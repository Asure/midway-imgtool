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
	.word	0,103 ;x,y
	.word	01AH	;pal5,pal4,hdr13-0
	.word	04440H,6,25,01BH
	.word	04450H,101,85,01AH
	.word	04440H,104,7,01BH
	.word	04440H,271,181,01AH
	.word	04440H,278,25,01BH
	.word	04440H,278,103,01BH
	.word	04440H,390,78,01AH
	.word	04440H,397,0,01BH
	.word	04440H,535,103,01AH
	.word	04440H,541,25,01BH
	.word	04440H,750,79,01AH
	.word	04440H,757,1,01BH
	.word	04450H,863,97,01AH
	.word	04440H,866,19,01BH
	.word	04440H,1012,103,01AH
	.word	04440H,1019,25,01BH
	.word	04440H,1177,93,01AH
	.word	04440H,1184,15,01BH
	.word	0FFFFH	;End Marker
DPUL4BLKS:
	.word	04340H	;flags
	.word	0,153 ;x,y
	.word	01EH	;pal5,pal4,hdr13-0
	.word	04340H,4,13,01FH
	.word	04340H,4,83,01FH
	.word	04340H,187,83,01EH
	.word	04340H,191,13,01FH
	.word	04340H,302,71,01EH
	.word	04340H,306,1,01FH
	.word	04340H,447,153,01EH
	.word	04340H,451,13,01FH
	.word	04340H,451,83,01FH
	.word	04340H,696,83,01EH
	.word	04340H,700,13,01FH
	.word	04340H,849,153,01EH
	.word	04340H,853,13,01FH
	.word	04340H,853,83,01FH
	.word	04340H,1003,70,01EH
	.word	04340H,1007,0,01FH
	.word	04340H,1108,159,01EH
	.word	04340H,1112,19,01FH
	.word	04340H,1112,89,01FH
	.word	0FFFFH	;End Marker
DPUL5BLKS:
	.word	04042H	;flags
	.word	0,32 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	04042H,0,218,02H
	.word	04043H,12,332,03H
	.word	04042H,25,32,04H
	.word	04040H,25,95,05H
	.word	04042H,25,286,06H
	.word	04043H,46,331,08H
	.word	04042H,63,113,09H
	.word	04042H,102,288,0AH
	.word	04043H,102,331,0BH
	.word	04240H,122,107,0CH
	.word	04240H,131,149,0CH
	.word	03F43H,141,255,0DH
	.word	04052H,143,32,0EH
	.word	04240H,152,57,0CH
	.word	04240H,160,100,0CH
	.word	04240H,182,7,0CH
	.word	04172H,190,288,013H
	.word	04240H,190,50,0CH
	.word	04142H,194,318,014H
	.word	04042H,195,155,015H
	.word	04042H,195,32,016H
	.word	04041H,195,94,017H
	.word	04042H,196,288,0AH
	.word	04043H,196,331,0BH
	.word	04240H,220,0,0CH
	.word	04042H,240,32,018H
	.word	04051H,240,94,017H
	.word	04042H,241,155,019H
	.word	04052H,286,32,01CH
	.word	04142H,288,288,01DH
	.word	04142H,289,318,014H
	.word	04042H,290,288,0AH
	.word	04043H,290,331,0BH
	.word	04052H,342,32,020H
	.word	04142H,382,318,014H
	.word	04242H,382,288,023H
	.word	03F43H,382,254,024H
	.word	04042H,384,288,0AH
	.word	04043H,384,331,0BH
	.word	04341H,396,31,025H
	.word	04042H,398,199,026H
	.word	04042H,464,32,020H
	.word	04042H,478,288,0AH
	.word	04043H,478,331,0BH
	.word	04043H,480,255,028H
	.word	04042H,520,32,01CH
	.word	04042H,572,288,0AH
	.word	04043H,572,331,0BH
	.word	04042H,574,32,01CH
	.word	04043H,575,255,028H
	.word	04052H,628,32,020H
	.word	04042H,666,288,0AH
	.word	03F43H,666,254,024H
	.word	04043H,666,331,0BH
	.word	04341H,683,31,025H
	.word	04042H,684,199,026H
	.word	04042H,750,32,020H
	.word	04152H,754,288,023H
	.word	04152H,758,318,014H
	.word	03F53H,759,255,0DH
	.word	04042H,760,288,0AH
	.word	04043H,760,331,0BH
	.word	04042H,806,32,01CH
	.word	04152H,840,288,01DH
	.word	04152H,851,318,014H
	.word	04042H,854,155,015H
	.word	04042H,854,32,016H
	.word	04042H,854,288,0AH
	.word	04043H,854,331,0BH
	.word	04141H,855,94,017H
	.word	04250H,891,1,0CH
	.word	04151H,901,94,017H
	.word	04042H,901,32,018H
	.word	04042H,902,155,019H
	.word	04152H,915,288,013H
	.word	04250H,921,51,0CH
	.word	04250H,931,7,0CH
	.word	04152H,946,318,014H
	.word	04042H,948,288,0AH
	.word	04043H,948,331,0BH
	.word	04042H,949,32,0EH
	.word	04250H,951,101,0CH
	.word	04250H,960,56,0CH
	.word	04250H,981,151,0CH
	.word	04250H,990,106,0CH
	.word	04052H,999,32,04H
	.word	04052H,1001,113,09H
	.word	04052H,1039,286,06H
	.word	04053H,1042,331,08H
	.word	04050H,1079,95,05H
	.word	04053H,1096,332,03H
	.word	04052H,1116,218,02H
	.word	04052H,1116,32,01H
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
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,55,0,00H
	.word	04040H,110,0,00H
	.word	04040H,165,0,00H
	.word	04040H,220,0,00H
	.word	04040H,275,0,00H
	.word	04040H,330,0,00H
	.word	04040H,385,0,00H
	.word	04040H,440,0,00H
	.word	04040H,495,0,00H
	.word	04040H,550,0,00H
	.word	04040H,605,0,00H
	.word	04040H,660,0,00H
	.word	04040H,715,0,00H
	.word	04040H,770,0,00H
	.word	04040H,825,0,00H
	.word	04040H,880,0,00H
	.word	04040H,935,0,00H
	.word	04040H,990,0,00H
	.word	04040H,1045,0,00H
	.word	04040H,1100,0,00H
	.word	04040H,1155,0,00H
	.word	04040H,1210,0,00H
	.word	04040H,1265,0,00H
	.word	04040H,1320,0,00H
	.word	04040H,1375,0,00H
	.word	04040H,1430,0,00H
	.word	04040H,1485,0,00H
	.word	04040H,1540,0,00H
	.word	04040H,1595,0,00H
	.word	04040H,1650,0,00H
	.word	04040H,1705,0,00H
	.word	04040H,1760,0,00H
	.word	04040H,1815,0,00H
	.word	04040H,1870,0,00H
	.word	04040H,1925,0,00H
	.word	04040H,1980,0,00H
	.word	0FFFFH	;End Marker
TMOD1BLKS:
	.word	04253H	;flags
	.word	0,19 ;x,y
	.word	04H	;pal5,pal4,hdr13-0
	.word	04344H,1,0,05H
	.word	04243H,32,19,06H
	.word	04243H,55,51,07H
	.word	04242H,62,19,08H
	.word	04344H,71,0,05H
	.word	04242H,78,51,09H
	.word	04042H,94,177,0AH
	.word	04240H,99,103,0BH
	.word	04241H,101,51,0CH
	.word	04252H,118,19,08H
	.word	04042H,134,181,0FH
	.word	04253H,137,51,07H
	.word	04252H,138,51,09H
	.word	04344H,141,0,05H
	.word	04253H,160,19,06H
	.word	04042H,175,177,010H
	.word	04243H,208,19,04H
	.word	04042H,209,177,0AH
	.word	04344H,211,0,05H
	.word	04253H,240,19,04H
	.word	04042H,249,181,0FH
	.word	04243H,272,19,06H
	.word	04344H,281,0,05H
	.word	04042H,290,177,010H
	.word	04243H,295,51,07H
	.word	04242H,302,19,08H
	.word	04242H,318,51,09H
	.word	04042H,324,177,0AH
	.word	04240H,339,103,0BH
	.word	04241H,341,51,0CH
	.word	04344H,351,0,05H
	.word	04252H,358,19,08H
	.word	04042H,364,181,0FH
	.word	04253H,377,51,07H
	.word	04253H,378,51,07H
	.word	04252H,378,51,09H
	.word	04253H,400,19,06H
	.word	04042H,405,177,010H
	.word	04344H,421,0,05H
	.word	04042H,439,177,0AH
	.word	04243H,448,19,04H
	.word	04042H,479,181,0FH
	.word	04253H,480,19,04H
	.word	04344H,491,0,05H
	.word	04243H,512,19,06H
	.word	04042H,520,177,010H
	.word	04243H,535,51,07H
	.word	04242H,542,19,08H
	.word	04042H,554,177,0AH
	.word	04242H,558,51,09H
	.word	04344H,561,0,05H
	.word	04240H,579,103,0BH
	.word	04241H,581,51,0CH
	.word	04042H,594,181,0FH
	.word	04252H,598,19,08H
	.word	04253H,617,51,07H
	.word	04252H,618,51,09H
	.word	04344H,631,0,05H
	.word	04042H,635,177,010H
	.word	04253H,640,19,06H
	.word	04042H,669,177,0AH
	.word	04243H,688,19,04H
	.word	04344H,701,0,05H
	.word	04042H,709,181,0FH
	.word	04253H,720,19,04H
	.word	04042H,750,177,010H
	.word	04243H,752,19,06H
	.word	04344H,771,0,05H
	.word	04243H,775,51,07H
	.word	04242H,782,19,08H
	.word	04042H,784,177,0AH
	.word	04242H,798,51,09H
	.word	04240H,819,103,0BH
	.word	04241H,821,51,0CH
	.word	04042H,824,181,0FH
	.word	04252H,838,19,08H
	.word	04344H,841,0,05H
	.word	04253H,857,51,07H
	.word	04252H,858,51,09H
	.word	04042H,865,177,010H
	.word	04253H,880,19,06H
	.word	04142H,888,158,011H
	.word	04142H,898,231,012H
	.word	04344H,911,0,05H
	.word	04253H,928,19,04H
	.word	04042H,942,166,013H
	.word	04043H,943,178,014H
	.word	04042H,960,166,015H
	.word	04243H,960,19,04H
	.word	04152H,977,158,011H
	.word	04344H,981,0,05H
	.word	04243H,992,19,06H
	.word	04152H,994,231,012H
	.word	04243H,1015,51,07H
	.word	04242H,1022,19,08H
	.word	04042H,1022,177,0AH
	.word	04142H,1028,231,016H
	.word	04242H,1038,51,09H
	.word	04344H,1051,0,05H
	.word	04250H,1057,103,0BH
	.word	04251H,1059,51,0CH
	.word	04042H,1062,181,0FH
	.word	04252H,1078,19,08H
	.word	04253H,1097,51,07H
	.word	04252H,1098,51,09H
	.word	04042H,1103,177,010H
	.word	04253H,1120,19,06H
	.word	04344H,1121,0,05H
	.word	04042H,1137,177,0AH
	.word	04253H,1168,19,04H
	.word	04042H,1177,181,0FH
	.word	04344H,1191,0,05H
	.word	04243H,1200,19,04H
	.word	04042H,1218,177,010H
	.word	04243H,1232,19,06H
	.word	04042H,1252,177,0AH
	.word	04243H,1255,51,07H
	.word	04344H,1261,0,05H
	.word	04242H,1262,19,08H
	.word	04242H,1278,51,09H
	.word	04042H,1292,181,0FH
	.word	04240H,1299,103,0BH
	.word	04241H,1301,51,0CH
	.word	04252H,1318,19,08H
	.word	04344H,1331,0,05H
	.word	04042H,1333,177,010H
	.word	04253H,1337,51,07H
	.word	04252H,1338,51,09H
	.word	04253H,1360,19,06H
	.word	04042H,1367,177,0AH
	.word	04344H,1401,0,05H
	.word	04042H,1407,181,0FH
	.word	04253H,1408,19,04H
	.word	04243H,1440,19,04H
	.word	04042H,1448,177,010H
	.word	04344H,1471,0,05H
	.word	04243H,1472,19,06H
	.word	04042H,1482,177,0AH
	.word	04243H,1495,51,07H
	.word	04242H,1502,19,08H
	.word	04242H,1518,51,09H
	.word	04042H,1522,181,0FH
	.word	04240H,1540,103,0BH
	.word	04241H,1541,51,0CH
	.word	04344H,1541,0,05H
	.word	04252H,1558,19,08H
	.word	04042H,1563,177,010H
	.word	04253H,1577,51,07H
	.word	04252H,1578,51,09H
	.word	04042H,1597,177,0AH
	.word	04253H,1600,19,06H
	.word	04344H,1611,0,05H
	.word	04042H,1637,181,0FH
	.word	04253H,1648,19,04H
	.word	04042H,1678,177,010H
	.word	04243H,1680,19,04H
	.word	04344H,1681,0,05H
	.word	04243H,1712,19,06H
	.word	04042H,1712,177,0AH
	.word	04243H,1735,51,07H
	.word	04242H,1742,19,08H
	.word	04344H,1751,0,05H
	.word	04042H,1752,181,0FH
	.word	04242H,1758,51,09H
	.word	04240H,1779,103,0BH
	.word	04241H,1781,51,0CH
	.word	04042H,1793,177,010H
	.word	04252H,1798,19,08H
	.word	04253H,1817,51,07H
	.word	04252H,1818,51,09H
	.word	04344H,1821,0,05H
	.word	04042H,1827,177,0AH
	.word	04253H,1840,19,06H
	.word	04042H,1867,181,0FH
	.word	04042H,1908,177,010H
	.word	0FFFFH	;End Marker
