REBOL [
	Title: "ReKini"
	File: %rKini.r
	Authors: "Shadwolf(rkini.r), Oldes(irc client)"
	Date: 23/05/09
	Purpose: "IRC Client based on VID"
	Download: http://my-svn.assembla.com/svn/shadwolforge/
	Docstrack: { docs, source diff and time tracs available on
	http://my-trac.assembla.com/shadwolforge/
	}
]

VERSION: "0.1"
;---------
; ---- STYLIZED FACES -----
;--------

split-text: func [txt [string!] n [integer!]
	/local frag fraglet bl frag-rule bs ws
] [ws: charset [#" " #"^-" #"^/"]
	bs: complement ws
	bl: copy []
	frag-rule: [
		any ws
		copy frag [
			[1 n skip
				opt [copy fraglet some bs]
			]
			| to end skip
		]
		(all [fraglet join frag fraglet]
			insert tail bl frag
			; print frag
		)
	]
	parse/all txt [some frag-rule]
	bl
]

stylize/master [
	

	chat-box: box with [
		pane: []
		data: []
		chan-name: ""
		xy: 0x0	
		line-length: 0
		nb-lines: 0 ;nombre de ligne a affichée
		font-obj: make face/font [name: "lucida console" size: 14 style: none offset: 0x0]
		effect: [draw [pen none font font-obj line-width 1 translate xy]]
		insert-text: func [ msg col][
; graham idea on the matter 
			foreach frag split-text msg line-length [
; we remove as many entries at the head of data that we insert item in data
				if 500 = length? data [ remove/part data 1 ] 
; insertion of the new "line" with the corresponding color
				insert/only tail data compose [ (frag) (col) ]
			]
			; call render-text to draw the last X lines to the screen
			render-text 1
		]
		
		render-text: func [ inc /stay /local n dt max-line 
		line color test-face sub-line
		
		][
			;case [
			;   stay [] 
			;   0 < inc []
			;   0 > inc [] 
		;	]
			;probe data 
			;probe nb-lines
			;a: make face [ font: make face/font [name: "lucida console" size: 14 style: none offset: 0x0 ]]
		
			decal: 0x0
			clear effect/draw
			effect/draw: reduce ['pen none 'font (font-obj) 'line-width 1 'translate (xy)]
			max-lines: length? data ; on prend le fond du tampon
			either nb-lines < max-lines [ n: max-lines - nb-lines + 1 ][ n: 1]
			dt: head data
			;color: 255.255.255
			while  [ n <= max-lines] [
				;probe data/:n halt
				line: first data/:n
				color: second data/:n
				insert tail effect/draw 'push 	
				;if find line user-conf/nick [ color: 128.128.0 ]
				;a/text: line 
				;if size/x < first size-text a [ print "Shadwolf you need to cut that line !!"]
				insert/only tail effect/draw reduce [ 'pen (color) 'text (line) (decal) ]
				decal/y: decal/y + 20
				n: n + 1
			]
			show self 
		]
		append init [
			nb-lines: size/y / 20
			line-length: to integer! size/x / 8.5
		]
	]
	
	channel-list-box: box with [
; tree view that allows to swap betwin channels 
;content and server notice window
	
		;internal images used to draw the tree	
		root-img: load 64#{
Qk2OAAAAAAAAAD4AAAAoAAAADwAAABQAAAABAAEAAAAAAFAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAP///wD+/gAA/v4AAP7+AAD+/gAA/v4AAP7+AAD+/gAA/n4AAP1+
AAD9vgAA+74AAPveAAD33gAA9+4AAO/uAADv5gAA3/YAAMAGAAD//gAA//4AAA==
}
		root-img2: load 64#{
Qk2OAAAAAAAAAD4AAAAoAAAADwAAABQAAAABAAEAAAAAAFAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAP///wD//gAA//4AAP/+AAD//gAA//4AAP/+AAD//gAA//4AAOf+
AADp/gAA7n4AAO+eAADv5gAA7/oAAO/yAADvzgAA7z4AAOj+AADj/gAA//4AAA==
}
		leaf-img: load 64#{
Qk2OAAAAAAAAAD4AAAAoAAAADwAAABQAAAABAAEAAAAAAFAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAP///wD+/gAA//4AAP7+AAD+/gAA//4AAP7+AAD+/gAA//4AAP5I
AAD+/gAA//4AAP7+AAD+/gAA//4AAP7+AAD+/gAA//4AAP7+AAD+/gAA//4AAA==
}
		leaf-img2: load 64#{
