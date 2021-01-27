1 rem mirror horror - joystick version
4 rem dsiclaimer - dont remove border, or will game crash progam
10 rem "mirror horror - joystick"
20 poke 53281,0:poke 53280,0:gosub 3100
30 poke 646,5:print chr$(147):gosub 200
40 poke 646,1
100 poke 214,1:print:poke 211,3
105 print "(joystick in port 2)"
108 poke 214,3:print:poke 211,3
110 print "use mirror to kill monsters!"
111 poke 214,5:print:poke 211,3
115 print "use stick to move over mirrorrs"
121 poke 214,7:print:poke 211,3
125 print "fire + left to tilt mirrors"
131 poke 214,9:print:poke 211,3
135 print "dont let monsters touch you"
136 poke 214,11:print:poke 211,3
138 print "fire + righ to shoot cannon""
139 poke 214,12:print:poke 211,3
140 print "fire + backward to pickup window"
141 poke 214,13:print:poke 211,3
142 print "fire + forward to place window"
143 poke 214,15:print
144 print spc(2)"tip to move around:""
145 print spc(2)"remove your fire finger from button"
146 j = peek(56320) and 31:rem l146
149 if keyb$="" and j<>15 then goto 146
154 keyb$="":
197 for cnt=1 to 100:print:next
198 poke 646,1:print chr$(147):gosub 200:goto 300
199 :rem
200 for cnt=0 to 19:rem "game frame":rem l200
201 poke 1024+19-cnt+40*19,160
202 poke 1024+19-cnt+40*0,160
203 poke 1024+20+cnt+40*19,160
204 poke 1024+20+cnt+40*0,160
206 poke 1024+00+40*(10+int(10/19*cnt)),160
207 poke 1024+00+40*(10-int(10/19*cnt)),160
208 poke 1024+39+40*(10+int(10/19*cnt)),160
209 poke 1024+39+40*(10-int(10/19*cnt)),160
210 next:return
300 :rem l300
301 dim m(4),g(4)
302 m(1)=78:m(2)=67:m(3)=77:m(4)=66:rem mirror directions
303 g(1)=107:g(2)=113:g(3)=115:g(4)=114:rem gun directrion
400 :rem
401 for cnt=1 to 10:rem "set mirrors"
402 mx=int(rnd(1)*37)+1
403 my=int(rnd(1)*17)+1
404 m=int(rnd(1)*4)+1
405 pk=peek(1024+mx+40*my)
406 if pk<> 32 then 402
407 poke 1024+mx+40*my,m(m):next
410 :rem
411 for cnt=1 to 10:rem "set enemy"
412 ex=int(rnd(1)*37)+1
413 ey=int(rnd(1)*17)+1
414 pk=peek(1024+ex+40*ey)
415 if pk<>32 then 412
416 poke 1024+ex+40*ey,88
417 poke55296+ex+40*ey,2:next
420 :rem
421 rem "set gun"
422 gx=int(rnd(1)*37)+1
423 gy=int(rnd(1)*17)+1
424 g=int(rnd(1)*4)+1
425 pk=peek(1024+gx+40*gy)
426 if pk<>32 then 422
427 poke 1024+gx+40*gy,g(g)
428 poke55296+gx+40*gy,6
500 :rem
501 rem "set player"
502 px=int(rnd(1)*38)+1
503 py=int(rnd(1)*17)+1
504 pk=peek(1024+px+40*py)
505 if pk<>32 then 502
600 :rem player movements
601 pk=peek(1024+px+40*py)
602 poke1024+px+40*py,81:rem rst stp
603 poke1024+px+40*py,pk:dx=0:dy=0
604 j=peek(56320) and 31:if j=31 then 602
605 if j=11 then gosub 700
606 if j=23 then dx=+1
607 if j=27 then dx=-1
608 if j=29 then  dy=+1
609 if j=30 then dy=-1
610 if j=14 or j=13 then gosub800
611 if j=7 then goto 900
617 s=peek(1024+px+dx+40*(py+dy))
618 if s=160 then 602
619 if s=88 then goto 2000
620 px=px+dx:py=py+dy:goto 600
699 :end
700 :rem l700
702 rem "adjust mirrors and gun"
704 ad=peek(1024+px+40*py)
706 if ad=m(1) then ad=m(2):goto 725:rem mirror
708 if ad=m(2) then ad=m(3):goto 725
710 if ad=m(3) then ad=m(4):goto 725
712 if ad=m(4) then ad=m(1):goto 725
714 if ad=g(1) then ad=g(2):goto 725:rem gun
716 if ad=g(2) then ad=g(3):goto 725
718 if ad=g(3) then ad=g(4):goto 725
720 if ad=g(4) then ad=g(1):goto 725
725 poke 1024+px+40*py,ad:return:rem l725
800 :rem if over mirror subr
801 if j=14 then 810:rem pick mirr
802 for cnt=1 to 4
804 pk=peek(1024+px+40*py)
806 if pk<>m(cnt) then 809
808 poke1024+px+40*py,32:mr=mr+1
809 next:rem place mirror subr
810 if j=13 then 825:rem place mir
812 if mr=0 then 825
814 pk=peek(1024+px+40*py)
816 if pk<>32 then 825
818 m=int(rnd(1)*4)+1:mr=mr-1
820 poke 1024+px+40*py,m(m)
825 return
900 :rem bang, shooting beam
910 pk=peek(1024+gx+40*gy)
911 :rem gun
912 if pk=107 then bx=+1:by=0:bm=64:rem pointing right
914 if pk=115 then bx=-1:by=0:bm=64:rem pointing left
916 if pk=114 then bx=0:by=+1:bm=93:rem pointing down
918 if pk=113 then bx=0:by=-1:bm=93:rem pointing up
920 x=gx:y=gy:rem gun-beam startpoint
921 pk=peek(1024+x+40*y)
922 if pk=32 then poke 1024+x+40*y,bm
924 if pk=88 then sc=sc+1000
925 if pk=88 then poke 1024+x+40*y,86
926 x=x+bx:y=y+by:rem beam travels here
928 pk=peek(1024+x+40*y)
929 if pk<>66 then 932:rem stright mirror hits
930 if bx=+1 and by=0 then d=2:poke1024+x+40*y,115
931 if bx=-1 and by=0 then d=1:poke1024+x+40*y,107
932 if pk<>67 then 945:rem stright mirror hits
937 if bx=0 and by=+1 then d=4:poke1024+x+40*y,113:
941 if bx=0 and by=-1 then d=3:poke1024+x+40*y,114:
945 if pk<>78 then 950:rem angel mirror hit
946 if bx=+1 and by=0 then d=4:poke1024+x+40*y,125
947 if bx=-1 and by=0 then d=3:poke1024+x+40*y,112
948 if bx=0 and by=+1 then d=2:poke1024+x+40*y,125
949 if bx=0 and by=-1 then d=1:poke1024+x+40*y,112
950 if pk<>77 then 960:rem angle mirror hit
952 if bx=+1 and by=0 then d=3:poke1024+x+40*y,110
954 if bx=-1 and by=0 then d=4:poke1024+x+40*y,109
956 if bx=0 and by=+1 then d=1:poke1024+x+40*y,109
958 if bx=0 and by=-1 then d=2:poke1024+x+40*y,110
959 rem beam h or w.
960 if d=1 then bx=+1:by=0:bm=64
962 if d=2 then bx=-1:by=0:bm=64
964 if d=3 then bx=0:by=+1:bm=93
966 if d=4 then bx=0:by=-1:bm=93
998 if pk<>160 then 921
999 rem end of beam
1001 print chr$(147):
1010 x=2:y=2:x$=" good work":gosub 3000
1020 x=3:y=4:x$="you killed":gosub 3000
1040 x$=str$(sc/1000)+" enemies of 10 possible"
1050 x=4:y=6:gosub 3000:
1060 x=4:y=8:x$="more plays?":gosub 3000
1068 x=9:y=12:x$=":yes":gosub 3000
1069 x=9:y=14:x$=":no":gosub 3000
1070 x=8:y=13:d=2
1071 j = peek(56320) and 31 
1072 if j = 29 then d=1
1075 if j = 30 then d=2
1076 if d=1 then poke 1024+x+40*y,32:poke 1024+x+40*(y+2),81
1077 if d=2 then poke 1024+x+40*y,81:poke 1024+x+40*(y+2),32
1078 poke 1024+x+40*y,32:poke 1024+x+40*(y+2),32
1080 if j=15 and d=2 then run
1090 if j=15 and d=1 then end
1099 goto 1071
2000 rem game over screen
2001 poke 214,12:print:poke 211,13
2002 print "{reverse on}{space*11}{reverse off}"
2004 poke 214,13:print:poke 211,13
2006 print "{reverse on} game over {reverse off}"
2008 poke 214,14:print:poke 211,13
2009 print "{reverse on}{space*11}{reverse off}"
2010 for wt=0 to 400:next wt:
2011 print chr$(147);
2012 print " lets try again "
2013 for wt=0 to 400:next wt:run
3000 poke 214,y:print:poke 211,x
3010 print x$;:return
3100 rem copy char
3110 rem ml copy all rom chars to 12288 $3000
3120 sa = 832
3130 for cnt = 0 to 147
3140 read a% : poke sa+cnt,a%: next cnt
3150 sys sa
3154 read ch
3156 if ch<>-1 then for n=0 to 7:read dt:poke 12288+n+8*ch,dt:next
3157 if ch<>-1 then goto 3154
3158 return
3159 rem sys data, for copy char
3160 data 169,48,133,52,133,56,173,14
3170 data 220,41,254,141,14,220,165,1
3180 data 41,251,133,1,162,0,189,0
3190 data 208,157,0,48,189,0,209,157
3200 data 0,49,189,0,210,157,0,50
3210 data 189,0,211,157,0,51,189,0
3220 data 212,157,0,52,189,0,213,157
3230 data 0,53,189,0,214,157,0,54
3240 data 189,0,215,157,0,55,189,0
3250 data 216,157,0,56,189,0,217,157
3260 data 0,57,189,0,218,157,0,58
3270 data 189,0,219,157,0,59,189,0
3280 data 220,157,0,60,189,0,221,157
3290 data 0,61,189,0,222,157,0,62
3300 data 189,0,223,157,0,63,232,224
3310 data 0,208,155,165,1,9,4,133
3320 data 1,173,14,220,9,1,141,14
3330 data 220,173,24,208,41,240,9,12
3340 data 141,24,208,96
3400 rem mirror deflect chars ch then data..
3410 data 109,216,248,120,63,31,14,7,3
3420 data 110,192,224,112,248,252,30,31,27
3430 data 112,3,7,14,31,63,120,248,216
3440 data 125,27,31,30,252,248,112,224,192
3450 data -1


 