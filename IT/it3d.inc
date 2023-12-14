;**************************************************************
;* IT 3D include file
;*.Last mod - 6/21/94 14:13
;**************************************************************

GEDSIG	equ	'vnEG'
GEOSIG	equ	'oeG'+1000000h
GEOSIGO	equ	'oeG'

GEOHDR	struct
	SIG	dd	?		;'GEO'+1 (+0 for old)
	IDLEN	dw	?		;Len of ID string or 0
	NVERT	dd	?		;# vertices
	NPOLY	dd	?		;# polygons
	NCENT	dd	?		;# centroids
	NANI	dd	?		;# animations
	NTPAL	dd	?		;# altered pals
	DISMDL	dd	?		;Display model
	PARTCNT	dd	?		;# of parts
	spare	dd	6 dup (?)	;
GEOHDR	ends

POLYGON	struct
	CTRL	dd	?		;Control word
	V1	dd	?		;1st vertex offset
	V2	dd	?		;2nd ^
	V3	dd	?		;3rd ^
	V4	dd	?		;4th ^
	NX	dd	?		;Normal (float)
	NY	dd	?		;^
	NZ	dd	?		;^
	IMG_s	db	32 dup (?)	;Image name
POLYGON	ends

GRUP	struct				;Entry in GED file
	X	dd	?		;X pos
	Y	dd	?		;Y pos
	Z	dd	?		;Z pos
	XA	dd	?		;XA (float)
	YA	dd	?		;YA (float)
	ZA	dd	?		;ZA (float)
	N_s	db	20 dup (?)	;Name of GRP file
	M_p	dd	?		;* mp
	OBJ_p	dd	?		;* obj
GRUP	ends

GRUPE	struct				;Entry in GRP file
	N_s	db	20 dup (?)	;Name
	X	dd	?		;X pos
	Y	dd	?		;Y pos
	Z	dd	?		;Z pos
	XA	dd	?		;XA (float)
	YA	dd	?		;YA (float)
	ZA	dd	?		;ZA (float)
	ID	dd	?		;
GRUPE	ends

GEDOBJ	struct				;Loose obj entry in GED file
	OBJ_p	dd	?		;* obj
	N_s	db	20 dup (?)	;File name
	X	dd	?		;X pos
	Y	dd	?		;Y pos
	Z	dd	?		;Z pos
	XA	dd	?		;XA (float)
	YA	dd	?		;YA (float)
	ZA	dd	?		;ZA (float)
	U1	dd	?		;User ?
	U2	dd	?		;User ?
	ID	dd	?		;ID
	CI	dd	?		;Cache index
	BACPOS1	dd	?		;?
	BACPOS2	dd	?		;?
	BACPOS3	dd	?		;?
	LINK_p	dd	?		;* obj
	PALNUM	dd	?		;!0=Special pal
	x	dd	7 dup (?)	;Spare
	FN_s	db	32 dup (?)	;?
GEDOBJ	ends

WIFFSSZ	equ	16		;Name string size

CHNKHDR	struct
	NM	dd	?		;4 byte name
	SZ	dd	?		;Size (motorola)
	N_s	db	WIFFSSZ dup (?)	;Name string (No null if 16 long)
CHNKHDR	ends

J3AHDR	struct
	VNUM	dd	?		;# vertices
	FNUM	dd	?		;# faces
J3AHDR	ends

DOTSHDR	struct
	TYP	dw	?		;1=8 bit, 2=16 bit
	W	dd	?		;Width
	H	dd	?		;Hgt
	CNUM	dw	?		;# colors in img (0 if true color)
DOTSHDR	ends

COLSHDR	struct
	TYP	dw	?		;1=15 bit
	CNUM	dw	?		;# colors
COLSHDR	ends

J3IMAP	struct
	FACE	dd	?		;Face index
	ID	dw	?		;Temp ID
	CTRL	dw	?		;
	LINE	dw	?		;Texture line offset
	IXY1	dw	?		;Texture vertice 1 Y:X (8:8)
	IXY2	dw	?		;
	IXY3	dw	?		;
	IXY4	dw	?		;
J3IMAP	ends

MDL	struct
	NXT_p	dd	?		;* next model or 0
	PTS_p	dd	?		;* points array (Cnt, XYZ,XYZ..)
	FACE_p	dd	?		;* face data
	TGA_p	dd	?		;* TGA struc or 0
	FLGS	dd	?		;Flags
	N_s	db	12 dup (?)	;Name (8+NULL)
MDL	ends

MRK_MF	equ	1