TMOD3BLKS:
	.word	04045H	;flags
	.word	0,2 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04046H,0,46,03H
	.word	04045H,138,0,0DH
	.word	04047H,138,46,0EH
	.word	04055H,280,0,0DH
	.word	04057H,280,46,0EH
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
	.word	0,103 ;x,y
	.word	06H	;pal5,pal4,hdr13-0
	.word	04462H,0,0,06H
	.word	04472H,343,3,06H
	.word	04442H,345,106,06H
	.word	0FFFFH	;End Marker
PLANE5BLKS:
	.word	04350H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04341H,6,193,01H
	.word	04350H,8,48,02H
	.word	04350H,8,94,03H
	.word	04341H,35,94,04H
	.word	04341H,35,66,05H
	.word	04350H,63,0,00H
	.word	04340H,80,48,02H
	.word	04340H,80,94,03H
	.word	04341H,107,193,01H
	.word	04350H,126,0,00H
	.word	04350H,146,94,03H
	.word	04350H,146,48,02H
	.word	04341H,173,94,04H
	.word	04341H,173,66,05H
	.word	04350H,189,0,00H
	.word	04341H,208,193,01H
	.word	04340H,218,48,02H
	.word	04340H,218,94,03H
	.word	04350H,252,0,00H
	.word	04350H,284,48,02H
	.word	04350H,284,94,03H
	.word	04341H,309,193,01H
	.word	04341H,311,94,04H
	.word	04341H,311,66,05H
	.word	04350H,315,0,00H
	.word	04340H,356,94,03H
	.word	04340H,356,48,02H
	.word	04350H,378,0,00H
	.word	04341H,410,193,01H
	.word	04350H,422,124,07H
	.word	04350H,425,48,08H
	.word	04350H,440,0,09H
	.word	04350H,470,124,0AH
	.word	04050H,470,0,0BH
	.word	04350H,502,76,0CH
	.word	04341H,511,193,01H
	.word	04340H,558,124,0AH
	.word	04040H,558,0,0BH
	.word	04340H,558,76,0CH
	.word	04340H,611,48,08H
	.word	04341H,612,193,01H
	.word	04340H,644,0,09H
	.word	04340H,646,124,07H
	.word	04340H,674,0,00H
	.word	04350H,688,48,02H
	.word	04350H,688,94,03H
	.word	04341H,713,193,01H
	.word	04341H,715,66,05H
	.word	04341H,715,94,04H
	.word	04340H,737,0,00H
	.word	04340H,760,48,02H
	.word	04340H,760,94,03H
	.word	04340H,800,0,00H
	.word	04341H,814,193,01H
	.word	04350H,826,94,03H
	.word	04350H,826,48,02H
	.word	04341H,853,94,04H
	.word	04341H,853,66,05H
	.word	04340H,863,0,00H
	.word	04340H,898,48,02H
	.word	04340H,898,94,03H
	.word	04341H,915,193,01H
	.word	04340H,926,0,00H
	.word	04350H,964,48,02H
	.word	04350H,964,94,03H
	.word	04340H,989,0,00H
	.word	04341H,991,94,04H
	.word	04341H,991,66,05H
	.word	04341H,1016,193,01H
	.word	04340H,1036,94,03H
	.word	04340H,1036,48,02H
	.word	04340H,1052,0,00H
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
	.word	0,3 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04043H,150,3,07H
	.word	04043H,297,0,0EH
	.word	0FFFFH	;End Marker
BAT6BLKS:
	.word	04143H	;flags
	.word	0,0 ;x,y
	.word	03H	;pal5,pal4,hdr13-0
	.word	04143H,168,17,09H
	.word	04143H,307,31,0FH
	.word	04143H,392,31,0FH
	.word	0FFFFH	;End Marker
BAT5BLKS:
	.word	04043H	;flags
	.word	0,0 ;x,y
	.word	010H	;pal5,pal4,hdr13-0
	.word	04043H,80,15,011H
	.word	04043H,156,58,012H
	.word	04043H,228,58,012H
	.word	0FFFFH	;End Marker
BAT4BLKS:
	.word	04340H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04340H,115,13,05H
	.word	04340H,249,38,0BH
	.word	04340H,296,0,0DH
	.word	04350H,350,0,0DH
	.word	04350H,405,38,0BH
	.word	04350H,451,13,05H
	.word	04350H,586,0,00H
	.word	04340H,701,13,05H
	.word	0FFFFH	;End Marker
BAT2BLKS:
	.word	04545H	;flags
	.word	0,151 ;x,y
	.word	04H	;pal5,pal4,hdr13-0
	.word	04545H,57,128,06H
	.word	04545H,88,0,08H
	.word	04555H,169,152,04H
	.word	04545H,555,151,04H
	.word	04545H,612,128,06H
	.word	04545H,643,0,08H
	.word	04555H,724,152,04H
	.word	0FFFFH	;End Marker
BAT1BLKS:
	.word	04644H	;flags
	.word	0,25 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	04644H,101,25,01H
	.word	04644H,202,25,01H
	.word	04742H,286,0,0CH
	.word	04644H,438,25,01H
	.word	04644H,539,25,01H
	.word	04644H,640,25,01H
	.word	04644H,741,25,01H
	.word	04644H,842,25,01H
	.word	04742H,928,0,0CH
	.word	04644H,1077,25,01H
	.word	04644H,1178,25,01H
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
	.word	0,34 ;x,y
	.word	08H	;pal5,pal4,hdr13-0
	.word	04041H,22,0,0CH
	.word	04041H,88,0,0CH
	.word	04041H,130,34,08H
	.word	04041H,152,0,0CH
	.word	04041H,218,0,0CH
	.word	04041H,260,34,08H
	.word	04041H,282,0,0CH
	.word	04041H,348,0,0CH
	.word	04041H,390,34,08H
	.word	04041H,412,0,0CH
	.word	04041H,478,0,0CH
	.word	0FFFFH	;End Marker
wood6BLKS:
	.word	04059H	;flags
	.word	0,89 ;x,y
	.word	05H	;pal5,pal4,hdr13-0
	.word	04042H,87,11,010H
	.word	04042H,103,2,013H
	.word	04049H,104,89,05H
	.word	04059H,204,89,05H
	.word	04042H,233,10,018H
	.word	04042H,249,0,013H
	.word	04049H,308,89,05H
	.word	04042H,361,10,018H
	.word	04042H,377,0,013H
	.word	04059H,408,89,05H
	.word	04042H,498,12,010H
	.word	04049H,512,89,05H
	.word	04042H,515,2,013H
	.word	04059H,612,89,05H
	.word	04042H,648,10,018H
	.word	04042H,664,0,013H
	.word	0FFFFH	;End Marker
wood5BLKS:
	.word	04049H	;flags
	.word	0,120 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04044H,24,81,01H
	.word	04044H,44,20,03H
	.word	04044H,44,1,04H
	.word	04049H,63,120,00H
	.word	04049H,126,120,00H
	.word	04049H,189,120,00H
	.word	04049H,252,120,00H
	.word	04044H,260,80,016H
	.word	04044H,280,19,03H
	.word	04044H,280,0,04H
	.word	04049H,315,120,01CH
	.word	04044H,429,83,01H
	.word	04049H,441,120,00H
	.word	04044H,449,22,03H
	.word	04044H,449,3,04H
	.word	04049H,504,120,00H
	.word	04049H,567,120,00H
	.word	04044H,621,80,016H
	.word	04044H,621,80,016H
	.word	04049H,630,120,00H
	.word	04044H,641,19,03H
	.word	04044H,641,0,04H
	.word	04049H,693,120,00H
	.word	04044H,740,80,01H
	.word	04049H,756,120,00H
	.word	04044H,760,19,03H
	.word	04044H,760,0,04H
	.word	0FFFFH	;End Marker
wood4BLKS:
	.word	04049H	;flags
	.word	0,140 ;x,y
	.word	06H	;pal5,pal4,hdr13-0
	.word	04044H,43,86,09H
	.word	04043H,61,25,0AH
	.word	04044H,61,0,0BH
	.word	04049H,79,136,0EH
	.word	04049H,151,140,06H
	.word	04049H,230,136,0EH
	.word	04044H,241,88,019H
	.word	04043H,265,27,0AH
	.word	04044H,265,3,0BH
	.word	04059H,302,136,0EH
	.word	04049H,374,140,06H
	.word	04059H,453,136,0EH
	.word	04044H,475,87,09H
	.word	04043H,493,26,0AH
	.word	04044H,493,2,0BH
	.word	04059H,524,140,06H
	.word	04049H,604,140,06H
	.word	04059H,682,140,06H
	.word	04049H,762,140,06H
	.word	04044H,768,87,019H
	.word	04043H,792,26,0AH
	.word	04044H,792,1,0BH
	.word	0FFFFH	;End Marker
wood2BLKS:
	.word	04058H	;flags
	.word	0,183 ;x,y
	.word	011H	;pal5,pal4,hdr13-0
	.word	04058H,58,164,014H
	.word	04058H,120,154,015H
	.word	04046H,131,102,017H
	.word	04045H,173,25,01AH
	.word	04044H,173,0,01BH
	.word	04047H,192,200,01EH
	.word	04045H,201,25,01FH
	.word	04046H,202,102,020H
	.word	04047H,293,199,021H
	.word	04046H,383,105,022H
	.word	04047H,401,200,01EH
	.word	04045H,423,28,01AH
	.word	04044H,423,3,01BH
	.word	04045H,451,28,01FH
	.word	04046H,452,105,023H
	.word	04047H,502,199,021H
	.word	04047H,610,200,01EH
	.word	04046H,692,102,024H
	.word	04047H,710,199,021H
	.word	04045H,734,25,01AH
	.word	04044H,734,0,01BH
	.word	04045H,762,25,01FH
	.word	04058H,817,183,011H
	.word	04058H,875,164,014H
	.word	04058H,937,154,015H
	.word	0FFFFH	;End Marker
