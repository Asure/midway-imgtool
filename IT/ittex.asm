;**************************************************************
;*
;* Software:		Shawn Liptak
;* Initiated:		6/21/93
;*
;* Modified:		6/21/93 SL - From it.asm for TVGV
;* 			1/6/94  SL - From TVGV for IT 3d
;*
;* Copyright (c) 1993,1994 Williams Electronics Games, inc.
;*
;*.Last mod - 6/21/94 16:31
;**************************************************************
	option	casemap:none
	.386P
	.model	flat,syscall,os_os2

	include	wmpstruc.inc
	include	it.inc
	include	it3d.inc



	.data

	externdef	scrnbuf:byte

	externdef	_ADDRL:dword
	externdef	_AIVI:dword
	externdef	_ARPS:dword


		align	4
___xmin		dd	0
___xmax		dd	320

_ADDRL		dd	0	;* texture

_AIVI		dd	4 dup (0)	;Texture offsets * 4 (FIX dwords)
_ARPS		dd	3*4 dup (0)	;Screen XYZ * 4

TIV	struct			;Texture internal vertices
	V1	dd	?	;YX (8:8)
	V2	dd	?
	V3	dd	?
	V4	dd	?
TIV	ends
TPTS	struct			;Texture destination points
	X1	dd	?
	Y1	dd	?
	Z1	dd	?
	X2	dd	?
	Y2	dd	?
	Z2	dd	?
	X3	dd	?
	Y3	dd	?
	Z3	dd	?
	X4	dd	?
	Y4	dd	?
	Z4	dd	?
TPTS	ends

	.data?

outbuffer	db	320 dup (?)

ilumv		dd	?
zsup		dd	?	;!0=ON
dither		dd	?	;!0=ON
_nzreplace	dd	?	;Flag

_xc		dd	?
_yc		dd	?
_xd		dd	?
_yd		dd	?
_xmin		dd	?
_xmax		dd	?

_xstart		dd	?
_y1st		dd	?	;1st y pos
_ypos		dd	?	;Current pos
_yhigh		dd	?	;Last pos

_minslope	dd	?
_maxslope	dd	?
_x1d		dd	?
_x1s		dd	?
_y1d		dd	?
_y1s		dd	?
_x2d		dd	?
_x2s		dd	?
_y2d		dd	?
_y2s		dd	?

_minflag	dd	?
_minsrci	dd	?
_mindesti	dd	?
_mindesty	dd	?
_maxflag	dd	?
_maxsrci	dd	?
_maxdesti	dd	?
_maxdesty	dd	?


XMAX		equ	319
;MWLX		equ	0
;MWRX		equ	320
;MWTY		equ	0		;Change code if this changes!

FRAC		equ	21
VERTMASK	equ	3		;Vertex index mask

M_COLOR		equ	00ffh		;Color field
M_NZR		equ	0400h		;Non-zero replacement
M_ZS		equ	0800h		;Zero supress
M_DITHER	equ	1000h		;Dither
M_METHOD	equ	6000h		;Method of plotting
M_TM		equ	2000h		;Texture mapping
M_SH		equ	4000h		;Shading
M_SHTM		equ	6000h		;Shaded texture map

WINH		equ	200
SCRNBUFW	equ	320

	.code

