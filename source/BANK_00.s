.BANK 0
.ORG 0

V_STARTUP:
  sei
  ; set a little starting register state
  stz NMITIMEN
  stz HDMAEN
  stz MDMAEN
  stz APUIO0
  stz APUIO1
  stz APUIO2
  stz APUIO3
  clc
  xce
  cld
  ; switch to data bank 0
  lda #0
  pha
  plb
  rep #P_Idx8Bit | P_Acc8Bit
  ; disable screen
  lda.w #$80
  sta INIDISP
  ; set page register to 0
  lda.w #$00
  tcd
  ; clear stack
  lda.w #$01FF
  tcs
  ; initialize out some game state
  stz DemoRunning
  sep #P_Idx8Bit | P_Acc8Bit                                      ; 008030 E2 30 
  stz $02CB
  stz $052C
  JSR.W L_8232                                    ; 008038 20 32 82 
  JSL L_EDAFF                                     ; 00803B 22 FF DA 0E 
  LDA.W $020A                                     ; 00803F AD 0A 02 
  BNE.B B_806B                                    ; 008042 D0 27 
  STZ.W GameCircuitWarpActive                                     ; 008044 9C 0E 02 
  STZ.W $020F                                     ; 008047 9C 0F 02 
  STZ.W $052F                                     ; 00804A 9C 2F 05 
  LDA.B #$02                                      ; 00804D A9 02 
  STA.W $0206                                     ; 00804F 8D 06 02 
  STZ.W $0207                                     ; 008052 9C 07 02 
  STZ.W $0204                                     ; 008055 9C 04 02 
  STZ.W $0205                                     ; 008058 9C 05 02 
  LDA.B #$02                                      ; 00805B A9 02 
  STA.W $0208                                     ; 00805D 8D 08 02 
  STZ.W $0209                                     ; 008060 9C 09 02 
  JSL L_EE1BB                                     ; 008063 22 BB E1 0E 
  JSL L_EDAF3                                     ; 008067 22 F3 DA 0E 
B_806B:
  LDA.W $020A                                     ; 00806B AD 0A 02 
  BNE.B B_8074                                    ; 00806E D0 04 
  JSL L_EFFE                                      ; 008070 22 FE EF 00 
B_8074:
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 008074 C2 30 
  JSL L_F835A                                     ; 008076 22 5A 83 0F 
  LDA.W #$0000                                    ; 00807A A9 00 00 
  JSL L_F836D                                     ; 00807D 22 6D 83 0F 
ReturnToTitle:
  SEP.B #P_Acc8Bit                                      ; 008081 E2 20 
  STZ.W $02CB                                     ; 008083 9C CB 02 
  STZ.W $052C                                     ; 008086 9C 2C 05 
  LDA.B #$08                                      ; 008089 A9 08 
  LDX.W #$0000                                    ; 00808B A2 00 00 
  JSL Audio_F830F                                     ; 00808E 22 0F 83 0F 
  LDA.B #$03                                      ; 008092 A9 03 
  LDX.W #$0606                                    ; 008094 A2 06 06 
  JSL Audio_F830F                                     ; 008097 22 0F 83 0F 
  LDA.B #$02                                      ; 00809B A9 02 
  LDX.W #$7070                                    ; 00809D A2 70 70 
  JSL Audio_F830F                                     ; 0080A0 22 0F 83 0F 
  LDA.B #$0D                                      ; 0080A4 A9 0D 
  LDX.W #$1212                                    ; 0080A6 A2 12 12 
  JSL Audio_F830F                                     ; 0080A9 22 0F 83 0F 
  JSL UpdateJoypadState                                     ; 0080AD 22 6A CA 0E 
  lda JoyDown
  cmp #(BTN0_LT | BTN0_A)
  bne B_80BC
  JSL RunGameEndingScreen
B_80BC:
  PEA.W $0000                                     ; 0080BC F4 00 00 
  PLB                                             ; 0080BF AB 
  PLB                                             ; 0080C0 AB 
  JSL L_ECBAF                                     ; 0080C1 22 AF CB 0E 
  JSL L_ECD12                                     ; 0080C5 22 12 CD 0E 
  SEP.B #P_Acc8Bit                                      ; 0080C9 E2 20 
  LDA.B #$0D                                      ; 0080CB A9 0D 
  LDX.W #$4040                                    ; 0080CD A2 40 40 
  JSL Audio_F830F                                     ; 0080D0 22 0F 83 0F 
  REP.B #$10                                      ; 0080D4 C2 10 
  LDA.B #$02                                      ; 0080D6 A9 02 
  STA.W $05E0                                     ; 0080D8 8D E0 05 
  LDX.W $05E0                                     ; 0080DB AE E0 05 
  LDA.B #$0F                                      ; 0080DE A9 0F 
  JSL Audio_F830F                                     ; 0080E0 22 0F 83 0F 
  SEP.B #$10                                      ; 0080E4 E2 10 
GameScreenLoop:
  PEA.W $0000                                     ; 0080E6 F4 00 00 
  PLB                                             ; 0080E9 AB 
  PLB                                             ; 0080EA AB 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 0080EB E2 30 
  STZ.W CurrentRound                                     ; 0080ED 9C AB 05 
  STZ.W CurrentRoom                                     ; 0080F0 9C AC 05 
  STZ.W TurboModeActive                                     ; 0080F3 9C 2E 05 
  LDA.W $052F                                     ; 0080F6 AD 2F 05 
  BEQ.B B_811F                                    ; 0080F9 F0 24 

.byte $9C,$2F,$05,$A9,$01,$8D,$2E,$05             ; 0080FB ........ ?/????.?
.byte $A9,$04,$8D,$06,$02,$A9,$03,$8D             ; 008103 ........ ????????
.byte $04,$02,$22,$F3,$DA,$0E,$20,$D0             ; 00810B ........ ??"??? ?
.byte $81,$22,$C3,$F2,$0E,$F4,$00,$00             ; 008113 ........ ?"??????
.byte $AB,$AB,$80,$41                             ; 00811C ....     ???A

B_811F:
  LDA.B #$02                                      ; 00811F A9 02 
  JSL L_F84EC                                     ; 008121 22 EC 84 0F 
  JSL RunTitleSplashScreen                                     ; 008125 22 50 E6 0D 
  JSL RunTitleTextCrawlScreen                                     ; 008129 22 C8 E7 0E 
  JSL L_E454                                      ; 00812D 22 54 E4 00 
  JSL RunTitleHighscoreScreen                                     ; 008131 22 57 E2 0E 
ReturnToTitleMenu:
  STZ.W CurrentRound                                     ; 008135 9C AB 05 
  STZ.W CurrentRoom                                     ; 008138 9C AC 05 
  JSL L_E454                                      ; 00813B 22 54 E4 00 
  SEP.B #P_Acc8Bit                                      ; 00813F E2 20 
  STZ.W $02CB                                     ; 008141 9C CB 02 
  STZ.W $052C                                     ; 008144 9C 2C 05 
  JSL RunTitleMenuScreen                                     ; 008147 22 30 D7 0E 
  LDA.W GameCircuitWarpActive                                     ; 00814B AD 0E 02 
  BEQ.B B_8159                                    ; 00814E F0 09 

  JSL RunCircuitWarpScreen
  LDA $05AB
  BMI RunGameCreditsScreen

B_8159:
  PEA.W $0000                                     ; 008159 F4 00 00 
  PLB                                             ; 00815C AB 
  PLB                                             ; 00815D AB 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00815E E2 30 
  JSR.W L_81D0                                    ; 008160 20 D0 81 
  LDX.W CurrentRound                                     ; 008163 AE AB 05 
  STX.W CurrentRound                                     ; 008166 8E AB 05 
  LDA.L D_81CD,X                                  ; 008169 BF CD 81 00 
  JSL L_F84EC                                     ; 00816D 22 EC 84 0F 
  JSR.W RunGameScreen                                    ; 008171 20 D7 84 
  LDA.W CurrentRound                                     ; 008174 AD AB 05 
  BMI.B B_81C2                                    ; 008177 30 49 

; probably code to deal with winning the game?
.byte $9C,$AC,$05,$22,$14,$DE,$0E,$AD             ; 008179 ........ ???"????
.byte $08,$02,$D0,$18,$22,$7F,$DA,$0E             ; 008181 ........ ????"???
.byte $22,$E6,$E3,$0E,$22,$57,$E2,$0E             ; 008189 ........ "???"W??
.byte $A9,$02,$8D,$08,$02,$22,$F3,$DA             ; 008191 ........ ?????"??
.byte $0E,$4C,$E6,$80,$AE,$AB,$05,$E8             ; 008199 ........ ?L??????
.byte $E0,$03,$D0,$C1

RunGameCreditsScreen:
.byte $AD,$2F,$05,$D0             ; 0081A1 ........ ?????/??
.byte $15,$AD,$2E,$05,$F0,$05,$A9,$02             ; 0081A9 ........ ??.?????
.byte $8D,$30,$05,$22,$49,$E1,$0E,$AD             ; 0081B1 ........ ?0?"I???
.byte $30,$05,$C9,$02,$F0,$03,$4C,$E6             ; 0081B9 ........ 0?????L?
.byte $80                                         ; 0081C2 .        ?

B_81C2:
  JSL L_EE3E6                                     ; 0081C2 22 E6 E3 0E 
  JSL RunTitleHighscoreScreen                                     ; 0081C6 22 57 E2 0E 
  JMP.W GameScreenLoop                                    ; 0081CA 4C E6 80 

D_81CD:
.byte $01,$03,$04                                 ; 0081CE D..      ???


L_81D0:
  LDA.W $0204                                     ; 0081D0 AD 04 02 
  CLC                                             ; 0081D3 18 
  ADC.B #$04                                      ; 0081D4 69 04 
  STA.W $0533                                     ; 0081D6 8D 33 05 
  CLC                                             ; 0081D9 18 
  LDA.W $0206                                     ; 0081DA AD 06 02 
  ADC.B #$03                                      ; 0081DD 69 03 
  STA.W XexzyLivesCount                           ; 0081DF 8D 31 05 
  STA.W $0532                                     ; 0081E2 8D 32 05 
  LDX.B #$01                                      ; 0081E5 A2 01 
B_81E7:
  STZ.W $1897,X                                   ; 0081E7 9E 97 18 
  STZ.W $18B2,X                                   ; 0081EA 9E B2 18 
  STZ.W $1899,X                                   ; 0081ED 9E 99 18 
  STZ.W $189B,X                                   ; 0081F0 9E 9B 18 
  LDA.B #$09                                      ; 0081F3 A9 09 
  STA.W $18B0,X                                   ; 0081F5 9D B0 18 
  DEX                                             ; 0081F8 CA 
  BPL.B B_81E7                                    ; 0081F9 10 EC 
  STZ.W $0530                                     ; 0081FB 9C 30 05 
  STZ.W $05B0                                     ; 0081FE 9C B0 05 
  STZ.W $05B1                                     ; 008201 9C B1 05 
  LDA.W $0208                                     ; 008204 AD 08 02 
  LSR                                             ; 008207 4A 
  TAX                                             ; 008208 AA 
  LDA.L D_8226,X                                  ; 008209 BF 26 82 00 
  STA.W $189F                                     ; 00820D 8D 9F 18 
  LDA.L D_8229,X                                  ; 008210 BF 29 82 00 
  STA.W $18A0                                     ; 008214 8D A0 18 
  LDA.L D_822C,X                                  ; 008217 BF 2C 82 00 
  STA.W $18A1                                     ; 00821B 8D A1 18 
  LDA.L D_822F,X                                  ; 00821E BF 2F 82 00 
  STA.W $18A2                                     ; 008222 8D A2 18 
  RTS                                             ; 008225 60 


D_8226:
.byte $08,$06,$04                                 ; 008227 DD.      ???
D_8229:
.byte $0A,$07,$04                                 ; 00822A DD.      ???
D_822C:
.byte $0E,$0A,$06                                 ; 00822D DD.      ???
D_822F:
.byte $0D,$0A,$06                                 ; 008230 DD.      ???


L_8232:
  PHP                                             ; 008232 08 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 008233 C2 30 
  LDX.W #$8000                                    ; 008235 A2 00 80 
  LDA.W #$8000                                    ; 008238 A9 00 80 
  LDY.W #$0007                                    ; 00823B A0 07 00 
  JSL L_58000                                     ; 00823E 22 00 80 05 
  PLP                                             ; 008242 28 
  RTS                                             ; 008243 60 

; non-maskable interrupt handler
V_NMI:
  ; set 16 bit mode
  rep #P_Idx8Bit | P_Acc8Bit
  ; store away state from interrupted code
  pha
  phx
  phy
  phb
  php
  ; increment frame count
  inc FrameCounter
  ; enable data bank 0
  sep #P_Acc8Bit
  lda #0
  pha
  plb
  ; reset nmi
  lda RDNMI
  rep #P_Idx8Bit | P_Acc8Bit
  ; run the configured nmi handler for the game mode
  jsl @CallHandler
  sep #P_Acc8Bit
  ; clear pending state
  stz NMIPending
  ; restore interrupted state
  plp
  plb
  ply
  plx
  pla
  ; resume interrupted code
  rti
@CallHandler:
  jml [NMIHandlerLo]

V_IRQ:
  ; set 16 bit mode
  rep #P_Idx8Bit | P_Acc8Bit
  ; store away state from interrupted code
  pha
  phx
  phy
  php
  phb
  ; enable data bank 0
  sep #P_Acc8Bit
  lda #0
  pha
  plb
  lda TIMEUP
  rep #P_Acc8Bit
  ; run the configured irq handler for the game mode
  jsl @CallHandler
  ; restore interrupted state
  plb
  plp
  ply
  plx
  pla
  ; resume interrupted code
  rti
@CallHandler:
  jml [IRQHandlerLo]

V_RTI:
  rti

L_828A:
  STZ.W $05D3                                     ; 00828A 9C D3 05 
  LDA.B #$78                                      ; 00828D A9 78 
  STA.W $05D4                                     ; 00828F 8D D4 05 
  LDA.B #$20                                      ; 008292 A9 20 
  STA.W $18A7                                     ; 008294 8D A7 18 
  STZ.W $052C                                     ; 008297 9C 2C 05 
  STZ.W $05E1                                     ; 00829A 9C E1 05 
  STZ.W $05E3                                     ; 00829D 9C E3 05 
  STZ.W $05B2                                     ; 0082A0 9C B2 05 
  STZ.W $05B3                                     ; 0082A3 9C B3 05 
  STZ.W $05D3                                     ; 0082A6 9C D3 05 
  STZ.W $1873                                     ; 0082A9 9C 73 18 
  JSR.W L_C17B                                    ; 0082AC 20 7B C1 
  JSR.W L_97D3                                    ; 0082AF 20 D3 97 
  JSR.W L_A8D5                                    ; 0082B2 20 D5 A8 
  LDA.W CurrentRound                                     ; 0082B5 AD AB 05 
  CMP.B #$01                                      ; 0082B8 C9 01 
  BNE.B B_82C5                                    ; 0082BA D0 09 

.byte $AE,$AC,$05,$BD,$C5,$82,$8D,$8E             ; 0082BC ........ ????????
.byte $18                                         ; 0082C5 .        ?

B_82C5:
  RTS                                             ; 0082C5 60 


.byte $01,$02,$00,$00,$00,$00,$00,$00             ; 0082C6 ........ ????????
.byte $00,$00,$03,$00,$00,$00,$00,$00             ; 0082CE ........ ????????
.byte $03,$00,$00                                 ; 0082D7 ...      ???


L_82D9:
  PHP                                             ; 0082D9 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 0082DA E2 30 
  LDA.B #$80                                      ; 0082DC A9 80 
  STA.W INIDISP                                   ; 0082DE 8D 00 21 
  JSR.W L_A45F                                    ; 0082E1 20 5F A4 
  LDA.B #$02                                      ; 0082E4 A9 02 
  JSL LoadSceneInterruptConfiguration                                     ; 0082E6 22 AD CA 0E 
  LDX.B #$07                                      ; 0082EA A2 07 
B_82EC:
  STZ.W $05B4,X                                   ; 0082EC 9E B4 05 
  DEX                                             ; 0082EF CA 
  BPL.B B_82EC                                    ; 0082F0 10 FA 
  STZ.W $052C                                     ; 0082F2 9C 2C 05 
  LDA.B #$20                                      ; 0082F5 A9 20 
  STA.W $18A7                                     ; 0082F7 8D A7 18 
  STZ.W $05D8                                     ; 0082FA 9C D8 05 
  STZ.W $188E                                     ; 0082FD 9C 8E 18 
  LDA.B #$FF                                      ; 008300 A9 FF 
  STA.W $05CC                                     ; 008302 8D CC 05 
  STA.W $05CD                                     ; 008305 8D CD 05 
  LDX.B #$03                                      ; 008308 A2 03 
B_830A:
  STZ.W $18C9,X                                   ; 00830A 9E C9 18 
  STZ.W $18C1,X                                   ; 00830D 9E C1 18 
  STZ.W $18C5,X                                   ; 008310 9E C5 18 
  STZ.W $18CD,X                                   ; 008313 9E CD 18 
  DEX                                             ; 008316 CA 
  BPL.B B_830A                                    ; 008317 10 F1 
  JSR.W L_9961                                    ; 008319 20 61 99 
  JSR.W L_B032                                    ; 00831C 20 32 B0 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00831F E2 30 
  LDA.W CurrentRoom                                     ; 008321 AD AC 05 
  BNE.B B_8329                                    ; 008324 D0 03 
  JSR.W L_83CA                                    ; 008326 20 CA 83 
B_8329:
  LDA.B #$FF                                      ; 008329 A9 FF 
  STA.W $05CE                                     ; 00832B 8D CE 05 
  STZ.W XexzyDropCountDownTimer                   ; 00832E 9C AE 05 
  JSL AdvanceRNG                                     ; 008331 22 95 CA 0E 
  AND.B #$7F                                      ; 008335 29 7F 
  STA.W $05AF                                     ; 008337 8D AF 05 
  STZ.W $06CD                                     ; 00833A 9C CD 06 
  STZ.W $06CE                                     ; 00833D 9C CE 06 
  STZ.W $06D0                                     ; 008340 9C D0 06 
  STZ.W $06D1                                     ; 008343 9C D1 06 
  STZ.W $06C8                                     ; 008346 9C C8 06 
  STZ.W $06C9                                     ; 008349 9C C9 06 
  STZ.W $06CA                                     ; 00834C 9C CA 06 
  STZ.W $06CB                                     ; 00834F 9C CB 06 
  STZ.W $05D9                                     ; 008352 9C D9 05 
  STZ.W $0688                                     ; 008355 9C 88 06 
  STZ.W $05E5                                     ; 008358 9C E5 05 
  STZ.W $0632                                     ; 00835B 9C 32 06 
  STZ.W $0633                                     ; 00835E 9C 33 06 
  STZ.W $0634                                     ; 008361 9C 34 06 
  STZ.W $0635                                     ; 008364 9C 35 06 
  STZ.B $B4                                       ; 008367 64 B4 
  STZ.B $B5                                       ; 008369 64 B5 
  STZ.W $0528                                     ; 00836B 9C 28 05 
  STZ.W $0529                                     ; 00836E 9C 29 05 
  STZ.B $C6                                       ; 008371 64 C6 
  STZ.W $05A4                                     ; 008373 9C A4 05 
  STZ.W $05A5                                     ; 008376 9C A5 05 
  STZ.W $05D6                                     ; 008379 9C D6 05 
  STZ.W $05D7                                     ; 00837C 9C D7 05 
  JSR.W L_94A2                                    ; 00837F 20 A2 94 
  LDX.B #$01                                      ; 008382 A2 01 
  JSL L_ACE4                                      ; 008384 22 E4 AC 00 
  JSL L_F414                                      ; 008388 22 14 F4 00 
  LDA.B #$01                                      ; 00838C A9 01 
  STA.W $19D3                                     ; 00838E 8D D3 19 
  STA.W $19D4                                     ; 008391 8D D4 19 
  STA.W $19D5                                     ; 008394 8D D5 19 
  STA.W $19D6                                     ; 008397 8D D6 19 
  JSR.W L_99AE                                    ; 00839A 20 AE 99 
  JSL L_EF822                                     ; 00839D 22 22 F8 0E 
  JSR.W L_BF4E                                    ; 0083A1 20 4E BF 
  JSL L_AF0E                                      ; 0083A4 22 0E AF 00 
  LDA.W CurrentRound                                     ; 0083A8 AD AB 05 
  ASL                                             ; 0083AB 0A 
  TAX                                             ; 0083AC AA 
  REP.B #P_Acc8Bit                                      ; 0083AD C2 20 
  LDA.L D_83C4,X                                  ; 0083AF BF C4 83 00 
  STA.W $05A6                                     ; 0083B3 8D A6 05 
  LDX.B #$00                                      ; 0083B6 A2 00 
  JSL L_EF072                                     ; 0083B8 22 72 F0 0E 
  LDA.W #$0007                                    ; 0083BC A9 07 00 
  STA.W $02C2                                     ; 0083BF 8D C2 02 
  PLP                                             ; 0083C2 28 
  RTS                                             ; 0083C3 60 


D_83C4:
.byte $15,$CE,$B5,$D6,$B5,$DF                     ; 0083C5 DD....   ??????


L_83CA:
  PHP                                             ; 0083CA 08 
  REP.B #P_Acc8Bit                                      ; 0083CB C2 20 
  LDA.W #$8128                                    ; 0083CD A9 28 81 
  JSL L_F8401                                     ; 0083D0 22 01 84 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 0083D4 E2 30 
  JSL L_380F3                                     ; 0083D6 22 F3 80 03 
  LDA.B #$0D                                      ; 0083DA A9 0D 
  JSL L_38064                                     ; 0083DC 22 64 80 03 
  STY.W $18D2                                     ; 0083E0 8C D2 18 
  JSL L_38094                                     ; 0083E3 22 94 80 03 
  LDA.B #$01                                      ; 0083E7 A9 01 
  STA.W EntityHeader,X                                   ; 0083E9 9D D2 06 
  LDA.B #$0C                                      ; 0083EC A9 0C 
  STA.W EntityV1,X                                   ; 0083EE 9D 44 07 
  LDA.B #$00                                      ; 0083F1 A9 00 
  STA.W EntityV3,X                                   ; 0083F3 9D 28 08 
  LDA.B #$C4                                      ; 0083F6 A9 C4 
  STA.W EntityV29,X                                   ; 0083F8 9D BC 13 
  STZ.W EntityV23,X                                   ; 0083FB 9E 10 11 
  LDA.B #$04                                      ; 0083FE A9 04 
  STA.W EntityV25,X                                   ; 008400 9D F4 11 
  LDA.B #$01                                      ; 008403 A9 01 
  STA.W EntityV15,X                                   ; 008405 9D 80 0D 
  LDA.B #$06                                      ; 008408 A9 06 
  STA.W EntityV16,X                                   ; 00840A 9D F2 0D 
  LDA.B #$80                                      ; 00840D A9 80 
  STA.W XexzyCharX,X                              ; 00840F 9D 46 0B 
  LDA.B #$80                                      ; 008412 A9 80 
  STA.W EntityYPx,X                                   ; 008414 9D 9C 0C 
  LDA.W $18D2                                     ; 008417 AD D2 18 
  ASL                                             ; 00841A 0A 
  ORA.B #$29                                      ; 00841B 09 29 
  STA.W EntityV2,X                                   ; 00841D 9D B6 07 
  STA.W EntityV30,X                                   ; 008420 9D 2E 14 
  JSL L_AEBC                                      ; 008423 22 BC AE 00 
  TYA                                             ; 008427 98 
  STA.W EntityV31,X                                   ; 008428 9D A0 14 
  LDA.B #$01                                      ; 00842B A9 01 
  STA.W $175E,Y                                   ; 00842D 99 5E 17 
  JSL L_AED8                                      ; 008430 22 D8 AE 00 
  LDA.B #$0B                                      ; 008434 A9 0B 
  STA.B $1C                                       ; 008436 85 1C 
  LDA.B #$10                                      ; 008438 A9 10 
  STA.B $1D                                       ; 00843A 85 1D 
  JSL L_AFC2                                      ; 00843C 22 C2 AF 00 
  JSR.W L_84CC                                    ; 008440 20 CC 84 
  LDA.B #$72                                      ; 008443 A9 72 
  STA.B $04                                       ; 008445 85 04 
  LDA.B #$C8                                      ; 008447 A9 C8 
  STA.B $05                                       ; 008449 85 05 
  LDA.B #$01                                      ; 00844B A9 01 
  STA.B $06                                       ; 00844D 85 06 
  JSR.W L_8463                                    ; 00844F 20 63 84 
  LDA.B #$8D                                      ; 008452 A9 8D 
  STA.B $04                                       ; 008454 85 04 
  LDA.B #$CC                                      ; 008456 A9 CC 
  STA.B $05                                       ; 008458 85 05 
  LDA.B #$02                                      ; 00845A A9 02 
  STA.B $06                                       ; 00845C 85 06 
  JSR.W L_8463                                    ; 00845E 20 63 84 
  PLP                                             ; 008461 28 
  RTS                                             ; 008462 60 


L_8463:
  JSL L_380F3                                     ; 008463 22 F3 80 03 
  LDA.B #$0D                                      ; 008467 A9 0D 
  JSL L_38064                                     ; 008469 22 64 80 03 
  STY.W $18D2                                     ; 00846D 8C D2 18 
  JSL L_38094                                     ; 008470 22 94 80 03 
  LDA.B #$01                                      ; 008474 A9 01 
  STA.W EntityHeader,X                                   ; 008476 9D D2 06 
  LDA.B #$0D                                      ; 008479 A9 0D 
  STA.W EntityV1,X                                   ; 00847B 9D 44 07 
  LDA.B #$00                                      ; 00847E A9 00 
  STA.W EntityV3,X                                   ; 008480 9D 28 08 
  LDA.B $05                                       ; 008483 A5 05 
  STA.W EntityV29,X                                   ; 008485 9D BC 13 
  LDA.B $06                                       ; 008488 A5 06 
  STA.W EntityV23,X                                   ; 00848A 9D 10 11 
  STZ.W EntityV25,X                                   ; 00848D 9E F4 11 
  LDA.B #$28                                      ; 008490 A9 28 
  STA.W EntityV15,X                                   ; 008492 9D 80 0D 
  LDA.B $04                                       ; 008495 A5 04 
  STA.W XexzyCharX,X                              ; 008497 9D 46 0B 
  LDA.B #$22                                      ; 00849A A9 22 
  STA.W EntityYPx,X                                   ; 00849C 9D 9C 0C 
  LDA.W $18D2                                     ; 00849F AD D2 18 
  ASL                                             ; 0084A2 0A 
  ORA.B #$29                                      ; 0084A3 09 29 
  STA.W EntityV2,X                                   ; 0084A5 9D B6 07 
  STA.W EntityV30,X                                   ; 0084A8 9D 2E 14 
  JSL L_AEBC                                      ; 0084AB 22 BC AE 00 
  TYA                                             ; 0084AF 98 
  STA.W EntityV31,X                                   ; 0084B0 9D A0 14 
  LDA.B #$01                                      ; 0084B3 A9 01 
  STA.W $175E,Y                                   ; 0084B5 99 5E 17 
  JSL L_AED8                                      ; 0084B8 22 D8 AE 00 
  LDA.B #$05                                      ; 0084BC A9 05 
  STA.B $1C                                       ; 0084BE 85 1C 
  LDA.B #$10                                      ; 0084C0 A9 10 
  STA.B $1D                                       ; 0084C2 85 1D 
  JSL L_AFC2                                      ; 0084C4 22 C2 AF 00 
  JSR.W L_84CC                                    ; 0084C8 20 CC 84 
  RTS                                             ; 0084CB 60 


L_84CC:
  PHB                                             ; 0084CC 8B 
  LDA.B #$03                                      ; 0084CD A9 03 
  PHA                                             ; 0084CF 48 
  PLB                                             ; 0084D0 AB 
  JSL L_38F0B                                     ; 0084D1 22 0B 8F 03 
  PLB                                             ; 0084D5 AB 
  RTS                                             ; 0084D6 60 


RunGameScreen:
  PHP                                             ; 0084D7 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 0084D8 E2 30 
  JSR.W L_82D9                                    ; 0084DA 20 D9 82 
  LDA.B #$81                                      ; 0084DD A9 81 
  STA.W NMITIMEN                                  ; 0084DF 8D 00 42 
  JSL FadeScreenIn                                     ; 0084E2 22 1E CA 0E 
  JSL L_F81DA                                     ; 0084E6 22 DA 81 0F 
  LDX.B #$28                                      ; 0084EA A2 28 
  JSL WaitXFrames                                     ; 0084EC 22 72 C9 0E 
B_84F0:
  JSL Wait1Frame                                     ; 0084F0 22 13 CA 0E 
  JSL UpdateJoypadState                                     ; 0084F4 22 6A CA 0E 
  JSR.W L_E5ED                                    ; 0084F8 20 ED E5 
  JSR.W L_99AE                                    ; 0084FB 20 AE 99 
  JSR.W L_BF4E                                    ; 0084FE 20 4E BF 
  JSL L_9CB2                                      ; 008501 22 B2 9C 00 
  JSL L_3811E                                     ; 008505 22 1E 81 03 
  LDA.W EntityV1                                     ; 008509 AD 44 07 
  ORA.W EntityV1+1                                     ; 00850C 0D 45 07 
  BNE.B B_84F0                                    ; 00850F D0 DF 
  JSR.W L_914E                                    ; 008511 20 4E 91 
  LDA.B #$01                                      ; 008514 A9 01 
  STA.W $05D9                                     ; 008516 8D D9 05 
  LDA.B #$01                                      ; 008519 A9 01 
  STA.W NMIPending                                     ; 00851B 8D 2D 05 
B_851E:
  LDA.W NMIPending                                     ; 00851E AD 2D 05 
  BNE.B B_851E                                    ; 008521 D0 FB 
  INC.W NMIPending                                     ; 008523 EE 2D 05 
  INC.B $D2                                       ; 008526 E6 D2 
  JSL UpdateJoypadState                                     ; 008528 22 6A CA 0E 
  JSR.W L_B0F9                                    ; 00852C 20 F9 B0 
  LDA.B $D2                                       ; 00852F A5 D2 
  AND.W TurboModeActive                                     ; 008531 2D 2E 05 
  BEQ.B B_8539                                    ; 008534 F0 03 

.byte $20,$F9,$B0                                 ; 008537 ...       ??

B_8539:
  JSR.W L_E5ED                                    ; 008539 20 ED E5 
  JSR.W L_99AE                                    ; 00853C 20 AE 99 
  JSR.W L_BF4E                                    ; 00853F 20 4E BF 
  JSL L_9CB2                                      ; 008542 22 B2 9C 00 
  JSL L_3811E                                     ; 008546 22 1E 81 03 
  LDA.B $D2                                       ; 00854A A5 D2 
  AND.W TurboModeActive                                     ; 00854C 2D 2E 05 
  BEQ.B B_8555                                    ; 00854F F0 04 

.byte $22,$1E,$81,$03                             ; 008552 ....     "???

B_8555:
  JSL L_58267                                     ; 008555 22 67 82 05 
  LDA.W $05D3                                     ; 008559 AD D3 05 
  BNE.B B_856B                                    ; 00855C D0 0D 
  JSR.W L_C2B5                                    ; 00855E 20 B5 C2 
  LDA.B $D2                                       ; 008561 A5 D2 
  AND.W TurboModeActive                                     ; 008563 2D 2E 05 
  BEQ.B B_856B                                    ; 008566 F0 03 

.byte $20,$B5,$C2                                 ; 008569 ...       ??

B_856B:
  LDA.W $18A5                                     ; 00856B AD A5 18 
  BEQ.B B_857A                                    ; 00856E F0 0A 
  LDA.W $187C                                     ; 008570 AD 7C 18 
  BEQ.B B_857A                                    ; 008573 F0 05 
  LDX.B #$00                                      ; 008575 A2 00 
  JSR.W L_9856                                    ; 008577 20 56 98 
B_857A:
  LDA.W $18A6                                     ; 00857A AD A6 18 
  BEQ.B B_8589                                    ; 00857D F0 0A 
  LDA.W $187D                                     ; 00857F AD 7D 18 
  BEQ.B B_8589                                    ; 008582 F0 05 
  LDX.B #$01                                      ; 008584 A2 01 
  JSR.W L_9856                                    ; 008586 20 56 98 
B_8589:
  LDA.B #$00                                      ; 008589 A9 00 
  LDX.W $18A3                                     ; 00858B AE A3 18 
  BEQ.B B_8593                                    ; 00858E F0 03 
  ORA.W JoyPressed+1                                     ; 008590 0D 01 03 
B_8593:
  LDX.W $18A4                                     ; 008593 AE A4 18 
  BEQ.B B_859B                                    ; 008596 F0 03 
  ORA.W Joy2Pressed+1                                     ; 008598 0D 03 03 
B_859B:
  AND.B #$10                                      ; 00859B 29 10 
  BEQ.B B_85B5                                    ; 00859D F0 16 
  LDA.W $02C2                                     ; 00859F AD C2 02 
  PHA                                             ; 0085A2 48 
  JSL L_ED641                                     ; 0085A3 22 41 D6 0E 
  PLA                                             ; 0085A7 68 
  BEQ.B B_85B5                                    ; 0085A8 F0 0B 

.byte $A2,$26,$22,$72,$F0,$0E,$A9,$92             ; 0085AA ........ ?&"r????
.byte $8D,$C2,$02                                 ; 0085B3 ...      ???

B_85B5:
  LDA.W $1900                                     ; 0085B5 AD 00 19 
  ORA.W $06C6                                     ; 0085B8 0D C6 06 
  BNE.B B_85DB                                    ; 0085BB D0 1E 
  LDA.W $05D3                                     ; 0085BD AD D3 05 
  BNE.B B_85C7                                    ; 0085C0 D0 05 
  JSR.W L_95F3                                    ; 0085C2 20 F3 95 
  BRA.B B_85DB                                    ; 0085C5 80 14 
B_85C7:
  LDA.W $05D4                                     ; 0085C7 AD D4 05 
  BEQ.B B_85DB                                    ; 0085CA F0 0F 
  LDA.B $D2                                       ; 0085CC A5 D2 
  AND.B #$01                                      ; 0085CE 29 01 
  BNE.B B_85DB                                    ; 0085D0 D0 09 
  DEC.W $05D4                                     ; 0085D2 CE D4 05 
  BNE.B B_85DB                                    ; 0085D5 D0 04 

.byte $22,$36,$82,$0F                             ; 0085D8 ....     "6??

B_85DB:
  LDA.W $18AB                                     ; 0085DB AD AB 18 
  ORA.W $18AC                                     ; 0085DE 0D AC 18 
  BNE.B B_8645                                    ; 0085E1 D0 62 
  LDA.W $18A3                                     ; 0085E3 AD A3 18 
  BEQ.B B_85ED                                    ; 0085E6 F0 05 
  LDA.W $18A5                                     ; 0085E8 AD A5 18 
  BNE.B B_8645                                    ; 0085EB D0 58 
B_85ED:
  LDA.W $18A4                                     ; 0085ED AD A4 18 
  BEQ.B B_85F7                                    ; 0085F0 F0 05 
  LDA.W $18A6                                     ; 0085F2 AD A6 18 
  BNE.B B_8645                                    ; 0085F5 D0 4E 
B_85F7:
  JSR.W L_959E                                    ; 0085F7 20 9E 95 
  LDA.B $04                                       ; 0085FA A5 04 
  CMP.B #$02                                      ; 0085FC C9 02 
  BNE.B B_8610                                    ; 0085FE D0 10 
  LDA.W $05E1                                     ; 008600 AD E1 05 
  CMP.B #$03                                      ; 008603 C9 03 
  BNE.B B_8610                                    ; 008605 D0 09 
  JSR.W L_8B8A                                    ; 008607 20 8A 8B 
  JSR.W L_9061                                    ; 00860A 20 61 90 
  JMP.W B_851E                                    ; 00860D 4C 1E 85 
B_8610:
  JSR.W L_959E                                    ; 008610 20 9E 95 
  LDA.B $05                                       ; 008613 A5 05 
  CMP.B #$02                                      ; 008615 C9 02 
  BNE.B B_8633                                    ; 008617 D0 1A 
  JSR.W L_8B8A                                    ; 008619 20 8A 8B 
  JSR.W L_914E                                    ; 00861C 20 4E 91 
  LDA.W CurrentRoom                                     ; 00861F AD AC 05 
  BMI.B B_8627                                    ; 008622 30 03 
  JMP.W B_851E                                    ; 008624 4C 1E 85 
B_8627:
  STZ.W $02CB                                     ; 008627 9C CB 02 
  STZ.W $02C2                                     ; 00862A 9C C2 02 
  JSL FadeScreenOut                                     ; 00862D 22 32 CA 0E 
  PLP                                             ; 008631 28 
  RTS                                             ; 008632 60 

B_8633:
  JSR.W L_959E                                    ; 008633 20 9E 95 
  LDA.B $06                                       ; 008636 A5 06 
  CMP.B #$02                                      ; 008638 C9 02 
  BNE.B B_8645                                    ; 00863A D0 09 
  JSR.W L_8B8A                                    ; 00863C 20 8A 8B 
  JSR.W L_93A4                                    ; 00863F 20 A4 93 
  JMP.W B_851E                                    ; 008642 4C 1E 85 
B_8645:
  JSR.W L_8A07                                    ; 008645 20 07 8A 
  JSL L_F8177                                     ; 008648 22 77 81 0F 
  JSR.W L_9804                                    ; 00864C 20 04 98 
  LDX.B #$00                                      ; 00864F A2 00 
  JSL L_ACE4                                      ; 008651 22 E4 AC 00 
  JSR.W L_A2A8                                    ; 008655 20 A8 A2 
  JSR.W L_A3AB                                    ; 008658 20 AB A3 
  LDA.W CurrentRound                                     ; 00865B AD AB 05 
  BMI.B B_8627                                    ; 00865E 30 C7 
  JMP.W B_851E                                    ; 008660 4C 1E 85 

L_8663:
  PHP                                             ; 008663 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 008664 E2 30 
  JSR.W L_8B8A                                    ; 008666 20 8A 8B 
  JSL Wait1Frame                                     ; 008669 22 13 CA 0E 
  LDA.W CurrentRound                                     ; 00866D AD AB 05 
  ASL                                             ; 008670 0A 
  TAX                                             ; 008671 AA 
  STZ.W $1A86                                     ; 008672 9C 86 1A 
  STZ.W $1A7D                                     ; 008675 9C 7D 1A 
  LDA.B #$22                                      ; 008678 A9 22 
  STA.W $1A7E                                     ; 00867A 8D 7E 1A 
  LDA.L D_882D,X                                  ; 00867D BF 2D 88 00 
  STA.W $1A7F                                     ; 008681 8D 7F 1A 
  LDA.L D_882E,X                                  ; 008684 BF 2E 88 00 
  STA.W $1A80                                     ; 008688 8D 80 1A 
  LDA.B #$0D                                      ; 00868B A9 0D 
  STA.W $1A81                                     ; 00868D 8D 81 1A 
  LDA.B #$80                                      ; 008690 A9 80 
  STA.W $1A82                                     ; 008692 8D 82 1A 
  LDA.B #$01                                      ; 008695 A9 01 
  STA.W $1A83                                     ; 008697 8D 83 1A 
  JSL Wait1Frame                                     ; 00869A 22 13 CA 0E 
  JSR.W L_9013                                    ; 00869E 20 13 90 
  JSR.W L_8F93                                    ; 0086A1 20 93 8F 
  LDA.W CurrentRound                                     ; 0086A4 AD AB 05 
  ASL                                             ; 0086A7 0A 
  TAX                                             ; 0086A8 AA 
  REP.B #P_Acc8Bit                                      ; 0086A9 C2 20 
  LDA.L D_8827,X                                  ; 0086AB BF 27 88 00 
  REP.B #$10                                      ; 0086AF C2 10 
  LDX.W #$3BAE                                    ; 0086B1 A2 AE 3B 
  LDY.W #$000D                                    ; 0086B4 A0 0D 00 
  JSL L_58000                                     ; 0086B7 22 00 80 05 
  SEP.B #P_Acc8Bit                                      ; 0086BB E2 20 
  LDX.W #$4800                                    ; 0086BD A2 00 48 
  STX.W $1A99                                     ; 0086C0 8E 99 1A 
  LDX.W #$1801                                    ; 0086C3 A2 01 18 
  STX.W $1A92                                     ; 0086C6 8E 92 1A 
  LDX.W #$3BAE                                    ; 0086C9 A2 AE 3B 
  STX.W $1A94                                     ; 0086CC 8E 94 1A 
  LDA.B #$7E                                      ; 0086CF A9 7E 
  STA.W $1A96                                     ; 0086D1 8D 96 1A 
  LDX.W #$0800                                    ; 0086D4 A2 00 08 
  STX.W $1A97                                     ; 0086D7 8E 97 1A 
  LDA.B #$01                                      ; 0086DA A9 01 
  STA.W $1A91                                     ; 0086DC 8D 91 1A 
  JSL Wait1Frame                                     ; 0086DF 22 13 CA 0E 
  JSR.W L_8F93                                    ; 0086E3 20 93 8F 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 0086E6 C2 30 
  LDX.W #$3BAE                                    ; 0086E8 A2 AE 3B 
  LDA.W #$A32A                                    ; 0086EB A9 2A A3 
  LDY.W #$000D                                    ; 0086EE A0 0D 00 
  JSL L_58000                                     ; 0086F1 22 00 80 05 
  SEP.B #P_Acc8Bit                                      ; 0086F5 E2 20 
  LDX.W #$0000                                    ; 0086F7 A2 00 00 
  STX.W $1A99                                     ; 0086FA 8E 99 1A 
  LDX.W #$1801                                    ; 0086FD A2 01 18 
  STX.W $1A92                                     ; 008700 8E 92 1A 
  LDX.W #$3BAE                                    ; 008703 A2 AE 3B 
  STX.W $1A94                                     ; 008706 8E 94 1A 
  LDA.B #$7E                                      ; 008709 A9 7E 
  STA.W $1A96                                     ; 00870B 8D 96 1A 
  LDX.W #$1000                                    ; 00870E A2 00 10 
  STX.W $1A97                                     ; 008711 8E 97 1A 
  LDA.B #$01                                      ; 008714 A9 01 
  STA.W $1A91                                     ; 008716 8D 91 1A 
  JSL Wait1Frame                                     ; 008719 22 13 CA 0E 
  JSR.W L_8F93                                    ; 00871D 20 93 8F 
  LDX.W #$0800                                    ; 008720 A2 00 08 
  STX.W $1A99                                     ; 008723 8E 99 1A 
  LDX.W #$1801                                    ; 008726 A2 01 18 
  STX.W $1A92                                     ; 008729 8E 92 1A 
  LDX.W #$4BAE                                    ; 00872C A2 AE 4B 
  STX.W $1A94                                     ; 00872F 8E 94 1A 
  LDA.B #$7E                                      ; 008732 A9 7E 
  STA.W $1A96                                     ; 008734 8D 96 1A 
  LDX.W #$1000                                    ; 008737 A2 00 10 
  STX.W $1A97                                     ; 00873A 8E 97 1A 
  LDA.B #$01                                      ; 00873D A9 01 
  STA.W $1A91                                     ; 00873F 8D 91 1A 
  JSL Wait1Frame                                     ; 008742 22 13 CA 0E 
  JSR.W L_8F93                                    ; 008746 20 93 8F 
  LDX.W #$1000                                    ; 008749 A2 00 10 
  STX.W $1A99                                     ; 00874C 8E 99 1A 
  LDX.W #$1801                                    ; 00874F A2 01 18 
  STX.W $1A92                                     ; 008752 8E 92 1A 
  LDX.W #$5BAE                                    ; 008755 A2 AE 5B 
  STX.W $1A94                                     ; 008758 8E 94 1A 
  LDA.B #$7E                                      ; 00875B A9 7E 
  STA.W $1A96                                     ; 00875D 8D 96 1A 
  LDX.W #$1000                                    ; 008760 A2 00 10 
  STX.W $1A97                                     ; 008763 8E 97 1A 
  LDA.B #$01                                      ; 008766 A9 01 
  STA.W $1A91                                     ; 008768 8D 91 1A 
  JSL Wait1Frame                                     ; 00876B 22 13 CA 0E 
  JSR.W L_8F93                                    ; 00876F 20 93 8F 
  LDX.W #$1800                                    ; 008772 A2 00 18 
  STX.W $1A99                                     ; 008775 8E 99 1A 
  LDX.W #$1801                                    ; 008778 A2 01 18 
  STX.W $1A92                                     ; 00877B 8E 92 1A 
  LDX.W #$6BAE                                    ; 00877E A2 AE 6B 
  STX.W $1A94                                     ; 008781 8E 94 1A 
  LDA.B #$7E                                      ; 008784 A9 7E 
  STA.W $1A96                                     ; 008786 8D 96 1A 
  LDX.W #$1000                                    ; 008789 A2 00 10 
  STX.W $1A97                                     ; 00878C 8E 97 1A 
  LDA.B #$01                                      ; 00878F A9 01 
  STA.W $1A91                                     ; 008791 8D 91 1A 
  SEP.B #$10                                      ; 008794 E2 10 
  LDX.B #$22                                      ; 008796 A2 22 
  JSL L_EF072                                     ; 008798 22 72 F0 0E 
  LDA.B #$29                                      ; 00879C A9 29 
  STA.W $02C2                                     ; 00879E 8D C2 02 
  LDA.B #$39                                      ; 0087A1 A9 39 
  STA.W $02C4                                     ; 0087A3 8D C4 02 
  LDA.B #$80                                      ; 0087A6 A9 80 
  STA.W $06CD                                     ; 0087A8 8D CD 06 
  STZ.W $06CE                                     ; 0087AB 9C CE 06 
  STZ.W $06D0                                     ; 0087AE 9C D0 06 
  STZ.W $06D1                                     ; 0087B1 9C D1 06 
  JSL Wait1Frame                                     ; 0087B4 22 13 CA 0E 
  JSR.W L_8F93                                    ; 0087B8 20 93 8F 
  LDA.B #$49                                      ; 0087BB A9 49 
  STA.W BG1SC                                     ; 0087BD 8D 07 21 
  LDA.B #$17                                      ; 0087C0 A9 17 
  STA.W TM                                        ; 0087C2 8D 2C 21 
  LDA.B #$01                                      ; 0087C5 A9 01 
  STA.W $18AF                                     ; 0087C7 8D AF 18 
  LDX.B #$3D                                      ; 0087CA A2 3D 
B_87CC:
  PHX                                             ; 0087CC DA 
  JSL Wait1Frame                                     ; 0087CD 22 13 CA 0E 
  JSR.W L_8F93                                    ; 0087D1 20 93 8F 
  SEC                                             ; 0087D4 38 
  LDA.W $06CD                                     ; 0087D5 AD CD 06 
  SBC.B #$02                                      ; 0087D8 E9 02 
  STA.W $06CD                                     ; 0087DA 8D CD 06 
  PLX                                             ; 0087DD FA 
  DEX                                             ; 0087DE CA 
  BNE.B B_87CC                                    ; 0087DF D0 EB 
  LDX.B #$78                                      ; 0087E1 A2 78 
B_87E3:
  PHX                                             ; 0087E3 DA 
  JSL Wait1Frame                                     ; 0087E4 22 13 CA 0E 
  JSR.W L_8F93                                    ; 0087E8 20 93 8F 
  PLX                                             ; 0087EB FA 
  DEX                                             ; 0087EC CA 
  BNE.B B_87E3                                    ; 0087ED D0 F4 
  LDA.B #$4A                                      ; 0087EF A9 4A 
  STA.W BG1SC                                     ; 0087F1 8D 07 21 
  LDX.B #$74                                      ; 0087F4 A2 74 
B_87F6:
  PHX                                             ; 0087F6 DA 
  JSL Wait1Frame                                     ; 0087F7 22 13 CA 0E 
  JSR.W L_8F93                                    ; 0087FB 20 93 8F 
  SEC                                             ; 0087FE 38 
  LDA.W $06D0                                     ; 0087FF AD D0 06 
  SBC.B #$01                                      ; 008802 E9 01 
  STA.W $06D0                                     ; 008804 8D D0 06 
  LDA.W $06D1                                     ; 008807 AD D1 06 
  SBC.B #$00                                      ; 00880A E9 00 
  STA.W $06D1                                     ; 00880C 8D D1 06 
  PLX                                             ; 00880F FA 
  DEX                                             ; 008810 CA 
  BNE.B B_87F6                                    ; 008811 D0 E3 
  LDA.B #$16                                      ; 008813 A9 16 
  STA.W TM                                        ; 008815 8D 2C 21 
  JSR.W L_8B65                                    ; 008818 20 65 8B 
  JSL Wait1Frame                                     ; 00881B 22 13 CA 0E 
  STZ.W $02C2                                     ; 00881F 9C C2 02 
  STZ.W $18AF                                     ; 008822 9C AF 18 
  PLP                                             ; 008825 28 
  RTS                                             ; 008826 60 


D_8827:
.byte $D8,$BF,$AB,$C1,$8B,$C3                     ; 008828 DD....   ??????
D_882D:
.byte $72                                         ; 00882E D        r
D_882E:
.byte $C5,$F2,$C5,$72,$C6                         ; 00882F D....    ???r?


L_8833:
  PHP                                             ; 008833 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 008834 E2 30 
  PHB                                             ; 008836 8B 
  PEA.W $0000                                     ; 008837 F4 00 00 
  PLB                                             ; 00883A AB 
  PLB                                             ; 00883B AB 
  LDA.W CurrentRound                                     ; 00883C AD AB 05 
  ASL                                             ; 00883F 0A 
  TAY                                             ; 008840 A8 
  LDA.W D_88E3,Y                                  ; 008841 B9 E3 88 
  STA.B $04                                       ; 008844 85 04 
  LDA.W D_88E4,Y                                  ; 008846 B9 E4 88 
  STA.B $05                                       ; 008849 85 05 
  LDY.W CurrentRoom                                     ; 00884B AC AC 05 
  LDA.B ($04),Y                                   ; 00884E B1 04 
  BPL.B B_8855                                    ; 008850 10 03 
  PLB                                             ; 008852 AB 
  PLP                                             ; 008853 28 
  RTS                                             ; 008854 60 

B_8855:
  PHA                                             ; 008855 48 
  JSR.W L_8920                                    ; 008856 20 20 89 
  SEP.B #$10                                      ; 008859 E2 10 
  LDA.B #$01                                      ; 00885B A9 01 
  STA.W $18AF                                     ; 00885D 8D AF 18 
  LDX.B #$22                                      ; 008860 A2 22 
  JSL L_EF072                                     ; 008862 22 72 F0 0E 
  LDA.B #$29                                      ; 008866 A9 29 
  STA.W $02C2                                     ; 008868 8D C2 02 
  LDA.B #$80                                      ; 00886B A9 80 
  STA.W $06CD                                     ; 00886D 8D CD 06 
  STZ.W $06CE                                     ; 008870 9C CE 06 
  STZ.W $06D0                                     ; 008873 9C D0 06 
  STZ.W $06D1                                     ; 008876 9C D1 06 
  JSL Wait1Frame                                     ; 008879 22 13 CA 0E 
  LDA.B #$49                                      ; 00887D A9 49 
  STA.W BG1SC                                     ; 00887F 8D 07 21 
  LDA.B #$17                                      ; 008882 A9 17 
  STA.W TM                                        ; 008884 8D 2C 21 
  LDX.B #$3D                                      ; 008887 A2 3D 
B_8889:
  PHX                                             ; 008889 DA 
  JSL Wait1Frame                                     ; 00888A 22 13 CA 0E 
  SEC                                             ; 00888E 38 
  LDA.W $06CD                                     ; 00888F AD CD 06 
  SBC.B #$02                                      ; 008892 E9 02 
  STA.W $06CD                                     ; 008894 8D CD 06 
  PLX                                             ; 008897 FA 
  DEX                                             ; 008898 CA 
  BNE.B B_8889                                    ; 008899 D0 EE 
  PLA                                             ; 00889B 68 
  JSL L_EF57                                      ; 00889C 22 57 EF 00 
  LDA.B #$4A                                      ; 0088A0 A9 4A 
  STA.W BG1SC                                     ; 0088A2 8D 07 21 
  LDA.B #$04                                      ; 0088A5 A9 04 
  JSL L_ED0B9                                     ; 0088A7 22 B9 D0 0E 
  LDX.B #$74                                      ; 0088AB A2 74 
B_88AD:
  PHX                                             ; 0088AD DA 
  JSL Wait1Frame                                     ; 0088AE 22 13 CA 0E 
  JSR.W L_8F93                                    ; 0088B2 20 93 8F 
  JSL L_ED117                                     ; 0088B5 22 17 D1 0E 
  SEC                                             ; 0088B9 38 
  LDA.W $06D0                                     ; 0088BA AD D0 06 
  SBC.B #$01                                      ; 0088BD E9 01 
  STA.W $06D0                                     ; 0088BF 8D D0 06 
  LDA.W $06D1                                     ; 0088C2 AD D1 06 
  SBC.B #$00                                      ; 0088C5 E9 00 
  STA.W $06D1                                     ; 0088C7 8D D1 06 
  PLX                                             ; 0088CA FA 
  DEX                                             ; 0088CB CA 
  BNE.B B_88AD                                    ; 0088CC D0 DF 
  LDA.B #$16                                      ; 0088CE A9 16 
  STA.W TM                                        ; 0088D0 8D 2C 21 
  STZ.W $02C2                                     ; 0088D3 9C C2 02 
  STZ.W $18AF                                     ; 0088D6 9C AF 18 
  JSR.W L_8B65                                    ; 0088D9 20 65 8B 
  JSL Wait1Frame                                     ; 0088DC 22 13 CA 0E 
  PLB                                             ; 0088E0 AB 
  PLP                                             ; 0088E1 28 
  RTS                                             ; 0088E2 60 


D_88E3:
.byte $E9                                         ; 0088E4 D        ?
D_88E4:
.byte $88,$F5,$88,$08,$89,$00,$FF,$FF             ; 0088E4 D.....D. ????????
.byte $01,$FF,$03,$FF,$FF,$FF,$FF,$00             ; 0088EC D..DD.DD ????????
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF             ; 0088F4 D....... ????????
.byte $02,$FF,$00,$00,$FF,$03,$FF,$03             ; 0088FC ........ ????????
.byte $FF,$FF,$FF,$FF,$00,$FF,$FF,$FF             ; 008904 ........ ????????
.byte $FF,$FF,$FF,$03,$FF,$03,$00,$FF             ; 00890C ........ ????????
.byte $03,$FF,$03,$FF,$FF,$FF,$FF,$FF             ; 008914 ........ ????????
.byte $FF,$01,$03,$FF                             ; 00891D ....     ????


L_8920:
  PHP                                             ; 008920 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 008921 E2 30 
  JSL Wait1Frame                                     ; 008923 22 13 CA 0E 
  STZ.W $1A86                                     ; 008927 9C 86 1A 
  STZ.W $1A7D                                     ; 00892A 9C 7D 1A 
  LDA.B #$22                                      ; 00892D A9 22 
  STA.W $1A7E                                     ; 00892F 8D 7E 1A 
  LDA.B #$F2                                      ; 008932 A9 F2 
  STA.W $1A7F                                     ; 008934 8D 7F 1A 
  LDA.B #$C6                                      ; 008937 A9 C6 
  STA.W $1A80                                     ; 008939 8D 80 1A 
  LDA.B #$0D                                      ; 00893C A9 0D 
  STA.W $1A81                                     ; 00893E 8D 81 1A 
  LDA.B #$80                                      ; 008941 A9 80 
  STA.W $1A82                                     ; 008943 8D 82 1A 
  LDA.B #$01                                      ; 008946 A9 01 
  STA.W $1A83                                     ; 008948 8D 83 1A 
  JSL Wait1Frame                                     ; 00894B 22 13 CA 0E 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00894F C2 30 
  LDX.W #$3BAE                                    ; 008951 A2 AE 3B 
  LDA.W #$9663                                    ; 008954 A9 63 96 
  LDY.W #$000D                                    ; 008957 A0 0D 00 
  JSL L_58000                                     ; 00895A 22 00 80 05 
  SEP.B #P_Acc8Bit                                      ; 00895E E2 20 
  LDX.W #$0000                                    ; 008960 A2 00 00 
  STX.W $1A99                                     ; 008963 8E 99 1A 
  LDX.W #$1801                                    ; 008966 A2 01 18 
  STX.W $1A92                                     ; 008969 8E 92 1A 
  LDX.W #$3BAE                                    ; 00896C A2 AE 3B 
  STX.W $1A94                                     ; 00896F 8E 94 1A 
  LDA.B #$7E                                      ; 008972 A9 7E 
  STA.W $1A96                                     ; 008974 8D 96 1A 
  LDX.W #$1000                                    ; 008977 A2 00 10 
  STX.W $1A97                                     ; 00897A 8E 97 1A 
  LDA.B #$01                                      ; 00897D A9 01 
  STA.W $1A91                                     ; 00897F 8D 91 1A 
  JSL Wait1Frame                                     ; 008982 22 13 CA 0E 
  LDX.W #$0800                                    ; 008986 A2 00 08 
  STX.W $1A99                                     ; 008989 8E 99 1A 
  LDX.W #$1801                                    ; 00898C A2 01 18 
  STX.W $1A92                                     ; 00898F 8E 92 1A 
  LDX.W #$4BAE                                    ; 008992 A2 AE 4B 
  STX.W $1A94                                     ; 008995 8E 94 1A 
  LDA.B #$7E                                      ; 008998 A9 7E 
  STA.W $1A96                                     ; 00899A 8D 96 1A 
  LDX.W #$1000                                    ; 00899D A2 00 10 
  STX.W $1A97                                     ; 0089A0 8E 97 1A 
  LDA.B #$01                                      ; 0089A3 A9 01 
  STA.W $1A91                                     ; 0089A5 8D 91 1A 
  JSL Wait1Frame                                     ; 0089A8 22 13 CA 0E 
  LDX.W #$1000                                    ; 0089AC A2 00 10 
  STX.W $1A99                                     ; 0089AF 8E 99 1A 
  LDX.W #$1801                                    ; 0089B2 A2 01 18 
  STX.W $1A92                                     ; 0089B5 8E 92 1A 
  LDX.W #$5BAE                                    ; 0089B8 A2 AE 5B 
  STX.W $1A94                                     ; 0089BB 8E 94 1A 
  LDA.B #$7E                                      ; 0089BE A9 7E 
  STA.W $1A96                                     ; 0089C0 8D 96 1A 
  LDX.W #$1000                                    ; 0089C3 A2 00 10 
  STX.W $1A97                                     ; 0089C6 8E 97 1A 
  LDA.B #$01                                      ; 0089C9 A9 01 
  STA.W $1A91                                     ; 0089CB 8D 91 1A 
  JSL Wait1Frame                                     ; 0089CE 22 13 CA 0E 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 0089D2 C2 30 
  LDA.W #$BE0B                                    ; 0089D4 A9 0B BE 
  LDY.W #$000D                                    ; 0089D7 A0 0D 00 
  LDX.W #$20AE                                    ; 0089DA A2 AE 20 
  JSL L_58000                                     ; 0089DD 22 00 80 05 
  SEP.B #P_Acc8Bit                                      ; 0089E1 E2 20 
  LDX.W #$4800                                    ; 0089E3 A2 00 48 
  STX.W $1A99                                     ; 0089E6 8E 99 1A 
  LDX.W #$1801                                    ; 0089E9 A2 01 18 
  STX.W $1A92                                     ; 0089EC 8E 92 1A 
  LDX.W #$20AE                                    ; 0089EF A2 AE 20 
  STX.W $1A94                                     ; 0089F2 8E 94 1A 
  LDA.B #$7E                                      ; 0089F5 A9 7E 
  STA.W $1A96                                     ; 0089F7 8D 96 1A 
  LDX.W #$0800                                    ; 0089FA A2 00 08 
  STX.W $1A97                                     ; 0089FD 8E 97 1A 
  LDA.B #$01                                      ; 008A00 A9 01 
  STA.W $1A91                                     ; 008A02 8D 91 1A 
  PLP                                             ; 008A05 28 
  RTS                                             ; 008A06 60 


L_8A07:
  PHP                                             ; 008A07 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 008A08 E2 30 
  LDY.W $05B2                                     ; 008A0A AC B2 05 
  BEQ.B B_8A21                                    ; 008A0D F0 12 
  DEY                                             ; 008A0F 88 
  STY.W $05B2                                     ; 008A10 8C B2 05 
  BNE.B B_8A21                                    ; 008A13 D0 0C 
  LDX.B #$00                                      ; 008A15 A2 00 
  JSL L_AB23                                      ; 008A17 22 23 AB 00 
  LDX.B #$00                                      ; 008A1B A2 00 
  JSL L_ACB0                                      ; 008A1D 22 B0 AC 00 
B_8A21:
  LDY.W $05B3                                     ; 008A21 AC B3 05 
  BEQ.B B_8A38                                    ; 008A24 F0 12 
  DEY                                             ; 008A26 88 
  STY.W $05B3                                     ; 008A27 8C B3 05 
  BNE.B B_8A38                                    ; 008A2A D0 0C 
  LDX.B #$01                                      ; 008A2C A2 01 
  JSL L_AB23                                      ; 008A2E 22 23 AB 00 
  LDX.B #$01                                      ; 008A32 A2 01 
  JSL L_ACB0                                      ; 008A34 22 B0 AC 00 
B_8A38:
  PLP                                             ; 008A38 28 
  RTS                                             ; 008A39 60 


L_8A3A:
  PHP                                             ; 008A3A 08 
  PHB                                             ; 008A3B 8B 
  JSL Wait1Frame                                     ; 008A3C 22 13 CA 0E 
  REP.B #$10                                      ; 008A40 C2 10 
  SEP.B #P_Acc8Bit                                      ; 008A42 E2 20 
  LDA.B #$80                                      ; 008A44 A9 80 
  STA.W VMAIN                                     ; 008A46 8D 15 21 
  LDX.W #$5000                                    ; 008A49 A2 00 50 
  STX.W VMADDL                                    ; 008A4C 8E 16 21 
  LDX.W #$1801                                    ; 008A4F A2 01 18 
  STX.W DMAP1                                     ; 008A52 8E 10 43 
  LDX.W #$33AE                                    ; 008A55 A2 AE 33 
  STX.W A1T1L                                     ; 008A58 8E 12 43 
  LDA.B #$7E                                      ; 008A5B A9 7E 
  STA.W A1B1                                      ; 008A5D 8D 14 43 
  LDX.W #$0800                                    ; 008A60 A2 00 08 
  STX.W DAS1L                                     ; 008A63 8E 15 43 
  LDA.B #$02                                      ; 008A66 A9 02 
  STA.W MDMAEN                                    ; 008A68 8D 0B 42 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 008A6B E2 30 
  PLB                                             ; 008A6D AB 
  SEP.B #$10                                      ; 008A6E E2 10 
  LDA.B #$40                                      ; 008A70 A9 40 
  STA.W $1A86                                     ; 008A72 8D 86 1A 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 008A75 E2 30 
  STZ.W $02CB                                     ; 008A77 9C CB 02 
  LDA.W $05AD                                     ; 008A7A AD AD 05 
  CMP.B #$05                                      ; 008A7D C9 05 
  BEQ.B B_8A85                                    ; 008A7F F0 04 
  CMP.B #$06                                      ; 008A81 C9 06 
  BNE.B B_8A8F                                    ; 008A83 D0 0A 
B_8A85:
  LDA.B #$06                                      ; 008A85 A9 06 
  LDX.B #$D6                                      ; 008A87 A2 D6 
  LDY.B #$DE                                      ; 008A89 A0 DE 
  JSL L_EF164                                     ; 008A8B 22 64 F1 0E 
B_8A8F:
  LDA.B #$01                                      ; 008A8F A9 01 
  STA.W $1A83                                     ; 008A91 8D 83 1A 
  JSL Wait1Frame                                     ; 008A94 22 13 CA 0E 
  LDA.B #$80                                      ; 008A98 A9 80 
  STA.W CGADD                                     ; 008A9A 8D 21 21 
  LDY.B #$20                                      ; 008A9D A0 20 
  LDX.B #$00                                      ; 008A9F A2 00 
B_8AA1:
  LDA.L D_A7D5,X                                  ; 008AA1 BF D5 A7 00 
  STA.W CGDATA                                    ; 008AA5 8D 22 21 
  INX                                             ; 008AA8 E8 
  LDA.L D_A7D5,X                                  ; 008AA9 BF D5 A7 00 
  STA.W CGDATA                                    ; 008AAD 8D 22 21 
  INX                                             ; 008AB0 E8 
  DEY                                             ; 008AB1 88 
  BNE.B B_8AA1                                    ; 008AB2 D0 ED 
  LDA.B #$00                                      ; 008AB4 A9 00 
  STA.W $1A8F                                     ; 008AB6 8D 8F 1A 
  LDA.B #$20                                      ; 008AB9 A9 20 
  STA.W $1A90                                     ; 008ABB 8D 90 1A 
  JSL Wait1Frame                                     ; 008ABE 22 13 CA 0E 
  LDX.B #$03                                      ; 008AC2 A2 03 
B_8AC4:
  PHX                                             ; 008AC4 DA 
  LDA.B #$01                                      ; 008AC5 A9 01 
  STA.W $1A88                                     ; 008AC7 8D 88 1A 
  JSL Wait1Frame                                     ; 008ACA 22 13 CA 0E 
  CLC                                             ; 008ACE 18 
  LDA.W $1A8C                                     ; 008ACF AD 8C 1A 
  ADC.B #$10                                      ; 008AD2 69 10 
  STA.W $1A8C                                     ; 008AD4 8D 8C 1A 
  CLC                                             ; 008AD7 18 
  LDA.W $1A90                                     ; 008AD8 AD 90 1A 
  ADC.B #$08                                      ; 008ADB 69 08 
  STA.W $1A90                                     ; 008ADD 8D 90 1A 
  PLX                                             ; 008AE0 FA 
  DEX                                             ; 008AE1 CA 
  BPL.B B_8AC4                                    ; 008AE2 10 E0 
  STZ.W $06C8                                     ; 008AE4 9C C8 06 
  STZ.W $06C9                                     ; 008AE7 9C C9 06 
  STZ.W $06CA                                     ; 008AEA 9C CA 06 
  STZ.W $06CB                                     ; 008AED 9C CB 06 
  JSL Wait1Frame                                     ; 008AF0 22 13 CA 0E 
  JSR.W L_8833                                    ; 008AF4 20 33 88 
  JSL Wait1Frame                                     ; 008AF7 22 13 CA 0E 
  JSL CheckForEncounterRoom                                     ; 008AFB 22 19 C6 0E 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 008AFF E2 30 
  LDX.W CurrentRound                                     ; 008B01 AE AB 05 
  BEQ.B B_8B1B                                    ; 008B04 F0 15 

.byte $CA,$F0,$09,$AD,$AC,$05,$C9,$15             ; 008B06 ........ ????????
.byte $F0,$4B,$80,$10,$AD,$AC,$05,$C9             ; 008B0E ........ ?K??????
.byte $07,$F0,$42,$80,$07                         ; 008B17 .....    ??B??

B_8B1B:
  LDA.W CurrentRoom                                     ; 008B1B AD AC 05 
  CMP.B #$0A                                      ; 008B1E C9 0A 
  BEQ.B B_8B5B                                    ; 008B20 F0 39 
  JSR.W L_8B65                                    ; 008B22 20 65 8B 
  REP.B #$10                                      ; 008B25 C2 10 
  LDX.W #$1800                                    ; 008B27 A2 00 18 
  STX.W $1A99                                     ; 008B2A 8E 99 1A 
  LDX.W #$1801                                    ; 008B2D A2 01 18 
  STX.W $1A92                                     ; 008B30 8E 92 1A 
  LDX.W $05A6                                     ; 008B33 AE A6 05 
  STX.W $1A94                                     ; 008B36 8E 94 1A 
  LDA.B #$04                                      ; 008B39 A9 04 
  STA.W $1A96                                     ; 008B3B 8D 96 1A 
  LDX.W #$1000                                    ; 008B3E A2 00 10 
  STX.W $1A97                                     ; 008B41 8E 97 1A 
  LDA.B #$01                                      ; 008B44 A9 01 
  STA.W $1A91                                     ; 008B46 8D 91 1A 
  SEP.B #$10                                      ; 008B49 E2 10 
  JSL Wait1Frame                                     ; 008B4B 22 13 CA 0E 
  LDX.B #$00                                      ; 008B4F A2 00 
  JSL L_AB23                                      ; 008B51 22 23 AB 00 
  LDX.B #$01                                      ; 008B55 A2 01 
  JSL L_AB23                                      ; 008B57 22 23 AB 00 
B_8B5B:
  JSL L_AC95                                      ; 008B5B 22 95 AC 00 
  JSL Wait1Frame                                     ; 008B5F 22 13 CA 0E 
  PLP                                             ; 008B63 28 
  RTS                                             ; 008B64 60 


L_8B65:
  STZ.W $1A86                                     ; 008B65 9C 86 1A 
  STZ.W $1A7D                                     ; 008B68 9C 7D 1A 
  LDA.B #$22                                      ; 008B6B A9 22 
  STA.W $1A7E                                     ; 008B6D 8D 7E 1A 
  LDA.B #$83                                      ; 008B70 A9 83 
  STA.W $1A7F                                     ; 008B72 8D 7F 1A 
  LDA.B #$AA                                      ; 008B75 A9 AA 
  STA.W $1A80                                     ; 008B77 8D 80 1A 
  LDA.B #$09                                      ; 008B7A A9 09 
  STA.W $1A81                                     ; 008B7C 8D 81 1A 
  LDA.B #$80                                      ; 008B7F A9 80 
  STA.W $1A82                                     ; 008B81 8D 82 1A 
  LDA.B #$01                                      ; 008B84 A9 01 
  STA.W $1A83                                     ; 008B86 8D 83 1A 
  RTS                                             ; 008B89 60 


L_8B8A:
  PHP                                             ; 008B8A 08 
  JSL Wait1Frame                                     ; 008B8B 22 13 CA 0E 
  REP.B #$10                                      ; 008B8F C2 10 
  SEP.B #P_Acc8Bit                                      ; 008B91 E2 20 
  LDA.B #$80                                      ; 008B93 A9 80 
  STA.W VMAIN                                     ; 008B95 8D 15 21 
  LDX.W #$5000                                    ; 008B98 A2 00 50 
  STX.W VMADDL                                    ; 008B9B 8E 16 21 
  LDX.W #$1801                                    ; 008B9E A2 01 18 
  STX.W DMAP1                                     ; 008BA1 8E 10 43 
  LDX.W #$33AE                                    ; 008BA4 A2 AE 33 
  STX.W A1T1L                                     ; 008BA7 8E 12 43 
  LDA.B #$7E                                      ; 008BAA A9 7E 
  STA.W A1B1                                      ; 008BAC 8D 14 43 
  LDX.W #$0800                                    ; 008BAF A2 00 08 
  STX.W DAS1L                                     ; 008BB2 8E 15 43 
  LDA.B #$02                                      ; 008BB5 A9 02 
  STA.W MDMAEN                                    ; 008BB7 8D 0B 42 
  PLP                                             ; 008BBA 28 
  RTS                                             ; 008BBB 60 


L_8BBC:
  PHP                                             ; 008BBC 08 
  PHB                                             ; 008BBD 8B 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 008BBE E2 30 
  LDA.B #$00                                      ; 008BC0 A9 00 
  PHA                                             ; 008BC2 48 
  PLB                                             ; 008BC3 AB 
  LDX.W CurrentRound                                     ; 008BC4 AE AB 05 
  LDA.W D_8DF2,X                                  ; 008BC7 BD F2 8D 
  STA.B $04                                       ; 008BCA 85 04 
  LDA.W D_8DF5,X                                  ; 008BCC BD F5 8D 
  STA.B $05                                       ; 008BCF 85 05 
  LDY.W CurrentRoom                                     ; 008BD1 AC AC 05 
  LDA.B ($04),Y                                   ; 008BD4 B1 04 
  STA.W $05AD                                     ; 008BD6 8D AD 05 
  TAX                                             ; 008BD9 AA 
  LDA.W D_8DD0,X                                  ; 008BDA BD D0 8D 
  STA.W $05E2                                     ; 008BDD 8D E2 05 
  JSR.W L_A338                                    ; 008BE0 20 38 A3 
  LDA.W $05AD                                     ; 008BE3 AD AD 05 
  CMP.B #$05                                      ; 008BE6 C9 05 
  BEQ.B B_8BEE                                    ; 008BE8 F0 04 
  CMP.B #$06                                      ; 008BEA C9 06 
  BNE.B B_8BF8                                    ; 008BEC D0 0A 
B_8BEE:
  LDA.B #$06                                      ; 008BEE A9 06 
  LDX.B #$56                                      ; 008BF0 A2 56 
  LDY.B #$5E                                      ; 008BF2 A0 5E 
  JSL L_EF164                                     ; 008BF4 22 64 F1 0E 
B_8BF8:
  LDA.W $05AD                                     ; 008BF8 AD AD 05 
  ASL                                             ; 008BFB 0A 
  TAX                                             ; 008BFC AA 
  REP.B #P_Acc8Bit                                      ; 008BFD C2 20 
  LDA.W D_8E2F,X                                  ; 008BFF BD 2F 8E 
  STA.B $04                                       ; 008C02 85 04 
  LDA.W D_8E73,X                                  ; 008C04 BD 73 8E 
  STA.B $06                                       ; 008C07 85 06 
  REP.B #$10                                      ; 008C09 C2 10 
  LDX.W #$3BAE                                    ; 008C0B A2 AE 3B 
  LDA.B $04                                       ; 008C0E A5 04 
  LDY.B $06                                       ; 008C10 A4 06 
  JSL L_58000                                     ; 008C12 22 00 80 05 
  PHB                                             ; 008C16 8B 
  PEA.W $7E7E                                     ; 008C17 F4 7E 7E 
  PLB                                             ; 008C1A AB 
  PLB                                             ; 008C1B AB 
  SEP.B #P_Acc8Bit                                      ; 008C1C E2 20 
  LDA.W CurrentRound                                     ; 008C1E AD AB 05 
  CMP.B #$02                                      ; 008C21 C9 02 
  BNE.B B_8C2C                                    ; 008C23 D0 07 

.byte $AD,$AC,$05,$C9,$07,$F0,$49                 ; 008C26 .......  ??????I

B_8C2C:
  REP.B #P_Acc8Bit                                      ; 008C2C C2 20 
  SEP.B #$10                                      ; 008C2E E2 10 
  LDY.B #$0E                                      ; 008C30 A0 0E 
B_8C32:
  LDA.W $3BC6,Y                                   ; 008C32 B9 C6 3B 
  ORA.W #$2000                                    ; 008C35 09 00 20 
  STA.W $3BC6,Y                                   ; 008C38 99 C6 3B 
  LDA.W $3C06,Y                                   ; 008C3B B9 06 3C 
  ORA.W #$2000                                    ; 008C3E 09 00 20 
  STA.W $3C06,Y                                   ; 008C41 99 06 3C 
  LDA.W $4286,Y                                   ; 008C44 B9 86 42 
  ORA.W #$2000                                    ; 008C47 09 00 20 
  STA.W $4286,Y                                   ; 008C4A 99 86 42 
  LDA.W $42C6,Y                                   ; 008C4D B9 C6 42 
  ORA.W #$2000                                    ; 008C50 09 00 20 
  STA.W $42C6,Y                                   ; 008C53 99 C6 42 
  LDA.W DAS0H,Y                                   ; 008C56 B9 06 43 
  ORA.W #$2000                                    ; 008C59 09 00 20 
  STA.W DAS0H,Y                                   ; 008C5C 99 06 43 
  LDA.W DAS4H,Y                                   ; 008C5F B9 46 43 
  ORA.W #$2000                                    ; 008C62 09 00 20 
  STA.W DAS4H,Y                                   ; 008C65 99 46 43 
  LDA.W $4386,Y                                   ; 008C68 B9 86 43 
  ORA.W #$2000                                    ; 008C6B 09 00 20 
  STA.W $4386,Y                                   ; 008C6E 99 86 43 
  DEY                                             ; 008C71 88 
  DEY                                             ; 008C72 88 
  BPL.B B_8C32                                    ; 008C73 10 BD 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 008C75 C2 30 
  LDY.W #$07FE                                    ; 008C77 A0 FE 07 
B_8C7A:
  LDA.W $3BAE,Y                                   ; 008C7A B9 AE 3B 
  ORA.W #$1200                                    ; 008C7D 09 00 12 
  STA.W $33AE,Y                                   ; 008C80 99 AE 33 
  DEY                                             ; 008C83 88 
  DEY                                             ; 008C84 88 
  BPL.B B_8C7A                                    ; 008C85 10 F3 
  LDY.W #$000A                                    ; 008C87 A0 0A 00 
B_8C8A:
  LDA.W $3448,Y                                   ; 008C8A B9 48 34 
  STA.W $060E,Y                                   ; 008C8D 99 0E 06 
  LDA.W $3488,Y                                   ; 008C90 B9 88 34 
  STA.W $061A,Y                                   ; 008C93 99 1A 06 
  LDA.W $34C8,Y                                   ; 008C96 B9 C8 34 
  STA.W $0626,Y                                   ; 008C99 99 26 06 
  DEY                                             ; 008C9C 88 
  DEY                                             ; 008C9D 88 
  BPL.B B_8C8A                                    ; 008C9E 10 EA 
  SEP.B #P_Acc8Bit                                      ; 008CA0 E2 20 
  LDA.W $05E2                                     ; 008CA2 AD E2 05 
  BMI.B B_8CED                                    ; 008CA5 30 46 
  LDA.W $06C7                                     ; 008CA7 AD C7 06 
  CMP.B #$02                                      ; 008CAA C9 02 
  BEQ.B B_8CD2                                    ; 008CAC F0 24 
  LDY.W #$000A                                    ; 008CAE A0 0A 00 
B_8CB1:
  REP.B #P_Acc8Bit                                      ; 008CB1 C2 20 
  LDA.W $05EA,Y                                   ; 008CB3 B9 EA 05 
  AND.W #$EDFF                                    ; 008CB6 29 FF ED 
  STA.W $3C48,Y                                   ; 008CB9 99 48 3C 
  LDA.W $05F6,Y                                   ; 008CBC B9 F6 05 
  AND.W #$EDFF                                    ; 008CBF 29 FF ED 
  STA.W $3C88,Y                                   ; 008CC2 99 88 3C 
  LDA.W $0602,Y                                   ; 008CC5 B9 02 06 
  AND.W #$EDFF                                    ; 008CC8 29 FF ED 
  STA.W $3CC8,Y                                   ; 008CCB 99 C8 3C 
  DEY                                             ; 008CCE 88 
  DEY                                             ; 008CCF 88 
  BPL.B B_8CB1                                    ; 008CD0 10 DF 
B_8CD2:
  REP.B #P_Acc8Bit                                      ; 008CD2 C2 20 
  LDY.W #$000A                                    ; 008CD4 A0 0A 00 
B_8CD7:
  LDA.W $05EA,Y                                   ; 008CD7 B9 EA 05 
  STA.W $3448,Y                                   ; 008CDA 99 48 34 
  LDA.W $05F6,Y                                   ; 008CDD B9 F6 05 
  STA.W $3488,Y                                   ; 008CE0 99 88 34 
  LDA.W $0602,Y                                   ; 008CE3 B9 02 06 
  STA.W $34C8,Y                                   ; 008CE6 99 C8 34 
  DEY                                             ; 008CE9 88 
  DEY                                             ; 008CEA 88 
  BPL.B B_8CD7                                    ; 008CEB 10 EA 
B_8CED:
  PLB                                             ; 008CED AB 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 008CEE E2 30 
  JSL Wait1Frame                                     ; 008CF0 22 13 CA 0E 
  REP.B #$10                                      ; 008CF4 C2 10 
  SEP.B #P_Acc8Bit                                      ; 008CF6 E2 20 
  LDA.B #$80                                      ; 008CF8 A9 80 
  STA.W VMAIN                                     ; 008CFA 8D 15 21 
  LDX.W #$5400                                    ; 008CFD A2 00 54 
  STX.W VMADDL                                    ; 008D00 8E 16 21 
  LDX.W #$1801                                    ; 008D03 A2 01 18 
  STX.W DMAP1                                     ; 008D06 8E 10 43 
  LDX.W #$3BAE                                    ; 008D09 A2 AE 3B 
  STX.W A1T1L                                     ; 008D0C 8E 12 43 
  LDA.B #$7E                                      ; 008D0F A9 7E 
  STA.W A1B1                                      ; 008D11 8D 14 43 
  LDX.W #$0800                                    ; 008D14 A2 00 08 
  STX.W DAS1L                                     ; 008D17 8E 15 43 
  LDA.B #$02                                      ; 008D1A A9 02 
  STA.W MDMAEN                                    ; 008D1C 8D 0B 42 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 008D1F E2 30 
  LDX.W $05AD                                     ; 008D21 AE AD 05 
  STZ.W $1A86                                     ; 008D24 9C 86 1A 
  STZ.W $1A7D                                     ; 008D27 9C 7D 1A 
  LDA.B #$22                                      ; 008D2A A9 22 
  STA.W $1A7E                                     ; 008D2C 8D 7E 1A 
  LDA.W D_8EB7,X                                  ; 008D2F BD B7 8E 
  STA.B $04                                       ; 008D32 85 04 
  STA.W $1A7F                                     ; 008D34 8D 7F 1A 
  LDA.W D_8ED9,X                                  ; 008D37 BD D9 8E 
  STA.B $05                                       ; 008D3A 85 05 
  STA.W $1A80                                     ; 008D3C 8D 80 1A 
  LDA.W D_8EFB,X                                  ; 008D3F BD FB 8E 
  STA.W $1A81                                     ; 008D42 8D 81 1A 
  LDA.B #$80                                      ; 008D45 A9 80 
  STA.W $1A82                                     ; 008D47 8D 82 1A 
  LDA.B #$01                                      ; 008D4A A9 01 
  STA.W $1A83                                     ; 008D4C 8D 83 1A 
  LDA.W $05AD                                     ; 008D4F AD AD 05 
  CMP.B #$05                                      ; 008D52 C9 05 
  BEQ.B B_8D5A                                    ; 008D54 F0 04 
  CMP.B #$06                                      ; 008D56 C9 06 
  BNE.B B_8D6E                                    ; 008D58 D0 14 
B_8D5A:
  PHB                                             ; 008D5A 8B 
  LDA.W D_8EFB,X                                  ; 008D5B BD FB 8E 
  PHA                                             ; 008D5E 48 
  PLB                                             ; 008D5F AB 
  LDY.B #$7F                                      ; 008D60 A0 7F 
B_8D62:
  LDA.B ($04),Y                                   ; 008D62 B1 04 
  STA.W $1AF1,Y                                   ; 008D64 99 F1 1A 
  STA.W $1B71,Y                                   ; 008D67 99 71 1B 
  DEY                                             ; 008D6A 88 
  BPL.B B_8D62                                    ; 008D6B 10 F5 
  PLB                                             ; 008D6D AB 
B_8D6E:
  LDA.W D_8F1D,X                                  ; 008D6E BD 1D 8F 
  STA.B $04                                       ; 008D71 85 04 
  LDA.W D_8F3F,X                                  ; 008D73 BD 3F 8F 
  STA.B $05                                       ; 008D76 85 05 
  LDA.W D_8F61,X                                  ; 008D78 BD 61 8F 
  STA.B $06                                       ; 008D7B 85 06 
  LDA.B #$00                                      ; 008D7D A9 00 
  STA.W $1A8F                                     ; 008D7F 8D 8F 1A 
  LDA.B #$00                                      ; 008D82 A9 00 
  STA.W $1A90                                     ; 008D84 8D 90 1A 
  LDA.B #$01                                      ; 008D87 A9 01 
  STA.W $1A89                                     ; 008D89 8D 89 1A 
  LDA.B #$18                                      ; 008D8C A9 18 
  STA.W $1A8A                                     ; 008D8E 8D 8A 1A 
  LDA.B $04                                       ; 008D91 A5 04 
  STA.W $1A8B                                     ; 008D93 8D 8B 1A 
  LDA.B $05                                       ; 008D96 A5 05 
  STA.B $08                                       ; 008D98 85 08 
  STA.W $1A8C                                     ; 008D9A 8D 8C 1A 
  LDA.B $06                                       ; 008D9D A5 06 
  STA.W $1A8D                                     ; 008D9F 8D 8D 1A 
  JSL Wait1Frame                                     ; 008DA2 22 13 CA 0E 
  LDX.B #$03                                      ; 008DA6 A2 03 
B_8DA8:
  PHX                                             ; 008DA8 DA 
  LDA.B #$01                                      ; 008DA9 A9 01 
  STA.W $1A88                                     ; 008DAB 8D 88 1A 
  JSL Wait1Frame                                     ; 008DAE 22 13 CA 0E 
  CLC                                             ; 008DB2 18 
  LDA.W $1A8C                                     ; 008DB3 AD 8C 1A 
  ADC.B #$10                                      ; 008DB6 69 10 
  STA.W $1A8C                                     ; 008DB8 8D 8C 1A 
  CLC                                             ; 008DBB 18 
  LDA.W $1A90                                     ; 008DBC AD 90 1A 
  ADC.B #$08                                      ; 008DBF 69 08 
  STA.W $1A90                                     ; 008DC1 8D 90 1A 
  PLX                                             ; 008DC4 FA 
  DEX                                             ; 008DC5 CA 
  BPL.B B_8DA8                                    ; 008DC6 10 E0 
  LDA.B $08                                       ; 008DC8 A5 08 
  STA.W $1A8C                                     ; 008DCA 8D 8C 1A 
  PLB                                             ; 008DCD AB 
  PLP                                             ; 008DCE 28 
  RTS                                             ; 008DCF 60 


D_8DD0:
.byte $00,$00,$00,$FF,$00,$01,$FF,$00             ; 008DD0 DD.D.D.. ????????
.byte $00,$00,$01,$01,$01,$01,$01,$01             ; 008DD8 ........ ????????
.byte $01,$01,$01,$01,$02,$02,$02,$02             ; 008DE0 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$02,$02             ; 008DE8 ........ ????????
.byte $02,$02                                     ; 008DF1 ..       ??
D_8DF2:
.byte $F8,$04,$17                                 ; 008DF3 D..      ???
D_8DF5:
.byte $8D,$8E,$8E,$00,$00,$02,$00,$01             ; 008DF5 D...D.D. ????????
.byte $05,$00,$00,$01,$01,$03,$05,$00             ; 008DFD .DD.DDD. ????????
.byte $0B,$0D,$10,$12,$0A,$0C,$11,$0F             ; 008E05 ........ ????????
.byte $10,$05,$13,$05,$0F,$05,$10,$0A             ; 008E0D ........ ????????
.byte $0E,$10,$00,$14,$15,$17,$16,$20             ; 008E15 ........ ??????? 
.byte $1E,$21,$15,$14,$05,$1F,$05,$15             ; 008E1D ........ ?!??????
.byte $05,$14,$1F,$14,$16,$05,$05,$06             ; 008E25 ........ ????????
.byte $05,$05                                     ; 008E2E ..       ??
D_8E2F:
.byte $9C,$81,$18,$87,$9F,$8C,$1A,$92             ; 008E2F DDDD..DD ????????
.byte $00,$00,$75,$EC,$65,$F0,$00,$00             ; 008E37 ..DD.... ??u?e???
.byte $00,$00,$00,$00,$64,$99,$91,$9D             ; 008E3F ........ ????d???
.byte $A7,$A1,$AB,$A5,$C7,$A9,$AE,$AD             ; 008E47 ........ ????????
.byte $5B,$B1,$06,$B5,$AE,$AD,$BE,$B9             ; 008E4F ........ [???????
.byte $A3,$C2,$7F,$C7,$57,$CC,$9E,$D1             ; 008E57 ........ ????W???
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 008E5F ........ ????????
.byte $00,$00,$00,$00,$80,$D8,$FF,$DC             ; 008E67 ........ ????????
.byte $6F,$E1,$E6,$E5                             ; 008E70 ....     o???
D_8E73:
.byte $01,$00,$01,$00,$01,$00,$01,$00             ; 008E73 DDDD..DD ????????
.byte $00,$00,$01,$00,$01,$00,$00,$00             ; 008E7B ..DD.... ????????
.byte $00,$00,$00,$00,$01,$00,$01,$00             ; 008E83 ........ ????????
.byte $01,$00,$01,$00,$01,$00,$01,$00             ; 008E8B ........ ????????
.byte $01,$00,$01,$00,$01,$00,$01,$00             ; 008E93 ........ ????????
.byte $01,$00,$01,$00,$01,$00,$01,$00             ; 008E9B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 008EA3 ........ ????????
.byte $00,$00,$00,$00,$01,$00,$01,$00             ; 008EAB ........ ????????
.byte $01,$00,$01,$00                             ; 008EB4 ....     ????
D_8EB7:
.byte $64,$E4,$64,$E4,$00,$63,$E3,$00             ; 008EB7 DD.D.D.. d?d??c??
.byte $00,$00,$A3,$23,$A3,$23,$A3,$23             ; 008EBF ........ ???#?#?#
.byte $A3,$23,$A3,$23,$80,$00,$80,$00             ; 008EC7 ........ ?#?#????
.byte $00,$00,$00,$00,$00,$00,$75,$F5             ; 008ECF ........ ??????u?
.byte $75,$F5                                     ; 008ED8 ..       u?
D_8ED9:
.byte $97,$97,$98,$98,$00,$F4,$F4,$00             ; 008ED9 DD.D.D.. ????????
.byte $00,$00,$BD,$BE,$BE,$BF,$BF,$C0             ; 008EE1 ........ ????????
.byte $C0,$C1,$C1,$C2,$D6,$D7,$D7,$D8             ; 008EE9 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$EA,$EA             ; 008EF1 ........ ????????
.byte $EB,$EB                                     ; 008EFA ..       ??
D_8EFB:
.byte $01,$01,$01,$01,$00,$01,$01,$00             ; 008EFB DD.D.D.. ????????
.byte $00,$00,$01,$01,$01,$01,$01,$01             ; 008F03 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 008F0B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$01,$01             ; 008F13 ........ ????????
.byte $01,$01                                     ; 008F1C ..       ??
D_8F1D:
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 008F1D DD.D.D.. ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 008F25 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 008F2D ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 008F35 ........ ????????
.byte $00,$00                                     ; 008F3E ..       ??
D_8F3F:
.byte $40,$40,$40,$40,$00,$00,$00,$00             ; 008F3F DD.D.D.. @@@@????
.byte $00,$00,$40,$40,$40,$40,$40,$40             ; 008F47 ........ ??@@@@@@
.byte $40,$40,$40,$40,$40,$40,$40,$40             ; 008F4F ........ @@@@@@@@
.byte $00,$00,$00,$00,$00,$00,$80,$80             ; 008F57 ........ ????????
.byte $80,$80                                     ; 008F60 ..       ??
D_8F61:
.byte $7F,$7F,$7F,$7F,$00,$7F,$7F,$00             ; 008F61 DD.D.D.. ????????
.byte $00,$00,$7F,$7F,$7F,$7F,$7F,$7F             ; 008F69 ........ ????????
.byte $7F,$7F,$7F,$7F,$7F,$7F,$7F,$7F             ; 008F71 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$7F,$7F             ; 008F79 ........ ????????
.byte $7F,$7F                                     ; 008F82 ..       ??


L_8F83:
  INC.B $D2                                       ; 008F83 E6 D2 
  JSR.W L_E5ED                                    ; 008F85 20 ED E5 
  JSR.W L_99AE                                    ; 008F88 20 AE 99 
  JSL L_3811E                                     ; 008F8B 22 1E 81 03 
  JSR.W L_BF4E                                    ; 008F8F 20 4E BF 
  RTS                                             ; 008F92 60 


L_8F93:
  INC.B $D2                                       ; 008F93 E6 D2 
  JSR.W L_E5ED                                    ; 008F95 20 ED E5 
  JSR.W L_99AE                                    ; 008F98 20 AE 99 
  JSL L_3811E                                     ; 008F9B 22 1E 81 03 
  JSR.W L_BF4E                                    ; 008F9F 20 4E BF 
  RTS                                             ; 008FA2 60 


L_8FA3:
  STX.B $0A                                       ; 008FA3 86 0A 
  LDA.W D_9010,X                                  ; 008FA5 BD 10 90 
  STA.W $1893                                     ; 008FA8 8D 93 18 
  STA.W $1894                                     ; 008FAB 8D 94 18 
  STA.W $1895                                     ; 008FAE 8D 95 18 
  STA.W $1896                                     ; 008FB1 8D 96 18 
  LDA.B #$01                                      ; 008FB4 A9 01 
  STA.W $187C                                     ; 008FB6 8D 7C 18 
  STA.W $187D                                     ; 008FB9 8D 7D 18 
  LDX.B #$00                                      ; 008FBC A2 00 
  STZ.W $188A,X                                   ; 008FBE 9E 8A 18 
  STZ.W $1888,X                                   ; 008FC1 9E 88 18 
  LDY.B $0A                                       ; 008FC4 A4 0A 
  LDA.W D_900D,Y                                  ; 008FC6 B9 0D 90 
  JSL L_E5C0                                      ; 008FC9 22 C0 E5 00 
  LDX.B #$01                                      ; 008FCD A2 01 
  STZ.W $188A,X                                   ; 008FCF 9E 8A 18 
  STZ.W $1888,X                                   ; 008FD2 9E 88 18 
  LDY.B $0A                                       ; 008FD5 A4 0A 
  LDA.W D_900D,Y                                  ; 008FD7 B9 0D 90 
  JSL L_E5C0                                      ; 008FDA 22 C0 E5 00 
  LDA.W $1897                                     ; 008FDE AD 97 18 
  ASL                                             ; 008FE1 0A 
  ASL                                             ; 008FE2 0A 
  ASL                                             ; 008FE3 0A 
  CLC                                             ; 008FE4 18 
  ADC.W $1893                                     ; 008FE5 6D 93 18 
  TAX                                             ; 008FE8 AA 
  LDA.L D_B457,X                                  ; 008FE9 BF 57 B4 00 
  STA.W $1884                                     ; 008FED 8D 84 18 
  LDA.B #$01                                      ; 008FF0 A9 01 
  STA.W $19D3                                     ; 008FF2 8D D3 19 
  LDA.W $1898                                     ; 008FF5 AD 98 18 
  ASL                                             ; 008FF8 0A 
  ASL                                             ; 008FF9 0A 
  ASL                                             ; 008FFA 0A 
  CLC                                             ; 008FFB 18 
  ADC.W $1894                                     ; 008FFC 6D 94 18 
  TAX                                             ; 008FFF AA 
  LDA.L D_B457,X                                  ; 009000 BF 57 B4 00 
  STA.W $1885                                     ; 009004 8D 85 18 
  LDA.B #$01                                      ; 009007 A9 01 
  STA.W $19D4                                     ; 009009 8D D4 19 
  RTS                                             ; 00900C 60 


D_900D:
.byte $05,$03,$01                                 ; 00900E DDD      ???
D_9010:
.byte $04,$02,$00                                 ; 009011 DDD      ???


L_9013:
  LDX.B #$01                                      ; 009013 A2 01 
B_9015:
  STZ.W $18B4,X                                   ; 009015 9E B4 18 
  STZ.W $18B6,X                                   ; 009018 9E B6 18 
  STZ.W $18B8,X                                   ; 00901B 9E B8 18 
  STZ.W $18BA,X                                   ; 00901E 9E BA 18 
  DEX                                             ; 009021 CA 
  BPL.B B_9015                                    ; 009022 10 F1 
  LDX.W $1893                                     ; 009024 AE 93 18 
  LDA.W D_9059,X                                  ; 009027 BD 59 90 
  STA.W XexzyWalkAnimation                        ; 00902A 8D 86 18 
  LDA.B #$01                                      ; 00902D A9 01 
  STA.W $19D5                                     ; 00902F 8D D5 19 
  STA.W $1874                                     ; 009032 8D 74 18 
  STA.W $187C                                     ; 009035 8D 7C 18 
  STZ.W $1876                                     ; 009038 9C 76 18 
  STZ.W $187E                                     ; 00903B 9C 7E 18 
  LDX.W $1894                                     ; 00903E AE 94 18 
  LDA.W D_9059,X                                  ; 009041 BD 59 90 
  STA.W $1887                                     ; 009044 8D 87 18 
  LDA.B #$01                                      ; 009047 A9 01 
  STA.W $19D6                                     ; 009049 8D D6 19 
  STA.W $1875                                     ; 00904C 8D 75 18 
  STA.W $187D                                     ; 00904F 8D 7D 18 
  STZ.W $1877                                     ; 009052 9C 77 18 
  STZ.W $187F                                     ; 009055 9C 7F 18 
  RTS                                             ; 009058 60 


D_9059:
.byte $2D,$2C,$2B,$2A,$29,$2A,$2B,$2C             ; 009059 D.D.D... -,+*)*+,


L_9061:
  STZ.W $05D9                                     ; 009061 9C D9 05 
  STZ.W $06C7                                     ; 009064 9C C7 06 
  LDA.B #$01                                      ; 009067 A9 01 
  STA.W $05DE                                     ; 009069 8D DE 05 
  STA.W $05DF                                     ; 00906C 8D DF 05 
  STZ.W $06C8                                     ; 00906F 9C C8 06 
  STZ.W $06C9                                     ; 009072 9C C9 06 
  STZ.W $06CA                                     ; 009075 9C CA 06 
  STZ.W $06CB                                     ; 009078 9C CB 06 
  LDX.B #$01                                      ; 00907B A2 01 
B_907D:
  STZ.W $18B4,X                                   ; 00907D 9E B4 18 
  STZ.W $18B8,X                                   ; 009080 9E B8 18 
  STZ.W $18B6,X                                   ; 009083 9E B6 18 
  LDA.B #$01                                      ; 009086 A9 01 
  STA.W EntityV8,X                                   ; 009088 9D 62 0A 
  STA.W $18BA,X                                   ; 00908B 9D BA 18 
  DEX                                             ; 00908E CA 
  BPL.B B_907D                                    ; 00908F 10 EC 
  LDX.B #$00                                      ; 009091 A2 00 
  JSR.W L_8FA3                                    ; 009093 20 A3 8F 
  LDA.B #$52                                      ; 009096 A9 52 
  STA.W BG2SC                                     ; 009098 8D 08 21 
  LDA.B #$5A                                      ; 00909B A9 5A 
  STA.W BG3SC                                     ; 00909D 8D 09 21 
  JSR.W L_9568                                    ; 0090A0 20 68 95 
  JSL L_AC62                                      ; 0090A3 22 62 AC 00 
  JSR.W L_94E2                                    ; 0090A7 20 E2 94 
  JSR.W LocateCurrentRoomOffset                                    ; 0090AA 20 B7 97 
  LDA.B ($04),Y                                   ; 0090AD B1 04 
  STA.W CurrentRoom                                     ; 0090AF 8D AC 05 
  JSR.W L_828A                                    ; 0090B2 20 8A 82 
  JSR.W L_8BBC                                    ; 0090B5 20 BC 8B 
  JSL Wait1Frame                                     ; 0090B8 22 13 CA 0E 
  JSR.W L_E883                                    ; 0090BC 20 83 E8 
  LDX.B #$01                                      ; 0090BF A2 01 
  JSL L_ACE4                                      ; 0090C1 22 E4 AC 00 
B_90C5:
  JSR.W L_8F83                                    ; 0090C5 20 83 8F 
  JSL Wait1Frame                                     ; 0090C8 22 13 CA 0E 
  SEC                                             ; 0090CC 38 
  LDA.W $06CA                                     ; 0090CD AD CA 06 
  SBC.B #$02                                      ; 0090D0 E9 02 
  STA.W $06CA                                     ; 0090D2 8D CA 06 
  LDA.W $06CB                                     ; 0090D5 AD CB 06 
  SBC.B #$00                                      ; 0090D8 E9 00 
  STA.W $06CB                                     ; 0090DA 8D CB 06 
  LDA.W $06CA                                     ; 0090DD AD CA 06 
  BNE.B B_90C5                                    ; 0090E0 D0 E3 
  STZ.W $05DE                                     ; 0090E2 9C DE 05 
  STZ.W $05DF                                     ; 0090E5 9C DF 05 
  JSR.W L_8F83                                    ; 0090E8 20 83 8F 
  JSL Wait1Frame                                     ; 0090EB 22 13 CA 0E 
  LDX.B #$01                                      ; 0090EF A2 01 
  LDA.B #$FF                                      ; 0090F1 A9 FF 
B_90F3:
  STA.W EntityV8,X                                   ; 0090F3 9D 62 0A 
  STA.W $18BA,X                                   ; 0090F6 9D BA 18 
  DEX                                             ; 0090F9 CA 
  BPL.B B_90F3                                    ; 0090FA 10 F7 
  LDX.B #$30                                      ; 0090FC A2 30 
B_90FE:
  PHX                                             ; 0090FE DA 
  JSL Wait1Frame                                     ; 0090FF 22 13 CA 0E 
  JSR.W L_8F83                                    ; 009103 20 83 8F 
  PLX                                             ; 009106 FA 
  DEX                                             ; 009107 CA 
  BPL.B B_90FE                                    ; 009108 10 F4 
  LDX.B #$01                                      ; 00910A A2 01 
B_910C:
  STZ.W EntityV8,X                                   ; 00910C 9E 62 0A 
  STZ.W $18BA,X                                   ; 00910F 9E BA 18 
  DEX                                             ; 009112 CA 
  BPL.B B_910C                                    ; 009113 10 F7 
  JSL Wait1Frame                                     ; 009115 22 13 CA 0E 
  JSR.W L_9013                                    ; 009119 20 13 90 
  JSR.W L_8F83                                    ; 00911C 20 83 8F 
  LDX.B #$3C                                      ; 00911F A2 3C 
  JSL WaitXFrames                                     ; 009121 22 72 C9 0E 
  JSR.W L_94AB                                    ; 009125 20 AB 94 
  JSR.W L_E933                                    ; 009128 20 33 E9 
  LDX.B #$01                                      ; 00912B A2 01 
  JSL L_ACE4                                      ; 00912D 22 E4 AC 00 
  JSR.W L_8A3A                                    ; 009131 20 3A 8A 
  STZ.W EntityV8                                     ; 009134 9C 62 0A 
  STZ.W $0A63                                     ; 009137 9C 63 0A 
  JSL Wait1Frame                                     ; 00913A 22 13 CA 0E 
  LDA.B #$50                                      ; 00913E A9 50 
  STA.W BG2SC                                     ; 009140 8D 08 21 
  LDA.B #$58                                      ; 009143 A9 58 
  STA.W BG3SC                                     ; 009145 8D 09 21 
  LDA.B #$01                                      ; 009148 A9 01 
  STA.W $05D9                                     ; 00914A 8D D9 05 
  RTS                                             ; 00914D 60 


L_914E:
  LDA.B #$01                                      ; 00914E A9 01 
  STA.W $06C7                                     ; 009150 8D C7 06 
  STA.W $05DE                                     ; 009153 8D DE 05 
  STA.W $05DF                                     ; 009156 8D DF 05 
  STZ.W $06C8                                     ; 009159 9C C8 06 
  STZ.W $06C9                                     ; 00915C 9C C9 06 
  STZ.W $06CA                                     ; 00915F 9C CA 06 
  STZ.W $06CB                                     ; 009162 9C CB 06 
  LDX.B #$01                                      ; 009165 A2 01 
B_9167:
  STZ.W $18B4,X                                   ; 009167 9E B4 18 
  STZ.W $18B8,X                                   ; 00916A 9E B8 18 
  STZ.W $18BA,X                                   ; 00916D 9E BA 18 
  LDA.B #$FF                                      ; 009170 A9 FF 
  STA.W EntityV6,X                                   ; 009172 9D 7E 09 
  STA.W $18B6,X                                   ; 009175 9D B6 18 
  DEX                                             ; 009178 CA 
  BPL.B B_9167                                    ; 009179 10 EC 
  LDX.B #$01                                      ; 00917B A2 01 
  JSR.W L_8FA3                                    ; 00917D 20 A3 8F 
  LDA.B #$51                                      ; 009180 A9 51 
  STA.W BG2SC                                     ; 009182 8D 08 21 
  LDA.B #$59                                      ; 009185 A9 59 
  STA.W BG3SC                                     ; 009187 8D 09 21 
  JSR.W L_9568                                    ; 00918A 20 68 95 
  JSL L_AC62                                      ; 00918D 22 62 AC 00 
  JSR.W L_94E2                                    ; 009191 20 E2 94 
  JSR.W LocateCurrentRoomOffset                                    ; 009194 20 B7 97 
  INY                                             ; 009197 C8 
  LDA.B ($04),Y                                   ; 009198 B1 04 
  STA.W CurrentRoom                                     ; 00919A 8D AC 05 
  BPL.B B_91A3                                    ; 00919D 10 04 

.byte $20,$47,$93,$60                             ; 0091A0 ....      G?`

B_91A3:
  LDA.W DemoRunning                                     ; 0091A3 AD F1 1B 
  BEQ.B B_91AD                                    ; 0091A6 F0 05 
  LDA.B #$07                                      ; 0091A8 A9 07 
  STA.W CurrentRoom                                     ; 0091AA 8D AC 05 
B_91AD:
  LDA.W CurrentRound                                     ; 0091AD AD AB 05 
  CMP.B #$02                                      ; 0091B0 C9 02 
  BNE.B B_91C7                                    ; 0091B2 D0 13 

.byte $AD,$AC,$05,$C9,$14,$D0,$0C,$AD             ; 0091B4 ........ ????????
.byte $B1,$05,$C9,$0A,$B0,$05,$A9,$17             ; 0091BC ........ ????????
.byte $8D,$AC,$05                                 ; 0091C5 ...      ???

B_91C7:
  LDA.B #$F3                                      ; 0091C7 A9 F3 
  STA.W $05DA                                     ; 0091C9 8D DA 05 
  LDA.B #$FF                                      ; 0091CC A9 FF 
  STA.W $05DB                                     ; 0091CE 8D DB 05 
  LDA.B #$0C                                      ; 0091D1 A9 0C 
  STA.W $05DC                                     ; 0091D3 8D DC 05 
  LDA.B #$01                                      ; 0091D6 A9 01 
  STA.W $05DD                                     ; 0091D8 8D DD 05 
  LDA.B #$80                                      ; 0091DB A9 80 
  STA.W $05D9                                     ; 0091DD 8D D9 05 
  JSR.W L_828A                                    ; 0091E0 20 8A 82 
  JSR.W L_8BBC                                    ; 0091E3 20 BC 8B 
  JSL Wait1Frame                                     ; 0091E6 22 13 CA 0E 
  JSL UpdateJoypadState                                     ; 0091EA 22 6A CA 0E 
  JSR.W L_E883                                    ; 0091EE 20 83 E8 
  LDX.B #$01                                      ; 0091F1 A2 01 
  JSL L_ACE4                                      ; 0091F3 22 E4 AC 00 
B_91F7:
  JSR.W L_8F83                                    ; 0091F7 20 83 8F 
  JSL Wait1Frame                                     ; 0091FA 22 13 CA 0E 
  JSL UpdateJoypadState                                     ; 0091FE 22 6A CA 0E 
  JSR.W L_9374                                    ; 009202 20 74 93 
  LDA.W DemoRunning                                     ; 009205 AD F1 1B 
  BNE.B B_9211                                    ; 009208 D0 07 
  LDA.W CurrentRoom                                     ; 00920A AD AC 05 
  CMP.B #$01                                      ; 00920D C9 01 
  BNE.B B_9222                                    ; 00920F D0 11 
B_9211:
  CLC                                             ; 009211 18 
  LDA.W $06CC                                     ; 009212 AD CC 06 
  ADC.B #$80                                      ; 009215 69 80 
  STA.W $06CC                                     ; 009217 8D CC 06 
  LDA.W $06CD                                     ; 00921A AD CD 06 
  ADC.B #$02                                      ; 00921D 69 02 
  STA.W $06CD                                     ; 00921F 8D CD 06 
B_9222:
  CLC                                             ; 009222 18 
  LDA.W $06C8                                     ; 009223 AD C8 06 
  ADC.B #$02                                      ; 009226 69 02 
  STA.W $06C8                                     ; 009228 8D C8 06 
  LDA.W $06C9                                     ; 00922B AD C9 06 
  ADC.B #$00                                      ; 00922E 69 00 
  STA.W $06C9                                     ; 009230 8D C9 06 
  BEQ.B B_91F7                                    ; 009233 F0 C2 
  STZ.W $05DE                                     ; 009235 9C DE 05 
  STZ.W $05DF                                     ; 009238 9C DF 05 
  JSR.W L_8F83                                    ; 00923B 20 83 8F 
  JSL Wait1Frame                                     ; 00923E 22 13 CA 0E 
  JSL UpdateJoypadState                                     ; 009242 22 6A CA 0E 
  LDA.W CurrentRoom                                     ; 009246 AD AC 05 
  BPL.B B_924E                                    ; 009249 10 03 

.byte $4C,$10,$93                                 ; 00924C ...      L??

B_924E:
  LDX.B #$01                                      ; 00924E A2 01 
  LDA.B #$01                                      ; 009250 A9 01 
B_9252:
  STA.W EntityV6,X                                   ; 009252 9D 7E 09 
  STA.W $18B6,X                                   ; 009255 9D B6 18 
  DEX                                             ; 009258 CA 
  BPL.B B_9252                                    ; 009259 10 F7 
  LDX.B #$1C                                      ; 00925B A2 1C 
B_925D:
  PHX                                             ; 00925D DA 
  JSL Wait1Frame                                     ; 00925E 22 13 CA 0E 
  JSL UpdateJoypadState                                     ; 009262 22 6A CA 0E 
  JSR.W L_8F83                                    ; 009266 20 83 8F 
  LDA.W CurrentRoom                                     ; 009269 AD AC 05 
  CMP.B #$01                                      ; 00926C C9 01 
  BNE.B B_927E                                    ; 00926E D0 0E 
  SEC                                             ; 009270 38 
  LDA.W $06D0                                     ; 009271 AD D0 06 
  SBC.B #$01                                      ; 009274 E9 01 
  STA.W $06D0                                     ; 009276 8D D0 06 
  BCS.B B_927E                                    ; 009279 B0 03 
  DEC.W $06D1                                     ; 00927B CE D1 06 
B_927E:
  PLX                                             ; 00927E FA 
  DEX                                             ; 00927F CA 
  BPL.B B_925D                                    ; 009280 10 DB 
  LDX.B #$01                                      ; 009282 A2 01 
B_9284:
  STZ.W EntityV6,X                                   ; 009284 9E 7E 09 
  STZ.W $18B6,X                                   ; 009287 9E B6 18 
  DEX                                             ; 00928A CA 
  BPL.B B_9284                                    ; 00928B 10 F7 
  JSL Wait1Frame                                     ; 00928D 22 13 CA 0E 
  JSL UpdateJoypadState                                     ; 009291 22 6A CA 0E 
  JSR.W L_9013                                    ; 009295 20 13 90 
  JSR.W L_8F83                                    ; 009298 20 83 8F 
  LDA.W DemoRunning                                     ; 00929B AD F1 1B 
  BNE.B B_92A7                                    ; 00929E D0 07 
  LDA.W CurrentRoom                                     ; 0092A0 AD AC 05 
  CMP.B #$01                                      ; 0092A3 C9 01 
  BNE.B B_92D3                                    ; 0092A5 D0 2C 
B_92A7:
  SEC                                             ; 0092A7 38 
  LDA.W $06D0                                     ; 0092A8 AD D0 06 
  SBC.B #$01                                      ; 0092AB E9 01 
  STA.W $06D0                                     ; 0092AD 8D D0 06 
  BCS.B B_92B5                                    ; 0092B0 B0 03 
  DEC.W $06D1                                     ; 0092B2 CE D1 06 
B_92B5:
  JSL Wait1Frame                                     ; 0092B5 22 13 CA 0E 
  JSL UpdateJoypadState                                     ; 0092B9 22 6A CA 0E 
  LDA.W $06D0                                     ; 0092BD AD D0 06 
  CMP.B #$32                                      ; 0092C0 C9 32 
  BCS.B B_92A7                                    ; 0092C2 B0 E3 
  JSL Wait1Frame                                     ; 0092C4 22 13 CA 0E 
  JSL UpdateJoypadState                                     ; 0092C8 22 6A CA 0E 
  LDA.B #$16                                      ; 0092CC A9 16 
  STA.W TM                                        ; 0092CE 8D 2C 21 
  BRA.B B_92D9                                    ; 0092D1 80 06 
B_92D3:
  LDX.B #$3C                                      ; 0092D3 A2 3C 
  JSL WaitXFrames                                     ; 0092D5 22 72 C9 0E 
B_92D9:
  JSR.W L_94AB                                    ; 0092D9 20 AB 94 
  JSR.W L_E933                                    ; 0092DC 20 33 E9 
  LDX.B #$00                                      ; 0092DF A2 00 
  JSL L_ACE4                                      ; 0092E1 22 E4 AC 00 
  LDA.B #$01                                      ; 0092E5 A9 01 
  STA.W $05D9                                     ; 0092E7 8D D9 05 
  JSR.W L_8A3A                                    ; 0092EA 20 3A 8A 
  LDA.W CurrentRound                                     ; 0092ED AD AB 05 
  CMP.B #$02                                      ; 0092F0 C9 02 
  BNE.B B_92FE                                    ; 0092F2 D0 0A 

.byte $AD,$AC,$05,$C9,$13,$D0,$03,$20             ; 0092F4 ........ ??????? 
.byte $11,$93                                     ; 0092FD ..       ??

B_92FE:
  JSL Wait1Frame                                     ; 0092FE 22 13 CA 0E 
  JSL UpdateJoypadState                                     ; 009302 22 6A CA 0E 
  LDA.B #$50                                      ; 009306 A9 50 
  STA.W BG2SC                                     ; 009308 8D 08 21 
  LDA.B #$58                                      ; 00930B A9 58 
  STA.W BG3SC                                     ; 00930D 8D 09 21 
  RTS                                             ; 009310 60 


L_9311:
  PHP                                             ; 009311 08 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 009312 C2 30 
  LDX.W #$3BAE                                    ; 009314 A2 AE 3B 
  LDA.W #$E067                                    ; 009317 A9 67 E0 
  LDY.W #$000D                                    ; 00931A A0 0D 00 
  JSL L_58000                                     ; 00931D 22 00 80 05 
  SEP.B #P_Acc8Bit                                      ; 009321 E2 20 
  LDX.W #$7800                                    ; 009323 A2 00 78 
  STX.W $1A99                                     ; 009326 8E 99 1A 
  LDX.W #$1801                                    ; 009329 A2 01 18 
  STX.W $1A92                                     ; 00932C 8E 92 1A 
  LDX.W #$3BAE                                    ; 00932F A2 AE 3B 
  STX.W $1A94                                     ; 009332 8E 94 1A 
  LDA.B #$7E                                      ; 009335 A9 7E 
  STA.W $1A96                                     ; 009337 8D 96 1A 
  LDX.W #$1000                                    ; 00933A A2 00 10 
  STX.W $1A97                                     ; 00933D 8E 97 1A 
  LDA.B #$01                                      ; 009340 A9 01 
  STA.W $1A91                                     ; 009342 8D 91 1A 
  PLP                                             ; 009345 28 
  RTS                                             ; 009346 60 


.byte $A2,$01,$A9,$01,$9D,$7E,$09,$9D             ; 009347 ........ ?????~??
.byte $B6,$18,$CA,$10,$F7,$A2,$20,$DA             ; 00934F ........ ?????? ?
.byte $22,$13,$CA,$0E,$20,$83,$8F,$FA             ; 009357 ........ "??? ???
.byte $CA,$D0,$F4,$A2,$01,$9E,$7E,$09             ; 00935F ........ ??????~?
.byte $9E,$B6,$18,$CA,$10,$F7,$A2,$1E             ; 009367 ........ ????????
.byte $22,$72,$C9,$0E,$60                         ; 009370 .....    "r??`


L_9374:
  SEC                                             ; 009374 38 
  LDA.W $05DA                                     ; 009375 AD DA 05 
  BEQ.B B_937F                                    ; 009378 F0 05 
  SBC.B #$02                                      ; 00937A E9 02 
  STA.W $05DA                                     ; 00937C 8D DA 05 
B_937F:
  LDA.W $05DB                                     ; 00937F AD DB 05 
  BEQ.B B_939C                                    ; 009382 F0 18 
  SEC                                             ; 009384 38 
  LDA.W $05DC                                     ; 009385 AD DC 05 
  SBC.B #$02                                      ; 009388 E9 02 
  STA.W $05DC                                     ; 00938A 8D DC 05 
  LDA.W $05DD                                     ; 00938D AD DD 05 
  SBC.B #$00                                      ; 009390 E9 00 
  STA.W $05DD                                     ; 009392 8D DD 05 
  BEQ.B B_939D                                    ; 009395 F0 06 
  LDA.B #$FF                                      ; 009397 A9 FF 
  STA.W $05DB                                     ; 009399 8D DB 05 
B_939C:
  RTS                                             ; 00939C 60 

B_939D:
  LDA.W $05DC                                     ; 00939D AD DC 05 
  STA.W $05DB                                     ; 0093A0 8D DB 05 
  RTS                                             ; 0093A3 60 


L_93A4:
  STZ.W $05D9                                     ; 0093A4 9C D9 05 
  LDA.B #$02                                      ; 0093A7 A9 02 
  STA.W $06C7                                     ; 0093A9 8D C7 06 
  LDA.B #$01                                      ; 0093AC A9 01 
  STA.W $05DE                                     ; 0093AE 8D DE 05 
  STA.W $05DF                                     ; 0093B1 8D DF 05 
  STZ.W $06C8                                     ; 0093B4 9C C8 06 
  STZ.W $06C9                                     ; 0093B7 9C C9 06 
  STZ.W $06CA                                     ; 0093BA 9C CA 06 
  STZ.W $06CB                                     ; 0093BD 9C CB 06 
  LDX.B #$01                                      ; 0093C0 A2 01 
B_93C2:
  STZ.W $18B4,X                                   ; 0093C2 9E B4 18 
  STZ.W $18B8,X                                   ; 0093C5 9E B8 18 
  STZ.W $18B6,X                                   ; 0093C8 9E B6 18 
  LDA.B #$FF                                      ; 0093CB A9 FF 
  STA.W EntityV8,X                                   ; 0093CD 9D 62 0A 
  STA.W $18BA,X                                   ; 0093D0 9D BA 18 
  DEX                                             ; 0093D3 CA 
  BPL.B B_93C2                                    ; 0093D4 10 EC 
  LDX.B #$02                                      ; 0093D6 A2 02 
  JSR.W L_8FA3                                    ; 0093D8 20 A3 8F 
  LDA.B #$52                                      ; 0093DB A9 52 
  STA.W BG2SC                                     ; 0093DD 8D 08 21 
  LDA.B #$5A                                      ; 0093E0 A9 5A 
  STA.W BG3SC                                     ; 0093E2 8D 09 21 
  JSR.W L_9568                                    ; 0093E5 20 68 95 
  JSL L_AC62                                      ; 0093E8 22 62 AC 00 
  JSR.W L_94E2                                    ; 0093EC 20 E2 94 
  JSR.W LocateCurrentRoomOffset                                    ; 0093EF 20 B7 97 
  INY                                             ; 0093F2 C8 
  INY                                             ; 0093F3 C8 
  LDA.B ($04),Y                                   ; 0093F4 B1 04 
  STA.W CurrentRoom                                     ; 0093F6 8D AC 05 
  JSR.W L_828A                                    ; 0093F9 20 8A 82 
  JSR.W L_8BBC                                    ; 0093FC 20 BC 8B 
  LDA.B #$03                                      ; 0093FF A9 03 
  STA.W $05E1                                     ; 009401 8D E1 05 
  LDA.B #$64                                      ; 009404 A9 64 
  STA.W $05E3                                     ; 009406 8D E3 05 
  JSL Wait1Frame                                     ; 009409 22 13 CA 0E 
  JSR.W L_E883                                    ; 00940D 20 83 E8 
  LDX.B #$00                                      ; 009410 A2 00 
  LDA.W $06C9                                     ; 009412 AD C9 06 
  ORA.W $06CB                                     ; 009415 0D CB 06 
  BNE.B B_941B                                    ; 009418 D0 01 
  INX                                             ; 00941A E8 
B_941B:
  JSL L_ACE4                                      ; 00941B 22 E4 AC 00 
B_941F:
  JSR.W L_8F83                                    ; 00941F 20 83 8F 
  JSR.W L_A250                                    ; 009422 20 50 A2 
  JSL Wait1Frame                                     ; 009425 22 13 CA 0E 
  CLC                                             ; 009429 18 
  LDA.W $06CA                                     ; 00942A AD CA 06 
  ADC.B #$02                                      ; 00942D 69 02 
  STA.W $06CA                                     ; 00942F 8D CA 06 
  LDA.W $06CB                                     ; 009432 AD CB 06 
  ADC.B #$00                                      ; 009435 69 00 
  STA.W $06CB                                     ; 009437 8D CB 06 
  BEQ.B B_941F                                    ; 00943A F0 E3 
  STZ.W $05DE                                     ; 00943C 9C DE 05 
  STZ.W $05DF                                     ; 00943F 9C DF 05 
  JSR.W L_8F83                                    ; 009442 20 83 8F 
  JSL Wait1Frame                                     ; 009445 22 13 CA 0E 
  LDX.B #$01                                      ; 009449 A2 01 
  LDA.B #$01                                      ; 00944B A9 01 
B_944D:
  STA.W EntityV8,X                                   ; 00944D 9D 62 0A 
  STA.W $18BA,X                                   ; 009450 9D BA 18 
  DEX                                             ; 009453 CA 
  BPL.B B_944D                                    ; 009454 10 F7 
  LDX.B #$24                                      ; 009456 A2 24 
B_9458:
  PHX                                             ; 009458 DA 
  JSL Wait1Frame                                     ; 009459 22 13 CA 0E 
  JSR.W L_8F83                                    ; 00945D 20 83 8F 
  PLX                                             ; 009460 FA 
  DEX                                             ; 009461 CA 
  BPL.B B_9458                                    ; 009462 10 F4 
  LDX.B #$01                                      ; 009464 A2 01 
B_9466:
  STZ.W EntityV8,X                                   ; 009466 9E 62 0A 
  STZ.W $18BA,X                                   ; 009469 9E BA 18 
  DEX                                             ; 00946C CA 
  BPL.B B_9466                                    ; 00946D 10 F7 
  JSL Wait1Frame                                     ; 00946F 22 13 CA 0E 
  JSR.W L_9013                                    ; 009473 20 13 90 
  JSR.W L_8F83                                    ; 009476 20 83 8F 
  LDX.B #$3C                                      ; 009479 A2 3C 
  JSL WaitXFrames                                     ; 00947B 22 72 C9 0E 
  JSR.W L_94AB                                    ; 00947F 20 AB 94 
  JSR.W L_E933                                    ; 009482 20 33 E9 
  LDX.B #$00                                      ; 009485 A2 00 
  JSL L_ACE4                                      ; 009487 22 E4 AC 00 
  JSR.W L_8A3A                                    ; 00948B 20 3A 8A 
  JSL Wait1Frame                                     ; 00948E 22 13 CA 0E 
  LDA.B #$50                                      ; 009492 A9 50 
  STA.W BG2SC                                     ; 009494 8D 08 21 
  LDA.B #$58                                      ; 009497 A9 58 
  STA.W BG3SC                                     ; 009499 8D 09 21 
  LDA.B #$01                                      ; 00949C A9 01 
  STA.W $05D9                                     ; 00949E 8D D9 05 
  RTS                                             ; 0094A1 60 


L_94A2:
  LDX.B #$0F                                      ; 0094A2 A2 0F 
B_94A4:
  STZ.W $194B,X                                   ; 0094A4 9E 4B 19 
  DEX                                             ; 0094A7 CA 
  BPL.B B_94A4                                    ; 0094A8 10 FA 
  RTS                                             ; 0094AA 60 


L_94AB:
  JSR.W L_94A2                                    ; 0094AB 20 A2 94 
  STZ.B $04                                       ; 0094AE 64 04 
  LDX.B #$02                                      ; 0094B0 A2 02 
B_94B2:
  LDA.W EntityHeader,X                                   ; 0094B2 BD D2 06 
  BEQ.B B_94DC                                    ; 0094B5 F0 25 
  LDA.W EntityV1,X                                   ; 0094B7 BD 44 07 
  CMP.B #$0F                                      ; 0094BA C9 0F 
  BNE.B B_94DC                                    ; 0094BC D0 1E 
  LDY.B $04                                       ; 0094BE A4 04 
  LDA.B #$01                                      ; 0094C0 A9 01 
  STA.W $194B,Y                                   ; 0094C2 99 4B 19 
  LDA.W XexzyCharX,X                              ; 0094C5 BD 46 0B 
  STA.W $195B,Y                                   ; 0094C8 99 5B 19 
  LDA.W EntityYPx,X                                   ; 0094CB BD 9C 0C 
  STA.W $196B,Y                                   ; 0094CE 99 6B 19 
  LDA.W EntityV31,X                                   ; 0094D1 BD A0 14 
  STA.W $197B,Y                                   ; 0094D4 99 7B 19 
  INC.B $04                                       ; 0094D7 E6 04 
  STZ.W EntityHeader,X                                   ; 0094D9 9E D2 06 
B_94DC:
  INX                                             ; 0094DC E8 
  CPX.B #$42                                      ; 0094DD E0 42 
  BNE.B B_94B2                                    ; 0094DF D0 D1 
  RTS                                             ; 0094E1 60 


L_94E2:
  LDY.B #$0F                                      ; 0094E2 A0 0F 
B_94E4:
  LDA.W $194B,Y                                   ; 0094E4 B9 4B 19 
  BEQ.B B_9557                                    ; 0094E7 F0 6E 
  JSL L_380F3                                     ; 0094E9 22 F3 80 03 
  JSL L_38094                                     ; 0094ED 22 94 80 03 
  LDA.B #$01                                      ; 0094F1 A9 01 
  STA.W EntityHeader,X                                   ; 0094F3 9D D2 06 
  LDA.B #$0E                                      ; 0094F6 A9 0E 
  STA.W EntityV1,X                                   ; 0094F8 9D 44 07 
  LDA.B #$00                                      ; 0094FB A9 00 
  STA.W EntityV3,X                                   ; 0094FD 9D 28 08 
  LDA.B #$AC                                      ; 009500 A9 AC 
  STA.W EntityV29,X                                   ; 009502 9D BC 13 
  LDA.B #$24                                      ; 009505 A9 24 
  STA.W EntityV30,X                                   ; 009507 9D 2E 14 
  LDA.W $197B,Y                                   ; 00950A B9 7B 19 
  STA.W EntityV31,X                                   ; 00950D 9D A0 14 
  LDA.W $195B,Y                                   ; 009510 B9 5B 19 
  STA.W XexzyCharX,X                              ; 009513 9D 46 0B 
  LDA.W $196B,Y                                   ; 009516 B9 6B 19 
  STA.W EntityYPx,X                                   ; 009519 9D 9C 0C 
  STZ.W EntityV11,X                                   ; 00951C 9E B8 0B 
  STZ.W EntityV14,X                                   ; 00951F 9E 0E 0D 
  PHY                                             ; 009522 5A 
  PHX                                             ; 009523 DA 
  LDY.W EntityV31,X                                   ; 009524 BC A0 14 
  JSL L_AEF1                                      ; 009527 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 00952B BD A0 14 
  TAX                                             ; 00952E AA 
  STZ.W $175E,X                                   ; 00952F 9E 5E 17 
  ASL                                             ; 009532 0A 
  ASL                                             ; 009533 0A 
  TAY                                             ; 009534 A8 
  LDA.B #$F0                                      ; 009535 A9 F0 
  BCC.B B_953E                                    ; 009537 90 05 
  STA.W $0409,Y                                   ; 009539 99 09 04 
  BRA.B B_9541                                    ; 00953C 80 03 

B_953E:
.byte $99,$09,$03                                 ; 00953F ...      ???

B_9541:
  PLX                                             ; 009541 FA 
  JSL L_AE82                                      ; 009542 22 82 AE 00 
  TYA                                             ; 009546 98 
  STA.W EntityV31,X                                   ; 009547 9D A0 14 
  LDA.B #$01                                      ; 00954A A9 01 
  STA.W $175E,Y                                   ; 00954C 99 5E 17 
  JSL L_AEF1                                      ; 00954F 22 F1 AE 00 
  JSR.W L_955B                                    ; 009553 20 5B 95 
  PLY                                             ; 009556 7A 
B_9557:
  DEY                                             ; 009557 88 
  BPL.B B_94E4                                    ; 009558 10 8A 
  RTS                                             ; 00955A 60 


L_955B:
  LDA.B #$08                                      ; 00955B A9 08 
  STA.B $1C                                       ; 00955D 85 1C 
  LDA.B #$09                                      ; 00955F A9 09 
  STA.B $1D                                       ; 009561 85 1D 
  JSL L_AFC2                                      ; 009563 22 C2 AF 00 
  RTS                                             ; 009567 60 


L_9568:
  LDX.B #$02                                      ; 009568 A2 02 
B_956A:
  LDA.W EntityHeader,X                                   ; 00956A BD D2 06 
  BEQ.B B_9598                                    ; 00956D F0 29 
  LDA.W EntityV1,X                                   ; 00956F BD 44 07 
  CMP.B #$03                                      ; 009572 C9 03 
  BNE.B B_9598                                    ; 009574 D0 22 
  STZ.W EntityHeader,X                                   ; 009576 9E D2 06 
  PHX                                             ; 009579 DA 
  LDY.W EntityV31,X                                   ; 00957A BC A0 14 
  JSL L_AEF1                                      ; 00957D 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 009581 BD A0 14 
  TAX                                             ; 009584 AA 
  STZ.W $175E,X                                   ; 009585 9E 5E 17 
  ASL                                             ; 009588 0A 
  ASL                                             ; 009589 0A 
  TAY                                             ; 00958A A8 
  LDA.B #$F0                                      ; 00958B A9 F0 
  BCC.B B_9594                                    ; 00958D 90 05 
  STA.W $0409,Y                                   ; 00958F 99 09 04 
  BRA.B B_9597                                    ; 009592 80 03 

B_9594:
.byte $99,$09,$03                                 ; 009595 ...      ???

B_9597:
  PLX                                             ; 009597 FA 
B_9598:
  INX                                             ; 009598 E8 
  CPX.B #$42                                      ; 009599 E0 42 
  BNE.B B_956A                                    ; 00959B D0 CD 
  RTS                                             ; 00959D 60 


L_959E:
  STZ.B $04                                       ; 00959E 64 04 
  STZ.B $05                                       ; 0095A0 64 05 
  STZ.B $06                                       ; 0095A2 64 06 
  LDA.W $05D3                                     ; 0095A4 AD D3 05 
  BNE.B B_95AA                                    ; 0095A7 D0 01 
  RTS                                             ; 0095A9 60 

B_95AA:
  LDY.B #$02                                      ; 0095AA A0 02 
B_95AC:
  LDA.W D_95E4,Y                                  ; 0095AC B9 E4 95 
  AND.W $05D5                                     ; 0095AF 2D D5 05 
  BNE.B B_95E0                                    ; 0095B2 D0 2C 
  LDX.B #$01                                      ; 0095B4 A2 01 
B_95B6:
  LDA.W D_95E7,Y                                  ; 0095B6 B9 E7 95 
  CMP.W XexzyCharX,X                              ; 0095B9 DD 46 0B 
  BCS.B B_95DD                                    ; 0095BC B0 1F 
  LDA.W D_95EA,Y                                  ; 0095BE B9 EA 95 
  CMP.W XexzyCharX,X                              ; 0095C1 DD 46 0B 
  BCC.B B_95DD                                    ; 0095C4 90 17 
  LDA.W D_95ED,Y                                  ; 0095C6 B9 ED 95 
  CMP.W EntityYPx,X                                   ; 0095C9 DD 9C 0C 
  BCS.B B_95DD                                    ; 0095CC B0 0F 
  LDA.W D_95F0,Y                                  ; 0095CE B9 F0 95 
  CMP.W EntityYPx,X                                   ; 0095D1 DD 9C 0C 
  BCC.B B_95DD                                    ; 0095D4 90 07 
  LDA.W $0004,Y                                   ; 0095D6 B9 04 00 
  INC A
  STA.W $0004,Y                                   ; 0095DA 99 04 00 
B_95DD:
  DEX                                             ; 0095DD CA 
  BPL.B B_95B6                                    ; 0095DE 10 D6 
B_95E0:
  DEY                                             ; 0095E0 88 
  BPL.B B_95AC                                    ; 0095E1 10 C9 
  RTS                                             ; 0095E3 60 


D_95E4:
.byte $01,$02,$04                                 ; 0095E5 DDD      ???
D_95E7:
.byte $72,$DE,$72                                 ; 0095E8 DDD      r?r
D_95EA:
.byte $8E,$FF,$8E                                 ; 0095EB DDD      ???
D_95ED:
.byte $00,$73,$D6                                 ; 0095EE DDD      ?s?
D_95F0:
.byte $33,$8B,$FF                                 ; 0095F1 DDD      3??


L_95F3:
  DEC.W $05D4                                     ; 0095F3 CE D4 05 
  BEQ.B B_95FB                                    ; 0095F6 F0 03 
  JMP.W D_969B                                    ; 0095F8 4C 9B 96 
B_95FB:
  LDA.B #$FF                                      ; 0095FB A9 FF 
  STA.W $05D4                                     ; 0095FD 8D D4 05 
  INC.W $05D3                                     ; 009600 EE D3 05 
  JSL L_F809A                                     ; 009603 22 9A 80 0F 
  LDA.W CurrentRoom                                     ; 009607 AD AC 05 
  CMP.B #$01                                      ; 00960A C9 01 
  BNE.B B_9611                                    ; 00960C D0 03 
  JSR.W L_8663                                    ; 00960E 20 63 86 
B_9611:
  LDA.W $05D5                                     ; 009611 AD D5 05 
  AND.B #$01                                      ; 009614 29 01 
  BNE.B B_9625                                    ; 009616 D0 0D 
  LDY.B #$00                                      ; 009618 A0 00 
  JSR.W L_96B9                                    ; 00961A 20 B9 96 
  LDA.B #$01                                      ; 00961D A9 01 
  STA.W $05E4                                     ; 00961F 8D E4 05 
  STA.W $05E3                                     ; 009622 8D E3 05 
B_9625:
  LDA.W $05D5                                     ; 009625 AD D5 05 
  AND.B #$02                                      ; 009628 29 02 
  BNE.B B_9643                                    ; 00962A D0 17 
  LDA.W CurrentRoom                                     ; 00962C AD AC 05 
  LDY.W CurrentRound                                     ; 00962F AC AB 05 
  BEQ.B B_963A                                    ; 009632 F0 06 

.byte $C9,$12,$F0,$0B,$80,$04                     ; 009635 ......   ??????

B_963A:
  CMP.B #$07                                      ; 00963A C9 07 
  BEQ.B B_9643                                    ; 00963C F0 05 
  LDY.B #$01                                      ; 00963E A0 01 
  JSR.W L_96B9                                    ; 009640 20 B9 96 
B_9643:
  LDA.W $05D5                                     ; 009643 AD D5 05 
  AND.B #$04                                      ; 009646 29 04 
  BNE.B B_964F                                    ; 009648 D0 05 
  LDY.B #$02                                      ; 00964A A0 02 
  JSR.W L_96B9                                    ; 00964C 20 B9 96 
B_964F:
  REP.B #$10                                      ; 00964F C2 10 
  SEP.B #P_Acc8Bit                                      ; 009651 E2 20 
  LDX.W #$6600                                    ; 009653 A2 00 66 
  STX.W $1A99                                     ; 009656 8E 99 1A 
  LDX.W #$1801                                    ; 009659 A2 01 18 
  STX.W $1A92                                     ; 00965C 8E 92 1A 
  LDX.W #$8000                                    ; 00965F A2 00 80 
  STX.W $1A94                                     ; 009662 8E 94 1A 
  LDA.B #$0E                                      ; 009665 A9 0E 
  STA.W $1A96                                     ; 009667 8D 96 1A 
  LDX.W #$0400                                    ; 00966A A2 00 04 
  STX.W $1A97                                     ; 00966D 8E 97 1A 
  LDA.B #$01                                      ; 009670 A9 01 
  STA.W $1A91                                     ; 009672 8D 91 1A 
  JSL Wait1Frame                                     ; 009675 22 13 CA 0E 
  REP.B #P_Acc8Bit                                      ; 009679 C2 20 
  LDA.W #$8017                                    ; 00967B A9 17 80 
  JSL L_F8401                                     ; 00967E 22 01 84 0F 
  SEP.B #P_Acc8Bit                                      ; 009682 E2 20 
  LDA.B #$07                                      ; 009684 A9 07 
  LDX.W #$FF17                                    ; 009686 A2 17 FF 
  JSL Audio_F830F                                     ; 009689 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00968D E2 30 
  LDX.B #$26                                      ; 00968F A2 26 
  JSL L_EF072                                     ; 009691 22 72 F0 0E 
  LDA.B #$92                                      ; 009695 A9 92 
  STA.W $02C2                                     ; 009697 8D C2 02 
  RTS                                             ; 00969A 60 

D_969B:
  LDX.B #$01                                      ; 00969B A2 01 
B_969D:
  LDA.W $1897,X                                   ; 00969D BD 97 18 
  CMP.B #$04                                      ; 0096A0 C9 04 
  BNE.B B_96B5                                    ; 0096A2 D0 11 

.byte $9E,$97,$18,$9E,$B2,$18,$9E,$99             ; 0096A4 ........ ????????
.byte $18,$9E,$9B,$18,$A9,$09,$9D,$B0             ; 0096AC ........ ????????
.byte $18                                         ; 0096B5 .        ?

B_96B5:
  DEX                                             ; 0096B5 CA 
  BPL.B B_969D                                    ; 0096B6 10 E5 
  RTS                                             ; 0096B8 60 


L_96B9:
  STY.B $04                                       ; 0096B9 84 04 
  JSL L_380F3                                     ; 0096BB 22 F3 80 03 
  JSL L_38094                                     ; 0096BF 22 94 80 03 
  LDA.B #$01                                      ; 0096C3 A9 01 
  STA.W EntityHeader,X                                   ; 0096C5 9D D2 06 
  LDA.B #$00                                      ; 0096C8 A9 00 
  STA.W EntityV3,X                                   ; 0096CA 9D 28 08 
  LDA.B #$03                                      ; 0096CD A9 03 
  STA.W EntityV1,X                                   ; 0096CF 9D 44 07 
  LDY.B $04                                       ; 0096D2 A4 04 
  LDA.W D_97AB,Y                                  ; 0096D4 B9 AB 97 
  STA.W EntityV29,X                                   ; 0096D7 9D BC 13 
  LDA.W D_97AE,Y                                  ; 0096DA B9 AE 97 
  STA.W EntityV30,X                                   ; 0096DD 9D 2E 14 
  LDA.W D_97A5,Y                                  ; 0096E0 B9 A5 97 
  STA.W XexzyCharX,X                              ; 0096E3 9D 46 0B 
  LDA.W D_97A8,Y                                  ; 0096E6 B9 A8 97 
  STA.W EntityYPx,X                                   ; 0096E9 9D 9C 0C 
  JSL L_AEAF                                      ; 0096EC 22 AF AE 00 
  TYA                                             ; 0096F0 98 
  STA.W EntityV31,X                                   ; 0096F1 9D A0 14 
  LDA.B #$01                                      ; 0096F4 A9 01 
  STA.W $175E,Y                                   ; 0096F6 99 5E 17 
  JSL L_AEF1                                      ; 0096F9 22 F1 AE 00 
  LDA.B #$00                                      ; 0096FD A9 00 
  STA.B $1C                                       ; 0096FF 85 1C 
  LDA.B #$00                                      ; 009701 A9 00 
  STA.B $1D                                       ; 009703 85 1D 
  JSL L_AFC2                                      ; 009705 22 C2 AF 00 
  JSL L_380F3                                     ; 009709 22 F3 80 03 
  JSL L_38094                                     ; 00970D 22 94 80 03 
  LDA.B #$01                                      ; 009711 A9 01 
  STA.W EntityHeader,X                                   ; 009713 9D D2 06 
  LDA.B #$00                                      ; 009716 A9 00 
  STA.W EntityV3,X                                   ; 009718 9D 28 08 
  LDA.B #$03                                      ; 00971B A9 03 
  STA.W EntityV1,X                                   ; 00971D 9D 44 07 
  LDY.B $04                                       ; 009720 A4 04 
  LDA.B #$64                                      ; 009722 A9 64 
  STA.W EntityV29,X                                   ; 009724 9D BC 13 
  LDA.B #$22                                      ; 009727 A9 22 
  STA.W EntityV30,X                                   ; 009729 9D 2E 14 
  LDA.W D_97B1,Y                                  ; 00972C B9 B1 97 
  STA.W XexzyCharX,X                              ; 00972F 9D 46 0B 
  LDA.W D_97B4,Y                                  ; 009732 B9 B4 97 
  STA.W EntityYPx,X                                   ; 009735 9D 9C 0C 
  JSL L_AEAF                                      ; 009738 22 AF AE 00 
  TYA                                             ; 00973C 98 
  STA.W EntityV31,X                                   ; 00973D 9D A0 14 
  LDA.B #$01                                      ; 009740 A9 01 
  STA.W $175E,Y                                   ; 009742 99 5E 17 
  JSL L_AEF1                                      ; 009745 22 F1 AE 00 
  LDA.B #$00                                      ; 009749 A9 00 
  STA.B $1C                                       ; 00974B 85 1C 
  LDA.B #$00                                      ; 00974D A9 00 
  STA.B $1D                                       ; 00974F 85 1D 
  JSL L_AFC2                                      ; 009751 22 C2 AF 00 
  JSL L_380F3                                     ; 009755 22 F3 80 03 
  JSL L_38094                                     ; 009759 22 94 80 03 
  LDA.B #$01                                      ; 00975D A9 01 
  STA.W EntityHeader,X                                   ; 00975F 9D D2 06 
  LDA.B #$00                                      ; 009762 A9 00 
  STA.W EntityV3,X                                   ; 009764 9D 28 08 
  LDA.B #$03                                      ; 009767 A9 03 
  STA.W EntityV1,X                                   ; 009769 9D 44 07 
  LDY.B $04                                       ; 00976C A4 04 
  LDA.B #$66                                      ; 00976E A9 66 
  STA.W EntityV29,X                                   ; 009770 9D BC 13 
  LDA.B #$22                                      ; 009773 A9 22 
  STA.W EntityV30,X                                   ; 009775 9D 2E 14 
  CLC                                             ; 009778 18 
  LDA.W D_97B1,Y                                  ; 009779 B9 B1 97 
  ADC.B #$10                                      ; 00977C 69 10 
  STA.W XexzyCharX,X                              ; 00977E 9D 46 0B 
  LDA.W D_97B4,Y                                  ; 009781 B9 B4 97 
  STA.W EntityYPx,X                                   ; 009784 9D 9C 0C 
  JSL L_AEAF                                      ; 009787 22 AF AE 00 
  TYA                                             ; 00978B 98 
  STA.W EntityV31,X                                   ; 00978C 9D A0 14 
  LDA.B #$01                                      ; 00978F A9 01 
  STA.W $175E,Y                                   ; 009791 99 5E 17 
  JSL L_AEF1                                      ; 009794 22 F1 AE 00 
  LDA.B #$00                                      ; 009798 A9 00 
  STA.B $1C                                       ; 00979A 85 1C 
  LDA.B #$00                                      ; 00979C A9 00 
  STA.B $1D                                       ; 00979E 85 1D 
  JSL L_AFC2                                      ; 0097A0 22 C2 AF 00 
  RTS                                             ; 0097A4 60 


D_97A5:
.byte $78,$8C,$78                                 ; 0097A6 DDD      x?x
D_97A8:
.byte $63,$77,$8B                                 ; 0097A9 DDD      cw?
D_97AB:
.byte $62,$60,$62                                 ; 0097AC DDD      b`b
D_97AE:
.byte $22,$22,$A2                                 ; 0097AF DDD      ""?
D_97B1:
.byte $75,$D6,$75                                 ; 0097B2 DDD      u?u
D_97B4:
.byte $25,$7D,$CC                                 ; 0097B5 DDD      %}?


LocateCurrentRoomOffset:
  ; switch to data bank 0
  lda #$00
  pha
  plb
  ; find offset in round to current room
  lda CurrentRoom
  sta $04
  asl
  clc
  adc $04
  tay
  ; find offset to the room list for the round
  ldx CurrentRound
  lda.w RoundRoomIndexesLo,X
  sta $04
  lda.w RoundRoomIndexesHi,X
  sta $05
  rts


L_97D3:
  PHB                                             ; 0097D3 8B 
  LDA.B #$00                                      ; 0097D4 A9 00 
  STA.W $05D5                                     ; 0097D6 8D D5 05 
  JSR.W LocateCurrentRoomOffset                                    ; 0097D9 20 B7 97 
  LDA.B ($04),Y                                   ; 0097DC B1 04 
  BNE.B B_97E8                                    ; 0097DE D0 08 
  LDA.B #$01                                      ; 0097E0 A9 01 
  ORA.W $05D5                                     ; 0097E2 0D D5 05 
  STA.W $05D5                                     ; 0097E5 8D D5 05 
B_97E8:
  INY                                             ; 0097E8 C8 
  LDA.B ($04),Y                                   ; 0097E9 B1 04 
  BNE.B B_97F5                                    ; 0097EB D0 08 
  LDA.B #$02                                      ; 0097ED A9 02 
  ORA.W $05D5                                     ; 0097EF 0D D5 05 
  STA.W $05D5                                     ; 0097F2 8D D5 05 
B_97F5:
  INY                                             ; 0097F5 C8 
  LDA.B ($04),Y                                   ; 0097F6 B1 04 
  BNE.B B_9802                                    ; 0097F8 D0 08 
  LDA.B #$04                                      ; 0097FA A9 04 
  ORA.W $05D5                                     ; 0097FC 0D D5 05 
  STA.W $05D5                                     ; 0097FF 8D D5 05 
B_9802:
  PLB                                             ; 009802 AB 
  RTS                                             ; 009803 60 


L_9804:
  PHP                                             ; 009804 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 009805 E2 30 
  LDA.W $0533                                     ; 009807 AD 33 05 
  BEQ.B B_9854                                    ; 00980A F0 48 
  LDA.W JoyPressed+1                                     ; 00980C AD 01 03 
  AND.B #$10                                      ; 00980F 29 10 
  BEQ.B B_9830                                    ; 009811 F0 1D 
  LDA.W $18A3                                     ; 009813 AD A3 18 
  BNE.B B_9830                                    ; 009816 D0 18 

.byte $A2,$00,$18,$AD,$06,$02,$69,$03             ; 009818 ........ ??????i?
.byte $9D,$31,$05,$20,$AA,$98,$CE,$33             ; 009820 ........ ?1? ???3
.byte $05,$A2,$07,$74,$97,$CA,$10,$FB             ; 009828 ........ ???t????

B_9830:
  LDA.W Joy2Pressed+1                                     ; 009830 AD 03 03 
  AND.B #$10                                      ; 009833 29 10 
  BEQ.B B_9854                                    ; 009835 F0 1D 

.byte $AD,$A4,$18,$D0,$18,$A2,$01,$18             ; 009837 ........ ????????
.byte $AD,$06,$02,$69,$03,$9D,$31,$05             ; 00983F ........ ???i??1?
.byte $20,$AA,$98,$CE,$33,$05,$A2,$07             ; 009847 ........  ???3???
.byte $74,$9F,$CA,$10,$FB                         ; 009850 .....    t????

B_9854:
  PLP                                             ; 009854 28 
  RTS                                             ; 009855 60 


L_9856:
  LDA.W XexzyLivesCount,X                         ; 009856 BD 31 05 
  BNE.B B_98A3                                    ; 009859 D0 48 
  LDA.W $0533                                     ; 00985B AD 33 05 
  BEQ.B B_9889                                    ; 00985E F0 29 
  PHX                                             ; 009860 DA 
  JSL L_ED4C0                                     ; 009861 22 C0 D4 0E 
  PHA                                             ; 009865 48 
  LDA.W $05D3                                     ; 009866 AD D3 05 
  BEQ.B B_9876                                    ; 009869 F0 0B 

.byte $A2,$26,$22,$72,$F0,$0E,$A9,$92             ; 00986B ........ ?&"r????
.byte $8D,$C2,$02                                 ; 009874 ...      ???

B_9876:
  PLA                                             ; 009876 68 
  PLX                                             ; 009877 FA 
  CMP.B #$01                                      ; 009878 C9 01 
  BNE.B B_9889                                    ; 00987A D0 0D 
  CLC                                             ; 00987C 18 
  LDA.W $0206                                     ; 00987D AD 06 02 
  ADC.B #$03                                      ; 009880 69 03 
  STA.W XexzyLivesCount,X                         ; 009882 9D 31 05 
  JSR.W L_98AA                                    ; 009885 20 AA 98 
  RTS                                             ; 009888 60 

B_9889:
  STZ.W $18A3,X                                   ; 009889 9E A3 18 
  STZ.W $18A5,X                                   ; 00988C 9E A5 18 
  LDA.W $18A3                                     ; 00988F AD A3 18 
  ORA.W $18A4                                     ; 009892 0D A4 18 
  BNE.B B_98A2                                    ; 009895 D0 0B 
  PHX                                             ; 009897 DA 
  JSL L_ED607                                     ; 009898 22 07 D6 0E 
  LDA.B #$FF                                      ; 00989C A9 FF 
  STA.W CurrentRound                                     ; 00989E 8D AB 05 
  PLX                                             ; 0098A1 FA 
B_98A2:
  RTS                                             ; 0098A2 60 

B_98A3:
  DEC.W XexzyLivesCount,X                         ; 0098A3 DE 31 05 
  JSR.W L_98AA                                    ; 0098A6 20 AA 98 
  RTS                                             ; 0098A9 60 


L_98AA:
  PHX                                             ; 0098AA DA 
  JSL L_ACB0                                      ; 0098AB 22 B0 AC 00 
  PLX                                             ; 0098AF FA 
  LDA.B #$01                                      ; 0098B0 A9 01 
  STA.W $18A3,X                                   ; 0098B2 9D A3 18 
  STZ.W $18A5,X                                   ; 0098B5 9E A5 18 
  LDA.B #$7C                                      ; 0098B8 A9 7C 
  STA.W EntityYPx,X                                   ; 0098BA 9D 9C 0C 
  LDA.W D_995B,X                                  ; 0098BD BD 5B 99 
  STA.W XexzyCharX,X                              ; 0098C0 9D 46 0B 
  LDA.B #$28                                      ; 0098C3 A9 28 
  STA.W $18AB,X                                   ; 0098C5 9D AB 18 
  STZ.W $18AD,X                                   ; 0098C8 9E AD 18 
  STZ.W $1897,X                                   ; 0098CB 9E 97 18 
  STZ.W $18B2,X                                   ; 0098CE 9E B2 18 
  STZ.W $1899,X                                   ; 0098D1 9E 99 18 
  STZ.W $189B,X                                   ; 0098D4 9E 9B 18 
  LDA.B #$09                                      ; 0098D7 A9 09 
  STA.W $18B0,X                                   ; 0098D9 9D B0 18 
  LDA.B #$01                                      ; 0098DC A9 01 
  STA.W $187C,X                                   ; 0098DE 9D 7C 18 
  LDA.B #$03                                      ; 0098E1 A9 03 
  STA.W $1884,X                                   ; 0098E3 9D 84 18 
  LDA.B #$01                                      ; 0098E6 A9 01 
  STA.W $19D3,X                                   ; 0098E8 9D D3 19 
  LDA.W D_995D,X                                  ; 0098EB BD 5D 99 
  STA.W $1893,X                                   ; 0098EE 9D 93 18 
  STA.W $1895,X                                   ; 0098F1 9D 95 18 
  LDA.W D_995F,X                                  ; 0098F4 BD 5F 99 
  STA.W $188A,X                                   ; 0098F7 9D 8A 18 
  STA.W $1888,X                                   ; 0098FA 9D 88 18 
  LDA.B #$03                                      ; 0098FD A9 03 
  JSL L_E5C0                                      ; 0098FF 22 C0 E5 00 
  STX.B $04                                       ; 009903 86 04 
  JSL L_38102                                     ; 009905 22 02 81 03 
  BEQ.B B_990C                                    ; 009909 F0 01 

.byte $60                                         ; 00990C .        `

B_990C:
  JSL L_38094                                     ; 00990C 22 94 80 03 
  LDA.B #$01                                      ; 009910 A9 01 
  STA.W EntityHeader,X                                   ; 009912 9D D2 06 
  LDA.B #$04                                      ; 009915 A9 04 
  STA.W EntityV1,X                                   ; 009917 9D 44 07 
  LDA.B #$00                                      ; 00991A A9 00 
  STA.W EntityV3,X                                   ; 00991C 9D 28 08 
  LDA.B #$FA                                      ; 00991F A9 FA 
  STA.W EntityV15,X                                   ; 009921 9D 80 0D 
  LDA.B #$01                                      ; 009924 A9 01 
  STA.W EntityV16,X                                   ; 009926 9D F2 0D 
  LDA.B $04                                       ; 009929 A5 04 
  STA.W EntityV20,X                                   ; 00992B 9D BA 0F 
  TAY                                             ; 00992E A8 
  LDA.B #$01                                      ; 00992F A9 01 
  STA.W $18A9,Y                                   ; 009931 99 A9 18 
  TXA                                             ; 009934 8A 
  STA.W $05CC,Y                                   ; 009935 99 CC 05 
  JSL L_AEAF                                      ; 009938 22 AF AE 00 
  TYA                                             ; 00993C 98 
  STA.W EntityV31,X                                   ; 00993D 9D A0 14 
  LDA.B #$01                                      ; 009940 A9 01 
  STA.W $175E,Y                                   ; 009942 99 5E 17 
  JSL L_AEF1                                      ; 009945 22 F1 AE 00 
  JSL L_AEAF                                      ; 009949 22 AF AE 00 
  TYA                                             ; 00994D 98 
  STA.W EntityV21,X                                   ; 00994E 9D 2C 10 
  LDA.B #$01                                      ; 009951 A9 01 
  STA.W $175E,Y                                   ; 009953 99 5E 17 
  JSL L_AEF1                                      ; 009956 22 F1 AE 00 
  RTS                                             ; 00995A 60 


D_995B:
.byte $05,$FA                                     ; 00995C DD       ??
D_995D:
.byte $02,$06                                     ; 00995E DD       ??
D_995F:
.byte $00,$40                                     ; 009960 DD       ?@


L_9961:
  PHP                                             ; 009961 08 
  SEP.B #P_Acc8Bit                                      ; 009962 E2 20 
  STZ.W $1A91                                     ; 009964 9C 91 1A 
  STZ.W $1A7C                                     ; 009967 9C 7C 1A 
  STZ.W $1A83                                     ; 00996A 9C 83 1A 
  STZ.W $1A88                                     ; 00996D 9C 88 1A 
  STZ.W $1ADB                                     ; 009970 9C DB 1A 
  STZ.W $1ADC                                     ; 009973 9C DC 1A 
  STZ.W $1ADD                                     ; 009976 9C DD 1A 
  STZ.W $1ADE                                     ; 009979 9C DE 1A 
  STZ.W $19E3                                     ; 00997C 9C E3 19 
  STZ.W $19F0                                     ; 00997F 9C F0 19 
  STZ.W $19FD                                     ; 009982 9C FD 19 
  STZ.W $1A0A                                     ; 009985 9C 0A 1A 
  STZ.W $1A17                                     ; 009988 9C 17 1A 
  STZ.W $1A24                                     ; 00998B 9C 24 1A 
  STZ.W $1A41                                     ; 00998E 9C 41 1A 
  STZ.W $1A4E                                     ; 009991 9C 4E 1A 
  STZ.W $1A5B                                     ; 009994 9C 5B 1A 
  STZ.W $1A68                                     ; 009997 9C 68 1A 
  STZ.W $1A75                                     ; 00999A 9C 75 1A 
  STZ.W $1A9B                                     ; 00999D 9C 9B 1A 
  STZ.W $1AA5                                     ; 0099A0 9C A5 1A 
  STZ.W $1AB2                                     ; 0099A3 9C B2 1A 
  STZ.W $1ABA                                     ; 0099A6 9C BA 1A 
  STZ.W $1AC2                                     ; 0099A9 9C C2 1A 
  PLP                                             ; 0099AC 28 
  RTS                                             ; 0099AD 60 


L_99AE:
  PHP                                             ; 0099AE 08 
  PHB                                             ; 0099AF 8B 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 0099B0 E2 30 
  LDA.B #$00                                      ; 0099B2 A9 00 
  PHA                                             ; 0099B4 48 
  PLB                                             ; 0099B5 AB 
  LDA.W $19D3                                     ; 0099B6 AD D3 19 
  BEQ.B B_9A0B                                    ; 0099B9 F0 50 
  BMI.B B_9A0B                                    ; 0099BB 30 4E 
  LDA.B #$04                                      ; 0099BD A9 04 
  STA.B $04                                       ; 0099BF 85 04 
  LDX.W $1884                                     ; 0099C1 AE 84 18 
  LDA.W D_9BDF,X                                  ; 0099C4 BD DF 9B 
  STA.B $05                                       ; 0099C7 85 05 
  LDA.W $1884                                     ; 0099C9 AD 84 18 
  ASL                                             ; 0099CC 0A 
  TAX                                             ; 0099CD AA 
  LDA.W D_9AFD,X                                  ; 0099CE BD FD 9A 
  STA.B $06                                       ; 0099D1 85 06 
  LDA.W D_9AFE,X                                  ; 0099D3 BD FE 9A 
  STA.B $07                                       ; 0099D6 85 07 
  LDY.B #$00                                      ; 0099D8 A0 00 
B_99DA:
  LDA.B #$01                                      ; 0099DA A9 01 
  STA.W $198B,Y                                   ; 0099DC 99 8B 19 
  LDA.B #$18                                      ; 0099DF A9 18 
  STA.W $198C,Y                                   ; 0099E1 99 8C 19 
  LDA.B $06                                       ; 0099E4 A5 06 
  STA.W $198D,Y                                   ; 0099E6 99 8D 19 
  CLC                                             ; 0099E9 18 
  LDA.B $07                                       ; 0099EA A5 07 
  STA.W $198E,Y                                   ; 0099EC 99 8E 19 
  ADC.B #$04                                      ; 0099EF 69 04 
  STA.B $07                                       ; 0099F1 85 07 
  LDA.B $05                                       ; 0099F3 A5 05 
  STA.W $198F,Y                                   ; 0099F5 99 8F 19 
  LDA.B #$80                                      ; 0099F8 A9 80 
  STA.W $1990,Y                                   ; 0099FA 99 90 19 
  TYA                                             ; 0099FD 98 
  CLC                                             ; 0099FE 18 
  ADC.B #$06                                      ; 0099FF 69 06 
  TAY                                             ; 009A01 A8 
  DEC.B $04                                       ; 009A02 C6 04 
  BNE.B B_99DA                                    ; 009A04 D0 D4 
  LDA.B #$FF                                      ; 009A06 A9 FF 
  STA.W $19D3                                     ; 009A08 8D D3 19 
B_9A0B:
  LDA.W $19D4                                     ; 009A0B AD D4 19 
  BEQ.B B_9A60                                    ; 009A0E F0 50 
  BMI.B B_9A60                                    ; 009A10 30 4E 
  LDA.B #$04                                      ; 009A12 A9 04 
  STA.B $04                                       ; 009A14 85 04 
  LDX.W $1885                                     ; 009A16 AE 85 18 
  LDA.W D_9BDF,X                                  ; 009A19 BD DF 9B 
  STA.B $05                                       ; 009A1C 85 05 
  LDA.W $1885                                     ; 009A1E AD 85 18 
  ASL                                             ; 009A21 0A 
  TAX                                             ; 009A22 AA 
  LDA.W D_9AFD,X                                  ; 009A23 BD FD 9A 
  STA.B $06                                       ; 009A26 85 06 
  LDA.W D_9AFE,X                                  ; 009A28 BD FE 9A 
  STA.B $07                                       ; 009A2B 85 07 
  LDY.B #$00                                      ; 009A2D A0 00 
B_9A2F:
  LDA.B #$01                                      ; 009A2F A9 01 
  STA.W $19AF,Y                                   ; 009A31 99 AF 19 
  LDA.B #$18                                      ; 009A34 A9 18 
  STA.W $19B0,Y                                   ; 009A36 99 B0 19 
  LDA.B $06                                       ; 009A39 A5 06 
  STA.W $19B1,Y                                   ; 009A3B 99 B1 19 
  CLC                                             ; 009A3E 18 
  LDA.B $07                                       ; 009A3F A5 07 
  STA.W $19B2,Y                                   ; 009A41 99 B2 19 
  ADC.B #$04                                      ; 009A44 69 04 
  STA.B $07                                       ; 009A46 85 07 
  LDA.B $05                                       ; 009A48 A5 05 
  STA.W $19B3,Y                                   ; 009A4A 99 B3 19 
  LDA.B #$80                                      ; 009A4D A9 80 
  STA.W $19B4,Y                                   ; 009A4F 99 B4 19 
  TYA                                             ; 009A52 98 
  CLC                                             ; 009A53 18 
  ADC.B #$06                                      ; 009A54 69 06 
  TAY                                             ; 009A56 A8 
  DEC.B $04                                       ; 009A57 C6 04 
  BNE.B B_9A2F                                    ; 009A59 D0 D4 
  LDA.B #$FF                                      ; 009A5B A9 FF 
  STA.W $19D4                                     ; 009A5D 8D D4 19 
B_9A60:
  LDA.W $19D5                                     ; 009A60 AD D5 19 
  BEQ.B B_9AAD                                    ; 009A63 F0 48 
  BMI.B B_9AAD                                    ; 009A65 30 46 
  LDA.B #$02                                      ; 009A67 A9 02 
  STA.B $04                                       ; 009A69 85 04 
  LDA.W XexzyWalkAnimation                        ; 009A6B AD 86 18 
  ASL                                             ; 009A6E 0A 
  TAX                                             ; 009A6F AA 
  LDA.W D_9C50,X                                  ; 009A70 BD 50 9C 
  STA.B $06                                       ; 009A73 85 06 
  LDA.W D_9C51,X                                  ; 009A75 BD 51 9C 
  STA.B $07                                       ; 009A78 85 07 
  LDY.B #$18                                      ; 009A7A A0 18 
B_9A7C:
  LDA.B #$01                                      ; 009A7C A9 01 
  STA.W $198B,Y                                   ; 009A7E 99 8B 19 
  LDA.B #$18                                      ; 009A81 A9 18 
  STA.W $198C,Y                                   ; 009A83 99 8C 19 
  LDA.B $06                                       ; 009A86 A5 06 
  STA.W $198D,Y                                   ; 009A88 99 8D 19 
  CLC                                             ; 009A8B 18 
  LDA.B $07                                       ; 009A8C A5 07 
  STA.W $198E,Y                                   ; 009A8E 99 8E 19 
  ADC.B #$04                                      ; 009A91 69 04 
  STA.B $07                                       ; 009A93 85 07 
  LDA.B #$7E                                      ; 009A95 A9 7E 
  STA.W $198F,Y                                   ; 009A97 99 8F 19 
  LDA.B #$40                                      ; 009A9A A9 40 
  STA.W $1990,Y                                   ; 009A9C 99 90 19 
  TYA                                             ; 009A9F 98 
  CLC                                             ; 009AA0 18 
  ADC.B #$06                                      ; 009AA1 69 06 
  TAY                                             ; 009AA3 A8 
  DEC.B $04                                       ; 009AA4 C6 04 
  BNE.B B_9A7C                                    ; 009AA6 D0 D4 
  LDA.B #$FF                                      ; 009AA8 A9 FF 
  STA.W $19D5                                     ; 009AAA 8D D5 19 
B_9AAD:
  LDA.W $19D6                                     ; 009AAD AD D6 19 
  BEQ.B B_9AFA                                    ; 009AB0 F0 48 
  BMI.B B_9AFA                                    ; 009AB2 30 46 
  LDA.B #$02                                      ; 009AB4 A9 02 
  STA.B $04                                       ; 009AB6 85 04 
  LDA.W $1887                                     ; 009AB8 AD 87 18 
  ASL                                             ; 009ABB 0A 
  TAX                                             ; 009ABC AA 
  LDA.W D_9C50,X                                  ; 009ABD BD 50 9C 
  STA.B $06                                       ; 009AC0 85 06 
  LDA.W D_9C51,X                                  ; 009AC2 BD 51 9C 
  STA.B $07                                       ; 009AC5 85 07 
  LDY.B #$18                                      ; 009AC7 A0 18 
B_9AC9:
  LDA.B #$01                                      ; 009AC9 A9 01 
  STA.W $19AF,Y                                   ; 009ACB 99 AF 19 
  LDA.B #$18                                      ; 009ACE A9 18 
  STA.W $19B0,Y                                   ; 009AD0 99 B0 19 
  LDA.B $06                                       ; 009AD3 A5 06 
  STA.W $19B1,Y                                   ; 009AD5 99 B1 19 
  CLC                                             ; 009AD8 18 
  LDA.B $07                                       ; 009AD9 A5 07 
  STA.W $19B2,Y                                   ; 009ADB 99 B2 19 
  ADC.B #$04                                      ; 009ADE 69 04 
  STA.B $07                                       ; 009AE0 85 07 
  LDA.B #$7E                                      ; 009AE2 A9 7E 
  STA.W $19B3,Y                                   ; 009AE4 99 B3 19 
  LDA.B #$40                                      ; 009AE7 A9 40 
  STA.W $19B4,Y                                   ; 009AE9 99 B4 19 
  TYA                                             ; 009AEC 98 
  CLC                                             ; 009AED 18 
  ADC.B #$06                                      ; 009AEE 69 06 
  TAY                                             ; 009AF0 A8 
  DEC.B $04                                       ; 009AF1 C6 04 
  BNE.B B_9AC9                                    ; 009AF3 D0 D4 
  LDA.B #$FF                                      ; 009AF5 A9 FF 
  STA.W $19D6                                     ; 009AF7 8D D6 19 
B_9AFA:
  PLB                                             ; 009AFA AB 
  PLP                                             ; 009AFB 28 
  RTS                                             ; 009AFC 60 


D_9AFD:
.byte $00                                         ; 009AFE .        ?
D_9AFE:
.byte $00,$00,$98,$80,$98,$00,$99,$80             ; 009AFE .DDDDDDD ????????
.byte $99,$00,$9A,$80,$9A,$00,$9B,$80             ; 009B06 DDDDDDDD ????????
.byte $9B,$00,$A8,$80,$A8,$00,$A9,$80             ; 009B0E DDDDDDDD ????????
.byte $A9,$00,$AA,$80,$AA,$00,$AB,$00             ; 009B16 DDDDDDDD ????????
.byte $B8,$80,$B8,$00,$B9,$80,$B9,$00             ; 009B1E DDDDDDDD ????????
.byte $BA,$80,$BA,$00,$BB,$80,$BB,$00             ; 009B26 DDDDDDDD ????????
.byte $C8,$80,$C8,$00,$C9,$80,$C9,$00             ; 009B2E DDDDDDDD ????????
.byte $CA,$80,$CA,$00,$CB,$00,$D8,$80             ; 009B36 DDDDDDDD ????????
.byte $D8,$00,$D9,$80,$D9,$00,$DA,$80             ; 009B3E DDDDDDD. ????????
.byte $DA,$00,$C0,$00,$C1,$00,$C2,$80             ; 009B46 .DDDDDD. ????????
.byte $AB,$00,$DB,$80,$C0,$80,$C1,$80             ; 009B4E ...DDDDD ????????
.byte $C2,$80,$CB,$00,$00,$00,$00,$00             ; 009B56 D....... ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 009B5E ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 009B66 .......D ????????
.byte $80,$80,$80,$00,$81,$80,$81,$00             ; 009B6E DDDDDDDD ????????
.byte $82,$80,$82,$00,$83,$80,$83,$00             ; 009B76 DDDDDDDD ????????
.byte $90,$80,$90,$00,$91,$80,$91,$00             ; 009B7E DDDDDDDD ????????
.byte $92,$80,$92,$00,$93,$80,$93,$00             ; 009B86 DDDDDDDD ????????
.byte $A0,$80,$A0,$00,$A1,$80,$A1,$00             ; 009B8E DDDDDDDD ????????
.byte $A2,$80,$A2,$00,$A3,$80,$A3,$00             ; 009B96 DDDDDDDD ????????
.byte $B0,$80,$B0,$00,$B1,$80,$B1,$00             ; 009B9E DDDDDDDD ????????
.byte $B2,$80,$B2,$00,$B3,$80,$B3,$00             ; 009BA6 DDDDDDD. ????????
.byte $C0,$80,$C0,$00,$C1,$80,$C1,$00             ; 009BAE ........ ????????
.byte $C2,$80,$C2,$00,$C3,$80,$C3,$00             ; 009BB6 ........ ????????
.byte $D0,$80,$D0,$00,$D1,$80,$D1,$00             ; 009BBE ........ ????????
.byte $D2,$80,$D2,$00,$D3,$80,$D3,$00             ; 009BC6 ........ ????????
.byte $E0,$80,$E0,$00,$E1,$80,$E1,$00             ; 009BCE ........ ????????
.byte $E2,$80,$E2,$00,$E3,$80,$E3,$00             ; 009BD6 ........ ????????
.byte $F0                                         ; 009BDF .        ?
D_9BDF:
.byte $00,$7E,$7E,$7E,$7E,$7E,$7E,$7E             ; 009BDF .DDDDDDD ?~~~~~~~
.byte $7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E             ; 009BE7 DDDDDDDD ~~~~~~~~
.byte $7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E             ; 009BEF DDDDDDDD ~~~~~~~~
.byte $7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E             ; 009BF7 DDDDDDDD ~~~~~~~~
.byte $7E,$7E,$7E,$7E,$7E,$08,$08,$08             ; 009BFF DDDD.DDD ~~~~~???
.byte $7E,$7E,$08,$08,$08,$7E,$00,$00             ; 009C07 ..DDD... ~~???~??
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 009C0F ........ ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 009C17 DDDDDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 009C1F DDDDDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 009C27 DDDDDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 009C2F DDDDDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 009C37 ........ ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 009C3F ........ ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 009C47 ........ ????????
.byte $08                                         ; 009C50 .        ?
D_9C50:
.byte $00                                         ; 009C51 .        ?
D_9C51:
.byte $00,$00,$90,$40,$90,$80,$90,$C0             ; 009C51 .DDDDDDD ???@????
.byte $90,$00,$91,$40,$91,$00,$00,$00             ; 009C59 DDDDD... ???@????
.byte $00,$00,$8A,$40,$8A,$80,$8A,$C0             ; 009C61 .DDDDDDD ???@????
.byte $8A,$00,$8B,$40,$8B,$80,$8B,$00             ; 009C69 DDDDDDD. ???@????
.byte $00,$00,$88,$40,$88,$80,$88,$C0             ; 009C71 .DDDDDDD ???@????
.byte $88,$00,$89,$40,$89,$80,$89,$00             ; 009C79 DDDDDDD. ???@????
.byte $00,$00,$82,$40,$82,$80,$82,$C0             ; 009C81 .DDDDDDD ???@????
.byte $82,$00,$83,$40,$83,$00,$00,$00             ; 009C89 DDDDD... ???@????
.byte $00,$00,$80,$40,$80,$80,$80,$C0             ; 009C91 .DDDDDDD ???@????
.byte $80,$00,$81,$40,$81,$80,$81,$C0             ; 009C99 DDDDDDDD ???@????
.byte $81,$00,$92,$40,$92,$80,$92,$C0             ; 009CA1 DDDDDDDD ???@????
.byte $92,$00,$93,$00,$00,$00,$00,$00             ; 009CA9 DDD..... ????????
.byte $00                                         ; 009CB2 .        ?


L_9CB2:
  PHP                                             ; 009CB2 08 
  PHB                                             ; 009CB3 8B 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 009CB4 E2 30 
  LDA.B #$00                                      ; 009CB6 A9 00 
  PHA                                             ; 009CB8 48 
  PLB                                             ; 009CB9 AB 
  LDA.W $18E5                                     ; 009CBA AD E5 18 
  ORA.W $18ED                                     ; 009CBD 0D ED 18 
  BEQ.B B_9D1F                                    ; 009CC0 F0 5D 
  DEC.W $1868                                     ; 009CC2 CE 68 18 
  BNE.B B_9D1F                                    ; 009CC5 D0 58 
  LDA.B #$02                                      ; 009CC7 A9 02 
  STA.W $1868                                     ; 009CC9 8D 68 18 
  LDA.W $185E                                     ; 009CCC AD 5E 18 
  INC A
  CMP.B #$05                                      ; 009CD0 C9 05 
  BCC.B B_9CD6                                    ; 009CD2 90 02 
  LDA.B #$00                                      ; 009CD4 A9 00 
B_9CD6:
  STA.W $185E                                     ; 009CD6 8D 5E 18 
  LDA.B #$02                                      ; 009CD9 A9 02 
  STA.B $04                                       ; 009CDB 85 04 
  LDA.W $185E                                     ; 009CDD AD 5E 18 
  ASL                                             ; 009CE0 0A 
  TAX                                             ; 009CE1 AA 
  LDA.W D_A15A,X                                  ; 009CE2 BD 5A A1 
  STA.B $06                                       ; 009CE5 85 06 
  LDA.W D_A15B,X                                  ; 009CE7 BD 5B A1 
  STA.B $07                                       ; 009CEA 85 07 
  LDY.B #$00                                      ; 009CEC A0 00 
B_9CEE:
  LDA.B #$01                                      ; 009CEE A9 01 
  STA.W $19E4,Y                                   ; 009CF0 99 E4 19 
  LDA.B #$18                                      ; 009CF3 A9 18 
  STA.W $19E5,Y                                   ; 009CF5 99 E5 19 
  LDA.B $06                                       ; 009CF8 A5 06 
  STA.W $19E6,Y                                   ; 009CFA 99 E6 19 
  CLC                                             ; 009CFD 18 
  LDA.B $07                                       ; 009CFE A5 07 
  STA.W $19E7,Y                                   ; 009D00 99 E7 19 
  ADC.B #$04                                      ; 009D03 69 04 
  STA.B $07                                       ; 009D05 85 07 
  LDA.B #$06                                      ; 009D07 A9 06 
  STA.W $19E8,Y                                   ; 009D09 99 E8 19 
  LDA.B #$40                                      ; 009D0C A9 40 
  STA.W $19E9,Y                                   ; 009D0E 99 E9 19 
  TYA                                             ; 009D11 98 
  CLC                                             ; 009D12 18 
  ADC.B #$06                                      ; 009D13 69 06 
  TAY                                             ; 009D15 A8 
  DEC.B $04                                       ; 009D16 C6 04 
  BNE.B B_9CEE                                    ; 009D18 D0 D4 
  LDA.B #$FF                                      ; 009D1A A9 FF 
  STA.W $19F0                                     ; 009D1C 8D F0 19 
B_9D1F:
  LDA.W $18EE                                     ; 009D1F AD EE 18 
  BEQ.B B_9D81                                    ; 009D22 F0 5D 
  DEC.W $1869                                     ; 009D24 CE 69 18 
  BNE.B B_9D81                                    ; 009D27 D0 58 
  LDA.B #$03                                      ; 009D29 A9 03 
  STA.W $1869                                     ; 009D2B 8D 69 18 
  LDA.W $185F                                     ; 009D2E AD 5F 18 
  INC A
  CMP.B #$05                                      ; 009D32 C9 05 
  BCC.B B_9D38                                    ; 009D34 90 02 
  LDA.B #$00                                      ; 009D36 A9 00 
B_9D38:
  STA.W $185F                                     ; 009D38 8D 5F 18 
  LDA.B #$02                                      ; 009D3B A9 02 
  STA.B $04                                       ; 009D3D 85 04 
  LDA.W $185F                                     ; 009D3F AD 5F 18 
  ASL                                             ; 009D42 0A 
  TAX                                             ; 009D43 AA 
  LDA.W D_A164,X                                  ; 009D44 BD 64 A1 
  STA.B $06                                       ; 009D47 85 06 
  LDA.W D_A165,X                                  ; 009D49 BD 65 A1 
  STA.B $07                                       ; 009D4C 85 07 
  LDY.B #$00                                      ; 009D4E A0 00 
B_9D50:
  LDA.B #$01                                      ; 009D50 A9 01 
  STA.W $19F1,Y                                   ; 009D52 99 F1 19 
  LDA.B #$18                                      ; 009D55 A9 18 
  STA.W $19F2,Y                                   ; 009D57 99 F2 19 
  LDA.B $06                                       ; 009D5A A5 06 
  STA.W $19F3,Y                                   ; 009D5C 99 F3 19 
  CLC                                             ; 009D5F 18 
  LDA.B $07                                       ; 009D60 A5 07 
  STA.W $19F4,Y                                   ; 009D62 99 F4 19 
  ADC.B #$04                                      ; 009D65 69 04 
  STA.B $07                                       ; 009D67 85 07 
  LDA.B #$06                                      ; 009D69 A9 06 
  STA.W $19F5,Y                                   ; 009D6B 99 F5 19 
  LDA.B #$40                                      ; 009D6E A9 40 
  STA.W $19F6,Y                                   ; 009D70 99 F6 19 
  TYA                                             ; 009D73 98 
  CLC                                             ; 009D74 18 
  ADC.B #$06                                      ; 009D75 69 06 
  TAY                                             ; 009D77 A8 
  DEC.B $04                                       ; 009D78 C6 04 
  BNE.B B_9D50                                    ; 009D7A D0 D4 
  LDA.B #$FF                                      ; 009D7C A9 FF 
  STA.W $19FD                                     ; 009D7E 8D FD 19 
B_9D81:
  LDA.W $18F1                                     ; 009D81 AD F1 18 
  BEQ.B B_9DE3                                    ; 009D84 F0 5D 
  DEC.W $186A                                     ; 009D86 CE 6A 18 
  BNE.B B_9DE3                                    ; 009D89 D0 58 
  LDA.B #$02                                      ; 009D8B A9 02 
  STA.W $186A                                     ; 009D8D 8D 6A 18 
  LDA.W $1860                                     ; 009D90 AD 60 18 
  INC A
  CMP.B #$03                                      ; 009D94 C9 03 
  BCC.B B_9D9A                                    ; 009D96 90 02 
  LDA.B #$00                                      ; 009D98 A9 00 
B_9D9A:
  STA.W $1860                                     ; 009D9A 8D 60 18 
  LDA.B #$02                                      ; 009D9D A9 02 
  STA.B $04                                       ; 009D9F 85 04 
  LDA.W $1860                                     ; 009DA1 AD 60 18 
  ASL                                             ; 009DA4 0A 
  TAX                                             ; 009DA5 AA 
  LDA.W D_A16E,X                                  ; 009DA6 BD 6E A1 
  STA.B $06                                       ; 009DA9 85 06 
  LDA.W D_A16F,X                                  ; 009DAB BD 6F A1 
  STA.B $07                                       ; 009DAE 85 07 
  LDY.B #$00                                      ; 009DB0 A0 00 
B_9DB2:
  LDA.B #$01                                      ; 009DB2 A9 01 
  STA.W $19FE,Y                                   ; 009DB4 99 FE 19 
  LDA.B #$18                                      ; 009DB7 A9 18 
  STA.W $19FF,Y                                   ; 009DB9 99 FF 19 
  LDA.B $06                                       ; 009DBC A5 06 
  STA.W $1A00,Y                                   ; 009DBE 99 00 1A 
  CLC                                             ; 009DC1 18 
  LDA.B $07                                       ; 009DC2 A5 07 
  STA.W $1A01,Y                                   ; 009DC4 99 01 1A 
  ADC.B #$04                                      ; 009DC7 69 04 
  STA.B $07                                       ; 009DC9 85 07 
  LDA.B #$06                                      ; 009DCB A9 06 
  STA.W $1A02,Y                                   ; 009DCD 99 02 1A 
  LDA.B #$40                                      ; 009DD0 A9 40 
  STA.W $1A03,Y                                   ; 009DD2 99 03 1A 
  TYA                                             ; 009DD5 98 
  CLC                                             ; 009DD6 18 
  ADC.B #$06                                      ; 009DD7 69 06 
  TAY                                             ; 009DD9 A8 
  DEC.B $04                                       ; 009DDA C6 04 
  BNE.B B_9DB2                                    ; 009DDC D0 D4 
  LDA.B #$FF                                      ; 009DDE A9 FF 
  STA.W $1A0A                                     ; 009DE0 8D 0A 1A 
B_9DE3:
  LDA.W $05D1                                     ; 009DE3 AD D1 05 
  BEQ.B B_9E45                                    ; 009DE6 F0 5D 
  DEC.W $186B                                     ; 009DE8 CE 6B 18 
  BNE.B B_9E45                                    ; 009DEB D0 58 
  LDA.B #$03                                      ; 009DED A9 03 
  STA.W $186B                                     ; 009DEF 8D 6B 18 
  LDA.W $1861                                     ; 009DF2 AD 61 18 
  INC A
  CMP.B #$03                                      ; 009DF6 C9 03 
  BCC.B B_9DFC                                    ; 009DF8 90 02 
  LDA.B #$00                                      ; 009DFA A9 00 
B_9DFC:
  STA.W $1861                                     ; 009DFC 8D 61 18 
  LDA.B #$02                                      ; 009DFF A9 02 
  STA.B $04                                       ; 009E01 85 04 
  LDA.W $1861                                     ; 009E03 AD 61 18 
  ASL                                             ; 009E06 0A 
  TAX                                             ; 009E07 AA 
  LDA.W D_A176,X                                  ; 009E08 BD 76 A1 
  STA.B $06                                       ; 009E0B 85 06 
  LDA.W D_A177,X                                  ; 009E0D BD 77 A1 
  STA.B $07                                       ; 009E10 85 07 
  LDY.B #$00                                      ; 009E12 A0 00 
B_9E14:
  LDA.B #$01                                      ; 009E14 A9 01 
  STA.W $1A0B,Y                                   ; 009E16 99 0B 1A 
  LDA.B #$18                                      ; 009E19 A9 18 
  STA.W $1A0C,Y                                   ; 009E1B 99 0C 1A 
  LDA.B $06                                       ; 009E1E A5 06 
  STA.W $1A0D,Y                                   ; 009E20 99 0D 1A 
  CLC                                             ; 009E23 18 
  LDA.B $07                                       ; 009E24 A5 07 
  STA.W $1A0E,Y                                   ; 009E26 99 0E 1A 
  ADC.B #$04                                      ; 009E29 69 04 
  STA.B $07                                       ; 009E2B 85 07 
  LDA.B #$06                                      ; 009E2D A9 06 
  STA.W $1A0F,Y                                   ; 009E2F 99 0F 1A 
  LDA.B #$40                                      ; 009E32 A9 40 
  STA.W $1A10,Y                                   ; 009E34 99 10 1A 
  TYA                                             ; 009E37 98 
  CLC                                             ; 009E38 18 
  ADC.B #$06                                      ; 009E39 69 06 
  TAY                                             ; 009E3B A8 
  DEC.B $04                                       ; 009E3C C6 04 
  BNE.B B_9E14                                    ; 009E3E D0 D4 
  LDA.B #$FF                                      ; 009E40 A9 FF 
  STA.W $1A17                                     ; 009E42 8D 17 1A 
B_9E45:
  LDA.W $18F0                                     ; 009E45 AD F0 18 
  BEQ.B B_9EA7                                    ; 009E48 F0 5D 
  DEC.W $186C                                     ; 009E4A CE 6C 18 
  BNE.B B_9EA7                                    ; 009E4D D0 58 
  LDA.B #$06                                      ; 009E4F A9 06 
  STA.W $186C                                     ; 009E51 8D 6C 18 
  LDA.W $1862                                     ; 009E54 AD 62 18 
  INC A
  CMP.B #$08                                      ; 009E58 C9 08 
  BCC.B B_9E5E                                    ; 009E5A 90 02 
  LDA.B #$00                                      ; 009E5C A9 00 
B_9E5E:
  STA.W $1862                                     ; 009E5E 8D 62 18 
  LDA.B #$02                                      ; 009E61 A9 02 
  STA.B $04                                       ; 009E63 85 04 
  LDA.W $1862                                     ; 009E65 AD 62 18 
  ASL                                             ; 009E68 0A 
  TAX                                             ; 009E69 AA 
  LDA.W D_A14A,X                                  ; 009E6A BD 4A A1 
  STA.B $06                                       ; 009E6D 85 06 
  LDA.W D_A14B,X                                  ; 009E6F BD 4B A1 
  STA.B $07                                       ; 009E72 85 07 
  LDY.B #$00                                      ; 009E74 A0 00 
B_9E76:
  LDA.B #$01                                      ; 009E76 A9 01 
  STA.W $19D7,Y                                   ; 009E78 99 D7 19 
  LDA.B #$18                                      ; 009E7B A9 18 
  STA.W $19D8,Y                                   ; 009E7D 99 D8 19 
  LDA.B $06                                       ; 009E80 A5 06 
  STA.W $19D9,Y                                   ; 009E82 99 D9 19 
  CLC                                             ; 009E85 18 
  LDA.B $07                                       ; 009E86 A5 07 
  STA.W $19DA,Y                                   ; 009E88 99 DA 19 
  ADC.B #$04                                      ; 009E8B 69 04 
  STA.B $07                                       ; 009E8D 85 07 
  LDA.B #$06                                      ; 009E8F A9 06 
  STA.W $19DB,Y                                   ; 009E91 99 DB 19 
  LDA.B #$40                                      ; 009E94 A9 40 
  STA.W $19DC,Y                                   ; 009E96 99 DC 19 
  TYA                                             ; 009E99 98 
  CLC                                             ; 009E9A 18 
  ADC.B #$06                                      ; 009E9B 69 06 
  TAY                                             ; 009E9D A8 
  DEC.B $04                                       ; 009E9E C6 04 
  BNE.B B_9E76                                    ; 009EA0 D0 D4 
  LDA.B #$FF                                      ; 009EA2 A9 FF 
  STA.W $19E3                                     ; 009EA4 8D E3 19 
B_9EA7:
  LDA.W $18E4                                     ; 009EA7 AD E4 18 
  BEQ.B B_9F04                                    ; 009EAA F0 58 
  DEC.W $186D                                     ; 009EAC CE 6D 18 
  BNE.B B_9F04                                    ; 009EAF D0 53 
  LDA.B #$07                                      ; 009EB1 A9 07 
  STA.W $186D                                     ; 009EB3 8D 6D 18 
  LDA.W $1863                                     ; 009EB6 AD 63 18 
  INC A
  CMP.B #$07                                      ; 009EBA C9 07 
  BCC.B B_9EC0                                    ; 009EBC 90 02 
  LDA.B #$00                                      ; 009EBE A9 00 
B_9EC0:
  STA.W $1863                                     ; 009EC0 8D 63 18 
  LDA.B #$02                                      ; 009EC3 A9 02 
  STA.B $04                                       ; 009EC5 85 04 
  LDA.W $1863                                     ; 009EC7 AD 63 18 
  ASL                                             ; 009ECA 0A 
  TAX                                             ; 009ECB AA 
  LDA.W D_A13C,X                                  ; 009ECC BD 3C A1 
  STA.B $06                                       ; 009ECF 85 06 
  LDA.W D_A13D,X                                  ; 009ED1 BD 3D A1 
  STA.B $07                                       ; 009ED4 85 07 
  LDY.B #$00                                      ; 009ED6 A0 00 
B_9ED8:
  LDA.B #$01                                      ; 009ED8 A9 01 
  STA.W $1A35,Y                                   ; 009EDA 99 35 1A 
  LDA.B #$18                                      ; 009EDD A9 18 
  STA.W $1A36,Y                                   ; 009EDF 99 36 1A 
  LDA.B $06                                       ; 009EE2 A5 06 
  STA.W $1A37,Y                                   ; 009EE4 99 37 1A 
  CLC                                             ; 009EE7 18 
  LDA.B $07                                       ; 009EE8 A5 07 
  STA.W $1A38,Y                                   ; 009EEA 99 38 1A 
  ADC.B #$04                                      ; 009EED 69 04 
  STA.B $07                                       ; 009EEF 85 07 
  LDA.B #$06                                      ; 009EF1 A9 06 
  STA.W $1A39,Y                                   ; 009EF3 99 39 1A 
  TYA                                             ; 009EF6 98 
  CLC                                             ; 009EF7 18 
  ADC.B #$06                                      ; 009EF8 69 06 
  TAY                                             ; 009EFA A8 
  DEC.B $04                                       ; 009EFB C6 04 
  BNE.B B_9ED8                                    ; 009EFD D0 D9 
  LDA.B #$FF                                      ; 009EFF A9 FF 
  STA.W $1A41                                     ; 009F01 8D 41 1A 
B_9F04:
  LDA.W $18E8                                     ; 009F04 AD E8 18 
  BEQ.B B_9F61                                    ; 009F07 F0 58 
  DEC.W $186D                                     ; 009F09 CE 6D 18 
  BNE.B B_9F61                                    ; 009F0C D0 53 
  LDA.B #$08                                      ; 009F0E A9 08 
  STA.W $186D                                     ; 009F10 8D 6D 18 
  LDA.W $1863                                     ; 009F13 AD 63 18 
  INC A
  CMP.B #$07                                      ; 009F17 C9 07 
  BCC.B B_9F1D                                    ; 009F19 90 02 
  LDA.B #$00                                      ; 009F1B A9 00 
B_9F1D:
  STA.W $1863                                     ; 009F1D 8D 63 18 
  LDA.B #$02                                      ; 009F20 A9 02 
  STA.B $04                                       ; 009F22 85 04 
  LDA.W $1863                                     ; 009F24 AD 63 18 
  ASL                                             ; 009F27 0A 
  TAX                                             ; 009F28 AA 
  LDA.W D_A12E,X                                  ; 009F29 BD 2E A1 
  STA.B $06                                       ; 009F2C 85 06 
  LDA.W D_A12F,X                                  ; 009F2E BD 2F A1 
  STA.B $07                                       ; 009F31 85 07 
  LDY.B #$00                                      ; 009F33 A0 00 
B_9F35:
  LDA.B #$01                                      ; 009F35 A9 01 
  STA.W $1A35,Y                                   ; 009F37 99 35 1A 
  LDA.B #$18                                      ; 009F3A A9 18 
  STA.W $1A36,Y                                   ; 009F3C 99 36 1A 
  LDA.B $06                                       ; 009F3F A5 06 
  STA.W $1A37,Y                                   ; 009F41 99 37 1A 
  CLC                                             ; 009F44 18 
  LDA.B $07                                       ; 009F45 A5 07 
  STA.W $1A38,Y                                   ; 009F47 99 38 1A 
  ADC.B #$04                                      ; 009F4A 69 04 
  STA.B $07                                       ; 009F4C 85 07 
  LDA.B #$06                                      ; 009F4E A9 06 
  STA.W $1A39,Y                                   ; 009F50 99 39 1A 
  TYA                                             ; 009F53 98 
  CLC                                             ; 009F54 18 
  ADC.B #$06                                      ; 009F55 69 06 
  TAY                                             ; 009F57 A8 
  DEC.B $04                                       ; 009F58 C6 04 
  BNE.B B_9F35                                    ; 009F5A D0 D9 
  LDA.B #$FF                                      ; 009F5C A9 FF 
  STA.W $1A41                                     ; 009F5E 8D 41 1A 
B_9F61:
  LDA.W $18EC                                     ; 009F61 AD EC 18 
  BEQ.B B_9FBE                                    ; 009F64 F0 58 
  DEC.W $186E                                     ; 009F66 CE 6E 18 
  BNE.B B_9FBE                                    ; 009F69 D0 53 
  LDA.B #$08                                      ; 009F6B A9 08 
  STA.W $186E                                     ; 009F6D 8D 6E 18 
  LDA.W $1864                                     ; 009F70 AD 64 18 
  INC A
  CMP.B #$08                                      ; 009F74 C9 08 
  BCC.B B_9F7A                                    ; 009F76 90 02 
  LDA.B #$00                                      ; 009F78 A9 00 
B_9F7A:
  STA.W $1864                                     ; 009F7A 8D 64 18 
  LDA.B #$02                                      ; 009F7D A9 02 
  STA.B $04                                       ; 009F7F 85 04 
  LDA.W $1864                                     ; 009F81 AD 64 18 
  ASL                                             ; 009F84 0A 
  TAX                                             ; 009F85 AA 
  LDA.W D_A11E,X                                  ; 009F86 BD 1E A1 
  STA.B $06                                       ; 009F89 85 06 
  LDA.W D_A11F,X                                  ; 009F8B BD 1F A1 
  STA.B $07                                       ; 009F8E 85 07 
  LDY.B #$00                                      ; 009F90 A0 00 
B_9F92:
  LDA.B #$01                                      ; 009F92 A9 01 
  STA.W $1A42,Y                                   ; 009F94 99 42 1A 
  LDA.B #$18                                      ; 009F97 A9 18 
  STA.W $1A43,Y                                   ; 009F99 99 43 1A 
  LDA.B $06                                       ; 009F9C A5 06 
  STA.W $1A44,Y                                   ; 009F9E 99 44 1A 
  CLC                                             ; 009FA1 18 
  LDA.B $07                                       ; 009FA2 A5 07 
  STA.W $1A45,Y                                   ; 009FA4 99 45 1A 
  ADC.B #$04                                      ; 009FA7 69 04 
  STA.B $07                                       ; 009FA9 85 07 
  LDA.B #$06                                      ; 009FAB A9 06 
  STA.W $1A46,Y                                   ; 009FAD 99 46 1A 
  TYA                                             ; 009FB0 98 
  CLC                                             ; 009FB1 18 
  ADC.B #$06                                      ; 009FB2 69 06 
  TAY                                             ; 009FB4 A8 
  DEC.B $04                                       ; 009FB5 C6 04 
  BNE.B B_9F92                                    ; 009FB7 D0 D9 
  LDA.B #$FF                                      ; 009FB9 A9 FF 
  STA.W $1A4E                                     ; 009FBB 8D 4E 1A 
B_9FBE:
  LDA.W $18E7                                     ; 009FBE AD E7 18 
  BEQ.B B_A020                                    ; 009FC1 F0 5D 
  DEC.W $186F                                     ; 009FC3 CE 6F 18 
  BNE.B B_A020                                    ; 009FC6 D0 58 
  LDA.B #$05                                      ; 009FC8 A9 05 
  STA.W $186F                                     ; 009FCA 8D 6F 18 
  LDA.W $1865                                     ; 009FCD AD 65 18 
  INC A
  CMP.B #$09                                      ; 009FD1 C9 09 
  BCC.B B_9FD7                                    ; 009FD3 90 02 
  LDA.B #$00                                      ; 009FD5 A9 00 
B_9FD7:
  STA.W $1865                                     ; 009FD7 8D 65 18 
  LDA.B #$02                                      ; 009FDA A9 02 
  STA.B $04                                       ; 009FDC 85 04 
  LDA.W $1865                                     ; 009FDE AD 65 18 
  ASL                                             ; 009FE1 0A 
  TAX                                             ; 009FE2 AA 
  LDA.W D_A10C,X                                  ; 009FE3 BD 0C A1 
  STA.B $06                                       ; 009FE6 85 06 
  LDA.W D_A10D,X                                  ; 009FE8 BD 0D A1 
  STA.B $07                                       ; 009FEB 85 07 
  LDY.B #$00                                      ; 009FED A0 00 
B_9FEF:
  LDA.B #$01                                      ; 009FEF A9 01 
  STA.W $1A4F,Y                                   ; 009FF1 99 4F 1A 
  LDA.B #$18                                      ; 009FF4 A9 18 
  STA.W $1A50,Y                                   ; 009FF6 99 50 1A 
  LDA.B $06                                       ; 009FF9 A5 06 
  STA.W $1A51,Y                                   ; 009FFB 99 51 1A 
  CLC                                             ; 009FFE 18 
  LDA.B $07                                       ; 009FFF A5 07 
  STA.W $1A52,Y                                   ; 00A001 99 52 1A 
  ADC.B #$04                                      ; 00A004 69 04 
  STA.B $07                                       ; 00A006 85 07 
  LDA.B #$06                                      ; 00A008 A9 06 
  STA.W $1A53,Y                                   ; 00A00A 99 53 1A 
  LDA.B #$80                                      ; 00A00D A9 80 
  STA.W $1A54,Y                                   ; 00A00F 99 54 1A 
  TYA                                             ; 00A012 98 
  CLC                                             ; 00A013 18 
  ADC.B #$06                                      ; 00A014 69 06 
  TAY                                             ; 00A016 A8 
  DEC.B $04                                       ; 00A017 C6 04 
  BNE.B B_9FEF                                    ; 00A019 D0 D4 
  LDA.B #$FF                                      ; 00A01B A9 FF 
  STA.W $1A5B                                     ; 00A01D 8D 5B 1A 
B_A020:
  LDA.W $18EB                                     ; 00A020 AD EB 18 
  BEQ.B B_A089                                    ; 00A023 F0 64 
  DEC.W $1870                                     ; 00A025 CE 70 18 
  BNE.B B_A089                                    ; 00A028 D0 5F 
  LDY.B #$01                                      ; 00A02A A0 01 
  LDA.B $D2                                       ; 00A02C A5 D2 
  AND.B #$03                                      ; 00A02E 29 03 
  BNE.B B_A033                                    ; 00A030 D0 01 
  INY                                             ; 00A032 C8 
B_A033:
  STY.W $1870                                     ; 00A033 8C 70 18 
  LDA.W $1866                                     ; 00A036 AD 66 18 
  INC A
  CMP.B #$05                                      ; 00A03A C9 05 
  BCC.B B_A040                                    ; 00A03C 90 02 
  LDA.B #$00                                      ; 00A03E A9 00 
B_A040:
  STA.W $1866                                     ; 00A040 8D 66 18 
  LDA.B #$02                                      ; 00A043 A9 02 
  STA.B $04                                       ; 00A045 85 04 
  LDA.W $1866                                     ; 00A047 AD 66 18 
  ASL                                             ; 00A04A 0A 
  TAX                                             ; 00A04B AA 
  LDA.W D_A102,X                                  ; 00A04C BD 02 A1 
  STA.B $06                                       ; 00A04F 85 06 
  LDA.W D_A103,X                                  ; 00A051 BD 03 A1 
  STA.B $07                                       ; 00A054 85 07 
  LDY.B #$00                                      ; 00A056 A0 00 
B_A058:
  LDA.B #$01                                      ; 00A058 A9 01 
  STA.W $1A5C,Y                                   ; 00A05A 99 5C 1A 
  LDA.B #$18                                      ; 00A05D A9 18 
  STA.W $1A5D,Y                                   ; 00A05F 99 5D 1A 
  LDA.B $06                                       ; 00A062 A5 06 
  STA.W $1A5E,Y                                   ; 00A064 99 5E 1A 
  CLC                                             ; 00A067 18 
  LDA.B $07                                       ; 00A068 A5 07 
  STA.W $1A5F,Y                                   ; 00A06A 99 5F 1A 
  ADC.B #$04                                      ; 00A06D 69 04 
  STA.B $07                                       ; 00A06F 85 07 
  LDA.B #$06                                      ; 00A071 A9 06 
  STA.W $1A60,Y                                   ; 00A073 99 60 1A 
  LDA.B #$40                                      ; 00A076 A9 40 
  STA.W $1A61,Y                                   ; 00A078 99 61 1A 
  TYA                                             ; 00A07B 98 
  CLC                                             ; 00A07C 18 
  ADC.B #$06                                      ; 00A07D 69 06 
  TAY                                             ; 00A07F A8 
  DEC.B $04                                       ; 00A080 C6 04 
  BNE.B B_A058                                    ; 00A082 D0 D4 
  LDA.B #$FF                                      ; 00A084 A9 FF 
  STA.W $1A68                                     ; 00A086 8D 68 1A 
B_A089:
  DEC.W $1871                                     ; 00A089 CE 71 18 
  BNE.B B_A0E6                                    ; 00A08C D0 58 
  LDA.B #$04                                      ; 00A08E A9 04 
  STA.W $1871                                     ; 00A090 8D 71 18 
  LDA.W $1867                                     ; 00A093 AD 67 18 
  INC A
  CMP.B #$0A                                      ; 00A097 C9 0A 
  BCC.B B_A09D                                    ; 00A099 90 02 
  LDA.B #$00                                      ; 00A09B A9 00 
B_A09D:
  STA.W $1867                                     ; 00A09D 8D 67 18 
  LDA.B #$02                                      ; 00A0A0 A9 02 
  STA.B $04                                       ; 00A0A2 85 04 
  LDA.W $1867                                     ; 00A0A4 AD 67 18 
  ASL                                             ; 00A0A7 0A 
  TAX                                             ; 00A0A8 AA 
  LDA.W D_A0EC,X                                  ; 00A0A9 BD EC A0 
  STA.B $06                                       ; 00A0AC 85 06 
  LDA.W D_A0ED,X                                  ; 00A0AE BD ED A0 
  STA.B $07                                       ; 00A0B1 85 07 
  LDY.B #$00                                      ; 00A0B3 A0 00 
B_A0B5:
  LDA.B #$01                                      ; 00A0B5 A9 01 
  STA.W $1A69,Y                                   ; 00A0B7 99 69 1A 
  LDA.B #$18                                      ; 00A0BA A9 18 
  STA.W $1A6A,Y                                   ; 00A0BC 99 6A 1A 
  LDA.B $06                                       ; 00A0BF A5 06 
  STA.W $1A6B,Y                                   ; 00A0C1 99 6B 1A 
  CLC                                             ; 00A0C4 18 
  LDA.B $07                                       ; 00A0C5 A5 07 
  STA.W $1A6C,Y                                   ; 00A0C7 99 6C 1A 
  ADC.B #$04                                      ; 00A0CA 69 04 
  STA.B $07                                       ; 00A0CC 85 07 
  LDA.B #$06                                      ; 00A0CE A9 06 
  STA.W $1A6D,Y                                   ; 00A0D0 99 6D 1A 
  LDA.B #$40                                      ; 00A0D3 A9 40 
  STA.W $1A6E,Y                                   ; 00A0D5 99 6E 1A 
  TYA                                             ; 00A0D8 98 
  CLC                                             ; 00A0D9 18 
  ADC.B #$06                                      ; 00A0DA 69 06 
  TAY                                             ; 00A0DC A8 
  DEC.B $04                                       ; 00A0DD C6 04 
  BNE.B B_A0B5                                    ; 00A0DF D0 D4 
  LDA.B #$FF                                      ; 00A0E1 A9 FF 
  STA.W $1A75                                     ; 00A0E3 8D 75 1A 
B_A0E6:
  JSR.W L_A17C                                    ; 00A0E6 20 7C A1 
  PLB                                             ; 00A0E9 AB 
  PLP                                             ; 00A0EA 28 
  RTL                                             ; 00A0EB 6B 

D_A0EC:
.byte $80                                         ; 00A0ED D        ?
D_A0ED:
.byte $E0,$C0,$E0,$00,$E1,$40,$E1,$80             ; 00A0ED DDDDDDDD ?????@??
.byte $E1,$C0,$E1,$C0,$FA,$00,$FB,$40             ; 00A0F5 DDDDDDDD ???????@
.byte $FB,$80,$FB,$C0,$FB                         ; 00A0FE DDD..    ?????
D_A102:
.byte $40                                         ; 00A103 D        @
D_A103:
.byte $C1,$80,$C1,$C0,$C1,$00,$C2,$40             ; 00A103 DDDDDDDD ???????@
.byte $C2                                         ; 00A10C D        ?
D_A10C:
.byte $00                                         ; 00A10D D        ?
D_A10D:
.byte $D8,$80,$D8,$00,$D9,$80,$D9,$00             ; 00A10D DDDDDDDD ????????
.byte $DA,$80,$DA,$00,$DB,$80,$DB,$00             ; 00A115 DDDDDDDD ????????
.byte $E0                                         ; 00A11E D        ?
D_A11E:
.byte $80                                         ; 00A11F D        ?
D_A11F:
.byte $AA,$40,$AB,$80,$C2,$40,$C3,$40             ; 00A11F DDDDDDDD ?@???@?@
.byte $CB,$40,$C3,$80,$C2,$40,$AB                 ; 00A128 DDDDDDD  ?@???@?
D_A12E:
.byte $00                                         ; 00A12F D        ?
D_A12F:
.byte $E8,$40,$E9,$80,$EA,$00,$F0,$40             ; 00A12F DDDDDDDD ?@?????@
.byte $F1,$80,$F2,$00,$F8                         ; 00A138 DDDDD    ?????
D_A13C:
.byte $00                                         ; 00A13D D        ?
D_A13D:
.byte $98,$40,$99,$80,$9A,$00,$A0,$40             ; 00A13D DDDDDDDD ?@?????@
.byte $A1,$80,$A2,$00,$A8                         ; 00A146 DDDDD    ?????
D_A14A:
.byte $C0                                         ; 00A14B D        ?
D_A14B:
.byte $88,$00,$89,$40,$89,$80,$D3,$C0             ; 00A14B DDDDDDDD ???@????
.byte $D3,$80,$D3,$40,$89,$00,$89                 ; 00A154 DDDDDDD  ???@???
D_A15A:
.byte $00                                         ; 00A15B D        ?
D_A15B:
.byte $80,$40,$80,$80,$80,$C0,$80,$00             ; 00A15B DDDDDDDD ?@??????
.byte $81                                         ; 00A164 D        ?
D_A164:
.byte $40                                         ; 00A165 D        @
D_A165:
.byte $81,$80,$81,$C0,$81,$00,$82,$40             ; 00A165 DDDDDDDD ???????@
.byte $82                                         ; 00A16E D        ?
D_A16E:
.byte $80                                         ; 00A16F D        ?
D_A16F:
.byte $82,$C0,$82,$00,$83,$40,$83                 ; 00A170 DDDDD..  ?????@?
D_A176:
.byte $00                                         ; 00A177 D        ?
D_A177:
.byte $88,$40,$88,$80,$88                         ; 00A178 DDDDD    ?@???


L_A17C:
  LDY.W $1863                                     ; 00A17C AC 63 18 
  LDA.W D_A1E0,Y                                  ; 00A17F B9 E0 A1 
  STA.W $1A25                                     ; 00A182 8D 25 1A 
  LDA.W D_A218,Y                                  ; 00A185 B9 18 A2 
  STA.W $1A2D                                     ; 00A188 8D 2D 1A 
  LDA.W D_A1E7,Y                                  ; 00A18B B9 E7 A1 
  STA.W $1A26                                     ; 00A18E 8D 26 1A 
  LDA.W D_A21F,Y                                  ; 00A191 B9 1F A2 
  STA.W $1A2E                                     ; 00A194 8D 2E 1A 
  LDA.W D_A211,Y                                  ; 00A197 B9 11 A2 
  STA.W $1A2C                                     ; 00A19A 8D 2C 1A 
  LDA.W D_A249,Y                                  ; 00A19D B9 49 A2 
  STA.W $1A34                                     ; 00A1A0 8D 34 1A 
  LDA.W D_A1EE,Y                                  ; 00A1A3 B9 EE A1 
  STA.W $1A27                                     ; 00A1A6 8D 27 1A 
  LDA.W D_A226,Y                                  ; 00A1A9 B9 26 A2 
  STA.W $1A2F                                     ; 00A1AC 8D 2F 1A 
  LDA.W D_A20A,Y                                  ; 00A1AF B9 0A A2 
  STA.W $1A2B                                     ; 00A1B2 8D 2B 1A 
  LDA.W D_A242,Y                                  ; 00A1B5 B9 42 A2 
  STA.W $1A33                                     ; 00A1B8 8D 33 1A 
  LDA.W D_A1F5,Y                                  ; 00A1BB B9 F5 A1 
  STA.W $1A28                                     ; 00A1BE 8D 28 1A 
  LDA.W D_A22D,Y                                  ; 00A1C1 B9 2D A2 
  STA.W $1A30                                     ; 00A1C4 8D 30 1A 
  LDA.W D_A203,Y                                  ; 00A1C7 B9 03 A2 
  STA.W $1A2A                                     ; 00A1CA 8D 2A 1A 
  LDA.W D_A23B,Y                                  ; 00A1CD B9 3B A2 
  STA.W $1A32                                     ; 00A1D0 8D 32 1A 
  LDA.W D_A1FC,Y                                  ; 00A1D3 B9 FC A1 
  STA.W $1A29                                     ; 00A1D6 8D 29 1A 
  LDA.W D_A234,Y                                  ; 00A1D9 B9 34 A2 
  STA.W $1A31                                     ; 00A1DC 8D 31 1A 
  RTS                                             ; 00A1DF 60 


D_A1E0:
.byte $00,$00,$00,$00,$00,$00,$00                 ; 00A1E1 DDDDDDD  ???????
D_A1E7:
.byte $FE,$FF,$FF,$FE,$FF,$02,$02                 ; 00A1E8 DDDDDDD  ???????
D_A1EE:
.byte $00,$FF,$FF,$FF,$00,$02,$02                 ; 00A1EF DDDDDDD  ???????
D_A1F5:
.byte $00,$00,$00,$00,$00,$00,$00                 ; 00A1F6 DDDDDDD  ???????
D_A1FC:
.byte $00,$00,$00,$00,$00,$00,$01                 ; 00A1FD DDDDDDD  ???????
D_A203:
.byte $00,$00,$00,$00,$00,$00,$00                 ; 00A204 DDDDDDD  ???????
D_A20A:
.byte $01,$02,$02,$02,$01,$FF,$FF                 ; 00A20B DDDDDDD  ???????
D_A211:
.byte $02,$01,$01,$02,$01,$FE,$FE                 ; 00A212 DDDDDDD  ???????
D_A218:
.byte $00,$00,$00,$00,$00,$00,$00                 ; 00A219 DDDDDDD  ???????
D_A21F:
.byte $00,$00,$00,$00,$00,$00,$00                 ; 00A220 DDDDDDD  ???????
D_A226:
.byte $01,$01,$01,$01,$01,$01,$01                 ; 00A227 DDDDDDD  ???????
D_A22D:
.byte $00,$00,$00,$00,$00,$00,$00                 ; 00A22E DDDDDDD  ???????
D_A234:
.byte $00,$01,$01,$01,$01,$00,$00                 ; 00A235 DDDDDDD  ???????
D_A23B:
.byte $00,$00,$00,$00,$00,$00,$00                 ; 00A23C DDDDDDD  ???????
D_A242:
.byte $00,$00,$00,$00,$00,$00,$00                 ; 00A243 DDDDDDD  ???????
D_A249:
.byte $00,$00,$00,$00,$00,$00,$00                 ; 00A24A DDDDDDD  ???????


L_A250:
  PHP                                             ; 00A250 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00A251 E2 30 
  LDA.W $1901                                     ; 00A253 AD 01 19 
  BNE.B B_A262                                    ; 00A256 D0 0A 
  LDA.W $05E3                                     ; 00A258 AD E3 05 
  BEQ.B B_A262                                    ; 00A25B F0 05 
  DEC.W $05E3                                     ; 00A25D CE E3 05 
  BEQ.B B_A264                                    ; 00A260 F0 02 
B_A262:
  PLP                                             ; 00A262 28 
  RTS                                             ; 00A263 60 

B_A264:
  LDA.B #$03                                      ; 00A264 A9 03 
  STA.W $05E3                                     ; 00A266 8D E3 05 
  LDX.W $05E1                                     ; 00A269 AE E1 05 
  DEX                                             ; 00A26C CA 
  BNE.B B_A272                                    ; 00A26D D0 03 
  STZ.W $05E3                                     ; 00A26F 9C E3 05 
B_A272:
  STX.W $05E1                                     ; 00A272 8E E1 05 
  JSR.W L_A338                                    ; 00A275 20 38 A3 
  REP.B #P_Acc8Bit                                      ; 00A278 C2 20 
  LDY.B #$0A                                      ; 00A27A A0 0A 
B_A27C:
  LDA.W $05EA,Y                                   ; 00A27C B9 EA 05 
  AND.W #$EDFF                                    ; 00A27F 29 FF ED 
  STA.W $05EA,Y                                   ; 00A282 99 EA 05 
  LDA.W $05F6,Y                                   ; 00A285 B9 F6 05 
  AND.W #$EDFF                                    ; 00A288 29 FF ED 
  STA.W $05F6,Y                                   ; 00A28B 99 F6 05 
  LDA.W $0602,Y                                   ; 00A28E B9 02 06 
  AND.W #$EDFF                                    ; 00A291 29 FF ED 
  STA.W $0602,Y                                   ; 00A294 99 02 06 
  DEY                                             ; 00A297 88 
  DEY                                             ; 00A298 88 
  BPL.B B_A27C                                    ; 00A299 10 E1 
  LDA.W #$544D                                    ; 00A29B A9 4D 54 
  STA.W $05E8                                     ; 00A29E 8D E8 05 
  SEP.B #P_Acc8Bit                                      ; 00A2A1 E2 20 
  INC.W $05E5                                     ; 00A2A3 EE E5 05 
  PLP                                             ; 00A2A6 28 
  RTS                                             ; 00A2A7 60 


L_A2A8:
  PHP                                             ; 00A2A8 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00A2A9 E2 30 
  LDA.W $05E2                                     ; 00A2AB AD E2 05 
  BMI.B B_A2BA                                    ; 00A2AE 30 0A 
  LDA.W $05E3                                     ; 00A2B0 AD E3 05 
  BEQ.B B_A2BA                                    ; 00A2B3 F0 05 
  DEC.W $05E3                                     ; 00A2B5 CE E3 05 
  BEQ.B B_A2BC                                    ; 00A2B8 F0 02 
B_A2BA:
  PLP                                             ; 00A2BA 28 
  RTS                                             ; 00A2BB 60 

B_A2BC:
  LDA.B #$03                                      ; 00A2BC A9 03 
  STA.W $05E3                                     ; 00A2BE 8D E3 05 
  LDA.W $05E4                                     ; 00A2C1 AD E4 05 
  BEQ.B B_A2F5                                    ; 00A2C4 F0 2F 
  LDX.W $05E1                                     ; 00A2C6 AE E1 05 
  CPX.B #$03                                      ; 00A2C9 E0 03 
  BEQ.B B_A2E5                                    ; 00A2CB F0 18 
  INX                                             ; 00A2CD E8 
  CPX.B #$03                                      ; 00A2CE E0 03 
  BNE.B B_A2DF                                    ; 00A2D0 D0 0D 
  LDA.W $05D3                                     ; 00A2D2 AD D3 05 
  BNE.B B_A2DF                                    ; 00A2D5 D0 08 
  STZ.W $05E4                                     ; 00A2D7 9C E4 05 
  LDA.B #$78                                      ; 00A2DA A9 78 
  STA.W $05E3                                     ; 00A2DC 8D E3 05 
B_A2DF:
  STX.W $05E1                                     ; 00A2DF 8E E1 05 
  JMP.W D_A301                                    ; 00A2E2 4C 01 A3 
B_A2E5:
  LDA.W $05D3                                     ; 00A2E5 AD D3 05 
  BNE.B B_A2F2                                    ; 00A2E8 D0 08 
  STZ.W $05E4                                     ; 00A2EA 9C E4 05 
  LDA.B #$96                                      ; 00A2ED A9 96 
  STA.W $05E3                                     ; 00A2EF 8D E3 05 
B_A2F2:
  JMP.W D_A301                                    ; 00A2F2 4C 01 A3 
B_A2F5:
  LDX.W $05E1                                     ; 00A2F5 AE E1 05 
  DEX                                             ; 00A2F8 CA 
  BNE.B B_A2FE                                    ; 00A2F9 D0 03 
  STZ.W $05E3                                     ; 00A2FB 9C E3 05 
B_A2FE:
  STX.W $05E1                                     ; 00A2FE 8E E1 05 
D_A301:
  JSR.W L_A338                                    ; 00A301 20 38 A3 
  LDA.W $05D3                                     ; 00A304 AD D3 05 
  BEQ.B B_A329                                    ; 00A307 F0 20 
  PHB                                             ; 00A309 8B 
  LDA.B #$7E                                      ; 00A30A A9 7E 
  PHA                                             ; 00A30C 48 
  PLB                                             ; 00A30D AB 
  LDY.B #$0A                                      ; 00A30E A0 0A 
  REP.B #P_Acc8Bit                                      ; 00A310 C2 20 
B_A312:
  LDA.W $060E,Y                                   ; 00A312 B9 0E 06 
  STA.W $3448,Y                                   ; 00A315 99 48 34 
  LDA.W $061A,Y                                   ; 00A318 B9 1A 06 
  STA.W $3488,Y                                   ; 00A31B 99 88 34 
  LDA.W $0626,Y                                   ; 00A31E B9 26 06 
  STA.W $34C8,Y                                   ; 00A321 99 C8 34 
  DEY                                             ; 00A324 88 
  DEY                                             ; 00A325 88 
  BPL.B B_A312                                    ; 00A326 10 EA 
  PLB                                             ; 00A328 AB 
B_A329:
  REP.B #P_Acc8Bit                                      ; 00A329 C2 20 
  LDA.W #$504D                                    ; 00A32B A9 4D 50 
  STA.W $05E8                                     ; 00A32E 8D E8 05 
  SEP.B #P_Acc8Bit                                      ; 00A331 E2 20 
  INC.W $05E5                                     ; 00A333 EE E5 05 
  PLP                                             ; 00A336 28 
  RTS                                             ; 00A337 60 


L_A338:
  PHP                                             ; 00A338 08 
  PHB                                             ; 00A339 8B 
  LDA.W $05E2                                     ; 00A33A AD E2 05 
  ASL                                             ; 00A33D 0A 
  TAX                                             ; 00A33E AA 
  LDA.L D_A3A5,X                                  ; 00A33F BF A5 A3 00 
  STA.W $05E6                                     ; 00A343 8D E6 05 
  LDA.L D_A3A6,X                                  ; 00A346 BF A6 A3 00 
  STA.W $05E7                                     ; 00A34A 8D E7 05 
  PEA.W $0D0D                                     ; 00A34D F4 0D 0D 
  PLB                                             ; 00A350 AB 
  PLB                                             ; 00A351 AB 
  LDX.W $05E1                                     ; 00A352 AE E1 05 
  LDA.L D_A3A1,X                                  ; 00A355 BF A1 A3 00 
  CLC                                             ; 00A359 18 
  ADC.W $05E6                                     ; 00A35A 6D E6 05 
  STA.B $04                                       ; 00A35D 85 04 
  LDA.W $05E7                                     ; 00A35F AD E7 05 
  ADC.B #$00                                      ; 00A362 69 00 
  STA.B $05                                       ; 00A364 85 05 
  REP.B #P_Acc8Bit                                      ; 00A366 C2 20 
  LDY.B #$22                                      ; 00A368 A0 22 
B_A36A:
  LDA.W $060E,Y                                   ; 00A36A B9 0E 06 
  STA.W $05EA,Y                                   ; 00A36D 99 EA 05 
  DEY                                             ; 00A370 88 
  DEY                                             ; 00A371 88 
  BPL.B B_A36A                                    ; 00A372 10 F6 
  CLC                                             ; 00A374 18 
  LDA.B $04                                       ; 00A375 A5 04 
  ADC.W #$0040                                    ; 00A377 69 40 00 
  STA.B $06                                       ; 00A37A 85 06 
  CLC                                             ; 00A37C 18 
  ADC.W #$0040                                    ; 00A37D 69 40 00 
  STA.B $08                                       ; 00A380 85 08 
  LDY.B #$0A                                      ; 00A382 A0 0A 
B_A384:
  LDA.B ($04),Y                                   ; 00A384 B1 04 
  AND.W #$00FF                                    ; 00A386 29 FF 00 
  BEQ.B B_A39A                                    ; 00A389 F0 0F 
  LDA.B ($04),Y                                   ; 00A38B B1 04 
  STA.W $05EA,Y                                   ; 00A38D 99 EA 05 
  LDA.B ($06),Y                                   ; 00A390 B1 06 
  STA.W $05F6,Y                                   ; 00A392 99 F6 05 
  LDA.B ($08),Y                                   ; 00A395 B1 08 
  STA.W $0602,Y                                   ; 00A397 99 02 06 
B_A39A:
  DEY                                             ; 00A39A 88 
  DEY                                             ; 00A39B 88 
  BPL.B B_A384                                    ; 00A39C 10 E6 
  PLB                                             ; 00A39E AB 
  PLP                                             ; 00A39F 28 
  RTS                                             ; 00A3A0 60 


D_A3A1:
.byte $00,$0C,$18,$24                             ; 00A3A2 DDDD     ???$
D_A3A5:
.byte $23                                         ; 00A3A6 D        #
D_A3A6:
.byte $91,$E3,$91,$A3,$92                         ; 00A3A7 DDD..    ?????


L_A3AB:
  PHP                                             ; 00A3AB 08 
  PHB                                             ; 00A3AC 8B 
  PEA.W $0D0D                                     ; 00A3AD F4 0D 0D 
  PLB                                             ; 00A3B0 AB 
  PLB                                             ; 00A3B1 AB 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00A3B2 E2 30 
  LDA.W $0634                                     ; 00A3B4 AD 34 06 
  BEQ.B B_A402                                    ; 00A3B7 F0 49 

.byte $CE,$34,$06,$D0,$44,$AD,$36,$06             ; 00A3B9 ........ ?4??D?6?
.byte $0A,$AA,$C2,$20,$BF,$57,$A4,$00             ; 00A3C1 ........ ??? ?W??
.byte $85,$04,$18,$69,$40,$00,$85,$06             ; 00A3C9 ........ ???i@???
.byte $69,$40,$00,$85,$08,$69,$40,$00             ; 00A3D1 ........ i@???i@?
.byte $85,$0A,$BF,$53,$A4,$00,$85,$0C             ; 00A3D9 ........ ???S????
.byte $A0,$08,$B1,$04,$99,$38,$06,$B1             ; 00A3E1 ........ ?????8??
.byte $06,$05,$0C,$99,$42,$06,$B1,$08             ; 00A3E9 ........ ????B???
.byte $99,$4C,$06,$B1,$0A,$99,$56,$06             ; 00A3F1 ........ ?L????V?
.byte $88,$88,$10,$E6,$E2,$20,$EE,$32             ; 00A3F9 ........ ????? ?2
.byte $06                                         ; 00A402 .        ?

B_A402:
  LDA.W $0635                                     ; 00A402 AD 35 06 
  BEQ.B B_A450                                    ; 00A405 F0 49 

.byte $CE,$35,$06,$D0,$44,$AD,$37,$06             ; 00A407 ........ ?5??D?7?
.byte $0A,$AA,$C2,$20,$BF,$5B,$A4,$00             ; 00A40F ........ ??? ?[??
.byte $85,$04,$18,$69,$40,$00,$85,$06             ; 00A417 ........ ???i@???
.byte $69,$40,$00,$85,$08,$69,$40,$00             ; 00A41F ........ i@???i@?
.byte $85,$0A,$BF,$53,$A4,$00,$85,$0C             ; 00A427 ........ ???S????
.byte $A0,$08,$B1,$04,$99,$60,$06,$B1             ; 00A42F ........ ?????`??
.byte $06,$05,$0C,$99,$6A,$06,$B1,$08             ; 00A437 ........ ????j???
.byte $99,$74,$06,$B1,$0A,$99,$7E,$06             ; 00A43F ........ ?t????~?
.byte $88,$88,$10,$E6,$E2,$20,$EE,$33             ; 00A447 ........ ????? ?3
.byte $06                                         ; 00A450 .        ?

B_A450:
  PLB                                             ; 00A450 AB 
  PLP                                             ; 00A451 28 
  RTS                                             ; 00A452 60 


.byte $00,$00,$00,$20,$63,$93,$6D,$93             ; 00A453 ........ ??? c?m?
.byte $77,$93,$81,$93                             ; 00A45C ....     w???


L_A45F:
  PHP                                             ; 00A45F 08 
  JSL L_EC9AC                                     ; 00A460 22 AC C9 0E 
  JSL L_EC97A                                     ; 00A464 22 7A C9 0E 
  REP.B #$10                                      ; 00A468 C2 10 
  SEP.B #P_Acc8Bit                                      ; 00A46A E2 20 
  LDA.B #$09                                      ; 00A46C A9 09 
  STA.W BGMODE                                    ; 00A46E 8D 05 21 
  LDA.B #$49                                      ; 00A471 A9 49 
  STA.W BG1SC                                     ; 00A473 8D 07 21 
  LDA.B #$51                                      ; 00A476 A9 51 
  STA.W BG2SC                                     ; 00A478 8D 08 21 
  LDA.B #$59                                      ; 00A47B A9 59 
  STA.W BG3SC                                     ; 00A47D 8D 09 21 
  STZ.W BG12NBA                                   ; 00A480 9C 0B 21 
  LDA.B #$04                                      ; 00A483 A9 04 
  STA.W BG34NBA                                   ; 00A485 8D 0C 21 
  STZ.W BG1HOFS                                   ; 00A488 9C 0D 21 
  STZ.W BG1HOFS                                   ; 00A48B 9C 0D 21 
  STZ.W BG2HOFS                                   ; 00A48E 9C 0F 21 
  STZ.W BG2HOFS                                   ; 00A491 9C 0F 21 
  STZ.W BG3HOFS                                   ; 00A494 9C 11 21 
  STZ.W BG3HOFS                                   ; 00A497 9C 11 21 
  STZ.W BG1VOFS                                   ; 00A49A 9C 0E 21 
  STZ.W BG1VOFS                                   ; 00A49D 9C 0E 21 
  STZ.W BG2VOFS                                   ; 00A4A0 9C 10 21 
  STZ.W BG2VOFS                                   ; 00A4A3 9C 10 21 
  STZ.W BG3VOFS                                   ; 00A4A6 9C 12 21 
  STZ.W BG3VOFS                                   ; 00A4A9 9C 12 21 
  LDA.B #$80                                      ; 00A4AC A9 80 
  STA.W VMAIN                                     ; 00A4AE 8D 15 21 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00A4B1 C2 30 
  LDX.W #$3BAE                                    ; 00A4B3 A2 AE 3B 
  LDA.W #$CFAD                                    ; 00A4B6 A9 AD CF 
  LDY.W #$000F                                    ; 00A4B9 A0 0F 00 
  JSL L_58000                                     ; 00A4BC 22 00 80 05 
  SEP.B #P_Acc8Bit                                      ; 00A4C0 E2 20 
  PHB                                             ; 00A4C2 8B 
  LDA.B #$7E                                      ; 00A4C3 A9 7E 
  PHA                                             ; 00A4C5 48 
  PLB                                             ; 00A4C6 AB 
  LDX.W #$07FF                                    ; 00A4C7 A2 FF 07 
B_A4CA:
  LDA.W $3BAE,X                                   ; 00A4CA BD AE 3B 
  ORA.B #$12                                      ; 00A4CD 09 12 
  STA.W $3BAE,X                                   ; 00A4CF 9D AE 3B 
  DEX                                             ; 00A4D2 CA 
  DEX                                             ; 00A4D3 CA 
  BPL.B B_A4CA                                    ; 00A4D4 10 F4 
  LDA.W $3DBD                                     ; 00A4D6 AD BD 3D 
  ORA.B #$20                                      ; 00A4D9 09 20 
  STA.W $3DBD                                     ; 00A4DB 8D BD 3D 
  LDA.W $3DFD                                     ; 00A4DE AD FD 3D 
  ORA.B #$20                                      ; 00A4E1 09 20 
  STA.W $3DFD                                     ; 00A4E3 8D FD 3D 
  LDA.W $3DBF                                     ; 00A4E6 AD BF 3D 
  ORA.B #$20                                      ; 00A4E9 09 20 
  STA.W $3DBF                                     ; 00A4EB 8D BF 3D 
  LDA.W $3DFF                                     ; 00A4EE AD FF 3D 
  ORA.B #$20                                      ; 00A4F1 09 20 
  STA.W $3DFF                                     ; 00A4F3 8D FF 3D 
  LDA.W $3DDD                                     ; 00A4F6 AD DD 3D 
  ORA.B #$20                                      ; 00A4F9 09 20 
  STA.W $3DDD                                     ; 00A4FB 8D DD 3D 
  LDA.W $3E1D                                     ; 00A4FE AD 1D 3E 
  ORA.B #$20                                      ; 00A501 09 20 
  STA.W $3E1D                                     ; 00A503 8D 1D 3E 
  LDA.W $3DDF                                     ; 00A506 AD DF 3D 
  ORA.B #$20                                      ; 00A509 09 20 
  STA.W $3DDF                                     ; 00A50B 8D DF 3D 
  LDA.W $3E1F                                     ; 00A50E AD 1F 3E 
  ORA.B #$20                                      ; 00A511 09 20 
  STA.W $3E1F                                     ; 00A513 8D 1F 3E 
  PLB                                             ; 00A516 AB 
  LDA.B #$80                                      ; 00A517 A9 80 
  STA.W VMAIN                                     ; 00A519 8D 15 21 
  LDX.W #$5000                                    ; 00A51C A2 00 50 
  STX.W VMADDL                                    ; 00A51F 8E 16 21 
  LDX.W #$1801                                    ; 00A522 A2 01 18 
  STX.W DMAP1                                     ; 00A525 8E 10 43 
  LDX.W #$3BAE                                    ; 00A528 A2 AE 3B 
  STX.W A1T1L                                     ; 00A52B 8E 12 43 
  LDA.B #$7E                                      ; 00A52E A9 7E 
  STA.W A1B1                                      ; 00A530 8D 14 43 
  LDX.W #$0800                                    ; 00A533 A2 00 08 
  STX.W DAS1L                                     ; 00A536 8E 15 43 
  LDA.B #$02                                      ; 00A539 A9 02 
  STA.W MDMAEN                                    ; 00A53B 8D 0B 42 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00A53E C2 30 
  LDX.W #$3BAE                                    ; 00A540 A2 AE 3B 
  LDA.W #$D55B                                    ; 00A543 A9 5B D5 
  LDY.W #$000F                                    ; 00A546 A0 0F 00 
  JSL L_58000                                     ; 00A549 22 00 80 05 
  SEP.B #P_Acc8Bit                                      ; 00A54D E2 20 
  PHB                                             ; 00A54F 8B 
  LDA.B #$7E                                      ; 00A550 A9 7E 
  PHA                                             ; 00A552 48 
  PLB                                             ; 00A553 AB 
  LDX.W #$07FF                                    ; 00A554 A2 FF 07 
B_A557:
  LDA.W $3BAE,X                                   ; 00A557 BD AE 3B 
  ORA.B #$12                                      ; 00A55A 09 12 
  STA.W $3BAE,X                                   ; 00A55C 9D AE 3B 
  DEX                                             ; 00A55F CA 
  DEX                                             ; 00A560 CA 
  BPL.B B_A557                                    ; 00A561 10 F4 
  PLB                                             ; 00A563 AB 
  LDA.B #$80                                      ; 00A564 A9 80 
  STA.W VMAIN                                     ; 00A566 8D 15 21 
  LDX.W #$4800                                    ; 00A569 A2 00 48 
  STX.W VMADDL                                    ; 00A56C 8E 16 21 
  LDX.W #$1801                                    ; 00A56F A2 01 18 
  STX.W DMAP1                                     ; 00A572 8E 10 43 
  LDX.W #$3BAE                                    ; 00A575 A2 AE 3B 
  STX.W A1T1L                                     ; 00A578 8E 12 43 
  LDA.B #$7E                                      ; 00A57B A9 7E 
  STA.W A1B1                                      ; 00A57D 8D 14 43 
  LDX.W #$0800                                    ; 00A580 A2 00 08 
  STX.W DAS1L                                     ; 00A583 8E 15 43 
  LDA.B #$02                                      ; 00A586 A9 02 
  STA.W MDMAEN                                    ; 00A588 8D 0B 42 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00A58B C2 30 
  LDX.W #$3BAE                                    ; 00A58D A2 AE 3B 
  LDA.W #$D6D5                                    ; 00A590 A9 D5 D6 
  LDY.W #$000F                                    ; 00A593 A0 0F 00 
  JSL L_58000                                     ; 00A596 22 00 80 05 
  SEP.B #P_Acc8Bit                                      ; 00A59A E2 20 
  LDA.B #$80                                      ; 00A59C A9 80 
  STA.W VMAIN                                     ; 00A59E 8D 15 21 
  LDX.W #$2000                                    ; 00A5A1 A2 00 20 
  STX.W VMADDL                                    ; 00A5A4 8E 16 21 
  LDX.W #$1801                                    ; 00A5A7 A2 01 18 
  STX.W DMAP1                                     ; 00A5AA 8E 10 43 
  LDX.W #$3BAE                                    ; 00A5AD A2 AE 3B 
  STX.W A1T1L                                     ; 00A5B0 8E 12 43 
  LDA.B #$7E                                      ; 00A5B3 A9 7E 
  STA.W A1B1                                      ; 00A5B5 8D 14 43 
  LDX.W #$4000                                    ; 00A5B8 A2 00 40 
  STX.W DAS1L                                     ; 00A5BB 8E 15 43 
  LDA.B #$02                                      ; 00A5BE A9 02 
  STA.W MDMAEN                                    ; 00A5C0 8D 0B 42 
  SEP.B #P_Acc8Bit                                      ; 00A5C3 E2 20 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00A5C5 C2 30 
  LDX.W #$3BAE                                    ; 00A5C7 A2 AE 3B 
  LDA.W #$8000                                    ; 00A5CA A9 00 80 
  LDY.W #$0002                                    ; 00A5CD A0 02 00 
  JSL L_58000                                     ; 00A5D0 22 00 80 05 
  SEP.B #P_Acc8Bit                                      ; 00A5D4 E2 20 
  LDA.B #$80                                      ; 00A5D6 A9 80 
  STA.W VMAIN                                     ; 00A5D8 8D 15 21 
  LDX.W #$4000                                    ; 00A5DB A2 00 40 
  STX.W VMADDL                                    ; 00A5DE 8E 16 21 
  LDX.W #$1801                                    ; 00A5E1 A2 01 18 
  STX.W DMAP1                                     ; 00A5E4 8E 10 43 
  LDX.W #$3BAE                                    ; 00A5E7 A2 AE 3B 
  STX.W A1T1L                                     ; 00A5EA 8E 12 43 
  LDA.B #$7E                                      ; 00A5ED A9 7E 
  STA.W A1B1                                      ; 00A5EF 8D 14 43 
  LDX.W #$1000                                    ; 00A5F2 A2 00 10 
  STX.W DAS1L                                     ; 00A5F5 8E 15 43 
  LDA.B #$02                                      ; 00A5F8 A9 02 
  STA.W MDMAEN                                    ; 00A5FA 8D 0B 42 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00A5FD C2 30 
  LDX.W #$3BAE                                    ; 00A5FF A2 AE 3B 
  LDA.W #$8EEA                                    ; 00A602 A9 EA 8E 
  LDY.W #$0002                                    ; 00A605 A0 02 00 
  JSL L_58000                                     ; 00A608 22 00 80 05 
  SEP.B #P_Acc8Bit                                      ; 00A60C E2 20 
  LDA.B #$80                                      ; 00A60E A9 80 
  STA.W VMAIN                                     ; 00A610 8D 15 21 
  LDX.W #$6000                                    ; 00A613 A2 00 60 
  STX.W VMADDL                                    ; 00A616 8E 16 21 
  LDX.W #$1801                                    ; 00A619 A2 01 18 
  STX.W DMAP1                                     ; 00A61C 8E 10 43 
  LDX.W #$3BAE                                    ; 00A61F A2 AE 3B 
  STX.W A1T1L                                     ; 00A622 8E 12 43 
  LDA.B #$7E                                      ; 00A625 A9 7E 
  STA.W A1B1                                      ; 00A627 8D 14 43 
  LDX.W #$3000                                    ; 00A62A A2 00 30 
  STX.W DAS1L                                     ; 00A62D 8E 15 43 
  LDA.B #$02                                      ; 00A630 A9 02 
  STA.W MDMAEN                                    ; 00A632 8D 0B 42 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00A635 C2 30 
  JSR.W L_9311                                    ; 00A637 20 11 93 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00A63A C2 30 
  LDX.W #$3BAE                                    ; 00A63C A2 AE 3B 
  LDA.W #$E067                                    ; 00A63F A9 67 E0 
  LDY.W #$000D                                    ; 00A642 A0 0D 00 
  JSL L_58000                                     ; 00A645 22 00 80 05 
  SEP.B #P_Acc8Bit                                      ; 00A649 E2 20 
  LDA.B #$80                                      ; 00A64B A9 80 
  STA.W VMAIN                                     ; 00A64D 8D 15 21 
  LDX.W #$7800                                    ; 00A650 A2 00 78 
  STX.W VMADDL                                    ; 00A653 8E 16 21 
  LDX.W #$1801                                    ; 00A656 A2 01 18 
  STX.W DMAP1                                     ; 00A659 8E 10 43 
  LDX.W #$3BAE                                    ; 00A65C A2 AE 3B 
  STX.W A1T1L                                     ; 00A65F 8E 12 43 
  LDA.B #$7E                                      ; 00A662 A9 7E 
  STA.W A1B1                                      ; 00A664 8D 14 43 
  LDX.W #$1000                                    ; 00A667 A2 00 10 
  STX.W DAS1L                                     ; 00A66A 8E 15 43 
  LDA.B #$02                                      ; 00A66D A9 02 
  STA.W MDMAEN                                    ; 00A66F 8D 0B 42 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00A672 C2 30 
  LDX.W #$20AE                                    ; 00A674 A2 AE 20 
  LDA.W #$DD9D                                    ; 00A677 A9 9D DD 
  LDY.W #$000D                                    ; 00A67A A0 0D 00 
  JSL L_58000                                     ; 00A67D 22 00 80 05 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00A681 E2 30 
  STZ.W CGADD                                     ; 00A683 9C 21 21 
  LDA.W D_A755                                    ; 00A686 AD 55 A7 
  STA.W CGDATA                                    ; 00A689 8D 22 21 
  LDA.W D_A756                                    ; 00A68C AD 56 A7 
  STA.W CGDATA                                    ; 00A68F 8D 22 21 
  LDA.B #$40                                      ; 00A692 A9 40 
  STA.W CGADD                                     ; 00A694 8D 21 21 
  LDY.B #$40                                      ; 00A697 A0 40 
  LDX.B #$00                                      ; 00A699 A2 00 
B_A69B:
  LDA.W D_A755,X                                  ; 00A69B BD 55 A7 
  STA.W CGDATA                                    ; 00A69E 8D 22 21 
  INX                                             ; 00A6A1 E8 
  LDA.W D_A755,X                                  ; 00A6A2 BD 55 A7 
  STA.W CGDATA                                    ; 00A6A5 8D 22 21 
  INX                                             ; 00A6A8 E8 
  DEY                                             ; 00A6A9 88 
  BNE.B B_A69B                                    ; 00A6AA D0 EF 
  LDA.B #$80                                      ; 00A6AC A9 80 
  STA.W CGADD                                     ; 00A6AE 8D 21 21 
  LDY.B #$80                                      ; 00A6B1 A0 80 
  LDX.B #$00                                      ; 00A6B3 A2 00 
B_A6B5:
  LDA.W D_A7D5,X                                  ; 00A6B5 BD D5 A7 
  STA.W CGDATA                                    ; 00A6B8 8D 22 21 
  INX                                             ; 00A6BB E8 
  LDA.W D_A7D5,X                                  ; 00A6BC BD D5 A7 
  STA.W CGDATA                                    ; 00A6BF 8D 22 21 
  INX                                             ; 00A6C2 E8 
  DEY                                             ; 00A6C3 88 
  BNE.B B_A6B5                                    ; 00A6C4 D0 EF 
  REP.B #$10                                      ; 00A6C6 C2 10 
  LDX.W #$01FF                                    ; 00A6C8 A2 FF 01 
  LDA.B #$F0                                      ; 00A6CB A9 F0 
B_A6CD:
  STA.W $0308,X                                   ; 00A6CD 9D 08 03 
  DEX                                             ; 00A6D0 CA 
  BPL.B B_A6CD                                    ; 00A6D1 10 FA 
  LDY.W #$0000                                    ; 00A6D3 A0 00 00 
  LDX.W #$0000                                    ; 00A6D6 A2 00 00 
B_A6D9:
  LDA.B #$F0                                      ; 00A6D9 A9 F0 
  TXA                                             ; 00A6DB 8A 
  STA.W $0308,Y                                   ; 00A6DC 99 08 03 
  LDA.B #$F0                                      ; 00A6DF A9 F0 
  STA.W XexzyTorsoY,Y                             ; 00A6E1 99 09 03 
  LDA.B #$00                                      ; 00A6E4 A9 00 
  STA.W $030A,Y                                   ; 00A6E6 99 0A 03 
  LDA.B #$20                                      ; 00A6E9 A9 20 
  STA.W $030B,Y                                   ; 00A6EB 99 0B 03 
  INX                                             ; 00A6EE E8 
  INX                                             ; 00A6EF E8 
  INY                                             ; 00A6F0 C8 
  INY                                             ; 00A6F1 C8 
  INY                                             ; 00A6F2 C8 
  INY                                             ; 00A6F3 C8 
  CPY.W #$0200                                    ; 00A6F4 C0 00 02 
  BNE.B B_A6D9                                    ; 00A6F7 D0 E0 
  LDY.W #$0000                                    ; 00A6F9 A0 00 00 
  LDA.B #$00                                      ; 00A6FC A9 00 
B_A6FE:
  STA.W $0508,Y                                   ; 00A6FE 99 08 05 
  STA.W $0509,Y                                   ; 00A701 99 09 05 
  INY                                             ; 00A704 C8 
  INY                                             ; 00A705 C8 
  CPY.W #$0020                                    ; 00A706 C0 20 00 
  BNE.B B_A6FE                                    ; 00A709 D0 F3 
  JSL L_AE6F                                      ; 00A70B 22 6F AE 00 
  JSL L_38000                                     ; 00A70F 22 00 80 03 
  JSL L_AF0E                                      ; 00A713 22 0E AF 00 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00A717 E2 30 
  STZ.W $06CD                                     ; 00A719 9C CD 06 
  STZ.W $06CE                                     ; 00A71C 9C CE 06 
  STZ.W $06D0                                     ; 00A71F 9C D0 06 
  STZ.W $06D1                                     ; 00A722 9C D1 06 
  LDA.B #$25                                      ; 00A725 A9 25 
  STA.W WH0                                       ; 00A727 8D 26 21 
  STA.W WH2                                       ; 00A72A 8D 28 21 
  LDA.B #$DA                                      ; 00A72D A9 DA 
  STA.W WH1                                       ; 00A72F 8D 27 21 
  STA.W WH3                                       ; 00A732 8D 29 21 
  LDA.B #$0B                                      ; 00A735 A9 0B 
  STA.W WOBJSEL                                   ; 00A737 8D 25 21 
  STA.W W12SEL                                    ; 00A73A 8D 23 21 
  LDA.B #$4A                                      ; 00A73D A9 4A 
  STA.W BG1SC                                     ; 00A73F 8D 07 21 
  LDA.B #$63                                      ; 00A742 A9 63 
  STA.W OBSEL                                     ; 00A744 8D 01 21 
  LDA.B #$17                                      ; 00A747 A9 17 
  LDX.W CurrentRoom                                     ; 00A749 AE AC 05 
  BEQ.B B_A750                                    ; 00A74C F0 02 

.byte $A9,$16                                     ; 00A74F ..       ??

B_A750:
  STA.W TM                                        ; 00A750 8D 2C 21 
  PLP                                             ; 00A753 28 
  RTS                                             ; 00A754 60 


D_A755:
.byte $00                                         ; 00A756 D        ?
D_A756:
.byte $00,$02,$28,$03,$40,$05,$5C,$26             ; 00A756 DDDDDDDD ??(?@?\&
.byte $68,$88,$6C,$FF,$03,$52,$02,$12             ; 00A75E DDDDDDDD h?l??R??
.byte $00,$37,$00,$7E,$04,$C6,$18,$08             ; 00A766 DDDDDDDD ?7?~????
.byte $21,$4A,$29,$52,$4A,$F7,$5E,$00             ; 00A76E DDDDDDDD !J)RJ?^?
.byte $00,$9F,$21,$DF,$02,$00,$46,$40             ; 00A776 DDDDDDDD ??!???F@
.byte $6F,$DF,$7B,$7E,$04,$37,$00,$12             ; 00A77E DDDDDDDD o?{~?7??
.byte $00,$0D,$00,$26,$68,$64,$08,$E7             ; 00A786 DDDDDDDD ???&hd??
.byte $1C,$6C,$29,$32,$42,$18,$63,$00             ; 00A78E DDDDDDDD ?l)2B?c?
.byte $00,$0C,$00,$10,$00,$13,$00,$37             ; 00A796 DDDDDDDD ???????7
.byte $00,$5A,$00,$03,$61,$DE,$11,$5E             ; 00A79E DDDDDDDD ?Z??a??^
.byte $1A,$FE,$22,$7F,$2B,$22,$2C,$24             ; 00A7A6 DDDDDDDD ??"?+",$
.byte $4C,$73,$4E,$5A,$6B,$8C,$31,$00             ; 00A7AE DDDDDDDD LsNZk?1?
.byte $00,$E0,$24,$40,$39,$C0,$4D,$01             ; 00A7B6 DDDDDDDD ??$@9?M?
.byte $14,$22,$2C,$07,$00,$A0,$18,$C0             ; 00A7BE DDDDDDDD ?",?????
.byte $00,$40,$01,$C6,$00,$29,$01,$6E             ; 00A7C6 DDDDDDDD ?@???)?n
.byte $01,$68,$04,$8A,$04,$05,$10                 ; 00A7CF DDDDDDD  ?h?????
D_A7D5:
.byte $00,$00,$F7,$72,$F7,$72,$F7,$72             ; 00A7D5 DDDDDDDD ???r?r?r
.byte $F7,$72,$F7,$72,$F7,$72,$F7,$72             ; 00A7DD DDDDDDDD ?r?r?r?r
.byte $F7,$72,$F7,$72,$F7,$72,$F7,$72             ; 00A7E5 DDDDDDDD ?r?r?r?r
.byte $F7,$72,$F7,$72,$F7,$72,$F7,$72             ; 00A7ED DDDDDDDD ?r?r?r?r
.byte $00,$00,$57,$08,$FC,$04,$12,$00             ; 00A7F5 DDDDDDDD ??W?????
.byte $BE,$01,$0F,$00,$9F,$02,$1F,$03             ; 00A7FD DDDDDDDD ????????
.byte $7F,$03,$09,$00,$E7,$58,$6B,$61             ; 00A805 DDDDDDDD ?????Xka
.byte $EF,$69,$94,$72,$FF,$03,$5A,$7F             ; 00A80D DDDDDDDD ?i?r??Z?
.byte $00,$00,$E0,$03,$D2,$0C,$F5,$10             ; 00A815 DDDDDDDD ????????
.byte $3B,$15,$BE,$29,$A4,$34,$06,$45             ; 00A81D DDDDDDDD ;??)?4?E
.byte $57,$32,$47,$5D,$C8,$6D,$84,$10             ; 00A825 DDDDDDDD W2G]?m??
.byte $29,$25,$AD,$35,$20,$02,$D6,$5A             ; 00A82D DDDDDDDD )%?5 ??Z
.byte $00,$00,$E0,$03,$8C,$10,$D0,$14             ; 00A835 DDDDDDDD ????????
.byte $74,$15,$B4,$19,$2D,$04,$31,$04             ; 00A83D DDDDDDDD t???-?1?
.byte $57,$32,$55,$08,$3A,$09,$84,$10             ; 00A845 DDDDDDDD W2U?:???
.byte $29,$25,$AD,$35,$93,$35,$D6,$5A             ; 00A84D DDDDDDDD )%?5?5?Z
.byte $00,$00,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A855 DDDDDDDD ????????
.byte $FF,$7F,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A85D DDDDDDDD ????????
.byte $FF,$7F,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A865 DDDDDDDD ????????
.byte $FF,$7F,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A86D DDDDDDDD ????????
.byte $00,$00,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A875 DDDDDDDD ????????
.byte $FF,$7F,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A87D DDDDDDDD ????????
.byte $FF,$7F,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A885 DDDDDDDD ????????
.byte $FF,$7F,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A88D DDDDDDDD ????????
.byte $00,$00,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A895 DDDDDDDD ????????
.byte $FF,$7F,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A89D DDDDDDDD ????????
.byte $FF,$7F,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A8A5 DDDDDDDD ????????
.byte $FF,$7F,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A8AD DDDDDDDD ????????
.byte $00,$00,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A8B5 DDDDDDDD ????????
.byte $FF,$7F,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A8BD DDDDDDDD ????????
.byte $FF,$7F,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A8C5 DDDDDDDD ????????
.byte $FF,$7F,$FF,$7F,$FF,$7F,$FF,$7F             ; 00A8CD DDDDDDDD ????????


L_A8D5:
  PHP                                             ; 00A8D5 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00A8D6 E2 30 
  LDA.W CurrentRound                                     ; 00A8D8 AD AB 05 
  ASL                                             ; 00A8DB 0A 
  TAY                                             ; 00A8DC A8 
  LDA.W D_AA3B,Y                                  ; 00A8DD B9 3B AA 
  STA.B $04                                       ; 00A8E0 85 04 
  LDA.W D_AA3C,Y                                  ; 00A8E2 B9 3C AA 
  STA.B $05                                       ; 00A8E5 85 05 
  LDY.W CurrentRoom                                     ; 00A8E7 AC AC 05 
  LDA.B ($04),Y                                   ; 00A8EA B1 04 
  ASL                                             ; 00A8EC 0A 
  TAY                                             ; 00A8ED A8 
  LDA.W D_A90B,Y                                  ; 00A8EE B9 0B A9 
  STA.W A1T7L                                     ; 00A8F1 8D 72 43 
  LDA.W D_A90C,Y                                  ; 00A8F4 B9 0C A9 
  STA.W A1T7H                                     ; 00A8F7 8D 73 43 
  LDA.B #$04                                      ; 00A8FA A9 04 
  STA.W DMAP7                                     ; 00A8FC 8D 70 43 
  LDA.B #$26                                      ; 00A8FF A9 26 
  STA.W BBAD7                                     ; 00A901 8D 71 43 
  LDA.B #$00                                      ; 00A904 A9 00 
  STA.W A1B7                                      ; 00A906 8D 74 43 
  PLP                                             ; 00A909 28 
  RTS                                             ; 00A90A 60 


D_A90B:
.byte $1B                                         ; 00A90C D        ?
D_A90C:
.byte $A9,$3F,$A9,$63,$A9,$82,$A9,$BF             ; 00A90C DDD..... ???c????
.byte $A9,$E8,$A9,$07,$AA,$2B,$AA,$0E             ; 00A914 .DD....D ?????+??
.byte $29,$D6,$00,$FF,$22,$29,$D6,$00             ; 00A91C DDDDDDDD )???")??
.byte $00,$1B,$00,$FF,$00,$00,$38,$0D             ; 00A924 DDDDDDDD ??????8?
.byte $F2,$00,$00,$52,$0D,$F2,$00,$00             ; 00A92C DDDDDDDD ???R????
.byte $03,$00,$FF,$62,$9D,$01,$00,$FF             ; 00A934 DDDDDDDD ???b????
.byte $00,$FF,$00,$0E,$29,$D6,$00,$00             ; 00A93C DDDDDDDD ????)???
.byte $22,$29,$D6,$00,$00,$1B,$00,$FF             ; 00A944 DDDDDDDD ")??????
.byte $00,$00,$38,$0D,$F2,$00,$00,$52             ; 00A94C DDDDDDDD ??8????R
.byte $0D,$F2,$00,$00,$03,$00,$FF,$62             ; 00A954 DDDDDDDD ???????b
.byte $9D,$01,$00,$FF,$00,$FF,$00,$0E             ; 00A95C DDDDDDD. ????????
.byte $29,$D6,$00,$00,$22,$29,$D6,$00             ; 00A964 ........ )???")??
.byte $00,$1B,$00,$FF,$00,$00,$38,$0D             ; 00A96C ........ ??????8?
.byte $F2,$00,$00,$54,$0D,$F2,$00,$00             ; 00A974 ........ ???T????
.byte $01,$00,$FF,$00,$FF,$00,$0E,$29             ; 00A97C ........ ???????)
.byte $D6,$00,$FF,$22,$29,$D6,$00,$00             ; 00A984 ........ ???")???
.byte $1B,$00,$FF,$00,$00,$44,$0D,$F2             ; 00A98C ........ ?????D??
.byte $00,$00,$01,$00,$AD,$00,$00,$01             ; 00A994 ........ ????????
.byte $00,$AC,$00,$00,$01,$00,$AB,$00             ; 00A99C ........ ????????
.byte $00,$01,$00,$AB,$00,$00,$43,$00             ; 00A9A4 ........ ??????C?
.byte $AA,$00,$00,$01,$00,$AA,$69,$96             ; 00A9AC ........ ??????i?
.byte $01,$00,$AA,$68,$97,$01,$00,$00             ; 00A9B4 ........ ???h????
.byte $00,$FF,$00,$0E,$29,$D6,$00,$FF             ; 00A9BC ........ ????)???
.byte $22,$29,$D6,$00,$00,$1B,$00,$FF             ; 00A9C4 ........ ")??????
.byte $00,$00,$38,$0D,$F2,$00,$00,$53             ; 00A9CC ........ ??8????S
.byte $0D,$F2,$00,$00,$01,$00,$FF,$69             ; 00A9D4 ........ ???????i
.byte $96,$01,$00,$FF,$68,$97,$01,$00             ; 00A9DC ........ ????h???
.byte $FF,$00,$FF,$00,$0E,$29,$D6,$00             ; 00A9E4 ....DDDD ?????)??
.byte $FF,$22,$29,$D6,$00,$00,$1B,$00             ; 00A9EC DDDDDDDD ?")?????
.byte $FF,$00,$00,$38,$0D,$F2,$00,$00             ; 00A9F4 DDDDDDDD ???8????
.byte $54,$0D,$F2,$00,$00,$01,$00,$FF             ; 00A9FC DDDDDDDD T???????
.byte $00,$FF,$00,$0E,$29,$D6,$00,$FF             ; 00AA04 DDD..... ????)???
.byte $22,$29,$D6,$00,$00,$1B,$00,$FF             ; 00AA0C ........ ")??????
.byte $00,$00,$38,$0D,$F2,$00,$00,$52             ; 00AA14 ........ ??8????R
.byte $0D,$F2,$00,$00,$02,$00,$FF,$62             ; 00AA1C ........ ???????b
.byte $9D,$01,$00,$FF,$00,$FF,$00,$58             ; 00AA24 ........ ???????X
.byte $00,$FF,$00,$00,$3C,$0D,$F2,$00             ; 00AA2C ........ ????<???
.byte $00,$01,$00,$FF,$00,$00,$00                 ; 00AA35 .......  ???????
D_AA3B:
.byte $41                                         ; 00AA3C D        A
D_AA3C:
.byte $AA,$4D,$AA,$60,$AA,$00,$00,$00             ; 00AA3C D.....D. ?M?`????
.byte $00,$00,$05,$00,$00,$00,$00,$01             ; 00AA44 D..DD.DD ????????
.byte $05,$00,$03,$04,$04,$04,$04,$04             ; 00AA4C D....... ????????
.byte $04,$04,$04,$05,$04,$05,$04,$05             ; 00AA54 ........ ????????
.byte $04,$04,$04,$04,$00,$06,$06,$06             ; 00AA5C ........ ????????
.byte $06,$06,$06,$07,$06,$06,$05,$06             ; 00AA64 ........ ????????
.byte $05,$06,$05,$06,$06,$06,$06,$06             ; 00AA6C ........ ????????
.byte $06,$02,$05,$05                             ; 00AA75 ....     ????


RoundRoomIndexesLo:
.byte <Round1RoomIndexes,<Round2RoomIndexes,<Round3RoomIndexes
RoundRoomIndexesHi:
.byte >Round1RoomIndexes,>Round2RoomIndexes,>Round3RoomIndexes


Round1RoomIndexes:
;       S   E   N   W
.byte $00,$01,$00,$00
.byte $03,$00,$00,$04
.byte $00,$02,$00,$06
.byte $00,$05,$08,$00
.byte $00,$09,$00,$07
.byte $00,$08,$0B,$00
.byte $00,$09,$00,$00
.byte $0A,$00,$00,$FF
.byte $00,$09,$00,$04

Round2RoomIndexes:
.byte $00             ; 00AA9B DDDDDDD. ????????
.byte $01,$00,$08,$02,$0D,$09,$03,$0E             ; 00AAA3 ........ ????????
.byte $04,$00,$0F,$0B,$00,$00,$00,$00             ; 00AAAB ........ ????????
.byte $06,$00,$07,$00,$00,$FF,$00,$00             ; 00AAB3 ........ ????????
.byte $09,$00,$00,$04,$00,$10,$07,$0B             ; 00AABB ........ ????????
.byte $00,$0C,$00,$00,$00,$05,$00,$0E             ; 00AAC3 ........ ????????
.byte $00,$00,$0F,$00,$00,$00,$11,$06             ; 00AACB ........ ????????
.byte $00,$00,$00,$12,$00,$10,$0A,$00             ; 00AAD3 ........ ????????

Round3RoomIndexes:
.byte $00,$01,$00,$08,$02,$0D,$09,$03             ; 00AADB ........ ????????
.byte $0E,$04,$00,$0F,$0B,$00,$00,$00             ; 00AAE3 ........ ????????
.byte $00,$06,$00,$07,$00,$00,$13,$00             ; 00AAEB ........ ????????
.byte $00,$09,$00,$00,$04,$00,$10,$07             ; 00AAF3 ........ ????????
.byte $0B,$00,$0C,$00,$00,$00,$05,$00             ; 00AAFB ........ ????????
.byte $0E,$00,$00,$0F,$00,$00,$00,$11             ; 00AB03 ........ ????????
.byte $06,$00,$00,$00,$12,$00,$10,$0A             ; 00AB0B ........ ????????
.byte $00,$00,$14,$00,$00,$15,$16,$00             ; 00AB13 ........ ????????
.byte $FF,$00,$00,$15,$00,$00,$15,$00             ; 00AB1B ........ ????????


L_AB23:
  PHP                                             ; 00AB23 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00AB24 E2 30 
  STX.B $04                                       ; 00AB26 86 04 
  PHB                                             ; 00AB28 8B 
  LDA.B #$09                                      ; 00AB29 A9 09 
  PHA                                             ; 00AB2B 48 
  PLB                                             ; 00AB2C AB 
  LDA.B $04                                       ; 00AB2D A5 04 
  ASL                                             ; 00AB2F 0A 
  TAX                                             ; 00AB30 AA 
  LDA.L D_AB61,X                                  ; 00AB31 BF 61 AB 00 
  STA.B $06                                       ; 00AB35 85 06 
  LDA.L D_AB62,X                                  ; 00AB37 BF 62 AB 00 
  STA.B $07                                       ; 00AB3B 85 07 
  LDX.B $04                                       ; 00AB3D A6 04 
  LDA.L D_AB5F,X                                  ; 00AB3F BF 5F AB 00 
  TAX                                             ; 00AB43 AA 
  REP.B #P_Acc8Bit                                      ; 00AB44 C2 20 
  LDY.B #$00                                      ; 00AB46 A0 00 
B_AB48:
  LDA.B ($06),Y                                   ; 00AB48 B1 06 
  STA.W $0574,X                                   ; 00AB4A 9D 74 05 
  INX                                             ; 00AB4D E8 
  INX                                             ; 00AB4E E8 
  INY                                             ; 00AB4F C8 
  INY                                             ; 00AB50 C8 
  CPY.B #$18                                      ; 00AB51 C0 18 
  BNE.B B_AB48                                    ; 00AB53 D0 F3 
  SEP.B #P_Acc8Bit                                      ; 00AB55 E2 20 
  LDX.B $04                                       ; 00AB57 A6 04 
  INC.W $05A4,X                                   ; 00AB59 FE A4 05 
  PLB                                             ; 00AB5C AB 
  PLP                                             ; 00AB5D 28 
  RTL                                             ; 00AB5E 6B 

D_AB5F:
.byte $00,$18                                     ; 00AB60 DD       ??
D_AB61:
.byte $03                                         ; 00AB62 D        ?
D_AB62:
.byte $AB,$1B,$AB                                 ; 00AB63 DDD      ???


L_AB65:
  PHP                                             ; 00AB65 08 
  PHB                                             ; 00AB66 8B 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00AB67 E2 30 
  STA.B $04                                       ; 00AB69 85 04 
  STX.B $05                                       ; 00AB6B 86 05 
  LDA.B #$00                                      ; 00AB6D A9 00 
  PHA                                             ; 00AB6F 48 
  PLB                                             ; 00AB70 AB 
  LDX.B $05                                       ; 00AB71 A6 05 
  LDA.L D_ABFE,X                                  ; 00AB73 BF FE AB 00 
  STA.B $08                                       ; 00AB77 85 08 
  LDA.W CurrentRound                                     ; 00AB79 AD AB 05 
  ASL                                             ; 00AB7C 0A 
  ASL                                             ; 00AB7D 0A 
  ASL                                             ; 00AB7E 0A 
  CLC                                             ; 00AB7F 18 
  ADC.B $04                                       ; 00AB80 65 04 
  ASL                                             ; 00AB82 0A 
  TAX                                             ; 00AB83 AA 
  REP.B #P_Acc8Bit                                      ; 00AB84 C2 20 
  LDA.L D_AC02,X                                  ; 00AB86 BF 02 AC 00 
  STA.B $06                                       ; 00AB8A 85 06 
  LDX.B $08                                       ; 00AB8C A6 08 
  LDY.B #$0E                                      ; 00AB8E A0 0E 
B_AB90:
  LDA.B ($06),Y                                   ; 00AB90 B1 06 
  STA.W $0534,X                                   ; 00AB92 9D 34 05 
  INX                                             ; 00AB95 E8 
  INX                                             ; 00AB96 E8 
  DEY                                             ; 00AB97 88 
  DEY                                             ; 00AB98 88 
  BPL.B B_AB90                                    ; 00AB99 10 F5 
  CLC                                             ; 00AB9B 18 
  LDA.B $06                                       ; 00AB9C A5 06 
  ADC.W #$0040                                    ; 00AB9E 69 40 00 
  STA.B $06                                       ; 00ABA1 85 06 
  LDX.B $08                                       ; 00ABA3 A6 08 
  LDY.B #$0E                                      ; 00ABA5 A0 0E 
B_ABA7:
  LDA.B ($06),Y                                   ; 00ABA7 B1 06 
  STA.W $0544,X                                   ; 00ABA9 9D 44 05 
  INX                                             ; 00ABAC E8 
  INX                                             ; 00ABAD E8 
  DEY                                             ; 00ABAE 88 
  DEY                                             ; 00ABAF 88 
  BPL.B B_ABA7                                    ; 00ABB0 10 F5 
  SEP.B #P_Acc8Bit                                      ; 00ABB2 E2 20 
  LDX.B $05                                       ; 00ABB4 A6 05 
  INC.B $B4,X                                     ; 00ABB6 F6 B4 
  LDA.W $18A3,X                                   ; 00ABB8 BD A3 18 
  BEQ.B B_ABFB                                    ; 00ABBB F0 3E 
  LDA.B #$09                                      ; 00ABBD A9 09 
  PHA                                             ; 00ABBF 48 
  PLB                                             ; 00ABC0 AB 
  LDA.W CurrentRound                                     ; 00ABC1 AD AB 05 
  ASL                                             ; 00ABC4 0A 
  ASL                                             ; 00ABC5 0A 
  CLC                                             ; 00ABC6 18 
  ADC.B $04                                       ; 00ABC7 65 04 
  ASL                                             ; 00ABC9 0A 
  ASL                                             ; 00ABCA 0A 
  TAX                                             ; 00ABCB AA 
  LDA.L D_AC32,X                                  ; 00ABCC BF 32 AC 00 
  STA.B $06                                       ; 00ABD0 85 06 
  LDA.L D_AC33,X                                  ; 00ABD2 BF 33 AC 00 
  STA.B $07                                       ; 00ABD6 85 07 
  LDX.B $05                                       ; 00ABD8 A6 05 
  LDA.L D_AC00,X                                  ; 00ABDA BF 00 AC 00 
  TAX                                             ; 00ABDE AA 
  REP.B #P_Acc8Bit                                      ; 00ABDF C2 20 
  LDY.B #$00                                      ; 00ABE1 A0 00 
B_ABE3:
  LDA.B ($06),Y                                   ; 00ABE3 B1 06 
  STA.W $0574,X                                   ; 00ABE5 9D 74 05 
  INX                                             ; 00ABE8 E8 
  INX                                             ; 00ABE9 E8 
  INY                                             ; 00ABEA C8 
  INY                                             ; 00ABEB C8 
  CPY.B #$18                                      ; 00ABEC C0 18 
  BNE.B B_ABE3                                    ; 00ABEE D0 F3 
  SEP.B #P_Acc8Bit                                      ; 00ABF0 E2 20 
  LDX.B $05                                       ; 00ABF2 A6 05 
  INC.W $05A4,X                                   ; 00ABF4 FE A4 05 
  JSL L_AC73                                      ; 00ABF7 22 73 AC 00 
B_ABFB:
  PLB                                             ; 00ABFB AB 
  PLP                                             ; 00ABFC 28 
  RTL                                             ; 00ABFD 6B 

D_ABFE:
.byte $00,$20                                     ; 00ABFF DD       ? 
D_AC00:
.byte $00,$18                                     ; 00AC01 DD       ??
D_AC02:
.byte $6F,$F9,$7F,$F9,$8F,$F9,$EF,$FA             ; 00AC02 DDDDDDDD o???????
.byte $FF,$FA,$00,$00,$00,$00,$00,$00             ; 00AC0A ........ ????????
.byte $EF,$F9,$FF,$F9,$0F,$FA,$EF,$FA             ; 00AC12 ........ ????????
.byte $FF,$FA,$00,$00,$00,$00,$00,$00             ; 00AC1A ........ ????????
.byte $6F,$FA,$7F,$FA,$8F,$FA,$EF,$FA             ; 00AC22 ........ o???????
.byte $FF,$FA,$00,$00,$00,$00,$00,$00             ; 00AC2A ........ ????????
D_AC32:
.byte $43                                         ; 00AC33 D        C
D_AC33:
.byte $AB,$5B,$AB,$83,$AB,$9B,$AB,$C3             ; 00AC33 D..DD..D ?[??????
.byte $AB,$DB,$AB,$00,$00,$00,$00,$43             ; 00AC3B D....... ???????C
.byte $AC,$5B,$AC,$83,$AC,$9B,$AC,$C3             ; 00AC43 ........ ?[??????
.byte $AC,$DB,$AC,$00,$00,$00,$00,$43             ; 00AC4B ........ ???????C
.byte $AD,$5B,$AD,$83,$AD,$9B,$AD,$C3             ; 00AC53 ........ ?[??????
.byte $AD,$DB,$AD,$00,$00,$00,$00                 ; 00AC5C .......  ???????


L_AC62:
  PHP                                             ; 00AC62 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00AC63 E2 30 
  LDX.B #$00                                      ; 00AC65 A2 00 
  JSL L_AC73                                      ; 00AC67 22 73 AC 00 
  LDX.B #$01                                      ; 00AC6B A2 01 
  JSL L_AC73                                      ; 00AC6D 22 73 AC 00 
  PLP                                             ; 00AC71 28 
  RTL                                             ; 00AC72 6B 

L_AC73:
  PHP                                             ; 00AC73 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00AC74 E2 30 
  TXA                                             ; 00AC76 8A 
  ASL                                             ; 00AC77 0A 
  ASL                                             ; 00AC78 0A 
  ASL                                             ; 00AC79 0A 
  TAY                                             ; 00AC7A A8 
  REP.B #P_Acc8Bit                                      ; 00AC7B C2 20 
  LDA.W #$0004                                    ; 00AC7D A9 04 00 
  STA.B $04                                       ; 00AC80 85 04 
  LDA.W #$0000                                    ; 00AC82 A9 00 00 
B_AC85:
  STA.W $0087,Y                                   ; 00AC85 99 87 00 
  INY                                             ; 00AC88 C8 
  INY                                             ; 00AC89 C8 
  DEC.B $04                                       ; 00AC8A C6 04 
  BNE.B B_AC85                                    ; 00AC8C D0 F7 
  SEP.B #P_Acc8Bit                                      ; 00AC8E E2 20 
  INC.W $0528,X                                   ; 00AC90 FE 28 05 
  PLP                                             ; 00AC93 28 
  RTL                                             ; 00AC94 6B 

L_AC95:
  PHP                                             ; 00AC95 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00AC96 E2 30 
  LDA.W $18A3                                     ; 00AC98 AD A3 18 
  BEQ.B B_ACA3                                    ; 00AC9B F0 06 
  LDX.B #$00                                      ; 00AC9D A2 00 
  JSL L_ACB0                                      ; 00AC9F 22 B0 AC 00 
B_ACA3:
  LDA.W $18A4                                     ; 00ACA3 AD A4 18 
  BEQ.B B_ACAE                                    ; 00ACA6 F0 06 
  LDX.B #$01                                      ; 00ACA8 A2 01 
  JSL L_ACB0                                      ; 00ACAA 22 B0 AC 00 
B_ACAE:
  PLP                                             ; 00ACAE 28 
  RTL                                             ; 00ACAF 6B 

L_ACB0:
  PHP                                             ; 00ACB0 08 
  PHB                                             ; 00ACB1 8B 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00ACB2 E2 30 
  LDA.B #$00                                      ; 00ACB4 A9 00 
  PHA                                             ; 00ACB6 48 
  PLB                                             ; 00ACB7 AB 
  TXA                                             ; 00ACB8 8A 
  ASL                                             ; 00ACB9 0A 
  ASL                                             ; 00ACBA 0A 
  ASL                                             ; 00ACBB 0A 
  TAY                                             ; 00ACBC A8 
  LDA.W XexzyLivesCount,X                         ; 00ACBD BD 31 05 
  ASL                                             ; 00ACC0 0A 
  ASL                                             ; 00ACC1 0A 
  ASL                                             ; 00ACC2 0A 
  PHX                                             ; 00ACC3 DA 
  TAX                                             ; 00ACC4 AA 
  REP.B #P_Acc8Bit                                      ; 00ACC5 C2 20 
  LDA.W #$0004                                    ; 00ACC7 A9 04 00 
  STA.B $04                                       ; 00ACCA 85 04 
B_ACCC:
  LDA.L D_F7EF,X                                  ; 00ACCC BF EF F7 00 
  STA.W $0087,Y                                   ; 00ACD0 99 87 00 
  INX                                             ; 00ACD3 E8 
  INX                                             ; 00ACD4 E8 
  INY                                             ; 00ACD5 C8 
  INY                                             ; 00ACD6 C8 
  DEC.B $04                                       ; 00ACD7 C6 04 
  BNE.B B_ACCC                                    ; 00ACD9 D0 F1 
  SEP.B #P_Acc8Bit                                      ; 00ACDB E2 20 
  PLX                                             ; 00ACDD FA 
  INC.W $0528,X                                   ; 00ACDE FE 28 05 
  PLB                                             ; 00ACE1 AB 
  PLP                                             ; 00ACE2 28 
  RTL                                             ; 00ACE3 6B 

L_ACE4:
  PHP                                             ; 00ACE4 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00ACE5 E2 30 
  PHB                                             ; 00ACE7 8B 
  LDA.B #$00                                      ; 00ACE8 A9 00 
  PHA                                             ; 00ACEA 48 
  PLB                                             ; 00ACEB AB 
  LDA.W D_AE4A,X                                  ; 00ACEC BD 4A AE 
  STA.B $04                                       ; 00ACEF 85 04 
  LDA.W D_AE4C,X                                  ; 00ACF1 BD 4C AE 
  STA.B $05                                       ; 00ACF4 85 05 
  CLC                                             ; 00ACF6 18 
  LDA.B $04                                       ; 00ACF7 A5 04 
  ADC.B #$C3                                      ; 00ACF9 69 C3 
  STA.B $B0                                       ; 00ACFB 85 B0 
  LDA.B $05                                       ; 00ACFD A5 05 
  ADC.B #$00                                      ; 00ACFF 69 00 
  STA.B $B1                                       ; 00AD01 85 B1 
  CLC                                             ; 00AD03 18 
  LDA.B $04                                       ; 00AD04 A5 04 
  ADC.B #$D5                                      ; 00AD06 69 D5 
  STA.B $B2                                       ; 00AD08 85 B2 
  LDA.B $05                                       ; 00AD0A A5 05 
  ADC.B #$00                                      ; 00AD0C 69 00 
  STA.B $B3                                       ; 00AD0E 85 B3 
  CLC                                             ; 00AD10 18 
  LDA.B $04                                       ; 00AD11 A5 04 
  ADC.B #$03                                      ; 00AD13 69 03 
  STA.B $C2                                       ; 00AD15 85 C2 
  LDA.B $05                                       ; 00AD17 A5 05 
  ADC.B #$01                                      ; 00AD19 69 01 
  STA.B $C3                                       ; 00AD1B 85 C3 
  CLC                                             ; 00AD1D 18 
  LDA.B $04                                       ; 00AD1E A5 04 
  ADC.B #$15                                      ; 00AD20 69 15 
  STA.B $C4                                       ; 00AD22 85 C4 
  LDA.B $05                                       ; 00AD24 A5 05 
  ADC.B #$01                                      ; 00AD26 69 01 
  STA.B $C5                                       ; 00AD28 85 C5 
  LDA.W CurrentRoom                                     ; 00AD2A AD AC 05 
  BPL.B B_AD56                                    ; 00AD2D 10 27 

.byte $64,$B4,$64,$B5,$64,$C6,$A2,$0F             ; 00AD2F ........ d?d?d???
.byte $9E,$34,$05,$9E,$44,$05,$9E,$54             ; 00AD37 ........ ?4??D??T
.byte $05,$9E,$64,$05,$CA,$10,$F1,$A2             ; 00AD3F ........ ??d?????
.byte $0B,$74,$B6,$CA,$10,$FB,$E6,$B4             ; 00AD47 ........ ?t??????
.byte $E6,$B5,$E6,$C6,$AB,$28,$6B                 ; 00AD50 .......  ?????(k

B_AD56:
  LDA.W $18A3                                     ; 00AD56 AD A3 18 
  BNE.B B_AD61                                    ; 00AD59 D0 06 
  LDA.B $D2                                       ; 00AD5B A5 D2 
  AND.B #$80                                      ; 00AD5D 29 80 
  BNE.B B_AD8B                                    ; 00AD5F D0 2A 
B_AD61:
  LDA.W $05B2                                     ; 00AD61 AD B2 05 
  BNE.B B_AD8B                                    ; 00AD64 D0 25 
  STZ.B $B4                                       ; 00AD66 64 B4 
  LDY.B #$07                                      ; 00AD68 A0 07 
B_AD6A:
  LDA.W XexzyScore,Y                              ; 00AD6A B9 97 00 
  ASL                                             ; 00AD6D 0A 
  TAX                                             ; 00AD6E AA 
  PHY                                             ; 00AD6F 5A 
  TYA                                             ; 00AD70 98 
  ASL                                             ; 00AD71 0A 
  TAY                                             ; 00AD72 A8 
  REP.B #P_Acc8Bit                                      ; 00AD73 C2 20 
  LDA.L D_F8EF,X                                  ; 00AD75 BF EF F8 00 
  STA.W $0534,Y                                   ; 00AD79 99 34 05 
  LDA.L D_F92F,X                                  ; 00AD7C BF 2F F9 00 
  STA.W $0544,Y                                   ; 00AD80 99 44 05 
  SEP.B #P_Acc8Bit                                      ; 00AD83 E2 20 
  PLY                                             ; 00AD85 7A 
  DEY                                             ; 00AD86 88 
  BPL.B B_AD6A                                    ; 00AD87 10 E1 
  INC.B $B4                                       ; 00AD89 E6 B4 
B_AD8B:
  LDA.W $18A4                                     ; 00AD8B AD A4 18 
  BNE.B B_AD96                                    ; 00AD8E D0 06 
  LDA.B $D2                                       ; 00AD90 A5 D2 
  AND.B #$80                                      ; 00AD92 29 80 
  BNE.B B_ADC0                                    ; 00AD94 D0 2A 
B_AD96:
  LDA.W $05B3                                     ; 00AD96 AD B3 05 
  BNE.B B_ADC0                                    ; 00AD99 D0 25 
  STZ.B $B5                                       ; 00AD9B 64 B5 
  LDY.B #$07                                      ; 00AD9D A0 07 
B_AD9F:
  LDA.W $009F,Y                                   ; 00AD9F B9 9F 00 
  ASL                                             ; 00ADA2 0A 
  TAX                                             ; 00ADA3 AA 
  PHY                                             ; 00ADA4 5A 
  TYA                                             ; 00ADA5 98 
  ASL                                             ; 00ADA6 0A 
  TAY                                             ; 00ADA7 A8 
  REP.B #P_Acc8Bit                                      ; 00ADA8 C2 20 
  LDA.L D_F8EF,X                                  ; 00ADAA BF EF F8 00 
  STA.W $0554,Y                                   ; 00ADAE 99 54 05 
  LDA.L D_F92F,X                                  ; 00ADB1 BF 2F F9 00 
  STA.W $0564,Y                                   ; 00ADB5 99 64 05 
  SEP.B #P_Acc8Bit                                      ; 00ADB8 E2 20 
  PLY                                             ; 00ADBA 7A 
  DEY                                             ; 00ADBB 88 
  BPL.B B_AD9F                                    ; 00ADBC 10 E1 
  INC.B $B5                                       ; 00ADBE E6 B5 
B_ADC0:
  LDA.B FrameCounter                              ; 00ADC0 A5 CF 
  AND.B #$03                                      ; 00ADC2 29 03 
  BNE.B B_ADD6                                    ; 00ADC4 D0 10 
  LDX.B #$01                                      ; 00ADC6 A2 01 
B_ADC8:
  LDA.W $189B,X                                   ; 00ADC8 BD 9B 18 
  INC A
  CMP.B #$07                                      ; 00ADCC C9 07 
  BCS.B B_ADD3                                    ; 00ADCE B0 03 
  STA.W $189B,X                                   ; 00ADD0 9D 9B 18 
B_ADD3:
  DEX                                             ; 00ADD3 CA 
  BPL.B B_ADC8                                    ; 00ADD4 10 F2 
B_ADD6:
  LDX.B #$01                                      ; 00ADD6 A2 01 
B_ADD8:
  LDA.W $1899,X                                   ; 00ADD8 BD 99 18 
  CMP.W $189B,X                                   ; 00ADDB DD 9B 18 
  BCS.B B_ADE3                                    ; 00ADDE B0 03 
  STA.W $189B,X                                   ; 00ADE0 9D 9B 18 
B_ADE3:
  DEX                                             ; 00ADE3 CA 
  BPL.B B_ADD8                                    ; 00ADE4 10 F2 
  STZ.B $C6                                       ; 00ADE6 64 C6 
  LDA.L D_F871                                    ; 00ADE8 AF 71 F8 00 
  LDX.B #$0B                                      ; 00ADEC A2 0B 
B_ADEE:
  STA.B $B6,X                                     ; 00ADEE 95 B6 
  DEX                                             ; 00ADF0 CA 
  BPL.B B_ADEE                                    ; 00ADF1 10 FB 
  LDY.B #$00                                      ; 00ADF3 A0 00 
  LDX.W $189B                                     ; 00ADF5 AE 9B 18 
  BEQ.B B_AE05                                    ; 00ADF8 F0 0B 
  LDA.L D_F86F                                    ; 00ADFA AF 6F F8 00 
B_ADFE:
  STA.W $00B6,Y                                   ; 00ADFE 99 B6 00 
  INY                                             ; 00AE01 C8 
  DEX                                             ; 00AE02 CA 
  BNE.B B_ADFE                                    ; 00AE03 D0 F9 
B_AE05:
  LDY.B #$00                                      ; 00AE05 A0 00 
  LDX.W $189C                                     ; 00AE07 AE 9C 18 
  BEQ.B B_AE17                                    ; 00AE0A F0 0B 
  LDA.L D_F86F                                    ; 00AE0C AF 6F F8 00 
B_AE10:
  STA.W $00BC,Y                                   ; 00AE10 99 BC 00 
  INY                                             ; 00AE13 C8 
  DEX                                             ; 00AE14 CA 
  BNE.B B_AE10                                    ; 00AE15 D0 F9 
B_AE17:
  INC.B $C6                                       ; 00AE17 E6 C6 
  LDA.B $D2                                       ; 00AE19 A5 D2 
  AND.B #$80                                      ; 00AE1B 29 80 
  BEQ.B B_AE47                                    ; 00AE1D F0 28 
  LDA.W $18A3                                     ; 00AE1F AD A3 18 
  BNE.B B_AE33                                    ; 00AE22 D0 0F 
  LDY.B #$03                                      ; 00AE24 A0 03 
  LDA.W $0533                                     ; 00AE26 AD 33 05 
  BNE.B B_AE2C                                    ; 00AE29 D0 01 

.byte $C8                                         ; 00AE2C .        ?

B_AE2C:
  TYA                                             ; 00AE2C 98 
  LDX.B #$00                                      ; 00AE2D A2 00 
  JSL L_AB65                                      ; 00AE2F 22 65 AB 00 
B_AE33:
  LDA.W $18A4                                     ; 00AE33 AD A4 18 
  BNE.B B_AE47                                    ; 00AE36 D0 0F 
  LDY.B #$03                                      ; 00AE38 A0 03 
  LDA.W $0533                                     ; 00AE3A AD 33 05 
  BNE.B B_AE40                                    ; 00AE3D D0 01 

.byte $C8                                         ; 00AE40 .        ?

B_AE40:
  TYA                                             ; 00AE40 98 
  LDX.B #$01                                      ; 00AE41 A2 01 
  JSL L_AB65                                      ; 00AE43 22 65 AB 00 
B_AE47:
  PLB                                             ; 00AE47 AB 
  PLP                                             ; 00AE48 28 
  RTL                                             ; 00AE49 6B 

D_AE4A:
.byte $00,$00                                     ; 00AE4B DD       ??
D_AE4C:
.byte $58,$5C                                     ; 00AE4D DD       X\


L_AE4E:
  PHP                                             ; 00AE4E 08 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00AE4F C2 30 
  LDX.W #$0000                                    ; 00AE51 A2 00 00 
  LDA.W #$F0FF                                    ; 00AE54 A9 FF F0 
B_AE57:
  STA.W $0308,X                                   ; 00AE57 9D 08 03 
  INX                                             ; 00AE5A E8 
  INX                                             ; 00AE5B E8 
  INX                                             ; 00AE5C E8 
  INX                                             ; 00AE5D E8 
  CPX.W #$0200                                    ; 00AE5E E0 00 02 
  BNE.B B_AE57                                    ; 00AE61 D0 F4 
B_AE63:
  STZ.W $0308,X                                   ; 00AE63 9E 08 03 
  INX                                             ; 00AE66 E8 
  INX                                             ; 00AE67 E8 
  CPX.W #$0220                                    ; 00AE68 E0 20 02 
  BNE.B B_AE63                                    ; 00AE6B D0 F6 
  PLP                                             ; 00AE6D 28 
  RTL                                             ; 00AE6E 6B 

L_AE6F:
  PHP                                             ; 00AE6F 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00AE70 E2 30 
  LDX.B #$7F                                      ; 00AE72 A2 7F 
B_AE74:
  STZ.W $175E,X                                   ; 00AE74 9E 5E 17 
  DEX                                             ; 00AE77 CA 
  BPL.B B_AE74                                    ; 00AE78 10 FA 
  STZ.W $1514                                     ; 00AE7A 9C 14 15 
  STZ.W $1515                                     ; 00AE7D 9C 15 15 
  PLP                                             ; 00AE80 28 
  RTL                                             ; 00AE81 6B 

L_AE82:
  LDY.B #$00                                      ; 00AE82 A0 00 
B_AE84:
  LDA.W $175E,Y                                   ; 00AE84 B9 5E 17 
  BEQ.B B_AE90                                    ; 00AE87 F0 07 
  INY                                             ; 00AE89 C8 
  CPY.B #$80                                      ; 00AE8A C0 80 
  BNE.B B_AE84                                    ; 00AE8C D0 F6 

.byte $A9,$01                                     ; 00AE8F ..       ??

B_AE90:
  RTL                                             ; 00AE90 6B 

L_AE91:
  LDY.B #$5B                                      ; 00AE91 A0 5B 
B_AE93:
  LDA.W $175E,Y                                   ; 00AE93 B9 5E 17 
  BEQ.B B_AE9F                                    ; 00AE96 F0 07 
  INY                                             ; 00AE98 C8 
  CPY.B #$80                                      ; 00AE99 C0 80 
  BNE.B B_AE93                                    ; 00AE9B D0 F6 

.byte $A9,$01                                     ; 00AE9E ..       ??

B_AE9F:
  RTL                                             ; 00AE9F 6B 

.byte $A0,$20,$B9,$5E,$17,$F0,$07,$C8             ; 00AEA0 ........ ? ?^????
.byte $C0,$80,$D0,$F6,$A9,$01,$6B                 ; 00AEA9 .......  ??????k


L_AEAF:
  LDY.B #$7F                                      ; 00AEAF A0 7F 
B_AEB1:
  LDA.W $175E,Y                                   ; 00AEB1 B9 5E 17 
  BEQ.B B_AEBB                                    ; 00AEB4 F0 05 
  DEY                                             ; 00AEB6 88 
  BPL.B B_AEB1                                    ; 00AEB7 10 F8 

.byte $A9,$01                                     ; 00AEBA ..       ??

B_AEBB:
  RTL                                             ; 00AEBB 6B 

L_AEBC:
  LDY.B #$08                                      ; 00AEBC A0 08 
B_AEBE:
  LDA.W $175E,Y                                   ; 00AEBE B9 5E 17 
  BEQ.B B_AECA                                    ; 00AEC1 F0 07 
  INY                                             ; 00AEC3 C8 
  CPY.B #$80                                      ; 00AEC4 C0 80 
  BNE.B B_AEBE                                    ; 00AEC6 D0 F6 

.byte $A9,$01                                     ; 00AEC9 ..       ??

B_AECA:
  RTL                                             ; 00AECA 6B 

L_AECB:
  LDY.B #$6F                                      ; 00AECB A0 6F 
B_AECD:
  LDA.W $175E,Y                                   ; 00AECD B9 5E 17 
  BEQ.B B_AED7                                    ; 00AED0 F0 05 
  DEY                                             ; 00AED2 88 
  BPL.B B_AECD                                    ; 00AED3 10 F8 

.byte $A9,$01                                     ; 00AED6 ..       ??

B_AED7:
  RTL                                             ; 00AED7 6B 

L_AED8:
  PHX                                             ; 00AED8 DA 
  TYA                                             ; 00AED9 98 
  AND.B #$03                                      ; 00AEDA 29 03 
  TAX                                             ; 00AEDC AA 
  TYA                                             ; 00AEDD 98 
  LSR                                             ; 00AEDE 4A 
  LSR                                             ; 00AEDF 4A 
  TAY                                             ; 00AEE0 A8 
  LDA.W $0508,Y                                   ; 00AEE1 B9 08 05 
  AND.L D_AF06,X                                  ; 00AEE4 3F 06 AF 00 
  ORA.L D_AF0A,X                                  ; 00AEE8 1F 0A AF 00 
  STA.W $0508,Y                                   ; 00AEEC 99 08 05 
  PLX                                             ; 00AEEF FA 
  RTL                                             ; 00AEF0 6B 

L_AEF1:
  PHX                                             ; 00AEF1 DA 
  TYA                                             ; 00AEF2 98 
  AND.B #$03                                      ; 00AEF3 29 03 
  TAX                                             ; 00AEF5 AA 
  TYA                                             ; 00AEF6 98 
  LSR                                             ; 00AEF7 4A 
  LSR                                             ; 00AEF8 4A 
  TAY                                             ; 00AEF9 A8 
  LDA.W $0508,Y                                   ; 00AEFA B9 08 05 
  AND.L D_AF06,X                                  ; 00AEFD 3F 06 AF 00 
  STA.W $0508,Y                                   ; 00AF01 99 08 05 
  PLX                                             ; 00AF04 FA 
  RTL                                             ; 00AF05 6B 

D_AF06:
.byte $A8,$A2,$8A,$2A                             ; 00AF07 DDDD     ???*
D_AF0A:
.byte $02,$08,$20,$80                             ; 00AF0B DDDD     ?? ?


L_AF0E:
  PHP                                             ; 00AF0E 08 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00AF0F C2 30 
  LDA.W #$0400                                    ; 00AF11 A9 00 04 
  STA.W DMAP0                                     ; 00AF14 8D 00 43 
  LDA.W #$0308                                    ; 00AF17 A9 08 03 
  STA.W A1T0L                                     ; 00AF1A 8D 02 43 
  LDA.W #$0220                                    ; 00AF1D A9 20 02 
  STA.W DAS0L                                     ; 00AF20 8D 05 43 
  SEP.B #P_Acc8Bit                                      ; 00AF23 E2 20 
  STZ.W OAMADDL                                   ; 00AF25 9C 02 21 
  STZ.W OAMADDH                                   ; 00AF28 9C 03 21 
  LDA.B #$7E                                      ; 00AF2B A9 7E 
  STA.W A1B0                                      ; 00AF2D 8D 04 43 
  LDA.B #$01                                      ; 00AF30 A9 01 
  STA.W MDMAEN                                    ; 00AF32 8D 0B 42 
  LDA.B #$80                                      ; 00AF35 A9 80 
  STA.W OAMADDH                                   ; 00AF37 8D 03 21 
  LDA.W $052C                                     ; 00AF3A AD 2C 05 
  STA.W OAMADDL                                   ; 00AF3D 8D 02 21 
  PLP                                             ; 00AF40 28 
  RTL                                             ; 00AF41 6B 

L_AF42:
  LDA.W $05DE                                     ; 00AF42 AD DE 05 
  BEQ.B B_AF8C                                    ; 00AF45 F0 45 
  SEC                                             ; 00AF47 38 
  LDA.B $04                                       ; 00AF48 A5 04 
  SBC.W $06C8                                     ; 00AF4A ED C8 06 
  STA.B $04                                       ; 00AF4D 85 04 
  LDA.B $05                                       ; 00AF4F A5 05 
  SBC.W $06C9                                     ; 00AF51 ED C9 06 
  STA.B $05                                       ; 00AF54 85 05 
  BEQ.B B_AF63                                    ; 00AF56 F0 0B 
  LDA.B #$F0                                      ; 00AF58 A9 F0 
  STA.B $06                                       ; 00AF5A 85 06 
  LDA.B #$FF                                      ; 00AF5C A9 FF 
  STA.B $04                                       ; 00AF5E 85 04 
  JMP.W B_AF8C                                    ; 00AF60 4C 8C AF 
B_AF63:
  SEC                                             ; 00AF63 38 
  LDA.B $06                                       ; 00AF64 A5 06 
  SBC.W $06CA                                     ; 00AF66 ED CA 06 
  STA.B $06                                       ; 00AF69 85 06 
  LDA.B $07                                       ; 00AF6B A5 07 
  SBC.W $06CB                                     ; 00AF6D ED CB 06 
  STA.B $07                                       ; 00AF70 85 07 
  BEQ.B B_AF7E                                    ; 00AF72 F0 0A 
  BPL.B B_AF84                                    ; 00AF74 10 0E 
  LDA.B $06                                       ; 00AF76 A5 06 
  CMP.B #$F0                                      ; 00AF78 C9 F0 
  BCC.B B_AF84                                    ; 00AF7A 90 08 
  BRA.B B_AF8C                                    ; 00AF7C 80 0E 
B_AF7E:
  LDA.B $06                                       ; 00AF7E A5 06 
  CMP.B #$F0                                      ; 00AF80 C9 F0 
  BCC.B B_AF8C                                    ; 00AF82 90 08 
B_AF84:
  LDA.B #$F0                                      ; 00AF84 A9 F0 
  STA.B $06                                       ; 00AF86 85 06 
  LDA.B #$FF                                      ; 00AF88 A9 FF 
  STA.B $04                                       ; 00AF8A 85 04 
B_AF8C:
  LDA.W EntityV31,X                                   ; 00AF8C BD A0 14 
  ASL                                             ; 00AF8F 0A 
  ASL                                             ; 00AF90 0A 
  TAY                                             ; 00AF91 A8 
  BCC.B B_AFAB                                    ; 00AF92 90 17 
  LDA.B $04                                       ; 00AF94 A5 04 
  STA.W $0408,Y                                   ; 00AF96 99 08 04 
  LDA.B $06                                       ; 00AF99 A5 06 
  STA.W $0409,Y                                   ; 00AF9B 99 09 04 
  LDA.W EntityV29,X                                   ; 00AF9E BD BC 13 
  STA.W $040A,Y                                   ; 00AFA1 99 0A 04 
  LDA.W EntityV30,X                                   ; 00AFA4 BD 2E 14 
  STA.W $040B,Y                                   ; 00AFA7 99 0B 04 
  RTL                                             ; 00AFAA 6B 
B_AFAB:
  LDA.B $04                                       ; 00AFAB A5 04 
  STA.W $0308,Y                                   ; 00AFAD 99 08 03 
  LDA.B $06                                       ; 00AFB0 A5 06 
  STA.W XexzyTorsoY,Y                             ; 00AFB2 99 09 03 
  LDA.W EntityV29,X                                   ; 00AFB5 BD BC 13 
  STA.W $030A,Y                                   ; 00AFB8 99 0A 03 
  LDA.W EntityV30,X                                   ; 00AFBB BD 2E 14 
  STA.W $030B,Y                                   ; 00AFBE 99 0B 03 
  RTL                                             ; 00AFC1 6B 

L_AFC2:
  LDA.W EntityV31,X                                   ; 00AFC2 BD A0 14 
  ASL                                             ; 00AFC5 0A 
  ASL                                             ; 00AFC6 0A 
  TAY                                             ; 00AFC7 A8 
  BCC.B B_AFE9                                    ; 00AFC8 90 1F 
  SEC                                             ; 00AFCA 38 
  LDA.W XexzyCharX,X                              ; 00AFCB BD 46 0B 
  SBC.B $1C                                       ; 00AFCE E5 1C 
  STA.W $0408,Y                                   ; 00AFD0 99 08 04 
  SEC                                             ; 00AFD3 38 
  LDA.W EntityYPx,X                                   ; 00AFD4 BD 9C 0C 
  SBC.B $1D                                       ; 00AFD7 E5 1D 
  STA.W $0409,Y                                   ; 00AFD9 99 09 04 
  LDA.W EntityV29,X                                   ; 00AFDC BD BC 13 
  STA.W $040A,Y                                   ; 00AFDF 99 0A 04 
  LDA.W EntityV30,X                                   ; 00AFE2 BD 2E 14 
  STA.W $040B,Y                                   ; 00AFE5 99 0B 04 
  RTL                                             ; 00AFE8 6B 
B_AFE9:
  SEC                                             ; 00AFE9 38 
  LDA.W XexzyCharX,X                              ; 00AFEA BD 46 0B 
  SBC.B $1C                                       ; 00AFED E5 1C 
  STA.W $0308,Y                                   ; 00AFEF 99 08 03 
  SEC                                             ; 00AFF2 38 
  LDA.W EntityYPx,X                                   ; 00AFF3 BD 9C 0C 
  SBC.B $1D                                       ; 00AFF6 E5 1D 
  STA.W XexzyTorsoY,Y                             ; 00AFF8 99 09 03 
  LDA.W EntityV29,X                                   ; 00AFFB BD BC 13 
  STA.W $030A,Y                                   ; 00AFFE 99 0A 03 
  LDA.W EntityV30,X                                   ; 00B001 BD 2E 14 
  STA.W $030B,Y                                   ; 00B004 99 0B 03 
  RTL                                             ; 00B007 6B 

L_B008:
  PHP                                             ; 00B008 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00B009 E2 30 
  LDX.W $18B2                                     ; 00B00B AE B2 18 
  BEQ.B B_B014                                    ; 00B00E F0 04 
  DEX                                             ; 00B010 CA 
  STX.W $18B2                                     ; 00B011 8E B2 18 
B_B014:
  LDX.W $18B3                                     ; 00B014 AE B3 18 
  BEQ.B B_B01D                                    ; 00B017 F0 04 
  DEX                                             ; 00B019 CA 
  STX.W $18B3                                     ; 00B01A 8E B3 18 
B_B01D:
  LDA.B $D2                                       ; 00B01D A5 D2 
  AND.B #$07                                      ; 00B01F 29 07 
  BNE.B B_B030                                    ; 00B021 D0 0D 
  LDX.B #$01                                      ; 00B023 A2 01 
B_B025:
  LDA.W $18AD,X                                   ; 00B025 BD AD 18 
  BEQ.B B_B02D                                    ; 00B028 F0 03 
  DEC.W $18AD,X                                   ; 00B02A DE AD 18 
B_B02D:
  DEX                                             ; 00B02D CA 
  BPL.B B_B025                                    ; 00B02E 10 F5 
B_B030:
  PLP                                             ; 00B030 28 
  RTS                                             ; 00B031 60 


L_B032:
  PHP                                             ; 00B032 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00B033 E2 30 
  LDX.B #$01                                      ; 00B035 A2 01 
D_B037:
  LDA.B #$45                                      ; 00B037 A9 45 
  STA.W EntityYPx,X                                   ; 00B039 9D 9C 0C 
  LDA.W D_B0F1,X                                  ; 00B03C BD F1 B0 
  STA.W XexzyCharX,X                              ; 00B03F 9D 46 0B 
  LDA.B #$01                                      ; 00B042 A9 01 
  STA.W EntityHeader,X                                   ; 00B044 9D D2 06 
  STA.W EntityV1,X                                   ; 00B047 9D 44 07 
  STA.W EntityV15,X                                   ; 00B04A 9D 80 0D 
  LDA.W D_B0EA,X                                  ; 00B04D BD EA B0 
  STA.W EntityV20,X                                   ; 00B050 9D BA 0F 
  LDA.B #$01                                      ; 00B053 A9 01 
  STA.W EntityV3,X                                   ; 00B055 9D 28 08 
  LDA.W D_B0F7,X                                  ; 00B058 BD F7 B0 
  STA.W EntityV31,X                                   ; 00B05B 9D A0 14 
  TAY                                             ; 00B05E A8 
  LDA.B #$01                                      ; 00B05F A9 01 
  STA.W $175E,Y                                   ; 00B061 99 5E 17 
  STA.W $175F,Y                                   ; 00B064 99 5F 17 
  PHX                                             ; 00B067 DA 
  PHY                                             ; 00B068 5A 
  LDA.W $18A3,X                                   ; 00B069 BD A3 18 
  BNE.B B_B074                                    ; 00B06C D0 06 
  JSL L_AEF1                                      ; 00B06E 22 F1 AE 00 
  BRA.B B_B078                                    ; 00B072 80 04 
B_B074:
  JSL L_AED8                                      ; 00B074 22 D8 AE 00 
B_B078:
  PLY                                             ; 00B078 7A 
  INY                                             ; 00B079 C8 
  JSL L_AEF1                                      ; 00B07A 22 F1 AE 00 
  PLX                                             ; 00B07E FA 
  LDA.B #$2D                                      ; 00B07F A9 2D 
  STA.W XexzyWalkAnimation,X                      ; 00B081 9D 86 18 
  LDA.W $18A3,X                                   ; 00B084 BD A3 18 
  BEQ.B B_B09B                                    ; 00B087 F0 12 
  LDA.W $1897,X                                   ; 00B089 BD 97 18 
  CMP.B #$03                                      ; 00B08C C9 03 
  BNE.B B_B09B                                    ; 00B08E D0 0B 

.byte $A9,$07,$22,$64,$80,$03,$30,$03             ; 00B090 ........ ??"d??0?
.byte $8C,$D1,$18                                 ; 00B099 ...      ???

B_B09B:
  LDA.W $1897,X                                   ; 00B09B BD 97 18 
  TAY                                             ; 00B09E A8 
  LDA.W D_B0EC,Y                                  ; 00B09F B9 EC B0 
  STA.W $1884,X                                   ; 00B0A2 9D 84 18 
  LDA.B #$01                                      ; 00B0A5 A9 01 
  STA.W $1874,X                                   ; 00B0A7 9D 74 18 
  STA.W $19D5,X                                   ; 00B0AA 9D D5 19 
  STA.W $187C,X                                   ; 00B0AD 9D 7C 18 
  STA.W $19D3,X                                   ; 00B0B0 9D D3 19 
  LDA.W D_B0F5,X                                  ; 00B0B3 BD F5 B0 
  STA.W EntityV29,X                                   ; 00B0B6 9D BC 13 
  LDA.W D_B0F3,X                                  ; 00B0B9 BD F3 B0 
  STA.W EntityV30,X                                   ; 00B0BC 9D 2E 14 
  STZ.W $18B2,X                                   ; 00B0BF 9E B2 18 
  LDA.B #$09                                      ; 00B0C2 A9 09 
  STA.W $18B0,X                                   ; 00B0C4 9D B0 18 
  STZ.W $1893,X                                   ; 00B0C7 9E 93 18 
  STZ.W $1895,X                                   ; 00B0CA 9E 95 18 
  STZ.W $188A,X                                   ; 00B0CD 9E 8A 18 
  STZ.W $1888,X                                   ; 00B0D0 9E 88 18 
  STZ.W $18A9,X                                   ; 00B0D3 9E A9 18 
  STZ.W $18AB,X                                   ; 00B0D6 9E AB 18 
  STZ.W $18AD,X                                   ; 00B0D9 9E AD 18 
  STZ.W $18A5,X                                   ; 00B0DC 9E A5 18 
  DEX                                             ; 00B0DF CA 
  BMI.B B_B0E5                                    ; 00B0E0 30 03 
  JMP.W D_B037                                    ; 00B0E2 4C 37 B0 
B_B0E5:
  STZ.W $18AF                                     ; 00B0E5 9C AF 18 
  PLP                                             ; 00B0E8 28 
  RTS                                             ; 00B0E9 60 


D_B0EA:
.byte $00,$08                                     ; 00B0EB DD       ??
D_B0EC:
.byte $01,$10,$1A,$1F,$24                         ; 00B0ED D....    ????$
D_B0F1:
.byte $40,$C0                                     ; 00B0F2 DD       @?
D_B0F3:
.byte $25,$27                                     ; 00B0F4 DD       %'
D_B0F5:
.byte $00,$04                                     ; 00B0F6 DD       ??
D_B0F7:
.byte $00,$02                                     ; 00B0F8 DD       ??


L_B0F9:
  PHP                                             ; 00B0F9 08 
  PHB                                             ; 00B0FA 8B 
  REP.B #$10                                      ; 00B0FB C2 10 
  SEP.B #P_Acc8Bit                                      ; 00B0FD E2 20 
  LDX.W #$0001                                    ; 00B0FF A2 01 00 
  LDA.B #$0F                                      ; 00B102 A9 0F 
  JSL Audio_F830F                                     ; 00B104 22 0F 83 0F 
  SEP.B #$10                                      ; 00B108 E2 10 
  JSR.W L_B008                                    ; 00B10A 20 08 B0 
  LDA.W $18A3                                     ; 00B10D AD A3 18 
  BNE.B B_B115                                    ; 00B110 D0 03 

.byte $4C,$82,$B2                                 ; 00B113 ...      L??

B_B115:
  LDA.W $18A5                                     ; 00B115 AD A5 18 
  BEQ.B B_B11D                                    ; 00B118 F0 03 
  JMP.W D_B20F                                    ; 00B11A 4C 0F B2 
B_B11D:
  LDA.W $18AB                                     ; 00B11D AD AB 18 
  BEQ.B B_B13F                                    ; 00B120 F0 1D 
  CLC                                             ; 00B122 18 
  LDA.B #$00                                      ; 00B123 A9 00 
  STA.W $18B4                                     ; 00B125 8D B4 18 
  ADC.W EntityXSubPx                                     ; 00B128 6D D4 0A 
  STA.W EntityXSubPx                                     ; 00B12B 8D D4 0A 
  LDA.B #$01                                      ; 00B12E A9 01 
  STA.W $18B6                                     ; 00B130 8D B6 18 
  ADC.W XexzyCharX                                ; 00B133 6D 46 0B 
  STA.W XexzyCharX                                ; 00B136 8D 46 0B 
  DEC.W $18AB                                     ; 00B139 CE AB 18 
  JMP.W D_B20F                                    ; 00B13C 4C 0F B2 
B_B13F:
  LDA.W EntityXSubPx                                     ; 00B13F AD D4 0A 
  STA.W $18BC                                     ; 00B142 8D BC 18 
  LDA.W XexzyCharX                                ; 00B145 AD 46 0B 
  STA.W $18BD                                     ; 00B148 8D BD 18 
  LDA.W EntityYSubPx                                     ; 00B14B AD 2A 0C 
  STA.W $18BE                                     ; 00B14E 8D BE 18 
  LDA.W EntityYPx                                     ; 00B151 AD 9C 0C 
  STA.W $18BF                                     ; 00B154 8D BF 18 
  LDA.W JoyDown+1                                     ; 00B157 AD F1 02 
  AND.B #BTN1_R|BTN1_L|BTN1_D|BTN1_U                                      ; 00B15A 29 0F 
  ASL                                             ; 00B15C 0A 
  TAX                                             ; 00B15D AA 
  STZ.W $18C0                                     ; 00B15E 9C C0 18 
  LDY.B #$00                                      ; 00B161 A0 00 
  LDA.W $18AD                                     ; 00B163 AD AD 18 
  BEQ.B B_B16A                                    ; 00B166 F0 02 
  LDY.B #$02                                      ; 00B168 A0 02 
B_B16A:
  JSR.W (L_B42F,X)                                ; 00B16A FC 2F B4 
  STZ.B $04                                       ; 00B16D 64 04 
  LDA.W JoyDown                                     ; 00B16F AD F0 02 
  AND.B #BTN0_A                                      ; 00B172 29 80 
  BEQ.B B_B17A                                    ; 00B174 F0 04 
  LDA.B #$01                                      ; 00B176 A9 01 
  STA.B $04                                       ; 00B178 85 04 
B_B17A:
  LDA.W JoyDown+1                                     ; 00B17A AD F1 02 
  AND.B #BTN1_Y                                      ; 00B17D 29 40 
  BEQ.B B_B187                                    ; 00B17F F0 06 
  LDA.B $04                                       ; 00B181 A5 04 
  ORA.B #$02                                      ; 00B183 09 02 
  STA.B $04                                       ; 00B185 85 04 
B_B187:
  LDA.W JoyDown                                     ; 00B187 AD F0 02 
  AND.B #BTN0_X                                      ; 00B18A 29 40 
  BEQ.B B_B194                                    ; 00B18C F0 06 
  LDA.B $04                                       ; 00B18E A5 04 
  ORA.B #$08                                      ; 00B190 09 08 
  STA.B $04                                       ; 00B192 85 04 
B_B194:
  LDA.W JoyDown+1                                     ; 00B194 AD F1 02 
  AND.B #BTN1_B                                      ; 00B197 29 80 
  BEQ.B B_B1A1                                    ; 00B199 F0 06 
  LDA.B $04                                       ; 00B19B A5 04 
  ORA.B #$04                                      ; 00B19D 09 04 
  STA.B $04                                       ; 00B19F 85 04 
B_B1A1:
  LDA.B $04                                       ; 00B1A1 A5 04 
  BEQ.B B_B1D8                                    ; 00B1A3 F0 33 
  ASL                                             ; 00B1A5 0A 
  TAX                                             ; 00B1A6 AA 
  LDA.W $18B2                                     ; 00B1A7 AD B2 18 
  BNE.B B_B1D6                                    ; 00B1AA D0 2A 
  JSR.W (L_B675,X)                                ; 00B1AC FC 75 B6 
  LDA.W $1895                                     ; 00B1AF AD 95 18 
  LDX.B #$00                                      ; 00B1B2 A2 00 
  JSR.W L_B7F1                                    ; 00B1B4 20 F1 B7 
  LDA.W $1874                                     ; 00B1B7 AD 74 18 
  BEQ.B B_B1D6                                    ; 00B1BA F0 1A 
  LDY.W $1895                                     ; 00B1BC AC 95 18 
  STY.W $1893                                     ; 00B1BF 8C 93 18 
  LDA.W D_B44F,Y                                  ; 00B1C2 B9 4F B4 
  STA.W $1888                                     ; 00B1C5 8D 88 18 
  LDA.W D_B49E,Y                                  ; 00B1C8 B9 9E B4 
  CMP.W XexzyWalkAnimation                        ; 00B1CB CD 86 18 
  STA.W XexzyWalkAnimation                        ; 00B1CE 8D 86 18 
  LDA.B #$01                                      ; 00B1D1 A9 01 
  STA.W $19D5                                     ; 00B1D3 8D D5 19 
B_B1D6:
  BRA.B B_B20A                                    ; 00B1D6 80 32 
B_B1D8:
  LDA.W JoyDown+1                                     ; 00B1D8 AD F1 02 
  AND.B #BTN1_R|BTN1_L|BTN1_D|BTN1_U                                      ; 00B1DB 29 0F 
  ASL                                             ; 00B1DD 0A 
  TAX                                             ; 00B1DE AA 
  LDA.W $187C                                     ; 00B1DF AD 7C 18 
  BEQ.B B_B20A                                    ; 00B1E2 F0 26 
  JSR.W (L_B675,X)                                ; 00B1E4 FC 75 B6 
  LDA.B #$01                                      ; 00B1E7 A9 01 
  STA.W $187C                                     ; 00B1E9 8D 7C 18 
  STZ.W $187E                                     ; 00B1EC 9C 7E 18 
  LDA.W $1897                                     ; 00B1EF AD 97 18 
  ASL                                             ; 00B1F2 0A 
  ASL                                             ; 00B1F3 0A 
  ASL                                             ; 00B1F4 0A 
  CLC                                             ; 00B1F5 18 
  ADC.W $1893                                     ; 00B1F6 6D 93 18 
  TAY                                             ; 00B1F9 A8 
  LDA.W D_B457,Y                                  ; 00B1FA B9 57 B4 
  CMP.W $1884                                     ; 00B1FD CD 84 18 
  BEQ.B B_B20A                                    ; 00B200 F0 08 
  STA.W $1884                                     ; 00B202 8D 84 18 
  LDA.B #$01                                      ; 00B205 A9 01 
  STA.W $19D3                                     ; 00B207 8D D3 19 
B_B20A:
  LDX.B #$00                                      ; 00B20A A2 00 
  JSR.W L_B6FC                                    ; 00B20C 20 FC B6 
D_B20F:
  LDA.W $18A9                                     ; 00B20F AD A9 18 
  BEQ.B B_B24C                                    ; 00B212 F0 38 
  LDX.B #$00                                      ; 00B214 A2 00 
  SEC                                             ; 00B216 38 
  LDA.W XexzyCharX,X                              ; 00B217 BD 46 0B 
  SBC.B #$09                                      ; 00B21A E9 09 
  BCS.B B_B220                                    ; 00B21C B0 02 
  LDA.B #$00                                      ; 00B21E A9 00 
B_B220:
  STA.W EntityV32,X                                   ; 00B220 9D 16 15 
  CLC                                             ; 00B223 18 
  LDA.W XexzyCharX,X                              ; 00B224 BD 46 0B 
  ADC.B #$09                                      ; 00B227 69 09 
  BCC.B B_B22D                                    ; 00B229 90 02 

.byte $A9,$FF                                     ; 00B22C ..       ??

B_B22D:
  STA.W EntityV33,X                                   ; 00B22D 9D 88 15 
  SEC                                             ; 00B230 38 
  LDA.W EntityYPx,X                                   ; 00B231 BD 9C 0C 
  SBC.B #$09                                      ; 00B234 E9 09 
  BCS.B B_B23A                                    ; 00B236 B0 02 

.byte $A9,$00                                     ; 00B239 ..       ??

B_B23A:
  STA.W EntityV34,X                                   ; 00B23A 9D FA 15 
  CLC                                             ; 00B23D 18 
  LDA.W EntityYPx,X                                   ; 00B23E BD 9C 0C 
  ADC.B #$09                                      ; 00B241 69 09 
  BCC.B B_B247                                    ; 00B243 90 02 

.byte $A9,$FF                                     ; 00B246 ..       ??

B_B247:
  STA.W EntityV35,X                                   ; 00B247 9D 6C 16 
  BRA.B B_B282                                    ; 00B24A 80 36 
B_B24C:
  LDX.B #$00                                      ; 00B24C A2 00 
  SEC                                             ; 00B24E 38 
  LDA.W XexzyCharX,X                              ; 00B24F BD 46 0B 
  SBC.B #$04                                      ; 00B252 E9 04 
  BCS.B B_B258                                    ; 00B254 B0 02 

.byte $A9,$00                                     ; 00B257 ..       ??

B_B258:
  STA.W EntityV32,X                                   ; 00B258 9D 16 15 
  CLC                                             ; 00B25B 18 
  LDA.W XexzyCharX,X                              ; 00B25C BD 46 0B 
  ADC.B #$04                                      ; 00B25F 69 04 
  BCC.B B_B265                                    ; 00B261 90 02 

.byte $A9,$FF                                     ; 00B264 ..       ??

B_B265:
  STA.W EntityV33,X                                   ; 00B265 9D 88 15 
  SEC                                             ; 00B268 38 
  LDA.W EntityYPx,X                                   ; 00B269 BD 9C 0C 
  SBC.B #$04                                      ; 00B26C E9 04 
  BCS.B B_B272                                    ; 00B26E B0 02 

.byte $A9,$00                                     ; 00B271 ..       ??

B_B272:
  STA.W EntityV34,X                                   ; 00B272 9D FA 15 
  CLC                                             ; 00B275 18 
  LDA.W EntityYPx,X                                   ; 00B276 BD 9C 0C 
  ADC.B #$04                                      ; 00B279 69 04 
  BCC.B B_B27F                                    ; 00B27B 90 02 

.byte $A9,$FF                                     ; 00B27E ..       ??

B_B27F:
  STA.W EntityV35,X                                   ; 00B27F 9D 6C 16 
B_B282:
  LDA.W $18A4                                     ; 00B282 AD A4 18 
  BNE.B B_B28A                                    ; 00B285 D0 03 
  JMP.W D_B3FB                                    ; 00B287 4C FB B3 
B_B28A:
  LDA.W $18A6                                     ; 00B28A AD A6 18 
  BEQ.B B_B292                                    ; 00B28D F0 03 
  JMP.W D_B388                                    ; 00B28F 4C 88 B3 
B_B292:
  LDA.W $18AC                                     ; 00B292 AD AC 18 
  BEQ.B B_B2B4                                    ; 00B295 F0 1D 
  CLC                                             ; 00B297 18 
  LDA.B #$00                                      ; 00B298 A9 00 
  STA.W $18B5                                     ; 00B29A 8D B5 18 
  ADC.W $0AD5                                     ; 00B29D 6D D5 0A 
  STA.W $0AD5                                     ; 00B2A0 8D D5 0A 
  LDA.B #$FF                                      ; 00B2A3 A9 FF 
  STA.W $18B7                                     ; 00B2A5 8D B7 18 
  ADC.W EntityXPx+1                                     ; 00B2A8 6D 47 0B 
  STA.W EntityXPx+1                                     ; 00B2AB 8D 47 0B 
  DEC.W $18AC                                     ; 00B2AE CE AC 18 
  JMP.W D_B388                                    ; 00B2B1 4C 88 B3 
B_B2B4:
  LDA.W $0AD5                                     ; 00B2B4 AD D5 0A 
  STA.W $18BC                                     ; 00B2B7 8D BC 18 
  LDA.W EntityXPx+1                                     ; 00B2BA AD 47 0B 
  STA.W $18BD                                     ; 00B2BD 8D BD 18 
  LDA.W EntityYSubPx+1                                     ; 00B2C0 AD 2B 0C 
  STA.W $18BE                                     ; 00B2C3 8D BE 18 
  LDA.W EntityYPx+1                                     ; 00B2C6 AD 9D 0C 
  STA.W $18BF                                     ; 00B2C9 8D BF 18 
  LDA.W Joy2Down+1                                     ; 00B2CC AD F3 02 
  AND.B #BTN1_R|BTN1_L|BTN1_D|BTN1_U                                      ; 00B2CF 29 0F 
  ASL                                             ; 00B2D1 0A 
  TAX                                             ; 00B2D2 AA 
  LDA.B #$01                                      ; 00B2D3 A9 01 
  STA.W $18C0                                     ; 00B2D5 8D C0 18 
  LDY.B #$00                                      ; 00B2D8 A0 00 
  LDA.W $18AE                                     ; 00B2DA AD AE 18 
  BEQ.B B_B2E1                                    ; 00B2DD F0 02 

.byte $A0,$02                                     ; 00B2E0 ..       ??

B_B2E1:
  JSR.W (L_B42F,X)                                ; 00B2E1 FC 2F B4 
  STZ.B $04                                       ; 00B2E4 64 04 
  LDA.W Joy2Down                                     ; 00B2E6 AD F2 02 
  AND.B #BTN0_A                                      ; 00B2E9 29 80 
  BEQ.B B_B2F1                                    ; 00B2EB F0 04 
  LDA.B #$01                                      ; 00B2ED A9 01 
  STA.B $04                                       ; 00B2EF 85 04 
B_B2F1:
  LDA.W Joy2Down+1                                     ; 00B2F1 AD F3 02 
  AND.B #BTN1_Y                                      ; 00B2F4 29 40 
  BEQ.B B_B2FE                                    ; 00B2F6 F0 06 
  LDA.B $04                                       ; 00B2F8 A5 04 
  ORA.B #$02                                      ; 00B2FA 09 02 
  STA.B $04                                       ; 00B2FC 85 04 
B_B2FE:
  LDA.W Joy2Down                                     ; 00B2FE AD F2 02 
  AND.B #BTN0_X                                      ; 00B301 29 40 
  BEQ.B B_B30B                                    ; 00B303 F0 06 
  LDA.B $04                                       ; 00B305 A5 04 
  ORA.B #$08                                      ; 00B307 09 08 
  STA.B $04                                       ; 00B309 85 04 
B_B30B:
  LDA.W Joy2Down+1                                     ; 00B30B AD F3 02 
  AND.B #BTN1_B                                      ; 00B30E 29 80 
  BEQ.B B_B318                                    ; 00B310 F0 06 
  LDA.B $04                                       ; 00B312 A5 04 
  ORA.B #$04                                      ; 00B314 09 04 
  STA.B $04                                       ; 00B316 85 04 
B_B318:
  LDA.B $04                                       ; 00B318 A5 04 
  BEQ.B B_B351                                    ; 00B31A F0 35 
  ASL                                             ; 00B31C 0A 
  TAX                                             ; 00B31D AA 
  LDA.W $18B3                                     ; 00B31E AD B3 18 
  BNE.B B_B34F                                    ; 00B321 D0 2C 
  JSR.W (L_B675,X)                                ; 00B323 FC 75 B6 
  LDA.W $1896                                     ; 00B326 AD 96 18 
  LDX.B #$01                                      ; 00B329 A2 01 
  JSR.W L_B7F1                                    ; 00B32B 20 F1 B7 
  LDA.W $1875                                     ; 00B32E AD 75 18 
  BEQ.B B_B34F                                    ; 00B331 F0 1C 
  LDY.W $1896                                     ; 00B333 AC 96 18 
  STY.W $1894                                     ; 00B336 8C 94 18 
  LDA.W D_B44F,Y                                  ; 00B339 B9 4F B4 
  STA.W $1889                                     ; 00B33C 8D 89 18 
  LDA.W D_B49E,Y                                  ; 00B33F B9 9E B4 
  CMP.W $1887                                     ; 00B342 CD 87 18 
  BEQ.B B_B34F                                    ; 00B345 F0 08 
  STA.W $1887                                     ; 00B347 8D 87 18 
  LDA.B #$01                                      ; 00B34A A9 01 
  STA.W $19D6                                     ; 00B34C 8D D6 19 
B_B34F:
  BRA.B B_B383                                    ; 00B34F 80 32 
B_B351:
  LDA.W Joy2Down+1                                     ; 00B351 AD F3 02 
  AND.B #BTN1_R|BTN1_L|BTN1_D|BTN1_U                                      ; 00B354 29 0F 
  ASL                                             ; 00B356 0A 
  TAX                                             ; 00B357 AA 
  LDA.W $187D                                     ; 00B358 AD 7D 18 
  BEQ.B B_B383                                    ; 00B35B F0 26 
  JSR.W (L_B675,X)                                ; 00B35D FC 75 B6 
  LDA.B #$01                                      ; 00B360 A9 01 
  STA.W $187D                                     ; 00B362 8D 7D 18 
  STZ.W $187F                                     ; 00B365 9C 7F 18 
  LDA.W $1898                                     ; 00B368 AD 98 18 
  ASL                                             ; 00B36B 0A 
  ASL                                             ; 00B36C 0A 
  ASL                                             ; 00B36D 0A 
  CLC                                             ; 00B36E 18 
  ADC.W $1894                                     ; 00B36F 6D 94 18 
  TAY                                             ; 00B372 A8 
  LDA.W D_B457,Y                                  ; 00B373 B9 57 B4 
  CMP.W $1885                                     ; 00B376 CD 85 18 
  BEQ.B B_B383                                    ; 00B379 F0 08 
  STA.W $1885                                     ; 00B37B 8D 85 18 
  LDA.B #$01                                      ; 00B37E A9 01 
  STA.W $19D4                                     ; 00B380 8D D4 19 
B_B383:
  LDX.B #$01                                      ; 00B383 A2 01 
  JSR.W L_B6FC                                    ; 00B385 20 FC B6 
D_B388:
  LDA.W $18AA                                     ; 00B388 AD AA 18 
  BEQ.B B_B3C5                                    ; 00B38B F0 38 
  LDX.B #$01                                      ; 00B38D A2 01 
  SEC                                             ; 00B38F 38 
  LDA.W XexzyCharX,X                              ; 00B390 BD 46 0B 
  SBC.B #$09                                      ; 00B393 E9 09 
  BCS.B B_B399                                    ; 00B395 B0 02 

.byte $A9,$00                                     ; 00B398 ..       ??

B_B399:
  STA.W EntityV32,X                                   ; 00B399 9D 16 15 
  CLC                                             ; 00B39C 18 
  LDA.W XexzyCharX,X                              ; 00B39D BD 46 0B 
  ADC.B #$09                                      ; 00B3A0 69 09 
  BCC.B B_B3A6                                    ; 00B3A2 90 02 
  LDA.B #$FF                                      ; 00B3A4 A9 FF 
B_B3A6:
  STA.W EntityV33,X                                   ; 00B3A6 9D 88 15 
  SEC                                             ; 00B3A9 38 
  LDA.W EntityYPx,X                                   ; 00B3AA BD 9C 0C 
  SBC.B #$09                                      ; 00B3AD E9 09 
  BCS.B B_B3B3                                    ; 00B3AF B0 02 

.byte $A9,$00                                     ; 00B3B2 ..       ??

B_B3B3:
  STA.W EntityV34,X                                   ; 00B3B3 9D FA 15 
  CLC                                             ; 00B3B6 18 
  LDA.W EntityYPx,X                                   ; 00B3B7 BD 9C 0C 
  ADC.B #$09                                      ; 00B3BA 69 09 
  BCC.B B_B3C0                                    ; 00B3BC 90 02 

.byte $A9,$FF                                     ; 00B3BF ..       ??

B_B3C0:
  STA.W EntityV35,X                                   ; 00B3C0 9D 6C 16 
  BRA.B D_B3FB                                    ; 00B3C3 80 36 
B_B3C5:
  LDX.B #$01                                      ; 00B3C5 A2 01 
  SEC                                             ; 00B3C7 38 
  LDA.W XexzyCharX,X                              ; 00B3C8 BD 46 0B 
  SBC.B #$04                                      ; 00B3CB E9 04 
  BCS.B B_B3D1                                    ; 00B3CD B0 02 

.byte $A9,$00                                     ; 00B3D0 ..       ??

B_B3D1:
  STA.W EntityV32,X                                   ; 00B3D1 9D 16 15 
  CLC                                             ; 00B3D4 18 
  LDA.W XexzyCharX,X                              ; 00B3D5 BD 46 0B 
  ADC.B #$04                                      ; 00B3D8 69 04 
  BCC.B B_B3DE                                    ; 00B3DA 90 02 

.byte $A9,$FF                                     ; 00B3DD ..       ??

B_B3DE:
  STA.W EntityV33,X                                   ; 00B3DE 9D 88 15 
  SEC                                             ; 00B3E1 38 
  LDA.W EntityYPx,X                                   ; 00B3E2 BD 9C 0C 
  SBC.B #$04                                      ; 00B3E5 E9 04 
  BCS.B B_B3EB                                    ; 00B3E7 B0 02 

.byte $A9,$00                                     ; 00B3EA ..       ??

B_B3EB:
  STA.W EntityV34,X                                   ; 00B3EB 9D FA 15 
  CLC                                             ; 00B3EE 18 
  LDA.W EntityYPx,X                                   ; 00B3EF BD 9C 0C 
  ADC.B #$04                                      ; 00B3F2 69 04 
  BCC.B B_B3F8                                    ; 00B3F4 90 02 

.byte $A9,$FF                                     ; 00B3F7 ..       ??

B_B3F8:
  STA.W EntityV35,X                                   ; 00B3F8 9D 6C 16 
D_B3FB:
  REP.B #$10                                      ; 00B3FB C2 10 
  LDX.W $05E0                                     ; 00B3FD AE E0 05 
  LDA.B #$0F                                      ; 00B400 A9 0F 
  JSL Audio_F830F                                     ; 00B402 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00B406 E2 30 
  LDA.W $18A3                                     ; 00B408 AD A3 18 
  BEQ.B B_B420                                    ; 00B40B F0 13 
  LDA.W $18A4                                     ; 00B40D AD A4 18 
  BNE.B B_B42C                                    ; 00B410 D0 1A 
  LDA.W XexzyCharX                                ; 00B412 AD 46 0B 
  STA.W EntityXPx+1                                     ; 00B415 8D 47 0B 
  LDA.W EntityYPx                                     ; 00B418 AD 9C 0C 
  STA.W EntityYPx+1                                     ; 00B41B 8D 9D 0C 
  BRA.B B_B42C                                    ; 00B41E 80 0C 

B_B420:
.byte $AD,$47,$0B,$8D,$46,$0B,$AD,$9D             ; 00B420 ........ ?G??F???
.byte $0C,$8D,$9C,$0C                             ; 00B429 ....     ????

B_B42C:
  PLB                                             ; 00B42C AB 
  PLP                                             ; 00B42D 28 
  RTS                                             ; 00B42E 60 


L_B42F:
.byte $7F,$B4,$A6,$B4,$C5,$B4,$7F,$B4             ; 00B42F DDDDDD.. ????????
.byte $E4,$B4,$03,$B5,$35,$B5,$7F,$B4             ; 00B437 DDDDDD.. ????5???
.byte $67,$B5,$86,$B5,$B8,$B5,$7F,$B4             ; 00B43F DDDDDD.. g???????
.byte $7F,$B4,$7F,$B4,$7F,$B4,$7F,$B4             ; 00B447 ........ ????????
D_B44F:
.byte $00,$00,$00,$00,$00,$40,$40,$40             ; 00B44F DDDDDDDD ?????@@@
D_B457:
.byte $01,$02,$03,$04,$05,$04,$03,$02             ; 00B457 DDDDDDDD ????????
.byte $10,$11,$12,$13,$14,$13,$12,$11             ; 00B45F DDD.DDDD ????????
.byte $1A,$1B,$1C,$1D,$1E,$1D,$1C,$1B             ; 00B467 DDDDDDDD ????????
.byte $1F,$20,$21,$22,$23,$22,$21,$20             ; 00B46F DD..D... ? !"#"! 
.byte $24,$25,$26,$27,$28,$27,$26,$25             ; 00B477 ........ $%&'('&%

  LDX.W $18C0                                     ; 00B47F AE C0 18 
  LDA.B #$01                                      ; 00B482 A9 01 
  STA.W $1874,X                                   ; 00B484 9D 74 18 
  STZ.W $1876,X                                   ; 00B487 9E 76 18 
  LDY.W $1893,X                                   ; 00B48A BC 93 18 
  LDA.W D_B49E,Y                                  ; 00B48D B9 9E B4 
  CMP.W XexzyWalkAnimation,X                      ; 00B490 DD 86 18 
  BEQ.B B_B49D                                    ; 00B493 F0 08 
  STA.W XexzyWalkAnimation,X                      ; 00B495 9D 86 18 
  LDA.B #$01                                      ; 00B498 A9 01 
  STA.W $19D5,X                                   ; 00B49A 9D D5 19 
B_B49D:
  RTS                                             ; 00B49D 60 


D_B49E:
.byte $2D,$2C,$2B,$2A,$29,$2A,$2B,$2C             ; 00B49E DDDDDDDD -,+*)*+,

  LDX.W $18C0                                     ; 00B4A6 AE C0 18 
  CLC                                             ; 00B4A9 18 
  LDA.W EntityXSubPx,X                                   ; 00B4AA BD D4 0A 
  ADC.W D_B66D,Y                                  ; 00B4AD 79 6D B6 
  STA.W $18BC                                     ; 00B4B0 8D BC 18 
  LDA.W XexzyCharX,X                              ; 00B4B3 BD 46 0B 
  ADC.W D_B66E,Y                                  ; 00B4B6 79 6E B6 
  STA.W $18BD                                     ; 00B4B9 8D BD 18 
  LDA.B #$02                                      ; 00B4BC A9 02 
  STA.W $1893,X                                   ; 00B4BE 9D 93 18 
  JSR.W L_B5EA                                    ; 00B4C1 20 EA B5 
  RTS                                             ; 00B4C4 60 

  LDX.W $18C0                                     ; 00B4C5 AE C0 18 
  SEC                                             ; 00B4C8 38 
  LDA.W EntityXSubPx,X                                   ; 00B4C9 BD D4 0A 
  SBC.W D_B66D,Y                                  ; 00B4CC F9 6D B6 
  STA.W $18BC                                     ; 00B4CF 8D BC 18 
  LDA.W XexzyCharX,X                              ; 00B4D2 BD 46 0B 
  SBC.W D_B66E,Y                                  ; 00B4D5 F9 6E B6 
  STA.W $18BD                                     ; 00B4D8 8D BD 18 
  LDA.B #$06                                      ; 00B4DB A9 06 
  STA.W $1893,X                                   ; 00B4DD 9D 93 18 
  JSR.W L_B5EA                                    ; 00B4E0 20 EA B5 
  RTS                                             ; 00B4E3 60 

  LDX.W $18C0                                     ; 00B4E4 AE C0 18 
  CLC                                             ; 00B4E7 18 
  LDA.W EntityYSubPx,X                                   ; 00B4E8 BD 2A 0C 
  ADC.W D_B66D,Y                                  ; 00B4EB 79 6D B6 
  STA.W $18BE                                     ; 00B4EE 8D BE 18 
  LDA.W EntityYPx,X                                   ; 00B4F1 BD 9C 0C 
  ADC.W D_B66E,Y                                  ; 00B4F4 79 6E B6 
  STA.W $18BF                                     ; 00B4F7 8D BF 18 
  LDA.B #$00                                      ; 00B4FA A9 00 
  STA.W $1893,X                                   ; 00B4FC 9D 93 18 
  JSR.W L_B5EA                                    ; 00B4FF 20 EA B5 
  RTS                                             ; 00B502 60 

  LDX.W $18C0                                     ; 00B503 AE C0 18 
  CLC                                             ; 00B506 18 
  LDA.W EntityYSubPx,X                                   ; 00B507 BD 2A 0C 
  ADC.W D_B671,Y                                  ; 00B50A 79 71 B6 
  STA.W $18BE                                     ; 00B50D 8D BE 18 
  LDA.W EntityYPx,X                                   ; 00B510 BD 9C 0C 
  ADC.W D_B672,Y                                  ; 00B513 79 72 B6 
  STA.W $18BF                                     ; 00B516 8D BF 18 
  CLC                                             ; 00B519 18 
  LDA.W EntityXSubPx,X                                   ; 00B51A BD D4 0A 
  ADC.W D_B671,Y                                  ; 00B51D 79 71 B6 
  STA.W $18BC                                     ; 00B520 8D BC 18 
  LDA.W XexzyCharX,X                              ; 00B523 BD 46 0B 
  ADC.W D_B672,Y                                  ; 00B526 79 72 B6 
  STA.W $18BD                                     ; 00B529 8D BD 18 
  LDA.B #$01                                      ; 00B52C A9 01 
  STA.W $1893,X                                   ; 00B52E 9D 93 18 
  JSR.W L_B5EA                                    ; 00B531 20 EA B5 
  RTS                                             ; 00B534 60 

  LDX.W $18C0                                     ; 00B535 AE C0 18 
  CLC                                             ; 00B538 18 
  LDA.W EntityYSubPx,X                                   ; 00B539 BD 2A 0C 
  ADC.W D_B671,Y                                  ; 00B53C 79 71 B6 
  STA.W $18BE                                     ; 00B53F 8D BE 18 
  LDA.W EntityYPx,X                                   ; 00B542 BD 9C 0C 
  ADC.W D_B672,Y                                  ; 00B545 79 72 B6 
  STA.W $18BF                                     ; 00B548 8D BF 18 
  SEC                                             ; 00B54B 38 
  LDA.W EntityXSubPx,X                                   ; 00B54C BD D4 0A 
  SBC.W D_B671,Y                                  ; 00B54F F9 71 B6 
  STA.W $18BC                                     ; 00B552 8D BC 18 
  LDA.W XexzyCharX,X                              ; 00B555 BD 46 0B 
  SBC.W D_B672,Y                                  ; 00B558 F9 72 B6 
  STA.W $18BD                                     ; 00B55B 8D BD 18 
  LDA.B #$07                                      ; 00B55E A9 07 
  STA.W $1893,X                                   ; 00B560 9D 93 18 
  JSR.W L_B5EA                                    ; 00B563 20 EA B5 
  RTS                                             ; 00B566 60 

  LDX.W $18C0                                     ; 00B567 AE C0 18 
  SEC                                             ; 00B56A 38 
  LDA.W EntityYSubPx,X                                   ; 00B56B BD 2A 0C 
  SBC.W D_B66D,Y                                  ; 00B56E F9 6D B6 
  STA.W $18BE                                     ; 00B571 8D BE 18 
  LDA.W EntityYPx,X                                   ; 00B574 BD 9C 0C 
  SBC.W D_B66E,Y                                  ; 00B577 F9 6E B6 
  STA.W $18BF                                     ; 00B57A 8D BF 18 
  LDA.B #$04                                      ; 00B57D A9 04 
  STA.W $1893,X                                   ; 00B57F 9D 93 18 
  JSR.W L_B5EA                                    ; 00B582 20 EA B5 
  RTS                                             ; 00B585 60 

  LDX.W $18C0                                     ; 00B586 AE C0 18 
  SEC                                             ; 00B589 38 
  LDA.W EntityYSubPx,X                                   ; 00B58A BD 2A 0C 
  SBC.W D_B671,Y                                  ; 00B58D F9 71 B6 
  STA.W $18BE                                     ; 00B590 8D BE 18 
  LDA.W EntityYPx,X                                   ; 00B593 BD 9C 0C 
  SBC.W D_B672,Y                                  ; 00B596 F9 72 B6 
  STA.W $18BF                                     ; 00B599 8D BF 18 
  CLC                                             ; 00B59C 18 
  LDA.W EntityXSubPx,X                                   ; 00B59D BD D4 0A 
  ADC.W D_B671,Y                                  ; 00B5A0 79 71 B6 
  STA.W $18BC                                     ; 00B5A3 8D BC 18 
  LDA.W XexzyCharX,X                              ; 00B5A6 BD 46 0B 
  ADC.W D_B672,Y                                  ; 00B5A9 79 72 B6 
  STA.W $18BD                                     ; 00B5AC 8D BD 18 
  LDA.B #$03                                      ; 00B5AF A9 03 
  STA.W $1893,X                                   ; 00B5B1 9D 93 18 
  JSR.W L_B5EA                                    ; 00B5B4 20 EA B5 
  RTS                                             ; 00B5B7 60 

  LDX.W $18C0                                     ; 00B5B8 AE C0 18 
  SEC                                             ; 00B5BB 38 
  LDA.W EntityYSubPx,X                                   ; 00B5BC BD 2A 0C 
  SBC.W D_B671,Y                                  ; 00B5BF F9 71 B6 
  STA.W $18BE                                     ; 00B5C2 8D BE 18 
  LDA.W EntityYPx,X                                   ; 00B5C5 BD 9C 0C 
  SBC.W D_B672,Y                                  ; 00B5C8 F9 72 B6 
  STA.W $18BF                                     ; 00B5CB 8D BF 18 
  SEC                                             ; 00B5CE 38 
  LDA.W EntityXSubPx,X                                   ; 00B5CF BD D4 0A 
  SBC.W D_B671,Y                                  ; 00B5D2 F9 71 B6 
  STA.W $18BC                                     ; 00B5D5 8D BC 18 
  LDA.W XexzyCharX,X                              ; 00B5D8 BD 46 0B 
  SBC.W D_B672,Y                                  ; 00B5DB F9 72 B6 
  STA.W $18BD                                     ; 00B5DE 8D BD 18 
  LDA.B #$05                                      ; 00B5E1 A9 05 
  STA.W $1893,X                                   ; 00B5E3 9D 93 18 
  JSR.W L_B5EA                                    ; 00B5E6 20 EA B5 
  RTS                                             ; 00B5E9 60 


L_B5EA:
  LDA.W $1893,X                                   ; 00B5EA BD 93 18 
  ASL                                             ; 00B5ED 0A 
  ASL                                             ; 00B5EE 0A 
  ASL                                             ; 00B5EF 0A 
D_B5F0:
  CLC                                             ; 00B5F0 18 
D_B5F1:
  ADC.W $1895,X                                   ; 00B5F1 7D 95 18 
  TAY                                             ; 00B5F4 A8 
  LDA.W D_B62D,Y                                  ; 00B5F5 B9 2D B6 
  BEQ.B B_B605                                    ; 00B5F8 F0 0B 
  CLC                                             ; 00B5FA 18 
  LDA.W $1893,X                                   ; 00B5FB BD 93 18 
  ADC.B #$04                                      ; 00B5FE 69 04 
  AND.B #$07                                      ; 00B600 29 07 
  TAY                                             ; 00B602 A8 
  BRA.B B_B608                                    ; 00B603 80 03 
B_B605:
  LDY.W $1893,X                                   ; 00B605 BC 93 18 
B_B608:
  LDA.W D_B625,Y                                  ; 00B608 B9 25 B6 
  CMP.W $1876,X                                   ; 00B60B DD 76 18 
  BEQ.B B_B61C                                    ; 00B60E F0 0C 
  PHY                                             ; 00B610 5A 
  JSL L_E5C0                                      ; 00B611 22 C0 E5 00 
  PLY                                             ; 00B615 7A 
  LDA.W D_B61D,Y                                  ; 00B616 B9 1D B6 
  STA.W $1888,X                                   ; 00B619 9D 88 18 
B_B61C:
  RTS                                             ; 00B61C 60 


D_B61D:
.byte $00,$00,$00,$00,$00,$40,$40,$40             ; 00B61D DDDDDDDD ?????@@@
D_B625:
.byte $01,$02,$03,$04,$05,$06,$07,$08             ; 00B625 DDDDDDDD ????????
D_B62D:
.byte $00,$00,$00,$01,$01,$01,$00,$00             ; 00B62D DDDDDDDD ????????
.byte $00,$00,$00,$00,$01,$01,$01,$00             ; 00B635 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$01,$01,$01             ; 00B63D DDDDDDDD ????????
.byte $01,$00,$00,$00,$00,$00,$01,$01             ; 00B645 DDDDDDDD ????????
.byte $01,$01,$00,$00,$00,$00,$00,$01             ; 00B64D DDDDDDDD ????????
.byte $01,$01,$01,$00,$00,$00,$00,$00             ; 00B655 DDDDDDDD ????????
.byte $00,$01,$01,$01,$00,$00,$00,$00             ; 00B65D DDDDDDDD ????????
.byte $00,$00,$01,$01,$01,$00,$00,$00             ; 00B665 DDDDDDDD ????????
D_B66D:
.byte $20                                         ; 00B66E D         
D_B66E:
.byte $01,$80,$01                                 ; 00B66F DDD      ???
D_B671:
.byte $CC                                         ; 00B672 D        ?
D_B672:
.byte $00,$0F,$01                                 ; 00B673 DDD      ???
L_B675:
.byte $95,$B6,$96,$B6,$A2,$B6,$95,$B6             ; 00B675 DDDDDD.. ????????
.byte $B0,$B6,$BC,$B6,$C8,$B6,$95,$B6             ; 00B67D DDDDDD.. ????????
.byte $D6,$B6,$E2,$B6,$EE,$B6,$95,$B6             ; 00B685 DDDDDD.. ????????
.byte $95,$B6,$95,$B6,$95,$B6,$95,$B6             ; 00B68D ..DDDD.. ????????

  RTS                                             ; 00B695 60 

  LDX.W $18C0                                     ; 00B696 AE C0 18 
  LDA.B #$02                                      ; 00B699 A9 02 
  STA.W $1895,X                                   ; 00B69B 9D 95 18 
  STZ.W $188A,X                                   ; 00B69E 9E 8A 18 
  RTS                                             ; 00B6A1 60 

  LDX.W $18C0                                     ; 00B6A2 AE C0 18 
  LDA.B #$06                                      ; 00B6A5 A9 06 
  STA.W $1895,X                                   ; 00B6A7 9D 95 18 
  LDA.B #$40                                      ; 00B6AA A9 40 
  STA.W $188A,X                                   ; 00B6AC 9D 8A 18 
  RTS                                             ; 00B6AF 60 

  LDX.W $18C0                                     ; 00B6B0 AE C0 18 
  LDA.B #$00                                      ; 00B6B3 A9 00 
  STA.W $1895,X                                   ; 00B6B5 9D 95 18 
  STZ.W $188A,X                                   ; 00B6B8 9E 8A 18 
  RTS                                             ; 00B6BB 60 

  LDX.W $18C0                                     ; 00B6BC AE C0 18 
  LDA.B #$01                                      ; 00B6BF A9 01 
  STA.W $1895,X                                   ; 00B6C1 9D 95 18 
  STZ.W $188A,X                                   ; 00B6C4 9E 8A 18 
  RTS                                             ; 00B6C7 60 

  LDX.W $18C0                                     ; 00B6C8 AE C0 18 
  LDA.B #$07                                      ; 00B6CB A9 07 
  STA.W $1895,X                                   ; 00B6CD 9D 95 18 
  LDA.B #$40                                      ; 00B6D0 A9 40 
  STA.W $188A,X                                   ; 00B6D2 9D 8A 18 
  RTS                                             ; 00B6D5 60 

  LDX.W $18C0                                     ; 00B6D6 AE C0 18 
  LDA.B #$04                                      ; 00B6D9 A9 04 
  STA.W $1895,X                                   ; 00B6DB 9D 95 18 
  STZ.W $188A,X                                   ; 00B6DE 9E 8A 18 
  RTS                                             ; 00B6E1 60 

  LDX.W $18C0                                     ; 00B6E2 AE C0 18 
  LDA.B #$03                                      ; 00B6E5 A9 03 
  STA.W $1895,X                                   ; 00B6E7 9D 95 18 
  STZ.W $188A,X                                   ; 00B6EA 9E 8A 18 
  RTS                                             ; 00B6ED 60 

  LDX.W $18C0                                     ; 00B6EE AE C0 18 
  LDA.B #$05                                      ; 00B6F1 A9 05 
  STA.W $1895,X                                   ; 00B6F3 9D 95 18 
  LDA.B #$40                                      ; 00B6F6 A9 40 
  STA.W $188A,X                                   ; 00B6F8 9D 8A 18 
  RTS                                             ; 00B6FB 60 


L_B6FC:
  LDY.B #$00                                      ; 00B6FC A0 00 
  LDA.W $05D1                                     ; 00B6FE AD D1 05 
  BEQ.B B_B70A                                    ; 00B701 F0 07 
  TXA                                             ; 00B703 8A 
  CMP.W $05D0                                     ; 00B704 CD D0 05 
  BNE.B B_B70A                                    ; 00B707 D0 01 
  INY                                             ; 00B709 C8 
B_B70A:
  SEC                                             ; 00B70A 38 
  LDA.B #$EE                                      ; 00B70B A9 EE 
  SBC.W D_B7D7,Y                                  ; 00B70D F9 D7 B7 
  STA.W $1890                                     ; 00B710 8D 90 18 
  CLC                                             ; 00B713 18 
  LDA.B #$12                                      ; 00B714 A9 12 
  ADC.W D_B7D9,Y                                  ; 00B716 79 D9 B7 
  STA.W $188F                                     ; 00B719 8D 8F 18 
  CLC                                             ; 00B71C 18 
  LDA.B #$20                                      ; 00B71D A9 20 
  ADC.W D_B7DB,Y                                  ; 00B71F 79 DB B7 
  STA.W $1891                                     ; 00B722 8D 91 18 
  SEC                                             ; 00B725 38 
  LDA.B #$DC                                      ; 00B726 A9 DC 
  SBC.W D_B7DD,Y                                  ; 00B728 F9 DD B7 
  STA.W $1892                                     ; 00B72B 8D 92 18 
  LDY.W $188E                                     ; 00B72E AC 8E 18 
  BEQ.B B_B76C                                    ; 00B731 F0 39 

.byte $88,$B9,$DF,$B7,$DD,$46,$0B,$90             ; 00B733 ........ ?????F??
.byte $08,$B9,$EE,$B7,$8D,$92,$18,$80             ; 00B73B ........ ????????
.byte $28,$BD,$46,$0B,$D9,$E5,$B7,$90             ; 00B743 ........ (?F?????
.byte $08,$B9,$EE,$B7,$8D,$92,$18,$80             ; 00B74B ........ ????????
.byte $18,$BD,$9C,$0C,$D9,$EB,$B7,$90             ; 00B753 ........ ????????
.byte $10,$B9,$E2,$B7,$F0,$03,$8D,$8F             ; 00B75B ........ ????????
.byte $18,$B9,$E8,$B7,$F0,$03,$8D,$90             ; 00B763 ........ ????????
.byte $18                                         ; 00B76C .        ?

B_B76C:
  LDA.W $1890                                     ; 00B76C AD 90 18 
  CMP.W $18BD                                     ; 00B76F CD BD 18 
  BCS.B B_B777                                    ; 00B772 B0 03 
  STA.W $18BD                                     ; 00B774 8D BD 18 
B_B777:
  LDA.W $188F                                     ; 00B777 AD 8F 18 
  CMP.W $18BD                                     ; 00B77A CD BD 18 
  BCC.B B_B782                                    ; 00B77D 90 03 
  STA.W $18BD                                     ; 00B77F 8D BD 18 
B_B782:
  LDA.W $1891                                     ; 00B782 AD 91 18 
  CMP.W $18BF                                     ; 00B785 CD BF 18 
  BCC.B B_B78D                                    ; 00B788 90 03 
  STA.W $18BF                                     ; 00B78A 8D BF 18 
B_B78D:
  LDA.W $1892                                     ; 00B78D AD 92 18 
  CMP.W $18BF                                     ; 00B790 CD BF 18 
  BCS.B B_B798                                    ; 00B793 B0 03 
  STA.W $18BF                                     ; 00B795 8D BF 18 
B_B798:
  SEC                                             ; 00B798 38 
  LDA.W $18BC                                     ; 00B799 AD BC 18 
  SBC.W EntityXSubPx,X                                   ; 00B79C FD D4 0A 
  STA.W $18B4,X                                   ; 00B79F 9D B4 18 
  LDA.W $18BD                                     ; 00B7A2 AD BD 18 
  SBC.W XexzyCharX,X                              ; 00B7A5 FD 46 0B 
  STA.W $18B6,X                                   ; 00B7A8 9D B6 18 
  SEC                                             ; 00B7AB 38 
  LDA.W $18BE                                     ; 00B7AC AD BE 18 
  SBC.W EntityYSubPx,X                                   ; 00B7AF FD 2A 0C 
  STA.W $18B8,X                                   ; 00B7B2 9D B8 18 
  LDA.W $18BF                                     ; 00B7B5 AD BF 18 
  SBC.W EntityYPx,X                                   ; 00B7B8 FD 9C 0C 
  STA.W $18BA,X                                   ; 00B7BB 9D BA 18 
  LDA.W $18BC                                     ; 00B7BE AD BC 18 
  STA.W EntityXSubPx,X                                   ; 00B7C1 9D D4 0A 
  LDA.W $18BD                                     ; 00B7C4 AD BD 18 
  STA.W XexzyCharX,X                              ; 00B7C7 9D 46 0B 
  LDA.W $18BE                                     ; 00B7CA AD BE 18 
  STA.W EntityYSubPx,X                                   ; 00B7CD 9D 2A 0C 
  LDA.W $18BF                                     ; 00B7D0 AD BF 18 
  STA.W EntityYPx,X                                   ; 00B7D3 9D 9C 0C 
  RTS                                             ; 00B7D6 60 


D_B7D7:
.byte $0C,$20                                     ; 00B7D8 DD       ? 
D_B7D9:
.byte $0C,$20                                     ; 00B7DA DD       ? 
D_B7DB:
.byte $11,$20                                     ; 00B7DC DD       ? 
D_B7DD:
.byte $FE,$20,$00,$62,$62,$00,$66,$66             ; 00B7DD DD...... ? ?bb?ff
.byte $A5,$9E,$FF,$9F,$9A,$00,$97,$95             ; 00B7E5 ........ ????????
.byte $95,$92,$92,$92                             ; 00B7EE ....     ????


L_B7F1:
  STA.B $08                                       ; 00B7F1 85 08 
  STX.B $09                                       ; 00B7F3 86 09 
  LDA.W $18AF                                     ; 00B7F5 AD AF 18 
  BNE.B B_B83F                                    ; 00B7F8 D0 45 
  LDA.W $18B2,X                                   ; 00B7FA BD B2 18 
  BNE.B B_B83F                                    ; 00B7FD D0 40 
  LDA.W $18B0,X                                   ; 00B7FF BD B0 18 
  STA.W $18B2,X                                   ; 00B802 9D B2 18 
  LDA.W XexzyCharX,X                              ; 00B805 BD 46 0B 
  STA.B $0A                                       ; 00B808 85 0A 
  LDA.W EntityYPx,X                                   ; 00B80A BD 9C 0C 
  STA.B $0B                                       ; 00B80D 85 0B 
  LDA.B #$01                                      ; 00B80F A9 01 
  STA.B $0C                                       ; 00B811 85 0C 
  LDA.W $1897,X                                   ; 00B813 BD 97 18 
  ASL                                             ; 00B816 0A 
  TAX                                             ; 00B817 AA 
  PHX                                             ; 00B818 DA 
  JSR.W (L_B840,X)                                ; 00B819 FC 40 B8 
  PLX                                             ; 00B81C FA 
  LDA.W $05CE                                     ; 00B81D AD CE 05 
  CMP.B $09                                       ; 00B820 C5 09 
  BNE.B B_B83F                                    ; 00B822 D0 1B 
  LDY.B $09                                       ; 00B824 A4 09 
  LDA.W $1897,Y                                   ; 00B826 B9 97 18 
  CMP.B #$04                                      ; 00B829 C9 04 
  BEQ.B B_B83F                                    ; 00B82B F0 12 
  LDY.W $05CF                                     ; 00B82D AC CF 05 
  LDA.W XexzyCharX,Y                              ; 00B830 B9 46 0B 
  STA.B $0A                                       ; 00B833 85 0A 
  LDA.W EntityYPx,Y                                   ; 00B835 B9 9C 0C 
  STA.B $0B                                       ; 00B838 85 0B 
  STZ.B $0C                                       ; 00B83A 64 0C 
  JSR.W (L_B840,X)                                ; 00B83C FC 40 B8 
B_B83F:
  RTS                                             ; 00B83F 60 


L_B840:
.byte $4A,$B8,$6F,$B9,$BB,$BA,$E3,$BB             ; 00B840 DDDDDDDD J?o?????
.byte $7A,$BD                                     ; 00B849 DD       z?

  JSL L_380E4                                     ; 00B84A 22 E4 80 03 
  BEQ.B B_B853                                    ; 00B84E F0 03 

.byte $4C,$26,$B9                                 ; 00B851 ...      L&?

B_B853:
  JSL L_38094                                     ; 00B853 22 94 80 03 
  LDA.B $09                                       ; 00B857 A5 09 
  STA.W EntityV20,X                                   ; 00B859 9D BA 0F 
  LDA.B #$32                                      ; 00B85C A9 32 
  STA.W EntityV1,X                                   ; 00B85E 9D 44 07 
  LDA.B #$02                                      ; 00B861 A9 02 
  STA.W EntityV3,X                                   ; 00B863 9D 28 08 
  LDA.B $08                                       ; 00B866 A5 08 
  STA.W EntityV21,X                                   ; 00B868 9D 2C 10 
  AND.B #$07                                      ; 00B86B 29 07 
  TAY                                             ; 00B86D A8 
  LDA.B $0C                                       ; 00B86E A5 0C 
  BEQ.B B_B887                                    ; 00B870 F0 15 
  CLC                                             ; 00B872 18 
  LDA.B $0A                                       ; 00B873 A5 0A 
  ADC.W D_B93F,Y                                  ; 00B875 79 3F B9 
  STA.W XexzyCharX,X                              ; 00B878 9D 46 0B 
  CLC                                             ; 00B87B 18 
  LDA.B $0B                                       ; 00B87C A5 0B 
  ADC.W D_B947,Y                                  ; 00B87E 79 47 B9 
  STA.W EntityYPx,X                                   ; 00B881 9D 9C 0C 
  JMP.W D_B891                                    ; 00B884 4C 91 B8 
B_B887:
  LDA.B $0A                                       ; 00B887 A5 0A 
  STA.W XexzyCharX,X                              ; 00B889 9D 46 0B 
  LDA.B $0B                                       ; 00B88C A5 0B 
  STA.W EntityYPx,X                                   ; 00B88E 9D 9C 0C 
D_B891:
  SEC                                             ; 00B891 38 
  LDA.W XexzyCharX,X                              ; 00B892 BD 46 0B 
  SBC.B #$01                                      ; 00B895 E9 01 
  BCS.B B_B89B                                    ; 00B897 B0 02 

.byte $A9,$00                                     ; 00B89A ..       ??

B_B89B:
  STA.W EntityV32,X                                   ; 00B89B 9D 16 15 
  CLC                                             ; 00B89E 18 
  LDA.W XexzyCharX,X                              ; 00B89F BD 46 0B 
  ADC.B #$01                                      ; 00B8A2 69 01 
  BCC.B B_B8A8                                    ; 00B8A4 90 02 

.byte $A9,$FF                                     ; 00B8A7 ..       ??

B_B8A8:
  STA.W EntityV33,X                                   ; 00B8A8 9D 88 15 
  SEC                                             ; 00B8AB 38 
  LDA.W EntityYPx,X                                   ; 00B8AC BD 9C 0C 
  SBC.B #$01                                      ; 00B8AF E9 01 
  BCS.B B_B8B5                                    ; 00B8B1 B0 02 

.byte $A9,$00                                     ; 00B8B4 ..       ??

B_B8B5:
  STA.W EntityV34,X                                   ; 00B8B5 9D FA 15 
  CLC                                             ; 00B8B8 18 
  LDA.W EntityYPx,X                                   ; 00B8B9 BD 9C 0C 
  ADC.B #$01                                      ; 00B8BC 69 01 
  BCC.B B_B8C2                                    ; 00B8BE 90 02 

.byte $A9,$FF                                     ; 00B8C1 ..       ??

B_B8C2:
  STA.W EntityV35,X                                   ; 00B8C2 9D 6C 16 
  LDA.B $08                                       ; 00B8C5 A5 08 
  AND.B #$07                                      ; 00B8C7 29 07 
  ASL                                             ; 00B8C9 0A 
  TAY                                             ; 00B8CA A8 
  LDA.W D_B94F,Y                                  ; 00B8CB B9 4F B9 
  STA.W EntityV5,X                                   ; 00B8CE 9D 0C 09 
  LDA.W D_B950,Y                                  ; 00B8D1 B9 50 B9 
  STA.W EntityV6,X                                   ; 00B8D4 9D 7E 09 
  LDA.W D_B95F,Y                                  ; 00B8D7 B9 5F B9 
  STA.W EntityV7,X                                   ; 00B8DA 9D F0 09 
  LDA.W D_B960,Y                                  ; 00B8DD B9 60 B9 
  STA.W EntityV8,X                                   ; 00B8E0 9D 62 0A 
  LDA.B #$01                                      ; 00B8E3 A9 01 
  STA.W EntityHeader,X                                   ; 00B8E5 9D D2 06 
  LDA.B $08                                       ; 00B8E8 A5 08 
  AND.B #$07                                      ; 00B8EA 29 07 
  TAY                                             ; 00B8EC A8 
  LDA.W D_B92F,Y                                  ; 00B8ED B9 2F B9 
  STA.W EntityV29,X                                   ; 00B8F0 9D BC 13 
  LDA.B #$32                                      ; 00B8F3 A9 32 
  ORA.W D_B937,Y                                  ; 00B8F5 19 37 B9 
  STA.W EntityV30,X                                   ; 00B8F8 9D 2E 14 
  JSL L_AECB                                      ; 00B8FB 22 CB AE 00 
  TYA                                             ; 00B8FF 98 
  STA.W EntityV31,X                                   ; 00B900 9D A0 14 
  LDA.B #$01                                      ; 00B903 A9 01 
  STA.W $175E,Y                                   ; 00B905 99 5E 17 
  JSL L_AEF1                                      ; 00B908 22 F1 AE 00 
  PHX                                             ; 00B90C DA 
  REP.B #$10                                      ; 00B90D C2 10 
  LDA.B #$07                                      ; 00B90F A9 07 
  LDX.W #$FF01                                    ; 00B911 A2 01 FF 
  JSL Audio_F830F                                     ; 00B914 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00B918 E2 30 
  PLX                                             ; 00B91A FA 
  LDX.B $09                                       ; 00B91B A6 09 
  LDY.B $08                                       ; 00B91D A4 08 
  LDA.W D_B927,Y                                  ; 00B91F B9 27 B9 
  JSL L_E593                                      ; 00B922 22 93 E5 00 
  RTS                                             ; 00B926 60 


D_B927:
.byte $0A,$0B,$0C,$0D,$0E,$0F,$10,$11             ; 00B927 DDDDDDDD ????????
D_B92F:
.byte $00,$02,$04,$02,$00,$02,$04,$02             ; 00B92F DDDDDDDD ????????
D_B937:
.byte $80,$80,$00,$00,$00,$40,$40,$C0             ; 00B937 DDDDDDDD ?????@@?
D_B93F:
.byte $01,$04,$0B,$04,$00,$FC,$F6,$FC             ; 00B93F DDDDDDDD ????????
D_B947:
.byte $FA,$F8,$F2,$EE,$EE,$EE,$F2,$F8             ; 00B947 DDDDDDDD ????????
D_B94F:
.byte $00                                         ; 00B950 D        ?
D_B950:
.byte $00,$89,$03,$00,$05,$89,$03,$00             ; 00B950 DDDDDDDD ????????
.byte $00,$77,$FC,$00,$FB,$77,$FC                 ; 00B959 DDDDDDD  ?w???w?
D_B95F:
.byte $00                                         ; 00B960 D        ?
D_B960:
.byte $05,$89,$03,$00,$00,$77,$FC,$00             ; 00B960 DDDDDDDD ?????w??
.byte $FB,$77,$FC,$00,$00,$89,$03                 ; 00B969 DDDDDDD  ?w?????

  LDA.B $08                                       ; 00B96F A5 08 
  ASL                                             ; 00B971 0A 
  STA.B $04                                       ; 00B972 85 04 
  JSR.W L_B9AB                                    ; 00B974 20 AB B9 
  LDA.B $04                                       ; 00B977 A5 04 
  DEC A
  AND.B #$0F                                      ; 00B97A 29 0F 
  STA.B $04                                       ; 00B97C 85 04 
  JSR.W L_B9AB                                    ; 00B97E 20 AB B9 
  CLC                                             ; 00B981 18 
  LDA.B $04                                       ; 00B982 A5 04 
  ADC.B #$02                                      ; 00B984 69 02 
  AND.B #$0F                                      ; 00B986 29 0F 
  STA.B $04                                       ; 00B988 85 04 
  JSR.W L_B9AB                                    ; 00B98A 20 AB B9 
  PHX                                             ; 00B98D DA 
  REP.B #$10                                      ; 00B98E C2 10 
  LDA.B #$07                                      ; 00B990 A9 07 
  LDX.W #$FF02                                    ; 00B992 A2 02 FF 
  JSL Audio_F830F                                     ; 00B995 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00B999 E2 30 
  PLX                                             ; 00B99B FA 
  JSR.W L_BEE9                                    ; 00B99C 20 E9 BE 
  LDX.B $09                                       ; 00B99F A6 09 
  LDY.B $08                                       ; 00B9A1 A4 08 
  LDA.W D_BA63,Y                                  ; 00B9A3 B9 63 BA 
  JSL L_E593                                      ; 00B9A6 22 93 E5 00 
  RTS                                             ; 00B9AA 60 


L_B9AB:
  JSL L_380E4                                     ; 00B9AB 22 E4 80 03 
  BEQ.B B_B9B4                                    ; 00B9AF F0 03 

.byte $4C,$62,$BA                                 ; 00B9B2 ...      Lb?

B_B9B4:
  JSL L_38094                                     ; 00B9B4 22 94 80 03 
  LDA.B $09                                       ; 00B9B8 A5 09 
  STA.W EntityV20,X                                   ; 00B9BA 9D BA 0F 
  LDA.B #$33                                      ; 00B9BD A9 33 
  STA.W EntityV1,X                                   ; 00B9BF 9D 44 07 
  LDA.B #$02                                      ; 00B9C2 A9 02 
  STA.W EntityV3,X                                   ; 00B9C4 9D 28 08 
  LDA.B $08                                       ; 00B9C7 A5 08 
  STA.W EntityV21,X                                   ; 00B9C9 9D 2C 10 
  AND.B #$07                                      ; 00B9CC 29 07 
  TAY                                             ; 00B9CE A8 
  LDA.B $0C                                       ; 00B9CF A5 0C 
  BEQ.B B_B9E8                                    ; 00B9D1 F0 15 
  CLC                                             ; 00B9D3 18 
  LDA.B $0A                                       ; 00B9D4 A5 0A 
  ADC.W D_BA6B,Y                                  ; 00B9D6 79 6B BA 
  STA.W XexzyCharX,X                              ; 00B9D9 9D 46 0B 
  CLC                                             ; 00B9DC 18 
  LDA.B $0B                                       ; 00B9DD A5 0B 
  ADC.W D_BA73,Y                                  ; 00B9DF 79 73 BA 
  STA.W EntityYPx,X                                   ; 00B9E2 9D 9C 0C 
  JMP.W D_B9F2                                    ; 00B9E5 4C F2 B9 
B_B9E8:
  LDA.B $0A                                       ; 00B9E8 A5 0A 
  STA.W XexzyCharX,X                              ; 00B9EA 9D 46 0B 
  LDA.B $0B                                       ; 00B9ED A5 0B 
  STA.W EntityYPx,X                                   ; 00B9EF 9D 9C 0C 
D_B9F2:
  SEC                                             ; 00B9F2 38 
  LDA.W XexzyCharX,X                              ; 00B9F3 BD 46 0B 
  SBC.B #$01                                      ; 00B9F6 E9 01 
  BCS.B B_B9FC                                    ; 00B9F8 B0 02 

.byte $A9,$00                                     ; 00B9FB ..       ??

B_B9FC:
  STA.W EntityV32,X                                   ; 00B9FC 9D 16 15 
  CLC                                             ; 00B9FF 18 
  LDA.W XexzyCharX,X                              ; 00BA00 BD 46 0B 
  ADC.B #$01                                      ; 00BA03 69 01 
  BCC.B B_BA09                                    ; 00BA05 90 02 

.byte $A9,$FF                                     ; 00BA08 ..       ??

B_BA09:
  STA.W EntityV33,X                                   ; 00BA09 9D 88 15 
  SEC                                             ; 00BA0C 38 
  LDA.W EntityYPx,X                                   ; 00BA0D BD 9C 0C 
  SBC.B #$01                                      ; 00BA10 E9 01 
  BCS.B B_BA16                                    ; 00BA12 B0 02 

.byte $A9,$00                                     ; 00BA15 ..       ??

B_BA16:
  STA.W EntityV34,X                                   ; 00BA16 9D FA 15 
  CLC                                             ; 00BA19 18 
  LDA.W EntityYPx,X                                   ; 00BA1A BD 9C 0C 
  ADC.B #$01                                      ; 00BA1D 69 01 
  BCC.B B_BA23                                    ; 00BA1F 90 02 

.byte $A9,$FF                                     ; 00BA22 ..       ??

B_BA23:
  STA.W EntityV35,X                                   ; 00BA23 9D 6C 16 
  LDA.B $04                                       ; 00BA26 A5 04 
  ASL                                             ; 00BA28 0A 
  TAY                                             ; 00BA29 A8 
  LDA.W D_BA7B,Y                                  ; 00BA2A B9 7B BA 
  STA.W EntityV5,X                                   ; 00BA2D 9D 0C 09 
  LDA.W D_BA7C,Y                                  ; 00BA30 B9 7C BA 
  STA.W EntityV6,X                                   ; 00BA33 9D 7E 09 
  LDA.W D_BA9B,Y                                  ; 00BA36 B9 9B BA 
  STA.W EntityV7,X                                   ; 00BA39 9D F0 09 
  LDA.W D_BA9C,Y                                  ; 00BA3C B9 9C BA 
  STA.W EntityV8,X                                   ; 00BA3F 9D 62 0A 
  LDA.B #$01                                      ; 00BA42 A9 01 
  STA.W EntityHeader,X                                   ; 00BA44 9D D2 06 
  LDA.B #$06                                      ; 00BA47 A9 06 
  STA.W EntityV29,X                                   ; 00BA49 9D BC 13 
  LDA.B #$32                                      ; 00BA4C A9 32 
  STA.W EntityV30,X                                   ; 00BA4E 9D 2E 14 
  JSL L_AECB                                      ; 00BA51 22 CB AE 00 
  TYA                                             ; 00BA55 98 
  STA.W EntityV31,X                                   ; 00BA56 9D A0 14 
  LDA.B #$01                                      ; 00BA59 A9 01 
  STA.W $175E,Y                                   ; 00BA5B 99 5E 17 
  JSL L_AEF1                                      ; 00BA5E 22 F1 AE 00 
  RTS                                             ; 00BA62 60 


D_BA63:
.byte $12,$13,$14,$15,$16,$17,$18,$19             ; 00BA63 DDDDDDDD ????????
D_BA6B:
.byte $FE,$0C,$0E,$06,$04,$FB,$F3,$F5             ; 00BA6B DDDDDDDD ????????
D_BA73:
.byte $02,$FA,$F3,$EE,$EE,$EE,$F3,$FA             ; 00BA73 DDDDDDDD ????????
D_BA7B:
.byte $00                                         ; 00BA7C D        ?
D_BA7C:
.byte $00,$E9,$01,$89,$03,$9E,$04,$00             ; 00BA7C DDDDDDDD ????????
.byte $05,$9E,$04,$89,$03,$E9,$01,$00             ; 00BA84 DDDDDDDD ????????
.byte $00,$17,$FE,$77,$FC,$62,$FB,$00             ; 00BA8C DDDDDDDD ???w?b??
.byte $FB,$62,$FB,$77,$FC,$17,$FE                 ; 00BA95 DDDDDDD  ?b?w???
D_BA9B:
.byte $00                                         ; 00BA9C D        ?
D_BA9C:
.byte $05,$9E,$04,$89,$03,$E9,$01,$00             ; 00BA9C DDDDDDDD ????????
.byte $00,$17,$FE,$77,$FC,$62,$FB,$00             ; 00BAA4 DDDDDDDD ???w?b??
.byte $FB,$62,$FB,$77,$FC,$17,$FE,$00             ; 00BAAC DDDDDDDD ?b?w????
.byte $00,$E9,$01,$89,$03,$9E,$04                 ; 00BAB5 DDDDDDD  ???????

  JSL L_380E4                                     ; 00BABB 22 E4 80 03 
  BEQ.B B_BAC4                                    ; 00BABF F0 03 

.byte $4C,$9A,$BB                                 ; 00BAC2 ...      L??

B_BAC4:
  JSL L_38094                                     ; 00BAC4 22 94 80 03 
  LDA.B $09                                       ; 00BAC8 A5 09 
  STA.W EntityV20,X                                   ; 00BACA 9D BA 0F 
  LDA.B #$34                                      ; 00BACD A9 34 
  STA.W EntityV1,X                                   ; 00BACF 9D 44 07 
  LDA.B #$02                                      ; 00BAD2 A9 02 
  STA.W EntityV3,X                                   ; 00BAD4 9D 28 08 
  LDA.B $08                                       ; 00BAD7 A5 08 
  STA.W EntityV21,X                                   ; 00BAD9 9D 2C 10 
  AND.B #$07                                      ; 00BADC 29 07 
  TAY                                             ; 00BADE A8 
  LDA.B $0C                                       ; 00BADF A5 0C 
  BEQ.B B_BAF8                                    ; 00BAE1 F0 15 
  CLC                                             ; 00BAE3 18 
  LDA.B $0A                                       ; 00BAE4 A5 0A 
  ADC.W D_BBB3,Y                                  ; 00BAE6 79 B3 BB 
  STA.W XexzyCharX,X                              ; 00BAE9 9D 46 0B 
  CLC                                             ; 00BAEC 18 
  LDA.B $0B                                       ; 00BAED A5 0B 
  ADC.W D_BBBB,Y                                  ; 00BAEF 79 BB BB 
  STA.W EntityYPx,X                                   ; 00BAF2 9D 9C 0C 
  JMP.W D_BB02                                    ; 00BAF5 4C 02 BB 
B_BAF8:
  LDA.B $0A                                       ; 00BAF8 A5 0A 
  STA.W XexzyCharX,X                              ; 00BAFA 9D 46 0B 
  LDA.B $0B                                       ; 00BAFD A5 0B 
  STA.W EntityYPx,X                                   ; 00BAFF 9D 9C 0C 
D_BB02:
  SEC                                             ; 00BB02 38 
  LDA.W XexzyCharX,X                              ; 00BB03 BD 46 0B 
  SBC.B #$01                                      ; 00BB06 E9 01 
  BCS.B B_BB0C                                    ; 00BB08 B0 02 

.byte $A9,$00                                     ; 00BB0B ..       ??

B_BB0C:
  STA.W EntityV32,X                                   ; 00BB0C 9D 16 15 
  CLC                                             ; 00BB0F 18 
  LDA.W XexzyCharX,X                              ; 00BB10 BD 46 0B 
  ADC.B #$01                                      ; 00BB13 69 01 
  BCC.B B_BB19                                    ; 00BB15 90 02 

.byte $A9,$FF                                     ; 00BB18 ..       ??

B_BB19:
  STA.W EntityV33,X                                   ; 00BB19 9D 88 15 
  SEC                                             ; 00BB1C 38 
  LDA.W EntityYPx,X                                   ; 00BB1D BD 9C 0C 
  SBC.B #$01                                      ; 00BB20 E9 01 
  BCS.B B_BB26                                    ; 00BB22 B0 02 

.byte $A9,$00                                     ; 00BB25 ..       ??

B_BB26:
  STA.W EntityV34,X                                   ; 00BB26 9D FA 15 
  CLC                                             ; 00BB29 18 
  LDA.W EntityYPx,X                                   ; 00BB2A BD 9C 0C 
  ADC.B #$01                                      ; 00BB2D 69 01 
  BCC.B B_BB33                                    ; 00BB2F 90 02 

.byte $A9,$FF                                     ; 00BB32 ..       ??

B_BB33:
  STA.W EntityV35,X                                   ; 00BB33 9D 6C 16 
  LDA.B $08                                       ; 00BB36 A5 08 
  AND.B #$07                                      ; 00BB38 29 07 
  ASL                                             ; 00BB3A 0A 
  TAY                                             ; 00BB3B A8 
  LDA.W D_BBC3,Y                                  ; 00BB3C B9 C3 BB 
  STA.W EntityV5,X                                   ; 00BB3F 9D 0C 09 
  LDA.W D_BBC4,Y                                  ; 00BB42 B9 C4 BB 
  STA.W EntityV6,X                                   ; 00BB45 9D 7E 09 
  LDA.W D_BBD3,Y                                  ; 00BB48 B9 D3 BB 
  STA.W EntityV7,X                                   ; 00BB4B 9D F0 09 
  LDA.W D_BBD4,Y                                  ; 00BB4E B9 D4 BB 
  STA.W EntityV8,X                                   ; 00BB51 9D 62 0A 
  LDA.B #$01                                      ; 00BB54 A9 01 
  STA.W EntityHeader,X                                   ; 00BB56 9D D2 06 
  LDA.B $08                                       ; 00BB59 A5 08 
  AND.B #$07                                      ; 00BB5B 29 07 
  TAY                                             ; 00BB5D A8 
  LDA.W D_BBA3,Y                                  ; 00BB5E B9 A3 BB 
  STA.W EntityV29,X                                   ; 00BB61 9D BC 13 
  LDA.B #$34                                      ; 00BB64 A9 34 
  ORA.W D_BBAB,Y                                  ; 00BB66 19 AB BB 
  STA.W EntityV30,X                                   ; 00BB69 9D 2E 14 
  JSL L_AECB                                      ; 00BB6C 22 CB AE 00 
  TYA                                             ; 00BB70 98 
  STA.W EntityV31,X                                   ; 00BB71 9D A0 14 
  LDA.B #$01                                      ; 00BB74 A9 01 
  STA.W $175E,Y                                   ; 00BB76 99 5E 17 
  JSL L_AEF1                                      ; 00BB79 22 F1 AE 00 
  PHX                                             ; 00BB7D DA 
  REP.B #$10                                      ; 00BB7E C2 10 
  LDA.B #$07                                      ; 00BB80 A9 07 
  LDX.W #$FF03                                    ; 00BB82 A2 03 FF 
  JSL Audio_F830F                                     ; 00BB85 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00BB89 E2 30 
  PLX                                             ; 00BB8B FA 
  JSR.W L_BEE9                                    ; 00BB8C 20 E9 BE 
  LDX.B $09                                       ; 00BB8F A6 09 
  LDY.B $08                                       ; 00BB91 A4 08 
  LDA.W D_BB9B,Y                                  ; 00BB93 B9 9B BB 
  JSL L_E593                                      ; 00BB96 22 93 E5 00 
  RTS                                             ; 00BB9A 60 


D_BB9B:
.byte $1A,$1B,$1C,$1D,$1E,$1F,$20,$21             ; 00BB9B DDDDDDDD ?????? !
D_BBA3:
.byte $08,$0A,$0C,$0A,$08,$0A,$0C,$0A             ; 00BBA3 DDDDDDDD ????????
D_BBAB:
.byte $80,$80,$00,$00,$00,$40,$40,$C0             ; 00BBAB DDDDDDDD ?????@@?
D_BBB3:
.byte $FC,$07,$0B,$01,$04,$FF,$F5,$FA             ; 00BBB3 DDDDDDDD ????????
D_BBBB:
.byte $FA,$F5,$F0,$EC,$EC,$EC,$F0,$F5             ; 00BBBB DDDDDDDD ????????
D_BBC3:
.byte $00                                         ; 00BBC4 D        ?
D_BBC4:
.byte $00,$79,$02,$80,$03,$79,$02,$00             ; 00BBC4 DDDDDDDD ?y???y??
.byte $00,$87,$FD,$80,$FC,$87,$FD                 ; 00BBCD DDDDDDD  ???????
D_BBD3:
.byte $80                                         ; 00BBD4 D        ?
D_BBD4:
.byte $03,$79,$02,$00,$00,$87,$FD,$80             ; 00BBD4 DDDDDDDD ?y??????
.byte $FC,$87,$FD,$00,$00,$79,$02                 ; 00BBDD DDDDDDD  ?????y?

  JSL L_380E4                                     ; 00BBE3 22 E4 80 03 
  BEQ.B B_BBEC                                    ; 00BBE7 F0 03 

.byte $4C,$D1,$BC                                 ; 00BBEA ...      L??

B_BBEC:
  JSL L_38094                                     ; 00BBEC 22 94 80 03 
  LDA.B $09                                       ; 00BBF0 A5 09 
  STA.W EntityV20,X                                   ; 00BBF2 9D BA 0F 
  LDA.B #$35                                      ; 00BBF5 A9 35 
  STA.W EntityV1,X                                   ; 00BBF7 9D 44 07 
  LDA.B #$02                                      ; 00BBFA A9 02 
  STA.W EntityV3,X                                   ; 00BBFC 9D 28 08 
  LDA.B $08                                       ; 00BBFF A5 08 
  STA.W EntityV21,X                                   ; 00BC01 9D 2C 10 
  AND.B #$07                                      ; 00BC04 29 07 
  TAY                                             ; 00BC06 A8 
  LDA.B $0C                                       ; 00BC07 A5 0C 
  BEQ.B B_BC20                                    ; 00BC09 F0 15 
  CLC                                             ; 00BC0B 18 
  LDA.B $0A                                       ; 00BC0C A5 0A 
  ADC.W D_BCEA,Y                                  ; 00BC0E 79 EA BC 
  STA.W XexzyCharX,X                              ; 00BC11 9D 46 0B 
  CLC                                             ; 00BC14 18 
  LDA.B $0B                                       ; 00BC15 A5 0B 
  ADC.W D_BCF2,Y                                  ; 00BC17 79 F2 BC 
  STA.W EntityYPx,X                                   ; 00BC1A 9D 9C 0C 
  JMP.W D_BC2A                                    ; 00BC1D 4C 2A BC 
B_BC20:
  LDA.B $0A                                       ; 00BC20 A5 0A 
  STA.W XexzyCharX,X                              ; 00BC22 9D 46 0B 
  LDA.B $0B                                       ; 00BC25 A5 0B 
  STA.W EntityYPx,X                                   ; 00BC27 9D 9C 0C 
D_BC2A:
  SEC                                             ; 00BC2A 38 
  LDA.W XexzyCharX,X                              ; 00BC2B BD 46 0B 
  SBC.B #$01                                      ; 00BC2E E9 01 
  BCS.B B_BC34                                    ; 00BC30 B0 02 

.byte $A9,$00                                     ; 00BC33 ..       ??

B_BC34:
  STA.W EntityV32,X                                   ; 00BC34 9D 16 15 
  CLC                                             ; 00BC37 18 
  LDA.W XexzyCharX,X                              ; 00BC38 BD 46 0B 
  ADC.B #$01                                      ; 00BC3B 69 01 
  BCC.B B_BC41                                    ; 00BC3D 90 02 

.byte $A9,$FF                                     ; 00BC40 ..       ??

B_BC41:
  STA.W EntityV33,X                                   ; 00BC41 9D 88 15 
  SEC                                             ; 00BC44 38 
  LDA.W EntityYPx,X                                   ; 00BC45 BD 9C 0C 
  SBC.B #$01                                      ; 00BC48 E9 01 
  BCS.B B_BC4E                                    ; 00BC4A B0 02 

.byte $A9,$00                                     ; 00BC4D ..       ??

B_BC4E:
  STA.W EntityV34,X                                   ; 00BC4E 9D FA 15 
  CLC                                             ; 00BC51 18 
  LDA.W EntityYPx,X                                   ; 00BC52 BD 9C 0C 
  ADC.B #$01                                      ; 00BC55 69 01 
  BCC.B B_BC5B                                    ; 00BC57 90 02 

.byte $A9,$FF                                     ; 00BC5A ..       ??

B_BC5B:
  STA.W EntityV35,X                                   ; 00BC5B 9D 6C 16 
  JSL AdvanceRNG                                     ; 00BC5E 22 95 CA 0E 
  AND.B #$0F                                      ; 00BC62 29 0F 
  TAY                                             ; 00BC64 A8 
  LDA.B $08                                       ; 00BC65 A5 08 
  ASL                                             ; 00BC67 0A 
  ASL                                             ; 00BC68 0A 
  CLC                                             ; 00BC69 18 
  ADC.W D_BCDA,Y                                  ; 00BC6A 79 DA BC 
  AND.B #$1F                                      ; 00BC6D 29 1F 
  ASL                                             ; 00BC6F 0A 
  TAY                                             ; 00BC70 A8 
  LDA.W D_BCFA,Y                                  ; 00BC71 B9 FA BC 
  STA.W EntityV5,X                                   ; 00BC74 9D 0C 09 
  LDA.W D_BCFB,Y                                  ; 00BC77 B9 FB BC 
  STA.W EntityV6,X                                   ; 00BC7A 9D 7E 09 
  LDA.W D_BD3A,Y                                  ; 00BC7D B9 3A BD 
  STA.W EntityV7,X                                   ; 00BC80 9D F0 09 
  LDA.W D_BD3B,Y                                  ; 00BC83 B9 3B BD 
  STA.W EntityV8,X                                   ; 00BC86 9D 62 0A 
  LDA.B #$01                                      ; 00BC89 A9 01 
  STA.W EntityHeader,X                                   ; 00BC8B 9D D2 06 
  LDA.B #$0E                                      ; 00BC8E A9 0E 
  STA.W EntityV29,X                                   ; 00BC90 9D BC 13 
  LDA.W $18D1                                     ; 00BC93 AD D1 18 
  ASL                                             ; 00BC96 0A 
  ORA.B #$38                                      ; 00BC97 09 38 
  STA.W EntityV30,X                                   ; 00BC99 9D 2E 14 
  JSL AdvanceRNG                                     ; 00BC9C 22 95 CA 0E 
  AND.B #$0F                                      ; 00BCA0 29 0F 
  STA.B $04                                       ; 00BCA2 85 04 
  JSL AdvanceRNG                                     ; 00BCA4 22 95 CA 0E 
  AND.B #$0F                                      ; 00BCA8 29 0F 
  CLC                                             ; 00BCAA 18 
  ADC.B $04                                       ; 00BCAB 65 04 
  ADC.B #$06                                      ; 00BCAD 69 06 
  STA.W EntityV15,X                                   ; 00BCAF 9D 80 0D 
  JSL L_AECB                                      ; 00BCB2 22 CB AE 00 
  TYA                                             ; 00BCB6 98 
  STA.W EntityV31,X                                   ; 00BCB7 9D A0 14 
  LDA.B #$01                                      ; 00BCBA A9 01 
  STA.W $175E,Y                                   ; 00BCBC 99 5E 17 
  JSL L_AEF1                                      ; 00BCBF 22 F1 AE 00 
  JSR.W L_BEE9                                    ; 00BCC3 20 E9 BE 
  LDX.B $09                                       ; 00BCC6 A6 09 
  LDY.B $08                                       ; 00BCC8 A4 08 
  LDA.W D_BCD2,Y                                  ; 00BCCA B9 D2 BC 
  JSL L_E593                                      ; 00BCCD 22 93 E5 00 
  RTS                                             ; 00BCD1 60 


D_BCD2:
.byte $22,$23,$24,$25,$26,$27,$28,$29             ; 00BCD2 DDDDDDDD "#$%&'()
D_BCDA:
.byte $00,$01,$FF,$02,$FE,$03,$FD,$00             ; 00BCDA DDDDDDDD ????????
.byte $00,$01,$FF,$02,$FE,$03,$FD,$00             ; 00BCE2 DDDDDDDD ????????
D_BCEA:
.byte $FE,$0B,$0D,$05,$02,$FB,$F4,$F7             ; 00BCEA DDDDDDDD ????????
D_BCF2:
.byte $FC,$F7,$F2,$EF,$EC,$EF,$F2,$F7             ; 00BCF2 DDDDDDDD ????????
D_BCFA:
.byte $00                                         ; 00BCFB D        ?
D_BCFB:
.byte $00,$63,$00,$C3,$00,$1C,$01,$6A             ; 00BCFB DDDDDDDD ?c?????j
.byte $01,$A9,$01,$D9,$01,$F6,$01,$00             ; 00BD03 DDDDDDDD ????????
.byte $02,$F6,$01,$D9,$01,$A9,$01,$6A             ; 00BD0B DDDDDDDD ???????j
.byte $01,$1C,$01,$C3,$00,$63,$00,$00             ; 00BD13 DDDDDDDD ?????c??
.byte $00,$9D,$FF,$3D,$FF,$E4,$FE,$96             ; 00BD1B DDDDDDDD ???=????
.byte $FE,$57,$FE,$27,$FE,$0A,$FE,$00             ; 00BD23 DDDDDDDD ?W?'????
.byte $FE,$0A,$FE,$27,$FE,$57,$FE,$96             ; 00BD2B DDDDDDDD ???'?W??
.byte $FE,$E4,$FE,$3D,$FF,$9D,$FF                 ; 00BD34 DDDDDDD  ???=???
D_BD3A:
.byte $00                                         ; 00BD3B D        ?
D_BD3B:
.byte $02,$F6,$01,$D9,$01,$A9,$01,$6A             ; 00BD3B DDDDDDDD ???????j
.byte $01,$1C,$01,$C3,$00,$63,$00,$00             ; 00BD43 DDDDDDDD ?????c??
.byte $00,$9D,$FF,$3D,$FF,$E4,$FE,$96             ; 00BD4B DDDDDDDD ???=????
.byte $FE,$57,$FE,$27,$FE,$0A,$FE,$00             ; 00BD53 DDDDDDDD ?W?'????
.byte $FE,$0A,$FE,$27,$FE,$57,$FE,$96             ; 00BD5B DDDDDDDD ???'?W??
.byte $FE,$E4,$FE,$3D,$FF,$9D,$FF,$00             ; 00BD63 DDDDDDDD ???=????
.byte $00,$63,$00,$C3,$00,$1C,$01,$6A             ; 00BD6B DDDDDDDD ?c?????j
.byte $01,$A9,$01,$D9,$01,$F6,$01                 ; 00BD74 DDDDDDD  ???????

  JSL L_380E4                                     ; 00BD7A 22 E4 80 03 
  BEQ.B B_BD83                                    ; 00BD7E F0 03 

.byte $4C,$B0,$BE                                 ; 00BD81 ...      L??

B_BD83:
  LDA.B #$01                                      ; 00BD83 A9 01 
  STA.W EntityHeader,X                                   ; 00BD85 9D D2 06 
  STX.B $05                                       ; 00BD88 86 05 
  JSL L_380E4                                     ; 00BD8A 22 E4 80 03 
  BEQ.B B_BD98                                    ; 00BD8E F0 08 

.byte $A6,$05,$9E,$D2,$06,$4C,$B0,$BE             ; 00BD90 ........ ?????L??

B_BD98:
  STX.B $04                                       ; 00BD98 86 04 
  JSL L_38094                                     ; 00BD9A 22 94 80 03 
  LDA.B #$01                                      ; 00BD9E A9 01 
  STA.W EntityHeader,X                                   ; 00BDA0 9D D2 06 
  LDA.B $09                                       ; 00BDA3 A5 09 
  STA.W EntityV20,X                                   ; 00BDA5 9D BA 0F 
  LDA.B $08                                       ; 00BDA8 A5 08 
  STA.W EntityV21,X                                   ; 00BDAA 9D 2C 10 
  LDA.B #$3B                                      ; 00BDAD A9 3B 
  STA.W EntityV1,X                                   ; 00BDAF 9D 44 07 
  LDA.B #$00                                      ; 00BDB2 A9 00 
  STA.W EntityV3,X                                   ; 00BDB4 9D 28 08 
  LDA.B #$28                                      ; 00BDB7 A9 28 
  STA.W EntityV15,X                                   ; 00BDB9 9D 80 0D 
  LDA.B $08                                       ; 00BDBC A5 08 
  STA.W EntityV21,X                                   ; 00BDBE 9D 2C 10 
  AND.B #$07                                      ; 00BDC1 29 07 
  TAY                                             ; 00BDC3 A8 
  LDA.B $0C                                       ; 00BDC4 A5 0C 
  BEQ.B B_BDDD                                    ; 00BDC6 F0 15 
  CLC                                             ; 00BDC8 18 
  LDA.B $0A                                       ; 00BDC9 A5 0A 
  ADC.W D_BEB9,Y                                  ; 00BDCB 79 B9 BE 
  STA.W XexzyCharX,X                              ; 00BDCE 9D 46 0B 
  CLC                                             ; 00BDD1 18 
  LDA.B $0B                                       ; 00BDD2 A5 0B 
  ADC.W D_BEC1,Y                                  ; 00BDD4 79 C1 BE 
  STA.W EntityYPx,X                                   ; 00BDD7 9D 9C 0C 
  JMP.W D_BDE7                                    ; 00BDDA 4C E7 BD 

B_BDDD:
.byte $A5,$0A,$9D,$46,$0B,$A5,$0B,$9D             ; 00BDDD ........ ???F????
.byte $9C,$0C                                     ; 00BDE6 ..       ??

D_BDE7:
  SEC                                             ; 00BDE7 38 
  LDA.W XexzyCharX,X                              ; 00BDE8 BD 46 0B 
  SBC.B #$01                                      ; 00BDEB E9 01 
  BCS.B B_BDF1                                    ; 00BDED B0 02 

.byte $A9,$00                                     ; 00BDF0 ..       ??

B_BDF1:
  STA.W EntityV32,X                                   ; 00BDF1 9D 16 15 
  CLC                                             ; 00BDF4 18 
  LDA.W XexzyCharX,X                              ; 00BDF5 BD 46 0B 
  ADC.B #$01                                      ; 00BDF8 69 01 
  BCC.B B_BDFE                                    ; 00BDFA 90 02 

.byte $A9,$FF                                     ; 00BDFD ..       ??

B_BDFE:
  STA.W EntityV33,X                                   ; 00BDFE 9D 88 15 
  SEC                                             ; 00BE01 38 
  LDA.W EntityYPx,X                                   ; 00BE02 BD 9C 0C 
  SBC.B #$01                                      ; 00BE05 E9 01 
  BCS.B B_BE0B                                    ; 00BE07 B0 02 

.byte $A9,$00                                     ; 00BE0A ..       ??

B_BE0B:
  STA.W EntityV34,X                                   ; 00BE0B 9D FA 15 
  CLC                                             ; 00BE0E 18 
  LDA.W EntityYPx,X                                   ; 00BE0F BD 9C 0C 
  ADC.B #$01                                      ; 00BE12 69 01 
  BCC.B B_BE18                                    ; 00BE14 90 02 

.byte $A9,$FF                                     ; 00BE17 ..       ??

B_BE18:
  STA.W EntityV35,X                                   ; 00BE18 9D 6C 16 
  LDA.B $08                                       ; 00BE1B A5 08 
  AND.B #$07                                      ; 00BE1D 29 07 
  ASL                                             ; 00BE1F 0A 
  TAY                                             ; 00BE20 A8 
  LDA.W D_BEC9,Y                                  ; 00BE21 B9 C9 BE 
  STA.W EntityV5,X                                   ; 00BE24 9D 0C 09 
  LDA.W D_BECA,Y                                  ; 00BE27 B9 CA BE 
  STA.W EntityV6,X                                   ; 00BE2A 9D 7E 09 
  LDA.W D_BED9,Y                                  ; 00BE2D B9 D9 BE 
  STA.W EntityV7,X                                   ; 00BE30 9D F0 09 
  LDA.W D_BEDA,Y                                  ; 00BE33 B9 DA BE 
  STA.W EntityV8,X                                   ; 00BE36 9D 62 0A 
  LDA.B #$6A                                      ; 00BE39 A9 6A 
  STA.W EntityV29,X                                   ; 00BE3B 9D BC 13 
  LDA.B #$34                                      ; 00BE3E A9 34 
  STA.W EntityV30,X                                   ; 00BE40 9D 2E 14 
  JSL L_AECB                                      ; 00BE43 22 CB AE 00 
  TYA                                             ; 00BE47 98 
  STA.W EntityV31,X                                   ; 00BE48 9D A0 14 
  LDA.B #$01                                      ; 00BE4B A9 01 
  STA.W $175E,Y                                   ; 00BE4D 99 5E 17 
  JSL L_AEF1                                      ; 00BE50 22 F1 AE 00 
  LDX.B $05                                       ; 00BE54 A6 05 
  JSL L_38094                                     ; 00BE56 22 94 80 03 
  LDA.B #$3A                                      ; 00BE5A A9 3A 
  STA.W EntityV1,X                                   ; 00BE5C 9D 44 07 
  LDA.B $04                                       ; 00BE5F A5 04 
  STA.W EntityV20,X                                   ; 00BE61 9D BA 0F 
  LDA.B #$C0                                      ; 00BE64 A9 C0 
  STA.W EntityV23,X                                   ; 00BE66 9D 10 11 
D_BE69:
  LDA.B #$FD                                      ; 00BE69 A9 FD 
  STA.W EntityV24,X                                   ; 00BE6B 9D 82 11 
  LDA.B #$EB                                      ; 00BE6E A9 EB 
  STA.W EntityV22,X                                   ; 00BE70 9D 9E 10 
  LDA.B #$28                                      ; 00BE73 A9 28 
  STA.W EntityV15,X                                   ; 00BE75 9D 80 0D 
  LDA.B #$60                                      ; 00BE78 A9 60 
  STA.W EntityV29,X                                   ; 00BE7A 9D BC 13 
  LDA.B #$32                                      ; 00BE7D A9 32 
  STA.W EntityV30,X                                   ; 00BE7F 9D 2E 14 
  JSL L_AECB                                      ; 00BE82 22 CB AE 00 
  TYA                                             ; 00BE86 98 
  STA.W EntityV31,X                                   ; 00BE87 9D A0 14 
  LDA.B #$01                                      ; 00BE8A A9 01 
  STA.W $175E,Y                                   ; 00BE8C 99 5E 17 
  JSL L_AEF1                                      ; 00BE8F 22 F1 AE 00 
  PHX                                             ; 00BE93 DA 
  REP.B #$10                                      ; 00BE94 C2 10 
  LDA.B #$07                                      ; 00BE96 A9 07 
  LDX.W #$8814                                    ; 00BE98 A2 14 88 
  JSL Audio_F830F                                     ; 00BE9B 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00BE9F E2 30 
  PLX                                             ; 00BEA1 FA 
  JSR.W L_BEE9                                    ; 00BEA2 20 E9 BE 
  LDX.B $09                                       ; 00BEA5 A6 09 
  LDY.B $08                                       ; 00BEA7 A4 08 
  LDA.W D_BEB1,Y                                  ; 00BEA9 B9 B1 BE 
  JSL L_E593                                      ; 00BEAC 22 93 E5 00 
  RTS                                             ; 00BEB0 60 


D_BEB1:
.byte $2D,$2E,$2F,$30,$31,$30,$2F,$2E             ; 00BEB1 .DD..DDD -./010/.
D_BEB9:
.byte $FB,$09,$0B,$01,$05,$02,$F6,$F9             ; 00BEB9 .DD..DDD ????????
D_BEC1:
.byte $0E,$0A,$00,$00,$00,$00,$01,$0A             ; 00BEC1 .DD..DDD ????????
D_BEC9:
.byte $00                                         ; 00BECA .        ?
D_BECA:
.byte $00,$6A,$01,$00,$02,$6A,$01,$00             ; 00BECA .DDDD... ?j???j??
.byte $00,$96,$FE,$00,$FE,$96,$FE                 ; 00BED3 .DDDDDD  ???????
D_BED9:
.byte $00                                         ; 00BEDA .        ?
D_BEDA:
.byte $02,$6A,$01,$00,$00,$96,$FE,$00             ; 00BEDA .DDDD... ?j??????
.byte $FE,$96,$FE,$00,$00,$6A,$01                 ; 00BEE3 .DDDDDD  ?????j?


L_BEE9:
  LDX.B $09                                       ; 00BEE9 A6 09 
  LDA.W $1897,X                                   ; 00BEEB BD 97 18 
  BEQ.B B_BF22                                    ; 00BEEE F0 32 
  DEC.W XexzyAmmoCounter,X                        ; 00BEF0 DE 9D 18 
  BNE.B B_BF23                                    ; 00BEF3 D0 2E 
  LDY.W $1897,X                                   ; 00BEF5 BC 97 18 
  LDA.W $189E,Y                                   ; 00BEF8 B9 9E 18 
  STA.W XexzyAmmoCounter,X                        ; 00BEFB 9D 9D 18 
  DEC.W $1899,X                                   ; 00BEFE DE 99 18 
  BNE.B B_BF23                                    ; 00BF01 D0 20 
  LDA.W $1897,X                                   ; 00BF03 BD 97 18 
  CMP.B #$03                                      ; 00BF06 C9 03 
  BNE.B B_BF1A                                    ; 00BF08 D0 10 
  PHX                                             ; 00BF0A DA 
  LDX.W $18D1                                     ; 00BF0B AE D1 18 
  DEC.W $18C5,X                                   ; 00BF0E DE C5 18 
  BNE.B B_BF19                                    ; 00BF11 D0 06 
  STZ.W $18C9,X                                   ; 00BF13 9E C9 18 
  STZ.W $18C1,X                                   ; 00BF16 9E C1 18 
B_BF19:
  PLX                                             ; 00BF19 FA 
B_BF1A:
  STZ.W $1897,X                                   ; 00BF1A 9E 97 18 
  LDA.B #$09                                      ; 00BF1D A9 09 
  STA.W $18B0,X                                   ; 00BF1F 9D B0 18 
B_BF22:
  RTS                                             ; 00BF22 60 

B_BF23:
  LDA.W $1899,X                                   ; 00BF23 BD 99 18 
  CMP.B #$03                                      ; 00BF26 C9 03 
  BNE.B B_BF4D                                    ; 00BF28 D0 23 
  PHX                                             ; 00BF2A DA 
  REP.B #$10                                      ; 00BF2B C2 10 
  SEP.B #P_Acc8Bit                                      ; 00BF2D E2 20 
  LDX.W #$0004                                    ; 00BF2F A2 04 00 
  LDA.B #$0F                                      ; 00BF32 A9 0F 
  JSL Audio_F830F                                     ; 00BF34 22 0F 83 0F 
  LDA.B #$07                                      ; 00BF38 A9 07 
  LDX.W #$FF13                                    ; 00BF3A A2 13 FF 
  JSL Audio_F830F                                     ; 00BF3D 22 0F 83 0F 
  LDX.W #$0001                                    ; 00BF41 A2 01 00 
  LDA.B #$0F                                      ; 00BF44 A9 0F 
  JSL Audio_F830F                                     ; 00BF46 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00BF4A E2 30 
  PLX                                             ; 00BF4C FA 
B_BF4D:
  RTS                                             ; 00BF4D 60 


L_BF4E:
  PHP                                             ; 00BF4E 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00BF4F E2 30 
  LDA.W $1514                                     ; 00BF51 AD 14 15 
  BEQ.B B_BF8E                                    ; 00BF54 F0 38 
  BMI.B B_BF6D                                    ; 00BF56 30 15 
  LDA.W $1512                                     ; 00BF58 AD 12 15 
  STA.B $08                                       ; 00BF5B 85 08 
  LDA.B #$F0                                      ; 00BF5D A9 F0 
  STA.W XexzyTorsoY                               ; 00BF5F 8D 09 03 
  STA.W XexzyLegY                                 ; 00BF62 8D 0D 03 
  LDY.B #$00                                      ; 00BF65 A0 00 
  JSL L_AEF1                                      ; 00BF67 22 F1 AE 00 
  BRA.B B_BF93                                    ; 00BF6B 80 26 
B_BF6D:
  LDY.W $1512                                     ; 00BF6D AC 12 15 
  JSL L_AEF1                                      ; 00BF70 22 F1 AE 00 
  LDA.W $1512                                     ; 00BF74 AD 12 15 
  ASL                                             ; 00BF77 0A 
  ASL                                             ; 00BF78 0A 
  TAY                                             ; 00BF79 A8 
  BCC.B B_BF86                                    ; 00BF7A 90 0A 
  LDA.B #$F0                                      ; 00BF7C A9 F0 
  STA.W $0409,Y                                   ; 00BF7E 99 09 04 
  STA.W $040D,Y                                   ; 00BF81 99 0D 04 
  BRA.B B_BF8E                                    ; 00BF84 80 08 

B_BF86:
.byte $A9,$F0,$99,$09,$03,$99,$0D,$03             ; 00BF86 ........ ????????

B_BF8E:
  LDA.W EntityV31                                     ; 00BF8E AD A0 14 
  STA.B $08                                       ; 00BF91 85 08 
B_BF93:
  LDA.W $1515                                     ; 00BF93 AD 15 15 
  BEQ.B B_BFD0                                    ; 00BF96 F0 38 
  BMI.B B_BFAF                                    ; 00BF98 30 15 
  LDA.W $1513                                     ; 00BF9A AD 13 15 
  STA.B $09                                       ; 00BF9D 85 09 
  LDA.B #$F0                                      ; 00BF9F A9 F0 
  STA.W $0311                                     ; 00BFA1 8D 11 03 
  STA.W $0315                                     ; 00BFA4 8D 15 03 
  LDY.B #$02                                      ; 00BFA7 A0 02 
  JSL L_AEF1                                      ; 00BFA9 22 F1 AE 00 
  BRA.B B_BFD5                                    ; 00BFAD 80 26 
B_BFAF:
  LDY.W $1513                                     ; 00BFAF AC 13 15 
  JSL L_AEF1                                      ; 00BFB2 22 F1 AE 00 
  LDA.W $1513                                     ; 00BFB6 AD 13 15 
  ASL                                             ; 00BFB9 0A 
  ASL                                             ; 00BFBA 0A 
  TAY                                             ; 00BFBB A8 
  BCC.B B_BFC8                                    ; 00BFBC 90 0A 
  LDA.B #$F0                                      ; 00BFBE A9 F0 
  STA.W $0409,Y                                   ; 00BFC0 99 09 04 
  STA.W $040D,Y                                   ; 00BFC3 99 0D 04 
  BRA.B B_BFD0                                    ; 00BFC6 80 08 

B_BFC8:
.byte $A9,$F0,$99,$09,$03,$99,$0D,$03             ; 00BFC8 ........ ????????

B_BFD0:
  LDA.W $14A1                                     ; 00BFD0 AD A1 14 
  STA.B $09                                       ; 00BFD3 85 09 
B_BFD5:
  LDA.W $1514                                     ; 00BFD5 AD 14 15 
  CMP.W $1515                                     ; 00BFD8 CD 15 15 
  BNE.B B_BFEF                                    ; 00BFDB D0 12 
  LDA.W EntityYPx                                     ; 00BFDD AD 9C 0C 
  CMP.W EntityYPx+1                                     ; 00BFE0 CD 9D 0C 
  BCS.B B_BFEF                                    ; 00BFE3 B0 0A 
  LDA.B $08                                       ; 00BFE5 A5 08 
  XBA                                             ; 00BFE7 EB 
  LDA.B $09                                       ; 00BFE8 A5 09 
  STA.B $08                                       ; 00BFEA 85 08 
  XBA                                             ; 00BFEC EB 
  STA.B $09                                       ; 00BFED 85 09 
B_BFEF:
  LDX.B #$00                                      ; 00BFEF A2 00 
D_BFF1:
  LDA.W $18A3,X                                   ; 00BFF1 BD A3 18 
  BNE.B B_C026                                    ; 00BFF4 D0 30 
  LDY.B $08,X                                     ; 00BFF6 B4 08 
  PHY                                             ; 00BFF8 5A 
  JSL L_AEF1                                      ; 00BFF9 22 F1 AE 00 
  PLA                                             ; 00BFFD 68 
  ASL                                             ; 00BFFE 0A 
  ASL                                             ; 00BFFF 0A 
  TAY                                             ; 00C000 A8 
  BCC.B B_C00A                                    ; 00C001 90 07 
  LDA.B #$F0                                      ; 00C003 A9 F0 
  STA.W $0409,Y                                   ; 00C005 99 09 04 
  BRA.B B_C00F                                    ; 00C008 80 05 
B_C00A:
  LDA.B #$F0                                      ; 00C00A A9 F0 
  STA.W XexzyTorsoY,Y                             ; 00C00C 99 09 03 
B_C00F:
  LDA.B $08,X                                     ; 00C00F B5 08 
  INC A
  ASL                                             ; 00C012 0A 
  ASL                                             ; 00C013 0A 
  TAY                                             ; 00C014 A8 
  BCC.B B_C01E                                    ; 00C015 90 07 
  LDA.B #$F0                                      ; 00C017 A9 F0 
  STA.W $0409,Y                                   ; 00C019 99 09 04 
  BRA.B B_C023                                    ; 00C01C 80 05 
B_C01E:
  LDA.B #$F0                                      ; 00C01E A9 F0 
  STA.W XexzyTorsoY,Y                             ; 00C020 99 09 03 
B_C023:
  JMP.W D_C0FC                                    ; 00C023 4C FC C0 
B_C026:
  SEC                                             ; 00C026 38 
  LDA.W XexzyCharX,X                              ; 00C027 BD 46 0B 
  SBC.B #$10                                      ; 00C02A E9 10 
  STA.B $04                                       ; 00C02C 85 04 
  LDA.W $188A,X                                   ; 00C02E BD 8A 18 
  BEQ.B B_C03E                                    ; 00C031 F0 0B 
  LDY.W $1884,X                                   ; 00C033 BC 84 18 
  SEC                                             ; 00C036 38 
  LDA.B $04                                       ; 00C037 A5 04 
  SBC.W D_C10A,Y                                  ; 00C039 F9 0A C1 
  STA.B $04                                       ; 00C03C 85 04 
B_C03E:
  SEC                                             ; 00C03E 38 
  LDA.W EntityYPx,X                                   ; 00C03F BD 9C 0C 
  SBC.B #$18                                      ; 00C042 E9 18 
  STA.B $05                                       ; 00C044 85 05 
  LDA.W EntityV29,X                                   ; 00C046 BD BC 13 
  STA.B $06                                       ; 00C049 85 06 
  LDA.W D_C108,X                                  ; 00C04B BD 08 C1 
  ORA.W $18A7                                     ; 00C04E 0D A7 18 
  ORA.W $188A,X                                   ; 00C051 1D 8A 18 
  STA.W EntityV30,X                                   ; 00C054 9D 2E 14 
  STA.B $07                                       ; 00C057 85 07 
  LDY.B $08,X                                     ; 00C059 B4 08 
  PHY                                             ; 00C05B 5A 
  JSL L_AED8                                      ; 00C05C 22 D8 AE 00 
  PLA                                             ; 00C060 68 
  ASL                                             ; 00C061 0A 
  ASL                                             ; 00C062 0A 
  TAY                                             ; 00C063 A8 
  BCC.B B_C07C                                    ; 00C064 90 16 
  LDA.B $04                                       ; 00C066 A5 04 
  STA.W $0408,Y                                   ; 00C068 99 08 04 
  LDA.B $05                                       ; 00C06B A5 05 
  STA.W $0409,Y                                   ; 00C06D 99 09 04 
  LDA.B $06                                       ; 00C070 A5 06 
  STA.W $040A,Y                                   ; 00C072 99 0A 04 
  LDA.B $07                                       ; 00C075 A5 07 
  STA.W $040B,Y                                   ; 00C077 99 0B 04 
  BRA.B B_C090                                    ; 00C07A 80 14 
B_C07C:
  LDA.B $04                                       ; 00C07C A5 04 
  STA.W $0308,Y                                   ; 00C07E 99 08 03 
  LDA.B $05                                       ; 00C081 A5 05 
  STA.W XexzyTorsoY,Y                             ; 00C083 99 09 03 
  LDA.B $06                                       ; 00C086 A5 06 
  STA.W $030A,Y                                   ; 00C088 99 0A 03 
  LDA.B $07                                       ; 00C08B A5 07 
  STA.W $030B,Y                                   ; 00C08D 99 0B 03 
B_C090:
  SEC                                             ; 00C090 38 
  LDA.W XexzyCharX,X                              ; 00C091 BD 46 0B 
  SBC.B #$10                                      ; 00C094 E9 10 
  STA.B $04                                       ; 00C096 85 04 
  LDA.B #$08                                      ; 00C098 A9 08 
  STA.B $0C                                       ; 00C09A 85 0C 
  LDA.W $1888,X                                   ; 00C09C BD 88 18 
  BEQ.B B_C0A3                                    ; 00C09F F0 02 
  DEC.B $0C                                       ; 00C0A1 C6 0C 
B_C0A3:
  CLC                                             ; 00C0A3 18 
  LDA.B $04                                       ; 00C0A4 A5 04 
  ADC.B $0C                                       ; 00C0A6 65 0C 
  STA.B $0A                                       ; 00C0A8 85 0A 
  CLC                                             ; 00C0AA 18 
  LDA.B $05                                       ; 00C0AB A5 05 
  ADC.B #$10                                      ; 00C0AD 69 10 
  STA.B $0B                                       ; 00C0AF 85 0B 
  LDA.W $18A5,X                                   ; 00C0B1 BD A5 18 
  BEQ.B B_C0BA                                    ; 00C0B4 F0 04 
  LDA.B #$F0                                      ; 00C0B6 A9 F0 
  STA.B $0B                                       ; 00C0B8 85 0B 
B_C0BA:
  LDA.W D_C106,X                                  ; 00C0BA BD 06 C1 
  STA.B $06                                       ; 00C0BD 85 06 
  LDA.W D_C108,X                                  ; 00C0BF BD 08 C1 
  ORA.W $18A7                                     ; 00C0C2 0D A7 18 
  ORA.W $1888,X                                   ; 00C0C5 1D 88 18 
  STA.B $07                                       ; 00C0C8 85 07 
  LDA.B $08,X                                     ; 00C0CA B5 08 
  INC A
  ASL                                             ; 00C0CD 0A 
  ASL                                             ; 00C0CE 0A 
  TAY                                             ; 00C0CF A8 
  BCC.B B_C0E8                                    ; 00C0D0 90 16 
  LDA.B $0A                                       ; 00C0D2 A5 0A 
  STA.W $0408,Y                                   ; 00C0D4 99 08 04 
  LDA.B $0B                                       ; 00C0D7 A5 0B 
  STA.W $0409,Y                                   ; 00C0D9 99 09 04 
  LDA.B $06                                       ; 00C0DC A5 06 
  STA.W $040A,Y                                   ; 00C0DE 99 0A 04 
  LDA.B $07                                       ; 00C0E1 A5 07 
  STA.W $040B,Y                                   ; 00C0E3 99 0B 04 
  BRA.B D_C0FC                                    ; 00C0E6 80 14 
B_C0E8:
  LDA.B $0A                                       ; 00C0E8 A5 0A 
  STA.W $0308,Y                                   ; 00C0EA 99 08 03 
  LDA.B $0B                                       ; 00C0ED A5 0B 
  STA.W XexzyTorsoY,Y                             ; 00C0EF 99 09 03 
  LDA.B $06                                       ; 00C0F2 A5 06 
  STA.W $030A,Y                                   ; 00C0F4 99 0A 03 
  LDA.B $07                                       ; 00C0F7 A5 07 
  STA.W $030B,Y                                   ; 00C0F9 99 0B 03 
D_C0FC:
  INX                                             ; 00C0FC E8 
  CPX.B #$02                                      ; 00C0FD E0 02 
  BEQ.B B_C104                                    ; 00C0FF F0 03 
  JMP.W D_BFF1                                    ; 00C101 4C F1 BF 
B_C104:
  PLP                                             ; 00C104 28 
  RTS                                             ; 00C105 60 


D_C106:
.byte $08,$28                                     ; 00C107 DD       ?(
D_C108:
.byte $25,$27                                     ; 00C109 DD       %'
D_C10A:
.byte $00,$00,$01,$01,$01,$00,$00,$01             ; 00C10A ..DDD..D ????????
.byte $01,$01,$00,$00,$01,$01,$01,$00             ; 00C112 DD..DDD. ????????
.byte $00,$00,$00,$01,$00,$00,$00,$00             ; 00C11A .DDD..DD ????????
.byte $01,$00,$00,$00,$01,$00,$00,$00             ; 00C122 D.DDDD.. ????????
.byte $01,$01,$00,$00,$00,$00,$00,$00             ; 00C12A DDD..DDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00C132 ..DDD... ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00C13A ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00C142 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00C14A DDDDDDDD ????????
.byte $00,$00,$00,$08,$08,$08,$08,$08             ; 00C152 DDDDDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$00,$00             ; 00C15A DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00C162 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00C16A ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00C172 ........ ????????
.byte $00                                         ; 00C17B .        ?


L_C17B:
  PHP                                             ; 00C17B 08 
  PHB                                             ; 00C17C 8B 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00C17D E2 30 
  LDA.B #$FF                                      ; 00C17F A9 FF 
  STA.W $05AA                                     ; 00C181 8D AA 05 
  STZ.W $05D2                                     ; 00C184 9C D2 05 
  STZ.W $05D1                                     ; 00C187 9C D1 05 
  STZ.W $18E4                                     ; 00C18A 9C E4 18 
  STZ.W $18E5                                     ; 00C18D 9C E5 18 
  STZ.W $18E6                                     ; 00C190 9C E6 18 
  STZ.W $18E7                                     ; 00C193 9C E7 18 
  STZ.W $18E8                                     ; 00C196 9C E8 18 
  STZ.W $18E9                                     ; 00C199 9C E9 18 
  STZ.W $18EA                                     ; 00C19C 9C EA 18 
  STZ.W $18EB                                     ; 00C19F 9C EB 18 
  STZ.W $18EC                                     ; 00C1A2 9C EC 18 
  STZ.W $18ED                                     ; 00C1A5 9C ED 18 
  STZ.W $18EE                                     ; 00C1A8 9C EE 18 
  STZ.W $18EF                                     ; 00C1AB 9C EF 18 
  STZ.W $18F0                                     ; 00C1AE 9C F0 18 
  STZ.W $18F1                                     ; 00C1B1 9C F1 18 
  STZ.W $1901                                     ; 00C1B4 9C 01 19 
  STZ.W $1900                                     ; 00C1B7 9C 00 19 
  STZ.W $06C6                                     ; 00C1BA 9C C6 06 
  LDX.B #$06                                      ; 00C1BD A2 06 
B_C1BF:
  STZ.W $1902,X                                   ; 00C1BF 9E 02 19 
  DEX                                             ; 00C1C2 CA 
  BPL.B B_C1BF                                    ; 00C1C3 10 FA 
  LDX.B #$02                                      ; 00C1C5 A2 02 
B_C1C7:
  STZ.W $1AAF,X                                   ; 00C1C7 9E AF 1A 
  DEX                                             ; 00C1CA CA 
  BPL.B B_C1C7                                    ; 00C1CB 10 FA 
  LDA.W GameCircuitWarpActive                                     ; 00C1CD AD 0E 02 
  BEQ.B B_C1E0                                    ; 00C1D0 F0 0E 

.byte $22,$6A,$CA,$0E,$AD,$F1,$02,$29             ; 00C1D2 ........ "j?????)
.byte $20,$F0,$03,$AB,$28,$60                     ; 00C1DB ......    ???(`

B_C1E0:
  LDA.B #$02                                      ; 00C1E0 A9 02 
  PHA                                             ; 00C1E2 48 
  PLB                                             ; 00C1E3 AB 
  LDA.W CurrentRound                                     ; 00C1E4 AD AB 05 
  ASL                                             ; 00C1E7 0A 
  TAX                                             ; 00C1E8 AA 
  LDA.W D_B5F0,X                                  ; 00C1E9 BD F0 B5 
  STA.B $04                                       ; 00C1EC 85 04 
  LDA.W D_B5F1,X                                  ; 00C1EE BD F1 B5 
  STA.B $05                                       ; 00C1F1 85 05 
  LDA.W CurrentRoom                                     ; 00C1F3 AD AC 05 
  ASL                                             ; 00C1F6 0A 
  TAY                                             ; 00C1F7 A8 
  LDA.B ($04),Y                                   ; 00C1F8 B1 04 
  STA.B $12                                       ; 00C1FA 85 12 
  INY                                             ; 00C1FC C8 
  LDA.B ($04),Y                                   ; 00C1FD B1 04 
  STA.B $13                                       ; 00C1FF 85 13 
  LDY.B #$00                                      ; 00C201 A0 00 
  LDA.B ($12),Y                                   ; 00C203 B1 12 
  STA.B $10                                       ; 00C205 85 10 
B_C207:
  INC.W $1900                                     ; 00C207 EE 00 19 
  LDX.B $10                                       ; 00C20A A6 10 
  INY                                             ; 00C20C C8 
  LDA.B ($12),Y                                   ; 00C20D B1 12 
  STA.W $1902,X                                   ; 00C20F 9D 02 19 
  INY                                             ; 00C212 C8 
  LDA.B ($12),Y                                   ; 00C213 B1 12 
  STA.W $1909,X                                   ; 00C215 9D 09 19 
  INY                                             ; 00C218 C8 
  LDA.B ($12),Y                                   ; 00C219 B1 12 
  STA.W $1910,X                                   ; 00C21B 9D 10 19 
  INY                                             ; 00C21E C8 
  LDA.B ($12),Y                                   ; 00C21F B1 12 
  STA.W $1917,X                                   ; 00C221 9D 17 19 
  INY                                             ; 00C224 C8 
  LDA.B ($12),Y                                   ; 00C225 B1 12 
  STA.W $191E,X                                   ; 00C227 9D 1E 19 
  INY                                             ; 00C22A C8 
  LDA.B ($12),Y                                   ; 00C22B B1 12 
  STA.W $1925,X                                   ; 00C22D 9D 25 19 
  INY                                             ; 00C230 C8 
  LDA.B ($12),Y                                   ; 00C231 B1 12 
  STA.W $192C,X                                   ; 00C233 9D 2C 19 
  INY                                             ; 00C236 C8 
  LDA.B ($12),Y                                   ; 00C237 B1 12 
  STA.W $1933,X                                   ; 00C239 9D 33 19 
  INY                                             ; 00C23C C8 
  LDA.B ($12),Y                                   ; 00C23D B1 12 
  STA.W $193A,X                                   ; 00C23F 9D 3A 19 
  INY                                             ; 00C242 C8 
  LDA.B ($12),Y                                   ; 00C243 B1 12 
  STA.W $1941,X                                   ; 00C245 9D 41 19 
  STY.B $11                                       ; 00C248 84 11 
  JSR.W L_C367                                    ; 00C24A 20 67 C3 
  LDY.B $11                                       ; 00C24D A4 11 
  DEC.B $10                                       ; 00C24F C6 10 
  BPL.B B_C207                                    ; 00C251 10 B4 
  INY                                             ; 00C253 C8 
  LDA.B ($12),Y                                   ; 00C254 B1 12 
  STA.W $18FF                                     ; 00C256 8D FF 18 
  PLB                                             ; 00C259 AB 
  PLP                                             ; 00C25A 28 
  RTS                                             ; 00C25B 60 


L_C25C:
  LDY.B #$06                                      ; 00C25C A0 06 
B_C25E:
  LDA.W $1902,Y                                   ; 00C25E B9 02 19 
  BEQ.B B_C268                                    ; 00C261 F0 05 
  PHY                                             ; 00C263 5A 
  JSR.W L_C26C                                    ; 00C264 20 6C C2 
  PLY                                             ; 00C267 7A 
B_C268:
  DEY                                             ; 00C268 88 
  BPL.B B_C25E                                    ; 00C269 10 F3 
  RTS                                             ; 00C26B 60 


L_C26C:
  TYX                                             ; 00C26C BB 
  LDA.W $1902,X                                   ; 00C26D BD 02 19 
  ASL                                             ; 00C270 0A 
  TAX                                             ; 00C271 AA 
  JMP.W ($C275,X)                                 ; 00C272 7C 75 C2 

.byte $B4,$C2,$B4,$C2,$B4,$C2,$A3,$C2             ; 00C275 ..DD.... ????????
.byte $B4,$C2,$A3,$C2,$B4,$C2,$B4,$C2             ; 00C27D ........ ????????
.byte $A3,$C2,$A3,$C2,$A3,$C2,$B4,$C2             ; 00C285 DDDDDD.. ????????
.byte $B4,$C2,$B4,$C2,$A3,$C2,$B4,$C2             ; 00C28D ......DD ????????
.byte $B4,$C2,$B4,$C2,$B4,$C2,$B4                 ; 00C296 ..DD...  ???????
D_C29C:
.byte $C2                                         ; 00C29D .        ?
D_C29D:
.byte $B4,$C2,$B4,$C2,$B4,$C2                     ; 00C29E DDDD..   ??????

  LDA.W $18FF                                     ; 00C2A3 AD FF 18 
  CMP.W $1900                                     ; 00C2A6 CD 00 19 
  BCC.B B_C2B3                                    ; 00C2A9 90 08 
  LDA.B #$00                                      ; 00C2AB A9 00 
  STA.W $1902,Y                                   ; 00C2AD 99 02 19 
  DEC.W $1900                                     ; 00C2B0 CE 00 19 
B_C2B3:
  RTS                                             ; 00C2B3 60 

  RTS                                             ; 00C2B4 60 


L_C2B5:
  PHP                                             ; 00C2B5 08 
  PHB                                             ; 00C2B6 8B 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00C2B7 E2 30 
  LDA.W $1901                                     ; 00C2B9 AD 01 19 
  BEQ.B B_C2C4                                    ; 00C2BC F0 06 
  DEC.W $1901                                     ; 00C2BE CE 01 19 
  PLB                                             ; 00C2C1 AB 
  PLP                                             ; 00C2C2 28 
  RTS                                             ; 00C2C3 60 

B_C2C4:
  JSR.W L_C25C                                    ; 00C2C4 20 5C C2 
  LDA.W $1900                                     ; 00C2C7 AD 00 19 
  BEQ.B B_C2D2                                    ; 00C2CA F0 06 
  JSR.W L_DB76                                    ; 00C2CC 20 76 DB 
  JSR.W L_DA43                                    ; 00C2CF 20 43 DA 
B_C2D2:
  LDA.B #$00                                      ; 00C2D2 A9 00 
  PHA                                             ; 00C2D4 48 
  PLB                                             ; 00C2D5 AB 
  LDY.B #$06                                      ; 00C2D6 A0 06 
B_C2D8:
  LDA.W $1902,Y                                   ; 00C2D8 B9 02 19 
  BEQ.B B_C32B                                    ; 00C2DB F0 4E 
  SEC                                             ; 00C2DD 38 
  LDA.W $193A,Y                                   ; 00C2DE B9 3A 19 
  SBC.B #$01                                      ; 00C2E1 E9 01 
  STA.W $193A,Y                                   ; 00C2E3 99 3A 19 
  LDA.W $1941,Y                                   ; 00C2E6 B9 41 19 
  SBC.B #$00                                      ; 00C2E9 E9 00 
  STA.W $1941,Y                                   ; 00C2EB 99 41 19 
  LDA.W $193A,Y                                   ; 00C2EE B9 3A 19 
  ORA.W $1941,Y                                   ; 00C2F1 19 41 19 
  BNE.B B_C32B                                    ; 00C2F4 D0 35 
  LDA.W $1925,Y                                   ; 00C2F6 B9 25 19 
  STA.W $193A,Y                                   ; 00C2F9 99 3A 19 
  LDA.W $192C,Y                                   ; 00C2FC B9 2C 19 
  STA.W $1941,Y                                   ; 00C2FF 99 41 19 
  STY.B $10                                       ; 00C302 84 10 
  JSR.W L_C331                                    ; 00C304 20 31 C3 
  STA.B $04                                       ; 00C307 85 04 
  LDY.B $10                                       ; 00C309 A4 10 
  SEC                                             ; 00C30B 38 
  LDA.W $1909,Y                                   ; 00C30C B9 09 19 
  SBC.B $04                                       ; 00C30F E5 04 
  STA.W $1909,Y                                   ; 00C311 99 09 19 
  LDA.W $1910,Y                                   ; 00C314 B9 10 19 
  SBC.B #$00                                      ; 00C317 E9 00 
  STA.W $1910,Y                                   ; 00C319 99 10 19 
  BMI.B B_C323                                    ; 00C31C 30 05 
  ORA.W $1909,Y                                   ; 00C31E 19 09 19 
  BNE.B B_C32B                                    ; 00C321 D0 08 
B_C323:
  LDA.B #$00                                      ; 00C323 A9 00 
  STA.W $1902,Y                                   ; 00C325 99 02 19 
  DEC.W $1900                                     ; 00C328 CE 00 19 
B_C32B:
  DEY                                             ; 00C32B 88 
  BPL.B B_C2D8                                    ; 00C32C 10 AA 
  PLB                                             ; 00C32E AB 
  PLP                                             ; 00C32F 28 
  RTS                                             ; 00C330 60 


L_C331:
  LDA.W $1902,Y                                   ; 00C331 B9 02 19 
  ASL                                             ; 00C334 0A 
  TAX                                             ; 00C335 AA 
  JMP.W ($C339,X)                                 ; 00C336 7C 39 C3 

.byte $D8,$C3,$DA,$C3,$82,$C4,$62,$C5             ; 00C339 ..DD.... ??????b?
.byte $92,$C6,$26,$C7,$37,$C8,$DF,$C8             ; 00C341 ........ ??&?7???
.byte $F3,$C9,$42,$CB,$B8,$CC,$A3,$CD             ; 00C349 DDDDDD.. ??B?????
.byte $55,$CE,$07,$CF,$EB,$CF,$1B,$D1             ; 00C351 ......DD U???????
.byte $A5,$D1,$5D,$D3,$A0,$D5,$BD,$D8             ; 00C359 ..DD.... ??]?????
.byte $BF,$D8,$37,$D9,$D8,$D9                     ; 00C362 DDDD..   ??7???


L_C367:
  LDA.W $1902,X                                   ; 00C367 BD 02 19 
  ASL                                             ; 00C36A 0A 
  TAX                                             ; 00C36B AA 
  JMP.W ($C36F,X)                                 ; 00C36C 7C 6F C3 

.byte $D9,$C3,$38,$C4,$83,$C4,$89,$C6             ; 00C36F ..DDDD.. ??8?????
.byte $F9,$C6,$2E,$C8,$95,$C8,$A9,$C9             ; 00C377 ........ ??.?????
.byte $39,$CB,$AF,$CC,$97,$CD,$4C,$CE             ; 00C37F DDDDDD.. 9?????L?
.byte $FE,$CE,$A1,$CF,$12,$D1,$1C,$D1             ; 00C387 ......DD ????????
.byte $A6,$D1,$9F,$D5,$07,$D7,$BE,$D8             ; 00C38F ..DD.... ????????
.byte $31,$D9,$D7,$D9,$E7,$D9                     ; 00C398 DDDD..   1?????


L_C39D:
  JSL AdvanceRNG                                     ; 00C39D 22 95 CA 0E 
  AND.B #$0F                                      ; 00C3A1 29 0F 
  TAY                                             ; 00C3A3 A8 
  LDA.W D_C3C0,Y                                  ; 00C3A4 B9 C0 C3 
  CMP.W $05AA                                     ; 00C3A7 CD AA 05 
  BNE.B B_C3AF                                    ; 00C3AA D0 03 
  INC A
  AND.B #$03                                      ; 00C3AD 29 03 
B_C3AF:
  STA.W $05AA                                     ; 00C3AF 8D AA 05 
  TAY                                             ; 00C3B2 A8 
  LDA.W D_C3D0,Y                                  ; 00C3B3 B9 D0 C3 
  STA.W XexzyCharX,X                              ; 00C3B6 9D 46 0B 
  LDA.W D_C3D4,Y                                  ; 00C3B9 B9 D4 C3 
  STA.W EntityYPx,X                                   ; 00C3BC 9D 9C 0C 
  RTS                                             ; 00C3BF 60 


D_C3C0:
.byte $00,$00,$01,$01,$02,$02,$00,$03             ; 00C3C0 DDDDDDDD ????????
.byte $00,$00,$02,$01,$02,$02,$03,$03             ; 00C3C8 DDDDDDDD ????????
D_C3D0:
.byte $80,$FA,$80,$04                             ; 00C3D1 DDDD     ????
D_C3D4:
.byte $06,$80,$E0,$80,$60,$60                     ; 00C3D5 DDDD..   ????``

  LDA.W $18E4                                     ; 00C3DA AD E4 18 
  CMP.W $18F2                                     ; 00C3DD CD F2 18 
  BCS.B B_C435                                    ; 00C3E0 B0 53 
  JSL L_380F3                                     ; 00C3E2 22 F3 80 03 
  BNE.B B_C435                                    ; 00C3E6 D0 4D 
  INC.W $06C6                                     ; 00C3E8 EE C6 06 
  CLC                                             ; 00C3EB 18 
  LDA.W $18E4                                     ; 00C3EC AD E4 18 
  ADC.B #$06                                      ; 00C3EF 69 06 
  STA.W $18E4                                     ; 00C3F1 8D E4 18 
  JSL L_38094                                     ; 00C3F4 22 94 80 03 
  LDA.B #$01                                      ; 00C3F8 A9 01 
  STA.W EntityHeader,X                                   ; 00C3FA 9D D2 06 
  JSR.W L_C39D                                    ; 00C3FD 20 9D C3 
  TYA                                             ; 00C400 98 
  STA.W EntityV21,X                                   ; 00C401 9D 2C 10 
  BNE.B B_C40E                                    ; 00C404 D0 08 
  LDA.B #$01                                      ; 00C406 A9 01 
  STA.W $05E4                                     ; 00C408 8D E4 05 
  STA.W $05E3                                     ; 00C40B 8D E3 05 
B_C40E:
  LDA.B #$14                                      ; 00C40E A9 14 
  STA.W EntityV1,X                                   ; 00C410 9D 44 07 
  LDA.B #$00                                      ; 00C413 A9 00 
  STA.W EntityV3,X                                   ; 00C415 9D 28 08 
  LDY.B $10                                       ; 00C418 A4 10 
  LDA.W $191E,Y                                   ; 00C41A B9 1E 19 
  STA.W EntityV22,X                                   ; 00C41D 9D 9E 10 
  JSL AdvanceRNG                                     ; 00C420 22 95 CA 0E 
  AND.B #$03                                      ; 00C424 29 03 
  BNE.B B_C431                                    ; 00C426 D0 09 
  JSL AdvanceRNG                                     ; 00C428 22 95 CA 0E 
  AND.B #$07                                      ; 00C42C 29 07 
  CLC                                             ; 00C42E 18 
  ADC.B #$04                                      ; 00C42F 69 04 
B_C431:
  STA.W EntityV20,X                                   ; 00C431 9D BA 0F 
  RTS                                             ; 00C434 60 

B_C435:
  LDA.B #$00                                      ; 00C435 A9 00 
  RTS                                             ; 00C437 60 

  LDX.B $10                                       ; 00C438 A6 10 
  LDA.W $1917,X                                   ; 00C43A BD 17 19 
  STA.W $18F2                                     ; 00C43D 8D F2 18 
  REP.B #P_Acc8Bit                                      ; 00C440 C2 20 
  LDA.W #$B000                                    ; 00C442 A9 00 B0 
  STA.W $1ACA                                     ; 00C445 8D CA 1A 
  LDA.W #$0200                                    ; 00C448 A9 00 02 
  STA.W $1ACC                                     ; 00C44B 8D CC 1A 
  LDA.W #$B400                                    ; 00C44E A9 00 B4 
  STA.W $1ACE                                     ; 00C451 8D CE 1A 
  LDA.W #$0200                                    ; 00C454 A9 00 02 
  STA.W $1AD0                                     ; 00C457 8D D0 1A 
  LDA.W #$B200                                    ; 00C45A A9 00 B2 
  STA.W $1AD2                                     ; 00C45D 8D D2 1A 
  LDA.W #$0180                                    ; 00C460 A9 80 01 
  STA.W $1AD4                                     ; 00C463 8D D4 1A 
  LDA.W #$B600                                    ; 00C466 A9 00 B6 
  STA.W $1AD6                                     ; 00C469 8D D6 1A 
  LDA.W #$0180                                    ; 00C46C A9 80 01 
  STA.W $1AD8                                     ; 00C46F 8D D8 1A 
  SEP.B #P_Acc8Bit                                      ; 00C472 E2 20 
  LDA.B #$01                                      ; 00C474 A9 01 
  STA.W $1ADA                                     ; 00C476 8D DA 1A 
  LDA.B #$01                                      ; 00C479 A9 01 
  STA.W $1ADB                                     ; 00C47B 8D DB 1A 
  JSR.W L_E10F                                    ; 00C47E 20 0F E1 
  RTS                                             ; 00C481 60 


.byte $60                                         ; 00C483 .        `

  PHB                                             ; 00C483 8B 
  LDA.B #$00                                      ; 00C484 A9 00 
  PHA                                             ; 00C486 48 
  PLB                                             ; 00C487 AB 
  LDX.B $10                                       ; 00C488 A6 10 
  DEC.W $1900                                     ; 00C48A CE 00 19 
  STZ.W $1902,X                                   ; 00C48D 9E 02 19 
  LDA.W $1909,X                                   ; 00C490 BD 09 19 
  CMP.B #$01                                      ; 00C493 C9 01 
  BEQ.B B_C49E                                    ; 00C495 F0 07 
  LDA.B #$B4                                      ; 00C497 A9 B4 
  STA.B $06                                       ; 00C499 85 06 
  JSR.W L_C4A7                                    ; 00C49B 20 A7 C4 
B_C49E:
  LDA.B #$4C                                      ; 00C49E A9 4C 
  STA.B $06                                       ; 00C4A0 85 06 
  JSR.W L_C4A7                                    ; 00C4A2 20 A7 C4 
  PLB                                             ; 00C4A5 AB 
  RTS                                             ; 00C4A6 60 


L_C4A7:
  JSL L_380F3                                     ; 00C4A7 22 F3 80 03 
  BEQ.B B_C4AE                                    ; 00C4AB F0 01 

B_C4AD:
.byte $60                                         ; 00C4AE .        `

B_C4AE:
  LDA.B #$0E                                      ; 00C4AE A9 0E 
  JSL L_38064                                     ; 00C4B0 22 64 80 03 
  BMI.B B_C4AD                                    ; 00C4B4 30 F7 
  STY.W $18E2                                     ; 00C4B6 8C E2 18 
  JSL L_38094                                     ; 00C4B9 22 94 80 03 
  LDA.B #$01                                      ; 00C4BD A9 01 
  STA.W EntityHeader,X                                   ; 00C4BF 9D D2 06 
  LDA.B #$92                                      ; 00C4C2 A9 92 
  STA.W EntityV1,X                                   ; 00C4C4 9D 44 07 
  LDA.B #$0C                                      ; 00C4C7 A9 0C 
  STA.W EntityV3,X                                   ; 00C4C9 9D 28 08 
  LDA.B #$10                                      ; 00C4CC A9 10 
  STA.W EntityV19,X                                   ; 00C4CE 9D 48 0F 
  INC.W $06C6                                     ; 00C4D1 EE C6 06 
  LDA.B $06                                       ; 00C4D4 A5 06 
  STA.W XexzyCharX,X                              ; 00C4D6 9D 46 0B 
  LDA.B #$1D                                      ; 00C4D9 A9 1D 
  STA.W EntityYPx,X                                   ; 00C4DB 9D 9C 0C 
  LDY.W $06C7                                     ; 00C4DE AC C7 06 
  LDA.W D_C559,Y                                  ; 00C4E1 B9 59 C5 
  STA.W EntityV11,X                                   ; 00C4E4 9D B8 0B 
  LDA.W D_C55C,Y                                  ; 00C4E7 B9 5C C5 
  STA.W EntityV14,X                                   ; 00C4EA 9D 0E 0D 
  JSL AdvanceRNG                                     ; 00C4ED 22 95 CA 0E 
  AND.B #$07                                      ; 00C4F1 29 07 
  ADC.B #$2C                                      ; 00C4F3 69 2C 
  STA.W EntityV15,X                                   ; 00C4F5 9D 80 0D 
  JSL L_38059                                     ; 00C4F8 22 59 80 03 
  LDA.B #$01                                      ; 00C4FC A9 01 
  STA.W $1AAF,Y                                   ; 00C4FE 99 AF 1A 
  LDA.W D_C55F,Y                                  ; 00C501 B9 5F C5 
  STA.W EntityV29,X                                   ; 00C504 9D BC 13 
  TYA                                             ; 00C507 98 
  STA.W EntityV23,X                                   ; 00C508 9D 10 11 
  LDA.W $18E2                                     ; 00C50B AD E2 18 
  ASL                                             ; 00C50E 0A 
  ORA.B #$39                                      ; 00C50F 09 39 
  STA.W EntityV2,X                                   ; 00C511 9D B6 07 
  STA.W EntityV30,X                                   ; 00C514 9D 2E 14 
  JSL L_AEBC                                      ; 00C517 22 BC AE 00 
  TYA                                             ; 00C51B 98 
  STA.W EntityV31,X                                   ; 00C51C 9D A0 14 
  LDA.B #$01                                      ; 00C51F A9 01 
  STA.W $175E,Y                                   ; 00C521 99 5E 17 
  JSL L_AED8                                      ; 00C524 22 D8 AE 00 
  LDA.W EntityV31,X                                   ; 00C528 BD A0 14 
  ASL                                             ; 00C52B 0A 
  ASL                                             ; 00C52C 0A 
  TAY                                             ; 00C52D A8 
  BCC.B B_C53C                                    ; 00C52E 90 0C 

.byte $A9,$FF,$99,$08,$04,$A9,$F0,$99             ; 00C530 ........ ????????
.byte $09,$04,$80,$0A                             ; 00C539 ....     ????

B_C53C:
  LDA.B #$FF                                      ; 00C53C A9 FF 
  STA.W $0308,Y                                   ; 00C53E 99 08 03 
  LDA.B #$F0                                      ; 00C541 A9 F0 
  STA.W XexzyTorsoY,Y                             ; 00C543 99 09 03 
  LDA.B #$08                                      ; 00C546 A9 08 
  STA.W EntityV25,X                                   ; 00C548 9D F4 11 
  PHB                                             ; 00C54B 8B 
  LDA.B #$03                                      ; 00C54C A9 03 
  PHA                                             ; 00C54E 48 
  PLB                                             ; 00C54F AB 
  LDA.W EntityV23,X                                   ; 00C550 BD 10 11 
  JSL L_3F032                                     ; 00C553 22 32 F0 03 
  PLB                                             ; 00C557 AB 
  RTS                                             ; 00C558 60 


D_C559:
.byte $00,$01,$00                                 ; 00C55A DDD      ???
D_C55C:
.byte $FF,$00,$01                                 ; 00C55D DDD      ???
D_C55F:
.byte $C4,$C8,$CC,$AD,$E5,$18,$CD,$F3             ; 00C55F .DD..... ????????
.byte $18,$B0,$06,$22,$F3,$80,$03,$F0             ; 00C567 ........ ???"????
.byte $03,$A9,$00,$60,$A9,$03,$22,$64             ; 00C56F ........ ???`??"d
.byte $80,$03,$30,$F5,$8C,$DB,$18,$98             ; 00C577 ........ ??0?????
.byte $0A,$09,$38,$85,$09,$86,$08,$22             ; 00C57F ........ ??8????"
.byte $94,$80,$03,$A9,$01,$9D,$D2,$06             ; 00C587 ........ ????????
.byte $A9,$1E,$9D,$44,$07,$A9,$0C,$9D             ; 00C58F ........ ???D????
.byte $28,$08,$A9,$E0,$9D,$BC,$13,$A5             ; 00C597 ........ (???????
.byte $09,$9D,$B6,$07,$9D,$2E,$14,$20             ; 00C59F ........ ?????.? 
.byte $9D,$C3,$98,$D0,$08,$A9,$01,$8D             ; 00C5A7 ........ ????????
.byte $E4,$05,$8D,$E3,$05,$98,$0A,$A8             ; 00C5AF ........ ????????
.byte $B9,$79,$C6,$9D,$0C,$09,$B9,$7A             ; 00C5B7 ........ ?y?????z
.byte $C6,$9D,$7E,$09,$B9,$81,$C6,$9D             ; 00C5BF ........ ??~?????
.byte $F0,$09,$B9,$82,$C6,$9D,$62,$0A             ; 00C5C7 ........ ??????b?
.byte $BD,$46,$0B,$85,$06,$BD,$9C,$0C             ; 00C5CF ........ ?F??????
.byte $85,$07,$A9,$01,$9D,$80,$0D,$22             ; 00C5D7 ........ ???????"
.byte $95,$CA,$0E,$29,$01,$9D,$BA,$0F             ; 00C5DF ........ ???)????
.byte $A9,$FF,$9D,$2C,$10,$A9,$03,$9D             ; 00C5E7 ........ ???,????
.byte $4A,$13,$9E,$D8,$12,$22,$BC,$AE             ; 00C5EF ........ J????"??
.byte $00,$98,$9D,$A0,$14,$A9,$01,$99             ; 00C5F7 ........ ????????
.byte $5E,$17,$22,$F1,$AE,$00,$A2,$08             ; 00C5FF ........ ^?"?????
.byte $86,$04,$22,$F3,$80,$03,$D0,$61             ; 00C607 ........ ??"????a
.byte $22,$94,$80,$03,$A9,$01,$9D,$D2             ; 00C60F ........ "???????
.byte $06,$A9,$0C,$9D,$28,$08,$A9,$20             ; 00C617 ........ ????(?? 
.byte $9D,$44,$07,$A9,$E0,$9D,$BC,$13             ; 00C61F ........ ?D??????
.byte $A5,$09,$9D,$B6,$07,$9D,$2E,$14             ; 00C627 ........ ??????.?
.byte $A5,$06,$9D,$46,$0B,$A5,$07,$9D             ; 00C62F ........ ???F????
.byte $9C,$0C,$8A,$29,$07,$1A,$9D,$80             ; 00C637 ........ ???)????
.byte $0D,$A5,$08,$9D,$BA,$0F,$A9,$FF             ; 00C63F ........ ????????
.byte $9D,$2C,$10,$8A,$A4,$08,$99,$2C             ; 00C647 ........ ?,?????,
.byte $10,$86,$08,$A9,$03,$9D,$4A,$13             ; 00C64F ........ ??????J?
.byte $9E,$D8,$12,$22,$BC,$AE,$00,$98             ; 00C657 ........ ???"????
.byte $9D,$A0,$14,$A9,$01,$99,$5E,$17             ; 00C65F ........ ??????^?
.byte $22,$F1,$AE,$00,$A6,$04,$CA,$D0             ; 00C667 ........ "???????
.byte $97,$EE,$E5,$18,$EE,$C6,$06,$A9             ; 00C66F ........ ????????
.byte $01,$60,$00,$00,$80,$FF,$00,$00             ; 00C677 ........ ?`??????
.byte $80,$00,$80,$00,$00,$00,$80,$FF             ; 00C67F ........ ????????
.byte $00,$00,$A6,$10,$BD,$17,$19,$8D             ; 00C687 ........ ????????
.byte $F3,$18,$60,$AD,$E6,$18,$CD,$F4             ; 00C68F ........ ??`?????
.byte $18,$B0,$5C,$22,$F3,$80,$03,$D0             ; 00C697 ........ ??\"????
.byte $56,$A9,$02,$22,$64,$80,$03,$30             ; 00C69F ........ V??"d??0
.byte $4E,$8C,$D5,$18,$98,$0A,$09,$38             ; 00C6A7 ........ N??????8
.byte $85,$04,$EE,$C6,$06,$EE,$E6,$18             ; 00C6AF ........ ????????
.byte $22,$94,$80,$03,$A9,$01,$9D,$D2             ; 00C6B7 ........ "???????
.byte $06,$A9,$00,$9D,$28,$08,$20,$9D             ; 00C6BF ........ ????(? ?
.byte $C3,$98,$9D,$2C,$10,$D0,$08,$A9             ; 00C6C7 ........ ???,????
.byte $01,$8D,$E4,$05,$8D,$E3,$05,$A5             ; 00C6CF ........ ????????
.byte $04,$9D,$B6,$07,$A4,$10,$B9,$1E             ; 00C6D7 ........ ????????
.byte $19,$4A,$9D,$10,$11,$A9,$18,$9D             ; 00C6DF ........ ?J??????
.byte $44,$07,$22,$95,$CA,$0E,$29,$07             ; 00C6E7 ........ D?"???)?
.byte $18,$69,$04,$9D,$BA,$0F,$60,$A9             ; 00C6EF ........ ?i????`?
.byte $00,$60,$A6,$10,$BD,$17,$19,$8D             ; 00C6F7 ........ ?`??????
.byte $F4,$18,$C2,$20,$A9,$00,$C0,$8D             ; 00C6FF ........ ??? ????
.byte $CA,$1A,$A9,$40,$01,$8D,$CC,$1A             ; 00C707 ........ ???@????
.byte $A9,$00,$C4,$8D,$CE,$1A,$A9,$40             ; 00C70F ........ ???????@
.byte $01,$8D,$D0,$1A,$E2,$20,$9C,$DA             ; 00C717 ........ ????? ??
.byte $1A,$A9,$01,$8D,$DB,$1A,$60,$AD             ; 00C71F ........ ??????`?
.byte $E7,$18,$CD,$F5,$18,$B0,$0E,$22             ; 00C727 ........ ???????"
.byte $F3,$80,$03,$D0,$08,$A9,$01,$22             ; 00C72F ........ ???????"
.byte $64,$80,$03,$10,$03,$A9,$00,$60             ; 00C737 ........ d??????`
.byte $8C,$DE,$18,$EE,$C6,$06,$18,$AD             ; 00C73F ........ ????????
.byte $E7,$18,$69,$0A,$8D,$E7,$18,$22             ; 00C747 ........ ??i????"
.byte $94,$80,$03,$A9,$01,$9D,$D2,$06             ; 00C74F ........ ????????
.byte $A9,$50,$9D,$44,$07,$A9,$0C,$9D             ; 00C757 ........ ?P?D????
.byte $28,$08,$A9,$EE,$9D,$BC,$13,$AD             ; 00C75F ........ (???????
.byte $DE,$18,$0A,$09,$38,$9D,$B6,$07             ; 00C767 ........ ????8???
.byte $9D,$2E,$14,$A4,$10,$B9,$1E,$19             ; 00C76F ........ ?.??????
.byte $0A,$0A,$0A,$0A,$85,$04,$22,$95             ; 00C777 ........ ??????"?
.byte $CA,$0E,$29,$0F,$18,$65,$04,$A8             ; 00C77F ........ ??)??e??
.byte $B9,$DE,$C7,$9D,$BA,$0F,$A8,$B9             ; 00C787 ........ ????????
.byte $D8,$C7,$9D,$46,$0B,$B9,$DB,$C7             ; 00C78F ........ ???F????
.byte $9D,$9C,$0C,$BD,$BA,$0F,$D0,$10             ; 00C797 ........ ????????
.byte $A9,$01,$8D,$E4,$05,$8D,$E3,$05             ; 00C79F ........ ????????
.byte $A9,$14,$9D,$80,$0D,$4C,$C0,$C7             ; 00C7A7 ........ ?????L??
.byte $A8,$88,$A9,$01,$99,$36,$06,$A9             ; 00C7AF ........ ?????6??
.byte $01,$99,$34,$06,$A9,$10,$9D,$80             ; 00C7B7 ........ ??4?????
.byte $0D,$22,$95,$CA,$0E,$29,$07,$85             ; 00C7BF ........ ?"???)??
.byte $04,$22,$95,$CA,$0E,$29,$07,$18             ; 00C7C7 ........ ?"???)??
.byte $65,$04,$69,$08,$9D,$F2,$0D,$1A             ; 00C7CF ........ e?i?????
.byte $60,$80,$53,$AC,$14,$20,$20,$00             ; 00C7D7 ........ `?S??  ?
.byte $01,$02,$00,$01,$02,$00,$01,$02             ; 00C7DF ........ ????????
.byte $00,$01,$02,$00,$01,$02,$00,$00             ; 00C7E7 ........ ????????
.byte $01,$00,$01,$00,$01,$00,$01,$00             ; 00C7EF ........ ????????
.byte $01,$00,$01,$00,$01,$00,$01,$00             ; 00C7F7 ........ ????????
.byte $02,$00,$02,$00,$02,$00,$02,$00             ; 00C7FF ........ ????????
.byte $02,$00,$02,$00,$02,$00,$02,$00             ; 00C807 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00C80F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$02             ; 00C817 ........ ????????
.byte $02,$02,$02,$02,$02,$02,$02,$02             ; 00C81F ........ ????????
.byte $02,$02,$02,$02,$02,$02,$02,$A6             ; 00C827 ........ ????????
.byte $10,$BD,$17,$19,$8D,$F5,$18,$60             ; 00C82F ........ ???????`
.byte $AD,$E8,$18,$CD,$F6,$18,$B0,$53             ; 00C837 ........ ???????S
.byte $22,$F3,$80,$03,$D0,$4D,$EE,$C6             ; 00C83F ........ "????M??
.byte $06,$18,$AD,$E8,$18,$69,$06,$8D             ; 00C847 ........ ?????i??
.byte $E8,$18,$22,$94,$80,$03,$A9,$01             ; 00C84F ........ ??"?????
.byte $9D,$D2,$06,$20,$9D,$C3,$98,$9D             ; 00C857 ........ ??? ????
.byte $2C,$10,$D0,$08,$A9,$01,$8D,$E4             ; 00C85F ........ ,???????
.byte $05,$8D,$E3,$05,$A9,$5A,$9D,$44             ; 00C867 ........ ?????Z?D
.byte $07,$A9,$00,$9D,$28,$08,$A4,$10             ; 00C86F ........ ????(???
.byte $B9,$1E,$19,$9D,$9E,$10,$22,$95             ; 00C877 ........ ??????"?
.byte $CA,$0E,$29,$03,$D0,$09,$22,$95             ; 00C87F ........ ??)???"?
.byte $CA,$0E,$29,$07,$18,$69,$04,$9D             ; 00C887 ........ ??)??i??
.byte $BA,$0F,$60,$A9,$00,$60,$A6,$10             ; 00C88F ........ ??`??`??
.byte $BD,$17,$19,$8D,$F6,$18,$C2,$20             ; 00C897 ........ ??????? 
.byte $A9,$00,$B0,$8D,$CA,$1A,$A9,$00             ; 00C89F ........ ????????
.byte $02,$8D,$CC,$1A,$A9,$00,$B4,$8D             ; 00C8A7 ........ ????????
.byte $CE,$1A,$A9,$00,$02,$8D,$D0,$1A             ; 00C8AF ........ ????????
.byte $A9,$40,$F9,$8D,$D2,$1A,$A9,$80             ; 00C8B7 ........ ?@??????
.byte $01,$8D,$D4,$1A,$A9,$40,$FD,$8D             ; 00C8BF ........ ?????@??
.byte $D6,$1A,$A9,$80,$01,$8D,$D8,$1A             ; 00C8C7 ........ ????????
.byte $E2,$20,$A9,$01,$8D,$DA,$1A,$A9             ; 00C8CF ........ ? ??????
.byte $01,$8D,$DB,$1A,$20,$0B,$E3,$60             ; 00C8D7 ........ ???? ??`
.byte $AD,$E9,$18,$CD,$F7,$18,$B0,$0E             ; 00C8DF ........ ????????
.byte $22,$F3,$80,$03,$D0,$08,$A9,$01             ; 00C8E7 ........ "???????
.byte $22,$64,$80,$03,$10,$03,$A9,$00             ; 00C8EF ........ "d??????
.byte $60,$8C,$DA,$18,$EE,$C6,$06,$EE             ; 00C8F7 ........ `???????
.byte $E9,$18,$22,$94,$80,$03,$A9,$01             ; 00C8FF ........ ??"?????
.byte $9D,$D2,$06,$A9,$22,$9D,$44,$07             ; 00C907 ........ ????"?D?
.byte $A9,$0C,$9D,$28,$08,$A9,$66,$9D             ; 00C90F ........ ???(??f?
.byte $BC,$13,$AD,$DA,$18,$0A,$09,$38             ; 00C917 ........ ???????8
.byte $9D,$B6,$07,$9D,$2E,$14,$20,$9D             ; 00C91F ........ ????.? ?
.byte $C3,$98,$D0,$08,$A9,$01,$8D,$E4             ; 00C927 ........ ????????
.byte $05,$8D,$E3,$05,$98,$0A,$A8,$B9             ; 00C92F ........ ????????
.byte $99,$C9,$9D,$0C,$09,$B9,$9A,$C9             ; 00C937 ........ ????????
.byte $9D,$7E,$09,$B9,$A1,$C9,$9D,$F0             ; 00C93F ........ ?~??????
.byte $09,$B9,$A2,$C9,$9D,$62,$0A,$22             ; 00C947 ........ ?????b?"
.byte $95,$CA,$0E,$29,$07,$09,$80,$9D             ; 00C94F ........ ???)????
.byte $BA,$0F,$22,$95,$CA,$0E,$29,$07             ; 00C957 ........ ??"???)?
.byte $1A,$9D,$2C,$10,$22,$95,$CA,$0E             ; 00C95F ........ ??,?"???
.byte $29,$1F,$18,$69,$20,$9D,$80,$0D             ; 00C967 ........ )??i ???
.byte $22,$95,$CA,$0E,$29,$07,$9D,$9E             ; 00C96F ........ "???)???
.byte $10,$A9,$03,$9D,$10,$11,$A9,$03             ; 00C977 ........ ????????
.byte $9D,$4A,$13,$9E,$D8,$12,$22,$BC             ; 00C97F ........ ?J????"?
.byte $AE,$00,$98,$9D,$A0,$14,$A9,$01             ; 00C987 ........ ????????
.byte $99,$5E,$17,$22,$F1,$AE,$00,$A9             ; 00C98F ........ ?^?"????
.byte $01,$60,$00,$00,$80,$FF,$00,$00             ; 00C997 ........ ?`??????
.byte $80,$00,$80,$00,$00,$00,$80,$FF             ; 00C99F ........ ????????
.byte $00,$00,$A6,$10,$BD,$17,$19,$8D             ; 00C9A7 ........ ????????
.byte $F7,$18,$C2,$20,$A9,$00,$D2,$8D             ; 00C9AF ........ ??? ????
.byte $CA,$1A,$A9,$80,$01,$8D,$CC,$1A             ; 00C9B7 ........ ????????
.byte $A9,$00,$D6,$8D,$CE,$1A,$A9,$80             ; 00C9BF ........ ????????
.byte $01,$8D,$D0,$1A,$A9,$00,$D0,$8D             ; 00C9C7 ........ ????????
.byte $D2,$1A,$A9,$00,$02,$8D,$D4,$1A             ; 00C9CF ........ ????????
.byte $A9,$00,$D4,$8D,$D6,$1A,$A9,$00             ; 00C9D7 ........ ????????
.byte $02,$8D,$D8,$1A,$E2,$20,$A9,$01             ; 00C9DF ........ ????? ??
.byte $8D,$DA,$1A,$A9,$01,$8D,$DB,$1A             ; 00C9E7 ........ ????????
.byte $20,$93,$DE,$60                             ; 00C9F0 ....      ??`

  LDA.W $18EA                                     ; 00C9F3 AD EA 18 
  CMP.W $18F8                                     ; 00C9F6 CD F8 18 
  BCS.B B_CA19                                    ; 00C9F9 B0 1E 
  JSL L_AEBC                                      ; 00C9FB 22 BC AE 00 
  STY.B $06                                       ; 00C9FF 84 06 
  LDA.B #$01                                      ; 00CA01 A9 01 
  STA.W $175E,Y                                   ; 00CA03 99 5E 17 
  JSL L_AEBC                                      ; 00CA06 22 BC AE 00 
  STY.B $07                                       ; 00CA0A 84 07 
  LDY.B $06                                       ; 00CA0C A4 06 
  LDA.B #$00                                      ; 00CA0E A9 00 
  STA.W $175E,Y                                   ; 00CA10 99 5E 17 
  JSL L_380F3                                     ; 00CA13 22 F3 80 03 
  BEQ.B B_CA1C                                    ; 00CA17 F0 03 
B_CA19:
  LDA.B #$00                                      ; 00CA19 A9 00 
  RTS                                             ; 00CA1B 60 

B_CA1C:
  LDA.B #$0E                                      ; 00CA1C A9 0E 
  JSL L_38064                                     ; 00CA1E 22 64 80 03 
  BMI.B B_CA19                                    ; 00CA22 30 F5 
  STY.W $18E2                                     ; 00CA24 8C E2 18 
  STX.B $04                                       ; 00CA27 86 04 
  INC.W $06C6                                     ; 00CA29 EE C6 06 
  INC.W $18EA                                     ; 00CA2C EE EA 18 
  JSL L_38094                                     ; 00CA2F 22 94 80 03 
  LDA.B #$01                                      ; 00CA33 A9 01 
  STA.W EntityHeader,X                                   ; 00CA35 9D D2 06 
  LDA.B #$8C                                      ; 00CA38 A9 8C 
  STA.W EntityV1,X                                   ; 00CA3A 9D 44 07 
  LDA.B #$0C                                      ; 00CA3D A9 0C 
  STA.W EntityV3,X                                   ; 00CA3F 9D 28 08 
  LDA.W $18E2                                     ; 00CA42 AD E2 18 
  ASL                                             ; 00CA45 0A 
  ORA.B #$39                                      ; 00CA46 09 39 
  STA.W EntityV2,X                                   ; 00CA48 9D B6 07 
  JSL AdvanceRNG                                     ; 00CA4B 22 95 CA 0E 
  AND.B #$1F                                      ; 00CA4F 29 1F 
  ADC.B #$3C                                      ; 00CA51 69 3C 
  STA.W EntityV15,X                                   ; 00CA53 9D 80 0D 
  LDA.B #$FF                                      ; 00CA56 A9 FF 
  STA.W EntityV20,X                                   ; 00CA58 9D BA 0F 
  JSR.W L_C39D                                    ; 00CA5B 20 9D C3 
  STY.B $08                                       ; 00CA5E 84 08 
  TYA                                             ; 00CA60 98 
  BNE.B B_CA6B                                    ; 00CA61 D0 08 
  LDA.B #$01                                      ; 00CA63 A9 01 
  STA.W $05E4                                     ; 00CA65 8D E4 05 
  STA.W $05E3                                     ; 00CA68 8D E3 05 
B_CA6B:
  LDA.W D_CB25,Y                                  ; 00CA6B B9 25 CB 
  STA.W EntityV25,X                                   ; 00CA6E 9D F4 11 
  TYA                                             ; 00CA71 98 
  ASL                                             ; 00CA72 0A 
  TAY                                             ; 00CA73 A8 
  LDA.W D_CB29,Y                                  ; 00CA74 B9 29 CB 
  STA.W EntityV5,X                                   ; 00CA77 9D 0C 09 
  LDA.W D_CB2A,Y                                  ; 00CA7A B9 2A CB 
  STA.W EntityV6,X                                   ; 00CA7D 9D 7E 09 
  LDA.W D_CB31,Y                                  ; 00CA80 B9 31 CB 
  STA.W EntityV7,X                                   ; 00CA83 9D F0 09 
  LDA.W D_CB32,Y                                  ; 00CA86 B9 32 CB 
  STA.W EntityV8,X                                   ; 00CA89 9D 62 0A 
  LDY.B $07                                       ; 00CA8C A4 07 
  TYA                                             ; 00CA8E 98 
  STA.W EntityV31,X                                   ; 00CA8F 9D A0 14 
  LDA.B #$01                                      ; 00CA92 A9 01 
  STA.W $175E,Y                                   ; 00CA94 99 5E 17 
  JSL L_AED8                                      ; 00CA97 22 D8 AE 00 
  JSL L_380F3                                     ; 00CA9B 22 F3 80 03 
  BEQ.B B_CAA4                                    ; 00CA9F F0 03 

B_CAA1:
.byte $A9,$01,$60                                 ; 00CAA2 ...      ??`

B_CAA4:
  LDA.B #$0E                                      ; 00CAA4 A9 0E 
  JSL L_38064                                     ; 00CAA6 22 64 80 03 
  BMI.B B_CAA1                                    ; 00CAAA 30 F5 
  STY.W $18E2                                     ; 00CAAC 8C E2 18 
  JSL L_38094                                     ; 00CAAF 22 94 80 03 
  LDA.B #$01                                      ; 00CAB3 A9 01 
  STA.W EntityHeader,X                                   ; 00CAB5 9D D2 06 
  LDA.B #$95                                      ; 00CAB8 A9 95 
  STA.W EntityV1,X                                   ; 00CABA 9D 44 07 
  LDA.B #$00                                      ; 00CABD A9 00 
  STA.W EntityV3,X                                   ; 00CABF 9D 28 08 
  LDA.B $04                                       ; 00CAC2 A5 04 
  STA.W EntityV20,X                                   ; 00CAC4 9D BA 0F 
  JSL AdvanceRNG                                     ; 00CAC7 22 95 CA 0E 
  AND.B #$1F                                      ; 00CACB 29 1F 
  ADC.B #$3C                                      ; 00CACD 69 3C 
  STA.W EntityV15,X                                   ; 00CACF 9D 80 0D 
  JSL L_38059                                     ; 00CAD2 22 59 80 03 
  LDA.B #$01                                      ; 00CAD6 A9 01 
  STA.W $1AAF,Y                                   ; 00CAD8 99 AF 1A 
  LDA.W D_CB22,Y                                  ; 00CADB B9 22 CB 
  STA.W EntityV29,X                                   ; 00CADE 9D BC 13 
  TYA                                             ; 00CAE1 98 
  STA.W EntityV23,X                                   ; 00CAE2 9D 10 11 
  LDA.W $18E2                                     ; 00CAE5 AD E2 18 
  ASL                                             ; 00CAE8 0A 
  ORA.B #$39                                      ; 00CAE9 09 39 
  STA.W EntityV2,X                                   ; 00CAEB 9D B6 07 
  STA.W EntityV30,X                                   ; 00CAEE 9D 2E 14 
  LDY.B $06                                       ; 00CAF1 A4 06 
  TYA                                             ; 00CAF3 98 
  STA.W EntityV31,X                                   ; 00CAF4 9D A0 14 
  LDA.B #$01                                      ; 00CAF7 A9 01 
  STA.W $175E,Y                                   ; 00CAF9 99 5E 17 
  JSL L_AED8                                      ; 00CAFC 22 D8 AE 00 
  LDY.B $08                                       ; 00CB00 A4 08 
  LDA.W D_CB1E,Y                                  ; 00CB02 B9 1E CB 
  STA.W EntityV25,X                                   ; 00CB05 9D F4 11 
  PHB                                             ; 00CB08 8B 
  LDA.B #$03                                      ; 00CB09 A9 03 
  PHA                                             ; 00CB0B 48 
  PLB                                             ; 00CB0C AB 
  LDA.W EntityV23,X                                   ; 00CB0D BD 10 11 
  JSL L_3F032                                     ; 00CB10 22 32 F0 03 
  PLB                                             ; 00CB14 AB 
  LDY.B $04                                       ; 00CB15 A4 04 
  TXA                                             ; 00CB17 8A 
  STA.W EntityV20,Y                                   ; 00CB18 99 BA 0F 
  LDA.B #$01                                      ; 00CB1B A9 01 
  RTS                                             ; 00CB1D 60 


D_CB1E:
.byte $08,$0C,$00,$04                             ; 00CB1F D.DD     ????
D_CB22:
.byte $C4,$C8,$CC                                 ; 00CB23 .DD      ???
D_CB25:
.byte $04,$06,$00,$02                             ; 00CB26 D.DD     ????
D_CB29:
.byte $00                                         ; 00CB2A D        ?
D_CB2A:
.byte $00,$60,$FF,$00,$00,$A0,$00                 ; 00CB2B D..DDDD  ?`?????
D_CB31:
.byte $A0                                         ; 00CB32 D        ?
D_CB32:
.byte $00,$00,$00,$60,$FF,$00,$00                 ; 00CB33 D..DDDD  ???`???

  LDX.B $10                                       ; 00CB39 A6 10 
  LDA.W $1917,X                                   ; 00CB3B BD 17 19 
  STA.W $18F8                                     ; 00CB3E 8D F8 18 
  RTS                                             ; 00CB41 60 

  LDA.W $18EB                                     ; 00CB42 AD EB 18 
  CMP.W $18F9                                     ; 00CB45 CD F9 18 
  BCS.B B_CB58                                    ; 00CB48 B0 0E 
  JSL L_380F3                                     ; 00CB4A 22 F3 80 03 
  BNE.B B_CB58                                    ; 00CB4E D0 08 
  LDA.B #$02                                      ; 00CB50 A9 02 
  JSL L_38064                                     ; 00CB52 22 64 80 03 
  BPL.B B_CB5B                                    ; 00CB56 10 03 

B_CB58:
.byte $A9,$00,$60                                 ; 00CB59 ...      ??`

B_CB5B:
  STY.W $18DF                                     ; 00CB5B 8C DF 18 
  INC.W $06C6                                     ; 00CB5E EE C6 06 
  INC.W $18EB                                     ; 00CB61 EE EB 18 
  JSL L_38094                                     ; 00CB64 22 94 80 03 
  LDA.B #$01                                      ; 00CB68 A9 01 
  STA.W EntityHeader,X                                   ; 00CB6A 9D D2 06 
  LDA.B #$54                                      ; 00CB6D A9 54 
  STA.W EntityV1,X                                   ; 00CB6F 9D 44 07 
  LDA.B #$0C                                      ; 00CB72 A9 0C 
  STA.W EntityV3,X                                   ; 00CB74 9D 28 08 
  LDA.B #$0E                                      ; 00CB77 A9 0E 
  STA.W EntityV29,X                                   ; 00CB79 9D BC 13 
  LDA.W $18DF                                     ; 00CB7C AD DF 18 
  ASL                                             ; 00CB7F 0A 
  ORA.B #$38                                      ; 00CB80 09 38 
  STA.B $06                                       ; 00CB82 85 06 
  ORA.B #$01                                      ; 00CB84 09 01 
  STA.W EntityV30,X                                   ; 00CB86 9D 2E 14 
  JSL AdvanceRNG                                     ; 00CB89 22 95 CA 0E 
  AND.B #$01                                      ; 00CB8D 29 01 
  STA.W EntityV20,X                                   ; 00CB8F 9D BA 0F 
  JSR.W L_C39D                                    ; 00CB92 20 9D C3 
  TYA                                             ; 00CB95 98 
  BNE.B B_CBA0                                    ; 00CB96 D0 08 
  LDA.B #$01                                      ; 00CB98 A9 01 
  STA.W $05E4                                     ; 00CB9A 8D E4 05 
  STA.W $05E3                                     ; 00CB9D 8D E3 05 
B_CBA0:
  TYA                                             ; 00CBA0 98 
  ASL                                             ; 00CBA1 0A 
  TAY                                             ; 00CBA2 A8 
  LDA.W D_CC5F,Y                                  ; 00CBA3 B9 5F CC 
  STA.W EntityV5,X                                   ; 00CBA6 9D 0C 09 
  LDA.W D_CC60,Y                                  ; 00CBA9 B9 60 CC 
  STA.W EntityV6,X                                   ; 00CBAC 9D 7E 09 
  LDA.W D_CC67,Y                                  ; 00CBAF B9 67 CC 
  STA.W EntityV7,X                                   ; 00CBB2 9D F0 09 
  LDA.W D_CC68,Y                                  ; 00CBB5 B9 68 CC 
  STA.W EntityV8,X                                   ; 00CBB8 9D 62 0A 
  LDA.W XexzyCharX,X                              ; 00CBBB BD 46 0B 
  STA.B $04                                       ; 00CBBE 85 04 
  LDA.W EntityYPx,X                                   ; 00CBC0 BD 9C 0C 
  STA.B $05                                       ; 00CBC3 85 05 
  STX.B $07                                       ; 00CBC5 86 07 
  JSL L_AEBC                                      ; 00CBC7 22 BC AE 00 
  TYA                                             ; 00CBCB 98 
  STA.W EntityV31,X                                   ; 00CBCC 9D A0 14 
  LDA.B #$01                                      ; 00CBCF A9 01 
  STA.W $175E,Y                                   ; 00CBD1 99 5E 17 
  JSL L_AEF1                                      ; 00CBD4 22 F1 AE 00 
  LDA.B #$01                                      ; 00CBD8 A9 01 
  STA.B $08                                       ; 00CBDA 85 08 
B_CBDC:
  JSL L_380F3                                     ; 00CBDC 22 F3 80 03 
  BEQ.B B_CBE5                                    ; 00CBE0 F0 03 

.byte $A9,$01,$60                                 ; 00CBE3 ...      ??`

B_CBE5:
  INC.W $06C6                                     ; 00CBE5 EE C6 06 
  PHX                                             ; 00CBE8 DA 
  LDX.W $18DF                                     ; 00CBE9 AE DF 18 
  INC.W $18C5,X                                   ; 00CBEC FE C5 18 
  PLX                                             ; 00CBEF FA 
  JSL L_38094                                     ; 00CBF0 22 94 80 03 
  LDA.B #$01                                      ; 00CBF4 A9 01 
  STA.W EntityHeader,X                                   ; 00CBF6 9D D2 06 
  LDA.B #$55                                      ; 00CBF9 A9 55 
  STA.W EntityV1,X                                   ; 00CBFB 9D 44 07 
  LDA.B #$0C                                      ; 00CBFE A9 0C 
  STA.W EntityV3,X                                   ; 00CC00 9D 28 08 
  LDA.B #$4A                                      ; 00CC03 A9 4A 
  STA.W EntityV29,X                                   ; 00CC05 9D BC 13 
  LDA.B $06                                       ; 00CC08 A5 06 
  ORA.B #$01                                      ; 00CC0A 09 01 
  STA.W EntityV30,X                                   ; 00CC0C 9D 2E 14 
  LDA.B $04                                       ; 00CC0F A5 04 
  STA.W XexzyCharX,X                              ; 00CC11 9D 46 0B 
  LDA.B $05                                       ; 00CC14 A5 05 
  STA.W EntityYPx,X                                   ; 00CC16 9D 9C 0C 
  LDA.B $07                                       ; 00CC19 A5 07 
  STA.W EntityV20,X                                   ; 00CC1B 9D BA 0F 
  LDA.B #$01                                      ; 00CC1E A9 01 
  STA.W EntityV15,X                                   ; 00CC20 9D 80 0D 
  JSL AdvanceRNG                                     ; 00CC23 22 95 CA 0E 
  AND.B #$0F                                      ; 00CC27 29 0F 
  ASL                                             ; 00CC29 0A 
  TAY                                             ; 00CC2A A8 
  LDA.W D_CC6F,Y                                  ; 00CC2B B9 6F CC 
  STA.W EntityV5,X                                   ; 00CC2E 9D 0C 09 
  LDA.W D_CC70,Y                                  ; 00CC31 B9 70 CC 
  STA.W EntityV6,X                                   ; 00CC34 9D 7E 09 
  LDA.W D_CC8F,Y                                  ; 00CC37 B9 8F CC 
  STA.W EntityV7,X                                   ; 00CC3A 9D F0 09 
  LDA.W D_CC90,Y                                  ; 00CC3D B9 90 CC 
  STA.W EntityV8,X                                   ; 00CC40 9D 62 0A 
  JSL L_AEBC                                      ; 00CC43 22 BC AE 00 
  TYA                                             ; 00CC47 98 
  STA.W EntityV31,X                                   ; 00CC48 9D A0 14 
  LDA.B #$01                                      ; 00CC4B A9 01 
  STA.W $175E,Y                                   ; 00CC4D 99 5E 17 
  JSL L_AEF1                                      ; 00CC50 22 F1 AE 00 
  INC.B $08                                       ; 00CC54 E6 08 
  LDA.B $08                                       ; 00CC56 A5 08 
  CMP.B #$14                                      ; 00CC58 C9 14 
  BCC.B B_CBDC                                    ; 00CC5A 90 80 
  LDA.B #$01                                      ; 00CC5C A9 01 
  RTS                                             ; 00CC5E 60 


D_CC5F:
.byte $00                                         ; 00CC60 D        ?
D_CC60:
.byte $00,$00,$FF,$00,$00,$00,$01                 ; 00CC61 D..DD..  ???????
D_CC67:
.byte $00                                         ; 00CC68 D        ?
D_CC68:
.byte $01,$00,$00,$00,$FF,$00,$00                 ; 00CC69 D..DD..  ???????
D_CC6F:
.byte $10                                         ; 00CC70 D        ?
D_CC70:
.byte $00,$80,$01,$80,$01,$80,$01,$10             ; 00CC70 DDDDDDDD ????????
.byte $00,$80,$FE,$80,$FE,$80,$FE,$F0             ; 00CC78 DDDDDDDD ????????
.byte $FF,$C0,$00,$C0,$00,$C0,$00,$F0             ; 00CC80 DDDDDDDD ????????
.byte $FF,$40,$FF,$40,$FF,$40,$FF                 ; 00CC89 DDDDDDD  ?@?@?@?
D_CC8F:
.byte $80                                         ; 00CC90 D        ?
D_CC90:
.byte $FE,$80,$FE,$F0,$FF,$80,$01,$80             ; 00CC90 DDDDDDDD ????????
.byte $01,$80,$01,$F0,$FF,$80,$FE,$40             ; 00CC98 DDDDDDDD ???????@
.byte $FF,$40,$FF,$10,$00,$C0,$00,$C0             ; 00CCA0 DDDDDDDD ?@??????
.byte $00,$C0,$00,$10,$00,$40,$FF                 ; 00CCA9 DDDDDDD  ?????@?

  LDX.B $10                                       ; 00CCAF A6 10 
  LDA.W $1917,X                                   ; 00CCB1 BD 17 19 
  STA.W $18F9                                     ; 00CCB4 8D F9 18 
  RTS                                             ; 00CCB7 60 

  LDA.W $18EC                                     ; 00CCB8 AD EC 18 
  CMP.W $18FA                                     ; 00CCBB CD FA 18 
  BCS.B B_CCC6                                    ; 00CCBE B0 06 
  JSL L_380F3                                     ; 00CCC0 22 F3 80 03 
  BEQ.B B_CCC9                                    ; 00CCC4 F0 03 
B_CCC6:
  LDA.B #$00                                      ; 00CCC6 A9 00 
  RTS                                             ; 00CCC8 60 

B_CCC9:
  INC.W $06C6                                     ; 00CCC9 EE C6 06 
  INC.W $18EC                                     ; 00CCCC EE EC 18 
  JSL L_38094                                     ; 00CCCF 22 94 80 03 
  LDA.B #$01                                      ; 00CCD3 A9 01 
  STA.W EntityHeader,X                                   ; 00CCD5 9D D2 06 
  LDA.B #$2C                                      ; 00CCD8 A9 2C 
  STA.W EntityV1,X                                   ; 00CCDA 9D 44 07 
  LDA.B #$0C                                      ; 00CCDD A9 0C 
  STA.W EntityV3,X                                   ; 00CCDF 9D 28 08 
  LDA.B #$20                                      ; 00CCE2 A9 20 
  STA.W EntityV21,X                                   ; 00CCE4 9D 2C 10 
  LDY.B $10                                       ; 00CCE7 A4 10 
  LDA.W $191E,Y                                   ; 00CCE9 B9 1E 19 
  STA.B $04                                       ; 00CCEC 85 04 
  BEQ.B B_CCF3                                    ; 00CCEE F0 03 

.byte $9E,$2C,$10                                 ; 00CCF1 ...      ?,?

B_CCF3:
  LDA.B #$7F                                      ; 00CCF3 A9 7F 
  STA.W EntityV22,X                                   ; 00CCF5 9D 9E 10 
  LDA.W $188E                                     ; 00CCF8 AD 8E 18 
  BEQ.B B_CD0B                                    ; 00CCFB F0 0E 

.byte $A9,$80,$9D,$46,$0B,$A9,$06,$9D             ; 00CCFD ........ ???F????
.byte $9C,$0C,$A0,$00,$80,$03                     ; 00CD06 ......   ??????

B_CD0B:
  JSR.W L_C39D                                    ; 00CD0B 20 9D C3 
  TYA                                             ; 00CD0E 98 
  BNE.B B_CD19                                    ; 00CD0F D0 08 
  LDA.B #$01                                      ; 00CD11 A9 01 
  STA.W $05E4                                     ; 00CD13 8D E4 05 
  STA.W $05E3                                     ; 00CD16 8D E3 05 
B_CD19:
  LDA.B $04                                       ; 00CD19 A5 04 
  BEQ.B B_CD23                                    ; 00CD1B F0 06 

.byte $22,$95,$CA,$0E,$29,$7F                     ; 00CD1E ......   "???)?

B_CD23:
  CLC                                             ; 00CD23 18 
  ADC.W D_CD93,Y                                  ; 00CD24 79 93 CD 
  STA.W EntityV15,X                                   ; 00CD27 9D 80 0D 
  LDA.W D_CD7B,Y                                  ; 00CD2A B9 7B CD 
  STA.W EntityV29,X                                   ; 00CD2D 9D BC 13 
  LDA.B #$26                                      ; 00CD30 A9 26 
  STA.W EntityV2,X                                   ; 00CD32 9D B6 07 
  ORA.W D_CD7F,Y                                  ; 00CD35 19 7F CD 
  STA.W EntityV30,X                                   ; 00CD38 9D 2E 14 
  TYA                                             ; 00CD3B 98 
  STA.W EntityV20,X                                   ; 00CD3C 9D BA 0F 
  ASL                                             ; 00CD3F 0A 
  TAY                                             ; 00CD40 A8 
  LDA.W D_CD83,Y                                  ; 00CD41 B9 83 CD 
  STA.W EntityV5,X                                   ; 00CD44 9D 0C 09 
  LDA.W D_CD84,Y                                  ; 00CD47 B9 84 CD 
  STA.W EntityV6,X                                   ; 00CD4A 9D 7E 09 
  LDA.W D_CD8B,Y                                  ; 00CD4D B9 8B CD 
  STA.W EntityV7,X                                   ; 00CD50 9D F0 09 
  LDA.W D_CD8C,Y                                  ; 00CD53 B9 8C CD 
  STA.W EntityV8,X                                   ; 00CD56 9D 62 0A 
  LDA.W $1514                                     ; 00CD59 AD 14 15 
  ORA.W $1515                                     ; 00CD5C 0D 15 15 
  BEQ.B B_CD67                                    ; 00CD5F F0 06 
  JSL L_AEAF                                      ; 00CD61 22 AF AE 00 
  BRA.B B_CD6B                                    ; 00CD65 80 04 
B_CD67:
  JSL L_AEBC                                      ; 00CD67 22 BC AE 00 
B_CD6B:
  TYA                                             ; 00CD6B 98 
  STA.W EntityV31,X                                   ; 00CD6C 9D A0 14 
  LDA.B #$01                                      ; 00CD6F A9 01 
  STA.W $175E,Y                                   ; 00CD71 99 5E 17 
  JSL L_AEF1                                      ; 00CD74 22 F1 AE 00 
  LDA.B #$01                                      ; 00CD78 A9 01 
  RTS                                             ; 00CD7A 60 


D_CD7B:
.byte $EC,$EA,$E8,$EA                             ; 00CD7C DDDD     ????
D_CD7F:
.byte $00,$40,$00,$00                             ; 00CD80 DDDD     ?@??
D_CD83:
.byte $00                                         ; 00CD84 D        ?
D_CD84:
.byte $00,$C0,$FF,$00,$00,$40,$00                 ; 00CD85 DDDDDDD  ?????@?
D_CD8B:
.byte $40                                         ; 00CD8C D        @
D_CD8C:
.byte $00,$00,$00,$C0,$FF,$00,$00                 ; 00CD8D DDDDDDD  ???????
D_CD93:
.byte $50,$32,$1E,$32                             ; 00CD94 DDDD     P2?2

  LDX.B $10                                       ; 00CD97 A6 10 
  LDA.W $1917,X                                   ; 00CD99 BD 17 19 
  STA.W $18FA                                     ; 00CD9C 8D FA 18 
  JSR.W L_DFA7                                    ; 00CD9F 20 A7 DF 
  RTS                                             ; 00CDA2 60 


.byte $AD,$ED,$18,$CD,$FB,$18,$B0,$06             ; 00CDA3 ........ ????????
.byte $22,$F3,$80,$03,$F0,$03,$A9,$00             ; 00CDAB ........ "???????
.byte $60,$A9,$04,$22,$64,$80,$03,$30             ; 00CDB3 ........ `??"d??0
.byte $F5,$8C,$D9,$18,$EE,$C6,$06,$EE             ; 00CDBB ........ ????????
.byte $ED,$18,$22,$94,$80,$03,$A9,$01             ; 00CDC3 ........ ??"?????
.byte $9D,$D2,$06,$A9,$1F,$9D,$44,$07             ; 00CDCB ........ ??????D?
.byte $A9,$0C,$9D,$28,$08,$A9,$E0,$9D             ; 00CDD3 ........ ???(????
.byte $BC,$13,$AD,$D9,$18,$0A,$09,$38             ; 00CDDB ........ ???????8
.byte $9D,$B6,$07,$9D,$2E,$14,$20,$9D             ; 00CDE3 ........ ????.? ?
.byte $C3,$98,$D0,$08,$A9,$01,$8D,$E4             ; 00CDEB ........ ????????
.byte $05,$8D,$E3,$05,$98,$0A,$A8,$B9             ; 00CDF3 ........ ????????
.byte $3C,$CE,$9D,$0C,$09,$B9,$3D,$CE             ; 00CDFB ........ <?????=?
.byte $9D,$7E,$09,$B9,$44,$CE,$9D,$F0             ; 00CE03 ........ ?~??D???
.byte $09,$B9,$45,$CE,$9D,$62,$0A,$A9             ; 00CE0B ........ ??E??b??
.byte $01,$9D,$80,$0D,$22,$95,$CA,$0E             ; 00CE13 ........ ????"???
.byte $29,$01,$9D,$BA,$0F,$A9,$03,$9D             ; 00CE1B ........ )???????
.byte $4A,$13,$9E,$D8,$12,$22,$BC,$AE             ; 00CE23 ........ J????"??
.byte $00,$98,$9D,$A0,$14,$A9,$01,$99             ; 00CE2B ........ ????????
.byte $5E,$17,$22,$F1,$AE,$00,$A9,$01             ; 00CE33 ........ ^?"?????
.byte $60,$00,$00,$80,$FF,$00,$00,$80             ; 00CE3B ........ `???????
.byte $00,$80,$00,$00,$00,$80,$FF,$00             ; 00CE43 ........ ????????
.byte $00,$A6,$10,$BD,$17,$19,$8D,$FB             ; 00CE4B ........ ????????
.byte $18,$60,$AD,$EE,$18,$CD,$FC,$18             ; 00CE53 ........ ?`??????
.byte $B0,$06,$22,$F3,$80,$03,$F0,$03             ; 00CE5B ........ ??"?????
.byte $A9,$00,$60,$A9,$02,$22,$64,$80             ; 00CE63 ........ ??`??"d?
.byte $03,$30,$F5,$8C,$DC,$18,$EE,$C6             ; 00CE6B ........ ?0??????
.byte $06,$EE,$EE,$18,$22,$94,$80,$03             ; 00CE73 ........ ????"???
.byte $A9,$01,$9D,$D2,$06,$A9,$28,$9D             ; 00CE7B ........ ??????(?
.byte $44,$07,$A9,$0C,$9D,$28,$08,$A9             ; 00CE83 ........ D????(??
.byte $E2,$9D,$BC,$13,$AD,$DC,$18,$0A             ; 00CE8B ........ ????????
.byte $09,$38,$9D,$B6,$07,$9D,$2E,$14             ; 00CE93 ........ ?8????.?
.byte $20,$9D,$C3,$98,$D0,$08,$A9,$01             ; 00CE9B ........  ???????
.byte $8D,$E4,$05,$8D,$E3,$05,$98,$0A             ; 00CEA3 ........ ????????
.byte $A8,$B9,$EE,$CE,$9D,$0C,$09,$B9             ; 00CEAB ........ ????????
.byte $EF,$CE,$9D,$7E,$09,$B9,$F6,$CE             ; 00CEB3 ........ ???~????
.byte $9D,$F0,$09,$B9,$F7,$CE,$9D,$62             ; 00CEBB ........ ???????b
.byte $0A,$A9,$01,$9D,$80,$0D,$22,$95             ; 00CEC3 ........ ??????"?
.byte $CA,$0E,$29,$01,$9D,$BA,$0F,$A9             ; 00CECB ........ ??)?????
.byte $03,$9D,$4A,$13,$9E,$D8,$12,$22             ; 00CED3 ........ ??J????"
.byte $BC,$AE,$00,$98,$9D,$A0,$14,$A9             ; 00CEDB ........ ????????
.byte $01,$99,$5E,$17,$22,$F1,$AE,$00             ; 00CEE3 ........ ??^?"???
.byte $A9,$01,$60,$00,$00,$80,$FF,$00             ; 00CEEB ........ ??`?????
.byte $00,$80,$00,$80,$00,$00,$00,$80             ; 00CEF3 ........ ????????
.byte $FF,$00,$00,$A6,$10,$BD,$17,$19             ; 00CEFB ........ ????????
.byte $8D,$FC,$18,$60,$AD,$EF,$18,$CD             ; 00CF03 ........ ???`????
.byte $FD,$18,$B0,$7C,$22,$F3,$80,$03             ; 00CF0B ........ ???|"???
.byte $D0,$76,$22,$95,$CA,$0E,$29,$03             ; 00CF13 ........ ?v"???)?
.byte $D0,$09,$A9,$FF,$85,$05,$A9,$32             ; 00CF1B ........ ???????2
.byte $4C,$3F,$CF,$A8,$B9,$8E,$CF,$85             ; 00CF23 ........ L???????
.byte $05,$A8,$B9,$9E,$CF,$22,$64,$80             ; 00CF2B ........ ?????"d?
.byte $03,$30,$55,$98,$A4,$05,$99,$D6             ; 00CF33 ........ ?0U?????
.byte $18,$0A,$09,$38,$85,$04,$EE,$C6             ; 00CF3B ........ ???8????
.byte $06,$EE,$EF,$18,$22,$94,$80,$03             ; 00CF43 ........ ????"???
.byte $A9,$01,$9D,$D2,$06,$A9,$00,$9D             ; 00CF4B ........ ????????
.byte $28,$08,$A5,$05,$9D,$9E,$10,$20             ; 00CF53 ........ (?????? 
.byte $9D,$C3,$98,$9D,$2C,$10,$D0,$08             ; 00CF5B ........ ????,???
.byte $A9,$01,$8D,$E4,$05,$8D,$E3,$05             ; 00CF63 ........ ????????
.byte $A5,$04,$9D,$B6,$07,$A4,$10,$B9             ; 00CF6B ........ ????????
.byte $1E,$19,$4A,$9D,$10,$11,$A9,$1A             ; 00CF73 ........ ??J?????
.byte $9D,$44,$07,$22,$95,$CA,$0E,$29             ; 00CF7B ........ ?D?"???)
.byte $07,$18,$69,$04,$9D,$BA,$0F,$60             ; 00CF83 ........ ??i????`
.byte $A9,$00,$60,$00,$01,$02,$00,$01             ; 00CF8B ........ ??`?????
.byte $02,$00,$01,$02,$00,$01,$02,$00             ; 00CF93 ........ ????????
.byte $01,$02,$00,$02,$03,$04,$A6,$10             ; 00CF9B ........ ????????
.byte $BD,$17,$19,$8D,$FD,$18,$C2,$20             ; 00CFA3 ........ ??????? 
.byte $A9,$00,$CA,$8D,$CA,$1A,$A9,$40             ; 00CFAB ........ ???????@
.byte $01,$8D,$CC,$1A,$A9,$00,$CE,$8D             ; 00CFB3 ........ ????????
.byte $CE,$1A,$A9,$40,$01,$8D,$D0,$1A             ; 00CFBB ........ ???@????
.byte $A9,$00,$C8,$8D,$D2,$1A,$A9,$00             ; 00CFC3 ........ ????????
.byte $02,$8D,$D4,$1A,$A9,$00,$CC,$8D             ; 00CFCB ........ ????????
.byte $D6,$1A,$A9,$00,$02,$8D,$D8,$1A             ; 00CFD3 ........ ????????
.byte $E2,$20,$A9,$01,$8D,$DA,$1A,$A9             ; 00CFDB ........ ? ??????
.byte $01,$8D,$DB,$1A,$20,$5C,$DD,$60             ; 00CFE3 ........ ???? \?`
.byte $AD,$F0,$18,$CD,$FE,$18,$B0,$06             ; 00CFEB ........ ????????
.byte $22,$F3,$80,$03,$F0,$03,$A9,$00             ; 00CFF3 ........ "???????
.byte $60,$A9,$0F,$22,$64,$80,$03,$30             ; 00CFFB ........ `??"d??0
.byte $F5,$8C,$DD,$18,$98,$0A,$09,$38             ; 00D003 ........ ???????8
.byte $85,$09,$86,$08,$22,$94,$80,$03             ; 00D00B ........ ????"???
.byte $A9,$01,$9D,$D2,$06,$A9,$29,$9D             ; 00D013 ........ ??????)?
.byte $44,$07,$A9,$0C,$9D,$28,$08,$A9             ; 00D01B ........ D????(??
.byte $CE,$9D,$BC,$13,$A5,$09,$9D,$B6             ; 00D023 ........ ????????
.byte $07,$9D,$2E,$14,$20,$9D,$C3,$98             ; 00D02B ........ ??.? ???
.byte $D0,$08,$A9,$01,$8D,$E4,$05,$8D             ; 00D033 ........ ????????
.byte $E3,$05,$98,$0A,$A8,$B9,$02,$D1             ; 00D03B ........ ????????
.byte $9D,$0C,$09,$B9,$03,$D1,$9D,$7E             ; 00D043 ........ ???????~
.byte $09,$B9,$0A,$D1,$9D,$F0,$09,$B9             ; 00D04B ........ ????????
.byte $0B,$D1,$9D,$62,$0A,$BD,$46,$0B             ; 00D053 ........ ???b??F?
.byte $85,$06,$BD,$9C,$0C,$85,$07,$A9             ; 00D05B ........ ????????
.byte $01,$9D,$80,$0D,$22,$95,$CA,$0E             ; 00D063 ........ ????"???
.byte $29,$01,$9D,$BA,$0F,$A9,$FF,$9D             ; 00D06B ........ )???????
.byte $2C,$10,$A9,$03,$9D,$4A,$13,$9E             ; 00D073 ........ ,????J??
.byte $D8,$12,$22,$BC,$AE,$00,$98,$9D             ; 00D07B ........ ??"?????
.byte $A0,$14,$A9,$01,$99,$5E,$17,$22             ; 00D083 ........ ?????^?"
.byte $F1,$AE,$00,$A2,$03,$86,$04,$22             ; 00D08B ........ ???????"
.byte $F3,$80,$03,$D0,$61,$22,$94,$80             ; 00D093 ........ ????a"??
.byte $03,$A9,$01,$9D,$D2,$06,$A9,$0C             ; 00D09B ........ ????????
.byte $9D,$28,$08,$A9,$2A,$9D,$44,$07             ; 00D0A3 ........ ?(??*?D?
.byte $A9,$CE,$9D,$BC,$13,$A5,$09,$9D             ; 00D0AB ........ ????????
.byte $B6,$07,$9D,$2E,$14,$A5,$06,$9D             ; 00D0B3 ........ ???.????
.byte $46,$0B,$A5,$07,$9D,$9C,$0C,$8A             ; 00D0BB ........ F???????
.byte $29,$07,$1A,$9D,$80,$0D,$A5,$08             ; 00D0C3 ........ )???????
.byte $9D,$BA,$0F,$A9,$FF,$9D,$2C,$10             ; 00D0CB ........ ??????,?
.byte $8A,$A4,$08,$99,$2C,$10,$86,$08             ; 00D0D3 ........ ????,???
.byte $A9,$03,$9D,$4A,$13,$9E,$D8,$12             ; 00D0DB ........ ???J????
.byte $22,$BC,$AE,$00,$98,$9D,$A0,$14             ; 00D0E3 ........ "???????
.byte $A9,$01,$99,$5E,$17,$22,$F1,$AE             ; 00D0EB ........ ???^?"??
.byte $00,$A6,$04,$CA,$D0,$97,$EE,$F0             ; 00D0F3 ........ ????????
.byte $18,$EE,$C6,$06,$A9,$01,$60,$00             ; 00D0FB ........ ??????`?
.byte $00,$80,$FF,$00,$00,$80,$00,$80             ; 00D103 ........ ????????
.byte $00,$00,$00,$80,$FF,$00,$00,$A6             ; 00D10B ........ ????????
.byte $10,$BD,$17,$19,$8D,$FE,$18,$60             ; 00D113 ........ ???????`

  RTS                                             ; 00D11B 60 

  LDA.W CurrentRound                                     ; 00D11C AD AB 05 
  ASL                                             ; 00D11F 0A 
  TAX                                             ; 00D120 AA 
  LDA.W D_C29C,X                                  ; 00D121 BD 9C C2 
  STA.B $04                                       ; 00D124 85 04 
  LDA.W D_C29D,X                                  ; 00D126 BD 9D C2 
  STA.B $05                                       ; 00D129 85 05 
  LDA.W CurrentRoom                                     ; 00D12B AD AC 05 
  ASL                                             ; 00D12E 0A 
  TAY                                             ; 00D12F A8 
  LDA.B ($04),Y                                   ; 00D130 B1 04 
  STA.B $06                                       ; 00D132 85 06 
  INY                                             ; 00D134 C8 
  LDA.B ($04),Y                                   ; 00D135 B1 04 
  STA.B $07                                       ; 00D137 85 07 
  LDX.B $10                                       ; 00D139 A6 10 
  LDA.W $1909,X                                   ; 00D13B BD 09 19 
  STZ.B $04                                       ; 00D13E 64 04 
  STA.B $05                                       ; 00D140 85 05 
B_D142:
  JSL L_380F3                                     ; 00D142 22 F3 80 03 
  JSL L_38094                                     ; 00D146 22 94 80 03 
  LDA.B #$01                                      ; 00D14A A9 01 
  STA.W EntityHeader,X                                   ; 00D14C 9D D2 06 
  LDA.B #$0F                                      ; 00D14F A9 0F 
  STA.W EntityV1,X                                   ; 00D151 9D 44 07 
  LDA.B #$00                                      ; 00D154 A9 00 
  STA.W EntityV3,X                                   ; 00D156 9D 28 08 
  LDA.B #$AC                                      ; 00D159 A9 AC 
  STA.W EntityV29,X                                   ; 00D15B 9D BC 13 
  LDA.B #$24                                      ; 00D15E A9 24 
  STA.W EntityV30,X                                   ; 00D160 9D 2E 14 
  JSL L_AEAF                                      ; 00D163 22 AF AE 00 
  TYA                                             ; 00D167 98 
  STA.W EntityV31,X                                   ; 00D168 9D A0 14 
  LDA.B #$01                                      ; 00D16B A9 01 
  STA.W $175E,Y                                   ; 00D16D 99 5E 17 
  JSL L_AEF1                                      ; 00D170 22 F1 AE 00 
  LDY.B #$00                                      ; 00D174 A0 00 
  LDA.B ($06),Y                                   ; 00D176 B1 06 
  STA.W XexzyCharX,X                              ; 00D178 9D 46 0B 
  INY                                             ; 00D17B C8 
  LDA.B ($06),Y                                   ; 00D17C B1 06 
  STA.W EntityYPx,X                                   ; 00D17E 9D 9C 0C 
  TXY                                             ; 00D181 9B 
  LDX.W $06C7                                     ; 00D182 AE C7 06 
  LDA.L D_C559,X                                  ; 00D185 BF 59 C5 00 
  STA.W EntityV11,Y                                   ; 00D189 99 B8 0B 
  LDA.L D_C55C,X                                  ; 00D18C BF 5C C5 00 
  STA.W EntityV14,Y                                   ; 00D190 99 0E 0D 
  CLC                                             ; 00D193 18 
  LDA.B $06                                       ; 00D194 A5 06 
  ADC.B #$02                                      ; 00D196 69 02 
  STA.B $06                                       ; 00D198 85 06 
  BCC.B B_D19E                                    ; 00D19A 90 02 

.byte $E6,$07                                     ; 00D19D ..       ??

B_D19E:
  INC.B $04                                       ; 00D19E E6 04 
  DEC.B $05                                       ; 00D1A0 C6 05 
  BNE.B B_D142                                    ; 00D1A2 D0 9E 
  RTS                                             ; 00D1A4 60 


.byte $60,$A9,$01,$A0,$70,$8C,$12,$15             ; 00D1A5 ........ `???p???
.byte $99,$5E,$17,$99,$5F,$17,$A9,$01             ; 00D1AD ........ ?^??_???
.byte $A0,$72,$8C,$13,$15,$99,$5E,$17             ; 00D1B5 ........ ?r????^?
.byte $99,$5F,$17,$A9,$01,$8D,$14,$15             ; 00D1BD ........ ?_??????
.byte $8D,$15,$15,$9C,$9A,$06,$9C,$9B             ; 00D1C5 ........ ????????
.byte $06,$9C,$9C,$06,$A9,$44,$85,$08             ; 00D1CD ........ ?????D??
.byte $A9,$56,$85,$09,$64,$0A,$20,$00             ; 00D1D5 ........ ?V??d? ?
.byte $D2,$A9,$BC,$85,$08,$A9,$56,$85             ; 00D1DD ........ ??????V?
.byte $09,$A9,$01,$85,$0A,$20,$00,$D2             ; 00D1E5 ........ ????? ??
.byte $20,$21,$D3,$18,$AD,$C6,$06,$69             ; 00D1ED ........  !?????i
.byte $02,$8D,$C6,$06,$EE,$00,$19,$EE             ; 00D1F5 ........ ????????
.byte $00,$19,$60,$22,$F3,$80,$03,$A9             ; 00D1FD ........ ??`"????
.byte $0C,$22,$64,$80,$03,$8C,$E0,$18             ; 00D205 ........ ?"d?????
.byte $98,$0A,$09,$28,$85,$06,$22,$94             ; 00D20D ........ ???(??"?
.byte $80,$03,$A9,$41,$9D,$D2,$06,$A9             ; 00D215 ........ ???A????
.byte $64,$9D,$44,$07,$A9,$0C,$9D,$28             ; 00D21D ........ d?D????(
.byte $08,$A5,$06,$9D,$B6,$07,$A9,$00             ; 00D225 ........ ????????
.byte $9D,$F4,$11,$A9,$1E,$9D,$4A,$13             ; 00D22D ........ ??????J?
.byte $A5,$08,$9D,$46,$0B,$A5,$09,$9D             ; 00D235 ........ ???F????
.byte $9C,$0C,$A9,$82,$9D,$80,$0D,$22             ; 00D23D ........ ???????"
.byte $95,$CA,$0E,$29,$3F,$69,$82,$9D             ; 00D245 ........ ???)?i??
.byte $F2,$0D,$A5,$0A,$9D,$82,$11,$86             ; 00D24D ........ ????????
.byte $07,$22,$A0,$AE,$00,$98,$85,$04             ; 00D255 ........ ?"??????
.byte $9D,$A0,$14,$A9,$01,$99,$5E,$17             ; 00D25D ........ ??????^?
.byte $22,$F1,$AE,$00,$22,$A0,$AE,$00             ; 00D265 ........ "???"???
.byte $98,$A6,$04,$85,$04,$9D,$DE,$17             ; 00D26D ........ ????????
.byte $A9,$01,$99,$5E,$17,$22,$F1,$AE             ; 00D275 ........ ???^?"??
.byte $00,$22,$A0,$AE,$00,$98,$A6,$04             ; 00D27D ........ ?"??????
.byte $85,$04,$9D,$DE,$17,$A9,$01,$99             ; 00D285 ........ ????????
.byte $5E,$17,$22,$F1,$AE,$00,$22,$A0             ; 00D28D ........ ^?"???"?
.byte $AE,$00,$98,$A6,$04,$85,$04,$9D             ; 00D295 ........ ????????
.byte $DE,$17,$A9,$01,$99,$5E,$17,$22             ; 00D29D ........ ?????^?"
.byte $F1,$AE,$00,$A0,$11,$5A,$22,$F3             ; 00D2A5 ........ ?????Z"?
.byte $80,$03,$A9,$0B,$22,$64,$80,$03             ; 00D2AD ........ ????"d??
.byte $8C,$E1,$18,$98,$0A,$09,$28,$85             ; 00D2B5 ........ ??????(?
.byte $06,$22,$94,$80,$03,$A9,$01,$9D             ; 00D2BD ........ ?"??????
.byte $D2,$06,$A9,$65,$9D,$44,$07,$A9             ; 00D2C5 ........ ???e?D??
.byte $04,$9D,$28,$08,$A9,$6C,$9D,$BC             ; 00D2CD ........ ??(??l??
.byte $13,$A5,$06,$09,$01,$9D,$B6,$07             ; 00D2D5 ........ ????????
.byte $9D,$2E,$14,$A5,$08,$9D,$46,$0B             ; 00D2DD ........ ?.????F?
.byte $18,$A5,$09,$69,$03,$85,$09,$9D             ; 00D2E5 ........ ???i????
.byte $9C,$0C,$A9,$FF,$9D,$2C,$10,$A5             ; 00D2ED ........ ?????,??
.byte $07,$9D,$BA,$0F,$A8,$8A,$99,$2C             ; 00D2F5 ........ ???????,
.byte $10,$86,$07,$22,$A0,$AE,$00,$98             ; 00D2FD ........ ???"????
.byte $9D,$A0,$14,$A9,$01,$99,$5E,$17             ; 00D305 ........ ??????^?
.byte $22,$F1,$AE,$00,$7A,$88,$D0,$95             ; 00D30D ........ "???z???
.byte $A9,$08,$9D,$28,$08,$8A,$A4,$0A             ; 00D315 ........ ???(????
.byte $99,$BC,$06,$60,$08,$C2,$30,$A2             ; 00D31D ........ ???`??0?
.byte $AE,$3B,$A9,$2D,$D0,$A0,$0D,$00             ; 00D325 ........ ?;?-????
.byte $22,$00,$80,$05,$C2,$10,$E2,$20             ; 00D32D ........ "?????? 
.byte $A2,$00,$78,$8E,$99,$1A,$A2,$01             ; 00D335 ........ ??x?????
.byte $18,$8E,$92,$1A,$A2,$AE,$3B,$8E             ; 00D33D ........ ??????;?
.byte $94,$1A,$A9,$7E,$8D,$96,$1A,$A2             ; 00D345 ........ ???~????
.byte $00,$10,$8E,$97,$1A,$A9,$01,$8D             ; 00D34D ........ ????????
.byte $91,$1A,$22,$13,$CA,$0E,$28,$60             ; 00D355 ........ ??"???(`

  INC.W $1900                                     ; 00D35D EE 00 19 
  LDA.B #$01                                      ; 00D360 A9 01 
  LDY.B #$70                                      ; 00D362 A0 70 
  STY.W $1512                                     ; 00D364 8C 12 15 
  STA.W $175E,Y                                   ; 00D367 99 5E 17 
  STA.W $175F,Y                                   ; 00D36A 99 5F 17 
  LDA.B #$01                                      ; 00D36D A9 01 
  LDY.B #$72                                      ; 00D36F A0 72 
  STY.W $1513                                     ; 00D371 8C 13 15 
  STA.W $175E,Y                                   ; 00D374 99 5E 17 
  STA.W $175F,Y                                   ; 00D377 99 5F 17 
  LDA.B #$01                                      ; 00D37A A9 01 
  STA.W $1514                                     ; 00D37C 8D 14 15 
  STA.W $1515                                     ; 00D37F 8D 15 15 
  LDA.B #$01                                      ; 00D382 A9 01 
  STA.W $05DE                                     ; 00D384 8D DE 05 
  STZ.W $0699                                     ; 00D387 9C 99 06 
  STZ.W XexzyMutoidHealth                         ; 00D38A 9C 9A 06 
  STZ.W $069B                                     ; 00D38D 9C 9B 06 
  STZ.W $069C                                     ; 00D390 9C 9C 06 
  LDA.B #$01                                      ; 00D393 A9 01 
  STA.W $1AAF                                     ; 00D395 8D AF 1A 
  LDA.B #$14                                      ; 00D398 A9 14 
  LDX.W $069E                                     ; 00D39A AE 9E 06 
  BEQ.B B_D3A1                                    ; 00D39D F0 02 

.byte $A9,$1A                                     ; 00D3A0 ..       ??

B_D3A1:
  STA.W $069D                                     ; 00D3A1 8D 9D 06 
  INC.W $06C6                                     ; 00D3A4 EE C6 06 
  JSL L_380F3                                     ; 00D3A7 22 F3 80 03 
  STX.W $068D                                     ; 00D3AB 8E 8D 06 
  LDA.B #$01                                      ; 00D3AE A9 01 
  STA.W EntityHeader,X                                   ; 00D3B0 9D D2 06 
  JSL L_380F3                                     ; 00D3B3 22 F3 80 03 
  STX.W $068C                                     ; 00D3B7 8E 8C 06 
  LDA.B #$01                                      ; 00D3BA A9 01 
  STA.W EntityHeader,X                                   ; 00D3BC 9D D2 06 
  JSL L_380F3                                     ; 00D3BF 22 F3 80 03 
  STX.W $068E                                     ; 00D3C3 8E 8E 06 
  LDA.B #$01                                      ; 00D3C6 A9 01 
  STA.W EntityHeader,X                                   ; 00D3C8 9D D2 06 
  JSL L_380F3                                     ; 00D3CB 22 F3 80 03 
  STX.W $069F                                     ; 00D3CF 8E 9F 06 
  LDA.B #$01                                      ; 00D3D2 A9 01 
  STA.W EntityHeader,X                                   ; 00D3D4 9D D2 06 
  JSL L_380F3                                     ; 00D3D7 22 F3 80 03 
  STX.W $06A0                                     ; 00D3DB 8E A0 06 
  LDA.B #$01                                      ; 00D3DE A9 01 
  STA.W EntityHeader,X                                   ; 00D3E0 9D D2 06 
  JSL L_380F3                                     ; 00D3E3 22 F3 80 03 
  STX.W $068B                                     ; 00D3E7 8E 8B 06 
  LDA.B #$01                                      ; 00D3EA A9 01 
  STA.W EntityHeader,X                                   ; 00D3EC 9D D2 06 
  LDX.W $068E                                     ; 00D3EF AE 8E 06 
  JSL L_38094                                     ; 00D3F2 22 94 80 03 
  LDA.B #$12                                      ; 00D3F6 A9 12 
  LDY.W $069E                                     ; 00D3F8 AC 9E 06 
  BEQ.B B_D3FF                                    ; 00D3FB F0 02 

.byte $A9,$14                                     ; 00D3FE ..       ??

B_D3FF:
  JSL L_38064                                     ; 00D3FF 22 64 80 03 
  TYA                                             ; 00D403 98 
  ASL                                             ; 00D404 0A 
  ORA.B #$08                                      ; 00D405 09 08 
  STA.W EntityV2,X                                   ; 00D407 9D B6 07 
  ORA.B #$31                                      ; 00D40A 09 31 
  STA.W EntityV30,X                                   ; 00D40C 9D 2E 14 
  LDA.B #$C4                                      ; 00D40F A9 C4 
  STA.W EntityV29,X                                   ; 00D411 9D BC 13 
  LDA.B #$6F                                      ; 00D414 A9 6F 
  STA.W EntityV1,X                                   ; 00D416 9D 44 07 
  LDA.B #$00                                      ; 00D419 A9 00 
  STA.W EntityV3,X                                   ; 00D41B 9D 28 08 
  LDA.B #$10                                      ; 00D41E A9 10 
  STA.W EntityV15,X                                   ; 00D420 9D 80 0D 
  LDA.B #$1D                                      ; 00D423 A9 1D 
  JSL L_3823C                                     ; 00D425 22 3C 82 03 
  JSL L_AE91                                      ; 00D429 22 91 AE 00 
  TYA                                             ; 00D42D 98 
  STA.W EntityV31,X                                   ; 00D42E 9D A0 14 
  LDA.B #$01                                      ; 00D431 A9 01 
  STA.W $175E,Y                                   ; 00D433 99 5E 17 
  JSL L_AED8                                      ; 00D436 22 D8 AE 00 
  LDA.B #$E0                                      ; 00D43A A9 E0 
  STA.W EntityYPx,X                                   ; 00D43C 9D 9C 0C 
  LDA.B #$00                                      ; 00D43F A9 00 
  STA.B $1C                                       ; 00D441 85 1C 
  LDA.B #$00                                      ; 00D443 A9 00 
  STA.B $1D                                       ; 00D445 85 1D 
  JSL L_AFC2                                      ; 00D447 22 C2 AF 00 
  LDX.W $069F                                     ; 00D44B AE 9F 06 
  JSR.W L_D4FE                                    ; 00D44E 20 FE D4 
  LDX.W $06A0                                     ; 00D451 AE A0 06 
  JSR.W L_D4FE                                    ; 00D454 20 FE D4 
  LDX.W $068B                                     ; 00D457 AE 8B 06 
  JSL L_38094                                     ; 00D45A 22 94 80 03 
  LDA.B #$11                                      ; 00D45E A9 11 
  JSL L_38064                                     ; 00D460 22 64 80 03 
  TYA                                             ; 00D464 98 
  ASL                                             ; 00D465 0A 
  ORA.B #$08                                      ; 00D466 09 08 
  STA.W EntityV2,X                                   ; 00D468 9D B6 07 
  STA.W $0697                                     ; 00D46B 8D 97 06 
  STA.W $0698                                     ; 00D46E 8D 98 06 
  LDA.B #$78                                      ; 00D471 A9 78 
  STA.W EntityV1,X                                   ; 00D473 9D 44 07 
  LDA.B #$30                                      ; 00D476 A9 30 
  STA.W EntityV3,X                                   ; 00D478 9D 28 08 
  LDA.B #$80                                      ; 00D47B A9 80 
  STA.W XexzyCharX,X                              ; 00D47D 9D 46 0B 
  LDA.B #$9C                                      ; 00D480 A9 9C 
  STA.W EntityYPx,X                                   ; 00D482 9D 9C 0C 
  LDA.B #$FF                                      ; 00D485 A9 FF 
  STA.W EntityV14,X                                   ; 00D487 9D 0E 0D 
  LDA.B #$80                                      ; 00D48A A9 80 
  STA.W EntityV7,X                                   ; 00D48C 9D F0 09 
  LDA.B #$00                                      ; 00D48F A9 00 
  STA.W EntityV8,X                                   ; 00D491 9D 62 0A 
  JSL L_AE91                                      ; 00D494 22 91 AE 00 
  TYA                                             ; 00D498 98 
  STA.B $08                                       ; 00D499 85 08 
  STA.W EntityV31,X                                   ; 00D49B 9D A0 14 
  LDA.B #$01                                      ; 00D49E A9 01 
  STA.W $175E,Y                                   ; 00D4A0 99 5E 17 
  JSL L_AEF1                                      ; 00D4A3 22 F1 AE 00 
  LDX.B #$13                                      ; 00D4A7 A2 13 
B_D4A9:
  PHX                                             ; 00D4A9 DA 
  JSL L_AE91                                      ; 00D4AA 22 91 AE 00 
  TYA                                             ; 00D4AE 98 
  LDX.B $08                                       ; 00D4AF A6 08 
  STA.B $08                                       ; 00D4B1 85 08 
  STA.W $17DE,X                                   ; 00D4B3 9D DE 17 
  LDA.B #$01                                      ; 00D4B6 A9 01 
  STA.W $175E,Y                                   ; 00D4B8 99 5E 17 
  JSL L_AEF1                                      ; 00D4BB 22 F1 AE 00 
  PLX                                             ; 00D4BF FA 
  DEX                                             ; 00D4C0 CA 
  BNE.B B_D4A9                                    ; 00D4C1 D0 E6 
  LDX.W $068C                                     ; 00D4C3 AE 8C 06 
  JSL L_38094                                     ; 00D4C6 22 94 80 03 
  LDA.B #$73                                      ; 00D4CA A9 73 
  STA.W EntityV1,X                                   ; 00D4CC 9D 44 07 
  LDA.B #$30                                      ; 00D4CF A9 30 
  STA.W EntityV3,X                                   ; 00D4D1 9D 28 08 
  LDA.B #$01                                      ; 00D4D4 A9 01 
  STA.W EntityV4,X                                   ; 00D4D6 9D 9A 08 
  LDA.B #$0C                                      ; 00D4D9 A9 0C 
  JSL L_3823C                                     ; 00D4DB 22 3C 82 03 
  LDX.W $068D                                     ; 00D4DF AE 8D 06 
  JSL L_38094                                     ; 00D4E2 22 94 80 03 
  LDA.B #$74                                      ; 00D4E6 A9 74 
  STA.W EntityV1,X                                   ; 00D4E8 9D 44 07 
  LDA.B #$30                                      ; 00D4EB A9 30 
  STA.W EntityV3,X                                   ; 00D4ED 9D 28 08 
  LDA.B #$11                                      ; 00D4F0 A9 11 
  STA.W EntityV4,X                                   ; 00D4F2 9D 9A 08 
  LDA.B #$0C                                      ; 00D4F5 A9 0C 
  JSL L_3823C                                     ; 00D4F7 22 3C 82 03 
  LDA.B #$01                                      ; 00D4FB A9 01 
  RTS                                             ; 00D4FD 60 


L_D4FE:
  LDA.B #$0E                                      ; 00D4FE A9 0E 
  JSL L_38064                                     ; 00D500 22 64 80 03 
  STY.W $18E2                                     ; 00D504 8C E2 18 
  JSL L_38094                                     ; 00D507 22 94 80 03 
  LDA.B #$01                                      ; 00D50B A9 01 
  STA.W EntityHeader,X                                   ; 00D50D 9D D2 06 
  LDA.B #$92                                      ; 00D510 A9 92 
  STA.W EntityV1,X                                   ; 00D512 9D 44 07 
  LDA.B #$04                                      ; 00D515 A9 04 
  STA.W EntityV3,X                                   ; 00D517 9D 28 08 
  LDA.B #$20                                      ; 00D51A A9 20 
  STA.W EntityV19,X                                   ; 00D51C 9D 48 0F 
  INC.W $06C6                                     ; 00D51F EE C6 06 
  LDA.B #$00                                      ; 00D522 A9 00 
  STA.W XexzyCharX,X                              ; 00D524 9D 46 0B 
  STA.W EntityYPx,X                                   ; 00D527 9D 9C 0C 
  STA.W EntityV11,X                                   ; 00D52A 9D B8 0B 
  STA.W EntityV14,X                                   ; 00D52D 9D 0E 0D 
  JSL AdvanceRNG                                     ; 00D530 22 95 CA 0E 
  AND.B #$07                                      ; 00D534 29 07 
  ADC.B #$2C                                      ; 00D536 69 2C 
  STA.W EntityV15,X                                   ; 00D538 9D 80 0D 
  JSL L_38059                                     ; 00D53B 22 59 80 03 
  LDA.B #$01                                      ; 00D53F A9 01 
  STA.W $1AAF,Y                                   ; 00D541 99 AF 1A 
  LDA.W D_D59C,Y                                  ; 00D544 B9 9C D5 
  STA.W EntityV29,X                                   ; 00D547 9D BC 13 
  TYA                                             ; 00D54A 98 
  STA.W EntityV23,X                                   ; 00D54B 9D 10 11 
  LDA.W $18E2                                     ; 00D54E AD E2 18 
  ASL                                             ; 00D551 0A 
  ORA.B #$39                                      ; 00D552 09 39 
  STA.W EntityV2,X                                   ; 00D554 9D B6 07 
  STA.W EntityV30,X                                   ; 00D557 9D 2E 14 
  JSL L_AEBC                                      ; 00D55A 22 BC AE 00 
  TYA                                             ; 00D55E 98 
  STA.W EntityV31,X                                   ; 00D55F 9D A0 14 
  LDA.B #$01                                      ; 00D562 A9 01 
  STA.W $175E,Y                                   ; 00D564 99 5E 17 
  JSL L_AED8                                      ; 00D567 22 D8 AE 00 
  LDA.W EntityV31,X                                   ; 00D56B BD A0 14 
  ASL                                             ; 00D56E 0A 
  ASL                                             ; 00D56F 0A 
  TAY                                             ; 00D570 A8 
  BCC.B B_D57F                                    ; 00D571 90 0C 

.byte $A9,$FF,$99,$08,$04,$A9,$F0,$99             ; 00D573 ........ ????????
.byte $09,$04,$80,$0A                             ; 00D57C ....     ????

B_D57F:
  LDA.B #$FF                                      ; 00D57F A9 FF 
  STA.W $0308,Y                                   ; 00D581 99 08 03 
  LDA.B #$F0                                      ; 00D584 A9 F0 
  STA.W XexzyTorsoY,Y                             ; 00D586 99 09 03 
  LDA.B #$08                                      ; 00D589 A9 08 
  STA.W EntityV25,X                                   ; 00D58B 9D F4 11 
  PHB                                             ; 00D58E 8B 
  LDA.B #$03                                      ; 00D58F A9 03 
  PHA                                             ; 00D591 48 
  PLB                                             ; 00D592 AB 
  LDA.W EntityV23,X                                   ; 00D593 BD 10 11 
  JSL L_3F032                                     ; 00D596 22 32 F0 03 
  PLB                                             ; 00D59A AB 
  RTS                                             ; 00D59B 60 


D_D59C:
.byte $C4,$C8,$CC                                 ; 00D59D .DD      ???

  RTS                                             ; 00D59F 60 


.byte $A9,$10,$8D,$AF,$06,$9C,$B0,$06             ; 00D5A0 ........ ????????
.byte $9C,$B1,$06,$9C,$B2,$06,$9C,$AD             ; 00D5A8 ........ ????????
.byte $06,$9C,$AE,$06,$A9,$01,$8D,$BA             ; 00D5B0 ........ ????????
.byte $06,$8D,$BB,$06,$A9,$40,$8D,$B5             ; 00D5B8 ........ ?????@??
.byte $06,$A9,$08,$8D,$B4,$06,$A2,$03             ; 00D5C0 ........ ????????
.byte $9E,$B6,$06,$CA,$10,$FA,$A9,$01             ; 00D5C8 ........ ????????
.byte $8D,$D8,$05,$EE,$00,$19,$A9,$30             ; 00D5D0 ........ ???????0
.byte $8D,$A7,$18,$A9,$6A,$8D,$CD,$06             ; 00D5D8 ........ ????j???
.byte $9C,$CE,$06,$A9,$7E,$8D,$D0,$06             ; 00D5E0 ........ ????~???
.byte $9C,$D1,$06,$20,$DF,$D7,$A2,$3C             ; 00D5E8 ........ ??? ???<
.byte $22,$72,$C9,$0E,$20,$08,$D7,$A0             ; 00D5F0 ........ "r?? ???
.byte $07,$5A,$B9,$F7,$D6,$85,$04,$B9             ; 00D5F8 ........ ?Z??????
.byte $FF,$D6,$85,$05,$84,$0A,$20,$4C             ; 00D600 ........ ?????? L
.byte $D6,$A5,$05,$09,$40,$85,$05,$A5             ; 00D608 ........ ????@???
.byte $0A,$09,$08,$85,$0A,$20,$4C,$D6             ; 00D610 ........ ????? L?
.byte $7A,$88,$10,$DD,$22,$11,$81,$03             ; 00D618 ........ z???"???
.byte $8E,$8B,$06,$EE,$C6,$06,$22,$94             ; 00D620 ........ ??????"?
.byte $80,$03,$A9,$01,$9D,$D2,$06,$A9             ; 00D628 ........ ????????
.byte $96,$9D,$44,$07,$A9,$0C,$9D,$28             ; 00D630 ........ ??D????(
.byte $08,$A9,$BE,$9D,$46,$0B,$A9,$AA             ; 00D638 ........ ????F???
.byte $9D,$9C,$0C,$9E,$B8,$0B,$9E,$0E             ; 00D640 ........ ????????
.byte $0D,$A9,$01,$60,$22,$F3,$80,$03             ; 00D648 ........ ???`"???
.byte $A9,$16,$22,$64,$80,$03,$8C,$E3             ; 00D650 ........ ??"d????
.byte $18,$98,$0A,$09,$38,$85,$08,$22             ; 00D658 ........ ????8??"
.byte $94,$80,$03,$A9,$01,$9D,$D2,$06             ; 00D660 ........ ????????
.byte $A9,$9F,$9D,$44,$07,$A9,$1E,$9D             ; 00D668 ........ ???D????
.byte $F2,$0D,$A5,$04,$9D,$BC,$13,$A5             ; 00D670 ........ ????????
.byte $08,$9D,$B6,$07,$05,$05,$9D,$2E             ; 00D678 ........ ???????.
.byte $14,$A5,$0A,$9D,$2C,$10,$0A,$A8             ; 00D680 ........ ????,???
.byte $B9,$B7,$D6,$9D,$0C,$09,$B9,$B8             ; 00D688 ........ ????????
.byte $D6,$9D,$7E,$09,$B9,$D7,$D6,$9D             ; 00D690 ........ ??~?????
.byte $F0,$09,$B9,$D8,$D6,$9D,$62,$0A             ; 00D698 ........ ??????b?
.byte $A9,$0C,$9D,$28,$08,$22,$CB,$AE             ; 00D6A0 ........ ???(?"??
.byte $00,$98,$9D,$A0,$14,$A9,$01,$99             ; 00D6A8 ........ ????????
.byte $5E,$17,$22,$F1,$AE,$00,$60,$84             ; 00D6B0 ........ ^?"???`?
.byte $FF,$9D,$FE,$EC,$FD,$8D,$FD,$8D             ; 00D6B8 ........ ????????
.byte $FD,$EC,$FD,$9D,$FE,$84,$FF,$7C             ; 00D6C0 ........ ???????|
.byte $00,$63,$01,$14,$02,$73,$02,$73             ; 00D6C8 ........ ?c???s?s
.byte $02,$14,$02,$63,$01,$7C,$00,$8D             ; 00D6D0 ........ ???c?|??
.byte $FD,$EC,$FD,$9D,$FE,$84,$FF,$7C             ; 00D6D8 ........ ???????|
.byte $00,$63,$01,$14,$02,$73,$02,$8D             ; 00D6E0 ........ ?c???s??
.byte $FD,$EC,$FD,$9D,$FE,$84,$FF,$7C             ; 00D6E8 ........ ???????|
.byte $00,$63,$01,$14,$02,$73,$02,$80             ; 00D6F0 ........ ?c???s??
.byte $82,$84,$86,$88,$8A,$8C,$8E,$01             ; 00D6F8 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$60             ; 00D700 ........ ???????`
.byte $08,$22,$13,$CA,$0E,$C2,$30,$A9             ; 00D708 ........ ?"????0?
.byte $E0,$C8,$A0,$0F,$00,$A2,$AE,$20             ; 00D710 ........ ??????? 
.byte $22,$00,$80,$05,$E2,$20,$A9,$00             ; 00D718 ........ "???? ??
.byte $8D,$89,$06,$A9,$08,$8D,$8A,$06             ; 00D720 ........ ????????
.byte $A9,$01,$8D,$88,$06,$28,$60,$A2             ; 00D728 ........ ?????(`?
.byte $00,$00,$8E,$99,$1A,$A2,$01,$18             ; 00D730 ........ ????????
.byte $8E,$92,$1A,$A2,$AE,$3B,$8E,$94             ; 00D738 ........ ?????;??
.byte $1A,$A9,$7E,$8D,$96,$1A,$A2,$00             ; 00D740 ........ ??~?????
.byte $10,$8E,$97,$1A,$A9,$01,$8D,$91             ; 00D748 ........ ????????
.byte $1A,$22,$13,$CA,$0E,$60,$A2,$07             ; 00D750 ........ ?"???`??
.byte $07,$BF,$AE,$3B,$7E,$9F,$AE,$63             ; 00D758 ........ ???;~??c
.byte $7E,$A9,$00,$9F,$AE,$3B,$7E,$CA             ; 00D760 ........ ~????;~?
.byte $10,$EF,$20,$2F,$D7,$A9,$17,$8D             ; 00D768 ........ ?? /????
.byte $2C,$21,$A9,$5A,$85,$06,$A0,$00             ; 00D770 ........ ,!?Z????
.byte $00,$98,$EB,$84,$04,$F4,$00,$00             ; 00D778 ........ ????????
.byte $AB,$AB,$5A,$A2,$07,$07,$8A,$65             ; 00D780 ........ ??Z????e
.byte $06,$29,$07,$89,$04,$F0,$07,$48             ; 00D788 ........ ?)?????H
.byte $A5,$06,$0A,$26,$06,$68,$18,$65             ; 00D790 ........ ???&?h?e
.byte $04,$A8,$B9,$B3,$D7,$3F,$AE,$63             ; 00D798 ........ ???????c
.byte $7E,$9F,$AE,$3B,$7E,$CA,$10,$DE             ; 00D7A0 ........ ~??;~???
.byte $7A,$20,$2F,$D7,$C8,$C0,$25,$00             ; 00D7A8 ........ z /???%?
.byte $D0,$C9,$60,$00,$00,$00,$00,$00             ; 00D7B0 ........ ??`?????
.byte $00,$00,$00,$80,$20,$08,$02,$48             ; 00D7B8 ........ ???? ??H
.byte $12,$88,$11,$A2,$49,$52,$2A,$56             ; 00D7C0 ........ ????IR*V
.byte $9A,$6C,$65,$67,$D9,$76,$BA,$77             ; 00D7C8 ........ ?leg?v?w
.byte $EB,$ED,$BB,$EF,$BF,$F7,$FD,$FF             ; 00D7D0 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$08             ; 00D7D8 ........ ????????
.byte $C2,$10,$E2,$20,$A2,$00,$78,$8E             ; 00D7E0 ........ ??? ??x?
.byte $99,$1A,$A2,$01,$18,$8E,$92,$1A             ; 00D7E8 ........ ????????
.byte $A2,$00,$F0,$8E,$94,$1A,$A9,$7E             ; 00D7F0 ........ ???????~
.byte $8D,$96,$1A,$A2,$00,$10,$8E,$97             ; 00D7F8 ........ ????????
.byte $1A,$A9,$01,$8D,$91,$1A,$22,$13             ; 00D800 ........ ??????"?
.byte $CA,$0E,$C2,$30,$A9,$0D,$B0,$A0             ; 00D808 ........ ???0????
.byte $0F,$00,$A2,$AE,$3B,$22,$00,$80             ; 00D810 ........ ????;"??
.byte $05,$E2,$20,$A2,$00,$08,$8E,$99             ; 00D818 ........ ?? ?????
.byte $1A,$A2,$01,$18,$8E,$92,$1A,$A2             ; 00D820 ........ ????????
.byte $AE,$4B,$8E,$94,$1A,$A9,$7E,$8D             ; 00D828 ........ ?K????~?
.byte $96,$1A,$A2,$00,$10,$8E,$97,$1A             ; 00D830 ........ ????????
.byte $A9,$01,$8D,$91,$1A,$22,$13,$CA             ; 00D838 ........ ?????"??
.byte $0E,$A2,$00,$10,$8E,$99,$1A,$A2             ; 00D840 ........ ????????
.byte $01,$18,$8E,$92,$1A,$A2,$AE,$5B             ; 00D848 ........ ???????[
.byte $8E,$94,$1A,$A9,$7E,$8D,$96,$1A             ; 00D850 ........ ????~???
.byte $A2,$00,$10,$8E,$97,$1A,$A9,$01             ; 00D858 ........ ????????
.byte $8D,$91,$1A,$22,$13,$CA,$0E,$C2             ; 00D860 ........ ???"????
.byte $30,$A9,$BD,$C7,$A0,$0F,$00,$A2             ; 00D868 ........ 0???????
.byte $AE,$20,$22,$00,$80,$05,$E2,$20             ; 00D870 ........ ? "???? 
.byte $A9,$00,$8D,$89,$06,$A9,$08,$8D             ; 00D878 ........ ????????
.byte $8A,$06,$A9,$01,$8D,$88,$06,$9C             ; 00D880 ........ ????????
.byte $86,$1A,$9C,$7D,$1A,$A9,$22,$8D             ; 00D888 ........ ???}??"?
.byte $7E,$1A,$A9,$AD,$8D,$7F,$1A,$A9             ; 00D890 ........ ~???????
.byte $CE,$8D,$80,$1A,$A9,$0F,$8D,$81             ; 00D898 ........ ????????
.byte $1A,$A9,$80,$8D,$82,$1A,$A9,$01             ; 00D8A0 ........ ????????
.byte $8D,$83,$1A,$22,$13,$CA,$0E,$E2             ; 00D8A8 ........ ???"????
.byte $30,$A9,$48,$8D,$07,$21,$C2,$10             ; 00D8B0 ........ 0?H??!??
.byte $20,$56,$D7,$28,$60,$60,$60                 ; 00D8B9 .......   V?(```

  JSL L_380F3                                     ; 00D8BF 22 F3 80 03 
  BEQ.B B_D8C8                                    ; 00D8C3 F0 03 

.byte $A9,$00,$60                                 ; 00D8C6 ...      ??`

B_D8C8:
  LDA.B #$00                                      ; 00D8C8 A9 00 
  STA.B $06                                       ; 00D8CA 85 06 
  LDA.B #$1E                                      ; 00D8CC A9 1E 
  STA.B $07                                       ; 00D8CE 85 07 
  JSR.W L_D8D6                                    ; 00D8D0 20 D6 D8 
  LDA.B #$01                                      ; 00D8D3 A9 01 
  RTS                                             ; 00D8D5 60 


L_D8D6:
  JSL L_38094                                     ; 00D8D6 22 94 80 03 
  LDA.B #$01                                      ; 00D8DA A9 01 
  STA.W EntityHeader,X                                   ; 00D8DC 9D D2 06 
  LDA.B #$0B                                      ; 00D8DF A9 0B 
  STA.W EntityV1,X                                   ; 00D8E1 9D 44 07 
  LDA.B #$00                                      ; 00D8E4 A9 00 
  STA.W EntityV3,X                                   ; 00D8E6 9D 28 08 
  LDA.B $07                                       ; 00D8E9 A5 07 
  STA.W EntityV15,X                                   ; 00D8EB 9D 80 0D 
  LDA.B $06                                       ; 00D8EE A5 06 
  STA.W EntityV20,X                                   ; 00D8F0 9D BA 0F 
  JSR.W L_DA82                                    ; 00D8F3 20 82 DA 
  LDA.B $04                                       ; 00D8F6 A5 04 
  STA.W XexzyCharX,X                              ; 00D8F8 9D 46 0B 
  LDA.B $05                                       ; 00D8FB A5 05 
  STA.W EntityYPx,X                                   ; 00D8FD 9D 9C 0C 
  LDY.B #$00                                      ; 00D900 A0 00 
  LDA.B $04                                       ; 00D902 A5 04 
  CMP.B #$80                                      ; 00D904 C9 80 
  BCC.B B_D90A                                    ; 00D906 90 02 
  LDY.B #$02                                      ; 00D908 A0 02 
B_D90A:
  LDA.W D_D92D,Y                                  ; 00D90A B9 2D D9 
  STA.W EntityV5,X                                   ; 00D90D 9D 0C 09 
  LDA.W D_D92E,Y                                  ; 00D910 B9 2E D9 
  STA.W EntityV6,X                                   ; 00D913 9D 7E 09 
  LDY.B #$00                                      ; 00D916 A0 00 
  LDA.B $05                                       ; 00D918 A5 05 
  CMP.B #$80                                      ; 00D91A C9 80 
  BCC.B B_D920                                    ; 00D91C 90 02 
  LDY.B #$02                                      ; 00D91E A0 02 
B_D920:
  LDA.W D_D92D,Y                                  ; 00D920 B9 2D D9 
  STA.W EntityV7,X                                   ; 00D923 9D F0 09 
  LDA.W D_D92E,Y                                  ; 00D926 B9 2E D9 
  STA.W EntityV8,X                                   ; 00D929 9D 62 0A 
  RTS                                             ; 00D92C 60 


D_D92D:
.byte $80                                         ; 00D92E D        ?
D_D92E:
.byte $01,$80,$FE                                 ; 00D92F DDD      ???

  LDA.B #$FF                                      ; 00D931 A9 FF 
  STA.W $05AF                                     ; 00D933 8D AF 05 
  RTS                                             ; 00D936 60 

  JSL L_380F3                                     ; 00D937 22 F3 80 03 
  JSL L_38094                                     ; 00D93B 22 94 80 03 
  LDA.B #$01                                      ; 00D93F A9 01 
  STA.W EntityHeader,X                                   ; 00D941 9D D2 06 
  LDA.B #$4C                                      ; 00D944 A9 4C 
  STA.W EntityV1,X                                   ; 00D946 9D 44 07 
  INC.W $06C6                                     ; 00D949 EE C6 06 
  LDA.B #$08                                      ; 00D94C A9 08 
  STA.W EntityV3,X                                   ; 00D94E 9D 28 08 
  LDA.B #$4E                                      ; 00D951 A9 4E 
  STA.W EntityV29,X                                   ; 00D953 9D BC 13 
  LDA.B #$33                                      ; 00D956 A9 33 
  STA.W EntityV30,X                                   ; 00D958 9D 2E 14 
  LDA.B #$E0                                      ; 00D95B A9 E0 
  STA.W XexzyCharX,X                              ; 00D95D 9D 46 0B 
  LDA.B #$C8                                      ; 00D960 A9 C8 
  STA.W EntityYPx,X                                   ; 00D962 9D 9C 0C 
  SEC                                             ; 00D965 38 
  LDA.W XexzyCharX,X                              ; 00D966 BD 46 0B 
  SBC.B #$06                                      ; 00D969 E9 06 
  BCS.B B_D96F                                    ; 00D96B B0 02 

.byte $A9,$00                                     ; 00D96E ..       ??

B_D96F:
  STA.W EntityV32,X                                   ; 00D96F 9D 16 15 
  CLC                                             ; 00D972 18 
  LDA.W XexzyCharX,X                              ; 00D973 BD 46 0B 
  ADC.B #$06                                      ; 00D976 69 06 
  BCC.B B_D97C                                    ; 00D978 90 02 

.byte $A9,$FF                                     ; 00D97B ..       ??

B_D97C:
  STA.W EntityV33,X                                   ; 00D97C 9D 88 15 
  SEC                                             ; 00D97F 38 
  LDA.W EntityYPx,X                                   ; 00D980 BD 9C 0C 
  SBC.B #$06                                      ; 00D983 E9 06 
  BCS.B B_D989                                    ; 00D985 B0 02 

.byte $A9,$00                                     ; 00D988 ..       ??

B_D989:
  STA.W EntityV34,X                                   ; 00D989 9D FA 15 
  CLC                                             ; 00D98C 18 
  LDA.W EntityYPx,X                                   ; 00D98D BD 9C 0C 
  ADC.B #$06                                      ; 00D990 69 06 
  BCC.B B_D996                                    ; 00D992 90 02 

.byte $A9,$FF                                     ; 00D995 ..       ??

B_D996:
  STA.W EntityV35,X                                   ; 00D996 9D 6C 16 
  STZ.W EntityV27,X                                   ; 00D999 9E D8 12 
  LDA.B #$FF                                      ; 00D99C A9 FF 
  STA.W EntityV28,X                                   ; 00D99E 9D 4A 13 
  JSL L_AEAF                                      ; 00D9A1 22 AF AE 00 
  TYA                                             ; 00D9A5 98 
  STA.W EntityV31,X                                   ; 00D9A6 9D A0 14 
  LDA.B #$01                                      ; 00D9A9 A9 01 
  STA.W $175E,Y                                   ; 00D9AB 99 5E 17 
  JSL L_AEF1                                      ; 00D9AE 22 F1 AE 00 
  LDA.B #$08                                      ; 00D9B2 A9 08 
  STA.B $1C                                       ; 00D9B4 85 1C 
  LDA.B #$08                                      ; 00D9B6 A9 08 
  STA.B $1D                                       ; 00D9B8 85 1D 
  JSL L_AFC2                                      ; 00D9BA 22 C2 AF 00 
  SEC                                             ; 00D9BE 38 
  LDA.W EntityYPx,X                                   ; 00D9BF BD 9C 0C 
  SBC.B #$08                                      ; 00D9C2 E9 08 
  STA.W EntityV20,X                                   ; 00D9C4 9D BA 0F 
  REP.B #$10                                      ; 00D9C7 C2 10 
  LDA.B #$07                                      ; 00D9C9 A9 07 
  LDX.W #$FF0E                                    ; 00D9CB A2 0E FF 
  JSL Audio_F830F                                     ; 00D9CE 22 0F 83 0F 
  SEP.B #$10                                      ; 00D9D2 E2 10 
  LDA.B #$01                                      ; 00D9D4 A9 01 
  RTS                                             ; 00D9D6 60 

  RTS                                             ; 00D9D7 60 


.byte $22,$F3,$80,$03,$F0,$03,$A9,$00             ; 00D9D8 ........ "???????
.byte $60,$20,$ED,$D9,$A9,$01,$60,$A9             ; 00D9E0 ........ ` ????`?
.byte $FF,$8D,$AF,$05,$60,$22,$94,$80             ; 00D9E8 ........ ????`"??
.byte $03,$A9,$01,$9D,$D2,$06,$A9,$59             ; 00D9F0 ........ ???????Y
.byte $9D,$44,$07,$A9,$00,$9D,$28,$08             ; 00D9F8 ........ ?D????(?
.byte $A9,$1E,$9D,$80,$0D,$20,$82,$DA             ; 00DA00 ........ ????? ??
.byte $A5,$04,$9D,$46,$0B,$A5,$05,$9D             ; 00DA08 ........ ???F????
.byte $9C,$0C,$A0,$00,$A5,$04,$C9,$80             ; 00DA10 ........ ????????
.byte $90,$02,$A0,$02,$B9,$3F,$DA,$9D             ; 00DA18 ........ ????????
.byte $0C,$09,$B9,$40,$DA,$9D,$7E,$09             ; 00DA20 ........ ???@??~?
.byte $A0,$00,$A5,$05,$C9,$80,$90,$02             ; 00DA28 ........ ????????
.byte $A0,$02,$B9,$3F,$DA,$9D,$F0,$09             ; 00DA30 ........ ????????
.byte $B9,$40,$DA,$9D,$62,$0A,$60,$80             ; 00DA38 ........ ?@??b?`?
.byte $01,$80,$FE                                 ; 00DA41 ...      ???


L_DA43:
  LDA.B $D2                                       ; 00DA43 A5 D2 
  AND.B #$01                                      ; 00DA45 29 01 
  BNE.B B_DA54                                    ; 00DA47 D0 0B 
  LDX.W $05AF                                     ; 00DA49 AE AF 05 
  BEQ.B B_DA55                                    ; 00DA4C F0 07 
  BMI.B B_DA54                                    ; 00DA4E 30 04 
  DEX                                             ; 00DA50 CA 
  STX.W $05AF                                     ; 00DA51 8E AF 05 
B_DA54:
  RTS                                             ; 00DA54 60 

B_DA55:
  JSL L_380F3                                     ; 00DA55 22 F3 80 03 
  BNE.B B_DA81                                    ; 00DA59 D0 26 
  JSR.W L_DA82                                    ; 00DA5B 20 82 DA 
  JSL AdvanceRNG                                     ; 00DA5E 22 95 CA 0E 
  AND.B #$07                                      ; 00DA62 29 07 
  STA.B $06                                       ; 00DA64 85 06 
  CMP.B #$04                                      ; 00DA66 C9 04 
  BCC.B B_DA7D                                    ; 00DA68 90 13 
  LDA.B #$04                                      ; 00DA6A A9 04 
  STA.B $06                                       ; 00DA6C 85 06 
  JSL AdvanceRNG                                     ; 00DA6E 22 95 CA 0E 
  AND.B #$03                                      ; 00DA72 29 03 
  CLC                                             ; 00DA74 18 
  ADC.B #$03                                      ; 00DA75 69 03 
  STA.B $07                                       ; 00DA77 85 07 
  JSR.W L_D8D6                                    ; 00DA79 20 D6 D8 
  RTS                                             ; 00DA7C 60 

B_DA7D:
  JSL L_DAA1                                      ; 00DA7D 22 A1 DA 00 
B_DA81:
  RTS                                             ; 00DA81 60 


L_DA82:
  PHB                                             ; 00DA82 8B 
  LDA.B #$00                                      ; 00DA83 A9 00 
  PHA                                             ; 00DA85 48 
  PLB                                             ; 00DA86 AB 
  JSL AdvanceRNG                                     ; 00DA87 22 95 CA 0E 
  AND.B #$1F                                      ; 00DA8B 29 1F 
  TAY                                             ; 00DA8D A8 
  LDA.W D_DD1C,Y                                  ; 00DA8E B9 1C DD 
  STA.B $04                                       ; 00DA91 85 04 
  JSL AdvanceRNG                                     ; 00DA93 22 95 CA 0E 
  AND.B #$1F                                      ; 00DA97 29 1F 
  TAY                                             ; 00DA99 A8 
  LDA.W D_DD3C,Y                                  ; 00DA9A B9 3C DD 
  STA.B $05                                       ; 00DA9D 85 05 
  PLB                                             ; 00DA9F AB 
  RTS                                             ; 00DAA0 60 


L_DAA1:
  PHB                                             ; 00DAA1 8B 
  JSL L_38094                                     ; 00DAA2 22 94 80 03 
  LDA.B #$01                                      ; 00DAA6 A9 01 
  STA.W EntityHeader,X                                   ; 00DAA8 9D D2 06 
  LDA.B #$47                                      ; 00DAAB A9 47 
  STA.W EntityV1,X                                   ; 00DAAD 9D 44 07 
  LDA.B #$00                                      ; 00DAB0 A9 00 
  PHA                                             ; 00DAB2 48 
  PLB                                             ; 00DAB3 AB 
  LDY.B $06                                       ; 00DAB4 A4 06 
  LDA.W D_DB5E,Y                                  ; 00DAB6 B9 5E DB 
  STA.W EntityV21,X                                   ; 00DAB9 9D 2C 10 
  STA.W EntityV23,X                                   ; 00DABC 9D 10 11 
  LDA.W D_DB66,Y                                  ; 00DABF B9 66 DB 
  STA.W EntityV29,X                                   ; 00DAC2 9D BC 13 
  LDA.W D_DB6E,Y                                  ; 00DAC5 B9 6E DB 
  STA.W EntityV30,X                                   ; 00DAC8 9D 2E 14 
  JSL AdvanceRNG                                     ; 00DACB 22 95 CA 0E 
  AND.B #$01                                      ; 00DACF 29 01 
  BNE.B B_DADB                                    ; 00DAD1 D0 08 
  LDA.W EntityV30,X                                   ; 00DAD3 BD 2E 14 
  ORA.B #$40                                      ; 00DAD6 09 40 
  STA.W EntityV30,X                                   ; 00DAD8 9D 2E 14 
B_DADB:
  LDA.B #$08                                      ; 00DADB A9 08 
  STA.W EntityV3,X                                   ; 00DADD 9D 28 08 
  LDA.B $04                                       ; 00DAE0 A5 04 
  STA.W XexzyCharX,X                              ; 00DAE2 9D 46 0B 
  LDA.B $05                                       ; 00DAE5 A5 05 
  LDY.W $188E                                     ; 00DAE7 AC 8E 18 
  BEQ.B B_DAF2                                    ; 00DAEA F0 06 

.byte $C9,$8C,$90,$02,$A9,$82                     ; 00DAED ......   ??????

B_DAF2:
  STA.W EntityYPx,X                                   ; 00DAF2 9D 9C 0C 
  SEC                                             ; 00DAF5 38 
  LDA.W XexzyCharX,X                              ; 00DAF6 BD 46 0B 
  SBC.B #$06                                      ; 00DAF9 E9 06 
  BCS.B B_DAFF                                    ; 00DAFB B0 02 

.byte $A9,$00                                     ; 00DAFE ..       ??

B_DAFF:
  STA.W EntityV32,X                                   ; 00DAFF 9D 16 15 
  CLC                                             ; 00DB02 18 
  LDA.W XexzyCharX,X                              ; 00DB03 BD 46 0B 
  ADC.B #$06                                      ; 00DB06 69 06 
  BCC.B B_DB0C                                    ; 00DB08 90 02 

.byte $A9,$FF                                     ; 00DB0B ..       ??

B_DB0C:
  STA.W EntityV33,X                                   ; 00DB0C 9D 88 15 
  SEC                                             ; 00DB0F 38 
  LDA.W EntityYPx,X                                   ; 00DB10 BD 9C 0C 
  SBC.B #$06                                      ; 00DB13 E9 06 
  BCS.B B_DB19                                    ; 00DB15 B0 02 

.byte $A9,$00                                     ; 00DB18 ..       ??

B_DB19:
  STA.W EntityV34,X                                   ; 00DB19 9D FA 15 
  CLC                                             ; 00DB1C 18 
  LDA.W EntityYPx,X                                   ; 00DB1D BD 9C 0C 
  ADC.B #$06                                      ; 00DB20 69 06 
  BCC.B B_DB26                                    ; 00DB22 90 02 

.byte $A9,$FF                                     ; 00DB25 ..       ??

B_DB26:
  STA.W EntityV35,X                                   ; 00DB26 9D 6C 16 
  STZ.W EntityV27,X                                   ; 00DB29 9E D8 12 
  LDA.B #$FF                                      ; 00DB2C A9 FF 
  STA.W EntityV28,X                                   ; 00DB2E 9D 4A 13 
  JSL L_AEAF                                      ; 00DB31 22 AF AE 00 
  TYA                                             ; 00DB35 98 
  STA.W EntityV31,X                                   ; 00DB36 9D A0 14 
  LDA.B #$01                                      ; 00DB39 A9 01 
  STA.W $175E,Y                                   ; 00DB3B 99 5E 17 
  JSL L_AEF1                                      ; 00DB3E 22 F1 AE 00 
  LDA.B #$08                                      ; 00DB42 A9 08 
  STA.B $1C                                       ; 00DB44 85 1C 
  LDA.B #$08                                      ; 00DB46 A9 08 
  STA.B $1D                                       ; 00DB48 85 1D 
  JSL L_AFC2                                      ; 00DB4A 22 C2 AF 00 
  SEC                                             ; 00DB4E 38 
  LDA.W EntityYPx,X                                   ; 00DB4F BD 9C 0C 
  SBC.B #$08                                      ; 00DB52 E9 08 
  STA.W EntityV20,X                                   ; 00DB54 9D BA 0F 
  LDA.B #$FF                                      ; 00DB57 A9 FF 
  STA.W $05AF                                     ; 00DB59 8D AF 05 
  PLB                                             ; 00DB5C AB 
  RTL                                             ; 00DB5D 6B 

D_DB5E:
.byte $01,$01,$01,$01,$00,$00,$00,$00             ; 00DB5E DDDDDDDD ????????
D_DB66:
.byte $60,$62,$64,$60,$66,$68,$6A,$40             ; 00DB66 DDDDDDDD `bd`fhj@
D_DB6E:
.byte $27,$23,$25,$27,$25,$23,$23,$23             ; 00DB6E DDDDDDDD '#%'%###


L_DB76:
  LDA.B $D2                                       ; 00DB76 A5 D2 
  AND.B #$01                                      ; 00DB78 29 01 
  BNE.B B_DB87                                    ; 00DB7A D0 0B 
  LDX.W XexzyDropCountDownTimer                   ; 00DB7C AE AE 05 
  BEQ.B B_DB88                                    ; 00DB7F F0 07 
  BMI.B B_DB87                                    ; 00DB81 30 04 
  DEX                                             ; 00DB83 CA 
  STX.W XexzyDropCountDownTimer                   ; 00DB84 8E AE 05 
B_DB87:
  RTS                                             ; 00DB87 60 

B_DB88:
  PHB                                             ; 00DB88 8B 
  LDA.B #$02                                      ; 00DB89 A9 02 
  PHA                                             ; 00DB8B 48 
  PLB                                             ; 00DB8C AB 
  LDA.W CurrentRound                                     ; 00DB8D AD AB 05 
  ASL                                             ; 00DB90 0A 
  TAX                                             ; 00DB91 AA 
  LDA.W D_BE69-1,X                                  ; 00DB92 BD 68 BE 
  STA.B $04                                       ; 00DB95 85 04 
  LDA.W D_BE69,X                                  ; 00DB97 BD 69 BE 
  STA.B $05                                       ; 00DB9A 85 05 
  LDA.W CurrentRoom                                     ; 00DB9C AD AC 05 
  ASL                                             ; 00DB9F 0A 
  TAY                                             ; 00DBA0 A8 
  LDA.B ($04),Y                                   ; 00DBA1 B1 04 
  STA.B $06                                       ; 00DBA3 85 06 
  INY                                             ; 00DBA5 C8 
  LDA.B ($04),Y                                   ; 00DBA6 B1 04 
  STA.B $07                                       ; 00DBA8 85 07 
  JSL AdvanceRNG                                     ; 00DBAA 22 95 CA 0E 
  STA.W WRMPYA                                    ; 00DBAE 8D 02 42 
  LDA.B #$14                                      ; 00DBB1 A9 14 
  STA.W WRMPYB                                    ; 00DBB3 8D 03 42 
  NOP                                             ; 00DBB6 EA 
  NOP                                             ; 00DBB7 EA 
  NOP                                             ; 00DBB8 EA 
  NOP                                             ; 00DBB9 EA 
  LDY.W RDMPYH                                    ; 00DBBA AC 17 42 
  LDA.B ($06),Y                                   ; 00DBBD B1 06 
  STA.B $07                                       ; 00DBBF 85 07 
  BEQ.B B_DBDD                                    ; 00DBC1 F0 1A 
  CMP.B #$05                                      ; 00DBC3 C9 05 
  BNE.B B_DBCC                                    ; 00DBC5 D0 05 
  LDA.W $05D1                                     ; 00DBC7 AD D1 05 
  BNE.B B_DBDD                                    ; 00DBCA D0 11 
B_DBCC:
  CMP.B #$06                                      ; 00DBCC C9 06 
  BNE.B B_DBD5                                    ; 00DBCE D0 05 
  LDA.W $05CE                                     ; 00DBD0 AD CE 05 
  BPL.B B_DBDD                                    ; 00DBD3 10 08 
B_DBD5:
  PLB                                             ; 00DBD5 AB 
  JSL L_380F3                                     ; 00DBD6 22 F3 80 03 
  BEQ.B B_DBDF                                    ; 00DBDA F0 03 

.byte $60                                         ; 00DBDD .        `

B_DBDD:
  PLB                                             ; 00DBDD AB 
B_DBDE:
  RTS                                             ; 00DBDE 60 

B_DBDF:
  JSL L_38094                                     ; 00DBDF 22 94 80 03 
  LDY.B $07                                       ; 00DBE3 A4 07 
  LDA.W D_DCEC,Y                                  ; 00DBE5 B9 EC DC 
  STA.W EntityV1,X                                   ; 00DBE8 9D 44 07 
  LDA.W D_DCF8,Y                                  ; 00DBEB B9 F8 DC 
  BNE.B B_DBFF                                    ; 00DBEE D0 0F 
  LDA.B #$07                                      ; 00DBF0 A9 07 
  JSL L_38064                                     ; 00DBF2 22 64 80 03 
  BMI.B B_DBDE                                    ; 00DBF6 30 E6 
  STY.W $18D1                                     ; 00DBF8 8C D1 18 
  TYA                                             ; 00DBFB 98 
  ASL                                             ; 00DBFC 0A 
  ORA.B #$28                                      ; 00DBFD 09 28 
B_DBFF:
  STA.W EntityV2,X                                   ; 00DBFF 9D B6 07 
  STA.W EntityV30,X                                   ; 00DC02 9D 2E 14 
  LDA.B #$01                                      ; 00DC05 A9 01 
  STA.W EntityHeader,X                                   ; 00DC07 9D D2 06 
  LDA.B #$08                                      ; 00DC0A A9 08 
  STA.W EntityV3,X                                   ; 00DC0C 9D 28 08 
  LDA.B #$EE                                      ; 00DC0F A9 EE 
  STA.W EntityV29,X                                   ; 00DC11 9D BC 13 
  JSL AdvanceRNG                                     ; 00DC14 22 95 CA 0E 
  AND.B #$1F                                      ; 00DC18 29 1F 
  TAY                                             ; 00DC1A A8 
  LDA.W D_DD1C,Y                                  ; 00DC1B B9 1C DD 
  STA.W XexzyCharX,X                              ; 00DC1E 9D 46 0B 
  JSL AdvanceRNG                                     ; 00DC21 22 95 CA 0E 
  AND.B #$1F                                      ; 00DC25 29 1F 
  TAY                                             ; 00DC27 A8 
  LDA.W D_DD3C,Y                                  ; 00DC28 B9 3C DD 
  LDY.W $188E                                     ; 00DC2B AC 8E 18 
  BEQ.B B_DC36                                    ; 00DC2E F0 06 

.byte $C9,$8C,$90,$02,$A9,$82                     ; 00DC31 ......   ??????

B_DC36:
  STA.W EntityYPx,X                                   ; 00DC36 9D 9C 0C 
  SEC                                             ; 00DC39 38 
  LDA.W XexzyCharX,X                              ; 00DC3A BD 46 0B 
  SBC.B #$06                                      ; 00DC3D E9 06 
  BCS.B B_DC43                                    ; 00DC3F B0 02 

.byte $A9,$00                                     ; 00DC42 ..       ??

B_DC43:
  STA.W EntityV32,X                                   ; 00DC43 9D 16 15 
  CLC                                             ; 00DC46 18 
  LDA.W XexzyCharX,X                              ; 00DC47 BD 46 0B 
  ADC.B #$06                                      ; 00DC4A 69 06 
  BCC.B B_DC50                                    ; 00DC4C 90 02 

.byte $A9,$FF                                     ; 00DC4F ..       ??

B_DC50:
  STA.W EntityV33,X                                   ; 00DC50 9D 88 15 
  SEC                                             ; 00DC53 38 
  LDA.W EntityYPx,X                                   ; 00DC54 BD 9C 0C 
  SBC.B #$06                                      ; 00DC57 E9 06 
  BCS.B B_DC5D                                    ; 00DC59 B0 02 

.byte $A9,$00                                     ; 00DC5C ..       ??

B_DC5D:
  STA.W EntityV34,X                                   ; 00DC5D 9D FA 15 
  CLC                                             ; 00DC60 18 
  LDA.W EntityYPx,X                                   ; 00DC61 BD 9C 0C 
  ADC.B #$06                                      ; 00DC64 69 06 
  BCC.B B_DC6A                                    ; 00DC66 90 02 

.byte $A9,$FF                                     ; 00DC69 ..       ??

B_DC6A:
  STA.W EntityV35,X                                   ; 00DC6A 9D 6C 16 
  STZ.W EntityV27,X                                   ; 00DC6D 9E D8 12 
  LDA.B #$FF                                      ; 00DC70 A9 FF 
  STA.W EntityV28,X                                   ; 00DC72 9D 4A 13 
  JSL L_AEAF                                      ; 00DC75 22 AF AE 00 
  TYA                                             ; 00DC79 98 
  STA.W EntityV31,X                                   ; 00DC7A 9D A0 14 
  LDA.B #$01                                      ; 00DC7D A9 01 
  STA.W $175E,Y                                   ; 00DC7F 99 5E 17 
  JSL L_AEF1                                      ; 00DC82 22 F1 AE 00 
  LDA.B #$08                                      ; 00DC86 A9 08 
  STA.B $1C                                       ; 00DC88 85 1C 
  LDA.B #$08                                      ; 00DC8A A9 08 
  STA.B $1D                                       ; 00DC8C 85 1D 
  JSL L_AFC2                                      ; 00DC8E 22 C2 AF 00 
  SEC                                             ; 00DC92 38 
  LDA.W EntityYPx,X                                   ; 00DC93 BD 9C 0C 
  SBC.B #$08                                      ; 00DC96 E9 08 
  STA.W EntityV20,X                                   ; 00DC98 9D BA 0F 
  LDA.B #$FF                                      ; 00DC9B A9 FF 
  STA.W XexzyDropCountDownTimer                   ; 00DC9D 8D AE 05 
  PHB                                             ; 00DCA0 8B 
  LDA.B #$00                                      ; 00DCA1 A9 00 
  PHA                                             ; 00DCA3 48 
  PLB                                             ; 00DCA4 AB 
  LDA.B #$02                                      ; 00DCA5 A9 02 
  STA.B $05                                       ; 00DCA7 85 05 
  LDA.B $07                                       ; 00DCA9 A5 07 
  ASL                                             ; 00DCAB 0A 
  TAX                                             ; 00DCAC AA 
  LDA.W D_DD04,X                                  ; 00DCAD BD 04 DD 
  STA.B $06                                       ; 00DCB0 85 06 
  LDA.W D_DD05,X                                  ; 00DCB2 BD 05 DD 
  STA.B $07                                       ; 00DCB5 85 07 
  LDY.B #$00                                      ; 00DCB7 A0 00 
B_DCB9:
  LDA.B #$01                                      ; 00DCB9 A9 01 
  STA.W $1A18,Y                                   ; 00DCBB 99 18 1A 
  LDA.B #$18                                      ; 00DCBE A9 18 
  STA.W $1A19,Y                                   ; 00DCC0 99 19 1A 
  LDA.B $06                                       ; 00DCC3 A5 06 
  STA.W $1A1A,Y                                   ; 00DCC5 99 1A 1A 
  CLC                                             ; 00DCC8 18 
  LDA.B $07                                       ; 00DCC9 A5 07 
  STA.W $1A1B,Y                                   ; 00DCCB 99 1B 1A 
  ADC.B #$04                                      ; 00DCCE 69 04 
  STA.B $07                                       ; 00DCD0 85 07 
  LDA.B #$06                                      ; 00DCD2 A9 06 
  STA.W $1A1C,Y                                   ; 00DCD4 99 1C 1A 
  LDA.B #$40                                      ; 00DCD7 A9 40 
  STA.W $1A1D,Y                                   ; 00DCD9 99 1D 1A 
  TYA                                             ; 00DCDC 98 
  CLC                                             ; 00DCDD 18 
  ADC.B #$06                                      ; 00DCDE 69 06 
  TAY                                             ; 00DCE0 A8 
  DEC.B $05                                       ; 00DCE1 C6 05 
  BNE.B B_DCB9                                    ; 00DCE3 D0 D4 
  LDA.B #$FF                                      ; 00DCE5 A9 FF 
  STA.W $1A24                                     ; 00DCE7 8D 24 1A 
  PLB                                             ; 00DCEA AB 
  RTS                                             ; 00DCEB 60 


D_DCEC:
.byte $00,$3C,$3D,$3E,$3F,$40,$41,$42             ; 00DCEC .DDDDDDD ?<=>?@AB
.byte $43,$44,$45,$46                             ; 00DCF5 DDDD     CDEF
D_DCF8:
.byte $00,$22,$24,$00,$22,$22,$00,$22             ; 00DCF8 .DDDDDDD ?"$?""?"
.byte $22,$00,$00,$22                             ; 00DD01 DDDD     "??"
D_DD04:
.byte $00                                         ; 00DD05 .        ?
D_DD05:
.byte $00,$80,$89,$C0,$89,$00,$8A,$40             ; 00DD05 .DDDDDDD ???????@
.byte $8A,$80,$8A,$C0,$8A,$00,$8B,$40             ; 00DD0D DDDDDDDD ???????@
.byte $8B,$80,$8B,$C0,$8B,$C0,$83                 ; 00DD16 DDDDDDD  ???????
D_DD1C:
.byte $64,$6C,$74,$7C,$84,$2C,$34,$3C             ; 00DD1C DDDDDDDD dlt|?,4<
.byte $44,$4C,$54,$5C,$64,$6C,$74,$7C             ; 00DD24 DDDDDDDD DLT\dlt|
.byte $84,$8C,$94,$9C,$A4,$AC,$B4,$BC             ; 00DD2C DDDDDDDD ????????
.byte $C4,$CC,$D4,$84,$7C,$84,$8C,$94             ; 00DD34 DDDDDDDD ????|???
D_DD3C:
.byte $54,$5C,$64,$6C,$74,$7C,$84,$3C             ; 00DD3C DDDDDDDD T\dlt|?<
.byte $44,$4C,$54,$5C,$64,$6C,$74,$7C             ; 00DD44 DDDDDDDD DLT\dlt|
.byte $84,$8C,$94,$9C,$A4,$AC,$B4,$BC             ; 00DD4C DDDDDDDD ????????
.byte $C4,$CC,$7C,$84,$8C,$94,$9C,$A4             ; 00DD54 DDDDDDDD ??|?????
.byte $A6,$10,$BD,$33,$19,$D0,$01,$60             ; 00DD5C ........ ???3???`
.byte $85,$06,$8B,$A9,$00,$48,$AB,$AD             ; 00DD64 ........ ?????H??
.byte $AB,$05,$0A,$A8,$B9,$78,$DE,$85             ; 00DD6C ........ ?????x??
.byte $04,$B9,$79,$DE,$85,$05,$AD,$AC             ; 00DD74 ........ ??y?????
.byte $05,$0A,$A8,$B1,$04,$85,$08,$C8             ; 00DD7C ........ ????????
.byte $B1,$04,$85,$09,$64,$07,$A6,$06             ; 00DD84 ........ ????d???
.byte $DA,$20,$9D,$DD,$18,$A5,$07,$69             ; 00DD8C ........ ? ?????i
.byte $03,$85,$07,$FA,$CA,$D0,$F1,$AB             ; 00DD94 ........ ????????
.byte $60,$22,$F3,$80,$03,$F0,$01,$60             ; 00DD9C ........ `"?????`
.byte $22,$95,$CA,$0E,$29,$03,$D0,$09             ; 00DDA4 ........ "???)???
.byte $A9,$FF,$85,$0B,$A9,$32,$4C,$CE             ; 00DDAC ........ ?????2L?
.byte $DD,$A8,$B9,$52,$DE,$85,$0B,$A8             ; 00DDB4 ........ ???R????
.byte $B9,$9E,$CF,$22,$64,$80,$03,$30             ; 00DDBC ........ ???"d??0
.byte $DE,$98,$A4,$0B,$99,$D6,$18,$0A             ; 00DDC4 ........ ????????
.byte $09,$28,$85,$0A,$EE,$C6,$06,$EE             ; 00DDCC ........ ?(??????
.byte $EF,$18,$22,$94,$80,$03,$A9,$01             ; 00DDD4 ........ ??"?????
.byte $9D,$D2,$06,$A9,$4B,$9D,$44,$07             ; 00DDDC ........ ????K?D?
.byte $A5,$0A,$9D,$B6,$07,$A9,$0C,$9D             ; 00DDE4 ........ ????????
.byte $28,$08,$22,$95,$CA,$0E,$29,$01             ; 00DDEC ........ (?"???)?
.byte $9D,$BA,$0F,$A5,$0B,$9D,$2C,$10             ; 00DDF4 ........ ??????,?
.byte $22,$95,$CA,$0E,$29,$1F,$9D,$80             ; 00DDFC ........ "???)???
.byte $0D,$A9,$C8,$9D,$F2,$0D,$A4,$07             ; 00DE04 ........ ????????
.byte $B1,$08,$9D,$46,$0B,$C8,$B1,$08             ; 00DE0C ........ ???F????
.byte $9D,$9C,$0C,$C8,$B1,$08,$9D,$9E             ; 00DE14 ........ ????????
.byte $10,$BC,$9E,$10,$B9,$62,$DE,$9D             ; 00DE1C ........ ?????b??
.byte $BC,$13,$BD,$B6,$07,$29,$3F,$19             ; 00DE24 ........ ?????)??
.byte $6D,$DE,$9D,$2E,$14,$AC,$C7,$06             ; 00DE2C ........ m??.????
.byte $B9,$59,$C5,$9D,$B8,$0B,$B9,$5C             ; 00DE34 ........ ?Y?????\
.byte $C5,$9D,$0E,$0D,$22,$BC,$AE,$00             ; 00DE3C ........ ????"???
.byte $98,$9D,$A0,$14,$A9,$01,$99,$5E             ; 00DE44 ........ ???????^
.byte $17,$22,$F1,$AE,$00,$60,$00,$01             ; 00DE4C ........ ?"???`??
.byte $02,$00,$01,$02,$00,$01,$02,$00             ; 00DE54 ........ ????????
.byte $01,$02,$00,$01,$02,$00,$00,$60             ; 00DE5C ........ ???????`
.byte $68,$00,$64,$62,$66,$00,$64,$62             ; 00DE64 ........ h?dbf?db
.byte $66,$00,$00,$00,$00,$00,$00,$00             ; 00DE6C ........ f???????
.byte $00,$40,$40,$40,$7E,$DE,$80,$DE             ; 00DE74 ........ ?@@@~???
.byte $88,$DE,$00,$00,$00,$00,$00,$00             ; 00DE7C ........ ????????
.byte $00,$00,$8A,$DE,$00,$00,$49,$49             ; 00DE84 ........ ??????II
.byte $06,$93,$58,$0A,$BF,$B0,$08,$A6             ; 00DE8C ........ ??X?????
.byte $10,$BD,$33,$19,$D0,$01,$60,$85             ; 00DE94 ........ ??3???`?
.byte $06,$8B,$A9,$00,$48,$AB,$AD,$AB             ; 00DE9C ........ ????H???
.byte $05,$0A,$A8,$B9,$4F,$DF,$85,$04             ; 00DEA4 ........ ????O???
.byte $B9,$50,$DF,$85,$05,$AD,$AC,$05             ; 00DEAC ........ ?P??????
.byte $0A,$A8,$B1,$04,$85,$08,$C8,$B1             ; 00DEB4 ........ ????????
.byte $04,$85,$09,$64,$07,$A6,$06,$DA             ; 00DEBC ........ ???d????
.byte $20,$D4,$DE,$18,$A5,$07,$69,$02             ; 00DEC4 ........  ?????i?
.byte $85,$07,$FA,$CA,$D0,$F1,$AB,$60             ; 00DECC ........ ???????`
.byte $22,$F3,$80,$03,$D0,$74,$A9,$01             ; 00DED4 ........ "????t??
.byte $22,$64,$80,$03,$30,$6C,$8C,$DA             ; 00DEDC ........ "d??0l??
.byte $18,$EE,$C6,$06,$EE,$E9,$18,$22             ; 00DEE4 ........ ???????"
.byte $94,$80,$03,$A9,$01,$9D,$D2,$06             ; 00DEEC ........ ????????
.byte $A9,$4F,$9D,$44,$07,$A9,$0C,$9D             ; 00DEF4 ........ ?O?D????
.byte $28,$08,$A9,$66,$9D,$BC,$13,$AD             ; 00DEFC ........ (??f????
.byte $DA,$18,$0A,$09,$28,$9D,$B6,$07             ; 00DF04 ........ ????(???
.byte $9D,$2E,$14,$A4,$07,$B1,$08,$9D             ; 00DF0C ........ ?.??????
.byte $46,$0B,$C8,$B1,$08,$9D,$9C,$0C             ; 00DF14 ........ F???????
.byte $AC,$C7,$06,$B9,$59,$C5,$9D,$B8             ; 00DF1C ........ ????Y???
.byte $0B,$B9,$5C,$C5,$9D,$0E,$0D,$A9             ; 00DF24 ........ ??\?????
.byte $03,$9D,$10,$11,$A9,$C8,$9D,$80             ; 00DF2C ........ ????????
.byte $0D,$A9,$03,$9D,$4A,$13,$9E,$D8             ; 00DF34 ........ ????J???
.byte $12,$22,$BC,$AE,$00,$98,$9D,$A0             ; 00DF3C ........ ?"??????
.byte $14,$A9,$01,$99,$5E,$17,$22,$F1             ; 00DF44 ........ ????^?"?
.byte $AE,$00,$60,$55,$DF,$57,$DF,$77             ; 00DF4C ........ ??`U?W?w
.byte $DF,$00,$00,$00,$00,$9F,$DF,$00             ; 00DF54 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$A1             ; 00DF5C ........ ????????
.byte $DF,$00,$00,$00,$00,$00,$00,$00             ; 00DF64 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00DF6C ........ ????????
.byte $00,$A3,$DF,$00,$00,$00,$00,$00             ; 00DF74 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00DF7C ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00DF84 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00DF8C ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00DF94 ........ ????????
.byte $00,$A5,$DF,$6B,$3A,$CE,$80,$48             ; 00DF9C ........ ???k:??H
.byte $2A,$93,$38                                 ; 00DFA5 ...      *?8


L_DFA7:
  LDX.B $10                                       ; 00DFA7 A6 10 
  LDA.W $1933,X                                   ; 00DFA9 BD 33 19 
  BNE.B B_DFAF                                    ; 00DFAC D0 01 
  RTS                                             ; 00DFAE 60 

B_DFAF:
  STA.B $06                                       ; 00DFAF 85 06 
  PHB                                             ; 00DFB1 8B 
  LDA.B #$00                                      ; 00DFB2 A9 00 
  PHA                                             ; 00DFB4 48 
  PLB                                             ; 00DFB5 AB 
  LDA.W CurrentRound                                     ; 00DFB6 AD AB 05 
  ASL                                             ; 00DFB9 0A 
  TAY                                             ; 00DFBA A8 
  LDA.W D_E070,Y                                  ; 00DFBB B9 70 E0 
  STA.B $04                                       ; 00DFBE 85 04 
  LDA.W D_E071,Y                                  ; 00DFC0 B9 71 E0 
  STA.B $05                                       ; 00DFC3 85 05 
  LDA.W CurrentRoom                                     ; 00DFC5 AD AC 05 
  ASL                                             ; 00DFC8 0A 
  TAY                                             ; 00DFC9 A8 
  LDA.B ($04),Y                                   ; 00DFCA B1 04 
  STA.B $08                                       ; 00DFCC 85 08 
  INY                                             ; 00DFCE C8 
  LDA.B ($04),Y                                   ; 00DFCF B1 04 
  STA.B $09                                       ; 00DFD1 85 09 
  STZ.B $07                                       ; 00DFD3 64 07 
  LDX.B $06                                       ; 00DFD5 A6 06 
B_DFD7:
  PHX                                             ; 00DFD7 DA 
  JSR.W L_DFF6                                    ; 00DFD8 20 F6 DF 
  CLC                                             ; 00DFDB 18 
  LDA.B $07                                       ; 00DFDC A5 07 
  ADC.B #$03                                      ; 00DFDE 69 03 
  STA.B $07                                       ; 00DFE0 85 07 
  PLX                                             ; 00DFE2 FA 
  DEX                                             ; 00DFE3 CA 
  BNE.B B_DFD7                                    ; 00DFE4 D0 F1 
  PLB                                             ; 00DFE6 AB 
  LDA.B #$01                                      ; 00DFE7 A9 01 
  STA.W $186E                                     ; 00DFE9 8D 6E 18 
  JSL L_9CB2                                      ; 00DFEC 22 B2 9C 00 
  LDA.B #$50                                      ; 00DFF0 A9 50 
  STA.W $186E                                     ; 00DFF2 8D 6E 18 
  RTS                                             ; 00DFF5 60 


L_DFF6:
  JSL L_380F3                                     ; 00DFF6 22 F3 80 03 
  BNE.B B_E067                                    ; 00DFFA D0 6B 
  INC.W $06C6                                     ; 00DFFC EE C6 06 
  INC.W $18EC                                     ; 00DFFF EE EC 18 
  JSL L_38094                                     ; 00E002 22 94 80 03 
  LDA.B #$01                                      ; 00E006 A9 01 
  STA.W EntityHeader,X                                   ; 00E008 9D D2 06 
  LDA.B #$30                                      ; 00E00B A9 30 
  STA.W EntityV1,X                                   ; 00E00D 9D 44 07 
  LDA.B #$0C                                      ; 00E010 A9 0C 
  STA.W EntityV3,X                                   ; 00E012 9D 28 08 
  LDA.B #$E6                                      ; 00E015 A9 E6 
  STA.W EntityV15,X                                   ; 00E017 9D 80 0D 
  STZ.W EntityV21,X                                   ; 00E01A 9E 2C 10 
  LDA.B #$3F                                      ; 00E01D A9 3F 
  STA.W EntityV22,X                                   ; 00E01F 9D 9E 10 
  LDY.B $07                                       ; 00E022 A4 07 
  LDA.B ($08),Y                                   ; 00E024 B1 08 
  STA.W XexzyCharX,X                              ; 00E026 9D 46 0B 
  INY                                             ; 00E029 C8 
  LDA.B ($08),Y                                   ; 00E02A B1 08 
  STA.W EntityYPx,X                                   ; 00E02C 9D 9C 0C 
  INY                                             ; 00E02F C8 
  LDA.B ($08),Y                                   ; 00E030 B1 08 
  STA.W EntityV20,X                                   ; 00E032 9D BA 0F 
  TAY                                             ; 00E035 A8 
  LDA.W D_E068,Y                                  ; 00E036 B9 68 E0 
  STA.W EntityV29,X                                   ; 00E039 9D BC 13 
  LDA.B #$26                                      ; 00E03C A9 26 
  STA.W EntityV2,X                                   ; 00E03E 9D B6 07 
  ORA.W D_E06C,Y                                  ; 00E041 19 6C E0 
  STA.W EntityV30,X                                   ; 00E044 9D 2E 14 
  LDY.W $06C7                                     ; 00E047 AC C7 06 
  LDA.W D_C559,Y                                  ; 00E04A B9 59 C5 
  STA.W EntityV11,X                                   ; 00E04D 9D B8 0B 
  LDA.W D_C55C,Y                                  ; 00E050 B9 5C C5 
  STA.W EntityV14,X                                   ; 00E053 9D 0E 0D 
  JSL L_AEBC                                      ; 00E056 22 BC AE 00 
  TYA                                             ; 00E05A 98 
  STA.W EntityV31,X                                   ; 00E05B 9D A0 14 
  LDA.B #$01                                      ; 00E05E A9 01 
  STA.W $175E,Y                                   ; 00E060 99 5E 17 
  JSL L_AEF1                                      ; 00E063 22 F1 AE 00 
B_E067:
  RTS                                             ; 00E067 60 


D_E068:
.byte $EC,$EA,$E8,$EA                             ; 00E069 D.DD     ????
D_E06C:
.byte $00,$40,$00,$00                             ; 00E06D D.DD     ?@??
D_E070:
.byte $76                                         ; 00E071 D        v
D_E071:
.byte $E0,$8A,$E0,$AC,$E0,$00,$00,$00             ; 00E071 D....... ????????
.byte $00,$DC,$E0,$00,$00,$E2,$E0,$00             ; 00E079 ........ ????????
.byte $00,$F7,$E0,$DC,$E0,$F7,$E0,$F7             ; 00E081 .DDDD..D ????????
.byte $E0,$00,$00,$00,$00,$00,$E1,$00             ; 00E089 D....... ????????
.byte $00,$00,$00,$00,$E1,$00,$00,$00             ; 00E091 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00E099 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00E0A1 ........ ????????
.byte $00,$00,$E1,$00,$00,$00,$00,$00             ; 00E0A9 ........ ????????
.byte $00,$DC,$E0,$03,$E1,$00,$00,$00             ; 00E0B1 ........ ????????
.byte $00,$00,$00,$00,$00,$03,$E1,$00             ; 00E0B9 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00E0C1 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$03             ; 00E0C9 ........ ????????
.byte $E1,$00,$00,$03,$E1,$00,$00,$00             ; 00E0D1 ........ ????????
.byte $00,$03,$E1,$31,$33,$03,$E2,$3A             ; 00E0D9 ...DDDDD ???13??:
.byte $00,$31,$33,$03,$E2,$3A,$00,$3C             ; 00E0E1 D....... ?13??:?<
.byte $46,$03,$BE,$50,$02,$48,$96,$02             ; 00E0E9 ........ F??P?H??
.byte $19,$D0,$02,$E6,$D0,$02,$31,$33             ; 00E0F1 ......DD ??????13
.byte $03,$E2,$3A,$00,$19,$D0,$02,$31             ; 00E0F9 DDDDDDD. ??:????1
.byte $33,$03,$31,$33,$03,$E2,$3A,$00             ; 00E101 ........ 3?13??:?
.byte $19,$D0,$02,$E6,$D0,$02                     ; 00E10A ......   ??????


L_E10F:
  LDX.B $10                                       ; 00E10F A6 10 
  LDA.W $1933,X                                   ; 00E111 BD 33 19 
  BNE.B B_E117                                    ; 00E114 D0 01 
  RTS                                             ; 00E116 60 

B_E117:
  STA.B $06                                       ; 00E117 85 06 
  PHB                                             ; 00E119 8B 
  LDA.B #$00                                      ; 00E11A A9 00 
  PHA                                             ; 00E11C 48 
  PLB                                             ; 00E11D AB 
  LDA.W CurrentRound                                     ; 00E11E AD AB 05 
  ASL                                             ; 00E121 0A 
  TAY                                             ; 00E122 A8 
  LDA.W D_E1E8,Y                                  ; 00E123 B9 E8 E1 
  STA.B $04                                       ; 00E126 85 04 
  LDA.W D_E1E9,Y                                  ; 00E128 B9 E9 E1 
  STA.B $05                                       ; 00E12B 85 05 
  LDA.W CurrentRoom                                     ; 00E12D AD AC 05 
  ASL                                             ; 00E130 0A 
  TAY                                             ; 00E131 A8 
  LDA.B ($04),Y                                   ; 00E132 B1 04 
  STA.B $08                                       ; 00E134 85 08 
  INY                                             ; 00E136 C8 
  LDA.B ($04),Y                                   ; 00E137 B1 04 
  STA.B $09                                       ; 00E139 85 09 
  STZ.B $05                                       ; 00E13B 64 05 
  LDX.B $06                                       ; 00E13D A6 06 
B_E13F:
  PHX                                             ; 00E13F DA 
  JSR.W L_E15E                                    ; 00E140 20 5E E1 
  CLC                                             ; 00E143 18 
  LDA.B $05                                       ; 00E144 A5 05 
  ADC.B #$03                                      ; 00E146 69 03 
  STA.B $05                                       ; 00E148 85 05 
  PLX                                             ; 00E14A FA 
  DEX                                             ; 00E14B CA 
  BNE.B B_E13F                                    ; 00E14C D0 F1 
  PLB                                             ; 00E14E AB 
  LDA.B #$01                                      ; 00E14F A9 01 
  STA.W $186D                                     ; 00E151 8D 6D 18 
  JSL L_9CB2                                      ; 00E154 22 B2 9C 00 
  LDA.B #$64                                      ; 00E158 A9 64 
  STA.W $186D                                     ; 00E15A 8D 6D 18 
  RTS                                             ; 00E15D 60 


L_E15E:
  JSL L_380F3                                     ; 00E15E 22 F3 80 03 
  BNE.B B_E1D7                                    ; 00E162 D0 73 
  LDA.B #$05                                      ; 00E164 A9 05 
  JSL L_38064                                     ; 00E166 22 64 80 03 
  BMI.B B_E1D7                                    ; 00E16A 30 6B 
  STY.W $18D3                                     ; 00E16C 8C D3 18 
  TYA                                             ; 00E16F 98 
  ASL                                             ; 00E170 0A 
  ORA.B #$28                                      ; 00E171 09 28 
  STA.B $04                                       ; 00E173 85 04 
  INC.W $06C6                                     ; 00E175 EE C6 06 
  INC.W $18E4                                     ; 00E178 EE E4 18 
  JSL L_38094                                     ; 00E17B 22 94 80 03 
  LDA.B #$01                                      ; 00E17F A9 01 
  STA.W EntityHeader,X                                   ; 00E181 9D D2 06 
  LDA.B $04                                       ; 00E184 A5 04 
  STA.W EntityV2,X                                   ; 00E186 9D B6 07 
  LDA.B #$2B                                      ; 00E189 A9 2B 
  STA.W EntityV1,X                                   ; 00E18B 9D 44 07 
  LDA.B #$FA                                      ; 00E18E A9 FA 
  STA.W EntityV15,X                                   ; 00E190 9D 80 0D 
  LDA.B #$0C                                      ; 00E193 A9 0C 
  STA.W EntityV3,X                                   ; 00E195 9D 28 08 
  LDY.B $05                                       ; 00E198 A4 05 
  LDA.B ($08),Y                                   ; 00E19A B1 08 
  STA.W XexzyCharX,X                              ; 00E19C 9D 46 0B 
  INY                                             ; 00E19F C8 
  LDA.B ($08),Y                                   ; 00E1A0 B1 08 
  STA.W EntityYPx,X                                   ; 00E1A2 9D 9C 0C 
  INY                                             ; 00E1A5 C8 
  LDA.B ($08),Y                                   ; 00E1A6 B1 08 
  TAY                                             ; 00E1A8 A8 
  LDA.W D_E1D8,Y                                  ; 00E1A9 B9 D8 E1 
  STA.W EntityV29,X                                   ; 00E1AC 9D BC 13 
  LDA.B $04                                       ; 00E1AF A5 04 
  ORA.W D_E1E0,Y                                  ; 00E1B1 19 E0 E1 
  STA.W EntityV30,X                                   ; 00E1B4 9D 2E 14 
  LDY.W $06C7                                     ; 00E1B7 AC C7 06 
  LDA.W D_C559,Y                                  ; 00E1BA B9 59 C5 
  STA.W EntityV11,X                                   ; 00E1BD 9D B8 0B 
  LDA.W D_C55C,Y                                  ; 00E1C0 B9 5C C5 
  STA.W EntityV14,X                                   ; 00E1C3 9D 0E 0D 
  JSL L_AEBC                                      ; 00E1C6 22 BC AE 00 
  TYA                                             ; 00E1CA 98 
  STA.W EntityV31,X                                   ; 00E1CB 9D A0 14 
  LDA.B #$01                                      ; 00E1CE A9 01 
  STA.W $175E,Y                                   ; 00E1D0 99 5E 17 
  JSL L_AEF1                                      ; 00E1D3 22 F1 AE 00 
B_E1D7:
  RTS                                             ; 00E1D7 60 


D_E1D8:
.byte $C4,$C6,$C8,$CA,$CC,$CA,$C8,$C6             ; 00E1D8 DDDDDDDD ????????
D_E1E0:
.byte $00,$00,$00,$00,$00,$40,$40,$40             ; 00E1E0 DDDDDDDD ?????@@@
D_E1E8:
.byte $EE                                         ; 00E1E9 D        ?
D_E1E9:
.byte $E1,$FE,$E1,$00,$E2,$00,$00,$30             ; 00E1E9 D......D ???????0
.byte $E2,$3C,$E2,$00,$00,$00,$00,$00             ; 00E1F1 D....... ?<??????
.byte $00,$6C,$E2,$9C,$E2,$00,$00,$00             ; 00E1F9 .DDDD... ?l??????
.byte $00,$00,$00,$00,$00,$CC,$E2,$00             ; 00E201 ........ ????????
.byte $00,$00,$00,$EA,$E2,$00,$00,$CC             ; 00E209 ........ ????????
.byte $E2,$00,$00,$00,$00,$DB,$E2,$00             ; 00E211 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00E219 ........ ????????
.byte $00,$FC,$E2,$FF,$E2,$00,$00,$ED             ; 00E221 ........ ????????
.byte $E2,$00,$00,$00,$00,$ED,$E2,$6A             ; 00E229 .......D ???????j
.byte $BF,$00,$D6,$AE,$07,$BA,$87,$06             ; 00E231 DDDDDDDD ????????
.byte $D6,$68,$06,$68,$CE,$02,$68,$BD             ; 00E239 DDD..... ?h?h??h?
.byte $02,$68,$A9,$02,$5C,$97,$01,$56             ; 00E241 ........ ?h??\??V
.byte $82,$02,$59,$6F,$02,$65,$5F,$03             ; 00E249 ........ ??Yo?e_?
.byte $73,$53,$04,$8D,$53,$04,$9B,$5F             ; 00E251 ........ sS??S??_
.byte $05,$A7,$6F,$06,$AA,$82,$06,$A3             ; 00E259 ........ ??o?????
.byte $97,$07,$98,$A9,$06,$98,$BD,$06             ; 00E261 ........ ????????
.byte $98,$CE,$06,$68,$32,$02,$68,$43             ; 00E269 ...DDDDD ???h2?hC
.byte $02,$68,$57,$02,$5B,$69,$03,$56             ; 00E271 DDDDDDDD ?hW?[i?V
.byte $7E,$02,$59,$91,$02,$65,$A1,$01             ; 00E279 DDDDDDDD ~?Y??e??
.byte $72,$AE,$00,$8E,$AE,$00,$9B,$A1             ; 00E281 DDDDDDDD r???????
.byte $07,$A7,$91,$06,$AA,$7E,$06,$A5             ; 00E289 DDDDDDDD ?????~??
.byte $69,$05,$98,$57,$06,$98,$43,$06             ; 00E291 DDDDDDDD i??W??C?
.byte $98,$32,$06,$19,$64,$04,$2B,$64             ; 00E299 DDDDDDDD ?2??d?+d
.byte $04,$3C,$64,$04,$51,$64,$04,$68             ; 00E2A1 DDDDDDDD ?<d?Qd?h
.byte $5D,$03,$80,$57,$04,$97,$5E,$05             ; 00E2A9 DDDDDDDD ]??W??^?
.byte $A7,$72,$06,$19,$96,$00,$2B,$96             ; 00E2B1 DDDDDDDD ?r????+?
.byte $00,$3C,$96,$00,$51,$96,$00,$68             ; 00E2B9 DDDDDDDD ?<??Q??h
.byte $9E,$01,$80,$A5,$00,$99,$9E,$07             ; 00E2C1 DDDDDDDD ????????
.byte $A7,$8C,$06,$90,$58,$05,$9D,$64             ; 00E2C9 DDD..... ????X??d
.byte $05,$A3,$72,$06,$A3,$84,$06,$9C             ; 00E2D1 ........ ??r?????
.byte $92,$07,$3C,$61,$02,$4F,$82,$02             ; 00E2D9 ........ ??<a?O??
.byte $41,$9A,$02,$C5,$6E,$06,$B7,$A2             ; 00E2E1 ........ A???n???
.byte $07,$8E,$B7,$07,$6A,$30,$04,$57             ; 00E2E9 ........ ????j0?W
.byte $4B,$03,$A2,$46,$05,$B3,$5D,$06             ; 00E2F1 ........ K??F??]?
.byte $9C,$68,$06,$9F,$A2,$07,$81,$33             ; 00E2F9 ........ ?h?????3
.byte $04,$64,$3F,$03,$69,$5A,$03,$A2             ; 00E301 ........ ?d??iZ??
.byte $9A,$07,$A6,$10,$BD,$33,$19,$D0             ; 00E309 ........ ?????3??
.byte $01,$60,$85,$06,$8B,$A9,$00,$48             ; 00E311 ........ ?`?????H
.byte $AB,$AD,$AB,$05,$0A,$A8,$B9,$E4             ; 00E319 ........ ????????
.byte $E3,$85,$04,$B9,$E5,$E3,$85,$05             ; 00E321 ........ ????????
.byte $AD,$AC,$05,$0A,$A8,$B1,$04,$85             ; 00E329 ........ ????????
.byte $08,$C8,$B1,$04,$85,$09,$64,$05             ; 00E331 ........ ??????d?
.byte $A6,$06,$DA,$20,$5A,$E3,$18,$A5             ; 00E339 ........ ??? Z???
.byte $05,$69,$03,$85,$05,$FA,$CA,$D0             ; 00E341 ........ ?i??????
.byte $F1,$AB,$A9,$01,$8D,$6D,$18,$22             ; 00E349 ........ ?????m?"
.byte $B2,$9C,$00,$A9,$64,$8D,$6D,$18             ; 00E351 ........ ????d?m?
.byte $60,$22,$F3,$80,$03,$D0,$73,$A9             ; 00E359 ........ `"????s?
.byte $09,$22,$64,$80,$03,$30,$6B,$8C             ; 00E361 ........ ?"d??0k?
.byte $D3,$18,$98,$0A,$09,$28,$85,$04             ; 00E369 ........ ?????(??
.byte $EE,$C6,$06,$EE,$E8,$18,$22,$94             ; 00E371 ........ ??????"?
.byte $80,$03,$A9,$01,$9D,$D2,$06,$A5             ; 00E379 ........ ????????
.byte $04,$9D,$B6,$07,$A9,$5F,$9D,$44             ; 00E381 ........ ?????_?D
.byte $07,$A9,$FA,$9D,$80,$0D,$A9,$0C             ; 00E389 ........ ????????
.byte $9D,$28,$08,$A4,$05,$B1,$08,$9D             ; 00E391 ........ ?(??????
.byte $46,$0B,$C8,$B1,$08,$9D,$9C,$0C             ; 00E399 ........ F???????
.byte $C8,$B1,$08,$A8,$B9,$D4,$E3,$9D             ; 00E3A1 ........ ????????
.byte $BC,$13,$A5,$04,$19,$DC,$E3,$9D             ; 00E3A9 ........ ????????
.byte $2E,$14,$AC,$C7,$06,$B9,$59,$C5             ; 00E3B1 ........ .?????Y?
.byte $9D,$B8,$0B,$B9,$5C,$C5,$9D,$0E             ; 00E3B9 ........ ????\???
.byte $0D,$22,$BC,$AE,$00,$98,$9D,$A0             ; 00E3C1 ........ ?"??????
.byte $14,$A9,$01,$99,$5E,$17,$22,$F1             ; 00E3C9 ........ ????^?"?
.byte $AE,$00,$60,$C4,$C6,$C8,$CA,$CC             ; 00E3D1 ........ ??`?????
.byte $CA,$C8,$C6,$00,$00,$00,$00,$00             ; 00E3D9 ........ ????????
.byte $40,$40,$40,$EA,$E3,$EA,$E3,$EA             ; 00E3E1 ........ @@@?????
.byte $E3,$00,$00,$06,$E4,$1E,$E4,$00             ; 00E3E9 ........ ????????
.byte $00,$27,$E4,$00,$00,$00,$00,$00             ; 00E3F1 ........ ?'??????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00E3F9 ........ ????????
.byte $00,$00,$00,$36,$E4,$54,$46,$04             ; 00E401 ........ ???6?TF?
.byte $70,$54,$05,$99,$3A,$05,$AA,$45             ; 00E409 ........ pT??:??E
.byte $06,$D9,$52,$06,$B1,$85,$06,$A0             ; 00E411 ........ ??R?????
.byte $BA,$07,$63,$C2,$00,$7C,$30,$04             ; 00E419 ........ ??c??|0?
.byte $D3,$79,$06,$B7,$B6,$07,$94,$40             ; 00E421 ........ ?y?????@
.byte $04,$6C,$45,$05,$27,$6D,$02,$51             ; 00E429 ........ ?lE?'m?Q
.byte $88,$02,$24,$8C,$01,$4F,$49,$04             ; 00E431 ........ ??$??OI?
.byte $AF,$42,$05,$D9,$44,$05,$B9,$53             ; 00E439 ........ ?B??D??S
.byte $06,$D4,$6C,$06,$55,$8F,$02,$3B             ; 00E441 ........ ??l?U??;
.byte $A3,$02,$5C,$AD,$01,$AD,$C3,$07             ; 00E449 ........ ??\?????
.byte $C5,$CA,$07                                 ; 00E452 ...      ???


L_E454:
  PHP                                             ; 00E454 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00E455 E2 30 
  LDX.B #$0F                                      ; 00E457 A2 0F 
B_E459:
  STZ.B XexzyScore,X                              ; 00E459 74 97 
  DEX                                             ; 00E45B CA 
  BPL.B B_E459                                    ; 00E45C 10 FB 
  PLP                                             ; 00E45E 28 
  RTL                                             ; 00E45F 6B 

.byte $08,$E2,$30,$A2,$0F,$9E,$BC,$05             ; 00E460 ........ ??0?????
.byte $CA,$10,$FA,$28,$6B                         ; 00E469 .....    ???(k


L_E46D:
  PHX                                             ; 00E46D DA 
  ASL                                             ; 00E46E 0A 
  ASL                                             ; 00E46F 0A 
  ASL                                             ; 00E470 0A 
  TAX                                             ; 00E471 AA 
  LDA.B $A7                                       ; 00E472 A5 A7 
  AND.B #$0F                                      ; 00E474 29 0F 
  STA.B $AA                                       ; 00E476 85 AA 
  LDA.B $A7                                       ; 00E478 A5 A7 
  LSR                                             ; 00E47A 4A 
  LSR                                             ; 00E47B 4A 
  LSR                                             ; 00E47C 4A 
  LSR                                             ; 00E47D 4A 
  STA.B $AB                                       ; 00E47E 85 AB 
  LDA.B $A8                                       ; 00E480 A5 A8 
  AND.B #$0F                                      ; 00E482 29 0F 
  STA.B $AC                                       ; 00E484 85 AC 
  LDA.B $A8                                       ; 00E486 A5 A8 
  LSR                                             ; 00E488 4A 
  LSR                                             ; 00E489 4A 
  LSR                                             ; 00E48A 4A 
  LSR                                             ; 00E48B 4A 
  STA.B $AD                                       ; 00E48C 85 AD 
  LDA.B $A9                                       ; 00E48E A5 A9 
  AND.B #$0F                                      ; 00E490 29 0F 
  STA.B $AE                                       ; 00E492 85 AE 
  LDA.B $A9                                       ; 00E494 A5 A9 
  LSR                                             ; 00E496 4A 
  LSR                                             ; 00E497 4A 
  LSR                                             ; 00E498 4A 
  LSR                                             ; 00E499 4A 
  STA.B $AF                                       ; 00E49A 85 AF 
  CLC                                             ; 00E49C 18 
  LDA.B XexzyScore,X                              ; 00E49D B5 97 
  ADC.B $AA                                       ; 00E49F 65 AA 
  CMP.B #$0A                                      ; 00E4A1 C9 0A 
  BCC.B B_E4A7                                    ; 00E4A3 90 02 

.byte $E9,$0A                                     ; 00E4A6 ..       ??

B_E4A7:
  STA.B XexzyScore,X                              ; 00E4A7 95 97 
  LDA.B $98,X                                     ; 00E4A9 B5 98 
  ADC.B $AB                                       ; 00E4AB 65 AB 
  CMP.B #$0A                                      ; 00E4AD C9 0A 
  BCC.B B_E4B3                                    ; 00E4AF 90 02 
  SBC.B #$0A                                      ; 00E4B1 E9 0A 
B_E4B3:
  STA.B $98,X                                     ; 00E4B3 95 98 
  LDA.B $99,X                                     ; 00E4B5 B5 99 
  ADC.B $AC                                       ; 00E4B7 65 AC 
  CMP.B #$0A                                      ; 00E4B9 C9 0A 
  BCC.B B_E4BF                                    ; 00E4BB 90 02 
  SBC.B #$0A                                      ; 00E4BD E9 0A 
B_E4BF:
  STA.B $99,X                                     ; 00E4BF 95 99 
  LDA.B $9A,X                                     ; 00E4C1 B5 9A 
  ADC.B $AD                                       ; 00E4C3 65 AD 
  CMP.B #$0A                                      ; 00E4C5 C9 0A 
  BCC.B B_E4CB                                    ; 00E4C7 90 02 
  SBC.B #$0A                                      ; 00E4C9 E9 0A 
B_E4CB:
  STA.B $9A,X                                     ; 00E4CB 95 9A 
  LDA.B $9B,X                                     ; 00E4CD B5 9B 
  ADC.B $AE                                       ; 00E4CF 65 AE 
  CMP.B #$0A                                      ; 00E4D1 C9 0A 
  BCC.B B_E4D7                                    ; 00E4D3 90 02 
  SBC.B #$0A                                      ; 00E4D5 E9 0A 
B_E4D7:
  STA.B $9B,X                                     ; 00E4D7 95 9B 
  LDA.B $9C,X                                     ; 00E4D9 B5 9C 
  ADC.B $AF                                       ; 00E4DB 65 AF 
  CMP.B #$0A                                      ; 00E4DD C9 0A 
  BCC.B B_E4E3                                    ; 00E4DF 90 02 
  SBC.B #$0A                                      ; 00E4E1 E9 0A 
B_E4E3:
  STA.B $9C,X                                     ; 00E4E3 95 9C 
  LDA.B $9D,X                                     ; 00E4E5 B5 9D 
  ADC.B #$00                                      ; 00E4E7 69 00 
  CMP.B #$0A                                      ; 00E4E9 C9 0A 
  BCC.B B_E4EF                                    ; 00E4EB 90 02 

.byte $E9,$0A                                     ; 00E4EE ..       ??

B_E4EF:
  STA.B $9D,X                                     ; 00E4EF 95 9D 
  LDA.B $9E,X                                     ; 00E4F1 B5 9E 
  ADC.B #$00                                      ; 00E4F3 69 00 
  CMP.B #$0A                                      ; 00E4F5 C9 0A 
  BCC.B B_E4FB                                    ; 00E4F7 90 02 

.byte $E9,$0A                                     ; 00E4FA ..       ??

B_E4FB:
  STA.B $9E,X                                     ; 00E4FB 95 9E 
  PLX                                             ; 00E4FD FA 
  RTL                                             ; 00E4FE 6B 

.byte $DA,$0A,$0A,$0A,$AA,$A5,$A7,$29             ; 00E4FF ........ ???????)
.byte $0F,$85,$AA,$A5,$A7,$4A,$4A,$4A             ; 00E507 ........ ?????JJJ
.byte $4A,$85,$AB,$A5,$A8,$29,$0F,$85             ; 00E50F ........ J????)??
.byte $AC,$A5,$A8,$4A,$4A,$4A,$4A,$85             ; 00E517 ........ ???JJJJ?
.byte $AD,$18,$BD,$BC,$05,$65,$AA,$C9             ; 00E51F ........ ?????e??
.byte $0A,$90,$02,$E9,$0A,$9D,$BC,$05             ; 00E527 ........ ????????
.byte $BD,$BD,$05,$65,$AB,$C9,$0A,$90             ; 00E52F ........ ???e????
.byte $02,$E9,$0A,$9D,$BD,$05,$BD,$BE             ; 00E537 ........ ????????
.byte $05,$65,$AC,$C9,$0A,$90,$02,$E9             ; 00E53F ........ ?e??????
.byte $0A,$9D,$BE,$05,$BD,$BF,$05,$65             ; 00E547 ........ ???????e
.byte $AD,$C9,$0A,$90,$02,$E9,$0A,$9D             ; 00E54F ........ ????????
.byte $BF,$05,$BD,$C0,$05,$69,$00,$C9             ; 00E557 ........ ?????i??
.byte $0A,$90,$02,$E9,$0A,$9D,$C0,$05             ; 00E55F ........ ????????
.byte $BD,$C1,$05,$69,$00,$C9,$0A,$90             ; 00E567 ........ ???i????
.byte $02,$E9,$0A,$9D,$C1,$05,$BD,$C2             ; 00E56F ........ ????????
.byte $05,$69,$00,$C9,$0A,$90,$02,$E9             ; 00E577 ........ ?i??????
.byte $0A,$9D,$C2,$05,$BD,$C3,$05,$69             ; 00E57F ........ ???????i
.byte $00,$C9,$0A,$90,$02,$E9,$0A,$9D             ; 00E587 ........ ????????
.byte $C3,$05,$FA,$6B                             ; 00E590 ....     ???k


L_E593:
  PHB                                             ; 00E593 8B 
  STA.W $187E,X                                   ; 00E594 9D 7E 18 
  TAY                                             ; 00E597 A8 
  LDA.B #$00                                      ; 00E598 A9 00 
  PHA                                             ; 00E59A 48 
  PLB                                             ; 00E59B AB 
  LDA.W D_E6AB,Y                                  ; 00E59C B9 AB E6 
  STA.B $04                                       ; 00E59F 85 04 
  LDA.W D_E6E0,Y                                  ; 00E5A1 B9 E0 E6 
  STA.B $05                                       ; 00E5A4 85 05 
  STZ.W $1880,X                                   ; 00E5A6 9E 80 18 
  LDY.B #$00                                      ; 00E5A9 A0 00 
  LDA.B ($04),Y                                   ; 00E5AB B1 04 
  STA.W $1882,X                                   ; 00E5AD 9D 82 18 
  INY                                             ; 00E5B0 C8 
  LDA.B ($04),Y                                   ; 00E5B1 B1 04 
  STA.W $1884,X                                   ; 00E5B3 9D 84 18 
  STZ.W $187C,X                                   ; 00E5B6 9E 7C 18 
  LDA.B #$01                                      ; 00E5B9 A9 01 
  STA.W $19D3,X                                   ; 00E5BB 9D D3 19 
  PLB                                             ; 00E5BE AB 
  RTL                                             ; 00E5BF 6B 

L_E5C0:
  PHB                                             ; 00E5C0 8B 
  STA.W $1876,X                                   ; 00E5C1 9D 76 18 
  TAY                                             ; 00E5C4 A8 
  LDA.B #$00                                      ; 00E5C5 A9 00 
  PHA                                             ; 00E5C7 48 
  PLB                                             ; 00E5C8 AB 
  LDA.W D_E6AB,Y                                  ; 00E5C9 B9 AB E6 
  STA.B $04                                       ; 00E5CC 85 04 
  LDA.W D_E6E0,Y                                  ; 00E5CE B9 E0 E6 
  STA.B $05                                       ; 00E5D1 85 05 
  STZ.W $1878,X                                   ; 00E5D3 9E 78 18 
  LDY.B #$00                                      ; 00E5D6 A0 00 
  LDA.B ($04),Y                                   ; 00E5D8 B1 04 
  STA.W $187A,X                                   ; 00E5DA 9D 7A 18 
  INY                                             ; 00E5DD C8 
  LDA.B ($04),Y                                   ; 00E5DE B1 04 
  STA.W XexzyWalkAnimation,X                      ; 00E5E0 9D 86 18 
  STZ.W $1874,X                                   ; 00E5E3 9E 74 18 
  LDA.B #$01                                      ; 00E5E6 A9 01 
  STA.W $19D5,X                                   ; 00E5E8 9D D5 19 
  PLB                                             ; 00E5EB AB 
  RTL                                             ; 00E5EC 6B 

L_E5ED:
  PHP                                             ; 00E5ED 08 
  PHB                                             ; 00E5EE 8B 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00E5EF E2 30 
  LDA.B #$00                                      ; 00E5F1 A9 00 
  PHA                                             ; 00E5F3 48 
  PLB                                             ; 00E5F4 AB 
  LDX.B #$01                                      ; 00E5F5 A2 01 
B_E5F7:
  LDA.W $1874,X                                   ; 00E5F7 BD 74 18 
  BNE.B B_E63D                                    ; 00E5FA D0 41 
  DEC.W $187A,X                                   ; 00E5FC DE 7A 18 
  BNE.B B_E63D                                    ; 00E5FF D0 3C 
  LDY.W $1876,X                                   ; 00E601 BC 76 18 
  LDA.W D_E6AB,Y                                  ; 00E604 B9 AB E6 
  STA.B $04                                       ; 00E607 85 04 
  LDA.W D_E6E0,Y                                  ; 00E609 B9 E0 E6 
  STA.B $05                                       ; 00E60C 85 05 
  INC.W $1878,X                                   ; 00E60E FE 78 18 
  LDA.W $1878,X                                   ; 00E611 BD 78 18 
  ASL                                             ; 00E614 0A 
  TAY                                             ; 00E615 A8 
  LDA.B ($04),Y                                   ; 00E616 B1 04 
  BNE.B B_E62F                                    ; 00E618 D0 15 
  INY                                             ; 00E61A C8 
  LDA.B ($04),Y                                   ; 00E61B B1 04 
  BEQ.B B_E628                                    ; 00E61D F0 09 
  LDA.W $1876,X                                   ; 00E61F BD 76 18 
  JSL L_E5C0                                      ; 00E622 22 C0 E5 00 
  BRA.B B_E63D                                    ; 00E626 80 15 

B_E628:
.byte $A9,$01,$9D,$74,$18,$80,$0E                 ; 00E629 .......  ???t???

B_E62F:
  STA.W $187A,X                                   ; 00E62F 9D 7A 18 
  INY                                             ; 00E632 C8 
  LDA.B ($04),Y                                   ; 00E633 B1 04 
  STA.W XexzyWalkAnimation,X                      ; 00E635 9D 86 18 
  LDA.B #$01                                      ; 00E638 A9 01 
  STA.W $19D5,X                                   ; 00E63A 9D D5 19 
B_E63D:
  DEX                                             ; 00E63D CA 
  BPL.B B_E5F7                                    ; 00E63E 10 B7 
  LDX.B #$01                                      ; 00E640 A2 01 
B_E642:
  LDA.W $187C,X                                   ; 00E642 BD 7C 18 
  BNE.B B_E6A5                                    ; 00E645 D0 5E 
  DEC.W $1882,X                                   ; 00E647 DE 82 18 
  BNE.B B_E6A5                                    ; 00E64A D0 59 
  LDY.W $187E,X                                   ; 00E64C BC 7E 18 
  LDA.W D_E6AB,Y                                  ; 00E64F B9 AB E6 
  STA.B $04                                       ; 00E652 85 04 
  LDA.W D_E6E0,Y                                  ; 00E654 B9 E0 E6 
  STA.B $05                                       ; 00E657 85 05 
  INC.W $1880,X                                   ; 00E659 FE 80 18 
  LDA.W $1880,X                                   ; 00E65C BD 80 18 
  ASL                                             ; 00E65F 0A 
  TAY                                             ; 00E660 A8 
  LDA.B ($04),Y                                   ; 00E661 B1 04 
  BNE.B B_E67A                                    ; 00E663 D0 15 
  INY                                             ; 00E665 C8 
  LDA.B ($04),Y                                   ; 00E666 B1 04 
  BEQ.B B_E673                                    ; 00E668 F0 09 

.byte $BD,$7E,$18,$22,$93,$E5,$00,$80             ; 00E66A ........ ?~?"????
.byte $32                                         ; 00E673 .        2

B_E673:
  LDA.B #$01                                      ; 00E673 A9 01 
  STA.W $187C,X                                   ; 00E675 9D 7C 18 
  BRA.B B_E6A5                                    ; 00E678 80 2B 
B_E67A:
  STA.W $1882,X                                   ; 00E67A 9D 82 18 
  INY                                             ; 00E67D C8 
  LDA.B ($04),Y                                   ; 00E67E B1 04 
  STA.W $1884,X                                   ; 00E680 9D 84 18 
  LDA.B #$01                                      ; 00E683 A9 01 
  STA.W $19D3,X                                   ; 00E685 9D D3 19 
  LDA.W $187E,X                                   ; 00E688 BD 7E 18 
  CMP.B #$2A                                      ; 00E68B C9 2A 
  BNE.B B_E6A5                                    ; 00E68D D0 16 
  LDA.W $1880,X                                   ; 00E68F BD 80 18 
  CMP.B #$0E                                      ; 00E692 C9 0E 
  BNE.B B_E6A5                                    ; 00E694 D0 0F 
  PHX                                             ; 00E696 DA 
  REP.B #$10                                      ; 00E697 C2 10 
  LDA.B #$07                                      ; 00E699 A9 07 
  LDX.W #$FF0B                                    ; 00E69B A2 0B FF 
  JSL Audio_F830F                                     ; 00E69E 22 0F 83 0F 
  SEP.B #$10                                      ; 00E6A2 E2 10 
  PLX                                             ; 00E6A4 FA 
B_E6A5:
  DEX                                             ; 00E6A5 CA 
  BPL.B B_E642                                    ; 00E6A6 10 9A 
  PLB                                             ; 00E6A8 AB 
  PLP                                             ; 00E6A9 28 
  RTS                                             ; 00E6AA 60 


D_E6AB:
.byte $15,$15,$23,$33,$43,$51,$43,$33             ; 00E6AB .DDDDDDD ??#3CQC3
.byte $23,$63,$63,$69,$6F,$75,$7B,$75             ; 00E6B3 D.DDDDDD #cciou{u
.byte $6F,$69,$81,$87,$8D,$93,$99,$93             ; 00E6BB DDDDDDDD oi??????
.byte $8D,$87,$9F,$A3,$A7,$AB,$AF,$AB             ; 00E6C3 DDDDDDDD ????????
.byte $A7,$A3,$B3,$B7,$BB,$BF,$C3,$BF             ; 00E6CB DDDDDDDD ????????
.byte $BB,$B7,$C9,$07,$2F,$65,$6B,$71             ; 00E6D3 DDDD..DD ????/ekq
.byte $77,$7D,$77,$71,$6B                         ; 00E6DC D....    w}wqk
D_E6E0:
.byte $E7,$E7,$E7,$E7,$E7,$E7,$E7,$E7             ; 00E6E0 .DDDDDDD ????????
.byte $E7,$E7,$E7,$E7,$E7,$E7,$E7,$E7             ; 00E6E8 D.DDDDDD ????????
.byte $E7,$E7,$E7,$E7,$E7,$E7,$E7,$E7             ; 00E6F0 DDDDDDDD ????????
.byte $E7,$E7,$E7,$E7,$E7,$E7,$E7,$E7             ; 00E6F8 DDDDDDDD ????????
.byte $E7,$E7,$E7,$E7,$E7,$E7,$E7,$E7             ; 00E700 DDDDDDDD ????????
.byte $E7,$E7,$E7,$E8,$E8,$E8,$E8,$E8             ; 00E708 DDDD..DD ????????
.byte $E8,$E8,$E8,$E8,$E8,$05,$01,$05             ; 00E710 D....DDD ????????
.byte $02,$05,$03,$05,$04,$05,$05,$05             ; 00E718 DDDDDDDD ????????
.byte $06,$00,$01,$04,$09,$04,$0A,$04             ; 00E720 DDDDDDDD ????????
.byte $0B,$04,$0C,$04,$0D,$04,$0E,$04             ; 00E728 DDDDDDDD ????????
.byte $0F,$00,$01,$04,$11,$04,$12,$04             ; 00E730 DDDDDDDD ????????
.byte $13,$04,$14,$04,$15,$04,$16,$04             ; 00E738 DDDDDDDD ????????
.byte $17,$00,$01,$04,$19,$04,$1A,$04             ; 00E740 DDDDDDDD ????????
.byte $1B,$04,$1C,$04,$1D,$04,$1E,$00             ; 00E748 DDDDDDDD ????????
.byte $01,$04,$21,$04,$22,$04,$23,$04             ; 00E750 DDDDDDDD ??!?"?#?
.byte $24,$04,$25,$04,$26,$04,$27,$04             ; 00E758 DDDDDDDD $?%?&?'?
.byte $28,$00,$01,$05,$0B,$0F,$06,$00             ; 00E760 DDDDDDDD (???????
.byte $00,$05,$0C,$0F,$07,$00,$00,$05             ; 00E768 DDDDD..D ????????
.byte $0D,$0F,$08,$00,$00,$05,$0E,$0F             ; 00E770 DDDDDDDD ????????
.byte $09,$00,$00,$05,$0F,$0F,$0A,$00             ; 00E778 DDDDDDDD ????????
.byte $00,$05,$10,$0F,$15,$00,$00,$05             ; 00E780 DDDDDDDD ????????
.byte $11,$0F,$16,$00,$00,$05,$12,$0F             ; 00E788 DDDDDDDD ????????
.byte $17,$00,$00,$05,$13,$0F,$18,$00             ; 00E790 DDDDDDDD ????????
.byte $00,$05,$14,$0F,$19,$00,$00,$14             ; 00E798 DDDDD..D ????????
.byte $1A,$00,$00,$14,$1B,$00,$00,$14             ; 00E7A0 DDDDDDDD ????????
.byte $1C,$00,$00,$14,$1D,$00,$00,$14             ; 00E7A8 DDDDDDDD ????????
.byte $1E,$00,$00,$14,$1F,$00,$00,$14             ; 00E7B0 DDDDDDDD ????????
.byte $20,$00,$00,$14,$21,$00,$00,$14             ; 00E7B8 D..DD..D  ???!???
.byte $22,$00,$00,$14,$23,$00,$00,$00             ; 00E7C0 D..DD... "???#???
.byte $01,$04,$38,$04,$39,$04,$3A,$04             ; 00E7C8 .DDDDDDD ??8?9?:?
.byte $3B,$04,$3C,$04,$3D,$04,$3E,$04             ; 00E7D0 DDDDDDDD ;?<?=?>?
.byte $3F,$04,$40,$04,$41,$04,$42,$04             ; 00E7D8 DDDDDDDD ??@?A?B?
.byte $43,$04,$44,$04,$45,$04,$46,$04             ; 00E7E0 DDDDDDDD C?D?E?F?
.byte $47,$04,$48,$04,$49,$04,$4A,$04             ; 00E7E8 DDDDDDDD G?H?I?J?
.byte $4B,$04,$4C,$04,$4D,$04,$4E,$04             ; 00E7F0 DDDDDDDD K?L?M?N?
.byte $4F,$04,$50,$08,$51,$08,$52,$08             ; 00E7F8 DDDDDDDD O?P?Q?R?
.byte $53,$09,$54,$1E,$55,$00,$00,$05             ; 00E800 DDDDDDDD S?T?U???
.byte $56,$05,$57,$05,$56,$05,$57,$07             ; 00E808 DDDDDDDD V?W?V?W?
.byte $56,$07,$57,$05,$56,$05,$57,$07             ; 00E810 DDDDDDDD V?W?V?W?
.byte $56,$07,$57,$07,$56,$07,$57,$07             ; 00E818 DDDDDDDD V?W?V?W?
.byte $56,$07,$57,$05,$56,$05,$57,$07             ; 00E820 DDDDDDDD V?W?V?W?
.byte $56,$07,$57,$1E,$55,$00,$00,$04             ; 00E828 DDDDDDD. V?W?U???
.byte $58,$04,$59,$04,$5A,$04,$5B,$04             ; 00E830 ........ X?Y?Z?[?
.byte $5C,$04,$5D,$04,$5E,$04,$5F,$04             ; 00E838 ........ \?]?^?_?
.byte $60,$04,$61,$04,$62,$04,$63,$04             ; 00E840 ........ `?a?b?c?
.byte $64,$04,$65,$04,$66,$04,$67,$04             ; 00E848 ........ d?e?f?g?
.byte $68,$04,$69,$04,$6A,$04,$6B,$04             ; 00E850 ........ h?i?j?k?
.byte $6C,$04,$6D,$04,$6E,$04,$6F,$04             ; 00E858 ........ l?m?n?o?
.byte $70,$1E,$55,$00,$00,$05,$24,$0F             ; 00E860 ........ p?U???$?
.byte $29,$00,$00,$05,$25,$0F,$2A,$00             ; 00E868 ...DDDD. )???%?*?
.byte $00,$05,$26,$0F,$2B,$00,$00,$05             ; 00E870 .DDDD..D ??&?+???
.byte $27,$0F,$2C,$00,$00,$05,$28,$0F             ; 00E878 DDD..... '?,???(?
.byte $2D,$00,$00                                 ; 00E881 ...      -??


L_E883:
  PHP                                             ; 00E883 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00E884 E2 30 
  LDA.W CurrentRoom                                     ; 00E886 AD AC 05 
  BPL.B B_E88D                                    ; 00E889 10 02 
  plp
  rts
B_E88D:
  PHB                                             ; 00E88D 8B 
  LDA.B #$00                                      ; 00E88E A9 00 
  PHA                                             ; 00E890 48 
  PLB                                             ; 00E891 AB 
  LDA.W CurrentRound                                     ; 00E892 AD AB 05 
  ASL                                             ; 00E895 0A 
  TAX                                             ; 00E896 AA 
  LDA.W RoundRoomNames,X                                  ; 00E897 BD 89 E9 
  STA.B $04                                       ; 00E89A 85 04 
  LDA.W RoundRoomNames+1,X                                  ; 00E89C BD 8A E9 
  STA.B $05                                       ; 00E89F 85 05 
  LDA.W CurrentRoom                                     ; 00E8A1 AD AC 05 
  DEC A
  STA.W WRMPYA                                    ; 00E8A5 8D 02 42 
  LDA.B #$1A                                      ; 00E8A8 A9 1A 
  STA.W WRMPYB                                    ; 00E8AA 8D 03 42 
  NOP                                             ; 00E8AD EA 
  NOP                                             ; 00E8AE EA 
  NOP                                             ; 00E8AF EA 
  NOP                                             ; 00E8B0 EA 
  CLC                                             ; 00E8B1 18 
  LDA.B $04                                       ; 00E8B2 A5 04 
  ADC.W RDMPYL                                    ; 00E8B4 6D 16 42 
  STA.B $04                                       ; 00E8B7 85 04 
  LDA.B $05                                       ; 00E8B9 A5 05 
  ADC.W RDMPYH                                    ; 00E8BB 6D 17 42 
  STA.B $05                                       ; 00E8BE 85 05 
  LDA.B #$A3                                      ; 00E8C0 A9 A3 
  STA.B $06                                       ; 00E8C2 85 06 
  LDA.B #$5D                                      ; 00E8C4 A9 5D 
  STA.B $07                                       ; 00E8C6 85 07 
  LDA.B #$80                                      ; 00E8C8 A9 80 
  STA.W VMAIN                                     ; 00E8CA 8D 15 21 
  LDA.B $06                                       ; 00E8CD A5 06 
  STA.W VMADDL                                    ; 00E8CF 8D 16 21 
  LDA.B $07                                       ; 00E8D2 A5 07 
  STA.W VMADDH                                    ; 00E8D4 8D 17 21 
  LDY.B #$00                                      ; 00E8D7 A0 00 
B_E8D9:
  LDA.B ($04),Y                                   ; 00E8D9 B1 04 
  TAX                                             ; 00E8DB AA 
  LDA.W D_EED7,X                                  ; 00E8DC BD D7 EE 
  ASL                                             ; 00E8DF 0A 
  TAX                                             ; 00E8E0 AA 
  LDA.L D_F6EF,X                                  ; 00E8E1 BF EF F6 00 
  STA.W VMDATAL                                   ; 00E8E5 8D 18 21 
  LDA.L D_F6F0,X                                  ; 00E8E8 BF F0 F6 00 
  ORA.B #$20                                      ; 00E8EC 09 20 
  STA.W VMDATAH                                   ; 00E8EE 8D 19 21 
  INY                                             ; 00E8F1 C8 
  CPY.B #$1A                                      ; 00E8F2 C0 1A 
  BNE.B B_E8D9                                    ; 00E8F4 D0 E3 
  CLC                                             ; 00E8F6 18 
  LDA.B $06                                       ; 00E8F7 A5 06 
  ADC.B #$20                                      ; 00E8F9 69 20 
  STA.W VMADDL                                    ; 00E8FB 8D 16 21 
  LDA.B $07                                       ; 00E8FE A5 07 
  ADC.B #$00                                      ; 00E900 69 00 
  STA.W VMADDH                                    ; 00E902 8D 17 21 
  LDY.B #$00                                      ; 00E905 A0 00 
B_E907:
  LDA.B ($04),Y                                   ; 00E907 B1 04 
  TAX                                             ; 00E909 AA 
  CLC                                             ; 00E90A 18 
  LDA.W D_EED7,X                                  ; 00E90B BD D7 EE 
  ASL                                             ; 00E90E 0A 
  TAX                                             ; 00E90F AA 
  LDA.L D_F72F,X                                  ; 00E910 BF 2F F7 00 
  STA.W VMDATAL                                   ; 00E914 8D 18 21 
  LDA.L D_F730,X                                  ; 00E917 BF 30 F7 00 
  ORA.B #$20                                      ; 00E91B 09 20 
  STA.W VMDATAH                                   ; 00E91D 8D 19 21 
  INY                                             ; 00E920 C8 
  CPY.B #$1A                                      ; 00E921 C0 1A 
  BNE.B B_E907                                    ; 00E923 D0 E2 
  LDX.B #$00                                      ; 00E925 A2 00 
  JSL L_EF072                                     ; 00E927 22 72 F0 0E 
  LDA.B #$07                                      ; 00E92B A9 07 
  STA.W $02C2                                     ; 00E92D 8D C2 02 
  PLB                                             ; 00E930 AB 
  PLP                                             ; 00E931 28 
  RTS                                             ; 00E932 60 


L_E933:
  PHP                                             ; 00E933 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00E934 E2 30 
  LDA.W $06C9                                     ; 00E936 AD C9 06 
  ORA.W $06CB                                     ; 00E939 0D CB 06 
  BEQ.B B_E948                                    ; 00E93C F0 0A 
  LDA.B #$A3                                      ; 00E93E A9 A3 
  STA.B $06                                       ; 00E940 85 06 
  LDA.B #$5D                                      ; 00E942 A9 5D 
  STA.B $07                                       ; 00E944 85 07 
  BRA.B B_E950                                    ; 00E946 80 08 

B_E948:
.byte $A9,$A3,$85,$06,$A9,$59,$85,$07             ; 00E948 ........ ?????Y??

B_E950:
  LDA.B #$80                                      ; 00E950 A9 80 
  STA.W VMAIN                                     ; 00E952 8D 15 21 
  LDA.B $06                                       ; 00E955 A5 06 
  STA.W VMADDL                                    ; 00E957 8D 16 21 
  LDA.B $07                                       ; 00E95A A5 07 
  STA.W VMADDH                                    ; 00E95C 8D 17 21 
  LDY.B #$19                                      ; 00E95F A0 19 
B_E961:
  STZ.W VMDATAL                                   ; 00E961 9C 18 21 
  STZ.W VMDATAH                                   ; 00E964 9C 19 21 
  DEY                                             ; 00E967 88 
  BPL.B B_E961                                    ; 00E968 10 F7 
  CLC                                             ; 00E96A 18 
  LDA.B $06                                       ; 00E96B A5 06 
  ADC.B #$20                                      ; 00E96D 69 20 
  STA.W VMADDL                                    ; 00E96F 8D 16 21 
  LDA.B $07                                       ; 00E972 A5 07 
  ADC.B #$00                                      ; 00E974 69 00 
  STA.W VMADDH                                    ; 00E976 8D 17 21 
  LDY.B #$19                                      ; 00E979 A0 19 
B_E97B:
  STZ.W VMDATAL                                   ; 00E97B 9C 18 21 
  STZ.W VMDATAH                                   ; 00E97E 9C 19 21 
  DEY                                             ; 00E981 88 
  BPL.B B_E97B                                    ; 00E982 10 F7 
  STZ.W $02C2                                     ; 00E984 9C C2 02 
  PLP                                             ; 00E987 28 
  RTS                                             ; 00E988 60 


RoundRoomNames:
.addr Round1RoomNames
.addr Round2RoomNames
.addr Round3RoomNames

Round1RoomNames:
.byte "          ARENA 1         "
.byte "     COLLECT 10 KEYS!     "
.byte "     COLLECT POWERUPS!    "
.byte "     MEET MR. SHRAPNEL    "
.byte "       BONUS PRIZES!      "
.byte "      EAT MY SHRAPNEL     "
.byte "       TOTAL CARNAGE      "
.byte "       CROWD CONTROL      "
.byte "       TANK TROUBLE       "
.byte "        MUTOID MAN!       "
.byte "     SECRET ROOM #1!      "
Round2RoomNames:
.byte "           ORBS!          "
.byte "       MEET MY TWIN       "
.byte "        SMASH 'EM         "
.byte "   FIRE POWER IS NEEDED!  "
.byte "      SLAUGHTER 'EM       "
.byte "     LAZER DEATH ZONE     "
.byte "      MEET SCARFACE!      "
.byte "       ROWDY DROIDS       "
.byte "       VACUUM CLEAN       "
.byte "      SECRET ROOM #2!     "
.byte "        METAL DEATH       "
.byte "      WATCH YOUR STEP     "
.byte "        FILM AT 11        "
.byte "         DEFEND ME        "
.byte "      TURTLES NEARBY      "
.byte "      CHUNKS GALORE!      "
.byte "     THESE ARE FAST!      "
.byte "   BUFFALO HERD NEARBY!   "
Round3RoomNames:
.byte "          NO DICE         "
.byte "       TEMPLE ALERT       "
.byte "      SCORPION FEVER      "
.byte "     COBRA JUST AHEAD!    "
.byte "       WALLS OF PAIN      "
.byte "        LAST ARENA?       "
.byte "       COBRA DEATH!       "
.byte "      TURTLES BEWARE!     "
.byte "    EXTRA SAUCE ACTION!   "
.byte "      SECRET ROOM #3!     "
.byte "   SECRET ROOMS NEARBY!   "
.byte "     ENJOY MY WEALTH      "
.byte "   NO TURTLES ALLOWED!    "
.byte "   TURTLE CHUNKS NEEDED   "
.byte "   DYNAMITE COBRA BOSS    "
.byte "   USE THE BUFFALO GUN    "
.byte "  WITNESS TOTAL CARNAGE   "
.byte "   SECRET ROOMS NEARBY!   "
.byte "    ALMOST ENOUGH KEYS    "
.byte "  YOU HAVE ENOUGH KEYS!   "
.byte "     EAT MY EYEBALLS!     "
.byte "      PLEASURE DOME!      "
.byte "     NOT ENOUGH KEYS!     "

D_EED7:
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00EED7 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00EEDF ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00EEE7 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00EEEF ........ ????????
.byte $00,$1B,$45,$40,$41,$42,$00,$1F             ; 00EEF7 DDDD.... ??E@AB??
.byte $00,$00,$00,$00,$1E,$41,$1D,$00             ; 00EEFF ........ ?????A??
.byte $46,$47,$48,$49,$4A,$4B,$4C,$4D             ; 00EF07 .D...... FGHIJKLM
.byte $4E,$4F,$43,$44,$00,$00,$00,$1C             ; 00EF0F ........ NOCD????
.byte $00,$01,$02,$03,$04,$05,$06,$07             ; 00EF17 .DDDDDDD ????????
.byte $08,$09,$0A,$0B,$0C,$0D,$0E,$0F             ; 00EF1F DD.DDDDD ????????
.byte $10,$11,$12,$13,$14,$15,$16,$17             ; 00EF27 D.DDDDDD ????????
.byte $18,$19,$1A,$00,$00,$00,$00,$00             ; 00EF2F .D...... ????????
.byte $00,$02,$03,$04,$05,$06,$07,$08             ; 00EF37 ........ ????????
.byte $09,$0A,$0B,$0C,$0D,$0E,$0F,$10             ; 00EF3F ........ ????????
.byte $11,$12,$13,$14,$15,$16,$17,$18             ; 00EF47 ........ ????????
.byte $19,$1A,$1B,$00,$00,$00,$00,$00             ; 00EF4F ........ ????????


L_EF57:
  PHP                                             ; 00EF57 08 
  PHB                                             ; 00EF58 8B 
  PEA.W $0000                                     ; 00EF59 F4 00 00 
  PLB                                             ; 00EF5C AB 
  PLB                                             ; 00EF5D AB 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00EF5E C2 30 
  AND.W #$00FF                                    ; 00EF60 29 FF 00 
  STA.W $0210                                     ; 00EF63 8D 10 02 
  STZ.W $0212                                     ; 00EF66 9C 12 02 
  JSL L_ED0B9                                     ; 00EF69 22 B9 D0 0E 
D_EF6D:
  LDA.W $0210                                     ; 00EF6D AD 10 02 
  ASL                                             ; 00EF70 0A 
  TAY                                             ; 00EF71 A8 
  LDA.W D_EFB6,Y                                  ; 00EF72 B9 B6 EF 
  STA.B $04                                       ; 00EF75 85 04 
  LDY.W $0212                                     ; 00EF77 AC 12 02 
  LDA.B ($04),Y                                   ; 00EF7A B1 04 
  BMI.B B_EFB3                                    ; 00EF7C 30 35 
  STA.W $0214                                     ; 00EF7E 8D 14 02 
  INY                                             ; 00EF81 C8 
  INY                                             ; 00EF82 C8 
  LDA.B ($04),Y                                   ; 00EF83 B1 04 
  INY                                             ; 00EF85 C8 
  INY                                             ; 00EF86 C8 
  STY.W $0212                                     ; 00EF87 8C 12 02 
  ASL                                             ; 00EF8A 0A 
  TAX                                             ; 00EF8B AA 
  LDA.W D_EFEE,X                                  ; 00EF8C BD EE EF 
  PHA                                             ; 00EF8F 48 
  JSL L_F8401                                     ; 00EF90 22 01 84 0F 
  PLA                                             ; 00EF94 68 
  ORA.W #$FF00                                    ; 00EF95 09 00 FF 
  TAX                                             ; 00EF98 AA 
  SEP.B #P_Acc8Bit                                      ; 00EF99 E2 20 
  LDA.B #$07                                      ; 00EF9B A9 07 
  JSL Audio_F830F                                     ; 00EF9D 22 0F 83 0F 
  REP.B #P_Acc8Bit                                      ; 00EFA1 C2 20 
B_EFA3:
  JSL Wait1Frame                                     ; 00EFA3 22 13 CA 0E 
  JSL L_ED117                                     ; 00EFA7 22 17 D1 0E 
  DEC.W $0214                                     ; 00EFAB CE 14 02 
  BNE.B B_EFA3                                    ; 00EFAE D0 F3 
  JMP.W D_EF6D                                    ; 00EFB0 4C 6D EF 
B_EFB3:
  PLB                                             ; 00EFB3 AB 
  PLP                                             ; 00EFB4 28 
  RTL                                             ; 00EFB5 6B 

D_EFB6:
.byte $BE,$EF,$C4,$EF,$CE,$EF,$D8,$EF             ; 00EFB6 DDDD.... ????????
.byte $8C,$00,$00,$00,$FF,$FF,$47,$00             ; 00EFBE DDDDDDDD ??????G?
.byte $01,$00,$3C,$00,$02,$00,$FF,$FF             ; 00EFC6 DDDDDDDD ??<?????
.byte $6E,$00,$07,$00,$3C,$00,$06,$00             ; 00EFCE ........ n???<???
.byte $FF,$FF,$18,$00,$03,$00,$3C,$00             ; 00EFD6 ........ ??????<?
.byte $04,$00,$18,$00,$03,$00,$46,$00             ; 00EFDE ........ ??????F?
.byte $05,$00,$3C,$00,$06,$00,$FF,$FF             ; 00EFE6 ........ ??<?????
D_EFEE:
.byte $19,$80,$27,$81,$1C,$80,$26,$81             ; 00EFEE DDDDDD.. ??'???&?
.byte $1D,$80,$2C,$82,$1B,$80,$1A,$80             ; 00EFF6 ........ ??,?????


L_EFFE:
  PHP                                             ; 00EFFE 08 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00EFFF C2 30 
  LDX.W #$F039                                    ; 00F001 A2 39 F0 
  LDY.W #$0000                                    ; 00F004 A0 00 00 
  JSL L_EDCC1                                     ; 00F007 22 C1 DC 0E 
  LDX.W #$E76E                                    ; 00F00B A2 6E E7 
  LDY.W #$000C                                    ; 00F00E A0 0C 00 
  JSL L_EE8EF                                     ; 00F011 22 EF E8 0E 
  LDA.W #$E72E                                    ; 00F015 A9 2E E7 
  LDX.W #$000C                                    ; 00F018 A2 0C 00 
  JSL L_EE94C                                     ; 00F01B 22 4C E9 0E 
  SEP.B #P_Acc8Bit                                      ; 00F01F E2 20 
  LDA.B #$81                                      ; 00F021 A9 81 
  STA.W NMITIMEN                                  ; 00F023 8D 00 42 
  REP.B #P_Acc8Bit                                      ; 00F026 C2 20 
  JSL FadeScreenIn                                     ; 00F028 22 1E CA 0E 
  LDX.W #$00B4                                    ; 00F02C A2 B4 00 
  JSL WaitXFrames                                     ; 00F02F 22 72 C9 0E 
  JSL FadeScreenOut                                     ; 00F033 22 32 CA 0E 
  PLP                                             ; 00F037 28 
  RTL                                             ; 00F038 6B 
  RTL                                             ; 00F039 6B 

UnusedSceneNMIHandler:
  rtl

TitleSceneIRQHandler:
  rtl

.byte $6B

TitleSceneNMIHandler:
  JSL L_AF0E                                      ; 00F03D 22 0E AF 00 
  JSL L_EF175                                     ; 00F041 22 75 F1 0E 
  JSL ReadCurrentJoypadState                                     ; 00F045 22 4C CA 0E 
  RTL                                             ; 00F049 6B 

GameSceneNMIHandler:
  JSL L_AF0E                                      ; 00F04A 22 0E AF 00 
  JSL L_EF095                                     ; 00F04E 22 95 F0 0E 
  JSL L_EF175                                     ; 00F052 22 75 F1 0E 
  JSR.W L_F2E1                                    ; 00F056 20 E1 F2 
  JSR.W L_F607                                    ; 00F059 20 07 F6 
  JSL L_EF822                                     ; 00F05C 22 22 F8 0E 
  JSR.W L_F666                                    ; 00F060 20 66 F6 
  JSL L_F414                                      ; 00F063 22 14 F4 00 
  JSL L_F318                                      ; 00F067 22 18 F3 00 
  JSR.W L_F3B2                                    ; 00F06B 20 B2 F3 
  JSR.W L_F5AD                                    ; 00F06E 20 AD F5 
  JSR.W L_F4BA                                    ; 00F071 20 BA F4 
  JSR.W L_F57C                                    ; 00F074 20 7C F5 
  JSR.W L_F2AA                                    ; 00F077 20 AA F2 
  JSR.W L_F17E                                    ; 00F07A 20 7E F1 
  JSR.W L_F117                                    ; 00F07D 20 17 F1 
  SEP.B #P_Acc8Bit                                      ; 00F080 E2 20 
  STZ.W HDMAEN                                    ; 00F082 9C 0C 42 
  STZ.W TMW                                       ; 00F085 9C 2E 21 
  LDA.W $05D9                                     ; 00F088 AD D9 05 
  BEQ.B B_F0BA                                    ; 00F08B F0 2D 
  BPL.B B_F0AD                                    ; 00F08D 10 1E 
  STZ.W WH0                                       ; 00F08F 9C 26 21 
  LDA.B #$FF                                      ; 00F092 A9 FF 
  STA.W WH1                                       ; 00F094 8D 27 21 
  LDA.W $05DA                                     ; 00F097 AD DA 05 
  STA.W WH2                                       ; 00F09A 8D 28 21 
  LDA.W $05DB                                     ; 00F09D AD DB 05 
  STA.W WH3                                       ; 00F0A0 8D 29 21 
  LDA.B #$10                                      ; 00F0A3 A9 10 
  ORA.W $05D8                                     ; 00F0A5 0D D8 05 
  STA.W TMW                                       ; 00F0A8 8D 2E 21 
  BRA.B B_F0BA                                    ; 00F0AB 80 0D 
B_F0AD:
  LDA.B #$10                                      ; 00F0AD A9 10 
  ORA.W $05D8                                     ; 00F0AF 0D D8 05 
  STA.W TMW                                       ; 00F0B2 8D 2E 21 
  LDA.B #$80                                      ; 00F0B5 A9 80 
  STA.W HDMAEN                                    ; 00F0B7 8D 0C 42 
B_F0BA:
  LDA.B #$50                                      ; 00F0BA A9 50 
  STA.W VTIMEL                                    ; 00F0BC 8D 09 42 
  STZ.W VTIMEH                                    ; 00F0BF 9C 0A 42 
  LDA.W $06CD                                     ; 00F0C2 AD CD 06 
  STA.W BG1HOFS                                   ; 00F0C5 8D 0D 21 
  LDA.W $06CE                                     ; 00F0C8 AD CE 06 
  STA.W BG1HOFS                                   ; 00F0CB 8D 0D 21 
  LDA.W $06C8                                     ; 00F0CE AD C8 06 
  STA.W BG2HOFS                                   ; 00F0D1 8D 0F 21 
  LDA.W $06C9                                     ; 00F0D4 AD C9 06 
  AND.B #$01                                      ; 00F0D7 29 01 
  STA.W BG2HOFS                                   ; 00F0D9 8D 0F 21 
  LDA.W $06C8                                     ; 00F0DC AD C8 06 
  STA.W BG3HOFS                                   ; 00F0DF 8D 11 21 
  LDA.W $06C9                                     ; 00F0E2 AD C9 06 
  AND.B #$01                                      ; 00F0E5 29 01 
  STA.W BG3HOFS                                   ; 00F0E7 8D 11 21 
  LDA.W $06D0                                     ; 00F0EA AD D0 06 
  STA.W BG1VOFS                                   ; 00F0ED 8D 0E 21 
  LDA.W $06D1                                     ; 00F0F0 AD D1 06 
  STA.W BG1VOFS                                   ; 00F0F3 8D 0E 21 
  LDA.W $06CA                                     ; 00F0F6 AD CA 06 
  STA.W BG2VOFS                                   ; 00F0F9 8D 10 21 
  LDA.W $06CB                                     ; 00F0FC AD CB 06 
  AND.B #$01                                      ; 00F0FF 29 01 
  STA.W BG2VOFS                                   ; 00F101 8D 10 21 
  LDA.W $06CA                                     ; 00F104 AD CA 06 
  STA.W BG3VOFS                                   ; 00F107 8D 12 21 
  LDA.W $06CB                                     ; 00F10A AD CB 06 
  AND.B #$01                                      ; 00F10D 29 01 
  STA.W BG3VOFS                                   ; 00F10F 8D 12 21 
  JSL ReadCurrentJoypadState                                     ; 00F112 22 4C CA 0E 
  RTL                                             ; 00F116 6B 

L_F117:
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00F117 E2 30 
  DEC.W $194A                                     ; 00F119 CE 4A 19 
  BNE.B B_F175                                    ; 00F11C D0 57 
  LDA.B #$0C                                      ; 00F11E A9 0C 
  STA.W $194A                                     ; 00F120 8D 4A 19 
  LDA.W $1949                                     ; 00F123 AD 49 19 
  EOR.B #$01                                      ; 00F126 49 01 
  AND.B #$01                                      ; 00F128 29 01 
  STA.W $1949                                     ; 00F12A 8D 49 19 
  ASL                                             ; 00F12D 0A 
  TAX                                             ; 00F12E AA 
  LDA.L D_F176,X                                  ; 00F12F BF 76 F1 00 
  STA.W A1T1L                                     ; 00F133 8D 12 43 
  LDA.L D_F177,X                                  ; 00F136 BF 77 F1 00 
  STA.W A1T1H                                     ; 00F13A 8D 13 43 
  PHP                                             ; 00F13D 08 
  REP.B #$10                                      ; 00F13E C2 10 
  SEP.B #P_Acc8Bit                                      ; 00F140 E2 20 
  LDA.B #$80                                      ; 00F142 A9 80 
  STA.W VMAIN                                     ; 00F144 8D 15 21 
  LDX.W #$6AC0                                    ; 00F147 A2 C0 6A 
  STX.W VMADDL                                    ; 00F14A 8E 16 21 
  LDX.W #$1801                                    ; 00F14D A2 01 18 
  STX.W DMAP1                                     ; 00F150 8E 10 43 
  LDA.B #$7E                                      ; 00F153 A9 7E 
  STA.W A1B1                                      ; 00F155 8D 14 43 
  LDX.W #$0040                                    ; 00F158 A2 40 00 
  STX.W DAS1L                                     ; 00F15B 8E 15 43 
  LDA.B #$02                                      ; 00F15E A9 02 
  STA.W MDMAEN                                    ; 00F160 8D 0B 42 
  LDX.W #$6BC0                                    ; 00F163 A2 C0 6B 
  STX.W VMADDL                                    ; 00F166 8E 16 21 
  LDX.W #$0040                                    ; 00F169 A2 40 00 
  STX.W DAS1L                                     ; 00F16C 8E 15 43 
  LDA.B #$02                                      ; 00F16F A9 02 
  STA.W MDMAEN                                    ; 00F171 8D 0B 42 
  PLP                                             ; 00F174 28 
B_F175:
  RTS                                             ; 00F175 60 


D_F176:
.byte $80                                         ; 00F177 D        ?
D_F177:
.byte $EB,$80,$EF,$80,$E9,$80,$ED                 ; 00F178 DDD....  ???????


L_F17E:
  PHP                                             ; 00F17E 08 
  REP.B #P_Acc8Bit                                      ; 00F17F C2 20 
  SEP.B #$10                                      ; 00F181 E2 10 
  LDX.B #$80                                      ; 00F183 A2 80 
  STX.W VMAIN                                     ; 00F185 8E 15 21 
  LDX.W $1AB2                                     ; 00F188 AE B2 1A 
  BEQ.B B_F1E8                                    ; 00F18B F0 5B 
  LDA.W #$7C40                                    ; 00F18D A9 40 7C 
  STA.W VMADDL                                    ; 00F190 8D 16 21 
  LDA.W $1AB3                                     ; 00F193 AD B3 1A 
  STA.W DMAP1                                     ; 00F196 8D 10 43 
  LDA.W $1AB5                                     ; 00F199 AD B5 1A 
  STA.W A1T1L                                     ; 00F19C 8D 12 43 
  LDX.W $1AB7                                     ; 00F19F AE B7 1A 
  STX.W A1B1                                      ; 00F1A2 8E 14 43 
  LDA.W #$0080                                    ; 00F1A5 A9 80 00 
  STA.W DAS1L                                     ; 00F1A8 8D 15 43 
  LDX.B #$02                                      ; 00F1AB A2 02 
  STX.W MDMAEN                                    ; 00F1AD 8E 0B 42 
  LDA.W #$7D40                                    ; 00F1B0 A9 40 7D 
  STA.W VMADDL                                    ; 00F1B3 8D 16 21 
  LDA.W #$0080                                    ; 00F1B6 A9 80 00 
  STA.W DAS1L                                     ; 00F1B9 8D 15 43 
  LDX.B #$02                                      ; 00F1BC A2 02 
  STX.W MDMAEN                                    ; 00F1BE 8E 0B 42 
  LDA.W #$7E40                                    ; 00F1C1 A9 40 7E 
  STA.W VMADDL                                    ; 00F1C4 8D 16 21 
  LDA.W #$0080                                    ; 00F1C7 A9 80 00 
  STA.W DAS1L                                     ; 00F1CA 8D 15 43 
  LDX.B #$02                                      ; 00F1CD A2 02 
  STX.W MDMAEN                                    ; 00F1CF 8E 0B 42 
  LDA.W #$7F40                                    ; 00F1D2 A9 40 7F 
  STA.W VMADDL                                    ; 00F1D5 8D 16 21 
  LDA.W #$0080                                    ; 00F1D8 A9 80 00 
  STA.W DAS1L                                     ; 00F1DB 8D 15 43 
  LDX.B #$02                                      ; 00F1DE A2 02 
  STX.W MDMAEN                                    ; 00F1E0 8E 0B 42 
  LDX.B #$00                                      ; 00F1E3 A2 00 
  STX.W $1AB2                                     ; 00F1E5 8E B2 1A 
B_F1E8:
  LDX.W $1ABA                                     ; 00F1E8 AE BA 1A 
  BEQ.B B_F248                                    ; 00F1EB F0 5B 
  LDA.W #$7C80                                    ; 00F1ED A9 80 7C 
  STA.W VMADDL                                    ; 00F1F0 8D 16 21 
  LDA.W $1ABB                                     ; 00F1F3 AD BB 1A 
  STA.W DMAP1                                     ; 00F1F6 8D 10 43 
  LDA.W $1ABD                                     ; 00F1F9 AD BD 1A 
  STA.W A1T1L                                     ; 00F1FC 8D 12 43 
  LDX.W $1ABF                                     ; 00F1FF AE BF 1A 
  STX.W A1B1                                      ; 00F202 8E 14 43 
  LDA.W #$0080                                    ; 00F205 A9 80 00 
  STA.W DAS1L                                     ; 00F208 8D 15 43 
  LDX.B #$02                                      ; 00F20B A2 02 
  STX.W MDMAEN                                    ; 00F20D 8E 0B 42 
  LDA.W #$7D80                                    ; 00F210 A9 80 7D 
  STA.W VMADDL                                    ; 00F213 8D 16 21 
  LDA.W #$0080                                    ; 00F216 A9 80 00 
  STA.W DAS1L                                     ; 00F219 8D 15 43 
  LDX.B #$02                                      ; 00F21C A2 02 
  STX.W MDMAEN                                    ; 00F21E 8E 0B 42 
  LDA.W #$7E80                                    ; 00F221 A9 80 7E 
  STA.W VMADDL                                    ; 00F224 8D 16 21 
  LDA.W #$0080                                    ; 00F227 A9 80 00 
  STA.W DAS1L                                     ; 00F22A 8D 15 43 
  LDX.B #$02                                      ; 00F22D A2 02 
  STX.W MDMAEN                                    ; 00F22F 8E 0B 42 
  LDA.W #$7F80                                    ; 00F232 A9 80 7F 
  STA.W VMADDL                                    ; 00F235 8D 16 21 
  LDA.W #$0080                                    ; 00F238 A9 80 00 
  STA.W DAS1L                                     ; 00F23B 8D 15 43 
  LDX.B #$02                                      ; 00F23E A2 02 
  STX.W MDMAEN                                    ; 00F240 8E 0B 42 
  LDX.B #$00                                      ; 00F243 A2 00 
  STX.W $1ABA                                     ; 00F245 8E BA 1A 
B_F248:
  LDX.W $1AC2                                     ; 00F248 AE C2 1A 
  BEQ.B B_F2A8                                    ; 00F24B F0 5B 
  LDA.W #$7CC0                                    ; 00F24D A9 C0 7C 
  STA.W VMADDL                                    ; 00F250 8D 16 21 
  LDA.W $1AC3                                     ; 00F253 AD C3 1A 
  STA.W DMAP1                                     ; 00F256 8D 10 43 
  LDA.W $1AC5                                     ; 00F259 AD C5 1A 
  STA.W A1T1L                                     ; 00F25C 8D 12 43 
  LDX.W $1AC7                                     ; 00F25F AE C7 1A 
  STX.W A1B1                                      ; 00F262 8E 14 43 
  LDA.W #$0080                                    ; 00F265 A9 80 00 
  STA.W DAS1L                                     ; 00F268 8D 15 43 
  LDX.B #$02                                      ; 00F26B A2 02 
  STX.W MDMAEN                                    ; 00F26D 8E 0B 42 
  LDA.W #$7DC0                                    ; 00F270 A9 C0 7D 
  STA.W VMADDL                                    ; 00F273 8D 16 21 
  LDA.W #$0080                                    ; 00F276 A9 80 00 
  STA.W DAS1L                                     ; 00F279 8D 15 43 
  LDX.B #$02                                      ; 00F27C A2 02 
  STX.W MDMAEN                                    ; 00F27E 8E 0B 42 
  LDA.W #$7EC0                                    ; 00F281 A9 C0 7E 
  STA.W VMADDL                                    ; 00F284 8D 16 21 
  LDA.W #$0080                                    ; 00F287 A9 80 00 
  STA.W DAS1L                                     ; 00F28A 8D 15 43 
  LDX.B #$02                                      ; 00F28D A2 02 
  STX.W MDMAEN                                    ; 00F28F 8E 0B 42 
  LDA.W #$7FC0                                    ; 00F292 A9 C0 7F 
  STA.W VMADDL                                    ; 00F295 8D 16 21 
  LDA.W #$0080                                    ; 00F298 A9 80 00 
  STA.W DAS1L                                     ; 00F29B 8D 15 43 
  LDX.B #$02                                      ; 00F29E A2 02 
  STX.W MDMAEN                                    ; 00F2A0 8E 0B 42 
  LDX.B #$00                                      ; 00F2A3 A2 00 
  STX.W $1AC2                                     ; 00F2A5 8E C2 1A 
B_F2A8:
  PLP                                             ; 00F2A8 28 
  RTS                                             ; 00F2A9 60 


L_F2AA:
  PHP                                             ; 00F2AA 08 
  REP.B #$10                                      ; 00F2AB C2 10 
  SEP.B #P_Acc8Bit                                      ; 00F2AD E2 20 
  LDA.B #$80                                      ; 00F2AF A9 80 
  STA.W VMAIN                                     ; 00F2B1 8D 15 21 
  LDA.W $1A9B                                     ; 00F2B4 AD 9B 1A 
  BEQ.B B_F2DF                                    ; 00F2B7 F0 26 
  LDY.W $1AA3                                     ; 00F2B9 AC A3 1A 
  STY.W VMADDL                                    ; 00F2BC 8C 16 21 
  LDX.W $1A9C                                     ; 00F2BF AE 9C 1A 
  STX.W DMAP1                                     ; 00F2C2 8E 10 43 
  LDX.W $1A9E                                     ; 00F2C5 AE 9E 1A 
  STX.W A1T1L                                     ; 00F2C8 8E 12 43 
  LDA.W $1AA0                                     ; 00F2CB AD A0 1A 
  STA.W A1B1                                      ; 00F2CE 8D 14 43 
  LDX.W $1AA1                                     ; 00F2D1 AE A1 1A 
  STX.W DAS1L                                     ; 00F2D4 8E 15 43 
  LDA.B #$02                                      ; 00F2D7 A9 02 
  STA.W MDMAEN                                    ; 00F2D9 8D 0B 42 
  STZ.W $1A9B                                     ; 00F2DC 9C 9B 1A 
B_F2DF:
  PLP                                             ; 00F2DF 28 
  RTS                                             ; 00F2E0 60 


L_F2E1:
  PHP                                             ; 00F2E1 08 
  REP.B #$10                                      ; 00F2E2 C2 10 
  SEP.B #P_Acc8Bit                                      ; 00F2E4 E2 20 
  LDA.B #$80                                      ; 00F2E6 A9 80 
  STA.W VMAIN                                     ; 00F2E8 8D 15 21 
  LDA.W $1A91                                     ; 00F2EB AD 91 1A 
  BEQ.B B_F316                                    ; 00F2EE F0 26 
  LDY.W $1A99                                     ; 00F2F0 AC 99 1A 
  STY.W VMADDL                                    ; 00F2F3 8C 16 21 
  LDX.W $1A92                                     ; 00F2F6 AE 92 1A 
  STX.W DMAP1                                     ; 00F2F9 8E 10 43 
  LDX.W $1A94                                     ; 00F2FC AE 94 1A 
  STX.W A1T1L                                     ; 00F2FF 8E 12 43 
  LDA.W $1A96                                     ; 00F302 AD 96 1A 
  STA.W A1B1                                      ; 00F305 8D 14 43 
  LDX.W $1A97                                     ; 00F308 AE 97 1A 
  STX.W DAS1L                                     ; 00F30B 8E 15 43 
  LDA.B #$02                                      ; 00F30E A9 02 
  STA.W MDMAEN                                    ; 00F310 8D 0B 42 
  STZ.W $1A91                                     ; 00F313 9C 91 1A 
B_F316:
  PLP                                             ; 00F316 28 
  RTS                                             ; 00F317 60 


L_F318:
  PHP                                             ; 00F318 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00F319 E2 30 
  LDA.B #$80                                      ; 00F31B A9 80 
  STA.W VMAIN                                     ; 00F31D 8D 15 21 
  LDA.W $05A4                                     ; 00F320 AD A4 05 
  BEQ.B B_F368                                    ; 00F323 F0 43 
  REP.B #P_Acc8Bit                                      ; 00F325 C2 20 
  LDA.W #$5041                                    ; 00F327 A9 41 50 
  STA.W VMADDL                                    ; 00F32A 8D 16 21 
  LDX.B #$00                                      ; 00F32D A2 00 
B_F32F:
  LDA.W $0574,X                                   ; 00F32F BD 74 05 
  STA.W VMDATAL                                   ; 00F332 8D 18 21 
  INX                                             ; 00F335 E8 
  INX                                             ; 00F336 E8 
  CPX.B #$08                                      ; 00F337 E0 08 
  BNE.B B_F32F                                    ; 00F339 D0 F4 
  LDA.W #$5061                                    ; 00F33B A9 61 50 
  STA.W VMADDL                                    ; 00F33E 8D 16 21 
  LDX.B #$00                                      ; 00F341 A2 00 
B_F343:
  LDA.W $057C,X                                   ; 00F343 BD 7C 05 
  STA.W VMDATAL                                   ; 00F346 8D 18 21 
  INX                                             ; 00F349 E8 
  INX                                             ; 00F34A E8 
  CPX.B #$08                                      ; 00F34B E0 08 
  BNE.B B_F343                                    ; 00F34D D0 F4 
  LDA.W #$5081                                    ; 00F34F A9 81 50 
  STA.W VMADDL                                    ; 00F352 8D 16 21 
  LDX.B #$00                                      ; 00F355 A2 00 
B_F357:
  LDA.W $0584,X                                   ; 00F357 BD 84 05 
  STA.W VMDATAL                                   ; 00F35A 8D 18 21 
  INX                                             ; 00F35D E8 
  INX                                             ; 00F35E E8 
  CPX.B #$08                                      ; 00F35F E0 08 
  BNE.B B_F357                                    ; 00F361 D0 F4 
  SEP.B #P_Acc8Bit                                      ; 00F363 E2 20 
  STZ.W $05A4                                     ; 00F365 9C A4 05 
B_F368:
  LDA.W $05A5                                     ; 00F368 AD A5 05 
  BEQ.B B_F3B0                                    ; 00F36B F0 43 
  REP.B #P_Acc8Bit                                      ; 00F36D C2 20 
  LDA.W #$505B                                    ; 00F36F A9 5B 50 
  STA.W VMADDL                                    ; 00F372 8D 16 21 
  LDX.B #$00                                      ; 00F375 A2 00 
B_F377:
  LDA.W $058C,X                                   ; 00F377 BD 8C 05 
  STA.W VMDATAL                                   ; 00F37A 8D 18 21 
  INX                                             ; 00F37D E8 
  INX                                             ; 00F37E E8 
  CPX.B #$08                                      ; 00F37F E0 08 
  BNE.B B_F377                                    ; 00F381 D0 F4 
  LDA.W #$507B                                    ; 00F383 A9 7B 50 
  STA.W VMADDL                                    ; 00F386 8D 16 21 
  LDX.B #$00                                      ; 00F389 A2 00 
B_F38B:
  LDA.W $0594,X                                   ; 00F38B BD 94 05 
  STA.W VMDATAL                                   ; 00F38E 8D 18 21 
  INX                                             ; 00F391 E8 
  INX                                             ; 00F392 E8 
  CPX.B #$08                                      ; 00F393 E0 08 
  BNE.B B_F38B                                    ; 00F395 D0 F4 
  LDA.W #$509B                                    ; 00F397 A9 9B 50 
  STA.W VMADDL                                    ; 00F39A 8D 16 21 
  LDX.B #$00                                      ; 00F39D A2 00 
B_F39F:
  LDA.W $059C,X                                   ; 00F39F BD 9C 05 
  STA.W VMDATAL                                   ; 00F3A2 8D 18 21 
  INX                                             ; 00F3A5 E8 
  INX                                             ; 00F3A6 E8 
  CPX.B #$08                                      ; 00F3A7 E0 08 
  BNE.B B_F39F                                    ; 00F3A9 D0 F4 
  SEP.B #P_Acc8Bit                                      ; 00F3AB E2 20 
  STZ.W $05A5                                     ; 00F3AD 9C A5 05 
B_F3B0:
  PLP                                             ; 00F3B0 28 
  RTL                                             ; 00F3B1 6B 

L_F3B2:
  PHP                                             ; 00F3B2 08 
  SEP.B #P_Acc8Bit                                      ; 00F3B3 E2 20 
  LDA.B #$80                                      ; 00F3B5 A9 80 
  STA.W VMAIN                                     ; 00F3B7 8D 15 21 
  LDA.W $0528                                     ; 00F3BA AD 28 05 
  BEQ.B B_F3E6                                    ; 00F3BD F0 27 
  REP.B #P_Acc8Bit                                      ; 00F3BF C2 20 
  LDA.W #$5862                                    ; 00F3C1 A9 62 58 
  STA.W VMADDL                                    ; 00F3C4 8D 16 21 
  LDA.B $87                                       ; 00F3C7 A5 87 
  STA.W VMDATAL                                   ; 00F3C9 8D 18 21 
  LDA.B $89                                       ; 00F3CC A5 89 
  STA.W VMDATAL                                   ; 00F3CE 8D 18 21 
  LDA.W #$5882                                    ; 00F3D1 A9 82 58 
  STA.W VMADDL                                    ; 00F3D4 8D 16 21 
  LDA.B $8B                                       ; 00F3D7 A5 8B 
  STA.W VMDATAL                                   ; 00F3D9 8D 18 21 
  LDA.B $8D                                       ; 00F3DC A5 8D 
  STA.W VMDATAL                                   ; 00F3DE 8D 18 21 
  SEP.B #P_Acc8Bit                                      ; 00F3E1 E2 20 
  STZ.W $0528                                     ; 00F3E3 9C 28 05 
B_F3E6:
  LDA.W $0529                                     ; 00F3E6 AD 29 05 
  BEQ.B B_F412                                    ; 00F3E9 F0 27 
  REP.B #P_Acc8Bit                                      ; 00F3EB C2 20 
  LDA.W #$587C                                    ; 00F3ED A9 7C 58 
  STA.W VMADDL                                    ; 00F3F0 8D 16 21 
  LDA.B $8F                                       ; 00F3F3 A5 8F 
  STA.W VMDATAL                                   ; 00F3F5 8D 18 21 
  LDA.B $91                                       ; 00F3F8 A5 91 
  STA.W VMDATAL                                   ; 00F3FA 8D 18 21 
  LDA.W #$589C                                    ; 00F3FD A9 9C 58 
  STA.W VMADDL                                    ; 00F400 8D 16 21 
  LDA.B $93                                       ; 00F403 A5 93 
  STA.W VMDATAL                                   ; 00F405 8D 18 21 
  LDA.B $95                                       ; 00F408 A5 95 
  STA.W VMDATAL                                   ; 00F40A 8D 18 21 
  SEP.B #P_Acc8Bit                                      ; 00F40D E2 20 
  STZ.W $0529                                     ; 00F40F 9C 29 05 
B_F412:
  PLP                                             ; 00F412 28 
  RTS                                             ; 00F413 60 


L_F414:
  PHP                                             ; 00F414 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00F415 E2 30 
  LDA.B #$80                                      ; 00F417 A9 80 
  STA.W VMAIN                                     ; 00F419 8D 15 21 
  LDA.B $B4                                       ; 00F41C A5 B4 
  BEQ.B B_F44C                                    ; 00F41E F0 2C 
  REP.B #$20                                      ; 00F420 C2 20 
  LDA.B $B0                                       ; 00F422 A5 B0 
  STA.W VMADDL                                    ; 00F424 8D 16 21 
  LDY.B #$0E                                      ; 00F427 A0 0E 
B_F429:
  LDA.W $0534,Y                                   ; 00F429 B9 34 05 
  STA.W VMDATAL                                   ; 00F42C 8D 18 21 
  DEY                                             ; 00F42F 88 
  DEY                                             ; 00F430 88 
  BPL.B B_F429                                    ; 00F431 10 F6 
  CLC                                             ; 00F433 18 
  LDA.B $B0                                       ; 00F434 A5 B0 
  ADC.W #$0020                                    ; 00F436 69 20 00 
  STA.W VMADDL                                    ; 00F439 8D 16 21 
  LDY.B #$0E                                      ; 00F43C A0 0E 
B_F43E:
  LDA.W $0544,Y                                   ; 00F43E B9 44 05 
  STA.W VMDATAL                                   ; 00F441 8D 18 21 
  DEY                                             ; 00F444 88 
  DEY                                             ; 00F445 88 
  BPL.B B_F43E                                    ; 00F446 10 F6 
  SEP.B #P_Acc8Bit                                      ; 00F448 E2 20 
  STZ.B $B4                                       ; 00F44A 64 B4 
B_F44C:
  LDA.B $B5                                       ; 00F44C A5 B5 
  BEQ.B B_F47C                                    ; 00F44E F0 2C 
  REP.B #P_Acc8Bit                                      ; 00F450 C2 20 
  LDA.B $B2                                       ; 00F452 A5 B2 
  STA.W VMADDL                                    ; 00F454 8D 16 21 
  LDY.B #$0E                                      ; 00F457 A0 0E 
B_F459:
  LDA.W $0554,Y                                   ; 00F459 B9 54 05 
  STA.W VMDATAL                                   ; 00F45C 8D 18 21 
  DEY                                             ; 00F45F 88 
  DEY                                             ; 00F460 88 
  BPL.B B_F459                                    ; 00F461 10 F6 
  CLC                                             ; 00F463 18 
  LDA.B $B2                                       ; 00F464 A5 B2 
  ADC.W #$0020                                    ; 00F466 69 20 00 
  STA.W VMADDL                                    ; 00F469 8D 16 21 
  LDY.B #$0E                                      ; 00F46C A0 0E 
B_F46E:
  LDA.W $0564,Y                                   ; 00F46E B9 64 05 
  STA.W VMDATAL                                   ; 00F471 8D 18 21 
  DEY                                             ; 00F474 88 
  DEY                                             ; 00F475 88 
  BPL.B B_F46E                                    ; 00F476 10 F6 
  SEP.B #P_Acc8Bit                                      ; 00F478 E2 20 
  STZ.B $B5                                       ; 00F47A 64 B5 
B_F47C:
  LDA.B $C6                                       ; 00F47C A5 C6 
  BEQ.B B_F4B8                                    ; 00F47E F0 38 
  LDA.B $C2                                       ; 00F480 A5 C2 
  STA.W VMADDL                                    ; 00F482 8D 16 21 
  LDA.B $C3                                       ; 00F485 A5 C3 
  STA.W VMADDH                                    ; 00F487 8D 17 21 
  LDY.B #$04                                      ; 00F48A A0 04 
  LDX.B #$00                                      ; 00F48C A2 00 
B_F48E:
  LDA.B $B6,X                                     ; 00F48E B5 B6 
  STA.W VMDATAL                                   ; 00F490 8D 18 21 
  STY.W VMDATAH                                   ; 00F493 8C 19 21 
  INX                                             ; 00F496 E8 
  CPX.B #$06                                      ; 00F497 E0 06 
  BNE.B B_F48E                                    ; 00F499 D0 F3 
  LDA.B $C4                                       ; 00F49B A5 C4 
  STA.W VMADDL                                    ; 00F49D 8D 16 21 
  LDA.B $C5                                       ; 00F4A0 A5 C5 
  STA.W VMADDH                                    ; 00F4A2 8D 17 21 
  LDY.B #$04                                      ; 00F4A5 A0 04 
  LDX.B #$00                                      ; 00F4A7 A2 00 
B_F4A9:
  LDA.B $BC,X                                     ; 00F4A9 B5 BC 
  STA.W VMDATAL                                   ; 00F4AB 8D 18 21 
  STY.W VMDATAH                                   ; 00F4AE 8C 19 21 
  INX                                             ; 00F4B1 E8 
  CPX.B #$06                                      ; 00F4B2 E0 06 
  BNE.B B_F4A9                                    ; 00F4B4 D0 F3 
  STZ.B $C6                                       ; 00F4B6 64 C6 
B_F4B8:
  PLP                                             ; 00F4B8 28 
  RTL                                             ; 00F4B9 6B 

L_F4BA:
  PHP                                             ; 00F4BA 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00F4BB E2 30 
  LDA.B #$80                                      ; 00F4BD A9 80 
  STA.W VMAIN                                     ; 00F4BF 8D 15 21 
  LDA.W $0632                                     ; 00F4C2 AD 32 06 
  BEQ.B B_F51E                                    ; 00F4C5 F0 57 

.byte $C2,$20,$A9,$48,$50,$8D,$16,$21             ; 00F4C7 ........ ? ?HP??!
.byte $A0,$00,$B9,$38,$06,$8D,$18,$21             ; 00F4CF ........ ???8???!
.byte $C8,$C8,$C0,$0A,$D0,$F4,$A9,$68             ; 00F4D7 ........ ???????h
.byte $50,$8D,$16,$21,$A0,$00,$B9,$42             ; 00F4DF ........ P??!???B
.byte $06,$8D,$18,$21,$C8,$C8,$C0,$0A             ; 00F4E7 ........ ???!????
.byte $D0,$F4,$A9,$88,$50,$8D,$16,$21             ; 00F4EF ........ ????P??!
.byte $A0,$00,$B9,$4C,$06,$8D,$18,$21             ; 00F4F7 ........ ???L???!
.byte $C8,$C8,$C0,$0A,$D0,$F4,$A9,$A8             ; 00F4FF ........ ????????
.byte $50,$8D,$16,$21,$A0,$00,$B9,$56             ; 00F507 ........ P??!???V
.byte $06,$8D,$18,$21,$C8,$C8,$C0,$0A             ; 00F50F ........ ???!????
.byte $D0,$F4,$E2,$20,$9C,$32,$06                 ; 00F518 .......  ??? ?2?

B_F51E:
  LDA.W $0633                                     ; 00F51E AD 33 06 
  BEQ.B B_F57A                                    ; 00F521 F0 57 

.byte $C2,$20,$A9,$53,$50,$8D,$16,$21             ; 00F523 ........ ? ?SP??!
.byte $A0,$00,$B9,$60,$06,$8D,$18,$21             ; 00F52B ........ ???`???!
.byte $C8,$C8,$C0,$0A,$D0,$F4,$A9,$73             ; 00F533 ........ ???????s
.byte $50,$8D,$16,$21,$A0,$00,$B9,$6A             ; 00F53B ........ P??!???j
.byte $06,$8D,$18,$21,$C8,$C8,$C0,$0A             ; 00F543 ........ ???!????
.byte $D0,$F4,$A9,$93,$50,$8D,$16,$21             ; 00F54B ........ ????P??!
.byte $A0,$00,$B9,$74,$06,$8D,$18,$21             ; 00F553 ........ ???t???!
.byte $C8,$C8,$C0,$0A,$D0,$F4,$A9,$B3             ; 00F55B ........ ????????
.byte $50,$8D,$16,$21,$A0,$00,$B9,$7E             ; 00F563 ........ P??!???~
.byte $06,$8D,$18,$21,$C8,$C8,$C0,$0A             ; 00F56B ........ ???!????
.byte $D0,$F4,$E2,$20,$9C,$33,$06                 ; 00F574 .......  ??? ?3?

B_F57A:
  PLP                                             ; 00F57A 28 
  RTS                                             ; 00F57B 60 


L_F57C:
  PHP                                             ; 00F57C 08 
  REP.B #$10                                      ; 00F57D C2 10 
  SEP.B #P_Acc8Bit                                      ; 00F57F E2 20 
  LDA.W $0688                                     ; 00F581 AD 88 06 
  BEQ.B B_F5AB                                    ; 00F584 F0 25 
  LDX.W #$4800                                    ; 00F586 A2 00 48 
  STX.W VMADDL                                    ; 00F589 8E 16 21 
  LDX.W #$1801                                    ; 00F58C A2 01 18 
  STX.W DMAP1                                     ; 00F58F 8E 10 43 
  LDX.W #$20AE                                    ; 00F592 A2 AE 20 
  STX.W A1T1L                                     ; 00F595 8E 12 43 
  LDA.B #$7E                                      ; 00F598 A9 7E 
  STA.W A1B1                                      ; 00F59A 8D 14 43 
  LDX.W $0689                                     ; 00F59D AE 89 06 
  STX.W DAS1L                                     ; 00F5A0 8E 15 43 
  LDA.B #$02                                      ; 00F5A3 A9 02 
  STA.W MDMAEN                                    ; 00F5A5 8D 0B 42 
  STZ.W $0688                                     ; 00F5A8 9C 88 06 
B_F5AB:
  PLP                                             ; 00F5AB 28 
  RTS                                             ; 00F5AC 60 


L_F5AD:
  PHP                                             ; 00F5AD 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00F5AE E2 30 
  LDA.W $05E5                                     ; 00F5B0 AD E5 05 
  BEQ.B B_F605                                    ; 00F5B3 F0 50 
  LDA.B #$80                                      ; 00F5B5 A9 80 
  STA.W VMAIN                                     ; 00F5B7 8D 15 21 
  REP.B #P_Acc8Bit                                      ; 00F5BA C2 20 
  LDA.W $05E8                                     ; 00F5BC AD E8 05 
  STA.W VMADDL                                    ; 00F5BF 8D 16 21 
  LDY.B #$00                                      ; 00F5C2 A0 00 
B_F5C4:
  LDA.W $05EA,Y                                   ; 00F5C4 B9 EA 05 
  STA.W VMDATAL                                   ; 00F5C7 8D 18 21 
  INY                                             ; 00F5CA C8 
  INY                                             ; 00F5CB C8 
  CPY.B #$0C                                      ; 00F5CC C0 0C 
  BNE.B B_F5C4                                    ; 00F5CE D0 F4 
  CLC                                             ; 00F5D0 18 
  LDA.W $05E8                                     ; 00F5D1 AD E8 05 
  ADC.W #$0020                                    ; 00F5D4 69 20 00 
  STA.W VMADDL                                    ; 00F5D7 8D 16 21 
  LDY.B #$00                                      ; 00F5DA A0 00 
B_F5DC:
  LDA.W $05F6,Y                                   ; 00F5DC B9 F6 05 
  STA.W VMDATAL                                   ; 00F5DF 8D 18 21 
  INY                                             ; 00F5E2 C8 
  INY                                             ; 00F5E3 C8 
  CPY.B #$0C                                      ; 00F5E4 C0 0C 
  BNE.B B_F5DC                                    ; 00F5E6 D0 F4 
  CLC                                             ; 00F5E8 18 
  LDA.W $05E8                                     ; 00F5E9 AD E8 05 
  ADC.W #$0040                                    ; 00F5EC 69 40 00 
  STA.W VMADDL                                    ; 00F5EF 8D 16 21 
  LDY.B #$00                                      ; 00F5F2 A0 00 
B_F5F4:
  LDA.W $0602,Y                                   ; 00F5F4 B9 02 06 
  STA.W VMDATAL                                   ; 00F5F7 8D 18 21 
  INY                                             ; 00F5FA C8 
  INY                                             ; 00F5FB C8 
  CPY.B #$0C                                      ; 00F5FC C0 0C 
  BNE.B B_F5F4                                    ; 00F5FE D0 F4 
  SEP.B #P_Acc8Bit                                      ; 00F600 E2 20 
  STZ.W $05E5                                     ; 00F602 9C E5 05 
B_F605:
  PLP                                             ; 00F605 28 
  RTS                                             ; 00F606 60 


L_F607:
  PHP                                             ; 00F607 08 
  REP.B #$10                                      ; 00F608 C2 10 
  SEP.B #P_Acc8Bit                                      ; 00F60A E2 20 
  LDA.B #$80                                      ; 00F60C A9 80 
  STA.W VMAIN                                     ; 00F60E 8D 15 21 
  LDA.W $1A83                                     ; 00F611 AD 83 1A 
  BEQ.B B_F639                                    ; 00F614 F0 23 
  STZ.W $1A83                                     ; 00F616 9C 83 1A 
  LDA.W $1A86                                     ; 00F619 AD 86 1A 
  STA.W CGADD                                     ; 00F61C 8D 21 21 
  LDX.W $1A7D                                     ; 00F61F AE 7D 1A 
  STX.W DMAP1                                     ; 00F622 8E 10 43 
  LDX.W $1A7F                                     ; 00F625 AE 7F 1A 
  STX.W A1T1L                                     ; 00F628 8E 12 43 
  LDX.W $1A81                                     ; 00F62B AE 81 1A 
  STX.W A1B1                                      ; 00F62E 8E 14 43 
  STZ.W DAS1H                                     ; 00F631 9C 16 43 
  LDA.B #$02                                      ; 00F634 A9 02 
  STA.W MDMAEN                                    ; 00F636 8D 0B 42 
B_F639:
  LDA.W $1A88                                     ; 00F639 AD 88 1A 
  BEQ.B B_F664                                    ; 00F63C F0 26 
  STZ.W $1A88                                     ; 00F63E 9C 88 1A 
  LDY.W $1A8F                                     ; 00F641 AC 8F 1A 
  STY.W VMADDL                                    ; 00F644 8C 16 21 
  LDX.W $1A89                                     ; 00F647 AE 89 1A 
  STX.W DMAP1                                     ; 00F64A 8E 10 43 
  LDX.W $1A8B                                     ; 00F64D AE 8B 1A 
  STX.W A1T1L                                     ; 00F650 8E 12 43 
  LDA.W $1A8D                                     ; 00F653 AD 8D 1A 
  STA.W A1B1                                      ; 00F656 8D 14 43 
  LDX.W #$1000                                    ; 00F659 A2 00 10 
  STX.W DAS1L                                     ; 00F65C 8E 15 43 
  LDA.B #$02                                      ; 00F65F A9 02 
  STA.W MDMAEN                                    ; 00F661 8D 0B 42 
B_F664:
  PLP                                             ; 00F664 28 
  RTS                                             ; 00F665 60 


L_F666:
  PHP                                             ; 00F666 08 
  PHB                                             ; 00F667 8B 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 00F668 E2 30 
  LDA.B #$0D                                      ; 00F66A A9 0D 
  PHA                                             ; 00F66C 48 
  PLB                                             ; 00F66D AB 
  LDX.B #$03                                      ; 00F66E A2 03 
B_F670:
  LDA.W $18CD,X                                   ; 00F670 BD CD 18 
  BEQ.B B_F6A4                                    ; 00F673 F0 2F 
  PHX                                             ; 00F675 DA 
  STZ.W $18CD,X                                   ; 00F676 9E CD 18 
  LDA.L D_F6AA,X                                  ; 00F679 BF AA F6 00 
  STA.W CGADD                                     ; 00F67D 8D 21 21 
  LDA.W $18C1,X                                   ; 00F680 BD C1 18 
  ASL                                             ; 00F683 0A 
  TAX                                             ; 00F684 AA 
  LDA.L D_F6AE,X                                  ; 00F685 BF AE F6 00 
  STA.B $00                                       ; 00F689 85 00 
  LDA.L D_F6AF,X                                  ; 00F68B BF AF F6 00 
  STA.B $01                                       ; 00F68F 85 01 
  LDY.B #$00                                      ; 00F691 A0 00 
B_F693:
  LDA.B ($00),Y                                   ; 00F693 B1 00 
  STA.W CGDATA                                    ; 00F695 8D 22 21 
  INY                                             ; 00F698 C8 
  LDA.B ($00),Y                                   ; 00F699 B1 00 
  STA.W CGDATA                                    ; 00F69B 8D 22 21 
  INY                                             ; 00F69E C8 
  CPY.B #$20                                      ; 00F69F C0 20 
  BNE.B B_F693                                    ; 00F6A1 D0 F0 
  PLX                                             ; 00F6A3 FA 
B_F6A4:
  DEX                                             ; 00F6A4 CA 
  BPL.B B_F670                                    ; 00F6A5 10 C9 
  PLB                                             ; 00F6A7 AB 
  PLP                                             ; 00F6A8 28 
  RTS                                             ; 00F6A9 60 


D_F6AA:
.byte $C0,$D0,$E0,$F0                             ; 00F6AB DDDD     ????
D_F6AE:
.byte $00                                         ; 00F6AF .        ?
D_F6AF:
.byte $00,$72,$C7,$92,$C7,$B2,$C7,$D2             ; 00F6AF ...DD... ?r??????
.byte $C7,$F2,$C7,$12,$C8,$32,$C8,$52             ; 00F6B7 .DDDDDD. ?????2?R
.byte $C8,$72,$C8,$92,$C8,$B2,$C8,$D2             ; 00F6BF ........ ?r??????
.byte $C8,$F2,$C8,$12,$C9,$32,$C9,$52             ; 00F6C7 .DDDD... ?????2?R
.byte $C9,$72,$C9,$92,$C9,$B2,$C9,$D2             ; 00F6CF .DDDDDD. ?r??????
.byte $C9,$F2,$C9,$12,$CA,$32,$CA,$52             ; 00F6D7 ........ ?????2?R
.byte $CA                                         ; 00F6E0 .        ?

GameSceneIRQHandler:
  SEP.B #P_Acc8Bit                                      ; 00F6E0 E2 20 
B_F6E2:
  LDA.W HVBJOY                                    ; 00F6E2 AD 12 42 
  AND.B #$40                                      ; 00F6E5 29 40 
  BEQ.B B_F6E2                                    ; 00F6E7 F0 F9 
  LDA.B #$13                                      ; 00F6E9 A9 13 
  STA.W TMW                                       ; 00F6EB 8D 2E 21 
  RTL                                             ; 00F6EE 6B 

D_F6EF:
.byte $00                                         ; 00F6F0 D        ?
D_F6F0:
.byte $00,$01,$04,$02,$04,$03,$04,$04             ; 00F6F0 DDDDDDDD ????????
.byte $04,$05,$04,$05,$04,$03,$04,$06             ; 00F6F8 DDDDDDDD ????????
.byte $04,$07,$04,$07,$44,$08,$04,$09             ; 00F700 DDD..DDD ????D???
.byte $04,$0A,$04,$0B,$04,$0C,$04,$0D             ; 00F708 DDDDDDDD ????????
.byte $04,$0C,$04,$0E,$04,$0F,$04,$10             ; 00F710 D..DDDDD ????????
.byte $04,$11,$04,$12,$04,$13,$04,$14             ; 00F718 DDD..DD. ????????
.byte $04,$15,$04,$16,$04,$17,$04,$18             ; 00F720 .DD..DD. ????????
.byte $04,$00,$00,$00,$00,$19,$04                 ; 00F729 .......  ???????
D_F72F:
.byte $00                                         ; 00F730 D        ?
D_F730:
.byte $00,$1A,$04,$1B,$04,$03,$84,$04             ; 00F730 DDDDDDDD ????????
.byte $84,$05,$84,$1C,$04,$1D,$04,$1A             ; 00F738 DDDDDDDD ????????
.byte $04,$07,$84,$1E,$04,$08,$84,$1F             ; 00F740 DDD..DDD ????????
.byte $04,$20,$04,$21,$04,$0C,$84,$1C             ; 00F748 DDDDDDDD ? ?!????
.byte $04,$22,$04,$1A,$04,$23,$04,$17             ; 00F750 D..DDDDD ?"???#??
.byte $84,$0C,$84,$24,$04,$25,$04,$14             ; 00F758 DDD..DD. ???$?%??
.byte $84,$17,$84,$26,$04,$27,$04,$28             ; 00F760 .DD..DD. ???&?'?(
.byte $04,$29,$04,$19,$04,$00,$00,$2A             ; 00F768 .......D ?)?????*
.byte $04,$2B,$04,$00,$00,$00,$00,$00             ; 00F770 D....... ?+??????
.byte $00,$2C,$04                                 ; 00F779 ...      ?,?
D_F77B:
.byte $0C,$04                                     ; 00F77C DD       ??
D_F77D:
.byte $2D,$04,$2E,$04,$2F,$04,$30,$04             ; 00F77D DDDDDDDD -?.?/?0?
.byte $31,$04,$32,$04,$33,$04,$34,$04             ; 00F785 DDDDDDDD 1?2?3?4?
.byte $01,$04,$00,$00,$00,$00,$00,$00             ; 00F78D DD...... ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F795 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F79D ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F7A5 ........ ????????
.byte $00,$00,$2A,$84,$2B,$84,$00,$00             ; 00F7AD ..DD.... ??*?+???
.byte $00,$00,$00,$00,$00,$00                     ; 00F7B6 ......   ??????
D_F7BB:
.byte $0C,$84                                     ; 00F7BC DD       ??
D_F7BD:
.byte $17,$C4,$05,$84,$2F,$84,$35,$04             ; 00F7BD DDDDDDDD ????/?5?
.byte $36,$04,$37,$04,$38,$04,$37,$04             ; 00F7C5 DDDDDDDD 6?7?8?7?
.byte $2E,$84,$00,$00,$00,$00,$00,$00             ; 00F7CD DD...... .???????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F7D5 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F7DD ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F7E5 ........ ????????
.byte $00,$00                                     ; 00F7EE ..       ??
D_F7EF:
.byte $39,$00,$3A,$00,$3B,$00,$3C,$00             ; 00F7EF DDDDDDDD 9?:?;?<?
.byte $3D,$00,$3E,$00,$3F,$00,$40,$00             ; 00F7F7 DDDDDDDD =?>???@?
.byte $41,$00,$42,$00,$43,$00,$44,$00             ; 00F7FF DDDDDDDD A?B?C?D?
.byte $45,$00,$42,$00,$46,$00,$47,$00             ; 00F807 DDDDDDDD E?B?F?G?
.byte $48,$00,$49,$00,$4A,$00,$4B,$00             ; 00F80F DDDDDDDD H?I?J?K?
.byte $4C,$00,$4D,$00,$4E,$00,$47,$00             ; 00F817 DDDDDDDD L?M?N?G?
.byte $4C,$00,$4F,$00,$43,$00,$47,$00             ; 00F81F DDDDDDDD L?O?C?G?
.byte $50,$00,$51,$00,$52,$00,$53,$00             ; 00F827 ........ P?Q?R?S?
.byte $54,$00,$55,$00,$56,$00,$57,$00             ; 00F82F ........ T?U?V?W?
.byte $58,$00,$59,$00,$5A,$00,$47,$00             ; 00F837 ........ X?Y?Z?G?
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F83F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F847 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F84F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F857 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F85F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F867 ........ ????????
D_F86F:
.byte $5B,$04                                     ; 00F870 D.       [?
D_F871:
.byte $5C,$10,$00,$00,$00,$00,$00,$00             ; 00F871 D....... \???????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F879 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F881 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F889 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F891 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F899 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F8A1 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F8A9 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F8B1 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F8B9 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F8C1 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F8C9 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F8D1 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F8D9 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F8E1 ........ ????????
.byte $00,$00,$00,$00,$00,$00                     ; 00F8EA ......   ??????
D_F8EF:
.byte $5D,$00,$5E,$00,$5F,$00,$60,$00             ; 00F8EF DDDDDDDD ]?^?_?`?
.byte $61,$00,$62,$00,$63,$00,$64,$00             ; 00F8F7 DDDDDDDD a?b?c?d?
.byte $65,$00,$66,$00,$01,$04,$02,$04             ; 00F8FF DDDD.... e?f?????
.byte $03,$04,$04,$04,$05,$04,$05,$04             ; 00F907 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F90F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F917 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F91F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F927 ........ ????????
D_F92F:
.byte $67,$00,$68,$00,$69,$00,$6A,$00             ; 00F92F DDDDDDDD g?h?i?j?
.byte $6B,$00,$6A,$00,$6C,$00,$6D,$00             ; 00F937 DDDDDDDD k?j?l?m?
.byte $6E,$00,$6F,$00,$1A,$04,$1B,$04             ; 00F93F DDDD.... n?o?????
.byte $03,$84,$04,$84,$05,$84,$1C,$04             ; 00F947 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F94F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F957 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F95F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F967 ........ ????????
.byte $70,$04,$71,$04,$72,$04,$73,$04             ; 00F96F DDDDDDDD p?q?r?s?
.byte $74,$04,$75,$04,$76,$04,$77,$04             ; 00F977 DDDDDDDD t?u?v?w?
.byte $78,$04,$79,$04,$7A,$04,$7B,$04             ; 00F97F DDDDDDDD x?y?z?{?
.byte $7C,$04,$7D,$04,$7E,$04,$7F,$04             ; 00F987 DDDDDDDD |?}?~???
.byte $70,$04,$71,$04,$72,$04,$73,$04             ; 00F98F DDDDDDDD p?q?r?s?
.byte $74,$04,$75,$04,$76,$04,$77,$04             ; 00F997 DDDDDDDD t?u?v?w?
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F99F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F9A7 ........ ????????
.byte $00,$00,$80,$04,$81,$04,$82,$04             ; 00F9AF DDDDDDDD ????????
.byte $83,$04,$76,$04,$84,$04,$00,$00             ; 00F9B7 DDDDDDDD ??v?????
.byte $00,$00,$85,$04,$86,$04,$87,$04             ; 00F9BF DDDDDDDD ????????
.byte $88,$04,$89,$04,$8A,$04,$00,$00             ; 00F9C7 DDDDDDDD ????????
.byte $00,$00,$00,$00,$8B,$04,$8C,$04             ; 00F9CF DDDDDDDD ????????
.byte $8D,$04,$00,$00,$00,$00,$00,$00             ; 00F9D7 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F9DF ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00F9E7 ........ ????????
.byte $8E,$04,$8F,$04,$90,$04,$91,$04             ; 00F9EF ........ ????????
.byte $92,$04,$93,$04,$94,$04,$95,$04             ; 00F9F7 ........ ????????
.byte $95,$44,$96,$04,$97,$04,$98,$04             ; 00F9FF ........ ?D??????
.byte $99,$04,$9A,$04,$9B,$04,$9C,$04             ; 00FA07 ........ ????????
.byte $9D,$04,$9E,$04,$9F,$04,$A0,$04             ; 00FA0F ........ ????????
.byte $A1,$04,$A2,$04,$A3,$04,$A4,$04             ; 00FA17 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FA1F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FA27 ........ ????????
.byte $00,$00,$A5,$04,$A6,$04,$A7,$04             ; 00FA2F ........ ????????
.byte $A8,$04,$80,$04,$A9,$04,$00,$00             ; 00FA37 ........ ????????
.byte $00,$00,$AA,$04,$AB,$04,$AC,$04             ; 00FA3F ........ ????????
.byte $AD,$04,$AE,$04,$AF,$04,$00,$00             ; 00FA47 ........ ????????
.byte $00,$00,$B0,$04,$8F,$04,$B1,$04             ; 00FA4F ........ ????????
.byte $B2,$04,$B3,$04,$B4,$04,$00,$00             ; 00FA57 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FA5F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FA67 ........ ????????
.byte $B5,$04,$B6,$04,$B7,$04,$B8,$04             ; 00FA6F ........ ????????
.byte $B9,$04,$9B,$04,$BA,$04,$BB,$04             ; 00FA77 ........ ????????
.byte $BC,$04,$BD,$04,$BE,$04,$BF,$04             ; 00FA7F ........ ????????
.byte $C0,$04,$C1,$04,$C2,$04,$C3,$04             ; 00FA87 ........ ????????
.byte $C4,$04,$C5,$04,$C6,$04,$C7,$04             ; 00FA8F ........ ????????
.byte $C8,$04,$C9,$04,$CA,$04,$CB,$04             ; 00FA97 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FA9F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FAA7 ........ ????????
.byte $00,$00,$CC,$04,$CD,$04,$CE,$04             ; 00FAAF ........ ????????
.byte $CF,$04,$D0,$04,$D1,$04,$D2,$04             ; 00FAB7 ........ ????????
.byte $D3,$04,$D4,$04,$BA,$04,$BB,$04             ; 00FABF ........ ????????
.byte $D5,$04,$D6,$04,$D7,$04,$8A,$04             ; 00FAC7 ........ ????????
.byte $D6,$04,$D8,$04,$D9,$04,$DA,$04             ; 00FACF ........ ????????
.byte $DB,$04,$DC,$04,$DD,$04,$DE,$04             ; 00FAD7 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FADF ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FAE7 ........ ????????
.byte $DF,$04,$E0,$04,$E1,$04,$E2,$04             ; 00FAEF DDDDDDDD ????????
.byte $E3,$04,$E4,$04,$E5,$04,$E6,$04             ; 00FAF7 DDDDDDDD ????????
.byte $E7,$04,$E8,$04,$E9,$04,$EA,$04             ; 00FAFF ........ ????????
.byte $EB,$04,$EC,$04,$ED,$04,$EE,$04             ; 00FB07 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FB0F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FB17 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FB1F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FB27 ........ ????????
.byte $00,$00,$80,$04,$EF,$04,$F0,$04             ; 00FB2F DDDDDDDD ????????
.byte $F1,$04,$F2,$04,$F3,$04,$00,$00             ; 00FB37 DDDDDDDD ????????
.byte $F4,$04,$F5,$04,$F6,$04,$F7,$04             ; 00FB3F ........ ????????
.byte $F8,$04,$F9,$04,$FA,$04,$FB,$04             ; 00FB47 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FB4F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FB57 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FB5F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 00FB67 ........ ????????
.byte $B0,$02,$0F,$00,$F1,$21,$E0,$1F             ; 00FB6F DDDDDDDD ?????!??
.byte $04,$B0,$FD,$50,$1D,$10,$13,$0D             ; 00FB77 DDDDDDDD ???P????
.byte $0F,$3E,$A0,$7C,$E1,$F3,$7C,$03             ; 00FB7F DDDDDDDD ?>?|??|?
.byte $D0,$51,$C2,$B0,$0F,$4F,$D3,$53             ; 00FB87 DDDDDDDD ?Q???O?S
.byte $DE,$0F,$17,$DD,$B0,$1F,$E2,$4F             ; 00FB8F DDDDDDDD ???????O
.byte $F0,$FF,$51,$D0,$3E,$A0,$7A,$4F             ; 00FB97 DDDDDDDD ??Q?>?zO
.byte $F3,$4E,$2F,$17,$0B,$E1,$B0,$F7             ; 00FB9F DDDDDDDD ?N/?????
.byte $0F,$F1,$F1,$30,$EE,$2F,$16,$B0             ; 00FBA7 DDDDDDDD ???0?/??
.byte $DD,$45,$F0,$EF,$13,$3E,$E1,$1C             ; 00FBAF DDDDDDDD ?E???>??
.byte $B0,$23,$DE,$3F,$24,$DE,$3F,$04             ; 00FBB7 DDDDDDDD ?#??$???
.byte $FE,$B0,$12,$E5,$FB,$27,$3B,$E1             ; 00FBBF DDDDDDDD ?????';?
.byte $F2,$7D,$A0,$92,$FE,$71,$DF,$F2             ; 00FBC7 DDDDDDDD ?}???q??
.byte $27,$3B,$D1,$B0,$21,$1E,$DF,$50             ; 00FBCF DDDDDDDD ';??!??P
.byte $3F,$C1,$7F,$0E,$B0,$EF,$43,$1A             ; 00FBD7 DDDDDDDD ??????C?
.byte $11,$10,$4E,$DF,$03,$A0,$44,$AC             ; 00FBDF DDDDDDDD ??N???D?
.byte $74,$3D,$B0,$12,$7B,$D1,$B0,$50             ; 00FBE7 DDDDDDDD t=??{??P
.byte $F1,$FB,$43,$01,$EE,$41,$1E,$B0             ; 00FBEF DDDDDDDD ??C??A??
.byte $0F,$D1,$4E,$5E,$EF,$56,$CE,$E0             ; 00FBF7 DDDDDDDD ??N^?V??
.byte $B0,$42,$1E,$C3,$5D,$20,$D0,$13             ; 00FBFF DDDDDDDD ?B??] ??
.byte $2E,$B0,$1C,$16,$E1,$3C,$B4,$3F             ; 00FC07 DDDDDDDD .????<??
.byte $3C,$D5,$B0,$32,$AE,$00,$7F,$0D             ; 00FC0F DDDDDDDD <??2????
.byte $F2,$40,$1F,$B0,$0D,$04,$2F,$1C             ; 00FC17 DDDDDDDD ?@????/?
.byte $17,$E2,$EE,$F2,$B0,$4E,$1D,$C5             ; 00FC1F DDDDDDDD ?????N??
.byte $5E,$1B,$0F,$72,$FE,$B0,$F0,$61             ; 00FC27 DDDDDDDD ^??r???a
.byte $E2,$DF,$13,$F2,$E0,$24,$B0,$2E             ; 00FC2F DDDDDDDD ?????$?.
.byte $DE,$27,$EF,$CE,$36,$FD,$F0,$B0             ; 00FC37 DDDDDDDD ?'??6???
.byte $D4,$6E,$F1,$C3,$7C,$12,$DE,$34             ; 00FC3F DDDDDDDD ?n??|??4
.byte $B0,$C4,$D0,$51,$3B,$F0,$37,$CE             ; 00FC47 DDDDDDDD ???Q;?7?
.byte $DF,$B0,$63,$C0,$0C,$36,$E0,$FF             ; 00FC4F DDDDDDDD ??c??6??
.byte $F4,$4D,$A0,$28,$C7,$7B,$1D,$E7             ; 00FC57 DDDDDDDD ?M?(?{??
.byte $65,$8B,$E6,$B0,$7C,$FE,$E4,$4D             ; 00FC5F DDDDDDDD e???|??M
.byte $1F,$FF,$62,$FE,$B0,$1D,$64,$B4             ; 00FC67 DDDDDDDD ??b???d?
.byte $A0,$14,$FD,$1F,$36,$C0,$F0,$D0             ; 00FC6F DDDDDDDD ????6???
.byte $24,$E0,$FE,$23,$EF,$1E,$B0,$15             ; 00FC77 DDDDDDDD $??#????
.byte $3D,$F1,$E4,$3C,$3D,$F1,$4F,$B0             ; 00FC7F DDDDDDDD =??<=?O?
.byte $E1,$F3,$40,$EF,$E0,$70,$B1,$E2             ; 00FC87 DDDDDDDD ??@??p??
.byte $B0,$7D,$D0,$2C,$34,$D0,$3E,$14             ; 00FC8F DDDDDDDD ?}?,4?>?
.byte $F0,$B0,$1D,$E4,$2D,$2E,$14,$02             ; 00FC97 DDDDDDDD ????-.??
.byte $EC,$E6,$B0,$4D,$0D,$07,$1B,$03             ; 00FC9F DDDDDDDD ???M????
.byte $D2,$4E,$F1,$A0,$1C,$37,$97,$8F             ; 00FCA7 DDDDDDDD ?N???7??
.byte $25,$EE,$3E,$77,$B0,$FF,$FD,$17             ; 00FCAF DDDDDDDD %?>w????
.byte $FD,$0D,$47,$CD,$11,$B0,$E3,$4C             ; 00FCB7 DDDDDDDD ??G????L
.byte $03,$D2,$2F,$03,$DE,$31,$B0,$E0             ; 00FCBF DDDDDDDD ??/??1??
.byte $2F,$07,$D1,$FD,$E7,$0E,$2C,$B0             ; 00FCC7 DDDDDDDD /?????,?
.byte $26,$1C,$E3,$E0,$25,$B0,$3E,$32             ; 00FCCF DDDDDDDD &???%?>2
.byte $A0,$D0,$58,$F6,$FC,$32,$D7,$20             ; 00FCD7 DDDDDDDD ??X??2? 
.byte $FC,$B0,$D2,$7C,$00,$E3,$7C,$D3             ; 00FCDF DDDDDDDD ???|??|?
.byte $01,$32,$A0,$83,$7B,$3F,$03,$4A             ; 00FCE7 DDDDDDDD ?2??{??J
.byte $D5,$F2,$2E,$B0,$05,$F1,$DF,$F3             ; 00FCEF DDDDDDDD ??.?????
.byte $4B,$F1,$E5,$3D,$B0,$02,$D1,$5D             ; 00FCF7 DDDDDDDD K??=???]
.byte $E2,$2D,$21,$F4,$DF,$B0,$13,$FE             ; 00FCFF DDDDDDDD ?-!?????
.byte $1E,$47,$DD,$10,$03,$1D,$B0,$F5             ; 00FD07 DDDDDDDD ?G??????
.byte $D2,$00,$12,$E0,$4E,$01,$1E,$B0             ; 00FD0F DDDDDDDD ????N???
.byte $24,$E1,$ED,$24,$EF,$0D,$64,$DF             ; 00FD17 DDDDDDDD $??$??d?
.byte $A0,$03,$D4,$2B,$04,$7A,$10,$46             ; 00FD1F DDDDDDDD ???+?z?F
.byte $EC,$B0,$E3,$01,$0C,$33,$11,$C2             ; 00FD27 DDDDDDDD ?????3??
.byte $F1,$5C,$A0,$03,$D7,$03,$EC,$7A             ; 00FD2F DDDDDDDD ?\?????z
.byte $17,$84,$2D,$B0,$11,$20,$2E,$F0             ; 00FD37 DDDDDDDD ??-?? .?
.byte $4E,$F1,$D4,$6E,$B0,$DF,$3F,$12             ; 00FD3F DDDDDDDD N??n????
.byte $C1,$4D,$10,$10,$40,$A0,$FD,$F7             ; 00FD47 DDDDDDDD ?M??@???
.byte $D2,$19,$47,$E3,$F9,$F7,$A0,$FE             ; 00FD4F DDDDDDDD ??G?????
.byte $1B,$76,$48,$E3,$7D,$F0,$E7,$B0             ; 00FD57 DDDDDDDD ?vH?}???
.byte $11,$D0,$41,$E2,$D0,$20,$0E,$1F             ; 00FD5F DDDDDDDD ??A?? ??
.byte $B0,$51,$E1,$1B,$43,$D2,$FD,$43             ; 00FD67 DDDDDDDD ?Q??C??C
.byte $EE,$A0,$12,$4D,$F3,$11,$2D,$E3             ; 00FD6F DDDDDDDD ???M??-?
.byte $63,$D2,$A0,$B0,$7D,$01,$A7,$20             ; 00FD77 DDDDDDDD c???}?? 
.byte $FB,$E5,$E3,$A0,$4C,$24,$10,$F4             ; 00FD7F DDDDDDDD ????L$??
.byte $1A,$5F,$F0,$7C,$A0,$F4,$A5,$2F             ; 00FD87 DDDDDDDD ?_?|???/
.byte $44,$F0,$C6,$DE,$EB,$B0,$52,$EF             ; 00FD8F DDDDDDDD D?????R?
.byte $E4,$5C,$1C,$4F,$5E,$C0,$B0,$53             ; 00FD97 DDDDDDDD ?\?O^??S
.byte $DE,$3D,$25,$E0,$01,$1F,$20,$A0             ; 00FD9F DDDDDDDD ?=%??? ?
.byte $23,$A0,$5F,$2D,$96,$64,$8D,$43             ; 00FDA7 DDDDDDDD #?_-?d?C
.byte $A0,$D1,$EF,$7E,$2E,$E6,$6D,$2D             ; 00FDAF DDDDDDDD ???~.?m-
.byte $01,$A0,$59,$F2,$D7,$3C,$4B,$6B             ; 00FDB7 DDDDDDDD ??Y??<Kk
.byte $34,$D4,$A0,$E3,$EF,$43,$ED,$41             ; 00FDBF DDDDDDDD 4????C?A
.byte $F1,$3D,$03,$B0,$E1,$F2,$4E,$2C             ; 00FDC7 DDDDDDDD ?=????N,
.byte $E6,$E1,$FD,$43,$B0,$F0,$E0,$44             ; 00FDCF DDDDDDDD ???C???D
.byte $BE,$4E,$40,$DF,$44,$A0,$BD,$02             ; 00FDD7 DDDDDDDD ?N@?D???
.byte $1F,$4E,$07,$E0,$2F,$7E,$B0,$1E             ; 00FDDF DDDDDDDD ?N??/~??
.byte $F5,$F0,$FC,$53,$FE,$E3,$31,$A0             ; 00FDE7 DDDDDDDD ???S??1?
.byte $DF,$15,$EE,$E0,$73,$FC,$59,$5F             ; 00FDEF DDDDDDDD ????s?Y_
.byte $B0,$2D,$03,$E5,$0E,$3F,$F4,$D0             ; 00FDF7 DDDDDDDD ?-??????
.byte $3D,$A0,$2F,$FE,$66,$CF,$E7,$B0             ; 00FDFF DDDDDDDD =?/?f???
.byte $3F,$2F,$A0,$3C,$F7,$01,$F2,$CF             ; 00FE07 DDDDDDDD ?/?<????
.byte $6D,$E2,$A7,$A0,$10,$FE,$37,$48             ; 00FE0F DDDDDDDD m?????7H
.byte $F7,$D5,$B0,$F4,$A0,$30,$E1,$3F             ; 00FE17 DDDDDDDD ?????0??
.byte $05,$E1,$C2,$E0,$7E,$B0,$01,$E5             ; 00FE1F DDDDDDDD ????~???
.byte $D2,$2E,$20,$E3,$11,$FF,$A0,$17             ; 00FE27 DDDDDDDD ?. ?????
.byte $C1,$F1,$1F,$3B,$23,$F3,$05,$A0             ; 00FE2F DDDDDDDD ???;#???
.byte $CD,$17,$FD,$FD,$73,$BE,$17,$E1             ; 00FE37 DDDDDDDD ????s???
.byte $A0,$AF,$77,$AF,$2F,$71,$F0,$07             ; 00FE3F DDDDDDDD ??w?/q??
.byte $CE,$A0,$6A,$4F,$F1,$22,$3B,$10             ; 00FE47 DDDDDDDD ??jO?";?
.byte $7B,$2F,$A0,$42,$F1,$C2,$54,$ED             ; 00FE4F DDDDDDDD {/?B??T?
.byte $15,$3C,$F7,$A0,$C2,$1C,$34,$C4             ; 00FE57 DDDDDDDD ?<????4?
.byte $E3,$F3,$DF,$6A,$A0,$50,$A7,$F0             ; 00FE5F DDDDDDDD ???j?P??
.byte $0E,$31,$5A,$23,$23,$A0,$93,$E3             ; 00FE67 DDDDDDDD ?1Z##???
.byte $6C,$00,$7F,$C1,$21,$D0,$B0,$0E             ; 00FE6F DDDDDDDD l???!???
.byte $60,$EF,$E3,$5D,$0C,$27,$E1,$A0             ; 00FE77 DDDDDDDD `??]?'??
.byte $94,$61,$FF,$E2,$25,$BF,$5D,$3E             ; 00FE7F DDDDDDDD ?a??%?]>
.byte $A0,$E3,$F3,$1D,$4E,$3F,$00,$5E             ; 00FE87 DDDDDDDD ????N??^
.byte $10,$A0,$C7,$2E,$0F,$21,$3F,$F0             ; 00FE8F DDDDDDDD ???.?!??
.byte $40,$FE,$B0,$02,$00,$00,$4F,$0C             ; 00FE97 DDDDDDDD @?????O?
.byte $25,$F0,$E0,$A0,$76,$BC,$02,$6F             ; 00FE9F DDDDDDDD %???v??o
.byte $C3,$C3,$7A,$00,$A0,$F5,$08,$74             ; 00FEA7 DDDDDDDD ??z????t
.byte $2B,$30,$B1,$7F,$DE,$B0,$2F,$6E             ; 00FEAF DDDDDDDD +0????/n
.byte $C5,$F1,$3D,$11,$0F,$11,$A0,$E4             ; 00FEB7 DDDDDDDD ??=?????
.byte $FE,$50,$C5,$F2,$01,$4D,$F6,$A0             ; 00FEBF DDDDDDDD ?P???M??
.byte $B3,$EE,$7F,$EF,$37,$B0,$01,$52             ; 00FEC7 DDDDDDDD ????7??R
.byte $A0,$B1,$10,$30,$F0,$05,$D1,$03             ; 00FECF DDDDDDDD ???0????
.byte $0E,$A0,$6C,$02,$1D,$F1,$17,$DC             ; 00FED7 DDDDDDDD ??l?????
.byte $40,$71,$A0,$A1,$23,$1E,$D2,$60             ; 00FEDF DDDDDDDD @q??#??`
.byte $E0,$E5,$2C,$A0,$D5,$40,$EC,$16             ; 00FEE7 DDDDDDDD ??,??@??
.byte $3C,$E1,$41,$FE,$A0,$04,$10,$D1             ; 00FEEF DDDDDDDD <?A?????
.byte $42,$FE,$02,$40,$DF,$A0,$7B,$5C             ; 00FEF7 DDDDDDDD B??@??{\
.byte $03,$20,$F0,$12,$4C,$02,$90,$27             ; 00FEFF DDDDDDDD ? ??L??'
.byte $DE,$31,$5E,$1F,$16,$D0,$30,$90             ; 00FF07 DDDDDDDD ?1^???0?
.byte $50,$E6,$E2,$05,$B2,$4E,$30,$05             ; 00FF0F DDDDDDDD P????N0?
.byte $90,$C4,$02,$2F,$02,$F2,$12,$02             ; 00FF17 DDDDDDDD ???/????
.byte $F2,$80,$14,$31,$14,$32,$4E,$7E             ; 00FF1F DDDDDDDD ???1?2N~
.byte $54,$6A,$90,$40,$32,$E2,$2F,$5E             ; 00FF27 DDDDDDDD Tj?@2?/^
.byte $22,$03,$21,$A1,$01,$10,$20,$10             ; 00FF2F DDDDDDDD "?!??? ?
.byte $2D,$50,$F3,$D7,$90,$AB,$BC,$AE             ; 00FF37 DDDDDDDD -P??????
.byte $BE,$80,$BF,$CF,$F0,$F0,$20,$42             ; 00FF3F DDDDDDDD ?????? B
.byte $45,$46,$90,$34,$35,$45,$55,$66             ; 00FF47 DDDDDDDD EF?45EUf
.byte $65,$76,$67,$A0,$45,$25,$44,$35             ; 00FF4F DDDDDDDD evg?E%D5
.byte $33,$42,$33,$33,$90,$55,$54,$44             ; 00FF57 DDDDDDDD 3B33?UTD
.byte $34,$23,$23,$21,$12,$70,$32,$40             ; 00FF5F DDDDDDDD 4##!?p2@
.byte $00,$E0,$D2,$C2,$AF,$BE,$70,$D9             ; 00FF67 DDDDDDDD ??????p?
.byte $DA,$DC,$AC,$AC,$9D,$8E,$8D,$70             ; 00FF6F DDDDDDDD ???????p
.byte $AA,$CB,$9D,$AC,$AC,$AC,$C0,$8E             ; 00FF77 DDDDDDDD ????????
.byte $80,$CF,$C0,$C0,$ED,$FD,$FD,$FD             ; 00FF7F DDDDDDDD ????????
.byte $FE,$80,$C0,$D0,$C0,$EF,$EF,$EF             ; 00FF87 DDDDDDDD ????????
.byte $F0,$F0,$80,$F0,$F0,$E2,$02,$E2             ; 00FF8F DDDDDDDD ????????
.byte $22,$20,$42,$80,$32,$24,$33,$44             ; 00FF97 DDDDDDDD " B?2$3D
.byte $54,$54,$64,$65,$80,$65,$66,$56             ; 00FF9F DDDDDDDD TTde?efV
.byte $65,$66,$66,$66,$65,$80,$65,$66             ; 00FFA7 DDDDDDDD efffe?ef
.byte $64                                         ; 00FFAF D        d

; SNES Rom Info
.byte $64,$54                                     ; Maker code
.byte $46,$26,$24,$80                             ; Game code
.byte "SC4CD42"                                   ; Fixed value
.byte $23                                         ; Expansion ram size
.byte $70                                         ; Special version
.byte $90                                         ; Cartridge subtype
.byte "SMASH T.V.           "                     ; Game name
.byte $20                                         ; Mapper type - LOROM
.byte $00                                         ; Cartridge type - ROM Only
.byte $09                                         ; Cartridge size (1 << $09, 512kb)
.byte $00                                         ; Cartridge RAM size (0)
.byte $00                                         ; Region code (0 = Japan)
.byte $B1                                         ; License code
.byte $00                                         ; Version number
.byte $19,$17,$E6,$E8                             ; Checksum
.byte $FF,$FF,$FF,$FF                             ; Complement

; interrupt vectors
.addr V_RTI                                       ; Native COP instruction
.addr V_RTI                                       ; Native BRK instruction
.addr V_RTI                                       ; Native ABORT (unused)
.addr V_NMI                                       ; Native NMI
.addr V_RTI                                       ; Native UNUSED
.addr V_IRQ                                       ; Native IRQ
.addr $FFFF                                       ; 
.addr $FFFF                                       ; 
.addr V_RTI                                       ; Emulation COIP
.addr V_RTI                                       ; Emulation Unused
.addr V_RTI                                       ; Emulation ABORT
.addr V_RTI                                       ; Emulation NMI
.addr V_STARTUP                                   ; Emulation Reset
.addr V_RTI                                       ; Emulation IRQ/BRK