wood1BLKS:
	.word	04040H	;flags
	.word	0,226 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	0404AH,36,123,07H
	.word	0406AH,78,82,0DH
	.word	0404AH,78,41,0DH
	.word	0406AH,78,0,0DH
	.word	04040H,98,224,0FH
	.word	0404AH,114,123,012H
	.word	04040H,203,226,02H
	.word	0404AH,287,212,01DH
	.word	04040H,301,224,0FH
	.word	0404AH,336,86,0DH
	.word	0406AH,336,45,0DH
	.word	0404AH,336,4,0DH
	.word	04040H,404,226,02H
	.word	04040H,501,226,02H
	.word	0404AH,584,212,01DH
	.word	04040H,598,226,02H
	.word	0404AH,633,86,0DH
	.word	0406AH,633,45,0DH
	.word	0404AH,633,4,0DH
	.word	04040H,696,226,02H
	.word	04040H,794,226,02H
	.word	0404AH,872,211,01DH
	.word	04040H,892,223,0FH
	.word	0404AH,921,86,0DH
	.word	0406AH,921,45,0DH
	.word	0404AH,921,4,0DH
	.word	04040H,996,225,02H
	.word	04040H,1094,225,02H
	.word	0404AH,1123,134,025H
	.word	0404AH,1150,93,0DH
	.word	0406AH,1150,52,0DH
	.word	0404AH,1150,11,0DH
	.word	0404AH,1186,134,026H
	.word	04040H,1192,223,0FH
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
	.word	0,99 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04042H,0,0,03H
	.word	04050H,13,99,04H
	.word	04051H,13,0,05H
	.word	04050H,49,99,07H
	.word	04051H,49,0,08H
	.word	04042H,81,99,02H
	.word	04042H,81,0,03H
	.word	04050H,94,99,04H
	.word	04051H,94,0,05H
	.word	04050H,130,99,07H
	.word	04051H,130,0,08H
	.word	04042H,162,99,02H
	.word	04042H,162,0,03H
	.word	04050H,175,99,04H
	.word	04051H,175,0,05H
	.word	04050H,211,99,07H
	.word	04051H,211,0,08H
	.word	04042H,243,99,02H
	.word	04042H,243,0,03H
	.word	04050H,256,99,04H
	.word	04051H,256,0,05H
	.word	04050H,292,99,07H
	.word	04051H,292,0,08H
	.word	04042H,324,99,02H
	.word	04042H,324,0,03H
	.word	04040H,338,138,013H
	.word	04041H,338,0,014H
	.word	04048H,338,42,015H
	.word	04042H,472,99,02H
	.word	04042H,472,0,03H
	.word	04050H,485,99,04H
	.word	04051H,485,0,05H
	.word	04050H,521,99,07H
	.word	04051H,521,0,08H
	.word	04042H,553,99,02H
	.word	04042H,553,1,03H
	.word	04050H,566,99,04H
	.word	04051H,566,0,05H
	.word	04050H,602,99,07H
	.word	04051H,602,1,08H
	.word	04042H,634,99,02H
	.word	04042H,634,0,03H
	.word	04050H,647,99,04H
	.word	04051H,647,0,05H
	.word	04050H,683,99,07H
	.word	04051H,683,0,08H
	.word	04042H,715,99,02H
	.word	04042H,715,0,03H
	.word	04050H,728,99,04H
	.word	04051H,728,0,05H
	.word	04050H,764,99,07H
	.word	04051H,764,0,08H
	.word	04042H,796,99,02H
	.word	04042H,796,0,03H
	.word	0FFFFH	;End Marker
ARM2BLKS:
	.word	04142H	;flags
	.word	0,105 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04152H,105,0,01H
	.word	04142H,173,0,01H
	.word	04142H,240,105,00H
	.word	04142H,346,105,00H
	.word	04142H,452,105,00H
	.word	04247H,469,56,012H
	.word	04247H,522,61,016H
	.word	04247H,543,94,017H
	.word	04142H,558,105,00H
	.word	04247H,558,54,018H
	.word	04142H,664,105,00H
	.word	04142H,770,105,00H
	.word	04247H,811,94,017H
	.word	04247H,826,54,018H
	.word	04152H,875,0,01H
	.word	04142H,943,0,01H
	.word	0FFFFH	;End Marker
ARM1BLKS:
	.word	04245H	;flags
	.word	0,163 ;x,y
	.word	06H	;pal5,pal4,hdr13-0
	.word	04245H,34,130,09H
	.word	04046H,42,1,0AH
	.word	04245H,67,140,0BH
	.word	04245H,95,183,0CH
	.word	03F45H,116,130,0DH
	.word	04046H,126,1,0EH
	.word	04054H,135,164,0FH
	.word	04044H,138,71,010H
	.word	04056H,180,1,0EH
	.word	04044H,183,164,0FH
	.word	04044H,183,71,011H
	.word	03F45H,226,182,0CH
	.word	04056H,236,1,0AH
	.word	03F55H,245,162,06H
	.word	04046H,519,0,0AH
	.word	04245H,563,181,0CH
	.word	03F45H,584,128,09H
	.word	04046H,603,1,0EH
	.word	04054H,611,164,0FH
	.word	04044H,613,71,010H
	.word	04056H,657,1,0EH
	.word	04044H,658,71,011H
	.word	04044H,659,164,0FH
	.word	03F45H,702,138,0BH
	.word	04056H,713,1,0AH
	.word	04245H,730,181,0CH
	.word	04245H,741,161,06H
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
	.word	0,130 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04046H,0,193,00H
	.word	04046H,0,256,00H
	.word	04046H,0,319,00H
	.word	04046H,0,382,00H
	.word	04046H,0,445,00H
	.word	04046H,0,508,00H
	.word	04046H,0,571,00H
	.word	04046H,0,634,00H
	.word	04046H,0,697,00H
	.word	04046H,0,760,00H
	.word	04046H,0,823,00H
	.word	04046H,0,886,00H
	.word	04046H,0,949,00H
	.word	04046H,1,67,01H
	.word	04056H,30,0,03H
	.word	04352H,86,2,05H
	.word	04352H,218,2,05H
	.word	04046H,350,0,03H
	.word	04046H,376,130,00H
	.word	04046H,376,193,00H
	.word	04046H,376,256,00H
	.word	04046H,376,319,00H
	.word	04046H,376,382,00H
	.word	04046H,376,445,00H
	.word	04046H,376,508,00H
	.word	04046H,376,571,00H
	.word	04046H,376,634,00H
	.word	04046H,376,697,00H
	.word	04046H,376,760,00H
	.word	04046H,376,823,00H
	.word	04046H,376,886,00H
	.word	04046H,376,949,00H
	.word	04046H,377,67,01H
	.word	04056H,406,0,03H
	.word	04352H,462,2,05H
	.word	04352H,594,2,05H
	.word	04046H,726,0,03H
	.word	04046H,752,130,00H
	.word	04046H,752,193,00H
	.word	04046H,752,256,00H
	.word	04046H,752,319,00H
	.word	04046H,752,382,00H
	.word	04046H,752,445,00H
	.word	04046H,752,508,00H
	.word	04046H,752,571,00H
	.word	04046H,752,634,00H
	.word	04046H,752,697,00H
	.word	04046H,752,759,00H
	.word	04046H,752,822,00H
	.word	04046H,752,885,00H
	.word	04046H,752,948,00H
	.word	04046H,753,67,01H
	.word	04056H,782,0,03H
	.word	04342H,835,2,05H
	.word	04342H,967,3,05H
	.word	04046H,1099,0,03H
	.word	04046H,1126,130,00H
	.word	04046H,1126,193,00H
	.word	04046H,1126,256,00H
	.word	04046H,1126,319,00H
	.word	04046H,1126,382,00H
	.word	04046H,1126,445,00H
	.word	04046H,1126,508,00H
	.word	04046H,1126,571,00H
	.word	04046H,1126,634,00H
	.word	04046H,1126,697,00H
	.word	04046H,1126,760,00H
	.word	04046H,1126,823,00H
	.word	04046H,1126,886,00H
	.word	04046H,1126,949,00H
	.word	04046H,1127,67,01H
	.word	04056H,1155,0,03H
	.word	04342H,1209,2,05H
	.word	04342H,1340,2,05H
	.word	04046H,1472,0,03H
	.word	04046H,1499,130,00H
	.word	04046H,1499,193,00H
	.word	04046H,1499,256,00H
	.word	04046H,1499,319,00H
	.word	04046H,1499,382,00H
	.word	04046H,1499,445,00H
	.word	04046H,1499,508,00H
	.word	04046H,1499,571,00H
	.word	04046H,1499,634,00H
	.word	04046H,1499,697,00H
	.word	04046H,1499,760,00H
	.word	04046H,1499,823,00H
	.word	04046H,1499,886,00H
	.word	04046H,1499,949,00H
	.word	04046H,1500,67,01H
	.word	0FFFFH	;End Marker
BRIDGE6BLKS:
	.word	03C45H	;flags
	.word	0,62 ;x,y
	.word	0FH	;pal5,pal4,hdr13-0
	.word	03C45H,172,82,015H
	.word	04047H,257,0,016H
	.word	03C55H,306,82,015H
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
	.word	0,0 ;x,y
	.word	0BH	;pal5,pal4,hdr13-0
	.word	04054H,168,0,0BH
	.word	04044H,339,0,0BH
	.word	04054H,507,0,0BH
	.word	0FFFFH	;End Marker
BRIDGE3BLKS:
	.word	04048H	;flags
	.word	0,0 ;x,y
	.word	0EH	;pal5,pal4,hdr13-0
	.word	04048H,74,71,010H
	.word	04043H,121,107,012H
	.word	04043H,152,103,013H
	.word	04043H,182,124,014H
	.word	04043H,217,103,013H
	.word	04043H,247,124,014H
	.word	04043H,282,103,013H
	.word	04043H,312,124,014H
	.word	04053H,346,107,012H
	.word	04058H,369,72,010H
	.word	04058H,423,1,0EH
	.word	0FFFFH	;End Marker
BRIDGE2BLKS:
	.word	04044H	;flags
	.word	0,3 ;x,y
	.word	08H	;pal5,pal4,hdr13-0
	.word	04044H,95,0,09H
	.word	04044H,212,5,0AH
	.word	04044H,314,6,0CH
	.word	04044H,474,4,011H
	.word	04044H,543,0,0AH
	.word	04044H,618,10,0CH
	.word	04044H,700,11,09H
	.word	04044H,863,13,0AH
	.word	04044H,947,3,011H
	.word	04044H,1023,15,0CH
	.word	0FFFFH	;End Marker
BRIDGE1BLKS:
	.word	04150H	;flags
	.word	0,0 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04140H,3,38,04H
	.word	04151H,98,21,06H
	.word	04141H,100,38,07H
	.word	04151H,188,38,07H
	.word	04141H,190,21,06H
	.word	04150H,277,38,04H
	.word	04140H,280,0,02H
	.word	04150H,374,0,02H
	.word	04140H,377,38,04H
	.word	04151H,472,21,06H
	.word	04141H,474,38,07H
	.word	04151H,562,38,07H
	.word	04141H,564,21,06H
	.word	04150H,651,38,04H
	.word	04140H,654,0,02H
	.word	04150H,748,0,02H
	.word	04140H,751,38,04H
	.word	04151H,846,21,06H
	.word	04141H,848,38,07H
	.word	04151H,936,38,07H
	.word	04141H,938,21,06H
	.word	04150H,1025,38,04H
	.word	04140H,1028,0,02H
	.word	04150H,1122,0,02H
	.word	04140H,1125,38,04H
	.word	04151H,1220,21,06H
	.word	04141H,1222,38,07H
	.word	04151H,1310,38,07H
	.word	04141H,1312,21,06H
	.word	04150H,1399,38,04H
	.word	04140H,1402,0,02H
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
	.word	0,195 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04245H,87,194,0AH
	.word	04245H,93,97,0BH
	.word	04245H,93,0,0BH
	.word	04245H,174,195,00H
	.word	04245H,261,194,0AH
	.word	04245H,267,97,0BH
	.word	04245H,267,0,0BH
	.word	04245H,348,195,00H
	.word	04245H,435,194,0AH
	.word	04245H,441,97,0BH
	.word	04245H,441,0,0BH
	.word	04245H,522,195,015H
	.word	04255H,618,195,015H
	.word	04255H,713,194,0AH
	.word	04255H,775,97,0BH
	.word	04255H,775,0,0BH
	.word	04255H,800,195,00H
	.word	04255H,887,194,0AH
	.word	04255H,949,97,0BH
	.word	04255H,949,0,0BH
	.word	04255H,974,195,00H
	.word	04255H,1061,194,0AH
	.word	04255H,1123,97,0BH
	.word	04255H,1123,0,0BH
	.word	04255H,1148,195,00H
	.word	0FFFFH	;End Marker
