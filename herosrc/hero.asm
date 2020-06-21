;-------------------------------------------------------------------------------
;John Van Ryzin's H.E.R.O.
;published by Activision
;Amstrad CPC Port/Rewrite by Flynn, May 2005
;
;
;sept. 3, 2005: added keyboard support

                 nolist
                  
;soundchip equates
finea            equ  0
coarsea          equ  1
fineb            equ  2
coarseb          equ  3
finec            equ  4
coarsec          equ  5
noise            equ  6
mixer            equ  7
channela         equ  8
channelb         equ  9
channelc         equ  10
envperiode_lo    equ  11
envperiode_hi    equ  12
envelope_shape   equ  13

soundfull        equ  %00001111
soundpst         equ  %00000000
envelope_on      equ  %10000
mixer_default    equ  %00101010

;x-positioning equates for life icons, bomb icons and score digits  
posoffs          equ  4
posleft          equ  27
pos1             equ  posleft+(posoffs*0)
pos2             equ  posleft+(posoffs*1)
pos3             equ  posleft+(posoffs*2)
pos4             equ  posleft+(posoffs*3)
pos5             equ  posleft+(posoffs*4)
pos6             equ  posleft+(posoffs*5)

topoffset        equ  10
heroheight       equ  23

;collision flags
col_flag_compltl equ  0
col_flag_compltr equ  1
col_flag_enemy   equ  2
col_flag_lantern equ  3
col_flag_flashw  equ  4
col_flag_bomb    equ  5
col_flag_water   equ  6

;joystick buttons  
joyup            equ  0
joydown          equ  1
joyleft          equ  2
joyright         equ  3
joyfire          equ  4

;-------------------------------------------------------------------------------
;start game
         org  &100
         
startgame
         di
         im   1
         
         ;-----------------------
         ;- start of init block -    
         ;-----------------------
         ld   sp,&8000           ;set stack pointer  

         ld   hl,&c9fb           ;patch rst38 -> ei ! ret
         ld   (&38),hl

         call blackout         
         call setupcrtc
         call setupytab
         
         ld   bc,&f700           ;set PPI A & C to output
         ld   a,%10000010
         out  (c),a

         ld   bc,&7f00
         ld   a,%10001100        ;set mode 0/up dis, lo dis
         out  (c),a
                 
         ld   b,13
lppsgnul ld   c,b
         xor  a
         push bc
         call wrpsg
         pop  bc
         djnz lppsgnul
         
         call allsoundstop

         ld   c,envperiode_lo
         xor  a                  ;duration = approx. 1s (12500*ts/16)
         call wrpsg
                  
         ;-----------------------
         ;-- end of init block --    
         ;-----------------------

         ;setup new game without screen swap
         call resetgame
         call swapscroutput
         ld   bc,1
         ld   d,201
         ld   e,80
         xor  a
         call fillblock         
         call setuppowerpane
         call setupactivision
         call setuplevel
         call drawlevel
         call drawenergy
         call drawlifes
         call drawbombs
         call drawscore                           
         call swapscroutput
         ld   bc,1
         ld   d,201
         ld   e,80
         xor  a
         call fillblock                                    
         call setuppowerpane
         call setupactivision
         call drawenergy
         call drawlifes
         call drawbombs         
         call drawscore                                               
         call swapscroutput
                          
         ;program loop
         ;jumps here, if game over    
         call swapscroutput
         call drawtitlescreen
         call swapscreen
         call unblackout                           
         call setlevelcolour
pgmloop  call writinganimation
         
         ;setup new game with screen swap!!                            
         call resetgame
         call swapscroutput
         ld   bc,1
         ld   d,201
         ld   e,80
         xor  a
         call fillblock         
         call setuppowerpane
         call setupactivision
         call setuplevel
         call drawlevel
         call drawenergy
         call drawlifes
         call drawbombs
         call drawscore         
         call swapscreen
         call setlevelcolour                                                    
         call swapscroutput
         ld   bc,1
         ld   d,201
         ld   e,80
         xor  a
         call fillblock                                    
         call setuppowerpane
         call setupactivision
         call drawenergy
         call drawlifes
         call drawbombs         
         call drawscore                                               
         call swapscroutput
         call resetgame

         ;skill selector
         xor  a
         ld   (rungame5),a

sklrstrt ld   a,%00010000
         call selectdingsound
         xor  a
         ld   (skilblnk),a
         set  7,a
         ld   (sklfirpr),a
sklselc1 ld   a,sklblnkinit
         ld   (sklblctr),a
         
sklselc2 ld   a,(skilblnk)
         or   a
         jr   z,sklshow         

         xor  a 
         ld   (skilblnk),a
         call clearlevel
         jr   sklselct

sklshow  set  7,a
         ld   (skilblnk),a
         call clearlevel
         ld   b,pos1+1
         ld   c,168+topoffset
         ld   de,&1107
         ld   hl,skill
         call drawsprite
         
         ld   a,(selskill)
         and  a
         sla  a
         ld   e,a
         ld   d,0
         ld   hl,numbadr
         add  hl,de
         ld   e,(hl)
         inc  hl
         ld   d,(hl)
         ex   de,hl
         ld   b,pos6
         ld   c,168+topoffset
         ld   de,&0307             ;width, height
         call drawsprite

sklselct call waitvsync
         call flashwalls
         call readjoystick
         ld   a,(sklfirpr)
         or   a
         jr   z,sklcheck
         ld   a,(joybyte)
         or   a
         jp   nz,sklnochk
         
sklcheck ld   a,(joybyte)
         ld   (sklfirpr),a
         bit  joyleft,a
         jr   nz,sklleft
         bit  joyright,a
         jr   nz,sklright
         bit  joyfire,a
         jr   nz,sklfire
         jp   sklnochk                  

sklright ld   a,(selskill)
         inc  a
         cp   6
         jr   nz,sklrtwr
         ld   a,1  
sklrtwr  ld   (selskill),a
         jp   sklrstrt

sklleft  ld   a,(selskill)
         dec  a
         or   a
         jr   nz,sklltwr
         ld   a,5         
sklltwr  ld   (selskill),a
         jp   sklrstrt
         
sklfire  ld   a,(selskill)
         cp   5
         jr   z,sklpro
         cp   4
         jr   z,sklgm4
         cp   3
         jr   z,sklgm3
         cp   2
         jr   z,sklgm2
           
         ;game 1         
         xor  a
         ld   (prolevel),a
         ld   (level),a
         ld   hl,level1
         ld   a,1
         ld   (level+1),a         
         ld   (levnumbr),a         
         jr   sklout

         ;game 2         
sklgm2   xor  a
         ld   (prolevel),a
         ld   (level),a
         ld   hl,level5
         ld   a,5
         ld   (level+1),a
         ld   (levnumbr),a
         jr   sklout

         ;game 3         
sklgm3   xor  a
         ld   (prolevel),a
         ld   (level),a
         ld   hl,level9
         ld   a,9
         ld   (level+1),a         
         ld   (levnumbr),a
         jr   sklout

         ;game 4         
sklgm4   xor  a
         ld   (prolevel),a
         ld   hl,level13
         ld   a,1
         ld   (level),a
         ld   a,3
         ld   (level+1),a
         ld   a,13
         ld   (levnumbr),a
         jr   sklout

         ;game 5/pro         
sklpro   ld   a,1
         ld   (prolevel),a
         ld   (rungame5),a
         ld   hl,level17

sklout   ld   (pnextlev),hl

         ld   a,%00010111
         call selectdingsound
         call clearlevel
         call drawscore
         call showlevel
         ld   b,6
waitding push bc
         call waitvsync
         ei
         halt
         halt
         di
         pop  bc
         djnz waitding         
         
         call allsoundstop
         ld   c,envperiode_hi
         ld   a,13  
         call wrpsg
         ld   c,mixer
         ld   a,mixer_default         
         call wrpsg
         jr   newlevel
         
sklnochk ei
         halt
         halt
         di
         ld   a,(sklblctr)
         or   a
         jp   z,sklselc1
         dec  a
         ld   (sklblctr),a
         jp   sklselct

         ;new level begins here
newlevel ld   a,15;46            ;set hero startpos x
         ld   (herox),a
         ld   (newherox),a
         call setuplevel
         ld   a,1
         ld   (newlevl),a
         ld   a,6
         ld   (bombs),a
         ld   a,powercntrinit
         ld   (powercnt),a
         xor  a
         ld   (timeout),a
         
         ;level restarts here, after hero has died 
restart  ld   c,channelb         ;volume b, pssst!!!
         ld   a,%00000000
         call wrpsg
                                  
         ld   a,&c9              ;patch make roto sound
         ld   (makerotosound),a

         call swapscroutput      ;setup new level
         call drawlevel
         call drawenergy
         call drawlifes
         call drawbombs         
         call drawscore          
         call swapscreen
         call setlevelcolour         
         call swapscroutput      
         call clearlevel
         call drawscore
         call swapscroutput      
                  
         xor  a                  ;start level, hero is flying
         ld   (herodir),a
         cpl         
         ld   (herofly),a        ;hero is flying
         call fillenergy         ;fill up energy "movie"     

         xor  a                  ;no old laser to be erased
         ld   (oldlasln),a
         ld   (bombset),a        ;no bombset
         ld   (dntvsync),a       ;no "no vsync" flag
         ld   (updtscre),a       ;no "update score" flag
         ld   (heroclsn),a       ;clear collision flags         
         ld   (newlevl),a       ;no new level!!!
         ld   a,bmbsndinit
         ld   (bombsnd),a
         ld   a,boumdlyinit
         ld   (boumctr),a                 

         ;*****************************
         ;****** game loop start ******
         ;*****************************
         
gameloop ;update changed x,y 
         ld   a,(newherox)
         ld   (herox),a
         ld   a,(newheroy)
         ld   (heroy),a

         ;draw hero twice, 2x vsync
         ld   b,2
vsrep    push bc
         ld   a,(dntvsync)
         or   a
         jr   nz,refiff
         ld   b,&F5
vsync2   in   a,(c)
         rra  
         jr   nc,vsync2         
         jr   vsync3

refiff   ei
         halt
         di
         ;flashing col
vsync3   call flashwalls

         ;roderick is standing on raft -> movement patch
         ld   a,(heroonraft)
         or   a
         jr   z,dhnormal
         ld   a,(herox)
         ld   b,a
         ld   a,(heroy)
         ld   c,a
         ld   de,&0418
         ld   hl,heroback
         push de
         push hl
         call drawbackground
         pop  hl
         pop  de
         ld   a,(newherox)
         ld   (herox),a
         ld   b,a
         ld   a,(newheroy)
         ld   (heroy),a
         ld   c,a
         call savebackground
         xor  a                 ;nop
         jr   dhnorm2 

         ;normal draw hero twice
dhnormal ld   a,&76             ;halt 
dhnorm2  ld   (dcrpjmpi),a
         ld   (dcrpjmpi+1),a
         ld   (hltptch2),a
         ld   (hltptch3),a
         call drawhero
         ld   a,(dntvsync)
         or   a
         jr   nz,gl2
         call vsyncgap
gl2      xor  a
         ld   (joybyte),a
         
         ;crushing walls?
         pop  bc
         push bc
         ld   a,b
         cp   2
         jp   nz,crushend
         ld   hl,(clvptrb1)
         ld   de,120
         add  hl,de
         bit  7,(hl)
         jp   z,crushend
         
         ld   a,(crushctr)
         or   a
         jr   z,crushgo
         dec  a
         ld   (crushctr),a
         jp   crushend
         
crushgo  ld   a,crushctrinit
         ld   (crushctr),a         

         xor  a                 ;patch halt to nop
         ld   (dcrpjmpi),a
                                      
         inc  hl                             
         inc  hl
         inc  hl                             
         inc  hl
         ld   a,(hl)                         ;crush block cntr
         bit  7,a
         jp   nz,crushopn
         
         ;***CRUSH CLOSE***         
         ld   b,a
         or   a
         jr   nz,crushdec
         inc  a
         set  7,a
         jr   crushcwr
crushdec dec  a
crushcwr ld   (hl),a

         ;CRUSH CLOSE: decrease "erasing laser length" 
         ld   a,(oldlasy)            
         sub  52+topoffset+1
         jr   c,nolascor
         sub  38
         jr   nc,nolascor
         ld   a,(oldlasln)
         or   a
         jr   z,nolascor
         sub  2
         jr   nc,stcnewls
         xor  a
stcnewls ld   (oldlasln),a         

         ;CRUSH CLOSE LEFT
nolascor push bc         
         ld   a,19
         sub  b                           
         ;*set block in mem
         ld   d,0
         ld   e,a                  
         ld   hl,(clvptrb2)
         add  hl,de
         ld   a,initialwallstrength or flashingwall       
         ld   (hl),a

         ;*prepare draw block
         sla  e
         ld   b,e
         ld   c,52+topoffset+2

         ;*collision test: hero in y range?
         ld   a,(newheroy)
         cp   28+topoffset+1      ;above crushing walls?
         jr   c,crnocllt          ;yes, no collision detection 
         cp   92+topoffset        ;below crushing walls?
         jr   nc,crnocllt         ;yes, no collision detection 

         ;*collision test: hero in x range?
         ld   yl,1                ;yl=flag, 1=hero is in y range, detection
         ld   a,(newherox)
         res  0,a
         sub  b
         jr   z,crcolylt
         jr   nc,crycollt

         ;*collision!!!!!!!
crcolylt ld   a,(heroclsn)
         set  col_flag_flashw,a
         ld   (heroclsn),a
         ld   a,(newherox)
         sub  b
         jr   z,crcnndlt
         ld   e,a
         ld   d,&26
         jr   crcontlt
 
         ;*continue draw block
crnocllt ld   yl,0                ;yl=flag, 0=hero is not in y range, no detection
crycollt ld   de,&2602
crcontlt ld   a,%00111111
         call fillblock
crcnndlt pop  bc

         ;CRUSH CLOSE RIGHT
         push bc                           
         ld   a,20
         add  b                           
         ;*set block in mem
         ld   d,0
         ld   e,a                  
         ld   hl,(clvptrb2)
         add  hl,de
         ld   a,initialwallstrength or flashingwall       
         ld   (hl),a
         
         ;*prepare draw block
         sla  e
         ld   b,e
         ld   c,52+topoffset+2

         ;*collision test: hero in x range?
         ld   a,yl
         or   a
         jr   z,crycolrt
         
         ld   a,(newherox)
         add  4
         res  0,a
         sub  b
         jr   c,crycolrt
         
         ;*collision!!!!!!!
crcolyrt ld   a,(heroclsn)
         set  col_flag_flashw,a
         ld   (heroclsn),a
         ld   a,(newherox)
         add  4
         sub  b
         jr   z,crycolrt
         ld   e,a
         ld   d,&26
         inc  b
         jr   crcontrt

         ;*continue draw block
crycolrt ld   de,&2602
crcontrt ld   a,%00111111
         call fillblock
crcnndrt pop  bc
         jr   crushend

crushopn ;***CRUSH OPEN***
         res  7,a         
         ld   b,a
         cp   7                    ;crush width
         jr   nz,crushinc
         dec  a         
         jr   crushowr
crushinc inc  a
         set  7,a
crushowr ld   (hl),a
         ;CRUSH CLOSE LEFT
         push bc         
         ld   a,20
         sub  b                           
         ;*set block in mem
         ld   d,0
         ld   e,a                  
         ld   hl,(clvptrb2)
         add  hl,de
         xor  a       
         ld   (hl),a
         ;*draw block
         sla  e
         ld   b,e
         ld   c,52+topoffset+2
         ld   de,&2602
         call fillblock
         pop  bc
         ;CRUSH CLOSE RIGHT
         push bc         
         ld   a,19
         add  b                           
         ;*set block in mem
         ld   d,0
         ld   e,a                  
         ld   hl,(clvptrb2)
         add  hl,de
         xor  a       
         ld   (hl),a
         ;*draw block
         sla  e
         ld   b,e
         ld   c,52+topoffset+2
         ld   de,&2602
         call fillblock
         pop  bc
         ;- end crushcode --------

crushend xor  a  
         ld   (dntvsync),a
         
         ;update score?
         ld   a,(updtscre)
         or   a
         jr   z,dolassnd
         xor  a
         ld   (updtscre),a
         call drawscore
     
         ;do laser beam sound
dolassnd ld   a,(oldlasln)
         or   a
         jr   z,laserpst
         ld   c,channela
         ld   a,soundfull
         call wrpsg
         ld   c,channelc
         ld   a,soundfull
         call wrpsg
         ld   c,finec
         ld   a,(lssndr)
         sub  10       
         ld   (lssndr),a   
         call wrpsg
         ld   c,finea
         ld   a,(lssndl)
         sub  9       
         ld   (lssndl),a   
         call wrpsg         
         ld   a,(lssndctr)
         dec  a
         jr   nz,frsndset
         ld   a,lasersndintl
         ld   (lssndl),a 
         ld   a,lasersndintr
         ld   (lssndr),a
         ld   a,lssndctri
frsndset ld   (lssndctr),a
         jr   overlas
                  
laserpst ld   c,channela
         ld   a,soundpst
         call wrpsg
         ld   c,channelc
         ld   a,soundpst
         call wrpsg
         
overlas  pop  bc
         
         ;collision test
         ld   a,b
         cp   1
         jr   z,vsloop
         push bc
         call collisiontest         

         ;decrease power
         ld   a,(powercnt)
         dec  a
         or   a
         jr   z,decrpowr
         ld   (powercnt),a
         jr   drwenmis
decrpowr ld   a,powercntrinit
         ld   (powercnt),a
         ld   a,(energy)
         or   a
         jp   z,timeover
         dec  a
         ld   (energy),a
         call drawenergy
         ei
         jr   dcrpjmpi

         ;draw enemies
drwenmis ei
         halt
dcrpjmpi halt
         halt
         ;halt
         di
         ld   b,8
         call waitsl
                  
         call drawenemies
         pop  bc

vsloop   djnz vsloop2
         jr   novsloop
vsloop2  jp   vsrep
         
         ;update joystick status and move calc new x, y of hero sprite
novsloop ei
         halt
         di
         call readjoystick
         call heromove

         ;give up
         ld   a,(escbyte)
         bit  2,a
         ;call nz,giveupquestion
         jr   z,wimpjmp         ;delete....
         ld   (wimp),a          ;....this, if enough mem left
wimpjmp  ld   a,(wimp)
         or   a
         jp   nz,gaveup
                          
         ;2.-4. sync block
         ;place to fill non painting, logic stuff
         ei
         halt 
hltptch2 halt 
hltptch3 halt 
         di
         ld  a,(hltptch2)
         or  a
         jr  nz,restrbck
         ld   b,8
         call waitsl

         ;restore hero's background, draw placed bomb and enemies 
restrbck ld   a,(herox)
         ld   b,a         
         ld   a,(heroy)
         ld   c,a
         ld   de,&0418
         ld   hl,heroback         
         
         push de
         push hl                  
         
         call drawbackground
         call drawbomb
         call drawfire
         call pointscounter
         
         ;test collision flag 
         ld   a,(heroclsn)
         bit  col_flag_enemy,a
         jr   nz,herodie
         bit  col_flag_bomb,a
         jp   nz,herodiesbomb
         bit  col_flag_water,a
         jr   nz,heroflwl
         bit  col_flag_flashw,a
         jr   nz,heroflwl
         bit  col_flag_lantern,a
         jr   nz,latnolgt
         bit  col_flag_compltr,a
         jr   nz,levcmplr         
         bit  col_flag_compltl,a
         jr   nz,levcmpll         
         jr   savherbg

levcmplr pop  hl
         pop  de
         ld   a,(herofly)
         or   a
         jr   nz,lvcmplr2
         ld   a,(herodir)
         or   a
         jr   z,lvcmplr2
         ld   a,(colsavb)
         add  3
         ld   (newherox),a
lvcmplr2 ld   hl,minrescr
         jp   levelcompleted

levcmpll pop  hl
         pop  de
         ld   a,(herofly)
         or   a
         jr   nz,lvcmpll2
         ld   a,(herodir)
         or   a
         jr   nz,lvcmpll2
         ld   a,(colsavb)
         sub  3
         ld   (newherox),a
lvcmpll2 ld   hl,minrescl
         jp   levelcompleted

herodie  pop  hl
         pop  de
         jp   herodies

heroflwl pop  hl
         pop  de
         ld   a,(newheroy)  
         ld   (heroy),a
         jp   herodies 
                  
latnolgt res  col_flag_lantern,a
         ld   (heroclsn),a
         ld   a,(colsavb)
         ld   b,a
         ld   a,(colsavc)
         ld   c,a
         ld   de,&030b
         ld   hl,lantnoff
         call drawsprite
                  
         ;save hero's background 
savherbg pop  hl
         pop  de

         ld   a,1
         ld   (dntvsync),a
         call waitvsync
         
         ld   a,(newherox)
         ld   b,a
         ld   a,(newheroy)
         ld   c,a   
         call savebackground
         
         ;update movement of hero's legs
svlgs3   ld   a,(horunng)
         or   a
         jr   nz,svlgsrun                  
         jr   svlgs
svlgsrun ld   a,(herolegs)
         inc  a
         cp   12
         jr   nz,svlgs
         ld   a,2         
svlgs    cp   1
         jr   nz,svlgs2
         ld   a,2
svlgs2   ld   (herolegs),a
         
         ;repeat game loop 
         jp   gameloop
         
         ;timeout
timeover
         ld   a,1
         ld   (timeout),a
         ld   hl,(pcurlev)
         ld   (pnextlev),hl         
         jr   herodies           

herodiesbomb
         call waitvsync
         call drawbomb
         ld   a,(herox)
         ld   b,a         
         ld   a,(heroy)      
         ld   c,a
         ld   de,&0418
         ld   hl,herodead         
         ld   a,(bombset)
         or   a
         jr   z,herodibm
         call drawsprite_or
         jr   herodiesbomb
herodibm call drawsprite
         call ziiing
         ld   a,(lifes)
         or   a
         jp   z,gamov2  
         dec  a
         ld   (lifes),a
         jr   hodi2
         
         ;wimp gave up!!!
gaveup   xor  a
         ld   (lifes),a
         ld   (scrnswap),a
         ld   (energy),a        

herodies call herosilence
         xor  a
         ld   (backclr),a
         call setbackclr    
         ei        
         halt 
         halt 
         halt 
         di         
         ld   a,(herox)
         ld   b,a         
         ld   a,(heroy)      
         ld   c,a
         ld   de,&0418
         ld   hl,heroback         
         push bc
         push de 
         call drawbackground
         xor  a                    ;erase laser beam
         ld   (joybyte),a
         call drawfire
         pop  de
         pop  bc

         push bc
         push de
         ld   hl,herodead
         call drawsprite_or
         pop  de
         pop  bc
         ld   a,(lifes)
         or   a
         jr   z,gameover
         dec  a
         ld   (lifes),a
         push bc
         push de
         call ziiing
         pop  de
         pop  bc         
         ld   hl,heroback
         call drawbackground
hodi2    call drawlifes
         ld   a,(timeout)
         or   a
         jp   nz,newlevel
         
         ;was a collision with a crushing wall?
         ld   hl,(clvptrb1)
         ld   de,120
         add  hl,de
         bit  7,(hl)
         jr   nz,crushcollision

         ;no crushing wall collision
         ld   a,(herox)
         ld   (newherox),a
         ld   a,(heroy)
         ld   (newheroy),a   
         jp   restart
         
crushcollision
         ;yes, crushing wall collision
         ld   a,38
         ld   (herox),a
         ld   (newherox),a
         ld   a,topoffset+14
         ld   (heroy),a
         ld   (newheroy),a   
         jp   restart
                  
gameover 
         call drawenergy
         call drawlifes
         call ziiing
gamov2   call swapscroutput
         call drawtitlescreen
         call swapscroutput
         jp   pgmloop
         
levelcompleted
         ld   a,(colsavb)
         ld   b,a
         ld   a,(colsavc)
         ld   c,a
         ld   de,&040c
         call drawsprite
         ld   a,(herofly)
         or   a
         jr   nz,levcmpld
         xor  a
         ld   (herolegs),a
levcmpld call drawhero

         call allsoundstop


         ;miner rescued -> 1000 pts
         ld   b,11
minrscpt push bc
         ld   c,&90
         call addpoints
         pop  bc
         djnz minrscpt
         ld   c,&10
         call addpoints
         call drawscore           

         ;count down remaining power/energy
         ld   a,(energy)
         or   a
         jr   z,countbmb
         ld   c,mixer
         ld   a,%00111000
         call wrpsg
         ld   c,fineb
         ld   a,%10001000
         call wrpsg

         ld   c,envperiode_hi
         ld   a,2                        ;duration = approx. 1/4
         call wrpsg

         ld   c,fineb
         ld   a,%10100100
         call wrpsg
                  
         ld   c,channelb
         ld   a,soundfull or envelope_on 
         call wrpsg
                  
         ld   c,envelope_shape
         ld   a,%1000                      ;envshape: \|\|\|\|\|
         call wrpsg
     
decpower call waitvsync

         ld   a,(curlvnbr)
         and  a
         sla  a
         ld   b,a
setpts1  push bc
         ld   c,&05
         call addpoints
         pop  bc
         djnz setpts1         
         ld   c,&10
         call addpoints         
         call drawscore           
         call waitvsync
         
         ld   a,(curlvnbr)
         and  a
         sla  a
         ld   b,a
