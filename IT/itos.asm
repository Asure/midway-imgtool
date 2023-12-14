;**************************************************************
;*
;* Software:		Shawn Liptak
;* Initiated:		6/2/92
;*
;* Modified:		12/10/93 - Started Watcom C / DOS4GW version
;*
;* COPYRIGHT (C) 1992,1993,1994 WILLIAMS ELECTRONICS GAMES, INC.
;*
;*.Last mod - 7/18/94 17:14
;**************************************************************
	option	casemap:none
	.386P
	.model	flat,syscall,os_os2

	include	wmpstruc.inc
	include	it.inc


	.code
	externdef	imgmode_init:near

	.data
;In it.c
	externdef	_imgenv_s:byte
	externdef	_tgaenv_s:byte
	externdef	_mdlenv_s:byte
	externdef	_usr1env_s:byte
	externdef	_usr2env_s:byte
	externdef	_usr3env_s:byte

;In here
	externdef	cfgstruc:CFG
;	externdef	fmode:byte
;	externdef	fname_s:byte
;	externdef	fnametmp_s:byte
	externdef	lib_hdr:
	externdef	imghdr_t:

	externdef	progname2_s:byte
	externdef	font_t:byte
	externdef	font6_t:byte
	externdef	box1:BOX
	externdef	load_s:byte
	externdef	save_s:byte
	externdef	rerror_s:byte
	externdef	werror_s:byte
	externdef	rusure_s:byte

;In itimg
	externdef	imgmode_setcfg:near

	externdef	ilselected:word


	.data

DATE	textequ	<">,@Date,<">

progname_s	db	"Image Tool 2.042 on ",DATE," by SL",10,13,"$"
progname2_s	db	"IMAGE TOOL 2.042",0
copyr_s		db	"COPYRIGHT 1994 WILLIAMS ELECTRONICS GAMES, INC.",0
nomouse_s	db	"You need a mouse and driver!$"
;nomem_s	db	"Not enough memory!$"
vidsverr_s	db	"VID save err!$"
oomem_s		db	"Out of memory!$"
viderr_s	db	"Can't set video mode!$"
forgetit_s	db	"FORGET IT!",0
load_s		db	"LOAD",0
append_s	db	"APPEND",0
save_s		db	"SAVE",0
delete_s	db	"DELETE",0
rerror_s	db	"Read error!",0
werror_s	db	"Write error, you must resave!",0
quitit_s	db	"Quit IT?",0
rusure_s	db	"Are you sure you want to do this?",0


helpfile_s	db	"c:\bin\it.hlp",0
cfgfile_s	db	"c:\bin\it.cfg",0
dirmatch_s	db	"*.*",0


	.data?

	BSSD	initsp			;Initial stack pointer

	BSS	buf	,64*1024	;Temp buffer

cfgstruc	CFG	{?}

	BSSDX	menu_p			;* Menu list
	BSSDX	gadlstmain_p		;* Main gadget list
	BSSDX	gadlst_p		;* Active gadget list
	BSSDX	gadfuncmain_p		;* Main gadget function table
	BSSDX	gadfunc_p		;* Active gadget function table
	BSSDX	key_p			;* Key function table

	BSSDX	maindraw_p		;* Code for screen update

	BSSDX	_mempool_p		;* memory pool
	BSSDX	_mempoolsz		;Size of memory pool
	BSSD	mpfree_p		;* 1st free mem block
	BSSDX	mpfree			;Free mem total
	BSSD	mpclen			;Temp copy length

	BSSW	tempcnt			;Temporary count
	BSSW	tempcnt2		;^
	BSSW	tempcnt3		;^
	BSSW	temp			;Temp value
	BSSW	temp2			;^
	BSSW	temp3			;^
	BSSW	temp4			;^
	align	4
	BSSD	tl1			;Temp long
	BSSD	tl2			;^ (must follow 1)
	BSSD	tl3			;^
	BSSD	tl4			;^
	BSSD	tl5			;^

	BSSD	vstatebuf_p		;* video state save buffer
	BSSW	vmode			;Video mode
	BSSB	vmodeold		;Old video mode
	align	4

	BSSW	keycode			;New keycode or 0

	BSSW	mousehmics		;Original mouse hmics
	BSSW	mousevmics		;^ vmics
	BSSW	mousedbl		;^ dblmics

	BSSWX	mousex			;Mouse X pos
	BSSWX	mousey			;Mouse Y pos
	BSSBX	mousebut		;Mouse button bits
	BSSBX	mousebchg		;^ change, Bit on = toggled
	align	4
	BSSD	mscrollxm		;X pos multiplier 16=1 to 1
	BSSD	mscrollym		;Y ^
	BSSD	mscrollcode_p		;* code to call when mouse moved
	BSSW	mscrollx		;Mouse scroller gad temp X pos
	BSSW	mscrolly		;^ Y
	align	4

	BSSD	prtx			;X print pos
	BSSD	prty			;Y print pos
	BSSWX	prtcolors		;Bgnd color : Fgnd color
	BSSW	prtyo			;Y print pos offset
	BSSX	prtbuf_s	,82
	align	4

	BSSD	linex1			;X1 line pos
	BSSD	liney1			;Y1 line pos
	BSSDX	linex2			;X2 line pos
	BSSDX	liney2			;Y2 line pos
	BSSD	linexfrac		;X fraction
	BSSD	lineyfrac		;Y fraction

	BSSWX	drawclipy		;Y line to clip at
	align	4

FEMAX	equ	350
	BSS	fpathold_s	,64	;Initial path
	BSSX	fpath_s		,64
	BSSX	fname_s		,13
	BSSX	fnametmp_s	,13	;Work copy
	BSSW	fselected		;# of selected file (0-MAX-1) or -1
	BSSW	f1stprt			;1st entry to print (0-MAX-1)
	BSSW	ftotal			;Total # entries (0-MAX)
	BSSD	fnxtmrkd		;Next entry to search for mark
	BSS	dta		,256	;DOS DTA
	BSS4	fptr_t	 ,FEMAX+1	;* to fentry_t
	BSS	fentry_t ,FEMAX*14	;File data entries
	BSSB	drvold			;Initial drive #
	align	4

	BSSD	fokcode_p		;* code to execute after freq
	BSSBX	fmode			;B1=Dbl click on, B0=Don't use fname_s
	align	4

	BSSD	gadmvact_p		;* active move gad or 0

	BSSD	gadlastlst_p		;* last gad list for msg/str box
	BSSD	gadlastfunc_p		;* last gad func_t for msg/str box

	BSSD	gadstrgad_p		;* active str gad or 0
	BSSD	gadcurx			;String gad cursor pos (0 - width-1)
	BSSD	gadcurxmax		;Max X ^ (0 to W-1)
	BSSD	gadobuf_p		;* original buffer
	BSS	gadbuf_s	,80	;Temp buffer for string data
	BSS	gadbufo1_s	,80	;Last string history
	BSSB	gadovwon		;!0=Overwrite mode on in string gad
	align	4

	BSSD	menui_p			;* active menu item list or 0
	BSSW	menunum			;Menu # selected or -1
	BSSW	menuinum		;Menu item # selected
	BSSW	menusx			;Menu strip x
	BSSW	menusw			;Menu strip width
	BSSW	menush			;Menu strip height
	BSSB	menuact			;!0=Menu active
	align	4

	BSSD	eboxgadcode_p		;* gadget code or 0

	BSSBX	palb1stc		;1st color selected in palblock
	BSSBX	palblastc		;last ^
	BSSBX	palblastuc		;Last used color
	BSSB	palbtruc		;!0=Show true palette (all)
		even
	BSSW	palbrmult		;Red sort multiplier
	BSSW	palbgmult		;Green ^
	BSSW	palbbmult		;Blue ^

	BSS2X	pal_t		,256	;Current pal data (5*3 bits RGB)
	BSSX	palmap_t	,256	;Current color pos of loaded pal



	.data
	align	4



FILERX	equ	32
FILERY	equ	10
FILERFX	equ	FILERX+24
FILERFY	equ	FILERY+6
X=FILERX
Y=FILERY
ID=0
ID2=100h
ID3=200h

filer_gad\
	GAD	{ @F, X+184,Y+329, 13*8,11, c12_wh, 0, GADF_DN, ID+0 }
@@:
	GAD	{ @F, X+30,Y+329, 13*8,11, c12_wh, forgetit_s, GADF_DN, ID+1 }
@@:
	GAD	{ @F, X+400,Y+329, 13*8,11, c12_wh, delete_s, GADF_DN, ID+2 }
@@:
	GAD	{ @F, FILERFX,FILERFY, 4*14*8,29*9, 0, 0, GADF_MV+GADF_MVR, ID+18h }
@@:
	GAD	{ @F, X+6,Y+276, 20,11, c2_wh, parchars_s, GADF_DN, ID+20h }
parchars_s	db	"..",0
@@:
	GAD	{ @F, X+6,Y+292, 63*8,11, c63_wh, fpath_s, GADF_STR, ID+28h }
@@:
fname_gad\
	GAD	{ @F, X+14,Y+307, 12*8,11, c12_wh, fnametmp_s, GADF_STR, ID+29h }
@@:
fmatch_gad\
	GAD	{ @F, X+140,Y+307, 12*8,11, c12_wh, 0, GADF_STR, ID+28h }
@@:
	GAD	{ @F, X+4,Y+100, 13,11, c1_wh, cA_s, GADF_DN, ID+38h }
@@:
	GAD	{ @F, X+4,Y+150, 13,11, c1_wh, cup_s, GADF_DN, ID+30h }
@@:
	GAD	{ @F, X+4,Y+165, 13,11, c1_wh, cdn_s, GADF_DN, ID+31h }
@@:
	GAD	{ @F, X+4,Y+210, 13,11, c1_wh, cA_s, GADF_DN, ID+80h }
@@:
	GAD	{ @F, X+4,Y+223, 13,11, c1_wh, cB_s, GADF_DN, ID+80h }
@@:
	GAD	{ @F, X+4,Y+236, 13,11, c1_wh, cC_s, GADF_DN, ID+80h }
@@:
	GAD	{ @F, X+4,Y+249, 13,11, c1_wh, cD_s, GADF_DN, ID+80h }
@@:
	GAD	{ @F, X+64,Y+276, 4*8,11, c3_wh, img_s, GADF_DN, ID2 }
img_s	db	"IMG",0
@@:
	GAD	{ @F, X+64+5*8,Y+276, 4*8,11, c3_wh, tga_s, GADF_DN, ID2+1 }
tga_s	db	"TGA",0
@@:
	GAD	{ @F, X+64+10*8,Y+276, 6*8,11, c5_wh, mdl_s, GADF_DN, ID2+2 }
mdl_s	db	"MODEL",0
@@:
	GAD	{ @F, X+64+17*8,Y+276, 5*8,11, c4_wh, usr1_s, GADF_DN, ID2+3 }
usr1_s	db	"USR1",0
@@:
	GAD	{ @F, X+64+23*8,Y+276, 5*8,11, c4_wh, usr2_s, GADF_DN, ID2+4 }
usr2_s	db	"USR2",0
@@:
	GAD	{ @F, X+64+29*8,Y+276, 5*8,11, c4_wh, usr3_s, GADF_DN, ID2+5 }
usr3_s	db	"USR3",0
@@:
	GAD	{ @F, X+140+14*8,Y+307, 2*8,11, c1_wh, ast_s, GADF_DN, ID3 }
ast_s	db	"*",0
@@:
	GAD	{ @F, X+140+16*8,Y+307, 4*8,11, c3_wh, img_s, GADF_DN, ID3 }
@@:
	GAD	{ @F, X+140+20*8,Y+307, 4*8,11, c3_wh, tga_s, GADF_DN, ID3 }
@@:
	GAD	{ @F, X+140+24*8,Y+307, 4*8,11, c3_wh, lbm_s, GADF_DN, ID3 }
lbm_s	db	"LBM",0
@@:
	GAD	{ @F, X+140+28*8,Y+307, 4*8,11, c3_wh, vda_s, GADF_DN, ID3 }
vda_s	db	"VDA",0
@@:
	GAD	{ 0, X+140+32*8,Y+307, 4*8,11, c3_wh, geo_s, GADF_DN, ID3 }
geo_s	db	"GEO",0


filer_gadf\
	dd	filereq_gads
	dd	filereq_envtopath
	dd	filereq_setfmatch

W=4*14*8+2
H=29*9+2

frfwin_box\
	BOX	{0,0, W+2,1, 252}
	BOX	{0,H+1, W+2,1, 254}
	BOX	{0,1, 1,H, 254}
	BOX	{1,1, W,H, 253}
	BOX	{W+1,1, 1,H, 252}
	word	-1


MSGBOXX	equ	120
MSGBOXY	equ	100
MSGBOXW	equ	400
X=MSGBOXX
Y=MSGBOXY
ID=0

msgbox_gad\
	GAD	{ @F, X+220,Y+36, 13*8,11, c12_wh, mbg1_s, GADF_DN, ID }
@@:
	GAD	{ 0, X+76,Y+36, 13*8,11, c12_wh, forgetit_s, GADF_DN, ID+1 }
mbg1_s	db	"OK",0

msgbox_gadf\
	dd	msgbox_gads


;FIX! some not in use

c1_wh	word	11,9
c2_wh	word	2*8+4,9
c3_wh	word	3*8+4,9
c4_wh	word	4*8+4,9
c5_wh	word	5*8+4,9
c12_wh	word	12*8+4,9
c16_wh	word	16*8+4,9
c63_wh	word	63*8+4,9

cup_s	db	"",0
cdn_s	db	"",0
clft_s	db	"",0
crgt_s	db	26,0	;Code view hates this char!
c4arr_s	db	28,0	;4 way arrow
clrarr_s db	29,0	;LR arrows
cast_s	db	"*",0
cA_s	db	"A",0
cB_s	db	"B",0
cC_s	db	"C",0
cD_s	db	"D",0
cL_s	db	"L",0
cM_s	db	"M",0
cS_s	db	"S",0
BR_s	db	"BR",0
CO_s	db	"CO",0




	.code

;********************************
;* OS boot point
;* EAX = *arg1 or 0

 SUBR	osmain_

	pushad
	mov	initsp,esp		;Save sp

	mov	edi,eax

	mov	edx,offset progname_s	;Print startup msg
	INT21	9


	TST	edi
	jz	@F

	push	edi
	mov	al,'?'
	call	strsrch
	pop	eax
	jnz	exitq			;Exit after message?

	call	stratoi
	mov	vmode,ax

@@:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	if	0
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	push	ds
	push	cs
	pop	ds
	mov	edx,offset handler_ctrlbrk
	INT21X	2523h			;Set Ctrl-Break handler

	mov	edx,offset handler_cerror
	mov	al,24h
	int	21h			;Set Critical Error handler
	pop	ds


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	endif
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	I21GETDRV			;Remember drive #
	mov	drvold,al
	mov	bl,al

	CLR	dl			;>Get CD string
	mov	esi,offset fpathold_s+1
	mov	BPTR [esi-1],'\'
	INT21	47h

	mov	esi,offset fpath_s+3
	add	bl,'A'
	mov	[esi-3],bl
	mov	WPTR [esi-2],'\:'
	INT21	47h






	CLR	eax			;>Chk for mouse (resets)
	int	33h
	lea	edx,nomouse_s
	inc	ax
	jnz	exiterr			;Error?




	call	mem_init


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;Memory debug

;	mov	ecx,1000
;memdblp:
;	mov	eax,ecx
;	call	mem_alloc
;	jnz	@F			;OK?
;	mov	al,ds:[0ffffffffh]
;@@:
;	call	mem_free
;
;	sub	ecx,8
;	jg	memdblp
;
;
;	call	mem_debug



;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ





;	mov	bx,2000h		;>Get 64K*2 buffer mem
;	INT21	48h
;	mov	edx,offset nomem_s
;	jc	exiterr
;	mov	imgbufseg,ax
;	add	ax,1000h
;	mov	scrnbufseg,ax



					;>Save current video mode
	mov	ah,0fh
	int	10h
	mov	vmodeold,al

					;>Save current video state
;	mov	ax,1c00h
;	mov	cx,7
;	int	10h			;Get buf size needed
;	lea	edx,vidsverr_s
;	cmp	al,1ch
;	jne	exiterr
;
;	movzx	eax,bx
;	shl	eax,6			;*64
;	call	mem_alloc
;	lea	edx,oomem_s
;	jz	exiterr			;Error?
;
;	mov	vstatebuf_p,eax
;	mov	ebx,eax
;
;	mov	ax,1c01h		;Save state to buf
;	mov	cx,7
;	int	10h



;	mov	ax,10f0h		;15 bit true color (undocumented)
;	mov	bl,2eh			;Mode
;	int	10h


;Test
;	mov	cx,10000
;	CLR	esi
;	CLR	eax
;vlp:	mov	gs:[esi],ax
;	inc	ax
;	add	esi,2
;	loopw	vlp


;	mov	ebx,7c00000h
;	CLR	eax
;	mov	[ebx],al



	call	vid_setvmode
	lea	edx,viderr_s
	jz	exiterr			;Error?

	call	vid_initvgapal


	call	cfg_load

	call	imgmode_init

	call	main_draw


	mov	bx,0feffh
	mov	cx,8
	mov	dx,97
	lea	esi,copyr_s
	call	prtf6





	if	SLAVE
	call	host_initslave
	endif

	mov	ax,1bh			;>Save mouse sensitivity
	int	33h
	mov	mousehmics,bx
	mov	mousevmics,cx
	mov	mousedbl,dx

	mov	ax,1ah			;>Set mouse sensitivity
	mov	bx,100
	mov	cx,100
	mov	dx,100
	int	33h

	call	mouse_reset



;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

mainlp:
;	mov	dx,3dah
;	in	al,dx
;	and	al,8
;	jz	mainlp			;Not in VB?


	mov	ah,11h			;>Chk keyboard buffer
	int	16h
	jz	chkmouse		;Empty?

	call	mouse_erase

	mov	ah,10h			;>Get key
	int	16h
	cmp	al,0e0h
	jne	noe0			;!101 extended?
	CLR	al
noe0:	TST	al
	jz	extkey			;Extended key?
	CLR	ah
extkey:	mov	keycode,ax

	push	eax
	mov	bx,0ffh
	mov	cx,280
	mov	dx,392
	call	prt_hexword
	pop	eax

	cmp	menuact,0
	jne	keyx			;Menu on?

	push	offset keyx		;Return addr

	cmp	gadlst_p,offset msgbox_gad
	je	msgbox_key		;Msgbox open?

	mov	ebx,gadstrgad_p
	TST	ebx
	jnz	gadstr_key		;Str gad active?

	cmp	gadlst_p,offset filer_gad
	je	filereq_key		;File requster open?

	pop	ebx
	mov	esi,key_p
	jmp	keyst

keylp:	inc	bx
	jz	keyx			;End of table?
	add	esi,2+4
keyst:	mov	bx,[esi]
	cmp	ax,bx
	jne	keylp

	call	DPTR 2[esi]		;Call function, Pass AX=Keycode

keyx:	mov	keycode,0
	jmp	drawmouse



chkmouse:
	mov	ax,3			;>Read mouse
	int	33h
	and	bl,3
	shr	cx,2			;/2
	shr	dx,2

	mov	al,mousebut
	mov	mousebut,bl
	xor	al,bl
	mov	mousebchg,al
	jz	nchg			;!Button change?

	CLR	eax
	mov	gadmvact_p,eax		;Reset move gad *
	jmp	mchg
