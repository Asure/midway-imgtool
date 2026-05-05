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
