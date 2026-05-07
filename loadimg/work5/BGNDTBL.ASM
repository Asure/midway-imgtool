	.OPTION	B,D,L,T
	.include	"BGNDTBL.GLO"
	.DATA

OLHDRS:
	.word	92,56	;x size, y size
	.long	036BE5BBH	;address
	.word	05A80H	;dma ctrl
	.word	28,186
	.long	036C09B3H
	.word	06080H
	.word	28,169
	.long	036C7C7FH
	.word	06080H
	.word	36,32
	.long	036CDCB1H
	.word	06580H
	.word	120,81
	.long	036CE891H
	.word	06180H
	.word	40,209
	.long	036DC361H
	.word	05480H
	.word	80,58
	.long	036E58EBH
	.word	06D80H
	.word	52,78
	.long	036EAC9FH
	.word	05580H
	.word	56,13
	.long	036ECB1BH
	.word	06000H
	.word	80,173
	.long	036EDC2BH
	.word	06480H
	.word	96,43
	.long	0370206BH
	.word	06080H
	.word	96,13
	.long	0370807FH
	.word	06080H
	.word	32,50
	.long	03709D8BH
	.word	05580H
	.word	244,33
	.long	0370A8DFH
	.word	06080H
	.word	52,232
	.long	03716513H
	.word	06000H
	.word	24,57
	.long	03727FD3H
	.word	05180H
	.word	140,47
	.long	03728F1AH
	.word	06080H
	.word	140,44
	.long	03732896H
	.word	06480H
	.word	12,81
	.long	0373B6A2H
	.word	05080H
	.word	36,30
	.long	0373C8FCH
	.word	06580H
	.word	4,13
	.long	0373D0F4H
	.word	06000H
	.word	48,100
	.long	0373D22CH
	.word	06A80H
	.word	48,104
	.long	037427E4H
	.word	06880H
	.word	48,103
	.long	0374823CH
	.word	06180H
	.word	48,103
	.long	0374E0CAH
	.word	06280H
	.word	48,100
	.long	03753AD2H
	.word	06280H
	.word	16,36
	.long	03758E38H
	.word	05080H
	.word	8,78
	.long	03759674H
	.word	05000H
	.word	56,223
	.long	0375A2A4H
	.word	06080H
	.word	16,30
	.long	0376C3D8H
	.word	06080H
	.word	8,21
	.long	0376CBD0H
	.word	05000H
	.word	4,70
	.long	0376CF18H
	.word	05000H
	.word	56,232
	.long	0376D490H
	.word	06A80H
	.word	144,47
	.long	03780338H
	.word	06000H
	.word	144,46
	.long	0378A1D8H
	.word	06280H
	.word	8,30
	.long	03793AECH
	.word	06000H
	.word	100,34
	.long	0379408CH
	.word	06180H
	.word	68,168
	.long	03798D80H
	.word	06000H
	.word	68,65
	.long	037A9940H
	.word	06080H
	.word	56,30
	.long	037AFFC8H
	.word	05680H
	.word	96,33
	.long	037B0C3EH
	.word	06000H
	.word	36,43
	.long	037B567EH
	.word	05580H
	.word	24,92
	.long	037B61CCH
	.word	05080H
DPUL6BLKS:
	.word	04044H	;flags
	.word	0,125 ;x,y
	.word	010H	;pal5,pal4,hdr13-0
	.word	04046H,0,81,011H
	.word	04045H,191,134,021H
	.word	04046H,191,88,022H
	.word	04066H,191,46,022H
	.word	04046H,191,0,022H
	.word	04044H,476,134,010H
	.word	04046H,476,90,011H
	.word	04066H,476,50,011H
	.word	04046H,476,6,011H
	.word	04045H,658,125,021H
	.word	04046H,658,79,022H
	.word	0FFFFH	;End Marker
DPUL1BLKS:
	.word	04740H	;flags
	.word	0,78 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04740H,74,0,07H
	.word	04740H,1063,0,02AH
	.word	04740H,1063,92,02AH
	.word	04740H,1064,184,02AH
	.word	04740H,1065,276,02AH
	.word	04740H,1065,368,02AH
	.word	04740H,1405,0,02AH
	.word	04740H,1406,92,02AH
	.word	04740H,1407,184,02AH
	.word	04740H,1408,276,02AH
	.word	04740H,1409,368,02AH
	.word	04750H,2238,0,07H
	.word	04750H,2272,78,00H
	.word	0FFFFH	;End Marker
DPUL2BLKS:
	.word	04540H	;flags
	.word	0,81 ;x,y
	.word	0FH	;pal5,pal4,hdr13-0
	.word	04540H,11,0,012H
	.word	04540H,122,37,012H
	.word	04540H,122,117,012H
	.word	04540H,122,197,012H
	.word	04540H,123,277,012H
	.word	04540H,124,357,012H
	.word	04650H,227,38,027H
	.word	04640H,283,38,027H
	.word	04650H,355,37,029H
	.word	04650H,378,80,027H
	.word	04550H,432,118,0FH
	.word	04540H,433,37,012H
	.word	04640H,434,80,027H
	.word	04640H,476,38,029H
	.word	04540H,546,37,012H
	.word	04540H,546,117,012H
	.word	04540H,546,197,012H
	.word	04540H,546,277,012H
	.word	04540H,546,357,012H
	.word	04650H,592,38,027H
	.word	04640H,648,38,027H
	.word	04550H,735,118,0FH
	.word	04540H,737,37,012H
	.word	04540H,855,37,012H
	.word	04540H,856,117,012H
	.word	04540H,857,197,012H
	.word	04540H,858,277,012H
	.word	04540H,859,357,012H
	.word	04540H,998,118,0FH
	.word	04540H,1009,37,012H
	.word	04650H,1071,38,029H
	.word	04650H,1093,81,027H
	.word	04640H,1149,81,027H
	.word	04640H,1191,38,029H
	.word	04540H,1312,92,0FH
	.word	04540H,1323,11,012H
	.word	04650H,1373,38,027H
	.word	04640H,1429,38,027H
	.word	04550H,1560,81,0FH
	.word	04540H,1561,0,012H
	.word	04540H,1722,37,012H
	.word	04540H,1723,117,012H
	.word	04540H,1724,197,012H
	.word	04540H,1725,277,012H
	.word	04540H,1726,357,012H
	.word	0FFFFH	;End Marker
DPUL3BLKS:
	.word	04440H	;flags
	.word	0,104 ;x,y
	.word	01AH	;pal5,pal4,hdr13-0
	.word	04440H,6,26,01BH
	.word	04450H,101,86,01AH
	.word	04440H,104,8,01BH
	.word	04440H,271,182,01AH
	.word	04440H,278,26,01BH
	.word	04440H,278,104,01BH
	.word	04440H,390,79,01AH
	.word	04440H,397,1,01BH
	.word	04440H,535,104,01AH
	.word	04440H,541,26,01BH
	.word	04440H,750,80,01AH
	.word	04440H,757,2,01BH
	.word	04450H,863,98,01AH
	.word	04440H,866,20,01BH
	.word	04440H,1012,104,01AH
	.word	04440H,1019,26,01BH
	.word	04440H,1177,94,01AH
	.word	04440H,1184,16,01BH
	.word	0FFFFH	;End Marker
DPUL4BLKS:
	.word	04340H	;flags
	.word	0,154 ;x,y
	.word	01EH	;pal5,pal4,hdr13-0
	.word	04340H,4,14,01FH
	.word	04340H,4,84,01FH
	.word	04340H,187,84,01EH
	.word	04340H,191,14,01FH
	.word	04340H,302,72,01EH
	.word	04340H,306,2,01FH
	.word	04340H,447,154,01EH
	.word	04340H,451,14,01FH
	.word	04340H,451,84,01FH
	.word	04340H,696,84,01EH
	.word	04340H,700,14,01FH
	.word	04340H,849,154,01EH
	.word	04340H,853,14,01FH
	.word	04340H,853,84,01FH
	.word	04340H,1003,71,01EH
	.word	04340H,1007,1,01FH
	.word	04340H,1108,160,01EH
	.word	04340H,1112,20,01FH
	.word	04340H,1112,90,01FH
	.word	0FFFFH	;End Marker
DPUL5BLKS:
	.word	04042H	;flags
	.word	0,36 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	04042H,0,222,02H
	.word	04043H,12,336,03H
	.word	04042H,25,36,04H
	.word	04040H,25,99,05H
	.word	04042H,25,290,06H
	.word	04043H,46,335,08H
	.word	04042H,63,117,09H
	.word	04042H,102,292,0AH
	.word	04043H,102,335,0BH
	.word	04240H,122,111,0CH
	.word	04240H,131,153,0CH
	.word	03F43H,141,259,0DH
	.word	04052H,143,36,0EH
	.word	04240H,152,61,0CH
	.word	04240H,160,104,0CH
	.word	04240H,182,11,0CH
	.word	04172H,190,292,013H
	.word	04240H,190,54,0CH
	.word	04142H,194,322,014H
	.word	04042H,195,159,015H
	.word	04042H,195,36,016H
	.word	04041H,195,98,017H
	.word	04042H,196,292,0AH
	.word	04043H,196,335,0BH
	.word	04240H,220,4,0CH
	.word	04042H,240,36,018H
	.word	04051H,240,98,017H
	.word	04042H,241,159,019H
	.word	04052H,286,36,01CH
	.word	04142H,288,292,01DH
	.word	04142H,289,322,014H
	.word	04042H,290,292,0AH
	.word	04043H,290,335,0BH
	.word	04052H,342,36,020H
	.word	04142H,382,322,014H
	.word	04242H,382,292,023H
	.word	03F43H,382,258,024H
	.word	04042H,384,292,0AH
	.word	04043H,384,335,0BH
	.word	04341H,396,35,025H
	.word	04042H,398,203,026H
	.word	04042H,464,36,020H
	.word	04042H,478,292,0AH
	.word	04043H,478,335,0BH
	.word	04043H,480,259,028H
	.word	04042H,520,36,01CH
	.word	04042H,572,292,0AH
	.word	04043H,572,335,0BH
	.word	04042H,574,36,01CH
	.word	04043H,575,259,028H
	.word	04052H,628,36,020H
	.word	04042H,666,292,0AH
	.word	03F43H,666,258,024H
	.word	04043H,666,335,0BH
	.word	04341H,683,35,025H
	.word	04042H,684,203,026H
	.word	04042H,750,36,020H
	.word	04152H,754,292,023H
	.word	04152H,758,322,014H
	.word	03F53H,759,259,0DH
	.word	04042H,760,292,0AH
	.word	04043H,760,335,0BH
	.word	04042H,806,36,01CH
	.word	04152H,840,292,01DH
	.word	04152H,851,322,014H
	.word	04042H,854,159,015H
	.word	04042H,854,36,016H
	.word	04042H,854,292,0AH
	.word	04043H,854,335,0BH
	.word	04141H,855,98,017H
	.word	04250H,891,5,0CH
	.word	04151H,901,98,017H
	.word	04042H,901,36,018H
	.word	04042H,902,159,019H
	.word	04152H,915,292,013H
	.word	04250H,921,55,0CH
	.word	04250H,931,11,0CH
	.word	04152H,946,322,014H
	.word	04042H,948,292,0AH
	.word	04043H,948,335,0BH
	.word	04042H,949,36,0EH
	.word	04250H,951,105,0CH
	.word	04250H,960,60,0CH
	.word	04250H,981,155,0CH
	.word	04250H,990,110,0CH
	.word	04052H,999,36,04H
	.word	04052H,1001,117,09H
	.word	04052H,1039,290,06H
	.word	04053H,1042,335,08H
	.word	04050H,1079,99,05H
	.word	04053H,1096,336,03H
	.word	04052H,1116,222,02H
	.word	04052H,1116,36,01H
	.word	0FFFFH	;End Marker
DPUL6BMOD:
	.word	802,181,12	;x size, y size, #blocks
	.long	DPUL6BLKS, OLHDRS, OLPALS
DPUL1BMOD:
	.word	2364,460,14	;x size, y size, #blocks
	.long	DPUL1BLKS, OLHDRS, OLPALS
DPUL2BMOD:
	.word	1738,438,46	;x size, y size, #blocks
	.long	DPUL2BLKS, OLHDRS, OLPALS
DPUL3BMOD:
	.word	1193,217,19	;x size, y size, #blocks
	.long	DPUL3BLKS, OLHDRS, OLPALS
DPUL4BMOD:
	.word	1116,180,20	;x size, y size, #blocks
	.long	DPUL4BLKS, OLHDRS, OLPALS
DPUL5BMOD:
	.word	1144,387,94	;x size, y size, #blocks
	.long	DPUL5BLKS, OLHDRS, OLPALS
HDRS:
	.word	56,32
	.long	037B84E1H
	.word	06580H
	.word	140,44
	.long	03732896H
	.word	06480H
	.word	140,47
	.long	03728F1AH
	.word	06080H
	.word	32,21
	.long	037B9B05H
	.word	06000H
	.word	72,26
	.long	037BAAC5H
	.word	06080H
	.word	48,32
	.long	037BD325H
	.word	06180H
	.word	48,54
	.long	037BEDC3H
	.word	06580H
	.word	60,32
	.long	037C0473H
	.word	06080H
	.word	24,45
	.long	037C2AF9H
	.word	06180H
	.word	40,58
	.long	037C3BA3H
	.word	06880H
	.word	44,78
	.long	037C6E93H
	.word	06080H
	.word	40,55
	.long	037C9FCBH
	.word	06080H
	.word	144,46
	.long	0378A1D8H
	.word	06280H
	.word	144,47
	.long	03780338H
	.word	06000H
	.word	44,50
	.long	037CD267H
	.word	06080H
	.word	36,58
	.long	037D0403H
	.word	06180H
	.word	56,73
	.long	037D2F8BH
	.word	06480H
	.word	28,4
	.long	037D83DBH
	.word	06000H
	.word	20,65
	.long	037D867BH
	.word	06480H
	.word	36,34
	.long	037D9DBFH
	.word	06080H
	.word	20,65
	.long	037DB4BFH
	.word	06180H
	.word	12,7
	.long	037DCD89H
	.word	04000H
TMOD2BLKS:
	.word	04040H	;flags
	.word	0,4 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,55,4,00H
	.word	04040H,110,4,00H
	.word	04040H,165,4,00H
	.word	04040H,220,4,00H
	.word	04040H,275,4,00H
	.word	04040H,330,4,00H
	.word	04040H,385,4,00H
	.word	04040H,440,4,00H
	.word	04040H,495,4,00H
	.word	04040H,550,4,00H
	.word	04040H,605,4,00H
	.word	04040H,660,4,00H
	.word	04040H,715,4,00H
	.word	04040H,770,4,00H
	.word	04040H,825,4,00H
	.word	04040H,880,4,00H
	.word	04040H,935,4,00H
	.word	04040H,990,4,00H
	.word	04040H,1045,4,00H
	.word	04040H,1100,4,00H
	.word	04040H,1155,4,00H
	.word	04040H,1210,4,00H
	.word	04040H,1265,4,00H
	.word	04040H,1320,4,00H
	.word	04040H,1375,4,00H
	.word	04040H,1430,4,00H
	.word	04040H,1485,4,00H
	.word	04040H,1540,4,00H
	.word	04040H,1595,4,00H
	.word	04040H,1650,4,00H
	.word	04040H,1705,4,00H
	.word	04040H,1760,4,00H
	.word	04040H,1815,4,00H
	.word	04040H,1870,4,00H
	.word	04040H,1925,4,00H
	.word	04040H,1980,4,00H
	.word	0FFFFH	;End Marker
TMOD1BLKS:
	.word	04253H	;flags
	.word	0,24 ;x,y
	.word	04H	;pal5,pal4,hdr13-0
	.word	04344H,1,5,05H
	.word	04243H,32,24,06H
	.word	04243H,55,56,07H
	.word	04242H,62,24,08H
	.word	04344H,71,5,05H
	.word	04242H,78,56,09H
	.word	04042H,94,182,0AH
	.word	04240H,99,108,0BH
	.word	04241H,101,56,0CH
	.word	04252H,118,24,08H
	.word	04042H,134,186,0FH
	.word	04253H,137,56,07H
	.word	04252H,138,56,09H
	.word	04344H,141,5,05H
	.word	04253H,160,24,06H
	.word	04042H,175,182,010H
	.word	04243H,208,24,04H
	.word	04042H,209,182,0AH
	.word	04344H,211,5,05H
	.word	04253H,240,24,04H
	.word	04042H,249,186,0FH
	.word	04243H,272,24,06H
	.word	04344H,281,5,05H
	.word	04042H,290,182,010H
	.word	04243H,295,56,07H
	.word	04242H,302,24,08H
	.word	04242H,318,56,09H
	.word	04042H,324,182,0AH
	.word	04240H,339,108,0BH
	.word	04241H,341,56,0CH
	.word	04344H,351,5,05H
	.word	04252H,358,24,08H
	.word	04042H,364,186,0FH
	.word	04253H,377,56,07H
	.word	04253H,378,56,07H
	.word	04252H,378,56,09H
	.word	04253H,400,24,06H
	.word	04042H,405,182,010H
	.word	04344H,421,5,05H
	.word	04042H,439,182,0AH
	.word	04243H,448,24,04H
	.word	04042H,479,186,0FH
	.word	04253H,480,24,04H
	.word	04344H,491,5,05H
	.word	04243H,512,24,06H
	.word	04042H,520,182,010H
	.word	04243H,535,56,07H
	.word	04242H,542,24,08H
	.word	04042H,554,182,0AH
	.word	04242H,558,56,09H
	.word	04344H,561,5,05H
	.word	04240H,579,108,0BH
	.word	04241H,581,56,0CH
	.word	04042H,594,186,0FH
	.word	04252H,598,24,08H
	.word	04253H,617,56,07H
	.word	04252H,618,56,09H
	.word	04344H,631,5,05H
	.word	04042H,635,182,010H
	.word	04253H,640,24,06H
	.word	04042H,669,182,0AH
	.word	04243H,688,24,04H
	.word	04344H,701,5,05H
	.word	04042H,709,186,0FH
	.word	04253H,720,24,04H
	.word	04042H,750,182,010H
	.word	04243H,752,24,06H
	.word	04344H,771,5,05H
	.word	04243H,775,56,07H
	.word	04242H,782,24,08H
	.word	04042H,784,182,0AH
	.word	04242H,798,56,09H
	.word	04240H,819,108,0BH
	.word	04241H,821,56,0CH
	.word	04042H,824,186,0FH
	.word	04252H,838,24,08H
	.word	04344H,841,5,05H
	.word	04253H,857,56,07H
	.word	04252H,858,56,09H
	.word	04042H,865,182,010H
	.word	04253H,880,24,06H
	.word	04142H,888,163,011H
	.word	04142H,898,236,012H
	.word	04344H,911,5,05H
	.word	04253H,928,24,04H
	.word	04042H,942,171,013H
	.word	04043H,943,183,014H
	.word	04042H,960,171,015H
	.word	04243H,960,24,04H
	.word	04152H,977,163,011H
	.word	04344H,981,5,05H
	.word	04243H,992,24,06H
	.word	04152H,994,236,012H
	.word	04243H,1015,56,07H
	.word	04242H,1022,24,08H
	.word	04042H,1022,182,0AH
	.word	04142H,1028,236,016H
	.word	04242H,1038,56,09H
	.word	04344H,1051,5,05H
	.word	04250H,1057,108,0BH
	.word	04251H,1059,56,0CH
	.word	04042H,1062,186,0FH
	.word	04252H,1078,24,08H
	.word	04253H,1097,56,07H
	.word	04252H,1098,56,09H
	.word	04042H,1103,182,010H
	.word	04253H,1120,24,06H
	.word	04344H,1121,5,05H
	.word	04042H,1137,182,0AH
	.word	04253H,1168,24,04H
	.word	04042H,1177,186,0FH
	.word	04344H,1191,5,05H
	.word	04243H,1200,24,04H
	.word	04042H,1218,182,010H
	.word	04243H,1232,24,06H
	.word	04042H,1252,182,0AH
	.word	04243H,1255,56,07H
	.word	04344H,1261,5,05H
	.word	04242H,1262,24,08H
	.word	04242H,1278,56,09H
	.word	04042H,1292,186,0FH
	.word	04240H,1299,108,0BH
	.word	04241H,1301,56,0CH
	.word	04252H,1318,24,08H
	.word	04344H,1331,5,05H
	.word	04042H,1333,182,010H
	.word	04253H,1337,56,07H
	.word	04252H,1338,56,09H
	.word	04253H,1360,24,06H
	.word	04042H,1367,182,0AH
	.word	04344H,1401,5,05H
	.word	04042H,1407,186,0FH
	.word	04253H,1408,24,04H
	.word	04243H,1440,24,04H
	.word	04042H,1448,182,010H
	.word	04344H,1471,5,05H
	.word	04243H,1472,24,06H
	.word	04042H,1482,182,0AH
	.word	04243H,1495,56,07H
	.word	04242H,1502,24,08H
	.word	04242H,1518,56,09H
	.word	04042H,1522,186,0FH
	.word	04240H,1540,108,0BH
	.word	04241H,1541,56,0CH
	.word	04344H,1541,5,05H
	.word	04252H,1558,24,08H
	.word	04042H,1563,182,010H
	.word	04253H,1577,56,07H
	.word	04252H,1578,56,09H
	.word	04042H,1597,182,0AH
	.word	04253H,1600,24,06H
	.word	04344H,1611,5,05H
	.word	04042H,1637,186,0FH
	.word	04253H,1648,24,04H
	.word	04042H,1678,182,010H
	.word	04243H,1680,24,04H
	.word	04344H,1681,5,05H
	.word	04243H,1712,24,06H
	.word	04042H,1712,182,0AH
	.word	04243H,1735,56,07H
	.word	04242H,1742,24,08H
	.word	04344H,1751,5,05H
	.word	04042H,1752,186,0FH
	.word	04242H,1758,56,09H
	.word	04240H,1779,108,0BH
	.word	04241H,1781,56,0CH
	.word	04042H,1793,182,010H
	.word	04252H,1798,24,08H
	.word	04253H,1817,56,07H
	.word	04252H,1818,56,09H
	.word	04344H,1821,5,05H
	.word	04042H,1827,182,0AH
	.word	04253H,1840,24,06H
	.word	04042H,1867,186,0FH
	.word	04042H,1908,182,010H
	.word	0FFFFH	;End Marker
