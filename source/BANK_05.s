.BANK 5
.ORG 0


L_58000:
  PHP                                             ; 058000 08 
  PHB                                             ; 058001 8B 
  STA.B $DE                                       ; 058002 85 DE 
  STY.B $E0                                       ; 058004 84 E0 
  STX.B $D6                                       ; 058006 86 D6 
  STX.B $D8                                       ; 058008 86 D8 
  STZ.B $E4                                       ; 05800A 64 E4 
  PEA.W $7E7E                                     ; 05800C F4 7E 7E 
  PLB                                             ; 05800F AB 
  PLB                                             ; 058010 AB 
  LDY.W #$0000                                    ; 058011 A0 00 00 
  LDA.B [$DE],Y                                   ; 058014 B7 DE 
  STA.B $D4                                       ; 058016 85 D4 
  INY                                             ; 058018 C8 
  INY                                             ; 058019 C8 
  LDA.B [$DE],Y                                   ; 05801A B7 DE 
  CLC                                             ; 05801C 18 
  ADC.W #$0002                                    ; 05801D 69 02 00 
  STA.B $DA                                       ; 058020 85 DA 
  LDA.W #$0004                                    ; 058022 A9 04 00 
  STA.B $DC                                       ; 058025 85 DC 
  STZ.B $E2                                       ; 058027 64 E2 
  STZ.B $E8                                       ; 058029 64 E8 
B_5802B:
  JSR.W L_580A6                                   ; 05802B 20 A6 80 
  BCS.B B_5805D                                   ; 05802E B0 2D 
  LDA.W #$0001                                    ; 058030 A9 01 00 
D_58033:
  JSR.W L_580A6                                   ; 058033 20 A6 80 
  BCS.B B_5803F                                   ; 058036 B0 07 
  JSR.W L_580A6                                   ; 058038 20 A6 80 
  ROL                                             ; 05803B 2A 
  JMP.W D_58033                                   ; 05803C 4C 33 80 
B_5803F:
  TAX                                             ; 05803F AA 
B_58040:
  LDY.B $DC                                       ; 058040 A4 DC 
  LDA.B [$DE],Y                                   ; 058042 B7 DE 
  INY                                             ; 058044 C8 
  STY.B $DC                                       ; 058045 84 DC 
  LDY.B $D8                                       ; 058047 A4 D8 
  STA.W $0000,Y                                   ; 058049 99 00 00 
  INY                                             ; 05804C C8 
  STY.B $D8                                       ; 05804D 84 D8 
  INC.B $E2                                       ; 05804F E6 E2 
  DEX                                             ; 058051 CA 
  BNE.B B_58040                                   ; 058052 D0 EC 
  LDA.B $E2                                       ; 058054 A5 E2 
  CMP.B $D4                                       ; 058056 C5 D4 
  BCC.B B_5802B                                   ; 058058 90 D1 
  JMP.W D_580A3                                   ; 05805A 4C A3 80 
B_5805D:
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 05805D E2 30 
  LDA.B #$08                                      ; 05805F A9 08 
  LDX.B $E3                                       ; 058061 A6 E3 
  BNE.B B_58069                                   ; 058063 D0 04 
  LDA.B #$00                                      ; 058065 A9 00 
  LDX.B $E2                                       ; 058067 A6 E2 
B_58069:
  CLC                                             ; 058069 18 
  ADC.L D_58167,X                                 ; 05806A 7F 67 81 05 
  TAX                                             ; 05806E AA 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 05806F C2 30 
  LDA.W #$0000                                    ; 058071 A9 00 00 
B_58074:
  JSR.W L_580A6                                   ; 058074 20 A6 80 
  ROL                                             ; 058077 2A 
  DEX                                             ; 058078 CA 
  BNE.B B_58074                                   ; 058079 D0 F9 
  CLC                                             ; 05807B 18 
  ADC.B $D6                                       ; 05807C 65 D6 
  TAX                                             ; 05807E AA 
  LDA.W #$0001                                    ; 05807F A9 01 00 
D_58082:
  JSR.W L_580A6                                   ; 058082 20 A6 80 
  BCS.B B_5808E                                   ; 058085 B0 07 
  JSR.W L_580A6                                   ; 058087 20 A6 80 
  ROL                                             ; 05808A 2A 
  JMP.W D_58082                                   ; 05808B 4C 82 80 
B_5808E:
  INC A
  STA.B $E4                                       ; 05808F 85 E4 
  LDY.B $D8                                       ; 058091 A4 D8 
  MVN $7e,$7e                                     ; 058093 54 7E 7E 
  STY.B $D8                                       ; 058096 84 D8 
  SEC                                             ; 058098 38 
  LDA.B $E4                                       ; 058099 A5 E4 
  ADC.B $E2                                       ; 05809B 65 E2 
  STA.B $E2                                       ; 05809D 85 E2 
  CMP.B $D4                                       ; 05809F C5 D4 
  BCC.B B_5802B                                   ; 0580A1 90 88 
D_580A3:
  PLB                                             ; 0580A3 AB 
  PLP                                             ; 0580A4 28 
  RTL                                             ; 0580A5 6B 

L_580A6:
  DEC.B $E8                                       ; 0580A6 C6 E8 
  BPL.B B_580BE                                   ; 0580A8 10 14 
  STA.B $EC                                       ; 0580AA 85 EC 
  LDA.W #$000F                                    ; 0580AC A9 0F 00 
  STA.B $E8                                       ; 0580AF 85 E8 
  LDY.B $DA                                       ; 0580B1 A4 DA 
  LDA.B [$DE],Y                                   ; 0580B3 B7 DE 
  XBA                                             ; 0580B5 EB 
  STA.B $EA                                       ; 0580B6 85 EA 
  INY                                             ; 0580B8 C8 
  INY                                             ; 0580B9 C8 
  STY.B $DA                                       ; 0580BA 84 DA 
  LDA.B $EC                                       ; 0580BC A5 EC 
B_580BE:
  ASL.B $EA                                       ; 0580BE 06 EA 
  RTS                                             ; 0580C0 60 


L_580C1:
  PHP                                             ; 0580C1 08 
  PHB                                             ; 0580C2 8B 
  STA.B $DE                                       ; 0580C3 85 DE 
  STY.B $E0                                       ; 0580C5 84 E0 
  STX.B $D6                                       ; 0580C7 86 D6 
  STX.B $D8                                       ; 0580C9 86 D8 
  STZ.B $E4                                       ; 0580CB 64 E4 
  PEA.W $7F7F                                     ; 0580CD F4 7F 7F 
  PLB                                             ; 0580D0 AB 
  PLB                                             ; 0580D1 AB 
  LDY.W #$0000                                    ; 0580D2 A0 00 00 
  LDA.B [$DE],Y                                   ; 0580D5 B7 DE 
  STA.B $D4                                       ; 0580D7 85 D4 
  INY                                             ; 0580D9 C8 
  INY                                             ; 0580DA C8 
  LDA.B [$DE],Y                                   ; 0580DB B7 DE 
  CLC                                             ; 0580DD 18 
  ADC.W #$0002                                    ; 0580DE 69 02 00 
  STA.B $DA                                       ; 0580E1 85 DA 
  LDA.W #$0004                                    ; 0580E3 A9 04 00 
  STA.B $DC                                       ; 0580E6 85 DC 
  STZ.B $E2                                       ; 0580E8 64 E2 
  STZ.B $E8                                       ; 0580EA 64 E8 
B_580EC:
  JSR.W L_580A6                                   ; 0580EC 20 A6 80 
  BCS.B B_5811E                                   ; 0580EF B0 2D 
  LDA.W #$0001                                    ; 0580F1 A9 01 00 
D_580F4:
  JSR.W L_580A6                                   ; 0580F4 20 A6 80 
  BCS.B B_58100                                   ; 0580F7 B0 07 
  JSR.W L_580A6                                   ; 0580F9 20 A6 80 
  ROL                                             ; 0580FC 2A 
  JMP.W D_580F4                                   ; 0580FD 4C F4 80 
B_58100:
  TAX                                             ; 058100 AA 
B_58101:
  LDY.B $DC                                       ; 058101 A4 DC 
  LDA.B [$DE],Y                                   ; 058103 B7 DE 
  INY                                             ; 058105 C8 
  STY.B $DC                                       ; 058106 84 DC 
  LDY.B $D8                                       ; 058108 A4 D8 
  STA.W $0000,Y                                   ; 05810A 99 00 00 
  INY                                             ; 05810D C8 
  STY.B $D8                                       ; 05810E 84 D8 
  INC.B $E2                                       ; 058110 E6 E2 
  DEX                                             ; 058112 CA 
  BNE.B B_58101                                   ; 058113 D0 EC 
  LDA.B $E2                                       ; 058115 A5 E2 
  CMP.B $D4                                       ; 058117 C5 D4 
  BCC.B B_580EC                                   ; 058119 90 D1 
  JMP.W D_58164                                   ; 05811B 4C 64 81 
B_5811E:
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 05811E E2 30 
  LDA.B #$08                                      ; 058120 A9 08 
  LDX.B $E3                                       ; 058122 A6 E3 
  BNE.B B_5812A                                   ; 058124 D0 04 
  LDA.B #$00                                      ; 058126 A9 00 
  LDX.B $E2                                       ; 058128 A6 E2 
B_5812A:
  CLC                                             ; 05812A 18 
  ADC.L D_58167,X                                 ; 05812B 7F 67 81 05 
  TAX                                             ; 05812F AA 
  REP.B #P_Idx8Bit | P_Acc8Bit                                      ; 058130 C2 30 
  LDA.W #$0000                                    ; 058132 A9 00 00 
B_58135:
  JSR.W L_580A6                                   ; 058135 20 A6 80 
  ROL                                             ; 058138 2A 
  DEX                                             ; 058139 CA 
  BNE.B B_58135                                   ; 05813A D0 F9 
  CLC                                             ; 05813C 18 
  ADC.B $D6                                       ; 05813D 65 D6 
  TAX                                             ; 05813F AA 
  LDA.W #$0001                                    ; 058140 A9 01 00 
D_58143:
  JSR.W L_580A6                                   ; 058143 20 A6 80 
  BCS.B B_5814F                                   ; 058146 B0 07 
  JSR.W L_580A6                                   ; 058148 20 A6 80 
  ROL                                             ; 05814B 2A 
  JMP.W D_58143                                   ; 05814C 4C 43 81 
B_5814F:
  INC A
  STA.B $E4                                       ; 058150 85 E4 
  LDY.B $D8                                       ; 058152 A4 D8 
  MVN $7f,$7f                                     ; 058154 54 7F 7F 
  STY.B $D8                                       ; 058157 84 D8 
  SEC                                             ; 058159 38 
  LDA.B $E4                                       ; 05815A A5 E4 
  ADC.B $E2                                       ; 05815C 65 E2 
  STA.B $E2                                       ; 05815E 85 E2 
  CMP.B $D4                                       ; 058160 C5 D4 
  BCC.B B_580EC                                   ; 058162 90 88 
D_58164:
  PLB                                             ; 058164 AB 
  PLP                                             ; 058165 28 
  RTL                                             ; 058166 6B 

D_58167:
.byte $00,$01,$02,$02,$03,$03,$03,$03             ; 058167 .DDDDDDD ????????
.byte $04,$04,$04,$04,$04,$04,$04,$04             ; 05816F DDDDDDDD ????????
.byte $05,$05,$05,$05,$05,$05,$05,$05             ; 058177 DDDDDDDD ????????
.byte $05,$05,$05,$05,$05,$05,$05,$05             ; 05817F DDDDDDDD ????????
.byte $06,$06,$06,$06,$06,$06,$06,$06             ; 058187 DDDDDDDD ????????
.byte $06,$06,$06,$06,$06,$06,$06,$06             ; 05818F DDDDDDDD ????????
.byte $06,$06,$06,$06,$06,$06,$06,$06             ; 058197 DDDDDDDD ????????
.byte $06,$06,$06,$06,$06,$06,$06,$06             ; 05819F DDDDDDDD ????????
.byte $07,$07,$07,$07,$07,$07,$07,$07             ; 0581A7 DDDDDDDD ????????
.byte $07,$07,$07,$07,$07,$07,$07,$07             ; 0581AF DDDDDDDD ????????
.byte $07,$07,$07,$07,$07,$07,$07,$07             ; 0581B7 DDDDDDDD ????????
.byte $07,$07,$07,$07,$07,$07,$07,$07             ; 0581BF DDDDDDDD ????????
.byte $07,$07,$07,$07,$07,$07,$07,$07             ; 0581C7 DDDDDDDD ????????
.byte $07,$07,$07,$07,$07,$07,$07,$07             ; 0581CF DDDDDDDD ????????
.byte $07,$07,$07,$07,$07,$07,$07,$07             ; 0581D7 DDDDDDDD ????????
.byte $07,$07,$07,$07,$07,$07,$07,$07             ; 0581DF DDDDDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 0581E7 DDDDDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 0581EF DDDDDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 0581F7 DD.DDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 0581FF DDDDDD.D ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 058207 D.D.DDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 05820F DD.DDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 058217 DDDDDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 05821F DDDDDD.D ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 058227 DDDDDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 05822F DDDDDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 058237 DDDDDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 05823F DD.DDD.D ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 058247 DDDDDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 05824F DDDDDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 058257 DDDDDDDD ????????
.byte $08,$08,$08,$08,$08,$08,$08,$08             ; 05825F DDDD.DDD ????????


L_58267:
  PHP                                             ; 058267 08 
  PHB                                             ; 058268 8B 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 058269 E2 30 
  LDA.B #$05                                      ; 05826B A9 05 
  PHA                                             ; 05826D 48 
  PLB                                             ; 05826E AB 
  JSR.W L_58419                                   ; 05826F 20 19 84 
  JSR.W L_58428                                   ; 058272 20 28 84 
  LDA.W $1873                                     ; 058275 AD 73 18 
  BEQ.B B_58280                                   ; 058278 F0 06 
  JSR.W L_585AE                                   ; 05827A 20 AE 85 
  JSR.W L_5866C                                   ; 05827D 20 6C 86 
B_58280:
  LDA.B $D2                                       ; 058280 A5 D2 
  AND.B #$07                                      ; 058282 29 07 
  BNE.B B_58289                                   ; 058284 D0 03 
  JSR.W L_5829C                                   ; 058286 20 9C 82 
B_58289:
  LDA.W $05D6                                     ; 058289 AD D6 05 
  BEQ.B B_58299                                   ; 05828C F0 0B 
  ORA.B #$80                                      ; 05828E 09 80 
  STA.W $05D6                                     ; 058290 8D D6 05 
  JSR.W L_583F9                                   ; 058293 20 F9 83 
  STZ.W $05D6                                     ; 058296 9C D6 05 
B_58299:
  PLB                                             ; 058299 AB 
  PLP                                             ; 05829A 28 
  RTL                                             ; 05829B 6B 

L_5829C:
  LDA.B #$08                                      ; 05829C A9 08 
  JSR.W L_583E1                                   ; 05829E 20 E1 83 
  LDA.B #$01                                      ; 0582A1 A9 01 
  STA.W $1872                                     ; 0582A3 8D 72 18 
  LDX.B #$01                                      ; 0582A6 A2 01 
B_582A8:
  LDA.W $18A3,X                                   ; 0582A8 BD A3 18 
  BEQ.B B_58317                                   ; 0582AB F0 6A 
  LDA.W EntityHeader,X                                   ; 0582AD BD D2 06 
  BEQ.B B_58317                                   ; 0582B0 F0 65 
  LDA.W EntityV3,X                                   ; 0582B2 BD 28 08 
  AND.B #$01                                      ; 0582B5 29 01 
  BEQ.B B_58317                                   ; 0582B7 F0 5E 
  LDA.W $18A5,X                                   ; 0582B9 BD A5 18 
  BNE.B B_58317                                   ; 0582BC D0 59 
  LDA.W $18A9,X                                   ; 0582BE BD A9 18 
  BNE.B B_58317                                   ; 0582C1 D0 54 
  STX.B $1E                                       ; 0582C3 86 1E 
  SEC                                             ; 0582C5 38 
  LDA.W EntityV32,X                                   ; 0582C6 BD 16 15 
  SBC.B #$02                                      ; 0582C9 E9 02 
  STA.B XexzyItemLocationMaybe                    ; 0582CB 85 27 
  CLC                                             ; 0582CD 18 
  LDA.W EntityV33,X                                   ; 0582CE BD 88 15 
  ADC.B #$02                                      ; 0582D1 69 02 
  STA.B XexzyItemXPickupMaybe                     ; 0582D3 85 28 
  SEC                                             ; 0582D5 38 
  LDA.W EntityV34,X                                   ; 0582D6 BD FA 15 
  SBC.B #$02                                      ; 0582D9 E9 02 
  STA.B $29                                       ; 0582DB 85 29 
  CLC                                             ; 0582DD 18 
  LDA.W EntityV35,X                                   ; 0582DE BD 6C 16 
  ADC.B #$02                                      ; 0582E1 69 02 
  STA.B $2A                                       ; 0582E3 85 2A 
  LDX.B #$0F                                      ; 0582E5 A2 0F 
B_582E7:
  LDA.W $194B,X                                   ; 0582E7 BD 4B 19 
  BEQ.B B_58312                                   ; 0582EA F0 26 
  LDA.W $195B,X                                   ; 0582EC BD 5B 19 
  CMP.B XexzyItemLocationMaybe                    ; 0582EF C5 27 
  BCC.B B_58312                                   ; 0582F1 90 1F 
  LDA.B XexzyItemXPickupMaybe                     ; 0582F3 A5 28 
  CMP.W $195B,X                                   ; 0582F5 DD 5B 19 
  BCC.B B_58312                                   ; 0582F8 90 18 
  LDA.W $196B,X                                   ; 0582FA BD 6B 19 
  CMP.B $29                                       ; 0582FD C5 29 
  BCC.B B_58312                                   ; 0582FF 90 11 
  LDA.B $2A                                       ; 058301 A5 2A 
  CMP.W $196B,X                                   ; 058303 DD 6B 19 
  BCC.B B_58312                                   ; 058306 90 0A 
  STX.B $1F                                       ; 058308 86 1F 
  JSR.W L_5831B                                   ; 05830A 20 1B 83 
  JMP.W D_58315                                   ; 05830D 4C 15 83 

.byte $A6,$1F                                     ; 058311 ..       ??

B_58312:
  DEX                                             ; 058312 CA 
  BPL.B B_582E7                                   ; 058313 10 D2 
D_58315:
  LDX.B $1E                                       ; 058315 A6 1E 
B_58317:
  DEX                                             ; 058317 CA 
  BPL.B B_582A8                                   ; 058318 10 8E 
  RTS                                             ; 05831A 60 


L_5831B:
  LDA.B #$FF                                      ; 05831B A9 FF 
  STA.B $05                                       ; 05831D 85 05 
  LDX.B #$0F                                      ; 05831F A2 0F 
B_58321:
  LDA.W $194B,X                                   ; 058321 BD 4B 19 
  BEQ.B B_58331                                   ; 058324 F0 0B 
  LDA.W $197B,X                                   ; 058326 BD 7B 19 
  CMP.B $05                                       ; 058329 C5 05 
  BCS.B B_58331                                   ; 05832B B0 04 
  STA.B $05                                       ; 05832D 85 05 
  STX.B $04                                       ; 05832F 86 04 
B_58331:
  DEX                                             ; 058331 CA 
  BPL.B B_58321                                   ; 058332 10 ED 
  LDA.B $04                                       ; 058334 A5 04 
  CMP.B $1F                                       ; 058336 C5 1F 
  BEQ.B B_58356                                   ; 058338 F0 1C 
  LDX.B $04                                       ; 05833A A6 04 
  LDA.W $197B,X                                   ; 05833C BD 7B 19 
  PHA                                             ; 05833F 48 
  LDY.B $1F                                       ; 058340 A4 1F 
  LDA.W $197B,Y                                   ; 058342 B9 7B 19 
  STA.W $197B,X                                   ; 058345 9D 7B 19 
  PLA                                             ; 058348 68 
  STA.W $197B,Y                                   ; 058349 99 7B 19 
  LDX.B $04                                       ; 05834C A6 04 
  JSR.W L_58398                                   ; 05834E 20 98 83 
  LDX.B $1F                                       ; 058351 A6 1F 
  JSR.W L_58398                                   ; 058353 20 98 83 
B_58356:
  JSL FindEmptyEntitySlot                                     ; 058356 22 F3 80 03 
  BEQ.B B_5835D                                   ; 05835A F0 01 

.byte $60                                         ; 05835D .        `

B_5835D:
  PHX                                             ; 05835D DA 
  LDA.B #$2A                                      ; 05835E A9 2A 
  JSR.W L_58844                                   ; 058360 20 44 88 
  LDA.B #$10                                      ; 058363 A9 10 
  STA.B $A7                                       ; 058365 85 A7 
  STZ.B $A8                                       ; 058367 64 A8 
  STZ.B $A9                                       ; 058369 64 A9 
  LDA.B $1E                                       ; 05836B A5 1E 
  JSL IncreasePlayerScore                                      ; 05836D 22 6D E4 00 
  PLX                                             ; 058371 FA 
  JSL ClearEntitySlotData                                     ; 058372 22 94 80 03 
  LDA.B #$01                                      ; 058376 A9 01 
  STA.W EntityHeader,X                                   ; 058378 9D D2 06 
  LDY.B $1F                                       ; 05837B A4 1F 
  LDA.W $195B,Y                                   ; 05837D B9 5B 19 
  STA.W EntityXPx,X                              ; 058380 9D 46 0B 
  LDA.W $196B,Y                                   ; 058383 B9 6B 19 
  STA.W EntityYPx,X                                   ; 058386 9D 9C 0C 
  LDA.W $197B,Y                                   ; 058389 B9 7B 19 
  STA.W EntityV31,X                                   ; 05838C 9D A0 14 
  LDA.B #$00                                      ; 05838F A9 00 
  STA.W $194B,Y                                   ; 058391 99 4B 19 
  JSR.W L_58CED                                   ; 058394 20 ED 8C 
  RTS                                             ; 058397 60 


L_58398:
  LDA.W $197B,X                                   ; 058398 BD 7B 19 
  ASL                                             ; 05839B 0A 
  ASL                                             ; 05839C 0A 
  TAY                                             ; 05839D A8 
  BCC.B B_583B3                                   ; 05839E 90 13 
  SEC                                             ; 0583A0 38 
  LDA.W $195B,X                                   ; 0583A1 BD 5B 19 
  SBC.B #$08                                      ; 0583A4 E9 08 
  STA.W $0408,Y                                   ; 0583A6 99 08 04 
  SEC                                             ; 0583A9 38 
  LDA.W $196B,X                                   ; 0583AA BD 6B 19 
  SBC.B #$09                                      ; 0583AD E9 09 
  STA.W $0409,Y                                   ; 0583AF 99 09 04 
  RTS                                             ; 0583B2 60 


B_583B3:
.byte $38,$BD,$5B,$19,$E9,$08,$99,$08             ; 0583B3 ........ 8?[?????
.byte $03,$38,$BD,$6B,$19,$E9,$09,$99             ; 0583BB ........ ?8?k????
.byte $09,$03,$60                                 ; 0583C4 ...      ??`


L_583C6:
  STA.B $04                                       ; 0583C6 85 04 
  LDY.B #$00                                      ; 0583C8 A0 00 
  LDX.B #$3F                                      ; 0583CA A2 3F 
B_583CC:
  LDA.W EntityHeader+2,X                         ; 0583CC BD D4 06 
  BEQ.B B_583DB                                   ; 0583CF F0 0A 
  LDA.W EntityV3+2,X                                   ; 0583D1 BD 2A 08 
  AND.B $04                                       ; 0583D4 25 04 
  BEQ.B B_583DB                                   ; 0583D6 F0 03 
  STX.B XexzyDropIndicator,Y                      ; 0583D8 96 43 
  INY                                             ; 0583DA C8 
B_583DB:
  DEX                                             ; 0583DB CA 
  BPL.B B_583CC                                   ; 0583DC 10 EE 
  STX.B XexzyDropIndicator,Y                      ; 0583DE 96 43 
  RTS                                             ; 0583E0 60 


L_583E1:
  STA.B $04                                       ; 0583E1 85 04 
  LDX.B #$3F                                      ; 0583E3 A2 3F 
B_583E5:
  STZ.B XexzyDropIndicator,X                      ; 0583E5 74 43 
  LDA.W EntityHeader+2,X                         ; 0583E7 BD D4 06 
  BEQ.B B_583F5                                   ; 0583EA F0 09 
  LDA.W EntityV3+2,X                                   ; 0583EC BD 2A 08 
  AND.B $04                                       ; 0583EF 25 04 
  BEQ.B B_583F5                                   ; 0583F1 F0 02 
  INC.B XexzyDropIndicator,X                      ; 0583F3 F6 43 
B_583F5:
  DEX                                             ; 0583F5 CA 
  BPL.B B_583E5                                   ; 0583F6 10 ED 
  RTS                                             ; 0583F8 60 


L_583F9:
  LDA.B #$01                                      ; 0583F9 A9 01 
  STA.W $1872                                     ; 0583FB 8D 72 18 
  LDA.W $05D6                                     ; 0583FE AD D6 05 
  AND.B #$7F                                      ; 058401 29 7F 
  TAX                                             ; 058403 AA 
  DEX                                             ; 058404 CA 
  STX.B $1E                                       ; 058405 86 1E 
  LDX.B #$3F                                      ; 058407 A2 3F 
B_58409:
  LDA.W EntityHeader+2,X                         ; 058409 BD D4 06 
  BEQ.B B_58415                                   ; 05840C F0 07 
  STX.B $1F                                       ; 05840E 86 1F 
  JSR.W EnemyHitByProjectile                                   ; 058410 20 29 8E 
  LDX.B $1F                                       ; 058413 A6 1F 
B_58415:
  DEX                                             ; 058415 CA 
  BPL.B B_58409                                   ; 058416 10 F1 
  RTS                                             ; 058418 60 


L_58419:
  JSR.W L_5849F                                   ; 058419 20 9F 84 
  LDA.B #$00                                      ; 05841C A9 00 
  STA.W $1872                                     ; 05841E 8D 72 18 
  JSR.W L_584E4                                   ; 058421 20 E4 84 
  JSR.W L_58549                                   ; 058424 20 49 85 
  RTS                                             ; 058427 60 


L_58428:
  LDA.B #$08                                      ; 058428 A9 08 
  JSR.W L_583E1                                   ; 05842A 20 E1 83 
  LDA.B #$01                                      ; 05842D A9 01 
  STA.W $1872                                     ; 05842F 8D 72 18 
  LDX.B #$01                                      ; 058432 A2 01 
B_58434:
  LDA.W $18A3,X                                   ; 058434 BD A3 18 
  BEQ.B B_5849B                                   ; 058437 F0 62 
  LDA.W EntityHeader,X                                   ; 058439 BD D2 06 
  BEQ.B B_5849B                                   ; 05843C F0 5D 
  LDA.W EntityV3,X                                   ; 05843E BD 28 08 
  AND.B #$01                                      ; 058441 29 01 
  BEQ.B B_5849B                                   ; 058443 F0 56 
  LDA.W $18A5,X                                   ; 058445 BD A5 18 
  BNE.B B_5849B                                   ; 058448 D0 51 
  STX.B $1E                                       ; 05844A 86 1E 
  LDA.W EntityV32,X                                   ; 05844C BD 16 15 
  STA.B XexzyItemLocationMaybe                    ; 05844F 85 27 
  LDA.W EntityV33,X                                   ; 058451 BD 88 15 
  STA.B XexzyItemXPickupMaybe                     ; 058454 85 28 
  LDA.W EntityV34,X                                   ; 058456 BD FA 15 
  STA.B $29                                       ; 058459 85 29 
  LDA.W EntityV35,X                                   ; 05845B BD 6C 16 
  STA.B $2A                                       ; 05845E 85 2A 
  LDX.B #$3F                                      ; 058460 A2 3F 
B_58462:
  LDA.B XexzyDropIndicator,X                      ; 058462 B5 43 
  BEQ.B B_58496                                   ; 058464 F0 30 
  LDA.W EntityV33+2,X                                   ; 058466 BD 8A 15 
  CMP.B XexzyItemLocationMaybe                    ; 058469 C5 27 
  BCC.B B_58496                                   ; 05846B 90 29 
  LDA.B XexzyItemXPickupMaybe                     ; 05846D A5 28 
  CMP.W EntityV32+2,X                                   ; 05846F DD 18 15 
  BCC.B B_58496                                   ; 058472 90 22 
  LDA.W EntityV35+2,X                                   ; 058474 BD 6E 16 
  CMP.B $29                                       ; 058477 C5 29 
  BCC.B B_58496                                   ; 058479 90 1B 
  LDA.B $2A                                       ; 05847B A5 2A 
  CMP.W EntityV34+2,X                                   ; 05847D DD FC 15 
  BCC.B B_58496                                   ; 058480 90 14 
  STX.B $1F                                       ; 058482 86 1F 
  LDY.B $1E                                       ; 058484 A4 1E 
  LDA.W $18A9,Y                                   ; 058486 B9 A9 18 
  BEQ.B B_58491                                   ; 058489 F0 06 
  JSR.W EnemyHitByProjectile                                   ; 05848B 20 29 8E 
  JMP.W D_58494                                   ; 05848E 4C 94 84 
B_58491:
  JSR.W PlayerHitEntity                                   ; 058491 20 3E 8E 
D_58494:
  LDX.B $1F                                       ; 058494 A6 1F 
B_58496:
  DEX                                             ; 058496 CA 
  BPL.B B_58462                                   ; 058497 10 C9 
  LDX.B $1E                                       ; 058499 A6 1E 
B_5849B:
  DEX                                             ; 05849B CA 
  BPL.B B_58434                                   ; 05849C 10 96 
  RTS                                             ; 05849E 60 


L_5849F:
  LDX.B #$07                                      ; 05849F A2 07 
  LDA.B #$FF                                      ; 0584A1 A9 FF 
B_584A3:
  STA.B $2B,X                                     ; 0584A3 95 2B 
  STA.B $33,X                                     ; 0584A5 95 33 
  DEX                                             ; 0584A7 CA 
  BPL.B B_584A3                                   ; 0584A8 10 F9 
  LDX.B #$3F                                      ; 0584AA A2 3F 
B_584AC:
  STZ.B XexzyDropIndicator,X                      ; 0584AC 74 43 
  LDA.W EntityHeader+2,X                         ; 0584AE BD D4 06 
  BEQ.B B_584E0                                   ; 0584B1 F0 2D 
  LDA.W EntityV3+2,X                                   ; 0584B3 BD 2A 08 
  AND.B #$04                                      ; 0584B6 29 04 
  BEQ.B B_584E0                                   ; 0584B8 F0 26 
  INC.B XexzyDropIndicator,X                      ; 0584BA F6 43 
  LDY.W EntityV32+2,X                                   ; 0584BC BC 18 15 
  LDA.W D_58744,Y                                 ; 0584BF B9 44 87 
  STA.B $04                                       ; 0584C2 85 04 
  TAY                                             ; 0584C4 A8 
  LDA.W $002B,Y                                   ; 0584C5 B9 2B 00 
  STA.W EntityV36,X                                   ; 0584C8 9D DE 16 
  STX.B $2B,Y                                     ; 0584CB 96 2B 
  LDY.W EntityV33+2,X                                   ; 0584CD BC 8A 15 
  LDA.W D_58744,Y                                 ; 0584D0 B9 44 87 
  CMP.B $04                                       ; 0584D3 C5 04 
  BEQ.B B_584E0                                   ; 0584D5 F0 09 
  TAY                                             ; 0584D7 A8 
  LDA.W $0033,Y                                   ; 0584D8 B9 33 00 
  STA.W $171E,X                                   ; 0584DB 9D 1E 17 
  STX.B $33,Y                                     ; 0584DE 96 33 
B_584E0:
  DEX                                             ; 0584E0 CA 
  BPL.B B_584AC                                   ; 0584E1 10 C9 
  RTS                                             ; 0584E3 60 


L_584E4:
  LDX.B #$2F                                      ; 0584E4 A2 2F 
B_584E6:
  LDA.W EntityHeader+Projectiles,X                                   ; 0584E6 BD 14 07 
  BEQ.B B_58545                                   ; 0584E9 F0 5A 
  LDA.W EntityV3+Projectiles,X                                   ; 0584EB BD 6A 08 
D_584EE:
  AND.B #$02                                      ; 0584EE 29 02 
  BEQ.B B_58545                                   ; 0584F0 F0 53 
  STX.B $1E                                       ; 0584F2 86 1E 
  LDA.W EntityV32+Projectiles,X                                   ; 0584F4 BD 58 15 
  STA.B XexzyItemLocationMaybe                    ; 0584F7 85 27 
  LDA.W EntityV33+Projectiles,X                                   ; 0584F9 BD CA 15 
  STA.B XexzyItemXPickupMaybe                     ; 0584FC 85 28 
  LDA.W EntityV34+Projectiles,X                                   ; 0584FE BD 3C 16 
  STA.B $29                                       ; 058501 85 29 
  LDA.W EntityV35+Projectiles,X                                   ; 058503 BD AE 16 
  STA.B $2A                                       ; 058506 85 2A 
  LDY.W EntityXPx+Projectiles,X                                   ; 058508 BC 88 0B 
  LDA.W D_58744,Y                                 ; 05850B B9 44 87 
  TAY                                             ; 05850E A8 
  LDX.B $2B,Y                                     ; 05850F B6 2B 
  BMI.B B_58543                                   ; 058511 30 30 
B_58513:
  LDA.B XexzyDropIndicator,X                      ; 058513 B5 43 
  BEQ.B B_5853D                                   ; 058515 F0 26 
  LDA.W EntityV35+2,X                                   ; 058517 BD 6E 16 
  CMP.B $29                                       ; 05851A C5 29 
  BCC.B B_5853D                                   ; 05851C 90 1F 
  LDA.B $2A                                       ; 05851E A5 2A 
  CMP.W EntityV34+2,X                                   ; 058520 DD FC 15 
  BCC.B B_5853D                                   ; 058523 90 18 
  LDA.W EntityV33+2,X                                   ; 058525 BD 8A 15 
  CMP.B XexzyItemLocationMaybe                    ; 058528 C5 27 
  BCC.B B_5853D                                   ; 05852A 90 11 
  LDA.B XexzyItemXPickupMaybe                     ; 05852C A5 28 
  CMP.W EntityV32+2,X                                   ; 05852E DD 18 15 
  BCC.B B_5853D                                   ; 058531 90 0A 
  STX.B $1F                                       ; 058533 86 1F 
  JSR.W EnemyHitByProjectile                                   ; 058535 20 29 8E 
  JMP.W B_58543                                   ; 058538 4C 43 85 

.byte $A6,$1F                                     ; 05853C ..       ??

B_5853D:
  LDA.W EntityV36,X                                   ; 05853D BD DE 16 
  TAX                                             ; 058540 AA 
  BPL.B B_58513                                   ; 058541 10 D0 
B_58543:
  LDX.B $1E                                       ; 058543 A6 1E 
B_58545:
  DEX                                             ; 058545 CA 
  BPL.B B_584E6                                   ; 058546 10 9E 
  RTS                                             ; 058548 60 


L_58549:
  LDX.B #$2F                                      ; 058549 A2 2F 
B_5854B:
  LDA.W EntityHeader+Projectiles,X                                   ; 05854B BD 14 07 
  BEQ.B B_585AA                                   ; 05854E F0 5A 
  LDA.W EntityV3+Projectiles,X                                   ; 058550 BD 6A 08 
  AND.B #$02                                      ; 058553 29 02 
  BEQ.B B_585AA                                   ; 058555 F0 53 
  STX.B $1E                                       ; 058557 86 1E 
  LDA.W EntityV32+Projectiles,X                                   ; 058559 BD 58 15 
  STA.B XexzyItemLocationMaybe                    ; 05855C 85 27 
  LDA.W EntityV33+Projectiles,X                                   ; 05855E BD CA 15 
  STA.B XexzyItemXPickupMaybe                     ; 058561 85 28 
  LDA.W EntityV34+Projectiles,X                                   ; 058563 BD 3C 16 
  STA.B $29                                       ; 058566 85 29 
  LDA.W EntityV35+Projectiles,X                                   ; 058568 BD AE 16 
  STA.B $2A                                       ; 05856B 85 2A 
  LDY.W EntityXPx+Projectiles,X                                   ; 05856D BC 88 0B 
  LDA.W D_58744,Y                                 ; 058570 B9 44 87 
  TAY                                             ; 058573 A8 
  LDX.B $33,Y                                     ; 058574 B6 33 
  BMI.B B_585A8                                   ; 058576 30 30 
B_58578:
  LDA.B XexzyDropIndicator,X                      ; 058578 B5 43 
  BEQ.B B_585A2                                   ; 05857A F0 26 
  LDA.W EntityV35+2,X                                   ; 05857C BD 6E 16 
  CMP.B $29                                       ; 05857F C5 29 
  BCC.B B_585A2                                   ; 058581 90 1F 
  LDA.B $2A                                       ; 058583 A5 2A 
  CMP.W EntityV34+2,X                                   ; 058585 DD FC 15 
  BCC.B B_585A2                                   ; 058588 90 18 
  LDA.W EntityV33+2,X                                   ; 05858A BD 8A 15 
  CMP.B XexzyItemLocationMaybe                    ; 05858D C5 27 
  BCC.B B_585A2                                   ; 05858F 90 11 
  LDA.B XexzyItemXPickupMaybe                     ; 058591 A5 28 
  CMP.W EntityV32+2,X                                   ; 058593 DD 18 15 
  BCC.B B_585A2                                   ; 058596 90 0A 
  STX.B $1F                                       ; 058598 86 1F 
  JSR.W EnemyHitByProjectile                                   ; 05859A 20 29 8E 
  JMP.W B_585A8                                   ; 05859D 4C A8 85 

.byte $A6,$1F                                     ; 0585A1 ..       ??

B_585A2:
  LDA.W $171E,X                                   ; 0585A2 BD 1E 17 
  TAX                                             ; 0585A5 AA 
  BPL.B B_58578                                   ; 0585A6 10 D0 
B_585A8:
  LDX.B $1E                                       ; 0585A8 A6 1E 
B_585AA:
  DEX                                             ; 0585AA CA 
  BPL.B B_5854B                                   ; 0585AB 10 9E 
  RTS                                             ; 0585AD 60 


L_585AE:
  LDA.B #$05                                      ; 0585AE A9 05 
  STA.B $24                                       ; 0585B0 85 24 
  LDA.B #$AB                                      ; 0585B2 A9 AB 
  STA.B $25                                       ; 0585B4 85 25 
  LDA.B #$10                                      ; 0585B6 A9 10 
  JSR.W L_583C6                                   ; 0585B8 20 C6 83 
  LDA.B #$00                                      ; 0585BB A9 00 
  STA.W $1872                                     ; 0585BD 8D 72 18 
  LDX.B #$2F                                      ; 0585C0 A2 2F 
B_585C2:
  LDA.W EntityHeader+Projectiles,X                                   ; 0585C2 BD 14 07 
  BEQ.B B_58608                                   ; 0585C5 F0 41 
  LDA.W EntityV3+Projectiles,X                                   ; 0585C7 BD 6A 08 
  AND.B #$02                                      ; 0585CA 29 02 
  BEQ.B B_58608                                   ; 0585CC F0 3A 
  STX.B $1E                                       ; 0585CE 86 1E 
  LDA.W EntityV32+Projectiles,X                                   ; 0585D0 BD 58 15 
  STA.B XexzyItemLocationMaybe                    ; 0585D3 85 27 
  LDA.W EntityV33+Projectiles,X                                   ; 0585D5 BD CA 15 
  STA.B XexzyItemXPickupMaybe                     ; 0585D8 85 28 
  LDA.W EntityV34+Projectiles,X                                   ; 0585DA BD 3C 16 
  STA.B $29                                       ; 0585DD 85 29 
  LDA.W EntityV35+Projectiles,X                                   ; 0585DF BD AE 16 
  STA.B $2A                                       ; 0585E2 85 2A 
  STZ.W $06BE                                     ; 0585E4 9C BE 06 
  LDY.B #$00                                      ; 0585E7 A0 00 
B_585E9:
  LDX.B XexzyDropIndicator,Y                      ; 0585E9 B6 43 
  BMI.B B_58606                                   ; 0585EB 30 19 
  STX.B $1F                                       ; 0585ED 86 1F 
  INC.W $06BE                                     ; 0585EF EE BE 06 
  PHY                                             ; 0585F2 5A 
  LDA.W EntityHeader+2,X                         ; 0585F3 BD D4 06 
  BEQ.B B_58602                                   ; 0585F6 F0 0A 
  LDA.W EntityV3+2,X                                   ; 0585F8 BD 2A 08 
  AND.B #$10                                      ; 0585FB 29 10 
  BEQ.B B_58602                                   ; 0585FD F0 03 
  JSR.W L_5860C                                   ; 0585FF 20 0C 86 
B_58602:
  PLY                                             ; 058602 7A 
  INY                                             ; 058603 C8 
  BRA.B B_585E9                                   ; 058604 80 E3 
B_58606:
  LDX.B $1E                                       ; 058606 A6 1E 
B_58608:
  DEX                                             ; 058608 CA 
  BPL.B B_585C2                                   ; 058609 10 B7 
  RTS                                             ; 05860B 60 


L_5860C:
  CLC                                             ; 05860C 18 
  LDA.W EntityV25+2,X                                   ; 05860D BD F6 11 
  ADC.W EntityV4+2,X                                   ; 058610 7D 9C 08 
  ASL                                             ; 058613 0A 
  TAY                                             ; 058614 A8 
  LDA.B ($24),Y                                   ; 058615 B1 24 
  STA.B $04                                       ; 058617 85 04 
  INY                                             ; 058619 C8 
  LDA.B ($24),Y                                   ; 05861A B1 24 
  STA.B $05                                       ; 05861C 85 05 
  LDY.B #$00                                      ; 05861E A0 00 
  LDA.B ($04),Y                                   ; 058620 B1 04 
  STA.B $23                                       ; 058622 85 23 
  STA.W $06BF                                     ; 058624 8D BF 06 
  BEQ.B B_5866B                                   ; 058627 F0 42 
  LDA.W EntityXPx+2,X                                   ; 058629 BD 48 0B 
  STA.B $20                                       ; 05862C 85 20 
  LDA.W EntityYPx+2,X                                   ; 05862E BD 9E 0C 
  STA.B $21                                       ; 058631 85 21 
B_58633:
  PHY                                             ; 058633 5A 
  INY                                             ; 058634 C8 
  CLC                                             ; 058635 18 
  LDA.B $20                                       ; 058636 A5 20 
  ADC.B ($04),Y                                   ; 058638 71 04 
  CMP.B XexzyItemXPickupMaybe                     ; 05863A C5 28 
  BCS.B B_58662                                   ; 05863C B0 24 
  INY                                             ; 05863E C8 
  CLC                                             ; 05863F 18 
  ADC.B ($04),Y                                   ; 058640 71 04 
  CMP.B XexzyItemLocationMaybe                    ; 058642 C5 27 
  BCC.B B_58662                                   ; 058644 90 1C 
  INY                                             ; 058646 C8 
  CLC                                             ; 058647 18 
  LDA.B $21                                       ; 058648 A5 21 
  ADC.B ($04),Y                                   ; 05864A 71 04 
  CMP.B $2A                                       ; 05864C C5 2A 
  BCS.B B_58662                                   ; 05864E B0 12 
  INY                                             ; 058650 C8 
  CLC                                             ; 058651 18 
  ADC.B ($04),Y                                   ; 058652 71 04 
  CMP.B $29                                       ; 058654 C5 29 
  BCC.B B_58662                                   ; 058656 90 0A 
  INY                                             ; 058658 C8 
  LDA.B ($04),Y                                   ; 058659 B1 04 
  STA.B $26                                       ; 05865B 85 26 
  PLA                                             ; 05865D 68 
  JSR.W EnemyHitByProjectile                                   ; 05865E 20 29 8E 
  RTS                                             ; 058661 60 

B_58662:
  CLC                                             ; 058662 18 
  PLA                                             ; 058663 68 
  ADC.B #$05                                      ; 058664 69 05 
  TAY                                             ; 058666 A8 
  DEC.B $23                                       ; 058667 C6 23 
  BNE.B B_58633                                   ; 058669 D0 C8 
B_5866B:
  RTS                                             ; 05866B 60 


L_5866C:
  LDA.B #$05                                      ; 05866C A9 05 
  STA.B $24                                       ; 05866E 85 24 
  LDA.B #$AB                                      ; 058670 A9 AB 
  STA.B $25                                       ; 058672 85 25 
  LDA.B #$20                                      ; 058674 A9 20 
  JSR.W L_583C6                                   ; 058676 20 C6 83 
  LDA.B #$01                                      ; 058679 A9 01 
  STA.W $1872                                     ; 05867B 8D 72 18 
  LDA.B #$01                                      ; 05867E A9 01 
  STA.W $1872                                     ; 058680 8D 72 18 
  LDX.B #$01                                      ; 058683 A2 01 
B_58685:
  LDA.W $18A3,X                                   ; 058685 BD A3 18 
  BEQ.B B_586D5                                   ; 058688 F0 4B 
  LDA.W EntityHeader,X                                   ; 05868A BD D2 06 
  BEQ.B B_586D5                                   ; 05868D F0 46 
  LDA.W EntityV3,X                                   ; 05868F BD 28 08 
  AND.B #$01                                      ; 058692 29 01 
  BEQ.B B_586D5                                   ; 058694 F0 3F 
  LDA.W $18A5,X                                   ; 058696 BD A5 18 
  BNE.B B_586D5                                   ; 058699 D0 3A 
  STX.B $1E                                       ; 05869B 86 1E 
  LDA.W EntityV32,X                                   ; 05869D BD 16 15 
  STA.B XexzyItemLocationMaybe                    ; 0586A0 85 27 
  LDA.W EntityV33,X                                   ; 0586A2 BD 88 15 
  STA.B XexzyItemXPickupMaybe                     ; 0586A5 85 28 
  LDA.W EntityV34,X                                   ; 0586A7 BD FA 15 
  STA.B $29                                       ; 0586AA 85 29 
  LDA.W EntityV35,X                                   ; 0586AC BD 6C 16 
  STA.B $2A                                       ; 0586AF 85 2A 
  STZ.W $06BE                                     ; 0586B1 9C BE 06 
  LDY.B #$00                                      ; 0586B4 A0 00 
B_586B6:
  LDX.B XexzyDropIndicator,Y                      ; 0586B6 B6 43 
  BMI.B B_586D3                                   ; 0586B8 30 19 
  STX.B $1F                                       ; 0586BA 86 1F 
  INC.W $06BE                                     ; 0586BC EE BE 06 
  PHY                                             ; 0586BF 5A 
  LDA.W EntityHeader+2,X                         ; 0586C0 BD D4 06 
  BEQ.B B_586CF                                   ; 0586C3 F0 0A 
  LDA.W EntityV3+2,X                                   ; 0586C5 BD 2A 08 
  AND.B #$20                                      ; 0586C8 29 20 
  BEQ.B B_586CF                                   ; 0586CA F0 03 
  JSR.W L_586D9                                   ; 0586CC 20 D9 86 
B_586CF:
  PLY                                             ; 0586CF 7A 
  INY                                             ; 0586D0 C8 
  BRA.B B_586B6                                   ; 0586D1 80 E3 
B_586D3:
  LDX.B $1E                                       ; 0586D3 A6 1E 
B_586D5:
  DEX                                             ; 0586D5 CA 
  BPL.B B_58685                                   ; 0586D6 10 AD 
  RTS                                             ; 0586D8 60 


L_586D9:
  CLC                                             ; 0586D9 18 
  LDA.W EntityV25+2,X                                   ; 0586DA BD F6 11 
  ADC.W EntityV4+2,X                                   ; 0586DD 7D 9C 08 
  ASL                                             ; 0586E0 0A 
  TAY                                             ; 0586E1 A8 
  LDA.B ($24),Y                                   ; 0586E2 B1 24 
  STA.B $04                                       ; 0586E4 85 04 
  INY                                             ; 0586E6 C8 
  LDA.B ($24),Y                                   ; 0586E7 B1 24 
  STA.B $05                                       ; 0586E9 85 05 
  LDY.B #$00                                      ; 0586EB A0 00 
  LDA.B ($04),Y                                   ; 0586ED B1 04 
  STA.B $23                                       ; 0586EF 85 23 
  STA.W $06BF                                     ; 0586F1 8D BF 06 
  BEQ.B B_58743                                   ; 0586F4 F0 4D 
  LDA.W EntityXPx+2,X                                   ; 0586F6 BD 48 0B 
  STA.B $20                                       ; 0586F9 85 20 
  LDA.W EntityYPx+2,X                                   ; 0586FB BD 9E 0C 
  STA.B $21                                       ; 0586FE 85 21 
B_58700:
  PHY                                             ; 058700 5A 
  INY                                             ; 058701 C8 
  CLC                                             ; 058702 18 
  LDA.B $20                                       ; 058703 A5 20 
  ADC.B ($04),Y                                   ; 058705 71 04 
  CMP.B XexzyItemXPickupMaybe                     ; 058707 C5 28 
  BCS.B B_5873A                                   ; 058709 B0 2F 
  INY                                             ; 05870B C8 
  CLC                                             ; 05870C 18 
  ADC.B ($04),Y                                   ; 05870D 71 04 
  CMP.B XexzyItemLocationMaybe                    ; 05870F C5 27 
  BCC.B B_5873A                                   ; 058711 90 27 
  INY                                             ; 058713 C8 
  CLC                                             ; 058714 18 
  LDA.B $21                                       ; 058715 A5 21 
  ADC.B ($04),Y                                   ; 058717 71 04 
  CMP.B $2A                                       ; 058719 C5 2A 
  BCS.B B_5873A                                   ; 05871B B0 1D 
  INY                                             ; 05871D C8 
  CLC                                             ; 05871E 18 
  ADC.B ($04),Y                                   ; 05871F 71 04 
  CMP.B $29                                       ; 058721 C5 29 
  BCC.B B_5873A                                   ; 058723 90 15 
  INY                                             ; 058725 C8 
  LDA.B ($04),Y                                   ; 058726 B1 04 
  STA.B $26                                       ; 058728 85 26 
  PLA                                             ; 05872A 68 
  LDY.B $1E                                       ; 05872B A4 1E 
  LDA.W $18A9,Y                                   ; 05872D B9 A9 18 
  BEQ.B B_58736                                   ; 058730 F0 04 
  JSR.W EnemyHitByProjectile                                   ; 058732 20 29 8E 
  RTS                                             ; 058735 60 

B_58736:
  JSR.W PlayerHitEntity                                   ; 058736 20 3E 8E 
  RTS                                             ; 058739 60 

B_5873A:
  CLC                                             ; 05873A 18 
  PLA                                             ; 05873B 68 
  ADC.B #$05                                      ; 05873C 69 05 
  TAY                                             ; 05873E A8 
  DEC.B $23                                       ; 05873F C6 23 
  BNE.B B_58700                                   ; 058741 D0 BD 
B_58743:
  RTS                                             ; 058743 60 


D_58744:
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 058744 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05874C DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 058754 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05875C DDDDDDDD ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 058764 DDDDDDDD ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 05876C DDDDDDDD ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 058774 DDDDDDDD ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 05877C DDDDDDDD ????????
.byte $02,$02,$02,$02,$02,$02,$02,$02             ; 058784 DDDDDDDD ????????
.byte $02,$02,$02,$02,$02,$02,$02,$02             ; 05878C DDDDDDDD ????????
.byte $02,$02,$02,$02,$02,$02,$02,$02             ; 058794 DDDDDDDD ????????
.byte $02,$02,$02,$02,$02,$02,$02,$02             ; 05879C DDDDDDDD ????????
.byte $03,$03,$03,$03,$03,$03,$03,$03             ; 0587A4 DDDDDDDD ????????
.byte $03,$03,$03,$03,$03,$03,$03,$03             ; 0587AC DDDDDDDD ????????
.byte $03,$03,$03,$03,$03,$03,$03,$03             ; 0587B4 DDDDDDDD ????????
.byte $03,$03,$03,$03,$03,$03,$03,$03             ; 0587BC DDDDDDDD ????????
.byte $04,$04,$04,$04,$04,$04,$04,$04             ; 0587C4 DDDDDDDD ????????
.byte $04,$04,$04,$04,$04,$04,$04,$04             ; 0587CC DDDDDDDD ????????
.byte $04,$04,$04,$04,$04,$04,$04,$04             ; 0587D4 DDDDDDDD ????????
.byte $04,$04,$04,$04,$04,$04,$04,$04             ; 0587DC DDDDDDDD ????????
.byte $05,$05,$05,$05,$05,$05,$05,$05             ; 0587E4 DDDDDDDD ????????
.byte $05,$05,$05,$05,$05,$05,$05,$05             ; 0587EC DDDDDDDD ????????
.byte $05,$05,$05,$05,$05,$05,$05,$05             ; 0587F4 DDDDDDDD ????????
.byte $05,$05,$05,$05,$05,$05,$05,$05             ; 0587FC DDDDDDDD ????????
.byte $06,$06,$06,$06,$06,$06,$06,$06             ; 058804 DDDDDDDD ????????
.byte $06,$06,$06,$06,$06,$06,$06,$06             ; 05880C DDDDDDDD ????????
.byte $06,$06,$06,$06,$06,$06,$06,$06             ; 058814 DDDDDDDD ????????
.byte $06,$06,$06,$06,$06,$06,$06,$06             ; 05881C DDDDDDDD ????????
.byte $07,$07,$07,$07,$07,$07,$07,$07             ; 058824 DDDDDDDD ????????
.byte $07,$07,$07,$07,$07,$07,$07,$07             ; 05882C DDDDDDDD ????????
.byte $07,$07,$07,$07,$07,$07,$07,$07             ; 058834 DDDDDDDD ????????
.byte $07,$07,$07,$07,$07,$07,$07,$07             ; 05883C DDDDDDDD ????????


L_58844:
  STA.B $04                                       ; 058844 85 04 
  PHX                                             ; 058846 DA 
  LDX.B $1E                                       ; 058847 A6 1E 
  LDA.W $18A5,X                                   ; 058849 BD A5 18 
  BNE.B B_588A5                                   ; 05884C D0 57 
  INC.W $18A5,X                                   ; 05884E FE A5 18 
  LDA.B #$10                                      ; 058851 A9 10 
  STA.B $A7                                       ; 058853 85 A7 
  STZ.B $A8                                       ; 058855 64 A8 
  STZ.B $A9                                       ; 058857 64 A9 
  TXA                                             ; 058859 8A 
  JSL IncreasePlayerScore                                      ; 05885A 22 6D E4 00 
  STZ.W $18B4,X                                   ; 05885E 9E B4 18 
  STZ.W $18B8,X                                   ; 058861 9E B8 18 
  STZ.W $18B6,X                                   ; 058864 9E B6 18 
  STZ.W $18BA,X                                   ; 058867 9E BA 18 
  LDA.B #$40                                      ; 05886A A9 40 
  STA.W $188A,X                                   ; 05886C 9D 8A 18 
  LDA.W EquippedWeaponType,X                                   ; 05886F BD 97 18 
  CMP.B #$03                                      ; 058872 C9 03 
  BNE.B B_58886                                   ; 058874 D0 10 
  PHX                                             ; 058876 DA 
  LDX.W $18D1                                     ; 058877 AE D1 18 
  DEC.W $18C5,X                                   ; 05887A DE C5 18 
  BNE.B B_58885                                   ; 05887D D0 06 
  STZ.W $18C9,X                                   ; 05887F 9E C9 18 
  STZ.W $18C1,X                                   ; 058882 9E C1 18 
B_58885:
  PLX                                             ; 058885 FA 
B_58886:
  PHX                                             ; 058886 DA 
  REP.B #P_Idx8Bit                                      ; 058887 C2 10 
  LDA.B #$00                                      ; 058889 A9 00 
  XBA                                             ; 05888B EB 
  SEC                                             ; 05888C 38 
  LDA.B $04                                       ; 05888D A5 04 
  SBC.B #$2A                                      ; 05888F E9 2A 
  ASL                                             ; 058891 0A 
  TAY                                             ; 058892 A8 
  LDX.W D_588A7,Y                                 ; 058893 BE A7 88 
  LDA.B #$07                                      ; 058896 A9 07 
  JSL Audio_F830F                                     ; 058898 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 05889C E2 30 
  PLX                                             ; 05889E FA 
  LDA.B $04                                       ; 05889F A5 04 
  JSL L_E593                                      ; 0588A1 22 93 E5 00 
B_588A5:
  PLX                                             ; 0588A5 FA 
  RTS                                             ; 0588A6 60 


D_588A7:
.byte $09,$FF,$0A,$FF,$09,$FF                     ; 0588A8 DDDD..   ??????


L_588AD:
  LDA.W $1872                                     ; 0588AD AD 72 18 
  BNE.B B_58925                                   ; 0588B0 D0 73 
  CLC                                             ; 0588B2 18 
  LDA.B $1E                                       ; 0588B3 A5 1E 
  ADC.B #$42                                      ; 0588B5 69 42 
  TAX                                             ; 0588B7 AA 
  LDA.W EntityTypeId,X                                   ; 0588B8 BD 44 07 
  CMP.B #$34                                      ; 0588BB C9 34 
  BEQ.B B_58925                                   ; 0588BD F0 66 
  CMP.B #$37                                      ; 0588BF C9 37 
  BEQ.B B_58925                                   ; 0588C1 F0 62 
  CMP.B #$36                                      ; 0588C3 C9 36 
  BNE.B B_588DB                                   ; 0588C5 D0 14 
  LDA.W EntityV19,X                                   ; 0588C7 BD 48 0F 
  INC A
  STA.W EntityV19,X                                   ; 0588CB 9D 48 0F 
  CMP.B #$08                                      ; 0588CE C9 08 
  BNE.B B_58925                                   ; 0588D0 D0 53 
  LDA.B #$37                                      ; 0588D2 A9 37 
  STA.W EntityTypeId,X                                   ; 0588D4 9D 44 07 
  DEC.W PlayerRazorShieldStatus                                     ; 0588D7 CE D1 05 
  RTS                                             ; 0588DA 60 

B_588DB:
  CMP.B #$38                                      ; 0588DB C9 38 
  BNE.B B_588EF                                   ; 0588DD D0 10 
  LDA.B #$10                                      ; 0588DF A9 10 
  STA.W EntityTypeId,X                                   ; 0588E1 9D 44 07 
  LDA.B #$FF                                      ; 0588E4 A9 FF 
  STA.W PlayerOrbStatus                                     ; 0588E6 8D CE 05 
  LDA.B #$00                                      ; 0588E9 A9 00 
  STA.W EntityV3,X                                   ; 0588EB 9D 28 08 
  RTS                                             ; 0588EE 60 

B_588EF:
  CMP.B #$35                                      ; 0588EF C9 35 
  BNE.B B_588F9                                   ; 0588F1 D0 06 
  LDA.B #$01                                      ; 0588F3 A9 01 
  STA.W EntityV15,X                                   ; 0588F5 9D 80 0D 
  RTS                                             ; 0588F8 60 

B_588F9:
  CMP.B #$39                                      ; 0588F9 C9 39 
  BNE.B B_58903                                   ; 0588FB D0 06 

.byte $A9,$00,$9D,$28,$08,$60                     ; 0588FE ......   ???(?`

B_58903:
  STZ.W EntityHeader,X                                   ; 058903 9E D2 06 
  PHX                                             ; 058906 DA 
  LDY.W EntityV31,X                                   ; 058907 BC A0 14 
  JSL L_AEF1                                      ; 05890A 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 05890E BD A0 14 
  TAX                                             ; 058911 AA 
  STZ.W $175E,X                                   ; 058912 9E 5E 17 
  ASL                                             ; 058915 0A 
  ASL                                             ; 058916 0A 
  TAY                                             ; 058917 A8 
  LDA.B #$F0                                      ; 058918 A9 F0 
  BCC.B B_58921                                   ; 05891A 90 05 
  STA.W $0409,Y                                   ; 05891C 99 09 04 
  BRA.B B_58924                                   ; 05891F 80 03 

B_58921:
.byte $99,$09,$03                                 ; 058922 ...      ???

B_58924:
  PLX                                             ; 058924 FA 
B_58925:
  RTS                                             ; 058925 60 


L_58926:
  LDA.W $1872                                     ; 058926 AD 72 18 
  BEQ.B B_5892C                                   ; 058929 F0 01 
  RTS                                             ; 05892B 60 

B_5892C:
  CLC                                             ; 05892C 18 
  LDA.B $1E                                       ; 05892D A5 1E 
  ADC.B #$42                                      ; 05892F 69 42 
  TAX                                             ; 058931 AA 
  LDA.W EntityTypeId,X                                   ; 058932 BD 44 07 
  CMP.B #$36                                      ; 058935 C9 36 
  BNE.B B_58964                                   ; 058937 D0 2B 

.byte $38,$A9,$00,$FD,$0C,$09,$9D,$0C             ; 058939 ........ 8???????
.byte $09,$A9,$00,$FD,$7E,$09,$9D,$7E             ; 058941 ........ ????~??~
.byte $09,$38,$A9,$00,$FD,$F0,$09,$9D             ; 058949 ........ ?8??????
.byte $F0,$09,$A9,$00,$FD,$62,$0A,$9D             ; 058951 ........ ?????b??
.byte $62,$0A,$A9,$37,$9D,$44,$07,$CE             ; 058959 ........ b??7?D??
.byte $D1,$05,$60                                 ; 058962 ...      ??`

B_58964:
  CMP.B #$38                                      ; 058964 C9 38 
  BNE.B B_58978                                   ; 058966 D0 10 
  LDA.B #$10                                      ; 058968 A9 10 
  STA.W EntityTypeId,X                                   ; 05896A 9D 44 07 
  LDA.B #$FF                                      ; 05896D A9 FF 
  STA.W PlayerOrbStatus                                     ; 05896F 8D CE 05 
  LDA.B #$00                                      ; 058972 A9 00 
  STA.W EntityV3,X                                   ; 058974 9D 28 08 
  RTS                                             ; 058977 60 

B_58978:
  CMP.B #$35                                      ; 058978 C9 35 
  BNE.B B_58982                                   ; 05897A D0 06 
  LDA.B #$01                                      ; 05897C A9 01 
  STA.W EntityV15,X                                   ; 05897E 9D 80 0D 
  RTS                                             ; 058981 60 

B_58982:
  CMP.B #$39                                      ; 058982 C9 39 
  BNE.B B_5898C                                   ; 058984 D0 06 

.byte $A9,$00,$9D,$28,$08,$60                     ; 058987 ......   ???(?`

B_5898C:
  STZ.W EntityHeader,X                                   ; 05898C 9E D2 06 
  PHX                                             ; 05898F DA 
  LDY.W EntityV31,X                                   ; 058990 BC A0 14 
  JSL L_AEF1                                      ; 058993 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 058997 BD A0 14 
  TAX                                             ; 05899A AA 
  STZ.W $175E,X                                   ; 05899B 9E 5E 17 
  ASL                                             ; 05899E 0A 
  ASL                                             ; 05899F 0A 
  TAY                                             ; 0589A0 A8 
  LDA.B #$F0                                      ; 0589A1 A9 F0 
  BCC.B B_589AA                                   ; 0589A3 90 05 
  STA.W $0409,Y                                   ; 0589A5 99 09 04 
  BRA.B B_589AD                                   ; 0589A8 80 03 

B_589AA:
.byte $99,$09,$03                                 ; 0589AB ...      ???

B_589AD:
  PLX                                             ; 0589AD FA 
  RTS                                             ; 0589AE 60 


L_589AF:
  LDA.W $1872                                     ; 0589AF AD 72 18 
  BNE.B B_58A14                                   ; 0589B2 D0 60 
  CLC                                             ; 0589B4 18 
  LDA.B $1E                                       ; 0589B5 A5 1E 
  ADC.B #$42                                      ; 0589B7 69 42 
  TAX                                             ; 0589B9 AA 
  LDA.W EntityTypeId,X                                   ; 0589BA BD 44 07 
  CMP.B #$36                                      ; 0589BD C9 36 
  BNE.B B_589CA                                   ; 0589BF D0 09 

.byte $A9,$37,$9D,$44,$07,$CE,$D1,$05             ; 0589C1 ........ ?7?D????
.byte $60                                         ; 0589CA .        `

B_589CA:
  CMP.B #$38                                      ; 0589CA C9 38 
  BNE.B B_589DE                                   ; 0589CC D0 10 

.byte $A9,$10,$9D,$44,$07,$A9,$FF,$8D             ; 0589CE ........ ???D????
.byte $CE,$05,$A9,$00,$9D,$28,$08,$60             ; 0589D6 ........ ?????(?`

B_589DE:
  CMP.B #$35                                      ; 0589DE C9 35 
  BNE.B B_589E8                                   ; 0589E0 D0 06 
  LDA.B #$01                                      ; 0589E2 A9 01 
  STA.W EntityV15,X                                   ; 0589E4 9D 80 0D 
  RTS                                             ; 0589E7 60 

B_589E8:
  CMP.B #$39                                      ; 0589E8 C9 39 
  BNE.B B_589F2                                   ; 0589EA D0 06 

.byte $A9,$00,$9D,$28,$08,$60                     ; 0589ED ......   ???(?`

B_589F2:
  STZ.W EntityHeader,X                                   ; 0589F2 9E D2 06 
  PHX                                             ; 0589F5 DA 
  LDY.W EntityV31,X                                   ; 0589F6 BC A0 14 
  JSL L_AEF1                                      ; 0589F9 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 0589FD BD A0 14 
  TAX                                             ; 058A00 AA 
  STZ.W $175E,X                                   ; 058A01 9E 5E 17 
  ASL                                             ; 058A04 0A 
  ASL                                             ; 058A05 0A 
  TAY                                             ; 058A06 A8 
  LDA.B #$F0                                      ; 058A07 A9 F0 
  BCC.B B_58A10                                   ; 058A09 90 05 
  STA.W $0409,Y                                   ; 058A0B 99 09 04 
  BRA.B B_58A13                                   ; 058A0E 80 03 

B_58A10:
.byte $99,$09,$03                                 ; 058A11 ...      ???

B_58A13:
  PLX                                             ; 058A13 FA 
B_58A14:
  RTS                                             ; 058A14 60 


L_58A15:
  LDA.W $1872                                     ; 058A15 AD 72 18 
  BEQ.B B_58A1D                                   ; 058A18 F0 03 
  JMP.W D_58AE4                                   ; 058A1A 4C E4 8A 
B_58A1D:
  CLC                                             ; 058A1D 18 
  LDA.B $1E                                       ; 058A1E A5 1E 
  ADC.B #$42                                      ; 058A20 69 42 
  TAX                                             ; 058A22 AA 
  LDA.W EntityTypeId,X                                   ; 058A23 BD 44 07 
  CMP.B #$33                                      ; 058A26 C9 33 
  BNE.B B_58A2E                                   ; 058A28 D0 04 
  JSR.W L_58CD0                                   ; 058A2A 20 D0 8C 
  RTS                                             ; 058A2D 60 

B_58A2E:
  CMP.B #$38                                      ; 058A2E C9 38 
  BNE.B B_58A42                                   ; 058A30 D0 10 

.byte $A9,$10,$9D,$44,$07,$A9,$FF,$8D             ; 058A32 ........ ???D????
.byte $CE,$05,$A9,$00,$9D,$28,$08,$60             ; 058A3A ........ ?????(?`

B_58A42:
  CMP.B #$32                                      ; 058A42 C9 32 
  BNE.B B_58A7D                                   ; 058A44 D0 37 
  LDA.B $D2                                       ; 058A46 A5 D2 
  AND.B #$01                                      ; 058A48 29 01 
  BNE.B B_58A7C                                   ; 058A4A D0 30 
  JSL AdvanceRNG                                     ; 058A4C 22 95 CA 0E 
  AND.B #$07                                      ; 058A50 29 07 
  TAY                                             ; 058A52 A8 
  LDA.W D_58AE5,Y                                 ; 058A53 B9 E5 8A 
  STA.W EntityV29,X                                   ; 058A56 9D BC 13 
  LDA.B #$32                                      ; 058A59 A9 32 
  ORA.W D_58AED,Y                                 ; 058A5B 19 ED 8A 
  STA.W EntityV30,X                                   ; 058A5E 9D 2E 14 
  TYA                                             ; 058A61 98 
  ASL                                             ; 058A62 0A 
  TAY                                             ; 058A63 A8 
  LDA.W D_58AF5,Y                                 ; 058A64 B9 F5 8A 
  STA.W EntityV5,X                                   ; 058A67 9D 0C 09 
  LDA.W D_58AF6,Y                                 ; 058A6A B9 F6 8A 
  STA.W EntityV6,X                                   ; 058A6D 9D 7E 09 
  LDA.W D_58B05,Y                                 ; 058A70 B9 05 8B 
  STA.W EntityV7,X                                   ; 058A73 9D F0 09 
  LDA.W D_58B06,Y                                 ; 058A76 B9 06 8B 
  STA.W EntityV8,X                                   ; 058A79 9D 62 0A 
B_58A7C:
  RTS                                             ; 058A7C 60 

B_58A7D:
  CMP.B #$35                                      ; 058A7D C9 35 
  BNE.B B_58A98                                   ; 058A7F D0 17 
  LDA.B #$01                                      ; 058A81 A9 01 
  STA.W EntityV15,X                                   ; 058A83 9D 80 0D 
  LDA.B #$00                                      ; 058A86 A9 00 
  STA.W EntityV3,X                                   ; 058A88 9D 28 08 
  STZ.W EntityV5,X                                   ; 058A8B 9E 0C 09 
  STZ.W EntityV6,X                                   ; 058A8E 9E 7E 09 
  STZ.W EntityV7,X                                   ; 058A91 9E F0 09 
  STZ.W EntityV8,X                                   ; 058A94 9E 62 0A 
  RTS                                             ; 058A97 60 

B_58A98:
  CMP.B #$39                                      ; 058A98 C9 39 
  BNE.B B_58AA2                                   ; 058A9A D0 06 
  LDA.B #$00                                      ; 058A9C A9 00 
  STA.W EntityV3,X                                   ; 058A9E 9D 28 08 
  RTS                                             ; 058AA1 60 

B_58AA2:
  CMP.B #$34                                      ; 058AA2 C9 34 
  BNE.B B_58AC2                                   ; 058AA4 D0 1C 
  LDA.B #$35                                      ; 058AA6 A9 35 
  STA.W EntityTypeId,X                                   ; 058AA8 9D 44 07 
  LDA.B #$01                                      ; 058AAB A9 01 
  STA.W EntityV15,X                                   ; 058AAD 9D 80 0D 
  LDA.B #$00                                      ; 058AB0 A9 00 
  STA.W EntityV3,X                                   ; 058AB2 9D 28 08 
  STZ.W EntityV5,X                                   ; 058AB5 9E 0C 09 
  STZ.W EntityV6,X                                   ; 058AB8 9E 7E 09 
  STZ.W EntityV7,X                                   ; 058ABB 9E F0 09 
  STZ.W EntityV8,X                                   ; 058ABE 9E 62 0A 
  RTS                                             ; 058AC1 60 

B_58AC2:
  STZ.W EntityHeader,X                                   ; 058AC2 9E D2 06 
  PHX                                             ; 058AC5 DA 
  LDY.W EntityV31,X                                   ; 058AC6 BC A0 14 
  JSL L_AEF1                                      ; 058AC9 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 058ACD BD A0 14 
  TAX                                             ; 058AD0 AA 
  STZ.W $175E,X                                   ; 058AD1 9E 5E 17 
  ASL                                             ; 058AD4 0A 
  ASL                                             ; 058AD5 0A 
  TAY                                             ; 058AD6 A8 
  LDA.B #$F0                                      ; 058AD7 A9 F0 
  BCC.B B_58AE0                                   ; 058AD9 90 05 
  STA.W $0409,Y                                   ; 058ADB 99 09 04 
  BRA.B B_58AE3                                   ; 058ADE 80 03 

B_58AE0:
.byte $99,$09,$03                                 ; 058AE1 ...      ???

B_58AE3:
  PLX                                             ; 058AE3 FA 
D_58AE4:
  RTS                                             ; 058AE4 60 


D_58AE5:
.byte $00,$02,$04,$02,$00,$02,$04,$02             ; 058AE5 DDDDDDDD ????????
D_58AED:
.byte $80,$80,$00,$00,$00,$40,$40,$C0             ; 058AED DDDDDDDD ?????@@?
D_58AF5:
.byte $00                                         ; 058AF6 D        ?
D_58AF6:
.byte $00,$89,$03,$00,$05,$89,$03,$00             ; 058AF6 DDDDDDDD ????????
.byte $00,$77,$FC,$00,$FB,$77,$FC                 ; 058AFF DDDDDDD  ?w???w?
D_58B05:
.byte $00                                         ; 058B06 D        ?
D_58B06:
.byte $05,$89,$03,$00,$00,$77,$FC,$00             ; 058B06 DDDDDDDD ?????w??
.byte $FB,$77,$FC,$00,$00,$89,$03,$AD             ; 058B0E DDDDDDD. ?w??????
.byte $72,$18,$D0,$75,$18,$A5,$1E,$69             ; 058B16 ........ r??u???i
.byte $42,$AA,$BD,$44,$07,$C9,$33,$F0             ; 058B1E ........ B??D??3?
.byte $0C,$C9,$32,$F0,$08,$C9,$34,$F0             ; 058B26 ........ ??2???4?
.byte $04,$C9,$35,$D0,$1C,$A9,$35,$9D             ; 058B2E ........ ??5???5?
.byte $44,$07,$A9,$01,$9D,$80,$0D,$A9             ; 058B36 ........ D???????
.byte $00,$9D,$28,$08,$9E,$0C,$09,$9E             ; 058B3E ........ ??(?????
.byte $7E,$09,$9E,$F0,$09,$9E,$62,$0A             ; 058B46 ........ ~?????b?
.byte $60,$C9,$39,$D0,$06,$A9,$00,$9D             ; 058B4E ........ `?9?????
.byte $28,$08,$60,$C9,$38,$D0,$10,$A9             ; 058B56 ........ (?`?8???
.byte $10,$9D,$44,$07,$A9,$FF,$8D,$CE             ; 058B5E ........ ??D?????
.byte $05,$A9,$00,$9D,$28,$08,$60,$9E             ; 058B66 ........ ????(?`?
.byte $D2,$06                                     ; 058B6F ..       ??
D_58B70:
.byte $DA,$BC,$A0,$14,$22,$F1,$AE,$00             ; 058B70 ........ ????"???
.byte $BD,$A0,$14,$AA,$9E,$5E,$17,$0A             ; 058B78 ........ ?????^??
.byte $0A,$A8,$A9,$F0,$90,$05,$99,$09             ; 058B80 ........ ????????
.byte $04,$80                                     ; 058B89 ..       ??
D_58B8A:
.byte $03,$99,$09,$03,$FA,$60                     ; 058B8B ......   ?????`


L_58B90:
  LDA.W $1872                                     ; 058B90 AD 72 18 
  BNE.B B_58B9F                                   ; 058B93 D0 0A 
  LDY.B $1E                                       ; 058B95 A4 1E 
  LDA.W EntityTypeId+Projectiles,Y                                   ; 058B97 B9 86 07 
  TAY                                             ; 058B9A A8 
  LDA.W D_58B70,Y                                 ; 058B9B B9 70 8B 
  RTS                                             ; 058B9E 60 

B_58B9F:
  LDA.B #$80                                      ; 058B9F A9 80 
  RTS                                             ; 058BA1 60 


.byte $01,$01                                     ; 058BA3 DD       ??
D_58BA4:
.byte $08,$02,$01,$01,$00,$08                     ; 058BA5 DDD.D.   ??????


L_58BAA:
  LDA.W $1872                                     ; 058BAA AD 72 18 
  BNE.B B_58BB9                                   ; 058BAD D0 0A 
  LDY.B $1E                                       ; 058BAF A4 1E 
  LDA.W EntityTypeId+Projectiles,Y                                   ; 058BB1 B9 86 07 
  TAY                                             ; 058BB4 A8 
  LDA.W D_58B8A,Y                                 ; 058BB5 B9 8A 8B 
  RTS                                             ; 058BB8 60 

B_58BB9:
  LDA.B #$80                                      ; 058BB9 A9 80 
  RTS                                             ; 058BBB 60 


.byte $01,$01,$08,$02,$08,$00,$00,$08             ; 058BBC DDDDD... ????????


L_58BC4:
  LDA.W $1872                                     ; 058BC4 AD 72 18 
  BNE.B B_58BD3                                   ; 058BC7 D0 0A 
  LDY.B $1E                                       ; 058BC9 A4 1E 
  LDA.W EntityTypeId+Projectiles,Y                                   ; 058BCB B9 86 07 
  TAY                                             ; 058BCE A8 
  LDA.W D_58BA4,Y                                 ; 058BCF B9 A4 8B 
  RTS                                             ; 058BD2 60 

B_58BD3:
  LDA.B #$00                                      ; 058BD3 A9 00 
  RTS                                             ; 058BD5 60 


.byte $00,$01,$03,$02,$00,$00,$00,$04             ; 058BD6 DDDD...D ????????
.byte $AD,$72,$18,$D0,$0A,$A4,$1E,$B9             ; 058BDE ........ ?r??????
.byte $86,$07,$A8,$B9,$BE,$8B,$60,$A9             ; 058BE6 ........ ??????`?
.byte $00,$60,$01,$01,$02,$02,$00,$00             ; 058BEE ........ ?`??????
.byte $00,$03,$AD,$72,$18,$D0,$0A,$A4             ; 058BF6 ........ ???r????
.byte $1E,$B9,$86,$07,$A8,$B9,$D8,$8B             ; 058BFE ........ ????????
.byte $60,$A9,$00,$60,$00,$00,$00,$00             ; 058C06 ........ `??`????
.byte $00,$00,$00,$03,$AD,$72,$18,$D0             ; 058C0E ........ ?????r??
.byte $1E,$A4,$1E,$B9,$FC,$0F,$EB,$B9             ; 058C16 ........ ????????
.byte $86,$07,$A8,$B9,$0E,$8C,$85,$A8             ; 058C1E ........ ????????
.byte $64,$A7,$64,$A9,$5A,$EB,$22,$6D             ; 058C26 ........ d?d?Z?"m
.byte $E4,$00,$7A,$B9,$06,$8C,$60,$A9             ; 058C2E ........ ??z???`?
.byte $00,$60,$01,$01,$03,$02,$01,$01             ; 058C36 ........ ?`??????
.byte $00,$04,$01,$02,$05,$03,$00,$00             ; 058C3E ........ ????????
.byte $00,$00,$A9,$13,$9D,$44,$07,$A9             ; 058C46 ........ ?????D??
.byte $00,$9D,$28,$08,$A9,$80,$9D,$BC             ; 058C4E ........ ??(?????
.byte $13,$22,$95,$CA,$0E,$29,$03,$A8             ; 058C56 ........ ?"???)??
.byte $B9,$AC,$8C,$1D,$2E,$14,$9D,$2E             ; 058C5E ........ ????.??.
.byte $14,$9E,$0C,$09,$9E,$7E,$09,$9E             ; 058C66 ........ ?????~??
.byte $F0,$09,$9E,$62,$0A,$A9,$05,$9D             ; 058C6E ........ ???b????
.byte $4A,$13,$9E,$D8,$12,$A4,$1E,$B9             ; 058C76 ........ J???????
.byte $6E,$10,$0A,$A8,$B9,$B0,$8C,$9D             ; 058C7E ........ n???????
.byte $0C,$09,$B9,$B1,$8C,$9D,$7E,$09             ; 058C86 ........ ??????~?
.byte $B9,$C0,$8C,$9D,$F0,$09,$B9,$C1             ; 058C8E ........ ????????
.byte $8C,$9D,$62,$0A,$DA,$C2,$10,$E2             ; 058C96 ........ ??b?????
.byte $20,$A9,$07,$A2,$05,$FF,$22,$0F             ; 058C9E ........  ?????"?
.byte $83,$0F,$E2,$30,$FA,$60,$00,$40             ; 058CA6 ........ ???0?`?@
.byte $80,$C0,$00,$00,$80,$00,$80,$00             ; 058CAE ........ ????????
.byte $80,$00,$00,$00,$80,$FF,$80,$FF             ; 058CB6 ........ ????????
.byte $80,$FF,$80,$00,$80,$00,$00,$00             ; 058CBE ........ ????????
.byte $80,$FF,$80,$FF,$80,$FF,$00,$00             ; 058CC6 ........ ????????
.byte $80,$00                                     ; 058CCF ..       ??


L_58CD0:
  LDA.B #$1C                                      ; 058CD0 A9 1C 
  STA.W EntityTypeId,X                                   ; 058CD2 9D 44 07 
  LDA.B #$00                                      ; 058CD5 A9 00 
  STA.W EntityV3,X                                   ; 058CD7 9D 28 08 
  LDA.B #$20                                      ; 058CDA A9 20 
  STA.W EntityV29,X                                   ; 058CDC 9D BC 13 
  LDA.B #$32                                      ; 058CDF A9 32 
  STA.W EntityV30,X                                   ; 058CE1 9D 2E 14 
  LDA.B #$04                                      ; 058CE4 A9 04 
  STA.W EntityV28,X                                   ; 058CE6 9D 4A 13 
  STZ.W EntityV27,X                                   ; 058CE9 9E D8 12 
  RTS                                             ; 058CEC 60 


L_58CED:
  LDA.B #$09                                      ; 058CED A9 09 
  STA.W EntityTypeId,X                                   ; 058CEF 9D 44 07 
  LDA.B #$00                                      ; 058CF2 A9 00 
  STA.W EntityV3,X                                   ; 058CF4 9D 28 08 
  LDA.B #$20                                      ; 058CF7 A9 20 
  STA.W EntityV29,X                                   ; 058CF9 9D BC 13 
  LDA.B #$32                                      ; 058CFC A9 32 
  STA.W EntityV30,X                                   ; 058CFE 9D 2E 14 
  STZ.W EntityV5,X                                   ; 058D01 9E 0C 09 
  STZ.W EntityV6,X                                   ; 058D04 9E 7E 09 
  STZ.W EntityV7,X                                   ; 058D07 9E F0 09 
  STZ.W EntityV8,X                                   ; 058D0A 9E 62 0A 
  LDA.B #$04                                      ; 058D0D A9 04 
  STA.W EntityV28,X                                   ; 058D0F 9D 4A 13 
  STZ.W EntityV27,X                                   ; 058D12 9E D8 12 
  PHX                                             ; 058D15 DA 
  REP.B #P_Idx8Bit                                      ; 058D16 C2 10 
  LDA.B #$07                                      ; 058D18 A9 07 
  LDX.W #$FF06                                    ; 058D1A A2 06 FF 
  JSL Audio_F830F                                     ; 058D1D 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 058D21 E2 30 
  PLX                                             ; 058D23 FA 
  RTS                                             ; 058D24 60 


L_58D25:
  LDA.B #$06                                      ; 058D25 A9 06 
  STA.W EntityTypeId,X                                   ; 058D27 9D 44 07 
  LDA.B #$00                                      ; 058D2A A9 00 
  STA.W EntityV3,X                                   ; 058D2C 9D 28 08 
  LDA.B #$20                                      ; 058D2F A9 20 
  STA.W EntityV29,X                                   ; 058D31 9D BC 13 
  LDA.B #$32                                      ; 058D34 A9 32 
  STA.W EntityV30,X                                   ; 058D36 9D 2E 14 
  STZ.W EntityV5,X                                   ; 058D39 9E 0C 09 
  STZ.W EntityV6,X                                   ; 058D3C 9E 7E 09 
  STZ.W EntityV7,X                                   ; 058D3F 9E F0 09 
  STZ.W EntityV8,X                                   ; 058D42 9E 62 0A 
  LDA.B #$04                                      ; 058D45 A9 04 
  STA.W EntityV28,X                                   ; 058D47 9D 4A 13 
  STZ.W EntityV27,X                                   ; 058D4A 9E D8 12 
  PHX                                             ; 058D4D DA 
  REP.B #P_Idx8Bit                                      ; 058D4E C2 10 
  LDA.B #$07                                      ; 058D50 A9 07 
  LDX.W #$FF06                                    ; 058D52 A2 06 FF 
  JSL Audio_F830F                                     ; 058D55 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 058D59 E2 30 
  PLX                                             ; 058D5B FA 
  RTS                                             ; 058D5C 60 


L_58D5D:
  LDA.B #$08                                      ; 058D5D A9 08 
  STA.W EntityTypeId,X                                   ; 058D5F 9D 44 07 
  LDA.B #$00                                      ; 058D62 A9 00 
  STA.W EntityV3,X                                   ; 058D64 9D 28 08 
  LDA.B #$40                                      ; 058D67 A9 40 
  STA.W EntityV29,X                                   ; 058D69 9D BC 13 
  LDA.B #$32                                      ; 058D6C A9 32 
  STA.W EntityV30,X                                   ; 058D6E 9D 2E 14 
  STZ.W EntityV5,X                                   ; 058D71 9E 0C 09 
  STZ.W EntityV6,X                                   ; 058D74 9E 7E 09 
  STZ.W EntityV7,X                                   ; 058D77 9E F0 09 
  STZ.W EntityV8,X                                   ; 058D7A 9E 62 0A 
  LDA.B #$04                                      ; 058D7D A9 04 
  STA.W EntityV28,X                                   ; 058D7F 9D 4A 13 
  STZ.W EntityV27,X                                   ; 058D82 9E D8 12 
  PHX                                             ; 058D85 DA 
  REP.B #P_Idx8Bit                                      ; 058D86 C2 10 
  LDA.B #$07                                      ; 058D88 A9 07 
  LDX.W #$FF06                                    ; 058D8A A2 06 FF 
  JSL Audio_F830F                                     ; 058D8D 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 058D91 E2 30 
  PLX                                             ; 058D93 FA 
  RTS                                             ; 058D94 60 


.byte $A9,$12,$9D,$44,$07,$A9,$00,$9D             ; 058D95 ........ ???D????
.byte $28,$08,$A9,$A0,$9D,$BC,$13,$A9             ; 058D9D ........ (???????
.byte $32,$9D,$2E,$14,$9E,$0C,$09,$9E             ; 058DA5 ........ 2?.?????
.byte $7E,$09,$9E,$F0,$09,$9E,$62,$0A             ; 058DAD ........ ~?????b?
.byte $A9,$04,$9D,$4A,$13,$9E,$D8,$12             ; 058DB5 ........ ???J????
.byte $60                                         ; 058DBE .        `


L_58DBE:
  LDA.B #$02                                      ; 058DBE A9 02 
  STA.W EntityTypeId,X                                   ; 058DC0 9D 44 07 
  LDA.B #$00                                      ; 058DC3 A9 00 
  STA.W EntityV3,X                                   ; 058DC5 9D 28 08 
  LDA.B #$60                                      ; 058DC8 A9 60 
  STA.W EntityV29,X                                   ; 058DCA 9D BC 13 
  LDA.B #$32                                      ; 058DCD A9 32 
  STA.W EntityV30,X                                   ; 058DCF 9D 2E 14 
  LDY.B $1E                                       ; 058DD2 A4 1E 
  LDA.W EntityV21+Projectiles,Y                                   ; 058DD4 B9 6E 10 
  ASL                                             ; 058DD7 0A 
  TAY                                             ; 058DD8 A8 
  LDA.W D_58E09,Y                                 ; 058DD9 B9 09 8E 
  STA.W EntityV5,X                                   ; 058DDC 9D 0C 09 
  LDA.W D_58E0A,Y                                 ; 058DDF B9 0A 8E 
  STA.W EntityV6,X                                   ; 058DE2 9D 7E 09 
  LDA.W D_58E19,Y                                 ; 058DE5 B9 19 8E 
  STA.W EntityV7,X                                   ; 058DE8 9D F0 09 
  LDA.W D_58E1A,Y                                 ; 058DEB B9 1A 8E 
  STA.W EntityV8,X                                   ; 058DEE 9D 62 0A 
  LDA.B #$04                                      ; 058DF1 A9 04 
  STA.W EntityV28,X                                   ; 058DF3 9D 4A 13 
  STZ.W EntityV27,X                                   ; 058DF6 9E D8 12 
  PHX                                             ; 058DF9 DA 
  REP.B #P_Idx8Bit                                      ; 058DFA C2 10 
  LDA.B #$07                                      ; 058DFC A9 07 
  LDX.W #$FF06                                    ; 058DFE A2 06 FF 
  JSL Audio_F830F                                     ; 058E01 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 058E05 E2 30 
  PLX                                             ; 058E07 FA 
  RTS                                             ; 058E08 60 


D_58E09:
.byte $00                                         ; 058E0A D        ?
D_58E0A:
.byte $00,$40,$00,$40,$00,$40,$00,$00             ; 058E0A DDDDDDDD ?@?@?@??
.byte $00,$C0,$FF,$C0,$FF,$C0,$FF                 ; 058E13 DDDDDDD  ???????
D_58E19:
.byte $40                                         ; 058E1A D        @
D_58E1A:
.byte $00,$40,$00,$00,$00,$C0,$FF,$C0             ; 058E1A DDDDDDDD ?@??????
.byte $FF,$C0,$FF,$00,$00,$40,$00                 ; 058E23 DDDDDDD  ?????@?


; --------------------------------------------------------------------------- ;
; An enemy has been hit by a player weapon
; 
;  X = Entity that was hit.
EnemyHitByProjectile:
  txa
  clc
  ; for some reason i guess we're off by 2, because of player entity?
  adc #$02
  tax
  ldy EntityTypeId,X
  ; find the handler for the entity type
  lda EnemyHitByProjectileRoutinesLo,Y
  sta $04
  lda EnemyHitByProjectileRoutinesHi,Y
  sta $05
  ; and invoke it
  jmp ($0004)

; --------------------------------------------------------------------------- ;
; Interaction between player and another entity on the game map.
; 
;  X = Entity that was hit.
PlayerHitEntity:
  txa
  clc
  ; for some reason i guess we're off by 2, because of player entity?
  adc #2
  tax
  ldy EntityTypeId,X
  ; find the handler for the entity type
  lda PlayerHitEntityRoutinesLo,Y
  sta $04
  lda PlayerHitEntityRoutinesHi,Y
  sta $05
  ; and invoke it
  jmp ($0004)


EnemyHitByProjectileRoutinesLo:
.byte <$90FB,<$90FD,<$90FF,<$9101,<$9103,<$9105,<$9107,<$9109
.byte <$910B,<$910D,<$910F,<$9111,<$9113,<$9115,<$9117,<$9119
.byte <$911B,<$911D,<$911F,<$9121,<$9123,<$9125,<$9125,<$9125
.byte <$91D7,<$91D9,<$923D,<$923F,<$92B0,<$92B2,<$92B4,<$939B
.byte <$9428,<$94D6,<$94D8,<$94D8,<$94D8,<$94D8,<$94D8,<$95A1
.byte <$95AE,<$9641,<$9705,<$9125,<$97AF,<$97AF,<$97AF,<$97AF
.byte <$97AF,<$9861,<$988A,<$988C,<$988E,<$9890,<$9892,<$9894
.byte <$9896,<$9898,<$989A,<$989C,<$989E,<$9909,<$9974,<$9A1B
.byte <$9AD4,<$9B24,<$9C28,<$9CBD,<$9D23,<$9D7E,<$9DF3,<$9E78
.byte <$9F2F,<$9F31,<$9F33,<$923F,<$9F35,<$9FAE,<$9FB0,<$94D8
.byte <$A004,<$A006,<$A006,<$A068,<$A06A,<$A0F5,<$A158,<$A18C
.byte <$A18E,<$A205,<$A207,<$A209,<$A209,<$A209,<$A209,<$A209
.byte <$A2C7,<$A2C9,<$A2CB,<$A2CD,<$A302,<$A385,<$A3CE,<$A41C
.byte <$A41E,<$A420,<$A42E,<$A435,<$A437,<$A439,<$A4BB,<$A4BD
.byte <$A4BF,<$A4C1,<$A4C3,<$A4C5,<$A4F5,<$A4C5,<$A525,<$A527
.byte <$A52E,<$A52E,<$A52E,<$A52E,<$A52E,<$A52E,<$A5BE,<$A5BF
.byte <$A5C0,<$A5C2,<$A4C5,<$A4F5,<$A4F5,<$A4C5,<$A4F5,<$A5C4
.byte <$A5C6,<$A5C8,<$A5CA,<$A5CC,<$A5CE,<$A5CE,<$A675,<$A682
.byte <$A684,<$A684,<$A684,<$A713,<$A715,<$A717,<$A719,<$A7D7
.byte <$A7D9,<$A7DB,<$A719,<$A7DD,<$A7DF,<$A7E1,<$A91B,<$A91D
.byte <$AA5E,<$AA60,<$AA62,<$AA64,<$AA66,<$AA68,<$AA6A,<$AA99
.byte <$AAC2,<$AAC4

EnemyHitByProjectileRoutinesHi:
.byte >$90FB,>$90FD,>$90FF,>$9101,>$9103,>$9105,>$9107,>$9109
.byte >$910B,>$910D,>$910F,>$9111,>$9113,>$9115,>$9117,>$9119
.byte >$911B,>$911D,>$911F,>$9121,>$9123,>$9125,>$9125,>$9125
.byte >$91D7,>$91D9,>$923D,>$923F,>$92B0,>$92B2,>$92B4,>$939B
.byte >$9428,>$94D6,>$94D8,>$94D8,>$94D8,>$94D8,>$94D8,>$95A1
.byte >$95AE,>$9641,>$9705,>$9125,>$97AF,>$97AF,>$97AF,>$97AF
.byte >$97AF,>$9861,>$988A,>$988C,>$988E,>$9890,>$9892,>$9894
.byte >$9896,>$9898,>$989A,>$989C,>$989E,>$9909,>$9974,>$9A1B
.byte >$9AD4,>$9B24,>$9C28,>$9CBD,>$9D23,>$9D7E,>$9DF3,>$9E78
.byte >$9F2F,>$9F31,>$9F33,>$923F,>$9F35,>$9FAE,>$9FB0,>$94D8
.byte >$A004,>$A006,>$A006,>$A068,>$A06A,>$A0F5,>$A158,>$A18C
.byte >$A18E,>$A205,>$A207,>$A209,>$A209,>$A209,>$A209,>$A209
.byte >$A2C7,>$A2C9,>$A2CB,>$A2CD,>$A302,>$A385,>$A3CE,>$A41C
.byte >$A41E,>$A420,>$A42E,>$A435,>$A437,>$A439,>$A4BB,>$A4BD
.byte >$A4BF,>$A4C1,>$A4C3,>$A4C5,>$A4F5,>$A4C5,>$A525,>$A527
.byte >$A52E,>$A52E,>$A52E,>$A52E,>$A52E,>$A52E,>$A5BE,>$A5BF
.byte >$A5C0,>$A5C2,>$A4C5,>$A4F5,>$A4F5,>$A4C5,>$A4F5,>$A5C4
.byte >$A5C6,>$A5C8,>$A5CA,>$A5CC,>$A5CE,>$A5CE,>$A675,>$A682
.byte >$A684,>$A684,>$A684,>$A713,>$A715,>$A717,>$A719,>$A7D7
.byte >$A7D9,>$A7DB,>$A719,>$A7DD,>$A7DF,>$A7E1,>$A91B,>$A91D
.byte >$AA5E,>$AA60,>$AA62,>$AA64,>$AA66,>$AA68,>$AA6A,>$AA99
.byte >$AAC2,>$AAC4  

PlayerHitEntityRoutinesLo:
.byte <$90FC,<$90FE,<$9100,<$9102,<$9104,<$9106,<$9108,<$910A
.byte <$910C,<$910E,<$9110,<$9112,<$9114,<$9116,<$9118,<$911A
.byte <$911C,<$911E,<$9120,<$9122,<$9124,<$9190,<$9190,<$91AC
.byte <$91D8,<$9231,<$923E,<$92A4,<$92B1,<$92B3,<$938F,<$941C
.byte <$94CA,<$94D7,<$9595,<$9595,<$9595,<$9595,<$9595,<$95A2
.byte <$9635,<$96F9,<$97A3,<$9190,<$9855,<$9855,<$9855,<$9855
.byte <$9855,<$987E,<$988B,<$988D,<$988F,<$9891,<$9893,<$9895
.byte <$9897,<$9899,<$989B,<$989D,<$98A4,<$990F,<$997A,<$9A21
.byte <$9ADA,<$9B2A,<$9C2E,<$9CC3,<$9D29,<$9D84,<$9DF9,<$9E7E
.byte <$9F30,<$9F32,<$9F34,<$92A4,<$9F3B,<$9FAF,<$9FF1,<$9595
.byte <$A005,<$A05C,<$A05C,<$A069,<$A0E9,<$A0E9,<$A0E9,<$A18D
.byte <$A194,<$A206,<$A208,<$A274,<$A274,<$A29C,<$A29C,<$A274
.byte <$A2C8,<$A2CA,<$A2CC,<$A2CE,<$A378,<$A3C8,<$A40F,<$A41D
.byte <$A41F,<$A421,<$A42F,<$A436,<$A438,<$A43A,<$A4BC,<$A4BE
.byte <$A4C0,<$A4C2,<$A4C4,<$A4F4,<$A524,<$A4F4,<$A526,<$A528
.byte <$A5B8,<$A5B8,<$A5B8,<$A5B8,<$A5B8,<$A5B8,<$A5B8,<$A5B8
.byte <$A5C1,<$A5C3,<$A4F4,<$A524,<$A524,<$A4F4,<$A524,<$A5C5
.byte <$A5C7,<$A5C9,<$A5CB,<$A5CD,<$A66F,<$A66F,<$A679,<$A683
.byte <$A70D,<$A70D,<$A70D,<$A714,<$A716,<$A718,<$A7D6,<$A7D8
.byte <$A7DA,<$A7DC,<$A7D6,<$A7DE,<$A7E0,<$A90F,<$A91C,<$AA52
.byte <$AA5F,<$AA61,<$AA63,<$AA65,<$AA67,<$AA69,<$AA8A,<$AAB6
.byte <$AAC3,<$AAE1

PlayerHitEntityRoutinesHi:
.byte >$90FC,>$90FE,>$9100,>$9102,>$9104,>$9106,>$9108,>$910A
.byte >$910C,>$910E,>$9110,>$9112,>$9114,>$9116,>$9118,>$911A
.byte >$911C,>$911E,>$9120,>$9122,>$9124,>$9190,>$9190,>$91AC
.byte >$91D8,>$9231,>$923E,>$92A4,>$92B1,>$92B3,>$938F,>$941C
.byte >$94CA,>$94D7,>$9595,>$9595,>$9595,>$9595,>$9595,>$95A2
.byte >$9635,>$96F9,>$97A3,>$9190,>$9855,>$9855,>$9855,>$9855
.byte >$9855,>$987E,>$988B,>$988D,>$988F,>$9891,>$9893,>$9895
.byte >$9897,>$9899,>$989B,>$989D,>$98A4,>$990F,>$997A,>$9A21
.byte >$9ADA,>$9B2A,>$9C2E,>$9CC3,>$9D29,>$9D84,>$9DF9,>$9E7E
.byte >$9F30,>$9F32,>$9F34,>$92A4,>$9F3B,>$9FAF,>$9FF1,>$9595
.byte >$A005,>$A05C,>$A05C,>$A069,>$A0E9,>$A0E9,>$A0E9,>$A18D
.byte >$A194,>$A206,>$A208,>$A274,>$A274,>$A29C,>$A29C,>$A274
.byte >$A2C8,>$A2CA,>$A2CC,>$A2CE,>$A378,>$A3C8,>$A40F,>$A41D
.byte >$A41F,>$A421,>$A42F,>$A436,>$A438,>$A43A,>$A4BC,>$A4BE
.byte >$A4C0,>$A4C2,>$A4C4,>$A4F4,>$A524,>$A4F4,>$A526,>$A528
.byte >$A5B8,>$A5B8,>$A5B8,>$A5B8,>$A5B8,>$A5B8,>$A5B8,>$A5B8
.byte >$A5C1,>$A5C3,>$A4F4,>$A524,>$A524,>$A4F4,>$A524,>$A5C5
.byte >$A5C7,>$A5C9,>$A5CB,>$A5CD,>$A66F,>$A66F,>$A679,>$A683
.byte >$A70D,>$A70D,>$A70D,>$A714,>$A716,>$A718,>$A7D6,>$A7D8
.byte >$A7DA,>$A7DC,>$A7D6,>$A7DE,>$A7E0,>$A90F,>$A91C,>$AA52
.byte >$AA5F,>$AA61,>$AA63,>$AA65,>$AA67,>$AA69,>$AA8A,>$AAB6
.byte >$AAC3,>$AAE1


.byte $60,$60,$60,$60

  RTS


.byte $60,$60,$60

  RTS


.byte $60,$60,$60,$60,$60,$60,$60,$60
.byte $60,$60,$60,$60,$60,$60,$60,$60
.byte $60,$60,$60,$60,$60,$60,$60,$60
.byte $60,$60,$60,$60,$60,$60,$60,$60
.byte $60

  JSR.W L_58B90                                   ; 059125 20 90 8B 
  BEQ.B B_59179                                   ; 059128 F0 4F 
  STZ.B $41,X                                     ; 05912A 74 41 
  DEC.W $18E4                                     ; 05912C CE E4 18 
  DEC.W $06C6                                     ; 05912F CE C6 06 
  PHX                                             ; 059132 DA 
  LDA.W EntityV22,X                                   ; 059133 BD 9E 10 
  BEQ.B B_59148                                   ; 059136 F0 10 
  LDX.W $18D4                                     ; 059138 AE D4 18 
  DEC.W $18C5,X                                   ; 05913B DE C5 18 
  BNE.B B_59156                                   ; 05913E D0 16 
  STZ.W $18C9,X                                   ; 059140 9E C9 18 
  STZ.W $18C1,X                                   ; 059143 9E C1 18 
  BRA.B B_59156                                   ; 059146 80 0E 
B_59148:
  LDX.W $18D3                                     ; 059148 AE D3 18 
  DEC.W $18C5,X                                   ; 05914B DE C5 18 
  BNE.B B_59156                                   ; 05914E D0 06 
  STZ.W $18C9,X                                   ; 059150 9E C9 18 
  STZ.W $18C1,X                                   ; 059153 9E C1 18 
B_59156:
  PLX                                             ; 059156 FA 
  STZ.B $A7                                       ; 059157 64 A7 
  LDA.B #$05                                      ; 059159 A9 05 
  STA.B $A8                                       ; 05915B 85 A8 
  STZ.B $A9                                       ; 05915D 64 A9 
  LDA.W $1872                                     ; 05915F AD 72 18 
  BNE.B B_5917D                                   ; 059162 D0 19 
  LDY.B $1E                                       ; 059164 A4 1E 
  LDA.W EntityV20+Projectiles,Y                                   ; 059166 B9 FC 0F 
  JSL IncreasePlayerScore                                      ; 059169 22 6D E4 00 
  LDA.W EntityTypeId+Projectiles,Y                                   ; 05916D B9 86 07 
  TAY                                             ; 059170 A8 
  LDA.W D_5918B-$32,Y                                 ; 059171 B9 58 91 
  BNE.B B_59183                                   ; 059174 D0 0D 
  JSR.W L_58DBE                                   ; 059176 20 BE 8D 
B_59179:
  JSR.W L_588AD                                   ; 059179 20 AD 88 
  RTS                                             ; 05917C 60 

B_5917D:
  LDA.B $1E                                       ; 05917D A5 1E 
  JSL IncreasePlayerScore                                      ; 05917F 22 6D E4 00 
B_59183:
  JSR.W L_58CED                                   ; 059183 20 ED 8C 
  JSR.W L_588AD                                   ; 059186 20 AD 88 
  RTS                                             ; 059189 60 

D_5918B:
.byte $00,$00,$01,$01,$00,$00                     ; 05918B DDDDD.   ??????

  STZ.W EntityV5,X                                   ; 059190 9E 0C 09 
  STZ.W EntityV6,X                                   ; 059193 9E 7E 09 
  STZ.W EntityV7,X                                   ; 059196 9E F0 09 
  STZ.W EntityV8,X                                   ; 059199 9E 62 0A 
  LDA.B #$01                                      ; 05919C A9 01 
  STA.W EntityV28,X                                   ; 05919E 9D 4A 13 
  LDA.B #$FF                                      ; 0591A1 A9 FF 
  STA.W EntityV27,X                                   ; 0591A3 9D D8 12 
  LDA.B #$17                                      ; 0591A6 A9 17 
  STA.W EntityTypeId,X                                   ; 0591A8 9D 44 07 
  RTS                                             ; 0591AB 60 

  LDA.B $D2                                       ; 0591AC A5 D2 
  AND.B #$1F                                      ; 0591AE 29 1F 
  BNE.B B_591D6                                   ; 0591B0 D0 24 
  LDY.B $1E                                       ; 0591B2 A4 1E 
  LDA.W EntityV23,X                                   ; 0591B4 BD 10 11 
  BEQ.B B_591D1                                   ; 0591B7 F0 18 
  CMP.B #$04                                      ; 0591B9 C9 04 
  BEQ.B B_591D1                                   ; 0591BB F0 14 
  BCS.B B_591C9                                   ; 0591BD B0 0A 
  LDA.W EntityXPx,X                              ; 0591BF BD 46 0B 
  CMP.W EntityXPx,Y                              ; 0591C2 D9 46 0B 
  BCC.B B_591D1                                   ; 0591C5 90 0A 

.byte $80,$0D                                     ; 0591C8 ..       ??
B_591C9:
.byte $BD,$46,$0B,$D9,$46,$0B,$90,$05             ; 0591C9 ........ ?F??F???

B_591D1:
  LDA.B #$2A                                      ; 0591D1 A9 2A 
  JSR.W L_58844                                   ; 0591D3 20 44 88 
B_591D6:
  RTS                                             ; 0591D6 60 


.byte $60,$60,$20,$90,$8B,$F0,$3C,$74             ; 0591D7 ........ `` ???<t
.byte $41,$CE,$E6,$18,$CE,$C6,$06,$DA             ; 0591DF ........ A???????
.byte $AE,$D5,$18,$DE,$C5,$18,$D0,$06             ; 0591E7 ........ ????????
.byte $9E,$C9,$18,$9E,$C1,$18,$FA,$A9             ; 0591EF ........ ????????
.byte $50,$85,$A7,$A9,$10,$85,$A8,$64             ; 0591F7 ........ P??????d
.byte $A9,$AD,$72,$18,$D0,$19,$A4,$1E             ; 0591FF ........ ??r?????
.byte $B9,$FC,$0F,$22,$6D,$E4,$00,$B9             ; 059207 ........ ???"m???
.byte $86,$07,$A8,$B9,$F9,$91,$D0,$0D             ; 05920F ........ ????????
.byte $20,$5D,$8D,$20,$AD,$88,$60,$A5             ; 059217 ........  ]? ??`?
.byte $1E,$22,$6D,$E4,$00,$20,$ED,$8C             ; 05921F ........ ?"m?? ??
.byte $20,$AD,$88,$60,$00,$00,$01,$01             ; 059227 ........  ??`????
.byte $00,$00,$A5,$D2,$29,$1F,$D0,$05             ; 05922F ........ ????)???
.byte $A9,$2A,$20,$44,$88,$60,$60,$60             ; 059237 ........ ?* D?```
.byte $20,$90,$8B,$F0,$2E,$74,$41,$A9             ; 05923F ........  ???.tA?
.byte $50,$85,$A7,$A9,$10,$85,$A8,$64             ; 059247 ........ P??????d
.byte $A9,$AD,$72,$18,$D0,$21,$A4,$1E             ; 05924F ........ ??r??!??
.byte $B9,$FC,$0F,$22,$6D,$E4,$00,$B9             ; 059257 ........ ???"m???
.byte $86,$07,$A8,$B9,$6C,$92,$D0,$15             ; 05925F ........ ????l???
.byte $22,$95,$CA,$0E,$29,$07,$F0,$0D             ; 059267 ........ "???)???
.byte $20,$48,$8C,$20,$AD,$88,$60,$A5             ; 05926F ........  H? ??`?
.byte $1E,$22,$6D,$E4,$00,$CE,$EF,$18             ; 059277 ........ ?"m?????
.byte $CE,$C6,$06,$DA,$BC,$2C,$10,$30             ; 05927F ........ ?????,?0
.byte $0E,$BE,$D6,$18,$DE,$C5,$18,$D0             ; 059287 ........ ????????
.byte $06,$9E,$C9,$18,$9E,$C1,$18,$FA             ; 05928F ........ ????????
.byte $20,$ED,$8C,$20,$AD,$88,$60,$00             ; 059297 ........  ?? ??`?
.byte $00,$01,$01,$00,$00,$A5,$D2,$29             ; 05929F ........ ???????)
.byte $1F,$D0,$05,$A9,$2A,$20,$44,$88             ; 0592A7 ........ ????* D?
.byte $60,$60,$60,$60,$60,$20,$90,$8B             ; 0592AF ........ ````` ??
.byte $F0,$69,$18,$7D,$48,$0F,$9D,$48             ; 0592B7 ........ ?i?}H??H
.byte $0F,$C9,$04,$90,$6F,$74,$41,$A9             ; 0592BF ........ ????otA?
.byte $00,$9D,$28,$08,$BC,$2C,$10,$30             ; 0592C7 ........ ??(??,?0
.byte $1A,$A9,$1E,$99,$44,$07,$BD,$BA             ; 0592CF ........ ????D???
.byte $0F,$99,$BA,$0F,$BD,$9E,$10,$99             ; 0592D7 ........ ????????
.byte $9E,$10,$BD,$80,$0D,$99,$80,$0D             ; 0592DF ........ ????????
.byte $4C,$00,$93,$CE,$E5,$18,$CE,$C6             ; 0592E7 ........ L???????
.byte $06,$DA,$AE,$DB,$18,$DE,$C5,$18             ; 0592EF ........ ????????
.byte $D0,$06,$9E,$C9,$18,$9E,$C1,$18             ; 0592F7 ........ ????????
.byte $FA,$64,$A7,$A9,$20,$85,$A8,$64             ; 0592FF ........ ?d?? ??d
.byte $A9,$AD,$72,$18,$D0,$19,$A4,$1E             ; 059307 ........ ??r?????
.byte $B9,$FC,$0F,$22,$6D,$E4,$00,$B9             ; 05930F ........ ???"m???
.byte $86,$07,$A8,$B9,$37,$93,$D0,$0D             ; 059317 ........ ????7???
.byte $20,$5D,$8D,$20,$AD,$88,$60,$A5             ; 05931F ........  ]? ??`?
.byte $1E,$22,$6D,$E4,$00,$20,$ED,$8C             ; 059327 ........ ?"m?? ??
.byte $20,$AD,$88,$60,$A4,$1E,$B9,$6E             ; 05932F ........  ??`???n
.byte $10,$0A,$A8,$18,$BD,$0C,$09,$79             ; 059337 ........ ???????y
.byte $6F,$93,$9D,$0C,$09,$BD,$7E,$09             ; 05933F ........ o?????~?
.byte $79,$70,$93,$9D,$7E,$09,$18,$BD             ; 059347 ........ yp??~???
.byte $F0,$09,$79,$7F,$93,$9D,$F0,$09             ; 05934F ........ ??y?????
.byte $BD,$62,$0A,$79,$80,$93,$9D,$62             ; 059357 ........ ?b?y???b
.byte $0A,$A9,$30,$9D,$2E,$14,$20,$AD             ; 05935F ........ ??0?.? ?
.byte $88,$60,$00,$00,$01,$01,$00,$00             ; 059367 ........ ?`??????
.byte $00,$00,$80,$00,$80,$00,$80,$00             ; 05936F ........ ????????
.byte $00,$00,$80,$FF,$80,$FF,$80,$FF             ; 059377 ........ ????????
.byte $80,$00,$80,$00,$00,$00,$80,$FF             ; 05937F ........ ????????
.byte $80,$FF,$80,$FF,$00,$00,$80,$00             ; 059387 ........ ????????
.byte $A5,$D2,$29,$0F,$D0,$05,$A9,$2A             ; 05938F ........ ??)????*
.byte $20,$44,$88,$60,$20,$90,$8B,$F0             ; 059397 ........  D?` ???
.byte $45,$18,$7D,$48,$0F,$9D,$48,$0F             ; 05939F ........ E?}H??H?
.byte $C9,$03,$90,$3E,$74,$41,$CE,$C6             ; 0593A7 ........ ???>tA??
.byte $06,$CE,$ED,$18,$DA,$AE,$D9,$18             ; 0593AF ........ ????????
.byte $DE,$C5,$18,$D0,$06,$9E,$C9,$18             ; 0593B7 ........ ????????
.byte $9E,$C1,$18,$FA,$64,$A7,$A9,$20             ; 0593BF ........ ????d?? 
.byte $85,$A8,$64,$A9,$AD,$72,$18,$D0             ; 0593C7 ........ ??d??r??
.byte $0C,$A4,$1E,$B9,$FC,$0F,$22,$6D             ; 0593CF ........ ??????"m
.byte $E4,$00,$4C,$E2,$93,$A5,$1E,$22             ; 0593D7 ........ ??L????"
.byte $6D,$E4,$00,$20,$ED,$8C,$20,$AD             ; 0593DF ........ m?? ?? ?
.byte $88,$60,$A4,$1E,$B9,$6E,$10,$A8             ; 0593E7 ........ ?`???n??
.byte $18,$BD,$7E,$09,$79,$0C,$94,$9D             ; 0593EF ........ ??~?y???
.byte $7E,$09,$18,$BD,$62,$0A,$79,$14             ; 0593F7 ........ ~???b?y?
.byte $94,$9D,$62,$0A,$A9,$30,$9D,$2E             ; 0593FF ........ ??b??0?.
.byte $14,$20,$AD,$88,$60,$00,$01,$01             ; 059407 ........ ? ??`???
.byte $01,$00,$FF,$FF,$FF,$01,$01,$00             ; 05940F ........ ????????
.byte $FF,$FF,$FF,$00,$01,$A5,$D2,$29             ; 059417 ........ ???????)
.byte $0F,$D0,$05,$A9,$2A,$20,$44,$88             ; 05941F ........ ????* D?
.byte $60,$20,$90,$8B,$F0,$4A,$18,$7D             ; 059427 ........ ` ???J?}
.byte $48,$0F,$9D,$48,$0F,$C9,$04,$90             ; 05942F ........ H??H????
.byte $54,$DA,$BD,$BA,$0F,$85,$04,$BD             ; 059437 ........ T???????
.byte $2C,$10,$85,$05,$30,$06,$AA,$A5             ; 05943F ........ ,???0???
.byte $04,$9D,$BA,$0F,$A6,$04,$A5,$05             ; 059447 ........ ????????
.byte $9D,$2C,$10,$FA,$74,$41,$64,$A7             ; 05944F ........ ?,??tAd?
.byte $A9,$20,$85,$A8,$64,$A9,$AD,$72             ; 059457 ........ ? ??d??r
.byte $18,$D0,$19,$A4,$1E,$B9,$FC,$0F             ; 05945F ........ ????????
.byte $22,$6D,$E4,$00,$B9,$86,$07,$A8             ; 059467 ........ "m??????
.byte $B9,$82,$94,$D0,$0D,$20,$5D,$8D             ; 05946F ........ ????? ]?
.byte $20,$AD,$88,$60,$A5,$1E,$22,$6D             ; 059477 ........  ??`??"m
.byte $E4,$00,$20,$ED,$8C,$20,$AD,$88             ; 05947F ........ ?? ?? ??
.byte $60,$20,$AD,$88,$60,$A4,$1E,$B9             ; 059487 ........ ` ??`???
.byte $6E,$10,$A8,$18,$BD,$7E,$09,$79             ; 05948F ........ n????~?y
.byte $BA,$94,$9D,$7E,$09,$18,$BD,$62             ; 059497 ........ ???~???b
.byte $0A,$79,$C2,$94,$9D,$62,$0A,$A9             ; 05949F ........ ?y???b??
.byte $0A,$9D,$80,$0D,$A9,$30,$9D,$2E             ; 0594A7 ........ ?????0?.
.byte $14,$20,$AD,$88,$60,$00,$00,$01             ; 0594AF ........ ? ??`???
.byte $01,$00,$00,$00,$01,$01,$01,$00             ; 0594B7 ........ ????????
.byte $FF,$FF,$FF,$01,$01,$00,$FF,$FF             ; 0594BF ........ ????????
.byte $FF,$00,$01,$A5,$D2,$29,$0F,$D0             ; 0594C7 ........ ?????)??
.byte $05,$A9,$2A,$20,$44,$88,$60,$60             ; 0594CF ........ ??* D?``
.byte $60,$BD,$44,$07,$C9,$23,$F0,$08             ; 0594D7 ........ `?D??#??
.byte $C9,$24,$F0,$04,$C9,$25,$D0,$03             ; 0594DF ........ ?$???%??
.byte $CE,$D2,$05,$20,$90,$8B,$F0,$54             ; 0594E7 ........ ??? ???T
.byte $18,$7D,$48,$0F,$9D,$48,$0F,$C9             ; 0594EF ........ ?}H??H??
.byte $02,$90,$59,$74,$41,$A9,$00,$9D             ; 0594F7 ........ ??YtA???
.byte $28,$08,$A9,$21,$9D,$44,$07,$A9             ; 0594FF ........ (??!?D??
.byte $01,$9D,$4A,$13,$64,$A7,$A9,$25             ; 059507 ........ ??J?d??%
.byte $85,$A8,$64,$A9,$AD,$72,$18,$D0             ; 05950F ........ ??d??r??
.byte $2F,$A4,$1E,$B9,$FC,$0F,$22,$6D             ; 059517 ........ /?????"m
.byte $E4,$00,$B9,$6E,$10,$A8,$18,$BD             ; 05951F ........ ???n????
.byte $7E,$09,$79,$85,$95,$9D,$7E,$09             ; 059527 ........ ~?y???~?
.byte $18,$BD,$62,$0A,$79,$8D,$95,$9D             ; 05952F ........ ??b?y???
.byte $62,$0A,$A9,$0D,$9D,$2C,$10,$A9             ; 059537 ........ b????,??
.byte $30,$9D,$2E,$14,$20,$AD,$88,$60             ; 05953F ........ 0?.? ??`
.byte $A5,$1E,$22,$6D,$E4,$00,$A9,$01             ; 059547 ........ ??"m????
.byte $9D,$2C,$10,$60,$A4,$1E,$B9,$6E             ; 05954F ........ ?,?`???n
.byte $10,$A8,$18,$BD,$7E,$09,$79,$85             ; 059557 ........ ????~?y?
.byte $95,$9D,$7E,$09,$18,$BD,$62,$0A             ; 05955F ........ ??~???b?
.byte $79,$8D,$95,$9D,$62,$0A,$A9,$26             ; 059567 ........ y???b??&
.byte $9D,$44,$07,$A9,$01,$9D,$4A,$13             ; 05956F ........ ?D????J?
.byte $A9,$0D,$9D,$2C,$10,$A9,$30,$9D             ; 059577 ........ ???,??0?
.byte $2E,$14,$20,$AD,$88,$60,$00,$01             ; 05957F ........ .? ??`??
.byte $01,$01,$00,$FF,$FF,$FF,$01,$01             ; 059587 ........ ????????
.byte $00,$FF,$FF,$FF,$00,$01,$A5,$D2             ; 05958F ........ ????????
.byte $29,$0F,$D0,$05,$A9,$2B,$20,$44             ; 059597 ........ )????+ D
.byte $88,$60,$60,$A5,$D2,$29,$0F,$D0             ; 05959F ........ ?``??)??
.byte $05,$A9,$2B,$20,$44,$88,$60,$20             ; 0595A7 ........ ??+ D?` 
.byte $90,$8B,$F0,$45,$18,$7D,$48,$0F             ; 0595AF ........ ???E?}H?
.byte $9D,$48,$0F,$C9,$02,$90,$3E,$74             ; 0595B7 ........ ?H????>t
.byte $41,$CE,$C6,$06,$CE,$EE,$18,$DA             ; 0595BF ........ A???????
.byte $AE,$DC,$18,$DE,$C5,$18,$D0,$06             ; 0595C7 ........ ????????
.byte $9E,$C9,$18,$9E,$C1,$18,$FA,$20             ; 0595CF ........ ??????? 
.byte $ED,$8C,$64,$A7,$A9,$20,$85,$A8             ; 0595D7 ........ ??d?? ??
.byte $64,$A9,$AD,$72,$18,$D0,$0C,$A4             ; 0595DF ........ d??r????
.byte $1E,$B9,$FC,$0F,$22,$6D,$E4,$00             ; 0595E7 ........ ????"m??
.byte $4C,$F8,$95,$A5,$1E,$22,$6D,$E4             ; 0595EF ........ L????"m?
.byte $00,$20,$AD,$88,$60,$A4,$1E,$B9             ; 0595F7 ........ ? ??`???
.byte $6E,$10,$A8,$A4,$1E,$B9,$6E,$10             ; 0595FF ........ n?????n?
.byte $A8,$18,$BD,$7E,$09,$79,$25,$96             ; 059607 ........ ???~?y%?
.byte $9D,$7E,$09,$18,$BD,$62,$0A,$79             ; 05960F ........ ?~???b?y
.byte $2D,$96,$9D,$62,$0A,$A9,$30,$9D             ; 059617 ........ -??b??0?
.byte $2E,$14,$20,$AD,$88,$60,$00,$01             ; 05961F ........ .? ??`??
.byte $01,$01,$00,$FF,$FF,$FF,$01,$01             ; 059627 ........ ????????
.byte $00,$FF,$FF,$FF,$00,$01,$A5,$D2             ; 05962F ........ ????????
.byte $29,$0F,$D0,$05,$A9,$2A,$20,$44             ; 059637 ........ )????* D
.byte $88,$60,$20,$90,$8B,$F0,$69,$18             ; 05963F ........ ?` ???i?
.byte $7D,$48,$0F,$9D,$48,$0F,$C9,$04             ; 059647 ........ }H??H???
.byte $90,$6F,$74,$41,$A9,$00,$9D,$28             ; 05964F ........ ?otA???(
.byte $08,$BC,$2C,$10,$30,$1A,$A9,$29             ; 059657 ........ ??,?0??)
.byte $99,$44,$07,$BD,$BA,$0F,$99,$BA             ; 05965F ........ ?D??????
.byte $0F,$BD,$9E,$10,$99,$9E,$10,$BD             ; 059667 ........ ????????
.byte $80,$0D,$99,$80,$0D,$4C,$8D,$96             ; 05966F ........ ?????L??
.byte $CE,$F0,$18,$CE,$C6,$06,$DA,$AE             ; 059677 ........ ????????
.byte $DD,$18,$DE,$C5,$18,$D0,$06,$9E             ; 05967F ........ ????????
.byte $C9,$18,$9E,$C1,$18,$FA,$64,$A7             ; 059687 ........ ??????d?
.byte $A9,$20,$85,$A8,$64,$A9,$AD,$72             ; 05968F ........ ? ??d??r
.byte $18,$D0,$19,$A4,$1E,$B9,$FC,$0F             ; 059697 ........ ????????
.byte $22,$6D,$E4,$00,$B9,$86,$07,$A8             ; 05969F ........ "m??????
.byte $B9,$B1,$96,$D0,$0D,$20,$5D,$8D             ; 0596A7 ........ ????? ]?
.byte $20,$AD,$88,$60,$A5,$1E,$22,$6D             ; 0596AF ........  ??`??"m
.byte $E4,$00,$20,$ED,$8C,$20,$AD,$88             ; 0596B7 ........ ?? ?? ??
.byte $60,$A4,$1E,$B9,$6E,$10,$A8,$18             ; 0596BF ........ `???n???
.byte $BD,$7E,$09,$79,$E9,$96,$9D,$7E             ; 0596C7 ........ ?~?y???~
.byte $09,$18,$BD,$62,$0A,$79,$F1,$96             ; 0596CF ........ ???b?y??
.byte $9D,$62,$0A,$A9,$30,$9D,$2E,$14             ; 0596D7 ........ ?b??0?.?
.byte $20,$AD,$88,$60,$00,$00,$01,$01             ; 0596DF ........  ??`????
.byte $00,$00,$00,$02,$02,$02,$00,$FE             ; 0596E7 ........ ????????
.byte $FE,$FE,$02,$02,$00,$FE,$FE,$FE             ; 0596EF ........ ????????
.byte $00,$02,$A5,$D2,$29,$0F,$D0,$05             ; 0596F7 ........ ????)???
.byte $A9,$2A,$20,$44,$88,$60,$20,$90             ; 0596FF ........ ?* D?` ?
.byte $8B,$F0,$4A,$18,$7D,$48,$0F,$9D             ; 059707 ........ ??J?}H??
.byte $48,$0F,$C9,$04,$90,$50,$74,$41             ; 05970F ........ H????PtA
.byte $DA,$BD,$BA,$0F,$85,$04,$BD,$2C             ; 059717 ........ ???????,
.byte $10,$85,$05,$30,$06,$AA,$A5,$04             ; 05971F ........ ???0????
.byte $9D,$BA,$0F,$A6,$04,$A5,$05,$9D             ; 059727 ........ ????????
.byte $2C,$10,$FA,$64,$A7,$A9,$20,$85             ; 05972F ........ ,??d?? ?
.byte $A8,$64,$A9,$AD,$72,$18,$D0,$19             ; 059737 ........ ?d??r???
.byte $A4,$1E,$B9,$FC,$0F,$22,$6D,$E4             ; 05973F ........ ?????"m?
.byte $00,$B9,$86,$07,$A8,$B9,$5B,$97             ; 059747 ........ ??????[?
.byte $D0,$0D,$20,$5D,$8D,$20,$AD,$88             ; 05974F ........ ?? ]? ??
.byte $60,$A5,$1E,$22,$6D,$E4,$00,$20             ; 059757 ........ `??"m?? 
.byte $ED,$8C,$20,$AD,$88,$60,$A4,$1E             ; 05975F ........ ?? ??`??
.byte $B9,$6E,$10,$A8,$18,$BD,$7E,$09             ; 059767 ........ ?n????~?
.byte $79,$93,$97,$9D,$7E,$09,$18,$BD             ; 05976F ........ y???~???
.byte $62,$0A,$79,$9B,$97,$9D,$62,$0A             ; 059777 ........ b?y???b?
.byte $A9,$10,$9D,$80,$0D,$A9,$30,$9D             ; 05977F ........ ??????0?
.byte $2E,$14,$20,$AD,$88,$60,$00,$00             ; 059787 ........ .? ??`??
.byte $01,$01,$00,$00,$00,$02,$02,$02             ; 05978F ........ ????????
.byte $00,$FE,$FE,$FE,$02,$02,$00,$FE             ; 059797 ........ ????????
.byte $FE,$FE,$00,$02,$A5,$D2,$29,$0F             ; 05979F ........ ??????)?
.byte $D0,$05,$A9,$2A,$20,$44,$88,$60             ; 0597A7 ........ ???* D?`

  JSR.W L_58B90                                   ; 0597AF 20 90 8B 
  BEQ.B B_597EB                                   ; 0597B2 F0 37 
  CLC                                             ; 0597B4 18 
  ADC.W EntityV19,X                                   ; 0597B5 7D 48 0F 
  STA.W EntityV19,X                                   ; 0597B8 9D 48 0F 
  CMP.B #$08                                      ; 0597BB C9 08 
  BCC.B B_597EF                                   ; 0597BD 90 30 
  LDA.B #$50                                      ; 0597BF A9 50 
  STA.B $A7                                       ; 0597C1 85 A7 
  LDA.B #$23                                      ; 0597C3 A9 23 
  STA.B $A8                                       ; 0597C5 85 A8 
  STZ.B $A9                                       ; 0597C7 64 A9 
  LDA.W $1872                                     ; 0597C9 AD 72 18 
  BNE.B B_597DA                                   ; 0597CC D0 0C 
  LDY.B $1E                                       ; 0597CE A4 1E 
  LDA.W EntityV20+Projectiles,Y                                   ; 0597D0 B9 FC 0F 
  JSL IncreasePlayerScore                                      ; 0597D3 22 6D E4 00 
  JMP.W D_597E0                                   ; 0597D7 4C E0 97 
B_597DA:
  LDA.B $1E                                       ; 0597DA A5 1E 
  JSL IncreasePlayerScore                                      ; 0597DC 22 6D E4 00 
D_597E0:
  STZ.B $41,X                                     ; 0597E0 74 41 
  DEC.W $18EC                                     ; 0597E2 CE EC 18 
  DEC.W $06C6                                     ; 0597E5 CE C6 06 
  JSR.W L_58CED                                   ; 0597E8 20 ED 8C 
B_597EB:
  JSR.W L_58926                                   ; 0597EB 20 26 89 
  RTS                                             ; 0597EE 60 

B_597EF:
  LDY.B $1E                                       ; 0597EF A4 1E 
  LDA.W EntityV21+Projectiles,Y                                   ; 0597F1 B9 6E 10 
  TAY                                             ; 0597F4 A8 
  CLC                                             ; 0597F5 18 
  LDA.W EntityXPx,X                              ; 0597F6 BD 46 0B 
  ADC.W D_59845,Y                                 ; 0597F9 79 45 98 
  CMP.B #$1E                                      ; 0597FC C9 1E 
  BCC.B B_59807                                   ; 0597FE 90 07 
  CMP.B #$E2                                      ; 059800 C9 E2 
  BCS.B B_59807                                   ; 059802 B0 03 
  STA.W EntityXPx,X                              ; 059804 9D 46 0B 
B_59807:
  CLC                                             ; 059807 18 
  LDA.W EntityYPx,X                                   ; 059808 BD 9C 0C 
  ADC.W D_5984D,Y                                 ; 05980B 79 4D 98 
  CMP.B #$2C                                      ; 05980E C9 2C 
  BCC.B B_59819                                   ; 059810 90 07 
  CMP.B #$D0                                      ; 059812 C9 D0 
  BCS.B B_59819                                   ; 059814 B0 03 
  STA.W EntityYPx,X                                   ; 059816 9D 9C 0C 
B_59819:
  LDA.W EntityV30,X                                   ; 059819 BD 2E 14 
  AND.B #$F1                                      ; 05981C 29 F1 
  STA.W EntityV30,X                                   ; 05981E 9D 2E 14 
  JSR.W L_58926                                   ; 059821 20 26 89 
  LDA.B #$FF                                      ; 059824 A9 FF 
  XBA                                             ; 059826 EB 
  JSL AdvanceRNG                                     ; 059827 22 95 CA 0E 
  AND.B #$03                                      ; 05982B 29 03 
  TAY                                             ; 05982D A8 
  LDA.W D_59841,Y                                 ; 05982E B9 41 98 
  BEQ.B B_59840                                   ; 059831 F0 0D 
  PHX                                             ; 059833 DA 
  REP.B #P_Idx8Bit                                      ; 059834 C2 10 
  TAX                                             ; 059836 AA 
  LDA.B #$07                                      ; 059837 A9 07 
  JSL Audio_F830F                                     ; 059839 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 05983D E2 30 
  PLX                                             ; 05983F FA 
B_59840:
  RTS                                             ; 059840 60 


D_59841:
.byte $0C,$0D,$00,$00                             ; 059842 DDDD     ????
D_59845:
.byte $00,$04,$04,$04,$00,$FC,$FC,$FC             ; 059845 DDDDDDDD ????????
D_5984D:
.byte $04,$04,$00,$FC,$FC,$FC,$00,$04             ; 05984D DDDDDDDD ????????

  LDA.B $D2                                       ; 059855 A5 D2 
  AND.B #$0F                                      ; 059857 29 0F 
  BNE.B B_59860                                   ; 059859 D0 05 
  LDA.B #$2A                                      ; 05985B A9 2A 
  JSR.W L_58844                                   ; 05985D 20 44 88 
B_59860:
  RTS                                             ; 059860 60 

  LDA.W $1872                                     ; 059861 AD 72 18 
  BNE.B B_59877                                   ; 059864 D0 11 
  LDY.B $1E                                       ; 059866 A4 1E 
  LDA.W EntityTypeId+Projectiles,Y                                   ; 059868 B9 86 07 
  CMP.B #$38                                      ; 05986B C9 38 
  BEQ.B B_59877                                   ; 05986D F0 08 
  CMP.B #$36                                      ; 05986F C9 36 
  BEQ.B B_59877                                   ; 059871 F0 04 
  CMP.B #$37                                      ; 059873 C9 37 
  BNE.B B_5987D                                   ; 059875 D0 06 
B_59877:
  DEC.W $06C6                                     ; 059877 CE C6 06 
  JSR.W L_58D25                                   ; 05987A 20 25 8D 
B_5987D:
  RTS                                             ; 05987D 60 

  LDA.B #$2A                                      ; 05987E A9 2A 
  JSR.W L_58844                                   ; 059880 20 44 88 
  DEC.W $06C6                                     ; 059883 CE C6 06 
  JSR.W L_58D25                                   ; 059886 20 25 8D 
  RTS                                             ; 059889 60 


.byte $60,$60,$60,$60,$60,$60,$60,$60             ; 05988A ........ ````````
.byte $60,$60,$60,$60,$60,$60,$60,$60             ; 059892 ........ ````````
.byte $60,$60,$60,$60                             ; 05989B ....     ````

  LDA.W $05D6                                     ; 05989E AD D6 05 
  BPL.B B_598A4                                   ; 0598A1 10 01 

.byte $60                                         ; 0598A4 .        `

B_598A4:
  STZ.B $41,X                                     ; 0598A4 74 41 
  STZ.W EntityHeader,X                                   ; 0598A6 9E D2 06 
  PHX                                             ; 0598A9 DA 
  LDY.W EntityV31,X                                   ; 0598AA BC A0 14 
  JSL L_AEF1                                      ; 0598AD 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 0598B1 BD A0 14 
  TAX                                             ; 0598B4 AA 
  STZ.W $175E,X                                   ; 0598B5 9E 5E 17 
  ASL                                             ; 0598B8 0A 
  ASL                                             ; 0598B9 0A 
  TAY                                             ; 0598BA A8 
  LDA.B #$F0                                      ; 0598BB A9 F0 
  BCC.B B_598C4                                   ; 0598BD 90 05 
  STA.W $0409,Y                                   ; 0598BF 99 09 04 
  BRA.B B_598C7                                   ; 0598C2 80 03 

B_598C4:
.byte $99,$09,$03                                 ; 0598C5 ...      ???

B_598C7:
  PLX                                             ; 0598C7 FA 
  LDX.B $1E                                       ; 0598C8 A6 1E 
  LDA.W EquippedWeaponType,X                                   ; 0598CA BD 97 18 
  CMP.B #$03                                      ; 0598CD C9 03 
  BNE.B B_598E1                                   ; 0598CF D0 10 

.byte $DA,$AE,$D1,$18,$DE,$C5,$18,$D0             ; 0598D1 ........ ????????
.byte $06,$9E,$C9,$18,$9E,$C1,$18,$FA             ; 0598D9 ........ ????????

B_598E1:
  LDA.B #$01                                      ; 0598E1 A9 01 
  STA.W EquippedWeaponType,X                                   ; 0598E3 9D 97 18 
  LDA.B #$06                                      ; 0598E6 A9 06 
  STA.W EquippedWeaponMagazines,X                                   ; 0598E8 9D 99 18 
  STZ.W EquippedWeaponMaxMagazines,X                                   ; 0598EB 9E 9B 18 
  LDA.W WeaponType1PickupAmmo                                     ; 0598EE AD 9F 18 
  STA.W EquippedWeaponAmmo,X                        ; 0598F1 9D 9D 18 
  LDA.B #$0A                                      ; 0598F4 A9 0A 
  STA.W $18B0,X                                   ; 0598F6 9D B0 18 
  JSL AdvanceRNG                                     ; 0598F9 22 95 CA 0E 
  AND.B #$3F                                      ; 0598FD 29 3F 
  CLC                                             ; 0598FF 18 
  ADC.B #$40                                      ; 059900 69 40 
  STA.W DropTimer                   ; 059902 8D AE 05 
  JSR.W L_599F9                                   ; 059905 20 F9 99 
  RTS                                             ; 059908 60 

  LDA.W $05D6                                     ; 059909 AD D6 05 
  BPL.B B_5990F                                   ; 05990C 10 01 

.byte $60                                         ; 05990F .        `

B_5990F:
  STZ.B $41,X                                     ; 05990F 74 41 
  STZ.W EntityHeader,X                                   ; 059911 9E D2 06 
  PHX                                             ; 059914 DA 
  LDY.W EntityV31,X                                   ; 059915 BC A0 14 
  JSL L_AEF1                                      ; 059918 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 05991C BD A0 14 
  TAX                                             ; 05991F AA 
  STZ.W $175E,X                                   ; 059920 9E 5E 17 
  ASL                                             ; 059923 0A 
  ASL                                             ; 059924 0A 
  TAY                                             ; 059925 A8 
  LDA.B #$F0                                      ; 059926 A9 F0 
  BCC.B B_5992F                                   ; 059928 90 05 
  STA.W $0409,Y                                   ; 05992A 99 09 04 
  BRA.B B_59932                                   ; 05992D 80 03 

B_5992F:
.byte $99,$09,$03                                 ; 059930 ...      ???

B_59932:
  PLX                                             ; 059932 FA 
  LDX.B $1E                                       ; 059933 A6 1E 
  LDA.W EquippedWeaponType,X                                   ; 059935 BD 97 18 
  CMP.B #$03                                      ; 059938 C9 03 
  BNE.B B_5994C                                   ; 05993A D0 10 
  PHX                                             ; 05993C DA 
  LDX.W $18D1                                     ; 05993D AE D1 18 
  DEC.W $18C5,X                                   ; 059940 DE C5 18 
  BNE.B B_5994B                                   ; 059943 D0 06 
  STZ.W $18C9,X                                   ; 059945 9E C9 18 
  STZ.W $18C1,X                                   ; 059948 9E C1 18 
B_5994B:
  PLX                                             ; 05994B FA 
B_5994C:
  LDA.B #$02                                      ; 05994C A9 02 
  STA.W EquippedWeaponType,X                                   ; 05994E 9D 97 18 
  LDA.B #$06                                      ; 059951 A9 06 
  STA.W EquippedWeaponMagazines,X                                   ; 059953 9D 99 18 
  STZ.W EquippedWeaponMaxMagazines,X                                   ; 059956 9E 9B 18 
  LDA.W WeaponType2PickupAmmo                                     ; 059959 AD A0 18 
  STA.W EquippedWeaponAmmo,X                        ; 05995C 9D 9D 18 
  LDA.B #$09                                      ; 05995F A9 09 
  STA.W $18B0,X                                   ; 059961 9D B0 18 
  JSL AdvanceRNG                                     ; 059964 22 95 CA 0E 
  AND.B #$3F                                      ; 059968 29 3F 
  CLC                                             ; 05996A 18 
  ADC.B #$40                                      ; 05996B 69 40 
  STA.W DropTimer                   ; 05996D 8D AE 05 
  JSR.W L_599F9                                   ; 059970 20 F9 99 
  RTS                                             ; 059973 60 

  LDA.W $05D6                                     ; 059974 AD D6 05 
  BPL.B B_5997A                                   ; 059977 10 01 

.byte $60                                         ; 05997A .        `

B_5997A:
  STZ.B $41,X                                     ; 05997A 74 41 
  LDY.W CurrentRound                                     ; 05997C AC AB 05 
  BEQ.B B_5998F                                   ; 05997F F0 0E 

.byte $88,$F0,$02,$80,$10,$AD,$AC,$05             ; 059981 ........ ????????
.byte $C9,$07,$D0,$09,$80,$02                     ; 05998A ......   ??????

B_5998F:
  BRA.B B_59996                                   ; 05998F 80 05 

.byte $20,$43,$9C,$80,$22                         ; 059992 .....     C??"

B_59996:
  STZ.W EntityHeader,X                                   ; 059996 9E D2 06 
  PHX                                             ; 059999 DA 
  LDY.W EntityV31,X                                   ; 05999A BC A0 14 
  JSL L_AEF1                                      ; 05999D 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 0599A1 BD A0 14 
  TAX                                             ; 0599A4 AA 
  STZ.W $175E,X                                   ; 0599A5 9E 5E 17 
  ASL                                             ; 0599A8 0A 
  ASL                                             ; 0599A9 0A 
  TAY                                             ; 0599AA A8 
  LDA.B #$F0                                      ; 0599AB A9 F0 
  BCC.B B_599B4                                   ; 0599AD 90 05 
  STA.W $0409,Y                                   ; 0599AF 99 09 04 
  BRA.B B_599B7                                   ; 0599B2 80 03 

B_599B4:
.byte $99,$09,$03                                 ; 0599B5 ...      ???

B_599B7:
  PLX                                             ; 0599B7 FA 
  LDX.B $1E                                       ; 0599B8 A6 1E 
  LDA.W EquippedWeaponType,X                                   ; 0599BA BD 97 18 
  CMP.B #$03                                      ; 0599BD C9 03 
  BNE.B B_599D1                                   ; 0599BF D0 10 
  LDX.W $18D1                                     ; 0599C1 AE D1 18 
  DEC.W $18C5,X                                   ; 0599C4 DE C5 18 
  BNE.B B_599CF                                   ; 0599C7 D0 06 

.byte $9E,$C9,$18,$9E,$C1,$18                     ; 0599CA ......   ??????

B_599CF:
  LDX.B $1E                                       ; 0599CF A6 1E 
B_599D1:
  LDA.B #$03                                      ; 0599D1 A9 03 
  STA.W EquippedWeaponType,X                                   ; 0599D3 9D 97 18 
  LDA.B #$06                                      ; 0599D6 A9 06 
  STA.W EquippedWeaponMagazines,X                                   ; 0599D8 9D 99 18 
  STZ.W EquippedWeaponMaxMagazines,X                                   ; 0599DB 9E 9B 18 
  LDA.W WeaponType3PickupAmmo                                     ; 0599DE AD A1 18 
  STA.W EquippedWeaponAmmo,X                        ; 0599E1 9D 9D 18 
  LDA.B #$04                                      ; 0599E4 A9 04 
  STA.W $18B0,X                                   ; 0599E6 9D B0 18 
  JSL AdvanceRNG                                     ; 0599E9 22 95 CA 0E 
  AND.B #$3F                                      ; 0599ED 29 3F 
  CLC                                             ; 0599EF 18 
  ADC.B #$40                                      ; 0599F0 69 40 
  STA.W DropTimer                   ; 0599F2 8D AE 05 
  JSR.W L_599F9                                   ; 0599F5 20 F9 99 
  RTS                                             ; 0599F8 60 


L_599F9:
  PHX                                             ; 0599F9 DA 
  REP.B #P_Idx8Bit                                      ; 0599FA C2 10 
  LDX.W #$0004                                    ; 0599FC A2 04 00 
  LDA.B #$0F                                      ; 0599FF A9 0F 
  JSL Audio_F830F                                     ; 059A01 22 0F 83 0F 
  LDA.B #$07                                      ; 059A05 A9 07 
  LDX.W #$8815                                    ; 059A07 A2 15 88 
  JSL Audio_F830F                                     ; 059A0A 22 0F 83 0F 
  LDX.W $05E0                                     ; 059A0E AE E0 05 
  LDA.B #$0F                                      ; 059A11 A9 0F 
  JSL Audio_F830F                                     ; 059A13 22 0F 83 0F 
  SEP.B #P_Idx8Bit                                      ; 059A17 E2 10 
  PLX                                             ; 059A19 FA 
  RTS                                             ; 059A1A 60 


.byte $AD,$D6,$05,$10,$01,$60                     ; 059A1C ......   ?????`

  STZ.B $41,X                                     ; 059A21 74 41 
  LDA.W $05D3                                     ; 059A23 AD D3 05 
  BEQ.B B_59A57                                   ; 059A26 F0 2F 

.byte $DA,$BC,$A0,$14,$22,$F1,$AE,$00             ; 059A28 ........ ????"???
.byte $BD,$A0,$14,$AA,$9E,$5E,$17,$0A             ; 059A30 ........ ?????^??
.byte $0A,$A8,$A9,$F0,$90,$05,$99,$09             ; 059A38 ........ ????????
.byte $04,$80,$03,$99,$09,$03,$FA,$22             ; 059A40 ........ ???????"
.byte $95,$CA,$0E,$29,$3F,$18,$69,$40             ; 059A48 ........ ???)??i@
.byte $8D,$AE,$05,$20,$F9,$99,$60                 ; 059A51 .......  ??? ??`

B_59A57:
  LDY.W CurrentRound                                     ; 059A57 AC AB 05 
  BEQ.B B_59A6A                                   ; 059A5A F0 0E 

.byte $88,$F0,$02,$80,$10,$AD,$AC,$05             ; 059A5C ........ ????????
.byte $C9,$07,$D0,$09,$80,$02                     ; 059A65 ......   ??????

B_59A6A:
  BRA.B B_59A71                                   ; 059A6A 80 05 

.byte $20,$43,$9C,$80,$22                         ; 059A6D .....     C??"

B_59A71:
  STZ.W EntityHeader,X                                   ; 059A71 9E D2 06 
  PHX                                             ; 059A74 DA 
  LDY.W EntityV31,X                                   ; 059A75 BC A0 14 
  JSL L_AEF1                                      ; 059A78 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 059A7C BD A0 14 
  TAX                                             ; 059A7F AA 
  STZ.W $175E,X                                   ; 059A80 9E 5E 17 
  ASL                                             ; 059A83 0A 
  ASL                                             ; 059A84 0A 
  TAY                                             ; 059A85 A8 
  LDA.B #$F0                                      ; 059A86 A9 F0 
  BCC.B B_59A8F                                   ; 059A88 90 05 
  STA.W $0409,Y                                   ; 059A8A 99 09 04 
  BRA.B B_59A92                                   ; 059A8D 80 03 

B_59A8F:
.byte $99,$09,$03                                 ; 059A90 ...      ???

B_59A92:
  PLX                                             ; 059A92 FA 
  LDX.B $1E                                       ; 059A93 A6 1E 
  LDA.W EquippedWeaponType,X                                   ; 059A95 BD 97 18 
  CMP.B #$03                                      ; 059A98 C9 03 
  BNE.B B_59AAC                                   ; 059A9A D0 10 

.byte $DA,$AE,$D1,$18,$DE,$C5,$18,$D0             ; 059A9C ........ ????????
.byte $06,$9E,$C9,$18,$9E,$C1,$18,$FA             ; 059AA4 ........ ????????

B_59AAC:
  LDA.B #$04                                      ; 059AAC A9 04 
  STA.W EquippedWeaponType,X                                   ; 059AAE 9D 97 18 
  LDA.B #$06                                      ; 059AB1 A9 06 
  STA.W EquippedWeaponMagazines,X                                   ; 059AB3 9D 99 18 
  STZ.W EquippedWeaponMaxMagazines,X                                   ; 059AB6 9E 9B 18 
  LDA.W WeaponType4PickupAmmo                                     ; 059AB9 AD A2 18 
  STA.W EquippedWeaponAmmo,X                        ; 059ABC 9D 9D 18 
  LDA.B #$09                                      ; 059ABF A9 09 
  STA.W $18B0,X                                   ; 059AC1 9D B0 18 
  JSL AdvanceRNG                                     ; 059AC4 22 95 CA 0E 
  AND.B #$3F                                      ; 059AC8 29 3F 
  CLC                                             ; 059ACA 18 
  ADC.B #$40                                      ; 059ACB 69 40 
  STA.W DropTimer                   ; 059ACD 8D AE 05 
  JSR.W L_599F9                                   ; 059AD0 20 F9 99 
  RTS                                             ; 059AD3 60 

  LDA.W $05D6                                     ; 059AD4 AD D6 05 
  BPL.B B_59ADA                                   ; 059AD7 10 01 

.byte $60                                         ; 059ADA .        `

B_59ADA:
  STZ.B $41,X                                     ; 059ADA 74 41 
  LDA.B #$1D                                      ; 059ADC A9 1D 
  STA.W EntityTypeId,X                                   ; 059ADE 9D 44 07 
  LDA.B #$00                                      ; 059AE1 A9 00 
  STA.W EntityV3,X                                   ; 059AE3 9D 28 08 
  LDA.B $1E                                       ; 059AE6 A5 1E 
  STA.W $05D0                                     ; 059AE8 8D D0 05 
  LDA.B #$05                                      ; 059AEB A9 05 
  STA.W EntityV20,X                                   ; 059AED 9D BA 0F 
  STZ.W EntityV15,X                                   ; 059AF0 9E 80 0D 
  LDA.B #$E6                                      ; 059AF3 A9 E6 
  STA.W EntityV29,X                                   ; 059AF5 9D BC 13 
  PHX                                             ; 059AF8 DA 
  LDY.W EntityV31,X                                   ; 059AF9 BC A0 14 
  JSL L_AEF1                                      ; 059AFC 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 059B00 BD A0 14 
  TAX                                             ; 059B03 AA 
  STZ.W $175E,X                                   ; 059B04 9E 5E 17 
  ASL                                             ; 059B07 0A 
  ASL                                             ; 059B08 0A 
  TAY                                             ; 059B09 A8 
  LDA.B #$F0                                      ; 059B0A A9 F0 
  BCC.B B_59B13                                   ; 059B0C 90 05 
  STA.W $0409,Y                                   ; 059B0E 99 09 04 
  BRA.B B_59B16                                   ; 059B11 80 03 

B_59B13:
.byte $99,$09,$03                                 ; 059B14 ...      ???

B_59B16:
  PLX                                             ; 059B16 FA 
  JSL AdvanceRNG                                     ; 059B17 22 95 CA 0E 
  AND.B #$3F                                      ; 059B1B 29 3F 
  CLC                                             ; 059B1D 18 
  ADC.B #$40                                      ; 059B1E 69 40 
  STA.W DropTimer                   ; 059B20 8D AE 05 
  RTS                                             ; 059B23 60 

  LDA.W $05D6                                     ; 059B24 AD D6 05 
  BPL.B B_59B2A                                   ; 059B27 10 01 

.byte $60                                         ; 059B2A .        `

B_59B2A:
  STZ.B $41,X                                     ; 059B2A 74 41 
  STZ.W EntityHeader,X                                   ; 059B2C 9E D2 06 
  PHX                                             ; 059B2F DA 
  LDY.W EntityV31,X                                   ; 059B30 BC A0 14 
  JSL L_AEF1                                      ; 059B33 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 059B37 BD A0 14 
  TAX                                             ; 059B3A AA 
  STZ.W $175E,X                                   ; 059B3B 9E 5E 17 
  ASL                                             ; 059B3E 0A 
  ASL                                             ; 059B3F 0A 
  TAY                                             ; 059B40 A8 
  LDA.B #$F0                                      ; 059B41 A9 F0 
  BCC.B B_59B4A                                   ; 059B43 90 05 
  STA.W $0409,Y                                   ; 059B45 99 09 04 
  BRA.B B_59B4D                                   ; 059B48 80 03 

B_59B4A:
.byte $99,$09,$03                                 ; 059B4B ...      ???

B_59B4D:
  PLX                                             ; 059B4D FA 
  LDX.W $18D1                                     ; 059B4E AE D1 18 
  DEC.W $18C5,X                                   ; 059B51 DE C5 18 
  BNE.B B_59B5C                                   ; 059B54 D0 06 
  STZ.W $18C9,X                                   ; 059B56 9E C9 18 
  STZ.W $18C1,X                                   ; 059B59 9E C1 18 
B_59B5C:
  JSL AdvanceRNG                                     ; 059B5C 22 95 CA 0E 
  AND.B #$3F                                      ; 059B60 29 3F 
  CLC                                             ; 059B62 18 
  ADC.B #$40                                      ; 059B63 69 40 
  STA.W DropTimer                   ; 059B65 8D AE 05 
  LDA.B $1E                                       ; 059B68 A5 1E 
  STA.W PlayerOrbStatus                                     ; 059B6A 8D CE 05 
  JSL FindEmptyProjectileSlot                                     ; 059B6D 22 E4 80 03 
  BEQ.B B_59B74                                   ; 059B71 F0 01 

.byte $60                                         ; 059B74 .        `

B_59B74:
  STX.W $05CF                                     ; 059B74 8E CF 05 
  JSL ClearEntitySlotData                                     ; 059B77 22 94 80 03 
  LDA.W PlayerOrbStatus                                     ; 059B7B AD CE 05 
  STA.W EntityV20,X                                   ; 059B7E 9D BA 0F 
  LDA.B #$01                                      ; 059B81 A9 01 
  STA.W EntityHeader,X                                   ; 059B83 9D D2 06 
  LDA.B #$38                                      ; 059B86 A9 38 
  STA.W EntityTypeId,X                                   ; 059B88 9D 44 07 
  LDA.B #$02                                      ; 059B8B A9 02 
  STA.W EntityV3,X                                   ; 059B8D 9D 28 08 
  LDY.W PlayerOrbStatus                                     ; 059B90 AC CE 05 
  LDA.W EntityXPx,Y                              ; 059B93 B9 46 0B 
  STA.W EntityXPx,X                              ; 059B96 9D 46 0B 
  SEC                                             ; 059B99 38 
  LDA.W EntityYPx,Y                                   ; 059B9A B9 9C 0C 
  SBC.B #$16                                      ; 059B9D E9 16 
  STA.W EntityYPx,X                                   ; 059B9F 9D 9C 0C 
  SEC                                             ; 059BA2 38 
  LDA.W EntityXPx,X                              ; 059BA3 BD 46 0B 
  SBC.B #$04                                      ; 059BA6 E9 04 
  BCS.B B_59BAC                                   ; 059BA8 B0 02 

.byte $A9,$00                                     ; 059BAB ..       ??

B_59BAC:
  STA.W EntityV32,X                                   ; 059BAC 9D 16 15 
  CLC                                             ; 059BAF 18 
  LDA.W EntityXPx,X                              ; 059BB0 BD 46 0B 
  ADC.B #$04                                      ; 059BB3 69 04 
  BCC.B B_59BB9                                   ; 059BB5 90 02 

.byte $A9,$FF                                     ; 059BB8 ..       ??

B_59BB9:
  STA.W EntityV33,X                                   ; 059BB9 9D 88 15 
  SEC                                             ; 059BBC 38 
  LDA.W EntityYPx,X                                   ; 059BBD BD 9C 0C 
  SBC.B #$04                                      ; 059BC0 E9 04 
  BCS.B B_59BC6                                   ; 059BC2 B0 02 

.byte $A9,$00                                     ; 059BC5 ..       ??

B_59BC6:
  STA.W EntityV34,X                                   ; 059BC6 9D FA 15 
  CLC                                             ; 059BC9 18 
  LDA.W EntityYPx,X                                   ; 059BCA BD 9C 0C 
  ADC.B #$04                                      ; 059BCD 69 04 
  BCC.B B_59BD3                                   ; 059BCF 90 02 

.byte $A9,$FF                                     ; 059BD2 ..       ??

B_59BD3:
  STA.W EntityV35,X                                   ; 059BD3 9D 6C 16 
  LDA.B #$00                                      ; 059BD6 A9 00 
  STA.W EntityV15,X                                   ; 059BD8 9D 80 0D 
  ASL                                             ; 059BDB 0A 
  TAY                                             ; 059BDC A8 
  PHB                                             ; 059BDD 8B 
  LDA.B #$03                                      ; 059BDE A9 03 
  PHA                                             ; 059BE0 48 
  PLB                                             ; 059BE1 AB 
  LDA.W D_384EE,Y                                 ; 059BE2 B9 EE 84 
  STA.W EntityV5,X                                   ; 059BE5 9D 0C 09 
  LDA.W D_384EF,Y                                 ; 059BE8 B9 EF 84 
  STA.W EntityV6,X                                   ; 059BEB 9D 7E 09 
  LDA.W D_3856E,Y                                 ; 059BEE B9 6E 85 
  STA.W EntityV7,X                                   ; 059BF1 9D F0 09 
  LDA.W D_3856F,Y                                 ; 059BF4 B9 6F 85 
  STA.W EntityV8,X                                   ; 059BF7 9D 62 0A 
  PLB                                             ; 059BFA AB 
  LDA.B #$42                                      ; 059BFB A9 42 
  STA.W EntityV29,X                                   ; 059BFD 9D BC 13 
  LDA.B #$23                                      ; 059C00 A9 23 
  STA.W EntityV30,X                                   ; 059C02 9D 2E 14 
  JSL L_AECB                                      ; 059C05 22 CB AE 00 
  TYA                                             ; 059C09 98 
  STA.W EntityV31,X                                   ; 059C0A 9D A0 14 
  LDA.B #$01                                      ; 059C0D A9 01 
  STA.W $175E,Y                                   ; 059C0F 99 5E 17 
  JSL L_AEF1                                      ; 059C12 22 F1 AE 00 
  PHX                                             ; 059C16 DA 
  REP.B #P_Idx8Bit                                      ; 059C17 C2 10 
  SEP.B #P_Acc8Bit                                      ; 059C19 E2 20 
  LDA.B #$07                                      ; 059C1B A9 07 
  LDX.W #$FF10                                    ; 059C1D A2 10 FF 
  JSL Audio_F830F                                     ; 059C20 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 059C24 E2 30 
  PLX                                             ; 059C26 FA 
  RTS                                             ; 059C27 60 

  LDA.W $05D6                                     ; 059C28 AD D6 05 
  BPL.B B_59C2E                                   ; 059C2B 10 01 

.byte $60                                         ; 059C2E .        `

B_59C2E:
  STZ.B $41,X                                     ; 059C2E 74 41 
  JSR.W L_59C43                                   ; 059C30 20 43 9C 
  JSL AdvanceRNG                                     ; 059C33 22 95 CA 0E 
  AND.B #$3F                                      ; 059C37 29 3F 
  CLC                                             ; 059C39 18 
  ADC.B #$40                                      ; 059C3A 69 40 
  STA.W DropTimer                   ; 059C3C 8D AE 05 
  JSR.W L_599F9                                   ; 059C3F 20 F9 99 
  RTS                                             ; 059C42 60 


L_59C43:
  LDY.B $1E                                       ; 059C43 A4 1E 
  LDA.W $05CC,Y                                   ; 059C45 B9 CC 05 
  BMI.B B_59C54                                   ; 059C48 30 0A 
  PHA                                             ; 059C4A 48 
  STZ.W EntityHeader,X                                   ; 059C4B 9E D2 06 
  JSR.W L_59C9D                                   ; 059C4E 20 9D 9C 
  PLX                                             ; 059C51 FA 
  BRA.B B_59C92                                   ; 059C52 80 3E 
B_59C54:
  LDA.B #$04                                      ; 059C54 A9 04 
  STA.W EntityTypeId,X                                   ; 059C56 9D 44 07 
  LDA.B #$00                                      ; 059C59 A9 00 
  STA.W EntityV3,X                                   ; 059C5B 9D 28 08 
  JSR.W L_59C9D                                   ; 059C5E 20 9D 9C 
  LDA.B $1E                                       ; 059C61 A5 1E 
  STA.W EntityV20,X                                   ; 059C63 9D BA 0F 
  TAY                                             ; 059C66 A8 
  TXA                                             ; 059C67 8A 
  STA.W $05CC,Y                                   ; 059C68 99 CC 05 
  LDA.B #$01                                      ; 059C6B A9 01 
  STA.W $18A9,Y                                   ; 059C6D 99 A9 18 
  JSL L_AEAF                                      ; 059C70 22 AF AE 00 
  TYA                                             ; 059C74 98 
  STA.W EntityV31,X                                   ; 059C75 9D A0 14 
  LDA.B #$01                                      ; 059C78 A9 01 
  STA.W $175E,Y                                   ; 059C7A 99 5E 17 
  JSL L_AEF1                                      ; 059C7D 22 F1 AE 00 
  JSL L_AEAF                                      ; 059C81 22 AF AE 00 
  TYA                                             ; 059C85 98 
  STA.W EntityV21,X                                   ; 059C86 9D 2C 10 
  LDA.B #$01                                      ; 059C89 A9 01 
  STA.W $175E,Y                                   ; 059C8B 99 5E 17 
  JSL L_AEF1                                      ; 059C8E 22 F1 AE 00 
B_59C92:
  LDA.B #$C8                                      ; 059C92 A9 C8 
  STA.W EntityV15,X                                   ; 059C94 9D 80 0D 
  LDA.B #$01                                      ; 059C97 A9 01 
  STA.W EntityV16,X                                   ; 059C99 9D F2 0D 
  RTS                                             ; 059C9C 60 


L_59C9D:
  PHX                                             ; 059C9D DA 
  LDY.W EntityV31,X                                   ; 059C9E BC A0 14 
  JSL L_AEF1                                      ; 059CA1 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 059CA5 BD A0 14 
  TAX                                             ; 059CA8 AA 
  STZ.W $175E,X                                   ; 059CA9 9E 5E 17 
  ASL                                             ; 059CAC 0A 
  ASL                                             ; 059CAD 0A 
  TAY                                             ; 059CAE A8 
  LDA.B #$F0                                      ; 059CAF A9 F0 
  BCC.B B_59CB8                                   ; 059CB1 90 05 
  STA.W $0409,Y                                   ; 059CB3 99 09 04 
  BRA.B B_59CBB                                   ; 059CB6 80 03 

B_59CB8:
.byte $99,$09,$03                                 ; 059CB9 ...      ???

B_59CBB:
  PLX                                             ; 059CBB FA 
  RTS                                             ; 059CBC 60 

  LDA.W $05D6                                     ; 059CBD AD D6 05 
  BPL.B B_59CC3                                   ; 059CC0 10 01 

.byte $60                                         ; 059CC3 .        `

B_59CC3:
  STZ.B $41,X                                     ; 059CC3 74 41 
  STZ.W EntityHeader,X                                   ; 059CC5 9E D2 06 
  PHX                                             ; 059CC8 DA 
  LDY.W EntityV31,X                                   ; 059CC9 BC A0 14 
  JSL L_AEF1                                      ; 059CCC 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 059CD0 BD A0 14 
  TAX                                             ; 059CD3 AA 
  STZ.W $175E,X                                   ; 059CD4 9E 5E 17 
  ASL                                             ; 059CD7 0A 
  ASL                                             ; 059CD8 0A 
  TAY                                             ; 059CD9 A8 
  LDA.B #$F0                                      ; 059CDA A9 F0 
  BCC.B B_59CE3                                   ; 059CDC 90 05 
  STA.W $0409,Y                                   ; 059CDE 99 09 04 
  BRA.B B_59CE6                                   ; 059CE1 80 03 

B_59CE3:
.byte $99,$09,$03                                 ; 059CE4 ...      ???

B_59CE6:
  PLX                                             ; 059CE6 FA 
  JSL AdvanceRNG                                     ; 059CE7 22 95 CA 0E 
  AND.B #$3F                                      ; 059CEB 29 3F 
  CLC                                             ; 059CED 18 
  ADC.B #$40                                      ; 059CEE 69 40 
  STA.W DropTimer                   ; 059CF0 8D AE 05 
  LDA.B #$19                                      ; 059CF3 A9 19 
  STA.W $05D7                                     ; 059CF5 8D D7 05 
  LDA.B #$64                                      ; 059CF8 A9 64 
  STA.W $1901                                     ; 059CFA 8D 01 19 
  LDX.B $1E                                       ; 059CFD A6 1E 
  INX                                             ; 059CFF E8 
  STX.W $05D6                                     ; 059D00 8E D6 05 
  JSL AdvanceRNG                                     ; 059D03 22 95 CA 0E 
  AND.B #$3F                                      ; 059D07 29 3F 
  CLC                                             ; 059D09 18 
  ADC.B #$40                                      ; 059D0A 69 40 
  STA.W DropTimer                   ; 059D0C 8D AE 05 
  PHX                                             ; 059D0F DA 
  REP.B #P_Idx8Bit                                      ; 059D10 C2 10 
  LDA.B #$07                                      ; 059D12 A9 07 
  LDX.W #$FF0E                                    ; 059D14 A2 0E FF 
  JSL Audio_F830F                                     ; 059D17 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 059D1B E2 30 
  JSL L_3803B                                     ; 059D1D 22 3B 80 03 
  PLX                                             ; 059D21 FA 
  RTS                                             ; 059D22 60 

  LDA.W $05D6                                     ; 059D23 AD D6 05 
  BPL.B B_59D29                                   ; 059D26 10 01 

.byte $60                                         ; 059D29 .        `

B_59D29:
  STZ.B $41,X                                     ; 059D29 74 41 
  STZ.W EntityHeader,X                                   ; 059D2B 9E D2 06 
  PHX                                             ; 059D2E DA 
  LDY.W EntityV31,X                                   ; 059D2F BC A0 14 
  JSL L_AEF1                                      ; 059D32 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 059D36 BD A0 14 
  TAX                                             ; 059D39 AA 
  STZ.W $175E,X                                   ; 059D3A 9E 5E 17 
  ASL                                             ; 059D3D 0A 
  ASL                                             ; 059D3E 0A 
  TAY                                             ; 059D3F A8 
  LDA.B #$F0                                      ; 059D40 A9 F0 
  BCC.B B_59D49                                   ; 059D42 90 05 
  STA.W $0409,Y                                   ; 059D44 99 09 04 
  BRA.B B_59D4C                                   ; 059D47 80 03 

B_59D49:
.byte $99,$09,$03                                 ; 059D4A ...      ???

B_59D4C:
  PLX                                             ; 059D4C FA 
  LDX.W $18D1                                     ; 059D4D AE D1 18 
  DEC.W $18C5,X                                   ; 059D50 DE C5 18 
  BNE.B B_59D5B                                   ; 059D53 D0 06 
  STZ.W $18C9,X                                   ; 059D55 9E C9 18 
  STZ.W $18C1,X                                   ; 059D58 9E C1 18 
B_59D5B:
  LDX.B $1E                                       ; 059D5B A6 1E 
  LDA.B #$FF                                      ; 059D5D A9 FF 
  STA.W $18AD,X                                   ; 059D5F 9D AD 18 
  JSL AdvanceRNG                                     ; 059D62 22 95 CA 0E 
  AND.B #$3F                                      ; 059D66 29 3F 
  CLC                                             ; 059D68 18 
  ADC.B #$40                                      ; 059D69 69 40 
  STA.W DropTimer                   ; 059D6B 8D AE 05 
  PHX                                             ; 059D6E DA 
  REP.B #P_Idx8Bit                                      ; 059D6F C2 10 
  LDA.B #$07                                      ; 059D71 A9 07 
  LDX.W #$FF10                                    ; 059D73 A2 10 FF 
  JSL Audio_F830F                                     ; 059D76 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 059D7A E2 30 
  PLX                                             ; 059D7C FA 
  RTS                                             ; 059D7D 60 

  LDA.W $05D6                                     ; 059D7E AD D6 05 
  BPL.B B_59D84                                   ; 059D81 10 01 

.byte $60                                         ; 059D84 .        `

B_59D84:
  LDA.B #$00                                      ; 059D84 A9 00 
  STA.W EntityV3,X                                   ; 059D86 9D 28 08 
  STZ.B $41,X                                     ; 059D89 74 41 
  LDA.B #$49                                      ; 059D8B A9 49 
  STA.W EntityTypeId,X                                   ; 059D8D 9D 44 07 
  LDA.W EntityXPx,X                              ; 059D90 BD 46 0B 
  STA.W $1ADF                                     ; 059D93 8D DF 1A 
  LDA.W EntityYPx,X                                   ; 059D96 BD 9C 0C 
  STA.W $1AE1                                     ; 059D99 8D E1 1A 
  LDA.B $1E                                       ; 059D9C A5 1E 
  STA.W EntityV20,X                                   ; 059D9E 9D BA 0F 
  TAY                                             ; 059DA1 A8 
  LDA.W D_59DF1,Y                                 ; 059DA2 B9 F1 9D 
  STA.W $1AE0                                     ; 059DA5 8D E0 1A 
  LDA.B #$1B                                      ; 059DA8 A9 1B 
  STA.W $1AE2                                     ; 059DAA 8D E2 1A 
  LDA.B #$00                                      ; 059DAD A9 00 
  STA.W $1AE3                                     ; 059DAF 8D E3 1A 
  LDA.B #$04                                      ; 059DB2 A9 04 
  STA.W $1AE4                                     ; 059DB4 8D E4 1A 
  PHX                                             ; 059DB7 DA 
  JSL L_18000                                     ; 059DB8 22 00 80 01 
  PLX                                             ; 059DBC FA 
  LDA.W $1AE5                                     ; 059DBD AD E5 1A 
  STA.W EntityV5,X                                   ; 059DC0 9D 0C 09 
  LDA.W $1AE6                                     ; 059DC3 AD E6 1A 
  STA.W EntityV6,X                                   ; 059DC6 9D 7E 09 
  LDA.W $1AE7                                     ; 059DC9 AD E7 1A 
  STA.W EntityV7,X                                   ; 059DCC 9D F0 09 
  LDA.W $1AE8                                     ; 059DCF AD E8 1A 
  STA.W EntityV8,X                                   ; 059DD2 9D 62 0A 
  JSL AdvanceRNG                                     ; 059DD5 22 95 CA 0E 
  AND.B #$3F                                      ; 059DD9 29 3F 
  CLC                                             ; 059DDB 18 
  ADC.B #$40                                      ; 059DDC 69 40 
  STA.W DropTimer                   ; 059DDE 8D AE 05 
  PHX                                             ; 059DE1 DA 
  REP.B #P_Idx8Bit                                      ; 059DE2 C2 10 
  LDA.B #$07                                      ; 059DE4 A9 07 
  LDX.W #$FF12                                    ; 059DE6 A2 12 FF 
  JSL Audio_F830F                                     ; 059DE9 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 059DED E2 30 
  PLX                                             ; 059DEF FA 
  RTS                                             ; 059DF0 60 


D_59DF1:
.byte $17,$E8                                     ; 059DF2 D.       ??

  LDA.W $05D6                                     ; 059DF3 AD D6 05 
  BPL.B B_59DF9                                   ; 059DF6 10 01 

.byte $60                                         ; 059DF9 .        `

B_59DF9:
  LDA.B #$00                                      ; 059DF9 A9 00 
  STA.W EntityV3,X                                   ; 059DFB 9D 28 08 
  STZ.B $41,X                                     ; 059DFE 74 41 
  LDA.B #$4A                                      ; 059E00 A9 4A 
  STA.W EntityTypeId,X                                   ; 059E02 9D 44 07 
  LDA.W EntityXPx,X                              ; 059E05 BD 46 0B 
  STA.W $1ADF                                     ; 059E08 8D DF 1A 
  LDA.W EntityYPx,X                                   ; 059E0B BD 9C 0C 
  STA.W $1AE1                                     ; 059E0E 8D E1 1A 
  LDA.B #$50                                      ; 059E11 A9 50 
  STA.B $A7                                       ; 059E13 85 A7 
  LDA.B #$12                                      ; 059E15 A9 12 
  STA.B $A8                                       ; 059E17 85 A8 
  STZ.B $A9                                       ; 059E19 64 A9 
  LDA.B $1E                                       ; 059E1B A5 1E 
  JSL IncreasePlayerScore                                      ; 059E1D 22 6D E4 00 
  LDA.B $1E                                       ; 059E21 A5 1E 
  STA.W EntityV20,X                                   ; 059E23 9D BA 0F 
  TAY                                             ; 059E26 A8 
  LDA.W D_59E76,Y                                 ; 059E27 B9 76 9E 
  STA.W $1AE0                                     ; 059E2A 8D E0 1A 
  LDA.B #$1B                                      ; 059E2D A9 1B 
  STA.W $1AE2                                     ; 059E2F 8D E2 1A 
  LDA.B #$00                                      ; 059E32 A9 00 
  STA.W $1AE3                                     ; 059E34 8D E3 1A 
  LDA.B #$04                                      ; 059E37 A9 04 
  STA.W $1AE4                                     ; 059E39 8D E4 1A 
  PHX                                             ; 059E3C DA 
  JSL L_18000                                     ; 059E3D 22 00 80 01 
  PLX                                             ; 059E41 FA 
  LDA.W $1AE5                                     ; 059E42 AD E5 1A 
  STA.W EntityV5,X                                   ; 059E45 9D 0C 09 
  LDA.W $1AE6                                     ; 059E48 AD E6 1A 
  STA.W EntityV6,X                                   ; 059E4B 9D 7E 09 
  LDA.W $1AE7                                     ; 059E4E AD E7 1A 
  STA.W EntityV7,X                                   ; 059E51 9D F0 09 
  LDA.W $1AE8                                     ; 059E54 AD E8 1A 
  STA.W EntityV8,X                                   ; 059E57 9D 62 0A 
  JSL AdvanceRNG                                     ; 059E5A 22 95 CA 0E 
  AND.B #$3F                                      ; 059E5E 29 3F 
  CLC                                             ; 059E60 18 
  ADC.B #$40                                      ; 059E61 69 40 
  STA.W DropTimer                   ; 059E63 8D AE 05 
  PHX                                             ; 059E66 DA 
  REP.B #P_Idx8Bit                                      ; 059E67 C2 10 
  LDA.B #$07                                      ; 059E69 A9 07 
  LDX.W #$FF16                                    ; 059E6B A2 16 FF 
  JSL Audio_F830F                                     ; 059E6E 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 059E72 E2 30 
  PLX                                             ; 059E74 FA 
  RTS                                             ; 059E75 60 


D_59E76:
.byte $17,$E8                                     ; 059E77 DD       ??

  LDA.W $05D6                                     ; 059E78 AD D6 05 
  BPL.B B_59E7E                                   ; 059E7B 10 01 
  RTS                                             ; 059E7D 60 

B_59E7E:
  LDA.B #$00                                      ; 059E7E A9 00 
  STA.W EntityV3,X                                   ; 059E80 9D 28 08 
  STZ.B $41,X                                     ; 059E83 74 41 
  LDA.B #$48                                      ; 059E85 A9 48 
  STA.W EntityTypeId,X                                   ; 059E87 9D 44 07 
  LDA.W EntityXPx,X                              ; 059E8A BD 46 0B 
  STA.W $1ADF                                     ; 059E8D 8D DF 1A 
  LDA.W EntityYPx,X                                   ; 059E90 BD 9C 0C 
  STA.W $1AE1                                     ; 059E93 8D E1 1A 
  LDA.W EntityV21,X                                   ; 059E96 BD 2C 10 
  BEQ.B B_59EAB                                   ; 059E99 F0 10 
  LDA.B #$10                                      ; 059E9B A9 10 
  STA.B $A7                                       ; 059E9D 85 A7 
  LDA.B #$50                                      ; 059E9F A9 50 
  STA.B $A8                                       ; 059EA1 85 A8 
  STZ.B $A9                                       ; 059EA3 64 A9 
  LDA.B $1E                                       ; 059EA5 A5 1E 
  JSL IncreasePlayerScore                                      ; 059EA7 22 6D E4 00 
B_59EAB:
  LDA.B $1E                                       ; 059EAB A5 1E 
  STA.W EntityV20,X                                   ; 059EAD 9D BA 0F 
  TAY                                             ; 059EB0 A8 
  LDA.W D_59F2D,Y                                 ; 059EB1 B9 2D 9F 
  STA.W $1AE0                                     ; 059EB4 8D E0 1A 
  LDA.B #$1B                                      ; 059EB7 A9 1B 
  STA.W $1AE2                                     ; 059EB9 8D E2 1A 
  LDA.B #$00                                      ; 059EBC A9 00 
  STA.W $1AE3                                     ; 059EBE 8D E3 1A 
  LDA.B #$05                                      ; 059EC1 A9 05 
  STA.W $1AE4                                     ; 059EC3 8D E4 1A 
  PHX                                             ; 059EC6 DA 
  JSL L_18000                                     ; 059EC7 22 00 80 01 
  PLX                                             ; 059ECB FA 
  LDA.W $1AE5                                     ; 059ECC AD E5 1A 
  STA.W EntityV5,X                                   ; 059ECF 9D 0C 09 
  LDA.W $1AE6                                     ; 059ED2 AD E6 1A 
  STA.W EntityV6,X                                   ; 059ED5 9D 7E 09 
  LDA.W $1AE7                                     ; 059ED8 AD E7 1A 
  STA.W EntityV7,X                                   ; 059EDB 9D F0 09 
  LDA.W $1AE8                                     ; 059EDE AD E8 1A 
  STA.W EntityV8,X                                   ; 059EE1 9D 62 0A 
  LDA.W CurrentRound                                     ; 059EE4 AD AB 05 
  CMP.B #$02                                      ; 059EE7 C9 02 
  BNE.B B_59EF2                                   ; 059EE9 D0 07 

.byte $AD,$AC,$05,$C9,$15,$F0,$0C                 ; 059EEC .......  ???????

B_59EF2:
  JSL AdvanceRNG                                     ; 059EF2 22 95 CA 0E 
  AND.B #$3F                                      ; 059EF6 29 3F 
  CLC                                             ; 059EF8 18 
  ADC.B #$40                                      ; 059EF9 69 40 
  STA.W $05AF                                     ; 059EFB 8D AF 05 
  LDA.B #$FF                                      ; 059EFE A9 FF 
  XBA                                             ; 059F00 EB 
  LDA.W EntityV23,X                                   ; 059F01 BD 10 11 
  ASL                                             ; 059F04 0A 
  ASL                                             ; 059F05 0A 
  STA.B $04                                       ; 059F06 85 04 
  JSL AdvanceRNG                                     ; 059F08 22 95 CA 0E 
  AND.B #$03                                      ; 059F0C 29 03 
  CLC                                             ; 059F0E 18 
  ADC.B $04                                       ; 059F0F 65 04 
  TAY                                             ; 059F11 A8 
  LDA.W D_59F25,Y                                 ; 059F12 B9 25 9F 
  PHX                                             ; 059F15 DA 
  REP.B #P_Idx8Bit                                      ; 059F16 C2 10 
  SEP.B #P_Acc8Bit                                      ; 059F18 E2 20 
  TAX                                             ; 059F1A AA 
  LDA.B #$07                                      ; 059F1B A9 07 
  JSL Audio_F830F                                     ; 059F1D 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 059F21 E2 30 
  PLX                                             ; 059F23 FA 
  RTS                                             ; 059F24 60 


D_59F25:
.byte $04,$04,$04,$04,$0F,$0E,$0F,$10             ; 059F25 DDDDD.DD ????????
D_59F2D:
.byte $17,$E8,$60,$60,$60,$60,$60,$60             ; 059F2D DD...... ??``````
.byte $AD,$D6,$05,$10,$01,$60                     ; 059F36 ......   ?????`

  LDA.B #$00                                      ; 059F3B A9 00 
  STA.W EntityV3,X                                   ; 059F3D 9D 28 08 
  STZ.B $41,X                                     ; 059F40 74 41 
  LDA.B #$4D                                      ; 059F42 A9 4D 
  STA.W EntityTypeId,X                                   ; 059F44 9D 44 07 
  LDA.W EntityXPx,X                              ; 059F47 BD 46 0B 
  STA.W $1ADF                                     ; 059F4A 8D DF 1A 
  LDA.W EntityYPx,X                                   ; 059F4D BD 9C 0C 
  STA.W $1AE1                                     ; 059F50 8D E1 1A 
  LDA.B $1E                                       ; 059F53 A5 1E 
  STA.W EntityV20,X                                   ; 059F55 9D BA 0F 
  TAY                                             ; 059F58 A8 
  LDA.W D_59FAC,Y                                 ; 059F59 B9 AC 9F 
  STA.W $1AE0                                     ; 059F5C 8D E0 1A 
  LDA.B #$1B                                      ; 059F5F A9 1B 
  STA.W $1AE2                                     ; 059F61 8D E2 1A 
  LDA.B #$00                                      ; 059F64 A9 00 
  STA.W $1AE3                                     ; 059F66 8D E3 1A 
  LDA.B #$06                                      ; 059F69 A9 06 
  STA.W $1AE4                                     ; 059F6B 8D E4 1A 
  PHX                                             ; 059F6E DA 
  JSL L_18000                                     ; 059F6F 22 00 80 01 
  PLX                                             ; 059F73 FA 
  LDA.W $1AE5                                     ; 059F74 AD E5 1A 
  STA.W EntityV5,X                                   ; 059F77 9D 0C 09 
  LDA.W $1AE6                                     ; 059F7A AD E6 1A 
  STA.W EntityV6,X                                   ; 059F7D 9D 7E 09 
  LDA.W $1AE7                                     ; 059F80 AD E7 1A 
  STA.W EntityV7,X                                   ; 059F83 9D F0 09 
  LDA.W $1AE8                                     ; 059F86 AD E8 1A 
  STA.W EntityV8,X                                   ; 059F89 9D 62 0A 
  LDA.B #$25                                      ; 059F8C A9 25 
  STA.B $A7                                       ; 059F8E 85 A7 
  LDA.B #$01                                      ; 059F90 A9 01 
  STA.B $A8                                       ; 059F92 85 A8 
  LDA.B #$01                                      ; 059F94 A9 01 
  STA.B $A9                                       ; 059F96 85 A9 
  LDA.B $1E                                       ; 059F98 A5 1E 
  JSL IncreasePlayerScore                                      ; 059F9A 22 6D E4 00 
  REP.B #P_Idx8Bit                                      ; 059F9E C2 10 
  LDA.B #$07                                      ; 059FA0 A9 07 
  LDX.W #$FF0F                                    ; 059FA2 A2 0F FF 
  JSL Audio_F830F                                     ; 059FA5 22 0F 83 0F 
  SEP.B #P_Idx8Bit                                      ; 059FA9 E2 10 
  RTS                                             ; 059FAB 60 


D_59FAC:
.byte $17,$E8,$60,$60,$AD,$72,$18,$F0             ; 059FAC D....... ??``?r??
.byte $0E,$20,$ED,$8C,$CE,$F1,$18,$D0             ; 059FB4 ........ ? ??????
.byte $05,$A9,$FF,$8D,$D4,$05,$60,$A4             ; 059FBC ........ ??????`?
.byte $1E,$B9,$6E,$10,$A8,$18,$BD,$46             ; 059FC4 ........ ??n????F
.byte $0B,$79,$E1,$9F,$9D,$46,$0B,$18             ; 059FCC ........ ?y???F??
.byte $BD,$9C,$0C,$79,$E9,$9F,$9D,$9C             ; 059FD4 ........ ???y????
.byte $0C,$20,$26,$89,$60,$00,$04,$04             ; 059FDC ........ ? &?`???
.byte $04,$00,$FC,$FC,$FC,$04,$04,$00             ; 059FE4 ........ ????????
.byte $FC,$FC,$FC,$00,$04,$20,$ED,$8C             ; 059FEC ........ ????? ??
.byte $CE,$F1,$18,$D0,$05,$A9,$FF,$8D             ; 059FF4 ........ ????????
.byte $D4,$05,$A9,$2A,$20,$44,$88,$60             ; 059FFC ........ ???* D?`
.byte $60,$60,$20,$90,$8B,$F0,$3A,$74             ; 05A004 ........ `` ???:t
.byte $41,$CE,$E7,$18,$CE,$C6,$06,$DA             ; 05A00C ........ A???????
.byte $AE,$DE,$18,$DE,$C5,$18,$D0,$06             ; 05A014 ........ ????????
.byte $9E,$C9,$18,$9E,$C1,$18,$FA,$64             ; 05A01C ........ ???????d
.byte $A7,$A9,$10,$85,$A8,$64,$A9,$AD             ; 05A024 ........ ?????d??
.byte $72,$18,$D0,$19,$A4,$1E,$B9,$FC             ; 05A02C ........ r???????
.byte $0F,$22,$6D,$E4,$00,$B9,$86,$07             ; 05A034 ........ ?"m?????
.byte $A8,$B9,$24,$A0,$D0,$0D,$20,$95             ; 05A03C ........ ??$??? ?
.byte $8D,$20,$AD,$88,$60,$A5,$1E,$22             ; 05A044 ........ ? ??`??"
.byte $6D,$E4,$00,$20,$ED,$8C,$20,$AD             ; 05A04C ........ m?? ?? ?
.byte $88,$60,$00,$00,$01,$01,$00,$00             ; 05A054 ........ ?`??????
.byte $A5,$D2,$29,$0F,$D0,$05,$A9,$2A             ; 05A05C ........ ??)????*
.byte $20,$44,$88,$60,$60,$60                     ; 05A065 ......    D?```

  JSR.W L_58B90                                   ; 05A06A 20 90 8B 
  BEQ.B B_5A0DF                                   ; 05A06D F0 70 
  STZ.B $41,X                                     ; 05A06F 74 41 
  DEC.W $18EB                                     ; 05A071 CE EB 18 
  DEC.W $06C6                                     ; 05A074 CE C6 06 
  PHX                                             ; 05A077 DA 
  LDX.W $18DF                                     ; 05A078 AE DF 18 
  DEC.W $18C5,X                                   ; 05A07B DE C5 18 
  BNE.B B_5A086                                   ; 05A07E D0 06 

.byte $9E,$C9,$18,$9E,$C1,$18                     ; 05A081 ......   ??????

B_5A086:
  PLX                                             ; 05A086 FA 
  STX.B $04                                       ; 05A087 86 04 
  STZ.B $A7                                       ; 05A089 64 A7 
  STZ.B $A8                                       ; 05A08B 64 A8 
  LDA.B #$02                                      ; 05A08D A9 02 
  STA.B $A9                                       ; 05A08F 85 A9 
  LDA.W $1872                                     ; 05A091 AD 72 18 
  BNE.B B_5A0AE                                   ; 05A094 D0 18 
  LDY.B $1E                                       ; 05A096 A4 1E 
  LDA.W EntityV20+Projectiles,Y                                   ; 05A098 B9 FC 0F 
  JSL IncreasePlayerScore                                      ; 05A09B 22 6D E4 00 
  LDA.W EntityTypeId+Projectiles,Y                                   ; 05A09F B9 86 07 
  TAY                                             ; 05A0A2 A8 
  LDA.W D_5A0B1,Y                                 ; 05A0A3 B9 B1 A0 
  BNE.B B_5A0B4                                   ; 05A0A6 D0 0C 
  JSR.W L_58D5D                                   ; 05A0A8 20 5D 8D 
  JMP.W D_5A0B7                                   ; 05A0AB 4C B7 A0 

B_5A0AE:
.byte $A5,$1E,$22                                 ; 05A0AF ...      ??"
D_5A0B1:
.byte $6D,$E4,$00                                 ; 05A0B2 ...      m??

B_5A0B4:
  JSR.W L_58CED                                   ; 05A0B4 20 ED 8C 
D_5A0B7:
  LDX.B #$3F                                      ; 05A0B7 A2 3F 
B_5A0B9:
  LDA.W EntityHeader+2,X                         ; 05A0B9 BD D4 06 
  BEQ.B B_5A0DC                                   ; 05A0BC F0 1E 
  LDA.W EntityTypeId+2,X                                   ; 05A0BE BD 46 07 
  CMP.B #$55                                      ; 05A0C1 C9 55 
  BNE.B B_5A0DC                                   ; 05A0C3 D0 17 
  LDA.W EntityV20+2,X                                   ; 05A0C5 BD BC 0F 
  CMP.B $04                                       ; 05A0C8 C5 04 
  BNE.B B_5A0DC                                   ; 05A0CA D0 10 
  JSL AdvanceRNG                                     ; 05A0CC 22 95 CA 0E 
  AND.B #$1F                                      ; 05A0D0 29 1F 
  ADC.B #$20                                      ; 05A0D2 69 20 
  STA.W EntityV15+2,X                                   ; 05A0D4 9D 82 0D 
  LDA.B #$56                                      ; 05A0D7 A9 56 
  STA.W EntityTypeId+2,X                                   ; 05A0D9 9D 46 07 
B_5A0DC:
  DEX                                             ; 05A0DC CA 
  BPL.B B_5A0B9                                   ; 05A0DD 10 DA 
B_5A0DF:
  JSR.W L_588AD                                   ; 05A0DF 20 AD 88 
  RTS                                             ; 05A0E2 60 


.byte $00,$00,$01,$01,$00,$00,$A5,$D2             ; 05A0E3 D.D..... ????????
.byte $29,$0F,$D0,$05,$A9,$2A,$20,$44             ; 05A0EB ........ )????* D
.byte $88,$60                                     ; 05A0F4 ..       ?`

  JSR.W L_58B90                                   ; 05A0F5 20 90 8B 
  BNE.B B_5A0FD                                   ; 05A0F8 D0 03 

.byte $4C,$4E,$A1                                 ; 05A0FB ...      LN?

B_5A0FD:
  STZ.B $41,X                                     ; 05A0FD 74 41 
  DEC.W $06C6                                     ; 05A0FF CE C6 06 
  PHX                                             ; 05A102 DA 
  LDX.W $18DF                                     ; 05A103 AE DF 18 
  DEC.W $18C5,X                                   ; 05A106 DE C5 18 
  BNE.B B_5A111                                   ; 05A109 D0 06 

.byte $9E,$C9,$18,$9E,$C1,$18                     ; 05A10C ......   ??????

B_5A111:
  PLX                                             ; 05A111 FA 
  LDA.B #$50                                      ; 05A112 A9 50 
  STA.B $A7                                       ; 05A114 85 A7 
  LDA.B #$20                                      ; 05A116 A9 20 
  STA.B $A8                                       ; 05A118 85 A8 
  STZ.B $A9                                       ; 05A11A 64 A9 
  LDA.W $1872                                     ; 05A11C AD 72 18 
  BNE.B B_5A139                                   ; 05A11F D0 18 
  LDY.B $1E                                       ; 05A121 A4 1E 
  LDA.W EntityV20+Projectiles,Y                                   ; 05A123 B9 FC 0F 
  JSL IncreasePlayerScore                                      ; 05A126 22 6D E4 00 
  LDA.W EntityTypeId+Projectiles,Y                                   ; 05A12A B9 86 07 
  TAY                                             ; 05A12D A8 
  LDA.W D_5A153-$32,Y                                 ; 05A12E B9 20 A1 
  BNE.B B_5A13F                                   ; 05A131 D0 0C 
  JSR.W L_58D5D                                   ; 05A133 20 5D 8D 
  JMP.W D_5A142                                   ; 05A136 4C 42 A1 

B_5A139:
.byte $A5,$1E,$22,$6D,$E4,$00                     ; 05A13A ......   ??"m??
B_5A13F:
.byte $20,$ED,$8C                                 ; 05A140 ...       ??

D_5A142:
  LDA.B #$08                                      ; 05A142 A9 08 
  STA.B $1C                                       ; 05A144 85 1C 
  LDA.B #$08                                      ; 05A146 A9 08 
  STA.B $1D                                       ; 05A148 85 1D 
  JSL L_AFC2                                      ; 05A14A 22 C2 AF 00 
  JSR.W L_588AD                                   ; 05A14E 20 AD 88 
  RTS                                             ; 05A151 60 

D_5A153:
.byte $00,$00,$01,$01,$00,$00                     ; 05A153 D.....   ??????

  JSR.W L_58B90                                   ; 05A158 20 90 8B 
  BEQ.B B_5A188                                   ; 05A15B F0 2B 
  STZ.B $41,X                                     ; 05A15D 74 41 
  DEC.W $06C6                                     ; 05A15F CE C6 06 
  PHX                                             ; 05A162 DA 
  LDX.W $18DF                                     ; 05A163 AE DF 18 
  DEC.W $18C5,X                                   ; 05A166 DE C5 18 
  BNE.B B_5A171                                   ; 05A169 D0 06 

.byte $9E,$C9,$18,$9E,$C1,$18                     ; 05A16C ......   ??????

B_5A171:
  PLX                                             ; 05A171 FA 
  LDY.W EntityV31,X                                   ; 05A172 BC A0 14 
  JSL L_AEF1                                      ; 05A175 22 F1 AE 00 
  JSR.W L_58D5D                                   ; 05A179 20 5D 8D 
  LDA.B #$08                                      ; 05A17C A9 08 
  STA.B $1C                                       ; 05A17E 85 1C 
  LDA.B #$08                                      ; 05A180 A9 08 
  STA.B $1D                                       ; 05A182 85 1D 
  JSL L_AFC2                                      ; 05A184 22 C2 AF 00 
B_5A188:
  JSR.W L_588AD                                   ; 05A188 20 AD 88 
  RTS                                             ; 05A18B 60 


.byte $60,$60,$AD,$D6,$05,$10,$01,$60             ; 05A18C ........ ``?????`
.byte $A9,$00,$9D,$28,$08,$74,$41,$A9             ; 05A194 ........ ???(?tA?
.byte $57,$9D,$44,$07,$BD,$46,$0B,$8D             ; 05A19C ........ W?D??F??
.byte $DF,$1A,$BD,$9C,$0C,$8D,$E1,$1A             ; 05A1A4 ........ ????????
.byte $A9,$25,$85,$A7,$A9,$10,$85,$A8             ; 05A1AC ........ ?%??????
.byte $64,$A9,$A5,$1E,$22,$6D,$E4,$00             ; 05A1B4 ........ d???"m??
.byte $A5,$1E,$9D,$BA,$0F,$A8,$B9,$03             ; 05A1BC ........ ????????
.byte $A2,$8D,$E0,$1A,$A9,$1B,$8D,$E2             ; 05A1C4 ........ ????????
.byte $1A,$A9,$00,$8D,$E3,$1A,$A9,$05             ; 05A1CC ........ ????????
.byte $8D,$E4,$1A,$DA,$22,$00,$80,$01             ; 05A1D4 ........ ????"???
.byte $FA,$AD,$E5,$1A,$9D,$0C,$09,$AD             ; 05A1DC ........ ????????
.byte $E6,$1A,$9D,$7E,$09,$AD,$E7,$1A             ; 05A1E4 ........ ???~????
.byte $9D,$F0,$09,$AD,$E8,$1A,$9D,$62             ; 05A1EC ........ ???????b
.byte $0A,$C2,$10,$A9,$07,$A2,$04,$FF             ; 05A1F4 ........ ????????
.byte $22,$0F,$83,$0F,$E2,$10,$60,$17             ; 05A1FC ........ "?????`?
.byte $E8,$60,$60,$60,$60,$20,$90,$8B             ; 05A204 ........ ?```` ??
.byte $F0,$4F,$74,$41,$CE,$E8,$18,$CE             ; 05A20C ........ ?OtA????
.byte $C6,$06,$DA,$BD,$9E,$10,$F0,$10             ; 05A214 ........ ????????
.byte $AE,$D4,$18,$DE,$C5,$18,$D0,$16             ; 05A21C ........ ????????
.byte $9E,$C9,$18,$9E,$C1,$18,$80,$0E             ; 05A224 ........ ????????
.byte $AE,$D3,$18,$DE,$C5,$18,$D0,$06             ; 05A22C ........ ????????
.byte $9E,$C9,$18,$9E,$C1,$18,$FA,$64             ; 05A234 ........ ???????d
.byte $A7,$A9,$10,$85,$A8,$64,$A9,$AD             ; 05A23C ........ ?????d??
.byte $72,$18,$D0,$19,$A4,$1E,$B9,$FC             ; 05A244 ........ r???????
.byte $0F,$22,$6D,$E4,$00,$B9,$86,$07             ; 05A24C ........ ?"m?????
.byte $A8,$B9,$3C,$A2,$D0,$0D,$20,$BE             ; 05A254 ........ ??<??? ?
.byte $8D,$20,$AD,$88,$60,$A5,$1E,$22             ; 05A25C ........ ? ??`??"
.byte $6D,$E4,$00,$20,$ED,$8C,$20,$AD             ; 05A264 ........ m?? ?? ?
.byte $88,$60,$00,$00,$01,$01,$00,$00             ; 05A26C ........ ?`??????
.byte $9E,$0C,$09,$9E,$7E,$09,$9E,$F0             ; 05A274 ........ ????~???
.byte $09,$9E,$62,$0A,$A9,$01,$9D,$4A             ; 05A27C ........ ??b????J
.byte $13,$A9,$FF,$9D,$D8,$12,$BC,$10             ; 05A284 ........ ????????
.byte $11,$B9,$94,$A2,$9D,$44,$07,$60             ; 05A28C ........ ?????D?`
.byte $5D,$5D,$5D,$5E,$5E,$5E,$5D,$5D             ; 05A294 ........ ]]]^^^]]
.byte $A5,$D2,$29,$1F,$D0,$24,$A4,$1E             ; 05A29C ........ ??)??$??
.byte $BD,$10,$11,$F0,$18,$C9,$04,$F0             ; 05A2A4 ........ ????????
.byte $14,$B0,$0A,$BD,$46,$0B,$D9,$46             ; 05A2AC ........ ????F??F
.byte $0B,$90,$0A,$80,$0D,$BD,$46,$0B             ; 05A2B4 ........ ??????F?
.byte $D9,$46,$0B,$90,$05,$A9,$2A,$20             ; 05A2BC ........ ?F????* 
.byte $44,$88,$60,$60,$60,$60,$60,$60             ; 05A2C4 ........ D?``````
.byte $60,$60,$60,$18,$6D,$9A,$06,$8D             ; 05A2CC ........ ```?m???
.byte $9A,$06,$AD,$9B,$06,$69,$00,$8D             ; 05A2D4 ........ ?????i??
.byte $9B,$06,$AD,$9C,$06,$0A,$A8,$AD             ; 05A2DC ........ ????????
.byte $9A,$06,$D9,$FB,$A2,$AD,$9B,$06             ; 05A2E4 ........ ????????
.byte $F9,$FC,$A2,$90,$09,$9C,$9A,$06             ; 05A2EC ........ ????????
.byte $9C,$9B,$06,$EE,$9C,$06,$60,$60             ; 05A2F4 ........ ??????``
.byte $05,$10,$00,$FF,$FF,$60,$20,$12             ; 05A2FC ........ ?????` ?
.byte $8C,$F0,$4D,$20,$CF,$A2,$BD,$D2             ; 05A304 ........ ??M ????
.byte $06,$29,$40,$D0,$0B,$BD,$66,$12             ; 05A30C ........ ?)@???f?
.byte $C9,$01,$F0,$0F,$C9,$02,$F0,$0B             ; 05A314 ........ ????????
.byte $22,$95,$CA,$0E,$29,$01,$1A,$22             ; 05A31C ........ "???)??"
.byte $3C,$82,$03,$A4,$1E,$B9,$6E,$10             ; 05A324 ........ <?????n?
.byte $0A,$A8,$18,$BD,$0C,$09,$79,$58             ; 05A32C ........ ??????yX
.byte $A3,$9D,$0C,$09,$BD,$7E,$09,$79             ; 05A334 ........ ?????~?y
.byte $59,$A3,$9D,$7E,$09,$18,$BD,$F0             ; 05A33C ........ Y??~????
.byte $09,$79,$68,$A3,$9D,$F0,$09,$BD             ; 05A344 ........ ?yh?????
.byte $62,$0A,$79,$69,$A3,$9D,$62,$0A             ; 05A34C ........ b?yi??b?
.byte $20,$26,$89,$60,$00,$00,$00,$01             ; 05A354 ........  &?`????
.byte $00,$01,$00,$01,$00,$00,$00,$FF             ; 05A35C ........ ????????
.byte $00,$FF,$00,$FF,$00,$01,$00,$01             ; 05A364 ........ ????????
.byte $00,$00,$00,$FF,$00,$FF,$00,$FF             ; 05A36C ........ ????????
.byte $00,$00,$00,$01,$BD,$9C,$0C,$C9             ; 05A374 ........ ????????
.byte $8C,$90,$05,$A9,$2B,$20,$44,$88             ; 05A37C ........ ????+ D?
.byte $60,$20,$12,$8C,$F0,$2A,$20,$CF             ; 05A384 ........ ` ???* ?
.byte $A2,$A4,$1E,$B9,$6E,$10,$A8,$18             ; 05A38C ........ ????n???
.byte $BD,$46,$0B,$79,$B8,$A3,$9D,$46             ; 05A394 ........ ?F?y???F
.byte $0B,$18,$BD,$9C,$0C,$79,$C0,$A3             ; 05A39C ........ ?????y??
.byte $9D,$9C,$0C,$A9,$02,$9D,$F2,$0D             ; 05A3A4 ........ ????????
.byte $BD,$2E,$14,$29,$F1,$9D,$2E,$14             ; 05A3AC ........ ?.?)??.?
.byte $20,$26,$89,$60,$00,$0A,$0A,$0A             ; 05A3B4 ........  &?`????
.byte $00,$F6,$F6,$F6,$0A,$0A,$00,$F6             ; 05A3BC ........ ????????
.byte $F6,$F6,$00,$0A,$A9,$2B,$20,$44             ; 05A3C4 ........ ?????+ D
.byte $88,$60,$20,$12,$8C,$F0,$38,$20             ; 05A3CC ........ ?` ???8 
.byte $CF,$A2,$BD,$D2,$06,$29,$40,$D0             ; 05A3D4 ........ ?????)@?
.byte $0B,$BD,$66,$12,$C9,$01,$F0,$0F             ; 05A3DC ........ ??f?????
.byte $C9,$02,$F0,$0B,$22,$95,$CA,$0E             ; 05A3E4 ........ ????"???
.byte $29,$01,$1A,$22,$3C,$82,$03,$A9             ; 05A3EC ........ )??"<???
.byte $64,$9D,$44,$07,$A9,$10,$9D,$80             ; 05A3F4 ........ d?D?????
.byte $0D,$22,$95,$CA,$0E,$18,$69,$20             ; 05A3FC ........ ?"????i 
.byte $90,$02,$A9,$FF,$9D,$F2,$0D,$20             ; 05A404 ........ ??????? 
.byte $26,$89,$60,$BD,$9C,$0C,$C9,$8C             ; 05A40C ........ &?`?????
.byte $90,$05,$A9,$2B,$20,$44,$88,$60             ; 05A414 ........ ???+ D?`
.byte $60,$60,$60,$60,$60,$BD,$9C,$0C             ; 05A41C ........ `````???
.byte $C9,$8C,$90,$05,$A9,$2B,$20,$44             ; 05A424 ........ ?????+ D
.byte $88,$60,$60,$A9,$2B,$20,$44,$88             ; 05A42C ........ ?``?+ D?
.byte $60,$60,$60,$60,$60,$60,$60                 ; 05A435 .......  ```````


L_5A43B:
  CLC                                             ; 05A43B 18 
  ADC.W XexzyMutoidHealth                         ; 05A43C 6D 9A 06 
  STA.W XexzyMutoidHealth                         ; 05A43F 8D 9A 06 
  LDA.W $069B                                     ; 05A442 AD 9B 06 
  ADC.B #$00                                      ; 05A445 69 00 
  STA.W $069B                                     ; 05A447 8D 9B 06 
  JSL AdvanceRNG                                     ; 05A44A 22 95 CA 0E 
  CMP.B #$10                                      ; 05A44E C9 10 
  BCS.B B_5A46C                                   ; 05A450 B0 1A 
  PHX                                             ; 05A452 DA 
  REP.B #P_Idx8Bit                                      ; 05A453 C2 10 
  LDA.B #$00                                      ; 05A455 A9 00 
  XBA                                             ; 05A457 EB 
  JSL AdvanceRNG                                     ; 05A458 22 95 CA 0E 
  AND.B #$03                                      ; 05A45C 29 03 
  ASL                                             ; 05A45E 0A 
  TAY                                             ; 05A45F A8 
  LDX.W D_5A46D,Y                                 ; 05A460 BE 6D A4 
  LDA.B #$07                                      ; 05A463 A9 07 
  JSL Audio_F830F                                     ; 05A465 22 0F 83 0F 
  SEP.B #P_Idx8Bit                                      ; 05A469 E2 10 
  PLX                                             ; 05A46B FA 
B_5A46C:
  RTS                                             ; 05A46C 60 


D_5A46D:
.byte $25,$FF,$2B,$FF,$2B,$FF,$2B,$FF             ; 05A46D DDDDDDDD %?+?+?+?
.byte $18,$6D,$B1,$06,$8D,$B1,$06,$90             ; 05A475 ........ ?m??????
.byte $0D,$9C,$B1,$06,$AD,$B0,$06,$C9             ; 05A47D ........ ????????
.byte $07,$F0,$03,$EE,$B0,$06,$48,$22             ; 05A485 ........ ??????H"
.byte $95,$CA,$0E,$29,$0F,$D0,$0F,$DA             ; 05A48D ........ ???)????
.byte $C2,$10,$A9,$07,$A2,$2B,$FF,$22             ; 05A495 ........ ?????+?"
.byte $0F,$83,$0F,$E2,$10,$FA,$68,$60             ; 05A49D ........ ??????h`


L_5A4A5:
  LDA.B $26                                       ; 05A4A5 A5 26 
  BNE.B B_5A4B2                                   ; 05A4A7 D0 09 
  LDA.W EntityV2,X                                   ; 05A4A9 BD B6 07 
  AND.B #$F1                                      ; 05A4AC 29 F1 
  STA.W $0697                                     ; 05A4AE 8D 97 06 
  RTS                                             ; 05A4B1 60 

B_5A4B2:
  LDA.W EntityV2,X                                   ; 05A4B2 BD B6 07 
  AND.B #$F1                                      ; 05A4B5 29 F1 
  STA.W $0698                                     ; 05A4B7 8D 98 06 
  RTS                                             ; 05A4BA 60 


.byte $60,$60,$60,$60,$60,$60,$60,$60             ; 05A4BB ........ ````````
.byte $60,$60                                     ; 05A4C4 ..       ``

  JSR.W L_58BC4                                   ; 05A4C5 20 C4 8B 
  BEQ.B B_5A4F0                                   ; 05A4C8 F0 26 
  JSR.W L_5A43B                                   ; 05A4CA 20 3B A4 
  LDA.B #$19                                      ; 05A4CD A9 19 
  STA.W $0699                                     ; 05A4CF 8D 99 06 
  LDA.B #$50                                      ; 05A4D2 A9 50 
  STA.B $A7                                       ; 05A4D4 85 A7 
  LDA.B #$03                                      ; 05A4D6 A9 03 
  STA.B $A8                                       ; 05A4D8 85 A8 
  STZ.B $A9                                       ; 05A4DA 64 A9 
  LDY.B $1E                                       ; 05A4DC A4 1E 
  LDA.W EntityV20+Projectiles,Y                                   ; 05A4DE B9 FC 0F 
  PHA                                             ; 05A4E1 48 
  JSL IncreasePlayerScore                                      ; 05A4E2 22 6D E4 00 
  PLA                                             ; 05A4E6 68 
  LDY.W $069E                                     ; 05A4E7 AC 9E 06 
  BEQ.B B_5A4F0                                   ; 05A4EA F0 04 

.byte $22,$6D,$E4,$00                             ; 05A4ED ....     "m??

B_5A4F0:
  JSR.W L_58A15                                   ; 05A4F0 20 15 8A 
  RTS                                             ; 05A4F3 60 

  RTS                                             ; 05A4F4 60 

  JSR.W L_58BC4                                   ; 05A4F5 20 C4 8B 
  BEQ.B B_5A520                                   ; 05A4F8 F0 26 
  JSR.W L_5A43B                                   ; 05A4FA 20 3B A4 
  LDA.B #$19                                      ; 05A4FD A9 19 
  STA.W $0699                                     ; 05A4FF 8D 99 06 
  LDA.B #$50                                      ; 05A502 A9 50 
  STA.B $A7                                       ; 05A504 85 A7 
  LDA.B #$03                                      ; 05A506 A9 03 
  STA.B $A8                                       ; 05A508 85 A8 
  STZ.B $A9                                       ; 05A50A 64 A9 
  LDY.B $1E                                       ; 05A50C A4 1E 
  LDA.W EntityV20+Projectiles,Y                                   ; 05A50E B9 FC 0F 
  PHA                                             ; 05A511 48 
  JSL IncreasePlayerScore                                      ; 05A512 22 6D E4 00 
  PLA                                             ; 05A516 68 
  LDY.W $069E                                     ; 05A517 AC 9E 06 
  BEQ.B B_5A520                                   ; 05A51A F0 04 

.byte $22,$6D,$E4,$00                             ; 05A51D ....     "m??

B_5A520:
  JSR.W L_58A15                                   ; 05A520 20 15 8A 
  RTS                                             ; 05A523 60 

  RTS                                             ; 05A524 60 


.byte $60,$60                                     ; 05A526 ..       ``

  RTS                                             ; 05A527 60 

  LDA.B #$2B                                      ; 05A528 A9 2B 
  JSR.W L_58844                                   ; 05A52A 20 44 88 
  RTS                                             ; 05A52D 60 

  LDA.W $1872                                     ; 05A52E AD 72 18 
  BNE.B B_5A565                                   ; 05A531 D0 32 
  JSR.W L_58BC4                                   ; 05A533 20 C4 8B 
  BEQ.B B_5A561                                   ; 05A536 F0 29 
  JSR.W L_5A43B                                   ; 05A538 20 3B A4 
  LDA.B #$1E                                      ; 05A53B A9 1E 
  STA.W $0699                                     ; 05A53D 8D 99 06 
  JSR.W L_5A4A5                                   ; 05A540 20 A5 A4 
  LDA.B #$50                                      ; 05A543 A9 50 
  STA.B $A7                                       ; 05A545 85 A7 
  LDA.B #$03                                      ; 05A547 A9 03 
  STA.B $A8                                       ; 05A549 85 A8 
  STZ.B $A9                                       ; 05A54B 64 A9 
  LDY.B $1E                                       ; 05A54D A4 1E 
  LDA.W EntityV20+Projectiles,Y                                   ; 05A54F B9 FC 0F 
  PHA                                             ; 05A552 48 
  JSL IncreasePlayerScore                                      ; 05A553 22 6D E4 00 
  PLA                                             ; 05A557 68 
  LDY.W $069E                                     ; 05A558 AC 9E 06 
  BEQ.B B_5A561                                   ; 05A55B F0 04 

.byte $22,$6D,$E4,$00                             ; 05A55E ....     "m??

B_5A561:
  JSR.W L_58A15                                   ; 05A561 20 15 8A 
  RTS                                             ; 05A564 60 

B_5A565:
  SEC                                             ; 05A565 38 
  LDA.W EntityXPx,X                              ; 05A566 BD 46 0B 
  SBC.B #$1C                                      ; 05A569 E9 1C 
  STA.B $06                                       ; 05A56B 85 06 
  CLC                                             ; 05A56D 18 
  LDA.W EntityXPx,X                              ; 05A56E BD 46 0B 
  ADC.B #$1C                                      ; 05A571 69 1C 
  STA.B $07                                       ; 05A573 85 07 
  SEC                                             ; 05A575 38 
  LDA.W EntityYPx,X                                   ; 05A576 BD 9C 0C 
  SBC.B #$06                                      ; 05A579 E9 06 
  STA.B $04                                       ; 05A57B 85 04 
  CLC                                             ; 05A57D 18 
  LDA.W EntityYPx,X                                   ; 05A57E BD 9C 0C 
  ADC.B #$36                                      ; 05A581 69 36 
  STA.B $05                                       ; 05A583 85 05 
  LDY.B $1E                                       ; 05A585 A4 1E 
  LDA.W EntityXPx,Y                              ; 05A587 B9 46 0B 
  CMP.B $06                                       ; 05A58A C5 06 
  BCS.B B_5A595                                   ; 05A58C B0 07 
  SEC                                             ; 05A58E 38 
  SBC.B #$02                                      ; 05A58F E9 02 
  STA.W EntityXPx,Y                              ; 05A591 99 46 0B 
  RTS                                             ; 05A594 60 

B_5A595:
  CMP.B $07                                       ; 05A595 C5 07 
  BCC.B B_5A59F                                   ; 05A597 90 06 
  CLC                                             ; 05A599 18 
  ADC.B #$02                                      ; 05A59A 69 02 
  STA.W EntityXPx,Y                              ; 05A59C 99 46 0B 
B_5A59F:
  LDA.W EntityYPx,Y                                   ; 05A59F B9 9C 0C 
  CMP.B $04                                       ; 05A5A2 C5 04 
  BCS.B B_5A5AD                                   ; 05A5A4 B0 07 
  SEC                                             ; 05A5A6 38 
  SBC.B #$02                                      ; 05A5A7 E9 02 
  STA.W EntityYPx,Y                                   ; 05A5A9 99 9C 0C 
  RTS                                             ; 05A5AC 60 

B_5A5AD:
  CMP.B $05                                       ; 05A5AD C5 05 
  BCC.B B_5A5B7                                   ; 05A5AF 90 06 
  CLC                                             ; 05A5B1 18 
  ADC.B #$02                                      ; 05A5B2 69 02 
  STA.W EntityYPx,Y                                   ; 05A5B4 99 9C 0C 
B_5A5B7:
  RTS                                             ; 05A5B7 60 

  LDA.B #$2A                                      ; 05A5B8 A9 2A 
  JSR.W L_58844                                   ; 05A5BA 20 44 88 
  RTS                                             ; 05A5BD 60 


.byte $60,$60,$60,$60,$60,$60,$60,$60             ; 05A5BE ........ ````````
.byte $60,$60,$60,$60,$60,$60,$60,$60             ; 05A5C6 ........ ````````

  JSR.W L_58BAA                                   ; 05A5CE 20 AA 8B 
  BEQ.B B_5A5DE                                   ; 05A5D1 F0 0B 
  CLC                                             ; 05A5D3 18 
  ADC.W EntityV19,X                                   ; 05A5D4 7D 48 0F 
  STA.W EntityV19,X                                   ; 05A5D7 9D 48 0F 
  CMP.B #$04                                      ; 05A5DA C9 04 
  BCS.B B_5A5E1                                   ; 05A5DC B0 03 
B_5A5DE:
  JMP.W D_5A66B                                   ; 05A5DE 4C 6B A6 
B_5A5E1:
  PHX                                             ; 05A5E1 DA 
  LDA.W EntityV20,X                                   ; 05A5E2 BD BA 0F 
  TAX                                             ; 05A5E5 AA 
  STZ.B $41,X                                     ; 05A5E6 74 41 
  LDA.W $1872                                     ; 05A5E8 AD 72 18 
  BNE.B B_5A602                                   ; 05A5EB D0 15 
  STZ.B $A7                                       ; 05A5ED 64 A7 
  LDA.B #$50                                      ; 05A5EF A9 50 
  STA.B $A8                                       ; 05A5F1 85 A8 
  LDA.B #$01                                      ; 05A5F3 A9 01 
  STA.B $A9                                       ; 05A5F5 85 A9 
  LDY.B $1E                                       ; 05A5F7 A4 1E 
  LDA.W EntityV20+Projectiles,Y                                   ; 05A5F9 B9 FC 0F 
  JSL IncreasePlayerScore                                      ; 05A5FC 22 6D E4 00 
  BRA.B B_5A608                                   ; 05A600 80 06 
B_5A602:
  LDA.B $1E                                       ; 05A602 A5 1E 
  JSL IncreasePlayerScore                                      ; 05A604 22 6D E4 00 
B_5A608:
  LDY.W EntityV23,X                                   ; 05A608 BC 10 11 
  LDA.B #$00                                      ; 05A60B A9 00 
  STA.W $1AAF,Y                                   ; 05A60D 99 AF 1A 
  LDY.W EntityV31,X                                   ; 05A610 BC A0 14 
  JSL L_AEF1                                      ; 05A613 22 F1 AE 00 
  JSR.W L_58CED                                   ; 05A617 20 ED 8C 
  LDA.B #$08                                      ; 05A61A A9 08 
  STA.B $1C                                       ; 05A61C 85 1C 
  LDA.B #$08                                      ; 05A61E A9 08 
  STA.B $1D                                       ; 05A620 85 1D 
  JSL L_AFC2                                      ; 05A622 22 C2 AF 00 
  PLX                                             ; 05A626 FA 
  STZ.B $41,X                                     ; 05A627 74 41 
  CLC                                             ; 05A629 18 
  LDA.W EntityXPx,X                              ; 05A62A BD 46 0B 
  ADC.B #$08                                      ; 05A62D 69 08 
  STA.W EntityXPx,X                              ; 05A62F 9D 46 0B 
  CLC                                             ; 05A632 18 
  LDA.W EntityYPx,X                                   ; 05A633 BD 9C 0C 
  ADC.B #$08                                      ; 05A636 69 08 
  STA.W EntityYPx,X                                   ; 05A638 9D 9C 0C 
  LDY.W EntityV31,X                                   ; 05A63B BC A0 14 
  JSL L_AEF1                                      ; 05A63E 22 F1 AE 00 
  JSR.W L_58CED                                   ; 05A642 20 ED 8C 
  LDA.B #$08                                      ; 05A645 A9 08 
  STA.B $1C                                       ; 05A647 85 1C 
  LDA.B #$08                                      ; 05A649 A9 08 
  STA.B $1D                                       ; 05A64B 85 1D 
  JSL L_AFC2                                      ; 05A64D 22 C2 AF 00 
  DEC.W $06C6                                     ; 05A651 CE C6 06 
  DEC.W $18EA                                     ; 05A654 CE EA 18 
  LDX.W $18E2                                     ; 05A657 AE E2 18 
  SEC                                             ; 05A65A 38 
  LDA.W $18C5,X                                   ; 05A65B BD C5 18 
  SBC.B #$02                                      ; 05A65E E9 02 
  STA.W $18C5,X                                   ; 05A660 9D C5 18 
  BNE.B D_5A66B                                   ; 05A663 D0 06 
  STZ.W $18C9,X                                   ; 05A665 9E C9 18 
  STZ.W $18C1,X                                   ; 05A668 9E C1 18 
D_5A66B:
  JSR.W L_589AF                                   ; 05A66B 20 AF 89 
  RTS                                             ; 05A66E 60 


.byte $A9,$2A,$20,$44,$88,$60                     ; 05A670 ......   ?* D?`

  JSR.W L_58D25                                   ; 05A675 20 25 8D 
  RTS                                             ; 05A678 60 

  JSR.W L_58CED                                   ; 05A679 20 ED 8C 
  LDA.B #$2A                                      ; 05A67C A9 2A 
  JSR.W L_58844                                   ; 05A67E 20 44 88 
  RTS                                             ; 05A681 60 


.byte $60,$60                                     ; 05A683 ..       ``

  JSR.W L_58BAA                                   ; 05A684 20 AA 8B 
  BEQ.B B_5A68B                                   ; 05A687 F0 02 
  BPL.B B_5A68E                                   ; 05A689 10 03 

B_5A68B:
.byte $4C,$05,$A7                                 ; 05A68C ...      L??

B_5A68E:
  STA.B $04                                       ; 05A68E 85 04 
  SEC                                             ; 05A690 38 
  LDA.W EntityV19,X                                   ; 05A691 BD 48 0F 
  SBC.B $04                                       ; 05A694 E5 04 
  STA.W EntityV19,X                                   ; 05A696 9D 48 0F 
  BCS.B B_5A6DF                                   ; 05A699 B0 44 
  STZ.B $41,X                                     ; 05A69B 74 41 
  STZ.B $A7                                       ; 05A69D 64 A7 
  LDA.B #$55                                      ; 05A69F A9 55 
  STA.B $A8                                       ; 05A6A1 85 A8 
  STZ.B $A9                                       ; 05A6A3 64 A9 
  LDY.B $1E                                       ; 05A6A5 A4 1E 
  LDA.W EntityV20+Projectiles,Y                                   ; 05A6A7 B9 FC 0F 
  JSL IncreasePlayerScore                                      ; 05A6AA 22 6D E4 00 
  LDY.W EntityV23,X                                   ; 05A6AE BC 10 11 
  LDA.B #$00                                      ; 05A6B1 A9 00 
  STA.W $1AAF,Y                                   ; 05A6B3 99 AF 1A 
  LDY.W EntityV31,X                                   ; 05A6B6 BC A0 14 
  JSL L_AEF1                                      ; 05A6B9 22 F1 AE 00 
  JSR.W L_58CED                                   ; 05A6BD 20 ED 8C 
  LDA.B #$08                                      ; 05A6C0 A9 08 
  STA.B $1C                                       ; 05A6C2 85 1C 
  LDA.B #$08                                      ; 05A6C4 A9 08 
  STA.B $1D                                       ; 05A6C6 85 1D 
  JSL L_AFC2                                      ; 05A6C8 22 C2 AF 00 
  DEC.W $06C6                                     ; 05A6CC CE C6 06 
  LDX.W $18E2                                     ; 05A6CF AE E2 18 
  DEC.W $18C5,X                                   ; 05A6D2 DE C5 18 
  BNE.B B_5A6DD                                   ; 05A6D5 D0 06 
  STZ.W $18C9,X                                   ; 05A6D7 9E C9 18 
  STZ.W $18C1,X                                   ; 05A6DA 9E C1 18 
B_5A6DD:
  BRA.B B_5A705                                   ; 05A6DD 80 26 
B_5A6DF:
  LDA.W EntityV30,X                                   ; 05A6DF BD 2E 14 
  AND.B #$40                                      ; 05A6E2 29 40 
  ORA.B #$31                                      ; 05A6E4 09 31 
  STA.W EntityV30,X                                   ; 05A6E6 9D 2E 14 
  LDA.B #$FF                                      ; 05A6E9 A9 FF 
  XBA                                             ; 05A6EB EB 
  JSL AdvanceRNG                                     ; 05A6EC 22 95 CA 0E 
  AND.B #$03                                      ; 05A6F0 29 03 
  TAY                                             ; 05A6F2 A8 
  LDA.W D_5A709,Y                                 ; 05A6F3 B9 09 A7 
  BEQ.B B_5A705                                   ; 05A6F6 F0 0D 
  PHX                                             ; 05A6F8 DA 
  REP.B #P_Idx8Bit                                      ; 05A6F9 C2 10 
  TAX                                             ; 05A6FB AA 
  LDA.B #$07                                      ; 05A6FC A9 07 
  JSL Audio_F830F                                     ; 05A6FE 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 05A702 E2 30 
  PLX                                             ; 05A704 FA 
B_5A705:
  JSR.W L_589AF                                   ; 05A705 20 AF 89 
  RTS                                             ; 05A708 60 


D_5A709:
.byte $0C,$0D,$00,$00,$A9,$2A,$20,$44             ; 05A709 DDDD.... ?????* D
.byte $88,$60,$60,$60,$60,$60,$60,$60             ; 05A711 ........ ?```````
.byte $AD,$72,$18,$F0,$03,$4C,$B5,$A7             ; 05A719 ........ ?r???L??
.byte $20,$F8,$8B,$D0,$03,$4C,$B2,$A7             ; 05A721 ........  ????L??
.byte $A9,$08,$20,$75,$A4,$64,$A7,$A9             ; 05A729 ........ ?? u?d??
.byte $30,$85,$A8,$64,$A9,$A4,$1E,$B9             ; 05A731 ........ 0??d????
.byte $FC,$0F,$22,$6D,$E4,$00,$BD,$44             ; 05A739 ........ ??"m???D
.byte $07,$C9,$9A,$F0,$11,$64,$A7,$A9             ; 05A741 ........ ?????d??
.byte $30,$85,$A8,$64,$A9,$A4,$1E,$B9             ; 05A749 ........ 0??d????
.byte $FC,$0F,$22,$6D,$E4,$00,$64,$04             ; 05A751 ........ ??"m??d?
.byte $A4,$1E,$B9,$88,$0B,$DD,$46,$0B             ; 05A759 ........ ??????F?
.byte $90,$02,$E6,$04,$B9,$DE,$0C,$DD             ; 05A761 ........ ????????
.byte $9C,$0C,$90,$06,$A5,$04,$09,$02             ; 05A769 ........ ????????
.byte $85,$04,$A4,$04,$B9,$B6,$06,$C9             ; 05A771 ........ ????????
.byte $0F,$F0,$06,$18,$69,$01,$99,$B6             ; 05A779 ........ ????i???
.byte $06,$A4,$1E,$B9,$6E,$10,$0A,$A8             ; 05A781 ........ ????n???
.byte $AE,$8B,$06,$18,$BD,$0C,$09,$79             ; 05A789 ........ ???????y
.byte $B6,$A7,$9D,$0C,$09,$BD,$7E,$09             ; 05A791 ........ ??????~?
.byte $79,$B7,$A7,$9D,$7E,$09,$18,$BD             ; 05A799 ........ y???~???
.byte $F0,$09,$79,$C6,$A7,$9D,$F0,$09             ; 05A7A1 ........ ??y?????
.byte $BD,$62,$0A,$79,$C7,$A7,$9D,$62             ; 05A7A9 ........ ?b?y???b
.byte $0A,$20,$15,$8B,$60,$00,$00,$00             ; 05A7B1 ........ ? ??`???
.byte $02,$00,$02,$00,$02,$00,$00,$00             ; 05A7B9 ........ ????????
.byte $FE,$00,$FE,$00,$FE,$00,$02,$00             ; 05A7C1 ........ ????????
.byte $02,$00,$00,$00,$FE,$00,$FE,$00             ; 05A7C9 ........ ????????
.byte $FE,$00,$00,$00,$02,$60,$60,$60             ; 05A7D1 ........ ?????```
.byte $60,$60,$60,$60,$60,$60,$60,$60             ; 05A7D9 ........ ````````
.byte $AD,$72,$18,$D0,$72,$BD,$9E,$10             ; 05A7E1 ........ ?r??r???
.byte $C9,$02,$D0,$08,$A9,$01,$20,$75             ; 05A7E9 ........ ?????? u
.byte $A4,$4C,$24,$A8,$20,$DE,$8B,$F0             ; 05A7F1 ........ ?L$? ???
.byte $2A,$48,$20,$75,$A4,$20,$8A,$A8             ; 05A7F9 ........ *H u? ??
.byte $68,$18,$7D,$48,$0F,$C9,$09,$90             ; 05A801 ........ h?}H????
.byte $0F,$FE,$9E,$10,$BD,$9E,$10,$C9             ; 05A809 ........ ????????
.byte $02,$D0,$03,$CE,$AF,$06,$A9,$00             ; 05A811 ........ ????????
.byte $9D,$48,$0F,$BD,$2E,$14,$29,$F1             ; 05A819 ........ ?H??.?)?
.byte $9D,$2E,$14,$A4,$1E,$B9,$6E,$10             ; 05A821 ........ ?.????n?
.byte $0A,$A8,$AE,$8B,$06,$18,$BD,$0C             ; 05A829 ........ ????????
.byte $09,$79,$EE,$A8,$9D,$0C,$09,$BD             ; 05A831 ........ ?y??????
.byte $7E,$09,$79,$EF,$A8,$9D,$7E,$09             ; 05A839 ........ ~?y???~?
.byte $18,$BD,$F0,$09,$79,$FE,$A8,$9D             ; 05A841 ........ ????y???
.byte $F0,$09,$BD,$62,$0A,$79,$FF,$A8             ; 05A849 ........ ???b?y??
.byte $9D,$62,$0A,$20,$15,$8B,$60,$BC             ; 05A851 ........ ?b? ??`?
.byte $2C,$10,$B9,$C6,$A8,$0A,$A8,$AE             ; 05A859 ........ ,???????
.byte $8B,$06,$18,$BD,$0C,$09,$79,$CE             ; 05A861 ........ ??????y?
.byte $A8,$9D,$0C,$09,$BD,$7E,$09,$79             ; 05A869 ........ ?????~?y
.byte $CF,$A8,$9D,$7E,$09,$18,$BD,$F0             ; 05A871 ........ ???~????
.byte $09,$79,$DE,$A8,$9D,$F0,$09,$BD             ; 05A879 ........ ?y??????
.byte $62,$0A,$79,$DF,$A8,$9D,$62,$0A             ; 05A881 ........ b?y???b?
.byte $60,$DA,$5A,$A4,$1E,$B9,$FC,$0F             ; 05A889 ........ `?Z?????
.byte $EB,$38,$B9,$86,$07,$E9,$32,$0A             ; 05A891 ........ ?8????2?
.byte $A8,$B9,$B6,$A8,$85,$A7,$B9,$B7             ; 05A899 ........ ????????
.byte $A8,$85,$A8,$64,$A9,$EB,$22,$6D             ; 05A8A1 ........ ???d??"m
.byte $E4,$00,$7A,$FA,$60,$01,$01,$03             ; 05A8A9 ........ ??z?`???
.byte $02,$01,$01,$00,$04,$00,$00,$50             ; 05A8B1 ........ ???????P
.byte $02,$00,$05,$50,$02,$00,$00,$00             ; 05A8B9 ........ ???P????
.byte $00,$00,$00,$00,$10,$00,$01,$03             ; 05A8C1 ........ ????????
.byte $04,$00,$07,$05,$04,$00,$00,$10             ; 05A8C9 ........ ????????
.byte $00,$10,$00,$10,$00,$00,$00,$F0             ; 05A8D1 ........ ????????
.byte $FF,$F0,$FF,$F0,$FF,$10,$00,$10             ; 05A8D9 ........ ????????
.byte $00,$00,$00,$F0,$FF,$F0,$FF,$F0             ; 05A8E1 ........ ????????
.byte $FF,$00,$00,$10,$00,$00,$00,$80             ; 05A8E9 ........ ????????
.byte $00,$80,$00,$80,$00,$00,$00,$80             ; 05A8F1 ........ ????????
.byte $FF,$80,$FF,$80,$FF,$80,$00,$80             ; 05A8F9 ........ ????????
.byte $00,$00,$00,$80,$FF,$80,$FF,$80             ; 05A901 ........ ????????
.byte $FF,$00,$00,$80,$00,$60,$A5,$D2             ; 05A909 ........ ?????`??
.byte $29,$0F,$D0,$05,$A9,$2A,$20,$44             ; 05A911 ........ )????* D
.byte $88,$60,$60,$60,$AD,$72,$18,$D0             ; 05A919 ........ ?```?r??
.byte $72,$BD,$9E,$10,$C9,$03,$D0,$08             ; 05A921 ........ r???????
.byte $A9,$01,$20,$75,$A4,$4C,$60,$A9             ; 05A929 ........ ?? u?L`?
.byte $20,$DE,$8B,$F0,$2A,$48,$20,$75             ; 05A931 ........  ???*H u
.byte $A4,$20,$C6,$A9,$68,$18,$7D,$48             ; 05A939 ........ ? ??h?}H
.byte $0F,$C9,$09,$90,$0F,$FE,$9E,$10             ; 05A941 ........ ????????
.byte $BD,$9E,$10,$C9,$03,$D0,$03,$CE             ; 05A949 ........ ????????
.byte $AF,$06,$A9,$00,$9D,$48,$0F,$BD             ; 05A951 ........ ?????H??
.byte $2E,$14,$29,$F1,$9D,$2E,$14,$A4             ; 05A959 ........ .?)??.??
.byte $1E,$B9,$6E,$10,$0A,$A8,$AE,$8B             ; 05A961 ........ ??n?????
.byte $06,$18,$BD,$0C,$09,$79,$32,$AA             ; 05A969 ........ ?????y2?
.byte $9D,$0C,$09,$BD,$7E,$09,$79,$33             ; 05A971 ........ ????~?y3
.byte $AA,$9D,$7E,$09,$18,$BD,$F0,$09             ; 05A979 ........ ??~?????
.byte $79,$42,$AA,$9D,$F0,$09,$BD,$62             ; 05A981 ........ yB?????b
.byte $0A,$79,$43,$AA,$9D,$62,$0A,$20             ; 05A989 ........ ?yC??b? 
.byte $15,$8B,$60,$BC,$2C,$10,$B9,$02             ; 05A991 ........ ??`?,???
.byte $AA,$0A,$A8,$AE,$8B,$06,$18,$BD             ; 05A999 ........ ????????
.byte $0C,$09,$79,$12,$AA,$9D,$0C,$09             ; 05A9A1 ........ ??y?????
.byte $BD,$7E,$09,$79,$13,$AA,$9D,$7E             ; 05A9A9 ........ ?~?y???~
.byte $09,$18,$BD,$F0,$09,$79,$22,$AA             ; 05A9B1 ........ ?????y"?
.byte $9D,$F0,$09,$BD,$62,$0A,$79,$23             ; 05A9B9 ........ ????b?y#
.byte $AA,$9D,$62,$0A,$60,$DA,$5A,$A4             ; 05A9C1 ........ ??b?`?Z?
.byte $1E,$B9,$FC,$0F,$EB,$38,$B9,$86             ; 05A9C9 ........ ?????8??
.byte $07,$E9,$32,$0A,$A8,$B9,$F2,$A9             ; 05A9D1 ........ ??2?????
.byte $85,$A7,$B9,$F3,$A9,$85,$A8,$64             ; 05A9D9 ........ ???????d
.byte $A9,$EB,$22,$6D,$E4,$00,$7A,$FA             ; 05A9E1 ........ ??"m??z?
.byte $60,$01,$01,$03,$02,$01,$01,$00             ; 05A9E9 ........ `???????
.byte $04,$50,$02,$00,$05,$00,$05,$50             ; 05A9F1 ........ ?P?????P
.byte $02,$00,$00,$00,$00,$00,$00,$00             ; 05A9F9 ........ ????????
.byte $20,$00,$01,$01,$02,$02,$03,$03             ; 05AA01 ........  ???????
.byte $04,$00,$07,$07,$06,$06,$05,$05             ; 05AA09 ........ ????????
.byte $04,$00,$00,$10,$00,$10,$00,$10             ; 05AA11 ........ ????????
.byte $00,$00,$00,$F0,$FF,$F0,$FF,$F0             ; 05AA19 ........ ????????
.byte $FF,$10,$00,$10,$00,$00,$00,$F0             ; 05AA21 ........ ????????
.byte $FF,$F0,$FF,$F0,$FF,$00,$00,$10             ; 05AA29 ........ ????????
.byte $00,$00,$00,$80,$00,$80,$00,$80             ; 05AA31 ........ ????????
.byte $00,$00,$00,$80,$FF,$80,$FF,$80             ; 05AA39 ........ ????????
.byte $FF,$80,$00,$80,$00,$00,$00,$80             ; 05AA41 ........ ????????
.byte $FF,$80,$FF,$80,$FF,$00,$00,$80             ; 05AA49 ........ ????????
.byte $00,$A5,$D2,$29,$0F,$D0,$05,$A9             ; 05AA51 ........ ???)????
.byte $2A,$20,$44,$88,$60,$60,$60,$60             ; 05AA59 ........ * D?````
.byte $60,$60,$60,$60,$60,$60,$60,$60             ; 05AA61 ........ ````````
.byte $60,$AD,$72,$18,$D0,$11,$A4,$1E             ; 05AA69 ........ `?r?????
.byte $B9,$86,$07,$C9,$38,$F0,$08,$C9             ; 05AA71 ........ ????8???
.byte $36,$F0,$04,$C9,$37,$D0,$09,$CE             ; 05AA79 ........ 6???7???
.byte $F1,$18,$20,$D0,$8C,$20,$F5,$AA             ; 05AA81 ........ ?? ?? ??
.byte $60,$CE,$F1,$18,$A9,$2A,$20,$44             ; 05AA89 ........ `????* D
.byte $88,$20,$D0,$8C,$20,$F5,$AA,$60             ; 05AA91 ........ ? ?? ??`
.byte $AD,$72,$18,$D0,$11,$A4,$1E,$B9             ; 05AA99 ........ ?r??????
.byte $86,$07,$C9,$38,$F0,$08,$C9,$36             ; 05AAA1 ........ ???8???6
.byte $F0,$04,$C9,$37,$D0,$06,$20,$D0             ; 05AAA9 ........ ???7?? ?
.byte $8C,$20,$F5,$AA,$60,$A9,$2A,$20             ; 05AAB1 ........ ? ??`?* 
.byte $44,$88,$20,$D0,$8C,$20,$F5,$AA             ; 05AAB9 ........ D? ?? ??
.byte $60,$60,$60,$AD,$72,$18,$D0,$11             ; 05AAC1 ........ ```?r???
.byte $A4,$1E,$B9,$86,$07,$C9,$38,$F0             ; 05AAC9 ........ ??????8?
.byte $08,$C9,$36,$F0,$04,$C9,$37,$D0             ; 05AAD1 ........ ??6???7?
.byte $06,$20,$25,$8D,$20,$F5,$AA,$60             ; 05AAD9 ........ ? %? ??`
.byte $22,$95,$CA,$0E,$29,$01,$D0,$05             ; 05AAE1 ........ "???)???
.byte $A9,$2A,$20,$44,$88,$20,$25,$8D             ; 05AAE9 ........ ?* D? %?
.byte $20,$F5,$AA,$60,$DA,$C2,$10,$A9             ; 05AAF1 ........  ??`????
.byte $07,$A2,$06,$FF,$22,$0F,$83,$0F             ; 05AAF9 ........ ????"???
.byte $E2,$10,$FA,$60,$47,$AB,$5C,$AB             ; 05AB01 ....DDDD ???`G?\?
.byte $6C,$AB,$7C,$AB,$91,$AB,$A6,$AB             ; 05AB09 DDDDDDDD l?|?????
.byte $BB,$AB,$C1,$AB,$C7,$AB,$CD,$AB             ; 05AB11 DDDDDDDD ????????
.byte $D3,$AB,$D9,$AB,$DF,$AB,$E0,$AB             ; 05AB19 DDDD.... ????????
.byte $E1,$AB,$E2,$AB,$E3,$AB,$E4,$AB             ; 05AB21 ......DD ????????
.byte $F4,$AB,$04,$AC,$19,$AC,$2E,$AC             ; 05AB29 DDDDDDDD ??????.?
.byte $43,$AC,$49,$AC,$4F,$AC,$55,$AC             ; 05AB31 DDDDDDDD C?I?O?U?
.byte $5B,$AC,$61,$AC,$67,$AC,$68,$AC             ; 05AB39 DDDD.... [?a?g?h?
.byte $69,$AC,$6A,$AC,$6B,$AC,$04,$E5             ; 05AB41 ......DD i?j?k???
.byte $15,$F9,$40,$00,$04,$15,$F9,$40             ; 05AB49 DDDDDDDD ??@????@
.byte $01,$F8,$07,$FE,$2A,$00,$FF,$07             ; 05AB51 DDDDDDDD ????*???
.byte $FE,$2A,$01,$03,$DB,$11,$DF,$0F             ; 05AB59 DDDDDDDD ?*??????
.byte $00,$D3,$2D,$E8,$1B,$00,$EA,$16             ; 05AB61 .DDDDDDD ??-?????
.byte $E8,$28,$00,$03,$EA,$16,$E8,$28             ; 05AB69 DD.DDDDD ?(?????(
.byte $00,$E3,$0E,$E9,$0B,$00,$C6,$29             ; 05AB71 DDDDD.DD ???????)
.byte $EF,$12,$00,$04,$EA,$16,$E8,$28             ; 05AB79 DD.DDDDD ???????(
.byte $00,$E2,$0D,$E9,$1B,$00,$D5,$0E             ; 05AB81 .DDDD.DD ????????
.byte $F5,$11,$00,$CA,$0E,$FF,$17,$00             ; 05AB89 DD.DD... ????????
.byte $04,$EA,$16,$E8,$28,$00,$E0,$11             ; 05AB91 DDDDD.DD ????(???
.byte $EA,$0F,$00,$D9,$16,$F5,$14,$00             ; 05AB99 DD.DDDD. ????????
.byte $D0,$10,$02,$20,$00,$04,$EA,$16             ; 05ABA1 DD...DDD ??? ????
.byte $E8,$28,$00,$E1,$0D,$EA,$21,$00             ; 05ABA9 DD.DD... ?(????!?
.byte $D8,$0B,$FD,$15,$00,$D2,$0E,$0E             ; 05ABB1 DD...DD. ????????
.byte $14,$00,$01,$EA,$16,$E8,$28,$00             ; 05ABB9 ..DDDDDD ??????(?
.byte $01,$EA,$16,$E8,$28,$00,$01,$EA             ; 05ABC1 DDDDDDDD ????(???
.byte $16,$E8,$28,$00,$01,$EA,$16,$E8             ; 05ABC9 D...DDD. ??(?????
.byte $28,$00,$01,$EA,$16,$E8,$28,$00             ; 05ABD1 ..DDD... (?????(?
.byte $01,$EA,$16,$E8,$28,$00,$00,$00             ; 05ABD9 DDDDDD.. ????(???
.byte $00,$00,$00,$03,$11,$14,$DF,$0E             ; 05ABE1 ...DDDDD ????????
.byte $00,$FE,$16,$E8,$28,$00,$10,$1D             ; 05ABE9 .DDDDDDD ????(???
.byte $E9,$1B,$00,$03,$FE,$16,$E8,$28             ; 05ABF1 DDDDDDDD ???????(
.byte $00,$12,$0B,$E9,$0B,$00,$10,$27             ; 05ABF9 DDDDDDDD ???????'
.byte $EE,$15,$00,$04,$FE,$16,$E8,$28             ; 05AC01 DDDDDDDD ???????(
.byte $00,$11,$0E,$ED,$13,$00,$1B,$0E             ; 05AC09 DDDDDDDD ????????
.byte $F3,$15,$00,$25,$10,$FE,$19,$00             ; 05AC11 DDDDDDDD ???%????
.byte $04,$FE,$16,$E8,$28,$00,$0E,$0E             ; 05AC19 DDDDDDDD ????(???
.byte $E9,$1C,$00,$19,$0D,$F4,$16,$00             ; 05AC21 DDDDDDDD ????????
.byte $1E,$11,$02,$20,$00,$04,$FE,$16             ; 05AC29 DDDDDDDD ??? ????
.byte $E8,$28,$00,$12,$0C,$EA,$22,$00             ; 05AC31 DDDDDDDD ?(????"?
.byte $1B,$09,$F9,$17,$00,$1E,$0C,$06             ; 05AC39 DDDDDDDD ????????
.byte $1B,$00,$01,$FE,$16,$E8,$28,$00             ; 05AC41 DDDDDDDD ??????(?
.byte $01,$FE,$16,$E8,$28,$00,$01,$FE             ; 05AC49 DDDDDDDD ????(???
.byte $16,$E8,$28,$00,$01,$FE,$16,$E8             ; 05AC51 D...DDD. ??(?????
.byte $28,$00,$01,$FE,$16,$E8,$28,$00             ; 05AC59 ..DDD... (?????(?
.byte $01,$FE,$16,$E8,$28,$00,$00,$00             ; 05AC61 DDD..... ????(???
.byte $00,$00,$00,$00,$08,$53,$00,$00             ; 05AC69 ...DDDDD ?????S??
.byte $20,$00,$20,$0D,$24,$00,$20,$01             ; 05AC71 DDDDDDDD  ? ?$? ?
.byte $11,$0F,$05,$1C,$1A,$0C,$A4,$00             ; 05AC79 DDDDDDDD ????????
.byte $20,$23,$09,$24,$01,$24,$15,$24             ; 05AC81 DDDDDDDD  #?$?$?$
.byte $05,$24,$0E,$2A,$1F,$24,$1A,$24             ; 05AC89 DDDDDDDD ?$?*?$?$
.byte $17,$A4,$05,$A4,$2A,$03,$05,$24             ; 05AC91 DDDDDDDD ????*??$
.byte $04,$24,$07,$24,$10,$24,$05,$A4             ; 05AC99 DDDDDDDD ?$?$?$??
.byte $04,$A4,$07,$A4,$17,$A4,$0F,$0F             ; 05ACA1 DDDDDDDD ????????
.byte $01,$10,$1C,$05,$23,$1A,$10,$24             ; 05ACA9 DDDDDDDD ????#??$
.byte $0C,$03,$0B,$07,$11,$17,$A4,$03             ; 05ACB1 DDDDDDDD ????????
.byte $21,$07,$0C,$0A,$1D,$20,$12,$24             ; 05ACB9 DDDDDDDD !???? ?$
.byte $06,$0C,$13,$02,$98,$0A,$98,$05             ; 05ACC1 DDDDDDDD ????????
.byte $53,$00,$55,$1F,$9C,$46,$1E,$2F             ; 05ACC9 DDDDDDDD S?U??F?/
.byte $71,$BB,$8F,$DC,$8F,$75,$08,$97             ; 05ACD1 DDDDDDDD q????u??
.byte $27,$BA,$BC,$3C,$8C,$EB,$FA,$59             ; 05ACD9 DDDDDDDD '??<???Y
.byte $54,$7B,$4A,$A8,$EF,$42,$A8,$E7             ; 05ACE1 DDDDDDDD T{J??B??
.byte $38,$AB,$03,$AC,$76,$93,$8A,$3A             ; 05ACE9 DDDDDDDD 8???v??:
.byte $A8,$40,$6A,$D1,$6B,$38,$AB,$78             ; 05ACF1 DDDDDDDD ?@j?k8?x
.byte $FC,$06,$91,$1E,$CC,$2A,$FA,$FC             ; 05ACF9 DDDDDDDD ?????*??
.byte $06,$B1,$1D,$50,$8A,$9B,$98,$2D             ; 05AD01 DDDDDDDD ???P???-
.byte $D0,$B6,$E7,$EE,$2A,$DB,$E3,$10             ; 05AD09 DDDDDDDD ????*???
.byte $6D,$AC,$DB,$E1,$DF,$11,$6D,$6E             ; 05AD11 DDDDDDDD m?????mn
.byte $DA,$CB,$C6,$A1,$02,$79,$3B,$73             ; 05AD19 DDDDDDDD ?????y;s
.byte $56,$E3,$3D,$CD,$DB,$8A,$FC,$AA             ; 05AD21 DDDDDDDD V?=?????
.byte $10,$23,$2B,$C5,$D1,$5B,$94,$F7             ; 05AD29 DDDDDDDD ?#+??[??
.byte $47,$6D,$AE,$EA,$59,$54,$76,$CE             ; 05AD31 DDDDDDDD Gm??YTv?
.byte $2A,$E4,$60,$2C,$91,$A0,$3E,$10             ; 05AD39 DDDDDDDD *?`,??>?
.byte $2C,$AB,$8D,$96,$35,$11,$E6,$B1             ; 05AD41 DDDDDDDD ,???5???
.byte $77,$84,$76,$40,$79,$A0,$55,$F1             ; 05AD49 DDDDDDDD w?v@y?U?
.byte $2D,$E2,$11,$F0,$E1,$D5,$85,$51             ; 05AD51 DDDDDDDD -??????Q
.byte $F7,$3A,$A8,$FF,$31,$02,$00,$04             ; 05AD59 DDDDDD.. ?:??1???
.byte $E0,$CD,$0C,$00,$00,$08,$00,$00             ; 05AD61 ........ ????????
.byte $2C,$CF,$0C,$00,$C0,$00,$00,$20             ; 05AD69 ........ ,?????? 
.byte $AD,$90,$0C,$00,$00,$40,$00,$40             ; 05AD71 ........ ?????@?@
.byte $AD,$90,$0C,$00,$00,$40,$FF,$FF             ; 05AD79 ........ ?????@??
.byte $00,$04,$A3,$C1,$0C,$00,$00,$03             ; 05AD81 ........ ????????
.byte $00,$00,$4D,$C2,$0C,$00,$00,$08             ; 05AD89 ........ ??M?????
.byte $00,$20,$00,$80,$0C,$00,$00,$40             ; 05AD91 ........ ? ?????@
.byte $00,$40,$50,$9A,$0C,$00,$00,$40             ; 05AD99 ........ ?@P????@
.byte $00,$10,$1F,$B3,$05,$00,$00,$20             ; 05ADA1 ........ ??????? 
.byte $FF,$FF,$00,$04,$8D,$C8,$0C,$00             ; 05ADA9 ..DDDDDD ????????
.byte $00,$08,$00,$40,$84,$BE,$05,$00             ; 05ADB1 DDDDDDDD ???@????
.byte $00,$40,$00,$20,$00,$80,$0C,$00             ; 05ADB9 DDDDDDDD ?@? ????
.byte $00,$40,$00,$60,$4D,$DA,$05,$00             ; 05ADC1 DDDDDDDD ?@?`M???
.byte $00,$40,$00,$10,$1F,$B3,$05,$00             ; 05ADC9 DDDDDDDD ?@??????
.byte $00,$20,$FF,$FF,$00,$00,$33,$CB             ; 05ADD1 DDDDDDDD ? ????3?
.byte $0C,$00,$00,$08,$00,$40,$00,$80             ; 05ADD9 DDDDDDDD ?????@??
.byte $0C,$00,$00,$40,$00,$10,$1F,$B3             ; 05ADE1 DDDDDDDD ???@????
.byte $05,$00,$00,$20,$FF,$FF,$00,$04             ; 05ADE9 DDDDDD.. ??? ????
.byte $CC,$CF,$0C,$00,$00,$08,$00,$20             ; 05ADF1 ........ ??????? 
.byte $00,$80,$0C,$00,$00,$40,$00,$40             ; 05ADF9 ........ ?????@?@
.byte $84,$BE,$05,$00,$00,$40,$00,$60             ; 05AE01 ........ ?????@?`
.byte $4D,$DA,$05,$00,$00,$40,$00,$10             ; 05AE09 ........ M????@??
.byte $1F,$B3,$05,$00,$00,$20,$FF,$FF             ; 05AE11 ........ ????? ??
.byte $00,$00,$33,$C4,$0C,$00,$00,$08             ; 05AE19 DDDDDDDD ??3?????
.byte $00,$40,$50,$9A,$0C,$00,$00,$40             ; 05AE21 DDDDDDDD ?@P????@
.byte $00,$10,$1F,$B3,$05,$00,$00,$20             ; 05AE29 DDDDDDDD ??????? 
.byte $FF,$FF,$52,$45,$49,$47,$4E,$49             ; 05AE31 DDDDDDDD ??REIGNI
.byte $4E,$47,$20,$43,$48,$41,$4D,$50             ; 05AE39 DDDDDDDD NG CHAMP
.byte $53,$00,$54,$4F,$44,$41,$59,$00             ; 05AE41 DDDDDDDD S?TODAY?
D_5AE49:
.byte $52,$4A,$52,$00,$00,$00,$00,$05             ; 05AE49 DDDDDDDD RJR?????
.byte $07,$03,$03,$01,$42,$4C,$44,$00             ; 05AE51 DDDDDDDD ????BLD?
.byte $00,$00,$00,$05,$02,$01,$02,$01             ; 05AE59 DDDDDDDD ????????
.byte $47,$53,$53,$00,$00,$00,$00,$05             ; 05AE61 DDDDDDDD GSS?????
.byte $07,$08,$01,$01,$41,$52,$4C,$00             ; 05AE69 DDDDDDDD ????ARL?
.byte $00,$00,$00,$00,$05,$09,$09,$00             ; 05AE71 DDDDDDDD ????????
.byte $4D,$52,$50,$00,$00,$00,$00,$05             ; 05AE79 DDDDDDDD MRP?????
.byte $02,$08,$08,$00,$41,$45,$42,$00             ; 05AE81 DDDDDDDD ????AEB?
.byte $00,$00,$00,$00,$00,$07,$07,$00             ; 05AE89 DDDDDDDD ????????
.byte $41,$4E,$4E,$00,$00,$00,$00,$05             ; 05AE91 DDDDDDDD ANN?????
.byte $07,$05,$05,$00,$4D,$4A,$54,$00             ; 05AE99 DDDDDDDD ????MJT?
.byte $00,$00,$00,$00,$05,$04,$00,$00             ; 05AEA1 DDDDDDDD ????????
.byte $53,$4A,$53,$00,$00,$00,$00,$05             ; 05AEA9 DDDDDDDD SJS?????
.byte $02,$03,$00,$00,$54,$4F,$4D,$00             ; 05AEB1 DDDDDDDD ????TOM?
.byte $00,$00,$00,$00,$00,$02,$00,$00             ; 05AEB9 DDDDDDDD ????????
.byte $54,$68,$65,$20,$59,$65,$61,$72             ; 05AEC1 DDDDDDDD The Year
.byte $20,$69,$73,$20,$31,$39,$39,$B9             ; 05AEC9 DDDDDDDD  is 199?
.byte $A0,$54,$65,$6C,$65,$76,$69,$73             ; 05AED1 DDDDDDDD ?Televis
.byte $69,$6F,$6E,$20,$68,$61,$73,$20             ; 05AED9 DDDDDDDD ion has 
.byte $61,$64,$61,$70,$74,$65,$E4,$A0             ; 05AEE1 DDDDDDDD adapte??
.byte $74,$6F,$20,$74,$68,$65,$20,$6D             ; 05AEE9 DDDDDDDD to the m
.byte $6F,$72,$65,$20,$76,$69,$6F,$6C             ; 05AEF1 DDDDDDDD ore viol
.byte $65,$6E,$F4,$A0,$6E,$61,$74,$75             ; 05AEF9 DDDDDDDD en??natu
.byte $72,$65,$20,$6F,$66,$20,$6D,$61             ; 05AF01 DDDDDDDD re of ma
.byte $6E,$AE,$A0,$A0,$A0,$A0,$54,$68             ; 05AF09 DDDDDDDD n?????Th
.byte $65,$20,$6D,$6F,$73,$74,$20,$70             ; 05AF11 DDDDDDDD e most p
.byte $6F,$70,$75,$6C,$61,$72,$20,$66             ; 05AF19 DDDDDDDD opular f
.byte $6F,$72,$6D,$20,$6F,$E6,$A0,$74             ; 05AF21 DDDDDDDD orm o??t
.byte $65,$6C,$65,$76,$69,$73,$69,$6F             ; 05AF29 DDDDDDDD elevisio
.byte $6E,$20,$72,$65,$6D,$61,$69,$6E             ; 05AF31 DDDDDDDD n remain
.byte $F3,$A0,$74,$68,$65,$20,$67,$61             ; 05AF39 DDDDDDDD ??the ga
.byte $6D,$65,$20,$73,$68,$6F,$77,$AE             ; 05AF41 DDDDDDDD me show?
.byte $A0,$A0,$A0,$A0,$4F,$6E,$65,$20             ; 05AF49 DDDDDDDD ????One 
.byte $73,$68,$6F,$77,$20,$69,$6E,$20             ; 05AF51 DDDDDDDD show in 
.byte $70,$61,$72,$74,$69,$63,$75,$6C             ; 05AF59 DDDDDDDD particul
.byte $61,$F2,$A0,$68,$61,$73,$20,$64             ; 05AF61 DDDDDDDD a??has d
.byte $6F,$6D,$69,$6E,$61,$74,$65,$64             ; 05AF69 DDDDDDDD ominated
.byte $20,$74,$68,$65,$20,$72,$61,$74             ; 05AF71 DDDDDDDD  the rat
.byte $69,$6E,$67,$73,$AE,$A0,$54,$68             ; 05AF79 DDDDDDDD ings??Th
.byte $61,$74,$20,$73,$68,$6F,$77,$20             ; 05AF81 DDDDDDDD at show 
.byte $69,$73,$20,$53,$6D,$61,$73,$68             ; 05AF89 DDDDDDDD is Smash
.byte $20,$54,$2E,$56,$AE,$A0,$54,$68             ; 05AF91 DDDDDDDD  T.V??Th
.byte $65,$20,$6D,$6F,$73,$74,$20,$76             ; 05AF99 DDDDDDDD e most v
.byte $69,$6F,$6C,$65,$6E,$F4,$A0,$67             ; 05AFA1 DDDDDDDD iolen??g
.byte $61,$6D,$65,$20,$73,$68,$6F,$77             ; 05AFA9 DDDDDDDD ame show
.byte $20,$6F,$66,$20,$61,$6C,$6C,$20             ; 05AFB1 DDDDDDDD  of all 
.byte $74,$69,$6D,$65,$AE,$A0,$A0,$A0             ; 05AFB9 DDDDDDDD time????
.byte $A0,$54,$77,$6F,$20,$6C,$75,$63             ; 05AFC1 DDDDDDDD ?Two luc
.byte $6B,$79,$20,$63,$6F,$6E,$74,$65             ; 05AFC9 DDDDDDDD ky conte
.byte $73,$74,$61,$6E,$74,$F3,$A0,$63             ; 05AFD1 DDDDDDDD stant??c
.byte $6F,$6D,$70,$65,$74,$65,$20,$66             ; 05AFD9 DDDDDDDD ompete f
.byte $6F,$72,$20,$63,$61,$73,$68,$20             ; 05AFE1 DDDDDDDD or cash 
.byte $61,$6E,$E4,$A0,$70,$72,$69,$7A             ; 05AFE9 DDDDDDDD an??priz
.byte $65,$73,$2E,$20,$45,$61,$63,$68             ; 05AFF1 DDDDDDDD es. Each
.byte $20,$63,$6F,$6E,$74,$65,$73,$74             ; 05AFF9 DDDDDDDD  contest
.byte $61,$6E,$74,$20,$69,$F3,$A0,$61             ; 05B001 DDDDDDDD ant i??a
.byte $72,$6D,$65,$64,$20,$77,$69,$74             ; 05B009 DDDDDDDD rmed wit
.byte $68,$20,$61,$6E,$20,$61,$73,$73             ; 05B011 DDDDDDDD h an ass
.byte $6F,$72,$74,$6D,$65,$6E,$F4,$A0             ; 05B019 DDDDDDDD ortmen??
.byte $6F,$66,$20,$70,$6F,$77,$65,$72             ; 05B021 DDDDDDDD of power
.byte $66,$75,$6C,$20,$77,$65,$61,$70             ; 05B029 DDDDDDDD ful weap
.byte $6F,$6E,$73,$20,$61,$6E,$E4,$A0             ; 05B031 DDDDDDDD ons an??
.byte $73,$65,$6E,$74,$20,$69,$6E,$74             ; 05B039 DDDDDDDD sent int
.byte $6F,$20,$61,$20,$63,$6C,$6F,$73             ; 05B041 DDDDDDDD o a clos
.byte $65,$64,$20,$61,$72,$65,$6E,$61             ; 05B049 DDDDDDDD ed arena
.byte $AE,$A0,$A0,$A0,$A0,$54,$68,$65             ; 05B051 DDDDDDDD ?????The
.byte $20,$61,$63,$74,$69,$6F,$6E,$20             ; 05B059 DDDDDDDD  action 
.byte $74,$61,$6B,$65,$73,$20,$70,$6C             ; 05B061 DDDDDDDD takes pl
.byte $61,$63,$65,$20,$69,$EE,$A0,$66             ; 05B069 DDDDDDDD ace i??f
.byte $72,$6F,$6E,$74,$20,$6F,$66,$20             ; 05B071 DDDDDDDD ront of 
.byte $61,$20,$73,$74,$75,$64,$69,$6F             ; 05B079 DDDDDDDD a studio
.byte $20,$61,$75,$64,$69,$65,$6E,$63             ; 05B081 DDDDDDDD  audienc
.byte $E5,$A0,$61,$6E,$64,$20,$69,$73             ; 05B089 DDDDDDDD ??and is
.byte $20,$62,$72,$6F,$61,$64,$63,$61             ; 05B091 DDDDDDDD  broadca
.byte $73,$74,$20,$6C,$69,$76,$65,$20             ; 05B099 DDDDDDDD st live 
.byte $76,$69,$E1,$A0,$73,$61,$74,$65             ; 05B0A1 DDDDDDDD vi??sate
.byte $6C,$6C,$69,$74,$65,$20,$61,$72             ; 05B0A9 DDDDDDDD llite ar
.byte $6F,$75,$6E,$64,$20,$74,$68,$65             ; 05B0B1 DDDDDDDD ound the
.byte $20,$77,$6F,$72,$6C,$64,$AE,$A0             ; 05B0B9 DDDDDDDD  world??
.byte $A0,$A0,$A0,$42,$65,$20,$70,$72             ; 05B0C1 DDDDDDDD ???Be pr
.byte $65,$70,$61,$72,$65,$64,$AE,$A0             ; 05B0C9 DDDDDDDD epared??
.byte $A0,$A0,$A0,$54,$68,$65,$20,$66             ; 05B0D1 DDDDDDDD ???The f
.byte $75,$74,$75,$72,$65,$20,$69,$73             ; 05B0D9 DDDDDDDD uture is
.byte $20,$6E,$6F,$77,$AE,$A0,$A0,$A0             ; 05B0E1 DDDDDDDD  now????
.byte $A0,$A0,$59,$6F,$75,$20,$61,$72             ; 05B0E9 DDDDDDDD ??You ar
.byte $65,$20,$74,$68,$65,$20,$6E,$65             ; 05B0F1 DDDDDDDD e the ne
.byte $78,$74,$20,$6C,$75,$63,$6B,$F9             ; 05B0F9 DDDDDDDD xt luck?
.byte $A0,$63,$6F,$6E,$74,$65,$73,$74             ; 05B101 DDDDDDDD ?contest
.byte $61,$6E,$74,$A1,$A0,$A0,$A0,$A0             ; 05B109 DDDDDDDD ant?????
.byte $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0             ; 05B111 DDDDDDDD ????????
.byte $A0,$A0,$A0,$A0,$A0,$00                     ; 05B11A DDDDDD   ??????
D_5B11F:
.byte $A0,$0B,$C0,$0B,$E0,$0B,$00,$08             ; 05B11F ..DD..DD ????????
.byte $20,$08,$40,$08,$60,$08,$80,$08             ; 05B127 ..DD..DD  ?@?`???
.byte $A0,$08,$C0,$08,$E0,$08,$00,$09             ; 05B12F ..DD..DD ????????
.byte $20,$09,$40,$09,$60,$09,$80,$09             ; 05B137 ..DD..DD  ?@?`???
.byte $A0,$09,$C0,$09,$E0,$09,$00,$0A             ; 05B13F ..DD..DD ????????
.byte $20,$0A,$40,$0A,$60,$0A,$80,$0A             ; 05B147 ..DD..DD  ?@?`???
.byte $A0,$0A,$C0,$0A,$E0,$0A,$00,$0B             ; 05B14F ..DD..DD ????????
.byte $20,$0B,$40,$0B,$60,$0B,$80,$0B             ; 05B157 ..DD..DD  ?@?`???
D_5B15F:
.byte $00,$00,$01,$00                             ; 05B160 DDDD     ????
D_5B163:
.byte $02,$04,$03,$04,$04,$04,$05,$04             ; 05B163 DDDDDDDD ????????
.byte $06,$04,$07,$04,$08,$04,$09,$04             ; 05B16B DDDDDDDD ????????
.byte $0A,$04,$0B,$04,$00,$00,$0C,$00             ; 05B173 DDDD.... ????????
.byte $00,$00,$00,$00,$0D,$00,$0E,$00             ; 05B17B DD..DDDD ????????
.byte $0F,$00,$10,$00,$11,$00,$12,$00             ; 05B183 DDDDDDDD ????????
.byte $13,$00,$14,$00,$15,$00,$16,$00             ; 05B18B DDDDDDDD ????????
.byte $17,$00,$18,$10,$00,$00,$18,$10             ; 05B193 ........ ????????
.byte $00,$00,$19,$00,$18,$10,$1A,$00             ; 05B19B ......DD ????????
.byte $1B,$00,$1C,$00,$1D,$00,$1E,$00             ; 05B1A3 DDDDDDDD ????????
.byte $1E,$00,$1F,$00,$20,$00,$21,$00             ; 05B1AB DDDDDDDD ???? ?!?
.byte $21,$40,$22,$00,$23,$00,$24,$00             ; 05B1B3 DDDDDDDD !@"?#?$?
.byte $25,$00,$0D,$00,$26,$00,$0D,$00             ; 05B1BB DDDDDDDD %???&???
.byte $27,$00,$28,$00,$29,$00,$2A,$00             ; 05B1C3 DDDDDDDD '?(?)?*?
.byte $2B,$00,$2C,$00,$2D,$00,$2E,$00             ; 05B1CB DDDDDDDD +?,?-?.?
.byte $2F,$00,$01,$00,$19,$00,$17,$00             ; 05B1D3 DDDDDDDD /???????
.byte $30,$00,$00,$00,$00,$00,$31,$00             ; 05B1DB DD....DD 0?????1?
.byte $32,$00,$33,$00,$34,$00,$35,$00             ; 05B1E3 DDDDDDDD 2?3?4?5?
.byte $36,$00,$31,$00,$37,$00,$38,$00             ; 05B1EB DDDDDDDD 6?1?7?8?
.byte $38,$40,$39,$00,$01,$00,$3A,$00             ; 05B1F3 ..DDDDDD 8@9???:?
.byte $3B,$00,$3C,$00,$3D,$00,$3E,$00             ; 05B1FB DDDDDD.. ;?<?=?>?
.byte $3F,$00,$40,$00,$41,$00,$42,$00             ; 05B203 DDDDDDDD ??@?A?B?
.byte $43,$00,$44,$00,$45,$00,$42,$00             ; 05B20B DDDDDDDD C?D?E?B?
.byte $46,$00,$00,$00,$00,$00,$47,$00             ; 05B213 DD...... F?????G?
.byte $00,$00,$00,$00                             ; 05B21C ....     ????
D_5B21F:
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B21F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B227 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B22F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B237 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B23F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B247 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B24F ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B257 ........ ????????
D_5B25F:
.byte $00,$00,$48,$00                             ; 05B260 DDDD     ??H?
D_5B263:
.byte $49,$04,$4A,$04,$4B,$04,$4C,$04             ; 05B263 DDDDDDDD I?J?K?L?
.byte $4D,$04,$4C,$04,$4E,$04,$4F,$04             ; 05B26B DDDDDDDD M?L?N?O?
.byte $50,$04,$51,$04,$52,$00,$00,$00             ; 05B273 DDDD.... P?Q?R???
.byte $53,$00,$00,$00,$3C,$80,$54,$00             ; 05B27B DD..DDDD S???<?T?
.byte $55,$00,$3C,$80,$54,$00,$56,$00             ; 05B283 DDDDDDDD U?<?T?V?
.byte $3C,$80,$57,$00,$3C,$80,$3C,$80             ; 05B28B DDDDDDDD <?W?<?<?
.byte $47,$00,$18,$10,$00,$00,$18,$10             ; 05B293 ........ G???????
.byte $00,$00,$48,$00,$18,$10,$42,$80             ; 05B29B ......DD ??H???B?
.byte $3D,$80,$3C,$80,$3D,$80,$55,$00             ; 05B2A3 DDDDDDDD =?<?=?U?
.byte $58,$00,$3E,$80,$42,$80,$59,$00             ; 05B2AB DDDDDDDD X?>?B?Y?
.byte $5A,$00,$5B,$00,$55,$00,$44,$80             ; 05B2B3 DDDDDDDD Z?[?U?D?
.byte $5C,$00,$3C,$80,$58,$00,$5D,$00             ; 05B2BB DDDDDDDD \?<?X?]?
.byte $42,$80,$56,$00,$54,$40,$3C,$80             ; 05B2C3 DDDDDDDD B?V?T@<?
.byte $5E,$00,$5F,$00,$60,$00,$54,$40             ; 05B2CB DDDDDDDD ^?_?`?T@
.byte $61,$00,$48,$00,$48,$00,$47,$00             ; 05B2D3 DDDDDDDD a?H?H?G?
.byte $62,$00,$00,$00,$00,$00,$31,$80             ; 05B2DB DD....DD b?????1?
.byte $3D,$80,$33,$80,$31,$80,$33,$80             ; 05B2E3 DDDDDDDD =?3?1?3?
.byte $63,$00,$64,$00,$42,$80,$54,$40             ; 05B2EB DDDDDDDD c?d?B?T@
.byte $65,$00,$42,$80,$54,$40,$66,$00             ; 05B2F3 ..DDDDDD e?B?T@f?
.byte $42,$80,$3C,$80,$67,$00,$68,$00             ; 05B2FB DDDDDD.. B?<?g?h?
.byte $58,$00,$69,$00,$54,$40,$3C,$80             ; 05B303 DDDDDDDD X?i?T@<?
.byte $6A,$00,$6B,$00,$45,$80,$6C,$00             ; 05B30B DDDDDDDD j?k?E?l?
.byte $6D,$00,$00,$00,$00,$00,$00,$00             ; 05B313 DD...... m???????
.byte $00,$00,$00,$00,$E0,$06,$F2,$00             ; 05B31B ....DDDD ????????
.byte $00,$00,$00,$38,$00,$38,$00,$00             ; 05B323 DDDDDDDD ???8?8??
.byte $FE,$00,$80,$7E,$B0,$7E,$A8,$66             ; 05B32B DDDDDDDD ???~?~?f
.byte $A8,$66,$00,$00,$7C,$04,$44,$3C             ; 05B333 DDDDDDDD ?f??|?D<
.byte $44,$3C,$64,$7C,$24,$1C,$24,$1C             ; 05B33B DDDDDDDD D<d|$?$?
.byte $24,$1C,$F8,$FE,$00,$06,$F8,$06             ; 05B343 DDDDDDDD $???????
.byte $80,$7E,$9E,$7E,$78,$78,$06,$40             ; 05B34B DDDDDDDD ?~?~xx?@
.byte $3E,$38,$E0,$00,$8C,$62,$8A,$66             ; 05B353 DDDDDDDD >8???b?f
.byte $8A,$66,$8A,$66,$98,$66,$80,$FC             ; 05B35B DDDDDDDD ?f?f?f??
.byte $02,$82,$80,$60,$9E,$60,$00,$F8             ; 05B363 DDDDDDDD ???`?`??
.byte $04,$84,$7C,$9C,$7C,$98,$08,$06             ; 05B36B DDDDDDDD ??|?|???
.byte $12,$0E,$80,$7E,$B8,$7E,$88,$46             ; 05B373 DDDDDDDD ???~?~?F
.byte $B8,$46,$B8,$7E,$A4,$62,$9C,$62             ; 05B37B DDDDDDDD ?F?~?b?b
.byte $18,$00,$10,$7C,$EE,$00,$EE,$1C             ; 05B383 DDDDDDDD ???|????
.byte $00,$3C,$7C,$1C,$0E,$00,$7E,$00             ; 05B38B DDDDDDDD ?<|???~?
.byte $FC,$3C,$0E,$6C,$00,$CC,$FE,$E0             ; 05B393 DDDDDDDD ?<?l????
.byte $0E,$1C,$FE,$FE,$FF,$00,$FF,$00             ; 05B39B DDDDDDDD ????????
.byte $1E,$FC,$7C,$E6,$00,$E6,$F8,$00             ; 05B3A3 DDDDDDDD ??|?????
.byte $F8,$82,$00,$C6,$8E,$00,$CE,$E0             ; 05B3AB DDDDDDDD ????????
.byte $00,$F0,$00,$78,$1E,$EE,$D6,$00             ; 05B3B3 DDDDDDDD ???x????
.byte $D6,$7C,$70,$00,$70,$60,$00,$50             ; 05B3BB DDDDDDDD ?|p?p`?P
.byte $28,$00,$28,$7E,$E0,$1E,$E6,$00             ; 05B3C3 DDDDDDDD (?(~????
.byte $EC,$6C,$DC,$76,$BC,$E6,$E6,$7C             ; 05B3CB DDDDDDDD ?l?v???|
.byte $C6,$A8,$66,$80,$7E,$7E,$60,$1E             ; 05B3D3 DDDDDDDD ??f?~~`?
.byte $00,$7E,$7E,$80,$60,$00,$06,$80             ; 05B3DB DDDDDDDD ?~~?`???
.byte $7E,$72,$FE,$0A,$06,$0A,$06,$06             ; 05B3E3 DDDDDDDD ~r??????
.byte $80,$66,$80,$20,$58,$48,$38,$90             ; 05B3EB DDDDDDDD ?f? XH8?
.byte $70,$E0,$60,$88,$4E,$04,$02,$3C             ; 05B3F3 DDDDDDDD p?`?N??<
.byte $02,$20,$1E,$1E,$3E,$18,$00,$30             ; 05B3FB DDDDDDDD ? ??>??0
.byte $0E,$DC,$78,$E2,$06,$28,$06,$00             ; 05B403 DDDDDDDD ??x??(??
.byte $05,$7E,$CE,$D6,$00,$44,$78,$70             ; 05B40B DDDDDDDD ?~???Dxp
.byte $39,$80,$DD,$9E,$07,$04,$90,$E8             ; 05B413 DDDDDDDD 9???????
.byte $20,$0D,$00,$42,$70,$02,$E3,$C3             ; 05B41B DDDDDDDD  ??Bp???
.byte $CF,$91,$EF,$CF,$36,$0E,$A3,$2E             ; 05B423 DDDDDDDD ????6??.
.byte $F0,$16,$9E,$3A,$A0,$41,$B8,$10             ; 05B42B DDDDDDDD ???:?A??
.byte $1D,$21,$C8,$04,$9C,$B3,$8E,$93             ; 05B433 DDDDDDDD ?!??????
.byte $84,$2D,$D8,$CF,$A8,$7A,$CC,$FA             ; 05B43B DDDDDDDD ?-???z??
.byte $17,$C1,$7D,$07,$A0,$B0,$EC,$3B             ; 05B443 DDDDDDDD ??}????;
.byte $C4,$0B,$71,$5B,$81,$DC,$64,$F0             ; 05B44B DDDDDDDD ??q[??d?
.byte $2B,$8E,$1B,$FA,$DF,$9C,$0C,$B8             ; 05B453 DDDDDDDD +???????
.byte $02,$F2,$74,$E4,$27,$2D,$38,$79             ; 05B45B DDDDDDDD ??t?'-8y
.byte $6C,$2E,$62,$97,$50,$1E,$A2,$05             ; 05B463 DDDDDDDD l.b?P???
.byte $BE,$B4,$FE,$0C,$5E,$E6,$C1,$E0             ; 05B46B DDDDDDDD ????^???
.byte $0F,$00,$9D,$81,$E8,$69,$71,$47             ; 05B473 DDDDDDDD ?????iqG
.byte $B1,$81,$E8,$CE,$76,$1E,$94,$2E             ; 05B47B DDDDDDDD ????v??.
.byte $BC,$0F,$25,$39,$28,$1B,$5C,$0E             ; 05B483 DDDDDDDD ??%9(?\?
.byte $42,$9F,$3C,$DF,$A2,$7E,$50,$FA             ; 05B48B DDDDDDDD B?<??~P?
.byte $E8,$6A,$E8,$58,$28,$2C,$F1,$06             ; 05B493 DDDDDDDD ?j?X(,??
.byte $D7,$93,$BD,$8E,$E4,$A7,$1A,$84             ; 05B49B DDDDDDDD ????????
.byte $F0,$32,$F2,$49,$3C,$88,$2E,$E8             ; 05B4A3 DDDDDDDD ?2?I<?.?
.byte $A7,$2E,$86,$E7,$81,$CB,$E9,$BE             ; 05B4AB DDDDDDDD ?.??????
.byte $21,$0E,$CF,$5C,$D0,$F0,$A8,$9B             ; 05B4B3 DDDDDDDD !??\????
.byte $AA,$27,$50,$89,$68,$C7,$08,$93             ; 05B4BB DDDDDDDD ?'P?h???
.byte $D8,$1C,$AE,$07,$01,$A7,$09,$85             ; 05B4C3 DDDDDDDD ????????
.byte $C0,$00,$F6,$C8,$76,$69,$A9,$29             ; 05B4CB DDDDDDDD ????vi?)
.byte $3A,$F9,$3E,$04,$78,$24,$E6,$42             ; 05B4D3 DDDDDDDD :?>?x$?B
.byte $DB,$84,$23,$99,$28,$5B,$30,$FA             ; 05B4DB DDDDDDDD ??#?([0?
.byte $09,$E3,$29,$E6,$28,$77,$99,$74             ; 05B4E3 DDDDDDDD ??)?(w?t
.byte $C2,$F5,$E9,$E4,$22,$7A,$D9,$AE             ; 05B4EB DDDDDDDD ????"z??
.byte $60,$7B,$38,$7B,$A9,$3C,$54,$3E             ; 05B4F3 DDDDDDDD `{8{?<T>
.byte $9E,$05,$D9,$43,$F4,$29,$7B,$D0             ; 05B4FB DDDDDDDD ???C?){?
.byte $39,$9A,$27,$E0,$A7,$94,$A9,$7E             ; 05B503 DDDDDDDD 9?'????~
.byte $D2,$37,$DD,$36,$F0,$05,$B5,$FC             ; 05B50B DDDDDDDD ?7?6????
.byte $EE,$24,$34,$22,$9C,$01,$4D,$70             ; 05B513 DDDDDDDD ?$4"??Mp
.byte $A7,$08,$50,$B8,$60,$B6,$90,$B5             ; 05B51B DDDDDDDD ??P?`???
.byte $8A,$70,$C4,$4E,$0D,$9C,$51,$4D             ; 05B523 DDDDDDDD ?p?N??QM
.byte $78,$A7,$17,$C0,$CB,$8A,$65,$D4             ; 05B52B DDDDDDDD x?????e?
.byte $0E,$45,$46,$2A,$89,$E2,$78,$E0             ; 05B533 DDDDDDDD ?EF*??x?
.byte $F0,$87,$15,$FC,$9C,$23,$11,$01             ; 05B53B DDDDDDDD ?????#??
.byte $C9,$84,$8C,$24,$07,$2E,$12,$07             ; 05B543 DDDDDDDD ???$?.??
.byte $2D,$E3,$38,$6B,$79,$30,$04,$07             ; 05B54B DDDDDDDD -?8ky0??
.byte $3A,$82,$31,$50,$1C,$B8,$02,$03             ; 05B553 DDDDDDDD :?1P????
.byte $00,$C8,$CF,$47,$05,$E9,$6A,$63             ; 05B55B DDDDDDDD ???G??jc
.byte $A5,$3A,$72,$9B,$91,$37,$5A,$25             ; 05B563 DDDDDDDD ?:r??7Z%
.byte $AE,$61,$E9,$68,$1A,$FD,$38,$1E             ; 05B56B DDDDDDDD ?a?h??8?
.byte $1D,$4D,$4E,$C0,$9D,$2D,$13,$83             ; 05B573 DDDDDDDD ?MN??-??
.byte $26,$EC,$40,$B7,$B1,$71,$40,$1D             ; 05B57B DDDDDDDD &?@??q@?
.byte $10,$87,$18,$40,$ED,$89,$71,$40             ; 05B583 DDDDDDDD ???@??q@
.byte $5E,$B2,$96,$02,$85,$C6,$38,$1D             ; 05B58B DDDDDDDD ^?????8?
.byte $D1,$38,$92,$76,$E4,$4E,$16,$89             ; 05B593 DDDDDDDD ?8?v?N??
.byte $D5,$30,$EA,$B8,$17,$79,$27,$C4             ; 05B59B DDDDDDDD ?0???y'?
.byte $87,$76,$1D,$B2,$A7,$5D,$D3,$BA             ; 05B5A3 DDDDDDDD ?v???]??
.byte $21,$96,$D2,$EC,$B3,$D4,$14,$D1             ; 05B5AB DDDDDDDD !???????
.byte $49,$DF,$D0,$D6,$19,$DF,$70,$34             ; 05B5B3 DDDDDDDD I?????p4
.byte $EA,$9D,$83,$4F,$20,$81,$B4,$53             ; 05B5BB DDDDDDDD ???O ??S
.byte $C9,$E5,$D6,$41,$78,$36,$1D,$E7             ; 05B5C3 DDDDDDDD ???Ax6??
.byte $03,$C2,$A4,$FA,$60,$1F,$50,$85             ; 05B5CB DDDDDDDD ????`?P?
.byte $C0,$E5,$BC,$28,$24,$00,$00,$00             ; 05B5D3 DDDDDDDD ???($???
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B5DB DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B5E3 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B5EB DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B5F3 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B5FB DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B603 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B60B DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B613 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B61B DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B623 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B62B DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B633 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B63B DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B643 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B64B DDDDDDDD ????????
.byte $00,$35,$0C,$36,$0C,$00,$00,$00             ; 05B653 DDDDDDDD ?5?6????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B65B DDDDDDDD ????????
.byte $00,$37,$0C,$38,$0C,$00,$00,$00             ; 05B663 DDDDDDDD ?7?8????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B66B DDDDDDDD ????????
.byte $00,$01,$0C,$02,$0C,$00,$00,$00             ; 05B673 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B67B DDDDDDDD ????????
.byte $00,$03,$0C,$04,$0C,$00,$00,$00             ; 05B683 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B68B DDDDDDDD ????????
.byte $00,$39,$0C,$0C,$0C,$00,$00,$00             ; 05B693 DDDDDDDD ?9??????
.byte $00,$00,$00,$3A,$08,$3B,$08,$3C             ; 05B69B DDDDDDDD ???:?;?<
.byte $08,$3D,$0C,$3E,$0C,$00,$00,$00             ; 05B6A3 DDDDDDDD ?=?>????
.byte $00,$00,$00,$3F,$08,$40,$08,$41             ; 05B6AB DDDDDDDD ?????@?A
.byte $08,$42,$08,$43,$08,$00,$00,$00             ; 05B6B3 DDDDDDDD ?B?C????
.byte $00,$44,$08,$45,$08,$46,$08,$47             ; 05B6BB DDDDDDDD ?D?E?F?G
.byte $08,$48,$08,$49,$08,$00,$00,$00             ; 05B6C3 DDDDDDDD ?H?I????
.byte $00,$4A,$08,$4B,$08,$4C,$08,$4D             ; 05B6CB DDDDDDDD ?J?K?L?M
.byte $08,$4E,$08,$4F,$08,$00,$00,$00             ; 05B6D3 DDDDDDDD ?N?O????
.byte $00,$50,$08,$51,$08,$52,$08,$53             ; 05B6DB DDDDDDDD ?P?Q?R?S
.byte $08,$54,$08,$55,$08,$00,$00,$56             ; 05B6E3 DDDDDDDD ?T?U???V
.byte $08,$57,$08,$58,$08,$59,$08,$5A             ; 05B6EB DDDDDDDD ?W?X?Y?Z
.byte $08,$5B,$08,$5C,$08,$00,$00,$5D             ; 05B6F3 DDDDDDDD ?[?\???]
.byte $08,$5E,$10,$5F,$10,$00,$00,$60             ; 05B6FB DDDDDDDD ?^?_???`
.byte $10,$61,$08,$62,$08,$00,$00,$63             ; 05B703 DDDDDDDD ?a?b???c
.byte $08,$64,$10,$65,$10,$66,$10,$67             ; 05B70B DDDDDDDD ?d?e?f?g
.byte $10,$68,$08,$69,$08,$00,$00,$00             ; 05B713 DDDDDDDD ?h?i????
.byte $00,$6A,$10,$6B,$10,$6C,$10,$6D             ; 05B71B DDDDDDDD ?j?k?l?m
.byte $10,$6E,$0C,$6F,$0C,$00,$00,$00             ; 05B723 DDDDDDDD ?n?o????
.byte $00,$70,$10,$71,$10,$72,$10,$73             ; 05B72B DDDDDDDD ?p?q?r?s
.byte $10,$74,$0C,$75,$0C,$00,$00,$00             ; 05B733 DDDDDDDD ?t?u????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B73B DDDDDDDD ????????
.byte $00,$76,$08,$77,$08,$00,$00,$00             ; 05B743 DDDDD... ?v?w????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B74B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B753 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B75B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B763 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B76B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B773 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B77B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B783 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B78B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B793 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B79B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B7A3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B7AB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B7B3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B7BB ........ ????????
.byte $00,$35,$0C,$36,$0C,$00,$00,$00             ; 05B7C3 ........ ?5?6????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B7CB ........ ????????
.byte $00,$37,$0C,$38,$0C,$00,$00,$00             ; 05B7D3 ........ ?7?8????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B7DB ........ ????????
.byte $00,$01,$0C,$02,$0C,$00,$00,$00             ; 05B7E3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B7EB ........ ????????
.byte $00,$03,$0C,$04,$0C,$00,$00,$00             ; 05B7F3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B7FB ........ ????????
.byte $00,$39,$0C,$0C,$0C,$00,$00,$00             ; 05B803 ........ ?9??????
.byte $00,$00,$00,$3A,$08,$3B,$08,$3C             ; 05B80B ........ ???:?;?<
.byte $08,$3D,$0C,$3E,$0C,$00,$00,$00             ; 05B813 ........ ?=?>????
.byte $00,$00,$00,$3F,$08,$40,$08,$41             ; 05B81B ........ ?????@?A
.byte $08,$42,$08,$43,$08,$00,$00,$00             ; 05B823 ........ ?B?C????
.byte $00,$78,$08,$45,$08,$46,$08,$47             ; 05B82B ........ ?x?E?F?G
.byte $08,$48,$08,$49,$08,$00,$00,$00             ; 05B833 ........ ?H?I????
.byte $00,$79,$08,$7A,$08,$7B,$08,$4D             ; 05B83B ........ ?y?z?{?M
.byte $08,$4E,$08,$4F,$08,$00,$00,$7C             ; 05B843 ........ ?N?O???|
.byte $08,$7D,$08,$7E,$08,$7F,$08,$53             ; 05B84B ........ ?}?~???S
.byte $08,$54,$08,$55,$08,$00,$00,$80             ; 05B853 ........ ?T?U????
.byte $10,$81,$10,$82,$10,$83,$10,$5A             ; 05B85B ........ ???????Z
.byte $08,$5B,$08,$5C,$08,$00,$00,$84             ; 05B863 ........ ?[?\????
.byte $10,$85,$10,$86,$10,$87,$10,$88             ; 05B86B ........ ????????
.byte $08,$61,$08,$62,$08,$00,$00,$89             ; 05B873 ........ ?a?b????
.byte $10,$8A,$10,$8B,$10,$8C,$10,$8D             ; 05B87B ........ ????????
.byte $08,$8E,$08,$69,$08,$00,$00,$00             ; 05B883 ........ ???i????
.byte $00,$00,$00,$8F,$08,$90,$08,$91             ; 05B88B ........ ????????
.byte $0C,$92,$0C,$6F,$0C,$00,$00,$00             ; 05B893 ........ ???o????
.byte $00,$00,$00,$00,$00,$00,$00,$93             ; 05B89B ........ ????????
.byte $0C,$94,$0C,$95,$0C,$00,$00,$00             ; 05B8A3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B8AB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B8B3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B8BB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B8C3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B8CB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B8D3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B8DB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B8E3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B8EB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B8F3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B8FB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B903 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B90B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B913 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B91B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B923 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B92B ........ ????????
.byte $00,$35,$0C,$36,$0C,$00,$00,$00             ; 05B933 ........ ?5?6????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B93B ........ ????????
.byte $00,$37,$0C,$38,$0C,$00,$00,$00             ; 05B943 ........ ?7?8????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B94B ........ ????????
.byte $00,$01,$0C,$02,$0C,$00,$00,$00             ; 05B953 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B95B ........ ????????
.byte $00,$03,$0C,$04,$0C,$00,$00,$00             ; 05B963 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05B96B ........ ????????
.byte $00,$39,$0C,$0C,$0C,$00,$00,$00             ; 05B973 ........ ?9??????
.byte $00,$00,$00,$3A,$08,$3B,$08,$3C             ; 05B97B ........ ???:?;?<
.byte $08,$3D,$0C,$3E,$0C,$00,$00,$00             ; 05B983 ........ ?=?>????
.byte $00,$00,$00,$96,$08,$97,$08,$98             ; 05B98B ........ ????????
.byte $08,$42,$08,$43,$08,$00,$00,$00             ; 05B993 ........ ?B?C????
.byte $00,$99,$08,$9A,$08,$9B,$08,$9C             ; 05B99B ........ ????????
.byte $08,$48,$08,$49,$08,$9D,$10,$9E             ; 05B9A3 ........ ?H?I????
.byte $10,$9F,$10,$A0,$10,$A1,$08,$A2             ; 05B9AB ........ ????????
.byte $08,$4E,$08,$4F,$08,$A3,$10,$A4             ; 05B9B3 ........ ?N?O????
.byte $10,$A5,$10,$A6,$10,$A7,$08,$53             ; 05B9BB ........ ???????S
.byte $08,$54,$08,$55,$08,$A8,$10,$A9             ; 05B9C3 ........ ?T?U????
.byte $10,$AA,$10,$AB,$10,$AC,$08,$5A             ; 05B9CB ........ ???????Z
.byte $08,$5B,$08,$5C,$08,$AD,$10,$AE             ; 05B9D3 ........ ?[?\????
.byte $10,$AF,$10,$B0,$10,$00,$00,$B1             ; 05B9DB ........ ????????
.byte $08,$61,$08,$62,$08,$00,$00,$B2             ; 05B9E3 ........ ?a?b????
.byte $10,$00,$00,$00,$00,$00,$00,$B3             ; 05B9EB ........ ????????
.byte $08,$68,$08,$69,$08,$00,$00,$00             ; 05B9F3 ........ ?h?i????
.byte $00,$00,$00,$00,$00,$00,$00,$B4             ; 05B9FB ........ ????????
.byte $0C,$B5,$0C,$6F,$0C,$00,$00,$00             ; 05BA03 ........ ???o????
.byte $00,$00,$00,$00,$00,$00,$00,$93             ; 05BA0B ........ ????????
.byte $0C,$94,$0C,$95,$0C,$00,$00,$00             ; 05BA13 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA1B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA23 .....DDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA2B DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA33 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA3B DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA43 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA4B DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA53 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA5B DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA63 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA6B DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA73 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA7B DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA83 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA8B DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BA93 DDDDDDDD ????????
.byte $00,$B6,$08,$B7,$08,$00,$00,$00             ; 05BA9B DDDDDDDD ????????
.byte $00,$35,$0C,$36,$0C,$00,$00,$B8             ; 05BAA3 DDDDDDDD ?5?6????
.byte $10,$B9,$08,$BA,$08,$00,$00,$00             ; 05BAAB DDDDDDDD ????????
.byte $00,$37,$0C,$38,$0C,$00,$00,$BB             ; 05BAB3 DDDDDDDD ?7?8????
.byte $10,$BC,$08,$BD,$08,$00,$00,$00             ; 05BABB DDDDDDDD ????????
.byte $00,$01,$0C,$02,$0C,$00,$00,$BE             ; 05BAC3 DDDDDDDD ????????
.byte $10,$BF,$10,$C0,$08,$00,$00,$00             ; 05BACB DDDDDDDD ????????
.byte $00,$03,$0C,$04,$0C,$C1,$10,$C2             ; 05BAD3 DDDDDDDD ????????
.byte $10,$C3,$10,$00,$00,$00,$00,$00             ; 05BADB DDDDDDDD ????????
.byte $00,$39,$0C,$0C,$08,$C4,$10,$C5             ; 05BAE3 DDDDDDDD ?9??????
.byte $10,$C6,$10,$C7,$08,$3B,$08,$3C             ; 05BAEB DDDDDDDD ?????;?<
.byte $08,$3D,$08,$3E,$0C,$C8,$10,$C9             ; 05BAF3 DDDDDDDD ?=?>????
.byte $10,$CA,$10,$CB,$08,$40,$08,$41             ; 05BAFB DDDDDDDD ?????@?A
.byte $08,$42,$08,$43,$08,$CC,$10,$CD             ; 05BB03 DDDDDDDD ?B?C????
.byte $10,$CE,$10,$CF,$08,$46,$08,$47             ; 05BB0B DDDDDDDD ?????F?G
.byte $08,$48,$08,$49,$08,$D0,$08,$D1             ; 05BB13 DDDDDDDD ?H?I????
.byte $08,$D2,$08,$D3,$08,$D4,$08,$4D             ; 05BB1B DDDDDDDD ???????M
.byte $08,$4E,$08,$4F,$08,$D5,$08,$D6             ; 05BB23 DDDDDDDD ?N?O????
.byte $08,$D7,$08,$D8,$08,$D9,$08,$DA             ; 05BB2B DDDDDDDD ????????
.byte $08,$54,$08,$55,$08,$00,$00,$00             ; 05BB33 DDDDDDDD ?T?U????
.byte $00,$00,$00,$00,$00,$DB,$08,$DC             ; 05BB3B DDDDDDDD ????????
.byte $08,$5B,$08,$5C,$08,$00,$00,$00             ; 05BB43 DDDDDDDD ?[?\????
.byte $00,$00,$00,$00,$00,$00,$00,$B1             ; 05BB4B DDDDDDDD ????????
.byte $08,$61,$08,$62,$08,$00,$00,$00             ; 05BB53 DDDDDDDD ?a?b????
.byte $00,$00,$00,$00,$00,$00,$00,$B3             ; 05BB5B DDDDDDDD ????????
.byte $08,$68,$08,$69,$08,$00,$00,$00             ; 05BB63 DDDDDDDD ?h?i????
.byte $00,$00,$00,$00,$00,$00,$00,$B4             ; 05BB6B DDDDDDDD ????????
.byte $0C,$B5,$0C,$6F,$0C,$00,$00,$00             ; 05BB73 DDDDDDDD ???o????
.byte $00,$00,$00,$00,$00,$00,$00,$93             ; 05BB7B DDDDDDDD ????????
.byte $0C,$94,$0C,$95,$0C,$00,$00,$00             ; 05BB83 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BB8B DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BB93 DDDDD... ????????
.byte $00,$00,$00,$00,$00,$DD,$08,$DE             ; 05BB9B ........ ????????
.byte $08,$00,$00,$00,$00,$00,$00,$00             ; 05BBA3 ........ ????????
.byte $00,$00,$00,$DF,$08,$E0,$08,$E1             ; 05BBAB ........ ????????
.byte $08,$E2,$08,$00,$00,$00,$00,$00             ; 05BBB3 ........ ????????
.byte $00,$00,$00,$E3,$10,$E4,$10,$E5             ; 05BBBB ........ ????????
.byte $08,$E6,$08,$00,$00,$00,$00,$00             ; 05BBC3 ........ ????????
.byte $00,$00,$00,$E7,$10,$E8,$10,$E9             ; 05BBCB ........ ????????
.byte $08,$00,$00,$00,$00,$00,$00,$00             ; 05BBD3 ........ ????????
.byte $00,$EA,$10,$EB,$10,$EC,$10,$00             ; 05BBDB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BBE3 ........ ????????
.byte $00,$ED,$10,$EE,$10,$EF,$10,$00             ; 05BBEB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$F0             ; 05BBF3 ........ ????????
.byte $10,$F1,$10,$F2,$10,$F3,$10,$00             ; 05BBFB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$F4             ; 05BC03 ........ ????????
.byte $10,$F5,$10,$F6,$10,$F7,$10,$00             ; 05BC0B ........ ????????
.byte $00,$35,$0C,$36,$0C,$00,$00,$00             ; 05BC13 ........ ?5?6????
.byte $00,$F8,$10,$F9,$10,$FA,$10,$00             ; 05BC1B ........ ????????
.byte $00,$37,$0C,$38,$0C,$00,$00,$00             ; 05BC23 ........ ?7?8????
.byte $00,$FB,$08,$FC,$08,$FD,$08,$00             ; 05BC2B ........ ????????
.byte $00,$01,$0C,$02,$0C,$00,$00,$00             ; 05BC33 ........ ????????
.byte $00,$FE,$08,$FF,$08,$00,$09,$00             ; 05BC3B ........ ????????
.byte $00,$03,$0C,$04,$0C,$00,$00,$00             ; 05BC43 ........ ????????
.byte $00,$01,$09,$02,$09,$03,$09,$04             ; 05BC4B ........ ????????
.byte $09,$05,$0D,$0C,$0C,$00,$00,$00             ; 05BC53 ........ ????????
.byte $00,$06,$09,$07,$09,$08,$09,$09             ; 05BC5B ........ ????????
.byte $09,$0A,$0D,$3E,$0C,$00,$00,$00             ; 05BC63 ........ ???>????
.byte $00,$0B,$09,$0C,$09,$0D,$09,$0E             ; 05BC6B ........ ????????
.byte $09,$0F,$09,$10,$09,$00,$00,$00             ; 05BC73 ........ ????????
.byte $00,$00,$00,$11,$09,$12,$09,$13             ; 05BC7B ........ ????????
.byte $09,$14,$09,$15,$09,$00,$00,$00             ; 05BC83 ........ ????????
.byte $00,$00,$00,$16,$09,$17,$09,$18             ; 05BC8B ........ ????????
.byte $09,$19,$09,$1A,$09,$00,$00,$00             ; 05BC93 ........ ????????
.byte $00,$00,$00,$00,$00,$1B,$09,$1C             ; 05BC9B ........ ????????
.byte $09,$1D,$09,$1E,$09,$00,$00,$00             ; 05BCA3 ........ ????????
.byte $00,$00,$00,$00,$00,$1F,$09,$20             ; 05BCAB ........ ??????? 
.byte $09,$21,$09,$22,$09,$00,$00,$00             ; 05BCB3 ........ ?!?"????
.byte $00,$00,$00,$00,$00,$23,$09,$24             ; 05BCBB ........ ?????#?$
.byte $09,$25,$09,$26,$09,$00,$00,$00             ; 05BCC3 ........ ?%?&????
.byte $00,$00,$00,$00,$00,$00,$00,$B3             ; 05BCCB ........ ????????
.byte $08,$68,$08,$69,$08,$00,$00,$00             ; 05BCD3 ........ ?h?i????
.byte $00,$00,$00,$00,$00,$00,$00,$B4             ; 05BCDB ........ ????????
.byte $0C,$B5,$0C,$6F,$0C,$00,$00,$00             ; 05BCE3 ........ ???o????
.byte $00,$00,$00,$00,$00,$00,$00,$93             ; 05BCEB ........ ????????
.byte $0C,$94,$0C,$95,$0C,$00,$00,$00             ; 05BCF3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BCFB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD03 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD0B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD13 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD1B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD23 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD2B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD33 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD3B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD43 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD4B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD53 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD5B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD63 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD6B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD73 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD7B ........ ????????
.byte $00,$35,$0C,$36,$0C,$00,$00,$00             ; 05BD83 ........ ?5?6????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD8B ........ ????????
.byte $00,$37,$0C,$38,$0C,$00,$00,$00             ; 05BD93 ........ ?7?8????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BD9B ........ ????????
.byte $00,$01,$0C,$02,$0C,$00,$00,$00             ; 05BDA3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BDAB ........ ????????
.byte $00,$03,$0C,$04,$0C,$00,$00,$00             ; 05BDB3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BDBB ........ ????????
.byte $00,$39,$0C,$0C,$0C,$00,$00,$00             ; 05BDC3 ........ ?9??????
.byte $00,$00,$00,$3A,$08,$3B,$08,$3C             ; 05BDCB ........ ???:?;?<
.byte $08,$3D,$0C,$3E,$0C,$00,$00,$00             ; 05BDD3 ........ ?=?>????
.byte $00,$00,$00,$3F,$08,$40,$08,$41             ; 05BDDB ........ ?????@?A
.byte $08,$42,$08,$43,$08,$00,$00,$00             ; 05BDE3 ........ ?B?C????
.byte $00,$78,$08,$45,$08,$46,$08,$47             ; 05BDEB ........ ?x?E?F?G
.byte $08,$48,$08,$49,$08,$00,$00,$00             ; 05BDF3 ........ ?H?I????
.byte $00,$79,$08,$7A,$08,$7B,$08,$4D             ; 05BDFB ........ ?y?z?{?M
.byte $08,$4E,$08,$4F,$08,$00,$00,$27             ; 05BE03 ........ ?N?O???'
.byte $09,$28,$09,$7E,$08,$29,$09,$53             ; 05BE0B ........ ?(?~?)?S
.byte $08,$54,$08,$55,$08,$00,$00,$2A             ; 05BE13 ........ ?T?U???*
.byte $11,$2B,$0D,$2C,$09,$2D,$09,$5A             ; 05BE1B ........ ?+?,?-?Z
.byte $08,$5B,$08,$5C,$08,$00,$00,$2E             ; 05BE23 ........ ?[?\???.
.byte $11,$2F,$11,$30,$11,$31,$11,$60             ; 05BE2B ........ ?/?0?1?`
.byte $10,$61,$08,$62,$08,$00,$00,$32             ; 05BE33 ........ ?a?b???2
.byte $11,$33,$11,$34,$11,$35,$11,$36             ; 05BE3B ........ ?3?4?5?6
.byte $0D,$37,$09,$69,$08,$00,$00,$00             ; 05BE43 ........ ?7?i????
.byte $00,$38,$11,$39,$11,$3A,$11,$3B             ; 05BE4B ........ ?8?9?:?;
.byte $0D,$B5,$0C,$6F,$0C,$00,$00,$00             ; 05BE53 ........ ???o????
.byte $00,$00,$00,$00,$00,$3C,$11,$3D             ; 05BE5B ........ ?????<?=
.byte $0D,$94,$0C,$95,$0C,$00,$00,$00             ; 05BE63 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05BE6B ........ ????????
.byte $00,$00,$00,$00,$00,$D8,$B5,$48             ; 05BE73 .....DD. ???????H
.byte $B7,$B8,$B8,$28,$BA,$98,$BB,$08             ; 05BE7B ...DD... ???(????
.byte $BD,$C0,$27,$DB,$13,$00,$00,$00             ; 05BE83 .DDDDDDD ??'?????
.byte $1F,$00,$3F,$00,$7E,$05,$3E,$01             ; 05BE8B DDDDDDDD ????~?>?
.byte $3E,$21,$2E,$00,$0B,$01,$1A,$00             ; 05BE93 DDDDDDDD >!.?????
.byte $60,$00,$44,$00,$05,$00,$05,$00             ; 05BE9B DDDDDDDD `?D?????
.byte $25,$00,$34,$01,$34,$00,$04,$01             ; 05BEA3 DDDDDDDD %?4?4???
.byte $FF,$00,$1F,$E0,$00,$00,$FF,$FA             ; 05BEAB DDDDDDDD ????????
.byte $7F,$FF,$FB,$FB,$4C,$FD,$40,$6E             ; 05BEB3 DDDDDDDD ????L?@n
.byte $00,$00,$07,$FF,$80,$0F,$00,$07             ; 05BEBB DDDDDDDD ????????
.byte $B1,$02,$1E,$B1,$12,$00,$02,$00             ; 05BEC3 DDDDDDDD ????????
.byte $3A,$10,$02,$01,$1A,$01,$0A,$01             ; 05BECB DDDDDDDD :???????
.byte $02,$01,$03,$01,$0C,$01,$3C,$01             ; 05BED3 DDDDDDDD ??????<?
.byte $3C,$01,$3D,$05,$72,$3E,$43,$5E             ; 05BEDB DDDDDDDD <?=?r>C^
.byte $73,$72,$FF,$FC,$FF,$F5,$FF,$B5             ; 05BEE3 DDDDDDDD sr??????
.byte $7F,$5C,$7F,$7E,$4C,$EB,$1D,$E3             ; 05BEEB DDDDDDDD ?\?~L???
.byte $01,$FF,$63,$FF,$7B,$FF,$7B,$FF             ; 05BEF3 DDDDDDDD ??c?{?{?
.byte $33,$FF,$01,$FF,$0C,$FD,$30,$7E             ; 05BEFB DDDDDDDD 3?????0~
.byte $F1,$02,$4E,$81,$72,$7E,$0C,$AB             ; 05BF03 DDDDDDDD ??N?r~??
.byte $00,$7E,$81,$7A,$04,$83,$3F,$21             ; 05BF0B DDDDDDDD ?~?z???!
.byte $2F,$01,$24,$00,$34,$00,$EF,$EA             ; 05BF13 DDDDDDDD /?$?4???
.byte $FE,$FE,$3A,$FA,$0C,$FD,$70,$5E             ; 05BF1B DDDDDDDD ??:???p^
.byte $1F,$00,$0F,$C0,$2E,$A1,$F3,$F2             ; 05BF23 DDDDDDDD ????.???
.byte $2C,$3D,$3F,$38,$39,$0E,$8A,$0F             ; 05BF2B DDDDDDDD ,=?89???
.byte $99,$99,$7B,$83,$6F,$8F,$78,$C3             ; 05BF33 DDDDDDDD ??{?o?x?
.byte $36,$02,$FD,$01,$FE,$86,$7F,$96             ; 05BF3B DDDDDDDD 6???????
.byte $6F,$62,$0D,$6C,$10,$77,$0F,$35             ; 05BF43 DDDDDDDD ob?l?w?5
.byte $0B,$1E,$9A,$00,$BF,$A0,$77,$93             ; 05BF4B DDDDDDDD ??????w?
.byte $73,$8B,$6B,$C3,$26,$BF,$40,$4F             ; 05BF53 DDDDDDDD s?k?&?@O
.byte $1F,$6F,$0F,$60,$17,$25,$1B,$39             ; 05BF5B DDDDDDDD ?o?`?%?9
.byte $3F,$2C,$2D,$0E,$8A,$01,$9F,$92             ; 05BF63 DDDDDDDD ?,-?????
.byte $7F,$A0,$79,$AB,$7F,$D7,$3E,$06             ; 05BF6B DDDDDDDD ??y???>?
.byte $F9,$9E,$61,$6B,$07,$47,$1F,$44             ; 05BF73 DDDDDDDD ??ak?G?D
.byte $1B,$29,$07,$00,$7C,$00,$FE,$00             ; 05BF7B DDDDDDDD ?)??|???
.byte $EE,$00,$EE,$E0,$8E,$00,$CE,$FE             ; 05BF83 DDDDDDDD ????????
.byte $FE,$38,$00,$38,$FC,$00,$FC,$E0             ; 05BF8B DDDDDDDD ?8?8????
.byte $00,$F0,$00,$78,$00,$3C,$00,$1E             ; 05BF93 DDDDDDDD ???x?<??
.byte $7C,$E6,$00,$E2,$0E,$08,$00,$0C             ; 05BF9B DDDDDDDD |???????
.byte $0F,$00,$0F,$EF,$00,$EF,$0E,$0E             ; 05BFA3 DDDDDDDD ????????
.byte $00,$CF,$00,$CF,$CE,$CF,$C3,$00             ; 05BFAB DDDDDDDD ????????
.byte $E3,$00,$E3,$80,$00,$80,$0F,$6F             ; 05BFB3 DDDDDDDD ???????o
.byte $00,$2F,$0E,$EF,$E3,$E3,$3E,$00             ; 05BFBB DDDDDDDD ?/????>?
.byte $3E,$00,$1C,$00,$1C,$DC,$00,$DC             ; 05BFC3 DDDDDDDD >???????
.byte $78,$7C,$82,$00,$C6,$76,$D6,$C6             ; 05BFCB DDDDDDDD x|???v??
.byte $EE,$00,$6C,$FC,$10,$01,$07,$03             ; 05BFD3 DDDDDDDD ??l?????
.byte $07,$06,$04,$00,$09,$00,$1A,$02             ; 05BFDB DDDDDDDD ????????
.byte $03,$01,$07,$00,$07,$1F,$01,$00             ; 05BFE3 DDDDDDDD ????????
.byte $00,$60,$60,$30,$B0,$6F,$40,$5E             ; 05BFEB DDDDDDDD ?``0?o@^
.byte $FF,$00,$70,$73,$80,$F0,$C0,$F0             ; 05BFF3 DDDDDDDD ??ps????
.byte $80,$A1,$00,$03,$FF,$8F,$37,$03             ; 05BFFB DDDDDDDD ??????7?
.byte $2F,$08,$1A,$18,$3F,$34,$3F,$20             ; 05C003 DDDDDDDD /????4? 
.byte $27,$7B,$00,$3B,$00,$3B,$00,$3D             ; 05C00B DDDDDDDD '{?;?;?=
.byte $7C,$00,$19,$04,$00,$FF,$1F,$FF             ; 05C013 DDDDDDDD |???????
.byte $FF,$12,$3A,$03,$01,$04,$04,$00             ; 05C01B DDDDDDDD ??:?????
.byte $02,$06,$06,$01,$85,$85,$87,$F8             ; 05C023 DDDDDDDD ????????
.byte $85,$7A,$01,$05,$02,$11,$0E,$0B             ; 05C02B DDDDDDDD ?z??????
.byte $34,$0C,$F0,$3F,$07,$D7,$01,$1D             ; 05C033 DDDDDDDD 4???????
.byte $03,$73,$0F,$EF,$1F,$38,$DF,$1C             ; 05C03B DDDDDDDD ?s???8??
.byte $E3,$00,$7D,$00,$85,$60,$25,$E0             ; 05C043 DDDDDDDD ??}??`%?
.byte $67,$E6,$67,$C2,$C7,$C3,$C7,$07             ; 05C04B DDDDDDDD g?g?????
.byte $3F,$7D,$02,$85,$7A,$45,$FA,$87             ; 05C053 DDDDDDDD ?}??zE??
.byte $F8,$81,$F8,$05,$F8,$04,$F8,$38             ; 05C05B DDDDDDDD ???????8
.byte $C0,$67,$1F,$B7,$8C,$5E,$CB,$6D             ; 05C063 DDDDDDDD ?g???^?m
.byte $E6,$3F,$F0,$3F,$F0,$3F,$FF,$0F             ; 05C06B DDDDDDDD ????????
.byte $FF,$98,$00,$4B,$00,$A6,$01,$9F             ; 05C073 DDDDDDDD ???K????
.byte $02,$C7,$00,$C0,$00,$C0,$00,$04             ; 05C07B DDDDDDDD ????????
.byte $08,$07,$07,$0B,$0B,$0F,$0B,$2F             ; 05C083 DDDDDDDD ???????/
.byte $09,$1A,$0D,$1D,$46,$1F,$03,$07             ; 05C08B DDDDDDDD ????F???
.byte $03,$0F,$07,$1F,$27,$1F,$27,$1F             ; 05C093 DDDDDDDD ????'?'?
.byte $07,$3F,$02,$3F,$40,$3F,$71,$7E             ; 05C09B DDDDDDDD ????@?q~
.byte $B0,$3F,$31,$BE,$A3,$BC,$2C,$B0             ; 05C0A3 DDDDDDDD ??1???,?
.byte $50,$60,$B3,$C3,$4C,$8F,$80,$FF             ; 05C0AB DDDDDDDD P`??L???
.byte $C0,$FF,$C0,$FF,$80,$FF,$03,$FC             ; 05C0B3 DDDDDDDD ????????
.byte $0F,$F0,$C7,$0F,$9B,$0C,$07,$30             ; 05C0BB DDDDDDDD ???????0
.byte $01,$34,$10,$12,$9C,$DF,$0C,$FF             ; 05C0C3 DDDDDDDD ?4??????
.byte $9E,$5F,$0F,$F0,$1F,$E0,$07,$F8             ; 05C0CB DDDDDDDD ?_??????
.byte $09,$FE,$0C,$FF,$C0,$3F,$E0,$1F             ; 05C0D3 DDDDDDDD ????????
.byte $C0,$3F,$D8,$E0,$3C,$C0,$FC,$00             ; 05C0DB DDDDDDDD ????<???
.byte $EC,$0E,$C0,$02,$1F,$00,$A7,$3F             ; 05C0E3 DDDDDDDD ????????
.byte $C0,$0F,$F0,$03,$FC,$20,$DF,$DD             ; 05C0EB DDDDDDDD ????? ??
.byte $20,$47,$38,$28,$1F,$3C,$1F,$9C             ; 05C0F3 DDDDDDDD  G8(?<??
.byte $8F,$D0,$CF,$6F,$60,$6C,$80,$7F             ; 05C0FB DDDDDDDD ???o`l??
.byte $9F,$02,$1C,$15,$09,$3B,$03,$B2             ; 05C103 DDDDDDDD ?????;??
.byte $03,$A1,$02,$41,$C2,$45,$C6,$7F             ; 05C10B DDDDDDDD ???A?E??
.byte $01,$7E,$83,$7C,$83,$7C,$83,$7C             ; 05C113 DDDDDDDD ?~?|?|?|
.byte $C3,$3C,$C7,$38,$91,$1E,$77,$78             ; 05C11B DDDDDDDD ?<?8??wx
.byte $8F,$F1,$3C,$C2,$FE,$02,$F8,$05             ; 05C123 DDDDDDDD ??<?????
.byte $F5,$0D,$F1,$0B,$1F,$E0,$7F,$FE             ; 05C12B DDDDDDDD ????????
.byte $01,$FE,$01,$FC,$03,$FC,$03,$F8             ; 05C133 DDDDDDDD ????????
.byte $07,$28,$E0,$42,$5C,$0C,$BF,$DE             ; 05C13B DDDDDDDD ?(?B\???
.byte $BF,$7F,$3F,$7F,$3F,$5F,$3F,$5F             ; 05C143 DDDDDDDD ?????_?_
.byte $3F,$9F,$7F,$3F,$FF,$7F,$FF,$7F             ; 05C14B DDDDDDDD ????????
.byte $FF,$FF,$FF,$84,$C4,$45,$7E,$95             ; 05C153 DDDDDDDD ?????E~?
.byte $19,$62,$84,$0C,$F7,$C2,$FB,$EA             ; 05C15B DDDDDDDD ?b??????
.byte $F3,$EE,$F7,$04,$FB,$87,$F8,$E1             ; 05C163 DDDDDDDD ????????
.byte $FE,$F8,$FF,$F8,$FC,$04,$FC,$8A             ; 05C16B DDDDDDDD ????????
.byte $BA,$D3,$3F,$80,$FB,$77,$79,$30             ; 05C173 DDDDDDDD ?????wy0
.byte $3C,$96,$18,$C6,$08,$1B,$E0,$89             ; 05C17B DDDDDDDD <???????
.byte $74,$F2,$0C,$F9,$06,$7E,$81,$3F             ; 05C183 DDDDDDDD t????~??
.byte $C0,$1F,$E0,$0F,$F0,$07,$01,$0D             ; 05C18B DDDDDDDD ????????
.byte $07,$0B,$0F,$05,$0D,$1B,$11,$1F             ; 05C193 DDDDDDDD ????????
.byte $00,$1F,$0C,$5F,$10,$07,$00,$0D             ; 05C19B DDDDDDDD ???_????
.byte $02,$09,$06,$11,$0E,$1F,$0C,$3B             ; 05C1A3 DDDDDDDD ???????;
.byte $1C,$17,$38,$27,$38,$45,$C6,$8D             ; 05C1AB DDDDDDDD ??8'8E??
.byte $8E,$7B,$7C,$CF,$F0,$9C,$E0,$99             ; 05C1B3 DDDDDDDD ?{|?????
.byte $E6,$C0,$C7,$38,$8F,$70,$F9,$0B             ; 05C1BB DDDDDDDD ???8?p??
.byte $F9,$0B,$89,$0B,$32,$39,$6C,$75             ; 05C1C3 DDDDDDDD ????29lu
.byte $A1,$34,$DC,$1A,$59,$9B,$F8,$07             ; 05C1CB DDDDDDDD ?4??Y???
.byte $F8,$07,$F8,$07,$C8,$07,$8C,$03             ; 05C1D3 DDDDDDDD ????????
.byte $CC,$03,$E6,$01,$E7,$00,$4F,$3F             ; 05C1DB DDDDDDDD ??????O?
.byte $26,$1F,$81,$9E,$CF,$C0,$60,$E0             ; 05C1E3 DDDDDDDD &?????`?
.byte $1F,$7F,$00,$7F,$FF,$3F,$94,$E7             ; 05C1EB DDDDDDDD ????????
.byte $20,$C7,$D9,$1E,$33,$3C,$E7,$F8             ; 05C1F3 DDDDDDDD  ???3<??
.byte $84,$F8,$77,$87,$3E,$3F,$E0,$07             ; 05C1FB DDDDDDDD ??w?>???
.byte $F8,$3F,$C0,$CA,$0C,$D6,$18,$D6             ; 05C203 DDDDDDDD ????????
.byte $18,$A7,$38,$67,$78,$E7,$F8,$8E             ; 05C20B DDDDDDDD ??8gx???
.byte $F0,$0E,$F0,$1F,$E0,$3F,$C0,$7E             ; 05C213 DDDDDDDD ???????~
.byte $79,$2C,$03,$3D,$23,$7A,$06,$74             ; 05C21B DDDDDDDD y,?=#z?t
.byte $8C,$FC,$0D,$28,$9B,$AD,$9B,$0F             ; 05C223 DDDDDDDD ???(????
.byte $30,$4F,$30,$7F,$00,$7E,$01,$7C             ; 05C22B DDDDDDDD 0O0??~?|
.byte $03,$7C,$03,$78,$07,$78,$07,$37             ; 05C233 DDDDDDDD ?|?x?x?7
.byte $F7,$E1,$E1,$B4,$89,$04,$79,$3F             ; 05C23B DDDDDDDD ??????y?
.byte $FD,$6F,$ED,$85,$87,$95,$A7,$F7             ; 05C243 DDDDDDDD ?o??????
.byte $08,$E1,$1E,$81,$7E,$FE,$11,$FE             ; 05C24B DDDDDDDD ????~???
.byte $79,$FE,$79,$FE,$48,$9B,$5E,$8D             ; 05C253 DDDDDDDD y?y?H?^?
.byte $5D,$84,$CD,$10,$DF,$02,$FB,$25             ; 05C25B DDDDDDDD ]??????%
.byte $29,$B6,$38,$B7,$E7,$E1,$C0,$00             ; 05C263 DDDDDDDD )?8?????
.byte $80,$80,$E3,$E3,$3E,$80,$7F,$F0             ; 05C26B DDDDDDDD ????>???
.byte $0F,$9F,$80,$82,$42,$80,$7F,$E3             ; 05C273 DDDDDDDD ????B???
.byte $1C,$3D,$00,$F8,$03,$FC,$7F,$80             ; 05C27B DDDDDDDD ?=??????
.byte $F0,$00,$07,$07,$F8,$00,$0C,$F0             ; 05C283 DDDDDDDD ????????
.byte $1C,$E0,$72,$80,$F6,$06,$01,$01             ; 05C28B DDDDDDDD ??r?????
.byte $01,$01,$03,$02,$E9,$9F,$68,$1E             ; 05C293 DDDDDDDD ??????h?
.byte $62,$16,$62,$16,$6A,$1E,$6A,$5E             ; 05C29B DDDDDDDD b?b?j?j^
.byte $CF,$DB,$8E,$DD,$78,$07,$F9,$07             ; 05C2A3 DDDDDDDD ????x???
.byte $F1,$0F,$F1,$0F,$F9,$07,$B9,$07             ; 05C2AB DDDDDDDD ????????
.byte $38,$07,$3C,$03,$3D,$6F,$6B,$6D             ; 05C2B3 DDDDDDDD 8?<?=okm
.byte $9C,$79,$53,$9A,$B9,$32,$6E,$74             ; 05C2BB DDDDDDDD ?yS??2nt
.byte $D2,$E4,$38,$CD,$F1,$FE,$F1,$FE             ; 05C2C3 DDDDDDDD ??8?????
.byte $E1,$FE,$E3,$FC,$C3,$FC,$87,$0E             ; 05C2CB DDDDDDDD ????????
.byte $F0,$2A,$B7,$8F,$37,$3F,$03,$4F             ; 05C2D3 DDDDDDDD ?*??7??O
.byte $43,$0F,$01,$07,$80,$03,$E5,$05             ; 05C2DB DDDDDDDD C???????
.byte $2F,$DF,$21,$DC,$72,$92,$C8,$24             ; 05C2E3 DDDDDDDD /?!?r??$
.byte $B4,$6D,$73,$E9,$7E,$ED,$1A,$00             ; 05C2EB DDDDDDDD ?ms?~???
.byte $0E,$01,$1C,$03,$1C,$03,$18,$07             ; 05C2F3 DDDDDDDD ????????
.byte $1C,$03,$3D,$3C,$F0,$CF,$00,$C4             ; 05C2FB DDDDDDDD ??=<????
.byte $1F,$3F,$7A,$FC,$F3,$FB,$CE,$F6             ; 05C303 DDDDDDDD ??z?????
.byte $98,$EE,$C3,$C0,$3F,$01,$FE,$06             ; 05C30B DDDDDDDD ????????
.byte $F9,$0F,$F0,$DC,$3F,$C7,$D7,$4F             ; 05C313 DDDDDDDD ???????O
.byte $4F,$F3,$FC,$FF,$FF,$C0,$E0,$07             ; 05C31B DDDDDDDD O???????
.byte $07,$71,$C0,$3F,$40,$BF,$F0,$0F             ; 05C323 DDDDDDDD ?q??@???
.byte $FF,$00,$E7,$18,$F8,$04,$07,$04             ; 05C32B DDDDDDDD ????????
.byte $06,$05,$05,$07,$03,$00,$E0,$FC             ; 05C333 DDDDDDDD ????????
.byte $E0,$FE,$F0,$78,$F8,$3F,$F8,$1C             ; 05C33B DDDDDDDD ???x????
.byte $E1,$4F,$60,$5C,$43,$5E,$41,$00             ; 05C343 DDDDDDDD ?O`\C^A?
.byte $87,$00,$DF,$00,$F2,$0C,$5B,$A4             ; 05C34B DDDDDDDD ??????[?
.byte $02,$0E,$06,$1E,$0C,$FC,$00,$FE             ; 05C353 DDDDDDDD ????????
.byte $06,$03,$FB,$FF,$01,$0C,$F0,$1A             ; 05C35B DDDDDDDD ????????
.byte $E2,$F4,$04,$E8,$08,$07,$E0,$FC             ; 05C363 DDDDDDDD ????????
.byte $F0,$FF,$7F,$7F,$7F,$7F,$3F,$3F             ; 05C36B DDDDDDDD ????????
.byte $1F,$1F,$9C,$83,$8F,$80,$CF,$C0             ; 05C373 DDDDDDDD ????????
.byte $E7,$E0,$60,$60,$70,$70,$20,$20             ; 05C37B DDDDDDDD ??``pp  
.byte $10,$10,$C5,$01,$53,$43,$34,$D5             ; 05C383 DDDDDDDD ????SC4?
.byte $E3,$03,$43,$0F,$E3,$DF,$B4,$8C             ; 05C38B DDDDDDDD ??C?????
.byte $37,$0F,$07,$F8,$57,$A8,$F8,$7C             ; 05C393 DDDDDDDD 7???W??|
.byte $03,$FF,$72,$7C,$09,$8E,$AC,$CF             ; 05C39B DDDDDDDD ??r|????
.byte $CC,$EF,$CE,$EF,$09,$0E,$03,$0C             ; 05C3A3 DDDDDDDD ????????
.byte $80,$0F,$05,$02,$E7,$20,$E3,$70             ; 05C3AB DDDDDDDD ????? ?p
.byte $F3,$69,$FD,$38,$FC,$94,$7C,$0E             ; 05C3B3 DDDDDDDD ?i?8??|?
.byte $3F,$24,$DF,$12,$BD,$42,$6C,$93             ; 05C3BB DDDDDDDD ?$???Bl?
.byte $E7,$18,$FB,$04,$FF,$00,$FD,$02             ; 05C3C3 DDDDDDDD ????????
.byte $FE,$00,$BE,$FF,$FF,$80,$80,$7F             ; 05C3CB DDDDDDDD ????????
.byte $0F,$30,$26,$19,$97,$05,$01,$FF             ; 05C3D3 DDDDDDDD ?0&?????
.byte $BF,$40,$A0,$60,$FF,$30,$FF,$19             ; 05C3DB DDDDDDDD ?@?`?0??
.byte $7F,$80,$80,$80,$C0,$C0,$60,$60             ; 05C3E3 DDDDDDDD ??????``
.byte $F0,$10,$10,$F0,$F8,$08,$04,$FC             ; 05C3EB DDDDDDDD ????????
.byte $12,$FE,$80,$F8,$D6,$EC,$1C,$1F             ; 05C3F3 DDDDDDDD ????????
.byte $1B,$1F,$1F,$1F,$1F,$1F,$13,$1F             ; 05C3FB DDDDDDDD ????????
.byte $11,$1F,$10,$1F,$10,$1F,$13,$10             ; 05C403 DDDDDDDD ????????
.byte $04,$18,$40,$40,$C0,$C0,$F1,$F3             ; 05C40B DDDDDDDD ??@@????
.byte $64,$65,$01,$0B,$3F,$0B,$BF,$0F             ; 05C413 DDDDDDDD de??????
.byte $00,$9C,$08,$F0,$0F,$0F,$08,$00             ; 05C41B DDDDDDDD ????????
.byte $62,$E2,$17,$36,$3E,$FF,$F2,$FF             ; 05C423 DDDDDDDD b??6>???
.byte $85,$FA,$FF,$FF,$00,$E3,$1C,$0B             ; 05C42B DDDDDDDD ????????
.byte $E4,$00,$73,$1F,$18,$1F,$0C,$0F             ; 05C433 DDDDDDDD ??s?????
.byte $04,$17,$9F,$00,$ED,$00,$F1,$3E             ; 05C43B DDDDDDDD ???????>
.byte $C7,$00,$E3,$0D,$FC,$0F,$3E,$0B             ; 05C443 DDDDDDDD ??????>?
.byte $BF,$05,$FF,$06,$FF,$03,$7F,$11             ; 05C44B DDDDDDDD ????????
.byte $B9,$44,$D1,$2E,$CC,$13,$DE,$01             ; 05C453 DDDDDDDD ?D?.????
.byte $5F,$DF,$88,$EE,$C6,$F3,$EF,$79             ; 05C45B DDDDDDDD _??????y
.byte $77,$DF,$3E,$E9,$97,$F2,$EF,$40             ; 05C463 DDDDDDDD w?>????@
.byte $FD,$0C,$FA,$66,$FF,$31,$FB,$10             ; 05C46B DDDDDDDD ???f?1??
.byte $FF,$88,$FF,$C1,$FE,$61,$D7,$B0             ; 05C473 DDDDDDDD ?????a??
.byte $1F,$02,$FD,$C4,$3B,$E8,$36,$CF             ; 05C47B DDDDDDDD ????;?6?
.byte $00,$BC,$7B,$FE,$17,$F8,$EE,$11             ; 05C483 DDDDDDDD ??{?????
.byte $67,$F1,$73,$FC,$60,$E0,$1F,$20             ; 05C48B DDDDDDDD g?s?`?? 
.byte $CF,$2F,$9F,$BF,$CC,$90,$0F,$8C             ; 05C493 DDDDDDDD ?/??????
.byte $03,$9F,$E0,$CF,$30,$97,$68,$43             ; 05C49B DDDDDDDD ????0?hC
.byte $BC,$F8,$03,$80,$07,$FF,$F7,$C7             ; 05C4A3 DDDDDDDD ????????
.byte $CF,$03,$03,$FC,$07,$F8,$FE,$FF             ; 05C4AB DDDDDDDD ????????
.byte $00,$F7,$3F,$08,$07,$04,$01,$01             ; 05C4B3 DDDDDDDD ????????
.byte $1F,$00,$7F,$78,$3F,$1C,$1F,$0F             ; 05C4BB DDDDDDDD ???x????
.byte $0F,$07,$07,$87,$30,$0F,$C0,$CD             ; 05C4C3 DDDDDDDD ????0???
.byte $E6,$FE,$07,$CF,$01,$C5,$FD,$0D             ; 05C4CB DDDDDDDD ????????
.byte $FD,$FF,$00,$3D,$02,$18,$07,$C8             ; 05C4D3 DDDDDDDD ???=????
.byte $37,$C4,$3B,$C0,$3F,$FD,$02,$F0             ; 05C4DB DDDDDDDD 7?;?????
.byte $00,$86,$4E,$5B,$EF,$6D,$BF,$36             ; 05C4E3 DDDDDDDD ??N[?m?6
.byte $B7,$93,$DB,$C9,$ED,$6C,$7E,$76             ; 05C4EB DDDDDDDD ?????l~v
.byte $FF,$C9,$B6,$A4,$5B,$D2,$6D,$81             ; 05C4F3 DDDDDDDD ????[?m?
.byte $7E,$48,$B7,$24,$9B,$12,$CD,$89             ; 05C4FB DDDDDDDD ~H?$????
.byte $66,$0F,$01,$0B,$00,$88,$80,$C8             ; 05C503 DDDDDDDD f???????
.byte $C0,$C8,$E0,$40,$C0,$80,$80,$20             ; 05C50B DDDDDDDD ???@??? 
.byte $20,$F7,$77,$00,$37,$80,$37,$C0             ; 05C513 DDDDDDDD  ?w?7?7?
.byte $80,$60,$C0,$BD,$B5,$77,$11,$31             ; 05C51B DDDDDDDD ?`???w?1
.byte $30,$0C,$73,$6E,$11,$20,$C0,$A0             ; 05C523 DDDDDDDD 0?sn? ??
.byte $60,$01,$07,$07,$00,$0C,$07,$08             ; 05C52B DDDDDDDD `???????
.byte $0D,$04,$07,$17,$0A,$13,$0C,$16             ; 05C533 DDDDDDDD ????????
.byte $01,$70,$0E,$E0,$19,$0C,$03,$0A             ; 05C53B DDDDDDDD ?p??????
.byte $07,$12,$0F,$15,$0E,$13,$0C,$37             ; 05C543 DDDDDDDD ???????7
.byte $08,$7E,$01,$F8,$07,$45,$C6,$0D             ; 05C54B DDDDDDDD ?~???E??
.byte $0E,$FB,$3C,$F2,$3C,$C4,$38,$26             ; 05C553 DDDDDDDD ??<?<?8&
.byte $D8,$38,$3F,$07,$C7,$C7,$38,$0F             ; 05C55B DDDDDDDD ?8????8?
.byte $F0,$07,$F8,$21,$34,$5C,$9A,$69             ; 05C563 DDDDDDDD ???!4\?i
.byte $8B,$F7,$07,$00,$0B,$1B,$06,$03             ; 05C56B DDDDDDDD ????????
.byte $04,$1F,$00,$81,$77,$02,$FE,$25             ; 05C573 DDDDDDDD ????w??%
.byte $AC,$0C,$8D,$1A,$09,$1B,$09,$0A             ; 05C57B DDDDDDDD ????????
.byte $39,$04,$02,$70,$8F,$F1,$0F,$A3             ; 05C583 DDDDDDDD 9??p????
.byte $5F,$83,$7F,$07,$07,$FF,$FF,$01             ; 05C58B DDDDDDDD _???????
.byte $C3,$F3,$29,$31,$E5,$39,$94,$D9             ; 05C593 DDDDDDDD ??)1?9??
.byte $96,$DB,$A7,$FA,$AB,$32,$59,$62             ; 05C59B DDDDDDDD ?????2Yb
.byte $03,$FC,$C1,$FE,$C1,$C3,$FC,$83             ; 05C5A3 DDDDDDDD ????????
.byte $FC,$A8,$CB,$AE,$CD,$3D,$C4,$3D             ; 05C5AB DDDDDDDD ?????=?=
.byte $C0,$9F,$42,$DB,$25,$F9,$06,$98             ; 05C5B3 DDDDDDDD ??B?%???
.byte $07,$F7,$00,$F3,$3E,$1F,$38,$13             ; 05C5BB DDDDDDDD ????>?8?
.byte $78,$39,$88,$38,$9C,$3C,$9A,$3F             ; 05C5C3 DDDDDDDD x9?8?<??
.byte $CE,$3F,$E5,$37,$00,$24,$03,$76             ; 05C5CB DDDDDDDD ???7?$?v
.byte $09,$AF,$50,$9B,$64,$B9,$46,$FE             ; 05C5D3 DDDDDDDD ??P?d?F?
.byte $FF,$01,$00,$7E,$40,$7F,$20,$20             ; 05C5DB DDDDDDDD ???~@?  
.byte $81,$40,$80,$3F,$C0,$DF,$3F,$EF             ; 05C5E3 DDDDDDDD ?@??????
.byte $10,$E8,$18,$C0,$C3,$C0,$C3,$C1             ; 05C5EB DDDDDDDD ????????
.byte $47,$23,$AF,$F2,$3E,$1C,$1C,$FC             ; 05C5F3 DDDDDDDD G#??>???
.byte $04,$04,$FC,$C6,$38,$6C,$10,$FC             ; 05C5FB DDDDDDDD ????8l??
.byte $00,$F8,$E0,$FC,$5F,$DF,$9F,$9F             ; 05C603 DDDDDDDD ????_???
.byte $9F,$9F,$0F,$0F,$03,$03,$01,$01             ; 05C60B DDDDDDDD ????????
.byte $D8,$58,$18,$18,$1C,$1C,$0C,$0C             ; 05C613 DDDDDDDD ?X??????
.byte $0E,$0E,$9F,$C3,$4F,$49,$77,$44             ; 05C61B DDDDDDDD ????OIwD
.byte $79,$40,$5C,$40,$1F,$00,$27,$26             ; 05C623 DDDDDDDD y@\@??'&
.byte $07,$03,$2F,$00,$27,$3C,$03,$8C             ; 05C62B DDDDDDDD ??/?'<??
.byte $C9,$06,$E5,$81,$31,$00,$F8,$03             ; 05C633 DDDDDDDD ????1???
.byte $FF,$03,$CF,$02,$EF,$01,$7F,$8C             ; 05C63B DDDDDDDD ????????
.byte $BF,$06,$9F,$20,$EE,$11,$74,$0B             ; 05C643 DDDDDDDD ??? ??t?
.byte $73,$04,$37,$00,$97,$00,$FE,$02             ; 05C64B DDDDDDDD s?7?????
.byte $81,$7F,$C4,$7F,$E2,$3B,$F1,$7C             ; 05C653 DDDDDDDD ?????;?|
.byte $3B,$DE,$9D,$F7,$CF,$7A,$FE,$00             ; 05C65B DDDDDDDD ;????z??
.byte $C3,$7E,$F5,$3B,$7E,$19,$7F,$8C             ; 05C663 DDDDDDDD ?~?;~???
.byte $3E,$C4,$BF,$62,$FF,$80,$80,$C0             ; 05C66B DDDDDDDD >??b????
.byte $E8,$40,$E0,$80,$C0,$40,$F0,$00             ; 05C673 DDDDDDDD ?@???@??
.byte $EF,$1F,$FF,$7F,$70,$EC,$6B,$E7             ; 05C67B DDDDDDDD ????p?k?
.byte $E8,$27,$77,$90,$30,$50,$07,$77             ; 05C683 DDDDDDDD ?'w?0P?w
.byte $D0,$F0,$01,$FD,$1C,$03,$08,$00             ; 05C68B DDDDDDDD ????????
.byte $CF,$C0,$E2,$FC,$03,$01,$05,$07             ; 05C693 DDDDDDDD ????????
.byte $00,$1F,$04,$0F,$C7,$E5,$BC,$FB             ; 05C69B DDDDDDDD ????????
.byte $D0,$FF,$43,$1F,$7C,$4F,$BC,$0F             ; 05C6A3 DDDDDDDD ??C?|O??
.byte $1E,$0F,$FF,$18,$F5,$C3,$00,$43             ; 05C6AB DDDDDDDD ???????C
.byte $00,$21,$00,$C0,$BF,$F1,$0E,$7A             ; 05C6B3 DDDDDDDD ?!?????z
.byte $0D,$CC,$C3,$F0,$F3,$39,$FF,$01             ; 05C6BB DDDDDDDD ?????9??
.byte $F3,$00,$F1,$9E,$7F,$C5,$3E,$FB             ; 05C6C3 DDDDDDDD ??????>?
.byte $04,$C6,$01,$F2,$0D,$F1,$0E,$41             ; 05C6CB DDDDDDDD ???????A
.byte $F8,$02,$EE,$29,$F7,$20,$D3,$16             ; 05C6D3 DDDDDDDD ???)? ??
.byte $7B,$9B,$AF,$ED,$CD,$76,$E4,$F3             ; 05C6DB DDDDDDDD {????v??
.byte $8C,$E5,$1A,$90,$6F,$F2,$2D,$69             ; 05C6E3 DDDDDDDD ????o?-i
.byte $96,$34,$DB,$20,$DF,$12,$ED,$F9             ; 05C6EB DDDDDDDD ?4? ????
.byte $F3,$44,$E5,$A1,$EB,$F7,$FB,$80             ; 05C6F3 DDDDDDDD ?D??????
.byte $0F,$C0,$BC,$43,$58,$A7,$08,$F7             ; 05C6FB DDDDDDDD ???CX???
.byte $04,$C0,$30,$27,$1F,$3C,$72,$3B             ; 05C703 DDDDDDDD ??0'?<r;
.byte $1B,$5F,$5D,$7F,$2C,$2F,$26,$1F             ; 05C70B DDDDDDDD ?_]?,/&?
.byte $2D,$0C,$26,$00,$36,$00,$09,$E6             ; 05C713 DDDDDDDD -?&?6???
.byte $44,$B3,$22,$19,$03,$1C,$19,$04             ; 05C71B DDDDDDDD D?"?????
.byte $13,$00,$1D,$00,$0D,$00,$57,$71             ; 05C723 DDDDDDDD ??????Wq
.byte $23,$A4,$88,$CF,$40,$4F,$60,$FF             ; 05C72B DDDDDDDD #???@O`?
.byte $B0,$FF,$7F,$37,$3F,$00,$20,$DF             ; 05C733 DDDDDDDD ???7?? ?
.byte $84,$7B,$47,$B0,$0F,$F0,$9F,$40             ; 05C73B DDDDDDDD ?{G????@
.byte $6F,$36,$3E,$0D,$05,$18,$00,$18             ; 05C743 DDDDDDDD o6>?????
.byte $07,$08,$08,$0F,$00,$2F,$06,$1D             ; 05C74B DDDDDDDD ?????/??
.byte $0D,$1C,$5A,$26,$24,$1F,$20,$1F             ; 05C753 DDDDDDDD ??Z&$? ?
.byte $01,$3E,$02,$3F,$41,$41,$FE,$CB             ; 05C75B DDDDDDDD ?>??AA??
.byte $DF,$27,$6A,$90,$35,$89,$1A,$00             ; 05C763 DDDDDDDD ?'j?5???
.byte $FF,$28,$F7,$16,$F9,$8A,$7D,$45             ; 05C76B DDDDDDDD ?(????}E
.byte $BE,$8C,$BF,$4E,$DF,$40,$BF,$60             ; 05C773 DDDDDDDD ???N?@?`
.byte $DF,$30,$01,$02,$07,$00,$3F,$1D             ; 05C77B DDDDDDDD ?0??????
.byte $07,$00,$2E,$1E,$09,$2B,$34,$2D             ; 05C783 DDDDDDDD ??.??+4-
.byte $16,$4D,$62,$4F,$A9,$01,$C1,$0C             ; 05C78B DDDDDDDD ?MbO????
.byte $E8,$0A,$AC,$08,$10,$7F,$15,$7A             ; 05C793 DDDDDDDD ???????z
.byte $35,$7A,$B7,$78,$F7,$78,$74,$FB             ; 05C79B DDDDDDDD 5z?x?xt?
.byte $72,$FD,$F3,$7C,$44,$0D,$B3,$87             ; 05C7A3 DDDDDDDD r??|D???
.byte $30,$AF,$01,$FE,$A9,$52,$C2,$41             ; 05C7AB DDDDDDDD 0????R?A
.byte $8E,$82,$1B,$0F,$A2,$DF,$54,$EB             ; 05C7B3 DDDDDDDD ??????T?
.byte $CF,$70,$FE,$01,$7E,$81,$7F,$80             ; 05C7BB DDDDDDDD ?p??~???
.byte $FE,$B8,$20,$42,$DC,$0C,$DF,$CE             ; 05C7C3 DDDDDDDD ?? B????
.byte $9F,$1F,$BF,$2F,$EF,$0F,$F7,$07             ; 05C7CB DDDDDDDD ???/????
.byte $77,$9F,$7F,$DF,$3F,$CF,$7F,$DF             ; 05C7D3 DDDDDDDD w???????
.byte $9F,$7F,$CF,$3F,$7F,$8F,$01,$06             ; 05C7DB DDDDDDDD ????????
.byte $01,$1C,$0B,$30,$07,$E1,$6E,$E3             ; 05C7E3 DDDDDDDD ???0??n?
.byte $0D,$04,$03,$1B,$07,$2C,$17,$F2             ; 05C7EB DDDDDDDD ?????,??
.byte $0F,$35,$CE,$73,$2C,$81,$3F,$81             ; 05C7F3 DDDDDDDD ?5?s,???
.byte $3E,$83,$7D,$0F,$77,$7F,$1F,$5F             ; 05C7FB DDDDDDDD >?}?w??_
.byte $4F,$5F,$0E,$61,$1E,$D1,$3E,$65             ; 05C803 DDDDDDDD O_?a??>e
.byte $BE,$99,$7E,$A7,$78,$9F,$BF,$00             ; 05C80B DDDDDDDD ??~?x???
.byte $B9,$BB,$BD,$FF,$DD,$DF,$C9,$6B             ; 05C813 DDDDDDDD ???????k
.byte $41,$67,$C0,$3F,$BC,$1F,$6C,$03             ; 05C81B DDDDDDDD Ag????l?
.byte $02,$7C,$42,$3C,$02,$3C,$22,$1C             ; 05C823 DDDDDDDD ?|B<?<"?
.byte $A6,$18,$BF,$95,$03,$B5,$9E,$F6             ; 05C82B DDDDDDDD ????????
.byte $A9,$28,$EF,$07,$71,$80,$9C,$DA             ; 05C833 DDDDDDDD ?(??q???
.byte $29,$AB,$70,$0F,$61,$1E,$EF,$10             ; 05C83B DDDDDDDD )?p?a???
.byte $FC,$57,$80,$1F,$7F,$86,$FF,$C1             ; 05C843 DDDDDDDD ?W??????
.byte $1E,$4F,$40,$6F,$9F,$3F,$03,$02             ; 05C84B DDDDDDDD ?O@o????
.byte $04,$03,$08,$18,$07,$09,$0F,$2E             ; 05C853 DDDDDDDD ???????.
.byte $04,$29,$02,$07,$0C,$07,$01,$0F             ; 05C85B DDDDDDDD ?)??????
.byte $12,$0F,$1D,$06,$17,$08,$1E,$00             ; 05C863 DDDDDDDD ????????
.byte $57,$8A,$1F,$C4,$1F,$DF,$5F,$D7             ; 05C86B DDDDDDDD W?????_?
.byte $CF,$8F,$9F,$1F,$5F,$1F,$DF,$4E             ; 05C873 DDDDDDDD ????_??N
.byte $E3,$9C,$27,$D8,$BF,$FF,$00,$BE             ; 05C87B DDDDDDDD ??'?????
.byte $1C,$7D,$38,$BB,$10,$86,$80,$ED             ; 05C883 DDDDDDDD ?}8?????
.byte $C0,$D3,$81,$B1,$00,$6E,$04,$7F             ; 05C88B DDDDDDDD ?????n??
.byte $F9,$9F,$00,$D8,$0F,$B1,$1F,$72             ; 05C893 DDDDDDDD ???????r
.byte $2F,$E4,$79,$C0,$FD,$90,$FB,$61             ; 05C89B DDDDDDDD /?y????a
.byte $F7,$23,$17,$3A,$07,$75,$0E,$EB             ; 05C8A3 DDDDDDDD ?#?:?u??
.byte $1C,$E9,$1E,$D5,$3A,$BB,$64,$76             ; 05C8AB DDDDDDDD ????:?dv
.byte $88,$F4,$08,$78,$BB,$6E,$BD,$7D             ; 05C8B3 DDDDDDDD ???x?n?}
.byte $A4,$3D,$A0,$BF,$22,$5B,$65,$B9             ; 05C8BB DDDDDDDD ?=??"[e?
.byte $C6,$58,$87,$C7,$C3,$C1,$25,$00             ; 05C8C3 DDDDDDDD ?X????%?
.byte $2B,$01,$3F,$37,$3F,$37,$3F,$38             ; 05C8CB DDDDDDDD +??7?7?8
.byte $3F,$3B,$1B,$00,$17,$30,$3F,$30             ; 05C8D3 DDDDDDDD ?;???0?0
.byte $3C,$3B,$37,$30,$EE,$C4,$ED,$E0             ; 05C8DB DDDDDDDD <;70????
.byte $F1,$E0,$F3,$90,$F4,$A0,$EC,$40             ; 05C8E3 DDDDDDDD ???????@
.byte $DB,$80,$B7,$9C,$60,$BB,$40,$73             ; 05C8EB DDDDDDDD ????`?@s
.byte $80,$E7,$DE,$0D,$DC,$0F,$B9,$1E             ; 05C8F3 DDDDDDDD ????????
.byte $70,$3F,$E0,$7E,$5C,$35,$09,$0F             ; 05C8FB DDDDDDDD p??~\5??
.byte $F3,$7F,$3D,$03,$3C,$03,$7A,$07             ; 05C903 DDDDDDDD ??=?<?z?
.byte $F5,$0E,$EA,$1D,$DD,$22,$80,$47             ; 05C90B DDDDDDDD ?????"?G
.byte $EF,$8F,$DF,$0E,$DE,$1C,$BC,$38             ; 05C913 DDDDDDDD ???????8
.byte $F8,$70,$F0,$E0,$E0,$C0,$C0,$68             ; 05C91B DDDDDDDD ?p?????h
.byte $90,$D3,$23,$D6,$26,$A4,$44,$C8             ; 05C923 DDDDDDDD ??#?&?D?
.byte $08,$90,$10,$20,$20,$40,$40,$9E             ; 05C92B DDDDDDDD ???  @@?
.byte $07,$1F,$07,$1F,$03,$0F,$03,$3C             ; 05C933 DDDDDDDD ???????<
.byte $3A,$3E,$1B,$1F,$19,$23,$20,$35             ; 05C93B DDDDDDDD :>???# 5
.byte $30,$15,$11,$16,$04,$04,$6F,$07             ; 05C943 DDDDDDDD 0?????o?
.byte $DE,$0F,$3C,$1F,$D9,$DE,$8F,$FF             ; 05C94B DDDDDDDD ??<?????
.byte $DF,$FF,$9F,$00,$3E,$01,$FD,$03             ; 05C953 DDDDDDDD ????>???
.byte $FA,$C7,$00,$71,$01,$23,$03,$23             ; 05C95B DDDDDDDD ???q?#?#
.byte $DF,$6F,$BF,$FE,$3E,$FC,$7C,$F8             ; 05C963 DDDDDDDD ?o??>?|?
.byte $F8,$E0,$E0,$5C,$E0,$91,$C1,$42             ; 05C96B DDDDDDDD ???\???B
.byte $82,$8C,$0C,$78,$78,$10,$30,$09             ; 05C973 DDDDDDDD ???xx?0?
.byte $19,$0F,$00,$06,$00,$FC,$FC,$0B             ; 05C97B DDDDDDDD ????????
.byte $18,$1C,$18,$18,$18,$10,$10,$1C             ; 05C983 DDDDDDDD ????????
.byte $10,$1B,$14,$19,$16,$11,$1E,$10             ; 05C98B DDDDDDDD ????????
.byte $18,$0F,$2E,$03,$07,$00,$37,$F0             ; 05C993 DDDDDDDD ??.???7?
.byte $0C,$0E,$10,$10,$13,$1B,$29,$3F             ; 05C99B DDDDDDDD ??????)?
.byte $5C,$5E,$CD,$CD,$C6,$F6,$12,$1C             ; 05C9A3 DDDDDDDD \^??????
.byte $02,$0D,$01,$1E,$08,$17,$14,$23             ; 05C9AB DDDDDDDD ???????#
.byte $02,$79,$83,$FC,$31,$CE,$0F,$E0             ; 05C9B3 DDDDDDDD ?y??1???
.byte $04,$08,$00,$D8,$00,$38,$98,$80             ; 05C9BB DDDDDDDD ?????8??
.byte $D0,$24,$55,$27,$1F,$0C,$F0,$DC             ; 05C9C3 DDDDDDDD ?$U'????
.byte $20,$7C,$80,$3C,$C0,$3C,$C0,$F2             ; 05C9CB DDDDDDDD  |?<?<??
.byte $0C,$F0,$0E,$B8,$46,$02,$02,$02             ; 05C9D3 DDDDDDDD ????F???
.byte $04,$02,$04,$0E,$00,$0D,$0D,$01             ; 05C9DB DDDDDDDD ????????
.byte $02,$05,$0A,$05,$0A,$05,$0E,$01             ; 05C9E3 DDDDDDDD ????????
.byte $B0,$B6,$98,$9A,$00,$6A,$6E,$24             ; 05C9EB DDDDDDDD ?????jn$
.byte $6E,$07,$7F,$2E,$7A,$07,$F8,$03             ; 05C9F3 DDDDDDDD n??.z???
.byte $FC,$6B,$94,$7F,$80,$6F,$90,$4B             ; 05C9FB DDDDDDDD ?k???o?K
.byte $90,$78,$80,$51,$80,$22,$4E,$B0             ; 05CA03 DDDDDDDD ?x?Q?"N?
.byte $DE,$3D,$5B,$A8,$D9,$23,$2C,$80             ; 05CA0B DDDDDDDD ?=[??#,?
.byte $DC,$8E,$92,$9A,$6F,$66,$00,$DE             ; 05CA13 DDDDDDDD ????of??
.byte $5C,$20,$9C,$60,$0D,$09,$0B,$05             ; 05CA1B DDDDDDDD \ ?`????
.byte $17,$00,$3F,$07,$3B,$36,$36,$1F             ; 05CA23 DDDDDDDD ????;66?
.byte $76,$4F,$EF,$37,$1A,$05,$18,$06             ; 05CA2B DDDDDDDD vO?7????
.byte $1D,$02,$17,$08,$32,$0D,$56,$29             ; 05CA33 DDDDDDDD ????2?V)
.byte $46,$39,$67,$18,$1E,$7F,$07,$7F             ; 05CA3B DDDDDDDD F9g?????
.byte $87,$BF,$E3,$6F,$FB,$97,$FF,$C7             ; 05CA43 DDDDDDDD ???o????
.byte $C4,$80,$D0,$00,$61,$80,$F8,$9C             ; 05CA4B DDDDDDDD ????a???
.byte $00,$E4,$00,$C2,$02,$F8,$00,$A8             ; 05CA53 DDDDDDDD ????????
.byte $00,$90,$24,$68,$88,$E0,$C0,$B8             ; 05CA5B DDDDDDDD ??$h????
.byte $F0,$EF,$57,$FF,$8F,$CF,$46,$F7             ; 05CA63 DDDDDDDD ??W???F?
.byte $00,$CD,$E0,$DB,$B0,$DE,$BC,$BE             ; 05CA6B DDDDDDDD ????????
.byte $D8,$67,$18,$8F,$50,$7F,$80,$4F             ; 05CA73 DDDDDDDD ?g??P??O
.byte $A0,$D3,$9F,$60,$9F,$60,$A8,$00             ; 05CA7B DDDDDDDD ???`?`??
.byte $98,$08,$58,$10,$58,$08,$18,$00             ; 05CA83 DDDDDDDD ??X?X???
.byte $F8,$08,$B8,$00,$38,$10,$D8,$B0             ; 05CA8B DDDDDDDD ????8???
.byte $08,$A8,$10,$E0,$78,$0F,$04,$0B             ; 05CA93 DDDDDDDD ????x???
.byte $0E,$09,$06,$1C,$13,$1E,$15,$3E             ; 05CA9B DDDDDDDD ???????>
.byte $29,$3F,$11,$7E,$4A,$0D,$00,$0A             ; 05CAA3 DDDDDDDD )??~J???
.byte $04,$10,$0E,$1A,$07,$35,$0B,$2C             ; 05CAAB DDDDDDDD ?????5?,
.byte $13,$59,$26,$5B,$24,$BD,$58,$7D             ; 05CAB3 DDDDDDDD ?Y&[$?X}
.byte $B8,$7C,$B0,$FB,$10,$7A,$80,$5F             ; 05CABB DDDDDDDD ?|???z?_
.byte $80,$F5,$20,$F5,$61,$1E,$E0,$3E             ; 05CAC3 DDDDDDDD ?? ?a??>
.byte $C0,$3F,$C0,$3C,$40,$1D,$80,$20             ; 05CACB DDDDDDDD ???<@?? 
.byte $C0,$FB,$00,$FB,$00,$70,$10,$70             ; 05CAD3 DDDDDDDD ?????p?p
.byte $20,$F0,$60,$F0,$A0,$20,$E0,$80             ; 05CADB DDDDDDDD  ?`?? ??
.byte $E0,$03,$7E,$30,$FD,$B0,$FD,$80             ; 05CAE3 DDDDDDDD ??~0????
.byte $FB,$29,$FB,$73,$77,$21,$F7,$85             ; 05CAEB DDDDDDDD ?)?sw!??
.byte $AF,$83,$B3,$4C,$B7,$48,$87,$78             ; 05CAF3 DDDDDDDD ???L?H?x
.byte $AF,$50,$7D,$02,$7B,$04,$EB,$61             ; 05CAFB DDDDDDDD ?P}?{??a
.byte $EB,$C1,$EB,$C1,$F7,$C0,$F7,$82             ; 05CB03 DDDDDDDD ????????
.byte $F6,$83,$CF,$82,$CF,$05,$EE,$01             ; 05CB0B DDDDDDDD ????????
.byte $EE,$01,$EE,$FD,$02,$C0,$80,$40             ; 05CB13 DDDDDDDD ???????@
.byte $DE,$DE,$F1,$BF,$C0,$A3,$C8,$A8             ; 05CB1B DDDDDDDD ????????
.byte $9C,$5C,$C0,$40,$80,$D2,$12,$CE             ; 05CB23 DDDDDDDD ?\?@????
.byte $A0,$06,$03,$0B,$0D,$05,$0F,$0D             ; 05CB2B DDDDDDDD ????????
.byte $0F,$85,$D4,$67,$57,$52,$B7,$A0             ; 05CB33 DDDDDDDD ???gWR??
.byte $67,$07,$0B,$07,$1B,$07,$33,$0F             ; 05CB3B DDDDDDDD g?????3?
.byte $0F,$60,$9F,$CF,$C3,$AF,$E0,$3B             ; 05CB43 DDDDDDDD ?`?????;
.byte $F8,$1F,$FF,$98,$FF,$98,$FE,$DC             ; 05CB4B DDDDDDDD ????????
.byte $FE,$FE,$FF,$3F,$00,$5F,$E0,$00             ; 05CB53 DDDDDDDD ?????_??
.byte $67,$00,$66,$01,$22,$DF,$0D,$BF             ; 05CB5B DDDDDDDD g?f?"???
.byte $0A,$3F,$09,$C7,$E7,$06,$EF,$C6             ; 05CB63 DDDDDDDD ????????
.byte $CF,$06,$1F,$0E,$BF,$FD,$02,$DB             ; 05CB6B DDDDDDDD ????????
.byte $04,$DE,$00,$20,$18,$E9,$10,$09             ; 05CB73 DDDDDDDD ??? ????
.byte $F0,$19,$E0,$B1,$40,$BE,$76,$3E             ; 05CB7B DDDDDDDD ????@?v>
.byte $BE,$1C,$9C,$18,$98,$C0,$C8,$3F             ; 05CB83 DDDDDDDD ????????
.byte $80,$7F,$80,$7F,$C0,$3F,$B0,$16             ; 05CB8B DDDDDDDD ????????
.byte $93,$15,$9D,$01,$58,$41,$C9,$C0             ; 05CB93 DDDDDDDD ????XA??
.byte $89,$C8,$9B,$D2,$13,$D6,$30,$CF             ; 05CB9B DDDDDDDD ??????0?
.byte $31,$CE,$31,$CE,$71,$8E,$F1,$0E             ; 05CBA3 DDDDDDDD 1?1?q???
.byte $F9,$06,$EB,$04,$EF,$00,$43,$C3             ; 05CBAB DDDDDDDD ??????C?
.byte $6A,$E0,$26,$60,$33,$31,$19,$39             ; 05CBB3 DDDDDDDD j?&`31?9
.byte $0C,$1D,$06,$0E,$03,$07,$3E,$FF             ; 05CBBB DDDDDDDD ??????>?
.byte $8C,$0C,$6E,$0E,$F7,$E7,$FB,$13             ; 05CBC3 DDDDDDDD ??n?????
.byte $DD,$61,$76,$A8,$12,$64,$C1,$F1             ; 05CBCB DDDDDDDD ?av??d??
.byte $1C,$E0,$0E,$F0,$8F,$70,$C7,$38             ; 05CBD3 DDDDDDDD ?????p?8
.byte $02,$E3,$DE,$3F,$71,$0E,$3F,$00             ; 05CBDB DDDDDDDD ????q???
.byte $8C,$80,$C1,$C1,$7F,$5B,$9A,$F9             ; 05CBE3 DDDDDDDD ?????[??
.byte $38,$B4,$3C,$2E,$3E,$77,$77,$8B             ; 05CBEB DDDDDDDD 8?<.>ww?
.byte $83,$D4,$C9,$0B,$35,$E7,$88,$FE             ; 05CBF3 DDDDDDDD ????5???
.byte $21,$34,$DC,$DA,$39,$FB,$26,$81             ; 05CBFB DDDDDDDD !4??9?&?
.byte $B2,$68,$E7,$1B,$38,$03,$0F,$73             ; 05CC03 DDDDDDDD ?h??8??s
.byte $0C,$07,$07,$33,$C3,$0C,$F0,$80             ; 05CC0B DDDDDDDD ???3????
.byte $80,$F8,$7F,$C4,$C2,$BE,$BC,$FF             ; 05CC13 DDDDDDDD ????????
.byte $FF,$3D,$3E,$40,$3F,$1A,$F9,$8D             ; 05CC1B DDDDDDDD ?=>@????
.byte $FC,$8F,$F6,$0E,$F2,$0F,$31,$1B             ; 05CC23 DDDDDDDD ??????1?
.byte $24,$39,$06,$1C,$07,$80,$7F,$60             ; 05CC2B DDDDDDDD $9?????`
.byte $1F,$B0,$8F,$DF,$40,$A2,$62,$1D             ; 05CC33 DDDDDDDD ????@?b?
.byte $00,$1E,$03,$07,$65,$85,$F8,$04             ; 05CC3B DDDDDDDD ????e???
.byte $01,$0E,$0F,$10,$10,$11,$1D,$20             ; 05CC43 DDDDDDDD ??????? 
.byte $33,$58,$79,$CE,$FE,$C3,$F7,$03             ; 05CC4B DDDDDDDD 3Xy?????
.byte $EE,$01,$0C,$13,$1E,$21,$03,$7C             ; 05CC53 DDDDDDDD ?????!?|
.byte $81,$FE,$30,$CF,$1F,$E0,$02,$04             ; 05CC5B DDDDDDDD ??0?????
.byte $00,$6C,$80,$9C,$CC,$C0,$64,$60             ; 05CC63 DDDDDDDD ?l????d`
.byte $C0,$E8,$12,$2A,$13,$0F,$06,$F8             ; 05CC6B DDDDDDDD ???*????
.byte $EE,$10,$3E,$C0,$1E,$E0,$1E,$E0             ; 05CC73 DDDDDDDD ??>?????
.byte $F9,$06,$F8,$07,$DC,$23,$80,$B0             ; 05CC7B DDDDDDDD ?????#??
.byte $B7,$9C,$9D,$04,$6D,$04,$7F,$24             ; 05CC83 DDDDDDDD ????m??$
.byte $6F,$04,$6F,$26,$6F,$07,$7F,$07             ; 05CC8B DDDDDDDD o?o&o???
.byte $F8,$01,$FA,$69,$92,$7B,$80,$4B             ; 05CC93 DDDDDDDD ???i?{?K
.byte $90,$6B,$90,$49,$11,$27,$58,$6F             ; 05CC9B DDDDDDDD ?k?I?'Xo
.byte $1E,$2D,$54,$6C,$EC,$4B,$90,$17             ; 05CCA3 DDDDDDDD ?-Tl?K??
.byte $41,$6E,$C6,$C8,$FE,$01,$B7,$B3             ; 05CCAB DDDDDDDD An??????
.byte $00,$B7,$9F,$00,$2F,$0B,$0F,$1F             ; 05CCB3 DDDDDDDD ????/???
.byte $16,$1E,$17,$3E,$27,$01,$02,$08             ; 05CCBB DDDDDDDD ???>'???
.byte $07,$1B,$04,$16,$09,$36,$09,$26             ; 05CCC3 DDDDDDDD ?????6?&
.byte $19,$2F,$7F,$1F,$7F,$83,$BF,$C3             ; 05CCCB DDDDDDDD ?/??????
.byte $DF,$E1,$8F,$E1,$C7,$E3,$C3,$E5             ; 05CCD3 DDDDDDDD ????????
.byte $81,$52,$82,$64,$84,$BC,$40,$FE             ; 05CCDB DDDDDDDD ?R?d??@?
.byte $00,$FD,$01,$FB,$01,$4C,$00,$C8             ; 05CCE3 DDDDDDDD ?????L??
.byte $10,$30,$40,$70,$00,$30,$30,$30             ; 05CCEB DDDDDDDD ?0@p?000
.byte $DE,$20,$02,$01,$3E,$2F,$3F,$2E             ; 05CCF3 DDDDDDDD ? ??>/?.
.byte $7F,$6C,$FD,$03,$E7,$B9,$FB,$6E             ; 05CCFB DDDDDDDD ?l?????n
.byte $FA,$75,$FB,$F7,$2E,$11,$6E,$11             ; 05CD03 DDDDDDDD ?u??.?n?
.byte $6C,$13,$05,$02,$A1,$58,$6A,$94             ; 05CD0B DDDDDDDD l????Xj?
.byte $70,$8F,$F3,$0C,$E4,$80,$E4,$80             ; 05CD13 DDDDDDDD p???????
.byte $E5,$80,$E9,$80,$EA,$80,$EB,$40             ; 05CD1B DDDDDDDD ???????@
.byte $EA,$00,$4E,$C0,$FA,$FB,$F6,$76             ; 05CD23 DDDDDDDD ??N????v
.byte $80,$03,$02,$07,$0D,$07,$0D,$0F             ; 05CD2B DDDDDDDD ????????
.byte $0B,$0D,$13,$0F,$1F,$1F,$07,$00             ; 05CD33 DDDDDDDD ????????
.byte $05,$02,$03,$F7,$EB,$F7,$EB,$E7             ; 05CD3B DDDDDDDD ????????
.byte $FF,$EF,$F7,$EF,$D6,$EF,$DE,$FF             ; 05CD43 DDDDDDDD ????????
.byte $CE,$DF,$AE,$E3,$1C,$E3,$1C,$E7             ; 05CD4B DDDDDDDD ????????
.byte $18,$E7,$18,$C7,$38,$CF,$30,$CF             ; 05CD53 DDDDDDDD ????8?0?
.byte $30,$8F,$70,$F6,$80,$FA,$02,$F6             ; 05CD5B DDDDDDDD 0?p?????
.byte $DE,$02,$DC,$04,$EC,$04,$EC,$04             ; 05CD63 DDDDDDDD ????????
.byte $EE,$01,$27,$38,$3B,$3C,$5F,$7C             ; 05CD6B DDDDDDDD ??'8;<_|
.byte $7F,$78,$BF,$F8,$7D,$F1,$7C,$F1             ; 05CD73 DDDDDDDD ?x??}?|?
.byte $03,$00,$24,$18,$3A,$04,$5E,$20             ; 05CD7B DDDDDDDD ??$?:?^ 
.byte $7E,$00,$BE,$40,$7F,$80,$7E,$81             ; 05CD83 DDDDDDDD ~??@??~?
.byte $DF,$BE,$DF,$3E,$FF,$3E,$FF,$44             ; 05CD8B DDDDDDDD ???>?>?D
.byte $3F,$E0,$23,$FC,$7E,$BE,$7F,$F0             ; 05CD93 DDDDDDDD ??#?~???
.byte $3F,$00,$4F,$80,$31,$C0,$22,$DC             ; 05CD9B DDDDDDDD ??O?1?"?
.byte $BC,$04,$BC,$00,$DC,$08,$58,$08             ; 05CDA3 DDDDDDDD ??????X?
.byte $10,$10,$B8,$00,$B8,$F8,$01,$03             ; 05CDAB DDDDDDDD ????????
.byte $FA,$E1,$FA,$E1,$FA,$E1,$F7,$E2             ; 05CDB3 DDDDDDDD ????????
.byte $F7,$E0,$F5,$C3,$FD,$C3,$DF,$F1             ; 05CDBB DDDDDDDD ????????
.byte $FC,$01,$FC,$01,$FC,$01,$FA,$01             ; 05CDC3 DDDDDDDD ????????
.byte $F8,$03,$F9,$02,$75,$02,$25,$02             ; 05CDCB DDDDDDDD ????u?%?
.byte $7E,$F0,$FE,$70,$FE,$60,$FC,$E0             ; 05CDD3 DDDDDDDD ~??p?`??
.byte $FD,$E0,$FD,$F9,$30,$10,$B0,$10             ; 05CDDB DDDDDDDD ????0???
.byte $B0,$00,$B0,$00,$20,$60,$20,$60             ; 05CDE3 DDDDDDDD ???? ` `
.byte $20,$F0,$00,$70,$00,$70,$CF,$FC             ; 05CDEB DDDDDDDD  ??p?p??
.byte $C7,$FF,$E3,$EF,$E0,$E3,$E8,$E9             ; 05CDF3 DDDDDDDD ????????
.byte $EC,$FD,$D0,$FF,$90,$FF,$31,$0C             ; 05CDFB DDDDDDDD ??????1?
.byte $10,$03,$1C,$01,$1E,$11,$0E,$AF             ; 05CE03 DDDDDDDD ????????
.byte $80,$EF,$80,$FA,$00,$D2,$80,$F2             ; 05CE0B DDDDDDDD ????????
.byte $E0,$FE,$FE,$FD,$0D,$00,$E0,$20             ; 05CE13 DDDDDDDD ??????? 
.byte $40,$C0,$80,$80,$00,$9C,$9B,$FF             ; 05CE1B DDDDDDDD @???????
.byte $68,$CC,$F0,$CE,$F0,$CB,$15,$CD             ; 05CE23 DDDDDDDD h???????
.byte $90,$69,$74,$09,$34,$07,$60,$97             ; 05CE2B DDDDDDDD ?it?4?`?
.byte $60,$1E,$E0,$99,$66,$31,$D1,$B0             ; 05CE33 DDDDDDDD `???f1??
.byte $2F,$61,$75,$C0,$CE,$A4,$9F,$2E             ; 05CE3B DDDDDDDD /au????.
.byte $1F,$2E,$1F,$29,$19,$EE,$91,$0E             ; 05CE43 DDDDDDDD ?.?)????
.byte $20,$1F,$1F,$E6,$1F,$00,$A0,$60             ; 05CE4B DDDDDDDD  ??????`
.byte $20,$20,$60,$00,$40,$20,$60,$80             ; 05CE53 DDDDDDDD   `?@ `?
.byte $60,$80,$5D,$40,$3D,$20,$2F,$31             ; 05CE5B DDDDDDDD `?]@= /1
.byte $2F,$21,$3F,$33,$0D,$1F,$07,$3D             ; 05CE63 DDDDDDDD /!?3???=
.byte $02,$1D,$02,$1E,$12,$29,$19,$EF             ; 05CE6B DDDDDDDD ?????)??
.byte $9F,$E7,$9F,$C2,$BF,$40,$2F,$67             ; 05CE73 DDDDDDDD ?????@/g
.byte $17,$70,$E6,$60,$E0,$1F,$F0,$0F             ; 05CE7B DDDDDDDD ?p?`????
.byte $10,$A0,$00,$B0,$30,$B0,$10,$90             ; 05CE83 DDDDDDDD ????0???
.byte $10,$90,$10,$90,$B8,$38,$2C,$2C             ; 05CE8B DDDDDDDD ?????8,,
.byte $20,$C0,$20,$C0,$20,$C0,$30,$C0             ; 05CE93 DDDDDDDD  ? ? ?0?
.byte $0F,$03,$17,$0C,$1D,$0E,$02,$1B             ; 05CE9B DDDDDDDD ????????
.byte $00,$19,$1B,$0D,$14,$1A,$1D,$16             ; 05CEA3 DDDDDDDD ????????
.byte $1C,$13,$0C,$11,$0E,$19,$06,$08             ; 05CEAB DDDDDDDD ????????
.byte $07,$0C,$03,$12,$70,$C8,$38,$E5             ; 05CEB3 DDDDDDDD ????p?8?
.byte $1D,$E3,$1F,$3C,$C3,$1C,$E3,$9E             ; 05CEBB DDDDDDDD ???<????
.byte $E1,$5E,$61,$F0,$0F,$F8,$07,$FD             ; 05CEC3 DDDDDDDD ?^a?????
.byte $02,$80,$22,$22,$CB,$E5,$8C,$E6             ; 05CECB DDDDDDDD ??""????
.byte $00,$E9,$18,$E2,$10,$E3,$10,$E2             ; 05CED3 DDDDDDDD ????????
.byte $12,$E2,$3C,$C0,$00,$F8,$F9,$80             ; 05CEDB DDDDDDDD ??<?????
.byte $80,$40,$40,$A0,$20,$D0,$90,$10             ; 05CEE3 DDDDDDDD ?@@? ???
.byte $50,$01,$A1,$9F,$00,$60,$80,$30             ; 05CEEB DDDDDDDD P????`?0
.byte $C0,$10,$E0,$04,$04,$70,$7C,$F9             ; 05CEF3 DDDDDDDD ?????p|?
.byte $0D,$F9,$06,$0A,$1D,$08,$0B,$00             ; 05CEFB DDDDDDDD ????????
.byte $0A,$07,$07,$02,$04,$03,$06,$01             ; 05CF03 DDDDDDDD ????????
.byte $00,$3A,$21,$09,$10,$61,$0C,$62             ; 05CF0B DDDDDDDD ?:!??a?b
.byte $04,$06,$04,$0C,$0E,$FD,$FE,$39             ; 05CF13 DDDDDDDD ???????9
.byte $FE,$12,$E2,$18,$E2,$91,$63,$81             ; 05CF1B DDDDDDDD ??????c?
.byte $73,$C1,$33,$61,$13,$F1,$87,$D1             ; 05CF23 DDDDDDDD s?3a????
.byte $C5,$F8,$3C,$03,$89,$D8,$8C,$FB             ; 05CF2B DDDDDDDD ??<?????
.byte $8C,$FB,$CD,$FB,$CC,$EA,$CE,$E8             ; 05CF33 DDDDDDDD ????????
.byte $8E,$E1,$02,$C9,$17,$E0,$17,$E0             ; 05CF3B DDDDDDDD ????????
.byte $06,$F1,$06,$F1,$00,$FD,$FD,$7E             ; 05CF43 DDDDDDDD ???????~
.byte $5D,$22,$1F,$00,$92,$81,$85,$80             ; 05CF4B DDDDDDDD ]"??????
.byte $C3,$52,$6A,$72,$72,$2A,$44,$43             ; 05CF53 DDDDDDDD ?Rjrr*DC
.byte $64,$67,$20,$25,$00,$04,$91,$15             ; 05CF5B DDDDDDDD dg %????
.byte $90,$15,$1A,$BE,$01,$9A,$01,$DA             ; 05CF63 DDDDDDDD ????????
.byte $EB,$00,$EB,$E1,$00,$10,$DC,$15             ; 05CF6B DDDDDDDD ????????
.byte $9E,$28,$39,$44,$78,$90,$FE,$0C             ; 05CF73 DDDDDDDD ?(9Dx???
.byte $EF,$0C,$A7,$55,$C9,$1F,$E0,$1D             ; 05CF7B DDDDDDDD ???U????
.byte $E2,$38,$C7,$78,$87,$FE,$01,$E3             ; 05CF83 DDDDDDDD ?8?x????
.byte $1C,$98,$7F,$3E,$FF,$D8,$E0,$80             ; 05CF8B DDDDDDDD ???>????
.byte $1F,$E0,$06,$78,$41,$1E,$10,$0F             ; 05CF93 DDDDDDDD ???xA???
.byte $0E,$21,$00,$FF,$6F,$18,$1C,$0F             ; 05CF9B DDDDDDDD ?!??o???
.byte $50,$4F,$6F,$E0,$0C,$E0,$BF,$3F             ; 05CFA3 DDDDDDDD POo?????
.byte $C0,$35,$29,$2D,$01,$15,$11,$18             ; 05CFAB DDDDDDDD ?5)-????
.byte $1B,$0E,$0C,$0C,$0C,$0D,$05,$06             ; 05CFB3 DDDDDDDD ????????
.byte $06,$0E,$98,$9E,$D8,$DF,$D8,$DF             ; 05CFBB DDDDDDDD ????????
.byte $F2,$FD,$F2,$FC,$B2,$FC,$D3,$FD             ; 05CFC3 DDDDDDDD ????????
.byte $C3,$FD,$60,$01,$21,$A9,$9E,$AE             ; 05CFCB DDDDDDDD ??`?!???
.byte $9F,$EF,$DF,$4F,$DF,$4F,$5F,$53             ; 05CFD3 DDDDDDDD ???O?O_S
.byte $4F,$29,$E7,$37,$F0,$9F,$7F,$8F             ; 05CFDB DDDDDDDD O)?7????
.byte $7F,$84,$CC,$85,$36,$55,$99,$90             ; 05CFE3 DDDDDDDD ????6U??
.byte $E6,$FA,$F3,$FA,$F3,$E6,$F7,$16             ; 05CFEB DDDDDDDD ????????
.byte $E7,$0C,$F3,$C7,$F8,$FF,$84,$7C             ; 05CFF3 DDDDDDDD ???????|
.byte $0A,$0A,$C0,$27,$82,$F9,$10,$1D             ; 05CFFB DDDDDDDD ???'????
.byte $87,$08,$C7,$08,$CF,$08,$0B,$F0             ; 05D003 DDDDDDDD ????????
.byte $09,$F4,$E1,$1E,$F8,$07,$06,$06             ; 05D00B DDDDDDDD ????????
.byte $FD,$65,$7F,$75,$6E,$F7,$EE,$D7             ; 05D013 DDDDDDDD ?e?un???
.byte $EE,$D2,$EF,$38,$E7,$88,$77,$11             ; 05D01B DDDDDDDD ???8??w?
.byte $F0,$8C,$7C,$07,$3F,$E1,$DF,$A0             ; 05D023 DDDDDDDD ??|?????
.byte $5F,$FE,$21,$D0,$8F,$7F,$83,$40             ; 05D02B DDDDDDDD _?!????@
.byte $60,$30,$0F,$EC,$0F,$18,$1F,$F1             ; 05D033 DDDDDDDD `0??????
.byte $FE,$E7,$F8,$0C,$F0,$19,$E1,$F3             ; 05D03B DDDDDDDD ????????
.byte $03,$0E,$01,$FE,$D7,$18,$97,$18             ; 05D043 DDDDDDDD ????????
.byte $37,$C7,$F8,$06,$F8,$06,$FF,$00             ; 05D04B DDDDDDDD 7???????
.byte $C8,$37,$68,$37,$70,$0F,$70,$0F             ; 05D053 DDDDDDDD ?7h7p?p?
.byte $30,$0F,$31,$10,$E0,$0B,$FB,$66             ; 05D05B DDDDDDDD 0?1????f
.byte $9F,$30,$C7,$52,$E9,$69,$F4,$1C             ; 05D063 DDDDDDDD ?0?R?i??
.byte $92,$04,$CB,$10,$0F,$0B,$61,$00             ; 05D06B DDDDDDDD ??????a?
.byte $30,$21,$1E,$9F,$00,$C0,$C0,$3F             ; 05D073 DDDDDDDD 0!??????
.byte $33,$C0,$77,$87,$CE,$0E,$B0,$30             ; 05D07B DDDDDDDD 3?w????0
.byte $C0,$C0,$F8,$CF,$FF,$00,$2C,$1E             ; 05D083 DDDDDDDD ??????,?
.byte $2E,$1E,$0E,$1F,$04,$1D,$8E,$EE             ; 05D08B DDDDDDDD .???????
.byte $40,$78,$25,$30,$CE,$02,$8C,$C4             ; 05D093 DDDDDDDD @x%0????
.byte $58,$C9,$D3,$C1,$D4,$CC,$11,$CF             ; 05D09B DDDDDDDD X???????
.byte $3C,$03,$38,$07,$30,$0F,$3C,$03             ; 05D0A3 DDDDDDDD <?8?0?<?
.byte $11,$00,$DC,$3D,$7F,$72,$FC,$F9             ; 05D0AB DDDDDDDD ???=?r??
.byte $F1,$CE,$FF,$C5,$08,$01,$FE,$DD             ; 05D0B3 DDDDDDDD ????????
.byte $3E,$04,$F8,$07,$C3,$CF,$E0,$6F             ; 05D0BB DDDDDDDD >??????o
.byte $FF,$30,$70,$90,$2F,$DF,$34,$77             ; 05D0C3 DDDDDDDD ?0p?/?4w
.byte $10,$70,$13,$31,$3F,$C3,$D3,$04             ; 05D0CB DDDDDDDD ?p?1????
.byte $F5,$EB,$0B,$83,$47,$CB,$BF,$E8             ; 05D0D3 DDDDDDDD ????G???
.byte $1B,$6C,$1C,$37,$0F,$DF,$20,$F0             ; 05D0DB DDDDDDDD ?l?7?? ?
.byte $0F,$78,$FC,$71,$7C,$08,$8E,$AC             ; 05D0E3 DDDDDDDD ?x?q|???
.byte $CE,$CC,$EE,$CE,$EE,$1E,$DE,$08             ; 05D0EB DDDDDDDD ????????
.byte $0E,$02,$0C,$0F,$08,$1A,$2A,$19             ; 05D0F3 DDDDDDDD ??????*?
.byte $A5,$9C,$83,$7F,$D4,$47,$04,$1F             ; 05D0FB DDDDDDDD ?????G??
.byte $2C,$3F,$7C,$7F,$5E,$7F,$4E,$7F             ; 05D103 DDDDDDDD ,?|?^?N?
.byte $83,$DF,$B4,$BF,$38,$9F,$1B,$00             ; 05D10B DDDDDDDD ????8???
.byte $13,$21,$00,$31,$00,$5F,$20,$0F             ; 05D113 DDDDDDDD ?!?1?_ ?
.byte $73,$AF,$77,$3F,$82,$1F,$C0,$0F             ; 05D11B DDDDDDDD s?w?????
.byte $E0,$1F,$F3,$81,$E0,$1F,$F8,$DF             ; 05D123 DDDDDDDD ????????
.byte $E0,$F7,$F8,$FB,$FC,$65,$56,$15             ; 05D12B DDDDDDDD ?????eV?
.byte $E6,$CB,$0D,$17,$1B,$CA,$F2,$0C             ; 05D133 DDDDDDDD ????????
.byte $F4,$60,$1C,$F8,$9A,$47,$9F,$87             ; 05D13B DDDDDDDD ?`???G??
.byte $9F,$83,$50,$DF,$01,$9E,$02,$FD             ; 05D143 DDDDDDDD ??P?????
.byte $44,$FB,$48,$3F,$84,$F0,$0F,$97             ; 05D14B DDDDDDDD D?H?????
.byte $6F,$8E,$7F,$DC,$3E,$F8,$3C,$38             ; 05D153 DDDDDDDD o???>?<8
.byte $F0,$B5,$79,$0F,$FF,$C3,$3F,$83             ; 05D15B DDDDDDDD ??y?????
.byte $FC,$01,$FF,$08,$F7,$18,$F9,$20             ; 05D163 DDDDDDDD ??????? 
.byte $E3,$40,$C7,$80,$8F,$01,$DF,$8A             ; 05D16B DDDDDDDD ?@??????
.byte $1C,$1D,$1E,$33,$3F,$7F,$67,$FD             ; 05D173 DDDDDDDD ???3??g?
.byte $DF,$FB,$BF,$F6,$7F,$AD,$FE,$E0             ; 05D17B DDDDDDDD ????????
.byte $0C,$F0,$46,$DC,$81,$9E,$00,$1F             ; 05D183 DDDDDDDD ??F?????
.byte $40,$40,$80,$B0,$C0,$A8,$F0,$66             ; 05D18B DDDDDDDD @@?????f
.byte $B8,$E9,$7E,$00,$FC,$43,$BF,$B0             ; 05D193 DDDDDDDD ??~??C??
.byte $FD,$9C,$4E,$06,$7B,$11,$3C,$0C             ; 05D19B DDDDDDDD ??N?{?<?
.byte $00,$70,$0F,$FC,$83,$BF,$80,$FC             ; 05D1A3 DDDDDDDD ?p??????
.byte $C0,$3F,$FA,$07,$BE,$81,$B7,$20             ; 05D1AB DDDDDDDD ??????? 
.byte $97,$10,$FA,$C9,$DB,$FD,$3B,$FF             ; 05D1B3 DDDDDDDD ??????;?
.byte $0C,$FF,$43,$3D,$C8,$07,$FA,$CE             ; 05D1BB DDDDDDDD ??C=????
.byte $01,$08,$3F,$10,$7F,$20,$21,$61             ; 05D1C3 DDDDDDDD ????? !a
.byte $5E,$5B,$95,$F8,$F1,$F0,$E1,$E0             ; 05D1CB DDDDDDDD ^[??????
.byte $C3,$C2,$C7,$63,$CE,$3C,$FF,$CE             ; 05D1D3 DDDDDDDD ???c?<??
.byte $3F,$71,$8E,$20,$38,$C0,$F2,$3E             ; 05D1DB DDDDDDDD ?q? 8??>
.byte $A0,$3F,$80,$BF,$C4,$7B,$04,$7B             ; 05D1E3 DDDDDDDD ?????{?{
.byte $20,$C0,$C0,$E0,$A0,$C0,$33,$CC             ; 05D1EB DDDDDDDD  ?????3?
.byte $EE,$1F,$D9,$3F,$F9,$3F,$B3,$7F             ; 05D1F3 DDDDDDDD ????????
.byte $3F,$3F,$33,$BF,$11,$DF,$DF,$CC             ; 05D1FB DDDDDDDD ??3?????
.byte $C0,$EE,$E0,$E0,$98,$87,$9F,$E4             ; 05D203 DDDDDDDD ????????
.byte $E5,$81,$8B,$BF,$8B,$3F,$1C,$EC             ; 05D20B DDDDDDDD ????????
.byte $28,$1D,$04,$3B,$9F,$F0,$A7,$3D             ; 05D213 DDDDDDDD (??;???=
.byte $E7,$01,$FF,$03,$33,$9F,$60,$67             ; 05D21B DDDDDDDD ????3?`g
.byte $19,$1D,$0F,$BF,$D1,$DF,$FF,$EE             ; 05D223 DDDDDDDD ????????
.byte $FF,$F8,$ED,$FC,$F7,$B7,$7F,$DE             ; 05D22B DDDDDDDD ????????
.byte $BF,$F5,$CE,$FF,$E0,$9F,$98,$D6             ; 05D233 DDDDDDDD ????????
.byte $C4,$EB,$E3,$7B,$7B,$00,$BF,$30             ; 05D23B DDDDDDDD ???{{??0
.byte $7F,$70,$FF,$D8,$FF,$A8,$E7,$FD             ; 05D243 DDDDDDDD ?p??????
.byte $ED,$F7,$E0,$E6,$E0,$DF,$E0,$8F             ; 05D24B DDDDDDDD ????????
.byte $C0,$0F,$80,$27,$1F,$1D,$00,$3F             ; 05D253 DDDDDDDD ???'????
.byte $3F,$0F,$20,$20,$E6,$C0,$39,$80             ; 05D25B DDDDDDDD ??  ??9?
.byte $C0,$4E,$09,$20,$9C,$32,$00,$76             ; 05D263 DDDDDDDD ?N? ?2?v
.byte $6D,$BD,$80,$0D,$00,$48,$35,$01             ; 05D26B DDDDDDDD m????H5?
.byte $24,$E0,$90,$8E,$49,$12,$EB,$D1             ; 05D273 DDDDDDDD $???I???
.byte $9D,$82,$8C,$6D,$24,$31,$02,$41             ; 05D27B DDDDDDDD ???m$1?A
.byte $8B,$04,$83,$1E,$01,$09,$BC,$06             ; 05D283 DDDDDDDD ????????
.byte $0D,$F7,$1C,$00,$8E,$0C,$05,$B4             ; 05D28B DDDDDDDD ????????
.byte $51,$80,$0F,$00,$48,$79,$00,$94             ; 05D293 DDDDDDDD Q???Hy??
.byte $3D,$91,$02,$75,$1B,$F4,$18,$3D             ; 05D29B DDDDDDDD =??u???=
.byte $5D,$E1,$4E,$05,$38,$24,$DF,$15             ; 05D2A3 DDDDDDDD ]?N?8$??
.byte $27,$83,$AE,$02,$E2,$72,$E1,$05             ; 05D2AB DDDDDDDD '????r??
.byte $78,$B4,$9E,$44,$39,$19,$E3,$10             ; 05D2B3 DDDDDDDD x??D9???
.byte $4D,$EB,$09,$DE,$E1,$58,$1D,$F0             ; 05D2BB DDDDDDDD M????X??
.byte $15,$E2,$B0,$E0,$F0,$0E,$A5,$0B             ; 05D2C3 DDDDDDDD ????????
.byte $01,$C5,$7A,$B4,$9E,$C8,$15,$E4             ; 05D2CB DDDDDDDD ??z?????
.byte $91,$4F,$11,$4E,$67,$38,$B4,$13             ; 05D2D3 DDDDDDDD ?O?Ng8??
.byte $CC,$52,$EC,$25,$1E,$09,$14,$F7             ; 05D2DB DDDDDDDD ?R?%????
.byte $14,$9F,$40,$9F,$86,$3E,$2B,$DC             ; 05D2E3 DDDDDDDD ??@??>+?
.byte $54,$9F,$62,$1F,$A1,$0F,$91,$04             ; 05D2EB DDDDDDDD T?b?????
.byte $BE,$12,$1F,$C8,$FB,$14,$0B,$88             ; 05D2F3 DDDDDDDD ????????
.byte $BF,$3C,$02,$DD,$12,$8C,$3C,$22             ; 05D2FB DDDDDDDD ?<????<"
.byte $38,$44,$3C,$11,$52,$78,$80,$71             ; 05D303 DDDDDDDD 8D<?Rx?q
.byte $01,$38,$60,$AD,$BE,$41,$DA,$4A             ; 05D30B DDDDDDDD ?8`??A?J
.byte $24,$EC,$A1,$06,$E0,$53,$C6,$94             ; 05D313 DDDDDDDD $????S??
.byte $4B,$80,$1C,$A9,$14,$B6,$45,$70             ; 05D31B DDDDDDDD K?????Ep
.byte $83,$99,$22,$9C,$4F,$38,$9A,$09             ; 05D323 DDDDDDDD ??"?O8??
.byte $D1,$14,$97,$A4,$87,$49,$9D,$78             ; 05D32B DDDDDDDD ?????I?x
.byte $8A,$6C,$04,$52,$74,$D9,$6B,$A1             ; 05D333 DDDDDDDD ?l?Rt?k?
.byte $16,$DA,$32,$0F,$53,$CD,$82,$A2             ; 05D33B DDDDDDDD ??2?S???
.byte $67,$85,$0E,$07,$80,$4E,$89,$11             ; 05D343 DDDDDDDD g????N??
.byte $75,$82,$16,$B2,$10,$6E,$F1,$5B             ; 05D34B DDDDDDDD u????n?[
.byte $48,$55,$9E,$C2,$02,$DA,$A2,$5F             ; 05D353 DDDDDDDD HU?????_
.byte $30,$87,$4C,$44,$2C,$03,$20,$58             ; 05D35B DDDDDDDD 0?LD,? X
.byte $61,$84,$F5,$01,$0F,$18,$18,$5F             ; 05D363 DDDDDDDD a??????_
.byte $35,$41,$B1,$F8,$0F,$4F,$C8,$E4             ; 05D36B DDDDDDDD 5A???O??
.byte $EE,$5D,$46,$4F,$AE,$61,$F6,$D9             ; 05D373 DDDDDDDD ?]FO?a??
.byte $EC,$B9,$F8,$28,$7C,$3F,$D3,$C7             ; 05D37B DDDDDDDD ???(|???
.byte $C4,$82,$7D,$6F,$EB,$FF,$4E,$0D             ; 05D383 DDDDDDDD ??}o??N?
.byte $86,$BB,$D4,$7F,$31,$BE,$71,$7A             ; 05D38B DDDDDDDD ????1?qz
.byte $51,$1F,$6D,$1E,$99,$07,$DB,$2F             ; 05D393 DDDDDDDD Q?m????/
.byte $D5,$46,$4C,$0B,$09,$1F,$1B,$64             ; 05D39B DDDDDDDD ?FL????d
.byte $3A,$5F,$7D,$A6,$01,$5D,$44,$48             ; 05D3A3 DDDDDDDD :_}??]DH
.byte $8F,$02,$24,$2A,$6D,$09,$26,$E1             ; 05D3AB DDDDDDDD ??$*m?&?
.byte $C9,$20,$70,$A0,$96,$24,$36,$E2             ; 05D3B3 DDDDDDDD ? p??$6?
.byte $63,$B4,$D0,$3B,$93,$2F,$11,$46             ; 05D3BB DDDDDDDD c??;?/?F
.byte $D6,$5B,$BC,$4A,$70,$EF,$00,$1C             ; 05D3C3 DDDDDDDD ?[?Jp???
.byte $37,$C0,$87,$1E,$FC,$7D,$48,$38             ; 05D3CB DDDDDDDD 7????}H8
.byte $B3,$5C,$8B,$C0,$A3,$C7,$7C,$1C             ; 05D3D3 DDDDDDDD ?\????|?
.byte $69,$1C,$38,$24,$22,$F0,$73,$1C             ; 05D3DB DDDDDDDD i?8$"?s?
.byte $7E,$13,$B8,$01,$CB,$D3,$00,$72             ; 05D3E3 DDDDDDDD ~??????r
.byte $2C,$5C,$0B,$F3,$78,$42,$1C,$18             ; 05D3EB DDDDDDDD ,\??xB??
.byte $10,$72,$E8,$92,$29,$C6,$BC,$81             ; 05D3F3 DDDDDDDD ?r??)???
.byte $A1,$50,$DB,$EC,$B2,$F3,$F9,$21             ; 05D3FB DDDDDDDD ?P?????!
.byte $C3,$80,$13,$CE,$A8,$C0,$72,$EC             ; 05D403 DDDDDDDD ??????r?
.byte $07,$52,$C4,$27,$4B,$DA,$8F,$3C             ; 05D40B DDDDDDDD ?R?'K??<
.byte $BD,$0F,$52,$AB,$C4,$7C,$1B,$99             ; 05D413 DDDDDDDD ??R??|??
.byte $84,$6D,$5F,$C4,$A0,$1D,$6B,$12             ; 05D41B DDDDDDDD ?m_???k?
.byte $8B,$CC,$94,$AF,$5B,$BD,$2D,$0E             ; 05D423 DDDDDDDD ????[?-?
.byte $A0,$CB,$00,$EE,$3A,$4A,$1C,$3C             ; 05D42B DDDDDDDD ????:J?<
.byte $C1,$D4,$31,$02,$E2,$7F,$0B,$AF             ; 05D433 DDDDDDDD ??1?????
.byte $73,$6E,$5D,$0F,$74,$C4,$76,$A7             ; 05D43B DDDDDDDD sn]?t?v?
.byte $DD,$81,$DD,$A1,$83,$64,$9C,$E8             ; 05D443 DDDDDDDD ?????d??
.byte $C8,$61,$F3,$2B,$DC,$DC,$AF,$73             ; 05D44B DDDDDDDD ?a?+???s
.byte $85,$D5,$EC,$1D,$E2,$10,$A1,$C6             ; 05D453 DDDDDDDD ????????
.byte $E1,$75,$F7,$3D,$4F,$CA,$74,$F5             ; 05D45B DDDDDDDD ?u?=O?t?
.byte $1C,$F7,$F8,$A8,$78,$B0,$77,$51             ; 05D463 DDDDDDDD ????x?wQ
.byte $75,$9B,$75,$88,$1D,$A9,$1D,$96             ; 05D46B DDDDDDDD u?u?????
.byte $1C,$47,$81,$2A,$F7,$D1,$76,$6F             ; 05D473 DDDDDDDD ?G?*??vo
.byte $0B,$D3,$C9,$28,$76,$67,$B6,$96             ; 05D47B DDDDDDDD ???(vg??
.byte $D0,$DD,$4F,$42,$9E,$3D,$B9,$C1             ; 05D483 DDDDDDDD ??OB?=??
.byte $A5,$8A,$B4,$87,$57,$85,$DB,$8C             ; 05D48B DDDDDDDD ????W???
.byte $F8,$6A,$C0,$3B,$EE,$C3,$C6,$D1             ; 05D493 DDDDDDDD ?j?;????
.byte $E9,$CC,$F4,$F7,$2E,$70,$10,$ED             ; 05D49B DDDDDDDD ????.p??
.byte $EF,$6E,$F3,$DE,$A1,$20,$FA,$B3             ; 05D4A3 DDDDDDDD ?n??? ??
.byte $77,$B3,$28,$F4,$AB,$E7,$61,$1C             ; 05D4AB DDDDDDDD w?(???a?
.byte $0D,$12,$79,$F8,$4F,$1E,$D0,$BE             ; 05D4B3 DDDDDDDD ??y?O???
.byte $88,$48,$70,$F8,$42,$F7,$F8,$62             ; 05D4BB DDDDDDDD ?Hp?B??b
.byte $FB,$09,$E8,$81,$79,$B3,$3D,$D0             ; 05D4C3 DDDDDDDD ????y?=?
.byte $EE,$80,$86,$E9,$E2,$FC,$35,$27             ; 05D4CB DDDDDDDD ??????5'
.byte $59,$EB,$ED,$9D,$B9,$18,$97,$36             ; 05D4D3 DDDDDDDD Y??????6
.byte $B6,$F9,$24,$07,$66,$C7,$B6,$05             ; 05D4DB DDDDDDDD ??$?f???
.byte $F0,$78,$C2,$79,$A3,$00,$87,$BF             ; 05D4E3 DDDDDDDD ?x?y????
.byte $B0,$1A,$E6,$4B,$F0,$B0,$10,$7C             ; 05D4EB DDDDDDDD ???K???|
.byte $20,$2C,$FD,$AA,$85,$B4,$5A,$04             ; 05D4F3 DDDDDDDD  ,????Z?
.byte $6E,$4C,$07,$13,$6C,$8A,$70,$A0             ; 05D4FB DDDDDDDD nL??l?p?
.byte $04,$73,$00,$04,$9C,$C8,$21,$7E             ; 05D503 DDDDDDDD ?s????!~
.byte $2A,$FE,$38,$5D,$AA,$CF,$F0,$2D             ; 05D50B DDDDDDDD *?8]???-
.byte $BC,$1C,$7C,$A8,$48,$BE,$F4,$C8             ; 05D513 DDDDDDDD ??|?H???
.byte $3D,$89,$8C,$2B,$D2,$98,$3F,$29             ; 05D51B DDDDDDDD =??+???)
.byte $4A,$1A,$E3,$E0,$D7,$20,$6B,$FE             ; 05D523 DDDDDDDD J???? k?
.byte $83,$4D,$C5,$BD,$66,$44,$D1,$74             ; 05D52B DDDDDDDD ?M??fD?t
.byte $40,$ED,$FF,$80,$DC,$98,$4A,$70             ; 05D533 DDDDDDDD @?????Jp
.byte $6A,$08,$03,$43,$C1,$39,$BC,$6D             ; 05D53B DDDDDDDD j??C?9?m
.byte $AB,$2C,$AA,$EE,$C5,$6D,$CA,$10             ; 05D543 DDDDDDDD ?,???m??
.byte $EA,$67,$C8,$7A,$32,$2E,$94,$AD             ; 05D54B DDDDDDDD ?g?z2.??
.byte $CA,$6C,$0E,$AC,$93,$78,$0A,$DB             ; 05D553 DDDDDDDD ?l???x??
.byte $1C,$5D,$E0,$00,$6D,$E7,$83,$63             ; 05D55B DDDDDDDD ?]??m??c
.byte $3F,$13,$A0,$B7,$58,$EF,$F0,$37             ; 05D563 DDDDDDDD ????X??7
.byte $1A,$24,$99,$F3,$61,$36,$FC,$E5             ; 05D56B DDDDDDDD ?$??a6??
.byte $CB,$25,$0D,$A2,$C4,$0A,$6D,$00             ; 05D573 DDDDDDDD ?%????m?
.byte $48,$0D,$A2,$03,$09,$B8,$03,$8A             ; 05D57B DDDDDDDD H???????
.byte $42,$6C,$6C,$4D,$DF,$C2,$43,$C7             ; 05D583 DDDDDDDD BllM??C?
.byte $D4,$1D,$72,$C6,$87,$E1,$25,$17             ; 05D58B DDDDDDDD ??r???%?
.byte $8A,$8B,$72,$2D,$B8,$91,$F2,$18             ; 05D593 DDDDDDDD ??r-????
.byte $4B,$91,$ED,$C4,$CC,$19,$E4,$FE             ; 05D59B DDDDDDDD K???????
.byte $71,$19,$E4,$F4,$1C,$97,$0E,$52             ; 05D5A3 DDDDDDDD q??????R
.byte $05,$91,$69,$37,$50,$DC,$A1,$F9             ; 05D5AB DDDDDDDD ??i7P???
.byte $44,$29,$BD,$F8,$E5,$56,$E7,$E1             ; 05D5B3 DDDDDDDD D)???V??
.byte $61,$33,$F8,$04,$0E,$7F,$F1,$84             ; 05D5BB DDDDDDDD a3??????
.byte $D0,$20,$10,$9A,$08,$04,$83,$41             ; 05D5C3 DDDDDDDD ? ?????A
.byte $80,$10,$E4,$A7,$06,$4D,$E2,$02             ; 05D5CB DDDDDDDD ?????M??
.byte $40,$03,$BC,$F6,$05,$CF,$99,$09             ; 05D5D3 DDDDDDDD @???????
.byte $BB,$F1,$4E,$74,$0A,$71,$EC,$61             ; 05D5DB DDDDDDDD ??Nt?q?a
.byte $78,$F6,$04,$08,$ED,$C4,$94,$78             ; 05D5E3 DDDDDDDD x??????x
.byte $BC,$C0,$EB,$CB,$90,$D1,$A8,$5B             ; 05D5EB DDDDDDDD ???????[
.byte $DE,$E1,$34,$D4,$24,$69,$B7,$B4             ; 05D5F3 DDDDDDDD ??4?$i??
.byte $DB,$01,$0E,$6B,$89,$77,$C9,$C0             ; 05D5FB DDDDDDDD ???k?w??
.byte $2E,$9F,$75,$81,$73,$34,$37,$15             ; 05D603 DDDDDDDD .?u?s47?
.byte $5C,$98,$A4,$82,$F4,$1B,$BA,$78             ; 05D60B DDDDDDDD \??????x
.byte $DA,$CD,$C6,$0E,$5A,$24,$2F,$11             ; 05D613 DDDDDDDD ????Z$/?
.byte $3C,$24,$10,$A6,$C3,$DC,$BD,$A4             ; 05D61B DDDDDDDD <$??????
.byte $BD,$2E,$E5,$0C,$68,$B0,$83,$AC             ; 05D623 DDDDDDDD ?.??h???
.byte $A3,$89,$8A,$3B,$86,$86,$4D,$C9             ; 05D62B DDDDDDDD ???;??M?
.byte $6F,$07,$C2,$5C,$D0,$F1,$D6,$B0             ; 05D633 DDDDDDDD o??\????
.byte $80,$D3,$60,$48,$70,$E4,$80,$7A             ; 05D63B DDDDDDDD ??`Hp??z
.byte $EC,$10,$9D,$7A,$83,$AF,$E1,$93             ; 05D643 DDDDDDDD ???z????
.byte $D4,$5E,$C0,$28,$F1,$00,$12,$0E             ; 05D64B DDDDDDDD ?^?(????
.byte $22,$02,$49,$99,$4D,$1E,$C8,$28             ; 05D653 DDDDDDDD "?I?M??(
.byte $C0,$1B,$E1,$8C,$D7,$06,$38,$94             ; 05D65B DDDDDDDD ??????8?
.byte $DB,$40,$5B,$51,$A0,$E4,$58,$76             ; 05D663 DDDDDDDD ?@[Q??Xv
.byte $7A,$09,$E4,$77,$C8,$F0,$DB,$80             ; 05D66B DDDDDDDD z??w????
.byte $9D,$26,$CE,$49,$86,$DD,$04,$ED             ; 05D673 DDDDDDDD ?&?I????
.byte $4E,$72,$B6,$07,$8F,$4A,$6E,$10             ; 05D67B DDDDDDDD Nr???Jn?
.byte $53,$B6,$7A,$36,$76,$F0,$71,$BE             ; 05D683 DDDDDDDD S?z6v?q?
.byte $B9,$F7,$B9,$D9,$89,$D6,$39,$1D             ; 05D68B DDDDDDDD ??????9?
.byte $8D,$30,$2B,$BA,$96,$15,$E4,$CB             ; 05D693 DDDDDDDD ?0+?????
.byte $76,$3D,$80,$E3,$DE,$67,$3D,$95             ; 05D69B DDDDDDDD v=???g=?
.byte $D4,$2B,$02,$9B,$26,$6C,$5C,$93             ; 05D6A3 DDDDDDDD ?+??&l\?
.byte $C9,$8E,$45,$72,$B3,$4A,$E6,$C1             ; 05D6AB DDDDDDDD ??Er?J??
.byte $B7,$55,$F7,$19,$2E,$1F,$36,$50             ; 05D6B3 DDDDDDDD ?U??.?6P
.byte $64,$79,$9C,$6A,$CC,$DF,$08,$1B             ; 05D6BB DDDDDDDD dy?j????
.byte $C5,$93,$39,$D9,$84,$D0,$90,$7B             ; 05D6C3 DDDDDDDD ??9????{
.byte $DE,$C2,$3C,$5C,$E1,$EC,$73,$78             ; 05D6CB DDDDDDDD ??<\??sx
.byte $13,$80,$57,$09,$7C,$1B,$35,$0F             ; 05D6D3 DDDDDDDD ??W?|?5?
.byte $02,$45,$E0,$57,$75,$DB,$CE,$C5             ; 05D6DB DDDDDDDD ?E?Wu???
.byte $4E,$4C,$C0,$78,$2F,$09,$07,$64             ; 05D6E3 DDDDDDDD NL?x/??d
.byte $C1,$08,$72,$B4,$08,$75,$1B,$41             ; 05D6EB DDDDDDDD ??r??u?A
.byte $BF,$EA,$43,$81,$AC,$3B,$4D,$6D             ; 05D6F3 DDDDDDDD ??C??;Mm
.byte $07,$B0,$07,$50,$39,$79,$2A,$C2             ; 05D6FB DDDDDDDD ???P9y*?
.byte $9C,$53,$E5,$EE,$1B,$08,$19,$12             ; 05D703 DDDDDDDD ?S??????
.byte $86,$5F,$3A,$47,$9D,$62,$41,$38             ; 05D70B DDDDDDDD ?_:G?bA8
.byte $4D,$1B,$56,$83,$AC,$60,$40,$3D             ; 05D713 DDDDDDDD M?V??`@=
.byte $2D,$EF,$0E,$30,$86,$9B,$2D,$4E             ; 05D71B DDDDDDDD -??0??-N
.byte $2B,$77,$B9,$E1,$E4,$40,$3E,$64             ; 05D723 DDDDDDDD +w???@>d
.byte $FA,$7B,$16,$D5,$56,$D2,$FE,$0C             ; 05D72B DDDDDDDD ?{??V???
.byte $9B,$DC,$04,$BA,$C4,$F5,$8D,$01             ; 05D733 DDDDDDDD ????????
.byte $F5,$4C,$2C,$07,$AA,$04,$8D,$C6             ; 05D73B DDDDDDDD ?L,?????
.byte $47,$AB,$60,$20,$35,$F3,$1E,$B7             ; 05D743 DDDDDDDD G?` 5???
.byte $0B,$36,$4B,$7A,$D3,$58,$1C,$C9             ; 05D74B DDDDDDDD ?6Kz?X??
.byte $E3,$71,$7B,$E3,$FD,$E0,$55,$60             ; 05D753 DDDDDDDD ?q{???U`
.byte $0F,$43,$01,$EA,$84,$0D,$4C,$01             ; 05D75B DDDDDDDD ?C????L?
.byte $09,$A9,$C0,$0E,$12,$04,$F5,$81             ; 05D763 DDDDDDDD ????????
.byte $EB,$0D,$1D,$62,$44,$63,$5A,$12             ; 05D76B DDDDDDDD ???bDcZ?
.byte $87,$70,$F5,$39,$D7,$82,$FB,$B6             ; 05D773 DDDDDDDD ?p?9????
.byte $5B,$B2,$8A,$37,$6E,$F1,$76,$34             ; 05D77B DDDDDDDD [??7n?v4
.byte $8F,$BE,$31,$20,$4C,$D7,$90,$A1             ; 05D783 DDDDDDDD ??1 L???
.byte $80,$05,$46,$EE,$C0,$1F,$18,$03             ; 05D78B DDDDDDDD ??F?????
.byte $E3,$41,$DD,$C0,$33,$9C,$87,$C7             ; 05D793 DDDDDDDD ?A??3???
.byte $82,$51,$EF,$37,$02,$FA,$31,$9E             ; 05D79B DDDDDDDD ?Q?7??1?
.byte $97,$33,$D6,$DF,$22,$3A,$3C,$39             ; 05D7A3 DDDDDDDD ?3??":<9
.byte $0F,$98,$60,$FB,$FC,$33,$5A,$10             ; 05D7AB DDDDDDDD ??`??3Z?
.byte $1F,$1F,$08,$04,$CC,$D6,$40,$1D             ; 05D7B3 DDDDDDDD ??????@?
.byte $5B,$0D,$C5,$D3,$C1,$63,$C6,$EA             ; 05D7BB DDDDDDDD [????c??
.byte $3E,$08,$83,$DF,$6E,$F0,$F4,$64             ; 05D7C3 DDDDDDDD >???n??d
.byte $17,$C5,$ED,$E4,$C5,$BB,$46,$C1             ; 05D7CB DDDDDDDD ??????F?
.byte $E5,$C6,$17,$5D,$E1,$06,$95,$22             ; 05D7D3 DDDDDDDD ???]???"
.byte $F5,$A3,$02,$38,$FB,$20,$31,$71             ; 05D7DB DDDDDDDD ???8? 1q
.byte $9E,$BC,$0B,$42,$2E,$56,$13,$DD             ; 05D7E3 DDDDDDDD ???B.V??
.byte $02,$85,$9A,$F6,$15,$3C,$2E,$10             ; 05D7EB DDDDDDDD ?????<.?
.byte $1A,$7D,$88,$0F,$0C,$CC,$7D,$FB             ; 05D7F3 DDDDDDDD ?}????}?
.byte $67,$F3,$9D,$B3,$5F,$13,$7F,$D5             ; 05D7FB DDDDDDDD g???_???
.byte $86,$3A,$DE,$1C,$C9,$47,$F4,$19             ; 05D803 DDDDDDDD ?:???G??
.byte $E0,$A7,$F4,$58,$42,$2F,$EC,$7B             ; 05D80B DDDDDDDD ???XB/?{
.byte $F2,$EF,$9D,$93,$A9,$80,$7E,$D8             ; 05D813 DDDDDDDD ??????~?
.byte $20,$7C,$6C,$C0,$F8,$D9,$72,$E4             ; 05D81B DDDDDDDD  |l???r?
.byte $84,$03,$A1,$1E,$10,$D3,$68,$74             ; 05D823 DDDDDDDD ??????ht
.byte $56,$2D,$4F,$B7,$E9,$9D,$9A,$06             ; 05D82B DDDDDDDD V-O?????
.byte $CD,$29,$FE,$7D,$1C,$71,$7C,$04             ; 05D833 DDDDDDDD ?)?}?q|?
.byte $11,$FB,$F0,$FE,$74,$5C,$70,$FF             ; 05D83B DDDDDDDD ????t\p?
.byte $4E,$10,$86,$9F,$22,$0F,$23,$44             ; 05D843 DDDDDDDD N???"?#D
.byte $03,$B5,$F6,$0F,$EE,$6C,$EC,$C1             ; 05D84B DDDDDDDD ?????l??
.byte $E3,$89,$03,$FD,$5B,$CE,$5B,$E5             ; 05D853 DDDDDDDD ????[?[?
.byte $45,$94,$D9,$D3,$01,$8A,$3B,$67             ; 05D85B DDDDDDDD E?????;g
.byte $C1,$72,$85,$84,$C9,$09,$07,$F9             ; 05D863 DDDDDDDD ?r??????
.byte $7B,$FC,$B8,$C8,$1B,$F5,$DB,$DF             ; 05D86B DDDDDDDD {???????
.byte $4C,$23,$B4,$22,$C0,$06,$53,$A2             ; 05D873 DDDDDDDD L#?"??S?
.byte $C0,$B9,$6E,$F6,$E1,$D1,$65,$78             ; 05D87B DDDDDDDD ??n???ex
.byte $DB,$5F,$12,$38,$98,$EE,$66,$83             ; 05D883 DDDDDDDD ?_?8??f?
.byte $2E,$39,$02,$41,$A0,$B7,$63,$98             ; 05D88B DDDDDDDD .9?A??c?
.byte $01,$6F,$E8,$C0,$E6,$30,$91,$BD             ; 05D893 DDDDDDDD ?o???0??
.byte $2B,$3A,$EE,$B9,$8E,$09,$02,$64             ; 05D89B DDDDDDDD +:?????d
.byte $9D,$0F,$03,$C6,$7A,$90,$40,$1C             ; 05D8A3 DDDDDDDD ????z?@?
.byte $0F,$86,$D4,$80,$59,$87,$70,$A7             ; 05D8AB DDDDDDDD ????Y?p?
.byte $09,$81,$06,$62,$E1,$18,$F4,$48             ; 05D8B3 DDDDDDDD ???b???H
.byte $58,$F6,$28,$E5,$6D,$3B,$A9,$A8             ; 05D8BB DDDDDDDD X?(?m;??
.byte $ED,$5A,$0B,$2B,$B6,$A8,$99,$4F             ; 05D8C3 DDDDDDDD ?Z?+???O
.byte $86,$B4,$D1,$23,$AD,$0B,$0E,$F5             ; 05D8CB DDDDDDDD ???#????
.byte $AC,$E7,$FB,$C0,$86,$D3,$D4,$2E             ; 05D8D3 DDDDDDDD ???????.
.byte $42,$90,$91,$90,$BC,$46,$43,$21             ; 05D8DB DDDDDDDD B????FC!
.byte $01,$95,$28,$05,$B9,$77,$02,$6F             ; 05D8E3 DDDDDDDD ??(??w?o
.byte $EA,$16,$BB,$2E,$5D,$C3,$C2,$E3             ; 05D8EB DDDDDDDD ???.]???
.byte $02,$E8,$BE,$F0,$6D,$07,$0B,$E1             ; 05D8F3 DDDDDDDD ????m???
.byte $00,$64,$7A,$1B,$E5,$47,$13,$A1             ; 05D8FB DDDDDDDD ?dz??G??
.byte $0A,$E4,$89,$B9,$23,$41,$22,$70             ; 05D903 DDDDDDDD ????#A"p
.byte $79,$19,$8B,$8C,$66,$32,$F1,$1E             ; 05D90B DDDDDDDD y???f2??
.byte $70,$B2,$3C,$4A,$C1,$98,$E8,$2C             ; 05D913 DDDDDDDD p?<J???,
.byte $AE,$28,$1A,$92,$1B,$EE,$D0,$6F             ; 05D91B DDDDDDDD ?(?????o
.byte $69,$58,$FF,$B6,$96,$BC,$03,$C1             ; 05D923 DDDDDDDD iX??????
.byte $F5,$C4,$1E,$91,$90,$38,$43,$93             ; 05D92B DDDDDDDD ?????8C?
.byte $CF,$0E,$58,$EE,$4F,$92,$10,$9C             ; 05D933 DDDDDDDD ??X?O???
.byte $6C,$84,$E1,$C7,$AB,$02,$E7,$CC             ; 05D93B DDDDDDDD l???????
.byte $BB,$6D,$44,$E5,$3F,$F1,$AC,$84             ; 05D943 DDDDDDDD ?mD?????
.byte $99,$B6,$F9,$52,$60,$D9,$D9,$A6             ; 05D94B DDDDDDDD ???R`???
.byte $55,$0C,$26,$55,$72,$5B,$46,$77             ; 05D953 DDDDDDDD U?&Ur[Fw
.byte $1D,$DC,$26,$AC,$19,$C1,$46,$71             ; 05D95B DDDDDDDD ??&???Fq
.byte $6A,$06,$C7,$78,$10,$0E,$72,$BD             ; 05D963 DDDDDDDD j??x??r?
.byte $AB,$A3,$09,$C6,$2D,$0B,$C7,$A4             ; 05D96B DDDDDDDD ????-???
.byte $65,$BA,$04,$71,$5E,$11,$97,$04             ; 05D973 DDDDDDDD e??q^???
.byte $93,$9A,$3F,$97,$20,$07,$1E,$A1             ; 05D97B DDDDDDDD ???? ???
.byte $A4,$29,$BD,$14,$6D,$50,$A0,$C0             ; 05D983 DDDDDDDD ?)??mP??
.byte $3A,$C6,$63,$86,$FE,$63,$5D,$10             ; 05D98B DDDDDDDD :?c??c]?
.byte $26,$61,$A1,$3C,$23,$36,$A9,$7C             ; 05D993 DDDDDDDD &a?<#6?|
.byte $01,$98,$A4,$07,$15,$C0,$67,$C0             ; 05D99B DDDDDDDD ??????g?
.byte $24,$67,$C5,$17,$23,$0E,$7C,$92             ; 05D9A3 DDDDDDDD $g??#?|?
.byte $04,$19,$F6,$08,$46,$7F,$03,$67             ; 05D9AB DDDDDDDD ????F??g
.byte $F3,$2D,$9F,$E0,$A4,$0B,$C9,$E3             ; 05D9B3 DDDDDDDD ?-??????
.byte $00,$72,$2D,$B6,$D3,$8C,$6C,$EE             ; 05D9BB DDDDDDDD ?r-???l?
.byte $CE,$54,$7C,$0B,$C5,$E9,$96,$34             ; 05D9C3 DDDDDDDD ?T|????4
.byte $17,$05,$65,$B1,$A6,$C9,$AB,$0C             ; 05D9CB DDDDDDDD ??e?????
.byte $06,$28,$3A,$90,$BA,$89,$72,$09             ; 05D9D3 DDDDDDDD ?(:???r?
.byte $BE,$95,$C1,$32,$48,$6F,$DB,$C0             ; 05D9DB DDDDDDDD ???2Ho??
.byte $66,$50,$E2,$7B,$0B,$CC,$03,$A3             ; 05D9E3 DDDDDDDD fP?{????
.byte $E6,$84,$8E,$3F,$7C,$BB,$6B,$86             ; 05D9EB DDDDDDDD ????|?k?
.byte $D6,$90,$66,$4D,$C8,$1A,$28,$32             ; 05D9F3 DDDDDDDD ??fM??(2
.byte $F2,$1C,$DB,$68,$B0,$8F,$04,$EC             ; 05D9FB DDDDDDDD ???h????
.byte $A1,$99,$C0,$12,$72,$B4,$5A,$7A             ; 05DA03 DDDDDDDD ????r?Zz
.byte $9C,$C7,$2C,$1C,$66,$30,$6F,$D0             ; 05DA0B DDDDDDDD ??,?f0o?
.byte $66,$83,$12,$70,$CB,$16,$68,$AB             ; 05DA13 DDDDDDDD f??p??h?
.byte $65,$0D,$B0,$6D,$CF,$89,$71,$1A             ; 05DA1B DDDDDDDD e??m??q?
.byte $F3,$19,$09,$03,$B6,$CB,$C8,$C2             ; 05DA23 DDDDDDDD ????????
.byte $43,$BD,$0D,$6F,$43,$8E,$CE,$E4             ; 05DA2B DDDDDDDD C??oC???
.byte $26,$D2,$6C,$0A,$EC,$C8,$DB,$E6             ; 05DA33 DDDDDDDD &?l?????
.byte $70,$F1,$B7,$8B,$1C,$F0,$48,$46             ; 05DA3B DDDDDDDD p?????HF
.byte $B4,$61,$C7,$EC,$06,$B4,$D0,$72             ; 05DA43 DDDDDDDD ?a?????r
.byte $32,$81,$00,$40,$85,$0C,$78,$00             ; 05DA4B DDDDDDDD 2??@??x?
.byte $60,$00,$60,$00,$00,$00,$F0,$00             ; 05DA53 DDDDDDDD `?`?????
.byte $30,$00,$30,$FF,$00,$FF,$80,$00             ; 05DA5B DDDDDDDD 0?0?????
.byte $80,$02,$00,$06,$03,$00,$07,$00             ; 05DA63 DDDDDDDD ????????
.byte $07,$00,$01,$00,$01,$01,$0E,$3E             ; 05DA6B DDDDDDDD ???????>
.byte $00,$40,$00,$1E,$1E,$47,$07,$01             ; 05DA73 DDDDDDDD ?@???G??
.byte $00,$0E,$00,$3F,$00,$7F,$00,$7F             ; 05DA7B DDDDDDDD ????????
.byte $E1,$00,$F8,$00,$CE,$00,$C7,$C0             ; 05DA83 DDDDDDDD ????????
.byte $0F,$31,$80,$0F,$00,$60,$60,$30             ; 05DA8B DDDDDDDD ?1???``0
.byte $70,$FF,$CE,$FC,$9F,$00,$8F,$F8             ; 05DA93 DDDDDDDD p???????
.byte $00,$E0,$80,$F8,$C0,$60,$E0,$3A             ; 05DA9B DDDDDDDD ?????`?:
.byte $FA,$1A,$7A,$00,$3C,$80,$00,$FA             ; 05DAA3 DDDDDDDD ??z?<???
.byte $00,$7E,$1F,$00,$05,$00,$85,$00             ; 05DAAB DDDDDDDD ?~??????
.byte $C3,$E0,$00,$C0,$60,$00,$78,$30             ; 05DAB3 DDDDDDDD ????`?x0
.byte $05,$00,$0B,$16,$1C,$05,$30,$10             ; 05DABB DDDDDDDD ??????0?
.byte $25,$01,$07,$00,$0F,$1F,$3A,$00             ; 05DAC3 DDDDDDDD %?????:?
.byte $2F,$C0,$01,$A0,$3D,$40,$47,$C0             ; 05DACB DDDDDDDD /???=@G?
.byte $EF,$82,$BD,$00,$8E,$80,$B3,$80             ; 05DAD3 DDDDDDDD ????????
.byte $DF,$FE,$00,$C2,$00,$B8,$00,$10             ; 05DADB DDDDDDDD ????????
.byte $71,$00,$4C,$00,$20,$00,$10,$B0             ; 05DAE3 DDDDDDDD q?L? ???
.byte $08,$FA,$00,$FB,$40,$BF,$80,$7F             ; 05DAEB DDDDDDDD ????@???
.byte $03,$7C,$1F,$FF,$20,$7F,$4F,$04             ; 05DAF3 DDDDDDDD ?|?? ?O?
.byte $03,$1F,$00,$BF,$1F,$00,$20,$01             ; 05DAFB DDDDDDDD ?????? ?
.byte $01,$04,$04,$00,$9D,$00,$B9,$00             ; 05DB03 DDDDDDDD ????????
.byte $C7,$80,$90,$00,$98,$DF,$00,$FE             ; 05DB0B DDDDDDDD ????????
.byte $00,$FB,$00,$62,$00,$46,$00,$38             ; 05DB13 DDDDDDDD ???b?F?8
.byte $00,$ED,$02,$FF,$98,$C0,$C0,$6B             ; 05DB1B DDDDDDDD ???????k
.byte $03,$DA,$07,$B0,$05,$60,$07,$C0             ; 05DB23 DDDDDDDD ?????`??
.byte $09,$00,$67,$30,$33,$40,$43,$FC             ; 05DB2B DDDDDDDD ??g03@C?
.byte $FA,$F6,$00,$98,$00,$CC,$00,$BC             ; 05DB33 DDDDDDDD ????????
.byte $00,$00,$BD,$10,$7F,$30,$FF,$47             ; 05DB3B DDDDDDDD ?????0?G
.byte $F6,$30,$FD,$C2,$5B,$82,$77,$82             ; 05DB43 DDDDDDDD ?0??[?w?
.byte $4F,$42,$01,$01,$08,$01,$03,$01             ; 05DB4B DDDDDDDD OB??????
.byte $05,$21,$0F,$05,$3F,$01,$80,$F0             ; 05DB53 DDDDDDDD ?!??????
.byte $80,$C0,$80,$1C,$DF,$43,$F3,$0B             ; 05DB5B DDDDDDDD ?????C??
.byte $AB,$09,$19,$F0,$7F,$C0,$7F,$C0             ; 05DB63 DDDDDDDD ????????
.byte $FF,$9E,$E1,$FF,$C3,$F3,$A0,$A1             ; 05DB6B DDDDDDDD ????????
.byte $CA,$17,$EE,$02,$60,$00,$02,$04             ; 05DB73 DDDDDDDD ????`???
.byte $0E,$00,$12,$04,$0E,$C2,$FC,$B6             ; 05DB7B DDDDDDDD ????????
.byte $B4,$36,$74,$79,$E6,$0D,$F0,$0D             ; 05DB83 DDDDDDDD ?6ty????
.byte $F8,$0D,$E0,$0D,$F8,$FC,$22,$AC             ; 05DB8B DDDDDDDD ??????"?
.byte $5A,$2C,$DA,$04,$06,$81,$83,$49             ; 05DB93 DDDDDDDD Z,?????I
.byte $09,$00,$0E,$11,$08,$80,$10,$91             ; 05DB9B DDDDDDDD ????????
.byte $05,$02,$FD,$02,$F9,$40,$B1,$0E             ; 05DBA3 DDDDDDDD ?????@??
.byte $1C,$90,$0F,$80,$0F,$88,$16,$81             ; 05DBAB DDDDDDDD ????????
.byte $00,$08,$41,$61,$29,$C7,$85,$05             ; 05DBB3 DDDDDDDD ??Aa)???
.byte $23,$02,$41,$08,$01,$F8,$00,$16             ; 05DBBB DDDDDDDD #?A?????
.byte $08,$3D,$C2,$87,$40,$35,$4A,$C1             ; 05DBC3 DDDDDDDD ?=??@5J?
.byte $3E,$81,$7E,$01,$FE,$07,$07,$0F             ; 05DBCB DDDDDDDD >?~?????
.byte $0B,$1E,$1F,$7D,$77,$31,$21,$7B             ; 05DBD3 DDDDDDDD ???}w1!{
.byte $7B,$07,$03,$0C,$07,$18,$87,$F8             ; 05DBDB DDDDDDDD {???????
.byte $4E,$7F,$04,$7F,$F0,$48,$F8,$84             ; 05DBE3 DDDDDDDD N????H??
.byte $F8,$07,$F8,$FE,$F6,$F7,$F4,$F0             ; 05DBEB DDDDDDDD ????????
.byte $08,$F8,$04,$F8,$07,$00,$FE,$08             ; 05DBF3 DDDDDDDD ????????
.byte $FF,$08,$88,$7A,$FA,$1A,$BA,$1E             ; 05DBFB DDDDDDDD ???z????
.byte $E6,$05,$93,$08,$77,$FA,$05,$3A             ; 05DC03 DDDDDDDD ????w??:
.byte $05,$C6,$01,$83,$E0,$60,$78,$F8             ; 05DC0B DDDDDDDD ?????`x?
.byte $FC,$FC,$FE,$FC,$FF,$FB,$FC,$00             ; 05DC13 DDDDDDDD ????????
.byte $78,$80,$FC,$FF,$01,$01,$03,$02             ; 05DC1B DDDDDDDD x???????
.byte $0C,$01,$0D,$00,$0C,$02,$04,$02             ; 05DC23 DDDDDDDD ????????
.byte $81,$AA,$01,$2A,$03,$A0,$02,$58             ; 05DC2B DDDDDDDD ???*???X
.byte $82,$54,$02,$0D,$01,$1E,$01,$1A             ; 05DC33 DDDDDDDD ?T??????
.byte $54,$00,$D4,$00,$5C,$00,$A5,$00             ; 05DC3B DDDDDDDD T???\???
.byte $29,$E0,$00,$E4,$00,$A2,$7F,$70             ; 05DC43 DDDDDDDD )??????p
.byte $1E,$60,$96,$EE,$0F,$BC,$6F,$BC             ; 05DC4B DDDDDDDD ?`????o?
.byte $5E,$30,$CE,$B2,$4E,$3F,$19,$9E             ; 05DC53 DDDDDDDD ^0??N???
.byte $0D,$16,$0F,$0F,$19,$2F,$3B,$1E             ; 05DC5B DDDDDDDD ?????/;?
.byte $13,$0E,$03,$0E,$01,$0F,$0F,$41             ; 05DC63 DDDDDDDD ???????A
.byte $21,$A8,$70,$BC,$70,$A6,$78,$08             ; 05DC6B DDDDDDDD !?p?p?x?
.byte $70,$61,$1E,$30,$0F,$0F,$F0,$3E             ; 05DC73 DDDDDDDD pa?0???>
.byte $7C,$3C,$7C,$54,$16,$14,$56,$E8             ; 05DC7B DDDDDDDD |<|T??V?
.byte $4E,$48,$EE,$08,$4E,$48,$06,$3C             ; 05DC83 DDDDDDDD NH??NH?<
.byte $C2,$3E,$C0,$14,$E8,$14,$E8,$08             ; 05DC8B DDDDDDDD ?>??????
.byte $F0,$E8,$B0,$48,$F0,$35,$96,$30             ; 05DC93 DDDDDDDD ???H?5?0
.byte $B5,$71,$D6,$12,$54,$30,$35,$11             ; 05DC9B DDDDDDDD ?q??T05?
.byte $34,$0C,$0C,$06,$07,$14,$83,$04             ; 05DCA3 DDDDDDDD 4???????
.byte $B3,$C4,$13,$54,$03,$34,$03,$34             ; 05DCAB DDDDDDDD ???T?4?4
.byte $03,$0C,$03,$07,$00,$84,$41,$10             ; 05DCB3 DDDDDDDD ??????A?
.byte $E1,$00,$F1,$82,$73,$68,$0E,$90             ; 05DCBB DDDDDDDD ????sh??
.byte $1C,$80,$01,$FE,$01,$FE,$01,$FE             ; 05DCC3 DDDDDDDD ????????
.byte $03,$FC,$0E,$F0,$1C,$E0,$7F,$2F             ; 05DCCB DDDDDDDD ???????/
.byte $7F,$20,$77,$01,$21,$01,$38,$5F             ; 05DCD3 DDDDDDDD ? w?!?8_
.byte $00,$5F,$1E,$EC,$FE,$04,$F6,$80             ; 05DCDB DDDDDDDD ?_??????
.byte $86,$80,$0E,$FB,$7E,$61,$04,$18             ; 05DCE3 DDDDDDDD ????~a??
.byte $01,$18,$00,$06,$EF,$F0,$1E,$61             ; 05DCEB DDDDDDDD ???????a
.byte $1E,$20,$DC,$60,$18,$60,$10,$20             ; 05DCF3 DDDDDDDD ? ?`?`? 
.byte $61,$40,$20,$00,$20,$40,$60,$08             ; 05DCFB DDDDDDDD a@ ? @`?
.byte $01,$0B,$00,$0B,$04,$0F,$04,$0F             ; 05DD03 DDDDDDDD ????????
.byte $04,$0F,$0F,$9A,$80,$BA,$00,$BB             ; 05DD0B DDDDDDDD ????????
.byte $7D,$00,$E7,$03,$EC,$07,$8A,$65             ; 05DD13 DDDDDDDD }??????e
.byte $00,$45,$00,$44,$18,$32,$40,$B0             ; 05DD1B DDDDDDDD ?E?D?2@?
.byte $4E,$32,$4E,$10,$6F,$37,$4F,$26             ; 05DD23 DDDDDDDD N2N?o7O&
.byte $DF,$0B,$F7,$27,$FF,$27,$DF,$0E             ; 05DD2B DDDDDDDD ???'?'??
.byte $03,$8E,$01,$8F,$01,$8F,$07,$00             ; 05DD33 DDDDDDDD ????????
.byte $27,$3F,$3F,$1F,$1F,$1F,$0F,$16             ; 05DD3B DDDDDDDD '???????
.byte $C4,$8B,$C7,$87,$F0,$E8,$FF,$E1             ; 05DD43 DDDDDDDD ????????
.byte $FE,$3F,$E0,$10,$FF,$08,$FF,$C4             ; 05DD4B DDDDDDDD ????????
.byte $FF,$C7,$7F,$F0,$1F,$FF,$07,$FE             ; 05DD53 DDDDDDDD ????????
.byte $10,$C0,$EE,$E4,$EE,$C8,$D6,$48             ; 05DD5B DDDDDDDD ???????H
.byte $56,$88,$D6,$80,$3E,$40,$BE,$40             ; 05DD63 DDDDDDDD V???>@?@
.byte $BE,$E0,$30,$20,$F0,$40,$E0,$40             ; 05DD6B DDDDDDDD ??0 ?@?@
.byte $E0,$C0,$40,$11,$00,$0A,$06,$01             ; 05DD73 DDDDDDDD ??@?????
.byte $01,$0B,$19,$1F,$3F,$3F,$1E,$3F             ; 05DD7B DDDDDDDD ????????
.byte $40,$38,$18,$1C,$0C,$02,$02,$1E             ; 05DD83 DDDDDDDD @8??????
.byte $02,$2E,$0A,$76,$72,$78,$E0,$FC             ; 05DD8B DDDDDDDD ?.?vrx??
.byte $F8,$FE,$E0,$FE,$C0,$FE,$10,$E6             ; 05DD93 DDDDDDDD ????????
.byte $02,$20,$00,$7C,$1C,$27,$27,$10             ; 05DD9B DDDDDDDD ? ?|?''?
.byte $33,$02,$7E,$00,$FF,$60,$FF,$40             ; 05DDA3 DDDDDDDD 3?~??`?@
.byte $40,$40,$F0,$F0,$B6,$B6,$0E,$0E             ; 05DDAB DDDDDDDD @@??????
.byte $FE,$1E,$EE,$80,$00,$C0,$B0,$40             ; 05DDB3 DDDDDDDD ???????@
.byte $40,$FE,$04,$FA,$02,$FC,$06,$F8             ; 05DDBB DDDDDDDD @???????
.byte $28,$28,$14,$14,$0A,$0A,$07,$07             ; 05DDC3 DDDDDDDD ((??????
.byte $30,$20,$18,$08,$0C,$04,$06,$02             ; 05DDCB DDDDDDDD 0 ??????
.byte $03,$03,$03,$48,$08,$0C,$50,$F0             ; 05DDD3 DDDDDDDD ???H??P?
.byte $B0,$07,$03,$07,$05,$07,$0C,$0C             ; 05DDDB DDDDDDDD ????????
.byte $11,$10,$26,$21,$0D,$03,$58,$47             ; 05DDE3 DDDDDDDD ??&!??XG
.byte $00,$07,$02,$0C,$03,$10,$0F,$20             ; 05DDEB DDDDDDDD ??????? 
.byte $1F,$00,$3F,$40,$3F,$87,$8F,$C9             ; 05DDF3 DDDDDDDD ???@????
.byte $D3,$A0,$B1,$00,$18,$60,$80,$30             ; 05DDFB DDDDDDDD ?????`?0
.byte $C0,$10,$E0,$30,$C0,$B7,$40,$C3             ; 05DE03 DDDDDDDD ???0??@?
.byte $26,$A1,$4F,$00,$E7,$37,$DF,$FB             ; 05DE0B DDDDDDDD &?O??7??
.byte $DF,$D2,$EF,$5C,$EF,$2F,$3F,$13             ; 05DE13 DDDDDDDD ???\?/??
.byte $1B,$02,$08,$01,$00,$17,$00,$9B             ; 05DE1B DDDDDDDD ????????
.byte $00,$CF,$0D,$CF,$83,$0F,$C0,$03             ; 05DE23 DDDDDDDD ????????
.byte $E4,$00,$F7,$00,$FF,$C7,$E6,$87             ; 05DE2B DDDDDDDD ????????
.byte $C6,$83,$C2,$C3,$E2,$A1,$FB,$41             ; 05DE33 DDDDDDDD ???????A
.byte $F3,$C3,$F3,$B1,$30,$E6,$38,$C6             ; 05DE3B DDDDDDDD ????0?8?
.byte $78,$C2,$7C,$E2,$3C,$FB,$5E,$F3             ; 05DE43 DDDDDDDD x?|?<?^?
.byte $BE,$F3,$3C,$30,$CF,$74,$8A,$3A             ; 05DE4B DDDDDDDD ??<0?t?:
.byte $FC,$7C,$FC,$6E,$FE,$DE,$DE,$8F             ; 05DE53 DDDDDDDD ?|?n????
.byte $8F,$87,$07,$03,$78,$40,$7C,$00             ; 05DE5B DDDDDDDD ????x@|?
.byte $7E,$10,$DE,$20,$8F,$70,$07,$F8             ; 05DE63 DDDDDDDD ~?? ?p??
.byte $03,$80,$80,$40,$C0,$C0,$13,$00             ; 05DE6B DDDDDDDD ???@????
.byte $0F,$09,$08,$08,$08,$2B,$2A,$2F             ; 05DE73 DDDDDDDD ?????+*/
.byte $2D,$1A,$1A,$0C,$3F,$01,$3E,$38             ; 05DE7B DDDDDDDD -?????>8
.byte $00,$38,$02,$39,$1E,$C6,$C2,$06             ; 05DE83 DDDDDDDD ?8?9????
.byte $02,$1A,$1A,$36,$2E,$F8,$D8,$C0             ; 05DE8B DDDDDDDD ???6.???
.byte $40,$40,$86,$00,$06,$14,$0E,$28             ; 05DE93 DDDDDDDD @@?????(
.byte $1E,$80,$78,$40,$7F,$40,$33,$30             ; 05DE9B DDDDDDDD ??x@?@30
.byte $06,$20,$1F,$04,$E6,$06,$E6,$06             ; 05DEA3 DDDDDDDD ? ??????
.byte $EE,$0E,$3E,$3E,$FC,$06,$F8,$06             ; 05DEAB DDDDDDDD ??>>????
.byte $F8,$04,$04,$04,$01,$01,$02,$0B             ; 05DEB3 DDDDDDDD ????????
.byte $02,$02,$03,$01,$06,$02,$80,$80             ; 05DEBB DDDDDDDD ????????
.byte $20,$20,$E8,$E8,$04,$0C,$30,$30             ; 05DEC3 DDDDDDDD   ????00
.byte $10,$10,$80,$C0,$C0,$30,$20,$30             ; 05DECB DDDDDDDD ?????0 0
.byte $03,$05,$01,$05,$07,$00,$18,$07             ; 05DED3 DDDDDDDD ????????
.byte $99,$06,$99,$C6,$70,$4E,$B2,$8C             ; 05DEDB DDDDDDDD ????pN??
.byte $A3,$9D,$67,$19,$45,$39,$40,$40             ; 05DEE3 DDDDDDDD ??g?E9@@
.byte $3F,$C0,$3F,$80,$7F,$01,$FE,$FB             ; 05DEEB DDDDDDDD ????????
.byte $1F,$B7,$3B,$4D,$73,$BC,$C3,$78             ; 05DEF3 DDDDDDDD ??;Ms??x
.byte $87,$FF,$80,$79,$80,$B0,$00,$1F             ; 05DEFB DDDDDDDD ???y????
.byte $E0,$3F,$C0,$7F,$80,$FF,$C3,$C3             ; 05DF03 DDDDDDDD ????????
.byte $FC,$C0,$FF,$C0,$31,$CE,$78,$C7             ; 05DF0B DDDDDDDD ????1?x?
.byte $1C,$C3,$AE,$61,$FF,$00,$C3,$3C             ; 05DF13 DDDDDDDD ???a???<
.byte $C0,$C0,$3F,$E0,$1F,$61,$11,$91             ; 05DF1B DDDDDDDD ?????a??
.byte $91,$F7,$F7,$01,$1A,$EB,$0C,$74             ; 05DF23 DDDDDDDD ???????t
.byte $87,$1B,$E3,$0D,$11,$1B,$E4,$9F             ; 05DF2B DDDDDDDD ????????
.byte $60,$F7,$08,$1F,$E0,$0F,$F0,$E1             ; 05DF33 DDDDDDDD `???????
.byte $FE,$CF,$FE,$F6,$BF,$31,$F1,$22             ; 05DF3B DDDDDDDD ?????1?"
.byte $A0,$6F,$20,$DE,$B0,$FA,$C8,$CE             ; 05DF43 DDDDDDDD ?o ?????
.byte $E5,$F1,$0E,$E0,$1F,$E0,$1F,$F1             ; 05DF4B DDDDDDDD ????????
.byte $0F,$F9,$07,$FC,$03,$40,$80,$20             ; 05DF53 DDDDDDDD ?????@? 
.byte $40,$C0,$10,$48,$88,$60,$00,$2C             ; 05DF5B DDDDDDDD @??H?`?,
.byte $0C,$E0,$00,$70,$80,$10,$E0,$00             ; 05DF63 DDDDDDDD ???p????
.byte $F0,$88,$F0,$C8,$61,$41,$10,$00             ; 05DF6B DDDDDDDD ????aA??
.byte $50,$D4,$9D,$9D,$D5,$DD,$00,$55             ; 05DF73 DDDDDDDD P??????U
.byte $00,$D5,$00,$D5,$00,$61,$20,$30             ; 05DF7B DDDDDDDD ?????a 0
.byte $D4,$DD,$DD,$55,$55,$D5,$D5,$D5             ; 05DF83 DDDDDDDD ???UU???
.byte $D5,$02,$02,$06,$04,$95,$B5,$A5             ; 05DF8B DDDDDDDD ????????
.byte $A5,$37,$B7,$00,$97,$00,$B5,$00             ; 05DF93 DDDDDDDD ?7??????
.byte $B5,$B5,$B7,$B7,$97,$97,$B5,$B5             ; 05DF9B DDDDDDDD ????????
.byte $B5,$B5,$02,$1F,$1F,$01,$1E,$06             ; 05DFA3 DDDDDDDD ????????
.byte $18,$03,$1F,$06,$80,$00,$78,$B0             ; 05DFAB DDDDDDDD ??????x?
.byte $F6,$98,$C0,$CC,$C6,$FE,$46,$F6             ; 05DFB3 DDDDDDDD ??????F?
.byte $80,$18,$80,$08,$E0,$09,$C0,$33             ; 05DFBB DDDDDDDD ???????3
.byte $30,$2D,$04,$44,$04,$86,$3F,$E7             ; 05DFC3 DDDDDDDD 0-?D????
.byte $1F,$C6,$3F,$0C,$3F,$02,$3F,$05             ; 05DFCB DDDDDDDD ????????
.byte $69,$01,$70,$11,$B8,$03,$2C,$0F             ; 05DFD3 DDDDDDDD i?p???,?
.byte $1C,$08,$28,$28,$A6,$24,$00,$01             ; 05DFDB DDDDDDDD ??((?$??
.byte $FC,$43,$FC,$C3,$FC,$E0,$FC,$C0             ; 05DFE3 DDDDDDDD ?C??????
.byte $FC,$20,$96,$02,$0A,$06,$0D,$0C             ; 05DFEB DDDDDDDD ? ??????
.byte $15,$04,$13,$18,$2F,$08,$36,$29             ; 05DFF3 DDDDDDDD ????/?6)
.byte $4E,$39,$06,$01,$06,$01,$04,$08             ; 05DFFB DDDDDDDD N9??????
.byte $07,$18,$07,$18,$07,$38,$07,$CC             ; 05E003 DDDDDDDD ?????8??
.byte $31,$CB,$32,$9A,$62,$96,$64,$2E             ; 05E00B DDDDDDDD 1?2?b?d.
.byte $C8,$37,$D9,$5C,$91,$7A,$B3,$03             ; 05E013 DDDDDDDD ?7?\?z??
.byte $FC,$07,$F8,$0F,$F0,$1E,$E0,$1E             ; 05E01B DDDDDDDD ????????
.byte $E0,$3C,$C0,$00,$EF,$18,$97,$3C             ; 05E023 DDDDDDDD ?<?????<
.byte $83,$FF,$00,$E0,$FF,$F7,$34,$F9             ; 05E02B DDDDDDDD ??????4?
.byte $79,$EF,$EF,$D7,$D7,$2F,$2F,$1B             ; 05E033 DDDDDDDD y????//?
.byte $1B,$36,$F1,$12,$F1,$09,$F8,$05             ; 05E03B DDDDDDDD ?6??????
.byte $FC,$E1,$1F,$F8,$0F,$FF,$01,$EA             ; 05E043 DDDDDDDD ????????
.byte $15,$F0,$0F,$F0,$0F,$F8,$FF,$E0             ; 05E04B DDDDDDDD ????????
.byte $F7,$F0,$FE,$FE,$FF,$FF,$06,$00             ; 05E053 DDDDDDDD ????????
.byte $03,$04,$03,$C4,$C3,$24,$9D,$81             ; 05E05B DDDDDDDD ?????$??
.byte $6E,$FF,$3F,$F8,$FF,$F8,$FF,$38             ; 05E063 DDDDDDDD n??????8
.byte $FF,$18,$FF,$81,$7E,$F0,$E4,$4F             ; 05E06B DDDDDDDD ????~??O
.byte $72,$48,$72,$5D,$61,$6D,$F0,$B5             ; 05E073 DDDDDDDD rHr]am??
.byte $79,$EA,$0D,$03,$FC,$FD,$03,$7E             ; 05E07B DDDDDDDD y??????~
.byte $81,$7E,$81,$FE,$28,$8C,$68,$8C             ; 05E083 DDDDDDDD ?~??(?h?
.byte $68,$0E,$18,$1E,$D8,$DE,$30,$AE             ; 05E08B DDDDDDDD h?????0?
.byte $0C,$FE,$1A,$FC,$4C,$F0,$0E,$F0             ; 05E093 DDDDDDDD ????L???
.byte $0E,$DE,$22,$BE,$4E,$FE,$FE,$FE             ; 05E09B DDDDDDDD ??"?N???
.byte $0A,$7F,$7F,$2C,$0F,$0D,$0D,$6F             ; 05E0A3 DDDDDDDD ???,???o
.byte $4E,$8E,$0C,$1C,$1C,$04,$0E,$1C             ; 05E0AB DDDDDDDD N???????
.byte $20,$3E,$23,$1C,$63,$1C,$82,$1C             ; 05E0B3 DDDDDDDD  >#?c???
.byte $48,$40,$D7,$F7,$EE,$FF,$7C,$7E             ; 05E0BB DDDDDDDD H@????|~
.byte $3C,$3C,$38,$3C,$30,$F7,$38,$CF             ; 05E0C3 DDDDDDDD <<8<0?8?
.byte $10,$EE,$7C,$30,$00,$14,$18,$17             ; 05E0CB DDDDDDDD ??|0????
.byte $18,$34,$08,$21,$01,$1C,$04,$07             ; 05E0D3 DDDDDDDD ?4?!????
.byte $07,$07,$C8,$02,$FA,$00,$70,$C8             ; 05E0DB DDDDDDDD ??????p?
.byte $C8,$78,$78,$70,$70,$60,$1C,$14             ; 05E0E3 DDDDDDDD ?xxpp`??
.byte $10,$10,$11,$06,$07,$1B,$03,$1F             ; 05E0EB DDDDDDDD ????????
.byte $06,$1F,$07,$0F,$04,$05,$02,$07             ; 05E0F3 DDDDDDDD ????????
.byte $01,$A8,$28,$C8,$08,$30,$10,$E0             ; 05E0FB DDDDDDDD ??(??0??
.byte $A0,$C0,$40,$C0,$C0,$20,$D8,$F8             ; 05E103 DDDDDDDD ??@?? ??
.byte $20,$F8,$00,$B0,$40,$E0,$80,$46             ; 05E10B DDDDDDDD  ???@??F
.byte $71,$B4,$13,$95,$F2,$6B,$24,$CA             ; 05E113 DDDDDDDD q????k$?
.byte $44,$55,$C9,$9D,$81,$BB,$82,$30             ; 05E11B DDDDDDDD DU?????0
.byte $0F,$70,$0F,$70,$0F,$E0,$1F,$C0             ; 05E123 DDDDDDDD ?p?p????
.byte $3F,$83,$7C,$F8,$21,$B0,$25,$F0             ; 05E12B DDDDDDDD ??|?!?%?
.byte $40,$70,$48,$F0,$90,$20,$80,$20             ; 05E133 DDDDDDDD @pH?? ? 
.byte $3C,$C0,$38,$C0,$78,$80,$70,$C0             ; 05E13B DDDDDDDD <?8?x?p?
.byte $00,$FF,$F0,$FF,$F8,$DF,$DC,$EF             ; 05E143 DDDDDDDD ????????
.byte $EE,$60,$60,$40,$40,$21,$21,$20             ; 05E14B DDDDDDDD ?``@@!! 
.byte $20,$0F,$0F,$07,$07,$23,$03,$11             ; 05E153 DDDDDDDD  ????#??
.byte $01,$1F,$00,$F4,$0B,$EA,$15,$F4             ; 05E15B DDDDDDDD ????????
.byte $0B,$FA,$05,$7E,$01,$3E,$01,$DF             ; 05E163 DDDDDDDD ???~?>??
.byte $C0,$E7,$E0,$FF,$FF,$FF,$7F,$FF             ; 05E16B DDDDDDDD ????????
.byte $07,$02,$FF,$A5,$FF,$5F,$FF,$AF             ; 05E173 DDDDDDDD ?????_??
.byte $FF,$2F,$06,$FF,$C0,$3F,$93,$FC             ; 05E17B DDDDDDDD ?/??????
.byte $6B,$FC,$97,$F8,$E7,$F8,$DF,$E0             ; 05E183 DDDDDDDD k???????
.byte $BF,$C0,$37,$C0,$E2,$02,$F7,$FD             ; 05E18B DDDDDDDD ??7?????
.byte $E0,$BA,$7C,$96,$78,$4C,$B0,$A8             ; 05E193 DDDDDDDD ??|?xL??
.byte $50,$FC,$FC,$F8,$F8,$F0,$F0,$E0             ; 05E19B DDDDDDDD P???????
.byte $E0,$00,$33,$01,$FF,$81,$FF,$81             ; 05E1A3 DDDDDDDD ??3?????
.byte $80,$80,$80,$F2,$9F,$F1,$9F,$68             ; 05E1AB DDDDDDDD ???????h
.byte $9F,$ED,$0D,$EE,$0E,$A7,$05,$07             ; 05E1B3 DDDDDDDD ????????
.byte $09,$07,$0A,$0E,$1B,$10,$0D,$0A             ; 05E1BB DDDDDDDD ????????
.byte $21,$16,$3A,$34,$07,$10,$0F,$10             ; 05E1C3 DDDDDDDD !?:4????
.byte $0F,$7D,$06,$5F,$24,$B2,$44,$BE             ; 05E1CB DDDDDDDD ?}?_$?D?
.byte $48,$32,$C4,$1B,$E2,$8A,$73,$8D             ; 05E1D3 DDDDDDDD H2????s?
.byte $71,$07,$03,$FC,$01,$FE,$20,$50             ; 05E1DB DDDDDDDD q????? P
.byte $90,$E0,$00,$18,$18,$18,$18,$04             ; 05E1E3 DDDDDDDD ????????
.byte $04,$04,$07,$03,$00,$3F,$3E,$1F             ; 05E1EB DDDDDDDD ??????>?
.byte $1F,$02,$01,$02,$C1,$01,$E0,$10             ; 05E1F3 DDDDDDDD ????????
.byte $E0,$3F,$FE,$3F,$CE,$0E,$02,$02             ; 05E1FB DDDDDDDD ????????
.byte $02,$02,$46,$04,$C4,$30,$7E,$20             ; 05E203 DDDDDDDD ??F??0~ 
.byte $36,$20,$24,$20,$29,$1F,$1F,$E1             ; 05E20B DDDDDDDD 6 $ )???
.byte $9F,$F2,$9F,$C6,$8F,$7F,$2E,$0E             ; 05E213 DDDDDDDD ??????.?
.byte $2D,$0D,$30,$30,$1A,$15,$18,$15             ; 05E21B DDDDDDDD -?00????
.byte $12,$13,$0C,$0E,$08,$31,$0E,$31             ; 05E223 DDDDDDDD ?????1?1
.byte $0E,$33,$0C,$1F,$C4,$B8,$0E,$30             ; 05E22B DDDDDDDD ?3?????0
.byte $7F,$40,$2F,$20,$8E,$06,$22,$30             ; 05E233 DDDDDDDD ?@/ ??"0
.byte $10,$80,$7F,$80,$7F,$FE,$01,$0F             ; 05E23B DDDDDDDD ????????
.byte $00,$A0,$C0,$50,$60,$29,$30,$B4             ; 05E243 DDDDDDDD ???P`)0?
.byte $38,$0F,$0E,$C6,$C7,$A3,$63,$2F             ; 05E24B DDDDDDDD 8?????c/
.byte $1F,$F8,$00,$7C,$80,$3E,$0F,$F0             ; 05E253 DDDDDDDD ???|?>??
.byte $C7,$38,$E3,$1C,$FF,$04,$04,$06             ; 05E25B DDDDDDDD ?8??????
.byte $06,$06,$86,$04,$04,$94,$04,$44             ; 05E263 DDDDDDDD ???????D
.byte $84,$B6,$C6,$C3,$00,$E3,$F9,$03             ; 05E26B DDDDDDDD ????????
.byte $00,$63,$00,$FA,$01,$45,$3B,$B3             ; 05E273 DDDDDDDD ?c???E;?
.byte $13,$61,$21,$0C,$40,$FE,$40,$3E             ; 05E27B DDDDDDDD ?a!?@?@>
.byte $80,$BC,$80,$BC,$80,$3C,$00,$F3             ; 05E283 DDDDDDDD ?????<??
.byte $0C,$E1,$1E,$80,$CC,$0C,$CC,$88             ; 05E28B DDDDDDDD ????????
.byte $C8,$88,$D8,$98,$D8,$90,$D0,$90             ; 05E293 DDDDDDDD ????????
.byte $D0,$03,$40,$C1,$18,$18,$03,$03             ; 05E29B DDDDDDDD ??@?????
.byte $EB,$F3,$70,$F8,$BC,$78,$1F,$0E             ; 05E2A3 DDDDDDDD ??p??x??
.byte $C3,$C6,$7E,$7B,$37,$33,$37,$33             ; 05E2AB DDDDDDDD ??~{7373
.byte $87,$00,$CF,$00,$CF,$00,$19,$FF             ; 05E2B3 DDDDDDDD ????????
.byte $1D,$7F,$0F,$3F,$01,$5F,$C1,$2F             ; 05E2BB DDDDDDDD ?????_?/
.byte $10,$A7,$58,$BB,$0C,$FD,$40,$30             ; 05E2C3 DDDDDDDD ??X???@0
.byte $3C,$3C,$00,$3C,$00,$3C,$81,$81             ; 05E2CB DDDDDDDD <<?<?<??
.byte $CF,$CE,$FA,$7E,$C1,$3F,$81,$7E             ; 05E2D3 DDDDDDDD ???~???~
.byte $CF,$30,$D0,$90,$10,$90,$90,$10             ; 05E2DB DDDDDDDD ?0??????
.byte $10,$60,$07,$03,$07,$0B,$07,$0B             ; 05E2E3 DDDDDDDD ?`??????
.byte $04,$1C,$0B,$08,$0B,$08,$1F,$18             ; 05E2EB DDDDDDDD ????????
.byte $1F,$18,$D3,$03,$37,$03,$1F,$02             ; 05E2F3 DDDDDDDD ????7???
.byte $43,$02,$5B,$0A,$5B,$4A,$5E,$4E             ; 05E2FB DDDDDDDD C?[?[J^N
.byte $2E,$2C,$2F,$E7,$00,$BF,$40,$AF             ; 05E303 DDDDDDDD .,/???@?
.byte $50,$EF,$10,$EF,$10,$FF,$00,$65             ; 05E30B DDDDDDDD P??????e
.byte $9E,$52,$AF,$88,$17,$22,$0D,$70             ; 05E313 DDDDDDDD ?R???"?p
.byte $07,$09,$32,$E4,$B9,$F2,$3C,$FF             ; 05E31B DDDDDDDD ??2???<?
.byte $3E,$1F,$FF,$0F,$FF,$07,$BF,$43             ; 05E323 DDDDDDDD >??????C
.byte $BF,$41,$3F,$C0,$00,$FE,$40,$9F             ; 05E32B DDDDDDDD ?A????@?
.byte $B0,$5F,$40,$B0,$A0,$50,$78,$80             ; 05E333 DDDDDDDD ?_@??Px?
.byte $80,$FF,$C0,$EF,$E0,$EF,$E0,$00             ; 05E33B DDDDDDDD ????????
.byte $C0,$18,$C8,$10,$80,$10,$88,$10             ; 05E343 DDDDDDDD ????????
.byte $08,$14,$0C,$30,$08,$30,$0C,$10             ; 05E34B DDDDDDDD ???0?0??
.byte $F8,$10,$F8,$10,$FC,$30,$FC,$1F             ; 05E353 DDDDDDDD ?????0??
.byte $02,$1F,$02,$1F,$10,$0F,$14,$0F             ; 05E35B DDDDDDDD ????????
.byte $08,$04,$03,$1F,$10,$1F,$10,$00             ; 05E363 DDDDDDDD ????????
.byte $05,$01,$C1,$01,$FF,$01,$F7,$17             ; 05E36B DDDDDDDD ????????
.byte $EC,$0F,$F8,$3F,$70,$9F,$30,$9F             ; 05E373 DDDDDDDD ????p?0?
.byte $F0,$80,$7F,$D9,$1E,$CD,$0E,$CF             ; 05E37B DDDDDDDD ????????
.byte $8E,$E6,$C7,$E6,$C7,$66,$C7,$66             ; 05E383 DDDDDDDD ?????f?f
.byte $C7,$76,$C7,$07,$F8,$7C,$00,$BF             ; 05E38B DDDDDDDD ?v???|??
.byte $00,$5F,$80,$7F,$90,$2F,$C0,$FF             ; 05E393 DDDDDDDD ?_???/??
.byte $7C,$EF,$0F,$0F,$30,$0C,$F2,$1E             ; 05E39B DDDDDDDD |???0???
.byte $E0,$1C,$EC,$1E,$CC,$36,$EB,$33             ; 05E3A3 DDDDDDDD ?????6?3
.byte $CA,$12,$CD,$19,$FC,$30,$EC,$E0             ; 05E3AB DDDDDDDD ?????0??
.byte $E0,$D6,$C8,$D2,$CC,$F3,$CC,$F9             ; 05E3B3 DDDDDDDD ????????
.byte $C6,$0F,$03,$08,$05,$04,$B0,$9F             ; 05E3BB DDDDDDDD ????????
.byte $B0,$BF,$B8,$9F,$F8,$9F,$F8,$9F             ; 05E3C3 DDDDDDDD ????????
.byte $F8,$8F,$F8,$8F,$B8,$8F,$76,$C7             ; 05E3CB DDDDDDDD ??????v?
.byte $76,$E7,$76,$E7,$F6,$C7,$4F,$B0             ; 05E3D3 DDDDDDDD v?v???O?
.byte $4F,$B0,$4F,$B8,$67,$90,$6E,$91             ; 05E3DB DDDDDDDD O?O?g?n?
.byte $FF,$0F,$F7,$07,$06,$CD,$19,$CA             ; 05E3E3 DDDDDDDD ????????
.byte $18,$8F,$5C,$C0,$5D,$13,$8E,$B2             ; 05E3EB DDDDDDDD ??\?]???
.byte $8E,$20,$1E,$61,$1F,$F9,$C6,$F8             ; 05E3F3 DDDDDDDD ? ?a????
.byte $C7,$BC,$83,$BC,$83,$7E,$01,$FF             ; 05E3FB DDDDDDDD ?????~??
.byte $E0,$C0,$C0,$80,$20,$68,$B0,$40             ; 05E403 DDDDDDDD ???? h?@
.byte $90,$B0,$5C,$22,$48,$30,$C0,$30             ; 05E40B DDDDDDDD ??\"H0?0
.byte $C0,$18,$E0,$18,$E0,$03,$02,$0E             ; 05E413 DDDDDDDD ????????
.byte $06,$15,$35,$0D,$02,$39,$06,$CA             ; 05E41B DDDDDDDD ??5??9??
.byte $02,$04,$11,$20,$80,$00,$C1,$C1             ; 05E423 DDDDDDDD ??? ????
.byte $81,$81,$87,$86,$DC,$D8,$3F,$03             ; 05E42B DDDDDDDD ????????
.byte $FF,$1F,$3E,$FE,$7E,$F8,$79,$F1             ; 05E433 DDDDDDDD ??>?~?y?
.byte $27,$C3,$47,$80,$7B,$0B,$EF,$2E             ; 05E43B DDDDDDDD '?G?{??.
.byte $3F,$38,$FA,$E0,$74,$00,$C8,$07             ; 05E443 DDDDDDDD ?8??t???
.byte $F4,$70,$D1,$C1,$C7,$86,$1E,$1C             ; 05E44B DDDDDDDD ?p??????
.byte $FC,$78,$20,$3C,$8F,$DC,$4F,$9E             ; 05E453 DDDDDDDD ?x <??O?
.byte $47,$3F,$67,$2F,$63,$6F,$23,$2F             ; 05E45B DDDDDDDD G?g/co#/
.byte $23,$2F,$03,$F6,$E6,$87,$E6,$87             ; 05E463 DDDDDDDD #/??????
.byte $E6,$07,$E6,$07,$7F,$81,$76,$8A             ; 05E46B DDDDDDDD ??????v?
.byte $77,$8F,$73,$8B,$7F,$87,$7B,$83             ; 05E473 DDDDDDDD w?s???{?
.byte $7E,$86,$7E,$86,$FE,$06,$FD,$FC             ; 05E47B DDDDDDDD ~?~?????
.byte $F9,$00,$79,$07,$FD,$83,$7C,$03             ; 05E483 DDDDDDDD ??y???|?
.byte $BE,$81,$FF,$C0,$1F,$C7,$58,$2C             ; 05E48B DDDDDDDD ??????X,
.byte $88,$BE,$AC,$96,$72,$CB,$76,$EB             ; 05E493 DDDDDDDD ????r?v?
.byte $79,$E5,$BA,$74,$B5,$72,$0E,$F0             ; 05E49B DDDDDDDD y??t?r??
.byte $8F,$70,$87,$78,$C3,$3C,$E3,$1C             ; 05E4A3 DDDDDDDD ?p?x?<??
.byte $E1,$1E,$04,$05,$01,$0D,$03,$4F             ; 05E4AB DDDDDDDD ???????O
.byte $38,$87,$65,$9A,$00,$18,$07,$70             ; 05E4B3 DDDDDDDD 8?e????p
.byte $0F,$C1,$3E,$0B,$E9,$1D,$E9,$17             ; 05E4BB DDDDDDDD ??>?????
.byte $E1,$1B,$C2,$5F,$AD,$BF,$57,$FC             ; 05E4C3 DDDDDDDD ???_??W?
.byte $2F,$40,$5F,$16,$E9,$16,$E9,$1E             ; 05E4CB DDDDDDDD /@_?????
.byte $E0,$3D,$C0,$32,$C1,$68,$87,$D0             ; 05E4D3 DDDDDDDD ?=?2?h??
.byte $0F,$A0,$1F,$B0,$A0,$60,$40,$86             ; 05E4DB DDDDDDDD ?????`@?
.byte $87,$FF,$FE,$F2,$5F,$87,$BF,$1F             ; 05E4E3 DDDDDDDD ????_???
.byte $78,$3F,$01,$FE,$02,$FC,$04,$F8             ; 05E4EB DDDDDDDD x???????
.byte $08,$F0,$B7,$91,$37,$11,$0F,$19             ; 05E4F3 DDDDDDDD ????7???
.byte $57,$48,$07,$08,$0B,$00,$2B,$20             ; 05E4FB DDDDDDDD WH????+ 
.byte $07,$24,$78,$38,$18,$07,$1C,$03             ; 05E503 DDDDDDDD ?$x8????
.byte $87,$F6,$07,$F6,$FD,$04,$F5,$04             ; 05E50B DDDDDDDD ????????
.byte $F7,$06,$F2,$06,$F0,$02,$D1,$50             ; 05E513 DDDDDDDD ???????P
.byte $80,$F9,$F8,$B9,$40,$9D,$60,$CF             ; 05E51B DDDDDDDD ????@?`?
.byte $30,$C3,$3C,$61,$1E,$B0,$8F,$58             ; 05E523 DDDDDDDD 0?<a???X
.byte $C7,$D4,$33,$DA,$39,$CB,$38,$CD             ; 05E52B DDDDDDDD ??3?9?8?
.byte $3C,$E7,$1E,$E6,$1E,$F3,$0F,$73             ; 05E533 DDDDDDDD <??????s
.byte $8F,$48,$60,$C0,$70,$24,$B0,$60             ; 05E53B DDDDDDDD ?H`?p$?`
.byte $B8,$B0,$5A,$A8,$4C,$D5,$2E,$44             ; 05E543 DDDDDDDD ??Z?L?.D
.byte $36,$70,$80,$78,$80,$38,$C0,$3C             ; 05E54B DDDDDDDD 6p?x?8?<
.byte $C0,$1C,$E0,$07,$06,$00,$0F,$06             ; 05E553 DDDDDDDD ????????
.byte $01,$0F,$00,$08,$11,$10,$21,$63             ; 05E55B DDDDDDDD ??????!c
.byte $0E,$01,$0C,$02,$19,$06,$31,$0E             ; 05E563 DDDDDDDD ??????1?
.byte $63,$1C,$86,$79,$06,$F9,$06,$F9             ; 05E56B DDDDDDDD c??y????
.byte $0D,$F2,$0F,$F0,$F3,$05,$E7,$0A             ; 05E573 DDDDDDDD ????????
.byte $C6,$15,$8F,$28,$9F,$50,$3F,$A0             ; 05E57B DDDDDDDD ???(?P??
.byte $7F,$40,$FF,$80,$86,$78,$0D,$F0             ; 05E583 DDDDDDDD ?@???x??
.byte $1A,$E1,$34,$C3,$69,$86,$40,$3F             ; 05E58B DDDDDDDD ??4?i?@?
.byte $81,$FE,$14,$E0,$60,$86,$80,$30             ; 05E593 DDDDDDDD ????`??0
.byte $92,$41,$E0,$18,$F8,$7F,$0F,$F0             ; 05E59B DDDDDDDD ?A??????
.byte $3E,$C0,$70,$3C,$C0,$05,$04,$11             ; 05E5A3 DDDDDDDD >?p<????
.byte $14,$00,$14,$04,$00,$0A,$0A,$01             ; 05E5AB DDDDDDDD ????????
.byte $0B,$03,$01,$0C,$0C,$03,$06,$07             ; 05E5B3 DDDDDDDD ????????
.byte $00,$E7,$F6,$07,$E7,$06,$67,$06             ; 05E5BB DDDDDDDD ??????g?
.byte $27,$06,$10,$C0,$10,$C0,$88,$08             ; 05E5C3 DDDDDDDD '???????
.byte $2C,$63,$26,$21,$13,$10,$09,$02             ; 05E5CB DDDDDDDD ,c&!????
.byte $11,$EF,$7F,$E0,$1F,$70,$0F,$38             ; 05E5D3 DDDDDDDD ?????p?8
.byte $07,$9E,$81,$7F,$00,$6E,$17,$38             ; 05E5DB DDDDDDDD ?????n?8
.byte $03,$9E,$83,$CC,$C1,$C1,$C1,$E1             ; 05E5E3 DDDDDDDD ????????
.byte $E1,$E2,$E0,$C1,$C0,$83,$7C,$C1             ; 05E5EB DDDDDDDD ??????|?
.byte $3E,$C1,$3E,$E1,$1E,$80,$40,$40             ; 05E5F3 DDDDDDDD >?>???@@
.byte $A0,$00,$60,$A0,$90,$C0,$70,$50             ; 05E5FB DDDDDDDD ??`???pP
.byte $1A,$00,$32,$61,$A1,$E1,$61,$23             ; 05E603 DDDDDDDD ??2a??a#
.byte $23,$A0,$A0,$A0,$A0,$1A,$05,$32             ; 05E60B DDDDDDDD #??????2
.byte $0D,$60,$1F,$E1,$1E,$E1,$1E,$A3             ; 05E613 DDDDDDDD ?`??????
.byte $5C,$A0,$5F,$A1,$5E,$11,$0D,$33             ; 05E61B DDDDDDDD \?_?^??3
.byte $0A,$26,$14,$1F,$28,$BA,$50,$F0             ; 05E623 DDDDDDDD ?&??(?P?
.byte $20,$E3,$40,$CB,$B0,$3A,$C1,$34             ; 05E62B DDDDDDDD  ?@??:?4
.byte $C3,$E8,$07,$D0,$0F,$A3,$1C,$7F             ; 05E633 DDDDDDDD ????????
.byte $00,$EF,$78,$20,$20,$08,$60,$50             ; 05E63B DDDDDDDD ??x  ?`P
.byte $0C,$F0,$F8,$40,$E0,$27,$88,$4F             ; 05E643 DDDDDDDD ???@?'?O
.byte $41,$C0,$B8,$30,$01,$03,$03,$0D             ; 05E64B DDDDDDDD A??0????
.byte $05,$05,$05,$05,$05,$1E,$0E,$0E             ; 05E653 DDDDDDDD ????????
.byte $0E,$0D,$02,$0D,$02,$0D,$02,$1E             ; 05E65B DDDDDDDD ????????
.byte $8B,$89,$12,$16,$17,$1A,$3F,$35             ; 05E663 DDDDDDDD ???????5
.byte $2E,$3A,$5C,$74,$78,$58,$F3,$A3             ; 05E66B DDDDDDDD .:\txX??
.byte $8A,$74,$15,$E8,$1D,$E0,$3B,$C0             ; 05E673 DDDDDDDD ?t????;?
.byte $36,$C1,$6C,$83,$68,$87,$D3,$0C             ; 05E67B DDDDDDDD 6?l?h???
.byte $FC,$00,$63,$03,$8F,$8E,$0E,$0C             ; 05E683 DDDDDDDD ??c?????
.byte $3C,$38,$F8,$F0,$30,$20,$E0,$C0             ; 05E68B DDDDDDDD <8??0 ??
.byte $FC,$03,$E3,$1C,$8F,$70,$0E,$F0             ; 05E693 DDDDDDDD ?????p??
.byte $3C,$C0,$F8,$E0,$1E,$0E,$06,$03             ; 05E69B DDDDDDDD <???????
.byte $22,$12,$20,$04,$00,$44,$20,$09             ; 05E6A3 DDDDDDDD "? ??D ?
.byte $C0,$1E,$0F,$37,$6C,$7F,$DF,$FF             ; 05E6AB DDDDDDDD ???7l???
.byte $7E,$FA,$B9,$B8,$86,$80,$00,$90             ; 05E6B3 DDDDDDDD ~???????
.byte $BF,$7F,$E0,$00,$90,$08,$00,$34             ; 05E6BB DDDDDDDD ???????4
.byte $10,$74,$22,$40,$60,$A0,$40,$18             ; 05E6C3 DDDDDDDD ?t"@`?@?
.byte $00,$2C,$00,$76,$20,$60,$60,$E0             ; 05E6CB DDDDDDDD ?,?v ``?
.byte $E0,$0E,$49,$E7,$90,$D4,$0C,$3C             ; 05E6D3 DDDDDDDD ??I????<
.byte $26,$48,$8C,$EF,$F5,$22,$3D,$A9             ; 05E6DB DDDDDDDD &H???"=?
.byte $EF,$F1,$50,$76,$54,$4D,$95,$14             ; 05E6E3 DDDDDDDD ??PvTM??
.byte $DF,$84,$46,$79,$08,$30,$BC,$E6             ; 05E6EB DDDDDDDD ??Fy?0??
.byte $01,$C8,$72,$1D,$16,$4E,$A7,$61             ; 05E6F3 DDDDDDDD ??r??N?a
.byte $FB,$AC,$CF,$37,$81,$7B,$8C,$B9             ; 05E6FB DDDDDDDD ???7?{??
.byte $45,$4C,$C8,$E6,$00,$9E,$93,$BB             ; 05E703 DDDDDDDD EL??????
.byte $15,$4C,$02,$49,$DE,$B0,$5C,$22             ; 05E70B DDDDDDDD ?L?I??\"
.byte $4B,$5D,$72,$B5,$54,$78,$D9,$41             ; 05E713 DDDDDDDD K]r?Tx?A
.byte $67,$65,$ED,$41,$81,$F2,$3B,$54             ; 05E71B DDDDDDDD ge?A??;T
.byte $67,$64,$E1,$5D,$BD,$85,$7C,$7E             ; 05E723 DDDDDDDD gd?]??|~
.byte $DA,$90,$81,$1C,$5B,$5F,$19,$1B             ; 05E72B DDDDDDDD ????[_??
.byte $6E,$78,$18,$B1,$8D,$54,$75,$42             ; 05E733 DDDDDDDD nx???TuB
.byte $AA,$3C,$5A,$14,$5C,$A0,$74,$4C             ; 05E73B DDDDDDDD ?<Z?\?tL
.byte $E8,$AB,$00,$E6,$06,$E9,$8C,$83             ; 05E743 DDDDDDDD ????????
.byte $BB,$98,$03,$67,$F2,$83,$85,$01             ; 05E74B DDDDDDDD ???g????
.byte $0D,$DD,$02,$04,$0F,$6D,$21,$4C             ; 05E753 DDDDDDDD ?????m!L
.byte $96,$C8,$BD,$FC,$24,$3B,$F6,$C2             ; 05E75B DDDDDDDD ????$;??
.byte $E0,$71,$85,$C0,$D8,$40,$E1,$10             ; 05E763 DDDDDDDD ?q???@??
.byte $21,$70,$78,$10,$3D,$FA,$08,$5F             ; 05E76B DDDDDDDD !px?=??_
.byte $50,$B0,$6E,$46,$CB,$BF,$35,$15             ; 05E773 DDDDDDDD P?nF??5?
.byte $58,$E8,$D0,$40,$64,$AF,$25,$85             ; 05E77B DDDDDDDD X??@d?%?
.byte $F0,$6B,$2D,$12,$0E,$8A,$64,$53             ; 05E783 DDDDDDDD ?k-???dS
.byte $C7,$D8,$40,$0F,$BA,$B2,$A6,$8A             ; 05E78B DDDDDDDD ??@?????
.byte $50,$02,$14,$35,$62,$91,$CE,$E0             ; 05E793 DDDDDDDD P??5b???
.byte $81,$DF,$E1,$27,$33,$DB,$71,$9D             ; 05E79B DDDDDDDD ???'3?q?
.byte $A0,$02,$03,$84,$94,$B3,$93,$B2             ; 05E7A3 DDDDDDDD ????????
.byte $09,$D6,$D9,$27,$32,$FE,$16,$47             ; 05E7AB DDDDDDDD ???'2??G
.byte $87,$F8,$37,$02,$E2,$21,$24,$30             ; 05E7B3 DDDDDDDD ??7??!$0
.byte $1C,$09,$73,$5D,$D3,$40,$01,$61             ; 05E7BB DDDDDDDD ??s]?@?a
.byte $73,$31,$B7,$16,$33,$74,$0D,$6A             ; 05E7C3 DDDDDDDD s1??3t?j
.byte $86,$1D,$84,$64,$35,$AD,$6C,$D5             ; 05E7CB DDDDDDDD ???d5?l?
.byte $64,$1E,$43,$27,$95,$99,$41,$C6             ; 05E7D3 DDDDDDDD d?C'??A?
.byte $EB,$1A,$E0,$DE,$88,$54,$2E,$2E             ; 05E7DB DDDDDDDD ?????T..
.byte $63,$60,$58,$C4,$BB,$89,$65,$84             ; 05E7E3 DDDDDDDD c`X???e?
.byte $E4,$DE,$43,$9F,$C6,$17,$12,$A8             ; 05E7EB DDDDDDDD ??C?????
.byte $0C,$54,$DC,$4D,$D8,$0C,$10,$86             ; 05E7F3 DDDDDDDD ?T?M????
.byte $17,$86,$82,$47,$A1,$10,$80,$E2             ; 05E7FB DDDDDDDD ???G????
.byte $54,$21,$78,$96,$03,$A6,$12,$70             ; 05E803 DDDDDDDD T!x????p
.byte $14,$16,$78,$C0,$55,$65,$77,$07             ; 05E80B DDDDDDDD ??x?Uew?
.byte $81,$1D,$DE,$12,$05,$5C,$5A,$64             ; 05E813 DDDDDDDD ?????\Zd
.byte $76,$BE,$16,$0D,$69,$10,$B9,$9D             ; 05E81B DDDDDDDD v???i???
.byte $55,$65,$F0,$12,$13,$39,$98,$7A             ; 05E823 DDDDDDDD Ue???9?z
.byte $4B,$91,$E6,$70,$84,$CE,$DC,$31             ; 05E82B DDDDDDDD K??p???1
.byte $54,$64,$E2,$51,$E9,$71,$F1,$46             ; 05E833 DDDDDDDD Td?Q?q?F
.byte $7A,$9E,$60,$F1,$80,$87,$B9,$F8             ; 05E83B DDDDDDDD z?`?????
.byte $3C,$70,$3C,$74,$2E,$9F,$D8,$0C             ; 05E843 DDDDDDDD <p<t.???
.byte $4D,$12,$0E,$45,$00,$90,$CE,$B1             ; 05E84B DDDDDDDD M??E????
.byte $93,$CA,$B7,$6D,$61,$13,$71,$28             ; 05E853 DDDDDDDD ???ma?q(
.byte $75,$0C,$13,$C9,$08,$13,$B1,$D9             ; 05E85B DDDDDDDD u???????
.byte $36,$3C,$24,$0D,$DD,$41,$84,$3D             ; 05E863 DDDDDDDD 6<$??A?=
.byte $15,$F5,$50,$95,$3B,$9C,$20,$4F             ; 05E86B DDDDDDDD ??P?;? O
.byte $4F,$09,$0D,$6D,$09,$0C,$EC,$08             ; 05E873 DDDDDDDD O??m????
.byte $5D,$E7,$D5,$58,$47,$E0,$59,$03             ; 05E87B DDDDDDDD ]??XG?Y?
.byte $71,$32,$F8,$96,$03,$CF,$05,$97             ; 05E883 DDDDDDDD q2??????
.byte $13,$25,$B9,$62,$8F,$3B,$D6,$1C             ; 05E88B DDDDDDDD ?%?b?;??
.byte $E5,$FE,$60,$59,$79,$FF,$91,$E8             ; 05E893 DDDDDDDD ??`Yy???
.byte $80,$90,$F8,$C2,$47,$EA,$19,$1C             ; 05E89B DDDDDDDD ????G???
.byte $43,$15,$61,$0E,$06,$E4,$0E,$0D             ; 05E8A3 DDDDDDDD C?a?????
.byte $08,$13,$15,$82,$35,$73,$8E,$CD             ; 05E8AB DDDDDDDD ????5s??
.byte $A0,$07,$D9,$D8,$47,$85,$E8,$4E             ; 05E8B3 DDDDDDDD ????G??N
.byte $97,$42,$14,$F4,$D0,$B7,$9E,$61             ; 05E8BB DDDDDDDD ?B?????a
.byte $1F,$C6,$65,$D8,$FD,$F7,$11,$44             ; 05E8C3 DDDDDDDD ??e????D
.byte $B7,$FE,$CA,$6F,$7A,$20,$78,$00             ; 05E8CB DDDDDDDD ???oz x?
.byte $C8,$E8,$48,$87,$35,$ED,$B0,$5A             ; 05E8D3 DDDDDDDD ??H?5??Z
.byte $17,$54,$F8,$C1,$B2,$A8,$38,$25             ; 05E8DB DDDDDDDD ?T????8%
.byte $04,$38,$01,$C1,$97,$83,$32,$C3             ; 05E8E3 DDDDDDDD ?8????2?
.byte $C1,$55,$B5,$06,$B2,$3B,$3F,$23             ; 05E8EB DDDDDDDD ?U???;?#
.byte $0D,$C1,$21,$94,$D6,$03,$0D,$D1             ; 05E8F3 DDDDDDDD ??!?????
.byte $B3,$C4,$0D,$9C,$EE,$50,$85,$24             ; 05E8FB DDDDDDDD ?????P?$
.byte $4C,$C7,$44,$86,$B2,$B8,$4E,$17             ; 05E903 DDDDDDDD L?D???N?
.byte $9C,$2F,$49,$13,$58,$DE,$85,$68             ; 05E90B DDDDDDDD ?/I?X??h
.byte $47,$8A,$87,$15,$38,$D2,$C0,$42             ; 05E913 DDDDDDDD G???8??B
.byte $71,$63,$83,$8A,$82,$F1,$72,$18             ; 05E91B DDDDDDDD qc????r?
.byte $03,$8B,$98,$B0,$B9,$CE,$8D,$77             ; 05E923 DDDDDDDD ???????w
.byte $E6,$FB,$C2,$03,$4C,$E0,$08,$6D             ; 05E92B DDDDDDDD ????L??m
.byte $36,$12,$39,$00,$43,$C8,$53,$90             ; 05E933 DDDDDDDD 6?9?C?S?
.byte $66,$F6,$CD,$93,$F7,$22,$28,$0C             ; 05E93B DDDDDDDD f????"(?
.byte $B5,$C0,$43,$B9,$7D,$71,$54,$2A             ; 05E943 DDDDDDDD ??C?}qT*
.byte $04,$A6,$CF,$C2,$D1,$27,$BB,$E0             ; 05E94B DDDDDDDD ?????'??
.byte $84,$73,$34,$EF,$16,$36,$BD,$10             ; 05E953 DDDDDDDD ?s4??6??
.byte $6C,$2D,$37,$38,$2C,$EC,$3B,$39             ; 05E95B DDDDDDDD l-78,?;9
.byte $1A,$07,$11,$C2,$4D,$80,$81,$3C             ; 05E963 DDDDDDDD ????M??<
.byte $CA,$B0,$9E,$1C,$CC,$0B,$67,$DB             ; 05E96B DDDDDDDD ??????g?
.byte $27,$0D,$80,$9D,$89,$93,$C8,$04             ; 05E973 DDDDDDDD '???????
.byte $4E,$6B,$2F,$21,$E2,$35,$CF,$71             ; 05E97B DDDDDDDD Nk/!?5?q
.byte $6B,$E3,$30,$DC,$D6,$80,$83,$8D             ; 05E983 DDDDDDDD k?0?????
.byte $D1,$2E,$C9,$6B,$89,$DD,$C0,$DF             ; 05E98B DDDDDDDD ?.?k????
.byte $29,$81,$A9,$FC,$79,$32,$8A,$0C             ; 05E993 DDDDDDDD )???y2??
.byte $07,$36,$43,$9F,$E1,$8C,$D0,$C6             ; 05E99B DDDDDDDD ?6C?????
.byte $FF,$CF,$DD,$65,$E1,$7C,$B2,$63             ; 05E9A3 DDDDDDDD ???e?|?c
.byte $BA,$55,$1E,$95,$40,$C0,$F4,$B9             ; 05E9AB DDDDDDDD ?U??@???
.byte $19,$79,$9B,$BD,$33,$08,$5E,$11             ; 05E9B3 DDDDDDDD ?y??3?^?
.byte $92,$6D,$5C,$23,$9B,$E1,$0A,$ED             ; 05E9BB DDDDDDDD ?m\#????
.byte $5A,$97,$64,$0C,$A7,$33,$C3,$86             ; 05E9C3 DDDDDDDD Z?d??3??
.byte $E1,$3A,$1C,$AC,$24,$AB,$01,$CD             ; 05E9CB DDDDDDDD ?:??$???
.byte $51,$48,$43,$6A,$D1,$D3,$C0,$B7             ; 05E9D3 DDDDDDDD QHCj????
.byte $93,$48,$F5,$89,$CF,$3A,$71,$A8             ; 05E9DB DDDDDDDD ?H???:q?
.byte $38,$8C,$1D,$66,$0E,$88,$2A,$A3             ; 05E9E3 DDDDDDDD 8??f??*?
.byte $D6,$81,$54,$72,$DF,$00,$0E,$91             ; 05E9EB DDDDDDDD ??Tr????
.byte $41,$36,$46,$BC,$AC,$91,$87,$84             ; 05E9F3 DDDDDDDD A6F?????
.byte $E6,$6F,$F6,$39,$B1,$1C,$8F,$C4             ; 05E9FB DDDDDDDD ?o?9????
.byte $80,$30,$BC,$1C,$D8,$02,$14,$EA             ; 05EA03 DDDDDDDD ?0??????
.byte $B0,$36,$A5,$9B,$7B,$9C,$9D,$51             ; 05EA0B DDDDDDDD ?6??{??Q
.byte $60,$3A,$AB,$A4,$1B,$E6,$0E,$B1             ; 05EA13 DDDDDDDD `:??????
.byte $41,$2F,$78,$AE,$B2,$C0,$77,$96             ; 05EA1B DDDDDDDD A/x???w?
.byte $2E,$86,$CA,$A3,$D9,$85,$54,$7C             ; 05EA23 DDDDDDDD .?????T|
.byte $1D,$20,$0D,$8C,$DF,$4A,$C4,$9B             ; 05EA2B DDDDDDDD ? ???J??
.byte $BE,$B9,$5F,$17,$0C,$E9,$07,$B9             ; 05EA33 DDDDDDDD ??_?????
.byte $EC,$A9,$CD,$D2,$47,$A7,$91,$09             ; 05EA3B DDDDDDDD ????G???
.byte $D3,$E1,$97,$89,$01,$00,$75,$92             ; 05EA43 DDDDDDDD ??????u?
.byte $83,$CC,$99,$06,$02,$81,$4F,$10             ; 05EA4B DDDDDDDD ??????O?
.byte $2A,$A3,$E6,$DD,$54,$70,$70,$82             ; 05EA53 DDDDDDDD *???Tpp?
.byte $24,$27,$33,$69,$3D,$88,$1E,$C1             ; 05EA5B DDDDDDDD $'3i=???
.byte $74,$86,$10,$0F,$77,$CD,$A3,$97             ; 05EA63 DDDDDDDD t???w???
.byte $0F,$5E,$1E,$C4,$09,$B5,$D8,$E5             ; 05EA6B DDDDDDDD ?^??????
.byte $EC,$72,$F0,$09,$0F,$6A,$01,$1E             ; 05EA73 DDDDDDDD ?r???j??
.byte $54,$88,$F2,$AD,$ED,$DC,$84,$75             ; 05EA7B DDDDDDDD T??????u
.byte $1C,$C0,$E1,$A0,$04,$F5,$02,$AA             ; 05EA83 DDDDDDDD ????????
.byte $3E,$ED,$15,$47,$E1,$9A,$A8,$FC             ; 05EA8B DDDDDDDD >??G????
.byte $B2,$55,$1F,$A6,$2A,$A3,$F6,$C1             ; 05EA93 DDDDDDDD ?U??*???
.byte $54,$7F,$17,$AA,$8F,$EA,$E5,$51             ; 05EA9B DDDDDDDD T??????Q
.byte $FE,$5A,$AA,$3B,$F5,$8A,$A3,$AD             ; 05EAA3 DDDDDDDD ?Z?;????
.byte $78,$02,$EA,$64,$27,$06,$80,$D8             ; 05EAAB DDDDDDDD x??d'???
.byte $42,$2A,$E0,$09,$29,$1A,$A6,$44             ; 05EAB3 DDDDDDDD B*??)??D
.byte $63,$81,$A6,$99,$A0,$9C,$20,$44             ; 05EABB DDDDDDDD c????? D
.byte $01,$AA,$F0,$1C,$26,$01,$C2,$70             ; 05EAC3 DDDDDDDD ????&??p
.byte $49,$C2,$84,$70,$A3,$11,$B6,$AC             ; 05EACB DDDDDDDD I??p????
.byte $06,$97,$82,$6D,$B6,$10,$9B,$6F             ; 05EAD3 DDDDDDDD ???m???o
.byte $09,$06,$4B,$E4,$8B,$9A,$36,$5A             ; 05EADB DDDDDDDD ??K???6Z
.byte $44,$24,$8E,$98,$D0,$40,$6C,$C7             ; 05EAE3 DDDDDDDD D$???@l?
.byte $F0,$27,$AA,$8F,$0F,$B0,$20,$49             ; 05EAEB DDDDDDDD ?'???? I
.byte $AD,$D0,$04,$3C,$51,$F2,$9B,$1F             ; 05EAF3 DDDDDDDD ???<Q???
.byte $C4,$83,$A3,$FE,$42,$E8,$DB,$9C             ; 05EAFB DDDDDDDD ????B???
.byte $34,$9B,$75,$C2,$D9,$B4,$7C,$5C             ; 05EB03 DDDDDDDD 4?u???|\
.byte $82,$68,$65,$E6,$70,$8E,$50,$68             ; 05EB0B DDDDDDDD ?he?p?Ph
.byte $62,$8C,$27,$17,$C2,$40,$1B,$2C             ; 05EB13 DDDDDDDD b?'??@?,
.byte $46,$A7,$A1,$B6,$70,$71,$9C,$16             ; 05EB1B DDDDDDDD F???pq??
.byte $DA,$3E,$DA,$31,$01,$C2,$A0,$A4             ; 05EB23 DDDDDDDD ?>?1????
.byte $0B,$98,$F9,$A7,$34,$5A,$A7,$B2             ; 05EB2B DDDDDDDD ????4Z??
.byte $3C,$1B,$B6,$79,$49,$C7,$1E,$6B             ; 05EB33 DDDDDDDD <??yI??k
.byte $9B,$EB,$B8,$84,$A1,$C2,$C2,$67             ; 05EB3B DDDDDDDD ???????g
.byte $32,$06,$98,$4B,$A6,$31,$A6,$1F             ; 05EB43 DDDDDDDD 2??K?1??
.byte $97,$6E,$9C,$36,$2E,$AC,$F2,$22             ; 05EB4B DDDDDDDD ?n?6.??"
.byte $69,$A4,$47,$06,$78,$36,$96,$AD             ; 05EB53 DDDDDDDD i?G?x6??
.byte $9D,$60,$59,$69,$F3,$A1,$E8,$4E             ; 05EB5B DDDDDDDD ?`Yi???N
.byte $77,$9C,$1A,$AE,$C1,$08,$B9,$D7             ; 05EB63 DDDDDDDD w???????
.byte $7A,$F1,$E4,$A7,$25,$66,$74,$01             ; 05EB6B DDDDDDDD z???%ft?
.byte $C8,$7E,$0F,$16,$FB,$C7,$FE,$08             ; 05EB73 DDDDDDDD ?~??????
.byte $30,$06,$87,$91,$67,$7E,$DC,$A6             ; 05EB7B DDDDDDDD 0???g~??
.byte $B0,$71,$A6,$71,$A4,$9C,$A8,$64             ; 05EB83 DDDDDDDD ?q?q???d
.byte $1C,$69,$EA,$C2,$E9,$A8,$C6,$43             ; 05EB8B DDDDDDDD ?i?????C
.byte $89,$C6,$F8,$5A,$73,$6D,$AA,$73             ; 05EB93 DDDDDDDD ???Zsm?s
.byte $29,$AA,$A8,$27,$1C,$B1,$00,$67             ; 05EB9B DDDDDDDD )??'???g
.byte $A9,$19,$EA,$86,$D9,$91,$CB,$30             ; 05EBA3 DDDDDDDD ???????0
.byte $48,$99,$F6,$45,$A7,$3C,$08,$1A             ; 05EBAB DDDDDDDD H??E?<??
.byte $E1,$93,$94,$1C,$07,$23,$14,$0E             ; 05EBB3 DDDDDDDD ?????#??
.byte $B9,$CF,$08,$91,$0A,$9C,$93,$84             ; 05EBBB DDDDDDDD ????????
.byte $AE,$7C,$D9,$26,$7C,$BC,$72,$5E             ; 05EBC3 DDDDDDDD ?|?&|?r^
.byte $1C,$98,$58,$37,$C2,$E8,$5E,$83             ; 05EBCB DDDDDDDD ??X7??^?
.byte $C7,$CA,$82,$32,$9C,$A7,$85,$9D             ; 05EBD3 DDDDDDDD ???2????
.byte $EB,$39,$10,$93,$CA,$9B,$CA,$98             ; 05EBDB DDDDDDDD ?9??????
.byte $40,$72,$A8,$29,$06,$5D,$69,$83             ; 05EBE3 DDDDDDDD @r?)?]i?
.byte $79,$C9,$A7,$1C,$AF,$41,$CE,$E0             ; 05EBEB DDDDDDDD y????A??
.byte $1C,$D1,$84,$BA,$65,$36,$9A,$61             ; 05EBF3 DDDDDDDD ????e6?a
.byte $A8,$22,$E4,$AC,$1C,$23,$87,$38             ; 05EBFB DDDDDDDD ?"???#?8
.byte $E1,$1B,$2E,$2C,$0E,$AA,$92,$10             ; 05EC03 DDDDDDDD ??.,????
.byte $26,$97,$C1,$01,$B6,$74,$ED,$D6             ; 05EC0B DDDDDDDD &????t??
.byte $90,$B8,$B5,$89,$C7,$B0,$1A,$F3             ; 05EC13 DDDDDDDD ????????
.byte $CA,$65,$4F,$21,$CC,$70,$4E,$45             ; 05EC1B DDDDDDDD ?eO!?pNE
.byte $AC,$22,$72,$4A,$12,$3C,$F7,$77             ; 05EC23 DDDDDDDD ?"rJ?<?w
.byte $3B,$ED,$92,$27,$06,$AB,$E1,$A4             ; 05EC2B DDDDDDDD ;??'????
.byte $23,$C9,$6F,$39,$B6,$BA,$35,$57             ; 05EC33 DDDDDDDD #?o9??5W
.byte $3F,$F8,$B7,$17,$92,$1C,$41,$6A             ; 05EC3B DDDDDDDD ??????Aj
.byte $A3,$D0,$1A,$8F,$15,$81,$D2,$44             ; 05EC43 DDDDDDDD ???????D
.byte $85,$82,$5C,$27,$49,$69,$CB,$BE             ; 05EC4B DDDDDDDD ??\'Ii??
.byte $8D,$C1,$9E,$8F,$0D,$F8,$A9,$60             ; 05EC53 DDDDDDDD ???????`
.byte $DF,$23,$A8,$10,$9D,$35,$09,$73             ; 05EC5B DDDDDDDD ?#???5?s
.byte $59,$23,$74,$D8,$23,$64,$5D,$23             ; 05EC63 DDDDDDDD Y#t?#d]#
.byte $74,$E0,$A3,$65,$80,$48,$60,$9D             ; 05EC6B DDDDDDDD t??e?H`?
.byte $04,$B8,$E5,$92,$8B,$D3,$DF,$72             ; 05EC73 DDDDDDDD ???????r
.byte $60,$A3,$C9,$81,$D1,$26,$AA,$3D             ; 05EC7B DDDDDDDD `????&?=
.byte $14,$2A,$A3,$D5,$E0,$AA,$3D,$7B             ; 05EC83 DDDDDDDD ?*????={
.byte $80,$11,$8C,$89,$21,$CC,$7B,$64             ; 05EC8B DDDDDDDD ????!?{d
.byte $AD,$D8,$64,$B7,$42,$FC,$06,$0F             ; 05EC93 DDDDDDDD ??d?B???
.byte $E3,$06,$DB,$0D,$A7,$2B,$D4,$E4             ; 05EC9B DDDDDDDD ?????+??
.byte $4F,$35,$09,$D4,$E4,$2E,$1D,$C2             ; 05ECA3 DDDDDDDD O5???.??
.byte $A8,$F5,$C0,$AA,$8F,$66,$7A,$A8             ; 05ECAB DDDDDDDD ?????fz?
.byte $F6,$CD,$20,$30,$3C,$95,$B7,$26             ; 05ECB3 DDDDDDDD ?? 0<??&
.byte $94,$27,$26,$86,$4C,$DA,$02,$F6             ; 05ECBB DDDDDDDD ?'&?L???
.byte $C0,$AA,$8F,$74,$12,$A8,$F7,$80             ; 05ECC3 DDDDDDDD ???t????
.byte $AA,$8F,$7C,$02,$A8,$F7,$FF,$AA             ; 05ECCB DDDDDDDD ??|?????
.byte $8F,$83,$F2,$A8,$F8,$7E,$AA,$8F             ; 05ECD3 DDDDDDDD ?????~??
.byte $8B,$E2,$A8,$F8,$FD,$AA,$8F,$93             ; 05ECDB DDDDDDDD ????????
.byte $D2,$A8,$F9,$7C,$AA,$8F,$9B,$C2             ; 05ECE3 DDDDDDDD ???|????
.byte $A8,$F9,$FB,$AA,$8F,$A3,$B2,$A8             ; 05ECEB DDDDDDDD ????????
.byte $FA,$7A,$AA,$8F,$AB,$A2,$A8,$FA             ; 05ECF3 DDDDDDDD ?z??????
.byte $F9,$AA,$8F,$B3,$92,$A8,$FB,$78             ; 05ECFB DDDDDDDD ???????x
.byte $AA,$8F,$BB,$82,$A8,$FB,$F7,$AA             ; 05ED03 DDDDDDDD ????????
.byte $8F,$C3,$72,$A8,$FC,$76,$AA,$8F             ; 05ED0B DDDDDDDD ??r??v??
.byte $CB,$62,$A8,$FC,$F5,$AA,$8F,$D3             ; 05ED13 DDDDDDDD ?b??????
.byte $52,$A8,$FD,$74,$AA,$8F,$DB,$42             ; 05ED1B DDDDDDDD R??t???B
.byte $A8,$FD,$F3,$AA,$8F,$E3,$32,$A8             ; 05ED23 DDDDDDDD ??????2?
.byte $FE,$72,$AA,$8F,$EB,$22,$A8,$FE             ; 05ED2B DDDDDDDD ?r???"??
.byte $F1,$AA,$8F,$F3,$12,$A8,$FF,$70             ; 05ED33 DDDDDDDD ???????p
.byte $AA,$8F,$FD,$F2,$AC,$0F,$00,$10             ; 05ED3B DDDDD... ????????
.byte $00,$11,$00,$12,$00,$13,$00,$14             ; 05ED43 ........ ????????
.byte $00,$12,$00,$15,$00,$11,$00,$12             ; 05ED4B ........ ????????
.byte $00,$16,$00,$16,$00,$17,$00,$18             ; 05ED53 ........ ????????
.byte $00,$19,$00,$1A,$00,$18,$00,$1B             ; 05ED5B ........ ????????
.byte $00,$17,$00,$18,$00,$00,$00,$1C             ; 05ED63 ........ ????????
.byte $00,$1D,$00,$1E,$00,$1F,$00,$20             ; 05ED6B ........ ??????? 
.byte $00,$1F,$00,$21,$00,$22,$00,$00             ; 05ED73 ........ ???!?"??
.byte $00,$00,$00,$23,$00,$24,$00,$25             ; 05ED7B ........ ???#?$?%
.byte $00,$25,$00,$26,$00,$25,$00,$27             ; 05ED83 ........ ?%?&?%?'
.byte $00,$28,$00,$00,$00,$00,$00,$00             ; 05ED8B ........ ?(??????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05ED93 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05ED9B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EDA3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EDAB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EDB3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EDBB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EDC3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EDCB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EDD3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EDDB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EDE3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EDEB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EDF3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EDFB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$29             ; 05EE03 ........ ???????)
.byte $00,$10,$00,$29,$40,$11,$00,$00             ; 05EE0B ........ ???)@???
.byte $00,$29,$40,$11,$00,$2A,$00,$00             ; 05EE13 ........ ?)@??*??
.byte $00,$00,$00,$2B,$00,$16,$00,$2C             ; 05EE1B ........ ???+???,
.byte $00,$17,$00,$00,$00,$2C,$00,$17             ; 05EE23 ........ ?????,??
.byte $00,$2D,$00,$00,$00,$00,$00,$00             ; 05EE2B ........ ?-??????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EE33 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EE3B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EE43 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EE4B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EE53 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EE5B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EE63 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$2E             ; 05EE6B ........ ???????.
.byte $00,$15,$00,$2F,$00,$13,$00,$00             ; 05EE73 ........ ???/????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EE7B ........ ????????
.byte $00,$00,$00,$30,$00,$1B,$00,$31             ; 05EE83 ........ ???0???1
.byte $00,$19,$00,$00,$00,$00,$00,$00             ; 05EE8B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EE93 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EE9B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EEA3 ........ ????????
.byte $00,$00,$00,$10,$00,$32,$00,$13             ; 05EEAB ........ ?????2??
.byte $00,$33,$00,$00,$00,$00,$00,$00             ; 05EEB3 ........ ?3??????
.byte $00,$00,$00,$00,$00,$00,$00,$16             ; 05EEBB ........ ????????
.byte $00,$34,$00,$19,$00,$1B,$00,$00             ; 05EEC3 ........ ?4??????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EECB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EED3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EEDB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EEE3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EEEB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EEF3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EEFB ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EF03 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EF0B ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05EF13 ........ ????????
.byte $00,$00,$00,$00,$00                         ; 05EF1C .....    ?????
D_5EF20:
.byte $01,$0C                                     ; 05EF21 DD       ??
D_5EF22:
.byte $02,$0C                                     ; 05EF23 DD       ??
D_5EF24:
.byte $03,$0C                                     ; 05EF25 DD       ??
D_5EF26:
.byte $04,$0C,$01,$0C,$05,$0C,$03,$0C             ; 05EF26 DDDDDDDD ????????
.byte $06,$0C,$01,$0C,$07,$0C,$03,$0C             ; 05EF2E DDDDDDDD ????????
.byte $08,$0C,$09,$0C,$0A,$0C,$03,$0C             ; 05EF36 DD...... ????????
.byte $0B,$0C                                     ; 05EF3F ..       ??
D_5EF40:
.byte $0C,$0C,$0D,$0C,$0E,$0C,$00,$00             ; 05EF40 DD...... ????????
.byte $00,$08,$99,$00,$00,$10,$00,$10             ; 05EF48 DDDDDDDD ????????
.byte $01,$00,$02,$00,$02,$00,$03,$00             ; 05EF50 DDDDDDDD ????????
.byte $04,$00,$05,$06,$00,$07,$00,$08             ; 05EF58 DDDDDDDD ????????
.byte $00,$09,$0A,$00,$0B,$00,$0C,$00             ; 05EF60 DDDDDDDD ????????
.byte $0D,$00,$0E,$0F,$11,$12,$00,$13             ; 05EF68 DDDDDDDD ????????
.byte $00,$14,$15,$00,$16,$00,$17,$18             ; 05EF70 DDDDDDDD ????????
.byte $00,$19,$00,$1A,$1B,$1C,$1D,$1E             ; 05EF78 DDDDDDDD ????????
.byte $00,$1F,$00,$20,$00,$21,$00,$22             ; 05EF80 DDDDDDDD ??? ?!?"
.byte $0E,$40,$23,$00,$24,$25,$00,$26             ; 05EF88 DDDDDDDD ?@#?$%?&
.byte $27,$00,$28,$00,$29,$00,$2A,$00             ; 05EF90 DDDDDDDD '?(?)?*?
.byte $2B,$2C,$00,$2D,$00,$10,$2E,$00             ; 05EF98 DDDDDDDD +,?-??.?
.byte $2F,$00,$30,$00,$31,$00,$0F,$40             ; 05EFA0 DDDDDDDD /?0?1??@
.byte $32,$00,$33,$34,$00,$21,$80,$35             ; 05EFA8 DDDDDDDD 2?34?!?5
.byte $00,$36,$00,$37,$38,$80,$24,$80             ; 05EFB0 DDDDDDDD ?6?78?$?
.byte $39,$00,$3A,$00,$3B,$80,$80,$13             ; 05EFB8 DDDDDDDD 9?:?;???
.byte $80,$14,$15,$80,$16,$80,$17,$18             ; 05EFC0 DDDDDDDD ????????
.byte $80,$19,$80,$1A,$10,$00,$3C,$00             ; 05EFC8 DDDDDDDD ??????<?
.byte $3D,$03,$80,$04,$80,$05,$80,$07             ; 05EFD0 DDDDDDDD =???????
.byte $80,$08,$80,$09,$0A,$80,$0B,$00             ; 05EFD8 DDDDDDDD ????????
.byte $00,$00,$00,$06,$0C,$13,$02,$98             ; 05EFE0 DDDDDDDD ????????
.byte $0A,$98,$05,$53,$00,$55,$1D,$FD             ; 05EFE8 DDDDDDDD ???S?U??
.byte $54,$77,$F2,$A8,$F7,$D5,$51,$E6             ; 05EFF0 DDDDDDDD Tw????Q?
.byte $A0,$08,$5E,$8F,$65,$E9,$96,$07             ; 05EFF8 DDDDDDDD ??^?e???
.byte $A9,$F9,$E0,$42,$EC,$8E,$A6,$2E             ; 05F000 DDDDDDDD ???B???.
.byte $D1,$87,$B5,$61,$ED,$98,$7A,$B5             ; 05F008 DDDDDDDD ???a??z?
.byte $46,$EF,$3B,$C3,$6F,$11,$81,$F1             ; 05F010 DDDDDDDD F?;?o???
.byte $58,$F0,$82,$7B,$B5,$17,$B3,$09             ; 05F018 DDDDDDDD X??{????
.byte $F3,$38,$1F,$35,$7C,$89,$3D,$98             ; 05F020 DDDDDDDD ?8?5|?=?
.byte $F2,$E4,$4F,$0C,$27,$D4,$59,$0F             ; 05F028 DDDDDDDD ??O?'?Y?
.byte $62,$04,$3B,$30,$27,$F2,$E0,$7F             ; 05F030 DDDDDDDD b?;0'???
.byte $46,$F2,$10,$27,$EB,$90,$37,$14             ; 05F038 DDDDDDDD F??'??7?
.byte $43,$AD,$12,$D6,$B4,$1C,$15,$87             ; 05F040 DDDDDDDD C???????
.byte $83,$30,$EF,$B5,$06,$1E,$1A,$EE             ; 05F048 DDDDDDDD ?0??????
.byte $40,$87,$83,$BA,$9C,$93,$8B,$2C             ; 05F050 DDDDDDDD @??????,
.byte $F0,$B5,$07,$41,$CA,$A3,$C8,$75             ; 05F058 DDDDDDDD ???A???u
.byte $51,$E8,$32,$A8,$F7,$25,$44,$8F             ; 05F060 DDDDDDDD Q?2??%D?
.byte $20,$79,$00,$3C,$80,$27,$90,$05             ; 05F068 DDDDDDDD  y?<?'??
.byte $3C,$80,$2A,$79,$00,$55,$3D,$02             ; 05F070 DDDDDDDD <?*y?U=?
.byte $AA,$3F,$00,$55,$18,$80,$C0,$07             ; 05F078 DDDDDDDD ???U????
.byte $6F,$01,$00,$00,$00,$01,$01,$02             ; 05F080 DDDDDDDD o???????
.byte $00,$03,$02,$07,$00,$07,$04,$0F             ; 05F088 DDDDDDDD ????????
.byte $00,$0F,$08,$1F,$03,$01,$00,$03             ; 05F090 DDDDDDDD ????????
.byte $04,$03,$00,$07,$08,$07,$00,$0F             ; 05F098 DDDDDDDD ????????
.byte $10,$FF,$00,$FF,$00,$C0,$00,$C0             ; 05F0A0 DDDDDDDD ????????
.byte $C1,$01,$C0,$01,$01,$00,$0B,$00             ; 05F0A8 DDDDDDDD ????????
.byte $2F,$00,$7F,$40,$FF,$00,$7F,$00             ; 05F0B0 DDDDDDDD /??@????
.byte $01,$03,$0C,$0F,$30,$3F,$00,$7F             ; 05F0B8 DDDDDDDD ????0???
.byte $80,$7F,$80,$A0,$00,$F4,$00,$FD             ; 05F0C0 DDDDDDDD ????????
.byte $80,$60,$F0,$0C,$FC,$03,$80,$80             ; 05F0C8 DDDDDDDD ?`??????
.byte $C0,$00,$80,$00,$E0,$80,$40,$80             ; 05F0D0 DDDDDDDD ??????@?
.byte $40,$C0,$20,$C0,$20,$00,$00,$02             ; 05F0D8 DDDDDDDD @? ? ???
.byte $1F,$10,$3F,$00,$1F,$3F,$00,$1F             ; 05F0E0 DDDDDDDD ????????
.byte $20,$1F,$20,$3F,$40,$3F,$40,$5F             ; 05F0E8 DDDDDDDD  ? ?@?@_
.byte $1F,$60,$E8,$FF,$00,$E0,$18,$40             ; 05F0F0 DDDDDDDD ?`?????@
.byte $00,$E0,$20,$F0,$F8,$00,$F0,$C0             ; 05F0F8 DDDDDDDD ?? ?????
.byte $C0,$00,$E0,$10,$E0,$10,$F0,$08             ; 05F100 DDDDDDDD ????????
.byte $F0,$08,$3F,$FE,$00,$FE,$1F,$3F             ; 05F108 DDDDDDDD ????????
.byte $20,$7F,$FF,$00,$C1,$00,$C3,$C1             ; 05F110 DDDDDDDD  ???????
.byte $02,$C1,$02,$FC,$08,$F0,$10,$F0             ; 05F118 DDDDDDDD ????????
.byte $F0,$04,$E0,$0F,$04,$03,$02,$03             ; 05F120 DDDDDDDD ????????
.byte $03,$08,$01,$00,$01,$02,$E0,$F0             ; 05F128 DDDDDDDD ????????
.byte $02,$FC,$04,$FC,$01,$F8,$00,$F8             ; 05F130 DDDDDDDD ????????
.byte $04,$02,$F8,$00,$FC,$FC,$F8,$04             ; 05F138 DDDDDDDD ????????
.byte $F8,$01,$01,$03,$01,$02,$08,$FF             ; 05F140 DDDDDDDD ????????
.byte $00,$F7,$10,$F7,$00,$E7,$20,$E7             ; 05F148 DDDDDDDD ?????? ?
.byte $00,$C7,$F7,$00,$F7,$08,$E7,$00             ; 05F150 DDDDDDDD ????????
.byte $E7,$10,$C7,$00,$C7,$20,$87,$C3             ; 05F158 DDDDDDDD ????? ??
.byte $01,$10,$F4,$00,$FB,$00,$F0,$0C             ; 05F160 DDDDDDDD ????????
.byte $F8,$07,$FE,$01,$B0,$80,$00,$C0             ; 05F168 DDDDDDDD ????????
.byte $80,$70,$00,$FE,$02,$FE,$00,$FC             ; 05F170 DDDDDDDD ?p??????
.byte $01,$02,$F8,$00,$C7,$00,$87,$80             ; 05F178 DDDDDDDD ????????
.byte $87,$00,$87,$40,$80,$00,$FF,$C0             ; 05F180 DDDDDDDD ???@????
.byte $7F,$70,$1F,$18,$0D,$0C,$07,$07             ; 05F188 DDDDDDDD ?p??????
.byte $BF,$00,$6F,$00,$17,$00,$09,$02             ; 05F190 DDDDDDDD ??o?????
.byte $06,$E0,$3F,$30,$DF,$E8,$E8,$00             ; 05F198 DDDDDDDD ???0????
.byte $F6,$0E,$08,$E0,$20,$40,$F8,$04             ; 05F1A0 DDDDDDDD ???? @??
.byte $08,$20,$80,$1F,$1C,$07,$06,$03             ; 05F1A8 DDDDDDDD ? ??????
.byte $03,$1B,$00,$05,$C0,$6F,$60,$3F             ; 05F1B0 DDDDDDDD ?????o`?
.byte $38,$BF,$00,$4F,$10,$37,$FD,$03             ; 05F1B8 DDDDDDDD 8??O?7??
.byte $80,$00,$60,$00,$D0,$E0,$C0,$30             ; 05F1C0 DDDDDDDD ??`????0
.byte $80,$07,$FF,$80,$DF,$1B,$18,$0F             ; 05F1C8 DDDDDDDD ????????
.byte $0E,$03,$01,$9F,$20,$6F,$00,$13             ; 05F1D0 DDDDDDDD ???? o??
.byte $04,$0D,$00,$03,$C0,$C0,$20,$C0             ; 05F1D8 DDDDDDDD ?????? ?
.byte $80,$60,$80,$FF,$01,$02,$FA,$FE             ; 05F1E0 DDDDDDDD ?`??????
.byte $01,$03,$06,$F8,$80,$80,$80,$39             ; 05F1E8 DDDDDDDD ???????9
.byte $80,$C0,$4E,$09,$2B,$B8,$40,$3C             ; 05F1F0 DDDDDDDD ??N?+?@<
.byte $03,$80,$9C,$05,$27,$BE,$78,$5B             ; 05F1F8 DDDDDDDD ????'?x[
.byte $BE,$2F,$DA,$53,$5B,$64,$38,$C3             ; 05F200 DDDDDDDD ?/?S[d8?
.byte $8A,$0D,$58,$0E,$68,$3A,$60,$21             ; 05F208 DDDDDDDD ??X?h:`!
.byte $ED,$41,$93,$C6,$03,$1A,$09,$77             ; 05F210 DDDDDDDD ?A?????w
.byte $9C,$61,$21,$74,$0C,$3A,$7E,$C5             ; 05F218 DDDDDDDD ?a!t?:~?
.byte $EE,$92,$84,$D4,$28,$C7,$22,$42             ; 05F220 DDDDDDDD ????(?"B
.byte $D8,$62,$C1,$B5,$04,$DB,$C1,$0E             ; 05F228 DDDDDDDD ?b??????
.byte $EB,$9D,$E4,$12,$1C,$37,$C0,$1E             ; 05F230 DDDDDDDD ?????7??
.byte $01,$3C,$02,$93,$E7,$CF,$3E,$9E             ; 05F238 DDDDDDDD ?<????>?
.byte $7D,$4E,$13,$7B,$F3,$DF,$A7,$BF             ; 05F240 DDDDDDDD }N?{????
.byte $53,$08,$A9,$84,$15,$D0,$62,$72             ; 05F248 DDDDDDDD S?????br
.byte $15,$B2,$C7,$45,$9B,$47,$32,$5C             ; 05F250 DDDDDDDD ???E?G2\
.byte $D5,$D9,$E1,$F3,$88,$78,$98,$E2             ; 05F258 DDDDDDDD ?????x??
.byte $22,$0E,$26,$03,$55,$80,$87,$8F             ; 05F260 DDDDDDDD "?&?U???
.byte $C1,$9D,$77,$CD,$65,$39,$81,$4E             ; 05F268 DDDDDDDD ??w?e9?N
.byte $70,$02,$1E,$7F,$06,$5D,$6D,$EA             ; 05F270 DDDDDDDD p????]m?
.byte $02,$EA,$53,$A8,$5D,$78,$7A,$9D             ; 05F278 DDDDDDDD ??S?]xz?
.byte $78,$70,$CA,$01,$38,$1B,$26,$47             ; 05F280 DDDDDDDD xp??8?&G
.byte $13,$95,$83,$8F,$C4,$87,$A4,$01             ; 05F288 DDDDDDDD ????????
.byte $DE,$E7,$9C,$01,$BC,$31,$0E,$0A             ; 05F290 DDDDDDDD ?????1??
.byte $0C,$A4,$17,$B4,$67,$5A,$EF,$41             ; 05F298 DDDDDDDD ????gZ?A
.byte $F4,$63,$D0,$89,$EE,$DF,$48,$49             ; 05F2A0 DDDDDDDD ?c????HI
.byte $C2,$34,$63,$0D,$11,$90,$E0,$99             ; 05F2A8 DDDDDDDD ?4c?????
.byte $1E,$2B,$1B,$8D,$78,$C2,$E2,$40             ; 05F2B0 DDDDDDDD ?+??x??@
.byte $E3,$2F,$B3,$31,$E5,$EA,$46,$0D             ; 05F2B8 DDDDDDDD ?/?1??F?
.byte $BD,$D4,$C7,$AC,$49,$79,$D8,$0C             ; 05F2C0 DDDDDDDD ????Iy??
.byte $F4,$75,$8E,$DF,$31,$21,$D4,$E6             ; 05F2C8 DDDDDDDD ?u??1!??
.byte $7B,$73,$DC,$07,$00,$14,$D3,$92             ; 05F2D0 DDDDDDDD {s??????
.byte $1C,$1E,$52,$D5,$BA,$F0,$E1,$4E             ; 05F2D8 DDDDDDDD ??R????N
.byte $24,$26,$CF,$38,$BE,$71,$5D,$4E             ; 05F2E0 DDDDDDDD $&?8?q]N
.byte $33,$AE,$D6,$13,$8F,$0A,$70,$A1             ; 05F2E8 DDDDDDDD 3?????p?
.byte $1D,$ED,$C3,$AF,$F1,$CD,$E5,$C9             ; 05F2F0 DDDDDDDD ????????
.byte $48,$1D,$B3,$73,$14,$E6,$4C,$73             ; 05F2F8 DDDDDDDD H??s??Ls
.byte $32,$E6,$30,$18,$6E,$47,$9B,$EA             ; 05F300 DDDDDDDD 2?0?nG??
.byte $42,$E1,$FF,$93,$B0,$3C,$15,$1D             ; 05F308 DDDDDDDD B????<??
.byte $91,$0B,$3B,$32,$12,$C4,$1D,$8C             ; 05F310 DDDDDDDD ??;2????
.byte $1D,$E4,$26,$53,$03,$7A,$C0,$63             ; 05F318 DDDDDDDD ??&S?z?c
.byte $70,$1D,$F5,$B3,$BF,$31,$7A,$A1             ; 05F320 DDDDDDDD p????1z?
.byte $6D,$3A,$CB,$66,$AD,$63,$1D,$93             ; 05F328 DDDDDDDD m:?f?c??
.byte $C5,$4B,$7A,$07,$3F,$23,$98,$A0             ; 05F330 DDDDDDDD ?Kz??#??
.byte $F6,$80,$0E,$D4,$09,$27,$42,$83             ; 05F338 DDDDDDDD ?????'B?
.byte $B9,$04,$EC,$6B,$82,$C8,$6B,$12             ; 05F340 DDDDDDDD ???k??k?
.byte $1E,$83,$18,$AC,$08,$7A,$2A,$DD             ; 05F348 DDDDDDDD ?????z*?
.byte $45,$07,$5E,$CD,$D5,$60,$3A,$B8             ; 05F350 DDDDDDDD E?^??`:?
.byte $10,$F5,$AD,$F0,$01,$E1,$F6,$7A             ; 05F358 DDDDDDDD ???????z
.byte $F8,$F8,$47,$9F,$DE,$03,$16,$D0             ; 05F360 DDDDDDDD ??G?????
.byte $49,$E4,$50,$6F,$20,$A3,$E6,$05             ; 05F368 DDDDDDDD I?Po ???
.byte $39,$F0,$9A,$38,$4F,$40,$29,$DD             ; 05F370 DDDDDDDD 9??8O@)?
.byte $84,$EC,$B7,$A9,$CF,$4F,$A9,$B5             ; 05F378 DDDDDDDD ?????O??
.byte $FC,$F0,$28,$4F,$40,$61,$DB,$9D             ; 05F380 DDDDDDDD ??(O@a??
.byte $DE,$38,$1E,$09,$B9,$64,$2D,$E0             ; 05F388 DDDDDDDD ?8???d-?
.byte $BC,$52,$1C,$BA,$C6,$F4,$9F,$85             ; 05F390 DDDDDDDD ?R??????
.byte $B8,$B4,$42,$F2,$88,$B3,$F1,$F1             ; 05F398 DDDDDDDD ??B?????
.byte $76,$38,$A7,$D3,$14,$ED,$E1,$F6             ; 05F3A0 DDDDDDDD v8??????
.byte $05,$39,$64,$11,$E2,$C8,$E5,$68             ; 05F3A8 DDDDDDDD ?9d????h
.byte $C7,$2B,$2E,$C0,$47,$BF,$E7,$DA             ; 05F3B0 DDDDDDDD ?+.?G???
.byte $82,$63,$B8,$FD,$20,$30,$00,$00             ; 05F3B8 DDDDDDDD ?c?? 0??
.byte $5F,$02,$1F,$00,$52,$4A,$95,$00             ; 05F3C0 DDDDDDDD _???RJ??
.byte $FF,$7F,$10,$42,$29,$25,$B5,$56             ; 05F3C8 DDDDDDDD ???B)%?V
.byte $CE,$39,$00,$00,$00,$00,$00,$00             ; 05F3D0 DDDDDDDD ?9??????
.byte $00,$00,$00,$04,$00,$04,$00,$04             ; 05F3D8 DDDDDDDD ????????
.byte $00,$04,$00,$04,$00,$04,$00,$04             ; 05F3E0 DDDDDDDD ????????
.byte $00,$04,$00,$08,$00,$08,$00,$08             ; 05F3E8 DDDDDDDD ????????
.byte $00,$08,$00,$08,$00,$08,$00,$08             ; 05F3F0 DDDDDDDD ????????
.byte $00,$08,$00,$0C,$00,$0C,$00,$0C             ; 05F3F8 DDDDDDDD ????????
.byte $00,$0C,$00,$0C,$00,$0C,$00,$0C             ; 05F400 DDDDDDDD ????????
.byte $00,$0C,$00,$10,$00,$10,$00,$10             ; 05F408 DDDDDDDD ????????
.byte $00,$10,$00,$10,$00,$10,$00,$10             ; 05F410 DDDDDDDD ????????
.byte $00,$10,$00,$14,$00,$14,$00,$14             ; 05F418 DDDDDDDD ????????
.byte $00,$14,$00,$14,$00,$14,$00,$14             ; 05F420 DDDDDDDD ????????
.byte $00,$18,$00,$18,$00,$18,$00,$18             ; 05F428 DDDDDDDD ????????
.byte $00,$18,$00,$18,$00,$18,$00,$18             ; 05F430 DDDDDDDD ????????
.byte $00,$1C,$00,$1C,$00,$1C,$00,$1C             ; 05F438 DDDDDDDD ????????
.byte $00,$1C,$00,$1C,$00,$1C,$00,$1C             ; 05F440 DDDDDDDD ????????
.byte $00,$20,$00,$20,$00,$20,$00,$20             ; 05F448 DDDDDDDD ? ? ? ? 
.byte $00,$20,$00,$20,$00,$20,$00,$20             ; 05F450 DDDDDDDD ? ? ? ? 
.byte $00,$24,$00,$24,$00,$24,$00,$24             ; 05F458 DDDDDDDD ?$?$?$?$
.byte $00,$24,$00,$24,$00,$24,$00,$24             ; 05F460 DDDDDDDD ?$?$?$?$
.byte $00,$28,$00,$28,$00,$28,$01,$28             ; 05F468 DDDDDDDD ?(?(?(?(
.byte $01,$28,$01,$28,$01,$28,$01,$28             ; 05F470 DDDDDDDD ?(?(?(?(
.byte $01,$2C,$01,$2C,$01,$2C,$01,$2C             ; 05F478 DDDDDDDD ?,?,?,?,
.byte $01,$2C,$01,$2C,$01,$2C,$01,$2C             ; 05F480 DDDDDDDD ?,?,?,?,
.byte $01,$30,$01,$30,$01,$30,$01,$30             ; 05F488 DDDDDDDD ?0?0?0?0
.byte $01,$30,$01,$30,$01,$30,$01,$30             ; 05F490 DDDDDDDD ?0?0?0?0
.byte $01,$34,$01,$34,$01,$34,$02,$34             ; 05F498 DDDDDDDD ?4?4?4?4
.byte $02,$34,$02,$34,$02,$34,$02,$34             ; 05F4A0 DDDDDDDD ?4?4?4?4
.byte $02,$38,$02,$38,$02,$38,$02,$38             ; 05F4A8 DDDDDDDD ?8?8?8?8
.byte $02,$38,$02,$38,$02,$38,$02,$38             ; 05F4B0 DDDDDDDD ?8?8?8?8
.byte $02,$3C,$02,$3C,$02,$3C,$80,$01             ; 05F4B8 DDDDDDDD ?<?<?<??
.byte $8F,$00,$01,$00,$01,$00,$01,$00             ; 05F4C0 DDDDDDDD ????????
.byte $02,$00,$03,$00,$04,$05,$00,$06             ; 05F4C8 DDDDDDDD ????????
.byte $00,$07,$00,$08,$09,$0A,$0B,$00             ; 05F4D0 DDDDDDDD ????????
.byte $0C,$00,$0D,$00,$0E,$00,$0F,$00             ; 05F4D8 DDDDDDDD ????????
.byte $10,$11,$00,$12,$00,$13,$00,$14             ; 05F4E0 DDDDDDDD ????????
.byte $00,$15,$00,$16,$00,$17,$00,$18             ; 05F4E8 DDDDDDDD ????????
.byte $00,$19,$00,$1A,$1B,$00,$1C,$00             ; 05F4F0 DDDDDDDD ????????
.byte $1D,$00,$1E,$00,$1F,$00,$20,$00             ; 05F4F8 DDDDDDDD ?????? ?
.byte $21,$22,$00,$23,$00,$24,$00,$25             ; 05F500 DDDDDDDD !"?#?$?%
.byte $26,$00,$27,$00,$28,$29,$2A,$00             ; 05F508 DDDDDDDD &?'?()*?
.byte $2B,$00,$2C,$00,$2D,$00,$2E,$2F             ; 05F510 DDDDDDDD +?,?-?./
.byte $00,$30,$00,$31,$00,$32,$00,$33             ; 05F518 DDDDDDDD ?0?1?2?3
.byte $00,$34,$00,$35,$32,$36,$00,$37             ; 05F520 DDDDDDDD ?4?526?7
.byte $00,$38,$00,$38,$39,$00,$3A,$00             ; 05F528 DDDDDDDD ?8?89?:?
.byte $3B,$00,$3C,$00,$3D,$00,$3E,$00             ; 05F530 DDDDDDDD ;?<?=?>?
.byte $3F,$00,$40,$00,$41,$00,$42,$00             ; 05F538 DDDDDDDD ??@?A?B?
.byte $43,$00,$44,$00,$45,$00,$46,$00             ; 05F540 DDDDDDDD C?D?E?F?
.byte $47,$00,$48,$49,$4A,$00,$4B,$06             ; 05F548 DDDDDDDD G?HIJ?K?
.byte $0C,$12,$5D,$F2,$E5,$8D,$92,$B6             ; 05F550 DDDDDDDD ??]?????
.byte $0A,$B8,$64,$21,$79,$B0,$2E,$D5             ; 05F558 DDDDDDDD ??d!y?.?
.byte $16,$47,$8B,$97,$9F,$87,$AB,$B7             ; 05F560 DDDDDDDD ?G??????
.byte $54,$18,$1F,$26,$47,$DF,$BD,$7F             ; 05F568 DDDDDDDD T??&G???
.byte $A8,$FB,$8E,$D8,$42,$5E,$1E,$70             ; 05F570 DDDDDDDD ????B^?p
.byte $F4,$E1,$EA,$72,$97,$7A,$0A,$4A             ; 05F578 DDDDDDDD ???r?z?J
.byte $BD,$26,$EC,$F3,$D0,$41,$80,$40             ; 05F580 DDDDDDDD ?&???A?@
.byte $01,$06,$00,$4C,$00,$4C,$00,$06             ; 05F588 DDDDDDDD ???L?L??
.byte $0C,$13,$02,$98,$0A,$98,$05,$53             ; 05F590 DDDDDDDD ???????S
.byte $00,$55,$1E,$F5,$55,$80,$40,$01             ; 05F598 DDDDDDDD ?U??U?@?
.byte $3C,$00,$4C,$00,$4C,$00,$4C,$00             ; 05F5A0 DDDDDDDD <?L?L?L?
.byte $4D,$00,$4E,$4D,$00,$4F,$50,$00             ; 05F5A8 DDDDDDDD M?NM?OP?
.byte $51,$52,$00,$53,$54,$00,$55,$00             ; 05F5B0 DDDDDDDD QR?ST?U?
.byte $56,$00,$56,$00,$57,$00,$58,$00             ; 05F5B8 DDDDDDDD V?V?W?X?
.byte $58,$00,$59,$04,$5A,$04,$5B,$04             ; 05F5C0 DDDDDDDD X?Y?Z?[?
.byte $5C,$04,$5C,$04,$5D,$04,$5E,$08             ; 05F5C8 DDDDDDDD \?\?]?^?
.byte $5F,$08,$5E,$48,$60,$08,$61,$08             ; 05F5D0 DDDDDDDD _?^H`?a?
.byte $62,$08,$63,$08,$06,$0C,$12,$1C             ; 05F5D8 DDDDDDDD b?c?????
.byte $2A,$E0,$00,$70,$0A,$4E,$55,$45             ; 05F5E0 DDDDDDDD *??p?NUE
.byte $9D,$55,$41,$9D,$4D,$41,$84,$0E             ; 05F5E8 DDDDDDDD ?UA?MA??
.byte $00,$24,$80,$0C,$85,$04,$00,$00             ; 05F5F0 DDDDDDDD ?$??????
.byte $00,$FF,$00,$FF,$FE,$00,$FC,$00             ; 05F5F8 DDDDDDDD ????????
.byte $F9,$01,$F2,$03,$E5,$02,$CD,$05             ; 05F600 DDDDDDDD ????????
.byte $9B,$0F,$37,$1F,$6F,$1F,$6F,$02             ; 05F608 DDDDDDDD ??7?o?o?
.byte $E4,$03,$CC,$06,$98,$08,$30,$10             ; 05F610 DDDDDDDD ??????0?
.byte $60,$10,$60,$FE,$03,$02,$FF,$56             ; 05F618 DDDDDDDD `?`????V
.byte $FF,$EA,$FE,$FF,$FE,$01,$FE,$01             ; 05F620 DDDDDDDD ????????
.byte $AA,$01,$16,$02,$01,$02,$01,$FE             ; 05F628 DDDDDDDD ????????
.byte $02,$FD,$05,$FB,$0A,$F7,$15,$EF             ; 05F630 DDDDDDDD ????????
.byte $3F,$DF,$7F,$BF,$FE,$7F,$01,$FE             ; 05F638 DDDDDDDD ????????
.byte $03,$FC,$06,$F8,$0D,$F0,$1A,$E0             ; 05F640 DDDDDDDD ????????
.byte $20,$C0,$41,$80,$82,$01,$FC,$07             ; 05F648 DDDDDDDD  ?A?????
.byte $09,$FE,$53,$FD,$E6,$FB,$4D,$F7             ; 05F650 DDDDDDDD ??S???M?
.byte $9F,$FC,$03,$F9,$06,$B2,$0C,$25             ; 05F658 DDDDDDDD ???????%
.byte $18,$CA,$30,$90,$60,$FE,$03,$04             ; 05F660 DDDDDDDD ??0?`???
.byte $FF,$58,$FF,$F0,$FF,$60,$FF,$C0             ; 05F668 DDDDDDDD ?X???`??
.byte $FF,$80,$FE,$01,$FC,$03,$A8,$07             ; 05F670 DDDDDDDD ????????
.byte $10,$0F,$A0,$1F,$40,$3F,$80,$7F             ; 05F678 DDDDDDDD ????@???
.byte $03,$82,$7F,$D6,$7F,$EA,$FE,$7F             ; 05F680 DDDDDDDD ????????
.byte $FE,$96,$82,$01,$82,$FE,$01,$C7             ; 05F688 DDDDDDDD ????????
.byte $00,$BB,$00,$4D,$08,$55,$00,$55             ; 05F690 DDDDDDDD ???M?U?U
.byte $08,$F7,$10,$EF,$F8,$00,$F1,$00             ; 05F698 DDDDDDDD ????????
.byte $E3,$01,$C6,$01,$86,$02,$0C,$04             ; 05F6A0 DDDDDDDD ????????
.byte $18,$08,$30,$0D,$04,$1B,$08,$37             ; 05F6A8 DDDDDDDD ??0????7
.byte $2A,$CA,$5D,$9D,$AA,$2A,$11,$11             ; 05F6B0 DDDDDDDD *?]??*??
.byte $23,$23,$02,$03,$14,$17,$08,$0F             ; 05F6B8 DDDDDDDD ##??????
.byte $20,$D5,$40,$A2,$80,$55,$00,$EE             ; 05F6C0 DDDDDDDD  ?@??U??
.byte $01,$DC,$02,$FD,$04,$EB,$08,$F7             ; 05F6C8 DDDDDDDD ????????
.byte $AA,$AB,$DE,$DF,$AA,$AB,$16,$17             ; 05F6D0 DDDDDDDD ????????
.byte $A2,$23,$82,$03,$92,$13,$82,$03             ; 05F6D8 DDDDDDDD ?#??????
.byte $02,$55,$02,$21,$E9,$82,$5D,$82             ; 05F6E0 DDDDDDDD ?U?!??]?
.byte $7D,$82,$6D,$82,$7D,$FD,$06,$FA             ; 05F6E8 DDDDDDDD }?m?}???
.byte $09,$F1,$12,$E2,$20,$C0,$51,$91             ; 05F6F0 DDDDDDDD ???? ?Q?
.byte $82,$03,$FC,$04,$F9,$08,$F6,$10             ; 05F6F8 DDDDDDDD ????????
.byte $ED,$20,$DF,$41,$AE,$82,$7D,$AC             ; 05F700 DDDDDDDD ? ?A??}?
.byte $AF,$D9,$DE,$B2,$BC,$25,$39,$4A             ; 05F708 DDDDDDDD ?????%9J
.byte $72,$90,$E0,$30,$D0,$41,$81,$04             ; 05F710 DDDDDDDD r??0?A??
.byte $53,$09,$26,$12,$4D,$24,$DA,$48             ; 05F718 DDDDDDDD S?&?M$?H
.byte $B5,$90,$6F,$20,$CF,$41,$BE,$AA             ; 05F720 DDDDDDDD ??o ?A??
.byte $2B,$DC,$DF,$A8,$AF,$10,$1F,$20             ; 05F728 DDDDDDDD +?????? 
.byte $3F,$40,$7F,$82,$55,$04,$23,$08             ; 05F730 DDDDDDDD ?@??U?#?
.byte $57,$10,$EF,$20,$DF,$40,$BF,$AA             ; 05F738 DDDDDDDD W?? ?@??
.byte $2B,$DE,$5F,$AA,$2B,$92,$13,$82             ; 05F740 DDDDDDDD +?_?+???
.byte $55,$82,$21,$6D,$00,$FF,$01,$FE             ; 05F748 DDDDDDDD U?!m????
.byte $06,$F8,$30,$D0,$40,$80,$20,$CF             ; 05F750 DDDDDDDD ??0?@? ?
.byte $40,$BF,$3E,$C1,$DD,$1C,$AA,$AA             ; 05F758 DDDDDDDD @?>?????
.byte $11,$11,$22,$22,$00,$00,$38,$54             ; 05F760 DDDDDDDD ??""??8T
.byte $82,$FC,$3E,$C1,$C1,$22,$EE,$00             ; 05F768 DDDDDDDD ??>??"??
.byte $DD,$00,$FF,$54,$AB,$82,$7D,$FE             ; 05F770 DDDDDDDD ???T??}?
.byte $03,$12,$13,$22,$12,$13,$02,$03             ; 05F778 DDDDDDDD ???"????
.byte $FE,$01,$ED,$02,$DD,$02,$FD,$FD             ; 05F780 DDDDDDDD ????????
.byte $FE,$01,$FE,$01,$DD,$5C,$AA,$2A             ; 05F788 DDDDDDDD ?????\?*
.byte $91,$11,$A2,$22,$80,$00,$90,$10             ; 05F790 DDDDDDDD ???"????
.byte $80,$00,$FE,$01,$81,$22,$80,$55             ; 05F798 DDDDDDDD ?????"?U
.byte $80,$6E,$80,$5D,$80,$7F,$80,$6F             ; 05F7A0 DDDDDDDD ?n?]???o
.byte $80,$DD,$DC,$7C,$7C,$82,$FE,$FE             ; 05F7A8 DDDDDDDD ???||???
.byte $01,$01,$7C,$83,$81,$7E,$E6,$98             ; 05F7B0 DDDDDDDD ??|??~??
.byte $19,$01,$10,$10,$81,$7E,$66,$19             ; 05F7B8 DDDDDDDD ?????~f?
.byte $18,$E6,$00,$7E,$81,$7E,$81,$81             ; 05F7C0 DDDDDDDD ???~?~??
.byte $C7,$80,$7F,$E0,$9F,$10,$0F,$28             ; 05F7C8 DDDDDDDD ???????(
.byte $2F,$04,$07,$14,$17,$02,$03,$00             ; 05F7D0 DDDDDDDD /???????
.byte $FF,$80,$7F,$60,$1F,$10,$EF,$08             ; 05F7D8 DDDDDDDD ???`????
.byte $D7,$04,$FB,$04,$EB,$02,$FD,$F0             ; 05F7E0 DDDDDDDD ????????
.byte $00,$E0,$00,$C1,$00,$81,$00,$03             ; 05F7E8 DDDDDDDD ????????
.byte $01,$06,$03,$0D,$02,$0C,$0D,$35             ; 05F7F0 DDDDDDDD ???????5
.byte $1A,$6A,$35,$D5,$7F,$BF,$5D,$9D             ; 05F7F8 DDDDDDDD ?j5???]?
.byte $FF,$7F,$AA,$FF,$77,$FF,$08,$32             ; 05F800 DDDDDDDD ????w??2
.byte $10,$65,$20,$CA,$40,$80,$88,$00             ; 05F808 DDDDDDDD ?e ?@???
.byte $50,$5F,$A0,$BF,$7F,$40,$FF,$FF             ; 05F810 DDDDDDDD P_???@??
.byte $DD,$DD,$FF,$FF,$10,$AF,$20,$5F             ; 05F818 DDDDDDDD ?????? _
.byte $3F,$80,$D6,$57,$AA,$2B,$D6,$57             ; 05F820 DDDDDDDD ???W?+?W
.byte $FE,$FF,$DE,$DF,$FE,$76,$FF,$82             ; 05F828 DDDDDDDD ?????v??
.byte $29,$29,$21,$02,$01,$56,$01,$8A             ; 05F830 DDDDDDDD ))!??V??
.byte $01,$D6,$57,$6B,$AB,$35,$D5,$1F             ; 05F838 DDDDDDDD ??Wk?5??
.byte $EF,$0D,$F5,$07,$FB,$02,$FD,$01             ; 05F840 DDDDDDDD ????????
.byte $FE,$82,$29,$41,$94,$20,$CA,$10             ; 05F848 DDDDDDDD ??)A? ??
.byte $E0,$08,$F2,$04,$F8,$03,$FC,$01             ; 05F850 DDDDDDDD ????????
.byte $FE,$55,$95,$2A,$CA,$95,$E5,$CF             ; 05F858 DDDDDDDD ?U?*????
.byte $F7,$E5,$F9,$F3,$FD,$A9,$FE,$74             ; 05F860 DDDDDDDD ???????t
.byte $FF,$41,$AA,$20,$D5,$90,$6A,$48             ; 05F868 DDDDDDDD ?A? ??jH
.byte $30,$24,$1A,$12,$0C,$59,$06,$8C             ; 05F870 DDDDDDDD 0$???Y??
.byte $FF,$40,$7F,$E0,$FF,$D0,$DF,$F8             ; 05F878 DDDDDDDD ?@??????
.byte $FF,$AC,$FF,$F6,$80,$7F,$40,$BF             ; 05F880 DDDDDDDD ??????@?
.byte $20,$1F,$10,$2F,$08,$07,$54,$03             ; 05F888 DDDDDDDD  ??/??T?
.byte $7F,$DE,$5F,$FE,$7F,$AA,$7F,$F6             ; 05F890 DDDDDDDD ??_?????
.byte $7F,$21,$82,$01,$D6,$55,$95,$68             ; 05F898 DDDDDDDD ?!???U?h
.byte $AB,$D6,$55,$7D,$68,$BF,$77,$BF             ; 05F8A0 DDDDDDDD ??U}h?w?
.byte $41,$AA,$42,$95,$80,$2B,$80,$03             ; 05F8A8 DDDDDDDD A?B??+??
.byte $56,$81,$49,$80,$01,$FE,$56,$57             ; 05F8B0 DDDDDDDD V?I???VW
.byte $2A,$2A,$7F,$F6,$FF,$02,$A9,$02             ; 05F8B8 DDDDDDDD **??????
.byte $D5,$56,$81,$0A,$01,$D5,$55,$81             ; 05F8C0 DDDDDDDD ?V????U?
.byte $2A,$55,$01,$AA,$56,$02,$A9,$C0             ; 05F8C8 DDDDDDDD *U??V???
.byte $00,$01,$00,$03,$06,$1B,$04,$1B             ; 05F8D0 DDDDDDDD ????????
.byte $0A,$37,$10,$6F,$24,$DB,$20,$DF             ; 05F8D8 DDDDDDDD ?7?o$? ?
.byte $55,$AA,$FF,$FF,$05,$18,$07,$18             ; 05F8E0 DDDDDDDD U???????
.byte $0D,$30,$1F,$60,$3B,$C4,$3F,$C0             ; 05F8E8 DDDDDDDD ?0?`;???
.byte $6A,$95,$FF,$00,$AA,$FF,$47,$FF             ; 05F8F0 DDDDDDDD j?????G?
.byte $A8,$FF,$10,$FF,$60,$BF,$20,$FF             ; 05F8F8 DDDDDDDD ????`? ?
.byte $40,$55,$00,$BF,$00,$58,$07,$F0             ; 05F900 DDDDDDDD @U???X??
.byte $0F,$A0,$5F,$E0,$1F,$C0,$AA,$FF             ; 05F908 DDDDDDDD ??_?????
.byte $C6,$FF,$AA,$7F,$82,$7F,$C6,$3B             ; 05F910 DDDDDDDD ???????;
.byte $2B,$FE,$FF,$56,$01,$BA,$FE,$01             ; 05F918 DDDDDDDD +??V????
.byte $BA,$45,$55,$7F,$45,$BF,$2A,$DF             ; 05F920 DDDDDDDD ?EU?E?*?
.byte $10,$EF,$0C,$F3,$04,$FB,$D6,$01             ; 05F928 DDDDDDDD ????????
.byte $7B,$80,$35,$C0,$1F,$E0,$0B,$F4             ; 05F930 DDDDDDDD {?5?????
.byte $07,$F8,$6B,$BF,$24,$DF,$9A,$EF             ; 05F938 DDDDDDDD ??k?$???
.byte $48,$F7,$64,$BB,$12,$FD,$59,$AE             ; 05F940 DDDDDDDD H?d???Y?
.byte $FC,$FF,$55,$80,$3B,$C0,$95,$60             ; 05F948 DDDDDDDD ??U?;??`
.byte $CF,$30,$A7,$58,$F3,$0C,$A9,$56             ; 05F950 DDDDDDDD ?0?X???V
.byte $FC,$C0,$FF,$20,$FF,$50,$BF,$08             ; 05F958 DDDDDDDD ??? ?P??
.byte $FF,$54,$AF,$FE,$3F,$E0,$1F,$B0             ; 05F960 DDDDDDDD ?T??????
.byte $4F,$F8,$07,$AC,$53,$C6,$D6,$6A             ; 05F968 DDDDDDDD O???S??j
.byte $2A,$0C,$FB,$06,$FF,$01,$15,$83             ; 05F970 DDDDDDDD *???????
.byte $7D,$3A,$83,$AA,$44,$D5,$EB,$3E             ; 05F978 DDDDDDDD }:??D??>
.byte $FF,$C6,$38,$B9,$44,$BB,$44,$FF             ; 05F980 DDDDDDDD ??8?D?D?
.byte $00,$EB,$14,$3E,$C1,$AA,$FF,$46             ; 05F988 DDDDDDDD ???>???F
.byte $02,$FF,$46,$BB,$AB,$56,$07,$00             ; 05F990 DDDDDDDD ??F??V??
.byte $07,$FE,$00,$FD,$FD,$1F,$F7,$1F             ; 05F998 DDDDDDDD ????????
.byte $A3,$00,$9D,$00,$BD,$00,$BD,$F7             ; 05F9A0 DDDDDDDD ????????
.byte $E3,$F7,$F8,$EF,$F8,$FD,$00,$7C             ; 05F9A8 DDDDDDDD ???????|
.byte $3D,$7D,$3E,$FE,$FE,$FB,$00,$FB             ; 05F9B0 DDDDDDDD =}>?????
.byte $2F,$00,$CF,$EF,$CF,$7F,$00,$FA             ; 05F9B8 DDDDDDDD /???????
.byte $00,$79,$00,$7B,$00,$7B,$3E,$00             ; 05F9C0 DDDDDDDD ?y?{?{>?
.byte $DE,$00,$DE,$91,$00,$6E,$EE,$FC             ; 05F9C8 DDDDDDDD ?????n??
.byte $F7,$F7,$7E,$00,$BE,$1E,$BE,$8F             ; 05F9D0 DDDDDDDD ??~?????
.byte $00,$77,$DF,$00,$DF,$FE,$E3,$BF             ; 05F9D8 DDDDDDDD ?w??????
.byte $BF,$E3,$FD,$EF,$BF,$7F,$00,$02             ; 05F9E0 DDDDDDDD ????????
.byte $F9,$04,$F3,$08,$E7,$10,$CF,$20             ; 05F9E8 DDDDDDDD ??????? 
.byte $9F,$80,$7F,$FC,$C7,$30,$8F,$60             ; 05F9F0 DDDDDDDD ?????0?`
.byte $01,$F8,$02,$F1,$04,$E3,$08,$C7             ; 05F9F8 DDDDDDDD ????????
.byte $08,$87,$10,$0F,$20,$FC,$03,$F8             ; 05FA00 DDDDDDDD ???? ???
.byte $07,$F0,$0E,$E1,$1C,$C1,$3C,$83             ; 05FA08 DDDDDDDD ??????<?
.byte $78,$E0,$01,$E0,$02,$C1,$02,$81             ; 05FA10 DDDDDDDD x???????
.byte $04,$03,$08,$0F,$3E,$80,$7E,$F8             ; 05FA18 DDDDDDDD ????>?~?
.byte $01,$80,$01,$00,$02,$01,$04,$03             ; 05FA20 DDDDDDDD ????????
.byte $1F,$C0,$20,$1F,$1F,$E0,$3F,$C0             ; 05FA28 DDDDDDDD ?? ?????
.byte $7F,$FF,$00,$0F,$F0,$08,$00,$08             ; 05FA30 DDDDDDDD ????????
.byte $FC,$83,$3F,$30,$3F,$30,$03,$33             ; 05FA38 DDDDDDDD ???0?0?3
.byte $0F,$8F,$C3,$F3,$C3,$F3,$CC,$0F             ; 05FA40 DDDDDDDD ????????
.byte $FC,$FC,$03,$83,$0C,$8F,$33,$8F             ; 05FA48 DDDDDDDD ??????3?
.byte $33,$F3,$3F,$F0,$3F,$C0,$3F,$C0             ; 05FA50 DDDDDDDD 3???????
.byte $F0,$E0,$E0,$1F,$33,$F0,$CC,$C3             ; 05FA58 DDDDDDDD ????3???
.byte $CC,$C3,$73,$0F,$FF,$3F,$FF,$3F             ; 05FA60 DDDDDDDD ??s?????
.byte $7F,$7F,$FC,$CC,$0F,$CC,$0F,$CC             ; 05FA68 DDDDDDDD ????????
.byte $C3,$3C,$03,$F3,$00,$F3,$00,$3C             ; 05FA70 DDDDDDDD ?<?????<
.byte $FF,$39,$80,$C0,$4D,$EB,$3C,$07             ; 05FA78 DDDDDDDD ?9??M?<?
.byte $02,$70,$29,$B2,$16,$78,$0A,$40             ; 05FA80 DDDDDDDD ?p)??x?@
.byte $1E,$02,$05,$E0,$E7,$89,$24,$E4             ; 05FA88 DDDDDDDD ??????$?
.byte $E7,$99,$84,$5E,$A5,$90,$EE,$89             ; 05FA90 DDDDDDDD ???^????
.byte $1D,$66,$53,$EE,$93,$81,$CF,$09             ; 05FA98 DDDDDDDD ?fS?????
.byte $34,$8B,$71,$39,$E3,$3C,$00,$5D             ; 05FAA0 DDDDDDDD 4?q9?<?]
.byte $DA,$F1,$20,$23,$2B,$0C,$0F,$46             ; 05FAA8 DDDDDDDD ?? #+??F
.byte $CA,$A3,$07,$52,$65,$7B,$00,$32             ; 05FAB0 DDDDDDDD ???Re{?2
.byte $83,$EC,$20,$78,$FC,$8E,$A0,$94             ; 05FAB8 DDDDDDDD ?? x????
.byte $1C,$EC,$24,$33,$F0,$80,$DA,$84             ; 05FAC0 DDDDDDDD ??$3????
.byte $83,$8C,$2D,$B8,$49,$37,$18,$20             ; 05FAC8 DDDDDDDD ??-?I7? 
.byte $E4,$07,$75,$46,$40,$D4,$C8,$5D             ; 05FAD0 DDDDDDDD ??uF@??]
.byte $A2,$27,$62,$64,$DB,$26,$1E,$96             ; 05FAD8 DDDDDDDD ?'bd?&??
.byte $BA,$03,$88,$C5,$8E,$32,$42,$55             ; 05FAE0 DDDDDDDD ?????2BU
.byte $D0,$F8,$E6,$44,$97,$9C,$D6,$38             ; 05FAE8 DDDDDDDD ???D???8
.byte $F8,$93,$BA,$08,$C1,$E2,$4E,$F8             ; 05FAF0 DDDDDDDD ??????N?
.byte $2D,$5B,$8E,$C2,$EE,$50,$67,$BC             ; 05FAF8 DDDDDDDD -[???Pg?
.byte $D0,$95,$75,$C2,$47,$D8,$10,$91             ; 05FB00 DDDDDDDD ??u?G???
.byte $36,$4B,$CD,$25,$3E,$30,$93,$C3             ; 05FB08 DDDDDDDD 6K?%>0??
.byte $BC,$A7,$E7,$08,$5F,$AB,$83,$AD             ; 05FB10 DDDDDDDD ????_???
.byte $2C,$9C,$80,$53,$69,$E4,$86,$87             ; 05FB18 DDDDDDDD ,??Si???
.byte $64,$37,$BC,$6F,$09,$81,$DE,$80             ; 05FB20 DDDDDDDD d7?o????
.byte $64,$72,$0D,$EE,$C9,$C4,$66,$17             ; 05FB28 DDDDDDDD dr????f?
.byte $8A,$C4,$06,$14,$04,$C9,$DE,$4C             ; 05FB30 DDDDDDDD ???????L
.byte $39,$0C,$24,$F1,$0D,$60,$38,$A8             ; 05FB38 DDDDDDDD 9?$??`8?
.byte $92,$71,$09,$08,$E2,$92,$1C,$80             ; 05FB40 DDDDDDDD ?q??????
.byte $43,$93,$47,$38,$90,$B9,$82,$8C             ; 05FB48 DDDDDDDD C?G8????
.byte $73,$49,$0B,$88,$28,$C7,$44,$90             ; 05FB50 DDDDDDDD sI??(?D?
.byte $DB,$80,$C6,$ED,$49,$EA,$02,$90             ; 05FB58 DDDDDDDD ????I???
.byte $A3,$C2,$19,$1C,$7D,$F5,$B7,$9E             ; 05FB60 DDDDDDDD ????}???
.byte $68,$76,$B3,$B4,$82,$42,$64,$8A             ; 05FB68 DDDDDDDD hv???Bd?
.byte $4E,$9D,$C1,$93,$2B,$BB,$50,$BB             ; 05FB70 DDDDDDDD N???+?P?
.byte $FC,$24,$37,$D8,$4A,$BC,$1F,$61             ; 05FB78 DDDDDDDD ?$7?J??a
.byte $78,$5E,$10,$3D,$DE,$2E,$95,$F7             ; 05FB80 DDDDDDDD x^?=?.??
.byte $18,$0B,$BA,$28,$DE,$01,$BB,$0B             ; 05FB88 DDDDDDDD ???(????
.byte $0F,$6B,$4F,$08,$DD,$F5,$1E,$78             ; 05FB90 DDDDDDDD ?kO????x
.byte $10,$F9,$B6,$CA,$7C,$07,$6C,$08             ; 05FB98 DDDDDDDD ????|?l?
.byte $5E,$DF,$C1,$88,$2B,$B9,$C1,$79             ; 05FBA0 DDDDDDDD ^???+??y
.byte $54,$1E,$A8,$0B,$95,$D0,$F6,$1A             ; 05FBA8 DDDDDDDD T???????
.byte $13,$81,$81,$7D,$C2,$A7,$BF,$4F             ; 05FBB0 DDDDDDDD ???}???O
.byte $7A,$A9,$F0,$55,$27,$0B,$D7,$C9             ; 05FBB8 DDDDDDDD z??U'???
.byte $30,$72,$09,$6C,$72,$F7,$96,$C6             ; 05FBC0 DDDDDDDD 0r?lr???
.byte $CB,$E6,$00,$32,$FD,$98,$FB,$57             ; 05FBC8 DDDDDDDD ???2???W
.byte $D4,$D4,$BE,$8D,$7E,$01,$FC,$39             ; 05FBD0 DDDDDDDD ????~??9
.byte $7D,$40,$06,$FC,$75,$ED,$4F,$A2             ; 05FBD8 DDDDDDDD }@??u?O?
.byte $97,$E4,$00,$67,$ED,$D7,$F0,$AF             ; 05FBE0 DDDDDDDD ???g????
.byte $E5,$60,$F4,$02,$F9,$45,$FE,$0F             ; 05FBE8 DDDDDDDD ?`???E??
.byte $F3,$9F,$2D,$04,$B7,$CC,$9E,$01             ; 05FBF0 DDDDDDDD ??-?????
.byte $B7,$2B,$10,$9D,$EA,$AE,$09,$AE             ; 05FBF8 DDDDDDDD ?+??????
.byte $08,$B8,$13,$52,$07,$84,$63,$84             ; 05FC00 DDDDDDDD ???R??c?
.byte $AE,$04,$40,$21,$E1,$90,$E1,$99             ; 05FC08 DDDDDDDD ??@!????
.byte $E1,$44,$02,$73,$36,$B8,$86,$38             ; 05FC10 DDDDDDDD ?D?s6??8
.byte $8A,$E1,$C4,$02,$E0,$2A,$DB,$4A             ; 05FC18 DDDDDDDD ?????*?J
.byte $E2,$93,$04,$F4,$38,$B7,$09,$E1             ; 05FC20 DDDDDDDD ????8???
.byte $BA,$E0,$3A,$E3,$0B,$8B,$10,$09             ; 05FC28 DDDDDDDD ??:?????
.byte $DE,$19,$06,$78,$E2,$E4,$04,$E4             ; 05FC30 DDDDDDDD ???x????
.byte $1C,$CC,$64,$E3,$CD,$4B,$86,$45             ; 05FC38 DDDDDDDD ??d??K?E
.byte $1B,$90,$EB,$59,$1B,$94,$4B,$02             ; 05FC40 DDDDDDDD ???Y??K?
.byte $E5,$1D,$8B,$F9,$60,$43,$95,$F5             ; 05FC48 DDDDDDDD ????`C??
.byte $39,$70,$50,$C4,$F1,$70,$57,$5B             ; 05FC50 DDDDDDDD 9pP??pW[
.byte $8A,$46,$E4,$82,$E5,$BA,$43,$0F             ; 05FC58 DDDDDDDD ?F????C?
.byte $A2,$79,$D0,$18,$35,$9B,$24,$70             ; 05FC60 DDDDDDDD ?y??5?$p
.byte $F9,$90,$D6,$56,$DB,$40,$81,$C3             ; 05FC68 DDDDDDDD ???V?@??
.byte $D7,$0F,$B7,$9B,$20,$70,$FA,$0E             ; 05FC70 DDDDDDDD ???? p??
.byte $89,$40,$E8,$01,$B5,$9A,$9C,$3C             ; 05FC78 DDDDDDDD ?@?????<
.byte $6D,$B4,$12,$13,$59,$B7,$A3,$65             ; 05FC80 DDDDDDDD m???Y??e
.byte $8E,$7F,$0E,$99,$40,$E9,$01,$87             ; 05FC88 DDDDDDDD ????@???
.byte $71,$61,$E9,$44,$E9,$4D,$B6,$D9             ; 05FC90 DDDDDDDD qa?D?M??
.byte $2E,$A4,$88,$DC,$40,$09,$DC,$59             ; 05FC98 DDDDDDDD .???@??Y
.byte $77,$15,$03,$71,$01,$7A,$B3,$56             ; 05FCA0 DDDDDDDD w??q?z?V
.byte $03,$AD,$C4,$80,$EB,$49,$79,$9B             ; 05FCA8 DDDDDDDD ?????Iy?
.byte $1E,$BF,$00,$D6,$87,$AC,$91,$3B             ; 05FCB0 DDDDDDDD ???????;
.byte $04,$63,$AC,$C4,$2E,$CC,$56,$03             ; 05FCB8 DDDDDDDD ?c??.?V?
.byte $AE,$C5,$93,$AF,$B4,$63,$AB,$C4             ; 05FCC0 DDDDDDDD ?????c??
.byte $2E,$C6,$57,$99,$F1,$EA,$ED,$1E             ; 05FCC8 DDDDDDDD .?W?????
.byte $C6,$00,$97,$B5,$B5,$87,$B9,$90             ; 05FCD0 DDDDDDDD ????????
.byte $63,$98,$C1,$EE,$F4,$7A,$9B,$0E             ; 05FCD8 DDDDDDDD c????z??
.byte $C6,$C4,$EF,$19,$0E,$B2,$94,$97             ; 05FCE0 DDDDDDDD ????????
.byte $AE,$B5,$97,$BD,$94,$2E,$A6,$87             ; 05FCE8 DDDDDDDD ?????.??
.byte $B8,$05,$E9,$DB,$C1,$D4,$3B,$1B             ; 05FCF0 DDDDDDDD ??????;?
.byte $47,$B8,$81,$70,$8C,$3C,$5C,$13             ; 05FCF8 DDDDDDDD G??p?<\?
.byte $13,$B0,$F1,$CA,$00,$00,$5F,$02             ; 05FD00 DDDDDDDD ??????_?
.byte $1F,$00,$52,$4A,$95,$00,$FF,$7F             ; 05FD08 DDDDDDDD ??RJ????
.byte $10,$42,$29,$25,$B5,$56,$CE,$39             ; 05FD10 DDDDDDDD ?B)%?V?9
.byte $00,$00,$DF,$01,$3F,$01,$3F,$03             ; 05FD18 DDDDDDDD ????????
.byte $FF,$03,$FF,$5F,$00,$00,$FF,$03             ; 05FD20 DDDDDDDD ???_????
.byte $FF,$5F,$5F,$02,$6D,$03,$00,$27             ; 05FD28 DDDDDDDD ?__?m??'
.byte $60,$03,$40,$4A,$D2,$03,$F8,$03             ; 05FD30 DDDDDDDD `?@J????
.byte $60,$7D,$80,$78,$00,$64,$03,$54             ; 05FD38 DDDDDDDD `}?x?d?T
.byte $05,$40,$06,$34,$00,$00,$06,$34             ; 05FD40 DDDDDDDD ?@?4???4
.byte $05,$28,$0C,$34,$0A,$34,$0D,$30             ; 05FD48 DDDDDDDD ?(?4?4?0
.byte $08,$34,$0D,$28,$10,$2C,$0B,$1C             ; 05FD50 DDDDDDDD ?4?(?,??
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 05FD58 DDDDDDDD ????????
.byte $00,$00,$00,$00,$60,$01,$BE,$F4             ; 05FD60 DDDDDDDD ????`???
.byte $05,$00,$80,$01,$60,$05,$87,$F5             ; 05FD68 DDDDDDDD ????`???
.byte $05,$00,$40,$01,$60,$09,$9E,$F5             ; 05FD70 DDDDDDDD ??@?`???
.byte $05,$00,$40,$01,$00,$40,$F2,$F5             ; 05FD78 DDDDDDDD ??@??@??
.byte $05,$00,$80,$0C,$00,$20,$F2,$F5             ; 05FD80 DDDDDDDD ????? ??
.byte $05,$00,$80,$0C,$FF,$FF,$00,$00             ; 05FD88 DDDDDDDD ????????
.byte $48,$EF,$05,$00,$00,$08,$00,$40             ; 05FD90 DDDDDDDD H??????@
.byte $7E,$F0,$05,$00,$C0,$08,$FF,$FF             ; 05FD98 DDDDDDDD ~???????
D_5FDA0:
.byte $A6,$FD,$AB,$FD,$B2,$FD,$45,$41             ; 05FDA0 DDDDDDDD ??????EA
.byte $53,$59,$00,$4E,$4F,$52,$4D,$41             ; 05FDA8 DDDDDDDD SY?NORMA
.byte $4C,$00,$48,$41,$52,$44,$00,$00             ; 05FDB0 DDDDDDDD L?HARD??
.byte $04,$E2,$EC,$0C,$00,$00,$08,$00             ; 05FDB8 DDDDDDDD ????????
.byte $20,$AD,$90,$0C,$00,$E0,$1F,$00             ; 05FDC0 DDDDDDDD  ???????
.byte $00,$2C,$CF,$0C,$00,$C0,$00,$00             ; 05FDC8 DDDDDDDD ?,??????
.byte $40,$AD,$90,$0C,$00,$00,$40,$FF             ; 05FDD0 DDDDDDDD @?????@?
.byte $FF,$00,$04,$C5,$ED,$0C,$00,$00             ; 05FDD8 DDDDDDDD ????????
.byte $08,$00,$20,$AD,$90,$0C,$00,$E0             ; 05FDE0 DDDDDDDD ?? ?????
.byte $1F,$00,$00,$2C,$CF,$0C,$00,$C0             ; 05FDE8 DDDDDDDD ???,????
.byte $00,$00,$40,$AD,$90,$0C,$00,$00             ; 05FDF0 DDDDDDDD ??@?????
.byte $40,$FF,$FF,$00,$04,$83,$EE,$0C             ; 05FDF8 DDDDDDDD @???????
.byte $00,$00,$08,$00,$20,$AD,$90,$0C             ; 05FE00 DDDD.... ???? ???
.byte $00,$E0,$1F,$FF,$FF,$7F,$A0,$11             ; 05FE08 .....DDD ????????
.byte $01,$C7,$E0,$04,$F0,$02,$F1,$90             ; 05FE10 DDDDDDDD ????????
.byte $E7,$D1,$E4,$FD,$F4,$04,$B1,$3F             ; 05FE18 DDDDDDDD ????????
.byte $A0,$1F,$2F,$1E,$7E,$F7,$D1,$F4             ; 05FE20 DDDDDDDD ??/?~???
.byte $E2,$A0,$E3,$F0,$0E,$72,$E9,$7E             ; 05FE28 DDDDDDDD ?????r?~
.byte $F1,$E4,$90,$2E,$3B,$12,$4F,$DF             ; 05FE30 DDDDDDDD ???.;?O?
.byte $7E,$F3,$0D,$A0,$3F,$01,$E4,$E4             ; 05FE38 DDDDDDDD ~???????
.byte $F0,$0F,$62,$F0,$80,$01,$E3,$0F             ; 05FE40 DDDDDDDD ??b?????
.byte $11,$FF,$10,$01,$87,$A0,$1A,$71             ; 05FE48 DDDDDDDD ???????q
.byte $01,$F3,$F0,$2E,$3F,$00,$A0,$1E             ; 05FE50 DDDDDDDD ???.????
.byte $6D,$5F,$01,$00,$4C,$11,$B5,$A0             ; 05FE58 DDDDDDDD m_??L???
.byte $FF,$7E,$0D,$4D,$6C,$6E,$01,$D7             ; 05FE60 DDDDDDDD ?~?Mln??
.byte $90,$93,$3F,$F7,$B3,$18,$7F,$F5             ; 05FE68 DDDDDDDD ????????
.byte $FF,$A0,$3E,$04,$B2,$F1,$00,$3E             ; 05FE70 DDDDDDDD ??>????>
.byte $5E,$1F,$90,$5D,$7E,$01,$E5,$FF             ; 05FE78 DDDDDDDD ^??]~???
.byte $7D,$4D,$7E,$A0,$00,$1F,$00,$0F             ; 05FE80 DDDDDDDD }M~?????
.byte $5D,$F7,$EF,$30,$B0,$F4,$E2,$F1             ; 05FE88 DDDDDDDD ]??0????
.byte $0F,$10,$F5,$D0,$30,$B0,$E5,$C1             ; 05FE90 DDDDDDDD ????0???
.byte $1F,$10,$F4,$D2,$F1,$00,$A0,$F5             ; 05FE98 DDDDDDDD ????????
.byte $E1,$F0,$4B,$21,$E7,$C5,$0A,$A0             ; 05FEA0 DDDDDDDD ??K!????
.byte $43,$D7,$E0,$01,$01,$00,$29,$7E             ; 05FEA8 DDDDDDDD C?????)~
.byte $A0,$F4,$DF,$7E,$00,$25,$E0,$4E             ; 05FEB0 DDDDDDDD ???~?%?N
.byte $4B,$B0,$F6,$D1,$2D,$20,$F4,$D1             ; 05FEB8 DDDDDDDD K???- ??
.byte $0F,$2F,$A0,$97,$10,$F4,$C3,$F1             ; 05FEC0 DDDDDDDD ?/??????
.byte $0D,$4F,$00,$90,$01,$F0,$2E,$6D             ; 05FEC8 DDDDDDDD ?O????.m
.byte $2E,$70,$91,$4D,$A0,$33,$00,$1F             ; 05FED0 DDDDDDDD .p?M?3??
.byte $1E,$7B,$17,$A7,$C7,$A0,$D2,$F1             ; 05FED8 DDDDDDDD ?{??????
.byte $E6,$E1,$C1,$1F,$31,$00,$A0,$3E             ; 05FEE0 DDDDDDDD ????1??>
.byte $2D,$21,$E7,$E2,$0E,$7C,$11,$A0             ; 05FEE8 DDDDDDDD -!???|??
.byte $F4,$D1,$3F,$00,$1C,$5E,$03,$03             ; 05FEF0 DDDDDDDD ?????^??
.byte $A0,$D5,$D7,$A2,$00,$11,$F7,$FC             ; 05FEF8 DDDDDDDD ????????
.byte $40,$A0,$F4,$E5,$E0,$1C,$5C,$32             ; 05FF00 DDDDDDDD @?????\2
.byte $F0,$10,$A0,$4D,$7E,$1E,$5C,$7F             ; 05FF08 DDDDDDDD ???M~?\?
.byte $C2,$F1,$00,$A0,$01,$E6,$E0,$0F             ; 05FF10 DDDDDDDD ????????
.byte $4E,$4F,$03,$5A,$A0,$7C,$12,$E7             ; 05FF18 DDDDDDDD NO?Z?|??
.byte $D1,$0F,$4C,$5E,$02,$A0,$0F,$5A             ; 05FF20 DDDDDDDD ??L^???Z
.byte $7A,$20,$2D,$7E,$02,$5C,$A0,$5E             ; 05FF28 DDDDDDDD z -~?\?^
.byte $31,$5D,$4F,$F5,$E1,$01,$E5,$A0             ; 05FF30 DDDDDDDD 1]O?????
.byte $A6,$FC,$31,$F2,$00,$1F,$5D,$6E             ; 05FF38 DDDDDDDD ??1???]n
.byte $A0,$10,$F4,$0C,$5E,$10,$0F,$20             ; 05FF40 DDDDDDDD ????^?? 
.byte $E6,$A0,$A2,$3D,$5C,$20,$20,$00             ; 05FF48 DDDDDDDD ???=\  ?
.byte $E1,$F2,$90,$6E,$12,$E1,$04,$C7             ; 05FF50 DDDDDDDD ???n????
.byte $D1,$F0,$E7,$A0,$F0,$02,$FF,$5E             ; 05FF58 DDDDDDDD ???????^
.byte $33,$10,$1F,$21,$A0,$F3,$F0,$0E             ; 05FF60 DDDDDDDD 3??!????
.byte $5E,$02,$00,$59,$6B,$A0,$7A,$50             ; 05FF68 DDDDDDDD ^??Yk?zP
.byte $B7,$B5,$C5,$FE,$7E,$F5,$90,$C4             ; 05FF70 DDDDDDDD ????~???
.byte $FF,$7B,$31,$0E,$7E,$F7,$C6,$A0             ; 05FF78 DDDDDDDD ?{1?~???
.byte $F0,$2E,$5E,$03,$F7,$D1,$0F,$3E             ; 05FF80 DDDDDDDD ?.^????>
.byte $90,$07,$E0,$0F,$5F,$01,$11,$E7             ; 05FF88 DDDDDDDD ????_???
.byte $BF,$A0,$5B,$5F,$F5,$E1,$0F,$32             ; 05FF90 DDDDDDDD ??[_???2
.byte $F1,$0E,$A0,$1E,$6D,$2F,$20,$F4             ; 05FF98 DDDDDDDD ????m/ ?
.byte $E3,$F1,$0F,$90,$F5,$D7,$D7,$FF             ; 05FFA0 DDDDDDDD ????????
.byte $2F,$02,$F0,$17,$A0,$F1,$1F,$1E             ; 05FFA8 DDDDDDDD /???????
.byte $6B,$41,$F2,$1F,$3F,$90,$04,$E2             ; 05FFB0 DDDDDDDD kA??????
.byte $01,$F3,$3F,$02,$E6,$1E,$90,$4E             ; 05FFB8 DDDDDDDD ???????N
.byte $3E,$6D,$10,$E7,$20,$0F,$63,$A0             ; 05FFC0 DDDDDDDD >m?? ?c?
.byte $E4,$D0,$3E,$1F,$6C,$23,$F0,$F4             ; 05FFC8 DDDDDDDD ??>?l#??
.byte $A0,$FF,$2F,$F2,$0F,$10,$F4,$E2             ; 05FFD0 DDDDDDDD ??/?????
.byte $0E,$90,$3C,$70,$0F,$02,$01,$E7             ; 05FFD8 DDDDDDDD ??<p????
.byte $A7,$FE,$90,$5E,$4F,$E0,$32,$1E             ; 05FFE0 DDDDDDDD ???^O?2?
.byte $70,$E7,$A2,$90,$F0,$3E,$5E,$03             ; 05FFE8 DDDDDDDD p????>^?
.byte $D5,$D6,$D4,$79,$A0,$14,$C2,$4A             ; 05FFF0 DDDDDDDD ???y???J
.byte $5F,$F5,$E3,$D0,$2F,$A0,$F3,$C7             ; 05FFF8 DDDDDDDD _???/???
