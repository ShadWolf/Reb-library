REBOL [
AUTHORS: "Shadwolf (strike again)"
AppName: "RTE-line"
PURPOSE: {Apr�s m�re r�flection et comme R3 est toujours pas d'actualit� j'ai d�cid� de travailler
de mon cot� � la r�alisation d'une Widget pour rebol/view VID2.0 



Voici ce que je compte impl�menter

une ligne a un nombre de 80  charactere
On affiche la ligne dans une face toute simple et on utilisera face/effect/draw pour realiser l'affichage
On utilisera les events clavier et sourie pour inserer le texte. 
Le formatage du texte se fera pardes bouton externe et une ligne nous indiquera quel est le mode courant.

La saisie des evenements claviers renseignera un "objet" qui aura les donn�es suivantes:
position, char_ASCII, fnt_couleur
Le curseur se d�placera au clavier ou a l'aide de la sourie.

D�placements du curseur au clavier:
A partir de le position courant du curseur on ira chercher la position du caract�re le plus proche de cette position
ainsi le curseur se d�placera au bon endroit quelque soit la taille du caract�re pr�c�dent

D�placement du curseur � la sourie:
 quand on cliquera sur une position relative et dans notre table index�e (ou la position sert d'indexe) 
 la position la plus proche et on placera le curseur a cette position
 
La table serra tri�e par sort/all 

table de ash (enfin table des caract�res saisies index�e en fontion de leur position 

[  [0x0 "a"  red  bold 12]
   [0x5 "b" green underline 25]
   [0x30 "c" yellow normal 25]
]

Cette table sera trait� par un moteur de dessin draw/AGG 

On poura aussi y adjoindre un autre moteur pour les besoin de sauvegarde typ�e.. (MDP  etc...)

Insertion de nouveaux caract�res dans un texte deja existant:

 Lors de la saisie du nouveau caract�re on d�tecte si a la position actuelle du curseur il ya deja un caract�re
Si tel est le cas on parcours la liste et on applique une incr�mentation des valeur de position dans la liste a partir 
de la position trouv�e.
Comme chaque caract�re est g�r� de fa�on propre ca aura pour effet de d�caler tout le bloc

une autre impl�mentation possible ce serrait les objet li�s un peu dans le genre d'une liste chain�e de struct! en C
 comme c'est plus dificile a mettre en place je testerai ca dans une �volution

La hauteur de la ligne doit d�pendre de la taille du texte le plus haut. 
Le text plus petit doit etre dessendu en bas de la ligne.

La touche entr�e ne fait rien elle servira dans la version multiline.

A FAire:
- magentisation vers le bas de la widget du text de plus petite taille
- selection de text avec les actions correspondante
- Am�lioration globale du code.(virer les switch et trouver une bonne �quation pour calculer la taille des caract�res)
- Am�liorer la repr�sentation des donn�es en vue d'un traitement de plus grande donn�es.

NOUVEAU 27/01/2010:



OK on va tester les id�e propos�e par DIDEC qui mettent en oeuvre caret to offset
et une speudo face servant a faire les teste


Toute l'algorithmie de d�placement du faux curseur et de positionnement des �l�ment est a chang�e.

}

]

;test face for char size evaluation
font1: make face/font [size: 20 align: 'left valign: 'top offset: 0x0]
ff: make face [font: font1 size: 1000x1000 para: make face/para [origin: 0x0 margin: 0x0] edge: make face/edge [size: 0x0]]
		
stylize/master [


	
	rte: box with [
		; face ou l'on affiche les choses
		color: gray 
	    ascii-char-tab: make [] ; table  ou on stoquera tout ce que l'on va dessiner
	    
	    char-sz: 12
		font-st: none
		stored-curs-position: none
	  	current-text-offset: 5x0
	  	cursor-text-offset: 5x0
	  	max-text-offset: 0x0
	  	text-color: black
	  	tmp-ascii-char: none
	  	pane: []
	  	draw-text: none
	  	rm-char-sz: none
	  	found_existing_coord: false
	  	end-offset: none
	  	tmp: none tmp2: none
	  	f-name: none
	  	set-font-style: func [ font-s [word!] sz-tt [integer!] ] [
			if char-sz <> sz-tt [ 
				if char-sz < sz-tt [ 
					size/y: sz-tt + 15
					self/pane/1/size/y: size/y
					show self
				] 
				char-sz: sz-tt
			]
			font-st: font-s
			;insert tail buffer/:line-index compose/deep [[ [ space: 2x0 size: (char-sz) style: [(font-s)] color: (text-color)] (cursor-text-offset - 6x0) "" ]]
		]		
		feel: make feel [
			detect: func [f event] [
				;probe event/type
				;probe event/offset
				
				if event/type == 'down [
					if not empty? f/ascii-char-tab [
						f/tmp: event/offset - f/offset
						foreach item f/ascii-char-tab [
							if item/1/x < f/tmp/x [
								either item/1/x = first first last f/ascii-char-tab [
									f/stored-curs-position: item/1
									f/stored-curs-position/x: item/1/x + (( item/3  / 2) - 1)
								][
									f/stored-curs-position: item/1
									
								]
							]
						] 
						f/pane/1/offset: f/stored-curs-position 
						f/cursor-text-offset: f/stored-curs-position
						show f
					]
				]
				event	
			] 
			engage: func [f a e] [
				switch a [
					key [ 
						; probe e/key
						switch/default e/key [
							#"^M" [ ; touche entrer
							 ; pas impl�menter pour l'instant
							]
							#"^[" [ ;touche escape ne fait rien
							]
							right [ ;touche fleche droite 
								if not empty? f/ascii-char-tab [
									f/end-offset: first last f/ascii-char-tab
									foreach item f/ascii-char-tab [
										if  item/1/x  ==  f/end-offset/x [
						  					f/stored-curs-position: item/1 
						  					f/stored-curs-position/x: item/1/x + (( item/3  / 2) - 1)
							  				f/pane/1/offset: f/stored-curs-position 
						  	   				f/cursor-text-offset: f/stored-curs-position  
							  				break
							  			]
							  			if item/1/x > f/cursor-text-offset/x [
							  				f/stored-curs-position: item/1
							  				f/pane/1/offset: f/stored-curs-position
						  	   				f/cursor-text-offset: f/stored-curs-position
							  				break
							  			]
							  			
						  	   		]
					  	   		]
							]
							left [ ; touche fl�che gauche
								if not empty? f/ascii-char-tab [
									foreach  item f/ascii-char-tab [
							  			if item/1/x < f/cursor-text-offset/x [
							  				f/stored-curs-position: item/1
							  			]
						  	   		] 
						  	   		f/pane/1/offset: f/stored-curs-position
						  	   		f/cursor-text-offset: f/stored-curs-position
					  	   		]
							]
							down [ ; A FAIRE si on g�re les lignes multiples 
							]
							up [ ; A FAIRE si on g�re les lignes multiples
							]
							#"^~" [ ; touche suppr
							;A FAIRE
							;ajouter dans l'algo la prise en compte de la lettre courante dans le recalcul de
							;la position des lettre quand on les d�place
							; si la lettre est "fijlt" alors au lieu d'attribuer � la lettre suivante la position de la lettre courante 
								f/end-offset: first last f/ascii-char-tab 
								f/end-offset/x: f/end-offset/x + (((third last f/ascii-char-tab ) / 2 ) - 1) 
								f/tmp: none 
								f/tmp2: none
								if f/cursor-text-offset/x <> f/end-offset/x [
								; on supprime le char correspondant a la position actuelle du curseur
									f/tmp-ascii-char: copy []
									foreach item f/ascii-char-tab [
										either item/1/x <> f/cursor-text-offset/x [
											insert tail f/tmp-ascii-char reduce [ item ] 
										][
											f/tmp: item/1 ; on stock la position du char supprimer  pour s'en servir dans l'algo de d�calage
										]
									]
									f/ascii-char-tab: copy f/tmp-ascii-char 
									f/tmp-ascii-char: copy []
									; on d�place les caract�res apres la position du curseur en tennant compte de la taille du car suppr 
									; pour calculer le d�calage a appliquer 
									foreach item f/ascii-char-tab [
										if item/1/x >  f/cursor-text-offset/x [
											either f/tmp2 ==  none [ 
												either find "fijlt" item/2 [ 
													f/tmp2:  item/1 
													f/tmp2/x: f/tmp2/x - (( item/3 / 2 ) - 3) 
												][
													f/tmp2:  item/1
												]
												item/1/x: f/tmp/x
												f/tmp: none 
										 	][
										 		either find "fijlt" item/2 [
													f/tmp: item/1 
													f/tmp/x: f/tmp/x - (( item/3 / 2 )- 3) 
												][
													f/tmp: item/1	
												]
										 		item/1/x: f/tmp2/x
												f/tmp2: none 
									 		]
										]
									]	
									f/tmp: none
									;on redessine a l'�cran
									f/draw-text: copy []
									foreach char f/ascii-char-tab [
										font-obj: make face/font compose/deep [space: 2x0 size: (char/3) style: [(char/4)]  color: (char/5)]
										insert tail f/draw-text  compose [ font (font-obj) pen (font-obj/color) text (char/1) (char/2)]
									]
									f/effect: none								
									f/effect: make effect reduce [ 'draw (f/draw-text)  ]
									
								]
							]
							#"^H" [ ; touche backspace
							; parcourt le block de donn�es et on cherche la position 
							; la plus proche de la position actuelle du curseur
							
							
; OLD ALGORITHM !!

; 							if not empty? f/ascii-char-tab [
; 								f/tmp: first first f/ascii-char-tab
; 							] 
; 							if f/cursor-text-offset/x <> f/tmp/x [
; 								foreach  item f/ascii-char-tab [
; 							  			if item/1/x < f/cursor-text-offset/x [
; 							  				f/stored-curs-position: item/1
; 							  			]
; 						  	 ] 
; 						  	 f/tmp: none
; 						  	 f/tmp2: none
; 						  	 ;on supprime l'element dont la position correspond a 
; 						  	 f/tmp-ascii-char: copy []
; 							 foreach item f/ascii-char-tab [
; 									either item/1/x <> f/stored-curs-position/x [
; 										insert tail f/tmp-ascii-char reduce [ item  ]
; 									][ ;f/rm-char-sz: item/3 
; 										f/tmp: item/1
; 									]
; 									if item/1/x > f/stored-curs-position/x [
; 										either f/tmp2 == none [
; 											either find "fijltr" item/2 [ 
; 												f/tmp2:  item/1 
; 												f/tmp2/x: f/tmp2/x - (( item/3 / 2 ) - 3) 
; 											][
; 												f/tmp2:  item/1
; 											]
; 											item/1/x: f/tmp/x
; 											f/tmp: none 
; 										][ 
; 											either find "fijltr" item/2 [
; 												f/tmp: item/1 
; 												f/tmp/x: f/tmp/x - (( item/3 / 2 )- 3) 
; 											][
; 												f/tmp: item/1	
; 											]
; 											item/1/x: f/tmp2/x
; 											f/tmp2: none
; 										]
; 									]
; 						  	   	]
; 						  	   
; 						  	   f/ascii-char-tab: none
; 						  	   
; 						  	   f/ascii-char-tab: copy f/tmp-ascii-char
; 						  	  	f/tmp-ascii-char: none
; 						  	   
; 						  	   	; on d�place le curseur a la stored-position
; 						  	 	f/pane/1/offset: f/stored-curs-position
; 						  	 	f/cursor-text-offset: f/stored-curs-position
; 								; on redessine la ligne avec les nouvelle donn�es
; 						  	 	;on fabrique le block de donn�e draw
; 							  	f/draw-text: copy []
; 								foreach char f/ascii-char-tab [
; 									font-obj: make face/font compose/deep [space: 2x0 size: (char/3) style: [(char/4)]  color: (char/5) name: "font-serif" ]
; 									insert tail f/draw-text  compose [ font (font-obj) pen (font-obj/color) text (char/1) (char/2)]
; 								]
; 								;on dessine le contenu de  du block de donn�e draw
; 								f/effect: none								
; 
; 								f/effect: make effect reduce [ 'draw (f/draw-text)  ]
; 							]
						  	   ; code d'example pour transformer ascii-char-tab en table de hash ce qui facilite les 
						  	   ; modifications  
						  	   ;hash-tab: [] foreach i ascii-char-tab [ insert tail b reduce [ i/1 reduce [ i/2 i/3 i/4 i/5 ] ]  ]

						 ]
					][
							;si la position est deja pr�sente dans 	la liste alors ca veux dire que la position nouvelle
							; lettre que l'on va ins�rer dans la liste est d�j� prise.
							; il faut prendre en compte aussi la taille des lettres qui pr�c�de la position d'insertion
						 
							;/***
							;nouvel algo 
							comment {
							 	1) on recherche si la position courante du curseur est deja attribu�e a un element de la liste
							 	2) on calcule la taille en pixel de la nouvelle lettre. (face cach�e + sizetext)
							 	
							 	3) on insert le nouvel �l�ment dans la liste ainsi que sa taille dans la liste
							 	4) on decale tout les �l�mets suivant si besoin est enfonction de la taille du novelle �l�ment
							 	5) on cr�e le nouveau block draw
							 	6) on place le curseur juste apres la nouvelle lettre.
							 	 
							
							}
							;/****
							;calcule la taille en X de notre nouvelle lettre saisie
;							font1:  make face/font compose/deep [ size: (f/char-sz)  style: [(to-word f/font-st)] color: (f/text-color)  name: "font-serif" ] ; la font est adapter avec les informations dynamique courante evidement 
							font1/style: compose [ ( to-word f/font-st) ] 
							font1/size: f/char-sz
							font1/color: f/text-color font1/name: "font-serif"
							;probe font1
							char-sz-decalage: size-text fu: make ff [font: font1 text: e/key]
							;recherche si la position de du curser existe deja et si oui nous d�callons tout les �l�ments de la taille de notre nouvelle lettre
					 
						foreach item f/ascii-char-tab [
							if item/1 == f/cursor-text-offset [
 								f/found_existing_coord: true
 							] 
							if f/found_existing_coord [
								item/1/x: item/1/x + char-sz-decalage/x
							]	
						]
						f/found_existing_coord: false
						
						
						;on insert notre �l�ment dans ascii tab 
						ascii-char-item: compose [ (f/cursor-text-offset) (to-string e/key) (f/char-sz) (f/font-st) (f/text-color) (f/f-name) ]	
						f/draw-text: copy []
; 							
; 							; on insert ascii-char-item dans notre table; 							
						insert tail  f/ascii-char-tab reduce [(ascii-char-item)]
						 ;on fabrique le block de donn�e draw
; 							
 							foreach char f/ascii-char-tab [
 								font-obj: make face/font compose/deep [space: 0x0 size: (char/3) style: [(char/4)]  color: (char/5) name: (char/6) ]
 								insert tail f/draw-text  compose [ font (font-obj) pen (font-obj/color) text (char/1) (char/2)]
 							]
; 							;on dessine le contenu de  du block de donn�e draw
 							f/effect: none	
 							f/effect: make effect reduce [ 'draw (f/draw-text)  ]
; 							
; 							;probe f/effect
; 							; on d�place la position actuelle du curseur
							f/cursor-text-offset/x: f/cursor-text-offset/x + char-sz-decalage/x
							f/pane/1/offset: f/cursor-text-offset
							sort/all f/ascii-char-tab
						
; I LET THE PREVIOUS ALGORITHM TO SHOW YOU THE PROGRESSION
; IN MY THINKING WAY
							
; 							   foreach item  f/ascii-char-tab [
; 								if item/1 == f/cursor-text-offset [
; 									f/found_existing_coord: true
; 								] 
; 								if f/found_existing_coord [
; 									switch f/char-sz [
; 									 	12 [ 
; 									 		either find "fijltr" e/key [
; 												item/1/x: item/1/x + 2
; 											][
; 												either find "mw" e/key [
; 													item/1/x: item/1/x + 7
; 												][
; 													item/1/x:  item/1/x + 5
; 													]
; 											    ]
; 									 		]
; 									 	20 [
; 									 		either find "fijltr" e/key [
; 												item/1/x:  item/1/x + 5
; 											][
; 												either find "mw" e/key [
; 													item/1/x: item/1/x + 15
; 												][
; 													item/1/x: item/1/x + 12
; 													]
; 											    ]
; 									 		]
; 									 	30 [
; 									 		either find "fijltr" e/key [
; 												item/1/x: item/1/x + 11
; 											][
; 												either find "mw" e/key [
; 													item/1/x: item/1/x + 22
; 												][
; 													item/1/x: item/1/x + 20
; 													]
; 											    ]
; 									 		]
; 									
; 									]
; 									either find "MW"  e/key [
; 										item/1/x: item/1/x + 3
; 								
; 									][ 
; 										if find "ABCDEFGHIJKLNOPQRSTUVXYZ" e/key [
; 											item/1/x: item/1/x + 2
; 										]
; 									]
; 								]
; 								
; 							]
; 						    f/found_existing_coord: false
; 						   
; 							l-fnt-disp/text: rejoin [ to-string f/char-sz "," to-string f/font-st "," to-string f/text-color ]
; 							show l-fnt-disp
; 							; 
; 							ascii-char-item: compose [ (f/cursor-text-offset) (to-string e/key) (f/char-sz) (f/font-st) (f/text-color) ]
; 							;ascii-char-item a l'emplacement actuel du curseur, le char saisi, la taille de la fnt, 
; 							; le style de la font,la couleur de la font
; 							;
; 							f/draw-text: copy []
; 							
; 							; on insert ascii-char-item dans notre table
; 							insert tail  f/ascii-char-tab reduce [(ascii-char-item)]
; 							;on fabrique le block de donn�e draw
; 							
; 							foreach char f/ascii-char-tab [
; 								font-obj: make face/font compose/deep [space: 2x0 size: (char/3) style: [(char/4)]  color: (char/5)name: "font-serif" ]
; 								insert tail f/draw-text  compose [ font (font-obj) pen (font-obj/color) text (char/1) (char/2)]
; 							]
; 							;on dessine le contenu de  du block de donn�e draw
; 							f/effect: none	
; 							f/effect: make effect reduce [ 'draw (f/draw-text)  ]
; 							
; 							;probe f/effect
; 							; on d�place la position actuelle du curseur
; 							
; 							switch f/char-sz [
; 								12 [
; 									either find "fijltr" e/key [
; 										f/cursor-text-offset/x: f/cursor-text-offset/x + 2
; 									][
; 										either find "mw" e/key [
; 											f/cursor-text-offset/x: f/cursor-text-offset/x + 7
; 										][
; 											f/cursor-text-offset/x: f/cursor-text-offset/x + 5
; 										]
; 									]
; 								]
; 								20 [
; 									either find "fijltr" e/key [
; 										f/cursor-text-offset/x: f/cursor-text-offset/x + 5
; 									][
; 										either find "mw" e/key [
; 											f/cursor-text-offset/x: f/cursor-text-offset/x + 15
; 										][
; 											f/cursor-text-offset/x: f/cursor-text-offset/x + 12
; 										]
; 									]	
; 								]
; 								30 [
; 									either find "fijltr" e/key [
; 										f/cursor-text-offset/x: f/cursor-text-offset/x + 11
; 									][
; 										either find "mw" e/key [
; 											f/cursor-text-offset/x: f/cursor-text-offset/x + 22
; 										][
; 											f/cursor-text-offset/x: f/cursor-text-offset/x + 20
; 										]
; 									
; 									]
; 								]
; 							]
; 							either find "MW"  e/key [
; 								f/cursor-text-offset/x: f/cursor-text-offset/x + 3
; 								
; 							][ 
; 								if find "ABCDEFGHIJKLNOPQRSTUVXYZ" e/key [
; 									f/cursor-text-offset/x: f/cursor-text-offset/x + 2
; 								]
; 							]
; 							f/pane/1/offset: f/cursor-text-offset
; 							sort/all f/ascii-char-tab
 						]
						show f
					]
					down [
						;insert f/buffer compose [(as-pair 0 (line-index * 20)) ""]
						f/color: white show f focus f
					]
					
				]
			]
		]
		append init [
			; probe buffer
			set-font-style 'normal char-sz
			insert pane make face [ color: red size: 1x20 offset: cursor-text-offset  ]
			show self 
		]
	]
]

view layout [
  across
  	rotary "font-sans-serif" "font-serif" "font-fixed" [
  		test-rte/f-name: get to-word face/text
  	]
  	btn "bold" [test-rte/set-font-style 'bold (to-integer dd1/text)]
  	btn "underline" [test-rte/set-font-style 'underline (to-integer dd1/text)]
  	btn "italic" [test-rte/set-font-style 'italic (to-integer dd1/text)]
  	btn "normal" [test-rte/set-font-style 'normal (to-integer dd1/text)]
	dd1: drop-down "12" "20" "30" [test-rte/set-font-style test-rte/font-st (to-integer dd1/text) ]
	col-r: box 20x20 black edge [ siez: 2x2 color: black] [ test-rte/text-color: request-color col-r/color: test-rte/text-color show col-r test-rte/set-font-style test-rte/font-st  test-rte/char-sz  ]
  return
  	test-rte: rte 400x20
  return
    text black "Current font style: "
    l-fnt-disp: text black 200x20 ""
] 
do-events 