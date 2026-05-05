	.OPTION	B,D,L,T
	.include	"BGNDTBL.GLO"
	.DATA

OLHDRS:
	.word	92,56	;x size, y size
	.long	03000000H	;address
	.word	05a80H	;dma ctrl
	.word	28,186
	.long	030023f8H
	.word	06080H
	.word	28,169
	.long	030096c4H
	.word	06080H
	.word	36,32
	.long	0300f6f6H
	.word	06580H
	.word	120,81
	.long	030102d6H
	.word	06180H
	.word	40,209
	.long	0301dda6H
	.word	05480H
	.word	80,58
	.long	03027330H
	.word	06d80H
	.word	52,78
	.long	0302c6e4H
	.word	05580H
	.word	56,13
	.long	0302e560H
	.word	06000H
	.word	80,173
	.long	0302f670H
	.word	06480H
	.word	96,43
	.long	03043ab0H
	.word	06080H
	.word	96,13
	.long	03049ac4H
	.word	06080H
	.word	32,50
	.long	0304b7d0H
	.word	05580H
	.word	244,33
	.long	0304c324H
	.word	06080H
	.word	52,232
	.long	03057f58H
	.word	06200H
	.word	24,57
	.long	03069a18H
	.word	05180H
	.word	140,47
	.long	0306a95fH
	.word	06080H
	.word	140,44
	.long	030742dbH
	.word	06480H
	.word	12,81
	.long	0307d0e7H
	.word	05080H
	.word	36,30
	.long	0307e341H
	.word	06580H
	.word	4,13
	.long	0307eb39H
	.word	06000H
	.word	48,100
	.long	0307ec71H
	.word	06a80H
	.word	48,104
	.long	03084229H
	.word	06880H
	.word	48,103
	.long	03089c81H
	.word	06180H
	.word	48,103
	.long	0308fb0fH
	.word	06280H
	.word	48,100
	.long	03095517H
	.word	06280H
	.word	16,36
	.long	0309a87dH
	.word	05080H
	.word	8,78
	.long	0309b0b9H
	.word	05000H
	.word	56,223
	.long	0309bce9H
	.word	06080H
	.word	16,30
	.long	030ade1dH
	.word	06080H
	.word	8,21
	.long	030ae615H
	.word	05000H
	.word	4,70
	.long	030ae95dH
	.word	05000H
	.word	56,232
	.long	030aeed5H
	.word	06a80H
	.word	144,47
	.long	030c1d7dH
	.word	06000H
	.word	144,46
	.long	030cbc1dH
	.word	06280H
	.word	8,30
	.long	030d5531H
	.word	06000H
	.word	100,34
	.long	030d5ad1H
	.word	06180H
	.word	68,168
	.long	030da7c5H
	.word	06000H
	.word	68,65
	.long	030eb385H
	.word	06080H
	.word	56,30
	.long	030f1a0dH
	.word	05680H
	.word	96,33
	.long	030f2683H
	.word	06000H
	.word	36,43
	.long	030f70c3H
	.word	05580H
	.word	24,92
	.long	030f7c11H
	.word	05080H
DPUL6BLKS:
	.word	04045H	;flags
	.word	1,127	;x,y
	.word	010H	;pal5,pal4,hdr13-0
	.word	04047H,1,83,011H
	.word	04045H,192,136,021H
	.word	04047H,192,90,022H
	.word	04067H,192,48,022H
	.word	04047H,192,2,022H
	.word	04045H,477,136,010H
	.word	04047H,477,92,011H
	.word	04067H,477,52,011H
	.word	04047H,477,8,011H
	.word	04045H,659,127,021H
	.word	04047H,659,81,022H
	.word	0FFFFH	;End Marker
DPUL1BLKS:
	.word	04741H	;flags
	.word	1,80	;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04741H,75,2,07H
	.word	04741H,1064,94,02aH
	.word	04741H,1064,2,02aH
	.word	04741H,1065,186,02aH
	.word	04741H,1066,370,02aH
	.word	04741H,1066,278,02aH
	.word	04741H,1406,2,02aH
	.word	04741H,1407,94,02aH
	.word	04741H,1408,186,02aH
	.word	04741H,1409,278,02aH
	.word	04741H,1410,370,02aH
	.word	04751H,2239,2,07H
	.word	04751H,2273,80,00H
	.word	0FFFFH	;End Marker