TMOD3BLKS:
	.word	04045H	;flags
	.word	0,9 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04046H,0,53,03H
	.word	04045H,138,7,0DH
	.word	04047H,138,53,0EH
	.word	04055H,280,7,0DH
	.word	04057H,280,53,0EH
	.word	0FFFFH	;End Marker
TMOD2BMOD:
	.word	2036,32,37	;x size, y size, #blocks
	.long	TMOD2BLKS, HDRS, PALS
TMOD1BMOD:
	.word	1944,238,176	;x size, y size, #blocks
	.long	TMOD1BLKS, HDRS, PALS
TMOD3BMOD:
	.word	424,93,6	;x size, y size, #blocks
	.long	TMOD3BLKS, HDRS, PALS
R2HDRS:
	.word	64,48
	.long	037DCED9H
	.word	06080H
	.word	104,7
	.long	037E113FH
	.word	06000H
	.word	72,46
	.long	037E224FH
	.word	06280H
	.word	72,99
	.long	037E5143H
	.word	06280H
	.word	92,28
	.long	037ED795H
	.word	06080H
	.word	92,28
	.long	037F1385H
	.word	06080H
	.word	48,103
	.long	037F4F75H
	.word	06080H
	.word	48,69
	.long	037FAE87H
	.word	06080H
	.word	80,76
	.long	037FF777H
	.word	06180H
	.word	32,48
	.long	03807693H
	.word	06480H
	.word	88,69
	.long	03809427H
	.word	06280H
	.word	88,48
	.long	0380E833H
	.word	06280H
	.word	56,42
	.long	03813B13H
	.word	06680H
PLANE4BLKS:
	.word	04442H	;flags
	.word	0,107 ;x,y
	.word	06H	;pal5,pal4,hdr13-0
	.word	04462H,0,4,06H
	.word	04472H,343,7,06H
	.word	04442H,345,110,06H
	.word	0FFFFH	;End Marker
PLANE5BLKS:
	.word	04350H	;flags
	.word	0,5 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04341H,6,198,01H
	.word	04350H,8,53,02H
	.word	04350H,8,99,03H
	.word	04341H,35,99,04H
	.word	04341H,35,71,05H
	.word	04350H,63,5,00H
	.word	04340H,80,53,02H
	.word	04340H,80,99,03H
	.word	04341H,107,198,01H
	.word	04350H,126,5,00H
	.word	04350H,146,99,03H
	.word	04350H,146,53,02H
	.word	04341H,173,99,04H
	.word	04341H,173,71,05H
	.word	04350H,189,5,00H
	.word	04341H,208,198,01H
	.word	04340H,218,53,02H
	.word	04340H,218,99,03H
	.word	04350H,252,5,00H
	.word	04350H,284,53,02H
	.word	04350H,284,99,03H
	.word	04341H,309,198,01H
	.word	04341H,311,99,04H
	.word	04341H,311,71,05H
	.word	04350H,315,5,00H
	.word	04340H,356,99,03H
	.word	04340H,356,53,02H
	.word	04350H,378,5,00H
	.word	04341H,410,198,01H
	.word	04350H,422,129,07H
	.word	04350H,425,53,08H
	.word	04350H,440,5,09H
	.word	04350H,470,129,0AH
	.word	04050H,470,5,0BH
	.word	04350H,502,81,0CH
	.word	04341H,511,198,01H
	.word	04340H,558,129,0AH
	.word	04040H,558,5,0BH
	.word	04340H,558,81,0CH
	.word	04340H,611,53,08H
	.word	04341H,612,198,01H
	.word	04340H,644,5,09H
	.word	04340H,646,129,07H
	.word	04340H,674,5,00H
	.word	04350H,688,53,02H
	.word	04350H,688,99,03H
	.word	04341H,713,198,01H
	.word	04341H,715,71,05H
	.word	04341H,715,99,04H
	.word	04340H,737,5,00H
	.word	04340H,760,53,02H
	.word	04340H,760,99,03H
	.word	04340H,800,5,00H
	.word	04341H,814,198,01H
	.word	04350H,826,99,03H
	.word	04350H,826,53,02H
	.word	04341H,853,99,04H
	.word	04341H,853,71,05H
	.word	04340H,863,5,00H
	.word	04340H,898,53,02H
	.word	04340H,898,99,03H
	.word	04341H,915,198,01H
	.word	04340H,926,5,00H
	.word	04350H,964,53,02H
	.word	04350H,964,99,03H
	.word	04340H,989,5,00H
	.word	04341H,991,99,04H
	.word	04341H,991,71,05H
	.word	04341H,1016,198,01H
	.word	04340H,1036,99,03H
	.word	04340H,1036,53,02H
	.word	04340H,1052,5,00H
	.word	0FFFFH	;End Marker
PLANE4BMOD:
	.word	393,209,4	;x size, y size, #blocks
	.long	PLANE4BLKS, R2HDRS, R2PALS
PLANE5BMOD:
	.word	1120,200,73	;x size, y size, #blocks
	.long	PLANE5BLKS, R2HDRS, R2PALS
leHDRS:
	.word	116,87
	.long	03814E6FH
	.word	06E80H
	.word	104,24
	.long	03821BA7H
	.word	06480H
	.word	152,92
	.long	03824FA9H
	.word	05380H
	.word	168,58
	.long	03835076H
	.word	06F80H
	.word	60,30
	.long	03840886H
	.word	06280H
	.word	136,74
	.long	03842782H
	.word	06B80H
	.word	116,53
	.long	0384E702H
	.word	06980H
	.word	148,92
	.long	03856812H
	.word	05180H
	.word	48,128
	.long	03866FB5H
	.word	06580H
	.word	140,41
	.long	0386D4D5H
	.word	06C80H
	.word	48,49
	.long	03874A15H
	.word	06000H
	.word	192,55
	.long	03878135H
	.word	06E80H
	.word	56,87
	.long	03880A1DH
	.word	06180H
	.word	136,95
	.long	03886A17H
	.word	05780H
	.word	88,27
	.long	03895553H
	.word	06080H
	.word	80,80
	.long	03898BF5H
	.word	06280H
	.word	76,65
	.long	0389CC37H
	.word	06880H
	.word	72,22
	.long	038A11EFH
	.word	06080H
BAT7BLKS:
	.word	04043H	;flags
	.word	0,14 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04043H,150,14,07H
	.word	04043H,297,11,0EH
	.word	0FFFFH	;End Marker
BAT6BLKS:
	.word	04143H	;flags
	.word	0,1 ;x,y
	.word	03H	;pal5,pal4,hdr13-0
	.word	04143H,168,18,09H
	.word	04143H,307,32,0FH
	.word	04143H,392,32,0FH
	.word	0FFFFH	;End Marker
BAT5BLKS:
	.word	04043H	;flags
	.word	0,1 ;x,y
	.word	010H	;pal5,pal4,hdr13-0
	.word	04043H,80,16,011H
	.word	04043H,156,59,012H
	.word	04043H,228,59,012H
	.word	0FFFFH	;End Marker
BAT4BLKS:
	.word	04340H	;flags
	.word	0,4 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04340H,115,17,05H
	.word	04340H,249,42,0BH
	.word	04340H,296,4,0DH
	.word	04350H,350,4,0DH
	.word	04350H,405,42,0BH
	.word	04350H,451,17,05H
	.word	04350H,586,4,00H
	.word	04340H,701,17,05H
	.word	0FFFFH	;End Marker
BAT2BLKS:
	.word	04545H	;flags
	.word	0,152 ;x,y
	.word	04H	;pal5,pal4,hdr13-0
	.word	04545H,57,129,06H
	.word	04545H,88,1,08H
	.word	04555H,169,153,04H
	.word	04545H,555,152,04H
	.word	04545H,612,129,06H
	.word	04545H,643,1,08H
	.word	04555H,724,153,04H
	.word	0FFFFH	;End Marker
BAT1BLKS:
	.word	04644H	;flags
	.word	0,24 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	04644H,101,24,01H
	.word	04644H,202,24,01H
	.word	04742H,286,-1,0CH
	.word	04644H,438,24,01H
	.word	04644H,539,24,01H
	.word	04644H,640,24,01H
	.word	04644H,741,24,01H
	.word	04644H,842,24,01H
	.word	04742H,928,-1,0CH
	.word	04644H,1077,24,01H
	.word	04644H,1178,24,01H
	.word	0FFFFH	;End Marker
BAT7BMOD:
	.word	433,95,3	;x size, y size, #blocks
	.long	BAT7BLKS, leHDRS, lePALS
BAT6BMOD:
	.word	480,58,4	;x size, y size, #blocks
	.long	BAT6BLKS, leHDRS, lePALS
BAT5BMOD:
	.word	300,80,4	;x size, y size, #blocks
	.long	BAT5BLKS, leHDRS, lePALS
BAT4BMOD:
	.word	837,87,9	;x size, y size, #blocks
	.long	BAT4BLKS, leHDRS, lePALS
BAT2BMOD:
	.word	784,182,8	;x size, y size, #blocks
	.long	BAT2BLKS, leHDRS, lePALS
BAT1BMOD:
	.word	1282,55,12	;x size, y size, #blocks
	.long	BAT1BLKS, leHDRS, lePALS
st2HDRS:
	.word	64,15
	.long	038A36E7H
	.word	06880H
	.word	60,52
	.long	038A490BH
	.word	06180H
	.word	100,30
	.long	038A72CBH
	.word	06680H
	.word	28,61
	.long	038AAC5BH
	.word	06000H
	.word	28,19
	.long	038AD463H
	.word	06580H
	.word	104,11
	.long	038ADDCBH
	.word	05780H
	.word	80,18
	.long	038AED2DH
	.word	06A80H
	.word	80,133
	.long	038B0815H
	.word	06280H
	.word	132,34
	.long	038B9CD9H
	.word	06080H
	.word	72,64
	.long	038C0581H
	.word	06580H
	.word	36,61
	.long	038C480DH
	.word	06000H
	.word	36,25
	.long	038C7B85H
	.word	06680H
	.word	16,34
	.long	038C8BADH
	.word	06080H
	.word	68,41
	.long	038C985DH
	.word	06000H
	.word	72,22
	.long	038CD9B5H
	.word	06280H
	.word	108,32
	.long	038CF8A1H
	.word	06580H
	.word	48,86
	.long	038D3BD1H
	.word	06180H
	.word	60,31
	.long	038D6D85H
	.word	06580H
	.word	64,130
	.long	038D9211H
	.word	06680H
	.word	24,10
	.long	038E0905H
	.word	04580H
	.word	64,50
	.long	038E0BADH
	.word	06880H
	.word	72,60
	.long	038E3A37H
	.word	06580H
	.word	60,51
	.long	038E84A7H
	.word	06180H
	.word	72,105
	.long	038EAF37H
	.word	06280H
	.word	48,87
	.long	038F10C9H
	.word	06080H
	.word	76,64
	.long	038F4429H
	.word	06580H
	.word	28,77
	.long	038F85D1H
	.word	06000H
	.word	56,25
	.long	038FB859H
	.word	06A80H
	.word	128,15
	.long	038FCE81H
	.word	06C80H
	.word	152,44
	.long	038FF6FBH
	.word	06A80H
	.word	104,14
	.long	0390660BH
	.word	06D80H
	.word	28,77
	.long	0390847BH
	.word	06080H
	.word	56,105
	.long	0390B5CFH
	.word	06480H
	.word	108,15
	.long	03910777H
	.word	06380H
	.word	72,103
	.long	039128D7H
	.word	06280H
	.word	56,103
	.long	03918309H
	.word	06480H
	.word	128,105
	.long	0391D075H
	.word	06680H
	.word	64,113
	.long	03928121H
	.word	06180H
	.word	56,113
	.long	0392F4ABH
	.word	06480H
wood7BLKS:
	.word	04041H	;flags
	.word	0,40 ;x,y
	.word	08H	;pal5,pal4,hdr13-0
	.word	04041H,22,6,0CH
	.word	04041H,88,6,0CH
	.word	04041H,130,40,08H
	.word	04041H,152,6,0CH
	.word	04041H,218,6,0CH
	.word	04041H,260,40,08H
	.word	04041H,282,6,0CH
	.word	04041H,348,6,0CH
	.word	04041H,390,40,08H
	.word	04041H,412,6,0CH
	.word	04041H,478,6,0CH
	.word	0FFFFH	;End Marker
wood6BLKS:
	.word	04059H	;flags
	.word	0,101 ;x,y
	.word	05H	;pal5,pal4,hdr13-0
	.word	04042H,87,23,010H
	.word	04042H,103,14,013H
	.word	04049H,104,101,05H
	.word	04059H,204,101,05H
	.word	04042H,233,22,018H
	.word	04042H,249,12,013H
	.word	04049H,308,101,05H
	.word	04042H,361,22,018H
	.word	04042H,377,12,013H
	.word	04059H,408,101,05H
	.word	04042H,498,24,010H
	.word	04049H,512,101,05H
	.word	04042H,515,14,013H
	.word	04059H,612,101,05H
	.word	04042H,648,22,018H
	.word	04042H,664,12,013H
	.word	0FFFFH	;End Marker
wood5BLKS:
	.word	04049H	;flags
	.word	0,122 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04044H,24,83,01H
	.word	04044H,44,22,03H
	.word	04044H,44,3,04H
	.word	04049H,63,122,00H
	.word	04049H,126,122,00H
	.word	04049H,189,122,00H
	.word	04049H,252,122,00H
	.word	04044H,260,82,016H
	.word	04044H,280,21,03H
	.word	04044H,280,2,04H
	.word	04049H,315,122,01CH
	.word	04044H,429,85,01H
	.word	04049H,441,122,00H
	.word	04044H,449,24,03H
	.word	04044H,449,5,04H
	.word	04049H,504,122,00H
	.word	04049H,567,122,00H
	.word	04044H,621,82,016H
	.word	04044H,621,82,016H
	.word	04049H,630,122,00H
	.word	04044H,641,21,03H
	.word	04044H,641,2,04H
	.word	04049H,693,122,00H
	.word	04044H,740,82,01H
	.word	04049H,756,122,00H
	.word	04044H,760,21,03H
	.word	04044H,760,2,04H
	.word	0FFFFH	;End Marker
wood4BLKS:
	.word	04049H	;flags
	.word	0,151 ;x,y
	.word	06H	;pal5,pal4,hdr13-0
	.word	04044H,43,97,09H
	.word	04043H,61,36,0AH
	.word	04044H,61,11,0BH
	.word	04049H,79,147,0EH
	.word	04049H,151,151,06H
	.word	04049H,230,147,0EH
	.word	04044H,241,99,019H
	.word	04043H,265,38,0AH
	.word	04044H,265,14,0BH
	.word	04059H,302,147,0EH
	.word	04049H,374,151,06H
	.word	04059H,453,147,0EH
	.word	04044H,475,98,09H
	.word	04043H,493,37,0AH
	.word	04044H,493,13,0BH
	.word	04059H,524,151,06H
	.word	04049H,604,151,06H
	.word	04059H,682,151,06H
	.word	04049H,762,151,06H
	.word	04044H,768,98,019H
	.word	04043H,792,37,0AH
	.word	04044H,792,12,0BH
	.word	0FFFFH	;End Marker
wood2BLKS:
	.word	04058H	;flags
	.word	0,187 ;x,y
	.word	011H	;pal5,pal4,hdr13-0
	.word	04058H,58,168,014H
	.word	04058H,120,158,015H
	.word	04046H,131,106,017H
	.word	04045H,173,29,01AH
	.word	04044H,173,4,01BH
	.word	04047H,192,204,01EH
	.word	04045H,201,29,01FH
	.word	04046H,202,106,020H
	.word	04047H,293,203,021H
	.word	04046H,383,109,022H
	.word	04047H,401,204,01EH
	.word	04045H,423,32,01AH
	.word	04044H,423,7,01BH
	.word	04045H,451,32,01FH
	.word	04046H,452,109,023H
	.word	04047H,502,203,021H
	.word	04047H,610,204,01EH
	.word	04046H,692,106,024H
	.word	04047H,710,203,021H
	.word	04045H,734,29,01AH
	.word	04044H,734,4,01BH
	.word	04045H,762,29,01FH
	.word	04058H,817,187,011H
	.word	04058H,875,168,014H
	.word	04058H,937,158,015H
	.word	0FFFFH	;End Marker
wood1BLKS:
	.word	04040H	;flags
	.word	0,234 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	0404AH,36,131,07H
	.word	0406AH,78,90,0DH
	.word	0404AH,78,49,0DH
	.word	0406AH,78,8,0DH
	.word	04040H,98,232,0FH
	.word	0404AH,114,131,012H
	.word	04040H,203,234,02H
	.word	0404AH,287,220,01DH
	.word	04040H,301,232,0FH
	.word	0404AH,336,94,0DH
	.word	0406AH,336,53,0DH
	.word	0404AH,336,12,0DH
	.word	04040H,404,234,02H
	.word	04040H,501,234,02H
	.word	0404AH,584,220,01DH
	.word	04040H,598,234,02H
	.word	0404AH,633,94,0DH
	.word	0406AH,633,53,0DH
	.word	0404AH,633,12,0DH
	.word	04040H,696,234,02H
	.word	04040H,794,234,02H
	.word	0404AH,872,219,01DH
	.word	04040H,892,231,0FH
	.word	0404AH,921,94,0DH
	.word	0406AH,921,53,0DH
	.word	0404AH,921,12,0DH
	.word	04040H,996,233,02H
	.word	04040H,1094,233,02H
	.word	0404AH,1123,142,025H
	.word	0404AH,1150,101,0DH
	.word	0406AH,1150,60,0DH
	.word	0404AH,1150,19,0DH
	.word	0404AH,1186,142,026H
	.word	04040H,1192,231,0FH
	.word	0FFFFH	;End Marker
wood7BMOD:
	.word	522,68,12	;x size, y size, #blocks
	.long	wood7BLKS, st2HDRS, st2PALS
wood6BMOD:
	.word	716,100,17	;x size, y size, #blocks
	.long	wood6BLKS, st2HDRS, st2PALS
wood5BMOD:
	.word	820,135,28	;x size, y size, #blocks
	.long	wood5BLKS, st2HDRS, st2PALS
wood4BMOD:
	.word	844,158,23	;x size, y size, #blocks
	.long	wood4BLKS, st2HDRS, st2PALS
wood2BMOD:
	.word	1009,214,26	;x size, y size, #blocks
	.long	wood2BLKS, st2HDRS, st2PALS
wood1BMOD:
	.word	1300,256,35	;x size, y size, #blocks
	.long	wood1BLKS, st2HDRS, st2PALS
ry1HDRS:
	.word	108,36
	.long	03935A37H
	.word	06380H
	.word	68,141
	.long	0393AA71H
	.word	06880H
	.word	16,82
	.long	039463C9H
	.word	06080H
	.word	16,99
	.long	03948141H
	.word	05080H
	.word	36,82
	.long	03949F6BH
	.word	06000H
	.word	36,99
	.long	0394E49BH
	.word	06000H
	.word	36,83
	.long	03953823H
	.word	06180H
	.word	32,82
	.long	03955F6FH
	.word	06000H
	.word	32,99
	.long	03959CEFH
	.word	06000H
	.word	36,116
	.long	0395E72FH
	.word	06480H
	.word	84,68
	.long	03962243H
	.word	06380H
	.word	28,106
	.long	03966F03H
	.word	06080H
	.word	24,63
	.long	039690FBH
	.word	06080H
	.word	28,116
	.long	0396A3DFH
	.word	06180H
	.word	56,70
	.long	0396C6B7H
	.word	06000H
	.word	48,82
	.long	03972297H
	.word	06080H
	.word	48,93
	.long	03977747H
	.word	06080H
	.word	44,93
	.long	0397D225H
	.word	06080H
	.word	56,86
	.long	03982AA5H
	.word	06580H
	.word	136,43
	.long	03986E11H
	.word	06080H
	.word	136,42
	.long	0398F675H
	.word	06080H
	.word	136,96
	.long	03997BADH
	.word	06080H
	.word	24,81
	.long	039AAC2DH
	.word	06080H
	.word	16,48
	.long	039AC403H
	.word	06080H
	.word	20,88
	.long	039AD177H
	.word	06080H