Qk2OAAAAAAAAAD4AAAAoAAAADwAAABQAAAABAAEAAAAAAFAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAP///wD//gAA//4AAP/+AAD//gAA//4AAP/+AAD//gAA//4AAP5I
AAD+/gAA//4AAP7+AAD+/gAA//4AAP7+AAD+/gAA//4AAP7+AAD+/gAA//4AAA==
}
		data: []
		pane: []
		color: white
		expand-tree?: false
		sel-ind: 0 ;index to know what line is selected
		font-obj: make face/font [name: "lucida console" size: 14 style: none offset: 0x0]
		effect: [draw [ pen 0.0.0 font font-obj line-width 1 translate 0x0]]
		
		ins-entry: func [entry /leaf /local dt  ][
			;insert/tail data entry
			 either leaf [
		 		either 2 = length? data [
	 				dt: data/2 
	 				insert tail dt entry ; we insert a leaf
		 		][
; we create the sub block and we insert the first leaf
	 				insert/only tail data reduce [(entry)] 
		 		] 
			 ][ insert tail data entry ] ; we insert a root 
			render-tree
		]
		
		render-tree: func [/local n decal decal2 n2 ][
			decal2: 20x0
			decal: 0x0
			clear effect/draw
			effect/draw: reduce ['pen 0.0.0 'font (font-obj) 'line-width 1 'translate 0x0]
			n: 1
			foreach [ root leafs ] data [
				either expand-tree? [	
					insert tail effect/draw 'push 
					insert/only tail effect/draw reduce [ 'image root-img (decal) 'pen ( either n = sel-ind [ 0.150.0 ][ 0.0.0]) 'text 'anti-aliased (root) (decal2) ]
					decal/y: decal/y + 20
					decal2/y: decal2/y + 20
					n2: 1
					foreach leaf leafs [
						n: n + 1
						insert tail effect/draw 'push
						either n2 = length? leafs [
							insert/only tail effect/draw reduce [ 'image  leaf-img2 (decal) 'pen ( either n = sel-ind [ 0.150.0 ][ 0.0.0]) 'text 'anti-aliased (leaf) (decal2)  ]
						][
							insert/only tail effect/draw reduce [ 'image leaf-img (decal) 'pen ( either n = sel-ind [ 0.150.0 ][ 0.0.0]) 'text  'anti-aliased (leaf) (decal2) ]
						]
						decal/y: decal/y + 20 
						decal2/y: decal2/y + 20
						n2: n2 + 1
					]
				][
					insert tail effect/draw 'push 
					insert/only tail effect/draw reduce [ 'image  root-img2  (decal) 'pen ( either n = sel-ind [ 0.150.0 ][ 0.0.0]) 'text 'anti-aliased (root) (decal2) ]
				]
			]
			;probe effect/draw ;dbg purpose ...
			show self
		]
		feel: make feel [
		
			engage: func [f a e /local click-pos laylist-ind ] [
				switch a [
				   down [
						click-pos: e/offset
						either all [ 10 >=  click-pos/x 10 >= click-pos/y ][ ; expand / shrink the tree
				   			either f/expand-tree? [ f/expand-tree?: false ][f/expand-tree?: true]
			   				f/render-tree
				   		][
				   			if f/expand-tree? [
			   					laylist-ind: to-integer click-pos/y / 20
			   					laylist-ind: laylist-ind + 1
			   					f/sel-ind: laylist-ind ; store the index to higlight it on the rendering 
			   					if laylist-ind <= length? lay-list [
			   						f/render-tree
			   						handle-bx/pane: lay-list/:laylist-ind
			   						show handle-bx
								]							
				   			]
			   			]		
				   ]
			   ]
			] 
		]
		append init [
			
		]
	]	
	
]



;---------
; ----  IRC CLIENT FUNCTION -----
;--------

user-conf: make object! [
	nick: make string! 0
    pwd: make string! 0
	irc-url: "irc.rezosup.org"
	irc-port: "6667"
	joinchannel: make string! 0
	quit-msg: make string! 0
	away-msg: make string! 0
	part-msg: make string! 0
	memo-serv: "MemoServ"
	nick-serv: "NickServ"
	new-user: false ;  usage interne non sauvegarder dasn le ficheir de conf
	connecting-state: false ; false= offline true = online
	e-mail: make email! 0
]

ident-name: botuser: to-string rejoin ["rKini-" VERSION]
;channels: make block! 5
tchannel: make object! [
    name: none ; nom du channel 
    topic: none ; titre du channel 
    mode: none ; mode du channel
    users: make block! 10 ;list des utilisateurs 
    lay: none ; layout
]
l-channel: make block! 1