;********************************
;* Draw textured or constant colored face
;* EAX = *Image data
;* EBX = *OBJ struc
;* ESI = *Base XYZ words
;* EDI = *FACE.V1

 SUBR	tex_drawface

	movsx	edx,[ebx].D3OBJ.ILTMP
	movsx	ecx,[ebx].D3OBJ.ILUM
	add	edx,ecx
	mov	ilumv,edx

	movzx	edx,[ebx].D3OBJ.FLGS
	mov	ecx,edx
	and	edx,ZS_OF
	mov	zsup,edx

	and	ecx,DITH_OF
	mov	dither,ecx


	mov	ebx,[edi-FACE.V1].FACE.LINE
	shl	ebx,8				;*256
	add	eax,ebx

	mov	_ADDRL,eax

	lea	ebx,_AIVI

	mov	eax,[edi-FACE.V1].FACE.IXY1
	ror	eax,8
	ror	ax,8
	rol	eax,8
	mov	[ebx].TIV.V1,eax

	mov	eax,[edi-FACE.V1].FACE.IXY2
	ror	eax,8
	ror	ax,8
	rol	eax,8
	mov	[ebx].TIV.V2,eax

	mov	eax,[edi-FACE.V1].FACE.IXY3
	ror	eax,8
	ror	ax,8
	rol	eax,8
	mov	[ebx].TIV.V3,eax

	mov	eax,[edi-FACE.V1].FACE.IXY4
	ror	eax,8
	ror	ax,8
	rol	eax,8
	mov	[ebx].TIV.V4,eax


	lea	ebx,_ARPS

	mov	ecx,[edi]		;Get 1st offset
	mov	eax,[esi][ecx]
	add	eax,160
	mov	[ebx].TPTS.X1,eax

	mov	eax,4[esi][ecx]
	mov	[ebx].TPTS.Y1,eax

	mov	ecx,4[edi]		;Get 2nd offset
	mov	eax,[esi][ecx]
	add	eax,160
	mov	[ebx].TPTS.X2,eax

	mov	eax,4[esi][ecx]
	mov	[ebx].TPTS.Y2,eax

	mov	ecx,(4*2)[edi]		;Get 3rd offset
	mov	eax,[esi][ecx]
	add	eax,160
	mov	[ebx].TPTS.X3,eax

	mov	eax,4[esi][ecx]
	mov	[ebx].TPTS.Y3,eax

	mov	ecx,(4*3)[edi]		;Get 4th offset
	mov	eax,[esi][ecx]
	add	eax,160
	mov	[ebx].TPTS.X4,eax

	mov	eax,4[esi][ecx]
	mov	[ebx].TPTS.Y4,eax

;	jmp	poly_drawface
;Fall through

 SUBEND


;********************************
;* Draw textured or constant colored face


 SUBR	poly_drawface

;	PUSHMR	eax,ebx,ecx,edx,esi,edi


;Remove these???
;	mov	eax,_ACNTL
;	and	eax,M_NZR
;	mov	_nzreplace,eax


	call	poly_setup_

	jmp	ystrt

ylp:
	call	poly_linesetup_

	call	tex_srclinesetup_


	mov	eax,_ypos
	TST	eax
	jl	ynxt



	mov	edx,_xmin		;Line left X
	sar	edx,FRAC
	mov	_xstart,edx


	mov	ecx,_xmax
	sar	ecx,FRAC		;Kill fraction
	cmp	ecx,XMAX
	jl	@F			;X past max?
	mov	ecx,XMAX
@@:	sub	ecx,edx			;ECX=Loop cnt-1
	jl	ynxt


;컴컴컴컴컴컴컴�			>Adjust if left clipped

	TST	edx
	jge	sxok

	mov	_xstart,0

	add	ecx,edx
	jl	ynxt

	mov	eax,_xd
	mov	ebx,_yd
@@:
	add	_xc,eax
	add	_yc,ebx
	inc	edx
	jl	@B
sxok:

;컴컴컴컴컴컴컴�

	cmp	ecx,SCRNBUFW
	jge	ynxt			;Line too long?


	mov	edi,offset outbuffer	;EDI=* outbuffer pos

lp:
	mov	eax,_yc
	mov	esi,_xc
	sar	eax,FRAC		;Kill fraction
	shl	eax,8			;*256
	add	eax,_ADDRL
	sar	esi,FRAC		;Kill fraction
	add	esi,eax			;ESI=*pixel

	mov	eax,_xd
	mov	ebx,_yd

	add	_xc,eax
	add	_yc,ebx


	mov	al,[esi]		;Get pixel

;	cmp	_nzreplace,0
;	jz	nzoff			;Off?
;
;	TST	al
;	jz	@F
;	mov	al,BPTR _ACNTL		;Constant color
;@@:
;nzoff:
	mov	[edi],al
	inc	edi

	dec	ecx
	jge	lp


	sub	edi,offset outbuffer
	mov	eax,edi			;Pixels written

	call	tex_copyline

;컴컴컴컴컴컴컴�

ynxt:
	inc	_ypos

	mov	eax,_minslope
	mov	ebx,_maxslope
	add	_xmin,eax
	add	_xmax,ebx

	mov	eax,_x1d
	mov	ebx,_y1d
	add	_x1s,eax
	add	_y1s,ebx

	mov	eax,_x2d
	mov	ebx,_y2d
	add	_x2s,eax
	add	_y2s,ebx


ystrt:
	mov	eax,_ypos
	cmp	eax,_yhigh
	jge	x			;Y done?
	cmp	eax,WINH
	jl	ylp