spiral2BLKS:
	.word	04044H	;flags
	.word	0,151 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	04044H,0,81,02H
	.word	04144H,0,0,03H
	.word	04144H,19,81,04H
	.word	04144H,30,5,05H
	.word	04144H,39,81,06H
	.word	04144H,54,151,07H
	.word	04144H,60,117,08H
	.word	04144H,68,49,09H
	.word	04144H,100,81,0CH
	.word	04154H,1095,49,09H
	.word	04154H,1107,81,0CH
	.word	04154H,1120,151,07H
	.word	04154H,1123,117,08H
	.word	04154H,1153,5,05H
	.word	04154H,1160,81,06H
	.word	04054H,1166,151,01H
	.word	04154H,1184,81,04H
	.word	04154H,1191,0,03H
	.word	04054H,1202,81,02H
	.word	0FFFFH	;End Marker
spiral3BLKS:
	.word	04150H	;flags
	.word	0,8 ;x,y
	.word	0DH	;pal5,pal4,hdr13-0
	.word	04140H,112,0,0EH
	.word	04140H,219,8,0DH
	.word	04150H,516,8,0DH
	.word	04140H,628,0,0EH
	.word	04140H,735,8,0DH
	.word	0FFFFH	;End Marker
spiral4BLKS:
	.word	04041H	;flags
	.word	0,129 ;x,y
	.word	0FH	;pal5,pal4,hdr13-0
	.word	04043H,5,85,010H
	.word	04040H,8,176,011H
	.word	04140H,36,168,012H
	.word	04146H,63,0,013H
	.word	04042H,143,84,014H
	.word	04040H,174,72,016H
	.word	04040H,205,68,017H
	.word	04040H,249,63,018H
	.word	04040H,303,83,019H
	.word	04043H,347,83,01AH
	.word	04041H,347,129,0FH
	.word	04040H,347,176,01BH
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
	.word	0,25 ;x,y
	.word	06H	;pal5,pal4,hdr13-0
	.word	04040H,42,17,07H
	.word	04040H,87,14,09H
	.word	03F49H,104,32,0AH
	.word	04040H,146,52,0BH
	.word	03F49H,152,32,0AH
	.word	04040H,200,10,0EH
	.word	03F49H,200,32,0AH
	.word	04050H,232,52,0BH
	.word	03F49H,248,32,0AH
	.word	04040H,291,0,012H
	.word	03F49H,296,32,0AH
	.word	04040H,320,52,013H
	.word	03F49H,344,32,0AH
	.word	03F49H,392,32,0AH
	.word	0FFFFH	;End Marker
arena5BLKS:
	.word	04141H	;flags
	.word	0,99 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04041H,1,0,05H
	.word	04041H,55,0,08H
	.word	04141H,121,99,02H
	.word	04041H,122,0,05H
	.word	04041H,176,0,08H
	.word	04141H,242,99,02H
	.word	04041H,243,0,05H
	.word	04041H,297,0,08H
	.word	04141H,363,99,02H
	.word	04041H,364,0,05H
	.word	04041H,418,0,08H
	.word	04141H,484,99,02H
	.word	04041H,485,0,05H
	.word	04041H,539,0,08H
	.word	0FFFFH	;End Marker
arena4BLKS:
	.word	04043H	;flags
	.word	0,0 ;x,y
	.word	03H	;pal5,pal4,hdr13-0
	.word	04043H,77,0,03H
	.word	04043H,154,0,03H
	.word	04043H,231,0,03H
	.word	04043H,308,0,03H
	.word	04043H,385,0,03H
	.word	04043H,462,0,03H
	.word	04043H,539,0,03H
	.word	04043H,616,0,03H
	.word	04043H,693,0,03H
	.word	04043H,770,0,03H
	.word	04043H,847,0,03H
	.word	04043H,924,0,03H
	.word	0FFFFH	;End Marker
arena3BLKS:
	.word	04043H	;flags
	.word	0,0 ;x,y
	.word	04H	;pal5,pal4,hdr13-0
	.word	04043H,77,0,04H
	.word	04043H,154,0,04H
	.word	04043H,231,0,04H
	.word	04043H,308,0,04H
	.word	04043H,385,0,04H
	.word	04043H,462,0,04H
	.word	04043H,539,0,04H
	.word	04043H,616,0,04H
	.word	04043H,693,0,04H
	.word	04043H,770,0,04H
	.word	04043H,847,0,04H
	.word	04043H,924,0,04H
	.word	04043H,1001,0,04H
	.word	0FFFFH	;End Marker
arena2BLKS:
	.word	04047H	;flags
	.word	0,120 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	04047H,17,113,00H
	.word	04047H,17,113,00H
	.word	04047H,76,120,01H
	.word	04047H,143,113,00H
	.word	04147H,144,120,0CH
	.word	04257H,150,75,0DH
	.word	04147H,182,110,0FH
	.word	04047H,182,130,010H
	.word	04047H,258,120,011H
	.word	04047H,269,113,00H
	.word	04247H,272,75,0DH
	.word	04047H,305,120,01H
	.word	04147H,373,120,014H
	.word	04344H,380,76,015H
	.word	04244H,395,130,016H
	.word	04244H,395,105,017H
	.word	04344H,402,61,015H
	.word	04044H,449,59,018H
	.word	04244H,450,105,019H
	.word	04244H,461,0,01AH
	.word	04244H,465,39,01BH
	.word	04254H,500,105,019H
	.word	04254H,501,39,01BH
	.word	04254H,501,0,01AH
	.word	04054H,501,59,018H
	.word	04254H,503,130,016H
	.word	04254H,555,105,017H
	.word	04344H,588,61,015H
	.word	04157H,609,120,014H
	.word	04047H,611,113,00H
	.word	04344H,613,76,015H
	.word	04047H,625,120,01H
	.word	04057H,700,120,011H
	.word	04257H,718,75,0DH
	.word	04047H,737,113,00H
	.word	04246H,748,130,01CH
	.word	04256H,748,110,01DH
	.word	04157H,822,120,0CH
	.word	04247H,840,75,0DH
	.word	04047H,854,120,01H
	.word	04047H,863,113,00H
	.word	04047H,930,120,01H
	.word	04047H,989,113,00H
	.word	04047H,1006,120,01H
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
	.word	0,102 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04041H,2,47,01H
	.word	04045H,19,183,02H
	.word	04040H,29,0,03H
	.word	04042H,135,47,04H
	.word	04044H,143,102,05H
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
	.word	0,0 ;x,y
	.word	02H	;pal5,pal4,hdr13-0
	.word	04041H,0,126,03H
	.word	04042H,42,0,09H
	.word	04042H,110,0,012H
	.word	04041H,141,145,015H
	.word	03F41H,141,176,016H
	.word	04042H,196,0,020H
	.word	04042H,196,114,021H
	.word	04051H,227,145,015H
	.word	04041H,260,176,02FH
	.word	04042H,279,0,032H
	.word	04041H,303,181,036H
	.word	03F41H,308,186,037H
	.word	04041H,313,142,039H
	.word	04042H,318,111,03BH
	.word	0FFFFH	;End Marker
mount1BLKS:
	.word	04040H	;flags
	.word	0,860 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04140H,8,771,01H
	.word	04143H,91,878,04H
	.word	04044H,91,937,05H
	.word	04040H,106,870,06H
	.word	04040H,106,821,07H
	.word	04040H,108,772,08H
	.word	04040H,142,766,0AH
	.word	04040H,145,725,0BH
	.word	04040H,164,827,0CH
	.word	04040H,164,781,0DH
	.word	04040H,164,697,0EH
	.word	04040H,164,730,0FH
	.word	04040H,173,668,010H
	.word	04140H,180,579,01H
	.word	04040H,181,870,011H
	.word	04040H,201,826,013H
	.word	04040H,201,768,014H
	.word	04044H,227,934,017H
	.word	04143H,229,878,018H
	.word	04040H,230,520,019H
	.word	04040H,231,768,01AH
	.word	04040H,241,730,01BH
	.word	04040H,244,446,019H
	.word	04040H,246,594,01CH
	.word	04040H,247,820,01DH
	.word	04140H,258,357,01H
	.word	04040H,260,668,01EH
	.word	04140H,261,749,01FH
	.word	04040H,277,588,01DH
	.word	04040H,297,328,019H
	.word	04040H,298,768,022H
	.word	04140H,303,717,01FH
	.word	04040H,304,570,023H
	.word	04040H,310,730,024H
	.word	04040H,310,285,025H
	.word	04040H,312,231,026H
	.word	04140H,313,501,01FH
	.word	04040H,319,816,01DH
	.word	04140H,325,788,027H
	.word	04043H,325,943,028H
	.word	04040H,326,170,029H
	.word	04040H,326,102,02AH
	.word	04040H,328,499,02BH
	.word	04140H,329,428,01FH
	.word	04040H,333,0,02CH
	.word	04143H,334,880,02DH
	.word	04140H,336,572,027H
	.word	04144H,337,928,02EH
	.word	04040H,343,452,02BH
	.word	04040H,347,571,030H
	.word	04140H,350,499,027H
	.word	04140H,351,499,027H
	.word	04040H,352,600,01DH
	.word	04040H,353,709,030H
	.word	04140H,353,682,031H
	.word	04140H,356,383,01FH
	.word	04140H,358,749,01FH
	.word	04040H,358,526,02BH
	.word	04040H,372,781,033H
	.word	04040H,376,286,027H
	.word	04040H,376,584,023H
	.word	04040H,377,402,02BH
	.word	04140H,377,453,027H
	.word	04040H,377,709,030H
	.word	04140H,380,820,027H
	.word	04253H,381,922,034H
	.word	04040H,382,328,035H
	.word	04040H,383,471,02BH
	.word	04040H,384,821,030H
	.word	04140H,389,807,01DH
	.word	04040H,391,679,038H
	.word	04040H,391,743,038H
	.word	04240H,393,670,01FH
	.word	04040H,396,545,02BH
	.word	04243H,396,922,03AH
	.word	04040H,398,615,038H
	.word	04040H,398,807,038H
	.word	04144H,406,930,03CH
	.word	04243H,406,880,02DH
	.word	04040H,413,402,03DH
	.word	04040H,413,791,023H
	.word	04140H,415,741,027H
	.word	04040H,420,471,02BH
	.word	04040H,421,326,03EH
	.word	04040H,430,545,035H
	.word	04040H,457,774,030H
	.word	04040H,466,858,030H
	.word	04040H,468,536,03EH
	.word	04040H,484,744,030H
	.word	04040H,485,680,030H
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
	.word	0,5 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04048H,1,0,01H
	.word	04049H,1,93,02H
	.word	04041H,1,177,03H
	.word	04045H,14,190,04H
	.word	04042H,35,78,05H
	.word	0404BH,36,0,06H
	.word	04041H,36,218,07H
	.word	04040H,40,2,08H
	.word	04046H,71,219,09H
	.word	0404DH,93,0,0AH
	.word	04044H,100,8,0BH
	.word	04047H,124,219,0CH
	.word	0404CH,194,78,0DH
	.word	04EH,205,0,0EH
	.word	04AH,205,108,0FH
	.word	0FFFFH	;End Marker
