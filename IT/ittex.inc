;**************************************************************
;* Asm include file
;*.Last mod - 6/22/93 13:39
;**************************************************************


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
N	byte	?
	endm

BSSW	macro	N
	.data?
N	word	?
	endm

CLR	macro	R
	xor	R,R
	endm

INT21	macro	F
	mov	ah,F
	int	21h
	endm

INT21X	macro	F
	mov	ax,F
	int	21h
	endm

SUBRP	macro	N
	.code
N&_	proc	near
SUBN	textequ	<N&_>
	endm

SUBR	macro	N
	.code
	externdef	N&_:near
N&_	proc	near
SUBN	textequ	<N&_>
	endm

SUBEND	macro
SUBN	endp
	endm

STRCT	macro	O
SOFF=O
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

BPTR	equ	<byte ptr>
WPTR	equ	<word ptr>
DPTR	equ	<dword ptr>

SCRWB	equ	640/4		;Screen width # of bytes


