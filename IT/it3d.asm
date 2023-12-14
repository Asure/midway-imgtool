;**************************************************************
;*
;* Software:		Shawn Liptak
;* Initiated:		6/2/92
;*
;* Modified:		4/22/93 SL - Split from it.asm
;* 			6/1/93  SL - Communication with VUNIT
;* 			1/6/94  SL - Started Watcom C / DOS4GW version
;*
;* COPYRIGHT (C) 1992,93,94 WILLIAMS ELECTRONICS GAMES, INC.
;*
;*.Last mod - 6/26/94 5:51
;**************************************************************
	option	casemap:none
	.386P
	.model	flat,syscall,os_os2

	include	wmpstruc.inc
	include	it.inc
	include	it3d.inc
;	include	net.inc



	.code

;OS functions

	externdef	mem_debug:near

	externdef	scr_clr:near
	externdef	main_draw:near
	externdef	main_redraw:near
	externdef	main_exit:near
	externdef	help_main:near

	externdef	img_load:near
	externdef	gad_add:near
	externdef	gad_draw:near
	externdef	gad_drawall:near
	externdef	gad_mousescroller:near
	externdef	vid_chain4off:near
	externdef	vid_initvgapal:near
	externdef	vid_setvgapal15:near
	externdef	vid_setvgapal18:near
	externdef	vid_setvmode:near
	externdef	mouse_reset:near
;	externdef	palblk_setvgapal:near
	externdef	prt:near
	externdef	prt_spc:near
	externdef	prt_dec:near
	externdef	prt_hexword:near
	externdef	prt_dec3srj:near
	externdef	prtf6_dec3srj:near
	externdef	line_draw:near
	externdef	boxh_draw:near
	externdef	box_draw:near
	externdef	box_drawshaded:near
	externdef	filereq_open:near
	externdef	filereq_getnxtmrkd:near
	externdef	msgbox_open:near
	externdef	entrybox_open:near
	externdef	gadstr_close:near
	externdef	mem_alloc:near
	externdef	mem_alloc0:near
	externdef	mem_free:near
	externdef	strcpy:near
	externdef	strcpylen:near
	externdef	strsrch:near
	externdef	strjoin:near
	externdef	strcmp:near
	externdef	stritoa:near
	externdef	stratoi:near
	externdef	stradddefext:near
	externdef	dos_read4:near
	externdef	dos_write4:near

;C functions

	externdef	conv_ftoi_:near
	externdef	conv_radtoi_:near

;Img functions

	externdef	imgmode_init:near
	externdef	pal_makemergemap:near

;Tex functions

	externdef	tex_drawface:near


	.data
	externdef	menu_p:dword
	externdef	gadlstmain_p:dword
	externdef	gadlst_p:dword
	externdef	gadfuncmain_p:dword
	externdef	gadfunc_p:dword
	externdef	key_p:dword
	externdef	maindraw_p:dword

	externdef	progname2_s:byte
	externdef	mpfree:dword

	externdef	fname_s:byte
	externdef	fnametmp_s:byte
	externdef	fmode:byte
	externdef	slaveon:byte
	externdef	prtcolors:word
	externdef	prtbuf_s:byte
	externdef	linex2:dword
	externdef	liney2:dword
	externdef	box1:BOX
	externdef	font_t:byte
	externdef	font6_t:byte
	externdef	load_s:byte
	externdef	save_s:byte
	externdef	rerror_s:byte
	externdef	werror_s:byte
	externdef	rusure_s:byte
	externdef	fileerr:byte

	externdef	mousex:word
	externdef	mousey:word
	externdef	mousebut:byte
	externdef	mousebchg:byte

;IMG data
	externdef	img_p:dword
	externdef	palmrgmap_t:byte



NETON	equ	0


;****************************************************************
;* Data

	.data

main_menu\
	MENU	{ @F, 10*8, main_s, main_mi, 19*8 }
main_s	db	"Main",0
main_mi	MENUI	{ m1_s,_3d_main_exit_stub }
	MENUI	{ m2_s,world_clear }
	MENUI	{ m3_s,world_loadreq }
	MENUI	{ m4_s,world_savereq }
	MENUI	{ m5_s,world_savegamreq }
	MENUI	{ m6_s,world_loadgeoreq }
	MENUI	{ m7_s,model_loadj3req }
	MENUI	{ m8_s,model_loadgeoreq }
	MENUI	{ m9_s,tga_loadreq }
	MENUI	{ m10_s,tga_reloadreq }
	MENUI	{ m11_s,_3d_help_main_stub }
	dd	0
m1_s	db	"EXIT (ESC)",0
m2_s	db	"CLEAR WORLD",0
m3_s	db	"LOAD WORLD (A-l)",0
m4_s	db	"SAVE WORLD (A-s)",0
m5_s	db	"SAVE GAM",0
m6_s	db	"LOAD GEO WORLD",0
m7_s	db	"LOAD J3 MODEL (l)",0
m8_s	db	"LOAD GEO MODEL (L)",0
m9_s	db	"LOAD TGA ()",0
m10_s	db	"RELOAD TGA ()",0
m11_s	db	"HELP (h)",0
@@:
	MENU	{ @F, 10*8, g_s, g_mi, 15*8 }
g_s	db	"Global",0
g_mi	MENUI	{ g1_s,map_setflrhgt }
	MENUI	{ g2_s,mlst_center }
	MENUI	{ g3_s,mlst_delete }
	dd	0
g1_s	db	"SET FLOOR HGT",0
g2_s	db	"X",0
g3_s	db	"X",0
@@:
	MENU	{ @F, 15*8, m_s, m_mi, 15*8 }
m_s	db	"Model",0
m_mi	MENUI	{ md1_s,mlst_onground }
	MENUI	{ md2_s,mlst_center }
	MENUI	{ md3_s,mlst_delete }
	dd	0
md1_s	db	"ON GROUND",0
md2_s	db	"CENTER",0
md3_s	db	"DELETE",0
@@:
	MENU	{ @F, 15*8, o_s, o_mi, 18*8 }
o_s	db	"Object",0
o_mi	MENUI	{ o1_s,olst_onground }
	MENUI	{ o2_s,olst_delete }
	MENUI	{ o3_s,olst_mrkall }
	MENUI	{ o4_s,olst_unmrkall }
	MENUI	{ o5_s,olst_invertmrks }
	MENUI	{ o6_s,olst_deletemrkd }
	MENUI	{ o7_s,olst_duplicatemrkd }
	dd	0
o1_s	db	"ON GROUND",0
o2_s	db	"DELETE (DEL)",0
o3_s	db	"MARK ALL (m)",0
o4_s	db	"UNMARK ALL (M)",0
o5_s	db	"INVERT MARKS",0
o6_s	db	"DELETE MARKED",0
o7_s	db	"DUPLICATE MARKED",0
@@:
	MENU	{ 0, 15*8, i_s, i_mi, 15*8 }
i_s	db	"Image",0
i_mi	MENUI	{ i1_s,i2lst_delete }
	MENUI	{ i2_s,i2lst_delete }
	dd	0
i1_s	db	"DELETE",0
i2_s	db	"xxxx",0



MAPID	equ	0
FACEID	equ	100h
MLSTID	equ	200h
OLSTID	equ	300h


ID=MAPID
D3BOXX	equ	324
D3BOXY	equ	10
X=D3BOXX+4
Y=D3BOXY+4

main_gad\
	GAD	{ @F, X,Y, 13,11, c1_wh, c4arr_s, GADF_DN, ID }
@@:
	GAD	{ @F, X,Y+12, 13,11, c1_wh, c4arr_s, GADF_DN, ID+1 }
@@:
	GAD	{ @F, X,Y+12*2, 13,11, c1_wh, c4arr_s, GADF_DN, ID+10h }
@@:
	GAD	{ @F, X,Y+12*3, 13,11, c1_wh, c4arr_s, GADF_DN, ID+14h }
@@:
	GAD	{ @F, X,Y+12*4, 13,11, c1_wh, c4arr_s, GADF_DN, ID+18h }
@@:
	GAD	{ @F, X,Y+13*5, 5*8+4,11, c5_wh, vdist_s, GADF_STR, ID+1ch }
vdist_s	db	"50000",0
	align	4
viewdist	dd	-50000	;View range
@@:
	GAD	{ @F, X,Y+13*6, 2*8+4,11, c2_wh, oil_s, GADF_STR, ID+1eh }
oil_s	db	"0",0,0

D3MAPX	equ	424
D3MAPY	equ	0
X=D3MAPX
Y=D3MAPY

@@:
	GAD	{ @F, X+80,Y, 13,11, c1_wh, c4arr_s, GADF_DN, ID+44h }
@@:
fhgt_gad\
	GAD	{ @F, MAPPX-30,MAPPY, 13,103, fch_wh, 0, GADF_MV, ID+60h }
fch_wh	dw	11,101
@@:
chgt_gad\
	GAD	{ @F, MAPPX-15,MAPPY, 13,103, fch_wh, 0, GADF_MV, ID+64h }
@@:
	GAD	{ @F, MAPPX,MAPPY, MAPPW,MAPPH, 0, 0, GADF_MV+GADF_UP+GADF_DNR, ID+48h }
@@:
	GAD	{ @F, X,Y, 4*8,11, c3_wh, putm_s, GADF_DN, ID+28h }
putm_s	db	"PUT",0
@@:
mapmmode_gad\
	GAD	{ @F, X,Y+13, 5*8,11, c4_wh, mdw_s, GADF_DN, ID+20h }
mdw_s	db	"Wall",0
mdf_s	db	"Flr",0
mdc_s	db	"Ceil",0
mdb_s	db	"Blk",0
@@:
mapgsmode_gad\
	GAD	{ @F, X+5*8,Y+13, 9*8,11, c8_wh, grds_s, GADF_DN, ID+24h }
grds_s	db	"GridSnap",0
grdh_s	db	"GridHalf",0
grdf_s	db	"GridFree",0
@@:
	GAD	{ @F, X+14*8,Y+13, 4*8,11, c4_wh, maph_s, GADF_STR, ID+50h }
maph_s	db	"0",0,0,0,0
@@:
	GAD	{ @F, X+19*8,Y+13, 4*8,11, c4_wh, mapil_s, GADF_STR, ID+54h }
mapil_s	db	"0",0,0,0,0


FACEX	equ	96
FACEY	equ	200
FACETW	equ	128
FACETH	equ	128
ID=FACEID
X=FACEX
Y=FACEY
X2=FACEX+64
Y2=FACEY+64

@@:
	GAD	{ @F, X+2*8,Y, 9*8,11, c8_wh, putf_s, GADF_DN, ID }
putf_s	db	"PUT FACE",0
@@:
	GAD	{ @F, X+32,Y+15, FACETW,FACETH, 0, 0, GADF_MV+GADF_MVR, ID+4 }
@@:
	GAD	{ @F, X2+12*8,Y+43, 13,11, c1_wh, cH_s, GADF_DN, ID+8 }
@@:
	GAD	{ @F, X2+14*8,Y+43, 13,11, c1_wh, cV_s, GADF_DN, ID+9 }
@@:
	GAD	{ @F, X2+16*8,Y+43, 13,11, c1_wh, cR_s, GADF_DN, ID+0ah }
@@:
	GAD	{ @F, X2+12*8,Y+30, 4*8,11, c3_wh, tga_s, GADF_DN, ID+10h }
tga_s	db	"TGA",0
@@:
	GAD	{ @F, X+2*8,Y2+94, 17*8,11, c16_wh, fciv_s, GADF_DN, ID+18h }
fciv_s	db	"1 2 3 4 5 6 7 8",0
@@:
	GAD	{ @F, X,Y+20, 13,11, c1_wh, c4arr_s, GADF_DN, ID+20h }
@@:
	GAD	{ @F, X,Y+32, 13,11, c1_wh, c4arr_s, GADF_DN, ID+24h }
@@:
	GAD	{ @F, X+3*8,Y2+80, 13,11, c1_wh, c4arr_s, GADF_DN, ID+40h }
@@:
	GAD	{ @F, X+5*8,Y2+80, 13,11, c1_wh, c4arr_s, GADF_DN, ID+44h }


MLSTX	equ	320
MLSTY	equ	220
MLSTW	equ	320-4
MLSTH	equ	MLSTROW*9+6
MLSTROW	equ	8
ID=MLSTID

@@:
	GAD	{ @F, MLSTX,MLSTY, 12*8,MLSTH, mlst_wh, 0, GADF_MV+GADF_MVR, ID }
mlst_wh	word	MLSTW,MLSTH

@@:
	GAD	{ @F, 290,200, 13,11, c1_wh, cF_s, GADF_DN, ID+20h }
@@:
	GAD	{ @F, 306,200, 13,11, c1_wh, c4arr_s, GADF_DN, ID+30h }
@@:
	GAD	{ @F, 290,214, 13,11, c1_wh, c4arr_s, GADF_DN, ID+40h }


OLSTX	equ	320
OLSTY	equ	MLSTY+MLSTH+4
OLSTW	equ	320-4
OLSTH	equ	OLSTROW*9+4
OLSTROW	equ	9
ID=OLSTID

@@:
	GAD	{ @F, OLSTX,OLSTY, 11*8,OLSTH, olst_wh, 0, GADF_MV+GADF_MVR, ID }
olst_wh	word	OLSTW,OLSTH
@@:
	GAD	{ @F, OLSTX+270,OLSTY, 5*8,OLSTH, 0, 0, GADF_DN+GADF_DNR, ID+10h }
@@:
	GAD	{ @F, 288,300, 13,11, c1_wh, c4arr_s, GADF_DN, ID+20h }
@@:
	GAD	{ @F, 304,300, 13,11, c1_wh, cudarr_s, GADF_DN, ID+30h }
@@:
	GAD	{ @F, 288,314, 13,11, c1_wh, c4arr_s, GADF_DN, ID+40h }
@@:
	GAD	{ @F, 304,314, 13,11, c1_wh, cudarr_s, GADF_DN, ID+44h }
@@:
	GAD	{ 0, OLSTX+256,OLSTY+OLSTH, 6*8,11, c6_wh, olstf_s, GADF_STR, ID+0c0h }
olstf_s	db	"0",0,0,0,0




c1_wh	dw	11,9
c2_wh	dw	2*8+4,9
c3_wh	dw	3*8+4,9
c4_wh	dw	4*8+4,9
c5_wh	dw	5*8+4,9
c6_wh	dw	6*8+4,9
c8_wh	dw	8*8+4,9
c12_wh	dw	12*8+4,9
c16_wh	dw	16*8+4,9

c4arr_s	db	28,0	;4 way arrow
cudarr_s db	30,0	;Updn arrow
cast_s	db	"*",0
cF_s	db	"F",0
cH_s	db	"H",0
cR_s	db	"R",0
cV_s	db	"V",0

fmatchwd_s	db	"*.WD",0,0,0,0,0,0,0,0,0
fmatchgam_s	db	"*.GAM",0,0,0,0,0,0,0,0,0
fmatchged_s	db	"*.GED",0,0,0,0,0,0,0,0
fmatchgeo_s	db	"*.GEO",0,0,0,0,0,0,0,0
fmatchtga_s	db	"*.TGA",0,0,0,0,0,0,0,0
fmatchj3_s	db	"*.J3",0,0,0,0,0,0,0,0,0

wdext_s		db	".WD",0
gamext_s	db	".GAM",0
grpext_s	db	".GRP",0
geoext_s	db	".GEO",0
tgaext_s	db	".TGA",0

wrldid_s	db	"WD",0,0

	align	4

gadfunc_t\			;Routines for buttons on gads
	dd	_3d_main_gads
	dd	face_gads
	dd	mlst_gads
	dd	olst_gads


viewstepsize	dd	500


WD	macro	W,D
	dw	W
	dd	D
	endm


key_t	equ	$			;Routines for main key presses
	WD	27,main_exit		;Esc
	WD	'h',help_main
	WD	2600h,world_loadreq
	WD	'l',model_loadj3req
	WD	'L',model_loadgeoreq
;	WD	's',main_savei
	WD	'f',main_redraw
	WD	'd',dmode_nxt
;	WD	'D',iwin_keys
;	WD	'r',iwin_keys
;	WD	't',palblk_togtruc
	WD	'i',facep_showfullimg
	WD	3b00h,imgmode_init	;F1
	WD	3c00h,_3d_run		;F2
;	WD	3d00h,_3d_vunitrun	;F3
;	WD	4100h,ilst_keys		;F7
;	WD	4200h,ilst_keys		;F8
;	WD	8500h,iwin_keys		;F11
;	WD	8600h,iwin_keys		;F12
	WD	4800h,view_kup		;Up
	WD	5000h,view_kdn		;Dn
	WD	4b00h,view_klft		;Lft
	WD	4d00h,view_krgt		;Rgt
	WD	8d00h,view_kcup		;Ctrl up
	WD	9100h,view_kcdn		;Ctrl dn

	WD	9700h,mlst_keys		;Alt Home
	WD	9f00h,mlst_keys		;Alt End
	WD	9900h,mlst_keys		;Alt Page u
	WD	0a100h,mlst_keys	;Alt Page d

;	WD	5200h,olst_keys		;Ins
	WD	5300h,olst_delete	;Del
	WD	4700h,olst_keys		;Home
	WD	4f00h,olst_keys		;End
	WD	4900h,olst_keys		;Page u
	WD	5100h,olst_keys		;Page d
	WD	' ',olst_keys
	WD	'm',olst_unmrkall
	WD	'M',olst_mrkall
;	WD	9800h,ilst_keys		;Alt up
;	WD	0a000h,ilst_keys	;Alt dn
	WD	9b00h,view_kalft	;Alt lft
	WD	9d00h,view_kargt	;Alt rgt
;	WD	7300h,ilst_keys		;Ctrl lft
;	WD	7400h,ilst_keys		;Ctrl rgt
;	WD	7700h,ilst_keys		;C home
;	WD	7500h,ilst_keys		;C end
;	WD	9300h,ilst_keys		;C del
;	WD	19h,ilst_keys		;C Y
;	WD	1ah,ilst_keys		;C Z
;	WD	2e00h,ilst_clrxdata	;Alt c
;	WD	1f00h,ilst_savelbm	;Alt s
;	WD	0ch,ilst_loadtga	;Ctrl l
;	WD	13h,ilst_savetga	;Ctrl s
;	WD	'-',ilst_keys
;	WD	'+',ilst_keys
;	WD	'a',ilst_keys
	word	-1






texfname_s	db	"IMG\TEX.IMG",0
	.data?
teximgloaded	db	?
	even

	.data
configfname_s	db	"TANK.CFG",0
vererr_s	db	"Old version! GETTANK",0
start_s		db	" GET READY!",0
joinin_s	db	" ARRIVED!",0
hitby_s		db	" HIT YOU.",0
killby_s	db	" KILLED BY ",0
you_s		db	"YOU!",0
logout_s	db	" LOGGED OUT!",0


PRCNUM	equ	200

PRC	struct
	NXT_p	dd	?		;* next process or 0
	WAKE_p	dd	?		;* wakeup code
	SLP	word	?		;Sleep countdown
	ID	word	?		;Type ID
	REDI	dd	?		;Saved copy of reg EDI
	DATA	dd	20 dup (?)	;Data space
PRC	ends


CREATE	macro	ID,CODE

	if	ID
	mov	ax,ID
	else
	CLR	eax
	endif
	mov	ebx,CODE
	call	prc_create

	endm

SLEEP	macro	T
	mov	ax,T
	call	prc_slp
	endm

DIE	macro
	jmp	prc_die
	endm

STRUCTPD macro
SOFF=PRC.DATA
	endm

ST_B	macro	L
L	equ	BPTR SOFF
SOFF=SOFF+1
	endm

ST_W	macro	L
L	equ	WPTR SOFF
SOFF=SOFF+2
	endm

ST_D	macro	L
L	equ	DPTR SOFF
SOFF=SOFF+4
	endm

FACEM	macro	C,N1,N2,N3,N4
	dd	C,N1*12,N2*12,N3*12,N4*12
	dd	0,0,0ffh,0ff00ffh,0ff0000h
	endm


CLSDEAD		equ	0000h		;Noncollidable
CLSNEUT		equ	2000h		;Neutral items
CLSPLYR		equ	4000h		;Player items
CLSENMY		equ	8000h		;Enemies

TYPPSHOT	equ	200h
TYPGND		equ	300h
TYPTNK		equ	400h
TYPTNKSHOT	equ	500h
TYPNETTNK	equ	600h
TYPTRAIN	equ	700h
TYPENBUL	equ	800h
TYPENMSL	equ	900h

SUBHL		equ	1		;Hill
SUBHLB		equ	7		;Hill


D3NUMO	equ	5000


	.data?
dummy	byte	?			;So we can even without bss bloating!

	BSSB	d3modeinit		;1=Have been initialized

	align	4


	BSSD	dispmode		;0=Textures, 1=Solid

	BSSD	model_p			;* 1st MDL structure or 0
	BSSD	modellast_p		;* last MDL structure selected or 0
	BSSD	modelcnt		;# of MDL strucs (0-?)
	BSSD	mlselected		;# of selected mdl (0 - cnt-1) or -1
	BSSD	ml1stprt		;1st entry to print (0 - cnt-1)

;	BSSD	model_p			;* 1st OBJ structure or 0
;	BSSD	modellast_p		;* last OBJ structure selected or 0
	BSSD	objcnt			;# of OBJ strucs (0-?)
	BSSD	objilum			;Ilumination for new objs
	BSSD	olselected		;# of selected obj (0 - cnt-1) or -1
	BSSD	ol1stprt		;1st entry to print (0 - cnt-1)
	BSSD	olflgsv			;Flags value


	BSSD	tga_p			;* 1st TGA structure or 0
	BSSD	tgalast_p		;* last TGA structure loaded or 0

	BSSD	facew			;Width
	BSSD	faceh			;Height
	BSSD	facetga_p		;*TGA struc
	BSSD	facenum			;# for unique name
	BSSD	facelineo		;Line offset
	BSSD	faceixy1		;Src internal vertice Y:X (8:8)
	BSSD	faceixy2		;^
	BSSD	faceixy3		;^
	BSSD	faceixy4		;^


	BSSW	d3scrollx
	BSSW	d3scrollz
	BSSW	d3scrolly

	align	4

chnkhdr		CHNKHDR	{?}
j3ahdr		J3AHDR	{<>}
j3imaptmp	J3IMAP	{<>}
dotshdr		DOTSHDR	{<>}
colshdr		COLSHDR	{<>}
mdlrec		MDLREC	{<>}
objrec		OBJREC	{<>}
tgarec		TGAREC	{<>}
imggam		IMGGAM	{?}
mdlgam		MDLGAM	{?}
facegam		FACEGAM	{?}
objgam		OBJGAM	{?}
geo_hdr		GEOHDR	{?}
polytmp		POLYGON	{?}
gruptmp		GRUP	{?}
grupetmp	GRUPE	{<>}
gedotmp		GEDOBJ	{<>}
tga_hdr		TGAHDR	{?}


MAPW	equ	128
MAPH	equ	128
MAPBSZ	equ	500
MAPPW	equ	24*8		;Keep a long multiple
MAPPH	equ	24*8
MAPPX	equ	13*32
MAPPY	equ	28
M_MAPH	equ	000003ffh		;*10 for hgt
M_MAPIL	equ	00001c00h
M_MAPID	equ	001fe000h
S_MAPIL	equ	10
S_MAPID	equ	13

	BSS4	map_t	,MAPW*MAPH	;Data for each position

	BSSD	mapscl			;Map scale divisor
	BSSD	mapx1			;Map mark X1 (screen rel)
	BSSD	mapy1			;^ Y1
	BSSD	mapx2			;^ X2
	BSSD	mapy2			;^ Y2
	BSSD	mapx1v			;Map mark X1 virtual scrn pos (after grid)
	BSSD	mapy1v			;^ Y1
	BSSD	mapx2v			;^ X2
	BSSD	mapy2v			;^ Y2
	BSSD	mapx1w			;Map mark X1 world pos (after grid)
	BSSD	mapy1w			;^ Y1
	BSSD	mapx2w			;^ X2
	BSSD	mapy2w			;^ Y2
	BSSD	mapmmode		;Mouse mode: 0=Wall, 1=Flr, 2=C, 3=Blk
	BSSD	mapgsmode		;Grid snap mode: 0=Grid, 1=Half, 2=Off

	BSSD	floorhgt		;Height of floor piece
	BSSD	ceilhgt			;^ ceiling


	BSSX	scrnbuf	,64*1024	;Screen buffer

	BSS	tmp_s	,80

	.data?
		align	4
tempcnt		dw	?		;Temporary count
tempcnt2	dw	?		;^
tempcnt3	dw	?		;^
temp		dw	?		;Temp value
temp2		dw	?		;^
temp3		dw	?		;^
tw1		dw	?		;Temp word
tw2		dw	?		;
tw3		dw	?		;
tw4		dw	?		;
tw5		dw	?		;
tw6		dw	?		;
tw7		dw	?		;
tw8		dw	?		;
		align	4

tl1		dd	?		;Temp long
tl2		dd	?		;^
tl3		dd	?		;^
tl4		dd	?		;^
tl5		dd	?		;^
tl6		dd	?		;^
tl7		dd	?		;^
tl8		dd	?		;^

prtx		dw	?		;X print pos
prty		dw	?		;X print pos
		align	4
imgdataw	dd	?		;Current img # bytes per line

d3runsp		dd	?
prcmem		PRC	PRCNUM dup (<>)	;Process mem
prcfree_p	dd	?		;* 1st in chain of free procs
prcact_p	dd	?		;* 1st active proc

vidpgoffset	dd	?		;Drawing offset into video page
framecnt	dd	?		;+1 per frame

txtrimg_t	dd	100 dup (?)	;ptrs to IMG strucs for textures

d3mode		dd	?

world_p		dd	?		;*1st in chain of world objs
d3vis_p		dd	?		;*1st in chain of visable objs
d3free_p	dd	?		;*1st in chain of free objs

d3objmem	D3OBJ	D3NUMO dup (<>)	;Object header mem

XPTMSZ	equ	3*20*D3NUMO

d3xptmem	dd	XPTMSZ dup (?)	;Xformed pts mem


viewx		dd	?		;X view position (24:8)
viewy		dd	?		;Y ^
viewz		dd	?		;Z ^

viewxa		dw	?		;X view angle 10:6
viewya		dw	?		;Y ^
viewza		dw	?		;Z ^
		align	4

sinax		dd	?		;View angles working sin/cos
cosax		dd	?		;
sinay		dd	?		;
cosay		dd	?		;
sinaz		dd	?		;
cosaz		dd	?		;

xrel		dd	?		;X relative to view
yrel		dd	?		;Y ^
zrel		dd	?		;Z ^

xtmp		dw	?		;Temporary X
ytmp		dw	?		;
ztmp		dw	?		;
x2tmp		dw	?		;
y2tmp		dw	?		;
z2tmp		dw	?		;
		align	4

xd		dd	?		;
yd		dd	?		;
zd		dd	?		;
x2d		dd	?		;
y2d		dd	?		;
z2d		dd	?		;

facelinecnt	dd	?		;
blinesxy	dd	?		;
tlinex		dd	?		;X pos of 1st point of top line
tliney		dd	?		;Y ^ (16:16)
tlinexlast	dd	?		;
tlineylast	dd	?		;
blinex		dd	?		;X pos of 1st point of bottom line
bliney		dd	?		;Y ^ (16:16)
blinexlast	dd	?		;
blineylast	dd	?		;
tlineyadd	dd	?		;Y add per X (16:16)
blineyadd	dd	?		;^
tlinecnt	dd	?		;Top cntdown till end of line
blinecnt	dd	?		;Bot ^
tlfo_p		dd	?		;* top line face offset
blfo_p		dd	?		;* bottom ^
firstfo_p	dd	?		;* 1st face offset
lastfo_p	dd	?		;* last ^

	BSSB	simrun			;!0=Simulator running
		align	4

d3collstop	dd	?		;!0=Stop scan on current obj
pcoll_t		dd D3NUMO+1 dup (?)	;List of objs of class player
ncoll_t		dd D3NUMO+1 dup (?)	;List of objs of class neutral
ecoll_t		dd D3NUMO+1 dup (?)	;List of objs of class enemy


joy1xcent	dw	?		;Joystick 1 center X value
joy1ycent	dw	?		;^ Y
joy1xpos	dw	?		;Joystick 1 current avrg X value
		align	4

SHLDMAX		equ	255

plcobj_p	dd	?		;* plyr chassie obj
pltobj_p	dd	?		;* plyr turret obj
plturnrate	dw	?		;Plyr turn rate (10:6)
pltturnrate	dw	?		;Plyr turret turn rate (10:6)
plnetact	dw	?		;Action flags for net
plshield	dw	?		;-=Dead,+=Shield strength
pldeadcntdn	dw	?		;Cnt down until rebirth
plnummsl	dw	?		;# of missiles (0-2)
plmslturn	dw	?		;Missile steering command (-1 to 1)
		align	4

plx		dd	?		;Plyr X position (24:8)
ply		dd	?		;Y ^
plz		dd	?		;Z ^
plyv		dd	?		;Y velocity

plxa		dw	?		;Plyr chassie X angle 10:6
plya		dw	?		;Y ^
plza		dw	?		;Z ^

pltya		dw	?		;Turret Y angle

plxlast		dd	?		;Last plyr X position (24:8)
plzlast		dd	?		;Z ^

plname_s	db	6 dup (?)	;5 Ascii chars

NETPDSZ		equ	8
netpdta_t	db	NETPDSZ*20 dup (?) ;Array of data for each net plyr

NETSTAT	struct
	X	dd	?		;X position 24:8
	Y	dd	?		;Y ^
	Z	dd	?		;Z ^
	YA	dw	?		;Y angle
	TYA	dw	?		;Turret Y angle
	SHIELD	dw	?		;Shield strength
	ACT	dw	?		;Action flags
	MSLT	dw	?		;Missile turn (-1 to 1)
	KNAME_s	db	6 dup (?)	;Killers name when I die
NETSTAT	ends


netsenddata_p	dd	?		;* net packet to send through


int8_fp		df	?		;F* Original int8 routine
int9_fp		df	?		;F* Original int9 routine

tickcnt		dw	?		;+1 by int8 handler




;*******************************
; 3D point format. Label is shown on + end of axis.
;	+---------+
;	|    Y /  | Z goes negative into screen
;	|    |/   |
;	| ---+--X |
;	|   /|    |
;       |  Z |    |
;	+---------+

WINH		equ	150
ARENAXSZ	equ	35000*256
ARENAZSZ	equ	35000*256

MVSPD		equ	10

MAPON		equ	1		;!0=Objects made from map
BLK10		equ	400
BLK5		equ	200
MAPXSZ		equ	10
MAPZSZ		equ	10


;********************************
;* Variable alignment test

; SUBRP	atst
;
;	push	model_p
;	lea	eax,chnkhdr
;	push	map_t
;	push	tw1
;	push	tl1
;	push	imgdataw
;	push	viewx
;	push	sinax
;
; SUBEND



;****************************************************************
;* Stub routines to external functions so linker won't crash

 SUBRP	_3d_main_exit_stub
	jmp	main_exit
 SUBEND

;********************************

 SUBRP	_3d_help_main_stub
	jmp	help_main
 SUBEND




;********************************
;* Init 3D editor mode
;* Trashes all

 SUBR	_3d_editorinit

	mov	menu_p,offset main_menu
	mov	key_p,offset key_t

	mov	gadlstmain_p,offset main_gad
	mov	gadlst_p,offset main_gad

	mov	gadfuncmain_p,offset gadfunc_t
	mov	gadfunc_p,offset gadfunc_t

	mov	maindraw_p,offset _3d_scrn_update

	cmp	d3modeinit,1
	je	@F
	mov	d3modeinit,1

	mov	eax,500
	mov	facew,eax
	mov	faceh,eax

	mov	ceilhgt,500

	call	_3d_init
@@:
	call	_3d_palinit


	jmp	main_draw

 SUBEND


;********************************
;* Initialize 3d editor palette
;* Trashes all non seg

 SUBRP	_3d_palinit

	call	vid_initvgapal

	CLR	al			;DAC color reg
	mov	cx,GENPALSZ
	lea	esi,genpal_t
	call	vid_setvgapal15

	mov	al,0f0h			;DAC color reg
	mov	cx,12
	lea	esi,d3pal_t
	call	vid_setvgapal18

	ret
 SUBEND

COL15	macro	R,G,B
CR=R
CG=G
CB=B
	dw	CR shl 10+CG shl 5+CB
	endm

COL15A	macro	R,G,B,N
	repeat	N
CR=CR+R
CG=CG+G
CB=CB+B
	dw	CR shl 10+CG shl 5+CB
	endm
	endm

	.data
GENPALSZ	equ	16*13
genpal_t	equ	$
	COL15	0,0,0
	COL15A	2,2,2,15
	COL15	0,0,0
	COL15A	2,0,0,15
	COL15	0,0,0
	COL15A	0,2,0,15
	COL15	0,0,0
	COL15A	0,0,2,15
	COL15	0,0,0
	COL15A	2,2,0,15
	COL15	0,0,0
	COL15A	0,2,2,15
	COL15	0,0,0
	COL15A	2,0,2,15
	COL15	0,0,0
	COL15A	2,1,0,15
	COL15	0,0,0
	COL15A	1,2,0,15
	COL15	0,0,0
	COL15A	0,2,1,15
	COL15	0,0,0
	COL15A	0,1,2,15
	COL15	0,0,0
	COL15A	2,0,1,15
	COL15	0,0,0
	COL15A	1,0,2,15




;********************************
;* Draw main screen

 SUBRP	_3d_scrn_update


	mov	ax,80			;Main box
	mov	bx,20
	mov	cx,0
	mov	dx,200
	call	box_drawshaded


;	call	palblk_draw
;	call	palblk_prtinfo


	mov	eax,mpfree
	shr	eax,10			;/1024
	mov	bx,0ffh
	mov	cx,18*8
	mov	dx,383
	call	prt_dec


	mov	esi,offset fname_s
	mov	bx,0ffh
	CLR	ecx
	mov	dx,383
	call	prt

;	mov	ax,lib_hdr.num_images
;	mov	cx,13*8
;	call	prt_dec3srj


	mov	esi,offset progname2_s
	mov	bx,0feffh
	CLR	ecx
	mov	dx,392
	call	prt

;	mov	ax,150			;W
;	mov	bx,35			;H
;	mov	cx,A3BOXX
;	mov	dx,A3BOXY
;	call	box_drawshaded
;
;	mov	esi,offset a3box_s
;	mov	bx,0feffh
;	mov	cx,A3BOXX+14
;	mov	dx,A3BOXY+18
;	call	prt


	call	gad_drawall


	mov	eax,viewy
	sar	eax,8
	mov	bx,0ffh
	mov	cx,D3BOXX+24
	mov	dx,D3BOXY+17
	call	prt_dec

	call	flrcbar_draw

	call	facep_prtsettings

	mov	eax,mlselected
	call	mlst_select

	call	mlst_prt
	call	olst_prt

	call	_3d_drawall

	ret


 SUBEND



;********************************
;* View and map window gadgets
;* AX  = Gadget ID
;* ECX = X top left offset from gad
;* EDX = Y ^

;* Trashes all

	BSSW	nviewxa
	BSSW	nviewya
	BSSW	nviewmv		;Front/back movement
	BSSW	nviewza
	BSSD	viewxold
	BSSD	viewyold
	BSSD	viewzold

 SUBRP	_3d_main_gads

	cmp	d3mode,1
	jne	x			;No init?


	push	eax

	mov	ax,viewxa
	shr	ax,6
	mov	nviewxa,ax
	mov	ax,viewya
	shr	ax,6
	mov	nviewya,ax
	mov	ax,viewza
	shr	ax,6
	mov	nviewza,ax

	mov	eax,viewx
	sar	eax,8
	mov	d3scrollx,ax

	mov	eax,viewz
	sar	eax,8
	mov	d3scrollz,ax

	mov	eax,viewy
	sar	eax,8
	mov	d3scrolly,ax

	pop	eax


	cmp	al,0
	jne	g1

	mov	eax,offset scrollwxz
	mov	cx,64
	mov	dx,cx
	mov	edi,offset d3scrollx
	call	gad_mousescroller
	jmp	x

g1:
	cmp	al,1
	jne	g2

	mov	eax,offset scrollwy
	mov	cx,64
	CLR	edx
	mov	edi,offset d3scrolly
	call	gad_mousescroller
	jmp	x

g2:
	cmp	al,10h
	jne	g3

	mov	eax,viewx
	mov	viewxold,eax
	mov	eax,viewz
	mov	viewzold,eax

	CLR	eax
	mov	nviewmv,ax

	mov	eax,offset scrollya
	mov	cx,16
	mov	dx,16
	mov	edi,offset nviewya
	call	gad_mousescroller
	jmp	x

g3:
	cmp	al,14h
	jne	g4

	mov	eax,offset scrollxa
	mov	cx,256
	CLR	edx
	mov	edi,offset nviewxa
	call	gad_mousescroller
	jmp	x

g4:
	cmp	al,18h
	jne	n18

	mov	eax,offset scrollza
	mov	cx,256
	CLR	edx
	mov	edi,offset nviewza
	call	gad_mousescroller
	jmp	x

n18:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Set view distance

	cmp	al,1ch
	jne	n1c

	lea	eax,vdist_s
	call	stratoi
	neg	eax
	mov	viewdist,eax

	jmp	x

n1c:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Set new obj ilum

	cmp	al,1eh
	jne	n1e

	lea	eax,oil_s
	call	stratoi
	mov	objilum,eax

	jmp	x

n1e:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Next map mouse mode

	cmp	al,20h
	jne	n20

	mov	eax,mapmmode
	inc	eax
	cmp	eax,3
	jbe	@F
	CLR	eax
@@:	mov	mapmmode,eax

	lea	ebx,mdw_s
	dec	eax
	jl	@F				;0?
	lea	ebx,mdf_s
	dec	eax
	jl	@F				;1?
	lea	ebx,mdc_s
	dec	eax
	jl	@F				;2?
	lea	ebx,mdb_s
@@:

	lea	esi,mapmmode_gad
	mov	[esi].GAD.TXT_p,ebx
	call	gad_draw

	jmp	x

n20:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Next map grid snap mode

	cmp	al,24h
	jne	n24

	mov	eax,mapgsmode
	inc	eax
	cmp	eax,2
	jbe	@F
	CLR	eax
@@:	mov	mapgsmode,eax

	lea	ebx,grds_s
	dec	eax
	jl	@F
	lea	ebx,grdh_s
	dec	eax
	jl	@F
	lea	ebx,grdf_s
@@:

	lea	esi,mapgsmode_gad
	mov	[esi].GAD.TXT_p,ebx
	call	gad_draw

	jmp	x

n24:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Place model

	cmp	al,28h
	jne	n28


	mov	eax,viewx
	sar	eax,8
	mov	modelx,eax

	mov	eax,viewy
	sar	eax,8
	sub	eax,300
	mov	modely,eax

	mov	eax,viewz
	sar	eax,8
	mov	modelz,eax

	mov	ax,viewxa
	shr	ax,6
	mov	modelxa,ax
	mov	ax,viewya
	neg	ax
	shr	ax,6
	mov	modelya,ax
	mov	ax,viewza
	shr	ax,6
	mov	modelza,ax

	call	model_put
	call	_3d_drawall

	jmp	x

n28:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,40h
	jne	n40



	jmp	x

n40:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Change map scale

	cmp	al,44h
	jne	n44


	mov	eax,offset @F
	mov	cx,2
	CLR	edx
	mov	edi,offset mapscl
	call	gad_mousescroller

	jmp	x

@@:
	movsx	eax,WPTR mapscl
	cmp	eax,2
	jge	@F
	mov	eax,2
@@:
	cmp	eax,500
	jle	@F
	mov	eax,500
@@:
	mov	mapscl,eax

	jmp	map_draw

n44:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Map draw gad

	cmp	al,48h
	jne	n48

	movsx	ecx,mousex
	movsx	edx,mousey

	test	mousebchg,2
	jnz	npos

	test	mousebut,1
	jz	@F			;Gad released

	test	mousebchg,1
	jz	@F			;No change?

	mov	mapx1,ecx
	mov	mapy1,edx
@@:
	mov	mapx2,ecx
	mov	mapy2,edx

	call	map_draw		;Updates virtual position

	test	mousebut,1
	jz	gadup			;Gad released

	jmp	x

gadup:
	mov	eax,mapmmode
	dec	eax
	jge	@F
	call	map_walladd
	jmp	x
@@:
	dec	eax
	jge	@F
	CLR	eax
	call	map_flrceiladd
	jmp	x
@@:
	dec	eax
	jge	@F
	mov	al,1
	call	map_flrceiladd
	jmp	x
@@:
	call	map_blkset
	jmp	x

npos:
	mov	eax,ecx
	sub	eax,MAPPX+MAPPW/2
	imul	eax,mapscl
	shl	eax,8
	add	viewx,eax

	mov	eax,edx
	sub	eax,MAPPY+MAPPH/2
	imul	eax,mapscl
	shl	eax,8
	add	viewz,eax

	test	BPTR ds:[417h],3
	jz	@F			;No shift?

	call	map_selectclosest
@@:
	call	_3d_drawall
	jmp	x

n48:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Set floor height

	cmp	al,60h
	jne	n60

	mov	eax,51
	sub	eax,edx
	mov	edx,eax
	imul	eax,10
	mov	floorhgt,eax
fcbd:
	call	flrcbar_draw

	jmp	x
n60:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Set ceiling height

	cmp	al,64h
	jne	n64

	mov	eax,51
	sub	eax,edx
	mov	edx,eax
	imul	eax,10
	mov	ceilhgt,eax

	jmp	fcbd

n64:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


x:
	ret


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

scrollwxz:
	movsx	eax,d3scrollx
	shl	eax,8
	mov	viewx,eax

	sar	eax,8
	mov	bx,0ffh
	mov	cx,D3BOXX+24
	mov	dx,D3BOXY+5
	call	prt_hexword

	movsx	eax,d3scrollz
	shl	eax,8
	mov	viewz,eax
	sar	eax,8
	add	cx,8*5
	call	prt_hexword
draw:
	call	_3d_drawall
	ret

scrollwy:
	movsx	eax,d3scrolly
	shl	eax,8
	mov	viewy,eax

	mov	ax,d3scrolly
	mov	bx,0ffh
	mov	cx,D3BOXX+24
	mov	dx,D3BOXY+17
	call	prt_dec

	jmp	draw


scrollya:
	mov	ax,nviewya
	shl	ax,6
	mov	viewya,ax
	neg	ax
	call	sinecos_get

	movsx	edx,nviewmv
	imul	eax,edx
	imul	ebx,edx
	add	eax,viewxold
	add	ebx,viewzold
	mov	viewx,eax
	mov	viewz,ebx

	mov	ax,nviewya
	and	ax,3ffh
	mov	bx,0ffh
	mov	cx,D3BOXX+24
	mov	dx,D3BOXY+29
	call	prt_dec3srj

	jmp	draw

scrollxa:
	mov	ax,nviewxa
	mov	viewxa,ax
	shr	ax,6
	mov	bx,0ffh
	mov	cx,D3BOXX+24
	mov	dx,D3BOXY+43
	call	prt_dec3srj
	jmp	draw

scrollza:
	mov	ax,nviewza
	mov	viewza,ax
	shr	ax,6
	mov	bx,0ffh
	mov	cx,D3BOXX+24
	mov	dx,D3BOXY+55
	call	prt_dec3srj

	jmp	draw

 SUBEND



;********************************
;* Draw floor and ceiling hgt bars

 SUBRP	flrcbar_draw

	lea	esi,fhgt_gad
	call	gad_draw

	mov	eax,floorhgt
	cdq
	mov	ebx,10
	idiv	ebx
	mov	edx,eax

	mov	prtcolors,2fh		;Green
	mov	ecx,MAPPX-30+6
	mov	linex2,ecx
	neg	edx
	add	edx,MAPPY+49+2
	mov	liney2,edx
	mov	edx,MAPPY+49+2
	call	line_draw

	mov	prtcolors,38h		;Blue
	inc	ecx
	mov	linex2,ecx
	call	line_draw

	mov	ax,WPTR floorhgt
	mov	bx,0ffh
	mov	cx,MAPPX-4*8
	mov	dx,MAPPY+105
	call	prtf6_dec3srj

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	lea	esi,chgt_gad
	call	gad_draw

	mov	eax,ceilhgt
	cdq
	mov	ebx,10
	idiv	ebx
	mov	edx,eax

	mov	prtcolors,2fh		;Green
	mov	ecx,MAPPX-15+6
	mov	linex2,ecx
	neg	edx
	add	edx,MAPPY+49+2
	mov	liney2,edx
	mov	edx,MAPPY+49+2
	call	line_draw

	mov	prtcolors,38h		;Blue
	inc	ecx
	mov	linex2,ecx
	call	line_draw

	mov	ax,WPTR ceilhgt
	mov	bx,0ffh
	mov	cx,MAPPX-4*8
	mov	dx,MAPPY+105+10
	call	prtf6_dec3srj


	ret
 SUBEND

;********************************
;* Face gadgets
;* AX = Gadget ID
;* ECX = X top left offset from gad
;* EDX = Y ^
;* Trashes all

 SUBRP	face_gads

	cmp	d3mode,1
	jne	x				;No init?

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Put face in world

	TST	al
	jne	n0

	call	model_alloc
	jz	x
	mov	esi,eax

	mov	modellast_p,esi			;Select

	mov	eax,facetga_p
	mov	[esi].MDL.TGA_p,eax


	mov	eax,4+sizeof XYZ*4
	call	mem_alloc
	jz	x
	mov	[esi].MDL.PTS_p,eax

	mov	DPTR [eax],4
	mov	edx,facew
	shr	edx,1				;/2
	mov	4[eax+1*sizeof XYZ].XYZ.X,edx
	mov	4[eax+2*sizeof XYZ].XYZ.X,edx
	neg	edx
	mov	4[eax+0*sizeof XYZ].XYZ.X,edx
	mov	4[eax+3*sizeof XYZ].XYZ.X,edx
	mov	edx,faceh
	mov	4[eax+0*sizeof XYZ].XYZ.Y,edx
	mov	4[eax+1*sizeof XYZ].XYZ.Y,edx
	CLR	edx
	mov	4[eax+2*sizeof XYZ].XYZ.Y,edx
	mov	4[eax+3*sizeof XYZ].XYZ.Y,edx
	mov	edx,250
	mov	4[eax+0*sizeof XYZ].XYZ.Z,edx
	mov	4[eax+1*sizeof XYZ].XYZ.Z,edx
	mov	4[eax+2*sizeof XYZ].XYZ.Z,edx
	mov	4[eax+3*sizeof XYZ].XYZ.Z,edx


	mov	eax,sizeof FACE+4
	call	mem_alloc
	jz	x
	mov	[esi].MDL.FACE_p,eax

	mov	[eax].FACE.ID,100h
	mov	[eax].FACE.V1,0*sizeof XYZ
	mov	[eax].FACE.V2,1*sizeof XYZ
	mov	[eax].FACE.V3,2*sizeof XYZ
	mov	[eax].FACE.V4,3*sizeof XYZ

	mov	edx,facelineo
	mov	[eax].FACE.LINE,edx

	mov	edx,faceixy1
	mov	[eax].FACE.IXY1,edx
	mov	edx,faceixy2
	mov	[eax].FACE.IXY2,edx
	mov	edx,faceixy3
	mov	[eax].FACE.IXY3,edx
	mov	edx,faceixy4
	mov	[eax].FACE.IXY4,edx

	mov	DPTR [eax+sizeof FACE],-1	;End



	inc	facenum
	mov	eax,facenum
	lea	edi,[esi].MDL.N_s
	call	stritoa


	mov	eax,viewy
	sar	eax,8
	sub	eax,300
	mov	modely,eax

	mov	ax,viewya
	neg	ax
	call	sinecos_get

	mov	edx,viewstepsize
	neg	edx
	imul	eax,edx
	imul	ebx,edx
	sar	eax,8
	sar	ebx,8
	add	eax,viewx
	add	ebx,viewz
	sar	eax,8
	sar	ebx,8
	mov	modelx,eax
	mov	modelz,ebx

	mov	ax,viewxa
	shr	ax,6
	mov	modelxa,ax
	mov	ax,viewya
	neg	ax
	shr	ax,6
	mov	modelya,ax
	mov	ax,viewza
	shr	ax,6
	mov	modelza,ax

	call	model_put

	call	_3d_drawall
	jmp	x
n0:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Set face ivert

	cmp	al,4
	jne	n4

	shl	ecx,1				;*2
	shl	edx,1+16			;*2
	mov	dx,cx

	CLR	eax

	test	mousebut,2
	jz	@F				;!B2
	add	eax,sizeof faceixy1
@@:
	test	BPTR ds:[417h],3
	jz	@F				;No shift?
	neg	eax
	add	eax,sizeof faceixy1*3
@@:
	mov	faceixy1[eax],edx
fprt:
	call	facep_prtsettings

	jmp	x
n4:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>H flip ivert

	cmp	al,8
	jne	n8

	lea	edi,faceixy1
	mov	eax,[edi]
	xchg	eax,sizeof faceixy1[edi]
	mov	[edi],eax

	mov	eax,(sizeof faceixy1*2)[edi]
	xchg	eax,(sizeof faceixy1*3)[edi]
	mov	(sizeof faceixy1*2)[edi],eax

	jmp	fprt
n8:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>V flip ivert

	cmp	al,9
	jne	n9

	lea	edi,faceixy1
	mov	eax,[edi]
	xchg	eax,(sizeof faceixy1*3)[edi]
	mov	[edi],eax

	mov	eax,(sizeof faceixy1*1)[edi]
	xchg	eax,(sizeof faceixy1*2)[edi]
	mov	(sizeof faceixy1*1)[edi],eax

	jmp	fprt
n9:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Rotate ivert

	cmp	al,0ah
	jne	na

	lea	edi,faceixy1
	mov	eax,[edi]
	xchg	eax,(sizeof faceixy1*1)[edi]
	xchg	eax,(sizeof faceixy1*2)[edi]
	xchg	eax,(sizeof faceixy1*3)[edi]
	mov	[edi],eax

	jmp	fprt
na:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Next tga

	cmp	al,10h
	jne	n10

	cmp	facetga_p,0
	je	use1st				;No previous face tga?

	lea	esi,tga_p			;>Find current ftga

@@:	mov	esi,[esi]
	cmp	esi,facetga_p
	je	foundtga
	TST	esi
	jnz	@B				;More?
	jmp	use1st				;Not found

foundtga:
	mov	esi,[esi]			;Get next
	TST	esi
	jnz	setft				;Valid?

use1st:
	mov	esi,tga_p
setft:
	mov	facetga_p,esi

	call	facep_prtsettings

	jmp	x
n10:


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Select position in tga

	cmp	al,18h
	jne	n18

	mov	esi,facetga_p
	TST	esi
	jz	x				;No previous face tga?

	sub	ecx,3
	jl	x
	shr	ecx,3				;/8
	CLR	eax
	shr	ecx,1				;/2
	jnc	@F
	add	eax,80h
@@:
	mov	faceixy1,eax
	add	eax,7fh
	mov	faceixy2,eax
	or	eax,7f0000h
	mov	faceixy3,eax
	sub	eax,7fh
	mov	faceixy4,eax

	shl	ecx,7				;*128
	mov	facelineo,ecx

	call	facep_prtsettings

	jmp	x
n18:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>

	cmp	al,20h
	jne	n20

	mov	eax,offset scrollh
	mov	cx,64
	CLR	edx
	mov	edi,offset faceh
	call	gad_mousescroller
	jmp	x
n20:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>

	cmp	al,24h
	jne	n24

	mov	faceh,500
prts:
	call	facep_prtsettings
	jmp	x
n24:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>

	cmp	al,40h
	jne	n40

	mov	eax,offset scrollw
	mov	cx,64
	CLR	edx
	mov	edi,offset facew
	call	gad_mousescroller
	jmp	x
n40:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>

	cmp	al,44h
	jne	n44

	mov	facew,500
	jmp	prts
n44:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>


x:
	ret

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				Place model

scrollwxz:
	movsx	eax,d3scrollx
	shl	eax,8
	mov	viewx,eax

	mov	bx,0ffh
	mov	cx,D3BOXX+24
	mov	dx,D3BOXY+5
	call	prt_hexword

	movsx	eax,d3scrollz
	shl	eax,8
	mov	viewz,eax
	add	cx,8*5
	call	prt_hexword
draw:
	call	_3d_drawall
	ret

scrollh:
	movsx	eax,WPTR faceh
	mov	faceh,eax
	jmp	facep_prtsettings

scrollw:
	movsx	eax,WPTR facew
	mov	facew,eax
	jmp	facep_prtsettings


 SUBEND



;********************************
;* Show face and settings

 SUBRP	facep_prtsettings

	local	imgx:dword,
		imgxadd:dword,
		imgyadd:dword,
		hgt:dword,
		cnt:dword

	mov	eax,faceh
	mov	bx,0ffh
	mov	cx,FACEX-4
	mov	dx,FACEY+47
	call	prt_dec

	mov	eax,facew
	mov	bx,0ffh
	mov	cx,FACEX+8*8
	mov	dx,FACEY+147
	call	prt_dec

	mov	eax,facelineo
	mov	bx,0ffh
	mov	cx,FACEX+8*8+64
	mov	dx,FACEY+151
	call	prtf6_dec3srj


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Draw texture


	mov	ax,0f00h+SC_MAPMASK	;>Clr face area
	mov	dx,SC_INDEX
	out	dx,ax

	cld

	CLR	eax
	mov	edi,0a0000h+(FACEY+15)*SCRWB+(FACEX+32)/4
	mov	edx,FACETH
clrlp:
	mov	ecx,FACETW/4/4
	rep	stosd

	add	edi,SCRWB-FACETW/4	;Next Y
	dec	edx
	jg	clrlp


	mov	ebx,facetga_p
	TST	ebx
	jz	notga

	mov	eax,facelineo
	shl	eax,8			;*256
	add	eax,[ebx].TGA.IMG_p
	mov	tl1,eax

	mov	prtx,FACEX+32

	mov	ax,(FACEY+15)*SCRWB
	mov	tempcnt,ax		;Y offset

	mov	eax,256*100h
	CLR	edx
	mov	ecx,FACETW
	idiv	ecx
	mov	imgxadd,eax

	mov	eax,256*10000h
	CLR	edx
	mov	ecx,FACETH
	idiv	ecx
	mov	imgyadd,eax

	mov	eax,[ebx].TGA.IMGH
	sub	eax,facelineo
	jle	notga
	imul	eax,DPTR FACETH
	shr	eax,8			;/256
	cmp	eax,FACETH
	jbe	@F
	mov	eax,FACETH
@@:
	mov	hgt,eax

	CLR	esi			;ESI=Img offset (24:8)
	mov	ecx,FACETW

xlp:
	push	ecx

	movsx	ecx,prtx
	inc	prtx

	mov	edi,ecx			;X
	shr	edi,2			;/4
	add	di,tempcnt		;+YO
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	mov	dx,SC_INDEX
	out	dx,ax

	mov	ecx,hgt

	push	esi
	shr	esi,8			;Remove frac
	add	esi,tl1			;+Base

	mov	ebx,8000h		;EBX=Y step (16:16)
ylp:
	mov	al,[esi]		;>Copy line
	mov	0a0000h[edi],al
	add	edi,SCRWB		;Next Y

	add	ebx,imgyadd
	mov	eax,ebx

	sar	eax,8			;Int*256 (TGA width)
	CLR	al
	add	esi,eax

	and	ebx,0ffffh
	dec	ecx
	jg	ylp


	pop	esi

	pop	ecx

	add	esi,imgxadd

	dec	ecx
	jg	xlp

notga:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Draw face outline

	lea	esi,fline_t
	mov	prtcolors,4fh		;Yellow
lnlp:
	lodsd
	mov	ecx,[eax]
	mov	edx,ecx
	movzx	ecx,cx
	shr	ecx,1
	shr	edx,16+1
	add	ecx,FACEX+32
	add	edx,FACEY+15

	mov	eax,[esi]
	TST	eax
	jz	lndn
	mov	eax,[eax]
	mov	ebx,eax
	movzx	eax,ax
	shr	eax,1
	shr	ebx,16+1
	add	eax,FACEX+32
	add	ebx,FACEY+15
	mov	linex2,eax
	mov	liney2,ebx

	call	line_draw

	mov	prtcolors,2bh		;Green
	jmp	lnlp
lndn:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Prt XY coords

	mov	cnt,4

	lea	esi,faceixy1
	mov	dx,FACEY+60
fxylp:
	mov	eax,[esi]
	mov	bx,0ffh
	mov	cx,FACEX+FACETW+4*8
	push	esi
	call	prtf6_dec3srj
	pop	esi

	mov	ax,2[esi]
	add	ecx,4*8
	push	esi
	call	prtf6_dec3srj
	pop	esi

	add	esi,4
	add	edx,6

	dec	cnt
	jg	fxylp



	ret
 SUBEND

	.data
fline_t	dd	faceixy1,faceixy2,faceixy3,faceixy4,faceixy1,0
	.code



;********************************
;* Show face and settings

X=0
Y=0
FACEFTW	equ	64
FACEFTH	equ	64

 SUBRP	facep_showfullimg

	local	imgx:dword,
		imgxadd:dword,
		imgyadd:dword,
		hgt:dword,
		xpos:dword,
		xcnt:dword


	CLR	eax
	mov	xpos,eax

	mov	xcnt,10

	lea	esi,tga_p
lp:
	push	esi

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Draw texture


;	mov	ax,0f00h+SC_MAPMASK	;>Clr face area
;	mov	dx,SC_INDEX
;	out	dx,ax
;
;	cld
;
;	CLR	eax
;	mov	edi,0a0000h+Y*SCRWB+X/4
;	mov	edx,FACEFTH
;clrlp:
;	mov	ecx,FACEFTW/4/4
;	rep	stosd
;
;	add	edi,SCRWB-FACEFTW/4	;Next Y
;	dec	edx
;	jg	clrlp


	mov	ebx,[esi]

;	mov	ebx,facetga_p
	TST	ebx
	jz	notga

	mov	eax,facelineo
	shl	eax,8			;*256
	add	eax,[ebx].TGA.IMG_p
	mov	tl1,eax

	mov	eax,xpos
	mov	prtx,ax

	mov	ax,(Y)*SCRWB
	mov	tempcnt,ax		;Y offset

	mov	eax,256*100h
	CLR	edx
	mov	ecx,FACEFTW
	idiv	ecx
	mov	imgxadd,eax

	mov	eax,256*10000h
	CLR	edx
	mov	ecx,FACEFTH
	idiv	ecx
	mov	imgyadd,eax

	mov	eax,[ebx].TGA.IMGH
	sub	eax,facelineo
	jle	notga
	imul	eax,DPTR FACEFTH
	shr	eax,8			;/256
	cmp	eax,FACEFTH*3
	jbe	@F
	mov	eax,FACEFTH*3
@@:
	mov	hgt,eax

	CLR	esi			;ESI=Img offset (24:8)
	mov	ecx,FACEFTW

xlp:
	push	ecx

	movsx	ecx,prtx
	inc	prtx

	mov	edi,ecx			;X
	shr	edi,2			;/4
	add	di,tempcnt		;+YO
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	mov	dx,SC_INDEX
	out	dx,ax

	mov	ecx,hgt

	push	esi
	shr	esi,8			;Remove frac
	add	esi,tl1			;+Base

	mov	ebx,8000h		;EBX=Y step (16:16)
ylp:
	mov	al,[esi]		;>Copy line
	mov	0a0000h[edi],al
	add	edi,SCRWB		;Next Y

	add	ebx,imgyadd
	mov	eax,ebx

	sar	eax,8			;Int*256 (TGA width)
	CLR	al
	add	esi,eax

	and	ebx,0ffffh
	dec	ecx
	jg	ylp


	pop	esi

	pop	ecx

	add	esi,imgxadd

	dec	ecx
	jg	xlp

notga:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	pop	esi
	mov	esi,[esi]
	TST	esi
	jz	x

	add	xpos,FACEFTW

	dec	xcnt
	jg	lp

x:
	ret
 SUBEND



;********************************
;* Change to next display mode

 SUBRP	dmode_nxt

	xor	dispmode,1

	jmp	_3d_drawall

 SUBEND


;********************************
;* Up key

 SUBRP	view_kup

	call	view_chkkeybuf

	mov	ax,viewya
	add	ax,8000h
	jmp	view_step

 SUBEND

;********************************
;* Down key

 SUBRP	view_kdn

	call	view_chkkeybuf

	mov	ax,viewya
	jmp	view_step

 SUBEND

;********************************
;* Left key

 SUBRP	view_klft

	call	view_chkkeybuf

	sub	viewya,10000h/16
	jmp	_3d_drawall

 SUBEND

;********************************
;* Right key

 SUBRP	view_krgt

	call	view_chkkeybuf

	add	viewya,10000h/16
	jmp	_3d_drawall

 SUBEND

;********************************
;* Alt left key

 SUBRP	view_kalft

	call	view_chkkeybuf

	mov	ax,viewya
	add	ax,4000h
	jmp	view_step

 SUBEND

;********************************
;* Alt right key

 SUBRP	view_kargt

	call	view_chkkeybuf

	mov	ax,viewya
	sub	ax,4000h
	jmp	view_step

 SUBEND

;********************************
;* Ctrl up key

 SUBRP	view_kcup

	call	view_chkkeybuf

	mov	eax,viewstepsize
vkcup::
	shl	eax,8
	add	viewy,eax
	jmp	_3d_drawall

 SUBEND

;********************************
;* Ctrl dn key

 SUBRP	view_kcdn

	call	view_chkkeybuf

	mov	eax,viewstepsize
	neg	eax
	jmp	vkcup

 SUBEND


;********************************
;* Don't return if others keys are in buffer

 SUBRP	view_chkkeybuf

	mov	dx,ds:[41ah]
	cmp	dx,ds:[41ch]
	je	x			;No other key in buffer?

	pop	eax			;Remove ret addr
x:
	ret

 SUBEND

;********************************
;* Step view in direction
;* AX=Dir (10:6)

 SUBRP	view_step

	neg	ax
	call	sinecos_get

	mov	edx,viewstepsize
	imul	eax,edx
	imul	ebx,edx
	sar	eax,8
	sar	ebx,8
	add	viewx,eax
	add	viewz,ebx

	jmp	_3d_drawall

 SUBEND


;********************************
;* Update display and stats

 SUBRP	_3d_drawall

	call	map_draw
	call	_3d_build
	call	_3d_draw

	ret

 SUBEND


;********************************
;* Clear all objects from world

 SUBRP	world_clear

	CLR	al
	mov	esi,offset rusure_s
	call	msgbox_open
	jnz	main_draw


	call	_3d_init

;FIX! - Free properly

	mov	tga_p,0
	mov	model_p,0

	jmp	main_draw

 SUBEND

;********************************
;* Call requester for 3d world load

 SUBR	world_loadreq

	lea	eax,fmatchwd_s
	lea	ebx,world_load
	lea	esi,load_s
	mov	fmode,2
	jmp	filereq_open

 SUBEND


;********************************
;* Load world

 SUBRP	world_load

	local	cnt1:dword,
		cnt2:dword

;FIX - free properly
	mov	tga_p,0
	mov	model_p,0


	mov	fileerr,1

	lea	edx,fname_s
	I21OPENR
	jc	error2
	mov	ebx,eax				;BX=File handle


	mov	ecx,3*4				;Read ID,version & model cnt
	lea	edx,tl1
	I21READ
	jc	error

	mov	eax,DPTR wrldid_s
	cmp	tl1,eax
	jne	error				;!WD?


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read models

	mov	ecx,tl3				;#
	TST	ecx
	jle	nomdl
	mov	cnt1,ecx
mdllp:
	mov	ecx,sizeof mdlrec
	lea	edx,mdlrec
	I21READ
	jc	error

	call	model_alloc
	jz	error
	mov	esi,eax

	lea	edi,mdlrec

	movzx	eax,[edi].MDLREC.TGAI
	mov	[esi].MDL.TGA_p,eax

	mov	eax,DPTR [edi].MDLREC.N_s
	mov	DPTR [esi].MDL.N_s,eax
	mov	eax,DPTR 4[edi].MDLREC.N_s
	mov	DPTR 4[esi].MDL.N_s,eax

	movsx	eax,[edi].MDLREC.PTCNT
	mov	edx,eax
	imul	eax,sizeof XYZ
	mov	ecx,eax
	add	eax,4
	call	mem_alloc
	jz	error
	mov	[esi].MDL.PTS_p,eax
	mov	[eax],edx			;Save cnt

	mov	edx,eax
	add	edx,4
	I21READ					;Vertices
	jc	error

	movsx	eax,[edi].MDLREC.FACECNT
	mov	edx,eax
	imul	eax,sizeof FACE
	mov	ecx,eax
	add	eax,4
	call	mem_alloc
	jz	error
	mov	[esi].MDL.FACE_p,eax

	mov	edx,eax
	I21READ					;Faces
	jc	error

	add	edx,ecx
	mov	DPTR [edx],-1			;End marker


	dec	cnt1
	jg	mdllp

nomdl:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read tga data

	call	dos_read4			;Read cnt
	jc	error

	TST	eax
	jle	notga
	mov	cnt1,eax
tgalp:
	mov	ecx,sizeof tgarec
	lea	edx,tgarec
	mov	edi,edx
	I21READ
	jc	error

	call	tga_alloc
	jz	error
	mov	esi,eax				;ESI=* TGA struc

	movzx	eax,[edi].TGAREC.PALCNT
	mov	[esi].TGA.PALCNT,eax
	add	eax,eax				;*2
	mov	ecx,eax
	call	mem_alloc
	jz	error
	mov	[esi].TGA.PAL_p,eax

	mov	edx,eax
	I21READ					;Pal data
	jc	error

	mov	eax,DPTR [edi].TGAREC.N_s
	mov	DPTR [esi].TGA.N_s,eax
	mov	eax,DPTR 4[edi].TGAREC.N_s
	mov	DPTR 4[esi].TGA.N_s,eax

	movsx	edx,[edi].TGAREC.IMGW
	cmp	edx,256
	jne	error				;Bad width?
	movsx	eax,[edi].TGAREC.IMGH
	mov	[esi].TGA.IMGH,eax
	imul	eax,edx
	mov	ecx,eax
	add	eax,eax				;*2
	call	mem_alloc
	jz	error
	mov	[esi].TGA.IMG_p,eax

	mov	edx,eax
	I21READ					;Pixels
	jc	error



;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Copy img data

	mov	ecx,[esi].TGA.IMGH
	shl	ecx,8				;*256

	mov	edx,[esi].TGA.IMG_p
	mov	edi,edx
	add	edi,ecx
	shr	ecx,2				;/4
clp:	mov	eax,[edx]
	mov	[edi],eax
	add	edx,4
	add	edi,4
	loop	clp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Remap to genpal

	push	ebx

	mov	eax,[esi].TGA.PAL_p
	mov	ebx,[esi].TGA.PALCNT
	lea	ecx,genpal_t+2
	mov	edx,GENPALSZ-1
	call	pal_makemergemap

	mov	ecx,[esi].TGA.IMGH
	shl	ecx,8				;*256

	mov	edi,[esi].TGA.IMG_p
	CLR	eax
plp:	mov	al,[edi]
	TST	al
	jz	@F				;0 pix?
	mov	al,BPTR palmrgmap_t[eax]	;Get new position
	inc	al
	mov	[edi],al
@@:	inc	edi
	loop	plp

	pop	ebx

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	dec	cnt1
	jg	tgalp

notga:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Find tga for models

	lea	esi,model_p
@@:
	mov	esi,[esi]
	TST	esi
	jz	madjdn

	mov	eax,[esi].MDL.TGA_p
	call	tga_find
	mov	[esi].MDL.TGA_p,eax
	jmp	@B
madjdn:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read objects

	call	dos_read4			;Read cnt
	jc	error

	TST	eax
	jle	noobj
	mov	cnt1,eax
olp:
	mov	ecx,sizeof objrec
	lea	edx,objrec
	mov	esi,edx
	I21READ
	jc	error

	call	obj_get
	jz	error

	mov	[edi].D3OBJ.CLRNG,BLK5
	mov	[edi].D3OBJ.PRC_p,0

	mov	eax,[esi].OBJREC.X
	mov	[edi].D3OBJ.X,eax
	mov	eax,[esi].OBJREC.Y
	mov	[edi].D3OBJ.Y,eax
	mov	eax,[esi].OBJREC.Z
	mov	[edi].D3OBJ.Z,eax

	mov	ax,[esi].OBJREC.XA
	mov	[edi].D3OBJ.XA,ax
	mov	ax,[esi].OBJREC.YA
	mov	[edi].D3OBJ.YA,ax
	mov	ax,[esi].OBJREC.ZA
	mov	[edi].D3OBJ.ZA,ax

	mov	ax,[esi].OBJREC.ID
	mov	[edi].D3OBJ.ID,ax

	mov	ax,[esi].OBJREC.FLGS
	mov	[edi].D3OBJ.FLGS,ax

	mov	ax,[esi].OBJREC.ILUM
	mov	[edi].D3OBJ.ILUM,ax

	movzx	eax,[esi].OBJREC.MDLI
	call	model_find
	jz	error

	mov	[edi].D3OBJ.MDL_p,eax

	mov	edx,[eax].MDL.PTS_p
	mov	[edi].D3OBJ.PTS_p,edx

	mov	edx,[eax].MDL.FACE_p
	mov	[edi].D3OBJ.FACE_p,edx


	dec	cnt1
	jg	olp

noobj:


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read map

	call	dos_read4
	jc	error

	movzx	ecx,ax				;W
	shr	eax,16				;H
	imul	ecx,eax
	cmp	ecx,MAPW*MAPH
	jne	error

	shl	ecx,2				;*4
	lea	edx,map_t
	I21READ
	jc	error


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	mov	fileerr,0			;Clr error flag


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

error:


	I21CLOSE				;Close file

	cmp	fileerr,0
	je	ok
error2:
	mov	al,1
	mov	esi,offset rerror_s
	call	msgbox_open

ok:

	call	main_draw



	ret

 SUBEND


;********************************
;* Call requester for 3d world save

 SUBR	world_savereq

	lea	eax,fmatchwd_s
	lea	ebx,world_save
	lea	esi,save_s
	mov	fmode,0
	jmp	filereq_open

 SUBEND


;********************************
;* Save world

 SUBRP	world_save

	local	cnt1:dword,
		cnt2:dword


	mov	fileerr,1

	lea	eax,wdext_s
	lea	edi,fname_s
	call	stradddefext


	CLR	ecx				;>Create file
	lea	edx,fname_s
	I21CREATE
	jc	error2
	mov	ebx,eax				;BX=File handle


	mov	ecx,8				;>Write ID & version
	lea	edx,tl1
	mov	eax,DPTR wrldid_s
	mov	[edx],eax
	mov	DPTR 4[edx],0
	I21WRITE
	jc	error


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write models

	mov	ecx,sizeof modelcnt
	lea	edx,modelcnt
	I21WRITE
	jc	error


	CLR	eax
	mov	cnt1,eax
mdlp:
	mov	eax,cnt1
	inc	cnt1
	call	model_find
	jz	mdend
	mov	esi,eax

	lea	edx,mdlrec

	mov	eax,[esi].MDL.PTS_p
	mov	eax,[eax]
	mov	[edx].MDLREC.PTCNT,ax

	CLR	ecx				;Count faces
	mov	eax,[esi].MDL.FACE_p
flp:
	cmp	DPTR [eax],0
	jl	@F
	inc	ecx
	add	eax,sizeof FACE
	jmp	flp
@@:
	mov	[edx].MDLREC.FACECNT,cx

	mov	eax,[esi].MDL.TGA_p
	call	tga_findindx
	mov	[edx].MDLREC.TGAI,ax

	mov	eax,DPTR [esi].MDL.N_s
	mov	DPTR [edx].MDLREC.N_s,eax

	mov	eax,DPTR 4[esi].MDL.N_s
	mov	DPTR 4[edx].MDLREC.N_s,eax

	mov	eax,DPTR 8[esi].MDL.N_s
	mov	DPTR 8[edx].MDLREC.N_s,eax

	mov	ecx,sizeof mdlrec
	I21WRITE
	jc	error

	mov	edx,[esi].MDL.PTS_p
	mov	ecx,[edx]
	add	edx,4
	imul	ecx,sizeof XYZ
	I21WRITE
	jc	error

	mov	edx,[esi].MDL.FACE_p
	movzx	ecx,mdlrec.FACECNT
	imul	ecx,sizeof FACE
	I21WRITE
	jc	error

	jmp	mdlp

mdend:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write TGA data

	lea	esi,tga_p
	CLR	eax
	dec	eax
@@:
	inc	eax
	mov	esi,[esi]
	TST	esi
	jnz	@B

	mov	ecx,4
	lea	edx,tl1
	mov	[edx],eax			;Count
	I21WRITE
	jc	error


	CLR	eax
	mov	cnt1,eax
tgalp:
	mov	eax,cnt1
	inc	cnt1
	call	tga_find
	jz	tgaend
	mov	esi,eax

	lea	edx,tgarec

	mov	eax,[esi].TGA.PALCNT
	mov	[edx].TGAREC.PALCNT,ax

	mov	[edx].TGAREC.IMGW,256

	mov	eax,[esi].TGA.IMGH
	mov	[edx].TGAREC.IMGH,ax

	mov	eax,DPTR [esi].TGA.N_s
	mov	DPTR [edx].TGAREC.N_s,eax

	mov	eax,DPTR 4[esi].TGA.N_s
	mov	DPTR 4[edx].TGAREC.N_s,eax

	mov	eax,DPTR 8[esi].TGA.N_s
	mov	DPTR 8[edx].TGAREC.N_s,eax

	mov	ecx,sizeof tgarec
	I21WRITE
	jc	error

	mov	edx,[esi].TGA.PAL_p
	mov	ecx,[esi].TGA.PALCNT
	add	ecx,ecx				;*2
	I21WRITE
	jc	error

	mov	edx,[esi].TGA.IMG_p
	mov	ecx,[esi].TGA.IMGH
	movzx	eax,tgarec.IMGW
	imul	ecx,eax
	add	edx,ecx				;Offset to original copy
	I21WRITE
	jc	error

	jmp	tgalp

tgaend:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write objects

	CLR	eax				;Count
	lea	esi,world_p-D3OBJ.WNXT_p
@@:
	mov	esi,[esi].D3OBJ.WNXT_p
	TST	esi
	jz	@F

	test	[esi].D3OBJ.FLGS,SV_OF
	jz	@B				;Don't save?
	inc	eax
	jmp	@B
@@:
	mov	ecx,sizeof objcnt
	lea	edx,objcnt
	mov	[edx],eax
	I21WRITE
	jc	error


	CLR	eax
	mov	cnt1,eax
olp:
	mov	eax,cnt1
	inc	cnt1
	call	obj_find
	jz	oend
	mov	esi,eax

	test	[esi].D3OBJ.FLGS,SV_OF
	jz	olp				;Don't save?

	lea	edx,objrec

	mov	eax,[esi].D3OBJ.X
	mov	[edx].OBJREC.X,eax

	mov	eax,[esi].D3OBJ.Y
	mov	[edx].OBJREC.Y,eax

	mov	eax,[esi].D3OBJ.Z
	mov	[edx].OBJREC.Z,eax

	mov	ax,[esi].D3OBJ.XA
	mov	[edx].OBJREC.XA,ax

	mov	ax,[esi].D3OBJ.YA
	mov	[edx].OBJREC.YA,ax

	mov	ax,[esi].D3OBJ.ZA
	mov	[edx].OBJREC.ZA,ax

	mov	ax,[esi].D3OBJ.ID
	mov	[edx].OBJREC.ID,ax

	mov	ax,[esi].D3OBJ.FLGS
	mov	[edx].OBJREC.FLGS,ax

	mov	ax,[esi].D3OBJ.ILUM
	mov	[edx].OBJREC.ILUM,ax

	mov	eax,[esi].D3OBJ.MDL_p
	call	model_findindx
	jl	error
	mov	[edx].OBJREC.MDLI,ax

	mov	ecx,sizeof objrec
	I21WRITE
	jc	error

	jmp	olp

oend:


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write map

	mov	eax,MAPH*256*256+MAPW
	call	dos_write4
	jc	error

	mov	ecx,MAPW*MAPH*4
	lea	edx,map_t
	I21WRITE
	jc	error

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	mov	fileerr,0			;Clr error flag


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

error:


	I21CLOSE				;Close file

	cmp	fileerr,0
	je	ok
error2:
	mov	al,1
	mov	esi,offset werror_s
	call	msgbox_open

ok:

	call	main_draw



	ret

 SUBEND


;********************************
;* Call requester for 3d world save (.GAM format)

 SUBR	world_savegamreq

	lea	eax,fmatchgam_s
	lea	ebx,world_savegam
	lea	esi,save_s
	mov	fmode,0
	jmp	filereq_open

 SUBEND


;********************************
;* Save world

 SUBRP	world_savegam

	local	cnt1:dword,
		cnt2:dword,
		dtmp:dword

	mov	fileerr,1

	lea	eax,gamext_s
	lea	edi,fname_s
	call	stradddefext


	CLR	ecx				;>Create file
	lea	edx,fname_s
	I21CREATE
	jc	error2
	mov	ebx,eax				;BX=File handle


;	mov	ecx,8				;>Write ID & version
;	lea	edx,tl1
;	mov	eax,DPTR wrldid_s
;	mov	[edx],eax
;	mov	DPTR 4[edx],0
;	I21WRITE
;	jc	error


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write TGA data

	lea	esi,tga_p
	CLR	eax
	dec	eax
@@:
	inc	eax
	mov	esi,[esi]
	TST	esi
	jnz	@B

	mov	ecx,4
	lea	edx,tl1
	dec	eax
	mov	[edx],eax			;Count-1
	I21WRITE
	jc	error


	CLR	eax
	mov	cnt1,eax
tgalp:
	mov	eax,cnt1
	inc	cnt1
	call	tga_find
	jz	tgaend
	mov	esi,eax

	lea	edx,imggam

	mov	eax,[esi].TGA.IMGH
	mov	[edx].IMGGAM.IMGH,eax

	mov	eax,[esi].TGA.PALCNT
	inc	eax
	and	al,0feh
	mov	[edx].IMGGAM.PALCNT,eax		;Even

	mov	ecx,sizeof imggam
	I21WRITE
	jc	error

	mov	edx,[esi].TGA.PAL_p
	mov	ecx,[esi].TGA.PALCNT
	inc	ecx
	and	cl,0feh
	add	ecx,ecx				;*2
	I21WRITE
	jc	error

	mov	edx,[esi].TGA.IMG_p
	mov	ecx,[esi].TGA.IMGH
	mov	eax,256
	imul	ecx,eax
	add	edx,ecx				;Offset to original copy
	I21WRITE
	jc	error

	jmp	tgalp

tgaend:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write models

	mov	ecx,sizeof modelcnt
	lea	edx,modelcnt
	dec	DPTR [edx]
	I21WRITE
	inc	DPTR [edx]
	jc	error


	CLR	eax
	mov	cnt1,eax
mdlp:
	mov	eax,cnt1
	inc	cnt1
	call	model_find
	jz	mdend
	mov	esi,eax

	lea	edx,mdlgam

	mov	eax,[esi].MDL.TGA_p
	call	tga_findindx
	mov	[edx].MDLGAM.IMGI,eax

	mov	eax,[esi].MDL.PTS_p
	mov	eax,[eax]
	dec	eax
	mov	[edx].MDLGAM.PTCNT,eax

	mov	ecx,sizeof mdlgam
	I21WRITE
	jc	error

	mov	edx,[esi].MDL.PTS_p
	mov	ecx,[edx]
	add	edx,4
	imul	ecx,sizeof XYZ
	I21WRITE
	jc	error

	CLR	ecx				;Count faces
	mov	eax,[esi].MDL.FACE_p
flp:
	cmp	DPTR [eax],0
	jl	@F
	inc	ecx
	add	eax,sizeof FACE
	jmp	flp
@@:
	dec	ecx

	lea	edx,dtmp			;Write fcnt
	mov	[edx],ecx
	mov	ecx,4
	I21WRITE
	jc	error

	mov	edi,[esi].MDL.FACE_p
mdflp:
	lea	esi,facegam

	mov	eax,[edi].FACE.ID
	mov	[esi].FACEGAM.CTRL,eax

	mov	[esi].FACEGAM.PAL,0
;FIX!
	mov	ecx,4

	mov	eax,[edi].FACE.V1
	cdq
	idiv	ecx
	mov	[esi].FACEGAM.V1,eax

	mov	eax,[edi].FACE.V2
	cdq
	idiv	ecx
	mov	[esi].FACEGAM.V2,eax

	mov	eax,[edi].FACE.V3
	cdq
	idiv	ecx
	mov	[esi].FACEGAM.V3,eax

	mov	eax,[edi].FACE.V4
	cdq
	idiv	ecx
	mov	[esi].FACEGAM.V4,eax

	mov	al,BPTR [edi].FACE.IXY2		;X2
	mov	ah,BPTR [edi+2].FACE.IXY2	;Y2
	shl	eax,16
	mov	al,BPTR [edi].FACE.IXY1		;X1
	mov	ah,BPTR [edi+2].FACE.IXY1	;Y1
	mov	[esi].FACEGAM.ABYX,eax

	mov	al,BPTR [edi].FACE.IXY4		;X4
	mov	ah,BPTR [edi+2].FACE.IXY4	;Y4
	shl	eax,16
	mov	al,BPTR [edi].FACE.IXY3		;X3
	mov	ah,BPTR [edi+2].FACE.IXY3	;Y3
	mov	[esi].FACEGAM.CDYX,eax

	mov	eax,[edi].FACE.LINE
	mov	[esi].FACEGAM.LINE,eax

	mov	edx,esi
	mov	ecx,sizeof facegam
	I21WRITE
	jc	error

	dec	dtmp
	jge	mdflp


	jmp	mdlp

mdend:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write objects

	CLR	eax				;Count
	lea	esi,world_p-D3OBJ.WNXT_p
@@:
	mov	esi,[esi].D3OBJ.WNXT_p
	TST	esi
	jz	@F

	test	[esi].D3OBJ.FLGS,SV_OF
	jz	@B				;Don't save?
	inc	eax
	jmp	@B
@@:
	lea	edx,objcnt
	dec	eax
	mov	[edx],eax
	mov	ecx,sizeof objcnt
	I21WRITE
	inc	DPTR [edx]
	jc	error


	CLR	eax
	mov	cnt1,eax
olp:
	mov	eax,cnt1
	inc	cnt1
	call	obj_find
	jz	oend
	mov	esi,eax

	test	[esi].D3OBJ.FLGS,SV_OF
	jz	olp				;Don't save?

	lea	edx,objgam

	mov	eax,[esi].D3OBJ.X
	sar	eax,8
	mov	[edx].OBJGAM.X,eax

	mov	eax,[esi].D3OBJ.Y
	sar	eax,8
	mov	[edx].OBJGAM.Y,eax

	mov	eax,[esi].D3OBJ.Z
	sar	eax,8
	mov	[edx].OBJGAM.Z,eax

	mov	ax,[esi].D3OBJ.XA
	mov	[edx].OBJGAM.XA,eax

	mov	ax,[esi].D3OBJ.YA
	mov	[edx].OBJGAM.YA,eax

	mov	ax,[esi].D3OBJ.ZA
	mov	[edx].OBJGAM.ZA,eax

	mov	ax,[esi].D3OBJ.ID
	mov	[edx].OBJGAM.ID,eax

	mov	ax,[esi].D3OBJ.FLGS
	mov	[edx].OBJGAM.FLGS,eax

	mov	ax,[esi].D3OBJ.ILUM
	mov	[edx].OBJGAM.ILUM,eax

	mov	eax,[esi].D3OBJ.MDL_p
	call	model_findindx
	jl	error
	mov	[edx].OBJGAM.MDLI,eax

	mov	ecx,sizeof objgam
	I21WRITE
	jc	error

	jmp	olp

oend:


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write map

	mov	eax,MAPH*256*256+MAPW
	call	dos_write4
	jc	error

	mov	ecx,MAPW*MAPH*4
	lea	edx,map_t
	I21WRITE
	jc	error

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	mov	fileerr,0			;Clr error flag


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

error:


	I21CLOSE				;Close file

	cmp	fileerr,0
	je	ok
error2:
	mov	al,1
	mov	esi,offset werror_s
	call	msgbox_open

ok:

	call	main_draw



	ret

 SUBEND


;********************************
;* Call requester for 3d world load

 SUBR	world_loadgeoreq

	lea	eax,fmatchged_s
	lea	ebx,world_loadgeo
	lea	esi,load_s
	mov	fmode,2
	jmp	filereq_open

 SUBEND


;********************************
;* Load world

 SUBRP	world_loadgeo

	local	cnt1:dword,
		cnt2:dword

;FIX - free properly
	mov	model_p,0


	mov	fileerr,1

	mov	edx,offset fname_s
	I21OPENR
	jc	error2
	mov	ebx,eax				;BX=File handle


	mov	ecx,3*4				;Read SIG,version & group cnt
	mov	edx,offset tl1
	I21READ
	jc	error

	cmp	tl1,GEDSIG
	jne	error				;!Ged?


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				;>Read groups


	mov	ecx,tl3				;# groups
	TST	ecx
	jle	nogrp
	mov	cnt1,ecx
grplp:
	mov	ecx,sizeof GRUP			;Read struc
	mov	edx,offset gruptmp
	I21READ
	jc	error


	push	ebx
	mov	eax,offset gruptmp.N_s
	mov	ebx,offset grpext_s
	mov	edi,offset tmp_s
	call	strjoin
	pop	ebx

	mov	edx,offset tmp_s		;Open GRP
	I21OPENR
	jc	error


	push	ebx
	mov	ebx,eax				;File handle

	mov	ecx,8				;Header
	mov	edx,offset tl1
	I21READ
	jc	grperr

	cmp	tl1,' prg'
	jne	grperr

	mov	eax,tl2				;# models in grp
	mov	cnt2,eax
	jmp	modstrt
grpelp:
	mov	ecx,sizeof GRUPE		;Read struc
	mov	edx,offset grupetmp
	I21READ
	jc	grperr


	mov	esi,offset model_p		;Chk if already loaded
mchklp:
	mov	esi,[esi]
	TST	esi
	jz	@F
	mov	eax,offset grupetmp.N_s
	lea	edi,[esi].MDL.N_s
	call	strcmp
	jnz	mchklp				;!Match?

	mov	eax,[esi].MDL.PTS_p
	mov	modelv_p,eax
	mov	eax,[esi].MDL.FACE_p
	mov	modelf_p,eax
	mov	modellast_p,esi			;Select

	jmp	modput
@@:

	push	ebx
	lea	eax,grupetmp.N_s
	lea	ebx,geoext_s
	lea	edi,fnametmp_s
	call	strjoin
	pop	ebx

	lea	eax,fnametmp_s
	call	model_loadgeo
modput:
	mov	eax,gruptmp.X
	add	eax,grupetmp.X
	mov	modelx,eax

	mov	eax,gruptmp.Y
	add	eax,grupetmp.Y
	mov	modely,eax

	mov	eax,gruptmp.Z
	add	eax,grupetmp.Z
	neg	eax
	mov	modelz,eax

	mov	eax,offset grupetmp.XA
	call	conv_radtoi_
	mov	modelxa,ax

	mov	eax,offset grupetmp.YA
	call	conv_radtoi_
	mov	modelya,ax

	mov	eax,offset grupetmp.ZA
	call	conv_radtoi_
	mov	modelza,ax

	call	model_put
modstrt:
	dec	cnt2
	jge	grpelp
	jmp	grpok

grperr:
	mov	al,1				;Tell of error
	mov	esi,offset rerror_s
	call	msgbox_open
grpok:
	I21CLOSE				;Close file

	pop	ebx



	dec	cnt1
	jg	grplp

nogrp:


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read loose objs


	mov	ecx,4				;Read # objs
	lea	edx,cnt1
	I21READ
	jc	error

	jmp	lostrt

lolp:
	mov	ecx,sizeof GEDOBJ		;Read struc
	mov	edx,offset gedotmp
	I21READ
	jc	loerr


	mov	esi,offset model_p		;Chk if already loaded
mchk2lp:
	mov	esi,[esi]
	TST	esi
	jz	@F
	mov	eax,offset gedotmp.N_s
	lea	edi,[esi].MDL.N_s
	call	strcmp
	jnz	mchk2lp				;!Match?

	mov	eax,[esi].MDL.PTS_p
	mov	modelv_p,eax
	mov	eax,[esi].MDL.FACE_p
	mov	modelf_p,eax
	mov	modellast_p,esi			;Select

	jmp	loput
@@:

	push	ebx
	lea	eax,gedotmp.N_s
	lea	ebx,geoext_s
	lea	edi,fnametmp_s
	call	strjoin
	pop	ebx

	lea	eax,fnametmp_s
	call	model_loadgeo
loput:
	mov	eax,gedotmp.X
	mov	modelx,eax

	mov	eax,gedotmp.Y
	mov	modely,eax

	mov	eax,gedotmp.Z
	neg	eax
	mov	modelz,eax

	mov	eax,offset gedotmp.XA
	call	conv_radtoi_
	mov	modelxa,ax

	mov	eax,offset gedotmp.YA
	call	conv_radtoi_
	mov	modelya,ax

	mov	eax,offset gedotmp.ZA
	call	conv_radtoi_
	mov	modelza,ax

	call	model_put
lostrt:
	dec	cnt1
	jge	lolp
	jmp	look

loerr:
	mov	al,1				;Tell of error
	mov	esi,offset rerror_s
	call	msgbox_open
look:

nolo:
	mov	fileerr,0			;Clr error flag


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

error:

	I21CLOSE				;Close file

	cmp	fileerr,0
	je	ok
error2:
	mov	al,1
	mov	esi,offset rerror_s
	call	msgbox_open

ok:

	call	main_draw



	ret

 SUBEND



;********************************
;* Alloc MDL struc and add to list
;*>EAX = *MDL struc or 0 (CC)
;* Trashes out

 SUBRP	model_alloc

	PUSHMR	ecx,edx,esi

	mov	eax,sizeof MDL
	call	mem_alloc0
	jz	x

	lea	esi,model_p		;Find end
	CLR	ecx
lp:	mov	edx,esi
	inc	ecx			;Count em
	mov	esi,[esi]
	TST	esi
	jnz	lp

	mov	[edx],eax		;Link
;	mov	[eax],esi		;0

	mov	modelcnt,ecx
x:
	TST	eax
	POPMR
	ret

 SUBEND


;********************************
;* Find MDL struc from mlselected
;*>EAX = *MDL struc or 0 (CC)
;* Trashes out

 SUBRP	model_findsel

	mov	eax,mlselected

	;Fall through!
 SUBEND

;********************************
;* Find MDL struc from #
;* EAX = Mdl # (0-?)
;*>EAX = *MDL struc or 0 (CC)
;* Trashes out

 SUBRP	model_find

	PUSHMR	edx,esi

	CLR	edx
	dec	edx
	lea	esi,model_p

lp:	mov	esi,[esi]
	TST	esi
	jz	f			;End?
	inc	edx
	cmp	eax,edx
	jne	lp
f:
	mov	eax,esi

	TST	eax
	POPMR
	ret

 SUBEND

;********************************
;* Find MDL index from * struc
;* EAX = *MDL struc
;*>EAX = MDL # (0-?) or -1 (CC)
;* Trashes out

 SUBRP	model_findindx

	PUSHMR	edx,esi

	CLR	edx
	dec	edx
	lea	esi,model_p
lp:
	mov	esi,[esi]
	TST	esi
	jz	err			;End?
	inc	edx
	cmp	eax,esi
	jne	lp

	mov	eax,edx
	jmp	x
err:
	mov	eax,-1
x:
	TST	eax
	POPMR
	ret

 SUBEND




;********************************
;* Call requester for 3d geo model load

 SUBR	model_loadgeoreq

	mov	eax,offset fmatchgeo_s
	mov	ebx,offset @F
	mov	esi,offset load_s
	mov	fmode,3
	jmp	filereq_open

lp:
	call	model_loadgeo
@@:
	call	filereq_getnxtmrkd
	jnz	lp

	jmp	main_draw

 SUBEND


;********************************
;* Load 3D model (geo format)
;* EAX = *Filename
;* Trashes none

;	BSSD	grpx		;X to place group
;	BSSD	grpy		;Y ^
;	BSSD	grpz		;Z ^

	BSSD	modelv_p	;* Vertex data
	BSSD	modelf_p	;* Face data
	BSSD	modelx		;X to place model
	BSSD	modely		;Y ^
	BSSD	modelz		;Z ^
	BSSW	modelxa		;XA to place model
	BSSW	modelya		;YA ^
	BSSW	modelza		;ZA ^

	BSSB	color

 SUBRP	model_loadgeo

	local	fn_p:dword			;*Filename

	pushad

	mov	fn_p,eax


	mov	modelv_p,0

	mov	fileerr,1			;Set error flag

	mov	edx,eax
	I21OPENR
	jc	error2
	mov	ebx,eax				;BX=File handle


	mov	ecx,sizeof GEOHDR		;Read header
	mov	edx,offset geo_hdr
	I21READ
	jc	error

	cmp	geo_hdr.SIG,GEOSIGO
	jne	@F				;!Geo?

	mov	geo_hdr.SIG,GEOSIG
	mov	geo_hdr.PARTCNT,0
@@:
	cmp	geo_hdr.SIG,GEOSIG
	jne	error				;!Geo?

	cmp	geo_hdr.NCENT,0
	jne	error				;Has centroids?


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	CLR	ecx				;Skip ID
	mov	dx,geo_hdr.IDLEN
	I21SETFPC
	jc	error

	CLR	ecx				;Skip part defines
	mov	edx,geo_hdr.PARTCNT
	imul	dx,4*2
	I21SETFPC
	jc	error

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read vertices

	mov	eax,geo_hdr.NVERT
	imul	eax,3*4
	push	eax
	add	eax,4
	call	mem_alloc
	pop	ecx
	jz	error

	mov	modelv_p,eax
	mov	edx,eax
	mov	eax,geo_hdr.NVERT
	mov	[edx],eax			;Save cnt
	add	edx,4
	I21READ
	jc	error


	mov	esi,modelv_p
	mov	ecx,[esi]
	add	esi,4
@@:
	neg	DPTR 8[esi]			;Flip Y
	add	esi,3*4
	loop	@B


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read faces

	mov	eax,geo_hdr.NPOLY
	TST	eax
	jle	error

	imul	eax,sizeof FACE
	add	eax,4
	call	mem_alloc
	jz	error

	mov	modelf_p,eax
	mov	esi,eax
polp:
	mov	ecx,sizeof POLYGON
	mov	edx,offset polytmp
	I21READ
	jc	error

;	inc	color
;	movzx	eax,color
;	or	al,1
	mov	eax,100h
	mov	[esi].FACE.ID,eax

	mov	eax,polytmp.V1
	imul	eax,3*4
	mov	[esi].FACE.V1,eax

	mov	eax,polytmp.V2
	imul	eax,3*4
	mov	[esi].FACE.V2,eax

	mov	eax,polytmp.V3
	imul	eax,3*4
	mov	[esi].FACE.V3,eax

	mov	eax,polytmp.V4
	imul	eax,3*4
	mov	[esi].FACE.V4,eax

	mov	[esi].FACE.LINE,0
	CLR	eax
	mov	[esi].FACE.IXY1,eax
	mov	al,07fh
	mov	[esi].FACE.IXY2,eax
	mov	eax,07f007fh
	mov	[esi].FACE.IXY3,eax
	mov	eax,07f0000h
	mov	[esi].FACE.IXY4,eax

;DEBUG
	mov	edx,modelv_p			;Avrg Ys
	add	edx,4
	mov	ecx,(1*4)[esi]
	mov	eax,4[ecx][edx]
	mov	ecx,(2*4)[esi]
	add	eax,4[ecx][edx]
	mov	ecx,(3*4)[esi]
	add	eax,4[ecx][edx]
	mov	ecx,(4*4)[esi]
	add	eax,4[ecx][edx]
	sar	eax,2
	cmp	eax,100
	jl	@F
	cmp	eax,400
	jg	@F
	movzx	eax,color
	cmp	al,14
	jbe	clrok
	mov	al,0
	mov	color,al
clrok:
	or	eax,100h
	mov	[esi].FACE.ID,eax		;Force texture
@@:

	add	esi,sizeof FACE

	dec	geo_hdr.NPOLY
	jg	polp

	mov	DPTR [esi],-1			;End


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Get & setup header struc

	call	model_alloc
	jz	error

	mov	esi,eax
	mov	modellast_p,esi			;Save *

	mov	edx,modelv_p
	mov	[esi].MDL.PTS_p,edx

	mov	edx,modelf_p
	mov	[esi].MDL.FACE_p,edx

	mov	eax,fn_p
	lea	edi,[esi].MDL.N_s
	mov	ecx,8
	call	strcpylen
	mov	BPTR [edi],0

	mov	al,'.'
	lea	edi,[esi].MDL.N_s
	call	strsrch
	mov	BPTR [edi],0			;Kill extension


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				;>Load the TGA

	push	ebx
	lea	eax,[esi].MDL.N_s
	mov	ebx,offset tgaext_s
	mov	edi,fn_p
	call	strjoin
	pop	ebx

	mov	eax,fn_p
	call	tga_load
	cmp	fileerr,0
	jne	error

	mov	eax,tgalast_p
	mov	[esi].MDL.TGA_p,eax




;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	fileerr,0			;Clr error flag

error:

	I21CLOSE				;Close file

	mov	al,fileerr
	TST	al
	jz	ok
error2:
	mov	al,1
	mov	esi,offset rerror_s
	call	msgbox_open			;Must be near call

ok:
	popad
	ret

 SUBEND



;********************************
;* Call requester for 3d j3 model load

 SUBR	model_loadj3req

	mov	eax,offset fmatchj3_s
	mov	ebx,offset @F
	mov	esi,offset load_s
	mov	fmode,3
	jmp	filereq_open

lp:
	call	model_loadj3
@@:
	call	filereq_getnxtmrkd
	jnz	lp

	jmp	main_draw

 SUBEND


;********************************
;* Load 3D model (j3 format)
;* EAX = *Filename
;* Trashes none

;	BSSD	modelv_p	;* Vertex data
;	BSSD	modelf_p	;* Face data
;	BSSD	modelx		;X to place model
;	BSSD	modely		;Y ^
;	BSSD	modelz		;Z ^
;	BSSW	modelxa		;XA to place model
;	BSSW	modelya		;YA ^
;	BSSW	modelza		;ZA ^

 SUBRP	model_loadj3

	local	fn_p:dword			;*Filename

	pushad

	mov	fn_p,eax


	mov	modelv_p,0

	mov	fileerr,1			;Set error flag

	mov	edx,eax
	I21OPENR
	jc	error2
	mov	ebx,eax				;BX=File handle


	mov	ecx,8				;Read header
	lea	edx,tl1
	I21READ
	jc	error

	cmp	tl1,'FFIW'
	jne	error				;!Wiff?


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	eax,' A3J'
	call	wiff_findchunk
	jz	error


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read vertices


	mov	ecx,sizeof j3ahdr		;Read header
	lea	edx,j3ahdr
	I21READ
	jc	error


	mov	eax,j3ahdr.VNUM
	TST	eax
	jle	error

	mov	edx,eax
	imul	eax,3*4
	mov	ecx,eax
	add	eax,4
	call	mem_alloc
	jz	error

	mov	modelv_p,eax
	mov	[eax],edx			;Save cnt
	mov	edx,eax
	add	edx,4
	I21READ
	jc	error


	mov	esi,modelv_p
	mov	ecx,[esi]
	add	esi,4
@@:
	lea	eax,[esi]			;X
	call	conv_ftoi_
	mov	[esi],eax

	lea	eax,4[esi]			;Y
	call	conv_ftoi_
	mov	4[esi],eax

	lea	eax,8[esi]			;Z
	call	conv_ftoi_
	mov	8[esi],eax

	add	esi,3*4
	loop	@B


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read faces

	mov	eax,j3ahdr.FNUM
	TST	eax
	jle	error

	imul	eax,sizeof FACE
	add	eax,4
	call	mem_alloc
	jz	error

	mov	modelf_p,eax
	mov	esi,eax
polp:
	mov	ecx,4*4
	lea	edx,tl1
	I21READ
	jc	error

	mov	eax,100h
	mov	[esi].FACE.ID,eax

	mov	eax,tl1
	imul	eax,3*4
	mov	[esi].FACE.V1,eax

	mov	eax,tl2
	imul	eax,3*4
	mov	[esi].FACE.V2,eax

	mov	eax,tl3
	imul	eax,3*4
	mov	[esi].FACE.V3,eax

	mov	eax,tl4
	imul	eax,3*4
	mov	[esi].FACE.V4,eax

	mov	[esi].FACE.LINE,0
	CLR	eax
	mov	[esi].FACE.IXY1,eax
	mov	al,0ffh
	mov	[esi].FACE.IXY2,eax
	mov	eax,0ff00ffh
	mov	[esi].FACE.IXY3,eax
	mov	eax,0ff0000h
	mov	[esi].FACE.IXY4,eax

	add	esi,sizeof FACE

	dec	j3ahdr.FNUM
	jg	polp

	mov	DPTR [esi],-1			;End


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Get & setup header struc

	call	model_alloc
	jz	error

	mov	esi,eax
	mov	modellast_p,esi			;Save *

	mov	edx,modelv_p
	mov	[esi].MDL.PTS_p,edx

	mov	edx,modelf_p
	mov	[esi].MDL.FACE_p,edx

	mov	eax,fn_p
	lea	edi,[esi].MDL.N_s
	mov	ecx,8
	call	strcpylen
	mov	BPTR [edi],0

	mov	al,'.'
	lea	edi,[esi].MDL.N_s
	call	strsrch
	mov	BPTR [edi],0			;Kill extension




;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Load img data


	mov	eax,'STOD'			;DOTS
	call	wiff_findchunk
	jz	noimg


	mov	ecx,sizeof dotshdr		;Read header
	lea	edx,dotshdr
	I21READ
	jc	error


	mov	eax,sizeof TGA
	call	mem_alloc
	jz	error
	mov	esi,eax				;ESI=* TGA struc

	cmp	dotshdr.TYP,1
	jne	error

	cmp	dotshdr.W,256
	jne	error				;!256 wide?

	mov	eax,dotshdr.H
	TST	eax
	jle	error				;Less than 1?
	mov	[esi].TGA.IMGH,eax

	shl	eax,8				;*256 wide
	call	mem_alloc			;Get image mem
	jz	error

	mov	[esi].TGA.IMG_p,eax

	mov	eax,fn_p			;Copy filename
	lea	edi,[esi].TGA.N_s
	push	edi
	mov	ecx,8
	call	strcpylen
	mov	BPTR [edi],0
	pop	edi

	mov	al,'.'				;Remove extension
	call	strsrch
	mov	BPTR [edi],0

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read pixels

	mov	ecx,[esi].TGA.IMGH
	shl	ecx,8				;*256
	mov	edx,[esi].TGA.IMG_p
	I21READ
	jc	error


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read palette

	mov	eax,'SLOC'			;COLS
	call	wiff_findchunk
	jz	noimg

	mov	ecx,sizeof colshdr		;Read header
	lea	edx,colshdr
	I21READ
	jc	error

	cmp	colshdr.TYP,1
	jne	error

	movzx	ecx,colshdr.CNUM
	mov	[esi].TGA.PALCNT,ecx

	shl	ecx,1				;*2
	mov	eax,ecx
	call	mem_alloc
	jz	error

	mov	[esi].TGA.PAL_p,eax

	mov	edx,eax
	I21READ
	jc	error


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Remap to genpal

	push	ebx

	mov	eax,[esi].TGA.PAL_p
	mov	ebx,[esi].TGA.PALCNT
	lea	ecx,genpal_t+2
	mov	edx,GENPALSZ-1
	call	pal_makemergemap


	mov	ecx,[esi].TGA.IMGH
	shl	ecx,8				;*256

	mov	edi,[esi].TGA.IMG_p
	CLR	eax
plp:	mov	al,[edi]
	TST	al
	jz	@F				;0 pix?
	mov	al,BPTR palmrgmap_t[eax]	;Get new position
	inc	al
	mov	[edi],al
@@:	inc	edi
	loop	plp

	pop	ebx

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				;>Add us to tga list

	mov	eax,offset tga_p		;Find end of list
@@:	mov	edi,eax
	mov	eax,[eax]
	TST	eax
	jnz	@B

	mov	[edi],esi			;* last to me
	mov	[esi].TGA.NXT_p,eax		;0

	mov	tgalast_p,esi			;Remember me


noimg:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	eax,'PAMI'			;IMAP
	call	wiff_findchunk
	jz	noimap

	mov	ecx,2+4				;Read header
	lea	edx,tw1
	I21READ
	jc	noimap

	movsx	ecx,tw1
	TST	ecx
	jle	noimap

	imul	ecx,2+WIFFSSZ			;ID+img name string
	lea	edx,scrnbuf
	I21READ
	jc	noimap

	mov	eax,DPTR tw2
	TST	eax
	jle	noimap
imlp:
	mov	ecx,sizeof j3imaptmp
	lea	edx,j3imaptmp
	I21READ
	jc	noimap

	mov	esi,j3imaptmp.FACE
	imul	esi,sizeof FACE
	add	esi,modelf_p

	movzx	eax,j3imaptmp.LINE
	mov	[esi].FACE.LINE,eax

	movzx	eax,j3imaptmp.IXY1
	ror	eax,8
	rol	ax,8
	rol	eax,8
	mov	[esi].FACE.IXY1,eax

	movzx	eax,j3imaptmp.IXY2
	ror	eax,8
	rol	ax,8
	rol	eax,8
	mov	[esi].FACE.IXY2,eax

	movzx	eax,j3imaptmp.IXY3
	ror	eax,8
	rol	ax,8
	rol	eax,8
	mov	[esi].FACE.IXY3,eax

	movzx	eax,j3imaptmp.IXY4
	ror	eax,8
	rol	ax,8
	rol	eax,8
	mov	[esi].FACE.IXY4,eax

	dec	DPTR tw2
	jg	imlp

noimap:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	esi,modellast_p

	mov	eax,tgalast_p
	mov	[esi].MDL.TGA_p,eax



;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	fileerr,0			;Clr error flag

error:

	I21CLOSE				;Close file

	mov	al,fileerr
	TST	al
	jz	ok
error2:
	mov	al,1
	mov	esi,offset rerror_s
	call	msgbox_open			;Must be near call

ok:
	popad
	ret

 SUBEND


;********************************
;* Find WIFF chunk
;* EAX = Chunk ID
;* EBX = Filehandle
;*>EAX = ID if found or 0
;* Trashes out

 SUBRP	wiff_findchunk

	PUSHMR	ecx,edx,esi

	mov	esi,eax

	CLR	ecx
	mov	edx,8
	I21SETFPS
	jc	err
clp:
	mov	ecx,sizeof CHNKHDR		;Read header
	lea	edx,chnkhdr
	I21READ
	jc	err

	mov	eax,esi

	cmp	chnkhdr.NM,esi
	je	match

	mov	ecx,chnkhdr.SZ			;Skip chunk
	rol	cx,8				;Make intel
	rol	ecx,16
	rol	cx,8
	sub	ecx,WIFFSSZ			;Already read name
	jl	err
	mov	edx,ecx
	shr	ecx,16
	I21SETFPC
	jc	err

	jmp	clp

err:
	CLR	eax

match:
	TST	eax
	POPMR
	ret

 SUBEND


;********************************
;* Get an object for selected model and place in world
;* Trashes none

 SUBRP	model_put

	pushad

	mov	ebx,modellast_p
	TST	ebx
	jz	x

	call	obj_get
	jz	x

	mov	[edi].D3OBJ.MDL_p,ebx

	mov	eax,[ebx].MDL.PTS_p
	mov	[edi].D3OBJ.PTS_p,eax

	mov	eax,[ebx].MDL.FACE_p
	mov	[edi].D3OBJ.FACE_p,eax

	mov	[edi].D3OBJ.ID,CLSDEAD
	mov	[edi].D3OBJ.CLRNG,BLK5
	mov	[edi].D3OBJ.PRC_p,0

	mov	eax,objilum
	mov	[edi].D3OBJ.ILUM,ax

	mov	eax,modelx
	shl	eax,8
	mov	[edi].D3OBJ.X,eax
	mov	eax,modelz
	shl	eax,8
	mov	[edi].D3OBJ.Z,eax
	mov	eax,modely
	shl	eax,8
	mov	[edi].D3OBJ.Y,eax

	mov	ax,modelxa
	shl	ax,6
	mov	[edi].D3OBJ.XA,ax
	mov	ax,modelya
	shl	ax,6
	mov	[edi].D3OBJ.YA,ax
	mov	ax,modelza
	shl	ax,6
	mov	[edi].D3OBJ.ZA,ax

x:
	popad
	ret

 SUBEND


;********************************
;* Model list keys
;* AX = Key code

 SUBRP	mlst_keys

	mov	dx,ds:[41ah]
	cmp	dx,ds:[41ch]
	jne	x			;Other key in buffer?


	mov	ebx,-MLSTROW

	cmp	ah,99h
	je	sel

	mov	ebx,-1

	cmp	ah,97h
	je	sel

	neg	ebx

	cmp	ah,9fh
	je	sel

	mov	ebx,MLSTROW

	cmp	ah,0a1h
	jne	nud

sel:
	mov	edx,modelcnt

	mov	eax,mlselected
	add	eax,ebx
	jge	@F
	CLR	eax
@@:
	cmp	eax,edx
	jl	selok			;Within max?
	mov	eax,edx
	dec	eax
selok:
	jmp	mlst_select

nud:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,' '
	jne	nsp

	call	model_findsel
	jz	x			;Bad?
	xor	[eax].MDL.FLGS,MRK_MF

	call	mlst_prt
	call	map_draw

	jmp	x
nsp:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


x:
	ret

 SUBEND



;********************************
;* Model list gadgets
;* AX = Gadget ID
;* CX = X top left offset from gad
;* DX = Y ^

 SUBRP	mlst_gads

	pushad


	TST	al
	jnz	n0

	sub	dx,3
	jl	x			;Above names?

	movsx	eax,dx
	CLR	edx
	mov	ebx,9
	div	ebx
	add	eax,ml1stprt

	test	mousebut,1
	jnz	sel			;Toggle?

	test	mousebchg,2
	jnz	@F			;Toggle?

	cmp	eax,mlselected
	je	x			;Already selected?
@@:
	mov	ebx,eax
	call	model_find
	jz	x
	xor	[eax].MDL.FLGS,MRK_MF
	mov	eax,ebx
	jmp	@F
sel:
	cmp	eax,mlselected
	je	x			;Already selected?
@@:
	call	mlst_select
	jmp	x

n0:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Set new TGA info

	cmp	al,20h
	jne	n20

	call	model_findsel
	jz	x

	mov	ebx,facetga_p
	TST	ebx
	jz	x

	mov	[eax].MDL.TGA_p,ebx

	mov	eax,[eax].MDL.FACE_p
	mov	edx,facelineo
	mov	[eax].FACE.LINE,edx

	mov	edx,faceixy1
	mov	[eax].FACE.IXY1,edx
	mov	edx,faceixy2
	mov	[eax].FACE.IXY2,edx
	mov	edx,faceixy3
	mov	[eax].FACE.IXY3,edx
	mov	edx,faceixy4
	mov	[eax].FACE.IXY4,edx

	call	mlst_prt
	call	_3d_drawall
	jmp	x

n20:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


x:	popad
	ret

 SUBEND



;********************************
;* Select item from model list
;* EAX = Item # (0-?)
;* Trashes none

 SUBRP	mlst_select

	pushad

	movsx	ebx,ax
	mov	mlselected,-1

	mov	eax,ebx
	call	model_find
	jz	x
	mov	esi,eax

	mov	mlselected,ebx
	mov	modellast_p,esi


	call	mlst_prt


;	push	esi
;	mov	ax,[esi].IMG.W
;	mov	bx,0fch
;	mov	cx,24*8
;	mov	dx,384
;	call	prt_dec3srj
;	pop	esi
;
;	mov	ax,[esi].IMG.H
;	mov	bx,0fch
;	mov	cx,28*8
;	mov	dx,384
;	call	prt_dec3srj
;
;	call	img_loadpal
;	call	img_prt

x:
	popad
	ret

 SUBEND



;********************************
;* Prt list of models loaded
;* Trashes none

 SUBRP	mlst_prt

	pushad

					;>Make sure selected is visable
	mov	ebx,mlselected
	mov	eax,ml1stprt
	cmp	ebx,eax
	jb	@F			;Off top?
	sub	ebx,MLSTROW-1
	cmp	ebx,eax
	jbe	vis			;!Off bottom?
	TST	ebx
	jge	@F
	CLR	ebx
@@:	mov	ml1stprt,ebx
vis:


	mov	ax,MLSTW
	mov	bx,MLSTH
	mov	cx,MLSTX
	mov	dx,MLSTY
	call	box_drawshaded



	mov	ecx,modelcnt
	TST	ecx
	jle	x			;None?
	cmp	ecx,MLSTROW
	jbe	numok
	mov	ecx,MLSTROW
numok:

	mov	eax,ml1stprt
	mov	edi,eax
	call	model_find
	jz	x
	mov	esi,eax

	mov	dx,MLSTY+3
lp:
	push	ecx
	push	edi
	call	mlst_prt1l_ll
	pop	edi
	pop	ecx

	add	dx,9
	inc	edi

	mov	esi,[esi]
	TST	esi
	jz	x

	loop	lp

x:
	popad
	ret


 SUBEND


;********************************
;* Prt 1 line of list of models
;* ESI=*Model struc
;* Trashes none

 SUBRP	mlst_prt1l

	pushad

	mov	ebx,mlselected
	mov	edi,ebx
	sub	ebx,ml1stprt
	cmp	ebx,MLSTROW
	jae	x			;Not visable?

	mov	ax,9
	mul	bx
	add	ax,MLSTY+3
	mov	dx,ax
	mov	ax,35
	mov	bh,0fdh
	mov	cx,MLSTX+4
	call	prt_spc
	call	mlst_prt1l_ll

x:	popad
	ret

 SUBEND


;********************************
;* Prt 1 line of list of models (Low level)
;* ESI = *Model struc
;* EDI = Img # (0-?)
;* DX  = Y pos
;* Trashes A-D

 SUBRP	mlst_prt1l_ll

	push	esi

	mov	bx,0fdfch
	cmp	edi,mlselected
	jne	notsel

	mov	bx,0feffh
notsel:	mov	cx,MLSTX+14
	push	esi
	add	esi,MDL.N_s
	call	prt			;Image name
	pop	esi

	mov	ebx,[esi].MDL.PTS_p
	mov	eax,[ebx]		;# pts
	mov	bx,0fdfch
	mov	cx,MLSTX+14+8*8
	push	esi
	call	prt_dec3srj
	pop	esi

	mov	ebx,[esi].MDL.TGA_p
	TST	ebx
	jz	@F

	push	esi
	lea	esi,[ebx].TGA.N_s
	mov	bx,0fdfch
	mov	cx,MLSTX+14+13*8
	call	prt
	pop	esi

	mov	ebx,[esi].MDL.TGA_p
	mov	eax,[ebx].TGA.IMGH
	mov	bx,0fdfch
	mov	cx,MLSTX+14+22*8
	push	esi
	call	prt_dec3srj
	pop	esi
@@:

	test	[esi].MDL.FLGS,MRK_MF
	jz	nomrk
	push	esi
	mov	bx,0feffh
	mov	esi,offset cast_s
	mov	cx,MLSTX+4
	call	prt
	pop	esi
nomrk:
;
;	pop	esi
;	push	esi
;	mov	ax,[esi].IMAGE.yoff
;	mov	cx,ILSTX+136
;	call	prt_dec3srj


	pop	esi
	ret

 SUBEND


;********************************
;* Adjust selected model's Y vertices so min is 0

 SUBRP	mlst_onground

	call	model_findsel
	jz	x			;Bad selection?

	mov	esi,[eax].MDL.PTS_p	;>Find min Y
	mov	ecx,[esi]
	add	esi,4+XYZ.Y
	mov	ebx,[esi]
minlp:
	mov	edx,[esi]
	cmp	edx,ebx
	jge	@F
	mov	ebx,edx			;New min
@@:
	add	esi,sizeof XYZ
	dec	ecx
	jg	minlp


	mov	esi,[eax].MDL.PTS_p	;Adjust Y's
	mov	ecx,[esi]
	add	esi,4+XYZ.Y
adjlp:
	sub	[esi],ebx
	add	esi,sizeof XYZ
	dec	ecx
	jg	adjlp


	call	main_draw
x:
	ret

 SUBEND



;********************************
;* Center selected model's vertices about 0,0,0

 SUBRP	mlst_center

	call	model_findsel
	jz	x			;Bad selection?

	mov	esi,[eax].MDL.PTS_p	;>Find min Y
	mov	ecx,[esi]
	add	esi,4+XYZ.Y
	mov	ebx,[esi]
	mov	edi,ebx
minlp:
	mov	edx,[esi]
	cmp	edx,ebx
	jge	@F
	mov	ebx,edx			;New min
@@:
	cmp	edx,edi
	jle	@F
	mov	edi,edx			;New max
@@:
	add	esi,sizeof XYZ
	dec	ecx
	jg	minlp


	mov	esi,[eax].MDL.PTS_p	;Adjust Y's

	add	ebx,edi
	sar	ebx,1

	mov	ecx,[esi]
	add	esi,4+XYZ.Y
adjlp:
	sub	[esi],ebx
	add	esi,sizeof XYZ
	dec	ecx
	jg	adjlp


	call	main_draw
x:
	ret

 SUBEND


;********************************
;* Delete selected model and any objs using it

 SUBRP	mlst_delete

	CLR	al
	mov	esi,offset rusure_s
	call	msgbox_open
	jnz	md

	call	model_findsel
	jz	md			;Bad selection?

;	mov	esi,[eax].MDL.PTS_p	;>Find min Y
;	mov	ecx,[esi]

md:
	call	main_draw
	ret

 SUBEND




;********************************
;* Find OBJ struc from olselected
;*>EAX = *OBJ struc or 0 (CC)
;* Trashes out

 SUBRP	obj_findsel

	mov	eax,olselected

	;Fall through!
 SUBEND

;********************************
;* Find OBJ struc from #
;* EAX = Obj # (0-?)
;*>EAX = *OBJ struc or 0 (CC)
;* Trashes out

 SUBRP	obj_find

	PUSHMR	edx,esi

	CLR	edx
	dec	edx
	lea	esi,world_p-D3OBJ.WNXT_p

lp:	mov	esi,[esi].D3OBJ.WNXT_p
	TST	esi
	jz	f			;End?
	inc	edx
	cmp	eax,edx
	jne	lp
f:
	mov	eax,esi

	TST	eax
	POPMR
	ret

 SUBEND


;********************************
;* Count # OBJ strucs
;*>EAX = # of objs (0-?)
;* Trashes out

 SUBRP	obj_cnt

	PUSHMR	esi

	CLR	eax
	dec	eax
	lea	esi,world_p-D3OBJ.WNXT_p
lp:
	inc	eax
	mov	esi,[esi].D3OBJ.WNXT_p
	TST	esi
	jnz	lp				;!End?

	TST	eax
	POPMR
	ret

 SUBEND


;********************************
;* Obj list keys
;* AX = Key code

 SUBRP	olst_keys

	mov	dx,ds:[41ah]
	cmp	dx,ds:[41ch]
	jne	x			;Other key in buffer?


	mov	ebx,-OLSTROW

	cmp	ah,49h
	je	sel

	mov	ebx,-1

	cmp	ah,47h
	je	sel

	neg	ebx

	cmp	ah,4fh
	je	sel

	mov	ebx,OLSTROW

	cmp	ah,51h
	jne	nud

sel:
	CLR	edx			;>Count objs
	dec	edx
	lea	esi,world_p-D3OBJ.WNXT_p

olp:	mov	esi,[esi].D3OBJ.WNXT_p
	inc	edx
	TST	esi
	jnz	olp


	mov	eax,olselected
	add	eax,ebx
	jge	@F
	CLR	eax
@@:
	cmp	eax,edx
	jl	selok			;Within max?
	mov	eax,edx
	dec	eax
selok:
	jmp	olst_select

nud:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,' '
	jne	nsp

	call	obj_findsel
	jz	x			;Bad?
	xor	[eax].D3OBJ.FLGS,MRK_OF

	call	olst_prt
	call	map_draw

	jmp	x
nsp:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


x:
	ret

 SUBEND


;********************************
;* Object list gadgets
;* AX = Gadget ID
;* ECX = X top left offset from gad
;* EDX = Y ^

 SUBRP	olst_gads

	pushad


	TST	al
	jnz	n0

	sub	edx,3
	jl	x			;Above names?

	mov	eax,edx
	CLR	edx
	mov	ebx,9
	div	ebx
	add	eax,ol1stprt

	test	mousebut,1
	jnz	sel			;Toggle?

	test	mousebchg,2
	jnz	@F			;Toggle?

	cmp	eax,olselected
	je	x			;Already selected?
@@:
	mov	ebx,eax
	call	obj_find
	jz	x
	xor	[eax].D3OBJ.FLGS,MRK_OF
	mov	eax,ebx
	jmp	@F
sel:
	cmp	eax,olselected
	je	x			;Already selected?
@@:
	call	olst_select
	jmp	x

n0:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Change flags

	cmp	al,10h
	jne	n10

	sub	edx,3
	jl	x			;Above names?

	mov	eax,edx
	CLR	edx
	mov	ebx,9
	div	ebx
	add	eax,ol1stprt

	test	mousebut,1
	jnz	fsel			;Toggle?

	test	mousebchg,2
	jnz	@F			;Toggle?

	cmp	eax,olselected
	je	x			;Already selected?
@@:
	mov	ebx,eax
	call	obj_find
	jz	x
	mov	edx,olflgsv
	mov	[eax].D3OBJ.FLGS,dx
	mov	eax,ebx
	jmp	@F
fsel:
	cmp	eax,olselected
	je	x			;Already selected?
@@:
	call	olst_select
	jmp	x

n10:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Move current obj XZ

	cmp	al,20h
	jne	n20

	lea	edi,tw1
	CLR	eax
	mov	[edi],eax
	mov	8[edi],eax		;tw5&6
	mov	cx,32
	mov	dx,cx
	lea	eax,@F
	call	gad_mousescroller
	jmp	x

@@:
	mov	ebx,DPTR tw1
	cmp	ebx,DPTR tw5
	jne	@F			;Changed?
	ret
@@:
	call	obj_findsel
	jz	my0			;Done?

	mov	bx,tw1
	sub	bx,tw5
	movsx	ebx,bx
	shl	ebx,8
	add	[eax].D3OBJ.X,ebx
	mov	bx,tw2
	sub	bx,tw6
	movsx	ebx,bx
	shl	ebx,8
	add	[eax].D3OBJ.Z,ebx

my0:
	mov	eax,DPTR tw1
	mov	DPTR tw5,eax

	call	_3d_drawall
	jmp	olst_prt

n20:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Move current obj Y

	cmp	al,30h
	jne	n30

	lea	edi,tw1
	CLR	eax
	mov	[edi],eax
	mov	8[edi],eax		;tw5&6
	CLR	cx
	mov	dx,32
	lea	eax,@F
	call	gad_mousescroller
	jmp	x

@@:
	mov	bx,tw2
	cmp	bx,tw6
	jne	@F			;Changed?
	ret
@@:
	call	obj_findsel
	jz	sdone			;Done?

	mov	bx,tw2
	sub	bx,tw6
	movsx	ebx,bx
	shl	ebx,8
	sub	[eax].D3OBJ.Y,ebx

sdone:
	mov	eax,DPTR tw1
	mov	DPTR tw5,eax

	call	_3d_drawall
	jmp	olst_prt

n30:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Move marked obj XZ

	cmp	al,40h
	jne	n40

	lea	edi,tw1
	CLR	eax
	mov	[edi],eax
	mov	8[edi],eax		;tw5&6
	mov	cx,32
	mov	dx,cx
	lea	eax,@F
	call	gad_mousescroller
	jmp	x

@@:
	mov	ebx,DPTR tw1
	cmp	ebx,DPTR tw5
	jne	@F			;Changed?
	ret
@@:
	CLR	ecx
	dec	ecx

amlp:	inc	ecx
	mov	eax,ecx
	call	obj_find
	jz	amdone			;Done?

	test	[eax].D3OBJ.FLGS,MRK_OF
	jz	amlp

	mov	bx,tw1
	sub	bx,tw5
	movsx	ebx,bx
	shl	ebx,8
	add	[eax].D3OBJ.X,ebx
	mov	bx,tw2
	sub	bx,tw6
	movsx	ebx,bx
	shl	ebx,8
	add	[eax].D3OBJ.Z,ebx
	jmp	amlp

amdone:
	mov	eax,DPTR tw1
	mov	DPTR tw5,eax

	call	_3d_drawall
	jmp	olst_prt

n40:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Move marked obj Y

	cmp	al,44h
	jne	n44

	lea	edi,tw1
	CLR	eax
	mov	[edi],eax
	mov	8[edi],eax		;tw5&6
	CLR	ecx
	mov	dx,32
	lea	eax,@F
	call	gad_mousescroller
	jmp	x

@@:
	mov	bx,tw2
	cmp	bx,tw6
	jne	@F			;Changed?
	ret
@@:
	CLR	ecx
	dec	ecx

mmylp:	inc	ecx
	mov	eax,ecx
	call	obj_find
	jz	mmydone			;Done?

	test	[eax].D3OBJ.FLGS,MRK_OF
	jz	mmylp

	mov	bx,tw2
	sub	bx,tw6
	movsx	ebx,bx
	shl	ebx,8
	sub	[eax].D3OBJ.Y,ebx
	jmp	mmylp

mmydone:
	mov	eax,DPTR tw1
	mov	DPTR tw5,eax

	call	_3d_drawall
	jmp	olst_prt

n44:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,0c0h
	jne	nc0

	lea	eax,olstf_s
	call	stratoi
	mov	olflgsv,eax

	jmp	x

nc0:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


x:	popad
	ret

 SUBEND



;********************************
;* Select item from obj list
;* EAX = Item # (0-?)
;* Trashes none

 SUBRP	olst_select

	pushad

	movsx	ebx,ax
	mov	olselected,-1

	mov	eax,ebx
	call	obj_find
	jz	x
	mov	esi,eax

	mov	olselected,ebx


	call	olst_prt


;	push	esi
;	mov	ax,[esi].IMG.W
;	mov	bx,0fch
;	mov	cx,24*8
;	mov	dx,384
;	call	prt_dec3srj
;	pop	esi
;
;	mov	ax,[esi].IMG.H
;	mov	bx,0fch
;	mov	cx,28*8
;	mov	dx,384
;	call	prt_dec3srj
;
;	call	img_loadpal
;	call	img_prt

x:
	popad
	ret

 SUBEND



;********************************
;* Prt list of objects
;* Trashes none

 SUBRP	olst_prt

	pushad

					;>Make sure selected is visable
	mov	ebx,olselected
	mov	eax,ol1stprt
	cmp	ebx,eax
	jb	@F			;Off top?
	sub	ebx,OLSTROW-1
	cmp	ebx,eax
	jbe	vis			;!Off bottom?
	TST	ebx
	jge	@F
	CLR	ebx
@@:	mov	ol1stprt,ebx
vis:


	mov	ax,OLSTW
	mov	bx,OLSTH
	mov	cx,OLSTX
	mov	dx,OLSTY
	call	box_drawshaded



;	mov	ecx,modelcnt
;	TST	ecx
;	jle	x			;None?
;	cmp	ecx,OLSTROW
;	jbe	numok
	mov	ecx,OLSTROW
numok:

	mov	eax,ol1stprt
	mov	edi,eax
	call	obj_find
	jz	x
	mov	esi,eax

	mov	dx,OLSTY+3
lp:
	push	ecx
	push	edi
	call	olst_prt1l_ll
	pop	edi
	pop	ecx

	add	dx,9
	inc	edi

	mov	esi,[esi].D3OBJ.WNXT_p
	TST	esi
	jz	x

	loop	lp

x:
	popad
	ret


 SUBEND


;********************************
;* Prt 1 line of list of objects
;* ESI = *OBJ struc
;* Trashes none

 SUBRP	olst_prt1l

	pushad

	mov	ebx,olselected
	mov	edi,ebx
	sub	ebx,ol1stprt
	cmp	ebx,OLSTROW
	jae	x			;Not visable?

	mov	ax,9
	mul	bx
	add	ax,OLSTY+3
	mov	dx,ax
	mov	ax,35
	mov	bh,0fdh
	mov	cx,OLSTX+4
	call	prt_spc
	call	olst_prt1l_ll

x:	popad
	ret

 SUBEND


;********************************
;* Prt 1 line of list of objs (Low level)
;* ESI = *OBJ struc
;* EDI = Obj # (0-?)
;* DX  = Y pos
;* Trashes A-D

 SUBRP	olst_prt1l_ll

	push	esi

	mov	bx,0fdfch
	cmp	edi,olselected
	jne	notsel

	mov	bx,0feffh
notsel:	mov	cx,OLSTX+14
	push	esi
	mov	esi,[esi].D3OBJ.MDL_p
	TST	esi
	jz	@F
	add	esi,MDL.N_s
	call	prt			;Model name
@@:
	pop	esi

	mov	eax,[esi].D3OBJ.X
	sar	eax,8
	mov	bx,0fdfch
	mov	cx,OLSTX+14+9*8
	push	esi
	call	prt_dec
	pop	esi

	mov	eax,[esi].D3OBJ.Z
	sar	eax,8
	mov	bx,0fdfch
	mov	cx,OLSTX+14+15*8
	push	esi
	call	prt_dec
	pop	esi

	mov	eax,[esi].D3OBJ.Y
	sar	eax,8
	mov	bx,0fdfch
	mov	cx,OLSTX+14+21*8
	push	esi
	call	prt_dec
	pop	esi

	mov	ax,[esi].D3OBJ.ID
	mov	bx,0fdfch
	mov	cx,OLSTX+14+27*8
	push	esi
	call	prt_hexword
	pop	esi

	mov	ax,[esi].D3OBJ.FLGS
	add	cx,5*8
	push	esi
	call	prt_hexword
	pop	esi


	test	[esi].D3OBJ.FLGS,MRK_OF
	jz	nomrk
	push	esi
	mov	bx,0feffh
	mov	cx,OLSTX+4
	mov	esi,offset cast_s
	call	prt
	pop	esi
nomrk:
;
;	pop	esi
;	push	esi
;	mov	ax,[esi].IMAGE.yoff
;	mov	cx,ILSTX+136
;	call	prt_dec3srj


	pop	esi
	ret

 SUBEND


;********************************
;* Set selected obj on ground

 SUBRP	olst_onground

	call	model_findsel
	jz	x			;Bad selection?

	mov	esi,[eax].MDL.PTS_p	;>Find min Y
	mov	ecx,[esi]
	add	esi,4+XYZ.Y
	mov	ebx,[esi]
minlp:
	mov	edx,[esi]
	cmp	edx,ebx
	jge	@F
	mov	ebx,edx			;New min
@@:
	add	esi,sizeof XYZ
	dec	ecx
	jg	minlp


	mov	esi,[eax].MDL.PTS_p	;Adjust Y's
	mov	ecx,[esi]
	add	esi,4+XYZ.Y
adjlp:
	sub	[esi],ebx
	add	esi,sizeof XYZ
	dec	ecx
	jg	adjlp


	call	main_draw
x:
	ret

 SUBEND



;********************************
;* Delete selected obj

 SUBRP	olst_delete

	call	obj_findsel
	jz	x			;Bad selection?

	mov	edi,eax
	call	_3d_freeobj

	call	main_draw
x:
	ret

 SUBEND


;********************************
;* Delete marked objs

 SUBRP	olst_deletemrkd

	CLR	ecx
	dec	ecx
lp:
	inc	ecx
lp2:
	mov	eax,ecx
	call	obj_find
	jz	dn			;Done?

	test	[eax].D3OBJ.FLGS,MRK_OF
	jz	lp

	mov	edi,eax
	call	_3d_freeobj
	jmp	lp2
dn:
	jmp	main_draw

 SUBEND



;********************************
;* Duplicate marked objs

 SUBRP	olst_duplicatemrkd

	local	xoff:dword,
		yoff:dword,
		zoff:dword,
		xstep:dword,
		ystep:dword,
		zstep:dword,
		dcnt:dword

	lea	eax,oldup_ebt
	call	entrybox_open
	jnz	x

	lea	eax,dupcnt_s
	call	stratoi
	mov	dcnt,eax

	lea	eax,dupx_s
	call	stratoi
	shl	eax,8
	mov	xstep,eax
	mov	xoff,eax

	lea	eax,dupy_s
	call	stratoi
	shl	eax,8
	mov	ystep,eax
	mov	yoff,eax

	lea	eax,dupz_s
	call	stratoi
	shl	eax,8
	mov	zstep,eax
	mov	zoff,eax

	jmp	dstrt

dlp:
	CLR	ecx
	dec	ecx
lp:
	inc	ecx
	mov	eax,ecx
	call	obj_find
	jz	dn			;Done?

	test	[eax].D3OBJ.FLGS,MRK_OF
	jz	lp
	mov	esi,eax

	call	obj_get
	jz	err

	mov	eax,[esi].D3OBJ.X
	add	eax,xoff
	mov	[edi].D3OBJ.X,eax
	mov	eax,[esi].D3OBJ.Y
	add	eax,yoff
	mov	[edi].D3OBJ.Y,eax
	mov	eax,[esi].D3OBJ.Z
	add	eax,zoff
	mov	[edi].D3OBJ.Z,eax

	mov	ax,[esi].D3OBJ.XA
	mov	[edi].D3OBJ.XA,ax
	mov	ax,[esi].D3OBJ.YA
	mov	[edi].D3OBJ.YA,ax
	mov	ax,[esi].D3OBJ.ZA
	mov	[edi].D3OBJ.ZA,ax

	mov	ax,[esi].D3OBJ.ID
	mov	[edi].D3OBJ.ID,ax

	mov	ax,[esi].D3OBJ.FLGS
	and	ax,not MRK_OF
	mov	[edi].D3OBJ.FLGS,ax

	mov	ax,[esi].D3OBJ.ILUM
	mov	[edi].D3OBJ.ILUM,ax

	mov	eax,[esi].D3OBJ.CLRNG
	mov	[edi].D3OBJ.CLRNG,eax

	mov	eax,[esi].D3OBJ.PTS_p
	mov	[edi].D3OBJ.PTS_p,eax

	mov	eax,[esi].D3OBJ.FACE_p
	mov	[edi].D3OBJ.FACE_p,eax

	mov	eax,[esi].D3OBJ.PRC_p
	mov	[edi].D3OBJ.PRC_p,eax

	mov	eax,[esi].D3OBJ.MDL_p
	mov	[edi].D3OBJ.MDL_p,eax

	jmp	lp
dn:
	mov	eax,xstep
	add	xoff,eax

	mov	eax,ystep
	add	yoff,eax

	mov	eax,zstep
	add	zoff,eax
dstrt:
	dec	dcnt
	jge	dlp

err:
x:
	call	main_draw

	ret

 SUBEND

	.data
X=160
Y=100
ID=0

oldup_ebt	dd	oldup_gad,0,dup_xys
		dw	X,Y,320,150
oldup_gad\
	GAD	{ @F, X+184,Y+129, 13*8,11, c12_wh, dup_s, GADF_DN, ID+0 }
dup_s	db	"DUPLICATE",0
@@:
	GAD	{ @F, X+30,Y+129, 13*8,11, c12_wh, no_s, GADF_DN, ID+1 }
no_s	db	"NO!",0
@@:
	GAD	{ @F, X+48,Y+7, 3*8+4,11, c3_wh, dupcnt_s, GADF_STR, ID+40h }
dupcnt_s	db	"1",0,0,0
@@:
	GAD	{ @F, X+48,Y+27, 5*8+4,11, c5_wh, dupx_s, GADF_STR, ID+40h }
dupx_s	db	"0",0,0,0,0,0
@@:
	GAD	{ @F, X+48,Y+47, 5*8+4,11, c5_wh, dupy_s, GADF_STR, ID+40h }
dupy_s	db	"0",0,0,0,0,0
@@:
	GAD	{ 0, X+48,Y+67, 5*8+4,11, c5_wh, dupz_s, GADF_STR, ID+40h }
dupz_s	db	"0",0,0,0,0,0


dup_xys\
	dw	X+8,Y+10,0fdfeh
	db	"Count",0
	dw	X+32,Y+30,0fdfeh
	db	"X",0
	dw	X+32,Y+50,0fdfeh
	db	"Y",0
	dw	X+32,Y+70,0fdfeh
	db	"Z",0
	dw	-1


;********************************
;*

; SUBRP	olst_dupgads
;
;	cmp	al,1				;>Forget it
;	jne	n1
;
;n1:
;;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;
;
;	ret
; SUBEND


;********************************
;* Mark all objs

 SUBRP	olst_mrkall

	CLR	ecx
	dec	ecx

lp:	inc	ecx
	mov	eax,ecx
	call	obj_find
	jz	done			;Done?

	or	[eax].D3OBJ.FLGS,MRK_OF
	jmp	lp

done:
	jmp	main_draw

 SUBEND


;********************************
;* Unmark all objs

 SUBRP	olst_unmrkall

	CLR	ecx
	dec	ecx

lp:	inc	ecx
	mov	eax,ecx
	call	obj_find
	jz	done			;Done?

	and	[eax].D3OBJ.FLGS,not MRK_OF
	jmp	lp

done:
	jmp	main_draw

 SUBEND


;********************************
;* Invert marks on all objs

 SUBRP	olst_invertmrks

	CLR	ecx
	dec	ecx

lp:	inc	ecx
	mov	eax,ecx
	call	obj_find
	jz	done			;Done?

	xor	[eax].D3OBJ.FLGS,MRK_OF
	jmp	lp

done:
	jmp	main_draw

 SUBEND



;********************************
;* Call requester for TGA load

 SUBR	tga_loadreq

	mov	eax,offset fmatchtga_s
	mov	ebx,offset @F
	mov	esi,offset load_s
	mov	fmode,3
	jmp	filereq_open

lp:
	call	tga_load
@@:
	call	filereq_getnxtmrkd
	jnz	lp

	jmp	main_draw

 SUBEND


;********************************
;* Load a TGA file (Width < 256 padded to 256, >256 stacked at bottom)
;* EAX = *Filename
;* Trashes none

 SUBRP	tga_load

	local	fn_p:dword,			;*Filename
		fh:dword,			;Filehandle
		cnt:dword,			;Temp
		tblkw:dword,			;# blocks wide
		tohgt:dword,			;Original hgt
		td_p:dword,			;*Dest
		trlen:dword			;Read len

	pushad

	mov	fn_p,eax


	mov	fileerr,1			;Set error flag

	mov	edx,eax
	I21OPENR
	jc	error2
	mov	ebx,eax				;BX=File handle
	mov	fh,eax

	mov	ecx,sizeof tga_hdr		;Read TGA header
	mov	edx,offset tga_hdr
	I21READ
	jc	error


	CLR	ecx				;Skip ID
	movzx	dx,tga_hdr.IDLEN
	I21SETFPC
	jc	error

	cmp	tga_hdr.ITYPE,1
	jne	error				;!Uncomp colormapped img?

	cmp	tga_hdr.CMTYPE,1
	jne	error				;No palette?

	cmp	tga_hdr.BITSPIX,8
	jne	error				;!256 color img?

	cmp	tga_hdr.CMBITS,24
	je	@F				;OK?
	cmp	tga_hdr.CMBITS,15
	jne	error				;Bad pal type?
@@:
	movzx	eax,tga_hdr.CMLEN
	dec	eax
	cmp	eax,255
	ja	error


	call	tga_alloc
	jz	error
	mov	esi,eax				;ESI=* TGA struc


	movsx	edx,tga_hdr.W
	TST	edx
	jle	error				;Less than 1?
	add	edx,255				;Round up to 256 multiple
	shr	edx,8
	mov	tblkw,edx

	movsx	eax,tga_hdr.H
	TST	eax
	jle	error				;Less than 1?
	mov	tohgt,eax
	imul	eax,edx
	mov	[esi].TGA.IMGH,eax

	shl	eax,8+1				;*256 wide * 2 copies
	call	mem_alloc0			;Get image mem
	jz	error

	mov	[esi].TGA.IMG_p,eax

	mov	eax,fn_p			;Copy filename
	lea	edi,[esi].TGA.N_s
	push	edi
	mov	ecx,8
	call	strcpylen
	mov	BPTR [edi],0
	pop	edi

	mov	al,'.'				;Remove extension
	call	strsrch
	mov	BPTR [edi],0


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				;>Read palette

	movzx	ecx,tga_hdr.CMLEN
	mov	[esi].TGA.PALCNT,ecx

	mov	eax,ecx
	shl	eax,1				;*2
	call	mem_alloc
	jz	error

	mov	[esi].TGA.PAL_p,eax

	mov	edi,eax
pallp:
	push	ecx
	mov	ecx,3
	cmp	tga_hdr.CMBITS,24
	je	@F				;OK?
	mov	ecx,2
@@:	mov	edx,offset tl1
	I21READ
	pop	ecx
	jc	error

	mov	ax,WPTR tl1
	cmp	tga_hdr.CMBITS,24
	jne	@F				;Word form?
	CLR	ah
	shr	al,3				;Blue
	mov	dl,BPTR tl1+1			;Green
	and	dx,0f8h
	shl	dx,2
	or	ax,dx
	mov	dl,BPTR tl1+2			;Red
	and	dx,0f8h
	shl	dx,7
	or	ax,dx

@@:	mov	[edi],ax
	add	edi,2

	loop	pallp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				;>Read pixels


	mov	ecx,tohgt
	mov	cnt,ecx
	CLR	edx
	test	tga_hdr.DESC,10h
	jnz	@F				;Going down?
	mov	edx,256
	dec	ecx
	imul	edx,ecx
@@:
	add	edx,[esi].TGA.IMG_p
pixlp:
	mov	td_p,edx
	movsx	eax,tga_hdr.W
	mov	trlen,eax
	mov	ecx,tblkw
pixblp:
	push	ecx
	mov	ecx,trlen
	cmp	ecx,256
	jle	@F
	mov	ecx,256
@@:
	sub	trlen,ecx
	I21READ
	pop	ecx
	jc	error				;Error?

	mov	eax,tohgt
	shl	eax,8				;*256
	add	edx,eax
	loop	pixblp

	mov	edx,td_p
	mov	eax,256
	test	tga_hdr.DESC,10h
	jnz	@F				;Going down?
	neg	eax
@@:	add	edx,eax

	dec	cnt
	jg	pixlp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Copy img data

	mov	ecx,[esi].TGA.IMGH
	shl	ecx,8				;*256

	mov	edx,[esi].TGA.IMG_p
	mov	edi,edx
	add	edi,ecx
	shr	ecx,2				;/4
clp:	mov	eax,[edx]
	mov	[edi],eax
	add	edx,4
	add	edi,4
	loop	clp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Remap to genpal

	mov	eax,[esi].TGA.PAL_p
	mov	ebx,[esi].TGA.PALCNT
	lea	ecx,genpal_t+2
	mov	edx,GENPALSZ-1
	call	pal_makemergemap


	mov	ecx,[esi].TGA.IMGH
	shl	ecx,8				;*256

	mov	edi,[esi].TGA.IMG_p
	CLR	eax
plp:	mov	al,[edi]
	TST	al
	jz	@F				;0 pix?
	mov	al,BPTR palmrgmap_t[eax]	;Get new position
	inc	al
	mov	[edi],al
@@:	inc	edi
	loop	plp



;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	tgalast_p,esi

	mov	fileerr,0			;Clr error flag


error:
	mov	ebx,fh
	I21CLOSE				;Close file

error2:

x:
	popad
	ret

 SUBEND


;********************************
;* Call requester for TGA reload

 SUBR	tga_reloadreq

	mov	eax,offset fmatchtga_s
	mov	ebx,offset @F
	mov	esi,offset load_s
	mov	fmode,3
	jmp	filereq_open

@@:
	call	filereq_getnxtmrkd
	jz	x

	mov	esi,facetga_p

	call	tga_load

	cmp	fileerr,0
	jne	x

	mov	edi,tgalast_p

	mov	eax,[esi].TGA.IMG_p
	call	mem_free
	mov	eax,[edi].TGA.IMG_p
	mov	[esi].TGA.IMG_p,eax

	mov	eax,[esi].TGA.PAL_p
	call	mem_free
	mov	eax,[edi].TGA.PAL_p
	mov	[esi].TGA.PAL_p,eax

	lea	eax,tga_p
@@:
	mov	ebx,eax
	mov	eax,[eax]
	TST	eax
	jz	tfre				;End?

	cmp	eax,edi
	jne	@B
	mov	eax,[eax]			;Unlink me
	mov	[ebx],eax
tfre:
	mov	eax,edi
	call	mem_free

x:
	jmp	main_draw

 SUBEND



;********************************
;* Alloc TGA struc and add to list
;*>EAX = *TGA struc or 0 (CC)
;* Trashes out

 SUBRP	tga_alloc

	PUSHMR	edx,esi

	mov	eax,sizeof TGA
	call	mem_alloc0
	jz	x

	lea	esi,tga_p			;Find end of list
@@:	mov	edx,esi
	mov	esi,[esi]
	TST	esi
	jnz	@B

	mov	[edx],eax			;* last to me
;	mov	[eax].TGA.NXT_p,esi		;0

	mov	tgalast_p,eax			;Remember me
x:
	TST	eax
	POPMR
	ret

 SUBEND

;********************************
;* Delete TGA struc and remove from list
;* EAX = TGA # (0-?)
;* Trashes none

 SUBRP	tga_del

	pushad

	TST	eax
	jl	x

	lea	esi,tga_p		;Find previous
	dec	eax
	jl	@F			;1st one?

	call	tga_find
	jz	x			;Bad selection?
	mov	esi,eax
@@:
	mov	edi,[esi]
	TST	edi
	jz	x
	mov	eax,[edi]		;Get deleted's next
	mov	[esi],eax		;Give to prev

;	dec	tgacnt

;	TST	eax
;	jnz	nlast			;!Last?
;
;	mov	il1stprt,0
;	mov	eax,ilselected
;	dec	eax
;	call	ilst_select
;
;nlast:
	mov	eax,[edi].TGA.IMG_p
	call	mem_free
	mov	eax,[edi].TGA.PAL_p
	call	mem_free
	mov	eax,edi
	call	mem_free

x:
	popad
	ret

 SUBEND



;********************************
;* Find TGA struc from #
;* EAX = TGA # (0-?)
;*>EAX = *TGA struc or 0 (CC)
;* Trashes out

 SUBRP	tga_find

	PUSHMR	edx,esi

	CLR	edx
	dec	edx
	lea	esi,tga_p

lp:	mov	esi,[esi]
	TST	esi
	jz	f			;End?
	inc	edx
	cmp	eax,edx
	jne	lp
f:
	mov	eax,esi

	TST	eax
	POPMR
	ret

 SUBEND


;********************************
;* Find TGA index from * struc
;* EAX = *TGA struc
;*>EAX = TGA # (0-?) or -1 (CC)
;* Trashes out

 SUBRP	tga_findindx

	PUSHMR	edx,esi

	CLR	edx
	dec	edx
	lea	esi,tga_p
lp:
	mov	esi,[esi]
	TST	esi
	jz	err			;End?
	inc	edx
	cmp	eax,esi
	jne	lp

	mov	eax,edx
	jmp	x
err:
	mov	eax,-1
x:
	TST	eax
	POPMR
	ret

 SUBEND



;********************************
;* Build remap
;* EAX = *Src pal
;* EBX = Source pal length
;* ECX = *Dest pal
;* EDX = Destination pal length

 SUBRP	pal_merge

	local	pmap[256]:dword,		;
		slen:dword,
		src_p:dword,
		dlen:dword,
		dst_p:dword,
		mnum:dword,
		mdelta:dword,
		sred:dword,
		sgrn:dword,
		sblu:dword

	pushad

	TST	ebx
	jle	x				;Bad len?
	TST	edx
	jle	x				;Bad len?

	mov	src_p,eax
	mov	slen,ebx
	mov	dst_p,ecx
	mov	dlen,edx


	lea	esi,pmap
slp:
						;>Get src RGB components
	movzx	eax,BPTR [ebx]
	and	al,1fh
	mov	sred,eax

	movzx	eax,WPTR [ebx]
	shr	eax,5
	and	eax,1fh
	mov	sgrn,eax

	movzx	eax,WPTR [ebx]
	shr	eax,10
	and	al,1fh
	mov	sblu,eax

						;>Comp src RGB to each dest RGB
	mov	mdelta,1000
	mov	ecx,dlen
	mov	edi,dst_p
dlp:
	CLR	edx

	movzx	eax,BPTR [edi]
	and	al,1fh
	sub	eax,sred
	jge	@F
	neg	eax
@@:	add	edx,eax

	movzx	eax,WPTR [edi]
	shr	eax,5
	and	eax,1fh
	sub	eax,sgrn
	jge	@F
	neg	eax
@@:	add	edx,eax

	movzx	eax,WPTR [edi]
	shr	eax,10
	and	al,1fh
	sub	eax,sblu
	jge	@F
	neg	eax
@@:	add	edx,eax

	cmp	mdelta,edx
	jle	@F				;Last is closer match?
	mov	mdelta,edx
	mov	eax,dlen
	sub	eax,ecx
	mov	mnum,eax
@@:

	add	edi,2
	loop	dlp


	mov	eax,mnum			;Save match # in palmap_t
	mov	[esi],al
	inc	esi

	add	ebx,2

	dec	slen
	jg	slp


x:
	popad
	ret

 SUBEND


;********************************
;* Delete selected image if it has no dependencies

 SUBRP	i2lst_delete

	CLR	ecx
lp:
	mov	eax,ecx
	call	model_find
	jz	del			;End?

	mov	esi,eax

	mov	eax,[esi].MDL.TGA_p
	cmp	eax,facetga_p
	je	dr			;Found use?

	inc	ecx
	jmp	lp

del:
	mov	eax,facetga_p
	call	tga_findindx
	jl	dr
	call	tga_del

dr:
	call	main_draw
x:
	ret

 SUBEND


;****************************************************************


;********************************
;* Init 3D world
;* Trashes none

 SUBRP	_3d_init

	pushad


	cmp	teximgloaded,1			;>Load textures
	je	txloaded

;	mov	eax,offset texfname_s
;	mov	edi,offset fname_s
;	call	strcpy
;
;	call	img_load
;
;	cmp	img_p,0
;	jle	x				;Error?
;
;	mov	teximgloaded,1

txloaded:





	call	pl_getname


	mov	ebx,offset netpdta_t		;>Free net plyr data
	mov	ecx,20
@@:	mov	WPTR [ebx],-1
	add	ebx,NETPDSZ
	loop	@B


;	call	_3d_reversefaces

	mov	d3mode,1			;ON

	mov	viewx,MAPBSZ/2*256
	mov	viewz,MAPBSZ/2*256
	mov	viewy,300*256


	call	prc_init

	mov	esi,offset prcact_p
;	CREATE	0,bkgnd_create

;	CREATE	0,en_guy

	CREATE	0,en_spawner




	CREATE	0,pl_weapon1
	CREATE	0,pl_weapon2
	CREATE	0,pl_mslmain

	call	pl_reinit





	mov	esi,offset d3objmem	;>Init free list
	mov	d3free_p,esi
	mov	ecx,D3NUMO
flp:	mov	edi,esi
	add	esi,sizeof D3OBJ
	mov	[edi],esi
	loop	flp

	CLR	eax
	mov	[edi],eax		;Null in last
	mov	world_p,eax
;	mov	d3world_t,eax




	if	MAPON
	call	map_init
	endif




	call	_3d_getobj0
	mov	plcobj_p,edi

	mov	[edi].D3OBJ.ID,CLSDEAD

	mov	eax,offset pltnkc_pts
	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,offset pltnkc_lt
	mov	[edi].D3OBJ.FACE_p,eax


	call	_3d_getobj0
	mov	pltobj_p,edi

	mov	[edi].D3OBJ.ID,CLSDEAD

	mov	eax,offset pltnkt_pts
	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,offset pltnkt_lt
	mov	[edi].D3OBJ.FACE_p,eax



	call	_3d_loadimgs



x:	popad
	ret

 SUBEND


	.data
	even


Z=-50
Y=80
X=500
d3init_t\	;World init
	dd	sq2_pts,sqline_t
	word	0,Y,Z
;	dd	cube_pts,cubeline_t
;	word	0,Y,-1000
;	dd	0

;	dd	sq_pts,sqline_t
;	word	-X,0,-X
;	dd	sq_pts,sqline_t
;	word	X,0,-X
;	dd	sq_pts,sqline_t
;	word	-X,0,X
;	dd	sq_pts,sqline_t
;	word	X,0,X

	dd	cube_pts,cubeline_t
	word	-500,Y,-500
	dd	cube_pts,cubeline_t
	word	500,Y,-500

	dd	0

X=500
Y=0
Z=500
sq_pts\
	dd	4
	dd	-X	,Y	,-Z
	dd	X	,Y	,-Z
	dd	X	,Y	,Z
	dd	-X	,Y	,Z
X=80
Y=80
sq2_pts\
	dd	4
	dd	-X	,Y	,0
	dd	X	,Y	,0
	dd	X	,-Y	,0
	dd	-X	,-Y	,0
sqline_t\
	dd	2,0,1,2,3
	dd	-1

X=40
Y=100
Z=20
cube_pts\
	dd	8
	dd	X,Y,Z
	dd	X,-Y,Z
	dd	-X,-Y,Z
	dd	-X,Y,Z
	dd	X,Y,-Z
	dd	X,-Y,-Z
	dd	-X,-Y,-Z
	dd	-X,Y,-Z

cubeline_t=$
	FACEM	1,0,1,2,3
	FACEM	2,7,6,5,4
	FACEM	3,3,2,6,7
	FACEM	3,4,5,1,0
	FACEM	4,5,6,2,1
	FACEM	4,7,4,0,3
	dd	-1	;End



X=150
Y=80
Z=300
pltnkc_pts\
	dd	6
	dd	-X	,Y	,-Z
	dd	X	,Y	,-Z
	dd	X	,Y	,Z-50
	dd	-X	,Y	,Z-50
	dd	X	,Y	,Z
	dd	-X	,Y	,Z
pltnkc_lt=$
	FACEM	10,0,1,2,3
	FACEM	8,3,2,4,5
	dd	-1

X=20
Y=150
Z=340
pltnkt_pts\
	dd	4
	dd	-X	,Y	,-Z
	dd	X	,Y	,-Z
	dd	X	,Y	,Z/2
	dd	-X	,Y	,Z/2
pltnkt_lt=$
	FACEM	5,0,1,2,3
	dd	-1



;********************************
;* Init map

 SUBRP	map_init

	local	xcnt:dword,
		zcnt:dword


	mov	mapscl,50


	mov	esi,offset map_t
	CLR	eax
	mov	ecx,MAPW*MAPH
@@:	mov	[esi],eax
	add	esi,4
	loop	@B

;DEBUG
;	mov	map_t+MAPW/2*4+MAPH/2*MAPW*4,1

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	mov	esi,offset mapinit_t	;>Init world from map
	mov	zcnt,MAPZSZ
	mov	ztmp,-MAPZSZ/2*BLK10	;+BLK10/2
mapzlp:
	mov	xtmp,-MAPXSZ/2*BLK10	;+BLK10/2
	mov	xcnt,MAPXSZ

mapxlp:	movzx	eax,WPTR [esi]
	add	esi,2
	push	esi

	mov	tl1,eax
	shl	eax,2			;*4
	add	eax,offset mapindx_t
	mov	esi,[eax]

	jmp	oistrt			;>Get blk objs and init

olp:	call	_3d_getobj
	jz	noobj

	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,[esi+4]
	mov	[edi].D3OBJ.FACE_p,eax

	mov	eax,tl1
	mov	[edi].D3OBJ.PRC_p,eax	;Save symbol #

	mov	[edi].D3OBJ.ID,0


	mov	eax,zcnt		;Save * obj
	neg	eax
	add	eax,MAPZSZ
	imul	eax,MAPW
	mov	edx,xcnt
	neg	edx
	add	edx,MAPXSZ
	add	eax,edx
;	mov	(offset map_t)[eax*4],edi


	mov	ax,WPTR [esi+8]
	add	ax,xtmp			;Block X offset
	movsx	eax,ax
	shl	eax,8
	mov	[edi].D3OBJ.X,eax

	movsx	eax,WPTR [esi+10]
	shl	eax,8
	mov	[edi].D3OBJ.Y,eax

	mov	ax,WPTR [esi+12]
	add	ax,ztmp			;Block Z offset
	movsx	eax,ax
	shl	eax,8
	mov	[edi].D3OBJ.Z,eax

	CLR	eax
	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.ZV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.YA,ax
	mov	[edi].D3OBJ.ZA,ax

;	mov	[edi].D3OBJ.FLGS,FLAT_OF

	add	esi,2*4+3*2
oistrt:	mov	eax,[esi]
	TST	eax
	jnz	olp

noobj:	pop	esi
	add	xtmp,BLK10		;Next block base position
	dec	xcnt
	jg	mapxlp

	add	ztmp,BLK10		;Next block Z pos
@@:
	dec	zcnt
	jg	mapzlp

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	ret

 SUBEND

	.data

	if	1
mapinit_t\
	word	0,0,0,0,0,0,0,0,0,0
	word	0,0,0,0,0,0,0,0,0,0
	word	0,0,0,0,0,0,0,0,0,0
	word	0,0,0,0,0,0,0,0,0,0
	word	0,0,0,0,0,0,0,0,0,0
	word	0,0,0,0,0,0,0,0,0,0
	word	0,0,0,0,0,0,0,0,0,0
	word	0,0,0,0,0,0,0,0,0,0
	word	0,0,0,0,0,0,0,0,0,0
	word	0,0,0,0,0,0,0,0,0,0
	else
mapinit_t\
	word	0,7,7,7,7,7,7,7,7,0
	word	8,1,1,1,1,1,1,1,1,8
	word	8,1,2,1,2,7,7,2,1,8
	word	8,1,1,1,8,0,0,8,1,8
	word	8,1,2,1,8,0,0,8,1,8
	word	8,1,1,1,2,7,7,2,1,8
	word	8,1,2,1,1,1,1,1,1,8
	word	8,1,2,1,1,6,7,4,1,8
	word	8,1,1,1,1,1,1,1,1,8
	word	0,7,7,7,7,7,7,7,7,0
	endif

mapindx_t\
	dd	m0,m1,m2,m3,m4,m5,m6,m7,m8

m0	dd	0
m1	dd	gnd10x10_pts,gnd10x10line_t
	word	0,0,0
	dd	0
m2	dd	cube10_pts,cube10nsew_lt
	word	0,BLK10/2,0
	dd	0
m3	dd	cube10_pts,cube10new_lt
	word	0,BLK10/2,0
	dd	0
m4	dd	cube10_pts,cube10nse_lt
	word	0,BLK10/2,0
	dd	0
m5	dd	cube10_pts,cube10sew_lt
	word	0,BLK10/2,0
	dd	0
m6	dd	cube10_pts,cube10nsw_lt
	word	0,BLK10/2,0
	dd	0
m7	dd	cube10_pts,cube10ns_lt
	word	0,BLK10/2,0
	dd	0
m8	dd	cube10_pts,cube10ew_lt
	word	0,BLK10/2,0
	dd	0

X=BLK10/2
Y=0
Z=X
gnd10x10_pts\
	dd	4
	dd	-X	,Y	,-Z
	dd	X	,Y	,-Z
	dd	X	,Y	,Z
	dd	-X	,Y	,Z
gnd10x10line_t=$
	FACEM	254,0,1,2,3
	dd	-1
X=BLK10/2
Y=X
Z=X
TX=MIDWAY_TX
cube10_pts\
	dd	8
	dd	X,Y,Z
	dd	X,-Y,Z
	dd	-X,-Y,Z
	dd	-X,Y,Z
	dd	X,Y,-Z
	dd	X,-Y,-Z
	dd	-X,-Y,-Z
	dd	-X,Y,-Z
cube10nsew_lt=$
	FACEM	TX,3,0,1,2		;South
	FACEM	TX,4,7,6,5		;North
	FACEM	3,3,2,6,7		;West
	FACEM	3,4,5,1,0		;East
;	FACEM	4,5,6,2,1		;Bot
;	FACEM	4,7,4,0,3		;Top
	dd	-1
cube10new_lt=$
	FACEM	2,7,6,5,4
	FACEM	3,3,2,6,7
	FACEM	3,4,5,1,0
	dd	-1
cube10nse_lt=$
	FACEM	1,0,1,2,3
	FACEM	2,7,6,5,4
	FACEM	3,4,5,1,0
	dd	-1
cube10sew_lt=$
	FACEM	1,0,1,2,3
	FACEM	3,3,2,6,7
	FACEM	3,4,5,1,0
	dd	-1
cube10nsw_lt=$
	FACEM	1,0,1,2,3
	FACEM	2,7,6,5,4
	FACEM	3,3,2,6,7
	dd	-1
;TX=0feh
TX=SQVIOLET_TX
cube10ns_lt=$
	FACEM	TX,3,0,1,2
	FACEM	TX,4,7,6,5
	dd	-1
TX=CROSSH_TX
cube10ew_lt=$
	FACEM	TX,7,3,2,6
	FACEM	TX,0,4,5,1
	dd	-1



;********************************
;* Show 3D top view map
;* Trashes none

 SUBRP	map_draw

	local	cnt:dword,\
		tpx:dword,\
		tpx2:dword,\
		tpz:dword

	pushad


	mov	ax,0f00h+SC_MAPMASK	;>Clr map window
	mov	dx,SC_INDEX
	out	dx,ax

	cld

	CLR	eax
	mov	edi,0a0000h+MAPPX/4+MAPPY*SCRWB

	mov	edx,MAPPH

@@:	mov	ecx,MAPPW/4
	rep	stosb
	add	edi,SCRWB-MAPPW/4

	dec	edx
	jg	@B


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Draw grid



	cmp	mapscl,100
	jg	nogrid


	mov	prtcolors,3


	mov	eax,viewx
	sar	eax,8
	mov	ebx,MAPBSZ
	cdq
	idiv	ebx
	neg	edx
	sub	edx,MAPBSZ*20-MAPBSZ
	mov	tl1,edx

	mov	liney2,MAPPY+MAPPH-1
xllp:
	mov	ebx,mapscl

	mov	eax,tl1
	cdq
	idiv	ebx
	cmp	eax,-MAPPW/2
	jl	xlnxt
	cmp	eax,MAPPW/2
	jge	xlend
	add	eax,MAPPX+MAPPW/2
	mov	ecx,eax
	mov	linex2,ecx

	mov	edx,MAPPY

	call	line_draw

xlnxt:
	add	tl1,MAPBSZ
	jmp	xllp

xlend:


	mov	eax,viewz
	sar	eax,8
	mov	ebx,MAPBSZ
	cdq
	idiv	ebx
	neg	edx
	sub	edx,MAPBSZ*20-MAPBSZ
	mov	tl1,edx

	mov	linex2,MAPPX+MAPPW-1
yllp:
	mov	ebx,mapscl

	mov	eax,tl1
	cdq
	idiv	ebx
	cmp	eax,-MAPPH/2
	jl	ylnxt
	cmp	eax,MAPPH/2
	jge	ylend
	add	eax,MAPPY+MAPPH/2
	mov	edx,eax
	mov	liney2,edx

	mov	ecx,MAPPX

	call	line_draw

ylnxt:
	add	tl1,MAPBSZ
	jmp	yllp

ylend:

nogrid:


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Prt map

	mov	esi,offset map_t

	mov	eax,-(MAPW-1)*MAPBSZ/2
	mov	ebx,viewx
	sar	ebx,8
	sub	eax,ebx
	mov	tpx,eax
	mov	tpx2,eax

	mov	eax,-(MAPH-1)*MAPBSZ/2
	mov	ebx,viewz
	sar	ebx,8
	sub	eax,ebx
	mov	tpz,eax

	mov	cnt,MAPH
mylp:
	mov	ecx,MAPW
mxlp:
	push	ecx
	mov	ecx,[esi]		;Get data
	TST	ecx
	jz	nxt


	mov	eax,tpx
	sub	eax,MAPBSZ/2
	mov	ebx,tpz
	sub	ebx,MAPBSZ/2
	and	ecx,M_MAPH		;Higher is brighter
	shr	ecx,7
	add	cl,38h			;Med blue
	call	map_drawbox

	mov	ebx,mapscl
	cmp	ebx,18
	jg	nxt			;Scale too smale?

	mov	eax,tpx
	cdq
	idiv	ebx
	sub	eax,2*8
	cmp	eax,-MAPPW/2
	jl	nxt
	cmp	eax,MAPPW/3
	jge	nxt
	add	eax,MAPPX+MAPPW/2
	mov	ecx,eax

	mov	eax,tpz
	cdq
	idiv	ebx
	sub	eax,1*6
	cmp	eax,-MAPPH/2
	jl	nxt
	cmp	eax,MAPPH/3
	jge	nxt
	add	eax,MAPPY+MAPPH/2
	mov	edx,eax

	mov	eax,[esi]		;Get data
	and	eax,M_MAPH
	push	esi
	mov	bx,255			;Yellow
	call	prtf6_dec3srj
	pop	esi

	mov	eax,[esi]		;Get data
	and	eax,M_MAPIL
	shr	eax,S_MAPIL
	push	esi
	mov	bx,255			;Yellow
	add	edx,6
	call	prtf6_dec3srj
	pop	esi

nxt:
	add	tpx,MAPBSZ

	add	esi,4

	pop	ecx
	dec	ecx
	jg	mxlp

	mov	eax,tpx2
	mov	tpx,eax
	add	tpz,MAPBSZ

	dec	cnt
	jg	mylp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	call	_3d_buildmaplist
	call	_3d_xformrelself

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Draw floor objs


	mov	esi,world_p
	jmp	fostrt

folp:
	mov	eax,[esi].D3OBJ.X
	sub	eax,viewx
	sar	eax,8
	mov	tpx,eax

	mov	eax,[esi].D3OBJ.Z
	sub	eax,viewz
	sar	eax,8
	mov	tpz,eax

;	mov	ebx,mapscl
	mov	ecx,[esi].D3OBJ.XPTS_p

	mov	eax,4[ecx+0*sizeof XYZ].XYZ.Y
	cmp	eax,4[ecx+3*sizeof XYZ].XYZ.Y
	jne	fonxt				;!Flat?

	mov	cl,5ah			;Cyan
	test	[esi].D3OBJ.FLGS,MRK_OF
	jnz	mrkd

	mov	cx,[esi].D3OBJ.ILUM
	add	cl,08h			;Grey
mrkd:
	mov	eax,tpx
	mov	ebx,tpz
	sub	eax,MAPBSZ/2
	sub	ebx,MAPBSZ/2
	call	map_drawbox

fonxt:
	mov	esi,[esi].D3OBJ.WNXT_p
fostrt:
	TST	esi
	jnz	folp



;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Draw wall objs


	mov	esi,world_p
	jmp	ostrt

olp:
	mov	eax,[esi].D3OBJ.X
	sub	eax,viewx
	sar	eax,8
	mov	tpx,eax

	mov	eax,[esi].D3OBJ.Z
	sub	eax,viewz
	sar	eax,8
	mov	tpz,eax

	mov	ebx,mapscl
	mov	ecx,[esi].D3OBJ.XPTS_p

;	mov	eax,[ecx]
;	mov	cnt,eax

	mov	eax,4[ecx+0*sizeof XYZ].XYZ.Y
	cmp	eax,4[ecx+3*sizeof XYZ].XYZ.Y
	je	onxt				;Flat?

	mov	eax,4[ecx+sizeof XYZ].XYZ.X
	add	eax,tpx
	cdq
	idiv	ebx
	cmp	eax,-MAPPW/2
	jl	onxt
	cmp	eax,MAPPW/2
	jge	onxt
	add	eax,MAPPX+MAPPW/2
	mov	linex2,eax

	mov	eax,4[ecx+sizeof XYZ].XYZ.Z
	add	eax,tpz
	cdq
	idiv	ebx
	cmp	eax,-MAPPH/2
	jl	onxt
	cmp	eax,MAPPH/2
	jge	onxt
	add	eax,MAPPY+MAPPH/2
	mov	liney2,eax

	mov	eax,4[ecx].XYZ.X
	add	eax,tpx
	cdq
	idiv	ebx
	cmp	eax,-MAPPW/2
	jl	onxt
	cmp	eax,MAPPW/2
	jge	onxt
	add	eax,MAPPX+MAPPW/2
	mov	edi,eax

	mov	eax,4[ecx].XYZ.Z
	add	eax,tpz
	cdq
	idiv	ebx
	cmp	eax,-MAPPH/2
	jl	onxt
	cmp	eax,MAPPH/2
	jge	onxt
	add	eax,MAPPY+MAPPH/2

	mov	ecx,edi
	mov	edx,eax

	add	edi,linex2
	add	eax,liney2
	push	edi
	push	eax

	mov	al,5fh			;Cyan
	test	[esi].D3OBJ.FLGS,MRK_OF
	jnz	@F
	mov	al,0ah			;Grey
@@:
	mov	BPTR prtcolors,al

	call	line_draw

	pop	eax
	pop	edi

	sar	edi,1
	sar	eax,1
	mov	linex2,edi
	mov	liney2,eax

	mov	ebx,mapscl

	mov	eax,tpx
	cdq
	idiv	ebx
	cmp	eax,-MAPPW/2
	jl	onxt
	cmp	eax,MAPPW/2
	jge	onxt
	add	eax,MAPPX+MAPPW/2
	mov	ecx,eax

	mov	eax,tpz
	cdq
	idiv	ebx
	cmp	eax,-MAPPH/2
	jl	onxt
	cmp	eax,MAPPH/2
	jge	onxt
	add	eax,MAPPY+MAPPH/2
	mov	edx,eax

	mov	prtcolors,01ch

	call	line_draw

onxt:
;	mov	edi,[esi]
;	dec	cnt
;	jg	oflp


	mov	esi,[esi].D3OBJ.WNXT_p
ostrt:
	TST	esi
	jnz	olp



;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Draw working line


	call	map_convertmrkpos


	mov	eax,mapx2v

	cmp	eax,MAPPX
	jge	@F
	mov	eax,MAPPX
@@:
	cmp	eax,MAPPX+MAPPW-1
	jle	@F
	mov	eax,MAPPX+MAPPW-1
@@:
	mov	linex2,eax


	mov	eax,mapy2v

	cmp	eax,MAPPY
	jge	@F
	mov	eax,MAPPY
@@:
	cmp	eax,MAPPY+MAPPH-1
	jle	@F
	mov	eax,MAPPY+MAPPH-1
@@:
	mov	liney2,eax


	mov	ecx,mapx1v

	cmp	ecx,MAPPX
	jge	@F
	mov	ecx,MAPPX
@@:
	cmp	ecx,MAPPX+MAPPW-1
	jle	@F
	mov	ecx,MAPPX+MAPPW-1
@@:

	mov	edx,mapy1v

	cmp	edx,MAPPY
	jge	@F
	mov	edx,MAPPY
@@:
	cmp	edx,MAPPY+MAPPH-1
	jle	@F
	mov	edx,MAPPY+MAPPH-1
@@:

	mov	prtcolors,0ffh

	mov	eax,mapmmode
	cmp	eax,1
	jl	@F
	cmp	eax,2
	jg	@F
	mov	eax,linex2
	mov	ebx,liney2
	call	boxh_draw
	jmp	bxdn
@@:
	call	line_draw
bxdn:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	ax,viewya
	add	ax,8000h
	neg	ax
	call	sinecos_get

	cdq
	idiv	mapscl
	mov	ecx,eax

	mov	eax,ebx
	cdq
	idiv	mapscl
	mov	edx,eax

	sar	ecx,9
	sar	edx,9

	add	ecx,MAPPX+MAPPW/2
	add	edx,MAPPY+MAPPH/2
	mov	linex2,MAPPX+MAPPW/2
	mov	liney2,MAPPY+MAPPH/2
	mov	prtcolors,2ch		;Green

	call	line_draw

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	popad
	ret

 SUBEND





;********************************
;*

 SUBRP	map_convertmrkpos

	mov	eax,mapgsmode		;Get grid snap value
	mov	ebx,MAPBSZ
	dec	eax
	jl	@F
	shr	ebx,1			;/2
	dec	eax
	jl	@F
	mov	ebx,1
@@:

	mov	eax,mapx1
	sub	eax,MAPPX+MAPPW/2
	imul	eax,mapscl
	mov	edx,viewx
	sar	edx,8
	add	eax,edx
	mov	edx,ebx			;Round off to grid size
	shr	edx,1
	TST	eax
	jge	@F
	neg	edx
@@:
	add	eax,edx
	cdq
	idiv	ebx
	imul	eax,ebx
	shl	eax,8
	mov	mapx1w,eax

	sub	eax,viewx
	cdq
	idiv	mapscl
	sar	eax,8
	add	eax,MAPPX+MAPPW/2
	mov	mapx1v,eax


	mov	eax,mapy1
	sub	eax,MAPPY+MAPPH/2
	imul	eax,mapscl
	mov	edx,viewz
	sar	edx,8
	add	eax,edx
	mov	edx,ebx			;Round off to grid size
	shr	edx,1
	TST	eax
	jge	@F
	neg	edx
@@:
	add	eax,edx
	cdq
	idiv	ebx
	imul	eax,ebx
	shl	eax,8
	mov	mapy1w,eax

	sub	eax,viewz
	cdq
	idiv	mapscl
	sar	eax,8
	add	eax,MAPPY+MAPPH/2
	mov	mapy1v,eax


	mov	eax,mapx2
	sub	eax,MAPPX+MAPPW/2
	imul	eax,mapscl
	mov	edx,viewx
	sar	edx,8
	add	eax,edx
	mov	edx,ebx			;Round off to grid size
	shr	edx,1
	TST	eax
	jge	@F
	neg	edx
@@:
	add	eax,edx
	cdq
	idiv	ebx
	imul	eax,ebx
	shl	eax,8
	mov	mapx2w,eax

	sub	eax,viewx
	cdq
	idiv	mapscl
	sar	eax,8
	add	eax,MAPPX+MAPPW/2
	mov	mapx2v,eax


	mov	eax,mapy2
	sub	eax,MAPPY+MAPPH/2
	imul	eax,mapscl
	mov	edx,viewz
	sar	edx,8
	add	eax,edx
	mov	edx,ebx			;Round off to grid size
	shr	edx,1
	TST	eax
	jge	@F
	neg	edx
@@:
	add	eax,edx
	cdq
	idiv	ebx
	imul	eax,ebx
	shl	eax,8
	mov	mapy2w,eax

	sub	eax,viewz
	cdq
	idiv	mapscl
	sar	eax,8
	add	eax,MAPPY+MAPPH/2
	mov	mapy2v,eax



	ret

 SUBEND


;********************************
;* Draw clipped box in map window
;* EAX = Map center relative world X
;* EBX = ^ Y
;* CL  = Color

 SUBRP	map_drawbox

	PUSHMR	esi

	mov	tl1,eax
	mov	tl2,ebx
	mov	box1.COL,cl

	mov	ebx,mapscl

	cdq
	idiv	ebx
	cmp	eax,MAPPW/2
	jge	x
	cmp	eax,-MAPPW/2-1
	jge	@F
	mov	eax,-MAPPW/2-1
@@:	mov	ecx,eax			;X

	mov	eax,tl1
	add	eax,MAPBSZ
	cdq
	idiv	ebx
	dec	eax			;In by 1
	cmp	eax,-MAPPW/2
	jl	x
	cmp	eax,MAPPW/2
	jl	@F
	mov	eax,MAPPW/2-1
@@:	sub	eax,ecx
	jle	x
	mov	tl1,eax			;W-1


	mov	eax,tl2
	cdq
	idiv	ebx
	cmp	eax,MAPPH/2
	jge	x
	cmp	eax,-MAPPH/2-1
	jge	@F
	mov	eax,-MAPPH/2-1
@@:	mov	edi,eax			;Y

	mov	eax,tl2
	add	eax,MAPBSZ
	cdq
	idiv	ebx
	dec	eax			;In by 1
	cmp	eax,-MAPPH/2
	jl	x
	cmp	eax,MAPPH/2
	jl	@F
	mov	eax,MAPPH/2-1
@@:	sub	eax,edi
	jle	x
	mov	ebx,eax			;H

	mov	eax,tl1
	mov	edx,edi
	add	ecx,MAPPX+MAPPW/2+1
	add	edx,MAPPY+MAPPH/2+1

	call	box_draw

x:
	POPMR
	ret
 SUBEND


;********************************
;* Add wall to world at line on map

 SUBRP	map_walladd

	local	tpx:dword,
		tpy:dword,
		wcnt:dword,
		xpos:dword,
		ypos:dword,
		xdlt:dword,
		ydlt:dword


	mov	eax,mapx1w
	mov	xpos,eax
	sub	eax,mapx2w
	mov	xdlt,eax
	jge	@F
	neg	eax
@@:
	mov	ecx,mapy1w
	mov	ypos,ecx
	sub	ecx,mapy2w
	mov	ydlt,ecx
	jge	@F
	neg	ecx
@@:
	cmp	eax,ecx
	jge	@F
	mov	eax,ecx
@@:
	TST	eax
	jle	x				;Dot?

	cdq
	mov	ebx,MAPBSZ*256
	idiv	ebx
	TST	eax
	jnz	@F
	inc	eax				;1
@@:

	mov	wcnt,eax
	mov	ebx,eax

	mov	eax,xdlt
	cdq
	idiv	ebx
	mov	xdlt,eax

	mov	eax,ydlt
	cdq
	idiv	ebx
	mov	ydlt,eax

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	eax,4+sizeof XYZ*4
	call	mem_alloc
	jz	x
	mov	edi,eax

	call	model_alloc
	jz	x
	mov	esi,eax

	mov	modellast_p,esi			;Select

	mov	ebx,facetga_p
	mov	[esi].MDL.TGA_p,ebx

	mov	eax,edi
	mov	[esi].MDL.PTS_p,eax

	mov	DPTR [eax],4


	mov	ebx,xpos
	add	ebx,ebx				;*2
	mov	ecx,ypos
	add	ecx,ecx
	sub	ebx,xdlt
	sub	ecx,ydlt
	sar	ebx,1				;/2
	sar	ecx,1				;/2
	mov	tpx,ebx
	mov	tpy,ecx

	mov	edx,xpos
	sub	edx,tpx
	sar	edx,8
	mov	4[eax+0*sizeof XYZ].XYZ.X,edx
	mov	4[eax+3*sizeof XYZ].XYZ.X,edx

	mov	edx,xpos
	sub	edx,xdlt
	sub	edx,tpx
	sar	edx,8
	mov	4[eax+1*sizeof XYZ].XYZ.X,edx
	mov	4[eax+2*sizeof XYZ].XYZ.X,edx

	mov	edx,ypos
	sub	edx,tpy
	sar	edx,8
	mov	4[eax+0*sizeof XYZ].XYZ.Z,edx
	mov	4[eax+3*sizeof XYZ].XYZ.Z,edx

	mov	edx,ypos
	sub	edx,ydlt
	sub	edx,tpy
	sar	edx,8
	mov	4[eax+1*sizeof XYZ].XYZ.Z,edx
	mov	4[eax+2*sizeof XYZ].XYZ.Z,edx

	mov	edx,faceh
	mov	4[eax+0*sizeof XYZ].XYZ.Y,edx
	mov	4[eax+1*sizeof XYZ].XYZ.Y,edx
	CLR	edx
	mov	4[eax+2*sizeof XYZ].XYZ.Y,edx
	mov	4[eax+3*sizeof XYZ].XYZ.Y,edx


	mov	eax,sizeof FACE+4
	call	mem_alloc
	jz	x
	mov	[esi].MDL.FACE_p,eax

	mov	[eax].FACE.ID,100h
	mov	[eax].FACE.V1,0*sizeof XYZ
	mov	[eax].FACE.V2,1*sizeof XYZ
	mov	[eax].FACE.V3,2*sizeof XYZ
	mov	[eax].FACE.V4,3*sizeof XYZ

	mov	edx,facelineo
	mov	[eax].FACE.LINE,edx

	mov	edx,faceixy1
	mov	[eax].FACE.IXY1,edx
	mov	edx,faceixy2
	mov	[eax].FACE.IXY2,edx
	mov	edx,faceixy3
	mov	[eax].FACE.IXY3,edx
	mov	edx,faceixy4
	mov	[eax].FACE.IXY4,edx

	mov	DPTR [eax+sizeof FACE],-1	;End


	inc	facenum
	mov	eax,facenum
	lea	edi,[esi].MDL.N_s
	call	stritoa

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

wlp:
	mov	ebx,xpos
	add	ebx,ebx				;*2
	mov	ecx,ypos
	add	ecx,ecx
	sub	ebx,xdlt
	sub	ecx,ydlt
	sar	ebx,1				;/2
	sar	ecx,1				;/2
	mov	tpx,ebx
	mov	tpy,ecx


	mov	eax,viewy
	sar	eax,8
	sub	eax,300
	add	eax,floorhgt
	mov	modely,eax

	mov	eax,tpx
	sar	eax,8
	mov	modelx,eax

	mov	eax,tpy
	sar	eax,8
	mov	modelz,eax

	CLR	eax
	mov	modelxa,ax
	mov	modelya,ax
	mov	modelza,ax

	call	model_put


	mov	eax,xpos
	sub	eax,xdlt
	mov	xpos,eax

	mov	eax,ypos
	sub	eax,ydlt
	mov	ypos,eax

	dec	wcnt
	jg	wlp


	mov	eax,modelcnt
	dec	eax
	call	mlst_select

	call	obj_cnt
	dec	eax
	call	olst_select

	CLR	eax
	mov	mapx1,eax
	mov	mapy1,eax
	mov	mapx2,eax
	mov	mapy2,eax


	call	_3d_drawall
x:
	ret

 SUBEND


;********************************
;* Add floor or ceiling to world at line on map
;* AL = Mode (0=Floor, 1=Ceiling)

 SUBRP	map_flrceiladd

	local	tpx:dword,
		tpy:dword,
		xcnt:dword,
		xcntsv:dword,
		ycnt:dword,
		xpos:dword,
		ypos:dword,
		xdlt:dword,
		ydlt:dword,
		mode:byte

	mov	mode,al


	mov	eax,mapx1w
	mov	xpos,eax
	sub	eax,mapx2w
	mov	xdlt,eax			;Neg
	jge	@F
	neg	eax
@@:
	mov	ecx,mapy1w
	mov	ypos,ecx
	sub	ecx,mapy2w
	mov	ydlt,ecx
	jge	@F
	neg	ecx
@@:
	TST	eax
	jle	x				;Bad?
	TST	ecx
	jle	x				;Bad?
@@:
	cdq
	mov	ebx,MAPBSZ*256
	idiv	ebx
	TST	eax
	jnz	@F
	inc	eax				;1
@@:
	mov	xcnt,eax
	mov	xcntsv,eax
	mov	ebx,eax

	mov	eax,xdlt
	cdq
	idiv	ebx
	mov	xdlt,eax


	mov	eax,ecx
	cdq
	mov	ebx,MAPBSZ*256
	idiv	ebx
	TST	eax
	jnz	@F
	inc	eax				;1
@@:
	mov	ycnt,eax
	mov	ebx,eax

	mov	eax,ydlt
	cdq
	idiv	ebx
	mov	ydlt,eax

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	eax,4+sizeof XYZ*4
	call	mem_alloc
	jz	x
	mov	edi,eax

	call	model_alloc
	jz	x
	mov	esi,eax

	mov	modellast_p,esi			;Select

	mov	ebx,facetga_p
	mov	[esi].MDL.TGA_p,ebx

	mov	eax,edi
	mov	[esi].MDL.PTS_p,eax

	mov	DPTR [eax],4

	mov	edx,-MAPBSZ/2
	cmp	mode,0
	je	@F				;Floor?
	neg	edx
@@:
	mov	4[eax+0*sizeof XYZ].XYZ.X,edx
	mov	4[eax+3*sizeof XYZ].XYZ.X,edx
	neg	edx
	mov	4[eax+1*sizeof XYZ].XYZ.X,edx
	mov	4[eax+2*sizeof XYZ].XYZ.X,edx
	mov	edx,MAPBSZ/2
	mov	4[eax+2*sizeof XYZ].XYZ.Z,edx
	mov	4[eax+3*sizeof XYZ].XYZ.Z,edx
	neg	edx
	mov	4[eax+0*sizeof XYZ].XYZ.Z,edx
	mov	4[eax+1*sizeof XYZ].XYZ.Z,edx
	CLR	edx
	mov	4[eax+0*sizeof XYZ].XYZ.Y,edx
	mov	4[eax+1*sizeof XYZ].XYZ.Y,edx
	mov	4[eax+2*sizeof XYZ].XYZ.Y,edx
	mov	4[eax+3*sizeof XYZ].XYZ.Y,edx


	mov	eax,sizeof FACE+4
	call	mem_alloc
	jz	x
	mov	[esi].MDL.FACE_p,eax

	mov	[eax].FACE.ID,100h
	mov	[eax].FACE.V1,0*sizeof XYZ
	mov	[eax].FACE.V2,1*sizeof XYZ
	mov	[eax].FACE.V3,2*sizeof XYZ
	mov	[eax].FACE.V4,3*sizeof XYZ

	mov	edx,facelineo
	mov	[eax].FACE.LINE,edx

	mov	edx,faceixy1
	mov	[eax].FACE.IXY1,edx
	mov	edx,faceixy2
	mov	[eax].FACE.IXY2,edx
	mov	edx,faceixy3
	mov	[eax].FACE.IXY3,edx
	mov	edx,faceixy4
	mov	[eax].FACE.IXY4,edx

	mov	DPTR [eax+sizeof FACE],-1	;End


	inc	facenum
	mov	eax,facenum
	lea	edi,[esi].MDL.N_s
	call	stritoa


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

ylp:
	mov	eax,mapx1w
	mov	xpos,eax
	mov	eax,xcntsv
	mov	xcnt,eax

xlp:
	mov	ebx,xpos
	mov	ecx,ypos
	add	ebx,ebx				;*2
	add	ecx,ecx
	sub	ebx,xdlt
	sub	ecx,ydlt
	sar	ebx,1+8				;/2 & loose frac
	sar	ecx,1+8
	mov	modelx,ebx
	mov	modelz,ecx

	mov	eax,floorhgt
	cmp	mode,0
	je	@F				;Floor?
	mov	eax,ceilhgt
@@:
	mov	ebx,viewy
	sar	ebx,8
	sub	ebx,300
	add	eax,ebx
	mov	modely,eax

	CLR	eax
	mov	modelxa,ax
	mov	modelya,ax
	mov	modelza,ax

	call	model_put


	mov	eax,xpos
	sub	eax,xdlt
	mov	xpos,eax

	dec	xcnt
	jg	xlp

	mov	eax,ypos
	sub	eax,ydlt
	mov	ypos,eax

	dec	ycnt
	jg	ylp

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	eax,modelcnt
	dec	eax
	call	mlst_select

	call	obj_cnt
	dec	eax
	call	olst_select


	CLR	eax
	mov	mapx1,eax
	mov	mapy1,eax
	mov	mapx2,eax
	mov	mapy2,eax

	call	_3d_drawall
x:
	ret

 SUBEND


;********************************
;* Set data for block at point on map

 SUBRP	map_blkset

	local	tx1:dword,\
		ty1:dword,\
		tx2:dword,\
		ty2:dword,\
		tpx:dword,\
		tpy:dword


	mov	ebx,MAPBSZ

	mov	eax,mapx2v
	sub	eax,MAPPX+MAPPW/2
	imul	eax,mapscl
	shl	eax,8
	add	eax,viewx
	cdq
	idiv	ebx
	sar	eax,8
	add	eax,MAPW/2
	cmp	eax,MAPW
	jae	err			;Out of range?
	mov	ecx,eax

	mov	eax,mapy2v
	sub	eax,MAPPY+MAPPH/2
	imul	eax,mapscl
	shl	eax,8
	add	eax,viewz
	cdq
	idiv	ebx
	sar	eax,8
	add	eax,MAPH/2
	cmp	eax,MAPH
	jae	err			;Out of range?
	imul	eax,MAPW*4

	shl	ecx,2			;*4
	add	ecx,eax

	lea	eax,maph_s
	call	stratoi
	and	eax,M_MAPH
	mov	edx,eax

	lea	eax,mapil_s
	call	stratoi
	shl	eax,S_MAPIL
	and	eax,M_MAPIL
	or	edx,eax

	mov	map_t[ecx],edx
err:
	CLR	eax
	mov	mapx1,eax
	mov	mapy1,eax
	mov	mapx2,eax
	mov	mapy2,eax

	call	_3d_drawall
x:
	ret

 SUBEND


;********************************
;* Select closest obj to map center

 SUBRP	map_selectclosest

	local	rad:dword,
		o_p:dword,
		onum:dword

	mov	rad,7fffffffh
	CLR	ecx
	mov	esi,world_p
	jmp	ostrt

olp:
	mov	eax,[esi].D3OBJ.X
	sub	eax,viewx
	jge	@F
	neg	eax
@@:
	mov	ebx,[esi].D3OBJ.Z
	sub	ebx,viewz
	jge	@F
	neg	ebx
@@:
	cmp	eax,ebx
	jl	@F
	xchg	eax,ebx
@@:
	sar	eax,1			;/2
	add	eax,ebx			;Radius
	cmp	eax,rad
	jge	@F
	mov	rad,eax
	mov	o_p,esi
	mov	onum,ecx
@@:
onxt:
	inc	ecx
	mov	esi,[esi].D3OBJ.WNXT_p
ostrt:
	TST	esi
	jnz	olp


	mov	eax,onum
	call	olst_select

	call	obj_findsel
	jz	x
	mov	eax,[eax].D3OBJ.MDL_p
	call	model_findindx
	call	mlst_select

x:
	ret

 SUBEND


;********************************
;* Select closest obj to map center

 SUBRP	map_setflrhgt

	local	zzz:dword


	mov	ecx,MAPW*MAPH
	lea	ebx,map_t
	mov	eax,-1
	and	eax,M_MAPH
@@:
	mov	edx,[ebx]
	and	edx,not M_MAPH
	or	edx,eax
	mov	[ebx],edx

	add	ebx,4
	loop	@B


	mov	esi,world_p
	jmp	ostrt

olp:
	mov	ebx,[esi].D3OBJ.PTS_p
	mov	eax,4[ebx+0*sizeof XYZ].XYZ.Y
	cmp	eax,4[ebx+1*sizeof XYZ].XYZ.Y
	jne	onxt
	cmp	eax,4[ebx+2*sizeof XYZ].XYZ.Y
	jne	onxt

	mov	eax,4[ebx+0*sizeof XYZ].XYZ.X
	cmp	eax,4[ebx+1*sizeof XYZ].XYZ.X
	jge	onxt

	mov	ebx,[esi].D3OBJ.FACE_p

	mov	ebx,MAPBSZ

	mov	eax,[esi].D3OBJ.X
	cdq
	idiv	ebx
	sar	eax,8
	add	eax,MAPW/2
	cmp	eax,MAPW
	jae	onxt			;Out of range?
	mov	ecx,eax

	mov	eax,[esi].D3OBJ.Z
	cdq
	idiv	ebx
	sar	eax,8
	add	eax,MAPH/2
	cmp	eax,MAPH
	jae	onxt			;Out of range?
	imul	eax,MAPW*4

	shl	ecx,2			;*4
	add	ecx,eax

	mov	eax,[esi].D3OBJ.Y
	sar	eax,8
	mov	ebx,10
	cdq
	idiv	ebx
	and	eax,M_MAPH

	mov	edx,map_t[ecx]
	and	edx,not M_MAPH
	or	edx,eax
	mov	map_t[ecx],edx


onxt:
	mov	esi,[esi].D3OBJ.WNXT_p
ostrt:
	TST	esi
	jnz	olp

x:
	ret

 SUBEND


;****************************************************************
;* Run 3D game mode
;* Trashes ES

 SUBR	_3d_run

	pushad



	cmp	d3mode,1
	jne	x			;No init?


	mov	ax,13h			;>Set 320x200 256 color
	int	10h
	call	vid_chain4off


	CLR	al			;DAC color reg
	mov	cx,GENPALSZ
	lea	esi,genpal_t
	call	vid_setvgapal15

	mov	al,0f0h			;DAC color reg
	mov	cx,16
	mov	esi,offset d3pal_t
	call	vid_setvgapal18



					;>Save time
	mov	eax,ds:[46ch]
	push	eax


	if	NETON

	call	netinit
	jnz	neterr			;Error?
;	mov	logindata,ax

	mov	esi,eax

	mov	netsenddata_p,ebx	;Save my send *

	mov	eax,DPTR plname_s	;Copy name
	mov	[esi],eax
	mov	al,plname_s+4
	CLR	ah
	mov	4[esi],ax

	call	netready
	jnz	neterr			;Error?

	endif



	mov	ebx,offset plname_s
	call	cpanel_prttxt

	mov	ebx,offset start_s
	call	cpanel_prttxtatend



	CLR	eax
	mov	framecnt,eax


	mov	d3runsp,esp		;Save stack ptr


	call	snd_init


	call	keyb_init


	call	_3d_loadimgs




	mov	ax,0f00h+SC_MAPMASK	;>Clr vidmem
	mov	dx,SC_INDEX
	out	dx,ax

	cld
	CLR	eax
	mov	edi,0a0000h
	mov	ecx,256*256-1
	rep	stosb


	mov	simrun,1


	call	joy_read
	mov	joy1xcent,bx
	mov	joy1ycent,cx
	mov	joy1xpos,bx


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

lp:
	cmp	tickcnt,1
;	jl	lp
	mov	tickcnt,0


	inc	framecnt


					;>Clr keyboard buffer
	cli
	mov	ax,ds:[41ah]
	mov	ds:[41ch],ax
	sti

;	mov	ah,11h			;>Chk keyboard buffer
;	int	16h
;;	jz	chkjoy			;Empty?
;	jz	dokey			;Empty?
;
;gkey:	mov	ah,10h			;>Get key
;	int	16h
;	cmp	al,0e0h
;	jne	noe0			;!101 extended?
;	CLR	al
;noe0:	TST	al
;	jz	extkey			;Extended key?
;	CLR	ah
;extkey:	mov	keycode,ax
;
;	push	ax
;	mov	ah,11h			;>Chk keyboard buffer
;	int	16h
;	pop	ax
;	jnz	gkey			;Another?
;
;dokey:
;	cmp	ax,27
;	je	runquit			;Esc?





	mov	ebx,world_p		;>Add velocities
	jmp	vstrt

vlp:	mov	eax,[ebx].D3OBJ.XV
	add	[ebx].D3OBJ.X,eax
	mov	eax,[ebx].D3OBJ.ZV
	add	[ebx].D3OBJ.Z,eax
	mov	eax,[ebx].D3OBJ.YV
	add	[ebx].D3OBJ.Y,eax

	mov	ebx,[ebx].D3OBJ.WNXT_p
vstrt:
	TST	ebx
	jnz	vlp



	call	pl_update


	if	NETON
	call	pl_setupnetstat

	call	netframe		;out:ne on err (check neterror)
	jz	nfok
	cmp	al,13
	je	nfok			;Bad packet?

	mov	bx,38h
	mov	cx,160-8*10
	mov	dx,WINH+10
	mov	esi,offset vererr_s
	call	prt320
	mov	plshield,-1
	mov	pldeadcntdn,10

nfok:	mov	plnetact,0
	endif


	call	_3d_collide

	call	prc_dispatch
	TST	esi
	jnz	runquit			;Process error?

	call	_3d_build
	call	_3d_draw

	call	pl_drawcpanel


	mov	dx,CC_INDEX		;>Page flip
	mov	al,CC_STRTADRH
	out	dx,al
	inc	dx

	mov	al,BPTR vidpgoffset+1
	out	dx,al
	xor	BPTR vidpgoffset+1,80h

	mov	dx,3dah
@@:	in	al,dx
	and	al,8
	jnz	@B			;In VB?
@@:	in	al,dx
	and	al,8
	jz	@B			;Not in VB?


	call	rnd


;	cmp	plshield,0
;	jl	runquit			;Dead?


	mov	dx,201h
	in	al,dx
	test	al,80h
	jz	runquit
	cmp	i9esc,0
	je	lp


runquit::
	mov	esp,d3runsp		;Restore stack ptr


	if	NETON
	call	netfinal
	endif


	call	snd_uninit


	push	ds
	lds	edx,int9_fp
	INT21X	2509h			;Restore Int9 (KeyB)
	pop	ds

					;>Clr keyboard buffer
	cli
	mov	ax,ds:[41ah]
	mov	ds:[41ch],ax
	sti


neterr:
	mov	simrun,0
	mov	vidpgoffset,0

	call	vid_setvmode
	call	_3d_palinit
	call	main_draw
	call	mouse_reset


	pop	edx			;>Print frames/sec

	mov	eax,ds:[46ch]
	sub	eax,edx
	cdq
	mov	ecx,18
	div	ecx
	TST	eax
	jz	fsz
	mov	ecx,eax
	mov	eax,framecnt
	CLR	edx
	div	ecx

	mov	bx,0feffh
	CLR	ecx
	CLR	edx
	call	prt_dec
fsz:


x:
	popad
	ret

 SUBEND

	.data	;RGB at F0
d3pal_t	db	10,20,40	;Sky
	db	10,20,35
	db	10,20,30
	db	10,20,20
	db	10,18,07	;Ground
	db	08,18,06
	db	06,18,05
	db	0,0,0
	db	5,5,20		;Water
	db	3,0,0
	db	3,0,0
	db	63,63,63
	db	48,48,48
	db	32,32,32
	db	20,20,20
	db	63,63,5




;********************************
;* Get name from file
;* Trashes all non seg

 SUBRP	pl_getname

	mov	edx,offset configfname_s	;>Open read only
	INT21X	3d00h
	jc	x

	mov	bx,ax				;BX=File handle
	push	ebx

	mov	ecx,5				;# bytes
	mov	edx,offset plname_s
	INT21	3fh				;Read
	jc	err				;Error?

err:	pop	ebx				;>Close file
	INT21	3eh


	mov	esi,offset plname_s-1
	mov	ecx,5
lp:	inc	esi
	cmp	BPTR [esi],' '
	jge	@F
	mov	BPTR [esi],0
@@:	loop	lp


x:	ret

 SUBEND


;********************************
;* Initialize player for zone entry
;* Trashes all non seg, ES

 SUBRP	pl_reinit

	call	rnd			;>Random position
	movsx	eax,ax
	shl	eax,7
	mov	plx,eax

	call	rnd
	movsx	eax,ax
	shl	eax,7
	mov	plz,eax

	mov	ply,BLK10*10*256	;Air drop

	CLR	eax
	mov	plxa,ax
	mov	plya,ax
	mov	plza,ax
	mov	pltya,ax
	mov	plyv,eax

	mov	plshield,SHLDMAX

	mov	plnummsl,2


	mov	ax,0f00h+SC_MAPMASK	;>Clr cpanel on both pages
	mov	dx,SC_INDEX
	out	dx,ax

	cld

	CLR	eax
	mov	edi,0a0000h+WINH*320/4
	mov	ecx,(200-WINH)*320/4/2
	rep	stosw

	mov	edi,0a0000h+WINH*320/4+8000h
	mov	ecx,(200-WINH)*320/4/2
	rep	stosw


	ret

 SUBEND


;********************************
;* Do all player actions

 SUBRP	pl_update


	cmp	plshield,0
	jge	alive


	add	ply,6*256
	add	plya,20*256

	dec	pldeadcntdn
	jg	setpos

	call	pl_reinit

alive:
	mov	eax,plx
	mov	plxlast,eax
	mov	eax,plz
	mov	plzlast,eax


	CLR	eax
	mov	plyv,eax

	cmp	ply,0
	jle	@F
	mov	plyv,-24*256
@@:

	cmp	i9lft,0
	je	@F

					;Check shift keys
	test	BPTR ds:[417h],3
	jz	trnl			;None?
	sub	pltturnrate,40h
	jmp	@F

trnl:
	sub	plturnrate,40h

@@:
	cmp	i9rgt,0
	je	@F

					;Check shift keys
	test	BPTR ds:[417h],3
	jz	trnr			;None?
	add	pltturnrate,40h
	jmp	@F

trnr:
	add	plturnrate,40h

@@:
	cmp	i9up,0
	je	@F

	mov	ax,plya
mv:	call	sinecos_get
	sar	eax,1
	sar	ebx,1
;	imul	eax,MVSPD
;	imul	ebx,MVSPD

	add	eax,plx
	cmp	eax,-ARENAXSZ
	jl	posbad
	cmp	eax,ARENAXSZ
	jg	posbad

	neg	ebx
	add	ebx,plz
	cmp	ebx,-ARENAZSZ
	jl	posbad
	cmp	ebx,ARENAZSZ
	jg	posbad

	mov	plx,eax
	mov	plz,ebx
posbad:	jmp	chkfire

@@:
	cmp	i9down,0
	je	@F

	mov	ax,plya
	add	ah,80h
	jmp	mv
@@:
chkfire:
;	add	plturnrate,40h		;DEBUG

	mov	ax,plturnrate
	cmp	ax,8
	jb	@F
	add	plya,ax
	add	pltya,ax
	sar	ax,3			;/8
	sub	plturnrate,ax
@@:
	mov	ax,pltturnrate
	cmp	ax,8
	jb	@F
	add	pltya,ax
	sar	ax,3			;/8
	sub	pltturnrate,ax
@@:

chkjoy:
;	call	joy_read
;	sub	bx,joy1xcent
;
;	push	ax
;	mov	ax,joy1xpos
;	mov	dx,ax
;	shl	ax,4			;*16
;	sub	ax,dx
;	add	ax,bx
;	sar	ax,4			;/16
;	mov	joy1xpos,ax
;	mov	bx,ax
;	pop	ax
;
;	sar	bx,5
;	jg	@F			;Right?
;	inc	bx
;	jge	nol			;!Left?
;@@:
;;	add	bx,bx
;	cmp	bx,2
;	jle	@F
;	mov	bx,2
;@@:	cmp	bx,-2
;	jge	@F
;	mov	bx,-2
;@@:	add	plya,bx
;nol:
;	sub	cx,joy1ycent
;	sar	cx,6
;	jg	@F			;Down?
;	inc	cx
;	jge	noup			;!Up?
;@@:
;	push	ax
;	mov	ax,plya
;	TST	cx
;	jl	@F
;	add	al,80
;@@:	call	sinecos_get
;	sar	eax,3
;	sar	ebx,3
;	imul	eax,MVSPD
;	imul	ebx,MVSPD
;	add	plx,eax
;	sub	plz,ebx
;	pop	ax
;
;noup:	test	al,10h			;J1B1
;	jz	fire





	cmp	ply,BLK10*1*256
	jg	inair


	mov	plmslturn,0
	cmp	i9lb,0
	jne	@F
	inc	plmslturn
@@:
	cmp	i9rb,0
	jne	@F
	dec	plmslturn
@@:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	esi,world_p		;Search world
	jmp	cstrt

collp:
	mov	ax,[esi].D3OBJ.ID
	TST	ax
	jz	cnxt

	mov	eax,[esi].D3OBJ.X
	sub	eax,plx
	jge	@F
	neg	eax
@@:	sar	eax,8			;Kill frac
	sub	eax,[esi].D3OBJ.CLRNG
	sub	eax,200
	jge	cnxt

	mov	eax,[esi].D3OBJ.Z
	sub	eax,plz
	jge	@F
	neg	eax
@@:	sar	eax,8			;Kill frac
	sub	eax,[esi].D3OBJ.CLRNG
	sub	eax,200
	jge	cnxt

	mov	ax,[esi].D3OBJ.ID

	cmp	ax,CLSENMY+TYPTNK
	je	mvbk

	cmp	ax,CLSNEUT+TYPNETTNK
	je	mvbk


	cmp	ah,(CLSNEUT+TYPGND)/256
	jne	notgnd

	cmp	al,SUBHL
	jb	mvbk			;Obstacle?

	movzx	eax,al
	imul	eax,BLK5/2*256

	CLR	ecx
	cmp	ply,eax
	jge	@F
	mov	ecx,32*256		;Elevate
@@:	mov	plyv,ecx

	jmp	cnxt

notgnd:
	cmp	ax,CLSENMY+TYPTNKSHOT
	jne	notts

	mov	edi,[esi].D3OBJ.PRC_p	;Kill shot
	mov	ens_fuel[edi],0

	mov	ebx,ens_pdta_p[edi]
	call	cpanel_prttxt
	mov	ebx,offset hitby_s
	call	cpanel_prttxtatend

	mov	ax,5000
	mov	bx,10000
	mov	cx,1
	call	snd_start

	sub	plshield,100
	jge	@F
	mov	ebx,ens_pdta_p[edi]
	call	pl_kill
@@:
	jmp	cnxt

notts:
	cmp	ax,CLSENMY+TYPENBUL
	jne	notb

	mov	edi,[esi].D3OBJ.PRC_p	;Kill shot
	mov	enb_fuel[edi],-1

	mov	ax,2000
	mov	bx,2000
	mov	cx,2
	call	snd_start

	sub	plshield,20
	jge	@F
	mov	ebx,enb_pdta_p[edi]
	call	pl_kill
@@:
	jmp	cnxt

notb:
	cmp	ax,CLSENMY+TYPENMSL
	jne	cnxt

	mov	edi,[esi].D3OBJ.PRC_p	;Kill msl
	mov	enm_fuel[edi],-1

	mov	ebx,enm_pdta_p[edi]
	call	cpanel_prttxt
	mov	ebx,offset hitby_s
	call	cpanel_prttxtatend

	mov	ax,5000
	mov	bx,5000
	mov	cx,1
	call	snd_start

	sub	plshield,100
	jge	@F
	mov	ebx,enm_pdta_p[edi]
	call	pl_kill
@@:
	jmp	cnxt



mvbk:	mov	eax,plxlast
	mov	plx,eax
	mov	eax,plzlast
	mov	plz,eax

cnxt:
	mov	esi,[esi].D3OBJ.WNXT_p
cstrt:
	TST	esi
	jnz	collp


inair:

	mov	eax,plyv
	add	ply,eax

setpos:
	mov	esi,plcobj_p
	mov	edi,pltobj_p


	mov	eax,plx
	mov	viewx,eax
	mov	[esi].D3OBJ.X,eax
	mov	[edi].D3OBJ.X,eax

	mov	eax,plz
	mov	viewz,eax
	mov	[esi].D3OBJ.Z,eax
	add	eax,5*256
	mov	[edi].D3OBJ.Z,eax

	mov	eax,ply
	mov	[esi].D3OBJ.Y,eax
	add	eax,10*256
	mov	[edi].D3OBJ.Y,eax
	add	eax,200*256
	mov	viewy,eax

	mov	ax,plxa
	mov	viewxa,ax

	mov	ax,plya
	neg	ax
	mov	[esi].D3OBJ.YA,ax

	mov	ax,pltya
	mov	viewya,ax
	neg	ax
	mov	[edi].D3OBJ.YA,ax

	mov	ax,plza
	mov	viewza,ax


	cmp	i9s,0
	je	@F
	mov	viewy,22000*256
	mov	viewxa,040h*256
	CLR	eax
	mov	viewya,ax
@@:


	ret
 SUBEND



;********************************
;* Kill the player
;* EBX=* killers name
;* Trashes EAX

 SUBRP	pl_kill

	push	ebx
	push	ecx
	push	esi

	mov	esi,netsenddata_p		;Get my send *
	mov	eax,[ebx]
	mov	DPTR [esi].NETSTAT.KNAME_s,eax
	mov	ax,4[ebx]
	mov	WPTR 4[esi].NETSTAT.KNAME_s,ax

	or	plnetact,10h

	mov	pldeadcntdn,TSEC*4

	mov	ebx,offset dead_s
	call	cpanel_prttxt

	pop	esi
	pop	ecx
	pop	ebx
	ret

 SUBEND

	.data
dead_s	db	"YOU ARE DEAD!",0


;********************************
;* Read joystick 1
;* >AL=Joy bits (4=J1B1, 5=J1B2, 6=J2B1, 7=J2B2)
;* >BX=X pos (0-?)
;* >CX=Y pos (0-?)

 SUBRP	joy_read

	mov	dx,201h

	CLR	ebx
	CLR	al
	cli
	out	dx,al
j1x:	in	al,dx
	test	al,1
	jz	@F
	inc	bx
	jge	j1x
@@:	sti

	mov	cx,bx		;Let Y sample finish
j1wt:	in	al,dx
	test	al,2
	jz	@F
	inc	cx
	jge	j1wt
@@:
	CLR	ecx
	CLR	al
	cli
	out	dx,al
j1y:	in	al,dx
	test	al,2
	jz	@F
	inc	cx
	jge	j1y
@@:	sti

	ret

 SUBEND


;********************************
;* Manage players weapons (Process)

 SUBRP	pl_weapon1

lp:	SLEEP	1

	cmp	i9spc,0
	je	lp

	cmp	ply,BLK10*1*256
	jg	slp

	cmp	plshield,0
	jl	slp

	or	plnetact,1

	CREATE	0,pl_shell

	mov	ax,30000
	CLR	ebx
	mov	cx,2
	call	snd_start

slp:	SLEEP	25
	jmp	lp

 SUBEND

;********************************
;* Player's shot (Process)

 SUBRP	pl_shell

	call	_3d_getobj
	jz	prc_die

	mov	[edi].D3OBJ.ID,CLSPLYR+TYPPSHOT
	mov	[edi].D3OBJ.CLRNG,BLK5/4
	mov	[edi].D3OBJ.PRC_p,esi

	mov	eax,offset pshot_pts
	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,offset pshot_lt
	mov	[edi].D3OBJ.FACE_p,eax

	mov	eax,plx
	mov	[edi].D3OBJ.X,eax
	mov	eax,plz
	mov	[edi].D3OBJ.Z,eax
	mov	eax,ply
	add	eax,180*256
	mov	[edi].D3OBJ.Y,eax

	CLR	eax

	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.ZA,ax

	mov	ax,pltya
	neg	ax
	mov	[edi].D3OBJ.YA,ax
	neg	ax
	call	sinecos_get
	shl	eax,1
	shl	ebx,1
	mov	[edi].D3OBJ.XV,eax
	neg	ebx
	mov	[edi].D3OBJ.ZV,ebx

	mov	[esi].PRC.DATA,TSEC*4

lp:
	SLEEP	1
	dec	[esi].PRC.DATA
	jg	lp


	mov	[edi].D3OBJ.ID,CLSDEAD

	CREATE	0,fragment_obj		;>Fragment
	mov	frag_srcobj_p[ebx],edi
	mov	frag_cnt[ebx],8

	CLR	eax
	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.ZV,eax
	SLEEP	3



	call	_3d_freeobj
	DIE


	.data
X=BLK10/2/6
Y=BLK10/2/6
;Z=BLK10/2/4
Z=0
pshot_pts\
	dd	4
	dd	-X	,Y	,Z
	dd	X	,Y	,Z
	dd	X	,-Y	,Z
	dd	-X	,-Y	,Z
;	dd	0	,0	,-Z
pshot_lt=$
	FACEM	PLSHOT_TX,0,1,2,3	;S
;	FACEM	253,1,0,4,		;T
;	FACEM	253,3,2,4,		;B
;	FACEM	254,0,3,4,		;W
;	FACEM	254,2,1,4,		;E
	dd	-1
	.code

 SUBEND



;********************************
;* Manage players weapons (Process)

 SUBRP	pl_weapon2

lp:	SLEEP	1

	cmp	i9alt,0
	je	lp

	cmp	ply,BLK10*1*256
	jg	slp

	cmp	plshield,0
	jl	slp

	or	plnetact,2

	CREATE	0,pl_bullet

slp:	SLEEP	3
	jmp	lp

 SUBEND

;********************************
;* Player's shot (Process)

 SUBRP	pl_bullet

	call	_3d_getobj
	jz	prc_die

	mov	[edi].D3OBJ.ID,CLSPLYR+TYPPSHOT
	mov	[edi].D3OBJ.CLRNG,BLK5/20
	mov	[edi].D3OBJ.PRC_p,esi

	mov	eax,offset pbul_pts
	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,offset pbul_lt
	mov	[edi].D3OBJ.FACE_p,eax

	mov	ax,pltya			;>Find pos offset
	add	ah,20h
	call	sinecos_get
	sar	eax,2
	sar	ebx,2
	neg	ebx

	add	eax,plx
	mov	[edi].D3OBJ.X,eax
	add	ebx,plz
	mov	[edi].D3OBJ.Z,ebx
	mov	eax,ply
	add	eax,180*256
	mov	[edi].D3OBJ.Y,eax

	CLR	eax

	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.ZA,ax

	mov	ax,pltya
	neg	ax
	mov	[edi].D3OBJ.YA,ax
	neg	ax
	call	sinecos_get
	shl	eax,1
	shl	ebx,1
	mov	[edi].D3OBJ.XV,eax
	neg	ebx
	mov	[edi].D3OBJ.ZV,ebx

	mov	[esi].PRC.DATA,10
lp:
	SLEEP	1
	dec	[esi].PRC.DATA
	jg	lp
	jz	x			;Out of time?


	mov	[edi].D3OBJ.ID,CLSDEAD

	CREATE	0,fragment_obj		;>Fragment (We hit something)
	mov	frag_srcobj_p[ebx],edi
	mov	frag_cnt[ebx],3

	CLR	eax
	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.ZV,eax
	SLEEP	3



x:	call	_3d_freeobj
	DIE

 SUBEND

	.data
X=BLK5/20
Y=BLK5/20
Z=0
pbul_pts\
	dd	4
	dd	-X	,Y	,Z
	dd	X	,Y	,Z
	dd	X	,-Y	,Z
	dd	-X	,-Y	,Z
pbul_lt=$
	FACEM	YELBALL_TX,0,1,2,3	;S
	dd	-1


;********************************
;* Player shot collision (Shell or bullet)

 SUBRP	pl_shot_hit

	mov	esi,[ebx].D3OBJ.PRC_p
	mov	[esi].PRC.DATA,0

	ret

 SUBEND


;********************************
;* Manage players missiles (Process)

 SUBRP	pl_mslmain

;DEBUG
;	mov	plnummsl,10

lp:	SLEEP	1

	cmp	i9m,0
	je	lp

	cmp	ply,BLK10*1*256
	jg	slp

	cmp	plshield,0
	jl	slp

	dec	plnummsl
	jl	slp			;None?

	or	plnetact,4

	CREATE	0,pl_msl

slp:	SLEEP	TSEC*4
	jmp	lp

 SUBEND

;********************************
;* Player's missile (Process)

	STRUCTPD
	ST_W	msl_fuel	;
	ST_W	msl_dir		;Dir 10:6

 SUBRP	pl_msl

	call	_3d_getobj
	jz	prc_die

	mov	[edi].D3OBJ.ID,CLSPLYR+TYPPSHOT
	mov	[edi].D3OBJ.CLRNG,BLK5/10
	mov	[edi].D3OBJ.PRC_p,esi

	mov	eax,offset pmsl_pts
	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,offset pmsl_lt
	mov	[edi].D3OBJ.FACE_p,eax

	mov	ax,pltya			;>Find pos offset
	add	ah,20h
	call	sinecos_get
	sar	eax,2
	sar	ebx,2
	neg	ebx

	add	eax,plx
	mov	[edi].D3OBJ.X,eax
	add	ebx,plz
	mov	[edi].D3OBJ.Z,ebx
	mov	eax,ply
	add	eax,180*256
	mov	[edi].D3OBJ.Y,eax

	CLR	eax

	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.ZA,ax

	mov	ax,pltya
	mov	msl_dir[esi],ax

	mov	msl_fuel[esi],100
lp:
	mov	ax,plmslturn
	shl	ax,9
	add	msl_dir[esi],ax

	mov	ax,msl_dir[esi]
	mov	viewya,ax
	neg	ax
	mov	[edi].D3OBJ.YA,ax
	neg	ax
	call	sinecos_get

	mov	[edi].D3OBJ.XV,eax
	neg	ebx
	mov	[edi].D3OBJ.ZV,ebx

	add	eax,[edi].D3OBJ.X
	mov	viewx,eax
	add	ebx,[edi].D3OBJ.Z
	mov	viewz,ebx
	mov	eax,[edi].D3OBJ.Y
	mov	viewy,eax

	SLEEP	1
	dec	msl_fuel[esi]
	jg	lp
	jz	x			;Out of time?


	mov	[edi].D3OBJ.ID,CLSDEAD

	CREATE	0,fragment_obj		;>Fragment (We hit something)
	mov	frag_srcobj_p[ebx],edi
	mov	frag_cnt[ebx],7

	CLR	eax
	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.ZV,eax
	SLEEP	3



x:	call	_3d_freeobj
	DIE

 SUBEND

	.data
X=BLK5/10
Y=BLK5/10
Z=BLK5/5
pmsl_pts\
	dd	9
	dd	0	,Y	,Z
	dd	X*3/4	,Y*3/4	,Z
	dd	X	,0	,Z
	dd	X*3/4	,-Y*3/4	,Z
	dd	0	,-Y	,Z
	dd	-X*3/4	,-Y*3/4	,Z
	dd	-X	,0	,Z
	dd	-X*3/4	,Y*3/4	,Z
	dd	0	,0	,-Z
pmsl_lt=$
	FACEM	94h,0,1,2,3	;Tail
	FACEM	94h,4,5,6,7
	FACEM	16h,0,8,1,1
	FACEM	14h,1,8,2,2
	FACEM	10h,2,8,3,3
	FACEM	0eh,3,8,4,4
	FACEM	10h,4,8,5,5
	FACEM	11h,5,8,6,6
	FACEM	13h,6,8,7,7
	FACEM	15h,7,8,0,0
	dd	-1



;********************************
;* Killer guy! (Process)

 SUBRP	en_guy

	call	_3d_getobj
	jz	prc_die

	mov	[edi].D3OBJ.ID,0
	mov	[edi].D3OBJ.PRC_p,esi

	mov	eax,offset guy_pts
	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,offset guy_lt
	mov	[edi].D3OBJ.FACE_p,eax

	mov	eax,-BLK10*4*256
	mov	[edi].D3OBJ.X,eax
	mov	eax,-BLK10*4*256
	mov	[edi].D3OBJ.Z,eax

	CLR	eax
	mov	[edi].D3OBJ.Y,eax

	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.ZV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.YA,ax
	mov	[edi].D3OBJ.ZA,ax

lp:	add	[edi].D3OBJ.YA,4*256

	SLEEP	1
	jmp	lp

	.data
X=BLK10/2/2
Y=BLK10/2
Z=0
guy_pts\
	dd	4
	dd	-X	,Y	,Z
	dd	X	,Y	,Z
	dd	X	,0	,Z
	dd	-X	,0	,Z
guy_lt=$
	FACEM	MIDWAY_TX,0,1,2,3
	dd	-1
	.code

 SUBEND



;********************************
;* Draw all parts of player control panel

 SUBRP	pl_drawcpanel

	call	radar_draw


	mov	ax,100h+SC_MAPMASK		;>Draw gun sight
	mov	dx,SC_INDEX
	out	dx,ax

	mov	al,16h				;Grey
	mov	esi,vidpgoffset
	add	esi,0a0000h+WINH/2*320/4

	mov	ecx,4
chlp:	mov	(((160-12)-320*5)/4)[esi],al
	mov	(((160+12)-320*5)/4)[esi],al
	mov	(((160-12)+320*2)/4)[esi],al
	mov	(((160+12)+320*2)/4)[esi],al
	add	si,320/4
	dec	ecx
	jg	chlp


	mov	bx,32h
	CLR	ecx

	mov	esi,offset cpanell1_s
	mov	dx,176
	call	prt320f6

	mov	esi,offset cpanell2_s
	mov	dx,182
	call	prt320f6

	mov	esi,offset cpanell3_s
	mov	dx,188
	call	prt320f6

	mov	esi,offset cpanell4_s
	mov	dx,194
	call	prt320f6

	ret

 SUBEND



;********************************
;* Draw radar

MAPSZ=46
MAPX=260
MAPY=175
RADSZ=46
RADX=160
RADY=175

 SUBRP	radar_draw


	cmp	plshield,0
	jl	dead				;No map?


						;>Clr map
	mov	edi,vidpgoffset
	add	edi,(MAPX-MAPSZ/2-1+(MAPY-MAPSZ/2-1)*320)/4+0a0000h

	mov	ax,0f00h+SC_MAPMASK
	mov	dx,SC_INDEX
	out	dx,ax

	mov	edx,MAPSZ+2
cmylp:
	mov	ecx,(MAPSZ+2)/4
cmxlp:	mov	BPTR [edi],0feh
	inc	edi
	dec	ecx
	jg	cmxlp

	add	edi,(320-(MAPSZ+2))/4

	dec	edx
	jg	cmylp

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	esi,world_p
	jmp	mstrt

mlp:	mov	eax,[esi].D3OBJ.X
	sub	eax,plx
	sar	eax,19
	add	eax,MAPSZ/2
	jl	mnxt
	cmp	eax,MAPSZ
	jae	mnxt
	mov	ebx,eax

	mov	eax,[esi].D3OBJ.Z
	sub	eax,plz
	sar	eax,19
	add	eax,MAPSZ/2
	jl	mnxt
	cmp	eax,MAPSZ
	jae	mnxt


	add	ebx,MAPX-MAPSZ/2
	add	eax,MAPY-MAPSZ/2

	mov	cl,bl
	shr	ebx,2			;X/4
	imul	ax,320/4
	add	bx,ax			;+Y
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	mov	dx,SC_INDEX
	out	dx,ax

	add	ebx,vidpgoffset

	movzx	edi,WPTR [esi].D3OBJ.ID+1	;Get hi byte of ID
	and	di,1fh
	mov	al,BPTR (offset radcolr_t)[edi]
	mov	0a0000h[ebx],al



mnxt:
	mov	esi,[esi].D3OBJ.WNXT_p
mstrt:
	TST	esi
	jnz	mlp



	mov	ax,100h+SC_MAPMASK
	mov	dx,SC_INDEX
	out	dx,ax

	mov	BPTR ds:[0a0000h+(MAPX+MAPY*320)/4],056h	;Green






;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Clr radar

	mov	edi,0a0000h+(RADX-RADSZ/2-1+(RADY-RADSZ/2-1)*320)/4
	add	edi,vidpgoffset

	mov	ax,0f00h+SC_MAPMASK
	mov	dx,SC_INDEX
	out	dx,ax

	mov	edx,RADSZ+2
cylp:
	mov	ecx,(RADSZ+2)/4
cxlp:	mov	BPTR [edi],0feh
	inc	edi
	dec	ecx
	jg	cxlp

	add	edi,(320-(RADSZ+2))/4

	dec	edx
	jg	cylp




	mov	ax,plya
	call	sinecos_get
	mov	sinay,eax
	mov	cosay,ebx

	mov	esi,world_p
	jmp	strt

lp:
	mov	al,BPTR [esi].D3OBJ.ID+1	;Get hi byte of ID
	and	al,1fh
	cmp	al,3
	jle	nxt				;Non threat?

	mov	eax,[esi].D3OBJ.Z
	sub	eax,plz
	sar	eax,8+4
	mov	zrel,eax

	imul	eax,cosay		;Cos*Z
	mov	ecx,eax

	mov	eax,[esi].D3OBJ.X
	sub	eax,plx
	sar	eax,8+4
	push	eax

	imul	eax,sinay		;Sin*X
	sub	ecx,eax			;Z about Y

	mov	eax,zrel
	imul	eax,sinay		;Sin*Z
	mov	ebx,eax

	pop	eax
	imul	eax,cosay		;Cos*X
	add	eax,ebx			;X about Y


	sar	eax,7+16
	add	eax,RADSZ/2		;X
	jl	nxt
	cmp	eax,RADSZ
	jae	nxt
	mov	ebx,eax

	mov	eax,ecx
	sar	eax,7+16		;Z
	add	eax,RADSZ/2
	jl	nxt
	cmp	eax,RADSZ
	jae	nxt



	add	ebx,RADX-RADSZ/2
	add	eax,RADY-RADSZ/2

	mov	cl,bl
	shr	ebx,2			;X/4
	imul	ax,320/4
	add	bx,ax			;+Y
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	mov	dx,SC_INDEX
	out	dx,ax

	add	ebx,vidpgoffset

	movzx	edi,WPTR [esi].D3OBJ.ID+1	;Get hi byte of ID
	and	di,1fh
	mov	al,radcolr_t[edi]
	mov	0a0000h[ebx],al



nxt:
	mov	esi,[esi].D3OBJ.WNXT_p
strt:
	TST	esi
	jnz	lp



	mov	ax,100h+SC_MAPMASK
	mov	dx,SC_INDEX
	out	dx,ax

	mov	BPTR ds:[0a0000h+(RADX+RADY*320)/4],056h	;Green dot




dead:


	mov	ax,0f00h+SC_MAPMASK		;>Draw shield bar
	mov	dx,SC_INDEX
	out	dx,ax

	mov	edi,0a0000h+(4+(WINH+2)*320)/4
	add	edi,vidpgoffset

	mov	bx,plshield
	sar	bx,4				;/16
	mov	ecx,20
shlp:
	CLR	al
	dec	bx
	jl	@F
	mov	al,38h
@@:	mov	[edi],al
	mov	80[edi],al
	inc	edi
	dec	ecx
	jg	shlp




	ret
 SUBEND

	.data
radcolr_t	db	0f8h,0,050h,08h, 02dh,034h,0fbh,0aah




;********************************
;* Print ctrl panel txt
;* EBX=* ASCIIZ
;* Trashes AX,BX,CX

TXTX	equ	0
TXTY	equ	176
LEN=26

 SUBRP	cpanel_prttxt

	push	esi
	push	edi

	mov	edi,offset cpanell1_s
	mov	ecx,24/4
@@:
	mov	eax,LEN[edi]
	mov	[edi],eax
	mov	eax,(LEN*2)[edi]
	mov	LEN[edi],eax
	mov	eax,(LEN*3)[edi]
	mov	(LEN*2)[edi],eax
	mov	eax,[ebx]
	mov	(LEN*3)[edi],eax
	add	ebx,4
	add	edi,4
	loop	@B



	mov	edi,0a0000h+(TXTX+(TXTY)*320)/4		;>Clr text
;	add	edi,vidpgoffset

	mov	ax,0f00h+SC_MAPMASK
	mov	dx,SC_INDEX
	out	dx,ax

	mov	edx,6*4
cmylp:
	mov	ecx,(17*8)/4/2
cmxlp:	mov	WPTR [edi],0
	mov	WPTR 8000h[edi],0
	inc	edi
	inc	edi
	dec	ecx
	jg	cmxlp

	add	edi,(320-(17*8))/4

	dec	edx
	jg	cmylp



	pop	edi
	pop	esi

	ret

 SUBEND

	.data
cpanell1_s	db	26 dup (?)
cpanell2_s	db	26 dup (?)
cpanell3_s	db	26 dup (?)
cpanell4_s	db	26 dup (?)



;********************************
;* Print ctrl panel txt at end of last line
;* EBX=* ASCIIZ
;* Trashes AX,BX,CX

 SUBRP	cpanel_prttxtatend

	push	esi
	push	edi

	mov	edi,offset cpanell4_s-1
@@:	inc	edi
	cmp	BPTR [edi],0
	jne	@B


@@:	mov	al,[ebx]
	mov	[edi],al
	inc	ebx
	inc	edi
	TST	al
	jnz	@B

	pop	edi
	pop	esi

	ret

 SUBEND



;****************************************************************
;* Mech specific code

TSEC	equ	15



;********************************
;* Generate background (Process)

;GNDLEN	equ	BLK10*25
;
; SUBRP	bkgnd_create
;
;
;;	jmp	bctest
;
;	mov	rndlast,0
;
;
;	mov	ecx,8			;>Make north-south borders
;	mov	ebx,-35000*256
;
;lp:	call	_3d_getobj0
;	jz	prc_die			;No objs?
;
;	mov	[edi].D3OBJ.ID,CLSDEAD
;	mov	[edi].D3OBJ.FLGS,GND_OF
;
;	mov	eax,offset brdrns_pts
;	mov	[edi].D3OBJ.PTS_p,eax
;	mov	eax,offset brdr_lt
;	mov	[edi].D3OBJ.FACE_p,eax
;
;	mov	[edi].D3OBJ.X,-35000*256
;	mov	[edi].D3OBJ.Z,ebx
;
;
;	call	_3d_getobj0
;	jz	prc_die			;No objs?
;
;	mov	[edi].D3OBJ.ID,CLSDEAD
;	mov	[edi].D3OBJ.FLGS,GND_OF
;
;	mov	eax,offset brdrns_pts
;	mov	[edi].D3OBJ.PTS_p,eax
;	mov	eax,offset brdr_lt
;	mov	[edi].D3OBJ.FACE_p,eax
;
;	mov	[edi].D3OBJ.X,35000*256
;	mov	[edi].D3OBJ.Z,ebx
;
;
;	add	ebx,GNDLEN*256
;
;	loop	lp
;
;
;
;	mov	ecx,8			;>Make east-west borders
;	mov	ebx,-35000*256
;
;ewlp:	call	_3d_getobj0
;	jz	prc_die			;No objs?
;
;	mov	[edi].D3OBJ.ID,CLSDEAD
;	mov	[edi].D3OBJ.FLGS,GND_OF
;
;	mov	eax,offset brdrew_pts
;	mov	[edi].D3OBJ.PTS_p,eax
;	mov	eax,offset brdr_lt
;	mov	[edi].D3OBJ.FACE_p,eax
;
;	mov	[edi].D3OBJ.X,ebx
;	mov	[edi].D3OBJ.Z,-35000*256
;
;
;	call	_3d_getobj0
;	jz	prc_die			;No objs?
;
;	mov	[edi].D3OBJ.ID,CLSDEAD
;	mov	[edi].D3OBJ.FLGS,GND_OF
;
;	mov	eax,offset brdrew_pts
;	mov	[edi].D3OBJ.PTS_p,eax
;	mov	eax,offset brdr_lt
;	mov	[edi].D3OBJ.FACE_p,eax
;
;	mov	[edi].D3OBJ.X,ebx
;	mov	[edi].D3OBJ.Z,35000*256
;
;
;	add	ebx,GNDLEN*256
;
;	loop	ewlp
;
;
;
;	mov	ecx,25			;>Make trees
;
;tlp:	call	_3d_getobj0
;	jz	prc_die			;No objs?
;
;	mov	[edi].D3OBJ.ID,CLSNEUT+TYPGND
;	mov	[edi].D3OBJ.CLRNG,BLK5/2
;	mov	[edi].D3OBJ.FLGS,FLAT_OF
;
;	mov	eax,offset tree1_pts
;	mov	[edi].D3OBJ.PTS_p,eax
;	mov	eax,offset tree1_lt
;	mov	[edi].D3OBJ.FACE_p,eax
;
;	call	rnd
;	movsx	eax,ax
;	shl	eax,8
;	mov	[edi].D3OBJ.X,eax
;
;	call	rnd
;	movsx	eax,ax
;	shl	eax,8
;	mov	[edi].D3OBJ.Z,eax
;
;	loop	tlp
;
;;bctest:
;;	DIE	;DB
;
;	mov	ecx,7			;>Make big cubes
;
;cblp:	call	_3d_getobj0
;	jz	prc_die			;No objs?
;
;	mov	[edi].D3OBJ.ID,CLSNEUT+TYPGND
;	mov	[edi].D3OBJ.CLRNG,BLK5*5
;
;	mov	eax,offset bgcube_pts
;	mov	[edi].D3OBJ.PTS_p,eax
;	mov	eax,offset bgcube_lt
;	mov	[edi].D3OBJ.FACE_p,eax
;
;	call	rnd
;	movsx	eax,ax
;	shl	eax,8
;	mov	[edi].D3OBJ.X,eax
;
;;	mov	[edi].D3OBJ.X,-28000*256
;
;	call	rnd
;	movsx	eax,ax
;	shl	eax,8
;	mov	[edi].D3OBJ.Z,eax
;
;;	mov	[edi].D3OBJ.Z,-28000*256
;
;	loop	cblp
;
;
;	mov	ecx,15			;>Make hills
;
;hlp:
;	call	_3d_getobj0
;	jz	prc_die			;No objs?
;
;	mov	[edi].D3OBJ.ID,CLSNEUT+TYPGND+SUBHL
;	mov	[edi].D3OBJ.CLRNG,BLK5*3*3/4
;
;	mov	eax,offset hill_pts
;	mov	[edi].D3OBJ.PTS_p,eax
;	mov	eax,offset hill_lt
;	mov	[edi].D3OBJ.FACE_p,eax
;
;	call	rnd
;	movsx	eax,ax
;	shl	eax,8
;	mov	[edi].D3OBJ.X,eax
;
;	call	rnd
;	movsx	eax,ax
;	shl	eax,8
;	mov	[edi].D3OBJ.Z,eax
;
;
;	call	_3d_getobj0
;	jz	prc_die			;No objs?
;
;	mov	[edi].D3OBJ.ID,CLSNEUT+TYPGND+SUBHL+1
;	mov	[edi].D3OBJ.CLRNG,BLK5*3*3/4
;
;	mov	eax,offset hill2_pts
;	mov	[edi].D3OBJ.PTS_p,eax
;	mov	eax,offset hill2_lt
;	mov	[edi].D3OBJ.FACE_p,eax
;
;	call	rnd
;	movsx	eax,ax
;	shl	eax,8
;	mov	[edi].D3OBJ.X,eax
;
;	call	rnd
;	movsx	eax,ax
;	shl	eax,8
;	mov	[edi].D3OBJ.Z,eax
;
;	dec	ecx
;	jg	hlp
;
;
;
;
;	DIE
;
; SUBEND
;
;	.data
;X=BLK5
;Y=0
;Z=GNDLEN/2
;brdrns_pts\
;	dd	4
;	dd	-X	,Y	,-Z
;	dd	X	,Y	,-Z
;	dd	X	,Y	,Z
;	dd	-X	,Y	,Z
;X=GNDLEN/2
;Z=BLK5
;brdrew_pts\
;	dd	4
;	dd	-X	,Y	,-Z
;	dd	X	,Y	,-Z
;	dd	X	,Y	,Z
;	dd	-X	,Y	,Z
;brdr_lt=$
;	FACEM	0f8h,0,1,2,3
;	dd	-1
;
;X=BLK5*5
;Y=X/2
;Z=X
;;TX=MIDWAY_TX
;TX=0fdh
;bgcube_pts\
;	dd	8
;	dd	X	,Y	,Z
;	dd	X	,0	,Z
;	dd	-X	,0	,Z
;	dd	-X	,Y	,Z
;	dd	X	,Y	,-Z
;	dd	X	,0	,-Z
;	dd	-X	,0	,-Z
;	dd	-X	,Y	,-Z
;bgcube_lt=$
;	FACEM	CROSSH_TX,3,0,1,2	;S
;	FACEM	SQVIOLET_TX,4,7,6,5	;N
;	FACEM	SQGREY_TX,7,3,2,6	;W
;	FACEM	MIDWAY_TX,0,4,5,1	;E
;	dd	-1
;
;X=BLK5
;Y=BLK5*2
;Z=0
;tree1_pts\
;	dd	4
;	dd	-X	,Y	,Z
;	dd	X	,Y	,Z
;	dd	X	,0	,Z
;	dd	-X	,0	,Z
;tree1_lt=$
;	FACEM	TREE_TX,0,1,2,3
;	dd	-1
;
;
;X=BLK5*3
;X2=X*3/4
;Y=BLK5/2
;Z=X
;Z2=X2
;TX=046h
;hill_pts\
;	dd	8
;	dd	X2	,Y	,Z2
;	dd	X	,0	,Z
;	dd	-X	,0	,Z
;	dd	-X2	,Y	,Z2
;	dd	X2	,Y	,-Z2
;	dd	X	,0	,-Z
;	dd	-X	,0	,-Z
;	dd	-X2	,Y	,-Z2
;hill_lt=$
;	FACEM	TX-2,3,0,1,2	;S
;	FACEM	TX+2,4,7,6,5	;N
;	FACEM	TX-1,7,3,2,6	;W
;	FACEM	TX+1,0,4,5,1	;E
;	FACEM	TX,7,4,0,3	;T
;	dd	-1
;
;X=BLK5*3
;X2=X*3/4
;Y=BLK5
;Z=X
;Z2=X2
;TX=046h
;hill2_pts\
;	dd	8
;	dd	X2	,Y	,Z2
;	dd	X	,0	,Z
;	dd	-X	,0	,Z
;	dd	-X2	,Y	,Z2
;	dd	X2	,Y	,-Z2
;	dd	X	,0	,-Z
;	dd	-X	,0	,-Z
;	dd	-X2	,Y	,-Z2
;hill2_lt=$
;	FACEM	TX-2,3,0,1,2	;S
;	FACEM	TX+2,4,7,6,5	;N
;	FACEM	TX-1,7,3,2,6	;W
;	FACEM	TX+1,0,4,5,1	;E
;	FACEM	TX,7,4,0,3	;T
;	dd	-1


;********************************
;* Enemy spawner (Process)

 SUBRP	en_spawner

;tlp:	mov	[esi].PRC.DATA,15
;@@:
;	CREATE	0,en_traincar
;	SLEEP	12
;	dec	[esi].PRC.DATA
;	jg	@B
;
;	SLEEP	TSEC*60*2
;	jmp	tlp


;	mov	[esi].PRC.DATA,20
;@@:
;	CREATE	0,en_tnk1
;	SLEEP	TSEC*10
;	dec	[esi].PRC.DATA
;	jg	@B


	DIE

 SUBEND


;********************************
;* Tank 1 (Process)

	STRUCTPD
	ST_W	tnk_shield
	ST_W	tnk_dir		;Dir 0-255
	ST_W	tnk_sdir	;Seek dir 0-255
	ST_W	tnk_move	;!0=Move
	ST_D	tnk_tur_p	;* turret obj
	ST_D	tnk_brl_p	;* barrel obj

TRATE=1*256

 SUBRP	en_tnk1

	call	_3d_getobj		;>Init turret
	jz	prc_die			;No objs?

	mov	tnk_tur_p[esi],edi

	mov	[edi].D3OBJ.ID,CLSDEAD
	mov	[edi].D3OBJ.CLRNG,BLK5
	mov	[edi].D3OBJ.PRC_p,esi
;FIX!
;	mov	eax,offset m1t_pts
;	mov	[edi].D3OBJ.PTS_p,eax
;	mov	eax,offset m1t_lt
;	mov	[edi].D3OBJ.FACE_p,eax

	mov	eax,100*256
	mov	[edi].D3OBJ.Y,eax

;	mov	eax,offset tnk1t_pts
;	mov	[edi].D3OBJ.PTS_p,eax
;	mov	eax,offset tnk1t_lt
;	mov	[edi].D3OBJ.FACE_p,eax

;	mov	eax,215*256
;	mov	[edi].D3OBJ.Y,eax

	CLR	eax
	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.ZV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.YA,ax
	mov	[edi].D3OBJ.ZA,ax


	call	_3d_getobj		;>Init barrel
	jz	frtur			;No objs?

	mov	tnk_brl_p[esi],edi

	mov	[edi].D3OBJ.ID,CLSDEAD
	mov	[edi].D3OBJ.CLRNG,BLK5
	mov	[edi].D3OBJ.PRC_p,esi

	mov	eax,offset tnk1b_pts
	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,offset tnk1b_lt
	mov	[edi].D3OBJ.FACE_p,eax

	mov	eax,200*256
	mov	[edi].D3OBJ.Y,eax

	CLR	eax
	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.ZV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.YA,ax
	mov	[edi].D3OBJ.ZA,ax


	call	_3d_getobj
	jz	frbrl			;No objs?

	mov	[edi].D3OBJ.ID,CLSENMY+TYPTNK
	mov	[edi].D3OBJ.CLRNG,BLK5
	mov	[edi].D3OBJ.PRC_p,esi
;FIX!
;	mov	eax,offset m1chas_pts
;	mov	eax,offset tnk1ch_pts
	mov	[edi].D3OBJ.PTS_p,eax
;FIX!
;	mov	eax,offset m1chas_lt
;	mov	eax,offset tnk1ch_lt
	mov	[edi].D3OBJ.FACE_p,eax

	call	rnd
	movsx	eax,ax
	shl	eax,8
	mov	[edi].D3OBJ.X,eax

	call	rnd
	movsx	eax,ax
	shl	eax,8
	mov	[edi].D3OBJ.Z,eax

	mov	eax,100*256
	mov	[edi].D3OBJ.Y,eax

	CLR	eax
	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.ZV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.YA,ax
	mov	[edi].D3OBJ.ZA,ax

	mov	tnk_move[esi],ax
	mov	tnk_shield[esi],1

lp:
	call	rnd
	and	al,01fh
	jnz	noseek

	mov	eax,plx
	mov	ebx,plz
	call	seekob_dir256
	mov	tnk_sdir[esi],ax
noseek:

	mov	ax,tnk_sdir[esi]
	sub	ax,tnk_dir[esi]		;AX=Difference
	jz	noturn

	mov	dx,ax
	jge	@F
	neg	ax			;Make +
@@:	cmp	ah,128
	jbe	@F
	neg	dx
@@:
	mov	cx,dx
	cmp	ax,TRATE
	jbe	wdir

	mov	cx,TRATE
	TST	dx
	jge	wdir
	neg	cx
wdir:
	add	tnk_dir[esi],cx
noturn:


	call	rnd
	and	al,01fh
	jnz	mv

	mov	eax,plx
	mov	ebx,plz
	call	seekob_dir256
	cmp	ax,tnk_dir[esi]
	jne	mv

	CREATE	0,en_shell			;>Fire
	mov	[ebx].PRC.DATA,edi


mv:
	mov	ax,tnk_dir[esi]
	neg	ax
	mov	[edi].D3OBJ.YA,ax
;DEBUG
;	CLR	ax
;	inc	[edi].D3OBJ.YA
;	mov	ax,[edi].D3OBJ.YA

	call	rnd
	and	al,07fh
	jnz	@F
	not	tnk_move[esi]
@@:
	CLR	eax
	CLR	ebx
	cmp	tnk_move[esi],0
	je	nomv

	mov	ax,tnk_dir[esi]
	call	sinecos_get
	sar	eax,2
	sar	ebx,2
	neg	ebx
;DEBUG
;	CLR	eax
;	CLR	ebx
nomv:
	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.ZV,ebx


	push	esi

	mov	esi,tnk_tur_p[esi]	;>Position turret

	mov	ax,[edi].D3OBJ.YA
	mov	[esi].D3OBJ.YA,ax
	neg	ax
	call	sinecos_get
	sar	eax,4
	sar	ebx,4
	neg	ebx

	add	eax,[edi].D3OBJ.X
	mov	[esi].D3OBJ.X,eax

	add	ebx,[edi].D3OBJ.Z
	mov	[esi].D3OBJ.Z,ebx

	pop	esi


	push	esi

	mov	esi,tnk_brl_p[esi]	;>Position barrel

	mov	ax,[edi].D3OBJ.YA
	mov	[esi].D3OBJ.YA,ax
	neg	ax
	call	sinecos_get
	sar	eax,3
	sar	ebx,3
	neg	ebx

	add	eax,[edi].D3OBJ.X
	mov	[esi].D3OBJ.X,eax

	add	ebx,[edi].D3OBJ.Z
	mov	[esi].D3OBJ.Z,ebx

	pop	esi


	SLEEP	1
	cmp	tnk_shield[esi],0
	jge	lp


	mov	ax,40000
	mov	bx,-15000
	mov	cx,2
	call	snd_start


	CREATE	0,fragment_obj		;>Fragment
	mov	frag_srcobj_p[ebx],edi
	mov	frag_cnt[ebx],15

	CREATE	0,explode_obj		;>Explode
	mov	xpld_srcobj_p[ebx],edi


	mov	[edi].D3OBJ.ID,0	;>Spin
	mov	[esi].PRC.DATA,30

@@:	SLEEP	1
	add	[edi].D3OBJ.Y,6*256
	add	[edi].D3OBJ.YA,20*256
	dec	[esi].PRC.DATA
	jg	@B


	call	_3d_freeobj

frbrl:	mov	edi,tnk_brl_p[esi]
	call	_3d_freeobj

frtur:	mov	edi,tnk_tur_p[esi]
	call	_3d_freeobj


	DIE


 SUBEND

	.data
X=150
Y=80
Z=300
TX=100h
tnk1ch_pts\
	dd	8
	dd	X,	Y,	Z
	dd	X,	-Y,	Z
	dd	-X,	-Y,	Z
	dd	-X,	Y,	Z
	dd	X,	Y-20,	-Z
	dd	X,	-Y,	-Z
	dd	-X,	-Y,	-Z
	dd	-X,	Y-20,	-Z
tnk1ch_lt=$
	FACEM	TNKS_TX,3,0,1,2		;South
	FACEM	TNKN_TX,4,7,6,5		;North
	FACEM	TNKW_TX,7,3,2,6		;West
	FACEM	TNKE_TX,0,4,5,1		;East
	FACEM	4,5,6,2,1		;Bot
	FACEM	4,7,4,0,3		;Top
	dd	-1

X=120
Y=35
Z=170
O=-60
tnk1t_pts\
	dd	8
	dd	X,	Y,	Z-O
	dd	X,	-Y,	Z-O
	dd	-X,	-Y,	Z-O
	dd	-X,	Y,	Z-O
	dd	X,	Y-20,	-Z-O
	dd	X,	-Y-10,	-Z-O
	dd	-X,	-Y-10,	-Z-O
	dd	-X,	Y-20,	-Z-O
tnk1t_lt=$
	FACEM	MIDWAY_TX,3,0,1,2	;S
	FACEM	8,4,7,6,5		;N
	FACEM	SQVIOLET_TX,7,3,2,6	;W
	FACEM	SQVIOLET_TX,0,4,5,1	;E
	FACEM	4,5,6,2,1		;B
	FACEM	4,7,4,0,3			;T
	dd	-1

X=20
Y=20
Z=120
O=220
tnk1b_pts\
	dd	8
	dd	X,	Y,	Z-O
	dd	X,	-Y,	Z-O
	dd	-X,	-Y,	Z-O
	dd	-X,	Y,	Z-O
	dd	X,	Y,	-Z-O
	dd	X,	-Y,	-Z-O
	dd	-X,	-Y,	-Z-O
	dd	-X,	Y,	-Z-O
tnk1b_lt=$
	FACEM	2,4,7,6,5		;N
	FACEM	SQGREY_TX,7,3,2,6	;W
	FACEM	SQGREY_TX,0,4,5,1	;E
	FACEM	010h,7,4,0,3		;T
	FACEM	8,5,6,2,1		;B
;	FACEM	6,3,0,1,2		;S
	dd	-1




;********************************
;* Enemy tank hit by shell

 SUBRP	en_tank_hitshell

	mov	esi,[ebx].D3OBJ.PRC_p
	dec	tnk_shield[esi]

	ret

 SUBEND

;********************************
;* Enemy tank hit obstacle

 SUBRP	en_tank_hitobst

	mov	eax,[ebx].D3OBJ.XV
	sub	[ebx].D3OBJ.X,eax

	mov	eax,[ebx].D3OBJ.ZV
	sub	[ebx].D3OBJ.Z,eax

	ret

 SUBEND



;********************************
;* Tank shell (Process)

	STRUCTPD
	ST_W	ens_fuel
	ST_D	ens_pdta_p	;* plyr data (Name)

 SUBRP	en_shell

	call	_3d_getobj
	jz	prc_die

	mov	[edi].D3OBJ.ID,CLSENMY+TYPTNKSHOT
	mov	[edi].D3OBJ.CLRNG,BLK5/6
	mov	[edi].D3OBJ.FLGS,FLAT_OF
	mov	[edi].D3OBJ.PRC_p,esi

	mov	eax,offset tshot_pts
	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,offset tshot_lt
	mov	[edi].D3OBJ.FACE_p,eax

	mov	ebx,[esi].PRC.DATA		;Get * spawner obj

	mov	eax,[ebx].D3OBJ.X
	mov	[edi].D3OBJ.X,eax

	mov	eax,[ebx].D3OBJ.Z
	mov	[edi].D3OBJ.Z,eax

	mov	eax,[ebx].D3OBJ.Y
	sub	eax,5*256
	mov	[edi].D3OBJ.Y,eax

	CLR	eax

	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.ZA,ax


	mov	ax,[ebx].D3OBJ.YA
	mov	[edi].D3OBJ.YA,ax
	neg	ax
	call	sinecos_get
	shl	eax,1
	shl	ebx,1
	mov	[edi].D3OBJ.XV,eax
	neg	ebx
	mov	[edi].D3OBJ.ZV,ebx

	mov	ens_fuel[esi],TSEC*6
lp:

	SLEEP	1
	dec	ens_fuel[esi]
	jg	lp


	mov	[edi].D3OBJ.ID,CLSDEAD

	CREATE	0,fragment_obj		;>Fragment
	mov	frag_srcobj_p[ebx],edi
	mov	frag_cnt[ebx],8

	CLR	eax
	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.ZV,eax
	SLEEP	3


	call	_3d_freeobj
	DIE


	.data
X=BLK5/6
Y=BLK5/6
Z=0
tshot_pts\
	dd	4
	dd	-X	,Y	,Z
	dd	X	,Y	,Z
	dd	X	,-Y	,Z
	dd	-X	,-Y	,Z
tshot_lt=$
	FACEM	ENSHOT_TX,0,1,2,3	;S
;	FACEM	ENSHOT_TX,1,0,3,2	;N
	dd	-1
	.code

 SUBEND


;********************************
;* Called by collision code

 SUBRP	en_shell_hit

	mov	esi,[ebx].D3OBJ.PRC_p
	mov	ens_fuel[esi],0

	ret

 SUBEND


;********************************
;* Enemy bullet (Process)

	STRUCTPD
	ST_W	enb_fuel
	ST_D	enb_pdta_p		;* plyr data (Name)

 SUBRP	en_bullet

	call	_3d_getobj
	jz	prc_die

	mov	[edi].D3OBJ.PRC_p,esi

	mov	[edi].D3OBJ.FLGS,FLAT_OF

	mov	[edi].D3OBJ.ID,CLSENMY+TYPENBUL
	mov	[edi].D3OBJ.CLRNG,BLK5/20

	mov	eax,offset pbul_pts
	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,offset pbul_lt
	mov	[edi].D3OBJ.FACE_p,eax


	mov	ebx,[esi].PRC.DATA		;Get * spawner obj

	mov	eax,[ebx].D3OBJ.X
	mov	[edi].D3OBJ.X,eax

	mov	eax,[ebx].D3OBJ.Z
	mov	[edi].D3OBJ.Z,eax

	mov	eax,[ebx].D3OBJ.Y
	sub	eax,5*256
	mov	[edi].D3OBJ.Y,eax

	CLR	eax

	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.ZA,ax


	mov	ax,[ebx].D3OBJ.YA
	mov	[edi].D3OBJ.YA,ax
	neg	ax
	call	sinecos_get
	shl	eax,1
	shl	ebx,1
	mov	[edi].D3OBJ.XV,eax
	neg	ebx
	mov	[edi].D3OBJ.ZV,ebx

	mov	enb_fuel[esi],10
lp:

	SLEEP	1
	dec	enb_fuel[esi]
	jg	lp
	jz	x			;Out of time?


	mov	[edi].D3OBJ.ID,CLSDEAD

	CREATE	0,fragment_obj		;>Fragment (We hit something)
	mov	frag_srcobj_p[ebx],edi
	mov	frag_cnt[ebx],3

	CLR	eax
	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.ZV,eax
	SLEEP	3


x:	call	_3d_freeobj
	DIE


 SUBEND


;********************************
;* Called by collision code

 SUBRP	en_bullet_hit

	mov	esi,[ebx].D3OBJ.PRC_p
	mov	enb_fuel[esi],-1		;Make it frag

	ret

 SUBEND



;********************************
;* Enemy missile (Process)

	STRUCTPD
	ST_W	enm_fuel	;
	ST_D	enm_pdta_p	;* plyr data (Name)
	ST_D	enm_tnk_p	;* plyr tank proc
	ST_W	enm_dir		;Dir 10:6

 SUBRP	en_msl

	call	_3d_getobj
	jz	prc_die

	mov	[edi].D3OBJ.ID,CLSENMY+TYPENMSL
	mov	[edi].D3OBJ.CLRNG,BLK5/10
	mov	[edi].D3OBJ.PRC_p,esi

	mov	eax,offset pmsl_pts
	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,offset pmsl_lt
	mov	[edi].D3OBJ.FACE_p,eax

	mov	ebx,[esi].PRC.DATA		;Get * spawner obj

	mov	eax,[ebx].D3OBJ.X
	mov	[edi].D3OBJ.X,eax

	mov	eax,[ebx].D3OBJ.Z
	mov	[edi].D3OBJ.Z,eax

	mov	eax,[ebx].D3OBJ.Y
	add	eax,180*256
	mov	[edi].D3OBJ.Y,eax
						;>Find pos offset
	mov	ax,[ebx].D3OBJ.YA
	neg	ax
	mov	enm_dir[esi],ax
	neg	ax
	add	ah,20h
	call	sinecos_get
	sar	eax,2
	sar	ebx,2
	neg	ebx

	add	[edi].D3OBJ.X,eax
	add	[edi].D3OBJ.Z,ebx

	CLR	eax

	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.ZA,ax

	mov	enm_fuel[esi],100
lp:
	mov	ebx,enm_tnk_p[esi]
	movsx	ax,ntnk_mslt[ebx]
	shl	ax,9
	add	enm_dir[esi],ax

	mov	ax,enm_dir[esi]
	neg	ax
	mov	[edi].D3OBJ.YA,ax
	neg	ax
	call	sinecos_get

	mov	[edi].D3OBJ.XV,eax
	neg	ebx
	mov	[edi].D3OBJ.ZV,ebx

	SLEEP	1
	dec	enm_fuel[esi]
	jg	lp
	jz	x			;Out of time?


	mov	[edi].D3OBJ.ID,CLSDEAD

	CREATE	0,fragment_obj		;>Fragment (We hit something)
	mov	frag_srcobj_p[ebx],edi
	mov	frag_cnt[ebx],7

	CLR	eax
	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.ZV,eax
	SLEEP	3



x:	call	_3d_freeobj
	DIE

 SUBEND

;********************************
;* Called by collision code

 SUBRP	en_msl_hit

	mov	esi,[ebx].D3OBJ.PRC_p
	mov	enm_fuel[esi],-1		;Make it frag

	ret

 SUBEND


;********************************
;* Train car (Process)

;	STRUCTPD
;	ST_W	trnc_fuel
;
; SUBRP	en_traincar
;
;	call	_3d_getobj
;	jz	prc_die
;
;	mov	[edi].D3OBJ.ID,CLSENMY+TYPTRAIN
;	mov	[edi].D3OBJ.CLRNG,BLK5
;;	mov	[edi].D3OBJ.FLGS,FLAT_OF
;	mov	[edi].D3OBJ.PRC_p,esi
;
;	mov	eax,offset train_pts
;	mov	[edi].D3OBJ.PTS_p,eax
;	mov	eax,offset train_lt
;	mov	[edi].D3OBJ.FACE_p,eax
;
;
;	mov	[edi].D3OBJ.X,-ARENAXSZ
;
;	mov	[edi].D3OBJ.Z,-ARENAZSZ-1000*256
;
;	mov	eax,210*256
;	mov	[edi].D3OBJ.Y,eax
;
;	CLR	eax
;
;	mov	[edi].D3OBJ.YV,eax
;	mov	[edi].D3OBJ.XA,ax
;	mov	[edi].D3OBJ.ZA,ax
;
;
;	mov	ax,8000h
;	mov	[edi].D3OBJ.YA,ax
;	neg	ax
;	call	sinecos_get
;	sar	eax,2
;	sar	ebx,2
;	mov	[edi].D3OBJ.XV,eax
;	neg	ebx
;	mov	[edi].D3OBJ.ZV,ebx
;
;	mov	trnc_fuel[esi],TSEC*70
;lp:
;	SLEEP	1
;	dec	trnc_fuel[esi]
;	jz	done
;	jg	lp
;
;
;	CREATE	0,fragment_obj		;>Fragment
;	mov	frag_srcobj_p[ebx],edi
;	mov	frag_cnt[ebx],12
;
;	CREATE	0,explode_obj		;>Explode
;	mov	xpld_srcobj_p[ebx],edi
;
;	SLEEP	TSEC*2
;
;done:
;	call	_3d_freeobj
;	DIE
;
; SUBEND
;
;	.data
;X=150
;Y=150
;Z=300
;TX=100h
;train_pts\
;	dd	24
;	dd	X,	Y,	Z
;	dd	X,	-Y,	Z
;	dd	-X,	-Y,	Z
;	dd	-X,	Y,	Z
;	dd	X,	Y,	-Z
;	dd	X,	-Y,	-Z
;	dd	-X,	-Y,	-Z
;	dd	-X,	Y,	-Z
;
;Z=-260
;	dd	-X,	-Y,	Z-30
;	dd	-X,	-Y,	Z+30
;	dd	-X,	-Y-60,	Z+30
;	dd	-X,	-Y-60,	Z-30
;Z=-180
;	dd	-X,	-Y,	Z-30
;	dd	-X,	-Y,	Z+30
;	dd	-X,	-Y-60,	Z+30
;	dd	-X,	-Y-60,	Z-30
;Z=180
;	dd	-X,	-Y,	Z-30
;	dd	-X,	-Y,	Z+30
;	dd	-X,	-Y-60,	Z+30
;	dd	-X,	-Y-60,	Z-30
;Z=260
;	dd	-X,	-Y,	Z-30
;	dd	-X,	-Y,	Z+30
;	dd	-X,	-Y-60,	Z+30
;	dd	-X,	-Y-60,	Z-30
;train_lt=$
;	FACEM	WOOD_TX,3,0,1,2		;South
;	FACEM	WOOD_TX,4,7,6,5		;North
;	FACEM	WOOD_TX,7,3,2,6		;West
;	FACEM	WOOD_TX,0,4,5,1		;East
;	FACEM	4,5,6,2,1		;Bot
;	FACEM	4,7,4,0,3		;Top
;	FACEM	3,8,9,10,11		;NW wheel
;	FACEM	3,12,13,14,15		;NW wheel
;	FACEM	3,16,17,18,19		;SW wheel
;	FACEM	3,20,21,22,23		;SW wheel
;	dd	-1


;********************************
;* Called by collision code

 SUBRP	en_train_hit

;	mov	esi,[ebx].D3OBJ.PRC_p
;	mov	trnc_fuel[esi],-1

	ret

 SUBEND



;********************************
;* Network tank (Process)

	STRUCTPD
	ST_W	ntnk_shield
	ST_W	ntnk_act	;Action flags from net player
	ST_D	ntnk_tur_p	;* turret obj
	ST_D	ntnk_brl_p	;* barrel obj
	ST_W	ntnk_xpldcnt
	ST_D	ntnk_pdta_p	;* plyr data (Name)
	ST_B	ntnk_logout	;!0=User logged out
	ST_B	ntnk_mslt	;Missile turn (-1 to 1)
	ST_B	ntnk_kname_s	;* killers name

 SUBRP	net_tnk


	mov	ebx,ntnk_pdta_p[esi]
	call	cpanel_prttxt

	mov	ebx,offset joinin_s
	call	cpanel_prttxtatend


	mov	ntnk_logout[esi],0


	call	_3d_getobj		;>Init turret
	jz	prc_die			;No objs?

	mov	ntnk_tur_p[esi],edi

	mov	[edi].D3OBJ.ID,CLSDEAD
	mov	[edi].D3OBJ.CLRNG,BLK5
	mov	[edi].D3OBJ.PRC_p,esi

	mov	eax,offset tnk1t_pts
	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,offset tnk1t_lt
	mov	[edi].D3OBJ.FACE_p,eax

	mov	eax,195*256
	mov	[edi].D3OBJ.Y,eax

	CLR	eax
	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.ZV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.YA,ax
	mov	[edi].D3OBJ.ZA,ax


	call	_3d_getobj		;>Init barrel
	jz	frtur			;No objs?

	mov	ntnk_brl_p[esi],edi

	mov	[edi].D3OBJ.ID,CLSDEAD
	mov	[edi].D3OBJ.CLRNG,BLK5
	mov	[edi].D3OBJ.PRC_p,esi

	mov	eax,offset tnk1b_pts
	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,offset tnk1b_lt
	mov	[edi].D3OBJ.FACE_p,eax

	mov	eax,180*256
	mov	[edi].D3OBJ.Y,eax

	CLR	eax
	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.ZV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.YA,ax
	mov	[edi].D3OBJ.ZA,ax


	call	_3d_getobj
	jz	frbrl			;No objs?

	mov	[edi].D3OBJ.CLRNG,BLK5
	mov	[edi].D3OBJ.PRC_p,esi

	mov	eax,offset tnk1ch_pts
	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,offset tnk1ch_lt
	mov	[edi].D3OBJ.FACE_p,eax

	CLR	eax
	mov	[edi].D3OBJ.X,eax
	mov	[edi].D3OBJ.Z,eax

	mov	eax,80*256
	mov	[edi].D3OBJ.Y,eax

	CLR	eax
	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.ZV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.YA,ax
	mov	[edi].D3OBJ.ZA,ax

	mov	ntnk_shield[esi],5

strtlp:
	mov	[edi].D3OBJ.ID,CLSNEUT+TYPNETTNK


lp:
	test	ntnk_act[esi],1
	jz	@F

	CREATE	0,en_shell		;>Fire shell
	mov	eax,ntnk_tur_p[esi]
	mov	[ebx].PRC.DATA,eax
	mov	eax,ntnk_pdta_p[esi]
	mov	ens_pdta_p[ebx],eax
@@:

	test	ntnk_act[esi],2
	jz	@F

	CREATE	0,en_bullet		;>Fire bullet
	mov	eax,ntnk_tur_p[esi]
	mov	[ebx].PRC.DATA,eax
	mov	eax,ntnk_pdta_p[esi]
	mov	enb_pdta_p[ebx],eax
@@:
	test	ntnk_act[esi],4
	jz	@F

	CREATE	0,en_msl		;>Fire missile
	mov	eax,ntnk_tur_p[esi]
	mov	[ebx].PRC.DATA,eax
	mov	eax,ntnk_pdta_p[esi]
	mov	enm_pdta_p[ebx],eax
	mov	enm_tnk_p[ebx],esi
@@:

	push	esi


	mov	esi,ntnk_tur_p[esi]	;>Position turret

	mov	ax,[esi].D3OBJ.YA
	push	ax
	neg	ax
	call	sinecos_get
	sar	eax,4
	sar	ebx,4
	neg	ebx

	add	eax,[edi].D3OBJ.X
	mov	[esi].D3OBJ.X,eax

	add	ebx,[edi].D3OBJ.Z
	mov	[esi].D3OBJ.Z,ebx

	pop	ax			;Get turret angle

	pop	esi
	push	esi

	mov	esi,ntnk_brl_p[esi]	;>Position barrel

	mov	[esi].D3OBJ.YA,ax
	neg	ax
	call	sinecos_get
	sar	eax,3
	sar	ebx,3
	neg	ebx

	add	eax,[edi].D3OBJ.X
	mov	[esi].D3OBJ.X,eax

	add	ebx,[edi].D3OBJ.Z
	mov	[esi].D3OBJ.Z,ebx

	mov	eax,[edi].D3OBJ.Y
	add	eax,100*256
	mov	[esi].D3OBJ.Y,eax

	pop	esi


	mov	ntnk_act[esi],0

	SLEEP	1
	cmp	ntnk_shield[esi],0
	jge	lp

	cmp	ntnk_logout[esi],0
	jne	logo			;Logged out?


					;>Dead
	mov	ebx,ntnk_pdta_p[esi]
	call	cpanel_prttxt

	mov	ebx,offset killby_s
	call	cpanel_prttxtatend

	lea	ebx,ntnk_kname_s[esi]

	push	edi
	push	esi

	mov	esi,ebx			;>Compare names
	mov	edi,offset plname_s
nmlp:	mov	al,[edi]
	cmp	[esi],al
	jne	@F			;Not me?
	inc	esi
	inc	edi
	TST	al
	jnz	nmlp

	mov	ebx,offset you_s
	cmp	plshield,0
	jl	@F			;Your dead?

	add	plnummsl,2

	add	plshield,200
	cmp	plshield,SHLDMAX
	jle	@F
	mov	plshield,SHLDMAX

@@:	call	cpanel_prttxtatend
	pop	esi
	pop	edi


	mov	ax,40000
	mov	bx,-15000
	mov	cx,2
	call	snd_start


	CREATE	0,fragment_obj		;>Fragment
	mov	frag_srcobj_p[ebx],edi
	mov	frag_cnt[ebx],15

	CREATE	0,explode_obj		;>Explode
	mov	xpld_srcobj_p[ebx],edi


	mov	[edi].D3OBJ.ID,CLSDEAD	;>Spin
	mov	ntnk_xpldcnt[esi],30

@@:	SLEEP	1
	dec	ntnk_xpldcnt[esi]
	jg	@B



@@:	SLEEP	1
	cmp	ntnk_shield[esi],0
	jge	strtlp			;Alive again?

	cmp	ntnk_logout[esi],0
	je	@B			;On net?


logo:
	call	_3d_freeobj

frbrl:	mov	edi,ntnk_brl_p[esi]
	call	_3d_freeobj

frtur:	mov	edi,ntnk_tur_p[esi]
	call	_3d_freeobj

	DIE

 SUBEND


;********************************

 SUBRP	net_tank_hit

;	mov	esi,[ebx].D3OBJ.PRC_p
;	dec	ntnk_shield[esi]

	ret

 SUBEND





;********************************
;* Make fragments (Process)

	STRUCTPD
	ST_D	frag_srcobj_p	;*Obj for source of frags (Set by creator)
	ST_W	frag_cnt	;# frags (Set by creator)

 SUBRP	fragment_obj


lp:	CREATE	0,fragment_one
	mov	eax,frag_srcobj_p[esi]
	mov	[ebx].PRC.DATA,eax

;	SLEEP	1
	dec	frag_cnt[esi]
	jg	lp


	DIE
 SUBEND

;********************************
;* Fragment piece (Process)

 SUBRP	fragment_one

	call	_3d_getobj
	jz	prc_die

	mov	[edi].D3OBJ.ID,CLSDEAD

	mov	eax,offset frag_pts
	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,offset frag_lt
	mov	[edi].D3OBJ.FACE_p,eax

	mov	ebx,[esi].PRC.DATA

	mov	eax,[ebx].D3OBJ.X
	mov	[edi].D3OBJ.X,eax

	mov	eax,[ebx].D3OBJ.Z
	mov	[edi].D3OBJ.Z,eax

	mov	eax,[ebx].D3OBJ.Y
	add	eax,100*256
	mov	[edi].D3OBJ.Y,eax

	CLR	eax

	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.ZA,ax


	call	rnd
	mov	[edi].D3OBJ.YA,ax
	call	sinecos_get
	sar	eax,2
	sar	ebx,2
	mov	[edi].D3OBJ.XV,eax
	neg	ebx
	mov	[edi].D3OBJ.ZV,ebx

	call	rnd
	and	ah,3fh
	add	ah,3
	movzx	eax,ax
	mov	[edi].D3OBJ.YV,eax		;3 to 66*256

	mov	[esi].PRC.DATA,TSEC*2+5
lp:
	call	rnd
	and	ah,1fh
	add	[edi].D3OBJ.YA,ax

	sub	[edi].D3OBJ.YV,3*256

	SLEEP	1
	cmp	WPTR 2[edi].D3OBJ.Y,0
	jg	lp


	call	_3d_freeobj
	DIE

	.data
X=15
Y=15
Z=0
frag_pts\
	dd	3
	dd	0	,Y	,Z
	dd	X	,-Y	,Z
	dd	-X	,-Y	,Z
frag_lt=$
	FACEM	0ah,0,1,2,2	;S
	FACEM	014h,1,0,2,2	;N
	dd	-1
	.code

 SUBEND


;********************************
;* Make explosion (Process)

	STRUCTPD
	ST_D	xpld_srcobj_p	;*Obj for source of frags (Set by creator)
	ST_W	xpld_cnt

 SUBRP	explode_obj

	mov	xpld_cnt[esi],5

lp:	CREATE	0,explode_one
	mov	eax,xpld_srcobj_p[esi]
	mov	[ebx].PRC.DATA,eax

	SLEEP	4
	dec	xpld_cnt[esi]
	jg	lp


	DIE
 SUBEND

;********************************
;* Explosion piece (Process)

 SUBRP	explode_one

	call	_3d_getobj
	jz	prc_die

	mov	[edi].D3OBJ.ID,CLSDEAD
	mov	[edi].D3OBJ.FLGS,FLAT_OF

	mov	eax,offset xpld_pts
	mov	[edi].D3OBJ.PTS_p,eax
	mov	eax,offset xpld_lt
	mov	[edi].D3OBJ.FACE_p,eax

	mov	ebx,[esi].PRC.DATA

	mov	eax,[ebx].D3OBJ.X
	mov	[edi].D3OBJ.X,eax

	mov	eax,[ebx].D3OBJ.Z
	mov	[edi].D3OBJ.Z,eax

	mov	eax,[ebx].D3OBJ.Y
	add	eax,100*256
	mov	[edi].D3OBJ.Y,eax

	CLR	eax

	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.ZA,ax


	call	rnd
	mov	[edi].D3OBJ.YA,ax
	call	sinecos_get
	sar	eax,4
	sar	ebx,4
	mov	[edi].D3OBJ.XV,eax
	neg	ebx
	mov	[edi].D3OBJ.ZV,ebx

	mov	[edi].D3OBJ.YV,10*256

	mov	[esi].PRC.DATA,TSEC*2
lp:
	add	[edi].D3OBJ.YA,20*256

;	mov	eax,[edi].D3OBJ.YV
;	add	[edi].D3OBJ.Y,eax
;	sub	[edi].D3OBJ.YV,4*256

	SLEEP	1
	dec	[esi].PRC.DATA
	jg	lp

	call	_3d_freeobj
	DIE

	.data

X=BLK10/2
Y=BLK10/2
Z=0
xpld_pts\
	dd	4
	dd	-X	,Y	,Z
	dd	X	,Y	,Z
	dd	X	,-Y	,Z
	dd	-X	,-Y	,Z
xpld_lt=$
	FACEM	XPLD1_TX,0,1,2,3	;S
	dd	-1

	.code

 SUBEND



;****************************************************************


;********************************
;* Load textures

 SUBRP	_3d_loadimgs

	mov	ebx,offset txtr_s
	mov	edi,offset txtrimg_t

	CLR	eax
	mov	temp,ax

txlp:
	lea	esi,img_p
	jmp	ihlp
ihlp:
	push	ebx
	push	esi
	lea	esi,[esi].IMG.N_s
mlp:	mov	al,[ebx]
	mov	ah,[esi]
	TST	al
	jz	@F			;End?
	inc	ebx
	inc	esi
	cmp	al,ah
	je	mlp			;Same?
@@:	pop	esi
	pop	ebx
	cmp	al,ah
	je	match
ihnxt:
	mov	esi,[esi]
	TST	esi
	jnz	ihlp

	CLR	esi

match:
	mov	[edi],esi		;Save in table
	add	edi,4


@@:	mov	al,[ebx]		;>Find end of current name_s
	inc	ebx
	TST	al
	jg	@B

	cmp	BPTR [ebx],0
	jge	txlp			;!End?

	ret

 SUBEND

	.data
INAME	macro	N,L
	db	N,0
L	equ	SOFF+100h
SOFF=SOFF+1
	endm


SOFF=0
txtr_s	equ	this byte
	INAME	"MIDWAY"	,MIDWAY_TX
	INAME	"tnkp1n"	,TNKN_TX
	INAME	"tnkp1s"	,TNKS_TX
	INAME	"tnkp1e"	,TNKE_TX
	INAME	"tnkp1e"	,TNKW_TX
	INAME	"fire1"		,ENSHOT_TX
	INAME	"CLD5"		,PLSHOT_TX
	INAME	"tree1"		,TREE_TX
	INAME	"XPLD1"		,XPLD1_TX
	INAME	"mboxtexv"	,SQVIOLET_TX
	INAME	"mboxtexg"	,SQGREY_TX
	INAME	"s_platech"	,CROSSH_TX
	INAME	"GNFR1"		,YELBALL_TX
	INAME	"WOODCORT"	,WOOD_TX
	db	-1
	.code



;********************************
;* Get a object from 3D free list
;*>EDI = * object or 0 (Z)
;* Trashes out

 SUBRP	obj_get

	PUSHMR	ebx,esi

	mov	edi,d3free_p
	TST	edi
	jz	x			;None free?
	mov	ebx,[edi]		;Unlink
	mov	d3free_p,ebx

	lea	esi,world_p-D3OBJ.WNXT_p
lp:
	mov	ebx,esi
	mov	esi,[esi].D3OBJ.WNXT_p
	TST	esi
	jnz	lp			;!End?

	mov	[ebx].D3OBJ.WNXT_p,edi	;* last to me
	mov	[edi].D3OBJ.WNXT_p,esi	;0

	CLR	ebx
	mov	[edi].D3OBJ.XV,ebx
	mov	[edi].D3OBJ.YV,ebx
	mov	[edi].D3OBJ.ZV,ebx
	mov	[edi].D3OBJ.MDL_p,ebx
	mov	[edi].D3OBJ.FLGS,SV_OF

	TST	edi
x:
	POPMR
	ret

 SUBEND

;********************************
;* Get a object from 3D free list
;* >EDI=* object or 0 (Z)
;* Trashes out

 SUBRP	_3d_getobj

	push	ebx

	mov	edi,d3free_p
	TST	edi
	jz	x			;None free?
	mov	ebx,[edi]		;Unlink
	mov	d3free_p,ebx

	mov	ebx,world_p
	mov	world_p,edi
	mov	[edi].D3OBJ.WNXT_p,ebx

	mov	[edi].D3OBJ.FLGS,0
	mov	[edi].D3OBJ.MDL_p,0

	TST	edi

x:	pop	ebx
	ret

 SUBEND

;********************************
;* Get a object from 3D free list and clr
;* >EDI=* object or 0 (Z)
;* Trashes EAX

 SUBRP	_3d_getobj0

	call	_3d_getobj
	jz	x

	CLR	eax
	mov	[edi].D3OBJ.Y,eax
	mov	[edi].D3OBJ.XV,eax
	mov	[edi].D3OBJ.YV,eax
	mov	[edi].D3OBJ.ZV,eax
	mov	[edi].D3OBJ.XA,ax
	mov	[edi].D3OBJ.YA,ax
	mov	[edi].D3OBJ.ZA,ax
	inc	al			;Clr Z

x:	ret

 SUBEND

;********************************
;* Free an object
;* EDI=* object
;* Trashes none

 SUBRP	_3d_freeobj

	push	eax
	push	ebx


	mov	ebx,world_p
	TST	ebx
	jz	free
	cmp	ebx,edi
	jne	lp

	mov	ebx,[edi].D3OBJ.WNXT_p		;Unlink from world
	mov	world_p,ebx

	jmp	free

lp:	mov	eax,ebx
	mov	ebx,[ebx].D3OBJ.WNXT_p
	TST	ebx
	jz	free
	cmp	ebx,edi
	jne	lp

	mov	ebx,[edi].D3OBJ.WNXT_p		;Unlink from world
	mov	[eax].D3OBJ.WNXT_p,ebx

free:

	mov	eax,d3free_p			;Add to free list
	mov	[edi],eax
	mov	d3free_p,edi


x:	pop	ebx
	pop	eax
	ret

 SUBEND



;********************************
;* Build 3D view
;* Trashes all non seg

 SUBRP	_3d_build

	call	_3d_buildvislist


;	mov	si,d3world_t
;	mov	d3vis_p,si
;	mov	di,d3world_t+2
;	mov	[si],di
;	CLR	eax
;	mov	[di],ax

	call	_3d_xformrelself

	call	_3d_xformrelview

					;>Scale for display
	mov	esi,offset d3vis_p
	jmp	@F
sxylp:	push	esi
	mov	esi,[esi].D3OBJ.XPTS_p
	call	_3d_scalexy
	pop	esi
@@:	mov	esi,[esi]
	TST	esi
	jnz	sxylp


	ret

 SUBEND



;*******************************
;* Check distance and visability of objs center point
;* Adds to d3vis_p if visable
;* Trashes all non seg

;x=x*cos(az)-y*sin(az)
;y=x*sin(az)+y*cos(az)

;y=y*cos(ax)-z*sin(ax)
;z=y*sin(ax)+z*cos(ax)

;z=z*cos(ay)-x*sin(ay)
;x=z*sin(ay)+x*cos(ay)


 SUBRP	_3d_buildvislist


	mov	ax,viewza
	call	sinecos_get
	mov	sinaz,eax
	mov	cosaz,ebx

	mov	ax,viewxa
	call	sinecos_get
	mov	sinax,eax
	mov	cosax,ebx

	mov	ax,viewya
	call	sinecos_get
	mov	sinay,eax
	mov	cosay,ebx


	mov	esi,world_p
	mov	edi,offset d3xptmem
	mov	d3vis_p,0		;Null end

	cld
	jmp	strt

lp:

	mov	eax,[esi].D3OBJ.X
	sub	eax,viewx		;X offset from view (24:8)
	cmp	eax,600000h
	jg	nxt
	cmp	eax,-600000h
	jl	nxt
	mov	xrel,eax

	mov	eax,[esi].D3OBJ.Z
	sub	eax,viewz
	cmp	eax,600000h
	jg	nxt
	cmp	eax,-600000h
	jl	nxt
	mov	zrel,eax

	mov	eax,[esi].D3OBJ.Y
	sub	eax,viewy
	cmp	eax,600000h
	jg	nxt
	cmp	eax,-600000h
	jl	nxt

	sar	eax,8			;Remove fractions
	mov	yrel,eax

	sar	xrel,8
	sar	zrel,8


	mov	ecx,xrel
	imul	ecx,cosaz		;Cos*X

	mov	eax,yrel
	imul	eax,sinaz		;Sin*Y
	sub	ecx,eax
	sar	ecx,16
	mov	xd,ecx			;X about Z

	mov	ecx,xrel
	imul	ecx,sinaz		;Sin*X

	mov	eax,yrel
	imul	eax,cosaz		;Cos*Y
	add	ecx,eax
	sar	ecx,16			;Y about Z


	push	ecx
	imul	ecx,cosax		;Cos*Y

	mov	eax,zrel
	imul	eax,sinax		;Sin*Z
	sub	ecx,eax
	sar	ecx,16
	mov	yd,ecx			;Y about X

	pop	ecx
	imul	ecx,sinax		;Sin*Y

	mov	eax,zrel
	imul	eax,cosax		;Cos*Z
	add	ecx,eax
	sar	ecx,16			;Z about X


	push	ecx
	imul	ecx,cosay		;Cos*Z

	mov	eax,xd
	imul	eax,sinay		;Sin*X
	sub	eax,ecx
	neg	eax
	pop	ecx
	sar	eax,16
	cmp	ax,BLK10*2
	jg	nxt			;Z behind view?

	cmp	eax,viewdist
	jl	nxt

	test	[esi].D3OBJ.FLGS,GND_OF
	jz	@F			;!Gnd mode?
	mov	ax,-7fffh
@@:
	mov	[esi].D3OBJ.ZTEMP,ax	;Z about Y

	imul	eax,sinay		;Sin*Z

	mov	ecx,xd
	imul	ecx,cosay		;Cos*X
	add	eax,ecx
	sar	eax,16			;X about Y
	mov	xd,eax


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	ebx,MAPBSZ

	mov	eax,[esi].D3OBJ.X
	cdq
	idiv	ebx
	sar	eax,8
	add	eax,MAPW/2
	cmp	eax,MAPW
	jae	merr			;Out of range?
	mov	ecx,eax

	mov	eax,[esi].D3OBJ.Z
	cdq
	idiv	ebx
	sar	eax,8
	add	eax,MAPH/2
	cmp	eax,MAPH
	jae	merr			;Out of range?
	imul	eax,MAPW*4

	shl	ecx,2			;*4
	add	ecx,eax

	mov	ebx,map_t[ecx]
	and	ebx,M_MAPIL
	shr	ebx,S_MAPIL


	movsx	eax,[esi].D3OBJ.ZTEMP
	sar	eax,9			;/512
	jl	@F
	neg	eax
@@:
	add	eax,15
	jg	@F
	CLR	eax
@@:
	cmp	eax,15
	jl	@F
	mov	eax,15
@@:
	add	eax,ebx
	mov	[esi].D3OBJ.ILTMP,ax
merr:

	mov	dx,[esi].D3OBJ.ZTEMP

	mov	[esi].D3OBJ.XPTS_p,edi
	add	edi,4
	mov	ebx,[esi].D3OBJ.PTS_p
	mov	eax,[ebx]		;#pts
	shl	eax,2			;*4
	add	edi,eax
	add	eax,eax			;*8
	add	edi,eax			;EDI += 4+(#pts*12)

	push	edi

	mov	ebx,offset d3vis_p	;>Find spot in list based on Z
zlp:	mov	edi,ebx
	mov	ebx,[ebx]		;Next
	TST	ebx
	jz	zend
	cmp	dx,[ebx].D3OBJ.ZTEMP
	jg	zlp			;Higher?
zend:
	mov	[edi],esi		;Point last to me
	mov	[esi],ebx		;Point me to next

	pop	edi

nxt:
	mov	esi,[esi].D3OBJ.WNXT_p
strt:
	TST	esi
	jnz	lp


	ret

 SUBEND



;*******************************
;* Check distance and visability of objs center point for map
;* Adds to d3vis_p if visable
;* Trashes all non seg

 SUBRP	_3d_buildmaplist

	mov	esi,world_p
	mov	edi,offset d3xptmem
	mov	d3vis_p,0		;Null end

	cld
	jmp	strt

lp:
	mov	eax,[esi].D3OBJ.X
	sub	eax,viewx		;X offset from view (24:8)
	cmp	eax,600000h
	jg	nxt
	cmp	eax,-600000h
	jl	nxt
;	mov	xrel,eax

	mov	eax,[esi].D3OBJ.Z
	sub	eax,viewz
	cmp	eax,600000h
	jg	nxt
	cmp	eax,-600000h
	jl	nxt
;	mov	zrel,eax

	mov	eax,[esi].D3OBJ.Y
	sub	eax,viewy
	cmp	eax,600000h
	jg	nxt
	cmp	eax,-600000h
	jl	nxt

	sar	eax,8			;Remove fractions
;	mov	yrel,eax

;	sar	xrel,8
;	sar	zrel,8


	test	[esi].D3OBJ.FLGS,GND_OF
	jz	@F			;!Gnd mode?
	mov	ax,-7fffh
@@:
	mov	[esi].D3OBJ.ZTEMP,ax	;Y
	mov	dx,ax

	mov	[esi].D3OBJ.XPTS_p,edi
	add	edi,4
	mov	ebx,[esi].D3OBJ.PTS_p
	mov	eax,[ebx]		;#pts
	shl	eax,2			;*4
	add	edi,eax
	add	eax,eax			;*8
	add	edi,eax			;EDI += 4+(#pts*12)

	push	edi

	mov	ebx,offset d3vis_p	;>Find spot in list based on Y
ylp:	mov	edi,ebx
	mov	ebx,[ebx]		;Next
	TST	ebx
	jz	yend
	cmp	dx,[ebx].D3OBJ.ZTEMP
	jg	ylp			;Higher?
yend:
	mov	[edi],esi		;Point last to me
	mov	[esi],ebx		;Point me to next

	pop	edi

nxt:
	mov	esi,[esi].D3OBJ.WNXT_p
strt:
	TST	esi
	jnz	lp


	ret

 SUBEND



;*******************************
;* Xform objects on visable list relative to self
;* Trashes all non seg

 SUBRP	_3d_xformrelself

	mov	ebx,offset d3vis_p

	cld
	jmp	strt

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

lp:
	push	ebx
	mov	esi,ebx

	mov	ax,[esi].D3OBJ.ZA
	call	sinecos_get
	mov	sinaz,eax
	mov	cosaz,ebx

	mov	ax,[esi].D3OBJ.XA
	call	sinecos_get
	mov	sinax,eax
	mov	cosax,ebx

	mov	ax,[esi].D3OBJ.YA
	test	[esi].D3OBJ.FLGS,FLAT_OF
	jz	@F			;!Flat mode?
	mov	ax,viewya
	neg	ax
@@:	call	sinecos_get
	mov	sinay,eax
	mov	cosay,ebx

	mov	edi,[esi].D3OBJ.XPTS_p
	mov	esi,[esi].D3OBJ.PTS_p
	lodsd				;Get # pts
	stosd				;Save # pts
	mov	ecx,eax

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
vlp:
	push	ecx
					;x=x*cos(az)-y*sin(az)
					;y=x*sin(az)+y*cos(az)
	lodsd				;Get X
	mov	edx,eax
	imul	eax,cosaz		;Cos*X
	mov	ecx,eax

	lodsd				;Get Y
	mov	ebx,eax
	imul	eax,sinaz		;Sin*Y
	sub	ecx,eax
	sar	ecx,16			;X about Z
	mov	x2d,ecx

	imul	edx,sinaz		;Sin*X
	mov	ecx,edx

	mov	eax,ebx
	imul	eax,cosaz		;Cos*Y
	add	ecx,eax
	sar	ecx,16			;Y about Z
;	mov	y2d,ecx

					;y=y*cos(ax)-z*sin(ax)
					;z=y*sin(ax)+z*cos(ax)
	push	ecx
	imul	ecx,cosax		;Cos*Y

	lodsd				;Get Z
	mov	ebx,eax
	imul	eax,sinax		;Sin*Z
	sub	ecx,eax
	sar	ecx,16			;Y about X
;	mov	y2d,ecx
	mov	[edi].XYZ.Y,ecx


	pop	ecx
	imul	ecx,sinax		;Sin*Y

	imul	ebx,cosax		;Cos*Z
	add	ecx,ebx
	sar	ecx,16			;Z about X

					;z=z*cos(ay)-x*sin(ay)
					;x=z*sin(ay)+x*cos(ay)
	mov	ebx,ecx
	imul	ecx,cosay		;Cos*Z

	mov	eax,x2d
	imul	eax,sinay		;Sin*X
	sub	eax,ecx
	neg	eax
	sar	eax,16			;Z about Y
;	mov	z2d,eax
	mov	[edi].XYZ.Z,eax

	imul	ebx,sinay		;Sin*Z

	mov	ecx,x2d
	imul	ecx,cosay		;Cos*X
	add	ebx,ecx
	sar	ebx,16			;X about Y
	mov	[edi],ebx


	pop	ecx
	add	edi,4*3

	dec	ecx
	jg	vlp

	pop	ebx
strt:	mov	ebx,[ebx]
	TST	ebx
	jnz	lp


	ret

 SUBEND


;*******************************
;* Xform objects on visable list relative to view point
;* Trashes all non seg

 SUBRP	_3d_xformrelview


	mov	ax,viewza
	call	sinecos_get
	mov	sinaz,eax
	mov	cosaz,ebx

	mov	ax,viewxa
	call	sinecos_get
	mov	sinax,eax
	mov	cosax,ebx

	mov	ax,viewya
	call	sinecos_get
	mov	sinay,eax
	mov	cosay,ebx


	mov	ebx,offset d3vis_p

	cld
	jmp	strt

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
lp:
	push	ebx

	mov	eax,[ebx].D3OBJ.X
	sub	eax,viewx		;X offset from view (24:8)
	sar	eax,8
	mov	xd,eax

	mov	eax,[ebx].D3OBJ.Y
	sub	eax,viewy
	sar	eax,8
	mov	yd,eax

	mov	eax,[ebx].D3OBJ.Z
	sub	eax,viewz
	sar	eax,8
	mov	zd,eax

	mov	esi,[ebx].D3OBJ.XPTS_p
	lodsd				;Get # pts
	mov	edi,esi
	mov	ecx,eax

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
vlp:
	push	ecx
;YXZ
					;z=z*cos(ay)-x*sin(ay)
					;x=z*sin(ay)+x*cos(ay)
	mov	eax,[esi]		;Get X
	add	eax,xd
	mov	ecx,eax

	mov	ebx,[esi].XYZ.Z		;Get Z
	add	ebx,zd
	mov	edx,ebx

	imul	ebx,cosay		;Cos*Z
	imul	eax,sinay		;Sin*X
	sub	ebx,eax

	sar	ebx,16			;Z about Y
;	mov	z2d,ebx

	imul	edx,sinay		;Sin*Z
	imul	ecx,cosay		;Cos*X
	add	ecx,edx
	sar	ecx,16			;X about Y
	mov	x2d,ecx

					;y=y*cos(ax)-z*sin(ax)
					;z=y*sin(ax)+z*cos(ax)
	mov	eax,[esi].XYZ.Y		;Get Y
	add	eax,yd
	mov	ecx,eax

	imul	eax,cosax		;Cos*Y

	mov	edx,ebx
	imul	ebx,sinax		;Sin*Z
	sub	eax,ebx
	sar	eax,16
	mov	y2d,eax			;Y about X

	imul	ecx,sinax		;Sin*Y

	imul	edx,cosax		;Cos*Z
	add	ecx,edx
	sar	ecx,16			;Z about X

					;x=x*cos(az)-y*sin(az)
					;y=x*sin(az)+y*cos(az)
;	lodsd				;Get X
;	add	eax,xd
;;	jno	@F
;;	mov	eax,7fffh
;;	js	@F			;Neg?
;;	neg	eax
;;@@:
;	push	eax
;	imul	eax,cosaz		;Cos*X
;	mov	ecx,eax
;
;	lodsd				;Get Y
;	add	eax,yd
;	mov	ebx,eax
;	imul	eax,sinaz		;Sin*Y
;	sub	ecx,eax
;	sar	ecx,16			;X about Z
;	mov	x2d,ecx
;
;	pop	ecx
;	imul	ecx,sinaz		;Sin*X
;
;	mov	eax,ebx
;	imul	eax,cosaz		;Cos*Y
;	add	ecx,eax
;	sar	ecx,16			;Y about Z
;
;					;y=y*cos(ax)-z*sin(ax)
;					;z=y*sin(ax)+z*cos(ax)
;	push	ecx
;	imul	ecx,cosax		;Cos*Y
;
;	lodsd				;Get Z
;	add	eax,zd
;;	jno	@F
;;	mov	eax,7fffh
;;	js	@F			;Neg?
;;	neg	eax
;;@@:
;	mov	ebx,eax
;	imul	eax,sinax		;Sin*Z
;	sub	ecx,eax
;	sar	ecx,16
;	mov	y2d,ecx			;Y about X
;
;	pop	ecx
;	imul	ecx,sinax		;Sin*Y
;
;	mov	eax,ebx
;	imul	eax,cosax		;Cos*Z
;	add	ecx,eax
;	sar	ecx,16			;Z about X
;
;					;z=z*cos(ay)-x*sin(ay)
;					;x=z*sin(ay)+x*cos(ay)
;	push	ecx
;	imul	ecx,cosay		;Cos*Z
;
;	mov	eax,x2d
;	imul	eax,sinay		;Sin*X
;	sub	eax,ecx
;	jno	@F
;	mov	eax,7fffffffh
;	js	@F			;Neg?
;	neg	eax
;@@:
;	neg	eax
;	sar	eax,16			;Z about Y
;	mov	z2d,eax
;
;	pop	eax
;	imul	eax,sinay		;Sin*Z
;
;	mov	ecx,x2d
;	imul	ecx,cosay		;Cos*X
;	add	eax,ecx
;	jno	@F
;	mov	eax,7fffffffh
;	js	@F			;Neg?
;	neg	eax
;@@:
;	sar	eax,16			;X about Y

	mov	eax,x2d
	mov	[esi],eax
	mov	eax,y2d
	mov	4[esi],eax
;	mov	eax,z2d
	mov	8[esi],ecx



	pop	ecx
	add	esi,4*3

	dec	ecx
	jg	vlp


	pop	ebx
strt:	mov	ebx,[ebx]
	TST	ebx
	jnz	lp


	ret

 SUBEND



;********************************
;* Scale XY by Z and adjust for display
;* ESI=*Xformed XYZ Points
;* Trashes EAX-EDX

 SUBRP	_3d_scalexy

	local	ptx:dword, pty:dword, ptz:dword

	push	esi

	mov	ecx,[esi]	;Get # points
	push	esi
	add	esi,4

lp:	mov	eax,8[esi]	;Z
	add	esi,3*4
	TST	eax
	jl	avis		;Any visable?
	dec	ecx
	jg	lp
	pop	esi
	mov	DPTR [esi],0	;Set # pts 0 so it won't be shown
	jmp	x

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
avis:
	pop	esi
	mov	ecx,[esi]	;Get # points
	add	esi,4
	cld

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
scllp:
	lodsd			;X
	mov	ptx,eax
	lodsd			;Y
	neg	eax
	mov	pty,eax
	lodsd			;Z
;	mov	ptz,eax
	TST	eax
	jl	vis		;In front of view?

				;>Scale up
;	mov	ax,1
;	add	ax,1024
	add	eax,512
	mov	edx,ptx
	imul	edx,eax
	sar	edx,9		;/512
	cmp	edx,7fffh
	jle	xhok
	mov	edx,7fffh
xhok:	cmp	edx,-7fffh
	jge	xlok
	mov	edx,-7fffh
xlok:	mov	[esi-12],edx	;New X

	imul	eax,pty
	sar	eax,9		;/512

	jmp	sety

vis:
	neg	eax
	add	eax,512
	mov	ebx,eax

	mov	eax,ptx
	shl	eax,9		;*512
	cdq
	idiv	ebx
	mov	[esi-12],eax	;New X

	mov	eax,pty
	shl	eax,9		;*512
	cdq
	idiv	ebx

sety:
	add	eax,WINH/2	;+Y offset
	mov	[esi-8],eax	;New Y


nxt:	dec	ecx
	jg	scllp


x:	pop	esi
	ret

 SUBEND



;********************************
;* Draw 3d polygon faces
;* Trashes ES

BMSYNC	equ	1
	ife	BMSYNC
DISMEM=0a0000h
;DESTW	equ	SCRWB
DESTW	equ	320/4
	else
DISMEM=scrnbuf
DESTW	equ	320
	endif

	BSSD	sort_p
	BSSD	sortfree_p
	BSS	sortmem		,2000*16

 SUBRP	_3d_draw

	local	imgx:dword,
		imgxtmp:dword,\
;		imgy:dword,
		imgxadd:dword,
		imgyadd:dword,
		imgxadd2:dword,
		imgyadd2:dword,
		i_p:dword,
		imgl_p:dword,
		imgh:dword,
		imgxmin:dword,
		imgxmax:dword,
		imgymin:dword,
		imgymax:dword,
		dmdl_p:dword,		;*MDL struc
		dtga_p:dword,		;*TGA struc
		dtimg_p:dword,		;*TGA image
		obj_p:dword		;*Current OBJ struc
	pushad


	ife	BMSYNC

	mov	ax,0f00h+SC_MAPMASK	;>Clr view window
	mov	dx,SC_INDEX
	out	dx,ax

	cld

	mov	ax,0f0f0h
	mov	edi,0a0000h
	add	edi,vidpgoffset

	mov	ecx,DESTW*(WINH/2-3)/2
	rep	stosw

	mov	dx,3
@@:	inc	al
	inc	ah
	mov	ecx,DESTW/2
	rep	stosw
	dec	dx
	jg	@B

	inc	al
	inc	ah
	mov	ecx,DESTW*(WINH/2/4)/2
	rep	stosw

	inc	al
	inc	ah
	mov	ecx,DESTW*(WINH/2/4)/2
	rep	stosw

	inc	al
	inc	ah
	mov	ecx,DESTW*(WINH/2/2+2)/2
	rep	stosw

	else


	mov	eax,0f0f0f0f0h
	mov	cx,320*(WINH/2-3)/32
	mov	edi,offset scrnbuf
@@:	mov	[edi],eax
	mov	4[edi],eax
	mov	8[edi],eax
	mov	0ch[edi],eax
	mov	10h[edi],eax
	mov	14h[edi],eax
	mov	18h[edi],eax
	mov	1ch[edi],eax
	add	edi,32
	dec	cx
	jg	@B

	mov	dl,3
nxthl:	add	eax,01010101h
	mov	cx,320/16
@@:	mov	[edi],eax
	mov	4[edi],eax
	mov	8[edi],eax
	mov	0ch[edi],eax
	add	edi,16
	dec	cx
	jg	@B
	dec	dl
	jg	nxthl

	mov	eax,0f4f4f4f4h
	mov	cx,320*(WINH/2)/32
@@:	mov	[edi],eax
	mov	4[edi],eax
	mov	8[edi],eax
	mov	0ch[edi],eax
	mov	10h[edi],eax
	mov	14h[edi],eax
	mov	18h[edi],eax
	mov	1ch[edi],eax
	add	edi,32
	dec	cx
	jg	@B


	endif





	mov	ebx,offset d3vis_p
	jmp	strt

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

objlp:	pop	ebx
strt:	mov	ebx,[ebx]		;Get * next obj
	TST	ebx
	jz	x			;End?

	push	ebx

	mov	esi,[ebx].D3OBJ.XPTS_p
	mov	eax,[esi]		;# pts
	TST	eax
	jz	objlp			;Not visable?
	add	esi,4			;ESI=*Base XYZ words
	mov	edi,[ebx].D3OBJ.FACE_p

	mov	eax,[ebx].D3OBJ.MDL_p
	mov	dmdl_p,eax
	TST	eax
	jz	@F
	mov	eax,[eax].MDL.TGA_p
@@:	mov	dtga_p,eax
	TST	eax
	jz	@F
	mov	eax,[eax].TGA.IMG_p	;* image
@@:	mov	dtimg_p,eax

	mov	obj_p,ebx

	mov	sort_p,0
	mov	sortfree_p,offset sortmem

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

fsortlp:
					;Z=(X1-X0)*(Y2-Y0)-(Y1-Y0)*(X2-X0)
	mov	ebx,[edi].FACE.V1	;Get offset 0
	mov	eax,[edi].FACE.V2	;Get offset 1
	mov	ecx,[edi].FACE.V3	;Get offset 2
	mov	eax,[esi][eax]		;X1
	sub	eax,[esi][ebx]		;X0
	mov	edx,4[esi][ecx]		;Y2
	sub	edx,4[esi][ebx]		;Y0
	imul	eax,edx
	push	eax

	mov	eax,[edi].FACE.V2	;Get offset 1
	mov	eax,4[esi][eax]		;Y1
	sub	eax,4[esi][ebx]		;Y0
	mov	edx,[esi][ecx]		;X2
	sub	edx,[esi][ebx]		;X0
	imul	edx,eax

	pop	eax
	sub	eax,edx
	jl	fsnxt			;Backwards?



	mov	eax,8[esi][ebx]		;Z0
	mov	ebx,4[edi+4]		;Get offset 1
	add	eax,8[esi][ebx]		;Z1
	mov	ebx,8[edi+4]		;Get offset 2
	add	eax,8[esi][ebx]		;Z2
	mov	ebx,12[edi+4]		;Get offset 3
	add	eax,8[esi][ebx]		;Z3

	cmp	eax,400*4*256
	jg	fsnxt			;Face behind view?


	mov	edx,sortfree_p
	add	sortfree_p,16

	mov	ebx,offset sort_p

	mov	4[edx],eax		;Save total of Z
	mov	8[edx],esi		;Save ESI
	mov	12[edx],edi		;Save EDI
	jmp	@F
sortlp:
	cmp	4[ebx],eax
	jge	sadd			;I'm behind?
@@:	mov	ecx,ebx
	mov	ebx,[ebx]
	TST	ebx
	jnz	sortlp
sadd:
	mov	[ecx],edx		;* prev to me
	mov	[edx],ebx		;* me to cur

fsnxt:
	add	edi,sizeof FACE		;Find end

	mov	eax,[edi]
	TST	eax
	jge	fsortlp			;!End?


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	jmp	nxtf

facelp:
	mov	eax,[edi]		;Get * nxt
	mov	sort_p,eax

	mov	esi,8[edi]		;Restore *
	mov	edi,12[edi]


					;>Find lowest & highest XY of face
	mov	ebx,[edi].FACE.V1	;Get pt offset
	mov	eax,[esi][ebx]		;X
	mov	edx,4[esi][ebx]		;Y
	mov	imgxmax,eax		;Highest X
	mov	imgymin,edx		;Lowest Y
	mov	imgymax,edx		;Highest Y
	push	edi
	add	edi,FACE.V1
	mov	ecx,4
	jmp	mmstrt

mmlp:
	add	edi,4
	mov	ebx,[edi]		;Get pt offset
	mov	eax,[esi][ebx]		;X
	cmp	eax,imgxmin
	jge	xbig
mmstrt:	mov	imgxmin,eax		;New low
	mov	blfo_p,edi
xbig:
	cmp	eax,imgxmax
	jle	xsml
	mov	imgxmax,eax		;New high
xsml:
	mov	eax,4[esi][ebx]		;Y
	cmp	eax,imgymin
	jge	ybig
	mov	imgymin,eax		;New low
ybig:
	cmp	eax,imgymax
	jle	ysml
	mov	imgymax,eax		;New high
ysml:
	dec	ecx
	jg	mmlp

	mov	lastfo_p,edi

	pop	edi


	cmp	imgxmin,160
	jge	nxtf			;Lowest X off screen?
	cmp	imgxmax,-160
	jle	nxtf			;Highest X off screen?

	cmp	imgymin,WINH
	jge	nxtf			;Lowest Y off screen?
	cmp	imgymax,-1
	jle	nxtf			;Highest Y off screen?

	mov	ecx,imgxmax
	mov	eax,ecx
	sub	ecx,imgxmin
	jz	nxtf			;Width of 1?

	sub	eax,159
	jle	@F
	sub	ecx,eax			;-extra rgt
@@:	inc	ecx			;Main loop cnt
	mov	facelinecnt,ecx




	mov	eax,[edi]		;Color/Mode
	mov	prtcolors,ax
	add	edi,FACE.V1
	mov	firstfo_p,edi

	TST	ah
	jz	noimg			;0=Solid color

	cmp	dispmode,1
	je	solid

	mov	edx,dtimg_p
	TST	edx
	jnz	@F
solid:
	mov	BPTR prtcolors+1,0
	jmp	noimg
@@:
	mov	eax,edx
	mov	ebx,obj_p
	call	tex_drawface
	jmp	nxtf


	mov	i_p,edx

	CLR	eax
	mov	imgx,eax

	mov	eax,[edi-FACE.V1].FACE.IXY2
	sub	eax,[edi-FACE.V1].FACE.IXY1
	shl	eax,16

	mov	ebx,4[edi]		;Get 2nd offset
	mov	ecx,[esi][ebx]		;2nd X
	mov	ebx,[edi]		;Get 1st offset
	sub	ecx,[esi][ebx]
	inc	ecx
	jz	@F
	cdq
	idiv	ecx
@@:
	mov	imgxadd2,eax


	mov	eax,dtga_p
	mov	eax,[eax].TGA.IMGH
	shl	eax,16
	mov	imgh,eax


noimg:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ



	mov	ebx,blfo_p
	mov	tlfo_p,ebx
	mov	ebx,[ebx]		;Get pt offset
	mov	eax,[esi][ebx]		;Get pt X
	mov	blinexlast,eax
	mov	tlinexlast,eax
	mov	eax,4[esi][ebx]		;Get pt Y
	shl	eax,16
	mov	blineylast,eax
	mov	tlineylast,eax

	mov	blinecnt,1
	mov	tlinecnt,1

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

linelp:
	dec	blinecnt
	jg	blok

getx:	mov	ebx,blfo_p
	sub	ebx,4
	cmp	ebx,firstfo_p
	jae	@F
	mov	ebx,lastfo_p
@@:	mov	blfo_p,ebx
	mov	ebx,[ebx]		;Get pt offset
	mov	ecx,[esi][ebx]		;Get pt X
	mov	edx,blinexlast		;Last X
	mov	blinexlast,ecx
	mov	blinex,edx
	sub	ecx,edx
;	jz	getx
	jl	nxtf
	inc	ecx
	mov	blinecnt,ecx

	mov	eax,4[esi][ebx]		;Get pt Y
	shl	eax,16
	mov	edx,blineylast		;Last Y
	mov	blineylast,eax
	mov	bliney,edx
	sub	eax,edx
	cdq
	idiv	ecx
byaz:	mov	blineyadd,eax
blok:

	dec	tlinecnt
	jg	tlok

getx2:	mov	ebx,tlfo_p
	add	ebx,4
	cmp	ebx,lastfo_p
	jbe	@F
	mov	ebx,firstfo_p
@@:	mov	tlfo_p,ebx
	mov	ebx,[ebx]		;Get pt offset
	mov	ecx,[esi][ebx]		;Get pt X
	mov	edx,tlinexlast		;Last X
	mov	tlinexlast,ecx
	mov	tlinex,edx
	sub	ecx,edx
;	jz	getx2
	jl	nxtf
	inc	ecx
	mov	tlinecnt,ecx

	mov	eax,4[esi][ebx]		;Get pt Y
	shl	eax,16
	mov	edx,tlineylast		;Last Y
	mov	tlineylast,eax
	mov	tliney,edx
	sub	eax,edx
	cdq
	idiv	ecx
	mov	tlineyadd,eax
tlok:

	mov	eax,blineyadd
	add	bliney,eax
	mov	eax,tlineyadd
	add	tliney,eax

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	cmp	imgxmin,-160
	jl	nxtl


	mov	cx,WPTR tliney+2
	cmp	cx,WPTR bliney+2
	jg	nxtf			;Face flipped?

	cmp	cx,WINH
	jge	nxtl


	cmp	BPTR prtcolors+1,0
	jg	tex			;Texture?

	TST	cx
	jge	tlyok			;Line y start ok?
	jmp	ccx

tex:
	mov	eax,i_p
	mov	imgl_p,eax

	mov	eax,imgh
	mov	cx,WPTR bliney+2
	sub	cx,WPTR tliney+2
	movzx	ecx,cx			;Won't be neg
	inc	ecx
	CLR	edx
	div	ecx
@@:	mov	imgyadd,eax

	mov	cx,WPTR tliney+2
	TST	cx
	jge	tlyok			;Line y start ok?

	neg	cx			;>Do top clipping
	movzx	ecx,cx
	imul	eax,ecx

	sar	eax,8			;Int*256 (TGA width)
	CLR	al
	add	imgl_p,eax

ccx:	CLR	ecx
tlyok:


	mov	ax,DESTW
	mul	cx
	mov	tempcnt,ax		;Y offset

	mov	ax,WPTR bliney+2
	cmp	ax,WINH-1
	jle	@F
	mov	ax,WINH-1
@@:
	TST	ax
	jl	nxtl

	push	edi

	sub	cx,ax
	neg	cx
	inc	cx
	push	ecx

	mov	ecx,imgxmin
	add	ecx,160
	mov	edi,ecx			;X

	ife	BMSYNC

	shr	edi,2			;/4
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	mov	dx,SC_INDEX
	out	dx,ax

	add	edi,vidpgoffset
	endif

	add	di,tempcnt		;+Y

	pop	ecx			;Height

	mov	ax,prtcolors
	TST	ah
	jg	texmode			;Texture?

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Draw 1st and last pixels

;	mov	DISMEM[edi],al		;Write 1st pixel
;lnlp:
;	add	edi,DESTW
;	dec	ecx
;	jg	lnlp
;
;	mov	(DISMEM-DESTW)[edi],al	;Write last pix
;
;	pop	edi			;Used??
;
;	jmp	nxtl2

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
					;>Draw a mono colored line
	sar	ecx,1
	jnc	fllp

	mov	DISMEM[edi],al		;Write pixel
	jz	flend			;Only 1?

	add	edi,DESTW

fllp:
	mov	DISMEM[edi],al		;Write pixel
	mov	DISMEM+DESTW[edi],al	;Write pixel

	dec	ecx
	jle	flend

	mov	DISMEM+(DESTW*2)[edi],al
	mov	DISMEM+(DESTW*3)[edi],al

	add	edi,DESTW*4
	dec	ecx
	jg	fllp


flend:	pop	edi			;Used??

	jmp	nxtl2

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

texmode:				;>Draw textured line
	push	esi
	mov	esi,imgl_p		;Get int
	CLR	ebx			;EBX=Y (16:16)
;	mov	edx,imgyadd
texlp:
	mov	al,[esi]		;Get pixel
	TST	al
	jz	@F
	mov	DISMEM[edi],al		;Write pixel
@@:
	add	di,DESTW

;	add	ebx,edx
	add	ebx,imgyadd
	mov	eax,ebx

	sar	eax,8			;Int*256 (TGA width)
	CLR	al
	add	esi,eax

	and	ebx,0ffffh
	dec	cx
	jg	texlp


	pop	esi

	pop	edi			;Used??

nxtl:
	cmp	BPTR prtcolors+1,0
	jz	nxtl2			;No texture?

	mov	eax,imgx		;Next texture X
	mov	edx,eax
	add	eax,imgxadd2
	mov	imgx,eax
	sar	eax,16
	sar	edx,16
	sub	eax,edx
	add	i_p,eax

nxtl2:
	inc	imgxmin
	dec	facelinecnt
	jg	linelp			;More lines?


nxtf:
	mov	edi,sort_p
	TST	edi
	jnz	facelp



	jmp	objlp

x:


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Copy buffer to VGA display


	if	BMSYNC

	cmp	simrun,0
	jne	cpy320			;Simulator running?


SWB=320/4*2

	mov	esi,offset scrnbuf
	mov	ax,1100h+SC_MAPMASK

	mov	ecx,4
cpylp:	push	ecx

	mov	dx,SC_INDEX
	out	dx,ax			;Set bit for bit plane
	push	eax

	mov	edi,vidpgoffset
	add	edi,0a0000h

	mov	edx,320/4/8		;Copy across
ylp:
	mov	ecx,WINH		;Copy down a column
@@:	mov	al,8[esi]
	mov	ah,12[esi]
	shl	eax,16
	mov	al,[esi]
	mov	ah,4[esi]
	mov	[edi],eax

	mov	al,168[esi]
	mov	ah,172[esi]
	shl	eax,16
	mov	al,160[esi]
	mov	ah,164[esi]
	mov	(160/4)[edi],eax

	add	esi,320
	add	edi,SWB

	dec	ecx
	jnz	@B

	add	esi,-WINH*320+4*4
	add	edi,-WINH*SWB+4

	dec	edx
	jnz	ylp

	sub	esi,320/4/8*4*4-1

	pop	eax
	rol	ah,1

	pop	ecx
	dec	ecx
	jnz	cpylp

	jmp	cpydone


SWB=320/4

cpy320:
	mov	esi,offset scrnbuf
	mov	ax,1100h+SC_MAPMASK

	mov	ecx,4
cpy3lp:	push	ecx

	mov	dx,SC_INDEX
	out	dx,ax			;Set bit for bit plane
	push	eax

	mov	edi,vidpgoffset
	add	edi,0a0000h

	mov	edx,320/4/8		;Copy across
y3lp:
	mov	ecx,WINH		;Copy down a column
@@:	mov	al,8[esi]
	mov	ah,12[esi]
	shl	eax,16
	mov	al,[esi]
	mov	ah,4[esi]
	mov	[edi],eax
	mov	al,168[esi]
	mov	ah,172[esi]
	shl	eax,16
	mov	al,160[esi]
	mov	ah,164[esi]
	mov	(160/4)[edi],eax
	add	esi,320
	add	edi,SWB
	dec	ecx
	jnz	@B

	add	esi,-WINH*320+4*4
	add	edi,-WINH*SWB+4

	dec	edx
	jnz	y3lp

	sub	esi,320/4/8*4*4-1

	pop	eax
	rol	ah,1

	pop	ecx
	dec	ecx
	jnz	cpy3lp


cpydone:


	endif



	popad
	ret

 SUBEND



;********************************
;* Get sine and cosine
;* AX = Angle (10:6)
;*>EAX = Sine (0-16384*4)
;*>EBX = Cos (0-16384*4)

 SUBRP	sinecos_get

	movzx	eax,ax
	shr	eax,6
	movsx	ebx,WPTR cos_t[eax*2]
	movsx	eax,WPTR sine_t[eax*2]
	shl	ebx,2
	shl	eax,2
	ret


 SUBEND

	.data
sine_t	word	0,100,201,301,402,502,603,703
	word	803,904,1004,1105,1205,1305,1405,1505
	word	1605,1705,1805,1905,2005,2105,2205,2304
	word	2404,2503,2602,2702,2801,2900,2999,3097
	word	3196,3294,3393,3491,3589,3687,3785,3883
	word	3981,4078,4175,4272,4369,4466,4563,4659
	word	4756,4852,4948,5043,5139,5234,5330,5424
	word	5519,5614,5708,5802,5896,5990,6083,6177
	word	6270,6362,6455,6547,6639,6731,6822,6914
	word	7005,7096,7186,7276,7366,7456,7545,7634
	word	7723,7812,7900,7988,8075,8163,8250,8336
	word	8423,8509,8595,8680,8765,8850,8934,9018
	word	9102,9186,9269,9351,9434,9516,9597,9679
	word	9760,9840,9920,10000,10080,10159,10237,10316
	word	10394,10471,10548,10625,10701,10777,10853,10928
	word	11003,11077,11151,11224,11297,11370,11442,11514
	word	11585,11656,11726,11796,11866,11935,12004,12072
	word	12140,12207,12274,12340,12406,12471,12536,12601
	word	12665,12728,12791,12854,12916,12978,13039,13099
	word	13160,13219,13278,13337,13395,13453,13510,13567
	word	13623,13678,13733,13788,13842,13895,13948,14001
	word	14053,14104,14155,14206,14255,14305,14353,14402
	word	14449,14496,14543,14589,14635,14679,14724,14768
	word	14811,14854,14896,14937,14978,15019,15059,15098
	word	15137,15175,15213,15250,15286,15322,15357,15392
	word	15426,15460,15493,15525,15557,15588,15619,15649
	word	15678,15707,15736,15763,15790,15817,15843,15868
	word	15893,15917,15941,15964,15986,16008,16029,16049
	word	16069,16088,16107,16125,16143,16160,16176,16192
	word	16207,16221,16235,16248,16261,16273,16284,16295
	word	16305,16315,16324,16332,16340,16347,16353,16359
	word	16364,16369,16373,16376,16379,16381,16383,16384
cos_t	word	16384,16384,16383,16381,16379,16376,16373,16369
	word	16364,16359,16353,16347,16340,16332,16324,16315
	word	16305,16295,16284,16273,16261,16248,16235,16221
	word	16207,16192,16176,16160,16143,16125,16107,16089
	word	16069,16049,16029,16008,15986,15964,15941,15917
	word	15893,15868,15843,15817,15791,15763,15736,15707
	word	15679,15649,15619,15588,15557,15525,15493,15460
	word	15426,15392,15357,15322,15286,15250,15213,15175
	word	15137,15098,15059,15019,14978,14937,14896,14854
	word	14811,14768,14724,14680,14635,14589,14543,14497
	word	14449,14402,14354,14305,14256,14206,14155,14104
	word	14053,14001,13949,13896,13842,13788,13733,13678
	word	13623,13567,13510,13453,13395,13337,13279,13219
	word	13160,13100,13039,12978,12916,12854,12792,12729
	word	12665,12601,12536,12472,12406,12340,12274,12207
	word	12140,12072,12004,11935,11866,11796,11726,11656
	word	11585,11514,11442,11370,11297,11224,11151,11077
	word	11003,10928,10853,10777,10702,10625,10548,10471
	word	10394,10316,10238,10159,10080,10000,9921,9840
	word	9760,9679,9598,9516,9434,9352,9269,9186
	word	9102,9019,8935,8850,8765,8680,8595,8509
	word	8423,8337,8250,8163,8076,7988,7900,7812
	word	7723,7634,7545,7456,7366,7276,7186,7096
	word	7005,6914,6823,6731,6639,6547,6455,6362
	word	6270,6177,6084,5990,5896,5802,5708,5614
	word	5519,5425,5330,5235,5139,5044,4948,4852
	word	4756,4660,4563,4466,4370,4273,4176,4078
	word	3981,3883,3785,3688,3590,3491,3393,3295
	word	3196,3097,2999,2900,2801,2702,2602,2503
	word	2404,2304,2205,2105,2005,1906,1806,1706
	word	1606,1506,1405,1305,1205,1105,1004,904
	word	804,703,603,502,402,301,201,100
	word	0,-100,-200,-301,-401,-502,-602,-703
	word	-803,-904,-1004,-1104,-1205,-1305,-1405,-1505
	word	-1605,-1705,-1805,-1905,-2005,-2105,-2204,-2304
	word	-2403,-2503,-2602,-2701,-2800,-2899,-2998,-3097
	word	-3196,-3294,-3393,-3491,-3589,-3687,-3785,-3883
	word	-3980,-4078,-4175,-4272,-4369,-4466,-4563,-4659
	word	-4755,-4852,-4948,-5043,-5139,-5234,-5329,-5424
	word	-5519,-5614,-5708,-5802,-5896,-5990,-6083,-6176
	word	-6269,-6362,-6455,-6547,-6639,-6731,-6822,-6914
	word	-7005,-7095,-7186,-7276,-7366,-7456,-7545,-7634
	word	-7723,-7811,-7900,-7988,-8075,-8163,-8250,-8336
	word	-8423,-8509,-8594,-8680,-8765,-8850,-8934,-9018
	word	-9102,-9185,-9269,-9351,-9434,-9516,-9597,-9679
	word	-9760,-9840,-9920,-10000,-10080,-10159,-10237,-10316
	word	-10394,-10471,-10548,-10625,-10701,-10777,-10853,-10928
	word	-11002,-11077,-11151,-11224,-11297,-11370,-11442,-11514
	word	-11585,-11656,-11726,-11796,-11866,-11935,-12004,-12072
	word	-12139,-12207,-12274,-12340,-12406,-12471,-12536,-12601
	word	-12665,-12728,-12791,-12854,-12916,-12978,-13039,-13099
	word	-13160,-13219,-13278,-13337,-13395,-13453,-13510,-13566
	word	-13623,-13678,-13733,-13788,-13842,-13895,-13948,-14001
	word	-14053,-14104,-14155,-14205,-14255,-14305,-14353,-14402
	word	-14449,-14496,-14543,-14589,-14634,-14679,-14724,-14768
	word	-14811,-14854,-14896,-14937,-14978,-15019,-15059,-15098
	word	-15137,-15175,-15213,-15250,-15286,-15322,-15357,-15392
	word	-15426,-15460,-15493,-15525,-15557,-15588,-15619,-15649
	word	-15678,-15707,-15736,-15763,-15790,-15817,-15843,-15868
	word	-15893,-15917,-15941,-15963,-15986,-16008,-16029,-16049
	word	-16069,-16088,-16107,-16125,-16143,-16160,-16176,-16192
	word	-16207,-16221,-16235,-16248,-16261,-16273,-16284,-16295
	word	-16305,-16315,-16324,-16332,-16340,-16347,-16353,-16359
	word	-16364,-16369,-16373,-16376,-16379,-16381,-16383,-16384
	word	-16384,-16384,-16383,-16381,-16379,-16376,-16373,-16369
	word	-16364,-16359,-16353,-16347,-16340,-16332,-16324,-16315
	word	-16305,-16295,-16284,-16273,-16261,-16248,-16235,-16221
	word	-16207,-16192,-16176,-16160,-16143,-16125,-16107,-16089
	word	-16069,-16049,-16029,-16008,-15986,-15964,-15941,-15917
	word	-15893,-15868,-15843,-15817,-15791,-15763,-15736,-15707
	word	-15679,-15649,-15619,-15588,-15557,-15525,-15493,-15460
	word	-15426,-15392,-15357,-15322,-15286,-15250,-15213,-15175
	word	-15137,-15098,-15059,-15019,-14979,-14937,-14896,-14854
	word	-14811,-14768,-14724,-14680,-14635,-14589,-14543,-14497
	word	-14449,-14402,-14354,-14305,-14256,-14206,-14155,-14105
	word	-14053,-14001,-13949,-13896,-13842,-13788,-13734,-13678
	word	-13623,-13567,-13510,-13453,-13395,-13337,-13279,-13219
	word	-13160,-13100,-13039,-12978,-12916,-12854,-12792,-12729
	word	-12665,-12601,-12537,-12472,-12406,-12340,-12274,-12207
	word	-12140,-12072,-12004,-11935,-11866,-11797,-11727,-11656
	word	-11585,-11514,-11442,-11370,-11298,-11225,-11151,-11077
	word	-11003,-10928,-10853,-10778,-10702,-10625,-10549,-10472
	word	-10394,-10316,-10238,-10159,-10080,-10001,-9921,-9841
	word	-9760,-9679,-9598,-9516,-9434,-9352,-9269,-9186
	word	-9103,-9019,-8935,-8850,-8765,-8680,-8595,-8509
	word	-8423,-8337,-8250,-8163,-8076,-7988,-7900,-7812
	word	-7723,-7635,-7546,-7456,-7366,-7277,-7186,-7096
	word	-7005,-6914,-6823,-6731,-6640,-6547,-6455,-6363
	word	-6270,-6177,-6084,-5990,-5897,-5803,-5709,-5614
	word	-5520,-5425,-5330,-5235,-5139,-5044,-4948,-4852
	word	-4756,-4660,-4563,-4467,-4370,-4273,-4176,-4078
	word	-3981,-3883,-3786,-3688,-3590,-3492,-3393,-3295
	word	-3196,-3098,-2999,-2900,-2801,-2702,-2603,-2503
	word	-2404,-2304,-2205,-2105,-2006,-1906,-1806,-1706
	word	-1606,-1506,-1406,-1305,-1205,-1105,-1005,-904
	word	-804,-703,-603,-502,-402,-301,-201,-100
	word	0,100,201,301,402,502,603,703
	word	803,904,1004,1105,1205,1305,1405,1505
	word	1605,1705,1805,1905,2005,2105,2205,2304
	word	2404,2503,2602,2702,2801,2900,2999,3097
	word	3196,3294,3393,3491,3589,3687,3785,3883
	word	3981,4078,4175,4272,4369,4466,4563,4659
	word	4756,4852,4948,5043,5139,5234,5330,5424
	word	5519,5614,5708,5802,5896,5990,6083,6177
	word	6270,6362,6455,6547,6639,6731,6822,6914
	word	7005,7096,7186,7276,7366,7456,7545,7634
	word	7723,7812,7900,7988,8075,8163,8250,8336
	word	8423,8509,8595,8680,8765,8850,8934,9018
	word	9102,9186,9269,9351,9434,9516,9597,9679
	word	9760,9840,9920,10000,10080,10159,10237,10316
	word	10394,10471,10548,10625,10701,10777,10853,10928
	word	11003,11077,11151,11224,11297,11370,11442,11514
	word	11585,11656,11726,11796,11866,11935,12004,12072
	word	12140,12207,12274,12340,12406,12471,12536,12601
	word	12665,12728,12791,12854,12916,12978,13039,13099
	word	13160,13219,13278,13337,13395,13453,13510,13567
	word	13623,13678,13733,13788,13842,13895,13948,14001
	word	14053,14104,14155,14206,14255,14305,14353,14402
	word	14449,14496,14543,14589,14635,14679,14724,14768
	word	14811,14854,14896,14937,14978,15019,15059,15098
	word	15137,15175,15213,15250,15286,15322,15357,15392
	word	15426,15460,15493,15525,15557,15588,15619,15649
	word	15678,15707,15736,15763,15790,15817,15843,15868
	word	15893,15917,15941,15964,15986,16008,16029,16049
	word	16069,16088,16107,16125,16143,16160,16176,16192
	word	16207,16221,16235,16248,16261,16273,16284,16295
	word	16305,16315,16324,16332,16340,16347,16353,16359
	word	16364,16369,16373,16376,16379,16381,16383,16384




;********************************
;* Print ASCII string (320 wide)
;* ESI=* ASCIIZ
;* BX=Bgnd color (0-255) : Fgnd color (0-255)
;* CX=X
;* DX=Y
;* Trashes ESI,EDI

 SUBRP	prt320

	push	eax
	push	ebx
	push	ecx
	push	edx
	push	ebp

	mov	prtx,cx
	mov	prty,dx
	mov	prtcolors,bx
	mov	ax,320/4
	mul	dx
	add	eax,vidpgoffset
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

	movzx	ecx,prtx
	mov	edi,ecx			;X
	shr	edi,2			;/4
	add	di,bp			;+Y offset
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	mov	dx,SC_INDEX
	out	dx,ax

	mov	bx,prtcolors
	mov	ecx,8			;Y cnt
	pop	edx
lpy:
	mov	ax,bx			;>Copy column
	test	[esi],dl		;Test bit
	jnz	fgc
	mov	al,ah
fgc:	mov	0a0000h[edi],al

	mov	ax,bx			;>Copy column
	test	[esi],dh		;Test bit
	jnz	fgc2
	mov	al,ah
fgc2:	mov	0a0001h[edi],al
	inc	esi
	add	edi,320/4
	dec	ecx
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

 SUBEND



;********************************
;* Print ASCII string in font6
;* ESI=* ASCIIZ
;* BX=Bgnd color (0-255) : Fgnd color (0-255)
;* CX=X
;* DX=Y
;* Trashes ESI,EDI

 SUBRP	prt320f6

	push	eax
	push	ebx
	push	ecx
	push	edx
	push	ebp

	mov	prtx,cx
	mov	prty,dx
	mov	prtcolors,bx
	mov	ax,320/4
	mul	dx
	add	eax,vidpgoffset
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

	movzx	ecx,prtx
	mov	edi,ecx			;X
	shr	edi,2			;/4
	add	di,bp			;+Y offset
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	mov	dx,SC_INDEX
	out	dx,ax

	mov	bx,prtcolors
	mov	cl,6			;Y cnt
	pop	edx
lpy:
	mov	ax,bx			;>Copy column
	test	[esi],dl		;Test bit
	jnz	fgc
	mov	al,ah
fgc:	mov	0a0000h[edi],al

	inc	esi
	add	edi,320/4
	dec	cl
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
	pop	eax

	ret

 SUBEND



;********************************
;* Initialize keyboard handler
;* Trashes all non seg, ES

 SUBRP	keyb_init

	mov	edi,offset keyh_t
	mov	ecx,offset keyh_t_end-offset keyh_t
@@:	mov	BPTR [edi],0
	inc	edi
	loop	@B

	push	es
	INT21X	3509h			;Get Int9
	mov	DPTR int9_fp,ebx
	mov	WPTR int9_fp+4,es
	pop	es

	push	ds
	mov	ax,cs
	mov	ds,ax
	mov	edx,offset int9handler
	INT21X	2509h			;Set Int9
	pop	ds

	ret
 SUBEND


;********************************
;* Int9 keyboard handler
;* Trashes none

 SUBRP	int9handler

	push	eax
	push	ebx
	push	ds

	mov	ax,seg _DATA
	mov	ds,ax

	in	al,60h

	mov	ebx,7fh
	and	bl,al
	cmp	bl,50h
	ja	x

	sar	al,7
	not	al
	mov	keyh_t[ebx],al		;0 or -1

;	mov	i9lastk,al

x:
	pop	ds
	pop	ebx
	pop	eax
	jmp	cs:[int9_fp]

	.data
keyh_t	db	0
i9esc	db	0
	db	1fh-2 dup (0)
i9s	db	0
	db	32h-20h dup (0)
i9m	db	0
i9lb	db	0
i9rb	db	0
	db	38h-35h dup (0)
i9alt	db	0
i9spc	db	0
	db	48h-3ah dup (0)
i9up	db	0
	db	0
	db	0
i9lft	db	0
	db	0
i9rgt	db	0
	db	0
	db	0
i9down	db	0	;50h
keyh_t_end\
	db	0
i9lastk	db	0
	.code

 SUBEND



;********************************
;* Get a random word
;* >AX=Rnd #
;* Trashes none

	BSSW	rndlast

 SUBRP	rnd

	xor	ax,rndlast
	rol	ax,cl
	add	ax,sp
	add	ax,si
	mov	rndlast,ax
	ret

 SUBEND



;********************************
;* Get dir to face an object
;* EAX=Dest X
;* EBX=Dest Z
;* EDI=*Source 3D obj
;* >EAX=(0-255)*256 (8:8)
;* Trashes EAX-EDX

 SUBRP	seekob_dir256

	CLR	edx			;Octant 0-1

	sub	eax,[edi].D3OBJ.X	;EAX=DestX-SrcX
	jl	a

	sub	ebx,[edi].D3OBJ.Z	;EBX=DestZ-SrcZ
	neg	ebx
	jge	oct01

	mov	dh,8			;Oct 2-3
	jmp	b

a:
	neg	eax

	mov	dh,16			;Oct 4-5
	sub	ebx,[edi].D3OBJ.Z	;EBX=DestZ-SrcZ
	jge	sl
	mov	dh,16+8			;Oct 6-7
b:	neg	ebx
	xchg	eax,ebx

sl:	shl	dh,3			;Oct*8
oct01:	CLR	ecx
	cmp	eax,ebx			;>Cmp slope
	jae	xbig

	shr	ebx,2+3			;Bigger/32
	jnz	@F
	jmp	x
lp1:	inc	dh			;Next 1/32 oct
	add	ecx,ebx			;+1/32
@@:	cmp	ecx,eax
	jb	lp1
	jmp	x

xbig:	add	dh,63			;End of next octant
	shr	eax,2+3			;Bigger/32
	jnz	@F
	jmp	x
lp2:	dec	dh			;Next 1/32 oct
	add	ecx,eax			;+1/32
@@:	cmp	ecx,ebx
	jb	lp2


x:	mov	eax,edx
	inc	eax

	ret
 SUBEND



;********************************
;* Init process system
;* Trashes all non seg

 SUBRP	prc_init

	mov	esi,offset prcmem	;>Init free list
	mov	prcfree_p,esi
	mov	ecx,PRCNUM
flp:	mov	edi,esi
	add	esi,sizeof PRC
	mov	[edi],esi
	loop	flp

	CLR	eax
	mov	[edi],eax		;Null in last
	mov	prcact_p,eax

	ret

 SUBEND



;********************************
;* Create a process
;* AX=ID
;* EBX=* starting code
;* ESI=* process
;* >EBX=* new process
;* Trashes EAX

 SUBRP	prc_create

	push	edi

	mov	edi,prcfree_p
	TST	edi
	jz	err			;None free?

	mov	[edi].PRC.ID,ax
	mov	[edi].PRC.WAKE_p,ebx
	mov	[edi].PRC.SLP,1
	mov	eax,[edi]		;Unlink
	mov	prcfree_p,eax

	mov	eax,[esi]		;Link in after currrent proc
	mov	[edi],eax
	mov	[esi],edi
	mov	ebx,edi

	pop	edi
	ret

err:	jmp	runquit

 SUBEND


;********************************
;* Dispatch active processes
;* Trashes all non seg

 SUBRP	prc_dispatch

	mov	esi,offset prcact_p
	jmp	nxt


prc_die::
	mov	edi,offset prcact_p
	jmp	pds
@@:
	cmp	esi,edi
	je	kl
pds:	mov	ebx,edi			;Save last
	mov	edi,[edi]
	TST	edi
	jnz	@B			;More?
	jmp	nxt
kl:
	mov	esi,[edi]		;Unlink
	mov	[ebx],esi

	mov	eax,prcfree_p		;Add to free list
	mov	[edi],eax
	mov	prcfree_p,edi
	jmp	nxt2

prc_slp::
	mov	[esi].PRC.SLP,ax
	pop	eax
	mov	[esi].PRC.WAKE_p,eax
	mov	[esi].PRC.REDI,edi	;Save EDI

nxt:
	mov	esi,[esi]
nxt2:	TST	esi
	jz	x			;End?

	dec	[esi].PRC.SLP
	jg	nxt

	mov	edi,[esi].PRC.REDI	;Restore EDI
	jmp	[esi].PRC.WAKE_p	;Call with ESI=*Proc


x:	ret

 SUBEND






;*******************************
;* Build lists and collide
;* Trashes all non seg

 SUBRP	_3d_collide

	mov	ebx,world_p

	mov	ecx,offset pcoll_t	;Build collision lists
	mov	edi,offset ecoll_t
	mov	edx,offset ncoll_t

	jmp	strt

enmy:	mov	[edi],ebx		;Insert on enemy list
	add	edi,4
next:	mov	ebx,[ebx].D3OBJ.WNXT_p	;Get next obj
strt:
	TST	ebx
	jz	endo

	mov	ax,[ebx].D3OBJ.ID
	TST	ah
	jz	next			;Not collideable?

;	TST	ah			;Check Class
	jl	enmy			;Enemy?
	test	ah,40h
	jnz	plyr			;Player?

	mov	[edx],ebx		;Insert on neutral list
	add	edx,4
	jmp	next

plyr:
	mov	[ecx],ebx		;Insert on player list
	add	ecx,4
	jmp	next


endo:	
	mov	[edi],ebx		;Null terminate each list
	mov	[ecx],ebx
	mov	[edx],ebx

	mov	esi,offset ecoll_t
	mov	ebx,offset pcoll_t
	call	collidelists		;Collide enemy to player

	mov	esi,offset ncoll_t
	mov	ebx,offset ecoll_t
	call	collidelists		;Collide neutral to enemy

	mov	esi,offset ncoll_t
	mov	ebx,offset pcoll_t
;	jruc	collidelists		;Collide neutral to player
					;Fall through
 SUBEND

;*******************************
;* Collide objects on list 1 with those on list 2
;* ESI,EBX=ptrs to null terminated tables of object ptrs

	BSSD	collst2_p

 SUBRP	collidelists

	mov	collst2_p,ebx
	push	esi

lp:	pop	esi
	mov	edi,[esi]
	TST	edi
	jz	x

	add	esi,4
	push	esi
					;Load up coors of obj from first list
	mov	ecx,[edi].D3OBJ.X	;ECX=Obj1 X
;	jz	lp			;Deleted?
	mov	edx,[edi].D3OBJ.Z	;EDX=Obj1 Z

	mov	esi,collst2_p		;Load head of second list
	jmp	lp2

psi:	pop	esi
lp2:	mov	ebx,[esi]
	TST	ebx
	jz	lp

	add	esi,4

					;Check objs for intersection
	mov	eax,[ebx].D3OBJ.Z
	sub	eax,edx
	jge	@F
	neg	eax
@@:	sar	eax,8			;Kill frac
	sub	eax,[ebx].D3OBJ.CLRNG
	sub	eax,[edi].D3OBJ.CLRNG
	jge	lp2

	mov	eax,[ebx].D3OBJ.X
	sub	eax,ecx
	jge	@F
	neg	eax
@@:	sar	eax,8			;Kill frac
	sub	eax,[ebx].D3OBJ.CLRNG
	sub	eax,[edi].D3OBJ.CLRNG
	jge	lp2

	push	esi

	call	ColFunc			;>Call colfunc for obj A1 and A2
	push	eax

	xchg	edi,ebx
	call	ColFunc
	xchg	edi,ebx

	pop	esi
	TST	eax
	jnz	@F

	TST	esi
	jz	psi

@@:	push	eax

	mov	d3collstop,0		;Clr flag

	TST	esi
	jz	pobj2col
	push	ebx
	mov	ebx,edi
	call	esi			;Call collision for 1st obj
	pop	ebx

pobj2col:
	pop	esi
	TST	esi
	jz	pckfree
	call	esi			;Call collision for 2nd obj

pckfree:
	cmp	d3collstop,0
	je	psi			;Continue scan?
	pop	esi
	jmp	lp

x:	ret

 SUBEND

;****************************************************************************
;* Return in EAX routine for obj EDI struck by obj EBX
;* Trashes EAX

 SUBRP	ColFunc

	movzx	eax,BPTR [ebx].D3OBJ.ID+1
	mov	ah,BPTR [edi].D3OBJ.ID+1
	and	ah,1fh

	shl	al,8-5
	shr	ax,3-2

	add	eax,offset typetbl

	jmp	cs:DPTR [eax]		;Routine can trash none

 SUBEND

;****************************************************************************
;* These are the COLLISION FUNCTIONS
;* A collision function is selected by the routine ColFunc
;* which uses the TYPE field of the victims ID to select a subtable
;* and indexes the subtable with the TYPE field of the killer.
;* This gives a ptr to a COLLISION FUNCTION which returns
;* the COLLISION ROUTINE to be called for the victim in AX.
;* The COLLISION FUNCS can destroy no registers!
;****************************************************************************

typetbl:
;0000
;NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;100
;Player
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;200
;Player shot
	dd	NULL, NULL, NULL, PSGO, PSTK, NULL, PSNT, PSTR
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;300
;Ground obstacle
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;400
;Tank
	dd	NULL, NULL, TKPS, TKGO, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;500
;Shell
	dd	NULL, NULL, NULL, SHGO, NULL, NULL, SHNT, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;600
;Network tank
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;700
;Train
	dd	NULL, NULL, TRPS, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;800
;Enemy bullet
	dd	NULL, NULL, NULL, BUGO, NULL, NULL, BUNT, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;900
;Enemy missile
	dd	NULL, NULL, NULL, MSGO, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;a00
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;b00
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;c00
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;d00
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;e00
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;f00
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1000
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1100
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1200
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1300
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1400
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1500
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1600
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1700
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1800
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1900
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1a00
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1b00
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1c00
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1d00
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1e00
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
;1f00
;Free
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	dd	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL


;********************************
;* Collison


NULL:	CLR	eax
	ret


PSGO:
PSTK:
PSNT:
PSTR:
	mov	eax,offset pl_shot_hit
	ret

TKPS:
	mov	eax,offset en_tank_hitshell
	ret
TKGO:
	mov	eax,offset en_tank_hitobst
	ret

SHGO:
SHNT:
	mov	eax,offset en_shell_hit
	ret

TRPS:
	mov	eax,offset en_train_hit
	ret

BUGO:
BUNT:
	mov	eax,offset en_bullet_hit
	ret

MSGO:
	mov	eax,offset en_msl_hit
	ret


;****************************************************************
;* Initialize sound system
;* Trashes all non seg

 SUBRP	snd_init

	push	es
	INT21X	3508h			;Get Int8
	mov	DPTR int8_fp,ebx
	mov	WPTR int8_fp+4,es
	pop	es

	push	ds
	mov	ax,cs
	mov	ds,ax
	mov	edx,offset int8handler
	INT21X	2508h			;Set Int8
	pop	ds

	ret
 SUBEND

;********************************
;* Stop sound system and free resources
;* Trashes all non seg

 SUBRP	snd_uninit

	push	ds

	lds	edx,int8_fp
	INT21X	2508h			;Restore Int8


	in	al,61h
	and	al,0fch
	out	61h,al

	pop	ds
	ret
 SUBEND

;********************************
;* Int8 timer handler (sound)
;* Trashes none

 SUBRP	int8handler

	push	eax
	push	ds

	mov	ax,seg _DATA
	mov	ds,ax

	inc	tickcnt			;For general use

	cmp	sndontime,0
	jl	x			;No active snd?

	mov	ax,sndfreq		;>Update freq
	add	ax,sndfreqadd
	mov	sndfreq,ax
	out	42h,al
	mov	al,ah
	out	42h,al

	dec	sndontime
	jge	@F			;Time left?

	in	al,61h			;>Kill snd
	and	al,0fch
	out	61h,al
@@:

x:	pop	ds
	pop	eax
	jmp	cs:[int8_fp]


sndontime	dw	-1
sndfreq		dw	0
sndfreqadd	dw	0

 SUBEND

;********************************
;* Start a sound effect
;* AX=Frequency
;* BX=Freq add
;* CX=Time duration in ticks (0-?)
;* Trashes AX

 SUBRP	snd_start

	mov	sndfreq,ax
	mov	sndfreqadd,bx
	mov	sndontime,cx

	push	eax
	mov	al,0b6h		;Mode 3
	out	43h,al

	pop	eax
	out	42h,al
	mov	al,ah
	out	42h,al

	in	al,61h		;Enable
	or	al,3
	out	61h,al

	ret

 SUBEND




;****************************************************************
;* Network functions



;********************************
;* This is called by net code each time a new user joins in
;* EAX=* to their login data block
;* >EBX=* to net plyr prc

 SUBRP	netlogin

	push	eax
	push	esi
	push	edi

	mov	edi,eax


	mov	esi,offset prcact_p		;>Create their process
	CREATE	0,net_tnk
	mov	[ebx].PRC.REDI,0

	mov	cx,19				;>Find free spot
	mov	esi,offset netpdta_t
@@:	cmp	WPTR [esi],-1
	je	@F
	add	esi,NETPDSZ
	loopw	@B
	mov	ax,'?'*256
	jmp	nof
@@:
	mov	eax,[edi]			;>Copy their name
nof:	mov	[esi],eax
	mov	al,4[edi]
	CLR	ah
	mov	4[esi],ax

	mov	ntnk_pdta_p[ebx],esi		;Save *

	pop	edi
	pop	esi
	pop	eax
	ret



 SUBEND

;********************************
;* This is called each frame for every station received
;* EAX=* to block received from other station
;* EBX=* passed at login

 SUBRP	netrespond

	push	eax
	push	ebx
	push	ecx
	push	esi
	push	edi

	mov	esi,eax


	mov	edi,[ebx].PRC.REDI
	TST	edi
	jz	x				;Process hasn't run?

	mov	ax,[esi].NETSTAT.SHIELD		;>Save to process
	mov	ntnk_shield[ebx],ax

	mov	ax,[esi].NETSTAT.ACT
	mov	ntnk_act[ebx],ax

	mov	ax,[esi].NETSTAT.MSLT
	mov	ntnk_mslt[ebx],al

	mov	eax,DPTR [esi].NETSTAT.KNAME_s
	mov	DPTR ntnk_kname_s[ebx],eax
	mov	ax,WPTR 4[esi].NETSTAT.KNAME_s
	mov	WPTR ntnk_kname_s+4[ebx],ax

						;>Update chassie
	mov	eax,[esi].NETSTAT.X
	mov	[edi].D3OBJ.X,eax

	mov	eax,[esi].NETSTAT.Y
	push	eax
	add	eax,80*256
	mov	[edi].D3OBJ.Y,eax

	mov	eax,[esi].NETSTAT.Z
	mov	[edi].D3OBJ.Z,eax

	mov	ax,[esi].NETSTAT.YA
	neg	ax
	mov	[edi].D3OBJ.YA,ax


	mov	edi,ntnk_tur_p[ebx]		;>Update turret

	pop	eax
	add	eax,195*256
	mov	[edi].D3OBJ.Y,eax

	mov	ax,[esi].NETSTAT.TYA
	neg	ax
	mov	[edi].D3OBJ.YA,ax


x:
	pop	edi
	pop	esi
	pop	ecx
	pop	ebx
	pop	eax
	ret

 SUBEND

;********************************
;* This is called each time a user disconnects
;* EBX=* passed at login

 SUBRP	netlogout

	push	eax
	push	ebx
	push	ecx
	push	edx

	mov	ntnk_shield[ebx],-1	;Cause him to die
	mov	ntnk_logout[ebx],1	;Logged out

	mov	ebx,ntnk_pdta_p[ebx]
	call	cpanel_prttxt

	mov	ebx,offset logout_s
	call	cpanel_prttxtatend

	pop	edx
	pop	ecx
	pop	ebx
	pop	eax
	ret
 SUBEND


;***************
;* Abort check
;* >NZ on abort

 SUBRP	abortcheck

	push	eax

	CLR	al
	pop	eax
	ret

 SUBEND



;********************************
;* Setup this players status for the net
;* Trashes all non seg

 SUBRP	pl_setupnetstat

	mov	esi,netsenddata_p	;Get my send *


	mov	ax,plshield
	mov	[esi].NETSTAT.SHIELD,ax

	mov	ax,plnetact
	mov	[esi].NETSTAT.ACT,ax

	mov	eax,plx
	mov	[esi].NETSTAT.X,eax

	mov	eax,ply
	mov	[esi].NETSTAT.Y,eax

	mov	eax,plz
	mov	[esi].NETSTAT.Z,eax

	mov	ax,plya
	mov	[esi].NETSTAT.YA,ax

	mov	ax,pltya
	mov	[esi].NETSTAT.TYA,ax

	mov	ax,plmslturn
	mov	[esi].NETSTAT.MSLT,ax

	ret

 SUBEND




;****************************************************************

	if	0


;********************************
;* Fix sort order in 3DG faces
;* Trashes all non seg

 SUBRP	_3d_reversefaces

	cmp	revfaces,0
	jne	x			;Already done?

	inc	revfaces

	mov	esi,offset m1chas_lt
	call	_3d_revfaces

	mov	esi,offset m1t_lt
	call	_3d_revfaces

x:	ret

 SUBEND

 SUBRP	_3d_revfaces

	jmp	strt

lp:	inc	esi
	inc	esi
	push	esi

@@:	inc	esi			;>Find end
	inc	esi
	cmp	WPTR [esi],-1
	jne	@B

	pop	ebx
	push	esi

@@:	dec	esi			;>Swap ends
	dec	esi
	cmp	ebx,esi
	jae	nxt
	mov	ax,[ebx]
	xchg	ax,[esi]
	mov	[ebx],ax
	inc	ebx
	inc	ebx
	jmp	@B

nxt:	pop	esi
	inc	esi
	inc	esi
strt:	cmp	WPTR [esi],0
	jge	lp

	ret

 SUBEND


	.data
revfaces	db	0





;********************************
;* Run 3D VUNIT mode
;* Trashes ES

 SUBR	_3d_vunitrun

	pusha

	push	ds


	mov	ax,seg FAR_DATA
	mov	es,ax
	cmp	es:d3mode,1
	jne	x			;No init?


	mov	ax,13h			;>Set 320x200 256 color
	int	10h
	call	vid_chain4off

	call	palblk_setvgapal

	mov	al,0f0h			;DAC color reg
	mov	cx,16
	mov	si,offset d3pal_t
	call	vid_setvgapal18



	CLR	ax			;>Save time
	mov	es,ax
	mov	eax,es:[46ch]
	push	eax


	mov	ax,seg FAR_DATA
	mov	ds,ax
	assume	ds:seg FAR_DATA


	CLR	eax
	mov	framecnt,eax


	mov	d3runsp,sp		;Save stack ptr


	call	snd_init


	call	keyb_init


	call	_3d_loadimgs




	mov	ax,0f00h+SC_MAPMASK	;>Clr vidmem
	mov	dx,SC_INDEX
	out	dx,ax

	mov	ax,0a000h		;Set Eseg to video mem
	mov	es,ax
	cld

	CLR	al
	CLR	di
	mov	cx,256*256-1
	rep	stosb


;----

lp:
	cmp	cs:tickcnt,1
;	jl	lp
	mov	cs:tickcnt,0


	inc	framecnt


	CLR	ax			;>Clr keyboard buffer
	mov	es,ax
	cli
	mov	ax,es:[41ah]
	mov	es:[41ch],ax
	sti


	mov	dx,HSTCTL		;>Wait for XF0 from DSP
@@:
	cmp	cs:tickcnt,5
	jae	chkabort		;Timed out?

	in	ax,dx
	test	al,4
	jz	@B

;	mov	ax,HSTSEG		;>Wait for XF0 from DSP
;	mov	es,ax
;@@:	test	WPTR es:HSTCTL,4
;	jz	@B			;Off?



;	call	host_copyvidmem

;TEST
;	mov	cx,5000
;@@:	push	cx
	call	host_genscrnfmq
;	pop	cx
;	loopw	@B
;	jmp	rquit


	mov	dx,CC_INDEX		;>Page flip
	mov	al,CC_STRTADRH
	out	dx,al
	inc	dx

	mov	al,BPTR vidpgoffset+1
	out	dx,al
	xor	BPTR vidpgoffset+1,80h

	mov	dx,3dah
@@:	in	al,dx
	and	al,8
	jnz	@B			;In VB?
@@:	in	al,dx
	and	al,8
	jz	@B			;Not in VB?


chkabort:
	mov	dx,201h
	in	al,dx
	test	al,80h
	jz	rquit
	cmp	cs:i9esc,0
	je	lp


rquit:
	mov	sp,d3runsp		;Restore stack ptr


	call	snd_uninit


	push	ds
	lds	dx,cs:int9_fp
	INT21X	2509h			;Restore Int9 (KeyB)
	pop	ds


	mov	ax,seg DGROUP
	mov	ds,ax



	call	vid_setvmode
	call	main_draw
	call	mouse_reset
	call	palblk_setvgapal


	pop	edx			;>Print frames/sec

	CLR	ax
	mov	es,ax
	mov	eax,es:[46ch]
	sub	eax,edx
	push	ax
	cdq
	mov	ecx,18
	div	ecx
	TST	ax
	jz	fsz
	mov	cx,ax
	mov	ax,seg FAR_DATA
	mov	es,ax
	mov	ax,framecnt
	CLR	dx
	div	cx

fsz:
	mov	bx,0feffh
	CLR	cx
	CLR	dx
	call	prt_dec

	pop	ax
	mov	dx,10
	call	prt_dec


x:	pop	ds
	popa
	ret

 SUBEND


;********************************
;* Copy video mem from host to PC
;* Trashes all

; SUBRP	host_copyvidmem
;
;	mov	eax,0f80000h
;	call	host_setaddr
;
;;	mov	WPTR es:HSTCTL,1000h
;
;	mov	ax,0a000h		;Set Eseg to video mem
;	mov	gs,ax
;
;	mov	di,vidpgoffset
;
;
;	mov	cx,320*200/4
;	mov	dx,SC_INDEX
;	mov	ax,0100h+SC_MAPMASK
;	out	dx,ax
;	CLR	bx
;vlp:
;	mov	es:HSTADRL,bx
;	mov	ax,es:HSTDATA
;	mov	gs:[di],al
;	add	bx,4
;	inc	di
;
;	dec	cx
;	jg	vlp
;
;
;	mov	cx,320*200/4
;	mov	ax,0200h+SC_MAPMASK
;	out	dx,ax
;	mov	bx,1
;	mov	di,vidpgoffset
;	add	di,bx
;v2lp:
;	mov	es:HSTADRL,bx
;	mov	ax,es:HSTDATA
;	mov	gs:[di],al
;	add	bx,4
;	inc	di
;
;	dec	cx
;	jg	v2lp
;
;
;	mov	cx,320*200/4
;	mov	ax,0400h+SC_MAPMASK
;	out	dx,ax
;	mov	bx,2
;	mov	di,vidpgoffset
;	add	di,bx
;v3lp:
;	mov	es:HSTADRL,bx
;	mov	ax,es:HSTDATA
;	mov	gs:[di],al
;	add	bx,4
;	inc	di
;
;	dec	cx
;	jg	v3lp
;
;
;	mov	cx,320*200/4
;	mov	ax,0800h+SC_MAPMASK
;	out	dx,ax
;	mov	bx,3
;	mov	di,vidpgoffset
;	add	di,bx
;v4lp:
;	mov	es:HSTADRL,bx
;	mov	ax,es:HSTDATA
;	mov	gs:[di],al
;	add	bx,4
;	inc	di
;
;	dec	cx
;	jg	v4lp
;
;
;;	mov	cx,320*200/4
;;	mov	dx,SC_INDEX
;;vlp:
;;	mov	ax,0100h+SC_MAPMASK
;;	out	dx,ax
;;	mov	ax,es:HSTDATA
;;	mov	gs:[di],al
;;
;;	mov	ax,0200h+SC_MAPMASK
;;	out	dx,ax
;;	mov	ax,es:HSTDATA
;;	mov	gs:[di],al
;;
;;	mov	ax,0400h+SC_MAPMASK
;;	out	dx,ax
;;	mov	ax,es:HSTDATA
;;	mov	gs:[di],al
;;
;;	mov	ax,0800h+SC_MAPMASK
;;	out	dx,ax
;;	mov	ax,es:HSTDATA
;;	mov	gs:[di],al
;;
;;	inc	di
;;
;;	dec	cx
;;	jg	vlp
;
;
;	mov	eax,20h
;	call	host_setaddr
;
;	mov	WPTR es:HSTDATA,1
;
;	mov	WPTR es:HSTCTL,0a000h	;Let DSP run
;
;	ret
;
; SUBEND



;********************************
;* Copy DMAQ from host to PC
;* Trashes all

 SUBRP	host_genscrnfmq

	mov	eax,0f80000h
	call	host_setaddr2

	mov	dx,HSTCTL
	mov	ax,1000h		;Auto inc
	out	dx,ax


	mov	dx,HSTDATA
	in	ax,dx			;Get queue count
	cmp	ax,2000
	jbe	cok
	CLR	ax
cok:
	mov	es,ss:scrnbufseg	;ES=*DMAQ
	mov	es:0,ax
	mov	di,2

	cld

	imul	ax,9			;Color, (X,Y)*4
	mov	cx,ax
	rep	insw			;Read buffer


	mov	eax,20h
	call	host_setaddr2

	mov	dx,HSTDATA
	mov	ax,1
	out	dx,ax

	mov	dx,HSTCTL		;Let DSP run
	mov	ax,0a000h
	out	dx,ax


	call	_3d_drawDMAq


	ret

 SUBEND



;********************************
;* Draw 3d polygon faces
;* Trashes ES,FS

DESTW	equ	320/4

 SUBRP	_3d_drawDMAq

	local	imgx:dword, imgxtmp:dword, imgy:dword,\
		imgxadd:dword, imgyadd:dword,\
		imgxadd2:dword, imgyadd2:dword,\
		img_p:word, imgl_p:word,\
		imgh:dword
	pusha


	mov	ax,0f00h+SC_MAPMASK	;>Clr view window
	mov	dx,SC_INDEX
	out	dx,ax

	mov	ax,0a000h		;Set Eseg to video mem
	mov	es,ax
	cld

	mov	ax,0f0f0h
	mov	di,vidpgoffset

	mov	cx,DESTW*(WINH/2-3)/2
	rep	stosw

	mov	dx,3
@@:	inc	al
	inc	ah
	mov	cx,DESTW/2
	rep	stosw
	dec	dx
	jg	@B

	inc	al
	inc	ah
	mov	cx,DESTW*(WINH/2/4)/2
	rep	stosw

	inc	al
	inc	ah
	mov	cx,DESTW*(WINH/2/4)/2
	rep	stosw

	inc	al
	inc	ah
	mov	cx,DESTW*(WINH/2/2+2)/2
	rep	stosw




	mov	es,ss:imgbufseg		;ES=*Img data
	mov	fs,ss:scrnbufseg	;FS=*DMAQ buffer


	mov	di,2
	jmp	strt


;---

facelp:
	mov	si,di
	add	si,2			;SI=*Base XY words


					;>Find lowest & highest XY of face
	mov	cx,7fffh		;Init lowest
	mov	dx,cx
	not	dx			;Init highest

	mov	prtx,cx			;Lowest X
	mov	temp2,dx		;Highest X
	mov	temp3,cx		;Lowest Y
	mov	temp4,dx		;Highest Y
	mov	bx,4
;	jmp	sstrt
sortlp:
	mov	ax,WPTR fs:[si]		;X
	cmp	ax,prtx
	jge	xbig
	mov	prtx,ax			;New low
	mov	blfo_p,si
xbig:
	cmp	ax,temp2
	jle	xsml
	mov	temp2,ax		;New high
xsml:
	mov	ax,WPTR fs:2[si]	;Y
	cmp	ax,temp3
	jge	ybig
	mov	temp3,ax		;New low
ybig:
	cmp	ax,temp4
	jle	ysml
	mov	temp4,ax		;New high
ysml:
	add	si,4

sstrt:
	dec	bx
	jg	sortlp

	sub	si,4
	mov	lastfo_p,si


	cmp	prtx,160
	jge	nxtf			;Lowest X off screen?
	cmp	temp2,-160
	jle	nxtf			;Highest X off screen?

	cmp	temp3,WINH
	jge	nxtf			;Lowest Y off screen?
	cmp	temp4,-1
	jle	nxtf			;Highest Y off screen?

	mov	cx,temp2
	mov	ax,cx
	sub	cx,prtx
;	jz	nxtf			;Width of 1?

	sub	ax,159
	jle	@F
	sub	cx,ax			;-extra rgt
@@:	inc	cx			;Main loop cnt
	mov	facelinecnt,cx

	mov	ax,fs:[di]		;Color/Mode
	mov	prtcolors,ax
	add	di,2
	mov	firstfo_p,di

	TST	ah
	jz	noimg			;0=Solid color

;DEBUG - For no textures
;	CLR	ah
;	mov	prtcolors,ax
;	jmp	noimg

					;>Texture calc
	movzx	eax,al
	mov	bx,txtrimg_t[eax*2]
	TST	bx
	jz	noimg

	mov	eax,WPTR ss:[bx].IMAGE.oset
	mov	img_p,eax

	CLR	eax
	mov	imgx,eax
	mov	imgy,eax
;	mov	img_p,eax


;	mov	bx,ilselected
;	TST	bx
;	jl	noimg
;	imul	bx,sizeof IMAGE
;	add	bx,offset imghdr_t

;ZZZ

	push	bx

	mov	ax,ss:[bx].IMAGE.xsize	;Data width
	mov	cx,ax
	add	ax,3
	and	al,0fch
	mov	imgdataw,ax
	mov	ax,cx
	shl	eax,16
	mov	cx,fs:4[di]		;X2
	sub	cx,fs:[di]		;X
	inc	cx
	jz	@F
	cdq
	movzx	ecx,cx
	idiv	ecx
@@:
	mov	imgxadd2,eax

	pop	bx
;	push	ecx

	mov	ax,ss:[bx].IMAGE.ysize
	shl	eax,16

	mov	imgh,eax


noimg:

	mov	bx,blfo_p
	mov	tlfo_p,bx
	mov	ax,fs:[bx]		;Get pt X
	mov	blinexlast,ax
	mov	tlinexlast,ax
	mov	ax,fs:2[bx]		;Get pt Y
	shl	eax,16
	mov	blineylast,eax
	mov	tlineylast,eax

	mov	blinecnt,1
	mov	tlinecnt,1
;---

linelp:
	dec	blinecnt
	jg	blok

getx:	mov	bx,blfo_p
	sub	bx,4
	cmp	bx,firstfo_p
	jae	@F
	mov	bx,lastfo_p
@@:	mov	blfo_p,bx
	mov	cx,fs:[bx]		;Get pt X
	mov	dx,blinexlast		;Last X
	mov	blinexlast,cx
	mov	blinex,dx
	sub	cx,dx
;	jz	getx
	jl	nxtf
	inc	cx
	mov	blinecnt,cx

	mov	ax,fs:2[bx]		;Get pt Y
	shl	eax,16
	mov	edx,blineylast		;Last Y
	mov	blineylast,eax
	mov	bliney,edx
	sub	eax,edx
	cdq
	movzx	ecx,cx
	idiv	ecx
byaz:	mov	blineyadd,eax
blok:

	dec	tlinecnt
	jg	tlok

getx2:	mov	bx,tlfo_p
	add	bx,4
	cmp	bx,lastfo_p
	jbe	@F
	mov	bx,firstfo_p
@@:	mov	tlfo_p,bx
	mov	cx,fs:[bx]		;Get pt X
	mov	dx,tlinexlast		;Last X
	mov	tlinexlast,cx
	mov	tlinex,dx
	sub	cx,dx
;	jz	getx2
	jl	nxtf
	inc	cx
	mov	tlinecnt,cx

	mov	ax,fs:2[bx]		;Get pt Y
	shl	eax,16
	mov	edx,tlineylast		;Last Y
	mov	tlineylast,eax
	mov	tliney,edx
	sub	eax,edx
	cdq
	movzx	ecx,cx
	idiv	ecx
	mov	tlineyadd,eax
tlok:

	mov	eax,blineyadd
	add	bliney,eax
	mov	eax,tlineyadd
	add	tliney,eax


	cmp	prtx,-160
	jl	nxtl


	mov	cx,WPTR tliney+2
	cmp	cx,WPTR bliney+2
	jg	nxtf			;Face flipped?

	cmp	cx,WINH
	jge	nxtl


	cmp	BPTR prtcolors+1,0
	jg	tex			;Texture?

	TST	cx
	jge	tlyok			;Line y start ok?
	jmp	ccx

tex:
	mov	ax,img_p
	mov	imgl_p,ax

	mov	eax,imgh
	mov	cx,WPTR bliney+2
	sub	cx,WPTR tliney+2
	inc	cx
	jz	@F
	movzx	ecx,cx
	CLR	edx
	div	ecx
@@:	mov	imgyadd,eax

	mov	cx,WPTR tliney+2
	TST	cx
	jge	tlyok			;Line y start ok?

	neg	cx			;>Do top clipping
;	mov	eax,imgyadd
	movzx	ecx,cx
	imul	ecx
	sar	eax,16
	imul	imgdataw		;Next texture pixel
	add	imgl_p,ax

ccx:	CLR	cx
tlyok:


	mov	ax,DESTW
	mul	cx
	mov	tempcnt,ax		;Y offset

	mov	ax,WPTR bliney+2
	cmp	ax,WINH-1
	jle	@F
	mov	ax,WINH-1
@@:
	TST	ax
	jl	nxtl

	push	di

	sub	cx,ax
	neg	cx
	inc	cx
	push	cx

	mov	cx,prtx
	add	cx,160
	mov	di,cx			;X

	shr	di,2			;/4
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	mov	dx,SC_INDEX
	out	dx,ax

	add	di,vidpgoffset

	add	di,tempcnt		;+Y

	pop	cx			;Height

	mov	ax,prtcolors
	TST	ah
	jg	texmode			;Texture?


;@@:
;	mov	gs:[di],al		;Write pixel
;
;	add	di,DESTW
;	dec	cx
;	jg	@B

					;>Draw a mono colored line
	shr	cx,1
	jnc	fllp

	mov	gs:[di],al		;Write pixel

	jz	flend			;Only 1?

	add	di,DESTW

fllp:
	mov	gs:[di],al		;Write pixel
	mov	gs:DESTW[di],al

	add	di,DESTW*2
	dec	cx
	jg	fllp


flend:	pop	di			;Used??

	jmp	nxtl2


texmode:				;>Draw textured line
	push	si
	mov	si,imgl_p		;Get int
	mov	ebx,imgy
;	mov	eax,imgx
;	mov	imgxtmp,eax
@@:
	mov	al,es:[si]		;Get pixel
	TST	al
	jz	zpix

	mov	gs:[di],al		;Write pixel

zpix:	add	di,DESTW

	mov	edx,ebx
	add	ebx,imgyadd
	mov	eax,ebx

	sar	eax,16
	sar	edx,16
	sub	ax,dx
	jle	samepix
npix:
	add	si,imgdataw		;Step to next texture pixel
	dec	al
	jg	npix
samepix:

	dec	cx
	jg	@B

	pop	si

	pop	di			;Used??

nxtl:
	cmp	BPTR prtcolors+1,0
	jz	nxtl2			;No texture?

;	mov	eax,imgyadd2
;	add	imgyadd,eax

;	mov	ebx,imgy
;	mov	edx,ebx
;	add	ebx,imgyadd2
;	sar	ebx,16
;	sar	edx,16
;	sub	bx,dx
;	jle	samepix2
;
;	mov	ax,imgdataw		;Next texture pixel
;npix2:
;	add	img_p,ax
;	dec	bx
;	jg	npix2
;samepix2:
	mov	eax,imgx		;Next texture X
	mov	edx,eax
	add	eax,imgxadd2
	mov	imgx,eax
	sar	eax,16
	sar	edx,16
	sub	ax,dx
	add	img_p,ax

nxtl2:
	inc	prtx
	dec	facelinecnt
	jg	linelp			;More lines?


nxtf:	mov	di,lastfo_p
	add	di,4

strt:
	dec	WPTR fs:0
	jge	facelp			;!End?


x:

	popa
	ret

 SUBEND





	if	0
HSTSEG	equ	0d700h
HSTDATA	equ	0
HSTCTL	equ	0d00h
HSTADRL	equ	0e00h
HSTADRH	equ	0f00h
	else
HSTDATA	equ	280h
HSTCTL	equ	1280h
HSTADRL	equ	2280h
HSTADRH	equ	3280h
	endif

;********************************
;* Set host port address
;* EAX=Ptr
;* Trashes AX

 SUBRP	host_setaddr2

	push	ds
	push	dx

	push	ax

					;>Mem mapped
;	mov	ax,HSTSEG
;	mov	ds,ax
;
;	mov	WPTR ds:HSTCTL,2000h
;@@:	test	WPTR ds:HSTCTL,2
;	jz	@B
;
;	mov	WPTR ds:HSTCTL,0
;
;	pop	ax
;
;	mov	ds:HSTADRL,ax
;	shr	eax,16
;	mov	ds:HSTADRH,ax

					;IO mapped
	mov	dx,HSTCTL
	mov	ax,2000h
	out	dx,ax

@@:	in	ax,dx
	test	al,2
	jz	@B

	CLR	ax
	out	dx,ax

	pop	ax

	mov	dx,HSTADRL
	out	dx,ax

	mov	dx,HSTADRH
	shr	eax,16
	out	dx,ax


	pop	dx
	pop	ds
	ret
 SUBEND



	endif





	end