WINNER2BLKS:
	.word	05EH	;flags
	.word	0,0 ;x,y
	.word	0EH	;pal5,pal4,hdr13-0
	.word	05AH,0,108,0FH
	.word	04057H,9,219,0CH
	.word	0405CH,11,78,0DH
	.word	0405DH,12,0,0AH
	.word	04042H,23,78,05H
	.word	04143H,40,8,010H
	.word	04056H,90,219,09H
	.word	0405BH,121,0,06H
	.word	04050H,129,2,08H
	.word	04051H,133,218,07H
	.word	04055H,143,190,04H
	.word	04050H,177,5,00H
	.word	04058H,180,0,01H
	.word	04059H,180,93,02H
	.word	04051H,180,177,03H
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
	.word	0,4 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,101,01H
	.word	04040H,0,154,01H
	.word	03C40H,0,207,02H
	.word	04040H,0,48,01H
	.word	04350H,0,16,03H
	.word	04350H,0,50,04H
	.word	04050H,8,198,05H
	.word	04350H,15,176,06H
	.word	04350H,18,150,04H
	.word	04340H,38,0,06H
	.word	04340H,42,209,06H
	.word	04050H,43,139,05H
	.word	04040H,50,43,07H
	.word	04040H,51,4,00H
	.word	03C40H,51,207,02H
	.word	04040H,51,206,08H
	.word	04040H,88,226,09H
	.word	04040H,102,4,00H
	.word	03C40H,102,207,02H
	.word	04040H,153,4,00H
	.word	03C40H,153,207,02H
	.word	03C40H,169,206,02H
	.word	04040H,194,153,0AH
	.word	04040H,194,48,0AH
	.word	04040H,194,101,0AH
	.word	04350H,197,65,06H
	.word	04070H,198,207,05H
	.word	04040H,204,4,00H
	.word	04050H,204,226,09H
	.word	03C40H,204,207,02H
	.word	04040H,206,43,07H
	.word	04040H,207,206,08H
	.word	04040H,255,4,00H
	.word	03C40H,255,207,02H
	.word	04040H,306,4,00H
	.word	03C40H,306,207,02H
	.word	04340H,307,15,04H
	.word	04340H,314,209,03H
	.word	04340H,329,235,06H
	.word	04050H,350,154,01H
	.word	04050H,350,101,01H
	.word	04050H,350,48,01H
	.word	04040H,355,4,00H
	.word	03C40H,355,207,02H
	.word	04340H,374,122,06H
	.word	04350H,378,102,04H
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
	.word	0,50 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	03241H,0,100,00H
	.word	03241H,0,150,00H
	.word	03241H,15,200,00H
	.word	03241H,15,250,00H
	.word	04041H,37,103,01H
	.word	04041H,37,107,01H
	.word	03241H,37,0,00H
	.word	04041H,49,107,01H
	.word	04041H,49,103,01H
	.word	03241H,50,150,00H
	.word	03241H,50,50,00H
	.word	03241H,50,100,00H
	.word	04042H,51,151,02H
	.word	04052H,61,158,03H
	.word	04041H,65,192,04H
	.word	04041H,65,196,05H
	.word	04041H,65,278,06H
	.word	03241H,65,282,00H
	.word	04041H,68,278,07H
	.word	04041H,68,192,08H
	.word	04643H,69,196,00H
	.word	04643H,69,228,00H
	.word	04052H,71,76,02H
	.word	03241H,87,0,00H
	.word	04041H,89,58,09H
	.word	04041H,89,103,0AH
	.word	04041H,89,108,0BH
	.word	04041H,89,184,0CH
	.word	04041H,89,108,09H
	.word	04041H,89,138,09H
	.word	04041H,89,41,0DH
	.word	04041H,89,43,09H
	.word	04041H,91,184,01H
	.word	04041H,92,41,01H
	.word	04041H,94,90,09H
	.word	04041H,94,180,0CH
	.word	04041H,94,134,09H
	.word	04041H,94,47,09H
	.word	04041H,94,45,0DH
	.word	04041H,95,180,01H
	.word	04041H,97,45,01H
	.word	04041H,100,173,06H
	.word	03C41H,100,99,0EH
	.word	03C41H,100,54,0EH
	.word	04041H,100,50,04H
	.word	03241H,100,177,00H
	.word	04041H,104,173,07H
	.word	04041H,104,50,08H
	.word	04041H,114,180,01H
	.word	03241H,115,282,00H
	.word	04041H,118,184,01H
	.word	04643H,119,196,00H
	.word	04643H,119,228,00H
	.word	04041H,127,278,07H
	.word	04041H,127,192,08H
	.word	04041H,132,41,01H
	.word	04041H,137,45,01H
	.word	03241H,137,0,00H
	.word	04041H,149,173,07H
	.word	03241H,150,177,00H
	.word	04041H,153,180,01H
	.word	04041H,156,184,01H
	.word	04041H,163,50,08H
	.word	03241H,165,282,00H
	.word	04643H,169,196,00H
	.word	04643H,169,228,00H
	.word	04041H,172,41,01H
	.word	04041H,177,45,01H
	.word	04041H,186,278,07H
	.word	04041H,186,192,08H
	.word	03241H,187,0,00H
	.word	04041H,193,180,01H
	.word	04041H,196,184,01H
	.word	03241H,200,177,00H
	.word	04041H,207,173,07H
	.word	04041H,212,41,01H
	.word	03241H,215,282,00H
	.word	04041H,217,45,01H
	.word	04643H,219,196,00H
	.word	04643H,219,228,00H
	.word	04041H,222,50,08H
	.word	04041H,233,180,01H
	.word	04041H,235,184,01H
	.word	03241H,237,0,00H
	.word	04041H,245,278,07H
	.word	04041H,245,192,08H
	.word	03241H,250,177,00H
	.word	04041H,252,41,01H
	.word	04041H,257,45,01H
	.word	03241H,265,282,00H
	.word	04041H,266,173,07H
	.word	04643H,269,196,00H
	.word	04643H,269,228,00H
	.word	04041H,273,180,01H
	.word	04041H,275,184,01H
	.word	04041H,281,50,08H
	.word	03241H,287,0,00H
	.word	04041H,292,41,01H
	.word	04041H,296,45,01H
	.word	03241H,300,176,00H
	.word	04041H,304,278,07H
	.word	04041H,304,192,08H
	.word	04041H,313,180,01H
	.word	04041H,315,184,01H
	.word	03241H,315,282,00H
	.word	04643H,319,196,00H
	.word	04643H,319,228,00H
	.word	04041H,324,50,08H
	.word	04041H,325,173,07H
	.word	04041H,332,41,01H
	.word	04041H,336,45,01H
	.word	03241H,337,0,00H
	.word	03241H,350,177,00H
	.word	04041H,352,180,01H
	.word	04041H,352,45,01H
	.word	04041H,355,184,01H
	.word	04041H,357,41,01H
	.word	04041H,359,192,08H
	.word	04041H,363,278,07H
	.word	03241H,365,282,00H
	.word	04643H,369,196,00H
	.word	04643H,369,228,00H
	.word	04041H,383,54,0FH
	.word	04041H,383,50,010H
	.word	04041H,383,99,0FH
	.word	04041H,383,173,011H
	.word	03241H,387,142,00H
	.word	03241H,387,92,00H
	.word	03241H,387,42,00H
	.word	04041H,390,45,0BH
	.word	04041H,391,89,09H
	.word	04041H,391,180,0AH
	.word	04041H,391,47,09H
	.word	04041H,391,134,09H
	.word	04041H,395,41,0BH
	.word	04052H,395,142,012H
	.word	04041H,396,59,09H
	.word	04041H,396,110,09H
	.word	04041H,396,108,0DH
	.word	04041H,396,104,0CH
	.word	04041H,396,184,0AH
	.word	04041H,396,139,09H
	.word	04041H,396,43,09H
	.word	04041H,398,104,01H
	.word	04041H,398,108,01H
	.word	03241H,415,282,00H
	.word	04041H,418,196,013H
	.word	04041H,418,192,010H
	.word	04041H,418,278,011H
	.word	03241H,422,232,00H
	.word	03241H,422,182,00H
	.word	04041H,434,104,01H
	.word	04041H,434,108,01H
	.word	03241H,437,132,00H
	.word	03241H,437,82,00H
	.word	03241H,437,32,00H
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
	.word	0,280 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	03241H,0,230,00H
	.word	03241H,20,185,00H
	.word	03241H,20,135,00H
	.word	03241H,20,85,00H
	.word	03241H,20,35,00H
	.word	04041H,40,239,01H
	.word	04041H,40,295,02H
	.word	04041H,40,235,03H
	.word	04040H,43,238,04H
	.word	04052H,43,180,05H
	.word	04041H,44,235,06H
	.word	04041H,44,295,07H
	.word	03241H,50,299,00H
	.word	04052H,56,39,08H
	.word	03C41H,70,53,09H
	.word	03C41H,70,84,09H
	.word	03C41H,70,158,09H
	.word	04041H,70,231,02H
	.word	04041H,70,50,03H
	.word	03241H,70,0,00H
	.word	04041H,73,50,06H
	.word	04041H,74,231,07H
	.word	04044H,74,58,0AH
	.word	04040H,90,238,04H
	.word	03241H,100,299,00H
	.word	04041H,103,235,06H
	.word	04041H,103,295,07H
	.word	03241H,120,0,00H
	.word	04041H,125,231,07H
	.word	04041H,131,50,06H
	.word	04040H,137,238,04H
	.word	03241H,150,299,00H
	.word	04044H,159,99,0BH
	.word	04041H,162,235,06H
	.word	04041H,162,295,07H
	.word	03241H,170,0,00H
	.word	04041H,184,231,07H
	.word	04040H,184,238,04H
	.word	04045H,185,159,0CH
	.word	04041H,190,50,06H
	.word	03241H,200,299,00H
	.word	04045H,218,97,0DH
	.word	03241H,220,0,00H
	.word	04041H,221,235,06H
	.word	04041H,221,295,07H
	.word	04040H,231,238,04H
	.word	04041H,243,231,07H
	.word	04041H,249,50,06H
	.word	03241H,250,299,00H
	.word	04045H,258,89,0EH
	.word	03241H,270,0,00H
	.word	04040H,278,238,04H
	.word	04041H,280,235,06H
	.word	04041H,280,295,07H
	.word	03241H,300,299,00H
	.word	04041H,302,231,07H
	.word	04041H,302,50,06H
	.word	03241H,320,0,00H
	.word	04040H,325,238,04H
	.word	04041H,333,235,06H
	.word	04041H,334,295,07H
	.word	04040H,344,238,04H
	.word	03241H,350,298,00H
	.word	04041H,361,157,0FH
	.word	04041H,361,83,0FH
	.word	04041H,361,53,0FH
	.word	04041H,361,231,010H
	.word	04041H,361,50,011H
	.word	04052H,362,54,05H
	.word	04042H,364,197,08H
	.word	03241H,365,135,00H
	.word	03241H,365,85,00H
	.word	03241H,365,35,00H
	.word	03241H,365,185,00H
	.word	04041H,392,235,011H
	.word	04041H,392,239,012H
	.word	04041H,392,295,010H
	.word	03241H,396,235,00H
	.word	03241H,396,285,00H
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
	.word	0,280 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	03241H,0,230,00H
	.word	03241H,20,185,00H
	.word	03241H,20,135,00H
	.word	03241H,20,85,00H
	.word	03241H,20,35,00H
	.word	04041H,40,239,01H
	.word	04041H,40,295,02H
	.word	04041H,40,235,03H
	.word	04040H,43,238,04H
	.word	04052H,43,180,05H
	.word	04041H,44,235,06H
	.word	04041H,44,295,07H
	.word	03241H,50,299,00H
	.word	04052H,56,39,08H
	.word	03C41H,70,53,09H
	.word	03C41H,70,84,09H
	.word	03C41H,70,158,09H
	.word	04041H,70,231,02H
	.word	04041H,70,50,03H
	.word	03241H,70,0,00H
	.word	04041H,73,50,06H
	.word	04041H,74,231,07H
	.word	04043H,81,66,0AH
	.word	04040H,90,238,04H
	.word	03241H,100,299,00H
	.word	04041H,103,235,06H
	.word	04041H,103,295,07H
	.word	03241H,120,0,00H
	.word	04041H,125,231,07H
	.word	04041H,131,50,06H
	.word	04040H,137,238,04H
	.word	03241H,150,299,00H
	.word	04043H,150,108,0BH
	.word	04041H,162,235,06H
	.word	04041H,162,295,07H
	.word	03241H,170,0,00H
	.word	04041H,184,231,07H
	.word	04040H,184,238,04H
	.word	04041H,190,50,06H
	.word	03241H,200,299,00H
	.word	03241H,220,0,00H
	.word	04041H,221,235,06H
	.word	04041H,221,295,07H
	.word	04044H,226,101,0CH
	.word	04040H,231,238,04H
	.word	04041H,243,231,07H
	.word	04041H,249,50,06H
	.word	03241H,250,299,00H
	.word	03241H,270,0,00H
	.word	04040H,278,238,04H
	.word	04041H,280,235,06H
	.word	04041H,280,295,07H
	.word	04045H,286,113,0DH
	.word	03241H,300,299,00H
	.word	04041H,302,231,07H
	.word	04041H,302,50,06H
	.word	03241H,320,0,00H
	.word	04040H,325,238,04H
	.word	04041H,333,235,06H
	.word	04041H,334,295,07H
	.word	04040H,344,238,04H
	.word	03241H,350,298,00H
	.word	04041H,361,157,0EH
	.word	04041H,361,83,0EH
	.word	04041H,361,53,0EH
	.word	04041H,361,231,0FH
	.word	04041H,361,50,010H
	.word	04052H,362,54,05H
	.word	04042H,364,197,08H
	.word	03241H,365,135,00H
	.word	03241H,365,85,00H
	.word	03241H,365,35,00H
	.word	03241H,365,185,00H
	.word	04041H,392,235,010H
	.word	04041H,392,239,011H
	.word	04041H,392,295,0FH
	.word	03241H,396,235,00H
	.word	03241H,396,285,00H
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
	.word	0,280 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	03241H,0,230,00H
	.word	03241H,20,185,00H
	.word	03241H,20,135,00H
	.word	03241H,20,85,00H
	.word	03241H,20,35,00H
	.word	04041H,40,239,01H
	.word	04041H,40,295,02H
	.word	04041H,40,235,03H
	.word	04040H,43,238,04H
	.word	04052H,43,180,05H
	.word	04041H,44,235,06H
	.word	04041H,44,295,07H
	.word	03241H,50,299,00H
	.word	04052H,56,39,08H
	.word	03C41H,70,53,09H
	.word	03C41H,70,84,09H
	.word	03C41H,70,158,09H
	.word	04041H,70,231,02H
	.word	04041H,70,50,03H
	.word	03241H,70,0,00H
	.word	04041H,73,50,06H
	.word	04041H,74,231,07H
	.word	04040H,90,238,04H
	.word	03241H,100,299,00H
	.word	04041H,103,235,06H
	.word	04041H,103,295,07H
	.word	03241H,120,0,00H
	.word	04041H,125,231,07H
	.word	04041H,131,50,06H
	.word	04040H,137,238,04H
	.word	03241H,150,299,00H
	.word	04041H,162,235,06H
	.word	04041H,162,295,07H
	.word	03241H,170,0,00H
	.word	04041H,184,231,07H
	.word	04040H,184,238,04H
	.word	04041H,190,50,06H
	.word	03241H,200,299,00H
	.word	03241H,220,0,00H
	.word	04041H,221,235,06H
	.word	04041H,221,295,07H
	.word	04040H,231,238,04H
	.word	04041H,243,231,07H
	.word	04041H,249,50,06H
	.word	03241H,250,299,00H
	.word	03241H,270,0,00H
	.word	04040H,278,238,04H
	.word	04041H,280,235,06H
	.word	04041H,280,295,07H
	.word	03241H,300,299,00H
	.word	04041H,302,231,07H
	.word	04041H,302,50,06H
	.word	03241H,320,0,00H
	.word	04040H,325,238,04H
	.word	04041H,333,235,06H
	.word	04041H,334,295,07H
	.word	04040H,344,238,04H
	.word	03241H,350,298,00H
	.word	04041H,361,157,0AH
	.word	04041H,361,83,0AH
	.word	04041H,361,53,0AH
	.word	04041H,361,231,0BH
	.word	04041H,361,50,0CH
	.word	04052H,362,54,05H
	.word	04042H,364,197,08H
	.word	03241H,365,135,00H
	.word	03241H,365,85,00H
	.word	03241H,365,35,00H
	.word	03241H,365,185,00H
	.word	04041H,392,235,0CH
	.word	04041H,392,239,0DH
	.word	04041H,392,295,0BH
	.word	03241H,396,235,00H
	.word	03241H,396,285,00H
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
	.word	0,280 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	03241H,0,230,00H
	.word	03241H,20,185,00H
	.word	03241H,20,135,00H
	.word	03241H,20,85,00H
	.word	03241H,20,35,00H
	.word	04041H,40,239,01H
	.word	04041H,40,295,02H
	.word	04041H,40,235,03H
	.word	04040H,43,238,04H
	.word	04052H,43,180,05H
	.word	04041H,44,235,06H
	.word	04041H,44,295,07H
	.word	03241H,50,299,00H
	.word	04052H,56,39,08H
	.word	03C41H,70,53,09H
	.word	03C41H,70,84,09H
	.word	03C41H,70,158,09H
	.word	04041H,70,231,02H
	.word	04041H,70,50,03H
	.word	03241H,70,0,00H
	.word	04041H,73,50,06H
	.word	04041H,74,231,07H
	.word	04040H,90,238,04H
	.word	03241H,100,299,00H
	.word	04041H,103,235,06H
	.word	04041H,103,295,07H
	.word	03241H,120,0,00H
	.word	04041H,125,231,07H
	.word	04041H,131,50,06H
	.word	04040H,137,238,04H
	.word	04043H,139,56,0AH
	.word	03241H,150,299,00H
	.word	04041H,162,235,06H
	.word	04041H,162,295,07H
	.word	03241H,170,0,00H
	.word	04041H,184,231,07H
	.word	04040H,184,238,04H
	.word	04041H,190,50,06H
	.word	03241H,200,299,00H
	.word	03241H,220,0,00H
	.word	04041H,221,235,06H
	.word	04041H,221,295,07H
	.word	04040H,231,238,04H
	.word	04041H,243,231,07H
	.word	04041H,249,50,06H
	.word	03241H,250,299,00H
	.word	03241H,270,0,00H
	.word	04040H,278,238,04H
	.word	04041H,280,235,06H
	.word	04041H,280,295,07H
	.word	03241H,300,299,00H
	.word	04041H,302,231,07H
	.word	04041H,302,50,06H
	.word	03241H,320,0,00H
	.word	04040H,325,238,04H
	.word	04041H,333,235,06H
	.word	04041H,334,295,07H
	.word	04040H,344,238,04H
	.word	03241H,350,298,00H
	.word	04041H,361,157,0BH
	.word	04041H,361,83,0BH
	.word	04041H,361,53,0BH
	.word	04041H,361,231,0CH
	.word	04041H,361,50,0DH
	.word	04052H,362,54,05H
	.word	04042H,364,197,08H
	.word	03241H,365,135,00H
	.word	03241H,365,85,00H
	.word	03241H,365,35,00H
	.word	03241H,365,185,00H
	.word	04041H,392,235,0DH
	.word	04041H,392,239,0EH
	.word	04041H,392,295,0CH
	.word	03241H,396,235,00H
	.word	03241H,396,285,00H
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
	.word	0,0 ;x,y
	.word	09H	;pal5,pal4,hdr13-0
	.word	04143H,112,2,0CH
	.word	04044H,143,0,09H
	.word	04153H,278,3,011H
	.word	04044H,286,0,09H
	.word	04044H,429,0,09H
	.word	04143H,510,3,01DH
	.word	04143H,557,0,0CH
	.word	04044H,572,0,09H
	.word	04143H,616,7,01FH
	.word	04143H,639,4,011H
	.word	04044H,715,0,09H
	.word	04044H,858,0,09H
	.word	04153H,910,3,0CH
	.word	04153H,972,4,01DH
	.word	04044H,1001,0,09H
	.word	0FFFFH	;End Marker
