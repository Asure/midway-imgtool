;;; Segment 0800 (0800:0000)

;; fn0800_0000: 0800:0000
;;   Called from:
;;     0800:02E7 (in fn0800_02C7)
fn0800_0000 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	call	far 1463h:000Ch
	cmp	ax,0h
	jge	001Ah

l0800_0017:
	jmp	002Eh

l0800_001A:
	mov	es,[3622h]
	push	word ptr es:[1732h]
	call	far 1463h:007Ch
	add	sp,2h
	jmp	003Ch

l0800_002E:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:22AEh
	add	sp,4h

l0800_003C:
	pop	si
	pop	di
	leave
	retf

;; fn0800_0040: 0800:0040
;;   Called from:
;;     0800:00F1 (in fn0800_00A0)
;;     1054:38E7 (in fn1054_37DD)
;;     1054:39D0 (in fn1054_38F9)
fn0800_0040 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[3622h]
	push	word ptr es:[1732h]
	push	0h
	call	far 1463h:004Eh
	add	sp,4h
	mov	es,[3622h]
	push	word ptr es:[1732h]
	push	101h
	call	far 1463h:004Eh
	add	sp,4h
	mov	es,[3622h]
	push	word ptr es:[1732h]
	push	202h
	call	far 1463h:004Eh
	add	sp,4h
	mov	es,[3622h]
	push	word ptr es:[1732h]
	push	303h
	call	far 1463h:004Eh
	add	sp,4h
	pop	si
	pop	di
	leave
	retf

;; fn0800_00A0: 0800:00A0
;;   Called from:
;;     0800:1829 (in main)
fn0800_00A0 proc
	push	bp
	mov	bp,sp
	mov	ax,6h
	call	far 149Ah:02C8h
	push	di
	push	si
	call	far 1463h:000Ch
	cbw
	mov	[bp-6h],ax
	cmp	ax,0h
	jge	00BEh

l0800_00BB:
	jmp	0103h

l0800_00BE:
	call	far 1463h:0028h
	cmp	ax,4h
	jl	00CBh

l0800_00C8:
	jmp	00D3h

l0800_00CB:
	mov	word ptr [bp-6h],0FFFFh
	jmp	0103h

l0800_00D3:
	push	ds
	push	42h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	4h
	call	far 1463h:0037h
	add	sp,2h
	mov	es,[3622h]
	mov	es:[1732h],ax
	call	far 0800h:0040h
	call	far 1463h:006Bh
	mov	[bp-2h],ax
	mov	word ptr [bp-4h],0h

l0800_0103:
	cmp	word ptr [bp-6h],0h
	jl	010Ch

l0800_0109:
	jmp	011Ch

l0800_010C:
	push	0DCh
	call	far 149Ah:22C1h
	add	sp,2h
	mov	[bp-4h],ax
	mov	[bp-2h],dx

l0800_011C:
	mov	ax,[bp-4h]
	mov	dx,[bp-2h]
	jmp	0125h

l0800_0125:
	pop	si
	pop	di
	leave
	retf

;; fn0800_0129: 0800:0129
;;   Called from:
;;     0800:1424 (in main)
fn0800_0129 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	push	ds
	push	6C2h
	push	ds
	push	65h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	ds
	push	86h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	0B5h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	0FEh
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	140h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	153h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	18Dh
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	1D5h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	215h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	24Ch
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	291h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	2DCh
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	321h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	357h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	383h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	3AFh
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	3F2h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	41Bh
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	445h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	48Ah
	call	far 149Ah:0ABCh
	add	sp,4h
	dec	word ptr [3202h]
	cmp	word ptr [3202h],0h
	jge	0238h

l0800_0235:
	jmp	023Fh

l0800_0238:
	inc	word ptr [31FEh]
	jmp	024Bh

l0800_023F:
	push	ds
	push	31FEh
	call	far 149Ah:0B00h
	add	sp,4h

l0800_024B:
	push	ds
	push	4C1h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	506h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	536h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	556h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	59Bh
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	5B5h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	5FCh
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	629h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	656h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	68Ch
	call	far 149Ah:0ABCh
	add	sp,4h
	pop	si
	pop	di
	leave
	retf

;; fn0800_02C7: 0800:02C7
;;   Called from:
;;     0800:0ABB (in fn0800_0A47)
;;     0800:0BB4 (in fn0800_0AC7)
;;     0800:0BDF (in fn0800_0AC7)
;;     0800:0C2E (in fn0800_0AC7)
;;     0800:0D31 (in fn0800_0AC7)
;;     0800:1AB8 (in main)
;;     0800:1B65 (in main)
;;     0800:1C6C (in main)
;;     0800:1D03 (in main)
;;     0800:1DB4 (in main)
;;     0800:1E3A (in main)
;;     0800:2016 (in main)
;;     0800:2215 (in main)
;;     0800:2638 (in main)
;;     0800:26C5 (in main)
;;     0800:2752 (in main)
;;     0800:294D (in main)
;;     0800:2A2B (in main)
;;     0800:2AB5 (in main)
;;     0800:2B81 (in main)
;;     0800:2C0E (in main)
;;     0800:3006 (in main)
;;     0800:3163 (in main)
;;     0800:318E (in main)
;;     0800:31ED (in main)
;;     0800:32FA (in main)
;;     0800:3A80 (in main)
;;     0800:3B3E (in main)
;;     0800:3B9D (in main)
;;     0800:4128 (in main)
;;     0800:48BE (in fn0800_481C)
;;     0800:4ADA (in fn0800_481C)
;;     0800:7470 (in fn0800_737C)
;;     0800:7E14 (in fn0800_7DD1)
;;     0800:7E6C (in fn0800_7DD1)
;;     1054:0077 (in fn1054_002B)
;;     1054:37D1 (in fn1054_3721)
;;     1054:3A65 (in fn1054_3A11)
;;     1054:3CAB (in fn1054_3C57)
;;     1054:3D04 (in fn1054_3C57)
;;     1054:3FBF (in fn1054_3F70)
fn0800_02C7 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	call	far 1054h:39D9h
	mov	es,[3624h]
	push	word ptr es:[0FA04h]
	push	word ptr es:[0FA02h]
	call	far 0800h:0000h
	add	sp,4h
	push	word ptr [bp+6h]
	call	far 149Ah:01DDh
	add	sp,2h
	pop	si
	pop	di
	leave
	retf

;; fn0800_02FE: 0800:02FE
;;   Called from:
;;     0800:3751 (in main)
;;     1054:114D (in fn1054_0DB3)
;;     1054:1778 (in fn1054_0DB3)
fn0800_02FE proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[3626h]
	cmp	word ptr es:[0208h],0h
	jg	031Ah

l0800_0317:
	jmp	04E4h

l0800_031A:
	mov	es,[3628h]
	cmp	word ptr es:[2C3Ah],0h
	jz	0329h

l0800_0326:
	jmp	0340h

l0800_0329:
	mov	es,[362Ah]
	push	word ptr es:[0FF1Eh]
	push	381Dh
	push	2C74h
	call	far 1054h:3EDEh
	add	sp,6h

l0800_0340:
	push	180Ah
	push	0FEDAh
	call	far 1054h:3C57h
	add	sp,4h
	mov	es,[362Ah]
	mov	si,es:[0FF1Eh]

l0800_0357:
	dec	si
	cmp	si,0h
	jge	0360h

l0800_035D:
	jmp	037Eh

l0800_0360:
	mov	es,[362Ch]
	mov	bx,si
	shl	bx,2h
	push	word ptr es:[bx+0F230h]
	push	word ptr es:[bx+0F22Eh]
	call	far 149Ah:22A8h
	add	sp,4h
	jmp	0357h

l0800_037E:
	mov	es,[362Ah]
	mov	si,es:[0FF20h]

l0800_0387:
	dec	si
	cmp	si,3h
	jge	0390h

l0800_038D:
	jmp	03AEh

l0800_0390:
	mov	es,[362Eh]
	mov	bx,si
	shl	bx,2h
	push	word ptr es:[bx+2C66h]
	push	word ptr es:[bx+2C64h]
	call	far 149Ah:22A8h
	add	sp,4h
	jmp	0387h

l0800_03AE:
	mov	es,[362Ah]
	cmp	word ptr es:[0FF2Eh],0ABCDh
	jz	03BEh

l0800_03BB:
	jmp	04C8h

l0800_03BE:
	mov	si,es:[0FF28h]

l0800_03C3:
	dec	si
	cmp	si,0h
	jge	03CCh

l0800_03C9:
	jmp	0453h

l0800_03CC:
	mov	es,[3630h]
	mov	bx,si
	shl	bx,2h
	les	bx,es:[bx+0FBCAh]
	mov	di,es:[bx+12h]

l0800_03DE:
	dec	di
	cmp	di,0h
	jge	03E7h

l0800_03E4:
	jmp	0435h

l0800_03E7:
	mov	ax,di
	shl	ax,2h
	mov	es,[3630h]
	mov	bx,si
	shl	bx,2h
	les	bx,es:[bx+0FBCAh]
	add	bx,14h
	add	bx,ax
	mov	ax,es:[bx+2h]
	or	ax,es:[bx]
	jnz	040Bh

l0800_0408:
	jmp	0432h

l0800_040B:
	mov	ax,di
	shl	ax,2h
	mov	es,[3630h]
	mov	bx,si
	shl	bx,2h
	les	bx,es:[bx+0FBCAh]
	add	bx,14h
	add	bx,ax
	push	word ptr es:[bx+2h]
	push	word ptr es:[bx]
	call	far 149Ah:22A8h
	add	sp,4h

l0800_0432:
	jmp	03DEh

l0800_0435:
	mov	es,[3630h]
	mov	bx,si
	shl	bx,2h
	push	word ptr es:[bx+0FBCCh]
	push	word ptr es:[bx+0FBCAh]
	call	far 149Ah:22A8h
	add	sp,4h
	jmp	03C3h

l0800_0453:
	mov	es,[362Ah]
	mov	si,es:[0FF2Ah]

l0800_045C:
	dec	si
	cmp	si,0h
	jge	0465h

l0800_0462:
	jmp	04C8h

l0800_0465:
	mov	es,[3632h]
	mov	bx,si
	shl	bx,2h
	les	bx,es:[bx+0FDD8h]
	mov	di,es:[bx+12h]

l0800_0477:
	dec	di
	cmp	di,0h
	jge	0480h

l0800_047D:
	jmp	04AAh

l0800_0480:
	mov	ax,di
	shl	ax,2h
	mov	es,[3632h]
	mov	bx,si
	shl	bx,2h
	les	bx,es:[bx+0FDD8h]
	add	bx,14h
	add	bx,ax
	push	word ptr es:[bx+2h]
	push	word ptr es:[bx]
	call	far 149Ah:22A8h
	add	sp,4h
	jmp	0477h

l0800_04AA:
	mov	es,[3632h]
	mov	bx,si
	shl	bx,2h
	push	word ptr es:[bx+0FDDAh]
	push	word ptr es:[bx+0FDD8h]
	call	far 149Ah:22A8h
	add	sp,4h
	jmp	045Ch

l0800_04C8:
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:1DCAh
	add	sp,2h
	mov	es,[3626h]
	mov	word ptr es:[0208h],0FFFFh

l0800_04E4:
	pop	si
	pop	di
	leave
	retf

;; fn0800_04E8: 0800:04E8
;;   Called from:
;;     0800:1505 (in main)
;;     0800:15E3 (in main)
;;     0800:1620 (in main)
;;     0800:165D (in main)
;;     0800:1693 (in main)
;;     0800:16EE (in main)
fn0800_04E8 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	les	bx,[bp+6h]
	mov	al,es:[bx]
	cbw
	jmp	058Dh

l0800_04FF:
	mov	es,[3634h]
	mov	ax,es:[2D72h]
	mov	dx,es:[2D74h]
	jmp	05C8h
0800:050F                                              E9                .
0800:0510 B6 00                                           ..              

l0800_0512:
	mov	es,[3636h]
	mov	ax,es:[0F22Ah]
	mov	dx,es:[0F22Ch]
	jmp	05C8h
0800:0522       E9 A3 00                                    ...           

l0800_0525:
	mov	es,[3638h]
	mov	ax,es:[2BBCh]
	mov	dx,es:[2BBEh]
	jmp	05C8h
0800:0535                E9 90 00                              ...        

l0800_0538:
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	inc	ax
	push	dx
	push	ax
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	call	far 149Ah:25AEh
	add	sp,8h
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	call	far 149Ah:260Eh
	add	sp,4h
	mov	si,ax
	les	bx,[bp+0Ah]
	cmp	byte ptr es:[bx+si-1h],5Ch
	jnz	056Ch

l0800_0569:
	jmp	057Eh

l0800_056C:
	push	ds
	push	6CEh
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	call	far 149Ah:2568h
	add	sp,8h

l0800_057E:
	mov	ax,[bp+0Ah]
	mov	dx,[bp+0Ch]
	jmp	05C8h
0800:0587                      E9 3E 00 E9 3B 00                 .>..;.   

l0800_058D:
	cmp	ax,53h
	jnz	0595h

l0800_0592:
	jmp	04FFh

l0800_0595:
	jle	059Ah

l0800_0597:
	jmp	05ADh

l0800_059A:
	sub	ax,43h
	jnz	05A2h

l0800_059F:
	jmp	0525h

l0800_05A2:
	sub	ax,6h
	jnz	05AAh

l0800_05A7:
	jmp	0512h

l0800_05AA:
	jmp	0538h

l0800_05AD:
	sub	ax,63h
	jnz	05B5h

l0800_05B2:
	jmp	0525h

l0800_05B5:
	sub	ax,6h
	jnz	05BDh

l0800_05BA:
	jmp	0512h

l0800_05BD:
	sub	ax,0Ah
	jnz	05C5h

l0800_05C2:
	jmp	04FFh

l0800_05C5:
	jmp	0538h

l0800_05C8:
	pop	si
	pop	di
	leave
	retf

;; fn0800_05CC: 0800:05CC
;;   Called from:
;;     0800:2565 (in main)
;;     0800:2DC0 (in main)
;;     0800:2F30 (in main)
;;     0800:3762 (in main)
fn0800_05CC proc
	push	bp
	mov	bp,sp
	mov	ax,8h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	push	5Ch
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:293Ch
	add	sp,6h
	or	dx,ax
	jz	05FCh

l0800_05F9:
	jmp	0652h

l0800_05FC:
	push	3Ah
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:293Ch
	add	sp,6h
	or	dx,ax
	jz	0613h

l0800_0610:
	jmp	0652h

l0800_0613:
	mov	es,[363Ah]
	cmp	byte ptr es:[0D068h],0h
	jnz	0622h

l0800_061F:
	jmp	0632h

l0800_0622:
	mov	es,[363Ch]
	mov	ax,es:[173Ch]
	mov	dx,es:[173Eh]
	jmp	063Fh

l0800_0632:
	mov	es,[3636h]
	mov	ax,es:[0F22Ah]
	mov	dx,es:[0F22Ch]

l0800_063F:
	push	dx
	push	ax
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	call	far 149Ah:25AEh
	add	sp,8h
	jmp	06C1h

l0800_0652:
	mov	es,[363Ah]
	cmp	byte ptr es:[0D068h],0h
	jnz	0661h

l0800_065E:
	jmp	06BAh

l0800_0661:
	mov	es,[363Ch]
	push	word ptr es:[173Eh]
	push	word ptr es:[173Ch]
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	call	far 149Ah:25AEh
	add	sp,8h
	push	5Ch
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:29B0h
	add	sp,6h
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	mov	ax,[bp-2h]
	or	ax,[bp-4h]
	jz	069Eh

l0800_069B:
	jmp	06B4h

l0800_069E:
	push	3Ah
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-4h],ax
	mov	[bp-2h],dx

l0800_06B4:
	inc	word ptr [bp-4h]
	jmp	06C1h

l0800_06BA:
	les	bx,[bp+0Ah]
	mov	byte ptr es:[bx],0h

l0800_06C1:
	push	word ptr [bp-2h]
	push	word ptr [bp-4h]
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	call	far 149Ah:2568h
	add	sp,8h
	pop	si
	pop	di
	leave
	retf

;; fn0800_06D9: 0800:06D9
;;   Called from:
;;     0800:0CE8 (in fn0800_0AC7)
;;     0800:2A6C (in main)
fn0800_06D9 proc
	push	bp
	mov	bp,sp
	mov	ax,54h
	call	far 149Ah:02C8h
	push	di
	push	si
	push	0h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:34E6h
	add	sp,6h
	cmp	ax,0h
	jz	06FEh

l0800_06FB:
	jmp	0780h

l0800_06FE:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	lea	ax,[bp-54h]
	push	ss
	push	ax
	call	far 149Ah:25AEh
	add	sp,8h
	push	2Eh
	lea	ax,[bp-54h]
	push	ss
	push	ax
	call	far 149Ah:29B0h
	add	sp,6h
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	or	dx,ax
	jnz	072Dh

l0800_072A:
	jmp	0738h

l0800_072D:
	les	bx,[bp-4h]
	mov	byte ptr es:[bx+1h],7Eh
	jmp	0749h

l0800_0738:
	push	ds
	push	6D0h
	lea	ax,[bp-54h]
	push	ss
	push	ax
	call	far 149Ah:2568h
	add	sp,8h

l0800_0749:
	push	0h
	lea	ax,[bp-54h]
	push	ss
	push	ax
	call	far 149Ah:34E6h
	add	sp,6h
	cmp	ax,0h
	jz	0760h

l0800_075D:
	jmp	076Dh

l0800_0760:
	lea	ax,[bp-54h]
	push	ss
	push	ax
	call	far 149Ah:365Eh
	add	sp,4h

l0800_076D:
	lea	ax,[bp-54h]
	push	ss
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:364Ah
	add	sp,8h

l0800_0780:
	pop	si
	pop	di
	leave
	retf

;; fn0800_0784: 0800:0784
;;   Called from:
;;     0800:1DCB (in main)
fn0800_0784 proc
	push	bp
	mov	bp,sp
	mov	ax,0Ch
	call	far 149Ah:02C8h
	push	di
	push	si

l0800_0791:
	mov	es,[363Eh]
	push	word ptr es:[2D7Ch]
	push	word ptr es:[2D7Ah]
	push	0FFh
	push	381Dh
	push	5B9Ah
	call	far 149Ah:272Eh
	add	sp,0Ah
	or	dx,ax
	jnz	07B7h

l0800_07B4:
	jmp	0846h

l0800_07B7:
	mov	es,[3640h]
	cmp	byte ptr es:[5B9Ah],20h
	jg	07C6h

l0800_07C3:
	jmp	0843h

l0800_07C6:
	push	3Ah
	push	es
	push	5B9Ah
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	or	dx,ax
	jnz	07E1h

l0800_07DE:
	jmp	0843h

l0800_07E1:
	les	bx,[bp-4h]
	mov	byte ptr es:[bx],0h
	mov	es,[3642h]
	mov	ax,es:[0FA36h]
	mov	dx,es:[0FA38h]
	mov	[bp-0Ch],ax
	mov	[bp-0Ah],dx
	push	14h
	call	far 149Ah:22A2h
	add	sp,2h
	mov	[bp-8h],ax
	mov	[bp-6h],dx
	push	381Dh
	push	5B9Ah
	push	word ptr [bp-6h]
	push	word ptr [bp-8h]
	call	far 149Ah:25AEh
	add	sp,8h
	mov	ax,[bp-0Ch]
	mov	dx,[bp-0Ah]
	les	bx,[bp-8h]
	mov	es:[bx+10h],ax
	mov	es:[bx+12h],dx
	mov	ax,[bp-8h]
	mov	dx,[bp-6h]
	mov	es,[3642h]
	mov	es:[0FA36h],ax
	mov	es:[0FA38h],dx

l0800_0843:
	jmp	0791h

l0800_0846:
	pop	si
	pop	di
	leave
	retf

;; fn0800_084A: 0800:084A
;;   Called from:
;;     0800:1DD0 (in main)
fn0800_084A proc
	push	bp
	mov	bp,sp
	mov	ax,6h
	call	far 149Ah:02C8h
	push	di
	push	si

l0800_0857:
	mov	es,[3644h]
	push	word ptr es:[0A7DCh]
	push	word ptr es:[0A7DAh]
	push	0FFh
	push	381Dh
	push	5B9Ah
	call	far 149Ah:272Eh
	add	sp,0Ah
	or	dx,ax
	jnz	087Dh

l0800_087A:
	jmp	0906h

l0800_087D:
	mov	es,[3640h]
	cmp	byte ptr es:[5B9Ah],20h
	jg	088Ch

l0800_0889:
	jmp	0903h

l0800_088C:
	push	3Ah
	push	es
	push	5B9Ah
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	or	dx,ax
	jnz	08A7h

l0800_08A4:
	jmp	0903h

l0800_08A7:
	les	bx,[bp-4h]
	mov	byte ptr es:[bx],0h
	push	381Dh
	push	5B9Ah
	call	far 0800h:757Ch
	add	sp,4h
	cmp	ax,0h
	jz	08C4h

l0800_08C1:
	jmp	0903h

l0800_08C4:
	push	381Dh
	push	5B9Ah
	call	far 1054h:3541h
	add	sp,4h
	inc	ax
	jz	08D8h

l0800_08D5:
	jmp	0903h

l0800_08D8:
	push	381Dh
	push	5B9Ah
	mov	es,[3646h]
	mov	ax,es:[0CF9Eh]
	inc	word ptr es:[0CF9Eh]
	mov	cx,ax
	shl	ax,2h
	add	ax,cx
	shl	ax,1h
	add	ax,0A826h
	push	180Ah
	push	ax
	call	far 149Ah:25AEh
	add	sp,8h

l0800_0903:
	jmp	0857h

l0800_0906:
	pop	si
	pop	di
	leave
	retf

;; fn0800_090A: 0800:090A
;;   Called from:
;;     0800:09AA (in fn0800_090A)
;;     0800:60B8 (in fn0800_550A)
fn0800_090A proc
	push	bp
	mov	bp,sp
	mov	ax,8h
	call	far 149Ah:02C8h
	push	di
	push	si
	les	bx,[bp+6h]
	cmp	byte ptr es:[bx],0h
	jz	0923h

l0800_0920:
	jmp	0929h

l0800_0923:
	mov	ax,1h
	jmp	0A43h

l0800_0929:
	mov	es,[3642h]
	mov	bx,[bp+0Ah]
	shl	bx,2h
	mov	ax,es:[bx+0FA36h]
	mov	dx,es:[bx+0FA38h]
	mov	[bp-8h],ax
	mov	[bp-6h],dx
	mov	ax,[bp-6h]
	or	ax,[bp-8h]
	jnz	094Eh

l0800_094B:
	jmp	0997h

l0800_094E:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	word ptr [bp-6h]
	push	word ptr [bp-8h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	096Ah

l0800_0967:
	jmp	0970h

l0800_096A:
	mov	ax,0h
	jmp	0A43h

l0800_0970:
	les	bx,[bp-8h]
	mov	ax,es:[bx+12h]
	or	ax,es:[bx+10h]
	jz	0980h

l0800_097D:
	jmp	0983h

l0800_0980:
	jmp	0997h

l0800_0983:
	les	bx,[bp-8h]
	mov	ax,es:[bx+10h]
	mov	dx,es:[bx+12h]
	mov	[bp-8h],ax
	mov	[bp-6h],dx
	jmp	094Eh

l0800_0997:
	cmp	word ptr [bp+0Ah],0h
	jnz	09A0h

l0800_099D:
	jmp	09C0h

l0800_09A0:
	push	0h
	push	0h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 0800h:090Ah
	add	sp,8h
	cmp	ax,0h
	jz	09BAh

l0800_09B7:
	jmp	09C0h

l0800_09BA:
	mov	ax,0h
	jmp	0A43h

l0800_09C0:
	cmp	word ptr [bp+0Ch],0h
	jnz	09C9h

l0800_09C6:
	jmp	0A3Dh

l0800_09C9:
	push	14h
	call	far 149Ah:22A2h
	add	sp,2h
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	word ptr [bp-2h]
	push	word ptr [bp-4h]
	call	far 149Ah:25AEh
	add	sp,8h
	les	bx,[bp-4h]
	sub	ax,ax
	mov	es:[bx+12h],ax
	mov	es:[bx+10h],ax
	mov	es,[3642h]
	mov	bx,[bp+0Ah]
	shl	bx,2h
	mov	ax,es:[bx+0FA38h]
	or	ax,es:[bx+0FA36h]
	jz	0A13h

l0800_0A10:
	jmp	0A2Ch

l0800_0A13:
	mov	ax,[bp-4h]
	mov	dx,[bp-2h]
	mov	bx,[bp+0Ah]
	shl	bx,2h
	mov	es:[bx+0FA36h],ax
	mov	es:[bx+0FA38h],dx
	jmp	0A3Dh

l0800_0A2C:
	mov	ax,[bp-4h]
	mov	dx,[bp-2h]
	les	bx,[bp-8h]
	mov	es:[bx+10h],ax
	mov	es:[bx+12h],dx

l0800_0A3D:
	mov	ax,1h
	jmp	0A43h

l0800_0A43:
	pop	si
	pop	di
	leave
	retf

;; fn0800_0A47: 0800:0A47
;;   Called from:
;;     0800:28DE (in main)
;;     0800:3330 (in main)
fn0800_0A47 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[363Eh]
	mov	ax,es:[2D7Ah]
	mov	dx,es:[2D7Ch]
	mov	es,[3648h]
	cmp	es:[5CA4h],ax
	jz	0A6Fh

l0800_0A6C:
	jmp	0A79h

l0800_0A6F:
	cmp	es:[5CA6h],dx
	jnz	0A79h

l0800_0A76:
	jmp	0AC3h

l0800_0A79:
	mov	ax,es:[5CA6h]
	or	ax,es:[5CA4h]
	jnz	0A87h

l0800_0A84:
	jmp	0AC3h

l0800_0A87:
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:063Ch
	add	sp,4h
	inc	ax
	jz	0A9Fh

l0800_0A9C:
	jmp	0AC3h

l0800_0A9F:
	mov	es,[364Ah]
	push	word ptr es:[0D2B4h]
	push	word ptr es:[0D2B2h]
	push	ds
	push	6D5h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_0AC3:
	pop	si
	pop	di
	leave
	retf

;; fn0800_0AC7: 0800:0AC7
;;   Called from:
;;     0800:2E77 (in main)
;;     0800:345E (in main)
fn0800_0AC7 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	si,0h
	jmp	0ADBh

l0800_0ADA:
	inc	si

l0800_0ADB:
	mov	es,[364Ch]
	cmp	es:[0A7F6h],si
	jg	0AE9h

l0800_0AE6:
	jmp	0BC2h

l0800_0AE9:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	mov	es,[364Eh]
	mov	bx,si
	shl	bx,2h
	push	word ptr es:[bx+2A2Eh]
	push	word ptr es:[bx+2A2Ch]
	call	far 149Ah:296Ah
	add	sp,8h
	cmp	ax,0h
	jz	0B12h

l0800_0B0F:
	jmp	0BBFh

l0800_0B12:
	mov	es,[364Eh]
	mov	bx,si
	shl	bx,2h
	mov	ax,es:[bx+2A2Ch]
	mov	dx,es:[bx+2A2Eh]
	mov	es,[364Ah]
	mov	es:[0D2B2h],ax
	mov	es:[0D2B4h],dx
	mov	es,[3650h]
	mov	es:[54E0h],si
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	180Ah
	push	67Eh
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[364Ah]
	push	word ptr es:[0D2B4h]
	push	word ptr es:[0D2B2h]
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	push	ds
	push	6ECh
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[3648h]
	mov	es:[5CA4h],ax
	mov	es:[5CA6h],dx
	mov	ax,es:[5CA6h]
	or	ax,es:[5CA4h]
	jz	0BA0h

l0800_0B9D:
	jmp	0BBCh

l0800_0BA0:
	push	180Ah
	push	67Eh
	push	ds
	push	6EEh
	call	far 149Ah:0ABCh
	add	sp,8h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_0BBC:
	jmp	0D5Ch

l0800_0BBF:
	jmp	0ADAh

l0800_0BC2:
	mov	es,[364Ch]
	cmp	word ptr es:[0A7F6h],64h
	jz	0BD1h

l0800_0BCE:
	jmp	0BE7h

l0800_0BD1:
	push	ds
	push	70Ch
	call	far 149Ah:0ABCh
	add	sp,4h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_0BE7:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:260Eh
	add	sp,4h
	inc	ax
	push	ax
	call	far 149Ah:22A2h
	add	sp,2h
	mov	es,[364Ah]
	mov	es:[0D2B2h],ax
	mov	es:[0D2B4h],dx
	mov	ax,es:[0D2B4h]
	or	ax,es:[0D2B2h]
	jz	0C1Ah

l0800_0C17:
	jmp	0C36h

l0800_0C1A:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	750h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_0C36:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	mov	es,[364Ah]
	push	word ptr es:[0D2B4h]
	push	word ptr es:[0D2B2h]
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[364Ch]
	mov	ax,es:[0A7F6h]
	mov	es,[3650h]
	mov	es:[54E0h],ax
	mov	es,[364Ah]
	mov	ax,es:[0D2B2h]
	mov	dx,es:[0D2B4h]
	mov	es,[364Ch]
	mov	bx,es:[0A7F6h]
	shl	bx,2h
	mov	es,[364Eh]
	mov	es:[bx+2A2Ch],ax
	mov	es:[bx+2A2Eh],dx
	mov	es,[364Ch]
	inc	word ptr es:[0A7F6h]
	mov	bx,es:[0A7F6h]
	shl	bx,2h
	mov	es,[3642h]
	sub	ax,ax
	mov	es:[bx+0FA38h],ax
	mov	es:[bx+0FA36h],ax
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	180Ah
	push	67Eh
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[364Ah]
	push	word ptr es:[0D2B4h]
	push	word ptr es:[0D2B2h]
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	push	180Ah
	push	67Eh
	call	far 0800h:06D9h
	add	sp,4h
	push	ds
	push	777h
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[3648h]
	mov	es:[5CA4h],ax
	mov	es:[5CA6h],dx
	mov	ax,es:[5CA6h]
	or	ax,es:[5CA4h]
	jz	0D1Dh

l0800_0D1A:
	jmp	0D39h

l0800_0D1D:
	push	180Ah
	push	67Eh
	push	ds
	push	779h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_0D39:
	push	381Dh
	push	4CC0h
	push	ds
	push	795h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ch
	jmp	0D5Ch

l0800_0D5C:
	pop	si
	pop	di
	leave
	retf

;; fn0800_0D60: 0800:0D60
;;   Called from:
;;     0800:2357 (in main)
;;     0800:7EDC (in fn0800_7DD1)
fn0800_0D60 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[3654h]
	mov	word ptr es:[2A22h],987Fh
	mov	ah,[bp+6h]
	sub	al,al
	or	es:[2A22h],ax
	push	1B0h
	push	0h
	call	far 1481h:0004h
	add	sp,4h
	mov	es,[3654h]
	push	word ptr es:[2A22h]
	call	far 1492h:0008h
	add	sp,2h
	pop	si
	pop	di
	leave
	retf

;; main: 0800:0DA4
main proc
	push	bp
	mov	bp,sp
	mov	ax,0E4h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[3656h]
	mov	word ptr es:[0D2AEh],0h
	push	ds
	push	79Ah
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	7D1h
	push	ds
	push	7D9h
	call	far 149Ah:0ABCh
	add	sp,8h
	mov	es,[3658h]
	mov	word ptr es:[54D4h],0C76Ch
	mov	word ptr es:[54D6h],180Ah
	mov	es,[365Ah]
	mov	word ptr es:[020Ah],5B7Ah
	mov	word ptr es:[020Ch],381Dh
	mov	es,[365Ch]
	mov	word ptr es:[022Eh],0h
	push	0DCh
	call	far 149Ah:22C1h
	add	sp,2h
	mov	es,[365Eh]
	mov	es:[0A7E0h],ax
	mov	es:[0A7E2h],dx
	mov	ax,es:[0A7E2h]
	or	ax,es:[0A7E0h]
	jz	0E2Ch

l0800_0E29:
	jmp	0E42h

l0800_0E2C:
	push	ds
	push	800h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	1h
	call	far 149Ah:01DDh
	add	sp,2h

l0800_0E42:
	mov	es,[3660h]
	mov	byte ptr es:[0A7E4h],0h
	push	ds
	push	831h
	push	381Dh
	push	4CC0h
	call	far 149Ah:25AEh
	add	sp,8h
	mov	ax,0h
	mov	es,[3662h]
	mov	es:[54EAh],ax
	mov	es,[3664h]
	mov	es:[0D2AAh],ax
	mov	ax,0h
	mov	dx,0h
	mov	es,[3666h]
	mov	es:[5B68h],ax
	mov	es:[5B6Ah],dx
	mov	es,[3668h]
	mov	es:[5B74h],ax
	mov	es:[5B76h],dx
	mov	es,[366Ah]
	mov	word ptr es:[54CEh],0h
	mov	es,[364Ch]
	mov	word ptr es:[0A7F6h],0h
	mov	es,[366Ch]
	mov	word ptr es:[0FF1Ah],836h
	mov	es:[0FF1Ch],ds
	mov	es,[366Eh]
	mov	word ptr es:[0F1FEh],841h
	mov	es:[0F200h],ds
	mov	es,[3670h]
	mov	word ptr es:[54DCh],84Ch
	mov	es:[54DEh],ds
	mov	es,[366Ch]
	mov	ax,es:[0FF1Ah]
	mov	dx,es:[0FF1Ch]
	mov	es,[3672h]
	mov	es:[5B8Eh],ax
	mov	es:[5B90h],dx
	mov	es,[366Eh]
	mov	ax,es:[0F1FEh]
	mov	dx,es:[0F200h]
	mov	es,[364Ah]
	mov	es:[0D2B2h],ax
	mov	es:[0D2B4h],dx
	mov	es,[3674h]
	mov	word ptr es:[0D2ACh],0FFFFh
	mov	es,[3650h]
	mov	word ptr es:[54E0h],0FFFFh
	mov	es,[3642h]
	sub	ax,ax
	mov	es:[0FA38h],ax
	mov	es:[0FA36h],ax
	mov	es,[3676h]
	mov	word ptr es:[54E4h],1h
	mov	ax,0h
	mov	es,[3678h]
	mov	es:[54CCh],ax
	mov	es,[367Ah]
	mov	es:[0FDCAh],ax
	call	far 0800h:4134h
	mov	es,[367Ch]
	mov	word ptr es:[5B78h],0FFFFh
	mov	ax,0h
	mov	es,[3646h]
	mov	es:[0CF9Eh],ax
	mov	es,[367Eh]
	mov	es:[0A7D4h],ax
	mov	es,[3626h]
	mov	word ptr es:[0208h],0FFFFh
	mov	es,[3680h]
	mov	word ptr es:[0D2A8h],0FFFFh
	mov	es,[3682h]
	mov	word ptr es:[0D29Eh],0h
	mov	word ptr es:[0D2A0h],200h
	mov	ax,es:[0D29Eh]
	mov	dx,es:[0D2A0h]
	mov	es,[3684h]
	mov	es:[2A06h],ax
	mov	es:[2A08h],dx
	mov	es,[3686h]
	sub	ax,ax
	mov	es:[5B6Eh],ax
	mov	es:[5B6Ch],ax
	mov	es,[3682h]
	mov	ax,es:[0D29Eh]
	mov	dx,es:[0D2A0h]
	mov	es,[3688h]
	mov	es:[0FBC6h],ax
	mov	es:[0FBC8h],dx
	mov	es,[368Ah]
	mov	word ptr es:[2A28h],0h
	mov	word ptr es:[2A2Ah],800h
	mov	ax,0h
	mov	dx,0h
	mov	es,[368Ch]
	mov	es:[1734h],ax
	mov	es:[1736h],dx
	mov	es,[368Eh]
	mov	es:[172Eh],ax
	mov	es:[1730h],dx
	mov	es,[3690h]
	mov	es:[021Ah],ax
	mov	es:[021Ch],dx
	mov	es,[3692h]
	mov	es:[5C9Eh],ax
	mov	es:[5CA0h],dx
	mov	es,[3694h]
	mov	word ptr es:[077Ch],5C9Eh
	mov	word ptr es:[077Eh],381Dh
	mov	ax,0h
	mov	dx,0h
	mov	es,[3696h]
	mov	es:[1728h],ax
	mov	es:[172Ah],dx
	mov	es,[3698h]
	mov	es:[1720h],ax
	mov	es:[1722h],dx
	mov	es,[369Ah]
	mov	es:[0200h],ax
	mov	es:[0202h],dx
	mov	es,[369Ch]
	mov	es:[5B96h],ax
	mov	es:[5B98h],dx
	mov	es,[369Eh]
	mov	word ptr es:[0D06Eh],5B96h
	mov	word ptr es:[0D070h],381Dh
	mov	es,[36A0h]
	mov	byte ptr es:[0232h],1h
	mov	es,[36A2h]
	sub	ax,ax
	mov	es:[0D2A4h],ax
	mov	es:[0D2A2h],ax
	mov	es,[36A4h]
	mov	word ptr es:[0F1FCh],0h
	mov	es,[36A6h]
	mov	word ptr es:[54E2h],0h
	mov	ax,0h
	mov	es,[36A8h]
	mov	es:[54D2h],ax
	mov	es,[36AAh]
	mov	es:[5B8Ch],ax
	mov	es,[36ACh]
	mov	word ptr es:[0A7DEh],0h
	mov	es,[36AEh]
	mov	word ptr es:[2B6Eh],0h
	mov	es,[36B0h]
	mov	word ptr es:[2C72h],0h
	mov	ax,0h
	mov	es,[36B2h]
	mov	es:[0D272h],ax
	mov	es,[36B4h]
	mov	es:[0D2B0h],ax
	mov	ax,0h
	mov	dx,0h
	mov	es,[36B6h]
	mov	es:[2A24h],ax
	mov	es:[2A26h],dx
	mov	es,[36B8h]
	mov	es:[2C6Ch],ax
	mov	es:[2C6Eh],dx
	mov	es,[36BAh]
	mov	word ptr es:[0212h],0h
	mov	es,[36BCh]
	mov	word ptr es:[2C38h],0h
	push	28h
	push	180Ah
	push	754h
	call	far 149Ah:352Ch
	add	sp,6h
	mov	es,[3638h]
	mov	es:[2BBCh],ax
	mov	es:[2BBEh],dx
	push	ds
	push	857h
	call	far 149Ah:26A0h
	add	sp,4h
	mov	es,[3636h]
	mov	es:[0F22Ah],ax
	mov	es:[0F22Ch],dx
	mov	ax,es:[0F22Ch]
	or	ax,es:[0F22Ah]
	jnz	116Fh

l0800_116C:
	jmp	119Ch

l0800_116F:
	push	word ptr es:[0F22Ch]
	push	word ptr es:[0F22Ah]
	push	180Ah
	push	0D276h
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[3636h]
	mov	word ptr es:[0F22Ah],0D276h
	mov	word ptr es:[0F22Ch],180Ah
	jmp	11C1h

l0800_119C:
	mov	es,[36BEh]
	mov	byte ptr es:[0D276h],0h
	push	28h
	push	es
	push	0D276h
	call	far 149Ah:352Ch
	add	sp,6h
	mov	es,[3636h]
	mov	es:[0F22Ah],ax
	mov	es:[0F22Ch],dx

l0800_11C1:
	push	ds
	push	85Eh
	call	far 149Ah:26A0h
	add	sp,4h
	mov	es,[3634h]
	mov	es:[2D72h],ax
	mov	es:[2D74h],dx
	mov	ax,es:[2D74h]
	or	ax,es:[2D72h]
	jnz	11E8h

l0800_11E5:
	jmp	1215h

l0800_11E8:
	push	word ptr es:[2D74h]
	push	word ptr es:[2D72h]
	push	381Dh
	push	2BC0h
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[3634h]
	mov	word ptr es:[2D72h],2BC0h
	mov	word ptr es:[2D74h],381Dh
	jmp	123Ah

l0800_1215:
	mov	es,[36C0h]
	mov	byte ptr es:[2BC0h],0h
	push	28h
	push	es
	push	2BC0h
	call	far 149Ah:352Ch
	add	sp,6h
	mov	es,[3634h]
	mov	es:[2D72h],ax
	mov	es:[2D74h],dx

l0800_123A:
	mov	es,[3634h]
	push	word ptr es:[2D74h]
	push	word ptr es:[2D72h]
	call	far 149Ah:260Eh
	add	sp,4h
	mov	bx,ax
	mov	es,[3634h]
	mov	ax,es
	les	si,es:[2D72h]
	cmp	byte ptr es:[bx+si-1h],5Ch
	jnz	1267h

l0800_1264:
	jmp	127Fh

l0800_1267:
	push	ds
	push	865h
	mov	es,ax
	push	word ptr es:[2D74h]
	push	word ptr es:[2D72h]
	call	far 149Ah:2568h
	add	sp,8h

l0800_127F:
	mov	es,[3636h]
	push	word ptr es:[0F22Ch]
	push	word ptr es:[0F22Ah]
	call	far 149Ah:260Eh
	add	sp,4h
	mov	si,ax
	mov	es,[3636h]
	les	bx,es:[0F22Ah]
	cmp	byte ptr es:[bx+si-1h],5Ch
	jnz	12AAh

l0800_12A7:
	jmp	12C4h

l0800_12AA:
	push	ds
	push	867h
	mov	es,[3636h]
	push	word ptr es:[0F22Ch]
	push	word ptr es:[0F22Ah]
	call	far 149Ah:2568h
	add	sp,8h

l0800_12C4:
	mov	es,[3638h]
	push	word ptr es:[2BBEh]
	push	word ptr es:[2BBCh]
	call	far 149Ah:260Eh
	add	sp,4h
	mov	si,ax
	mov	es,[3638h]
	les	bx,es:[2BBCh]
	cmp	byte ptr es:[bx+si-1h],5Ch
	jnz	12EFh

l0800_12EC:
	jmp	1309h

l0800_12EF:
	push	ds
	push	869h
	mov	es,[3638h]
	push	word ptr es:[2BBEh]
	push	word ptr es:[2BBCh]
	call	far 149Ah:2568h
	add	sp,8h

l0800_1309:
	mov	al,0h
	mov	es,[36C2h]
	mov	es:[172Ch],al
	mov	es,[36C4h]
	mov	es:[063Ch],al
	mov	es,[36C6h]
	mov	byte ptr es:[0FFE0h],0h
	mov	al,0h
	mov	es,[36C8h]
	mov	es:[0D2A6h],al
	mov	es,[36CAh]
	mov	es:[0A7F4h],al
	mov	es,[36CCh]
	mov	byte ptr es:[0FED8h],1h
	mov	al,0h
	mov	es,[36CEh]
	mov	es:[5B72h],al
	mov	es,[36D0h]
	mov	es:[5B94h],al
	mov	es,[363Ah]
	mov	byte ptr es:[0D068h],0h
	mov	es,[36D2h]
	mov	byte ptr es:[2B6Ch],0h
	mov	es,[36D4h]
	mov	byte ptr es:[4CBEh],0h
	mov	es,[36D6h]
	mov	byte ptr es:[0FDCEh],1h
	mov	es,[36D8h]
	mov	byte ptr es:[5B60h],1h
	mov	es,[36DAh]
	mov	word ptr es:[5CA2h],0h
	mov	es,[36DCh]
	mov	byte ptr es:[54D8h],0h
	mov	es,[36DEh]
	mov	byte ptr es:[2C70h],0h
	mov	es,[36E0h]
	mov	word ptr es:[0230h],0h
	mov	es,[36E2h]
	mov	word ptr es:[5B70h],0h
	mov	es,[36E4h]
	mov	byte ptr es:[2C6Ah],3h
	mov	es,[3636h]
	mov	ax,es:[0F22Ah]
	mov	dx,es:[0F22Ch]
	mov	es,[36E6h]
	mov	es:[54E6h],ax
	mov	es:[54E8h],dx
	mov	es,[36E8h]
	sub	ax,ax
	mov	es:[022Ah],ax
	mov	es:[0228h],ax
	mov	es,[3652h]
	sub	ax,ax
	mov	es:[2A04h],ax
	mov	es:[2A02h],ax
	mov	es,[363Ch]
	sub	ax,ax
	mov	es:[173Eh],ax
	mov	es:[173Ch],ax
	sub	ax,ax
	mov	[bp-30h],ax
	mov	[bp-32h],ax
	mov	es,[36EAh]
	mov	word ptr es:[2D70h],0h
	cmp	word ptr [bp+6h],2h
	jl	1424h

l0800_1421:
	jmp	1433h

l0800_1424:
	call	far 0800h:0129h
	push	0h
	call	far 149Ah:01DDh
	add	sp,2h

l0800_1433:
	cmp	word ptr [bp+6h],2h
	jz	143Ch

l0800_1439:
	jmp	149Ch

l0800_143C:
	les	bx,[bp+8h]
	les	bx,es:[bx+4h]
	mov	al,es:[bx]
	mov	[bp-2Ah],al
	cmp	byte ptr [bp-2Ah],68h
	jnz	1452h

l0800_144F:
	jmp	1464h

l0800_1452:
	cmp	byte ptr [bp-2Ah],48h
	jnz	145Bh

l0800_1458:
	jmp	1464h

l0800_145B:
	cmp	byte ptr [bp-2Ah],3Fh
	jz	1464h

l0800_1461:
	jmp	1467h

l0800_1464:
	jmp	152Ah

l0800_1467:
	cmp	byte ptr [bp-2Ah],2Fh
	jz	1470h

l0800_146D:
	jmp	149Ch

l0800_1470:
	les	bx,[bp+8h]
	les	bx,es:[bx+4h]
	mov	al,es:[bx+1h]
	mov	[bp-2Ah],al
	cmp	byte ptr [bp-2Ah],68h
	jnz	1487h

l0800_1484:
	jmp	1499h

l0800_1487:
	cmp	byte ptr [bp-2Ah],48h
	jnz	1490h

l0800_148D:
	jmp	1499h

l0800_1490:
	cmp	byte ptr [bp-2Ah],3Fh
	jz	1499h

l0800_1496:
	jmp	149Ch

l0800_1499:
	jmp	152Ah

l0800_149C:
	mov	word ptr [bp-1Ch],2h
	jmp	14A7h

l0800_14A4:
	inc	word ptr [bp-1Ch]

l0800_14A7:
	mov	ax,[bp-1Ch]
	cmp	[bp+6h],ax
	jg	14B2h

l0800_14AF:
	jmp	17DEh

l0800_14B2:
	mov	bx,[bp-1Ch]
	shl	bx,2h
	les	si,[bp+8h]
	les	bx,es:[bx+si]
	mov	al,es:[bx+1h]
	cbw
	jmp	173Ch

l0800_14C6:
	mov	es,[36E4h]
	mov	byte ptr es:[2C6Ah],2h
	jmp	17DBh

l0800_14D3:
	mov	es,[36D6h]
	mov	byte ptr es:[0FDCEh],0h
	jmp	17DBh

l0800_14E0:
	mov	es,[36CAh]
	mov	byte ptr es:[0A7F4h],1h
	push	180Ah
	push	2C3Ch
	mov	bx,[bp-1Ch]
	shl	bx,2h
	les	si,[bp+8h]
	mov	ax,es:[bx+si]
	mov	dx,es:[bx+si+2h]
	add	ax,2h
	push	dx
	push	ax
	call	far 0800h:04E8h
	add	sp,8h
	mov	es,[3652h]
	mov	es:[2A02h],ax
	mov	es:[2A04h],dx
	jmp	17DBh

l0800_151D:
	mov	es,[36CCh]
	mov	byte ptr es:[0FED8h],0h
	jmp	17DBh

l0800_152A:
	push	ds
	push	86Bh
	call	far 149Ah:3404h
	add	sp,4h
	push	0h
	call	far 149Ah:01DDh
	add	sp,2h
	jmp	17DBh

l0800_1543:
	mov	es,[36C6h]
	mov	byte ptr es:[0FFE0h],1h
	jmp	17DBh

l0800_1550:
	mov	es,[36ECh]
	mov	byte ptr es:[0FDCCh],1h
	jmp	17DBh

l0800_155D:
	mov	es,[36C8h]
	mov	byte ptr es:[0D2A6h],1h
	jmp	17DBh

l0800_156A:
	mov	es,[36C4h]
	mov	byte ptr es:[063Ch],1h
	jmp	17DBh

l0800_1577:
	mov	es,[36A4h]
	mov	word ptr es:[0F1FCh],1h
	jmp	17DBh

l0800_1585:
	mov	bx,[bp-1Ch]
	shl	bx,2h
	les	si,[bp+8h]
	les	bx,es:[bx+si]
	mov	al,es:[bx+2h]
	sub	al,30h
	mov	es,[36DCh]
	mov	es:[54D8h],al
	cmp	byte ptr es:[54D8h],5h
	jg	15AAh

l0800_15A7:
	jmp	15B0h

l0800_15AA:
	mov	byte ptr es:[54D8h],0h

l0800_15B0:
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],0h
	jl	15BFh

