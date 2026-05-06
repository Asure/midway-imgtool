;;; Segment 1054 (1054:0000)
1054:0000 F4 89 46 F6 89 56 F8 E9 9B FF                   ..F..V....      

l0800_854A:
	pop	si
	pop	di
	leave
	retf

;; fn1054_000E: 1054:000E
;;   Called from:
;;     1054:1D19 (in fn1054_1A49)
;;     1054:26D7 (in fn1054_1A49)
;;     1054:2700 (in fn1054_1A49)
;;     1054:3472 (in fn1054_1A49)
;;     1054:349E (in fn1054_1A49)
;;     1054:34AD (in fn1054_1A49)
fn1054_000E proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	add	ax,4h
	jmp	0027h

l1054_0027:
	pop	si
	pop	di
	leave
	retf

;; fn1054_002B: 1054:002B
;;   Called from:
;;     1054:1B4F (in fn1054_1A49)
;;     1054:1B9C (in fn1054_1A49)
;;     1054:1BF1 (in fn1054_1A49)
;;     1054:1C0D (in fn1054_1A49)
;;     1054:1C27 (in fn1054_1A49)
;;     1054:1C45 (in fn1054_1A49)
;;     1054:1C70 (in fn1054_1A49)
;;     1054:1C9C (in fn1054_1A49)
;;     1054:1CBA (in fn1054_1A49)
;;     1054:1D7A (in fn1054_1A49)
;;     1054:1DC6 (in fn1054_1A49)
;;     1054:1E32 (in fn1054_1A49)
;;     1054:1E88 (in fn1054_1A49)
;;     1054:2320 (in fn1054_1A49)
;;     1054:2483 (in fn1054_1A49)
;;     1054:24BE (in fn1054_1A49)
;;     1054:24F7 (in fn1054_1A49)
;;     1054:27C4 (in fn1054_1A49)
;;     1054:2847 (in fn1054_1A49)
;;     1054:28A7 (in fn1054_1A49)
;;     1054:297E (in fn1054_1A49)
;;     1054:2D35 (in fn1054_1A49)
;;     1054:3513 (in fn1054_1A49)
;;     1054:3535 (in fn1054_1A49)
;;     1054:35C4 (in fn1054_35A1)
;;     1054:3951 (in fn1054_38F9)
fn1054_002B proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[3736h]
	cmp	word ptr es:[5B62h],0Ah
	jl	0047h

l1054_0044:
	jmp	0075h

l1054_0047:
	inc	word ptr es:[5B62h]
	push	ds
	push	1F70h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	word ptr [bp+12h]
	push	word ptr [bp+10h]
	push	word ptr [bp+0Eh]
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:0ABCh
	add	sp,0Eh

l1054_0075:
	push	1h
	call	far 0800h:02C7h
	add	sp,2h
	pop	si
	pop	di
	leave
	retf

;; fn1054_0083: 1054:0083
;;   Called from:
;;     1054:1EFE (in fn1054_1A49)
;;     1054:1F18 (in fn1054_1A49)
fn1054_0083 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	cmp	word ptr [bp+6h],80h
	jge	009Ah

l1054_0097:
	jmp	00A0h

l1054_009A:
	mov	ax,8h
	jmp	0100h

l1054_00A0:
	cmp	word ptr [bp+6h],40h
	jge	00A9h

l1054_00A6:
	jmp	00AFh

l1054_00A9:
	mov	ax,7h
	jmp	0100h

l1054_00AF:
	cmp	word ptr [bp+6h],20h
	jge	00B8h

l1054_00B5:
	jmp	00BEh

l1054_00B8:
	mov	ax,6h
	jmp	0100h

l1054_00BE:
	cmp	word ptr [bp+6h],10h
	jge	00C7h

l1054_00C4:
	jmp	00CDh

l1054_00C7:
	mov	ax,5h
	jmp	0100h

l1054_00CD:
	cmp	word ptr [bp+6h],8h
	jge	00D6h

l1054_00D3:
	jmp	00DCh

l1054_00D6:
	mov	ax,4h
	jmp	0100h

l1054_00DC:
	cmp	word ptr [bp+6h],4h
	jge	00E5h

l1054_00E2:
	jmp	00EBh

l1054_00E5:
	mov	ax,3h
	jmp	0100h

l1054_00EB:
	cmp	word ptr [bp+6h],2h
	jge	00F4h

l1054_00F1:
	jmp	00FAh

l1054_00F4:
	mov	ax,2h
	jmp	0100h

l1054_00FA:
	mov	ax,1h
	jmp	0100h

l1054_0100:
	pop	si
	pop	di
	leave
	retf

;; fn1054_0104: 1054:0104
;;   Called from:
;;     0800:2F6D (in main)
fn1054_0104 proc
	push	bp
	mov	bp,sp
	mov	ax,0Ah
	call	far 149Ah:02C8h
	push	di
	push	si
	push	ds
	push	1F83h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:2568h
	add	sp,8h
	push	8000h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:1E7Eh
	add	sp,6h
	mov	[bp-2h],ax
	cmp	word ptr [bp-2h],0h
	jle	0140h

l1054_013D:
	jmp	0155h

l1054_0140:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1F88h
	call	far 149Ah:0ABCh
	add	sp,8h
	jmp	032Eh

l1054_0155:
	push	2Eh
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	or	dx,ax
	jnz	0172h

l1054_016F:
	jmp	0179h

l1054_0172:
	les	bx,[bp-0Ah]
	mov	byte ptr es:[bx],0h

l1054_0179:
	push	5Ch
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:29B0h
	add	sp,6h
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	mov	ax,[bp-8h]
	or	ax,[bp-0Ah]
	jz	019Ah

l1054_0197:
	jmp	01A9h

l1054_019A:
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	jmp	01ACh

l1054_01A9:
	inc	word ptr [bp-0Ah]

l1054_01AC:
	mov	es,[3738h]
	cmp	word ptr es:[54EAh],0h
	jnz	01BBh

l1054_01B8:
	jmp	01ECh

l1054_01BB:
	mov	es,[373Ah]
	mov	ax,es:[0D2AAh]
	mov	es,[373Ch]
	les	bx,es:[022Ch]
	mov	es:[bx],ax
	mov	es,[373Ch]
	add	word ptr es:[022Ch],2h
	mov	ax,0h
	mov	es,[3738h]
	mov	es:[54EAh],ax
	mov	es,[373Ah]
	mov	es:[0D2AAh],ax

l1054_01EC:
	mov	es,[373Eh]
	mov	ax,es:[0D29Eh]
	mov	dx,es:[0D2A0h]
	add	ax,0Fh
	adc	dx,0h
	and	ax,0FFF0h
	and	dx,0FFh
	mov	es:[0D29Eh],ax
	mov	es:[0D2A0h],dx
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	021Dh

l1054_021A:
	jmp	024Bh

l1054_021D:
	mov	es,[373Eh]
	push	word ptr es:[0D2A0h]
	push	word ptr es:[0D29Eh]
	push	word ptr [bp-8h]
	push	word ptr [bp-0Ah]
	push	ds
	push	1FA4h
	mov	es,[3742h]
	push	word ptr es:[5CA6h]
	push	word ptr es:[5CA4h]
	call	far 149Ah:0752h
	add	sp,10h

l1054_024B:
	push	7h
	push	0D000h
	call	far 0800h:8095h
	add	sp,4h

l1054_0258:
	push	0FA00h
	mov	es,[373Ch]
	push	word ptr es:[022Eh]
	push	word ptr es:[022Ch]
	push	word ptr [bp-2h]
	call	far 149Ah:2030h
	add	sp,8h
	mov	si,ax
	cmp	si,0h
	jnz	027Eh

l1054_027B:
	jmp	0323h

l1054_027E:
	test	si,1h
	jnz	0287h

l1054_0284:
	jmp	0288h

l1054_0287:
	inc	si

l1054_0288:
	mov	ax,si
	sub	dx,dx
	shl	ax,1h
	rcl	dx,1h
	shl	ax,1h
	rcl	dx,1h
	shl	ax,1h
	rcl	dx,1h
	push	dx
	push	ax
	call	far 0800h:7D25h
	add	sp,4h
	cmp	ax,0h
	jl	02AAh

l1054_02A7:
	jmp	02BFh

l1054_02AA:
	push	word ptr [bp-8h]
	push	word ptr [bp-0Ah]
	push	ds
	push	1FB3h
	call	far 149Ah:0ABCh
	add	sp,8h
	jmp	0323h

l1054_02BF:
	mov	es,[3744h]
	cmp	byte ptr es:[0232h],0h
	jnz	02CEh

l1054_02CB:
	jmp	0302h

l1054_02CE:
	mov	es,[3746h]
	cmp	byte ptr es:[0FED8h],0h
	jz	02DDh

l1054_02DA:
	jmp	02ECh

l1054_02DD:
	mov	es,[3748h]
	cmp	byte ptr es:[4CBEh],0h
	jnz	02ECh

l1054_02E9:
	jmp	0302h

l1054_02EC:
	mov	es,[373Ch]
	add	es:[022Ch],si
	push	7h
	push	0D000h
	call	far 0800h:8095h
	add	sp,4h

l1054_0302:
	mov	ax,si
	sub	dx,dx
	shl	ax,1h
	rcl	dx,1h
	shl	ax,1h
	rcl	dx,1h
	shl	ax,1h
	rcl	dx,1h
	mov	es,[374Ah]
	add	es:[0D2A2h],ax
	adc	es:[0D2A4h],dx
	jmp	0258h

l1054_0323:
	push	word ptr [bp-2h]
	call	far 149Ah:1DCAh
	add	sp,2h

l1054_032E:
	pop	si
	pop	di
	leave
	retf

;; fn1054_0332: 1054:0332
;;   Called from:
;;     1054:0538 (in fn1054_03DA)
fn1054_0332 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[374Ch]
	mov	si,es:[0FF1Eh]

l1054_0348:
	dec	si
	cmp	si,0h
	jge	0351h

l1054_034E:
	jmp	037Ch

l1054_0351:
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	mov	es,[374Eh]
	mov	bx,si
	shl	bx,2h
	cmp	es:[bx+0F22Eh],ax
	jz	036Ah

l1054_0367:
	jmp	0379h

l1054_036A:
	cmp	es:[bx+0F230h],dx
	jz	0374h

l1054_0371:
	jmp	0379h

l1054_0374:
	mov	ax,si
	jmp	0382h

l1054_0379:
	jmp	0348h

l1054_037C:
	mov	ax,0FFFFh
	jmp	0382h

l1054_0382:
	pop	si
	pop	di
	leave
	retf

;; fn1054_0386: 1054:0386
;;   Called from:
;;     1054:0B75 (in fn1054_0792)
fn1054_0386 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[374Ch]
	mov	si,es:[0FF28h]

l1054_039C:
	dec	si
	cmp	si,0h
	jge	03A5h

l1054_03A2:
	jmp	03D0h

l1054_03A5:
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	mov	es,[3750h]
	mov	bx,si
	shl	bx,2h
	cmp	es:[bx+0FBCAh],ax
	jz	03BEh

l1054_03BB:
	jmp	03CDh

l1054_03BE:
	cmp	es:[bx+0FBCCh],dx
	jz	03C8h

l1054_03C5:
	jmp	03CDh

l1054_03C8:
	mov	ax,si
	jmp	03D6h

l1054_03CD:
	jmp	039Ch

l1054_03D0:
	mov	ax,0FFFFh
	jmp	03D6h

l1054_03D6:
	pop	si
	pop	di
	leave
	retf

;; fn1054_03DA: 1054:03DA
;;   Called from:
;;     1054:09F4 (in fn1054_0792)
;;     1054:0BA8 (in fn1054_0792)
;;     1054:138B (in fn1054_0DB3)
fn1054_03DA proc
	push	bp
	mov	bp,sp
	mov	ax,10h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	al,[bp+0Ch]
	mov	es,[3752h]
	mov	es:[0D2B6h],al
	mov	word ptr [bp-4h],0h
	les	bx,[bp+6h]
	test	byte ptr es:[bx+10h],2h
	jz	0404h

l1054_0401:
	jmp	0462h

l1054_0404:
	mov	es,[3754h]
	cmp	byte ptr es:[0FFE0h],0h
	jnz	0413h

l1054_0410:
	jmp	0433h

l1054_0413:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1FD8h
	mov	es,[3756h]
	push	word ptr es:[0206h]
	push	word ptr es:[0204h]
	call	far 149Ah:0752h
	add	sp,0Ch

l1054_0433:
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	0442h

l1054_043F:
	jmp	0462h

l1054_0442:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	1FDEh
	mov	es,[3758h]
	push	word ptr es:[0216h]
	push	word ptr es:[0214h]
	call	far 149Ah:0752h
	add	sp,0Ch

l1054_0462:
	mov	si,0h
	jmp	0469h

l1054_0468:
	inc	si

l1054_0469:
	les	bx,[bp+6h]
	cmp	es:[bx+12h],si
	jg	0475h

l1054_0472:
	jmp	0716h

l1054_0475:
	mov	di,si
	shl	di,2h
	les	bx,[bp+6h]
	add	bx,14h
	les	bx,es:[bx+di]
	mov	ax,es:[bx]
	mov	dx,es:[bx+2h]
	mov	[bp-10h],ax
	mov	[bp-0Eh],dx
	mov	ax,[bp-0Eh]
	or	ax,[bp-10h]
	jnz	049Bh

l1054_0498:
	jmp	06C3h

l1054_049B:
	les	bx,[bp+6h]
	test	byte ptr es:[bx+10h],2h
	jz	04A8h

l1054_04A5:
	jmp	0532h

l1054_04A8:
	mov	es,[3754h]
	cmp	byte ptr es:[0FFE0h],0h
	jnz	04B7h

l1054_04B4:
	jmp	0532h

l1054_04B7:
	cmp	word ptr [bp-4h],0h
	jnz	04C0h

l1054_04BD:
	jmp	04F8h

l1054_04C0:
	mov	di,si
	shl	di,2h
	les	bx,[bp+6h]
	add	bx,14h
	les	bx,es:[bx+di]
	mov	al,es:[bx+6h]
	sub	ah,ah
	push	ax
	push	word ptr [bp-0Eh]
	push	word ptr [bp-10h]
	push	ds
	push	1FF7h
	mov	es,[3756h]
	push	word ptr es:[0206h]
	push	word ptr es:[0204h]
	call	far 149Ah:0752h
	add	sp,0Eh
	jmp	052Dh

l1054_04F8:
	mov	di,si
	shl	di,2h
	les	bx,[bp+6h]
	add	bx,14h
	les	bx,es:[bx+di]
	mov	al,es:[bx+6h]
	sub	ah,ah
	push	ax
	push	word ptr [bp-0Eh]
	push	word ptr [bp-10h]
	push	ds
	push	2013h
	mov	es,[3756h]
	push	word ptr es:[0206h]
	push	word ptr es:[0204h]
	call	far 149Ah:0752h
	add	sp,0Eh

l1054_052D:
	mov	word ptr [bp-4h],0h

l1054_0532:
	push	word ptr [bp-0Eh]
	push	word ptr [bp-10h]
	call	far 1054h:0332h
	add	sp,4h
	mov	[bp-2h],ax
	les	bx,[bp-10h]
	test	byte ptr es:[bx+10h],2h
	jnz	0550h

l1054_054D:
	jmp	0679h

l1054_0550:
	push	word ptr [bp-2h]
	push	381Dh
	push	2C74h
	call	far 1054h:3E4Dh
	add	sp,6h
	sub	ah,ah
	mov	[bp-0Ch],ax
	cmp	word ptr [bp-0Ch],4h
	jge	056Fh

l1054_056C:
	jmp	062Bh

l1054_056F:
	test	byte ptr [bp-0Ch],2h
	jz	0578h

l1054_0575:
	jmp	05CDh

l1054_0578:
	mov	al,[bp-0Ch]
	and	al,0Ch
	cmp	al,8h
	jz	0584h

l1054_0581:
	jmp	05CAh

l1054_0584:
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	0593h

l1054_0590:
	jmp	05B3h

l1054_0593:
	push	word ptr [bp-0Eh]
	push	word ptr [bp-10h]
	push	ds
	push	2022h
	mov	es,[3758h]
	push	word ptr es:[0216h]
	push	word ptr es:[0214h]
	call	far 149Ah:0752h
	add	sp,0Ch

l1054_05B3:
	mov	al,[bp-0Ch]
	or	al,2h
	push	ax
	push	word ptr [bp-2h]
	push	381Dh
	push	2C74h
	call	far 1054h:3E87h
	add	sp,8h

l1054_05CA:
	jmp	0628h

l1054_05CD:
	test	byte ptr [bp-0Ch],1h
	jz	05D6h

l1054_05D3:
	jmp	0628h

l1054_05D6:
	mov	al,[bp-0Ch]
	and	al,0Ch
	cmp	al,0Ch
	jz	05E2h

l1054_05DF:
	jmp	0628h

l1054_05E2:
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	05F1h

l1054_05EE:
	jmp	0611h

l1054_05F1:
	push	word ptr [bp-0Eh]
	push	word ptr [bp-10h]
	push	ds
	push	205Fh
	mov	es,[375Ah]
	push	word ptr es:[0FDD2h]
	push	word ptr es:[0FDD0h]
	call	far 149Ah:0752h
	add	sp,0Ch

l1054_0611:
	mov	al,[bp-0Ch]
	or	al,1h
	push	ax
	push	word ptr [bp-2h]
	push	381Dh
	push	2C74h
	call	far 1054h:3E87h
	add	sp,8h

l1054_0628:
	jmp	0676h

l1054_062B:
	cmp	word ptr [bp-0Ch],2h
	jz	0634h

l1054_0631:
	jmp	0676h

l1054_0634:
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	0643h

l1054_0640:
	jmp	0663h

l1054_0643:
	push	word ptr [bp-0Eh]
	push	word ptr [bp-10h]
	push	ds
	push	2093h
	mov	es,[3758h]
	push	word ptr es:[0216h]
	push	word ptr es:[0214h]
	call	far 149Ah:0752h
	add	sp,0Ch

l1054_0663:
	push	0Ah
	push	word ptr [bp-2h]
	push	381Dh
	push	2C74h
	call	far 1054h:3E87h
	add	sp,8h

l1054_0676:
	jmp	0468h

l1054_0679:
	mov	al,[bp+0Ah]
	mov	es,[375Ch]
	mov	es:[0C76Ah],al
	cmp	al,0h
	jnz	068Bh

l1054_0688:
	jmp	06AFh

l1054_068B:
	les	bx,[bp-10h]
	mov	al,es:[bx+11h]
	and	al,3h
	dec	al
	mov	es,[375Ch]
	mov	es:[0C76Ah],al
	cmp	byte ptr es:[0C76Ah],0h
	jl	06A9h

l1054_06A6:
	jmp	06AFh

l1054_06A9:
	mov	byte ptr es:[0C76Ah],3h

l1054_06AF:
	push	word ptr [bp-2h]
	push	word ptr [bp-0Eh]
	push	word ptr [bp-10h]
	call	far 0800h:550Ah
	add	sp,6h
	jmp	0713h

l1054_06C3:
	les	bx,[bp+6h]
	test	byte ptr es:[bx+10h],2h
	jz	06D0h

l1054_06CD:
	jmp	0713h

l1054_06D0:
	mov	es,[3754h]
	cmp	byte ptr es:[0FFE0h],0h
	jnz	06DFh

l1054_06DC:
	jmp	0713h

l1054_06DF:
	mov	di,si
	shl	di,2h
	les	bx,[bp+6h]
	add	bx,14h
	les	bx,es:[bx+di]
	mov	al,es:[bx+6h]
	sub	ah,ah
	push	ax
	push	ds
	push	20CFh
	mov	es,[3756h]
	push	word ptr es:[0206h]
	push	word ptr es:[0204h]
	call	far 149Ah:0752h
	add	sp,0Ah
	mov	word ptr [bp-4h],1h

