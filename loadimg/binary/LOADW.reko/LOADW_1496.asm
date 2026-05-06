;;; Segment 1496 (1496:0000)
1496:0000 8B 05 5F 07 CB 8B 16 C2 38 ED CB 00             .._.....8...    

;; fn1496_000C: 1496:000C
;;   Called from:
;;     0800:8011 (in fn0800_7DD1)
;;     0800:818B (in fn0800_8095)
fn1496_000C proc
	enter	0h,0h
	push	ds
	push	si
	mov	cx,[bp+0Ah]
	jcxz	0034h

l1496_0017:
	cld
	cmp	word ptr [38C0h],0h
	jz	0038h

l1496_001F:
	push	es
	push	di
	mov	es,[38C0h]
	mov	di,[38C2h]
	lds	si,[bp+6h]

l1496_002C:
	lodsw
	mov	es:[di],ax
	loop	002Ch

l1496_0032:
	pop	di
	pop	es

l1496_0034:
	pop	si
	pop	ds
	leave
	retf

l1496_0038:
	mov	dx,[38C2h]
	lds	si,[bp+6h]

l1496_003F:
	lodsw