l0800_15BC:
	jmp	15C5h

l0800_15BF:
	mov	byte ptr es:[54D8h],0h

l0800_15C5:
	jmp	17DBh

l0800_15C8:
	push	180Ah
	push	0F202h
	mov	bx,[bp-1Ch]
	shl	bx,2h
	les	si,[bp+8h]
	mov	ax,es:[bx+si]
	mov	dx,es:[bx+si+2h]
	add	ax,2h
	push	dx
	push	ax
	call	far 0800h:04E8h
	add	sp,8h
	mov	es,[36E6h]
	mov	es:[54E6h],ax
	mov	es:[54E8h],dx
	jmp	17DBh

l0800_15FB:
	mov	es,[363Ah]
	mov	byte ptr es:[0D068h],1h
	push	381Dh
	push	54A4h
	mov	bx,[bp-1Ch]
	shl	bx,2h
	les	si,[bp+8h]
	mov	ax,es:[bx+si]
	mov	dx,es:[bx+si+2h]
	add	ax,2h
	push	dx
	push	ax
	call	far 0800h:04E8h
	add	sp,8h
	mov	es,[363Ch]
	mov	es:[173Ch],ax
	mov	es:[173Eh],dx
	jmp	17DBh

l0800_1638:
	mov	es,[36D0h]
	mov	byte ptr es:[5B94h],1h
	push	381Dh
	push	200h
	mov	bx,[bp-1Ch]
	shl	bx,2h
	les	si,[bp+8h]
	mov	ax,es:[bx+si]
	mov	dx,es:[bx+si+2h]
	add	ax,2h
	push	dx
	push	ax
	call	far 0800h:04E8h
	add	sp,8h
	mov	[bp-32h],ax
	mov	[bp-30h],dx
	jmp	17DBh

l0800_166E:
	mov	es,[36D4h]
	mov	byte ptr es:[4CBEh],1h
	push	180Ah
	push	1740h
	mov	bx,[bp-1Ch]
	shl	bx,2h
	les	si,[bp+8h]
	mov	ax,es:[bx+si]
	mov	dx,es:[bx+si+2h]
	add	ax,2h
	push	dx
	push	ax
	call	far 0800h:04E8h
	add	sp,8h
	mov	es,[36E8h]
	mov	es:[0228h],ax
	mov	es:[022Ah],dx
	jmp	17DBh

l0800_16AB:
	mov	es,[36CCh]
	mov	byte ptr es:[0FED8h],0h
	mov	es,[36CAh]
	mov	byte ptr es:[0A7F4h],0h
	mov	es,[36D4h]
	mov	byte ptr es:[4CBEh],0h
	mov	es,[36D2h]
	mov	byte ptr es:[2B6Ch],1h
	push	180Ah
	push	1740h
	mov	bx,[bp-1Ch]
	shl	bx,2h
	les	si,[bp+8h]
	mov	ax,es:[bx+si]
	mov	dx,es:[bx+si+2h]
	add	ax,2h
	push	dx
	push	ax
	call	far 0800h:04E8h
	add	sp,8h
	mov	es,[36E8h]
	mov	es:[0228h],ax
	mov	es:[022Ah],dx
	jmp	17DBh

l0800_1706:
	mov	es,[36DEh]
	mov	byte ptr es:[2C70h],1h
	jmp	17DBh

l0800_1713:
	mov	bx,[bp-1Ch]
	shl	bx,2h
	les	si,[bp+8h]
	push	word ptr es:[bx+si+2h]
	push	word ptr es:[bx+si]
	push	ds
	push	888h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	4h
	call	far 149Ah:01DDh
	add	sp,2h
	jmp	17DBh

l0800_173C:
	sub	ax,33h
	cmp	ax,45h
	jbe	1747h

l0800_1744:
	jmp	1713h

l0800_1747:
	shl	ax,1h
	xchg	bx,ax
	jmp	word ptr cs:[bx+174Fh]
l0800_174F	dw	0x14C6
l0800_1751	dw	0x1713
l0800_1753	dw	0x1713
l0800_1755	dw	0x1713
l0800_1757	dw	0x1713
l0800_1759	dw	0x1713
l0800_175B	dw	0x1713
l0800_175D	dw	0x1713
l0800_175F	dw	0x1713
l0800_1761	dw	0x1713
l0800_1763	dw	0x1713
l0800_1765	dw	0x1713
l0800_1767	dw	0x152A
l0800_1769	dw	0x1713
l0800_176B	dw	0x155D
l0800_176D	dw	0x14D3
l0800_176F	dw	0x1713
l0800_1771	dw	0x15C8
l0800_1773	dw	0x1577
l0800_1775	dw	0x166E
l0800_1777	dw	0x1713
l0800_1779	dw	0x152A
l0800_177B	dw	0x1706
l0800_177D	dw	0x1713
l0800_177F	dw	0x1713
l0800_1781	dw	0x1550
l0800_1783	dw	0x1713
l0800_1785	dw	0x1713
l0800_1787	dw	0x15FB
l0800_1789	dw	0x156A
l0800_178B	dw	0x1713
l0800_178D	dw	0x16AB
l0800_178F	dw	0x1543
l0800_1791	dw	0x14E0
l0800_1793	dw	0x1638
l0800_1795	dw	0x1585
l0800_1797	dw	0x1713
l0800_1799	dw	0x151D
l0800_179B	dw	0x1713
l0800_179D	dw	0x1713
l0800_179F	dw	0x1713
l0800_17A1	dw	0x1713
l0800_17A3	dw	0x1713
l0800_17A5	dw	0x1713
l0800_17A7	dw	0x1713
l0800_17A9	dw	0x1713
l0800_17AB	dw	0x155D
l0800_17AD	dw	0x14D3
l0800_17AF	dw	0x1713
l0800_17B1	dw	0x15C8
l0800_17B3	dw	0x1577
l0800_17B5	dw	0x166E
l0800_17B7	dw	0x1713
l0800_17B9	dw	0x152A
l0800_17BB	dw	0x1706
l0800_17BD	dw	0x1713
l0800_17BF	dw	0x1713
l0800_17C1	dw	0x1550
l0800_17C3	dw	0x1713
l0800_17C5	dw	0x1713
l0800_17C7	dw	0x15FB
l0800_17C9	dw	0x156A
l0800_17CB	dw	0x1713
l0800_17CD	dw	0x16AB
l0800_17CF	dw	0x1543
l0800_17D1	dw	0x14E0
l0800_17D3	dw	0x1638
l0800_17D5	dw	0x1585
l0800_17D7	dw	0x1713
l0800_17D9	dw	0x151D

l0800_17DB:
	jmp	14A4h

l0800_17DE:
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	180Ah
	push	63Eh
	call	far 149Ah:25AEh
	add	sp,8h
	push	ds
	push	8A0h
	push	180Ah
	push	63Eh
	call	far 149Ah:2568h
	add	sp,8h
	mov	es,[36C8h]
	cmp	byte ptr es:[0D2A6h],0h
	jz	181Bh

l0800_1818:
	jmp	1829h

l0800_181B:
	push	180Ah
	push	63Eh
	call	far 149Ah:365Eh
	add	sp,4h

l0800_1829:
	call	far 0800h:00A0h
	mov	es,[3624h]
	mov	es:[0FA02h],ax
	mov	es:[0FA04h],dx
	mov	ax,es:[0FA02h]
	mov	dx,es:[0FA04h]
	mov	es,[36EEh]
	mov	es:[022Ch],ax
	mov	es:[022Eh],dx
	call	far 1054h:3721h
	mov	es,[36CCh]
	cmp	byte ptr es:[0FED8h],0h
	jz	1865h

l0800_1862:
	jmp	1874h

l0800_1865:
	mov	es,[36D2h]
	cmp	byte ptr es:[2B6Ch],0h
	jnz	1874h

l0800_1871:
	jmp	188Ch

l0800_1874:
	push	1h
	push	ds
	push	8A7h
	call	far 149Ah:26A0h
	add	sp,4h
	push	dx
	push	ax
	call	far 1484h:000Eh
	add	sp,6h

l0800_188C:
	mov	es,[36D2h]
	cmp	byte ptr es:[2B6Ch],0h
	jnz	189Bh

l0800_1898:
	jmp	18B5h

l0800_189B:
	mov	es,[36E8h]
	mov	ax,es:[0228h]
	mov	dx,es:[022Ah]
	mov	es,[36E6h]
	mov	es:[54E6h],ax
	mov	es:[54E8h],dx

l0800_18B5:
	mov	es,[36E6h]
	push	word ptr es:[54E8h]
	push	word ptr es:[54E6h]
	push	180Ah
	push	67Eh
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[36D4h]
	cmp	byte ptr es:[4CBEh],0h
	jnz	18E0h

l0800_18DD:
	jmp	18FCh

l0800_18E0:
	mov	es,[36E8h]
	push	word ptr es:[022Ah]
	push	word ptr es:[0228h]
	lea	ax,[bp+0FF7Eh]
	push	ss
	push	ax
	call	far 149Ah:25AEh
	add	sp,8h

l0800_18FC:
	mov	es,[36F0h]
	mov	byte ptr es:[54D0h],0h
	push	3Ah
	les	bx,[bp+8h]
	push	word ptr es:[bx+6h]
	push	word ptr es:[bx+4h]
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-22h],ax
	mov	[bp-20h],dx
	or	dx,ax
	jz	1928h

l0800_1925:
	jmp	196Ch

l0800_1928:
	les	bx,[bp+8h]
	push	word ptr es:[bx+6h]
	push	word ptr es:[bx+4h]
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	mov	es,[36D4h]
	cmp	byte ptr es:[4CBEh],0h
	jnz	1950h

l0800_194D:
	jmp	1969h

l0800_1950:
	les	bx,[bp+8h]
	push	word ptr es:[bx+6h]
	push	word ptr es:[bx+4h]
	lea	ax,[bp+0FF7Eh]
	push	ss
	push	ax
	call	far 149Ah:2568h
	add	sp,8h

l0800_1969:
	jmp	1A1Eh

l0800_196C:
	mov	es,[36F0h]
	mov	byte ptr es:[54D0h],1h
	les	bx,[bp+8h]
	push	word ptr es:[bx+6h]
	push	word ptr es:[bx+4h]
	push	180Ah
	push	67Eh
	call	far 149Ah:25AEh
	add	sp,8h
	push	5Ch
	les	bx,[bp+8h]
	push	word ptr es:[bx+6h]
	push	word ptr es:[bx+4h]
	call	far 149Ah:29B0h
	add	sp,6h
	or	dx,ax
	jz	19ABh

l0800_19A8:
	jmp	19DFh

l0800_19AB:
	mov	es,[36F2h]
	mov	byte ptr es:[0680h],0h
	push	ds
	push	8B0h
	push	es
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	inc	word ptr [bp-22h]
	push	word ptr [bp-20h]
	push	word ptr [bp-22h]
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	jmp	19FBh

l0800_19DF:
	push	5Ch
	les	bx,[bp+8h]
	push	word ptr es:[bx+6h]
	push	word ptr es:[bx+4h]
	call	far 149Ah:29B0h
	add	sp,6h
	inc	ax
	mov	[bp-22h],ax
	mov	[bp-20h],dx

l0800_19FB:
	mov	es,[36D4h]
	cmp	byte ptr es:[4CBEh],0h
	jnz	1A0Ah

l0800_1A07:
	jmp	1A1Eh

l0800_1A0A:
	push	word ptr [bp-20h]
	push	word ptr [bp-22h]
	lea	ax,[bp+0FF7Eh]
	push	ss
	push	ax
	call	far 149Ah:2568h
	add	sp,8h

l0800_1A1E:
	mov	es,[36D2h]
	cmp	byte ptr es:[2B6Ch],0h
	jnz	1A2Dh

l0800_1A2A:
	jmp	1ADAh

l0800_1A2D:
	push	ds
	push	8B2h
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	push	ds
	push	8B7h
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[36F4h]
	mov	es:[0FFDCh],ax
	mov	es:[0FFDEh],dx
	mov	ax,es:[0FFDEh]
	or	ax,es:[0FFDCh]
	jz	1A6Ch

l0800_1A69:
	jmp	1AC0h

l0800_1A6C:
	push	180Ah
	push	67Eh
	push	ds
	push	8BAh
	call	far 149Ah:0ABCh
	add	sp,8h
	mov	es,[36F0h]
	cmp	byte ptr es:[54D0h],0h
	jnz	1A8Dh

l0800_1A8A:
	jmp	1A9Ch

l0800_1A8D:
	push	ds
	push	8E4h
	call	far 149Ah:0ABCh
	add	sp,4h
	jmp	1AB6h

l0800_1A9C:
	mov	es,[36E6h]
	push	word ptr es:[54E8h]
	push	word ptr es:[54E6h]
	push	ds
	push	91Bh
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_1AB6:
	push	3h
	call	far 0800h:02C7h
	add	sp,2h

l0800_1AC0:
	mov	es,[36F4h]
	les	bx,es:[0FFDCh]
	mov	al,es:[bx+0Bh]
	sub	ah,ah
	mov	es,[3680h]
	mov	es:[0D2A8h],ax
	jmp	1B6Dh

l0800_1ADA:
	push	ds
	push	94Ch
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	push	ds
	push	951h
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[36F6h]
	mov	es:[020Eh],ax
	mov	es:[0210h],dx
	mov	ax,es:[0210h]
	or	ax,es:[020Eh]
	jz	1B19h

l0800_1B16:
	jmp	1B6Dh

l0800_1B19:
	push	180Ah
	push	67Eh
	push	ds
	push	953h
	call	far 149Ah:0ABCh
	add	sp,8h
	mov	es,[36F0h]
	cmp	byte ptr es:[54D0h],0h
	jnz	1B3Ah

l0800_1B37:
	jmp	1B49h

l0800_1B3A:
	push	ds
	push	96Fh
	call	far 149Ah:0ABCh
	add	sp,4h
	jmp	1B63h

l0800_1B49:
	mov	es,[36E6h]
	push	word ptr es:[54E8h]
	push	word ptr es:[54E6h]
	push	ds
	push	9A7h
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_1B63:
	push	3h
	call	far 0800h:02C7h
	add	sp,2h

l0800_1B6D:
	push	180Ah
	push	67Eh
	push	ds
	push	9D9h
	call	far 149Ah:0ABCh
	add	sp,8h
	mov	es,[363Ah]
	cmp	byte ptr es:[0D068h],0h
	jnz	1B8Eh

l0800_1B8B:
	jmp	1BA8h

l0800_1B8E:
	mov	es,[363Ch]
	push	word ptr es:[173Eh]
	push	word ptr es:[173Ch]
	push	ds
	push	9F8h
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_1BA8:
	push	ds
	push	0A0Fh
	call	far 149Ah:0ABCh
	add	sp,4h
	mov	es,[36CAh]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	1BC3h

l0800_1BC0:
	jmp	1F67h

l0800_1BC3:
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	ds
	push	0A16h
	call	far 149Ah:0ABCh
	add	sp,8h
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	180Ah
	push	67Eh
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[366Eh]
	push	word ptr es:[0F200h]
	push	word ptr es:[0F1FEh]
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	mov	es,[36C8h]
	cmp	byte ptr es:[0D2A6h],0h
	jnz	1C24h

l0800_1C21:
	jmp	1C2Ah

l0800_1C24:
	mov	ax,0A4Bh
	jmp	1C2Dh

l0800_1C2A:
	mov	ax,0A4Dh

l0800_1C2D:
	push	ds
	push	ax
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[363Eh]
	mov	es:[2D7Ah],ax
	mov	es:[2D7Ch],dx
	mov	ax,es:[2D7Ch]
	or	ax,es:[2D7Ah]
	jz	1C58h

l0800_1C55:
	jmp	1C74h

l0800_1C58:
	push	180Ah
	push	67Eh
	push	ds
	push	0A4Fh
	call	far 149Ah:0ABCh
	add	sp,8h
	push	5h
	call	far 0800h:02C7h
	add	sp,2h

l0800_1C74:
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	180Ah
	push	67Eh
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[366Ch]
	push	word ptr es:[0FF1Ch]
	push	word ptr es:[0FF1Ah]
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	mov	es,[36C8h]
	cmp	byte ptr es:[0D2A6h],0h
	jnz	1CBBh

l0800_1CB8:
	jmp	1CC1h

l0800_1CBB:
	mov	ax,0A6Dh
	jmp	1CC4h

l0800_1CC1:
	mov	ax,0A6Fh

l0800_1CC4:
	push	ds
	push	ax
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[36F8h]
	mov	es:[0F1F8h],ax
	mov	es:[0F1FAh],dx
	mov	ax,es:[0F1FAh]
	or	ax,es:[0F1F8h]
	jz	1CEFh

l0800_1CEC:
	jmp	1D0Bh

l0800_1CEF:
	push	180Ah
	push	67Eh
	push	ds
	push	0A71h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	6h
	call	far 0800h:02C7h
	add	sp,2h

l0800_1D0B:
	mov	es,[36F8h]
	mov	ax,es:[0F1F8h]
	mov	dx,es:[0F1FAh]
	mov	es,[36FAh]
	mov	es:[0FDD0h],ax
	mov	es:[0FDD2h],dx
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	180Ah
	push	67Eh
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[3670h]
	push	word ptr es:[54DEh]
	push	word ptr es:[54DCh]
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	mov	es,[36C8h]
	cmp	byte ptr es:[0D2A6h],0h
	jnz	1D6Ch

l0800_1D69:
	jmp	1D72h

l0800_1D6C:
	mov	ax,0A8Fh
	jmp	1D75h

l0800_1D72:
	mov	ax,0A91h

l0800_1D75:
	push	ds
	push	ax
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[3644h]
	mov	es:[0A7DAh],ax
	mov	es:[0A7DCh],dx
	mov	ax,es:[0A7DCh]
	or	ax,es:[0A7DAh]
	jz	1DA0h

l0800_1D9D:
	jmp	1DBCh

l0800_1DA0:
	push	180Ah
	push	67Eh
	push	ds
	push	0A93h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	8h
	call	far 0800h:02C7h
	add	sp,2h

l0800_1DBC:
	mov	es,[36C8h]
	cmp	byte ptr es:[0D2A6h],0h
	jnz	1DCBh

l0800_1DC8:
	jmp	1E45h

l0800_1DCB:
	call	far 0800h:0784h
	call	far 0800h:084Ah
	mov	es,[3648h]
	sub	ax,ax
	mov	es:[5CA6h],ax
	mov	es:[5CA4h],ax
	mov	es,[3644h]
	push	word ptr es:[0A7DCh]
	push	word ptr es:[0A7DAh]
	call	far 149Ah:063Ch
	add	sp,4h
	push	ds
	push	0AAFh
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[3644h]
	mov	es:[0A7DAh],ax
	mov	es:[0A7DCh],dx
	mov	ax,es:[0A7DCh]
	or	ax,es:[0A7DAh]
	jz	1E26h

l0800_1E23:
	jmp	1E42h

l0800_1E26:
	push	180Ah
	push	67Eh
	push	ds
	push	0AB1h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	8h
	call	far 0800h:02C7h
	add	sp,2h

l0800_1E42:
	jmp	1F67h

l0800_1E45:
	mov	es,[366Eh]
	push	word ptr es:[0F200h]
	push	word ptr es:[0F1FEh]
	push	ds
	push	0ACFh
	mov	es,[363Eh]
	push	word ptr es:[2D7Ch]
	push	word ptr es:[2D7Ah]
	call	far 149Ah:0752h
	add	sp,0Ch
	push	ds
	push	0ADCh
	mov	es,[363Eh]
	push	word ptr es:[2D7Ch]
	push	word ptr es:[2D7Ah]
	call	far 149Ah:0752h
	add	sp,8h
	mov	es,[366Ch]
	push	word ptr es:[0FF1Ch]
	push	word ptr es:[0FF1Ah]
	push	ds
	push	0AEEh
	mov	es,[363Eh]
	push	word ptr es:[2D7Ch]
	push	word ptr es:[2D7Ah]
	call	far 149Ah:0752h
	add	sp,0Ch
	push	ds
	push	0AFDh
	mov	es,[363Eh]
	push	word ptr es:[2D7Ch]
	push	word ptr es:[2D7Ah]
	call	far 149Ah:0752h
	add	sp,8h
	mov	es,[3670h]
	push	word ptr es:[54DEh]
	push	word ptr es:[54DCh]
	push	ds
	push	0B0Ch
	mov	es,[3644h]
	push	word ptr es:[0A7DCh]
	push	word ptr es:[0A7DAh]
	call	far 149Ah:0752h
	add	sp,0Ch
	push	ds
	push	0B19h
	mov	es,[3644h]
	push	word ptr es:[0A7DCh]
	push	word ptr es:[0A7DAh]
	call	far 149Ah:0752h
	add	sp,8h
	mov	es,[366Ch]
	push	word ptr es:[0FF1Ch]
	push	word ptr es:[0FF1Ah]
	push	ds
	push	0B2Bh
	mov	es,[3644h]
	push	word ptr es:[0A7DCh]
	push	word ptr es:[0A7DAh]
	call	far 149Ah:0752h
	add	sp,0Ch
	push	ds
	push	0B3Ah
	mov	es,[3644h]
	push	word ptr es:[0A7DCh]
	push	word ptr es:[0A7DAh]
	call	far 149Ah:0752h
	add	sp,8h
	mov	es,[363Eh]
	mov	ax,es:[2D7Ah]
	mov	dx,es:[2D7Ch]
	mov	es,[3648h]
	mov	es:[5CA4h],ax
	mov	es:[5CA6h],dx

l0800_1F67:
	mov	es,[36CCh]
	cmp	byte ptr es:[0FED8h],0h
	jz	1F76h

l0800_1F73:
	jmp	1F85h

l0800_1F76:
	mov	es,[36D2h]
	cmp	byte ptr es:[2B6Ch],0h
	jnz	1F85h

l0800_1F82:
	jmp	1FA3h

l0800_1F85:
	call	far 147Dh:0000h
	mov	[bp-1Ah],ax
	push	0CBh
	call	far 147Dh:001Dh
	add	sp,2h
	push	ds
	push	0B49h
	call	far 149Ah:0ABCh
	add	sp,4h

l0800_1FA3:
	mov	es,[36D2h]
	cmp	byte ptr es:[2B6Ch],0h
	jnz	1FB2h

l0800_1FAF:
	jmp	1FBAh

l0800_1FB2:
	call	far 0800h:7DD1h
	jmp	3C0Eh

l0800_1FBA:
	mov	es,[36D4h]
	cmp	byte ptr es:[4CBEh],0h
	jnz	1FC9h

l0800_1FC6:
	jmp	20FBh

l0800_1FC9:
	push	ds
	push	0B64h
	lea	ax,[bp+0FF7Eh]
	push	ss
	push	ax
	call	far 149Ah:2568h
	add	sp,8h
	push	80h
	push	8302h
	lea	ax,[bp+0FF7Eh]
	push	ss
	push	ax
	call	far 149Ah:1E7Eh
	add	sp,8h
	mov	es,[3680h]
	mov	es:[0D2A8h],ax
	cmp	word ptr es:[0D2A8h],0h
	jle	2002h

l0800_1FFF:
	jmp	201Eh

l0800_2002:
	lea	ax,[bp+0FF7Eh]
	push	ss
	push	ax
	push	ds
	push	0B69h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	0FAh
	call	far 0800h:02C7h
	add	sp,2h

l0800_201E:
	mov	es,[36DAh]
	cmp	word ptr es:[5CA2h],0h
	jnz	202Dh

l0800_202A:
	jmp	2048h

l0800_202D:
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	lea	ax,[bp+0FF7Eh]
	push	ss
	push	ax
	push	ds
	push	0B91h
	call	far 149Ah:0ABCh
	add	sp,0Ah

l0800_2048:
	push	ds
	push	0BACh
	push	180Ah
	push	0FA0Ah
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[36FCh]
	mov	word ptr es:[0FA2Ch],64h
	mov	word ptr es:[0FA2Ah],0h
	mov	word ptr [bp-1Ch],0h
	jmp	2077h

l0800_2074:
	inc	word ptr [bp-1Ch]

l0800_2077:
	mov	es,[36FCh]
	mov	bx,[bp-1Ch]
	cmp	byte ptr es:[bx+0FA0Ah],0h
	jnz	2089h

l0800_2086:
	jmp	209Ah

l0800_2089:
	mov	bx,[bp-1Ch]
	mov	al,es:[bx+0FA0Ah]
	cbw
	add	es:[0FA2Ah],ax
	jmp	2074h

l0800_209A:
	push	2Ch
	push	180Ah
	push	0FA0Ah
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	call	far 149Ah:212Eh
	add	sp,8h
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	call	far 149Ah:28C2h
	add	sp,2h
	mov	es,[36FEh]
	mov	es:[5C9Ah],ax
	mov	es:[5C9Ch],dx
	mov	es,[3700h]
	sub	ax,ax
	mov	es:[2A14h],ax
	mov	es:[2A12h],ax
	sub	ax,ax
	mov	es:[2A10h],ax
	mov	es:[2A0Eh],ax
	lea	ax,[bp+0FF7Eh]
	push	ss
	push	ax
	push	ds
	push	0BB4h
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_20FB:
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],0h
	jnz	210Ah

l0800_2107:
	jmp	2140h

l0800_210A:
	mov	es,[36C4h]
	cmp	byte ptr es:[063Ch],0h
	jnz	2119h

l0800_2116:
	jmp	2125h

l0800_2119:
	push	ds
	push	0BBFh
	call	far 149Ah:0ABCh
	add	sp,4h

l0800_2125:
	mov	es,[36ECh]
	cmp	byte ptr es:[0FDCCh],0h
	jnz	2134h

l0800_2131:
	jmp	2140h

l0800_2134:
	push	ds
	push	0BE7h
	call	far 149Ah:0ABCh
	add	sp,4h

l0800_2140:
	mov	es,[3682h]
	push	word ptr es:[0D2A0h]
	push	word ptr es:[0D29Eh]
	call	far 0800h:77A8h
	add	sp,4h

l0800_2156:
	mov	es,[36F6h]
	push	word ptr es:[0210h]
	push	word ptr es:[020Eh]
	push	0FFh
	push	381Dh
	push	5B9Ah
	call	far 149Ah:272Eh
	add	sp,0Ah
	or	dx,ax
	jnz	217Ch

l0800_2179:
	jmp	380Eh

l0800_217C:
	mov	es,[3640h]
	cmp	byte ptr es:[5B9Ah],0Ah
	jz	218Bh

l0800_2188:
	jmp	218Eh

l0800_218B:
	jmp	2156h

l0800_218E:
	mov	es,[3640h]
	cmp	byte ptr es:[5B9Ah],3Bh
	jz	219Dh

l0800_219A:
	jmp	21A0h

l0800_219D:
	jmp	2156h

l0800_21A0:
	mov	es,[3640h]
	cmp	byte ptr es:[5B9Ah],2Fh
	jz	21AFh

l0800_21AC:
	jmp	21B2h

l0800_21AF:
	jmp	2156h

l0800_21B2:
	push	0Ah
	push	381Dh
	push	5B9Ah
	call	far 149Ah:293Ch
	add	sp,6h
	mov	es,dx
	mov	bx,ax
	mov	byte ptr es:[bx],0h
	push	4h
	push	ds
	push	0C0Dh
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	21E6h

l0800_21E3:
	jmp	2283h

l0800_21E6:
	mov	es,[36CAh]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	21F5h

l0800_21F2:
	jmp	221Dh

l0800_21F5:
	mov	es,[3648h]
	mov	ax,es:[5CA6h]
	or	ax,es:[5CA4h]
	jz	2207h

l0800_2204:
	jmp	221Dh

l0800_2207:
	push	ds
	push	0C12h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	7h
	call	far 0800h:02C7h
	add	sp,2h

l0800_221D:
	cmp	word ptr [06CCh],0h
	jz	2227h

l0800_2224:
	jmp	2280h

l0800_2227:
	mov	es,[3702h]
	mov	word ptr es:[0A7D6h],5B9Fh
	mov	word ptr es:[0A7D8h],381Dh

l0800_2239:
	mov	es,[3702h]
	les	bx,es:[0A7D6h]
	cmp	byte ptr es:[bx],0h
	jnz	224Bh

l0800_2248:
	jmp	2280h

l0800_224B:
	call	far 0800h:514Dh
	mov	[bp-1Eh],ax
	cmp	ax,0h
	jl	225Bh

l0800_2258:
	jmp	225Eh

l0800_225B:
	jmp	2239h

l0800_225E:
	push	word ptr [bp-1Eh]
	mov	es,[362Ch]
	mov	bx,[bp-1Eh]
	shl	bx,2h
	push	word ptr es:[bx+0F230h]
	push	word ptr es:[bx+0F22Eh]
	call	far 0800h:550Ah
	add	sp,6h
	jmp	2239h

l0800_2280:
	jmp	380Bh

l0800_2283:
	push	4h
	push	ds
	push	0C55h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	229Fh

l0800_229C:
	jmp	23ABh

l0800_229F:
	mov	es,[3702h]
	mov	word ptr es:[0A7D6h],5B9Fh
	mov	word ptr es:[0A7D8h],381Dh
	sub	ax,ax
	mov	[bp-0Ah],ax
	mov	[bp-0Ch],ax
	mov	es,[36A6h]
	mov	ax,es:[54E2h]
	mov	[bp-28h],ax
	mov	es,[3704h]
	sub	ax,ax
	mov	es:[0D06Ch],ax
	mov	es:[0D06Ah],ax
	mov	es,[36A6h]
	mov	word ptr es:[54E2h],0h
	push	es
	push	54E2h
	push	180Ah
	push	0D06Ah
	lea	ax,[bp-0Ch]
	push	ss
	push	ax
	push	ds
	push	0C5Ah
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:2876h
	add	sp,14h
	mov	es,[3704h]
	cmp	word ptr es:[0D06Ch],0h
	jle	2315h

l0800_2312:
	jmp	233Fh

l0800_2315:
	jge	231Ah