setpts2  push bc
         ld   c,&05
         call addpoints
         pop  bc
         djnz setpts2        
         ld   c,&15
         call addpoints
         call drawscore
                             
         ld   a,(energy)
         dec  a
         ld   (energy),a
         push af
         call drawenergy         
         pop  af
         jr   nz,decpower

         ;count down remaining bombs
countbmb call allsoundstop
         ld   c,mixer
         ld   a,mixer_default
         call wrpsg
         ld   c,envperiode_hi
         ld   a,8  
         call wrpsg

decbombs ld   a,(bombs)
         or   a
         jr   z,nocntbmb
         dec  a
         ld   (bombs),a
         push af
         ld   c,noise
         ld   a,%11111
         call wrpsg
         ld   c,envelope_shape
         ld   a,%0000                ;envshape: \_____
         call wrpsg
         ld   c,channelb
         ld   a,soundfull or envelope_on
         call wrpsg
         ld   c,&50
         call addpoints
         call drawscore           
         call drawbombs
         pop  af
         ld   b,13
bombpaus push bc
         call waitvsync
         ei
         halt
         halt
         di
         pop  bc
         djnz bombpaus
         jr   decbombs
                                   
nocntbmb ld   c,envperiode_hi
         ld   a,13  
         call wrpsg
                 
         ;select random level
         ld   a,(levnumbr)
         cp   20
         jr   nz,isprolv
         ld   a,1
         ld   (prolevel),a
isprolv  ld   a,(prolevel)
         or   a
         jr   z,nxtlvnrm
         ld   hl,randlvls
         ld   a,r
         and  15
         or   a
         jr   z,rndlev1
         sla  a
         ld   e,a
         ld   d,0
         add  hl,de
rndlev1  ld   e,(hl)
         inc  hl
         ld   d,(hl)
         ld   (pnextlev),de
         jr   inclvcol
         
nxtlvnrm call addlevelnr
inclvcol ld   a,(levelcoltabptr)
         inc  a
         cp   4
         jr   nz,ncltbnul
         xor  a
ncltbnul ld   (levelcoltabptr),a
         jp   newlevel

         ;*****************************
         ;******* game loop end *******
         ;*****************************
                           
         ;gameloop data stuff 
powercntrinit equ 65 

herox    db   44
heroy    db   5
newherox db   44                                                 
newheroy db   5
herodir  db   0         ;Z=right,NZ=left
rotostat db   0         ;0=100, 1=50, 2=0 3=50
rotosnd  db   0
herofly  db   0         ;hero is flying flag
herolegs db   2         ;0=stand, 1-10=run state (*2:1-5)
dntvsync db   0         ;do not first hero vsync, cos the fire took longer as vsync

updtscre db   0         ;update score
altcolr1 equ  12  ;&0c
altcolr2 equ  07  ;&1c
altcntri equ  5
altercol db   altcolr1
altercnt db   altcntri
powercnt db   0

heroclsn db   0
newlevl  db   0

wimp     db   0
timeout  db   0

prolevel db   0

sklblnkinit equ 7;9
selskill db   1
skilblnk db   0
sklblctr db   0
sklfirpr db   0
rungame5 db   0

crushctrinit equ 1
crushctr db   0

randlvls dw   level5,  level6,  level7,  level8
         dw   level9,  level10, level11, level12
         dw   level13, level14, level15, level16
         dw   level17, level18, level19, level20         


;-------------------------------------------------------------------------------
;waitsl
;wait b scan lines
;
waitsl   push bc
         ld   b,&29
waitsl2  djnz waitsl2
         pop  bc
         djnz waitsl   
         ret
                  
;-------------------------------------------------------------------------------
;selectdingsound
;a=b fine: tone periode
;
selectdingsound
         ld   c,fineb
         call wrpsg
         ld   c,envperiode_hi
         ld   a,4  
         call wrpsg
         ld   c,mixer            
         ld   a,%00111000                  ;mixer all tone 
         call wrpsg
         ;ld   c,fineb
         ;ld   a,%00010000
         ;call wrpsg
         ld   c,channelb
         ld   a,soundfull or envelope_on
         call wrpsg         
         ld   c,envelope_shape
         ld   a,%0000                      ;envshape: \_____
         call wrpsg 
         ret
         
;-------------------------------------------------------------------------------
;vsyncgap
vsyncgap
         ld   a,(newheroy)
         cp   116         ;116
         ret  c
         ld   b,10       ;count ten scanlines
vsgpaus2 push bc
         ld   b,63        ;one scanline
vsgpause djnz vsgpause
         pop  bc
         djnz vsgpaus2
         ret

;-------------------------------------------------------------------------------
;placepoints
;in:hl=pointer mem, bc=pos, fix size=&0405
;
placepoints
         ex   de,hl          
         ld   hl,plcpntct    ;free "points-slots"?
         ld   a,(hl)
         or   a
         jr   z,plpnset
         inc  hl             ;next record
         inc  hl
         inc  hl
         inc  hl
         inc  hl
         ld   a,(hl)
         or   a
         ret  nz

plpnset  ld   a,plpncninit    ;store...
         ld   (hl),a          ;...counter
         inc  hl
         ld   (hl),b          ;store...
         inc  hl              ;...x and y
         ld   (hl),c          ;
         inc  hl
         ld   (hl),e          ;store....
         inc  hl              ;...pointer
         ld   (hl),d          ;
         ret
           
plcpntct db   0       ;pnt1 counter
         dw   0       ;xy
         dw   0       ;hl pointer
plcpntc2 db   0       ;pnt2 counter                                                                 
         dw   0       ;xy                                                                 
         dw   0       ;hl pointer

plpncninit equ 8
           
;-------------------------------------------------------------------------------
;pointscounter
;
pointscounter
         ld   b,2
         ld   hl,plcpntct
ptscntlp push bc  
         ld   a,(hl)
         or   a
         jr   z,ptscntnx
         cp   1
         jr   z,ptscntnl
         dec  a
         ld   (hl),a
         inc  hl
         ld   b,(hl)
         inc  hl
         ld   c,(hl)
         push hl
         inc  hl         
         ld   e,(hl)
         inc  hl
         ld   d,(hl)
         ex   de,hl
         ld   de,&0405
         call drawsprite_or
         pop  hl
         jr   ptscntx2
         
ptscntnx inc  hl
         inc  hl
ptscntx2 inc  hl
         inc  hl
         inc  hl
         pop  bc
         djnz ptscntlp 
         ret

ptscntnl push hl
         xor  a
         ld   (hl),a
         inc  hl
         ld   b,(hl)
         inc  hl
         ld   c,(hl)
         inc  c
         ld   de,&0504
         call fillblock
         pop  hl
         jr   ptscntnx
                  
;-------------------------------------------------------------------------------
;allsoundstop
;
allsoundstop
         ld   c,channelb
         ld   a,soundpst
         call wrpsg   

acsoundstop
         ld   c,channela
         ld   a,soundpst
         call wrpsg   
         ld   c,channelc
         ld   a,soundpst
         call wrpsg   
         ret   

;-------------------------------------------------------------------------------
;collision test
;
collisiontest
         ld   hl,(clvptrb1)
         ld   de,120+4+1      ;+1 = crushcounter                                                  
         add  hl,de

         ;collision test
coltstlt ld   b,items
cltstllp push bc
         ld   a,(hl)         
         or   a
         jr   z,cltstlsk
         push hl
         pop  ix
         inc  hl              ;skip itemtype 
         inc  hl              ;skip number of sprites
         ld   a,(hl)
         and  a               ;patch 1
         sla  a
         ld   (cltstptc+1),a
         
         ld   b,11            ;fill up patch
         sub  b
         cpl
         inc  a
         ld   (cltstlnr+1),a
                            
         inc  hl              

         ld   b,(hl)          ;retrive x (b) and...
         inc  hl              ;
         ld   c,(hl)          ;...and y (c)

         ld   de,5            ;skip...
         add  hl,de           ;...movement parameter

cltstptc ld   de,0            ;patched addition to correct sprite pointer
         add  hl,de
         
         ld   e,(hl)          ;retrieve...
         inc  hl              ;...width and              
         ld   d,(hl)          ;...height of enemy
         push hl              ;
         ex   de,hl           ;
         ld   e,(hl)          ;e = height of enemy
         inc  hl              ; 
         ld   d,(hl)          ;d = width of enemy
         pop  hl              ;
         
         ld   a,(newherox)    ;test: is enemy in x range
         sub  b
         jr   c,cltstxc1
         sub  d               ;case 2: hero > enemy --> test enemy width
         jr   cltstxc2                  
cltstxc1 cpl                  ;case 1: hero < enemy --> test hero width
         sub  3               ;&14-&18 =-4 -> "cpl ! inc 1" or "sub herowidth-1"
cltstxc2 jr   nc,cltstlnr

         ld   a,(newheroy)    ;test: is enemy in y range
         sub  c
         jr   c,cltstyc1
         sub  e
         jr   cltstyc2
cltstyc1 cpl
         sub  23              ;heroheight -1 = 24-1 = 23         
         jr   cltstyc2
cltstyc2 jr   nc,cltstlnr

         ld   a,(ix+0)
         cp   item_lantern_off
         jr   z,cltstlfn
         cp   item_lantern_on
         jr   z,lantern_collision
         cp   item_miner_rt
         jr   z,level_finished_rt
         cp   item_miner_lt
         jr   z,level_finished_lt
         cp   item_raft
         jr   z,cltstlfn
         ;hero dies
         xor  a
         ld   (ix+0),a
         ld   a,(heroclsn)
         set  col_flag_enemy,a
         ld   (heroclsn),a
cltstlfn pop  bc
         ret  
                    
cltstlnr ld   de,11                  ;itclltnr
         add  hl,de
         jr   cltstlnx
         
cltstlsk ld   de,itemrecsize
         add  hl,de
         
cltstlnx pop  bc
         djnz cltstllp
         ret

lantern_collision
         ld   a,item_lantern_off     ;set lantern to off
         ld   (ix+0),a

         ld   hl,_lantoff   
         ld   (ix+9),l               ;new sprite
         ld   (ix+10),h
                                  
         ld   hl,(clvptrb1)
         dec  hl
         ld   (hl),20

         ld   hl,colsavb
         ld   (hl),b
         inc  hl
         ld   (hl),c

         call setlevelcolour         ;change level colour

         ld   a,(heroclsn)         
         set  col_flag_lantern,a
         ld   (heroclsn),a
lantcolp pop  bc                     ;THIS OPCODE MUST BE "POP BC", PATCHED!!!!
         ret  
         
level_finished_rt
         ld   a,(heroclsn)
         set  col_flag_compltr,a
finjmpin ld   (heroclsn),a
         ld   hl,colsavb
         ld   (hl),b
         inc  hl
         ld   (hl),c
         pop  bc
         ret  

level_finished_lt
         ld   a,(heroclsn)
         set  col_flag_compltl,a
         jr   finjmpin
         ;end test enemies

colsavb  db   0
colsavc  db   0

;-------------------------------------------------------------------------------
;flash walls
;
flashwalls
         ld   a,(altercnt)
         or   a
         jr   nz,flashdec
         ld   a,altcntri
         ld   (altercnt),a
         ld   a,(altercol)
         cp   altcolr1
         jr   nz,flashs1
         ld   a,altcolr2
         jr   flashs2
flashs1  ld   a,altcolr1
flashs2  ld   (altercol),a
         ld   bc,&7f0e
         out  (c),c         
         or   %01000000
         out  (c),a
         ret                           
flashdec dec  a
         ld   (altercnt),a
         ret
         
;-------------------------------------------------------------------------------
;drawfire
;todo:
; der laser beam kann rechts oder links zum bildschirm aus
; getestet werden -> swap 255, oder 41 swap!!!!!!
;
drawfire
         ;delete old laser beam
         ld   a,(oldlasln)
         or   a
         jr   z,dfr
         ld   h,a              ;save laser len to subtract, if dir = left
         ld   e,a
         ld   d,1
         ld   a,(oldlasx)
         ld   b,a
         ld   a,(oldlasy)
         inc  a
         ld   c,a
         ld   a,(oldlasdr)
         or   a
         jr   nz,dellaslt
         jr   dellaser
dellaslt ld   a,b
         sub  h
         ld   b,a
dellaser xor  a
         ld   (oldlasln),a
         call fillblock
                  
         ;fire pressed?         
dfr      ld   a,(joybyte)            
         bit  joyfire,a              
         jp   nz,lasfire

         ;no fire pressed!
         xor  a
         ld   (lasbeam),a
         ret

         ;yes, fire pressed
         ;determine laser length and laser direction
lasfire  ld   a,(herodir)
         ld   (oldlasdr),a
         or   a
         jp   nz,lasleft
         
         ;laser right
         ld   a,1             ;no vsync test!!!!   
         ld   (dntvsync),a
         
         ld   a,(newherox)
         add  3               ;add 3 to x -> hero looks at right side
         ld   b,a
         ld   (oldlasx),a
         ld   a,(newheroy)
         add  4               ;increment y -> helmet
         ld   (oldlasy),a
         ld   c,a
         push bc
         ld   yl,b
         call getstage
         ld   b,laslength     ;max laser length
         ld   c,yl
dflooprt or   a               ;wall...
         call nz,decwalrt     ;...collision?
         jp   nz,walcolrt     ;     

         ;begin test enemies
         ld   a,laslength
         sub  b
         ld   (curlaslen),a
         push bc
         push de
         ld   hl,(clvptrb1)
         ld   bc,120+4+1
         add  hl,bc
         ld   b,items
itclrtlp push bc
         ld   a,(hl)
         or   a
         jp   z,itclrtsk
         push hl
         pop  ix
         inc  hl              ;
         inc  hl              ;skip...
         inc  hl              ;...animation counters

         ld   b,(hl)          ;retrive x (b) and...
         inc  hl              ;
         ld   c,(hl)          ;...and y (c)

         ld   de,5            ;skip...
         add  hl,de           ;...movement parameter

         ld   e,(hl)          ;retrieve...
         inc  hl              ;...width and              
         ld   d,(hl)          ;...height of enemy
         push hl              ;
         ex   de,hl           ;
         ld   e,(hl)          ;e = height of enemy
         inc  hl              ; 
         ld   d,(hl)          ;d = width of enemy
         pop  hl              ;
         
         ld   a,(oldlasy)     ;test: is enemy in y range
         sub  c
         jr   c,itclrtnr
         sub  e
         jr   nc,itclrtnr
         
         ld   a,(oldlasx)
         ld   yh,a
         ld   a,(curlaslen)
         add  yh
         sub  d
         sub  b
         jr   nc,itclrtnr
         cpl
         sub  d
         jr   nc,itclrtnr

         ld   a,(ix+0)
         cp   item_lantern_on
         call z,fried_lantern
         jr   z,itclrtfn
         and  item_mask_drlev
         or   a
         jr   nz,itclrtfn
         ld   a,(ix+0)
         xor   a                        ;patch to "dec a" to decrease strength
         ;dec  a
         ld   (ix+0),a
         jr   nz,itclrtfn

         ld   a,(ix+2)
         push ix
         pop  hl
         ld   de,9
         add  hl,de
         sla  a
         ld   e,a
         add  hl,de
         ld   e,(hl)
         inc  hl
         ld   d,(hl)
         ex   de,hl
         ld   d,(hl)
         inc  hl
         ld   e,(hl)

         inc  c
         xor  a
         push bc
         push de
         call fillblock         
         pop  de  
         pop  bc
         
         dec  c
         ld   hl,pts50
         call placepoints

         ld   c,&50
         call addpoints                  
         ld   a,1
         ld   (updtscre),a                  
         jr   itclrtfn           
itclrtnr ld   de,11
         add  hl,de
         jr   itclrtnx
         
itclrtsk ld   de,itemrecsize
         add  hl,de
         
itclrtnx pop  bc
         djnz itclrtlj
         jr   itclrtx2
itclrtlj jp   itclrtlp

itclrtfn pop  bc
         pop  de
         pop  bc
         jr   walcolrt 
itclrtx2 pop  de
         pop  bc
         ;end test enemies

         inc  c
         bit  0,c
         jr   nz,dfloprt2
         inc  de
dfloprt2 ld   a,(de)
         bit  6,a
         jr   z,dfloprtj
         xor  a
dfloprtj djnz dfloprt3
         jr   walcolrt         
dfloprt3 jp   dflooprt
         
         ;laser length is set, so draw it
walcolrt ld   a,laslength     ;a is laser length
         sub  b
         jp   z,lasln0
         ld   (oldlasln),a
         ld   d,a
         ld   e,1
         pop  bc
         ld   a,(lasbeam)
         xor  &ff
         ld   (lasbeam),a
         or   a
         jr   z,beam2rt
         ld   hl,laserb1
         call drawsprite        
         ret
beam2rt  ld   hl,laserb2   
         call drawsprite         
         ret
                  
         ;laser left
lasleft  ld   a,1             ;no vsync test!!!!   
         ld   (dntvsync),a

         ld   a,(newherox)
         inc  a               ;increment x -> hero looks at left side
         ld   b,a
         ld   (oldlasx),a
         ld   a,(newheroy)
         add  4               ;increment y -> helmet
         ld   (oldlasy),a
         ld   c,a
         push bc
         ld   yl,b
         dec  b
         call getstage
         ld   b,laslength     ;max laser length
         ld   c,yl
dflooplt or   a               ;wall... 
         call nz,decwallt     ;...collision?
         jp   nz,walcollt     ;
         
         ;begin test enemies
         ld   a,laslength
         sub  b
         ld   (curlaslen),a
         push bc
         push de
         ld   hl,(clvptrb1)
         ld   bc,120+4+1
         add  hl,bc
         ld   b,items
itclltlp push bc
         ld   a,(hl)         
         or   a
         jr   z,itclltsk
         push hl
         pop  ix
         inc  hl              ;
         inc  hl              ;skip...
         inc  hl              ;...animation counters

         ld   b,(hl)          ;retrive x (b) and...
         inc  hl              ;
         ld   c,(hl)          ;...and y (c)

         ld   de,5            ;skip...
         add  hl,de           ;...movement parameter

         ld   e,(hl)          ;retrieve...
         inc  hl              ;...width and              
         ld   d,(hl)          ;...height of enemy
         push hl              ;
         ex   de,hl           ;
         ld   e,(hl)          ;e = height of enemy
         inc  hl              ; 
         ld   d,(hl)          ;d = width of enemy
         pop  hl              ;
         
         ld   a,(oldlasy)     ;test: is enemy in y range
         sub  c
         jr   c,itclltnr
         sub  e
         jr   nc,itclltnr
         
         ld   a,(curlaslen)
         inc  a
         ld   yh,a
         ld   a,(oldlasx)
         sub  yh
         sub  b
         jr   c,itclltnr
         sub  d
         jr   nc,itclltnr
         
         ld   a,(ix+0)
         cp   item_lantern_on
         call z,fried_lantern
         jr   z,itclltfn
         and  item_mask_drlev
         or   a
         jr   nz,itclltfn
         ld   a,(ix+0)
         xor   a                        ;patch to "dec a" to decrease strength
         ld   (ix+0),a
         jr   nz,itclltfn
         
         ld   a,(ix+2)
         push ix
         pop  hl
         ld   de,9
         add  hl,de
         sla  a
         ld   e,a
         add  hl,de
         ld   e,(hl)
         inc  hl
         ld   d,(hl)
         ex   de,hl
         ld   d,(hl)
         inc  hl
         ld   e,(hl)

         inc  c
         xor  a
         push bc
         push de
         call fillblock         
         pop  de  
         pop  bc
         
         dec  c
         ld   hl,pts50
         call placepoints
         
         ld   c,&50
         call addpoints
         ld   a,1
         ld   (updtscre),a                  
         jr   itclltfn           
itclltnr ld   de,11
         add  hl,de
         jr   itclltnx
         
itclltsk ld   de,itemrecsize
         add  hl,de
         
itclltnx pop  bc
         djnz itclltlj
         jr   itclltx2
itclltlj jp   itclltlp
         
itclltfn pop  bc
         pop  de
         pop  bc
         jr   walcollt 
itclltx2 pop  de
         pop  bc
         ;end test enemies
         
         dec  c                  ;do not increment, wall are twice thick
         bit  0,c
         jr   nz,dfloplt2
         dec  de
dfloplt2 ld   a,(de)
         bit  6,a
         jr   z,dflopltj
         xor  a
dflopltj djnz dfloplt3
         jr   walcollt
dfloplt3 jp   dflooplt
         
         ;laser length is set, so draw it
walcollt ld   a,laslength     ;a is laser length
         sub  b
         jr   z,lasln0
         ld   (oldlasln),a
         ld   d,a
         ld   e,1
         pop  bc
         ld   a,b
         sub  d
         ld   b,a
         ld   a,(lasbeam)
         xor  &ff
         ld   (lasbeam),a
         or   a
         jr   z,beam2lt
         ld   hl,laserb1
         call drawsprite        
         ret
beam2lt  ld   hl,laserb2
         call drawsprite         
         ret

         ;laser len is zero
lasln0   pop  bc
         ld   (oldlasln),a
         ret

         ;
         ;
         ;
         ;decrease wall strength right, and delete if necessary
decwalrt push af
         push bc
         ld   hl,(clvptrb1)
         ld   d,0
         ld   e,c
         srl  e             ;div 2
         add  hl,de
         
         dec  hl
         ld   a,(hl)
         or   a
         jr   nz,decwlrt2
         inc  hl
         inc  hl            ;wall width 2 blocks
         inc  hl
         ld   a,(hl)        ;test if wall can be shot
         or   a
         jr   nz,decwlrt2         
         dec  hl            ;ok, decrement wall strength      
         dec  hl
         ld   a,(hl)
         or   a
         jr   z,decwlrt2
         dec  (hl)
         
         ld   a,(hl)        ;delete wall?
         and  %00111111
         or   a             
         jr   nz,decwlrt2
         push bc
         ld   b,c
         ld   c,15+topoffset
         ld   de,&2602
         xor  a
         ld   (hl),a
         call fillblock
         ld   a,1
         ld   (dntvsync),a
         pop  bc                           
         
decwlrt2 ld   hl,(clvptrb2)
         ld   d,0
         ld   e,c
         srl  e             ;div 2
         add  hl,de
         
         dec  hl
         ld   a,(hl)
         or   a
         jr   nz,decwlrt3
         inc  hl
         inc  hl            ;wall width 2 blocks
         inc  hl
         ld   a,(hl)        ;test if wall can be shot
         or   a
         jr   nz,decwlrt3         
         dec  hl            ;ok, decrement wall strength      
         dec  hl         
         ld   a,(hl)
         or   a
         jr   z,decwlrt3         
         dec  (hl)

         ld   a,(hl)        ;delete wall?
         and  %00111111
         or   a
         jr   nz,decwlrt3
         push bc
         ld   b,c
         ld   c,15+topoffset+39
         ld   de,&2602
         xor  a
         ld   (hl),a
         call fillblock
         ld   a,1
         ld   (dntvsync),a
         pop  bc                           

decwlrt3 ld   hl,(clvptrb3)
         ld   d,0
         ld   e,c
         srl  e             ;div 2
         add  hl,de
         
         dec  hl
         ld   a,(hl)
         or   a
         jr   nz,decwlrt4
         inc  hl
         inc  hl            ;wall width 2 blocks
         inc  hl
         ld   a,(hl)        ;test if wall can be shot
         or   a
         jr   nz,decwlrt4         
         dec  hl            ;ok, decrement wall strength      
         dec  hl         
         ld   a,(hl)
         or   a
         jr   z,decwlrt4         
         dec  (hl)

         ld   a,(hl)        ;delete wall?
         and  %00111111
         or   a
         jr   nz,decwlrt4
         push bc
         ld   b,c
         ld   c,15+topoffset+39+39
         ld   de,&2602
         xor  a
         ld   (hl),a
         call fillblock
         ld   a,1
         ld   (dntvsync),a
         pop  bc                           

decwlrt4 pop  bc
         pop  af
         ret        

         ;
         ;
         ;
         ;decrease wall strength left, and delete if necessary
decwallt push af
         push bc
         ld   hl,(clvptrb1)
         ld   d,0
         ld   e,c
         srl  e             ;div 2
         add  hl,de
         
         ld   a,(hl)
         or   a
         jr   nz,decwllt2
         dec  hl
         dec  hl            ;wall width 2 blocks
         dec  hl
         ld   a,(hl)        ;test if wall can be shot
         or   a
         jr   nz,decwllt2         
         inc  hl            ;ok, decrement wall strength      
         inc  hl
         ld   a,(hl)
         or   a
         jr   z,decwllt2         
         dec  (hl)

         ld   a,(hl)        ;delete wall?
         and  %00111111
         or   a
         jr   nz,decwllt2
         push bc
         ld   b,c
         dec  b
         dec  b
         ld   c,15+topoffset
         ld   de,&2602
         xor  a
         ld   (hl),a
         call fillblock
         ld   a,1
         ld   (dntvsync),a
         pop  bc                           
         
