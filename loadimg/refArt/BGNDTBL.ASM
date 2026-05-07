	.OPTION	B,D,L,T
	.include	"BGNDTBL.GLO"
	.DATA

timeHDRS:
	.word	76,123	;x size, y size
	.long	03CBC782H	;address
	.word	00H	;dma ctrl
	.word	76,133
	.long	03CCEBA2H
	.word	00H
	.word	76,133
	.long	03CE2782H
	.word	00H
	.word	76,123
	.long	03CF6362H
	.word	00H
	.word	76,133
	.long	03D08782H
	.word	00H
	.word	76,123
	.long	03D1C362H
	.word	00H
	.word	80,133
	.long	03D2E782H
	.word	00H
	.word	76,123
	.long	03D43402H
	.word	00H
	.word	100,133
	.long	03D55822H
	.word	00H
	.word	100,123
	.long	03D6F7C2H
	.word	00H
	.word	68,58
	.long	03D87822H
	.word	06000H
	.word	72,58
	.long	03D8D492H
	.word	06000H
	.word	88,58
	.long	03D93672H
	.word	06000H
	.word	84,58
	.long	03D9AE12H
	.word	06000H
maximBLKS:
	.word	0A45H	;flags
	.word	0,123 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	0A40H,0,0,00H
	.word	0404AH,27,41,0AH
	.word	0A41H,75,0,03H
	.word	0A47H,75,123,02H
	.word	0404BH,95,41,0BH
	.word	0A46H,145,123,04H
	.word	0A42H,150,0,05H
	.word	0404CH,164,42,0CH
	.word	0A48H,220,123,06H
	.word	0A43H,225,0,07H
	.word	0404DH,250,42,0DH
	.word	0A44H,300,0,09H
	.word	0A49H,300,123,08H
	.word	0FFFFH	;End Marker
hangtimeBLKS:
	.word	0A40H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	0A45H,0,123,01H
	.word	0A47H,75,123,02H
	.word	0A41H,75,0,03H
	.word	0A46H,145,123,04H
	.word	0A42H,150,0,05H
	.word	0A48H,220,123,06H
	.word	0A43H,225,0,07H
	.word	0A49H,300,123,08H
	.word	0A44H,300,0,09H
	.word	0FFFFH	;End Marker
maximBMOD:
	.word	400,256,14	;x size, y size, #blocks
	.long	maximBLKS, timeHDRS, timePALS
hangtimeBMOD:
	.word	400,256,10	;x size, y size, #blocks
	.long	hangtimeBLKS, timeHDRS, timePALS

RHDRS:
	.word	204,23	;x size, y size
	.long	03DA2042H	;address
	.word	00H	;dma ctrl
	.word	200,21
	.long	03DAB2E2H
	.word	07000H
	.word	44,54
	.long	03DB25BAH
	.word	05000H
	.word	44,54
	.long	03DB5422H
	.word	05000H
	.word	200,21
	.long	03DB828AH
	.word	07000H
	.word	196,23
	.long	03DBF562H
	.word	00H
VSSCRBLKS:
	.word	04142H	;flags
	.word	0,0 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	04141H,0,54,01H
	.word	04243H,175,82,02H
	.word	04243H,193,118,03H
	.word	04140H,200,54,04H
	.word	04142H,204,0,05H
	.word	0FFFFH	;End Marker
VSSCRBMOD:
	.word	400,172,6	;x size, y size, #blocks
	.long	VSSCRBLKS, RHDRS, RPALS

