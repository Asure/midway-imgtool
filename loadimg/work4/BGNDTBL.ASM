	.OPTION	B,D,L,T
	.include	"BGNDTBL.GLO"
	.DATA

TYHDRS:
	.word	160,86	;x size, y size
	.long	07000000H	;address
	.word	06A80H	;dma ctrl
	.word	48,122
	.long	07010948H
	.word	06580H
	.word	60,31
	.long	07016298H
	.word	06080H
	.word	116,39
	.long	07018DB4H
	.word	06180H
	.word	76,130
	.long	0701EB68H
	.word	06580H
	.word	60,31
	.long	07028890H
	.word	06000H
	.word	36,66
	.long	0702B428H
	.word	06480H
	.word	56,31
	.long	0702D384H
	.word	06000H
	.word	80,31
	.long	0702FC34H
	.word	06080H
	.word	56,61
	.long	070335D8H
	.word	06580H
	.word	64,31
	.long	0703616CH
	.word	06080H
	.word	76,97
	.long	07038EB6H
	.word	06980H
	.word	56,31
	.long	0704137EH
	.word	06000H
	.word	188,65
	.long	07043C2EH
	.word	06000H
	.word	188,63
	.long	07055A96H
	.word	06C80H
	.word	80,69
	.long	07064E50H
	.word	06880H
	.word	56,31
	.long	0706C87EH
	.word	06080H
	.word	56,57
	.long	0706F0B2H
	.word	06580H
	.word	60,31
	.long	07071C0EH
	.word	06000H
	.word	76,82
	.long	070747A6H
	.word	06580H
	.word	160,60
	.long	0707B80AH
	.word	06080H
	.word	52,31
	.long	070885A2H
	.word	06000H
	.word	124,108
	.long	0708AB6AH
	.word	06A80H
	.word	212,49
	.long	0709779AH
	.word	06000H
	.word	212,56
	.long	070A6B12H
	.word	06000H
	.word	108,55
	.long	070B8152H
	.word	06880H
	.word	60,169
	.long	070BFAA4H
	.word	06580H
mkcity1BLKS:
	.word	04042H	;flags
	.word	0,170 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04042H,2,9,01H
	.word	04042H,14,131,03H
	.word	04042H,48,1,04H
	.word	04042H,105,40,06H
	.word	04052H,963,169,00H
	.word	04052H,982,39,06H
	.word	04052H,993,130,03H
	.word	04052H,999,0,04H
	.word	04052H,1073,8,01H
	.word	0FFFFH	;End Marker
mkcity2BLKS:
	.word	04043H	;flags
	.word	0,43 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04043H,58,43,05H
	.word	04043H,117,43,07H
	.word	04043H,173,43,08H
	.word	04140H,194,0,09H
	.word	04043H,251,43,0AH
	.word	04043H,312,43,0CH
	.word	04043H,368,43,010H
	.word	04141H,400,2,011H
	.word	04043H,422,43,012H
	.word	04043H,481,43,015H
	.word	04053H,533,43,015H
	.word	04053H,584,43,012H
	.word	04151H,610,2,011H
	.word	04053H,642,43,010H
	.word	04053H,698,43,0CH
	.word	04053H,751,43,0AH
	.word	04053H,813,43,08H
	.word	04150H,818,1,09H
	.word	04053H,893,43,07H
	.word	04053H,948,43,05H
	.word	04053H,1006,43,02H
	.word	0FFFFH	;End Marker
mkcity3BLKS:
	.word	04044H	;flags
	.word	0,0 ;x,y
	.word	013H	;pal5,pal4,hdr13-0
	.word	04047H,123,26,019H
	.word	0FFFFH	;End Marker
mkcity4BLKS:
	.word	0414CH	;flags
	.word	0,72 ;x,y
	.word	0BH	;pal5,pal4,hdr13-0
	.word	0404CH,62,100,0FH
	.word	04046H,177,109,014H
	.word	04045H,194,1,016H
	.word	04048H,419,0,01AH
	.word	0FFFFH	;End Marker
mkcity5BLKS:
	.word	0404BH	;flags
	.word	0,63 ;x,y
	.word	0DH	;pal5,pal4,hdr13-0
	.word	0404AH,0,0,0EH
	.word	0404BH,187,79,017H
	.word	04049H,187,23,018H
	.word	0FFFFH	;End Marker
mkcity1BMOD:
	.word	1123,256,10	;x size, y size, #blocks
	.long	mkcity1BLKS, TYHDRS, TYPALS
mkcity2BMOD:
	.word	1066,74,22	;x size, y size, #blocks
	.long	mkcity2BLKS, TYHDRS, TYPALS
mkcity3BMOD:
	.word	231,82,2	;x size, y size, #blocks
	.long	mkcity3BLKS, TYHDRS, TYPALS
mkcity4BMOD:
	.word	479,169,5	;x size, y size, #blocks
	.long	mkcity4BLKS, TYHDRS, TYPALS
mkcity5BMOD:
	.word	399,128,4	;x size, y size, #blocks
	.long	mkcity5BLKS, TYHDRS, TYPALS

BRAWHDRS:
	.word	76,6	;x size, y size
	.long	070C95C8H	;address
	.word	04880H	;dma ctrl
	.word	120,24
	.long	070C9BB8H
	.word	04080H
	.word	116,13
	.long	070CC858H
	.word	06080H
	.word	112,34
	.long	070CEB2EH
	.word	06000H
	.word	112,12
	.long	070D446EH
	.word	06000H
	.word	140,92
	.long	070D63EEH
	.word	06080H
	.word	108,35
	.long	070E8E36H
	.word	06080H
	.word	28,111
	.long	070EE642H
	.word	06000H
	.word	108,24
	.long	070F2F1AH
	.word	04080H
	.word	112,13
	.long	070F573AH
	.word	06080H
	.word	116,35
	.long	070F78D8H
	.word	06000H
	.word	112,34
	.long	070FD800H
	.word	06080H
	.word	112,12
	.long	071030B8H
	.word	06080H
	.word	8,107
	.long	07105008H
	.word	06000H
	.word	140,92
	.long	07106418H
	.word	06080H
	.word	16,28
	.long	07118E60H
	.word	06080H
	.word	140,92
	.long	071198C4H
	.word	06080H
	.word	28,111
	.long	0712C30CH
	.word	06000H
	.word	140,92
	.long	07130BE4H
	.word	06080H
	.word	140,92
	.long	0714362CH
	.word	06080H
	.word	112,24
	.long	07156074H
	.word	04000H
	.word	8,106
	.long	07158A74H
	.word	06000H
SUBWAY2BLKS:
	.word	0405AH	;flags
	.word	0,0 ;x,y
	.word	05H	;pal5,pal4,hdr13-0
	.word	0405AH,136,0,0EH
	.word	0405AH,272,0,010H
	.word	04041H,412,0,012H
	.word	0404AH,548,0,013H
	.word	0405AH,681,0,0EH
	.word	0FFFFH	;End Marker
SUBWAY1BLKS:
	.word	04045H	;flags
	.word	0,185 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	03F43H,6,172,02H
	.word	04044H,8,35,03H
	.word	04049H,8,69,04H
	.word	0404BH,13,0,06H
	.word	04142H,106,74,07H
	.word	04045H,117,185,08H
	.word	03F43H,119,172,09H
	.word	0404BH,119,0,0AH
	.word	04044H,120,35,0BH
	.word	04049H,120,69,0CH
	.word	04047H,134,74,0DH
	.word	04046H,152,151,0FH
	.word	04048H,192,80,00H
	.word	04045H,222,185,01H
	.word	03F43H,228,172,02H
	.word	04044H,230,35,03H
	.word	04049H,230,69,04H
	.word	0404BH,235,0,06H
	.word	04040H,329,74,011H
	.word	04045H,339,185,08H
	.word	0404BH,341,0,0AH
	.word	04044H,342,35,0BH
	.word	04045H,444,185,01H
	.word	04044H,452,35,03H
	.word	0404BH,457,0,06H
	.word	04042H,550,74,07H
	.word	04045H,561,185,08H
	.word	03F43H,563,172,09H
	.word	0404BH,563,0,0AH
	.word	04044H,564,35,0BH
	.word	04049H,564,69,0CH
	.word	04047H,578,74,0DH
	.word	04046H,591,152,0FH
	.word	04048H,636,80,00H
	.word	04045H,666,185,01H
	.word	03F43H,672,172,02H
	.word	04044H,674,35,03H
	.word	04049H,674,69,04H
	.word	0404BH,679,0,06H
	.word	04040H,773,74,011H
	.word	04045H,783,185,014H
	.word	0404BH,785,0,0AH
	.word	04044H,786,35,0BH
	.word	04054H,894,35,0BH
	.word	04055H,895,185,014H
	.word	0404BH,901,0,06H
	.word	04052H,991,74,07H
	.word	04055H,1004,185,01H
	.word	03F53H,1004,172,02H
	.word	0405BH,1005,0,06H
	.word	04054H,1006,35,03H
	.word	04059H,1006,69,04H
	.word	04046H,1032,153,0FH
	.word	04058H,1078,80,00H
	.word	0405BH,1113,0,0AH
	.word	04054H,1116,35,0BH
	.word	04059H,1116,69,0CH
	.word	03F53H,1117,172,09H
	.word	04055H,1121,185,08H
	.word	04057H,1205,74,015H
	.word	04050H,1213,74,011H
	.word	04055H,1226,185,01H
	.word	0405BH,1227,0,06H
	.word	04054H,1228,35,03H
	.word	0405BH,1335,0,0AH
	.word	04054H,1338,35,0BH
	.word	04055H,1343,185,08H
	.word	04052H,1435,74,07H
	.word	03F53H,1447,172,02H
	.word	04055H,1448,185,01H
	.word	0405BH,1449,0,06H
	.word	04054H,1449,35,03H
	.word	04059H,1450,69,04H
	.word	04046H,1474,151,0FH
	.word	04058H,1521,80,00H
	.word	0405BH,1557,0,0AH
	.word	04054H,1558,35,0BH
	.word	04059H,1559,69,0CH
	.word	03F53H,1560,172,09H
	.word	04055H,1565,185,08H
	.word	04057H,1649,75,015H
	.word	04050H,1657,74,011H
	.word	04055H,1670,185,01H
	.word	04054H,1670,35,03H
	.word	0405BH,1671,0,06H
	.word	03F53H,1671,172,02H
	.word	04049H,1671,69,0CH
	.word	04058H,1744,80,00H
	.word	0FFFFH	;End Marker

;file MKSUBRAW blocks not in any module
;	.word	04048H	;flags
;	.word	196,711 ;x,y
;	.word	00H	;pal5,pal4,hdr13-0
;	.word	0FFFFH	;End Marker
SUBWAY2BMOD:
	.word	821,92,6	;x size, y size, #blocks
	.long	SUBWAY2BLKS, BRAWHDRS, BRAWPALS
SUBWAY1BMOD:
	.word	1820,209,89	;x size, y size, #blocks
	.long	SUBWAY1BLKS, BRAWHDRS, BRAWPALS

OULHDRS:
	.word	100,26	;x size, y size
	.long	07159E54H	;address
	.word	06380H	;dma ctrl
	.word	52,39
	.long	0715D3B0H
	.word	06280H
	.word	60,34
	.long	0715FFC6H
	.word	06280H
	.word	56,153
	.long	07162D9AH
	.word	06280H
	.word	140,13
	.long	07168CE0H
	.word	06C80H
	.word	56,152
	.long	0716AFB0H
	.word	06A80H
	.word	64,35
	.long	07170AF8H
	.word	06000H
	.word	32,53
	.long	07173F78H
	.word	06480H
	.word	56,39
	.long	071751D0H
	.word	06280H
	.word	44,147
	.long	0717806EH
	.word	06480H
	.word	168,56
	.long	0717DFA2H
	.word	06E80H
	.word	96,26
	.long	0718AA1AH
	.word	06080H
	.word	40,147
	.long	0718E20AH
	.word	06080H
	.word	64,35
	.long	07193E68H
	.word	06080H
	.word	40,55
	.long	07197160H
	.word	06280H
	.word	120,17
	.long	07198584H
	.word	06C80H
	.word	68,35
	.long	0719A76CH
	.word	06380H
	.word	128,55
	.long	0719DD58H
	.word	06B80H
	.word	64,54
	.long	071A5ED8H
	.word	06280H
	.word	60,112
	.long	071A7CD8H
	.word	06A80H
	.word	72,54
	.long	071AD548H
	.word	06880H
	.word	64,112
	.long	071AF6A8H
	.word	06680H
	.word	124,26
	.long	071B5578H
	.word	06D80H
	.word	124,55
	.long	071B8AE0H
	.word	06D80H
	.word	132,22
	.long	071C0D8CH
	.word	06A80H
	.word	80,27
	.long	071C389CH
	.word	06180H
	.word	68,34
	.long	071C67A6H
	.word	06C80H
	.word	104,55
	.long	071C9D96H
	.word	06C80H
	.word	88,38
	.long	071D0DFAH
	.word	06000H
	.word	88,26
	.long	071D5C5AH
	.word	06480H
	.word	80,17
	.long	071D8CD6H
	.word	06180H
	.word	36,100
	.long	071DA870H
	.word	06080H
	.word	16,30
	.long	071DDD40H
	.word	06080H
	.word	24,92
	.long	071DE5CEH
	.word	06080H
	.word	92,30
	.long	071E0C12H
	.word	06080H
	.word	72,42
	.long	071E4B96H
	.word	06C80H
	.word	104,53
	.long	071E76E6H
	.word	06D80H
	.word	76,24
	.long	071EDFF6H
	.word	06180H
	.word	76,18
	.long	071F08E2H
	.word	06280H
	.word	96,38
	.long	071F2418H
	.word	06080H
	.word	32,94
	.long	071F77B0H
	.word	06480H
	.word	44,102
	.long	071FA95CH
	.word	06080H
	.word	20,29
	.long	071FEA00H
	.word	06080H
	.word	100,18
	.long	071FF3D0H
	.word	06A80H
	.word	88,24
	.long	07200E10H
	.word	06380H
