;;; Segment 149A (149A:0000)
149A:0000 EF E2 FC                                        ...             

l1496_0043:
	pop	si
	pop	ds
	leave
	retf
1496:0047                      00 00 00 00 00 00 00 00 00        .........
1496:0050 00 00 00 00 00 00 00 00 B4 30 CD 21 3C 02 73 05 .........0.!<.s.
1496:0060 33 C0 06 50 CB BF E8 3D 8B 36 02 00 2B F7 81 FE 3..P...=.6..+...
1496:0070 00 10 72 03 BE 00 10 FA 8E D7 81 C4 CE 3A FB 73 ..r..........:.s
1496:0080 12 16 1F 0E E8 59 02 33 C0 50 0E E8 3B 05 B8 FF .....Y.3.P..;...
1496:0090 4C CD 21 8B C6 B1 04 D3 E0 48 36 A3 66 31 BB 68 L.!......H6.f1.h
1496:00A0 31 36 8C 17 83 E4 FE 36 89 67 04 B8 FE FF 50 36 16.....6.g....P6
1496:00B0 89 67 0A F7 D0 50 36 89 67 06 36 89 67 08 36 89 .g...P6.g.6.g.6.
1496:00C0 26 62 31 03 F7 89 36 02 00 8C C3 2B DE F7 DB B4 &b1...6....+....
1496:00D0 4A CD 21 36 8C 1E A2 31 16 07 FC BF 9E 38 B9 D0 J.!6...1.....8..
1496:00E0 3A 2B CF 33 C0 F3 AA 16 1F 8B 0E FC 35 E3 02 FF :+.3........5...
1496:00F0 D1 9A BE 04 9A 14 9A 10 03 9A 14 33 ED 9A 18 01 ...........3....
1496:0100 9A 14 16 1F FF 36 C7 31 FF 36 C5 31 FF 36 C3 31 .....6.1.6.1.6.1
1496:0110 FF 36 C1 31 FF 36 BF 31 9A A4 0D 00 08 50 0E E8 .6.1.6.1.....P..
1496:0120 FB 00 C3 2E A1 15 01 8E D8 B8 03 00 36 C7 06 64 ............6..d
1496:0130 31 DD 01                                        1..             

l149A_00F3:
	push	ax
	push	cs
	call	02A0h
	push	cs
	call	0589h
	cmp	word ptr ss:[35FEh],0D6D6h
	jnz	010Ch

l149A_0105:
	pop	ax
	push	ax
	call	word ptr ss:[3602h]

l149A_010C:
	mov	ax,0FFh
	push	ax
	push	cs
	call	word ptr [3164h]
	call	0155h
	mov	ax,3500h
	int	21h
	mov	[318Eh],bx
	mov	[3190h],es
	push	cs
	pop	ds
	mov	ax,2500h
	mov	dx,0E3h
	int	21h
	push	ss
	pop	ds
	mov	cx,[3610h]
	jcxz	0165h

l149A_0137:
	mov	es,[31A2h]
	mov	si,es:[002Ch]
	lds	ax,[3612h]
	mov	dx,ds
	xor	bx,bx
	call	dword ptr ss:[360Eh]
	jnc	0154h

l149A_014F:
	push	ss
	pop	ds
	jmp	02C2h

l149A_0154:
	lds	ax,ss:[3616h]

;; fn149A_0155: 149A:0155
;;   Called from:
;;     149A:0115 (in fn149A_02C8)
fn149A_0155 proc
	lds	ax,[3616h]

;; fn149A_0159: 149A:0159
;;   Called from:
;;     149A:0154 (in fn149A_02C8)
;;     149A:0155 (in fn149A_0155)
fn149A_0159 proc
	mov	dx,ds
	mov	bx,3h
	call	dword ptr ss:[360Eh]
	push	ss
	pop	ds

;; fn149A_0165: 149A:0165
;;   Called from:
;;     149A:0135 (in fn149A_02C8)
;;     149A:0164 (in fn149A_0159)
;;     149A:0164 (in fn149A_0159)
fn149A_0165 proc
	mov	es,[31A2h]
	mov	cx,es:[002Ch]
	jcxz	01AEh

;; fn149A_0170: 149A:0170
;;   Called from:
;;     149A:016E (in fn149A_0165)
;;     149A:016E (in fn149A_0165)
fn149A_0170 proc
	mov	es,cx
	xor	di,di

l149A_0174:
	cmp	byte ptr es:[di],0h
	jz	01AEh

l149A_017A:
	mov	cx,0Dh
	mov	si,3180h
	rep cmpsb
	jz	018Fh

l149A_0184:
	mov	cx,7FFFh
	xor	ax,ax

l149A_0189:
	repne scasb

l149A_018B:
	jnz	01AEh

l149A_018D:
	jmp	0174h

l149A_018F:
	push	es
	push	ds
	pop	es
	pop	ds
	mov	si,di
	mov	di,31ABh
	mov	cl,4h

l149A_019A:
	lodsb
	sub	al,41h
	jc	01ACh

l149A_019F:
	shl	al,cl
	xchg	dx,ax
	lodsb
	sub	al,41h
	jc	01ACh

l149A_01A7:
	or	al,dl
	stosb
	jmp	019Ah

l149A_01AC:
	push	ss
	pop	ds

;; fn149A_01AE: 149A:01AE
;;   Called from:
;;     149A:016E (in fn149A_0165)
;;     149A:016E (in fn149A_0165)
;;     149A:0178 (in fn149A_0170)
;;     149A:018B (in fn149A_0170)
;;     149A:01AD (in fn149A_0170)
fn149A_01AE proc
	mov	bx,4h

l149A_01B1:
	and	byte ptr [bx+31ABh],0BFh
	mov	ax,4400h
	int	21h
	jc	01C7h

l149A_01BD:
	test	dl,80h
	jz	01C7h

l149A_01C2:
	or	byte ptr [bx+31ABh],40h

l149A_01C7:
	dec	bx
	jns	01B1h

l149A_01CA:
	mov	si,361Ah
	mov	di,361Ah
	call	028Dh
	mov	si,361Ah
	mov	di,361Ah
	call	028Dh
	retf

;; fn149A_01DD: 149A:01DD
;;   Called from:
;;     0800:02F2 (in fn0800_02C7)
;;     0800:0E3A (in main)
;;     0800:142B (in main)
;;     0800:1538 (in main)
;;     0800:1731 (in main)
;;     0800:7A80 (in fn0800_77A8)
fn149A_01DD proc
	push	bp
	mov	bp,sp
	xor	cx,cx
	jmp	01FEh
149A:01E4             55 8B EC B9 01 00 EB 12 55 8B EC 56     U.......U..V
149A:01F0 57 B9 00 01 EB 08 55 8B EC 56 57 B9 01 01       W.....U..VW...  

l149A_01FE:
	push	cx
	or	cl,cl
	jnz	0221h

l149A_0203:
	mov	si,38B6h
	mov	di,38B6h
	call	028Dh
	mov	si,361Ah
	mov	di,361Eh
	call	028Dh
	cmp	word ptr [35FEh],0D6D6h
	jnz	0221h

l149A_021D:
	call	word ptr [3604h]

l149A_0221:
	mov	si,361Eh
	mov	di,361Eh
	call	028Dh
	mov	si,361Eh
	mov	di,361Eh
	call	028Dh
	call	far 149Ah:02ECh
	or	ax,ax
	jz	024Dh

l149A_023C:
	pop	ax
	or	ah,ah
	push	ax
	jnz	024Dh

l149A_0242:
	cmp	word ptr [bp+6h],0h
	jnz	024Dh

l149A_0248:
	mov	word ptr [bp+6h],0FFh

l149A_024D:
	call	0260h
	pop	ax
	or	ah,ah
	jnz	025Ch

l149A_0255:
	mov	ax,[bp+6h]
	mov	ah,4Ch
	int	21h

l149A_025C:
	pop	di
	pop	si
	pop	bp
	retf

;; fn149A_0260: 149A:0260
;;   Called from:
;;     149A:024D (in fn149A_01DD)
fn149A_0260 proc
	mov	cx,[3610h]
	jcxz	026Dh

l149A_0266:
	mov	bx,2h
	call	dword ptr [360Eh]

l149A_026D:
	push	ds
	lds	dx,[318Eh]
	mov	ax,2500h
	int	21h
	pop	ds
	cmp	byte ptr [31D0h],0h
	jz	028Ch

l149A_027F:
	push	ds
	mov	al,[31D1h]
	lds	dx,[31D2h]
	mov	ah,25h
	int	21h
	pop	ds

l149A_028C:
	ret

;; fn149A_028D: 149A:028D
;;   Called from:
;;     149A:01D0 (in fn149A_01AE)
;;     149A:01D9 (in fn149A_01AE)
;;     149A:0209 (in fn149A_01DD)
;;     149A:0212 (in fn149A_01DD)
;;     149A:0227 (in fn149A_01DD)
;;     149A:0230 (in fn149A_01DD)
fn149A_028D proc
	cmp	si,di
	jnc	029Fh

l149A_0291:
	sub	di,4h
	mov	ax,[di]
	or	ax,[di+2h]
	jz	028Dh

l149A_029B:
	call	dword ptr [di]
	jmp	028Dh

l149A_029F:
	ret

;; fn149A_02A0: 149A:02A0
;;   Called from:
;;     149A:00F4 (in fn149A_02C8)
;;     149A:02FF (in fn149A_02EC)
fn149A_02A0 proc
	push	bp
	mov	bp,sp
	mov	ax,0FCh
	push	ax
	push	cs
	call	0589h
	cmp	word ptr [31D8h],0h
	jz	02B6h

l149A_02B2:
	call	dword ptr [31D6h]

l149A_02B6:
	mov	ax,0FFh
	push	ax
	push	cs
	call	0589h
	mov	sp,bp
	pop	bp
	retf

l149A_02C2:
	mov	ax,2h
	jmp	00F3h

;; fn149A_02C8: 149A:02C8
;;   Called from:
;;     0800:0006 (in fn0800_0000)
;;     0800:0046 (in fn0800_0040)
;;     0800:00A6 (in fn0800_00A0)
;;     0800:012F (in fn0800_0129)
;;     0800:02CD (in fn0800_02C7)
;;     0800:0304 (in fn0800_02FE)
;;     0800:04EE (in fn0800_04E8)
;;     0800:05D2 (in fn0800_05CC)
;;     0800:06DF (in fn0800_06D9)
;;     0800:078A (in fn0800_0784)
;;     0800:0850 (in fn0800_084A)
;;     0800:0910 (in fn0800_090A)
;;     0800:0A4D (in fn0800_0A47)
;;     0800:0ACD (in fn0800_0AC7)
;;     0800:0D66 (in fn0800_0D60)
;;     0800:0DAA (in main)
;;     0800:413A (in fn0800_4134)
;;     0800:41C1 (in fn0800_41BB)
;;     0800:4460 (in fn0800_445A)
;;     0800:44E7 (in fn0800_44E1)
;;     0800:45E2 (in fn0800_45DC)
;;     0800:46F2 (in fn0800_46EC)
;;     0800:472B (in fn0800_4725)
;;     0800:4822 (in fn0800_481C)
;;     0800:5153 (in fn0800_514D)
;;     0800:5385 (in fn0800_537F)
;;     0800:5418 (in fn0800_5412)
;;     0800:545A (in fn0800_5454)
;;     0800:54A6 (in fn0800_54A0)
;;     0800:5510 (in fn0800_550A)
;;     0800:6F26 (in fn0800_6F20)
;;     0800:7382 (in fn0800_737C)
;;     0800:750B (in fn0800_7505)
;;     0800:7582 (in fn0800_757C)
;;     0800:75E7 (in fn0800_75E1)
;;     0800:772D (in fn0800_7727)
;;     0800:77AE (in fn0800_77A8)
;;     0800:7AFD (in fn0800_7AF7)
;;     0800:7B8E (in fn0800_7B88)
;;     0800:7D2B (in fn0800_7D25)
;;     0800:7DD7 (in fn0800_7DD1)
;;     0800:809B (in fn0800_8095)
;;     0800:83CB (in fn0800_83C5)
;;     0800:849D (in fn0800_8497)
;;     1054:0014 (in fn1054_000E)
;;     1054:0031 (in fn1054_002B)
;;     1054:0089 (in fn1054_0083)
;;     1054:010A (in fn1054_0104)
;;     1054:0338 (in fn1054_0332)
;;     1054:038C (in fn1054_0386)
;;     1054:03E0 (in fn1054_03DA)
;;     1054:0768 (in fn1054_0762)
;;     1054:0798 (in fn1054_0792)
;;     1054:0DB9 (in fn1054_0DB3)
;;     1054:1A4F (in fn1054_1A49)
;;     1054:3547 (in fn1054_3541)
;;     1054:35A7 (in fn1054_35A1)
;;     1054:3602 (in fn1054_35FC)
;;     1054:3697 (in fn1054_3691)
;;     1054:3727 (in fn1054_3721)
;;     1054:37E3 (in fn1054_37DD)
;;     1054:38FF (in fn1054_38F9)
;;     1054:39DF (in fn1054_39D9)
;;     1054:3A17 (in fn1054_3A11)
;;     1054:3C5D (in fn1054_3C57)
;;     1054:3E53 (in fn1054_3E4D)
;;     1054:3E8D (in fn1054_3E87)
;;     1054:3EE4 (in fn1054_3EDE)
;;     1054:3F76 (in fn1054_3F70)
;;     1484:0014 (in fn1484_000E)
;;     149A:0FA8 (in fn149A_0FA2)
;;     149A:17FC (in fn149A_17F6)
;;     149A:21EA (in fn149A_212E)
;;     149A:2FBF (in fn149A_2FB2)
;;     149A:3075 (in fn149A_3068)
fn149A_02C8 proc
	pop	cx
	pop	dx
	mov	bx,sp
	sub	bx,ax
	jc	02DBh

l149A_02D0:
	cmp	bx,[31DEh]
	jc	02DBh

l149A_02D6:
	mov	sp,bx
	push	dx
	push	cx
	retf

l149A_02DB:
	push	dx
	push	cx
	mov	ax,[31DAh]
	inc	ax
	jnz	02E8h

l149A_02E3:
	xor	ax,ax
	jmp	00F3h

l149A_02E8:
	jmp	dword ptr [31DAh]

;; fn149A_02EC: 149A:02EC
;;   Called from:
;;     149A:0233 (in fn149A_01DD)
fn149A_02EC proc
	push	si
	xor	si,si
	mov	cx,42h
	xor	ah,ah
	cld

l149A_02F5:
	lodsb
	xor	ah,al
	loop	02F5h

l149A_02FA:
	xor	ah,55h
	jz	030Eh

l149A_02FF:
	push	cs
	call	02A0h
	mov	ax,1h
	push	ax
	push	cs
	call	0589h
	mov	ax,1h

l149A_030E:
	pop	si
	retf
149A:0310 8F 06 E0 31 8F 06 E2 31 B4 30 CD 21 A3 A4 31 BA ...1...1.0.!..1.
149A:0320 01 00 3C 02 74 29 8E 06 A2 31 26 8E 06 2C 00 8C ..<.t)...1&..,..
149A:0330 06 CB 31 33 C0 99 B9 00 80 33 FF F2 AE AE 75 FB ..13.....3....u.
149A:0340 47 47 89 3E C9 31 B9 FF FF F2 AE F7 D1 8B D1 BF GG.>.1..........
149A:0350 01 00 BE 81 00 8E 1E A2 31 AC 3C 20 74 FB 3C 09 ........1.< t.<.
149A:0360 74 F7 3C 0D 74 6F 0A C0 74 6B 47 4E AC 3C 20 74 t.<.to..tkGN.< t
149A:0370 E8 3C 09 74 E4 3C 0D 74 5C 0A C0 74 58 3C 22 74 .<.t.<.t\..tX<"t
149A:0380 24 3C 5C 74 03 42 EB E4 33 C9 41 AC 3C 5C 74 FA $<\t.B..3.A.<\t.
149A:0390 3C 22 74 04 03 D1 EB D3 8B C1 D1 E9 13 D1 A8 01 <"t.............
149A:03A0 75 CA EB 01 4E AC 3C 0D 74 2B 0A C0 74 27 3C 22 u...N.<.t+..t'<"
149A:03B0 74 BA 3C 5C 74 03 42 EB EC 33 C9 41 AC 3C 5C 74 t.<\t.B..3.A.<\t
149A:03C0 FA 3C 22 74 04 03 D1 EB DB 8B C1 D1 E9 13 D1 A8 .<"t............
149A:03D0 01 75 D2 EB 97 16 1F 89 3E BF 31 03 D7 47 D1 E7 .u......>.1..G..
149A:03E0 D1 E7 03 D7 42 80 E2 FE 2B E2 8B C4 A3 C1 31 8C ....B...+.....1.
149A:03F0 16 C3 31 8B D8 03 FB 16 07 36 89 3F 36 8C 57 02 ..1......6.?6.W.
149A:0400 83 C3 04 C5 36 C9 31 AC AA 0A C0 75 FA 36 8E 1E ....6.1....u.6..
149A:0410 A2 31 BE 81 00 EB 03 33 C0 AA AC 3C 20 74 FB 3C .1.....3...< t.<
149A:0420 09 74 F7 3C 0D 75 03 E9 84 00 0A C0 75 03 EB 7E .t.<.u......u..~
149A:0430 90 36 89 3F 36 8C 57 02 83 C3 04 4E AC 3C 20 74 .6.?6.W....N.< t
149A:0440 D6 3C 09 74 D2 3C 0D 74 62 0A C0 74 5E 3C 22 74 .<.t.<.tb..t^<"t
149A:0450 27 3C 5C 74 03 AA EB E4 33 C9 41 AC 3C 5C 74 FA '<\t....3.A.<\t.
149A:0460 3C 22 74 06 B0 5C F3 AA EB D1 B0 5C D1 E9 F3 AA <"t..\.....\....
149A:0470 73 06 B0 22 AA EB C5 4E AC 3C 0D 74 2E 0A C0 74 s.."...N.<.t...t
149A:0480 2A 3C 22 74 B7 3C 5C 74 03 AA EB EC 33 C9 41 AC *<"t.<\t....3.A.
149A:0490 3C 5C 74 FA 3C 22 74 06 B0 5C F3 AA EB D9 B0 5C <\t.<"t..\.....\
149A:04A0 D1 E9 F3 AA 73 96 B0 22 AA EB CD 33 C0 AA 16 1F ....s.."...3....
149A:04B0 C7 07 00 00 C7 47 02 00 00 FF 2E E0 31 00 55 8B .....G......1.U.
149A:04C0 EC 83 EC 04 1E 8E 06 A2 31 26 8B 1E 2C 00 8E C3 ........1&..,...
149A:04D0 8C 46 FE 33 C0 33 F6 33 FF B9 FF FF 0B DB 74 0E .F.3.3.3......t.
149A:04E0 26 80 3E 00 00 00 74 06 F2 AE 46 AE 75 FA 8B C7 &.>...t...F.u...
149A:04F0 40 24 FE 46 8B FE D1 E6 D1 E6 B9 09 00 E8 C0 00 @$.F............
149A:0500 52 50 8B C6 E8 B9 00 A3 C5 31 89 16 C7 31 89 56 RP.......1...1.V
149A:0510 FC 06 1F 8B CF 8B D8 33 F6 5F 07 49 E3 33 8B 04 .......3._.I.3..
149A:0520 36 3B 06 80 31 75 14 51 56 57 06 16 07 BF 80 31 6;..1u.QVW.....1
149A:0530 B9 06 00 F3 A7 07 5F 5E 59 74 0B 8E 5E FC 89 3F ......_^Yt..^..?
149A:0540 8C 47 02 83 C3 04 8E 5E FE AC AA 0A C0 75 FA E2 .G.....^.....u..
149A:0550 CD 8E 5E FC 89 0F 89 4F 02 1F 8B E5 5D CB       ..^....O....].  

;; fn149A_055E: 149A:055E
;;   Called from:
;;     149A:0590 (in fn149A_0589)
fn149A_055E proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	ds
	pop	es
	mov	dx,[bp+6h]
	mov	si,37C4h

l149A_056B:
	lodsw
	cmp	ax,dx
	jz	0580h

l149A_0570:
	inc	ax
	xchg	si,ax
	jz	0580h

l149A_0574:
	xchg	di,ax
	xor	ax,ax
	mov	cx,0FFFFh
	repne scasb
	mov	si,di
	jmp	056Bh

l149A_0580:
	xchg	si,ax
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf	2h

;; fn149A_0589: 149A:0589
;;   Called from:
;;     149A:00F8 (in fn149A_02C8)
;;     149A:02A7 (in fn149A_02A0)
;;     149A:02BA (in fn149A_02A0)
;;     149A:0307 (in fn149A_02EC)
fn149A_0589 proc
	push	bp
	mov	bp,sp
	push	di
	push	word ptr [bp+6h]
	push	cs
	call	055Eh
	or	ax,ax
	jz	05B8h

l149A_0598:
	xchg	dx,ax
	mov	di,dx
	xor	ax,ax
	mov	cx,0FFFFh
	repne scasb
	not	cx
	dec	cx
	mov	bx,2h
	cmp	word ptr [35FEh],0D6D6h
	jnz	05B4h

l149A_05B0:
	call	word ptr [3600h]

l149A_05B4:
	mov	ah,40h
	int	21h

l149A_05B8:
	pop	di
	mov	sp,bp
	pop	bp
	retf	2h