statHDRS:
	.word	204,23	;x size, y size
	.long	03DA2042H	;address
	.word	00H	;dma ctrl
	.word	200,70
	.long	03DC8242H
	.word	05000H
	.word	200,71
	.long	03DD93B2H
	.word	06000H
	.word	200,68
	.long	03DEE082H
	.word	05000H
	.word	200,51
	.long	03DFEA22H
	.word	06000H
	.word	192,86
	.long	03E0D932H
	.word	06000H
	.word	96,46
	.long	03E25C32H
	.word	06000H
	.word	84,12
	.long	03E2C3B2H
	.word	07000H
	.word	88,64
	.long	03E2DF42H
	.word	00H
	.word	36,46
	.long	03E38F42H
	.word	06000H
	.word	212,9
	.long	03E3B612H
	.word	03000H
	.word	200,65
	.long	03E3CC6EH
	.word	05000H
	.word	200,72
	.long	03E4CA56H
	.word	05000H
	.word	200,68
	.long	03E5E396H
	.word	06000H
	.word	200,54
	.long	03E72256H
	.word	06000H
	.word	196,23
	.long	03DBF562H
	.word	00H
	.word	64,9
	.long	03E81F76H
	.word	03000H
	.word	56,46
	.long	03E82636H
	.word	06000H
	.word	92,138
	.long	03E86296H
	.word	06000H
	.word	176,24
	.long	03E98C26H
	.word	00H
	.word	148,11
	.long	03EA1026H
	.word	00H
	.word	84,9
	.long	03EA4306H
	.word	03000H
	.word	92,138
	.long	03EA4BE2H
	.word	06000H
	.word	100,110
	.long	03EB7572H
	.word	00H
	.word	64,8
	.long	03ECCD32H
	.word	02000H
	.word	56,8
	.long	03ECD132H
	.word	02000H
	.word	40,9
	.long	03ECD4B2H
	.word	03000H
	.word	40,107
	.long	03ECD8EAH
	.word	04000H
	.word	168,24
	.long	03ED1BCAH
	.word	00H
	.word	148,11
	.long	03ED99CAH
	.word	00H
	.word	92,138
	.long	03EDCCAAH
	.word	07000H
	.word	92,138
	.long	03EF27D2H
	.word	07000H
teamstatBLKS:
	.word	054CH	;flags
	.word	0,0 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	04045H,0,10,00H
	.word	054DH,1,69,03H
	.word	0540H,1,137,01002H
	.word	054BH,2,206,04H
	.word	0A46H,14,107,012H
	.word	0C42H,33,98,013H
	.word	0C40H,59,232,014H
	.word	02847H,65,99,015H
	.word	0A46H,104,107,016H
	.word	0C41H,155,122,017H
	.word	02848H,176,233,018H
	.word	02848H,179,222,019H
	.word	02847H,183,99,01AH
	.word	02844H,184,112,01BH
	.word	054FH,200,72,0BH
	.word	054EH,200,0,0CH
	.word	054AH,201,135,0DH
	.word	0549H,202,203,0EH
	.word	04045H,204,10,0FH
	.word	0C42H,205,98,01CH
	.word	0C40H,206,232,01DH
	.word	0A43H,208,107,01EH
	.word	02847H,257,99,015H
	.word	0A43H,298,107,01FH
	.word	0FFFFH	;End Marker
finalresBLKS:
	.word	04045H	;flags
	.word	0,10 ;x,y
	.word	00H	;pal5,pal4,hdr13-0
	.word	054CH,0,0,01H
	.word	0540H,1,137,01002H
	.word	054DH,1,69,03H
	.word	054BH,2,206,04H
	.word	04044H,7,99,01005H
	.word	04042H,7,198,01006H
	.word	04043H,12,168,01007H
	.word	04041H,12,104,01008H
	.word	04043H,18,168,01007H
	.word	04042H,100,198,01009H
	.word	04043H,104,168,01007H
	.word	04041H,104,104,01008H
	.word	04043H,110,168,01007H
	.word	04046H,110,187,0100AH
	.word	04042H,134,198,01009H
	.word	04042H,168,198,01009H
	.word	054FH,200,70,0BH
	.word	054EH,200,0,0CH
	.word	054AH,201,135,0DH
	.word	0549H,202,203,0EH
	.word	04042H,202,198,01009H
	.word	04044H,203,99,01005H
	.word	04045H,204,10,0FH
	.word	04045H,208,168,01007H
	.word	04041H,208,104,01008H
	.word	04045H,214,168,01007H
	.word	04042H,236,198,01009H
	.word	04042H,270,198,01009H
	.word	04045H,300,168,01007H
	.word	04041H,300,104,01008H
	.word	04042H,304,198,01009H
	.word	04045H,307,168,01007H
	.word	04046H,322,187,01010H
	.word	04042H,338,198,01011H
	.word	0FFFFH	;End Marker
teamstatBMOD:
	.word	402,257,25	;x size, y size, #blocks
	.long	teamstatBLKS, statHDRS, statPALS
finalresBMOD:
	.word	402,257,35	;x size, y size, #blocks
	.long	finalresBLKS, statHDRS, statPALS