SOUL1BLKS:
	.word	04049H	;flags
	.word	0,0 ;x,y
	.word	0AH	;pal5,pal4,hdr13-0
	.word	04049H,165,1,011H
	.word	04049H,290,1,011H
	.word	04049H,415,1,017H
	.word	04049H,536,1,01BH
	.word	04049H,638,3,024H
	.word	04059H,736,1,017H
	.word	04059H,857,1,011H
	.word	04059H,982,2,011H
	.word	04059H,1108,1,0AH
	.word	0FFFFH	;End Marker
SOUL2BLKS:
	.word	04042H	;flags
	.word	0,99 ;x,y
	.word	04H	;pal5,pal4,hdr13-0
	.word	04052H,138,95,0FH
	.word	04052H,257,0,013H
	.word	04052H,314,0,015H
	.word	04042H,378,0,015H
	.word	04042H,439,0,013H
	.word	04042H,498,95,0FH
	.word	04052H,618,95,0FH
	.word	04052H,737,0,013H
	.word	04052H,794,0,015H
	.word	04042H,858,0,015H
	.word	04042H,919,0,013H
	.word	04042H,978,95,0FH
	.word	04052H,1096,99,04H
	.word	0FFFFH	;End Marker
SOUL3BLKS:
	.word	04045H	;flags
	.word	0,185 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04046H,17,3,02H
	.word	04046H,76,3,06H
	.word	04058H,82,38,07H
	.word	04058H,93,38,09H
	.word	04055H,95,185,0BH
	.word	04058H,135,38,0CH
	.word	04046H,140,3,0DH
	.word	04058H,158,38,0EH
	.word	04045H,190,185,00H
	.word	04046H,201,3,010H
	.word	04046H,267,3,06H
	.word	04058H,273,38,07H
	.word	04058H,284,38,09H
	.word	04055H,285,185,0BH
	.word	04058H,326,38,0CH
	.word	04046H,331,3,0DH
	.word	04058H,349,38,0EH
	.word	04045H,381,185,00H
	.word	04046H,391,3,010H
	.word	04056H,454,3,0DH
	.word	04058H,464,38,07H
	.word	04058H,475,38,09H
	.word	04055H,476,185,0BH
	.word	04058H,517,38,0CH
	.word	04056H,518,3,06H
	.word	04058H,540,38,0EH
	.word	04045H,572,184,019H
	.word	04046H,582,3,01AH
	.word	04046H,649,0,01CH
	.word	04045H,651,185,01DH
	.word	04046H,658,38,01EH
	.word	04044H,662,85,01FH
	.word	04046H,677,55,020H
	.word	04043H,688,99,021H
	.word	04041H,690,55,022H
	.word	04044H,696,85,023H
	.word	04045H,736,187,025H
	.word	04046H,737,38,026H
	.word	04046H,737,0,027H
	.word	04043H,754,97,028H
	.word	04045H,767,85,029H
	.word	04045H,779,56,02AH
	.word	04045H,812,187,02CH
	.word	04046H,830,3,02H
	.word	04056H,886,3,0DH
	.word	04048H,892,38,0EH
	.word	04045H,899,185,0BH
	.word	04048H,915,38,0CH
	.word	04056H,950,3,06H
	.word	04048H,953,38,09H
	.word	04048H,976,38,07H
	.word	04055H,990,185,00H
	.word	04046H,1014,3,010H
	.word	04056H,1077,3,0DH
	.word	04048H,1082,38,0EH
	.word	04045H,1089,185,0BH
	.word	04048H,1105,38,0CH
	.word	04056H,1141,3,06H
	.word	04048H,1143,38,09H
	.word	04048H,1166,38,07H
	.word	04055H,1180,185,00H
	.word	04046H,1205,3,010H
	.word	04056H,1268,3,0DH
	.word	04048H,1272,38,0EH
	.word	04045H,1280,185,0BH
	.word	04048H,1295,38,0CH
	.word	04056H,1332,3,06H
	.word	04048H,1333,38,09H
	.word	04048H,1356,38,07H
	.word	04055H,1371,185,00H
	.word	0FFFFH	;End Marker
SOUL4BLKS:
	.word	04040H	;flags
	.word	0,0 ;x,y
	.word	012H	;pal5,pal4,hdr13-0
	.word	04040H,62,0,014H
	.word	04040H,131,28,016H
	.word	04040H,254,32,018H
	.word	04040H,385,0,012H
	.word	04040H,447,0,014H
	.word	04040H,516,36,02BH
	.word	0FFFFH	;End Marker
SOUL5BLKS:
	.word	04047H	;flags
	.word	0,114 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	04047H,12,0,03H
	.word	04047H,65,1,05H
	.word	04047H,80,114,08H
	.word	04047H,133,114,01H
	.word	04047H,145,0,03H
	.word	04047H,198,1,05H
	.word	04047H,213,114,08H
	.word	04047H,266,114,01H
	.word	04047H,278,0,03H
	.word	04047H,331,1,05H
	.word	04047H,346,114,08H
	.word	04047H,399,114,01H
	.word	04047H,411,0,03H
	.word	04047H,464,1,05H
	.word	04047H,479,114,08H
	.word	04047H,532,114,01H
	.word	04047H,544,0,03H
	.word	04047H,597,1,05H
	.word	04047H,612,114,08H
	.word	04047H,665,114,01H
	.word	0FFFFH	;End Marker
SOUL1BMOD:
	.word	1276,57,10	;x size, y size, #blocks
	.long	SOUL1BLKS, OULHDRS, OULPALS
SOUL2BMOD:
	.word	1236,112,14	;x size, y size, #blocks
	.long	SOUL2BLKS, OULHDRS, OULPALS
SOUL3BMOD:
	.word	1471,211,71	;x size, y size, #blocks
	.long	SOUL3BLKS, OULHDRS, OULPALS
SOUL4BMOD:
	.word	616,54,7	;x size, y size, #blocks
	.long	SOUL4BLKS, OULHDRS, OULPALS
SOUL5BMOD:
	.word	717,153,21	;x size, y size, #blocks
	.long	SOUL5BLKS, OULHDRS, OULPALS

NKHDRS:
	.word	56,53	;x size, y size
	.long	07203CAEH	;address
	.word	06080H	;dma ctrl
	.word	48,56
	.long	0720816AH
	.word	06280H
	.word	48,56
	.long	0720BFA2H
	.word	06480H
	.word	72,52
	.long	0720FBE2H
	.word	06080H
	.word	96,17
	.long	072152D2H
	.word	06880H
	.word	48,78
	.long	072173E2H
	.word	06000H
	.word	56,67
	.long	0721CBA2H
	.word	06000H
	.word	52,78
	.long	07222392H
	.word	06080H
	.word	4,78
	.long	07227C84H
	.word	06000H
	.word	52,67
	.long	072283D4H
	.word	06080H
	.word	76,56
	.long	0722D470H
	.word	06180H
	.word	28,90
	.long	072332C4H
	.word	06000H
	.word	72,11
	.long	07236DD4H
	.word	06000H
	.word	48,78
	.long	07238064H
	.word	06080H
	.word	64,53
	.long	0723D290H
	.word	06080H
	.word	72,78
	.long	07241FFEH
	.word	06080H
	.word	72,78
	.long	0724A266H
	.word	06080H
	.word	76,11
	.long	072524CEH
	.word	06000H
	.word	48,78
	.long	07253866H
	.word	06180H
	.word	28,90
	.long	0725883AH
	.word	06000H
	.word	112,16
	.long	0725C34AH
	.word	06880H
	.word	48,78
	.long	0725E872H
	.word	06080H
	.word	48,78
	.long	07263D26H
	.word	06080H
	.word	108,56
	.long	072693AEH
	.word	06C80H
	.word	108,27
	.long	072712DEH
	.word	06080H
	.word	124,59
	.long	072755C8H
	.word	04380H
	.word	52,25
	.long	0727B908H
	.word	06480H
	.word	44,45
	.long	0727D3C8H
	.word	06080H
	.word	40,82
	.long	0727FB2EH
	.word	06580H
	.word	44,24
	.long	072832FEH
	.word	06480H
	.word	40,87
	.long	072844E0H
	.word	06480H
	.word	136,58
	.long	07288E42H
	.word	04C80H
	.word	24,75
	.long	0728F112H
	.word	06080H
	.word	180,34
	.long	07290CD2H
	.word	06F80H
	.word	172,27
	.long	07299062H
	.word	06080H
BANK1BLKS:
	.word	04053H	;flags
	.word	0,223 ;x,y
	.word	03H	;pal5,pal4,hdr13-0
	.word	04044H,2,275,04H
	.word	04050H,2,67,05H
	.word	04046H,2,0,06H
	.word	04050H,48,67,07H
	.word	04040H,55,145,08H
	.word	04046H,58,0,09H
	.word	04053H,69,220,0AH
	.word	04052H,85,130,0BH
	.word	04043H,95,276,0CH
	.word	04050H,98,67,0DH
	.word	04046H,108,0,06H
	.word	04053H,142,223,0EH
	.word	04050H,144,67,0FH
	.word	04051H,144,145,010H
	.word	04046H,164,0,09H
	.word	04043H,167,276,011H
	.word	04053H,204,220,02H
	.word	04046H,214,0,06H
	.word	04050H,215,67,012H
	.word	04052H,235,130,013H
	.word	04054H,242,276,014H
	.word	04053H,252,220,01H
	.word	04050H,260,67,015H
	.word	04046H,270,0,09H
	.word	04053H,298,223,00H
	.word	04040H,305,146,08H
	.word	04050H,306,67,016H
	.word	04046H,320,0,06H
	.word	04053H,352,223,03H
	.word	04044H,354,275,04H
	.word	04050H,354,67,05H
	.word	04046H,376,0,09H
	.word	04050H,400,67,07H
	.word	04040H,404,145,08H
	.word	04053H,421,220,0AH
	.word	04046H,426,0,06H
	.word	04052H,437,130,0BH
	.word	04043H,447,276,0CH
	.word	04050H,450,67,0DH
	.word	04046H,482,0,09H
	.word	04053H,494,223,0EH
	.word	04051H,496,145,010H
	.word	04050H,496,67,0FH
	.word	04043H,519,276,011H
	.word	04046H,532,0,06H
	.word	04053H,556,220,02H
	.word	04050H,567,67,012H
	.word	04052H,587,130,013H
	.word	04046H,588,0,09H
	.word	04054H,594,276,014H
	.word	04053H,604,220,01H
	.word	04050H,612,67,015H
	.word	04046H,638,0,06H
	.word	04053H,650,223,00H
	.word	04040H,653,145,08H
	.word	04050H,658,67,016H
	.word	04046H,694,0,09H
	.word	04044H,706,276,014H
	.word	04040H,706,67,016H
	.word	04043H,706,223,00H
	.word	04046H,744,0,06H
	.word	04040H,751,145,08H
	.word	04040H,752,67,015H
	.word	04043H,760,220,01H
	.word	04042H,797,130,013H
	.word	04040H,797,67,012H
	.word	04046H,800,0,09H
	.word	04043H,808,220,02H
	.word	04043H,818,276,011H
	.word	04041H,844,145,010H
	.word	04040H,844,67,0FH
	.word	04046H,850,0,06H
	.word	04043H,854,223,0EH
	.word	04043H,893,276,0CH
	.word	04046H,906,0,09H
	.word	04040H,914,67,0DH
	.word	04043H,915,220,0AH
	.word	04042H,947,130,0BH
	.word	04046H,956,0,06H
	.word	04040H,960,67,07H
	.word	04054H,962,275,04H
	.word	04043H,988,223,03H
	.word	04040H,1002,145,08H
	.word	04040H,1010,67,05H
	.word	04046H,1012,0,09H
	.word	04044H,1058,276,014H
	.word	04040H,1058,67,016H
	.word	04043H,1058,223,00H
	.word	04046H,1062,0,06H
	.word	04040H,1096,145,08H
	.word	04040H,1104,67,015H
	.word	04043H,1112,220,01H
	.word	04046H,1118,0,09H
	.word	04042H,1149,130,013H
	.word	04040H,1149,67,012H
	.word	04043H,1160,220,02H
	.word	04046H,1168,0,06H
	.word	04043H,1170,276,0CH
	.word	04040H,1196,67,0FH
	.word	04041H,1196,145,010H
	.word	04043H,1206,223,0EH
	.word	04046H,1224,0,09H
	.word	04043H,1242,276,011H
	.word	04040H,1266,67,0DH
	.word	04043H,1267,220,0AH
	.word	04046H,1274,0,06H
	.word	04042H,1299,130,0BH
	.word	04040H,1312,67,07H
	.word	04054H,1314,275,04H
	.word	04046H,1330,0,09H
	.word	04043H,1340,223,03H
	.word	04040H,1352,145,08H
	.word	04046H,1354,0,06H
	.word	04040H,1362,67,05H
	.word	0FFFFH	;End Marker
BANK2BLKS:
	.word	04047H	;flags
	.word	0,37 ;x,y
	.word	017H	;pal5,pal4,hdr13-0
	.word	04048H,0,93,018H
	.word	0404DH,69,0,019H
	.word	04047H,105,50,01AH
	.word	04049H,105,75,01BH
	.word	0404BH,136,53,01CH
	.word	0404BH,170,29,01DH
	.word	0404BH,174,53,01EH
	.word	0404DH,193,0,01FH
	.word	0404BH,214,56,020H
	.word	0404AH,223,58,021H
	.word	0404AH,232,92,022H
	.word	0FFFFH	;End Marker

;file MKBANK blocks not in any module
;	.word	04053H	;flags
;	.word	249,698 ;x,y
;	.word	00H	;pal5,pal4,hdr13-0
;	.word	04053H,310,696,01H
;	.word	04053H,365,698,02H
;	.word	0FFFFH	;End Marker
BANK1BMOD:
	.word	1412,292,115	;x size, y size, #blocks
	.long	BANK1BLKS, NKHDRS, NKPALS
BANK2BMOD:
	.word	404,140,12	;x size, y size, #blocks
	.long	BANK2BLKS, NKHDRS, NKPALS

