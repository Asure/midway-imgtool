	.OPTION	B,D,L,T
	.include	"BGNDTBL.GLO"
	.DATA

timeHDRS:
	.word	76,123	;x size, y size
	.long	03C98BF6H	;address
	.word	00H	;dma ctrl
	.word	76,133
	.long	03CAB016H
	.word	00H
	.word	76,133
	.long	03CBEBF6H
	.word	00H
	.word	76,123
	.long	03CD27D6H
	.word	00H
	.word	76,133
	.long	03CE4BF6H
	.word	00H
	.word	76,123
	.long	03CF87D6H
	.word	00H
	.word	80,133
	.long	03D0ABF6H
	.word	00H
	.word	76,123
	.long	03D1F876H
	.word	00H
	.word	100,133
	.long	03D31C96H
	.word	00H
	.word	100,123
	.long	03D4BC36H
	.word	00H
	.word	68,58
	.long	03D63C96H
	.word	06000H
	.word	72,58
	.long	03D69906H
	.word	06000H
	.word	88,58
	.long	03D6FAE6H
	.word	06000H
	.word	84,58
	.long	03D77286H
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
	.word	204,23
	.long	03D7E4B6H
	.word	00H
	.word	200,21
	.long	03D87756H
	.word	07000H
	.word	44,54
	.long	03D8EA2EH
	.word	05000H
	.word	44,54
	.long	03D91896H
	.word	05000H
	.word	200,21
	.long	03D946FEH
	.word	07000H
	.word	196,23
	.long	03D9B9D6H
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
	.word	204,23
	.long	03D7E4B6H
	.word	00H
	.word	200,70
	.long	03DA46B6H
	.word	05000H
	.word	200,71
	.long	03DB5826H
	.word	06000H
	.word	200,68
	.long	03DCA4F6H
	.word	05000H
	.word	200,51
	.long	03DDAE96H
	.word	06000H
	.word	192,86
	.long	03DE9DA6H
	.word	06000H
	.word	96,46
	.long	03E020A6H
	.word	06000H
	.word	84,12
	.long	03E08826H
	.word	07000H
	.word	88,64
	.long	03E0A3B6H
	.word	00H
	.word	36,46
	.long	03E153B6H
	.word	06000H
	.word	212,9
	.long	03E17A86H
	.word	03000H
	.word	200,65
	.long	03E190E2H
	.word	05000H
	.word	200,72
	.long	03E28ECAH
	.word	05000H
	.word	200,68
	.long	03E3A80AH
	.word	06000H
	.word	200,54
	.long	03E4E6CAH
	.word	06000H
	.word	196,23
	.long	03D9B9D6H
	.word	00H
	.word	64,9
	.long	03E5E3EAH
	.word	03000H
	.word	56,46
	.long	03E5EAAAH
	.word	06000H
	.word	92,138
	.long	03E6270AH
	.word	06000H
	.word	176,24
	.long	03E7509AH
	.word	00H
	.word	148,11
	.long	03E7D49AH
	.word	00H
	.word	84,9
	.long	03E8077AH
	.word	03000H
	.word	92,138
	.long	03E81056H
	.word	06000H
	.word	100,110
	.long	03E939E6H
	.word	00H
	.word	64,8
	.long	03EA91A6H
	.word	02000H
	.word	56,8
	.long	03EA95A6H
	.word	02000H
	.word	40,9
	.long	03EA9926H
	.word	03000H
	.word	40,107
	.long	03EA9D5EH
	.word	04000H
	.word	168,24
	.long	03EAE03EH
	.word	00H
	.word	148,11
	.long	03EB5E3EH
	.word	00H
	.word	92,138
	.long	03EB911EH
	.word	07000H
	.word	92,138
	.long	03ECEC46H
	.word	07000H
teamstatBLKS:
	.word	054CH	;flags
	.word	0,0 ;x,y
	.word	01H	;pal5,pal4,hdr13-0
	.word	04045H,0,10,00H
	.word	054DH,1,69,03H
	.word	0540H,1,137,02H
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
	.word	0540H,1,137,02H
	.word	054DH,1,69,03H
	.word	054BH,2,206,04H
	.word	04044H,7,99,05H
	.word	04042H,7,198,06H
	.word	04043H,12,168,07H
	.word	04041H,12,104,08H
	.word	04043H,18,168,07H
	.word	04042H,100,198,09H
	.word	04043H,104,168,07H
	.word	04041H,104,104,08H
	.word	04043H,110,168,07H
	.word	04046H,110,187,0AH
	.word	04042H,134,198,09H
	.word	04042H,168,198,09H
	.word	054FH,200,70,0BH
	.word	054EH,200,0,0CH
	.word	054AH,201,135,0DH
	.word	0549H,202,203,0EH
	.word	04042H,202,198,09H
	.word	04044H,203,99,05H
	.word	04045H,204,10,0FH
	.word	04045H,208,168,07H
	.word	04041H,208,104,08H
	.word	04045H,214,168,07H
	.word	04042H,236,198,09H
	.word	04042H,270,198,09H
	.word	04045H,300,168,07H
	.word	04041H,300,104,08H
	.word	04042H,304,198,09H
	.word	04045H,307,168,07H
	.word	04046H,322,187,010H
	.word	04042H,338,198,011H
	.word	0FFFFH	;End Marker
teamstatBMOD:
	.word	402,257,25	;x size, y size, #blocks
	.long	teamstatBLKS, statHDRS, statPALS
finalresBMOD:
	.word	402,257,35	;x size, y size, #blocks
	.long	finalresBLKS, statHDRS, statPALS