ARM3BLKS:
	.word	04042H	;flags
	.word	0,103 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04042H,0,4,03H
	.word	04050H,13,103,04H
	.word	04051H,13,4,05H
	.word	04050H,49,103,07H
	.word	04051H,49,4,08H
	.word	04042H,81,103,02H
	.word	04042H,81,4,03H
	.word	04050H,94,103,04H
	.word	04051H,94,4,05H
	.word	04050H,130,103,07H
	.word	04051H,130,4,08H
	.word	04042H,162,103,02H
	.word	04042H,162,4,03H
	.word	04050H,175,103,04H
	.word	04051H,175,4,05H
	.word	04050H,211,103,07H
	.word	04051H,211,4,08H
	.word	04042H,243,103,02H
	.word	04042H,243,4,03H
	.word	04050H,256,103,04H
	.word	04051H,256,4,05H
	.word	04050H,292,103,07H
	.word	04051H,292,4,08H
	.word	04042H,324,103,02H
	.word	04042H,324,4,03H
	.word	04040H,338,142,013H
	.word	04041H,338,4,014H
	.word	04048H,338,46,015H
	.word	04042H,472,103,02H
	.word	04042H,472,4,03H
	.word	04050H,485,103,04H
	.word	04051H,485,4,05H
	.word	04050H,521,103,07H
	.word	04051H,521,4,08H
	.word	04042H,553,103,02H
	.word	04042H,553,5,03H
	.word	04050H,566,103,04H
	.word	04051H,566,4,05H
	.word	04050H,602,103,07H
	.word	04051H,602,5,08H
	.word	04042H,634,103,02H
	.word	04042H,634,4,03H
	.word	04050H,647,103,04H
	.word	04051H,647,4,05H
	.word	04050H,683,103,07H
	.word	04051H,683,4,08H
	.word	04042H,715,103,02H
	.word	04042H,715,4,03H
	.word	04050H,728,103,04H
	.word	04051H,728,4,05H
	.word	04050H,764,103,07H
	.word	04051H,764,4,08H
	.word	04042H,796,103,02H
	.word	04042H,796,4,03H
	.word	0FFFFH	;End Marker
ARM2BLKS:
	.word	04142H	;flags
	.word	0,107 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04152H,105,2,01H
	.word	04142H,173,2,01H
	.word	04142H,240,107,00H
	.word	04142H,346,107,00H
	.word	04142H,452,107,00H
	.word	04247H,469,58,012H
	.word	04247H,522,63,016H
	.word	04247H,543,96,017H
	.word	04142H,558,107,00H
	.word	04247H,558,56,018H
	.word	04142H,664,107,00H
	.word	04142H,770,107,00H
	.word	04247H,811,96,017H
	.word	04247H,826,56,018H
	.word	04152H,875,2,01H
	.word	04142H,943,2,01H
	.word	0FFFFH	;End Marker
ARM1BLKS:
	.word	04245H	;flags
	.word	0,167 ;x,y
	.word	06H	;pal5,pal4,hdr13-0
	.word	04245H,34,134,09H
	.word	04046H,42,5,0AH
	.word	04245H,67,144,0BH
	.word	04245H,95,187,0CH
	.word	03F45H,116,134,0DH
	.word	04046H,126,5,0EH
	.word	04054H,135,168,0FH
	.word	04044H,138,75,010H
	.word	04056H,180,5,0EH
	.word	04044H,183,168,0FH
	.word	04044H,183,75,011H
	.word	03F45H,226,186,0CH
	.word	04056H,236,5,0AH
	.word	03F55H,245,166,06H
	.word	04046H,519,4,0AH
	.word	04245H,563,185,0CH
	.word	03F45H,584,132,09H
	.word	04046H,603,5,0EH
	.word	04054H,611,168,0FH
	.word	04044H,613,75,010H
	.word	04056H,657,5,0EH
	.word	04044H,658,75,011H
	.word	04044H,659,168,0FH
	.word	03F45H,702,142,0BH
	.word	04056H,713,5,0AH
	.word	04245H,730,185,0CH
	.word	04245H,741,165,06H
	.word	0FFFFH	;End Marker
ARM3BMOD:
	.word	812,181,55	;x size, y size, #blocks
	.long	ARM3BLKS, ry1HDRS, ry1PALS
ARM2BMOD:
	.word	1011,142,17	;x size, y size, #blocks
	.long	ARM2BLKS, ry1HDRS, ry1PALS
ARM1BMOD:
	.word	797,246,28	;x size, y size, #blocks
	.long	ARM1BLKS, ry1HDRS, ry1PALS
GE1HDRS:
	.word	60,63
	.long	039AEC0DH
	.word	06080H
	.word	60,63
	.long	039B2DE9H
	.word	06080H
	.word	100,38
	.long	039B6FC5H
	.word	06380H
	.word	56,67
	.long	039B8E59H
	.word	06680H
	.word	100,24
	.long	039BC8F9H
	.word	06180H
	.word	132,42
	.long	039BFBE1H
	.word	06780H
	.word	92,17
	.long	039C498DH
	.word	06680H
	.word	92,23
	.long	039C5D35H
	.word	06080H
	.word	92,14
	.long	039C8E71H
	.word	04A80H
	.word	132,15
	.long	039C99D1H
	.word	04A80H
	.word	112,13
	.long	039CADE9H
	.word	04A80H
	.word	172,14
	.long	039CBE01H
	.word	04780H
	.word	68,8
	.long	039CDAB9H
	.word	04000H
	.word	148,12
	.long	039CE339H
	.word	06D80H
	.word	76,189
	.long	039CFFADH
	.word	06680H
	.word	172,52
	.long	039DD1ADH
	.word	06C80H
	.word	56,118
	.long	039E818FH
	.word	06580H
	.word	92,16
	.long	039EEEABH
	.word	04980H
	.word	32,12
	.long	039EFCDBH
	.word	06180H
	.word	68,21
	.long	039F046DH
	.word	06580H
	.word	8,66
	.long	039F1799H
	.word	03000H
	.word	140,33
	.long	039F1DC9H
	.word	06380H
	.word	64,51
	.long	039F7583H
	.word	05580H
BRIDGE0BLKS:
	.word	04046H	;flags
	.word	0,148 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04046H,0,211,00H
	.word	04046H,0,274,00H
	.word	04046H,0,337,00H
	.word	04046H,0,400,00H
	.word	04046H,0,463,00H
	.word	04046H,0,526,00H
	.word	04046H,0,589,00H
	.word	04046H,0,652,00H
	.word	04046H,0,715,00H
	.word	04046H,0,778,00H
	.word	04046H,0,841,00H
	.word	04046H,0,904,00H
	.word	04046H,0,967,00H
	.word	04046H,1,85,01H
	.word	04056H,30,18,03H
	.word	04352H,86,20,05H
	.word	04352H,218,20,05H
	.word	04046H,350,18,03H
	.word	04046H,376,148,00H
	.word	04046H,376,211,00H
	.word	04046H,376,274,00H
	.word	04046H,376,337,00H
	.word	04046H,376,400,00H
	.word	04046H,376,463,00H
	.word	04046H,376,526,00H
	.word	04046H,376,589,00H
	.word	04046H,376,652,00H
	.word	04046H,376,715,00H
	.word	04046H,376,778,00H
	.word	04046H,376,841,00H
	.word	04046H,376,904,00H
	.word	04046H,376,967,00H
	.word	04046H,377,85,01H
	.word	04056H,406,18,03H
	.word	04352H,462,20,05H
	.word	04352H,594,20,05H
	.word	04046H,726,18,03H
	.word	04046H,752,148,00H
	.word	04046H,752,211,00H
	.word	04046H,752,274,00H
	.word	04046H,752,337,00H
	.word	04046H,752,400,00H
	.word	04046H,752,463,00H
	.word	04046H,752,526,00H
	.word	04046H,752,589,00H
	.word	04046H,752,652,00H
	.word	04046H,752,715,00H
	.word	04046H,752,777,00H
	.word	04046H,752,840,00H
	.word	04046H,752,903,00H
	.word	04046H,752,966,00H
	.word	04046H,753,85,01H
	.word	04056H,782,18,03H
	.word	04342H,835,20,05H
	.word	04342H,967,21,05H
	.word	04046H,1099,18,03H
	.word	04046H,1126,148,00H
	.word	04046H,1126,211,00H
	.word	04046H,1126,274,00H
	.word	04046H,1126,337,00H
	.word	04046H,1126,400,00H
	.word	04046H,1126,463,00H
	.word	04046H,1126,526,00H
	.word	04046H,1126,589,00H
	.word	04046H,1126,652,00H
	.word	04046H,1126,715,00H
	.word	04046H,1126,778,00H
	.word	04046H,1126,841,00H
	.word	04046H,1126,904,00H
	.word	04046H,1126,967,00H
	.word	04046H,1127,85,01H
	.word	04056H,1155,18,03H
	.word	04342H,1209,20,05H
	.word	04342H,1340,20,05H
	.word	04046H,1472,18,03H
	.word	04046H,1499,148,00H
	.word	04046H,1499,211,00H
	.word	04046H,1499,274,00H
	.word	04046H,1499,337,00H
	.word	04046H,1499,400,00H
	.word	04046H,1499,463,00H
	.word	04046H,1499,526,00H
	.word	04046H,1499,589,00H
	.word	04046H,1499,652,00H
	.word	04046H,1499,715,00H
	.word	04046H,1499,778,00H
	.word	04046H,1499,841,00H
	.word	04046H,1499,904,00H
	.word	04046H,1499,967,00H
	.word	04046H,1500,85,01H
	.word	0FFFFH	;End Marker
BRIDGE6BLKS:
	.word	03C45H	;flags
	.word	0,63 ;x,y
	.word	0FH	;pal5,pal4,hdr13-0
	.word	03C45H,172,83,015H
	.word	04047H,257,1,016H
	.word	03C55H,306,83,015H
	.word	0FFFFH	;End Marker
BRIDGE5BLKS:
	.word	03D45H	;flags
	.word	0,4 ;x,y
	.word	0DH	;pal5,pal4,hdr13-0
	.word	03D45H,142,2,0DH
	.word	03D45H,282,1,0DH
	.word	03D45H,421,0,0DH
	.word	0FFFFH	;End Marker
BRIDGE4BLKS:
	.word	04044H	;flags
	.word	0,8 ;x,y
	.word	0BH	;pal5,pal4,hdr13-0
	.word	04054H,168,8,0BH
	.word	04044H,339,8,0BH
	.word	04054H,507,8,0BH
	.word	0FFFFH	;End Marker
BRIDGE3BLKS:
	.word	04048H	;flags
	.word	0,6 ;x,y
	.word	0EH	;pal5,pal4,hdr13-0
	.word	04048H,74,77,010H
	.word	04043H,121,113,012H
	.word	04043H,152,109,013H
	.word	04043H,182,130,014H
	.word	04043H,217,109,013H
	.word	04043H,247,130,014H
	.word	04043H,282,109,013H
	.word	04043H,312,130,014H
	.word	04053H,346,113,012H
	.word	04058H,369,78,010H
	.word	04058H,423,7,0EH
	.word	0FFFFH	;End Marker
BRIDGE2BLKS:
	.word	04044H	;flags
	.word	0,8 ;x,y
	.word	08H	;pal5,pal4,hdr13-0
	.word	04044H,95,5,09H
	.word	04044H,212,10,0AH
	.word	04044H,314,11,0CH
	.word	04044H,474,9,011H
	.word	04044H,543,5,0AH
	.word	04044H,618,15,0CH
	.word	04044H,700,16,09H
	.word	04044H,863,18,0AH
	.word	04044H,947,8,011H
	.word	04044H,1023,20,0CH
	.word	0FFFFH	;End Marker
BRIDGE1BLKS:
	.word	04150H	;flags
	.word	0,6 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04140H,3,44,04H
	.word	04151H,98,27,06H
	.word	04141H,100,44,07H
	.word	04151H,188,44,07H
	.word	04141H,190,27,06H
	.word	04150H,277,44,04H
	.word	04140H,280,6,02H
	.word	04150H,374,6,02H
	.word	04140H,377,44,04H
	.word	04151H,472,27,06H
	.word	04141H,474,44,07H
	.word	04151H,562,44,07H
	.word	04141H,564,27,06H
	.word	04150H,651,44,04H
	.word	04140H,654,6,02H
	.word	04150H,748,6,02H
	.word	04140H,751,44,04H
	.word	04151H,846,27,06H
	.word	04141H,848,44,07H
	.word	04151H,936,44,07H
	.word	04141H,938,27,06H
	.word	04150H,1025,44,04H
	.word	04140H,1028,6,02H
	.word	04150H,1122,6,02H
	.word	04140H,1125,44,04H
	.word	04151H,1220,27,06H
	.word	04141H,1222,44,07H
	.word	04151H,1310,44,07H
	.word	04141H,1312,27,06H
	.word	04150H,1399,44,04H
	.word	04140H,1402,6,02H
	.word	0FFFFH	;End Marker
BRIDGE0BMOD:
	.word	1560,1012,91	;x size, y size, #blocks
	.long	BRIDGE0BLKS, GE1HDRS, GE1PALS
BRIDGE6BMOD:
	.word	446,115,4	;x size, y size, #blocks
	.long	BRIDGE6BLKS, GE1HDRS, GE1PALS
BRIDGE5BMOD:
	.word	569,16,4	;x size, y size, #blocks
	.long	BRIDGE5BLKS, GE1HDRS, GE1PALS
BRIDGE4BMOD:
	.word	679,14,4	;x size, y size, #blocks
	.long	BRIDGE4BLKS, GE1HDRS, GE1PALS
BRIDGE3BMOD:
	.word	499,190,12	;x size, y size, #blocks
	.long	BRIDGE3BLKS, GE1HDRS, GE1PALS
BRIDGE2BMOD:
	.word	1091,26,11	;x size, y size, #blocks
	.long	BRIDGE2BLKS, GE1HDRS, GE1PALS
BRIDGE1BMOD:
	.word	1502,62,32	;x size, y size, #blocks
	.long	BRIDGE1BLKS, GE1HDRS, GE1PALS
alHDRS:
	.word	88,24
	.long	039FA943H
	.word	06280H
	.word	56,24
	.long	039FD1ABH
	.word	06080H
	.word	20,70
	.long	039FF0CBH
	.word	06080H
	.word	32,81
	.long	03A00A0BH
	.word	06480H
	.word	20,70
	.long	03A043CBH
	.word	06080H
	.word	40,76
	.long	03A05DE3H
	.word	06480H
	.word	24,70
	.long	03A08F17H
	.word	06080H
	.word	48,24
	.long	03A0AA13H
	.word	06080H
	.word	40,34
	.long	03A0C3E1H
	.word	06280H
	.word	60,32
	.long	03A0E3ABH
	.word	06080H
	.word	88,25
	.long	03A10B9FH
	.word	06880H
	.word	20,97
	.long	03A13D03H
	.word	06080H
	.word	16,62
	.long	03A166B1H
	.word	06080H
	.word	112,12
	.long	03A17861H
	.word	06980H
	.word	108,20
	.long	03A18DCDH
	.word	06D80H
	.word	144,47
	.long	03780338H
	.word	06000H
	.word	140,44
	.long	03732896H
	.word	06480H
	.word	136,39
	.long	03A1AEC5H
	.word	06000H
	.word	28,8
	.long	03A22B15H
	.word	04000H
	.word	88,82
	.long	03A22E95H
	.word	06580H
	.word	32,131
	.long	03A2B7A1H
	.word	06000H
	.word	96,24
	.long	03A319E1H
	.word	06F80H
	.word	32,143
	.long	03A33391H
	.word	06180H
	.word	44,147
	.long	03A39A55H
	.word	06280H
	.word	56,152
	.long	03A42D6DH
	.word	06580H
	.word	44,132
	.long	03A4E4A1H
	.word	06000H
	.word	144,46
	.long	03A56CC1H
	.word	06880H
	.word	136,39
	.long	03A606D1H
	.word	06080H
spiral1BLKS:
	.word	04245H	;flags
	.word	0,199 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04245H,87,198,0AH
	.word	04245H,93,101,0BH
	.word	04245H,93,4,0BH
	.word	04245H,174,199,00H
	.word	04245H,261,198,0AH
	.word	04245H,267,101,0BH
	.word	04245H,267,4,0BH
	.word	04245H,348,199,00H
	.word	04245H,435,198,0AH
	.word	04245H,441,101,0BH
	.word	04245H,441,4,0BH
	.word	04245H,522,199,015H
	.word	04255H,618,199,015H
	.word	04255H,713,198,0AH
	.word	04255H,775,101,0BH
	.word	04255H,775,4,0BH
	.word	04255H,800,199,00H
	.word	04255H,887,198,0AH
	.word	04255H,949,101,0BH
	.word	04255H,949,4,0BH
	.word	04255H,974,199,00H
	.word	04255H,1061,198,0AH
	.word	04255H,1123,101,0BH
	.word	04255H,1123,4,0BH
	.word	04255H,1148,199,00H
	.word	0FFFFH	;End Marker
spiral2BLKS:
	.word	04044H	;flags
	.word	0,157 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	04044H,0,87,02H
	.word	04144H,0,6,03H
	.word	04144H,19,87,04H
	.word	04144H,30,11,05H
	.word	04144H,39,87,06H
	.word	04144H,54,157,07H
	.word	04144H,60,123,08H
	.word	04144H,68,55,09H
	.word	04144H,100,87,0CH
	.word	04154H,1095,55,09H
	.word	04154H,1107,87,0CH
	.word	04154H,1120,157,07H
	.word	04154H,1123,123,08H
	.word	04154H,1153,11,05H
	.word	04154H,1160,87,06H
	.word	04054H,1166,157,01H
	.word	04154H,1184,87,04H
	.word	04154H,1191,6,03H
	.word	04054H,1202,87,02H
	.word	0FFFFH	;End Marker
spiral3BLKS:
	.word	04150H	;flags
	.word	0,10 ;x,y
	.word	0DH	;pal5,pal4,hdr13-0
	.word	04140H,112,2,0EH
	.word	04140H,219,10,0DH
	.word	04150H,516,10,0DH
	.word	04140H,628,2,0EH
	.word	04140H,735,10,0DH
	.word	0FFFFH	;End Marker
spiral4BLKS:
	.word	04041H	;flags
	.word	0,135 ;x,y
	.word	0FH	;pal5,pal4,hdr13-0
	.word	04043H,5,91,010H
	.word	04040H,8,182,011H
	.word	04140H,36,174,012H
	.word	04146H,63,6,013H
	.word	04042H,143,90,014H
	.word	04040H,174,78,016H
	.word	04040H,205,74,017H
	.word	04040H,249,69,018H
	.word	04040H,303,89,019H
	.word	04043H,347,89,01AH
	.word	04041H,347,135,0FH
	.word	04040H,347,182,01BH
	.word	0FFFFH	;End Marker
spiral1BMOD:
	.word	1236,219,26	;x size, y size, #blocks
	.long	spiral1BLKS, alHDRS, alPALS
spiral2BMOD:
	.word	1223,175,20	;x size, y size, #blocks
	.long	spiral2BLKS, alHDRS, alPALS
spiral3BMOD:
	.word	847,20,6	;x size, y size, #blocks
	.long	spiral3BLKS, alHDRS, alPALS
spiral4BMOD:
	.word	491,215,13	;x size, y size, #blocks
	.long	spiral4BLKS, alHDRS, alPALS