nchg:
	cmp	cx,mousex		;>Any changes?
	jne	mchg
	cmp	dx,mousey
	je	mainlp

mchg:
	push	ebx

	push	ecx
	push	edx
	call	mouse_erase
	pop	edx
	pop	ecx
	mov	mousex,cx
	mov	mousey,dx


	push	edx			;>Prt mouse XY
	mov	ax,cx
	mov	bx,0ffh
	mov	cx,144
	mov	dx,395
	call	prtf6_dec3srj
	pop	eax
	mov	bx,0ffh
	mov	cx,144+24
	mov	dx,395
	call	prtf6_dec3srj
	pop	ebx


	cmp	menuact,0
	je	nom			;Menu off?

	call	menu_main
	jmp	drawmouse
nom:


	cmp	mousebchg,0
	jne	@F			;Transition?

	test	bl,3
	jz	drawmouse		;!Mouse but?
@@:
	test	bl,2
	jz	@F			;!Rgt but?

	cmp	mousey,0
	je	menui
@@:

	call	gad_chkmouse
	TST	esi
	jz	drawmouse		;Not over a gadget?

	mov	bx,[esi].GAD.FLAGS

	test	mousebchg,1
	jz	@F			;No lbut change?
	test	mousebut,1
	jz	chkup			;!Lbut?
	test	bx,GADF_DN
	jnz	callgad
	jmp	@F
chkup:
	test	bx,GADF_UP
	jnz	callgad
@@:
	test	mousebchg,2
	jz	@F			;No rbut change?
	test	mousebut,2
	jz	chkupr			;!Rbut?
	test	bx,GADF_DNR
	jnz	callgad
	jmp	@F
chkupr:
	test	bx,GADF_UPR
	jnz	callgad
@@:

	test	mousebut,1
	jz	@F			;!Lbut?
	test	bx,GADF_MV
	jz	nobut
	jmp	mvgad
@@:
	test	mousebut,2
	jz	drawmouse		;!Rbut?
	test	bx,GADF_MVR
	jz	nobut
mvgad:
	mov	edi,gadmvact_p
	cmp	esi,edi
	je	callgad			;Already active?
	TST	edi
	jnz	drawmouse		;Another active?
	mov	gadmvact_p,esi

callgad:
	TST	ax
	jl	drawmouse		;Neg ID?
	movzx	ebx,ah
	shl	ebx,2			;*4
	add	ebx,gadfunc_p
					;Call function, Pass AX=Gadget ID
					;ECX/EDX=XY offset from gad
	call	DPTR [ebx]		;ESI=*Gadget
	jmp	drawmouse


nobut:	test	bx,GADF_STR
	jz	nostr

	call	gadstr_init

nostr:
drawmouse::
	call	mouse_draw

	movzx	ax,mouseptrbuf		;>Prt pixel # under tip of mouse
	mov	bx,0ffh
	mov	cx,144+24+24
	mov	dx,395
	call	prtf6_dec3srj

	jmp	mainlp


menui:
	call	menu_init
	jmp	drawmouse


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

exit::
	call	cfg_save


	mov	dl,drvold
	I21SETDRV

	mov	edx,offset fpathold_s	;>Set CD
	INT21	3bh


	mov	ax,1ah			;>Set old mouse sensitivity
	mov	bx,mousehmics
	mov	cx,mousevmics
	mov	dx,mousedbl
	int	33h

	CLR	edx


exiterr:
	push	edx

	mov	al,vmodeold		;>Restore old vidmode
	CLR	ah
	int	10h

;	mov	ebx,vstatebuf_p		;>Restore original video state
;	TST	ebx
;	jz	@F
;	mov	ax,1c02h
;	mov	cx,7
;	int	10h
;@@:
	pop	edx


	TST	edx
	jz	@F
	INT21	9			;>Prt exit msg
@@:


;	mov	bx,imgfileh		;>Close last img file
;	TST	bx
;	jz	notopen
;	mov	ah,3eh
;	int	21h
;notopen:

;	mov	ax,imgbufseg		;>Free ibuf mem
;	TST	ax
;	jz	@F
;	mov	es,ax
;	INT21	49h
;@@:

exitq:
	mov	esp,initsp		;Get original sp
	popad

	ret


 SUBEND



;********************************
;* Run test code


 SUBRP	test_main

	push	DPTR ds:[46ch]

	test	mousebut,2		;R but
	jnz	rbut

;	mov	ecx,10000000
;@@:
;	add	al,bl
;	add	al,bl
;	loop	@B


;	mov	cx,50
;lp:	CLR	eax
;	call	ilst_select
;	loopw	lp

	externdef	_3d_draw:near
;	mov	ecx,500
	mov	ecx,100
@@:	call	_3d_draw
	loop	@B

	jmp	time

rbut:
	mov	ecx,10000000
@@:
	add	ax,bx
	add	ax,bx
	loop	@B

;	mov	cx,200
;@@:	CLR	eax
;	call	ilst_select
;	loopw	@B

;	call	ilst_select
;	mov	cx,200
;@@:	CLR	eax
;	call	img_prt
;	loopw	@B

;	mov	cx,30
;@@:	call	_3d_drawsync
;	loopw	@B

time:
	pop	edx
	mov	eax,ds:[46ch]
	sub	eax,edx

	mov	bx,0feffh
	CLR	ecx
	CLR	edx
	call	prt_dec

	ret

 SUBEND


;********************************
;* Redraw main screen

 SUBRP	main_redraw

	mov	eax,gadlstmain_p
	cmp	gadlst_p,eax
	je	main_draw
	ret

 SUBEND


;********************************
;* Draw main screen

 SUBRP	main_draw

	mov	eax,gadlstmain_p
	mov	gadlst_p,eax

	mov	eax,gadfuncmain_p
	mov	gadfunc_p,eax

	call	scr_clr

	mov	eax,maindraw_p
	TST	eax
	jz	x
	call	eax
x:
	ret

 SUBEND


;********************************
;* Main function - Exit program

 SUBRP	main_exit

	CLR	al
	mov	esi,offset quitit_s
	call	msgbox_open			;Must be near call
	jnz	main_draw

	pop	eax
	jmp	exit


 SUBEND




;********************************
;* Initialize memory pool
;* Trashes EAX-EBX

MEMDEBUG	equ	1
NXT=8

 SUBRP	mem_init

	mov	eax,_mempool_p
	mov	mpfree_p,eax

	mov	ebx,_mempoolsz
	sub	ebx,NXT
	mov	mpfree,ebx

	mov	DPTR [eax],ebx			;Size of block

	mov	DPTR NXT[eax],0			;* next

	if	MEMDEBUG
	not	ebx
	mov	DPTR 4[eax],ebx
	endif

	ret

 SUBEND


;********************************
;* Allocate from pool of memory
;* EAX = Length
;*>EAX = *Mem or 0 if error (CC)
;* Trashes out

 SUBRP	mem_alloc

	PUSHMR	ebx,edx,esi

	if	MEMDEBUG
	call	mem_debug
	endif

	add	eax,3			;Round up to double
	and	al,0fch
	mov	esi,offset mpfree_p-NXT
	jmp	strt
lp:
	cmp	[esi],eax
	jae	found			;Large enough?

strt:	mov	ebx,esi
	mov	esi,NXT[esi]
	TST	esi
	jnz	lp			;!End?

	CLR	eax			;Error!
	jmp	x

found:
	mov	edx,[esi]		;Size
	sub	edx,eax			;-request
	cmp	edx,16
	jae	@F			;Remainder big enough to keep?

	add	edx,eax
	sub	mpfree,edx		;Sub from total
	lea	eax,NXT[esi]		;Unlink block (we take all)
	mov	edx,[eax]
	mov	NXT[ebx],edx
	jmp	x

@@:					;>Grab mem from end of block
	sub	edx,NXT
	mov	[esi],edx		;New size
	mov	NXT[esi+edx],eax	;Save size

	if	MEMDEBUG
	not	edx
	mov	4[esi],edx		;Chksum
	not	edx
	not	eax
	mov	NXT+4[esi+edx],eax	;Chksum
	not	eax
	endif

	add	eax,NXT
	sub	mpfree,eax		;Sub from total
	lea	eax,NXT+NXT[esi+edx]

x:
	TST	eax			;Set CC
	POPMR
	ret

 SUBEND


;********************************
;* Allocate from pool of memory and clear
;* EAX = Length
;*>EAX = *Mem or 0 if error (CC)
;* Trashes out

 SUBRP	mem_alloc0

	PUSHMR	ecx

	mov	ecx,eax

	call	mem_alloc
	jz	x

	call	mem_clr
x:
	POPMR
	ret

 SUBEND


;********************************
;* Free block of memory
;* EAX = *Mem or 0
;* Trashes EAX

 SUBRP	mem_free

	TST	eax
	jz	xx			;No mem?

	PUSHMR	edx

	mov	edx,mpfree_p
	mov	[eax],edx
	sub	eax,NXT
	mov	mpfree_p,eax

	mov	eax,[eax]		;Size
	add	mpfree,eax

	if	MEMDEBUG
	call	mem_debug
	endif

	POPMR
xx:	ret

 SUBEND

;********************************
;* Check mem chain
;* Trashes none

	if	MEMDEBUG

 SUBRP	mem_debug

	pushad

	mov	ecx,_mempool_p
	mov	edx,ecx
	add	edx,_mempoolsz
	sub	edx,NXT

	mov	esi,offset mpfree_p-NXT
lp:
	mov	esi,NXT[esi]
	TST	esi
	jz	x			;End?

	cmp	esi,ecx
	jb	error
	cmp	esi,edx
	jae	error

	mov	ebx,[esi]
	not	ebx
	cmp	ebx,4[esi]
	je	lp			;Chksum OK?
error:
	mov	al,1
	mov	esi,offset memerror_s
	call	msgbox_open
	jmp	exit

x:	popad
	ret

 SUBEND
	.data
memerror_s	db	"Memory error!!! BYE!",0

	endif


;********************************
;* Clear memory
;* EAX = *Mem
;* ECX = Length (or 0)
;* Trashes none

 SUBRP	mem_clr

	PUSHMR	eax,ecx,edx

	CLR	edx
	jmp	dstrt
@@:
	mov	[eax],edx	;Clr doubles
	add	eax,4
dstrt:	sub	ecx,4
	jge	@B

	add	ecx,4
	jmp	bstrt
blp:
	mov	[eax],dl	;Clr bytes
	inc	eax
bstrt:	dec	ecx
	jge	blp

	POPMR
	ret

 SUBEND


;********************************
;* Copy memory
;* EAX = *Source
;* EBX = *Dest
;* ECX = Length (or 0)
;* Trashes none

 SUBRP	mem_copy

	push	eax
	push	ebx
	push	ecx
	push	edx

	jmp	dstrt

@@:	mov	edx,[eax]	;Copy doubles
	mov	[ebx],edx
	add	eax,4
	add	ebx,4
dstrt:	sub	ecx,4
	jge	@B

	add	ecx,4
	jmp	bstrt
blp:
	mov	dl,[eax]	;Copy bytes
	mov	[ebx],dl
	inc	eax
	inc	ebx
bstrt:	dec	ecx
	jge	blp

	pop	edx
	pop	ecx
	pop	ebx
	pop	eax

	ret

 SUBEND



;********************************
;* Duplicate a memory block
;* EAX = *Source memblock
;*>EAX = *Mem or 0 if error (CC)
;* Trashes out

 SUBRP	mem_duplicate

	PUSHMR	ebx,ecx

	mov	ebx,eax

	mov	eax,[eax-NXT]		;Size
	mov	ecx,eax
	call	mem_alloc
	jz	x			;Error?

	xchg	ebx,eax

	call	mem_copy

	mov	eax,ebx


	TST	eax
x:
	POPMR
	ret

 SUBEND




;********************************
;* Init the VGA DAC palette
;* Trashes all non seg

 SUBRP	vid_initvgapal

	mov	esi,offset c_t
	mov	cx,4
	mov	al,0fch

	jmp	vid_setvgapal18

	.data
c_t	db	48,48,48	;RGB
	db	32,32,32
	db	20,20,20
	db	63,63,5
	.code

 SUBEND



;********************************
;* Dump 18 bit RGB bytes to VGA palette registers
;* AL = 1st DAC color #
;* CX = # colors
;* ESI= *RGB data
;* Trashes all non seg

 SUBR	vid_setvgapal18

	mov	dx,DAC_WADDR
	out	dx,al

	mov	ax,cx		;*3
	add	cx,cx
	add	cx,ax

	mov	dx,DAC_DATA
lp:	lodsb
	out	dx,al

	loopw	lp

	ret
 SUBEND


;********************************
;* Dump 15 bit RGB packed words to VGA palette registers
;* AL = 1st DAC color #
;* CX = # colors
;* ESI= *Word RGB data
;* Trashes all non seg

 SUBRP	vid_setvgapal15

	mov	dx,DAC_WADDR
	out	dx,al

	mov	dx,DAC_DATA
lp:
	mov	al,1[esi]			;Red
	and	al,1111100b
	shr	al,1
	out	dx,al

	mov	ax,[esi]			;Green
	and	ax,1111100000b
	shr	ax,5-1
	out	dx,al

	lodsw					;Blue
	and	al,1fh
	add	al,al				;*2
	out	dx,al

	loopw	lp

	ret
 SUBEND



;********************************
;* Set the video card mode to 640x400 256 colors
;* > Z=Error
;* Trashes all non seg

STL24	equ	0

	.data?
viddat	db	30 dup (?)

 SUBR	vid_setvmode

	mov	esi,offset m_t		;>Set vmode
	movzx	eax,vmode
	TST	eax
	jz	@F			;No user specifed mode?
	mov	[esi],eax

@@:	cld

lp:	lodsw				;Get mode #
	TST	ax
	jz	x			;End? Z set

	mov	vmode,ax

	TST	ah
	jz	norm

	mov	bx,ax			;>Set VESA mode
	mov	ax,4f02h
	int	10h
	cmp	ax,4fh
	jne	lp			;Error?
	jmp	vesa
;	jmp	vok


norm:	CLR	ah			;>Set normal mode
	int	10h

	mov	ah,0fh			;>Chk new vmode
	int	10h
	cmp	al,BPTR vmode
	jne	lp			;Error?



vesa:

	if	STL24

	mov	dx,CC_INDEX		;>Unlock S3 VGA registers
	mov	ax,4838h
	out	dx,ax


	mov	esi,offset viddat
	mov	bl,30h
	mov	cx,12

@@:	mov	dx,CC_INDEX		;>Test
	mov	al,bl		;
	out	dx,al
	inc	dx
	in	al,dx
	mov	[esi],al
	inc	esi
	inc	bl
	loopw	@B


	mov	ax,13h			;>Fix
	int	10h



	mov	dx,CC_INDEX		;>Clr scan line doubling
	mov	al,CC_MAXSCAN
	out	dx,al
	inc	dx
	in	al,dx
	and	al,01110000b
	out	dx,al
	dec	dx


;	mov	al,CC_VRE		;Turn off reg 0-7 protection
;	out	dx,al
;	inc	dx
;	in	al,dx
;	and	al,7fh
;	out	dx,al
;	dec	dx
;
;	mov	al,CC_HTOT		;
;	out	dx,al
;	inc	dx
;	in	al,dx
;	push	eax
;	add	al,80
;	out	dx,al
;	dec	dx
;
;	mov	al,CC_HDIS		;
;	out	dx,al
;	inc	dx
;	in	al,dx
;	add	al,80
;	out	dx,al
;	dec	dx
;
;	mov	al,2		;
;	out	dx,al
;	inc	dx
;	in	al,dx
;	add	al,80
;	out	dx,al
;	dec	dx
;
;	mov	al,4		;
;	out	dx,al
;	inc	dx
;	in	al,dx
;	add	al,80
;	out	dx,al
;	dec	dx

;	mov	dx,SC_INDEX		;>
;	mov	al,SC_CLKMODE
;	out	dx,al
;	inc	dx
;	in	al,dx
;;	pushad
;
;	and	al,11100011b
;;	or	al,00000100b
;	out	dx,al

	endif
;vok:


	call	vid_chain4off


	if	STL24

	call	scr_clr


	mov	esi,offset viddat
	mov	cx,20
	mov	dx,0
@@:	push	ecx
	mov	al,[esi]
	inc	esi
	push	esi
	CLR	ah
	mov	bx,0fdfch
	mov	cx,0
	call	prt_hexword
	add	dx,8
	pop	esi
	pop	ecx
	loopw	@B


	mov	eax,80000000
wt:	dec	eax
	jg	wt

	endif


ok:
	CLR	eax
	inc	eax			;Clr Z
x:
	ret

 SUBEND

	.data
m_t	dw	2fh,5eh,61h,0



;********************************
;* Turn off VGA chain4 mode
;* Trashes all non seg

 SUBR	vid_chain4off

	mov	dx,GC_INDEX		;>Clr odd/even mode
	mov	al,GC_GFXMODE
	out	dx,al
	inc	dx
	in	al,dx
	and	al,11101111b
	out	dx,al
	dec	dx

	mov	al,GC_MISC		;>Clr odd/even in misc
	out	dx,al
	inc	dx
	in	al,dx
	and	al,11111101b
	out	dx,al

	mov	dx,SC_INDEX		;>Set linear, Clr odd/even mode
	mov	al,SC_MEMMODE
	out	dx,al
	inc	dx
	in	al,dx
	and	al,11110011b
	or	al,4
	out	dx,al

	mov	dx,CC_INDEX		;>Clr dword mode
	mov	al,CC_ULINE
	out	dx,al
	inc	dx
	in	al,dx
	and	al,10111111b
	out	dx,al
	dec	dx

	mov	al,CC_MODECTRL		;>Set byte mode
	out	dx,al
	inc	dx
	in	al,dx
	or	al,40h
	out	dx,al

	ret
 SUBEND




;********************************
;* Keep in here??????????????????

PALBX	equ	184
PALBY	equ	240
PALBW	equ	8*16
PALBH	equ	8*16

	externdef	plselected:dword
	externdef	pal_find:near


;********************************
;* Initialize palette block

 SUBR	palblk_init

	mov	palbrmult,14
	mov	palbgmult,20
	mov	palbbmult,10
	mov	palbtruc,0
	ret

 SUBEND


;********************************
;* Display the palette block
;* Trashes all non seg

XA=8
YA=8

 SUBRP	palblk_draw

	CLR	bh
	mov	ecx,PALBX
	mov	edx,PALBY

lp:
	mov	ax,1
	mov	esi,offset palsq_s
	shr	bx,8			;Color
	call	prt
	mov	bh,bl


	cmp	bh,palb1stc
	jne	not1c

	mov	bl,0ffh			;>Prt 1st color marker
	cmp	bl,bh
	jne	@F
	mov	bl,0fch
@@:	push	ecx
	push	edx
	mov	linex2,ecx
	mov	liney2,edx
	add	ecx,3
	mov	prtcolors,bx
	call	line_draw
	pop	edx
	pop	ecx
	push	ecx
	push	edx
	mov	linex2,ecx
	mov	liney2,edx
	add	edx,3
	call	line_draw

	pop	edx
	pop	ecx
not1c:

	cmp	bh,palblastc
	jne	notlc

	mov	bl,0ffh			;>Prt last color marker
	cmp	bl,bh
	jne	@F
	mov	bl,0fch
@@:	push	ecx
	push	edx
	add	ecx,4
	mov	linex2,ecx
	mov	liney2,edx
	add	ecx,3
	mov	prtcolors,bx
	call	line_draw
	pop	edx
	pop	ecx
	push	ecx
	push	edx
	add	ecx,7
	mov	linex2,ecx
	mov	liney2,edx
	add	edx,3
	call	line_draw
	pop	edx
	pop	ecx