DPUL2BLKS:
	.word	04541H	;flags
	.word	2,83	;x,y
	.word	0fH	;pal5,pal4,hdr13-0
	.word	04541H,13,2,012H
	.word	04541H,124,199,012H
	.word	04541H,124,119,012H
	.word	04541H,124,39,012H
	.word	04541H,125,279,012H
	.word	04541H,126,359,012H
	.word	04651H,229,40,027H
	.word	04641H,285,40,027H
	.word	04651H,357,39,029H
	.word	04651H,380,82,027H
	.word	04551H,434,120,0fH
	.word	04541H,435,39,012H
	.word	04641H,436,82,027H
	.word	04641H,478,40,029H
	.word	04541H,548,359,012H
	.word	04541H,548,279,012H
	.word	04541H,548,199,012H
	.word	04541H,548,119,012H
	.word	04541H,548,39,012H
	.word	04651H,594,40,027H
	.word	04641H,650,40,027H
	.word	04551H,737,120,0fH
	.word	04541H,739,39,012H
	.word	04741H,849,582,02aH
	.word	04741H,849,490,02aH
	.word	04741H,850,674,02aH
	.word	04741H,851,858,02aH
	.word	04741H,851,766,02aH
	.word	04541H,857,39,012H
	.word	04541H,858,119,012H
	.word	04541H,859,199,012H
	.word	04541H,860,279,012H
	.word	04541H,861,359,012H
	.word	04541H,1000,120,0fH
	.word	04541H,1011,39,012H
	.word	04651H,1073,40,029H
	.word	04651H,1095,83,027H
	.word	04641H,1151,83,027H
	.word	04741H,1191,490,02aH
	.word	04741H,1192,582,02aH
	.word	04741H,1193,674,02aH
	.word	04641H,1193,40,029H
	.word	04741H,1194,766,02aH
	.word	04741H,1195,858,02aH
	.word	04541H,1314,94,0fH
	.word	04541H,1325,13,012H
	.word	04651H,1375,40,027H
	.word	04641H,1431,40,027H
	.word	04551H,1562,83,0fH
	.word	04541H,1563,2,012H
	.word	04541H,1724,39,012H
	.word	04541H,1725,119,012H
	.word	04541H,1726,199,012H
	.word	04541H,1727,279,012H
	.word	04541H,1728,359,012H
	.word	0FFFFH	;End Marker
DPUL3BLKS:
	.word	04441H	;flags
	.word	2,106	;x,y
	.word	01aH	;pal5,pal4,hdr13-0
	.word	04441H,8,28,01bH
	.word	04541H,33,437,012H
	.word	04541H,33,357,012H
	.word	04541H,33,277,012H
	.word	04541H,34,517,012H
	.word	04541H,35,597,012H
	.word	04451H,103,88,01aH
	.word	04441H,106,10,01bH
	.word	04651H,138,278,027H
	.word	04641H,194,278,027H
	.word	04651H,266,277,029H
	.word	04441H,273,184,01aH
	.word	04441H,280,106,01bH
	.word	04441H,280,28,01bH
	.word	04651H,289,320,027H
	.word	04551H,343,358,0fH
	.word	04541H,344,277,012H
	.word	04641H,345,320,027H
	.word	04641H,387,278,029H
	.word	04441H,392,81,01aH
	.word	04441H,399,3,01bH
	.word	04541H,457,597,012H
	.word	04541H,457,517,012H
	.word	04541H,457,437,012H
	.word	04541H,457,357,012H
	.word	04541H,457,277,012H
	.word	04651H,503,278,027H
	.word	04441H,537,106,01aH
	.word	04441H,543,28,01bH
	.word	04641H,559,278,027H
	.word	04551H,646,358,0fH
	.word	04541H,648,277,012H
	.word	04441H,752,82,01aH
	.word	04741H,758,820,02aH
	.word	04741H,758,728,02aH
	.word	04741H,759,912,02aH
	.word	04441H,759,4,01bH
	.word	04741H,760,1096,02aH
	.word	04741H,760,1004,02aH
	.word	04541H,766,277,012H
	.word	04541H,767,357,012H
	.word	04541H,768,437,012H
	.word	04541H,769,517,012H
	.word	04541H,770,597,012H
	.word	04451H,865,100,01aH
	.word	04441H,868,22,01bH
	.word	04541H,909,358,0fH
	.word	04541H,920,277,012H
	.word	04651H,982,278,029H
	.word	04651H,1004,321,027H
	.word	04441H,1014,106,01aH
	.word	04441H,1021,28,01bH
	.word	04641H,1060,321,027H
	.word	04741H,1100,728,02aH
	.word	04741H,1101,820,02aH
	.word	04741H,1102,912,02aH
	.word	04641H,1102,278,029H
	.word	04741H,1103,1004,02aH
	.word	04741H,1104,1096,02aH
	.word	04441H,1179,96,01aH
	.word	04441H,1186,18,01bH
	.word	04541H,1223,332,0fH
	.word	04541H,1234,251,012H
	.word	0FFFFH	;End Marker