remove-colors?: either system/version/4 = 3 [true][false]
;it's not possible to see colors in the Windows console :(
escapechar: charset "^Q^C^A" ;there are probably more of them
normalchar: complement escapechar
digits: charset "0123456789"
space: charset [#" "]
non-space: complement space
to-space: [some non-space | end]
cprint?: true ; for normal printing :)
idents: none
debug?: false ; for debuging printing ...

params: prefix: nick: user: host: servername: none

; enlève les couleurs du texte
preptxt: func[txt /local tmp][
    if not remove-colors? [return txt]
    tmp: make string! 512
    parse/all txt [any [
          #"^Q"
        | #"^A" ;action
        | #"^C" some digits #"," some digits;on vire les couleurs ;)
        | copy t some normalchar (insert tail tmp t)
    ]]
    tmp
]
pad: func[txt c][head insert/dup tail txt " " c - length? txt]

;c la que l'on gère l'affichage des txt dans la console
cprint: func[msg /err /inf /local color lay][
    color: 0.0.0
    if block? msg [msg: rejoin msg]
    either err [color: 175.0.0 insert msg "!!! "][if inf [ color: 0.151.0 msg ]]
    console?: true
    ;]
   	either any [inf err ] [ 
   		lay-list/1/pane/2/insert-text msg color
	][
; locate the layout corresponding to the tchannel/name to display the message
		if 0 < length? lay-list[
			foreach lay lay-list [
				if find lay/pane/2/chan-name tchannel/name [
					lay/pane/2/insert-text msg color
					show handle-bx
					break
				]
				
			]
			
		] 
	]
]

dprint: func[msg][
    if debug? [
        ;if not empty? console/buffer [console/clear-line]
        print msg
        ;if not empty? console/buffer [prin console/buffer]
    ]
]

; bot-error: func[err /local type id arg1 arg2 arg3][
;     set [type id arg1 arg2 arg3] reduce [err/type err/id err/arg1 err/arg2 err/arg3]
;     cprint/err [
;         "Bot-" system/error/:type/type ": "
;         reduce bind system/error/:type/:id 'arg1
;     ]
;     cprint/err ["** Where: " mold err/where]
;     cprint/err ["** Near: " mold err/near]
; ]
; envoi des données vers le server
irc-port-send: func[msg [block! string!]][
    msg: either string? msg [msg][rejoin msg]
    dprint ["IRCOUT: " msg]
    insert irc-open-port msg
]

say: func[txt /to whom /action][
    if not to [whom: tchannel/name]
    if block? txt [txt: rejoin txt]
    txt: parse/all txt "^/" 
    forall txt [
        irc-port-send either action [
            ["PRIVMSG " whom " :^AACTION " txt/1  #"^A" ]
        ][
            ["PRIVMSG " whom " :" txt/1 ]
        ]
    ]
]
reply: func[txt /action /local whom][
    whom: either params/1 = user-conf/nick [nick][params/1]
    either action [say/action/to txt whom][say/to txt whom]
]

chat-rules: [
    ;add your own rules here:
    [thru "Rebol" to end][
    	reply/action "is a IRC client coded in REBOL langage" 
        reply "Check out http://www.rebol.com for Rebol related informations"
    ]
]

; chat-parser: func[msg /local err tmp][
;     foreach [rule action] chat-rules [
;         if parse/all msg rule [
;             if error? err: try [do action][ bot-error disarm err]
;         ]
;     ]
; ]

; this function is called by irc-parser when the msg JOIN is detected
joining-a-chan: func [chan-name /local lay ][
	insert tail lay-list layout  [
		origin 0x0 space 2x2 below
		;chan-name + topic #1
		text 600x25 black white chan-name font [size: 14 ]
	 	;chat-box #2
		 chat-box 600x400  white
	 	;send-line #3
	 	field 600x25 white 
		return
		;chan-user-list #4
		text-list 100x400
		key #"^M" [
			either 0 < length? face/parent-face/pane/3/text [
				textis: face/parent-face/pane/3/text 
				chanis: face/parent-face/pane/2/chan-name
				either #"/" = textis/1 [ 
					remove textis 1
					irc-port-send textis
				][
					face/parent-face/pane/2/insert-text rejoin [ user-conf/nick "-->" textis ] orange
					say/to textis chanis
				]
				unfocus face/parent-face/pane/3
				clear face/parent-face/pane/3/text
				show face/parent-face/pane/3
			
			][
				focus face/parent-face/pane/3 show face/parent-face/pane/3
			]
		] 	
	]

	lay: last lay-list
	lay/offset: 0x0 
	lay/pane/2/chan-name: tchannel/name ; store the channel name  used as index to locate the corresponding layout
	handle-bx/pane: lay
	show handle-bx 
]