x:
;	POPMR
	ret

 SUBEND


;********************************


;	yhighi = ylowi= 0;
;	ypos	 = yhigh	= ARPS[0][YO];
;
;	for (temp = 0; temp < NUMVERT; temp++)  {
;		if (ARPS[temp][YO] < ypos)  {
;			ypos	= ARPS[temp][YO];
;			ylowi	= temp;
;		}
;		if (ARPS[temp][YO] > yhigh)  {
;			yhigh	= ARPS[temp][YO];
;			yhighi= temp;
;		}
;	}
;
;	mindesti	= maxdesti	= ylowi;
;	mindesty	= maxdesty	= ARPS[ylowi][YO];
;	xmin = ARPS[ylowi][XO] << FRAC;
;	xmax = ARPS[ylowi][XO] << FRAC;


 SUBRP	poly_setup_

;	mov	_ylowi,0
	CLR	edi
;	mov	_yhighi,0

	mov	eax,_ARPS+4			;Vert1 Y
	mov	ebx,eax

	mov	ecx,3				;Chk 1-3 against 0
	mov	esi,(offset _ARPS)+4+(3*12)	;* Last Y
lp:
	cmp	eax,[esi]
	jle	@F
	mov	eax,[esi]			;New low
	mov	edi,ecx
@@:
	cmp	ebx,[esi]
	jge	@F
	mov	ebx,[esi]			;New high
;	mov	_yhighi,ecx
@@:
	sub	esi,12
	dec	ecx
	jg	lp

	mov	_y1st,eax			;Lowest
	mov	_ypos,eax			;Lowest
	mov	_yhigh,ebx			;Highest


	mov	_mindesti,edi
	mov	_maxdesti,edi

	mov	eax,edi
	add	edi,eax
	add	edi,eax				;*3
	mov	eax,(offset _ARPS)+4[edi*4]	;Y

	mov	_mindesty,eax
	mov	_maxdesty,eax

	mov	eax,(offset _ARPS)[edi*4]	;X
	shl	eax,FRAC
	mov	_xmin,eax
	mov	_xmax,eax



	ret

 SUBEND


;********************************


 SUBRP	poly_linesetup_

	mov	_minflag,0
	mov	_maxflag,0

	mov	eax,_mindesty
	cmp	eax,_ypos
	jne	noymin

	inc	_minflag		;1

	mov	esi,_mindesti		;Next vertex
	mov	_minsrci,esi
	mov	edi,esi
	dec	edi
	and	edi,VERTMASK
	mov	_mindesti,edi

	mov	eax,esi			;*3
	add	esi,eax
	add	esi,eax
	lea	esi,(offset _ARPS)[esi*4] ;ESI=* src pts

	mov	eax,edi			;*3
	add	edi,eax
	add	edi,eax
	lea	edi,(offset _ARPS)[edi*4] ;EDI=* dest pts

chkmin:	mov	eax,4[esi]		;Src Y
	cmp	eax,4[edi]		;Dest Y
	jne	@F			;Different Y?

	mov	esi,_mindesti		;Next vertex
	mov	_minsrci,esi
	mov	edi,esi
	dec	edi
	and	edi,VERTMASK
	mov	_mindesti,edi

	mov	eax,esi			;*3
	add	esi,eax
	add	esi,eax
	lea	esi,(offset _ARPS)[esi*4] ;ESI=* src pts

	mov	eax,edi			;*3
	add	edi,eax
	add	edi,eax
	lea	edi,(offset _ARPS)[edi*4] ;EDI=* dest pts
;Repeat problem?
	jmp	chkmin
@@:

	mov	eax,4[edi]		;Dest Y
	mov	_mindesty,eax

	mov	eax,[esi]		;Src X
	shl	eax,FRAC
;	add	eax,(1 shl (FRAC-1))
	mov	_xmin,eax

	mov	eax,4[esi]		;Src Y
	sub	eax,4[edi]		;Dest Y
	jz	@F
	mov	ebx,eax
	mov	eax,[esi]		;Src X
	sub	eax,[edi]		;Dest X
	shl	eax,FRAC
	cdq
	idiv	ebx
@@:	mov	_minslope,eax


