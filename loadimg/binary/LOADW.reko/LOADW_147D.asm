;;; Segment 147D (147D:0000)

;; fn147D_0000: 147D:0000
;;   Called from:
;;     0800:1F85 (in main)
fn147D_0000 proc
	cmp	word ptr [38C0h],0h
	jz	0017h

l147D_0007:
	push	es
	push	di
	mov	es,[38C0h]
	mov	di,[3AC8h]
	mov	al,es:[di]
	pop	di
	pop	es
	retf

l147D_0017:
	mov	dx,[3AC8h]
	in	al,dx
	retf

;; fn147D_001D: 147D:001D
;;   Called from:
;;     0800:1F8F (in main)
;;     0800:3C4B (in main)
fn147D_001D proc
	enter	0h,0h
	mov	al,[bp+6h]
	cmp	word ptr [38C0h],0h
	jz	003Ch

l147D_002B:
	push	es
	push	di
	mov	es,[38C0h]
	mov	di,[3AC8h]
	mov	es:[di],al
	pop	di
	pop	es
	leave
	retf

l147D_003C:
	mov	dx,[3AC8h]