reetHDRS:
	.word	52,15	;x size, y size
	.long	0729F9D4H	;address
	.word	06000H	;dma ctrl
	.word	48,15
	.long	072A0C1CH
	.word	06000H
	.word	52,185
	.long	072A1CFCH
	.word	06080H
	.word	52,127
	.long	072AF73AH
	.word	06280H
	.word	40,15
	.long	072B8FB8H
	.word	06000H
	.word	56,121
	.long	072B9DC8H
	.word	06280H
	.word	52,15
	.long	072C364CH
	.word	06000H
	.word	56,185
	.long	072C4894H
	.word	06000H
	.word	56,15
	.long	072D3B64H
	.word	06080H
	.word	56,114
	.long	072D4ED8H
	.word	06280H
	.word	56,185
	.long	072DDC44H
	.word	06080H
	.word	40,76
	.long	072EC7DAH
	.word	06180H
	.word	56,23
	.long	072EE7AAH
	.word	06080H
	.word	168,47
	.long	072F04F4H
	.word	06B80H
	.word	52,34
	.long	072F9C24H
	.word	06880H
	.word	44,205
	.long	072FB324H
	.word	06580H
	.word	52,15
	.long	072FF634H
	.word	06000H
	.word	56,109
	.long	0730087CH
	.word	06480H
	.word	56,185
	.long	0730887CH
	.word	06080H
	.word	52,23
	.long	07315F1EH
	.word	06000H
	.word	44,52
	.long	07317B26H
	.word	06080H
	.word	20,15
	.long	0731AFDEH
	.word	06480H
	.word	24,17
	.long	0731B4ACH
	.word	06180H
	.word	56,23
	.long	0731BC42H
	.word	06000H
	.word	144,52
	.long	0731DA72H
	.word	06080H
	.word	56,23
	.long	0732887AH
	.word	06080H
	.word	124,32
	.long	0732A5C4H
	.word	06380H
	.word	136,77
	.long	0732EB8EH
	.word	06380H
	.word	88,95
	.long	0733A292H
	.word	06A80H
	.word	40,23
	.long	0734319AH
	.word	06000H
	.word	40,23
	.long	0734472AH
	.word	06080H
	.word	152,59
	.long	07345C5EH
	.word	06B80H
	.word	56,23
	.long	07350B46H
	.word	06000H
	.word	52,15
	.long	07352976H
	.word	06000H
	.word	56,23
	.long	07350B46H
	.word	06000H
street4BLKS:
	.word	04046H	;flags
	.word	0,56 ;x,y
	.word	0DH	;pal5,pal4,hdr13-0
	.word	04045H,1,54,0EH
	.word	04045H,68,60,015H
	.word	04047H,148,73,01AH
	.word	04049H,164,0,01CH
	.word	04048H,253,44,01FH
	.word	0FFFFH	;End Marker
street3BLKS:
	.word	04050H	;flags
	.word	0,127 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04050H,1,0,03H
	.word	04050H,51,6,05H
	.word	04050H,52,127,07H
	.word	04050H,104,13,09H
	.word	04050H,105,127,0AH
	.word	04641H,110,224,0BH
	.word	04050H,158,18,011H
	.word	04050H,159,127,012H
	.word	03F40H,209,260,014H
	.word	04050H,213,36,016H
	.word	04040H,253,260,018H
	.word	04142H,303,224,01BH
	.word	04040H,397,260,018H
	.word	04040H,512,36,016H
	.word	04040H,535,127,012H
	.word	04040H,535,18,011H
	.word	04641H,575,223,0BH
	.word	04040H,589,127,0AH
	.word	04040H,589,13,09H
	.word	04040H,642,127,07H
	.word	04040H,642,6,05H
	.word	04040H,696,0,03H
	.word	04040H,698,127,02H
	.word	04050H,744,127,02H
	.word	04050H,746,0,03H
	.word	04050H,796,127,07H
	.word	04050H,796,6,05H
	.word	0FFFFH	;End Marker
street1BLKS:
	.word	04043H	;flags
	.word	0,198 ;x,y
	.word	0CH	;pal5,pal4,hdr13-0
	.word	04144H,40,0,0FH
	.word	04043H,53,198,013H
	.word	04043H,105,198,017H
	.word	04043H,160,198,019H
	.word	04043H,213,198,01DH
	.word	04043H,253,198,01EH
	.word	04043H,291,198,020H
	.word	04043H,346,198,0CH
	.word	04144H,386,0,0FH
	.word	04043H,399,198,013H
	.word	04043H,451,198,017H
	.word	04043H,506,198,019H
	.word	04043H,559,198,01DH
	.word	04043H,599,198,01EH
	.word	04053H,635,198,01EH
	.word	04053H,675,198,01DH
	.word	04053H,712,198,019H
	.word	04053H,767,198,017H
	.word	04053H,823,198,013H
	.word	04154H,842,0,0FH
	.word	04053H,872,198,0CH
	.word	04053H,927,198,022H
	.word	04053H,981,198,01EH
	.word	04053H,1021,198,01DH
	.word	04053H,1058,198,019H
	.word	04053H,1113,198,017H
	.word	04053H,1169,198,013H
	.word	04154H,1187,0,0FH
	.word	04053H,1218,198,0CH
	.word	0FFFFH	;End Marker
street2BLKS:
	.word	04043H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04043H,51,0,01H
	.word	04043H,96,0,04H
	.word	04043H,135,0,06H
	.word	04043H,186,0,08H
	.word	04043H,240,0,010H
	.word	04053H,289,0,08H
	.word	04053H,342,0,06H
	.word	04043H,394,0,01H
	.word	04043H,441,0,04H
	.word	04043H,481,0,06H
	.word	04043H,532,0,08H
	.word	04043H,586,0,010H
	.word	04043H,637,0,021H
	.word	04043H,689,0,00H
	.word	04043H,740,0,01H
	.word	04043H,787,0,04H
	.word	04043H,827,0,06H
	.word	04043H,878,0,08H
	.word	04043H,932,0,010H
	.word	0FFFFH	;End Marker
street4BMOD:
	.word	405,105,6	;x size, y size, #blocks
	.long	street4BLKS, reetHDRS, reetPALS
street3BMOD:
	.word	852,312,28	;x size, y size, #blocks
	.long	street3BLKS, reetHDRS, reetPALS
street1BMOD:
	.word	1274,221,30	;x size, y size, #blocks
	.long	street1BLKS, reetHDRS, reetPALS
street2BMOD:
	.word	984,15,20	;x size, y size, #blocks
	.long	street2BLKS, reetHDRS, reetPALS

IDGEHDRS:
	.word	72,160	;x size, y size
	.long	07353BBEH	;address
	.word	06000H	;dma ctrl
	.word	88,128
	.long	073649BEH
	.word	06880H
	.word	64,160
	.long	07375042H
	.word	06000H
	.word	96,122
	.long	07384042H
	.word	06C80H
	.word	104,73
	.long	07395164H
	.word	06080H
	.word	48,158
	.long	073A01E8H
	.word	06000H
	.word	56,160
	.long	073AB3A8H
	.word	06000H
	.word	56,54
	.long	073B85A8H
	.word	06580H
	.word	52,148
	.long	073BB9F8H
	.word	06880H
	.word	148,72
	.long	073C4BF8H
	.word	06880H
	.word	104,125
	.long	073CFF44H
	.word	06980H
	.word	56,143
	.long	073E2548H
	.word	06580H
	.word	56,118
	.long	073ED2E0H
	.word	06480H
	.word	60,40
	.long	073F5E08H
	.word	06000H
	.word	36,92
	.long	073F9648H
	.word	06080H
	.word	36,95
	.long	073FE278H
	.word	06080H
	.word	96,110
	.long	07403124H
	.word	06C80H
	.word	40,103
	.long	0741219AH
	.word	06480H
	.word	144,5
	.long	07417716H
	.word	06480H
	.word	132,67
	.long	07418686H
	.word	06080H
	.word	28,135
	.long	074249A0H
	.word	06080H
	.word	12,93
	.long	07427610H
	.word	06080H
	.word	96,67
	.long	07428EC4H
	.word	06680H
	.word	160,5
	.long	07431560H
	.word	06580H
	.word	80,67
	.long	074325CCH
	.word	06880H
	.word	56,116
	.long	07438B2CH
	.word	06080H
	.word	32,111
	.long	0743EC98H
	.word	06080H
	.word	80,67
	.long	07443B7CH
	.word	06280H
BRIDGE1BLKS:
	.word	04047H	;flags
	.word	0,174 ;x,y
	.word	04H	;pal5,pal4,hdr13-0
	.word	04049H,0,16,05H
	.word	04248H,35,186,07H
	.word	0404AH,48,26,08H
	.word	04044H,62,175,09H
	.word	0404BH,151,188,0DH
	.word	0405BH,161,96,0EH
	.word	0405CH,161,1,0FH
	.word	03C5DH,193,175,012H
	.word	04055H,209,180,013H
	.word	0405EH,326,93,014H
	.word	0405EH,332,0,015H
	.word	04055H,341,180,016H
	.word	0405DH,342,175,017H
	.word	04046H,437,180,018H
	.word	0404BH,490,113,019H
	.word	0404CH,502,2,01AH
	.word	04046H,517,180,01BH
	.word	0404DH,532,175,017H
	.word	04045H,597,180,016H
	.word	0404EH,680,93,014H
	.word	0404EH,690,0,015H
	.word	04045H,693,180,013H
	.word	03C4DH,697,175,012H
	.word	0405BH,823,188,0DH
	.word	04054H,824,175,09H
	.word	0404CH,837,1,0FH
	.word	0404BH,837,96,0EH
	.word	04057H,930,174,04H
	.word	0405AH,934,26,08H
	.word	04258H,943,189,07H
	.word	04059H,986,16,05H
	.word	0FFFFH	;End Marker
BRIDGE2BLKS:
	.word	04041H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04041H,72,0,02H
	.word	04041H,136,0,06H
	.word	04042H,191,17,0BH
	.word	04042H,247,42,0CH
	.word	04043H,300,57,011H
	.word	0FFFFH	;End Marker
BRIDGE3BLKS:
	.word	04040H	;flags
	.word	0,0 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	04040H,88,6,03H
	.word	04040H,184,3,0AH
	.word	04040H,287,18,010H
	.word	0FFFFH	;End Marker
BRIDGE1BMOD:
	.word	1034,247,32	;x size, y size, #blocks
	.long	BRIDGE1BLKS, IDGEHDRS, IDGEPALS
BRIDGE2BMOD:
	.word	340,160,6	;x size, y size, #blocks
	.long	BRIDGE2BLKS, IDGEHDRS, IDGEPALS
BRIDGE3BMOD:
	.word	383,128,4	;x size, y size, #blocks
	.long	BRIDGE3BLKS, IDGEHDRS, IDGEPALS

LLHDRS:
	.word	20,69	;x size, y size
	.long	0744A0DCH	;address
	.word	06080H	;dma ctrl
	.word	64,81
	.long	0744BE82H
	.word	06580H
	.word	40,79
	.long	07450E0EH
	.word	06000H
	.word	32,67
	.long	0745581EH
	.word	06080H
	.word	40,16
	.long	074584D8H
	.word	03480H
	.word	28,88
	.long	07458918H
	.word	06080H
	.word	44,94
	.long	0745C2B6H
	.word	06480H
	.word	92,76
	.long	0746182CH
	.word	06580H
	.word	72,11
	.long	07469BB0H
	.word	06280H
	.word	108,29
	.long	0746AA00H
	.word	06880H
	.word	76,48
	.long	0746E448H
	.word	06080H
	.word	48,53
	.long	074737E8H
	.word	06480H
	.word	68,31
	.long	07476CF0H
	.word	06080H
	.word	48,52
	.long	0747983CH
	.word	06080H
	.word	48,54
	.long	0747C298H
	.word	06180H
	.word	44,50
	.long	0747FB1AH
	.word	06000H
	.word	76,28
	.long	07482EAAH
	.word	06080H
	.word	136,31
	.long	07485F72H
	.word	06080H
	.word	72,47
	.long	0748BECCH
	.word	06000H
	.word	72,48
	.long	07490E1CH
	.word	06280H
	.word	92,54
	.long	07495A84H
	.word	06580H
	.word	84,28
	.long	0749AA88H
	.word	06080H
	.word	12,50
	.long	0749E198H
	.word	06080H
	.word	48,66
	.long	0749EEF8H
	.word	06080H
	.word	44,75
	.long	074A2C96H
	.word	06080H
	.word	8,101
	.long	074A6D6AH
	.word	06000H
	.word	8,118
	.long	074A805AH
	.word	06000H
	.word	52,48
	.long	074A967AH
	.word	06080H
	.word	48,44
	.long	074AD03AH
	.word	06000H
	.word	140,31
	.long	074B01BAH
	.word	06080H
	.word	80,28
	.long	074B6408H
	.word	06080H
	.word	16,159
	.long	074B9560H
	.word	06080H
	.word	52,48
	.long	074BC02CH
	.word	06000H
	.word	52,44
	.long	074BFAACH
	.word	06080H
	.word	48,52
	.long	074C2F9CH
	.word	06280H
	.word	36,214
	.long	074C6604H
	.word	06080H
	.word	40,54
	.long	074D0DACH
	.word	06000H
	.word	32,35
	.long	074D404CH
	.word	06080H
	.word	72,51
	.long	074D5976H
	.word	06080H
	.word	76,48
	.long	074DAA04H
	.word	06080H
	.word	56,226
	.long	074DFD98H
	.word	06000H
	.word	76,51
	.long	074F2638H
	.word	06080H
	.word	108,56
	.long	074F804AH
	.word	06080H
	.word	48,53
	.long	07500322H
	.word	06080H
	.word	48,51
	.long	07502E88H
	.word	06280H
	.word	44,48
	.long	0750645EH
	.word	06000H
	.word	36,48
	.long	075095DEH
	.word	06180H
	.word	32,60
	.long	0750BC1EH
	.word	06580H
	.word	44,69
	.long	0750E4FEH
	.word	06180H
	.word	40,49
	.long	07512674H
	.word	06000H
	.word	28,25
	.long	07515464H
	.word	06080H
	.word	96,55
	.long	07515FD0H
	.word	06080H
	.word	28,113
	.long	0751D9B2H
	.word	06080H
	.word	24,114
	.long	075221C2H
	.word	06000H
	.word	40,67
	.long	075261E2H
	.word	06080H
	.word	40,82
	.long	07529E56H
	.word	06480H
	.word	40,78
	.long	0752CE52H
	.word	06080H
	.word	56,226
	.long	075316E8H
	.word	06000H
	.word	52,80
	.long	07543F88H
	.word	06980H
	.word	56,82
	.long	075459A8H
	.word	06680H
	.word	12,71
	.long	075474C8H
	.word	06080H