aHDRS:
	.word	128,7
	.long	03A6819BH
	.word	06000H
	.word	76,21
	.long	03A6969BH
	.word	06000H
	.word	124,19
	.long	03A6BC03H
	.word	06080H
	.word	80,8
	.long	03A6F27DH
	.word	06000H
	.word	80,11
	.long	03A7017DH
	.word	06080H
	.word	56,74
	.long	03A715AFH
	.word	06580H
	.word	44,60
	.long	03A75F27H
	.word	06480H
	.word	48,68
	.long	03A79713H
	.word	06180H
	.word	68,99
	.long	03A7DA7FH
	.word	06A80H
	.word	60,71
	.long	03A83F2FH
	.word	06880H
	.word	48,42
	.long	03A88B89H
	.word	05000H
	.word	88,33
	.long	03A8B2E9H
	.word	06880H
	.word	40,21
	.long	03A8E787H
	.word	06080H
	.word	16,45
	.long	03A8FA0BH
	.word	06080H
	.word	40,15
	.long	03A90755H
	.word	06180H
	.word	76,20
	.long	03A90FC5H
	.word	06580H
	.word	76,11
	.long	03A93069H
	.word	06000H
	.word	48,21
	.long	03A94401H
	.word	06000H
	.word	56,22
	.long	03A95BA1H
	.word	06480H
	.word	84,33
	.long	03A96DAFH
	.word	06180H
	.word	24,21
	.long	03A9A577H
	.word	06080H
	.word	16,51
	.long	03A9B01BH
	.word	06080H
	.word	108,11
	.long	03A9BEF1H
	.word	06000H
	.word	56,25
	.long	03A9DAC9H
	.word	06080H
	.word	56,46
	.long	03A9FAF3H
	.word	06480H
	.word	56,25
	.long	03AA3293H
	.word	06080H
	.word	44,39
	.long	03AA5269H
	.word	06480H
	.word	40,21
	.long	03AA7027H
	.word	06080H
	.word	76,11
	.long	03AA7E0DH
	.word	06000H
	.word	76,20
	.long	03AA91A5H
	.word	06580H
arena6BLKS:
	.word	04040H	;flags
	.word	0,51 ;x,y
	.word	06H	;pal5,pal4,hdr13-0
	.word	04040H,42,43,07H
	.word	04040H,87,40,09H
	.word	03F49H,104,58,0AH
	.word	04040H,146,78,0BH
	.word	03F49H,152,58,0AH
	.word	04040H,200,36,0EH
	.word	03F49H,200,58,0AH
	.word	04050H,232,78,0BH
	.word	03F49H,248,58,0AH
	.word	04040H,291,26,012H
	.word	03F49H,296,58,0AH
	.word	04040H,320,78,013H
	.word	03F49H,344,58,0AH
	.word	03F49H,392,58,0AH
	.word	0FFFFH	;End Marker
arena5BLKS:
	.word	04141H	;flags
	.word	0,111 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04041H,1,12,05H
	.word	04041H,55,12,08H
	.word	04141H,121,111,02H
	.word	04041H,122,12,05H
	.word	04041H,176,12,08H
	.word	04141H,242,111,02H
	.word	04041H,243,12,05H
	.word	04041H,297,12,08H
	.word	04141H,363,111,02H
	.word	04041H,364,12,05H
	.word	04041H,418,12,08H
	.word	04141H,484,111,02H
	.word	04041H,485,12,05H
	.word	04041H,539,12,08H
	.word	0FFFFH	;End Marker
arena4BLKS:
	.word	04043H	;flags
	.word	0,7 ;x,y
	.word	03H	;pal5,pal4,hdr13-0
	.word	04043H,77,7,03H
	.word	04043H,154,7,03H
	.word	04043H,231,7,03H
	.word	04043H,308,7,03H
	.word	04043H,385,7,03H
	.word	04043H,462,7,03H
	.word	04043H,539,7,03H
	.word	04043H,616,7,03H
	.word	04043H,693,7,03H
	.word	04043H,770,7,03H
	.word	04043H,847,7,03H
	.word	04043H,924,7,03H
	.word	0FFFFH	;End Marker
arena3BLKS:
	.word	04043H	;flags
	.word	0,4 ;x,y
	.word	04H	;pal5,pal4,hdr13-0
	.word	04043H,77,4,04H
	.word	04043H,154,4,04H
	.word	04043H,231,4,04H
	.word	04043H,308,4,04H
	.word	04043H,385,4,04H
	.word	04043H,462,4,04H
	.word	04043H,539,4,04H
	.word	04043H,616,4,04H
	.word	04043H,693,4,04H
	.word	04043H,770,4,04H
	.word	04043H,847,4,04H
	.word	04043H,924,4,04H
	.word	04043H,1001,4,04H
	.word	0FFFFH	;End Marker
arena2BLKS:
	.word	04047H	;flags
	.word	0,122 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	04047H,17,115,00H
	.word	04047H,17,115,00H
	.word	04047H,76,122,01H
	.word	04047H,143,115,00H
	.word	04147H,144,122,0CH
	.word	04257H,150,77,0DH
	.word	04147H,182,112,0FH
	.word	04047H,182,132,010H
	.word	04047H,258,122,011H
	.word	04047H,269,115,00H
	.word	04247H,272,77,0DH
	.word	04047H,305,122,01H
	.word	04147H,373,122,014H
	.word	04344H,380,78,015H
	.word	04244H,395,132,016H
	.word	04244H,395,107,017H
	.word	04344H,402,63,015H
	.word	04044H,449,61,018H
	.word	04244H,450,107,019H
	.word	04244H,461,2,01AH
	.word	04244H,465,41,01BH
	.word	04254H,500,107,019H
	.word	04254H,501,41,01BH
	.word	04254H,501,2,01AH
	.word	04054H,501,61,018H
	.word	04254H,503,132,016H
	.word	04254H,555,107,017H
	.word	04344H,588,63,015H
	.word	04157H,609,122,014H
	.word	04047H,611,115,00H
	.word	04344H,613,78,015H
	.word	04047H,625,122,01H
	.word	04057H,700,122,011H
	.word	04257H,718,77,0DH
	.word	04047H,737,115,00H
	.word	04246H,748,132,01CH
	.word	04256H,748,112,01DH
	.word	04157H,822,122,0CH
	.word	04247H,840,77,0DH
	.word	04047H,854,122,01H
	.word	04047H,863,115,00H
	.word	04047H,930,122,01H
	.word	04047H,989,115,00H
	.word	04047H,1006,122,01H
	.word	0FFFFH	;End Marker
arena6BMOD:
	.word	440,85,15	;x size, y size, #blocks
	.long	arena6BLKS, aHDRS, aPALS
arena5BMOD:
	.word	608,118,15	;x size, y size, #blocks
	.long	arena5BLKS, aHDRS, aPALS
arena4BMOD:
	.word	1004,8,13	;x size, y size, #blocks
	.long	arena4BLKS, aHDRS, aPALS
arena3BMOD:
	.word	1081,11,14	;x size, y size, #blocks
	.long	arena3BLKS, aHDRS, aPALS
arena2BMOD:
	.word	1117,141,45	;x size, y size, #blocks
	.long	arena2BLKS, aHDRS, aPALS
GEHDRS:
	.word	144,81
	.long	03AAB279H
	.word	05080H
	.word	136,55
	.long	03AB905CH
	.word	05180H
	.word	236,56
	.long	03AC16A3H
	.word	06F80H
	.word	220,47
	.long	03ACFB73H
	.word	06A80H
	.word	140,55
	.long	03ADB043H
	.word	05480H
	.word	132,81
	.long	03AE3CE3H
	.word	05080H
HUGE1BLKS:
	.word	04043H	;flags
	.word	0,110 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04041H,2,55,01H
	.word	04045H,19,191,02H
	.word	04040H,29,8,03H
	.word	04042H,135,55,04H
	.word	04044H,143,110,05H
	.word	0FFFFH	;End Marker
HUGE1BMOD:
	.word	275,239,6	;x size, y size, #blocks
	.long	HUGE1BLKS, GEHDRS, GEPALS
tainHDRS:
	.word	108,36
	.long	03AF0775H
	.word	06280H
	.word	100,89
	.long	03AF5635H
	.word	06680H
	.word	44,148
	.long	03AFD751H
	.word	06680H
	.word	172,114
	.long	03B054E1H
	.word	06B80H
	.word	140,62
	.long	03B1A619H
	.word	06380H
	.word	136,22
	.long	03B26D49H
	.word	05880H
	.word	76,26
	.long	03B2A670H
	.word	06880H
	.word	60,49
	.long	03B2D458H
	.word	06080H
	.word	36,49
	.long	03B3187CH
	.word	06180H
	.word	68,143
	.long	03B33054H
	.word	06B80H
	.word	24,55
	.long	03B3FE5CH
	.word	06080H
	.word	20,41
	.long	03B41C46H
	.word	06080H
	.word	40,43
	.long	03B42BB0H
	.word	06080H
	.word	40,46
	.long	03B45252H
	.word	06080H
	.word	96,33
	.long	03B47BA6H
	.word	06080H
	.word	80,51
	.long	03B4C376H
	.word	06880H
	.word	88,29
	.long	03B5187EH
	.word	06080H
	.word	68,27
	.long	03B551FAH
	.word	06280H
	.word	88,148
	.long	03B57B16H
	.word	06780H
	.word	48,44
	.long	03B654F2H
	.word	06080H
	.word	32,58
	.long	03B685C2H
	.word	06080H
	.word	88,37
	.long	03B6B05AH
	.word	06A80H
	.word	108,64
	.long	03B6F232H
	.word	06980H
	.word	112,25
	.long	03B75CDEH
	.word	05380H
	.word	108,61
	.long	03B78B69H
	.word	06180H
	.word	88,74
	.long	03B821D7H
	.word	06080H
	.word	32,58
	.long	03B8AA43H
	.word	06080H
	.word	72,38
	.long	03B8D4DBH
	.word	06080H
	.word	32,33
	.long	03B9137FH
	.word	06180H
	.word	76,83
	.long	03B92519H
	.word	06080H
	.word	96,62
	.long	03B9B79FH
	.word	06080H
	.word	40,71
	.long	03BA40B3H
	.word	06180H
	.word	84,69
	.long	03BA7741H
	.word	06280H
	.word	124,38
	.long	03BABCFBH
	.word	06380H
	.word	68,54
	.long	03BB2125H
	.word	06080H
	.word	36,20
	.long	03BB7519H
	.word	06280H
	.word	56,38
	.long	03BB8441H
	.word	06080H
	.word	116,43
	.long	03BBB4A5H
	.word	06080H
	.word	108,54
	.long	03BC2467H
	.word	06080H
	.word	28,40
	.long	03BCA201H
	.word	06180H
	.word	60,11
	.long	03BCB049H
	.word	06080H
	.word	88,61
	.long	03BCBCEFH
	.word	06080H
	.word	76,68
	.long	03BD3251H
	.word	06080H
	.word	52,74
	.long	03BD9D23H
	.word	06080H
	.word	56,102
	.long	03BDDFABH
	.word	06480H
	.word	72,56
	.long	03BE384FH
	.word	06880H
	.word	72,31
	.long	03BE943FH
	.word	05280H
	.word	56,9
	.long	03BEB40EH
	.word	06000H
	.word	24,72
	.long	03BEBFDEH
	.word	06000H
	.word	52,32
	.long	03BEE85EH
	.word	06000H
	.word	72,51
	.long	03BF0F5EH
	.word	06880H
	.word	36,42
	.long	03BF3BB0H
	.word	05000H
	.word	28,15
	.long	03BF5938H
	.word	06180H
	.word	64,74
	.long	03BF6166H
	.word	06480H
	.word	100,24
	.long	03BFBA3EH
	.word	06B80H
	.word	96,38
	.long	03BFD59EH
	.word	06F80H
	.word	100,73
	.long	03BFE89EH
	.word	05380H
	.word	92,43
	.long	03C05882H
	.word	06680H
	.word	40,37
	.long	03C0A9C6H
	.word	06480H
	.word	88,40
	.long	03C0BBA4H
	.word	06F80H
	.word	84,31
	.long	03C10274H
	.word	05380H
	.word	44,69
	.long	03C132E7H
	.word	06080H
	.word	20,70
	.long	03C17427H
	.word	06080H
mount2BLKS:
	.word	04042H	;flags
	.word	0,41 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04041H,0,167,03H
	.word	04042H,42,41,09H
	.word	04042H,110,41,012H
	.word	04041H,141,186,015H
	.word	03F41H,141,217,016H
	.word	04042H,196,41,020H
	.word	04042H,196,155,021H
	.word	04051H,227,186,015H
	.word	04041H,260,217,02FH
	.word	04042H,279,41,032H
	.word	04041H,303,222,036H
	.word	03F41H,308,227,037H
	.word	04041H,313,183,039H
	.word	04042H,318,152,03BH
	.word	0FFFFH	;End Marker
mount1BLKS:
	.word	04040H	;flags
	.word	0,886 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04140H,8,797,01H
	.word	04143H,91,904,04H
	.word	04044H,91,963,05H
	.word	04040H,106,896,06H
	.word	04040H,106,847,07H
	.word	04040H,108,798,08H
	.word	04040H,142,792,0AH
	.word	04040H,145,751,0BH
	.word	04040H,164,853,0CH
	.word	04040H,164,807,0DH
	.word	04040H,164,723,0EH
	.word	04040H,164,756,0FH
	.word	04040H,173,694,010H
	.word	04140H,180,605,01H
	.word	04040H,181,896,011H
	.word	04040H,201,852,013H
	.word	04040H,201,794,014H
	.word	04044H,227,960,017H
	.word	04143H,229,904,018H
	.word	04040H,230,546,019H
	.word	04040H,231,794,01AH
	.word	04040H,241,756,01BH
	.word	04040H,244,472,019H
	.word	04040H,246,620,01CH
	.word	04040H,247,846,01DH
	.word	04140H,258,383,01H
	.word	04040H,260,694,01EH
	.word	04140H,261,775,01FH
	.word	04040H,277,614,01DH
	.word	04040H,297,354,019H
	.word	04040H,298,794,022H
	.word	04140H,303,743,01FH
	.word	04040H,304,596,023H
	.word	04040H,310,756,024H
	.word	04040H,310,311,025H
	.word	04040H,312,257,026H
	.word	04140H,313,527,01FH
	.word	04040H,319,842,01DH
	.word	04140H,325,814,027H
	.word	04043H,325,969,028H
	.word	04040H,326,196,029H
	.word	04040H,326,128,02AH
	.word	04040H,328,525,02BH
	.word	04140H,329,454,01FH
	.word	04040H,333,26,02CH
	.word	04143H,334,906,02DH
	.word	04140H,336,598,027H
	.word	04144H,337,954,02EH
	.word	04040H,343,478,02BH
	.word	04040H,347,597,030H
	.word	04140H,350,525,027H
	.word	04140H,351,525,027H
	.word	04040H,352,626,01DH
	.word	04040H,353,735,030H
	.word	04140H,353,708,031H
	.word	04140H,356,409,01FH
	.word	04140H,358,775,01FH
	.word	04040H,358,552,02BH
	.word	04040H,372,807,033H
	.word	04040H,376,312,027H
	.word	04040H,376,610,023H
	.word	04040H,377,428,02BH
	.word	04140H,377,479,027H
	.word	04040H,377,735,030H
	.word	04140H,380,846,027H
	.word	04253H,381,948,034H
	.word	04040H,382,354,035H
	.word	04040H,383,497,02BH
	.word	04040H,384,847,030H
	.word	04140H,389,833,01DH
	.word	04040H,391,705,038H
	.word	04040H,391,769,038H
	.word	04240H,393,696,01FH
	.word	04040H,396,571,02BH
	.word	04243H,396,948,03AH
	.word	04040H,398,641,038H
	.word	04040H,398,833,038H
	.word	04144H,406,956,03CH
	.word	04243H,406,906,02DH
	.word	04040H,413,428,03DH
	.word	04040H,413,817,023H
	.word	04140H,415,767,027H
	.word	04040H,420,497,02BH
	.word	04040H,421,352,03EH
	.word	04040H,430,571,035H
	.word	04040H,457,800,030H
	.word	04040H,466,884,030H
	.word	04040H,468,562,03EH
	.word	04040H,484,770,030H
	.word	04040H,485,706,030H
	.word	0FFFFH	;End Marker
mount2BMOD:
	.word	406,240,15	;x size, y size, #blocks
	.long	mount2BLKS, tainHDRS, tainPALS
mount1BMOD:
	.word	509,961,91	;x size, y size, #blocks
	.long	mount1BLKS, tainHDRS, tainPALS
LECTHDRS:
	.word	88,126
	.long	03C18B39H
	.word	06080H
	.word	88,130
	.long	03C28D21H
	.word	06080H
	.word	120,31
	.long	03C39739H
	.word	06080H
	.word	116,5
	.long	03C3EDEDH
	.word	04000H
	.word	116,5
	.long	03C3F6FDH
	.word	04000H
	.word	116,5
	.long	03C4000DH
	.word	04000H
	.word	8,225
	.long	03C4091DH
	.word	04000H
PLAYRSELBLKS:
	.word	04041H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,126,01H
	.word	04046H,86,0,02H
	.word	04044H,86,101,03H
	.word	04043H,86,176,04H
	.word	04042H,86,251,05H
	.word	04045H,141,31,06H
	.word	04045H,201,31,06H
	.word	04056H,202,0,02H
	.word	04053H,205,176,04H
	.word	04052H,205,251,05H
	.word	04054H,205,101,03H
	.word	04045H,261,31,06H
	.word	04050H,319,126,01H
	.word	04051H,319,0,00H
	.word	0FFFFH	;End Marker
PLAYRSELBMOD:
	.word	407,256,15	;x size, y size, #blocks
	.long	PLAYRSELBLKS, LECTHDRS, LECTPALS
NNERHDRS:
	.word	40,77
	.long	03C4253DH
	.word	06580H
	.word	36,93
	.long	03C45D51H
	.word	04580H
	.word	36,97
	.long	03C47C49H
	.word	05580H
	.word	36,79
	.long	03C4BD77H
	.word	06580H
	.word	60,66
	.long	03C4ECE3H
	.word	04880H
	.word	160,141
	.long	03C50E4BH
	.word	05000H
	.word	60,78
	.long	03C6C6EBH
	.word	05280H
	.word	48,38
	.long	03C70D21H
	.word	06980H
	.word	48,61
	.long	03C726A5H
	.word	06880H
	.word	56,37
	.long	03C75065H
	.word	04080H
	.word	112,78
	.long	03C76D65H
	.word	05000H
	.word	96,67
	.long	03C81805H
	.word	05580H
	.word	84,37
	.long	03C88A89H
	.word	05080H
	.word	12,141
	.long	03C8C63AH
	.word	04000H
	.word	12,108
	.long	03C8E0AAH
	.word	04000H
	.word	12,148
	.long	03C8F4EAH
	.word	04000H
	.word	60,66
	.long	03C910AAH
	.word	05080H
WINNER1BLKS:
	.word	04040H	;flags
	.word	0,7 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04048H,1,2,01H
	.word	04049H,1,95,02H
	.word	04041H,1,179,03H
	.word	04045H,14,192,04H
	.word	04042H,35,80,05H
	.word	0404BH,36,2,06H
	.word	04041H,36,220,07H
	.word	04040H,40,4,08H
	.word	04046H,71,221,09H
	.word	0404DH,93,2,0AH
	.word	04044H,100,10,0BH
	.word	04047H,124,221,0CH
	.word	0404CH,194,80,0DH
	.word	04EH,205,2,0EH
	.word	04AH,205,110,0FH
	.word	0FFFFH	;End Marker
WINNER2BLKS:
	.word	05EH	;flags
	.word	0,1 ;x,y
	.word	0EH	;pal5,pal4,hdr13-0
	.word	05AH,0,109,0FH
	.word	04057H,9,220,0CH
	.word	0405CH,11,79,0DH
	.word	0405DH,12,1,0AH
	.word	04042H,23,79,05H
	.word	04143H,40,9,010H
	.word	04056H,90,220,09H
	.word	0405BH,121,1,06H
	.word	04050H,129,3,08H
	.word	04051H,133,219,07H
	.word	04055H,143,191,04H
	.word	04050H,177,6,00H
	.word	04058H,180,1,01H
	.word	04059H,180,94,02H
	.word	04051H,180,178,03H
	.word	0FFFFH	;End Marker
WINNER1BMOD:
	.word	217,256,16	;x size, y size, #blocks
	.long	WINNER1BLKS, NNERHDRS, NNERPALS
WINNER2BMOD:
	.word	217,256,16	;x size, y size, #blocks
	.long	WINNER2BLKS, NNERHDRS, NNERPALS
RSUSHDRS:
	.word	52,44
	.long	03C95937H
	.word	04000H
	.word	56,53
	.long	03C97CF7H
	.word	04000H
	.word	52,55
	.long	03C9AB57H
	.word	04000H
	.word	48,39
	.long	03C9D807H
	.word	04980H
	.word	28,25
	.long	03C9E247H
	.word	04580H
	.word	12,19
	.long	03C9E757H
	.word	04080H
	.word	16,28
	.long	03C9EAE7H
	.word	04080H
	.word	148,5
	.long	03C9F077H
	.word	04000H
	.word	148,5
	.long	03C9FC07H
	.word	04000H
	.word	116,25
	.long	03CA0797H
	.word	04000H
	.word	20,53
	.long	03CA34E7H
	.word	04080H