decwllt2 ld   hl,(clvptrb2)
         ld   d,0
         ld   e,c
         srl  e             ;div 2
         add  hl,de
         
         ld   a,(hl)
         or   a
         jr   nz,decwllt3
         dec  hl
         dec  hl            ;wall width 2 blocks
         dec  hl
         ld   a,(hl)        ;test if wall can be shot
         or   a
         jr   nz,decwllt3         
         inc  hl            ;ok, decrement wall strength      
         inc  hl         
         ld   a,(hl)
         or   a
         jr   z,decwllt3         
         dec  (hl)

         ld   a,(hl)        ;delete wall?
         and  %00111111
         or   a
         jr   nz,decwllt3         
         push bc
         ld   b,c
         dec  b
         dec  b
         ld   c,15+topoffset+39
         ld   de,&2602
         xor  a
         ld   (hl),a
         call fillblock
         ld   a,1
         ld   (dntvsync),a
         pop  bc                           

decwllt3 ld   hl,(clvptrb3)
         ld   d,0
         ld   e,c
         srl  e             ;div 2
         add  hl,de
         
         ld   a,(hl)
         or   a
         jr   nz,decwllt4
         dec  hl
         dec  hl            ;wall width 2 blocks
         dec  hl
         ld   a,(hl)        ;test if wall can be shot
         or   a
         jr   nz,decwllt4         
         inc  hl            ;ok, decrement wall strength      
         inc  hl         
         ld   a,(hl)
         or   a
         jr   z,decwllt4         
         dec  (hl)

         ld   a,(hl)        ;delete wall?
         and  %00111111
         or   a
         jr   nz,decwllt4
         push bc
         ld   b,c
         dec  b
         dec  b
         ld   c,15+topoffset+39+39
         ld   de,&2602
         xor  a
         ld   (hl),a
         call fillblock
         ld   a,1
         ld   (dntvsync),a
         pop  bc                           

decwllt4 pop  bc
         pop  af
         ret        

fried_lantern
         ld   a,(lantcolp)
         push af
         xor  a
         ld   (lantcolp),a
         call lantern_collision
         pop  af
         ld   (lantcolp),a    
         ret

;laser gfx stuff
laslength  equ  11         ;double pixels -> 22 pixels

lasbeam  db   0           ;laser beam alternator -> beam
oldlasln db   0           ;stored laser length to erase old laser beam
oldlasx  db   0           ;stored laser x to erase old laser beam         
oldlasy  db   0           ;stored laser y to erase old laser beam         
oldlasdr db   0           ;old laser direction, z=rt, nz=lt
curlaslen db  0           ;current laser length -> enemy test

;laser beam sound stuff
lssndctri    equ 4        ;init value
lasersndintl equ 155
lasersndintr equ 154

;lasersndintl equ 163
;lasersndintr equ 162      ;130

lssndl   db   lasersndintl
lssndr   db   lasersndintr
lssndctr db   lssndctri   ;counter
                     
;-------------------------------------------------------------------------------
;ziiing
;"hero dies"-sound
ziiing
zngnonse call allsoundstop
         
         ld   c,mixer            
         ld   a,%00111000                  ;mixer all tone 
         call wrpsg
                  
zngenv   ld   c,envperiode_hi
         ld   a,13*3                       ;duration = approx. 3s
         call wrpsg

         ld   c,fineb
         ld   a,%10000000
         call wrpsg
         
         ld   c,channelb
         ld   a,soundfull or envelope_on
         call wrpsg         
         ld   c,envelope_shape
         ld   a,%0000                      ;envshape: \_____
         call wrpsg

         ld   b,30
zngsnd   push bc
         call zngwait
         ei
         halt
         halt
         di
         call zngwait
         ld   c,fineb   
         ld   a,%01000000
         call wrpsg
         ei
         halt
         halt
         di

         call zngwait
         ei
         halt
         halt
         di
         call zngwait
         ld   c,fineb  
         ld   a,%10000000
         call wrpsg         
         ei
         halt
         halt
         di
         pop  bc
         djnz zngsnd
         
         ;restore envelope duration and mixer
         ld   c,envperiode_hi
         ld   a,13                         ;duration = approx. 1s
         call wrpsg
         ld   c,mixer                      ;mixer a,b noise, c tone
         ld   a,mixer_default       
         call wrpsg         
         ret

zngwait  ld   b,&F5
         in   a,(c)                    
         rra  
         jr   nc,zngwait
         call flashwalls
         ret       
         
;-------------------------------------------------------------------------------
;drawenemies
;
drawenemies
         ld   a,(drwendly)
         dec  a
         or   a
         jr   z,amctrnul
         ld   (drwendly),a
         ld   a,1
         jr   drwnstrt
amctrnul ld   a,drwendlyinit         
         ld   (drwendly),a
         xor  a
drwnstrt ld   (anmpatch+1),a

         ld   hl,(clvptrb1)
         ld   bc,120+4+1
         add  hl,bc
         ld   b,items
drwenms  push bc
         ld   a,(hl)         
         inc  hl
         or   a
         jp   z,drwenms2
                  
         ld   b,a
         and  item_mask_drlev
         or   a                                  
         jp   nz,drwenms2

         ld   a,b
         and  enemy_mask_out
         cp   item_tentacle   ;tentacle moving patch                  
         jr   nz,notentcl
         ld   a,1
         jr   dotentcl
notentcl xor  a
dotentcl ld   (tntlptch+1),a
         ld   a,b
         and  enemy_mask_out
         cp   item_raft
         jr   nz,noraftmv
         ld   a,1
         jr   doraftmv
noraftmv xor  a
doraftmv ld   (raftmve+1),a

         inc  hl
         ld   a,(hl)                  
         ld   (drolda),a
         dec  hl
         
anmpatch ld   a,1
         or   a
         jr   z,itemfnd
         inc  hl
         ld   a,(hl)
         jr   drweinc3
         
itemfnd  ld   b,(hl)        ;counter max
         inc  hl
         ld   a,(hl)
         cp   b
         jr   z,drweinc1
         inc  a
         jr   drweinc2
drweinc1 xor  a
drweinc2 ld   (hl),a
drweinc3 inc  hl
         sla  a             ;a=a*2
         ld   (depatch+1),a  
                  
         ;fill coord
fillcord ld   a,1         
         ld   a,(hl)
         ld   b,a
         ld   (drwoldb),a
         inc  hl
         ld   a,(hl)
         ld   (drwoldc),a
         ld   c,a

         ;tentacle move
tntlptch ld   a,1
         or   a             ;z=no tentacle
         jr   z,raftmve
         ld   a,(tentldly)
         or   a
         jr   z,tntlmov
         dec  a
         ld   (tentldly),a
         jp   xmv
               
tntlmov  ld   a,drwtentldlyinit
         ld   (tentldly),a
         push hl
         dec  hl
         ld   a,(newherox)
         ld   b,(hl)
         inc  hl
         ld   c,(hl)
         dec  hl
         cp   b
         jr   z,outtentl
         jr   c,dectent                   ;herox<tentaclex

         ld   a,b
         ld   (svtentlb),a
         inc  b
         push bc
         inc  b
         inc  b
         inc  b
         call getstage
         pop  bc
         or   a
         jr   z,wrtentlx
         ld   a,(svtentlb)
         ld   b,a         
         jr   outtentl
         
dectent  ld   a,b
         ld   (svtentlb),a
         dec  b   
         push bc
         call getstage
         pop  bc
         or   a
         jr   z,wrtentlx
         ld   a,(svtentlb)
         ld   b,a         
         jr   outtentl

wrtentlx ld   (hl),b
         
outtentl pop  hl         
         
         ;raft move
raftmve  ld   a,1
         or   a
         jr   z,xmv
         ld   a,(heroonraft)
         or   a
         jr   z,outraft2
         push hl
         inc  hl
         ld   a,(hl)
         dec  hl
         
         dec  hl
         ld   b,(hl)
         inc  hl
         ld   c,(hl)
         dec  hl
         or   a
         jr   nz,decraftx
         
         ld   a,b
         ld   (svraftb),a
         inc  b
         push bc
         ld   a,b
         add  7           ;5=raft width + 2 hero
         ld   b,a
         call getstage
         pop  bc
         or   a
         jr   z,wrraftxi
         ld   a,(svraftb)
         ld   b,a         
         jr   outraft 

wrraftxi ld   a,(newherox)
         inc  a
         ld   (newherox),a         
         ld   (hl),b
         jr   outraft
         
decraftx ld   a,b
         ld   (svraftb),a
         dec  b   
         push bc
         dec  b
         dec  b
         dec  b
         call getstage
         pop  bc
         or   a
         jr   z,wrraftxd
         ld   a,(svraftb)
         ld   b,a         
         jr   outraft 

wrraftxd ld   a,(newherox)
         dec  a
         ld   (newherox),a         
         ld   (hl),b
         
outraft  pop  hl
outraft2 inc  hl
         inc  hl
         jr   noxmv
         
         ;x move
xmv      inc  hl
         ld   a,(hl)
         inc  hl
         or   a
         jr   z,noxmv
         ld   d,a      ;movement range -> d
         ld   a,(hl)   ;e current movement counter (bit 7 = direction)
         bit  7,a
         jr   z,xmvpos
         or   a
         jr   z,xmvpos
         res  7,a      
         dec  a
         dec  b
         or   a
         jr   z,xmv2
         set  7,a
         jr   xmv2     

xmvpos   inc  a
         inc  b       ;increment x
         cp   d
         jr   nz,xmv2         
         set  7,a
xmv2     ld   (hl),a

         ld   de,3     ;update x pos
         and  a
         sbc  hl,de  
         ld   (hl),b
         add  hl,de
                    
         inc  hl
         jr   ymv         

noxmv    inc  hl

         ;y move
ymv      ld   a,(hl)
         inc  hl
         or   a
         jr   z,noymv
         ld   d,a     ;movement range -> d
         ld   a,(hl)  ;e current movement counter (bit 7 = direction)
         bit  7,a
         jr   z,ymvpos
         or   a
         jr   z,ymvpos
         res  7,a
         dec  a
         dec  c
         or   a
         jr   z,ymv2
         set  7,a
         jr   ymv2
         
ymvpos   inc  a
         inc  c      ;increment y
         cp   d
         jr   nz,ymv2
         set  7,a
ymv2     ld   (hl),a

         ld   de,4   ;update y pos
         and  a
         sbc  hl,de
         ld   (hl),c
         add  hl,de
         
         inc  hl
         jr   deahead         

noymv    inc  hl         
deahead  push hl                         
depatch  ld   de,0

         push bc
         push de
         push hl
         
         ld   a,(drolda)         
         and  a
         sla  a
         ld   e,a
         ld   d,0
         add  hl,de
         
         ld   e,(hl)
         inc  hl
         ld   d,(hl)
         ex   de,hl         
         ld   d,(hl)
         inc  hl
         ld   e,(hl)
           
         ld   a,(drwoldb)
         ld   b,a
         ld   a,(drwoldc)
         ld   c,a
         inc  c
         xor  a
         call fillblock            

         pop  hl
         pop  de
         pop  bc

         add  hl,de
         ld   e,(hl)
         inc  hl
         ld   d,(hl)
         ex   de,hl         
         ld   e,(hl)
         inc  hl
         ld   d,(hl)
         inc  hl
         
         call drawsprite
                           
         pop  hl
         ld   de,12
         add  hl,de         
         jr   drwenms3
drwenms2 ld   de,itemrecsize-1
         add  hl,de             
drwenms3 pop  bc
         djnz drwjump
         ret      
drwjump  jp   drwenms
         
         
drwendlyinit    equ 3
drwtentldlyinit equ 1

drwendly db   drwendlyinit
drolda   db   0           ;old counter
drwoldb  db   0
drwoldc  db   0         
svtentlb db   0
svraftb  db   0
tentldly db   drwtentldlyinit

;-------------------------------------------------------------------------------
;
drawtitlescreen
         ld   bc,1
         ld   d,201
         ld   e,80
         xor  a
         call fillblock
                  
         ld   b,0
         ld   c,topoffset+19
         ld   d,34
         ld   e,159
         ld   hl,herotit
         call drawsprite

         ld   b,28
         ld   c,topoffset+39         
         ld   d,41
         ld   e,7
         ld   hl,jvr
         call drawsprite
         
         ld   b,28
         ld   c,topoffset+54
         ld   d,43
         ld   e,42 
         ld   hl,herologo
         call drawsprite

         ld   b,35
         ld   c,topoffset+110        
         ld   d,27
         ld   e,8
         ld   hl,prsfire
         call drawsprite

         ld  a,(scrswp1+1)
         ld  (titlepage),a
         ret

titlepage db 0
         
;-------------------------------------------------------------------------------
;adddecimal
;in:hl=pointer to last digit, b=digits, c=number to add 
;out:-
;corrupted regs: af, b, de, hl
;
adddecimal
         ld   a,c
                  
adddlop  ld   d,a
         and  %00001111
         add  (hl)
         daa
         ld   e,a
         and  %00001111
         ld   (hl),a
         dec  hl
         ld   a,e
         srl  a
         srl  a
         srl  a
         srl  a
         ld   e,a
         ld   a,d
         srl  a
         srl  a
         srl  a
         srl  a
         add  e
         daa
         djnz adddlop
         ret

;-------------------------------------------------------------------------------
;addpoints
;in:c points
;out:-
;corrupted regs: af, b, de, hl
;
addpoints
         ld   hl,score+5
         ld   b,6
         call adddecimal

         ;add life?
         ld   a,(old5val)
         ld   b,a
         ld   a,(score+1)
         cp   b
         ret  z
         ld   (old5val),a
         ld   a,(addlifec)
         cp   1
         jr   z,addlife
         inc  a
         ld  (addlifec),a
         ret
addlife  ld   a,(lifes)         
         cp   6
         ret  z
         inc  a
         ld   (lifes),a
         call drawlifes
         xor  a
         ld   (addlifec),a
         ret

addlifec db   0         ;add life counter 
old5val  db   0
         
;-------------------------------------------------------------------------------
;calclevelnr
;
addlevelnr
         ld   hl,levnumbr
         inc  (hl)         
         ld   hl,level+1
         ld   bc,&0201
         jr   adddecimal

;-------------------------------------------------------------------------------
;drawbomb
;in/out:-
;corrupted regs: all
;
drawbomb
         ld   a,(bombset)
         cp   0
         ret  z

         ld   a,(bombset)
         cp   1
         jp   nz,drb
         
         ld   a,(boumctr)
         cp   0
         jp   z,bmend
         cp   boumdlyinit
         jr   nz,bumanm2

         ld   hl,bombx
         dec  (hl)
         ld   hl,bomby
         dec  (hl)
         dec  (hl)
         ld   c,noise                ;boum anim 1

         ld   a,%11111
         call wrpsg
         ld   c,channelb
         ld   a,soundfull or envelope_on
         call wrpsg         
         ld   c,envelope_shape
         ld   a,%0000                ;envshape: \_____
         call wrpsg
         call setbackclrswap
         call deletewalls

         ld   a,(bombx)       ;test: is bomb in x range
         ld   b,a
         ld   a,(newherox)    
         sub  b               ;bomb x
         jr   c,bmtstxc1
         sub  4               ;case 2: hero > enemy --> test enemy width
         jr   bmtstxc2                  
bmtstxc1 cpl                  ;case 1: hero < enemy --> test hero width
         sub  3               ;&14-&18 =-4 -> "cpl ! inc 1" or "sub herowidth-1"
bmtstxc2 jr   nc,bmtstnoc

         ld   a,(bomby)       ;test: is bomb in y range
         ld   c,a
         ld   a,(newheroy)    
         sub  c
         jr   c,bmtstyc1
         sub  11
         jr   bmtstyc2
bmtstyc1 cpl
         sub  23              ;heroheight -1 = 24-1 = 23         
bmtstyc2 jr   nc,bmtstnoc
         ld   a,(heroclsn)
         set  col_flag_bomb,a
         ld   (heroclsn),a         
                          
bmtstnoc ld   hl,bombs
         dec  (hl)                   ;decrement bomb -> nop to cheat
         call drawbombs
         call setlevelcolour
         ld   hl,boum1
         jr   boumanim
                      
bumanm2  cp   boumdlyinit-1
         jr   nz,bumanm3         
         call setbackclrswap
         ld   hl,boum2
         jr   boumanim
         
bumanm3  cp   boumdlyinit-2
         jr   nz,boumanm4
         call setbackclrswap
         ld   hl,boum3
         jr   boumanim
                                        
boumanm4 cp   boumdlyinit-3
         jr   nz,boumanm5
         call setbackclrswap
         ld   hl,boum4
         jr   boumanim
         
boumanm5 cp   boumdlyinit-4
         jr   nz,boumgo
         xor  a
         ld   (backclr),a
         call setbackclr    
         ld   a,(bombx)
         ld   b,a
         ld   a,(bomby)
         add  3
         ld   c,a
         ld   de,&0b04
         
         ld   hl,bombscrn         ;curscreen?
         ld   a,(curscrn)
         cp   (hl)
         jr   nz,boumgo
         
         xor  a
         call fillblock

         ld   a,(dltwals)
         or   a
         jr   z,boumgo
         
         ld   a,(bombx)
         ld   b,a
         ld   a,(bomby)
         ld   c,a
         ld   hl,pts75
         call placepoints            
         jr   boumgo         

boumanim ld   de,&040b
         ld   a,(bombx)
         ld   b,a
         ld   a,(bomby)
         add  2
         ld   c,a

         push hl
         ld   hl,bombscrn         ;curscreen?
         ld   a,(curscrn)
         cp   (hl)
         pop  hl
         jr   nz,boumgo

         call drawsprite
boumgo   ld   a,(boumctr)
         dec  a
         ld   (boumctr),a
         ret
          
bmend    ld   c,channelb    ;volume b, pssst!!!
         ld   a,soundpst
         call wrpsg
         ld   a,bmbsndinit
         ld   (bombsnd),a   ;reset bomb values
         ld   a,boumdlyinit
         ld   (boumctr),a
         xor  a
         ld   (bombset),a
         ret                  

drb      dec  a
         ld  (bombset),a
         
         ld   hl,(clvptrb1)
         dec  hl
         ld   a,(hl)
         cp   20
         jr   nz,dbnocrcg
         ld   bc,&7f0f
         out  (c),c
         ld   a,0 or %01000000
         out  (c),a         

dbnocrcg ld   a,(bombanm)
         inc  a
         cp   3
         jr   nz,drbmgo
         ld   a,0         
drbmgo   ld   (bombanm),a
         cp   0
         jr   nz,drb1
         ld   hl,bomb1
         jr   drb3
drb1     cp   1
         jr   nz,drb2
         ld   hl,bomb2
         jr   drb3
drb2     ld   hl,bomb3
drb3     ld   de,&020b
         ld   a,(bombx)
         ld   b,a
         ld   a,(bomby)
         ld   c,a
         push hl
         ld   hl,bombscrn      ;curscreen?
         ld   a,(curscrn)
         cp   (hl)
         pop  hl
         jr   nz,drb4
         call drawsprite
drb4     ld   c,noise
         ld   a,(bombsnd)
         ld   hl,bombset
         add  (hl)
         xor  &ff             ;xor  %00101         
         and  %00111
         ld   (bombsnd),a
         call wrpsg
         
         ld   c,channelb
         ld   a,soundfull
         call wrpsg  
         
         ret

setbackclrswap
         ld   a,(backclr)
         xor  1
         ld   (backclr),a
setbackclr
         ld   bc,&7f00
         out  (c),c         
         ld   a,(backclr)
         or   a
         jr   z,sbcblack                  
         ld   a,%01001011
         out  (c),a
         ret
sbcblack ld   a,%01010100
         out  (c),a
         ret                 
                   
bmbsndinit   equ  2     ;3                                                          
bombdly      equ  15    ;21
boumdlyinit  equ  11    ;knapp bei shape cutoff

bombsnd  db   bmbsndinit
boumctr  db   boumdlyinit
bombset  db   0         ;0=not set, >0=counter
bombscrn db   0         ;bomb set in screen
bombx    db   0
bomby    db   0
bombanm  db   0         ;0-3
backclr  db   0
         
;-------------------------------------------------------------------------------
;deletewalls
;
deletewalls
         ;calculate x
         ld   a,(bombx)
         srl  a             ;div 2
         ld   (bombxdw),a
         ld   e,a
         ld   a,0
         ld   (dltwals),a
         ld   a,e
         ld   d,0
         
         ;           
         ;stage 0
         ;  
dwst0    ld   hl,(dlwptrb1)  
         add  hl,de
         
         ;delete walls left  
         ld   b,0
         push hl
         ld   a,(hl)
         or   a
         jr   nz,dw0rt
                  
         dec  hl
         ld   a,(hl)
         or   a
         jr   nz,dw04ptcl
         ld   a,6
         ld   (dwst0ptl+1),a
         jr   dw0_2lt
dw04ptcl ld   a,4
         ld   (dwst0ptl+1),a
         jr   dw0_1lt         
         
dw0_2lt  dec  hl
dw0_1lt  dec  hl         
         dec  hl
         ld   a,(hl)
         or   a
         jr   nz,dw0rt
         inc  hl
         ld   a,(hl)
         or   a
         jr   z,dwst01
         inc  b
         ld   (hl),0
dwst01   inc  hl
         ld   a,(hl)
         or   a
         jr   z,dwst02
         inc  b
         ld   (hl),0
dwst02   ld   a,b
         or   a
         jr   z,dw0rt
         ld   a,(bombxdw)
         and  a
         rl   a
dwst0ptl sub  4
         ld   b,a
         ld   c,15+topoffset
         ld   de,&2604
         xor  a
         call fillblock                           
         ld   hl,dltwals
         inc  (hl)
         
         ;delete walls right
dw0rt    pop  hl
         ld   b,0
         inc  hl
         ld   a,(hl)         
         or   a
         jr   nz,dwst1

         inc  hl
         ld   a,(hl)
         or   a
         jr   nz,dw04ptch
         ld   a,6
         ld   (dwst0ptc+1),a
         jr   dw0_2rt
dw04ptch ld   a,4
         ld   (dwst0ptc+1),a
         jr   dw0_1rt         
         
dw0_2rt  inc  hl
dw0_1rt  inc  hl
         inc  hl
         ld   a,(hl)
         or   a
         jr   nz,dwst1
         dec  hl
         ld   a,(hl)
         or   a
         jr   z,dwst03
         inc  b
         ld   (hl),0
dwst03   dec  hl
         ld   a,(hl)
         or   a
         jr   z,dwst04
         inc  b
         ld   (hl),0         
dwst04   ld   a,b
         or   a
         jr   z,dwst1
         ld   a,(bombxdw)
         and  a
         rl   a
dwst0ptc add  4
         ld   b,a
         ld   c,15+topoffset
         ld   de,&2604
         xor  a
         call fillblock
         ld   hl,dltwals
         inc  (hl)

         ;
         ;stage 1
         ;                           
dwst1    ld   hl,(dlwptrb2)
         ld   a,(bombxdw)  
         ld   e,a       
         ld   d,0
         add  hl,de
         
         ;delete walls left
         ld   b,0  
         push hl
         ld   a,(hl)
         or   a
         jr   nz,dw1rt
         dec  hl
         ld   a,(hl)
         or   a
         jr   nz,dw14ptcl
         ld   a,6
         ld   (dwst1ptl+1),a
         jr   dw1_2lt
dw14ptcl ld   a,4
         ld   (dwst1ptl+1),a
         jr   dw1_1lt         
         
dw1_2lt  dec  hl
dw1_1lt  dec  hl         
         dec  hl
         ld   a,(hl)
         or   a
         jr   nz,dw1rt
         inc  hl
         ld   a,(hl)
         or   a
         jr   z,dwst11
         inc  b
         ld   (hl),0
dwst11   inc  hl
         ld   a,(hl)
         or   a
         jr   z,dwst12
         inc  b         
         ld   (hl),0
dwst12   ld   a,b
         or   a
         jr   z,dw1rt
         ld   a,(bombxdw)
         and  a
         rl   a
dwst1ptl sub  4
         ld   b,a
         ld   c,15+topoffset+39
         ld   de,&2604
         xor  a
         call fillblock
         ld   hl,dltwals
         inc  (hl)
                                             
         ;delete walls right
dw1rt    pop  hl
         ld   b,0
         inc  hl
         ld   a,(hl)
         or   a
         jr   nz,dwst2

         inc  hl
         ld   a,(hl)
         or   a
         jr   nz,dw14ptch
         ld   a,6
         ld   (dwst1ptc+1),a
         jr   dw1_2rt
dw14ptch ld   a,4
         ld   (dwst1ptc+1),a
         jr   dw1_1rt         
         
dw1_2rt  inc  hl
dw1_1rt  inc  hl
         inc  hl
         ld   a,(hl)
         or   a
         jr   nz,dwst2
         dec  hl
         ld   a,(hl)
         or   a
         jr   z,dwst13
         inc  b
         ld   (hl),0
dwst13   dec  hl
         ld   a,(hl)
         or   a
         jr   z,dwst14
         inc  b         
         ld   (hl),0
dwst14   ld   a,b
         or   a
         jr   z,dwst2
         ld   a,(bombxdw)
         and  a
         rl   a
dwst1ptc add  4
         ld   b,a
         ld   c,15+topoffset+39
         ld   de,&2604
         xor  a
         call fillblock
         ld   hl,dltwals
         inc  (hl)
         
         ;                                             
         ;stage 2
         ;           
dwst2    ld   hl,(dlwptrb3)
         ld   a,(bombxdw)  
         ld   e,a       
         ld   d,0
         add  hl,de
         
         ;delete walls left
         ld   b,0  
         push hl
         ld   a,(hl)
         or   a
         jr   nz,dw2rt
         dec  hl
         ld   a,(hl)
         or   a
         jr   nz,dw24ptcl
         ld   a,6
         ld   (dwst2ptl+1),a
         jr   dw2_2lt