MKBELL6BLKS:
	.word	04041H	;flags
	.word	0,1 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04042H,0,68,01H
	.word	04041H,0,149,02H
	.word	04041H,17,1,03H
	.word	04041H,28,0,04H
	.word	04041H,39,140,05H
	.word	04041H,46,0,06H
	.word	04042H,64,86,08H
	.word	04041H,66,199,09H
	.word	04041H,66,151,0AH
	.word	04041H,90,33,0BH
	.word	04042H,136,97,0DH
	.word	04041H,136,43,0EH
	.word	04041H,139,149,0FH
	.word	04041H,182,152,012H
	.word	04041H,183,55,013H
	.word	04042H,251,100,016H
	.word	04043H,252,58,017H
	.word	04043H,253,124,018H
	.word	04041H,294,151,01BH
	.word	04041H,296,60,01CH
	.word	04041H,344,151,020H
	.word	04041H,344,60,021H
	.word	04041H,394,58,022H
	.word	04041H,396,145,024H
	.word	04042H,399,110,025H
	.word	04041H,436,151,027H
	.word	04051H,436,55,013H
	.word	04042H,508,98,02BH
	.word	04041H,508,47,02CH
	.word	04041H,509,151,02DH
	.word	04051H,517,199,09H
	.word	04041H,552,151,02EH
	.word	04041H,555,37,02FH
	.word	04041H,585,26,030H
	.word	04041H,585,150,031H
	.word	04041H,601,2,032H
	.word	04051H,623,1,04H
	.word	04041H,625,115,034H
	.word	04041H,628,2,035H
	.word	04041H,652,1,036H
	.word	04042H,652,68,037H
	.word	04041H,652,150,038H
	.word	0FFFFH	;End Marker
MKBELL1BLKS:
	.word	04045H	;flags
	.word	0,0 ;x,y
	.word	01FH	;pal5,pal4,hdr13-0
	.word	04045H,261,0,01FH
	.word	04045H,567,0,01FH
	.word	0FFFFH	;End Marker
MKBELL5BLKS:
	.word	04045H	;flags
	.word	0,0 ;x,y
	.word	014H	;pal5,pal4,hdr13-0
	.word	04045H,499,0,014H
	.word	0FFFFH	;End Marker
MKBELL4BLKS:
	.word	04044H	;flags
	.word	0,186 ;x,y
	.word	010H	;pal5,pal4,hdr13-0
	.word	04044H,75,186,015H
	.word	04044H,159,186,01EH
	.word	04044H,236,0,023H
	.word	04044H,269,163,026H
	.word	04044H,338,163,029H
	.word	04054H,410,0,023H
	.word	04054H,443,187,01EH
	.word	04054H,523,187,015H
	.word	04054H,606,187,010H
	.word	0FFFFH	;End Marker
MKBELL3BLKS:
	.word	04046H	;flags
	.word	0,119 ;x,y
	.word	019H	;pal5,pal4,hdr13-0
	.word	04046H,1,2,01AH
	.word	04046H,501,2,03AH
	.word	04046H,553,0,03BH
	.word	04046H,652,120,03CH
	.word	04046H,654,2,01AH
	.word	0FFFFH	;End Marker
MKBELL2BLKS:
	.word	04044H	;flags
	.word	0,195 ;x,y
	.word	0CH	;pal5,pal4,hdr13-0
	.word	04044H,66,195,011H
	.word	04044H,199,195,01DH
	.word	04044H,338,0,028H
	.word	04044H,394,170,02AH
	.word	04044H,499,171,033H
	.word	04044H,593,0,039H
	.word	04054H,648,195,01DH
	.word	04054H,785,195,011H
	.word	04054H,919,195,0CH
	.word	0FFFFH	;End Marker
MKBELL7BLKS:
	.word	04040H	;flags
	.word	0,0 ;x,y
	.word	07H	;pal5,pal4,hdr13-0
	.word	0FFFFH	;End Marker
MKBELL6BMOD:
	.word	692,228,43	;x size, y size, #blocks
	.long	MKBELL6BLKS, LLHDRS, LLPALS
MKBELL1BMOD:
	.word	583,159,3	;x size, y size, #blocks
	.long	MKBELL1BLKS, LLHDRS, LLPALS
MKBELL5BMOD:
	.word	591,54,2	;x size, y size, #blocks
	.long	MKBELL5BLKS, LLHDRS, LLPALS
MKBELL4BMOD:
	.word	682,215,10	;x size, y size, #blocks
	.long	MKBELL4BLKS, LLHDRS, LLPALS
MKBELL3BMOD:
	.word	664,220,6	;x size, y size, #blocks
	.long	MKBELL3BLKS, LLHDRS, LLPALS
MKBELL2BMOD:
	.word	987,226,10	;x size, y size, #blocks
	.long	MKBELL2BLKS, LLHDRS, LLPALS
MKBELL7BMOD:
	.word	92,76,1	;x size, y size, #blocks
	.long	MKBELL7BLKS, LLHDRS, LLPALS

LL2HDRS:
	.word	88,97	;x size, y size
	.long	075487A4H	;address
	.word	06080H	;dma ctrl
	.word	88,95
	.long	07554BEAH
	.word	06080H
	.word	200,77
	.long	07560C24H
	.word	06000H
	.word	204,27
	.long	07577514H
	.word	06080H
	.word	124,51
	.long	0757F51EH
	.word	06080H
	.word	124,50
	.long	07588758H
	.word	06380H
	.word	56,97
	.long	075905FEH
	.word	06080H
	.word	68,50
	.long	07598184H
	.word	06000H
	.word	68,47
	.long	0759D134H
	.word	06000H
	.word	200,77
	.long	075A1C1CH
	.word	06000H
	.word	208,27
	.long	075B850CH
	.word	06080H
	.word	64,88
	.long	075C079EH
	.word	06080H
	.word	24,73
	.long	075C8864H
	.word	06080H
	.word	20,91
	.long	075CA678H
	.word	06080H
	.word	84,91
	.long	075CCD92H
	.word	06000H
	.word	96,11
	.long	075D80BAH
	.word	06080H
	.word	64,67
	.long	075D9870H
	.word	06580H
	.word	56,88
	.long	075DDB14H
	.word	06080H
	.word	24,62
	.long	075E4062H
	.word	06080H
	.word	20,91
	.long	075E5566H
	.word	06080H
	.word	80,71
	.long	075E7C80H
	.word	06080H
	.word	80,74
	.long	075EFEDAH
	.word	06080H
	.word	88,97
	.long	075487A4H
	.word	06080H
MKTOWERBLKS:
	.word	04044H	;flags
	.word	0,67 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04044H,0,164,01H
	.word	04040H,1,286,02H
	.word	04041H,1,259,03H
	.word	04043H,85,111,04H
	.word	04043H,85,61,05H
	.word	04043H,85,162,06H
	.word	04043H,138,162,07H
	.word	04043H,138,212,08H
	.word	04040H,201,286,09H
	.word	04041H,202,259,0AH
	.word	04042H,206,80,0BH
	.word	04042H,206,9,0CH
	.word	04043H,206,168,0DH
	.word	04044H,223,168,0EH
	.word	04042H,226,69,0FH
	.word	04042H,233,0,010H
	.word	04042H,270,80,011H
	.word	04042H,300,7,012H
	.word	04043H,306,168,013H
	.word	04044H,323,188,014H
	.word	04044H,323,114,015H
	.word	0FFFFH	;End Marker

;file MKBELL2 blocks not in any module
;	.word	04044H	;flags
;	.word	942,98 ;x,y
;	.word	016H	;pal5,pal4,hdr13-0
;	.word	0FFFFH	;End Marker
MKTOWERBMOD:
	.word	410,363,22	;x size, y size, #blocks
	.long	MKTOWERBLKS, LL2HDRS, LL2PALS

MP2HDRS:
	.word	60,75	;x size, y size
	.long	075F86B6H	;address
	.word	06080H	;dma ctrl
	.word	60,75
	.long	075FE962H
	.word	06080H
	.word	20,42
	.long	07604B8AH
	.word	06080H
	.word	76,39
	.long	07605E80H
	.word	06000H
	.word	76,36
	.long	0760A3F8H
	.word	06580H
	.word	56,75
	.long	0760CB70H
	.word	06080H
	.word	40,25
	.long	0761277AH
	.word	06080H
	.word	28,77
	.long	07613D1EH
	.word	06080H
	.word	60,75
	.long	07616C2CH
	.word	06080H
	.word	56,39
	.long	0761CD52H
	.word	06880H
	.word	60,75
	.long	0761F9C2H
	.word	06080H
	.word	44,33
	.long	07625980H
	.word	06180H
	.word	28,65
	.long	076277C2H
	.word	06080H
	.word	60,75
	.long	076295AEH
	.word	06080H
	.word	24,114
	.long	0762F6A4H
	.word	06080H
	.word	28,85
	.long	07631B28H
	.word	06080H
	.word	60,75
	.long	07634C80H
	.word	06080H
	.word	20,113
	.long	0763ADA6H
	.word	06080H
	.word	36,144
	.long	0763CF8EH
	.word	06080H
	.word	60,75
	.long	07643DECH
	.word	06080H
	.word	40,144
	.long	0764A25AH
	.word	06080H
	.word	72,25
	.long	0765250AH
	.word	06080H
	.word	24,114
	.long	07654F30H
	.word	06080H
	.word	40,49
	.long	076573B4H
	.word	06880H
	.word	40,80
	.long	0765A08CH
	.word	06080H
	.word	20,113
	.long	0765DD3EH
	.word	06080H
	.word	60,40
	.long	0765FF26H
	.word	06080H
	.word	28,166
	.long	0766268EH
	.word	06080H
	.word	80,31
	.long	0766929CH
	.word	06080H
	.word	32,111
	.long	0766CB86H
	.word	06080H
	.word	72,55
	.long	07671DA6H
	.word	06880H
	.word	128,50
	.long	076763E6H
	.word	06980H
	.word	44,119
	.long	0767D88AH
	.word	06980H
	.word	88,26
	.long	07680882H
	.word	06080H
	.word	36,99
	.long	07683D1EH
	.word	06180H
	.word	48,50
	.long	07688908H
	.word	06280H
	.word	36,99
	.long	0768AC1CH
	.word	06080H
	.word	44,119
	.long	0768FCC2H
	.word	06680H
	.word	32,55
	.long	076928E2H
	.word	06080H
	.word	60,75
	.long	075FE962H
	.word	06080H
temple4BLKS:
	.word	04059H	;flags
	.word	0,27 ;x,y
	.word	0EH	;pal5,pal4,hdr13-0
	.word	04048H,12,46,0FH
	.word	04059H,23,28,011H
	.word	04040H,41,0,012H
	.word	04040H,76,0,014H
	.word	04040H,83,141,015H
	.word	04049H,114,27,016H
	.word	04040H,115,0,017H
	.word	04048H,124,46,0FH
	.word	04049H,136,28,019H
	.word	04040H,154,0,01BH
	.word	04040H,181,55,01DH
	.word	04040H,181,0,01EH
	.word	04047H,211,21,020H
	.word	04040H,212,140,021H
	.word	04048H,220,32,022H
	.word	04040H,250,0,023H
	.word	04048H,253,32,024H
	.word	04047H,255,21,025H
	.word	04050H,295,55,01DH
	.word	04040H,297,0,026H
	.word	04050H,326,0,01BH
	.word	04059H,352,28,019H
	.word	04050H,353,0,017H
	.word	04050H,353,141,015H
	.word	04058H,356,46,0FH
	.word	04059H,370,27,016H
	.word	04050H,392,0,014H
	.word	04050H,431,0,012H
	.word	04049H,465,28,011H
	.word	04058H,468,46,0FH
	.word	04049H,484,27,0EH
	.word	0FFFFH	;End Marker
temple1BLKS:
	.word	04041H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04041H,59,0,01H
	.word	04041H,118,0,05H
	.word	04041H,172,0,08H
	.word	04041H,230,0,0AH
	.word	04041H,287,0,0DH
	.word	04041H,345,0,010H
	.word	04041H,403,0,013H
	.word	04041H,463,0,018H
	.word	04041H,500,49,01CH
	.word	04051H,574,49,01CH
	.word	04051H,651,0,018H
	.word	04051H,691,0,013H
	.word	04051H,749,0,010H
	.word	04051H,807,0,0DH
	.word	04051H,864,0,0AH
	.word	04051H,922,0,08H
	.word	04051H,980,0,05H
	.word	04051H,1035,0,01H
	.word	04051H,1094,0,00H
	.word	0FFFFH	;End Marker
temple2BLKS:
	.word	04045H	;flags
	.word	0,0 ;x,y
	.word	0CH	;pal5,pal4,hdr13-0
	.word	04045H,150,0,0CH
	.word	04044H,266,36,01FH
	.word	04055H,509,0,0CH
	.word	04055H,659,0,0CH
	.word	0FFFFH	;End Marker
temple3BLKS:
	.word	04042H	;flags
	.word	0,0 ;x,y
	.word	03H	;pal5,pal4,hdr13-0
	.word	04046H,11,39,04H
	.word	04046H,25,152,06H
	.word	04046H,32,75,07H
	.word	04042H,76,0,09H
	.word	04042H,131,0,0BH
	.word	04042H,172,0,03H
	.word	04046H,184,39,04H
	.word	04046H,198,152,06H
	.word	04046H,205,75,07H
	.word	04042H,248,0,09H
	.word	04042H,303,0,0BH
	.word	04042H,344,0,03H
	.word	04046H,356,39,04H
	.word	04046H,362,152,01AH
	.word	04046H,378,75,07H
	.word	04042H,420,0,09H
	.word	04052H,474,0,09H
	.word	04056H,518,39,04H
	.word	04056H,528,152,01AH
	.word	04052H,530,0,03H
	.word	04056H,544,75,07H
	.word	04052H,603,0,0BH
	.word	04052H,646,0,09H
	.word	04056H,691,39,04H
	.word	04052H,702,0,03H
	.word	04056H,713,152,06H
	.word	04056H,718,75,07H
	.word	04056H,863,39,04H
	.word	04056H,885,152,06H
	.word	04056H,890,75,07H
	.word	0FFFFH	;End Marker