notlc:
	add	ecx,XA
	cmp	ecx,PALBX+16*XA
	jb	xok
	mov	ecx,PALBX		;1st X
	add	edx,YA			;Next Y
xok:	inc	bh			;Next color
	jnz	lp



	movzx	ax,palb1stc		;>Prt 1st color #
	mov	bx,0ffh
	mov	cx,PALBX-46
	mov	dx,PALBY+43
	call	prtf6_dec3srj

	call	palblk_draw1strgb
	call	palblk_drawsortm


	ret

	.data
palsq_s	db	1fh,0
	.code

 SUBEND



;********************************
;* Draw palette block RBG value of 1st selected color
;* Trashes all non seg

X=-49

 SUBRP	palblk_draw1strgb

	movzx	ebx,palb1stc
	shl	ebx,1
	mov	ax,pal_t[ebx]

	push	eax
	shr	ax,10
	mov	bx,0ffh
	mov	cx,PALBX+X
	mov	dx,PALBY+64
	call	prtf6_dec2rj
	pop	eax

	push	eax
	shr	ax,5
	and	ax,1fh
	mov	cx,PALBX+X+16
	call	prtf6_dec2rj
	pop	eax

	and	ax,1fh
	mov	cx,PALBX+X+32
	jmp	prtf6_dec2rj


 SUBEND


;********************************
;* Draw palette block RBG sort multipliers
;* Trashes all non seg

X=-49

 SUBRP	palblk_drawsortm

	mov	ax,palbrmult
	mov	bx,0ffh
	mov	cx,PALBX+X
	mov	dx,PALBY+120
	call	prtf6_dec2rj

	mov	ax,palbgmult
	mov	cx,PALBX+X+16
	call	prtf6_dec2rj

	mov	ax,palbbmult
	mov	cx,PALBX+X+32
	jmp	prtf6_dec2rj


 SUBEND



;********************************
;* Display the loaded palettes name
;* Trashes none

Y=PALBY+16*YA+3

 SUBRP	palblk_prtinfo

	pushad


	movzx	ax,palblastuc		;>Prt size of pal
	inc	ax
	mov	bx,0fch
	mov	cx,PALBX-2
	mov	dx,Y+1
	call	prtf6_dec3srj


	mov	ax,9			;>Prt name
	CLR	bh
	mov	cx,PALBX+30
	mov	dx,Y
	call	prt_spc

	mov	eax,plselected
	call	pal_find
	jz	x
	lea	esi,[eax].PAL.N_s

	mov	bx,0fch
	call	prt

x:
	popad
	ret


 SUBEND


;********************************
;* Toggle true palette setting

 SUBRP	palblk_togtruc

	not	palbtruc

	jmp	palblk_setvgapal


 SUBEND


;********************************
;* Palette block gadets
;* AX=Gadget ID
;* CX=X top left offset from gad
;* DX=Y ^

 SUBRP	palblk_gads


	externdef	plst_loadpblk:near
	externdef	plst_savepblk:near


	pushad

	cmp	plselected,0
	jl	x

	TST	al			;>Select color
	jnz	g2

	shr	cx,3			;/8
	shr	dx,3
	imul	dx,16
	add	dx,cx

	cmp	dl,palblastuc
	jbe	@F
	mov	dl,palblastuc
@@:
	test	mousebut,2		;R but
	jnz	setlst

	mov	palb1stc,dl
	cmp	dl,palblastc
	jbe	draw			;1st before last?

setlst:	mov	palblastc,dl
	cmp	dl,palb1stc
	jae	draw			;Last after 1st?
	mov	palb1stc,dl

draw:	call	palblk_draw
	jmp	x

g2:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,20h			;>Reload palette
	jne	g30

	call	plst_loadpblk
	jmp	x

g30:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,21h			;>Save palette
	jne	g40

	call	plst_savepblk
	jmp	x

g40:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,30h			;>Sort by brightness
	jne	g50

	call	palblk_sortbrt
	jmp	svga

g50:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,38h			;>Sort into R,G,B
	jne	g60

	call	palblk_sortrgb

svga:	call	palblk_setvgapal
	call	palblk_draw1strgb
	jmp	x

g60:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,40h			;>Adjust range by RGB
	jb	g70
	cmp	al,4fh
	ja	g70

	call	palblk_adjrgb

	jmp	svga

g70:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,50h			;>Adjust sort RGB multipliers
	jb	g80
	cmp	al,5fh
	ja	g80

	mov	dl,1
	test	al,1
	jz	@F
	neg	dl
@@:
	mov	esi,offset palbrmult
	cmp	al,54h
	jb	@F
	mov	esi,offset palbgmult
@@:	cmp	al,58h
	jb	@F
	mov	esi,offset palbbmult
@@:
	add	BPTR [esi],dl
	call	palblk_drawsortm

	jmp	x

g80:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,60h			;>Adjust sort RGB multipliers
	jne	g90

	call	palblk_movecolor
	jmp	svga


g90:

x:	popad
	ret


 SUBEND


;********************************
;* Sort loaded palette by brightness
;* Trashes all non seg

 SUBRP	palblk_sortbrt

lp:
	CLR	edi
	mov	cl,palb1stc
	cmp	cl,palblastc
	je	x
	TST	cl
	jnz	strt
	inc	cl
	jmp	strt
lp2:
	movzx	esi,cl
	add	esi,esi			;*2
	add	esi,offset pal_t

	movzx	ebx,cl
	inc	bl
	add	ebx,ebx			;*2
	add	ebx,offset pal_t

	push	ecx			;>Compare current and next color

	mov	ax,[esi]
	mov	cx,ax
	and	ax,1fh			;Blue
	imul	ax,palbbmult

	shr	cx,10
	and	cx,1fh			;Red
	imul	cx,palbrmult
	cmp	ax,cx
	jae	@F
	xchg	ax,cx
@@:
	mov	temp,cx			;Save smaller

	mov	cx,[esi]
	shr	cx,5
	and	cx,1fh			;Green
	imul	cx,palbgmult
	cmp	ax,cx
	jae	@F
	xchg	ax,cx
@@:
	cmp	cx,temp
	jae	@F
	xchg	cx,temp
@@:	shr	cx,1			;/2
	add	ax,cx
	mov	cx,temp
	shr	cx,2			;/4
	add	ax,cx
	mov	dx,ax

	mov	ax,[ebx]
	mov	cx,ax
	and	ax,1fh			;Blue
	imul	ax,palbbmult

	shr	cx,10
	and	cx,1fh			;Red
	imul	cx,palbrmult
	cmp	ax,cx
	jae	@F
	xchg	ax,cx
@@:
	mov	temp,cx			;Save smaller

	mov	cx,[ebx]
	shr	cx,5
	and	cx,1fh			;Green
	imul	cx,palbgmult
	cmp	ax,cx
	jae	@F
	xchg	ax,cx
@@:
	cmp	cx,temp
	jae	@F
	xchg	cx,temp
@@:	shr	cx,1			;/2
	add	ax,cx
	mov	cx,temp
	shr	cx,2			;/4
	add	ax,cx


	pop	ecx
	cmp	dx,ax
	jae	nxt


	mov	ax,[esi]		;>Exchange colors
	mov	dx,[ebx]
	mov	[esi],dx
	mov	[ebx],ax

	movzx	edi,cl
	mov	al,palmap_t[edi]
	inc	cl
	movzx	edi,cl
	mov	dl,palmap_t[edi]
	mov	palmap_t[edi],al
	dec	cl
	movzx	edi,cl
	mov	palmap_t[edi],dl

	mov	edi,1			;Set exchange flag

nxt:	inc	cl
strt:	cmp	cl,palblastc
	jne	lp2

	TST	edi
	jnz	lp			;Any exchanges?

x:
	ret


 SUBEND


;********************************
;* Sort loaded palette into R,G,B
;* Trashes all non seg

 SUBRP	palblk_sortrgb

lp:
	CLR	edi
	mov	cl,palb1stc
	cmp	cl,palblastc
	je	x
	TST	cl
	jnz	strt
	inc	cl
	jmp	strt
lp2:
	movzx	esi,cl
	add	esi,esi			;*2
	add	esi,offset pal_t

	movzx	ebx,cl
	inc	bl
	add	ebx,ebx			;*2
	add	ebx,offset pal_t

	push	ecx			;>Compare current and next color

	mov	ax,[esi]
	mov	cx,ax
	and	ax,1fh			;Blue
;	imul	ax,palbbmult
	mov	temp,3

	shr	cx,10
	and	cx,1fh			;Red
;	imul	cx,palbrmult
	cmp	ax,cx
	ja	@F
	mov	temp,1			;Magenta #
	je	@F
	mov	temp,5
	mov	ax,cx
@@:
	mov	cx,[esi]
	shr	cx,5
	and	cx,1fh			;Green
;	imul	cx,palbgmult
	cmp	ax,cx
	ja	@F
	jb	grn
	cmp	temp,1
	jne	nmag
	mov	temp,9			;Grey
nmag:	sub	temp,3
	jmp	@F
grn:	mov	temp,4
	mov	ax,cx
@@:
	mov	dx,ax

	mov	ax,[ebx]
	mov	cx,ax
	and	ax,1fh			;Blue
;	imul	ax,palbbmult
	mov	temp2,3

	shr	cx,10
	and	cx,1fh			;Red
;	imul	cx,palbrmult
	cmp	ax,cx
	ja	@F
	mov	temp2,1			;Magenta #
	je	@F
	mov	temp2,5
	mov	ax,cx
@@:

	mov	cx,[ebx]
	shr	cx,5
	and	cx,1fh			;Green
;	imul	cx,palbgmult
	cmp	ax,cx
	ja	@F
	jb	grn2
	cmp	temp2,1
	jne	nmag2
	mov	temp2,9			;Grey
nmag2:	sub	temp2,3
	jmp	@F
grn2:	mov	temp2,4
	mov	ax,cx
@@:


	mov	cx,temp2
	cmp	cx,temp
	pop	ecx
	jb	nxt
	ja	exg
	cmp	dx,ax
	jae	nxt

exg:
	mov	ax,[esi]		;>Exchange colors
	mov	dx,[ebx]
	mov	[esi],dx
	mov	[ebx],ax

	movzx	edi,cl
	mov	al,palmap_t[edi]
	inc	cl
	movzx	edi,cl
	mov	dl,palmap_t[edi]
	mov	palmap_t[edi],al
	dec	cl
	movzx	edi,cl
	mov	palmap_t[edi],dl

	mov	edi,1			;Set exchange flag

nxt:	inc	cl
strt:	cmp	cl,palblastc
	jne	lp2

	TST	edi
	jnz	lp			;Any exchanges?

x:
	ret


 SUBEND


;********************************
;* Adjust RGB values of range
;* AX=Gadget ID
;* Trashes all non seg

 SUBRP	palblk_adjrgb

	mov	bl,1			;+1
	test	al,1
	jz	@F
	neg	bl			;-1
@@:
	test	mousebut,2		;R but
	jz	@F
	shl	bl,2			;*4
@@:
	mov	cl,10			;R
	cmp	al,44h
	jb	@F
	mov	cl,5			;G
@@:
	cmp	al,48h
	jb	@F
	CLR	cl			;B
@@:
	mov	al,palb1stc
	dec	al

lp:	inc	al
	push	eax

	movzx	esi,al
	add	esi,esi			;*2
	add	esi,offset pal_t
	mov	ax,[esi]
	shr	ax,cl
	and	al,1fh
	add	al,bl
	cmp	al,1fh
	jle	@F			;Max ok?
	mov	al,1fh
@@:	TST	al
	jge	@F			;Min ok?
	CLR	al
@@:
	mov	dx,[esi]
	ror	dx,cl
	and	dx,0ffe0h
	or	dl,al
	rol	dx,cl
	mov	[esi],dx

	pop	eax

	cmp	al,palblastc
	jne	lp


	ret

 SUBEND


;********************************
;* Move color in palette
;* AX=Gadget ID
;* Trashes all non seg

 SUBRP	palblk_movecolor

	movzx	eax,palb1stc
	mov	cl,palblastc
	test	mousebut,2		;R but
	jz	@F
	movzx	eax,palblastc
	mov	cl,palb1stc
@@:

	mov	dx,pal_t[eax*2]
	mov	temp,dx
	mov	dl,palmap_t[eax]
	mov	BPTR temp2,dl
lp:
	movzx	esi,ax
	add	esi,esi			;*2
	add	esi,offset pal_t
	mov	dx,2[esi]
	mov	[esi],dx
	mov	dl,palmap_t+1[eax]
	mov	palmap_t[eax],dl

	inc	al
	jnz	lp


	CLR	eax
	jmp	istrt
ilp:
	movzx	esi,ax
	add	esi,esi			;*2
	add	esi,offset pal_t
	mov	dx,(-2)[esi]
	mov	[esi],dx
	mov	dl,(palmap_t-1)[eax]
	mov	palmap_t[eax],dl
istrt:
	dec	al
	cmp	al,cl
	jne	ilp


	mov	dx,temp
	mov	pal_t[eax*2],dx
	mov	dl,BPTR temp2
	mov	palmap_t[eax],dl


	ret

 SUBEND



;********************************
;* Dump pal_t to VGA palette registers
;* Trashes all non seg

 SUBR	palblk_setvgapal

	call	vid_initvgapal

	CLR	al				;DAC color reg 0
	mov	cx,252
	cmp	palblastuc,cl
	jbe	@F
	cmp	palbtruc,0
	je	@F				;Leave OS colors?
	mov	cl,palblastuc
	inc	cx
@@:
	mov	esi,offset pal_t
	call	vid_setvgapal15

	if	SLAVE
	call	palblk_setslavepal
	endif

	ret

 SUBEND



	if	1
;	if	SLAVE

;********************************
;* Dump pal_t to slave palette registers
;* Trashes all non seg

 SUBRP	palblk_setslavepal

	mov	eax,1a80080h		;DMACONST
	call	host_setaddr

	mov	dx,280h
	CLR	eax
	out	dx,ax

	mov	eax,1800000h
	call	host_setaddr

	mov	dx,280h
	mov	cx,256			;# colors
	mov	esi,offset pal_t

@@:	lodsw
	out	dx,ax			;Send data
	dec	cx
	jnz	@B

	ret
 SUBEND


;********************************
;* Init slave development system
;* Trashes all non seg

 SUBRP	host_initslave

	mov	eax,0c0000000h
	call	host_setaddr

	mov	dx,280h
	mov	esi,offset gspioinit_t

	mov	cx,12
	cld
@@:	lodsw
	out	dx,ax
	loopw	@B

	mov	eax,0c0000110h
	call	host_setaddr

	mov	cx,11
@@:	lodsw
	out	dx,ax
	loopw	@B

	ret
 SUBEND


	.data
gspioinit_t\
	word	15h		;>C0000000 -- HESYNC
	word	32h ;HEBLNKINIT	;>C0000010 -- HEBLNK
	word	0fah		;>C0000020 -- HSBLNK
	word	0fch		;>C0000030 -- HTOTAL
	word	3		;>C0000040 -- VESYNC
	word	20		;>C0000050 -- VEBLNK
	word	274		;>C0000060 -- VSBLNK	;254 lines
	word	288		;>C0000070 -- VTOTAL
	word	0f010h		;>C0000080 -- DPYCTL	ENV|NIL|DXV|SRE|>10
	word	-4		;>C0000090 -- DPYSTRT
	word	274	;EOSINT	;>C00000A0 -- DPYINT 
	word	2ch		;>C00000B0 -- CONTROL

	word	0		;>C0000110 -- INTENBL
	word	0		;>C0000120 -- INTPEND
	word	0		;>C0000130 -- CONVSP
	word	0		;>C0000140 -- CONVDP
	word	8 ;PXSIZE	;>C0000150 -- PSIZE
	word	0		;>C0000160 -- PMASK
	word	0		;>C0000170 -- RESERVED
	word	0		;>C0000180 -- RESERVED
	word	0		;>C0000190 -- RESERVED
	word	0		;>C00001A0 -- RESERVED
	word	28		;>C00001B0 -- DPYTAP

	.code


;********************************
;* Set host port address
;* EAX=Ptr
;* Trashes AX

 SUBRP	host_setaddr

	push	edx
	push	eax

	mov	al,98h			;HLT+INCR+INCW
	mov	dx,1281h
	out	dx,al

	pop	eax

	mov	dx,2280h		;ADRL
	out	dx,ax

	mov	dx,3280h		;ADRH
	shr	eax,16
	out	dx,ax

	pop	edx
	ret
 SUBEND


;********************************
;* Dump slave mem to file as hex
;* Trashes all non seg

	.data
tempt_s	db	"TEMP.TXT",0

 SUBRP	host_dumpslavemem

	mov	eax,1000000h		;Scratch
	call	host_setaddr


	CLR	ecx			;>Create file
	mov	edx,offset tempt_s
	I21CREATE
	jc	x
	mov	bx,ax			;BX=File handle

	mov	cx,128*2
	mov	temp,0
lp:
	push	ecx

	push	ebx

	mov	dx,280h
	in	ax,dx
	mov	bx,0ffh
	mov	cx,0
	mov	dx,temp
	add	temp,8
	and	dx,1fh*8
	call	prt_hexword

	pop	ebx

	mov	esi,offset prtbuf_s
	mov	WPTR 4[esi],0a0dh

	mov	cx,6
	mov	edx,esi
	I21WRITE
	pop	ecx
	jc	err

	loopw	lp

err:
	I21CLOSE

x:
	ret

 SUBEND



	endif





;********************************
;* Set host port address
;* Trashes 

;+0 = 8 Data bits
;+1 = Status 6543210
;	     ||||||Unused
;	     |||||Unused
;	     ||||Unused
;	     |||In from VUnit ctrl line 1
;	     ||Unused
;	     |Unused
;	     In from VUnit ctrl line 2 (Interrupts pc if enabled)

;+2 = Ctrl 543210
;	   |||||Unused
;	   ||||Out to VUNIT interrupt
;	   |||Unused
;	   ||Out to VUNIT ctrl line 0
;	   |1=Enable pc parallel interrupt
;	   Data direction (1=In)



; SUBRP	vcom_test
;
;	push	edx
;
;
;	CLR	eax
;	mov	es,ax
;	mov	dx,[408]
;
;	add	dx,2
;	mov	al,0
;	out	dx,al
;
;
;
;	pop	edx
;	ret
; SUBEND







;********************************
;* Load and display help info
;* Trashes all non seg

X=10
Y=5

 SUBRP	help_main


	call	vid_initvgapal


	mov	ax,620
	mov	bx,380
	mov	cx,X
	mov	dx,Y
	call	box_drawshaded


	mov	edx,offset helpfile_s		;>Open read only
	INT21X	3d00h
	jc	xx

	mov	ebx,eax				;EBX=File handle
	push	ebx




	mov	ecx,80*50			;# bytes
	mov	edx,offset buf
	INT21	3fh				;Read
	jc	x				;Error?



	mov	ebx,offset buf
	add	ebx,eax				;# read

	mov	BPTR [ebx],0			;Null at end

	mov	dx,Y+8				;DX=Ypos
	mov	edi,offset buf

lp:						;>Prt info
	mov	esi,offset prtbuf_s

scan:	mov	al,[edi]			;>Copy a line
	inc	edi
	TST	al
	jz	pause				;End?
	cmp	al,0dh
	je	endl				;End of line?
	mov	[esi],al
	inc	esi
	jmp	scan

