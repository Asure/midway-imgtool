;;; Segment 1481 (1481:0000)
1481:0000 EE C9 CB                                        ...             
147D:0043          00                                        .            

;; fn1481_0004: 1481:0004
;;   Called from:
;;     0800:0D87 (in fn0800_0D60)
;;     0800:7F23 (in fn0800_7DD1)
;;     0800:8172 (in fn0800_8095)
fn1481_0004 proc
	enter	0h,0h
	mov	bx,[bp+6h]
	cmp	word ptr [38C0h],0h
	jz	002Dh

l1481_0012:
	push	es
	push	di
	mov	es,[38C0h]
	mov	di,[3AC6h]
	mov	es:[di],bx
	mov	di,[3AC4h]
	mov	dx,[bp+8h]
	mov	es:[di],dx
	pop	di
	pop	es
	leave
	retf

l1481_002D:
	mov	dx,[3AC6h]
