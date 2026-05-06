;;; Segment 1484 (1484:0000)
1484:0000 3A 8B C3 EF 8B 16 C4 3A 8B 46 08 EF C9 CB       :......:.F....  

;; fn1484_000E: 1484:000E
;;   Called from:
;;     0800:1884 (in main)
fn1484_000E proc
	push	bp
	mov	bp,sp
	mov	ax,6h
	call	far 149Ah:02C8h
	mov	word ptr [38C0h],0C000h
	mov	word ptr [3ACAh],7D00h
	mov	word ptr [3AC8h],7D01h
	mov	word ptr [3AC6h],7E00h
	mov	word ptr [3AC4h],7F00h
	mov	word ptr [38C2h],7000h
	mov	ax,[bp+8h]
	or	ax,[bp+6h]
	jz	00B4h

l1484_0045:
	lea	ax,[bp-4h]
	push	ss
	push	ax
	push	ds
	push	310Eh
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:2876h
	add	sp,0Ch
	or	ax,ax
	jz	00B4h

l1484_0060:
	mov	ax,[bp-2h]
	mov	[38C0h],ax
	or	ax,ax
	jnz	0096h

l1484_006A:
	mov	ax,[bp-4h]
	mov	[bp-6h],ax
	mov	[38C2h],ax
	add	ah,10h
	mov	[3ACAh],ax
	mov	ax,[bp-6h]
	add	ax,1001h
	mov	[3AC8h],ax
	mov	ax,[bp-6h]
	add	ah,20h
	mov	[3AC6h],ax
	mov	ax,[bp-6h]
	add	ah,30h
	mov	[3AC4h],ax
	jmp	00B4h

l1484_0096:
	mov	ax,[bp-4h]
	sub	ax,[38C2h]
	mov	[bp-6h],ax
	add	[38C2h],ax
	add	[3AC4h],ax
	add	[3AC6h],ax
	add	[3AC8h],ax
	add	[3ACAh],ax

l1484_00B4:
	cmp	word ptr [bp+0Ah],0h
	jz	00E5h

l1484_00BA:
	cmp	word ptr [38C0h],0h
	jz	00D8h

l1484_00C1:
	push	word ptr [38C2h]
	push	word ptr [38C0h]
	push	ds
	push	3112h
	call	far 149Ah:0ABCh
	add	sp,8h
	leave
	retf
1484:00D7                      90                                .        

l1484_00D8:
	push	word ptr [38C2h]
	push	ds
	push	313Dh