l0800_2317:
	jmp	2325h

l0800_231A:
	cmp	word ptr es:[0D06Ah],4h
	jc	2325h

l0800_2322:
	jmp	233Fh

l0800_2325:
	mov	ax,es:[0D06Ah]
	mov	es,[36A6h]
	mov	es:[54E2h],ax
	mov	es,[3704h]
	sub	ax,ax
	mov	es:[0D06Ch],ax
	mov	es:[0D06Ah],ax

l0800_233F:
	mov	es,[36A4h]
	cmp	word ptr es:[0F1FCh],0h
	jnz	234Eh

l0800_234B:
	jmp	235Fh

l0800_234E:
	mov	es,[36A6h]
	push	word ptr es:[54E2h]
	call	far 0800h:0D60h
	add	sp,2h

l0800_235F:
	mov	ax,[bp-0Ch]
	mov	dx,[bp-0Ah]
	mov	es,[3682h]
	cmp	es:[0D29Eh],ax
	jz	2373h

l0800_2370:
	jmp	238Eh

l0800_2373:
	cmp	es:[0D2A0h],dx
	jz	237Dh

l0800_237A:
	jmp	238Eh

l0800_237D:
	mov	es,[36A6h]
	mov	ax,[bp-28h]
	cmp	es:[54E2h],ax
	jnz	238Eh

l0800_238B:
	jmp	23A8h

l0800_238E:
	push	0h
	push	0h
	call	far 0800h:8095h
	add	sp,4h
	push	word ptr [bp-0Ah]
	push	word ptr [bp-0Ch]
	call	far 0800h:77A8h
	add	sp,4h

l0800_23A8:
	jmp	380Bh

l0800_23AB:
	push	4h
	push	ds
	push	0C65h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	23C7h

l0800_23C4:
	jmp	2430h

l0800_23C7:
	mov	es,[3702h]
	mov	word ptr es:[0A7D6h],5B9Fh
	mov	word ptr es:[0A7D8h],381Dh
	push	180Ah
	push	2B6Eh
	push	ds
	push	0C6Ah
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:2876h
	add	sp,0Ch
	cmp	ax,0h
	jz	23FDh

l0800_23FA:
	jmp	2408h

l0800_23FD:
	mov	es,[36AEh]
	mov	word ptr es:[2B6Eh],0h

l0800_2408:
	mov	es,[36AEh]
	cmp	word ptr es:[2B6Eh],8h
	jle	2417h

l0800_2414:
	jmp	2422h

l0800_2417:
	cmp	word ptr es:[2B6Eh],0h
	jl	2422h

l0800_241F:
	jmp	242Dh

l0800_2422:
	mov	es,[36AEh]
	mov	word ptr es:[2B6Eh],0h

l0800_242D:
	jmp	380Bh

l0800_2430:
	push	4h
	push	ds
	push	0C6Dh
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	244Ch

l0800_2449:
	jmp	24E6h

l0800_244C:
	mov	word ptr [bp-22h],5B9Fh
	mov	word ptr [bp-20h],381Dh
	mov	es,[36CAh]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	2465h

l0800_2462:
	jmp	24E3h

l0800_2465:
	mov	word ptr [bp+0FF24h],0h

l0800_246B:
	mov	ax,[bp-22h]
	mov	dx,[bp-20h]
	mov	es,[3702h]
	mov	es:[0A7D6h],ax
	mov	es:[0A7D8h],dx
	or	dx,ax
	jnz	2485h

l0800_2482:
	jmp	24D1h

l0800_2485:
	push	2Ch
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-22h],ax
	mov	[bp-20h],dx
	or	dx,ax
	jnz	24A6h

l0800_24A3:
	jmp	24B0h

l0800_24A6:
	les	bx,[bp-22h]
	inc	word ptr [bp-22h]
	mov	byte ptr es:[bx],0h

l0800_24B0:
	push	word ptr [bp+0FF24h]
	inc	word ptr [bp+0FF24h]
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 0800h:41BBh
	add	sp,6h
	jmp	246Bh

l0800_24D1:
	mov	es,[3706h]
	mov	bx,[bp+0FF24h]
	shl	bx,2h
	mov	word ptr es:[bx+2BEAh],0h

l0800_24E3:
	jmp	380Bh

l0800_24E6:
	push	4h
	push	ds
	push	0C72h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	2502h

l0800_24FF:
	jmp	27B1h

l0800_2502:
	mov	word ptr [bp-22h],5B9Fh
	mov	word ptr [bp-20h],381Dh

l0800_250C:
	mov	ax,[bp-22h]
	mov	dx,[bp-20h]
	mov	es,[3702h]
	mov	es:[0A7D6h],ax
	mov	es:[0A7D8h],dx
	or	dx,ax
	jnz	2526h

l0800_2523:
	jmp	27AEh

l0800_2526:
	push	2Ch
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-22h],ax
	mov	[bp-20h],dx
	or	dx,ax
	jnz	2547h

l0800_2544:
	jmp	2551h

l0800_2547:
	les	bx,[bp-22h]
	inc	word ptr [bp-22h]
	mov	byte ptr es:[bx],0h

l0800_2551:
	lea	ax,[bp+0FF26h]
	push	ss
	push	ax
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 0800h:05CCh
	add	sp,8h
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],0h
	jnz	257Ch

l0800_2579:
	jmp	258Eh

l0800_257C:
	lea	ax,[bp+0FF26h]
	push	ss
	push	ax
	push	ds
	push	0C77h
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_258E:
	mov	es,[36CAh]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	259Dh

l0800_259A:
	jmp	279Dh

l0800_259D:
	mov	es,[3678h]
	cmp	word ptr es:[54CCh],0h
	jz	25ACh

l0800_25A9:
	jmp	279Dh

l0800_25AC:
	mov	word ptr es:[54CCh],1h
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	180Ah
	push	67Eh
	call	far 149Ah:25AEh
	add	sp,8h
	push	ds
	push	0C8Fh
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	mov	es,[36C8h]
	cmp	byte ptr es:[0D2A6h],0h
	jnz	25F0h

l0800_25ED:
	jmp	25F6h

l0800_25F0:
	mov	ax,0C99h
	jmp	25F9h

l0800_25F6:
	mov	ax,0C9Bh

l0800_25F9:
	push	ds
	push	ax
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[3708h]
	mov	es:[0FDD4h],ax
	mov	es:[0FDD6h],dx
	mov	ax,es:[0FDD6h]
	or	ax,es:[0FDD4h]
	jz	2624h

l0800_2621:
	jmp	2640h

l0800_2624:
	push	180Ah
	push	67Eh
	push	ds
	push	0C9Dh
	call	far 149Ah:0ABCh
	add	sp,8h
	push	7h
	call	far 0800h:02C7h
	add	sp,2h

l0800_2640:
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	180Ah
	push	67Eh
	call	far 149Ah:25AEh
	add	sp,8h
	push	ds
	push	0CBBh
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	mov	es,[36C8h]
	cmp	byte ptr es:[0D2A6h],0h
	jnz	267Dh

l0800_267A:
	jmp	2683h

l0800_267D:
	mov	ax,0CC7h
	jmp	2686h

l0800_2683:
	mov	ax,0CC9h

l0800_2686:
	push	ds
	push	ax
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[370Ah]
	mov	es:[0C766h],ax
	mov	es:[0C768h],dx
	mov	ax,es:[0C768h]
	or	ax,es:[0C766h]
	jz	26B1h

l0800_26AE:
	jmp	26CDh

l0800_26B1:
	push	180Ah
	push	67Eh
	push	ds
	push	0CCBh
	call	far 149Ah:0ABCh
	add	sp,8h
	push	7h
	call	far 0800h:02C7h
	add	sp,2h

l0800_26CD:
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	180Ah
	push	67Eh
	call	far 149Ah:25AEh
	add	sp,8h
	push	ds
	push	0CE9h
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	mov	es,[36C8h]
	cmp	byte ptr es:[0D2A6h],0h
	jnz	270Ah

l0800_2707:
	jmp	2710h

l0800_270A:
	mov	ax,0CF5h
	jmp	2713h

l0800_2710:
	mov	ax,0CF7h

l0800_2713:
	push	ds
	push	ax
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[370Ch]
	mov	es:[2B68h],ax
	mov	es:[2B6Ah],dx
	mov	ax,es:[2B6Ah]
	or	ax,es:[2B68h]
	jz	273Eh

l0800_273B:
	jmp	275Ah

l0800_273E:
	push	180Ah
	push	67Eh
	push	ds
	push	0CF9h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	9h
	call	far 0800h:02C7h
	add	sp,2h

l0800_275A:
	mov	es,[36C8h]
	cmp	byte ptr es:[0D2A6h],0h
	jz	2769h

l0800_2766:
	jmp	279Dh

l0800_2769:
	push	ds
	push	0D17h
	mov	es,[370Ah]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,8h
	push	ds
	push	0D29h
	mov	es,[370Ch]
	push	word ptr es:[2B6Ah]
	push	word ptr es:[2B68h]
	call	far 149Ah:0752h
	add	sp,8h

l0800_279D:
	lea	ax,[bp+0FF26h]
	push	ss
	push	ax
	call	far 1054h:1A49h
	add	sp,4h
	jmp	250Ch

l0800_27AE:
	jmp	380Bh

l0800_27B1:
	push	4h
	push	ds
	push	0D3Bh
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	27CDh

l0800_27CA:
	jmp	2822h

l0800_27CD:
	mov	es,[3702h]
	mov	word ptr es:[0A7D6h],5B9Fh
	mov	word ptr es:[0A7D8h],381Dh
	push	180Ah
	push	0FDCAh
	push	ds
	push	0D40h
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:2876h
	add	sp,0Ch
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],0h
	jnz	280Ah

l0800_2807:
	jmp	281Fh

l0800_280A:
	mov	es,[367Ah]
	push	word ptr es:[0FDCAh]
	push	ds
	push	0D43h
	call	far 149Ah:0ABCh
	add	sp,6h

l0800_281F:
	jmp	380Bh

l0800_2822:
	push	4h
	push	ds
	push	0D63h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	283Eh

l0800_283B:
	jmp	286Bh

l0800_283E:
	mov	es,[3702h]
	mov	word ptr es:[0A7D6h],5B9Fh
	mov	word ptr es:[0A7D8h],381Dh
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	push	180Ah
	push	0A7E4h
	call	far 149Ah:25AEh
	add	sp,8h
	jmp	380Bh

l0800_286B:
	push	4h
	push	ds
	push	0D68h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	2887h

l0800_2884:
	jmp	2EB1h

l0800_2887:
	mov	ax,[bp-32h]
	mov	dx,[bp-30h]
	mov	[bp-14h],ax
	mov	[bp-12h],dx
	mov	word ptr [bp-22h],5B9Fh
	mov	word ptr [bp-20h],381Dh
	mov	es,[364Ah]
	mov	ax,es:[0D2B2h]
	mov	dx,es:[0D2B4h]
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	mov	es,[36CEh]
	mov	byte ptr es:[5B72h],1h
	mov	es,[36CAh]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	28C9h

l0800_28C6:
	jmp	2CE3h

l0800_28C9:
	mov	es,[36FAh]
	mov	ax,es:[0FDD0h]
	mov	dx,es:[0FDD2h]
	mov	[bp+0FF7Ah],ax
	mov	[bp+0FF7Ch],dx
	call	far 0800h:0A47h
	mov	es,[367Ah]
	push	word ptr es:[0FDCAh]
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	ds
	push	0D6Dh
	push	180Ah
	push	67Eh
	call	far 149Ah:280Ah
	add	sp,0Eh
	push	ds
	push	0D7Bh
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[370Eh]
	mov	es:[5B64h],ax
	mov	es:[5B66h],dx
	mov	ax,es:[5B66h]
	or	ax,es:[5B64h]
	jz	2939h

l0800_2936:
	jmp	2955h

l0800_2939:
	push	180Ah
	push	67Eh
	push	ds
	push	0D7Dh
	call	far 149Ah:0ABCh
	add	sp,8h
	push	7h
	call	far 0800h:02C7h
	add	sp,2h

l0800_2955:
	push	ds
	push	0D9Bh
	mov	es,[370Eh]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,8h
	push	ds
	push	0DADh
	mov	es,[370Eh]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,8h
	push	ds
	push	0DC4h
	mov	es,[370Eh]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,8h
	mov	es,[367Ah]
	push	word ptr es:[0FDCAh]
	push	ds
	push	0DDCh
	mov	es,[370Eh]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,0Ah
	mov	es,[367Ah]
	push	word ptr es:[0FDCAh]
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	ds
	push	0DF4h
	push	180Ah
	push	67Eh
	call	far 149Ah:280Ah
	add	sp,0Eh
	push	0Ah
	call	far 149Ah:22A2h
	add	sp,2h
	mov	es,[364Ah]
	mov	es:[0D2B2h],ax
	mov	es:[0D2B4h],dx
	mov	ax,es:[0D2B4h]
	or	ax,es:[0D2B2h]
	jz	2A14h

l0800_2A11:
	jmp	2A33h

l0800_2A14:
	mov	es,[367Ah]
	push	word ptr es:[0FDCAh]
	push	ds
	push	0E02h
	call	far 149Ah:0ABCh
	add	sp,6h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_2A33:
	mov	es,[367Ah]
	push	word ptr es:[0FDCAh]
	push	ds
	push	0E32h
	mov	es,[364Ah]
	push	word ptr es:[0D2B4h]
	push	word ptr es:[0D2B2h]
	call	far 149Ah:280Ah
	add	sp,0Ah
	mov	es,[364Ch]
	mov	ax,es:[0A7F6h]
	mov	es,[3650h]
	mov	es:[54E0h],ax
	push	180Ah
	push	67Eh
	call	far 0800h:06D9h
	add	sp,4h
	push	ds
	push	0E3Eh
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[3648h]
	mov	es:[5CA4h],ax
	mov	es:[5CA6h],dx
	mov	ax,es:[5CA6h]
	or	ax,es:[5CA4h]
	jz	2AA1h

l0800_2A9E:
	jmp	2ABDh

l0800_2AA1:
	push	180Ah
	push	67Eh
	push	ds
	push	0E40h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	7h
	call	far 0800h:02C7h
	add	sp,2h

l0800_2ABD:
	mov	es,[3676h]
	cmp	word ptr es:[54E4h],0h
	jnz	2ACCh

l0800_2AC9:
	jmp	2CC9h

l0800_2ACC:
	mov	word ptr es:[54E4h],0h
	push	ds
	push	0E5Eh
	mov	es,[3644h]
	push	word ptr es:[0A7DCh]
	push	word ptr es:[0A7DAh]
	call	far 149Ah:0752h
	add	sp,8h
	mov	es,[36C6h]
	cmp	byte ptr es:[0FFE0h],0h
	jnz	2AFCh

l0800_2AF9:
	jmp	2B89h

l0800_2AFC:
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	180Ah
	push	67Eh
	call	far 149Ah:25AEh
	add	sp,8h
	push	ds
	push	0E76h
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	mov	es,[36C8h]
	cmp	byte ptr es:[0D2A6h],0h
	jnz	2B39h

l0800_2B36:
	jmp	2B3Fh

l0800_2B39:
	mov	ax,0E82h
	jmp	2B42h

l0800_2B3F:
	mov	ax,0E84h

l0800_2B42:
	push	ds
	push	ax
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[3710h]
	mov	es:[0204h],ax
	mov	es:[0206h],dx
	mov	ax,es:[0206h]
	or	ax,es:[0204h]
	jz	2B6Dh

l0800_2B6A:
	jmp	2B89h

l0800_2B6D:
	push	180Ah
	push	67Eh
	push	ds
	push	0E86h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	7h
	call	far 0800h:02C7h
	add	sp,2h

l0800_2B89:
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	180Ah
	push	67Eh
	call	far 149Ah:25AEh
	add	sp,8h
	push	ds
	push	0EA4h
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	mov	es,[36C8h]
	cmp	byte ptr es:[0D2A6h],0h
	jnz	2BC6h

l0800_2BC3:
	jmp	2BCCh

l0800_2BC6:
	mov	ax,0EB0h
	jmp	2BCFh

l0800_2BCC:
	mov	ax,0EB2h

l0800_2BCF:
	push	ds
	push	ax
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[3712h]
	mov	es:[0214h],ax
	mov	es:[0216h],dx
	mov	ax,es:[0216h]
	or	ax,es:[0214h]
	jz	2BFAh

l0800_2BF7:
	jmp	2C16h

l0800_2BFA:
	push	180Ah
	push	67Eh
	push	ds
	push	0EB4h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	7h
	call	far 0800h:02C7h
	add	sp,2h

l0800_2C16:
	mov	es,[36C8h]
	cmp	byte ptr es:[0D2A6h],0h
	jz	2C25h

l0800_2C22:
	jmp	2CC9h

l0800_2C25:
	push	ds
	push	0ED2h
	mov	es,[3712h]
	push	word ptr es:[0216h]
	push	word ptr es:[0214h]
	call	far 149Ah:0752h
	add	sp,8h
	mov	es,[3660h]
	cmp	byte ptr es:[0A7E4h],0h
	jnz	2C4Eh

l0800_2C4B:
	jmp	2C6Ch

l0800_2C4E:
	push	es
	push	0A7E4h
	push	ds
	push	0EE4h
	mov	es,[3712h]
	push	word ptr es:[0216h]
	push	word ptr es:[0214h]
	call	far 149Ah:0752h
	add	sp,0Ch

l0800_2C6C:
	mov	es,[36C6h]
	cmp	byte ptr es:[0FFE0h],0h
	jnz	2C7Bh

l0800_2C78:
	jmp	2CC9h

l0800_2C7B:
	push	ds
	push	0EF3h
	mov	es,[3710h]
	push	word ptr es:[0206h]
	push	word ptr es:[0204h]
	call	far 149Ah:0752h
	add	sp,8h
	push	ds
	push	0F0Bh
	mov	es,[3710h]
	push	word ptr es:[0206h]
	push	word ptr es:[0204h]
	call	far 149Ah:0752h
	add	sp,8h
	push	ds
	push	0F23h
	mov	es,[3710h]
	push	word ptr es:[0206h]
	push	word ptr es:[0204h]
	call	far 149Ah:0752h
	add	sp,8h

l0800_2CC9:
	mov	es,[3712h]
	mov	ax,es:[0214h]
	mov	dx,es:[0216h]
	mov	es,[36FAh]
	mov	es:[0FDD0h],ax
	mov	es:[0FDD2h],dx

l0800_2CE3:
	mov	ax,[bp-22h]
	mov	dx,[bp-20h]
	mov	es,[3702h]
	mov	es:[0A7D6h],ax
	mov	es:[0A7D8h],dx
	or	dx,ax
	jnz	2CFDh

l0800_2CFA:
	jmp	2E00h

l0800_2CFD:
	push	2Ch
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-22h],ax
	mov	[bp-20h],dx
	or	dx,ax
	jnz	2D1Eh

l0800_2D1B:
	jmp	2D28h

l0800_2D1E:
	les	bx,[bp-22h]
	inc	word ptr [bp-22h]
	mov	byte ptr es:[bx],0h

l0800_2D28:
	mov	es,[36D0h]
	cmp	byte ptr es:[5B94h],0h
	jz	2D37h

l0800_2D34:
	jmp	2DACh

l0800_2D37:
	push	3Bh
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp+0FF20h],ax
	mov	[bp+0FF22h],dx
	or	dx,ax
	jnz	2D5Eh

l0800_2D5B:
	jmp	2DACh

l0800_2D5E:
	les	bx,[bp+0FF20h]
	inc	word ptr [bp+0FF20h]
	mov	byte ptr es:[bx],0h
	push	word ptr [bp+0FF22h]
	push	word ptr [bp+0FF20h]
	call	far 149Ah:260Eh
	add	sp,4h
	mov	si,ax
	les	bx,[bp+0FF20h]
	cmp	byte ptr es:[bx+si-1h],5Ch
	jnz	2D8Ah

l0800_2D87:
	jmp	2D9Eh

l0800_2D8A:
	push	ds
	push	0F68h
	push	word ptr [bp+0FF22h]
	push	word ptr [bp+0FF20h]
	call	far 149Ah:2568h
	add	sp,8h

l0800_2D9E:
	mov	ax,[bp+0FF20h]
	mov	dx,[bp+0FF22h]
	mov	[bp-32h],ax
	mov	[bp-30h],dx

l0800_2DAC:
	lea	ax,[bp+0FF26h]
	push	ss
	push	ax
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 0800h:05CCh
	add	sp,8h
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],0h
	jnz	2DD7h

l0800_2DD4:
	jmp	2DE9h

l0800_2DD7:
	lea	ax,[bp+0FF26h]
	push	ss
	push	ax
	push	ds
	push	0F6Ah
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_2DE9:
	push	word ptr [bp-30h]
	push	word ptr [bp-32h]
	lea	ax,[bp+0FF26h]
	push	ss
	push	ax
	call	far 1054h:0DB3h
	add	sp,8h
	jmp	2CE3h

l0800_2E00:
	mov	es,[36CEh]
	mov	byte ptr es:[5B72h],0h
	mov	es,[36CAh]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	2E19h

l0800_2E16:
	jmp	2E94h

l0800_2E19:
	mov	es,[3712h]
	push	word ptr es:[0216h]
	push	word ptr es:[0214h]
	call	far 149Ah:0ECEh
	add	sp,4h
	mov	es,[370Eh]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:063Ch
	add	sp,4h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:063Ch
	add	sp,4h
	mov	es,[364Ah]
	push	word ptr es:[0D2B4h]
	push	word ptr es:[0D2B2h]
	call	far 149Ah:22A8h
	add	sp,4h
	push	word ptr [bp-2h]
	push	word ptr [bp-4h]
	call	far 0800h:0AC7h
	add	sp,4h
	mov	ax,[bp+0FF7Ah]
	mov	dx,[bp+0FF7Ch]
	mov	es,[36FAh]
	mov	es:[0FDD0h],ax
	mov	es:[0FDD2h],dx

l0800_2E94:
	mov	ax,[bp-14h]
	mov	dx,[bp-12h]
	mov	[bp-32h],ax
	mov	[bp-30h],dx
	mov	es,[367Ah]
	inc	word ptr es:[0FDCAh]
	call	far 1054h:3F70h
	jmp	380Bh

l0800_2EB1:
	push	4h
	push	ds
	push	0F80h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	2ECDh

l0800_2ECA:
	jmp	2F7Bh

l0800_2ECD:
	mov	word ptr [bp-22h],5B9Fh
	mov	word ptr [bp-20h],381Dh

l0800_2ED7:
	mov	ax,[bp-22h]
	mov	dx,[bp-20h]
	mov	es,[3702h]
	mov	es:[0A7D6h],ax
	mov	es:[0A7D8h],dx
	or	dx,ax
	jnz	2EF1h

l0800_2EEE:
	jmp	2F78h

l0800_2EF1:
	push	2Ch
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-22h],ax
	mov	[bp-20h],dx
	or	dx,ax
	jnz	2F12h

l0800_2F0F:
	jmp	2F1Ch

l0800_2F12:
	les	bx,[bp-22h]
	inc	word ptr [bp-22h]
	mov	byte ptr es:[bx],0h

l0800_2F1C:
	lea	ax,[bp+0FF26h]
	push	ss
	push	ax
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 0800h:05CCh
	add	sp,8h
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],0h
	jnz	2F47h

l0800_2F44:
	jmp	2F67h

l0800_2F47:
	mov	es,[3682h]
	push	word ptr es:[0D2A0h]
	push	word ptr es:[0D29Eh]
	lea	ax,[bp+0FF26h]
	push	ss
	push	ax
	push	ds
	push	0F85h
	call	far 149Ah:0ABCh
	add	sp,0Ch

l0800_2F67:
	lea	ax,[bp+0FF26h]
	push	ss
	push	ax
	call	far 1054h:0104h
	add	sp,4h
	jmp	2ED7h

l0800_2F78:
	jmp	380Bh

l0800_2F7B:
	push	4h
	push	ds
	push	0FA2h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	2F97h

l0800_2F94:
	jmp	3305h

l0800_2F97:
	mov	es,[36CAh]
	cmp	byte ptr es:[0A7F4h],0h
	jz	2FA6h

l0800_2FA3:
	jmp	2FA9h

l0800_2FA6:
	jmp	3302h

l0800_2FA9:
	mov	es,[36FAh]
	mov	ax,es:[0FDD0h]
	mov	dx,es:[0FDD2h]
	mov	es,[36F8h]
	cmp	es:[0F1F8h],ax
	jz	2FC4h

l0800_2FC1:
	jmp	2FCEh

l0800_2FC4:
	cmp	es:[0F1FAh],dx
	jnz	2FCEh

l0800_2FCB:
	jmp	300Eh

l0800_2FCE:
	mov	es,[36FAh]
	push	word ptr es:[0FDD2h]
	push	word ptr es:[0FDD0h]
	call	far 149Ah:063Ch
	add	sp,4h
	inc	ax
	jz	2FEAh

l0800_2FE7:
	jmp	300Eh

l0800_2FEA:
	mov	es,[3672h]
	push	word ptr es:[5B90h]
	push	word ptr es:[5B8Eh]
	push	ds
	push	0FA7h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_300E:
	mov	es,[3702h]
	mov	word ptr es:[0A7D6h],5B9Fh
	mov	word ptr es:[0A7D8h],381Dh
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	mov	es,[366Ch]
	push	word ptr es:[0FF1Ch]
	push	word ptr es:[0FF1Ah]
	call	far 149Ah:296Ah
	add	sp,8h
	cmp	ax,0h
	jz	3048h

l0800_3045:
	jmp	3070h

l0800_3048:
	mov	es,[3674h]
	mov	word ptr es:[0D2ACh],0FFFFh
	mov	es,[36F8h]
	mov	ax,es:[0F1F8h]
	mov	dx,es:[0F1FAh]
	mov	es,[36FAh]
	mov	es:[0FDD0h],ax
	mov	es:[0FDD2h],dx
	jmp	3302h

l0800_3070:
	mov	word ptr [bp-16h],0h
	jmp	307Bh

l0800_3078:
	inc	word ptr [bp-16h]

l0800_307B:
	mov	es,[366Ah]
	mov	ax,[bp-16h]
	cmp	es:[54CEh],ax
	jg	308Ch

l0800_3089:
	jmp	3171h

l0800_308C:
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	mov	es,[3714h]
	mov	bx,[bp-16h]
	shl	bx,2h
	push	word ptr es:[bx+2B72h]
	push	word ptr es:[bx+2B70h]
	call	far 149Ah:296Ah
	add	sp,8h
	cmp	ax,0h
	jz	30BEh

l0800_30BB:
	jmp	316Eh

l0800_30BE:
	mov	es,[3714h]
	mov	bx,[bp-16h]
	shl	bx,2h
	mov	ax,es:[bx+2B70h]
	mov	dx,es:[bx+2B72h]
	mov	es,[3672h]
	mov	es:[5B8Eh],ax
	mov	es:[5B90h],dx
	mov	ax,[bp-16h]
	mov	es,[3674h]
	mov	es:[0D2ACh],ax
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	180Ah
	push	67Eh
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[3672h]
	push	word ptr es:[5B90h]
	push	word ptr es:[5B8Eh]
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	push	ds
	push	0FBEh
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[36FAh]
	mov	es:[0FDD0h],ax
	mov	es:[0FDD2h],dx
	mov	ax,es:[0FDD2h]
	or	ax,es:[0FDD0h]
	jz	314Fh

l0800_314C:
	jmp	316Bh

l0800_314F:
	push	180Ah
	push	67Eh
	push	ds
	push	0FC0h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_316B:
	jmp	3302h

l0800_316E:
	jmp	3078h

l0800_3171:
	mov	es,[366Ah]
	cmp	word ptr es:[54CEh],32h
	jz	3180h

l0800_317D:
	jmp	3196h

l0800_3180:
	push	ds
	push	0FDEh
	call	far 149Ah:0ABCh
	add	sp,4h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_3196:
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:260Eh
	add	sp,4h
	inc	ax
	push	ax
	call	far 149Ah:22A2h
	add	sp,2h
	mov	es,[3672h]
	mov	es:[5B8Eh],ax
	mov	es:[5B90h],dx
	mov	ax,es:[5B90h]
	or	ax,es:[5B8Eh]
	jz	31D1h

l0800_31CE:
	jmp	31F5h

l0800_31D1:
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	push	ds
	push	1025h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_31F5:
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	mov	es,[3672h]
	push	word ptr es:[5B90h]
	push	word ptr es:[5B8Eh]
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[3672h]
	push	word ptr es:[5B90h]
	push	word ptr es:[5B8Eh]
	push	ds
	push	104Fh
	mov	es,[363Eh]
	push	word ptr es:[2D7Ch]
	push	word ptr es:[2D7Ah]
	call	far 149Ah:0752h
	add	sp,0Ch
	mov	es,[366Ah]
	mov	ax,es:[54CEh]
	mov	es,[3674h]
	mov	es:[0D2ACh],ax
	mov	es,[3672h]
	mov	ax,es:[5B8Eh]
	mov	dx,es:[5B90h]
	mov	es,[366Ah]
	mov	bx,es:[54CEh]
	shl	bx,2h
	mov	es,[3714h]
	mov	es:[bx+2B70h],ax
	mov	es:[bx+2B72h],dx
	mov	es,[366Ah]
	inc	word ptr es:[54CEh]
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	180Ah
	push	67Eh
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[3672h]
	push	word ptr es:[5B90h]
	push	word ptr es:[5B8Eh]
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	push	ds
	push	105Eh
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[36FAh]
	mov	es:[0FDD0h],ax
	mov	es:[0FDD2h],dx
	mov	ax,es:[0FDD2h]
	or	ax,es:[0FDD0h]
	jz	32E6h

l0800_32E3:
	jmp	3302h

l0800_32E6:
	push	180Ah
	push	67Eh
	push	ds
	push	1060h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_3302:
	jmp	380Bh

l0800_3305:
	push	4h
	push	ds
	push	107Ch
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	3321h

l0800_331E:
	jmp	3469h

l0800_3321:
	mov	es,[36CAh]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	3330h

l0800_332D:
	jmp	3466h

l0800_3330:
	call	far 0800h:0A47h
	mov	es,[3702h]
	mov	word ptr es:[0A7D6h],5B9Fh
	mov	word ptr es:[0A7D8h],381Dh
	push	2Ch
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-22h],ax
	mov	[bp-20h],dx
	or	dx,ax
	jnz	3368h

l0800_3365:
	jmp	33FCh

l0800_3368:
	les	bx,[bp-22h]
	inc	word ptr [bp-22h]
	mov	byte ptr es:[bx],0h
	mov	ax,[bp-22h]
	mov	dx,[bp-20h]
	mov	[bp+0FF20h],ax
	mov	[bp+0FF22h],dx

l0800_3380:
	les	bx,[bp+0FF20h]
	cmp	byte ptr es:[bx],0h
	jnz	338Dh

l0800_338A:
	jmp	33B3h

l0800_338D:
	les	bx,[bp+0FF20h]
	mov	al,es:[bx]
	cbw
	mov	bx,ax
	test	byte ptr [bx+3489h],2h
	jnz	33A1h

l0800_339E:
	jmp	33ACh

l0800_33A1:
	les	bx,[bp+0FF20h]
	sub	byte ptr es:[bx],20h
	jmp	33ACh

l0800_33AC:
	inc	word ptr [bp+0FF20h]
	jmp	3380h

l0800_33B3:
	push	ds
	push	1081h
	push	word ptr [bp-20h]
	push	word ptr [bp-22h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	33CDh

l0800_33CA:
	jmp	33E4h

l0800_33CD:
	push	word ptr [bp-20h]
	push	word ptr [bp-22h]
	push	381Dh
	push	4CC0h
	call	far 149Ah:25AEh
	add	sp,8h
	jmp	33FCh

l0800_33E4:
	push	word ptr [bp-20h]
	push	word ptr [bp-22h]
	push	ds
	push	1086h
	push	381Dh
	push	4CC0h
	call	far 149Ah:280Ah
	add	sp,0Ch

l0800_33FC:
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	mov	es,[366Eh]
	push	word ptr es:[0F200h]
	push	word ptr es:[0F1FEh]
	call	far 149Ah:296Ah
	add	sp,8h
	cmp	ax,0h
	jz	3428h

l0800_3425:
	jmp	3450h

l0800_3428:
	mov	es,[3650h]
	mov	word ptr es:[54E0h],0FFFFh
	mov	es,[363Eh]
	mov	ax,es:[2D7Ah]
	mov	dx,es:[2D7Ch]
	mov	es,[3648h]
	mov	es:[5CA4h],ax
	mov	es:[5CA6h],dx
	jmp	3466h

l0800_3450:
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 0800h:0AC7h
	add	sp,4h

l0800_3466:
	jmp	380Bh

l0800_3469:
	push	4h
	push	ds
	push	1091h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	3485h

l0800_3482:
	jmp	3520h

l0800_3485:
	mov	es,[3702h]
	mov	word ptr es:[0A7D6h],5B9Fh
	mov	word ptr es:[0A7D8h],381Dh
	push	381Dh
	push	5B74h
	push	ds
	push	1096h
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:2876h
	add	sp,0Ch
	push	2Ch
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:293Ch
	add	sp,6h
	inc	ax
	mov	es,[3702h]
	mov	es:[0A7D6h],ax
	mov	es:[0A7D8h],dx
	push	381Dh
	push	5B68h
	push	ds
	push	109Ah
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:2876h
	add	sp,0Ch
	mov	es,[3666h]
	push	word ptr es:[5B6Ah]
	push	word ptr es:[5B68h]
	mov	es,[3668h]
	push	word ptr es:[5B76h]
	push	word ptr es:[5B74h]
	push	ds
	push	109Eh
	call	far 149Ah:0ABCh
	add	sp,0Ch
	jmp	380Bh

l0800_3520:
	push	4h
	push	ds
	push	10DFh
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	353Ch

l0800_3539:
	jmp	3549h

l0800_353C:
	mov	es,[36D8h]
	mov	byte ptr es:[5B60h],1h
	jmp	380Bh

l0800_3549:
	push	4h
	push	ds
	push	10E4h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	3565h

l0800_3562:
	jmp	3572h

l0800_3565:
	mov	es,[36D8h]
	mov	byte ptr es:[5B60h],0h
	jmp	380Bh

l0800_3572:
	push	4h
	push	ds
	push	10E9h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	358Eh

l0800_358B:
	jmp	359Ch

l0800_358E:
	mov	es,[36EAh]
	mov	word ptr es:[2D70h],0h
	jmp	380Bh

l0800_359C:
	push	4h
	push	ds
	push	10EEh
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	35B8h

l0800_35B5:
	jmp	35C6h

l0800_35B8:
	mov	es,[36EAh]
	mov	word ptr es:[2D70h],1h
	jmp	380Bh

l0800_35C6:
	push	4h
	push	ds
	push	10F3h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	35E2h

l0800_35DF:
	jmp	35FBh

l0800_35E2:
	mov	es,[36AAh]
	mov	word ptr es:[5B8Ch],1h
	mov	es,[36A8h]
	mov	word ptr es:[54D2h],0h
	jmp	380Bh

l0800_35FB:
	push	4h
	push	ds
	push	10F8h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	3617h

l0800_3614:
	jmp	362Dh

l0800_3617:
	mov	ax,1h
	mov	es,[36AAh]
	mov	es:[5B8Ch],ax
	mov	es,[36A8h]
	mov	es:[54D2h],ax
	jmp	380Bh

l0800_362D:
	push	4h
	push	ds
	push	10FDh
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	3649h

l0800_3646:
	jmp	3657h

l0800_3649:
	mov	es,[36AAh]
	mov	word ptr es:[5B8Ch],0h
	jmp	380Bh

l0800_3657:
	push	4h
	push	ds
	push	1102h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	3673h

l0800_3670:
	jmp	3680h

l0800_3673:
	mov	es,[36C2h]
	mov	byte ptr es:[172Ch],1h
	jmp	380Bh

l0800_3680:
	push	4h
	push	ds
	push	1107h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	369Ch

l0800_3699:
	jmp	36A9h

l0800_369C:
	mov	es,[36C2h]
	mov	byte ptr es:[172Ch],0h
	jmp	380Bh

l0800_36A9:
	push	4h
	push	ds
	push	110Ch
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	36C5h

l0800_36C2:
	jmp	36D3h

l0800_36C5:
	mov	es,[36ACh]
	mov	word ptr es:[0A7DEh],0h
	jmp	380Bh

l0800_36D3:
	push	4h
	push	ds
	push	1111h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	36EFh

l0800_36EC:
	jmp	36FDh

l0800_36EF:
	mov	es,[36ACh]
	mov	word ptr es:[0A7DEh],1h
	jmp	380Bh

l0800_36FD:
	push	4h
	push	ds
	push	1116h
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	3719h

l0800_3716:
	jmp	3727h

l0800_3719:
	mov	es,[3716h]
	mov	word ptr es:[173Ah],0h
	jmp	380Bh

l0800_3727:
	push	4h
	push	ds
	push	111Bh
	push	381Dh
	push	5B9Ah
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	3743h

l0800_3740:
	jmp	3751h

l0800_3743:
	mov	es,[3716h]
	mov	word ptr es:[173Ah],1h
	jmp	380Bh

l0800_3751:
	call	far 0800h:02FEh
	push	180Ah
	push	67Eh
	push	381Dh
	push	5B9Ah
	call	far 0800h:05CCh
	add	sp,8h
	push	180Ah
	push	67Eh
	push	180Ah
	push	0FEDAh
	call	far 149Ah:25AEh
	add	sp,8h
	push	8000h
	push	180Ah
	push	67Eh
	call	far 149Ah:1E7Eh
	add	sp,6h
	mov	es,[3626h]
	mov	es:[0208h],ax
	cmp	word ptr es:[0208h],0h
	jle	37A2h

l0800_379F:
	jmp	37C6h

l0800_37A2:
	push	180Ah
	push	67Eh
	push	ds
	push	1120h
	call	far 149Ah:0ABCh
	add	sp,8h
	mov	word ptr [06CCh],1h
	mov	es,[3656h]
	inc	word ptr es:[0D2AEh]
	jmp	380Bh

l0800_37C6:
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],0h
	jnz	37D5h

l0800_37D2:
	jmp	37E7h

l0800_37D5:
	push	180Ah
	push	0FEDAh
	push	ds
	push	1149h
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_37E7:
	mov	es,[3628h]
	mov	word ptr es:[2C3Ah],0h
	call	far 0800h:481Ch
	push	180Ah
	push	0FEDAh
	call	far 1054h:3A11h
	add	sp,4h
	mov	word ptr [06CCh],0h

l0800_380B:
	jmp	2156h

l0800_380E:
	mov	es,[36DEh]
	cmp	byte ptr es:[2C70h],0h
	jnz	381Dh

l0800_381A:
	jmp	391Fh

l0800_381D:
	push	ds
	push	115Fh
	mov	es,[36F8h]
	push	word ptr es:[0F1FAh]
	push	word ptr es:[0F1F8h]
	call	far 149Ah:0752h
	add	sp,8h
	push	ds
	push	117Fh
	mov	es,[370Ah]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,8h
	push	ds
	push	119Dh
	mov	es,[370Ah]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,8h
	mov	word ptr [bp-1Ch],0h
	jmp	3876h

l0800_3873:
	inc	word ptr [bp-1Ch]

l0800_3876:
	mov	es,[36E0h]
	mov	ax,[bp-1Ch]
	cmp	es:[0230h],ax
	jg	3887h