temple0BLKS:
	.word	0404AH	;flags
	.word	0,0 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	0404AH,150,0,02H
	.word	0404AH,300,0,02H
	.word	0404AH,450,0,02H
	.word	0404AH,600,0,02H
	.word	0404AH,750,0,02H
	.word	0404AH,900,0,02H
	.word	0404AH,1050,0,02H
	.word	0404AH,1200,0,02H
	.word	0404AH,1350,0,02H
	.word	0404AH,1481,0,02H
	.word	0FFFFH	;End Marker

;file MKTEMP2 blocks not in any module
;	.word	04051H	;flags
;	.word	1269,767 ;x,y
;	.word	027H	;pal5,pal4,hdr13-0
;	.word	0404AH,1772,1120,02H
;	.word	0FFFFH	;End Marker
temple4BMOD:
	.word	508,166,32	;x size, y size, #blocks
	.long	temple4BLKS, MP2HDRS, MP2PALS
temple1BMOD:
	.word	1154,80,20	;x size, y size, #blocks
	.long	temple1BLKS, MP2HDRS, MP2PALS
temple2BMOD:
	.word	687,86,5	;x size, y size, #blocks
	.long	temple2BLKS, MP2HDRS, MP2PALS
temple3BMOD:
	.word	939,192,31	;x size, y size, #blocks
	.long	temple3BLKS, MP2HDRS, MP2PALS
temple0BMOD:
	.word	1501,42,11	;x size, y size, #blocks
	.long	temple0BLKS, MP2HDRS, MP2PALS

AVEHDRS:
	.word	56,23	;x size, y size
	.long	07695146H	;address
	.word	06580H	;dma ctrl
	.word	60,29
	.long	07696302H
	.word	06280H
	.word	88,15
	.long	076988AAH
	.word	05980H
	.word	52,9
	.long	076996CEH
	.word	05280H
	.word	136,54
	.long	07699F22H
	.word	06D80H
	.word	68,26
	.long	076A3AB6H
	.word	06080H
	.word	64,32
	.long	076A5E5AH
	.word	06000H
	.word	176,23
	.long	076A8E5AH
	.word	06380H
	.word	16,225
	.long	076AD4A2H
	.word	06080H
	.word	44,219
	.long	076B1AB6H
	.word	06080H
	.word	84,25
	.long	076BEF2CH
	.word	06380H
	.word	96,35
	.long	076C01C4H
	.word	05980H
	.word	80,18
	.long	076C283EH
	.word	06280H
	.word	40,199
	.long	076C4866H
	.word	06080H
	.word	52,114
	.long	076CF542H
	.word	04280H
	.word	40,63
	.long	076D20DEH
	.word	06080H
	.word	128,66
	.long	076D52EEH
	.word	06380H
	.word	40,83
	.long	076DEFDEH
	.word	06480H
	.word	28,91
	.long	076E1BFEH
	.word	06180H
	.word	36,38
	.long	076E4CAEH
	.word	06580H
	.word	28,22
	.long	076E5CA2H
	.word	06080H
	.word	44,14
	.long	076E69ACH
	.word	05000H
	.word	80,32
	.long	076E75B4H
	.word	06880H
	.word	32,66
	.long	076E9EFEH
	.word	06000H
	.word	128,43
	.long	076ED07EH
	.word	06C80H
	.word	72,18
	.long	076F3326H
	.word	06000H
	.word	56,107
	.long	076F5186H
	.word	04880H
	.word	88,26
	.long	076F7BB2H
	.word	05A80H
	.word	76,20
	.long	076F9BD6H
	.word	06280H
	.word	44,65
	.long	076FB38CH
	.word	06480H
	.word	128,35
	.long	076FE45CH
	.word	06C80H
	.word	40,98
	.long	077037F4H
	.word	06080H
	.word	76,33
	.long	07707674H
	.word	06880H
	.word	144,83
	.long	0770A93EH
	.word	06D80H
	.word	80,15
	.long	0771A326H
	.word	05880H
	.word	108,38
	.long	0771B389H
	.word	06D80H
	.word	100,54
	.long	0771E0D5H
	.word	06980H
	.word	24,23
	.long	07722959H
	.word	06080H
	.word	84,24
	.long	077235F9H
	.word	06C80H
	.word	72,13
	.long	077260E9H
	.word	06580H
	.word	28,97
	.long	077275D9H
	.word	06080H
	.word	28,53
	.long	0772990FH
	.word	06080H
	.word	52,17
	.long	0772ABFDH
	.word	05880H
	.word	20,76
	.long	0772B5A9H
	.word	06080H
	.word	32,46
	.long	0772CEE3H
	.word	06080H
	.word	96,27
	.long	0772E50BH
	.word	06980H
	.word	60,19
	.long	077312B3H
	.word	06480H
	.word	104,17
	.long	07732A73H
	.word	06280H
	.word	72,18
	.long	0773521FH
	.word	06880H
	.word	36,29
	.long	0773704FH
	.word	06480H
	.word	52,47
	.long	07737FADH
	.word	06180H
	.word	24,55
	.long	0773AFE7H
	.word	06080H
	.word	64,36
	.long	0773C3EDH
	.word	06580H
	.word	88,19
	.long	0773E019H
	.word	06580H
	.word	24,51
	.long	077402ADH
	.word	06580H
	.word	52,34
	.long	07741039H
	.word	06280H
	.word	40,39
	.long	07742973H
	.word	06180H
	.word	112,17
	.long	077444D9H
	.word	06C80H
	.word	40,65
	.long	07746D21H
	.word	06480H
	.word	44,62
	.long	0774943DH
	.word	06580H
	.word	48,56
	.long	0774C65DH
	.word	06A80H
	.word	48,23
	.long	0774DCEDH
	.word	06000H
	.word	64,32
	.long	0774F6CDH
	.word	06580H
	.word	88,20
	.long	077517C5H
	.word	06C80H
	.word	96,23
	.long	07753545H
	.word	06980H
	.word	136,14
	.long	07756411H
	.word	06080H
	.word	36,36
	.long	07758FBFH
	.word	06080H
	.word	36,83
	.long	0775ABD9H
	.word	06080H
	.word	28,55
	.long	0775E129H
	.word	06080H
	.word	132,25
	.long	0776006FH
	.word	06D80H
	.word	64,46
	.long	07761FD3H
	.word	06880H
	.word	44,54
	.long	0776579DH
	.word	06080H
	.word	52,65
	.long	07767D23H
	.word	06980H
	.word	104,14
	.long	07769DF7H
	.word	06000H
	.word	48,54
	.long	0776C017H
	.word	06880H
	.word	76,45
	.long	0776D91FH
	.word	06580H
	.word	48,57
	.long	07770DB7H
	.word	06480H
	.word	36,89
	.long	07773949H
	.word	06180H
	.word	100,27
	.long	07776C53H
	.word	06280H
	.word	24,25
	.long	0777A5EFH
	.word	06080H
	.word	20,101
	.long	0777B359H
	.word	06080H
	.word	24,101
	.long	0777D313H
	.word	06480H
	.word	132,21
	.long	0777F5A3H
	.word	06D80H
	.word	36,61
	.long	0778246BH
	.word	06480H
GRAVE7BLKS:
	.word	04049H	;flags
	.word	0,29 ;x,y
	.word	04H	;pal5,pal4,hdr13-0
	.word	04049H,136,17,010H
	.word	04049H,264,0,021H
	.word	0FFFFH	;End Marker
GRAVE6BLKS:
	.word	04040H	;flags
	.word	0,20 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04040H,88,0,0BH
	.word	04040H,183,9,01BH
	.word	04040H,270,20,022H
	.word	04040H,347,18,02AH
	.word	04040H,398,20,022H
	.word	0FFFFH	;End Marker
GRAVE5BLKS:
	.word	04046H	;flags
	.word	0,91 ;x,y
	.word	0AH	;pal5,pal4,hdr13-0
	.word	0404CH,44,0,0EH
	.word	0404CH,94,7,01AH
	.word	04046H,117,95,01CH
	.word	04046H,190,76,023H
	.word	04046H,298,100,02FH
	.word	04046H,334,53,032H
	.word	04046H,383,55,03BH
	.word	04046H,421,97,03FH
	.word	0FFFFH	;End Marker
GRAVE4BLKS:
	.word	04046H	;flags
	.word	0,61 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04056H,51,58,05H
	.word	04046H,119,66,0CH
	.word	04046H,155,3,0FH
	.word	04046H,195,0,017H
	.word	04046H,197,66,019H
	.word	04046H,227,1,01DH
	.word	04046H,268,58,05H
	.word	04046H,333,71,027H
	.word	0404BH,358,18,029H
	.word	04046H,405,55,031H
	.word	04046H,440,29,033H
	.word	04046H,463,61,00H
	.word	04046H,517,61,03DH
	.word	04046H,565,59,045H
	.word	0FFFFH	;End Marker
GRAVE3BLKS:
	.word	04047H	;flags
	.word	0,82 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	04047H,60,79,06H
	.word	04057H,124,79,06H
	.word	04047H,188,97,015H
	.word	04047H,188,65,016H
	.word	04047H,268,64,020H
	.word	04047H,344,0,028H
	.word	04047H,365,21,02BH
	.word	04047H,383,70,02DH
	.word	04047H,477,32,03AH
	.word	04047H,514,65,03EH
	.word	04047H,575,65,046H
	.word	04047H,637,54,04CH
	.word	04047H,682,22,04DH
	.word	04047H,717,86,04FH
	.word	04047H,739,82,01H
	.word	0FFFFH	;End Marker
GRAVE2BLKS:
	.word	04048H	;flags
	.word	0,186 ;x,y
	.word	07H	;pal5,pal4,hdr13-0
	.word	0404AH,122,164,014H
	.word	04048H,176,174,01EH
	.word	0404AH,181,76,01FH
	.word	0404AH,253,164,025H
	.word	04048H,304,163,02CH
	.word	04048H,329,190,02EH
	.word	04044H,382,51,034H
	.word	04043H,386,190,035H
	.word	04042H,387,139,036H
	.word	04044H,402,14,037H
	.word	04041H,410,151,038H
	.word	04044H,443,48,03CH
	.word	04044H,472,186,040H
	.word	04044H,481,0,041H
	.word	04044H,483,12,042H
	.word	04044H,488,48,043H
	.word	04044H,497,131,044H
	.word	04044H,520,13,047H
	.word	04044H,521,67,048H
	.word	04044H,561,13,04AH
	.word	0404AH,568,164,04BH
	.word	04048H,644,182,04EH
	.word	04048H,697,81,050H
	.word	04048H,716,81,051H
	.word	04048H,744,188,052H
	.word	04048H,772,127,053H
	.word	0FFFFH	;End Marker
GRAVE1BLKS:
	.word	04045H	;flags
	.word	0,1 ;x,y
	.word	09H	;pal5,pal4,hdr13-0
	.word	04045H,41,5,0DH
	.word	04045H,78,31,011H
	.word	04045H,78,114,012H
	.word	04045H,104,162,018H
	.word	04045H,229,181,026H
	.word	04045H,312,187,030H
	.word	04045H,384,188,039H
	.word	04045H,494,191,049H
	.word	04055H,595,188,039H
	.word	04055H,707,187,030H
	.word	04055H,778,181,026H
	.word	04055H,859,162,018H
	.word	04055H,973,31,011H
	.word	04055H,985,114,012H
	.word	04055H,1010,5,0DH
	.word	04055H,1047,1,09H
	.word	04055H,1088,0,08H
	.word	0FFFFH	;End Marker
GRAVE0BLKS:
	.word	0404DH	;flags
	.word	0,16 ;x,y
	.word	013H	;pal5,pal4,hdr13-0
	.word	0404DH,141,0,024H
	.word	0404DH,290,16,013H
	.word	0405DH,524,16,013H
	.word	0404DH,593,0,024H
	.word	0405DH,899,16,013H
	.word	0404DH,947,0,024H
	.word	0405DH,1170,16,013H
	.word	0FFFFH	;End Marker

;file MKGRAVE blocks not in any module
;	.word	04040H	;flags
;	.word	177,322 ;x,y
;	.word	03H	;pal5,pal4,hdr13-0
;	.word	04040H,227,322,03H
;	.word	04045H,236,1165,08H
;	.word	0FFFFH	;End Marker
GRAVE7BMOD:
	.word	408,83,3	;x size, y size, #blocks
	.long	GRAVE7BLKS, AVEHDRS, AVEPALS
GRAVE6BMOD:
	.word	478,35,6	;x size, y size, #blocks
	.long	GRAVE6BLKS, AVEHDRS, AVEPALS
GRAVE5BMOD:
	.word	509,117,9	;x size, y size, #blocks
	.long	GRAVE5BLKS, AVEHDRS, AVEPALS
GRAVE4BMOD:
	.word	697,84,15	;x size, y size, #blocks
	.long	GRAVE4BLKS, AVEHDRS, AVEPALS
GRAVE3BMOD:
	.word	799,111,16	;x size, y size, #blocks
	.long	GRAVE3BLKS, AVEHDRS, AVEPALS
GRAVE2BMOD:
	.word	876,209,27	;x size, y size, #blocks
	.long	GRAVE2BLKS, AVEHDRS, AVEPALS
GRAVE1BMOD:
	.word	1104,225,18	;x size, y size, #blocks
	.long	GRAVE1BLKS, AVEHDRS, AVEPALS
GRAVE0BMOD:
	.word	1206,54,8	;x size, y size, #blocks
	.long	GRAVE0BLKS, AVEHDRS, AVEPALS