l1054_0713:
	jmp	0468h

l1054_0716:
	les	bx,[bp+6h]
	test	byte ptr es:[bx+10h],2h
	jz	0723h

l1054_0720:
	jmp	074Ch

l1054_0723:
	mov	es,[3754h]
	cmp	byte ptr es:[0FFE0h],0h
	jnz	0732h

l1054_072F:
	jmp	074Ch

l1054_0732:
	push	ds
	push	20EBh
	mov	es,[3756h]
	push	word ptr es:[0206h]
	push	word ptr es:[0204h]
	call	far 149Ah:0752h
	add	sp,8h

l1054_074C:
	les	bx,[bp+6h]
	or	word ptr es:[bx+10h],2h
	mov	es,[3752h]
	mov	byte ptr es:[0D2B6h],0h
	pop	si
	pop	di
	leave
	retf

;; fn1054_0762: 1054:0762
;;   Called from:
;;     1054:0A61 (in fn1054_0792)
;;     1054:0ACA (in fn1054_0792)
;;     1054:0C2F (in fn1054_0792)
;;     1054:0C85 (in fn1054_0792)
fn1054_0762 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	cmp	word ptr [bp+6h],80h
	jnz	0779h

l1054_0776:
	jmp	0788h

l1054_0779:
	cmp	word ptr [bp+6h],0Fh
	jg	0782h

l1054_077F:
	jmp	0788h

l1054_0782:
	mov	ax,0Fh
	jmp	078Eh

l1054_0788:
	mov	ax,[bp+6h]
	jmp	078Eh

l1054_078E:
	pop	si
	pop	di
	leave
	retf

;; fn1054_0792: 1054:0792
;;   Called from:
;;     1054:16A4 (in fn1054_0DB3)
fn1054_0792 proc
	push	bp
	mov	bp,sp
	mov	ax,1Ah
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[375Eh]
	mov	bx,[bp+6h]
	shl	bx,2h
	mov	ax,es:[bx+0h]
	mov	dx,es:[bx+2h]
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	mov	word ptr [bp-16h],0h
	mov	es,[3760h]
	mov	si,es:[54DAh]
	jmp	07CBh

l1054_07CA:
	dec	si

l1054_07CB:
	cmp	si,0h
	jge	07D3h

l1054_07D0:
	jmp	0828h

l1054_07D3:
	mov	es,[3762h]
	mov	bx,si
	shl	bx,2h
	les	bx,es:[bx+0D072h]
	mov	ax,[bp+6h]
	cmp	es:[bx],ax
	jz	07ECh

l1054_07E9:
	jmp	0825h

l1054_07EC:
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	mov	es,[3762h]
	mov	bx,si
	shl	bx,2h
	les	bx,es:[bx+0D072h]
	push	word ptr es:[bx+6h]
	push	word ptr es:[bx+4h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	0818h

l1054_0815:
	jmp	0820h

l1054_0818:
	mov	ax,si
	jmp	0D4Bh
1054:081D                                        E9 05 00              ...

l1054_0820:
	mov	word ptr [bp-16h],1h

l1054_0825:
	jmp	07CAh

l1054_0828:
	les	bx,[bp+0Ah]
	mov	al,es:[bx+13h]
	and	al,0A0h
	cmp	al,0A0h
	jz	0838h

l1054_0835:
	jmp	084Ah

l1054_0838:
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	ds
	push	20F8h
	call	far 149Ah:0ABCh
	add	sp,8h

l1054_084A:
	mov	es,[3760h]
	inc	word ptr es:[54DAh]
	cmp	word ptr es:[54DAh],80h
	jz	085Fh

l1054_085C:
	jmp	0877h

l1054_085F:
	push	ds
	push	214Eh
	call	far 149Ah:0ABCh
	add	sp,4h
	push	ds
	push	2186h
	call	far 149Ah:0ABCh
	add	sp,4h

l1054_0877:
	mov	es,[3760h]
	cmp	word ptr es:[54DAh],80h
	jge	0887h

l1054_0884:
	jmp	088Dh

l1054_0887:
	mov	ax,0FFFFh
	jmp	0D4Bh

l1054_088D:
	push	8h
	call	far 149Ah:22A2h
	add	sp,2h
	mov	es,[3760h]
	mov	bx,es:[54DAh]
	shl	bx,2h
	mov	es,[3762h]
	mov	es:[bx+0D072h],ax
	mov	es:[bx+0D074h],dx
	mov	ax,[bp+6h]
	mov	es,[3760h]
	mov	bx,es:[54DAh]
	shl	bx,2h
	mov	es,[3762h]
	les	bx,es:[bx+0D072h]
	mov	es:[bx],ax
	mov	es,[3764h]
	inc	word ptr es:[5B78h]
	mov	ax,es:[5B78h]
	mov	es,[3760h]
	mov	bx,es:[54DAh]
	shl	bx,2h
	mov	es,[3762h]
	les	bx,es:[bx+0D072h]
	mov	es:[bx+2h],ax
	push	10h
	call	far 149Ah:22A2h
	add	sp,2h
	mov	es,[3760h]
	mov	bx,es:[54DAh]
	shl	bx,2h
	mov	es,[3762h]
	les	bx,es:[bx+0D072h]
	mov	es:[bx+4h],ax
	mov	es:[bx+6h],dx
	mov	es,[3760h]
	mov	bx,es:[54DAh]
	shl	bx,2h
	mov	es,[3762h]
	les	bx,es:[bx+0D072h]
	mov	ax,es:[bx+4h]
	mov	dx,es:[bx+6h]
	mov	[bp-8h],ax
	mov	[bp-6h],dx
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	word ptr [bp-6h]
	push	word ptr [bp-8h]
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[3754h]
	mov	al,es:[0FFE0h]
	cbw
	mov	[bp-0Ch],ax
	mov	byte ptr es:[0FFE0h],0h
	les	bx,[bp+0Ah]
	mov	al,es:[bx+10h]
	and	ax,1h
	mov	[bp-14h],ax
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	097Eh

l1054_097B:
	jmp	09DCh

l1054_097E:
	mov	es,[3760h]
	mov	bx,es:[54DAh]
	shl	bx,2h
	mov	es,[3762h]
	les	bx,es:[bx+0D072h]
	push	word ptr es:[bx+2h]
	push	ds
	push	21ABh
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,0Ah
	les	bx,[bp+0Ah]
	mov	al,es:[bx+10h]
	and	ax,1h
	push	ax
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	ds
	push	21B9h
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,0Eh

l1054_09DC:
	les	bx,[bp-4h]
	test	byte ptr es:[bx+10h],40h
	jnz	09E9h

l1054_09E6:
	jmp	0B18h

l1054_09E9:
	push	0h
	push	word ptr [bp+8h]
	push	word ptr [bp-2h]
	push	word ptr [bp-4h]
	call	far 1054h:03DAh
	add	sp,8h
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	0A0Bh

l1054_0A08:
	jmp	0B15h

l1054_0A0B:
	mov	si,1h
	jmp	0A12h

l1054_0A11:
	inc	si

l1054_0A12:
	les	bx,[bp-4h]
	cmp	es:[bx+12h],si
	jg	0A1Eh

l1054_0A1B:
	jmp	0A87h

l1054_0A1E:
	mov	bx,si
	shl	bx,2h
	add	bx,[bp-4h]
	mov	es,[bp-2h]
	les	bx,es:[bx+10h]
	mov	ax,es:[bx]
	mov	dx,es:[bx+2h]
	mov	[bp-1Ah],ax
	mov	[bp-18h],dx
	mov	ax,[bp-18h]
	or	ax,[bp-1Ah]
	jnz	0A45h

l1054_0A42:
	jmp	0A84h

l1054_0A45:
	push	word ptr [bp-18h]
	push	word ptr [bp-1Ah]
	mov	bx,si
	shl	bx,2h
	add	bx,[bp-4h]
	mov	es,[bp-2h]
	les	bx,es:[bx+10h]
	mov	al,es:[bx+6h]
	sub	ah,ah
	push	ax
	call	far 1054h:0762h
	add	sp,2h
	push	ax
	push	ds
	push	21C8h
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,0Eh

l1054_0A84:
	jmp	0A11h

l1054_0A87:
	mov	bx,si
	shl	bx,2h
	add	bx,[bp-4h]
	mov	es,[bp-2h]
	les	bx,es:[bx+10h]
	mov	ax,es:[bx]
	mov	dx,es:[bx+2h]
	mov	[bp-1Ah],ax
	mov	[bp-18h],dx
	mov	ax,[bp-18h]
	or	ax,[bp-1Ah]
	jnz	0AAEh

l1054_0AAB:
	jmp	0AF0h

l1054_0AAE:
	push	word ptr [bp-18h]
	push	word ptr [bp-1Ah]
	mov	bx,si
	shl	bx,2h
	add	bx,[bp-4h]
	mov	es,[bp-2h]
	les	bx,es:[bx+10h]
	mov	al,es:[bx+6h]
	sub	ah,ah
	push	ax
	call	far 1054h:0762h
	add	sp,2h
	push	ax
	push	ds
	push	21DFh
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,0Eh
	jmp	0B15h

l1054_0AF0:
	mov	es,[3760h]
	mov	bx,es:[54DAh]
	shl	bx,2h
	mov	es,[3762h]
	les	bx,es:[bx+0D072h]
	push	word ptr es:[bx+2h]
	push	ds
	push	21F9h
	call	far 149Ah:0ABCh
	add	sp,6h

l1054_0B15:
	jmp	0CABh

l1054_0B18:
	les	bx,[bp-4h]
	mov	ax,es:[bx+12h]
	add	[bp-14h],ax
	mov	si,0h
	jmp	0B29h

l1054_0B28:
	inc	si

l1054_0B29:
	les	bx,[bp-4h]
	cmp	es:[bx+12h],si
	jg	0B35h

l1054_0B32:
	jmp	0CABh

l1054_0B35:
	mov	ax,si
	shl	ax,2h
	les	bx,[bp-4h]
	add	bx,14h
	add	bx,ax
	les	bx,es:[bx]
	mov	ax,es:[bx]
	mov	dx,es:[bx+2h]
	mov	[bp-10h],ax
	mov	[bp-0Eh],dx
	les	bx,[bp-10h]
	cmp	word ptr es:[bx+12h],1h
	jg	0B5Fh

l1054_0B5C:
	jmp	0B65h

l1054_0B5F:
	mov	al,[bp-0Ch]
	jmp	0B67h

l1054_0B65:
	mov	al,0h

l1054_0B67:
	mov	es,[3754h]
	mov	es:[0FFE0h],al
	push	word ptr [bp-0Eh]
	push	word ptr [bp-10h]
	call	far 1054h:0386h
	add	sp,4h
	mov	[bp-0Ah],ax
	push	word ptr [bp-0Ah]
	push	180Ah
	push	6D2h
	call	far 1054h:3E4Dh
	add	sp,6h
	mov	[bp-12h],ax
	cmp	word ptr [bp-12h],0h
	jz	0B9Dh

l1054_0B9A:
	jmp	0BC3h

l1054_0B9D:
	push	0h
	push	word ptr [bp+8h]
	push	word ptr [bp-0Eh]
	push	word ptr [bp-10h]
	call	far 1054h:03DAh
	add	sp,8h
	push	1h
	push	word ptr [bp-0Ah]
	push	180Ah
	push	6D2h
	call	far 1054h:3E87h
	add	sp,8h

l1054_0BC3:
	mov	ax,si
	shl	ax,2h
	les	bx,[bp-4h]
	add	bx,14h
	add	bx,ax
	les	bx,es:[bx]
	mov	al,es:[bx+6h]
	sub	ah,ah
	mov	di,ax
	les	bx,[bp-10h]
	cmp	word ptr es:[bx+12h],1h
	jz	0BE8h

l1054_0BE5:
	jmp	0C55h

l1054_0BE8:
	dec	word ptr [bp-14h]
	les	bx,[bp-10h]
	les	bx,es:[bx+14h]
	mov	ax,es:[bx]
	mov	dx,es:[bx+2h]
	mov	[bp-1Ah],ax
	mov	[bp-18h],dx
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	0C0Eh

l1054_0C0B:
	jmp	0C52h

l1054_0C0E:
	les	bx,[bp-4h]
	mov	ax,es:[bx+12h]
	sub	ax,si
	dec	ax
	jz	0C1Dh

l1054_0C1A:
	jmp	0C23h

l1054_0C1D:
	mov	ax,2227h
	jmp	0C26h

l1054_0C23:
	mov	ax,222Ah

l1054_0C26:
	push	ds
	push	ax
	push	word ptr [bp-18h]
	push	word ptr [bp-1Ah]
	push	di
	call	far 1054h:0762h
	add	sp,2h
	push	ax
	push	ds
	push	222Bh
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,12h

l1054_0C52:
	jmp	0CA8h

l1054_0C55:
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	0C64h

l1054_0C61:
	jmp	0CA8h

l1054_0C64:
	les	bx,[bp-4h]
	mov	ax,es:[bx+12h]
	sub	ax,si
	dec	ax
	jz	0C73h

l1054_0C70:
	jmp	0C79h

l1054_0C73:
	mov	ax,2245h
	jmp	0C7Ch

l1054_0C79:
	mov	ax,2248h

l1054_0C7C:
	push	ds
	push	ax
	push	word ptr [bp-0Eh]
	push	word ptr [bp-10h]
	push	di
	call	far 1054h:0762h
	add	sp,2h
	push	ax
	push	ds
	push	224Bh
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,12h

l1054_0CA8:
	jmp	0B28h

l1054_0CAB:
	les	bx,[bp+0Ah]
	test	byte ptr es:[bx+10h],40h
	jnz	0CB8h

l1054_0CB5:
	jmp	0D35h

l1054_0CB8:
	cmp	word ptr [bp-14h],0h
	jz	0CC1h

l1054_0CBE:
	jmp	0D13h

l1054_0CC1:
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	0CD0h

l1054_0CCD:
	jmp	0D10h

l1054_0CD0:
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	ds
	push	2265h
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,0Ch
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	ds
	push	2274h
	mov	es,[3758h]
	push	word ptr es:[0216h]
	push	word ptr es:[0214h]
	call	far 149Ah:0752h
	add	sp,0Ch

l1054_0D10:
	jmp	0D35h

l1054_0D13:
	les	bx,[bp-4h]
	mov	ax,es:[bx+12h]
	sub	ax,[bp-14h]
	inc	ax
	jnz	0D23h

l1054_0D20:
	jmp	0D35h

l1054_0D23:
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	ds
	push	22ABh
	call	far 149Ah:0ABCh
	add	sp,8h

l1054_0D35:
	mov	al,[bp-0Ch]
	mov	es,[3754h]
	mov	es:[0FFE0h],al
	mov	es,[3760h]
	mov	ax,es:[54DAh]
	jmp	0D4Bh

l1054_0D4B:
	pop	si
	pop	di
	leave
	retf
1054:0D4F                                              55                U
1054:0D50 8B EC B8 00 00 9A C8 02 9A 14 57 56 BE 00 00 C4 ..........WV....
1054:0D60 5E 06 26 F6 47 21 20 75 03 E9 03 00 83 CE 10 C4 ^.&.G! u........
1054:0D70 5E 06 26 F6 47 21 08 75 03 E9 03 00 83 CE 08 C4 ^.&.G!.u........
1054:0D80 5E 06 26 F6 47 21 40 75 03 E9 03 00 83 CE 01 C4 ^.&.G!@u........
1054:0D90 5E 06 26 F6 47 21 10 75 03 E9 03 00 83 CE 02 C4 ^.&.G!.u........
1054:0DA0 5E 06 26 89 77 24 C4 5E 06 26 81 67 20 FF 87 5E ^.&.w$.^.&.g ..^
1054:0DB0 5F C9 CB                                        _..             

;; fn1054_0DB3: 1054:0DB3
;;   Called from:
;;     0800:2DF5 (in main)
fn1054_0DB3 proc
	push	bp
	mov	bp,sp
	mov	ax,388h
	call	far 149Ah:02C8h
	push	di
	push	si
	push	ds
	push	230Ah
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:2568h
	add	sp,8h
	push	8000h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:1E7Eh
	add	sp,6h
	mov	[bp+0FC7Ch],ax
	cmp	word ptr [bp+0FC7Ch],0h
	jle	0DF1h

l1054_0DEE:
	jmp	0E06h

l1054_0DF1:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	230Fh
	call	far 149Ah:0ABCh
	add	sp,8h
	jmp	1A45h

l1054_0E06:
	push	2Eh
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp+0FC80h],ax
	mov	[bp+0FC82h],dx
	or	dx,ax
	jnz	0E25h

l1054_0E22:
	jmp	0E2Dh

l1054_0E25:
	les	bx,[bp+0FC80h]
	mov	byte ptr es:[bx],0h

l1054_0E2D:
	push	5Ch
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:29B0h
	add	sp,6h
	mov	[bp+0FC80h],ax
	mov	[bp+0FC82h],dx
	mov	ax,[bp+0FC82h]
	or	ax,[bp+0FC80h]
	jz	0E52h

l1054_0E4F:
	jmp	0E63h

l1054_0E52:
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	mov	[bp+0FC80h],ax
	mov	[bp+0FC82h],dx
	jmp	0E67h

l1054_0E63:
	inc	word ptr [bp+0FC80h]

l1054_0E67:
	push	30h
	push	381Dh
	push	54F0h
	push	word ptr [bp+0FC7Ch]
	call	far 149Ah:2030h
	add	sp,8h
	mov	es,[3768h]
	cmp	word ptr es:[54F0h],100h
	jl	0E8Bh

l1054_0E88:
	jmp	0EACh

l1054_0E8B:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	232Bh
	call	far 149Ah:0ABCh
	add	sp,8h
	push	word ptr [bp+0FC7Ch]
	call	far 149Ah:1DCAh
	add	sp,2h
	jmp	1A45h

l1054_0EAC:
	mov	es,[3768h]
	mov	ax,es:[54F2h]
	shl	ax,6h
	push	ax
	lea	ax,[bp+0FCC8h]
	push	ss
	push	ax
	push	word ptr [bp+0FC7Ch]
	call	far 149Ah:2030h
	add	sp,8h
	mov	word ptr [bp-16h],30h
	mov	es,[3768h]
	cmp	word ptr es:[54F4h],7D0h
	jg	0EDFh

l1054_0EDC:
	jmp	0F0Ch

