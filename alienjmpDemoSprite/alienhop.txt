10 rem f - animation frame count variable
15 rem s - sprite number
18 rem n - number count
19 rem dt - data read
20 rem x,y - cordinates horisontal,vertical
21 rem d - animation frame jump (right or left direction)
22 rem keyb$ - (ke$)string variable to collect keyboard input
23 rem  mv - extra move
100 rem 
110 data 0,0,0,0,0,0,0,0
120 data 0,0,0,0,0,0,0,0
130 data 0,0,0,0,0,7,255,192
140 data 7,255,224,7,254,32,7,255
150 data 0,4,63,224,5,255,192,11
160 data 255,240,4,255,240,14,231,240
170 data 4,115,240,0,176,192,0,48
180 data 96,0,29,184,0,31,152
190 rem 
200 data 0,0,0,0,0,0,0,0
210 data 0,0,0,0,0,0,0,0
220 data 0,0,7,255,192,7,255,224
230 data 7,254,32,7,255,0,4,63
240 data 224,5,255,192,11,255,240,4
250 data 255,240,14,231,240,4,115,240
260 data 0,176,192,0,48,192,0,48
270 data 192,0,48,192,0,48,192
280 rem 
290 data 0,0,0,0,0,0,0,0
300 data 0,0,0,0,0,0,0,0
310 data 0,0,0,0,0,7,255,192
320 data 7,255,224,7,254,32,7,255
330 data 0,4,63,224,5,255,192,11
340 data 255,240,4,255,240,14,231,240
350 data 4,115,240,0,176,192,0,48
360 data 192,0,96,128,0,227,128
370 rem 
380 data 0,0,0,0,0,0,0,0
390 data 0,0,0,0,0,0,0,0
400 data 0,0,0,0,0,7,255,192
410 data 7,255,224,7,254,32,7,255
420 data 0,4,63,224,5,255,192,23
430 data 255,240,8,255,240,20,231,240
440 data 0,115,240,0,176,192,0,32
450 data 192,0,195,128,0,0,0
460 rem 
470 data 0,0,0,0,0,0,0,0
480 data 0,0,0,0,0,0,0,0
490 data 0,0,0,0,0,3,255,224
500 data 7,255,224,4,127,224,0,255
510 data 224,7,252,32,3,255,160,15
520 data 255,208,15,255,32,15,231,112
530 data 15,206,32,3,13,0,6,12
540 data 0,29,184,0,25,248,0
550 rem 
560 data 0,0,0,0,0,0,0,0
570 data 0,0,0,0,0,0,0,0
580 data 0,0,3,255,224,7,255,224
590 data 4,127,224,0,255,224,7,252
600 data 32,3,255,160,15,255,208,15
610 data 255,32,15,231,112,15,206,32
620 data 3,13,0,3,12,0,3,12
630 data 0,3,12,0,3,12,0
640 rem 
650 data 0,0,0,0,0,0,0,0
660 data 0,0,0,0,0,0,0,0
670 data 0,0,0,0,0,3,255,224
680 data 7,255,224,4,127,224,0,255
690 data 224,7,252,32,3,255,160,15
700 data 255,208,15,255,32,15,231,112
710 data 15,206,32,3,13,0,3,12
720 data 0,1,6,0,1,199,0
730 rem 
740 data 0,0,0,0,0,0,0,0
750 data 0,0,0,0,0,0,0,0
760 data 0,0,0,0,0,3,255,224
770 data 7,255,224,4,127,224,0,255
780 data 224,7,252,32,3,255,160,15
790 data 255,232,15,255,16,15,231,40
800 data 15,206,0,3,13,0,3,4
810 data 0,1,195,0,0,0,0
1000 rem store data
1010 for s=0 to 7
1020 for n=0 to 62:rem 63 bytes in a sprite. c64 can only jmp 64 step.
1030 read dt
1040 poke 8192+n+64*s,dt:next n:next s
1050 poke 2040,128
1070 rem v = 53248, start of display chip
1080 poke 53248+21,peek(53248 + 21) or (2^0)
1090 poke 53248+0,100:poke 53248+1,100
1095 x=peek(53248+0):y=peek(53248+1):d=0
1100 rem loop
1110 get keyb$:if keyb$="" then goto 1100:rem get kb input
1115 poke 2040,128+f+4*d
1118 f=f+1:if f=4 then f=0
1120 if keyb$<>"{right}" then goto 1170:rem cursor right
1125 d=0
1155 x=x+4
1156 if x<256 then mv=0
1157 if x>255 then mv=1
1158 poke 53248+16,mv
1160 poke 53248+0,x-(mv*256)
1161 if x>322 then x=322
1162 goto 1100
1170 if keyb$<>"{left}" then 1215:rem cursor left
1175 d=1
1178 x=x-4:
1179 if x<256 then mv=0
1184 if x>255 then mv=1
1186 poke 53248+16,mv
1189 poke 53248+0,x-(mv*256)
1210 if x<24 then x=24
1215 if keyb$<>"{down}" then 1265:rem cursor down
1225 poke 53248+1,y
1255 y=y+4:if y>226 then y=226
1265 if keyb$<>"{up}" then 1315
1275 poke 53248+1,y
1305 y=y-4:if y<44 then y=44
1315 goto 1100