TGA	struct
	NXT_p	dd	?		;* next TGA or 0
	IMG_p	dd	?		;* image data
	IMGH	dd	?		;Image height
	PAL_p	dd	?		;* palette data
	PALCNT	dd	?		;# colors in pal (1-256)
	N_s	db	12 dup (?)	;Name (8+NULL)
TGA	ends

FACE	struct
	ID	dd	?		;
	V1	dd	?		;Vertex offset
	V2	dd	?		;
	V3	dd	?		;
	V4	dd	?		;
	LINE	dd	?		;Texture line offset
	IXY1	dd	?		;Texture vertice 1 Y:X (16:16)
	IXY2	dd	?		;^
	IXY3	dd	?		;^
	IXY4	dd	?		;^
FACE	ends

XYZ	struct
	X	dd	?
	Y	dd	?
	Z	dd	?
XYZ	ends

D3OBJ	struct
	NXT_p	dd	?	;* next visable object or 0
	WNXT_p	dd	?	;* next world object or 0
	X	dd	?	;X pos 24:8
	Y	dd	?	;Y ^
	Z	dd	?	;Z ^
	XV	dd	?	;X vel 24:8
	YV	dd	?	;Y ^
	ZV	dd	?	;Z ^
	XA	dw	?	;X angle 10:6
	YA	dw	?	;Y ^
	ZA	dw	?	;Z ^
	ID	dw	?	;Type ID
	FLGS	dw	?	;Flags
	ILUM	dw	?	;Ilumination value (+/-7)
	ILTMP	dw	?	;Current ilum value (0-?)
	ZTEMP	dw	?	;View relative Z for sorting
	CLRNG	dd	?	;Collision range
	PTS_p	dd	?	;* Points array (Cnt, XYZ,XYZ..)
	XPTS_p	dd	?	;* Xformed points array (Cnt, XYZ,XYZ..)
	FACE_p	dd	?	;* Face data
	PRC_p	dd	?	;* Process that owns
	MDL_p	dd	?	;* MDL struc or 0
D3OBJ	ends

FLAT_OF	equ	1
GND_OF	equ	2
ZS_OF	equ	4
DITH_OF	equ	8
MRK_OF	equ	4000h
SV_OF	equ	8000h

;.WD (world) file structures
MDLREC	struct
	PTCNT	dw	?		;# points after this struc
	FACECNT	dw	?		;# faces after points
	TGAI	dw	?		;TGA struc index (0-?)
	free	dd	?		;
	free2	dd	?		;
	N_s	db	12 dup (?)	;Name (8+NULL)
MDLREC	ends

OBJREC	struct
	X	dd	?	;X pos 24:8
	Y	dd	?	;Y ^
	Z	dd	?	;Z ^
	XA	dw	?	;X angle 10:6
	YA	dw	?	;Y ^
	ZA	dw	?	;Z ^
	ID	dw	?	;Type ID
	FLGS	dw	?	;Flags
	ILUM	dw	?	;Ilumination value (0-7)
	MDLI	dw	?	;MDL index (0-?)
	free	dd	?	;
	free2	dd	?	;
OBJREC	ends

TGAREC	struct
	PALCNT	dw	?		;# colors in pal (1-256) after struc
	IMGW	dw	?		;Image width (1-256) (after pal)
	IMGH	dw	?		;Image height
	free	dd	?		;
	free2	dd	?		;
	N_s	db	12 dup (?)	;Name (8+NULL)
TGAREC	ends

;.GAM file structures
IMGGAM	struct
	IMGH	dd	?	;Image height (after pal)
	LINE	dd	?	;Line offset used in game
	PALCNT	dd	?	;# colors in pal-1 (0-255) after struc (last item!)
IMGGAM	ends

MDLGAM	struct
	IMGI	dd	?	;TGA struc index (0-?)
	PTCNT	dd	?	;# points-1 after this struc (last item!)
MDLGAM	ends

FACEGAM	struct
	CTRL	dd	?	;
	PAL	dd	?	;
	V1	dd	?	;Vertex offset (*3)
	V2	dd	?	;
	V3	dd	?	;
	V4	dd	?	;
	ABYX	dd	?	;Texture vertice AB Y:X (8:8)
	CDYX	dd	?	;^
	LINE	dd	?	;Texture line offset
FACEGAM	ends

OBJGAM	struct
	X	dd	?	;X pos 24:0
	Y	dd	?	;Y ^
	Z	dd	?	;Z ^
	XA	dd	?	;X angle 10:6
	YA	dd	?	;Y ^
	ZA	dd	?	;Z ^
	ID	dd	?	;Type ID
	FLGS	dd	?	;Flags
	ILUM	dd	?	;Ilumination value (0-7)
	MDLI	dd	?	;MDL index (0-?)
OBJGAM	ends

;EOF