l0800_3884:
	jmp	38B8h

l0800_3887:
	mov	es,[3718h]
	mov	bx,[bp-1Ch]
	shl	bx,2h
	push	word ptr es:[bx+0C7D0h]
	push	word ptr es:[bx+0C7CEh]
	push	ds
	push	11C1h
	mov	es,[370Ah]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ch
	jmp	3873h

l0800_38B8:
	push	ds
	push	11CFh
	mov	es,[370Ah]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,8h
	mov	word ptr [bp-1Ch],0h
	jmp	38DDh

l0800_38DA:
	inc	word ptr [bp-1Ch]

l0800_38DD:
	mov	es,[36E2h]
	mov	ax,[bp-1Ch]
	cmp	es:[5B70h],ax
	jg	38EEh

l0800_38EB:
	jmp	391Fh

l0800_38EE:
	mov	es,[371Ah]
	mov	bx,[bp-1Ch]
	shl	bx,2h
	push	word ptr es:[bx+0CFA2h]
	push	word ptr es:[bx+0CFA0h]
	push	ds
	push	11F3h
	mov	es,[370Ah]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ch
	jmp	38DAh

l0800_391F:
	mov	es,[36CAh]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	392Eh

l0800_392B:
	jmp	3BA8h

l0800_392E:
	mov	es,[363Eh]
	push	word ptr es:[2D7Ch]
	push	word ptr es:[2D7Ah]
	call	far 149Ah:063Ch
	add	sp,4h
	mov	es,[36F8h]
	mov	ax,es:[0F1FAh]
	or	ax,es:[0F1F8h]
	jnz	3956h

l0800_3953:
	jmp	3968h

l0800_3956:
	push	word ptr es:[0F1FAh]
	push	word ptr es:[0F1F8h]
	call	far 149Ah:063Ch
	add	sp,4h

l0800_3968:
	mov	es,[3644h]
	push	word ptr es:[0A7DCh]
	push	word ptr es:[0A7DAh]
	call	far 149Ah:063Ch
	add	sp,4h
	mov	es,[3678h]
	cmp	word ptr es:[54CCh],0h
	jnz	398Dh

l0800_398A:
	jmp	39CFh

l0800_398D:
	mov	es,[370Ah]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:063Ch
	add	sp,4h
	mov	es,[370Ch]
	push	word ptr es:[2B6Ah]
	push	word ptr es:[2B68h]
	call	far 149Ah:063Ch
	add	sp,4h
	mov	es,[3708h]
	push	word ptr es:[0FDD6h]
	push	word ptr es:[0FDD4h]
	call	far 149Ah:063Ch
	add	sp,4h

l0800_39CF:
	mov	es,[367Ah]
	cmp	word ptr es:[0FDCAh],0h
	jnz	39DEh

l0800_39DB:
	jmp	3A19h

l0800_39DE:
	mov	es,[3712h]
	push	word ptr es:[0216h]
	push	word ptr es:[0214h]
	call	far 149Ah:063Ch
	add	sp,4h
	mov	es,[36C6h]
	cmp	byte ptr es:[0FFE0h],0h
	jnz	3A03h

l0800_3A00:
	jmp	3A19h

l0800_3A03:
	mov	es,[3710h]
	push	word ptr es:[0206h]
	push	word ptr es:[0204h]
	call	far 149Ah:063Ch
	add	sp,4h

l0800_3A19:
	mov	es,[363Eh]
	mov	ax,es:[2D7Ah]
	mov	dx,es:[2D7Ch]
	mov	es,[3648h]
	cmp	es:[5CA4h],ax
	jz	3A34h

l0800_3A31:
	jmp	3A3Eh

l0800_3A34:
	cmp	es:[5CA6h],dx
	jnz	3A3Eh

l0800_3A3B:
	jmp	3A88h

l0800_3A3E:
	mov	ax,es:[5CA6h]
	or	ax,es:[5CA4h]
	jnz	3A4Ch

l0800_3A49:
	jmp	3A88h

l0800_3A4C:
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:063Ch
	add	sp,4h
	inc	ax
	jz	3A64h

l0800_3A61:
	jmp	3A88h

l0800_3A64:
	mov	es,[364Ah]
	push	word ptr es:[0D2B4h]
	push	word ptr es:[0D2B2h]
	push	ds
	push	1201h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_3A88:
	mov	word ptr [bp-16h],0h
	jmp	3A93h

l0800_3A90:
	inc	word ptr [bp-16h]

l0800_3A93:
	mov	es,[364Ch]
	mov	ax,[bp-16h]
	cmp	es:[0A7F6h],ax
	jg	3AA4h

l0800_3AA1:
	jmp	3BA8h

l0800_3AA4:
	mov	es,[364Eh]
	mov	bx,[bp-16h]
	shl	bx,2h
	mov	ax,es:[bx+2A2Ch]
	mov	dx,es:[bx+2A2Eh]
	mov	es,[364Ah]
	mov	es:[0D2B2h],ax
	mov	es:[0D2B4h],dx
	mov	es,[3652h]
	push	word ptr es:[2A04h]
	push	word ptr es:[2A02h]
	push	180Ah
	push	67Eh
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[364Ah]
	push	word ptr es:[0D2B4h]
	push	word ptr es:[0D2B2h]
	push	180Ah
	push	67Eh
	call	far 149Ah:2568h
	add	sp,8h
	push	ds
	push	1218h
	push	180Ah
	push	67Eh
	call	far 149Ah:0736h
	add	sp,8h
	mov	es,[3648h]
	mov	es:[5CA4h],ax
	mov	es:[5CA6h],dx
	mov	ax,es:[5CA6h]
	or	ax,es:[5CA4h]
	jz	3B2Ah

l0800_3B27:
	jmp	3B49h

l0800_3B2A:
	push	180Ah
	push	67Eh
	push	ds
	push	121Ah
	call	far 149Ah:0ABCh
	add	sp,8h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h
	jmp	3BA5h

l0800_3B49:
	push	1Ah
	push	ds
	push	1238h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ah
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:063Ch
	add	sp,4h
	inc	ax
	jz	3B81h

l0800_3B7E:
	jmp	3BA5h

l0800_3B81:
	mov	es,[364Ah]
	push	word ptr es:[0D2B4h]
	push	word ptr es:[0D2B2h]
	push	ds
	push	1243h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_3BA5:
	jmp	3A90h

l0800_3BA8:
	mov	es,[36F6h]
	push	word ptr es:[0210h]
	push	word ptr es:[020Eh]
	call	far 149Ah:063Ch
	add	sp,4h
	push	0h
	push	0h
	call	far 0800h:8095h
	add	sp,4h
	mov	es,[36D4h]
	cmp	byte ptr es:[4CBEh],0h
	jnz	3BD9h

l0800_3BD6:
	jmp	3C0Eh

l0800_3BD9:
	mov	es,[36DAh]
	cmp	word ptr es:[5CA2h],0h
	jnz	3BE8h

l0800_3BE5:
	jmp	3BFDh

l0800_3BE8:
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	push	ds
	push	125Ah
	call	far 149Ah:0ABCh
	add	sp,6h

l0800_3BFD:
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	call	far 149Ah:1DCAh
	add	sp,2h

l0800_3C0E:
	mov	es,[36CCh]
	cmp	byte ptr es:[0FED8h],0h
	jz	3C1Dh

l0800_3C1A:
	jmp	3C2Ch

l0800_3C1D:
	mov	es,[36D2h]
	cmp	byte ptr es:[2B6Ch],0h
	jnz	3C2Ch

l0800_3C29:
	jmp	3C53h

l0800_3C2C:
	mov	es,[36CAh]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	3C3Bh

l0800_3C38:
	jmp	3C43h

l0800_3C3B:
	or	word ptr [bp-1Ah],80h
	jmp	3C47h

l0800_3C43:
	and	word ptr [bp-1Ah],40h

l0800_3C47:
	mov	al,[bp-1Ah]
	push	ax
	call	far 147Dh:001Dh
	add	sp,2h

l0800_3C53:
	mov	es,[36D2h]
	cmp	byte ptr es:[2B6Ch],0h
	jz	3C62h

l0800_3C5F:
	jmp	3C71h

l0800_3C62:
	mov	es,[36CCh]
	cmp	byte ptr es:[0FED8h],0h
	jnz	3C71h

l0800_3C6E:
	jmp	3C7Dh

l0800_3C71:
	push	ds
	push	1270h
	call	far 149Ah:0ABCh
	add	sp,4h

l0800_3C7D:
	mov	es,[3692h]
	mov	ax,es:[5CA0h]
	or	ax,es:[5C9Eh]
	jnz	3C8Fh

l0800_3C8C:
	jmp	3CAFh

l0800_3C8F:
	push	word ptr es:[5CA0h]
	push	word ptr es:[5C9Eh]
	push	word ptr es:[5CA0h]
	push	word ptr es:[5C9Eh]
	push	ds
	push	1282h
	call	far 149Ah:0ABCh
	add	sp,0Ch

l0800_3CAF:
	mov	es,[3690h]
	mov	ax,es:[021Ch]
	or	ax,es:[021Ah]
	jnz	3CC1h

l0800_3CBE:
	jmp	3CE1h

l0800_3CC1:
	push	word ptr es:[021Ch]
	push	word ptr es:[021Ah]
	push	word ptr es:[021Ch]
	push	word ptr es:[021Ah]
	push	ds
	push	12ABh
	call	far 149Ah:0ABCh
	add	sp,0Ch

l0800_3CE1:
	mov	es,[368Eh]
	mov	ax,es:[1730h]
	or	ax,es:[172Eh]
	jnz	3CF3h

l0800_3CF0:
	jmp	3D13h

l0800_3CF3:
	push	word ptr es:[1730h]
	push	word ptr es:[172Eh]
	push	word ptr es:[1730h]
	push	word ptr es:[172Eh]
	push	ds
	push	12D4h
	call	far 149Ah:0ABCh
	add	sp,0Ch

l0800_3D13:
	mov	es,[368Ch]
	mov	ax,es:[1736h]
	or	ax,es:[1734h]
	jnz	3D25h

l0800_3D22:
	jmp	3D45h

l0800_3D25:
	push	word ptr es:[1736h]
	push	word ptr es:[1734h]
	push	word ptr es:[1736h]
	push	word ptr es:[1734h]
	push	ds
	push	12FDh
	call	far 149Ah:0ABCh
	add	sp,0Ch

l0800_3D45:
	mov	es,[368Ch]
	mov	ax,es:[1734h]
	mov	dx,es:[1736h]
	mov	es,[368Eh]
	add	ax,es:[172Eh]
	adc	dx,es:[1730h]
	mov	es,[3690h]
	add	ax,es:[021Ah]
	adc	dx,es:[021Ch]
	mov	es,[3692h]
	add	ax,es:[5C9Eh]
	adc	dx,es:[5CA0h]
	mov	es,[371Ch]
	mov	es:[0F9FEh],ax
	mov	es:[0FA00h],dx
	mov	ax,es:[0FA00h]
	or	ax,es:[0F9FEh]
	jnz	3D97h

l0800_3D94:
	jmp	3DCAh

l0800_3D97:
	mov	es,[36D2h]
	cmp	byte ptr es:[2B6Ch],0h
	jz	3DA6h

l0800_3DA3:
	jmp	3DCAh

l0800_3DA6:
	mov	es,[371Ch]
	push	word ptr es:[0FA00h]
	push	word ptr es:[0F9FEh]
	push	word ptr es:[0FA00h]
	push	word ptr es:[0F9FEh]
	push	ds
	push	1326h
	call	far 149Ah:0ABCh
	add	sp,0Ch

l0800_3DCA:
	mov	es,[371Ch]
	mov	ax,es:[0FA00h]
	or	ax,es:[0F9FEh]
	jnz	3DDCh

l0800_3DD9:
	jmp	3E32h

l0800_3DDC:
	mov	es,[36D2h]
	cmp	byte ptr es:[2B6Ch],0h
	jnz	3DEBh

l0800_3DE8:
	jmp	3E32h

l0800_3DEB:
	mov	es,[36B0h]
	cmp	word ptr es:[2C72h],1h
	jz	3DFAh

l0800_3DF7:
	jmp	3E00h

l0800_3DFA:
	mov	ax,1350h
	jmp	3E03h

l0800_3E00:
	mov	ax,1351h

l0800_3E03:
	push	ds
	push	ax
	mov	es,[36B0h]
	push	word ptr es:[2C72h]
	mov	es,[371Ch]
	push	word ptr es:[0FA00h]
	push	word ptr es:[0F9FEh]
	push	word ptr es:[0FA00h]
	push	word ptr es:[0F9FEh]
	push	ds
	push	1353h
	call	far 149Ah:0ABCh
	add	sp,12h

l0800_3E32:
	mov	es,[36D4h]
	cmp	byte ptr es:[4CBEh],0h
	jnz	3E41h

l0800_3E3E:
	jmp	3FAEh

l0800_3E41:
	push	ds
	push	138Eh
	call	far 149Ah:0ABCh
	add	sp,4h
	mov	es,[369Ch]
	mov	ax,es:[5B98h]
	or	ax,es:[5B96h]
	jnz	3E5Fh

l0800_3E5C:
	jmp	3E7Fh

l0800_3E5F:
	push	word ptr es:[5B98h]
	push	word ptr es:[5B96h]
	push	word ptr es:[5B98h]
	push	word ptr es:[5B96h]
	push	ds
	push	13ADh
	call	far 149Ah:0ABCh
	add	sp,0Ch

l0800_3E7F:
	mov	es,[369Ah]
	mov	ax,es:[0202h]
	or	ax,es:[0200h]
	jnz	3E91h

l0800_3E8E:
	jmp	3EB1h

l0800_3E91:
	push	word ptr es:[0202h]
	push	word ptr es:[0200h]
	push	word ptr es:[0202h]
	push	word ptr es:[0200h]
	push	ds
	push	13D9h
	call	far 149Ah:0ABCh
	add	sp,0Ch

l0800_3EB1:
	mov	es,[3698h]
	mov	ax,es:[1722h]
	or	ax,es:[1720h]
	jnz	3EC3h

l0800_3EC0:
	jmp	3EE3h

l0800_3EC3:
	push	word ptr es:[1722h]
	push	word ptr es:[1720h]
	push	word ptr es:[1722h]
	push	word ptr es:[1720h]
	push	ds
	push	1405h
	call	far 149Ah:0ABCh
	add	sp,0Ch

l0800_3EE3:
	mov	es,[3696h]
	mov	ax,es:[172Ah]
	or	ax,es:[1728h]
	jnz	3EF5h

l0800_3EF2:
	jmp	3F15h

l0800_3EF5:
	push	word ptr es:[172Ah]
	push	word ptr es:[1728h]
	push	word ptr es:[172Ah]
	push	word ptr es:[1728h]
	push	ds
	push	1431h
	call	far 149Ah:0ABCh
	add	sp,0Ch

l0800_3F15:
	mov	es,[3698h]
	mov	ax,es:[1720h]
	mov	dx,es:[1722h]
	mov	es,[369Ah]
	add	ax,es:[0200h]
	adc	dx,es:[0202h]
	mov	es,[369Ch]
	add	ax,es:[5B96h]
	adc	dx,es:[5B98h]
	mov	es,[3696h]
	add	ax,es:[1728h]
	adc	dx,es:[172Ah]
	mov	es,[371Eh]
	mov	es:[0FA06h],ax
	mov	es:[0FA08h],dx
	mov	ax,es:[0FA08h]
	or	ax,es:[0FA06h]
	jnz	3F67h

l0800_3F64:
	jmp	3FAEh

l0800_3F67:
	mov	es,[36B0h]
	cmp	word ptr es:[2C72h],1h
	jz	3F76h

l0800_3F73:
	jmp	3F7Ch

l0800_3F76:
	mov	ax,145Dh
	jmp	3F7Fh

l0800_3F7C:
	mov	ax,145Eh

l0800_3F7F:
	push	ds
	push	ax
	mov	es,[36B0h]
	push	word ptr es:[2C72h]
	mov	es,[371Eh]
	push	word ptr es:[0FA08h]
	push	word ptr es:[0FA06h]
	push	word ptr es:[0FA08h]
	push	word ptr es:[0FA06h]
	push	ds
	push	1460h
	call	far 149Ah:0ABCh
	add	sp,12h

l0800_3FAE:
	mov	es,[36CAh]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	3FBDh

l0800_3FBA:
	jmp	3FFAh

l0800_3FBD:
	mov	es,[36A2h]
	mov	ax,es:[0D2A2h]
	mov	dx,es:[0D2A4h]
	add	ax,7h
	adc	dx,0h
	shr	dx,1h
	rcr	ax,1h
	shr	dx,1h
	rcr	ax,1h
	shr	dx,1h
	rcr	ax,1h
	mov	[bp-0Ch],ax
	mov	[bp-0Ah],dx
	push	word ptr [bp-0Ah]
	push	word ptr [bp-0Ch]
	push	word ptr [bp-0Ah]
	push	word ptr [bp-0Ch]
	push	ds
	push	149Eh
	call	far 149Ah:0ABCh
	add	sp,0Ch

l0800_3FFA:
	mov	es,[365Ch]
	cmp	word ptr es:[022Eh],0h
	jnz	4009h

l0800_4006:
	jmp	401Ch

l0800_4009:
	push	0Ah
	push	word ptr es:[022Eh]
	push	ds
	push	14D0h
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_401C:
	mov	es,[36D8h]
	cmp	byte ptr es:[5B60h],0h
	jnz	402Bh

l0800_4028:
	jmp	408Ah

l0800_402B:
	mov	es,[36B2h]
	cmp	word ptr es:[0D272h],0h
	jnz	403Ah

l0800_4037:
	jmp	408Ah

l0800_403A:
	mov	es,[36B2h]
	cmp	word ptr es:[0D272h],1h
	jz	4049h

l0800_4046:
	jmp	404Fh

l0800_4049:
	mov	ax,1524h
	jmp	4052h

l0800_404F:
	mov	ax,1525h

l0800_4052:
	push	ds
	push	ax
	mov	es,[36B2h]
	push	word ptr es:[0D272h]
	mov	es,[36B6h]
	mov	ax,es:[2A24h]
	mov	dx,es:[2A26h]
	add	ax,7h
	adc	dx,0h
	shr	dx,1h
	rcr	ax,1h
	shr	dx,1h
	rcr	ax,1h
	shr	dx,1h
	rcr	ax,1h
	push	dx
	push	ax
	push	ds
	push	1528h
	call	far 149Ah:0ABCh
	add	sp,0Eh

l0800_408A:
	mov	es,[36D8h]
	cmp	byte ptr es:[5B60h],0h
	jnz	4099h

l0800_4096:
	jmp	40F8h

l0800_4099:
	mov	es,[36B4h]
	cmp	word ptr es:[0D2B0h],0h
	jnz	40A8h

l0800_40A5:
	jmp	40F8h

l0800_40A8:
	mov	es,[36B4h]
	cmp	word ptr es:[0D2B0h],1h
	jz	40B7h

l0800_40B4:
	jmp	40BDh

l0800_40B7:
	mov	ax,1569h
	jmp	40C0h

l0800_40BD:
	mov	ax,156Ah

l0800_40C0:
	push	ds
	push	ax
	mov	es,[36B4h]
	push	word ptr es:[0D2B0h]
	mov	es,[36B8h]
	mov	ax,es:[2C6Ch]
	mov	dx,es:[2C6Eh]
	add	ax,7h
	adc	dx,0h
	shr	dx,1h
	rcr	ax,1h
	shr	dx,1h
	rcr	ax,1h
	shr	dx,1h
	rcr	ax,1h
	push	dx
	push	ax
	push	ds
	push	156Dh
	call	far 149Ah:0ABCh
	add	sp,0Eh

l0800_40F8:
	mov	es,[3656h]
	cmp	word ptr es:[0D2AEh],0h
	jnz	4107h

l0800_4104:
	jmp	4113h

l0800_4107:
	push	ds
	push	15AEh
	call	far 149Ah:0ABCh
	add	sp,4h

l0800_4113:
	push	ds
	push	15E1h
	call	far 149Ah:0ABCh
	add	sp,4h
	mov	es,[36BAh]
	push	word ptr es:[0212h]
	call	far 0800h:02C7h
	add	sp,2h
	pop	si
	pop	di
	leave
	retf

;; fn0800_4134: 0800:4134
;;   Called from:
;;     0800:0F4D (in main)
fn0800_4134 proc
	push	bp
	mov	bp,sp
	mov	ax,2h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	word ptr [bp-2h],0h
	jmp	414Ch

l0800_4149:
	inc	word ptr [bp-2h]

l0800_414C:
	cmp	word ptr [bp-2h],6h
	jle	4155h

l0800_4152:
	jmp	41A0h

l0800_4155:
	mov	ax,[bp-2h]
	inc	ax
	mov	es,[3706h]
	mov	bx,[bp-2h]
	shl	bx,2h
	mov	es:[bx+2BEAh],ax
	cmp	word ptr [bp-2h],2h
	jnz	4171h

l0800_416E:
	jmp	417Ah

l0800_4171:
	cmp	word ptr [bp-2h],6h
	jz	417Ah

l0800_4177:
	jmp	418Dh

l0800_417A:
	mov	es,[3706h]
	mov	bx,[bp-2h]
	shl	bx,2h
	mov	byte ptr es:[bx+2BECh],4Ch
	jmp	419Dh

l0800_418D:
	mov	es,[3706h]
	mov	bx,[bp-2h]
	shl	bx,2h
	mov	byte ptr es:[bx+2BECh],57h

l0800_419D:
	jmp	4149h

l0800_41A0:
	mov	es,[3706h]
	mov	bx,[bp-2h]
	shl	bx,2h
	mov	word ptr es:[bx+2BEAh],0h
	mov	ax,0h
	jmp	41B7h

l0800_41B7:
	pop	si
	pop	di
	leave
	retf

;; fn0800_41BB: 0800:41BB
;;   Called from:
;;     0800:24C6 (in main)
fn0800_41BB proc
	push	bp
	mov	bp,sp
	mov	ax,6h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	word ptr [bp-6h],0h
	push	3Ah
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	mov	ax,[bp-2h]
	or	ax,[bp-4h]
	jnz	41EEh

l0800_41EB:
	jmp	41F8h

l0800_41EE:
	les	bx,[bp-4h]
	inc	word ptr [bp-4h]
	mov	byte ptr es:[bx],0h

l0800_41F8:
	mov	ax,[bp-2h]
	or	ax,[bp-4h]
	jnz	4203h

l0800_4200:
	jmp	422Ah

l0800_4203:
	les	bx,[bp-4h]
	mov	al,es:[bx]
	cbw
	mov	bx,ax
	test	byte ptr [bx+3489h],2h
	jnz	4216h

l0800_4213:
	jmp	4221h

l0800_4216:
	les	bx,[bp-4h]
	mov	al,es:[bx]
	sub	al,20h
	jmp	4227h

l0800_4221:
	les	bx,[bp-4h]
	mov	al,es:[bx]

l0800_4227:
	jmp	422Ch

l0800_422A:
	mov	al,57h

l0800_422C:
	mov	es,[3706h]
	mov	bx,[bp+0Ah]
	shl	bx,2h
	mov	es:[bx+2BECh],al

l0800_423B:
	cmp	word ptr [bp-6h],0h
	jz	4244h

l0800_4241:
	jmp	443Eh

l0800_4244:
	push	ds
	push	15E4h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	425Eh

l0800_425B:
	jmp	4266h

l0800_425E:
	mov	word ptr [bp-6h],1h
	jmp	443Bh

l0800_4266:
	push	ds
	push	15E9h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	4280h

l0800_427D:
	jmp	4288h

l0800_4280:
	mov	word ptr [bp-6h],2h
	jmp	443Bh

l0800_4288:
	push	ds
	push	15EEh
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	42A2h

l0800_429F:
	jmp	42AAh

l0800_42A2:
	mov	word ptr [bp-6h],3h
	jmp	443Bh

l0800_42AA:
	push	ds
	push	15F2h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	42C4h

l0800_42C1:
	jmp	42CCh

l0800_42C4:
	mov	word ptr [bp-6h],4h
	jmp	443Bh

l0800_42CC:
	push	ds
	push	15F7h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	42E6h

l0800_42E3:
	jmp	42EEh

l0800_42E6:
	mov	word ptr [bp-6h],5h
	jmp	443Bh

l0800_42EE:
	push	ds
	push	15FCh
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	4308h

l0800_4305:
	jmp	4310h

l0800_4308:
	mov	word ptr [bp-6h],6h
	jmp	443Bh

l0800_4310:
	push	ds
	push	1601h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	432Ah

l0800_4327:
	jmp	4332h

l0800_432A:
	mov	word ptr [bp-6h],7h
	jmp	443Bh

l0800_4332:
	push	ds
	push	1605h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	434Ch

l0800_4349:
	jmp	4354h

l0800_434C:
	mov	word ptr [bp-6h],8h
	jmp	443Bh

l0800_4354:
	push	ds
	push	160Bh
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	436Eh

l0800_436B:
	jmp	4376h

l0800_436E:
	mov	word ptr [bp-6h],9h
	jmp	443Bh

l0800_4376:
	push	ds
	push	1611h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	4390h

l0800_438D:
	jmp	4398h

l0800_4390:
	mov	word ptr [bp-6h],0Ah
	jmp	443Bh

l0800_4398:
	push	ds
	push	1617h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	43B2h

l0800_43AF:
	jmp	43BAh

l0800_43B2:
	mov	word ptr [bp-6h],0Bh
	jmp	443Bh

l0800_43BA:
	push	2h
	push	ds
	push	161Bh
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:2626h
	add	sp,0Ah
	cmp	ax,0h
	jz	43D6h

l0800_43D3:
	jmp	4435h

l0800_43D6:
	les	bx,[bp+6h]
	cmp	byte ptr es:[bx+2h],30h
	jge	43E3h

l0800_43E0:
	jmp	43F0h

l0800_43E3:
	les	bx,[bp+6h]
	cmp	byte ptr es:[bx+2h],39h
	jg	43F0h

l0800_43ED:
	jmp	43F6h

l0800_43F0:
	mov	ax,0FFFFh
	jmp	4456h

l0800_43F6:
	les	bx,[bp+6h]
	cmp	byte ptr es:[bx+3h],58h
	jnz	4403h

l0800_4400:
	jmp	4416h

l0800_4403:
	les	bx,[bp+6h]
	cmp	byte ptr es:[bx+3h],59h
	jnz	4410h

l0800_440D:
	jmp	4416h

l0800_4410:
	mov	ax,0FFFFh
	jmp	4456h

l0800_4416:
	les	bx,[bp+6h]
	mov	al,es:[bx+2h]
	cbw
	sub	ax,56h
	shl	ax,1h
	les	bx,[bp+6h]
	mov	cx,ax
	mov	al,es:[bx+3h]
	cbw
	add	cx,ax
	mov	[bp-6h],cx
	jmp	443Bh

l0800_4435:
	mov	ax,0FFFFh
	jmp	4456h

l0800_443B:
	jmp	423Bh

l0800_443E:
	mov	ax,[bp-6h]
	mov	es,[3706h]
	mov	bx,[bp+0Ah]
	shl	bx,2h
	mov	es:[bx+2BEAh],ax
	mov	ax,0h
	jmp	4456h

l0800_4456:
	pop	si
	pop	di
	leave
	retf

;; fn0800_445A: 0800:445A
;;   Called from:
;;     0800:4EBE (in fn0800_481C)
fn0800_445A proc
	push	bp
	mov	bp,sp
	mov	ax,2h
	call	far 149Ah:02C8h
	push	di
	push	si
	cmp	word ptr [06CAh],800h
	jg	4472h

l0800_446F:
	jmp	4488h

l0800_4472:
	push	word ptr [06CAh]
	push	ds
	push	161Eh
	call	far 149Ah:0ABCh
	add	sp,6h
	mov	ax,0FFFFh
	jmp	44DDh

l0800_4488:
	push	28h
	call	far 149Ah:22A2h
	add	sp,2h
	mov	es,[3720h]
	mov	bx,[06CAh]
	shl	bx,2h
	mov	es:[bx+230h],ax
	mov	es:[bx+232h],dx
	mov	bx,[06CAh]
	shl	bx,2h
	mov	ax,es:[bx+232h]
	or	ax,es:[bx+230h]
	jz	44BDh

l0800_44BA:
	jmp	44D3h

l0800_44BD:
	push	word ptr [06CAh]
	push	ds
	push	1652h
	call	far 149Ah:0ABCh
	add	sp,6h
	mov	ax,0FFFFh
	jmp	44DDh

l0800_44D3:
	mov	ax,[06CAh]
	inc	word ptr [06CAh]
	jmp	44DDh

l0800_44DD:
	pop	si
	pop	di
	leave
	retf

;; fn0800_44E1: 0800:44E1
;;   Called from:
;;     0800:4C81 (in fn0800_481C)
;;     0800:4DC0 (in fn0800_481C)
fn0800_44E1 proc
	push	bp
	mov	bp,sp
	mov	ax,70h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[362Ah]
	cmp	word ptr es:[0FF2Eh],0ABCDh
	jnz	44FEh

l0800_44FB:
	jmp	4556h

l0800_44FE:
	push	36h
	lea	ax,[bp-36h]
	push	ss
	push	ax
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h
	lea	ax,[bp-14h]
	push	ss
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25AEh
	add	sp,8h
	mov	ax,[bp-36h]
	les	bx,[bp+6h]
	mov	es:[bx+12h],ax
	les	bx,[bp+6h]
	mov	word ptr es:[bx+10h],0h
	mov	si,6h

l0800_453F:
	dec	si
	cmp	si,0h
	jge	4548h

l0800_4545:
	jmp	4553h

l0800_4548:
	les	bx,[bp+6h]
	mov	byte ptr es:[bx+si+58h],0FFh
	jmp	453Fh

l0800_4553:
	jmp	45D8h

l0800_4556:
	mov	es,[362Ah]
	cmp	word ptr es:[0FF26h],632h
	jl	4566h

l0800_4563:
	jmp	45BFh

l0800_4566:
	push	3Ah
	lea	ax,[bp-70h]
	push	ss
	push	ax
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h
	lea	ax,[bp-70h]
	push	ss
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25AEh
	add	sp,8h
	mov	ax,[bp-5Eh]
	les	bx,[bp+6h]
	mov	es:[bx+12h],ax
	mov	ax,[bp-60h]
	les	bx,[bp+6h]
	mov	es:[bx+10h],ax
	mov	si,6h

l0800_45A8:
	dec	si
	cmp	si,0h
	jge	45B1h

l0800_45AE:
	jmp	45BCh

l0800_45B1:
	les	bx,[bp+6h]
	mov	byte ptr es:[bx+si+58h],0FFh
	jmp	45A8h

l0800_45BC:
	jmp	45D8h

l0800_45BF:
	push	62h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h

l0800_45D8:
	pop	si
	pop	di
	leave
	retf

;; fn0800_45DC: 0800:45DC
;;   Called from:
;;     0800:4D3A (in fn0800_481C)
;;     0800:4E79 (in fn0800_481C)
fn0800_45DC proc
	push	bp
	mov	bp,sp
	mov	ax,20h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[362Ah]
	cmp	word ptr es:[0FF2Eh],0ABCDh
	jnz	45F9h

l0800_45F6:
	jmp	462Ah

l0800_45F9:
	push	10h
	lea	ax,[bp-20h]
	push	ss
	push	ax
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h
	mov	al,[bp-1Eh]
	sub	ah,ah
	les	bx,[bp+6h]
	mov	es:[bx+4h],ax
	mov	al,[bp-1Dh]
	les	bx,[bp+6h]
	mov	es:[bx+6h],al
	jmp	4682h

l0800_462A:
	mov	es,[362Ah]
	cmp	word ptr es:[0FF26h],632h
	jl	463Ah

l0800_4637:
	jmp	4669h

l0800_463A:
	push	10h
	lea	ax,[bp-10h]
	push	ss
	push	ax
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h
	mov	ax,[bp-0Eh]
	les	bx,[bp+6h]
	mov	es:[bx+4h],ax
	mov	al,[bp-0Ch]
	les	bx,[bp+6h]
	mov	es:[bx+6h],al
	jmp	4682h

l0800_4669:
	push	12h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h

l0800_4682:
	cmp	word ptr [bp+0Ah],0h
	jnz	468Bh

l0800_4688:
	jmp	46B0h

l0800_468B:
	les	bx,[bp+6h]
	mov	bx,es:[bx+4h]
	shl	bx,2h
	mov	es,[3630h]
	mov	ax,es:[bx+0FBCAh]
	mov	dx,es:[bx+0FBCCh]
	les	bx,[bp+6h]
	mov	es:[bx],ax
	mov	es:[bx+2h],dx
	jmp	46E8h

l0800_46B0:
	les	bx,[bp+6h]
	cmp	word ptr es:[bx+4h],0h
	jge	46BDh

l0800_46BA:
	jmp	46D8h

l0800_46BD:
	les	bx,[bp+6h]
	mov	bx,es:[bx+4h]
	shl	bx,2h
	mov	es,[362Ch]
	mov	ax,es:[bx+0F22Eh]
	mov	dx,es:[bx+0F230h]
	jmp	46DEh

l0800_46D8:
	mov	ax,0h
	mov	dx,0h

l0800_46DE:
	les	bx,[bp+6h]
	mov	es:[bx],ax
	mov	es:[bx+2h],dx

l0800_46E8:
	pop	si
	pop	di
	leave
	retf

;; fn0800_46EC: 0800:46EC
;;   Called from:
;;     0800:4783 (in fn0800_4725)
;;     0800:47F6 (in fn0800_4725)
fn0800_46EC proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	si,[bp+6h]
	inc	si
	jmp	4701h

l0800_4700:
	inc	si

l0800_4701:
	cmp	si,6h
	jl	4709h

l0800_4706:
	jmp	4719h

l0800_4709:
	les	bx,[bp+8h]
	mov	al,es:[bx+si]
	les	bx,[bp+8h]
	mov	es:[bx+si-1h],al
	jmp	4700h

l0800_4719:
	les	bx,[bp+8h]
	mov	byte ptr es:[bx+si-1h],0FFh
	pop	si
	pop	di
	leave
	retf

;; fn0800_4725: 0800:4725
;;   Called from:
;;     0800:50A8 (in fn0800_481C)
;;     0800:5128 (in fn0800_481C)
fn0800_4725 proc
	push	bp
	mov	bp,sp
	mov	ax,4h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[362Ah]
	mov	si,es:[0FF1Eh]

l0800_473B:
	dec	si
	cmp	si,0h
	jge	4744h

l0800_4741:
	jmp	47A5h

l0800_4744:
	mov	es,[362Ch]
	mov	bx,si
	shl	bx,2h
	mov	ax,es:[bx+0F22Eh]
	mov	dx,es:[bx+0F230h]
	add	ax,26h
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	mov	di,6h

l0800_4763:
	dec	di
	cmp	di,0h
	jge	476Ch

l0800_4769:
	jmp	47A2h

l0800_476C:
	les	bx,[bp-4h]
	mov	al,[bp+6h]
	cmp	es:[bx+di],al
	jz	477Ah

l0800_4777:
	jmp	478Bh

l0800_477A:
	push	word ptr [bp-2h]
	push	word ptr [bp-4h]
	push	word ptr [bp+6h]
	call	far 0800h:46ECh
	add	sp,6h

l0800_478B:
	les	bx,[bp-4h]
	mov	al,[bp+6h]
	cmp	es:[bx+di],al
	jg	4799h

l0800_4796:
	jmp	479Fh

l0800_4799:
	les	bx,[bp-4h]
	dec	byte ptr es:[bx+di]

l0800_479F:
	jmp	4763h

l0800_47A2:
	jmp	473Bh

l0800_47A5:
	mov	es,[362Ah]
	mov	si,es:[0FF28h]

l0800_47AE:
	dec	si
	cmp	si,0h
	jge	47B7h

l0800_47B4:
	jmp	4818h

l0800_47B7:
	mov	es,[3630h]
	mov	bx,si
	shl	bx,2h
	mov	ax,es:[bx+0FBCAh]
	mov	dx,es:[bx+0FBCCh]
	add	ax,58h
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	mov	di,6h

l0800_47D6:
	dec	di
	cmp	di,0h
	jge	47DFh

l0800_47DC:
	jmp	4815h

l0800_47DF:
	les	bx,[bp-4h]
	mov	al,[bp+6h]
	cmp	es:[bx+di],al
	jz	47EDh

l0800_47EA:
	jmp	47FEh

l0800_47ED:
	push	word ptr [bp-2h]
	push	word ptr [bp-4h]
	push	word ptr [bp+6h]
	call	far 0800h:46ECh
	add	sp,6h

l0800_47FE:
	les	bx,[bp-4h]
	mov	al,[bp+6h]
	cmp	es:[bx+di],al
	jg	480Ch

l0800_4809:
	jmp	4812h

l0800_480C:
	les	bx,[bp-4h]
	dec	byte ptr es:[bx+di]

l0800_4812:
	jmp	47D6h

l0800_4815:
	jmp	47AEh

l0800_4818:
	pop	si
	pop	di
	leave
	retf

;; fn0800_481C: 0800:481C
;;   Called from:
;;     0800:37F2 (in main)
;;     1054:126C (in fn1054_0DB3)
fn0800_481C proc
	push	bp
	mov	bp,sp
	mov	ax,34h
	call	far 149Ah:02C8h
	push	di
	push	si
	push	1Ch
	push	180Ah
	push	0FF1Eh
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h
	push	0h
	mov	es,[362Ah]
	push	word ptr es:[0FF24h]
	push	word ptr es:[0FF22h]
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:1DEAh
	add	sp,8h
	mov	es,[362Ah]
	mov	ax,es:[0FF20h]
	mov	[bp-34h],ax
	mov	ax,es:[0FF1Eh]
	mov	[bp-14h],ax
	mov	ax,es:[0FF28h]
	mov	[bp-6h],ax
	mov	ax,es:[0FF2Ah]
	mov	[bp-2h],ax
	mov	ax,es:[0FF2Ch]
	mov	[bp-8h],ax
	mov	si,0h

l0800_488D:
	cmp	[bp-14h],si
	jg	4895h

l0800_4892:
	jmp	4A90h

l0800_4895:
	push	38h
	call	far 149Ah:22A2h
	add	sp,2h
	mov	[bp-32h],ax
	mov	[bp-30h],dx
	mov	ax,[bp-30h]
	or	ax,[bp-32h]
	jz	48B0h

l0800_48AD:
	jmp	48C6h

l0800_48B0:
	push	ds
	push	167Eh
	call	far 149Ah:0ABCh
	add	sp,4h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_48C6:
	mov	es,[362Ah]
	cmp	word ptr es:[0FF2Eh],0ABCDh
	jnz	48D6h

l0800_48D3:
	jmp	4992h

l0800_48D6:
	push	2Ah
	push	180Ah
	push	0A7F8h
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h
	push	180Ah
	push	0A7F8h
	push	word ptr [bp-30h]
	push	word ptr [bp-32h]
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[3722h]
	mov	ax,es:[0A80Ch]
	les	bx,[bp-32h]
	mov	es:[bx+16h],ax
	mov	es,[3722h]
	mov	ax,es:[0A80Eh]
	les	bx,[bp-32h]
	mov	es:[bx+18h],ax
	mov	es,[3722h]
	mov	ax,es:[0A808h]
	les	bx,[bp-32h]
	mov	es:[bx+12h],ax
	mov	es,[3722h]
	mov	ax,es:[0A80Ah]
	les	bx,[bp-32h]
	mov	es:[bx+14h],ax
	mov	es,[3722h]
	mov	al,es:[0A810h]
	cbw
	les	bx,[bp-32h]
	mov	es:[bx+1Ah],ax
	mov	es,[3722h]
	mov	ax,es:[0A812h]
	mov	dx,es:[0A814h]
	les	bx,[bp-32h]
	mov	es:[bx+1Ch],ax
	mov	es:[bx+1Eh],dx
	mov	ax,0FFFFh
	les	bx,[bp-32h]
	mov	es:[bx+2Eh],ax
	les	bx,[bp-32h]
	mov	es:[bx+30h],ax
	mov	di,6h