endl:	mov	BPTR [esi],0
	inc	edi				;Skip LF

	mov	esi,offset prtbuf_s
	mov	bx,0fdffh
	mov	cx,X+16
	push	edi
	call	prt
	pop	edi
	add	dx,9

	jmp	lp


pause:
	call	waiton_keyormouse


x:
;	mov	ax,ilselected			;Fixes img buffer
;	call	ilst_select


	pop	ebx				;>Close file
	INT21	3eh

xx:
	call	main_draw

	ret


 SUBEND



;********************************
;* Load config file
;* Trashes all non seg

 SUBRP	cfg_load

	call	cfg_init

	lea	edx,cfgfile_s
	I21OPENR
	jc	x

	mov	ebx,eax				;EBX=File handle
	push	ebx


	mov	ecx,sizeof cfgstruc
	lea	edx,cfgstruc
	I21READ
	jc	err				;Error?
	cmp	eax,ecx
	jne	err

	lea	edx,cfgstruc
	cmp	[edx].CFG.VER,CFGVER
	jne	err

	jmp	ok

err:
	call	cfg_init
ok:
	pop	ebx
	I21CLOSE

x:
	ret

 SUBEND

;********************************
;* Init cfgstruc

 SUBRP	cfg_init

	lea	eax,cfgstruc
	mov	edx,eax
	mov	ecx,sizeof cfgstruc
	call	mem_clr

	mov	[edx].CFG.IWCX,160
	mov	[edx].CFG.IWCY,100

	ret
 SUBEND


;********************************
;* Save config file
;* Trashes all non seg

 SUBRP	cfg_save

	CLR	ecx
	lea	edx,cfgfile_s
	I21CREATE
	jc	x

	mov	ebx,eax				;BX=File handle
	push	ebx

	call	imgmode_setcfg

	mov	cfgstruc.VER,CFGVER

	mov	ecx,sizeof cfgstruc
	lea	edx,cfgstruc
	I21WRITE
;	jc	err				;Error?
;
;err:
	pop	ebx				;>Close file
	I21CLOSE

x:
	ret

 SUBEND


;********************************
;* Rename file to backup name
;* EAX = *Filename
;*>NZ = Error
;* Trashes none

 SUBRP	file_renamebkup

	local	t_s[80]:byte,
		fn_p:dword

	pushad

	mov	fn_p,eax

	lea	edi,t_s
	call	strcpy

	mov	al,'.'			;Make ext .~xx or .~ if none
	lea	edi,t_s
	call	strsrch
	jnz	@F			;Found?
	mov	BPTR [edi+2],0
@@:
	mov	WPTR [edi],'~.'


	lea	edx,t_s
	I21DELETE
;	jc	err

	mov	edx,fn_p
	lea	edi,t_s
	I21RENAME
	jnc	ok			;Rename ok?
	cmp	ax,2			;File not found
	jb	err
	cmp	ax,3			;Path not found
	ja	err
ok:
	CLR	eax
	jmp	x

err:
	CLR	eax
	inc	eax

x:
	TST	eax
	popad
	ret

 SUBEND



;****************************************************************
;* Open file requester
;* EAX=* fmatch_s
;* EBX=* code to run when OK gad is hit or 0
;* ESI=* title_s
;* fmode is B1=Dbl click on, B0=don't use fname_s
;* Trashes all non seg except EBP

 SUBR	filereq_open


	mov	fmatch_gad.TXT_p,eax
	mov	fokcode_p,ebx

	mov	filer_gad.TXT_p,esi		;>Open requester
	mov	gadlst_p,offset filer_gad
	mov	gadfunc_p,offset filer_gadf

	call	vid_initvgapal

	mov	ax,520
	mov	bx,345
	mov	cx,FILERX
	mov	dx,FILERY
	call	box_drawshaded


	test	fmode,1
	jnz	nofn				;Don't copy?

	mov	eax,offset fname_s		;>Copy fname to temp
	mov	edi,offset fnametmp_s
	mov	ecx,13
	call	strcpylen
nofn:

	call	dir_scan
	call	dir_prt

	call	gad_drawall
	jmp	drawmouse		;I'm leaving ret address on stack


 SUBEND


;********************************
;* File requester keys
;* AX=Key code

 SUBRP	filereq_key

	mov	bl,al
	CLR	eax				;0=OK
	cmp	bl,13
	je	filereq_gads

	inc	eax				;1=Forget it
	cmp	bl,27
	je	filereq_gads

	mov	al,20h				;Parent (BkSpc)
	cmp	bl,8
	je	filereq_gads

	mov	al,38h				;Select all (a)
	cmp	bl,'a'
	je	filereq_gads

	ret

 SUBEND


;********************************
;* File requester gadget hit
;* AX=Gadget ID
;* CX=X top left offset from gad
;* DX=Y ^
;* Trashes all non seg

 SUBRP	filereq_gads

	call	gadstr_close

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	TST	al				;>OK
	jnz	n0
doneok:
	test	fmode,1
	jnz	nofn				;Don't copy?

	mov	eax,offset fnametmp_s		;>Copy new fname
	mov	edi,offset fname_s
	call	strcpy
nofn:
	mov	fmode,0
	call	main_draw
	cmp	fokcode_p,0
	je	@F
	call	[fokcode_p]
@@:
	pop	esi				;Remove ret address
	CLR	eax				;EAX=0 (CC)
	ret

n0:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,1				;>Forget it
	jne	n1

	mov	fmode,0
	call	main_draw

	pop	esi				;Remove ret address
	CLR	eax
	inc	eax				;EAX=1 (CC)
	ret
n1:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Delete files

	cmp	al,2
	jne	n2

	CLR	al
	mov	esi,offset rusure_s
	call	msgbox_open
	jnz	x

	jmp	@F
dlp:
	mov	edx,eax
	I21DELETE
@@:
	call	filereq_getnxtmrkd
	jnz	dlp


	jmp	reload
n2:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,18h				;>File names window
	jne	gad5

	call	filereq_select
	jl	reload				;New dir?
	jz	x				;Null choice?

	dec	al
	jnz	doneok				;Double click?

	call	dir_prt
	mov	esi,offset fname_gad		;Update
	call	gad_draw
	jmp	x

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

gad5:	cmp	al,20h				;>Parent
	jne	gad6

	mov	esi,offset fpath_s-1		;>Find end
@@:	inc	esi
	mov	al,[esi]
	TST	al
	jnz	@B

@@:	cmp	esi,offset fpath_s
	je	at1st
	dec	esi
	mov	al,[esi]
	cmp	al,'\'
	jne	@B
at1st:
	CLR	eax
	mov	[esi],ax
	mov	BPTR [fpath_s+2],'\'
reload:
	call	dir_scan
	call	dir_prt
	call	gad_drawall
	jmp	x

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

gad6:	cmp	al,28h				;>Path or match name
	jne	gad7
	jmp	reload

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

gad7:	cmp	al,30h				;>Up
	jne	gad8
	mov	ax,f1stprt
	sub	ax,29*4				;Page up
	jge	@F
	CLR	eax
@@:	mov	f1stprt,ax
	call	dir_prt
	jmp	x

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

gad8:	cmp	al,31h				;>Dn
	jne	n31
	mov	bx,ftotal
	sub	bx,29*4
	jle	x				;!Enough for 2nd page?
	mov	ax,f1stprt
	add	ax,29*4
	cmp	ax,bx
	jle	@F
	mov	ax,bx
@@:	mov	f1stprt,ax
	call	dir_prt
	jmp	x
n31:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Select all

	cmp	al,38h
	jne	n38

	CLR	ebx
selalp:
	cmp	bx,ftotal
	jae	@F				;End?

	mov	eax,fptr_t[ebx*4]
	inc	ebx

	or	BPTR [eax],80h
	jmp	selalp
@@:
	call	dir_prt
	jmp	x
n38:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Drive select

	cmp	al,80h
	jne	n80

	mov	edx,[esi].GAD.TXT_p
	mov	eax,'\: '
	mov	al,[edx]
	mov	DPTR fpath_s,eax
	jmp	reload
n80:


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

x:
	ret


 SUBEND

;********************************
;* Set path_s from enviroment define
;* AX=Gadget ID
;* Trashes all non seg

 SUBRP	filereq_envtopath

	lea	edx,_imgenv_s
	TST	al
	jz	@F
	lea	edx,_tgaenv_s
	dec	al
	jz	@F
	lea	edx,_mdlenv_s
	dec	al
	jz	@F
	lea	edx,_usr1env_s
	dec	al
	jz	@F
	lea	edx,_usr2env_s
	dec	al
	jz	@F
	lea	edx,_usr3env_s
@@:
	mov	eax,edx
	cmp	BPTR [eax],0
	je	x			;Null string?
	lea	edi,fpath_s
	call	strcpy

	cmp	BPTR [edi-1],'\'
	jne	@F
	mov	BPTR [edi-1],0		;Fix end
@@:
	call	dir_scan
	call	dir_prt
	call	gad_drawall

x:
	ret

 SUBEND


;********************************
;* Set fmatch_s from gadget
;* AX  = Gadget ID
;* ESI = *gadget
;* Trashes all non seg

 SUBRP	filereq_setfmatch

	mov	eax,[esi].GAD.TXT_p
	mov	edi,fmatch_gad.TXT_p
	mov	WPTR [edi],'.*'
	add	edi,2
	call	strcpy

	call	dir_scan
	call	dir_prt
	jmp	gad_drawall

 SUBEND



;********************************
;* Scan contents of a directory

 SUBRP	dir_scan

	PUSHMR	eax,ebx,ecx,edx

	CLR	eax
	dec	eax
	mov	fnxtmrkd,eax			;-1

						;>Set DTA
	mov	ah,1ah
	mov	edx,offset dta
	int	21h

	CLR	eax
	mov	DPTR [fptr_t],eax
	mov	ftotal,ax
	mov	f1stprt,ax
	mov	fselected,-1

	lea	eax,fpath_s
	cmp	BPTR 1[eax],':'
	jne	nodrv
	mov	dl,[eax]
	cmp	dl,'a'
	jb	@F
	sub	dl,'a'-'A'
@@:
	sub	dl,'A'
	I21SETDRV
nodrv:

	lea	edx,fpath_s
	I21SETCD
	jc	x				;Error?


	mov	ah,4eh				;>Find 1st dir
	mov	cx,10h				;Dir bit
	mov	edx,offset dirmatch_s
	int	21h
	mov	edx,offset fentry_t
	jc	nodir				;No match?


dsclp:	test	BPTR [dta+21],10h		;Dir bit
	jz	dnext				;Not a dir?
	cmp	BPTR [dta+30],'.'
	je	dnext

dndot:	mov	edi,offset fptr_t-4
dscnxt:	add	edi,4
	mov	ebx,[edi]			;Get *
	TST	ebx
	jz	dset				;End?

	mov	esi,offset dta+30-1		;>Compare names
dcmplp:	inc	esi
	inc	ebx
	mov	al,[esi]
	mov	ah,[ebx]
	cmp	al,ah
	je	dcmplp
	ja	dscnxt				;Higher char?

dset:	call	dir_insert

dnext:	mov	ah,4fh				;>Find next
	int	21h
	jnc	dsclp


nodir:
	push	edx
	mov	ah,4eh				;>Find 1st file
	CLR	ecx				;Only files
	mov	edx,fmatch_gad.TXT_p
	int	21h
	pop	edx
	jc	nofile				;No match?


sclp:	mov	edi,offset fptr_t-4

scnxt:	add	edi,4
	mov	ebx,[edi]
	TST	ebx
	jz	set				;End?
	test	BPTR [ebx],10h			;Dir bit
	jnz	scnxt				;Dir?

	mov	esi,offset dta+30-1		;>Compare names
cmplp:	inc	esi
	inc	ebx
	mov	al,[esi]
	mov	ah,[ebx]
	cmp	al,ah
	je	cmplp
	ja	scnxt				;Higher char?

set:	call	dir_insert

	mov	ah,4fh				;>Find next
	int	21h
	jnc	sclp


nofile:
x:
	POPMR
	ret

 SUBEND



;********************************
;* Insert entry into dir entry table
;* EDX=* fentry_t
;* EDI=* fptr_t

 SUBRP	dir_insert

	cmp	ftotal,FEMAX
	jae	x				;Full?

	inc	ftotal

	mov	ebx,edx				;>Insert *
inslp:	mov	eax,[edi]
	mov	[edi],edx
	add	edi,4
	mov	edx,eax
	TST	edx
	jnz	inslp				;!End?
	mov	[edi],edx
	mov	edx,ebx

	mov	al,[dta+21]
	and	al,7fh				;Clr mark bit
	mov	[ebx],al

	mov	esi,offset dta+30-1		;>Copy name
cpylp:	inc	esi
	inc	ebx
	mov	al,[esi]
	mov	[ebx],al
	TST	al
	jnz	cpylp

	add	edx,sizeof FENTRY
x:
	ret

 SUBEND


;********************************
;* Print directory entry table

 SUBRP	dir_prt

	PUSHMR	eax,ebx,ecx,edx

	mov	esi,offset frfwin_box	;Draw box over file window
	mov	cx,FILERFX-2
	mov	dx,FILERFY-2
	call	box_drawmany


	mov	cx,FILERFX
	mov	dx,FILERFY
	mov	ax,f1stprt		;AX=Entry #
	movzx	edi,ax
	shl	edi,2			;*4
	add	edi,offset fptr_t
	jmp	next

prtlp:
	mov	bx,0fdffh
	cmp	ax,fselected
	jne	@F			;!Selected?
	mov	bx,0fcfeh
@@:
	test	BPTR [esi],80h
	jz	@F			;!Marked?
	mov	bx,0fdfeh
@@:
	test	BPTR [esi],10h
	jz	notdir			;File?
	mov	bh,0feh
notdir:
	add	esi,FENTRY.N_s
	push	eax
	push	edi
	call	prt
	pop	edi
	pop	eax

	inc	ax
	add	edi,4

	add	dx,9				;Next Y
	cmp	dx,FILERFY+29*9
	jb	yok
	add	cx,14*8				;Top of next column
	mov	dx,FILERFY
	cmp	cx,FILERFX+4*14*8
	jae	x				;Out of space?
yok:
next:	mov	esi,[edi]
	TST	esi
	jnz	prtlp


x:
	POPMR
	ret

 SUBEND



;********************************
;* Select item from directory entry table
;* CX=X top left offset from gad
;* DX=Y ^
;* >AL=-1/0/1/2 (dir/none/file/file dbl click)

 SUBRP	filereq_select

	PUSHMR	ebx,ecx,edx


	mov	ax,cx
	mov	bl,14*8
	div	bl
	mov	bl,29			;*Entries per column
	mul	bl
	mov	cx,ax

	mov	ax,dx
	mov	bl,9
	div	bl
	CLR	ah
	add	ax,cx
	add	ax,f1stprt


	mov	bx,fselected

	mov	fselected,-1
	CLR	cl
	cmp	ax,ftotal
	jae	x

	mov	fselected,ax

	test	mousebchg,2
	jnz	@F			;Toggle?

	cmp	ax,bx
	jne	@F			;!Same as before?

	test	mousebchg,1
	jz	x			;No change?

	test	fmode,2			;Chk double click mode
	jz	x			;Off?

	mov	cl,2
	jmp	x

@@:
	mov	cl,1

	movzx	esi,ax
	mov	esi,fptr_t[esi*4]


	mov	edi,offset fnametmp_s-1
	test	BPTR [esi],10h
	jz	file

	mov	fselected,-1
	mov	cl,-1

	mov	edi,offset fpath_s-1	;>Find end of path_s
srchlp:	inc	edi
	mov	al,[edi]
	TST	al
	jnz	srchlp
	mov	BPTR [edi],'\'
	cmp	BPTR [edi-1],'\'
	jne	cpylp
	dec	edi
	jmp	cpylp

file:
	test	mousebut,2
	jz	cpylp
	xor	BPTR [esi],80h		;Toggle mark
	jmp	x

cpylp:	inc	esi			;>Copy name
	inc	edi
	mov	al,[esi]
	mov	[edi],al
	TST	al
	jnz	cpylp


x:	mov	al,cl
	TST	al			;Set flags
	POPMR
	ret

 SUBEND


;********************************
;* Get filename of selected or next marked item in directory entry table
;*>EAX = *filename or 0 (CC)
;* Trashes out

 SUBRP	filereq_getnxtmrkd

	PUSHMR	ebx


	mov	ebx,fnxtmrkd		;Starting #
	TST	ebx
	jge	lp			;Doing marks?

	CLR	ebx

	movsx	eax,fselected
	TST	eax
	jl	lp			;None?

	mov	eax,fptr_t[eax*4]
	test	BPTR [eax],80h
	jz	fnd			;!Marked?

lp:
	CLR	eax
	cmp	bx,ftotal
	jae	x			;End?

	mov	eax,fptr_t[ebx*4]
	inc	ebx

	test	BPTR [eax],80h
	jz	lp			;!Marked?

fnd:
	mov	fnxtmrkd,ebx

	lea	eax,[eax].FENTRY.N_s

x:
	TST	eax			;Set flags
	POPMR
	ret

 SUBEND