VSSCREENBLKS:
	.word	04040H	;flags
	.word	0,2 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,99,01H
	.word	04040H,0,152,01H
	.word	03C40H,0,205,02H
	.word	04040H,0,46,01H
	.word	04350H,0,14,03H
	.word	04350H,0,48,04H
	.word	04050H,8,196,05H
	.word	04350H,15,174,06H
	.word	04350H,18,148,04H
	.word	04340H,38,-2,06H
	.word	04340H,42,207,06H
	.word	04050H,43,137,05H
	.word	04040H,50,41,07H
	.word	04040H,51,2,00H
	.word	03C40H,51,205,02H
	.word	04040H,51,204,08H
	.word	04040H,88,224,09H
	.word	04040H,102,2,00H
	.word	03C40H,102,205,02H
	.word	04040H,153,2,00H
	.word	03C40H,153,205,02H
	.word	03C40H,169,204,02H
	.word	04040H,194,151,0AH
	.word	04040H,194,46,0AH
	.word	04040H,194,99,0AH
	.word	04350H,197,63,06H
	.word	04070H,198,205,05H
	.word	04040H,204,2,00H
	.word	04050H,204,224,09H
	.word	03C40H,204,205,02H
	.word	04040H,206,41,07H
	.word	04040H,207,204,08H
	.word	04040H,255,2,00H
	.word	03C40H,255,205,02H
	.word	04040H,306,2,00H
	.word	03C40H,306,205,02H
	.word	04340H,307,13,04H
	.word	04340H,314,207,03H
	.word	04340H,329,233,06H
	.word	04050H,350,152,01H
	.word	04050H,350,99,01H
	.word	04050H,350,46,01H
	.word	04040H,355,2,00H
	.word	03C40H,355,205,02H
	.word	04340H,374,120,06H
	.word	04350H,378,100,04H
	.word	0FFFFH	;End Marker
VSSCREENBMOD:
	.word	407,263,47	;x size, y size, #blocks
	.long	VSSCREENBLKS, RSUSHDRS, RSUSPALS
ORY1HDRS:
	.word	52,50
	.long	03CA4577H
	.word	04080H
	.word	40,3
	.long	03CA6E17H
	.word	05000H
	.word	16,28
	.long	03C9EAE7H
	.word	04080H
	.word	28,25
	.long	03C9E247H
	.word	04580H
	.word	4,4
	.long	03CA706FH
	.word	04000H
	.word	4,82
	.long	03CA70AFH
	.word	04000H
	.word	4,4
	.long	03CA75CFH
	.word	05000H
	.word	60,4
	.long	03CA761FH
	.word	05000H
	.word	60,4
	.long	03CA7ACFH
	.word	04000H
	.word	4,46
	.long	03CA7E8FH
	.word	05000H
	.word	4,3
	.long	03CA8227H
	.word	05000H
	.word	4,3
	.long	03CA8263H
	.word	04000H
	.word	4,3
	.long	03CA8293H
	.word	04000H
	.word	4,3
	.long	03CA82C3H
	.word	05000H
	.word	4,74
	.long	03CA82FFH
	.word	04000H
	.word	4,74
	.long	03CA879FH
	.word	05000H
	.word	4,4
	.long	03CA8D67H
	.word	05000H
	.word	4,4
	.long	03CA8DB7H
	.word	05000H
	.word	48,39
	.long	03C9D807H
	.word	04980H
	.word	4,82
	.long	03CA8E07H
	.word	05000H
STORY1BLKS:
	.word	03241H	;flags
	.word	0,49 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	03241H,0,99,00H
	.word	03241H,0,149,00H
	.word	03241H,15,199,00H
	.word	03241H,15,249,00H
	.word	04041H,37,102,01H
	.word	04041H,37,106,01H
	.word	03241H,37,-1,00H
	.word	04041H,49,106,01H
	.word	04041H,49,102,01H
	.word	03241H,50,149,00H
	.word	03241H,50,49,00H
	.word	03241H,50,99,00H
	.word	04042H,51,150,02H
	.word	04052H,61,157,03H
	.word	04041H,65,191,04H
	.word	04041H,65,195,05H
	.word	04041H,65,277,06H
	.word	03241H,65,281,00H
	.word	04041H,68,277,07H
	.word	04041H,68,191,08H
	.word	04643H,69,195,00H
	.word	04643H,69,227,00H
	.word	04052H,71,75,02H
	.word	03241H,87,-1,00H
	.word	04041H,89,57,09H
	.word	04041H,89,102,0AH
	.word	04041H,89,107,0BH
	.word	04041H,89,183,0CH
	.word	04041H,89,107,09H
	.word	04041H,89,137,09H
	.word	04041H,89,40,0DH
	.word	04041H,89,42,09H
	.word	04041H,91,183,01H
	.word	04041H,92,40,01H
	.word	04041H,94,89,09H
	.word	04041H,94,179,0CH
	.word	04041H,94,133,09H
	.word	04041H,94,46,09H
	.word	04041H,94,44,0DH
	.word	04041H,95,179,01H
	.word	04041H,97,44,01H
	.word	04041H,100,172,06H
	.word	03C41H,100,98,0EH
	.word	03C41H,100,53,0EH
	.word	04041H,100,49,04H
	.word	03241H,100,176,00H
	.word	04041H,104,172,07H
	.word	04041H,104,49,08H
	.word	04041H,114,179,01H
	.word	03241H,115,281,00H
	.word	04041H,118,183,01H
	.word	04643H,119,195,00H
	.word	04643H,119,227,00H
	.word	04041H,127,277,07H
	.word	04041H,127,191,08H
	.word	04041H,132,40,01H
	.word	04041H,137,44,01H
	.word	03241H,137,-1,00H
	.word	04041H,149,172,07H
	.word	03241H,150,176,00H
	.word	04041H,153,179,01H
	.word	04041H,156,183,01H
	.word	04041H,163,49,08H
	.word	03241H,165,281,00H
	.word	04643H,169,195,00H
	.word	04643H,169,227,00H
	.word	04041H,172,40,01H
	.word	04041H,177,44,01H
	.word	04041H,186,277,07H
	.word	04041H,186,191,08H
	.word	03241H,187,-1,00H
	.word	04041H,193,179,01H
	.word	04041H,196,183,01H
	.word	03241H,200,176,00H
	.word	04041H,207,172,07H
	.word	04041H,212,40,01H
	.word	03241H,215,281,00H
	.word	04041H,217,44,01H
	.word	04643H,219,195,00H
	.word	04643H,219,227,00H
	.word	04041H,222,49,08H
	.word	04041H,233,179,01H
	.word	04041H,235,183,01H
	.word	03241H,237,-1,00H
	.word	04041H,245,277,07H
	.word	04041H,245,191,08H
	.word	03241H,250,176,00H
	.word	04041H,252,40,01H
	.word	04041H,257,44,01H
	.word	03241H,265,281,00H
	.word	04041H,266,172,07H
	.word	04643H,269,195,00H
	.word	04643H,269,227,00H
	.word	04041H,273,179,01H
	.word	04041H,275,183,01H
	.word	04041H,281,49,08H
	.word	03241H,287,-1,00H
	.word	04041H,292,40,01H
	.word	04041H,296,44,01H
	.word	03241H,300,175,00H
	.word	04041H,304,277,07H
	.word	04041H,304,191,08H
	.word	04041H,313,179,01H
	.word	04041H,315,183,01H
	.word	03241H,315,281,00H
	.word	04643H,319,195,00H
	.word	04643H,319,227,00H
	.word	04041H,324,49,08H
	.word	04041H,325,172,07H
	.word	04041H,332,40,01H
	.word	04041H,336,44,01H
	.word	03241H,337,-1,00H
	.word	03241H,350,176,00H
	.word	04041H,352,179,01H
	.word	04041H,352,44,01H
	.word	04041H,355,183,01H
	.word	04041H,357,40,01H
	.word	04041H,359,191,08H
	.word	04041H,363,277,07H
	.word	03241H,365,281,00H
	.word	04643H,369,195,00H
	.word	04643H,369,227,00H
	.word	04041H,383,53,0FH
	.word	04041H,383,49,010H
	.word	04041H,383,98,0FH
	.word	04041H,383,172,011H
	.word	03241H,387,141,00H
	.word	03241H,387,91,00H
	.word	03241H,387,41,00H
	.word	04041H,390,44,0BH
	.word	04041H,391,88,09H
	.word	04041H,391,179,0AH
	.word	04041H,391,46,09H
	.word	04041H,391,133,09H
	.word	04041H,395,40,0BH
	.word	04052H,395,141,012H
	.word	04041H,396,58,09H
	.word	04041H,396,109,09H
	.word	04041H,396,107,0DH
	.word	04041H,396,103,0CH
	.word	04041H,396,183,0AH
	.word	04041H,396,138,09H
	.word	04041H,396,42,09H
	.word	04041H,398,103,01H
	.word	04041H,398,107,01H
	.word	03241H,415,281,00H
	.word	04041H,418,195,013H
	.word	04041H,418,191,010H
	.word	04041H,418,277,011H
	.word	03241H,422,231,00H
	.word	03241H,422,181,00H
	.word	04041H,434,103,01H
	.word	04041H,434,107,01H
	.word	03241H,437,131,00H
	.word	03241H,437,81,00H
	.word	03241H,437,31,00H
	.word	0FFFFH	;End Marker
STORY1BMOD:
	.word	489,332,157	;x size, y size, #blocks
	.long	STORY1BLKS, ORY1HDRS, ORY1PALS
ORY2HDRS:
	.word	52,50
	.long	03CA4577H
	.word	04080H
	.word	16,28
	.long	03C9EAE7H
	.word	04080H
	.word	4,46
	.long	03CA7E8FH
	.word	05000H
	.word	4,3
	.long	03CA8293H
	.word	04000H
	.word	4,3
	.long	03CA82C3H
	.word	05000H
	.word	40,3
	.long	03CA6E17H
	.word	05000H
	.word	4,4
	.long	03CA706FH
	.word	04000H
	.word	4,4
	.long	03CA75CFH
	.word	05000H
	.word	4,74
	.long	03CA82FFH
	.word	04000H
	.word	60,4
	.long	03CA761FH
	.word	05000H
	.word	60,4
	.long	03CA7ACFH
	.word	04000H
	.word	28,25
	.long	03C9E247H
	.word	04580H
	.word	4,3
	.long	03CA8227H
	.word	05000H
	.word	4,30
	.long	03CA946FH
	.word	05000H
	.word	4,3
	.long	03CA8263H
	.word	04000H
	.word	4,74
	.long	03CA879FH
	.word	05000H
	.word	4,4
	.long	03CA8DB7H
	.word	05000H
	.word	4,4
	.long	03CA8D67H
	.word	05000H
STORY2BLKS:
	.word	03241H	;flags
	.word	0,79 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	03241H,0,129,00H
	.word	03241H,0,179,00H
	.word	03241H,4,29,00H
	.word	03241H,4,229,00H
	.word	03241H,4,279,00H
	.word	04054H,25,124,01H
	.word	04041H,40,72,02H
	.word	04041H,40,118,02H
	.word	04041H,40,164,02H
	.word	04041H,40,210,02H
	.word	04041H,40,256,03H
	.word	04041H,40,70,04H
	.word	04041H,42,256,05H
	.word	04041H,43,70,05H
	.word	04041H,45,77,02H
	.word	04041H,45,123,02H
	.word	04041H,45,169,02H
	.word	04041H,45,207,02H
	.word	04041H,45,252,03H
	.word	04041H,45,74,04H
	.word	04041H,46,252,05H
	.word	04041H,47,74,05H
	.word	04041H,50,79,06H
	.word	04041H,50,246,07H
	.word	04041H,50,83,08H
	.word	04041H,50,157,08H
	.word	04041H,50,172,08H
	.word	04041H,54,246,09H
	.word	04041H,54,79,0AH
	.word	04044H,54,43,0BH
	.word	03241H,54,29,00H
	.word	03241H,54,250,00H
	.word	04041H,64,74,05H
	.word	04041H,66,252,05H
	.word	04041H,76,70,05H
	.word	04041H,77,256,05H
	.word	04041H,104,74,05H
	.word	03241H,104,29,00H
	.word	03241H,104,250,00H
	.word	04041H,106,252,05H
	.word	04041H,110,79,0AH
	.word	04041H,113,246,09H
	.word	04041H,115,70,0CH
	.word	04041H,115,41,0DH
	.word	04041H,116,258,02H
	.word	04041H,116,256,0EH
	.word	04041H,118,79,0AH
	.word	04041H,119,246,09H
	.word	04041H,120,70,03H
	.word	04041H,120,41,0DH
	.word	04041H,121,258,02H
	.word	04041H,121,256,04H
	.word	04041H,122,70,05H
	.word	04041H,124,256,05H
	.word	04041H,144,252,05H
	.word	04041H,144,74,05H
	.word	04041H,149,70,05H
	.word	04041H,149,256,05H
	.word	03241H,154,250,00H
	.word	03241H,154,29,00H
	.word	04044H,165,258,01H
	.word	04044H,175,284,0BH
	.word	04041H,177,83,0FH
	.word	04041H,177,156,0FH
	.word	04041H,177,172,0FH
	.word	04041H,177,246,010H
	.word	04041H,177,79,011H
	.word	03241H,181,200,00H
	.word	03241H,181,150,00H
	.word	03241H,181,100,00H
	.word	03241H,181,50,00H
	.word	04041H,184,77,02H
	.word	04041H,184,123,02H
	.word	04041H,184,169,02H
	.word	04041H,184,206,02H
	.word	04041H,184,252,0CH
	.word	04041H,184,74,0EH
	.word	04041H,189,72,02H
	.word	04041H,189,117,02H
	.word	04041H,189,162,02H
	.word	04041H,189,207,02H
	.word	04041H,189,211,02H
	.word	04041H,189,256,0CH
	.word	04041H,189,70,0EH
	.word	04041H,204,54,08H
	.word	04041H,204,128,08H
	.word	04041H,204,202,08H
	.word	04041H,204,212,08H
	.word	04041H,204,50,06H
	.word	04041H,204,285,07H
	.word	03241H,204,0,00H
	.word	03241H,204,289,00H
	.word	04041H,208,50,0AH
	.word	04041H,208,285,09H
	.word	04645H,208,104,00H
	.word	04645H,208,154,00H
	.word	04645H,208,204,00H
	.word	04645H,208,235,00H
	.word	04645H,208,54,00H
	.word	04645H,251,235,00H
	.word	04645H,254,154,00H
	.word	03241H,254,0,00H
	.word	03241H,254,289,00H
	.word	04645H,258,54,00H
	.word	04645H,258,104,00H
	.word	04645H,258,204,00H
	.word	04041H,267,50,0AH
	.word	04041H,267,285,09H
	.word	04645H,301,154,00H
	.word	04645H,301,235,00H
	.word	03241H,304,0,00H
	.word	03241H,304,289,00H
	.word	04645H,308,54,00H
	.word	04645H,308,104,00H
	.word	04645H,308,204,00H
	.word	04041H,326,50,0AH
	.word	04041H,326,285,09H
	.word	04041H,341,285,09H
	.word	04041H,342,50,0AH
	.word	04645H,351,104,00H
	.word	04645H,351,154,00H
	.word	04645H,351,204,00H
	.word	04645H,351,235,00H
	.word	04645H,351,54,00H
	.word	03241H,354,0,00H
	.word	03241H,354,289,00H
	.word	04041H,400,54,0FH
	.word	04041H,400,65,0FH
	.word	04041H,400,138,0FH
	.word	04041H,400,211,0FH
	.word	04041H,400,285,010H
	.word	04041H,400,50,011H
	.word	03241H,404,266,00H
	.word	03241H,404,216,00H
	.word	03241H,404,166,00H
	.word	03241H,404,116,00H
	.word	03241H,404,66,00H
	.word	03241H,404,16,00H
	.word	0FFFFH	;End Marker
STORY2BMOD:
	.word	456,339,139	;x size, y size, #blocks
	.long	STORY2BLKS, ORY2HDRS, ORY2PALS
ORY3HDRS:
	.word	52,50
	.long	03CA4577H
	.word	04080H
	.word	16,28
	.long	03C9EAE7H
	.word	04080H
	.word	4,46
	.long	03CA7E8FH
	.word	05000H
	.word	4,3
	.long	03CA8293H
	.word	04000H
	.word	4,3
	.long	03CA82C3H
	.word	05000H
	.word	40,3
	.long	03CA6E17H
	.word	05000H
	.word	4,4
	.long	03CA706FH
	.word	04000H
	.word	4,4
	.long	03CA75CFH
	.word	05000H
	.word	4,74
	.long	03CA82FFH
	.word	04000H
	.word	60,4
	.long	03CA761FH
	.word	05000H
	.word	60,4
	.long	03CA7ACFH
	.word	04000H
	.word	28,25
	.long	03C9E247H
	.word	04580H
	.word	124,163
	.long	03CA96C7H
	.word	06B80H
	.word	4,3
	.long	03CA8227H
	.word	05000H
	.word	4,30
	.long	03CA946FH
	.word	05000H
	.word	4,3
	.long	03CA8263H
	.word	04000H
	.word	4,74
	.long	03CA879FH
	.word	05000H
	.word	4,4
	.long	03CA8DB7H
	.word	05000H
	.word	4,4
	.long	03CA8D67H
	.word	05000H
STORY3BLKS:
	.word	03241H	;flags
	.word	0,79 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	03241H,0,129,00H
	.word	03241H,0,179,00H
	.word	03241H,4,29,00H
	.word	03241H,4,229,00H
	.word	03241H,4,279,00H
	.word	04053H,25,124,01H
	.word	04041H,40,72,02H
	.word	04041H,40,118,02H
	.word	04041H,40,164,02H
	.word	04041H,40,210,02H
	.word	04041H,40,256,03H
	.word	04041H,40,70,04H
	.word	04041H,42,256,05H
	.word	04041H,43,70,05H
	.word	04041H,45,77,02H
	.word	04041H,45,123,02H
	.word	04041H,45,169,02H
	.word	04041H,45,207,02H
	.word	04041H,45,252,03H
	.word	04041H,45,74,04H
	.word	04041H,46,252,05H
	.word	04041H,47,74,05H
	.word	04041H,50,79,06H
	.word	04041H,50,246,07H
	.word	04041H,50,83,08H
	.word	04041H,50,157,08H
	.word	04041H,50,172,08H
	.word	04041H,54,246,09H
	.word	04041H,54,79,0AH
	.word	04043H,54,43,0BH
	.word	03241H,54,29,00H
	.word	03241H,54,250,00H
	.word	04040H,54,83,0CH
	.word	04041H,64,74,05H
	.word	04041H,66,252,05H
	.word	04041H,76,70,05H
	.word	04041H,77,256,05H
	.word	04041H,104,74,05H
	.word	03241H,104,29,00H
	.word	03241H,104,250,00H
	.word	04041H,106,252,05H
	.word	04041H,110,79,0AH
	.word	04041H,113,246,09H
	.word	04041H,115,70,0DH
	.word	04041H,115,41,0EH
	.word	04041H,116,258,02H
	.word	04041H,116,256,0FH
	.word	04041H,118,79,0AH
	.word	04041H,119,246,09H
	.word	04041H,120,70,03H
	.word	04041H,120,41,0EH
	.word	04041H,121,258,02H
	.word	04041H,121,256,04H
	.word	04041H,122,70,05H
	.word	04041H,124,256,05H
	.word	04041H,144,252,05H
	.word	04041H,144,74,05H
	.word	04041H,149,70,05H
	.word	04041H,149,256,05H
	.word	03241H,154,250,00H
	.word	03241H,154,29,00H
	.word	04043H,165,258,01H
	.word	04043H,175,284,0BH
	.word	04041H,177,83,010H
	.word	04041H,177,156,010H
	.word	04041H,177,172,010H
	.word	04041H,177,246,011H
	.word	04041H,177,79,012H
	.word	03241H,181,200,00H
	.word	03241H,181,150,00H
	.word	03241H,181,100,00H
	.word	03241H,181,50,00H
	.word	04041H,184,77,02H
	.word	04041H,184,123,02H
	.word	04041H,184,169,02H
	.word	04041H,184,206,02H
	.word	04041H,184,252,0DH
	.word	04041H,184,74,0FH
	.word	04041H,189,72,02H
	.word	04041H,189,117,02H
	.word	04041H,189,162,02H
	.word	04041H,189,207,02H
	.word	04041H,189,211,02H
	.word	04041H,189,256,0DH
	.word	04041H,189,70,0FH
	.word	04041H,204,54,08H
	.word	04041H,204,128,08H
	.word	04041H,204,202,08H
	.word	04041H,204,212,08H
	.word	04041H,204,50,06H
	.word	04041H,204,285,07H
	.word	03241H,204,0,00H
	.word	03241H,204,289,00H
	.word	04041H,208,50,0AH
	.word	04041H,208,285,09H
	.word	04642H,208,104,00H
	.word	04642H,208,154,00H
	.word	04642H,208,204,00H
	.word	04642H,208,235,00H
	.word	04642H,208,54,00H
	.word	04642H,251,235,00H
	.word	04642H,254,154,00H
	.word	03241H,254,0,00H
	.word	03241H,254,289,00H
	.word	04642H,258,54,00H
	.word	04642H,258,104,00H
	.word	04642H,258,204,00H
	.word	04041H,267,50,0AH
	.word	04041H,267,285,09H
	.word	04642H,301,154,00H
	.word	04642H,301,235,00H
	.word	03241H,304,0,00H
	.word	03241H,304,289,00H
	.word	04642H,308,54,00H
	.word	04642H,308,104,00H
	.word	04642H,308,204,00H
	.word	04041H,326,50,0AH
	.word	04041H,326,285,09H
	.word	04041H,341,285,09H
	.word	04041H,342,50,0AH
	.word	04642H,351,104,00H
	.word	04642H,351,154,00H
	.word	04642H,351,204,00H
	.word	04642H,351,235,00H
	.word	04642H,351,54,00H
	.word	03241H,354,0,00H
	.word	03241H,354,289,00H
	.word	04041H,400,54,010H
	.word	04041H,400,65,010H
	.word	04041H,400,138,010H
	.word	04041H,400,211,010H
	.word	04041H,400,285,011H
	.word	04041H,400,50,012H
	.word	03241H,404,266,00H
	.word	03241H,404,216,00H
	.word	03241H,404,166,00H
	.word	03241H,404,116,00H
	.word	03241H,404,66,00H
	.word	03241H,404,16,00H
	.word	0FFFFH	;End Marker
