;;; Segment 146C (146C:0000)
146C:0000 FF                                              .               

l1463_0091:
	leave
	retf
1463:0093          00                                        .            

;; fn146C_0004: 146C:0004
;;   Called from:
;;     0800:8445 (in fn0800_83C5)
fn146C_0004 proc
	enter	0h,0h
	push	si
	push	di
	cld
	les	di,[bp+0Ch]
	mov	bx,[bp+6h]
	xor	dx,dx
	xor	cx,cx
	push	ds
	lds	si,[bp+8h]
	push	bp
	xor	bp,bp
	mov	al,[si]
	call	0087h
	mov	al,[si+2h]
	call	0087h
	mov	al,[bx+si]
	call	0087h
	mov	al,[bx+si+2h]
	call	0087h
	mov	bx,bp
	pop	bp
	pop	ds
	mov	al,cl
	shr	dx,2h
	shr	cx,5h
	and	al,1Fh
	cmp	al,2h
	jz	0053h

l146C_0044:
	jg	004Ch

l146C_0046:
	xor	ax,ax
	pop	di
	pop	si
	leave
	retf

l146C_004C:
	cmp	al,4h
	jz	0059h

l146C_0050:
	jmp	0072h
146C:0052       90                                          .             

l146C_0053:
	shl	dx,1h
	shl	cx,1h
	shl	bx,1h

l146C_0059:
	shr	dx,2h
	shr	cx,2h
	shr	bx,2h

l146C_0062:
	and	cx,1Fh
	and	dx,1Fh
	and	bx,1Fh
	call	00AAh
	pop	di
	pop	si
	leave
	retf

l146C_0072:
	xchg	bx,ax
	div	bl
	mov	bh,al
	mov	ax,cx
	div	bl
	mov	cl,al
	mov	ax,dx
	div	bl
	mov	dl,al
	mov	bl,bh
	jmp	0062h

;; fn146C_0087: 146C:0087
;;   Called from:
;;     146C:001E (in fn146C_0004)
;;     146C:0024 (in fn146C_0004)
;;     146C:0029 (in fn146C_0004)
;;     146C:002F (in fn146C_0004)
fn146C_0087 proc
	push	bx
	mov	bl,al
	xor	bh,bh
	shl	bx,1h
	jz	00A8h

l146C_0090:
	inc	cl
	mov	ax,es:[bx+di]
	mov	bx,ax
	and	bx,7C1Fh
	and	ax,3E0h
	add	cx,ax
	xor	ax,ax
	xchg	bh,al
	add	dx,ax
	add	bp,bx

l146C_00A8:
	pop	bx
	ret

;; fn146C_00AA: 146C:00AA
;;   Called from:
;;     146C:006B (in fn146C_0004)
fn146C_00AA proc
	xor	si,si
	mov	[310Ah],bl
	mov	[3108h],dl
	mov	[3109h],cl
	mov	word ptr [3106h],1388h
	mov	cx,[bp+10h]
	dec	cx
	add	di,2h

l146C_00C5:
	mov	ax,es:[di]
	add	di,2h
	inc	si
	mov	bx,ax
	shr	bh,2h
	and	bx,1F1Fh
	sub	bl,[310Ah]
	sub	bh,[3108h]
	shr	ax,5h
	and	al,1Fh
	sub	al,[3109h]
	imul	al
	mov	dx,ax
	mov	al,bl
	imul	bl
	add	dx,ax
	mov	al,bh
	imul	bh
	add	dx,ax
	jz	010Ch

l146C_00F8:
	cmp	dx,[3106h]
	jg	0106h

l146C_00FE:
	mov	[310Bh],si
	mov	[3106h],dx

l146C_0106:
	loop	00C5h

l146C_0108:
	mov	ax,[310Bh]
	ret

l146C_010C:
	mov	ax,si
	ret
146C:010F                                              00                .
