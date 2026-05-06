;;; Segment 1463 (1463:0000)
1463:0000 9A BC 0A 9A 14 83 C4 0A                         ........        

l1054_40F8:
	pop	si
	pop	di
	leave
	retf

;; fn1463_000C: 1463:000C
;;   Called from:
;;     0800:000D (in fn0800_0000)
;;     0800:00AD (in fn0800_00A0)
fn1463_000C proc
	push	si
	push	di
	mov	ax,3567h
	int	21h
	mov	di,0Ah
	lea	si,[30FEh]
	xor	ax,ax
	mov	cx,8h
	cld
	rep cmpsb
	jz	0025h

l1463_0024:
	dec	ax

l1463_0025:
	pop	di
	pop	si
	retf

;; fn1463_0028: 1463:0028
;;   Called from:
;;     0800:00BE (in fn0800_00A0)
;;     1054:372E (in fn1054_3721)
fn1463_0028 proc
	mov	ah,42h
	int	67h
	or	ah,ah
	jz	0034h

l1463_0030:
	mov	bl,ah
	mov	bh,0FFh

l1463_0034:
	mov	ax,bx
	retf

;; fn1463_0037: 1463:0037
;;   Called from:
;;     0800:00E1 (in fn0800_00A0)
;;     1054:379D (in fn1054_3721)
fn1463_0037 proc
	enter	0h,0h
	mov	ah,43h
	mov	bx,[bp+6h]
	int	67h
	or	ah,ah
	jz	004Ah

l1463_0046:
	mov	dl,ah
	mov	dh,0FFh

l1463_004A:
	mov	ax,dx
	leave
	retf

;; fn1463_004E: 1463:004E
;;   Called from:
;;     0800:0058 (in fn0800_0040)
;;     0800:006C (in fn0800_0040)
;;     0800:0080 (in fn0800_0040)
;;     0800:0094 (in fn0800_0040)
;;     1054:36BF (in fn1054_3691)
;;     1054:36D8 (in fn1054_3691)
;;     1054:36F1 (in fn1054_3691)
;;     1054:370A (in fn1054_3691)
fn1463_004E proc
	enter	0h,0h
	mov	ax,4400h
	mov	bx,[bp+6h]
	xchg	bh,al
	mov	dx,[bp+8h]
	int	67h
	xor	al,al
	or	ah,ah
	jz	0069h

l1463_0065:
	mov	al,ah
	mov	ah,0FFh

l1463_0069:
	leave
	retf

;; fn1463_006B: 1463:006B
;;   Called from:
;;     0800:00F6 (in fn0800_00A0)
;;     1054:376B (in fn1054_3721)
fn1463_006B proc
	mov	ah,41h
	int	67h
	xor	al,al
	or	ah,ah
	jz	0079h

l1463_0075:
	mov	al,ah
	mov	ah,0FFh

l1463_0079:
	mov	ax,bx
	retf

;; fn1463_007C: 1463:007C
;;   Called from:
;;     0800:0023 (in fn0800_0000)
;;     1054:3A02 (in fn1054_39D9)
fn1463_007C proc
	enter	0h,0h
	mov	ah,45h
	mov	dx,[bp+6h]
	int	67h
	xor	al,al
	or	ah,ah
	jz	0091h

l1463_008D:
	mov	al,ah
	mov	ah,0FFh