STORY3BMOD:
	.word	456,339,140	;x size, y size, #blocks
	.long	STORY3BLKS, ORY3HDRS, ORY3PALS
X1HDRS:
	.word	52,50
	.long	03CA4577H
	.word	04080H
	.word	4,56
	.long	03CBE927H
	.word	04000H
	.word	4,4
	.long	03CA75CFH
	.word	05000H
	.word	4,4
	.long	03CA706FH
	.word	04000H
	.word	48,57
	.long	03CBECA7H
	.word	04000H
	.word	28,25
	.long	03C9E247H
	.word	04580H
	.word	60,4
	.long	03CA7ACFH
	.word	04000H
	.word	60,4
	.long	03CA761FH
	.word	05000H
	.word	16,28
	.long	03C9EAE7H
	.word	04080H
	.word	4,74
	.long	03CA82FFH
	.word	04000H
	.word	88,173
	.long	03CC1767H
	.word	0A80H
	.word	80,132
	.long	03CD3B8FH
	.word	0A80H
	.word	36,72
	.long	03CDBD4FH
	.word	0180H
	.word	40,134
	.long	03CDEDBFH
	.word	0180H
	.word	96,142
	.long	03CE5F7FH
	.word	0880H
	.word	4,74
	.long	03CA879FH
	.word	05000H
	.word	4,4
	.long	03CA8DB7H
	.word	05000H
	.word	4,4
	.long	03CA8D67H
	.word	05000H
	.word	4,56
	.long	03CF901FH
	.word	05000H
ATRXMOD1BLKS:
	.word	03241H	;flags
	.word	0,279 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	03241H,0,229,00H
	.word	03241H,20,184,00H
	.word	03241H,20,134,00H
	.word	03241H,20,84,00H
	.word	03241H,20,34,00H
	.word	04041H,40,238,01H
	.word	04041H,40,294,02H
	.word	04041H,40,234,03H
	.word	04040H,43,237,04H
	.word	04052H,43,179,05H
	.word	04041H,44,234,06H
	.word	04041H,44,294,07H
	.word	03241H,50,298,00H
	.word	04052H,56,38,08H
	.word	03C41H,70,52,09H
	.word	03C41H,70,83,09H
	.word	03C41H,70,157,09H
	.word	04041H,70,230,02H
	.word	04041H,70,49,03H
	.word	03241H,70,-1,00H
	.word	04041H,73,49,06H
	.word	04041H,74,230,07H
	.word	04044H,74,57,0AH
	.word	04040H,90,237,04H
	.word	03241H,100,298,00H
	.word	04041H,103,234,06H
	.word	04041H,103,294,07H
	.word	03241H,120,-1,00H
	.word	04041H,125,230,07H
	.word	04041H,131,49,06H
	.word	04040H,137,237,04H
	.word	03241H,150,298,00H
	.word	04044H,159,98,0BH
	.word	04041H,162,234,06H
	.word	04041H,162,294,07H
	.word	03241H,170,-1,00H
	.word	04041H,184,230,07H
	.word	04040H,184,237,04H
	.word	04045H,185,158,0CH
	.word	04041H,190,49,06H
	.word	03241H,200,298,00H
	.word	04045H,218,96,0DH
	.word	03241H,220,-1,00H
	.word	04041H,221,234,06H
	.word	04041H,221,294,07H
	.word	04040H,231,237,04H
	.word	04041H,243,230,07H
	.word	04041H,249,49,06H
	.word	03241H,250,298,00H
	.word	04045H,258,88,0EH
	.word	03241H,270,-1,00H
	.word	04040H,278,237,04H
	.word	04041H,280,234,06H
	.word	04041H,280,294,07H
	.word	03241H,300,298,00H
	.word	04041H,302,230,07H
	.word	04041H,302,49,06H
	.word	03241H,320,-1,00H
	.word	04040H,325,237,04H
	.word	04041H,333,234,06H
	.word	04041H,334,294,07H
	.word	04040H,344,237,04H
	.word	03241H,350,297,00H
	.word	04041H,361,156,0FH
	.word	04041H,361,82,0FH
	.word	04041H,361,52,0FH
	.word	04041H,361,230,010H
	.word	04041H,361,49,011H
	.word	04052H,362,53,05H
	.word	04042H,364,196,08H
	.word	03241H,365,134,00H
	.word	03241H,365,84,00H
	.word	03241H,365,34,00H
	.word	03241H,365,184,00H
	.word	04041H,392,234,011H
	.word	04041H,392,238,012H
	.word	04041H,392,294,010H
	.word	03241H,396,234,00H
	.word	03241H,396,284,00H
	.word	0FFFFH	;End Marker
ATRXMOD1BMOD:
	.word	448,349,80	;x size, y size, #blocks
	.long	ATRXMOD1BLKS, X1HDRS, X1PALS
X2HDRS:
	.word	52,50
	.long	03CA4577H
	.word	04080H
	.word	4,56
	.long	03CBE927H
	.word	04000H
	.word	4,4
	.long	03CA75CFH
	.word	05000H
	.word	4,4
	.long	03CA706FH
	.word	04000H
	.word	48,57
	.long	03CBECA7H
	.word	04000H
	.word	28,25
	.long	03C9E247H
	.word	04580H
	.word	60,4
	.long	03CA7ACFH
	.word	04000H
	.word	60,4
	.long	03CA761FH
	.word	05000H
	.word	16,28
	.long	03C9EAE7H
	.word	04080H
	.word	4,74
	.long	03CA82FFH
	.word	04000H
	.word	80,165
	.long	03CF947FH
	.word	0980H
	.word	36,41
	.long	03D0A5E7H
	.word	0480H
	.word	112,69
	.long	03D0C68FH
	.word	07D80H
	.word	76,113
	.long	03D12BDDH
	.word	07680H
	.word	4,74
	.long	03CA879FH
	.word	05000H
	.word	4,4
	.long	03CA8DB7H
	.word	05000H
	.word	4,4
	.long	03CA8D67H
	.word	05000H
	.word	4,56
	.long	03CF901FH
	.word	05000H
ATRXMOD2BLKS:
	.word	03241H	;flags
	.word	0,279 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	03241H,0,229,00H
	.word	03241H,20,184,00H
	.word	03241H,20,134,00H
	.word	03241H,20,84,00H
	.word	03241H,20,34,00H
	.word	04041H,40,238,01H
	.word	04041H,40,294,02H
	.word	04041H,40,234,03H
	.word	04040H,43,237,04H
	.word	04052H,43,179,05H
	.word	04041H,44,234,06H
	.word	04041H,44,294,07H
	.word	03241H,50,298,00H
	.word	04052H,56,38,08H
	.word	03C41H,70,52,09H
	.word	03C41H,70,83,09H
	.word	03C41H,70,157,09H
	.word	04041H,70,230,02H
	.word	04041H,70,49,03H
	.word	03241H,70,-1,00H
	.word	04041H,73,49,06H
	.word	04041H,74,230,07H
	.word	04043H,81,65,0AH
	.word	04040H,90,237,04H
	.word	03241H,100,298,00H
	.word	04041H,103,234,06H
	.word	04041H,103,294,07H
	.word	03241H,120,-1,00H
	.word	04041H,125,230,07H
	.word	04041H,131,49,06H
	.word	04040H,137,237,04H
	.word	03241H,150,298,00H
	.word	04043H,150,107,0BH
	.word	04041H,162,234,06H
	.word	04041H,162,294,07H
	.word	03241H,170,-1,00H
	.word	04041H,184,230,07H
	.word	04040H,184,237,04H
	.word	04041H,190,49,06H
	.word	03241H,200,298,00H
	.word	03241H,220,-1,00H
	.word	04041H,221,234,06H
	.word	04041H,221,294,07H
	.word	04044H,226,100,0CH
	.word	04040H,231,237,04H
	.word	04041H,243,230,07H
	.word	04041H,249,49,06H
	.word	03241H,250,298,00H
	.word	03241H,270,-1,00H
	.word	04040H,278,237,04H
	.word	04041H,280,234,06H
	.word	04041H,280,294,07H
	.word	04045H,286,112,0DH
	.word	03241H,300,298,00H
	.word	04041H,302,230,07H
	.word	04041H,302,49,06H
	.word	03241H,320,-1,00H
	.word	04040H,325,237,04H
	.word	04041H,333,234,06H
	.word	04041H,334,294,07H
	.word	04040H,344,237,04H
	.word	03241H,350,297,00H
	.word	04041H,361,156,0EH
	.word	04041H,361,82,0EH
	.word	04041H,361,52,0EH
	.word	04041H,361,230,0FH
	.word	04041H,361,49,010H
	.word	04052H,362,53,05H
	.word	04042H,364,196,08H
	.word	03241H,365,134,00H
	.word	03241H,365,84,00H
	.word	03241H,365,34,00H
	.word	03241H,365,184,00H
	.word	04041H,392,234,010H
	.word	04041H,392,238,011H
	.word	04041H,392,294,0FH
	.word	03241H,396,234,00H
	.word	03241H,396,284,00H
	.word	0FFFFH	;End Marker
ATRXMOD2BMOD:
	.word	448,349,79	;x size, y size, #blocks
	.long	ATRXMOD2BLKS, X2HDRS, X2PALS
X3HDRS:
	.word	52,50
	.long	03CA4577H
	.word	04080H
	.word	4,56
	.long	03CBE927H
	.word	04000H
	.word	4,4
	.long	03CA75CFH
	.word	05000H
	.word	4,4
	.long	03CA706FH
	.word	04000H
	.word	48,57
	.long	03CBECA7H
	.word	04000H
	.word	28,25
	.long	03C9E247H
	.word	04580H
	.word	60,4
	.long	03CA7ACFH
	.word	04000H
	.word	60,4
	.long	03CA761FH
	.word	05000H
	.word	16,28
	.long	03C9EAE7H
	.word	04080H
	.word	4,74
	.long	03CA82FFH
	.word	04000H
	.word	4,74
	.long	03CA879FH
	.word	05000H
	.word	4,4
	.long	03CA8DB7H
	.word	05000H
	.word	4,4
	.long	03CA8D67H
	.word	05000H
	.word	4,56
	.long	03CF901FH
	.word	05000H
ATRXMOD3BLKS:
	.word	03241H	;flags
	.word	0,279 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	03241H,0,229,00H
	.word	03241H,20,184,00H
	.word	03241H,20,134,00H
	.word	03241H,20,84,00H
	.word	03241H,20,34,00H
	.word	04041H,40,238,01H
	.word	04041H,40,294,02H
	.word	04041H,40,234,03H
	.word	04040H,43,237,04H
	.word	04052H,43,179,05H
	.word	04041H,44,234,06H
	.word	04041H,44,294,07H
	.word	03241H,50,298,00H
	.word	04052H,56,38,08H
	.word	03C41H,70,52,09H
	.word	03C41H,70,83,09H
	.word	03C41H,70,157,09H
	.word	04041H,70,230,02H
	.word	04041H,70,49,03H
	.word	03241H,70,-1,00H
	.word	04041H,73,49,06H
	.word	04041H,74,230,07H
	.word	04040H,90,237,04H
	.word	03241H,100,298,00H
	.word	04041H,103,234,06H
	.word	04041H,103,294,07H
	.word	03241H,120,-1,00H
	.word	04041H,125,230,07H
	.word	04041H,131,49,06H
	.word	04040H,137,237,04H
	.word	03241H,150,298,00H
	.word	04041H,162,234,06H
	.word	04041H,162,294,07H
	.word	03241H,170,-1,00H
	.word	04041H,184,230,07H
	.word	04040H,184,237,04H
	.word	04041H,190,49,06H
	.word	03241H,200,298,00H
	.word	03241H,220,-1,00H
	.word	04041H,221,234,06H
	.word	04041H,221,294,07H
	.word	04040H,231,237,04H
	.word	04041H,243,230,07H
	.word	04041H,249,49,06H
	.word	03241H,250,298,00H
	.word	03241H,270,-1,00H
	.word	04040H,278,237,04H
	.word	04041H,280,234,06H
	.word	04041H,280,294,07H
	.word	03241H,300,298,00H
	.word	04041H,302,230,07H
	.word	04041H,302,49,06H
	.word	03241H,320,-1,00H
	.word	04040H,325,237,04H
	.word	04041H,333,234,06H
	.word	04041H,334,294,07H
	.word	04040H,344,237,04H
	.word	03241H,350,297,00H
	.word	04041H,361,156,0AH
	.word	04041H,361,82,0AH
	.word	04041H,361,52,0AH
	.word	04041H,361,230,0BH
	.word	04041H,361,49,0CH
	.word	04052H,362,53,05H
	.word	04042H,364,196,08H
	.word	03241H,365,134,00H
	.word	03241H,365,84,00H
	.word	03241H,365,34,00H
	.word	03241H,365,184,00H
	.word	04041H,392,234,0CH
	.word	04041H,392,238,0DH
	.word	04041H,392,294,0BH
	.word	03241H,396,234,00H
	.word	03241H,396,284,00H
	.word	0FFFFH	;End Marker
ATRXMOD3BMOD:
	.word	448,349,75	;x size, y size, #blocks
	.long	ATRXMOD3BLKS, X3HDRS, X3PALS
X4HDRS:
	.word	52,50
	.long	03CA4577H
	.word	04080H
	.word	4,56
	.long	03CBE927H
	.word	04000H
	.word	4,4
	.long	03CA75CFH
	.word	05000H
	.word	4,4
	.long	03CA706FH
	.word	04000H
	.word	48,57
	.long	03CBECA7H
	.word	04000H
	.word	28,25
	.long	03C9E247H
	.word	04580H
	.word	60,4
	.long	03CA7ACFH
	.word	04000H
	.word	60,4
	.long	03CA761FH
	.word	05000H
	.word	16,28
	.long	03C9EAE7H
	.word	04080H
	.word	4,74
	.long	03CA82FFH
	.word	04000H
	.word	164,175
	.long	03D1A435H
	.word	0A80H
	.word	4,74
	.long	03CA879FH
	.word	05000H
	.word	4,4
	.long	03CA8DB7H
	.word	05000H
	.word	4,4
	.long	03CA8D67H
	.word	05000H
	.word	4,56
	.long	03CF901FH
	.word	05000H
ATRXMOD4BLKS:
	.word	03241H	;flags
	.word	0,279 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	03241H,0,229,00H
	.word	03241H,20,184,00H
	.word	03241H,20,134,00H
	.word	03241H,20,84,00H
	.word	03241H,20,34,00H
	.word	04041H,40,238,01H
	.word	04041H,40,294,02H
	.word	04041H,40,234,03H
	.word	04040H,43,237,04H
	.word	04052H,43,179,05H
	.word	04041H,44,234,06H
	.word	04041H,44,294,07H
	.word	03241H,50,298,00H
	.word	04052H,56,38,08H
	.word	03C41H,70,52,09H
	.word	03C41H,70,83,09H
	.word	03C41H,70,157,09H
	.word	04041H,70,230,02H
	.word	04041H,70,49,03H
	.word	03241H,70,-1,00H
	.word	04041H,73,49,06H
	.word	04041H,74,230,07H
	.word	04040H,90,237,04H
	.word	03241H,100,298,00H
	.word	04041H,103,234,06H
	.word	04041H,103,294,07H
	.word	03241H,120,-1,00H
	.word	04041H,125,230,07H
	.word	04041H,131,49,06H
	.word	04040H,137,237,04H
	.word	04043H,139,55,0AH
	.word	03241H,150,298,00H
	.word	04041H,162,234,06H
	.word	04041H,162,294,07H
	.word	03241H,170,-1,00H
	.word	04041H,184,230,07H
	.word	04040H,184,237,04H
	.word	04041H,190,49,06H
	.word	03241H,200,298,00H
	.word	03241H,220,-1,00H
	.word	04041H,221,234,06H
	.word	04041H,221,294,07H
	.word	04040H,231,237,04H
	.word	04041H,243,230,07H
	.word	04041H,249,49,06H
	.word	03241H,250,298,00H
	.word	03241H,270,-1,00H
	.word	04040H,278,237,04H
	.word	04041H,280,234,06H
	.word	04041H,280,294,07H
	.word	03241H,300,298,00H
	.word	04041H,302,230,07H
	.word	04041H,302,49,06H
	.word	03241H,320,-1,00H
	.word	04040H,325,237,04H
	.word	04041H,333,234,06H
	.word	04041H,334,294,07H
	.word	04040H,344,237,04H
	.word	03241H,350,297,00H
	.word	04041H,361,156,0BH
	.word	04041H,361,82,0BH
	.word	04041H,361,52,0BH
	.word	04041H,361,230,0CH
	.word	04041H,361,49,0DH
	.word	04052H,362,53,05H
	.word	04042H,364,196,08H
	.word	03241H,365,134,00H
	.word	03241H,365,84,00H
	.word	03241H,365,34,00H
	.word	03241H,365,184,00H
	.word	04041H,392,234,0DH
	.word	04041H,392,238,0EH
	.word	04041H,392,294,0CH
	.word	03241H,396,234,00H
	.word	03241H,396,284,00H
	.word	0FFFFH	;End Marker
ATRXMOD4BMOD:
	.word	448,349,76	;x size, y size, #blocks
	.long	ATRXMOD4BLKS, X4HDRS, X4PALS
fu7HDRS:
	.word	52,10
	.long	03D3E20DH
	.word	06000H
	.word	144,11
	.long	03D3EE3DH
	.word	04000H
	.word	40,49
	.long	03D406FDH
	.word	06000H
	.word	144,5
	.long	03D434EDH
	.word	04000H
	.word	60,50
	.long	03D4402DH
	.word	06580H
	.word	36,50
	.long	03D47529H
	.word	06080H
	.word	144,14
	.long	03D49D4DH
	.word	05000H
	.word	144,16
	.long	03D4C4ADH
	.word	05000H
	.word	144,11
	.long	03D4F1ADH
	.word	05000H
	.word	144,19
	.long	03D5109DH
	.word	05000H
	.word	144,18
	.long	03D5460DH
	.word	04000H
	.word	84,17
	.long	03D56E8DH
	.word	05080H
	.word	60,21
	.long	03D589FAH
	.word	06580H
	.word	12,100
	.long	03D59E22H
	.word	06000H
	.word	84,100
	.long	03D5BA42H
	.word	07080H
	.word	84,100
	.long	03D69ADEH
	.word	06080H
	.word	84,100
	.long	03D75BD6H
	.word	07080H
	.word	56,23
	.long	03D83C72H
	.word	06A80H
	.word	36,53
	.long	03D849D2H
	.word	06080H
	.word	32,44
	.long	03D86E9CH
	.word	06080H
	.word	48,33
	.long	03D88E5CH
	.word	06280H
	.word	76,28
	.long	03D8AF74H
	.word	06000H
	.word	36,42
	.long	03D8E154H
	.word	06080H
	.word	48,21
	.long	03D90254H
	.word	06180H
	.word	64,11
	.long	03D91346H
	.word	06080H
	.word	4,17
	.long	03D9239AH
	.word	00H
	.word	168,25
	.long	03D925BAH
	.word	06000H
	.word	36,14
	.long	03D9882AH
	.word	06580H
	.word	40,13
	.long	03D98D62H
	.word	04280H
	.word	36,22
	.long	03D99336H
	.word	06080H
	.word	92,17
	.long	03D9A17EH
	.word	05000H
	.word	52,9
	.long	03D9C00AH
	.word	05000H
	.word	24,60
	.long	03D9C92EH
	.word	06080H
	.word	20,17
	.long	03D9E7CAH
	.word	06080H
	.word	16,12
	.long	03D9EFAEH
	.word	06080H
	.word	32,14
	.long	03D9F2DEH
	.word	06580H
	.word	16,21
	.long	03D9F756H
	.word	06080H
	.word	8,12
	.long	03D9FCEAH
	.word	06000H
	.word	16,15
	.long	03D9FF2AH
	.word	06080H
	.word	32,27
	.long	03DA0326H
	.word	06080H
	.word	32,23
	.long	03DA1490H
	.word	06080H
	.word	16,21
	.long	03DA20B8H
	.word	06080H
	.word	28,68
	.long	03DA278AH
	.word	06480H
	.word	24,22
	.long	03DA4882H
	.word	06580H
	.word	8,7
	.long	03DA4E5AH
	.word	05000H
	.word	20,20
	.long	03DA4F72H
	.word	06080H
	.word	16,15
	.long	03DA54E6H
	.word	06080H
	.word	20,100
	.long	03DA58E2H
	.word	06080H
	.word	16,100
	.long	03DA83DAH
	.word	06000H