dw24ptcl ld   a,4
         ld   (dwst2ptl+1),a
         jr   dw2_1lt         
         
dw2_2lt  dec  hl
dw2_1lt  dec  hl         
         dec  hl
         ld   a,(hl)
         or   a
         jr   nz,dw2rt
         inc  hl
         ld   a,(hl)
         or   a
         jr   z,dwst21
         inc  b
         ld   (hl),0
dwst21   inc  hl
         ld   a,(hl)
         or   a
         jr   z,dwst22
         inc  b
         ld   (hl),0
dwst22   ld   a,b
         or   a
         jr   z,dw2rt
         ld   a,(bombxdw)
         and  a
         rl   a
dwst2ptl sub  4
         ld   b,a
         ld   c,15+topoffset+39+39
         ld   de,&2604
         xor  a
         call fillblock
         ld   hl,dltwals
         inc  (hl)
                                             
         ;delete walls right
dw2rt    pop  hl
         ld   b,0
         inc  hl
         ld   a,(hl)
         or   a
         jr   nz,dwadpnt

         inc  hl
         ld   a,(hl)
         or   a
         jr   nz,dw24ptch
         ld   a,6
         ld   (dwst2ptc+1),a
         jr   dw2_2rt
dw24ptch ld   a,4
         ld   (dwst2ptc+1),a
         jr   dw2_1rt         
         
dw2_2rt  inc  hl
dw2_1rt  inc  hl
         inc  hl
         ld   a,(hl)
         or   a
         jr   nz,dwadpnt
         dec  hl
         ld   a,(hl)
         or   a
         jr   z,dwst23
         inc  b
         ld   (hl),0
dwst23   dec  hl
         ld   a,(hl)
         or   a
         jr   z,dwst24
         inc  b
         ld   (hl),0
dwst24   ld   a,b
         or   a
         ret  z
         ld   a,(bombxdw)
         and  a
         rl   a
dwst2ptc add  4
         ld   b,a
         ld   c,15+topoffset+39+39
         ld   de,&2604
         xor  a
         call fillblock
         ld   hl,dltwals
         inc  (hl)                                             
         
         ;add points, if a wall was deleted
dwadpnt  ld   a,(dltwals)
         or   a
         ret  z
         ld   c,&75
         call addpoints
         call drawscore
         ret
           
bombxdw  db   0
dltwals  db   0
dlwptrb1 dw   0
dlwptrb2 dw   0 
dlwptrb3 dw   0

;-------------------------------------------------------------------------------
;setupcrtc
;
setupcrtc
         ld   d,0
         ld   hl,crtc   

scrtlp   ld   b,&bc
         out  (c),d
         ld   b,&bd
         ld   a,(hl)
         out  (c),a
         inc  hl
         inc  d
         ld   a,d
         cp   14
         jr   nz,scrtlp
         
         ret

crtc     db   &3f,&28,&2e,&8e,&28,&06,&16,&1e,&00,&07,&00,&00,&30,&78

;-------------------------------------------------------------------------------
;setupytab
;
setupytab
         ld   hl,ytab
         ld   c,0

sytlop1  push bc
         push hl
         ld   a,c          ;8er-rasterzeile in h addieren
         and  7
         jr   z,syt2
         ld   b,a
         xor  a  
sytshft1 add  8
         djnz sytshft1
syt2     ld   h,a

         ld   a,c          ;1er-rasterzeile in l,h addieren
         srl  a            ;a=a div 8
         srl  a
         srl  a
         jr   z,sytmsksc
         ld   b,a
         xor  a
sytshft2 add  80         
         jr   c,inchsyt
         djnz sytshft2
         jr   sytmsksc               
inchsyt  inc  h
         djnz sytshft2

sytmsksc ld   l,a          ;hl=screen pos
         ld   a,h
         and  &3f
         ld   h,a         
         
         ex   de,hl
         pop  hl
         ld   (hl),e
         inc  hl
         ld   (hl),d
         inc  hl         
         pop  bc
         inc  c
         ld   a,c
         cp   255
         ret  z
         jr   sytlop1
         
         ret
                                                                                    
;-------------------------------------------------------------------------------
;swapscroutput
;
swapscroutput
         ld  a,(scrswp1+1)
         cp  &c0
         jr  nz,scoswap1
         ld  a,&80
         jr  scoswap2         
scoswap1 ld  a,&c0
scoswap2 ld  (scrswp1+1),a
         ld  (scrswp2+1),a
         ld  (scrswp3+1),a
         ld  (scrswp4+1),a
         ld  (scrswp5+1),a
         ld  (scrswp6+1),a
         ld  (scrswp7+1),a
         ld  (scrswp8+1),a
         ret
                   
;-------------------------------------------------------------------------------
;swapscreen
;
swapscreen
         ld  a,(scrswp1+1)
         cp  &c0
         jr  nz,ssswap1
         ld  a,&30
         jr  ssswap2
ssswap1  ld  a,&20 
ssswap2  ld  bc,&bc0c
         out (c),c
         ld  bc,&bd00
         out (c),a
         ret        
 
;-------------------------------------------------------------------------------
;setuplevel
;
initialwallstrength equ %00111111
bottomwater         equ %01000000
flashingwall        equ %10000000
  
setuplevel
         xor  a                      ;current screen is 0 (top of level)
         ld   (curscrn),a
         
         ld   hl,(pnextlev)
         ld   (pcurlev),hl
                 
         ld   de,curlevel            ;set working pointer
         inc  de
         ld   (clvptrb1),de          ;set current screen pointer
         dec  de         
         ld   a,(hl)                 ;copy current level number...
         ld   (curlvnbr),a           ;...in memory
         inc  hl
         ld   b,(hl)                 ;screens in level
         inc  hl
         
slrep4   push bc

         push hl        
         push de
         ;init crushcode?
         ld   de,17
         add  hl,de
         ld   a,(hl)
         and  wall_mask_crush
         or   a
         jr   z,nocrushi
         ld   a,%10000000     ;crushflag
         jr   chkflwls
nocrushi ld   a,0
chkflwls ld   (crshptch+1),a
         ;flashing walls?
         ld   a,(hl)
         and  wall_mask_flash
         or   a
         jr   z,slptchno
         ld   a,initialwallstrength or flashingwall
         jr   slptchgo
slptchno ld   a,initialwallstrength 
slptchgo ld   (slptchfw+1),a
         ;water bottom
         ld   a,(hl)
         and  item_bottm_water
         or   a
         jr   z,slptc2no
         ld   a,0 or bottomwater                 
         jr   slptc2go
slptc2no ld   a,0 
slptc2go ld   (slptchbw+1),a
         ;setup level colour
         ld   hl,levelcolourtab
         ld   a,(levelcoltabptr)
         ld   e,a
         ld   d,0

         push hl                    ;patch water colour
         ld   hl,watercolourtab
         add  hl,de
         ld   a,(hl)
         ld   (d3blkwt2+1),a
         pop  hl
         
         add  hl,de         
         pop  de
         ld   a,(hl)
         ld   (de),a
         inc  de
         pop  hl
         
         ;prepare new level
         ld   b,3                    ;3 block lines
slrep3   ld   yl,b
         push bc
         ld   b,5                    ;5 bytes -> 1 block line 
slrep2   push bc
         ld   b,8
         ld   a,(hl)
slrep1   rlc  a
         jr   nc,slnocry  
         push af
         ld   a,yl
         cp   2
         jr   nz,slsetbtb
         pop  af
slptchfw ld   c,initialwallstrength     ;stage 2
         jr   slsetbyt         
slsetbtb pop  af   
         ld   c,initialwallstrength     ;stage 1
         jr   slsetbyt         

slnocry  push af
         ld   a,yl
         cp   1
         jr   nz,slnocry2
slptchbw ld   c,0                       ;stage 3
         jr   slsetbt2                  
slnocry2 ld   c,0
slsetbt2 pop  af
slsetbyt push af
         ld   a,c
         ld   (de),a
         inc  de
         pop  af
         djnz slrep1
         pop  bc
         inc  hl
         djnz slrep2
         pop  bc
         djnz slrep3

         ;direction bytes
         ld   b,2
cpdirdat ld   a,(hl)
         and  %11110000
         srl  a
         srl  a
         srl  a
         srl  a
         inc  a
crshptch or   %00000000      ;patch crush code
         ld   (de),a
         inc  de
         ld   a,(hl)
         and  %00001111
         inc  a
         ld   (de),a
         inc  de
         inc  hl
         djnz cpdirdat
         
         ;crush position
         xor  a
         ld   (de),a
         inc  de

         ld   b,items
slsetitm push bc                  
         ld   a,(hl)
         and  item_mask_out
         inc  hl
         ld   (de),a
         inc  de
         cp   item_lantern_on
         jr   z,setuplantern
         cp   item_spider
         jr   z,setupspider
         cp   item_moth
         jr   z,setupmoth
         cp   item_bat
         jr   z,setupbat
         cp   item_miner_rt
         jr   z,setupminerright
         cp   item_miner_lt
         jr   z,setupminerleft
         cp   item_snake
         jr   z,setupsnake
         cp   item_raft
         jr   z,setupraft
         cp   item_tentacle
         jr   z,setuptentacle
         
         ;
         ;setup other stuff here
         ;
         push hl
         xor  a
         ld   (de),a         
         push de
         pop  hl
         inc  de
         ld   bc,itemrecsize-2
         ldir         
         pop  hl

slnext   pop  bc
         djnz slsetitm
         
         pop  bc
         djnz slrept
         jr   slgah
slrept   jp   slrep4

slgah    ld   (pnextlev),hl    
         ld   hl,(clvptrb1)
         ld   de,40
         add  hl,de
         ld   (clvptrb2),hl
         add  hl,de
         ld   (clvptrb3),hl
                  
         ret        

         ;
         ;setup items
         ;
setuplantern
         ld   ix,extract_item_lantern
         jr   setupitem
         
setupspider
         ld   ix,extract_item_spider
         jr   setupitem

setupmoth
         ld   ix,extract_item_moth
         jr   setupitem

setupbat
         ld   ix,extract_item_bat
         jr   setupitem

setupsnake
         ld   ix,extract_item_snake
         jr   setupitem 

setupraft
         ld   ix,extract_item_raft
         jr   setupitem

setuptentacle
         ld   ix,extract_item_tenctacle
         jr   setupitem
         
setupminerright
         ld   ix,extract_item_miner_right
         jr   setupitem

setupminerleft
         ld   ix,extract_item_miner_left
         jr   setupitem

setupitem
         push hl
         push ix
         pop  hl         
         ld   bc,1
         ldir
         xor  a
         ld   (de),a                ;clear counter space
         inc  de                    ;
         pop  hl

         ld   bc,2                  ;retrieve x/y pos
         ldir
         
         ld   a,(hl)                ;extract x/y movement range
         and  %11110000
         srl  a
         srl  a
         srl  a
         srl  a
         ld   (de),a
         inc  de
         xor  a
         ld   (de),a
         inc  de
         ld   a,(hl)
         and  %00001111
         ld   (de),a
         inc  de
         xor  a
         ld   (de),a
         inc  de
         inc  hl
                  
         push hl
         push ix
         pop  hl
         inc  hl
         ld   bc,6*2      ;garbage would be copied too,
         ldir                                              
         pop  hl
         jp   slnext

curlvnbr db   0                      ;current level number -> scoring
curscrn  db   0                      ;current screen
clvptrb1 dw   0                      ;pointer to memory of current screen stage 1
clvptrb2 dw   0                      ;pointer to memory of current screen stage 2
clvptrb3 dw   0                      ;pointer to memory of current screen stage 3
pnextlev dw   0                      ;pointer to next level
pcurlev  dw   0                      ;pointer to current level

;-------------------------------------------------------------------------------
;drawlevel
;
drawlevel
         ;
         ;first stage
         ;
         ld   b,38
dl1blk2  push bc
         ld   a,b
         add  13+topoffset
         sla  a  
         ld   e,a
         ld   a,0
         adc  0
         ld   d,a
         ld   hl,ytab
         add  hl,de
         ld   e,(hl)
         inc  hl
         ld   a,(hl)
scrswp1  or   &c0
         ld   d,a
         ld   hl,(clvptrb1)
         
         ld   b,40
dl1blk1  ld   a,(hl)
         or   a
         inc  hl
         jr   nz,dlblkblk
         ld   (de),a
         inc  de
         ld   (de),a
         inc  de
         jr   dl1blklp
dlblkblk ld   a,%11111111
dlblkmov ld   (de),a
         inc  de
         ld   (de),a
         inc  de                  
dl1blklp djnz dl1blk1
         pop  bc
         djnz dl1blk2
         
         ;
         ;second stage
         ;
         ld   b,38
dl2blk2  push bc
         ld   a,b
         add  52+topoffset  
         sla  a  
         ld   e,a
         ld   a,0
         adc  0
         ld   d,a
         ld   hl,ytab
         add  hl,de
         ld   e,(hl)
         inc  hl
         ld   a,(hl)
scrswp2  or   &c0
         ld   d,a
         ld   hl,(clvptrb2)
         
         ld   b,40
dl2blk1  ld   a,(hl)
         or   a
         inc  hl
         jr   nz,dl2blkcl
         ld   (de),a
         inc  de
         ld   (de),a
         inc  de
         jr   dl2blklp
dl2blkcl bit  7,a
         jr   z,d2blkblk
         ld   a,%00111111         
         jr   d2blkmov
d2blkblk ld   a,%11111111
d2blkmov ld   (de),a
         inc  de
         ld   (de),a
         inc  de                  
dl2blklp djnz dl2blk1
         pop  bc
         djnz dl2blk2

         ;
         ;third stage
         ;
         ld   b,38
dl3blk2  push bc
         ld   a,b
         ld   (dlvs3y),a
         add  91+topoffset  
         sla  a  
         ld   e,a
         ld   a,0
         adc  0
         ld   d,a
         ld   hl,ytab
         add  hl,de
         ld   e,(hl)
         inc  hl
         ld   a,(hl)
scrswp3  or   &c0
         ld   d,a
         ld   hl,(clvptrb3)
         
         ld   b,40
dl3blk1  ld   a,(hl)
         or   a
         inc  hl
         jr   nz,dl3blkcl
         ld   (de),a
         inc  de
         ld   (de),a
         inc  de
         jr   dl3blklp
dl3blkcl bit  6,a
         jr   z,d3blkblk
         ld   a,(dlvs3y)
         cp   36
         jr   nc,d3blkwt2
         xor  a
         jr   d3blkmov
d3blkwt2 ld   a,%11110000
         jr   d3blkmov         
d3blkblk ld   a,%11111111
d3blkmov ld   (de),a
         inc  de
         ld   (de),a
         inc  de                  
dl3blklp djnz dl3blk1
         pop  bc
         djnz dl3blk2

         ;
         ;draw two line
         ;
         ld   b,0
         ld   c,53+topoffset
         ld   de,&0150
         xor  a
         call fillblock
         ld   b,0
         ld   c,92+topoffset
         ld   de,&0150
         xor  a
         call fillblock

         ;
         ;erase laser beam
         ;
         xor  a
         ld   (oldlasln),a

         ;
         ;erase points on screen
         ;
         ld   (plcpntct),a                  
         ld   (plcpntc2),a         
         ;
         ;draw items
         ;
         ld   hl,(clvptrb1)
         ld   bc,120+4+1
         add  hl,bc
         ld   b,items
drwitems push bc
         ld   a,(hl)         
         inc  hl
         and  item_mask_drlev
         or   a
         jr   z,drwitms2
         inc  hl        ;skip animation counter
         inc  hl
         ld   b,(hl)
         inc  hl
         ld   c,(hl)
         inc  hl

         ld   de,4      ;skip x/y-movements
         add  hl,de

         ld   e,(hl)
         inc  hl
         ld   d,(hl)
         inc  hl
         
         push hl
         ex   de,hl
         ld   e,(hl)
         inc  hl
         ld   d,(hl)
         inc  hl         
         call drawsprite
         pop  hl
         ld   de,5*2
         add  hl,de
         jr   drwitms3
drwitms2 ld   de,itemrecsize-1
         add  hl,de             
drwitms3 pop  bc
         djnz drwitems
         call drawenemies
         ret

dlvypos  db   15+topoffset,54+topoffset,93+topoffset        
dlvs3y   db   0
                                                                           
;-------------------------------------------------------------------------------
;set level colour
;
setlevelcolour
         ld   bc,&7f0f
         out  (c),c
         push hl         
         ld   hl,(clvptrb1)
         dec  hl
         ld   a,(hl)
         pop  hl
         or   %01000000
         out  (c),a
         ret              

;-------------------------------------------------------------------------------
;fill energy
;
fillenergy  
         ld   a,(newlevl)         
         cp   0
         jp   z,heroset5
                            
herostnr call showlevel

         ;hero falls down in start level
         ld   a,1
heroset  push af
         push af
         call waitvsync
         call flashwalls
         pop  af
         ld   (newheroy),a
         cp   1
         jr   z,heroset3
         ld   c,a
         ld   a,(newherox)
         ld   b,a
         xor  a
         ld   de,&1804
         call fillblock
heroset3 call drawhero
         pop  af
         inc  a
         cp   25
         jr   nz,heroset
         
         ld   c,channelb    ;volume b, pssst!!!
         ld   a,soundfull
         call wrpsg
         
         ld   a,1           ;fill up energy 0-40
fn1      ld   (energy),a
         push af                       
         rra
         cpl
         ld   c,6       
         call wrpsg
         call drawenergy
         call waitvsync
         call flashwalls         
         
         ld   a,(newheroy)
         inc  a
         ld   (newheroy),a
         jr   z,heroset4
         ld   c,a
         ld   a,(newherox)
         ld   b,a   
         xor  a
         ld   de,&1804         
         call fillblock
heroset4 call drawhero
         pop  af         
         inc  a
         cp   41
         jr   nz,fn1
                  
         ld   c,channelb    ;volume b, pssst!!!
         ld   a,soundpst
         call wrpsg
         
         call clearlevel
         call drawscore 

heroset5 ld   a,herodlymiddle
         ld   (houpdly),a
         ld   a,1
         ld   (herofly),a        ;hero is flying

         call waitvsync

         ld   a,(newherox)
         ld   b,a         
         ld   a,(newheroy)
         ld   c,a
         inc  c
         ld   de,&0104
         xor  a
         call fillblock
         call drawhero
         call readjoystick
         call flashwalls
         ld   a,(joybyte)
         and  %00001111
         jr   nz,heroset7
         ld   a,(escbyte)
         bit  2,a
         ;call nz,giveupquestion
         jr   z,heroset5        ;delete...
         ld   (wimp),a          ;..this if question mem left
         ld   a,(wimp)
         or   a
         jr   z,heroset5
         jr   clearherobackground
                  
heroset7 ld   c,channelb    ;volume b, 100 % vol
         ld   a,soundfull
         call wrpsg
         
         ld   a,&00         ;patch make roto sound
         ld   (makerotosound),a
         
clearherobackground
         ld   b,&04*&18
         ld   hl,heroback
clrhebck ld   (hl),0
         inc  hl
         djnz clrhebck
         
         ret
                  
;-------------------------------------------------------------------------------
;setscreen
;
setscreen
         push bc
         push de
         push hl
         push ix
         push iy
         call herosilence
         call acsoundstop
         
         ld   hl,(clvptrb1)   ;+patch  
stscptch ld   e,120                              
         ld   d,0
         add  hl,de
         
         ld   a,(hl)
         dec  a
         and  %00011111                          ;1-16, bit 5-7 could be flags
         ld   (curscrn),a

         ld   hl,curlevel
         inc  hl
         or   a
         jr   z,stscrn2
         ld   b,a         
         ld   de,1+120+4+1+(itemperlevel)     ;4=direction bytes,+1=crushcntr 
stscrn   add  hl,de
         djnz stscrn
stscrn2  ld   (clvptrb1),hl         
         ld   de,40
         add  hl,de
         ld   (clvptrb2),hl
         add  hl,de
         ld   (clvptrb3),hl
         call swapscroutput
         call drawlevel
         call drawenergy
         call drawlifes
         call drawscore
         call drawbombs
         ld   a,(newherox)
         ld   (herox),a
         ld   b,a
         ld   a,(newheroy)
         ld   (heroy),a
         ld   c,a         

         ld   de,&0418
         ld   hl,heroback
         call savebackground

         call drawhero
         call swapscreen
         call waitvsync
         ei
         halt
         di
         call setlevelcolour                  
         pop  iy
         pop  ix
         pop  hl
         pop  de
         pop  bc
         ret

;-------------------------------------------------------------------------------
;upscreen
;
lowernextscreen equ 137-10

upscreen
         push af
         ld   a,(curscrn)
         or   a
         jr   z,upscrny1
         ld   a,120           ;up   
         ld   (stscptch+1),a
         ld   a,lowernextscreen
         ld   (newheroy),a         
         call setscreen
upscrnpp pop  af
         ret
upscrny1 ld   a,1
         ld   (newheroy),a
         jr   upscrnpp

;-------------------------------------------------------------------------------
;downscreen
;
downscreen
         push af
         ld   a,121           ;down
         ld   (stscptch+1),a
         ld   a,1
         ld   (newheroy),a
         call setscreen
         pop  af
         ret

;-------------------------------------------------------------------------------
;leftscreen
;
leftscreen
         push af
         ld   a,122           ;left
         ld   (stscptch+1),a
         ld   a,76
         ld   (newherox),a
         call setscreen
         pop  af
         ret

;-------------------------------------------------------------------------------
;rightscreen
;
rightscreen
         push af
         ld   a,123           ;right
         ld   (stscptch+1),a
         ld   a,1
         ld   (newherox),a
         call setscreen
         pop  af
         ret

;-------------------------------------------------------------------------------
;waitvsync
;
waitvsync
         ld   b,&F5
wtvsync  in   a,(c)
         rra  
         jr   nc,wtvsync
         ret
                       
;-------------------------------------------------------------------------------
;hero move
;
heromove
         ld   a,(newherox)
         ld   (raftherox),a
         
         xor  a
         ld   (horunng),a
         
         ld   a,(joybyte)            ;check movement/joystick

         bit  joyleft,a              ;joystick left ----------------------------
         jr   z,joytst

         push af                     ;
         ld   a,(herodir)
         or   a
         jr   nz,herolft 
         cpl
         ld   (herodir),a
         jr   hmltdir

herolft  ld   a,1
         ld   (horunng),a                  
         ld   a,(newherox)           ;top collision with level blocks?
         cp   1                      ;hero left 
         jr   nz,hmlt
         call leftscreen
         jr   hmltdir
hmlt     dec  a         
         ld   yl,a
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         call getstage

         bit  7,a
         jr   z,hmlttst2
         ld   a,(heroclsn)
         set  col_flag_flashw,a
         ld   (heroclsn),a
         jr   hmltdir
         
hmlttst2 or   a
         jr   nz,hmltdir
         ld   b,yl
         ld   a,(newheroy)
         add  heroheight             ;hero height incl roto
         ld   c,a
         call getstage

         bit  7,a
         jr   z,hmlttst3
         ld   a,(heroclsn)
         set  col_flag_flashw,a
         ld   (heroclsn),a
         jr   hmltdir

hmlttst3 or   a
         jr   nz,hmltdir
         
         ld   a,yl
         ld   (newherox),a
         
hmltdir  pop  af
         
joytst   bit  joyright,a             ;joystick right ---------------------------
         jr   z,joytst2

         push af
         ld   a,(herodir)
         or   a
         jr   z,herorigh
         xor  a
         ld   (herodir),a
         jr   hmrtdir
                           
herorigh ld   a,1
         ld   (horunng),a                  
         ld   a,(newherox)           ;top collision with level blocks?
         cp   76                     ;hero right
         jr   nz,hmrt
         call rightscreen
         jr   hmrtdir
hmrt     add  4
         ld   yl,a
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         call getstage

         bit  7,a
         jr   z,hmrttst2
         ld   a,(heroclsn)
         set  col_flag_flashw,a
         ld   (heroclsn),a
         jr   hmrtdir

hmrttst2 or   a
         jr   nz,hmrtdir
         ld   b,yl
         ld   a,(newheroy)
         add  heroheight             ;hero height incl roto
         ld   c,a
         call getstage

         bit  7,a
         jr   z,hmrttst3
         ld   a,(heroclsn)
         set  col_flag_flashw,a
         ld   (heroclsn),a
         jr   hmrtdir

hmrttst3 or   a
         jr   nz,hmrtdir
         
         ld   a,(newherox)
         inc  a         
         ld   (newherox),a           
         
hmrtdir  pop  af
         
joytst2  bit  joyup,a                ;joystick up ------------------------------
         jp   z,homvfall

         ;raising
homvrais ld   a,(houpdly)            ;hero is raising -> increase delay
         cp   herodlybordertop
         jr   z,herytest
         inc  a
         ld   (houpdly),a
         jr   herytest
         
homvfall ld   a,(houpdly)            ;hero is falling -> decrease delay
         or   a
         jr   z,herytest
         dec  a
         ld   (houpdly),a            
                     
herytest cp   herodlyborderdzbottom
         jr   c,herofall
         cp   herodlyborderdztop
         jr   nc,herorais
         jp   joytst3
             