RONEHDRS:
	.word	136,101	;x size, y size
	.long	07784837H	;address
	.word	06D80H	;dma ctrl
	.word	96,56
	.long	0779493FH
	.word	06080H
	.word	96,52
	.long	0779C50FH
	.word	06080H
	.word	96,48
	.long	077A3807H
	.word	06080H
	.word	96,42
	.long	077AA227H
	.word	06080H
	.word	96,44
	.long	077AFF03H
	.word	06080H
	.word	96,42
	.long	077B604BH
	.word	06080H
	.word	120,42
	.long	077BBD27H
	.word	06080H
	.word	144,72
	.long	077C2F8DH
	.word	06980H
	.word	152,79
	.long	077CFAF1H
	.word	06C80H
	.word	60,180
	.long	077DD749H
	.word	06080H
	.word	160,29
	.long	077ED199H
	.word	06480H
	.word	88,180
	.long	077F34CDH
	.word	06880H
	.word	36,55
	.long	07803835H
	.word	06080H
	.word	56,84
	.long	07805E1DH
	.word	06080H
	.word	44,76
	.long	0780C8E5H
	.word	06080H
	.word	52,69
	.long	07810CA9H
	.word	06080H
	.word	80,56
	.long	07815C6BH
	.word	06A80H
	.word	56,51
	.long	0781AC2BH
	.word	06280H
	.word	56,51
	.long	0781E83DH
	.word	06280H
	.word	188,62
	.long	0782258DH
	.word	06380H
	.word	60,51
	.long	07830103H
	.word	06280H
	.word	48,150
	.long	0783428BH
	.word	06000H
	.word	44,98
	.long	0783EB4BH
	.word	06080H
	.word	76,44
	.long	07844ED3H
	.word	06000H
	.word	52,76
	.long	07849D33H
	.word	06000H
	.word	64,89
	.long	0784F9D3H
	.word	06080H
	.word	72,51
	.long	07857DEFH
	.word	06180H
	.word	60,51
	.long	0785C8E9H
	.word	06880H
	.word	88,99
	.long	07860B55H
	.word	06280H
	.word	48,150
	.long	0786B739H
	.word	06080H
	.word	28,76
	.long	07875DA1H
	.word	06080H
	.word	104,36
	.long	07878C83H
	.word	06080H
	.word	104,39
	.long	0787E1BBH
	.word	06080H
	.word	104,38
	.long	07883E31H
	.word	06080H
	.word	108,40
	.long	078897FFH
	.word	06080H
	.word	56,54
	.long	0788F5F7H
	.word	06080H
	.word	108,40
	.long	07893B15H
	.word	06080H
	.word	108,45
	.long	078999B5H
	.word	06080H
	.word	104,41
	.long	078A03C9H
	.word	06080H
	.word	104,39
	.long	078A64EDH
	.word	06080H
	.word	232,84
	.long	078AC0FDH
	.word	06080H
	.word	104,32
	.long	078C8675H
	.word	06080H
	.word	104,40
	.long	078CD137H
	.word	06080H
	.word	100,51
	.long	078D2F29H
	.word	06000H
	.word	72,137
	.long	078DA6B1H
	.word	06180H
	.word	216,142
	.long	078E5C11H
	.word	06680H
	.word	60,90
	.long	07912565H
	.word	06080H
	.word	44,150
	.long	079192C1H
	.word	06080H
	.word	68,51
	.long	0792111BH
	.word	06080H
	.word	72,51
	.long	07925F93H
	.word	06080H
	.word	56,54
	.long	0792AD87H
	.word	06080H
	.word	72,51
	.long	0792F0F5H
	.word	06080H
	.word	36,35
	.long	079343F9H
	.word	06480H
	.word	52,51
	.long	07935345H
	.word	06280H
	.word	72,51
	.long	07938B01H
	.word	06080H
	.word	56,51
	.long	0793DF73H
	.word	06280H
	.word	64,51
	.long	07941BAFH
	.word	06280H
	.word	56,51
	.long	07946277H
	.word	06280H
	.word	40,91
	.long	0794A0BDH
	.word	06000H
	.word	36,179
	.long	0794F60DH
	.word	06080H
	.word	36,39
	.long	07958863H
	.word	06000H
	.word	44,72
	.long	0795A94BH
	.word	06180H
	.word	144,167
	.long	0795CD57H
	.word	06A80H
	.word	80,27
	.long	0796E0BFH
	.word	06380H
	.word	80,64
	.long	079703B7H
	.word	06880H
	.word	128,46
	.long	07976DD3H
	.word	06080H
	.word	112,49
	.long	0797F0D9H
	.word	06080H
	.word	68,65
	.long	07987061H
	.word	06280H
	.word	64,77
	.long	0798A6E3H
	.word	06580H
	.word	48,34
	.long	0798F5B3H
	.word	06680H
	.word	44,20
	.long	07990B7BH
	.word	06180H
	.word	44,171
	.long	07991DA3H
	.word	06080H
MKPIT4BLKS:
	.word	04041H	;flags
	.word	0,142 ;x,y
	.word	029H	;pal5,pal4,hdr13-0
	.word	04050H,13,0,02EH
	.word	04051H,226,142,029H
	.word	04040H,229,0,02EH
	.word	0FFFFH	;End Marker
MKPIT3BLKS:
	.word	04042H	;flags
	.word	0,0 ;x,y
	.word	035H	;pal5,pal4,hdr13-0
	.word	04042H,133,0,035H
	.word	0FFFFH	;End Marker
MKPIT2BLKS:
	.word	04051H	;flags
	.word	0,460 ;x,y
	.word	014H	;pal5,pal4,hdr13-0
	.word	04051H,45,310,016H
	.word	04054H,49,3,017H
	.word	04055H,50,101,018H
	.word	04055H,50,145,019H
	.word	04056H,51,221,01AH
	.word	04055H,91,2,01DH
	.word	04051H,91,310,01EH
	.word	04059H,99,145,01FH
	.word	04057H,115,173,02DH
	.word	04059H,126,83,02FH
	.word	04051H,138,310,030H
	.word	04049H,538,81,02FH
	.word	04047H,538,171,02DH
	.word	04041H,538,458,014H
	.word	04041H,543,308,030H
	.word	04045H,545,0,01DH
	.word	04041H,586,308,01EH
	.word	04045H,598,99,018H
	.word	04049H,598,143,01FH
	.word	04046H,610,219,01AH
	.word	04045H,623,143,019H
	.word	04044H,631,1,017H
	.word	04041H,632,308,016H
	.word	04046H,672,218,03BH
	.word	04044H,673,1,03CH
	.word	04045H,674,180,03DH
	.word	0FFFFH	;End Marker
MKPIT1BLKS:
	.word	0405EH	;flags
	.word	0,2258 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	0405EH,21,2202,00H
	.word	0405EH,37,2128,00H
	.word	0405EH,54,2054,00H
	.word	0405EH,71,1979,00H
	.word	0405EH,86,1906,00H
	.word	0405EH,101,1826,00H
	.word	0405EH,107,1746,00H
	.word	0405EH,111,873,00H
	.word	0405EH,111,1666,00H
	.word	0405EH,113,793,00H
	.word	0405EH,113,953,00H
	.word	0405EH,114,1592,00H
	.word	0405EH,116,1033,00H
	.word	0405EH,116,1512,00H
	.word	0405EH,117,1432,00H
	.word	0405EH,118,718,00H
	.word	0405EH,118,1352,00H
	.word	0405EH,119,639,00H
	.word	0405EH,119,1112,00H
	.word	0405EH,119,1272,00H
	.word	0405EH,122,1192,00H
	.word	0405EH,126,339,01H
	.word	0405EH,126,395,02H
	.word	0405EH,126,447,03H
	.word	0405EH,126,495,04H
	.word	0405EH,126,537,05H
	.word	0405EH,126,581,06H
	.word	0405EH,127,623,07H
	.word	0405EH,128,267,08H
	.word	04048H,129,209,09H
	.word	04048H,129,29,0AH
	.word	04048H,129,0,0BH
	.word	04048H,187,29,0CH
	.word	0405EH,219,568,0DH
	.word	0405EH,221,339,0EH
	.word	0405EH,221,492,0FH
	.word	0405EH,222,423,010H
	.word	0405AH,238,239,011H
	.word	0405AH,316,236,012H
	.word	0405AH,371,236,013H
	.word	0405AH,426,236,015H
	.word	04043H,484,287,01BH
	.word	04040H,486,236,0101CH
	.word	0404CH,499,2178,020H
	.word	0404CH,499,2214,021H
	.word	0404CH,499,2332,020H
	.word	0404CH,499,2368,021H
	.word	0404CH,499,2486,020H
	.word	0404CH,499,2522,021H
	.word	0404CH,499,2640,020H
	.word	0404CH,501,790,022H
	.word	0404CH,501,828,021H
	.word	0404CH,501,946,020H
	.word	0404CH,501,982,021H
	.word	0404CH,501,1100,020H
	.word	0404CH,501,1136,021H
	.word	0404CH,501,1254,020H
	.word	0404CH,501,1290,021H
	.word	0404CH,501,1408,020H
	.word	0404CH,501,1444,021H
	.word	0404CH,501,1562,020H
	.word	0404CH,501,1598,021H
	.word	0404CH,501,1716,020H
	.word	0404CH,501,1752,021H
	.word	0404CH,501,1870,020H
	.word	0404CH,501,1906,021H
	.word	0404CH,501,2024,020H
	.word	0404CH,501,2060,021H
	.word	0404CH,501,2292,023H
	.word	0404CH,501,2446,023H
	.word	0404CH,501,2600,023H
	.word	04043H,502,338,024H
	.word	04043H,502,392,025H
	.word	04043H,502,483,026H
	.word	0404CH,502,528,027H
	.word	0404CH,502,641,022H
	.word	0404CH,502,679,021H
	.word	0404CH,502,2138,023H
	.word	0404CH,502,2253,028H
	.word	0404CH,502,2407,028H
	.word	0404CH,502,2561,028H
	.word	0404CH,503,906,023H
	.word	0404CH,503,1060,023H
	.word	0404CH,503,1214,023H
	.word	0404CH,503,1368,023H
	.word	0404CH,503,1522,023H
	.word	0404CH,503,1676,023H
	.word	0404CH,503,1830,023H
	.word	0404CH,503,1984,023H
	.word	0404CH,503,2099,028H
	.word	0404CH,504,867,028H
	.word	0404CH,504,1021,028H
	.word	0404CH,504,1175,028H
	.word	0404CH,504,1329,028H
	.word	0404CH,504,1483,028H
	.word	0404CH,504,1637,028H
	.word	0404CH,504,1791,028H
	.word	0404CH,504,1945,028H
	.word	0404CH,505,718,02AH
	.word	0404CH,505,750,02BH
	.word	0404CH,506,569,02AH
	.word	0404CH,506,601,02BH
	.word	04043H,510,432,02CH
	.word	04040H,545,236,01031H
	.word	04043H,555,287,032H
	.word	04043H,556,338,033H
	.word	04040H,610,236,01034H
	.word	04040H,679,236,01036H
	.word	04040H,729,236,01037H
	.word	04040H,799,236,01038H
	.word	04043H,824,287,01BH
	.word	0404CH,840,1870,020H
	.word	0404CH,840,1906,021H
	.word	0404CH,840,2024,020H
	.word	0404CH,840,2060,021H
	.word	0404CH,840,2178,020H
	.word	0404CH,840,2214,021H
	.word	0404CH,840,2331,020H
	.word	0404CH,840,2367,021H
	.word	0404CH,840,2485,020H
	.word	0404CH,840,2521,021H
	.word	0404CH,840,2639,020H
	.word	0404CH,841,1100,020H
	.word	0404CH,841,1136,021H
	.word	0404CH,841,1254,020H
	.word	0404CH,841,1290,021H
	.word	0404CH,841,1408,020H
	.word	0404CH,841,1444,021H
	.word	0404CH,841,1562,020H
	.word	0404CH,841,1598,021H
	.word	0404CH,841,1716,020H
	.word	0404CH,841,1752,021H
	.word	04043H,842,338,024H
	.word	04043H,842,392,025H
	.word	0404CH,842,790,022H
	.word	0404CH,842,828,021H
	.word	0404CH,842,946,020H
	.word	0404CH,842,982,021H
	.word	0404CH,842,1984,023H
	.word	0404CH,842,2138,023H
	.word	0404CH,842,2291,023H
	.word	0404CH,842,2445,023H
	.word	0404CH,842,2599,023H
	.word	04043H,843,483,026H
	.word	0404CH,843,528,027H
	.word	0404CH,843,641,022H
	.word	0404CH,843,679,021H
	.word	0404CH,843,1060,023H
	.word	0404CH,843,1214,023H
	.word	0404CH,843,1368,023H
	.word	0404CH,843,1522,023H
	.word	0404CH,843,1676,023H
	.word	0404CH,843,1676,023H
	.word	0404CH,843,1830,023H
	.word	0404CH,843,1945,028H
	.word	0404CH,843,2099,028H
	.word	0404CH,843,2253,028H
	.word	0404CH,843,2406,028H
	.word	0404CH,843,2560,028H
	.word	0404CH,844,906,023H
	.word	0404CH,844,1021,028H
	.word	0404CH,844,1175,028H
	.word	0404CH,844,1329,028H
	.word	0404CH,844,1483,028H
	.word	0404CH,844,1637,028H
	.word	0404CH,844,1791,028H
	.word	0404CH,845,867,028H
	.word	0404CH,846,718,02AH
	.word	0404CH,846,750,02BH
	.word	0404CH,847,569,02AH
	.word	0404CH,847,601,02BH
	.word	04043H,851,432,02CH
	.word	04040H,853,236,01039H
	.word	04043H,895,287,032H
	.word	04043H,896,338,033H
	.word	04040H,916,236,0103AH
	.word	0404AH,972,236,015H
	.word	0404AH,1031,236,013H
	.word	0404AH,1086,236,012H
	.word	0404AH,1140,239,011H
	.word	0404BH,1179,192,03EH
	.word	0404EH,1182,339,0EH
	.word	0404EH,1185,423,010H
	.word	0404EH,1187,267,08H
	.word	0404FH,1188,28,03FH
	.word	0404EH,1194,492,0FH
	.word	0404EH,1200,1214,00H
	.word	0404EH,1200,1294,00H
	.word	0404EH,1200,1374,00H
	.word	0404EH,1200,1454,00H
	.word	0404EH,1200,1534,00H
	.word	0404EH,1200,1614,00H
	.word	0404EH,1200,1694,00H
	.word	0404EH,1200,1774,00H
	.word	0404EH,1203,1134,00H
	.word	0404EH,1204,568,0DH
	.word	0404EH,1206,1054,00H
	.word	0404BH,1209,257,040H
	.word	0404DH,1209,193,041H
	.word	0404EH,1209,894,00H
	.word	0404EH,1209,974,00H
	.word	0404EH,1212,623,042H
	.word	0404EH,1212,814,00H
	.word	0404EH,1213,734,00H
	.word	0404EH,1218,1848,00H
	.word	0404EH,1219,669,07H
	.word	0404EH,1226,711,043H
	.word	0404BH,1229,132,044H
	.word	0404EH,1235,1923,00H
	.word	0404EH,1237,339,01H
	.word	0404EH,1237,395,02H
	.word	0404EH,1237,447,03H
	.word	0404EH,1237,495,04H
	.word	0404EH,1237,537,05H
	.word	0404EH,1237,581,06H
	.word	0404DH,1240,55,045H
	.word	0404EH,1251,1997,00H
	.word	0404EH,1266,2070,00H
	.word	0404EH,1276,2143,00H
	.word	0404DH,1281,55,046H
	.word	0404BH,1289,268,047H
	.word	0404DH,1289,97,048H
	.word	0404EH,1292,2214,00H
	.word	0404EH,1309,2288,00H
	.word	0FFFFH	;End Marker