dun1BLKS:
	.word	04044H	;flags
	.word	0,5 ;x,y
	.word	09H	;pal5,pal4,hdr13-0
	.word	04143H,112,7,0CH
	.word	04044H,143,5,09H
	.word	04153H,278,8,011H
	.word	04044H,286,5,09H
	.word	04044H,429,5,09H
	.word	04143H,510,8,01DH
	.word	04143H,557,5,0CH
	.word	04044H,572,5,09H
	.word	04143H,616,12,01FH
	.word	04143H,639,9,011H
	.word	04044H,715,5,09H
	.word	04044H,858,5,09H
	.word	04153H,910,8,0CH
	.word	04153H,972,9,01DH
	.word	04044H,1001,5,09H
	.word	0FFFFH	;End Marker
dun2BLKS:
	.word	04044H	;flags
	.word	0,6 ;x,y
	.word	07H	;pal5,pal4,hdr13-0
	.word	04044H,143,6,07H
	.word	04044H,286,6,07H
	.word	04044H,429,6,07H
	.word	04044H,572,6,07H
	.word	04044H,715,6,07H
	.word	04044H,858,6,07H
	.word	04044H,1001,6,07H
	.word	0FFFFH	;End Marker
dun3BLKS:
	.word	04044H	;flags
	.word	0,7 ;x,y
	.word	06H	;pal5,pal4,hdr13-0
	.word	04044H,143,7,06H
	.word	04044H,286,7,06H
	.word	04044H,429,7,06H
	.word	04044H,572,7,06H
	.word	04044H,715,7,06H
	.word	04044H,858,7,06H
	.word	04044H,1001,7,06H
	.word	0FFFFH	;End Marker
dun4BLKS:
	.word	04044H	;flags
	.word	0,325 ;x,y
	.word	08H	;pal5,pal4,hdr13-0
	.word	04142H,72,312,0BH
	.word	04045H,121,212,0DH
	.word	04045H,130,12,0EH
	.word	04045H,133,212,0FH
	.word	04045H,133,112,0EH
	.word	04044H,143,325,08H
	.word	04142H,153,312,0BH
	.word	04045H,211,12,0EH
	.word	04046H,214,212,010H
	.word	04045H,214,112,0EH
	.word	04142H,234,312,0BH
	.word	04155H,284,259,012H
	.word	04044H,286,325,08H
	.word	04045H,292,12,0EH
	.word	04045H,292,215,013H
	.word	04045H,294,140,014H
	.word	04045H,295,113,015H
	.word	04045H,295,173,016H
	.word	04153H,311,314,017H
	.word	04055H,314,112,018H
	.word	04052H,314,311,019H
	.word	04045H,371,116,01AH
	.word	04045H,373,12,0EH
	.word	04055H,376,112,018H
	.word	04143H,415,320,01BH
	.word	04044H,429,325,08H
	.word	04055H,439,112,018H
	.word	04045H,454,12,0EH
	.word	04143H,461,319,01CH
	.word	04055H,488,111,018H
	.word	04055H,511,112,018H
	.word	04045H,535,12,0EH
	.word	04055H,535,113,015H
	.word	04055H,562,140,014H
	.word	04044H,572,325,08H
	.word	04055H,576,173,016H
	.word	04055H,585,215,013H
	.word	04145H,590,259,012H
	.word	04042H,596,311,019H
	.word	04042H,600,312,01EH
	.word	04045H,606,212,0FH
	.word	04045H,606,112,0EH
	.word	04045H,616,12,0EH
	.word	04150H,632,116,020H
	.word	04343H,635,116,021H
	.word	04343H,650,133,022H
	.word	04243H,651,321,023H
	.word	04343H,658,145,024H
	.word	04343H,669,166,025H
	.word	04343H,676,175,026H
	.word	04045H,687,212,0FH
	.word	04045H,687,112,0EH
	.word	04343H,690,183,027H
	.word	04343H,692,210,028H
	.word	04142H,692,312,01EH
	.word	04343H,693,162,029H
	.word	04343H,693,233,02AH
	.word	04045H,697,12,0EH
	.word	04044H,715,325,08H
	.word	04343H,719,167,02BH
	.word	04343H,719,289,02CH
	.word	04343H,738,147,02DH
	.word	04343H,747,132,02EH
	.word	04045H,751,212,02FH
	.word	04353H,752,116,021H
	.word	04140H,752,116,020H
	.word	04155H,756,259,012H
	.word	04045H,765,215,013H
	.word	04045H,768,112,030H
	.word	04045H,769,173,016H
	.word	04045H,770,141,014H
	.word	04045H,773,114,015H
	.word	04045H,778,12,0EH
	.word	04052H,784,312,019H
	.word	04055H,811,112,018H
	.word	04045H,848,116,01AH
	.word	04044H,858,325,08H
	.word	04045H,859,12,0EH
	.word	04055H,871,112,018H
	.word	04153H,883,323,01BH
	.word	04045H,935,112,018H
	.word	04045H,940,12,0EH
	.word	04143H,958,312,017H
	.word	04045H,973,111,018H
	.word	04044H,1001,325,08H
	.word	04055H,1016,113,015H
	.word	04045H,1021,13,0EH
	.word	04055H,1044,140,014H
	.word	04055H,1054,173,016H
	.word	04055H,1061,215,013H
	.word	04145H,1065,259,012H
	.word	04042H,1068,311,019H
	.word	04142H,1072,312,0BH
	.word	04046H,1086,212,010H
	.word	04045H,1090,113,0EH
	.word	04045H,1102,12,0EH
	.word	04044H,1144,325,08H
	.word	04142H,1153,312,0BH
	.word	04045H,1166,113,0EH
	.word	04046H,1167,212,010H
	.word	0FFFFH	;End Marker
dun5BLKS:
	.word	04044H	;flags
	.word	0,2 ;x,y
	.word	0AH	;pal5,pal4,hdr13-0
	.word	04044H,143,2,0AH
	.word	04044H,286,2,0AH
	.word	04044H,429,2,0AH
	.word	04044H,572,2,0AH
	.word	04044H,715,2,0AH
	.word	04044H,858,2,0AH
	.word	0FFFFH	;End Marker
dun8BLKS:
	.word	04044H	;flags
	.word	0,201 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	04041H,15,5,02H
	.word	04041H,15,54,02H
	.word	04041H,31,103,00H
	.word	04041H,55,5,02H
	.word	04041H,55,54,02H
	.word	04041H,79,103,04H
	.word	04041H,95,5,02H
	.word	04041H,95,54,02H
	.word	04041H,103,153,05H
	.word	04041H,135,5,02H
	.word	04041H,135,54,02H
	.word	04051H,139,103,04H
	.word	04051H,139,153,05H
	.word	04044H,143,201,01H
	.word	04041H,175,5,02H
	.word	04041H,175,54,02H
	.word	04041H,195,103,00H
	.word	04041H,215,5,02H
	.word	04041H,215,54,02H
	.word	04041H,247,103,00H
	.word	04041H,255,5,02H
	.word	04041H,255,54,02H
	.word	04044H,286,201,01H
	.word	04041H,295,5,02H
	.word	04041H,295,54,02H
	.word	04041H,299,103,00H
	.word	04041H,335,5,02H
	.word	04041H,335,54,02H
	.word	04041H,338,103,04H
	.word	04041H,363,153,05H
	.word	04041H,375,5,02H
	.word	04041H,375,54,02H
	.word	04051H,398,103,04H
	.word	04051H,399,153,05H
	.word	04041H,415,5,02H
	.word	04041H,415,54,02H
	.word	04044H,429,201,01H
	.word	04041H,451,102,00H
	.word	04041H,455,5,02H
	.word	04041H,455,54,02H
	.word	04041H,495,5,02H
	.word	04041H,495,54,02H
	.word	04041H,503,102,00H
	.word	04041H,535,5,02H
	.word	04041H,535,54,02H
	.word	04041H,555,102,00H
	.word	04044H,572,201,01H
	.word	04041H,575,5,02H
	.word	04041H,575,54,02H
	.word	04041H,592,103,04H
	.word	04041H,615,5,02H
	.word	04041H,615,54,02H
	.word	04041H,617,153,05H
	.word	04051H,652,103,04H
	.word	04051H,653,153,05H
	.word	04041H,655,5,02H
	.word	04041H,655,54,02H
	.word	04041H,695,5,02H
	.word	04041H,695,54,02H
	.word	04041H,708,103,00H
	.word	04044H,714,201,01H
	.word	04041H,735,5,02H
	.word	04041H,735,54,02H
	.word	0FFFFH	;End Marker
dun9BLKS:
	.word	04044H	;flags
	.word	0,12 ;x,y
	.word	03H	;pal5,pal4,hdr13-0
	.word	04044H,124,12,03H
	.word	04044H,267,12,03H
	.word	04044H,410,12,03H
	.word	04044H,553,12,03H
	.word	0FFFFH	;End Marker
dun10BLKS:
	.word	04054H	;flags
	.word	0,12 ;x,y
	.word	03H	;pal5,pal4,hdr13-0
	.word	04054H,143,12,03H
	.word	04054H,286,12,03H
	.word	04044H,430,12,03H
	.word	0FFFFH	;End Marker
dun1BMOD:
	.word	1145,27,16	;x size, y size, #blocks
	.long	dun1BLKS, fu7HDRS, fu7PALS
dun2BMOD:
	.word	1145,16,8	;x size, y size, #blocks
	.long	dun2BLKS, fu7HDRS, fu7PALS
dun3BMOD:
	.word	1145,14,8	;x size, y size, #blocks
	.long	dun3BLKS, fu7HDRS, fu7PALS
dun4BMOD:
	.word	1288,325,101	;x size, y size, #blocks
	.long	dun4BLKS, fu7HDRS, fu7PALS
dun5BMOD:
	.word	1002,18,7	;x size, y size, #blocks
	.long	dun5BLKS, fu7HDRS, fu7PALS
dun8BMOD:
	.word	858,207,64	;x size, y size, #blocks
	.long	dun8BLKS, fu7HDRS, fu7PALS
dun9BMOD:
	.word	697,5,5	;x size, y size, #blocks
	.long	dun9BLKS, fu7HDRS, fu7PALS
dun10BMOD:
	.word	574,5,4	;x size, y size, #blocks
	.long	dun10BLKS, fu7HDRS, fu7PALS
AMHDRS:
	.word	52,50
	.long	03CA4577H
	.word	04080H
	.word	28,25
	.long	03C9E247H
	.word	04580H
	.word	16,28
	.long	03C9EAE7H
	.word	04080H
	.word	4,4
	.long	03CA706FH
	.word	04000H
	.word	4,74
	.long	03CA82FFH
	.word	04000H
	.word	4,4
	.long	03CA75CFH
	.word	05000H
	.word	60,4
	.long	03CA7ACFH
	.word	04000H
	.word	88,116
	.long	03DAA95AH
	.word	080H
	.word	60,4
	.long	03CA761FH
	.word	05000H
	.word	88,116
	.long	03DBE85AH
	.word	080H
	.word	4,4
	.long	03CA8D67H
	.word	05000H
	.word	4,74
	.long	03CA879FH
	.word	05000H
	.word	4,4
	.long	03CA8DB7H
	.word	05000H
	.word	88,116
	.long	03DD275AH
	.word	080H
	.word	88,116
	.long	03DE665AH
	.word	080H
TEAMMOD1BLKS:
	.word	03241H	;flags
	.word	0,50 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	03241H,0,100,00H
	.word	03241H,0,150,00H
	.word	03241H,0,200,00H
	.word	03241H,0,250,00H
	.word	03241H,4,0,00H
	.word	03241H,13,298,00H
	.word	04643H,26,256,01H
	.word	04643H,36,31,02H
	.word	04041H,50,50,03H
	.word	04041H,50,54,04H
	.word	04041H,50,96,04H
	.word	04041H,50,170,05H
	.word	03241H,50,174,00H
	.word	04041H,50,178,04H
	.word	04041H,50,174,03H
	.word	04041H,50,294,05H
	.word	04041H,50,220,04H
	.word	04041H,54,50,06H
	.word	03241H,54,0,00H
	.word	04040H,54,54,07H
	.word	04041H,54,170,08H
	.word	04044H,54,178,09H
	.word	04041H,54,174,06H
	.word	04041H,54,294,08H
	.word	03241H,63,298,00H
	.word	04041H,82,170,08H
	.word	04041H,82,294,08H
	.word	04041H,83,50,06H
	.word	04041H,83,174,06H
	.word	03241H,99,174,00H
	.word	03241H,104,0,00H
	.word	03241H,113,298,00H
	.word	04041H,141,50,0AH
	.word	04041H,141,54,0BH
	.word	04041H,141,96,0BH
	.word	04041H,141,170,0CH
	.word	04041H,141,178,0BH
	.word	04041H,141,174,0AH
	.word	04041H,141,294,0CH
	.word	04041H,141,220,0BH
	.word	04643H,141,228,02H
	.word	04643H,144,83,01H
	.word	03241H,145,50,00H
	.word	03241H,145,100,00H
	.word	03241H,145,150,00H
	.word	03241H,145,200,00H
	.word	03241H,145,248,00H
	.word	03241H,154,0,00H
	.word	03241H,163,298,00H
	.word	03241H,195,50,00H
	.word	03241H,195,100,00H
	.word	03241H,195,150,00H
	.word	03241H,195,200,00H
	.word	03241H,195,248,00H
	.word	03241H,204,0,00H
	.word	03241H,213,298,00H
	.word	03241H,245,50,00H
	.word	03241H,245,100,00H
	.word	03241H,245,150,00H
	.word	03241H,245,200,00H
	.word	03241H,245,248,00H
	.word	03241H,254,0,00H
	.word	03241H,259,248,00H
	.word	03241H,259,200,00H
	.word	03241H,260,50,00H
	.word	03241H,260,150,00H
	.word	03241H,261,100,00H
	.word	03241H,263,298,00H
	.word	04653H,283,219,01H
	.word	03241H,304,0,00H
	.word	04041H,309,174,03H
	.word	04041H,309,178,04H
	.word	04041H,309,220,04H
	.word	04041H,309,294,05H
	.word	04041H,310,170,05H
	.word	04041H,310,96,04H
	.word	04041H,310,54,04H
	.word	04041H,310,50,03H
	.word	03241H,313,298,00H
	.word	04045H,313,178,0DH
	.word	04041H,313,174,06H
	.word	04041H,313,294,08H
	.word	04042H,314,54,0EH
	.word	04041H,314,170,08H
	.word	04041H,314,50,06H
	.word	04041H,341,50,06H
	.word	04041H,341,170,08H
	.word	04041H,341,294,08H
	.word	04041H,341,174,06H
	.word	03241H,354,0,00H
	.word	03241H,363,298,00H
	.word	04041H,400,50,0AH
	.word	04041H,400,54,0BH
	.word	04041H,400,170,0CH
	.word	04041H,400,96,0BH
	.word	04041H,400,294,0CH
	.word	04041H,400,220,0BH
	.word	04041H,400,178,0BH
	.word	04041H,400,174,0AH
	.word	04643H,403,96,02H
	.word	03241H,404,0,00H
	.word	03241H,404,50,00H
	.word	03241H,404,100,00H
	.word	03241H,404,150,00H
	.word	03241H,404,200,00H
	.word	03241H,404,250,00H
	.word	03241H,404,298,00H
	.word	0FFFFH	;End Marker
TEAMMOD1BMOD:
	.word	456,348,108	;x size, y size, #blocks
	.long	TEAMMOD1BLKS, AMHDRS, AMPALS
ORE1HDRS:
	.word	52,50
	.long	03CA4577H
	.word	04080H
	.word	4,3
	.long	03CA82C3H
	.word	05000H
	.word	4,46
	.long	03CA7E8FH
	.word	05000H
	.word	4,3
	.long	03CA8293H
	.word	04000H
	.word	4,4
	.long	03CA75CFH
	.word	05000H
	.word	4,4
	.long	03CA706FH
	.word	04000H
	.word	4,74
	.long	03CA82FFH
	.word	04000H
	.word	40,3
	.long	03CA6E17H
	.word	05000H
	.word	40,3
	.long	03CA6E17H
	.word	05000H
	.word	60,4
	.long	03CA761FH
	.word	05000H
	.word	60,4
	.long	03CA7ACFH
	.word	04000H
	.word	52,50
	.long	03CA4577H
	.word	04080H
	.word	4,4
	.long	03CA8D67H
	.word	05000H
	.word	4,4
	.long	03CA8DB7H
	.word	05000H
	.word	4,74
	.long	03CA879FH
	.word	05000H
	.word	4,3
	.long	03CA8263H
	.word	04000H
	.word	4,3
	.long	03CA8227H
	.word	05000H
HISCRMOD1BLKS:
	.word	04040H	;flags
	.word	0,153 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,103,00H
	.word	04040H,0,53,00H
	.word	04040H,0,203,00H
	.word	04040H,0,253,00H
	.word	04040H,0,3,00H
	.word	04840H,47,44,01H
	.word	04640H,47,47,02H
	.word	04640H,47,93,02H
	.word	04640H,47,139,02H
	.word	04640H,47,185,02H
	.word	04640H,47,231,02H
	.word	04640H,47,248,02H
	.word	04140H,47,294,03H
	.word	04040H,50,-1,00H
	.word	04640H,50,289,04H
	.word	04640H,50,48,05H
	.word	04240H,50,52,06H
	.word	04240H,50,126,06H
	.word	04240H,50,215,06H
	.word	04240H,50,200,06H
	.word	04840H,50,294,07H
	.word	04040H,50,293,00H
	.word	04840H,50,44,08H
	.word	04840H,54,289,09H
	.word	04240H,54,48,0AH
	.word	03D41H,54,52,0BH
	.word	03C41H,54,102,0BH
	.word	03C41H,54,152,0BH
	.word	03C41H,54,202,0BH
	.word	03C41H,54,239,0BH
	.word	04741H,57,52,0BH
	.word	03C41H,57,102,0BH
	.word	03C41H,57,152,0BH
	.word	03C41H,57,202,0BH
	.word	03C41H,57,239,0BH
	.word	04840H,90,44,08H
	.word	04840H,90,294,07H
	.word	04040H,100,-1,00H
	.word	04040H,100,293,00H
	.word	03D41H,107,52,0BH
	.word	03C41H,107,102,0BH
	.word	03C41H,107,152,0BH
	.word	03C41H,107,202,0BH
	.word	03C41H,107,239,0BH
	.word	04240H,112,48,0AH
	.word	04840H,113,289,09H
	.word	04840H,130,44,08H
	.word	04840H,130,294,07H
	.word	04040H,150,-1,00H
	.word	04040H,150,293,00H
	.word	04741H,157,52,0BH
	.word	04741H,157,102,0BH
	.word	03C41H,157,152,0BH
	.word	03C41H,157,202,0BH
	.word	03C41H,157,239,0BH
	.word	04840H,170,44,08H
	.word	04840H,170,294,07H
	.word	04240H,171,48,0AH
	.word	04840H,172,289,09H
	.word	04040H,200,-1,00H
	.word	04040H,200,293,00H
	.word	04741H,207,52,0BH
	.word	04741H,207,102,0BH
	.word	03C41H,207,152,0BH
	.word	03C41H,207,202,0BH
	.word	03C41H,207,239,0BH
	.word	04840H,210,44,08H
	.word	04840H,210,294,07H
	.word	04240H,230,48,0AH
	.word	04840H,231,289,09H
	.word	04040H,250,-1,00H
	.word	04840H,250,44,08H
	.word	04840H,250,294,07H
	.word	04040H,250,293,00H
	.word	04741H,257,52,0BH
	.word	04741H,257,102,0BH
	.word	03C41H,257,152,0BH
	.word	03C41H,257,202,0BH
	.word	03C41H,257,239,0BH
	.word	04840H,289,48,0AH
	.word	04840H,290,289,09H
	.word	04840H,290,44,08H
	.word	04840H,290,294,07H
	.word	04040H,300,-1,00H
	.word	04040H,300,293,00H
	.word	03C41H,307,52,0BH
	.word	04741H,307,102,0BH
	.word	03C41H,307,152,0BH
	.word	03C41H,307,202,0BH
	.word	03C41H,307,239,0BH
	.word	04840H,330,44,08H
	.word	04840H,330,294,07H
	.word	04840H,348,289,09H
	.word	04840H,348,48,0AH
	.word	04040H,350,-1,00H
	.word	04040H,350,293,00H
	.word	04741H,357,202,0BH
	.word	04741H,357,152,0BH
	.word	03D41H,357,102,0BH
	.word	04741H,357,239,0BH
	.word	03C41H,357,52,0BH
	.word	04840H,370,294,07H
	.word	04840H,370,44,08H
	.word	04840H,372,294,07H
	.word	04840H,372,44,08H
	.word	04040H,400,293,00H
	.word	04040H,400,2,00H
	.word	04640H,407,48,0CH
	.word	04840H,407,289,0DH
	.word	04840H,407,215,0EH
	.word	04840H,407,141,0EH
	.word	04840H,407,67,0EH
	.word	04840H,407,52,0EH
	.word	04040H,410,52,00H
	.word	04040H,410,102,00H
	.word	04040H,411,152,00H
	.word	04040H,411,202,00H
	.word	04040H,411,252,00H
	.word	04640H,412,47,02H
	.word	04840H,412,44,0FH
	.word	04640H,412,93,02H
	.word	04640H,412,139,02H
	.word	04640H,412,185,02H
	.word	04640H,412,231,02H
	.word	04640H,412,248,02H
	.word	04840H,412,294,010H
	.word	0FFFFH	;End Marker