dun2BLKS:
	.word	04044H	;flags
	.word	0,0 ;x,y
	.word	07H	;pal5,pal4,hdr13-0
	.word	04044H,143,0,07H
	.word	04044H,286,0,07H
	.word	04044H,429,0,07H
	.word	04044H,572,0,07H
	.word	04044H,715,0,07H
	.word	04044H,858,0,07H
	.word	04044H,1001,0,07H
	.word	0FFFFH	;End Marker
dun3BLKS:
	.word	04044H	;flags
	.word	0,0 ;x,y
	.word	06H	;pal5,pal4,hdr13-0
	.word	04044H,143,0,06H
	.word	04044H,286,0,06H
	.word	04044H,429,0,06H
	.word	04044H,572,0,06H
	.word	04044H,715,0,06H
	.word	04044H,858,0,06H
	.word	04044H,1001,0,06H
	.word	0FFFFH	;End Marker
dun4BLKS:
	.word	04044H	;flags
	.word	0,313 ;x,y
	.word	08H	;pal5,pal4,hdr13-0
	.word	04142H,72,300,0BH
	.word	04045H,121,200,0DH
	.word	04045H,130,0,0EH
	.word	04045H,133,200,0FH
	.word	04045H,133,100,0EH
	.word	04044H,143,313,08H
	.word	04142H,153,300,0BH
	.word	04045H,211,0,0EH
	.word	04046H,214,200,010H
	.word	04045H,214,100,0EH
	.word	04142H,234,300,0BH
	.word	04155H,284,247,012H
	.word	04044H,286,313,08H
	.word	04045H,292,0,0EH
	.word	04045H,292,203,013H
	.word	04045H,294,128,014H
	.word	04045H,295,101,015H
	.word	04045H,295,161,016H
	.word	04153H,311,302,017H
	.word	04055H,314,100,018H
	.word	04052H,314,299,019H
	.word	04045H,371,104,01AH
	.word	04045H,373,0,0EH
	.word	04055H,376,100,018H
	.word	04143H,415,308,01BH
	.word	04044H,429,313,08H
	.word	04055H,439,100,018H
	.word	04045H,454,0,0EH
	.word	04143H,461,307,01CH
	.word	04055H,488,99,018H
	.word	04055H,511,100,018H
	.word	04045H,535,0,0EH
	.word	04055H,535,101,015H
	.word	04055H,562,128,014H
	.word	04044H,572,313,08H
	.word	04055H,576,161,016H
	.word	04055H,585,203,013H
	.word	04145H,590,247,012H
	.word	04042H,596,299,019H
	.word	04042H,600,300,01EH
	.word	04045H,606,200,0FH
	.word	04045H,606,100,0EH
	.word	04045H,616,0,0EH
	.word	04150H,632,104,020H
	.word	04343H,635,104,021H
	.word	04343H,650,121,022H
	.word	04243H,651,309,023H
	.word	04343H,658,133,024H
	.word	04343H,669,154,025H
	.word	04343H,676,163,026H
	.word	04045H,687,200,0FH
	.word	04045H,687,100,0EH
	.word	04343H,690,171,027H
	.word	04343H,692,198,028H
	.word	04142H,692,300,01EH
	.word	04343H,693,150,029H
	.word	04343H,693,221,02AH
	.word	04045H,697,0,0EH
	.word	04044H,715,313,08H
	.word	04343H,719,155,02BH
	.word	04343H,719,277,02CH
	.word	04343H,738,135,02DH
	.word	04343H,747,120,02EH
	.word	04045H,751,200,02FH
	.word	04353H,752,104,021H
	.word	04140H,752,104,020H
	.word	04155H,756,247,012H
	.word	04045H,765,203,013H
	.word	04045H,768,100,030H
	.word	04045H,769,161,016H
	.word	04045H,770,129,014H
	.word	04045H,773,102,015H
	.word	04045H,778,0,0EH
	.word	04052H,784,300,019H
	.word	04055H,811,100,018H
	.word	04045H,848,104,01AH
	.word	04044H,858,313,08H
	.word	04045H,859,0,0EH
	.word	04055H,871,100,018H
	.word	04153H,883,311,01BH
	.word	04045H,935,100,018H
	.word	04045H,940,0,0EH
	.word	04143H,958,300,017H
	.word	04045H,973,99,018H
	.word	04044H,1001,313,08H
	.word	04055H,1016,101,015H
	.word	04045H,1021,1,0EH
	.word	04055H,1044,128,014H
	.word	04055H,1054,161,016H
	.word	04055H,1061,203,013H
	.word	04145H,1065,247,012H
	.word	04042H,1068,299,019H
	.word	04142H,1072,300,0BH
	.word	04046H,1086,200,010H
	.word	04045H,1090,101,0EH
	.word	04045H,1102,0,0EH
	.word	04044H,1144,313,08H
	.word	04142H,1153,300,0BH
	.word	04045H,1166,101,0EH
	.word	04046H,1167,200,010H
	.word	0FFFFH	;End Marker