;********************************
;* Open the info message box. Returns to main loop
;* AL=!0 show only OK gadget
;* ESI=* text
;* Trashes none

 SUBRP	msgbox_open

	pushad

	mov	msgbox_gad.NEXT_p,0
	TST	al
	jnz	@F
	mov	msgbox_gad.NEXT_p,offset msgbox_gad+sizeof GAD	;`Forget it!'
@@:
	push	esi
	mov	ax,MSGBOXW
	mov	bx,50			;H
	mov	cx,MSGBOXX
	mov	dx,MSGBOXY
	call	box_drawshaded
	pop	esi

	push	esi			;>Prt string centered
	add	cx,MSGBOXW/2+4
	cld
lp:	lodsb
	sub	cx,4			;-half witdh
	TST	al
	jnz	lp

	pop	esi
	mov	bx,0feffh
	add	dx,20
	call	prt

	mov	eax,gadlst_p		;Save gad ptrs
	mov	gadlastlst_p,eax
	mov	gadlst_p,offset msgbox_gad

	mov	eax,gadfunc_p
	mov	gadlastfunc_p,eax
	mov	gadfunc_p,offset msgbox_gadf

	call	gad_drawall
	jmp	drawmouse		;I'm leaving ret address on stack


 SUBEND


;********************************
;* Message box keys
;* AX=Key code

 SUBRP	msgbox_key

	mov	bl,al
	CLR	eax
	cmp	bl,13
	je	@F
	inc	eax
@@:

;Fall through

 SUBEND


;********************************
;* Message box gadgets. Jumps to creator
;* AX=Gadget ID

 SUBRP	msgbox_gads

	pop	esi			;Remove ret address

	mov	esi,gadlastlst_p
	mov	gadlst_p,esi

	mov	esi,gadlastfunc_p
	mov	gadfunc_p,esi

	TST	al			;Pass Z

	popad
	ret				;Pass AL (0=OK, !0=Forget it)

 SUBEND



;****************************************************************
;* Open data entry box
;* EAX = * Entry box table
;* Trashes all non seg

 SUBR	entrybox_open

;	call	vid_initvgapal

	cld
	mov	esi,eax

	lodsd
	mov	gadlst_p,eax
	lodsd
	mov	eboxgadcode_p,eax


	lodsd
	push	eax			;*XY str

	lodsw
	mov	ecx,eax			;X
	lodsw
	mov	edx,eax			;Y
	lodsw
	mov	ebx,eax			;W
	lodsw
	xchg	eax,ebx
	call	box_drawshaded

	mov	gadfunc_p,offset ebox_gadf

	call	gad_drawall

	pop	eax
	call	prt_xystr

	jmp	drawmouse		;I'm leaving ret address on stack


 SUBEND

	.data
ebox_gadf\
	dd	entrybox_gads



;********************************
;* File requester keys
;* AX=Key code

; SUBRP	filereq_key
;
;	mov	bl,al
;	CLR	eax				;0=OK
;	cmp	bl,13
;	je	filereq_main
;
;	inc	eax				;1=Forget it
;	cmp	bl,27
;	je	filereq_main
;
;	mov	al,20h				;Parent (BkSpc)
;	cmp	bl,8
;	je	filereq_main
;
;	mov	al,38h				;Select all (a)
;	cmp	bl,'a'
;	je	filereq_main
;
;	ret
;
; SUBEND


;********************************
;* Entry box gadget hit
;* AX  = Gadget ID
;* ECX = X top left offset from gad
;* EDX = Y ^
;* Trashes all non seg

 SUBRP	entrybox_gads

	call	gadstr_close

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	TST	al				;>OK
	jnz	n0
doneok:
	call	main_draw
	pop	esi				;Remove ret address
	CLR	eax				;EAX=0 (CC)
	ret

n0:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,1				;>Forget it
	jne	n1

	mov	fmode,0
	call	main_draw

	pop	esi				;Remove ret address
	CLR	eax
	inc	eax				;EAX=1 (CC)
	ret
n1:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Delete files

;	cmp	al,2
;	jne	n2
;
;n2:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	eboxgadcode_p,0
	je	@F
	call	[eboxgadcode_p]
@@:

x:
	ret

 SUBEND


;********************************
;* Wait for a key or mouse button
;* Trashes none

 SUBRP	waiton_keyormouse

	pushad

mlp:	mov	ax,3				;>Read mouse
	int	33h
	and	bl,3
	jnz	mlp				;Button down?

klp:	mov	ah,11h				;>Empty keyboard buffer
	int	16h
	jz	wt				;Empty?
	mov	ah,10h				;>Get key
	int	16h
	jmp	klp


wt:	mov	ax,3				;>Read mouse
	int	33h
	and	bl,3
	jnz	xlp				;Button down?

	mov	ah,11h				;>Chk for key
	int	16h
	jz	wt				;Empty?
	mov	ah,10h				;>Get key
	int	16h


xlp:	mov	ax,3				;>Read mouse
	int	33h
	and	bl,3
	jnz	xlp				;Button down?

	popad
	ret

 SUBEND



;********************************
;* Ctrl-break handler (int 23h)

 SUBRP	handler_ctrlbrk

;	pushad
;
;	mov	al,182
;	out	43h,al
;
;	mov	ax,1046		;Frequency
;	out	42h,al
;	mov	ah,al
;	out	42h,al
;
;	in	al,61h
;	or	al,3
;	out	61h,al
;
;	sti
;
;	mov	ax,40h
;	mov	ds,ax
;	mov	cx,18
;lp2:	mov	bx,ds:[6ch]
;lp:	mov	dx,ds:[6ch]
;	cmp	dx,bx
;	je	lp
;	loopw	lp2
;
;	in	al,61h
;	and	al,0fch
;	out	61h,al
;
;	popad
	iret

 SUBEND


;********************************
;* Critical error handler (int 24h)

 SUBRP	handler_cerror

	mov	al,3		;End function with an error

	iret

 SUBEND



;****************************************************************
;* C like string functions
;****************************************************************

;********************************
;* Copy an ASCII string
;* EAX=* source
;* EDI=* dest
;* >EDI=* dest NULL
;* Trashes EAX,EDI

 SUBRP	strcpy

	push	esi

	mov	esi,eax
lp:
	mov	al,[esi]
	mov	[edi],al
	inc	esi
	inc	edi
	TST	al
	jnz	lp			;More?

	dec	edi

	pop	esi
	ret
 SUBEND


;********************************
;* Copy an ASCII string within max length
;* EAX=* source
;* ECX=Max length
;* EDI=* dest
;* >EDI=* NULL or dest next char
;* Trashes EAX,ECX,EDI

 SUBRP	strcpylen

	PUSHMR	esi

	mov	esi,eax
lp:
	mov	al,[esi]
	mov	[edi],al
	TST	al
	jz	x			;Null?
	inc	esi
	inc	edi
	loop	lp
x:
	POPMR
	ret
 SUBEND


;********************************
;* Search an ASCII string for a character (Case sensitive)
;* AL = Character
;* EDI= * string
;*>AH = Char or 0 if not found (CC)
;*>EDI= * char in string or * end null
;* Trashes out

 SUBRP	strsrch

	jmp	strt
lp:
	cmp	al,ah
	je	match

	inc	edi
strt:	mov	ah,[edi]
	TST	ah
	jnz	lp			;More?

match:
	TST	ah
	ret
 SUBEND


;********************************
;* Copy two ASCII strings to destination
;* EAX = * 1st source
;* EBX = * 2nd source
;* EDI = * dest
;*>EDI = * dest NULL
;* Trashes EAX,EDI

 SUBRP	strjoin

	call	strcpy
	mov	eax,ebx
	jmp	strcpy

 SUBEND

;********************************
;* Compare two ASCII strings
;* EAX = * source 1
;* EDI = * source 2
;*>Z if match
;* Trashes EAX,EDI

 SUBRP	strcmp

	push	esi

	mov	esi,eax
	jmp	strt
lp:
	inc	esi
	inc	edi
strt:	mov	al,[esi]
	cmp	[edi],al
	jne	x			;Mismatch?
	TST	al
	jnz	lp			;More?
x:
	pop	esi
	ret
 SUBEND


;********************************
;* Compare two ASCII strings within length
;* EAX = * source 1
;* ECX = Max length (0-?)
;* EDI = * source 2
;*>Z if match
;* Trashes EAX,EDI

 SUBRP	strncmp

	PUSHMR	esi

	mov	esi,eax
	jmp	strt
lp:
	inc	esi
	inc	edi
strt:
	dec	ecx
	jl	x

	mov	al,[esi]
	cmp	[edi],al
	jne	x			;Mismatch?
	TST	al
	jnz	lp			;More?
x:
	POPMR
	ret
 SUBEND


;********************************
;* Convert signed word (16 bit) # to ASCII string
;* AX  = #
;* EDI = * dest buf
;*>EDI = * dest NULL
;* Trashes EAX,EDI

 SUBRP	stritoa

	push	ebx
	push	ecx
	push	edx

	CLR	ecx			;ECX=Non zero flag

	TST	ax
	jns	pos
	neg	ax
	mov	BPTR [edi],'-'
	inc	edi
pos:

	mov	bx,10000
	cmp	ax,bx
	jb	b10000
	CLR	edx
	div	bx
	xchg	ax,dx
	add	dl,'0'
	mov	[edi],dl
	inc	edi
	inc	ecx
b10000:
	mov	bx,1000
	TST	ecx
	jnz	@F
	cmp	ax,bx
	jb	b1000
@@:	CLR	edx
	div	bx
	xchg	ax,dx
	add	dl,'0'
	mov	[edi],dl
	inc	edi
	inc	ecx
b1000:
	mov	bx,100
	TST	ecx
	jnz	@F
	cmp	ax,bx
	jb	b100
@@:	CLR	edx
	div	bx
	xchg	ax,dx
	add	dl,'0'
	mov	[edi],dl
	inc	edi
	inc	ecx
b100:
	mov	bx,10
	TST	ecx
	jnz	@F
	cmp	ax,bx
	jb	b10
@@:	CLR	edx
	div	bx
	add	al,'0'
	mov	[edi],al
	inc	edi
	mov	al,dl
b10:
	add	al,'0'
	CLR	ah
	mov	[edi],ax

	inc	edi

	pop	edx
	pop	ecx
	pop	ebx
	ret

 SUBEND



;********************************
;* Convert signed long (32 bit) # to ASCII string
;* EAX = # (Max 99999999)
;* EDI = * dest buf
;*>EDI = * dest NULL
;* Trashes EAX,EDI

 SUBRP	striltoa

	push	ebx
	push	ecx
	push	edx

	CLR	ecx			;ECX=Non zero flag

	TST	eax
	jns	pos
	neg	eax
	mov	BPTR [edi],'-'
	inc	edi
pos:

	mov	ebx,10000000
	TST	ecx
	jnz	@F
	cmp	eax,ebx
	jb	d8
@@:	CLR	edx
	div	ebx
	xchg	eax,edx
	add	dl,'0'
	mov	[edi],dl
	inc	edi
	inc	ecx
d8:
	mov	ebx,1000000
	TST	ecx
	jnz	@F
	cmp	eax,ebx
	jb	d7
@@:	CLR	edx
	div	ebx
	xchg	eax,edx
	add	dl,'0'
	mov	[edi],dl
	inc	edi
	inc	ecx
d7:
	mov	ebx,100000
	TST	ecx
	jnz	@F
	cmp	eax,ebx
	jb	d6
@@:	CLR	edx
	div	ebx
	xchg	eax,edx
	add	dl,'0'
	mov	[edi],dl
	inc	edi
	inc	ecx
d6:

	mov	ebx,10000
	TST	ecx
	jnz	@F
	cmp	eax,ebx
	jb	d5
@@:	CLR	edx
	div	ebx
	xchg	eax,edx
	add	dl,'0'
	mov	[edi],dl
	inc	edi
	inc	ecx
d5:
	mov	ebx,1000
	TST	ecx
	jnz	@F
	cmp	eax,ebx
	jb	d4
@@:	CLR	edx
	div	ebx
	xchg	eax,edx
	add	dl,'0'
	mov	[edi],dl
	inc	edi
	inc	ecx
d4:
	mov	ebx,100
	TST	ecx
	jnz	@F
	cmp	eax,ebx
	jb	d3
@@:	CLR	edx
	div	ebx
	xchg	eax,edx
	add	dl,'0'
	mov	[edi],dl
	inc	edi
	inc	ecx
d3:
	mov	ebx,10
	TST	ecx
	jnz	@F
	cmp	eax,ebx
	jb	d2
@@:	CLR	edx
	div	ebx
	add	al,'0'
	mov	[edi],al
	inc	edi
	mov	al,dl
d2:
	add	al,'0'
	CLR	ah
	mov	[edi],ax

	inc	edi

	pop	edx
	pop	ecx
	pop	ebx
	ret

 SUBEND


;********************************
;* Convert ASCII string to an integer (precede with 0x for hex)
;* EAX = *ASCII string
;*>EAX = #
;* Trashes EAX,EDI

 SUBRP	stratoi

	PUSHMR	ebx,ecx,edx,edi

	mov	edi,eax
	CLR	eax
	mov	ebx,10		;EBX=Radix
	CLR	ecx		;ECX=!0 if result neg
	CLR	edx
spclp:
	mov	dl,[edi]
	inc	edi
	cmp	dl,' '
	je	spclp
	jl	x		;End?
	cmp	dl,'0'
	je	spclp

	cmp	dl,'-'
	jne	@F		;!Minus?
	mov	ecx,edx		;Set flag
	jmp	spclp
@@:
	cmp	dl,'x'
	je	hex		;Hex indicator?
	cmp	dl,'X'
	jne	lp		;No hex?
hex:	add	ebx,6
	jmp	nxt

lp:
	cmp	dl,'a'
	jl	uc
	sub	dl,20h		;Make uppercase
uc:
	cmp	dl,'A'
	jl	notaf
	sub	dl,'A'-':'	;Bring down A-F
	jmp	@F
notaf:
	cmp	dl,'9'
	ja	set		;: to @ chars?
@@:
	sub	dl,'0'
	jl	set
	cmp	dl,15
	ja	set

	imul	eax,ebx		;* radix
	add	eax,edx
nxt:
	mov	dl,[edi]
	inc	edi
	jmp	lp

set:
	TST	ecx
	jz	x
	neg	eax

x:
	POPMR
	ret

 SUBEND




;********************************
;* Write ASCII string to file (excluding null)
;* EBX = File handle
;* EDX = *ASCII string
;*>CC from write
;* Trashes EAX,ECX

 SUBRP	strwrite

	PUSHMR	esi

	mov	esi,edx
	CLR	ecx			;ECX=Length
	dec	ecx
lp:
	inc	ecx
	mov	al,[esi]
	inc	esi
	TST	al
	jnz	lp			;More?

	I21WRITE

	POPMR
	ret

 SUBEND


;********************************
;* Add extension to file name string if none exists
;* EAX = *extension string (.xxx)
;* EDI = *ASCII string
;* Trashes EAX,EDI

 SUBRP	stradddefext

;	PUSHMR	e

	push	eax
	mov	al,'.'
	call	strsrch
	pop	eax
	jnz	x

	call	strcpy
x:
;	POPMR
	ret

 SUBEND


;********************************
;* Read 4 bytes from a file
;* EBX = File handle
;*>EAX = Value read
;*>C if error
;* Trashes out

 SUBRP	dos_read4

	PUSHMR	ecx,edx

	mov	ecx,4				;Read cnt
	lea	edx,tl1
	I21READ
	jc	err
	cmp	eax,ecx
	stc
	jne	err

	mov	eax,tl1
	clc
err:
	POPMR
	ret

 SUBEND


;********************************
;* Write 4 bytes to a file
;* EAX = Value to write
;* EBX = File handle
;*>C if error
;* Trashes out

 SUBRP	dos_write4

	PUSHMR	ecx,edx

	mov	ecx,4				;Read cnt
	lea	edx,tl1
	mov	[edx],eax
	I21WRITE
	jc	err
	cmp	eax,ecx
	stc
	jne	err

	clc
err:
	POPMR
	ret

 SUBEND



;****************************************************************
;* Graphics and windowing functions
;****************************************************************


;********************************
;* Draw cross hatch
;* BL=Color
;* CX=X1
;* DX=Y1
;* Trashes EAX,EDI

XS=20	;XY size
YS=20

 SUBRP	crossh_draw

	push	ebx
	push	ecx
	push	edx

	mov	prtcolors,bx
	movsx	ecx,cx
	movsx	edx,dx

	push	ecx
	mov	eax,ecx
	sub	ecx,XS
	add	eax,XS
	mov	linex2,eax
	mov	liney2,edx
	call	line_drawclip
	pop	ecx

	mov	eax,edx
	sub	edx,YS
	add	eax,YS
	mov	linex2,ecx
	mov	liney2,eax
	call	line_drawclip


	pop	edx
	pop	ecx
	pop	ebx

	ret

 SUBEND


;********************************
;* Draw sml cross hatch
;* BL=Color
;* CX=X1
;* DX=Y1
;* Trashes EAX,EDI

XS=10	;XY size
YS=10

 SUBRP	crossh_drawsml

	push	ebx
	push	ecx
	push	edx

	mov	prtcolors,bx
	movsx	ecx,cx
	movsx	edx,dx

	push	ecx
	mov	eax,ecx
	sub	ecx,XS
	add	eax,XS
	mov	linex2,eax
	mov	liney2,edx
	call	line_drawclip
	pop	ecx

	mov	eax,edx
	sub	edx,YS
	add	eax,YS
	mov	linex2,ecx
	mov	liney2,eax
	call	line_drawclip


	pop	edx
	pop	ecx
	pop	ebx

	ret

 SUBEND

;********************************
;* Draw a hollow box
;* EAX=X1
;* EBX=Y1
;* ECX=X2
;* EDX=Y2
;* Trashes EAX,EDI

 SUBRP	boxh_drawclip

	local	y1:dword,\
		x2:dword

	PUSHMR	ebx,ecx,edx

	mov	y1,ebx
	mov	x2,ecx

	mov	linex2,eax
	mov	liney2,ebx

	push	edx
	push	eax

	mov	edx,ebx
	call	line_drawclip		;Top line

	pop	ecx
	pop	edx
	call	line_drawclip		;Left line

	mov	eax,x2
	mov	linex2,eax
	mov	liney2,edx
	push	eax
	call	line_drawclip		;Bot line
	pop	ecx

	mov	edx,y1
	call	line_drawclip		;Rgt line

	POPMR
	ret

 SUBEND


;********************************
;* Draw a hollow box
;* EAX=X1
;* EBX=Y1
;* ECX=X2
;* EDX=Y2
;* Trashes EAX,EDI

 SUBRP	boxh_draw

	local	y1:dword,\
		x2:dword

	PUSHMR	ebx,ecx,edx

	mov	y1,ebx
	mov	x2,ecx

	mov	linex2,eax
	mov	liney2,ebx

	push	edx
	push	eax

	mov	edx,ebx
	call	line_draw		;Top line

	pop	ecx
	pop	edx
	call	line_draw		;Left line

	mov	eax,x2
	mov	linex2,eax
	mov	liney2,edx
	push	eax
	call	line_draw		;Bot line
	pop	ecx

	mov	edx,y1
	call	line_draw		;Rgt line

	POPMR
	ret

 SUBEND


;********************************
;* Draw a line
;* ECX=X1
;* EDX=Y1
;* Trashes EAX,EDI

FRAC=8

 SUBRP	line_drawclip

	PUSHMR	ebx,ecx,edx

	mov	linex1,ecx
	mov	liney1,edx

	sub	ecx,linex2
	mov	eax,ecx
	jg	@F			;Pos?
	neg	ecx

@@:	sub	edx,liney2
	mov	edi,edx
	jg	@F			;Pos?
	neg	edx

@@:	cmp	ecx,edx
	ja	cbig			;ECX bigger?
	mov	ecx,edx			;ECX=Pixel count
cbig:
	TST	ecx
	jz	@F

	shl	eax,FRAC
	cdq
	idiv	ecx
	mov	linexfrac,eax

	mov	eax,edi
	shl	eax,FRAC
	cdq
	idiv	ecx
	mov	lineyfrac,eax
@@:
	mov	ebx,linex1
	mov	eax,liney1
	shl	ebx,FRAC
	shl	eax,FRAC

	mov	dx,SC_INDEX

lp:	push	ecx
	push	eax

	mov	edi,ebx			;X
	sar	edi,2+FRAC		;/4
	cmp	edi,SCRWB
	jae	nxt
	sar	eax,FRAC
	cmp	ax,drawclipy
	jae	nxt
	imul	eax,WPTR SCRWB
	add	di,ax			;+Y
	mov	cl,bh
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	out	dx,ax

	mov	al,BPTR prtcolors	;Get color
	mov	0a0000h[edi],al
nxt:
	pop	eax
	pop	ecx

	sub	ebx,linexfrac
	sub	eax,lineyfrac

	dec	ecx
	jge	lp


	POPMR
	ret

 SUBEND



;********************************
;* Draw a line
;* ECX=X1
;* EDX=Y1
;* Trashes EAX,EDI

FRAC=8

 SUBRP	line_draw

	PUSHMR	ebx,ecx,edx,esi

	mov	linex1,ecx
	mov	liney1,edx

	sub	ecx,linex2
	mov	eax,ecx
	jg	@F			;Pos?
	neg	ecx

@@:	sub	edx,liney2
	mov	edi,edx
	jg	@F			;Pos?
	neg	edx

@@:	cmp	ecx,edx
	ja	cbig			;ECX bigger?
	mov	ecx,edx			;ECX=Pixel count
cbig:
	TST	ecx
	jz	@F

	shl	eax,FRAC
	cdq
	idiv	ecx
	mov	linexfrac,eax

	mov	eax,edi
	shl	eax,FRAC
	cdq
	idiv	ecx
	mov	lineyfrac,eax
@@:
	mov	ebx,linex1
	mov	eax,liney1
	shl	ebx,FRAC
	shl	eax,FRAC

	mov	dx,SC_INDEX

	mov	esi,ecx
lp:
	push	eax

	mov	edi,ebx			;X
	sar	edi,2+FRAC		;/4
	sar	eax,FRAC
	imul	eax,WPTR SCRWB
	add	edi,eax			;+Y
	mov	cl,bh
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	out	dx,ax

	mov	al,BPTR prtcolors	;Get color
	mov	0a0000h[edi],al

	pop	eax

	sub	ebx,linexfrac
	sub	eax,lineyfrac

	dec	esi
	jge	lp


	POPMR
	ret

 SUBEND


;********************************
;* Reset mouse range and position
;* Trashes none

 SUBR	mouse_reset

	pushad

	mov	ax,7			;Set X range
	CLR	ecx
	mov	dx,632*4
	int	33h

	mov	ax,8			;Set Y range
	CLR	ecx
	mov	dx,399*4
	int	33h

	mov	ax,4			;Move mouse
	mov	cx,mousex
	mov	dx,mousey
	shl	cx,2
	shl	dx,2
	int	33h

	popad
	ret

 SUBEND


;********************************
;* Draw mouse cursor
;* Trashes all non seg

 SUBRP	mouse_draw

	mov	esi,offset mouseptrbuf
	mov	bx,mousex

	mov	cx,8			;X cnt
lpx:	push	ecx

	movzx	edi,bx			;X
	shr	edi,2			;/4
	mov	ax,SCRWB		;DO ONCE??
	mul	mousey
	add	di,ax			;+Y
	mov	cl,bl
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	mov	dx,SC_INDEX
	out	dx,ax
	mov	al,GC_MAPSEL
	mov	ah,cl
	mov	dx,GC_INDEX
	out	dx,ax

	mov	cx,8			;Y cnt
lpy:
	mov	al,0a0000h[edi]
	mov	[esi],al
	mov	al,(8*8)[esi]
	TST	al
	jz	nowrt			;Don't write if 0
	mov	0a0000h[edi],al
nowrt:	add	esi,8
	add	di,SCRWB
	loopw	lpy

	sub	esi,8*8-1		;Top Y
	inc	bx			;Next X

	pop	ecx
	loopw	lpx


	ret


	.data
mouseptrbuf	db	8*8 dup (0)
mouseptrdata	db	255,0,0,0,0,0,0,0
		db	254,252,0,0,0,0,0,0
		db	254,255,252,0,0,0,0,0
		db	254,255,255,252,0,0,0,0
		db	254,255,255,255,252,0,0,0
		db	254,255,255,255,255,252,0,0
		db	254,255,255,255,255,255,252,0
		db	254,255,255,255,255,255,255,252
	.code


 SUBEND


;********************************
;* Erase mouse cursor
;* Trashes all non seg

 SUBRP	mouse_erase

	mov	esi,offset mouseptrbuf
	movzx	ebx,mousex

	mov	cx,8			;X cnt
lpx:	push	ecx

	mov	edi,ebx			;X
	shr	edi,2			;/4
	mov	ax,SCRWB		;DO ONCE??
	mul	mousey
	add	di,ax			;+Y
	mov	cl,bl
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	mov	dx,SC_INDEX
	out	dx,ax

	mov	ecx,8			;Y cnt
lpy:	mov	al,[esi]
	mov	0a0000h[edi],al
	add	esi,8
	add	di,SCRWB
	loop	lpy

	sub	esi,8*8-1		;Top Y
	inc	ebx			;Next X

	pop	ecx
	loopw	lpx


	ret


 SUBEND


;********************************
;* Draw all gadgets
;* Trashes esi,edi

 SUBR	gad_drawall

	push	eax
	push	ebx
	push	ecx
	push	edx
	mov	esi,offset gadlst_p
	jmp	start


lp:	push	esi

	mov	cx,[esi].GAD.X
	mov	dx,[esi].GAD.Y
	mov	esi,[esi].GAD.IMG_p
	TST	esi
	jz	noimg
	mov	ax,[esi]
	mov	bx,[esi+2]
	call	box_drawshaded
noimg:
	pop	esi
	push	esi
	mov	bx,253*256+255
	mov	cx,[esi].GAD.X
	mov	dx,[esi].GAD.Y
	mov	esi,[esi].GAD.TXT_p
	TST	esi
	jz	notxt
	add	cx,4
	add	dx,3
	call	prt
notxt:

	pop	esi
start:	mov	esi,[esi]			;Get * next
	TST	esi
	jnz	lp			;!End?


	pop	edx
	pop	ecx
	pop	ebx
	pop	eax

	ret

 SUBEND



;********************************
;* Draws a gadget
;* ESI = * gadget
;* Trashes ESI,EDI

 SUBRP	gad_draw

	push	eax
	push	ebx
	push	ecx
	push	edx

	push	esi
	mov	cx,[esi].GAD.X
	mov	dx,[esi].GAD.Y
	mov	esi,[esi].GAD.IMG_p
	TST	esi
	jz	noimg
	mov	ax,[esi]
	mov	bx,[esi+2]
	call	box_drawshaded
noimg:
	pop	esi
	mov	bx,253*256+255
	mov	cx,[esi].GAD.X
	mov	dx,[esi].GAD.Y
	mov	esi,[esi].GAD.TXT_p
	TST	esi
	jz	notxt
	add	cx,4
	add	dx,3
	call	prt
notxt:

	pop	edx
	pop	ecx
	pop	ebx
	pop	eax

	ret

 SUBEND


;********************************
;* Check gadgets for intersection with the mouse pointer
;*>AX  = ID or 0
;*>ECX = X top left offset from gad
;*>EDX = Y ^
;*>ESI = *Gadget or 0

 SUBRP	gad_chkmouse

	PUSHMR	ebx

	mov	esi,gadlst_p
	jmp	strt

lp:
	mov	cx,mousex
	sub	cx,[esi].GAD.X
	jl	next
	cmp	cx,[esi].GAD.W
	jge	next

	mov	dx,mousey
	sub	dx,[esi].GAD.Y
	jl	next
	mov	ax,[esi].GAD.ID
	cmp	dx,[esi].GAD.H
	jl	x			;Match?
next:
	mov	esi,[esi]		;Get * next
strt:
	TST	esi
	jnz	lp			;!End?

x:
	movsx	ecx,cx
	movsx	edx,dx

	POPMR
	ret

 SUBEND


;********************************
;* Adds a list of gadgets to the end of current gadlst
;* EAX=* 1st of new gad list
;* Trashes none

 SUBR	gad_add

	pushad

	mov	edi,offset gadlst_p

lp:	mov	esi,edi
	mov	edi,[esi]		;Get * next
	cmp	eax,edi
	je	x			;Error? Already on list
	TST	edi
	jnz	lp			;!End?

	mov	[esi],eax

x:	popad
	ret

 SUBEND



;********************************
;* Mouse scroller gadget
;* EAX=* code to call when mouse moves
;* CX=X scroll multiplier
;* DX=Y ^
;* EDI=*Data words to adjust
;* Trashes none

RNG=32000

 SUBR	gad_mousescroller

	pushad

	mov	mscrollcode_p,eax
					;Check shift keys
	test	BPTR ds:[417h],3
	jz	noshft			;None?
	TST	cx
	jz	@F
	sar	cx,2			;/4
	jnz	@F
	inc	cx
@@:	TST	dx
	jz	@F
	sar	dx,2
	jnz	@F
	inc	dx
@@:
noshft:
	movsx	ecx,cx
	movsx	edx,dx
	mov	mscrollxm,ecx
	mov	mscrollym,edx

	mov	ax,7			;Set X range
	CLR	ecx
	mov	dx,RNG
	int	33h
	mov	ax,8			;Set Y range
	int	33h

	mov	ax,4			;Move mouse
	mov	cx,RNG/2
	mov	dx,cx
	int	33h

	mov	ax,[edi]
	mov	mscrollx,ax
	mov	ax,2[edi]
	mov	mscrolly,ax

	jmp	strt

lp:
	sub	cx,RNG/2		;>Any changes?
	sub	dx,RNG/2
	movsx	ecx,cx
	movsx	edx,dx
	imul	ecx,mscrollxm
	imul	edx,mscrollym
	sar	ecx,8			;/256
	sar	edx,8

	add	cx,mscrollx
	add	dx,mscrolly
	cmp	cx,[edi]
	jne	mv
	cmp	dx,2[edi]
	je	nomv
mv:
	mov	[edi],cx
	cmp	mscrollym,0
	jz	@F			;Off?
	mov	2[edi],dx
@@:
strt:	push	edi
	call	[mscrollcode_p]		;Pass none
	pop	edi
nomv:
	mov	ax,3			;>Read mouse
	int	33h
	and	bl,1
	jnz	lp			;But 1 down?


	call	mouse_reset

	popad
	ret


 SUBEND




;********************************
;* Open box and get a string from user
;* EAX=Max string length (not counting null)
;* EDI=* string
;* >Pass Z (0=OK, !0=Aborted)
;* Trashes none

	BSSD	strboxstack_p		;* stack on entry
X=320
Y=200
ID=0

 SUBRP	strbox_open

	pushad
	mov	strboxstack_p,esp

	cmp	eax,78
	jb	@F
	mov	eax,78
@@:
	shl	eax,3			;*8
	mov	ecx,eax
	mov	strbox_gad.W,ax

	shr	ecx,1			;/2
	neg	ecx
	add	ecx,X
	mov	strbox_gad.X,cx
	mov	strbox_gad.TXT_p,edi

	add	ax,20			;W
	mov	bx,30			;H
	sub	cx,8
	mov	dx,Y
	call	box_drawshaded

	mov	cx,4
	lea	esi,strbox_gad
	call	gadstr_init


	mov	eax,gadlst_p		;Save gad ptrs
	mov	gadlastlst_p,eax
	mov	gadlst_p,offset strbox_gad

	mov	eax,gadfunc_p
	mov	gadlastfunc_p,eax
	mov	gadfunc_p,offset strbox_gadf

	jmp	drawmouse		;I'm leaving ret address on stack

 SUBEND

	.data
strbox_gad\
	GAD	{ 0, 0,Y+5, 0,11, 0, 0, GADF_STR, ID }

strbox_gadf\
	dd	strbox_gads


;********************************
;* String box gadgets. Jumps to creator
;* AX=Gadget ID

 SUBRP	strbox_gads

	mov	esp,strboxstack_p	;Restore stack

	mov	esi,gadlastlst_p
	mov	gadlst_p,esi

	mov	esi,gadlastfunc_p
	mov	gadfunc_p,esi

	TST	al			;Pass Z (0=OK, !0=Aborted)

	popad
	ret

 SUBEND




;********************************
;* Initialize a string gad
;* CX=X left offset from gad
;* ESI=*Gadget

 SUBRP	gadstr_init

	movsx	ecx,cx

	cmp	gadstrgad_p,esi
	je	setcur			;Already open?

	call	gadstr_close

	mov	gadstrgad_p,esi

	mov	eax,[esi].GAD.TXT_p	;>Copy gad_s to buffer
	mov	edi,offset gadbuf_s
	call	strcpy

setcur:
	sub	ecx,4
	jl	x			;Not on a char?
	shr	ecx,3

	CLR	edx			;>Keep cursor on a valid char
	mov	edi,offset gadbuf_s
@@:	mov	al,[edi]
	inc	edx
	inc	edi
	TST	al
	jnz	@B

	dec	edx
	cmp	ecx,edx
	jle	@F			;Not past null?
	mov	ecx,edx
@@:	mov	gadcurx,ecx

	movzx	ecx,[esi].GAD.W
	sub	ecx,7
	shr	ecx,3
	mov	gadcurxmax,ecx

	call	gadstr_prt

x:	ret

 SUBEND


;********************************
;* Close the string gad
;* Trashes none

 SUBRP	gadstr_close

	pushad

	mov	esi,gadstrgad_p
	TST	esi
	jz	x

	mov	gadstrgad_p,0

	lea	eax,gadbuf_s		;Save for history
	lea	edi,gadbufo1_s
	call	strcpy

	lea	eax,gadbuf_s		;Copy to original
	mov	edi,[esi].GAD.TXT_p
	call	strcpy

	push	esi
	call	gad_draw		;Redraw
	pop	esi

	movzx	eax,[esi].GAD.ID
	TST	eax
	jl	x			;Neg ID?
	movzx	esi,ah
	shl	esi,2			;*4
	add	esi,gadfunc_p
					;Call function, Pass AX=Gadget ID
	call	DPTR [esi]


x:	popad
	ret

 SUBEND


;********************************
;* Abort the string gad

 SUBRP	gadstr_abort

	mov	esi,gadstrgad_p
	TST	esi
	jz	x

	mov	gadstrgad_p,0

	call	gad_draw		;Redraw

	mov	al,1
	cmp	gadlst_p,offset strbox_gad
	je	strbox_gads		;Let him abort

x:
	ret

 SUBEND



;********************************
;* Key press in string gad
;* AX=Keycode

 SUBRP	gadstr_key

	cmp	ax,13
	je	gadstr_close
	cmp	ax,27
	je	gadstr_abort

	lea	ebx,gadbuf_s
	mov	ecx,gadcurx
	add	ebx,ecx

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Cursor left

	cmp	ax,4b00h
	jne	@F

	dec	ecx
	jl	sprt
	mov	gadcurx,ecx
	jmp	sprt
@@:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Cursor rgt

	cmp	ax,4d00h
	jne	@F

	cmp	ecx,gadcurxmax
	jae	sprt			;Maxed?
	mov	al,[ebx]
	TST	al
	jz	sprt			;At end?
	inc	ecx
	mov	gadcurx,ecx

	jmp	sprt
@@:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Backspace

	cmp	ax,8
	jne	@F

	dec	ecx
	jl	sprt
	mov	gadcurx,ecx

bksplp:	mov	al,[ebx]		;Move all back
	mov	[ebx]-1,al
	inc	ebx
	TST	al
	jnz	bksplp

	jmp	sprt
@@:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>INS

	cmp	ax,5200h
	jne	@F

	not	gadovwon		;Toggle
	jmp	sprt
@@:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>DEL

	cmp	ax,5300h
	jne	@F

	mov	al,[ebx]
	jmp	delnxt

dellp:	mov	al,1[ebx]		;Move all back
	mov	[ebx],al
	inc	ebx
delnxt:
	TST	al
	jnz	dellp

	jmp	sprt
@@:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Home

	cmp	ax,4700h
	jne	@F

	CLR	eax
	mov	gadcurx,eax
	jmp	sprt
@@:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>End

	cmp	ax,4f00h
	jne	@F
kend:
elp:
	cmp	BPTR [ebx],0
	je	sprt			;At null?
	cmp	ecx,gadcurxmax
	jae	sprt			;Cursor at end?
	inc	ebx
	inc	gadcurx
	inc	ecx
	jmp	elp

@@:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Tab

	cmp	ax,9
	jne	@F

	mov	BPTR [ebx],0
	jmp	sprt
@@:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Up arrow

	cmp	ax,4800h
	jne	@F

	lea	eax,gadbufo1_s		;Restore from history
	lea	edi,gadbuf_s
	push	edi
	mov	ecx,gadcurxmax
	inc	ecx
	call	strcpylen
	mov	BPTR [edi],0
	pop	ebx

	CLR	ecx
	mov	gadcurx,ecx

	jmp	kend
@@:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Regular keys

	cmp	ax,' '
	jb	x
	cmp	ax,'~'
	ja	x

inslp:
	mov	ah,[ebx]
	mov	[ebx],al
	inc	ebx

	cmp	gadovwon,0
	je	@F			;Insert mode?
	TST	ah
	jnz	chkmax
	jmp	xend
@@:
	cmp	ecx,gadcurxmax
	jae	xend			;At end?
	inc	ecx
	mov	al,ah
	TST	ah
	jnz	inslp
xend:
	mov	BPTR [ebx],0
chkmax:
	mov	ecx,gadcurx
	cmp	ecx,gadcurxmax
	jae	xmax			;Cursor at end?
	inc	gadcurx
xmax:

sprt:	call	gadstr_prt

x:	ret


 SUBEND


;********************************
;* Print string and cursor

 SUBRP	gadstr_prt

	mov	esi,gadstrgad_p

	CLR	bh			;>Clr old str
	mov	ax,[esi].GAD.W
	shr	ax,3			;# spaces
	mov	cx,[esi].GAD.X
	mov	dx,[esi].GAD.Y
	add	cx,4
	add	dx,3
	call	prt_spc

	mov	bx,0feffh
	mov	esi,offset gadbuf_s	;>Prt str
	call	prt

	mov	esi,offset prtbuf_s	;>Prt cursor
	mov	ebx,offset gadbuf_s
	add	ebx,gadcurx
	mov	al,[ebx]
	TST	al
	jnz	nonull
	mov	al,' '			;Prt null as spc
nonull:
	CLR	ah
	mov	[esi],ax
	mov	ebx,gadcurx
	shl	ebx,3
	add	ecx,ebx
	mov	bx,0fcfeh
	call	prt

	ret

 SUBEND




;********************************
;* Initialize and display menu
;* Trashes all non seg

 SUBR	menu_init

	mov	eax,gadlstmain_p
	cmp	gadlst_p,eax
	jne	x

	mov	menuact,1

	mov	menunum,-2
	mov	menuinum,-1
	mov	menusx,-1
	call	menu_draw

x:	ret

 SUBEND


;********************************
;* Main menu functions
;* Trashes all non seg

 SUBR	menu_main

	test	mousebut,2
	jz	select			;No Rbut?

	call	menu_draw

	jmp	x

select:
	mov	menuact,0

	call	main_draw

	CLR	edx
	mov	esi,menui_p
	TST	esi
	jz	x
	jmp	strt

lp:	cmp	dx,menuinum
	jne	@F

	call	[esi].MENUI.CODE_p
	jmp	x
@@:
	inc	dx
	add	esi,sizeof MENUI
strt:	mov	ax,[esi]
	TST	ax
	jnz	lp


x:	ret

 SUBEND


;********************************
;* Draw current menu
;* Trashes all non seg

MENUH	equ	8

 SUBR	menu_draw

	mov	ax,mousey
	cmp	ax,MENUH
	jge	strip			;Below heading?

	mov	esi,offset menu_p
	CLR	ecx			;X
	CLR	eax			;Current #
	jmp	mnstrt
mnlp:
	add	cx,[esi].MENU.W
	cmp	cx,mousex
	jg	@F

	inc	ax
mnstrt:
	mov	esi,[esi]
	TST	esi
	jnz	mnlp

	mov	ax,-1
@@:

	cmp	ax,menunum
	je	strip
	mov	menunum,ax


	mov	ax,80			;>Clear menu bar
	mov	bh,0feh
	CLR	ecx
	CLR	edx
	call	prt_spc

					;>Erase old strip
	mov	cx,menusx
	TST	cx
	jl	noolds
	mov	ax,menusw
	add	ax,4
	mov	bx,menush
	mov	dx,MENUH
	mov	box1.COL,0
	call	box_draw
noolds:


	mov	menui_p,0
	mov	menuinum,-2

	mov	esi,offset menu_p
	CLR	ecx			;X
	CLR	edi			;Current #
	jmp	strt2
lp2:
	push	esi
	push	edi

	mov	bx,0fefch

	cmp	di,menunum
	jne	@F			;!Selected?

	mov	eax,[esi].MENU.MENUI_p
	mov	menui_p,eax
	mov	menusx,cx
	mov	ax,[esi].MENU.MSW
	mov	menusw,ax
	mov	bx,0fdffh

	mov	ax,[esi].MENU.W
	shr	ax,3			;/8
	dec	ax
	mov	dx,0
	call	prt_spc
@@:
	mov	esi,[esi].MENU.TITLE_p
	mov	dx,0
	call	prt

	pop	edi
	pop	esi
	add	cx,[esi].MENU.W
	inc	edi
strt2:
	mov	esi,[esi]
	TST	esi
	jnz	lp2



strip:
	mov	ax,-1

	mov	bx,menusx
	cmp	bx,mousex
	jg	@F			;Mouse to left?
	add	bx,menusw
	cmp	bx,mousex
	jle	@F			;Mouse to rgt?

	mov	bx,mousey
	sub	bx,MENUH
	jl	@F			;On header?
	mov	ax,bx
	mov	bl,13
	div	bl
	CLR	ah

@@:	cmp	ax,menuinum
	je	x
	mov	menuinum,ax


					;>Draw strip
	mov	esi,menui_p
	TST	esi
	jz	x			;None?
	mov	menush,0
	mov	dx,MENUH		;Y
	CLR	edi			;Current #
	jmp	strt
lp:
	push	esi
	push	edi
	push	eax

	cmp	di,menuinum
	jne	@F			;!Selected?

	mov	ax,menusw		;W
	add	ax,4
	mov	bx,13			;H
	mov	cx,menusx
	mov	box1.COL,0fdh
	call	box_draw
	jmp	pstr

@@:	mov	ax,menusw		;W
	mov	bx,13-4			;H
	mov	cx,menusx
	call	box_drawshaded
pstr:
	pop	esi			;* string
	pop	eax
	push	eax
	mov	bx,0fdffh
	cmp	ax,menuinum
	jne	@F			;!Selected?
	mov	bx,0fd00h
@@:
	mov	cx,menusx
	add	cx,6
	add	dx,3
	call	prt

	add	dx,13-3
	add	menush,13

	pop	edi
	pop	esi
	inc	di
	add	esi,sizeof MENUI
strt:
	mov	eax,[esi]
	TST	eax
	jnz	lp

x:
	ret

 SUBEND



;********************************
;* Clear screen memory

 SUBRP	scr_clr

	pushad

	cld

	mov	ax,0f00h+SC_MAPMASK
	mov	dx,SC_INDEX
	out	dx,ax

	CLR	eax
	mov	edi,0a0000h		;Vid mem
	mov	ecx,640*400/4/4
	rep	stosd

	popad

	ret


 SUBEND


;********************************
;* Draw shaded box
;* AX=Width
;* BX=Height
;* CX=X
;* DX=Y
;* Trashes ESI,EDI

 SUBRP	box_drawshaded

	push	eax
	push	ebx

	mov	esi,offset shade_box

	mov	(sizeof BOX*4)[esi].BOX.W,ax

	add	ax,2
	mov	(sizeof BOX*5)[esi].BOX.X,ax

	inc	ax
	mov	(sizeof BOX*6)[esi].BOX.X,ax

	inc	ax
	mov	[esi].BOX.W,ax
	mov	(sizeof BOX)[esi].BOX.W,ax

	mov	(sizeof BOX*3)[esi].BOX.H,bx
	mov	(sizeof BOX*4)[esi].BOX.H,bx
	mov	(sizeof BOX*5)[esi].BOX.H,bx
	add	bx,2
	mov	sizeof BOX[esi].BOX.Y,bx
	mov	(sizeof BOX*2)[esi].BOX.H,bx
	mov	(sizeof BOX*6)[esi].BOX.H,bx

	pop	ebx
	pop	eax

	jmp	box_drawmany


	.data
W=8*16
H=9
shade_box\
	BOX	{0,0, W+4,2, 252}
	BOX	{0,H+2, W+4,2, 254}
	BOX	{0,1, 1,H+2, 254}
	BOX	{1,2, 1,H, 254}
	BOX	{2,2, W,H, 253}
	BOX	{W+2,2, 1,H, 252}
	BOX	{W+3,1, 1,H+2, 252}
	word	-1	;End

	.code

 SUBEND



;********************************
;* Draw filled box
;* AX=Width
;* BX=Height
;* CX=X
;* DX=Y
;* Trashes ESI,EDI

 SUBRP	box_draw

	mov	esi,offset box1

	mov	[esi].BOX.W,ax
	mov	[esi].BOX.H,bx

	jmp	box_drawmany


	.data
box1\
	BOX	{0,0, 0,0, 253}
	word	-1	;End

	.code

 SUBEND




;********************************
;* Draw many simple boxes
;* ESI=* box data
;* CX=X offset
;* DX=Y offset
;* Trashes ESI,EDI

 SUBRP	box_drawmany

	push	eax
	push	ebx
	push	ecx
	push	edx
	push	ebp

	movsx	ecx,cx
	movsx	edx,dx
	mov	prtx,ecx
	mov	prty,edx

	jmp	strt


lp:
	add	ebx,prtx

	mov	dx,SCRWB
	mov	ax,2[esi]		;Y offset
	add	eax,prty
	mul	dx
	mov	bp,ax

	movzx	ecx,WPTR 4[esi]		;X size
lpx:	push	ecx

	movzx	edi,bx			;X
	shr	edi,2			;/4
	add	di,bp			;+Y offset
	mov	cl,bl
	and	cl,3
	jnz	do1			;Not on long boundary?

	cmp	DPTR [esp],4
	jl	do1			;Too few?

	mov	ax,0f00h+SC_MAPMASK	;>Do 4 lines
	add	bx,3
	sub	DPTR [esp],3
	jmp	setup
do1:
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
setup:	mov	dx,SC_INDEX
	out	dx,ax

	mov	cx,6[esi]		;Y size
	mov	al,8[esi]		;Color
lpy:
	mov	0a0000h[edi],al
	add	di,SCRWB
	dec	cx
	jg	lpy

	inc	bx			;Next X

	pop	ecx
	dec	ecx
	jg	lpx


	add	esi,sizeof BOX
strt:	mov	bx,[esi]		;X offset
	TST	bx
	jge	lp			;!End?


	pop	ebp
	pop	edx
	pop	ecx
	pop	ebx
	pop	eax

	ret

 SUBEND




;********************************
;* Prt decimal #
;* AX=#
;* BX=Bgnd color (0-255) : Fgnd color (0-255)
;* CX=X
;* DX=Y
;* Trashes esi,edi

 SUBR	prt_dec

	push	eax
	push	ebx
	push	ecx
	push	edx

	mov	esi,offset prtbuf_s
	mov	edi,esi

	CLR	ecx			;ECX=Non zero flag

	TST	ax
	jns	pos
	neg	ax
	mov	BPTR [edi],'-'
	inc	edi
pos:

	mov	bx,10000
	cmp	ax,bx
	jb	b10000
	CLR	edx
	div	bx
	xchg	ax,dx
	add	dl,'0'
	mov	[edi],dl
	inc	edi
	inc	ecx
b10000:
	mov	bx,1000
	TST	ecx
	jnz	@F
	cmp	ax,bx
	jb	b1000
@@:	CLR	edx
	div	bx
	xchg	ax,dx
	add	dl,'0'
	mov	[edi],dl
	inc	edi
	inc	ecx
b1000:
	mov	bx,100
	TST	ecx
	jnz	@F
	cmp	ax,bx
	jb	b100
@@:	CLR	edx
	div	bx
	xchg	ax,dx
	add	dl,'0'
	mov	[edi],dl
	inc	edi
	inc	ecx
b100:
	mov	bx,10
	TST	ecx
	jnz	@F
	cmp	ax,bx
	jb	b10
@@:	CLR	edx
	div	bx
	add	al,'0'
	mov	[edi],al
	inc	edi
	mov	al,dl
b10:
	add	al,'0'
	CLR	ah
	mov	[edi],ax


	pop	edx
	pop	ecx
	pop	ebx
	pop	eax

	jmp	prt


 SUBEND


;********************************
;* Prt decimal # (3 digits, signed, right justified)
;* AX=#
;* BX=Bgnd color (0-255) : Fgnd color (0-255)
;* CX=X
;* DX=Y
;* Trashes esi,edi

 SUBR	prt_dec3srj

	push	eax
	push	ebx
	push	ecx
	push	edx


	mov	esi,offset prtbuf_s
	mov	edi,esi
	mov	DPTR [edi],'    '

	TST	ax
	jns	pos
	neg	ax
	mov	BPTR [edi],'-'
pos:
	inc	edi


	mov	bx,100
	cmp	ax,bx
	jb	b100			;No digit?
	CLR	edx
	div	bx
	xchg	ax,dx
	add	dl,'0'
	mov	[edi],dl
	inc	edi
	mov	bx,10
	jmp	d2

b100:	inc	edi

	mov	bx,10
	cmp	ax,bx
	jb	b10			;No digit?
d2:	CLR	edx
	div	bx
	add	al,'0'
	mov	[edi],al
	mov	al,dl
b10:
	inc	edi
	add	al,'0'
	CLR	ah
	mov	[edi],ax


	pop	edx
	pop	ecx
	pop	ebx
	pop	eax

	jmp	prt


 SUBEND



;********************************
;* Prt binary word
;* AX=#
;* BX=Bgnd color (0-255) : Fgnd color (0-255)
;* CX=X
;* DX=Y
;* Trashes esi,edi

 SUBRP	prt_binword

	push	eax
	push	ebx
	push	ecx
	push	edx

	mov	cx,16
	mov	edi,offset prtbuf_s
lp:
	CLR	bl
	rol	ax,1
	adc	bl,'0'
	mov	[edi],bl
	inc	edi

	loopw	lp

	mov	[edi],cl			;Null

	pop	edx
	pop	ecx
	pop	ebx
	pop	eax
	mov	esi,offset prtbuf_s
	jmp	prt


 SUBEND


;********************************
;* Prt hex word
;* AX=#
;* BX=Bgnd color (0-255) : Fgnd color (0-255)
;* CX=X
;* DX=Y
;* Trashes esi,edi

 SUBR	prt_hexword

	push	eax
	push	ebx
	push	ecx
	push	edx

	CLR	ebx
	mov	cx,4
	mov	edi,offset prtbuf_s
lp:
	rol	ax,4
	mov	bl,al
	and	bx,0fh
	mov	dl,ascii0f_s[ebx]
	mov	[edi],dl
	inc	edi

	loopw	lp

	mov	[edi],cl			;Null

	pop	edx
	pop	ecx
	pop	ebx
	pop	eax
	mov	esi,offset prtbuf_s
	jmp	prt


 SUBEND



;********************************
;* Prt data as hex dump
;* ESI=* data
;* Trashes esi,edi

 SUBRP	prt_hexdump

	push	eax
	push	ebx
	push	ecx
	push	edx

	mov	cx,16
	mov	dx,2
lp:	push	ecx
	push	edx

	mov	cx,8
	mov	edi,offset prtbuf_s
llp:
	CLR	ebx
	mov	bl,[esi]
	shr	bl,4
	mov	dl,ascii0f_s[ebx]
	mov	[edi],dl
	inc	edi
	mov	bl,[esi]
	and	bl,0fh
	inc	esi
	mov	dl,ascii0f_s[ebx]
	mov	[edi],dl
	inc	edi
	mov	BPTR [edi],' '
	inc	edi

	loopw	llp

	mov	BPTR [edi],0

	pop	edx
	push	esi
	mov	esi,offset prtbuf_s
	mov	bx,0fdh
	mov	cx,320
	call	prt
	add	dx,9
	pop	esi

	pop	ecx
	loopw	lp


	pop	edx
	pop	ecx
	pop	ebx
	pop	eax

	ret

	.data
ascii0f_s	db	"0123456789ABCDEF"
	.code

 SUBEND




;********************************
;* Print spaces
;* AX=# spaces (1-80)
;* BH=Color (0-255)
;* CX=X
;* DX=Y
;* Trashes none

 SUBRP	prt_spc

	pushad

	movsx	ecx,cx
	mov	prtx,ecx
	mov	prtcolors,bx
	mov	bx,ax

	mov	ax,SCRWB
	mul	dx
	mov	bp,ax

	mov	ecx,4			;X cnt
lpx:	push	ecx

	mov	ecx,prtx
	mov	edi,ecx			;X
	shr	edi,2			;/4
	add	di,bp			;+Y offset
	and	cl,3
	jnz	do1			;Not on long boundary?

	cmp	WPTR [esp],4
	jl	do1			;Too few?

	mov	ax,0f00h+SC_MAPMASK	;>Do 4 lines
	add	prtx,3
	sub	WPTR [esp],3
	jmp	setup
do1:
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
setup:	mov	dx,SC_INDEX		;Cache?
	out	dx,ax

	mov	ax,prtcolors
	mov	cx,8			;Y cnt
lpy:
	push	ebx
	push	edi
lpc:	mov	0a0000h[edi],ah
	mov	0a0001h[edi],ah
	add	di,2
	dec	bx
	jg	lpc
	pop	edi
	pop	ebx

	add	di,SCRWB
	dec	cx
	jg	lpy


	inc	prtx			;Next X

	pop	ecx
	loop	lpx


	popad

	ret


 SUBEND


;********************************
;* Prt an XY multi string
;* EAX = * string
;* Trashes EAX

 SUBRP	prt_xystr

	PUSHMR	ebx,ecx,edx,esi,edi

	jmp	strt
lp:
	add	eax,2

	mov	dx,[eax]		;Y
	add	eax,2

	mov	bx,[eax]		;Color
	add	eax,2

	mov	esi,eax
	call	prt
@@:
	mov	dl,[eax]
	inc	eax
	TST	dl
	jnz	@B

strt:
	mov	cx,[eax]		;X
	TST	cx
	jge	lp


	POPMR
	ret

 SUBEND


;********************************
;* Print ASCII string
;* ESI = * ASCIIZ
;* BX  = Bgnd color (0-255) : Fgnd color (0-255)
;* CX  = X
;* DX  = Y
;* Trashes ESI,EDI

 SUBR	prt

	push	eax
	push	ebx
	push	ecx
	push	edx
	push	ebp

	movsx	ecx,cx
	movsx	edx,dx
	mov	prtx,ecx
	mov	prty,edx
	mov	prtcolors,bx
	mov	ax,SCRWB
	mul	dx
	mov	bp,ax
	jmp	start


lp:
	push	esi

	movzx	esi,al
	shl	esi,3			;*8
	add	esi,offset font_t

	mov	cx,4			;X cnt
	mov	dx,880h			;Font bit mask
lpx:	push	ecx
	push	edx

	mov	ecx,prtx
	mov	edi,ecx			;X
	shr	edi,2			;/4
	add	di,bp			;+Y offset
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	mov	dx,SC_INDEX
	out	dx,ax

	mov	bx,prtcolors
	mov	cx,8			;Y cnt
	pop	edx
lpy:
	mov	al,bl			;>Copy column
	test	[esi],dl			;Test bit
	jnz	fgc
	mov	al,bh
fgc:
	mov	ah,bl			;>Copy column
	test	[esi],dh			;Test bit
	jnz	fgc2
	mov	ah,bh
fgc2:
	mov	0a0000h[edi],ax

	inc	esi
	add	di,SCRWB
	dec	cx
	jg	lpy


	sub	esi,8			;Top Y
	inc	prtx			;Next X
	shr	dx,1			;Next bit

	pop	ecx
	loopw	lpx

	add	prtx,4			;Next X

	pop	esi
	inc	esi
start:	mov	al,[esi]
	sub	al,''
	jae	lp

	pop	ebp
	pop	edx
	pop	ecx
	pop	ebx
	pop	eax

	ret


	.data
font_t\
	db	00000000b	;
	db	00000000b
	db	00011000b
	db	00111100b
	db	01100110b
	db	11000011b
	db	00000000b
	db	00000000b

	db	00000000b	;
	db	00000000b
	db	11000011b
	db	01100110b
	db	00111100b
	db	00011000b
	db	00000000b
	db	00000000b

	db	11100000b	;RArrow
	db	00111000b
	db	00001110b
	db	00000111b
	db	00001110b
	db	00111000b
	db	11100000b
	db	00000000b

	db	00000111b	;LArrow
	db	00011100b
	db	01110000b
	db	11100000b
	db	01110000b
	db	00011100b
	db	00000111b
	db	00000000b

	db	00011000b	;
	db	00111100b
	db	01100110b
	db	11000011b
	db	11000011b
	db	01100110b
	db	00111100b
	db	00011000b

	db	00000000b	;
	db	00100100b
	db	01000010b
	db	11100111b
	db	01000010b
	db	00100100b
	db	00000000b
	db	00000000b

	db	00011000b	;
	db	00111100b
	db	01011010b
	db	00000000b
	db	01011010b
	db	00111100b
	db	00011000b
	db	00000000b

	db	00000000b	;
	db	01111110b
	db	01111110b
	db	01111110b
	db	01111110b
	db	01111110b
	db	01111110b
	db	00000000b

	db	00000000b	;Space
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00011000b	;!
	db	00011000b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00000000b
	db	00011000b
	db	00000000b

	db	01100110b	;"
	db	01100110b
	db	01100110b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;#
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;$
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;%
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00011000b	;&
	db	00111100b
	db	00111100b
	db	01100110b
	db	01100110b
	db	11000011b
	db	11000011b
	db	00000000b

	db	00011000b	;'
	db	00011000b
	db	00110000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00001100b	;(
	db	00011000b
	db	00110000b
	db	00110000b
	db	00110000b
	db	00011000b
	db	00001100b
	db	00000000b

	db	00110000b	;)
	db	00011000b
	db	00001100b
	db	00001100b
	db	00001100b
	db	00011000b
	db	00110000b
	db	00000000b

	db	00000000b	;*
	db	01101100b
	db	00111000b
	db	11111110b
	db	00111000b
	db	01101100b
	db	00000000b
	db	00000000b

	db	00000000b	;+
	db	00011000b
	db	00011000b
	db	01111110b
	db	00011000b
	db	00011000b
	db	00000000b
	db	00000000b

	db	00000000b	;,
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00011000b
	db	00011000b
	db	00110000b

	db	00000000b	;-
	db	00000000b
	db	00000000b
	db	01111110b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;.
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00011000b
	db	00011000b
	db	00000000b

	db	00000010b	;/
	db	00000110b
	db	00001100b
	db	00011000b
	db	00110000b
	db	01100000b
	db	01000000b
	db	00000000b

	db	00111100b	;0
	db	01100110b
	db	01101110b
	db	01111110b
	db	01110110b
	db	01100110b
	db	00111100b
	db	00000000b

	db	00011000b	;1
	db	00111000b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00000000b

	db	00111100b	;2
	db	01100110b
	db	00000110b
	db	00001100b
	db	00011000b
	db	00110000b
	db	01111110b
	db	00000000b

	db	00111100b	;3
	db	01100110b
	db	00000110b
	db	00011100b
	db	00000110b
	db	01100110b
	db	00111100b
	db	00000000b

	db	01100110b	;4
	db	01100110b
	db	01100110b
	db	01111110b
	db	00000110b
	db	00000110b
	db	00000110b
	db	00000000b

	db	01111110b	;5
	db	01100000b
	db	01100000b
	db	01111100b
	db	00000110b
	db	01100110b
	db	00111100b
	db	00000000b

	db	00111100b	;6
	db	01100110b
	db	01100000b
	db	01111100b
	db	01100110b
	db	01100110b
	db	00111100b
	db	00000000b

	db	01111110b	;7
	db	00000110b
	db	00000110b
	db	00001100b
	db	00001100b
	db	00011000b
	db	00011000b
	db	00000000b

	db	00111100b	;8
	db	01100110b
	db	01100110b
	db	00111100b
	db	01100110b
	db	01100110b
	db	00111100b
	db	00000000b

	db	00111100b	;9
	db	01100110b
	db	01100110b
	db	00111110b
	db	00000110b
	db	01100110b
	db	00111100b
	db	00000000b

	db	00000000b	;:
	db	00011000b
	db	00011000b
	db	00000000b
	db	00011000b
	db	00011000b
	db	00000000b
	db	00000000b

	db	00000000b	;;
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;<
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;=
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;>
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00111100b	;?
	db	01100110b
	db	00000110b
	db	00001100b
	db	00011000b
	db	00000000b
	db	00011000b
	db	00000000b

	db	00000000b	;@
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00111100b	;A
	db	01100110b
	db	01100110b
	db	01111110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	00000000b

	db	01111100b
	db	01100110b
	db	01100110b
	db	01111100b
	db	01100110b
	db	01100110b
	db	01111100b
	db	00000000b

	db	00111100b
	db	01100110b
	db	01100000b
	db	01100000b
	db	01100000b
	db	01100110b
	db	00111100b
	db	00000000b

	db	01111100b
	db	01100110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	01111100b
	db	00000000b

	db	01111110b
	db	01100000b
	db	01100000b
	db	01111100b
	db	01100000b
	db	01100000b
	db	01111110b
	db	00000000b

	db	01111110b
	db	01100000b
	db	01100000b
	db	01111100b
	db	01100000b
	db	01100000b
	db	01100000b
	db	00000000b

	db	00111100b
	db	01100110b
	db	01100000b
	db	01101110b
	db	01100110b
	db	01100110b
	db	00111100b
	db	00000000b

	db	01100110b
	db	01100110b
	db	01100110b
	db	01111110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	00000000b

	db	01111110b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00011000b
	db	01111110b
	db	00000000b

	db	00000110b
	db	00000110b
	db	00000110b
	db	00000110b
	db	01100110b
	db	01100110b
	db	00111100b
	db	00000000b

	db	01100110b
	db	01100110b
	db	01101100b
	db	01111000b
	db	01101100b
	db	01100110b
	db	01100110b
	db	00000000b

	db	01100000b
	db	01100000b
	db	01100000b
	db	01100000b
	db	01100000b
	db	01100000b
	db	01111110b
	db	00000000b

	db	11000110b
	db	11101110b
	db	11111110b
	db	11010110b
	db	11000110b
	db	11000110b
	db	11000110b
	db	00000000b

	db	01100110b
	db	01110110b
	db	01110110b
	db	01111110b
	db	01101110b
	db	01101110b
	db	01100110b
	db	00000000b

	db	00111100b
	db	01100110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	00111100b
	db	00000000b

	db	01111100b
	db	01100110b
	db	01100110b
	db	01111100b
	db	01100000b
	db	01100000b
	db	01100000b
	db	00000000b

	db	00111100b
	db	01100110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	01101110b
	db	00111110b
	db	00000011b

	db	01111100b
	db	01100110b
	db	01100110b
	db	01111100b
	db	01101100b
	db	01100110b
	db	01100110b
	db	00000000b

	db	00111100b
	db	01100110b
	db	01100000b
	db	00111100b
	db	00000110b
	db	01100110b
	db	00111100b
	db	00000000b

	db	01111110b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00000000b

	db	01100110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	00111100b
	db	00000000b

	db	01100110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	00111100b
	db	00011000b
	db	00000000b

	db	11000110b
	db	11000110b
	db	11000110b
	db	11010110b
	db	11111110b
	db	11101110b
	db	11000110b
	db	00000000b

	db	01100110b
	db	01100110b
	db	00111100b
	db	00011000b
	db	00111100b
	db	01100110b
	db	01100110b
	db	00000000b

	db	01100110b
	db	01100110b
	db	01100110b
	db	00111100b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00000000b

	db	01111110b
	db	00000110b
	db	00001100b
	db	00011000b
	db	00110000b
	db	01100000b
	db	01111110b
	db	00000000b

	db	00111100b	;[
	db	00110000b
	db	00110000b
	db	00110000b
	db	00110000b
	db	00110000b
	db	00111100b
	db	00000000b

	db	01000000b	;\
	db	01100000b
	db	00110000b
	db	00011000b
	db	00001100b
	db	00000110b
	db	00000010b
	db	00000000b

	db	00111100b	;]
	db	00001100b
	db	00001100b
	db	00001100b
	db	00001100b
	db	00001100b
	db	00111100b
	db	00000000b

	db	00011000b	;^
	db	00111100b
	db	01100110b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
				  
	db	00000000b	;_
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	11111110b

	db	00011000b	;`
	db	00011000b
	db	00001100b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;a
	db	00000000b
	db	00111100b
	db	00000110b
	db	00111110b
	db	01100110b
	db	00111110b
	db	00000000b

	db	01100000b	;b
	db	01100000b
	db	01111100b
	db	01100110b
	db	01100110b
	db	01100110b
	db	01111100b
	db	00000000b

	db	00000000b	;c
	db	00000000b
	db	00111100b
	db	01100110b
	db	01100000b
	db	01100110b
	db	00111100b
	db	00000000b

	db	00000110b	;d
	db	00000110b
	db	00111110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	00111110b
	db	00000000b

	db	00000000b	;e
	db	00000000b
	db	00111100b
	db	01100110b
	db	01111110b
	db	01100000b
	db	00111110b
	db	00000000b

	db	00011100b	;f
	db	00110110b
	db	00110000b
	db	01111100b
	db	00110000b
	db	00110000b
	db	00110000b
	db	00000000b

	db	00000000b	;g
	db	00000000b
	db	00111100b
	db	01100110b
	db	01100110b
	db	00111110b
	db	00000110b
	db	00111100b

	db	01100000b	;h
	db	01100000b
	db	01111100b
	db	01100110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	00000000b

	db	00011000b	;i
	db	00000000b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00000000b

	db	00001100b	;j
	db	00000000b
	db	00001100b
	db	00001100b
	db	00001100b
	db	00001100b
	db	01101100b
	db	00111000b

	db	01100000b	;k
	db	01100000b
	db	01100110b
	db	01101100b
	db	01111000b
	db	01101100b
	db	01100110b
	db	00000000b

	db	00110000b	;l
	db	00110000b
	db	00110000b
	db	00110000b
	db	00110000b
	db	00110000b
	db	00011000b
	db	00000000b

	db	00000000b	;m
	db	00000000b
	db	01101100b
	db	11010110b
	db	11010110b
	db	11010110b
	db	11000110b
	db	00000000b

	db	00000000b	;n
	db	00000000b
	db	01111100b
	db	01100110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	00000000b

	db	00000000b	;o
	db	00000000b
	db	00111100b
	db	01100110b
	db	01100110b
	db	01100110b
	db	00111100b
	db	00000000b

	db	00000000b	;p
	db	00000000b
	db	01111100b
	db	01100110b
	db	01100110b
	db	01100110b
	db	01111100b
	db	01100000b

	db	00000000b	;q
	db	00000000b
	db	00111110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	00111110b
	db	00000110b

	db	00000000b	;r
	db	00000000b
	db	01111100b
	db	01100110b
	db	01100000b
	db	01100000b
	db	01100000b
	db	00000000b

	db	00000000b	;s
	db	00000000b
	db	00111110b
	db	01100000b
	db	00111100b
	db	00000110b
	db	01111100b
	db	00000000b

	db	00011000b	;t
	db	00011000b
	db	00111100b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00011000b
	db	00000000b

	db	00000000b	;u
	db	00000000b
	db	01100110b
	db	01100110b
	db	01100110b
	db	01100110b
	db	00111110b
	db	00000000b

	db	00000000b	;v
	db	00000000b
	db	01100110b
	db	01100110b
	db	01100110b
	db	00111100b
	db	00011000b
	db	00000000b

	db	00000000b	;w
	db	00000000b
	db	11000110b
	db	11000110b
	db	11010110b
	db	11111110b
	db	01101100b
	db	00000000b

	db	00000000b	;x
	db	00000000b
	db	01100110b
	db	00111100b
	db	00011000b
	db	00111100b
	db	01100110b
	db	00000000b

	db	00000000b	;y
	db	00000000b
	db	01100110b
	db	01100110b
	db	01100110b
	db	00111110b
	db	00000110b
	db	00111100b

	db	00000000b	;z
	db	00000000b
	db	01111110b
	db	00001100b
	db	00011000b
	db	00110000b
	db	01111110b
	db	00000000b

	db	00000000b	;{
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;|
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;}
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	01110110b	;~
	db	11011100b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00010000b	;#127
	db	00010000b
	db	00010000b
	db	11101110b
	db	00010000b
	db	00010000b
	db	00010000b
	db	00000000b

	db	10000001b	;Map 1
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	10000001b

	db	11111111b	;Map 2
	db	10000001b
	db	10000001b
	db	10000001b
	db	10000001b
	db	10000001b
	db	10000001b
	db	11111111b

	db	11111111b	;Map 3
	db	10000001b
	db	10000001b
	db	10000001b
	db	10000001b
	db	10000001b
	db	10000001b
	db	10000001b

	db	11111111b	;Map 4
	db	00000001b
	db	00000001b
	db	00000001b
	db	00000001b
	db	00000001b
	db	00000001b
	db	11111111b

	db	10000001b	;Map 5
	db	10000001b
	db	10000001b
	db	10000001b
	db	10000001b
	db	10000001b
	db	10000001b
	db	11111111b

	db	11111111b	;Map 6
	db	10000000b
	db	10000000b
	db	10000000b
	db	10000000b
	db	10000000b
	db	10000000b
	db	11111111b

	db	11111111b	;Map 7
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	11111111b

	db	10000001b	;Map 8
	db	10000001b
	db	10000001b
	db	10000001b
	db	10000001b
	db	10000001b
	db	10000001b
	db	10000001b

	.code


 SUBEND