HISCRMOD1BMOD:
	.word	463,344,127	;x size, y size, #blocks
	.long	HISCRMOD1BLKS, ORE1HDRS, ORE1PALS
T1HDRS:
	.word	52,50
	.long	03CA4577H
	.word	04080H
	.word	4,46
	.long	03CA7E8FH
	.word	05000H
	.word	4,3
	.long	03CA8293H
	.word	04000H
	.word	4,3
	.long	03CA82C3H
	.word	05000H
	.word	40,3
	.long	03CA6E17H
	.word	05000H
	.word	4,4
	.long	03CA706FH
	.word	04000H
	.word	4,74
	.long	03CA82FFH
	.word	04000H
	.word	4,4
	.long	03CA75CFH
	.word	05000H
	.word	60,4
	.long	03CA761FH
	.word	05000H
	.word	60,4
	.long	03CA7ACFH
	.word	04000H
	.word	4,4
	.long	03CA8D67H
	.word	05000H
	.word	4,74
	.long	03CA879FH
	.word	05000H
	.word	4,4
	.long	03CA8DB7H
	.word	05000H
	.word	4,3
	.long	03CA8227H
	.word	05000H
	.word	4,3
	.long	03CA8263H
	.word	04000H
	.word	4,3
	.long	03CA8293H
	.word	04000H
	.word	40,3
	.long	03CA6E17H
	.word	05000H
	.word	52,50
	.long	03CA4577H
	.word	04080H
	.word	64,61
	.long	03DFA55AH
	.word	05080H
	.word	4,3
	.long	03CA8227H
	.word	05000H
ENT1MODBLKS:
	.word	04040H	;flags
	.word	0,153 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,103,00H
	.word	04040H,0,53,00H
	.word	04040H,0,203,00H
	.word	04040H,0,3,00H
	.word	04040H,0,253,00H
	.word	04640H,43,191,01H
	.word	04640H,43,237,02H
	.word	04640H,43,99,01H
	.word	04640H,43,145,01H
	.word	04640H,43,53,01H
	.word	04640H,43,44,01H
	.word	04840H,43,42,03H
	.word	04640H,46,237,04H
	.word	04840H,46,42,04H
	.word	04640H,50,49,05H
	.word	04240H,50,53,06H
	.word	04240H,50,125,06H
	.word	04640H,50,199,07H
	.word	04040H,50,203,00H
	.word	04040H,50,-1,00H
	.word	04040H,50,253,00H
	.word	04240H,54,199,08H
	.word	04240H,54,49,09H
	.word	04640H,54,237,04H
	.word	04840H,54,42,04H
	.word	04240H,91,199,08H
	.word	04640H,94,237,04H
	.word	04840H,94,42,04H
	.word	04640H,100,203,05H
	.word	03B40H,100,199,06H
	.word	04040H,100,-1,00H
	.word	04040H,100,240,00H
	.word	04640H,101,233,07H
	.word	04240H,104,203,09H
	.word	04240H,105,233,08H
	.word	04240H,113,49,09H
	.word	04240H,133,203,09H
	.word	04240H,133,233,08H
	.word	04640H,134,237,04H
	.word	04840H,134,42,04H
	.word	04240H,150,199,08H
	.word	04240H,150,49,09H
	.word	04040H,150,-1,00H
	.word	04040H,150,240,00H
	.word	04640H,174,237,04H
	.word	04840H,174,42,04H
	.word	04640H,192,203,0AH
	.word	03B40H,192,199,0BH
	.word	04640H,192,233,0CH
	.word	04040H,196,199,00H
	.word	04040H,200,-1,00H
	.word	04040H,200,249,00H
	.word	04040H,209,149,00H
	.word	04240H,209,125,0BH
	.word	04240H,209,51,0BH
	.word	04640H,209,49,0AH
	.word	04040H,209,99,00H
	.word	04040H,209,49,00H
	.word	04640H,209,199,0CH
	.word	04640H,214,54,01H
	.word	04640H,214,99,01H
	.word	04640H,214,191,01H
	.word	04640H,214,237,0DH
	.word	04640H,214,145,01H
	.word	04640H,214,45,01H
	.word	04840H,214,42,0EH
	.word	04840H,222,256,0FH
	.word	04640H,222,210,01H
	.word	04640H,222,164,01H
	.word	04640H,222,118,01H
	.word	04640H,222,72,01H
	.word	04640H,222,45,01H
	.word	04840H,222,42,03H
	.word	04840H,224,256,010H
	.word	04840H,225,42,04H
	.word	04840H,226,48,05H
	.word	04840H,226,175,06H
	.word	04840H,226,249,07H
	.word	04840H,226,52,06H
	.word	04840H,226,126,06H
	.word	04741H,227,52,011H
	.word	04741H,227,102,011H
	.word	04741H,227,152,011H
	.word	04741H,227,202,011H
	.word	04840H,230,249,08H
	.word	04840H,230,48,09H
	.word	04040H,250,-1,00H
	.word	04040H,250,249,00H
	.word	04840H,254,256,010H
	.word	04840H,254,42,04H
	.word	03C41H,257,52,011H
	.word	04741H,257,102,011H
	.word	04741H,275,202,011H
	.word	04741H,277,152,011H
	.word	04840H,289,249,08H
	.word	04840H,289,48,09H
	.word	04840H,294,256,010H
	.word	04840H,294,42,04H
	.word	04040H,300,-1,00H
	.word	04040H,300,249,00H
	.word	04741H,307,152,011H
	.word	03D41H,307,102,011H
	.word	03D41H,307,52,011H
	.word	04741H,325,202,011H
	.word	04840H,334,256,010H
	.word	04840H,334,42,04H
	.word	04840H,348,249,08H
	.word	04B40H,348,48,0AH
	.word	03F40H,348,33,0BH
	.word	03E70H,349,106,07H
	.word	04040H,350,-1,00H
	.word	04040H,350,249,00H
	.word	04940H,352,45,012H
	.word	03F40H,352,106,09H
	.word	03C41H,357,52,011H
	.word	04741H,357,152,011H
	.word	03D41H,357,102,011H
	.word	04741H,359,202,011H
	.word	04840H,374,256,010H
	.word	04840H,374,42,04H
	.word	04040H,400,-1,00H
	.word	04040H,400,249,00H
	.word	04840H,407,177,0BH
	.word	04640H,407,48,0AH
	.word	04840H,407,249,0CH
	.word	04840H,407,103,0BH
	.word	04B40H,407,106,0AH
	.word	04040H,411,49,00H
	.word	04040H,411,99,00H
	.word	04040H,411,149,00H
	.word	04040H,411,199,00H
	.word	04640H,414,45,01H
	.word	04640H,414,91,01H
	.word	04640H,414,137,01H
	.word	04640H,414,183,01H
	.word	04640H,414,212,01H
	.word	04840H,414,256,013H
	.word	04840H,414,42,0EH
	.word	0FFFFH	;End Marker
ENT1MODBMOD:
	.word	463,304,139	;x size, y size, #blocks
	.long	ENT1MODBLKS, T1HDRS, T1PALS
T2HDRS:
	.word	52,50
	.long	03CA4577H
	.word	04080H
	.word	4,3
	.long	03CA8293H
	.word	04000H
	.word	4,46
	.long	03CA7E8FH
	.word	05000H
	.word	4,3
	.long	03CA82C3H
	.word	05000H
	.word	40,3
	.long	03CA6E17H
	.word	05000H
	.word	40,3
	.long	03CA6E17H
	.word	05000H
	.word	4,4
	.long	03CA706FH
	.word	04000H
	.word	4,74
	.long	03CA82FFH
	.word	04000H
	.word	4,4
	.long	03CA75CFH
	.word	05000H
	.word	52,50
	.long	03CA4577H
	.word	04080H
	.word	60,4
	.long	03CA761FH
	.word	05000H
	.word	60,4
	.long	03CA7ACFH
	.word	04000H
	.word	4,4
	.long	03CA8D67H
	.word	05000H
	.word	4,74
	.long	03CA879FH
	.word	05000H
	.word	64,61
	.long	03DFA55AH
	.word	05080H
	.word	4,4
	.long	03CA8DB7H
	.word	05000H
	.word	4,3
	.long	03CA8227H
	.word	05000H
	.word	4,3
	.long	03CA8263H
	.word	04000H
	.word	4,3
	.long	03CA8293H
	.word	04000H
	.word	4,3
	.long	03CA8227H
	.word	05000H
ENTMOD2BLKS:
	.word	04040H	;flags
	.word	0,-1 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,249,00H
	.word	04040H,9,149,00H
	.word	04040H,9,99,00H
	.word	04040H,9,49,00H
	.word	04840H,22,256,01H
	.word	04640H,22,210,02H
	.word	04640H,22,164,02H
	.word	04640H,22,118,02H
	.word	04640H,22,72,02H
	.word	04640H,22,45,02H
	.word	04840H,22,42,03H
	.word	04840H,24,256,04H
	.word	04840H,25,42,05H
	.word	04840H,26,48,06H
	.word	04840H,26,175,07H
	.word	04840H,26,249,08H
	.word	04840H,26,52,07H
	.word	04840H,26,126,07H
	.word	04741H,27,52,09H
	.word	04741H,27,102,09H
	.word	04741H,27,152,09H
	.word	04741H,27,202,09H
	.word	04840H,30,249,0AH
	.word	04840H,30,48,0BH
	.word	04040H,50,-1,00H
	.word	04040H,50,249,00H
	.word	04840H,54,256,04H
	.word	04840H,54,42,05H
	.word	03C41H,57,52,09H
	.word	04741H,57,102,09H
	.word	04741H,75,202,09H
	.word	04741H,77,152,09H
	.word	04840H,89,249,0AH
	.word	04840H,89,48,0BH
	.word	04840H,94,256,04H
	.word	04840H,94,42,05H
	.word	04040H,100,-1,00H
	.word	04040H,100,249,00H
	.word	04741H,107,152,09H
	.word	03D41H,107,102,09H
	.word	03D41H,107,52,09H
	.word	04741H,125,202,09H
	.word	04840H,134,256,04H
	.word	04840H,134,42,05H
	.word	04840H,148,249,0AH
	.word	04B40H,148,48,0CH
	.word	03F40H,148,33,0DH
	.word	03E70H,149,106,08H
	.word	04040H,150,-1,00H
	.word	04040H,150,249,00H
	.word	04940H,152,45,0EH
	.word	03F40H,152,106,0BH
	.word	03C41H,157,52,09H
	.word	04741H,157,152,09H
	.word	03D41H,157,102,09H
	.word	04741H,159,202,09H
	.word	04840H,174,256,04H
	.word	04840H,174,42,05H
	.word	03B40H,188,149,00H
	.word	03B40H,188,99,00H
	.word	03B40H,188,49,00H
	.word	04040H,200,-1,00H
	.word	04040H,200,249,00H
	.word	04840H,207,177,0DH
	.word	04640H,207,48,0CH
	.word	04840H,207,249,0FH
	.word	04840H,207,103,0DH
	.word	04B40H,207,106,0CH
	.word	04040H,211,199,00H
	.word	04640H,214,45,02H
	.word	04640H,214,91,02H
	.word	04640H,214,137,02H
	.word	04640H,214,183,02H
	.word	04640H,214,212,02H
	.word	04840H,214,256,010H
	.word	04840H,214,42,011H
	.word	04840H,227,42,03H
	.word	04640H,227,44,02H
	.word	04640H,227,53,02H
	.word	04640H,227,145,02H
	.word	04640H,227,99,02H
	.word	04640H,227,237,012H
	.word	04640H,227,191,02H
	.word	04840H,230,42,05H
	.word	04640H,230,237,05H
	.word	04040H,234,-1,00H
	.word	04040H,234,203,00H
	.word	04640H,234,199,08H
	.word	04240H,234,125,07H
	.word	04240H,234,53,07H
	.word	04640H,234,49,06H
	.word	04840H,238,42,05H
	.word	04640H,238,237,05H
	.word	04240H,238,49,0BH
	.word	04240H,238,199,0AH
	.word	04040H,250,249,00H
	.word	04240H,275,199,0AH
	.word	04840H,278,42,05H
	.word	04640H,278,237,05H
	.word	04040H,284,-1,00H
	.word	03B40H,284,199,07H
	.word	04640H,284,203,06H
	.word	04640H,285,233,08H
	.word	04040H,285,240,00H
	.word	04240H,288,203,0BH
	.word	04240H,289,233,0AH
	.word	04240H,297,49,0BH
	.word	04240H,317,233,0AH
	.word	04240H,317,203,0BH
	.word	04840H,318,42,05H
	.word	04640H,318,237,05H
	.word	04040H,334,-1,00H
	.word	04240H,334,49,0BH
	.word	04240H,334,199,0AH
	.word	04040H,335,240,00H
	.word	04840H,358,42,05H
	.word	04640H,358,237,05H
	.word	04640H,376,233,0FH
	.word	03B40H,376,199,0DH
	.word	04640H,376,203,0CH
	.word	04040H,380,199,00H
	.word	04040H,384,-1,00H
	.word	04040H,385,249,00H
	.word	04640H,393,199,0FH
	.word	04040H,393,49,00H
	.word	04040H,393,99,00H
	.word	04640H,393,49,0CH
	.word	04240H,393,51,0DH
	.word	04240H,393,125,0DH
	.word	04040H,393,149,00H
	.word	04840H,398,42,011H
	.word	04640H,398,45,02H
	.word	04640H,398,145,02H
	.word	04640H,398,237,013H
	.word	04640H,398,191,02H
	.word	04640H,398,99,02H
	.word	04640H,398,54,02H
	.word	0FFFFH	;End Marker
ENTMOD2BMOD:
	.word	445,300,138	;x size, y size, #blocks
	.long	ENTMOD2BLKS, T2HDRS, T2PALS
soonHDRS:
	.word	188,126
	.long	03DFEFEFH
	.word	080H
	.word	188,125
	.long	03E2D42FH
	.word	07000H
	.word	140,177
	.long	03E556C3H
	.word	0280H
	.word	176,198
	.long	03E7BFE3H
	.word	0F80H
	.word	212,126
	.long	03EAA693H
	.word	080H
	.word	212,125
	.long	03EDE953H
	.word	07000H
	.word	24,16
	.long	03F0BDEFH
	.word	04180H
comesoonBLKS:
	.word	04040H	;flags
	.word	0,25 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,151,01H
	.word	04B43H,46,63,02H
	.word	04B43H,186,42,03H
	.word	04040H,187,25,04H
	.word	04040H,188,151,05H
	.word	04E44H,286,226,06H
	.word	0FFFFH	;End Marker
comesoonBMOD:
	.word	400,251,7	;x size, y size, #blocks
	.long	comesoonBLKS, soonHDRS, soonPALS
Y1HDRS:
	.word	52,50
	.long	03CA4577H
	.word	04080H
	.word	28,25
	.long	03C9E247H
	.word	04580H
	.word	16,28
	.long	03C9EAE7H
	.word	04080H
	.word	4,74
	.long	03CA82FFH
	.word	04000H
	.word	4,4
	.long	03CA706FH
	.word	04000H
	.word	4,4
	.long	03CA75CFH
	.word	05000H
	.word	60,4
	.long	03CA7ACFH
	.word	04000H
	.word	48,57
	.long	03CBECA7H
	.word	04000H
	.word	60,4
	.long	03CA761FH
	.word	05000H
	.word	4,4
	.long	03CA8DB7H
	.word	05000H
	.word	4,74
	.long	03CA879FH
	.word	05000H
	.word	4,4
	.long	03CA8D67H
	.word	05000H
STORYMODBLKS:
	.word	03241H	;flags
	.word	0,25 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	03241H,0,75,00H
	.word	03241H,0,125,00H
	.word	03241H,0,175,00H
	.word	03241H,0,225,00H
	.word	03241H,0,275,00H
	.word	04042H,25,179,01H
	.word	04052H,36,38,02H
	.word	04041H,46,248,00H
	.word	03C41H,50,52,03H
	.word	04041H,50,49,04H
	.word	03241H,50,-1,00H
	.word	03C41H,50,126,03H
	.word	04041H,50,211,05H
	.word	04041H,50,215,04H
	.word	04041H,50,244,05H
	.word	03C41H,50,170,03H
	.word	04041H,53,49,06H
	.word	03B40H,53,218,07H
	.word	04041H,54,211,08H
	.word	04041H,54,215,06H
	.word	04041H,54,244,08H
	.word	04041H,96,248,00H
	.word	03241H,100,-1,00H
	.word	03B40H,100,218,07H
	.word	04041H,112,49,06H
	.word	04041H,113,211,08H
	.word	04041H,113,215,06H
	.word	04041H,113,244,08H
	.word	04041H,133,211,08H
	.word	04041H,133,215,06H
	.word	03C41H,133,244,08H
	.word	04041H,146,248,00H
	.word	03B40H,147,218,07H
	.word	03241H,150,-1,00H
	.word	04252H,157,247,01H
	.word	03C41H,171,49,06H
	.word	04041H,192,211,09H
	.word	04041H,192,53,0AH
	.word	04041H,192,49,0BH
	.word	04041H,192,215,0BH
	.word	04041H,192,127,0AH
	.word	04041H,192,170,0AH
	.word	04041H,192,244,09H
	.word	04041H,196,49,04H
	.word	03C41H,196,53,03H
	.word	03C41H,196,127,03H
	.word	03C41H,196,201,03H
	.word	04041H,196,275,05H
	.word	04041H,196,279,00H
	.word	03B40H,199,52,07H
	.word	03B40H,199,218,07H
	.word	03B40H,199,162,07H
	.word	03B40H,199,106,07H
	.word	03241H,200,-1,00H
	.word	04041H,200,275,08H
	.word	04041H,230,49,06H
	.word	03B40H,246,52,07H
	.word	03B40H,246,218,07H
	.word	03B40H,246,162,07H
	.word	03B40H,246,106,07H
	.word	03241H,246,279,00H
	.word	03241H,250,-1,00H
	.word	04041H,259,275,08H
	.word	04041H,289,49,06H
	.word	03B40H,293,52,07H
	.word	03B40H,293,218,07H
	.word	03B40H,293,162,07H
	.word	03B40H,293,106,07H
	.word	03241H,296,279,00H
	.word	03241H,300,-1,00H
	.word	04041H,318,275,08H
	.word	04041H,328,49,06H
	.word	03C41H,328,275,08H
	.word	03B40H,340,52,07H
	.word	03B40H,340,218,07H
	.word	03B40H,340,162,07H
	.word	03B40H,340,106,07H
	.word	03241H,346,279,00H
	.word	03241H,350,-1,00H
	.word	04042H,354,22,02H
	.word	04041H,387,49,0BH
	.word	04041H,387,53,0AH
	.word	04041H,387,127,0AH
	.word	04041H,387,201,0AH
	.word	04041H,387,275,09H
	.word	04042H,390,246,01H
	.word	03241H,391,49,00H
	.word	03241H,391,99,00H
	.word	03241H,391,149,00H
	.word	03241H,391,199,00H
	.word	03241H,391,249,00H
	.word	03241H,400,-1,00H
	.word	0FFFFH	;End Marker
STORYMODBMOD:
	.word	452,330,93	;x size, y size, #blocks
	.long	STORYMODBLKS, Y1HDRS, Y1PALS