l1054_0EDF:
	push	word ptr [bp+0FC7Ch]
	call	far 149Ah:1DCAh
	add	sp,2h
	push	7D0h
	mov	es,[3768h]
	push	word ptr es:[54F4h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	2354h
	call	far 149Ah:0ABCh
	add	sp,0Ch
	jmp	1A45h

l1054_0F0C:
	push	word ptr [bp+0FC7Ch]
	call	far 149Ah:28C2h
	add	sp,2h
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	push	30h
	call	far 149Ah:22C1h
	add	sp,2h
	mov	[bp+0FCC4h],ax
	mov	[bp+0FCC6h],dx
	mov	ax,[bp+0FCC6h]
	or	ax,[bp+0FCC4h]
	jz	0F3Dh

l1054_0F3A:
	jmp	0F4Ch

l1054_0F3D:
	push	ds
	push	2382h
	call	far 149Ah:0ABCh
	add	sp,4h
	jmp	1A45h

l1054_0F4C:
	mov	es,[376Ah]
	mov	ax,es:[5B8Ch]
	mov	[bp-8h],ax
	mov	word ptr es:[5B8Ch],0h
	mov	word ptr [bp-0Ah],0h
	mov	di,0h
	jmp	0F6Ah

l1054_0F69:
	inc	di

l1054_0F6A:
	mov	es,[3768h]
	cmp	es:[54F4h],di
	jg	0F78h

l1054_0F75:
	jmp	1134h

l1054_0F78:
	push	word ptr [bp-16h]
	push	word ptr [bp+0FCC6h]
	push	word ptr [bp+0FCC4h]
	push	word ptr [bp+0FC7Ch]
	call	far 149Ah:2030h
	add	sp,8h
	les	bx,[bp+0FCC4h]
	test	byte ptr es:[bx+24h],8h
	jnz	0F9Dh

l1054_0F9A:
	jmp	0FB8h

l1054_0F9D:
	mov	es,[376Ch]
	mov	bx,di
	shl	bx,2h
	sub	ax,ax
	mov	es:[bx+0D2BAh],ax
	mov	es:[bx+0D2B8h],ax
	inc	word ptr [bp-0Ah]
	jmp	0F69h

l1054_0FB8:
	push	14h
	call	far 149Ah:22C1h
	add	sp,2h
	mov	es,[376Ch]
	mov	bx,di
	shl	bx,2h
	mov	es:[bx+0D2B8h],ax
	mov	es:[bx+0D2BAh],dx
	mov	bx,di
	shl	bx,2h
	mov	ax,es:[bx+0D2BAh]
	or	ax,es:[bx+0D2B8h]
	jz	0FE9h

l1054_0FE6:
	jmp	1004h

l1054_0FE9:
	push	di
	push	ds
	push	23AFh
	call	far 149Ah:0ABCh
	add	sp,6h
	mov	ax,[bp-8h]
	mov	es,[376Ah]
	mov	es:[5B8Ch],ax
	jmp	1A45h

l1054_1004:
	les	bx,[bp+0FCC4h]
	mov	ax,es:[bx+20h]
	mov	es,[376Ch]
	mov	bx,di
	shl	bx,2h
	les	bx,es:[bx+0D2B8h]
	mov	es:[bx+12h],ax
	mov	es,[3768h]
	cmp	word ptr es:[54F0h],10Dh
	jl	102Eh

l1054_102B:
	jmp	106Eh

l1054_102E:
	mov	es,[376Ch]
	mov	bx,di
	shl	bx,2h
	les	bx,es:[bx+0D2B8h]
	test	byte ptr es:[bx+13h],10h
	jnz	1046h

l1054_1043:
	jmp	106Eh

l1054_1046:
	mov	es,[376Ch]
	mov	bx,di
	shl	bx,2h
	les	bx,es:[bx+0D2B8h]
	and	word ptr es:[bx+12h],0EFFFh
	mov	es,[376Ch]
	mov	bx,di
	shl	bx,2h
	les	bx,es:[bx+0D2B8h]
	or	word ptr es:[bx+12h],800h

l1054_106E:
	les	bx,[bp+0FCC4h]
	mov	ax,es:[bx+24h]
	mov	es,[376Ch]
	mov	bx,di
	shl	bx,2h
	les	bx,es:[bx+0D2B8h]
	mov	es:[bx+10h],ax
	les	bx,[bp+0FCC4h]
	test	byte ptr es:[bx+21h],80h
	jnz	1096h

l1054_1093:
	jmp	1109h

l1054_1096:
	les	bx,[bp+0FCC4h]
	test	byte ptr es:[bx+24h],4h
	jnz	10A4h

l1054_10A1:
	jmp	1109h

l1054_10A4:
	les	bx,[bp+0FCC4h]
	test	byte ptr es:[bx+24h],1h
	jz	10B2h

l1054_10AF:
	jmp	1109h

l1054_10B2:
	mov	si,0h
	jmp	10B9h

l1054_10B8:
	inc	si

l1054_10B9:
	cmp	di,si
	jg	10C0h

l1054_10BD:
	jmp	10F6h

l1054_10C0:
	mov	ax,[bp+0FCC4h]
	mov	dx,[bp+0FCC6h]
	add	ax,2h
	push	dx
	push	ax
	mov	es,[376Ch]
	mov	bx,si
	shl	bx,2h
	push	word ptr es:[bx+0D2BAh]
	push	word ptr es:[bx+0D2B8h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	10F0h

l1054_10ED:
	jmp	10F3h

l1054_10F0:
	jmp	10F6h

l1054_10F3:
	jmp	10B8h

l1054_10F6:
	mov	es,[376Ch]
	mov	bx,si
	shl	bx,2h
	les	bx,es:[bx+0D2B8h]
	or	word ptr es:[bx+10h],40h

l1054_1109:
	mov	ax,[bp+0FCC4h]
	mov	dx,[bp+0FCC6h]
	add	ax,2h
	push	dx
	push	ax
	mov	es,[376Ch]
	mov	bx,di
	shl	bx,2h
	push	word ptr es:[bx+0D2BAh]
	push	word ptr es:[bx+0D2B8h]
	call	far 149Ah:25AEh
	add	sp,8h
	jmp	0F69h

l1054_1134:
	mov	word ptr [bp-24h],0FFFFh

l1054_1139:
	mov	es,[3768h]
	inc	word ptr [bp-24h]
	mov	ax,[bp-24h]
	cmp	es:[54F2h],ax
	jg	114Dh

l1054_114A:
	jmp	1778h

l1054_114D:
	call	far 0800h:02FEh
	mov	ax,[bp+0Ch]
	or	ax,[bp+0Ah]
	jz	115Dh

l1054_115A:
	jmp	117Ch

l1054_115D:
	mov	ax,[bp-24h]
	shl	ax,6h
	lea	cx,[bp+0FCC8h]
	add	ax,cx
	push	ss
	push	ax
	lea	ax,[bp+0FC84h]
	push	ss
	push	ax
	call	far 149Ah:25AEh
	add	sp,8h
	jmp	1214h

l1054_117C:
	push	5Ch
	mov	ax,[bp-24h]
	shl	ax,6h
	lea	cx,[bp+0FCC8h]
	add	ax,cx
	push	ss
	push	ax
	call	far 149Ah:29B0h
	add	sp,6h
	mov	[bp-22h],ax
	mov	[bp-20h],dx
	mov	ax,[bp-20h]
	or	ax,[bp-22h]
	jz	11A5h

l1054_11A2:
	jmp	11E9h

l1054_11A5:
	push	3Ah
	mov	ax,[bp-24h]
	shl	ax,6h
	lea	cx,[bp+0FCC8h]
	add	ax,cx
	push	ss
	push	ax
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-22h],ax
	mov	[bp-20h],dx
	mov	ax,[bp-20h]
	or	ax,[bp-22h]
	jz	11CEh

l1054_11CB:
	jmp	11E3h

l1054_11CE:
	mov	ax,[bp-24h]
	shl	ax,6h
	lea	cx,[bp+0FCC8h]
	add	ax,cx
	mov	[bp-22h],ax
	mov	[bp-20h],ss
	jmp	11E6h

l1054_11E3:
	inc	word ptr [bp-22h]

l1054_11E6:
	jmp	11ECh

l1054_11E9:
	inc	word ptr [bp-22h]

l1054_11EC:
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	lea	ax,[bp+0FC84h]
	push	ss
	push	ax
	call	far 149Ah:25AEh
	add	sp,8h
	push	word ptr [bp-20h]
	push	word ptr [bp-22h]
	lea	ax,[bp+0FC84h]
	push	ss
	push	ax
	call	far 149Ah:2568h
	add	sp,8h

l1054_1214:
	push	8000h
	lea	ax,[bp+0FC84h]
	push	ss
	push	ax
	call	far 149Ah:1E7Eh
	add	sp,6h
	mov	es,[376Eh]
	mov	es:[0208h],ax
	cmp	word ptr es:[0208h],0h
	jle	1238h

l1054_1235:
	jmp	124Dh

l1054_1238:
	lea	ax,[bp+0FC84h]
	push	ss
	push	ax
	push	ds
	push	23E0h
	call	far 149Ah:0ABCh
	add	sp,8h
	jmp	1139h

l1054_124D:
	lea	ax,[bp+0FC84h]
	push	ss
	push	ax
	push	180Ah
	push	0FEDAh
	call	far 149Ah:25AEh
	add	sp,8h
	mov	es,[3770h]
	mov	word ptr es:[2C3Ah],1h
	call	far 0800h:481Ch
	push	180Ah
	push	0FEDAh
	call	far 1054h:3A11h
	add	sp,4h
	mov	es,[3760h]
	mov	word ptr es:[54DAh],0FFFFh
	push	0h
	push	word ptr [bp-2h]
	push	word ptr [bp-4h]
	push	word ptr [bp+0FC7Ch]
	call	far 149Ah:1DEAh
	add	sp,8h
	mov	di,0h
	jmp	12A5h

l1054_12A4:
	inc	di

l1054_12A5:
	mov	es,[3768h]
	cmp	es:[54F4h],di
	jg	12B3h

l1054_12B0:
	jmp	171Ah

l1054_12B3:
	push	word ptr [bp-16h]
	push	word ptr [bp+0FCC6h]
	push	word ptr [bp+0FCC4h]
	push	word ptr [bp+0FC7Ch]
	call	far 149Ah:2030h
	add	sp,8h
	mov	es,[376Ch]
	mov	bx,di
	shl	bx,2h
	mov	ax,es:[bx+0D2B8h]
	mov	dx,es:[bx+0D2BAh]
	mov	[bp-1Ah],ax
	mov	[bp-18h],dx
	or	dx,ax
	jz	12EAh

l1054_12E7:
	jmp	12EDh

l1054_12EA:
	jmp	12A4h

l1054_12ED:
	les	bx,[bp+0FCC4h]
	mov	ax,[bp-24h]
	cmp	es:[bx],ax
	jz	12FCh

l1054_12F9:
	jmp	1717h

l1054_12FC:
	les	bx,[bp+0FCC4h]
	mov	si,es:[bx+12h]
	les	bx,[bp-1Ah]
	mov	al,es:[bx+12h]
	and	ax,1h
	cmp	ax,1h
	sbb	ax,ax
	neg	ax
	mov	[bp-6h],ax
	les	bx,[bp-1Ah]
	mov	al,es:[bx+13h]
	and	al,0A0h
	cmp	al,0A0h
	jz	1328h

l1054_1325:
	jmp	1349h

l1054_1328:
	push	word ptr [bp+0FC82h]
	push	word ptr [bp+0FC80h]
	mov	ax,[bp+0FCC4h]
	mov	dx,[bp+0FCC6h]
	add	ax,2h
	push	dx
	push	ax
	push	ds
	push	2409h
	call	far 149Ah:0ABCh
	add	sp,0Ch

l1054_1349:
	les	bx,[bp-1Ah]
	test	byte ptr es:[bx+10h],1h
	jnz	1356h

l1054_1353:
	jmp	13A7h

l1054_1356:
	push	si
	push	180Ah
	push	6D2h
	call	far 1054h:3E4Dh
	add	sp,6h
	mov	[bp+0FC7Eh],ax
	cmp	word ptr [bp+0FC7Eh],0h
	jz	1373h

l1054_1370:
	jmp	13A4h

l1054_1373:
	push	1h
	push	word ptr [bp-6h]
	mov	es,[3750h]
	mov	bx,si
	shl	bx,2h
	push	word ptr es:[bx+0FBCCh]
	push	word ptr es:[bx+0FBCAh]
	call	far 1054h:03DAh
	add	sp,8h
	push	1h
	push	si
	push	180Ah
	push	6D2h
	call	far 1054h:3E87h
	add	sp,8h

l1054_13A4:
	jmp	163Ah

l1054_13A7:
	push	word ptr [bp-18h]
	push	word ptr [bp-1Ah]
	mov	es,[374Eh]
	mov	bx,si
	shl	bx,2h
	push	word ptr es:[bx+0F230h]
	push	word ptr es:[bx+0F22Eh]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jnz	13D0h

l1054_13CD:
	jmp	1412h

l1054_13D0:
	les	bx,[bp+0FCC4h]
	mov	bx,es:[bx+12h]
	shl	bx,2h
	mov	es,[374Eh]
	push	word ptr es:[bx+0F230h]
	push	word ptr es:[bx+0F22Eh]
	push	word ptr [bp-18h]
	push	word ptr [bp-1Ah]
	lea	ax,[bp+0FC84h]
	push	ss
	push	ax
	les	bx,[bp+0FCC4h]
	push	word ptr es:[bx+12h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	242Fh
	call	far 149Ah:0ABCh
	add	sp,16h
	jmp	12A4h

l1054_1412:
	mov	es,[374Eh]
	mov	bx,si
	shl	bx,2h
	les	bx,es:[bx+0F22Eh]
	test	byte ptr es:[bx+10h],2h
	jz	142Ah

l1054_1427:
	jmp	1487h

l1054_142A:
	mov	al,[bp-6h]
	mov	es,[375Ch]
	mov	es:[0C76Ah],al
	cmp	al,0h
	jnz	143Ch

l1054_1439:
	jmp	146Bh

l1054_143C:
	mov	es,[374Eh]
	mov	bx,si
	shl	bx,2h
	les	bx,es:[bx+0F22Eh]
	mov	al,es:[bx+11h]
	and	al,3h
	dec	al
	mov	es,[375Ch]
	mov	es:[0C76Ah],al
	cmp	byte ptr es:[0C76Ah],0h
	jl	1465h

l1054_1462:
	jmp	146Bh

l1054_1465:
	mov	byte ptr es:[0C76Ah],3h

l1054_146B:
	push	si
	mov	es,[374Eh]
	mov	bx,si
	shl	bx,2h
	push	word ptr es:[bx+0F230h]
	push	word ptr es:[bx+0F22Eh]
	call	far 0800h:550Ah
	add	sp,6h

l1054_1487:
	les	bx,[bp-1Ah]
	test	byte ptr es:[bx+13h],80h
	jnz	1494h

l1054_1491:
	jmp	163Ah

l1054_1494:
	push	si
	push	381Dh
	push	2C74h
	call	far 1054h:3E4Dh
	add	sp,6h
	sub	ah,ah
	mov	[bp+0FC7Eh],ax
	mov	byte ptr [bp-10h],0h
	cmp	word ptr [bp+0FC7Eh],2h
	jz	14B7h

l1054_14B4:
	jmp	14BBh

l1054_14B7:
	mov	byte ptr [bp-10h],0Ah

l1054_14BB:
	cmp	word ptr [bp+0FC7Eh],4h
	jge	14C5h

l1054_14C2:
	jmp	14D8h

l1054_14C5:
	test	byte ptr [bp+0FC7Eh],3h
	jz	14CFh

l1054_14CC:
	jmp	14D8h

l1054_14CF:
	mov	al,[bp+0FC7Eh]
	or	al,2h
	mov	[bp-10h],al

l1054_14D8:
	les	bx,[bp-1Ah]
	test	byte ptr es:[bx+10h],4h
	jz	14E5h

l1054_14E2:
	jmp	1525h

l1054_14E5:
	push	word ptr [bp-18h]
	push	word ptr [bp-1Ah]
	lea	ax,[bp-36h]
	push	ss
	push	ax
	call	far 149Ah:25AEh
	add	sp,8h
	push	ds
	push	2497h
	push	word ptr [bp-18h]
	push	word ptr [bp-1Ah]
	call	far 149Ah:25AEh
	add	sp,8h
	lea	ax,[bp-36h]
	push	ss
	push	ax
	push	word ptr [bp-18h]
	push	word ptr [bp-1Ah]
	call	far 149Ah:2568h
	add	sp,8h
	les	bx,[bp-1Ah]
	or	word ptr es:[bx+10h],3h

l1054_1525:
	cmp	byte ptr [bp-10h],0h
	jnz	152Eh

l1054_152B:
	jmp	163Ah

l1054_152E:
	mov	es,[3754h]
	cmp	byte ptr es:[0FFE0h],0h
	jnz	153Dh

l1054_153A:
	jmp	15BEh

l1054_153D:
	les	bx,[bp-1Ah]
	test	byte ptr es:[bx+10h],4h
	jz	154Ah

l1054_1547:
	jmp	15BEh

l1054_154A:
	mov	es,[374Eh]
	mov	bx,si
	shl	bx,2h
	push	word ptr es:[bx+0F230h]
	push	word ptr es:[bx+0F22Eh]
	push	ds
	push	249Ah
	mov	es,[3756h]
	push	word ptr es:[0206h]
	push	word ptr es:[0204h]
	call	far 149Ah:0752h
	add	sp,0Ch
	mov	es,[374Eh]
	mov	bx,si
	shl	bx,2h
	push	word ptr es:[bx+0F230h]
	push	word ptr es:[bx+0F22Eh]
	push	ds
	push	24A2h
	mov	es,[3756h]
	push	word ptr es:[0206h]
	push	word ptr es:[0204h]
	call	far 149Ah:0752h
	add	sp,0Ch
	push	ds
	push	24B0h
	mov	es,[3756h]
	push	word ptr es:[0206h]
	push	word ptr es:[0204h]
	call	far 149Ah:0752h
	add	sp,8h

l1054_15BE:
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	15CDh

l1054_15CA:
	jmp	1627h

l1054_15CD:
	mov	es,[374Eh]
	mov	bx,si
	shl	bx,2h
	push	word ptr es:[bx+0F230h]
	push	word ptr es:[bx+0F22Eh]
	push	ds
	push	24BDh
	mov	es,[3758h]
	push	word ptr es:[0216h]
	push	word ptr es:[0214h]
	call	far 149Ah:0752h
	add	sp,0Ch
	mov	es,[374Eh]
	mov	bx,si
	shl	bx,2h
	push	word ptr es:[bx+0F230h]
	push	word ptr es:[bx+0F22Eh]
	push	ds
	push	24E8h
	mov	es,[3758h]
	push	word ptr es:[0216h]
	push	word ptr es:[0214h]
	call	far 149Ah:0752h
	add	sp,0Ch

l1054_1627:
	mov	al,[bp-10h]
	push	ax
	push	si
	push	381Dh
	push	2C74h
	call	far 1054h:3E87h
	add	sp,8h

l1054_163A:
	les	bx,[bp-1Ah]
	test	byte ptr es:[bx+10h],4h
	jnz	1647h

l1054_1644:
	jmp	1717h

l1054_1647:
	les	bx,[bp-1Ah]
	test	byte ptr es:[bx+10h],1h
	jnz	1654h

l1054_1651:
	jmp	1670h

l1054_1654:
	les	bx,[bp+0FCC4h]
	mov	bx,es:[bx+12h]
	shl	bx,2h
	mov	es,[3750h]
	les	bx,es:[bx+0FBCAh]
	mov	al,es:[bx+58h]
	cbw
	jmp	1689h

l1054_1670:
	les	bx,[bp+0FCC4h]
	mov	bx,es:[bx+12h]
	shl	bx,2h
	mov	es,[374Eh]
	les	bx,es:[bx+0F22Eh]
	mov	al,es:[bx+26h]
	cbw

l1054_1689:
	mov	[bp+0FC7Ah],ax
	cmp	word ptr [bp+0FC7Ah],0h
	jge	1697h

l1054_1694:
	jmp	16EEh

l1054_1697:
	push	word ptr [bp-18h]
	push	word ptr [bp-1Ah]
	push	word ptr [bp-6h]
	push	word ptr [bp+0FC7Ah]
	call	far 1054h:0792h
	add	sp,8h
	mov	[bp-26h],ax
	cmp	word ptr [bp-26h],0h
	jl	16B8h

l1054_16B5:
	jmp	16C3h

l1054_16B8:
	les	bx,[bp-1Ah]
	and	word ptr es:[bx+10h],0FBh
	jmp	16E8h

l1054_16C3:
	mov	es,[3762h]
	mov	bx,[bp-26h]
	shl	bx,2h
	les	bx,es:[bx+0D072h]
	push	word ptr es:[bx+2h]
	push	ds
	push	2511h
	push	word ptr [bp-18h]
	push	word ptr [bp-1Ah]
	call	far 149Ah:280Ah
	add	sp,0Ah

l1054_16E8:
	jmp	12A4h
1054:16EB                                  E9 29 00                  .).  

l1054_16EE:
	les	bx,[bp-1Ah]
	and	word ptr es:[bx+10h],0FBh
	mov	es,[3772h]
	cmp	byte ptr es:[54D8h],1h
	jg	1705h

l1054_1702:
	jmp	1717h

l1054_1705:
	push	word ptr [bp-18h]
	push	word ptr [bp-1Ah]
	push	ds
	push	251Ch
	call	far 149Ah:0ABCh
	add	sp,8h

l1054_1717:
	jmp	12A4h

l1054_171A:
	mov	es,[3760h]
	cmp	word ptr es:[54DAh],0h
	jge	1729h

l1054_1726:
	jmp	1775h

l1054_1729:
	mov	bx,es:[54DAh]
	shl	bx,2h
	mov	es,[3762h]
	les	bx,es:[bx+0D072h]
	push	word ptr es:[bx+6h]
	push	word ptr es:[bx+4h]
	call	far 149Ah:22A8h
	add	sp,4h
	mov	es,[3760h]
	mov	ax,es:[54DAh]
	dec	word ptr es:[54DAh]
	mov	bx,ax
	shl	bx,2h
	mov	es,[3762h]
	push	word ptr es:[bx+0D074h]
	push	word ptr es:[bx+0D072h]
	call	far 149Ah:22A8h
	add	sp,4h
	jmp	171Ah

l1054_1775:
	jmp	1139h

l1054_1778:
	call	far 0800h:02FEh
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	178Ch

l1054_1789:
	jmp	19D7h

l1054_178C:
	push	word ptr [bp+0FC82h]
	push	word ptr [bp+0FC80h]
	push	ds
	push	2544h
	mov	es,[3758h]
	push	word ptr es:[0216h]
	push	word ptr es:[0214h]
	call	far 149Ah:0752h
	add	sp,0Ch
	push	ds
	push	255Eh
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,8h
	mov	es,[3768h]
	push	word ptr es:[5512h]
	push	word ptr es:[5510h]
	push	word ptr es:[54F6h]
	mov	ax,es:[54F4h]
	sub	ax,[bp-0Ah]
	push	ax
	push	word ptr [bp+0FC82h]
	push	word ptr [bp+0FC80h]
	push	ds
	push	259Fh
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,14h
	mov	es,[3768h]
	push	word ptr es:[5502h]
	push	word ptr es:[5500h]
	push	word ptr es:[54FEh]
	push	word ptr es:[54FCh]
	push	ds
	push	25BFh
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,10h
	push	0h
	push	word ptr [bp-2h]
	push	word ptr [bp-4h]
	push	word ptr [bp+0FC7Ch]
	call	far 149Ah:1DEAh
	add	sp,8h
	mov	word ptr [bp-0Ah],0h
	mov	di,0h
	jmp	1857h

l1054_1856:
	inc	di

l1054_1857:
	mov	es,[3768h]
	cmp	es:[54F4h],di
	jg	1865h

l1054_1862:
	jmp	19D7h

l1054_1865:
	push	word ptr [bp-16h]
	push	word ptr [bp+0FCC6h]
	push	word ptr [bp+0FCC4h]
	push	word ptr [bp+0FC7Ch]
	call	far 149Ah:2030h
	add	sp,8h
	mov	es,[376Ch]
	mov	bx,di
	shl	bx,2h
	mov	ax,es:[bx+0D2B8h]
	mov	dx,es:[bx+0D2BAh]
	mov	[bp-1Ah],ax
	mov	[bp-18h],dx
	or	dx,ax
	jz	189Ch

l1054_1899:
	jmp	18A2h

l1054_189C:
	inc	word ptr [bp-0Ah]
	jmp	1856h

l1054_18A2:
	les	bx,[bp+0FCC4h]
	mov	ax,es:[bx+14h]
	mov	dx,es:[bx+16h]
	mov	[bp-0Eh],ax
	mov	[bp-0Ch],dx
	les	bx,[bp+0FCC4h]
	mov	ax,es:[bx+18h]
	mov	dx,es:[bx+1Ah]
	mov	[bp-14h],ax
	mov	[bp-12h],dx
	les	bx,[bp+0FCC4h]
	mov	ax,es:[bx+1Ch]
	mov	dx,es:[bx+1Eh]
	mov	[bp-1Eh],ax
	mov	[bp-1Ch],dx
	mov	ax,di
	sub	ax,[bp-0Ah]
	push	ax
	push	ds
	push	25F5h
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,0Ah
	les	bx,[bp-1Ah]
	mov	al,es:[bx+10h]
	and	ax,4h
	cmp	ax,1h
	cmc
	sbb	ax,ax
	and	ax,4h
	mov	[bp-38h],ax
	les	bx,[bp-1Ah]
	test	byte ptr es:[bx+10h],1h
	jnz	191Bh

l1054_1918:
	jmp	191Fh

l1054_191B:
	or	word ptr [bp-38h],1h

l1054_191F:
	les	bx,[bp-1Ah]
	test	byte ptr es:[bx+10h],2h
	jnz	192Ch

l1054_1929:
	jmp	1930h

l1054_192C:
	or	word ptr [bp-38h],2h

l1054_1930:
	push	word ptr [bp-38h]
	push	word ptr [bp-18h]
	push	word ptr [bp-1Ah]
	push	ds
	push	2610h
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,0Eh
	push	word ptr [bp-0Ch]
	push	word ptr [bp-0Eh]
	push	ds
	push	261Eh
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,0Ch
	push	word ptr [bp-12h]
	push	word ptr [bp-14h]
	push	ds
	push	2640h
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,0Ch
	push	word ptr [bp-1Ch]
	push	word ptr [bp-1Eh]
	push	ds
	push	2662h
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,0Ch
	les	bx,[bp-1Ah]
	push	word ptr es:[bx+12h]
	push	ds
	push	2684h
	mov	es,[3766h]
	push	word ptr es:[5B66h]
	push	word ptr es:[5B64h]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	1856h

l1054_19D7:
	push	word ptr [bp+0FC7Ch]
	call	far 149Ah:1DCAh
	add	sp,2h
	mov	di,0h
	jmp	19EAh

l1054_19E9:
	inc	di

l1054_19EA:
	mov	es,[3768h]
	cmp	es:[54F4h],di
	jg	19F8h

l1054_19F5:
	jmp	1A2Ah

l1054_19F8:
	mov	es,[376Ch]
	mov	bx,di
	shl	bx,2h
	mov	ax,es:[bx+0D2BAh]
	or	ax,es:[bx+0D2B8h]
	jnz	1A10h

l1054_1A0D:
	jmp	1A27h

l1054_1A10:
	mov	bx,di
	shl	bx,2h
	push	word ptr es:[bx+0D2BAh]
	push	word ptr es:[bx+0D2B8h]
	call	far 149Ah:22AEh
	add	sp,4h

l1054_1A27:
	jmp	19E9h

l1054_1A2A:
	push	word ptr [bp+0FCC6h]
	push	word ptr [bp+0FCC4h]
	call	far 149Ah:22AEh
	add	sp,4h
	mov	ax,[bp-8h]
	mov	es,[376Ah]
	mov	es:[5B8Ch],ax

l1054_1A45:
	pop	si
	pop	di
	leave
	retf

;; fn1054_1A49: 1054:1A49
;;   Called from:
;;     0800:27A3 (in main)
fn1054_1A49 proc
	push	bp
	mov	bp,sp
	mov	ax,0E0h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[376Ah]
	mov	ax,es:[5B8Ch]
	mov	[bp-2Ch],ax
	mov	es,[3736h]
	mov	word ptr es:[5B62h],0h
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	1A7Bh

l1054_1A78:
	jmp	1AF0h

l1054_1A7B:
	mov	es,[3774h]
	cmp	byte ptr es:[0D2A6h],0h
	jnz	1A8Ah

l1054_1A87:
	jmp	1A90h

l1054_1A8A:
	mov	word ptr [1F6Ch],1h

l1054_1A90:
	cmp	word ptr [1F6Ch],0h
	jz	1A9Ah

l1054_1A97:
	jmp	1AF0h

l1054_1A9A:
	mov	word ptr [1F6Ch],1h
	mov	es,[3776h]
	push	word ptr es:[5B90h]
	push	word ptr es:[5B8Eh]
	push	ds
	push	2695h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ch
	mov	es,[3776h]
	push	word ptr es:[5B90h]
	push	word ptr es:[5B8Eh]
	push	ds
	push	26ACh
	mov	es,[377Ah]
	push	word ptr es:[2B6Ah]
	push	word ptr es:[2B68h]
	call	far 149Ah:0752h
	add	sp,0Ch

l1054_1AF0:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:260Eh
	add	sp,4h
	add	ax,[bp+6h]
	mov	dx,[bp+8h]
	mov	[bp+0FF68h],ax
	mov	[bp+0FF6Ah],dx
	push	ds
	push	26C3h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:2568h
	add	sp,8h
	push	ds
	push	26C8h
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:0736h
	add	sp,8h
	mov	[bp+0FF5Ah],ax
	mov	[bp+0FF5Ch],dx
	mov	ax,[bp+0FF5Ch]
	or	ax,[bp+0FF5Ah]
	jz	1B45h

l1054_1B42:
	jmp	1B57h

l1054_1B45:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	26CAh
	call	far 1054h:002Bh
	add	sp,8h

l1054_1B57:
	push	ds
	push	26E6h
	push	word ptr [bp+0FF6Ah]
	push	word ptr [bp+0FF68h]
	call	far 149Ah:25AEh
	add	sp,8h
	push	ds
	push	26EBh
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:0736h
	add	sp,8h
	mov	[bp+0FF44h],ax
	mov	[bp+0FF46h],dx
	mov	ax,[bp+0FF46h]
	or	ax,[bp+0FF44h]
	jz	1B92h

l1054_1B8F:
	jmp	1BA4h

l1054_1B92:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	26EEh
	call	far 1054h:002Bh
	add	sp,8h

l1054_1BA4:
	lea	ax,[bp+0FF2Ah]
	push	ss
	push	ax
	lea	ax,[bp-6h]
	push	ss
	push	ax
	lea	ax,[bp-34h]
	push	ss
	push	ax
	lea	ax,[bp+0FF30h]
	push	ss
	push	ax
	lea	ax,[bp+0FF34h]
	push	ss
	push	ax
	lea	ax,[bp+0FF3Ah]
	push	ss
	push	ax
	lea	ax,[bp-1Eh]
	push	ss
	push	ax
	push	ds
	push	270Ah
	push	word ptr [bp+0FF5Ch]
	push	word ptr [bp+0FF5Ah]
	call	far 149Ah:0904h
	add	sp,24h
	mov	[bp+0FF6Ch],ax
	cmp	word ptr [bp+0FF6Ch],7h
	jc	1BEDh

l1054_1BEA:
	jmp	1BF9h

l1054_1BED:
	push	ds
	push	2720h
	call	far 1054h:002Bh
	add	sp,4h

l1054_1BF9:
	cmp	word ptr [bp-6h],100h
	ja	1C03h

l1054_1C00:
	jmp	1C15h

l1054_1C03:
	push	100h
	push	word ptr [bp-6h]
	push	ds
	push	2738h
	call	far 1054h:002Bh
	add	sp,8h

l1054_1C15:
	cmp	word ptr [bp-34h],64h
	ja	1C1Eh

l1054_1C1B:
	jmp	1C2Fh

l1054_1C1E:
	push	64h
	push	word ptr [bp-34h]
	push	ds
	push	2758h
	call	far 1054h:002Bh
	add	sp,8h

l1054_1C2F:
	cmp	word ptr [bp+0FF2Ah],9C4h
	ja	1C3Ah

l1054_1C37:
	jmp	1C4Dh

l1054_1C3A:
	push	9C4h
	push	word ptr [bp+0FF2Ah]
	push	ds
	push	2777h
	call	far 1054h:002Bh
	add	sp,8h

l1054_1C4D:
	push	word ptr [bp+0FF46h]
	push	word ptr [bp+0FF44h]
	push	50h
	lea	ax,[bp+0FF74h]
	push	ss
	push	ax
	call	far 149Ah:272Eh
	add	sp,0Ah
	or	dx,ax
	jz	1C6Ch

l1054_1C69:
	jmp	1C78h

l1054_1C6C:
	push	ds
	push	2795h
	call	far 1054h:002Bh
	add	sp,4h

l1054_1C78:
	lea	ax,[bp+0FF6Eh]
	push	ss
	push	ax
	push	ds
	push	27B0h
	lea	ax,[bp+0FF74h]
	push	ss
	push	ax
	call	far 149Ah:2876h
	add	sp,0Ch
	cmp	ax,0h
	jz	1C98h

l1054_1C95:
	jmp	1CA4h

l1054_1C98:
	push	ds
	push	27B4h
	call	far 1054h:002Bh
	add	sp,4h

l1054_1CA4:
	cmp	word ptr [bp+0FF6Eh],190h
	ja	1CAFh

l1054_1CAC:
	jmp	1CC2h

l1054_1CAF:
	push	190h
	push	word ptr [bp+0FF6Eh]
	push	ds
	push	27CEh
	call	far 1054h:002Bh
	add	sp,8h

l1054_1CC2:
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	1CD1h

l1054_1CCE:
	jmp	1D3Dh

l1054_1CD1:
	push	ds
	push	27EDh
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,8h
	mov	es,[377Ch]
	cmp	byte ptr es:[2C70h],0h
	jnz	1CFAh

l1054_1CF7:
	jmp	1D14h

l1054_1CFA:
	push	ds
	push	27EFh
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,8h

l1054_1D14:
	lea	ax,[bp-1Eh]
	push	ss
	push	ax
	call	far 1054h:000Eh
	add	sp,4h
	push	dx
	push	ax
	push	ds
	push	27F1h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ch

l1054_1D3D:
	mov	word ptr [bp+0FF48h],0h
	jmp	1D4Ah

l1054_1D46:
	inc	word ptr [bp+0FF48h]

l1054_1D4A:
	mov	ax,[bp+0FF6Eh]
	cmp	[bp+0FF48h],ax
	jc	1D57h

l1054_1D54:
	jmp	22FCh

l1054_1D57:
	push	word ptr [bp+0FF46h]
	push	word ptr [bp+0FF44h]
	push	50h
	lea	ax,[bp+0FF74h]
	push	ss
	push	ax
	call	far 149Ah:272Eh
	add	sp,0Ah
	or	dx,ax
	jz	1D76h

l1054_1D73:
	jmp	1D82h

l1054_1D76:
	push	ds
	push	27FAh
	call	far 1054h:002Bh
	add	sp,4h

l1054_1D82:
	lea	ax,[bp+0FF2Ch]
	push	ss
	push	ax
	lea	ax,[bp+0FF56h]
	push	ss
	push	ax
	lea	ax,[bp+0FF62h]
	push	ss
	push	ax
	mov	ax,[bp+0FF48h]
	mov	cx,ax
	shl	ax,2h
	add	ax,cx
	shl	ax,1h
	add	ax,780h
	push	180Ah
	push	ax
	push	ds
	push	280Fh
	lea	ax,[bp+0FF74h]
	push	ss
	push	ax
	call	far 149Ah:2876h
	add	sp,18h
	cmp	ax,4h
	jnz	1DC2h

l1054_1DBF:
	jmp	1DCEh

l1054_1DC2:
	push	ds
	push	281Ch
	call	far 1054h:002Bh
	add	sp,4h

l1054_1DCE:
	mov	ax,[bp+0FF62h]
	mov	es,[377Eh]
	mov	bx,[bp+0FF48h]
	mov	cx,bx
	shl	bx,2h
	add	bx,cx
	shl	bx,1h
	mov	es:[bx+782h],ax
	mov	ax,[bp+0FF56h]
	mov	bx,[bp+0FF48h]
	mov	cx,bx
	shl	bx,2h
	add	bx,cx
	shl	bx,1h
	mov	es:[bx+784h],ax
	mov	ax,[bp+0FF56h]
	mul	word ptr [bp+0FF62h]
	mov	[bp+0FF64h],ax
	mov	[bp+0FF66h],dx
	cmp	word ptr [bp+0FF66h],0h
	jbe	1E18h

l1054_1E15:
	jmp	1E22h

l1054_1E18:
	cmp	word ptr [bp+0FF64h],0DCh
	ja	1E22h

l1054_1E1F:
	jmp	1E3Ah

l1054_1E22:
	push	0h
	push	0DCh
	push	word ptr [bp+0FF56h]
	push	word ptr [bp+0FF62h]
	push	ds
	push	2838h
	call	far 1054h:002Bh
	add	sp,0Ch

l1054_1E3A:
	sub	ax,ax
	mov	[bp-2Eh],ax
	mov	[bp-30h],ax
	mov	es,[373Eh]
	mov	ax,es:[0D29Eh]
	mov	dx,es:[0D2A0h]
	mov	[bp+0FF52h],ax
	mov	[bp+0FF54h],dx
	push	word ptr [bp+0FF46h]
	push	word ptr [bp+0FF44h]
	push	word ptr [bp+0FF64h]
	push	1h
	mov	es,[3780h]
	push	word ptr es:[0A7E2h]
	push	word ptr es:[0A7E0h]
	call	far 149Ah:0792h
	add	sp,0Ch
	cmp	ax,[bp+0FF64h]
	jc	1E84h

l1054_1E81:
	jmp	1E90h

l1054_1E84:
	push	ds
	push	2867h
	call	far 1054h:002Bh
	add	sp,4h

l1054_1E90:
	lea	ax,[bp-2Ah]
	push	ss
	push	ax
	mov	cx,[bp+0FF64h]
	mov	dx,[bp+0FF66h]
	shr	dx,1h
	rcr	cx,1h
	push	dx
	push	cx
	mov	es,[3780h]
	push	word ptr es:[0A7E2h]
	push	word ptr es:[0A7E0h]
	call	far 1054h:35FCh
	add	sp,0Ch
	mov	[bp-30h],ax
	mov	[bp-2Eh],dx
	mov	es,[3782h]
	mov	ax,es:[2B6Eh]
	mov	[bp-26h],ax
	cmp	word ptr [bp-26h],0h
	jnz	1ED3h

l1054_1ED0:
	jmp	1F0Ch

l1054_1ED3:
	mov	cl,es:[2B6Eh]
	mov	ax,1h
	shl	ax,cl
	cmp	ax,[bp-2Ah]
	jle	1EE5h

l1054_1EE2:
	jmp	1F0Ch

l1054_1EE5:
	push	word ptr es:[2B6Eh]
	mov	ax,[bp-2Ah]
	inc	ax
	push	ax
	push	ds
	push	2889h
	call	far 149Ah:0ABCh
	add	sp,8h
	push	word ptr [bp-2Ah]
	call	far 1054h:0083h
	add	sp,2h
	mov	[bp-26h],ax
	jmp	1F41h

l1054_1F0C:
	cmp	word ptr [bp-26h],0h
	jz	1F15h

l1054_1F12:
	jmp	1F41h

l1054_1F15:
	push	word ptr [bp-2Ah]
	call	far 1054h:0083h
	add	sp,2h
	mov	[bp-26h],ax
	mov	es,[3772h]
	cmp	byte ptr es:[54D8h],3h
	jg	1F32h

l1054_1F2F:
	jmp	1F41h

l1054_1F32:
	push	word ptr [bp-26h]
	push	ds
	push	28C4h
	call	far 149Ah:0ABCh
	add	sp,6h

l1054_1F41:
	mov	es,[376Ah]
	cmp	word ptr es:[5B8Ch],0h
	jnz	1F50h

l1054_1F4D:
	jmp	1F85h

l1054_1F50:
	cmp	word ptr [bp+0FF62h],0Ah
	jbe	1F5Ah

l1054_1F57:
	jmp	1F85h

l1054_1F5A:
	mov	word ptr es:[5B8Ch],0h
	mov	es,[3772h]
	cmp	byte ptr es:[54D8h],3h
	jg	1F70h

l1054_1F6D:
	jmp	1F7Ch

l1054_1F70:
	push	ds
	push	28F0h
	call	far 149Ah:0ABCh
	add	sp,4h

l1054_1F7C:
	mov	es,[3784h]
	inc	word ptr es:[022Eh]

l1054_1F85:
	push	word ptr [bp+0FF66h]
	push	word ptr [bp+0FF64h]
	mov	ax,[bp-26h]
	cwd
	push	dx
	push	ax
	call	far 149Ah:36B0h
	mov	es,[3786h]
	mov	es:[0A822h],ax
	mov	es:[0A824h],dx
	mov	ah,[bp-26h]
	and	ax,700h
	shl	ah,4h
	mov	es,[3788h]
	mov	es:[5B92h],ax
	mov	es,[376Ah]
	cmp	word ptr es:[5B8Ch],0h
	jnz	1FC5h

l1054_1FC2:
	jmp	2010h

l1054_1FC5:
	push	word ptr [bp-26h]
	push	word ptr [bp+0FF62h]
	push	word ptr [bp+0FF56h]
	mov	es,[3780h]
	push	word ptr es:[0A7E2h]
	push	word ptr es:[0A7E0h]
	call	far 0800h:6F20h
	add	sp,0Ah
	mov	es,[376Ah]
	mov	es:[5B8Ch],ax
	cmp	word ptr es:[5B8Ch],0h
	jnz	1FF9h

l1054_1FF6:
	jmp	2010h

l1054_1FF9:
	mov	ax,es:[5B8Ch]
	mov	es,[3788h]
	mov	es:[5B92h],ax
	mov	es,[376Ah]
	mov	word ptr es:[5B8Ch],1h

l1054_2010:
	mov	es,[378Ah]
	cmp	byte ptr es:[0FDCCh],0h
	jnz	201Fh

l1054_201C:
	jmp	2041h

l1054_201F:
	mov	es,[3786h]
	mov	ax,es:[0A822h]
	mov	dx,es:[0A824h]
	add	ax,0Fh
	adc	dx,0h
	and	ax,0FFF0h
	and	dx,0FFh
	mov	es:[0A822h],ax
	mov	es:[0A824h],dx

l1054_2041:
	mov	es,[378Ch]
	cmp	byte ptr es:[5B60h],0h
	jnz	2050h

l1054_204D:
	jmp	20C5h

l1054_2050:
	mov	es,[3788h]
	push	word ptr es:[5B92h]
	push	word ptr [bp-2Eh]
	push	word ptr [bp-30h]
	push	word ptr [bp+0FF56h]
	push	word ptr [bp+0FF62h]
	call	far 1054h:37DDh
	add	sp,0Ah
	mov	[bp+0FF24h],ax
	mov	[bp+0FF26h],dx
	cmp	ax,0FFFFh
	jz	207Fh

l1054_207C:
	jmp	2087h

l1054_207F:
	cmp	dx,0FFh
	jnz	2087h

l1054_2084:
	jmp	20C5h

l1054_2087:
	mov	es,[378Eh]
	inc	word ptr es:[0D272h]
	mov	es,[3786h]
	mov	ax,es:[0A822h]
	mov	dx,es:[0A824h]
	mov	es,[3790h]
	add	es:[2A24h],ax
	adc	es:[2A26h],dx
	sub	ax,ax
	mov	[bp+0FF66h],ax
	mov	[bp+0FF64h],ax
	mov	ax,[bp+0FF24h]
	mov	dx,[bp+0FF26h]
	mov	[bp+0FF52h],ax
	mov	[bp+0FF54h],dx

l1054_20C5:
	mov	ax,[bp+0FF66h]
	or	ax,[bp+0FF64h]
	jnz	20D2h

l1054_20CF:
	jmp	2141h

l1054_20D2:
	mov	es,[3786h]
	push	word ptr es:[0A824h]
	push	word ptr es:[0A822h]
	call	far 0800h:7D25h
	add	sp,4h
	cmp	ax,0h
	jl	20F0h

l1054_20ED:
	jmp	20FFh

l1054_20F0:
	push	ds
	push	2918h
	call	far 149Ah:0ABCh
	add	sp,4h
	jmp	2141h

l1054_20FF:
	mov	es,[3788h]
	push	word ptr es:[5B92h]
	push	word ptr [bp+0FF54h]
	push	word ptr [bp+0FF52h]
	push	word ptr [bp-2Eh]
	push	word ptr [bp-30h]
	push	word ptr [bp+0FF56h]
	push	word ptr [bp+0FF62h]
	call	far 1054h:38F9h
	add	sp,0Eh
	mov	es,[3786h]
	mov	ax,es:[0A822h]
	mov	dx,es:[0A824h]
	mov	es,[374Ah]
	add	es:[0D2A2h],ax
	adc	es:[0D2A4h],dx

l1054_2141:
	mov	ax,[bp+0FF66h]
	or	ax,[bp+0FF64h]
	jnz	214Eh

l1054_214B:
	jmp	219Dh

l1054_214E:
	mov	es,[3746h]
	cmp	byte ptr es:[0FED8h],0h
	jz	215Dh

l1054_215A:
	jmp	216Ch

l1054_215D:
	mov	es,[3748h]
	cmp	byte ptr es:[4CBEh],0h
	jnz	216Ch

l1054_2169:
	jmp	219Dh

l1054_216C:
	mov	es,[3786h]
	push	word ptr es:[0A824h]
	push	word ptr es:[0A822h]
	call	far 0800h:8095h
	add	sp,4h
	push	0h
	mov	es,[3788h]
	push	word ptr es:[5B92h]
	push	word ptr [bp+0FF56h]
	push	word ptr [bp+0FF62h]
	call	far 0800h:7B88h
	add	sp,8h

l1054_219D:
	mov	ax,[bp+0FF52h]
	mov	dx,[bp+0FF54h]
	mov	es,[377Eh]
	mov	bx,[bp+0FF48h]
	mov	cx,bx
	shl	bx,2h
	add	bx,cx
	shl	bx,1h
	mov	es:[bx+786h],ax
	mov	es:[bx+788h],dx
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	21CFh

l1054_21CC:
	jmp	22EEh

l1054_21CF:
	mov	es,[377Ch]
	cmp	byte ptr es:[2C70h],0h
	jz	21DEh

l1054_21DB:
	jmp	22EEh

l1054_21DE:
	mov	es,[3792h]
	cmp	word ptr es:[0F1FCh],0h
	jnz	21EDh

l1054_21EA:
	jmp	2213h

l1054_21ED:
	mov	es,[3794h]
	cmp	word ptr es:[54E2h],0h
	jnz	21FCh

l1054_21F9:
	jmp	2205h

l1054_21FC:
	mov	ax,0h
	mov	dx,200h
	jmp	220Bh

l1054_2205:
	mov	ax,0h
	mov	dx,0FE00h

l1054_220B:
	add	[bp+0FF52h],ax
	adc	[bp+0FF54h],dx

l1054_2213:
	cmp	word ptr [bp+0FF48h],0h
	jz	221Dh

l1054_221A:
	jmp	2287h

l1054_221D:
	push	word ptr [bp+0FF56h]
	push	word ptr [bp+0FF62h]
	push	ds
	push	293Fh
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ch
	push	word ptr [bp+0FF54h]
	push	word ptr [bp+0FF52h]
	push	ds
	push	295Dh
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ch
	mov	es,[3788h]
	push	word ptr es:[5B92h]
	push	ds
	push	2974h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	22EEh

l1054_2287:
	push	word ptr [bp+0FF56h]
	push	word ptr [bp+0FF62h]
	push	ds
	push	298Bh
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ch
	push	word ptr [bp+0FF54h]
	push	word ptr [bp+0FF52h]
	push	ds
	push	2999h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ch
	mov	es,[3788h]
	push	word ptr es:[5B92h]
	push	ds
	push	29A7h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ah

l1054_22EE:
	mov	ax,[bp-2Ch]
	mov	es,[376Ah]
	mov	es:[5B8Ch],ax
	jmp	1D46h

l1054_22FC:
	mov	es,[377Ch]
	cmp	byte ptr es:[2C70h],0h
	jnz	230Bh

l1054_2308:
	jmp	2447h

l1054_230B:
	mov	es,[3796h]
	cmp	word ptr es:[5B70h],32h
	jge	231Ah

l1054_2317:
	jmp	2328h

l1054_231A:
	push	32h
	push	ds
	push	29B4h
	call	far 1054h:002Bh
	add	sp,6h

l1054_2328:
	mov	es,[373Eh]
	mov	ax,es:[0D29Eh]
	mov	dx,es:[0D2A0h]
	mov	es,[3796h]
	mov	bx,es:[5B70h]
	shl	bx,2h
	mov	es,[3798h]
	mov	es:[bx+0CFA0h],ax
	mov	es:[bx+0CFA2h],dx
	mov	es,[373Eh]
	push	word ptr es:[0D2A0h]
	push	word ptr es:[0D29Eh]
	push	word ptr [bp+0FF6Eh]
	push	ds
	push	29DEh
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Eh
	mov	es,[3738h]
	cmp	word ptr es:[54EAh],0h
	jnz	238Ah

l1054_2387:
	jmp	239Dh

l1054_238A:
	mov	ax,10h
	sub	ax,es:[54EAh]
	push	ax
	push	0h
	call	far 0800h:7AF7h
	add	sp,4h

l1054_239D:
	push	10h
	push	word ptr [bp+0FF6Eh]
	call	far 0800h:7AF7h
	add	sp,4h
	mov	word ptr [bp+0FF48h],0h
	jmp	23B8h

l1054_23B4:
	inc	word ptr [bp+0FF48h]

l1054_23B8:
	mov	ax,[bp+0FF6Eh]
	cmp	[bp+0FF48h],ax
	jc	23C5h

l1054_23C2:
	jmp	2447h

l1054_23C5:
	push	10h
	mov	es,[377Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,2h
	add	bx,ax
	shl	bx,1h
	push	word ptr es:[bx+782h]
	call	far 0800h:7AF7h
	add	sp,4h
	push	10h
	mov	es,[377Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,2h
	add	bx,ax
	shl	bx,1h
	push	word ptr es:[bx+784h]
	call	far 0800h:7AF7h
	add	sp,4h
	mov	es,[377Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,2h
	add	bx,ax
	shl	bx,1h
	mov	ax,es:[bx+786h]
	mov	dx,es:[bx+788h]
	mov	[bp+0FF52h],ax
	mov	[bp+0FF54h],dx
	push	10h
	push	word ptr [bp+0FF52h]
	call	far 0800h:7AF7h
	add	sp,4h
	push	10h
	push	word ptr [bp+0FF54h]
	call	far 0800h:7AF7h
	add	sp,4h
	jmp	23B4h

l1054_2447:
	mov	word ptr [bp+0FF48h],0h
	jmp	2454h

l1054_2450:
	inc	word ptr [bp+0FF48h]

l1054_2454:
	mov	ax,[bp-6h]
	cmp	[bp+0FF48h],ax
	jc	2460h

l1054_245D:
	jmp	26C3h

l1054_2460:
	push	word ptr [bp+0FF46h]
	push	word ptr [bp+0FF44h]
	push	50h
	lea	ax,[bp+0FF74h]
	push	ss
	push	ax
	call	far 149Ah:272Eh
	add	sp,0Ah
	or	dx,ax
	jz	247Fh

l1054_247C:
	jmp	248Bh

l1054_247F:
	push	ds
	push	29F9h
	call	far 1054h:002Bh
	add	sp,4h

l1054_248B:
	lea	ax,[bp+0FF5Eh]
	push	ss
	push	ax
	lea	ax,[bp-14h]
	push	ss
	push	ax
	push	ds
	push	2A12h
	lea	ax,[bp+0FF74h]
	push	ss
	push	ax
	call	far 149Ah:2876h
	add	sp,10h
	mov	[bp+0FF6Ch],ax
	cmp	word ptr [bp+0FF6Ch],2h
	jnz	24B6h

l1054_24B3:
	jmp	24C6h

l1054_24B6:
	push	word ptr [bp+0FF48h]
	push	ds
	push	2A19h
	call	far 1054h:002Bh
	add	sp,6h

l1054_24C6:
	push	word ptr [bp+0FF46h]
	push	word ptr [bp+0FF44h]
	push	word ptr [bp+0FF5Eh]
	push	2h
	mov	es,[3780h]
	push	word ptr es:[0A7E2h]
	push	word ptr es:[0A7E0h]
	call	far 149Ah:0792h
	add	sp,0Ch
	cmp	ax,[bp+0FF5Eh]
	jc	24F3h

l1054_24F0:
	jmp	24FFh

l1054_24F3:
	push	ds
	push	2A3Eh
	call	far 1054h:002Bh
	add	sp,4h

l1054_24FF:
	lea	ax,[bp-14h]
	push	ss
	push	ax
	call	far 1054h:3541h
	add	sp,4h
	mov	es,[379Ah]
	mov	bx,[bp+0FF48h]
	shl	bx,1h
	mov	es:[bx+0h],ax
	mov	bx,[bp+0FF48h]
	shl	bx,1h
	cmp	word ptr es:[bx+0h],0FFh
	jnz	252Ch

l1054_2529:
	jmp	252Fh

l1054_252C:
	jmp	26C0h

l1054_252F:
	lea	ax,[bp-14h]
	push	ss
	push	ax
	call	far 0800h:757Ch
	add	sp,4h
	cmp	ax,0h
	jnz	2544h

l1054_2541:
	jmp	2563h

l1054_2544:
	lea	ax,[bp-14h]
	push	ss
	push	ax
	call	far 1054h:35A1h
	add	sp,4h
	mov	es,[379Ah]
	mov	bx,[bp+0FF48h]
	shl	bx,1h
	mov	es:[bx+0h],ax
	jmp	26C0h

l1054_2563:
	lea	ax,[bp-14h]
	push	ss
	push	ax
	call	far 1054h:35A1h
	add	sp,4h
	mov	es,[379Ah]
	mov	bx,[bp+0FF48h]
	shl	bx,1h
	mov	es:[bx+0h],ax
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	258Eh

l1054_258B:
	jmp	26C0h

l1054_258E:
	push	word ptr [bp+0FF48h]
	mov	es,[379Ah]
	mov	bx,[bp+0FF48h]
	shl	bx,1h
	mov	ax,es:[bx+0h]
	mov	cx,ax
	shl	ax,2h
	add	ax,cx
	shl	ax,1h
	add	ax,1768h
	push	180Ah
	push	ax
	push	ds
	push	2A4Fh
	mov	es,[377Ah]
	push	word ptr es:[2B6Ah]
	push	word ptr es:[2B68h]
	call	far 149Ah:0752h
	add	sp,0Eh
	push	word ptr [bp+0FF5Eh]
	push	ds
	push	2A5Dh
	mov	es,[377Ah]
	push	word ptr es:[2B6Ah]
	push	word ptr es:[2B68h]
	call	far 149Ah:0752h
	add	sp,0Ah
	mov	word ptr [bp-32h],1h
	mov	es,[3780h]
	mov	ax,es:[0A7E0h]
	mov	dx,es:[0A7E2h]
	mov	es,[379Ch]
	mov	es:[06CEh],ax
	mov	es:[06D0h],dx
	mov	word ptr [bp+0FF4Ch],0h
	jmp	2615h

l1054_2611:
	inc	word ptr [bp+0FF4Ch]

l1054_2615:
	mov	ax,[bp+0FF5Eh]
	cmp	[bp+0FF4Ch],ax
	jc	2622h

l1054_261F:
	jmp	26A6h

l1054_2622:
	cmp	word ptr [bp-32h],1h
	jz	262Bh

l1054_2628:
	jmp	265Fh

l1054_262B:
	mov	es,[379Ch]
	mov	bx,es:[06CEh]
	add	word ptr es:[06CEh],2h
	mov	es,es:[06D0h]
	push	word ptr es:[bx]
	push	ds
	push	2A71h
	mov	es,[377Ah]
	push	word ptr es:[2B6Ah]
	push	word ptr es:[2B68h]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	2690h

l1054_265F:
	mov	es,[379Ch]
	mov	bx,es:[06CEh]
	add	word ptr es:[06CEh],2h
	mov	es,es:[06D0h]
	push	word ptr es:[bx]
	push	ds
	push	2A7Eh
	mov	es,[377Ah]
	push	word ptr es:[2B6Ah]
	push	word ptr es:[2B68h]
	call	far 149Ah:0752h
	add	sp,0Ah

l1054_2690:
	mov	ax,[bp-32h]
	inc	word ptr [bp-32h]
	cmp	ax,0Ah
	jz	269Eh

l1054_269B:
	jmp	26A3h

l1054_269E:
	mov	word ptr [bp-32h],1h

l1054_26A3:
	jmp	2611h

l1054_26A6:
	push	ds
	push	2A84h
	mov	es,[377Ah]
	push	word ptr es:[2B6Ah]
	push	word ptr es:[2B68h]
	call	far 149Ah:0752h
	add	sp,8h

l1054_26C0:
	jmp	2450h

l1054_26C3:
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	26D2h

l1054_26CF:
	jmp	27B2h

l1054_26D2:
	lea	ax,[bp-1Eh]
	push	ss
	push	ax
	call	far 1054h:000Eh
	add	sp,4h
	push	dx
	push	ax
	push	ds
	push	2A86h
	mov	es,[377Ah]
	push	word ptr es:[2B6Ah]
	push	word ptr es:[2B68h]
	call	far 149Ah:0752h
	add	sp,0Ch
	lea	ax,[bp-1Eh]
	push	ss
	push	ax
	call	far 1054h:000Eh
	add	sp,4h
	push	dx
	push	ax
	push	ds
	push	2A90h
	mov	es,[375Ah]
	push	word ptr es:[0FDD2h]
	push	word ptr es:[0FDD0h]
	call	far 149Ah:0752h
	add	sp,0Ch
	mov	word ptr [bp+0FF48h],0h
	jmp	2731h

l1054_272D:
	inc	word ptr [bp+0FF48h]

l1054_2731:
	mov	ax,[bp-6h]
	cmp	[bp+0FF48h],ax
	jc	273Dh

l1054_273A:
	jmp	27B2h

l1054_273D:
	mov	es,[379Ah]
	mov	bx,[bp+0FF48h]
	shl	bx,1h
	mov	ax,es:[bx+0h]
	mov	cx,ax
	shl	ax,2h
	add	ax,cx
	shl	ax,1h
	add	ax,1768h
	push	180Ah
	push	ax
	push	ds
	push	2AA0h
	mov	es,[377Ah]
	push	word ptr es:[2B6Ah]
	push	word ptr es:[2B68h]
	call	far 149Ah:0752h
	add	sp,0Ch
	mov	es,[379Ah]
	mov	bx,[bp+0FF48h]
	shl	bx,1h
	mov	ax,es:[bx+0h]
	mov	cx,ax
	shl	ax,2h
	add	ax,cx
	shl	ax,1h
	add	ax,1768h
	push	180Ah
	push	ax
	push	ds
	push	2AABh
	mov	es,[375Ah]
	push	word ptr es:[0FDD2h]
	push	word ptr es:[0FDD0h]
	call	far 149Ah:0752h
	add	sp,0Ch
	jmp	272Dh

l1054_27B2:
	cmp	word ptr [bp-34h],64h
	ja	27BBh

l1054_27B8:
	jmp	27CCh

l1054_27BB:
	push	64h
	push	word ptr [bp-34h]
	push	ds
	push	2AB7h
	call	far 1054h:002Bh
	add	sp,8h

l1054_27CC:
	mov	word ptr [bp+0FF48h],0h
	jmp	27D9h

l1054_27D5:
	inc	word ptr [bp+0FF48h]

l1054_27D9:
	mov	ax,[bp-34h]
	cmp	[bp+0FF48h],ax
	jc	27E5h

l1054_27E2:
	jmp	2852h

l1054_27E5:
	imul	ax,[bp+0FF48h],14h
	add	ax,2240h
	push	381Dh
	push	ax
	imul	ax,[bp+0FF48h],14h
	add	ax,223Eh
	push	381Dh
	push	ax
	imul	ax,[bp+0FF48h],14h
	add	ax,223Ch
	push	381Dh
	push	ax
	imul	ax,[bp+0FF48h],14h
	add	ax,223Ah
	push	381Dh
	push	ax
	imul	ax,[bp+0FF48h],14h
	add	ax,2230h
	push	381Dh
	push	ax
	push	ds
	push	2AD6h
	push	word ptr [bp+0FF5Ch]
	push	word ptr [bp+0FF5Ah]
	call	far 149Ah:0904h
	add	sp,1Ch
	mov	[bp+0FF6Ch],ax
	cmp	word ptr [bp+0FF6Ch],5h
	jc	2843h

l1054_2840:
	jmp	284Fh

l1054_2843:
	push	ds
	push	2AE6h
	call	far 1054h:002Bh
	add	sp,4h

l1054_284F:
	jmp	27D5h

l1054_2852:
	mov	word ptr [bp-28h],0h
	jmp	285Dh

l1054_285A:
	inc	word ptr [bp-28h]

l1054_285D:
	mov	ax,[bp+0FF2Ah]
	cmp	[bp-28h],ax
	jc	2869h

l1054_2866:
	jmp	29CFh

l1054_2869:
	lea	ax,[bp+0FF32h]
	push	ss
	push	ax
	lea	ax,[bp+0FF28h]
	push	ss
	push	ax
	lea	ax,[bp+0FF42h]
	push	ss
	push	ax
	lea	ax,[bp+0FF58h]
	push	ss
	push	ax
	lea	ax,[bp+0FF38h]
	push	ss
	push	ax
	push	ds
	push	2AFCh
	push	word ptr [bp+0FF5Ch]
	push	word ptr [bp+0FF5Ah]
	call	far 149Ah:0904h
	add	sp,1Ch
	cmp	ax,5h
	jl	28A3h

l1054_28A0:
	jmp	28AFh

l1054_28A3:
	push	ds
	push	2B0Ch
	call	far 1054h:002Bh
	add	sp,4h

l1054_28AF:
	and	word ptr [bp+0FF38h],0F0h
	mov	al,[bp+0FF32h]
	and	ax,0Fh
	or	[bp+0FF38h],ax
	mov	ax,[bp+0FF38h]
	mov	es,[379Eh]
	mov	bx,[bp-28h]
	mov	cx,bx
	shl	bx,1h
	add	bx,cx
	shl	bx,2h
	mov	es:[bx+32A4h],ax
	mov	ax,[bp+0FF58h]
	mov	bx,[bp-28h]
	mov	cx,bx
	shl	bx,1h
	add	bx,cx
	shl	bx,2h
	mov	es:[bx+32A6h],ax
	mov	ax,[bp+0FF42h]
	mov	bx,[bp-28h]
	mov	cx,bx
	shl	bx,1h
	add	bx,cx
	shl	bx,2h
	mov	es:[bx+32A8h],ax
	mov	ax,[bp+0FF28h]
	mov	bx,[bp-28h]
	mov	cx,bx
	shl	bx,1h
	add	bx,cx
	shl	bx,2h
	mov	es:[bx+32AAh],ax
	mov	bx,[bp-28h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	word ptr es:[bx+32ACh],0h
	mov	word ptr [bp+0FF48h],0h
	jmp	2937h

l1054_2933:
	inc	word ptr [bp+0FF48h]

l1054_2937:
	mov	ax,[bp+0FF6Eh]
	cmp	[bp+0FF48h],ax
	jc	2944h

l1054_2941:
	jmp	297Ah

l1054_2944:
	mov	es,[379Eh]
	mov	bx,[bp-28h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	ax,es:[bx+32AAh]
	mov	es,[377Eh]
	mov	bx,[bp+0FF48h]
	mov	cx,bx
	shl	bx,2h
	add	bx,cx
	shl	bx,1h
	cmp	es:[bx+780h],ax
	jz	2974h

l1054_2971:
	jmp	2977h

l1054_2974:
	jmp	2986h

l1054_2977:
	jmp	2933h

l1054_297A:
	push	ds
	push	2B26h
	call	far 1054h:002Bh
	add	sp,4h

l1054_2986:
	mov	ax,[bp+0FF48h]
	mov	es,[379Eh]
	mov	bx,[bp-28h]
	mov	cx,bx
	shl	bx,1h
	add	bx,cx
	shl	bx,2h
	mov	es:[bx+32AEh],ax
	mov	ax,[bp+0FF48h]
	mov	bx,[bp-28h]
	mov	cx,bx
	shl	bx,1h
	add	bx,cx
	shl	bx,2h
	mov	es:[bx+32AAh],ax
	mov	ah,[bp+0FF32h]
	and	ax,0F000h
	mov	bx,[bp-28h]
	mov	cx,bx
	shl	bx,1h
	add	bx,cx
	shl	bx,2h
	add	es:[bx+32AAh],ax
	jmp	285Ah

l1054_29CF:
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	29DEh

l1054_29DB:
	jmp	2C37h

l1054_29DE:
	mov	word ptr [bp+0FF2Eh],0h
	jmp	29EBh

l1054_29E7:
	inc	word ptr [bp+0FF2Eh]

l1054_29EB:
	mov	ax,[bp-34h]
	cmp	[bp+0FF2Eh],ax
	jc	29F7h

l1054_29F4:
	jmp	2C37h

l1054_29F7:
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,es:[bx+223Ch]
	mov	[bp+0FF60h],ax
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,es:[bx+2240h]
	mov	[bp+0FF4Eh],ax
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,es:[bx+223Ah]
	mov	[bp+0FF50h],ax
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,es:[bx+223Eh]
	mov	[bp+0FF3Eh],ax
	imul	bx,[bp+0FF2Eh],14h
	mov	word ptr es:[bx+2242h],0h
	mov	word ptr [bp+0FF48h],0h
	jmp	2A4Ch

l1054_2A48:
	inc	word ptr [bp+0FF48h]

l1054_2A4C:
	mov	ax,[bp+0FF2Ah]
	cmp	[bp+0FF48h],ax
	jc	2A59h

l1054_2A56:
	jmp	2BF8h

l1054_2A59:
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	bx,es:[bx+32AEh]
	mov	es,[377Eh]
	mov	ax,bx
	shl	bx,2h
	add	bx,ax
	shl	bx,1h
	mov	ax,es:[bx+782h]
	mov	bx,[bp+0FF48h]
	mov	cx,bx
	shl	bx,1h
	add	bx,cx
	shl	bx,2h
	mov	es,[379Eh]
	add	ax,es:[bx+32A6h]
	dec	ax
	mov	[bp+0FF40h],ax
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	bx,es:[bx+32AEh]
	mov	es,[377Eh]
	mov	ax,bx
	shl	bx,2h
	add	bx,ax
	shl	bx,1h
	mov	ax,es:[bx+784h]
	mov	bx,[bp+0FF48h]
	mov	cx,bx
	shl	bx,1h
	add	bx,cx
	shl	bx,2h
	mov	es,[379Eh]
	add	ax,es:[bx+32A8h]
	dec	ax
	mov	[bp+0FF36h],ax
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,es:[bx+223Eh]
	mov	bx,[bp+0FF48h]
	mov	cx,bx
	shl	bx,1h
	add	bx,cx
	shl	bx,2h
	mov	es,[379Eh]
	cmp	es:[bx+32A8h],ax
	jnc	2B04h

l1054_2B01:
	jmp	2BF5h

l1054_2B04:
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,es:[bx+223Ah]
	mov	bx,[bp+0FF48h]
	mov	cx,bx
	shl	bx,1h
	add	bx,cx
	shl	bx,2h
	mov	es,[379Eh]
	cmp	es:[bx+32A6h],ax
	jnc	2B2Dh

l1054_2B2A:
	jmp	2BF5h

l1054_2B2D:
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,[bp+0FF36h]
	cmp	es:[bx+2240h],ax
	jnc	2B44h

l1054_2B41:
	jmp	2BF5h

l1054_2B44:
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,[bp+0FF40h]
	cmp	es:[bx+223Ch],ax
	jnc	2B57h

l1054_2B54:
	jmp	2BF5h

l1054_2B57:
	imul	bx,[bp+0FF2Eh],14h
	inc	word ptr es:[bx+2242h]
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	ax,[bp+0FF60h]
	cmp	es:[bx+32A6h],ax
	jc	2B80h

l1054_2B7D:
	jmp	2B96h

l1054_2B80:
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	ax,es:[bx+32A6h]
	mov	[bp+0FF60h],ax

l1054_2B96:
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	ax,[bp+0FF4Eh]
	cmp	es:[bx+32A8h],ax
	jc	2BB5h

l1054_2BB2:
	jmp	2BCBh

l1054_2BB5:
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	ax,es:[bx+32A8h]
	mov	[bp+0FF4Eh],ax

l1054_2BCB:
	mov	ax,[bp+0FF50h]
	cmp	[bp+0FF40h],ax
	ja	2BD8h

l1054_2BD5:
	jmp	2BE0h

l1054_2BD8:
	mov	ax,[bp+0FF40h]
	mov	[bp+0FF50h],ax

l1054_2BE0:
	mov	ax,[bp+0FF3Eh]
	cmp	[bp+0FF36h],ax
	ja	2BEDh

l1054_2BEA:
	jmp	2BF5h

l1054_2BED:
	mov	ax,[bp+0FF36h]
	mov	[bp+0FF3Eh],ax

l1054_2BF5:
	jmp	2A48h

l1054_2BF8:
	mov	ax,[bp+0FF60h]
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	mov	es:[bx+223Ah],ax
	mov	ax,[bp+0FF4Eh]
	imul	bx,[bp+0FF2Eh],14h
	mov	es:[bx+223Eh],ax
	mov	ax,[bp+0FF50h]
	imul	bx,[bp+0FF2Eh],14h
	mov	es:[bx+223Ch],ax
	mov	ax,[bp+0FF3Eh]
	imul	bx,[bp+0FF2Eh],14h
	mov	es:[bx+2240h],ax
	jmp	29E7h

l1054_2C37:
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	2C46h

l1054_2C43:
	jmp	34E4h

l1054_2C46:
	mov	word ptr [bp+0FF2Eh],0h
	jmp	2C53h

l1054_2C4F:
	inc	word ptr [bp+0FF2Eh]

l1054_2C53:
	mov	ax,[bp-34h]
	cmp	[bp+0FF2Eh],ax
	jc	2C5Fh

l1054_2C5C:
	jmp	3141h

l1054_2C5F:
	mov	es,[377Ch]
	cmp	byte ptr es:[2C70h],0h
	jnz	2C6Eh

l1054_2C6B:
	jmp	2C88h

l1054_2C6E:
	push	ds
	push	2B44h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,8h

l1054_2C88:
	imul	ax,[bp+0FF2Eh],14h
	add	ax,2230h
	push	381Dh
	push	ax
	push	word ptr [1F6Eh]
	push	ds
	push	2B46h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Eh
	mov	es,[377Ch]
	cmp	byte ptr es:[2C70h],0h
	jnz	2CC1h

l1054_2CBE:
	jmp	2CECh

l1054_2CC1:
	mov	es,[373Eh]
	push	word ptr es:[0D2A0h]
	push	word ptr es:[0D29Eh]
	push	ds
	push	2B50h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ch
	jmp	2D06h

l1054_2CEC:
	push	ds
	push	2B5Bh
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,8h

l1054_2D06:
	mov	word ptr [bp-32h],0h
	mov	es,[377Ch]
	cmp	byte ptr es:[2C70h],0h
	jnz	2D1Ah

l1054_2D17:
	jmp	2D68h

l1054_2D1A:
	mov	es,[37A2h]
	mov	ax,es:[0230h]
	add	ax,[bp+0FF2Eh]
	cmp	ax,1F4h
	jnc	2D2Eh

l1054_2D2B:
	jmp	2D3Dh

l1054_2D2E:
	push	1F4h
	push	ds
	push	2B5Dh
	call	far 1054h:002Bh
	add	sp,6h

l1054_2D3D:
	mov	es,[373Eh]
	mov	ax,es:[0D29Eh]
	mov	dx,es:[0D2A0h]
	mov	es,[37A2h]
	mov	bx,es:[0230h]
	add	bx,[bp+0FF2Eh]
	shl	bx,2h
	mov	es,[37A4h]
	mov	es:[bx+0C7CEh],ax
	mov	es:[bx+0C7D0h],dx

l1054_2D68:
	mov	word ptr [bp-0Ah],0h
	mov	word ptr [bp+0FF48h],0h
	jmp	2D7Ah

l1054_2D76:
	inc	word ptr [bp+0FF48h]

l1054_2D7A:
	mov	ax,[bp+0FF2Ah]
	cmp	[bp+0FF48h],ax
	jc	2D87h

l1054_2D84:
	jmp	30D8h

l1054_2D87:
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	bx,es:[bx+32AEh]
	mov	es,[377Eh]
	mov	ax,bx
	shl	bx,2h
	add	bx,ax
	shl	bx,1h
	mov	ax,es:[bx+782h]
	mov	bx,[bp+0FF48h]
	mov	cx,bx
	shl	bx,1h
	add	bx,cx
	shl	bx,2h
	mov	es,[379Eh]
	add	ax,es:[bx+32A6h]
	dec	ax
	mov	[bp+0FF40h],ax
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	bx,es:[bx+32AEh]
	mov	es,[377Eh]
	mov	ax,bx
	shl	bx,2h
	add	bx,ax
	shl	bx,1h
	mov	ax,es:[bx+784h]
	mov	bx,[bp+0FF48h]
	mov	cx,bx
	shl	bx,1h
	add	bx,cx
	shl	bx,2h
	mov	es,[379Eh]
	add	ax,es:[bx+32A8h]
	dec	ax
	mov	[bp+0FF36h],ax
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	cmp	word ptr es:[bx+32ACh],0h
	jz	2E21h

l1054_2E1E:
	jmp	30D5h

l1054_2E21:
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,es:[bx+223Ah]
	mov	bx,[bp+0FF48h]
	mov	cx,bx
	shl	bx,1h
	add	bx,cx
	shl	bx,2h
	mov	es,[379Eh]
	cmp	es:[bx+32A6h],ax
	jnc	2E4Ah

l1054_2E47:
	jmp	30D5h

l1054_2E4A:
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,es:[bx+223Eh]
	mov	bx,[bp+0FF48h]
	mov	cx,bx
	shl	bx,1h
	add	bx,cx
	shl	bx,2h
	mov	es,[379Eh]
	cmp	es:[bx+32A8h],ax
	jnc	2E73h

l1054_2E70:
	jmp	30D5h

l1054_2E73:
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,[bp+0FF40h]
	cmp	es:[bx+223Ch],ax
	jnc	2E8Ah

l1054_2E87:
	jmp	30D5h

l1054_2E8A:
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,[bp+0FF36h]
	cmp	es:[bx+2240h],ax
	jnc	2E9Dh

l1054_2E9A:
	jmp	30D5h

l1054_2E9D:
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	word ptr es:[bx+32ACh],1h
	inc	word ptr [bp-0Ah]
	mov	es,[377Ch]
	cmp	byte ptr es:[2C70h],0h
	jnz	2EC7h

l1054_2EC4:
	jmp	2F6Ch

l1054_2EC7:
	push	10h
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	ax,es:[bx+32A4h]
	or	ax,40h
	push	ax
	call	far 0800h:7AF7h
	add	sp,4h
	push	10h
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	ax,es:[bx+32A6h]
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	sub	ax,es:[bx+223Ah]
	push	ax
	call	far 0800h:7AF7h
	add	sp,4h
	push	10h
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	ax,es:[bx+32A8h]
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	sub	ax,es:[bx+223Eh]
	push	ax
	call	far 0800h:7AF7h
	add	sp,4h
	push	10h
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	push	word ptr es:[bx+32AAh]
	call	far 0800h:7AF7h
	add	sp,4h
	jmp	30D5h

l1054_2F6C:
	cmp	word ptr [bp-32h],0h
	jz	2F75h

l1054_2F72:
	jmp	3045h

l1054_2F75:
	mov	word ptr [bp-32h],1h
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	ax,es:[bx+32A4h]
	or	ax,40h
	push	ax
	push	ds
	push	2B84h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ah
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	ax,es:[bx+32A8h]
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	sub	ax,es:[bx+223Eh]
	push	ax
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	es,[379Eh]
	mov	ax,es:[bx+32A6h]
	imul	bx,[bp+0FF2Eh],14h
	mov	es,[37A0h]
	sub	ax,es:[bx+223Ah]
	push	ax
	push	ds
	push	2B98h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ch
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	push	word ptr es:[bx+32AAh]
	push	ds
	push	2BABh
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	30D5h

l1054_3045:
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	push	word ptr es:[bx+32AAh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	ax,es:[bx+32A8h]
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	sub	ax,es:[bx+223Eh]
	push	ax
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	es,[379Eh]
	mov	ax,es:[bx+32A6h]
	imul	bx,[bp+0FF2Eh],14h
	mov	es,[37A0h]
	sub	ax,es:[bx+223Ah]
	push	ax
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	es,[379Eh]
	mov	ax,es:[bx+32A4h]
	or	ax,40h
	push	ax
	push	ds
	push	2BCBh
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,10h

l1054_30D5:
	jmp	2D76h

l1054_30D8:
	mov	es,[377Ch]
	cmp	byte ptr es:[2C70h],0h
	jnz	30E7h

l1054_30E4:
	jmp	3113h

l1054_30E7:
	push	10h
	push	0FFh
	call	far 0800h:7AF7h
	add	sp,4h
	push	word ptr [bp-0Ah]
	push	ds
	push	2BE3h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	312Dh

l1054_3113:
	push	ds
	push	2BF5h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,8h

l1054_312D:
	mov	ax,[bp-0Ah]
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	mov	es:[bx+2242h],ax
	jmp	2C4Fh

l1054_3141:
	mov	word ptr [bp-32h],0h
	mov	word ptr [bp+0FF48h],0h
	jmp	3153h

l1054_314F:
	inc	word ptr [bp+0FF48h]

l1054_3153:
	mov	ax,[bp+0FF2Ah]
	cmp	[bp+0FF48h],ax
	jc	3160h

l1054_315D:
	jmp	32BFh

l1054_3160:
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	cmp	word ptr es:[bx+32ACh],0h
	jz	317Ch

l1054_3179:
	jmp	32BCh

l1054_317C:
	cmp	word ptr [bp-32h],0h
	jz	3185h

l1054_3182:
	jmp	3252h

l1054_3185:
	mov	word ptr [bp-32h],1h
	lea	ax,[bp-1Eh]
	push	ss
	push	ax
	push	ds
	push	2C10h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ch
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	ax,es:[bx+32A4h]
	or	ax,40h
	push	ax
	push	ds
	push	2C34h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ah
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	push	word ptr es:[bx+32A8h]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	push	word ptr es:[bx+32A6h]
	push	ds
	push	2C49h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ch
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	push	word ptr es:[bx+32AAh]
	push	ds
	push	2C5Dh
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ah
	jmp	32BCh

l1054_3252:
	mov	es,[379Eh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	push	word ptr es:[bx+32AAh]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	push	word ptr es:[bx+32A8h]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	push	word ptr es:[bx+32A6h]
	mov	bx,[bp+0FF48h]
	mov	ax,bx
	shl	bx,1h
	add	bx,ax
	shl	bx,2h
	mov	ax,es:[bx+32A4h]
	or	ax,40h
	push	ax
	push	ds
	push	2C7Eh
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,10h

l1054_32BC:
	jmp	314Fh

l1054_32BF:
	cmp	word ptr [bp-32h],0h
	jnz	32C8h

l1054_32C5:
	jmp	32E2h

l1054_32C8:
	push	ds
	push	2C97h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,8h

l1054_32E2:
	mov	es,[3740h]
	cmp	byte ptr es:[0A7F4h],0h
	jnz	32F1h

l1054_32EE:
	jmp	34E4h

l1054_32F1:
	mov	word ptr [bp+0FF2Eh],0h
	jmp	32FEh

l1054_32FA:
	inc	word ptr [bp+0FF2Eh]

l1054_32FE:
	mov	ax,[bp-34h]
	cmp	[bp+0FF2Eh],ax
	jc	330Ah

l1054_3307:
	jmp	34E4h

l1054_330A:
	imul	ax,[bp+0FF2Eh],14h
	add	ax,2230h
	push	381Dh
	push	ax
	push	word ptr [1F6Eh]
	push	ds
	push	2CB3h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Eh
	imul	ax,[bp+0FF2Eh],14h
	add	ax,2230h
	push	381Dh
	push	ax
	push	word ptr [1F6Eh]
	push	ds
	push	2CBEh
	mov	es,[375Ah]
	push	word ptr es:[0FDD2h]
	push	word ptr es:[0FDD0h]
	call	far 149Ah:0752h
	add	sp,0Eh
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,es:[bx+223Ch]
	imul	bx,[bp+0FF2Eh],14h
	sub	ax,es:[bx+223Ah]
	inc	ax
	push	ax
	imul	ax,[bp+0FF2Eh],14h
	add	ax,2230h
	push	es
	push	ax
	push	ds
	push	2CD0h
	mov	es,[37A6h]
	push	word ptr es:[0FDD6h]
	push	word ptr es:[0FDD4h]
	call	far 149Ah:0752h
	add	sp,0Eh
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,es:[bx+2240h]
	imul	bx,[bp+0FF2Eh],14h
	sub	ax,es:[bx+223Eh]
	inc	ax
	push	ax
	imul	ax,[bp+0FF2Eh],14h
	add	ax,2230h
	push	es
	push	ax
	push	ds
	push	2CDDh
	mov	es,[37A6h]
	push	word ptr es:[0FDD6h]
	push	word ptr es:[0FDD4h]
	call	far 149Ah:0752h
	add	sp,0Eh
	mov	es,[37A0h]
	imul	bx,[bp+0FF2Eh],14h
	push	word ptr es:[bx+2242h]
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,es:[bx+2240h]
	imul	bx,[bp+0FF2Eh],14h
	sub	ax,es:[bx+223Eh]
	inc	ax
	push	ax
	imul	bx,[bp+0FF2Eh],14h
	mov	ax,es:[bx+223Ch]
	imul	bx,[bp+0FF2Eh],14h
	sub	ax,es:[bx+223Ah]
	inc	ax
	push	ax
	push	ds
	push	2CEAh
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Eh
	mov	es,[377Ch]
	cmp	byte ptr es:[2C70h],0h
	jnz	343Dh

l1054_343A:
	jmp	3499h

l1054_343D:
	mov	es,[3796h]
	push	word ptr es:[5B70h]
	mov	es,[37A2h]
	mov	ax,es:[0230h]
	add	ax,[bp+0FF2Eh]
	push	ax
	push	ds
	push	2D14h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ch
	lea	ax,[bp-1Eh]
	push	ss
	push	ax
	call	far 1054h:000Eh
	add	sp,4h
	push	dx
	push	ax
	push	ds
	push	2D3Ah
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,0Ch
	jmp	34E1h

l1054_3499:
	lea	ax,[bp-1Eh]
	push	ss
	push	ax
	call	far 1054h:000Eh
	add	sp,4h
	push	dx
	push	ax
	lea	ax,[bp-1Eh]
	push	ss
	push	ax
	call	far 1054h:000Eh
	add	sp,4h
	push	dx
	push	ax
	imul	ax,[bp+0FF2Eh],14h
	add	ax,2230h
	push	381Dh
	push	ax
	push	word ptr [1F6Eh]
	push	ds
	push	2D49h
	mov	es,[3778h]
	push	word ptr es:[0C768h]
	push	word ptr es:[0C766h]
	call	far 149Ah:0752h
	add	sp,16h

l1054_34E1:
	jmp	32FAh

l1054_34E4:
	mov	es,[3796h]
	inc	word ptr es:[5B70h]
	mov	ax,[bp-34h]
	mov	es,[37A2h]
	add	es:[0230h],ax
	push	word ptr [bp+0FF5Ch]
	push	word ptr [bp+0FF5Ah]
	call	far 149Ah:063Ch
	add	sp,4h
	inc	ax
	jz	350Fh

l1054_350C:
	jmp	351Bh

l1054_350F:
	push	ds
	push	2D6Ah
	call	far 1054h:002Bh
	add	sp,4h

l1054_351B:
	push	word ptr [bp+0FF46h]
	push	word ptr [bp+0FF44h]
	call	far 149Ah:063Ch
	add	sp,4h
	inc	ax
	jz	3531h

l1054_352E:
	jmp	353Dh

l1054_3531:
	push	ds
	push	2D7Fh
	call	far 1054h:002Bh
	add	sp,4h

l1054_353D:
	pop	si
	pop	di
	leave
	retf

;; fn1054_3541: 1054:3541
;;   Called from:
;;     0800:08CA (in fn0800_084A)
;;     0800:752E (in fn0800_7505)
;;     1054:2504 (in fn1054_1A49)
fn1054_3541 proc
	push	bp
	mov	bp,sp
	mov	ax,2h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	word ptr [bp-2h],0h
	jmp	3559h

l1054_3556:
	inc	word ptr [bp-2h]

l1054_3559:
	mov	ax,[bp-2h]
	cmp	[1F6Ah],ax
	jg	3565h

l1054_3562:
	jmp	3597h

l1054_3565:
	mov	ax,[bp-2h]
	mov	cx,ax
	shl	ax,2h
	add	ax,cx
	shl	ax,1h
	add	ax,1768h
	push	180Ah
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jz	358Eh

l1054_358B:
	jmp	3594h

l1054_358E:
	mov	ax,[bp-2h]
	jmp	359Dh

l1054_3594:
	jmp	3556h

l1054_3597:
	mov	ax,0FFFFh
	jmp	359Dh

l1054_359D:
	pop	si
	pop	di
	leave
	retf

;; fn1054_35A1: 1054:35A1
;;   Called from:
;;     1054:2549 (in fn1054_1A49)
;;     1054:2568 (in fn1054_1A49)
fn1054_35A1 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	cmp	word ptr [1F6Ah],200h
	jge	35B9h

l1054_35B6:
	jmp	35CCh

l1054_35B9:
	push	200h
	push	word ptr [1F6Ah]
	push	ds
	push	2D97h
	call	far 1054h:002Bh
	add	sp,8h

l1054_35CC:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	mov	ax,[1F6Ah]
	mov	cx,ax
	shl	ax,2h
	add	ax,cx
	shl	ax,1h
	add	ax,1768h
	push	180Ah
	push	ax
	call	far 149Ah:25AEh
	add	sp,8h
	inc	word ptr [1F6Ah]
	mov	ax,[1F6Ah]
	dec	ax
	jmp	35F8h

l1054_35F8:
	pop	si
	pop	di
	leave
	retf

;; fn1054_35FC: 1054:35FC
;;   Called from:
;;     0800:5ED0 (in fn0800_550A)
;;     1054:1EB1 (in fn1054_1A49)
fn1054_35FC proc
	push	bp
	mov	bp,sp
	mov	ax,0Ah
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	word ptr [bp-2h],0h
	sub	ax,ax
	mov	[bp-6h],ax
	mov	[bp-8h],ax

l1054_3616:
	sub	word ptr [bp+0Ah],1h
	sbb	word ptr [bp+0Ch],0h
	mov	ax,[bp+0Ch]
	or	ax,[bp+0Ah]
	jnz	3629h

l1054_3626:
	jmp	3670h

l1054_3629:
	les	bx,[bp+6h]
	add	word ptr [bp+6h],2h
	mov	si,es:[bx]
	sub	ax,ax
	add	[bp-8h],si
	adc	[bp-6h],ax
	mov	ax,si
	sub	ah,ah
	mov	[bp-4h],ax
	mov	ax,si
	mov	al,ah
	sub	ah,ah
	mov	[bp-0Ah],ax
	mov	ax,[bp-2h]
	cmp	[bp-4h],ax
	jg	3656h

l1054_3653:
	jmp	365Ch

l1054_3656:
	mov	ax,[bp-4h]
	mov	[bp-2h],ax

l1054_365C:
	mov	ax,[bp-0Ah]
	cmp	[bp-2h],ax
	jl	3667h

l1054_3664:
	jmp	366Dh

l1054_3667:
	mov	ax,[bp-0Ah]
	mov	[bp-2h],ax

l1054_366D:
	jmp	3616h

l1054_3670:
	mov	ax,[bp+10h]
	or	ax,[bp+0Eh]
	jnz	367Bh

l1054_3678:
	jmp	3684h

l1054_367B:
	mov	ax,[bp-2h]
	les	bx,[bp+0Eh]
	mov	es:[bx],ax

l1054_3684:
	mov	ax,[bp-8h]
	mov	dx,[bp-6h]
	jmp	368Dh

l1054_368D:
	pop	si
	pop	di
	leave
	retf

;; fn1054_3691: 1054:3691
;;   Called from:
;;     1054:3806 (in fn1054_37DD)
;;     1054:383D (in fn1054_37DD)
;;     1054:3975 (in fn1054_38F9)
fn1054_3691 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[37A8h]
	mov	ax,[bp+6h]
	cmp	es:[0D274h],ax
	jnz	36AFh

l1054_36AC:
	jmp	371Dh

l1054_36AF:
	mov	es,[37AAh]
	mov	bx,[bp+6h]
	shl	bx,1h
	push	word ptr es:[bx+634h]
	push	0h
	call	far 1463h:004Eh
	add	sp,4h
	mov	es,[37AAh]
	mov	bx,[bp+6h]
	shl	bx,1h
	push	word ptr es:[bx+634h]
	push	101h
	call	far 1463h:004Eh
	add	sp,4h
	mov	es,[37AAh]
	mov	bx,[bp+6h]
	shl	bx,1h
	push	word ptr es:[bx+634h]
	push	202h
	call	far 1463h:004Eh
	add	sp,4h
	mov	es,[37AAh]
	mov	bx,[bp+6h]
	shl	bx,1h
	push	word ptr es:[bx+634h]
	push	303h
	call	far 1463h:004Eh
	add	sp,4h
	mov	ax,[bp+6h]
	mov	es,[37A8h]
	mov	es:[0D274h],ax

l1054_371D:
	pop	si
	pop	di
	leave
	retf

;; fn1054_3721: 1054:3721
;;   Called from:
;;     0800:1851 (in main)
fn1054_3721 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	call	far 1463h:0028h
	mov	si,ax
	cmp	si,4h
	jge	373Dh

l1054_373A:
	jmp	37C3h

l1054_373D:
	mov	es,[37ACh]
	mov	word ptr es:[2A00h],0h
	mov	es,[37AEh]
	mov	word ptr es:[0218h],0h
	mov	es,[37A8h]
	mov	word ptr es:[0D274h],0FFFFh
	mov	ax,si
	sar	ax,2h
	mov	es,[37B0h]
	mov	es:[2D78h],ax
	call	far 1463h:006Bh
	mov	es,[37B2h]
	mov	es:[2BE8h],ax
	mov	si,0h
	jmp	377Fh

l1054_377E:
	inc	si

l1054_377F:
	cmp	si,4h
	jl	3787h

l1054_3784:
	jmp	37B5h

l1054_3787:
	mov	es,[37B0h]
	cmp	es:[2D78h],si
	jle	3795h

l1054_3792:
	jmp	379Bh

l1054_3795:
	mov	ax,0FFFFh
	jmp	37A5h

l1054_379B:
	push	4h
	call	far 1463h:0037h
	add	sp,2h

l1054_37A5:
	mov	es,[37AAh]
	mov	bx,si
	shl	bx,1h
	mov	es:[bx+634h],ax
	jmp	377Eh

l1054_37B5:
	mov	es,[37B4h]
	mov	word ptr es:[2D76h],0h
	jmp	37D9h

l1054_37C3:
	push	ds
	push	2DBDh
	call	far 149Ah:0ABCh
	add	sp,4h
	push	3h
	call	far 0800h:02C7h
	add	sp,2h

l1054_37D9:
	pop	si
	pop	di
	leave
	retf

;; fn1054_37DD: 1054:37DD
;;   Called from:
;;     0800:5EFB (in fn0800_550A)
;;     1054:2067 (in fn1054_1A49)
fn1054_37DD proc
	push	bp
	mov	bp,sp
	mov	ax,0Ah
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	word ptr [bp-0Ah],0FFFFh
	mov	word ptr [bp-8h],0FFFFh
	mov	es,[37B2h]
	mov	ax,es:[2BE8h]
	mov	[bp-4h],ax
	mov	word ptr [bp-2h],0h
	push	0h
	call	far 1054h:3691h
	add	sp,2h
	mov	es,[37B4h]
	mov	si,es:[2D76h]

l1054_3817:
	dec	si
	cmp	si,0h
	jge	3820h

l1054_381D:
	jmp	38DCh

l1054_3820:
	mov	ax,[bp-2h]
	mov	[bp-6h],ax
	add	word ptr [bp-2h],0Eh
	cmp	word ptr [bp-2h],0Eh
	jc	3833h

l1054_3830:
	jmp	384Fh

l1054_3833:
	mov	es,[37A8h]
	mov	ax,es:[0D274h]
	inc	ax
	push	ax
	call	far 1054h:3691h
	add	sp,2h
	mov	word ptr [bp-2h],0Eh
	mov	word ptr [bp-6h],0h

l1054_384F:
	les	bx,[bp-6h]
	mov	ax,[bp+6h]
	cmp	es:[bx],ax
	jz	385Dh

l1054_385A:
	jmp	38D9h

l1054_385D:
	les	bx,[bp-6h]
	mov	ax,[bp+8h]
	cmp	es:[bx+2h],ax
	jz	386Ch

l1054_3869:
	jmp	38D9h

l1054_386C:
	les	bx,[bp-6h]
	mov	ax,[bp+0Eh]
	cmp	es:[bx+4h],ax
	jz	387Bh

l1054_3878:
	jmp	38D9h

l1054_387B:
	mov	ax,[bp+0Ah]
	mov	dx,[bp+0Ch]
	les	bx,[bp-6h]
	cmp	es:[bx+6h],ax
	jz	388Dh

l1054_388A:
	jmp	38D9h

l1054_388D:
	cmp	es:[bx+8h],dx
	jz	3896h

l1054_3893:
	jmp	38D9h

l1054_3896:
	mov	es,[3772h]
	cmp	byte ptr es:[54D8h],3h
	jg	38A5h

l1054_38A2:
	jmp	38C5h

l1054_38A5:
	les	bx,[bp-6h]
	push	word ptr es:[bx+0Ch]
	push	word ptr es:[bx+0Ah]
	push	word ptr [bp+0Eh]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	2DEDh
	call	far 149Ah:0ABCh
	add	sp,0Eh

l1054_38C5:
	les	bx,[bp-6h]
	mov	ax,es:[bx+0Ah]
	mov	dx,es:[bx+0Ch]
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	jmp	38DCh

l1054_38D9:
	jmp	3817h

l1054_38DC:
	mov	es,[37A8h]
	mov	word ptr es:[0D274h],0FFFFh
	call	far 0800h:0040h
	mov	ax,[bp-0Ah]
	mov	dx,[bp-8h]
	jmp	38F5h

l1054_38F5:
	pop	si
	pop	di
	leave
	retf

;; fn1054_38F9: 1054:38F9
;;   Called from:
;;     0800:5FF9 (in fn0800_550A)
;;     1054:211E (in fn1054_1A49)
fn1054_38F9 proc
	push	bp
	mov	bp,sp
	mov	ax,4h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	es,[37B2h]
	mov	ax,es:[2BE8h]
	mov	[bp-2h],ax
	mov	es,[37ACh]
	mov	ax,es:[2A00h]
	mov	[bp-4h],ax
	add	word ptr es:[2A00h],0Eh
	cmp	word ptr es:[2A00h],0Eh
	jc	392Dh

l1054_392A:
	jmp	396Ch

l1054_392D:
	mov	es,[37AEh]
	inc	word ptr es:[0218h]
	mov	ax,es
	mov	es,[37B0h]
	mov	cx,es:[2D78h]
	mov	es,ax
	cmp	es:[0218h],cx
	jge	394Dh

l1054_394A:
	jmp	395Ch

l1054_394D:
	push	ds
	push	2E1Eh
	call	far 1054h:002Bh
	add	sp,4h
	jmp	396Ch

l1054_395C:
	mov	es,[37ACh]
	mov	word ptr es:[2A00h],0Eh
	mov	word ptr [bp-4h],0h

l1054_396C:
	mov	es,[37AEh]
	push	word ptr es:[0218h]
	call	far 1054h:3691h
	add	sp,2h
	mov	ax,[bp+6h]
	les	bx,[bp-4h]
	mov	es:[bx],ax
	mov	ax,[bp+8h]
	les	bx,[bp-4h]
	mov	es:[bx+2h],ax
	mov	ax,[bp+12h]
	les	bx,[bp-4h]
	mov	es:[bx+4h],ax
	mov	ax,[bp+0Ah]
	mov	dx,[bp+0Ch]
	les	bx,[bp-4h]
	mov	es:[bx+6h],ax
	mov	es:[bx+8h],dx
	mov	ax,[bp+0Eh]
	mov	dx,[bp+10h]
	les	bx,[bp-4h]
	mov	es:[bx+0Ah],ax
	mov	es:[bx+0Ch],dx
	mov	es,[37B4h]
	inc	word ptr es:[2D76h]
	mov	es,[37A8h]
	mov	word ptr es:[0D274h],0FFFFh
	call	far 0800h:0040h
	pop	si
	pop	di
	leave
	retf

;; fn1054_39D9: 1054:39D9
;;   Called from:
;;     0800:02D4 (in fn0800_02C7)
fn1054_39D9 proc
	push	bp
	mov	bp,sp
	mov	ax,0h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	si,0h
	jmp	39EDh

l1054_39EC:
	inc	si

l1054_39ED:
	cmp	si,4h
	jl	39F5h

l1054_39F2:
	jmp	3A0Dh

l1054_39F5:
	mov	es,[37AAh]
	mov	bx,si
	shl	bx,1h
	push	word ptr es:[bx+634h]
	call	far 1463h:007Ch
	add	sp,2h
	jmp	39ECh

l1054_3A0D:
	pop	si
	pop	di
	leave
	retf

;; fn1054_3A11: 1054:3A11
;;   Called from:
;;     0800:37FD (in main)
;;     1054:1277 (in fn1054_0DB3)
fn1054_3A11 proc
	push	bp
	mov	bp,sp
	mov	ax,56h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	word ptr [bp-48h],0h
	push	0h
	push	180Ah
	push	63Eh
	call	far 149Ah:34E6h
	add	sp,6h
	cmp	ax,0h
	jz	3A3Bh

l1054_3A38:
	jmp	3BE4h

l1054_3A3B:
	push	8000h
	push	180Ah
	push	63Eh
	call	far 149Ah:1E7Eh
	add	sp,6h
	mov	[bp-4Ch],ax
	cmp	ax,0h
	jle	3A57h

l1054_3A54:
	jmp	3A6Dh

l1054_3A57:
	push	ds
	push	2E39h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	7h
	call	far 0800h:02C7h
	add	sp,2h

l1054_3A6D:
	mov	es,[37B6h]
	cmp	word ptr es:[5CA2h],0h
	jnz	3A7Ch

l1054_3A79:
	jmp	3A91h

l1054_3A7C:
	push	word ptr [bp-4Ch]
	push	180Ah
	push	63Eh
	push	ds
	push	2E77h
	call	far 149Ah:0ABCh
	add	sp,0Ah

l1054_3A91:
	push	44h
	lea	ax,[bp-44h]
	push	ss
	push	ax
	push	word ptr [bp-4Ch]
	call	far 149Ah:2030h
	add	sp,8h
	cmp	ax,44h
	jz	3AABh

l1054_3AA8:
	jmp	3BB5h

l1054_3AAB:
	mov	ax,[bp-4h]
	mov	[bp-56h],ax
	mov	ax,[bp-2h]
	mov	[bp-4Ah],ax
	push	word ptr [bp-4Ch]
	call	far 149Ah:28C2h
	add	sp,2h
	mov	es,[37B8h]
	mov	es:[54ECh],ax
	mov	es:[54EEh],dx
	mov	ax,[bp-56h]
	inc	ax
	sar	ax,1h
	push	ax
	push	381Dh
	push	2C74h
	push	word ptr [bp-4Ch]
	call	far 149Ah:2030h
	add	sp,8h
	mov	ax,[bp-4Ah]
	inc	ax
	sar	ax,1h
	push	ax
	push	180Ah
	push	6D2h
	push	word ptr [bp-4Ch]
	call	far 149Ah:2030h
	add	sp,8h
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	mov	[bp-50h],ax
	mov	[bp-4Eh],dx
	jmp	3B11h

l1054_3B0E:
	inc	word ptr [bp-50h]

l1054_3B11:
	les	bx,[bp-50h]
	cmp	byte ptr es:[bx],0h
	jnz	3B1Dh

l1054_3B1A:
	jmp	3B36h

l1054_3B1D:
	les	bx,[bp-50h]
	mov	al,es:[bx]
	cbw
	push	ax
	call	far 149Ah:268Ah
	add	sp,2h
	les	bx,[bp-50h]
	mov	es:[bx],al
	jmp	3B0Eh

l1054_3B36:
	lea	ax,[bp-44h]
	push	ss
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:25E4h
	add	sp,8h
	cmp	ax,0h
	jnz	3B51h

l1054_3B4E:
	jmp	3B54h

l1054_3B51:
	jmp	3A91h

l1054_3B54:
	mov	es,[374Ch]
	mov	ax,[bp-56h]
	cmp	es:[0FF1Eh],ax
	jnz	3B65h

l1054_3B62:
	jmp	3B7Fh

l1054_3B65:
	push	word ptr es:[0FF1Eh]
	push	word ptr [bp-56h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	2EABh
	call	far 149Ah:0ABCh
	add	sp,0Ch

l1054_3B7F:
	mov	es,[374Ch]
	mov	ax,[bp-4Ah]
	cmp	es:[0FF28h],ax
	jnz	3B90h

l1054_3B8D:
	jmp	3BAAh

l1054_3B90:
	push	word ptr es:[0FF28h]
	push	word ptr [bp-4Ah]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	ds
	push	2EEAh
	call	far 149Ah:0ABCh
	add	sp,0Ch

l1054_3BAA:
	mov	word ptr [bp-48h],1h
	jmp	3BB5h
1054:3BB2       E9 DC FE                                    ...           

l1054_3BB5:
	push	word ptr [bp-4Ch]
	call	far 149Ah:1DCAh
	add	sp,2h
	mov	es,[37B6h]
	cmp	word ptr es:[5CA2h],0h
	jnz	3BCFh

l1054_3BCC:
	jmp	3BE4h

l1054_3BCF:
	push	word ptr [bp-4Ch]
	push	180Ah
	push	63Eh
	push	ds
	push	2F29h
	call	far 149Ah:0ABCh
	add	sp,0Ah

l1054_3BE4:
	cmp	word ptr [bp-48h],0h
	jz	3BEDh

l1054_3BEA:
	jmp	3C53h

l1054_3BED:
	mov	es,[37B8h]
	mov	word ptr es:[54ECh],0FFFFh
	mov	word ptr es:[54EEh],0FFFFh
	mov	word ptr [bp-54h],2C74h
	mov	word ptr [bp-52h],381Dh
	mov	word ptr [bp-46h],7Dh

l1054_3C0E:
	dec	word ptr [bp-46h]
	cmp	word ptr [bp-46h],0h
	jge	3C1Ah

l1054_3C17:
	jmp	3C29h

l1054_3C1A:
	les	bx,[bp-54h]
	add	word ptr [bp-54h],2h
	mov	word ptr es:[bx],0h
	jmp	3C0Eh

l1054_3C29:
	mov	word ptr [bp-54h],6D2h
	mov	word ptr [bp-52h],180Ah
	mov	word ptr [bp-46h],20h

l1054_3C38:
	dec	word ptr [bp-46h]
	cmp	word ptr [bp-46h],0h
	jge	3C44h

l1054_3C41:
	jmp	3C53h

l1054_3C44:
	les	bx,[bp-54h]
	add	word ptr [bp-54h],2h
	mov	word ptr es:[bx],0h
	jmp	3C38h

l1054_3C53:
	pop	si
	pop	di
	leave
	retf

;; fn1054_3C57: 1054:3C57
;;   Called from:
;;     0800:0346 (in fn0800_02FE)
fn1054_3C57 proc
	push	bp
	mov	bp,sp
	mov	ax,4h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	di,0h
	push	0h
	push	180Ah
	push	63Eh
	call	far 149Ah:34E6h
	add	sp,6h
	cmp	ax,0h
	jl	3C7Fh

l1054_3C7C:
	jmp	3CDBh

l1054_3C7F:
	push	80h
	push	8302h
	push	180Ah
	push	63Eh
	call	far 149Ah:1E7Eh
	add	sp,8h
	mov	si,ax
	cmp	si,0h
	jle	3C9Dh

l1054_3C9A:
	jmp	3CB3h

l1054_3C9D:
	push	ds
	push	2F54h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	7h
	call	far 0800h:02C7h
	add	sp,2h

l1054_3CB3:
	mov	es,[37B6h]
	cmp	word ptr es:[5CA2h],0h
	jnz	3CC2h

l1054_3CBF:
	jmp	3CD5h

l1054_3CC2:
	push	si
	push	180Ah
	push	63Eh
	push	ds
	push	2F8Ah
	call	far 149Ah:0ABCh
	add	sp,0Ah

l1054_3CD5:
	mov	di,1h
	jmp	3D76h

l1054_3CDB:
	push	8002h
	push	180Ah
	push	63Eh
	call	far 149Ah:1E7Eh
	add	sp,6h
	mov	si,ax
	cmp	si,0h
	jle	3CF6h

l1054_3CF3:
	jmp	3D0Ch

l1054_3CF6:
	push	ds
	push	2FB6h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	7h
	call	far 0800h:02C7h
	add	sp,2h

l1054_3D0C:
	mov	es,[37B6h]
	cmp	word ptr es:[5CA2h],0h
	jnz	3D1Bh

l1054_3D18:
	jmp	3D2Eh

l1054_3D1B:
	push	si
	push	180Ah
	push	63Eh
	push	ds
	push	2FF6h
	call	far 149Ah:0ABCh
	add	sp,0Ah

l1054_3D2E:
	mov	es,[37B8h]
	cmp	word ptr es:[54ECh],0FFh
	jz	3D3Dh

l1054_3D3A:
	jmp	3D5Dh

l1054_3D3D:
	cmp	word ptr es:[54EEh],0FFh
	jz	3D48h

l1054_3D45:
	jmp	3D5Dh

l1054_3D48:
	push	2h
	push	0h
	push	0h
	push	si
	call	far 149Ah:1DEAh
	add	sp,8h
	mov	di,1h
	jmp	3D76h

l1054_3D5D:
	push	0h
	mov	es,[37B8h]
	push	word ptr es:[54EEh]
	push	word ptr es:[54ECh]
	push	si
	call	far 149Ah:1DEAh
	add	sp,8h

l1054_3D76:
	cmp	di,0h
	jnz	3D7Eh

l1054_3D7B:
	jmp	3DE8h

l1054_3D7E:
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	jmp	3D90h

l1054_3D8D:
	inc	word ptr [bp-4h]

l1054_3D90:
	les	bx,[bp-4h]
	cmp	byte ptr es:[bx],0h
	jnz	3D9Ch

l1054_3D99:
	jmp	3DB5h

l1054_3D9C:
	les	bx,[bp-4h]
	mov	al,es:[bx]
	cbw
	push	ax
	call	far 149Ah:268Ah
	add	sp,2h
	les	bx,[bp-4h]
	mov	es:[bx],al
	jmp	3D8Dh

l1054_3DB5:
	push	40h
	push	180Ah
	push	0FEDAh
	push	si
	call	far 149Ah:212Eh
	add	sp,8h
	push	2h
	push	180Ah
	push	0FF1Eh
	push	si
	call	far 149Ah:212Eh
	add	sp,8h
	push	2h
	push	180Ah
	push	0FF28h
	push	si
	call	far 149Ah:212Eh
	add	sp,8h

l1054_3DE8:
	mov	es,[374Ch]
	mov	ax,es:[0FF1Eh]
	inc	ax
	sar	ax,1h
	push	ax
	push	381Dh
	push	2C74h
	push	si
	call	far 149Ah:212Eh
	add	sp,8h
	mov	es,[374Ch]
	mov	ax,es:[0FF28h]
	inc	ax
	sar	ax,1h
	push	ax
	push	180Ah
	push	6D2h
	push	si
	call	far 149Ah:212Eh
	add	sp,8h
	mov	es,[37B6h]
	cmp	word ptr es:[5CA2h],0h
	jnz	3E2Dh

l1054_3E2A:
	jmp	3E40h

l1054_3E2D:
	push	si
	push	180Ah
	push	63Eh
	push	ds
	push	302Ch
	call	far 149Ah:0ABCh
	add	sp,0Ah

l1054_3E40:
	push	si
	call	far 149Ah:1DCAh
	add	sp,2h
	pop	si
	pop	di
	leave
	retf

;; fn1054_3E4D: 1054:3E4D
;;   Called from:
;;     0800:611D (in fn0800_550A)
;;     1054:0559 (in fn1054_03DA)
;;     1054:0B89 (in fn1054_0792)
;;     1054:135D (in fn1054_0DB3)
;;     1054:149B (in fn1054_0DB3)
fn1054_3E4D proc
	push	bp
	mov	bp,sp
	mov	ax,2h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	bx,[bp+0Ah]
	sar	bx,1h
	les	si,[bp+6h]
	mov	al,es:[bx+si]
	mov	[bp-2h],al
	test	byte ptr [bp+0Ah],1h
	jnz	3E71h

l1054_3E6E:
	jmp	3E78h

l1054_3E71:
	sar	byte ptr [bp-2h],4h
	jmp	3E7Ch

l1054_3E78:
	and	byte ptr [bp-2h],0Fh

l1054_3E7C:
	mov	al,[bp-2h]
	cbw
	jmp	3E83h

l1054_3E83:
	pop	si
	pop	di
	leave
	retf

;; fn1054_3E87: 1054:3E87
;;   Called from:
;;     0800:616B (in fn0800_550A)
;;     0800:6204 (in fn0800_550A)
;;     0800:628F (in fn0800_550A)
;;     0800:62D2 (in fn0800_550A)
;;     1054:05C2 (in fn1054_03DA)
;;     1054:0620 (in fn1054_03DA)
;;     1054:066E (in fn1054_03DA)
;;     1054:0BBB (in fn1054_0792)
;;     1054:139C (in fn1054_0DB3)
;;     1054:1632 (in fn1054_0DB3)
fn1054_3E87 proc
	push	bp
	mov	bp,sp
	mov	ax,2h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	bx,[bp+0Ah]
	sar	bx,1h
	les	si,[bp+6h]
	mov	al,es:[bx+si]
	mov	[bp-2h],al
	test	byte ptr [bp+0Ah],1h
	jnz	3EABh

l1054_3EA8:
	jmp	3EBDh

l1054_3EAB:
	mov	al,[bp-2h]
	and	al,0Fh
	shl	byte ptr [bp+0Ch],4h
	or	al,[bp+0Ch]
	mov	[bp-2h],al
	jmp	3ECCh

l1054_3EBD:
	mov	al,[bp-2h]
	and	al,0F0h
	and	byte ptr [bp+0Ch],0Fh
	or	al,[bp+0Ch]
	mov	[bp-2h],al

l1054_3ECC:
	mov	bx,[bp+0Ah]
	sar	bx,1h
	les	si,[bp+6h]
	mov	al,[bp-2h]
	mov	es:[bx+si],al
	pop	si
	pop	di
	leave
	retf

;; fn1054_3EDE: 1054:3EDE
;;   Called from:
;;     0800:0338 (in fn0800_02FE)
;;     1054:4062 (in fn1054_3F70)
;;     1054:4073 (in fn1054_3F70)
fn1054_3EDE proc
	push	bp
	mov	bp,sp
	mov	ax,6h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	ax,[bp+0Ah]
	inc	ax
	sar	ax,1h
	mov	[bp-2h],ax

l1054_3EF4:
	dec	word ptr [bp-2h]
	cmp	word ptr [bp-2h],0h
	jge	3F00h

l1054_3EFD:
	jmp	3F6Ch

l1054_3F00:
	les	bx,[bp+6h]
	mov	al,es:[bx]
	mov	[bp-6h],al
	mov	[bp-4h],al
	and	byte ptr [bp-6h],0Fh
	cmp	byte ptr [bp-6h],4h
	jc	3F19h

l1054_3F16:
	jmp	3F33h

l1054_3F19:
	cmp	byte ptr [bp-6h],0h
	jnz	3F22h

l1054_3F1F:
	jmp	3F33h

l1054_3F22:
	shl	byte ptr [bp-6h],2h
	cmp	byte ptr [bp-6h],4h
	jz	3F2Fh

l1054_3F2C:
	jmp	3F33h

l1054_3F2F:
	mov	byte ptr [bp-6h],5h

l1054_3F33:
	and	byte ptr [bp-4h],0F0h
	cmp	byte ptr [bp-4h],40h
	jc	3F40h

l1054_3F3D:
	jmp	3F5Ah

l1054_3F40:
	cmp	byte ptr [bp-4h],0h
	jnz	3F49h

l1054_3F46:
	jmp	3F5Ah

l1054_3F49:
	shl	byte ptr [bp-4h],2h
	cmp	byte ptr [bp-4h],40h
	jz	3F56h

l1054_3F53:
	jmp	3F5Ah

l1054_3F56:
	mov	byte ptr [bp-4h],50h

l1054_3F5A:
	mov	al,[bp-6h]
	or	al,[bp-4h]
	les	bx,[bp+6h]
	inc	word ptr [bp+6h]
	mov	es:[bx],al
	jmp	3EF4h

l1054_3F6C:
	pop	si
	pop	di
	leave
	retf

;; fn1054_3F70: 1054:3F70
;;   Called from:
;;     0800:2EA9 (in main)
fn1054_3F70 proc
	push	bp
	mov	bp,sp
	mov	ax,4Ah
	call	far 149Ah:02C8h
	push	di
	push	si
	push	0h
	push	180Ah
	push	63Eh
	call	far 149Ah:34E6h
	add	sp,6h
	cmp	ax,0h
	jz	3F95h

l1054_3F92:
	jmp	40F8h

l1054_3F95:
	push	8002h
	push	180Ah
	push	63Eh
	call	far 149Ah:1E7Eh
	add	sp,6h
	mov	[bp-48h],ax
	cmp	ax,0h
	jle	3FB1h

l1054_3FAE:
	jmp	3FC7h

l1054_3FB1:
	push	ds
	push	3057h
	call	far 149Ah:0ABCh
	add	sp,4h
	push	7h
	call	far 0800h:02C7h
	add	sp,2h

l1054_3FC7:
	mov	es,[37B6h]
	cmp	word ptr es:[5CA2h],0h
	jnz	3FD6h

l1054_3FD3:
	jmp	3FEBh

l1054_3FD6:
	push	word ptr [bp-48h]
	push	180Ah
	push	63Eh
	push	ds
	push	3099h
	call	far 149Ah:0ABCh
	add	sp,0Ah

l1054_3FEB:
	push	44h
	lea	ax,[bp-44h]
	push	ss
	push	ax
	push	word ptr [bp-48h]
	call	far 149Ah:2030h
	add	sp,8h
	cmp	ax,44h
	jz	4005h

l1054_4002:
	jmp	40C9h

l1054_4005:
	mov	ax,[bp-4h]
	mov	[bp-4Ah],ax
	mov	ax,[bp-2h]
	mov	[bp-46h],ax
	push	word ptr [bp-48h]
	call	far 149Ah:28C2h
	add	sp,2h
	mov	es,[37B8h]
	mov	es:[54ECh],ax
	mov	es:[54EEh],dx
	mov	ax,[bp-4Ah]
	inc	ax
	sar	ax,1h
	push	ax
	push	381Dh
	push	2C74h
	push	word ptr [bp-48h]
	call	far 149Ah:2030h
	add	sp,8h
	mov	ax,[bp-46h]
	inc	ax
	sar	ax,1h
	push	ax
	push	180Ah
	push	6D2h
	push	word ptr [bp-48h]
	call	far 149Ah:2030h
	add	sp,8h
	push	word ptr [bp-4Ah]
	push	381Dh
	push	2C74h
	call	far 1054h:3EDEh
	add	sp,6h
	push	word ptr [bp-46h]
	push	180Ah
	push	6D2h
	call	far 1054h:3EDEh
	add	sp,6h
	push	0h
	mov	es,[37B8h]
	push	word ptr es:[54EEh]
	push	word ptr es:[54ECh]
	push	word ptr [bp-48h]
	call	far 149Ah:1DEAh
	add	sp,8h
	mov	ax,[bp-4Ah]
	inc	ax
	sar	ax,1h
	push	ax
	push	381Dh
	push	2C74h
	push	word ptr [bp-48h]
	call	far 149Ah:212Eh
	add	sp,8h
	mov	ax,[bp-46h]
	inc	ax
	sar	ax,1h
	push	ax
	push	180Ah
	push	6D2h
	push	word ptr [bp-48h]
	call	far 149Ah:212Eh
	add	sp,8h
	jmp	3FEBh

l1054_40C9:
	push	word ptr [bp-48h]
	call	far 149Ah:1DCAh
	add	sp,2h
	mov	es,[37B6h]
	cmp	word ptr es:[5CA2h],0h
	jnz	40E3h

l1054_40E0:
	jmp	40F8h

l1054_40E3:
	push	word ptr [bp-48h]
	push	180Ah
	push	63Eh
	push	ds
	push	30D1h