;********************************
;* Prt decimal # (2 digits, signed, right justified) in font6
;* AX=#
;* BX=Bgnd color (0-255) : Fgnd color (0-255)
;* CX=X
;* DX=Y
;* Trashes AX,esi,edi

 SUBRP	prtf6_dec2rj

	push	ebx
	push	ecx
	push	edx


	mov	esi,offset prtbuf_s
	mov	edi,esi
	mov	WPTR [edi],'  '

	mov	bx,10
	cmp	ax,bx
	jb	b10			;No digit?
d2:	CLR	edx
	div	bx
	add	al,'0'
	mov	[edi],al
	mov	al,dl
b10:	inc	edi
	add	al,'0'
	mov	[edi],al
	inc	edi


	mov	BPTR [edi],0

	pop	edx
	pop	ecx
	pop	ebx

	jmp	prtf6


 SUBEND



;********************************
;* Prt decimal # (3 digits, signed, right justified) in font6
;* AX=#
;* BX=Bgnd color (0-255) : Fgnd color (0-255)
;* CX=X
;* DX=Y
;* Trashes EAX,ESI,EDI

 SUBRP	prtf6_dec3srj

	push	ebx
	push	ecx
	push	edx


	mov	esi,offset prtbuf_s
	mov	edi,esi
	mov	dword ptr [edi],'    '

	TST	ax
	jns	pos
	neg	ax
	mov	BPTR [edi],'-'