herorais sub  herodlyborderdztop         
         ld   b,a
         inc  b
         xor  a ! ld   (heroonraft),a
         ld   a,(newheroy)
         sub  b                      ;!!!!!
         jr   c,houpscr

         or   1
         jr   z,herorai2
         jr   nc,herorai2
         
houpscr  call upscreen
         jp   joytst3                  
herorai2 ld   (newheroy),a
         
         ld   b,4                    ;wall test lower
raistest push bc
         ld   a,(newherox)           
         add  b
         dec  a
         ld   b,a
         ld   a,(newheroy)
         dec  a
         ld   c,a
         call getstage

         bit  7,a
         jr   z,hmuptst2
         ld   a,(heroclsn)
         set  col_flag_flashw,a
         ld   (heroclsn),a
         jr   herowalc
         
hmuptst2 or   a
         jr   nz,herowalc
         pop  bc
         djnz raistest
         ld   a,1
         ld   (herofly),a                            
         jp   joytst3                ;no wall collision -> next joy test                  

herowalc pop  af
         ld   a,c
         or   a
         jr   nz,herowal2
         ld   a,53+topoffset
         jr   herowal3         
herowal2 ld   a,92+topoffset         ;wall collision
herowal3 ld   (newheroy),a
         ld   a,1
         ld   (herofly),a
         jp   joytst3

         ;falling
herofall ld   b,a
         ld   a,herodlyborderdzbottom
         sub  b
         ld   b,a
         xor  a ! ld   (heroonraft),a
         ld   a,(newheroy)
         add  b                      ;!!!!!!
         cp   lowernextscreen        ;next screen?
         jr   c,herofal2
         call downscreen
         jp   joytst3
herofal2 ld   (newheroy),a
         
         ld   b,4                    ;wall test lower
falltest push bc
         ld   a,(newherox)           
         add  b
         dec  a
         ld   b,a
         ld   a,(newheroy)
         add  heroheight+1   
         ld   c,a
         call getstagewithwater

         bit  7,a
         jr   z,hmuptst3
         ld   a,(heroclsn)
         set  col_flag_flashw,a
         ld   (heroclsn),a
         jr   herostnd
hmuptst3 bit  6,a
         jr   z,hmuptst4         
         ld   yl,a
         
         ld   hl,(clvptrb1)      ;RAFT ITEM MUST BE THE FIRST ITEM IN LIST!!
         ld   de,120+4+1
         add  hl,de
         ld   a,(hl)
         cp   item_raft
         jr   nz,hmwatnor
         ld   a,(newheroy)         
         cp   101+topoffset
         jr   c,hmwatnor         ;no possible y collision with raft

         inc  hl                 ;skip sprite-anim
         inc  hl
         inc  hl
         ld   a,(newherox)
         add  3
         ld   b,(hl)             ;x pos of raft
         sub  b
         jr   z,raftcols
         jr   c,hmwatnor         
raftcols sub  8
         jr   nc,hmwatnor 
 
         pop  af
         ld   a,1
         ld   (heroonraft),a
         ld   a,101+topoffset
         jr   herstdwy                  
         
hmwatnor ld   a,(newheroy)        ;no raft
         cp   102+topoffset
         jr   c,hmuptstr          
         ld   a,(heroclsn)
         set  col_flag_water,a
         ld   (heroclsn),a
         ld   a,102+topoffset
         ld   (newheroy),a
         pop  af
         jr   joytst3            

hmuptstr ld   a,yl
         bit  6,a       
         jr   nz,hmuptst5
hmuptst4 or   a
         jr   nz,herostnd           
hmuptst5 pop  bc
         djnz falltest
         ld   a,1
         ld   (herofly),a                            
         jr   joytst3                ;no wall collision -> next joy test                  

herostnd pop  af
         ld   a,c
         cp   1
         jr   nz,herstnd2
         ld   a,28+topoffset
         jr   herstdwy
herstnd2 ld   a,67+topoffset         ;wall collision -> hero is standing
herstdwy ld   (newheroy),a
         ld   a,0
         ld   (herofly),a
         ;ld   a,herodlymiddle       ;this commented code makes...
         ;ld   (houpdly),a           ;...falling from a cliff too smooth!!!!                          

joytst3  ;raft movement -> no hero x move!!
         ld   a,(heroonraft)
         or   a
         jr   z,joytst4
         ld   a,(raftherox)
         ld   (newherox),a
         xor  a
         ld   (horunng),a

joytst4  ld   a,(joybyte)            ;joystick down -> PLACE BOMB --------------
         bit  joydown,a              
         ret  z
         ld   a,(herofly)
         cp   1
         ret  z
         ld   a,(bombset)
         cp   0
         ret  nz
         ld   a,(bombs)
         or   a
         ret  z
         ld   a,bombdly              ;place bomb
         ld   (bombset),a
         ld   a,(curscrn)            ;copy...
         ld   (bombscrn),a           ;...screen info
         ld   hl,clvptrb1            ;
         ld   de,dlwptrb1            ;
         ld   bc,6                   ;
         ldir                        ;
         ld   a,(newherox)
         inc  a           
         ld   (bombx),a
         ld   b,a         
         ld   a,(newheroy)
         add  13
         ld   (bomby),a
         ld   c,a
         ret
         
herodlybordertop      equ 17
herodlymiddle         equ 8
herodlyborderbottom   equ 0
herodlyborderdztop    equ 12 
herodlyborderdzbottom equ herodlybordertop-herodlyborderdztop 

heroraftmovedelay     equ 2
 
houpdly     db   0
horunng     db   0
heroonraft  db   0
heroraftdly db   heroraftmovedelay
raftherox   db   0

;-------------------------------------------------------------------------------
;getstage    
;in:  b=x, c=y
;out: a=block,c=stage,de=level address
;

getstage
         call getstagewithwater
         bit  6,a
         ret  z
         xor  a
         ret
         
getstagewithwater 
         push hl
         ld   a,b      
         srl  a
         ld   l,a        

         ld   a,c
         sub  13+topoffset
         jr   nc,gstdiv5
         xor  a         
gstdiv5  ld   e,a
         ld   c,39
         xor  a
         ld   b,8
gstdiv   rl   e
         rla
         sub  c
         jr   nc,gstdiv2  
         add  a,c
gstdiv2  djnz gstdiv  
         ld   a,e
         rla  
         cpl
         
         cp   3
         jr   nz,gst3
         ld   a,2
gst3     ld   (gstpatch+1),a
         or   a         
         jr   z,gstdiv4
         ld   b,a        
         xor  a
gstdiv3  add  40
         djnz gstdiv3 

gstdiv4  add  l
         ld   e,a
         ld   d,0
         ld   hl,(clvptrb1)          ;
         add  hl,de                  ;
         
         ld   a,(hl)
gstpatch ld   c,0
         ex   de,hl
         pop  hl
         ret

;-------------------------------------------------------------------------------
;draw hero
;(not really nice to read, but fast)
;
drawhero
         ld   a,(herofly)            ;is hero running?
         or   a
         jp   z,dwhorun
                                                                                  
         ld   a,(herodir)            ;draw hero left or right
         or   a
         jp   nz,heroleft
         
         ld   a,(rotostat)           ;hero right -------------------------------
         
         cp   0                      ;roto 100%
         jr   nz,hort50r
         inc  a
         ld   (rotostat),a
         ld   a,(newherox)
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto100r
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,hoflyr
         ld   de,&0415
         call drawsprite_or
         call makerotosound
         ret         

hort50r  cp   1                      ;roto 50%
         jr   nz,hort0r
         inc  a
         ld   (rotostat),a
         ld   a,(newherox)
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto50r
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,hoflyr        
         ld   de,&0415
         call drawsprite_or
         call makerotosound
         ret         

hort0r   cp   2                      ;roto 0%
         jr   nz,hort50r_
         inc  a
         ld   (rotostat),a
         ld   a,(newherox)
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto0r
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,hoflyr        
         ld   de,&0415
         call drawsprite_or
         call makerotosound
         ret         

hort50r_ xor  a                      ;roto 50%
         ld   (rotostat),a
         ld   a,(newherox)
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto50r
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,hoflyr        
         ld   de,&0415
         call drawsprite_or
         call makerotosound
         ret         
         
heroleft ld   a,(rotostat)           ;hero left --------------------------------
         cp   0                      ;roto 100%
         jr   nz,hort50l
         inc  a
         ld   (rotostat),a
         ld   a,(newherox)
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto100l
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,hoflyl        
         ld   de,&0415       
         call drawsprite_or
         call makerotosound
         ret         

hort50l  cp   1                      ;roto 50%
         jr   nz,hort0l
         inc  a
         ld   (rotostat),a
         ld   a,(newherox)
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto50l
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,hoflyl        
         ld   de,&0415
         call drawsprite_or
         call makerotosound
         ret         

hort0l   cp   2                      ;roto 0%
         jr   nz,hort50l_
         inc  a
         ld   (rotostat),a
         ld   a,(newherox)
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto0l
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,hoflyl        
         ld   de,&0415
         call drawsprite_or
         call makerotosound
         ret         

hort50l_ xor  a                      ;roto 50%
         ld   (rotostat),a
         ld   a,(newherox)
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto50l
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,hoflyl        
         ld   de,&0415
         call drawsprite_or
         call makerotosound
         ret
         
dwhorun  ld   a,(herodir)            ;draw hero left or right
         or   a
         jp   nz,horunlft
         
         ld   a,(herolegs)           ;hero right -------------------------------
         cp   0                      ;hero stand
         jr   nz,horunrt1
         ld   a,(newherox)
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto50r
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,hostndr
         ld   de,&0415
         call drawsprite_or
         call herosilence
         ret
         
horunrt1 sra  a
         cp   1                      ;hero run state 1  (1)
         jr   nz,horunrt2
         ld   a,(newherox)
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto100r
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,horun1r
         ld   de,&0415
         call drawsprite_or
         call herosilence
         ret

horunrt2 cp   2                      ;hero run state 2
         jr   nz,horunrt3
         ld   a,(newherox)
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto50r
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,horun2r
         ld   de,&0415
         call drawsprite_or
         call herosilence
         ret

horunrt3 cp   3                      ;hero run state 3
         jr   nz,horunrt4
         ld   a,(newherox)              
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto0r
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,horun3r
         ld   de,&0415
         call drawsprite_or
         call herosilence
         ret
         
horunrt4 cp   4                      ;hero run state 4
         jr   nz,horunrt5
         ld   a,(newherox)              
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto50r
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,horun4r
         ld   de,&0415
         call drawsprite_or
         call herosilence
         ret

horunrt5 ld   a,(newherox)           ;hero run state 5   
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto100r
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,horun5r
         ld   de,&0415
         call drawsprite_or
         call herosilence
         ret
         
horunlft ld   a,(herolegs)           ;hero left --------------------------------
         cp   0                      ;hero stand
         jr   nz,horunlt1
         ld   a,(newherox)
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto50l
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,hostndl
         ld   de,&0415
         call drawsprite_or
         call herosilence
         ret
         
horunlt1 sra  a
         cp   1                      ;hero run state 1
         jr   nz,horunlt2
         ld   a,(newherox)
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto100l
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,horun1l
         ld   de,&0415
         call drawsprite_or
         call herosilence
         ret

horunlt2 cp   2                      ;hero run state 2
         jr   nz,horunlt3
         ld   a,(newherox)
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto50l
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,horun2l
         ld   de,&0415
         call drawsprite_or
         call herosilence
         ret

horunlt3 cp   3                      ;hero run state 3
         jr   nz,horunlt4
         ld   a,(newherox)              
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto0l
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,horun3l
         ld   de,&0415
         call drawsprite_or
         call herosilence
         ret
         
horunlt4 cp   4                      ;hero run state 4
         jr   nz,horunlt5
         ld   a,(newherox)              
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto50l
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,horun4l
         ld   de,&0415
         call drawsprite_or
         call herosilence
         ret

horunlt5 ld   a,(newherox)              ;hero run state 5
         ld   b,a
         ld   a,(newheroy)
         ld   c,a
         ld   hl,roto100l
         ld   de,&0403
         push bc
         call drawsprite_or
         pop  bc
         inc  c
         inc  c
         inc  c
         ld   hl,horun5l
         ld   de,&0415
         call drawsprite_or
         call herosilence
         ret
                           
;-------------------------------------------------------------------------------
;make roto sound
;
makerotosound
         nop    
         ld   a,(bombset)
         or   a
         ret  nz
         ld   a,(rotosnd)
         dec  a         
         and  %11100        ;%11000 = schnell, %11100 = langsam
         ld   (rotosnd),a
         ld   c,noise       ;reg 
         call wrpsg
         ld   c,channelb
         ld   a,soundfull
         call wrpsg         
         ret         

;-------------------------------------------------------------------------------
;herosilence
;
herosilence
         ld   a,(bombset)
         cp   0
         ret  nz
         ld   c,channelb
         ld   a,soundpst
         call wrpsg
         ret

;-------------------------------------------------------------------------------
;setupactivision
;place the activision logo, the game starts!!!
;
setupactivision
         ld   b,17
         ld   c,179+topoffset
         ld   e,&2c
         ld   d,9
         ld   a,%00001100
         call fillblock
         ld   hl,actvis
         ld   b,25
         ld   c,179+topoffset
         ld   de,&1d0a
         call drawsprite         
         ret               

;-------------------------------------------------------------------------------
;writing animation
;
dlylong    equ 120
dlyshort   equ dlylong/2
dlyscroll  equ dlylong/20
           
writinganimation
         call waitvsync         
         xor  a
         ld   (dispscor),a
         ld   (scrnswap),a
                   
wranmlop ld   a,(scrnswap)
         cp   3
         jr   nz,noscswap
         xor  a
         ld   (scrnswap),a
         call swapscroutput
         call swapscreen
         jr   wranmgo    
noscswap inc  a
         ld   (scrnswap),a         

wranmgo  ld   a,(lifes)
         or   a
         jr   nz,wranmgo2
         ld   a,(scrswp1+1)
         ld   b,a
         ld   a,(titlepage)
         cp   b
         jr   z,wranmgo2
         ld   a,(dispscor)
         inc  a
         and  1
         ld   (dispscor),a
         or   a
         jr   z,dsplevel
         call clearlevel
         call drawscore
         jr   wranmgo2
dsplevel call showlevel         

wranmgo2 ld   a,(writdisp)
         or   a
         jr   nz,preanim
         ld   a,10
         ld   (writdisp),a
         
         ld   b,25
         ld   c,179+topoffset
         ld   de,&0b1d
         ld   a,%00001100
         call fillblock
         
         ld   b,17
         ld   c,180+topoffset
         ld   de,&2c07
         ld   hl,wincpc
         call drawsprite
         ld   b,dlylong*2
         call scrolldelay
         ret  c
         ld   b,dlylong*2
         call scrolldelay
         ret  c
         ld   b,17
         ld   c,180+topoffset
         ld   de,&082c
         ld   a,%00001100
         call fillblock
         jr   wranim
         
preanim  dec  a
         ld   (writdisp),a
         
wranim   ld   b,16
         ld   c,179+topoffset
         ld   de,&300a    ;&250a
         ld   hl,cpcport
         call drawsprite
         ld   b,dlylong
         call scrolldelay
         ret  c

         ld   b,16
         ld   c,179+topoffset
         ld   e,&30  ;&25
         ld   d,8
         ld   a,%00001100
         call fillblock
         
         ld   hl,cprght
         
         xor  a
         push af
         jr   animdir
         
anmsync  push af
         ld   b,dlyscroll
         call scrolldelay     
         jr   c,animret
         
animdir  ld   b,25
         ld   c,179+topoffset
         ld   de,&1d0a
         push hl
         call drawsprite
         pop  hl
         pop  af
         ld   de,&1d
         add  hl,de
         inc  a 
         cp   1
         jr   nz,anmnxtst       
         push af
         ld   b,dlylong
         call scrolldelay
         jr   c,animret
         pop  af
anmnxtst cp   8
         jr   nz,anmsync
         ld   b,dlyshort
         call scrolldelay
         
         jp   wranmlop                                  
animret  pop  af
         ret

writdisp db   0
scrnswap db   0
dispscor db   0
         
;-------------------------------------------------------------------------------
;scrolldelay
;b=delay in vsyncs div 4
;                               
scrolldelay
         scf
         ccf
         push af
synclop2 push bc
         ld   b,&F5
synclop3 call readjoystick
         ld   a,(joybyte)
         bit  joyfire,a
         jr   nz,sdimd
         in   a,(c)
         rra  
         jr   nc,synclop3
         call flashwalls
         ei:halt:halt:di
         pop  bc
         djnz synclop2
         pop  af         
         ret                                                                                
sdimd    pop  bc
         pop  af
         scf
         ret
                                                                                        
;-------------------------------------------------------------------------------
;read joystick
;
readjoystick
         push bc
         push de
         push af         
         push hl
         
         ld   hl,joybyte
         
         ld   bc,&f400+14
         out  (c),c
         
         ld   bc,&f600 or %11000000
         out  (c),c
         
         ld   c,0
         out  (c),c
         
         ld   bc,&f700 or %10010010
         out  (c),c
         
         ld   b,&F6
         ld   a,%01001001     ;read line 9
         out  (c),a         
         ld   b,&f4
         in   a,(c)
         cpl         
         ld   (hl),a

         ld   b,&F6
         ld   a,%01000000     ;read line 0
         out  (c),a         
         ld   b,&f4
         in   a,(c)
         bit  2,a
         jr   nz,rjoy1
         set  1,(hl)
rjoy1    bit  1,a
         jr   nz,rjoy2
         set  3,(hl)
rjoy2    bit  0,a
         jr   nz,rjoy3
         set  0,(hl)
                  
rjoy3    ld   b,&F6
         ld   a,%01000001     ;read line 1
         out  (c),a         
         ld   b,&f4
         in   a,(c)
         bit  1,a
         jr   nz,rjoy4
         set  4,(hl)
rjoy4    bit  0,a
         jr   nz,rjoy5
         set  2,(hl)

rjoy5    ld   b,&F6
         ld   a,%01000101     ;read line 5
         out  (c),a         
         ld   b,&f4
         in   a,(c)
         bit  7,a
         jr   nz,resc
         set  4,(hl)
         
resc     ld   b,&F6
         ld   a,%01001000     ;read line 8 -> ESC
         out  (c),a         
         ld   b,&f4
         in   a,(c)
         cpl
         ld   (escbyte),a         

         ld   bc,&f700 or %10000010
         out  (c),c
         ld   bc,&6f00
         out  (c),c         
         
         pop  hl
         pop  af
         pop  de
         pop  bc
         ret

joybyte  db   0
escbyte  db   0
                  
;-------------------------------------------------------------------------------
;setup power pane
;
setuppowerpane
         ld   b,0                  ;upper border
         ld   c,0+topoffset
         ld   e,80
         ld   d,14
         ld   a,%00001100
         call fillblock

         ld   b,0                  ;1 line black, beneath game screen
         ld   c,131+topoffset
         ld   e,80
         ld   d,1
         ld   a,%00001100
         call fillblock
         
         ld   b,0                  ;powerpane grey
         ld   c,132+topoffset    
         ld   e,80               
         ld   d,47               
         ld   a,%00000011        
         call fillblock
         
         ld   b,13                 ;draw "power" sprite
         ld   c,134+topoffset
         ld   de,&0b05
         ld   hl,powerpan
         call drawsprite

         ld   b,0                  ;lower scroll border
         ld   c,179+topoffset
         ld   e,80
         ld   d,12
         ld   a,%00001100
         call fillblock
                  
         ret
                  
;-------------------------------------------------------------------------------
;draw score
;
drawscore         
         ld   ix,score             ;set pointer
         ld   b,6                  ;six digits
         ld   (ix-1),0             ;indicator no blanking
         
screp    ld   yl,b                 ;save loop counter
                  
         ld   a,(ix+0)             ;fill block or...
         or   a                    ;...draw score digit?
         jr   nz,scdsp1

         ld   a,(scdgonly)         ;draw zero digits...?
         or   a                    ;
         jr   nz,scdsp             ;
         
         ld   a,b                  ;last digit...?
         cp   1                    ;
         jr   z,scdsp              ;...draw always
         
         ld   a,(ix+6)             
         ld   b,a                  ;x position
         ld   c,169+topoffset      ;y position
         ld   de,&0703              ;height, width
         ld   a,%00000011          ;both pixels grey
         call fillblock
         jr   scnxt         

scdsp    ld   hl,numb0             ;jump block for digit 0
         jr   scdsp2
         
scdsp1   ld   hl,numbadr           ;calculate digitaddress
         rl   a                    ;a=a*2, because address is word
         ld   b,0                  ;clear b to add hl,bc
         ld   c,a                  ;set offset to c
         add  hl,bc                ;calculate address in table
         ld   e,(hl)               ;copy adress...
         inc  hl                   ;...in table...
         ld   d,(hl)               ;...to de
         ex   de,hl                ;swap de hl to receive address in hl
         
scdsp2   ld   a,(ix+6)
         ld   b,a                  ;x position
         ld   c,168+topoffset      ;y position
         ld   de,&0307             ;width, height
         call drawsprite
         ld   hl,scdgonly          ;
         ld   (hl),1               ;no blanking!!!   
         
scnxt    ld   b,yl                 ;restore loop counter
         inc  ix                   ;increment pointer
         djnz screp                ;loop all 6 digits
         ret 

scdgonly db   0                               ; DO NOT CHANGE THIS BLOCK!!!
score    db   0,0,0,0,0,0
scoffs   db   pos1,pos2,pos3,pos4,pos5,pos6
numbadr  dw   numb0,numb1,numb2,numb3,numb4,numb5,numb6,numb7,numb8,numb9

;-------------------------------------------------------------------------------
;draw level
;same as draw score, but own routine
;
showlevel                                                                  
         ld   a,(rungame5)
         or   a
         ret  nz                                                                                                                                            
         call clearlevel
         ld   b,pos1-2
         ld   c,168+topoffset
         ld   de,&1307
         ld   hl,levelpan
         call drawsprite
         
         ld   a,(prolevel)
         or   a
         jr   z,shwlevnr
         ld   b,pos1-2+&15
         ld   c,168+topoffset
         ld   de,&0a07
         ld   hl,levpro
         call drawsprite
         ret
                           
shwlevnr ld   ix,level             ;set pointer
         ld   b,2                  ;two digits
         ld   (ix-1),0             ;indicator no blanking
         
lvrep    ld   yl,b                 ;save loop counter
                  
         ld   a,(ix+0)             ;fill block or...
         or   a                    ;...draw level digit?
         jr   nz,lvdsp1

         ld   a,(lvdgonly)         ;draw zero digits...?
         or   a                    ;
         jr   nz,lvdsp             ;
         
         ld   a,b                  ;last digit...?
         cp   1                    ;
         jr   z,lvdsp              ;...draw always
         
         ld   a,(ix+2)             
         ld   b,a                  ;x position
         ld   c,169+topoffset      ;y position
         ld   de,&0703              ;height, width
         ld   a,%00000011          ;both pixels grey
         call fillblock
         jr   lvnxt         

lvdsp    ld   hl,numb0             ;jump block for digit 0
         jr   lvdsp2
         
lvdsp1   ld   hl,numadrlv          ;calculate digitaddress
         rl   a                    ;a=a*2, because address is word
         ld   b,0                  ;clear b to add hl,bc
         ld   c,a                  ;set offset to c
         add  hl,bc                ;calculate address in table
         ld   e,(hl)               ;copy adress...
         inc  hl                   ;...in table...
         ld   d,(hl)               ;...to de
         ex   de,hl                ;swap de hl to receive address in hl
         
lvdsp2   ld   a,(ix+2)
         ld   b,a                  ;x position
         ld   c,168+topoffset      ;y position
         ld   de,&0307             ;width, height
         call drawsprite
         ld   hl,lvdgonly          ;
         ld   (hl),1               ;no blanking!!!   
         
lvnxt    ld   b,yl                 ;restore loop counter
         inc  ix                   ;increment pointer
         djnz lvrep                ;loop all 2 digits
         ret 

lvdgonly db   0                               ; DO NOT CHANGE THIS BLOCK!!!
level    db   0,1
lvoffs   db   pos5+3,pos6+3
numadrlv dw   numb0,numb1,numb2,numb3,numb4,numb5,numb6,numb7,numb8,numb9
levnumbr db   0

;-------------------------------------------------------------------------------
;clear level writing
;
clearlevel
         ld   b,pos1-2
         ld   c,168+topoffset
         ld   de,&0820
         ld   a,%00000011
         call fillblock
         ret                   

;-------------------------------------------------------------------------------
;draw bombs
;
drawbombs
         ld   ix,booffs+5
         ld   a,(bombs)
         or   a                    ;jump if...                                             
         jr   z,nobombs            ;...no bombs                                             
         ld   b,a                  ;setup counter

dbrep    ld   yl,b
         ld   a,(ix+0)
         ld   b,a         
         ld   c,155+topoffset
         ld   de,&020b
         ld   hl,powbomb
         call drawsprite         
         ld   b,yl
         dec  ix
         djnz dbrep
         
nobombs  ld   a,(bombs)
         ld   b,a
         ld   a,6
         sub  b
         ret  z
         ld   b,a
         