DPUL4BLKS:
	.word	04341H	;flags
	.word	2,156	;x,y
	.word	01eH	;pal5,pal4,hdr13-0
	.word	04341H,6,86,01fH
	.word	04341H,6,16,01fH
	.word	04451H,43,326,01aH
	.word	04441H,46,248,01bH
	.word	04651H,78,516,027H
	.word	04641H,134,516,027H
	.word	04341H,189,86,01eH
	.word	04341H,193,16,01fH
	.word	04651H,206,515,029H
	.word	04441H,213,422,01aH
	.word	04441H,220,344,01bH
	.word	04441H,220,266,01bH
	.word	04651H,229,558,027H
	.word	04551H,283,596,0fH
	.word	04541H,284,515,012H
	.word	04641H,285,558,027H
	.word	04341H,304,74,01eH
	.word	04341H,308,4,01fH
	.word	04641H,327,516,029H
	.word	04441H,332,319,01aH
	.word	04441H,339,241,01bH
	.word	04541H,397,835,012H
	.word	04541H,397,755,012H
	.word	04541H,397,675,012H
	.word	04541H,397,595,012H
	.word	04541H,397,515,012H
	.word	04651H,443,516,027H
	.word	04341H,449,156,01eH
	.word	04341H,453,86,01fH
	.word	04341H,453,16,01fH
	.word	04441H,477,344,01aH
	.word	04441H,483,266,01bH
	.word	04641H,499,516,027H
	.word	04551H,586,596,0fH
	.word	04541H,588,515,012H
	.word	04441H,692,320,01aH
	.word	04341H,698,86,01eH
	.word	04441H,699,242,01bH
	.word	04341H,702,16,01fH
	.word	04541H,706,515,012H
	.word	04541H,707,595,012H
	.word	04541H,708,675,012H
	.word	04541H,709,755,012H
	.word	04541H,710,835,012H
	.word	04451H,805,338,01aH
	.word	04441H,808,260,01bH
	.word	04541H,849,596,0fH
	.word	04341H,851,156,01eH
	.word	04341H,855,86,01fH
	.word	04341H,855,16,01fH
	.word	04541H,860,515,012H
	.word	04651H,922,516,029H
	.word	04651H,944,559,027H
	.word	04441H,954,344,01aH
	.word	04441H,961,266,01bH
	.word	04641H,1000,559,027H
	.word	04341H,1005,73,01eH
	.word	04341H,1009,3,01fH
	.word	04641H,1042,516,029H
	.word	04341H,1110,162,01eH
	.word	04341H,1114,92,01fH
	.word	04341H,1114,22,01fH
	.word	04441H,1119,334,01aH
	.word	04441H,1126,256,01bH
	.word	0FFFFH	;End Marker