dun5BLKS:
	.word	04044H	;flags
	.word	0,0 ;x,y
	.word	0AH	;pal5,pal4,hdr13-0
	.word	04044H,143,0,0AH
	.word	04044H,286,0,0AH
	.word	04044H,429,0,0AH
	.word	04044H,572,0,0AH
	.word	04044H,715,0,0AH
	.word	04044H,858,0,0AH
	.word	0FFFFH	;End Marker
dun8BLKS:
	.word	04044H	;flags
	.word	0,196 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	04041H,15,0,02H
	.word	04041H,15,49,02H
	.word	04041H,31,98,00H
	.word	04041H,55,0,02H
	.word	04041H,55,49,02H
	.word	04041H,79,98,04H
	.word	04041H,95,0,02H
	.word	04041H,95,49,02H
	.word	04041H,103,148,05H
	.word	04041H,135,0,02H
	.word	04041H,135,49,02H
	.word	04051H,139,98,04H
	.word	04051H,139,148,05H
	.word	04044H,143,196,01H
	.word	04041H,175,0,02H
	.word	04041H,175,49,02H
	.word	04041H,195,98,00H
	.word	04041H,215,0,02H
	.word	04041H,215,49,02H
	.word	04041H,247,98,00H
	.word	04041H,255,0,02H
	.word	04041H,255,49,02H
	.word	04044H,286,196,01H
	.word	04041H,295,0,02H
	.word	04041H,295,49,02H
	.word	04041H,299,98,00H
	.word	04041H,335,0,02H
	.word	04041H,335,49,02H
	.word	04041H,338,98,04H
	.word	04041H,363,148,05H
	.word	04041H,375,0,02H
	.word	04041H,375,49,02H
	.word	04051H,398,98,04H
	.word	04051H,399,148,05H
	.word	04041H,415,0,02H
	.word	04041H,415,49,02H
	.word	04044H,429,196,01H
	.word	04041H,451,97,00H
	.word	04041H,455,0,02H
	.word	04041H,455,49,02H
	.word	04041H,495,0,02H
	.word	04041H,495,49,02H
	.word	04041H,503,97,00H
	.word	04041H,535,0,02H
	.word	04041H,535,49,02H
	.word	04041H,555,97,00H
	.word	04044H,572,196,01H
	.word	04041H,575,0,02H
	.word	04041H,575,49,02H
	.word	04041H,592,98,04H
	.word	04041H,615,0,02H
	.word	04041H,615,49,02H
	.word	04041H,617,148,05H
	.word	04051H,652,98,04H
	.word	04051H,653,148,05H
	.word	04041H,655,0,02H
	.word	04041H,655,49,02H
	.word	04041H,695,0,02H
	.word	04041H,695,49,02H
	.word	04041H,708,98,00H
	.word	04044H,714,196,01H
	.word	04041H,735,0,02H
	.word	04041H,735,49,02H
	.word	0FFFFH	;End Marker
dun9BLKS:
	.word	04044H	;flags
	.word	0,0 ;x,y
	.word	03H	;pal5,pal4,hdr13-0
	.word	04044H,124,0,03H
	.word	04044H,267,0,03H
	.word	04044H,410,0,03H
	.word	04044H,553,0,03H
	.word	0FFFFH	;End Marker