dbrep2   ld   yl,b
         ld   a,(ix+0)             
         ld   b,a         
         ld   c,156+topoffset       
         ld   de,&0b02    
         ld   a,%00000011 
         call fillblock
         ld   b,yl
         dec  ix
         djnz dbrep2      

         ret

bombs    db   0
booffs   db   pos1+1,pos2+1,pos3+1,pos4+1,pos5+1,pos6+1

;-------------------------------------------------------------------------------
;draw lifes
;
drawlifes
         ld   ix,lifoffs+5
         ld   a,(lifes)
         or   a                    ;jump if...                                             
         jr   z,nolifes            ;...no lifes                                         
         ld   b,a                  ;setup counter

dlrep    ld   yl,b
         ld   a,(ix+0)
         ld   b,a         
         ld   c,141+topoffset
         ld   de,&030c
         ld   hl,powlife
         call drawsprite         
         ld   b,yl
         dec  ix
         djnz dlrep
         
nolifes  ld   a,(lifes)
         ld   b,a
         ld   a,6
         sub  b
         ret  z
         ld   b,a
         
dlrep2   ld   yl,b
         ld   a,(ix+0)             
         ld   b,a         
         ld   c,142+topoffset       
         ld   de,&0c03    
         ld   a,%00000011 
         call fillblock
         ld   b,yl
         dec  ix
         djnz dlrep2      

         ret

lifes    db   0
lifoffs  db   pos1,pos2,pos3,pos4,pos5,pos6

;-------------------------------------------------------------------------------
;draw energy
drawenergy
         ld   a,(energy)
         or   a
         jr   z,defillup
         ld   e,a
         ld   b,25
         ld   c,135+topoffset
         ld   d,5 
         ld   a,%11000000       ;pissgelb                                                
         call fillblock
         
defillup ld   a,(energy)
         ld   b,a
         ld   c,a
         ld   a,40
         sub  c
         ret  z         
         ld   e,a
         
         ld   a,b
         ld   b,25
         add  b
         ld   b,a

         ld   c,135+topoffset
         ld   d,5 
         ld   a,%11001111       ;magenta
         call fillblock
         
         ret                   

energy   db   0                 ;full=40
                                                                  
;-------------------------------------------------------------------------------
;reset game
;
resetgame         
         ;clear values                             
         xor  a                  ;set score to 0                                                
         ld   (score),a
         ld   (score+1),a
         ld   (score+2),a
         ld   (score+3),a
         ld   (score+4),a
         ld   (score+5),a

         ld   (addlifec),a       ;reset add life counter 
         ld   (old5val),a        ;reset 10000 counter
         ld   (heroonraft),a     ;clear flag

         ld   (wimp),a           ;give up?
         ld   (energy),a         ;set energy to 0
         ld   (levelcoltabptr),a ;clear level colour table pointer
         
         add  3                  ;set lifes to 3
         ld   (lifes),a

         add  3                  ;set bombs to 6
         ld   (bombs),a
                                      
         xor  a                  ;set level
         ld   (level),a
         ld   a,1
         ld   (level+1),a
         ld   hl,level1
         ld   (pnextlev),hl
         ld   a,1
         ld   (levnumbr),a         
         ret         

;-------------------------------------------------------------------------------
;blackout
;blacks all colours             
blackout
         ld   bc,&7f00 or %00010000      ;black border
         out  (c),c
         ld   bc,&7f00 or %01010100
         out  (c),c   

         ld   b,16                       ;all colours to black
boloop   push bc
         ld   a,b
         dec  a
         ld   bc,&7f00
         out  (c),a
         
         ld   a,%01010100                                                       
         out  (c),a
         pop  bc
         djnz boloop
         
         ret

;-------------------------------------------------------------------------------
;unblackout
;set colour, defined in coltab    
unblackout
         ld   a,0   ;start
         ld   d,15  ;ende
         ld   hl,coltab
         call setupcolours
         ret
         
;-------------------------------------------------------------------------------
;setup colours
;hl=address of colourtable, a=start index, d=end index
setupcolours
         push af                      
         push bc
         inc  d
scrset   ld   e,(hl)
         inc  hl

         push af
         ld   bc,&7f00
         out  (c),a
         
         ld   a,%01000000
         or   e
         out  (c),a
         
         pop  af

         inc  a
         cp   d 
         jr   nz,scrset
         pop  bc
         pop  af
         ret   

;-------------------------------------------------------------------------------
;wrpsg
;c = register number
;a = register data                
wrpsg
        ld   b,&f4
        out  (c),c
        
        ld   bc,&f6c0
        out  (c),c
        
        ld   bc,&f600
        out  (c),c
        
        ld   b,&f4
        out  (c),a
        
        ld   bc,&f680
        out  (c),c
        
        ld   bc,&f600
        out  (c),c
        ret
        
;-------------------------------------------------------------------------------
;fill block 
;b=x, c=start raster, d=block height, a=fillpattern, e=fill width         
fillblock
         dec  c             ;add height to top to receive end raster
         push af
         ld   a,c
         add  d
         ld   d,a
         pop  af                                                                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                        
         ld   hl,fbpatch+1  ;patch...                                                                                                                                          
         ld   (hl),e        ;...fill width
         ld   hl,pwrlp+1    ;patch...
         ld   (hl),b        ;...x pos
         ld   hl,fbptrn+1    ;patch...
         ld   (hl),a        ;...fill pattern
pwrlp    ld   b,0
         push de    
         ld   a,c
         sla  a  
         ld   e,a
         ld   a,0
         adc  0
         ld   d,a
         ld   hl,ytab
         add  hl,de
         ld   a,(hl)
         add  b         
         ld   e,a
         inc  hl
         ld   d,(hl)
         ld   a,0
         adc  d
         ld   d,a
         ex   de,hl         
         ld   a,h
         and  &3f
scrswp4  or   &c0
         ld   h,a         
         pop  de
fbpatch  ld   b,80                  
fbptrn   ld   a,%00000011
pwrlst   ld   (hl),a
         inc  hl
         djnz pwrlst
         inc  c
         ld   a,c
         cp   d  
         jr   nz,pwrlp
         ret

;-------------------------------------------------------------------------------
;savebackground
;in:  B=x, C=y, D=bg width, E=bg height, HL=pointer to memorybuffer
savebackground
         ld   (savhght),de
         ld   (savsppos),hl 
         
sbagain  push bc         
         ld   a,c
         sla  a  
         ld   e,a
         ld   a,0
         adc  0
         ld   d,a
         ld   hl,ytab
         add  hl,de
         ld   a,(hl)
         add  b         
         ld   e,a
         inc  hl
         ld   d,(hl)
         ld   a,0
         adc  d
         ld   d,a
         ex   de,hl         
         ld   a,h
         and  &3f
scrswp5  or   &c0
         ld   h,a         

         ld   de,(savsppos)
         ld   bc,(savwdth)
         ld   b,0
         ldir

         ld   (savsppos),de
         ld   bc,(savhght)
         dec  c
         jr   z,sbexit
         ld   (savhght),bc
         pop  bc
         inc  c
         
         jr   sbagain

sbexit   pop  bc
         ret

;-------------------------------------------------------------------------------
;draw sprite (in mode 0)
;in:  B=x, C=y, D=sprite width, E=sprite height, HL=sprite in memory
drawsprite
         ld   (savhght),de
         ld   (savsppos),hl 
         
dsagain  push bc         
         ld   a,c
         sla  a  
         ld   e,a
         ld   a,0
         adc  0
         ld   d,a
         ld   hl,ytab
         add  hl,de
         ld   a,(hl)
         add  b         
         ld   e,a
         inc  hl
         ld   d,(hl)
         ld   a,0
         adc  d
         ld   d,a
         ex   de,hl         
         ld   a,h
         and  &3f
scrswp6  or   &c0
         ld   h,a         

         ex   de,hl
         ld   hl,(savsppos)
         ld   bc,(savwdth)
         ld   b,0
         ldir
         ld   (savsppos),hl
         ld   bc,(savhght)
         dec  c
         jr   z,dsexit
         ld   (savhght),bc
         pop  bc
         inc  c
         
         jr   dsagain

dsexit   pop  bc
         ret

savhght  db   0
savwdth  db   0
orgwdth  db   0
savsppos dw   0         

;-------------------------------------------------------------------------------
;draw sprite or (in mode 0)
;in:  B=x, C=y, D=sprite width, E=sprite height, HL=sprite in memory
drawsprite_or
         ld   (savhght),de
         ld   (savsppos),hl          
         
         ld   a,c
         cp   10                              
         jr   nc,dshagain
         ld   a,e
         cp   9
         ret  c

dshagain push bc
         ld   a,c
         cp   140
         jr   nc,dshexit         
         sla  a  
         ld   e,a
         ld   a,0
         adc  0
         ld   d,a
         ld   hl,ytab
         add  hl,de
         ld   a,(hl)
         add  b         
         ld   e,a
         inc  hl
         ld   d,(hl)
         ld   a,0
         adc  d
         ld   d,a
         ex   de,hl         
         ld   a,h
         and  &3f
scrswp7  or   &c0
         ld   h,a         

         ld   bc,(savhght)
         push bc
         ld   de,(savsppos)
dscopy   ld   a,(hl)
         ld   c,a
         ld   a,(de)
         or   c              ;OR'd drawing operation
         
         ld   (hl),a
         inc  de             
         inc  hl                    
         djnz dscopy 
         ld   (savsppos),de
         pop  bc
         dec  c
         
         jr   z,dshexit
         ld   (savhght),bc
         pop  bc
         inc  c

         jr   dshagain

dshexit  pop  bc
         ret
         
;-------------------------------------------------------------------------------
;draw herosprite (in mode 0)
;in:  B=x, C=y, D=sprite width, E=sprite height, HL=sprite in memory
drawbackground
         ld   (savhght),de
         ld   (savsppos),hl 
         
dbhagain push bc
         ld   a,c
         cp   140
         jr   nc,dbhexit         
         sla  a  
         ld   e,a
         ld   a,0
         adc  0
         ld   d,a
         ld   hl,ytab
         add  hl,de
         ld   a,(hl)
         add  b         
         ld   e,a
         inc  hl
         ld   d,(hl)
         ld   a,0
         adc  d
         ld   d,a
         ex   de,hl         
         ld   a,h
         and  &3f
scrswp8  or   &c0
         ld   h,a         

         ex   de,hl
         ld   hl,(savsppos)
         ld   bc,(savwdth)
         ld   b,0
         ldir
         ld   (savsppos),hl
         ld   bc,(savhght)
         dec  c
         jr   z,dbhexit
         ld   (savhght),bc
         pop  bc
         inc  c

         jr   dbhagain

dbhexit  pop  bc
         ret

;-------------------------------------------------------------------------------
;colour table
coltab   db   20       ;00 - background black -> flashing during detonation                               
         db   3        ;01 - pastel yellow    -> energy bar
         db   20       ;02 - black
         db   13       ;03 - bright magenta   -> activision logo
         db   31       ;04 - pastel blue
         db   11       ;05 - bright white
         db   12       ;06 - bright red
         db   10       ;07 - bright yellow
         db   0        ;08 - grey (50% white)
         db   14       ;09 - orange/brown
         db   22       ;0A - green 
         db   24       ;0B - magenta
         db   29       ;0C - mauve
         db   18       ;0D - bright green (18)                 
         db   altcolr1 ;0E - (undefined)      -> flashing level walls                   
         db   0        ;0F - (undefined)      -> level background
         
;-------------------------------------------------------------------------------
;hero gfx stuff
hostndr  db   %00000000,%10001010,%01000101,%10001010
         db   %00000000,%10001000,%10001000,%00000000
         db   %00000000,%10001010,%10001010,%00000000
         db   %00000000,%10001010,%11001111,%10001010
         db   %00000000,%10001010,%01000101,%10001010
         db   %00010000,%00100000,%00110000,%00000000
         db   %00010000,%00110000,%00110000,%00100000
         db   %00010000,%00110000,%00011000,%00100000
         db   %00010000,%00110000,%00011000,%00100000
         db   %00000000,%00110000,%00011000,%00001000
         db   %00000000,%00110000,%00001100,%00100000
         db   %00000000,%01010000,%11110000,%00000000
         db   %00000000,%00000000,%11110000,%00000000
         db   %00000000,%00000000,%11110000,%00000000
         db   %00000000,%00000000,%11110000,%00000000
         db   %00000000,%00000000,%11110000,%00000000
         db   %00000000,%00000000,%11110000,%00000000
         db   %00000000,%00000000,%11110000,%00000000
         db   %00000000,%00000000,%11110000,%00000000
         db   %00000000,%00000000,%11110000,%00000000
         db   %00000000,%00000000,%11110000,%10100000

hostndl  db   %01000101,%10001010,%01000101,%00000000
         db   %00000000,%01000100,%01000100,%00000000
         db   %00000000,%01000101,%01000101,%00000000
         db   %01000101,%11001111,%01000101,%00000000
         db   %01000101,%10001010,%01000101,%00000000
         db   %00000000,%00110000,%00010000,%00100000
         db   %00010000,%00110000,%00110000,%00100000
         db   %00010000,%00100100,%00110000,%00100000
         db   %00010000,%00100100,%00110000,%00100000
         db   %00000100,%00100100,%00110000,%00000000
         db   %00010000,%00001100,%00110000,%00000000
         db   %00000000,%11110000,%10100000,%00000000
         db   %00000000,%11110000,%00000000,%00000000
         db   %00000000,%11110000,%00000000,%00000000
         db   %00000000,%11110000,%00000000,%00000000
         db   %00000000,%11110000,%00000000,%00000000
         db   %00000000,%11110000,%00000000,%00000000
         db   %00000000,%11110000,%00000000,%00000000
         db   %00000000,%11110000,%00000000,%00000000
         db   %00000000,%11110000,%00000000,%00000000
         db   %01010000,%11110000,%00000000,%00000000

hoflyr   db   %00000000,%10001010,%01000101,%10001010
         db   %00000000,%10001000,%10001000,%00000000
         db   %00000000,%10001010,%10001010,%00000000
         db   %00000000,%10001010,%11001111,%10001010
         db   %00000000,%10001010,%01000101,%10001010
         db   %00010000,%00100000,%00110000,%00000000
         db   %00010000,%00110000,%00110000,%00100000
         db   %00010000,%00110000,%00011000,%00100000
         db   %00010000,%00110000,%00011000,%00100000
         db   %00000000,%00110000,%00011000,%00001000
         db   %00000000,%00110000,%00001100,%00100000
         db   %00000000,%01010000,%11110000,%00000000
         db   %00000000,%00000000,%11110000,%00000000
         db   %00000000,%00000000,%11110000,%00000000
         db   %00000000,%00000000,%10100000,%00000000
         db   %00000000,%00000000,%10100000,%00000000
         db   %00000000,%01010000,%10100000,%00000000
         db   %00000000,%01010000,%10100000,%00000000
         db   %00000000,%01010000,%00000000,%00000000
         db   %00000000,%01010000,%00000000,%00000000
         db   %00000000,%01010000,%00000000,%00000000

hoflyl   db   %01000101,%10001010,%01000101,%00000000
         db   %00000000,%01000100,%01000100,%00000000
         db   %00000000,%01000101,%01000101,%00000000
         db   %01000101,%11001111,%01000101,%00000000
         db   %01000101,%10001010,%01000101,%00000000
         db   %00000000,%00110000,%00010000,%00100000
         db   %00010000,%00110000,%00110000,%00100000
         db   %00010000,%00100100,%00110000,%00100000
         db   %00010000,%00100100,%00110000,%00100000
         db   %00000100,%00100100,%00110000,%00000000
         db   %00010000,%00001100,%00110000,%00000000
         db   %00000000,%11110000,%10100000,%00000000
         db   %00000000,%11110000,%00000000,%00000000
         db   %00000000,%11110000,%00000000,%00000000
         db   %00000000,%01010000,%00000000,%00000000
         db   %00000000,%01010000,%00000000,%00000000
         db   %00000000,%01010000,%10100000,%00000000
         db   %00000000,%01010000,%10100000,%00000000
         db   %00000000,%00000000,%10100000,%00000000
         db   %00000000,%00000000,%10100000,%00000000
         db   %00000000,%00000000,%10100000,%00000000

horun1r  db   %00000000,%10001010,%01000101,%10001010
         db   %00000000,%10001000,%10001000,%00000000
         db   %00000000,%10001010,%10001010,%00000000
         db   %00000000,%10001010,%11001111,%10001010
         db   %00000000,%10001010,%01000101,%10001010
         db   %00010000,%00100000,%00110000,%00000000
         db   %00010000,%00110000,%00110000,%00100000
         db   %00010000,%00110000,%00011000,%00100000
         db   %00010000,%00110000,%00011000,%00100000
         db   %00000000,%00110000,%00011000,%00001000
         db   %00000000,%00110000,%00001100,%00100000
         db   %00000000,%01010000,%11110000,%00000000
         db   %00000000,%01010000,%11110000,%00000000
         db   %00000000,%01010000,%11110000,%10100000
         db   %00000000,%01010000,%01010000,%10100000
         db   %00000000,%11110000,%00000000,%10100000
         db   %00000000,%11110000,%01010000,%00000000
         db   %00000000,%10100000,%01010000,%00000000
         db   %00000000,%10100000,%00000000,%10100000
         db   %00000000,%10100000,%00000000,%00000000
         db   %00000000,%01010000,%00000000,%00000000

horun1l  db   %01000101,%10001010,%01000101,%00000000
         db   %00000000,%01000100,%01000100,%00000000
         db   %00000000,%01000101,%01000101,%00000000
         db   %01000101,%11001111,%01000101,%00000000
         db   %01000101,%10001010,%01000101,%00000000
         db   %00000000,%00110000,%00010000,%00100000
         db   %00010000,%00110000,%00110000,%00100000
         db   %00010000,%00100100,%00110000,%00100000
         db   %00010000,%00100100,%00110000,%00100000
         db   %00000100,%00100100,%00110000,%00000000
         db   %00010000,%00001100,%00110000,%00000000
         db   %00000000,%11110000,%10100000,%00000000
         db   %00000000,%11110000,%10100000,%00000000
         db   %01010000,%11110000,%10100000,%00000000
         db   %01010000,%10100000,%10100000,%00000000
         db   %01010000,%00000000,%11110000,%00000000
         db   %00000000,%10100000,%11110000,%00000000
         db   %00000000,%10100000,%01010000,%00000000
         db   %01010000,%00000000,%01010000,%00000000
         db   %00000000,%00000000,%01010000,%00000000
         db   %00000000,%00000000,%10100000,%00000000        

horun2r  db   %00000000,%10001010,%01000101,%10001010
         db   %00000000,%10001000,%10001000,%00000000
         db   %00000000,%10001010,%10001010,%00000000
         db   %00000000,%10001010,%11001111,%10001010
         db   %00000000,%10001010,%01000101,%10001010
         db   %00010000,%00100000,%00110000,%00000000
         db   %00010000,%00110000,%00110000,%00100000
         db   %00010000,%00110000,%00011000,%00100000
         db   %00010000,%00110000,%00011000,%00100000
         db   %00000000,%00110000,%00011000,%00001000
         db   %00000000,%00110000,%00001100,%00100000
         db   %00000000,%01010000,%11110000,%00000000
         db   %00000000,%01010000,%11110000,%00000000
         db   %00000000,%11110000,%01010000,%10100000
         db   %00000000,%11110000,%00000000,%10100000
         db   %01010000,%10100000,%00000000,%10100000
         db   %01010000,%10100000,%00000000,%10100000
         db   %11110000,%00000000,%00000000,%11110000
         db   %10100000,%00000000,%00000000,%00000000
         db   %10100000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000

horun2l  db   %01000101,%10001010,%01000101,%00000000
         db   %00000000,%01000100,%01000100,%00000000
         db   %00000000,%01000101,%01000101,%00000000
         db   %01000101,%11001111,%01000101,%00000000
         db   %01000101,%10001010,%01000101,%00000000
         db   %00000000,%00110000,%00010000,%00100000
         db   %00010000,%00110000,%00110000,%00100000
         db   %00010000,%00100100,%00110000,%00100000
         db   %00010000,%00100100,%00110000,%00100000
         db   %00000100,%00100100,%00110000,%00000000
         db   %00010000,%00001100,%00110000,%00000000
         db   %00000000,%11110000,%10100000,%00000000
         db   %00000000,%11110000,%10100000,%00000000
         db   %01010000,%10100000,%11110000,%00000000
         db   %01010000,%00000000,%11110000,%00000000
         db   %01010000,%00000000,%01010000,%10100000
         db   %01010000,%00000000,%01010000,%10100000
         db   %11110000,%00000000,%00000000,%11110000
         db   %00000000,%00000000,%00000000,%01010000
         db   %00000000,%00000000,%00000000,%01010000
         db   %00000000,%00000000,%00000000,%00000000

horun3r  db   %00000000,%10001010,%01000101,%10001010
         db   %00000000,%10001000,%10001000,%00000000
         db   %00000000,%10001010,%10001010,%00000000
         db   %00000000,%10001010,%11001111,%10001010
         db   %00000000,%10001010,%01000101,%10001010
         db   %00010000,%00100000,%00110000,%00000000
         db   %00010000,%00110000,%00110000,%00100000
         db   %00010000,%00110000,%00011000,%00100000
         db   %00010000,%00110000,%00011000,%00100000
         db   %00000000,%00100100,%00110000,%00100000
         db   %00000000,%00100100,%00001100,%00100000
         db   %00000000,%01010000,%11110000,%00000000
         db   %00000000,%01010000,%11110000,%10100000
         db   %11110000,%01010000,%10100000,%10100000
         db   %01010000,%11110000,%00000000,%10100000
         db   %00000000,%11110000,%00000000,%11110000
         db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000

horun3l  db   %01000101,%10001010,%01000101,%00000000
         db   %00000000,%01000100,%01000100,%00000000
         db   %00000000,%01000101,%01000101,%00000000
         db   %01000101,%11001111,%01000101,%00000000
         db   %01000101,%10001010,%01000101,%00000000
         db   %00000000,%00110000,%00010000,%00100000
         db   %00010000,%00110000,%00110000,%00100000
         db   %00010000,%00100100,%00110000,%00100000
         db   %00010000,%00100100,%00110000,%00100000
         db   %00010000,%00110000,%00011000,%00000000
         db   %00010000,%00001100,%00011000,%00000000
         db   %00000000,%11110000,%10100000,%00000000
         db   %01010000,%11110000,%10100000,%00000000
         db   %01010000,%01010000,%10100000,%11110000
         db   %01010000,%00000000,%11110000,%10100000
         db   %11110000,%00000000,%11110000,%00000000
         db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000

horun4r  db   %00000000,%10001010,%01000101,%10001010
         db   %00000000,%10001000,%10001000,%00000000
         db   %00000000,%10001010,%10001010,%00000000
         db   %00000000,%10001010,%11001111,%10001010
         db   %00000000,%10001010,%01000101,%10001010
         db   %00010000,%00100000,%00110000,%00000000
         db   %00010000,%00110000,%00110000,%00100000
         db   %00010000,%00110000,%00011000,%00100000
         db   %00010000,%00110000,%00011000,%00100000
         db   %00000000,%00100100,%00110000,%00100000
         db   %00000000,%00100100,%00001100,%00100000
         db   %00000000,%01010000,%11110000,%00000000
         db   %00000000,%01010000,%10100000,%00000000
         db   %00000000,%01010000,%11110000,%00000000
         db   %00000000,%01010000,%11110000,%00000000
         db   %00000000,%01010000,%01010000,%10100000
         db   %01010000,%11110000,%00000000,%10100000
         db   %01010000,%00000000,%00000000,%10100000
         db   %01010000,%00000000,%00000000,%11110000
         db   %00000000,%00000000,%00000000,%10100000
         db   %00000000,%00000000,%00000000,%00000000

horun4l  db   %01000101,%10001010,%01000101,%00000000
         db   %00000000,%01000100,%01000100,%00000000
         db   %00000000,%01000101,%01000101,%00000000
         db   %01000101,%11001111,%01000101,%00000000
         db   %01000101,%10001010,%01000101,%00000000
         db   %00000000,%00110000,%00010000,%00100000
         db   %00010000,%00110000,%00110000,%00100000
         db   %00010000,%00100100,%00110000,%00100000
         db   %00010000,%00100100,%00110000,%00100000
         db   %00010000,%00110000,%00011000,%00000000
         db   %00010000,%00001100,%00011000,%00000000
         db   %00000000,%11110000,%10100000,%00000000
         db   %00000000,%01010000,%10100000,%00000000
         db   %00000000,%11110000,%10100000,%00000000
         db   %00000000,%11110000,%10100000,%00000000
         db   %01010000,%10100000,%10100000,%00000000
         db   %01010000,%00000000,%11110000,%10100000
         db   %01010000,%00000000,%00000000,%10100000
         db   %11110000,%00000000,%00000000,%10100000
         db   %01010000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000

