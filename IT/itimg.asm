;**************************************************************
;*
;* Software:		Shawn Liptak
;* Initiated:		6/2/92
;*
;* Modified:		1/18/94 - Split from itos
;*
;* COPYRIGHT (C) 1992,1993,1994 WILLIAMS ELECTRONICS GAMES, INC.
;*
;*.Last mod - 7/18/94 17:28
;**************************************************************
	option	casemap:none
	.386P
	.model	flat,syscall,os_os2

	include	wmpstruc.inc
	include	it.inc

SLGAME	equ	0

	.code
	externdef	_3d_editorinit:near

;OS functions

	externdef	scr_clr:near
	externdef	main_draw:near
	externdef	main_redraw:near
	externdef	main_exit:near
	externdef	help_main:near
	externdef	test_main:near
	externdef	msgbox_open:near
	externdef	strbox_open:near
	externdef	file_renamebkup:near
	externdef	filereq_open:near
	externdef	filereq_getnxtmrkd:near
	externdef	gad_draw:near
	externdef	gad_drawall:near
	externdef	gad_mousescroller:near
	externdef	palblk_init:near
	externdef	palblk_draw:near
	externdef	palblk_prtinfo:near
	externdef	palblk_setvgapal:near
	externdef	palblk_togtruc:near
	externdef	prt:near
	externdef	prtf6:near
	externdef	prt_dec:near
	externdef	prt_dec3srj:near
	externdef	prt_spc:near
	externdef	prt_binword:near
	externdef	prt_hexword:near
	externdef	box_drawshaded:near
	externdef	boxh_drawclip:near
	externdef	line_draw:near
	externdef	mem_alloc:near
	externdef	mem_free:near
	externdef	mem_copy:near
	externdef	mem_duplicate:near
	externdef	crossh_draw:near
	externdef	crossh_drawsml:near
	externdef	strsrch:near
	externdef	strcpy:near
	externdef	strcpylen:near
	externdef	stritoa:near
	externdef	striltoa:near
	externdef	stradddefext:near
	externdef	strwrite:near
	externdef	vid_setvmode:near
	externdef	waiton_keyormouse:near
	externdef	host_dumpslavemem:near

	if	SLGAME
	externdef	g_run:near
	endif

	.data
	externdef	menu_p:dword
	externdef	gadlstmain_p:dword
	externdef	gadlst_p:dword
	externdef	gadfuncmain_p:dword
	externdef	gadfunc_p:dword
	externdef	key_p:dword
	externdef	maindraw_p:dword
	externdef	cfgstruc:CFG

	externdef	progname2_s:byte
	externdef	mpfree:dword

	externdef	fmode:byte
	externdef	fpath_s:byte
	externdef	fname_s:byte
	externdef	fnametmp_s:byte

	externdef	prtbuf_s:byte
	externdef	font_t:byte
	externdef	font6_t:byte
	externdef	load_s:byte
	externdef	rerror_s:byte
	externdef	rusure_s:byte
	externdef	fileerr:byte

	externdef	pal_t:
	externdef	palmap_t:
	externdef	palbrmult:byte
	externdef	palbgmult:byte
	externdef	palbbmult:byte
	externdef	palbtruc:byte
	externdef	palb1stc:byte
	externdef	palblastc:byte
	externdef	palblastuc:byte

	externdef	drawclipy:word

	externdef	mousex:word
	externdef	mousey:word
	externdef	mousebut:byte
	externdef	mousebchg:byte

	externdef	prtcolors:word

	externdef	linex2:dword
	externdef	liney2:dword


	.data

ilstfunc_s	db	"Name         AX  AY   A2X A2Y A2Z",0
a3box_s		db	"A3X A3Y  A3Z  ID",0
forgetit_s	db	"FORGET IT!",0
append_s	db	"APPEND",0
save_s		db	"SAVE",0
smlconv_s	db	"Old small model converted to large.",0
bogusfv_s	db	"Bogus file version!",0
werror_s	db	"Write error, you must resave!",0

crlf_s		db	13,10,0

fmatch_s	db	"*.*",0,0,0,0,0,0,0,0
fmatchimg_s	db	"*.IMG",0,0,0,0,0,0,0,0
fmatchbin_s	db	"*.BIN",0,0,0,0,0,0,0,0
fmatchlbm_s	db	"*.LBM",0,0,0,0,0,0,0,0
fmatchtga_s	db	"*.TGA",0,0,0,0,0,0,0,0

imgext_s	db	".IMG",0

form_s		db	"FORM"
pbm_s		db	"PBM "
bmhd_s		db	"BMHD"
		db	0,0,0,20	;BMHD len
cmap_s		db	"CMAP"
		db	0,0,3,0		;CMAP len
body_s		db	"BODY"
anf_s		db	"ANF "


	.data?

	BSSB	imgmodeinit		;1=Have been initialized

	align	4

	BSS	buf	,64*1024	;Temp buffer
	BSS	tmp_s	,84		;Temp string

	BSSW	tw1			;Temp value
	BSSW	tw2			;^
	BSSW	tw3			;^
	BSSW	tw4			;^
	BSSW	tw5			;^
	BSSW	tw6			;^
	align	4

	BSSD	tl1			;Temp long
	BSSD	tl2			;^ (must follow 1)
	BSSD	tl3			;^
	BSSD	tl4			;^
	BSSD	tl5			;^

	BSSW	rawbits			;Bit buffer for raw write
	BSSB	bitshift		;Raw write bit shift
	BSSB	fileerr			;!0=Error during load/save
	BSSB	aniptmode		;Anipt editing mode (1-7)
	align	4

	BSSD	prtx			;X print pos
	BSSD	prty			;Y print pos
	BSSW	prtyo			;Y print pos offset
	align	4

	BSSD	bndboxx1		;Bounding box X1
	BSSD	bndboxy1		;^ Y1
	BSSD	bndboxx2		;^ X2
	BSSD	bndboxy2		;^ Y2

	BSSD	mpboxselect		;# of selected mpart box (0 to MAX-1)
	BSSB	mpboxon			;!0=Mpart box mode on
	align	4

	BSSB	cboxon			;!0=Collision box mode on
	align	4

	BSSW	iwincx			;Image win center X
	BSSW	iwincy			;^ Y
	BSSW	iwinsclx		;Iwin scale X 8:8
	BSSW	iwinscly		;^ Y
	BSSW	iwinrx			;Image win ref X (-1=off)
	BSSW	iwinry			;^ Y
	BSSB	iwinanipton		;!0=Show anipts
	align	4

	BSSW	anipt2x			;Current scrn X of anipt 2
	BSSW	anipt2y			;^ Y
	BSSB	ani2link		;!0=Draw 2nd at 1st ani2
	BSSB	drawpri			;!0=Draw 2nd list last
	align	4

	BSSDX	img_p			;* 1st IMG structure or 0
	BSSD	imgcnt			;# of IMG strucs (0-?)
	BSSD	imgdataw		;Current img # bytes per line
	BSSD	ilselected		;# of selected img (0 - cnt-1) or -1
	BSSD	il1stprt		;1st entry to print (0 - cnt-1)
	BSSD	ilpalloaded		;Pal # loaded or -1 (by ilst)
	BSSD	img2_p			;* 1st IMG structure or 0
	BSSD	img2cnt			;# of IMG strucs (0-?)
	BSSD	il2selected		;# of selected img (0 - cnt-1) or -1
	BSSD	il21stprt		;1st entry to print (0 - cnt-1)
	BSSW	imgfileh		;File handle for loads and saves
	align	4

lib_hdr		LIB_HDR	{?}
imagetmp	IMAGE	{<>}

animscr_t	SEQSCR	1 dup (<>)	;Temp
animseq_t	SEQSCR	1 dup (<>)
ssentry_t	ENTRY	16 dup (<>)	;Temp

	BSSD	scrcnt			;# of scripts (0-?)
	BSSD	seqcnt			;# of sequences (0-?)
	BSSD	scrseqbytes		;# bytes used in scr&seq_t
	BSSD	scrseqmem_p		;* to scr & seq

	BSSD	damcnt			;# of damage tables (0-?)
	align	4

	BSSD	pal_p			;* 1st PAL structure or 0
	BSSD	palcnt			;# of palettes (0-?)
	BSSDX	plselected		;# of selected pal (0 - MAX-1) or -1
	BSSD	pl1stprt		;1st entry to print (0 - MAX-1)
	align	4

palettetmp	PALETTE	{<>}

	align	4

tga_hdr		TGAHDR	{?}
bmhd		BMHD	{?}



	.data
	align	4



main_menu\
	MENU	{ @F, 9*8, main_s, main_mi, 11*8 }
main_s	db	"Main",0
main_mi	MENUI	{ m1_s,main_exit_stub }
	MENUI	{ m2_s,main_clear }
	MENUI	{ m3_s,main_loadi }
	MENUI	{ m4_s,main_appendi }
	MENUI	{ m5_s,main_savei }
	MENUI	{ m6_s,help_main_stub }
	MENUI	{ m7_s,main_saveiraw }
	dd	0
m1_s	db	"EXIT (ESC)",0
m2_s	db	"CLEAR",0
m3_s	db	"LOAD (l)",0
m4_s	db	"APPEND",0
m5_s	db	"SAVE (s)",0
m6_s	db	"HELP (h)",0
m7_s	db	"RAW SAVE",0
@@:
	MENU	{ @F, 10*8, mis_s, mis_mi, 15*8 }
mis_s	db	"In/Out",0
mis_mi	MENUI	{ mis1_s,ilst_loadlbm }
	MENUI	{ mis2_s,ilst_savelbm }
	MENUI	{ mis2b_s,ilst_savelbmmrkd }
	MENUI	{ mis3_s,ilst_loadtga }
	MENUI	{ mis4_s,ilst_savetga }
	dd	0
mis1_s	db	"LOAD LBM (A-l)",0
mis2_s	db	"SAVE LBM (A-s)",0
mis2b_s	db	"SAVE MRKD LBM",0
mis3_s	db	"LOAD TGA (C-l)",0
mis4_s	db	"SAVE TGA (C-s)",0
@@:
	MENU	{ @F, 8*8, i_s, i_mi, 20*8 }
i_s	db	"Image",0
i_mi	MENUI	{ i1_s,ilst_rename }
	MENUI	{ i2_s,ilst_delete }
	MENUI	{ i3_s,ilst_setpal }
	MENUI	{ i4_s,ilst_duplicate }
	MENUI	{ i5_s,ilst_pttblchng }
	dd	0
i1_s	db	"RENAME (C-r)",0
i2_s	db	"DELETE (C-d)",0
i3_s	db	"SET PALETTE",0
i4_s	db	"DUPLICATE",0
i5_s	db	"ADD/DEL PTTBL (C-p)",0
@@:
	MENU	{ @F, 12*8, mi_s, mi_mi, 20*8 }
mi_s	db	"Mrkd image",0
mi_mi	MENUI	{ mi1_s,ilst_renamemrkd }
	MENUI	{ mi2_s,ilst_deletemrkd }
	MENUI	{ mi3_s,ilst_setpalmrkd }
	MENUI	{ mi4_s,ilst_stripmrkd }
	MENUI	{ mi4b_s,ilst_striplowmrkd }
	MENUI	{ mi4c_s,ilst_striprngmrkd }
	MENUI	{ mi5_s,ilst_leastsqmrkd }
	MENUI	{ mi6_s,ilst_ditherrepmrkd }
	MENUI	{ mi7_s,ilst_buildtgamrkd }
	dd	0
mi1_s	db	"RENAME",0
mi2_s	db	"DELETE",0
mi3_s	db	"SET PALETTE",0
mi4_s	db	"STRIP EDGE",0
mi4b_s	db	"STRIP EDGE LOW",0
mi4c_s	db	"STRIP EDGE RNG",0
mi5_s	db	"LEAST SQUARE",0
mi6_s	db	"DITHER REPLACE",0
mi7_s	db	"BUILD TGA (C-b)",0
@@:
	MENU	{ @F, 8*8, pal_s, pal_mi, 20*8 }
pal_s	db	"Pal",0
pal_mi	MENUI	{ pal1_s,plst_rename }
	MENUI	{ pal2_s,plst_merge }
	MENUI	{ pal3_s,plst_duplicate }
	MENUI	{ pal4_s,plst_histogram }
	MENUI	{ pal5_s,plst_delunusedcols }
	dd	0
pal1_s	db	"RENAME",0
pal2_s	db	"MERGE",0
pal3_s	db	"DUPLICATE",0
pal4_s	db	"SHOW HISTOGRAM",0
pal5_s	db	"DEL UNUSED COLS",0
@@:
	MENU	{ @F, 7*8, mrk_s, mrk_mi, 20*8 }
mrk_s	db	"Marks",0
mrk_mi	MENUI	{ mrk1_s,ilmrk_clrall }
	MENUI	{ mrk2_s,ilmrk_setall }
	MENUI	{ mrk3_s,ilmrk_invertall }
	MENUI	{ mrk4_s,plmrk_clrall }
	MENUI	{ mrk5_s,plmrk_setall }
	MENUI	{ mrk6_s,plmrk_invertall }
	dd	0
mrk1_s	db	"CLR ALL IMG (m)",0
mrk2_s	db	"SET ALL IMG (M)",0
mrk3_s	db	"INVERT ALL IMG",0
mrk4_s	db	"CLR ALL PAL",0
mrk5_s	db	"SET ALL PAL",0
mrk6_s	db	"INVERT ALL PAL",0
@@:
	MENU	{ 0, 5*8, p_s, p_mi, 15*8 }
p_s	db	"Prog",0
p_mi	MENUI	{ p1_s,host_dumpslavemem_stub }
	MENUI	{ p2_s,ilst_wanilstmrkd }
	dd	0
p1_s	db	"DUMP SLAVE",0
p2_s	db	"WRITE ANILST",0


	align	4


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

ILSTID		equ	000h
IWINID		equ	100h
PLSTID		equ	200h
PALBID		equ	300h
MPBID		equ	400h
CBID		equ	500h


main_gad	equ	$

	GAD	{ @F, 0,0, 320,200, 0, 0, GADF_MV+GADF_UP, IWINID }
@@:
	GAD	{ @F, 210,200, 13,11, c1_wh, c4arr_s, GADF_DN, IWINID+8 }
@@:
	GAD	{ @F, 254,200, 13,11, c1_wh, c4arr_s, GADF_DN, IWINID+10h }


PLSTX	equ	0
PLSTY	equ	200
PLSTW	equ	15*8
PLSTH	equ	110
PLSTROW	equ	12
@@:
	GAD	{ @F, PLSTX,PLSTY, 12*8,PLSTH, plst_wh, 0, GADF_MV+GADF_MVR, PLSTID }
plst_wh	word	PLSTW,PLSTH

;@@:
;	GAD	{ @F, PLSTX+PLSTW,PLSTY+50, 13,11, c1_wh, c4arr_s, GADF_DN, PLSTID+20h }
;@@:
;	GAD	{ @F, 306,200, 13,11, c1_wh, cM_s, GADF_DN, PLSTID+30h }

PALBX	equ	184
PALBY	equ	240
PALBW	equ	8*16
PALBH	equ	8*16
@@:
	GAD	{ @F, PALBX,PALBY, PALBW,PALBH, 0, 0, GADF_MV+GADF_MVR, PALBID }
@@:
	GAD	{ @F, PALBX-21,PALBY, 13,11, c1_wh, cL_s, GADF_DN, PALBID+20h }
@@:
	GAD	{ @F, PALBX-21,PALBY+15, 13,11, c1_wh, cS_s, GADF_DN, PALBID+21h }
@@:
	GAD	{ @F, PALBX-50,PALBY, 13,11, c1_wh, cM_s, GADF_DN+GADF_DNR, PALBID+60h }
@@:
	GAD	{ @F, PALBX-50,PALBY+50, 13,11, c1_wh, cup_s, GADF_DN+GADF_DNR, PALBID+40h }
@@:
	GAD	{ @F, PALBX-50,PALBY+70, 13,11, c1_wh, cdn_s, GADF_DN+GADF_DNR, PALBID+41h }
@@:
	GAD	{ @F, PALBX-34,PALBY+50, 13,11, c1_wh, cup_s, GADF_DN+GADF_DNR, PALBID+44h }
@@:
	GAD	{ @F, PALBX-34,PALBY+70, 13,11, c1_wh, cdn_s, GADF_DN+GADF_DNR, PALBID+45h }
@@:
	GAD	{ @F, PALBX-18,PALBY+50, 13,11, c1_wh, cup_s, GADF_DN+GADF_DNR, PALBID+48h }
@@:
	GAD	{ @F, PALBX-18,PALBY+70, 13,11, c1_wh, cdn_s, GADF_DN+GADF_DNR, PALBID+49h }
@@:
	GAD	{ @F, PALBX-52,PALBY+90, 21,11, c2_wh, CO_s, GADF_DN, PALBID+38h }
@@:
	GAD	{ @F, PALBX-26,PALBY+90, 21,11, c2_wh, BR_s, GADF_DN, PALBID+30h }
@@:
	GAD	{ @F, PALBX-50,PALBY+106, 13,11, c1_wh, cup_s, GADF_DN+GADF_DNR, PALBID+50h }
@@:
	GAD	{ @F, PALBX-50,PALBY+126, 13,11, c1_wh, cdn_s, GADF_DN+GADF_DNR, PALBID+51h }
@@:
	GAD	{ @F, PALBX-34,PALBY+106, 13,11, c1_wh, cup_s, GADF_DN+GADF_DNR, PALBID+54h }
@@:
	GAD	{ @F, PALBX-34,PALBY+126, 13,11, c1_wh, cdn_s, GADF_DN+GADF_DNR, PALBID+55h }
@@:
	GAD	{ @F, PALBX-18,PALBY+106, 13,11, c1_wh, cup_s, GADF_DN+GADF_DNR, PALBID+58h }
@@:
	GAD	{ @F, PALBX-18,PALBY+126, 13,11, c1_wh, cdn_s, GADF_DN+GADF_DNR, PALBID+59h }

ILSTX	equ	320
ILSTY	equ	223
ILSTW	equ	316
ILSTH	equ	173
ILSTROW	equ	19
@@:
	GAD	{ @F, ILSTX,ILSTY, 12*8,ILSTH, ilst_wh, 0, GADF_MV+GADF_MVR, ILSTID }
ilst_wh	word	ILSTW,ILSTH

@@:
	GAD	{ @F, 290,200, 13,11, c1_wh, c4arr_s, GADF_DN, ILSTID+20h }
@@:
	GAD	{ @F, 306,200, 13,11, c1_wh, cM_s, GADF_DN, ILSTID+30h }
@@:
	GAD	{ @F, 290,214, 13,11, c1_wh, c4arr_s, GADF_DN, ILSTID+40h }

AFBOXX	equ	486
AFBOXY	equ	110

@@:
	GAD	{ @F, AFBOXX,AFBOXY, 16*8+4,13, c16_wh, 0, GADF_DN, ILSTID+80h }

;CBOXX	equ	486
;CBOXY	equ	130
;
;@@:
;	GAD	{ @F, CBOXX+18,CBOXY+4, 13,11, c1_wh, clrarr_s, GADF_DN, ILSTID+0a0h }
;@@:
;	GAD	{ @F, CBOXX+58,CBOXY+4, 13,11, c1_wh, clrarr_s, GADF_DN, ILSTID+0a2h }
;@@:
;	GAD	{ @F, CBOXX+98,CBOXY+4, 13,11, c1_wh, clrarr_s, GADF_DN, ILSTID+0a4h }

A3BOXX	equ	486
A3BOXY	equ	170

@@:
	GAD	{ @F, A3BOXX+34,A3BOXY+4, 13,11, c1_wh, c4arr_s, GADF_DN, ILSTID+50h }
@@:
	GAD	{ @F, A3BOXX+88,A3BOXY+4, 13,11, c1_wh, clrarr_s, GADF_DN, ILSTID+52h }
@@:
	GAD	{ @F, A3BOXX+122,A3BOXY+4, 13,11, c1_wh, clrarr_s, GADF_DN, ILSTID+54h }


MPBBOXX	equ	320
MPBBOXY	equ	160
X=MPBBOXX
Y=MPBBOXY

@@:
	GAD	{ @F, X,Y, 8*2,11, c1_wh, mpbsel_s, GADF_DN, MPBID }
@@:
	GAD	{ @F, X+8*3,Y, 8*4,11, c3_wh, del_s, GADF_DN, MPBID+10h }
@@:
mpboo_gad\
	GAD	{ @F, X+8*8,Y, 8*4,11, c3_wh, mpboff_s, GADF_DN, MPBID+20h }
mpbsel_s	db	"0",0
mpboff_s	db	"Off",0
mpbon_s		db	"On",0


CBBOXX	equ	320
CBBOXY	equ	175
X=CBBOXX
Y=CBBOXY

@@:
	GAD	{ @F, X,Y, 8*4,11, c3_wh, del_s, GADF_DN, CBID }
@@:
cboo_gad\
	GAD	{ @F, X+8*5,Y, 8*4,11, c3_wh, cboff_s, GADF_DN, CBID+20h }
cboff_s	db	"Off",0
cbon_s	db	"On",0
@@:
	GAD	{ 0, X+8*10,Y, 8*5,11, c4_wh, cbcpy_s, GADF_DN, CBID+30h }
cbcpy_s	db	"Copy",0


c1_wh	word	11,9
c2_wh	word	2*8+4,9
c3_wh	word	3*8+4,9
c4_wh	word	4*8+4,9
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
cL_s	db	"L",0
cM_s	db	"M",0
cS_s	db	"S",0
BR_s	db	"BR",0
CO_s	db	"CO",0
del_s	db	"DEL",0

	align	4




gadfunc_t\			;Routines for button on gads
	dd	ilst_gads
	dd	iwin_gads
	dd	plst_gads
	externdef	palblk_gads:near
	dd	palblk_gads
	dd	mpbox_gads
	dd	cbox_gads




WD	macro	W,D
	dw	W
	dd	D
	endm


key_t	equ	$			;Routines for main key presses
	WD	27,main_exit		;Esc
	WD	'h',help_main
	WD	7ch,test_main		;|
	WD	'l',main_loadi
	WD	's',main_savei
	WD	'f',main_redraw
	WD	'F',vid_setvmode
	WD	'd',iwin_keys
	WD	'D',iwin_keys
	WD	'r',iwin_keys
	WD	't',palblk_togtruc
	WD	'T',iwin_keys
	WD	'2',iwin_keys
	WD	'p',iwin_keys
	WD	3b00h,_3d_editorinit	;F1
	WD	4100h,ilst_keys		;F7
	WD	4200h,ilst_keys		;F8
	WD	8500h,iwin_keys		;F11
	WD	8600h,iwin_keys		;F12
	WD	4800h,ilst_kup		;Up
	WD	5000h,ilst_kdn		;Dn
	WD	4b00h,ilst_keys		;Lft
	WD	4d00h,ilst_keys		;Rgt
	WD	4900h,ilst_kpup		;Pgup
	WD	5100h,ilst_kpdn		;Pgdn
	WD	9900h,ilst_moveup	;Alt pgup
	WD	0a100h,ilst_movedn	;Alt pgdn
	WD	9800h,ilst_keys		;Alt up
	WD	0a000h,ilst_keys	;Alt dn
	WD	9b00h,ilst_keys		;Alt lft
	WD	9d00h,ilst_keys		;Alt rgt
	WD	8d00h,ilst_keys		;Ctrl up
	WD	9100h,ilst_keys		;Ctrl dn
	WD	7300h,ilst_keys		;Ctrl lft
	WD	7400h,ilst_keys		;Ctrl rgt
	WD	7700h,ilst_keys		;Ctrl home
	WD	7500h,ilst_keys		;Ctrl end
	WD	9300h,ilst_keys		;Ctrl del
	WD	19h,ilst_keys		;Ctrl y
	WD	1ah,ilst_keys		;Ctrl z
	WD	2e00h,ilst_clrxdata	;Alt c
	WD	12h,ilst_rename		;Ctrl r
	WD	4,ilst_delete		;Ctrl d
	WD	2,ilst_buildtgamrkd	;Ctrl b
	WD	10h,ilst_pttblchng	;Ctrl p
	WD	2600h,ilst_loadlbm	;Alt l
	WD	1f00h,ilst_savelbm	;Alt s
	WD	0ch,ilst_loadtga	;Ctrl l
	WD	13h,ilst_savetga	;Ctrl s
