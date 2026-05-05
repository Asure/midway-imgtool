	.OPTION	B,D,L,T
	.include	"BGNDTBL.GLO"
	.DATA

OLHDRS:
	.word	92,56	;x size, y size
	.long	03000000H	;address
	.word	06A80H	;dma ctrl
	.word	28,186
	.long	03002AD0H
	.word	06080H
	.word	28,169
	.long	03009D9CH
	.word	06080H
	.word	36,32
	.long	0300FDCEH
	.word	06580H
	.word	120,81
	.long	030109AEH
	.word	06180H
	.word	40,209
	.long	0301E47EH
	.word	06480H
	.word	80,58
	.long	030296A2H
	.word	06D80H
	.word	52,78
	.long	0302EA56H
	.word	06580H
	.word	56,13
	.long	03030E6EH
	.word	06000H
	.word	80,173
	.long	03031F7EH
	.word	06480H
	.word	96,43
	.long	030463BEH
	.word	06080H
	.word	96,13
	.long	0304C3D2H
	.word	06080H
	.word	32,50
	.long	0304E0DEH
	.word	06580H
	.word	244,33
	.long	0304EE26H
	.word	06080H
	.word	52,232
	.long	0305AA5AH
	.word	06000H
	.word	24,57
	.long	0306C51AH
	.word	06180H
	.word	140,47
	.long	0306D714H
	.word	06080H
	.word	140,44
	.long	03077090H
	.word	06480H
	.word	12,81
	.long	0307FE9CH
	.word	06080H
	.word	36,30
	.long	03081420H
	.word	06580H
	.word	4,13
	.long	03081C18H
	.word	06000H
	.word	48,100
	.long	03081D50H
	.word	06A80H
	.word	48,104
	.long	03087308H
	.word	06880H
	.word	48,103
	.long	0308CD60H
	.word	06180H
	.word	48,103
	.long	03092BEEH
	.word	06280H
	.word	48,100
	.long	030985F6H
	.word	06280H
	.word	16,36
	.long	0309D95CH
	.word	06080H
	.word	8,78
	.long	0309E304H
	.word	06000H
	.word	56,223
	.long	0309F1A4H
	.word	06080H
	.word	16,30
	.long	030B12D8H
	.word	06080H
	.word	8,21
	.long	030B1AD0H
	.word	06000H
	.word	4,70
	.long	030B1EC0H
	.word	06000H
	.word	56,232
	.long	030B2550H
	.word	06A80H
	.word	144,47
	.long	030C53F8H
	.word	06000H
	.word	144,46
	.long	030CF298H
	.word	06280H
	.word	8,30
	.long	030D8BACH
	.word	06000H
	.word	100,34
	.long	030D914CH
	.word	06180H
	.word	68,168
	.long	030DDE40H
	.word	06000H
	.word	68,65
	.long	030EEA00H
	.word	06080H
	.word	56,30
	.long	030F5088H
	.word	06680H
	.word	96,33
	.long	030F5F4CH
	.word	06000H
	.word	36,43
	.long	030FA98CH
	.word	06580H
	.word	24,92
	.long	030FB6D8H
	.word	06080H
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
	.word	56,32	;x size, y size
	.long	030FE05EH	;address
	.word	06580H	;dma ctrl
	.word	116,58
	.long	030FF682H
	.word	06000H
	.word	140,44
	.long	03077090H
	.word	06480H
	.word	140,47
	.long	0306D714H
	.word	06080H
	.word	32,21
	.long	03109432H
	.word	06000H
	.word	72,26
	.long	0310A3F2H
	.word	06080H
	.word	48,32
	.long	0310CC52H
	.word	06180H
	.word	48,54
	.long	0310E6F0H
	.word	06580H
	.word	60,32
	.long	0310FDA0H
	.word	06080H
	.word	24,45
	.long	03112426H
	.word	06180H
	.word	40,58
	.long	031134D0H
	.word	06880H
	.word	44,78
	.long	031167C0H
	.word	06080H
	.word	40,55
	.long	031198F8H
	.word	06080H
	.word	144,46
	.long	030CF298H
	.word	06280H
	.word	144,47
	.long	030C53F8H
	.word	06000H
	.word	44,50
	.long	0311CB94H
	.word	06080H
	.word	36,58
	.long	0311FD30H
	.word	06180H
	.word	56,73
	.long	031228B8H
	.word	06480H
	.word	28,4
	.long	03127D08H
	.word	06080H
	.word	20,65
	.long	03127F56H
	.word	06480H
	.word	36,34
	.long	0312969AH
	.word	06080H
	.word	20,65
	.long	0312AD9AH
	.word	06180H
	.word	12,7
	.long	0312C664H
	.word	06080H
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

;file TOMB blocks not in any module
;	.word	04142H	;flags
;	.word	322,605 ;x,y
;	.word	01H	;pal5,pal4,hdr13-0
;	.word	0FFFFH	;End Marker
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
	.word	64,48	;x size, y size
	.long	0312C840H	;address
	.word	06080H	;dma ctrl
	.word	104,7
	.long	03130AA6H
	.word	06080H
	.word	72,46
	.long	03131B70H
	.word	06280H
	.word	72,99
	.long	03134A64H
	.word	06280H
	.word	92,28
	.long	0313D0B6H
	.word	06080H
	.word	92,28
	.long	03140CA6H
	.word	06080H
	.word	48,103
	.long	03144896H
	.word	06080H
	.word	48,69
	.long	0314A7A8H
	.word	06080H
	.word	80,76
	.long	0314F098H
	.word	06180H
	.word	32,48
	.long	03156FB4H
	.word	06480H
	.word	88,69
	.long	03158D48H
	.word	06280H
	.word	88,48
	.long	0315E154H
	.word	06280H
	.word	56,42
	.long	03163434H
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
