REBOL [	
	TITLE: "Enhanced area"
	auteurs: "Shadwolf, Steeve"
	start-date: 07/04/2009
	release-date: 22/04/2009
	credits: { Carl sassenrath, Steeve, Maxim, Coccinelle, Cyphre (AGG guru ^^)}
	purpose: { construct a new style "area-tc",
	with rendering dynamic colorized text using draw/agg}
	Download: http://my-svn.assembla.com/svn/shadwolforge/
	Docstrack: { docs, source diff and time tracs available on
	http://my-trac.assembla.com/shadwolforge/
	}
]
;print ""

; utility functions

sav-pref: func [][
	;consol_path: fi/text
	pref/bg_color: b1/color
	pref/txt_color: b2/color
	save %pref.dat pref
]

load-pref: func [][
	if exists? %pref.dat [pref: do load %pref.dat]
]

either  exists? %pref.dat [
	load-pref
][
	pref: make object! [
		;consol_path: copy system/options/boot
		bg_color: 255.255.255
		txt_color: 0.0.0
	]
]
; LOAD MENU WIDGET Cyphre(TM)
do load decompress #{
789CB51B6B73DAB8F67B7E85BA3B770237430CE4D12EDD6EC6109A92266D499A
B629E3CE1810C6606C6A9BE074BBFFFD9E23C9B66CCB84A477C384C8B2747474
5E3A0FE5EF5118D516D45DB5C8C29C53E20D6774143E23839D6F357B615A3468
119F8E5723CABABED55EE260329C5B646D875342C71665FD8E678EC9F1E1EF7F
DB9FDAEFAFD6F5B76796A7C3CFBBEB9B69F7C68256BB87CFD71DFD161F3EFFF0
8EBE6047FB6CDCFE78D3D5F58BB3F7930FE1D5CE7C0DBD9DF6ECFAF5F93B787D
7CDED775AB77A9EB1F5C0D5EE8C7F07AFC11BEDE2F11ECB103E35F37F7BE7CFF
EADE20C09DE6DCE9F63F5D1DBA67172F34ED85A6FFB8D1FB7A27B27A33FFD38B
BDABAFE7DF17E1B43B5B4DA7B06AD7BABE3A773AEFDAD7FE7BC07074D5DDB1E7
776BC4D25B2EDB00BBFBEE1656F7ACC08AACAF67572BBDD9A6BDC6E7B6ADEB6F
BAD6FCC5E91B5B3F8F2EBFF6FBD142BFA6D6E71D58EDEAF8C7CDF2EB25ECA0D3
D1DFBEE95E754EEFDF74FA7AB7FBEEA67376DFD1BF9FDDF6FBFA69FBEEF6D68F
AE7A17BADEEB0DDB9DE69DFEFEEDCE17EB6BEFB6F7767D7EEE0125EF69AF1FE8
EDB61E5993FAE5349AF5828B4B86E17A31E97FBC9E863F7AFACDFBFACCBA38EF
996DA0FBCE6D70F5E58D7DE67EE94CFBFDD7A3D3C6C58B8B2BFDB2DB7D7D7C7A
AD03B5FBB7FAC5DC72BF1EDE6B07EDBECE5873F3E9FDD5DBA3CE6DAFF7EA1F89
D9A3291DCD413CFCF9969CD6D9578F73FAB47BFAFCF8E2DFE1F44D3DE6F4F97C
4FDFEBAE7AB0F41A609DBE99CED7FDB6A5B7EDFECAB4AE0F7B20017A74DBB7EC
B707CF3F009C7EFFEDF4F38ED75D74901A97D7AF7FD43B9FDAC8ACB3CBCE9ED5
EDB65FB70F6F75ABDFEF358EEE74EB3540EEEA7BF3E0CB878F079ED6EE3292ED
E46966C06F10DE3BF60FAA2DCC20A4BED01BAE6313131489290EEFFD561B798E
E7B788EBB954F44C3C3714DA88CD64643276E898A379D2E94D26018509F5A89E
F4055373ECAD33500DF117155640C7A6043D009C5BA41135F2EB359E37F71BC7
2FF61B4707DF6A39706BCF1F838948A18CCDD0240397AE356CC18E6D3F08894B
A39098BE15A42D2399623ACBA92981F856C3E9ACB7305F1A04066A42827BA0F1
421BAE6C678C2B52F22769366AE7A65B6BD6EB8719A839C8CDA323522324E9C9
8C34A4A70C62793C8C1C41BC498617410838B5083029E5376C8A711824A236C9
304960164F9E50EAC492004D69333EE5DC9AACDC11190019E069CF90374B41C8
40F896A6ED9F90898603C84034B4A895B4C81E9F0C2D79CFF1D078603C4C1E13
4CBD35991428912388EDDA612B2BC42D62BAF764C0C48B6D3F850A2C75BD90F0
57032180CD83E3FDE6C1C17EB3719C8E5C9A2E6037F2960029ED659445B5497B
3C9F9A2350389B0C0DC2C553DA84ED06D40F4968DA0E419082DCE688E6642704
D6B7889DE9E3CA243130A337857E3835F93BE9503DFC63BF513FDE6FFCF13C47
098EBB1B1666ACA73688393302C5D1B1B8A0DD301DDB725B64D7A193303B7269
FAA618894D80E99BCB13344F4E003E806F5B364C6C46F5EC342E1087D1214883
45C35AC84408D7B271C5CCD8D82C813E64FAB9551812FCC9625F2AEC02E01DF5
5381378967E44730E9311D986A82D4C2C628500F39A9312DCCF571F55300E1B6
5A0315A321CC4184156354C0346F19DA9E1B2858BF6152B85872ABA10629E858
59DBAE202AE873153850A9470DF25FA19F553065F5E870DB353927033AF2DC31
0940EE4FD4AB732563D695D9AB7887822E894CEE7285CDC2803EB28BD231D1D8
41B6CB0D7D7610EB33B6C55B9C29654CE1164931B130B6B8E244136ABBB4C1DB
9968A9B292E2527C47B91992B62AA6E4ACA51A0DEA5AA6456531A70A090DC083
008B661674842998B776952FF2241547139A5BC50B0500159756CB92B5401555
3AA81E0C16C99BE715945963DB1DD3088413FEAA5E8324536722AC066F0F5468
E2671BAD8E1905F82C574B0D740EC8A9996BF35E2956ADD2D342FE240AFECBBA
2C84447DEAC89FB2132823289B7549880C3B53F2C63D4356738426A1852702B0
2B4B27D079F6B67476A981798C7979BC71119C2E5A41C4A7743CC8346C50B89C
77365D935D90135CA9A63CB232847CE078933F78368E1C2FA0357A077B41FF9A
3D96EF84CF015FC61ED393C47C2003180483B75FF1270D1F1E82B5F4BD110D82
9AB70A1128C74405F90138F8B3721D00C59578B080839C84F68212148D3B5471
D198D37BC2AC5730F23DC7A93936F84302E5F07E097230454C986A3E843EFEB0
990F8C7B900CDEB236A6211D852DE0E153362F1C71C11B92CE7E5004721018F9
64B128210DF723C980A3B8C51AC6D698288542DAD2368BFD0243CADF95BD3118
D56ADC8E174EDFF8B336EDB0FCDC509E9ACC53564E508129F6E57BB2CFF293DC
16A74888274623AAC3895129F1C6C12456AB85D0EC5BEDE543364F0C38AED7A3
669A504093A5F1A093B0539687E5B17DE6FD6C621232C47F172B27B485E5636D
49DA26B643333665E8CC334A0516973957D04F1A393165ECE087184B49719460
A4927859B40C96AA81AF8470311AEC7510FAECAF961E7C136F38C3497C804FC3
95EFB22DB3C050E107A003844A9E49E70C672067312A22E152879F887D8B7E1E
69C638705459582D7248299ECC0B49CEEFF8EC640F041E44EF24CE56404BF42D
CD702A3A97A2C55D23DE74BC91E9B0E65D92E0F55760C4590BED329F0381E842
38D7E355DC0A5643DE630727AC319ACE79C35E58ECEFD0F44547B8607FC1F2B3
BF3402591CF377AE07E6920F172C8D43C9241309188340C95CC1E76C5200D8C0
3616B305741942DC847004B605C76BE0C1793440C0102F7B2EA960536BE0C304
1CB49F04BD4614C2219066FE8C543818EC010055783FB79706093D42DD315F98
E076EC30E16192DB40DA275282BB0CB2181B29E15BE4203A48C99BA65114C1F0
D843E72476C2B82E9818976C769D779937B28B001F31CBC41457925254052DBF
860E07F92884A84C3D2E982AF7BCE03C6F4CC0629E2A3172D4013700F52A753B
8DE4D478446E67DBAC4E2E7768A4CA9718F0ACDDFFEDF237C277AE2529B08CD0
81AEC7B2561766881D29A9962BD4834AF95DAE278951455A0C7641D1CDA14349
0535BE45427F45AB06A3D380E5F976E1B4421B205E8136EDD6E21E768E560D31
1CB50C8C0419B0D2D33318892704FE45FC9FC5C376C180900A5A91643536335C
A0D5B45DEB191FF73BEB46B75274C7F3C144910A33300900AEFB0916C21211BE
6134093F992D90314DED81412AD2A1C3625926B43CAB08946F908A8864719DAA
34384E59A1809C24CBB22E84CF90348C814853E26C8E471604235AE674147C67
843C89896A89A3125A598783BD0A3D5EF293B5466887E553EA92547738DC1683
4B2713748F4129C08B4A8A08E09B3051355E368E23396F9BF568004D9040ED1E
629383FC0EA4CC2CB7EC04F896D169F2127A588D0A9F732E15FAC580557C1CC9
9B15B86379536BBC64E2CEAB214390217349FE634D2216E2EF2F5D2B373BDEEE
C85B2CC117073F3B0AC1E813166B8283432A65468347A8CDA323A3CA13DCE835
958E96B2E3D5BCB7581EDE97E606D4E97289090119A439DB20DCCE218599A886
1B3807E4D7F27975C2EB8A63EAD80BB057BE9A710058BD6DA91EB5EDEE13574B
AA6E091396E6A9C18F06A7B774DF19F73B9F9FE1C6281F156448554A146EB213
B2E06306B6A047B19F5724C2450E4975E2DDF73CF42A73DA90398B44A089669C
0C061299659283319226955720BC7C098208F649B3B5E653EA12982B83238599
1730331008E51444442251B31819C11191A90E31A9111A1D47EA92C92C0820D3
796D4CE9920CC6BEB9164715BA4360E2175695D4F741C3F7EB464E81F2A0C462
780A2AC2EF0C6C0CF184B16A9680572C80BE65410FCAB51A04741C0903B14C82
03C1D6C79666088F20C88C848B25FE7AF815E0976D902C150B68C3A0B2F89A1F
6A35FA7D653A2719416AC822AACC673C2ABFFFA40C7F31CA57E6FCE532154FBE
A36A663CDB3809FA0A5E025BD4099AF2792D3EAD300742928A0A12F4CFD2AA73
EE4D5C3F75B96CB08045890FC12F803303ADCB5BD9FCCE2B0E78F8E1F484235A
257FBE2249975B65647193DD6FCCAC7307AE74048421C9415D0107074C638DF9
C2E2C89D79109E0C7621F0406292DD4CEE1A3D6003F1C97B5CD98F4F594ED30C
057166A52319756AA5D4512D414A324A55456745D127EC4CD6A1243CBC050AB3
9D95E4FF4AD3829BC98E32A3F1B43F999448221B97C4C9998D0D54BD6011D5DD
6A188AF594F42A2D5DA1D92AABA115B44E594C2D8CDA504A2D8C55153F846F28
46F3334B7889E8472A0AADEA19B19F5A26CF42602A251B65374614EF44910B5E
436CC7E3F624F89732B0E08F6385AB4AFE22F50D69676081642294B44410F994
60414C3DB55993463063A95C406B8AE23BDBF231D90CC756C249A8B261726C60
6D7ECBA9049B8D3B4DB8868800B2B68CB91DF3ED2FF2105F1E5824DE285BA526
AF524B567900403AA7C5FD8274261279E3EC8DE51625F03DEE76D41E02BCF12D
1792ADF6C7252E4563C3E027D432CAB7AF7205124A3C412CCB5040B5E47BE492
C4BF379A3C38DB376A7A2AFD4F117C99E319A1378781E7AC42CAE4E0D1A4FE05
8A72992B5FF297CE8F47B24B5C87C983528EDED2C9D85CB7FA3F5E6099C49536
F022CA2E9EB03B26E25E49DEE530480A41EDBCB15B1D83CDA3B62FD32519371E
3DE7E6C57724A452D79DE9AC681C28452C32F5E154264A874DE5A2257EADCAB3
D9E0EA32D7B6D4DB85D80FFDDDE28D8D2D02CE38B0F35CE75E89166C92DF81D6
3077A118C0D3CF6C448953C4CA354A09CEE5A6B39F48DC39DDDD63E96783D1BB
126189870B2344A31313738CD047067B301206D57082610CA04FE970E3E72789
5AB9B21082C0B250E90CAC16A9B550949054CAA85415520119C92F14D7DAD574
5CC48A9248E12F887D2E1988B9F6C7E602C14AF9E1681516135F49EA2BAE0FA6
9FF20CE813EFB666925752112549812B2EDC6E4838F2DC5C116F6EEB9B8AD414
922E5FBC493FE2F0B96FF174791EF55C82262DC6AA39086B15B0CE7172B3FD79
98ABA6EFC3E153CE52F67E6BA696D239CEDD0DF87AF5FDE7F00B1FE27BEC5CF8
A3C0E64285E25FA474194DE3320FC6DFAEA1222DB7A18CBE3CA9A04CCCB14A13
D697E25889D79AF68863825F961FAD28A8F0407412B00B0149448A28629A9B9D
1808B25E128C4A858A5D9E5E4DF5261B84A605906DEEB6F0DB9095B20CAEB44C
55B67D80774148784D32D7C9CA5DB93E5E8FCC750A4615FA45ED30D39B629231
F0F11E25C3CEBBC41D92F412C30EBBE4C13204995B1EE9058FF45E867C3323BD
1921DFCDE0D1C84E725067FE312577BBE0A1A23262A03552BB943AED99FFA7B0
852B5B6902F7D81278B735E3D8DAB21F2B7BEF7238920BA3EEF3C3EFE597B082
ACA8316A33B194FC0F4EDCEB9C891B73123B8BC7D62C1358A4898F38807E8040
79F1CE5F8A5253AAD26477BA18373653EE49BB44B5891369E93EE37F084A7659
93B0D222BC8C7CA8DC1378B5CCE66E41B81A99A54D01B8042696F69F80E28B52
24C4202067732BD6487628BE646727D7B20587528E714B85025B2DAAB6505CE9
F69674D5077ACCF13873A72BBDFD1697FB714A72A52D003F4943CBA2C141A2A1
B30D5E5D6C99F9D04301C9244363202209FC77431B040804940CD96F930C307B
8BB782C12732E21B663C8F5D82914872B36B38325AB011E325D6BFBD0989FF97
78E79FFF0120649CE6573C0000
}
; END of ctx-menu
area-tc: context [	;** global context

colors: [
	char!		0.180.40
	date!		0.120.150
	decimal!	0.120.150
	email!		0.180.40
	file!		0.180.40
	integer!	0.120.150
	issue!		0.180.40
	money!		0.120.150
	pair!		0.120.150
	string!		0.180.40
	tag!		0.180.40
	time!		0.120.150
	tuple!		0.120.150
	url!		250.120.40
	refinement!	160.120.40
	comment!	255.88.9
	datatype!	120.60.100
	function!	255.0.0
	native!		255.0.0
	action!		255.0.0
	error!		255.0.0
	multi!		0.180.40
	free-text!	0.0.200
]
insert tail colors compose [ block! (pref/txt_color) default! (pref/txt_color) ]
;func-list: make string! 5000
;foreach fun bind first system/words system/words [
;	if all [value? :fun any-function? get :fun][
;		insert insert tail func-list #" " form fun
;	]
;]
;**print length? func-list
multi-chars: complement charset "^^}^/^-"	;** to detect end of rebol strings
save-color: color: start: end: out-style: x:
str: type: f: value: multi: grow?: none

;** markers used in replacement of the draw comman PUSH. Much easy to track them.
expand:		;** marker for info messages (like errors)
hilight: 'push	;** marker for hilight background
no-edit: edit: 'aliased

edit-mode: none

abs-x: 0
;** rule to output draw dialect
gen-draw: [end: (
	str: copy/part start end
	unless tail? str [
		color: any [select colors type color select colors 'default! 0.0.0]
		abs-x: x * f/x + f/origine-x
		either save-color <> color [
			if block? color [
				out-style: insert insert insert insert insert insert insert insert out-style
					'pen color/2 'fill-pen color/2 'box
					as-pair abs-x 7 as-pair (f/x * length? str) + abs-x 7 + f/y 3
				type: none
				color: color/1
			]
			out-style: insert insert insert insert insert out-style
				'pen color [text edit] as-pair abs-x + f/xy/x 5 str

		][
			insert tail pick out-style -1 str
		]
		if type = 'error! [
			out-style: insert/only insert out-style 'expand
				reduce ['pen red 'text 'vectorial as-pair abs-x 5 + f/y reform [value/id value/arg1]]
		]
		x: x + length? str
		save-color: color
		if type = 'error! [grow?: true]
	]
)]
tab1: next tab2: next tab3: next tab4: "    "
what: none
gen-tab: [(
		what: pick [tab4 tab3 tab2 tab1] x // 4 + 1		;** align tabs
		out-style: insert insert insert out-style
			[text edit] as-pair x * f/x + f/xy/x + f/origine-x 5 what
		x: x + length? get what
		save-color: none
)]

spaces: exclude charset [#"^(1)" - #" "] charset "^/^-" ;** treat like space

;** rule to detect rebol values (uses load/next)
;** (heavy, because we handle errors too)
rebol-value: [skip (
	error? set/any [value end] try [load/next start]
	either error? :value [
		value: disarm :value
		either value/arg2/1 = #"{" [
			end: any [find start newline tail start]
			type: 'multi!
			multi: case [
				multi < 2 [3]
				multi = 2 [4]
				'else [multi]
			]
		][
			end: skip start length? value/arg2
			type: 'error!
		]
	][
		case/all [
			path? :value [value: first :value]
			all [word? :value value? :value][value: get value]
			any-string? :value [
				if find/part start newline end [
					end: find/part start newline end
					multi: case [
						multi < 2 [3]
						multi = 2 [4]
						'else [multi]
					]
					type: 'multi!
				]
			]
		]
		type: type?/word :value
		color: none
	]
) :end
]

no-tabs: complement charset "^/^-"
gen-to-end: [any [some no-tabs | end: tab :end gen-draw some [tab gen-tab] start:] gen-draw]
any-char: complement charset " ^-"

;** construct a draw block for one line
set 'colorize func [
	face line out
	/local check-multi check-free-text orig lvl-start lvl val cont pline pos
][
	color: save-color: grow?: none
	f: face
	x: 0
	orig: out-style: out

	;** multi = -1, free text before REBOL header
	;** multi = 0, code not parsed
	;** multi = 1, normal code
	;** multi = 2, end of multi-line string
	;** multi = 3, begin of multi-line string
	;** multi = 4, full multi-line string

	lvl: lvl-start
	multi: case [
		head? line							[-1]
		2 < val: first pline: pick line -1	[4]
		val = -1							[-1]
		'else								[1]
	]
	lvl: lvl-start: either pline [pline/3/2][1]
	line: line/1

	check-multi: if multi <> 4 [[end skip]]
	check-free-text: [(cont: if multi <> -1 [[end skip]]) cont]

	;**all [char? line/2 print line]
	parse/all line/2 [
		start:
		check-free-text "rebol" any #" " #"[" (multi: 1) end skip
		| check-free-text (type: 'free-text!) gen-to-end
		| opt [
			check-multi start: some [
				some multi-chars
				| #"^^" [skip | end]
				|  end: tab :end (type: 'multi!) gen-draw some [tab gen-tab] start:
				| #"}" (multi: 2) break	;** end of multi-line
				| break					;** newline
			]
			(type: 'multi!) gen-draw
		]
		any [
			start: [newline | end] break
			| some spaces (type: 'blank!) gen-draw
			| tab  gen-tab
			| [#"[" | #"("] (type: 'block! lvl: lvl + 1) gen-draw
			| [#"]" | #")"] (type: 'block! lvl: lvl - 1) gen-draw
			| #";"(type: 'comment!) gen-to-end
			| rebol-value gen-draw
		]
	]

	line/1: multi
	line/3: as-pair lvl-start lvl


	f/h-scroller/max-x: max f/h-scroller/max-x x * f/x + f/origine-x + (f/x * 10)
	;**f/cursor/len: x

	case [
		empty? orig [ ;** if the text contains no chars, add a dummy line
			append orig compose [text edit (as-pair f/origine-x + f/xy/x 5) (copy "")]
		]
		not same? back start find/reverse start any-char [
			insert insert insert tail orig
				[pen blue text no-edit]
				as-pair x * f/x + f/origine-x + f/xy/x 5
				"°"
		]
	]
	grow?   ;** notices if it's a simple line or a double-size line
]

;** cut text into lines
set 'build-data func [
	text f /local out 
][
	out: f/data
	clear out 
	parse/all text [any [pos: (out: insert/only out reduce [0 pos 0x0]) thru newline]]
	f/origine-x: f/x * (1 + length? to string! length? head out)
	recycle/on 
	out: head out
]

;** boxline: [pen red fill-pen red box 0x1 32x18]

;** debug: display where show occurs
;show: func [f][print either in f 'cursor ['area-tc]['cursor-only] system/words/show f]

;** markers used in replacement of the draw comman PUSH. Much easy to track them with parse.
expand:			;** marker for info messages (like errors)
hilight: 'push	;** marker for hilight background
no-edit: 	;** marker for text no editable
edit: 'aliased

;** contruct draw blocks, only for new lines inserted
set 'render-text func [
	f inc
	/stay
	/local pos char color draw-txt
	prev-col draw-sblk nb line data n decal
][
	start: now/precise
	prev-col: none
	case [
		stay [
			inc: inc - 1
			data: skip f/data inc
		]
		inc < 0 [
			inc: negate min abs inc ((index? f/data) - 1)
			data: f/data: skip f/data inc
		]
		inc > 0 [
			inc: min max 0 ((length? f/data) - f/nb-lines) inc
			data: f/data: skip f/data inc
		]
		'else [data: f/data]
	]

	draw-txt: any [find f/effect/draw 'push tail f/effect/draw]

	case [
		stay [
			draw-txt: clear skip draw-txt max 0 inc * 4
			nb: min f/nb-lines f/nb-lines - inc
		]
		empty? draw-txt [
			nb: f/nb-lines
		]
		inc > 0 [
			remove/part draw-txt 4 * inc
			draw-txt: tail draw-txt
			nb: min f/nb-lines inc
			data: skip data either f/nb-lines > inc [f/nb-lines - inc][0]
			;** A FAIRE, si inc dépasse le nombre de lignes affichées,
			;** parser les lignes skipées (non affichées)
			;** pour détecter les strings multi-ligne
		]
		inc < 0 [
			clear skip draw-txt max 0 4 * (f/nb-lines + inc)
			nb: min f/nb-lines abs inc
		]
		'else [return true]
	]
	nb: min nb length? data
	n: 1
	decal: as-pair 0 f/y
	while [n <= nb][
		line: at data n
		draw-txt: insert draw-txt 'push
		draw-sblk: insert insert insert make block! 50
			[hilight none pen 128.128.128 text no-edit] as-pair f/xy/x 5
			reverse copy/part reverse head insert change
				clear "" "       " (n - 1 + index? data) (f/origine-x - f/x / f/x)
		if colorize f line draw-sblk [
			decal: as-pair 0 2 * f/y
		]
		draw-txt: insert insert insert/only draw-txt head draw-sblk 'translate decal
		decal: as-pair 0 f/y
		n: n + 1
	]
	
	set-y f 5   ;** recalc all y offset of texts (which can be absolute only)
	unless f/cursor/selection? [show f]
	;** probe difference now/precise start
]

;** recalc of all y offset after verstical scroll
set-y: func [f y /local blk pair line idx gb lgb chg-y][
	blk: f/effect/draw
	blk: find f/effect/draw 'push
	lgb: index? f/data
	gb: f/cursor/global-idx
	idx: 2
	f/cursor/show?: false
	chg-y: [thru 'text ['edit | 'no-edit] pair: pair! (pair/1/y: y)]
	foreach [cmd value] blk [
		switch cmd [
			translate [y: y + value/y]
			push [
				if gb = lgb [
					f/cursor/xy/y: y
					f/cursor/data: at blk idx
					f/cursor/show?: true
				]
				parse value [
					any chg-y
					any [thru 'push into [any chg-y to end break]]
				]
				lgb: lgb + 1
			]

		]
		idx: idx + 2
	]
]

move-x: func [f x /local blk pair chg-x][
	blk: f/effect/draw
	blk: find f/effect/draw 'push
	chg-x: [thru 'text ['edit | 'no-edit] pair: pair! (pair/1/x: x + pair/1/x)]
	foreach [cmd value] blk [
		switch cmd [
			translate [x: x + value/x]
			push [
				parse value [
					any chg-x
					any [thru 'push into [any chg-x to end break]]
				]
			]
		]
	]
	f/cursor/xy/x: f/cursor/xy/x + x
]


;** return the inner face matching the point
map-inner: func [face point /local pane][
	unless pane: face/pane [return face]
	unless block? pane [pane: to block! pane]
	foreach face pane [
		if within? point face/offset face/size [return map-inner face point - face/offset]
	]
	face
]

get*: func [v][do back change/only [none] v]	;** if v is a word, get value in the world
any-char: complement space: charset " ^-"

;** find a free place in the whole area to display the info box
find-free-places: func [
	f
	/local data end x len l-len r-pos stack-l stack-r
][
	stack-l: clear []
	stack-r: clear []
	data: f/data
	loop len: f/nb-lines [
		line: data/1/2
		end: any [find line newline tail line]

		;** length of the left free zone
		pos: any [find/part line space end line]
		l-len: -1 + index? pos

		;** start of the rigth free zone
		pos: ant [find/reverse end any-char end]
		r-start: index? pos

		stack-l: insert stack-l l-len
		stack-r: insert stack-r r-len
		data: next data
	]
	x: maximum-of stack-l
	loop len [

		stack-l: next stack-l
	]
]

event-func: use [
	origin off-mem save-size 0x0 drag track
][
	origin: off-mem: save-size: 0x0
	drag: track: false
	func [
		{area-tc handler}	;** don't remove or change this text, it's used to identify the handler
		face event /local tmp
	][
					;**print [event/type event/key]
		switch event/type [
			time   none	;** a lot of 'time events are sent, check it first
			key	[
					;** key handler for faces without text and caret (actually only for areat-tc)
					if event/1 = 'time [return event]   ;** FUUUUUCK, why we receive that crap event here ???
					if all [
						tmp: system/view/focal-face
						in tmp 'style
						tmp/style = 'area-tc
					][
						tmp/feel/engage tmp 'key event
					]
			]
			move [
				either drag [
					tmp: track/offset
					drag/feel/drag drag event/offset - origin
					origin: origin + track/offset - tmp	;** correct the origin, if the tracked face has moved
					return false				;** disable move event
				][off-mem: event/offset  ]			;** for mouse wheel motion
			]
			resize [
				tmp: negate saved-size - saved-size: face/pane/1/size
				foreach face face/pane/1/pane [
					if in face/feel 'resize [face/feel/resize face tmp]
				]
			]
			down [
				face: map-inner event/face event/offset
				if in face/feel 'drag [
					;** the draging face which contains the pointer may be different from the draged (track) face
					drag: face
					origin: event/offset
					track: drag/feel/drag/track drag event/offset
				]
			]
			up [if drag [recycle drag: false]]
			scroll-line [
				face: event/face
				face: map-inner event/face off-mem
				if in face/feel 'scrollwheel [
					face/feel/scrollwheel face event off-mem - win-offset? face
				]
			]
			active [saved-size: face/pane/1/size]
		]
		;**[print [event/type event/offset]]
		event
	]
]
key-to-insert: make bitset! #{
	01000000FFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
}

stylize/master [

; list of function widget
	func-view: box with [
		color: white
		edge: [ size: 1x1 color: 'black]
		feel: make feel [
			resize: func [f size+] [
				either pair? size+ [
					f/size/y: f/size/y + size+/y
				][
					f/size: size+
				]
				show f
			]
		] 
		;effect: make effect [ draw: []]
		draw-list: func [/local n nblines tmpstr line dr-blk pos] [
			nblines: length? f/data
			n: 1
			tmpstr: "" line: ""
			dr-blk: [pen 0.0.0]
			pos: 0x0
			while [n <= nblines][
				line: second f/data/:n
				line: copy/part line any [ find line newline tail line ] ; on ne prend que du debut de la ligne jusqu'au premier newline
				if not find line ";" [
					either find line any [": func" ": function" ": does" ": use" ": do" ] [
						;probe line
						tmpstr: trim detab copy/part line find line ":"
						
						insert insert insert insert tail  dr-blk 'text 'anti-aliased pos tmpstr
						pos: pos + 0x20 
					][
						if find line all ["set" "func"] [ 
							if not find line "!" [
								;probe line
								tmpstr: trim detab copy/part line find line "func"
								
								insert insert insert insert tail  dr-blk 'text 'anti-aliased pos tmpstr
								pos: pos + 0x20 
							]
						]
					]
				]
				n: n + 1
			]
			self/effect: compose/only [ draw (dr-blk) ]
			show self
			;probe dr-blk
		]
	]

; arec text color 
	area-tc: box with [
		style: 'area-tc
		rate: 1
		text: none
		para: make para [origin: 0x0 margin: 0x0]
		delay: 0
		ask: 'recycle		;** command to delay
		color: pref/bg_color
		x: 8				;** current x size oh 1 char
		y: 18				;** current y size of a line
		origine-x: 3 * x   ;** stock la position a la quelle le texte démarre apres le rendu des numéro de ligne
		data: []
		font-obj: make face/font [name: "lucida console" size: 14 style: none offset: 0x0]
		nb-lines: 0
		xy: 0x0		;** scroll offset
		move-offset: 0x0
		save-x:	0
		file-name: none
		effect: [draw [pen none font font-obj line-width 1 translate xy]]
		open-file: func [ file [file! none!] /local ][
			if any [file file: request-file ][
				;** data: build-data detab/size read file 4 self
				if block? file [file:  first file]
				data: build-data read/direct file self
				file-name: file
				render-text/stay t 1
			]
		]
		write-file: func [/local str-tmp n line nbline] [
			str-tmp: "" n: 1 nbline: length? data 
				while [n <= nbline ] [
					line: second data/:n ; on transfert le  pointeur vers le document dans data vers un autre pointeur  
					append str-tmp copy/part  line any [ find line newline tail line] ;on copy jusqu'a newline ou jusqu'a la fin 
					append str-tmp newline
					n: n + 1
			]
			write file-name str-tmp	
		]
		save-file: func [] [
			if 0 <> length? data  [
				either  none? file-name [ ; data is full but we don't have a file-name
				    if   file-name:  request-file/save/title "Save as..." "save" 
				     [ 
				     if block? file [file:  first file]
				     write-file ]
				     
				] [	
				; data is full and we have a file name
					write-file
				]	  
			]				
		]
		run_scr: func [] [
			save-file
			;call/console rejoin [ pref/consol_path file-name ]
			launch file-name
		]
		
		v-scroller: make face [
			offset: 0x0 size: 13x0 color: none edge: none
			size-box: 0x0
			para: none
			effect: [draw [pen sky line-width 2 fill-pen none box 0x0 size-box 2]]
			feel: make feel [
				redraw: func [f a /local p l][
					if all ['show = a p: f/parent-face 0 < l: length? head p/data][
						f/size/y: max 25 p/nb-lines / l * p/size/y
						f/offset/y: (index? p/data) / (l - p/nb-lines) * (p/size/y - f/size/y)
						f/size-box: f/size - 2x2
					]
				]
				drag: func [f offset /track /local coeff][
					f/parent-face/delay: 3  ;** don't perturb the scroll please
					if track [return f]
					if 1 <= abs coeff: offset/y / (f/size/y / f/parent-face/nb-lines) [
						render-text f/parent-face to integer! coeff
						if f/parent-face/cursor/selection? [
							f/parent-face/feel/expand-selector f/parent-face/cursor
							show f/parent-face
						]
					]
				]
				engage: func [f a e][false] ;** don't send events to the area
			]
		]
		h-scroller: make face [
			offset: 0x0 size: 0x13 color: none edge: none
			size-box: 0x0
			text: none
			edge: none
			font: make font [align: 'right size: 10 style: 'bold color: red]
			para: make para [origin: 0x0]
			max-x: 1
			effect: [draw [pen sky line-width 2 fill-pen none box 0x0 size-box 2]]
			feel: make feel [
				redraw: func [f a /local parent][
					if 'show = a [
						f/show?: if f/max-x > f/parent-face/size/x [
							parent: f/parent-face
							f/offset/x: to integer! negate parent/xy/x / f/max-x * parent/size/x
							f/size/x: to integer! (parent/size/x ** 2) / f/max-x
							f/size-box: f/size - 2x2
							true
						]
					]
				]
				drag: func [scroller offset /track /local parent save-x decal x][
					f: scroller/parent-face
					f/delay: 3  ;** don't perturb the scroll please
					if track [return scroller]
					if f/x <= abs offset/x [
						offset/x: to integer! offset/x + 4 / f/x * f/x
						save-x: f/xy/x
						x: f/xy/x: min 0 max
							f/size/x - scroller/max-x
							f/xy/x - offset/x

						;** change change skip tail boxline -2
						;**		as-pair negate x 1 as-pair 32 - x 18

						if 0 <> decal: x - save-x [move-x f decal]
						show f
					]
				]
				engage: func [f a e][false] ;** don't send events to the area
			]
		]
		cursor: make face [
			offset: 0x5 size: 2x18 para: color: edge: none
			xy: as-pair origine-x 5
			sub-string: idx: global-idx: col: old-col:
			old-idx: tmp-offset: pos-len: old-pos-len: none
			selection?: false
			selector-xy: [0x0]
			head?: false
			data: pos-blk: []
			blink-color: red
			size-box: 2x16
			effect: [draw [pen blink-color fill-pen blink-color box 0x1 size-box]]
			feel: make feel [
				redraw: func [f a][
					if a = 'show [
						f/offset: f/xy
						if f/selection? [
							f/selector-xy/1/x: f/xy/x - f/parent-face/xy/x
						]
					]
				]
				engage: func [f a e][] ;** disable events
			]
		]
		feel: make feel [
			scrollwheel: func [f event offset] [
				f/delay: 3
				dir: either event/offset/y > 0 ['down]['up]
				switch dir [
					down [render-text f 3]
					up [render-text f -3]
				]
				if f/cursor/selection? [expand-selector f/cursor show f]
			]
			resize: func [f size+][
				f/size: f/size + size+
				f/nb-lines: to-integer (f/size/y - 10 / f/y)
				f/v-scroller/offset: as-pair f/size/x - 13 2
				f/h-scroller/offset: as-pair 2 f/size/y - 13
				render-text/stay f 1
				if f/cursor/selection? [expand-selector f/cursor show f]
			]
			begin-selection: func [
				cursor /local f
			][

				f: cursor/parent-face
				cursor/selection?: true
				insert-selector f next cursor/data/1 cursor/xy/x + f/xy/x
				cursor/selector-xy: back tail cursor/data/1/2
				cursor/old-idx: cursor/global-idx
				cursor/old-pos-len: cursor/pos-len
				get-col cursor
				cursor/old-col: cursor/col
			]

			;** drag = activate selection
			drag: func [f offset /track /local cursor][

				;** beware, it's the cursor which moves, not the area.
				if track [return f/cursor]
				unless f/cursor/selection? [begin-selection f/cursor]

				;** not enough displacement to move the cursor
				if all [f/x > abs offset/x  f/y > abs offset/y][exit]

				case [
					all [positive? offset/y f/cursor/idx = f/nb-lines][render-text f 1]	;** scroll down
					all [negative? offset/y f/cursor/idx = 1][render-text f -1]	;** scroll up
				]
				click f f/cursor/xy + offset
				expand-selector f/cursor
				show f
			]

			detect: func [f e][
				;**print remold [e/1 e/2 e/3 e/4 e/5 e/6]
				if e/type = 'move [
					;** because of the timer, 'move events are received, even if there is no move
					if all [find [info-position recycle] f/ask f/move-offset <> e/offset][
						f/ask: 'info-position
						f/delay: 2
						f/move-offset: e/offset
					]
					return false
				]
				e
			]
			engage: func [f a e /local key tmp cursor select?][
				;**print remold [a e/type e/key e/1 e/2 e/3 e/4 e/5 e/6]
				cursor: f/cursor
				if a = 'time [
						;print [now/time f/ask f/delay]
						either all [cursor/show? find [recycle info-position] f/ask] [
							f/cursor/blink-color: get first reverse [red none]
							show f/cursor
						][f/cursor/blink-color: red]
						case [
							0 > f/delay: f/delay - 1  [
								;** if f/ask <> 'show [print ["timer:" now/time f/ask] ]
								switch f/ask [
									show		[]
									recycle	[recycle]
								]
								f/ask: 'recycle
								f/rate: 1	;** default rate, 1 event per second
								f/delay: 5	;** recycle after 5 secs of inactivity
								show f		;** DON't remove the show here (needed to update the face rate)
							]
						]
						return false
				]
				select?: cursor/selection?
				unless find [up down] key: e/key [f/save-x: 0]
				if f/ask <> 'show [f/ask: 'info-cursor  f/delay: 3]
				cursor/blink-color: red

				if all [e/5 not select? any [word? key key < #" "]][
					select?: true
					begin-selection cursor
				]
				switch a [
					down [click f e/offset]
					key [
						;** e/6 = true for ctrl
						switch/default key[
							page-up [render-text f negate f/nb-lines]
							page-down [render-text f f/nb-lines]
							#"^P" [inc-font-size f 1]  ;** increase font size
							#"^L" [inc-font-size f -1] ;** decrease font size
							#"^B" [bold f]
						][
							locate-cursor cursor
						]
						switch/default key [
							f1 [ if request "Run this Script ?" [ t/run_scr ] ]
							#"^M" [split-line f]
							#"^[" []
							#"^~" [ ;** delete
								either select? [
									do-selection/delete f
								][
									delete-char cursor
									recolorize cursor
								]
								show f
							]
							#"^H" [ ;** backtab
								either select? [
									do-selection/delete f
								][
									move-cursor/left cursor
									delete-char cursor
									recolorize cursor
								]
								show f
							]
							right [
								either e/6 [
									right-word cursor
								][
									move-cursor/right cursor
								]
								show cursor								]
							left [
								either e/6 [
									left-word cursor
								][
									move-cursor/left cursor
								]
								show cursor
							]
							down [down-cursor cursor]
							up [up-cursor cursor]
							end [
								constraint f as-pair 100000 cursor/xy/y
								show cursor
							]
							home [
								constraint f as-pair f/origine-x + f/xy/x cursor/xy/y
								show cursor
							]
							#"^S" [ if request "Save file ? " [ f/save-file] ]
							#"^O" [ if request "Open a file?" [ f/open-file none]]
							#"^N" [ if request "Start a new file?" [f/data: build-data "" f  render-text/stay f 1 ]]
							#"^C" [do-selection/clip f]
							#"^X" [do-selection/clip/delete f]
							#"^V" [;** TO-DO insert multi-lines text
								insert-char f/cursor tmp: first parse read clipboard:// "^/"
								show f
							]
							#"^F" [search f]

						][
							if all [char? key find key-to-insert key ][
								insert-char f/cursor e/key
								recolorize f/cursor
								;** auto-scroll horizontaly
								if f/x * 10 + cursor/xy/x > f/size/x [
									scroll-x f f/x * 10
								]
								show f
							]
						]
					]
				]
				if select? [
					either any [e/5 e/6 a = 'up] [
						expand-selector cursor
					][
						remove-selector cursor
					]
					show f
				]
			]
			bold: func [f][
				f/font-obj/style: either f/font-obj/style [none]['bold]
				inc-font-size f 0
			]
			search: func [f][
				;what: read clipboard://
			]

			split-line: func [f /local tmp str blanks][
				insert-char f/cursor "^/"

				tmp: at f/data f/cursor/idx
				str: tmp/1/2

				blanks: copy/part str find str any-char
				insert str: find/tail str newline blanks
				insert/only next tmp reduce [0 str 0x0]

				render-text/stay f f/cursor/idx
				replace/all blanks tab "    "
				f/cursor/xy/x: f/origine-x + f/xy/x + (f/x * length? blanks)
				down-cursor f/cursor
				f/save-x: 0
			]

			inc-font-size: func [f inc /local tmp][

				f/font-obj/size: max 10 min 30 f/font-obj/size + inc
				f/origine-x: f/origine-x / f/x
				f/xy/x: f/xy/x / f/x
				tmp: size-text make face [
					text: "MM"
					size: 300x300
					font: f/font-obj
					para: f/para
				]
				f/x: to integer! tmp/x / 2
				f/y: tmp/y + 2
				f/xy/x: f/xy/x * f/x
				f/origine-x: f/origine-x * f/x
				f/cursor/size/y: f/y
				f/cursor/size-box/y: f/y - 2
				tmp: f/cursor/xy
				resize f 0
				click f tmp
			]

			do-selection: func [
				f
				/delete /clip
				/local cursor data idx old-idx start end str start-col end-col scroll n y
			][
				cursor: f/cursor
				if clip [clip: make string! 256]
				idx: cursor/global-idx
				old-idx: cursor/old-idx
				get-col cursor
				either old-idx < idx [
					set [start end] reduce [old-idx idx]
					set [start-col end-col] reduce [cursor/old-col  cursor/col]
					either start < index? f/data [
						scroll: start - index? f/data 
						n: -1 + min start to-integer f/nb-lines / 2
						scroll: scroll - n
						y: n * f/y + 2
					][
						y: cursor/xy/y +(start - end * f/y)
					]
				][
					set [start end] reduce [idx old-idx]
					set [start-col end-col] reduce [cursor/col  cursor/old-col]
				]
				data: at head f/data start
				if start = end [
					set [start-col end-col] sort reduce [start-col end-col]
				]
				if delete [
					locate-cursor cursor
					delete: copy/part data/1/2 start-col - 1
				]
				loop end - start [
					if clip [
						append clip append copy/part at data/1/2 start-col 
							any [find data/1/2 newline tail data/1/2]
							newline

					]
					either delete [remove data][data: next data]
					start-col: 1
				]

				str: data/1/2
				case/all [
					clip [
						append clip copy/part at str start-col at str end-col
						write clipboard:// clip
						clip: none
					]
					delete [
						data/1/2: delete
						case [
							scroll [render-text f scroll]
							start <> end [render-text/stay f 1]
							'else [recolorize cursor]
						]
						if y [cursor/xy/y: y]
						constraint f cursor/xy 
						append delete copy/part at str end-col any [find str newline tail str]
						recolorize cursor
					]
				]
			]

			click: func [f offset][
					;** We don't use the focus function to avoid this dummy system caret (whe have our own)
					unless same? system/view/focal-face f [
						if system/view/focal-face [unfocus]
						system/view/focal-face: f
					]

				constraint f either offset/x - f/xy/x < f/origine-x
					[as-pair f/origine-x offset/y][offset]
				show f/cursor
			]
			expand-selector: func [
				cursor
				/local idx f pos curr-idx add-selector del-selector upd-selector str
					x upd-tail upd-head add-tail add-head calc-tail add-middle upd-middle old-idx
			][

				f: cursor/parent-face
				idx: cursor/global-idx
				old-idx: cursor/old-idx
				curr-idx: index? f/data
				del-selector: [change pos none]
				calc-tail: [
					x: 0
					parse pos [some [
						thru 'text skip pair! [set str string! | set str word! (str: get str)]
						(x: x + length? str)
					]]
					x: x + 1 * f/x
				]
				upd-middle: [cursor/selector-xy: back tail pos/1]
				upd-tail: [do calc-tail change back tail pos/1 as-pair x f/y + 7]
				upd-head: [change back tail pos/1 as-pair f/origine-x f/y + 7]
				add-head: [insert-selector f pos f/origine-x]
				add-tail: [do calc-tail insert-selector f pos x]
				add-middle: [print "Beginning of the selection lost, TO DO !!!"]

				upd-selector: [(
					either old-idx < idx [
						case [
							curr-idx < old-idx  del-selector
							curr-idx > idx	del-selector
							curr-idx = idx	upd-middle		;** cover until the position of the cursor
							'else			upd-tail		;** cover the tail of the line
						]
					][
						case [
							curr-idx < idx	del-selector
							curr-idx > old-idx  del-selector
							curr-idx = idx	upd-middle		;** cover until the position of the cursor
							'else			upd-head		;** cover the head of the line
						]
					]
					curr-idx: curr-idx + 1
				)]

				add-selector: [(
					either old-idx < idx [
						case [
							curr-idx < old-idx  none
							curr-idx > idx	none
							curr-idx = idx	[do add-head do upd-middle]		;** cover tail
							curr-idx = old-idx  [do add-middle 'do upd-tail];** cover middle to tail
							'else			[do add-head do upd-tail]		;** cover the whole line
						]
					][
						case [
							curr-idx < idx	none
							curr-idx > old-idx  none
							curr-idx = idx	[do add-tail do upd-middle]		;** cover tail
							curr-idx = old-idx  [do add-middle 'do upd-head];** cover middle to head
							'else			[do add-tail do upd-head]		;** cover the whole line
						]
					]
					curr-idx: curr-idx + 1
				)]

				parse f/effect/draw [
					any [
						thru 'push into ['hilight pos: [block! upd-selector | add-selector ] to end]
					]
				]
			]
			insert-selector: func [f where x][
				;** append an highlight box in the current block at relative x position
				change/only where
					compose [pen 255.200.10 fill-pen 250.200.10 box (as-pair x 7) (as-pair x f/y + 7)]
			]
			remove-selector: func [cursor /local f tmp][
				cursor/selection?: false
				parse cursor/parent-face/effect/draw [
					any [thru 'push into ['hilight tmp: (change tmp none) to end]]
				]
			]
			left-word: func [cursor /local f x str blk pos s-blk][
				f: cursor/parent-face
				str: get-sub-string cursor
				blk: skip s-blk: cursor/pos-blk -2

				case [
					find/reverse blk 'edit				none 	;** not head of line
					not head? str						none	;** neither
					'else [
						cursor/xy/x: 100000
						if up-cursor cursor [left-word cursor]
						exit
					]
				]
				x: 0
				foreach stuff reduce [any-char space][
					while [
						all [
							not find/reverse str stuff
							blk
							blk: find/reverse blk 'edit
						]
					][
							x: x - 1 + index? str
							str: tail get* blk/3
					]
					x: x - length? str
					str: any [find/reverse str stuff str]
					x: x + length? str
				]
				either str/1 = #" " [x: x - 1][x: x + (index? str) - index? head str]
				if x = 0 [x: -1 + index? str]
				constraint f cursor/xy + as-pair x * negate f/x 0
			]

			get-sub-string: func [cursor][
				at head do back change [none] cursor/sub-string cursor/pos-len
			]

			right-word: func [cursor /local x str blk pos][
				f: cursor/parent-face
				blk: s-blk: cursor/pos-blk
				str: get-sub-string cursor

				case [
					find blk 'edit			none 	;** not tail of line
					not tail? str			none	;** neither
					'else [
						cursor/xy/x: f/origine-x + f/xy/x
						if down-cursor cursor [right-word cursor]
						exit
					]
				]
				x: 0
				foreach stuff reduce [space any-char][
					while [
						all [
							not find str stuff
							blk
							blk: find/tail blk 'edit
						]
					][
							x: x + length? str
							str: get* blk/2
					]
					x: x - index? str
					str: any [find str stuff str]
					x: x + index? str
				]
				if str/1 = #" " [x: x + length? str]
				if x = 0 [x: length? str]
				constraint f cursor/xy + as-pair x * f/x 0
			]

			scroll-x: func [f x][
				f/h-scroller/feel/drag f/h-scroller as-pair x 0
			]

			locate-cursor: func [cursor /local x idx f][
				f: cursor/parent-face
				unless cursor/show? [
					either (idx: cursor/global-idx) < index? f/data [
						render-text f idx - index? f/data
					][
						render-text f idx - f/nb-lines + 1 - index? f/data
					]
				]
				x: cursor/xy/x
				if any [
					x > (f/size/x - f/x)
					x < f/x
				][scroll-x f f/x * 20 + f/xy/x + cursor/xy/x - f/size/x ]
			]


			move-cursor: func [
				cursor
				/left /right
				/local f pos offset len
			][
				f: cursor/parent-face
				;** locate-cursor cursor
				;** print remold [cursor/pos-len cursor/sub-string]
				case [
					left [
						if len: either string? cursor/sub-string [
							either cursor/pos-len = 1 [1][
								cursor/pos-len: cursor/pos-len - 1
								cursor/sub-string: back cursor/sub-string
								cursor/xy/x: cursor/xy/x - f/x
								false
							]
						][
							either cursor/pos-len = 1 [1][
								cursor/pos-len: 1
								cursor/xy/x: cursor/xy/x - (f/x * length? get cursor/sub-string)
								false
							]
						][
							either pos: find/tail/reverse skip cursor/pos-blk -2 'edit [
								either string? pos/2 [
									len: length? pos/2
									cursor/sub-string: at pos/2 len
								][
									cursor/sub-string: pos/2
								]
								cursor/pos-len: len
								cursor/xy/x: pos/1/1 + (len - 1 * f/x)
								cursor/pos-blk: skip pos 1
							][
								if cursor/global-idx > 1 [
									cursor/xy/x: 100000
									up-cursor cursor
								]
							]
						]
					]
					right [
						if len: either string? cursor/sub-string [
							either tail? cursor/sub-string [2][
								cursor/pos-len: cursor/pos-len + 1
								cursor/sub-string: next cursor/sub-string
								cursor/xy/x: cursor/xy/x + f/x
								false
							]
						][
							either cursor/pos-len > 1 [2][
								cursor/pos-len: 1 + length? get cursor/sub-string
								cursor/xy/x: cursor/xy/x + (f/x * length? get cursor/sub-string)
								false
							]
						][
							either pos: find/tail cursor/pos-blk 'edit [
								either string? pos/2 [
									cursor/sub-string: at pos/2 len
								][
									len: 1 + length? get pos/2
									cursor/sub-string: pos/2
								]
								cursor/pos-len: len
								cursor/xy/x: pos/1/1 + (len - 1 * f/x)
								cursor/pos-blk: skip pos 1
							][
								if cursor/global-idx < index? back tail f/data [
									cursor/xy/x: f/origine-x + f/xy/x
									down-cursor cursor
								]
							]
						]
					]
				]
			]
			delay-show: func [f][
				f/ask: 'show		;** delay the show event, speed issue
				f/delay: 1		;   wait 2 checks
				f/rate: 10		;   check 10 times per second
			]
			down-cursor: func [cursor /local f tmp][
				f: cursor/parent-face
				if cursor/global-idx < index? back tail f/data [
					if cursor/idx = f/nb-lines [
						delay-show f
						render-text f 1
					]
					tmp: cursor/xy + third cursor/data
					if f/save-x = 0 [f/save-x: tmp/x]
					constraint f as-pair f/save-x tmp/y
					unless f/ask = 'show [show cursor]
					true
				]
			]
			up-cursor: func [cursor /local f tmp][
				f: cursor/parent-face
				if cursor/global-idx > 1 [
					if cursor/idx = 1 [
						delay-show f
						render-text f -1
					]
					tmp: cursor/xy - pick cursor/data -2
					if f/save-x = 0 [f/save-x: tmp/x]
					constraint f as-pair f/save-x tmp/y
					unless f/ask = 'show [show cursor]
					true
				]
			]

			insert-char: func [cursor char /local f text refresh?][
				f: cursor/parent-face
				if cursor/selection? [
					do-selection/delete f
					locate-cursor cursor
					refresh?: true
				]
				text: cursor/sub-string
				either string? text [
					insert text char
				][
					insert insert
						either cursor/pos-len = 1 [cursor/pos-blk][next cursor/pos-blk]
						'new
						char
				]
				collect cursor
				cursor/xy/x: cursor/xy/x + either char = tab [4 * f/x][f/x * length? form char]
				if refresh? [
					render-text/stay f 1
					constraint f cursor/xy
				]
			]

			delete-char: func [cursor /local pos f data str1 str2 end][
				text: cursor/sub-string
				unless either string? text [
					unless tail? text [remove text]
				][
					if cursor/pos-len = 1 [remove back cursor/pos-blk] ;**remove the offset
				][
					either pos: find/tail cursor/pos-blk 'edit [
						either string? pos/2 [
							remove pos/2
						][
							remove pos	;** remove the offset
						]
					][
					   regroup-2-lines cursor
					   exit
					]
				]

				collect cursor
			]
			get-col: func [cursor /local col pos][
				col: 0
				pos: cursor/data/1 
				while [pos: find/tail pos 'edit][
					if same? pos: next pos cursor/pos-blk [break]
					col: col + either string? pos/1 [length? head pos/1][1]
				]
				col: col + either string? cursor/sub-string 
					[cursor/pos-len]
					[either cursor/pos-len > 1 [2][1]]
				cursor/col: col
			]

			collect: func [cursor /local full txt pos][
				full: clear {}
				add-full: [(full: insert full either word? txt [#"^-"][txt])]
				parse cursor/data/1 [
					any [thru 'edit opt [
							pair!
							opt ['new set txt skip add-full]
							set txt skip add-full
							opt ['new set txt skip add-full]
					]]
				]
				poke first at cursor/parent-face/data cursor/idx 2 copy head full
			]
			regroup-2-lines: func [cursor][
				f: cursor/parent-face
				data: at head f/data cursor/global-idx
				unless tail? next data [
					str1: either end: find data/1/2 newline [copy/part data/1/2 end][data/1/2]
					str2: either end: find data/2/2 newline [copy/part data/2/2 end][data/2/2]
					append str1 str2
					poke data/1 2 str1
					remove next data
					render-text/stay f cursor/idx
				]
			]

			;*** Reconstruct a line (draw block) after an insert
			;*** (which contains modified sub-strings)
			;* if the line contains a multi-line string, then other lines below
			;* may be reconstructed too.
			recolorize: func [
				cursor
				/local line f multi-p multi data pos-head
			][
				f: cursor/parent-face
				data: cursor/data
				line: at f/data cursor/idx

				change skip data 2
					either colorize f line clear find/tail data/1 string!
					[as-pair 0 2 * f/y][as-pair 0 f/y]

				loop f/nb-lines - cursor/idx [
					if tail? next line [break]

					multi-p: line/1/1
					multi: line/2/1
					if any [
						all [find [1 2] multi-p find [1 3] multi]
						all [find [3 4] multi-p find [2 4] multi]
					][break]

					data: find/tail data 'push
					line: next line
					change skip data 2
						either colorize f line clear find/tail data/1 string!
						[as-pair 0 2 * f/y][as-pair 0 f/y]
				]
				constraint f cursor/xy
				set-y f 5
			]

			constraint: func [
				f offset
				/local cursor y blk pair text cont? idx save-pair at-tail? len
			][
				y: idx: 0
				cont?: none
				cursor: f/cursor
				at-tail?: false
				parse f/effect/draw [
					some [
						thru 'push blk: block! skip set pair pair!
						(idx: idx + 1 cont?: if offset/y <= (y + pair/y) ['break])
						cont? (y: y + pair/y)
					]
					:blk into [
						(cont?: none)
						thru 'edit set pair pair! pos-head: text: skip
						any [
							thru 'edit set save-pair pair!
							(cont?: if offset/x < save-pair/x ['break])
							cont?
							text: skip (pair: save-pair)
						]
						opt [to 'edit | (at-tail?: true)]
					]
				]
				either string? text/1 [
					offset: min length? text/1 to integer! offset/x - pair/x / f/x
					cursor/xy: as-pair
						offset * f/x + pair/x
						y + 7
					cursor/sub-string: skip text/1 offset
					cursor/pos-len: offset + 1
				][
					;** special case, for tags (like tabulations)
					len: length? get text/1
					len: either offset/x < (f/x * len / 2 + pair/x) [0][len]
					cursor/xy: as-pair f/x * len + pair/x   y + 7
					cursor/sub-string: text/1
					cursor/pos-len: 1 + len
				]
				cursor/head?: pos-head
				cursor/data: blk
				cursor/pos-blk: text
				cursor/idx: idx
				cursor/global-idx: idx - 1 + index? f/data

				case [
					cursor/xy/x < 0 [scroll-x f -20 * f/x + cursor/xy/x]
					cursor/xy/x > f/size/x [scroll-x f f/x * 20 + f/xy/x + cursor/xy/x - f/size/x]
				]
			]
		]
		append init [
			data: append/only make block! 1000 reduce [0 ""]
			v-scroller: make v-scroller []
			h-scroller: make h-scroller []
			cursor: make cursor []
			pane: reduce [cursor v-scroller h-scroller]
			edge: make edge []
			data: build-data [""] self
			feel/resize self first reduce [size size: 0]
			feel/inc-font-size f 0
			;** remove the event handler if found
			foreach func system/view/screen-face/feel/event-funcs [
				if {area-tc handler} = pick third :func 1 [
					remove-event-func :func
				]
			]
			insert-event-func :event-func
		]
		export: context [
			font+: func [f][f/feel/inc-font-size f +1]
			font-: func [f][f/feel/inc-font-size f -1]
			bold: func [f][f/feel/bold f]
		]
	]

]
] ;** end of global context


; API layouts

pref_win: layout [
	across
	;text "Rebol VM path:"
	;return
	;fi: field 300 pref/consol_path btn "..." [ if none? (fi/text: request-file/title/filter "Choose REBOL VM" "Select" "*.exe" ) [ fi/text: pref/consol_path ] show fi]
	return
	text "API Colors" 
	return
	text "Background color:" b1: box 20x20 pref/bg_color btn "..." [ if none? b1/color: request-color [b1/color: white ] show b1 ] 
	return
	text "Default text color:" b2: box 20x20 pref/txt_color btn "..." [ if none? b2/color: request-color [ b2/color: black ] show b2]
	return tab 
	btn "Ok" [ sav-pref  t/color: pref/bg_color unview/only pref_win render-text/stay t 1 show t]
	btn "Cancel" [ unview/only pref_win ]
]


;** TEST
do test: does [
	unview/all
	view/new/options layout  [
		across space 0x0 origin 0x0
		mn: menu with [ 
			size: 750x20 data: compose/deep [
				"File" [
					"New"  # "Ctrl+N" [if request "Start a new file?" [t/data: build-data "" t  render-text/stay t 1 ]]
					"Open" # "Ctrl+O" [t/open-file none]
					"Close" # "Ctrl+W"
					bar
					"Save" # "Ctrl+S" [ if request "Save file ? " [ t/save-file]]
					bar
					"Exit" [quit]
				]
				"View" [
					"Text Size" sub [
						"Text +" [t/export/font+ t]
						"Text -" [t/export/font- t]
					]
					"BOLD/NORMAL" [t/export/bold t]
					"Functions" [l/draw-list]
				]
				"Script" [
					"Run" # "F1" [ if request "Run this Script ?" [ t/run_scr ] ]
				]
 				 "Tools" [
				 	"Preferencies" [ view/new pref_win ]
				]
				"Help" [
					"About..." [alert "WEB: http://my-trac.assembla.com/shadwolforge"]
				]
			]
		]
		below across 
		l: func-view 100x500  
		
		t: area-tc 650x500 
	][resize]
	if exists? %area-tc-03-menu3.r [t/open-file %area-tc-03-menu3.r]
	do-events
]
halt

