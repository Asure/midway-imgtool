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

fu7HDRS:
	.word	52,10	;x size, y size
	.long	030FE05EH	;address
	.word	06000H	;dma ctrl
	.word	144,11
	.long	030FEC8EH
	.word	06000H
	.word	40,49
	.long	031011AEH
	.word	06000H
	.word	144,5
	.long	03103F9EH
	.word	06000H
	.word	60,50
	.long	0310507EH
	.word	06580H
	.word	36,50
	.long	0310857AH
	.word	06080H
	.word	144,14
	.long	0310AD9EH
	.word	06000H
	.word	144,16
	.long	0310DCDEH
	.word	06000H
	.word	144,11
	.long	031112DEH
	.word	06000H
	.word	144,19
	.long	031137FEH
	.word	06000H
	.word	144,18
	.long	0311781EH
	.word	06000H
	.word	84,17
	.long	0311B4DEH
	.word	06080H
	.word	60,21
	.long	0311D5ACH
	.word	06580H
	.word	12,100
	.long	0311E9D4H
	.word	06000H
	.word	84,100
	.long	031205F4H
	.word	07080H
	.word	84,100
	.long	0312E690H
	.word	06080H
	.word	84,100
	.long	0313A788H
	.word	07080H
	.word	56,23
	.long	03148824H
	.word	06A80H
	.word	36,53
	.long	03149584H
	.word	06080H
	.word	32,44
	.long	0314BA4EH
	.word	06080H
	.word	48,33
	.long	0314DA0EH
	.word	06280H
	.word	76,28
	.long	0314FB26H
	.word	06000H
	.word	36,42
	.long	03152D06H
	.word	06080H
	.word	48,21
	.long	03154E06H
	.word	06180H
	.word	64,11
	.long	03155EF8H
	.word	06080H
	.word	4,17
	.long	03156F4CH
	.word	06000H
	.word	168,25
	.long	031570E4H
	.word	06000H
	.word	36,14
	.long	0315D354H
	.word	06580H
	.word	40,13
	.long	0315D88CH
	.word	06280H
	.word	36,22
	.long	0315E116H
	.word	06080H
	.word	92,17
	.long	0315EF5EH
	.word	06000H
	.word	52,9
	.long	03161406H
	.word	06680H
	.word	24,60
	.long	03161D42H
	.word	06080H
	.word	20,17
	.long	03163BDEH
	.word	06080H
	.word	16,12
	.long	031643C2H
	.word	06080H
	.word	32,14
	.long	031646F2H
	.word	06580H
	.word	16,21
	.long	03164B6AH
	.word	06080H
	.word	8,12
	.long	031650FEH
	.word	06000H
	.word	16,15
	.long	0316533EH
	.word	06080H
	.word	32,27
	.long	0316573AH
	.word	06080H
	.word	32,23
	.long	031668A4H
	.word	06080H
	.word	16,21
	.long	031674CCH
	.word	06080H
	.word	28,68
	.long	03167B9EH
	.word	06480H
	.word	24,22
	.long	03169C96H
	.word	06580H
	.word	8,7
	.long	0316A26EH
	.word	06000H
	.word	20,20
	.long	0316A3BEH
	.word	06080H
	.word	16,15
	.long	0316A932H
	.word	06080H
	.word	20,100
	.long	0316AD2EH
	.word	06080H
	.word	16,100
	.long	0316D826H
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

;file kungfu7 blocks not in any module
;	.word	04041H	;flags
;	.word	4,294 ;x,y
;	.word	00H	;pal5,pal4,hdr13-0
;	.word	0FFFFH	;End Marker
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
	.word	52,50	;x size, y size
	.long	0316FDA6H	;address
	.word	06080H	;dma ctrl
	.word	28,25
	.long	031739CEH
	.word	06580H
	.word	16,28
	.long	03174102H
	.word	06080H
	.word	4,4
	.long	031748EAH
	.word	06000H
	.word	4,74
	.long	0317494AH
	.word	06000H
	.word	4,4
	.long	0317503AH
	.word	06000H
	.word	60,4
	.long	0317509AH
	.word	06000H
	.word	88,116
	.long	0317563AH
	.word	080H
	.word	60,4
	.long	0318953AH
	.word	06000H
	.word	88,116
	.long	03189ADAH
	.word	080H
	.word	4,4
	.long	0319D9DAH
	.word	06000H
	.word	4,74
	.long	0319DA3AH
	.word	06000H
	.word	4,4
	.long	0319E12AH
	.word	06000H
	.word	88,116
	.long	0319E18AH
	.word	080H
	.word	88,116
	.long	031B208AH
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