pos:
	inc	edi


	mov	bx,100
	cmp	ax,bx
	jb	b100			;No digit?
	CLR	edx
	div	bx
	xchg	ax,dx
	add	dl,'0'
	mov	[edi],dl
	inc	edi
	mov	bx,10
	jmp	d2

b100:	inc	edi

	mov	bx,10
	cmp	ax,bx
	jb	b10			;No digit?
d2:	CLR	edx
	div	bx
	add	al,'0'
	mov	[edi],al
	mov	al,dl
b10:	inc	edi
	add	al,'0'
	mov	[edi],al
	inc	edi


	mov	BPTR [edi],0

	pop	edx
	pop	ecx
	pop	ebx

	jmp	prtf6


 SUBEND




;********************************
;* Print ASCII string 0-9 in font6
;* ESI=* ASCIIZ
;* BX=Bgnd color (0-255) : Fgnd color (0-255)
;* CX=X
;* DX=Y
;* Trashes ESI,EDI

 SUBRP	prtf6

	push	ebx
	push	ecx
	push	edx
	push	ebp

	movsx	ecx,cx
	movsx	edx,dx
	mov	prtx,ecx
	mov	prty,edx
	mov	prtcolors,bx
	mov	ax,SCRWB
	mul	dx
	mov	bp,ax
	jmp	start