l0800_497B:
	dec	di
	cmp	di,0h
	jge	4984h

l0800_4981:
	jmp	498Fh

l0800_4984:
	les	bx,[bp-32h]
	mov	byte ptr es:[bx+di+26h],0FFh
	jmp	497Bh

l0800_498F:
	jmp	4A45h

l0800_4992:
	push	38h
	push	word ptr [bp-30h]
	push	word ptr [bp-32h]
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h
	mov	es,[362Ah]
	cmp	word ptr es:[0FF26h],60Ah
	jl	49BBh

l0800_49B8:
	jmp	49C4h

l0800_49BB:
	les	bx,[bp-32h]
	mov	word ptr es:[bx+2Eh],0FFFFh

l0800_49C4:
	mov	es,[362Ah]
	cmp	word ptr es:[0FF26h],61Dh
	jl	49D4h

l0800_49D1:
	jmp	49DDh

l0800_49D4:
	les	bx,[bp-32h]
	mov	word ptr es:[bx+30h],0FFFFh

l0800_49DD:
	mov	es,[362Ah]
	cmp	word ptr es:[0FF26h],632h
	jl	49EDh

l0800_49EA:
	jmp	4A1Eh

l0800_49ED:
	mov	di,6h

l0800_49F0:
	dec	di
	cmp	di,0h
	jge	49F9h

l0800_49F6:
	jmp	4A04h

l0800_49F9:
	les	bx,[bp-32h]
	mov	byte ptr es:[bx+di+26h],0FFh
	jmp	49F0h

l0800_4A04:
	push	1h
	push	0FFh
	push	0FAh
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:1DEAh
	add	sp,8h
	jmp	4A45h

l0800_4A1E:
	mov	es,[362Ah]
	cmp	word ptr es:[0FF26h],634h
	jge	4A2Eh

l0800_4A2B:
	jmp	4A45h

l0800_4A2E:
	push	1h
	push	0FFh
	push	0FAh
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:1DEAh
	add	sp,8h

l0800_4A45:
	les	bx,[bp-32h]
	and	word ptr es:[bx+10h],300h
	les	bx,[bp-32h]
	mov	word ptr es:[bx+2Ch],0FFFFh
	mov	es,[3626h]
	mov	ax,es:[0208h]
	les	bx,[bp-32h]
	mov	es:[bx+24h],ax
	les	bx,[bp-32h]
	sub	ax,ax
	mov	es:[bx+22h],ax
	mov	es:[bx+20h],ax
	mov	ax,[bp-32h]
	mov	dx,[bp-30h]
	mov	es,[362Ch]
	mov	bx,si
	shl	bx,2h
	mov	es:[bx+0F22Eh],ax
	mov	es:[bx+0F230h],dx
	inc	si
	jmp	488Dh

l0800_4A90:
	mov	di,3h

l0800_4A93:
	cmp	[bp-34h],di
	jg	4A9Bh

l0800_4A98:
	jmp	4BF9h

l0800_4A9B:
	push	20h
	call	far 149Ah:22A2h
	add	sp,2h
	mov	es,[362Eh]
	mov	bx,di
	shl	bx,2h
	mov	es:[bx+2C64h],ax
	mov	es:[bx+2C66h],dx
	mov	bx,di
	shl	bx,2h
	mov	ax,es:[bx+2C66h]
	or	ax,es:[bx+2C64h]
	jz	4ACCh

l0800_4AC9:
	jmp	4AE2h

l0800_4ACC:
	push	ds
	push	16A4h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_4AE2:
	mov	es,[362Ah]
	cmp	word ptr es:[0FF26h],632h
	jge	4AF2h

l0800_4AEF:
	jmp	4AFEh

l0800_4AF2:
	cmp	word ptr es:[0FF26h],634h
	jge	4AFEh

l0800_4AFB:
	jmp	4BA9h

l0800_4AFE:
	push	1Ah
	lea	ax,[bp-2Eh]
	push	ss
	push	ax
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h
	lea	ax,[bp-2Eh]
	push	ss
	push	ax
	mov	es,[362Eh]
	mov	bx,di
	shl	bx,2h
	push	word ptr es:[bx+2C66h]
	push	word ptr es:[bx+2C64h]
	call	far 149Ah:25AEh
	add	sp,8h
	mov	al,[bp-23h]
	mov	es,[362Eh]
	mov	bx,di
	shl	bx,2h
	les	bx,es:[bx+2C64h]
	mov	es:[bx+0Bh],al
	mov	ax,[bp-22h]
	mov	es,[362Eh]
	mov	bx,di
	shl	bx,2h
	les	bx,es:[bx+2C64h]
	mov	es:[bx+0Ch],ax
	mov	ax,[bp-20h]
	mov	dx,[bp-1Eh]
	mov	es,[362Eh]
	mov	bx,di
	shl	bx,2h
	les	bx,es:[bx+2C64h]
	mov	es:[bx+0Eh],ax
	mov	es:[bx+10h],dx
	mov	al,[bp-17h]
	mov	es,[362Eh]
	mov	bx,di
	shl	bx,2h
	les	bx,es:[bx+2C64h]
	mov	es:[bx+19h],al
	mov	al,[bp-24h]
	mov	es,[362Eh]
	mov	bx,di
	shl	bx,2h
	les	bx,es:[bx+2C64h]
	mov	es:[bx+0Ah],al
	jmp	4BCFh

l0800_4BA9:
	push	20h
	mov	es,[362Eh]
	mov	bx,di
	shl	bx,2h
	push	word ptr es:[bx+2C66h]
	push	word ptr es:[bx+2C64h]
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h

l0800_4BCF:
	mov	es,[362Eh]
	mov	bx,di
	shl	bx,2h
	les	bx,es:[bx+2C64h]
	mov	byte ptr es:[bx+0Ah],0h
	mov	es,[362Eh]
	mov	bx,di
	shl	bx,2h
	les	bx,es:[bx+2C64h]
	and	byte ptr es:[bx+19h],0Fh
	inc	di
	jmp	4A93h

l0800_4BF9:
	mov	es,[362Ah]
	cmp	word ptr es:[0FF2Eh],0ABCDh
	jz	4C09h

l0800_4C06:
	jmp	4FF5h

l0800_4C09:
	cmp	word ptr [bp-6h],0h
	jnz	4C12h

l0800_4C0F:
	jmp	4D48h

l0800_4C12:
	mov	word ptr [bp-12h],0h
	jmp	4C1Dh

l0800_4C1A:
	inc	word ptr [bp-12h]

l0800_4C1D:
	mov	ax,[bp-6h]
	cmp	[bp-12h],ax
	jl	4C28h

l0800_4C25:
	jmp	4D48h

l0800_4C28:
	push	62h
	call	far 149Ah:22A2h
	add	sp,2h
	mov	es,[3630h]
	mov	bx,[bp-12h]
	shl	bx,2h
	mov	es:[bx+0FBCAh],ax
	mov	es:[bx+0FBCCh],dx
	mov	bx,[bp-12h]
	shl	bx,2h
	mov	ax,es:[bx+0FBCCh]
	or	ax,es:[bx+0FBCAh]
	jz	4C5Bh

l0800_4C58:
	jmp	4C6Dh

l0800_4C5B:
	push	word ptr [bp-12h]
	push	ds
	push	16BCh
	call	far 149Ah:0ABCh
	add	sp,6h
	jmp	4C1Ah

l0800_4C6D:
	mov	es,[3630h]
	mov	bx,[bp-12h]
	shl	bx,2h
	push	word ptr es:[bx+0FBCCh]
	push	word ptr es:[bx+0FBCAh]
	call	far 0800h:44E1h
	add	sp,4h
	mov	es,[3630h]
	mov	bx,[bp-12h]
	shl	bx,2h
	les	bx,es:[bx+0FBCAh]
	mov	si,es:[bx+12h]

l0800_4C9C:
	dec	si
	cmp	si,0h
	jge	4CA5h

l0800_4CA2:
	jmp	4D45h

l0800_4CA5:
	push	12h
	call	far 149Ah:22A2h
	add	sp,2h
	mov	cx,si
	shl	cx,2h
	mov	es,[3630h]
	mov	bx,[bp-12h]
	shl	bx,2h
	les	bx,es:[bx+0FBCAh]
	add	bx,cx
	mov	es:[bx+14h],ax
	mov	es:[bx+16h],dx
	mov	ax,si
	shl	ax,2h
	mov	es,[3630h]
	mov	bx,[bp-12h]
	shl	bx,2h
	les	bx,es:[bx+0FBCAh]
	add	bx,14h
	add	bx,ax
	mov	ax,es:[bx+2h]
	or	ax,es:[bx]
	jz	4CF2h

l0800_4CEF:
	jmp	4D18h

l0800_4CF2:
	push	si
	push	word ptr [bp-12h]
	push	ds
	push	16D9h
	call	far 149Ah:0ABCh
	add	sp,8h
	mov	es,[3630h]
	mov	bx,[bp-12h]
	shl	bx,2h
	les	bx,es:[bx+0FBCAh]
	mov	es:[bx+12h],si
	jmp	4D45h

l0800_4D18:
	push	0h
	mov	ax,si
	shl	ax,2h
	mov	es,[3630h]
	mov	bx,[bp-12h]
	shl	bx,2h
	les	bx,es:[bx+0FBCAh]
	add	bx,14h
	add	bx,ax
	push	word ptr es:[bx+2h]
	push	word ptr es:[bx]
	call	far 0800h:45DCh
	add	sp,6h
	jmp	4C9Ch

l0800_4D45:
	jmp	4C1Ah

l0800_4D48:
	cmp	word ptr [bp-2h],0h
	jnz	4D51h

l0800_4D4E:
	jmp	4E87h

l0800_4D51:
	mov	word ptr [bp-12h],0h
	jmp	4D5Ch

l0800_4D59:
	inc	word ptr [bp-12h]

l0800_4D5C:
	mov	ax,[bp-12h]
	cmp	[bp-2h],ax
	jg	4D67h

l0800_4D64:
	jmp	4E87h

l0800_4D67:
	push	62h
	call	far 149Ah:22A2h
	add	sp,2h
	mov	es,[3632h]
	mov	bx,[bp-12h]
	shl	bx,2h
	mov	es:[bx+0FDD8h],ax
	mov	es:[bx+0FDDAh],dx
	mov	bx,[bp-12h]
	shl	bx,2h
	mov	ax,es:[bx+0FDDAh]
	or	ax,es:[bx+0FDD8h]
	jz	4D9Ah

l0800_4D97:
	jmp	4DACh

l0800_4D9A:
	push	word ptr [bp-12h]
	push	ds
	push	1700h
	call	far 149Ah:0ABCh
	add	sp,6h
	jmp	4D59h

l0800_4DAC:
	mov	es,[3632h]
	mov	bx,[bp-12h]
	shl	bx,2h
	push	word ptr es:[bx+0FDDAh]
	push	word ptr es:[bx+0FDD8h]
	call	far 0800h:44E1h
	add	sp,4h
	mov	es,[3632h]
	mov	bx,[bp-12h]
	shl	bx,2h
	les	bx,es:[bx+0FDD8h]
	mov	si,es:[bx+12h]

l0800_4DDB:
	dec	si
	cmp	si,0h
	jge	4DE4h

l0800_4DE1:
	jmp	4E84h

l0800_4DE4:
	push	12h
	call	far 149Ah:22A2h
	add	sp,2h
	mov	cx,si
	shl	cx,2h
	mov	es,[3632h]
	mov	bx,[bp-12h]
	shl	bx,2h
	les	bx,es:[bx+0FDD8h]
	add	bx,cx
	mov	es:[bx+14h],ax
	mov	es:[bx+16h],dx
	mov	ax,si
	shl	ax,2h
	mov	es,[3632h]
	mov	bx,[bp-12h]
	shl	bx,2h
	les	bx,es:[bx+0FDD8h]
	add	bx,14h
	add	bx,ax
	mov	ax,es:[bx+2h]
	or	ax,es:[bx]
	jz	4E31h

l0800_4E2E:
	jmp	4E57h

l0800_4E31:
	push	si
	push	word ptr [bp-12h]
	push	ds
	push	171Bh
	call	far 149Ah:0ABCh
	add	sp,8h
	mov	es,[3632h]
	mov	bx,[bp-12h]
	shl	bx,2h
	les	bx,es:[bx+0FDD8h]
	mov	es:[bx+12h],si
	jmp	4E84h

l0800_4E57:
	push	1h
	mov	ax,si
	shl	ax,2h
	mov	es,[3632h]
	mov	bx,[bp-12h]
	shl	bx,2h
	les	bx,es:[bx+0FDD8h]
	add	bx,14h
	add	bx,ax
	push	word ptr es:[bx+2h]
	push	word ptr es:[bx]
	call	far 0800h:45DCh
	add	sp,6h
	jmp	4DDBh

l0800_4E84:
	jmp	4D59h

l0800_4E87:
	mov	es,[362Ah]
	cmp	word ptr es:[0FF26h],60Ah
	jge	4E97h

l0800_4E94:
	jmp	4F10h

l0800_4E97:
	mov	si,0h
	jmp	4E9Eh

l0800_4E9D:
	inc	si

l0800_4E9E:
	cmp	[bp-14h],si
	jg	4EA6h

l0800_4EA3:
	jmp	4F10h

l0800_4EA6:
	mov	es,[362Ch]
	mov	bx,si
	shl	bx,2h
	les	bx,es:[bx+0F22Eh]
	cmp	word ptr es:[bx+2Eh],0h
	jge	4EBEh

l0800_4EBB:
	jmp	4F0Dh

l0800_4EBE:
	call	far 0800h:445Ah
	mov	[bp-4h],ax
	cmp	ax,0h
	jl	4ECEh

l0800_4ECB:
	jmp	4ED1h

l0800_4ECE:
	jmp	4F10h

l0800_4ED1:
	push	28h
	mov	es,[3720h]
	mov	bx,[bp-4h]
	shl	bx,2h
	push	word ptr es:[bx+232h]
	push	word ptr es:[bx+230h]
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h
	mov	ax,[bp-4h]
	mov	es,[362Ch]
	mov	bx,si
	shl	bx,2h
	les	bx,es:[bx+0F22Eh]
	mov	es:[bx+2Eh],ax

l0800_4F0D:
	jmp	4E9Dh

l0800_4F10:
	mov	es,[362Ah]
	cmp	word ptr es:[0FF26h],61Dh
	jge	4F20h

l0800_4F1D:
	jmp	4FF5h

l0800_4F20:
	mov	si,0h
	jmp	4F27h

l0800_4F26:
	inc	si

l0800_4F27:
	cmp	[bp-14h],si
	jg	4F2Fh

l0800_4F2C:
	jmp	4FF5h

l0800_4F2F:
	mov	es,[362Ch]
	mov	bx,si
	shl	bx,2h
	les	bx,es:[bx+0F22Eh]
	cmp	word ptr es:[bx+30h],0h
	jge	4F47h

l0800_4F44:
	jmp	4FF2h

l0800_4F47:
	push	10h
	call	far 149Ah:22C1h
	add	sp,2h
	mov	es,[36BCh]
	mov	bx,es:[2C38h]
	shl	bx,2h
	mov	es,[3724h]
	mov	es:[bx+4CD4h],ax
	mov	es:[bx+4CD6h],dx
	mov	es,[36BCh]
	mov	bx,es:[2C38h]
	shl	bx,2h
	mov	es,[3724h]
	mov	ax,es:[bx+4CD6h]
	or	ax,es:[bx+4CD4h]
	jz	4F8Ah

l0800_4F87:
	jmp	4FA2h

l0800_4F8A:
	mov	es,[36BCh]
	push	word ptr es:[2C38h]
	push	ds
	push	1740h
	call	far 149Ah:0ABCh
	add	sp,6h
	jmp	4FF5h

l0800_4FA2:
	push	10h
	mov	es,[36BCh]
	mov	bx,es:[2C38h]
	shl	bx,2h
	mov	es,[3724h]
	push	word ptr es:[bx+4CD6h]
	push	word ptr es:[bx+4CD4h]
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h
	mov	es,[36BCh]
	mov	ax,es:[2C38h]
	mov	es,[362Ch]
	mov	bx,si
	shl	bx,2h
	les	bx,es:[bx+0F22Eh]
	mov	es:[bx+30h],ax
	mov	es,[36BCh]
	inc	word ptr es:[2C38h]

l0800_4FF2:
	jmp	4F26h

l0800_4FF5:
	mov	es,[362Ah]
	cmp	word ptr es:[0FF26h],632h
	jl	5005h

l0800_5002:
	jmp	500Ch

l0800_5005:
	mov	word ptr es:[0FF2Ch],0h

l0800_500C:
	mov	word ptr [bp-0Eh],0h
	mov	es,[362Ah]
	cmp	word ptr es:[0FF2Ch],0h
	jg	5020h

l0800_501D:
	jmp	5143h

l0800_5020:
	mov	ax,es:[0FF2Ch]
	shl	ax,2h
	push	ax
	mov	es,[365Eh]
	push	word ptr es:[0A7E2h]
	push	word ptr es:[0A7E0h]
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h
	mov	es,[365Eh]
	mov	ax,es:[0A7E0h]
	mov	dx,es:[0A7E2h]
	mov	[bp-0Ch],ax
	mov	[bp-0Ah],dx

l0800_505A:
	mov	ax,[bp-8h]
	cmp	[bp-0Eh],ax
	jl	5065h

l0800_5062:
	jmp	5143h

l0800_5065:
	les	bx,[bp-0Ch]
	add	word ptr [bp-0Ch],2h
	mov	ax,es:[bx]
	mov	[bp-10h],ax
	cmp	word ptr [bp-10h],40h
	jnz	507Bh

l0800_5078:
	jmp	5084h

l0800_507B:
	cmp	word ptr [bp-10h],0h
	jz	5084h

l0800_5081:
	jmp	5113h

l0800_5084:
	les	bx,[bp-0Ch]
	cmp	word ptr es:[bx],0h
	jl	5090h

l0800_508D:
	jmp	50BFh

l0800_5090:
	push	word ptr [bp-0Eh]
	les	bx,[bp-0Ch]
	push	word ptr es:[bx]
	push	ds
	push	176Ch
	call	far 149Ah:0ABCh
	add	sp,8h
	push	word ptr [bp-0Eh]
	call	far 0800h:4725h
	add	sp,2h
	dec	word ptr [bp-8h]
	mov	es,[362Ah]
	dec	word ptr es:[0FF2Ch]
	jmp	5110h

l0800_50BF:
	cmp	word ptr [bp-10h],0h
	jnz	50C8h

l0800_50C5:
	jmp	50E2h

l0800_50C8:
	les	bx,[bp-0Ch]
	mov	bx,es:[bx]
	shl	bx,2h
	mov	es,[3630h]
	mov	ax,es:[bx+0FBCAh]
	mov	dx,es:[bx+0FBCCh]
	jmp	50F9h

l0800_50E2:
	les	bx,[bp-0Ch]
	mov	bx,es:[bx]
	shl	bx,2h
	mov	es,[3632h]
	mov	ax,es:[bx+0FDD8h]
	mov	dx,es:[bx+0FDDAh]

l0800_50F9:
	mov	es,[3726h]
	mov	bx,[bp-0Eh]
	shl	bx,2h
	mov	es:[bx+0h],ax
	mov	es:[bx+2h],dx
	inc	word ptr [bp-0Eh]

l0800_5110:
	jmp	513Ch

l0800_5113:
	push	word ptr [bp-0Eh]
	push	word ptr [bp-10h]
	push	ds
	push	178Ch
	call	far 149Ah:0ABCh
	add	sp,8h
	push	word ptr [bp-0Eh]
	call	far 0800h:4725h
	add	sp,2h
	dec	word ptr [bp-8h]
	mov	es,[362Ah]
	dec	word ptr es:[0FF2Ch]

l0800_513C:
	add	word ptr [bp-0Ch],2h
	jmp	505Ah

l0800_5143:
	mov	ax,0h
	jmp	5149h

l0800_5149:
	pop	si
	pop	di
	leave
	retf

;; fn0800_514D: 0800:514D
;;   Called from:
;;     0800:224B (in main)
fn0800_514D proc
	push	bp
	mov	bp,sp
	mov	ax,0Ah
	call	far 149Ah:02C8h
	push	di
	push	si
	push	2Ch
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	or	dx,ax
	jz	517Fh

l0800_517C:
	jmp	51ACh

l0800_517F:
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:260Eh
	add	sp,4h
	mov	es,[3702h]
	add	ax,es:[0A7D6h]
	mov	dx,es:[0A7D8h]
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	jmp	51B6h

l0800_51AC:
	les	bx,[bp-0Ah]
	inc	word ptr [bp-0Ah]
	mov	byte ptr es:[bx],0h

l0800_51B6:
	mov	es,[3728h]
	mov	word ptr es:[1738h],0h
	push	3Ah
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-6h],ax
	mov	[bp-4h],dx
	or	dx,ax
	jnz	51E6h

l0800_51E3:
	jmp	523Bh

l0800_51E6:
	mov	ax,[bp-0Ah]
	cmp	[bp-6h],ax
	jc	51F1h

l0800_51EE:
	jmp	523Bh

l0800_51F1:
	les	bx,[bp-6h]
	inc	word ptr [bp-6h]
	mov	byte ptr es:[bx],0h

l0800_51FB:
	les	bx,[bp-6h]
	cmp	byte ptr es:[bx],0h
	jnz	5207h

l0800_5204:
	jmp	523Bh

l0800_5207:
	les	bx,[bp-6h]
	cmp	byte ptr es:[bx],2Bh
	jnz	5213h

l0800_5210:
	jmp	523Bh

l0800_5213:
	les	bx,[bp-6h]
	inc	word ptr [bp-6h]
	mov	al,es:[bx]
	cbw
	mov	es,[3728h]
	mov	cx,es:[1738h]
	mov	dx,cx
	shl	cx,2h
	add	cx,dx
	shl	cx,1h
	add	ax,cx
	sub	ax,30h
	mov	es:[1738h],ax
	jmp	51FBh

l0800_523B:
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	call	far 149Ah:260Eh
	add	sp,4h
	mov	es,[3702h]
	add	ax,es:[0A7D6h]
	mov	dx,es:[0A7D8h]
	dec	ax
	mov	[bp-6h],ax
	mov	[bp-4h],dx
	les	bx,[bp-6h]
	cmp	byte ptr es:[bx-1h],2Ah
	jz	5273h

l0800_5270:
	jmp	5278h

l0800_5273:
	mov	al,1h
	jmp	527Ah

l0800_5278:
	mov	al,0h

l0800_527A:
	mov	es,[372Ah]
	mov	es:[0C76Ah],al
	cmp	byte ptr es:[0C76Ah],0h
	jnz	528Dh

l0800_528A:
	jmp	52A5h

l0800_528D:
	les	bx,[bp-6h]
	mov	al,es:[bx]
	sub	al,31h
	mov	es,[372Ah]
	mov	es:[0C76Ah],al
	les	bx,[bp-6h]
	mov	byte ptr es:[bx-1h],0h

l0800_52A5:
	mov	es,[372Ah]
	cmp	byte ptr es:[0C76Ah],3h
	jg	52B4h

l0800_52B1:
	jmp	52E1h

l0800_52B4:
	mov	al,es:[0C76Ah]
	cbw
	add	ax,31h
	push	ax
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	push	ds
	push	17ABh
	call	far 149Ah:0ABCh
	add	sp,0Ah
	mov	es,[372Ah]
	mov	byte ptr es:[0C76Ah],3h

l0800_52E1:
	mov	es,[362Ah]
	mov	ax,es:[0FF1Eh]
	mov	[bp-2h],ax

l0800_52EC:
	dec	word ptr [bp-2h]
	cmp	word ptr [bp-2h],0h
	jge	52F8h

l0800_52F5:
	jmp	5330h

l0800_52F8:
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	mov	es,[362Ch]
	mov	bx,[bp-2h]
	shl	bx,2h
	push	word ptr es:[bx+0F230h]
	push	word ptr es:[bx+0F22Eh]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	532Ah

l0800_5327:
	jmp	532Dh

l0800_532A:
	jmp	5330h

l0800_532D:
	jmp	52ECh

l0800_5330:
	cmp	word ptr [bp-2h],0h
	jl	5339h

l0800_5336:
	jmp	5362h

l0800_5339:
	mov	es,[36BAh]
	inc	word ptr es:[0212h]
	push	180Ah
	push	0FEDAh
	mov	es,[3702h]
	push	word ptr es:[0A7D8h]
	push	word ptr es:[0A7D6h]
	push	ds
	push	17DCh
	call	far 149Ah:0ABCh
	add	sp,0Ch

l0800_5362:
	mov	ax,[bp-0Ah]
	mov	dx,[bp-8h]
	mov	es,[3702h]
	mov	es:[0A7D6h],ax
	mov	es:[0A7D8h],dx
	mov	ax,[bp-2h]
	jmp	537Bh

l0800_537B:
	pop	si
	pop	di
	leave
	retf

;; fn0800_537F: 0800:537F
;;   Called from:
;;     0800:5D4B (in fn0800_550A)
fn0800_537F proc
	push	bp
	mov	bp,sp
	mov	ax,0Ah
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	ax,[bp+0Ch]
	imul	word ptr [bp+0Ah]
	mov	[bp-2h],ax
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	add	ax,[bp-2h]
	mov	[bp-6h],ax
	mov	[bp-4h],dx
	mov	ax,[bp+0Ch]
	shl	ax,2h
	add	ax,[bp-6h]
	mov	dx,[bp-4h]
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	mov	si,[bp+0Ch]

l0800_53B9:
	dec	si
	cmp	si,0h
	jge	53C2h

l0800_53BF:
	jmp	540Eh

l0800_53C2:
	dec	word ptr [bp-0Ah]
	les	bx,[bp-0Ah]
	mov	byte ptr es:[bx],0h
	dec	word ptr [bp-0Ah]
	les	bx,[bp-0Ah]
	mov	byte ptr es:[bx],0h
	dec	word ptr [bp-0Ah]
	les	bx,[bp-0Ah]
	mov	byte ptr es:[bx],0h
	dec	word ptr [bp-0Ah]
	les	bx,[bp-0Ah]
	mov	byte ptr es:[bx],0h
	mov	di,[bp+0Ah]

l0800_53ED:
	dec	di
	cmp	di,0h
	jge	53F6h

l0800_53F3:
	jmp	540Bh

l0800_53F6:
	dec	word ptr [bp-6h]
	les	bx,[bp-6h]
	mov	al,es:[bx]
	dec	word ptr [bp-0Ah]
	les	bx,[bp-0Ah]
	mov	es:[bx],al
	jmp	53EDh

l0800_540B:
	jmp	53B9h

l0800_540E:
	pop	si
	pop	di
	leave
	retf

;; fn0800_5412: 0800:5412
;;   Called from:
;;     0800:5DA7 (in fn0800_550A)
fn0800_5412 proc
	push	bp
	mov	bp,sp
	mov	ax,6h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	ax,[bp+0Ch]
	imul	word ptr [bp+0Ah]
	mov	[bp-2h],ax
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	add	ax,[bp-2h]
	mov	[bp-6h],ax
	mov	[bp-4h],dx
	mov	si,[bp+0Ah]

l0800_543A:
	dec	si
	cmp	si,0h
	jge	5443h

l0800_5440:
	jmp	5450h

l0800_5443:
	les	bx,[bp-6h]
	inc	word ptr [bp-6h]
	mov	byte ptr es:[bx],0h
	jmp	543Ah

l0800_5450:
	pop	si
	pop	di
	leave
	retf

;; fn0800_5454: 0800:5454
;;   Called from:
;;     0800:6416 (in fn0800_550A)
;;     0800:647D (in fn0800_550A)
;;     0800:6521 (in fn0800_550A)
;;     0800:6588 (in fn0800_550A)
;;     0800:65EF (in fn0800_550A)
;;     0800:665A (in fn0800_550A)
;;     0800:66F6 (in fn0800_550A)
;;     0800:677A (in fn0800_550A)
;;     0800:6803 (in fn0800_550A)
;;     0800:686A (in fn0800_550A)
;;     0800:6961 (in fn0800_550A)
;;     0800:69BE (in fn0800_550A)
;;     0800:6AA3 (in fn0800_550A)
fn0800_5454 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	cmp	byte ptr [bp+6h],42h
	jz	546Ah

l0800_5467:
	jmp	5472h

l0800_546A:
	mov	ax,1806h
	mov	dx,ds
	jmp	549Ch

l0800_5472:
	cmp	byte ptr [bp+6h],57h
	jz	547Bh

l0800_5478:
	jmp	5483h

l0800_547B:
	mov	ax,180Bh
	mov	dx,ds
	jmp	549Ch

l0800_5483:
	cmp	byte ptr [bp+6h],4Ch
	jz	548Ch

l0800_5489:
	jmp	5494h

l0800_548C:
	mov	ax,1810h
	mov	dx,ds
	jmp	549Ch

l0800_5494:
	mov	ax,1815h
	mov	dx,ds
	jmp	549Ch

l0800_549C:
	pop	si
	pop	di
	leave
	retf

;; fn0800_54A0: 0800:54A0
;;   Called from:
;;     0800:6E66 (in fn0800_550A)
fn0800_54A0 proc
	push	bp
	mov	bp,sp
	mov	ax,4h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	cl,[bp+0Eh]
	mov	si,1h
	shl	si,cl
	lea	si,[si-1h]
	cmp	word ptr [bp+0Ah],0h
	jg	54C1h

l0800_54BE:
	jmp	54C6h

l0800_54C1:
	mov	ax,si
	jmp	54CAh

l0800_54C6:
	mov	ax,si
	neg	ax

l0800_54CA:
	mov	[bp-2h],ax
	mov	cl,[bp+0Eh]
	mov	ax,[bp+0Ah]
	add	ax,[bp-2h]
	sar	ax,cl
	les	bx,[bp+6h]
	mov	es:[bx+12h],ax
	cmp	word ptr [bp+0Ch],0h
	jg	54E8h

l0800_54E5:
	jmp	54EDh

l0800_54E8:
	mov	ax,si
	jmp	54F1h

l0800_54ED:
	mov	ax,si
	neg	ax

l0800_54F1:
	mov	[bp-4h],ax
	mov	cl,[bp+0Eh]
	mov	ax,[bp+0Ch]
	add	ax,[bp-4h]
	sar	ax,cl
	les	bx,[bp+6h]
	mov	es:[bx+14h],ax
	pop	si
	pop	di
	leave
	retf

;; fn0800_550A: 0800:550A
;;   Called from:
;;     0800:2275 (in main)
;;     1054:06B8 (in fn1054_03DA)
;;     1054:147F (in fn1054_0DB3)
fn0800_550A proc
	push	bp
	mov	bp,sp
	mov	ax,8Eh
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	word ptr [bp-5Ch],0h
	mov	word ptr [bp-4Ah],0h
	mov	ax,0h
	mov	[bp-3Ah],ax
	mov	[bp-42h],ax
	les	bx,[bp+6h]
	mov	al,es:[bx]
	mov	[bp-5Eh],al
	mov	es,[36A0h]
	mov	al,es:[0232h]
	mov	[bp-34h],al
	mov	es,[36AAh]
	mov	al,es:[5B8Ch]
	mov	[bp-28h],al
	mov	es,[36C2h]
	mov	al,es:[172Ch]
	mov	[bp-0Eh],al
	les	bx,[bp+6h]
	mov	ax,es:[bx+12h]
	mov	[bp-70h],ax
	les	bx,[bp+6h]
	mov	ax,es:[bx+14h]
	mov	[bp-76h],ax
	mov	es,[372Ah]
	cmp	byte ptr es:[0C76Ah],0h
	jnz	5577h

l0800_5574:
	jmp	55B9h

l0800_5577:
	les	bx,[bp+6h]
	mov	ax,es:[bx+12h]
	mov	[bp+0FF7Ch],ax
	les	bx,[bp+6h]
	mov	ax,es:[bx+14h]
	mov	[bp-2h],ax
	mov	es,[36E4h]
	mov	al,es:[2C6Ah]
	mov	es,[372Ah]
	cmp	al,es:[0C76Ah]
	jg	55A2h

l0800_559F:
	jmp	55A6h

l0800_55A2:
	mov	al,es:[0C76Ah]

l0800_55A6:
	mov	[bp-12h],al
	mov	byte ptr es:[0C76Ah],1h
	mov	es,[36C2h]
	mov	byte ptr es:[172Ch],1h

l0800_55B9:
	mov	es,[36ACh]
	cmp	word ptr es:[0A7DEh],0h
	jnz	55C8h

l0800_55C5:
	jmp	568Ah

l0800_55C8:
	mov	word ptr [bp-48h],0h
	mov	di,0h
	les	bx,[bp+6h]
	cmp	word ptr es:[bx+2Eh],0h
	jge	55DDh

l0800_55DA:
	jmp	5641h

l0800_55DD:
	les	bx,[bp+6h]
	mov	ax,es:[bx+16h]
	mov	[bp-2Ch],ax
	les	bx,[bp+6h]
	mov	ax,es:[bx+18h]
	mov	[bp-32h],ax
	les	bx,[bp+6h]
	mov	bx,es:[bx+2Eh]
	shl	bx,2h
	mov	es,[3720h]
	mov	ax,es:[bx+230h]
	mov	dx,es:[bx+232h]
	add	ax,10h
	mov	[bp-1Eh],ax
	mov	[bp-1Ch],dx
	mov	ax,[bp-1Eh]
	mov	dx,[bp-1Ch]
	mov	[bp-5Ah],ax
	mov	[bp-58h],dx
	mov	si,0h

l0800_5621:
	inc	si
	cmp	si,5h
	jle	562Ah

l0800_5627:
	jmp	5641h

l0800_562A:
	les	bx,[bp-5Ah]
	add	word ptr [bp-5Ah],4h
	mov	ax,es:[bx+2h]
	or	ax,es:[bx]
	jnz	563Dh

l0800_563A:
	jmp	563Eh

l0800_563D:
	inc	di

l0800_563E:
	jmp	5621h

l0800_5641:
	cmp	di,0h
	jnz	5649h

l0800_5646:
	jmp	566Ch

l0800_5649:
	mov	word ptr [bp-5Ch],5h
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],1h
	jg	565Dh

l0800_565A:
	jmp	5669h

l0800_565D:
	push	ds
	push	181Ah
	call	far 149Ah:0ABCh
	add	sp,4h

l0800_5669:
	jmp	566Fh

l0800_566C:
	mov	di,1h

l0800_566F:
	push	di
	push	ds
	push	1820h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ah

l0800_568A:
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],1h
	jg	5699h

l0800_5696:
	jmp	56ABh

l0800_5699:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	182Bh
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_56AB:
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],2h
	jg	56BAh

l0800_56B7:
	jmp	56E2h

l0800_56BA:
	les	bx,[bp+6h]
	push	word ptr es:[bx+14h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+12h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+18h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+16h]
	push	ds
	push	1832h
	call	far 149Ah:0ABCh
	add	sp,0Ch

l0800_56E2:
	cmp	word ptr [bp-5Ch],0h
	jg	56EBh

l0800_56E8:
	jmp	57B0h

l0800_56EB:
	les	bx,[bp-1Eh]
	mov	ax,es:[bx+2h]
	or	ax,es:[bx]
	jz	56FAh

l0800_56F7:
	jmp	5701h

l0800_56FA:
	add	word ptr [bp-1Eh],4h
	jmp	6E99h

l0800_5701:
	les	bx,[bp-1Eh]
	inc	word ptr [bp-1Eh]
	mov	al,es:[bx]
	sub	ah,ah
	mov	[bp-3Ah],ax
	les	bx,[bp-1Eh]
	inc	word ptr [bp-1Eh]
	mov	al,es:[bx]
	sub	ah,ah
	mov	[bp-42h],ax
	les	bx,[bp-1Eh]
	inc	word ptr [bp-1Eh]
	mov	al,es:[bx]
	sub	ah,ah
	inc	ax
	mov	[bp-38h],ax
	les	bx,[bp-1Eh]
	inc	word ptr [bp-1Eh]
	mov	al,es:[bx]
	sub	ah,ah
	inc	ax
	mov	[bp-40h],ax
	cmp	word ptr [bp-38h],4h
	jl	5744h

l0800_5741:
	jmp	5756h

l0800_5744:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	184Ch
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_5756:
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],2h
	jg	5765h

l0800_5762:
	jmp	577Dh

l0800_5765:
	push	word ptr [bp-40h]
	push	word ptr [bp-38h]
	push	word ptr [bp-42h]
	push	word ptr [bp-3Ah]
	push	ds
	push	186Ah
	call	far 149Ah:0ABCh
	add	sp,0Ch

l0800_577D:
	mov	ax,[bp-2Ch]
	les	bx,[bp+6h]
	mov	es:[bx+16h],ax
	mov	ax,[bp-32h]
	les	bx,[bp+6h]
	mov	es:[bx+18h],ax
	mov	ax,[bp-70h]
	sub	ax,[bp-3Ah]
	les	bx,[bp+6h]
	mov	es:[bx+12h],ax
	mov	ax,[bp-76h]
	sub	ax,[bp-42h]
	les	bx,[bp+6h]
	mov	es:[bx+14h],ax
	mov	word ptr [bp-48h],1h

l0800_57B0:
	les	bx,[bp+6h]
	mov	bx,es:[bx+1Ah]
	shl	bx,2h
	mov	es,[362Eh]
	les	bx,es:[bx+2C64h]
	mov	ax,es:[bx+0Ch]
	mov	[bp-8h],ax
	mov	es,[36AEh]
	mov	ax,es:[2B6Eh]
	mov	[bp-14h],ax
	cmp	ax,0h
	jnz	57DDh

l0800_57DA:
	jmp	5827h

l0800_57DD:
	mov	cl,es:[2B6Eh]
	mov	ax,1h
	shl	ax,cl
	cmp	ax,[bp-8h]
	jl	57EFh

l0800_57EC:
	jmp	5827h

l0800_57EF:
	push	word ptr es:[2B6Eh]
	push	word ptr [bp-8h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	187Ch
	call	far 149Ah:0ABCh
	add	sp,0Ch
	les	bx,[bp+6h]
	mov	bx,es:[bx+1Ah]
	shl	bx,2h
	mov	es,[362Eh]
	les	bx,es:[bx+2C64h]
	mov	al,es:[bx+0Bh]
	cbw
	mov	[bp-14h],ax
	jmp	586Fh

l0800_5827:
	cmp	word ptr [bp-14h],0h
	jz	5830h

l0800_582D:
	jmp	586Fh

l0800_5830:
	les	bx,[bp+6h]
	mov	bx,es:[bx+1Ah]
	shl	bx,2h
	mov	es,[362Eh]
	les	bx,es:[bx+2C64h]
	mov	al,es:[bx+0Bh]
	cbw
	mov	[bp-14h],ax
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],1h
	jg	585Ah

l0800_5857:
	jmp	586Fh