irc-parser: func[msg /local tmp][ 
    params: make block! 10
    prefix: none
    parse/all msg [
        opt [#":"  copy prefix some non-space some space ]
        copy command some non-space
        any [
               some space #":" copy tmp to end (append params tmp)
             | some space copy tmp to-space (append params tmp)
        ]
    ]
    nick: user: host: servername: none
    if not none? prefix [
        either found? find prefix "@" [
            set [nick user host] parse prefix "!@" 
        ][  servername: copy prefix]
    ]
    dprint msg
    dprint reform ["PARSED: " mold prefix mold command mold params]
    switch/default command [
        "PING" [irc-port-send ["PONG " params]]
        "JOIN" [
            tchannel/name: copy first params
            cprint/inf either nick = user-conf/nick [
            	joining-a-chan tchannel/name
            	chan-lst/ins-entry/leaf tchannel/name
                ["You have joined channel " tchannel/name]
            ][
                insert tchannel/users nick
                [nick " (" user "@" host ") has joined channel " tchannel/name]
            ]
            tchannel/name: " "
        ]
        "PART" [
            tchannel/name: copy first params
            cprint/inf rejoin [nick " has left channel " params/1]
            tchannel/name: " "
        ]

        "PRIVMSG" [
           ; preparation tchannel/name
       	   		tchannel/name: copy first params
           		;probe tchannel/name        
            	cprint rejoin either find params/1 "#"  [
            	    either "^AACTION" = copy/part params/2 7 [
            	        ["["to string! now/time"]  " "* " nick skip params/2 7] 
            	    ][ 
            	    	["["to string! now/time"]" "<" nick  "> " params/2 ] 
            	    ] 
            	][ 
            		either find params/2 #"^A" [ 
            			either ctcp-cloack? [
            				[ "*** CTCP request attempt by " nick " blocked (CTCPCloak On)" ] red
            			][
            		; Algo emprunté a botnet de ZeKiller(kiki)
            		;REPONSE AUX REQUETTES CTCP  ajouté le 28/02/03
           				ctcpKW: handle-ctcp-req params/2
            			; on imprime le message sur la console
            			["*** CTCP(" ctcpKW ") - request by " nick]
            		   ]
            		][  ["*" nick "* " params/2 ] ] 
            	] 
            	; handler-service-msg nick params/2 ; traitement des msg service
            	; chat-parser params/2 ; traitement des mg des channels..	   
            	tchannel/name: " "      
        ]
        "NOTICE" [
            either none? nick [cprint/inf params/2][
                cprint/inf either #"#" = params/1/1 [
                    	["-" nick ":" params/1 "- " params/2]
                  ][
                  		["-" nick "- " params/2]
                  ]
            ]
           ; handler-service-msg nick params/2; nick message a passer en vu du declenchement d'une action :)   
        ]
        "MODE" [
        	if find params "+r" [ identified?: true]; quand le nick est enregistrer :)
            cprint/inf [
            	{Mode change "} next params {" }
                either params/1/1 = #"#" ["on channel "]["for user "] params/1 { by } nick
                
            ]
            if tchannel/name = params/1 [tchannel/mode: copy next params]
        ]
        "NICK" [
            cprint/inf either nick = user-conf/nick [
               user-conf/nick: copy params/1 
                ["You are now known as " params/1]
            ] [[nick " is now known as " params/1]]
        ] 
        "QUIT" [
            cprint/inf [
                "Signoff: " nick " (" user ") "
                either find/part params/1 "WinSock error" 13 [params/2][""]
            ]
            error? try [remove find tchannel/users nick]
        ]
        "INVITE" [
            cprint/inf [nick " invites you to channel " last params]
        ]
        "TOPIC" [
            tchannel/name: copy first params
            cprint either nick = user-conf/nick [
                ["You have changed the topic on channel " params/1 " to " params/2]
            ][  [nick " has changed the topic on channel " params/1 " to " params/2] ]
        	tchannel/name: " "
        ]
        "KICK" [
            cprint/inf [
                either user-conf/nick = params/2 ["You have"][rejoin [params/2 " has"]]
                " been kicked off channel " params/1 " by " nick " (" params/3 ")"
            ]
        ]
        ;errors:
        "401" [cprint/err [ params/2 " - " params/3]] ;ERR_NOSUCHNICK
        "402" [cprint/err [ params/2 " - " params/3]] ;ERR_NOSUCHSERVER
        "403" [cprint/err [ params/2 " - " params/3]] ;ERR_NOSUCHCHANNEL
        "404" [cprint/err [ params/2 " - " params/3]] ;ERR_CANNOTSENDTOCHAN
        "405" [cprint/err [ params/2 " - " params/3]] ;ERR_TOOMANYCHANNELS
        "406" [cprint/err [ params/2 " - " params/3]] ;ERR_WASNOSUCHNICK
        "407" [cprint/err [ params/2 " - " params/3]] ;ERR_TOOMANYTARGETS
        "409" [cprint/err [ params/2]] ;ERR_NOORIGIN
        "411" [cprint/err [ params/2]] ;ERR_NORECIPIENT
        "412" [cprint/err [ params/2]] ;ERR_NOTEXTTOSEND
        "413" [cprint/err [ params/2 " - " params/3]] ;ERR_NOTOPLEVEL
        "414" [cprint/err [ params/2 " - " params/3]] ;ERR_WILDTOPLEVEL
        "421" [cprint/err [ params/2 " - " params/3]] ;ERR_UNKNOWNCOMMAND
        "422" [cprint/err [ params/2]] ;ERR_NOMOTD
        "423" [cprint/err [ params/2 " - " params/3]] ;ERR_NOADMININFO
        "424" [cprint/err [ params/2]] ;ERR_FILEERROR
        "431" [cprint/err [ params/2]] ;ERR_NONICKNAMEGIVEN
        "432" [cprint/err [ params/2 " - " params/3]] ;ERR_ERRONEUSNICKNAME
        "433" [cprint/err [ params/1 " - " params/2]] ;ERR_NICKNAMEINUSE
        "436" [cprint/err [ params/2 " - " params/3]] ;ERR_NICKCOLLISION
        "441" [cprint/err [ params/2 " " params/3 " - " params/4]] ;ERR_USERNOTINCHANNEL
        "442" [cprint/err [ params/2 " - " params/3]] ;ERR_NOTONCHANNEL
        "443" [cprint/err [ params/2 " " params/3 " - " params/4]] ;ERR_USERONCHANNEL
        "444" [cprint/err [ params/2 " - " params/3]] ;ERR_NOLOGIN
        "445" [cprint/err [ params/2]] ;ERR_SUMMONDISABLED
        "446" [cprint/err [ params/2]] ;ERR_USERSDISABLED
        "451" [cprint/err [ params/2]] ;ERR_NOTREGISTERED
        "461" [cprint/err [ params/2 " - " params/3]] ;ERR_NEEDMOREPARAMS
        "462" [cprint/err [ params/2]] ;ERR_ALREADYREGISTRED
        "463" [cprint/err [ params/2]] ;ERR_NOPERMFORHOST
        "464" [cprint/err [ params/2]] ;ERR_PASSWDMISMATCH
        "465" [cprint/err [ params/2]] ;ERR_YOUREBANNEDCREEP
        "467" [cprint/err [ params/2 " - " params/3]] ;ERR_KEYSET
        "471" [cprint/err [ params/2 " - " params/3]] ;ERR_CHANNELISFULL
        "472" [cprint/err [ params/2 " - " params/3]] ;ERR_UNKNOWNMODE
        "473" [cprint/err [ params/2 " - " params/3]] ;ERR_INVITEONLYCHAN
        "474" [cprint/err [ params/2 " - " params/3]] ;ERR_BANNEDFROMCHAN
        "475" [cprint/err [ params/2 " - " params/3]] ;ERR_BADCHANNELKEY
        "481" [cprint/err [ params/2]] ;ERR_NOPRIVILEGES
        "482" [cprint/err [ params/2 " - " params/3]] ;ERR_CHANOPRIVSNEEDED
        "483" [cprint/err [ params/2]] ;ERR_CANTKILLSERVER
        "491" [cprint/err [ params/2]] ;ERR_NOOPERHOST
        "501" [cprint/err [ params/2]] ;ERR_UMODEUNKNOWNFLAG
        "502" [cprint/err [ params/2]] ;ERR_USERSDONTMATCH
        "999" [cprint/err [ params/2]] ;ERR_COMMNOTFOUND
        ;Command responses:
        "300" [];RPL_NONE
        "204" [cprint/inf ["Oper [" params/3 "] ==> " params/4]];RPL_TRACEOPERATOR
        "211" [cprint/inf next params];RPL_STATSLINKINFO
        "212" [cprint/inf next params];RPL_STATSCOMMANDS
        "213" [cprint/inf next params];RPL_STATSCLINE
        "214" [cprint/inf next params];RPL_STATSNLINE
        "215" [cprint/inf next params];RPL_STATSILINE
        "216" [cprint/inf next params];RPL_STATSKLINE
        "218" [cprint/inf next params];RPL_STATSYLINE
        "219" [];RPL_ENDOFSTATS
        "221" [cprint/inf next params];RPL_UMODEIS
        "205" [cprint/inf ["User [" params/3 "] ==>"]];RPL_TRACEUSER
        "242" [cprint/inf next params];RPL_STATSUPTIME
        "243" [cprint/inf next params];RPL_STATSOLINE
        "244" [cprint/inf next params];RPL_STATSHLINE
        "250" [cprint/inf params/2] ;RPL_STATSDLINE
        "251" [cprint/inf params/2 irc-port-send ["JOIN " user-conf/joinchannel] ];RPL_LUSERCLIENT
        "252" [cprint/inf [params/2 " " params/3]] ;RPL_LUSEROP 
        "253" [cprint/inf [params/2 " " params/3]] ;RPL_LUSERUNKNOWN
        "254" [cprint/inf [params/2 " " params/3]] ;RPL_LUSERCHANNELS
        "255" [cprint/inf params/2] ;RPL_LUSERME
        "256" [cprint/inf [params/2 " - " params/3]] ;RPL_ADMINME
        "257" [cprint/inf params/2] ;RPL_ADMINLOC1
        "258" [cprint/inf params/2] ;RPL_ADMINLOC2
        "259" [cprint/inf params/2] ;RPL_ADMINEMAIL
        "301" [cprint/inf [params/2 " is away (" params/3 ")"]];RPL_AWAY
        "303" [cprint/inf either 1 < length? params ["Currently online: " next params]["Nobody is online"]];RPL_ISON
        "305" [cprint/inf reform next params]
        "306" [cprint/inf reform next params]
        "311" [cprint/inf [params/2 " is " params/3 "@" params/4 " (" last params ")"]];RPL_WHOISUSER
        "312" [cprint/inf ["on irc via server " params/3 " (" params/4 ")"]];RPL_WHOISSERVER
        "313" [cprint/inf [params/2 " is " params/3]];RPL_WHOISOPERATOR
        "315" [update-state params/2 ];RPL_ENDOFWHO
        "317" [;use [t][
            ;t: to-time params/3
            cprint/inf [params/2 " has been idle: " to-time to-integer params/3]
            cprint/inf [params/2 " is online since: " 1-1-1970/0:0:0 + to-time to-integer params/4]
        ];];RPL_WHOISIDLE
        "318" [];RPL_ENDOFWHOIS
        "319" [cprint/inf rejoin ["on channels: " mold parse last params ""]] ;RPL_WHOISCHANNELS

        "321" [cprint/inf "Channel    Users  Topic" ];RPL_LISTSTART
        "322" [cprint/inf [pad params/2 11 pad params/3 7 params/4]];RPL_LIST
        "323" [];RPL_LISTEND
        "331" [cprint/inf reform next params];RPL_NOTOPIC
        "332" [tchannel/name: copy second params 
        cprint/inf ["Topic for " params/2 ": " params/3]
        		;locate layout corresponding in the lay-list
        		foreach lay lay-list [
    				if find lay/pane/2/chan-name tchannel/name [
						lay/pane/1/text: params/3 show lay/pane/1
						break
    				] 
        		]
        tchannel/name: " "
        	  ];RPL_TOPIC
        "341" [cprint/inf ["Inviting " params/2 " to channel " params/3]];RPL_INVITING
        "351" [cprint/inf ["Server " params/3 ": " params/2 " " params/4]];RPL_VERSION
        "352" [cprint/inf [
            pad params/2 11
            pad params/3 10
            pad params/7 4
            params/6 "@" params/4
            " (" find/tail params/8 " " ")"
        ]];RPL_WHOREPLY
        "353" [ ; USER_LIST
            ;params/4: sort parse params/4 ""
            ;if tchannel/name = params/3 [tchannel/users: copy params/4]
;print in the server window... not needed i think ...
            ;cprint/inf ["Users at " pad params/3 10 mold params/4]
            ;locate in lay-list the good item 
            foreach lay lay-list [
				if find lay/pane/2/chan-name params/3 [
					tmp: parse params/4 " "
					foreach  user tmp [ 
; once we have the good layout  we build the user list in it and show it
        				insert tail lay/pane/4/data user
            		]
           			 show lay/pane/4
           			 break
        		] 
        	]
            ;liste de sutilistaeur d'un channel affichée dans la fenetre de dial correspondante.
            ; chan_user_lst/data: mold copy  params/4
            ;show chan_user_lst
        ]
        "366" [];RPL_ENDOFNAMES
        "375" [cprint/inf params/2] ;RPL_MOTDSTART
        "372" [cprint/inf reform next params] ;RPL_MOTD
        "376" [];RPL_ENDOFMOTD
        
        "371" [cprint/inf params/2] ;RPL_INFO
        "374" [];RPL_ENDOFINFO
        "381" [cprint/inf last params];RPL_YOUREOPER
        "391" [cprint/inf ["Server (" params/2 ") time: " params/3]]
        
        "392" [cprint/inf params/2];RPL_USERSSTART
        "393" [cprint/inf params/2];RPL_USERS
        "394" [];RPL_ENDOFUSERS
        ;Other responses:
        "001" [cprint/inf params/2 error? try [close idents] ]
        "002" [cprint/inf params/2]
        "003" [cprint/inf params/2]
        "004" [cprint/inf reform next params]
    ][
        if 0 < length? lay-list [ cprint/inf msg ]
    ]
]
; lecture des données provennant du socket IRC
getirc-port-data: does [
    either error? getirc-port-data-error: try [irc-input-buffer: copy/part irc-open-port 1] [
        getirc-port-data-error: disarm getirc-port-data-error
        error-proc getirc-port-data-error
        print "Error Generated at GETIRC-PORT-DATA function!"
        return ""
    ][
        if type? irc-input-buffer = block! [irc-input-buffer: to-string irc-input-buffer]
        if irc-input-buffer = "none" [
            ;disconnected
            cprint "Connection to IRC closed"
            close irc-open-port
            identified?: false 
        ]
    ]
    return irc-input-buffer
]