DPUL5BLKS:
	.word	04043H	;flags
	.word	2,224	;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04043H,2,38,01H
	.word	04043H,14,338,03H
	.word	04043H,27,292,06H
	.word	04041H,27,101,05H
	.word	04043H,27,38,04H
	.word	04043H,48,337,08H
	.word	04042H,65,119,09H
	.word	04043H,104,337,0bH
	.word	04042H,104,294,0aH
	.word	04241H,124,113,0cH
	.word	04241H,133,155,0cH
	.word	03f42H,143,261,0dH
	.word	04052H,145,38,0eH
	.word	04241H,154,63,0cH
	.word	04241H,162,106,0cH
	.word	04241H,184,13,0cH
	.word	04173H,192,294,013H
	.word	04241H,192,56,0cH
	.word	04143H,196,324,014H
	.word	04042H,197,161,015H
	.word	04041H,197,100,017H
	.word	04042H,197,38,016H
	.word	04043H,198,337,0bH
	.word	04042H,198,294,0aH
	.word	04241H,222,6,0cH
	.word	04051H,242,100,017H
	.word	04042H,242,38,018H
	.word	04042H,243,161,019H
	.word	04052H,288,38,01cH
	.word	04143H,290,294,01dH
	.word	04143H,291,324,014H
	.word	04043H,292,337,0bH
	.word	04042H,292,294,0aH
	.word	04341H,326,578,01eH
	.word	04341H,330,508,01fH
	.word	04341H,330,438,01fH
	.word	04052H,344,38,020H
	.word	04143H,384,324,014H
	.word	04243H,384,294,023H
	.word	03f42H,384,260,024H
	.word	04043H,386,337,0bH
	.word	04042H,386,294,0aH
	.word	04341H,398,37,025H
	.word	04043H,400,205,026H
	.word	04042H,466,38,020H
	.word	04043H,480,337,0bH
	.word	04042H,480,294,0aH
	.word	04043H,482,261,028H
	.word	04341H,513,508,01eH
	.word	04341H,517,438,01fH
	.word	04042H,522,38,01cH
	.word	04043H,574,337,0bH
	.word	04042H,574,294,0aH
	.word	04042H,576,38,01cH
	.word	04043H,577,261,028H
	.word	04341H,628,496,01eH
	.word	04052H,630,38,020H
	.word	04341H,632,426,01fH
	.word	04441H,663,663,01bH
	.word	04043H,668,337,0bH
	.word	04042H,668,294,0aH
	.word	03f42H,668,260,024H
	.word	04341H,685,37,025H
	.word	04043H,686,205,026H
	.word	04042H,752,38,020H
	.word	04153H,756,294,023H
	.word	04153H,760,324,014H
	.word	03f52H,761,261,0dH
	.word	04043H,762,337,0bH
	.word	04042H,762,294,0aH
	.word	04341H,773,578,01eH
	.word	04341H,777,508,01fH
	.word	04341H,777,438,01fH
	.word	04042H,808,38,01cH
	.word	04153H,842,294,01dH
	.word	04153H,853,324,014H
	.word	04043H,856,337,0bH
	.word	04042H,856,294,0aH
	.word	04042H,856,161,015H
	.word	04042H,856,38,016H
	.word	04141H,857,100,017H
	.word	04251H,893,7,0cH
	.word	04151H,903,100,017H
	.word	04042H,903,38,018H
	.word	04042H,904,161,019H
	.word	04153H,917,294,013H
	.word	04251H,923,57,0cH
	.word	04251H,933,13,0cH
	.word	04153H,948,324,014H
	.word	04043H,950,337,0bH
	.word	04042H,950,294,0aH
	.word	04042H,951,38,0eH
	.word	04251H,953,107,0cH
	.word	04251H,962,62,0cH
	.word	04251H,983,157,0cH
	.word	04251H,992,112,0cH
	.word	04053H,1001,38,04H
	.word	04052H,1003,119,09H
	.word	04341H,1022,508,01eH
	.word	04441H,1023,664,01bH
	.word	04341H,1026,438,01fH
	.word	04053H,1041,292,06H
	.word	04053H,1044,337,08H
	.word	04051H,1081,101,05H
	.word	04053H,1098,338,03H
	.word	04053H,1118,224,02H
	.word	04053H,1118,38,01H
	.word	0FFFFH	;End Marker
DPUL6BMOD:
	.word	802,181,12	;x size, y size, #blocks
	.long	DPUL6BLKS, OLHDRS, OLPALS
DPUL1BMOD:
	.word	2364,460,14	;x size, y size, #blocks
	.long	DPUL1BLKS, OLHDRS, OLPALS
DPUL2BMOD:
	.word	1738,948,46	;x size, y size, #blocks
	.long	DPUL2BLKS, OLHDRS, OLPALS
DPUL3BMOD:
	.word	1245,1185,19	;x size, y size, #blocks
	.long	DPUL3BLKS, OLHDRS, OLPALS
DPUL4BMOD:
	.word	1133,913,20	;x size, y size, #blocks
	.long	DPUL4BLKS, OLHDRS, OLPALS
DPUL5BMOD:
	.word	1144,736,94	;x size, y size, #blocks
	.long	DPUL5BLKS, OLHDRS, OLPALS