dun10BLKS:
	.word	04054H	;flags
	.word	0,0 ;x,y
	.word	03H	;pal5,pal4,hdr13-0
	.word	04054H,143,0,03H
	.word	04054H,286,0,03H
	.word	04044H,430,0,03H
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
	.word	0,154 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,104,00H
	.word	04040H,0,54,00H
	.word	04040H,0,204,00H
	.word	04040H,0,254,00H
	.word	04040H,0,4,00H
	.word	04840H,47,45,01H
	.word	04640H,47,48,02H
	.word	04640H,47,94,02H
	.word	04640H,47,140,02H
	.word	04640H,47,186,02H
	.word	04640H,47,232,02H
	.word	04640H,47,249,02H
	.word	04140H,47,295,03H
	.word	04040H,50,0,00H
	.word	04640H,50,290,04H
	.word	04640H,50,49,05H
	.word	04240H,50,53,06H
	.word	04240H,50,127,06H
	.word	04240H,50,216,06H
	.word	04240H,50,201,06H
	.word	04840H,50,295,07H
	.word	04040H,50,294,00H
	.word	04840H,50,45,08H
	.word	04840H,54,290,09H
	.word	04240H,54,49,0AH
	.word	03D41H,54,53,0BH
	.word	03C41H,54,103,0BH
	.word	03C41H,54,153,0BH
	.word	03C41H,54,203,0BH
	.word	03C41H,54,240,0BH
	.word	04741H,57,53,0BH
	.word	03C41H,57,103,0BH
	.word	03C41H,57,153,0BH
	.word	03C41H,57,203,0BH
	.word	03C41H,57,240,0BH
	.word	04840H,90,45,08H
	.word	04840H,90,295,07H
	.word	04040H,100,0,00H
	.word	04040H,100,294,00H
	.word	03D41H,107,53,0BH
	.word	03C41H,107,103,0BH
	.word	03C41H,107,153,0BH
	.word	03C41H,107,203,0BH
	.word	03C41H,107,240,0BH
	.word	04240H,112,49,0AH
	.word	04840H,113,290,09H
	.word	04840H,130,45,08H
	.word	04840H,130,295,07H
	.word	04040H,150,0,00H
	.word	04040H,150,294,00H
	.word	04741H,157,53,0BH
	.word	04741H,157,103,0BH
	.word	03C41H,157,153,0BH
	.word	03C41H,157,203,0BH
	.word	03C41H,157,240,0BH
	.word	04840H,170,45,08H
	.word	04840H,170,295,07H
	.word	04240H,171,49,0AH
	.word	04840H,172,290,09H
	.word	04040H,200,0,00H
	.word	04040H,200,294,00H
	.word	04741H,207,53,0BH
	.word	04741H,207,103,0BH
	.word	03C41H,207,153,0BH
	.word	03C41H,207,203,0BH
	.word	03C41H,207,240,0BH
	.word	04840H,210,45,08H
	.word	04840H,210,295,07H
	.word	04240H,230,49,0AH
	.word	04840H,231,290,09H
	.word	04040H,250,0,00H
	.word	04840H,250,45,08H
	.word	04840H,250,295,07H
	.word	04040H,250,294,00H
	.word	04741H,257,53,0BH
	.word	04741H,257,103,0BH
	.word	03C41H,257,153,0BH
	.word	03C41H,257,203,0BH
	.word	03C41H,257,240,0BH
	.word	04840H,289,49,0AH
	.word	04840H,290,290,09H
	.word	04840H,290,45,08H
	.word	04840H,290,295,07H
	.word	04040H,300,0,00H
	.word	04040H,300,294,00H
	.word	03C41H,307,53,0BH
	.word	04741H,307,103,0BH
	.word	03C41H,307,153,0BH
	.word	03C41H,307,203,0BH
	.word	03C41H,307,240,0BH
	.word	04840H,330,45,08H
	.word	04840H,330,295,07H
	.word	04840H,348,290,09H
	.word	04840H,348,49,0AH
	.word	04040H,350,0,00H
	.word	04040H,350,294,00H
	.word	04741H,357,203,0BH
	.word	04741H,357,153,0BH
	.word	03D41H,357,103,0BH
	.word	04741H,357,240,0BH
	.word	03C41H,357,53,0BH
	.word	04840H,370,295,07H
	.word	04840H,370,45,08H
	.word	04840H,372,295,07H
	.word	04840H,372,45,08H
	.word	04040H,400,294,00H
	.word	04040H,400,3,00H
	.word	04640H,407,49,0CH
	.word	04840H,407,290,0DH
	.word	04840H,407,216,0EH
	.word	04840H,407,142,0EH
	.word	04840H,407,68,0EH
	.word	04840H,407,53,0EH
	.word	04040H,410,53,00H
	.word	04040H,410,103,00H
	.word	04040H,411,153,00H
	.word	04040H,411,203,00H
	.word	04040H,411,253,00H
	.word	04640H,412,48,02H
	.word	04840H,412,45,0FH
	.word	04640H,412,94,02H
	.word	04640H,412,140,02H
	.word	04640H,412,186,02H
	.word	04640H,412,232,02H
	.word	04640H,412,249,02H
	.word	04840H,412,295,010H
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
	.word	0,154 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,104,00H
	.word	04040H,0,54,00H
	.word	04040H,0,204,00H
	.word	04040H,0,4,00H
	.word	04040H,0,254,00H
	.word	04640H,43,192,01H
	.word	04640H,43,238,02H
	.word	04640H,43,100,01H
	.word	04640H,43,146,01H
	.word	04640H,43,54,01H
	.word	04640H,43,45,01H
	.word	04840H,43,43,03H
	.word	04640H,46,238,04H
	.word	04840H,46,43,04H
	.word	04640H,50,50,05H
	.word	04240H,50,54,06H
	.word	04240H,50,126,06H
	.word	04640H,50,200,07H
	.word	04040H,50,204,00H
	.word	04040H,50,0,00H
	.word	04040H,50,254,00H
	.word	04240H,54,200,08H
	.word	04240H,54,50,09H
	.word	04640H,54,238,04H
	.word	04840H,54,43,04H
	.word	04240H,91,200,08H
	.word	04640H,94,238,04H
	.word	04840H,94,43,04H
	.word	04640H,100,204,05H
	.word	03B40H,100,200,06H
	.word	04040H,100,0,00H
	.word	04040H,100,241,00H
	.word	04640H,101,234,07H
	.word	04240H,104,204,09H
	.word	04240H,105,234,08H
	.word	04240H,113,50,09H
	.word	04240H,133,204,09H
	.word	04240H,133,234,08H
	.word	04640H,134,238,04H
	.word	04840H,134,43,04H
	.word	04240H,150,200,08H
	.word	04240H,150,50,09H
	.word	04040H,150,0,00H
	.word	04040H,150,241,00H
	.word	04640H,174,238,04H
	.word	04840H,174,43,04H
	.word	04640H,192,204,0AH
	.word	03B40H,192,200,0BH
	.word	04640H,192,234,0CH
	.word	04040H,196,200,00H
	.word	04040H,200,0,00H
	.word	04040H,200,250,00H
	.word	04040H,209,150,00H
	.word	04240H,209,126,0BH
	.word	04240H,209,52,0BH
	.word	04640H,209,50,0AH
	.word	04040H,209,100,00H
	.word	04040H,209,50,00H
	.word	04640H,209,200,0CH
	.word	04640H,214,55,01H
	.word	04640H,214,100,01H
	.word	04640H,214,192,01H
	.word	04640H,214,238,0DH
	.word	04640H,214,146,01H
	.word	04640H,214,46,01H
	.word	04840H,214,43,0EH
	.word	04840H,222,257,0FH
	.word	04640H,222,211,01H
	.word	04640H,222,165,01H
	.word	04640H,222,119,01H
	.word	04640H,222,73,01H
	.word	04640H,222,46,01H
	.word	04840H,222,43,03H
	.word	04840H,224,257,010H
	.word	04840H,225,43,04H
	.word	04840H,226,49,05H
	.word	04840H,226,176,06H
	.word	04840H,226,250,07H
	.word	04840H,226,53,06H
	.word	04840H,226,127,06H
	.word	04741H,227,53,011H
	.word	04741H,227,103,011H
	.word	04741H,227,153,011H
	.word	04741H,227,203,011H
	.word	04840H,230,250,08H
	.word	04840H,230,49,09H
	.word	04040H,250,0,00H
	.word	04040H,250,250,00H
	.word	04840H,254,257,010H
	.word	04840H,254,43,04H
	.word	03C41H,257,53,011H
	.word	04741H,257,103,011H
	.word	04741H,275,203,011H
	.word	04741H,277,153,011H
	.word	04840H,289,250,08H
	.word	04840H,289,49,09H
	.word	04840H,294,257,010H
	.word	04840H,294,43,04H
	.word	04040H,300,0,00H
	.word	04040H,300,250,00H
	.word	04741H,307,153,011H
	.word	03D41H,307,103,011H
	.word	03D41H,307,53,011H
	.word	04741H,325,203,011H
	.word	04840H,334,257,010H
	.word	04840H,334,43,04H
	.word	04840H,348,250,08H
	.word	04B40H,348,49,0AH
	.word	03F40H,348,34,0BH
	.word	03E70H,349,107,07H
	.word	04040H,350,0,00H
	.word	04040H,350,250,00H
	.word	04940H,352,46,012H
	.word	03F40H,352,107,09H
	.word	03C41H,357,53,011H
	.word	04741H,357,153,011H
	.word	03D41H,357,103,011H
	.word	04741H,359,203,011H
	.word	04840H,374,257,010H
	.word	04840H,374,43,04H
	.word	04040H,400,0,00H
	.word	04040H,400,250,00H
	.word	04840H,407,178,0BH
	.word	04640H,407,49,0AH
	.word	04840H,407,250,0CH
	.word	04840H,407,104,0BH
	.word	04B40H,407,107,0AH
	.word	04040H,411,50,00H
	.word	04040H,411,100,00H
	.word	04040H,411,150,00H
	.word	04040H,411,200,00H
	.word	04640H,414,46,01H
	.word	04640H,414,92,01H
	.word	04640H,414,138,01H
	.word	04640H,414,184,01H
	.word	04640H,414,213,01H
	.word	04840H,414,257,013H
	.word	04840H,414,43,0EH
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
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,250,00H
	.word	04040H,9,150,00H
	.word	04040H,9,100,00H
	.word	04040H,9,50,00H
	.word	04840H,22,257,01H
	.word	04640H,22,211,02H
	.word	04640H,22,165,02H
	.word	04640H,22,119,02H
	.word	04640H,22,73,02H
	.word	04640H,22,46,02H
	.word	04840H,22,43,03H
	.word	04840H,24,257,04H
	.word	04840H,25,43,05H
	.word	04840H,26,49,06H
	.word	04840H,26,176,07H
	.word	04840H,26,250,08H
	.word	04840H,26,53,07H
	.word	04840H,26,127,07H
	.word	04741H,27,53,09H
	.word	04741H,27,103,09H
	.word	04741H,27,153,09H
	.word	04741H,27,203,09H
	.word	04840H,30,250,0AH
	.word	04840H,30,49,0BH
	.word	04040H,50,0,00H
	.word	04040H,50,250,00H
	.word	04840H,54,257,04H
	.word	04840H,54,43,05H
	.word	03C41H,57,53,09H
	.word	04741H,57,103,09H
	.word	04741H,75,203,09H
	.word	04741H,77,153,09H
	.word	04840H,89,250,0AH
	.word	04840H,89,49,0BH
	.word	04840H,94,257,04H
	.word	04840H,94,43,05H
	.word	04040H,100,0,00H
	.word	04040H,100,250,00H
	.word	04741H,107,153,09H
	.word	03D41H,107,103,09H
	.word	03D41H,107,53,09H
	.word	04741H,125,203,09H
	.word	04840H,134,257,04H
	.word	04840H,134,43,05H
	.word	04840H,148,250,0AH
	.word	04B40H,148,49,0CH
	.word	03F40H,148,34,0DH
	.word	03E70H,149,107,08H
	.word	04040H,150,0,00H
	.word	04040H,150,250,00H
	.word	04940H,152,46,0EH
	.word	03F40H,152,107,0BH
	.word	03C41H,157,53,09H
	.word	04741H,157,153,09H
	.word	03D41H,157,103,09H
	.word	04741H,159,203,09H
	.word	04840H,174,257,04H
	.word	04840H,174,43,05H
	.word	03B40H,188,150,00H
	.word	03B40H,188,100,00H
	.word	03B40H,188,50,00H
	.word	04040H,200,0,00H
	.word	04040H,200,250,00H
	.word	04840H,207,178,0DH
	.word	04640H,207,49,0CH
	.word	04840H,207,250,0FH
	.word	04840H,207,104,0DH
	.word	04B40H,207,107,0CH
	.word	04040H,211,200,00H
	.word	04640H,214,46,02H
	.word	04640H,214,92,02H
	.word	04640H,214,138,02H
	.word	04640H,214,184,02H
	.word	04640H,214,213,02H
	.word	04840H,214,257,010H
	.word	04840H,214,43,011H
	.word	04840H,227,43,03H
	.word	04640H,227,45,02H
	.word	04640H,227,54,02H
	.word	04640H,227,146,02H
	.word	04640H,227,100,02H
	.word	04640H,227,238,012H
	.word	04640H,227,192,02H
	.word	04840H,230,43,05H
	.word	04640H,230,238,05H
	.word	04040H,234,0,00H
	.word	04040H,234,204,00H
	.word	04640H,234,200,08H
	.word	04240H,234,126,07H
	.word	04240H,234,54,07H
	.word	04640H,234,50,06H
	.word	04840H,238,43,05H
	.word	04640H,238,238,05H
	.word	04240H,238,50,0BH
	.word	04240H,238,200,0AH
	.word	04040H,250,250,00H
	.word	04240H,275,200,0AH
	.word	04840H,278,43,05H
	.word	04640H,278,238,05H
	.word	04040H,284,0,00H
	.word	03B40H,284,200,07H
	.word	04640H,284,204,06H
	.word	04640H,285,234,08H
	.word	04040H,285,241,00H
	.word	04240H,288,204,0BH
	.word	04240H,289,234,0AH
	.word	04240H,297,50,0BH
	.word	04240H,317,234,0AH
	.word	04240H,317,204,0BH
	.word	04840H,318,43,05H
	.word	04640H,318,238,05H
	.word	04040H,334,0,00H
	.word	04240H,334,50,0BH
	.word	04240H,334,200,0AH
	.word	04040H,335,241,00H
	.word	04840H,358,43,05H
	.word	04640H,358,238,05H
	.word	04640H,376,234,0FH
	.word	03B40H,376,200,0DH
	.word	04640H,376,204,0CH
	.word	04040H,380,200,00H
	.word	04040H,384,0,00H
	.word	04040H,385,250,00H
	.word	04640H,393,200,0FH
	.word	04040H,393,50,00H
	.word	04040H,393,100,00H
	.word	04640H,393,50,0CH
	.word	04240H,393,52,0DH
	.word	04240H,393,126,0DH
	.word	04040H,393,150,00H
	.word	04840H,398,43,011H
	.word	04640H,398,46,02H
	.word	04640H,398,146,02H
	.word	04640H,398,238,013H
	.word	04640H,398,192,02H
	.word	04640H,398,100,02H
	.word	04640H,398,55,02H
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
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04040H,0,126,01H
	.word	04B43H,46,38,02H
	.word	04B43H,186,17,03H
	.word	04040H,187,0,04H
	.word	04040H,188,126,05H
	.word	04E44H,286,201,06H
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
	.word	0,26 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	03241H,0,76,00H
	.word	03241H,0,126,00H
	.word	03241H,0,176,00H
	.word	03241H,0,226,00H
	.word	03241H,0,276,00H
	.word	04042H,25,180,01H
	.word	04052H,36,39,02H
	.word	04041H,46,249,00H
	.word	03C41H,50,53,03H
	.word	04041H,50,50,04H
	.word	03241H,50,0,00H
	.word	03C41H,50,127,03H
	.word	04041H,50,212,05H
	.word	04041H,50,216,04H
	.word	04041H,50,245,05H
	.word	03C41H,50,171,03H
	.word	04041H,53,50,06H
	.word	03B40H,53,219,07H
	.word	04041H,54,212,08H
	.word	04041H,54,216,06H
	.word	04041H,54,245,08H
	.word	04041H,96,249,00H
	.word	03241H,100,0,00H
	.word	03B40H,100,219,07H
	.word	04041H,112,50,06H
	.word	04041H,113,212,08H
	.word	04041H,113,216,06H
	.word	04041H,113,245,08H
	.word	04041H,133,212,08H
	.word	04041H,133,216,06H
	.word	03C41H,133,245,08H
	.word	04041H,146,249,00H
	.word	03B40H,147,219,07H
	.word	03241H,150,0,00H
	.word	04252H,157,248,01H
	.word	03C41H,171,50,06H
	.word	04041H,192,212,09H
	.word	04041H,192,54,0AH
	.word	04041H,192,50,0BH
	.word	04041H,192,216,0BH
	.word	04041H,192,128,0AH
	.word	04041H,192,171,0AH
	.word	04041H,192,245,09H
	.word	04041H,196,50,04H
	.word	03C41H,196,54,03H
	.word	03C41H,196,128,03H
	.word	03C41H,196,202,03H
	.word	04041H,196,276,05H
	.word	04041H,196,280,00H
	.word	03B40H,199,53,07H
	.word	03B40H,199,219,07H
	.word	03B40H,199,163,07H
	.word	03B40H,199,107,07H
	.word	03241H,200,0,00H
	.word	04041H,200,276,08H
	.word	04041H,230,50,06H
	.word	03B40H,246,53,07H
	.word	03B40H,246,219,07H
	.word	03B40H,246,163,07H
	.word	03B40H,246,107,07H
	.word	03241H,246,280,00H
	.word	03241H,250,0,00H
	.word	04041H,259,276,08H
	.word	04041H,289,50,06H
	.word	03B40H,293,53,07H
	.word	03B40H,293,219,07H
	.word	03B40H,293,163,07H
	.word	03B40H,293,107,07H
	.word	03241H,296,280,00H
	.word	03241H,300,0,00H
	.word	04041H,318,276,08H
	.word	04041H,328,50,06H
	.word	03C41H,328,276,08H
	.word	03B40H,340,53,07H
	.word	03B40H,340,219,07H
	.word	03B40H,340,163,07H
	.word	03B40H,340,107,07H
	.word	03241H,346,280,00H
	.word	03241H,350,0,00H
	.word	04042H,354,23,02H
	.word	04041H,387,50,0BH
	.word	04041H,387,54,0AH
	.word	04041H,387,128,0AH
	.word	04041H,387,202,0AH
	.word	04041H,387,276,09H
	.word	04042H,390,247,01H
	.word	03241H,391,50,00H
	.word	03241H,391,100,00H
	.word	03241H,391,150,00H
	.word	03241H,391,200,00H
	.word	03241H,391,250,00H
	.word	03241H,400,0,00H
	.word	0FFFFH	;End Marker
STORYMODBMOD:
	.word	452,330,93	;x size, y size, #blocks
	.long	STORYMODBLKS, Y1HDRS, Y1PALS