horun5r  db   %00000000,%10001010,%01000101,%10001010
         db   %00000000,%10001000,%10001000,%00000000
         db   %00000000,%10001010,%10001010,%00000000
         db   %00000000,%10001010,%11001111,%10001010
         db   %00000000,%10001010,%01000101,%10001010
         db   %00010000,%00100000,%00110000,%00000000
         db   %00010000,%00110000,%00110000,%00100000
         db   %00010000,%00110000,%00011000,%00100000
         db   %00010000,%00110000,%00011000,%00100000
         db   %00000000,%00110000,%00011000,%00001000
         db   %00000000,%00110000,%00001100,%00100000
         db   %00000000,%01010000,%11110000,%00000000
         db   %00000000,%01010000,%10100000,%00000000
         db   %00000000,%01010000,%11110000,%00000000
         db   %00000000,%00000000,%11110000,%10100000
         db   %00000000,%00000000,%10100000,%10100000
         db   %00000000,%11110000,%11110000,%10100000
         db   %00000000,%10100000,%10100000,%00000000
         db   %00000000,%10100000,%10100000,%00000000
         db   %00000000,%00000000,%10100000,%00000000
         db   %00000000,%00000000,%11110000,%00000000

horun5l  db   %01000101,%10001010,%01000101,%00000000
         db   %00000000,%01000100,%01000100,%00000000
         db   %00000000,%01000101,%01000101,%00000000
         db   %01000101,%11001111,%01000101,%00000000
         db   %01000101,%10001010,%01000101,%00000000
         db   %00000000,%00110000,%00010000,%00100000
         db   %00010000,%00110000,%00110000,%00100000
         db   %00010000,%00100100,%00110000,%00100000
         db   %00010000,%00100100,%00110000,%00100000
         db   %00000100,%00100100,%00110000,%00000000
         db   %00010000,%00001100,%00110000,%00000000
         db   %00000000,%11110000,%10100000,%00000000
         db   %00000000,%01010000,%10100000,%00000000
         db   %00000000,%11110000,%10100000,%00000000
         db   %01010000,%11110000,%00000000,%00000000
         db   %01010000,%01010000,%00000000,%00000000
         db   %01010000,%11110000,%11110000,%00000000
         db   %00000000,%01010000,%01010000,%00000000
         db   %00000000,%01010000,%01010000,%00000000
         db   %00000000,%01010000,%00000000,%00000000
         db   %00000000,%11110000,%00000000,%00000000

herodead db   %00000000,%01010100,%11111100,%11111100
         db   %00000000,%00000000,%01010100,%00000000
         db   %00000000,%00000000,%01010100,%00000000
         db   %00000000,%11001111,%01000101,%10001010
         db   %01000100,%00000000,%10001000,%10001000
         db   %01000101,%00000000,%10001010,%10001010
         db   %01000101,%11001111,%10001010,%10001010
         db   %00000000,%11001111,%00000000,%10001010
         db   %00000000,%00110000,%00010000,%00100000
         db   %00010000,%00000000,%00100000,%00100000
         db   %00010000,%00110000,%00110000,%00000000
         db   %00100000,%00110000,%00010000,%00000000
         db   %00100000,%00110000,%00010000,%00100000
         db   %00100000,%00110000,%00100000,%00100000
         db   %10100000,%11110000,%10100000,%10100000
         db   %00000000,%11110000,%10100000,%00000000
         db   %00000000,%10100000,%10100000,%00000000
         db   %00000000,%10100000,%10100000,%00000000
         db   %00000000,%10100000,%10100000,%00000000
         db   %00000000,%10100000,%10100000,%00000000
         db   %00000000,%10100000,%10100000,%00000000
         db   %00000000,%10100000,%10100000,%00000000
         db   %00000000,%10100000,%10100000,%00000000
         db   %01010000,%10100000,%11110000,%00000000

roto100r db   %11111100,%11111100,%10101000,%00000000
         db   %00000000,%10101000,%00000000,%00000000
         db   %00000000,%10101000,%00000000,%00000000

roto100l db   %00000000,%01010100,%11111100,%11111100
         db   %00000000,%00000000,%01010100,%00000000
         db   %00000000,%00000000,%01010100,%00000000

roto50r  db   %01010100,%11111100,%00000000,%00000000
         db   %00000000,%10101000,%00000000,%00000000
         db   %00000000,%10101000,%00000000,%00000000

roto50l  db   %00000000,%00000000,%11111100,%10101000
         db   %00000000,%00000000,%01010100,%00000000
         db   %00000000,%00000000,%01010100,%00000000

roto0r   db   %00000000,%10101000,%00000000,%00000000
         db   %00000000,%10101000,%00000000,%00000000
         db   %00000000,%10101000,%00000000,%00000000
         
roto0l   db   %00000000,%00000000,%01010100,%00000000
         db   %00000000,%00000000,%01010100,%00000000
         db   %00000000,%00000000,%01010100,%00000000

;-------------------------------------------------------------------------------
;miner gfx stuff
_minrt   dw   &040c
minerr   db   %00000000,%01010100,%00000000,%00000000
         db   %00000000,%00000011,%00000010,%00000000
         db   %00000000,%11000011,%00000000,%00000000
         db   %00000000,%11000011,%00000000,%00000000
         db   %00000000,%10000010,%00000000,%00000000
         db   %01010001,%11110011,%00000000,%00000000
         db   %01010001,%01011001,%00000000,%00000000
         db   %01010001,%01011001,%00000000,%00000000
         db   %01010001,%01011001,%01010001,%00000000
         db   %01010000,%10100100,%11110000,%10100000
         db   %01010000,%11110000,%10100000,%10100000
         db   %00000000,%11110000,%00000000,%11110000

_minlt   dw   &040c
minerl   db   %00000000,%00000000,%10101000,%00000000
         db   %00000000,%00000001,%00000011,%00000000
         db   %00000000,%00000000,%11000011,%00000000
         db   %00000000,%00000000,%11000011,%00000000
         db   %00000000,%00000000,%01000001,%00000000
         db   %00000000,%00000000,%11110011,%10100010
         db   %00000000,%00000000,%10100110,%10100010
         db   %00000000,%00000000,%10100110,%10100010
         db   %00000000,%10100010,%10100110,%10100010
         db   %01010000,%11110000,%01011000,%10100000
         db   %01010000,%01010000,%11110000,%10100000
         db   %11110000,%00000000,%11110000,%00000000

minrescr db   %00000000,%01010100,%00000000,%00000000
         db   %00000000,%00000011,%00000010,%00000000
         db   %00000000,%11000011,%00000000,%00000000
         db   %00000000,%11000011,%00000000,%00000000
         db   %00000000,%10000010,%01000001,%00000000
         db   %01010001,%11110011,%01010001,%00000000
         db   %01010001,%01011001,%11110011,%00000000
         db   %01010001,%01011001,%00000000,%00000000
         db   %01010001,%01011001,%01010001,%00000000
         db   %01010000,%10100100,%11110000,%10100000
         db   %01010000,%11110000,%10100000,%10100000
         db   %00000000,%11110000,%00000000,%11110000

minrescl db   %00000000,%00000000,%10101000,%00000000
         db   %00000000,%00000001,%00000011,%00000000
         db   %00000000,%00000000,%11000011,%00000000
         db   %00000000,%00000000,%11000011,%00000000
         db   %00000000,%10000010,%01000001,%00000000
         db   %00000000,%10100010,%11110011,%10100010
         db   %00000000,%11110011,%10100110,%10100010
         db   %00000000,%00000000,%10100110,%10100010
         db   %00000000,%10100010,%10100110,%10100010
         db   %01010000,%11110000,%01011000,%10100000
         db   %01010000,%01010000,%11110000,%10100000
         db   %11110000,%00000000,%11110000,%00000000

;-------------------------------------------------------------------------------
;laserbeams
laserb1  db   %00111100,%00010100,%00101000,%00111100,%00010100,%00101000,%00111100,%00010100,%00101000,%00111100,%00010100
laserb2  db   %00010100,%00101000,%00111100,%00010100,%00101000,%00111100,%00010100,%00101000,%00111100,%00010100,%00101000

;-------------------------------------------------------------------------------
;bomb
bomb1    db   %01010100,%00000000
         db   %11111100,%00000000
         db   %01010100,%10101000
         db   %01010100,%00000000
         db   %01010100,%00000000
         db   %11001111,%10001010
         db   %11001111,%10001010
         db   %11001111,%10001010
         db   %11001111,%10001010
         db   %11001111,%10001010
         db   %11001111,%10001010

bomb2    db   %10101000,%00000000
         db   %00000000,%10101000
         db   %01010100,%10101000
         db   %01010100,%00000000
         db   %01010100,%00000000
         db   %11001111,%10001010
         db   %11001111,%10001010
         db   %11001111,%10001010
         db   %11001111,%10001010
         db   %11001111,%10001010
         db   %11001111,%10001010

bomb3    db   %00000000,%10101000
         db   %10101000,%00000000
         db   %11111100,%00000000
         db   %01010100,%00000000
         db   %01010100,%00000000
         db   %11001111,%10001010
         db   %11001111,%10001010
         db   %11001111,%10001010
         db   %11001111,%10001010
         db   %11001111,%10001010
         db   %11001111,%10001010

boum1    db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%01010100,%10101000,%00000000
         db   %00000000,%11111100,%11111100,%00000000
         db   %01010100,%00010100,%11111100,%00000000
         db   %00000000,%10111100,%00101000,%10101000
         db   %00000000,%11111100,%11111100,%10101000
         db   %00000000,%11111100,%10101000,%00000000
         db   %00000000,%01010100,%10101000,%00000000
         db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000

boum2    db   %00000000,%00000000,%01010100,%00000000
         db   %10101000,%01010100,%00000000,%01010100
         db   %01010100,%01010100,%10101000,%10101000
         db   %01010100,%11111100,%11111100,%10101000
         db   %00000000,%11111100,%11111100,%00000000
         db   %00000000,%01010100,%11111100,%01010100
         db   %10101000,%11111100,%10101000,%00000000
         db   %00000000,%11111100,%11111100,%00000000
         db   %01010100,%11111100,%11111100,%10101000
         db   %01010100,%01010100,%10101000,%01010100
         db   %10101000,%00000000,%10101000,%00000000

boum3    db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%10101000,%00000000
         db   %00000000,%01010100,%10101000,%00000000
         db   %01010100,%01010100,%10101000,%00000000
         db   %00000000,%11111100,%11111100,%00000000
         db   %01010100,%01010100,%11111100,%00000000
         db   %00000000,%11111100,%10101000,%10101000
         db   %00000000,%11111100,%11111100,%00000000
         db   %00000000,%01010100,%10101000,%10101000
         db   %00000000,%01010100,%10101000,%00000000
         db   %00000000,%01010100,%00000000,%00000000

boum4    db   %00000000,%10101000,%00000000,%01010100
         db   %00000000,%01010100,%01010100,%00000000
         db   %01010100,%00000000,%00000000,%00000000
         db   %00000000,%10101000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000
         db   %10101000,%00000000,%01010100,%00000000
         db   %00000000,%00000000,%00000000,%10101000
         db   %01010100,%01010100,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%01010100

;-------------------------------------------------------------------------------
;lantern h=11,w=3 
_lanton  dw   &030b
latnrnon db   %00000000,%00000001,%00000011
         db   %00000000,%00000011,%00000011
         db   %00000000,%00000010,%00000000
         db   %00000000,%00000010,%00000000
         db   %00000001,%00000011,%00000000
         db   %00000011,%00000011,%00000010
         db   %01000000,%11000000,%00000000
         db   %01000000,%11000000,%00000000
         db   %00000011,%00000011,%00000010
         db   %01000000,%11000000,%00000000
         db   %00000000,%10000000,%00000000

_lantoff dw   &030b
lantnoff db   %00000000,%00000001,%00000011
         db   %00000000,%00000011,%00000011
         db   %00000000,%00000010,%00000000
         db   %00000000,%00000010,%00000000
         db   %00000001,%00000011,%00000000
         db   %00000011,%00000011,%00000010
         db   %00000001,%00000001,%00000000
         db   %00000001,%00000001,%00000000
         db   %00000011,%00000011,%00000010
         db   %00000001,%00000011,%00000000
         db   %00000000,%00000010,%00000000

;-------------------------------------------------------------------------------
;spider
_spider1 dw   &040a 
         db   %00000000,%00000001,%00000000,%00000000
         db   %00000000,%00000001,%00000000,%00000000
         db   %00000000,%00000001,%00000000,%00000000
         db   %00000000,%00000001,%00000000,%00000000
         db   %00000000,%01000001,%00000000,%00000000
         db   %01010100,%01000001,%01010100,%00000000
         db   %10000010,%11000011,%10000010,%10000010
         db   %10000010,%11000011,%10000010,%10000010
         db   %10000010,%01000001,%00000000,%10000010
         db   %10000010,%00000000,%00000000,%10000010

_spider2 dw   &040a 
         db   %00000000,%00000001,%00000000,%00000000
         db   %00000000,%00000001,%00000000,%00000000
         db   %00000000,%00000001,%00000000,%00000000
         db   %00000000,%01000001,%00000000,%00000000
         db   %01010100,%01000001,%01010100,%00000000
         db   %10000010,%11000011,%10000010,%10000010
         db   %10000010,%11000011,%10000010,%10000010
         db   %10000010,%01000001,%00000000,%10000010
         db   %10000010,%00000000,%00000000,%10000010
         db   %00000000,%00000000,%00000000,%00000000
                                                                      
_spider3 dw   &040a 
         db   %00000000,%00000001,%00000000,%00000000
         db   %00000000,%00000001,%00000000,%00000000
         db   %00000000,%01000001,%00000000,%00000000
         db   %01010100,%01000001,%01010100,%00000000
         db   %10000010,%11000011,%10000010,%10000010
         db   %10000010,%11000011,%10000010,%10000010
         db   %10000010,%01000001,%00000000,%10000010
         db   %10000010,%00000000,%00000000,%10000010
         db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000

;-------------------------------------------------------------------------------
;moth
_moth1   dw   &040b
         db   %00000000,%00000001,%00000000,%00000000
         db   %00000000,%00000011,%00000010,%00000000
         db   %00000000,%10100000,%10100000,%00000000
         db   %00000000,%10101000,%10101000,%00000000
         db   %00000000,%11000011,%10000010,%00000000
         db   %01000001,%11000011,%11000011,%00000000
         db   %00000000,%11000011,%10000010,%00000000
         db   %00000000,%10101000,%10101000,%00000000
         db   %00000000,%10100000,%10100000,%00000000
         db   %00000000,%00000011,%00000010,%00000000
         db   %00000000,%00000001,%00000000,%00000000

_moth2   dw   &040b
         db   %00000000,%00000010,%00000010,%00000000
         db   %00000000,%00000010,%00000010,%00000000
         db   %00000000,%10100000,%10100000,%00000000
         db   %00000000,%10101000,%10101000,%00000000
         db   %00000000,%11000011,%10000010,%00000000
         db   %01000001,%11000011,%11000011,%00000000
         db   %00000000,%11000011,%10000010,%00000000
         db   %00000000,%10101000,%10101000,%00000000
         db   %00000000,%10100000,%10100000,%00000000
         db   %00000000,%00000010,%00000010,%00000000
         db   %00000000,%00000010,%00000010,%00000000

_moth3   dw   &040b
         db   %00000001,%00000000,%00000001,%00000000
         db   %00000001,%00000010,%00000011,%00000000
         db   %00000000,%10100000,%10100000,%00000000
         db   %00000000,%10101000,%10101000,%00000000
         db   %00000000,%11000011,%10000010,%00000000
         db   %01000001,%11000011,%11000011,%00000000
         db   %00000000,%11000011,%10000010,%00000000
         db   %00000000,%10101000,%10101000,%00000000
         db   %00000000,%10100000,%10100000,%00000000
         db   %00000001,%00000010,%00000011,%00000000
         db   %00000001,%00000000,%00000001,%00000000

_moth4   dw   &040b
         db   %00000010,%00000000,%00000000,%00000010
         db   %00000011,%00000000,%00000001,%00000010
         db   %01010000,%10100000,%11110000,%00000000
         db   %00000000,%10101000,%10101000,%00000000
         db   %00000000,%11000011,%10000010,%00000000
         db   %01000001,%11000011,%11000011,%00000000
         db   %00000000,%11000011,%10000010,%00000000
         db   %00000000,%10101000,%10101000,%00000000
         db   %01010000,%10100000,%11110000,%00000000
         db   %00000011,%00000000,%00000001,%00000010
         db   %00000010,%00000000,%00000000,%00000010
                                                                       
;-------------------------------------------------------------------------------
;bat

_bat1    dw   &0408
         db   %00000000,%10000010,%10000010,%00000000
         db   %00000000,%01000001,%00000000,%00000000
         db   %00000000,%11000011,%10000010,%00000000
         db   %01000001,%11000011,%11000011,%00000000
         db   %11000011,%01000001,%01000001,%10000010
         db   %11000011,%00000000,%01000001,%10000010
         db   %10000000,%00000000,%00000000,%10000000
         db   %01000001,%00000000,%01000001,%00000000
                                                                       
_bat2    dw   &0408
         db   %10000010,%00000000,%00000000,%10000010
         db   %10101000,%10000010,%10000010,%10101000
         db   %11000011,%01000001,%01000001,%10000010
         db   %11000011,%10000010,%11000011,%10000010
         db   %11000011,%11000011,%11000011,%10000010
         db   %01000001,%11000011,%11000011,%00000000
         db   %00000000,%01000001,%00000000,%00000000
         db   %00000000,%00000000,%00000000,%00000000

;-------------------------------------------------------------------------------
;snake

_snake1  dw   &0107                                                                                                                                         
         db   %10100010
         db   %01010001
         db   %11110011
         db   %01010001
         db   %00000000
         db   %11110011
         db   %10100010

_snake2  dw   &0207
         db   %01010001,%10100010
         db   %11110011,%01010001
         db   %11110011,%11110011
         db   %10100010,%01010001
         db   %11110011,%11110011
         db   %00000000,%10100010
         db   %00000000,%00000000

_snake3  dw   &0307
         db   %00000000,%01010001,%10100010
         db   %00000000,%11110011,%01010001
         db   %11110011,%11110011,%11110011
         db   %11110011,%10100010,%01010001
         db   %11110011,%11110011,%00000000
         db   %00000000,%01010001,%11110011
         db   %00000000,%00000000,%10100010

_snake4  dw   &0407
         db   %00000000,%00000000,%01010001,%10100010
         db   %00000000,%00000000,%11110011,%01010001
         db   %11110011,%11110011,%11110011,%11110011
         db   %11110011,%11110011,%10100010,%01010001
         db   %11110011,%11110011,%11110011,%11110011
         db   %00000000,%00000000,%00000000,%10100010
         db   %00000000,%00000000,%00000000,%00000000

;-------------------------------------------------------------------------------
;raft

_raft    dw   &0502
itraft   db   %11000000,%11000000,%11000000,%11000000,%11000000
         db   %11000000,%11000000,%11000000,%11000000,%11000000

;-------------------------------------------------------------------------------
;tentacle
_tentcl1 dw   &0408
         db   %00000000,%00110000,%00100000,%00000000
         db   %00010000,%00000000,%00010000,%00000000
         db   %00100000,%00010000,%00000000,%00100000
         db   %00100000,%00100000,%00000000,%00100000
         db   %00100000,%00010000,%00110000,%00000000
         db   %00110000,%00000000,%00000000,%00000000
         db   %00010000,%00000000,%00110000,%00000000
         db   %00010000,%00010000,%00110000,%00100000
                                                                  
_tentcl2 dw   &0408
         db   %00000000,%00110000,%00100000,%00000000
         db   %00010000,%00000000,%00010000,%00000000
         db   %00010000,%00000000,%00000000,%00100000
         db   %00100000,%00000000,%00000000,%00100000
         db   %00100000,%00110000,%00000000,%00100000
         db   %00100000,%00000000,%00110000,%00000000
         db   %00110000,%00000000,%00000000,%00000000
         db   %00010000,%00000000,%00110000,%00000000

_tentcl3 dw   &0408
         db   %00000000,%00000000,%00000000,%00000000
         db   %00000000,%00110000,%00110000,%00000000
         db   %00010000,%00000000,%00000000,%00100000
         db   %00100000,%00000000,%00000000,%00010000
         db   %00100000,%00000000,%00000000,%00010000
         db   %00100000,%00000000,%00000000,%00100000
         db   %00100000,%00000000,%00000000,%00000000
         db   %00110000,%00000000,%00000000,%00000000
 
;-------------------------------------------------------------------------------
;points
pts50    db   %11000000,%10000000,%11000000,%10000000
         db   %10000000,%00000000,%10000000,%10000000
         db   %11000000,%10000000,%10000000,%10000000
         db   %00000000,%10000000,%10000000,%10000000
         db   %11000000,%10000000,%11000000,%10000000
         
pts75    db   %11000000,%10000000,%11000000,%10000000
         db   %00000000,%10000000,%10000000,%00000000
         db   %00000000,%10000000,%11000000,%10000000
         db   %00000000,%10000000,%00000000,%10000000
         db   %00000000,%10000000,%11000000,%10000000

;-------------------------------------------------------------------------------
;power pane
powerpan db   %11110000,%10100001,%11110000,%10100001,%10100001,%00000011,%10100001,%11110000,%10100001,%11110000,%10100001
         db   %10100001,%10100001,%10100001,%10100001,%10100001,%10100001,%10100001,%10100001,%00000011,%10100001,%10100001
         db   %11110000,%10100001,%10100001,%10100001,%11110000,%11110000,%10100001,%11110000,%00000011,%11110000,%00000011
         db   %10100001,%00000011,%10100001,%10100001,%11110000,%01010010,%10100001,%10100001,%00000011,%10100001,%10100001
         db   %10100001,%00000011,%11110000,%10100001,%10100001,%00000011,%10100001,%11110000,%10100001,%10100001,%10100001     

levelpan db   %11110000,%00000011,%00000011,%01010010,%11110000,%11110000,%10100001,%11110000,%00000011,%11110000,%01010010,%11110000,%11110000,%10100001,%11110000,%00000011,%00000011,%00000011,%00000011
         db   %11110000,%00000011,%00000011,%01010010,%10100001,%00000011,%00000011,%11110000,%00000011,%11110000,%01010010,%10100001,%00000011,%00000011,%11110000,%00000011,%00000011,%01010010,%10100001
         db   %11110000,%00000011,%00000011,%01010010,%10100001,%00000011,%00000011,%11110000,%00000011,%11110000,%01010010,%10100001,%00000011,%00000011,%11110000,%00000011,%00000011,%01010010,%10100001
         db   %11110000,%00000011,%00000011,%01010010,%11110000,%11110000,%00000011,%11110000,%00000011,%11110000,%01010010,%11110000,%11110000,%00000011,%11110000,%00000011,%00000011,%00000011,%00000011
         db   %11110000,%00000011,%00000011,%01010010,%10100001,%00000011,%00000011,%11110000,%00000011,%11110000,%01010010,%10100001,%00000011,%00000011,%11110000,%00000011,%00000011,%01010010,%10100001
         db   %11110000,%00000011,%00000011,%01010010,%10100001,%00000011,%00000011,%01010010,%11110000,%10100001,%01010010,%10100001,%00000011,%00000011,%11110000,%00000011,%00000011,%01010010,%10100001
         db   %11110000,%11110000,%11110000,%01010010,%11110000,%11110000,%10100001,%00000011,%11110000,%00000011,%01010010,%11110000,%11110000,%10100001,%11110000,%11110000,%11110000,%00000011,%00000011

levpro   db   %11110000,%11110000,%10100001,%01010010,%11110000,%11110000,%00000011,%01010010,%11110000,%10100001
         db   %11110000,%00000011,%11110000,%01010010,%10100001,%01010010,%10100001,%11110000,%00000011,%11110000
         db   %11110000,%00000011,%11110000,%01010010,%10100001,%01010010,%10100001,%11110000,%00000011,%11110000
         db   %11110000,%11110000,%10100001,%01010010,%11110000,%11110000,%00000011,%11110000,%00000011,%11110000
         db   %11110000,%00000011,%00000011,%01010010,%10100001,%01010010,%10100001,%11110000,%00000011,%11110000
         db   %11110000,%00000011,%00000011,%01010010,%10100001,%01010010,%10100001,%11110000,%00000011,%11110000
         db   %11110000,%00000011,%00000011,%01010010,%10100001,%01010010,%10100001,%01010010,%11110000,%10100001

skill    db   %01010010,%11110000,%11110000,%01010010,%10100001,%01010010,%10100001,%11110000,%01010010,%10100001,%00000011,%00000011,%11110000,%00000011,%00000011,%00000011,%00000011
         db   %11110000,%00000011,%00000011,%01010010,%10100001,%01010010,%10100001,%11110000,%01010010,%10100001,%00000011,%00000011,%11110000,%00000011,%00000011,%01010010,%10100001
         db   %11110000,%00000011,%00000011,%01010010,%10100001,%11110000,%00000011,%11110000,%01010010,%10100001,%00000011,%00000011,%11110000,%00000011,%00000011,%01010010,%10100001
         db   %01010010,%11110000,%10100001,%01010010,%11110000,%10100001,%00000011,%11110000,%01010010,%10100001,%00000011,%00000011,%11110000,%00000011,%00000011,%00000011,%00000011
         db   %00000011,%00000011,%11110000,%01010010,%10100001,%11110000,%00000011,%11110000,%01010010,%10100001,%00000011,%00000011,%11110000,%00000011,%00000011,%01010010,%10100001
         db   %00000011,%00000011,%11110000,%01010010,%10100001,%01010010,%10100001,%11110000,%01010010,%10100001,%00000011,%00000011,%11110000,%00000011,%00000011,%01010010,%10100001
         db   %11110000,%11110000,%10100001,%01010010,%10100001,%01010010,%10100001,%11110000,%01010010,%11110000,%11110000,%10100001,%11110000,%11110000,%11110000,%00000011,%00000011