lp:
	push	esi

	add	eax,eax			;>*6
	mov	esi,eax
	add	esi,eax
	add	esi,eax
	add	esi,offset font6_t

	mov	cx,6			;X cnt
	mov	dl,80h			;Font bit mask
lpx:	push	ecx
	push	edx

	mov	ecx,prtx
	mov	edi,ecx			;X
	shr	edi,2			;/4
	add	di,bp			;+Y offset
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	mov	dx,SC_INDEX
	out	dx,ax

	mov	bx,prtcolors
	mov	cx,6			;Y cnt
	pop	edx
lpy:
	mov	ax,bx			;>Copy column
	test	[esi],dl			;Test bit
	jnz	fgc
	mov	al,ah
fgc:	mov	0a0000h[edi],al

	inc	esi
	add	di,SCRWB
	dec	cx
	jg	lpy


	sub	esi,6			;Top Y
	inc	prtx			;Next X
	shr	dl,1			;Next bit

	pop	ecx
	loopw	lpx


	pop	esi
	inc	esi
start:	movzx	eax,BPTR [esi]
	sub	al,' '
	jge	lp


	pop	ebp
	pop	edx
	pop	ecx
	pop	ebx

	ret

 SUBEND


	.data
font6_t	db	00000000b	;Space
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00010000b	;!
	db	00010000b
	db	00010000b
	db	00000000b
	db	00010000b
	db	00000000b

	db	00000000b	;"
	db	00101000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;#
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;$
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;%
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00011000b	;&
	db	00111100b
	db	00111100b
	db	01100110b
	db	01100110b
	db	11000011b

	db	11000011b	;`
	db	11000011b
	db	01100110b
	db	01100110b
	db	00111100b
	db	00111100b

	db	00000000b	;(
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;)
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;*
	db	01101100b
	db	00111000b
	db	11111110b
	db	00111000b
	db	01101100b

	db	00000000b	;+
	db	00011000b
	db	00011000b
	db	01111110b
	db	00011000b
	db	00011000b

	db	00000000b	;,
	db	00000000b
	db	00000000b
	db	00000000b
	db	00010000b
	db	00100000b

	db	00000000b	;-
	db	00000000b
	db	01111100b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;.
	db	00000000b
	db	00000000b
	db	00000000b
	db	00010000b
	db	00000000b

	db	00000010b	;/
	db	00000110b
	db	00001100b
	db	00011000b
	db	00110000b
	db	01100000b

	db	00111000b	;0
	db	01001100b
	db	01010100b
	db	01100100b
	db	00111000b
	db	00000000b

	db	00010000b	;1
	db	00110000b
	db	00010000b
	db	00010000b
	db	00111000b
	db	00000000b

	db	01111100b	;2
	db	00000100b
	db	01111100b
	db	01000000b
	db	01111100b
	db	00000000b

	db	01111100b	;3
	db	00000100b
	db	01111100b
	db	00000100b
	db	01111100b
	db	00000000b

	db	01000100b	;4
	db	01000100b
	db	01111100b
	db	00000100b
	db	00000100b
	db	00000000b

	db	01111100b	;5
	db	01000000b
	db	01111100b
	db	00000100b
	db	01111100b
	db	00000000b

	db	01111100b	;6
	db	01000000b
	db	01111100b
	db	01000100b
	db	01111100b
	db	00000000b

	db	01111100b	;7
	db	00000100b
	db	00000100b
	db	00000100b
	db	00000100b
	db	00000000b

	db	01111100b	;8
	db	01000100b
	db	01111100b
	db	01000100b
	db	01111100b
	db	00000000b

	db	01111100b	;9
	db	01000100b
	db	01111100b
	db	00000100b
	db	01111100b
	db	00000000b

	db	00000000b	;:
	db	00011000b
	db	00011000b
	db	00000000b
	db	00011000b
	db	00011000b

	db	00000000b	;;
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;<
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;=
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00000000b	;>
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00111100b	;?
	db	01100110b
	db	00000110b
	db	00001100b
	db	00011000b
	db	00000000b

	db	00000000b	;@
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b
	db	00000000b

	db	00111000b	;A
	db	01000100b
	db	01111100b
	db	01000100b
	db	01000100b
	db	00000000b

	db	01111000b
	db	01000100b
	db	01111000b
	db	01000100b
	db	01111000b
	db	00000000b

	db	00111000b
	db	01000100b
	db	01000000b
	db	01000100b
	db	00111000b
	db	00000000b

	db	01111000b
	db	01000100b
	db	01000100b
	db	01000100b
	db	01111000b
	db	00000000b

	db	01111100b
	db	01000000b
	db	01111000b
	db	01000000b
	db	01111100b
	db	00000000b

	db	01111100b
	db	01000000b
	db	01111000b
	db	01000000b
	db	01000000b
	db	00000000b

	db	00111000b
	db	01000000b
	db	01001100b
	db	01000100b
	db	00111000b
	db	00000000b

	db	01000100b
	db	01000100b
	db	01111100b
	db	01000100b
	db	01000100b
	db	00000000b

	db	01111100b
	db	00010000b
	db	00010000b
	db	00010000b
	db	01111100b
	db	00000000b

	db	00000100b
	db	00000100b
	db	00000100b
	db	01000100b
	db	00111000b
	db	00000000b

	db	01000100b
	db	01001000b
	db	01110000b
	db	01001000b
	db	01000100b
	db	00000000b

	db	01000000b
	db	01000000b
	db	01000000b
	db	01000000b
	db	01111100b
	db	00000000b

	db	01000100b
	db	01101100b
	db	01111100b
	db	01010100b
	db	01000100b
	db	00000000b

	db	01000100b
	db	01100100b
	db	01010100b
	db	01001100b
	db	01000100b
	db	00000000b

	db	00111000b
	db	01000100b
	db	01000100b
	db	01000100b
	db	00111000b
	db	00000000b

	db	01111000b
	db	01000100b
	db	01111000b
	db	01000000b
	db	01000000b
	db	00000000b

	db	00111000b
	db	01000100b
	db	01000100b
	db	01001100b
	db	00111100b
	db	00000010b

	db	01111000b
	db	01000100b
	db	01111000b
	db	01000100b
	db	01000100b
	db	00000000b

	db	00111100b
	db	01000000b
	db	00111000b
	db	00000100b
	db	01111000b
	db	00000000b

	db	01111100b
	db	00010000b
	db	00010000b
	db	00010000b
	db	00010000b
	db	00000000b

	db	01000100b
	db	01000100b
	db	01000100b
	db	01000100b
	db	00111000b
	db	00000000b

	db	01000100b
	db	01000100b
	db	01000100b
	db	00111000b
	db	00010000b
	db	00000000b

	db	01000100b
	db	01010100b
	db	01111100b
	db	01101100b
	db	01000100b
	db	00000000b

	db	01000100b
	db	00101000b
	db	00010000b
	db	00101000b
	db	01000100b
	db	00000000b

	db	01000100b
	db	01000100b
	db	00111000b
	db	00010000b
	db	00010000b
	db	00000000b

	db	01111100b
	db	00001000b
	db	00010000b
	db	00100000b
	db	01111100b
	db	00000000b


	.code


;********************************



	end