l0800_585A:
	push	word ptr [bp-14h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	18B7h
	call	far 149Ah:0ABCh
	add	sp,0Ah

l0800_586F:
	les	bx,[bp+6h]
	cmp	word ptr es:[bx+16h],3h
	jc	587Ch

l0800_5879:
	jmp	58AFh

l0800_587C:
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],2h
	jg	588Bh

l0800_5888:
	jmp	58A6h

l0800_588B:
	push	3h
	les	bx,[bp+6h]
	push	word ptr es:[bx+16h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	18DCh
	call	far 149Ah:0ABCh
	add	sp,0Ch

l0800_58A6:
	les	bx,[bp+6h]
	mov	word ptr es:[bx+16h],3h

l0800_58AF:
	les	bx,[bp+6h]
	mov	ax,es:[bx+16h]
	mov	[bp-4Ch],ax
	les	bx,[bp+6h]
	mov	ax,es:[bx+16h]
	add	ax,3h
	and	ax,0FFFCh
	mov	[bp-22h],ax
	mov	es,[36C2h]
	cmp	byte ptr es:[172Ch],0h
	jnz	58D8h

l0800_58D5:
	jmp	58F3h

l0800_58D8:
	les	bx,[bp+6h]
	mov	ax,[bp-22h]
	cmp	es:[bx+16h],ax
	jz	58E7h

l0800_58E4:
	jmp	58EDh

l0800_58E7:
	mov	ax,1h
	jmp	58F0h

l0800_58ED:
	mov	ax,0h

l0800_58F0:
	mov	[bp-1Ah],ax

l0800_58F3:
	mov	es,[36C4h]
	cmp	byte ptr es:[063Ch],0h
	jnz	5902h

l0800_58FF:
	jmp	590Ch

l0800_5902:
	mov	ax,[bp-22h]
	les	bx,[bp+6h]
	mov	es:[bx+16h],ax

l0800_590C:
	les	bx,[bp+6h]
	mov	ax,es:[bx+18h]
	mul	word ptr [bp-22h]
	mov	[bp+0FF76h],ax
	mov	word ptr [bp+0FF78h],0h
	mov	es,[365Eh]
	mov	ax,es:[0A7E0h]
	mov	dx,es:[0A7E2h]
	les	bx,[bp+6h]
	mov	es:[bx+20h],ax
	mov	es:[bx+22h],dx
	push	0h
	les	bx,[bp+6h]
	push	word ptr es:[bx+1Eh]
	push	word ptr es:[bx+1Ch]
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:1DEAh
	add	sp,8h
	push	word ptr [bp+0FF76h]
	mov	es,[365Eh]
	push	word ptr es:[0A7E2h]
	push	word ptr es:[0A7E0h]
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h
	cmp	word ptr [bp-5Ch],0h
	jg	5982h

l0800_597F:
	jmp	5A3Bh

l0800_5982:
	les	bx,[bp+6h]
	mov	ax,es:[bx+20h]
	mov	dx,es:[bx+22h]
	mov	[bp-52h],ax
	mov	[bp-50h],dx
	mov	ax,[bp-42h]
	imul	word ptr [bp-22h]
	add	ax,[bp-52h]
	mov	dx,[bp-50h]
	add	ax,[bp-3Ah]
	mov	[bp-64h],ax
	mov	[bp-62h],dx
	mov	ax,[bp-38h]
	les	bx,[bp+6h]
	mov	es:[bx+16h],ax
	mov	ax,[bp-40h]
	les	bx,[bp+6h]
	mov	es:[bx+18h],ax
	mov	di,[bp-40h]

l0800_59BF:
	dec	di
	cmp	di,0h
	jge	59C8h

l0800_59C5:
	jmp	5A17h

l0800_59C8:
	mov	si,[bp-38h]

l0800_59CB:
	dec	si
	cmp	si,0h
	jge	59D4h

l0800_59D1:
	jmp	59E9h

l0800_59D4:
	les	bx,[bp-64h]
	inc	word ptr [bp-64h]
	mov	al,es:[bx]
	les	bx,[bp-52h]
	inc	word ptr [bp-52h]
	mov	es:[bx],al
	jmp	59CBh

l0800_59E9:
	mov	si,[bp-38h]
	add	si,3h
	and	si,0FCh
	sub	si,[bp-38h]

l0800_59F5:
	dec	si
	cmp	si,0h
	jge	59FEh

l0800_59FB:
	jmp	5A0Bh

l0800_59FE:
	les	bx,[bp-52h]
	inc	word ptr [bp-52h]
	mov	byte ptr es:[bx],0h
	jmp	59F5h

l0800_5A0B:
	mov	ax,[bp-22h]
	sub	ax,[bp-38h]
	add	[bp-64h],ax
	jmp	59BFh

l0800_5A17:
	les	bx,[bp+6h]
	mov	ax,es:[bx+16h]
	add	ax,3h
	and	ax,0FFFCh
	mov	[bp-22h],ax
	les	bx,[bp+6h]
	mov	ax,es:[bx+18h]
	mul	word ptr [bp-22h]
	mov	[bp+0FF76h],ax
	mov	word ptr [bp+0FF78h],0h

l0800_5A3B:
	mov	es,[3728h]
	cmp	word ptr es:[1738h],0h
	jnz	5A4Ah

l0800_5A47:
	jmp	5B90h

l0800_5A4A:
	mov	word ptr [bp-3Eh],0h
	les	bx,[bp+6h]
	mov	ax,es:[bx+20h]
	mov	dx,es:[bx+22h]
	mov	[bp-52h],ax
	mov	[bp-50h],dx
	les	bx,[bp+6h]
	mov	di,es:[bx+18h]

l0800_5A67:
	dec	di
	cmp	di,0h
	jge	5A70h

l0800_5A6D:
	jmp	5ABAh

l0800_5A70:
	mov	si,[bp-22h]
	jmp	5A79h

l0800_5A76:
	inc	word ptr [bp-52h]

l0800_5A79:
	dec	si
	cmp	si,0h
	jge	5A82h

l0800_5A7F:
	jmp	5AB7h

l0800_5A82:
	les	bx,[bp-52h]
	cmp	byte ptr es:[bx],0h
	jnz	5A8Eh

l0800_5A8B:
	jmp	5AB4h

l0800_5A8E:
	mov	es,[3728h]
	mov	al,es:[1738h]
	les	bx,[bp-52h]
	add	es:[bx],al
	mov	al,es:[bx]
	sub	ah,ah
	cmp	ax,[bp-3Eh]
	jg	5AA9h

l0800_5AA6:
	jmp	5AB4h

l0800_5AA9:
	les	bx,[bp-52h]
	mov	al,es:[bx]
	sub	ah,ah
	mov	[bp-3Eh],ax

l0800_5AB4:
	jmp	5A76h

l0800_5AB7:
	jmp	5A67h

l0800_5ABA:
	mov	ax,[bp-14h]
	mov	[bp-4Eh],ax

l0800_5AC0:
	mov	cl,[bp-14h]
	mov	ax,1h
	shl	ax,cl
	cmp	ax,[bp-3Eh]
	jle	5AD0h

l0800_5ACD:
	jmp	5B61h

l0800_5AD0:
	inc	word ptr [bp-14h]
	cmp	word ptr [bp-14h],8h
	jg	5ADCh

l0800_5AD9:
	jmp	5B5Eh

l0800_5ADC:
	mov	es,[3728h]
	push	word ptr es:[1738h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1907h
	call	far 149Ah:0ABCh
	add	sp,0Ah
	les	bx,[bp+6h]
	mov	ax,es:[bx+20h]
	mov	dx,es:[bx+22h]
	mov	[bp-52h],ax
	mov	[bp-50h],dx
	les	bx,[bp+6h]
	mov	di,es:[bx+18h]

l0800_5B0F:
	dec	di
	cmp	di,0h
	jge	5B18h

l0800_5B15:
	jmp	5B4Ah

l0800_5B18:
	mov	si,[bp-22h]
	jmp	5B21h

l0800_5B1E:
	inc	word ptr [bp-52h]

l0800_5B21:
	dec	si
	cmp	si,0h
	jge	5B2Ah

l0800_5B27:
	jmp	5B47h

l0800_5B2A:
	les	bx,[bp-52h]
	cmp	byte ptr es:[bx],0h
	jnz	5B36h

l0800_5B33:
	jmp	5B44h

l0800_5B36:
	mov	es,[3728h]
	mov	al,es:[1738h]
	les	bx,[bp-52h]
	sub	es:[bx],al

l0800_5B44:
	jmp	5B1Eh

l0800_5B47:
	jmp	5B0Fh

l0800_5B4A:
	mov	es,[3728h]
	mov	word ptr es:[1738h],0h
	mov	ax,[bp-4Eh]
	mov	[bp-14h],ax
	jmp	5B61h

l0800_5B5E:
	jmp	5AC0h

l0800_5B61:
	mov	ax,[bp-14h]
	cmp	[bp-4Eh],ax
	jnz	5B6Ch

l0800_5B69:
	jmp	5B8Dh

l0800_5B6C:
	mov	es,[3728h]
	push	word ptr es:[1738h]
	push	word ptr [bp-14h]
	push	word ptr [bp-4Eh]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	193Fh
	call	far 149Ah:0ABCh
	add	sp,0Eh

l0800_5B8D:
	jmp	5C7Ch

l0800_5B90:
	mov	es,[36AEh]
	cmp	word ptr es:[2B6Eh],0h
	jz	5B9Fh

l0800_5B9C:
	jmp	5C7Ch

l0800_5B9F:
	mov	es,[36D6h]
	cmp	byte ptr es:[0FDCEh],0h
	jnz	5BAEh

l0800_5BAB:
	jmp	5C7Ch

l0800_5BAE:
	mov	word ptr [bp-3Eh],0h
	les	bx,[bp+6h]
	mov	ax,es:[bx+20h]
	mov	dx,es:[bx+22h]
	mov	[bp-52h],ax
	mov	[bp-50h],dx
	les	bx,[bp+6h]
	mov	di,es:[bx+18h]

l0800_5BCB:
	dec	di
	cmp	di,0h
	jge	5BD4h

l0800_5BD1:
	jmp	5C07h

l0800_5BD4:
	mov	si,[bp-22h]
	jmp	5BDDh

l0800_5BDA:
	inc	word ptr [bp-52h]

l0800_5BDD:
	dec	si
	cmp	si,0h
	jge	5BE6h

l0800_5BE3:
	jmp	5C04h

l0800_5BE6:
	les	bx,[bp-52h]
	mov	al,es:[bx]
	sub	ah,ah
	cmp	ax,[bp-3Eh]
	jg	5BF6h

l0800_5BF3:
	jmp	5C01h

l0800_5BF6:
	les	bx,[bp-52h]
	mov	al,es:[bx]
	sub	ah,ah
	mov	[bp-3Eh],ax

l0800_5C01:
	jmp	5BDAh

l0800_5C04:
	jmp	5BCBh

l0800_5C07:
	cmp	word ptr [bp-3Eh],1h
	jz	5C10h

l0800_5C0D:
	jmp	5C18h

l0800_5C10:
	mov	word ptr [bp-14h],1h
	jmp	5C7Ch

l0800_5C18:
	cmp	word ptr [bp-3Eh],4h
	jl	5C21h

l0800_5C1E:
	jmp	5C29h

l0800_5C21:
	mov	word ptr [bp-14h],2h
	jmp	5C7Ch

l0800_5C29:
	cmp	word ptr [bp-3Eh],8h
	jl	5C32h

l0800_5C2F:
	jmp	5C3Ah

l0800_5C32:
	mov	word ptr [bp-14h],3h
	jmp	5C7Ch

l0800_5C3A:
	cmp	word ptr [bp-3Eh],10h
	jl	5C43h

l0800_5C40:
	jmp	5C4Bh

l0800_5C43:
	mov	word ptr [bp-14h],4h
	jmp	5C7Ch

l0800_5C4B:
	cmp	word ptr [bp-3Eh],20h
	jl	5C54h

l0800_5C51:
	jmp	5C5Ch

l0800_5C54:
	mov	word ptr [bp-14h],5h
	jmp	5C7Ch

l0800_5C5C:
	cmp	word ptr [bp-3Eh],40h
	jl	5C65h

l0800_5C62:
	jmp	5C6Dh

l0800_5C65:
	mov	word ptr [bp-14h],6h
	jmp	5C7Ch

l0800_5C6D:
	cmp	word ptr [bp-3Eh],80h
	jl	5C77h

l0800_5C74:
	jmp	5C7Ch

l0800_5C77:
	mov	word ptr [bp-14h],7h

l0800_5C7C:
	mov	es,[372Ah]
	cmp	byte ptr es:[0C76Ah],0h
	jnz	5C8Bh

l0800_5C88:
	jmp	5CC6h

l0800_5C8B:
	mov	es,[36AAh]
	cmp	word ptr es:[5B8Ch],0h
	jnz	5C9Ah

l0800_5C97:
	jmp	5CBBh

l0800_5C9A:
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],2h
	jg	5CA9h

l0800_5CA6:
	jmp	5CBBh

l0800_5CA9:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	197Bh
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_5CBB:
	mov	es,[36AAh]
	mov	word ptr es:[5B8Ch],0h

l0800_5CC6:
	mov	es,[36AAh]
	cmp	word ptr es:[5B8Ch],0h
	jnz	5CD5h

l0800_5CD2:
	jmp	5D19h

l0800_5CD5:
	les	bx,[bp+6h]
	cmp	word ptr es:[bx+16h],0Ah
	jbe	5CE2h

l0800_5CDF:
	jmp	5D19h

l0800_5CE2:
	mov	es,[36AAh]
	mov	word ptr es:[5B8Ch],0h
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],1h
	jg	5CFCh

l0800_5CF9:
	jmp	5D10h

l0800_5CFC:
	push	0Ah
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	19AFh
	call	far 149Ah:0ABCh
	add	sp,0Ah

l0800_5D10:
	mov	es,[365Ch]
	inc	word ptr es:[022Eh]

l0800_5D19:
	mov	word ptr [bp-20h],0h
	mov	es,[36C2h]
	cmp	byte ptr es:[172Ch],0h
	jnz	5D2Dh

l0800_5D2A:
	jmp	5DC3h

l0800_5D2D:
	cmp	word ptr [bp-1Ah],0h
	jnz	5D36h

l0800_5D33:
	jmp	5D70h

l0800_5D36:
	les	bx,[bp+6h]
	push	word ptr es:[bx+18h]
	push	word ptr [bp-22h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+22h]
	push	word ptr es:[bx+20h]
	call	far 0800h:537Fh
	add	sp,8h
	add	word ptr [bp-22h],4h
	mov	es,[36C4h]
	cmp	byte ptr es:[063Ch],0h
	jnz	5D66h

l0800_5D63:
	jmp	5D70h

l0800_5D66:
	mov	ax,[bp-22h]
	les	bx,[bp+6h]
	mov	es:[bx+16h],ax

l0800_5D70:
	mov	es,[36C4h]
	cmp	byte ptr es:[063Ch],0h
	jz	5D7Fh

l0800_5D7C:
	jmp	5D86h

l0800_5D7F:
	les	bx,[bp+6h]
	inc	word ptr es:[bx+16h]

l0800_5D86:
	les	bx,[bp+6h]
	mov	ax,es:[bx+18h]
	inc	word ptr es:[bx+18h]
	mov	[bp+0FF72h],ax
	push	word ptr [bp+0FF72h]
	push	word ptr [bp-22h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+22h]
	push	word ptr es:[bx+20h]
	call	far 0800h:5412h
	add	sp,8h
	les	bx,[bp+6h]
	mov	ax,es:[bx+18h]
	mul	word ptr [bp-22h]
	mov	[bp+0FF76h],ax
	mov	word ptr [bp+0FF78h],0h

l0800_5DC3:
	mov	ax,[bp-14h]
	cwd
	push	dx
	push	ax
	les	bx,[bp+6h]
	mov	ax,es:[bx+16h]
	les	bx,[bp+6h]
	mul	word ptr es:[bx+18h]
	push	0h
	push	ax
	call	far 149Ah:36B0h
	mov	es,[372Ch]
	mov	es:[0A822h],ax
	mov	es:[0A824h],dx
	mov	ah,[bp-14h]
	and	ax,700h
	shl	ah,4h
	mov	es,[372Eh]
	mov	es:[5B92h],ax
	mov	es,[36AAh]
	cmp	word ptr es:[5B8Ch],0h
	jnz	5E0Ch

l0800_5E09:
	jmp	5E5Ah

l0800_5E0C:
	push	word ptr [bp-14h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+16h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+18h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+22h]
	push	word ptr es:[bx+20h]
	call	far 0800h:6F20h
	add	sp,0Ah
	mov	es,[36AAh]
	mov	es:[5B8Ch],ax
	cmp	word ptr es:[5B8Ch],0h
	jnz	5E43h

l0800_5E40:
	jmp	5E5Ah

l0800_5E43:
	mov	ax,es:[5B8Ch]
	mov	es,[372Eh]
	mov	es:[5B92h],ax
	mov	es,[36AAh]
	mov	word ptr es:[5B8Ch],1h

l0800_5E5A:
	mov	es,[36ECh]
	cmp	byte ptr es:[0FDCCh],0h
	jnz	5E69h

l0800_5E66:
	jmp	5E8Bh

l0800_5E69:
	mov	es,[372Ch]
	mov	ax,es:[0A822h]
	mov	dx,es:[0A824h]
	add	ax,0Fh
	adc	dx,0h
	and	ax,0FFF0h
	and	dx,0FFh
	mov	es:[0A822h],ax
	mov	es:[0A824h],dx

l0800_5E8B:
	mov	es,[3682h]
	mov	ax,es:[0D29Eh]
	mov	dx,es:[0D2A0h]
	mov	[bp-0Ch],ax
	mov	[bp-0Ah],dx
	mov	[bp-56h],ax
	mov	[bp-54h],dx
	mov	es,[36D8h]
	cmp	byte ptr es:[5B60h],0h
	jnz	5EB3h

l0800_5EB0:
	jmp	5F79h

l0800_5EB3:
	push	0h
	push	0h
	mov	ax,[bp+0FF76h]
	mov	dx,[bp+0FF78h]
	shr	dx,1h
	rcr	ax,1h
	push	dx
	push	ax
	les	bx,[bp+6h]
	push	word ptr es:[bx+22h]
	push	word ptr es:[bx+20h]
	call	far 1054h:35FCh
	add	sp,0Ch
	mov	[bp-26h],ax
	mov	[bp-24h],dx
	mov	es,[372Eh]
	push	word ptr es:[5B92h]
	push	word ptr [bp-24h]
	push	word ptr [bp-26h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+18h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+16h]
	call	far 1054h:37DDh
	add	sp,0Ah
	mov	[bp-0Ch],ax
	mov	[bp-0Ah],dx
	cmp	ax,0FFFFh
	jz	5F11h

l0800_5F0E:
	jmp	5F19h

l0800_5F11:
	cmp	dx,0FFh
	jnz	5F19h

l0800_5F16:
	jmp	5F79h

l0800_5F19:
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],2h
	jg	5F28h

l0800_5F25:
	jmp	5F3Ah

l0800_5F28:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	19F2h
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_5F3A:
	mov	es,[36B4h]
	inc	word ptr es:[0D2B0h]
	mov	word ptr [bp-20h],1h
	mov	es,[372Ch]
	mov	ax,es:[0A822h]
	mov	dx,es:[0A824h]
	mov	es,[36B8h]
	add	es:[2C6Ch],ax
	adc	es:[2C6Eh],dx
	mov	es,[36A0h]
	mov	byte ptr es:[0232h],0h
	mov	ax,[bp-0Ch]
	mov	dx,[bp-0Ah]
	mov	[bp-56h],ax
	mov	[bp-54h],dx

l0800_5F79:
	mov	ax,[bp-56h]
	mov	dx,[bp-54h]
	mov	es,[3682h]
	cmp	es:[0D29Eh],ax
	jz	5F8Dh

l0800_5F8A:
	jmp	601Ch

l0800_5F8D:
	cmp	es:[0D2A0h],dx
	jz	5F97h

l0800_5F94:
	jmp	601Ch

l0800_5F97:
	mov	es,[372Ch]
	push	word ptr es:[0A824h]
	push	word ptr es:[0A822h]
	call	far 0800h:7D25h
	add	sp,4h
	cmp	ax,0h
	jl	5FB5h

l0800_5FB2:
	jmp	5FD6h

l0800_5FB5:
	mov	al,[bp-5Eh]
	les	bx,[bp+6h]
	mov	es:[bx],al
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1A11h
	call	far 149Ah:0ABCh
	add	sp,8h
	jmp	6ED7h
0800:5FD3          E9 46 00                                  .F.          

l0800_5FD6:
	mov	es,[372Eh]
	push	word ptr es:[5B92h]
	push	word ptr [bp-54h]
	push	word ptr [bp-56h]
	push	word ptr [bp-24h]
	push	word ptr [bp-26h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+18h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+16h]
	call	far 1054h:38F9h
	add	sp,0Eh
	mov	es,[372Ch]
	mov	ax,es:[0A822h]
	mov	dx,es:[0A824h]
	mov	es,[36A2h]
	add	es:[0D2A2h],ax
	adc	es:[0D2A4h],dx

l0800_601C:
	mov	es,[36A0h]
	cmp	byte ptr es:[0232h],0h
	jnz	602Bh

l0800_6028:
	jmp	60A6h

l0800_602B:
	mov	es,[36CCh]
	cmp	byte ptr es:[0FED8h],0h
	jz	603Ah

l0800_6037:
	jmp	6049h

l0800_603A:
	mov	es,[36D4h]
	cmp	byte ptr es:[4CBEh],0h
	jnz	6049h

l0800_6046:
	jmp	60A6h

l0800_6049:
	mov	es,[372Ch]
	push	word ptr es:[0A824h]
	push	word ptr es:[0A822h]
	call	far 0800h:8095h
	add	sp,4h
	les	bx,[bp+6h]
	mov	ax,es:[bx+16h]
	neg	ax
	and	ax,3h
	push	ax
	mov	es,[372Eh]
	push	word ptr es:[5B92h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+18h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+16h]
	call	far 0800h:7B88h
	add	sp,8h
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],3h
	jg	609Ah

l0800_6097:
	jmp	60A6h

l0800_609A:
	push	ds
	push	1A38h
	call	far 149Ah:0ABCh
	add	sp,4h

l0800_60A6:
	push	1h
	mov	es,[3650h]
	mov	ax,es:[54E0h]
	inc	ax
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 0800h:090Ah
	add	sp,8h
	mov	[bp-3Ch],ax
	cmp	ax,0h
	jz	60CBh

l0800_60C8:
	jmp	60F9h

l0800_60CB:
	mov	es,[36D8h]
	cmp	byte ptr es:[5B60h],0h
	jnz	60DAh

l0800_60D7:
	jmp	60F5h

l0800_60DA:
	cmp	word ptr [bp-20h],0h
	jz	60E3h

l0800_60E0:
	jmp	60F5h

l0800_60E3:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1A40h
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_60F5:
	mov	byte ptr [bp-12h],0h

l0800_60F9:
	mov	es,[36CAh]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	6108h

l0800_6105:
	jmp	62ECh

l0800_6108:
	les	bx,[bp+6h]
	cmp	byte ptr es:[bx],0h
	jnz	6114h

l0800_6111:
	jmp	62ECh

l0800_6114:
	push	word ptr [bp+0Ah]
	push	381Dh
	push	2C74h
	call	far 1054h:3E4Dh
	add	sp,6h
	mov	[bp-66h],al
	cmp	byte ptr [bp-66h],0h
	jz	6131h

l0800_612E:
	jmp	6230h

l0800_6131:
	mov	es,[3730h]
	cmp	byte ptr es:[0D2B6h],0h
	jnz	6140h

l0800_613D:
	jmp	6176h

l0800_6140:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1A7Fh
	mov	es,[3712h]
	push	word ptr es:[0216h]
	push	word ptr es:[0214h]
	call	far 149Ah:0752h
	add	sp,0Ch
	push	0Ah
	push	word ptr [bp+0Ah]
	push	381Dh
	push	2C74h
	call	far 1054h:3E87h
	add	sp,8h
	jmp	6230h

l0800_6176:
	mov	es,[3712h]
	mov	ax,es:[0214h]
	mov	dx,es:[0216h]
	mov	es,[36FAh]
	cmp	es:[0FDD0h],ax
	jz	6191h

l0800_618E:
	jmp	61A2h

l0800_6191:
	cmp	es:[0FDD2h],dx
	jz	619Bh

l0800_6198:
	jmp	61A2h

l0800_619B:
	mov	byte ptr [bp-36h],2h
	jmp	61F7h

l0800_61A2:
	mov	es,[363Eh]
	mov	ax,es:[2D7Ah]
	mov	dx,es:[2D7Ch]
	mov	es,[3648h]
	cmp	es:[5CA4h],ax
	jz	61BDh

l0800_61BA:
	jmp	61F3h

l0800_61BD:
	cmp	es:[5CA6h],dx
	jz	61C7h

l0800_61C4:
	jmp	61F3h

l0800_61C7:
	mov	es,[36FAh]
	mov	ax,es:[0FDD0h]
	mov	dx,es:[0FDD2h]
	mov	es,[36F8h]
	cmp	es:[0F1F8h],ax
	jz	61E2h

l0800_61DF:
	jmp	61F3h

l0800_61E2:
	cmp	es:[0F1FAh],dx
	jz	61ECh

l0800_61E9:
	jmp	61F3h

l0800_61EC:
	mov	byte ptr [bp-36h],3h
	jmp	61F7h

l0800_61F3:
	mov	byte ptr [bp-36h],1h

l0800_61F7:
	mov	al,[bp-36h]
	push	ax
	push	word ptr [bp+0Ah]
	push	381Dh
	push	2C74h
	call	far 1054h:3E87h
	add	sp,8h
	cmp	word ptr [bp-3Ch],0h
	jz	6215h

l0800_6212:
	jmp	6230h

l0800_6215:
	cmp	word ptr [bp-20h],0h
	jnz	621Eh

l0800_621B:
	jmp	6230h

l0800_621E:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1AA4h
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_6230:
	cmp	byte ptr [bp-66h],4h
	jnc	6239h

l0800_6236:
	jmp	62DAh

l0800_6239:
	mov	es,[372Ah]
	cmp	byte ptr es:[0C76Ah],2h
	jl	6248h

l0800_6245:
	jmp	62DAh

l0800_6248:
	mov	es,[36CEh]
	cmp	byte ptr es:[5B72h],0h
	jnz	6257h

l0800_6254:
	jmp	629Ah

l0800_6257:
	test	byte ptr [bp-66h],2h
	jz	6260h

l0800_625D:
	jmp	6297h

l0800_6260:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1AF0h
	mov	es,[3712h]
	push	word ptr es:[0216h]
	push	word ptr es:[0214h]
	call	far 149Ah:0752h
	add	sp,0Ch
	mov	al,[bp-66h]
	or	al,2h
	push	ax
	push	word ptr [bp+0Ah]
	push	381Dh
	push	2C74h
	call	far 1054h:3E87h
	add	sp,8h

l0800_6297:
	jmp	62DAh

l0800_629A:
	test	byte ptr [bp-66h],1h
	jz	62A3h

l0800_62A0:
	jmp	62DAh

l0800_62A3:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1B0Fh
	mov	es,[36F8h]
	push	word ptr es:[0F1FAh]
	push	word ptr es:[0F1F8h]
	call	far 149Ah:0752h
	add	sp,0Ch
	mov	al,[bp-66h]
	or	al,1h
	push	ax
	push	word ptr [bp+0Ah]
	push	381Dh
	push	2C74h
	call	far 1054h:3E87h
	add	sp,8h

l0800_62DA:
	cmp	byte ptr [bp-66h],0h
	jnz	62E3h

l0800_62E0:
	jmp	62ECh

l0800_62E3:
	mov	word ptr [bp-3Ch],0h
	mov	byte ptr [bp-12h],0h

l0800_62EC:
	mov	es,[36CAh]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	62FBh

l0800_62F8:
	jmp	6C75h

l0800_62FB:
	cmp	word ptr [bp-3Ch],0h
	jnz	6304h

l0800_6301:
	jmp	6C75h

l0800_6304:
	les	bx,[bp+6h]
	mov	ax,es:[bx+1Ah]
	mov	[bp-46h],ax
	cmp	ax,3h
	jl	6316h

l0800_6313:
	jmp	6321h

l0800_6316:
	mov	word ptr [bp-6Ch],1B2Eh
	mov	[bp-6Ah],ds
	jmp	633Bh

l0800_6321:
	mov	es,[362Eh]
	mov	bx,[bp-46h]
	shl	bx,2h
	mov	ax,es:[bx+2C64h]
	mov	dx,es:[bx+2C66h]
	mov	[bp-6Ch],ax
	mov	[bp-6Ah],dx

l0800_633B:
	les	bx,[bp+6h]
	cmp	byte ptr es:[bx],0h
	jnz	6347h

l0800_6344:
	jmp	6367h

l0800_6347:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1B33h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ch

l0800_6367:
	mov	byte ptr [bp-7Ah],0h
	mov	byte ptr [bp-74h],0h
	jmp	6375h

l0800_6372:
	inc	byte ptr [bp-74h]

l0800_6375:
	mov	al,[bp-74h]
	cbw
	mov	bx,ax
	shl	bx,2h
	mov	es,[3706h]
	cmp	word ptr es:[bx+2BEAh],0h
	jnz	638Dh

l0800_638A:
	jmp	6AFDh

l0800_638D:
	mov	al,[bp-74h]
	cbw
	mov	bx,ax
	shl	bx,2h
	mov	al,es:[bx+2BECh]
	mov	[bp-60h],al
	cmp	word ptr [bp-5Ch],0h
	jg	63A7h

l0800_63A4:
	jmp	63C7h

l0800_63A7:
	mov	al,[bp-74h]
	cbw
	mov	bx,ax
	shl	bx,2h
	cmp	word ptr es:[bx+2BEAh],6h
	jg	63BBh

l0800_63B8:
	jmp	63C7h

l0800_63BB:
	cmp	word ptr [bp-4Ah],0h
	jnz	63C4h

l0800_63C1:
	jmp	63C7h

l0800_63C4:
	jmp	6372h

l0800_63C7:
	mov	al,[bp-74h]
	cbw
	mov	bx,ax
	shl	bx,2h
	mov	es,[3706h]
	mov	ax,es:[bx+2BEAh]
	jmp	6AD3h

l0800_63DC:
	mov	al,[bp-60h]
	cmp	[bp-7Ah],al
	jz	63E7h

l0800_63E4:
	jmp	640Bh

l0800_63E7:
	les	bx,[bp+6h]
	push	word ptr es:[bx+16h]
	push	ds
	push	1B38h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	6440h

l0800_640B:
	les	bx,[bp+6h]
	push	word ptr es:[bx+16h]
	mov	al,[bp-60h]
	push	ax
	call	far 0800h:5454h
	add	sp,2h
	push	dx
	push	ax
	push	ds
	push	1B3Ch
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Eh
	mov	al,[bp-60h]
	mov	[bp-7Ah],al

l0800_6440:
	jmp	6AFAh

l0800_6443:
	mov	al,[bp-60h]
	cmp	[bp-7Ah],al
	jz	644Eh

l0800_644B:
	jmp	6472h

l0800_644E:
	les	bx,[bp+6h]
	push	word ptr es:[bx+18h]
	push	ds
	push	1B47h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	64A7h

l0800_6472:
	les	bx,[bp+6h]
	push	word ptr es:[bx+18h]
	mov	al,[bp-60h]
	push	ax
	call	far 0800h:5454h
	add	sp,2h
	push	dx
	push	ax
	push	ds
	push	1B4Bh
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Eh
	mov	al,[bp-60h]
	mov	[bp-7Ah],al

l0800_64A7:
	jmp	6AFAh

l0800_64AA:
	mov	ax,[bp-56h]
	mov	dx,[bp-54h]
	mov	[bp-0Ch],ax
	mov	[bp-0Ah],dx
	mov	es,[36A4h]
	cmp	word ptr es:[0F1FCh],0h
	jnz	64C5h

l0800_64C2:
	jmp	64E9h

l0800_64C5:
	mov	es,[36A6h]
	cmp	word ptr es:[54E2h],0h
	jnz	64D4h

l0800_64D1:
	jmp	64DDh

l0800_64D4:
	mov	ax,0h
	mov	dx,200h
	jmp	64E3h

l0800_64DD:
	mov	ax,0h
	mov	dx,0FE00h

l0800_64E3:
	add	[bp-0Ch],ax
	adc	[bp-0Ah],dx

l0800_64E9:
	mov	al,[bp-60h]
	cmp	[bp-7Ah],al
	jz	64F4h

l0800_64F1:
	jmp	6517h

l0800_64F4:
	push	word ptr [bp-0Ah]
	push	word ptr [bp-0Ch]
	push	ds
	push	1B56h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ch
	jmp	654Bh

l0800_6517:
	push	word ptr [bp-0Ah]
	push	word ptr [bp-0Ch]
	mov	al,[bp-60h]
	push	ax
	call	far 0800h:5454h
	add	sp,2h
	push	dx
	push	ax
	push	ds
	push	1B5Dh
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,10h
	mov	al,[bp-60h]
	mov	[bp-7Ah],al

l0800_654B:
	jmp	6AFAh

l0800_654E:
	mov	al,[bp-60h]
	cmp	[bp-7Ah],al
	jz	6559h

l0800_6556:
	jmp	657Dh

l0800_6559:
	les	bx,[bp+6h]
	push	word ptr es:[bx+12h]
	push	ds
	push	1B6Bh
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	65B2h

l0800_657D:
	les	bx,[bp+6h]
	push	word ptr es:[bx+12h]
	mov	al,[bp-60h]
	push	ax
	call	far 0800h:5454h
	add	sp,2h
	push	dx
	push	ax
	push	ds
	push	1B6Fh
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Eh
	mov	al,[bp-60h]
	mov	[bp-7Ah],al

l0800_65B2:
	jmp	6AFAh

l0800_65B5:
	mov	al,[bp-60h]
	cmp	[bp-7Ah],al
	jz	65C0h

l0800_65BD:
	jmp	65E4h

l0800_65C0:
	les	bx,[bp+6h]
	push	word ptr es:[bx+14h]
	push	ds
	push	1B7Ah
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	6619h

l0800_65E4:
	les	bx,[bp+6h]
	push	word ptr es:[bx+14h]
	mov	al,[bp-60h]
	push	ax
	call	far 0800h:5454h
	add	sp,2h
	push	dx
	push	ax
	push	ds
	push	1B7Eh
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Eh
	mov	al,[bp-60h]
	mov	[bp-7Ah],al

l0800_6619:
	jmp	6AFAh

l0800_661C:
	mov	al,[bp-60h]
	cmp	[bp-7Ah],al
	jz	6627h

l0800_6624:
	jmp	664Dh

l0800_6627:
	mov	es,[372Eh]
	push	word ptr es:[5B92h]
	push	ds
	push	1B89h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	6684h

l0800_664D:
	mov	es,[372Eh]
	push	word ptr es:[5B92h]
	mov	al,[bp-60h]
	push	ax
	call	far 0800h:5454h
	add	sp,2h
	push	dx
	push	ax
	push	ds
	push	1B8Fh
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Eh
	mov	al,[bp-60h]
	mov	[bp-7Ah],al

l0800_6684:
	jmp	6AFAh

l0800_6687:
	mov	es,[36EAh]
	cmp	word ptr es:[2D70h],0h
	jz	6696h

l0800_6693:
	jmp	6720h

l0800_6696:
	mov	es,[3674h]
	push	word ptr es:[0D2ACh]
	push	word ptr [bp-6Ah]
	push	word ptr [bp-6Ch]
	call	far 0800h:737Ch
	add	sp,6h
	push	word ptr [bp-46h]
	push	word ptr [bp-6Ah]
	push	word ptr [bp-6Ch]
	call	far 0800h:7505h
	add	sp,6h
	mov	al,[bp-60h]
	cmp	[bp-7Ah],al
	jz	66C9h

l0800_66C6:
	jmp	66ECh

l0800_66C9:
	push	word ptr [bp-6Ah]
	push	word ptr [bp-6Ch]
	push	ds
	push	1B9Ch
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ch
	jmp	6720h

l0800_66EC:
	push	word ptr [bp-6Ah]
	push	word ptr [bp-6Ch]
	mov	al,[bp-60h]
	push	ax
	call	far 0800h:5454h
	add	sp,2h
	push	dx
	push	ax
	push	ds
	push	1BA0h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,10h
	mov	al,[bp-60h]
	mov	[bp-7Ah],al

l0800_6720:
	jmp	6AFAh

l0800_6723:
	les	bx,[bp+6h]
	mov	si,es:[bx+26h]
	cmp	si,0FFh
	jz	6732h

l0800_672F:
	jmp	6749h

l0800_6732:
	les	bx,[bp+6h]
	cmp	word ptr es:[bx+28h],0FFh
	jz	673Fh

l0800_673C:
	jmp	6749h

l0800_673F:
	cmp	word ptr es:[bx+2Ah],0FFh
	jnz	6749h

l0800_6746:
	jmp	674Ch

l0800_6749:
	sub	si,[bp-3Ah]

l0800_674C:
	mov	al,[bp-60h]
	cmp	[bp-7Ah],al
	jz	6757h

l0800_6754:
	jmp	6775h

l0800_6757:
	push	si
	push	ds
	push	1BABh
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	67A4h

l0800_6775:
	push	si
	mov	al,[bp-60h]
	push	ax
	call	far 0800h:5454h
	add	sp,2h
	push	dx
	push	ax
	push	ds
	push	1BAFh
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Eh
	mov	al,[bp-60h]
	mov	[bp-7Ah],al

l0800_67A4:
	jmp	6AFAh

l0800_67A7:
	les	bx,[bp+6h]
	mov	si,es:[bx+28h]
	les	bx,[bp+6h]
	cmp	word ptr es:[bx+26h],0FFh
	jz	67BBh

l0800_67B8:
	jmp	67D2h

l0800_67BB:
	les	bx,[bp+6h]
	cmp	word ptr es:[bx+28h],0FFh
	jz	67C8h

l0800_67C5:
	jmp	67D2h

l0800_67C8:
	cmp	word ptr es:[bx+2Ah],0FFh
	jnz	67D2h

l0800_67CF:
	jmp	67D5h

l0800_67D2:
	sub	si,[bp-42h]

l0800_67D5:
	mov	al,[bp-60h]
	cmp	[bp-7Ah],al
	jz	67E0h

l0800_67DD:
	jmp	67FEh

l0800_67E0:
	push	si
	push	ds
	push	1BBAh
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	682Dh

l0800_67FE:
	push	si
	mov	al,[bp-60h]
	push	ax
	call	far 0800h:5454h
	add	sp,2h
	push	dx
	push	ax
	push	ds
	push	1BBEh
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Eh
	mov	al,[bp-60h]
	mov	[bp-7Ah],al

l0800_682D:
	jmp	6AFAh

l0800_6830:
	mov	al,[bp-60h]
	cmp	[bp-7Ah],al
	jz	683Bh

l0800_6838:
	jmp	685Fh

l0800_683B:
	les	bx,[bp+6h]
	push	word ptr es:[bx+2Ah]
	push	ds
	push	1BC9h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	6894h

l0800_685F:
	les	bx,[bp+6h]
	push	word ptr es:[bx+2Ah]
	mov	al,[bp-60h]
	push	ax
	call	far 0800h:5454h
	add	sp,2h
	push	dx
	push	ax
	push	ds
	push	1BCDh
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Eh
	mov	al,[bp-60h]
	mov	[bp-7Ah],al

