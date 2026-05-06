;;; Segment 1492 (1492:0000)
1492:0000 9A BC 0A 9A 14                                  .....           

l1484_00E5:
	leave
	retf
1484:00E7                      90                                .        

;; fn1492_0008: 1492:0008
;;   Called from:
;;     0800:0D98 (in fn0800_0D60)
fn1492_0008 proc
	enter	0h,0h
	mov	ax,[bp+6h]
	cmp	word ptr [38C0h],0h
	jz	0027h

l1492_0016:
	push	es
	push	di
	mov	es,[38C0h]
	mov	di,[38C2h]
	mov	es:[di],ax
	pop	di
	pop	es
	leave
	retf

l1492_0027:
	mov	dx,[38C2h]
	out	dx,ax
	leave
	retf
1492:002E                                           83 3E               .>
1492:0030 C0 38 00 74 10 06 57 8E 06 C0 38 8B 3E C2 38 26 .8.t..W...8.>.8&