powlife  db   %11111100,%10101001,%00000011
         db   %01010110,%00000011,%00000011
         db   %00010110,%00010110,%00101001
         db   %00010110,%00010110,%00101001
         db   %00010010,%00110000,%00100001
         db   %00000011,%00100001,%00100001
         db   %00000011,%00100001,%00100001
         db   %00000011,%01010010,%00000011
         db   %00000011,%01010010,%00000011
         db   %00000011,%11110000,%00000011
         db   %00000011,%10100001,%00000011
         db   %00000011,%10100001,%00000011

powbomb  db   %01010110,%00000011
         db   %11111100,%00000011
         db   %01010110,%10101001
         db   %01010110,%00000011
         db   %01010110,%00000011
         db   %11001111,%10001011
         db   %11001111,%10001011
         db   %11001111,%10001011
         db   %11001111,%10001011
         db   %11001111,%10001011
         db   %11001111,%10001011


;-------------------------------------------------------------------------------
;cpc-port, copyright and activision logo
cpcport  db   %11110000,%11110000,%01011000,%11110000,%10100100,%11110000,%11110000,%00001100,%00001100,%11110000,%11110000,%00001100,%00001100,%00001100,%00001100,%00001100,%10100100,%00001100,%00001100,%01011000,%11110000,%10100100,%11110000,%11110000,%01011000,%11110000,%10100100,%11110000,%11110000,%00001100,%00001100,%10100100,%00001100,%00001100,%00001100,%00001100,%00001100,%01011000,%11110000,%10100100,%10100100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100
         db   %10100100,%01011000,%01011000,%00001100,%10100100,%10100100,%01011000,%00001100,%00001100,%10100100,%01011000,%00001100,%00001100,%00001100,%00001100,%11110000,%11110000,%10100100,%00001100,%00001100,%00001100,%10100100,%10100100,%01011000,%01011000,%00001100,%10100100,%10100100,%00001100,%00001100,%00001100,%10100100,%00001100,%00001100,%00001100,%00001100,%00001100,%01011000,%00001100,%00001100,%10100100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100
         db   %10100100,%00001100,%01011000,%11110000,%10100100,%10100100,%00001100,%01011000,%10100100,%11110000,%11110000,%01011000,%11110000,%10100100,%11110000,%00001100,%10100100,%00001100,%00001100,%01011000,%11110000,%10100100,%10100100,%01011000,%01011000,%00001100,%10100100,%11110000,%11110000,%00001100,%00001100,%11110000,%11110000,%01011000,%00001100,%10100100,%00001100,%01011000,%11110000,%00001100,%10100100,%10100100,%01011000,%01011000,%11110000,%10100100,%11110000,%11110000
         db   %10100100,%01011000,%01011000,%00001100,%00001100,%10100100,%01011000,%00001100,%00001100,%10100100,%00001100,%01011000,%00001100,%10100100,%10100100,%00001100,%10100100,%00001100,%00001100,%01011000,%00001100,%00001100,%10100100,%01011000,%01011000,%00001100,%10100100,%00001100,%01011000,%00001100,%00001100,%10100100,%01011000,%01011000,%00001100,%10100100,%00001100,%01011000,%00001100,%00001100,%10100100,%10100100,%01011000,%01011000,%00001100,%10100100,%10100100,%01011000
         db   %11110000,%11110000,%01011000,%00001100,%00001100,%11110000,%11110000,%00001100,%00001100,%10100100,%00001100,%01011000,%11110000,%10100100,%10100100,%00001100,%10100100,%01011000,%00001100,%01011000,%11110000,%10100100,%11110000,%11110000,%01011000,%11110000,%10100100,%11110000,%11110000,%00001100,%00001100,%11110000,%11110000,%01011000,%11110000,%10100100,%00001100,%01011000,%00001100,%00001100,%10100100,%11110000,%11110000,%01011000,%00001100,%10100100,%10100100,%01011000
         db   %00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%01011000,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%10100100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%01011000,%00001100,%00001100,%00001100,%00001100,%00001100
         db   %00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%10100100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%01011000,%11110000,%10100100,%00001100,%00001100,%00001100,%00001100,%00001100,%11110000,%11110000,%00001100,%00001100,%00001100,%00001100,%00001100

         db   %00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100
         db   %00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100
         db   %00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100

cprght   db   %11110000,%11110000,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%01011000,%00001100,%00001100,%00001100,%10100100,%00001100,%01011000,%00001100,%00001100,%00001100,%10100100,%11110000,%11110000,%01011000,%11110000,%10100100,%10100100,%01011000
         db   %10100100,%01011000,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%10100100,%01011000,%11110000,%11110000,%00001100,%00001100,%10100100,%10100100,%01011000,%01011000,%00001100,%10100100,%10100100,%01011000          
         db   %10100100,%00001100,%01011000,%11110000,%10100100,%11110000,%11110000,%01011000,%00001100,%10100100,%11110000,%01011000,%01011000,%11110000,%10100100,%11110000,%10100100,%01011000,%00001100,%00001100,%00001100,%10100100,%11110000,%11110000,%01011000,%11110000,%10100100,%11110000,%11110000
         db   %10100100,%01011000,%01011000,%00001100,%10100100,%10100100,%01011000,%01011000,%00001100,%10100100,%10100100,%01011000,%01011000,%00001100,%10100100,%10100100,%10100100,%01011000,%00001100,%00001100,%00001100,%10100100,%00001100,%01011000,%01011000,%00001100,%10100100,%00001100,%01011000
         db   %11110000,%11110000,%01011000,%11110000,%10100100,%11110000,%11110000,%01011000,%11110000,%10100100,%10100100,%01011000,%01011000,%11110000,%10100100,%10100100,%10100100,%01011000,%00001100,%00001100,%00001100,%10100100,%00001100,%01011000,%01011000,%11110000,%10100100,%00001100,%01011000
         db   %00001100,%00001100,%00001100,%00001100,%00001100,%10100100,%00001100,%00001100,%00001100,%10100100,%00001100,%00001100,%00001100,%00001100,%10100100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100
         db   %00001100,%00001100,%00001100,%00001100,%00001100,%10100100,%00001100,%01011000,%11110000,%10100100,%00001100,%00001100,%01011000,%11110000,%10100100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100

actvis   db   %00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100
         db   %00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100
         db   %00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100
         
         db   %11001111,%11001111,%11001111,%11001111,%11001111,%11001111,%11001111,%11001111,%11001111,%11001111,%11001111,%11001111,%11001111,%11001111,%10100100,%11110000,%11110000,%11110000,%11110000,%00001100,%00001100,%11110000,%11110000,%11110000,%10100100,%00001100,%00001100,%00001100,%00001100
         db   %11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11010010,%10100100,%00001100,%01011000,%00001100,%01011000,%00001100,%01011000,%10100100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100
         db   %11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11000011,%11110000,%10100100,%11110000,%01011000,%01011000,%01011000,%00001100,%11110000,%00001100,%11110000,%10100100,%10100100,%11110000,%10100100,%10100100,%01011000
         db   %11111100,%11111100,%11111100,%11111100,%11111100,%11111100,%11111100,%11111100,%11111100,%11111100,%11111100,%11111100,%11111000,%10100100,%10100100,%10100100,%01011000,%01011000,%01011000,%01011000,%10100100,%10100100,%10100100,%00001100,%10100100,%10100100,%10100100,%11110000,%01011000
         db   %00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%11110000,%11110000,%10100100,%10100100,%01011000,%01011000,%01011000,%11110000,%00001100,%10100100,%11110000,%10100100,%10100100,%10100100,%10100100,%11110000,%11110000
         db   %00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%00001111,%01010010,%10100100,%00001100,%10100100,%10100100,%01011000,%01011000,%01011000,%10100100,%00001100,%10100100,%00001100,%10100100,%10100100,%10100100,%10100100,%10100100,%11110000
         db   %00110011,%00110011,%00110011,%00110011,%00110011,%00110011,%00110011,%00110011,%00110011,%00110011,%00110011,%11110000,%00001100,%00001100,%10100100,%11110000,%01011000,%01011000,%01011000,%00001100,%00001100,%10100100,%11110000,%10100100,%10100100,%11110000,%10100100,%10100100,%01011000
                                                                                                                                                                                                                                                                                           
;-------------------------------------------------------------------------------
;number gfx
numb0    db   %01010010,%11110000,%10100001
         db   %11110000,%00000011,%11110000
         db   %11110000,%00000011,%11110000
         db   %11110000,%00000011,%11110000
         db   %11110000,%00000011,%11110000
         db   %11110000,%00000011,%11110000
         db   %01010010,%11110000,%10100001
        
numb1    db   %00000011,%11110000,%00000011
         db   %01010010,%11110000,%00000011
         db   %00000011,%11110000,%00000011
         db   %00000011,%11110000,%00000011
         db   %00000011,%11110000,%00000011
         db   %00000011,%11110000,%00000011
         db   %01010010,%11110000,%10100001

numb2    db   %01010010,%11110000,%10100001
         db   %11110000,%00000011,%11110000
         db   %00000011,%00000011,%11110000
         db   %00000011,%01010010,%10100001
         db   %00000011,%11110000,%00000011
         db   %01010010,%10100001,%00000011
         db   %11110000,%11110000,%11110000

numb3    db   %01010010,%11110000,%10100001
         db   %11110000,%00000011,%11110000
         db   %00000011,%00000011,%11110000
         db   %00000011,%11110000,%10100001
         db   %00000011,%00000011,%11110000
         db   %11110000,%00000011,%11110000
         db   %01010010,%11110000,%10100001

numb4    db   %00000011,%11110000,%10100001
         db   %01010010,%11110000,%10100001
         db   %11110000,%01010010,%10100001
         db   %11110000,%11110000,%11110000
         db   %00000011,%01010010,%10100001
         db   %00000011,%01010010,%10100001
         db   %00000011,%11110000,%11110000

numb5    db   %11110000,%11110000,%11110000
         db   %11110000,%00000011,%00000011
         db   %11110000,%00000011,%00000011
         db   %11110000,%11110000,%10100001
         db   %00000011,%00000011,%11110000
         db   %11110000,%00000011,%11110000
         db   %01010010,%11110000,%10100001

numb6    db   %01010010,%11110000,%10100001
         db   %11110000,%00000011,%11110000
         db   %11110000,%00000011,%00000011
         db   %11110000,%11110000,%10100001
         db   %11110000,%00000011,%11110000
         db   %11110000,%00000011,%11110000
         db   %01010010,%11110000,%10100001

numb7    db   %11110000,%11110000,%11110000
         db   %00000011,%00000011,%11110000
         db   %00000011,%00000011,%11110000
         db   %00000011,%01010010,%10100001
         db   %00000011,%11110000,%00000011
         db   %00000011,%11110000,%00000011
         db   %00000011,%11110000,%00000011

numb8    db   %01010010,%11110000,%10100001
         db   %11110000,%00000011,%11110000
         db   %11110000,%00000011,%11110000
         db   %01010010,%11110000,%10100001
         db   %11110000,%00000011,%11110000
         db   %11110000,%00000011,%11110000
         db   %01010010,%11110000,%10100001

numb9    db   %01010010,%11110000,%10100001
         db   %11110000,%00000011,%11110000
         db   %11110000,%00000011,%11110000
         db   %01010010,%11110000,%11110000
         db   %00000011,%00000011,%11110000
         db   %11110000,%00000011,%11110000
         db   %01010010,%11110000,%10100001

wincpc   db   %10000110,%10000110,%00001100,%11000011,%10000110,%00001100,%11000011,%00001100,%00001100,%01001001,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%10100100,%01011000,%00001100,%01011000,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%10100100,%00001100,%00001100,%00001100,%10100100,%00001100,%10100100,%10100100,%00001100,%00001100,%01011000,%00001100,%11110000,%00001100,%01011000,%00001100
         db   %10000110,%10000110,%00001100,%10000110,%00001100,%00001100,%10000110,%10000110,%00001100,%10000110,%10000110,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%01011000,%00001100,%01011000,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%00001100,%10100100,%00001100,%10100100,%00001100,%00001100,%00001100,%10100100,%10100100,%10100100,%10100100,%10100100,%10100100
         db   %10000110,%10000110,%00001100,%10000110,%00001100,%00001100,%10000110,%10000110,%00001100,%10000110,%10000110,%00001100,%00001100,%10100100,%10100100,%10100100,%01011000,%10100100,%10100100,%11110000,%10100100,%11110000,%10100100,%01011000,%00001100,%11110000,%00001100,%00001100,%10100100,%11110000,%00001100,%00001100,%10100100,%10100100,%10100100,%10100100,%11110000,%00001100,%10100100,%00001100,%10100100,%10100100,%10100100,%00001100
         db   %11000011,%10000110,%00001100,%11000011,%00001100,%00001100,%11000011,%00001100,%00001100,%10000110,%10000110,%00001100,%00001100,%10100100,%10100100,%10100100,%10100100,%00001100,%10100100,%01011000,%00001100,%01011000,%00001100,%10100100,%10100100,%10100100,%10100100,%00001100,%10100100,%10100100,%10100100,%00001100,%10100100,%10100100,%10100100,%10100100,%10100100,%10100100,%10100100,%00001100,%11110000,%00001100,%10100100,%00001100
         db   %10000110,%10000110,%00001100,%10000110,%00001100,%00001100,%10000110,%10000110,%00001100,%10000110,%10000110,%00001100,%00001100,%10100100,%10100100,%10100100,%10100100,%00001100,%10100100,%01011000,%00001100,%01011000,%00001100,%11110000,%10100100,%10100100,%10100100,%00001100,%10100100,%10100100,%10100100,%00001100,%10100100,%10100100,%10100100,%10100100,%10100100,%10100100,%10100100,%00001100,%10100100,%00001100,%10100100,%00001100
         db   %10000110,%10000110,%00001100,%10000110,%00001100,%00001100,%10000110,%10000110,%00001100,%10000110,%10000110,%00001100,%00001100,%10100100,%10100100,%10100100,%10100100,%00001100,%10100100,%01011000,%00001100,%01011000,%00001100,%10100100,%00001100,%10100100,%10100100,%00001100,%10100100,%10100100,%10100100,%00001100,%10100100,%10100100,%10100100,%10100100,%10100100,%10100100,%10100100,%10100100,%10100100,%00001100,%10100100,%10100100
         db   %10000110,%10000110,%10000110,%11000011,%10000110,%10000110,%10000110,%10000110,%10000110,%01001001,%00001100,%10000110,%00001100,%01011000,%01011000,%00001100,%10100100,%00001100,%10100100,%01011000,%00001100,%01011000,%00001100,%01011000,%10100100,%10100100,%10100100,%00001100,%10100100,%10100100,%10100100,%00001100,%01011000,%01011000,%00001100,%10100100,%10100100,%10100100,%01011000,%00001100,%10100100,%00001100,%01011000,%00001100

herotit  read "titlepic.asm"
herologo read "titlelogo.asm"

jvr      db   %00000000,%00000000,%10100000,%01010000,%11110000,%00000000,%10100000,%00000000,%10100000,%10100000,%00000000,%10100000,%00000000,%01010000,%00000000,%01010000,%00000000,%01010000,%00000000,%01010000,%00000000,%01010000,%00000000,%00000000,%11110000,%11110000,%00000000,%10100000,%00000000,%10100000,%11110000,%11110000,%10100000,%10100000,%10100000,%00000000,%10100000,%10100000,%01010000,%11110000,%10100000
         db   %00000000,%00000000,%10100000,%10100000,%00000000,%10100000,%10100000,%00000000,%10100000,%10100000,%00000000,%10100000,%00000000,%01010000,%00000000,%01010000,%00000000,%10100000,%10100000,%01010000,%00000000,%01010000,%00000000,%00000000,%10100000,%00000000,%10100000,%10100000,%00000000,%10100000,%00000000,%00000000,%10100000,%10100000,%10100000,%00000000,%10100000,%10100000,%10100000,%00000000,%00000000
         db   %00000000,%00000000,%10100000,%10100000,%00000000,%10100000,%10100000,%00000000,%10100000,%11110000,%00000000,%10100000,%00000000,%01010000,%00000000,%01010000,%01010000,%00000000,%01010000,%01010000,%10100000,%01010000,%00000000,%00000000,%10100000,%00000000,%10100000,%01010000,%01010000,%00000000,%00000000,%01010000,%00000000,%10100000,%11110000,%00000000,%10100000,%00000000,%10100000,%00000000,%00000000
         db   %00000000,%00000000,%10100000,%10100000,%00000000,%10100000,%11110000,%11110000,%10100000,%10100000,%10100000,%10100000,%00000000,%01010000,%00000000,%01010000,%01010000,%11110000,%11110000,%01010000,%01010000,%01010000,%00000000,%00000000,%11110000,%11110000,%00000000,%00000000,%10100000,%00000000,%00000000,%10100000,%00000000,%10100000,%10100000,%10100000,%10100000,%00000000,%01010000,%11110000,%00000000
         db   %00000000,%00000000,%10100000,%10100000,%00000000,%10100000,%10100000,%00000000,%10100000,%10100000,%01010000,%10100000,%00000000,%01010000,%00000000,%01010000,%01010000,%00000000,%01010000,%01010000,%00000000,%11110000,%00000000,%00000000,%10100000,%00000000,%10100000,%00000000,%10100000,%00000000,%01010000,%00000000,%00000000,%10100000,%10100000,%01010000,%10100000,%00000000,%00000000,%00000000,%10100000
         db   %10100000,%00000000,%10100000,%10100000,%00000000,%10100000,%10100000,%00000000,%10100000,%10100000,%00000000,%10100000,%00000000,%00000000,%10100000,%10100000,%01010000,%00000000,%01010000,%01010000,%00000000,%01010000,%00000000,%00000000,%10100000,%00000000,%10100000,%00000000,%10100000,%00000000,%10100000,%00000000,%00000000,%10100000,%10100000,%00000000,%10100000,%00000000,%00000000,%00000000,%10100000
         db   %01010000,%11110000,%00000000,%01010000,%11110000,%00000000,%10100000,%00000000,%10100000,%10100000,%00000000,%10100000,%00000000,%00000000,%01010000,%00000000,%01010000,%00000000,%01010000,%01010000,%00000000,%01010000,%00000000,%00000000,%10100000,%00000000,%10100000,%00000000,%10100000,%00000000,%11110000,%11110000,%10100000,%10100000,%10100000,%00000000,%10100000,%00000000,%11110000,%11110000,%00000000

prsfire  db   %11000000,%11000000,%00000000,%11000000,%11000000,%00000000,%11000000,%11000000,%10000000,%01000000,%11000000,%00000000,%01000000,%11000000,%00000000,%00000000,%00000000,%11000000,%11000000,%10000000,%10000000,%11000000,%11000000,%00000000,%11000000,%11000000,%10000000
         db   %11000000,%11000000,%10000000,%11000000,%11000000,%10000000,%11000000,%11000000,%10000000,%11000000,%11000000,%00000000,%11000000,%11000000,%00000000,%00000000,%00000000,%11000000,%11000000,%10000000,%10000000,%11000000,%11000000,%10000000,%11000000,%11000000,%10000000
         db   %10000000,%00000000,%10000000,%10000000,%00000000,%10000000,%10000000,%00000000,%00000000,%10000000,%00000000,%00000000,%10000000,%00000000,%00000000,%00000000,%00000000,%10000000,%00000000,%00000000,%10000000,%10000000,%00000000,%10000000,%10000000,%00000000,%00000000
         db   %11000000,%11000000,%10000000,%11000000,%11000000,%10000000,%11000000,%11000000,%00000000,%11000000,%11000000,%00000000,%11000000,%11000000,%00000000,%00000000,%00000000,%11000000,%11000000,%00000000,%10000000,%11000000,%11000000,%10000000,%11000000,%11000000,%00000000
         db   %11000000,%11000000,%00000000,%11000000,%11000000,%00000000,%11000000,%11000000,%00000000,%01000000,%11000000,%10000000,%01000000,%11000000,%10000000,%00000000,%00000000,%11000000,%11000000,%00000000,%10000000,%11000000,%11000000,%00000000,%11000000,%11000000,%00000000
         db   %10000000,%00000000,%00000000,%10000000,%00000000,%10000000,%10000000,%00000000,%00000000,%00000000,%00000000,%10000000,%00000000,%00000000,%10000000,%00000000,%00000000,%10000000,%00000000,%00000000,%10000000,%10000000,%00000000,%10000000,%10000000,%00000000,%00000000
         db   %10000000,%00000000,%00000000,%10000000,%00000000,%10000000,%11000000,%11000000,%10000000,%11000000,%11000000,%10000000,%11000000,%11000000,%10000000,%00000000,%00000000,%10000000,%00000000,%00000000,%10000000,%10000000,%00000000,%10000000,%11000000,%11000000,%10000000
         db   %10000000,%00000000,%00000000,%10000000,%00000000,%10000000,%11000000,%11000000,%10000000,%11000000,%11000000,%00000000,%11000000,%11000000,%00000000,%00000000,%00000000,%10000000,%00000000,%00000000,%10000000,%10000000,%00000000,%10000000,%11000000,%11000000,%10000000
        
;-------------------------------------------------------------------------------
;item collection
extract_item_miner_right                  
         db   0
         dw   _minrt

extract_item_miner_left                  
         db   0
         dw   _minlt
                                    
extract_item_lantern
         db   0
         dw   _lanton

extract_item_bat
         db   1                      
         dw   _bat1,_bat2

extract_item_spider
         db   3
         dw   _spider1,_spider2,_spider3,_spider2
         
extract_item_moth
         db   5
         dw   _moth1,_moth2,_moth3,_moth4,_moth3,_moth2
         
extract_item_snake
         db   5
         dw   _snake1,_snake2,_snake3,_snake4,_snake3,_snake2

extract_item_raft
         db   0
         dw   _raft
         
extract_item_tenctacle
         db   3
         dw   _tentcl1,_tentcl2,_tentcl3,_tentcl2
                                                     
;-------------------------------------------------------------------------------
;levels colour table
lvgreen          equ  22
lvbrown          equ  14
lvblue           equ  23
lvgrey           equ  0

water_green      equ  %00001111
water_blue       equ  %00110011
water_lava       equ  %11001111
water_brown      equ  %11000011

levelcolourtab   db   lvbrown, lvgreen, lvblue, lvgrey
watercolourtab   db   water_blue, water_lava, water_brown, water_green
levelcoltabptr   db   0

;-------------------------------------------------------------------------------
;levels
;

;item/wall type mask
item_mask_drlev  equ %00010000       ;draw level mask
item_mask_out    equ %00011111       ;item mask out
enemy_mask_out   equ %00001111       ;enemy mask out
wall_mask_flash  equ %00100000       ;wall is flashing -> or'ed in item
wall_mask_crush  equ %01000000       ;crushing walls   -> or'ed in item
item_bottm_water equ %10000000       ;water bottom     -> or'ed in item

;items
item_lantern_on  equ %00000000 or item_mask_drlev   ;=undestroyable
item_lantern_off equ %00000010 or item_mask_drlev   ;=undestroyable       
item_spider      equ %00000011
item_moth        equ %00000100
item_snake       equ %00000101
item_bat         equ %00000110
item_tentacle    equ %00001100                                                   
item_raft        equ %00001101                                                  
item_miner_rt    equ %00001110 or item_mask_drlev   ;=undestroyable
item_miner_lt    equ %00001111 or item_mask_drlev   ;=undestroyable

;item record (prepared)
items            equ 3
itemrecsize      equ 21                                                                   
itemperlevel     equ items*itemrecsize


;*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*    
;
;level record (prepared):
;db   0                ;screens in level (once per level!!!)
;
;db   0                ;colour of this screen (every screen has its own colour)
;ds   5                ;5 bytes (bitmap) stage 0
;ds   5                ;5 bytes (bitmap) stage 1
;ds   5                ;5 bytes (bitmap) stage 2
;
;direction and crush record:
;db   0,0,0,0          ;up, down, left, right  ;up flagged -> crushcode bit 7
;db   0                ;crushcounter
;
;item record (unprepared):
;db   0                ;item type (defines enemy or item and its strength)
;db   0,0              ;x,y - pos
;db   0                ;x movement one way
;db   0                ;y movement one way
;
;item record (prepared, calculated through setuplevel):
;db   0                ;item type (defines enemy or item and its strength)
;db   0,0              ;number of sprites (begins at 0), animation counter space
;db   0,0              ;x,y - pos
;db   0,0              ;x movement one way, current x space (bit 7=dir,1=left)
;db   0,0              ;y movement one way, current y space (bit 7=dir,1=up)
;dw   0,0,0,0,0,0      ;animation sprite pointer(s)
;

;*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*    
         read "levels.asm"     
         
;-------------------------------------------------------------------------------
;data puffer, free in memory
;-------------------------------------------------------------------------------
heroback equ  $                       ;hero's backbuffer
;givupbck equ  heroback+(&04*&18)      ;give up backbuffer
;ytab     equ  givupbck+(&0f*&17)      ;y-lookup table (200*2)
ytab     equ  heroback+(&04*&18)      ;y-lookup table (200*2)
curlevel equ  ytab+(200*2)            ;40 characters*3 lines*16 frames (max)            
         ;
eof      equ  $
;= EOF =========================================================================         