MKPIT4BMOD:
	.word	458,226,4	;x size, y size, #blocks
	.long	MKPIT4BLKS, RONEHDRS, RONEPALS
MKPIT3BMOD:
	.word	169,35,2	;x size, y size, #blocks
	.long	MKPIT3BLKS, RONEHDRS, RONEPALS
MKPIT2BMOD:
	.word	726,522,27	;x size, y size, #blocks
	.long	MKPIT2BLKS, RONEHDRS, RONEPALS
MKPIT1BMOD:
	.word	1445,2676,225	;x size, y size, #blocks
	.long	MKPIT1BLKS, RONEHDRS, RONEPALS

LC2HDRS:
	.word	60,114	;x size, y size
	.long	0799B3F7H	;address
	.word	06280H	;dma ctrl
	.word	76,132
	.long	079A3FBFH
	.word	06580H
	.word	72,112
	.long	079ACD13H
	.word	06880H
	.word	64,196
	.long	079B53D9H
	.word	06080H
	.word	252,18
	.long	079C76EDH
	.word	06F80H
	.word	80,201
	.long	079CD59DH
	.word	06080H
	.word	16,22
	.long	079E4B59H
	.word	06080H
	.word	76,39
	.long	079E5203H
	.word	06000H
	.word	92,89
	.long	079E977BH
	.word	06480H
	.word	132,67
	.long	079F3CAFH
	.word	06880H
	.word	40,98
	.long	079FFFB7H
	.word	06080H
	.word	40,70
	.long	07A0371DH
	.word	05580H
	.word	120,38
	.long	07A04DC5H
	.word	06880H
	.word	60,154
	.long	07A0A697H
	.word	06680H
	.word	112,16
	.long	07A13453H
	.word	06580H
	.word	80,66
	.long	07A1564BH
	.word	06A80H
	.word	60,154
	.long	07A1ACA3H
	.word	06580H
	.word	124,37
	.long	07A23AA7H
	.word	06280H
	.word	128,149
	.long	07A296D7H
	.word	06E80H
	.word	16,32
	.long	07A37DCFH
	.word	06080H
	.word	48,72
	.long	07A386CDH
	.word	06480H
	.word	64,175
	.long	07A3CB55H
	.word	06A80H
	.word	44,50
	.long	07A45725H
	.word	06280H
	.word	116,15
	.long	07A48405H
	.word	06000H
BALCONY3BLKS:
	.word	0404AH	;flags
	.word	0,0 ;x,y
	.word	0CH	;pal5,pal4,hdr13-0
	.word	04044H,62,12,0EH
	.word	0404AH,117,1,011H
	.word	0FFFFH	;End Marker
BALCONY4BLKS:
	.word	04041H	;flags
	.word	0,57 ;x,y
	.word	06H	;pal5,pal4,hdr13-0
	.word	04040H,20,3,0AH
	.word	04050H,109,3,0AH
	.word	04041H,158,50,06H
	.word	04041H,186,48,013H
	.word	04040H,201,2,0AH
	.word	04050H,293,0,0AH
	.word	04041H,328,51,06H
	.word	0FFFFH	;End Marker
BALCONY5BLKS:
	.word	04041H	;flags
	.word	0,0 ;x,y
	.word	04H	;pal5,pal4,hdr13-0
	.word	0FFFFH	;End Marker
BALCONY1BLKS:
	.word	04049H	;flags
	.word	0,161 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04448H,36,46,01H
	.word	04049H,60,154,02H
	.word	04046H,105,0,03H
	.word	04046H,167,157,07H
	.word	04043H,167,68,08H
	.word	04046H,167,1,09H
	.word	0444BH,195,134,0BH
	.word	04047H,243,44,0DH
	.word	04046H,297,1,0FH
	.word	04047H,300,44,010H
	.word	04042H,338,1,012H
	.word	04046H,357,124,014H
	.word	04047H,402,23,015H
	.word	04057H,463,1,016H
	.word	04047H,463,181,017H
	.word	04047H,507,1,016H
	.word	04057H,548,23,015H
	.word	04052H,548,1,012H
	.word	04056H,610,124,014H
	.word	04056H,637,1,0FH
	.word	04057H,655,45,010H
	.word	04057H,712,45,0DH
	.word	04056H,716,1,09H
	.word	04053H,756,68,08H
	.word	04056H,772,157,07H
	.word	0445BH,780,134,0BH
	.word	04056H,846,0,03H
	.word	04059H,863,154,02H
	.word	04458H,883,45,01H
	.word	04059H,935,161,00H
	.word	0FFFFH	;End Marker
BALCONY2BLKS:
	.word	04045H	;flags
	.word	0,0 ;x,y
	.word	05H	;pal5,pal4,hdr13-0
	.word	04055H,724,2,05H
	.word	0FFFFH	;End Marker
BALCONY3BMOD:
	.word	241,38,3	;x size, y size, #blocks
	.long	BALCONY3BLKS, LC2HDRS, LC2PALS
BALCONY4BMOD:
	.word	344,101,8	;x size, y size, #blocks
	.long	BALCONY4BLKS, LC2HDRS, LC2PALS
BALCONY5BMOD:
	.word	252,18,1	;x size, y size, #blocks
	.long	BALCONY5BLKS, LC2HDRS, LC2PALS
BALCONY1BMOD:
	.word	995,275,31	;x size, y size, #blocks
	.long	BALCONY1BLKS, LC2HDRS, LC2PALS
BALCONY2BMOD:
	.word	804,203,2	;x size, y size, #blocks
	.long	BALCONY2BLKS, LC2HDRS, LC2PALS

DDENHDRS:
	.word	204,82	;x size, y size
	.long	07A4ACCDH	;address
	.word	06080H	;dma ctrl
	.word	120,174
	.long	07A631A9H
	.word	06000H
	.word	28,63
	.long	07A81B09H
	.word	06080H
	.word	120,51
	.long	07A82D75H
	.word	06000H
	.word	16,25
	.long	07A8BCE5H
	.word	06080H
	.word	76,147
	.long	07A8C39BH
	.word	06480H
	.word	148,27
	.long	07A9BE93H
	.word	05000H
	.word	32,47
	.long	07AA0C9FH
	.word	06480H
	.word	76,147
	.long	07AA1AD1H
	.word	06180H
	.word	204,82
	.long	07AB1545H
	.word	06080H
	.word	44,83
	.long	07AC9C0DH
	.word	06180H
	.word	140,174
	.long	07ACC299H
	.word	06080H
	.word	64,108
	.long	07AEFAD1H
	.word	06580H
HIDDEN1BLKS:
	.word	04044H	;flags
	.word	0,0 ;x,y
	.word	03H	;pal5,pal4,hdr13-0
	.word	04054H,118,0,03H
	.word	04044H,238,0,03H
	.word	04054H,356,0,03H
	.word	04044H,476,0,03H
	.word	04054H,594,0,03H
	.word	04044H,714,0,03H
	.word	04054H,832,0,03H
	.word	04044H,952,0,03H
	.word	04054H,1070,0,03H
	.word	04044H,1190,0,03H
	.word	0FFFFH	;End Marker
HIDDEN2BLKS:
	.word	04041H	;flags
	.word	0,174 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04042H,0,0,01H
	.word	04143H,2,166,02H
	.word	04143H,104,196,04H
	.word	04040H,120,27,05H
	.word	04042H,120,0,06H
	.word	04143H,125,178,07H
	.word	04040H,194,27,08H
	.word	04041H,201,174,09H
	.word	04143H,234,153,0AH
	.word	04042H,268,0,0BH
	.word	04143H,347,134,0CH
	.word	0FFFFH	;End Marker
HIDDEN1BMOD:
	.word	1310,51,11	;x size, y size, #blocks
	.long	HIDDEN1BLKS, DDENHDRS, DDENPALS
HIDDEN2BMOD:
	.word	411,256,12	;x size, y size, #blocks
	.long	HIDDEN2BLKS, DDENHDRS, DDENPALS

AO1HDRS:
	.word	76,97	;x size, y size
	.long	07038EB6H	;address
	.word	06980H	;dma ctrl
	.word	188,63
	.long	07055A96H
	.word	06C80H
	.word	188,65
	.long	07043C2EH
	.word	06000H
	.word	80,69
	.long	07064E50H
	.word	06880H
	.word	76,82
	.long	070747A6H
	.word	06580H
	.word	160,60
	.long	0707B80AH
	.word	06080H
	.word	124,94
	.long	07AF3815H
	.word	06A80H
	.word	212,49
	.long	0709779AH
	.word	06000H
	.word	212,56
	.long	070A6B12H
	.word	06000H
	.word	108,55
	.long	070B8152H
	.word	06880H
	.word	60,169
	.long	070BFAA4H
	.word	06580H
TEXT1BLKS:
	.word	04140H	;flags
	.word	0,72 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04042H,25,41,01H
	.word	04041H,25,104,02H
	.word	04140H,69,100,03H
	.word	04244H,78,87,04H
	.word	04146H,154,109,05H
	.word	04145H,171,15,06H
	.word	04041H,212,120,07H
	.word	04043H,212,64,08H
	.word	04247H,236,114,09H
	.word	04148H,345,0,0AH
	.word	0FFFFH	;End Marker
TEXT1BMOD:
	.word	424,169,11	;x size, y size, #blocks
	.long	TEXT1BLKS, AO1HDRS, AO1PALS

AO2HDRS:
	.word	76,97	;x size, y size
	.long	07038EB6H	;address
	.word	06980H	;dma ctrl
	.word	188,63
	.long	07055A96H
	.word	06C80H
	.word	188,65
	.long	07043C2EH
	.word	06000H
	.word	80,69
	.long	07064E50H
	.word	06880H
	.word	76,82
	.long	070747A6H
	.word	06580H
	.word	212,49
	.long	0709779AH
	.word	06000H
	.word	212,56
	.long	070A6B12H
	.word	06000H
	.word	108,55
	.long	070B8152H
	.word	06880H
	.word	60,169
	.long	070BFAA4H
	.word	06580H
TEXT2BLKS:
	.word	04140H	;flags
	.word	0,72 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04042H,25,41,01H
	.word	04041H,25,104,02H
	.word	04140H,69,100,03H
	.word	04244H,78,87,04H
	.word	04041H,212,120,05H
	.word	04043H,212,64,06H
	.word	04246H,236,114,07H
	.word	04145H,345,0,08H
	.word	0FFFFH	;End Marker
TEXT2BMOD:
	.word	424,169,9	;x size, y size, #blocks
	.long	TEXT2BLKS, AO2HDRS, AO2PALS

XTHDRS:
	.word	76,97	;x size, y size
	.long	07038EB6H	;address
	.word	06980H	;dma ctrl
	.word	188,63
	.long	07055A96H
	.word	06C80H
	.word	188,65
	.long	07043C2EH
	.word	06000H
	.word	80,69
	.long	07064E50H
	.word	06880H
	.word	76,82
	.long	070747A6H
	.word	06580H
	.word	160,60
	.long	0707B80AH
	.word	06080H
	.word	124,108
	.long	0708AB6AH
	.word	06A80H
	.word	212,49
	.long	0709779AH
	.word	06000H
	.word	212,56
	.long	070A6B12H
	.word	06000H
	.word	108,55
	.long	070B8152H
	.word	06880H
	.word	60,169
	.long	070BFAA4H
	.word	06580H
TEXTBLKS:
	.word	0414CH	;flags
	.word	0,72 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	0404AH,25,41,01H
	.word	0404BH,25,104,02H
	.word	0414CH,69,100,03H
	.word	04244H,78,87,04H
	.word	04146H,154,109,05H
	.word	04145H,172,1,06H
	.word	0404BH,212,120,07H
	.word	04049H,212,64,08H
	.word	04247H,236,114,09H
	.word	04148H,345,0,0AH
	.word	0FFFFH	;End Marker
TEXTBMOD:
	.word	424,169,11	;x size, y size, #blocks
	.long	TEXTBLKS, XTHDRS, XTPALS

dderHDRS:
	.word	204,82	;x size, y size
	.long	07A4ACCDH	;address
	.word	06080H	;dma ctrl
	.word	120,174
	.long	07A631A9H
	.word	06000H
	.word	28,63
	.long	07A81B09H
	.word	06080H
	.word	16,25
	.long	07A8BCE5H
	.word	06080H
	.word	76,147
	.long	07A8C39BH
	.word	06480H
	.word	148,27
	.long	07A9BE93H
	.word	05000H
	.word	32,47
	.long	07AA0C9FH
	.word	06480H
	.word	76,147
	.long	07AA1AD1H
	.word	06180H
	.word	204,82
	.long	07AB1545H
	.word	06080H
	.word	44,83
	.long	07AC9C0DH
	.word	06180H
	.word	140,174
	.long	07ACC299H
	.word	06080H
	.word	64,108
	.long	07AEFAD1H
	.word	06580H
