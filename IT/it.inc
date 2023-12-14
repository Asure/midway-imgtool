;**************************************************************
;* IT include file
;*.Last mod - 6/21/94 14:12
;**************************************************************

CFGVER	equ	1

CFG	struct
	VER	dw	?		;CFG file version #
	IPN_s	db	66 dup (?)	;Last IMG path\file loaded
	IFN_s	db	14 dup (?)	;Last IMG path\file loaded
	COL0	dw	?		;Color 0 RGB15
	IWCX	dw	?		;IWin center X
	IWCY	dw	?		;^ Y
	FREE	dw	100 dup (?)	;
CFG	ends

FENTRY	struct
	ATRB	db	?		;Bit 7 is my marked bit
	N_s	db	13 dup (?)
FENTRY	ends

BMHD	struct
	W	word	?	;Img width
	H	word	?	;Img height
	XO	word	?	;Img start X offset
	YO	word	?	;Y ^
	NPLANES	byte	?	;# bitplanes
	MASKP	byte	?	;Mask plane (0=None, 1=Extra mask plane)
	COMP	byte	?	;Compression (0=None, 1=Run length)
	PAD	byte	?	;Padding
	TCOL	word	?	;Transparent color
	XAR	byte	?	;X aspect ratio
	YAR	byte	?	;Y ^
	PAGEW	word	?	;Page width
	PAGEH	word	?	;^ height
BMHD	ends

TGAHDR	struct
	IDLEN	byte	?	;Length of text ID or 0
	CMTYPE	byte	?	;Color map type (0=None,1=Palette)
	ITYPE	byte	?	;Image type (0=None,1=Uncomp color-map,2=Uncomp true color)
	FCENT	word	?	;First color entry (0)
	CMLEN	word	?	;Color map len (0 if none)
	CMBITS	byte	?	;# bits per color map entry
	XO	word	?	;Img start X offset
	YO	word	?	;Y ^
	W	word	?	;Img width
	H	word	?	;Img height
	BITSPIX	byte	?	;Bits per pixel
	DESC	byte	?	;Orientation (0=Start at BL, 32=Start at TL)
TGAHDR	ends

MENU	struct
	NEXT_p	dd	0	;* next menu or 0
	W	word	0	;Heading width
	TITLE_p	dd	0	;* title text or 0
	MENUI_p	dd	0	;* menu strip items
	MSW	word	0	;Menu strip width
MENU	ends

MENUI	struct
	TXT_p	dd	0	;* text or 0
	CODE_p	dd	0	;* code to call
MENUI	ends

GAD	struct
	NEXT_p	dd	0	;* next gad or 0
	X	word	0	;X pos
	Y	word	0	;Y pos
	W	word	0	;Box width
	H	word	0	;^ height
	IMG_p	dd	0	;* Image data (W,H) or 0
	TXT_p	dd	0	;* text or 0
	FLAGS	word	0
	ID	word	0
GAD	ends

GADF_DN		equ	1
GADF_DNR	equ	2
GADF_MV		equ	4
GADF_MVR	equ	8
GADF_UP		equ	16
GADF_UPR	equ	32
GADF_STR	equ	64


BOX	struct
	X	word	?
	Y	word	?
	W	word	?
	H	word	?
	COL	byte	?
BOX	ends


SC_INDEX	equ	3c4h	;Sequence controller
SC_CLKMODE	equ	1	;Clocking mode
SC_MAPMASK	equ	2	;Map mask
SC_MEMMODE	equ	4	;Memory mode
DAC_WADDR	equ	3c8h	;DAC write address
DAC_DATA	equ	3c9h	;DAC color data
GC_INDEX	equ	3ceh	;Graphics controller
GC_MAPSEL	equ	4	;Read map select
GC_GFXMODE	equ	5	;Mode
GC_MISC		equ	6	;Misc
CC_INDEX	equ	3d4h	;CRT controller
CC_HTOT		equ	0	;Horizontal total (chars)
CC_HDIS		equ	1	;Horizontal display (chars)
CC_MAXSCAN	equ	9	;# scan lines per row
CC_STRTADRH	equ	0ch	;Start address high
CC_VRE		equ	11h	;Vertical rescan end
CC_ULINE	equ	14h	;Underline
CC_MODECTRL	equ	17h	;Mode control


BSSB	macro	N
	.data?
N	db	?
	endm

BSSBX	macro	N
	.data?
	externdef	N:byte
N	db	?
	endm

BSSW	macro	N
	.data?
	align	2
N	dw	?
	endm

BSSWX	macro	N
	.data?
	align	2
	externdef	N:word
N	dw	?
	endm

BSSD	macro	N
	.data?
	align	4
N	dd	?
	endm

BSSDX	macro	N
	.data?
	align	4
	externdef	N:dword
N	dd	?
	endm

BSS	macro	N,X
	.data?
N	db	X dup (?)
	endm

BSSX	macro	N,X
	.data?
	externdef	N:byte
N	db	X dup (?)
	endm

BSS2	macro	N,X
	.data?
	align	2
N	dw	X dup (?)
	endm

BSS2X	macro	N,X
	.data?
	align	2
	externdef	N:word
N	dw	X dup (?)
	endm

BSS4	macro	N,X
	.data?
	align	4
N	dd	X dup (?)
	endm

BSS4X	macro	N,X
	.data?
	align	4
	externdef	N:dword
N	dd	X dup (?)
	endm

CLR	macro	R
	xor	R,R
	endm

TST	macro	R
	test	R,R
	endm

PUSHM	macro	REGS:vararg
	for	R,<REGS>
	push	R
	endm
	endm

POPM	macro	REGS:vararg
TMP	textequ	<>
	for	R,<REGS>
TMP	catstr	<,R>,TMP
	endm
TMP	substr	TMP,2
	%for	R,<TMP>
	pop	R
	endm
	endm

PUSHMR	macro	REGS:vararg
PUSHMRS	textequ	<&REGS>
	for	R,<REGS>
	push	R
	endm
	endm

POPMR	macro
	POPM	%PUSHMRS
	endm

SUBRP	macro	N
	.code
N	proc	near
SUBN	textequ	<&N>
	endm

SUBR	macro	N
	.code
	externdef	&N:near
N	proc	near
SUBN	textequ	<&N>
	endm

SUBEND	macro
SUBN	endp
	endm

BPTR	equ	<byte ptr>
WPTR	equ	<word ptr>
DPTR	equ	<dword ptr>

SCRWB	equ	640/4		;Screen width # of bytes
SLAVE	equ	0


INT21	macro	F
	mov	ah,F
	int	21h
	endm

INT21X	macro	F
	mov	ax,F
	int	21h
	endm

I21GETDRV	equ	<INT21	19h>
I21SETDRV	equ	<INT21	0eh>
I21SETCD	equ	<INT21	3bh>
I21RENAME	equ	<INT21	56h>
I21DELETE	equ	<INT21	41h>
I21OPENR	equ	<INT21X	3d00h>
I21CREATE	equ	<INT21	3ch>
I21READ		equ	<INT21	3fh>
I21WRITE	equ	<INT21	40h>
I21SETFPS	equ	<INT21X	4200h>
I21SETFPC	equ	<INT21X	4201h>
I21SETFPE	equ	<INT21X	4202h>
I21CLOSE	equ	<INT21	3eh>