l0800_6894:
	jmp	6AFAh

l0800_6897:
	mov	es,[36EAh]
	cmp	word ptr es:[2D70h],0h
	jz	68A6h

l0800_68A3:
	jmp	69E2h

l0800_68A6:
	mov	al,[bp-60h]
	mov	[bp-7Ah],al
	les	bx,[bp+6h]
	cmp	word ptr es:[bx+30h],0h
	jge	68B9h

l0800_68B6:
	jmp	69BAh

l0800_68B9:
	les	bx,[bp+6h]
	mov	bx,es:[bx+30h]
	shl	bx,2h
	mov	es,[3724h]
	mov	ax,es:[bx+4CD4h]
	mov	dx,es:[bx+4CD6h]
	mov	[bp+0FF7Eh],ax
	mov	[bp-80h],dx
	mov	word ptr [bp-4Eh],0h
	jmp	68E3h

l0800_68E0:
	inc	word ptr [bp-4Eh]

l0800_68E3:
	cmp	word ptr [bp-4Eh],10h
	jl	68ECh

l0800_68E9:
	jmp	69BAh

l0800_68EC:
	les	bx,[bp+0FF7Eh]
	add	bx,[bp-4Eh]
	cmp	byte ptr es:[bx],0h
	jl	68FCh

l0800_68F9:
	jmp	68FFh

l0800_68FC:
	jmp	69BAh

l0800_68FF:
	les	bx,[bp+0FF7Eh]
	add	bx,[bp-4Eh]
	mov	al,es:[bx]
	cbw
	mov	bx,ax
	shl	bx,2h
	mov	es,[362Eh]
	mov	ax,es:[bx+2C64h]
	mov	dx,es:[bx+2C66h]
	mov	[bp-30h],ax
	mov	[bp-2Eh],dx
	mov	es,[3674h]
	push	word ptr es:[0D2ACh]
	push	word ptr [bp-2Eh]
	push	word ptr [bp-30h]
	call	far 0800h:737Ch
	add	sp,6h
	les	bx,[bp+0FF7Eh]
	add	bx,[bp-4Eh]
	mov	al,es:[bx]
	cbw
	push	ax
	push	word ptr [bp-2Eh]
	push	word ptr [bp-30h]
	call	far 0800h:7505h
	add	sp,6h
	test	byte ptr [bp-4Eh],3h
	jz	695Dh

l0800_695A:
	jmp	6985h

l0800_695D:
	mov	al,[bp-60h]
	push	ax
	call	far 0800h:5454h
	add	sp,2h
	push	dx
	push	ax
	push	ds
	push	1BD8h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ch

l0800_6985:
	push	word ptr [bp-2Eh]
	push	word ptr [bp-30h]
	mov	al,[bp-4Eh]
	and	ax,3h
	cmp	ax,1h
	sbb	ax,ax
	and	ax,0FFF4h
	add	ax,2Ch
	push	ax
	push	ds
	push	1BE0h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Eh
	jmp	68E0h

l0800_69BA:
	mov	al,[bp-60h]
	push	ax
	call	far 0800h:5454h
	add	sp,2h
	push	dx
	push	ax
	push	ds
	push	1BE5h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ch

l0800_69E2:
	jmp	6AFAh

l0800_69E5:
	mov	al,[bp-74h]
	cbw
	mov	bx,ax
	shl	bx,2h
	mov	es,[3706h]
	mov	si,es:[bx+2BEAh]
	sub	si,0Ch
	cmp	si,13h
	ja	6A02h

l0800_69FF:
	jmp	6A11h

l0800_6A02:
	push	ds
	push	1C0Fh
	call	far 149Ah:0ABCh
	add	sp,4h
	jmp	6ACDh

l0800_6A11:
	les	bx,[bp+6h]
	mov	ax,es:[bx+2Eh]
	mov	[bp-6h],ax
	cmp	ax,0h
	jge	6A23h

l0800_6A20:
	jmp	6A6Ch

l0800_6A23:
	mov	di,si
	sar	di,1h
	test	si,1h
	jnz	6A30h

l0800_6A2D:
	jmp	6A4Dh

l0800_6A30:
	mov	ax,di
	shl	ax,2h
	mov	es,[3720h]
	mov	bx,[bp-6h]
	shl	bx,2h
	les	bx,es:[bx+230h]
	add	bx,ax
	mov	ax,es:[bx+2h]
	jmp	6A66h

l0800_6A4D:
	mov	ax,di
	shl	ax,2h
	mov	es,[3720h]
	mov	bx,[bp-6h]
	shl	bx,2h
	les	bx,es:[bx+230h]
	add	bx,ax
	mov	ax,es:[bx]

l0800_6A66:
	mov	[bp-2Ah],ax
	jmp	6A71h

l0800_6A6C:
	mov	word ptr [bp-2Ah],0h

l0800_6A71:
	mov	al,[bp-60h]
	cmp	[bp-7Ah],al
	jz	6A7Ch

l0800_6A79:
	jmp	6A9Ch

l0800_6A7C:
	push	word ptr [bp-2Ah]
	push	ds
	push	1C34h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	6ACDh

l0800_6A9C:
	push	word ptr [bp-2Ah]
	mov	al,[bp-60h]
	push	ax
	call	far 0800h:5454h
	add	sp,2h
	push	dx
	push	ax
	push	ds
	push	1C38h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Eh
	mov	al,[bp-60h]
	mov	[bp-7Ah],al

l0800_6ACD:
	jmp	6AFAh
0800:6AD0 E9 27 00                                        .'.             

l0800_6AD3:
	dec	ax
	cmp	ax,0Ah
	jbe	6ADCh

l0800_6AD9:
	jmp	69E5h

l0800_6ADC:
	shl	ax,1h
	xchg	bx,ax
	jmp	word ptr cs:[bx+6AE4h]
l0800_6AE4	dw	0x63DC
l0800_6AE6	dw	0x6443
l0800_6AE8	dw	0x64AA
l0800_6AEA	dw	0x654E
l0800_6AEC	dw	0x65B5
l0800_6AEE	dw	0x661C
l0800_6AF0	dw	0x6687
l0800_6AF2	dw	0x6723
l0800_6AF4	dw	0x67A7
l0800_6AF6	dw	0x6830
l0800_6AF8	dw	0x6897

l0800_6AFA:
	jmp	6372h

l0800_6AFD:
	mov	es,[3716h]
	cmp	word ptr es:[173Ah],0h
	jnz	6B0Ch

l0800_6B09:
	jmp	6BDCh

l0800_6B0C:
	cmp	word ptr [bp-4Ah],0h
	jz	6B15h

l0800_6B12:
	jmp	6BDCh

l0800_6B15:
	les	bx,[bp+6h]
	mov	ax,es:[bx+2Eh]
	mov	[bp-6h],ax
	cmp	ax,0h
	jge	6B27h

l0800_6B24:
	jmp	6BC2h

l0800_6B27:
	mov	es,[3720h]
	mov	bx,[bp-6h]
	shl	bx,2h
	les	bx,es:[bx+230h]
	mov	al,es:[bx+24h]
	cbw
	mov	si,ax
	sub	si,[bp-70h]
	mov	es,[3720h]
	mov	bx,[bp-6h]
	shl	bx,2h
	les	bx,es:[bx+230h]
	mov	al,es:[bx+25h]
	cbw
	mov	di,ax
	sub	di,[bp-76h]
	push	di
	push	si
	push	ds
	push	1C43h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ch
	mov	es,[3720h]
	mov	bx,[bp-6h]
	shl	bx,2h
	les	bx,es:[bx+230h]
	mov	si,es:[bx+26h]
	and	si,0FFh
	mov	es,[3720h]
	mov	bx,[bp-6h]
	shl	bx,2h
	les	bx,es:[bx+230h]
	mov	al,es:[bx+27h]
	sub	ah,ah
	mov	di,ax
	push	di
	push	si
	push	ds
	push	1C51h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,0Ch
	jmp	6BDCh

l0800_6BC2:
	push	ds
	push	1C58h
	mov	es,[3648h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,8h

l0800_6BDC:
	mov	es,[372Ah]
	cmp	byte ptr es:[0C76Ah],2h
	jl	6BEBh

l0800_6BE8:
	jmp	6C70h

l0800_6BEB:
	mov	es,[36CEh]
	cmp	byte ptr es:[5B72h],0h
	jz	6BFAh

l0800_6BF7:
	jmp	6C70h

l0800_6BFA:
	les	bx,[bp+6h]
	cmp	byte ptr es:[bx],0h
	jnz	6C06h

l0800_6C03:
	jmp	6C70h

l0800_6C06:
	mov	es,[363Eh]
	mov	ax,es:[2D7Ah]
	mov	dx,es:[2D7Ch]
	mov	es,[3648h]
	cmp	es:[5CA4h],ax
	jz	6C21h

l0800_6C1E:
	jmp	6C2Bh

l0800_6C21:
	cmp	es:[5CA6h],dx
	jnz	6C2Bh

l0800_6C28:
	jmp	6C50h

l0800_6C2B:
	mov	es,[36FAh]
	mov	ax,es:[0FDD0h]
	mov	dx,es:[0FDD2h]
	mov	es,[36F8h]
	cmp	es:[0F1F8h],ax
	jz	6C46h

l0800_6C43:
	jmp	6C50h

l0800_6C46:
	cmp	es:[0F1FAh],dx
	jnz	6C50h

l0800_6C4D:
	jmp	6C70h

l0800_6C50:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1C68h
	mov	es,[36FAh]
	push	word ptr es:[0FDD2h]
	push	word ptr es:[0FDD0h]
	call	far 149Ah:0752h
	add	sp,0Ch

l0800_6C70:
	mov	word ptr [bp-4Ah],1h

l0800_6C75:
	mov	al,[bp-12h]
	dec	byte ptr [bp-12h]
	cmp	al,0h
	jz	6C82h

l0800_6C7F:
	jmp	6C8Ch

l0800_6C82:
	mov	es,[372Ah]
	mov	byte ptr es:[0C76Ah],0h

l0800_6C8C:
	mov	es,[372Ah]
	cmp	byte ptr es:[0C76Ah],1h
	jz	6C9Bh

l0800_6C98:
	jmp	6D13h

l0800_6C9B:
	cmp	word ptr [bp-22h],8h
	jge	6CA4h

l0800_6CA1:
	jmp	6CB1h

l0800_6CA4:
	les	bx,[bp+6h]
	cmp	word ptr es:[bx+18h],4h
	jc	6CB1h

l0800_6CAE:
	jmp	6CC6h

l0800_6CB1:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1C75h
	call	far 149Ah:0ABCh
	add	sp,8h
	jmp	6D10h

l0800_6CC6:
	les	bx,[bp+6h]
	push	word ptr es:[bx+1Ah]
	call	far 0800h:7727h
	add	sp,2h
	mov	[bp-4h],ax
	les	bx,[bp+6h]
	push	word ptr es:[bx+22h]
	push	word ptr es:[bx+20h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+18h]
	push	word ptr [bp-22h]
	call	far 0800h:8497h
	add	sp,8h
	les	bx,[bp+6h]
	mov	byte ptr es:[bx],0h
	les	bx,[bp+6h]
	mov	ax,es:[bx+18h]
	inc	ax
	shr	ax,1h
	les	bx,[bp+6h]
	mov	es:[bx+18h],ax
	jmp	6DADh

l0800_6D10:
	jmp	6E99h

l0800_6D13:
	mov	es,[372Ah]
	cmp	byte ptr es:[0C76Ah],2h
	jnz	6D22h

l0800_6D1F:
	jmp	6D2Dh

l0800_6D22:
	cmp	byte ptr es:[0C76Ah],3h
	jz	6D2Dh

l0800_6D2A:
	jmp	6E99h

l0800_6D2D:
	mov	es,[372Ah]
	cmp	byte ptr es:[0C76Ah],3h
	jz	6D3Ch

l0800_6D39:
	jmp	6D7Fh

l0800_6D3C:
	push	word ptr [bp-4h]
	push	180Ah
	push	0h
	les	bx,[bp+6h]
	push	word ptr es:[bx+22h]
	push	word ptr es:[bx+20h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+18h]
	push	word ptr [bp-22h]
	call	far 0800h:83C5h
	add	sp,0Eh
	les	bx,[bp+6h]
	shr	word ptr es:[bx+18h],1h
	cmp	word ptr es:[bx+18h],0h
	jz	6D73h

l0800_6D70:
	jmp	6D7Ch

l0800_6D73:
	les	bx,[bp+6h]
	mov	word ptr es:[bx+18h],1h

l0800_6D7C:
	jmp	6DADh

l0800_6D7F:
	les	bx,[bp+6h]
	push	word ptr es:[bx+22h]
	push	word ptr es:[bx+20h]
	les	bx,[bp+6h]
	push	word ptr es:[bx+18h]
	push	word ptr [bp-22h]
	call	far 0800h:8497h
	add	sp,8h
	les	bx,[bp+6h]
	mov	ax,es:[bx+18h]
	inc	ax
	shr	ax,1h
	les	bx,[bp+6h]
	mov	es:[bx+18h],ax

l0800_6DAD:
	mov	ax,[bp-22h]
	sar	ax,1h
	add	ax,3h
	and	ax,0FFFCh
	mov	[bp-68h],ax
	mov	ax,[bp-4Ch]
	inc	ax
	sar	ax,1h
	mov	[bp-4Ch],ax
	les	bx,[bp+6h]
	mov	es:[bx+16h],ax
	les	bx,[bp+6h]
	mov	ax,es:[bx+16h]
	add	ax,3h
	and	ax,0FFFCh
	mov	[bp-22h],ax
	mov	es,[36C2h]
	cmp	byte ptr es:[172Ch],0h
	jnz	6DEAh

l0800_6DE7:
	jmp	6E05h

l0800_6DEA:
	les	bx,[bp+6h]
	mov	ax,[bp-68h]
	cmp	es:[bx+16h],ax
	jz	6DF9h

l0800_6DF6:
	jmp	6DFFh

l0800_6DF9:
	mov	ax,1h
	jmp	6E02h

l0800_6DFF:
	mov	ax,0h

l0800_6E02:
	mov	[bp-1Ah],ax

l0800_6E05:
	mov	es,[36C4h]
	cmp	byte ptr es:[063Ch],0h
	jnz	6E14h

l0800_6E11:
	jmp	6E49h

l0800_6E14:
	mov	es,[36C2h]
	cmp	byte ptr es:[172Ch],0h
	jnz	6E23h

l0800_6E20:
	jmp	6E3Fh

l0800_6E23:
	les	bx,[bp+6h]
	mov	ax,[bp-22h]
	cmp	es:[bx+16h],ax
	jz	6E32h

l0800_6E2F:
	jmp	6E3Fh

l0800_6E32:
	mov	ax,[bp-68h]
	les	bx,[bp+6h]
	mov	es:[bx+16h],ax
	jmp	6E49h

l0800_6E3F:
	mov	ax,[bp-22h]
	les	bx,[bp+6h]
	mov	es:[bx+16h],ax

l0800_6E49:
	mov	ax,[bp-68h]
	mov	[bp-22h],ax
	mov	es,[372Ah]
	mov	al,es:[0C76Ah]
	cbw
	push	ax
	push	word ptr [bp-2h]
	push	word ptr [bp+0FF7Ch]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 0800h:54A0h
	add	sp,0Ah
	les	bx,[bp+6h]
	mov	ax,es:[bx+18h]
	mul	word ptr [bp-22h]
	mov	[bp+0FF76h],ax
	mov	word ptr [bp+0FF78h],0h
	mov	es,[372Ah]
	inc	byte ptr es:[0C76Ah]
	mov	al,[bp-34h]
	mov	es,[36A0h]
	mov	es:[0232h],al
	jmp	5D19h

l0800_6E99:
	dec	word ptr [bp-5Ch]
	cmp	word ptr [bp-5Ch],0h
	jg	6EA5h

l0800_6EA2:
	jmp	6ECFh

l0800_6EA5:
	cmp	word ptr [bp-48h],0h
	jnz	6EAEh

l0800_6EAB:
	jmp	6EB5h

l0800_6EAE:
	les	bx,[bp+6h]
	mov	byte ptr es:[bx],0h

l0800_6EB5:
	mov	al,[bp-34h]
	mov	es,[36A0h]
	mov	es:[0232h],al
	mov	al,[bp-28h]
	cbw
	mov	es,[36AAh]
	mov	es:[5B8Ch],ax
	jmp	56E2h

l0800_6ECF:
	les	bx,[bp+6h]
	or	word ptr es:[bx+10h],2h

l0800_6ED7:
	mov	ax,[bp-70h]
	les	bx,[bp+6h]
	mov	es:[bx+12h],ax
	mov	ax,[bp-76h]
	les	bx,[bp+6h]
	mov	es:[bx+14h],ax
	mov	al,[bp-0Eh]
	mov	es,[36C2h]
	mov	es:[172Ch],al
	mov	al,[bp-28h]
	cbw
	mov	es,[36AAh]
	mov	es:[5B8Ch],ax
	mov	al,[bp-34h]
	mov	es,[36A0h]
	mov	es:[0232h],al
	mov	al,[bp-5Eh]
	les	bx,[bp+6h]
	mov	es:[bx],al
	mov	ax,1h
	jmp	6F1Ch

l0800_6F1C:
	pop	si
	pop	di
	leave
	retf

;; fn0800_6F20: 0800:6F20
;;   Called from:
;;     0800:5E28 (in fn0800_550A)
;;     1054:1FDE (in fn1054_1A49)
fn0800_6F20 proc
	push	bp
	mov	bp,sp
	mov	ax,3Ah
	call	far 149Ah:02C8h
	push	di
	push	si
	sub	ax,ax
	mov	[bp-24h],ax
	mov	[bp-26h],ax
	mov	ax,[bp+0Ch]
	neg	ax
	and	ax,3h
	mov	[bp-12h],ax
	mov	word ptr [bp-38h],0h
	jmp	6F4Bh

l0800_6F48:
	inc	word ptr [bp-38h]

l0800_6F4B:
	cmp	word ptr [bp-38h],4h
	jl	6F54h

l0800_6F51:
	jmp	6F6Ch

l0800_6F54:
	mov	ax,0h
	mov	si,[bp-38h]
	shl	si,2h
	mov	[bp+si-20h],ax
	mov	si,[bp-38h]
	shl	si,2h
	mov	[bp+si-22h],ax
	jmp	6F48h

l0800_6F6C:
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	mov	[bp-10h],ax
	mov	[bp-0Eh],dx
	mov	word ptr [bp-2Ch],0h
	jmp	6F83h

l0800_6F80:
	inc	word ptr [bp-2Ch]

l0800_6F83:
	mov	ax,[bp+0Ah]
	cmp	[bp-2Ch],ax
	jl	6F8Eh

l0800_6F8B:
	jmp	70BBh

l0800_6F8E:
	mov	ax,0h
	mov	[bp-8h],ax
	mov	[bp-32h],ax
	mov	word ptr [bp-0Ah],1h
	mov	word ptr [bp-28h],0h
	jmp	6FA7h

l0800_6FA4:
	inc	word ptr [bp-28h]

l0800_6FA7:
	mov	ax,[bp+0Ch]
	cmp	[bp-28h],ax
	jl	6FB2h

l0800_6FAF:
	jmp	7016h

l0800_6FB2:
	les	bx,[bp-10h]
	inc	word ptr [bp-10h]
	mov	al,es:[bx]
	sub	ah,ah
	mov	[bp-34h],ax
	cmp	word ptr [bp-0Ah],0h
	jnz	6FC9h

l0800_6FC6:
	jmp	6FF1h

l0800_6FC9:
	cmp	word ptr [bp-32h],78h
	jnz	6FD2h

l0800_6FCF:
	jmp	6FE9h

l0800_6FD2:
	cmp	word ptr [bp-34h],0h
	jz	6FDBh

l0800_6FD8:
	jmp	6FE1h

l0800_6FDB:
	inc	word ptr [bp-32h]
	jmp	6FE6h

l0800_6FE1:
	mov	word ptr [bp-0Ah],0h

l0800_6FE6:
	jmp	6FEEh

l0800_6FE9:
	mov	word ptr [bp-0Ah],0h

l0800_6FEE:
	jmp	7013h

l0800_6FF1:
	mov	ax,[bp+0Ch]
	sub	ax,78h
	cmp	ax,[bp-28h]
	jl	6FFFh

l0800_6FFC:
	jmp	7013h

l0800_6FFF:
	cmp	word ptr [bp-34h],0h
	jz	7008h

l0800_7005:
	jmp	700Eh

l0800_7008:
	inc	word ptr [bp-8h]
	jmp	7013h

l0800_700E:
	mov	word ptr [bp-8h],0h

l0800_7013:
	jmp	6FA4h

l0800_7016:
	mov	ax,[bp-12h]
	add	[bp-10h],ax
	mov	word ptr [bp-38h],0h
	jmp	7027h

l0800_7024:
	inc	word ptr [bp-38h]

l0800_7027:
	cmp	word ptr [bp-38h],4h
	jl	7030h

l0800_702D:
	jmp	7098h

l0800_7030:
	mov	cl,[bp-38h]
	mov	ax,1h
	shl	ax,cl
	mov	[bp-3Ah],ax
	mov	ax,[bp-32h]
	sub	dx,dx
	div	word ptr [bp-3Ah]
	mov	[bp-4h],ax
	cmp	word ptr [bp-4h],0Fh
	jg	704Fh

l0800_704C:
	jmp	7054h

l0800_704F:
	mov	word ptr [bp-4h],0Fh

l0800_7054:
	mov	ax,[bp-3Ah]
	imul	word ptr [bp-4h]
	sub	ax,[bp-32h]
	neg	ax
	mov	si,[bp-38h]
	shl	si,2h
	add	[bp+si-22h],ax
	mov	ax,[bp-8h]
	sub	dx,dx
	div	word ptr [bp-3Ah]
	mov	[bp-4h],ax
	cmp	word ptr [bp-4h],0Fh
	jg	707Ch

l0800_7079:
	jmp	7081h

l0800_707C:
	mov	word ptr [bp-4h],0Fh

l0800_7081:
	mov	ax,[bp-3Ah]
	imul	word ptr [bp-4h]
	sub	ax,[bp-8h]
	neg	ax
	mov	si,[bp-38h]
	shl	si,2h
	add	[bp+si-20h],ax
	jmp	7024h

l0800_7098:
	mov	ax,[bp-32h]
	mov	es,[3732h]
	mov	bx,[bp-2Ch]
	shl	bx,2h
	mov	es:[bx+234h],ax
	mov	ax,[bp-8h]
	mov	bx,[bp-2Ch]
	shl	bx,2h
	mov	es:[bx+236h],ax
	jmp	6F80h

l0800_70BB:
	mov	ax,0h
	mov	[bp-6h],ax
	mov	[bp-30h],ax
	mov	word ptr [bp-38h],1h
	jmp	70CFh

l0800_70CC:
	inc	word ptr [bp-38h]

l0800_70CF:
	cmp	word ptr [bp-38h],4h
	jl	70D8h

l0800_70D5:
	jmp	7115h

l0800_70D8:
	mov	si,[bp-38h]
	shl	si,2h
	mov	ax,[bp+si-22h]
	mov	si,[bp-30h]
	shl	si,2h
	cmp	[bp+si-22h],ax
	jg	70EFh

l0800_70EC:
	jmp	70F5h

l0800_70EF:
	mov	ax,[bp-38h]
	mov	[bp-30h],ax

l0800_70F5:
	mov	si,[bp-38h]
	shl	si,2h
	mov	ax,[bp+si-20h]
	mov	si,[bp-6h]
	shl	si,2h
	cmp	[bp+si-20h],ax
	jg	710Ch

l0800_7109:
	jmp	7112h

l0800_710C:
	mov	ax,[bp-38h]
	mov	[bp-6h],ax

l0800_7112:
	jmp	70CCh

l0800_7115:
	mov	al,[bp+0Eh]
	and	al,7h
	shl	al,4h
	or	al,[bp-30h]
	mov	cl,[bp-6h]
	shl	cl,2h
	or	al,cl
	mov	cl,80h
	mov	ch,al
	mov	[bp-2h],cx
	mov	cx,[bp-30h]
	mov	[bp-0Ah],cx
	mov	ax,1h
	shl	ax,cl
	mov	[bp-30h],ax
	mov	cx,[bp-6h]
	mov	[bp-36h],cx
	mov	ax,1h
	shl	ax,cl
	mov	[bp-6h],ax
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],4h
	jg	715Ah

l0800_7157:
	jmp	716Fh

l0800_715A:
	push	word ptr [bp-6h]
	push	word ptr [bp-30h]
	push	word ptr [bp+0Eh]
	push	ds
	push	1C9Ch
	call	far 149Ah:0ABCh
	add	sp,0Ah

l0800_716F:
	mov	word ptr [bp-2Ch],0h
	jmp	717Ah

l0800_7177:
	inc	word ptr [bp-2Ch]

l0800_717A:
	mov	ax,[bp+0Ah]
	cmp	[bp-2Ch],ax
	jl	7185h

l0800_7182:
	jmp	72C2h

l0800_7185:
	mov	es,[3732h]
	mov	bx,[bp-2Ch]
	shl	bx,2h
	mov	ax,es:[bx+234h]
	mov	[bp-32h],ax
	mov	bx,[bp-2Ch]
	shl	bx,2h
	mov	ax,es:[bx+236h]
	mov	[bp-8h],ax
	mov	ax,[bp-30h]
	mov	cx,ax
	shl	ax,4h
	sub	ax,cx
	cmp	ax,[bp-32h]
	jc	71B7h

l0800_71B4:
	jmp	71BFh

l0800_71B7:
	mov	word ptr [bp-32h],0Fh
	jmp	71CAh

l0800_71BF:
	mov	ax,[bp-32h]
	sub	dx,dx
	div	word ptr [bp-30h]
	mov	[bp-32h],ax

l0800_71CA:
	mov	ax,[bp-6h]
	mov	cx,ax
	shl	ax,4h
	sub	ax,cx
	cmp	ax,[bp-8h]
	jc	71DCh

l0800_71D9:
	jmp	71E4h

l0800_71DC:
	mov	word ptr [bp-8h],0Fh
	jmp	71EFh

l0800_71E4:
	mov	ax,[bp-8h]
	sub	dx,dx
	div	word ptr [bp-6h]
	mov	[bp-8h],ax

l0800_71EF:
	mov	ax,[bp-30h]
	imul	word ptr [bp-32h]
	mov	[bp-2Ah],ax
	mov	ax,[bp-6h]
	imul	word ptr [bp-8h]
	sub	ax,[bp+0Ch]
	neg	ax
	dec	ax
	mov	[bp-2Eh],ax
	mov	ax,[bp-2Eh]
	sub	ax,[bp-2Ah]
	inc	ax
	cmp	ax,0Ah
	jl	7216h

l0800_7213:
	jmp	7285h

l0800_7216:
	mov	ax,[bp-2Ah]
	sub	ax,[bp-2Eh]
	add	ax,9h
	mov	[bp-0Ch],ax
	mov	ax,[bp-2Ah]
	cmp	[bp-0Ch],ax
	jg	722Dh

l0800_722A:
	jmp	7236h

l0800_722D:
	mov	ax,[bp-2Ah]
	sub	[bp-0Ch],ax
	jmp	723Ch

l0800_7236:
	mov	ax,[bp-0Ch]
	mov	[bp-2Ah],ax

l0800_723C:
	mov	ax,[bp-30h]
	mul	word ptr [bp-32h]
	sub	ax,[bp-2Ah]
	sub	dx,dx
	div	word ptr [bp-30h]
	mov	[bp-32h],ax
	mov	ax,[bp-30h]
	imul	word ptr [bp-32h]
	mov	[bp-2Ah],ax
	mov	ax,[bp-2Eh]
	sub	ax,[bp-2Ah]
	inc	ax
	cmp	ax,0Ah
	jl	7265h

l0800_7262:
	jmp	7285h

l0800_7265:
	mov	ax,[bp-6h]
	mul	word ptr [bp-8h]
	sub	ax,[bp-0Ch]
	sub	dx,dx
	div	word ptr [bp-6h]
	mov	[bp-8h],ax
	mov	ax,[bp-6h]
	imul	word ptr [bp-8h]
	sub	ax,[bp+0Ch]
	neg	ax
	dec	ax
	mov	[bp-2Eh],ax

l0800_7285:
	mov	ax,[bp+0Ch]
	mov	cl,[bp-36h]
	mov	dx,[bp-8h]
	shl	dx,cl
	sub	ax,dx
	mov	cl,[bp-0Ah]
	mov	dx,[bp-32h]
	shl	dx,cl
	sub	ax,dx
	mul	word ptr [bp+0Eh]
	sub	dx,dx
	add	[bp-26h],ax
	adc	[bp-24h],dx
	mov	ax,[bp-8h]
	shl	ax,4h
	or	ax,[bp-32h]
	mov	es,[3732h]
	mov	bx,[bp-2Ch]
	shl	bx,2h
	mov	es:[bx+234h],ax
	jmp	7177h

l0800_72C2:
	mov	ax,[bp+0Ah]
	shl	ax,3h
	cwd
	add	[bp-26h],ax
	adc	[bp-24h],dx
	mov	ax,[bp-26h]
	mov	dx,[bp-24h]
	mov	es,[372Ch]
	cmp	es:[0A824h],dx
	jbe	72E3h

l0800_72E0:
	jmp	72FAh

l0800_72E3:
	jnc	72E8h

l0800_72E5:
	jmp	72F2h

l0800_72E8:
	cmp	es:[0A822h],ax
	jc	72F2h

l0800_72EF:
	jmp	72FAh

l0800_72F2:
	mov	word ptr [bp-2h],0h
	jmp	730Dh

l0800_72FA:
	mov	ax,[bp-26h]
	mov	dx,[bp-24h]
	mov	es,[372Ch]
	mov	es:[0A822h],ax
	mov	es:[0A824h],dx

l0800_730D:
	mov	es,[36DCh]
	cmp	byte ptr es:[54D8h],4h
	jg	731Ch

l0800_7319:
	jmp	7372h

l0800_731C:
	push	ds
	push	1CDDh
	call	far 149Ah:0ABCh
	add	sp,4h
	mov	word ptr [bp-38h],0h
	jmp	7333h

l0800_7330:
	inc	word ptr [bp-38h]

l0800_7333:
	cmp	word ptr [bp-38h],4h
	jl	733Ch

l0800_7339:
	jmp	7366h

l0800_733C:
	mov	si,[bp-38h]
	shl	si,2h
	push	word ptr [bp+si-20h]
	mov	si,[bp-38h]
	shl	si,2h
	push	word ptr [bp+si-22h]
	mov	cl,[bp-38h]
	mov	ax,1h
	shl	ax,cl
	push	ax
	push	ds
	push	1CE0h
	call	far 149Ah:0ABCh
	add	sp,0Ah
	jmp	7330h

l0800_7366:
	push	ds
	push	1D11h
	call	far 149Ah:0ABCh
	add	sp,4h

l0800_7372:
	mov	ax,[bp-2h]
	jmp	7378h

l0800_7378:
	pop	si
	pop	di
	leave
	retf

;; fn0800_737C: 0800:737C
;;   Called from:
;;     0800:66A5 (in fn0800_550A)
;;     0800:6932 (in fn0800_550A)
;;     0800:73C7 (in fn0800_737C)
fn0800_737C proc
	push	bp
	mov	bp,sp
	mov	ax,0Ah
	call	far 149Ah:02C8h
	push	di
	push	si
	cmp	word ptr [bp+0Ah],0FFh
	jnz	7392h

l0800_738F:
	jmp	73E2h

l0800_7392:
	mov	es,[36FAh]
	mov	ax,es:[0FDD0h]
	mov	dx,es:[0FDD2h]
	mov	[bp-6h],ax
	mov	[bp-4h],dx
	mov	es,[36F8h]
	mov	ax,es:[0F1F8h]
	mov	dx,es:[0F1FAh]
	mov	es,[36FAh]
	mov	es:[0FDD0h],ax
	mov	es:[0FDD2h],dx
	push	0FFh
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 0800h:737Ch
	add	sp,6h
	mov	ax,[bp-6h]
	mov	dx,[bp-4h]
	mov	es,[36FAh]
	mov	es:[0FDD0h],ax
	mov	es:[0FDD2h],dx

l0800_73E2:
	mov	word ptr [bp-2h],0h
	jmp	73EDh

l0800_73EA:
	inc	word ptr [bp-2h]

l0800_73ED:
	mov	es,[367Eh]
	mov	ax,[bp-2h]
	cmp	es:[0A7D4h],ax
	jg	73FEh

l0800_73FB:
	jmp	7443h

l0800_73FE:
	mov	es,[3734h]
	mov	bx,[bp-2h]
	shl	bx,1h
	mov	ax,[bp+0Ah]
	cmp	es:[bx+5520h],ax
	jz	7414h

l0800_7411:
	jmp	7440h

l0800_7414:
	mov	ax,[bp-2h]
	mov	cx,ax
	shl	ax,2h
	add	ax,cx
	shl	ax,1h
	add	ax,2D7Eh
	push	381Dh
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	743Dh

l0800_743A:
	jmp	7440h

l0800_743D:
	jmp	7501h

l0800_7440:
	jmp	73EAh

l0800_7443:
	mov	es,[367Eh]
	cmp	word ptr es:[0A7D4h],320h
	jz	7453h

l0800_7450:
	jmp	7478h

l0800_7453:
	push	320h
	push	ds
	push	1D14h
	call	far 149Ah:0ABCh
	add	sp,6h
	push	ds
	push	1D3Ah
	call	far 149Ah:0ABCh
	add	sp,4h
	push	1h
	call	far 0800h:02C7h
	add	sp,2h

l0800_7478:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1D5Fh
	mov	es,[36CEh]
	cmp	byte ptr es:[5B72h],0h
	jnz	7491h

l0800_748E:
	jmp	74A1h

l0800_7491:
	mov	es,[36F8h]
	mov	ax,es:[0F1F8h]
	mov	dx,es:[0F1FAh]
	jmp	74AEh

l0800_74A1:
	mov	es,[36FAh]
	mov	ax,es:[0FDD0h]
	mov	dx,es:[0FDD2h]

l0800_74AE:
	push	dx
	push	ax
	call	far 149Ah:0752h
	add	sp,0Ch
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	mov	es,[367Eh]
	mov	ax,es:[0A7D4h]
	mov	cx,ax
	shl	ax,2h
	add	ax,cx
	shl	ax,1h
	add	ax,2D7Eh
	push	381Dh
	push	ax
	call	far 149Ah:25AEh
	add	sp,8h
	mov	ax,[bp+0Ah]
	mov	es,[367Eh]
	mov	bx,es:[0A7D4h]
	shl	bx,1h
	mov	es,[3734h]
	mov	es:[bx+5520h],ax
	mov	es,[367Eh]
	inc	word ptr es:[0A7D4h]
	jmp	7501h

l0800_7501:
	pop	si
	pop	di
	leave
	retf

;; fn0800_7505: 0800:7505
;;   Called from:
;;     0800:66B6 (in fn0800_550A)
;;     0800:694C (in fn0800_550A)
fn0800_7505 proc
	push	bp
	mov	bp,sp
	mov	ax,4h
	call	far 149Ah:02C8h
	push	di
	push	si
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 0800h:757Ch
	add	sp,4h
	cmp	ax,0h
	jz	7528h

l0800_7525:
	jmp	7572h

l0800_7528:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 1054h:3541h
	add	sp,4h
	inc	ax
	jz	753Ch

l0800_7539:
	jmp	7572h

l0800_753C:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	mov	es,[3646h]
	mov	ax,es:[0CF9Eh]
	inc	word ptr es:[0CF9Eh]
	mov	cx,ax
	shl	ax,2h
	add	ax,cx
	shl	ax,1h
	add	ax,0A826h
	push	180Ah
	push	ax
	call	far 149Ah:25AEh
	add	sp,8h
	push	word ptr [bp+0Ah]
	call	far 0800h:75E1h
	add	sp,2h

l0800_7572:
	mov	ax,0h
	jmp	7578h

l0800_7578:
	pop	si
	pop	di
	leave
	retf

;; fn0800_757C: 0800:757C
;;   Called from:
;;     0800:08B4 (in fn0800_084A)
;;     0800:7518 (in fn0800_7505)
;;     1054:2534 (in fn1054_1A49)
fn0800_757C proc
	push	bp
	mov	bp,sp
	mov	ax,2h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	word ptr [bp-2h],0h
	jmp	7594h

l0800_7591:
	inc	word ptr [bp-2h]

l0800_7594:
	mov	es,[3646h]
	mov	ax,[bp-2h]
	cmp	es:[0CF9Eh],ax
	jg	75A5h

l0800_75A2:
	jmp	75D7h

l0800_75A5:
	mov	ax,[bp-2h]
	mov	cx,ax
	shl	ax,2h
	add	ax,cx
	shl	ax,1h
	add	ax,0A826h
	push	180Ah
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	75CEh

l0800_75CB:
	jmp	75D4h

l0800_75CE:
	mov	ax,1h
	jmp	75DDh

l0800_75D4:
	jmp	7591h

l0800_75D7:
	mov	ax,0h
	jmp	75DDh

l0800_75DD:
	pop	si
	pop	di
	leave
	retf

;; fn0800_75E1: 0800:75E1
;;   Called from:
;;     0800:756A (in fn0800_7505)
fn0800_75E1 proc
	push	bp
	mov	bp,sp
	mov	ax,0Eh
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	word ptr [bp-4h],0h
	push	word ptr [bp+6h]
	call	far 0800h:7727h
	add	sp,2h
	mov	es,[362Eh]
	mov	bx,[bp+6h]
	shl	bx,2h
	push	word ptr es:[bx+2C66h]
	push	word ptr es:[bx+2C64h]
	push	ds
	push	1D6Bh
	mov	es,[3644h]
	push	word ptr es:[0A7DCh]
	push	word ptr es:[0A7DAh]
	call	far 149Ah:0752h
	add	sp,0Ch
	mov	word ptr [bp-0Ah],0h
	mov	word ptr [bp-8h],180Ah
	mov	word ptr [bp-2h],0h
	mov	es,[362Eh]
	mov	bx,[bp+6h]
	shl	bx,2h
	les	bx,es:[bx+2C64h]
	push	word ptr es:[bx+0Ch]
	push	ds
	push	1D70h
	mov	es,[3644h]
	push	word ptr es:[0A7DCh]
	push	word ptr es:[0A7DAh]
	call	far 149Ah:0752h
	add	sp,0Ah
	mov	word ptr [bp-6h],0h
	jmp	7673h

l0800_7670:
	inc	word ptr [bp-6h]

l0800_7673:
	mov	es,[362Eh]
	mov	bx,[bp+6h]
	shl	bx,2h
	les	bx,es:[bx+2C64h]
	mov	ax,[bp-6h]
	cmp	es:[bx+0Ch],ax
	ja	768Eh

l0800_768B:
	jmp	7709h

l0800_768E:
	cmp	word ptr [bp-2h],0h
	jnz	7697h

l0800_7694:
	jmp	76A0h

l0800_7697:
	cmp	word ptr [bp-4h],7h
	jz	76A0h

l0800_769D:
	jmp	76C7h

l0800_76A0:
	mov	es,[3644h]
	push	word ptr es:[0A7DCh]
	push	word ptr es:[0A7DAh]
	push	ds
	push	1D7Ch
	call	far 149Ah:27A8h
	add	sp,8h
	mov	word ptr [bp-4h],0h
	mov	word ptr [bp-2h],1h
	jmp	76E2h