149A:05BF                                              00                .
149A:05C0 53 06 51 B9 00 04 87 0E 68 34 51 50 9A A2 22 9A S.Q.....h4QP..".
149A:05D0 14 5B 8F 06 68 34 59 8B DA 0B D8 74 03 07 5B C3 .[..h4Y....t..[.
149A:05E0 8B C1 E9 0E FB 00                               ......          

;; fn149A_05E6: 149A:05E6
;;   Called from:
;;     149A:1DE7 (in fn149A_1DCA)
;;     149A:3504 (in fn149A_34E6)
;;     149A:365B (in fn149A_364A)
;;     149A:366A (in fn149A_365E)
fn149A_05E6 proc
	jc	05FDh

l149A_05E8:
	xor	ax,ax
	mov	sp,bp
	pop	bp
	retf
149A:05EE                                           73 F8               s.
149A:05F0 50 E8 1A 00 58 32 E4 8B E5 5D CB                P...X2...].     

;; fn149A_05FB: 149A:05FB
;;   Called from:
;;     149A:1E61 (in fn149A_1DEA)
;;     149A:1EC5 (in fn149A_1E86)
;;     149A:1F91 (in fn149A_1E86)
;;     149A:20B8 (in fn149A_2030)
;;     149A:2141 (in fn149A_212E)
;;     149A:2251 (in fn149A_2251)
;;     149A:2251 (in fn149A_2251)
;;     149A:225D (in fn149A_212E)
;;     149A:2EDD (in fn149A_2EC4)
;;     149A:2FAE (in fn149A_2EC4)
;;     149A:34E3 (in fn149A_34D0)
fn149A_05FB proc
	jnc	0604h

;; fn149A_05FD: 149A:05FD
;;   Called from:
;;     149A:05E6 (in fn149A_05E6)
;;     149A:05FB (in fn149A_05FB)
;;     149A:05FB (in fn149A_05FB)
fn149A_05FD proc
	call	060Eh
	mov	ax,0FFFFh
	cwd

l149A_0604:
	mov	sp,bp
	pop	bp
	retf

;; fn149A_0608: 149A:0608
;;   Called from:
;;     149A:2925 (in fn149A_28DA)
fn149A_0608 proc
	xor	ah,ah
	call	060Eh
	retf

;; fn149A_060E: 149A:060E
;;   Called from:
;;     149A:05FD (in fn149A_05FD)
;;     149A:060A (in fn149A_0608)
fn149A_060E proc
	mov	[31A7h],al
	or	ah,ah
	jnz	0637h

l149A_0615:
	cmp	byte ptr [31A4h],3h
	jc	0628h

l149A_061C:
	cmp	al,22h
	jnc	062Ch

l149A_0620:
	cmp	al,20h
	jc	0628h

l149A_0624:
	mov	al,5h
	jmp	062Eh

l149A_0628:
	cmp	al,13h
	jbe	062Eh

l149A_062C:
	mov	al,13h

l149A_062E:
	mov	bx,31E4h
	xlat

l149A_0632:
	cbw
	mov	[319Ch],ax
	ret

l149A_0637:
	mov	al,ah
	jmp	0632h
149A:063B                                  00                        .    

;; fn149A_063C: 149A:063C
;;   Called from:
;;     0800:0A91 (in fn0800_0A47)
;;     0800:1DF1 (in main)
;;     0800:2E3D (in main)
;;     0800:2E53 (in main)
;;     0800:2FDC (in main)
;;     0800:393C (in main)
;;     0800:3960 (in main)
;;     0800:3976 (in main)
;;     0800:399B (in main)
;;     0800:39B1 (in main)
;;     0800:39C7 (in main)
;;     0800:39EC (in main)
;;     0800:3A11 (in main)
;;     0800:3A56 (in main)
;;     0800:3B73 (in main)
;;     0800:3BB6 (in main)
;;     1054:3501 (in fn1054_1A49)
;;     1054:3523 (in fn1054_1A49)
fn149A_063C proc
	push	bp
	mov	bp,sp
	sub	sp,10h
	push	di
	push	si
	mov	di,0FFFFh
	mov	si,[bp+6h]
	test	byte ptr [si+0Ah],40h
	jz	0653h

l149A_0650:
	jmp	06F6h

l149A_0653:
	test	byte ptr [si+0Ah],83h
	jnz	065Ch

l149A_0659:
	jmp	06F6h

l149A_065C:
	push	ds
	push	si
	call	far 149Ah:0ECEh
	add	sp,4h
	mov	di,ax
	mov	bx,si
	sub	bx,31FEh
	mov	ax,[bx+32F2h]
	mov	[bp-6h],ax
	push	ds
	push	si
	call	0C88h
	add	sp,4h
	mov	al,[si+0Bh]
	sub	ah,ah
	push	ax
	call	far 149Ah:1DCAh
	add	sp,2h
	or	ax,ax
	jl	06F3h

l149A_068F:
	cmp	word ptr [bp-6h],0h
	jz	06F6h

l149A_0695:
	mov	ax,31F8h
	push	ds
	push	ax
	lea	ax,[bp-10h]
	push	ss
	push	ax
	call	far 149Ah:25AEh
	add	sp,8h
	lea	ax,[bp-0Eh]
	mov	[bp-4h],ax
	mov	[bp-2h],ss
	cmp	byte ptr [bp-10h],5Ch
	jz	06CAh

l149A_06B6:
	mov	ax,31FAh
	push	ds
	push	ax
	lea	ax,[bp-10h]
	push	ss
	push	ax
	call	far 149Ah:2568h
	add	sp,8h
	jmp	06CDh

l149A_06CA:
	dec	word ptr [bp-4h]

l149A_06CD:
	mov	ax,0Ah
	push	ax
	push	word ptr [bp-2h]
	push	word ptr [bp-4h]
	push	word ptr [bp-6h]
	call	far 149Ah:2662h
	add	sp,8h
	lea	ax,[bp-10h]
	push	ss
	push	ax
	call	far 149Ah:365Eh
	add	sp,4h
	or	ax,ax
	jz	06F6h

l149A_06F3:
	mov	di,0FFFFh

l149A_06F6:
	mov	byte ptr [si+0Ah],0h
	mov	ax,di
	pop	si
	pop	di
	mov	sp,bp
	pop	bp
	retf

;; fn149A_0702: 149A:0702
;;   Called from:
;;     149A:0748 (in fn149A_0736)
fn149A_0702 proc
	push	bp
	mov	bp,sp
	sub	sp,8h
	call	far 149Ah:1CE0h
	mov	[bp-2h],dx
	or	dx,ax
	jnz	071Ah

l149A_0714:
	sub	ax,ax
	cwd
	jmp	0732h
149A:0719                            90                            .      

l149A_071A:
	push	word ptr [bp-2h]
	push	ax
	push	word ptr [bp+0Eh]
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:0D0Ch

l149A_0732:
	mov	sp,bp
	pop	bp
	retf

;; fn149A_0736: 149A:0736
;;   Called from:
;;     0800:0B7D (in fn0800_0AC7)
;;     0800:0CFA (in fn0800_0AC7)
;;     0800:1A49 (in main)
;;     0800:1AF6 (in main)
;;     0800:1C35 (in main)
;;     0800:1CCC (in main)
;;     0800:1D7D (in main)
;;     0800:1E03 (in main)
;;     0800:2601 (in main)
;;     0800:268E (in main)
;;     0800:271B (in main)
;;     0800:2916 (in main)
;;     0800:2A7E (in main)
;;     0800:2B4A (in main)
;;     0800:2BD7 (in main)
;;     0800:312C (in main)
;;     0800:32C3 (in main)
;;     0800:3B07 (in main)
;;     1054:1B28 (in fn1054_1A49)
;;     1054:1B75 (in fn1054_1A49)
fn149A_0736 proc
	push	bp
	mov	bp,sp
	sub	ax,ax
	push	ax
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:0702h
	mov	sp,bp
	pop	bp
	retf
149A:0751    90                                            .              

;; fn149A_0752: 149A:0752
;;   Called from:
;;     0800:0D51 (in fn0800_0AC7)
;;     0800:1E65 (in main)
;;     0800:1E7F (in main)
;;     0800:1EA7 (in main)
;;     0800:1EC1 (in main)
;;     0800:1EE9 (in main)
;;     0800:1F03 (in main)
;;     0800:1F2B (in main)
;;     0800:1F45 (in main)
;;     0800:277B (in main)
;;     0800:2795 (in main)
;;     0800:2967 (in main)
;;     0800:2981 (in main)
;;     0800:299B (in main)
;;     0800:29BE (in main)
;;     0800:2AE5 (in main)
;;     0800:2C37 (in main)
;;     0800:2C64 (in main)
;;     0800:2C8D (in main)
;;     0800:2CA7 (in main)
;;     0800:2CC1 (in main)
;;     0800:3239 (in main)
;;     0800:382F (in main)
;;     0800:3849 (in main)
;;     0800:3863 (in main)
;;     0800:38AD (in main)
;;     0800:38CA (in main)
;;     0800:3914 (in main)
;;     0800:3B5D (in main)
;;     0800:5682 (in fn0800_550A)
;;     0800:6158 (in fn0800_550A)
;;     0800:6278 (in fn0800_550A)
;;     0800:62BB (in fn0800_550A)
;;     0800:635F (in fn0800_550A)
;;     0800:6400 (in fn0800_550A)
;;     0800:6432 (in fn0800_550A)
;;     0800:6467 (in fn0800_550A)
;;     0800:6499 (in fn0800_550A)
;;     0800:650C (in fn0800_550A)
;;     0800:653D (in fn0800_550A)
;;     0800:6572 (in fn0800_550A)
;;     0800:65A4 (in fn0800_550A)
;;     0800:65D9 (in fn0800_550A)
;;     0800:660B (in fn0800_550A)
;;     0800:6642 (in fn0800_550A)
;;     0800:6676 (in fn0800_550A)
;;     0800:66E1 (in fn0800_550A)
;;     0800:6712 (in fn0800_550A)
;;     0800:676A (in fn0800_550A)
;;     0800:6796 (in fn0800_550A)
;;     0800:67F3 (in fn0800_550A)
;;     0800:681F (in fn0800_550A)
;;     0800:6854 (in fn0800_550A)
;;     0800:6886 (in fn0800_550A)
;;     0800:697D (in fn0800_550A)
;;     0800:69AF (in fn0800_550A)
;;     0800:69DA (in fn0800_550A)
;;     0800:6A91 (in fn0800_550A)
;;     0800:6ABF (in fn0800_550A)
;;     0800:6B6D (in fn0800_550A)
;;     0800:6BB7 (in fn0800_550A)
;;     0800:6BD4 (in fn0800_550A)
;;     0800:6C68 (in fn0800_550A)
;;     0800:74B0 (in fn0800_737C)
;;     0800:7624 (in fn0800_75E1)
;;     0800:7660 (in fn0800_75E1)
;;     0800:76FE (in fn0800_75E1)
;;     1054:0243 (in fn1054_0104)
;;     1054:042B (in fn1054_03DA)
;;     1054:045A (in fn1054_03DA)
;;     1054:04ED (in fn1054_03DA)
;;     1054:0525 (in fn1054_03DA)
;;     1054:05AB (in fn1054_03DA)
;;     1054:0609 (in fn1054_03DA)
;;     1054:065B (in fn1054_03DA)
;;     1054:0706 (in fn1054_03DA)
;;     1054:0744 (in fn1054_03DA)
;;     1054:09A9 (in fn1054_0792)
;;     1054:09D4 (in fn1054_0792)
;;     1054:0A7C (in fn1054_0792)
;;     1054:0AE5 (in fn1054_0792)
;;     1054:0C4A (in fn1054_0792)
;;     1054:0CA0 (in fn1054_0792)
;;     1054:0CE8 (in fn1054_0792)
;;     1054:0D08 (in fn1054_0792)
;;     1054:156F (in fn1054_0DB3)
;;     1054:159C (in fn1054_0DB3)
;;     1054:15B6 (in fn1054_0DB3)
;;     1054:15F2 (in fn1054_0DB3)
;;     1054:161F (in fn1054_0DB3)
;;     1054:17A6 (in fn1054_0DB3)
;;     1054:17C0 (in fn1054_0DB3)
;;     1054:17FD (in fn1054_0DB3)
;;     1054:182F (in fn1054_0DB3)
;;     1054:18F0 (in fn1054_0DB3)
;;     1054:194B (in fn1054_0DB3)
;;     1054:196B (in fn1054_0DB3)
;;     1054:198B (in fn1054_0DB3)
;;     1054:19AB (in fn1054_0DB3)
;;     1054:19CC (in fn1054_0DB3)
;;     1054:1AC0 (in fn1054_1A49)
;;     1054:1AE8 (in fn1054_1A49)
;;     1054:1CE3 (in fn1054_1A49)
;;     1054:1D0C (in fn1054_1A49)
;;     1054:1D35 (in fn1054_1A49)
;;     1054:2237 (in fn1054_1A49)
;;     1054:2259 (in fn1054_1A49)
;;     1054:227C (in fn1054_1A49)
;;     1054:22A1 (in fn1054_1A49)
;;     1054:22C3 (in fn1054_1A49)
;;     1054:22E6 (in fn1054_1A49)
;;     1054:2373 (in fn1054_1A49)
;;     1054:25C3 (in fn1054_1A49)
;;     1054:25E1 (in fn1054_1A49)
;;     1054:2654 (in fn1054_1A49)
;;     1054:2688 (in fn1054_1A49)
;;     1054:26B8 (in fn1054_1A49)
;;     1054:26F3 (in fn1054_1A49)
;;     1054:271C (in fn1054_1A49)
;;     1054:276E (in fn1054_1A49)
;;     1054:27A7 (in fn1054_1A49)
;;     1054:2C80 (in fn1054_1A49)
;;     1054:2CAA (in fn1054_1A49)
;;     1054:2CE1 (in fn1054_1A49)
;;     1054:2CFE (in fn1054_1A49)
;;     1054:2FA6 (in fn1054_1A49)
;;     1054:300A (in fn1054_1A49)
;;     1054:303A (in fn1054_1A49)
;;     1054:30CD (in fn1054_1A49)
;;     1054:3108 (in fn1054_1A49)
;;     1054:3125 (in fn1054_1A49)
;;     1054:31A1 (in fn1054_1A49)
;;     1054:31D5 (in fn1054_1A49)
;;     1054:3217 (in fn1054_1A49)
;;     1054:3247 (in fn1054_1A49)
;;     1054:32B4 (in fn1054_1A49)
;;     1054:32DA (in fn1054_1A49)
;;     1054:332C (in fn1054_1A49)
;;     1054:3356 (in fn1054_1A49)
;;     1054:3394 (in fn1054_1A49)
;;     1054:33D2 (in fn1054_1A49)
;;     1054:3426 (in fn1054_1A49)
;;     1054:3465 (in fn1054_1A49)
;;     1054:348E (in fn1054_1A49)
;;     1054:34D9 (in fn1054_1A49)
fn149A_0752 proc
	push	bp
	mov	bp,sp
	sub	sp,6h
	push	di
	push	si
	mov	si,[bp+6h]
	push	ds
	push	si
	call	0E04h
	add	sp,4h
	mov	di,ax
	lea	ax,[bp+0Eh]
	push	ss
	push	ax
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	ds
	push	si
	call	far 149Ah:17F6h
	add	sp,0Ch
	mov	[bp-6h],ax
	push	ds
	push	si
	push	di
	call	0E85h
	add	sp,6h
	mov	ax,[bp-6h]
	pop	si
	pop	di
	mov	sp,bp
	pop	bp
	retf
149A:0791    90                                            .              

;; fn149A_0792: 149A:0792
;;   Called from:
;;     1054:1E73 (in fn1054_1A49)
;;     1054:24E2 (in fn1054_1A49)
fn149A_0792 proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	push	si
	push	di
	mov	ax,[bp+0Ah]
	mul	word ptr [bp+0Ch]
	mov	cx,ax
	or	cx,dx
	jz	0807h

l149A_07A6:
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	les	bx,[bp+6h]
	mov	si,[bp+0Eh]

l149A_07B2:
	or	dx,dx
	jnz	07D5h

l149A_07B6:
	cmp	ax,0FFFFh
	jz	07D5h

l149A_07BB:
	mov	cx,bx
	add	cx,ax
	jc	07D5h

l149A_07C1:
	push	ax
	push	bx
	push	dx
	mov	cx,ax
	call	0833h
	mov	cx,ax
	pop	dx
	pop	bx
	pop	ax
	sub	ax,cx
	sbb	dx,0h
	jmp	0811h

l149A_07D5:
	cmp	bx,1h
	ja	07DFh

l149A_07DA:
	mov	cx,8000h
	jmp	07E3h

l149A_07DF:
	mov	cx,bx
	neg	cx

l149A_07E3:
	push	cx
	push	ax
	push	bx
	push	dx
	call	0833h
	mov	cx,ax
	pop	dx
	pop	bx
	pop	ax
	pop	di
	sub	ax,cx
	sbb	dx,0h
	cmp	cx,di
	jc	0811h

l149A_07F9:
	add	bx,cx
	jnc	0809h

l149A_07FD:
	mov	cx,es
	add	cx,1000h
	mov	es,cx
	jmp	0809h

l149A_0807:
	jmp	082Dh

l149A_0809:
	mov	cx,ax
	or	cx,dx
	jnz	07B2h

l149A_080F:
	jmp	0811h

l149A_0811:
	mov	cx,ax
	or	cx,dx
	jz	082Ah

l149A_0817:
	mov	cx,[bp-4h]
	sub	cx,ax
	mov	ax,cx
	mov	cx,[bp-2h]
	sbb	cx,dx
	mov	dx,cx
	div	word ptr [bp+0Ah]
	jmp	082Dh

l149A_082A:
	mov	ax,[bp+0Ch]

l149A_082D:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf

;; fn149A_0833: 149A:0833
;;   Called from:
;;     149A:07C6 (in fn149A_0792)
;;     149A:07E7 (in fn149A_0792)
fn149A_0833 proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	mov	[bp-2h],cx
	mov	di,32EEh
	mov	ax,si
	sub	ax,31FEh
	add	di,ax
	test	byte ptr [si+0Ah],0Ch
	jnz	0851h

l149A_084C:
	test	byte ptr [di],1h
	jz	0856h

l149A_0851:
	mov	ax,[di+2h]
	jmp	0859h

l149A_0856:
	mov	ax,200h

l149A_0859:
	mov	[bp-4h],ax

l149A_085C:
	test	byte ptr [si+0Ah],0Ch
	jnz	0867h

l149A_0862:
	test	byte ptr [di],1h
	jz	089Ah

l149A_0867:
	mov	ax,[si+4h]
	or	ax,ax
	jz	089Ah

l149A_086E:
	cmp	ax,cx
	jbe	0874h

l149A_0872:
	mov	ax,cx

l149A_0874:
	push	ax
	push	bx
	push	cx
	push	es
	push	ax
	push	word ptr [si+2h]
	push	word ptr [si]
	push	es
	push	bx
	push	cs
	call	29DEh
	add	sp,0Ah
	pop	es
	pop	cx
	pop	bx
	pop	ax
	sub	cx,ax
	sub	[si+4h],ax
	add	bx,ax
	add	[si],ax
	jmp	0896h

l149A_0896:
	jcxz	08FAh

l149A_0898:
	jmp	085Ch

l149A_089A:
	cmp	cx,[bp-4h]
	jc	08CFh

l149A_089F:
	xor	dx,dx
	mov	ax,cx
	div	word ptr [bp-4h]
	mov	ax,cx
	sub	ax,dx
	push	bx
	push	cx
	push	es
	push	ax
	push	es
	push	bx
	xor	ax,ax
	mov	al,[si+0Bh]
	push	ax
	push	cs
	call	2030h
	add	sp,8h
	pop	es
	pop	cx
	pop	bx
	or	ax,ax
	jz	08F0h

l149A_08C4:
	cmp	ax,0FFFFh
	jz	08F6h

l149A_08C9:
	sub	cx,ax
	add	bx,ax
	jmp	0896h

l149A_08CF:
	push	bx
	push	cx
	push	es
	push	ds
	push	si
	push	cs
	call	0B00h
	add	sp,4h
	pop	es
	pop	cx
	pop	bx
	cmp	ax,0FFFFh
	jz	08FAh

l149A_08E3:
	mov	es:[bx],al
	inc	bx
	dec	cx
	mov	ax,[di+2h]
	mov	[bp-4h],ax
	jmp	0896h

l149A_08F0:
	or	byte ptr [si+0Ah],10h
	jmp	08FAh

l149A_08F6:
	or	byte ptr [si+0Ah],20h

l149A_08FA:
	mov	ax,[bp-2h]
	sub	ax,cx
	mov	sp,bp
	pop	bp
	ret
149A:0903          00                                        .            

;; fn149A_0904: 149A:0904
;;   Called from:
;;     1054:1BD7 (in fn1054_1A49)
;;     1054:282D (in fn1054_1A49)
;;     1054:2893 (in fn1054_1A49)
fn149A_0904 proc
	push	bp
	mov	bp,sp
	sub	sp,6h
	lea	ax,[bp+0Eh]
	push	ss
	push	ax
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:0FA2h
	mov	sp,bp
	pop	bp
	retf

;; fn149A_0924: 149A:0924
;;   Called from:
;;     149A:27DF (in fn149A_27A8)
fn149A_0924 proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	push	si
	push	di
	mov	ax,[bp+0Ah]
	mul	word ptr [bp+0Ch]
	mov	cx,ax
	or	cx,dx
	jz	0999h

l149A_0938:
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	les	bx,[bp+6h]
	mov	si,[bp+0Eh]

l149A_0944:
	or	dx,dx
	jnz	0967h

l149A_0948:
	cmp	ax,0FFFFh
	jz	0967h

l149A_094D:
	mov	cx,bx
	add	cx,ax
	jc	0967h

l149A_0953:
	push	ax
	push	bx
	push	dx
	mov	cx,ax
	call	09C5h
	mov	cx,ax
	pop	dx
	pop	bx
	pop	ax
	sub	ax,cx
	sbb	dx,0h
	jmp	09A3h

l149A_0967:
	cmp	bx,1h
	ja	0971h

l149A_096C:
	mov	cx,8000h
	jmp	0975h

l149A_0971:
	mov	cx,bx
	neg	cx

l149A_0975:
	push	cx
	push	ax
	push	bx
	push	dx
	call	09C5h
	mov	cx,ax
	pop	dx
	pop	bx
	pop	ax
	pop	di
	sub	ax,cx
	sbb	dx,0h
	cmp	cx,di
	jc	09A3h

l149A_098B:
	add	bx,cx
	jnc	099Bh

l149A_098F:
	mov	cx,es
	add	cx,1000h
	mov	es,cx
	jmp	099Bh

l149A_0999:
	jmp	09BFh

l149A_099B:
	mov	cx,ax
	or	cx,dx
	jnz	0944h

l149A_09A1:
	jmp	09A3h

l149A_09A3:
	mov	cx,ax
	or	cx,dx
	jz	09BCh

l149A_09A9:
	mov	cx,[bp-4h]
	sub	cx,ax
	mov	ax,cx
	mov	cx,[bp-2h]
	sbb	cx,dx
	mov	dx,cx
	div	word ptr [bp+0Ah]
	jmp	09BFh

l149A_09BC:
	mov	ax,[bp+0Ch]

l149A_09BF:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf

;; fn149A_09C5: 149A:09C5
;;   Called from:
;;     149A:0958 (in fn149A_0924)
;;     149A:0979 (in fn149A_0924)
fn149A_09C5 proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	mov	[bp-2h],cx
	mov	di,32EEh
	mov	ax,si
	sub	ax,31FEh
	add	di,ax
	test	byte ptr [si+0Ah],0Ch
	jnz	09E3h

l149A_09DE:
	test	byte ptr [di],1h
	jz	09E8h

l149A_09E3:
	mov	ax,[di+2h]
	jmp	09EBh

l149A_09E8:
	mov	ax,200h

l149A_09EB:
	mov	[bp-4h],ax

l149A_09EE:
	test	byte ptr [si+0Ah],8h
	jnz	09F9h

l149A_09F4:
	test	byte ptr [di],1h
	jz	0A2Fh

l149A_09F9:
	mov	ax,[si+4h]
	or	ax,ax
	jz	0A2Fh

l149A_0A00:
	cmp	ax,cx
	jbe	0A06h

l149A_0A04:
	mov	ax,cx

l149A_0A06:
	push	ax
	push	bx
	push	cx
	push	es
	push	ax
	push	es
	push	bx
	push	word ptr [si+2h]
	push	word ptr [si]
	push	cs
	call	29DEh
	add	sp,0Ah
	pop	es
	pop	cx
	pop	bx
	pop	ax
	sub	cx,ax
	sub	[si+4h],ax
	add	bx,ax
	add	[si],ax
	jmp	0A28h

l149A_0A28:
	or	cx,cx
	jnz	09EEh

l149A_0A2C:
	jmp	0AB2h

l149A_0A2F:
	cmp	cx,[bp-4h]
	jc	0A84h

l149A_0A34:
	test	byte ptr [si+0Ah],8h
	jnz	0A3Fh

l149A_0A3A:
	test	byte ptr [di],1h
	jz	0A52h

l149A_0A3F:
	push	bx
	push	cx
	push	es
	push	ds
	push	si
	push	cs
	call	0ECEh
	add	sp,4h
	pop	es
	pop	cx
	pop	bx
	or	ax,ax
	jnz	0AB2h

l149A_0A52:
	xor	dx,dx
	mov	ax,cx
	div	word ptr [bp-4h]
	mov	ax,cx
	sub	ax,dx
	push	ax
	push	bx
	push	cx
	push	es
	push	ax
	push	es
	push	bx
	xor	ax,ax
	mov	al,[si+0Bh]
	push	ax
	push	cs
	call	212Eh
	add	sp,8h
	pop	es
	pop	cx
	pop	bx
	pop	dx
	cmp	ax,0FFFFh
	jz	0AAEh

l149A_0A7A:
	sub	cx,ax
	cmp	ax,dx
	jnz	0AAEh

l149A_0A80:
	add	bx,ax
	jmp	0A28h

l149A_0A84:
	xor	ax,ax
	mov	al,es:[bx]
	push	bx
	push	cx
	push	es
	push	ds
	push	si
	push	ax
	push	cs
	call	0B9Ch
	add	sp,6h
	pop	es
	pop	cx
	pop	bx
	cmp	ax,0FFFFh
	jz	0AB2h

l149A_0A9E:
	inc	bx
	dec	cx
	mov	ax,[di+2h]
	or	ax,ax
	jnz	0AA8h

l149A_0AA7:
	inc	ax

l149A_0AA8:
	mov	[bp-4h],ax
	jmp	0A28h

l149A_0AAE:
	or	byte ptr [si+0Ah],20h

l149A_0AB2:
	mov	ax,[bp-2h]
	sub	ax,cx
	mov	sp,bp
	pop	bp
	ret
149A:0ABB                                  00                        .    

;; fn149A_0ABC: 149A:0ABC
;;   Called from:
;;     0800:00D7 (in fn0800_00A0)
;;     0800:013E (in fn0800_0129)
;;     0800:014A (in fn0800_0129)
;;     0800:0156 (in fn0800_0129)
;;     0800:0162 (in fn0800_0129)
;;     0800:016E (in fn0800_0129)
;;     0800:017A (in fn0800_0129)
;;     0800:0186 (in fn0800_0129)
;;     0800:0192 (in fn0800_0129)
;;     0800:019E (in fn0800_0129)
;;     0800:01AA (in fn0800_0129)
;;     0800:01B6 (in fn0800_0129)
;;     0800:01C2 (in fn0800_0129)
;;     0800:01CE (in fn0800_0129)
;;     0800:01DA (in fn0800_0129)
;;     0800:01E6 (in fn0800_0129)
;;     0800:01F2 (in fn0800_0129)
;;     0800:01FE (in fn0800_0129)
;;     0800:020A (in fn0800_0129)
;;     0800:0216 (in fn0800_0129)
;;     0800:0222 (in fn0800_0129)
;;     0800:024F (in fn0800_0129)
;;     0800:025B (in fn0800_0129)
;;     0800:0267 (in fn0800_0129)
;;     0800:0273 (in fn0800_0129)
;;     0800:027F (in fn0800_0129)
;;     0800:028B (in fn0800_0129)
;;     0800:0297 (in fn0800_0129)
;;     0800:02A3 (in fn0800_0129)
;;     0800:02AF (in fn0800_0129)
;;     0800:02BB (in fn0800_0129)
;;     0800:0AB1 (in fn0800_0A47)
;;     0800:0BAA (in fn0800_0AC7)
;;     0800:0BD5 (in fn0800_0AC7)
;;     0800:0C24 (in fn0800_0AC7)
;;     0800:0D27 (in fn0800_0AC7)
;;     0800:0DC0 (in main)
;;     0800:0DD0 (in main)
;;     0800:0E30 (in main)
;;     0800:1727 (in main)
;;     0800:1A76 (in main)
;;     0800:1A91 (in main)
;;     0800:1AAE (in main)
;;     0800:1B23 (in main)
;;     0800:1B3E (in main)
;;     0800:1B5B (in main)
;;     0800:1B77 (in main)
;;     0800:1BA0 (in main)
;;     0800:1BAC (in main)
;;     0800:1BD5 (in main)
;;     0800:1C62 (in main)
;;     0800:1CF9 (in main)
;;     0800:1DAA (in main)
;;     0800:1E30 (in main)
;;     0800:1F9B (in main)
;;     0800:200C (in main)
;;     0800:2040 (in main)
;;     0800:20F3 (in main)
;;     0800:211D (in main)
;;     0800:2138 (in main)
;;     0800:220B (in main)
;;     0800:2586 (in main)
;;     0800:262E (in main)
;;     0800:26BB (in main)
;;     0800:2748 (in main)
;;     0800:2817 (in main)
;;     0800:2943 (in main)
;;     0800:2A21 (in main)
;;     0800:2AAB (in main)
;;     0800:2B77 (in main)
;;     0800:2C04 (in main)
;;     0800:2DE1 (in main)
;;     0800:2F5F (in main)
;;     0800:2FFC (in main)
;;     0800:3159 (in main)
;;     0800:3184 (in main)
;;     0800:31E3 (in main)
;;     0800:32F0 (in main)
;;     0800:3515 (in main)
;;     0800:37AC (in main)
;;     0800:37DF (in main)
;;     0800:3A76 (in main)
;;     0800:3B34 (in main)
;;     0800:3B93 (in main)
;;     0800:3BF5 (in main)
;;     0800:3C75 (in main)
;;     0800:3CA7 (in main)
;;     0800:3CD9 (in main)
;;     0800:3D0B (in main)
;;     0800:3D3D (in main)
;;     0800:3DC2 (in main)
;;     0800:3E2A (in main)
;;     0800:3E45 (in main)
;;     0800:3E77 (in main)
;;     0800:3EA9 (in main)
;;     0800:3EDB (in main)
;;     0800:3F0D (in main)
;;     0800:3FA6 (in main)
;;     0800:3FF2 (in main)
;;     0800:4014 (in main)
;;     0800:4082 (in main)
;;     0800:40F0 (in main)
;;     0800:410B (in main)
;;     0800:4117 (in main)
;;     0800:447A (in fn0800_445A)
;;     0800:44C5 (in fn0800_445A)
;;     0800:48B4 (in fn0800_481C)
;;     0800:4AD0 (in fn0800_481C)
;;     0800:4C62 (in fn0800_481C)
;;     0800:4CFA (in fn0800_481C)
;;     0800:4DA1 (in fn0800_481C)
;;     0800:4E39 (in fn0800_481C)
;;     0800:4F97 (in fn0800_481C)
;;     0800:509D (in fn0800_481C)
;;     0800:511D (in fn0800_481C)
;;     0800:52CF (in fn0800_514D)
;;     0800:535A (in fn0800_514D)
;;     0800:5661 (in fn0800_550A)
;;     0800:56A3 (in fn0800_550A)
;;     0800:56DA (in fn0800_550A)
;;     0800:574E (in fn0800_550A)
;;     0800:5775 (in fn0800_550A)
;;     0800:5801 (in fn0800_550A)
;;     0800:5867 (in fn0800_550A)
;;     0800:589E (in fn0800_550A)
;;     0800:5AEF (in fn0800_550A)
;;     0800:5B85 (in fn0800_550A)
;;     0800:5CB3 (in fn0800_550A)
;;     0800:5D08 (in fn0800_550A)
;;     0800:5F32 (in fn0800_550A)
;;     0800:5FC8 (in fn0800_550A)
;;     0800:609E (in fn0800_550A)
;;     0800:60ED (in fn0800_550A)
;;     0800:6228 (in fn0800_550A)
;;     0800:6A06 (in fn0800_550A)
;;     0800:6CBB (in fn0800_550A)
;;     0800:7167 (in fn0800_6F20)
;;     0800:7320 (in fn0800_6F20)
;;     0800:735B (in fn0800_6F20)
;;     0800:736A (in fn0800_6F20)
;;     0800:745A (in fn0800_737C)
;;     0800:7466 (in fn0800_737C)
;;     0800:7870 (in fn0800_77A8)
;;     0800:78F5 (in fn0800_77A8)
;;     0800:7994 (in fn0800_77A8)
;;     0800:79B8 (in fn0800_77A8)
;;     0800:7A3D (in fn0800_77A8)
;;     0800:7A61 (in fn0800_77A8)
;;     0800:7A76 (in fn0800_77A8)
;;     0800:7AA8 (in fn0800_77A8)
;;     0800:7C01 (in fn0800_7B88)
;;     0800:7E0A (in fn0800_7DD1)
;;     0800:7E62 (in fn0800_7DD1)
;;     0800:7E96 (in fn0800_7DD1)
;;     0800:8075 (in fn0800_7DD1)
;;     0800:839F (in fn0800_8095)
;;     1054:0050 (in fn1054_002B)
;;     1054:006D (in fn1054_002B)
;;     1054:014A (in fn1054_0104)
;;     1054:02B4 (in fn1054_0104)
;;     1054:0842 (in fn1054_0792)
;;     1054:0863 (in fn1054_0792)
;;     1054:086F (in fn1054_0792)
;;     1054:0B0D (in fn1054_0792)
;;     1054:0D2D (in fn1054_0792)
;;     1054:0DFB (in fn1054_0DB3)
;;     1054:0E95 (in fn1054_0DB3)
;;     1054:0F01 (in fn1054_0DB3)
;;     1054:0F41 (in fn1054_0DB3)
;;     1054:0FEE (in fn1054_0DB3)
;;     1054:1242 (in fn1054_0DB3)
;;     1054:1341 (in fn1054_0DB3)
;;     1054:1407 (in fn1054_0DB3)
;;     1054:170F (in fn1054_0DB3)
;;     1054:1EF3 (in fn1054_1A49)
;;     1054:1F39 (in fn1054_1A49)
;;     1054:1F74 (in fn1054_1A49)
;;     1054:20F4 (in fn1054_1A49)
;;     1054:37C7 (in fn1054_3721)
;;     1054:38BD (in fn1054_37DD)
;;     1054:3A5B (in fn1054_3A11)
;;     1054:3A89 (in fn1054_3A11)
;;     1054:3B77 (in fn1054_3A11)
;;     1054:3BA2 (in fn1054_3A11)
;;     1054:3BDC (in fn1054_3A11)
;;     1054:3CA1 (in fn1054_3C57)
;;     1054:3CCD (in fn1054_3C57)
;;     1054:3CFA (in fn1054_3C57)
;;     1054:3D26 (in fn1054_3C57)
;;     1054:3E38 (in fn1054_3C57)
;;     1054:3FB5 (in fn1054_3F70)
;;     1054:3FE3 (in fn1054_3F70)
;;     1054:40F0 (in fn1054_3F70)
;;     1484:00CD (in fn1484_000E)
;;     1484:00E0 (in fn1484_000E)
fn149A_0ABC proc
	push	bp
	mov	bp,sp
	sub	sp,6h
	push	di
	mov	ax,320Ah
	push	ds
	push	ax
	call	0E04h
	add	sp,4h
	mov	di,ax
	lea	ax,[bp+0Ah]
	push	ss
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	mov	ax,320Ah
	push	ds
	push	ax
	call	far 149Ah:17F6h
	add	sp,0Ch
	mov	[bp-6h],ax
	mov	ax,320Ah
	push	ds
	push	ax
	push	di
	call	0E85h
	add	sp,6h
	mov	ax,[bp-6h]
	pop	di
	mov	sp,bp
	pop	bp
	retf
149A:0AFF                                              90                .

;; fn149A_0B00: 149A:0B00
;;   Called from:
;;     0800:0243 (in fn0800_0129)
;;     149A:08D4 (in fn149A_0833)
;;     149A:1798 (in fn149A_1772)
;;     149A:276E (in fn149A_272E)
fn149A_0B00 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	si,[bp+6h]
	mov	al,[si+0Ah]
	test	al,83h
	jz	0B6Eh

l149A_0B0F:
	test	al,40h
	jnz	0B6Eh

l149A_0B13:
	test	al,2h
	jnz	0B5Fh

l149A_0B17:
	or	al,1h
	mov	[si+0Ah],al
	mov	di,si
	sub	di,31FEh
	add	di,32EEh
	test	al,0Ch
	jnz	0B37h

l149A_0B2A:
	test	byte ptr [di],1h
	jnz	0B37h

l149A_0B2F:
	push	ds
	push	si
	call	0CC0h
	add	sp,4h

l149A_0B37:
	mov	ax,[si+6h]
	mov	[si],ax
	push	word ptr [di+2h]
	push	word ptr [si+8h]
	push	ax
	xor	bx,bx
	mov	bl,[si+0Bh]
	push	bx
	push	cs
	call	2030h
	add	sp,8h
	or	ax,ax
	jz	0B65h

l149A_0B54:
	cmp	ax,0FFFFh
	jnz	0B73h

l149A_0B59:
	or	byte ptr [si+0Ah],20h
	jmp	0B69h

l149A_0B5F:
	or	byte ptr [si+0Ah],20h
	jmp	0B6Eh

l149A_0B65:
	or	byte ptr [si+0Ah],10h

l149A_0B69:
	mov	word ptr [si+4h],0h

l149A_0B6E:
	mov	ax,0FFFFh
	jmp	0B98h

l149A_0B73:
	mov	bh,[bx+31ABh]
	and	bh,82h
	cmp	bh,82h
	jnz	0B8Ah

l149A_0B7F:
	mov	bh,[si+0Ah]
	test	bh,82h
	jnz	0B8Ah

l149A_0B87:
	or	byte ptr [di],20h

l149A_0B8A:
	dec	ax
	mov	[si+4h],ax
	les	bx,[si]
	xor	ax,ax
	mov	al,es:[bx]
	inc	bx
	mov	[si],bx

l149A_0B98:
	pop	di
	pop	si
	pop	bp
	retf

;; fn149A_0B9C: 149A:0B9C
;;   Called from:
;;     149A:0A8F (in fn149A_09C5)
;;     149A:1D55 (in fn149A_1D36)
;;     149A:2865 (in fn149A_280A)
fn149A_0B9C proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	si,[bp+8h]
	mov	al,[si+0Ah]
	test	al,82h
	jz	0C15h

l149A_0BAB:
	test	al,40h
	jnz	0C15h

l149A_0BAF:
	mov	word ptr [si+4h],0h
	test	al,1h
	jz	0BC3h

l149A_0BB8:
	test	al,10h
	jz	0C15h

l149A_0BBC:
	mov	cx,[si+6h]
	mov	[si],cx
	and	al,0FEh

l149A_0BC3:
	or	al,2h
	and	al,0EFh
	mov	[si+0Ah],al
	mov	di,si
	sub	di,31FEh
	add	di,32EEh
	xor	bx,bx
	mov	bl,[si+0Bh]
	test	al,8h
	jnz	0C2Eh

l149A_0BDD:
	test	al,4h
	jnz	0BFFh

l149A_0BE1:
	test	byte ptr [di],1h
	jnz	0C2Eh

l149A_0BE6:
	cmp	si,320Ah
	jz	0BF8h

l149A_0BEC:
	cmp	si,3216h
	jz	0BF8h

l149A_0BF2:
	cmp	si,322Eh
	jnz	0C1Eh

l149A_0BF8:
	test	byte ptr [bx+31ABh],40h
	jz	0C1Eh

l149A_0BFF:
	mov	cx,1h
	push	cx
	push	ss
	lea	di,[bp+6h]
	push	di
	push	bx
	push	cs
	call	212Eh
	add	sp,8h
	mov	cx,1h
	jmp	0C5Bh

l149A_0C15:
	mov	ax,0FFFFh
	or	byte ptr [si+0Ah],20h
	jmp	0C83h

l149A_0C1E:
	push	bx
	push	ds
	push	si
	call	0CC0h
	add	sp,4h
	pop	bx
	test	byte ptr [si+0Ah],8h
	jz	0BFFh

l149A_0C2E:
	mov	cx,[si]
	mov	dx,[si+6h]
	sub	cx,dx
	inc	dx
	mov	[si],dx
	mov	dx,[di+2h]
	dec	dx
	mov	[si+4h],dx
	jcxz	0C66h

l149A_0C41:
	push	cx
	push	cx
	push	word ptr [si+8h]
	push	word ptr [si+6h]
	push	bx
	push	cs
	call	212Eh
	add	sp,8h
	pop	cx

l149A_0C52:
	les	di,[si+6h]
	mov	dx,[bp+6h]
	mov	es:[di],dl

l149A_0C5B:
	cmp	ax,cx
	jnz	0C15h

l149A_0C5F:
	xor	ax,ax
	mov	al,[bp+6h]
	jmp	0C83h

l149A_0C66:
	xor	ax,ax
	test	byte ptr [bx+31ABh],20h
	jz	0C52h

l149A_0C6F:
	mov	cx,2h
	push	cx
	push	ax
	push	ax
	push	bx
	push	cs
	call	1DEAh
	add	sp,8h
	xor	ax,ax
	mov	cx,ax
	jmp	0C52h

l149A_0C83:
	pop	di
	pop	si
	pop	bp
	retf
149A:0C87                      00                                .        

;; fn149A_0C88: 149A:0C88
;;   Called from:
;;     149A:0677 (in fn149A_063C)
fn149A_0C88 proc
	push	bp
	mov	bp,sp
	push	si
	mov	si,[bp+4h]
	mov	al,[si+0Ah]
	test	al,83h
	jz	0CBCh

l149A_0C96:
	test	al,8h
	jz	0CBCh

l149A_0C9A:
	push	word ptr [si+8h]
	push	word ptr [si+6h]
	call	far 149Ah:22A8h
	add	sp,4h
	and	byte ptr [si+0Ah],0F7h
	xor	ax,ax
	mov	[si+6h],ax
	mov	[si+8h],ax
	mov	[si],ax
	mov	[si+2h],ax
	mov	[si+4h],ax

l149A_0CBC:
	pop	si
	pop	bp
	ret
149A:0CBF                                              00                .

;; fn149A_0CC0: 149A:0CC0
;;   Called from:
;;     149A:0B31 (in fn149A_0B00)
;;     149A:0C21 (in fn149A_0B9C)
;;     149A:1D90 (in fn149A_1D5E)
fn149A_0CC0 proc
	push	bp
	mov	bp,sp
	push	si
	mov	si,[bp+4h]
	mov	ax,200h
	push	ax
	call	far 149Ah:22A2h
	pop	cx
	mov	bx,si
	sub	bx,31FEh
	add	bx,32EEh
	or	dx,dx
	jz	0CEAh

l149A_0CDF:
	or	byte ptr [si+0Ah],8h
	mov	word ptr [bx+2h],200h
	jmp	0CF8h

l149A_0CEA:
	or	byte ptr [si+0Ah],4h
	mov	word ptr [bx+2h],1h
	mov	dx,ds
	lea	ax,[bx+1h]

l149A_0CF8:
	mov	[si+2h],dx
	mov	[si],ax
	mov	[si+8h],dx
	mov	[si+6h],ax
	mov	word ptr [si+4h],0h
	pop	si
	pop	bp
	ret
149A:0D0B                                  00                        .    

;; fn149A_0D0C: 149A:0D0C
;;   Called from:
;;     149A:072D (in fn149A_0702)
fn149A_0D0C proc
	push	bp
	mov	bp,sp
	sub	sp,8h
	push	di
	push	si
	les	bx,[bp+0Ah]
	mov	al,es:[bx]
	cbw
	cmp	ax,77h
	jz	0D68h

l149A_0D20:
	ja	0D2Ah

l149A_0D22:
	sub	al,61h
	jz	0D72h

l149A_0D26:
	sub	al,11h
	jz	0D30h

l149A_0D2A:
	sub	ax,ax
	cwd
	jmp	0DFDh

l149A_0D30:
	sub	si,si
	mov	byte ptr [bp-4h],1h

l149A_0D36:
	mov	word ptr [bp-2h],1h

l149A_0D3B:
	inc	word ptr [bp+0Ah]
	les	bx,[bp+0Ah]
	cmp	byte ptr es:[bx],0h
	jz	0DA2h

l149A_0D47:
	cmp	word ptr [bp-2h],0h
	jz	0DA2h

l149A_0D4D:
	mov	al,es:[bx]
	cbw
	cmp	ax,74h
	jz	0D8Ah

l149A_0D56:
	ja	0D60h

l149A_0D58:
	sub	al,2Bh
	jz	0D78h

l149A_0D5C:
	sub	al,37h
	jz	0D96h

l149A_0D60:
	mov	word ptr [bp-2h],0h
	jmp	0D3Bh
149A:0D67                      90                                .        

l149A_0D68:
	mov	si,301h

l149A_0D6B:
	mov	byte ptr [bp-4h],2h
	jmp	0D36h
149A:0D71    90                                            .              

l149A_0D72:
	mov	si,109h
	jmp	0D6Bh
149A:0D77                      90                                .        

l149A_0D78:
	test	si,2h
	jnz	0D60h

l149A_0D7E:
	or	si,2h
	and	si,0FEh
	mov	byte ptr [bp-4h],80h
	jmp	0D3Bh

l149A_0D8A:
	test	si,0C000h
	jnz	0D60h

l149A_0D90:
	or	si,4000h
	jmp	0D3Bh

l149A_0D96:
	test	si,0C000h
	jnz	0D60h

l149A_0D9C:
	or	si,8000h
	jmp	0D3Bh

l149A_0DA2:
	mov	ax,1A4h
	push	ax
	push	word ptr [bp+0Eh]
	push	si
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:1E64h
	add	sp,0Ah
	mov	[bp-6h],ax
	or	ax,ax
	jge	0DC2h

l149A_0DBF:
	jmp	0D2Ah

l149A_0DC2:
	inc	word ptr [31FCh]
	mov	di,[bp+10h]
	mov	ax,di
	sub	ax,31FEh
	add	ax,32EEh
	mov	[bp-8h],ax
	mov	al,[bp-4h]
	mov	[di+0Ah],al
	mov	bx,[bp-8h]
	mov	byte ptr [bx],0h
	sub	ax,ax
	mov	[di+4h],ax
	mov	[bx+4h],ax
	mov	[di+2h],ax
	mov	[di],ax
	mov	[di+8h],ax
	mov	[di+6h],ax
	mov	al,[bp-6h]
	mov	[di+0Bh],al
	mov	ax,di
	mov	dx,ds

l149A_0DFD:
	pop	si
	pop	di
	mov	sp,bp
	pop	bp
	retf
149A:0E03          90                                        .            

;; fn149A_0E04: 149A:0E04
;;   Called from:
;;     149A:075F (in fn149A_0752)
;;     149A:0AC8 (in fn149A_0ABC)
;;     149A:27C6 (in fn149A_27A8)
fn149A_0E04 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	si,[bp+4h]
	mov	bx,33E2h
	cmp	si,320Ah
	jz	0E27h

l149A_0E15:
	mov	bx,33E6h
	cmp	si,3216h
	jz	0E27h

l149A_0E1E:
	mov	bx,33EAh
	cmp	si,322Eh
	jnz	0E7Fh

l149A_0E27:
	mov	di,si
	sub	di,31FEh
	add	di,32EEh
	test	byte ptr [si+0Ah],0Ch
	jnz	0E7Fh

l149A_0E37:
	test	byte ptr [di],1h
	jnz	0E7Fh

l149A_0E3C:
	mov	ax,[bx]
	mov	dx,[bx+2h]
	mov	cx,ax
	or	cx,dx
	jz	0E68h

l149A_0E47:
	mov	[si+6h],ax
	mov	[si+8h],dx
	mov	[si],ax
	mov	[si+2h],dx
	mov	word ptr [si+4h],200h
	mov	word ptr [di+2h],200h
	or	byte ptr [si+0Ah],2h
	mov	byte ptr [di],11h
	mov	ax,1h
	jmp	0E81h

l149A_0E68:
	push	bx
	mov	ax,200h
	push	ax
	call	far 149Ah:22A2h
	pop	bx
	pop	bx
	or	dx,dx
	jz	0E7Fh

l149A_0E78:
	mov	[bx],ax
	mov	[bx+2h],dx
	jmp	0E47h

l149A_0E7F:
	xor	ax,ax

l149A_0E81:
	pop	di
	pop	si
	pop	bp
	ret

;; fn149A_0E85: 149A:0E85
;;   Called from:
;;     149A:0782 (in fn149A_0752)
;;     149A:0AF1 (in fn149A_0ABC)
;;     149A:27F1 (in fn149A_27A8)
fn149A_0E85 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	si,[bp+6h]
	mov	di,si
	sub	di,31FEh
	add	di,32EEh
	test	byte ptr [di],10h
	jz	0EC9h

l149A_0E9C:
	xor	bx,bx
	mov	bl,[si+0Bh]
	test	byte ptr [bx+31ABh],40h
	jz	0EC9h

l149A_0EA8:
	push	ds
	push	si
	push	cs
	call	0ECEh
	add	sp,4h
	cmp	word ptr [bp+4h],0h
	jz	0EC9h

l149A_0EB7:
	xor	ax,ax
	mov	[di],al
	mov	[di+2h],ax
	mov	[si],ax
	mov	[si+2h],ax
	mov	[si+6h],ax
	mov	[si+8h],ax

l149A_0EC9:
	pop	di
	pop	si
	pop	bp
	ret
149A:0ECD                                        00                    .  

;; fn149A_0ECE: 149A:0ECE
;;   Called from:
;;     0800:2E27 (in main)
;;     149A:065E (in fn149A_063C)
;;     149A:0A44 (in fn149A_09C5)
;;     149A:0EAA (in fn149A_0E85)
;;     149A:0F7E (in fn149A_0F56)
fn149A_0ECE proc
	push	bp
	mov	bp,sp
	sub	sp,2h
	push	di
	push	si
	sub	di,di
	mov	ax,[bp+8h]
	or	ax,[bp+6h]
	jnz	0EE8h

l149A_0EE0:
	sub	ax,ax
	push	ax
	call	0F56h
	jmp	0F47h

l149A_0EE8:
	mov	si,[bp+6h]
	mov	al,[si+0Ah]
	mov	cx,ax
	and	al,3h
	cmp	al,2h
	jnz	0F35h

l149A_0EF6:
	test	cl,8h
	jnz	0F08h

l149A_0EFB:
	mov	bx,si
	sub	bx,31FEh
	test	byte ptr [bx+32EEh],1h
	jz	0F35h

l149A_0F08:
	mov	ax,[si]
	sub	ax,[si+6h]
	mov	[bp-2h],ax
	or	ax,ax
	jle	0F35h

l149A_0F14:
	push	ax
	push	word ptr [si+8h]
	push	word ptr [si+6h]
	mov	cl,[si+0Bh]
	sub	ch,ch
	push	cx
	call	far 149Ah:212Eh
	add	sp,8h
	cmp	[bp-2h],ax
	jz	0F35h

l149A_0F2E:
	or	byte ptr [si+0Ah],20h
	mov	di,0FFFFh

l149A_0F35:
	mov	ax,[si+6h]
	mov	dx,[si+8h]
	mov	[si],ax
	mov	[si+2h],dx
	mov	word ptr [si+4h],0h
	mov	ax,di

l149A_0F47:
	pop	si
	pop	di
	mov	sp,bp
	pop	bp
	retf
149A:0F4D                                        90 B8 01              ...
149A:0F50 00 50 E8 01 00 CB                               .P....          

;; fn149A_0F56: 149A:0F56
;;   Called from:
;;     149A:0EE3 (in fn149A_0ECE)
fn149A_0F56 proc
	push	bp
	mov	bp,sp
	sub	sp,2h
	push	di
	push	si
	mov	si,31FEh
	sub	di,di
	mov	[bp-2h],di
	jmp	0F70h

l149A_0F68:
	mov	word ptr [bp-2h],0FFFFh

l149A_0F6D:
	add	si,0Ch

l149A_0F70:
	cmp	[33DEh],si
	jc	0F8Ch

l149A_0F76:
	test	byte ptr [si+0Ah],83h
	jz	0F6Dh

l149A_0F7C:
	push	ds
	push	si
	call	far 149Ah:0ECEh
	add	sp,4h
	inc	ax
	jz	0F68h

l149A_0F89:
	inc	di
	jmp	0F6Dh

l149A_0F8C:
	cmp	word ptr [bp+4h],1h
	jnz	0F96h

l149A_0F92:
	mov	ax,di
	jmp	0F99h

l149A_0F96:
	mov	ax,[bp-2h]

l149A_0F99:
	pop	si
	pop	di
	mov	sp,bp
	pop	bp
	ret	2h
149A:0FA1    90                                            .              

;; fn149A_0FA2: 149A:0FA2
;;   Called from:
;;     149A:091B (in fn149A_0904)
;;     149A:28B4 (in fn149A_2876)
fn149A_0FA2 proc
	push	bp
	mov	bp,sp
	mov	ax,1B4h
	call	far 149Ah:02C8h
	push	di
	push	si
	mov	byte ptr [bp-48h],0h
	sub	ax,ax
	mov	[bp-18h],ax
	mov	[bp-3Ah],ax

l149A_0FBB:
	les	bx,[bp+0Ah]
	cmp	byte ptr es:[bx],0h
	jnz	0FC7h

l149A_0FC4:
	jmp	1736h

l149A_0FC7:
	mov	bl,es:[bx]
	sub	bh,bh
	test	byte ptr [bx+3489h],8h
	jz	1000h

l149A_0FD3:
	dec	word ptr [bp-18h]
	lea	ax,[bp-18h]
	push	ss
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	17C2h
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	17A4h

l149A_0FEE:
	inc	word ptr [bp+0Ah]
	les	bx,[bp+0Ah]
	mov	bl,es:[bx]
	sub	bh,bh
	test	byte ptr [bx+3489h],8h
	jnz	0FEEh

l149A_1000:
	mov	bx,[bp+0Ah]
	cmp	byte ptr es:[bx],25h
	jz	100Ch

l149A_1009:
	jmp	170Eh

l149A_100C:
	mov	byte ptr [bp-40h],0h
	sub	al,al
	mov	[bp-4h],al
	mov	[bp-4Ah],al
	mov	[bp-0Eh],al
	mov	[bp-0Ah],al
	mov	[bp-12h],al
	mov	[bp+0FE52h],al
	sub	ax,ax
	mov	[bp-16h],ax
	mov	[bp-46h],ax
	mov	[bp-2h],ax
	mov	[bp-3Ch],ax
	mov	[bp-3Eh],ax
	jmp	10A0h
149A:1038                         90 90                           ..      

l149A_103A:
	inc	word ptr [bp+0Ah]
	les	bx,[bp+0Ah]
	mov	al,es:[bx]
	sub	ah,ah
	mov	di,ax
	test	byte ptr [di+3489h],4h
	jz	1068h

l149A_104E:
	inc	word ptr [bp-46h]
	mov	ax,[bp-2h]
	mov	cx,ax
	shl	ax,1h
	shl	ax,1h
	add	ax,cx
	shl	ax,1h
	add	ax,di
	sub	ax,30h
	mov	[bp-2h],ax
	jmp	10A0h

l149A_1068:
	cmp	ax,6Ch
	jz	1089h

l149A_106D:
	ja	109Ch

l149A_106F:
	cmp	al,4Ch
	jz	1086h

l149A_1073:
	jg	1094h

l149A_1075:
	sub	al,2Ah
	jz	108Eh

l149A_1079:
	sub	al,1Ch
	jz	10A0h

l149A_107D:
	jmp	109Ch
149A:107F                                              90                .

l149A_1080:
	inc	byte ptr [bp-4h]
	jmp	10A0h
149A:1085                90                                    .          

l149A_1086:
	inc	byte ptr [bp-0Ah]

l149A_1089:
	inc	byte ptr [bp-0Ah]
	jmp	10A0h

l149A_108E:
	inc	byte ptr [bp-12h]
	jmp	10A0h
149A:1093          90                                        .            

l149A_1094:
	sub	al,4Eh
	jz	10A0h

l149A_1098:
	sub	al,1Ah
	jz	1080h

l149A_109C:
	inc	byte ptr [bp+0FE52h]

l149A_10A0:
	cmp	byte ptr [bp+0FE52h],0h
	jz	103Ah

l149A_10A7:
	cmp	byte ptr [bp-12h],0h
	jnz	10C1h

l149A_10AD:
	les	bx,[bp+0Eh]
	add	word ptr [bp+0Eh],4h
	mov	ax,es:[bx]
	mov	dx,es:[bx+2h]
	mov	[bp-8h],ax
	mov	[bp-6h],dx

l149A_10C1:
	mov	byte ptr [bp+0FE52h],0h
	les	bx,[bp+0Ah]
	mov	al,es:[bx]
	or	al,20h
	sub	ah,ah
	mov	di,ax
	cmp	di,6Eh
	jz	1100h

l149A_10D7:
	cmp	di,63h
	jz	10F2h

l149A_10DC:
	cmp	di,7Bh
	jz	10F2h

l149A_10E1:
	lea	ax,[bp-18h]
	push	ss
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	17C2h
	jmp	10FEh
149A:10F1    90                                            .              

l149A_10F2:
	inc	word ptr [bp-18h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	1772h

l149A_10FE:
	mov	si,ax

l149A_1100:
	cmp	word ptr [bp-46h],0h
	jz	110Fh

l149A_1106:
	cmp	word ptr [bp-2h],0h
	jnz	110Fh

l149A_110C:
	jmp	16A2h

l149A_110F:
	mov	ax,di
	jmp	16C4h

l149A_1114:
	cmp	word ptr [bp-46h],0h
	jnz	1120h

l149A_111A:
	inc	word ptr [bp-46h]
	inc	word ptr [bp-2h]

l149A_1120:
	mov	word ptr [bp-44h],33F4h

l149A_1125:
	mov	[bp-42h],ds
	jmp	114Dh

l149A_112A:
	mov	word ptr [bp-44h],33EEh
	jmp	1125h
149A:1131    90                                            .              

l149A_1132:
	inc	word ptr [bp+0Ah]
	les	bx,[bp+0Ah]
	mov	[bp-44h],bx
	mov	[bp-42h],es
	cmp	byte ptr es:[bx],5Eh
	jnz	1150h

l149A_1144:
	lea	ax,[bx+1h]
	mov	[bp-44h],ax
	mov	[bp-42h],es

l149A_114D:
	dec	byte ptr [bp-4Ah]

l149A_1150:
	mov	ax,20h
	push	ax
	sub	ax,ax
	push	ax
	lea	ax,[bp-38h]
	push	ss
	push	ax
	call	far 149Ah:2A3Ch
	add	sp,8h
	cmp	di,7Bh
	jz	116Ch

l149A_1169:
	jmp	121Fh

l149A_116C:
	les	bx,[bp-44h]
	cmp	byte ptr es:[bx],5Dh
	jz	1178h

l149A_1175:
	jmp	121Fh

l149A_1178:
	mov	byte ptr [bp-40h],5Dh
	inc	word ptr [bp-44h]
	mov	byte ptr [bp-2Dh],20h
	jmp	121Fh

l149A_1186:
	mov	al,es:[bx]
	mov	[bp-0Ch],al
	inc	word ptr [bp-44h]
	cmp	al,2Dh
	jnz	11A2h

l149A_1193:
	cmp	byte ptr [bp-40h],0h
	jz	11A2h

l149A_1199:
	mov	bx,[bp-44h]
	cmp	byte ptr es:[bx],5Dh
	jnz	11C6h

l149A_11A2:
	mov	bl,[bp-0Ch]
	mov	[bp-40h],bl
	mov	al,1h
	mov	cl,bl
	and	cl,7h
	mov	dx,cx
	mov	cl,dl
	shl	al,cl
	mov	cl,3h
	shr	bl,cl
	sub	bh,bh
	lea	cx,[bp-38h]
	add	bx,cx
	or	ss:[bx],al
	jmp	121Fh
149A:11C5                90                                    .          

l149A_11C6:
	inc	word ptr [bp-44h]
	mov	al,es:[bx]
	mov	[bp-0Ch],al
	cmp	al,[bp-40h]
	jbe	11DAh

l149A_11D4:
	mov	[bp-10h],al
	jmp	11E6h
149A:11D9                            90                            .      

l149A_11DA:
	mov	al,[bp-40h]
	mov	[bp-10h],al
	mov	al,[bp-0Ch]
	mov	[bp-40h],al

l149A_11E6:
	mov	al,[bp-40h]
	mov	[bp-0Ch],al
	jmp	120Fh

l149A_11EE:
	mov	bl,[bp-0Ch]
	mov	al,1h
	mov	cl,bl
	and	cl,7h
	mov	dx,cx
	mov	cl,dl
	shl	al,cl
	mov	cl,3h
	shr	bl,cl
	sub	bh,bh
	lea	cx,[bp-38h]
	add	bx,cx
	or	ss:[bx],al
	inc	byte ptr [bp-0Ch]

l149A_120F:
	mov	al,[bp-10h]
	cbw
	mov	cl,[bp-0Ch]
	sub	ch,ch
	cmp	ax,cx
	jge	11EEh

l149A_121C:
	mov	[bp-40h],ch

l149A_121F:
	les	bx,[bp-44h]
	cmp	byte ptr es:[bx],5Dh
	jz	122Bh

l149A_1228:
	jmp	1186h

l149A_122B:
	cmp	byte ptr es:[bx],0h
	jnz	1234h

l149A_1231:
	jmp	1736h

l149A_1234:
	cmp	di,7Bh
	jnz	1243h

l149A_1239:
	mov	ax,bx
	mov	dx,es
	mov	[bp+0Ah],ax
	mov	[bp+0Ch],dx

l149A_1243:
	mov	ax,[bp-8h]
	mov	dx,[bp-6h]
	mov	[bp+0FE54h],ax
	mov	[bp+0FE56h],dx

l149A_1251:
	cmp	word ptr [bp-46h],0h
	jz	1261h

l149A_1257:
	mov	ax,[bp-2h]
	dec	word ptr [bp-2h]
	or	ax,ax
	jz	12B0h

l149A_1261:
	cmp	si,0FFh
	jz	12B0h

l149A_1266:
	mov	bx,si
	mov	cl,3h
	sar	bx,cl
	lea	ax,[bp-38h]
	add	bx,ax
	mov	al,ss:[bx]
	xor	al,[bp-4Ah]
	cbw
	mov	dx,1h
	mov	cx,si
	mov	bx,cx
	and	cl,7h
	shl	dx,cl
	test	dx,ax
	jz	12B0h

l149A_1288:
	cmp	byte ptr [bp-12h],0h
	jnz	129Ch

l149A_128E:
	mov	ax,si
	les	bx,[bp-8h]
	inc	word ptr [bp-8h]
	mov	es:[bx],al
	jmp	12A0h
149A:129B                                  90                        .    

l149A_129C:
	inc	word ptr [bp+0FE54h]

l149A_12A0:
	inc	word ptr [bp-18h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	1772h
	mov	si,ax
	jmp	1251h

l149A_12B0:
	dec	word ptr [bp-18h]
	push	si
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	17A4h
	mov	ax,[bp-8h]
	mov	dx,[bp-6h]
	cmp	[bp+0FE54h],ax
	jnz	12D2h

l149A_12C9:
	cmp	[bp+0FE56h],dx
	jnz	12D2h

l149A_12CF:
	jmp	1736h

l149A_12D2:
	cmp	byte ptr [bp-12h],0h
	jz	12DBh

l149A_12D8:
	jmp	1706h

l149A_12DB:
	inc	word ptr [bp-3Ah]
	cmp	di,63h
	jnz	12E6h

l149A_12E3:
	jmp	1706h

l149A_12E6:
	mov	es,dx
	mov	bx,ax
	mov	byte ptr es:[bx],0h
	jmp	1706h
149A:12F1    90                                            .              

l149A_12F2:
	mov	di,64h

l149A_12F5:
	cmp	si,2Dh
	jnz	1300h

l149A_12FA:
	inc	byte ptr [bp-0Eh]
	jmp	1305h
149A:12FF                                              90                .

l149A_1300:
	cmp	si,2Bh
	jnz	1324h

l149A_1305:
	dec	word ptr [bp-2h]
	jnz	1316h

l149A_130A:
	cmp	word ptr [bp-46h],0h
	jz	1316h

l149A_1310:
	inc	byte ptr [bp+0FE52h]
	jmp	1324h

l149A_1316:
	inc	word ptr [bp-18h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	1772h
	mov	si,ax

l149A_1324:
	cmp	si,30h
	jz	132Ch

l149A_1329:
	jmp	1483h

l149A_132C:
	inc	word ptr [bp-18h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	1772h
	mov	si,ax
	cmp	al,78h
	jz	1342h

l149A_133E:
	cmp	al,58h
	jnz	1356h

l149A_1342:
	inc	word ptr [bp-18h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	1772h
	mov	si,ax
	mov	di,78h
	jmp	1483h

l149A_1356:
	inc	word ptr [bp-16h]
	cmp	di,78h
	jz	1364h

l149A_135E:
	mov	di,6Fh
	jmp	1483h

l149A_1364:
	dec	word ptr [bp-18h]
	push	si
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	17A4h
	mov	si,30h
	jmp	1483h
149A:1377                      90                                .        

l149A_1378:
	cmp	byte ptr [bp-4h],0h
	jnz	1384h

l149A_137E:
	inc	byte ptr [bp-0Ah]
	mov	di,46h

l149A_1384:
	cmp	si,2Dh
	jnz	138Eh

l149A_1389:
	inc	byte ptr [bp-0Eh]
	jmp	1396h

l149A_138E:
	cmp	si,2Bh
	jz	1396h

l149A_1393:
	jmp	1483h

l149A_1396:
	dec	word ptr [bp-2h]
	jz	139Eh

l149A_139B:
	jmp	1433h

l149A_139E:
	cmp	word ptr [bp-46h],0h
	jnz	13A7h

l149A_13A4:
	jmp	1433h

l149A_13A7:
	inc	byte ptr [bp+0FE52h]
	jmp	1483h

l149A_13AE:
	cmp	di,78h
	jz	13C0h

l149A_13B3:
	cmp	di,70h
	jz	13C0h

l149A_13B8:
	cmp	di,46h
	jz	13C0h

l149A_13BD:
	jmp	1444h

l149A_13C0:
	test	byte ptr [si+3489h],80h
	jz	13DCh

l149A_13C7:
	mov	al,4h
	push	ax
	lea	ax,[bp-3Eh]
	push	ss
	push	ax
	call	far 149Ah:3690h
	push	si
	call	1754h
	mov	si,ax
	jmp	1411h

l149A_13DC:
	cmp	di,46h
	jnz	140Dh

l149A_13E1:
	cmp	word ptr [bp-16h],0h
	jz	140Dh

l149A_13E7:
	cmp	si,3Ah
	jnz	1408h

l149A_13EC:
	mov	ax,[bp-3Eh]
	mov	[bp-14h],ax
	sub	ax,ax
	mov	[bp-3Ch],ax
	mov	[bp-3Eh],ax
	mov	word ptr [bp-16h],0FFFFh
	mov	di,70h
	mov	si,30h
	jmp	1411h
149A:1407                      90                                .        

l149A_1408:
	mov	word ptr [bp-16h],0h

l149A_140D:
	inc	byte ptr [bp+0FE52h]

l149A_1411:
	cmp	byte ptr [bp+0FE52h],0h
	jnz	1476h

l149A_1418:
	inc	word ptr [bp-16h]
	lea	ax,[si-30h]
	cwd
	add	[bp-3Eh],ax
	adc	[bp-3Ch],dx
	cmp	word ptr [bp-46h],0h
	jz	1433h

l149A_142B:
	dec	word ptr [bp-2h]
	jnz	1433h

l149A_1430:
	jmp	13A7h

l149A_1433:
	inc	word ptr [bp-18h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	1772h
	mov	si,ax
	jmp	1483h
149A:1443          90                                        .            

l149A_1444:
	test	byte ptr [si+3489h],4h
	jz	140Dh

l149A_144B:
	cmp	di,6Fh
	jnz	1464h

l149A_1450:
	cmp	si,38h
	jge	140Dh

l149A_1455:
	mov	al,3h
	push	ax
	lea	ax,[bp-3Eh]
	push	ss
	push	ax
	call	far 149Ah:3690h
	jmp	1411h

l149A_1464:
	mov	ax,0Ah
	cwd
	push	dx
	push	ax
	lea	ax,[bp-3Eh]
	push	ss
	push	ax
	call	far 149Ah:366Eh
	jmp	1411h

l149A_1476:
	dec	word ptr [bp-18h]
	push	si
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	17A4h

l149A_1483:
	cmp	byte ptr [bp+0FE52h],0h
	jnz	148Dh

l149A_148A:
	jmp	13AEh

l149A_148D:
	cmp	di,70h
	jnz	14A1h

l149A_1492:
	cmp	byte ptr [bp-0Ah],0h
	jz	14A1h

l149A_1498:
	mov	ax,[bp-14h]
	mov	cx,[bp-3Eh]
	mov	[bp-3Ch],ax

l149A_14A1:
	cmp	byte ptr [bp-0Eh],0h
	jz	14B1h

l149A_14A7:
	neg	word ptr [bp-3Eh]
	adc	word ptr [bp-3Ch],0h
	neg	word ptr [bp-3Ch]

l149A_14B1:
	cmp	di,46h
	jnz	14BBh

l149A_14B6:
	mov	word ptr [bp-16h],0h

l149A_14BB:
	cmp	word ptr [bp-16h],0h
	jnz	14C4h

l149A_14C1:
	jmp	1736h

l149A_14C4:
	cmp	byte ptr [bp-12h],0h
	jz	14CDh

l149A_14CA:
	jmp	1706h

l149A_14CD:
	inc	word ptr [bp-3Ah]

l149A_14D0:
	cmp	byte ptr [bp-0Ah],0h
	jz	14EAh

l149A_14D6:
	mov	ax,[bp-3Eh]
	mov	dx,[bp-3Ch]
	les	bx,[bp-8h]
	mov	es:[bx],ax
	mov	es:[bx+2h],dx
	jmp	1706h
149A:14E9                            90                            .      

l149A_14EA:
	mov	ax,[bp-3Eh]
	les	bx,[bp-8h]
	mov	es:[bx],ax
	jmp	1706h

l149A_14F6:
	mov	ax,[bp-18h]
	cwd
	mov	[bp-3Eh],ax
	mov	[bp-3Ch],dx
	jmp	14D0h

l149A_1502:
	lea	ax,[bp+0FE58h]
	mov	[bp-44h],ax
	mov	[bp-42h],ss
	cmp	si,2Dh
	jnz	1524h

l149A_1511:
	mov	bx,ax
	mov	byte ptr ss:[bx],2Dh
	lea	ax,[bp+0FE59h]
	mov	[bp-44h],ax
	mov	[bp-42h],ss
	jmp	1529h
149A:1523          90                                        .            

l149A_1524:
	cmp	si,2Bh
	jnz	153Ah

l149A_1529:
	dec	word ptr [bp-2h]
	inc	word ptr [bp-18h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	1772h
	mov	si,ax

l149A_153A:
	cmp	word ptr [bp-46h],0h
	jz	1547h

l149A_1540:
	cmp	word ptr [bp-2h],15Dh
	jle	1574h

l149A_1547:
	mov	word ptr [bp-2h],15Dh
	jmp	1574h

l149A_154E:
	mov	ax,[bp-2h]
	dec	word ptr [bp-2h]
	or	ax,ax
	jz	157Bh

l149A_1558:
	inc	word ptr [bp-16h]
	mov	ax,si
	les	bx,[bp-44h]
	inc	word ptr [bp-44h]
	mov	es:[bx],al
	inc	word ptr [bp-18h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	1772h
	mov	si,ax

l149A_1574:
	test	byte ptr [si+3489h],4h
	jnz	154Eh

l149A_157B:
	cmp	si,2Eh
	jnz	15C3h

l149A_1580:
	mov	ax,[bp-2h]
	dec	word ptr [bp-2h]
	or	ax,ax
	jz	15C3h

l149A_158A:
	les	bx,[bp-44h]
	inc	word ptr [bp-44h]
	mov	byte ptr es:[bx],2Eh
	jmp	15AEh

l149A_1596:
	mov	ax,[bp-2h]
	dec	word ptr [bp-2h]
	or	ax,ax
	jz	15C3h

l149A_15A0:
	inc	word ptr [bp-16h]
	mov	ax,si
	les	bx,[bp-44h]
	inc	word ptr [bp-44h]
	mov	es:[bx],al

l149A_15AE:
	inc	word ptr [bp-18h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	1772h
	mov	si,ax
	test	byte ptr [si+3489h],4h
	jnz	1596h

l149A_15C3:
	cmp	word ptr [bp-16h],0h
	jnz	15CCh

l149A_15C9:
	jmp	164Dh

l149A_15CC:
	mov	ax,si
	cmp	al,65h
	jz	15D6h

l149A_15D2:
	cmp	al,45h
	jnz	164Dh

l149A_15D6:
	mov	ax,[bp-2h]
	dec	word ptr [bp-2h]
	or	ax,ax
	jz	164Dh

l149A_15E0:
	les	bx,[bp-44h]
	inc	word ptr [bp-44h]
	mov	byte ptr es:[bx],65h
	inc	word ptr [bp-18h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	1772h
	mov	si,ax
	cmp	si,2Dh
	jnz	160Ch

l149A_15FD:
	les	bx,[bp-44h]
	inc	word ptr [bp-44h]
	mov	byte ptr es:[bx],2Dh
	jmp	1611h
149A:1609                            90 90 90                      ...    

l149A_160C:
	cmp	si,2Bh
	jnz	1646h

l149A_1611:
	mov	ax,[bp-2h]
	dec	word ptr [bp-2h]
	or	ax,ax
	jnz	1638h

l149A_161B:
	inc	word ptr [bp-2h]
	jmp	1646h

l149A_1620:
	mov	ax,[bp-2h]
	dec	word ptr [bp-2h]
	or	ax,ax
	jz	164Dh

l149A_162A:
	inc	word ptr [bp-16h]
	mov	ax,si
	les	bx,[bp-44h]
	inc	word ptr [bp-44h]
	mov	es:[bx],al

l149A_1638:
	inc	word ptr [bp-18h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	1772h
	mov	si,ax

l149A_1646:
	test	byte ptr [si+3489h],4h
	jnz	1620h

l149A_164D:
	dec	word ptr [bp-18h]
	push	si
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	17A4h
	cmp	word ptr [bp-16h],0h
	jnz	1663h

l149A_1660:
	jmp	1736h

l149A_1663:
	cmp	byte ptr [bp-12h],0h
	jz	166Ch

l149A_1669:
	jmp	1706h

l149A_166C:
	inc	word ptr [bp-3Ah]
	les	bx,[bp-44h]
	mov	byte ptr es:[bx],0h
	lea	ax,[bp+0FE58h]
	push	ss
	push	ax
	push	word ptr [bp-6h]
	push	word ptr [bp-8h]
	mov	al,[bp-0Ah]
	cbw
	push	ax
	mov	es,[37BAh]
	call	dword ptr es:[3472h]
	add	sp,0Ah
	jmp	1706h
149A:1695                90                                    .          

l149A_1696:
	les	bx,[bp+0Ah]
	mov	al,es:[bx]
	sub	ah,ah
	cmp	ax,si
	jz	16B4h

l149A_16A2:
	dec	word ptr [bp-18h]
	push	si
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	17A4h
	jmp	1736h
149A:16B2       90 90                                       ..            

l149A_16B4:
	dec	byte ptr [bp-48h]
	cmp	byte ptr [bp-12h],0h
	jnz	1706h

l149A_16BD:
	sub	word ptr [bp+0Eh],4h
	jmp	1706h
149A:16C3          90                                        .            

l149A_16C4:
	sub	ax,63h
	cmp	ax,18h
	ja	1696h

l149A_16CC:
	shl	ax,1h
	xchg	bx,ax
	jmp	word ptr cs:[bx+16D4h]
l149A_16D4	dw	0x1114
l149A_16D6	dw	0x1384
l149A_16D8	dw	0x1502
l149A_16DA	dw	0x1502
l149A_16DC	dw	0x1502
l149A_16DE	dw	0x1696
l149A_16E0	dw	0x12F2
l149A_16E2	dw	0x1696
l149A_16E4	dw	0x1696
l149A_16E6	dw	0x1696
l149A_16E8	dw	0x1696
l149A_16EA	dw	0x14F6
l149A_16EC	dw	0x1384
l149A_16EE	dw	0x1378
l149A_16F0	dw	0x1696
l149A_16F2	dw	0x1696
l149A_16F4	dw	0x112A
l149A_16F6	dw	0x1696
l149A_16F8	dw	0x1384
l149A_16FA	dw	0x1696
l149A_16FC	dw	0x1696
l149A_16FE	dw	0x12F5
l149A_1700	dw	0x1696
l149A_1702	dw	0x1696
l149A_1704	dw	0x1132

l149A_1706:
	inc	byte ptr [bp-48h]
	inc	word ptr [bp+0Ah]
	jmp	172Eh

l149A_170E:
	inc	word ptr [bp-18h]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	1772h
	mov	si,ax
	les	bx,[bp+0Ah]
	inc	word ptr [bp+0Ah]
	mov	al,es:[bx]
	sub	ah,ah
	cmp	si,ax
	jz	172Eh

l149A_172B:
	jmp	16A2h

l149A_172E:
	cmp	si,0FFh
	jz	1736h

l149A_1733:
	jmp	0FBBh

l149A_1736:
	cmp	si,0FFh
	jnz	1747h

l149A_173B:
	cmp	word ptr [bp-3Ah],0h
	jnz	1747h

l149A_1741:
	cmp	byte ptr [bp-48h],0h
	jz	174Ch

l149A_1747:
	mov	ax,[bp-3Ah]
	jmp	174Eh

l149A_174C:
	mov	ax,si

l149A_174E:
	pop	si
	pop	di
	mov	sp,bp
	pop	bp
	retf

;; fn149A_1754: 149A:1754
;;   Called from:
;;     149A:13D5 (in fn149A_0FA2)
fn149A_1754 proc
	push	bp
	mov	bp,sp
	mov	bx,[bp+4h]
	test	byte ptr [bx+3489h],4h
	jz	1766h

l149A_1761:
	mov	ax,bx
	jmp	176Dh
149A:1765                90                                    .          

l149A_1766:
	mov	ax,bx
	and	al,0DFh
	sub	ax,7h

l149A_176D:
	pop	bp
	ret	2h
149A:1771    90                                            .              

;; fn149A_1772: 149A:1772
;;   Called from:
;;     149A:10FB (in fn149A_0FA2)
;;     149A:12A9 (in fn149A_0FA2)
;;     149A:131F (in fn149A_0FA2)
;;     149A:1335 (in fn149A_0FA2)
;;     149A:134B (in fn149A_0FA2)
;;     149A:143C (in fn149A_0FA2)
;;     149A:1535 (in fn149A_0FA2)
;;     149A:156F (in fn149A_0FA2)
;;     149A:15B7 (in fn149A_0FA2)
;;     149A:15F3 (in fn149A_0FA2)
;;     149A:1641 (in fn149A_0FA2)
;;     149A:1717 (in fn149A_0FA2)
;;     149A:17D2 (in fn149A_17C2)
fn149A_1772 proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	les	bx,[bp+4h]
	dec	word ptr es:[bx+4h]
	js	1796h

l149A_1781:
	mov	ax,es:[bx]
	mov	dx,es:[bx+2h]
	inc	word ptr es:[bx]
	mov	bx,ax
	mov	es,dx
	mov	al,es:[bx]
	sub	ah,ah
	jmp	179Dh

l149A_1796:
	push	es
	push	bx
	call	far 149Ah:0B00h

l149A_179D:
	mov	sp,bp
	pop	bp
	ret	4h
149A:17A3          90                                        .            

;; fn149A_17A4: 149A:17A4
;;   Called from:
;;     149A:0FEB (in fn149A_0FA2)
;;     149A:12BA (in fn149A_0FA2)
;;     149A:136E (in fn149A_0FA2)
;;     149A:1480 (in fn149A_0FA2)
;;     149A:1657 (in fn149A_0FA2)
;;     149A:16AC (in fn149A_0FA2)
fn149A_17A4 proc
	push	bp
	mov	bp,sp
	cmp	word ptr [bp+8h],0FFh
	jz	17BBh

l149A_17AD:
	push	word ptr [bp+6h]
	push	word ptr [bp+4h]
	push	word ptr [bp+8h]
	call	far 149Ah:1D5Eh

l149A_17BB:
	mov	sp,bp
	pop	bp
	ret	6h
149A:17C1    90                                            .              

;; fn149A_17C2: 149A:17C2
;;   Called from:
;;     149A:0FE1 (in fn149A_0FA2)
;;     149A:10EC (in fn149A_0FA2)
fn149A_17C2 proc
	push	bp
	mov	bp,sp
	push	si

l149A_17C6:
	les	bx,[bp+8h]
	inc	word ptr es:[bx]
	push	word ptr [bp+6h]
	push	word ptr [bp+4h]
	call	1772h
	mov	si,ax
	test	byte ptr [si+3489h],8h
	jnz	17C6h

l149A_17DE:
	pop	si
	mov	sp,bp
	pop	bp
	ret	8h
149A:17E5                90 4E 18 59 18 6F 18 A3 18 CF 18      .N.Y.o.....
149A:17F0 D7 18 00 19 32 19                               ....2.          

;; fn149A_17F6: 149A:17F6
;;   Called from:
;;     149A:0774 (in fn149A_0752)
;;     149A:0AE0 (in fn149A_0ABC)
;;     149A:2841 (in fn149A_280A)
fn149A_17F6 proc
	push	bp
	mov	bp,sp
	mov	ax,171h
	push	cs
	call	02C8h
	push	si
	push	di
	xor	ax,ax
	mov	[bp-8h],ax
	mov	[bp-5h],al
	les	si,[bp+0Ah]
	lodsb	al,es:[si]
	mov	[bp+0Ah],si
	mov	[bp-2h],al
	or	al,al
	jz	181Fh

l149A_1819:
	cmp	word ptr [bp-8h],0h
	jge	1825h

l149A_181F:
	mov	ax,[bp-8h]
	jmp	1CDAh

l149A_1825:
	mov	bx,33F6h
	sub	al,20h
	cmp	al,58h
	ja	1833h

l149A_182E:
	xlat
	and	al,0Fh
	jmp	1835h

l149A_1833:
	mov	al,0h

l149A_1835:
	mov	cl,3h
	shl	al,cl
	add	al,[bp-5h]
	xlat
	inc	cl
	shr	al,cl
	mov	[bp-5h],al
	cbw
	mov	bx,ax
	shl	bx,1h
	jmp	word ptr cs:[bx+17E6h]
149A:184E                                           8A 56               .V
149A:1850 FE B9 01 00 E8 36 04 EB B1 33 C0 89 46 F0 89 46 .....6...3..F..F
149A:1860 F6 89 46 EE C7 46 FC 20 00 48 89 46 F4 EB 9B 8A ..F..F. .H.F....
149A:1870 46 FE 3C 2D 75 06 80 4E FC 04 EB 8E 3C 2B 75 06 F.<-u..N....<+u.
149A:1880 80 4E FC 01 EB 84 3C 20 75 07 80 4E FC 02 E9 79 .N....< u..N...y
149A:1890 FF 3C 23 75 07 80 4E FC 80 E9 6E FF 80 4E FC 08 .<#u..N...n..N..
149A:18A0 E9 67 FF 8A 4E FE 80 F9 2A 75 0F E8 5C 03 0B C0 .g..N...*u..\...
149A:18B0 79 17 F7 D8 80 4E FC 04 EB 0F 80 E9 30 32 ED 8B y....N......02..
149A:18C0 46 F6 BB 0A 00 F7 E3 03 C1 89 46 F6 E9 3B FF C7 F.........F..;..
149A:18D0 46 F4 00 00 E9 33 FF 8A 4E FE 80 F9 2A 75 0C E8 F....3..N...*u..
149A:18E0 28 03 0B C0 79 14 B8 FF FF EB 0F 80 E9 30 32 ED (...y........02.
149A:18F0 8B 46 F4 BB 0A 00 F7 E3 03 C1 89 46 F4 E9 0A FF .F.........F....
149A:1900 8A 46 FE 3C 6C 75 06 80 4E FC 10 EB 22 3C 46 75 .F.<lu..N..."<Fu
149A:1910 06 80 4E FC 20 EB 18 3C 4E 75 06 80 4E FD 10 EB ..N. ..<Nu..N...
149A:1920 0E 3C 4C 75 06 80 4E FD 04 EB 04 80 4E FD 08 E9 .<Lu..N.....N...
149A:1930 D8 FE 8A 46 FE 3C 64 75 03 E9 94 01 3C 69 75 03 ...F.<du....<iu.
149A:1940 E9 8D 01 3C 75 75 03 E9 8A 01 3C 58 75 03 E9 89 ...<uu....<Xu...
149A:1950 01 3C 78 75 03 E9 88 01 3C 6F 75 03 E9 A2 01 3C .<xu....<ou....<
149A:1960 63 74 1A 3C 73 74 27 3C 6E 74 51 3C 70 74 60 3C ct.<st'<ntQ<pt`<
149A:1970 45 74 07 3C 47 74 03 E9 BB 00 E9 B5 00 E8 8A 02 Et.<Gt..........
149A:1980 8D BE 8F FE 16 07 AA 4F B9 01 00 E9 F1 01 E8 90 .......O........
149A:1990 02 0B FF 75 12 8C C0 0B C0 75 0C 1E 07 BF 4F 34 ...u.....u....O4
149A:19A0 8B 0E 55 34 E9 D8 01 57 8B 4E F4 E3 07 32 C0 F2 ..U4...W.N...2..
149A:19B0 AE 75 01 4F 59 2B F9 87 CF E9 C3 01 E8 62 02 8B .u.OY+.......b..
149A:19C0 46 F8 AB F6 46 FC 10 74 03 33 C0 AB E9 3B FE F6 F...F..t.3...;..
149A:19D0 46 FC 30 75 05 E8 32 02 EB 39 E8 36 02 F6 46 FD F.0u..2..9.6..F.
149A:19E0 18 75 30 C6 46 FF 07 B9 10 00 16 07 52 33 D2 8D .u0.F.......R3..
149A:19F0 BE 97 FE BE 04 00 E8 B0 02 B9 10 00 8D BE 92 FE ................
149A:1A00 58 33 D2 BE 04 00 E8 A0 02 C6 86 93 FE 3A B9 09 X3...........:..
149A:1A10 00 EB 18 C6 46 FF 07 B9 10 00 16 07 33 D2 8D BE ....F.......3...
149A:1A20 92 FE BE 04 00 E8 81 02 B9 04 00 8D BE 8F FE E9 ................
149A:1A30 4D 01 FF 46 EE 80 4E FC 40 8A 46 FE 0C 20 98 8B M..F..N.@.F.. ..
149A:1A40 F0 83 7E F4 00 7F 13 74 07 C7 46 F4 06 00 EB 0A ..~....t..F.....
149A:1A50 3D 67 00 75 05 C7 46 F4 01 00 8D BE 8F FE FF 76 =g.u..F........v
149A:1A60 EE FF 76 F4 56 16 57 FF 76 10 FF 76 0E F6 46 FD ..v.V.W.v..v..F.
149A:1A70 04 74 0A FF 1E 7E 34 83 46 0E 0A EB 08 FF 1E 6A .t...~4.F......j
149A:1A80 34 83 46 0E 08 83 C4 0E F6 46 FC 80 74 0F 83 7E 4.F......F..t..~
149A:1A90 F4 00 75 09 16 57 FF 1E 76 34 83 C4 04 83 FE 67 ..u..W..v4.....g
149A:1AA0 75 10 F7 46 FC 80 00 75 09 16 57 FF 1E 6E 34 83 u..F...u..W..n4.
149A:1AB0 C4 04 16 07 26 80 3D 2D 75 05 47 80 4E FD 01 B9 ....&.=-u.G.N...
149A:1AC0 FF FF 57 B0 00 F2 AE 4F 59 2B F9 87 CF E9 AF 00 ..W....OY+......
149A:1AD0 80 4E FC 40 C6 46 FA 0A EB 35 C6 46 FF 07 EB 04 .N.@.F...5.F....
149A:1AE0 C6 46 FF 27 F6 46 FC 80 74 11 C7 46 F0 02 00 C6 .F.'.F..t..F....
149A:1AF0 46 F2 30 B2 51 02 56 FF 88 56 F3 C6 46 FA 10 EB F.0.Q.V..V..F...
149A:1B00 0E F6 46 FC 80 74 04 80 4E FD 02 C6 46 FA 08 F6 ..F..t..N...F...
149A:1B10 46 FC 10 74 05 E8 FB 00 EB 0E E8 ED 00 F6 46 FC F..t..........F.
149A:1B20 40 74 03 99 EB 02 33 D2 F6 46 FC 40 74 0F 0B D2 @t....3..F.@t...
149A:1B30 7D 0B 80 4E FD 01 F7 D8 83 D2 00 F7 DA 83 7E F4 }..N..........~.
149A:1B40 00 7D 07 C7 46 F4 01 00 EB 04 80 66 FC F7 8B D8 .}..F......f....
149A:1B50 0B DA 75 05 C7 46 F0 00 00 8D 7E EB 16 07 8A 4E ..u..F....~....N
149A:1B60 FA 32 ED 8B 76 F4 E8 40 01 F6 46 FD 02 74 0E E3 .2..v..@..F..t..
149A:1B70 06 26 80 3D 30 74 06 4F 26 C6 05 30 41 EB 00 F6 .&.=0t.O&..0A...
149A:1B80 46 FC 40 74 31 F6 46 FD 01 74 0B C6 46 F2 2D C7 F.@t1.F..t..F.-.
149A:1B90 46 F0 01 00 EB 20 F6 46 FC 01 74 0B C6 46 F2 2B F.... .F..t..F.+
149A:1BA0 C7 46 F0 01 00 EB 0F F6 46 FC 02 74 09 C6 46 F2 .F......F..t..F.
149A:1BB0 20 C7 46 F0 01 00 8B 46 F6 2B C1 2B 46 F0 7D 02  .F....F.+.+F.}.
149A:1BC0 33 C0 06 57 51 F6 46 FC 0C 75 07 8B C8 B2 20 E8 3..WQ.F..u.... .
149A:1BD0 BB 00 50 16 07 8D 7E F2 8B 4E F0 E8 91 00 58 F6 ..P...~..N....X.
149A:1BE0 46 FC 08 74 0D F6 46 FC 04 75 07 8B C8 B2 30 E8 F..t..F..u....0.
149A:1BF0 9B 00 59 5F 07 50 E8 76 00 58 F6 46 FC 04 74 07 ..Y_.P.v.X.F..t.
149A:1C00 8B C8 B2 20 E8 86 00 E9 00 FC C4 76 0E 26 AD 89 ... .......v.&..
149A:1C10 76 0E C3 C4 76 0E 26 AD 8B D0 26 AD 92 89 76 0E v...v.&...&...v.
149A:1C20 C3 F6 46 FC 20 74 08 E8 E9 FF 8E C2 8B F8 C3 E8 ..F. t..........
149A:1C30 D8 FF 8B F8 0B C0 75 03 8E C0 C3 1E 07 C3 98 06 ......u.........
149A:1C40 57 C4 5E 06 26 FF 4F 04 78 10 26 8B 3F 26 FF 07 W.^.&.O.x.&.?&..
149A:1C50 26 8E 47 02 AA 33 C0 5F 07 C3 51 52 06 53 50 0E &.G..3._..QR.SP.
149A:1C60 E8 39 EF 83 C4 06 5A 59 3D FF FF 75 E8 EB E8 E3 .9....ZY=..u....
149A:1C70 1B 8B F7 01 4E F8 57 33 FF 26 AC E8 C0 FF 0B F8 ....N.W3.&......
149A:1C80 E2 F7 0B FF 5F 74 05 C7 46 F8 FF FF C3 E3 19 01 ...._t..F.......
149A:1C90 4E F8 57 33 FF 8A C2 E8 A4 FF 0B F8 E2 F7 0B FF N.W3............
149A:1CA0 5F 74 05 C7 46 F8 FF FF C3 FD 57 93 0B F6 7F 0A _t..F.....W.....
149A:1CB0 0B DB 75 06 0B D2 75 02 EB 1A 92 33 D2 F7 F1 93 ..u...u....3....
149A:1CC0 F7 F1 92 87 D3 04 30 3C 39 76 03 02 46 FF AA 8B ......0<9v..F...
149A:1CD0 C2 4E EB D8 59 2B CF 47 FC C3                   .N..Y+.G..      

l149A_1CDA:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf

;; fn149A_1CE0: 149A:1CE0
;;   Called from:
;;     149A:0708 (in fn149A_0702)
fn149A_1CE0 proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	push	si
	mov	si,31FEh
	sub	ax,ax
	mov	[bp-2h],ax
	mov	[bp-4h],ax
	jmp	1CF7h

l149A_1CF4:
	add	si,0Ch

l149A_1CF7:
	cmp	[33DEh],si
	jc	1D23h

l149A_1CFD:
	test	byte ptr [si+0Ah],83h
	jnz	1CF4h

l149A_1D03:
	mov	word ptr [si+4h],0h
	mov	byte ptr [si+0Ah],0h
	sub	ax,ax
	mov	[si+8h],ax
	mov	[si+6h],ax
	mov	[si+2h],ax
	mov	[si],ax
	mov	byte ptr [si+0Bh],0FFh
	mov	[bp-4h],si
	mov	[bp-2h],ds

l149A_1D23:
	mov	ax,[bp-4h]
	mov	dx,[bp-2h]
	pop	si
	mov	sp,bp
	pop	bp
	retf
149A:1D2E                                           55 8B               U.
149A:1D30 EC BB 0A 32 EB 06                               ...2..          

;; fn149A_1D36: 149A:1D36
;;   Called from:
;;     0800:76D7 (in fn0800_75E1)
fn149A_1D36 proc
	push	bp
	mov	bp,sp
	mov	bx,[bp+8h]
	dec	word ptr [bx+4h]
	js	1D50h

l149A_1D41:
	inc	word ptr [bx]
	les	bx,[bx]
	mov	al,[bp+6h]
	mov	es:[bx-1h],al
	xor	ah,ah
	jmp	1D5Ch

l149A_1D50:
	push	ds
	push	bx
	push	word ptr [bp+6h]
	push	cs
	call	0B9Ch
	add	sp,6h

l149A_1D5C:
	pop	bp
	retf

;; fn149A_1D5E: 149A:1D5E
;;   Called from:
;;     149A:17B6 (in fn149A_17A4)
fn149A_1D5E proc
	push	bp
	mov	bp,sp
	push	di
	push	si
	mov	si,[bp+6h]
	mov	di,[bp+8h]
	cmp	si,0FFh
	jz	1D80h

l149A_1D6E:
	test	byte ptr [di+0Ah],1h
	jnz	1D86h

l149A_1D74:
	test	byte ptr [di+0Ah],80h
	jz	1D80h

l149A_1D7A:
	test	byte ptr [di+0Ah],2h
	jz	1D86h

l149A_1D80:
	mov	ax,0FFFFh
	jmp	1DC3h
149A:1D85                90                                    .          

l149A_1D86:
	mov	ax,[di+8h]
	or	ax,[di+6h]
	jnz	1D96h

l149A_1D8E:
	push	ds
	push	di
	call	0CC0h
	add	sp,4h

l149A_1D96:
	mov	ax,[di]
	mov	dx,[di+2h]
	cmp	[di+6h],ax
	jnz	1DADh

l149A_1DA0:
	cmp	[di+8h],dx
	jnz	1DADh

l149A_1DA5:
	cmp	word ptr [di+4h],0h
	jnz	1D80h

l149A_1DAB:
	inc	word ptr [di]

l149A_1DAD:
	inc	word ptr [di+4h]
	mov	ax,si
	dec	word ptr [di]
	les	bx,[di]
	mov	es:[bx],al
	and	byte ptr [di+0Ah],0EFh
	or	byte ptr [di+0Ah],1h
	sub	ah,ah

l149A_1DC3:
	pop	si
	pop	di
	mov	sp,bp
	pop	bp
	retf
149A:1DC9                            90                            .      

;; fn149A_1DCA: 149A:1DCA
;;   Called from:
;;     0800:04D1 (in fn0800_02FE)
;;     0800:3C06 (in main)
;;     0800:8089 (in fn0800_7DD1)
;;     1054:0326 (in fn1054_0104)
;;     1054:0EA1 (in fn1054_0DB3)
;;     1054:0EE3 (in fn1054_0DB3)
;;     1054:19DB (in fn1054_0DB3)
;;     1054:3BB8 (in fn1054_3A11)
;;     1054:3E41 (in fn1054_3C57)
;;     1054:40CC (in fn1054_3F70)
;;     149A:0683 (in fn149A_063C)
fn149A_1DCA proc
	push	bp
	mov	bp,sp
	mov	bx,[bp+6h]
	cmp	bx,[31A9h]
	jc	1DDCh

l149A_1DD6:
	mov	ax,900h
	stc
	jmp	1DE7h

l149A_1DDC:
	mov	ah,3Eh
	int	21h
	jc	1DE7h

l149A_1DE2:
	mov	byte ptr [bx+31ABh],0h

l149A_1DE7:
	jmp	05E6h

;; fn149A_1DEA: 149A:1DEA
;;   Called from:
;;     0800:485B (in fn0800_481C)
;;     0800:4A13 (in fn0800_481C)
;;     0800:4A3D (in fn0800_481C)
;;     0800:594E (in fn0800_550A)
;;     0800:7764 (in fn0800_7727)
;;     0800:82CA (in fn0800_8095)
;;     0800:8347 (in fn0800_8095)
;;     1054:1296 (in fn1054_0DB3)
;;     1054:1843 (in fn1054_0DB3)
;;     1054:3D4F (in fn1054_3C57)
;;     1054:3D6E (in fn1054_3C57)
;;     1054:408E (in fn1054_3F70)
;;     149A:0C76 (in fn149A_0B9C)
;;     149A:28D0 (in fn149A_28C2)
fn149A_1DEA proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	mov	bx,[bp+6h]
	cmp	bx,[31A9h]
	jc	1DFEh

l149A_1DF9:
	mov	ax,900h
	jmp	1E28h

l149A_1DFE:
	test	word ptr [bp+0Ah],8000h
	jz	1E4Dh

l149A_1E05:
	cmp	word ptr [bp+0Ch],0h
	jz	1E25h

l149A_1E0B:
	xor	cx,cx
	mov	dx,cx
	mov	ax,4201h
	int	21h
	jc	1E61h

l149A_1E16:
	test	word ptr [bp+0Ch],2h
	jnz	1E2Bh

l149A_1E1D:
	add	ax,[bp+8h]
	adc	dx,[bp+0Ah]
	jns	1E4Dh

l149A_1E25:
	mov	ax,1600h

l149A_1E28:
	stc
	jmp	1E61h

l149A_1E2B:
	mov	[bp-2h],dx
	mov	[bp-4h],ax
	mov	dx,cx
	mov	ax,4202h
	int	21h
	add	ax,[bp+8h]
	adc	dx,[bp+0Ah]
	jns	1E4Dh

l149A_1E40:
	mov	cx,[bp-2h]
	mov	dx,[bp-4h]
	mov	ax,4200h
	int	21h
	jmp	1E25h

l149A_1E4D:
	mov	dx,[bp+8h]
	mov	cx,[bp+0Ah]
	mov	al,[bp+0Ch]
	mov	ah,42h
	int	21h
	jc	1E61h

l149A_1E5C:
	and	byte ptr [bx+31ABh],0FDh

l149A_1E61:
	jmp	05FBh

;; fn149A_1E64: 149A:1E64
;;   Called from:
;;     149A:0DB0 (in fn149A_0D0C)
fn149A_1E64 proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	xor	bh,bh
	cmp	byte ptr [31A4h],3h
	jc	1E76h

l149A_1E73:
	mov	bh,[bp+0Ch]

l149A_1E76:
	mov	ax,[bp+0Eh]
	mov	[bp+0Ch],ax
	jmp	1E86h

;; fn149A_1E7E: 149A:1E7E
;;   Called from:
;;     0800:1FE7 (in main)
;;     0800:3787 (in main)
;;     1054:012C (in fn1054_0104)
;;     1054:0DDB (in fn1054_0DB3)
;;     1054:121D (in fn1054_0DB3)
;;     1054:3A44 (in fn1054_3A11)
;;     1054:3C8B (in fn1054_3C57)
;;     1054:3CE4 (in fn1054_3C57)
;;     1054:3F9E (in fn1054_3F70)
fn149A_1E7E proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	xor	bh,bh

;; fn149A_1E86: 149A:1E86
;;   Called from:
;;     149A:1E7C (in fn149A_1E64)
;;     149A:1E84 (in fn149A_1E7E)
fn149A_1E86 proc
	mov	[bp-2h],bh
	mov	ax,[bp+0Ah]
	mov	cx,ax
	mov	byte ptr [bp-4h],0h
	test	ax,8000h
	jnz	1EA7h

l149A_1E97:
	test	ax,4000h
	jnz	1EA3h

l149A_1E9C:
	test	byte ptr [3459h],80h
	jnz	1EA7h

l149A_1EA3:
	mov	byte ptr [bp-4h],80h

l149A_1EA7:
	push	ds
	lds	dx,[bp+6h]
	and	al,3h
	or	al,bh
	mov	ah,3Dh
	int	21h
	pop	ds
	jnc	1EC8h

l149A_1EB6:
	cmp	ax,2h
	jnz	1EC4h

l149A_1EBB:
	test	cx,100h
	jz	1EC4h

l149A_1EC1:
	jmp	1F69h

l149A_1EC4:
	stc
	jmp	05FBh

l149A_1EC8:
	xchg	bx,ax
	mov	ax,cx
	and	ax,500h
	cmp	ax,500h
	jnz	1EDCh

l149A_1ED3:
	mov	ah,3Eh
	int	21h
	mov	ax,1100h
	jmp	1EC4h

l149A_1EDC:
	mov	byte ptr [bp-3h],1h
	mov	ax,4400h
	int	21h
	test	dl,80h
	jz	1EEEh

l149A_1EEA:
	or	byte ptr [bp-4h],40h

l149A_1EEE:
	test	byte ptr [bp-4h],40h
	jz	1EF7h

l149A_1EF4:
	jmp	1FD6h

l149A_1EF7:
	mov	ax,[bp+0Ah]
	test	ax,200h
	jz	1F1Dh

l149A_1EFF:
	test	ax,3h
	jz	1F0Dh

l149A_1F04:
	xor	cx,cx
	mov	ah,40h
	int	21h
	jmp	1FD6h

l149A_1F0D:
	mov	ah,3Eh
	int	21h
	push	ds
	lds	dx,[bp+6h]
	mov	ax,4300h
	int	21h
	pop	ds
	jmp	1F86h

l149A_1F1D:
	test	byte ptr [bp-4h],80h
	jnz	1F26h

l149A_1F23:
	jmp	1FD6h

l149A_1F26:
	test	ax,2h
	jnz	1F2Eh

l149A_1F2B:
	jmp	1FD6h

l149A_1F2E:
	mov	cx,0FFFFh
	mov	dx,cx
	mov	ax,4202h
	int	21h
	neg	cx
	push	ds
	push	ss
	pop	ds
	lea	dx,[bp-1h]
	mov	ah,3Fh
	int	21h
	pop	ds
	or	ax,ax
	jz	1F5Eh

l149A_1F49:
	cmp	byte ptr [bp-1h],1Ah
	jnz	1F5Eh

l149A_1F4F:
	neg	cx
	mov	dx,cx
	mov	ax,4202h
	int	21h
	xor	cx,cx
	mov	ah,40h
	int	21h

l149A_1F5E:
	xor	cx,cx
	mov	dx,cx
	mov	ax,4200h
	int	21h
	jmp	1FD6h

l149A_1F69:
	mov	byte ptr [bp-3h],0h
	mov	cx,[bp+0Ch]
	call	201Fh
	mov	[bp+0Ch],cx
	test	byte ptr [bp-2h],0FFh
	jnz	1F83h

l149A_1F7C:
	test	word ptr [bp+0Ah],2h
	jnz	1F86h

l149A_1F83:
	and	cl,0FEh

l149A_1F86:
	push	ds
	lds	dx,[bp+6h]
	mov	ah,3Ch
	int	21h
	pop	ds
	jnc	1F94h

l149A_1F91:
	jmp	05FBh

l149A_1F94:
	xchg	bx,ax
	test	byte ptr [bp-2h],0FFh
	jnz	1FA2h

l149A_1F9B:
	test	word ptr [bp+0Ah],2h
	jnz	1FD6h

l149A_1FA2:
	mov	ah,3Eh
	int	21h
	mov	al,[bp+0Ah]
	and	al,3h
	or	al,[bp-2h]
	push	ds
	lds	dx,[bp+6h]
	mov	ah,3Dh
	int	21h
	pop	ds
	jc	1F91h

l149A_1FB9:
	xchg	bx,ax
	test	byte ptr [bp-3h],1h
	jnz	1FD6h

l149A_1FC0:
	test	word ptr [bp+0Ch],1h
	jz	1FD6h

l149A_1FC7:
	or	cl,1h
	push	ds
	lds	dx,[bp+6h]
	mov	ax,4301h
	int	21h
	pop	ds
	jc	1F91h

l149A_1FD6:
	test	byte ptr [bp-4h],40h
	jnz	201Bh

l149A_1FDC:
	push	ds
	lds	dx,[bp+6h]
	mov	ax,4300h
	int	21h
	pop	ds
	mov	ax,cx
	xor	cl,cl
	and	ax,1h
	jz	1FF1h

l149A_1FEF:
	mov	cl,10h

l149A_1FF1:
	test	word ptr [bp+0Ah],8h
	jz	1FFBh

l149A_1FF8:
	or	cl,20h

l149A_1FFB:
	cmp	bx,[31A9h]
	jc	200Bh

l149A_2001:
	mov	ah,3Eh
	int	21h
	mov	ax,1800h
	jmp	1EC4h

l149A_200B:
	or	cl,[bp-4h]
	or	cl,1h
	mov	[bx+31ABh],cl
	mov	ax,bx
	mov	sp,bp
	pop	bp
	retf

l149A_201B:
	xor	cl,cl
	jmp	1FFBh

;; fn149A_201F: 149A:201F
;;   Called from:
;;     149A:1F70 (in fn149A_1E86)
fn149A_201F proc
	mov	ax,[319Eh]
	not	ax
	and	ax,cx
	xor	cx,cx
	test	al,80h
	jnz	202Fh

l149A_202C:
	or	cl,1h

l149A_202F:
	ret

;; fn149A_2030: 149A:2030
;;   Called from:
;;     0800:450E (in fn0800_44E1)
;;     0800:4576 (in fn0800_44E1)
;;     0800:45D0 (in fn0800_44E1)
;;     0800:4609 (in fn0800_45DC)
;;     0800:464A (in fn0800_45DC)
;;     0800:467A (in fn0800_45DC)
;;     0800:483A (in fn0800_481C)
;;     0800:48E7 (in fn0800_481C)
;;     0800:49A3 (in fn0800_481C)
;;     0800:4B0E (in fn0800_481C)
;;     0800:4BC7 (in fn0800_481C)
;;     0800:4EF0 (in fn0800_481C)
;;     0800:4FC7 (in fn0800_481C)
;;     0800:503F (in fn0800_481C)
;;     0800:5971 (in fn0800_550A)
;;     0800:778A (in fn0800_7727)
;;     0800:7DEF (in fn0800_7DD1)
;;     0800:7EAF (in fn0800_7DD1)
;;     0800:7F92 (in fn0800_7DD1)
;;     1054:026C (in fn1054_0104)
;;     1054:0E73 (in fn1054_0DB3)
;;     1054:0EC2 (in fn1054_0DB3)
;;     1054:0F87 (in fn1054_0DB3)
;;     1054:12C2 (in fn1054_0DB3)
;;     1054:1874 (in fn1054_0DB3)
;;     1054:3A9B (in fn1054_3A11)
;;     1054:3ADF (in fn1054_3A11)
;;     1054:3AF7 (in fn1054_3A11)
;;     1054:3FF5 (in fn1054_3F70)
;;     1054:4039 (in fn1054_3F70)
;;     1054:4051 (in fn1054_3F70)
;;     149A:08B6 (in fn149A_0833)
;;     149A:0B49 (in fn149A_0B00)
fn149A_2030 proc
	push	bp
	mov	bp,sp
	sub	sp,2h
	mov	bx,[bp+6h]
	cmp	bx,[31A9h]
	jc	2045h

l149A_203F:
	stc
	mov	ax,900h
	jmp	20B8h

l149A_2045:
	xor	ax,ax
	mov	cx,[bp+0Ch]
	jcxz	20B8h

l149A_204C:
	test	byte ptr [bx+31ABh],2h
	jnz	20B8h

l149A_2053:
	cmp	word ptr [35FEh],0D6D6h
	jnz	205Fh

l149A_205B:
	call	word ptr [3600h]

l149A_205F:
	mov	cx,[bp+0Ch]
	push	ds
	lds	dx,[bp+8h]
	mov	ah,3Fh
	int	21h
	pop	ds
	jnc	2071h

l149A_206D:
	mov	ah,9h
	jmp	20B8h

l149A_2071:
	test	byte ptr [bx+31ABh],80h
	jz	20B8h

l149A_2078:
	and	byte ptr [bx+31ABh],0FBh
	push	si
	push	di
	push	ds
	pop	es
	mov	ds,[bp+0Ah]
	cld
	mov	si,dx
	mov	di,dx
	mov	cx,ax
	jcxz	20B4h

l149A_208D:
	mov	ah,0Dh
	cmp	byte ptr [si],0Ah
	jnz	209Ah

l149A_2094:
	or	byte ptr es:[bx+31ABh],4h

l149A_209A:
	lodsb
	cmp	al,ah
	jz	20BBh

l149A_209F:
	cmp	al,1Ah
	jnz	20ABh

l149A_20A3:
	or	byte ptr es:[bx+31ABh],2h
	jmp	20B0h

l149A_20AB:
	mov	[di],al
	inc	di

l149A_20AE:
	loop	209Ah

l149A_20B0:
	mov	ax,di
	sub	ax,dx

l149A_20B4:
	push	es
	pop	ds

l149A_20B6:
	pop	di
	pop	si

l149A_20B8:
	jmp	05FBh

l149A_20BB:
	cmp	cx,1h
	jz	20C7h

l149A_20C0:
	cmp	byte ptr [si],0Ah
	jz	20AEh

l149A_20C5:
	jmp	20ABh

l149A_20C7:
	push	es
	pop	ds
	test	byte ptr [bx+31ABh],40h
	jz	20ECh

l149A_20D0:
	mov	ax,4400h
	int	21h
	test	dx,20h
	jnz	20E8h

l149A_20DB:
	push	ds
	push	ss
	pop	ds
	lea	dx,[bp-1h]
	mov	ah,3Fh
	int	21h
	pop	ds
	jc	20B6h

l149A_20E8:
	mov	al,0Ah
	jmp	211Ch

l149A_20EC:
	push	ds
	push	ss
	pop	ds
	mov	byte ptr [bp-1h],0h
	lea	dx,[bp-1h]
	mov	ah,3Fh
	int	21h
	pop	ds
	jc	20B6h

l149A_20FD:
	or	ax,ax
	jz	211Ah

l149A_2101:
	cmp	word ptr [bp+0Ch],1h
	jz	2126h

l149A_2107:
	mov	cx,0FFFFh
	mov	dx,cx
	mov	ax,4201h
	int	21h
	mov	cx,1h
	cmp	byte ptr [bp-1h],0Ah
	jz	2121h

l149A_211A:
	mov	al,0Dh

l149A_211C:
	lds	dx,[bp+8h]
	jmp	20ABh

l149A_2121:
	lds	dx,[bp+8h]
	jmp	20AEh

l149A_2126:
	cmp	byte ptr [bp-1h],0Ah
	jnz	2107h

l149A_212C:
	jmp	20E8h

;; fn149A_212E: 149A:212E
;;   Called from:
;;     0800:20AB (in main)
;;     0800:81F9 (in fn0800_8095)
;;     0800:8272 (in fn0800_8095)
;;     0800:832E (in fn0800_8095)
;;     1054:3DBE (in fn1054_3C57)
;;     1054:3DCF (in fn1054_3C57)
;;     1054:3DE0 (in fn1054_3C57)
;;     1054:3DFB (in fn1054_3C57)
;;     1054:3E16 (in fn1054_3C57)
;;     1054:40A6 (in fn1054_3F70)
;;     1054:40BE (in fn1054_3F70)
;;     149A:0A6A (in fn149A_09C5)
;;     149A:0C09 (in fn149A_0B9C)
;;     149A:0C4A (in fn149A_0B9C)
;;     149A:0F21 (in fn149A_0ECE)
fn149A_212E proc
	push	bp
	mov	bp,sp
	sub	sp,8h
	mov	bx,[bp+6h]
	cmp	bx,[31A9h]
	jc	2144h

l149A_213D:
	mov	ax,900h
	stc

l149A_2141:
	jmp	05FBh

l149A_2144:
	cmp	word ptr [35FEh],0D6D6h
	jnz	2150h

l149A_214C:
	call	word ptr [3600h]

l149A_2150:
	test	byte ptr [bx+31ABh],20h
	jz	2162h

l149A_2157:
	mov	ax,4202h
	xor	cx,cx
	mov	dx,cx
	int	21h
	jc	2141h

l149A_2162:
	test	byte ptr [bx+31ABh],80h
	jz	21E5h

l149A_2169:
	mov	[bp-6h],ds
	mov	es,[bp+0Ah]
	lds	dx,[bp+8h]
	xor	ax,ax
	mov	[bp-2h],ax
	mov	[bp-4h],ax
	cld
	push	di
	push	si
	mov	di,dx
	mov	si,dx
	mov	[bp-8h],sp
	mov	cx,[bp+0Ch]
	jcxz	21C8h

l149A_2189:
	mov	al,0Ah

l149A_218B:
	repne scasb

l149A_218D:
	jnz	21E0h

l149A_218F:
	push	ds
	mov	ds,[bp-6h]
	call	far 149Ah:228Eh
	cmp	ax,0A8h
	jbe	21E7h

l149A_219D:
	pop	ds
	sub	sp,2h
	mov	bx,sp
	mov	dx,200h
	cmp	ax,228h
	jnc	21AEh

l149A_21AB:
	mov	dx,80h

l149A_21AE:
	sub	sp,dx
	mov	dx,sp
	mov	di,dx
	push	ss
	pop	es
	mov	cx,[bp+0Ch]

l149A_21B9:
	lodsb
	cmp	al,0Ah
	jz	21CAh

l149A_21BE:
	cmp	di,bx
	jz	21DBh

l149A_21C2:
	stosb
	loop	21B9h

l149A_21C5:
	call	21EEh

l149A_21C8:
	jmp	2243h

l149A_21CA:
	mov	al,0Dh
	cmp	di,bx
	jnz	21D3h

l149A_21D0:
	call	21EEh

l149A_21D3:
	stosb
	mov	al,0Ah
	inc	word ptr [bp-4h]
	jmp	21BEh

l149A_21DB:
	call	21EEh
	jmp	21C2h

l149A_21E0:
	pop	si
	pop	di
	mov	ds,[bp-6h]

l149A_21E5:
	jmp	2254h

l149A_21E7:
	mov	ax,0FFFCh
	push	cs
	call	02C8h

;; fn149A_21EE: 149A:21EE
;;   Called from:
;;     149A:21C5 (in fn149A_212E)
;;     149A:21D0 (in fn149A_212E)
;;     149A:21DB (in fn149A_212E)
;;     149A:21EA (in fn149A_212E)
fn149A_21EE proc
	push	ax
	push	bx
	push	cx
	push	ds
	push	es
	pop	ds
	mov	cx,di
	sub	cx,dx
	jcxz	220Ch

l149A_21FA:
	push	cx
	mov	bx,[bp+6h]
	mov	ah,40h
	int	21h
	pop	cx
	jc	2213h

l149A_2205:
	add	[bp-2h],ax
	cmp	cx,ax
	ja	2213h

l149A_220C:
	pop	ds
	pop	cx
	pop	bx
	pop	ax
	mov	di,dx
	ret

l149A_2213:
	lahf
	pop	ds
	add	sp,8h
	cmp	word ptr [bp-2h],0h
	jnz	2243h

l149A_221E:
	sahf
	jnc	2225h

l149A_2221:
	mov	ah,9h
	jmp	2249h

l149A_2225:
	mov	ds,[bp-6h]
	test	byte ptr [bx+31ABh],40h
	jz	223Dh

l149A_222F:
	mov	ds,[bp+0Ah]
	mov	bx,[bp+8h]
	cmp	byte ptr [bx],1Ah
	jnz	223Dh

l149A_223A:
	clc
	jmp	2249h

l149A_223D:
	stc
	mov	ax,1C00h
	jmp	2249h

;; fn149A_2243: 149A:2243
;;   Called from:
;;     149A:21C8 (in fn149A_212E)
;;     149A:221C (in fn149A_21EE)
fn149A_2243 proc
	mov	ax,[bp-2h]
	sub	ax,[bp-4h]

;; fn149A_2249: 149A:2249
;;   Called from:
;;     149A:2223 (in fn149A_21EE)
;;     149A:223B (in fn149A_21EE)
;;     149A:2241 (in fn149A_21EE)
;;     149A:2246 (in fn149A_2243)
fn149A_2249 proc
	mov	sp,[bp-8h]
	pop	si
	pop	di
	mov	ds,[bp-6h]

;; fn149A_2251: 149A:2251
;;   Called from:
;;     149A:224E (in fn149A_2249)
;;     149A:226F (in fn149A_212E)
;;     149A:2273 (in fn149A_212E)
;;     149A:2285 (in fn149A_212E)
;;     149A:228B (in fn149A_212E)
fn149A_2251 proc
	jmp	05FBh

l149A_2254:
	mov	cx,[bp+0Ch]
	or	cx,cx
	jnz	2260h

l149A_225B:
	mov	ax,cx
	jmp	05FBh

l149A_2260:
	push	ds
	lds	dx,[bp+8h]
	mov	ah,40h
	int	21h
	push	ds
	pop	es
	pop	ds
	jnc	2271h

l149A_226D:
	mov	ah,9h
	jmp	2251h

l149A_2271:
	or	ax,ax
	jnz	2251h

l149A_2275:
	test	byte ptr [bx+31ABh],40h
	jz	2287h

l149A_227C:
	mov	bx,dx
	cmp	byte ptr es:[bx],1Ah
	jnz	2287h

l149A_2284:
	clc
	jmp	2251h

l149A_2287:
	stc
	mov	ax,1C00h
	jmp	2251h
149A:228D                                        00                    .  

;; fn149A_228E: 149A:228E
;;   Called from:
;;     149A:2193 (in fn149A_212E)
fn149A_228E proc
	pop	cx
	pop	dx
	mov	ax,[31DEh]
	cmp	ax,sp
	jnc	229Eh

l149A_2297:
	sub	ax,sp
	neg	ax

l149A_229B:
	push	dx
	push	cx
	retf

l149A_229E:
	xor	ax,ax
	jmp	229Bh

;; fn149A_22A2: 149A:22A2
;;   Called from:
;;     0800:07FD (in fn0800_0784)
;;     0800:09CB (in fn0800_090A)
;;     0800:0BF7 (in fn0800_0AC7)
;;     0800:29F1 (in main)
;;     0800:31AE (in main)
;;     0800:448A (in fn0800_445A)
;;     0800:4897 (in fn0800_481C)
;;     0800:4A9D (in fn0800_481C)
;;     0800:4C2A (in fn0800_481C)
;;     0800:4CA7 (in fn0800_481C)
;;     0800:4D69 (in fn0800_481C)
;;     0800:4DE6 (in fn0800_481C)
;;     1054:088F (in fn1054_0792)
;;     1054:08F4 (in fn1054_0792)
;;     149A:0CCB (in fn149A_0CC0)
;;     149A:0E6D (in fn149A_0E04)
;;     149A:2C39 (in fn149A_2B5A)
;;     149A:316E (in fn149A_3068)
;;     149A:32D9 (in fn149A_3236)
;;     149A:35FD (in fn149A_3544)
fn149A_22A2 proc
	jmp	far 149Ah:22C1h
149A:22A7                      00                                .        

;; fn149A_22A8: 149A:22A8
;;   Called from:
;;     0800:0373 (in fn0800_02FE)
;;     0800:03A3 (in fn0800_02FE)
;;     0800:042A (in fn0800_02FE)
;;     0800:0448 (in fn0800_02FE)
;;     0800:049F (in fn0800_02FE)
;;     0800:04BD (in fn0800_02FE)
;;     0800:2E69 (in main)
;;     1054:1742 (in fn1054_0DB3)
;;     1054:176A (in fn1054_0DB3)
;;     149A:0CA0 (in fn149A_0C88)
;;     149A:2E47 (in fn149A_2B5A)
;;     149A:3057 (in fn149A_2FB2)
;;     149A:3226 (in fn149A_3068)
;;     149A:33F0 (in fn149A_3236)
fn149A_22A8 proc
	jmp	far 149Ah:22AEh
149A:22AD                                        00                    .  

;; fn149A_22AE: 149A:22AE
;;   Called from:
;;     0800:0034 (in fn0800_0000)
;;     1054:1A1F (in fn1054_0DB3)
;;     1054:1A32 (in fn1054_0DB3)
;;     149A:22A8 (in fn149A_22A8)
fn149A_22AE proc
	push	bp
	mov	bp,sp
	push	si
	les	si,[bp+6h]
	mov	cx,es
	jcxz	22BEh

l149A_22B9:
	or	byte ptr es:[si-2h],1h

l149A_22BE:
	pop	si
	pop	bp
	retf

;; fn149A_22C1: 149A:22C1
;;   Called from:
;;     0800:010E (in fn0800_00A0)
;;     0800:0E09 (in main)
;;     0800:4F49 (in fn0800_481C)
;;     1054:0F20 (in fn1054_0DB3)
;;     1054:0FBA (in fn1054_0DB3)
;;     149A:22A2 (in fn149A_22A2)
fn149A_22C1 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	cx,[bp+6h]
	cmp	cx,0E8h
	ja	2337h

l149A_22CE:
	push	ds
	mov	ax,[345Ch]
	or	ax,ax
	jz	231Eh

l149A_22D6:
	mov	di,23A8h

l149A_22D9:
	mov	si,[3464h]
	lds	bx,[345Eh]

l149A_22E1:
	push	ds

l149A_22E2:
	push	si
	push	di
	call	di
	pop	di
	pop	si
	jnc	2315h

l149A_22EA:
	mov	dx,ds
	lds	bx,[bx+0Ch]
	cmp	dx,si
	jnz	22E2h

l149A_22F3:
	pop	ax
	pop	ds
	push	ds
	les	si,[345Eh]
	mov	si,es:[si+12h]
	lds	bx,[345Ah]
	mov	dx,ds
	cmp	dx,ax
	jnz	22E1h

l149A_2308:
	pop	ds
	push	ds
	cmp	di,2424h
	jz	231Eh

l149A_2310:
	mov	di,2424h
	jmp	22D9h

l149A_2315:
	pop	si
	cmp	di,23A8h
	jz	232Bh

l149A_231C:
	jmp	2328h

l149A_231E:
	pop	es
	push	es
	mov	di,345Ah
	call	2524h
	jc	2336h

l149A_2328:
	call	23A8h

l149A_232B:
	pop	ds
	mov	[3460h],dx
	mov	[345Eh],bx
	jmp	233Ah

l149A_2336:
	pop	ds

l149A_2337:
	xor	ax,ax
	cwd

l149A_233A:
	pop	di
	pop	si
	pop	bp
	retf

;; fn149A_233E: 149A:233E
;;   Called from:
;;     149A:255D (in fn149A_2524)
fn149A_233E proc
	push	es
	push	di
	mov	di,ax
	add	di,bx
	mov	[bx+4h],di
	dec	di
	dec	di
	sub	ax,16h
	lea	si,[bx+14h]
	mov	word ptr [di],0FFFEh
	mov	[bx+0Ah],di
	dec	ax
	mov	[si],ax
	mov	[bx],ds
	mov	ax,si
	mov	dx,ds
	mov	es,dx
	lea	di,[bx+6h]
	cld
	stosw
	stosw
	inc	di
	inc	di
	xor	ax,ax
	stosw
	stosw
	stosw
	stosw
	pop	di
	pop	es
	ret

;; fn149A_2372: 149A:2372
;;   Called from:
;;     149A:2560 (in fn149A_2524)
fn149A_2372 proc
	mov	ax,es:[di+2h]
	or	ax,ax
	jnz	2383h

l149A_237A:
	mov	es:[di+2h],ds
	mov	es:[di],bx
	jmp	2397h

l149A_2383:
	push	es
	les	si,es:[di+8h]
	mov	es:[si+0Eh],ds
	mov	es:[si+0Ch],bx
	mov	[bx+12h],es
	mov	[bx+10h],si
	pop	es

l149A_2397:
	mov	es:[di+0Ah],ds
	mov	es:[di+8h],bx
	mov	es:[di+6h],ds
	mov	es:[di+4h],bx
	ret

;; fn149A_23A8: 149A:23A8
;;   Called from:
;;     149A:2328 (in fn149A_22C1)
fn149A_23A8 proc
	inc	cx
	and	cl,0FEh
	push	bx
	cld
	mov	si,[bx+8h]
	mov	bx,[bx+0Ah]
	xor	di,di
	jmp	23DBh

l149A_23B8:
	mov	ax,bx
	pop	bx
	test	al,1h
	jnz	2401h

l149A_23BF:
	push	bx
	mov	si,[bx+6h]
	mov	bx,[bx+8h]
	cmp	bx,si
	jz	2400h

l149A_23CA:
	dec	bx
	xor	di,di
	jmp	23DBh
149A:23CF                                              90                .

l149A_23D0:
	lea	dx,[si-2h]
	cmp	dx,bx
	jnc	23B8h

l149A_23D7:
	add	si,ax
	jc	23FEh

l149A_23DB:
	lodsw
	test	al,1h
	jz	23D0h

l149A_23E0:
	mov	di,si

l149A_23E2:
	dec	ax
	cmp	ax,cx
	jnc	240Ah

l149A_23E7:
	add	si,ax
	jc	23FEh

l149A_23EB:
	mov	dx,ax
	lodsw
	test	al,1h
	jz	23D0h

l149A_23F2:
	add	ax,dx
	add	ax,2h
	mov	si,di
	mov	[si-2h],ax
	jmp	23E2h

l149A_23FE:
	mov	ax,ax

l149A_2400:
	pop	bx

l149A_2401:
	mov	ax,[bx+6h]
	mov	[bx+8h],ax
	stc
	jmp	2423h

l149A_240A:
	pop	bx
	mov	[si-2h],cx
	jz	2419h

l149A_2410:
	add	di,cx
	sub	ax,cx
	dec	ax
	mov	[di],ax
	sub	di,cx

l149A_2419:
	add	di,cx
	mov	[bx+8h],di
	mov	ax,si
	mov	dx,ds
	clc

l149A_2423:
	ret
149A:2424             51 57 F6 47 02 01 74 66 E8 D5 00 8B     QW.G..tf....
149A:2430 FE 8B 04 A8 01 74 03 2B C8 49 41 41 8B 77 04 0B .....t.+.IAA.w..
149A:2440 F6 74 4F 03 CE 73 09 33 C0 BA F0 FF E3 33 EB 42 .tO..s.3.....3.B
149A:2450 B8 E8 3D 8E C0 26 A1 68 34 3D 00 20 74 16 BA 00 ..=..&.h4=. t...
149A:2460 80 3B D0 72 06 D1 EA 75 F8 EB 22 83 FA 08 72 1D .;.r...u.."...r.
149A:2470 D1 E2 8B C2 48 8B D0 03 C1 73 02 33 C0 F7 D2 23 ....H....s.3...#
149A:2480 C2 52 E8 2E 00 5A 73 0D 83 FA F0 74 05 B8 10 00 .R...Zs....t....
149A:2490 EB E2 F9 EB 1B 8B D0 2B 57 04 89 47 04 89 7F 08 .......+W..G....
149A:24A0 8B 77 0A 4A 89 14 42 03 F2 C7 04 FE FF 89 77 0A .w.J..B.......w.
149A:24B0 5F 59 C3 8B D0 F6 47 02 04 74 0F 4A 8B 77 04 4E _Y....G..t.J.w.N
149A:24C0 3B D6 72 05 39 57 FE 73 36 42 53 51 8C DE 8E C6 ;.r.9W.s6BSQ....
149A:24D0 B1 04 D3 E8 75 03 B8 00 10 F6 47 02 04 74 0A 03 ....u.....G..t..
149A:24E0 C6 8B 1E A2 31 2B C3 8E C3 8B D8 B4 4A CD 21 59 ....1+......J.!Y
149A:24F0 5B 72 10 8B C2 F6 47 02 04 74 04 4A 89 57 FE F8 [r....G..t.J.W..
149A:2500 EB 01 F9 C3 57 8B 77 08 3B 77 0A 75 03 8B 77 06 ....W.w.;w.u..w.
149A:2510 AD 3D FE FF 74 08 8B FE 24 FE 03 F0 EB F2 4F 4F .=..t...$.....OO
149A:2520 8B F7 5F C3                                     .._.            

;; fn149A_2524: 149A:2524
;;   Called from:
;;     149A:2323 (in fn149A_22C1)
fn149A_2524 proc
	mov	dx,cx
	add	dx,27h
	and	dl,0F0h
	mov	bx,dx
	neg	bx
	neg	bx
	cmc
	rcr	bx,1h
	shr	bx,1h
	shr	bx,1h
	shr	bx,1h

l149A_253B:
	mov	ah,48h
	int	21h
	jc	2567h

l149A_2541:
	cmp	ax,[317Eh]
	jbe	253Bh

l149A_2547:
	cmp	ax,[317Ch]
	jbe	2550h

l149A_254D:
	mov	[317Ch],ax

l149A_2550:
	mov	ds,ax
	xor	bx,bx
	mov	ax,es:[di+0Ch]
	mov	[bx+2h],ax
	mov	ax,dx
	call	233Eh
	call	2372h
	clc
	jmp	2567h
149A:2566                   F9                                  .         

l149A_2567:
	ret

;; fn149A_2568: 149A:2568
;;   Called from:
;;     0800:0576 (in fn0800_04E8)
;;     0800:06CD (in fn0800_05CC)
;;     0800:0741 (in fn0800_06D9)
;;     0800:0B6B (in fn0800_0AC7)
;;     0800:0CDA (in fn0800_0AC7)
;;     0800:1277 (in main)
;;     0800:12BC (in main)
;;     0800:1301 (in main)
;;     0800:1804 (in main)
;;     0800:1939 (in main)
;;     0800:1961 (in main)
;;     0800:19BD (in main)
;;     0800:19D4 (in main)
;;     0800:1A16 (in main)
;;     0800:1A37 (in main)
;;     0800:1AE4 (in main)
;;     0800:1C0D (in main)
;;     0800:1CA4 (in main)
;;     0800:1D55 (in main)
;;     0800:1FD3 (in main)
;;     0800:25D9 (in main)
;;     0800:2666 (in main)
;;     0800:26F3 (in main)
;;     0800:2B22 (in main)
;;     0800:2BAF (in main)
;;     0800:2D96 (in main)
;;     0800:311A (in main)
;;     0800:32B1 (in main)
;;     0800:3AF5 (in main)
;;     1054:011B (in fn1054_0104)
;;     1054:0DCA (in fn1054_0DB3)
;;     1054:120C (in fn1054_0DB3)
;;     1054:1515 (in fn1054_0DB3)
;;     1054:1B16 (in fn1054_1A49)
;;     149A:06C0 (in fn149A_063C)
;;     149A:3350 (in fn149A_3236)
;;     149A:338A (in fn149A_3236)
fn149A_2568 proc
	push	bp
	mov	bp,sp
	mov	dx,di
	mov	bx,si
	push	ds
	les	di,[bp+6h]
	xor	ax,ax
	mov	cx,0FFFFh
	repne scasb
	lea	si,[di-1h]
	les	di,[bp+0Ah]
	mov	cx,0FFFFh
	repne scasb
	not	cx
	sub	di,cx
	mov	ax,es
	mov	ds,ax
	mov	es,[bp+8h]
	xchg	si,di
	mov	ax,[bp+6h]
	test	si,1h
	jz	259Dh

l149A_259B:
	movsb
	dec	cx

l149A_259D:
	shr	cx,1h
	rep movsw
	adc	cx,cx
	rep movsb
	mov	si,bx
	mov	di,dx
	pop	ds
	mov	dx,es
	pop	bp
	retf

;; fn149A_25AE: 149A:25AE
;;   Called from:
;;     0800:0547 (in fn0800_04E8)
;;     0800:0647 (in fn0800_05CC)
;;     0800:0675 (in fn0800_05CC)
;;     0800:0709 (in fn0800_06D9)
;;     0800:0817 (in fn0800_0784)
;;     0800:08FB (in fn0800_084A)
;;     0800:09E5 (in fn0800_090A)
;;     0800:0B4F (in fn0800_0AC7)
;;     0800:0C4A (in fn0800_0AC7)
;;     0800:0CBE (in fn0800_0AC7)
;;     0800:0E56 (in main)
;;     0800:117F (in main)
;;     0800:11F8 (in main)
;;     0800:17F2 (in main)
;;     0800:18C9 (in main)
;;     0800:18F4 (in main)
;;     0800:1987 (in main)
;;     0800:1BF1 (in main)
;;     0800:1C88 (in main)
;;     0800:1D39 (in main)
;;     0800:2052 (in main)
;;     0800:25C7 (in main)
;;     0800:2654 (in main)
;;     0800:26E1 (in main)
;;     0800:2860 (in main)
;;     0800:2B10 (in main)
;;     0800:2B9D (in main)
;;     0800:30FE (in main)
;;     0800:3211 (in main)
;;     0800:3295 (in main)
;;     0800:33D9 (in main)
;;     0800:3776 (in main)
;;     0800:3AD9 (in main)
;;     0800:4521 (in fn0800_44E1)
;;     0800:4589 (in fn0800_44E1)
;;     0800:48FB (in fn0800_481C)
;;     0800:4B2E (in fn0800_481C)
;;     0800:74D6 (in fn0800_737C)
;;     0800:755F (in fn0800_7505)
;;     1054:0948 (in fn1054_0792)
;;     1054:1129 (in fn1054_0DB3)
;;     1054:1171 (in fn1054_0DB3)
;;     1054:11F8 (in fn1054_0DB3)
;;     1054:1259 (in fn1054_0DB3)
;;     1054:14F0 (in fn1054_0DB3)
;;     1054:1502 (in fn1054_0DB3)
;;     1054:1B63 (in fn1054_1A49)
;;     1054:35E5 (in fn1054_35A1)
;;     149A:069F (in fn149A_063C)
;;     149A:2CB8 (in fn149A_2B5A)
;;     149A:2CE8 (in fn149A_2B5A)
;;     149A:2D6F (in fn149A_2B5A)
;;     149A:2D9F (in fn149A_2B5A)
;;     149A:2DB3 (in fn149A_2B5A)
;;     149A:2E6C (in fn149A_2B5A)
;;     149A:319A (in fn149A_3068)
;;     149A:31E1 (in fn149A_3068)
;;     149A:363C (in fn149A_3544)
fn149A_25AE proc
	push	bp
	mov	bp,sp
	mov	dx,di
	mov	bx,si
	push	ds
	lds	si,[bp+0Ah]
	mov	di,si
	mov	ax,ds
	mov	es,ax
	xor	ax,ax
	mov	cx,0FFFFh
	repne scasb
	not	cx
	les	di,[bp+6h]
	mov	ax,di
	test	al,1h
	jz	25D3h

l149A_25D1:
	movsb
	dec	cx

l149A_25D3:
	shr	cx,1h
	rep movsw
	adc	cx,cx
	rep movsb
	mov	si,bx
	mov	di,dx
	pop	ds
	mov	dx,es
	pop	bp
	retf

;; fn149A_25E4: 149A:25E4
;;   Called from:
;;     0800:095A (in fn0800_090A)
;;     0800:33BD (in main)
;;     0800:424E (in fn0800_41BB)
;;     0800:4270 (in fn0800_41BB)
;;     0800:4292 (in fn0800_41BB)
;;     0800:42B4 (in fn0800_41BB)
;;     0800:42D6 (in fn0800_41BB)
;;     0800:42F8 (in fn0800_41BB)
;;     0800:431A (in fn0800_41BB)
;;     0800:433C (in fn0800_41BB)
;;     0800:435E (in fn0800_41BB)
;;     0800:4380 (in fn0800_41BB)
;;     0800:43A2 (in fn0800_41BB)
;;     0800:531A (in fn0800_514D)
;;     0800:742D (in fn0800_737C)
;;     0800:75BE (in fn0800_757C)
;;     0800:7E7E (in fn0800_7DD1)
;;     1054:0808 (in fn1054_0792)
;;     1054:10E0 (in fn1054_0DB3)
;;     1054:13C0 (in fn1054_0DB3)
;;     1054:357E (in fn1054_3541)
;;     1054:3B41 (in fn1054_3A11)
fn149A_25E4 proc
	push	bp
	mov	bp,sp
	mov	dx,di
	mov	bx,si
	push	ds
	lds	si,[bp+6h]
	les	di,[bp+0Ah]
	xor	ax,ax
	mov	cx,0FFFFh
	repne scasb
	not	cx
	sub	di,cx
	rep cmpsb
	jz	2606h

l149A_2601:
	sbb	ax,ax
	sbb	ax,0FFFFh

l149A_2606:
	pop	ds
	mov	si,bx
	mov	di,dx
	pop	bp
	retf
149A:260D                                        00                    .  

;; fn149A_260E: 149A:260E
;;   Called from:
;;     0800:0555 (in fn0800_04E8)
;;     0800:0BED (in fn0800_0AC7)
;;     0800:1248 (in main)
;;     0800:128D (in main)
;;     0800:12D2 (in main)
;;     0800:2D72 (in main)
;;     0800:31A4 (in main)
;;     0800:518D (in fn0800_514D)
;;     0800:5249 (in fn0800_514D)
;;     1054:1AF6 (in fn1054_1A49)
;;     149A:26C6 (in fn149A_26A0)
;;     149A:26E3 (in fn149A_26A0)
;;     149A:27B6 (in fn149A_27A8)
;;     149A:2899 (in fn149A_2876)
;;     149A:2B99 (in fn149A_2B5A)
;;     149A:2BFF (in fn149A_2B5A)
;;     149A:2E1F (in fn149A_2B5A)
;;     149A:3162 (in fn149A_3068)
;;     149A:31A8 (in fn149A_3068)
;;     149A:332D (in fn149A_3236)
;;     149A:335E (in fn149A_3236)
;;     149A:336E (in fn149A_3236)
;;     149A:35D8 (in fn149A_3544)
fn149A_260E proc
	push	bp
	mov	bp,sp
	mov	dx,di
	les	di,[bp+6h]
	xor	ax,ax
	mov	cx,0FFFFh
	repne scasb
	not	cx
	dec	cx
	xchg	cx,ax
	mov	di,dx
	pop	bp
	retf
149A:2625                00                                    .          

;; fn149A_2626: 149A:2626
;;   Called from:
;;     0800:21D6 (in main)
;;     0800:228F (in main)
;;     0800:23B7 (in main)
;;     0800:243C (in main)
;;     0800:24F2 (in main)
;;     0800:27BD (in main)
;;     0800:282E (in main)
;;     0800:2877 (in main)
;;     0800:2EBD (in main)
;;     0800:2F87 (in main)
;;     0800:3311 (in main)
;;     0800:3475 (in main)
;;     0800:352C (in main)
;;     0800:3555 (in main)
;;     0800:357E (in main)
;;     0800:35A8 (in main)
;;     0800:35D2 (in main)
;;     0800:3607 (in main)
;;     0800:3639 (in main)
;;     0800:3663 (in main)
;;     0800:368C (in main)
;;     0800:36B5 (in main)
;;     0800:36DF (in main)
;;     0800:3709 (in main)
;;     0800:3733 (in main)
;;     0800:43C6 (in fn0800_41BB)
;;     149A:2704 (in fn149A_26A0)
fn149A_2626 proc
	push	bp
	mov	bp,sp
	push	di
	push	si
	push	ds
	mov	cx,[bp+0Eh]
	jcxz	2658h

l149A_2631:
	mov	bx,cx
	les	di,[bp+6h]
	mov	si,di
	xor	ax,ax

l149A_263A:
	repne scasb

l149A_263C:
	neg	cx
	add	cx,bx
	mov	di,si
	lds	si,[bp+0Ah]
	rep cmpsb
	mov	al,[si-1h]
	xor	cx,cx
	cmp	al,es:[di-1h]
	ja	2656h

l149A_2652:
	jz	2658h

l149A_2654:
	dec	cx
	dec	cx

l149A_2656:
	not	cx

l149A_2658:
	mov	ax,cx
	pop	ds
	pop	si
	pop	di
	mov	sp,bp
	pop	bp
	retf
149A:2661    00                                            .              

;; fn149A_2662: 149A:2662
;;   Called from:
;;     149A:06DA (in fn149A_063C)
fn149A_2662 proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	bl,1h
	mov	cx,[bp+0Ch]
	mov	ax,[bp+6h]
	xor	dx,dx
	cmp	cx,0Ah
	jnz	2677h

l149A_2676:
	cwd

l149A_2677:
	push	ds
	lds	di,[bp+8h]
	jmp	2A91h
149A:267E                                           55 8B               U.
149A:2680 EC 8B 46 06 2D 20 00 5D CB 90                   ..F.- .]..      

;; fn149A_268A: 149A:268A
;;   Called from:
;;     1054:3B25 (in fn1054_3A11)
;;     1054:3DA4 (in fn1054_3C57)
fn149A_268A proc
	push	bp
	mov	bp,sp
	mov	bx,[bp+6h]
	test	byte ptr [bx+3489h],2h
	jz	269Ch

l149A_2697:
	lea	ax,[bx-20h]
	jmp	269Eh

l149A_269C:
	mov	ax,bx

l149A_269E:
	pop	bp
	retf

;; fn149A_26A0: 149A:26A0
;;   Called from:
;;     0800:114C (in main)
;;     0800:11C5 (in main)
;;     0800:187A (in main)
;;     149A:2FDB (in fn149A_2FB2)
;;     149A:32C3 (in fn149A_3236)
;;     149A:3416 (in fn149A_3404)
fn149A_26A0 proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	push	si
	mov	ax,[31C5h]
	mov	dx,[31C7h]
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	or	dx,ax
	jz	2726h

l149A_26B8:
	mov	ax,[bp+8h]
	or	ax,[bp+6h]
	jz	2726h

l149A_26C0:
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:260Eh
	add	sp,4h
	mov	si,ax

l149A_26D0:
	les	bx,[bp-4h]
	mov	ax,es:[bx+2h]
	or	ax,es:[bx]
	jz	2726h

l149A_26DC:
	push	word ptr es:[bx+2h]
	push	word ptr es:[bx]
	call	far 149Ah:260Eh
	add	sp,4h
	cmp	ax,si
	jle	2720h

l149A_26EF:
	les	bx,[bp-4h]
	les	bx,es:[bx]
	cmp	byte ptr es:[bx+si],3Dh
	jnz	2720h

l149A_26FB:
	push	si
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	push	es
	push	bx
	call	far 149Ah:2626h
	add	sp,0Ah
	or	ax,ax
	jnz	2720h

l149A_2710:
	les	bx,[bp-4h]
	mov	ax,es:[bx]
	mov	dx,es:[bx+2h]
	add	ax,si
	inc	ax
	jmp	2729h
149A:271F                                              90                .

l149A_2720:
	add	word ptr [bp-4h],4h
	jmp	26D0h

l149A_2726:
	sub	ax,ax
	cwd

l149A_2729:
	pop	si
	mov	sp,bp
	pop	bp
	retf

;; fn149A_272E: 149A:272E
;;   Called from:
;;     0800:07A8 (in fn0800_0784)
;;     0800:086E (in fn0800_084A)
;;     0800:216D (in main)
;;     1054:1C5D (in fn1054_1A49)
;;     1054:1D67 (in fn1054_1A49)
;;     1054:2470 (in fn1054_1A49)
fn149A_272E proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	dx,[bp+0Ah]
	or	dx,dx
	jle	2790h

l149A_273A:
	dec	dx
	mov	bx,[bp+0Ch]
	les	di,[bp+6h]

l149A_2741:
	or	dx,dx
	jz	279Ah

l149A_2745:
	mov	cx,[bx+4h]
	jcxz	2769h

l149A_274A:
	cmp	cx,dx
	jbe	2750h

l149A_274E:
	mov	cx,dx

l149A_2750:
	push	ds
	lds	si,[bx]
	mov	ah,0Ah
	push	cx

l149A_2756:
	lodsb
	stosb
	cmp	al,ah
	loopne	2756h

l149A_275C:
	pop	ax
	pop	ds
	mov	[bx],si
	jz	2795h

l149A_2762:
	sub	[bx+4h],ax
	sub	dx,ax
	jmp	2741h

l149A_2769:
	push	es
	push	bx
	push	dx
	push	ds
	push	bx
	push	cs
	call	0B00h
	add	sp,4h
	pop	dx
	pop	bx
	pop	es
	cmp	ax,0FFFFh
	jz	2785h

l149A_277D:
	stosb
	cmp	al,0Ah
	jz	279Ah

l149A_2782:
	dec	dx
	jmp	2741h

l149A_2785:
	cmp	di,[bp+6h]
	jz	2790h

l149A_278A:
	test	byte ptr [bx+0Ah],20h
	jz	279Ah

l149A_2790:
	xor	ax,ax
	cwd
	jmp	27A3h

l149A_2795:
	sub	ax,cx
	sub	[bx+4h],ax

l149A_279A:
	xor	ax,ax
	stosb
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]

l149A_27A3:
	pop	di
	pop	si
	pop	bp
	retf
149A:27A7                      00                                .        

;; fn149A_27A8: 149A:27A8
;;   Called from:
;;     0800:76B2 (in fn0800_75E1)
;;     0800:771B (in fn0800_75E1)
fn149A_27A8 proc
	push	bp
	mov	bp,sp
	sub	sp,2h
	push	di
	push	si
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:260Eh
	add	sp,4h
	mov	di,ax
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	call	0E04h
	add	sp,4h
	mov	si,ax
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	di
	mov	ax,1h
	push	ax
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:0924h
	add	sp,0Ch
	mov	[bp-2h],ax
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	si
	call	0E85h
	add	sp,6h
	cmp	[bp-2h],di
	jnz	2800h

l149A_27FC:
	sub	ax,ax
	jmp	2803h

l149A_2800:
	mov	ax,0FFFFh

l149A_2803:
	pop	si
	pop	di
	mov	sp,bp
	pop	bp
	retf
149A:2809                            90                            .      

;; fn149A_280A: 149A:280A
;;   Called from:
;;     0800:2904 (in main)
;;     0800:29E7 (in main)
;;     0800:2A4E (in main)
;;     0800:33F4 (in main)
;;     1054:16E0 (in fn1054_0DB3)
fn149A_280A proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	push	di
	push	si
	mov	byte ptr [38A8h],42h
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	mov	[38A4h],ax
	mov	[38A6h],dx
	mov	si,389Eh
	mov	[si],ax
	mov	[si+2h],dx
	mov	word ptr [38A2h],7FFFh
	lea	ax,[bp+0Eh]
	push	ss
	push	ax
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	mov	ax,si
	push	ds
	push	ax
	call	far 149Ah:17F6h
	add	sp,0Ch
	mov	di,ax
	dec	word ptr [38A2h]
	js	2860h

l149A_2851:
	les	bx,[389Eh]
	inc	word ptr [389Eh]
	mov	byte ptr es:[bx],0h
	jmp	286Dh
149A:285F                                              90                .

l149A_2860:
	push	ds
	push	si
	sub	ax,ax
	push	ax
	call	far 149Ah:0B9Ch
	add	sp,6h

l149A_286D:
	mov	ax,di
	pop	si
	pop	di
	mov	sp,bp
	pop	bp
	retf
149A:2875                90                                    .          

;; fn149A_2876: 149A:2876
;;   Called from:
;;     0800:22FE (in main)
;;     0800:23ED (in main)
;;     0800:27F3 (in main)
;;     0800:34AB (in main)
;;     0800:34ED (in main)
;;     1054:1C88 (in fn1054_1A49)
;;     1054:1DB2 (in fn1054_1A49)
;;     1054:24A0 (in fn1054_1A49)
;;     1484:0054 (in fn1484_000E)
fn149A_2876 proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	push	si
	mov	byte ptr [38B4h],49h
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	mov	[38B0h],ax
	mov	[38B2h],dx
	mov	si,38AAh
	mov	[si],ax
	mov	[si+2h],dx
	push	dx
	push	ax
	call	far 149Ah:260Eh
	add	sp,4h
	mov	[38AEh],ax
	lea	ax,[bp+0Eh]
	push	ss
	push	ax
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	mov	ax,38AAh
	push	ds
	push	ax
	call	far 149Ah:0FA2h
	add	sp,0Ch
	pop	si
	mov	sp,bp
	pop	bp
	retf
149A:28C1    90                                            .              

;; fn149A_28C2: 149A:28C2
;;   Called from:
;;     0800:20BC (in main)
;;     0800:82A3 (in fn0800_8095)
;;     1054:0F10 (in fn1054_0DB3)
;;     1054:3ABA (in fn1054_3A11)
;;     1054:4014 (in fn1054_3F70)
fn149A_28C2 proc
	push	bp
	mov	bp,sp
	mov	ax,1h
	push	ax
	sub	ax,ax
	push	ax
	push	ax
	push	word ptr [bp+6h]
	call	far 149Ah:1DEAh
	mov	sp,bp
	pop	bp
	retf
149A:28D9                            90                            .      

;; fn149A_28DA: 149A:28DA
;;   Called from:
;;     149A:35B1 (in fn149A_3544)
fn149A_28DA proc
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	ds
	lds	di,[bp+6h]
	mov	ax,[di]
	mov	bx,[di+2h]
	mov	cx,[di+4h]
	mov	dx,[di+6h]
	mov	si,[di+8h]
	push	word ptr [di+0Ah]
	lds	di,[bp+0Eh]
	mov	es,[di]
	mov	ds,[di+6h]
	pop	di
	int	21h
	push	di
	push	ds
	lds	di,[bp+0Eh]
	mov	[di],es
	pop	word ptr [di+6h]
	lds	di,[bp+0Ah]
	mov	[di],ax
	mov	[di+2h],bx
	mov	[di+4h],cx
	mov	[di+6h],dx
	mov	[di+8h],si
	pop	word ptr [di+0Ah]
	jc	2923h

l149A_291F:
	xor	si,si
	jmp	2931h

l149A_2923:
	pop	ds
	push	ds
	push	cs
	call	0608h
	lds	di,[bp+0Ah]
	mov	si,1h
	mov	ax,[di]

l149A_2931:
	mov	[di+0Ch],si
	pop	ds
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf
149A:293B                                  00                        .    

;; fn149A_293C: 149A:293C
;;   Called from:
;;     0800:05ED (in fn0800_05CC)
;;     0800:0604 (in fn0800_05CC)
;;     0800:06A6 (in fn0800_05CC)
;;     0800:07CC (in fn0800_0784)
;;     0800:0892 (in fn0800_084A)
;;     0800:1913 (in main)
;;     0800:21BA (in main)
;;     0800:2491 (in main)
;;     0800:2532 (in main)
;;     0800:2D09 (in main)
;;     0800:2D47 (in main)
;;     0800:2EFD (in main)
;;     0800:3353 (in main)
;;     0800:34C3 (in main)
;;     0800:41D5 (in fn0800_41BB)
;;     0800:516A (in fn0800_514D)
;;     0800:51D1 (in fn0800_514D)
;;     1054:015D (in fn1054_0104)
;;     1054:0E0E (in fn1054_0DB3)
;;     1054:11B5 (in fn1054_0DB3)
;;     149A:2CC2 (in fn149A_2B5A)
;;     149A:2CF2 (in fn149A_2B5A)
;;     149A:2DA9 (in fn149A_2B5A)
;;     149A:2DBD (in fn149A_2B5A)
;;     149A:2E76 (in fn149A_2B5A)
;;     149A:3108 (in fn149A_3068)
;;     149A:328C (in fn149A_3236)
;;     149A:32A2 (in fn149A_3236)
fn149A_293C proc
	push	bp
	mov	bp,sp
	push	di
	les	di,[bp+6h]
	mov	bx,di
	xor	ax,ax
	mov	cx,0FFFFh
	repne scasb
	inc	cx
	neg	cx
	mov	al,[bp+0Ah]
	mov	di,bx

l149A_2954:
	repne scasb

l149A_2956:
	dec	di
	cmp	es:[di],al
	jz	2960h

l149A_295C:
	xor	di,di
	mov	es,di

l149A_2960:
	mov	ax,di
	mov	dx,es
	pop	di
	mov	sp,bp
	pop	bp
	retf
149A:2969                            00                            .      

;; fn149A_296A: 149A:296A
;;   Called from:
;;     0800:0B02 (in fn0800_0AC7)
;;     0800:3038 (in main)
;;     0800:30AE (in main)
;;     0800:3418 (in main)
;;     149A:3123 (in fn149A_3068)
fn149A_296A proc
	push	bp
	mov	bp,sp
	mov	dx,si
	push	ds
	lds	si,[bp+0Ah]
	les	bx,[bp+6h]
	mov	al,0FFh

l149A_2978:
	or	al,al
	jz	29A9h

l149A_297C:
	lodsb
	mov	ah,es:[bx]
	inc	bx
	cmp	ah,al
	jz	2978h

l149A_2985:
	sub	al,41h
	cmp	al,1Ah
	sbb	cl,cl
	and	cl,20h
	add	al,cl
	add	al,41h
	xchg	al,ah
	sub	al,41h
	cmp	al,1Ah
	sbb	cl,cl
	and	cl,20h
	add	al,cl
	add	al,41h
	cmp	al,ah
	jz	2978h

l149A_29A5:
	sbb	al,al
	sbb	al,0FFh

l149A_29A9:
	cbw
	pop	ds
	mov	si,dx
	pop	bp
	retf
149A:29AF                                              00                .

;; fn149A_29B0: 149A:29B0
;;   Called from:
;;     0800:0685 (in fn0800_05CC)
;;     0800:0718 (in fn0800_06D9)
;;     0800:199C (in main)
;;     0800:19EC (in main)
;;     1054:0181 (in fn1054_0104)
;;     1054:0E35 (in fn1054_0DB3)
;;     1054:118C (in fn1054_0DB3)
;;     149A:30A8 (in fn149A_3068)
;;     149A:30C0 (in fn149A_3068)
fn149A_29B0 proc
	push	bp
	mov	bp,sp
	push	di
	les	di,[bp+6h]
	xor	ax,ax
	mov	cx,0FFFFh
	repne scasb
	inc	cx
	neg	cx
	dec	di
	mov	al,[bp+0Ah]
	std

l149A_29C6:
	repne scasb

l149A_29C8:
	inc	di
	cmp	es:[di],al
	jz	29D4h

l149A_29CE:
	xor	ax,ax
	mov	dx,ax
	jmp	29D8h

l149A_29D4:
	mov	ax,di
	mov	dx,es

l149A_29D8:
	cld
	pop	di
	mov	sp,bp
	pop	bp
	retf

;; fn149A_29DE: 149A:29DE
;;   Called from:
;;     149A:0880 (in fn149A_0833)
;;     149A:0A12 (in fn149A_09C5)
fn149A_29DE proc
	push	bp
	mov	bp,sp
	mov	cx,[bp+0Eh]
	push	ds
	push	di
	push	si
	jcxz	2A31h

l149A_29E9:
	lds	si,[bp+0Ah]
	les	di,[bp+6h]

l149A_29EF:
	mov	ax,cx
	dec	ax
	mov	dx,di
	not	dx
	sub	ax,dx
	sbb	bx,bx
	and	ax,bx
	add	ax,dx
	mov	dx,si
	not	dx
	sub	ax,dx
	sbb	bx,bx
	and	ax,bx
	add	ax,dx
	inc	ax
	xchg	cx,ax
	sub	ax,cx
	shr	cx,1h
	rep movsw
	adc	cx,cx
	rep movsb
	xchg	cx,ax
	jcxz	2A31h

l149A_2A19:
	or	si,si
	jnz	2A24h

l149A_2A1D:
	mov	ax,ds
	add	ax,1000h
	mov	ds,ax

l149A_2A24:
	or	di,di
	jnz	29EFh

l149A_2A28:
	mov	ax,es
	add	ax,1000h
	mov	es,ax
	jmp	29EFh

l149A_2A31:
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	pop	si
	pop	di
	pop	ds
	pop	bp
	retf

;; fn149A_2A3C: 149A:2A3C
;;   Called from:
;;     149A:115C (in fn149A_0FA2)
fn149A_2A3C proc
	push	bp
	mov	bp,sp
	mov	cx,[bp+0Ch]
	jcxz	2A7Ch

l149A_2A44:
	push	di
	les	di,[bp+6h]
	mov	dx,di
	neg	dx
	jz	2A5Ah

l149A_2A4E:
	sub	dx,cx
	sbb	bx,bx
	and	dx,bx
	add	dx,cx
	xchg	cx,dx
	sub	dx,cx

l149A_2A5A:
	mov	ax,[bp+0Ah]
	mov	ah,al
	shr	cx,1h

l149A_2A61:
	rep stosw

l149A_2A63:
	adc	cx,cx

l149A_2A65:
	rep stosb

l149A_2A67:
	xchg	cx,dx
	jcxz	2A7Bh

l149A_2A6B:
	mov	bx,es
	add	bx,1000h
	mov	es,bx
	shr	cx,1h

l149A_2A75:
	rep stosw

l149A_2A77:
	adc	cx,cx

l149A_2A79:
	rep stosb

l149A_2A7B:
	pop	di

l149A_2A7C:
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	pop	bp
	retf
149A:2A84             8B 4E 0E 8B 46 06 8B 56 08 1E C5 7E     .N..F..V...~
149A:2A90 0A                                              .               

l149A_2A91:
	push	di
	push	ds
	pop	es
	cld
	xchg	bx,ax
	or	al,al
	jz	2AADh

l149A_2A9A:
	cmp	cx,0Ah
	jnz	2AADh

l149A_2A9F:
	or	dx,dx
	jns	2AADh

l149A_2AA3:
	mov	al,2Dh
	stosb
	neg	bx
	adc	dx,0h
	neg	dx

l149A_2AAD:
	mov	si,di

l149A_2AAF:
	xchg	dx,ax
	xor	dx,dx
	or	ax,ax
	jz	2AB8h

l149A_2AB6:
	div	cx

l149A_2AB8:
	xchg	bx,ax
	div	cx
	xchg	dx,ax
	xchg	bx,dx
	add	al,30h
	cmp	al,39h
	jbe	2AC6h

l149A_2AC4:
	add	al,27h

l149A_2AC6:
	stosb
	mov	ax,dx
	or	ax,bx
	jnz	2AAFh

l149A_2ACD:
	mov	[di],al

l149A_2ACF:
	dec	di
	lodsb
	xchg	[di],al
	mov	[si-1h],al
	lea	ax,[si+1h]
	cmp	ax,di
	jc	2ACFh

l149A_2ADD:
	mov	dx,ds
	pop	ax
	pop	ds
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf
149A:2AE7                      00                                .        

;; fn149A_2AE8: 149A:2AE8
;;   Called from:
;;     149A:330C (in fn149A_3236)
fn149A_2AE8 proc
	push	bp
	mov	bp,sp
	sub	sp,4h
	mov	ax,[bp+4h]
	mov	dx,[bp+6h]
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	dec	word ptr [bp+0Ch]
	jz	2B3Ch

l149A_2AFF:
	les	bx,[bp+4h]
	cmp	byte ptr es:[bx],0h
	jz	2B33h

l149A_2B08:
	cmp	byte ptr es:[bx],3Bh
	jz	2B33h

l149A_2B0E:
	mov	al,es:[bx]
	les	bx,[bp+8h]
	mov	es:[bx],al
	inc	word ptr [bp+4h]
	inc	word ptr [bp+8h]
	dec	word ptr [bp+0Ch]
	jnz	2AFFh

l149A_2B22:
	mov	ax,[bp+4h]
	mov	dx,[bp+6h]
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	jmp	2B3Ch

l149A_2B30:
	inc	word ptr [bp+4h]

l149A_2B33:
	mov	bx,[bp+4h]
	cmp	byte ptr es:[bx],3Bh
	jz	2B30h

l149A_2B3C:
	les	bx,[bp+8h]
	mov	byte ptr es:[bx],0h
	mov	ax,[bp+4h]
	mov	dx,[bp+6h]
	cmp	[bp-4h],ax
	jnz	2B56h

l149A_2B4E:
	cmp	[bp-2h],dx
	jnz	2B56h

l149A_2B53:
	sub	ax,ax
	cwd

l149A_2B56:
	mov	sp,bp
	pop	bp
	ret

;; fn149A_2B5A: 149A:2B5A
;;   Called from:
;;     149A:3026 (in fn149A_2FB2)
fn149A_2B5A proc
	push	bp
	mov	bp,sp
	sub	sp,16h
	push	si
	sub	si,si
	mov	ax,[bp+0Ch]
	or	ax,[bp+0Ah]
	jnz	2B78h

l149A_2B6B:
	mov	ax,[31C5h]
	mov	dx,[31C7h]
	mov	[bp+0Ah],ax
	mov	[bp+0Ch],dx

l149A_2B78:
	mov	ax,[bp+0Ch]
	or	ax,[bp+0Ah]
	jz	2BB6h

l149A_2B80:
	mov	ax,[bp+0Ah]
	mov	dx,[bp+0Ch]
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	jmp	2BA4h

l149A_2B8E:
	add	word ptr [bp-0Ah],4h
	push	word ptr es:[bx+2h]
	push	word ptr es:[bx]
	call	far 149Ah:260Eh
	add	sp,4h
	inc	ax
	add	si,ax

l149A_2BA4:
	les	bx,[bp-0Ah]
	mov	ax,es:[bx+2h]
	or	ax,es:[bx]
	jz	2BB6h

l149A_2BB0:
	cmp	si,7FFFh
	jbe	2B8Eh

l149A_2BB6:
	cmp	word ptr [358Eh],0h
	jz	2BDCh

l149A_2BBD:
	mov	ax,[31A9h]
	mov	[bp-2h],ax
	jmp	2BC9h
149A:2BC5                90                                    .          

l149A_2BC6:
	dec	word ptr [bp-2h]

l149A_2BC9:
	cmp	word ptr [bp-2h],0h
	jz	2BE1h

l149A_2BCF:
	mov	bx,[bp-2h]
	cmp	byte ptr [bx+31AAh],0h
	jnz	2BE1h

l149A_2BD9:
	jmp	2BC6h
149A:2BDB                                  90                        .    

l149A_2BDC:
	mov	word ptr [bp-2h],0h

l149A_2BE1:
	cmp	word ptr [bp-2h],0h
	jz	2BF1h

l149A_2BE7:
	mov	ax,[bp-2h]
	add	ax,7h
	shl	ax,1h
	add	si,ax

l149A_2BF1:
	mov	ax,[bp+1Ch]
	or	ax,[bp+1Ah]
	jz	2C0Ch

l149A_2BF9:
	push	word ptr [bp+1Ch]
	push	word ptr [bp+1Ah]
	call	far 149Ah:260Eh
	add	sp,4h
	add	ax,3h
	add	si,ax

l149A_2C0C:
	inc	si
	mov	[bp-0Ch],si
	cmp	si,7FFFh
	jbe	2C28h

l149A_2C16:
	mov	word ptr [319Ch],7h
	mov	word ptr [31A7h],0Ah

l149A_2C22:
	mov	ax,0FFFFh
	jmp	2EB4h

l149A_2C28:
	mov	si,[3468h]
	mov	word ptr [3468h],10h
	mov	ax,[bp-0Ch]
	add	ax,0Fh
	push	ax
	call	far 149Ah:22A2h
	add	sp,2h
	mov	[bp-12h],ax
	mov	[bp-10h],dx
	or	dx,ax
	jnz	2C5Eh

l149A_2C4B:
	mov	word ptr [319Ch],0Ch
	mov	word ptr [31A7h],8h
	mov	[3468h],si
	jmp	2C22h
149A:2C5D                                        90                    .  

l149A_2C5E:
	mov	[3468h],si
	mov	dx,[bp-10h]
	les	bx,[bp+0Eh]
	mov	es:[bx],ax
	mov	es:[bx+2h],dx
	add	ax,0Fh
	and	al,0F0h
	mov	[bp-12h],ax
	les	bx,[bp+12h]
	mov	es:[bx],ax
	mov	es:[bx+2h],dx
	mov	ax,[bp+0Ch]
	or	ax,[bp+0Ah]
	jz	2CD4h

l149A_2C89:
	mov	ax,[bp+0Ah]
	mov	dx,[bp+0Ch]
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	jmp	2C9Ch
149A:2C97                      90                                .        

l149A_2C98:
	add	word ptr [bp-0Ah],4h

l149A_2C9C:
	les	bx,[bp-0Ah]
	mov	ax,es:[bx+2h]
	or	ax,es:[bx]
	jz	2CD4h

l149A_2CA8:
	sub	ax,ax
	push	ax
	push	word ptr es:[bx+2h]
	push	word ptr es:[bx]
	push	word ptr [bp-10h]
	push	word ptr [bp-12h]
	call	far 149Ah:25AEh
	add	sp,8h
	push	dx
	push	ax
	call	far 149Ah:293Ch
	add	sp,6h
	inc	ax
	mov	[bp-12h],ax
	mov	[bp-10h],dx
	jmp	2C98h
149A:2CD3          90                                        .            

l149A_2CD4:
	cmp	word ptr [bp-2h],0h
	jz	2D3Fh

l149A_2CDA:
	sub	ax,ax
	push	ax
	mov	ax,3180h
	push	ds
	push	ax
	push	word ptr [bp-10h]
	push	word ptr [bp-12h]
	call	far 149Ah:25AEh
	add	sp,8h
	push	dx
	push	ax
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-12h],ax
	mov	[bp-10h],dx
	sub	si,si
	jmp	2D2Bh

l149A_2D04:
	mov	al,[si+31ABh]
	mov	cl,4h
	mov	dx,ax
	sar	al,cl
	and	al,0Fh
	add	al,41h
	les	bx,[bp-12h]
	inc	word ptr [bp-12h]
	mov	es:[bx],al
	and	dl,0Fh
	add	dl,41h
	mov	bx,[bp-12h]
	inc	word ptr [bp-12h]
	mov	es:[bx],dl
	inc	si

l149A_2D2B:
	mov	ax,[bp-2h]
	dec	word ptr [bp-2h]
	or	ax,ax
	jnz	2D04h

l149A_2D35:
	les	bx,[bp-12h]
	inc	word ptr [bp-12h]
	mov	byte ptr es:[bx],0h

l149A_2D3F:
	les	bx,[bp-12h]
	inc	word ptr [bp-12h]
	mov	byte ptr es:[bx],0h
	mov	ax,[bp+1Ch]
	or	ax,[bp+1Ah]
	jz	2D77h

l149A_2D51:
	mov	bx,[bp-12h]
	inc	word ptr [bp-12h]
	mov	byte ptr es:[bx],1h
	mov	bx,[bp-12h]
	inc	word ptr [bp-12h]
	mov	byte ptr es:[bx],0h
	push	word ptr [bp+1Ch]
	push	word ptr [bp+1Ah]
	push	es
	push	word ptr [bp-12h]
	call	far 149Ah:25AEh
	add	sp,8h

l149A_2D77:
	sub	si,si
	mov	ax,[bp+16h]
	mov	dx,[bp+18h]
	inc	ax
	mov	[bp-12h],ax
	mov	[bp-10h],dx
	mov	cx,[bp+20h]
	or	cx,[bp+1Eh]
	jz	2DD6h

l149A_2D8E:
	sub	cx,cx
	push	cx
	push	word ptr [bp+20h]
	push	word ptr [bp+1Eh]
	push	cx
	mov	cx,358Ah
	push	ds
	push	cx
	push	dx
	push	ax
	call	far 149Ah:25AEh
	add	sp,8h
	push	dx
	push	ax
	call	far 149Ah:293Ch
	add	sp,6h
	push	dx
	push	ax
	call	far 149Ah:25AEh
	add	sp,8h
	push	dx
	push	ax
	call	far 149Ah:293Ch
	add	sp,6h
	mov	es,dx
	mov	si,ax
	sub	si,4h
	mov	[bp-12h],si
	mov	[bp-10h],es
	sub	si,[bp+16h]
	dec	si

l149A_2DD6:
	les	bx,[bp+6h]
	mov	ax,es:[bx+2h]
	or	ax,es:[bx]
	jnz	2DE5h

l149A_2DE2:
	jmp	2EA2h

l149A_2DE5:
	mov	ax,es:[bx+6h]
	or	ax,es:[bx+4h]
	jz	2DFAh

l149A_2DEF:
	les	bx,[bp-12h]
	inc	word ptr [bp-12h]
	mov	byte ptr es:[bx],20h
	inc	si

l149A_2DFA:
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	add	ax,4h
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx

l149A_2E09:
	les	bx,[bp-0Ah]
	mov	ax,es:[bx+2h]
	or	ax,es:[bx]
	jnz	2E18h

l149A_2E15:
	jmp	2EA2h

l149A_2E18:
	push	word ptr es:[bx+2h]
	push	word ptr es:[bx]
	call	far 149Ah:260Eh
	add	sp,4h
	mov	[bp-0Eh],ax
	add	ax,si
	cmp	ax,7Dh
	jbe	2E52h

l149A_2E31:
	mov	word ptr [319Ch],7h
	mov	word ptr [31A7h],0Ah
	les	bx,[bp+0Eh]
	push	word ptr es:[bx+2h]
	push	word ptr es:[bx]
	call	far 149Ah:22A8h
	add	sp,4h
	jmp	2C22h

l149A_2E52:
	add	si,[bp-0Eh]
	sub	ax,ax
	push	ax
	les	bx,[bp-0Ah]
	add	word ptr [bp-0Ah],4h
	push	word ptr es:[bx+2h]
	push	word ptr es:[bx]
	push	word ptr [bp-10h]
	push	word ptr [bp-12h]
	call	far 149Ah:25AEh
	add	sp,8h
	push	dx
	push	ax
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-12h],ax
	mov	[bp-10h],dx
	les	bx,[bp-0Ah]
	mov	ax,es:[bx+2h]
	or	ax,es:[bx]
	jnz	2E93h

l149A_2E90:
	jmp	2E09h

l149A_2E93:
	les	bx,[bp-12h]
	inc	word ptr [bp-12h]
	mov	byte ptr es:[bx],20h
	inc	si
	jmp	2E09h
149A:2EA1    90                                            .              

l149A_2EA2:
	les	bx,[bp-12h]
	mov	byte ptr es:[bx],0Dh
	mov	ax,si
	les	bx,[bp+16h]
	mov	es:[bx],al
	mov	ax,[bp-0Ch]

l149A_2EB4:
	pop	si
	mov	sp,bp
	pop	bp
	retf
149A:2EB9                            90 00 00 00 00 00 00          .......
149A:2EC0 00 00 00 00                                     ....            

;; fn149A_2EC4: 149A:2EC4
;;   Called from:
;;     149A:3046 (in fn149A_2FB2)
fn149A_2EC4 proc
	push	bp
	mov	bp,sp
	cmp	word ptr [bp+6h],1h
	jz	2EE0h

l149A_2ECD:
	cmp	word ptr [bp+6h],0h
	jz	2EE0h

l149A_2ED3:
	mov	word ptr [319Ch],16h
	mov	ax,0FFFFh
	clc
	jmp	05FBh

l149A_2EE0:
	push	si
	push	di
	mov	ax,[bp+12h]
	mov	bx,[bp+10h]
	mov	cl,4h
	shr	bx,cl
	add	ax,bx
	mov	[3590h],ax
	mov	ax,[bp+0Ch]
	mov	[3592h],ax
	mov	ax,[bp+0Eh]
	mov	[3594h],ax
	mov	[3598h],ds
	mov	[359Ch],ds
	push	ds
	pop	es
	push	ds
	lds	si,[3592h]
	inc	si
	mov	di,359Eh
	mov	ax,2901h
	int	21h
	mov	ax,2901h
	mov	di,35AEh
	int	21h
	pop	ds
	cmp	word ptr [35FEh],0D6D6h
	jnz	2F2Dh

l149A_2F26:
	mov	bx,0FFFFh
	call	word ptr [3600h]

l149A_2F2D:
	push	bp
	push	es
	push	ds
	mov	cs:[2EBCh],ss
	mov	cs:[2EBAh],sp
	mov	di,2Eh
	mov	si,[di]
	mov	cs:[2EBEh],si
	mov	si,[di+2h]
	mov	cs:[2EC0h],si
	mov	cs:[2EC2h],ds
	mov	bx,3590h
	cmp	word ptr [bp+6h],0h
	jz	2F60h

l149A_2F5A:
	mov	al,4h
	xor	cx,cx
	jmp	2F62h

l149A_2F60:
	xor	al,al

l149A_2F62:
	clc
	push	ax
	mov	ah,0Bh
	int	21h
	pop	ax
	mov	word ptr [31CEh],1h
	lds	dx,[bp+8h]
	mov	ah,4Bh
	int	21h
	xchg	bx,ax
	lahf
	cli
	mov	ss,cs:[2EBCh]
	mov	sp,cs:[2EBAh]
	sti
	mov	di,2Eh
	mov	ds,cs:[2EC2h]
	mov	si,cs:[2EC0h]
	mov	[di+2h],si
	mov	si,cs:[2EBEh]
	mov	[di],si
	sahf
	xchg	bx,ax
	pop	ds
	mov	word ptr [31CEh],0h
	pop	es
	pop	bp
	pop	di
	pop	si
	jc	2FAEh

l149A_2FAA:
	mov	ah,4Dh
	int	21h

l149A_2FAE:
	jmp	05FBh
149A:2FB1    00                                            .              

;; fn149A_2FB2: 149A:2FB2
;;   Called from:
;;     149A:3141 (in fn149A_3068)
;;     149A:3215 (in fn149A_3068)
fn149A_2FB2 proc
	push	ds
	pop	ax
	nop
	inc	bp
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,ax
	mov	ax,90h
	call	far 149Ah:02C8h
	cmp	word ptr [bp+14h],0h
	jnz	2FF8h

l149A_2FCA:
	mov	ax,[bp+8h]
	mov	dx,[bp+0Ah]
	mov	[bp-0Ch],ax
	mov	[bp-0Ah],dx
	mov	ax,35BEh
	push	ds
	push	ax
	call	far 149Ah:26A0h
	add	sp,4h
	mov	[bp+8h],ax
	mov	[bp+0Ah],dx
	or	dx,ax
	jnz	3000h

l149A_2FED:
	mov	word ptr [319Ch],8h

l149A_2FF3:
	mov	ax,0FFFFh
	jmp	305Fh

l149A_2FF8:
	sub	ax,ax
	mov	[bp-0Ah],ax
	mov	[bp-0Ch],ax

l149A_3000:
	push	word ptr [bp-0Ah]
	push	word ptr [bp-0Ch]
	sub	ax,ax
	push	ax
	push	ax
	lea	ax,[bp+0FF70h]
	push	ss
	push	ax
	lea	ax,[bp-6h]
	push	ss
	push	ax
	lea	ax,[bp-10h]
	push	ss
	push	ax
	push	word ptr [bp+12h]
	push	word ptr [bp+10h]
	push	word ptr [bp+0Eh]
	push	word ptr [bp+0Ch]
	call	far 149Ah:2B5Ah
	add	sp,1Ch
	inc	ax
	jz	2FF3h

l149A_3031:
	push	word ptr [bp-4h]
	push	word ptr [bp-6h]
	lea	ax,[bp+0FF70h]
	push	ss
	push	ax
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:2EC4h
	add	sp,0Eh
	mov	[bp-8h],ax
	push	word ptr [bp-0Eh]
	push	word ptr [bp-10h]
	call	far 149Ah:22A8h
	mov	ax,[bp-8h]

l149A_305F:
	dec	bp
	dec	bp
	mov	sp,bp
	pop	ds
	pop	bp
	dec	bp
	retf
149A:3067                      90                                .        

;; fn149A_3068: 149A:3068
;;   Called from:
;;     149A:326D (in fn149A_3236)
;;     149A:33A7 (in fn149A_3236)
;;     149A:3486 (in fn149A_3404)
fn149A_3068 proc
	push	ds
	pop	ax
	nop
	inc	bp
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,ax
	mov	ax,14h
	call	far 149Ah:02C8h
	cmp	word ptr [bp+6h],2h
	jnz	309Eh

l149A_3080:
	push	word ptr [bp+12h]
	push	word ptr [bp+10h]
	push	word ptr [bp+0Eh]
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	call	far 149Ah:34D0h
	add	sp,0Ch
	jmp	322Eh
149A:309D                                        90                    .  

l149A_309E:
	mov	ax,5Ch
	push	ax
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	call	far 149Ah:29B0h
	add	sp,6h
	mov	[bp-14h],ax
	mov	[bp-12h],dx
	mov	ax,2Fh
	push	ax
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	call	far 149Ah:29B0h
	add	sp,6h
	mov	[bp-6h],ax
	mov	[bp-4h],dx
	or	dx,ax
	jnz	30E2h

l149A_30D2:
	mov	ax,[bp-12h]
	or	ax,[bp-14h]
	jnz	30FEh

l149A_30DA:
	mov	ax,[bp+8h]
	mov	dx,[bp+0Ah]
	jmp	30F8h

l149A_30E2:
	mov	ax,[bp-12h]
	or	ax,[bp-14h]
	jz	30F2h

l149A_30EA:
	mov	ax,[bp-14h]
	cmp	[bp-6h],ax
	jbe	30FEh

l149A_30F2:
	mov	ax,[bp-6h]
	mov	dx,[bp-4h]

l149A_30F8:
	mov	[bp-14h],ax
	mov	[bp-12h],dx

l149A_30FE:
	mov	ax,2Eh
	push	ax
	push	word ptr [bp-12h]
	push	word ptr [bp-14h]
	call	far 149Ah:293Ch
	add	sp,6h
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	or	dx,ax
	jz	3150h

l149A_311A:
	push	ds
	push	word ptr [35D6h]
	push	word ptr [bp-8h]
	push	ax
	call	far 149Ah:296Ah
	add	sp,8h
	push	ax
	push	word ptr [bp+12h]
	push	word ptr [bp+10h]
	push	word ptr [bp+0Eh]
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:2FB2h
	add	sp,10h
	mov	[bp-0Eh],ax
	jmp	322Bh
149A:314F                                              90                .

l149A_3150:
	mov	ax,[3468h]
	mov	[bp-0Ch],ax
	mov	word ptr [3468h],10h
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	call	far 149Ah:260Eh
	add	sp,4h
	add	ax,5h
	push	ax
	call	far 149Ah:22A2h
	add	sp,2h
	mov	[bp-14h],ax
	mov	[bp-12h],dx
	mov	ax,[bp-0Ch]
	mov	[3468h],ax
	mov	ax,dx
	or	ax,[bp-14h]
	jnz	3190h

l149A_3189:
	mov	ax,0FFFFh
	jmp	322Eh
149A:318F                                              90                .

l149A_3190:
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	push	dx
	push	word ptr [bp-14h]
	call	far 149Ah:25AEh
	add	sp,8h
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	call	far 149Ah:260Eh
	add	sp,4h
	add	ax,[bp-14h]
	mov	dx,[bp-12h]
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	mov	word ptr [bp-0Eh],0FFFFh
	mov	word ptr [bp-10h],2h
	jmp	31CBh

l149A_31C8:
	dec	word ptr [bp-10h]

l149A_31CB:
	cmp	word ptr [bp-10h],0h
	jl	3220h

l149A_31D1:
	mov	bx,[bp-10h]
	shl	bx,1h
	push	ds
	push	word ptr [bx+35D6h]
	push	word ptr [bp-8h]
	push	word ptr [bp-0Ah]
	call	far 149Ah:25AEh
	add	sp,8h
	sub	ax,ax
	push	ax
	push	word ptr [bp-12h]
	push	word ptr [bp-14h]
	call	far 149Ah:34E6h
	add	sp,6h
	inc	ax
	jz	31C8h

l149A_31FD:
	push	word ptr [bp-10h]
	push	word ptr [bp+12h]
	push	word ptr [bp+10h]
	push	word ptr [bp+0Eh]
	push	word ptr [bp+0Ch]
	push	word ptr [bp-12h]
	push	word ptr [bp-14h]
	push	word ptr [bp+6h]
	call	far 149Ah:2FB2h
	add	sp,10h
	mov	[bp-0Eh],ax

l149A_3220:
	push	word ptr [bp-12h]
	push	word ptr [bp-14h]
	call	far 149Ah:22A8h

l149A_322B:
	mov	ax,[bp-0Eh]

l149A_322E:
	dec	bp
	dec	bp
	mov	sp,bp
	pop	ds
	pop	bp
	dec	bp
	retf

;; fn149A_3236: 149A:3236
;;   Called from:
;;     149A:34C3 (in fn149A_3404)
fn149A_3236 proc
	push	ds
	pop	ax
	nop
	inc	bp
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,ax
	sub	sp,12h
	push	si
	sub	ax,ax
	mov	[bp-10h],ax
	mov	[bp-12h],ax
	mov	ax,[3468h]
	mov	[bp-4h],ax
	mov	word ptr [3468h],10h
	push	word ptr [bp+12h]
	push	word ptr [bp+10h]
	push	word ptr [bp+0Eh]
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	call	far 149Ah:3068h
	add	sp,0Eh
	mov	[bp-6h],ax
	inc	ax
	jnz	32EBh

l149A_327B:
	cmp	word ptr [319Ch],2h
	jnz	32EBh

l149A_3282:
	mov	ax,2Fh
	push	ax
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	call	far 149Ah:293Ch
	add	sp,6h
	or	dx,ax
	jnz	32EBh

l149A_3298:
	mov	ax,5Ch
	push	ax
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	call	far 149Ah:293Ch
	add	sp,6h
	or	dx,ax
	jnz	32EBh

l149A_32AE:
	les	bx,[bp+8h]
	cmp	byte ptr es:[bx],0h
	jz	32BEh

l149A_32B7:
	cmp	byte ptr es:[bx+1h],3Ah
	jz	32EBh

l149A_32BE:
	mov	ax,35DCh
	push	ds
	push	ax
	call	far 149Ah:26A0h
	add	sp,4h
	mov	[bp-0Eh],ax
	mov	[bp-0Ch],dx
	or	dx,ax
	jz	32EBh

l149A_32D5:
	mov	ax,104h
	push	ax
	call	far 149Ah:22A2h
	add	sp,2h
	mov	[bp-12h],ax
	mov	[bp-10h],dx
	or	dx,ax
	jnz	32F6h

l149A_32EB:
	mov	ax,[bp-4h]
	mov	[3468h],ax
	jmp	33E2h
149A:32F4             90 90                                   ..          

l149A_32F6:
	mov	ax,[bp-4h]
	mov	[3468h],ax

l149A_32FC:
	mov	ax,103h
	push	ax
	push	word ptr [bp-10h]
	push	word ptr [bp-12h]
	push	word ptr [bp-0Ch]
	push	word ptr [bp-0Eh]
	call	2AE8h
	add	sp,0Ah
	mov	[bp-0Eh],ax
	mov	[bp-0Ch],dx
	or	dx,ax
	jnz	331Fh

l149A_331C:
	jmp	33E2h

l149A_331F:
	les	bx,[bp-12h]
	cmp	byte ptr es:[bx],0h
	jnz	332Bh

l149A_3328:
	jmp	33E2h

l149A_332B:
	push	es
	push	bx
	call	far 149Ah:260Eh
	add	sp,4h
	les	bx,[bp-12h]
	add	bx,ax
	dec	bx
	cmp	byte ptr es:[bx],5Ch
	jz	3358h

l149A_3341:
	cmp	byte ptr es:[bx],2Fh
	jz	3358h

l149A_3347:
	mov	ax,35E1h
	push	ds
	push	ax
	push	es
	push	word ptr [bp-12h]
	call	far 149Ah:2568h
	add	sp,8h

l149A_3358:
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	call	far 149Ah:260Eh
	add	sp,4h
	push	word ptr [bp-10h]
	push	word ptr [bp-12h]
	mov	si,ax
	call	far 149Ah:260Eh
	add	sp,4h
	add	si,ax
	cmp	si,104h
	jnc	33E2h

l149A_337E:
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	push	word ptr [bp-10h]
	push	word ptr [bp-12h]
	call	far 149Ah:2568h
	add	sp,8h
	push	word ptr [bp+12h]
	push	word ptr [bp+10h]
	push	word ptr [bp+0Eh]
	push	word ptr [bp+0Ch]
	push	word ptr [bp-10h]
	push	word ptr [bp-12h]
	push	word ptr [bp+6h]
	call	far 149Ah:3068h
	add	sp,0Eh
	mov	[bp-6h],ax
	inc	ax
	jnz	33E2h

l149A_33B5:
	cmp	word ptr [319Ch],2h
	jnz	33BFh

l149A_33BC:
	jmp	32FCh

l149A_33BF:
	les	bx,[bp-12h]
	cmp	byte ptr es:[bx],5Ch
	jz	33CEh

l149A_33C8:
	cmp	byte ptr es:[bx],2Fh
	jnz	33E2h

l149A_33CE:
	cmp	byte ptr es:[bx+1h],5Ch
	jnz	33D8h

l149A_33D5:
	jmp	32FCh

l149A_33D8:
	cmp	byte ptr es:[bx+1h],2Fh
	jnz	33E2h

l149A_33DF:
	jmp	32FCh

l149A_33E2:
	mov	ax,[bp-10h]
	or	ax,[bp-12h]
	jz	33F8h

l149A_33EA:
	push	word ptr [bp-10h]
	push	word ptr [bp-12h]
	call	far 149Ah:22A8h
	add	sp,4h

l149A_33F8:
	mov	ax,[bp-6h]
	pop	si
	dec	bp
	dec	bp
	mov	sp,bp
	pop	ds
	pop	bp
	dec	bp
	retf

;; fn149A_3404: 149A:3404
;;   Called from:
;;     0800:152E (in main)
fn149A_3404 proc
	push	ds
	pop	ax
	nop
	inc	bp
	push	bp
	mov	bp,sp
	push	ds
	mov	ds,ax
	sub	sp,18h
	mov	ax,35E4h
	push	ds
	push	ax
	call	far 149Ah:26A0h
	add	sp,4h
	mov	[bp-12h],ax
	mov	[bp-10h],dx
	mov	ax,[bp+8h]
	or	ax,[bp+6h]
	jnz	344Ch

l149A_342C:
	sub	ax,ax
	push	ax
	push	dx
	push	word ptr [bp-12h]
	call	far 149Ah:34E6h
	add	sp,6h
	or	ax,ax
	jnz	3446h

l149A_343F:
	mov	ax,1h
	jmp	34C8h
149A:3445                90                                    .          

l149A_3446:
	sub	ax,ax
	jmp	34C8h
149A:344A                               90 90                       ..    

l149A_344C:
	mov	word ptr [bp-0Eh],35ECh
	mov	[bp-0Ch],ds
	mov	ax,[bp+6h]
	mov	dx,[bp+8h]
	mov	[bp-0Ah],ax
	mov	[bp-8h],dx
	sub	ax,ax
	mov	[bp-4h],ax
	mov	[bp-6h],ax
	mov	ax,[bp-10h]
	or	ax,[bp-12h]
	jz	34A8h

l149A_3470:
	push	word ptr [31C7h]
	push	word ptr [31C5h]
	lea	ax,[bp-12h]
	push	ss
	push	ax
	push	word ptr [bp-10h]
	push	word ptr [bp-12h]
	sub	cx,cx
	push	cx
	call	far 149Ah:3068h
	add	sp,0Eh
	mov	[bp-14h],ax
	inc	ax
	jnz	34A2h

l149A_3494:
	cmp	word ptr [319Ch],2h
	jz	34A8h

l149A_349B:
	cmp	word ptr [319Ch],0Dh
	jz	34A8h

l149A_34A2:
	mov	ax,[bp-14h]
	jmp	34C8h
149A:34A7                      90                                .        

l149A_34A8:
	push	word ptr [31C7h]
	push	word ptr [31C5h]
	lea	ax,[bp-12h]
	push	ss
	push	ax
	mov	cx,35EFh
	mov	[bp-12h],cx
	mov	[bp-10h],ds
	push	ds
	push	cx
	sub	ax,ax
	push	ax
	call	far 149Ah:3236h

l149A_34C8:
	dec	bp
	dec	bp
	mov	sp,bp
	pop	ds
	pop	bp
	dec	bp
	retf

;; fn149A_34D0: 149A:34D0
;;   Called from:
;;     149A:3092 (in fn149A_3068)
fn149A_34D0 proc
	mov	cx,[3620h]
	jcxz	34DAh

l149A_34D6:
	jmp	dword ptr [361Eh]

l149A_34DA:
	mov	ax,0FFFFh
	mov	word ptr [319Ch],16h
	jmp	05FBh

;; fn149A_34E6: 149A:34E6
;;   Called from:
;;     0800:06EE (in fn0800_06D9)
;;     0800:0750 (in fn0800_06D9)
;;     1054:3A2B (in fn1054_3A11)
;;     1054:3C6F (in fn1054_3C57)
;;     1054:3F85 (in fn1054_3F70)
;;     149A:31F2 (in fn149A_3068)
;;     149A:3433 (in fn149A_3404)
fn149A_34E6 proc
	push	bp
	mov	bp,sp
	push	ds
	lds	dx,[bp+6h]
	mov	ax,4300h
	int	21h
	pop	ds
	jc	3504h

l149A_34F5:
	test	byte ptr [bp+0Ah],2h
	jz	3504h

l149A_34FB:
	test	cl,1h
	jz	3504h

l149A_3500:
	mov	ax,0D00h
	stc

l149A_3504:
	jmp	05E6h
149A:3507                      00                                .        

;; fn149A_3508: 149A:3508
;;   Called from:
;;     149A:355F (in fn149A_3544)
fn149A_3508 proc
	mov	ah,19h
	int	21h
	mov	ah,0h
	inc	ax
	retf
149A:3510 55 8B EC 8A 56 06 4A B4 0E CD 21 B4 19 CD 21 40 U...V.J...!...!@
149A:3520 3A 46 06 B8 FF FF 75 01 40 5D CB 00             :F....u.@]..    

;; fn149A_352C: 149A:352C
;;   Called from:
;;     0800:1133 (in main)
;;     0800:11AC (in main)
;;     0800:1225 (in main)
fn149A_352C proc
	push	bp
	mov	bp,sp
	push	word ptr [bp+0Ah]
	push	word ptr [bp+8h]
	push	word ptr [bp+6h]
	sub	ax,ax
	push	ax
	call	far 149Ah:3544h
	mov	sp,bp
	pop	bp
	retf

;; fn149A_3544: 149A:3544
;;   Called from:
;;     149A:353B (in fn149A_352C)
fn149A_3544 proc
	push	bp
	mov	bp,sp
	sub	sp,12Eh
	push	si
	mov	si,[bp+0Ch]
	lea	ax,[bp+0FED2h]
	mov	[bp-4h],ax
	mov	[bp-2h],ss
	cmp	word ptr [bp+6h],0h
	jnz	3567h

l149A_355F:
	call	far 149Ah:3508h
	mov	[bp+6h],ax

l149A_3567:
	mov	al,[bp+6h]
	add	al,40h
	les	bx,[bp-4h]
	mov	es:[bx],al
	inc	word ptr [bp-4h]
	les	bx,[bp-4h]
	mov	byte ptr es:[bx],3Ah
	inc	word ptr [bp-4h]
	les	bx,[bp-4h]
	mov	byte ptr es:[bx],5Ch
	inc	word ptr [bp-4h]
	mov	byte ptr [bp-19h],47h
	mov	al,[bp+6h]
	mov	[bp-14h],al
	mov	ax,[bp-2h]
	mov	[bp-0Ch],ax
	mov	[bp-6h],ax
	mov	ax,[bp-4h]
	mov	[bp-12h],ax
	lea	ax,[bp-0Ch]
	push	ss
	push	ax
	lea	ax,[bp-28h]
	push	ss
	push	ax
	lea	cx,[bp-1Ah]
	push	ss
	push	cx
	call	far 149Ah:28DAh
	add	sp,0Ch
	cmp	word ptr [bp-1Ch],0h
	jz	35D2h

l149A_35BF:
	mov	word ptr [319Ch],0Dh
	mov	ax,[bp-28h]
	mov	[31A7h],ax

l149A_35CB:
	sub	ax,ax
	cwd
	jmp	3644h
149A:35D0 90 90                                           ..              

l149A_35D2:
	lea	ax,[bp+0FED2h]
	push	ss
	push	ax
	call	far 149Ah:260Eh
	add	sp,4h
	inc	ax
	mov	[bp-2Ah],ax
	mov	ax,[bp+8h]
	mov	dx,[bp+0Ah]
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	or	dx,ax
	jnz	3623h

l149A_35F4:
	cmp	[bp-2Ah],si
	jle	35FCh

l149A_35F9:
	mov	si,[bp-2Ah]

l149A_35FC:
	push	si
	call	far 149Ah:22A2h
	add	sp,2h
	mov	[bp-4h],ax
	mov	[bp-2h],dx
	or	dx,ax
	jnz	361Ah

l149A_360F:
	mov	word ptr [319Ch],0Ch
	mov	dx,[bp-2h]
	jmp	3644h

l149A_361A:
	mov	dx,[bp-2h]
	mov	[bp+8h],ax
	mov	[bp+0Ah],dx

l149A_3623:
	cmp	[bp-2Ah],si
	jle	3630h

l149A_3628:
	mov	word ptr [319Ch],22h
	jmp	35CBh

l149A_3630:
	lea	ax,[bp+0FED2h]
	push	ss
	push	ax
	push	word ptr [bp-2h]
	push	word ptr [bp-4h]
	call	far 149Ah:25AEh
	add	sp,8h

l149A_3644:
	pop	si
	mov	sp,bp
	pop	bp
	retf
149A:3649                            90                            .      

;; fn149A_364A: 149A:364A
;;   Called from:
;;     0800:0778 (in fn0800_06D9)
fn149A_364A proc
	push	bp
	mov	bp,sp
	push	di
	push	ds
	lds	dx,[bp+6h]
	les	di,[bp+0Ah]
	mov	ah,56h
	int	21h
	pop	ds
	pop	di
	jmp	05E6h

;; fn149A_365E: 149A:365E
;;   Called from:
;;     0800:0765 (in fn0800_06D9)
;;     0800:1821 (in main)
;;     149A:06E7 (in fn149A_063C)
fn149A_365E proc
	push	bp
	mov	bp,sp
	push	ds
	lds	dx,[bp+6h]
	mov	ah,41h
	int	21h
	pop	ds
	jmp	05E6h
149A:366D                                        00                    .  

;; fn149A_366E: 149A:366E
;;   Called from:
;;     149A:146F (in fn149A_0FA2)
fn149A_366E proc
	push	bp
	mov	bp,sp
	push	ds
	push	bx
	lds	bx,[bp+6h]
	push	word ptr [bp+0Ch]
	push	word ptr [bp+0Ah]
	push	word ptr [bx+2h]
	push	word ptr [bx]
	push	cs
	call	36B0h
	mov	[bx],ax
	mov	[bx+2h],dx
	pop	bx
	pop	ds
	pop	bp
	retf	8h

;; fn149A_3690: 149A:3690
;;   Called from:
;;     149A:13CF (in fn149A_0FA2)
;;     149A:145D (in fn149A_0FA2)
fn149A_3690 proc
	push	bp
	mov	bp,sp
	push	ds
	push	bx
	lds	bx,[bp+6h]
	mov	ax,[bx]
	mov	dx,[bx+2h]
	mov	cx,[bp+0Ah]
	push	cs
	call	36E2h
	mov	[bx],ax
	mov	[bx+2h],dx
	pop	bx
	pop	ds
	pop	bp
	retf	6h
149A:36AF                                              00                .

;; fn149A_36B0: 149A:36B0
;;   Called from:
;;     0800:5DDA (in fn0800_550A)
;;     1054:1F93 (in fn1054_1A49)
;;     149A:3681 (in fn149A_366E)
fn149A_36B0 proc
	push	bp
	mov	bp,sp
	mov	ax,[bp+8h]
	mov	cx,[bp+0Ch]
	or	cx,ax
	mov	cx,[bp+0Ah]
	jnz	36C9h

l149A_36C0:
	mov	ax,[bp+6h]
	mul	cx
	pop	bp
	retf	8h

l149A_36C9:
	push	bx
	mul	cx
	mov	bx,ax
	mov	ax,[bp+6h]
	mul	word ptr [bp+0Ch]
	add	bx,ax
	mov	ax,[bp+6h]
	mul	cx
	add	dx,bx
	pop	bx
	pop	bp
	retf	8h

;; fn149A_36E2: 149A:36E2
;;   Called from:
;;     149A:36A0 (in fn149A_3690)
fn149A_36E2 proc
	xor	ch,ch
	jcxz	36ECh

l149A_36E6:
	shl	ax,1h
	rcl	dx,1h
	loop	36E6h

l149A_36EC:
	retf
149A:36ED                                        00 00 00              ...