;focntion de traitement des requettes CTCP
handle-ctcp-req: func [ctcp-req]
[
 days: ["Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday" "Sunday"]	
 parse next find ctcp-req #"^A" [copy ctcpcmd to #"^A"]
 ctcpcmd: parse ctcpcmd none
;CTCP - PING
  switch (first ctcpcmd) [
  	"PING" [
		irc-port-send [ "NOTICE " nick " :" #"^A" ctcpcmd #"^A"#"^M"  ]
  	]
;CTCP TIME
  	"TIME"[
    	irc-port-send [ "NOTICE " nick " :^ATIME " (first skip days (now/weekday - 1)) ", " now/date " " now/time "^A"#"^M" ]
  	]
;CTCP - VERSION
  	"VERSION" [
    	irc-port-send [ "NOTICE " nick " :^AVERSION rKini (" Version ") [htpp://kini.rezosup.net]^A"#"^M" ]
    "CLIENTINFO" [
      	irc-send ["NOTICE " nick " :^ACLIENTINFO VERSION TIME PING CLIENTINFO ^A"#"^M" ]
    ]	
]] return first ctcpcmd]
;fonction d'ouverture de la session cliente
handshake:  does [
    irc-port-send ["NICK " user-conf/nick] cprint/inf ["User is sending " user-conf/nick]
    irc-port-send ["USER " "KiniUser" " " system/network/host-address " ircserv :" "KINI-REBOL"]
    cprint/inf "Kini is sending USER data"
    connected: true
    ;irc-port-send ["JOIN " joinchannel] cprint ["Bot is joining " joinchannel]
]
; ;serv identd
; start-ident: does [
;     cprint/inf "IDENT SERVER IS LISTENING ON PORT TCP:113"
;     idents: open/direct/lines tcp://:113
; ] 

irc-open-port: none

connect-to-irc: func [host /port p /local tmp-buf]
[
	cprint/inf rejoin ["opening IRC connection to %% " host " %%" ]
	;start-ident  ;ouverture du port d'identd  
	irc-open-port: open/lines/direct/no-wait  to-url rejoin [ "tcp://" host ":" p ]
	tmp-buf: make string! 0
	handshake ; overture de session IRC
	
	forever [
        ready: wait/all waitports: [irc-open-port 120 ] ;idents]
        if ready [
            foreach port ready [
            	wait 0.01
            	;ajouter la recuération des données depuis les différentes interfaces de dilaogue 
                ;if port = idents [
                ;    cprint/inf rejoin [ host " has make an IDENT request!!!!" ]
                 ;   ident-connection: first idents
                ;    ident-buffer: first ident-connection
                 ;   if find/any reform ident-buffer "* , *" [
                ;        insert ident-connection rejoin [ident-buffer " : USERID : REBOL : " ident-name]
                ;    ]
                ;]
            	
            	if port = irc-open-port [
                	tmp-buf: getirc-port-data
                	if  tmp-buf = "none" [
						break
               		]
                	irc-parser tmp-buf 
                ]
                
            ]
        ]
    ]
]


;---------
; ---- GUI INTERFACE -----
;--------

; callback function to connect 
login-serv: func [ nick chan blk /local p serv tmp ] [
	either all [ 
	 0 < length? nick 
	 0 < length? blk
	 0 < length? chan	
	][
	unview/only serv-list-win
	user-conf/nick: nick
	if not #"#" = chan/1 [ insert chan "#" ]
	user-conf/joinchannel: chan 
	tmp: parse first blk ":"
    serv: first tmp
	p: second tmp
	chan-lst/ins-entry serv 
	; create the new layout and we store it in the layout list
	lay-list: []
	insert tail lay-list layout [ 
	origin 0x0 space 2x2 below
	 ;topic #1
	 text 700x25 black white font [size: 14 ]
	 ;chat-box #2
	 chat-box 700x400  white
	 ;send-line #3
	 field 700x25 white
	; return
	 ;chan-user-list #4
	; text-list 100x400
	] 

; 	insert tail lay-list face [ pane: [ 
; 		text [size: 600x25 colors: [black white] font: [size: 14]  offset: 0x0]
; 		chat-box [ size: 700x400 color: white offset: 0x25]
; 		field [size: 600x25 offset: 0x425]	
; 	]]
	; we set the new layout store in the layout list to the handle-bx/pane
	lay-list/1/offset: 0x0
	handle-bx/pane: lay-list/1
	show handle-bx
	;we connect to irc serv 
	connect-to-irc/port serv p 
	][
		alert "Fill the fields and choose and server !"
	]
]

serv-list-win: layout [
    origin 2x2  space 2x2
	across 
	text "Nickname:" nick-fd: field 100 return
	text "Channel:" chan-fd: field 130 return
	below
	text "Choose an IRC server"
	cnx-tl: text-list data ["www.compkarori.co.nz:6667"]
	return
	btn "Connect" [ login-serv nick-fd/text chan-fd/text cnx-tl/picked  ]
	btn "Close" [ unview/only serv-list-win  ]
]



jchan-cb: func [ text /local ][
	if 0 < length? text [
		if not #"#" = text/1 [ insert text "#" ]
		irc-port-send rejoin [ "JOIN "  text ]
	] 
]

j-chanwin: layout [
	origin 2x2 space 3x2	
	across 
	text "Channel name:"
	return
	field  100
    return
	btn "Join" [ jchan-cb face/parent-face/pane/2/text unview/only j-chanwin ]
	btn "Cancel" [unview/only j-chanwin] 
]

;callback function main window

; send-mesg: func [text][
; 	either text/1 = #"/" [ 
; 		remove text 1
; 		irc-port-send text
; 	][
; 		chat-bx/insert-text rejoin [ user-conf/nick "-->" text ] orange
; 		say/to text user-conf/joinchannel
; 	]
; ]

; config-win: layout [
; 	style t80 text 80
; 	style f150 field 150
; 	style bt50 btn 50
; 	across
; 	h4 "User informations"
; 	return
; 	t80 "Nickname:" f150  
; 	return
;     t80 "2nd Nick:" f150
;     return 
;     t80 "3rd Nick" f150
;     return
; 	h4 "Networks"
; 	return
; 	text-list 200 data [ "www.compkarori.co.nz:6667"  ]
;     return
;     btn "Close" [ unview/only config-win ] 
;     btn "Connect" []
;    	below at 225x170
;     bt50 "Add" []
; 	bt50 "Remove" []
; 	bt50 "Edit..." []
; 	bt50 "Sort" []
; ]

main-win: layout [
origin 2x2 
space 2x2
	across
	;connect
	btn "Log In" [ view/new serv-list-win ]
	btn "Log Out" [ if not none? irc-open-port [ if request "Really Log out ?" [irc-port-send "QUIT Byebye" ] ] ]
	tab
	btn "Join"  [ view/new j-chanwin ]
	tab 
	btn "Quit" [ if request "Really quit ?" [if not none? irc-open-port [ irc-port-send "QUIT Byebye" wait 1 ] quit]]
	return
	;topic-v: text 600x25 black white font [size: 14 ]
	return 
	chan-lst: channel-list-box 150x450
	; box to display the irc messages
	handle-bx: box 700x450

] 


;---------
; ---- Software Start -----
;--------
view/new main-win
do-events
; unless exists? %./user-cnf.dat[
; view/new config-win 
; do-events][ ]