noymin:


	mov	eax,_maxdesty
	cmp	eax,_ypos
	jne	noymax

	inc	_maxflag		;1

	mov	esi,_maxdesti		;Next vertex
	mov	_maxsrci,esi
	mov	edi,esi
	inc	edi
	and	edi,VERTMASK
	mov	_maxdesti,edi

	mov	eax,esi			;*3
	add	esi,eax
	add	esi,eax
	lea	esi,(offset _ARPS)[esi*4] ;ESI=* src pts

	mov	eax,edi			;*3
	add	edi,eax
	add	edi,eax
	lea	edi,(offset _ARPS)[edi*4] ;EDI=* dest pts
chkmax:
	mov	eax,4[esi]		;Src Y
	cmp	eax,4[edi]		;Dest Y
	jne	@F			;Different Y?

	mov	esi,_maxdesti		;Next vertex
	mov	_maxsrci,esi
	mov	edi,esi
	inc	edi
	and	edi,VERTMASK
	mov	_maxdesti,edi

	mov	eax,esi			;*3
	add	esi,eax
	add	esi,eax
	lea	esi,(offset _ARPS)[esi*4] ;ESI=* src pts

	mov	eax,edi			;*3
	add	edi,eax
	add	edi,eax
	lea	edi,(offset _ARPS)[edi*4] ;EDI=* dest pts
	jmp	chkmax
@@:

	mov	eax,4[edi]		;Dest Y
	mov	_maxdesty,eax

	mov	eax,[esi]		;Src X
	shl	eax,FRAC
;	add	eax,(1 shl (FRAC-1))
	mov	_xmax,eax

	mov	eax,4[esi]		;Src Y
	sub	eax,4[edi]		;Dest Y
	jz	@F
	mov	ebx,eax
	mov	eax,[esi]		;Src X
	sub	eax,[edi]		;Dest X
	shl	eax,FRAC
	cdq
	idiv	ebx
@@:	mov	_maxslope,eax


noymax:




	ret
 SUBEND



;********************************
;* Setup source texture variables for current line

 SUBRP	tex_srclinesetup_


	cmp	_minflag,0
	jz	@F
					;>Calc left polygon edge texture map
	mov	esi,offset _AIVI
	mov	edi,offset _ARPS

	mov	ebx,_minsrci

	movzx	eax,BPTR [esi][ebx*4]	;Img X position
	shl	eax,FRAC
	mov	_x1s,eax

	movzx	eax,BPTR 1[esi][ebx*4]	;Img Y position
	shl	eax,FRAC
	mov	_y1s,eax


	;(Img X dest - IX src) / (Vert Y dest - VY src)

	mov	ebx,_mindesti

	movzx	eax,BPTR [esi][ebx*4]	;Img X dest
	shl	eax,FRAC
	sub	eax,_x1s		;-IXSrc

	mov	edx,ebx			;*3
	add	ebx,edx
	add	ebx,edx

	mov	ecx,4[edi][ebx*4]	;Vert Y dest

	mov	ebx,_minsrci
	mov	edx,ebx			;*3
	add	ebx,edx
	add	ebx,edx
	sub	ecx,4[edi][ebx*4]	;-VYSrc

	cdq
	idiv	ecx
	mov	_x1d,eax


	;(Img Y dest - IY src) / (Vert Y dest - VY src)

	mov	ebx,_mindesti

	movzx	eax,BPTR 1[esi][ebx*4]	;Img Y dest
	shl	eax,FRAC
	sub	eax,_y1s		;-IYSrc

	cdq
	idiv	ecx
	mov	_y1d,eax

@@:

	cmp	_maxflag,0
	jz	@F
					;>Calc rgt polygon edge texture map
	mov	esi,offset _AIVI
	mov	edi,offset _ARPS

	mov	ebx,_maxsrci

	movzx	eax,BPTR [esi][ebx*4]	;Img X position
	shl	eax,FRAC
	mov	_x2s,eax

	movzx	eax,BPTR 1[esi][ebx*4]	;Img Y position
	shl	eax,FRAC
	mov	_y2s,eax


	;(Img X dest - IX src) / (Vert Y dest - VY src)

	mov	ebx,_maxdesti

	movzx	eax,BPTR [esi][ebx*4]	;Img X dest
	shl	eax,FRAC
	sub	eax,_x2s		;-IXSrc

	mov	edx,ebx			;*3
	add	ebx,edx
	add	ebx,edx

	mov	ecx,4[edi][ebx*4]	;Vert Y dest

	mov	ebx,_maxsrci
	mov	edx,ebx			;*3
	add	ebx,edx
	add	ebx,edx
	sub	ecx,4[edi][ebx*4]	;-VYSrc

	cdq
	idiv	ecx
	mov	_x2d,eax


	;(Img Y dest - IY src) / (Vert Y dest - VY src)

	mov	ebx,_maxdesti

	movzx	eax,BPTR 1[esi][ebx*4]	;Img Y dest
	shl	eax,FRAC
	sub	eax,_y2s		;-IYSrc

	cdq
	idiv	ecx
	mov	_y2d,eax