;	WD	'-',ilst_keys
;	WD	'+',ilst_keys
	WD	9,ilst_nxtlstkey	;Tab
	WD	'i',ilst_setidfmnxtlst
	WD	'a',ilst_keys
	WD	' ',ilst_keys
	WD	'm',ilmrk_clrall
	WD	'M',ilmrk_setall
	WD	"'",plst_kup		;
	WD	'/',plst_kdn		;
	WD	'"',plst_kpup		;
	WD	'?',plst_kpdn		;
	if	SLGAME
	WD	2900h,g_run		;Alt `
	endif
	word	-1




;****************************************************************
;* Stub routines to external functions so linker won't crash

 SUBRP	main_exit_stub
	jmp	main_exit
 SUBEND

 SUBRP	help_main_stub
	jmp	help_main
 SUBEND

 SUBRP	host_dumpslavemem_stub
	jmp	host_dumpslavemem
 SUBEND




;********************************
;* Image mode init
;* Trashes all non seg

 SUBR	imgmode_init

	mov	menu_p,offset main_menu
	mov	key_p,offset key_t

	mov	gadlstmain_p,offset main_gad
	mov	gadlst_p,offset main_gad

	mov	gadfuncmain_p,offset gadfunc_t
	mov	gadfunc_p,offset gadfunc_t

	mov	maindraw_p,offset scrn_update

	cmp	imgmodeinit,1
	je	@F
	mov	imgmodeinit,1

	call	img_clearall

	lea	ebx,cfgstruc

	lea	eax,[ebx].CFG.IPN_s
	cmp	BPTR [eax],0
	je	@F
	lea	edi,fpath_s
	call	strcpy

	lea	eax,[ebx].CFG.IFN_s
	lea	edi,fname_s
	call	strcpy

	cmp	DPTR [edi-3],'GMI'
	jne	@F				;!.IMG?

	lea	edx,fpath_s
	I21SETCD

	call	img_load

@@:

	mov	ax,cfgstruc.COL0
	mov	pal_t,ax


	jmp	main_draw

 SUBEND


;********************************
;* Setup data in cfgstruc for save
;* Trashes none

 SUBRP	imgmode_setcfg

	pushad

	lea	edx,cfgstruc

	mov	ax,pal_t
	mov	[edx].CFG.COL0,ax

	mov	ax,iwincx
	mov	[edx].CFG.IWCX,ax
	mov	ax,iwincy
	mov	[edx].CFG.IWCY,ax

	lea	eax,fpath_s
	lea	edi,[edx].CFG.IPN_s
	call	strcpy

	lea	eax,fname_s
	lea	edi,[edx].CFG.IFN_s
	call	strcpy

	popad
	ret
 SUBEND


;********************************
;* Draw main screen

 SUBRP	scrn_update


;	mov	ax,124			;Main box
;	mov	bx,20
;	mov	cx,MAINX
;	mov	dx,MAINY
;	call	box_drawshaded



	call	palblk_draw
	call	palblk_prtinfo


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

	mov	eax,imgcnt
	mov	cx,13*8
	call	prt_dec3srj


	mov	esi,offset progname2_s
	mov	bx,0feffh
	CLR	ecx
	mov	dx,392
	call	prt

	mov	esi,offset ilstfunc_s
	mov	bx,0feffh
	mov	cx,ILSTX+12
	mov	dx,ILSTY-9
	call	prt

;	mov	ax,150			;W
;	mov	bx,35			;H
;	mov	cx,CBOXX
;	mov	dx,CBOXY
;	call	box_drawshaded

;	mov	esi,offset cbox_s
;	mov	bx,0feffh
;	mov	cx,CBOXX+14
;	mov	dx,CBOXY+18
;	call	prt

	mov	ax,150			;W
	mov	bx,35			;H
	mov	cx,A3BOXX
	mov	dx,A3BOXY
	call	box_drawshaded

	mov	esi,offset a3box_s
	mov	bx,0feffh
	mov	cx,A3BOXX+14
	mov	dx,A3BOXY+18
	call	prt

	call	ilst_prtaniptmode

	call	gad_drawall

	mov	eax,ilselected
	call	ilst_select

	mov	eax,plselected
	call	plst_select

	jmp	iwin_showscale


 SUBEND


;********************************
;* Main function - Clear all image data

 SUBRP	main_clear

	CLR	al
	mov	esi,offset rusure_s
	call	msgbox_open
	jnz	main_draw

	mov	fname_s,0

	call	img_clearall

	jmp	main_draw

 SUBEND


;********************************
;* Main function - load wimp image file

 SUBRP	main_loadi

	mov	eax,offset fmatchimg_s
	mov	ebx,offset img_loadnew
	mov	esi,offset load_s
	mov	fmode,2
	jmp	filereq_open

 SUBEND


;********************************
;* Main function - Append wimp image file

 SUBR	main_appendi

	mov	eax,offset fmatchimg_s
	mov	ebx,offset img_load
	mov	esi,offset append_s
	mov	fmode,2
	jmp	filereq_open

 SUBEND


;********************************
;* Main function - save wimp image file

 SUBRP	main_savei

	mov	eax,offset fmatchimg_s
	mov	ebx,offset img_save
	mov	esi,offset save_s
	jmp	filereq_open

 SUBEND


;********************************
;* Main function - save raw image data

 SUBRP	main_saveiraw

	CLR	al
	mov	esi,offset rusure_s
	call	msgbox_open			;Must be near call
	jnz	main_draw

	mov	eax,offset fmatchbin_s
	mov	ebx,offset img_saveraw
	mov	esi,offset save_s
	jmp	filereq_open


 SUBEND





;********************************
;* Clear all images, palettes and associated data
;* Trashes all non seg

 SUBRP	img_clearall

@@:	CLR	eax
	call	img_del
	cmp	img_p,0
	jne	@B				;More?

@@:	CLR	eax
	call	pal_del
	cmp	pal_p,0
	jne	@B				;More?

	mov	eax,scrseqmem_p
	call	mem_free

	CLR	eax
	mov	imgcnt,eax
	mov	palcnt,eax
	mov	seqcnt,eax
	mov	scrcnt,eax
	mov	damcnt,eax

	mov	scrseqmem_p,eax
	mov	scrseqbytes,eax

	CLR	eax
	dec	eax
	mov	ilpalloaded,eax
	mov	ilselected,eax

	call	palblk_init

	lea	ebx,cfgstruc
	mov	ax,[ebx].CFG.IWCX
	mov	iwincx,ax
	mov	ax,[ebx].CFG.IWCY
	mov	iwincy,ax

	mov	iwinsclx,100h
	mov	iwinscly,100h
	mov	iwinanipton,-1
	mov	iwinrx,-1
	mov	drawclipy,200

	mov	aniptmode,2


	ret

 SUBEND



;********************************
;* Clr existing images and load new ones

 SUBRP	img_loadnew

	call	img_clearall
	jmp	img_load

 SUBEND

;********************************
;* Load an image file

 SUBR	img_load

	local	imgoset:dword,\
		paloset:dword,\
		ptoset:dword,\
		cnt:dword,\
		palno:dword

	pushad


	mov	ilpalloaded,-1



	mov	edx,offset fname_s		;>Open read only
	I21OPENR
	jc	xx
	mov	ebx,eax				;BX=File handle
	mov	imgfileh,bx

	mov	ecx,sizeof lib_hdr		;Read lib header
	mov	edx,offset lib_hdr
	I21READ
	jc	x

	cmp	lib_hdr.TEMP,0abcdh
	jne	bogus				;Old?

	mov	ax,lib_hdr.VERSION		;Verify
	cmp	ax,634h
	jge	vok				;Large model?
	cmp	ax,632h
	jge	bogus				;Spaz model?
	cmp	ax,500h
	jge	vok

bogus:	mov	al,1
	mov	esi,offset bogusfv_s
	call	msgbox_open			;Must be near call
	jmp	x

vok:
	mov	ax,lib_hdr.IMGCNT
	dec	ax
	cmp	ax,MAX_IMG-1
	ja	x				;Too many or 0?

	CLR	eax
	mov	damcnt,eax


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Set file offset to sequences

	mov	edx,lib_hdr.OSET

	movzx	eax,lib_hdr.IMGCNT
	imul	eax,sizeof IMAGE
	add	edx,eax
	mov	paloset,edx

	movzx	eax,lib_hdr.PALCNT
	sub	eax,NUMDEFPAL			;-defaults
	jle	@F
	imul	eax,sizeof PALETTE
	add	edx,eax
@@:
	mov	tl1,edx				;Save offset

	mov	ecx,edx
	shr	ecx,16
	I21SETFPS				;Change offset
	jc	x				;Error?


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Scan sequences

	mov	scrseqbytes,0

	movsx	ecx,lib_hdr.SEQCNT
	TST	ecx
	jle	noseqs

seqlp:	push	ecx
	mov	ecx,sizeof SEQSCR
	cmp	lib_hdr.VERSION,634h
	jge	@F				;Far ptr version?
	sub	ecx,2*16+8			;Near version
@@:	add	scrseqbytes,ecx
	mov	edx,offset animseq_t
	I21READ
	pop	ecx
	jc	x				;Error?

	push	ecx
	mov	eax,sizeof ENTRY
	cmp	lib_hdr.VERSION,634h
	jge	@F				;Far ptr version?
	sub	eax,2				;Near version
@@:	movzx	ecx,animseq_t.num
	imul	ecx,eax
	add	scrseqbytes,ecx
	mov	edx,offset ssentry_t
	I21READ
	pop	ecx
	jc	x				;Error?

	loop	seqlp
noseqs:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Scan scripts

	movsx	ecx,lib_hdr.SCRCNT
	TST	ecx
	jle	noscrs

scrlp:	push	ecx
	mov	ecx,sizeof SEQSCR
	cmp	lib_hdr.VERSION,634h
	jge	@F				;Far ptr version?
	sub	ecx,2*16+8			;Near version
@@:	add	scrseqbytes,ecx
	mov	edx,offset animscr_t
	I21READ
	pop	ecx
	jc	x				;Error?

	push	ecx
	mov	eax,sizeof ENTRY
	cmp	lib_hdr.VERSION,634h
	jge	@F				;Far ptr version?
	sub	eax,2				;Near version
@@:	movzx	ecx,animscr_t.num
	imul	ecx,eax
	add	scrseqbytes,ecx
	mov	edx,offset ssentry_t
	I21READ
	pop	ecx
	jc	x				;Error?

	loop	scrlp
noscrs:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Get mem and read seq&scr

	movsx	eax,lib_hdr.SEQCNT
	mov	seqcnt,eax

	movsx	eax,lib_hdr.SCRCNT
	mov	scrcnt,eax

	cmp	img_p,0
	jne	zss				;Appending images?

	cmp	lib_hdr.VERSION,634h
	jge	@F				;New enough version?
zss:
	CLR	eax
	mov	seqcnt,eax			;Delete old small data
	mov	scrcnt,eax
	mov	scrseqbytes,eax
@@:
	cmp	scrseqbytes,0
	jle	noss

	mov	edx,tl1				;Reset scrseq offset
	mov	ecx,edx
	shr	ecx,16
	I21SETFPS
	jc	x				;Error?

	mov	eax,scrseqbytes
	call	mem_alloc
	jz	x
	mov	scrseqmem_p,eax

	mov	ecx,scrseqbytes
	mov	edx,eax
	I21READ
	jc	x				;Error?
noss:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Save offset to point tables


	CLR	edx
	CLR	ecx
	I21SETFPC				;Get current offset
	jc	x
	shl	edx,16
	mov	dx,ax
	mov	ptoset,edx


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read images and data

	mov	eax,palcnt
	mov	palno,eax

	mov	eax,lib_hdr.OSET
	mov	imgoset,eax

	movzx	eax,lib_hdr.IMGCNT
	mov	cnt,eax

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read img header

imglp:

	mov	edx,imgoset
	add	imgoset,sizeof IMAGE
	mov	ecx,edx
	shr	ecx,16
	I21SETFPS				;Change offset
	jc	x				;Error?


	call	img_alloc
	jz	x
	mov	esi,eax

	lea	edi,imagetmp

	mov	ecx,sizeof IMAGE
	mov	edx,edi
	I21READ
	jc	x				;Error?
	cmp	eax,sizeof IMAGE
	jne	x

	cmp	lib_hdr.VERSION,634h
	jge	@F				;Far ptr version?
	mov	ax,[edi].IMAGE.ANIZ2
	mov	dx,[edi].IMAGE.FRM
	mov	[edi].IMAGE.ANIZ2,dx
	mov	[edi].IMAGE.FRM,ax
	mov	[edi].IMAGE.OPALS,-1
@@:
	mov	ax,[edi].IMAGE.FLAGS
	mov	[esi].IMG.FLAGS,ax

	mov	ax,[edi].IMAGE.ANIX
	mov	[esi].IMG.ANIX,ax
	mov	ax,[edi].IMAGE.ANIY
	mov	[esi].IMG.ANIY,ax

	mov	ax,[edi].IMAGE.W
	cmp	ax,2
	ja	@F
	mov	ax,3				;Set 1 or 2 to 3
@@:	mov	[esi].IMG.W,ax

	mov	ax,[edi].IMAGE.H
	mov	[esi].IMG.H,ax

	movzx	eax,[edi].IMAGE.PALNUM
	sub	eax,NUMDEFPAL			;-defaults
	add	eax,palno
	mov	[esi].IMG.PALNUM,ax

	mov	ax,[edi].IMAGE.ANIX2
	mov	[esi].IMG.ANIX2,ax
	mov	ax,[edi].IMAGE.ANIY2
	mov	[esi].IMG.ANIY2,ax
	mov	ax,[edi].IMAGE.ANIZ2
	mov	[esi].IMG.ANIZ2,ax

	mov	ax,[edi].IMAGE.OPALS
	mov	[esi].IMG.OPALS,ax

	lea	eax,[edi].IMAGE.N_s
	lea	edi,[esi].IMG.N_s
	call	strcpy


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read img data

	mov	edx,imagetmp.OSET
	mov	ecx,edx
	shr	ecx,16
	I21SETFPS
	jc	x				;Error?

	movzx	eax,[esi].IMG.W
	add	ax,3
	and	al,0fch
	movzx	ecx,[esi].IMG.H
	imul	eax,ecx
	mov	ecx,eax				;Len

	call	mem_alloc
	jz	x
	mov	[esi].IMG.DATA_p,eax

	mov	edx,eax
	I21READ
	jc	x				;Error?


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read point table

	mov	[esi].IMG.PTTBL_p,0

	cmp	lib_hdr.VERSION,60ah
	jl	nopttbl				;Old version?
	movsx	edx,imagetmp.PTTBLNUM
	TST	edx
	jl	nopttbl

	imul	edx,sizeof PTTBL
	add	edx,ptoset
	mov	ecx,edx
	shr	ecx,16
	I21SETFPS
	jc	x				;Error?

	mov	eax,sizeof PTTBL
	mov	ecx,eax
	call	mem_alloc
	jz	x
	mov	[esi].IMG.PTTBL_p,eax

	mov	edx,eax
	I21READ
	jc	x

nopttbl:


	dec	cnt
	jg	imglp



;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read palettes and data

	movzx	ecx,lib_hdr.PALCNT
	sub	ecx,NUMDEFPAL			;-defaults
	jle	nopals
	cmp	ecx,MAX_PAL
	ja	x				;Too many?
	mov	cnt,ecx

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read pal header

pallp:
	mov	edx,paloset
	add	paloset,sizeof PALETTE
	mov	ecx,edx
	shr	ecx,16
	I21SETFPS				;Change offset
	jc	x				;Error?


	lea	edi,palettetmp

	mov	ecx,sizeof PALETTE
	mov	edx,edi
	I21READ
	jc	x				;Error?

	call	pal_alloc
	jz	x
	mov	esi,eax

	mov	al,[edi].PALETTE.FLAGS
	mov	[esi].PAL.FLAGS,al

	mov	al,[edi].PALETTE.BITSPIX
	mov	[esi].PAL.BITSPIX,al

	mov	ax,[edi].PALETTE.NUMC
	mov	[esi].PAL.NUMC,ax

	lea	eax,[edi].PALETTE.N_s
	lea	edi,[esi].PAL.N_s
	call	strcpy


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Read pal data


	mov	edx,palettetmp.OSET
	mov	ecx,edx
	shr	ecx,16
	I21SETFPS
	jc	x				;Error?

	movzx	eax,[esi].PAL.NUMC
	shl	eax,1				;*2
	mov	ecx,eax				;Len

	call	mem_alloc
	jz	x
	mov	[esi].PAL.DATA_p,eax

	mov	edx,eax
	I21READ
	jc	x				;Error?


	dec	cnt
	jg	pallp


nopals:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	cmp	lib_hdr.VERSION,IMGVER
	jge	@F				;New enough version?

	mov	al,1
	mov	esi,offset smlconv_s
	call	msgbox_open
@@:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	CLR	eax
	call	ilst_select


x:	mov	bx,imgfileh			;>Close file
	I21CLOSE


xx:
	call	main_draw



	popad
	ret


 SUBEND


;********************************
;* Save an image file
;* Trashes all non seg

 SUBRP	img_save

	mov	fileerr,1			;Set error flag


	lea	eax,imgext_s
	lea	edi,fname_s
	call	stradddefext

	lea	eax,fname_s
	call	file_renamebkup
	jnz	error2


	CLR	ecx				;>Create file
	mov	edx,offset fname_s
	I21CREATE
	jc	error2
	mov	ebx,eax				;BX=File handle


	lea	edx,lib_hdr

	mov	eax,imgcnt
	mov	[edx].LIB_HDR.IMGCNT,ax
	mov	eax,palcnt
	add	eax,NUMDEFPAL
	mov	[edx].LIB_HDR.PALCNT,ax

	mov	[edx].LIB_HDR.VERSION,IMGVER

	mov	eax,seqcnt
	mov	[edx].LIB_HDR.SEQCNT,ax
	mov	eax,scrcnt
	mov	[edx].LIB_HDR.SCRCNT,ax

	mov	[edx].LIB_HDR.TEMP,0abcdh

	mov	DPTR [edx].LIB_HDR.BUFSCR,-1
	CLR	eax
	mov	[edx].LIB_HDR.DAMCNT,ax
	mov	[edx].LIB_HDR.spare1,ax
	mov	[edx].LIB_HDR.spare2,ax
	mov	[edx].LIB_HDR.spare3,ax

	mov	ecx,sizeof lib_hdr		;>Write lib header
	I21WRITE
	jc	error


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write pal data


	lea	esi,pal_p
	jmp	paldnxt

paldlp:
	CLR	edx
	CLR	ecx
	I21SETFPC				;Get current offset
	jc	error				;Error?
	mov	WPTR [esi].PAL.TEMP,ax
	mov	WPTR [esi].PAL.TEMP+2,dx

	movzx	ecx,[esi].PAL.NUMC
	add	ecx,ecx				;*2
	mov	edx,[esi].PAL.DATA_p
	I21WRITE
	jc	error				;Error?
paldnxt:
	mov	esi,[esi]
	TST	esi
	jnz	paldlp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write img data


	lea	esi,img_p
	jmp	imgnxt

imglp:
	CLR	edx
	CLR	ecx
	I21SETFPC				;Get current offset
	jc	error				;Error?
	mov	WPTR [esi].IMG.TEMP,ax		;Save it
	mov	WPTR [esi].IMG.TEMP+2,dx

	movzx	ecx,[esi].IMG.W
	add	cx,3
	and	cl,0fch
	movzx	eax,[esi].IMG.H
	imul	ecx,eax

	mov	edx,[esi].IMG.DATA_p
	I21WRITE
	jc	error				;Error?
imgnxt:
	mov	esi,[esi]
	TST	esi
	jnz	imglp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	CLR	edx
	CLR	ecx
	I21SETFPC				;Get current offset
	jc	error				;Error?
	mov	WPTR lib_hdr.OSET,ax
	mov	WPTR lib_hdr.OSET+2,dx


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write img headers

	mov	tl1,0				;Pttbl #

	lea	esi,img_p
	jmp	wihnxt

wihlp:
	lea	edi,imagetmp

	mov	ax,[esi].IMG.FLAGS
	mov	[edi].IMAGE.FLAGS,ax

	mov	ax,[esi].IMG.ANIX
	mov	[edi].IMAGE.ANIX,ax
	mov	ax,[esi].IMG.ANIY
	mov	[edi].IMAGE.ANIY,ax

	mov	ax,[esi].IMG.W
	mov	[edi].IMAGE.W,ax
	mov	ax,[esi].IMG.H
	mov	[edi].IMAGE.H,ax

	mov	ax,[esi].IMG.PALNUM
	add	ax,NUMDEFPAL			;+defaults
	mov	[edi].IMAGE.PALNUM,ax

	mov	eax,[esi].IMG.TEMP
	mov	[edi].IMAGE.OSET,eax

	mov	ax,[esi].IMG.ANIX2
	mov	[edi].IMAGE.ANIX2,ax
	mov	ax,[esi].IMG.ANIY2
	mov	[edi].IMAGE.ANIY2,ax
	mov	ax,[esi].IMG.ANIZ2
	mov	[edi].IMAGE.ANIZ2,ax

	mov	[edi].IMAGE.FRM,0

	mov	ax,-1
	cmp	[esi].IMG.PTTBL_p,0
	je	@F				;No point table?
	mov	eax,tl1				;Get #
	inc	tl1
@@:	mov	[edi].IMAGE.PTTBLNUM,ax

	mov	ax,[esi].IMG.OPALS
	mov	[edi].IMAGE.OPALS,ax

	lea	eax,[esi].IMG.N_s
	lea	edi,[edi].IMAGE.N_s
	call	strcpy


	mov	ecx,sizeof IMAGE
	lea	edx,imagetmp
	I21WRITE
	jc	error				;Error?

wihnxt:
	mov	esi,[esi]
	TST	esi
	jnz	wihlp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write pal headers

	lea	esi,pal_p
	jmp	palhnxt

palhlp:
	lea	edi,palettetmp

	mov	al,[esi].PAL.FLAGS
	mov	[edi].PALETTE.FLAGS,al

	mov	al,[esi].PAL.BITSPIX
	mov	[edi].PALETTE.BITSPIX,al

	mov	ax,[esi].PAL.NUMC
	mov	[edi].PALETTE.NUMC,ax

	mov	eax,[esi].PAL.TEMP
	mov	[edi].PALETTE.OSET,eax

	mov	[edi].PALETTE.spare,0

	lea	eax,[esi].PAL.N_s
	lea	edi,[edi].PALETTE.N_s
	call	strcpy

	mov	ecx,sizeof PALETTE
	lea	edx,palettetmp
	I21WRITE
	jc	error				;Error?
palhnxt:
	mov	esi,[esi]
	TST	esi
	jnz	palhlp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write scripts/seqs

	mov	ecx,scrseqbytes
	TST	ecx
	jle	noss				;None?

	mov	edx,scrseqmem_p
	I21WRITE
	jc	error
noss:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write point table

	lea	esi,img_p
	jmp	wptnxt

wptlp:
	mov	edx,[esi].IMG.PTTBL_p
	TST	edx
	jz	wptnxt				;No point table?

	mov	ecx,sizeof PTTBL
	I21WRITE
	jc	error				;Error?
wptnxt:
	mov	esi,[esi]
	TST	esi
	jnz	wptlp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write final lib header


	CLR	edx				;To start
	CLR	ecx
	I21SETFPS
	jc	error				;Error?

	mov	ecx,sizeof lib_hdr
	mov	edx,offset lib_hdr
	I21WRITE
	jc	error				;Error?


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	fileerr,0			;OK!

error:
	I21CLOSE

	cmp	fileerr,0
	je	x
error2:
	mov	al,1
	mov	esi,offset werror_s
	call	msgbox_open			;Must be near call

	call	main_draw


x:	ret

 SUBEND


;********************************
;* Save marked images as raw data (interleaved horizontally)
;* Trashes all non seg

 SUBRP	img_saveraw

	local	lcnt:dword,\
		lnum:dword


	lea	esi,img_p			;>Find 1st marked img

lp:	mov	esi,[esi]
	TST	esi
	jz	x
	test	[esi].IMG.FLAGS,MARKED
	jz	lp


	movzx	eax,[esi].IMG.H			;# lines we will write
	mov	lcnt,eax

	movzx	eax,[esi].IMG.PALNUM
	call	pal_find
	jz	x

	mov	al,[eax].PAL.BITSPIX
	dec	al
	xor	al,7	
	mov	bitshift,al


	mov	fileerr,1

	CLR	ecx
	mov	edx,offset fname_s
	I21CREATE
	jc	error2
	mov	ebx,eax				;BX=File handle



	mov	rawbits,80h

	mov	lnum,0				;>Write img data

imglp2:
	lea	esi,img_p

imglp:
	test	[esi].IMG.FLAGS,MARKED
	jz	next

	movzx	eax,[esi].IMG.W
	mov	edx,eax

	add	eax,3				;Round up
	and	al,0fch
	imul	eax,lnum
	add	eax,[esi].IMG.DATA_p


	push	ebx

						;>Convert 8 bits to x bits
	mov	ebx,eax
	CLR	edi
	mov	ax,rawbits
	jmp	get1stb

@@:	cmp	ah,1
	jne	shft

	TST	edx
	jle	write				;Last byte?
get1stb:
	mov	ah,[ebx]			;Get bits
	inc	ebx
	dec	edx
	mov	cl,bitshift
	shl	ah,cl				;Kill unused bits
	stc					;End bit
	rcr	ah,cl				;Kill unused bits

	TST	cl
	jnz	shft				;!8 bits?
	mov	al,ah
	mov	ah,1
	jmp	store

shft:	shr	ax,1
	jnc	@B

store:	mov	buf[edi],al
	inc	edi
	mov	al,80h
	jmp	@B


write:	mov	rawbits,ax
	mov	ecx,edi

	pop	ebx				;>Write line
	mov	edx,offset buf
	I21WRITE
	jc	error				;Error?

next:
	mov	esi,[esi]
	TST	esi
	jnz	imglp

	inc	lnum
	dec	lcnt
	jg	imglp2				;Next line?


	mov	ax,rawbits
	cmp	al,80h
	je	close

@@:	shr	al,1
	jnc	@B
	mov	buf,al

						;>Write last byte
	mov	ecx,1
	mov	edx,offset buf
	INT21	40h
	jc	error				;Error?

close:
	mov	fileerr,0			;Clr error flag

error:
	I21CLOSE

	mov	al,fileerr
	TST	al
	jz	x

error2:	mov	al,1
	mov	esi,offset werror_s
	call	msgbox_open			;Must be near call

	call	main_draw


x:	ret


 SUBEND

;********************************
;* Alloc IMG struc and add to list
;*>EAX = *IMG struc or 0 (CC)
;* Trashes out

 SUBRP	img_alloc

	PUSHMR	ecx,edx,esi

	mov	eax,sizeof IMG
	call	mem_alloc
	jz	x

	lea	esi,img_p		;Find end
	CLR	ecx
lp:	mov	edx,esi
	inc	ecx			;Count em
	mov	esi,[esi]
	TST	esi
	jnz	lp

	mov	[edx],eax		;Link
	mov	[eax],esi		;0

	mov	[eax].IMG.DATA_p,esi	;0
	mov	[eax].IMG.PTTBL_p,esi	;0

	mov	imgcnt,ecx
x:
	TST	eax
	POPMR
	ret

 SUBEND


;********************************
;* Find IMG struc from ilselected
;*>EAX = *IMG struc or 0 (CC)
;* Trashes out

 SUBRP	img_findsel

	mov	eax,ilselected

	;Fall through!
 SUBEND

;********************************
;* Find IMG struc from #
;* EAX = Img # (0-?)
;*>EAX = *IMG struc or 0 (CC)
;* Trashes out

 SUBRP	img_find

	PUSHMR	edx,esi

	CLR	edx
	dec	edx
	lea	esi,img_p

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
;* Delete img and it's data
;* EAX = Img # (0-?)
;* Trashes none

 SUBRP	img_del

	pushad

	TST	eax
	jl	x

	lea	esi,img_p		;Find previous
	dec	eax
	jl	@F			;1st one?

	call	img_find
	jz	x			;Bad selection?
	mov	esi,eax
@@:
	mov	edi,[esi]
	TST	edi
	jz	x
	mov	eax,[edi]		;Get deleted's next
	mov	[esi],eax		;Give to prev

	dec	imgcnt

	TST	eax
	jnz	nlast			;!Last?

	mov	il1stprt,0
	mov	eax,ilselected
	dec	eax
	call	ilst_select

nlast:
	mov	eax,[edi].IMG.DATA_p
	call	mem_free
	mov	eax,[edi].IMG.PTTBL_p
	call	mem_free
	mov	eax,edi
	call	mem_free

x:
	popad
	ret

 SUBEND


;********************************
;* Add point table to image
;* EAX = Img # (0-?)
;*>EAX = *PTTBL struc or 0 (CC)
;* Trashes out

 SUBRP	img_pttbladd

	PUSHMR	ecx,edi

	call	img_find
	jz	x			;Bad selection?
	mov	edi,eax

	mov	eax,[edi].IMG.PTTBL_p
	TST	eax
	jnz	x			;Already have?

	mov	eax,sizeof PTTBL
	mov	ecx,eax
	call	mem_alloc
	jz	x			;No mem?
	mov	[edi].IMG.PTTBL_p,eax

	push	eax
@@:	mov	BPTR [eax],0		;Clr it
	inc	eax
	loop	@B
	pop	eax

x:
	TST	eax
	POPMR
	ret
 SUBEND



;********************************
;* Image list gadgets
;* AX=Gadget ID
;* CX=X top left offset from gad
;* DX=Y ^

 SUBRP	ilst_gads

	pushad


	TST	al
	jnz	n0

	sub	dx,3
	jl	x			;Above names?

	movsx	eax,dx
	CLR	edx
	mov	ebx,9
	div	ebx
	add	eax,il1stprt

	test	mousebut,1
	jnz	sel			;Toggle?

	test	mousebchg,2
	jnz	@F			;Toggle?

	cmp	eax,ilselected
	je	x			;Already selected?
@@:
	mov	ebx,eax
	call	img_find
	jz	x
	xor	[eax].IMG.FLAGS,MARKED
	mov	eax,ebx
	jmp	@F
sel:
	cmp	eax,ilselected
	je	x			;Already selected?
@@:
	call	ilst_select
	jmp	x

n0:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Move all marked imgs anipt #1

	cmp	al,30h
	jne	n30

	lea	edi,tw1
	CLR	eax
	mov	[edi],eax
	mov	8[edi],eax		;tw5&6
	mov	cx,-32
	mov	dx,cx
	lea	eax,@F
	call	gad_mousescroller
	jmp	x

@@:
	mov	bx,tw1
	cmp	bx,tw5
	jne	@F			;Changed?
	mov	bx,tw2
	cmp	bx,tw6
	jne	@F			;Changed?
	ret
@@:
	CLR	ecx
	dec	ecx

amlp:	inc	ecx
	mov	eax,ecx
	call	img_find
	jz	amdone			;Done?

	test	[eax].IMG.FLAGS,MARKED
	jz	amlp

	mov	bx,tw1
	sub	bx,tw5
	add	[eax].IMG.ANIX,bx
	mov	bx,tw2
	sub	bx,tw6
	add	[eax].IMG.ANIY,bx
	jmp	amlp

amdone:
	mov	eax,DPTR tw1
	mov	DPTR tw5,eax

	call	img_prt
	jmp	ilst_prt

n30:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	ebx,eax

	call	img_findsel
	jz	x			;No selection?

	mov	esi,eax			;ESI=*Img struc

	cmp	bl,80h
	jae	flaggad


	mov	cx,-32			;>Ani pt 1 or 2 scroll gad
	mov	dx,cx
	mov	edi,IMG.ANIX
	add	edi,esi
	cmp	bl,20h
	je	anigad			;Ani1?

	mov	cx,32
	mov	dx,cx
	mov	edi,IMG.ANIX2
	add	edi,esi
	cmp	bl,40h
	je	anigad			;Ani2?

	mov	edi,[esi].IMG.PTTBL_p	;Ani3
	TST	edi
	jz	x			;None?

	add	edi,PTTBL.X
	cmp	bl,50h
	je	a3xy			;Ani3 XY?

	mov	cx,4
	CLR	edx
	add	edi,PTTBL.Z-PTTBL.X
	cmp	bl,52h
	je	a3xy			;Ani3 Z?
	add	edi,PTTBL.ID-PTTBL.Z
a3xy:
anigad:
	mov	eax,offset code
	call	gad_mousescroller
	jmp	x


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

flaggad:
	mov	edi,[esi].IMG.PTTBL_p
	TST	edi
	jz	x				;None?

	cmp	bl,80h
	ja	cboxgad

	sub	cx,4
	jl	x
	shr	cx,3				;/8
	sub	cl,15
	neg	cl
	mov	ax,1
	shl	ax,cl

	xor	[edi].PTTBL.FLAGS,ax

	mov	ax,[edi].PTTBL.FLAGS
	mov	bx,0fdfch
	mov	cx,AFBOXX+4
	mov	dx,AFBOXY+3
	call	prt_binword
	jmp	x

cboxgad:
;	cmp	bl,80h
;	jae	x

;	mov	cx,1
;	CLR	edx
;	add	edi,offset imgpts_t+PTTBL.CBX
;	cmp	bl,0a0h
;	je	anigad				;X?
;	add	edi,PTTBL.CBY-PTTBL.CBX
;	cmp	bl,0a2h
;	je	anigad				;Y?
;	add	edi,PTTBL.CBZ-PTTBL.CBY
;	jmp	anigad


x:	popad
	ret


code:	call	img_prt
	jmp	ilst_prt1l


 SUBEND



;********************************
;* Select item from image list
;* AX=Item # (0-?)
;* Trashes none

 SUBRP	ilst_select

	pushad


	movsx	ebx,ax
	mov	ilselected,-1

	mov	eax,ebx
	call	img_find
	jz	x
	mov	esi,eax

	mov	ilselected,ebx


	call	ilst_prt


	push	esi
	mov	ax,[esi].IMG.W
	mov	bx,0fch
	mov	cx,24*8
	mov	dx,384
	call	prt_dec3srj
	pop	esi

	mov	ax,[esi].IMG.H
	mov	bx,0fch
	mov	cx,28*8
	mov	dx,384
	call	prt_dec3srj

	call	img_loadpal
	call	img_prt

x:
	popad
	ret

 SUBEND



;********************************
;* Prt list of image names
;* Trashes none

 SUBRP	ilst_prt

	pushad

					;>Make sure selected is visable
	mov	ebx,ilselected
	mov	eax,il1stprt
	cmp	ebx,eax
	jb	@F			;Off top?
	sub	ebx,ILSTROW-1
	cmp	ebx,eax
	jbe	vis			;!Off bottom?
	TST	ebx
	jge	@F
	CLR	ebx
@@:	mov	il1stprt,ebx
vis:

	mov	ax,ILSTW
	mov	bx,ILSTH
	mov	cx,ILSTX
	mov	dx,ILSTY
	call	box_drawshaded


	mov	ecx,imgcnt
	TST	ecx
	jle	x			;None?
	cmp	ecx,ILSTROW
	jbe	inumok
	mov	ecx,ILSTROW
inumok:

	mov	eax,il1stprt
	mov	edi,eax
	call	img_find
	jz	x
	mov	esi,eax

	mov	dx,ILSTY+3
lp:
	push	ecx
	push	edi
	call	ilst_prt1l_ll
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
;* Prt 1 line of list of image names
;* ESI=*Image struc
;* Trashes none

 SUBRP	ilst_prt1l

	pushad

	mov	ebx,ilselected
	mov	edi,ebx
	sub	ebx,il1stprt
	cmp	ebx,ILSTROW
	jae	x			;Not visable?

	mov	ax,9
	mul	bx
	add	ax,ILSTY+3
	mov	dx,ax
	mov	ax,35
	mov	bh,0fdh
	mov	cx,ILSTX+4
	call	prt_spc
	call	ilst_prt1l_ll

x:	popad
	ret

 SUBEND


;********************************
;* Prt 1 line of list of image names (Low level)
;* ESI = *Image hdr
;* EDI = Img # (0-?)
;* DX  = Y pos
;* Trashes A-D

 SUBRP	ilst_prt1l_ll

	push	esi

	movsx	edi,di

	mov	bx,0fdfch
	cmp	edi,ilselected
	jne	notsel

	push	edx
	mov	ax,16
	mov	cx,AFBOXX+4
	mov	dx,AFBOXY+3
	call	prt_spc

;	mov	ax,18
;	mov	bx,0fdfch
;	mov	cx,CBOXX+4
;	mov	dx,CBOXY+28
;	call	prt_spc

	mov	ax,18
	mov	bx,0fdfch
	mov	cx,A3BOXX+4
	mov	dx,A3BOXY+28
	call	prt_spc

	mov	esi,[esi].IMG.PTTBL_p
	TST	esi
	jz	nopt

	mov	ax,[esi].PTTBL.X		;>Prt ani3 data
	push	esi
	call	prt_dec3srj
	pop	esi

	mov	ax,[esi].PTTBL.Y
	add	cx,36
	push	esi
	call	prt_dec3srj
	pop	esi

	mov	ax,[esi].PTTBL.Z
	add	cx,36
	push	esi
	call	prt_dec3srj
	pop	esi

	mov	ax,[esi].PTTBL.ID
	add	cx,36
	push	esi
	call	prt_dec3srj
	pop	esi

;	mov	cx,CBOXX+4		;>Prt collision box data
;	mov	dx,CBOXY+28
;	mov	ax,[esi].PTTBL.CBX
;	push	esi
;	call	prt_dec3srj
;	pop	esi
;
;	mov	ax,[esi].PTTBL.CBY
;	add	cx,36
;	push	esi
;	call	prt_dec3srj
;	pop	esi
;
;	mov	ax,[esi].PTTBL.CBZ
;	add	cx,36
;	push	esi
;	call	prt_dec3srj
;	pop	esi

	mov	ax,[esi].PTTBL.FLAGS	;>Prt bit flags
	mov	bx,0fdfch
	mov	cx,AFBOXX+4
	mov	dx,AFBOXY+3
	call	prt_binword

nopt:	pop	edx

	pop	esi
	push	esi
	mov	bx,0feffh
notsel:	mov	cx,ILSTX+14
	lea	esi,[esi].IMG.N_s
	call	prt			;Image name

	pop	esi
	push	esi
	test	[esi].IMG.FLAGS,MARKED
	jz	nomrk
	mov	bx,0feffh
	mov	esi,offset cast_s
	mov	cx,ILSTX+4
	call	prt
nomrk:
	pop	esi
	push	esi
	mov	ax,[esi].IMG.ANIX
	mov	bx,0fdfch
	mov	cx,ILSTX+100
	call	prt_dec3srj

	pop	esi
	push	esi
	mov	ax,[esi].IMG.ANIY
	mov	cx,ILSTX+136
	call	prt_dec3srj

	pop	esi
	push	esi
	mov	ax,[esi].IMG.ANIX2	;X
	mov	cx,ILSTX+100+36*2
	call	prt_dec3srj

	pop	esi
	push	esi
	mov	ax,[esi].IMG.ANIY2	;Y
	mov	cx,ILSTX+100+36*3
	call	prt_dec3srj

	pop	esi
	push	esi
	mov	ax,[esi].IMG.ANIZ2	;Z
	mov	cx,ILSTX+100+36*4
	call	prt_dec3srj

	pop	esi
	ret

 SUBEND


;********************************
;* Image list - Page up

 SUBRP	ilst_kpup

	mov	ebx,-ILSTROW
	jmp	ikup
 SUBEND

;********************************
;* Key - Up arrow

 SUBRP	ilst_kup

	mov	ebx,-1
ikup::
	mov	ax,ds:[41ah]
	cmp	ax,ds:[41ch]
	jne	x			;Other key in buffer?

	mov	eax,ilselected
	add	eax,ebx
	jge	selok
	CLR	eax
selok:	jmp	ilst_select

x:	ret

 SUBEND


;********************************
;* Key - Page down

 SUBRP	ilst_kpdn

	mov	ebx,ILSTROW
	jmp	ikdn

 SUBEND

;********************************
;* Key - Down arrow

 SUBRP	ilst_kdn

	mov	ebx,1
ikdn::
	mov	ax,ds:[41ah]
	cmp	ax,ds:[41ch]
	jne	x			;Other key in buffer?

	mov	eax,ilselected
	add	eax,ebx
	mov	ebx,imgcnt
	cmp	eax,ebx
	jb	selok			;Within max?
	mov	eax,ebx
	dec	eax
selok:
	jmp	ilst_select

x:	ret

 SUBEND


;********************************
;* Image list key functions
;* AX=Key code

 SUBRP	ilst_keys

	mov	edx,eax


	mov	eax,ilselected
	mov	ebx,eax
	call	img_find
	jz	x			;!Found?
	mov	esi,eax			;ESI=*IMG struc

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

					;>Alt cursor keys
	cmp	dh,98h			;>Up
	jne	@F
	inc	[esi].IMG.ANIY
@@:
	cmp	dh,0a0h			;>Dn
	jne	@F
	dec	[esi].IMG.ANIY
@@:
	cmp	dh,9bh			;>Left
	jne	@F
	inc	[esi].IMG.ANIX
@@:
	cmp	dh,9dh			;>Rgt
	jne	@F
	dec	[esi].IMG.ANIX
@@:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
					;>Ctrl cursor keys

	cmp	cboxon,0
	je	ccur			;Off?


	mov	edi,[esi].IMG.PTTBL_p
	TST	edi
	jz	chome			;None?

	lea	edi,[edi].PTTBL.CBOX

	test	BPTR ds:[417h],3	;Shift keys
	jz	@F			;None?
	add	edi,PTCBOX.W-PTCBOX.X	;Do WH instead
@@:
	cmp	dh,8dh			;>C-Up
	jne	@F

	dec	[edi].PTCBOX.Y
@@:
	cmp	dh,91h			;>C-Dn
	jne	@F
	inc	[edi].PTCBOX.Y
@@:
	cmp	dh,73h			;>C-L
	jne	@F
	dec	[edi].PTCBOX.X
@@:
	cmp	dh,74h			;>C-R
	jne	@F
	inc	[edi].PTCBOX.X
@@:

	jmp	chome


ccur:
	mov	al,aniptmode
	and	al,3			;Mask off ani3 bit
	mov	edi,[esi].IMG.PTTBL_p	;Ani3
	TST	edi
	jz	@F			;None?
	or	al,aniptmode		;Get ani3 bit
@@:
	mov	cx,1

	cmp	dh,8dh			;>C-Up
	je	cup
	cmp	dh,91h			;>C-Dn
	jne	ctrllr
	neg	cx

cup:	test	al,1
	jz	@F
	add	[esi].IMG.ANIY,cx
@@:	test	al,2
	jz	@F
	sub	[esi].IMG.ANIY2,cx
@@:	test	al,4
	jz	@F
	sub	[edi].PTTBL.Y,cx
@@:

ctrllr:
	mov	cx,1

	cmp	dh,73h			;>C-Lft
	je	clft
	cmp	dh,74h			;>C-Rgt
	jne	chome
	neg	cx

clft:	test	al,1
	jz	@F
	add	[esi].IMG.ANIX,cx
@@:	test	al,2
	jz	@F
	sub	[esi].IMG.ANIX2,cx
@@:	test	al,4
	jz	@F
	sub	[edi].PTTBL.X,cx
@@:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
chome:					;>C-Home
	mov	cx,1
	cmp	dh,77h
	je	cho
	cmp	dh,75h			;>C-End
	jne	notce
	neg	cx
cho:
	test	al,2
	jz	@F
	sub	[esi].IMG.ANIZ2,cx
@@:	test	al,4
	jz	@F
	sub	[edi].PTTBL.Z,cx
@@:
notce:

	cmp	dh,93h			;>C-Del
	jne	@F
	CLR	eax
	mov	[esi].IMG.ANIX2,ax
	mov	[esi].IMG.ANIY2,ax
	mov	[esi].IMG.ANIZ2,ax
@@:
;nonext:

	cmp	dl,19h			;>Ctrl Y
	jne	@F
	CLR	eax
	cmp	[esi].IMG.ANIY2,0
	jne	clry			;Clr it?
	mov	ax,-200
clry:	mov	[esi].IMG.ANIY2,ax
@@:
	cmp	dl,1ah			;>Ctrl Z
	jne	@F
	mov	[esi].IMG.ANIZ2,0
@@:
	cmp	dl,' '			;>Space
	jne	@F
	xor	[esi].IMG.FLAGS,MARKED	;Toggle
@@:

	cmp	dl,'a'			;>Next anipt mode
	jne	@F
	mov	al,aniptmode
	inc	al
	and	al,7
	jnz	apmok
	inc	al
apmok:	mov	aniptmode,al
	jmp	ilst_prtaniptmode

@@:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	dh,4bh			;>Previous marked
	jne	@F

	CLR	ecx
	dec	ecx
	jmp	domrk
@@:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	dh,4dh			;>Next marked
	jne	@F

	CLR	ecx
	inc	ecx
domrk:
	mov	ebx,ilselected
	mov	edx,ebx
mrklp:
	add	ebx,ecx
	cmp	ebx,edx
	je	mrk			;Wrapped around?

	mov	eax,ebx
	call	img_find
	jz	mbad
	test	[eax].IMG.FLAGS,MARKED
	jnz	mrk
	jmp	mrklp

mbad:	TST	ebx
	jl	mend
	CLR	ebx			;Goto first
	dec	ebx
	jmp	mrklp
mend:
	mov	ebx,imgcnt		;Goto end
	jmp	mrklp
mrk:
	mov	eax,ebx
	jmp	ilst_select
@@:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

;	mov	cx,1
;	cmp	dh,41h			;>F7 (Height+1)
;	je	chgh
;	cmp	dh,42h			;>F8 (Height-1)
;	jne	@F
;
;	mov	cx,-1
;chgh:
;	CLR	eax
;	mov	ax,[esi].IMG.W
;	add	ax,3
;	and	al,0fch
;	TST	cx
;	jl	addos
;	neg	eax
;addos:	add	[esi].IMG.DATA_p,eax
;
;	add	[esi].IMG.H,cx
;	add	[esi].IMG.ANIY,cx
;	add	[esi].IMG.ANIY2,cx
;
;	mov	edi,[esi].IMG.PTTBL_p	;Ani3
;	TST	edi
;	jz	goisel			;None?
;	add	[edi].PTTBL.Y,cx
;goisel:
;	mov	eax,ilselected
;	jmp	ilst_select


@@:
	call	ilst_prt1l
	call	img_prt

x:
	ret

 SUBEND

;********************************
;* Change to next list

 SUBRP	ilst_nxtlstkey

	call	ilst_nxtlst

	jmp	main_draw

 SUBEND

;********************************
;* Change to next list
;* Trashes EAX

 SUBRP	ilst_nxtlst

	mov	eax,img_p
	xchg	img2_p,eax
	mov	img_p,eax

	mov	eax,imgcnt
	xchg	img2cnt,eax
	mov	imgcnt,eax

	mov	eax,ilselected
	xchg	il2selected,eax
	mov	ilselected,eax

	mov	eax,il1stprt
	xchg	il21stprt,eax
	mov	il1stprt,eax

	ret

 SUBEND

;********************************
;* Set current img pttbl.ID based on offset in 2nd list

 SUBRP	ilst_setidfmnxtlst

	mov	eax,ilselected
	call	img_find
	jz	x

	mov	eax,[eax].IMG.PTTBL_p
	TST	eax
	jnz	@F

	mov	eax,ilselected
	call	img_pttbladd
	jz	x
@@:
	mov	edx,il2selected
	inc	dx
	mov	[eax].PTTBL.ID,dx
x:
	ret

 SUBEND


;********************************
;* Clr all extra data

 SUBRP	ilst_clrxdata


	lea	esi,img_p
	jmp	nxt

lp:	CLR	eax
	mov	[esi].IMG.ANIX2,ax
	mov	[esi].IMG.ANIY2,ax
	mov	[esi].IMG.ANIZ2,ax

	mov	edi,[esi].IMG.PTTBL_p
	TST	edi
	jz	nopt			;No pttbl?
	mov	ecx,sizeof PTTBL
@@:	mov	[edi],al
	inc	edi
	loop	@B
nopt:
nxt:	mov	esi,[esi]
	TST	esi
	jnz	lp


	call	ilst_prt

	call	img_prt


	ret

 SUBEND



;********************************
;* Print current Ctrl-cursor keys anipt mode

 SUBRP	ilst_prtaniptmode

	mov	esi,offset aniptm_s

	mov	al,' '
	mov	12[esi],al
	mov	14[esi],al
	mov	16[esi],al

	mov	al,aniptmode
	test	al,1
	jz	@F
	mov	BPTR 12[esi],'1'
@@:
	test	al,2
	jz	@F
	mov	BPTR 14[esi],'2'
@@:
	test	al,4
	jz	@F
	mov	BPTR 16[esi],'3'
@@:
	mov	bx,0feffh
	mov	cx,ILSTX+4
	mov	dx,ILSTY-20
	call	prt

	ret

 SUBEND
	.data
aniptm_s	db	"Anipt mode: x x x",0



;********************************
;* Rename selected image

 SUBRP	ilst_rename

	call	img_findsel
	jz	x			;Bad selection?

	lea	edi,[eax].IMG.N_s
	mov	eax,INAMELEN
	call	strbox_open
;	jnz	x

	call	main_draw
x:
	ret

 SUBEND



;********************************
;* Rename marked images

 SUBRP	ilst_renamemrkd

	local	sbuf[20]:byte


	CLR	ecx			;>Find 1st mrkd
	dec	ecx

flp:	inc	ecx
	mov	eax,ecx
	call	img_find
	jz	x			;End?

	test	[eax].IMG.FLAGS,MARKED
	jz	flp

	lea	eax,[eax].IMG.N_s
	lea	edi,buf
	call	strcpy

	mov	eax,INAMELEN-3
	lea	edi,buf
	call	strbox_open
	jnz	x


	CLR	ecx
	dec	ecx

	CLR	edx			;EDX=# to append to name

lp:	inc	ecx
	mov	eax,ecx
	call	img_find
	jz	draw			;Done?

	test	[eax].IMG.FLAGS,MARKED
	jz	lp

	mov	esi,eax

	lea	eax,[esi].IMG.N_s	;Save name
	lea	edi,sbuf
	call	strcpy

	lea	eax,buf
	cmp	BPTR buf,'+'
	jne	@F
	inc	eax
@@:
	lea	edi,[esi].IMG.N_s	;Copy base
	call	strcpy

	cmp	BPTR buf,'+'
	jne	@F

	lea	eax,sbuf
	call	strcpy

@@:
	cmp	BPTR buf,'+'
	je	@F

	inc	edx			;Add #
	mov	eax,edx
	call	stritoa
@@:
	jmp	lp

draw:
	call	main_draw

x:
	ret

 SUBEND


;********************************
;* Delete selected image

 SUBRP	ilst_delete

	CLR	al
	mov	esi,offset rusure_s
	call	msgbox_open
	jnz	draw			;Canceled?

	mov	eax,ilselected
	call	img_del
draw:
	jmp	main_draw

 SUBEND


;********************************
;* Delete marked images

 SUBRP	ilst_deletemrkd

	CLR	al
	mov	esi,offset rusure_s
	call	msgbox_open
	jnz	draw			;Canceled?

	CLR	ecx
	dec	ecx

lp:	inc	ecx
same:	mov	eax,ecx
	call	img_find
	jz	draw			;Done?

	test	[eax].IMG.FLAGS,MARKED
	jz	lp

	mov	eax,ecx
	call	img_del
	jmp	same

draw:
	jmp	main_draw

 SUBEND


;********************************
;* Duplicate selected image

 SUBRP	ilst_duplicate

	call	img_findsel
	jz	x				;Bad selection?
	mov	esi,eax				;ESI=*Src IMG struc

	call	img_alloc
	jz	x
	mov	edi,eax				;EDI=*New IMG struc

	mov	eax,[esi].IMG.DATA_p
	TST	eax
	jz	dok

	call	mem_duplicate
	jnz	dok
err:
	mov	eax,imgcnt
	dec	eax
	call	img_del
	jmp	x
dok:
	mov	[edi].IMG.DATA_p,eax

	mov	eax,[esi].IMG.PTTBL_p
	TST	eax
	jz	pok

	call	mem_duplicate
	jz	err
pok:
	mov	[edi].IMG.PTTBL_p,eax

	mov	ax,[esi].IMG.FLAGS
	mov	[edi].IMG.FLAGS,ax
	mov	ax,[esi].IMG.ANIX
	mov	[edi].IMG.ANIX,ax
	mov	ax,[esi].IMG.ANIY
	mov	[edi].IMG.ANIY,ax
	mov	ax,[esi].IMG.W
	mov	[edi].IMG.W,ax
	mov	ax,[esi].IMG.H
	mov	[edi].IMG.H,ax
	mov	ax,[esi].IMG.PALNUM
	mov	[edi].IMG.PALNUM,ax
	mov	ax,[esi].IMG.ANIX2
	mov	[edi].IMG.ANIX2,ax
	mov	ax,[esi].IMG.ANIY2
	mov	[edi].IMG.ANIY2,ax
	mov	ax,[esi].IMG.ANIZ2
	mov	[edi].IMG.ANIZ2,ax
	mov	ax,[esi].IMG.OPALS
	mov	[edi].IMG.OPALS,ax

	lea	eax,[esi].IMG.N_s
	lea	edi,[edi].IMG.N_s
	push	edi
	call	strcpy
	pop	edi

	mov	eax,INAMELEN			;Let user rename
	call	strbox_open

	mov	eax,imgcnt
	dec	eax
	call	ilst_select

	call	main_draw

x:
	ret

 SUBEND



;********************************
;* Set palette of selected image to selected pal

 SUBRP	ilst_setpal

	mov	eax,plselected
	mov	ebx,eax
	call	pal_find
	jz	x			;Bad selection?

	call	img_findsel
	jz	x			;Bad selection?

	mov	[eax].IMG.PALNUM,bx

	call	main_draw
x:
	ret

 SUBEND

;********************************
;* Set palette of marked images to selected pal

 SUBRP	ilst_setpalmrkd

	mov	eax,plselected
	mov	ebx,eax
	call	pal_find
	jz	draw			;Bad selection?

	CLR	al
	mov	esi,offset rusure_s
	call	msgbox_open
	jnz	draw			;Canceled?

	CLR	ecx
	dec	ecx

lp:	inc	ecx
	mov	eax,ecx
	call	img_find
	jz	draw			;Done?

	test	[eax].IMG.FLAGS,MARKED
	jz	lp

	mov	[eax].IMG.PALNUM,bx
	jmp	lp

draw:
	jmp	main_draw

 SUBEND



;********************************
;* Do a least square size reduction on marked images
;* Trashes all non seg

 SUBRP	ilst_leastsqmrkd

	local	x1:dword,\
		y1:dword,\
		x2:dword,\
		y2:dword,\
		cnt:dword


;	CLR	al
;	mov	esi,offset rusure_s
;	call	msgbox_open
;	jnz	draw			;Canceled?

	CLR	eax
	mov	cnt,eax

lp:	mov	eax,cnt
	inc	cnt
	call	img_find
	jz	draw			;Done?

	test	[eax].IMG.FLAGS,MARKED
	jz	lp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Do least square on box

	mov	edi,eax

	movzx	eax,[edi].IMG.W
	dec	eax
	mov	x2,eax
	inc	eax
	add	eax,3
	and	al,0fch
	mov	imgdataw,eax

	movzx	eax,[edi].IMG.H
	dec	eax
	mov	y2,eax


					;>Check left edge
	CLR	edx			;EDX=Left X
lxlp:
	mov	ebx,edx
	add	ebx,[edi].IMG.DATA_p
	mov	ecx,y2
lylp:
	cmp	BPTR [ebx],0
	jne	lok

	add	ebx,imgdataw		;Next Y
	dec	ecx
	jge	lylp

	inc	edx
	cmp	edx,x2
	jl	lxlp
lok:
	mov	x1,edx


					;>Check rgt edge
	mov	edx,x2			;EDX=Rgt X
rxlp:
	mov	ebx,edx
	add	ebx,[edi].IMG.DATA_p
	mov	ecx,y2
rylp:
	cmp	BPTR [ebx],0
	jne	rok

	add	ebx,imgdataw		;Next Y
	dec	ecx
	jge	rylp

	dec	edx
	cmp	edx,x1
	jg	rxlp
rok:
	mov	x2,edx


					;>Check top edge
	CLR	edx			;EDX=Top Y
tylp:
	mov	ebx,edx
	imul	ebx,imgdataw
	add	ebx,x1
	add	ebx,[edi].IMG.DATA_p

	mov	ecx,x2
	sub	ecx,x1
txlp:
	cmp	BPTR [ebx],0
	jne	tok

	inc	ebx			;Next X
	dec	ecx
	jge	txlp

	inc	edx
	cmp	edx,y2
	jl	tylp

tok:
	mov	y1,edx


					;>Check bot edge
	mov	edx,y2			;EDX=Bot Y
bylp:
	mov	ebx,edx
	imul	ebx,imgdataw
	add	ebx,x1
	add	ebx,[edi].IMG.DATA_p

	mov	ecx,x2
	sub	ecx,x1
bxlp:
	cmp	BPTR [ebx],0
	jne	bok

	inc	ebx			;Next X
	dec	ecx
	jge	bxlp

	dec	edx
	cmp	edx,y1
	jg	bylp
bok:
	mov	y2,edx



	CLR	eax
	cmp	x1,eax
	jne	chg
	cmp	y1,eax
	jne	chg

	movzx	eax,[edi].IMG.W
	dec	eax
	cmp	x2,eax
	jne	chg

	movzx	eax,[edi].IMG.H
	dec	eax
	cmp	y2,eax
	je	lp			;All same?

chg:

	mov	eax,x2
	sub	eax,x1
	jl	lp			;Error?
	inc	eax
	add	eax,3
	and	al,0fch
	mov	edx,eax

	mov	ecx,y2
	sub	ecx,y1
	jl	lp			;Error?
	inc	ecx

	imul	eax,ecx
	call	mem_alloc		;Get new block
	jz	merr

	push	eax
	mov	ebx,eax
@@:
	add	eax,edx
	mov	DPTR [eax-4],0		;Clr last 4 of each line
	loop	@B


	mov	edx,y1
cylp:
	mov	esi,edx
	imul	esi,imgdataw
	add	esi,x1
	add	esi,[edi].IMG.DATA_p

	mov	ecx,x2
	sub	ecx,x1
@@:
	mov	al,[esi]		;Copy pixel
	mov	[ebx],al
	inc	esi
	inc	ebx

	dec	ecx
	jge	@B

	add	ebx,3			;Bump dest
	and	bl,0fch

	inc	edx			;Next Y
	cmp	edx,y2
	jle	cylp



	mov	eax,[edi].IMG.DATA_p
	call	mem_free		;Free old

	pop	eax
	mov	[edi].IMG.DATA_p,eax

	mov	eax,x2
	sub	eax,x1
	inc	eax
	mov	[edi].IMG.W,ax

	mov	eax,y2
	sub	eax,y1
	inc	eax
	mov	[edi].IMG.H,ax

	mov	eax,x1
	sub	[edi].IMG.ANIX,ax

	mov	eax,y1
	sub	[edi].IMG.ANIY,ax


	jmp	lp

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

merr:
	call	msg_memerr

draw:
	call	main_draw

	ret
 SUBEND


;********************************

 SUBRP	ilst_striplowmrkd

	mov	eax,3
	CLR	ebx
	jmp	ilst_stripmrkd2

 SUBEND

;********************************

 SUBRP	ilst_striprngmrkd

	mov	eax,5
	mov	bl,palb1stc
	mov	bh,palblastc

	jmp	ilst_stripmrkd2

 SUBEND

;********************************

 SUBRP	ilst_stripmrkd

	mov	eax,5
	CLR	ebx

 SUBEND

;********************************
;* Strip edge pixels on marked images
;* EAX = Max # transparent pixels
;*  BL = !0 = 1st pixel # to strip
;*  BH = Last pixel # to strip
;* Trashes all non seg

 SUBRP	ilst_stripmrkd2

	local	px:dword,		;Pixel X
		py:dword,		;Pixel Y
		maxx:dword,
		maxy:dword,
		cnt:dword,
		strpmaxt:dword,
		strp1st:byte,
		strplast:byte


	mov	strpmaxt,eax		;5 normal
	mov	strp1st,bl
	mov	strplast,bh


	CLR	eax
	mov	cnt,eax

lp:	mov	eax,cnt
	inc	cnt
	call	img_find
	jz	draw			;Done?

	test	[eax].IMG.FLAGS,MARKED
	jz	lp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Process image

	mov	edi,eax

	movzx	eax,[edi].IMG.W
	dec	eax
	mov	px,eax
	mov	maxx,eax
	inc	eax
	add	eax,3
	and	al,0fch
	mov	imgdataw,eax

	movzx	ebx,[edi].IMG.H
	imul	eax,ebx
	dec	ebx
	mov	py,ebx
	mov	maxy,ebx

	mov	ecx,eax
	call	mem_alloc		;Get strip block
	jz	merr
	mov	esi,eax			;ESI=*Mem block

	sar	ecx,2			;/4
@@:	mov	DPTR [eax],0		;Clr block
	add	eax,4
	dec	ecx
	jg	@B

pixlp:
	mov	eax,py
	imul	eax,imgdataw
	add	eax,px
	add	eax,[edi].IMG.DATA_p
	mov	bl,[eax]
	TST	bl
	jz	pixnxt			;Trans pixel?
	mov	bh,strp1st
	TST	bh
	jz	@F			;Do all types?
	cmp	bl,bh
	jb	pixnxt			;Too low?
	cmp	bl,strplast
	ja	pixnxt			;Too high?
@@:
	lea	ebx,stripo_t
	CLR	ecx			;ECX=Border pix count
brdrlp:
	movsx	eax,BPTR [ebx]
	cmp	al,100
	je	brdrend
	inc	ebx
	add	eax,px
	jl	trns			;Out of bounds?
	cmp	eax,maxx
	jg	trns			;Out of bounds?

	movsx	edx,BPTR [ebx]
	add	edx,py
	jl	trns			;Out of bounds?
	cmp	edx,maxy
	jg	trns			;Out of bounds?
	imul	edx,imgdataw
	add	eax,edx

	add	eax,[edi].IMG.DATA_p

	cmp	BPTR [eax],0
	jne	@F			;!Transparent?
trns:
	inc	ecx			;Cnt+1
@@:
	inc	ebx
	jmp	brdrlp

brdrend:
	cmp	ecx,2
	jl	pixnxt
	cmp	ecx,strpmaxt
	jg	pixnxt

	mov	eax,py
	imul	eax,imgdataw
	add	eax,px
	mov	BPTR [eax+esi],1	;Flag for delete

pixnxt:
	dec	px
	jge	pixlp

	movzx	eax,[edi].IMG.W
	dec	eax
	mov	px,eax

	dec	py
	jge	pixlp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Delete flagged pixels

	mov	ebx,esi
	mov	edx,[edi].IMG.DATA_p
	movzx	ecx,[edi].IMG.H
	imul	ecx,imgdataw

	mov	al,palb1stc
	cmp	strp1st,0
	je	@F			;Do all types?
	CLR	al
@@:
dellp:
	cmp	BPTR [ebx],0
	je	@F			;!Flagged?
	mov	BPTR [edx],al
@@:
	inc	ebx
	inc	edx
	dec	ecx
	jg	dellp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Find lonely pixels


	movzx	eax,[edi].IMG.W
	dec	eax
	mov	px,eax

	movzx	ebx,[edi].IMG.H
	dec	ebx
	mov	py,ebx

lpixlp:
	mov	eax,py
	imul	eax,imgdataw
	add	eax,px
	add	eax,[edi].IMG.DATA_p
	cmp	BPTR [eax],0
	je	lpixnxt			;Trans pixel?

	lea	ebx,stripo_t
	CLR	ecx			;ECX=Border pix count
lbrdrlp:
	movsx	eax,BPTR [ebx]
	cmp	al,100
	je	lbrdrend
	inc	ebx
	add	eax,px
	jl	ltrns			;Out of bounds?
	cmp	eax,maxx
	jg	ltrns			;Out of bounds?

	movsx	edx,BPTR [ebx]
	add	edx,py
	jl	ltrns			;Out of bounds?
	cmp	edx,maxy
	jg	ltrns			;Out of bounds?
	imul	edx,imgdataw
	add	eax,edx

	add	eax,[edi].IMG.DATA_p

	cmp	BPTR [eax],0
	jne	@F			;!Transparent?
ltrns:
	inc	ecx			;Cnt+1
@@:
	inc	ebx
	jmp	lbrdrlp

lbrdrend:
	cmp	ecx,8
	jl	lpixnxt

	mov	eax,py
	imul	eax,imgdataw
	add	eax,px
	mov	BPTR [eax+esi],1	;Flag for delete

lpixnxt:
	dec	px
	jge	lpixlp

	movzx	eax,[edi].IMG.W
	dec	eax
	mov	px,eax

	dec	py
	jge	lpixlp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Delete flagged pixels

	mov	ebx,esi
	mov	edx,[edi].IMG.DATA_p
	movzx	ecx,[edi].IMG.H
	imul	ecx,imgdataw

	mov	al,palb1stc
	cmp	strp1st,0
	je	@F			;Do all types?
	CLR	al
@@:
del2lp:
	cmp	BPTR [ebx],0
	je	@F			;!Flagged?
	mov	BPTR [edx],al
@@:
	inc	ebx
	inc	edx
	dec	ecx
	jg	del2lp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	mov	eax,esi
	call	mem_free


	jmp	lp

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

merr:
	call	msg_memerr

draw:
	call	main_draw

	ret

 SUBEND

	.data
stripo_t	db	-1,-1, 0,-1, 1,-1
		db	-1,0,  1,0
		db	-1,1, 0,1, 1,1
		db	100
		align	4



;********************************
;* Replace dither pixels on marked images
;* Trashes all non seg

 SUBRP	ilst_ditherrepmrkd

	local	px:dword,\		;Pixel X
		py:dword,\		;Pixel Y
		maxx:dword,\
		maxy:dword,\
		cnt:dword


	CLR	eax
	mov	cnt,eax

lp:	mov	eax,cnt
	inc	cnt
	call	img_find
	jz	draw			;Done?

	test	[eax].IMG.FLAGS,MARKED
	jz	lp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Process image

	mov	edi,eax

	movzx	ebx,[edi].IMG.H

	mov	edx,[edi].IMG.DATA_p
ylp:
	movzx	ecx,[edi].IMG.W
	add	ecx,3
	and	cl,0fch
	shr	ecx,1			;/2
xlp:
	cmp	BPTR [edx],0
	je	xnxt			;Trans pixel?

	mov	al,palb1stc
	mov	[edx],al
xnxt:
	add	edx,2

	dec	ecx
	jg	xlp

	xor	edx,1			;Toggle low bit

	dec	ebx
	jg	ylp


	jmp	lp

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


draw:
	call	main_draw

	ret

 SUBEND


;********************************
;* Build 256 wide TGA for VUNIT from marked images
;* Trashes all non seg

AFACE	struct
	CTRL	dd	?	;
	PAL	dd	?	;
	O1	dd	?	;
	O2	dd	?	;
	O3	dd	?	;
	O4	dd	?	;
	AYX	dw	?	;
	BYX	dw	?	;
	CYX	dw	?	;
	DYX	dw	?	;
	LINE	dd	?	;
AFACE	ends

BSZ=16
LMAX=6000
FSZ=sizeof AFACE*1000

 SUBRP	ilst_buildtgamrkd

	local	srt_p:dword,\
		dst_p:dword,\
		dsti_p:dword,\
		af_p:dword,\		;*aniface mem
		aff_p:dword,\		;*next free aniface
		fcnt:dword,\		;Face count
		paln:dword,\
		cnt:dword,\
		lineuse_p:dword,\
		lcnt:dword,\
		len:dword


;	CLR	al
;	mov	esi,offset rusure_s
;	call	msgbox_open
;	jnz	draw			;Canceled?


	CLR	eax
	mov	srt_p,eax
	lea	edi,buf			;EDI=*free block

	mov	cnt,eax
sortlp:
	mov	eax,cnt
	inc	cnt
	call	img_find
	jz	sortend			;Done?

	mov	[eax].IMG.TEMP,0

	test	[eax].IMG.FLAGS,MARKED
	jz	sortlp

	cmp	[eax].IMG.W,256
	ja	sortlp			;Too wide?

	cmp	srt_p,0
	jne	@F			;!1st?
	mov	dx,[eax].IMG.PALNUM
	mov	paln,edx
@@:
	mov	4[edi],eax		;Save * img
	movzx	edx,[eax].IMG.W
	mov	8[edi],edx		;Save W
	movzx	edx,[eax].IMG.H
	mov	12[edi],edx		;Save H

	lea	esi,srt_p
	jmp	snxt
slp2:
;	cmp	edx,8[esi]
;	jle	sadd			;Lower?
	cmp	edx,12[esi]
	jge	sadd			;Higher?
snxt:
	mov	ecx,esi
	mov	esi,[esi]
	TST	esi
	jnz	slp2

sadd:
	mov	[ecx],edi
	mov	[edi],esi
	add	edi,BSZ

	jmp	sortlp

sortend:
	cmp	srt_p,0
	je	draw			;None?


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Get mem block

	mov	eax,(LMAX+1)*4+LMAX*256+FSZ
	call	mem_alloc
	jz	draw
	mov	dst_p,eax

	mov	ecx,LMAX		;Set all free
@@:	mov	DPTR [eax],256
	add	eax,4
	loop	@B

	mov	DPTR [eax],-1		;End
	add	eax,4

	mov	dsti_p,eax

	mov	ecx,LMAX*256/4		;Clr lines
@@:	mov	DPTR [eax],0
	add	eax,4
	loop	@B


	mov	af_p,eax
	mov	aff_p,eax


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Build TGA and face info


	mov	esi,srt_p
	CLR	eax
	mov	fcnt,eax

bldlp:

	mov	edi,dst_p		;>Find a set of free lines
	sub	edi,4
	mov	lineuse_p,edi
@@:
	add	lineuse_p,4
	mov	edi,lineuse_p
	mov	ebx,4[esi]		;Get * IMG struc
	movzx	ecx,[ebx].IMG.H
	mov	edx,8[esi]		;Get W
	mov	ebx,[edi]		;EBX=Min free line found
fndlp:
	mov	eax,[edi]		;Get free length
	add	edi,4
	TST	eax
	jl	nospc			;End of lines?
	cmp	edx,eax
	ja	@B			;No room? Restart

	cmp	ebx,254
	jae	@F			;Min is high?
	push	ebx
;	shl	ebx,1			;*2
	add	ebx,10
	cmp	eax,ebx
	pop	ebx
	jae	@B			;Current high? Restart
@@:
	cmp	eax,ebx
	jge	@F
	mov	ebx,eax			;New min
@@:
	dec	ecx
	jg	fndlp

					;>Set new size of free lines
	sub	ebx,edx			;-width

	mov	eax,lineuse_p
	sub	edi,eax
	shr	edi,2			;/4
@@:
	mov	[eax],ebx
	add	eax,4
	dec	edi
	jg	@B

	add	ebx,edx			;+width



	mov	edi,lineuse_p		;>Copy pixels
	sub	edi,dst_p
	push	edi
	shl	edi,8-2			;*256/4
	add	edi,dsti_p

	sub	ebx,256
	push	ebx
	sub	edi,ebx			;+Offset

	mov	eax,4[esi]		;Get * IMG struc
	mov	ebx,[eax].IMG.DATA_p

	mov	edx,aff_p
	mov	[eax].IMG.TEMP,edx	;Save AFACE *

	movzx	edx,[eax].IMG.H
icpylp:
	mov	ecx,8[esi]		;Get W
@@:
	mov	al,[ebx]
	mov	[edi],al
	inc	ebx
	inc	edi
	dec	ecx
	jg	@B

	add	ebx,3			;Round up src
	and	bl,0fch

	mov	eax,256			;Next dest line
	sub	eax,8[esi]		;W
	add	edi,eax

	dec	edx
	jg	icpylp


	pop	edx
	neg	edx			;X offset

	pop	ecx
	shr	ecx,2			;Line offset

	mov	edi,aff_p
	add	aff_p,sizeof AFACE

	inc	fcnt

	mov	ebx,4[esi]		;Get * IMG struc
	mov	ax,[ebx].IMG.ANIY
	shl	eax,16
	mov	ax,[ebx].IMG.ANIX
	mov	[edi].AFACE.CTRL,eax	;Ani YX for now

	CLR	eax
	mov	[edi].AFACE.PAL,eax
	mov	[edi].AFACE.O1,eax
	mov	[edi].AFACE.O2,1*3
	mov	[edi].AFACE.O3,2*3
	mov	[edi].AFACE.O4,3*3
	mov	[edi].AFACE.LINE,ecx

	mov	eax,8[esi]		;W
	dec	eax
	mov	ebx,12[esi]		;H
	dec	ebx

	mov	[edi].AFACE.AYX,dx
	add	al,dl
	mov	[edi].AFACE.BYX,ax
	mov	ah,bl
	mov	[edi].AFACE.CYX,ax
	mov	dh,bl
	mov	[edi].AFACE.DYX,dx


	mov	esi,[esi]
	TST	esi
	jnz	bldlp



;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Count used lines

	mov	esi,dst_p
	CLR	eax
	dec	eax
@@:
	inc	eax
	cmp	DPTR [esi],256
	lea	esi,4[esi]
	jb	@B

	mov	lcnt,eax


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Display


	mov	esi,dsti_p

	mov	ecx,256			;W
	CLR	eax
	mov	prtx,eax
;	mov	tw4,ax

lpx:	push	ecx

	mov	ecx,prtx
	inc	prtx
	mov	edi,ecx			;X
	shr	edi,2			;/4
;	add	di,tw4			;+Y
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	mov	dx,SC_INDEX
	out	dx,ax

	mov	ecx,400			;H
	mov	edx,256
	push	esi
lpy:
	mov	al,[esi]
;	TST	al
;	jz	zero
	mov	0a0000h[edi],al
zero:	add	esi,edx
	add	edi,SCRWB
	dec	ecx
	jg	lpy

	pop	esi
	inc	esi

	pop	ecx
	dec	ecx
	jg	lpx


	mov	eax,lcnt
	mov	bx,0ffh
	mov	cx,40*8
	mov	dx,5
	call	prt_dec


	call	waiton_keyormouse


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Open filereq

	mov	BPTR fnametmp_s,0

	mov	eax,offset fmatchtga_s
	CLR	ebx
	mov	esi,offset save_s
	mov	fmode,1
	call	filereq_open
	jnz	nospc


	mov	al,'.'				;TGA extension
	lea	edi,fnametmp_s
	mov	BPTR 8[edi],0
	call	strsrch
	mov	DPTR [edi],'AGT.'
	mov	BPTR 4[edi],0


	mov	fileerr,1

	CLR	ecx				;>Create file
	mov	edx,offset fnametmp_s
	I21CREATE
	jc	error2
	mov	ebx,eax				;BX=File handle


	mov	tga_hdr.IDLEN,0
	mov	tga_hdr.CMTYPE,1		;Palette
	mov	tga_hdr.ITYPE,1			;Uncomp colormapped
	mov	tga_hdr.FCENT,0

	mov	eax,paln
	call	pal_find
	jz	error
	mov	edi,eax

	mov	ax,[edi].PAL.NUMC
	mov	tga_hdr.CMLEN,ax

	mov	tga_hdr.CMBITS,15
	mov	tga_hdr.XO,0
	mov	tga_hdr.YO,0
	mov	tga_hdr.W,256
	mov	eax,lcnt
	mov	tga_hdr.H,ax
	mov	tga_hdr.BITSPIX,8
	mov	tga_hdr.DESC,0			;Img starts at bottom left

	mov	ecx,sizeof tga_hdr		;>Write tga header
	mov	edx,offset tga_hdr
	I21WRITE
	jc	error

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
						;>Write palette
	movzx	ecx,[edi].PAL.NUMC
	shl	ecx,1
	mov	edx,[edi].PAL.DATA_p
	I21WRITE
	jc	error				;Error?


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
						;>Write pixels
	mov	ecx,lcnt
	mov	edx,256
	dec	ecx
	imul	edx,ecx
	inc	ecx
	add	edx,dsti_p
pixlp:
	push	ecx
	mov	ecx,256
	I21WRITE
	pop	ecx
	jc	error				;Error?

	sub	edx,256

	loop	pixlp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	fileerr,0			;Clr error flag

error:
	I21CLOSE				;Close file

	cmp	fileerr,0
	je	@F
error2:
	mov	al,1
	mov	esi,offset werror_s
	call	msgbox_open

@@:


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Write ANF file


	mov	al,'.'				;ANF extension
	lea	edi,fnametmp_s
	call	strsrch
	mov	DPTR [edi],'FNA.'
	mov	BPTR 4[edi],0


	mov	fileerr,1

	CLR	ecx				;Create file
	mov	edx,offset fnametmp_s
	I21CREATE
	jc	aerr2
	mov	ebx,eax				;BX=File handle

	mov	ecx,4
	lea	edx,anf_s
	I21WRITE
	jc	aerr

	mov	ecx,4				;>Write cnt-1
	lea	edx,fcnt
	dec	DPTR [edx]
	I21WRITE
	inc	fcnt
	jc	aerr


	CLR	eax				;>Write in order
	mov	cnt,eax
afwlp:
	mov	eax,cnt
	inc	cnt
	call	img_find
	jz	afwend				;Done?

	mov	esi,[eax].IMG.TEMP
	TST	esi
	jz	afwlp				;No * AFACE ?

	mov	len,0				;Write a 0
	mov	ecx,4
	lea	edx,len
	I21WRITE
	jc	aerr
						;Write face
	mov	ecx,sizeof AFACE
	mov	edx,esi
	I21WRITE
	jc	aerr

	jmp	afwlp
afwend:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	fileerr,0			;Clr error flag

aerr:
	I21CLOSE				;Close file

	cmp	fileerr,0
	je	@F
aerr2:
	mov	al,1
	mov	esi,offset werror_s
	call	msgbox_open

@@:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

nospc:
	mov	eax,dst_p
	call	mem_free


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


draw:
	call	main_draw

	ret
 SUBEND


;********************************
;* Move selected image up in list

 SUBRP	ilst_moveup

	lea	esi,img_p

	mov	eax,ilselected
	dec	eax
	jl	x			;At top or no selection?
	jz	@F			;2nd one?
	dec	eax
	call	img_find
	jz	x			;Bad selection?
	mov	esi,eax
@@:
	mov	eax,[esi]		;*Prev
	TST	eax
	jz	x
	mov	ebx,[eax]		;*Me
	TST	ebx
	jz	x
	mov	ecx,[ebx]		;*Next
	mov	[esi],ebx		;Prev2 points to me
	mov	[ebx],eax		;I point to prev
	mov	[eax],ecx		;Prev points to next

	dec	ilselected
	call	ilst_prt
x:
	ret

 SUBEND


;********************************
;* Move selected image down in list

 SUBRP	ilst_movedn

	lea	esi,img_p

	mov	eax,ilselected
	TST	eax
	jl	x			;No selection?
	jz	@F			;1st one?
	dec	eax
	call	img_find
	jz	x			;Bad selection?
	mov	esi,eax
@@:
	mov	eax,[esi]		;*Me
	TST	eax
	jz	x
	mov	ebx,[eax]		;*Next
	TST	ebx
	jz	x
	mov	ecx,[ebx]		;*Next2
	mov	[esi],ebx		;Prev points to next
	mov	[ebx],eax		;Next point to me
	mov	[eax],ecx		;I points to next2

	inc	ilselected
	call	ilst_prt
x:
	ret

 SUBEND



;********************************
;* Add point table or del if one exists

 SUBRP	ilst_pttblchng

	call	img_findsel
	jz	x			;Bad selection?
	mov	edi,eax

	cmp	[edi].IMG.PTTBL_p,0
	jnz	havept

	mov	eax,ilselected
	call	img_pttbladd

	jmp	draw

havept:
	CLR	al
	mov	esi,offset rusure_s
	call	msgbox_open
	jnz	draw			;Canceled?

	mov	eax,[edi].IMG.PTTBL_p
	call	mem_free
	CLR	eax
	mov	[edi].IMG.PTTBL_p,eax
draw:
	call	main_draw

x:
	ret

 SUBEND



;********************************
;* Open file req for loadlbm

 SUBRP	ilst_loadlbm

	mov	BPTR fnametmp_s,0

	mov	eax,offset fmatchlbm_s
	mov	ebx,offset @F
	mov	esi,offset load_s
	mov	fmode,3
	jmp	filereq_open

lp:
	call	loadlbm
@@:
	call	filereq_getnxtmrkd
	jnz	lp


	ret

 SUBEND


;********************************
;* Load an LBM file
;* EAX = *Filename
;* Trashes all non seg

 SUBRP	loadlbm

	local	fn_p:dword	;*Filename


	mov	fn_p,eax


	mov	fileerr,1

	mov	edx,eax
	I21OPENR
	jc	error2
	mov	ebx,eax				;BX=File handle


	mov	ecx,8				;Read FORM & len
	mov	edx,offset tl1
	I21READ
	jc	error

	cmp	tl1,'MROF'
	jne	error				;!FORM?

chkform:
	mov	ecx,4				;Read form type
	mov	edx,offset tl3
	I21READ
	jc	error


	cmp	tl3,'MINA'
	je	fok				;ANIM?
	cmp	tl3,'MBLI'
	je	fok				;ILBM?
	cmp	tl3,' MBP'
	jne	error				;!PBM?
fok:
	mov	tw1,0

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

chunklp:
	CLR	ecx				;Check file boundary
	CLR	edx
	I21SETFPC
	jc	error

	test	al,1
	jz	@F				;Even?

	CLR	ecx				;Skip odd byte
	mov	dx,1
	I21SETFPC
	jc	error
@@:

	mov	ecx,8				;Read chunk & len
	mov	edx,offset tl1
	I21READ
	jc	error
	cmp	eax,ecx
	jne	eof				;End?

	mov	eax,tl2				;Length
	rol	ax,8				;Make intel
	rol	eax,16
	rol	ax,8

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ



	cmp	tl1,'MROF'
	jne	noform				;!FORM?


	jmp	chkform
noform:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	tl1,'DHMB'
	jne	nobmhd				;!BMHD?

	mov	ecx,sizeof bmhd			;Read BMHD
	mov	edx,offset bmhd
	I21READ
	jc	error

	rol	bmhd.W,8
	rol	bmhd.H,8
;	rol	bmhd.XO,8
;	rol	bmhd.YO,8
;	rol	bmhd.TCOL,8
;	rol	bmhd.PAGEW,8
;	rol	bmhd.PAGEH,8

	or	tw1,1				;Have BMHD

	jmp	chunklp

nobmhd:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	tl1,'PAMC'
	jne	nocmap				;!CMAP?

	CLR	edx
	mov	ecx,3
	div	ecx
	cmp	eax,256
	ja	error				;Too many colors?

	mov	ecx,eax				;# colors

	call	pal_alloc
	jz	error

	mov	edi,eax				;EDI=*Pal hdr

	mov	[edi].PAL.FLAGS,0
	mov	[edi].PAL.BITSPIX,8
	mov	eax,ecx
	mov	[edi].PAL.NUMC,ax

	shl	eax,1				;*2
	call	mem_alloc
	jz	error

	mov	[edi].PAL.DATA_p,eax


	mov	esi,eax
pallp:
	push	ecx
	mov	ecx,3
	mov	edx,offset tl1
	I21READ
	pop	ecx
	jc	error

	mov	al,BPTR tl1			;Red
	and	ax,0f8h
	shl	ax,7
	mov	dl,BPTR tl1+1			;Green
	and	dx,0f8h
	shl	dx,2
	or	ax,dx
	mov	dl,BPTR tl1+2			;Blue
	shr	dl,3
	or	al,dl

	mov	[esi],ax
	add	esi,2

	loop	pallp


	lea	edi,[edi].PAL.N_s

	push	edi
	mov	eax,fn_p			;Copy filename
	mov	ecx,PNAMELEN
	call	strcpylen
	pop	edi

	mov	al,'.'				;Remove extension
	call	strsrch
	mov	WPTR [edi],'P'


	or	tw1,2				;Have CMAP

	jmp	chunklp
nocmap:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	tl1,'YDOB'
	jne	nobody				;!BODY?

	cmp	tw1,3
	jne	error				;BMHD or CMAP missing?


	call	img_alloc
	jz	error
	mov	esi,eax				;ESI=*IMG struc

	movzx	eax,bmhd.W
	mov	[esi].IMG.W,ax

	movzx	edx,bmhd.H
	mov	[esi].IMG.H,dx

	add	eax,3
	and	al,0fch
	imul	eax,edx
	call	mem_alloc
	jz	error

	mov	[esi].IMG.DATA_p,eax

	mov	eax,palcnt
	dec	eax
	mov	[esi].IMG.PALNUM,ax

	CLR	eax
	mov	[esi].IMG.FLAGS,ax
	mov	[esi].IMG.ANIX,ax
	mov	[esi].IMG.ANIY,ax
	mov	[esi].IMG.ANIX2,ax
	mov	[esi].IMG.ANIY2,ax
	mov	[esi].IMG.ANIZ2,ax
	mov	[esi].IMG.PTTBL_p,eax
	mov	[esi].IMG.OPALS,-1

	mov	eax,fn_p			;Copy filename
	lea	edi,[esi].IMG.N_s
	call	strcpy

	mov	al,'.'				;Remove extension
	lea	edi,[esi].IMG.N_s
	call	strsrch
	mov	BPTR [edi],0


						;>Read pixels
	movzx	eax,[esi].IMG.H
	mov	tw4,ax
	mov	edi,[esi].IMG.DATA_p
	mov	edx,edi
pixylp:
;FIX
	cmp	tl3,'MBLI'
	jne	noti				;!ILBM

	or	tw1,4				;Have BODY

	mov	al,1
	lea	esi,ifftnosup_s
	call	msgbox_open
	jmp	eof


noti:

	cmp	bmhd.COMP,0
	je	nocomp				;None?

	mov	tl4,edi
pcomplp:
	mov	ecx,2
	mov	edx,offset tw2
	I21READ
	jc	error				;Error?
	mov	ax,tw2
	TST	al
	jl	rlen				;Repeat command?

	mov	[edi],ah			;Read literals
	inc	edi
	movzx	ecx,al
	mov	edx,edi
	I21READ
	jc	error				;Error?
	add	edi,eax
	jmp	pcompnxt
rlen:
	neg	al				;Repeat byte
@@:	mov	[edi],ah
	inc	edi
	dec	al
	jge	@B

pcompnxt:
	mov	eax,edi
	sub	eax,tl4
	movzx	ecx,[esi].IMG.W			;IFF saved as even width
	inc	ecx
	and	cl,0feh
	sub	eax,ecx
	jl	pcomplp				;More X?
;	je	@F
;	dec	di
;@@:
	add	edi,3				;Round up
	and	di,0fffch
	jmp	pixynxt


nocomp:
	movzx	ecx,[esi].IMG.W
	inc	ecx				;Round up
	and	cl,0feh
	I21READ
	jc	error				;Error?

	movzx	eax,[esi].IMG.W
	add	eax,3
	and	al,0fch
	add	edx,eax
	jc	error				;Overflow?

pixynxt:
	dec	tw4
	jg	pixylp


bdone:
	or	tw1,4				;Have BODY

	jmp	eof
nobody:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Skip unknown chunk

	mov	edx,eax
	shr	eax,16
	mov	ecx,eax
	I21SETFPC
	jc	error

	jmp	chunklp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

eof:
	cmp	tw1,7
	jne	error


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
	mov	eax,imgcnt
	dec	ax
	call	ilst_select

	call	main_draw



x:
	ret


 SUBEND


	.data
ifftnosup_s	db	"IFF type not supported yet!",0



;********************************
;* Open file req for savelbm

 SUBRP	ilst_savelbm

	mov	eax,ilselected
	call	ilst_select			;To get pal


	call	img_findsel
	jz	x
	mov	esi,eax				;ESI=*IMG struc

	lea	eax,[esi].IMG.N_s
	mov	edi,offset fnametmp_s
	mov	ecx,8
	call	strcpylen

	mov	DPTR [edi],'MBL.'
	mov	BPTR 4[edi],0


	mov	eax,offset fmatchlbm_s
	mov	ebx,offset savelbm
	mov	esi,offset save_s
	mov	fmode,1
	jmp	filereq_open

x:
	ret

 SUBEND


;********************************
;* Open file req for savelbm

 SUBRP	ilst_savelbmmrkd


	mov	eax,offset fmatchlbm_s
	CLR	ebx
	mov	esi,offset save_s
	mov	fmode,1
	call	filereq_open
	jnz	x


	CLR	ecx
	dec	ecx
lp:
	inc	ecx
	mov	eax,ecx
	call	img_find
	jz	x			;End?

	test	[eax].IMG.FLAGS,MARKED
	jz	lp

	mov	esi,eax				;ESI=*IMG struc
	push	ecx

	mov	eax,ecx
	call	ilst_select

	lea	eax,[esi].IMG.N_s
	mov	edi,offset fnametmp_s
	mov	ecx,8
	call	strcpylen

	mov	DPTR [edi],'MBL.'
	mov	BPTR 4[edi],0

	call	savelbm

	pop	ecx
	jmp	lp

x:
	ret

 SUBEND


;********************************
;* Save current image as a IFF LBM file

 SUBRP	savelbm

	pushad

	call	img_findsel
	jz	x
	mov	esi,eax				;ESI=*IMG struc


	mov	fileerr,1

	CLR	ecx				;>Create file
	mov	edx,offset fnametmp_s
	I21CREATE
	jc	error2
	mov	ebx,eax				;BX=File handle


	mov	ax,[esi].IMG.W
	rol	ax,8				;Make motorola
	mov	bmhd.W,ax
	mov	bmhd.PAGEW,ax
	mov	ax,[esi].IMG.H
	rol	ax,8				;Make motorola
	mov	bmhd.H,ax
	mov	bmhd.PAGEH,ax
	mov	bmhd.XO,0
	mov	bmhd.YO,0
	mov	bmhd.NPLANES,8
	mov	bmhd.MASKP,0
	mov	bmhd.COMP,0			;None
	mov	bmhd.TCOL,0
	mov	bmhd.XAR,5
	mov	bmhd.YAR,6


	mov	ecx,8				;>Write FORM and dummy len
	mov	edx,offset form_s
	I21WRITE
	jc	error

	mov	ecx,4				;>Write PBM
	mov	edx,offset pbm_s
	I21WRITE
	jc	error

	mov	ecx,8				;>Write BMHD and len
	mov	edx,offset bmhd_s
	I21WRITE
	jc	error

	mov	ecx,sizeof BMHD			;>Write bmhd
	mov	edx,offset bmhd
	I21WRITE
	jc	error


	mov	ecx,8				;>Write CMAP and len
	mov	edx,offset cmap_s
	I21WRITE
	jc	error

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
						;>Write palette
	mov	edi,offset pal_t
	mov	ecx,256
pallp:
	mov	ax,[edi]			;Red
	shr	ax,10
	and	al,1fh
	shl	al,3
	mov	BPTR tl1,al

	mov	ax,[edi]			;Green
	shr	ax,5
	and	al,1fh
	shl	al,3
	mov	BPTR tl1+1,al

	mov	ax,[edi]			;Blue
	and	al,1fh
	shl	al,3
	mov	BPTR tl1+2,al

	push	ecx
	mov	ecx,3
	mov	edx,offset tl1
	I21WRITE
	pop	ecx
	jc	error				;Error?

	add	edi,2
	loop	pallp

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	ecx,4				;>Write BODY
	mov	edx,offset body_s
	I21WRITE
	jc	error

	mov	ax,[esi].IMG.W
	inc	ax
	and	al,0feh
	mul	[esi].IMG.H
	rol	ax,8				;Make motorola
	rol	dx,8
	mov	WPTR tl1,dx
	mov	WPTR tl1+2,ax

	mov	ecx,4				;>Write len
	mov	edx,offset tl1
	I21WRITE
	jc	error

						;>Write pixels
	movzx	ecx,[esi].IMG.H
	mov	edx,[esi].IMG.DATA_p
pixlp:
	push	ecx
	movzx	ecx,[esi].IMG.W
	inc	ecx
	and	cl,0feh
	I21WRITE
	pop	ecx
	jc	error				;Error?

	movzx	eax,[esi].IMG.W
	add	eax,3
	and	al,0fch
	add	edx,eax

	loop	pixlp


	CLR	ecx				;>Get current file offset
	CLR	edx
	I21SETFPC
	jc	error
	sub	ax,8
	sbb	dx,0
	rol	ax,8				;Make motorola
	rol	dx,8				;Make motorola
	mov	WPTR tl1,dx
	mov	WPTR tl1+2,ax

	CLR	ecx				;>Set offset
	mov	dx,4
	I21SETFPS
	jc	error

	mov	ecx,4				;>Write FORM len
	mov	edx,offset tl1
	I21WRITE
	jc	error


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	fileerr,0			;Clr error flag

error:
	I21CLOSE				;Close file

	mov	al,fileerr
	TST	al
	jz	x
error2:
	mov	al,1
	mov	esi,offset werror_s
	call	msgbox_open

	call	main_draw

x:
	popad
	ret

 SUBEND


;********************************
;* Open file req for loadtga

 SUBRP	ilst_loadtga

	mov	BPTR fnametmp_s,0

	mov	eax,offset fmatchtga_s
	mov	ebx,offset @F
	mov	esi,offset load_s
	mov	fmode,3
	jmp	filereq_open

lp:
	call	loadtga
@@:
	call	filereq_getnxtmrkd
	jnz	lp


	ret
 SUBEND


;********************************
;* Load a TGA file
;* EAX = *Filename
;* Trashes all non seg

 SUBRP	loadtga

	local	fn_p:dword	;*Filename


	mov	fn_p,eax


	mov	fileerr,1


	mov	edx,eax
	I21OPENR
	jc	error2
	mov	ebx,eax				;BX=File handle

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
	cmp	tga_hdr.CMBITS,16
	je	@F				;OK?
	cmp	tga_hdr.CMBITS,15
	jne	error				;Bad pal type?
@@:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	call	img_alloc
	jz	error
	mov	esi,eax				;ESI=*IMG struc

	movsx	eax,tga_hdr.W
	mov	[esi].IMG.W,ax
	TST	eax
	jle	error

	movsx	edx,tga_hdr.H
	mov	[esi].IMG.H,dx
	TST	edx
	jle	error

	add	ax,3
	and	al,0fch
	imul	eax,edx
	call	mem_alloc
	jz	error
	mov	[esi].IMG.DATA_p,eax

	mov	eax,palcnt
	mov	[esi].IMG.PALNUM,ax

	CLR	eax
	mov	[esi].IMG.FLAGS,ax
	mov	[esi].IMG.ANIX,ax
	mov	[esi].IMG.ANIY,ax
	mov	[esi].IMG.ANIX2,ax
	mov	[esi].IMG.ANIY2,ax
	mov	[esi].IMG.ANIZ2,ax
	mov	[esi].IMG.PTTBL_p,eax
	mov	[esi].IMG.OPALS,-1

	mov	eax,fn_p			;Copy filename
	lea	edi,[esi].IMG.N_s
	call	strcpy

	mov	al,'.'				;Remove extension
	lea	edi,[esi].IMG.N_s
	call	strsrch
	mov	BPTR [edi],0


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				;>Read palette


	movzx	ecx,tga_hdr.CMLEN

	mov	eax,ecx
	shl	eax,1				;*2
	call	mem_alloc
	jz	error

	mov	tl2,eax

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


	call	pal_alloc
	jz	error
	mov	edi,eax				;EDI=*Pal hdr

	mov	eax,tl2
	mov	[edi].PAL.DATA_p,eax
	mov	[edi].PAL.FLAGS,0
	mov	[edi].PAL.BITSPIX,8

	mov	ax,tga_hdr.CMLEN
	mov	[edi].PAL.NUMC,ax

	lea	edi,[edi].PAL.N_s
	push	edi
	mov	eax,fn_p			;Copy filename
	mov	ecx,PNAMELEN
	call	strcpylen
	pop	edi

	mov	al,'.'				;Remove extension
	call	strsrch
	mov	WPTR [edi],'P'


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				;>Read pixels


	movzx	ecx,tga_hdr.H
	CLR	edx
	test	tga_hdr.DESC,10h
	jnz	@F				;Going down?
	movzx	edx,tga_hdr.W
	add	dx,3
	and	dl,0fch
	dec	ecx
	imul	edx,ecx
	inc	ecx
@@:
	add	edx,[esi].IMG.DATA_p
pixlp:
	push	ecx
	movzx	ecx,tga_hdr.W
	I21READ
	pop	ecx
	jc	error				;Error?

	movzx	eax,tga_hdr.W
	add	ax,3
	and	al,0fch
	test	tga_hdr.DESC,10h
	jnz	@F				;Going down?
	neg	eax
@@:	add	edx,eax

	loop	pixlp



;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	mov	fileerr,0			;Clr error flag

error:
	I21CLOSE				;Close file

	cmp	fileerr,0
	je	ok
error2:
	mov	al,1
	mov	esi,offset rerror_s
	call	msgbox_open			;Must be near call

ok:
	mov	eax,imgcnt
	dec	ax
	call	ilst_select

	call	main_draw



x:
	ret

 SUBEND


;********************************
;* Open file req for savetga

 SUBRP	ilst_savetga

	mov	eax,ilselected
	call	ilst_select

	call	img_findsel
	jz	x
	mov	esi,eax				;ESI=*IMG struc

	lea	eax,[esi].IMG.N_s
	mov	edi,offset fnametmp_s
	mov	ecx,8
	call	strcpylen

	mov	DPTR [edi],'AGT.'
	mov	BPTR 4[edi],0


	mov	eax,offset fmatchtga_s
	mov	ebx,offset savetga
	mov	esi,offset save_s
	mov	fmode,1
	jmp	filereq_open

x:
	ret

 SUBEND


;********************************
;* Save current image as a TGA file

 SUBRP	savetga


	call	img_findsel
	jz	x
	mov	esi,eax				;ESI=*IMG struc


	mov	fileerr,1

	CLR	ecx				;>Create file
	mov	edx,offset fnametmp_s
	I21CREATE
	jc	error2
	mov	ebx,eax				;BX=File handle


	mov	tga_hdr.IDLEN,0
	mov	tga_hdr.CMTYPE,1		;Palette
	mov	tga_hdr.ITYPE,1			;Uncomp colormapped
	mov	tga_hdr.FCENT,0

	movsx	eax,[esi].IMG.PALNUM
	call	pal_find
	jz	error
	mov	edi,eax

	mov	ax,[edi].PAL.NUMC
	mov	tga_hdr.CMLEN,ax

	mov	tga_hdr.CMBITS,15
	mov	tga_hdr.XO,0
	mov	tga_hdr.YO,0
	mov	ax,[esi].IMG.W
	mov	tga_hdr.W,ax
	mov	ax,[esi].IMG.H
	mov	tga_hdr.H,ax
	mov	tga_hdr.BITSPIX,8
	mov	tga_hdr.DESC,0			;Img starts at bottom left

	mov	ecx,sizeof tga_hdr		;>Write tga header
	mov	edx,offset tga_hdr
	I21WRITE
	jc	error

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
						;>Write palette
	movzx	ecx,[edi].PAL.NUMC
	shl	ecx,1
	mov	edx,[edi].PAL.DATA_p
	I21WRITE
	jc	error				;Error?


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
						;>Write pixels
	movzx	ecx,[esi].IMG.H
	movzx	edx,[esi].IMG.W
	add	dx,3
	and	dl,0fch
	dec	ecx
	imul	edx,ecx
	inc	ecx
	add	edx,[esi].IMG.DATA_p
pixlp:
	push	ecx
	movzx	ecx,[esi].IMG.W
	I21WRITE
	pop	ecx
	jc	error				;Error?

	movzx	eax,[esi].IMG.W
	add	ax,3
	and	al,0fch
	sub	edx,eax

	loop	pixlp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	fileerr,0			;Clr error flag

error:
	I21CLOSE				;Close file

	mov	al,fileerr
	TST	al
	jz	x
error2:
	mov	al,1
	mov	esi,offset werror_s
	call	msgbox_open			;Must be near call

	call	main_draw


x:
	ret

 SUBEND






;********************************
;* Write temp anilst file from marked images
;* Trashes all non seg

 SUBRP	ilst_wanilstmrkd

	local	cnt:dword,\
		aninum:dword

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Open filereq

	mov	DPTR fpath_s,'\:d'
	mov	WPTR fnametmp_s,'x'

	mov	eax,offset fmatch_s
	CLR	ebx
	mov	esi,offset save_s
	mov	fmode,1
	call	filereq_open
	jnz	draw

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	fileerr,1

	CLR	ecx				;>Create file
	mov	edx,offset fnametmp_s
	I21CREATE
	jc	error2
	mov	ebx,eax				;BX=File handle

	lea	edx,anilst1_s
	call	strwrite
	jc	error


	CLR	eax
	mov	aninum,eax
	mov	cnt,eax
ilp:
	mov	eax,cnt
	inc	cnt
	call	img_find
	jz	iend				;Done?

	test	[eax].IMG.FLAGS,MARKED
	jz	ilp


	lea	esi,[eax].IMG.N_s

	lea	edx,anilstw_s			;.word
	call	strwrite
	jc	error

	mov	eax,aninum
	lea	edi,tmp_s
	call	stritoa

	lea	edx,tmp_s			;Index
	call	strwrite
	jc	error

	lea	edx,anilstc_s			;Tab & ;
	call	strwrite
	jc	error

	mov	edx,esi				;Image name
	call	strwrite
	jc	error

	lea	edx,crlf_s			;CR & LF
	call	strwrite
	jc	error

	inc	aninum


	jmp	ilp
iend:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	fileerr,0			;Clr error flag

error:
	I21CLOSE				;Close file

	cmp	fileerr,0
	je	@F
error2:
	mov	al,1
	mov	esi,offset werror_s
	call	msgbox_open

@@:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


draw:
	call	main_draw

	ret
 SUBEND

	.data
anilst1_s	db	"	.asg	1,N",13,10,0
anilstw_s	db	"	.word	N,",0
anilstc_s	db	"	;",0



;********************************
;* Unmark all images

 SUBRP	ilmrk_clrall


	lea	esi,img_p
	jmp	nxt
lp:
	and	[esi].IMG.FLAGS,not MARKED	;Clr

nxt:	mov	esi,[esi]
	TST	esi
	jnz	lp

	jmp	ilst_prt

 SUBEND

;********************************
;* Mark all images

 SUBRP	ilmrk_setall


	lea	esi,img_p
	jmp	nxt
lp:
	or	[esi].IMG.FLAGS,MARKED		;Set

nxt:	mov	esi,[esi]
	TST	esi
	jnz	lp

	jmp	ilst_prt

 SUBEND


;********************************
;* Invert marks on all images

 SUBRP	ilmrk_invertall


	lea	esi,img_p
	jmp	nxt
lp:
	xor	[esi].IMG.FLAGS,MARKED

nxt:	mov	esi,[esi]
	TST	esi
	jnz	lp

	jmp	ilst_prt

 SUBEND



;****************************************************************
;* Multi part box gadgets
;* AX=Gadget ID

 SUBRP	mpbox_gads

	pushad


	TST	al
	jnz	n0

	call	mpbox_nxtused
	call	main_draw

	jmp	x

n0:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,10h
	jne	n10
	call	mpbox_delcur

	jmp	x
n10:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

;	cmp	al,20h
;	jne	n20

	call	mpbox_togon

x:
	popad
	ret

 SUBEND



;********************************
;* Add one multi part box to current img

 SUBRP	mpbox_add

	local	imgw:dword,
		imgh:dword,
		pt_p:dword,
		cnt:dword


	call	img_findsel
	jz	x			;Bad selection?
	mov	edi,eax

	mov	esi,[edi].IMG.PTTBL_p
	TST	esi
	jnz	hvpt			;Exists?

	mov	eax,ilselected
	call	img_pttbladd
	jz	x			;Error?
	mov	esi,eax

hvpt:
	mov	cx,iwincx
	mov	dx,iwincy
	sub	cx,[edi].IMG.ANIX
	sub	dx,[edi].IMG.ANIY
	movsx	ecx,cx
	movsx	edx,dx
	mov	tl1,ecx
	mov	tl2,edx
	movzx	eax,[edi].IMG.W
	mov	imgw,eax
	movzx	eax,[edi].IMG.H
	mov	imgh,eax


	CLR	ebx
	mov	ecx,PTBOXNUM
	lea	esi,[esi].PTTBL.BOX
boxlp:
	cmp	DPTR [esi],0
	je	fnd			;Not in use?

	inc	ebx
	add	esi,sizeof PTBOX
	loop	boxlp

	jmp	x			;No free boxes!

fnd:
	mov	mpboxselect,ebx
	add	bl,'1'
	mov	mpbsel_s,bl


	mov	eax,bndboxx1
	mov	ebx,bndboxx2
	cmp	ebx,eax
	jge	@F			;EBX bigger?
	xchg	eax,ebx
@@:
	sub	eax,tl1
	jge	@F			;Above left X?
	CLR	eax
@@:	cmp	eax,imgw
	jl	@F			;Within width?
	mov	eax,imgw
	dec	eax
@@:	cmp	eax,255
	jle	@F			;Within max?
	mov	eax,255
@@:
	mov	[esi].PTBOX.X,al

	sub	ebx,tl1			;EBX=Width-1
	cmp	ebx,imgw
	jl	@F			;Within width?
	mov	ebx,imgw
	dec	ebx
@@:
	sub	ebx,eax			;Make offset
	jge	@F
	CLR	ebx
@@:	cmp	ebx,255
	jle	@F			;Within max?
	mov	ebx,255
@@:
	mov	[esi].PTBOX.W,bl


	mov	eax,bndboxy1
	mov	ebx,bndboxy2
	cmp	ebx,eax
	jge	@F			;EBX bigger?
	xchg	eax,ebx
@@:
	sub	eax,tl2
	jge	@F			;Below top Y?
	CLR	eax
@@:	cmp	eax,imgh
	jl	@F			;Within height?
	mov	eax,imgh
	dec	eax
@@:	cmp	eax,255
	jle	@F			;Within max?
	mov	eax,255
@@:
	mov	[esi].PTBOX.Y,al

	sub	ebx,tl2			;EBX=Height-1
	cmp	ebx,imgh
	jl	@F			;Within height?
	mov	ebx,imgh
	dec	ebx
@@:
	sub	ebx,eax			;Make offset
	jge	@F
	CLR	ebx
@@:	cmp	ebx,255
	jle	@F			;Within max?
	mov	ebx,255
@@:
	mov	[esi].PTBOX.H,bl


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Get work buffer


	movzx	eax,[edi].IMG.W
	add	eax,3
	and	al,0fch
	mov	imgdataw,eax


	movzx	ecx,[edi].IMG.H
	imul	ecx,eax
	mov	eax,ecx
	call	mem_alloc
	jz	x			;No mem?
	mov	[edi].IMG.TEMP,eax
	mov	ebx,[edi].IMG.DATA_p
@@:
	mov	dl,[ebx]		;Copy img
	mov	[eax],dl
	inc	ebx
	inc	eax

	dec	ecx
	jg	@B


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Clr pixels in work buf of prev def boxes

	mov	pt_p,esi
	push	esi

	mov	esi,[edi].IMG.PTTBL_p
	lea	esi,[esi].PTTBL.BOX

	mov	ecx,PTBOXNUM
cboxlp:
	cmp	DPTR [esi],0
	je	cboxnxt			;Not in use?

	cmp	esi,pt_p
	je	cboxnxt

	push	ecx

	movzx	eax,[esi].PTBOX.H
	mov	cnt,eax

	movzx	edx,[esi].PTBOX.X
	movzx	ebx,[esi].PTBOX.Y
	imul	ebx,imgdataw
	add	ebx,edx
	add	ebx,[edi].IMG.TEMP
cylp:
	movzx	ecx,[esi].PTBOX.W	;W-1
	mov	edx,ecx
	inc	edx
cxlp:
	mov	BPTR [ebx],0
	inc	ebx			;Next X

	dec	ecx
	jge	cxlp

	add	ebx,imgdataw
	sub	ebx,edx

	dec	cnt
	jge	cylp

	pop	ecx

cboxnxt:
	add	esi,sizeof PTBOX
	loop	cboxlp

	pop	esi


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Do least square on box


lxlp:					;>Check left edge
	movzx	edx,[esi].PTBOX.X
	movzx	ebx,[esi].PTBOX.Y
	imul	ebx,imgdataw
	add	ebx,edx
	add	ebx,[edi].IMG.TEMP

	movzx	ecx,[esi].PTBOX.H
lylp:
	cmp	BPTR [ebx],0
	jne	lok

	add	ebx,imgdataw		;Next Y

	dec	ecx
	jge	lylp

	inc	[esi].PTBOX.X
	jz	abort
	sub	[esi].PTBOX.W,1
	jnc	lxlp
	jmp	abort
lok:

rxlp:					;>Check rgt edge
	movzx	edx,[esi].PTBOX.X
	movzx	eax,[esi].PTBOX.W
	add	edx,eax
	movzx	ebx,[esi].PTBOX.Y
	imul	ebx,imgdataw
	add	ebx,edx
	add	ebx,[edi].IMG.TEMP

	movzx	ecx,[esi].PTBOX.H
rylp:
	cmp	BPTR [ebx],0
	jne	rok

	add	ebx,imgdataw		;Next Y

	dec	ecx
	jge	rylp

	sub	[esi].PTBOX.W,1
	jnc	rxlp
	jmp	abort
rok:

tylp:					;>Check top edge
	movzx	edx,[esi].PTBOX.X
	movzx	ebx,[esi].PTBOX.Y
	imul	ebx,imgdataw
	add	ebx,edx
	add	ebx,[edi].IMG.TEMP

	movzx	ecx,[esi].PTBOX.W
txlp:
	cmp	BPTR [ebx],0
	jne	tok

	inc	ebx			;Next X

	dec	ecx
	jge	txlp

	inc	[esi].PTBOX.Y
	jz	abort
	sub	[esi].PTBOX.H,1
	jnc	tylp
	jmp	abort
tok:

bylp:					;>Check bot edge
	movzx	edx,[esi].PTBOX.X
	movzx	ebx,[esi].PTBOX.Y
	movzx	eax,[esi].PTBOX.H
	add	ebx,eax
	imul	ebx,imgdataw
	add	ebx,edx
	add	ebx,[edi].IMG.TEMP

	movzx	ecx,[esi].PTBOX.W
bxlp:
	cmp	BPTR [ebx],0
	jne	bok

	inc	ebx			;Next X

	dec	ecx
	jge	bxlp

	sub	[esi].PTBOX.H,1
	jnc	bylp
	jmp	abort
bok:


	jmp	@F


abort:
	CLR	eax
	mov	[esi],eax

@@:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	mov	eax,[edi].IMG.TEMP	;Work buf
	call	mem_free


	CLR	eax
	mov	bndboxx1,eax
	mov	bndboxy1,eax
	mov	bndboxx2,eax
	mov	bndboxy2,eax


	call	main_draw

x:
	ret

 SUBEND


;********************************
;* Delete current multi part box of current img

 SUBRP	mpbox_delcur


	call	img_findsel
	jz	x			;Bad selection?
	mov	edi,eax

	mov	esi,[edi].IMG.PTTBL_p
	TST	esi
	jz	x			;None?

	lea	esi,[esi].PTTBL.BOX
	mov	eax,mpboxselect
	imul	eax,sizeof PTBOX
	mov	DPTR [esi+eax],0

	call	mpbox_nxtused

	call	main_draw

x:
	ret

 SUBEND


;********************************
;* Select next used multi part box of current img
;* Trashes EAX

 SUBRP	mpbox_nxtused

	PUSHMR	ebx,esi

	call	img_findsel
	jz	x			;Bad selection?

	mov	esi,[eax].IMG.PTTBL_p
	TST	esi
	jz	x			;None?

	mov	ebx,mpboxselect

lp:
	mov	eax,mpboxselect
	inc	eax
	cmp	eax,PTBOXNUM
	jb	@F
	CLR	eax
@@:	mov	mpboxselect,eax
	cmp	eax,ebx
	je	x			;Wrapped to start?

	imul	eax,sizeof PTBOX

	cmp	DPTR [esi+eax].PTTBL.BOX,0
	je	lp			;Free?

	mov	eax,mpboxselect
	add	al,'1'
	mov	mpbsel_s,al

x:
	POPMR
	ret

 SUBEND


;********************************
;* Toggle mode of multipart boxes on or off
;* Trashes all non seg

 SUBRP	mpbox_togon


	lea	eax,mpboff_s
	not	mpboxon
	cmp	mpboxon,0
	je	@F
	lea	eax,mpbon_s
@@:
	lea	esi,mpboo_gad
	mov	[esi].GAD.TXT_p,eax

	jmp	main_draw


 SUBEND



;****************************************************************
;* Collision box gadgets
;* AX = Gadget ID

 SUBRP	cbox_gads

	pushad


	TST	al
	jnz	n0

	call	cbox_delcur

	jmp	x

n0:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,20h
	jne	n20

	call	cbox_togon

	jmp	x

n20:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	call	cbox_copytomrkd

x:
	popad
	ret

 SUBEND



;********************************
;* Add collision box to current img

 SUBRP	cbox_add

	local	imgw:dword,
		imgh:dword,
		pt_p:dword,
		cnt:dword


	call	img_findsel
	jz	x			;Bad selection?
	mov	edi,eax

	mov	esi,[edi].IMG.PTTBL_p
	TST	esi
	jnz	hvpt			;Exists?

	mov	eax,ilselected
	call	img_pttbladd
	jz	x			;Error?
	mov	esi,eax

hvpt:
	mov	cx,iwincx
	mov	dx,iwincy
	sub	cx,[edi].IMG.ANIX
	sub	dx,[edi].IMG.ANIY
	movsx	ecx,cx
	movsx	edx,dx
	mov	tl1,ecx
	mov	tl2,edx
	movzx	eax,[edi].IMG.W
	mov	imgw,eax
	movzx	eax,[edi].IMG.H
	mov	imgh,eax


	lea	esi,[esi].PTTBL.CBOX


	mov	eax,bndboxx1
	mov	ebx,bndboxx2
	cmp	ebx,eax
	jge	@F			;EBX bigger?
	xchg	eax,ebx
@@:
	sub	eax,tl1
	cmp	eax,-128
	jge	@F			;Within max?
	mov	eax,-128

;	jge	@F			;Above left X?
;	CLR	eax
;@@:	cmp	eax,imgw
;	jl	@F			;Within width?
;	mov	eax,imgw
;	dec	eax
@@:	cmp	eax,127
	jle	@F			;Within max?
	mov	eax,127
@@:
	mov	[esi].PTCBOX.X,al

	sub	ebx,tl1			;EBX=Width-1
;	cmp	ebx,imgw
;	jl	@F			;Within width?
;	mov	ebx,imgw
;	dec	ebx
;@@:
	sub	ebx,eax			;Make offset
	jge	@F
	CLR	ebx
@@:	cmp	ebx,255
	jle	@F			;Within max?
	mov	ebx,255
@@:
	mov	[esi].PTCBOX.W,bl


	mov	eax,bndboxy1
	mov	ebx,bndboxy2
	cmp	ebx,eax
	jge	@F			;EBX bigger?
	xchg	eax,ebx
@@:
	sub	eax,tl2
	cmp	eax,-128
	jge	@F			;Within max?
	mov	eax,-128

;	jge	@F			;Below top Y?
;	CLR	eax
;@@:	cmp	eax,imgh
;	jl	@F			;Within height?
;	mov	eax,imgh
;	dec	eax
@@:	cmp	eax,127
	jle	@F			;Within max?
	mov	eax,127
@@:
	mov	[esi].PTCBOX.Y,al

	sub	ebx,tl2			;EBX=Height-1
;	cmp	ebx,imgh
;	jl	@F			;Within height?
;	mov	ebx,imgh
;	dec	ebx
;@@:
	sub	ebx,eax			;Make offset
	jge	@F
	CLR	ebx
@@:	cmp	ebx,255
	jle	@F			;Within max?
	mov	ebx,255
@@:
	mov	[esi].PTCBOX.H,bl



;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	CLR	eax
	mov	bndboxx1,eax
	mov	bndboxy1,eax
	mov	bndboxx2,eax
	mov	bndboxy2,eax


	call	main_draw

x:
	ret

 SUBEND


;********************************
;* Delete collision box of current img

 SUBRP	cbox_delcur


	call	img_findsel
	jz	x			;Bad selection?
	mov	edi,eax

	mov	esi,[edi].IMG.PTTBL_p
	TST	esi
	jz	x			;None?

	CLR	eax
	mov	DPTR [esi].PTTBL.CBOX,eax

	call	main_draw

x:
	ret

 SUBEND


;********************************
;* Toggle mode of multipart boxes on or off
;* Trashes all non seg

 SUBRP	cbox_togon


	lea	eax,cboff_s
	not	cboxon
	cmp	cboxon,0
	je	@F
	lea	eax,cbon_s
@@:
	lea	esi,cboo_gad
	mov	[esi].GAD.TXT_p,eax

	jmp	main_draw


 SUBEND

;********************************
;* Copy cbox to marked images

 SUBRP	cbox_copytomrkd

	call	img_findsel
	jz	x				;Bad selection?
	mov	edi,eax

	mov	esi,[edi].IMG.PTTBL_p
	TST	esi
	jz	x				;None?

	CLR	ecx
	dec	ecx

lp:	inc	ecx
	mov	eax,ecx
	call	img_find
	jz	x				;Done?
	mov	edx,eax

	test	[edx].IMG.FLAGS,MARKED
	jz	lp

	mov	ebx,[edx].IMG.PTTBL_p
	TST	ebx
	jnz	hvpt				;Exists?

	mov	eax,ecx
	call	img_pttbladd
	jz	lp				;Error?
	mov	ebx,eax
hvpt:

	movsx	ax,[esi].PTTBL.CBOX.X		;Keep relative to anipt
	sub	ax,[edi].IMG.ANIX
	add	ax,[edx].IMG.ANIX
	mov	[ebx].PTTBL.CBOX.X,al

	movsx	ax,[esi].PTTBL.CBOX.Y
	sub	ax,[edi].IMG.ANIY
	add	ax,[edx].IMG.ANIY
	mov	[ebx].PTTBL.CBOX.Y,al

	mov	ax,WPTR [esi].PTTBL.CBOX.W	;&H
	mov	WPTR [ebx].PTTBL.CBOX.W,ax

	jmp	lp

x:
	jmp	main_draw

 SUBEND



;****************************************************************
;* Image window gadgets
;* AX = Gadget ID
;* Trashes all non seg

 SUBRP	iwin_gads


	TST	al
	jnz	n0

	test	mousebut,1
	jz	gadup			;Gad released

	movsx	ecx,mousex
	movsx	edx,mousey

	test	mousebchg,1
	jz	@F			;No change?

	mov	bndboxx1,ecx
	mov	bndboxy1,edx
@@:
	mov	bndboxx2,ecx
	mov	bndboxy2,edx

	call	img_prt

	jmp	x

gadup:
	cmp	mpboxon,0
	je	@F
	call	mpbox_add
@@:
	cmp	cboxon,0
	je	@F
	call	cbox_add
@@:
	jmp	x

n0:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	al,8
	jne	n8

	mov	eax,offset img_prt
	mov	cx,64
	mov	dx,cx
	mov	edi,offset iwincx
	jmp	scrl
n8:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	eax,offset iwin_showscale
	mov	cx,64
	mov	dx,cx
	mov	edi,offset iwinsclx
scrl:	call	gad_mousescroller


x:
	ret

 SUBEND


;********************************
;* Image window key functions
;* AX=Key code

 SUBRP	iwin_keys

	mov	dx,ax

;	mov	al,libloaded
;	TST	al
;	jz	x			;Not loaded?

	cmp	dl,'T'			;>Toggle display on anipts
	jne	@F

	not	iwinanipton
@@:

	cmp	dl,'2'			;>Toggle ani2 link mode
	jne	@F

	not	ani2link
@@:

	cmp	dl,'p'			;>Toggle draw priority
	jne	@F

	not	drawpri
@@:

	cmp	dl,'r'			;>Drop reference mark
	jne	@F
	mov	ax,anipt2x
	mov	iwinrx,ax
	mov	ax,anipt2y
	mov	iwinry,ax
	jmp	ssc

@@:
	cmp	dl,'d'			;>Double scale
	jne	@F
	shr	iwinsclx,1		;/2
	shr	iwinscly,1
@@:
	cmp	dl,'D'			;>Half scale
	jne	@F
	shl	iwinsclx,1		;*2
	shl	iwinscly,1
@@:
	cmp	dh,85h			;>Decrease scale (F11)
	jne	@F
	add	iwinsclx,1
	add	iwinscly,1
@@:
	cmp	dh,86h			;>Increase scale (F12)
	jne	@F
	sub	iwinsclx,1
	sub	iwinscly,1
@@:
ssc:	call	iwin_showscale


x:	ret

 SUBEND


;********************************
;* Show scale values and image
;* Trashes all non seg except esi

 SUBRP	iwin_showscale

	push	esi

	mov	ax,iwinsclx	;>Get scale and verify
	cmp	ax,20h
	jge	@F
	mov	ax,20h
@@:	cmp	ax,800h
	jbe	@F
	mov	ax,800h
@@:	mov	iwinsclx,ax

	mov	bx,0ffh
	mov	cx,246
	mov	dx,215
	call	prt_hexword

	mov	ax,iwinscly	;>Get scale and verify
	cmp	ax,20h
	jge	@F
	mov	ax,20h
@@:	cmp	ax,800h
	jbe	@F
	mov	ax,800h
@@:	mov	iwinscly,ax

	mov	bx,0ffh
	mov	cx,246
	mov	dx,215+9
	call	prt_hexword

	pop	esi

	jmp	img_prt


 SUBEND


;********************************
;* Clear img window

 SUBRP	iwin_clr

	mov	ax,0f00h+SC_MAPMASK	;>Clr iwin
	mov	dx,SC_INDEX
	out	dx,ax

	cld

	CLR	eax
	mov	edi,0a0000h
	mov	edx,200
clrlp:
	mov	ecx,320/4/4
	rep	stosd

	add	edi,320/4		;Next Y
	dec	edx
	jg	clrlp

	ret

 SUBEND


;********************************
;* Prints selected image in img win
;* Trashes none

 SUBRP	img_prt

	pushad

	call	iwin_clr

;	CLR	ecx
;	dec	ecx
;
;lp:	inc	ecx
;	mov	eax,ecx
;	call	img_find
;	jz	dn			;Done?
;
;	test	[eax].IMG.FLAGS,MARKED
;	jz	lp
;
;	mov	eax,ecx
;	call	img_draw
;	jmp	lp
;dn:

	cmp	drawpri,0
	je	@F

	mov	eax,ilselected
	CLR	ecx
	CLR	edx
	call	img_draw		;1st list
@@:

	CLR	ecx
	CLR	edx
	mov	eax,ilselected
	call	img_find
	jz	nosh

	cmp	ani2link,0
	je	@F
	mov	cx,[eax].IMG.ANIX
	mov	dx,[eax].IMG.ANIY
	neg	ecx
	neg	edx
	add	cx,[eax].IMG.ANIX2
	add	dx,[eax].IMG.ANIY2
	movsx	ecx,cx
	movsx	edx,dx
@@:
	mov	eax,[eax].IMG.PTTBL_p
	TST	eax
	jz	nosh
	movsx	ebx,[eax].PTTBL.ID
	dec	ebx
	jge	@F
nosh:
	mov	ebx,il2selected		;2nd list
@@:
	call	ilst_nxtlst
	mov	eax,ebx
	call	img_draw

	call	ilst_nxtlst


	cmp	drawpri,0
	jne	@F

	mov	eax,ilselected
	CLR	ecx
	CLR	edx
	call	img_draw		;1st list
@@:

x:
	popad
	ret

 SUBEND


;********************************
;* Draw image in image window
;* EAX = Img #
;* ECX = X offset
;* EDX = Y offset
;* Trashes none

 SUBRP	img_draw

	pushad


	mov	tl3,ecx
	mov	tl4,edx


	cmp	iwinsclx,100h
	jne	img_drawscaled		;Scaled?
	cmp	iwinscly,100h
	jne	img_drawscaled		;Scaled?



;	mov	bl,255			;>Draw anipt1
;	mov	cx,iwincx
;	mov	dx,iwincy
;	call	crossh_draw


	call	img_find
	jz	noimg			;None?
	mov	ebx,eax

	add	cx,iwincx
	add	dx,iwincy
	sub	cx,[ebx].IMG.ANIX
	sub	dx,[ebx].IMG.ANIY
	movsx	ecx,cx
	movsx	edx,dx
	mov	prtx,ecx
	mov	prty,edx


	CLR	esi			;ESI=*Img data
	mov	cx,[ebx].IMG.H

	TST	edx
	jge	topok

	add	cx,dx
	jle	done			;Completely off top?

	movzx	eax,[ebx].IMG.W		;Data width
	add	ax,3
	and	al,0fch
	neg	edx
	mov	esi,edx
	imul	esi,eax			;ESI=*Img data
	CLR	edx
	mov	tw4,dx			;Y offset
	jmp	@F
topok:
	mov	eax,SCRWB
	imul	eax,edx
	mov	tw4,ax			;Y offset
@@:
	mov	ax,drawclipy
	sub	ax,dx			;Lines left
	jle	done			;Completely off bottom?

	cmp	cx,ax
	jbe	sethgt			;OK?
	mov	cx,ax			;Clip bottom

sethgt:	mov	tw2,cx			;Save height


	add	esi,[ebx].IMG.DATA_p

	movzx	ecx,[ebx].IMG.W
	mov	eax,ecx
	add	eax,3
	and	al,0fch			;Min width 4 in steps of 4
	mov	imgdataw,eax

	mov	eax,prtx
	TST	eax
	jge	@F			;No left clip?
	add	ecx,eax
	jle	done			;All left clipped?
	neg	eax
	add	esi,eax
	mov	prtx,0
@@:
	mov	eax,prtx
	add	eax,ecx
	sub	eax,640
	jle	@F			;No right clip?
	sub	ecx,eax
	jle	done			;All right clipped?
@@:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

lpx:	push	ecx

	mov	ecx,prtx
	inc	prtx
	mov	edi,ecx			;X
	shr	edi,2			;/4
	add	di,tw4			;+Y
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	mov	dx,SC_INDEX
	out	dx,ax

	movzx	ecx,tw2			;Height
	mov	edx,imgdataw
	push	esi
lpy:
	mov	al,[esi]
	TST	al
	jz	zero
	mov	0a0000h[edi],al
zero:	add	esi,edx
	add	edi,SCRWB
	dec	ecx
	jg	lpy

	pop	esi
	inc	esi

	pop	ecx
	dec	ecx
	jg	lpx

done:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	cmp	iwinanipton,0
	je	noap

	push	ebx
	mov	bl,255			;>Draw anipt1
	mov	ecx,tl3
	mov	edx,tl4
	add	cx,iwincx
	add	dx,iwincy
	call	crossh_draw
	pop	ebx


	push	ebx
	mov	cx,[ebx].IMG.ANIX2	;>Draw anipt2
	mov	dx,[ebx].IMG.ANIY2
	cmp	dx,-200
	jg	ynorm
	CLR	edx
ynorm:	add	cx,iwincx
	add	dx,iwincy
	sub	cx,[ebx].IMG.ANIX
	sub	dx,[ebx].IMG.ANIY
	mov	anipt2x,cx		;Save
	mov	anipt2y,dx
	mov	bl,0feh
	call	crossh_draw
	pop	ebx


	mov	esi,[ebx].IMG.PTTBL_p	;>Draw anipt3
	TST	esi
	jz	@F			;None?

	push	ebx
	mov	cx,[esi].PTTBL.X
	mov	dx,[esi].PTTBL.Y
	add	cx,iwincx
	add	dx,iwincy
	sub	cx,[ebx].IMG.ANIX
	sub	dx,[ebx].IMG.ANIY
	mov	bl,0fch
	call	crossh_draw
	pop	ebx
@@:

;	mov	cx,iwinrx		;Draw reference mark
;	TST	cx
;	jl	@F
;	mov	dx,iwinry
;	mov	bl,0fdh
;	call	crossh_drawsml
;@@:

noap:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	mov	esi,[ebx].IMG.PTTBL_p	;>Draw multi part & collision boxes
	TST	esi
	jz	noboxes			;None?



	cmp	mpboxon,0
	je	nobox			;Hidden?

	push	ebx

	mov	ecx,tl3
	mov	edx,tl4
	add	cx,iwincx
	add	dx,iwincy
	sub	cx,[ebx].IMG.ANIX
	sub	dx,[ebx].IMG.ANIY
	movsx	ecx,cx
	movsx	edx,dx
	mov	tl1,ecx
	mov	tl2,edx


	CLR	ecx
	lea	esi,[esi].PTTBL.BOX
boxlp:
	cmp	DPTR [esi],0
	je	boxnxt			;Not in use?

	mov	prtcolors,0feh

	cmp	ecx,mpboxselect
	jne	@F
	mov	prtcolors,0ffh		;Yellow
@@:
	PUSHM	ecx,edi

	movzx	eax,[esi].PTBOX.X
	movzx	ebx,[esi].PTBOX.Y
	add	eax,tl1
	add	ebx,tl2
	movzx	ecx,[esi].PTBOX.W
	movzx	edx,[esi].PTBOX.H
	add	ecx,eax
	add	edx,ebx
	call	boxh_drawclip

	POPM	ecx,edi
boxnxt:
	add	esi,sizeof PTBOX
	inc	ecx
	cmp	ecx,PTBOXNUM
	jb	boxlp


	pop	ebx


nobox:

	cmp	cboxon,0
	je	nocbox			;Hidden?

	push	ebx

	mov	ecx,tl3
	mov	edx,tl4
	add	cx,iwincx
	add	dx,iwincy
	sub	cx,[ebx].IMG.ANIX
	sub	dx,[ebx].IMG.ANIY
	movsx	ecx,cx
	movsx	edx,dx
	mov	tl1,ecx
	mov	tl2,edx


	CLR	ecx
	mov	esi,[ebx].IMG.PTTBL_p
	lea	esi,[esi].PTTBL.CBOX
cboxlp:
	cmp	DPTR [esi],0
	je	cboxnxt			;Not in use?
;	je	cboxnxt			;Not in use?

	mov	prtcolors,0ffh

;	cmp	ecx,cboxselect
;	jne	@F
;	mov	prtcolors,0ffh		;Yellow
;@@:
	PUSHM	ecx,edi

	movsx	eax,[esi].PTCBOX.X
	movsx	ebx,[esi].PTCBOX.Y
	add	eax,tl1
	add	ebx,tl2
	movzx	ecx,[esi].PTCBOX.W
	movzx	edx,[esi].PTCBOX.H
	add	ecx,eax
	add	edx,ebx
	call	boxh_drawclip

	POPM	ecx,edi
;cboxnxt:
;	add	esi,sizeof PTCBOX
;	inc	ecx
;	cmp	ecx,PTCBOXNUM
;	jb	cboxlp


	pop	ebx
	push	ebx

	lea	edi,tmp_s
	push	edi

	mov	eax,'    '
	mov	8[edi],eax
	mov	12[edi],eax
	mov	16[edi],eax

	movsx	eax,[esi].PTCBOX.X
	sub	ax,[ebx].IMG.ANIX
	movsx	eax,ax
	call	stritoa
	mov	BPTR [edi],' '
	inc	edi

	movsx	eax,[esi].PTCBOX.Y
	sub	ax,[ebx].IMG.ANIY
	movsx	eax,ax
	call	stritoa
	mov	BPTR [edi],' '
	inc	edi

	movzx	eax,[esi].PTCBOX.W
	inc	eax
	call	stritoa
	mov	BPTR [edi],' '
	inc	edi

	movzx	eax,[esi].PTCBOX.H
	inc	eax
	call	stritoa
	mov	BPTR [edi],' '

	pop	esi
	mov	BPTR 20[esi],0
	mov	bx,0fdh
	mov	cx,41*8
	mov	dx,35
	call	prtf6

cboxnxt:

	pop	ebx

nocbox:
noboxes:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


noimg:


	mov	prtcolors,0fch
	mov	eax,bndboxx1
	mov	ebx,bndboxy1
	mov	ecx,bndboxx2
	mov	edx,bndboxy2
	call	boxh_drawclip



	lea	edi,tmp_s
	push	edi

	mov	eax,'    '
	mov	8[edi],eax
	mov	12[edi],eax
	mov	16[edi],eax

	mov	eax,bndboxx1
	sub	ax,iwincx
	call	stritoa
	mov	BPTR [edi],' '
	inc	edi

	mov	eax,bndboxy1
	sub	ax,iwincy
	call	stritoa
	mov	BPTR [edi],' '
	inc	edi

	mov	eax,bndboxx2
	sub	eax,bndboxx1
	call	stritoa
	mov	BPTR [edi],' '
	inc	edi

	mov	eax,bndboxy2
	sub	eax,bndboxy1
	call	stritoa
	mov	BPTR [edi],' '

	pop	esi
	mov	BPTR 20[esi],0
	mov	bx,0fdh
	mov	cx,41*8
	mov	dx,25
	call	prtf6



	popad
	ret

 SUBEND



;********************************
;* Draw image in image window at scale
;* EAX = Img #
;* Trashes none

 SUBRP	img_drawscaled


	call	img_find
	jz	x
	mov	ebx,eax


	movsx	eax,[ebx].IMG.ANIX	;>Sub scaled ani pt
	shl	eax,8			;*256
	movzx	ecx,iwinsclx
	cdq
	idiv	ecx
	mov	cx,iwincx
	sub	cx,ax
	movsx	ecx,cx
	mov	prtx,ecx
	push	ecx

	movsx	eax,[ebx].IMG.ANIY
	shl	eax,8			;*256
	movzx	ecx,iwinscly
	cdq
	idiv	ecx
	mov	cx,iwincy
	sub	cx,ax
	movsx	ecx,cx
	mov	prty,ecx

	mov	ax,SCRWB
	mul	cx
	mov	tw4,ax			;Y offset

	mov	ax,400
	sub	ax,cx			;Lines left

	mov	cx,[ebx].IMG.H
	shl	cx,8
	imul	ax,iwinscly
	jc	overflow		;Lots left?
	cmp	cx,ax
	jbe	overflow		;OK?
	mov	cx,ax			;Clip bottom
overflow:
	mov	tw3,cx

	mov	eax,[ebx].IMG.DATA_p
	mov	tl1,eax

	CLR	esi			;ESI=*Img data

	movzx	ecx,[ebx].IMG.W
	add	ecx,3
	and	cl,0fch
	mov	imgdataw,ecx

lpx:	push	ecx

	mov	ecx,prtx
	inc	prtx
	jle	skipx			;Left clipped?

	mov	edi,ecx			;X
	shr	edi,2			;/4
	add	di,tw4			;+Y
	and	cl,3
	mov	ax,100h+SC_MAPMASK
	shl	ah,cl			;Set bit for bit plane
	mov	dx,SC_INDEX
	out	dx,ax

	push	ebx
	mov	cx,tw3			;H
	mov	edx,imgdataw
	CLR	ebx

	push	esi
	shr	esi,8			;Remove frac
	add	esi,tl1			;+Base

	cmp	BPTR iwinscly+1,0
	je	lylp			;Scale up?

sylp:
	mov	al,[esi]		;>Scale down
	TST	al
	jz	szero
	mov	0a0000h[edi],al
szero:	add	di,SCRWB		;Next Y

	mov	al,bh
	add	bx,iwinscly		; >100h
	jc	nextx			;Overflow?
	sub	al,bh
saddlp:	add	esi,edx			;Skip pixel
	inc	al
	jl	saddlp

	cmp	bx,cx
	jb	sylp
	jmp	nextx

lylp:
	mov	al,[esi]		;>Scale up
	add	esi,edx

lylp2:	TST	al
	jz	lzero
	mov	0a0000h[edi],al
lzero:	add	di,SCRWB

	add	bl,BPTR iwinscly	;<100h
	jnc	lylp2

	inc	bh
	cmp	bx,cx
	jb	lylp


nextx:	pop	esi

	pop	ebx
skipx:
	pop	ecx

	add	si,iwinsclx
	jc	scldone			;Overflow?

	mov	ax,si
	cmp	ah,cl
	jb	lpx

scldone:

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	pop	ecx

	cmp	iwinanipton,0
	je	noap

	push	ecx

	push	ebx
	mov	bl,255			;>Draw anipt1
	mov	cx,iwincx
	mov	dx,iwincy
	call	crossh_draw
	pop	ebx


	movsx	eax,[ebx].IMG.ANIX2	;>Draw anipt2
	shl	eax,8			;*256
	cdq
	movzx	ecx,iwinsclx
	idiv	ecx
	pop	ecx			;Img left X pos
	mov	prtx,ecx
	add	ecx,eax

	push	ecx

	movsx	eax,[ebx].IMG.ANIY2
	shl	eax,8			;*256
	cdq
	movzx	ecx,iwinscly
	idiv	ecx
	mov	edx,prty		;Img top Y pos
	add	edx,eax

	pop	ecx

	mov	anipt2x,cx		;Save
	mov	anipt2y,dx

	push	ebx
	mov	bl,254
	call	crossh_draw
	pop	ebx


	mov	esi,[ebx].IMG.PTTBL_p	;>Draw anipt3
	TST	esi
	jz	@F			;None?

	movsx	eax,[esi].PTTBL.X
	shl	eax,8			;*256
	cdq
	movzx	ecx,iwinsclx
	idiv	ecx
	mov	ecx,prtx		;Img left X pos
	add	ecx,eax
	push	ecx

	movsx	eax,[esi].PTTBL.Y
	shl	eax,8			;*256
	cdq
	movzx	ecx,iwinscly
	idiv	ecx
	mov	edx,prty		;Img top Y pos
	add	edx,eax

	pop	ecx

	mov	bl,0fch
	call	crossh_draw
@@:
noap:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	mov	cx,iwinrx		;Draw reference mark
	TST	cx
	jl	@F
	mov	dx,iwinry
	mov	bl,0fdh
	call	crossh_drawsml
@@:


x:
	popad
	ret

 SUBEND


;********************************
;* Load palette for current img
;* Trashes all non seg

 SUBRP	img_loadpal

	call	img_findsel
	jz	x
	mov	esi,eax				;ESI=*IMG struc

	movsx	eax,[esi].IMG.PALNUM
	cmp	eax,ilpalloaded
	je	x				;Already loaded?

	mov	ilpalloaded,eax

	call	plst_select

x:
	ret

 SUBEND





;********************************
;* Alloc PAL struc and add to list
;* >EAX = *PAL struc or 0 (CC)
;* Trashes out

 SUBRP	pal_alloc

	PUSHMR	edx,esi

	mov	eax,sizeof PAL
	call	mem_alloc
	jz	x

	lea	esi,pal_p		;Find end
lp:	mov	edx,esi
	mov	esi,[esi]
	TST	esi
	jnz	lp

	mov	[edx],eax		;Link
	mov	[eax],esi		;0

	mov	[eax].PAL.DATA_p,esi	;0

	inc	palcnt
x:
	TST	eax
	POPMR
	ret

 SUBEND

;********************************
;* Find PAL struc of plselected
;*>EAX = *PAL struc or 0 (CC)
;* Trashes out

 SUBRP	pal_findsel

	mov	eax,plselected

	;Fall through!
 SUBEND

;********************************
;* Find PAL struc from #
;* EAX = Pal # (0-?)
;*>EAX = *PAL struc or 0 (CC)
;* Trashes out

 SUBRP	pal_find

	PUSHMR	edx,esi

	CLR	edx
	dec	edx
	lea	esi,pal_p

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
;* Delete pal and it's data
;* EAX = Pal # (0-?)
;* Trashes none

 SUBRP	pal_del

	pushad

	TST	eax
	jl	x

	lea	esi,pal_p		;Find previous
	dec	eax
	jl	@F			;1st one?

	call	pal_find
	jz	x			;Bad selection?
	mov	esi,eax
@@:
	mov	edi,[esi]
	TST	edi
	jz	x
	mov	eax,[edi]		;Get deleted's next
	mov	[esi],eax		;Give to prev

	dec	palcnt

	TST	eax
	jnz	nlast			;!Last?

	mov	pl1stprt,0
	mov	eax,plselected
	dec	eax
	call	plst_select

nlast:
	mov	eax,[edi].PAL.DATA_p
	call	mem_free
	mov	eax,edi
	call	mem_free

x:
	popad
	ret

 SUBEND


;********************************
;* Pal list page up

 SUBRP	plst_kpup

	mov	ebx,-PLSTROW
	jmp	pkup
 SUBEND

;********************************
;* Pal list line up

 SUBRP	plst_kup

	mov	ebx,-1
pkup::
	mov	ax,ds:[41ah]
	cmp	ax,ds:[41ch]
	jne	x			;Other key in buffer?

	mov	eax,plselected
	add	eax,ebx
	jge	selok
	CLR	eax
selok:	jmp	plst_select

x:	ret

 SUBEND


;********************************
;* Pal list page down

 SUBRP	plst_kpdn

	mov	ebx,PLSTROW
	jmp	pkdn

 SUBEND

;********************************
;* Pal list line down

 SUBRP	plst_kdn

	mov	ebx,1
pkdn::
	mov	ax,ds:[41ah]
	cmp	ax,ds:[41ch]
	jne	x			;Other key in buffer?

	mov	eax,plselected
	add	eax,ebx
	mov	ebx,palcnt
	cmp	eax,ebx
	jb	selok			;Within max?
	mov	eax,ebx
	dec	eax
selok:
	jmp	plst_select

x:	ret

 SUBEND


;********************************
;* Image list gadgets
;* AX=Gadget ID
;* CX=X top left offset from gad
;* DX=Y ^

 SUBRP	plst_gads

	pushad


	TST	al
	jnz	n0

	sub	dx,3
	jl	x			;Above names?

	movsx	eax,dx
	CLR	edx
	mov	ebx,9
	div	ebx
	add	eax,pl1stprt

	test	mousebut,1
	jnz	sel			;Toggle?

	test	mousebchg,2
	jnz	@F			;Toggle?

	cmp	eax,plselected
	je	x			;Already selected?
@@:
	mov	ebx,eax
	call	pal_find
	jz	x
	xor	[eax].PAL.FLAGS,MARKED
	mov	eax,ebx
	jmp	@F
sel:
	cmp	eax,plselected
	je	x			;Already selected?
@@:
	call	plst_select
	jmp	x

n0:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Move all marked imgs anipt 1

	cmp	al,40h
	jne	n40

	call	plst_prt
	jmp	x

n40:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ



x:	popad
	ret



 SUBEND



;********************************
;* Select item from pal list
;* EAX = Item # (0-?)
;* Trashes none

 SUBRP	plst_select

	pushad


	CLR	edx
	dec	edx
	mov	plselected,edx			;-1

	mov	ebx,eax
	call	pal_find
	jz	nof
	mov	esi,eax				;ESI=*Pal

	mov	plselected,ebx



	mov	ecx,255				;>Clr pal_t
	CLR	eax
	mov	edi,offset pal_t+2
@@:	mov	[edi],ax
	add	edi,2
	loop	@B


	mov	eax,[esi].PAL.DATA_p
	add	eax,2

	mov	ebx,offset pal_t+2

	movzx	ecx,[esi].PAL.NUMC
	dec	ecx
	mov	palblastuc,cl
	add	ecx,ecx				;*2

	call	mem_copy


	mov	ebx,offset palmap_t		;>Init map
	CLR	al
@@:	mov	[ebx],al
	inc	ebx
	inc	al
	jnz	@B


	call	palblk_prtinfo
	call	palblk_setvgapal


nof:
	call	plst_prt


x:
	popad
	ret

 SUBEND



;********************************
;* Load palblk with selected palette
;* Trashes EAX

 SUBRP	plst_loadpblk

	mov	eax,plselected
	jmp	plst_select

 SUBEND


;********************************
;* Save palblk over selected palette
;* Trashes all non seg

 SUBRP	plst_savepblk

	call	pal_findsel
	jz	x
	mov	esi,eax

	mov	eax,offset pal_t
	mov	ebx,[esi].PAL.DATA_p
	movzx	ecx,[esi].PAL.NUMC
	add	ecx,ecx				;*2
	call	mem_copy

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	CLR	cl				;>Convert format of palmap
	mov	esi,offset palmap_t
	CLR	eax
@@:
	mov	al,[esi]			;Get pix # in this location
	inc	esi
	mov	BPTR pal_t+2[eax],cl		;Use pal_t as buffer

	inc	cl
	jnz	@B


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				;>Remap pixels


	lea	esi,img_p
	jmp	mpnxt
mplp:
	movsx	eax,[esi].IMG.PALNUM
	cmp	eax,plselected
	jne	mpnxt


	movzx	eax,[esi].IMG.W
	add	ax,3
	and	al,0fch
	movzx	ecx,[esi].IMG.H
	imul	ecx,eax

	mov	edi,[esi].IMG.DATA_p
	CLR	eax
plp:	mov	al,[edi]
	TST	al
	jz	@F				;0 pix?
	mov	al,BPTR pal_t+2[eax]		;Get new position
	mov	[edi],al
@@:	inc	edi
	loop	plp

mpnxt:
	mov	esi,[esi]
	TST	esi
	jnz	mplp


	mov	ilpalloaded,-1
	mov	eax,ilselected			;Redraw image
	call	ilst_select


x:
	ret

 SUBEND




;********************************
;* Prt list of palette names
;* Trashes none

 SUBRP	plst_prt

	pushad

					;>Make sure selected is visable
	mov	ebx,plselected
	mov	eax,pl1stprt
	cmp	ebx,eax
	jb	@F			;Off top?
	sub	ebx,PLSTROW-1
	cmp	ebx,eax
	jbe	vis			;!Off bottom?
	TST	ebx
	jge	@F
	CLR	ebx
@@:	mov	pl1stprt,ebx
vis:

	mov	ax,PLSTW
	mov	bx,PLSTH
	mov	cx,PLSTX
	mov	dx,PLSTY
	call	box_drawshaded


	mov	ecx,palcnt
	TST	ecx
	jle	x			;None?
	cmp	ecx,PLSTROW
	jbe	pnumok
	mov	ecx,PLSTROW
pnumok:

	mov	eax,pl1stprt
	mov	edi,eax
	call	pal_find
	jz	x
	mov	esi,eax

	mov	dx,PLSTY+3
lp:
	push	ecx
	push	edi
	call	plst_prt1l_ll
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
;* Prt 1 line of list of palette names
;* ESI=*Image struc
;* Trashes none

 SUBRP	plst_prt1l

	pushad

	mov	ebx,plselected
	mov	edi,ebx
	sub	ebx,pl1stprt
	cmp	ebx,PLSTROW
	jae	x			;Not visable?

	mov	ax,9
	mul	bx
	add	ax,PLSTY+3
	mov	dx,ax
	mov	ax,35
	mov	bh,0fdh
	mov	cx,PLSTX+4
	call	prt_spc
	call	plst_prt1l_ll

x:	popad
	ret

 SUBEND


;********************************
;* Prt 1 line of list of palette names (Low level)
;* ESI = *PAL struc
;* EDI = Pal # (0-?)
;* DX  = Y pos

 SUBRP	plst_prt1l_ll

	push	esi

	movsx	edi,di

	mov	bx,0fdfch
	cmp	edi,plselected
	jne	notsel

	mov	bx,0feffh
notsel:	mov	cx,PLSTX+12
	lea	esi,[esi].PAL.N_s
	call	prt			;Pal name

	pop	esi
	push	esi
	test	[esi].PAL.FLAGS,MARKED
	jz	nomrk
	mov	bx,0feffh
	mov	esi,offset cast_s
	mov	cx,PLSTX+4
	call	prt
nomrk:
	pop	esi
	push	esi
	mov	ax,[esi].PAL.NUMC
	mov	bx,0fdfch
	mov	cx,PLSTX+8+10*8
	call	prt_dec3srj

	pop	esi
	ret

 SUBEND


;********************************
;* Rename selected palette

 SUBRP	plst_rename

	call	pal_findsel
	jz	x			;Bad selection?

	lea	edi,[eax].PAL.N_s
	mov	eax,PNAMELEN
	call	strbox_open
;	jnz	x

	call	main_draw
x:
	ret

 SUBEND


;********************************
;* Duplicate selected palette

 SUBRP	plst_duplicate

	call	pal_findsel
	jz	x				;Bad selection?

	mov	esi,eax
	movzx	ecx,[esi].PAL.NUMC

	mov	eax,ecx
	shl	eax,1				;*2
	call	mem_alloc
	jz	x

	mov	edx,eax

	mov	ebx,[esi].PAL.DATA_p
	mov	edi,eax
clp:
	mov	ax,[ebx]
	mov	[edi],ax
	add	ebx,2
	add	edi,2

	loop	clp


	call	pal_alloc
	jz	x
	mov	edi,eax				;EDI=*Pal hdr

	mov	[edi].PAL.DATA_p,edx
	mov	[edi].PAL.FLAGS,0
	mov	al,[esi].PAL.BITSPIX
	mov	[edi].PAL.BITSPIX,al

	mov	ax,[esi].PAL.NUMC
	mov	[edi].PAL.NUMC,ax

	lea	eax,[esi].PAL.N_s
	lea	edi,[edi].PAL.N_s
	push	edi
	call	strcpy
	pop	edi

	mov	eax,PNAMELEN			;Let user rename
	call	strbox_open
;	jnz	x

	mov	eax,palcnt
	dec	eax
	call	plst_select

	call	main_draw
x:
	ret

 SUBEND



;********************************
;* Merge marked palettes (and their images) into selected pal

 SUBRP	plst_merge

	local	pnum:dword


	call	pal_findsel
	jz	x
	mov	edi,eax			;EDI=*Selected PAL struc

	and	[eax].PAL.FLAGS,not MARKED


	CLR	eax
	dec	eax
	mov	pnum,eax
mlp:
	inc	pnum
	mov	eax,pnum
;	cmp	eax,plselected
;	je	mlp			;Same as selected?
	call	pal_find
	jz	mend			;End?

	test	[eax].PAL.FLAGS,MARKED
	jz	mlp			;No mark?

	mov	esi,eax

	mov	eax,[esi].PAL.DATA_p
	movzx	ebx,[esi].PAL.NUMC
	mov	ecx,[edi].PAL.DATA_p
	movzx	edx,[edi].PAL.NUMC
	call	pal_makemergemap

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	PUSHM	esi,edi

	lea	esi,img_p
	jmp	mpnxt
mplp:
	movzx	eax,[esi].IMG.PALNUM
	cmp	eax,pnum
	jne	mpnxt

	mov	eax,plselected
	mov	[esi].IMG.PALNUM,ax

	movzx	eax,[esi].IMG.W
	add	ax,3
	and	al,0fch
	movzx	ecx,[esi].IMG.H
	imul	ecx,eax

	mov	edi,[esi].IMG.DATA_p
	CLR	eax
plp:	mov	al,[edi]
	TST	al
	jz	@F				;0 pix?
	mov	al,BPTR palmrgmap_t[eax]	;Get new position
	mov	[edi],al
@@:	inc	edi
	loop	plp

mpnxt:
	mov	esi,[esi]
	TST	esi
	jnz	mplp

	POPM	esi,edi

	jmp	mlp

mend:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ			>Delete merged pals

	CLR	eax
	dec	eax
	mov	pnum,eax
dellp:
	inc	pnum
delsmlp:
	mov	eax,pnum
	call	pal_find
	jz	dend			;End?

	test	[eax].PAL.FLAGS,MARKED
	jz	dellp			;No mark?

	mov	eax,pnum
	call	pal_del


	lea	esi,img_p
	jmp	@F
ifixlp:
	movzx	eax,[esi].IMG.PALNUM
	cmp	eax,pnum
	jle	@F

	dec	[esi].IMG.PALNUM
@@:
	mov	esi,[esi]
	TST	esi
	jnz	ifixlp


	jmp	delsmlp
dend:
;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	call	main_draw
x:
	ret

 SUBEND


;********************************
;* Build remap
;* EAX = *Src pal
;* EBX = Source pal length
;* ECX = *Dest pal
;* EDX = Destination pal length
;* Trashes none

	BSSX	palmrgmap_t	,256		;Merge map

 SUBRP	pal_makemergemap

	local	slen:dword,
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

	mov	ebx,eax
	lea	esi,palmrgmap_t
slp:
						;>Get src RGB components
	movzx	eax,WPTR [ebx]
	shr	eax,10
	and	al,1fh
	imul	eax,eax
	mov	sred,eax

	movzx	eax,WPTR [ebx]
	shr	eax,5
	and	eax,1fh
	imul	eax,eax
	mov	sgrn,eax

	movzx	eax,BPTR [ebx]
	and	al,1fh
	imul	eax,eax
	mov	sblu,eax

						;>Comp src RGB to each dest RGB
	mov	mdelta,1000
	mov	ecx,dlen
	mov	edi,dst_p
dlp:
	CLR	edx

	movzx	eax,WPTR [edi]
	shr	eax,10
	and	al,1fh
	imul	eax,eax
	sub	eax,sred
	jge	@F
	neg	eax
@@:	add	edx,eax

	movzx	eax,WPTR [edi]
	shr	eax,5
	and	eax,1fh
	imul	eax,eax
	sub	eax,sgrn
	jge	@F
	neg	eax
@@:	add	edx,eax

	movzx	eax,BPTR [edi]
	and	al,1fh
	imul	eax,eax
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
;* Show histogram of selected pal
;* Trashes all non seg

PHSTX	equ	48
PHSTY	equ	15
PHSTW	equ	640-PHSTX*2
PHSTH	equ	256+54

 SUBRP	plst_histogram

	local	hbuf_t[256]:dword,
		hmax:dword,
		icnt:dword

	mov	ax,PHSTW
	mov	bx,PHSTH
	mov	cx,PHSTX
	mov	dx,PHSTY
	call	box_drawshaded


	call	pal_findsel
	jz	err
	mov	esi,eax				;ESI=*PAL struc


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Clr hist buf

	CLR	eax
	lea	ebx,hbuf_t
	mov	ecx,256
clp:
	mov	[ebx],eax
	add	ebx,4
	loop	clp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Count color usage

	CLR	eax
	mov	icnt,eax

	lea	edi,img_p
	jmp	cntnxt
cntlp:
	movsx	eax,[edi].IMG.PALNUM
	cmp	eax,plselected
	jne	cntnxt

	inc	icnt

	movzx	eax,[edi].IMG.W
	add	ax,3
	and	al,0fch
	movzx	ecx,[edi].IMG.H
	imul	ecx,eax

	mov	ebx,[edi].IMG.DATA_p
	CLR	eax
pxlp:	mov	al,[ebx]
	inc	hbuf_t[eax*4]			;Count +1
	inc	ebx
	loop	pxlp

cntnxt:
	mov	edi,[edi]
	TST	edi
	jnz	cntlp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Find max count

	CLR	edx
	lea	ebx,hbuf_t+4			;Skip 1st
	mov	ecx,256-1
maxlp:
	mov	eax,[ebx]
	cmp	eax,edx
	jbe	@F
	mov	edx,eax				;New max
@@:
	add	ebx,4
	loop	maxlp

	cmp	edx,1
	jge	@F
	mov	edx,1
@@:
	mov	hmax,edx

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Print imgcnt and max

	push	esi

	mov	eax,icnt
	mov	bx,0ffh
	mov	cx,PHSTX+32
	mov	dx,PHSTY+5
	call	prt_dec

	mov	eax,hmax
	lea	edi,tmp_s
	mov	DPTR [edi],':xaM'
	add	edi,4
	call	striltoa

	mov	bx,0ffh
	mov	cx,PHSTX+32
	mov	dx,PHSTY+15
	lea	esi,tmp_s
	call	prt

	pop	esi

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Draw graph

	mov	eax,PHSTX+24
	mov	linex2,eax
	mov	eax,PHSTY+295
	mov	liney2,eax

	CLR	eax
	mov	prtcolors,ax

	movzx	ecx,[esi].PAL.NUMC
	lea	esi,hbuf_t
dlp:
	mov	eax,[esi]
	shl	eax,8				;*256
	cdq
	idiv	hmax				;Scale to fit
	cmp	eax,270
	jbe	@F
	mov	eax,270
@@:
	push	ecx

	mov	ecx,linex2
	mov	edx,liney2
	sub	edx,eax
	cmp	DPTR [esi],0
	jne	@F				;Used?
	add	edx,7				;Show as not used
@@:
	call	line_draw
	inc	linex2
	inc	ecx
	call	line_draw

	pop	ecx

	inc	prtcolors
	inc	linex2
	add	esi,4

	loop	dlp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


	call	waiton_keyormouse
err:
	call	main_draw

	ret

 SUBEND


;********************************
;* Delete unused colors of selected pal
;* Trashes all non seg

 SUBRP	plst_delunusedcols

	local	hbuf_t[256]:dword,
		hmax:dword,
		icnt:dword


	call	pal_findsel
	jz	err
	mov	esi,eax				;ESI=*PAL struc


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Clr hist buf

	CLR	eax
	lea	ebx,hbuf_t
	mov	ecx,256
clp:
	mov	[ebx],eax
	add	ebx,4
	loop	clp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Count color usage

	CLR	eax
	mov	icnt,eax

	lea	edi,img_p
	jmp	cntnxt
cntlp:
	movsx	eax,[edi].IMG.PALNUM
	cmp	eax,plselected
	jne	cntnxt

	inc	icnt

	movzx	eax,[edi].IMG.W
	add	ax,3
	and	al,0fch
	movzx	ecx,[edi].IMG.H
	imul	ecx,eax

	mov	ebx,[edi].IMG.DATA_p
	CLR	eax
pxlp:	mov	al,[ebx]
	inc	hbuf_t[eax*4]			;Count +1
	inc	ebx
	loop	pxlp

cntnxt:
	mov	edi,[edi]
	TST	edi
	jnz	cntlp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Set new color count

	lea	ebx,hbuf_t+4
	mov	ecx,255
	CLR	edx
	inc	edx
cnlp:
	mov	eax,[ebx]
	TST	eax
	jz	@F
	inc	edx
@@:
	add	ebx,4
	loop	cnlp


;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ				>Pack used colors


	movzx	ecx,[esi].PAL.NUMC
	mov	[esi].PAL.NUMC,dx

	sub	ecx,2
	jle	err

	push	esi
	lea	esi,hbuf_t+4
	lea	edi,pal_t+2
	lea	ebx,palmap_t+1
dlp:
	mov	eax,[esi]
	TST	eax
	jnz	dnxt				;Used?

	PUSHM	ebx,ecx,esi,edi			;>Move following down
d2lp:
	mov	eax,4[esi]
	mov	[esi],eax
	mov	ax,2[edi]
	mov	[edi],ax
	mov	al,1[ebx]
	mov	[ebx],al
	add	esi,4
	add	edi,2
	inc	ebx
	dec	ecx
	jg	d2lp

	mov	BPTR [ebx],0

	POPM	ebx,ecx,esi,edi

	jmp	@F
dnxt:
	add	esi,4
	add	edi,2
	inc	ebx
@@:
	loop	dlp

	pop	esi

;ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

	call	plst_savepblk


err:

	ret

 SUBEND



;********************************
;* Unmark all pals

 SUBRP	plmrk_clrall


	lea	esi,pal_p
	jmp	nxt
lp:
	and	[esi].PAL.FLAGS,not MARKED	;Clr

nxt:	mov	esi,[esi]
	TST	esi
	jnz	lp

	jmp	plst_prt

 SUBEND

;********************************
;* Mark all pals

 SUBRP	plmrk_setall


	lea	esi,pal_p
	jmp	nxt
lp:
	or	[esi].PAL.FLAGS,MARKED		;Set

nxt:	mov	esi,[esi]
	TST	esi
	jnz	lp

	jmp	plst_prt

 SUBEND


;********************************
;* Invert marks on all pals

 SUBRP	plmrk_invertall


	lea	esi,pal_p
	jmp	nxt
lp:
	xor	[esi].PAL.FLAGS,MARKED

nxt:	mov	esi,[esi]
	TST	esi
	jnz	lp

	jmp	plst_prt

 SUBEND


;********************************
;* Tell user of memory error
;* Trashes none

 SUBRP	msg_memerr

	pushad

	mov	al,1
	mov	esi,offset memerr_s
	call	msgbox_open

	popad
	ret
 SUBEND

	.data
memerr_s	db	"Memory error!",0



;********************************


	end