LADDERBLKS:
	.word	04041H	;flags
	.word	0,174 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04042H,0,0,01H
	.word	04143H,2,166,02H
	.word	04143H,104,196,03H
	.word	04040H,120,27,04H
	.word	04042H,120,0,05H
	.word	04143H,125,178,06H
	.word	04040H,194,27,07H
	.word	04041H,201,174,08H
	.word	04143H,234,153,09H
	.word	04042H,268,0,0AH
	.word	04143H,347,134,0BH
	.word	0FFFFH	;End Marker
LADDERBMOD:
	.word	411,256,12	;x size, y size, #blocks
	.long	LADDERBLKS, dderHDRS, dderPALS

LECTHDRS:
	.word	200,128	;x size, y size
	.long	07AFF75DH	;address
	.word	06C80H	;dma ctrl
	.word	200,128
	.long	07B15C9DH
	.word	06C80H
	.word	32,195
	.long	07B2AF7DH
	.word	06480H
	.word	52,195
	.long	07B2EBB9H
	.word	06580H
	.word	56,195
	.long	07B3313DH
	.word	06580H
	.word	56,195
	.long	07B37799H
	.word	06580H
	.word	200,128
	.long	07B3BDF5H
	.word	06380H
	.word	200,128
	.long	07B51195H
	.word	06380H
	.word	52,195
	.long	07B65185H
	.word	06580H
	.word	32,195
	.long	07B69709H
	.word	06180H
MKSELECTBLKS:
	.word	04040H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04042H,0,128,01H
	.word	04044H,65,34,02H
	.word	04044H,94,34,03H
	.word	04044H,145,34,04H
	.word	04044H,198,34,05H
	.word	04041H,200,0,06H
	.word	04043H,200,128,07H
	.word	04044H,252,34,08H
	.word	04044H,304,34,09H
	.word	0FFFFH	;End Marker
MKSELECTBMOD:
	.word	400,256,10	;x size, y size, #blocks
	.long	MKSELECTBLKS, LECTHDRS, LECTPALS

LVSHDRS:
	.word	204,130	;x size, y size
	.long	07B6D6FFH	;address
	.word	04000H	;dma ctrl
	.word	204,117
	.long	07B8755FH
	.word	04380H
STEELMODBLKS:
	.word	04040H	;flags
	.word	0,117 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,0,01H
	.word	04050H,202,0,01H
	.word	04050H,202,117,00H
	.word	0FFFFH	;End Marker
STEELMODBMOD:
	.word	406,247,4	;x size, y size, #blocks
	.long	STEELMODBLKS, LVSHDRS, LVSPALS

yinHDRS:
	.word	100,141	;x size, y size
	.long	07B99D6BH	;address
	.word	05580H	;dma ctrl
	.word	24,5
	.long	07BA9DEFH
	.word	05080H
	.word	48,142
	.long	07BA9FC5H
	.word	05480H
	.word	72,29
	.long	07BB1EE7H
	.word	03980H
	.word	88,29
	.long	07BB2653H
	.word	05A80H
	.word	104,141
	.long	07BB32B7H
	.word	05580H
	.word	68,29
	.long	07BC3881H
	.word	03680H
	.word	100,141
	.long	07BC3EEBH
	.word	05580H
	.word	68,29
	.long	07BD3ED9H
	.word	05680H
	.word	100,141
	.long	07BD490DH
	.word	05580H
	.word	52,29
	.long	07BE48B5H
	.word	04580H
	.word	104,141
	.long	07BE4FBDH
	.word	05580H
	.word	64,29
	.long	07BF5519H
	.word	05980H
	.word	48,29
	.long	07BF5E7BH
	.word	04580H
	.word	48,29
	.long	07BF6543H
	.word	04580H
	.word	100,141
	.long	07BF6BFBH
	.word	05580H
	.word	84,29
	.long	07C06C2FH
	.word	05A80H
	.word	52,29
	.long	07C078A7H
	.word	04580H
	.word	100,141
	.long	07C07F9FH
	.word	05580H
	.word	56,29
	.long	07C1800FH
	.word	04980H
	.word	52,141
	.long	07C18857H
	.word	05180H
	.word	20,5
	.long	07C20DACH
	.word	04080H
buyinbotBLKS:
	.word	04040H	;flags
	.word	0,4 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	06440H,0,24,01H
	.word	04040H,36,0,04H
	.word	04040H,99,4,07H
	.word	04040H,134,0,08H
	.word	04040H,199,4,0BH
	.word	04040H,202,0,0CH
	.word	04040H,281,1,010H
	.word	04040H,300,4,012H
	.word	04040H,381,24,015H
	.word	0FFFFH	;End Marker
buyintopBLKS:
	.word	04040H	;flags
	.word	0,0 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	06440H,1,116,03H
	.word	04040H,48,0,05H
	.word	06440H,86,116,06H
	.word	04040H,150,0,09H
	.word	06440H,152,116,0AH
	.word	06440H,202,116,0DH
	.word	06440H,249,116,0EH
	.word	04040H,249,0,0FH
	.word	06440H,296,116,011H
	.word	06440H,345,116,013H
	.word	04040H,349,0,014H
	.word	0FFFFH	;End Marker
buyinbotBMOD:
	.word	401,145,10	;x size, y size, #blocks
	.long	buyinbotBLKS, yinHDRS, yinPALS
buyintopBMOD:
	.word	401,145,12	;x size, y size, #blocks
	.long	buyintopBLKS, yinHDRS, yinPALS

oinHDRS:
	.word	128,128	;x size, y size
	.long	07C20F00H	;address
	.word	05000H	;dma ctrl
	.word	156,46
	.long	07C34F00H
	.word	06380H
	.word	176,53
	.long	07C3E394H
	.word	05B80H
	.word	212,57
	.long	07C45BACH
	.word	06C80H
	.word	196,59
	.long	07C5480AH
	.word	05E80H
coinmodBLKS:
	.word	04040H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,128,00H
	.word	04641H,86,32,01H
	.word	04540H,88,37,02H
	.word	04040H,128,128,00H
	.word	04040H,128,0,00H
	.word	04641H,240,28,03H
	.word	04040H,256,128,00H
	.word	04040H,256,0,00H
	.word	04540H,262,31,04H
	.word	04040H,384,0,00H
	.word	04040H,384,128,00H
	.word	0FFFFH	;End Marker
coinmodBMOD:
	.word	512,256,12	;x size, y size, #blocks
	.long	coinmodBLKS, oinHDRS, oinPALS

IOHDRS:
	.word	120,11	;x size, y size
	.long	07C5EA1EH	;address
	.word	04000H	;dma ctrl
	.word	64,64
	.long	07C5FEBEH
	.word	05280H
	.word	64,64
	.long	07C612CAH
	.word	05280H
	.word	120,11
	.long	07C626D6H
	.word	04000H
	.word	4,60
	.long	07C63B76H
	.word	05000H
	.word	64,64
	.long	07C64026H
	.word	05000H
	.word	64,3
	.long	07C69026H
	.word	04000H
	.word	64,3
	.long	07C69326H
	.word	05000H
	.word	64,64
	.long	07C696E6H
	.word	05880H
	.word	64,64
	.long	07C6AAF2H
	.word	05880H
	.word	4,54
	.long	07C6BEFEH
	.word	05000H
BIOMODBLKS:
	.word	04041H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04070H,0,11,01H
	.word	04070H,0,177,02H
	.word	04041H,0,241,03H
	.word	04040H,0,75,04H
	.word	04040H,0,127,04H
	.word	04040H,4,14,05H
	.word	04040H,4,78,05H
	.word	04040H,4,142,05H
	.word	04040H,4,174,05H
	.word	04040H,64,11,06H
	.word	04060H,64,238,07H
	.word	04040H,68,14,05H
	.word	04040H,68,78,05H
	.word	04040H,68,142,05H
	.word	04040H,68,174,05H
	.word	04040H,128,11,06H
	.word	04060H,128,238,07H
	.word	04040H,132,14,05H
	.word	04040H,132,78,05H
	.word	04040H,132,142,05H
	.word	04040H,132,174,05H
	.word	04040H,188,14,05H
	.word	04040H,188,78,05H
	.word	04040H,188,142,05H
	.word	04040H,188,174,05H
	.word	04070H,192,11,08H
	.word	04070H,192,177,09H
	.word	04040H,252,75,0AH
	.word	04040H,252,129,0AH
	.word	0FFFFH	;End Marker
BIOMODBMOD:
	.word	256,252,30	;x size, y size, #blocks
	.long	BIOMODBLKS, IOHDRS, IOPALS

NDHDRS:
	.word	64,64	;x size, y size
	.long	07C64026H	;address
	.word	05000H	;dma ctrl
	.word	40,3
	.long	07C6C336H
	.word	05000H
	.word	4,31
	.long	07C6C58EH
	.word	05000H
	.word	64,64
	.long	07C5FEBEH
	.word	05280H
	.word	64,64
	.long	07C612CAH
	.word	05280H
	.word	4,14
	.long	07C6C7FAH
	.word	04000H
	.word	64,3
	.long	07C69026H
	.word	04000H
	.word	64,3
	.long	07C69326H
	.word	05000H
	.word	8,4
	.long	07C6C8DAH
	.word	05000H
	.word	8,4
	.long	07C6C97AH
	.word	04000H
	.word	64,64
	.long	07C696E6H
	.word	05880H
	.word	64,64
	.long	07C6AAF2H
	.word	05880H
	.word	4,12
	.long	07C6C9FAH
	.word	05000H
ENDMODBLKS:
	.word	04040H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,1,256,00H
	.word	04040H,1,64,00H
	.word	04040H,1,128,00H
	.word	04040H,1,192,00H
	.word	04640H,1,136,01H
	.word	04640H,1,114,01H
	.word	04640H,17,136,01H
	.word	04640H,17,114,01H
	.word	04640H,55,59,02H
	.word	04640H,55,90,02H
	.word	04640H,55,121,02H
	.word	04640H,55,152,02H
	.word	04640H,55,176,02H
	.word	04640H,56,204,01H
	.word	04640H,57,56,01H
	.word	04040H,64,0,00H
	.word	04040H,64,198,00H
	.word	04040H,65,262,00H
	.word	04070H,65,64,03H
	.word	04370H,65,134,04H
	.word	04040H,65,124,05H
	.word	04640H,95,204,01H
	.word	04640H,96,56,01H
	.word	04040H,128,64,06H
	.word	04060H,128,195,07H
	.word	04040H,128,0,00H
	.word	04040H,128,198,00H
	.word	04040H,129,262,00H
	.word	04640H,134,204,01H
	.word	04640H,136,56,01H
	.word	04640H,173,204,01H
	.word	04640H,175,56,01H
	.word	04040H,192,64,06H
	.word	04060H,192,195,07H
	.word	04040H,192,0,00H
	.word	04040H,192,198,00H
	.word	04040H,193,262,00H
	.word	04640H,212,204,01H
	.word	04640H,214,56,01H
	.word	04640H,251,204,01H
	.word	04640H,253,56,01H
	.word	04040H,255,195,08H
	.word	04040H,255,63,09H
	.word	04040H,256,0,00H
	.word	04040H,256,198,00H
	.word	04040H,257,262,00H
	.word	04070H,259,64,0AH
	.word	04370H,259,134,0BH
	.word	04040H,279,262,00H
	.word	04040H,279,198,00H
	.word	04640H,289,204,01H
	.word	04640H,290,56,01H
	.word	04040H,304,0,00H
	.word	04040H,319,128,0CH
	.word	04040H,322,192,00H
	.word	04040H,323,64,00H
	.word	04040H,323,128,00H
	.word	04040H,325,0,00H
	.word	04040H,325,256,00H
	.word	04640H,328,58,02H
	.word	04640H,328,89,02H
	.word	04640H,328,120,02H
	.word	04640H,328,151,02H
	.word	04640H,328,174,02H
	.word	04640H,330,114,01H
	.word	04640H,331,136,01H
	.word	04640H,369,114,01H
	.word	04640H,370,136,01H
	.word	04040H,386,192,00H
	.word	04040H,387,64,00H
	.word	04040H,387,128,00H
	.word	04040H,387,0,00H
	.word	0FFFFH	;End Marker
ENDMODBMOD:
	.word	451,326,73	;x size, y size, #blocks
	.long	ENDMODBLKS, NDHDRS, NDPALS

BOXHDRS:
	.word	64,64	;x size, y size
	.long	07C6CAEAH	;address
	.word	05000H	;dma ctrl
	.word	64,3
	.long	07C69326H
	.word	05000H
	.word	64,3
	.long	07C69026H
	.word	04000H
WIDEMODBLKS:
	.word	04040H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,64,01H
	.word	04040H,1,196,02H
	.word	04040H,1,199,00H
	.word	04040H,1,263,00H
	.word	04040H,64,0,00H
	.word	04040H,64,64,01H
	.word	04040H,65,196,02H
	.word	04050H,65,199,00H
	.word	04040H,65,263,00H
	.word	04040H,128,0,00H
	.word	04040H,128,64,01H
	.word	04040H,129,196,02H
	.word	04050H,129,199,00H
	.word	04050H,129,263,00H
	.word	04040H,192,0,00H
	.word	04040H,192,64,01H
	.word	04040H,193,196,02H
	.word	04050H,193,199,00H
	.word	04040H,193,263,00H
	.word	04040H,256,0,00H
	.word	04040H,256,64,01H
	.word	04040H,257,196,02H
	.word	04050H,257,199,00H
	.word	04040H,257,263,00H
	.word	04040H,320,0,00H
	.word	04040H,320,64,01H
	.word	04040H,321,196,02H
	.word	04050H,321,199,00H
	.word	04040H,321,263,00H
	.word	04040H,384,0,00H
	.word	04040H,384,64,01H
	.word	04040H,385,199,00H
	.word	04040H,385,196,02H
	.word	04040H,385,263,00H
	.word	0FFFFH	;End Marker
WIDEMODBMOD:
	.word	449,327,35	;x size, y size, #blocks
	.long	WIDEMODBLKS, BOXHDRS, BOXPALS