@@:


					;>Calc src line stepping
	mov	eax,_x1s
	mov	_xc,eax

	mov	eax,_y1s
	mov	_yc,eax


	mov	ebx,_xmax		;Max-Min+1
	sar	ebx,FRAC

	mov	eax,_xmin
	sar	eax,FRAC

	sub	ebx,eax
	inc	ebx
	jnz	@F
	dec	ebx			;Make -1
@@:

	mov	eax,_x2s
	sub	eax,_x1s
	cdq
	idiv	ebx
	mov	_xd,eax

	mov	eax,_y2s
	sub	eax,_y1s
	cdq
	idiv	ebx
	mov	_yd,eax




	ret

 SUBEND





;********************************
;* Copy a line of bytes to video buffer
;* EAX = Length
;* Trashes all non seg

 SUBR	tex_copyline

	local	x1:dword,
		x2:dword

	mov	esi,offset outbuffer

	mov	edx,_xstart
	mov	x1,edx
	add	eax,edx
	dec	eax
	mov	x2,eax

	mov	eax,x1
	cmp	eax,___xmin
	jge	@F			;Start x >= min?

	mov	eax,___xmin
	sub	eax,x1
	add	esi,eax

	mov	eax,___xmin
	mov	x1,eax
@@:
	mov	eax,x2
	cmp	eax,___xmax
	jle	@F			;End x <= max?
	mov	eax,___xmax
	mov	x2,eax
@@:
	mov	eax,x2
	cmp	eax,x1
	jl	x			;Start past end?



	mov	ecx,x2
	sub	ecx,x1
	inc	ecx			;ECX=Width



	mov	eax,_ypos
	imul	eax,SCRNBUFW		;Width in bytes

	add	eax,x1

	add	eax,offset scrnbuf
	mov	edi,eax


	mov	ebx,ilumv
	sub	ebx,10
	add	ebx,offset pix_t

	mov	eax,zsup
	TST	eax
	jnz	zs


	mov	eax,dither
	TST	eax
	jnz	dith

@@:
	mov	al,[esi]
	mov	edx,eax
	and	eax,0fh
	xor	edx,eax
	mov	al,[ebx][eax]
	inc	esi
	or	eax,edx

	mov	[edi],al
	inc	edi

	dec	ecx
	jg	@B

	jmp	x

dith:
	mov	eax,_ypos
	sub	eax,_y1st
	and	eax,1
	add	esi,eax
	add	edi,eax
	sub	ecx,eax
	jle	x
@@:
	mov	al,[esi]
	mov	edx,eax
	and	eax,0fh
	xor	edx,eax
	mov	al,[ebx][eax]
	add	esi,2
	or	eax,edx

	mov	[edi],al
	add	edi,2

	sub	ecx,2
	jg	@B

	jmp	x


zs:
	mov	eax,dither
	TST	eax
	jnz	zsdith

@@:
	mov	al,[esi]
	TST	al
	jz	zsnxt			;Transparent?

	mov	edx,eax
	and	eax,0fh
	xor	edx,eax
	mov	al,[ebx][eax]
	or	eax,edx

	mov	[edi],al
zsnxt:
	inc	esi
	inc	edi

	dec	ecx
	jg	@B

	jmp	x

zsdith:
	mov	eax,_ypos
	sub	eax,_y1st
	and	eax,1
	add	esi,eax
	add	edi,eax
	sub	ecx,eax
	jle	x
@@:
	mov	al,[esi]
	TST	al
	jz	zsdnxt			;Transparent?

	mov	edx,eax
	and	eax,0fh
	xor	edx,eax
	mov	al,[ebx][eax]
	or	eax,edx

	mov	[edi],al
zsdnxt:
	add	esi,2
	add	edi,2

	sub	ecx,2
	jg	@B



x:
	ret

 SUBEND


	.data
	db	0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0
pix_t	db	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
	db	15,15,15,15,15,15,15,15




	end