l0800_76C7:
	mov	es,[3644h]
	push	word ptr es:[0A7DCh]
	push	word ptr es:[0A7DAh]
	push	2Ch
	call	far 149Ah:1D36h
	add	sp,6h
	inc	word ptr [bp-4h]

l0800_76E2:
	les	bx,[bp-0Ah]
	add	word ptr [bp-0Ah],2h
	push	word ptr es:[bx]
	push	ds
	push	1D85h
	mov	es,[3644h]
	push	word ptr es:[0A7DCh]
	push	word ptr es:[0A7DAh]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	7670h

l0800_7709:
	mov	es,[3644h]
	push	word ptr es:[0A7DCh]
	push	word ptr es:[0A7DAh]
	push	ds
	push	1D8Bh
	call	far 149Ah:27A8h
	add	sp,8h
	pop	si
	pop	di
	leave
	retf

;; fn0800_7727: 0800:7727
;;   Called from:
;;     0800:6CCD (in fn0800_550A)
;;     0800:75F6 (in fn0800_75E1)
fn0800_7727 proc
	push	bp
	mov	bp,sp
	mov	ax,6h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[362Eh]
	mov	bx,[bp+6h]
	shl	bx,2h
	mov	ax,es:[bx+2C64h]
	mov	dx,es:[bx+2C66h]
	mov	[bp-6h],ax
	mov	[bp-4h],dx
	push	0h
	les	bx,[bp-6h]
	push	word ptr es:[bx+10h]
	push	word ptr es:[bx+0Eh]
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:1DEAh
	add	sp,8h
	les	bx,[bp-6h]
	mov	ax,es:[bx+0Ch]
	shl	ax,1h
	mov	[bp-2h],ax
	push	word ptr [bp-2h]
	push	180Ah
	push	0h
	mov	es,[3626h]
	push	word ptr es:[0208h]
	call	far 149Ah:2030h
	add	sp,8h
	les	bx,[bp-6h]
	mov	byte ptr es:[bx+18h],0h
	les	bx,[bp-6h]
	mov	ax,es:[bx+0Ch]
	jmp	77A4h

l0800_77A4:
	pop	si
	pop	di
	leave
	retf

;; fn0800_77A8: 0800:77A8
;;   Called from:
;;     0800:214E (in main)
;;     0800:23A0 (in main)
;;     0800:7EF2 (in fn0800_7DD1)
fn0800_77A8 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	al,[bp+6h]
	and	ax,0Fh
	mov	es,[3662h]
	mov	es:[54EAh],ax
	cmp	word ptr es:[54EAh],0h
	jnz	77CEh

l0800_77CB:
	jmp	77F7h

l0800_77CE:
	mov	es,[36ECh]
	cmp	byte ptr es:[0FDCCh],0h
	jnz	77DDh

l0800_77DA:
	jmp	77F7h

l0800_77DD:
	mov	ax,10h
	mov	es,[3662h]
	sub	ax,es:[54EAh]
	cwd
	add	[bp+6h],ax
	adc	[bp+8h],dx
	mov	word ptr es:[54EAh],0h

l0800_77F7:
	cmp	word ptr [bp+8h],80h
	jnc	7800h

l0800_77FD:
	jmp	787Bh

l0800_7800:
	jbe	7805h

l0800_7802:
	jmp	780Eh

l0800_7805:
	cmp	word ptr [bp+6h],0h
	jnc	780Eh

l0800_780B:
	jmp	787Bh

l0800_780E:
	cmp	word ptr [bp+8h],0FFh
	jbe	7817h

l0800_7814:
	jmp	787Bh

l0800_7817:
	jnc	781Ch

l0800_7819:
	jmp	7826h

l0800_781C:
	cmp	word ptr [bp+6h],0F000h
	jc	7826h

l0800_7823:
	jmp	787Bh

l0800_7826:
	mov	es,[368Ah]
	mov	word ptr es:[2A28h],0F000h
	mov	word ptr es:[2A2Ah],0FFFFh
	mov	es,[36A0h]
	mov	byte ptr es:[0232h],1h
	mov	es,[3694h]
	mov	word ptr es:[077Ch],1734h
	mov	word ptr es:[077Eh],180Ah
	mov	es,[369Eh]
	mov	word ptr es:[0D06Eh],1728h
	mov	word ptr es:[0D070h],180Ah
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1D8Dh
	call	far 149Ah:0ABCh
	add	sp,8h
	jmp	7A88h

l0800_787B:
	cmp	word ptr [bp+8h],100h
	jnc	7885h

l0800_7882:
	jmp	7900h

l0800_7885:
	jbe	788Ah

l0800_7887:
	jmp	7893h

l0800_788A:
	cmp	word ptr [bp+6h],0h
	jnc	7893h

l0800_7890:
	jmp	7900h

l0800_7893:
	cmp	word ptr [bp+8h],110h
	jbe	789Dh

l0800_789A:
	jmp	7900h

l0800_789D:
	jnc	78A2h

l0800_789F:
	jmp	78ABh

l0800_78A2:
	cmp	word ptr [bp+6h],0h
	jc	78ABh

l0800_78A8:
	jmp	7900h

l0800_78AB:
	mov	es,[368Ah]
	mov	word ptr es:[2A28h],0h
	mov	word ptr es:[2A2Ah],110h
	mov	es,[36A0h]
	mov	byte ptr es:[0232h],1h
	mov	es,[3694h]
	mov	word ptr es:[077Ch],172Eh
	mov	word ptr es:[077Eh],180Ah
	mov	es,[369Eh]
	mov	word ptr es:[0D06Eh],1720h
	mov	word ptr es:[0D070h],180Ah
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1DB0h
	call	far 149Ah:0ABCh
	add	sp,8h
	jmp	7A88h

l0800_7900:
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	mov	es,[3668h]
	cmp	es:[5B76h],dx
	jbe	7914h

l0800_7911:
	jmp	79C3h

l0800_7914:
	jnc	7919h

l0800_7916:
	jmp	7923h

l0800_7919:
	cmp	es:[5B74h],ax
	jbe	7923h

l0800_7920:
	jmp	79C3h

l0800_7923:
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	mov	es,[3666h]
	cmp	es:[5B6Ah],dx
	jnc	7937h

l0800_7934:
	jmp	79C3h

l0800_7937:
	jbe	793Ch

l0800_7939:
	jmp	7946h

l0800_793C:
	cmp	es:[5B68h],ax
	ja	7946h

l0800_7943:
	jmp	79C3h

l0800_7946:
	mov	ax,es:[5B68h]
	mov	dx,es:[5B6Ah]
	mov	es,[368Ah]
	mov	es:[2A28h],ax
	mov	es:[2A2Ah],dx
	mov	es,[36A0h]
	mov	byte ptr es:[0232h],0h
	mov	es,[3694h]
	mov	word ptr es:[077Ch],21Ah
	mov	word ptr es:[077Eh],180Ah
	mov	es,[369Eh]
	mov	word ptr es:[0D06Eh],200h
	mov	word ptr es:[0D070h],180Ah
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1DD3h
	call	far 149Ah:0ABCh
	add	sp,8h
	mov	es,[36A4h]
	cmp	word ptr es:[0F1FCh],0h
	jnz	79ABh

l0800_79A8:
	jmp	79C0h

l0800_79AB:
	mov	es,[36A6h]
	push	word ptr es:[54E2h]
	push	ds
	push	1DEFh
	call	far 149Ah:0ABCh
	add	sp,6h

l0800_79C0:
	jmp	7A88h

l0800_79C3:
	cmp	word ptr [bp+8h],200h
	jnc	79CDh

l0800_79CA:
	jmp	7A6Ch

l0800_79CD:
	jbe	79D2h

l0800_79CF:
	jmp	79DBh

l0800_79D2:
	cmp	word ptr [bp+6h],0h
	jnc	79DBh

l0800_79D8:
	jmp	7A6Ch

l0800_79DB:
	cmp	word ptr [bp+8h],800h
	jbe	79E5h

l0800_79E2:
	jmp	7A6Ch

l0800_79E5:
	jnc	79EAh

l0800_79E7:
	jmp	79F3h

l0800_79EA:
	cmp	word ptr [bp+6h],0h
	jc	79F3h

l0800_79F0:
	jmp	7A6Ch

l0800_79F3:
	mov	es,[368Ah]
	mov	word ptr es:[2A28h],0h
	mov	word ptr es:[2A2Ah],800h
	mov	es,[36A0h]
	mov	byte ptr es:[0232h],1h
	mov	es,[3694h]
	mov	word ptr es:[077Ch],5C9Eh
	mov	word ptr es:[077Eh],381Dh
	mov	es,[369Eh]
	mov	word ptr es:[0D06Eh],5B96h
	mov	word ptr es:[0D070h],381Dh
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1DF8h
	call	far 149Ah:0ABCh
	add	sp,8h
	mov	es,[36A4h]
	cmp	word ptr es:[0F1FCh],0h
	jnz	7A54h

l0800_7A51:
	jmp	7A69h

l0800_7A54:
	mov	es,[36A6h]
	push	word ptr es:[54E2h]
	push	ds
	push	1E14h
	call	far 149Ah:0ABCh
	add	sp,6h

l0800_7A69:
	jmp	7A88h

l0800_7A6C:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1E1Dh
	call	far 149Ah:0ABCh
	add	sp,8h
	push	7h
	call	far 149Ah:01DDh
	add	sp,2h

l0800_7A88:
	mov	es,[3704h]
	mov	ax,es:[0D06Ch]
	or	ax,es:[0D06Ah]
	jnz	7A9Ah

l0800_7A97:
	jmp	7AB0h

l0800_7A9A:
	push	word ptr es:[0D06Ch]
	push	word ptr es:[0D06Ah]
	push	ds
	push	1E46h
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_7AB0:
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	mov	es,[3682h]
	mov	es:[0D29Eh],ax
	mov	es:[0D2A0h],dx
	mov	ax,es:[0D29Eh]
	mov	dx,es:[0D2A0h]
	mov	es,[3688h]
	mov	es:[0FBC6h],ax
	mov	es:[0FBC8h],dx
	mov	es,[3682h]
	mov	ax,es:[0D29Eh]
	mov	dx,es:[0D2A0h]
	mov	es,[3684h]
	mov	es:[2A06h],ax
	mov	es:[2A08h],dx
	pop	si
	pop	di
	leave
	retf

;; fn0800_7AF7: 0800:7AF7
;;   Called from:
;;     0800:7C49 (in fn0800_7B88)
;;     0800:7C9B (in fn0800_7B88)
;;     0800:7CDC (in fn0800_7B88)
;;     0800:7D19 (in fn0800_7B88)
;;     1054:2395 (in fn1054_1A49)
;;     1054:23A3 (in fn1054_1A49)
;;     1054:23DD (in fn1054_1A49)
;;     1054:23FD (in fn1054_1A49)
;;     1054:242E (in fn1054_1A49)
;;     1054:243C (in fn1054_1A49)
;;     1054:2EE3 (in fn1054_1A49)
;;     1054:2F12 (in fn1054_1A49)
;;     1054:2F41 (in fn1054_1A49)
;;     1054:2F61 (in fn1054_1A49)
;;     1054:30EB (in fn1054_1A49)
fn0800_7AF7 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[3662h]
	mov	cl,es:[54EAh]
	mov	ax,[bp+6h]
	shl	ax,cl
	mov	es,[3664h]
	or	es:[0D2AAh],ax
	mov	ax,[bp+8h]
	mov	es,[3662h]
	add	es:[54EAh],ax
	cmp	word ptr es:[54EAh],10h
	jge	7B32h

l0800_7B2F:
	jmp	7B84h

l0800_7B32:
	mov	es,[3664h]
	mov	ax,es:[0D2AAh]
	mov	es,[36EEh]
	les	bx,es:[022Ch]
	mov	es:[bx],ax
	mov	es,[36EEh]
	add	word ptr es:[022Ch],2h
	mov	es,[3662h]
	sub	word ptr es:[54EAh],10h
	cmp	word ptr es:[54EAh],0h
	jnz	7B65h

l0800_7B62:
	jmp	7B79h

l0800_7B65:
	mov	ax,[bp+6h]
	mov	cl,[bp+8h]
	mov	es,[3662h]
	sub	cl,es:[54EAh]
	sar	ax,cl
	jmp	7B7Ch

l0800_7B79:
	mov	ax,0h

l0800_7B7C:
	mov	es,[3664h]
	mov	es:[0D2AAh],ax

l0800_7B84:
	pop	si
	pop	di
	leave
	retf

;; fn0800_7B88: 0800:7B88
;;   Called from:
;;     0800:6083 (in fn0800_550A)
;;     1054:2195 (in fn1054_1A49)
fn0800_7B88 proc
	push	bp
	mov	bp,sp
	mov	ax,18h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	al,[bp+0Ah]
	and	ax,80h
	mov	[bp-0Ch],ax
	mov	al,[bp+0Bh]
	and	al,3h
	cbw
	mov	[bp-14h],ax
	mov	al,[bp+0Bh]
	and	al,0Ch
	cbw
	sar	ax,2h
	mov	[bp-4h],ax
	mov	al,[bp+0Bh]
	and	al,70h
	cbw
	sar	ax,4h
	mov	[bp-2h],ax
	cmp	word ptr [bp-2h],0h
	jz	7BC8h

l0800_7BC5:
	jmp	7BCDh

l0800_7BC8:
	mov	word ptr [bp-2h],8h

l0800_7BCD:
	mov	es,[36AAh]
	cmp	word ptr es:[5B8Ch],0h
	jnz	7BDCh

l0800_7BD9:
	jmp	7BE5h

l0800_7BDC:
	cmp	word ptr [bp-0Ch],0h
	jnz	7BE5h

l0800_7BE2:
	jmp	7BFDh

l0800_7BE5:
	mov	es,[36AAh]
	cmp	word ptr es:[5B8Ch],0h
	jz	7BF4h

l0800_7BF1:
	jmp	7C09h

l0800_7BF4:
	cmp	word ptr [bp-0Ch],0h
	jnz	7BFDh

l0800_7BFA:
	jmp	7C09h

l0800_7BFD:
	push	ds
	push	1E55h
	call	far 149Ah:0ABCh
	add	sp,4h

l0800_7C09:
	mov	word ptr [bp-0Ah],234h
	mov	word ptr [bp-8h],180Ah
	mov	es,[365Eh]
	mov	ax,es:[0A7E0h]
	mov	dx,es:[0A7E2h]
	mov	[bp-10h],ax
	mov	[bp-0Eh],dx
	cmp	word ptr [bp-0Ch],0h
	jnz	7C2Fh

l0800_7C2C:
	jmp	7CB5h

l0800_7C2F:
	mov	di,[bp+8h]

l0800_7C32:
	dec	di
	cmp	di,0h
	jge	7C3Bh

l0800_7C38:
	jmp	7CB2h

l0800_7C3B:
	push	8h
	les	bx,[bp-0Ah]
	mov	al,es:[bx]
	sub	ah,ah
	mov	[bp-6h],ax
	push	ax
	call	far 0800h:7AF7h
	add	sp,4h
	add	word ptr [bp-0Ah],4h
	mov	cl,[bp-4h]
	mov	al,[bp-6h]
	and	ax,0F0h
	shr	al,4h
	shl	ax,cl
	mov	[bp-12h],ax
	mov	cl,[bp-14h]
	mov	al,[bp-6h]
	and	ax,0Fh
	shl	ax,cl
	mov	[bp-6h],ax
	mov	ax,[bp-6h]
	add	[bp-10h],ax
	mov	si,[bp+6h]
	sub	si,[bp-12h]
	sub	si,[bp-6h]

l0800_7C83:
	dec	si
	cmp	si,0h
	jge	7C8Ch

l0800_7C89:
	jmp	7CA6h

l0800_7C8C:
	push	word ptr [bp-2h]
	les	bx,[bp-10h]
	inc	word ptr [bp-10h]
	mov	al,es:[bx]
	sub	ah,ah
	push	ax
	call	far 0800h:7AF7h
	add	sp,4h
	jmp	7C83h

l0800_7CA6:
	mov	ax,[bp+0Ch]
	add	ax,[bp-12h]
	add	[bp-10h],ax
	jmp	7C32h

l0800_7CB2:
	jmp	7CF0h

l0800_7CB5:
	mov	di,[bp+8h]

l0800_7CB8:
	dec	di
	cmp	di,0h
	jge	7CC1h

l0800_7CBE:
	jmp	7CF0h

l0800_7CC1:
	mov	si,[bp+6h]

l0800_7CC4:
	dec	si
	cmp	si,0h
	jge	7CCDh

l0800_7CCA:
	jmp	7CE7h

l0800_7CCD:
	push	word ptr [bp-2h]
	les	bx,[bp-10h]
	inc	word ptr [bp-10h]
	mov	al,es:[bx]
	sub	ah,ah
	push	ax
	call	far 0800h:7AF7h
	add	sp,4h
	jmp	7CC4h

l0800_7CE7:
	mov	ax,[bp+0Ch]
	add	[bp-10h],ax
	jmp	7CB8h

l0800_7CF0:
	mov	es,[36ECh]
	cmp	byte ptr es:[0FDCCh],0h
	jnz	7CFFh

l0800_7CFC:
	jmp	7D21h

l0800_7CFF:
	mov	es,[3662h]
	cmp	word ptr es:[54EAh],0h
	jnz	7D0Eh

l0800_7D0B:
	jmp	7D21h

l0800_7D0E:
	mov	ax,10h
	sub	ax,es:[54EAh]
	push	ax
	push	0h
	call	far 0800h:7AF7h
	add	sp,4h

l0800_7D21:
	pop	si
	pop	di
	leave
	retf

;; fn0800_7D25: 0800:7D25
;;   Called from:
;;     0800:5FA5 (in fn0800_550A)
;;     1054:029A (in fn1054_0104)
;;     1054:20E0 (in fn1054_1A49)
fn0800_7D25 proc
	push	bp
	mov	bp,sp
	mov	ax,8h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[3682h]
	mov	ax,es:[0D29Eh]
	mov	dx,es:[0D2A0h]
	add	ax,[bp+6h]
	adc	dx,[bp+8h]
	mov	[bp-8h],ax
	mov	[bp-6h],dx
	mov	es,[3704h]
	mov	ax,es:[0D06Ch]
	or	ax,es:[0D06Ah]
	jnz	7D5Dh

l0800_7D5A:
	jmp	7D6Dh

l0800_7D5D:
	mov	es,[3704h]
	mov	ax,es:[0D06Ah]
	mov	dx,es:[0D06Ch]
	jmp	7D7Ah

l0800_7D6D:
	mov	es,[368Ah]
	mov	ax,es:[2A28h]
	mov	dx,es:[2A2Ah]

l0800_7D7A:
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	mov	ax,[bp-8h]
	mov	dx,[bp-6h]
	cmp	[bp-2h],dx
	jbe	7D8Eh

l0800_7D8B:
	jmp	7DB4h

l0800_7D8E:
	jnc	7D93h

l0800_7D90:
	jmp	7D9Bh

l0800_7D93:
	cmp	[bp-4h],ax
	jc	7D9Bh

l0800_7D98:
	jmp	7DB4h

l0800_7D9B:
	mov	es,[36A0h]
	mov	byte ptr es:[0232h],0h
	mov	es,[36BAh]
	inc	word ptr es:[0212h]
	mov	ax,0FFFFh
	jmp	7DCDh

l0800_7DB4:
	mov	ax,[bp-8h]
	mov	dx,[bp-6h]
	mov	es,[3682h]
	mov	es:[0D29Eh],ax
	mov	es:[0D2A0h],dx
	mov	ax,0h
	jmp	7DCDh

l0800_7DCD:
	pop	si
	pop	di
	leave
	retf

;; fn0800_7DD1: 0800:7DD1
;;   Called from:
;;     0800:1FB2 (in main)
fn0800_7DD1 proc
	push	bp
	mov	bp,sp
	mov	ax,26h
	call	far 149Ah:02C8h
	push	di
	push	si
	push	2Ch
	push	180Ah
	push	0FA0Ah
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	call	far 149Ah:2030h
	add	sp,8h
	mov	es,[36FCh]
	cmp	word ptr es:[0FA2Ch],64h
	jnz	7E06h

l0800_7E03:
	jmp	7E1Ch

l0800_7E06:
	push	ds
	push	1E8Dh
	call	far 149Ah:0ABCh
	add	sp,4h
	push	0FAh
	call	far 0800h:02C7h
	add	sp,2h

l0800_7E1C:
	mov	word ptr [bp-6h],0h
	mov	word ptr [bp-16h],0h
	jmp	7E2Ch

l0800_7E29:
	inc	word ptr [bp-16h]

l0800_7E2C:
	mov	es,[36FCh]
	mov	bx,[bp-16h]
	cmp	byte ptr es:[bx+0FA0Ah],0h
	jnz	7E3Eh

l0800_7E3B:
	jmp	7E4Dh

l0800_7E3E:
	mov	bx,[bp-16h]
	mov	al,es:[bx+0FA0Ah]
	cbw
	add	[bp-6h],ax
	jmp	7E29h

l0800_7E4D:
	mov	es,[36FCh]
	mov	ax,[bp-6h]
	cmp	es:[0FA2Ah],ax
	jnz	7E5Eh

l0800_7E5B:
	jmp	7E74h

l0800_7E5E:
	push	ds
	push	1EB9h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	0FAh
	call	far 0800h:02C7h
	add	sp,2h

l0800_7E74:
	push	ds
	push	1EDCh
	push	180Ah
	push	0FA0Ah
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jnz	7E8Eh

l0800_7E8B:
	jmp	7E9Eh

l0800_7E8E:
	push	ds
	push	6C2h
	push	ds
	push	1EE4h
	call	far 149Ah:0ABCh
	add	sp,8h

l0800_7E9E:
	push	18h
	push	381Dh
	push	2A0Ah
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	call	far 149Ah:2030h
	add	sp,8h
	cmp	ax,0h
	jnz	7EBFh

l0800_7EBC:
	jmp	8080h

l0800_7EBF:
	mov	es,[36B0h]
	inc	word ptr es:[2C72h]
	mov	es,[3700h]
	cmp	word ptr es:[2A1Ah],0h
	jge	7ED7h

l0800_7ED4:
	jmp	7EE4h

l0800_7ED7:
	push	word ptr es:[2A1Ah]
	call	far 0800h:0D60h
	add	sp,2h

l0800_7EE4:
	mov	es,[3700h]
	push	word ptr es:[2A0Ch]
	push	word ptr es:[2A0Ah]
	call	far 0800h:77A8h
	add	sp,4h
	sub	ax,ax
	mov	[bp-1Eh],ax
	mov	[bp-20h],ax
	mov	es,[3700h]
	mov	ax,es:[2A0Eh]
	mov	dx,es:[2A10h]
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	mov	es,[3682h]
	push	word ptr es:[0D2A0h]
	push	word ptr es:[0D29Eh]
	call	far 1481h:0004h
	add	sp,4h
	mov	es,[3682h]
	mov	ax,es:[0D29Eh]
	mov	dx,es:[0D2A0h]
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	mov	word ptr [bp-0Ch],0FFFFh

l0800_7F43:
	mov	ax,[bp-2h]
	or	ax,[bp-4h]
	jnz	7F4Eh

l0800_7F4B:
	jmp	804Ah

l0800_7F4E:
	inc	word ptr [bp-0Ch]
	mov	ax,[bp-4h]
	mov	dx,[bp-2h]
	cmp	dx,0h
	jge	7F5Fh

l0800_7F5C:
	jmp	7F72h

l0800_7F5F:
	jle	7F64h

l0800_7F61:
	jmp	7F6Ch

l0800_7F64:
	cmp	ax,0FFDCh
	ja	7F6Ch

l0800_7F69:
	jmp	7F72h

l0800_7F6C:
	mov	dx,0h
	mov	ax,0FFDCh

l0800_7F72:
	mov	[bp-1Ch],ax
	mov	[bp-1Ah],dx
	push	word ptr [bp-1Ch]
	mov	es,[3624h]
	push	word ptr es:[0FA04h]
	push	word ptr es:[0FA02h]
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	call	far 149Ah:2030h
	add	sp,8h
	mov	ax,[bp-1Ch]
	mov	dx,[bp-1Ah]
	sub	[bp-4h],ax
	sbb	[bp-2h],dx
	mov	es,[3624h]
	mov	ax,es:[0FA02h]
	mov	dx,es:[0FA04h]
	mov	[bp-10h],ax
	mov	[bp-0Eh],dx
	mov	ax,[bp-1Ch]
	mov	dx,[bp-1Ah]
	shr	dx,1h
	rcr	ax,1h
	mov	[bp-14h],ax
	mov	[bp-12h],dx

l0800_7FC9:
	mov	ax,[bp-14h]
	mov	dx,[bp-12h]
	sub	word ptr [bp-14h],1h
	sbb	word ptr [bp-12h],0h
	or	dx,ax
	jnz	7FDEh

l0800_7FDB:
	jmp	7FF3h

l0800_7FDE:
	les	bx,[bp-10h]
	add	word ptr [bp-10h],2h
	mov	ax,es:[bx]
	sub	dx,dx
	add	[bp-20h],ax
	adc	[bp-1Eh],dx
	jmp	7FC9h

l0800_7FF3:
	mov	ax,[bp-1Ch]
	mov	dx,[bp-1Ah]
	shr	dx,1h
	rcr	ax,1h
	mov	[bp-22h],ax
	push	word ptr [bp-22h]
	mov	es,[3624h]
	push	word ptr es:[0FA04h]
	push	word ptr es:[0FA02h]
	call	far 1496h:000Ch
	add	sp,6h
	mov	ax,[bp-1Ch]
	mov	dx,[bp-1Ah]
	shl	ax,1h
	rcl	dx,1h
	shl	ax,1h
	rcl	dx,1h
	shl	ax,1h
	rcl	dx,1h
	add	[bp-0Ah],ax
	adc	[bp-8h],dx
	mov	ax,[bp-1Ch]
	mov	dx,[bp-1Ah]
	mov	es,[3694h]
	les	bx,es:[077Ch]
	add	es:[bx],ax
	adc	es:[bx+2h],dx
	jmp	7F43h

l0800_804A:
	mov	ax,[bp-20h]
	mov	dx,[bp-1Eh]
	mov	es,[3700h]
	cmp	es:[2A12h],ax
	jz	805Eh

l0800_805B:
	jmp	8068h

l0800_805E:
	cmp	es:[2A14h],dx
	jnz	8068h

l0800_8065:
	jmp	807Dh

l0800_8068:
	mov	es,[36B0h]
	push	word ptr es:[2C72h]
	push	ds
	push	1F1Eh
	call	far 149Ah:0ABCh
	add	sp,6h

l0800_807D:
	jmp	7E9Eh

l0800_8080:
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	call	far 149Ah:1DCAh
	add	sp,2h
	pop	si
	pop	di
	leave
	retf

;; fn0800_8095: 0800:8095
;;   Called from:
;;     0800:2392 (in main)
;;     0800:3BC2 (in main)
;;     0800:6057 (in fn0800_550A)
;;     1054:0250 (in fn1054_0104)
;;     1054:02FA (in fn1054_0104)
;;     1054:217A (in fn1054_1A49)
fn0800_8095 proc
	push	bp
	mov	bp,sp
	mov	ax,10h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[36EEh]
	mov	ax,es:[022Ch]
	mov	es,[3624h]
	sub	ax,es:[0FA02h]
	mov	[bp-0Eh],ax
	mov	ax,[bp+8h]
	or	ax,[bp+6h]
	jz	80C1h

l0800_80BE:
	jmp	8108h

l0800_80C1:
	mov	es,[3662h]
	cmp	word ptr es:[54EAh],0h
	jnz	80D0h

l0800_80CD:
	jmp	8105h

l0800_80D0:
	mov	es,[3664h]
	mov	ax,es:[0D2AAh]
	mov	es,[36EEh]
	les	bx,es:[022Ch]
	mov	es:[bx],ax
	mov	es,[36EEh]
	add	word ptr es:[022Ch],2h
	add	word ptr [bp-0Eh],2h
	mov	ax,0h
	mov	es,[3662h]
	mov	es:[54EAh],ax
	mov	es,[3664h]
	mov	es:[0D2AAh],ax

l0800_8105:
	jmp	8138h

l0800_8108:
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	sar	dx,1h
	rcr	ax,1h
	sar	dx,1h
	rcr	ax,1h
	sar	dx,1h
	rcr	ax,1h
	add	ax,[bp-0Eh]
	adc	dx,0h
	cmp	dx,0h
	jle	8128h

l0800_8125:
	jmp	8138h

l0800_8128:
	jge	812Dh

l0800_812A:
	jmp	8135h

l0800_812D:
	cmp	ax,0FFDCh
	jc	8135h

l0800_8132:
	jmp	8138h

l0800_8135:
	jmp	83C1h

l0800_8138:
	mov	ax,[bp-0Eh]
	shr	ax,1h
	mov	[bp-0Ah],ax
	mov	es,[36CCh]
	cmp	byte ptr es:[0FED8h],0h
	jnz	814Fh

l0800_814C:
	jmp	81B2h

l0800_814F:
	mov	ax,[bp-0Eh]
	sub	dx,dx
	mov	es,[3694h]
	les	bx,es:[077Ch]
	add	es:[bx],ax
	adc	es:[bx+2h],dx
	mov	es,[3688h]
	push	word ptr es:[0FBC8h]
	push	word ptr es:[0FBC6h]
	call	far 1481h:0004h
	add	sp,4h
	push	word ptr [bp-0Ah]
	mov	es,[3624h]
	push	word ptr es:[0FA04h]
	push	word ptr es:[0FA02h]
	call	far 1496h:000Ch
	add	sp,6h
	mov	ax,[bp-0Eh]
	sub	dx,dx
	shl	ax,1h
	rcl	dx,1h
	shl	ax,1h
	rcl	dx,1h
	shl	ax,1h
	rcl	dx,1h
	mov	es,[3688h]
	add	es:[0FBC6h],ax
	adc	es:[0FBC8h],dx

l0800_81B2:
	mov	es,[36D4h]
	cmp	byte ptr es:[4CBEh],0h
	jnz	81C1h

l0800_81BE:
	jmp	83A7h

l0800_81C1:
	mov	es,[3700h]
	mov	ax,es:[2A10h]
	or	ax,es:[2A0Eh]
	jz	81D3h

l0800_81D0:
	jmp	8201h

l0800_81D3:
	cmp	word ptr [bp-0Eh],0h
	ja	81DCh

l0800_81D9:
	jmp	8201h

l0800_81DC:
	mov	word ptr es:[2A16h],4h
	mov	word ptr es:[2A18h],0h
	push	18h
	push	es
	push	2A0Ah
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	call	far 149Ah:212Eh
	add	sp,8h

l0800_8201:
	mov	ax,[bp-0Eh]
	sub	dx,dx
	mov	es,[3700h]
	add	es:[2A0Eh],ax
	adc	es:[2A10h],dx
	mov	es,[3624h]
	mov	ax,es:[0FA02h]
	mov	dx,es:[0FA04h]
	mov	[bp-8h],ax
	mov	[bp-6h],dx
	mov	ax,[bp-0Ah]
	mov	[bp-0Ch],ax

l0800_822D:
	mov	ax,[bp-0Ch]
	dec	word ptr [bp-0Ch]
	cmp	ax,0h
	jnz	823Bh

l0800_8238:
	jmp	8258h

l0800_823B:
	les	bx,[bp-8h]
	add	word ptr [bp-8h],2h
	mov	ax,es:[bx]
	sub	dx,dx
	mov	es,[3700h]
	add	es:[2A12h],ax
	adc	es:[2A14h],dx
	jmp	822Dh

l0800_8258:
	push	word ptr [bp-0Eh]
	mov	es,[3624h]
	push	word ptr es:[0FA04h]
	push	word ptr es:[0FA02h]
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	call	far 149Ah:212Eh
	add	sp,8h
	mov	ax,[bp-0Eh]
	sub	dx,dx
	mov	es,[369Eh]
	les	bx,es:[0D06Eh]
	add	es:[bx],ax
	adc	es:[bx+2h],dx
	mov	ax,[bp+8h]
	or	ax,[bp+6h]
	jz	829Ah

l0800_8297:
	jmp	8383h

l0800_829A:
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	call	far 149Ah:28C2h
	add	sp,2h
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	push	0h
	mov	es,[36FEh]
	push	word ptr es:[5C9Ch]
	push	word ptr es:[5C9Ah]
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	call	far 149Ah:1DEAh
	add	sp,8h
	mov	es,[3684h]
	mov	ax,es:[2A06h]
	mov	dx,es:[2A08h]
	mov	es,[3700h]
	mov	es:[2A0Ah],ax
	mov	es:[2A0Ch],dx
	mov	es,[36A4h]
	cmp	word ptr es:[0F1FCh],0h
	jnz	82FBh

l0800_82F8:
	jmp	8306h

l0800_82FB:
	mov	es,[36A6h]
	mov	ax,es:[54E2h]
	jmp	8309h

l0800_8306:
	mov	ax,0FFFFh

l0800_8309:
	mov	es,[3700h]
	mov	es:[2A1Ah],ax
	mov	word ptr es:[2A16h],4h
	mov	word ptr es:[2A18h],0h
	push	18h
	push	es
	push	2A0Ah
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	call	far 149Ah:212Eh
	add	sp,8h
	push	0h
	push	word ptr [bp-2h]
	push	word ptr [bp-4h]
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	call	far 149Ah:1DEAh
	add	sp,8h
	mov	ax,[bp-4h]
	mov	dx,[bp-2h]
	mov	es,[36FEh]
	mov	es:[5C9Ah],ax
	mov	es:[5C9Ch],dx
	mov	es,[36B0h]
	inc	word ptr es:[2C72h]
	mov	es,[3700h]
	sub	ax,ax
	mov	es:[2A10h],ax
	mov	es:[2A0Eh],ax
	sub	ax,ax
	mov	es:[2A14h],ax
	mov	es:[2A12h],ax

l0800_8383:
	mov	es,[36DAh]
	cmp	word ptr es:[5CA2h],0h
	jnz	8392h

l0800_838F:
	jmp	83A7h

l0800_8392:
	mov	es,[3680h]
	push	word ptr es:[0D2A8h]
	push	ds
	push	1F4Bh
	call	far 149Ah:0ABCh
	add	sp,6h

l0800_83A7:
	mov	es,[3624h]
	mov	ax,es:[0FA02h]
	mov	dx,es:[0FA04h]
	mov	es,[36EEh]
	mov	es:[022Ch],ax
	mov	es:[022Eh],dx

l0800_83C1:
	pop	si
	pop	di
	leave
	retf

;; fn0800_83C5: 0800:83C5
;;   Called from:
;;     0800:6D5A (in fn0800_550A)
fn0800_83C5 proc
	push	bp
	mov	bp,sp
	mov	ax,10h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	ax,[bp+6h]
	mov	[bp-10h],ax
	mov	ax,[bp+0Ah]
	mov	dx,[bp+0Ch]
	mov	[bp-6h],ax
	mov	[bp-4h],dx
	mov	ax,[bp+0Ah]
	mov	dx,[bp+0Ch]
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	mov	[bp-0Eh],ax
	mov	[bp-0Ch],dx
	mov	di,[bp+6h]
	shl	di,1h
	sar	word ptr [bp+6h],1h
	mov	ax,[bp+6h]
	add	ax,3h
	and	ax,0FFFCh
	sub	ax,[bp+6h]
	mov	[bp-2h],ax
	test	byte ptr [bp+8h],1h
	jnz	8416h

l0800_8413:
	jmp	841Ah

l0800_8416:
	and	word ptr [bp+8h],0FEh

l0800_841A:
	sub	word ptr [bp+8h],2h
	cmp	word ptr [bp+8h],0h
	jge	8427h

l0800_8424:
	jmp	8493h

l0800_8427:
	mov	si,[bp+6h]

l0800_842A:
	dec	si
	cmp	si,0h
	jge	8433h

l0800_8430:
	jmp	845Dh

l0800_8433:
	push	word ptr [bp+12h]
	push	word ptr [bp+10h]
	push	word ptr [bp+0Eh]
	push	word ptr [bp-0Ch]
	push	word ptr [bp-0Eh]
	push	word ptr [bp-10h]
	call	far 146Ch:0004h
	add	sp,0Ch
	les	bx,[bp-6h]
	inc	word ptr [bp-6h]
	mov	es:[bx],al
	add	word ptr [bp-0Eh],2h
	jmp	842Ah

l0800_845D:
	mov	si,[bp-2h]

l0800_8460:
	dec	si
	cmp	si,0h
	jge	8469h

l0800_8466:
	jmp	8476h

l0800_8469:
	les	bx,[bp-6h]
	inc	word ptr [bp-6h]
	mov	byte ptr es:[bx],0h
	jmp	8460h

l0800_8476:
	mov	ax,[bp-0Ah]
	mov	dx,[bp-8h]
	add	ax,di
	mov	[bp-0Eh],ax
	mov	[bp-0Ch],dx
	mov	ax,[bp-0Eh]
	mov	dx,[bp-0Ch]
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	jmp	841Ah

l0800_8493:
	pop	si
	pop	di
	leave
	retf

;; fn0800_8497: 0800:8497
;;   Called from:
;;     0800:6CED (in fn0800_550A)
;;     0800:6D94 (in fn0800_550A)
fn0800_8497 proc
	push	bp
	mov	bp,sp
	mov	ax,0Eh
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	ax,[bp+0Ah]
	mov	dx,[bp+0Ch]
	mov	[bp-6h],ax
	mov	[bp-4h],dx
	mov	ax,[bp+0Ah]
	mov	dx,[bp+0Ch]
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	mov	[bp-0Eh],ax
	mov	[bp-0Ch],dx
	mov	di,[bp+6h]
	shl	di,1h
	sar	word ptr [bp+6h],1h
	mov	ax,[bp+6h]
	add	ax,3h
	and	ax,0FFFCh
	sub	ax,[bp+6h]
	mov	[bp-2h],ax
	test	byte ptr [bp+8h],1h
	jnz	84E2h

l0800_84DF:
	jmp	84E5h

l0800_84E2:
	inc	word ptr [bp+8h]

l0800_84E5:
	sub	word ptr [bp+8h],2h
	cmp	word ptr [bp+8h],0h
	jge	84F2h

l0800_84EF:
	jmp	854Ah

l0800_84F2:
	mov	si,[bp+6h]

l0800_84F5:
	dec	si
	cmp	si,0h
	jge	84FEh

l0800_84FB:
	jmp	8514h

l0800_84FE:
	les	bx,[bp-0Eh]
	mov	al,es:[bx]
	les	bx,[bp-6h]
	inc	word ptr [bp-6h]
	mov	es:[bx],al
	add	word ptr [bp-0Eh],2h
	jmp	84F5h

l0800_8514:
	mov	si,[bp-2h]

l0800_8517:
	dec	si
	cmp	si,0h
	jge	8520h

l0800_851D:
	jmp	852Dh

l0800_8520:
	les	bx,[bp-6h]
	inc	word ptr [bp-6h]
	mov	byte ptr es:[bx],0h
	jmp	8517h

l0800_852D:
	mov	ax,[bp-0Ah]
	mov	dx,[bp-8h]
	add	ax,di
	mov	[bp-0Eh],ax
	mov	[bp-0Ch],dx
	mov	ax,[bp-0Eh]
	mov	dx,[bp-0Ch]
