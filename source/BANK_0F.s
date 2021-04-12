.SETCPU "65816"
.i16
.a16
.ORG $0F8000

.byte $28,$E2,$30,$AD,$49,$19,$8D,$BE             ; 0F8000 (?0?I???
.byte $06,$AD,$D1,$05,$8D,$BE,$06,$8D             ; 0F8008 ????????
.byte $BF,$06,$8D,$C0,$06,$8D,$C1,$06             ; 0F8010 ????????
.byte $AD,$BE,$06,$29,$0F,$85,$9D,$AD             ; 0F8018 ???)????
.byte $BE,$06,$4A,$4A,$4A,$4A,$85,$9E             ; 0F8020 ??JJJJ??
.byte $AD,$BF,$06,$29,$0F,$85,$9B,$AD             ; 0F8028 ???)????
.byte $BF,$06,$4A,$4A,$4A,$4A,$85,$9C             ; 0F8030 ??JJJJ??
.byte $AD,$C0,$06,$29,$0F,$85,$99,$AD             ; 0F8038 ???)????
.byte $C0,$06,$4A,$4A,$4A,$4A,$85,$9A             ; 0F8040 ??JJJJ??
.byte $AD,$C1,$06,$29,$0F,$85,$97,$AD             ; 0F8048 ???)????
.byte $C1,$06,$4A,$4A,$4A,$4A,$85,$98             ; 0F8050 ??JJJJ??
.byte $AD,$C2,$06,$29,$0F,$85,$A5,$AD             ; 0F8058 ???)????
.byte $C2,$06,$4A,$4A,$4A,$4A,$85,$A6             ; 0F8060 ??JJJJ??
.byte $AD,$C3,$06,$29,$0F,$85,$A3,$AD             ; 0F8068 ???)????
.byte $C3,$06,$4A,$4A,$4A,$4A,$85,$A4             ; 0F8070 ??JJJJ??
.byte $AD,$C4,$06,$29,$0F,$85,$A1,$AD             ; 0F8078 ???)????
.byte $C4,$06,$4A,$4A,$4A,$4A,$85,$A2             ; 0F8080 ??JJJJ??
.byte $AD,$C5,$06,$29,$0F,$85,$9F,$AD             ; 0F8088 ???)????
.byte $C5,$06,$4A,$4A,$4A,$4A,$85,$A0             ; 0F8090 ??JJJJ??
.byte $28,$6B                                     ; 0F8099 (k


L_F809A:
  LDA $05AB                                       ; 0F809A AD AB 05 
.a8
  CMP #$02                                        ; 0F809D C9 02 
  BEQ B_F80A2                                     ; 0F809F F0 01 
  RTL                                             ; 0F80A1 6B 

B_F80A2:
.byte $AD,$AC,$05,$C9,$16,$D0,$F8,$C2             ; 0F80A2 ????????
.byte $20,$A9,$18,$80,$22,$01,$84,$0F             ; 0F80AA  ???"???
.byte $E2,$20,$A2,$00,$22,$72,$F0,$0E             ; 0F80B2 ? ??"r??
.byte $A9,$07,$8D,$C2,$02,$22,$13,$CA             ; 0F80BA ?????"??
.byte $0E,$A9,$01,$A0,$0A,$22,$07,$F4             ; 0F80C2 ?????"??
.byte $0E,$A2,$00,$20,$5F,$81,$A2,$3C             ; 0F80CA ??? _??<
.byte $22,$72,$C9,$0E,$A9,$02,$A0,$0D             ; 0F80D2 "r??????
.byte $22,$07,$F4,$0E,$A2,$01,$20,$5F             ; 0F80DA "????? _
.byte $81,$A2,$3C,$22,$72,$C9,$0E,$A9             ; 0F80E2 ??<"r???
.byte $03,$A0,$10,$22,$07,$F4,$0E,$A2             ; 0F80EA ???"????
.byte $02,$20,$5F,$81,$A2,$3C,$22,$72             ; 0F80F2 ? _??<"r
.byte $C9,$0E,$A9,$04,$A0,$13,$22,$07             ; 0F80FA ??????"?
.byte $F4,$0E,$A2,$03,$20,$5F,$81,$A2             ; 0F8102 ???? _??
.byte $3C,$22,$72,$C9,$0E,$A9,$05,$A0             ; 0F810A <"r?????
.byte $16,$22,$07,$F4,$0E,$C2,$10,$A9             ; 0F8112 ?"??????
.byte $07,$A2,$18,$FF,$22,$0F,$83,$0F             ; 0F811A ????"???
.byte $E2,$10,$A2,$FF,$22,$72,$C9,$0E             ; 0F8122 ????"r??
.byte $A2,$80,$22,$72,$C9,$0E,$A2,$04             ; 0F812A ??"r????
.byte $DA,$BF,$5A,$81,$0F,$A8,$A9,$00             ; 0F8132 ??Z?????
.byte $22,$07,$F4,$0E,$A2,$04,$20,$5F             ; 0F813A "????? _
.byte $81,$A2,$0A,$22,$72,$C9,$0E,$FA             ; 0F8142 ???"r???
.byte $CA,$10,$E5,$22,$13,$CA,$0E,$9C             ; 0F814A ???"????
.byte $C2,$02,$A9,$01,$8D,$30,$05,$6B             ; 0F8152 ?????0?k
.byte $16,$13,$10,$0D,$0A,$A9,$FF,$EB             ; 0F815A ????????
.byte $BF,$72,$81,$0F,$C2,$10,$AA,$A9             ; 0F8162 ?r??????
.byte $07,$22,$0F,$83,$0F,$E2,$10,$60             ; 0F816A ?"?????`
.byte $0E,$0F,$10,$12,$01                         ; 0F8173 ?????


L_F8177:
  PHP                                             ; 0F8177 08 
  PHB                                             ; 0F8178 8B 
  SEP #$30                                        ; 0F8179 E2 30 
  PEA $0F0F                                       ; 0F817B F4 0F 0F 
  PLB                                             ; 0F817E AB 
  PLB                                             ; 0F817F AB 
  LDA $05D7                                       ; 0F8180 AD D7 05 
  BEQ B_F81C7                                     ; 0F8183 F0 42 
  LDA $D2                                         ; 0F8185 A5 D2 
  AND #$01                                        ; 0F8187 29 01 
  BNE B_F81C7                                     ; 0F8189 D0 3C 
  DEC $05D7                                       ; 0F818B CE D7 05 
  BNE B_F819F                                     ; 0F818E D0 0F 
  STZ $06C8                                       ; 0F8190 9C C8 06 
  STZ $06C9                                       ; 0F8193 9C C9 06 
  STZ $06CA                                       ; 0F8196 9C CA 06 
  STZ $06CB                                       ; 0F8199 9C CB 06 
  PLB                                             ; 0F819C AB 
  PLP                                             ; 0F819D 28 
  RTL                                             ; 0F819E 6B 
B_F819F:
  JSL f:L_ECA95                                   ; 0F819F 22 95 CA 0E 
  AND #$07                                        ; 0F81A3 29 07 
  ASL                                             ; 0F81A5 0A 
  TAX                                             ; 0F81A6 AA 
  LDA D_81CA,X                                    ; 0F81A7 BD CA 81 
  STA $06C8                                       ; 0F81AA 8D C8 06 
  LDA D_81CB,X                                    ; 0F81AD BD CB 81 
  STA $06C9                                       ; 0F81B0 8D C9 06 
  JSL f:L_ECA95                                   ; 0F81B3 22 95 CA 0E 
  AND #$07                                        ; 0F81B7 29 07 
  ASL                                             ; 0F81B9 0A 
  TAX                                             ; 0F81BA AA 
  LDA D_81CA,X                                    ; 0F81BB BD CA 81 
  STA $06CA                                       ; 0F81BE 8D CA 06 
  LDA D_81CB,X                                    ; 0F81C1 BD CB 81 
  STA $06CB                                       ; 0F81C4 8D CB 06 
B_F81C7:
  PLB                                             ; 0F81C7 AB 
  PLP                                             ; 0F81C8 28 
  RTL                                             ; 0F81C9 6B 

.byte $00,$00,$01,$00,$FF,$FF,$00,$00             ; 0F81CA ????????
.byte $01,$00,$FF,$FF,$00,$00,$00,$00             ; 0F81D2 ????????


L_F81DA:
  PHP                                             ; 0F81DA 08 
  PHB                                             ; 0F81DB 8B 
  REP #$30                                        ; 0F81DC C2 30 
  LDX #$0000                                      ; 0F81DE A2 00 00 
.a16
  LDA #$A146                                      ; 0F81E1 A9 46 A1 
  LDY #$000B                                      ; 0F81E4 A0 0B 00 
  JSL f:L_580C1                                   ; 0F81E7 22 C1 80 05 
  SEP #$10                                        ; 0F81EB E2 10 
  LDX $05AB                                       ; 0F81ED AE AB 05 
  BEQ B_F8224                                     ; 0F81F0 F0 32 

.byte $CA,$F0,$1E,$C2,$30,$A2,$00,$40             ; 0F81F2 ????0??@
.byte $A9,$00,$80,$A0,$09,$00,$22,$C1             ; 0F81FA ??????"?
.byte $80,$05,$A2,$00,$80,$A9,$C9,$9C             ; 0F8202 ????????
.byte $A0,$0A,$00,$22,$C1,$80,$05,$80             ; 0F820A ???"????
.byte $20,$C2,$30,$A2,$00,$40,$A9,$00             ; 0F8212  ?0??@??
.byte $80,$A0,$0A,$00,$22,$C1,$80,$05             ; 0F821A ????"???
.byte $80,$0F                                     ; 0F8223 ??

B_F8224:
  REP #$30                                        ; 0F8224 C2 30 
  LDX #$4000                                      ; 0F8226 A2 00 40 
  LDA #$8000                                      ; 0F8229 A9 00 80 
  LDY #$000B                                      ; 0F822C A0 0B 00 
  JSL f:L_580C1                                   ; 0F822F 22 C1 80 05 
  PLB                                             ; 0F8233 AB 
  PLP                                             ; 0F8234 28 
  RTL                                             ; 0F8235 6B 

.byte $DA,$AD,$A3,$18,$F0,$07,$64,$04             ; 0F8236 ??????d?
.byte $64,$06,$20,$55,$82,$AD,$A4,$18             ; 0F823E d? U????
.byte $F0,$0B,$A9,$01,$85,$04,$A9,$04             ; 0F8246 ????????
.byte $85,$06,$20,$55,$82,$FA,$6B,$22             ; 0F824E ?? U??k"
.byte $F3,$80,$03,$D0,$51,$22,$94,$80             ; 0F8256 ????Q"??
.byte $03,$A9,$01,$9D,$D2,$06,$EE,$F1             ; 0F825E ????????
.byte $18,$A9,$4E,$9D,$44,$07,$A9,$0C             ; 0F8266 ??N?D???
.byte $9D,$28,$08,$A9,$E4,$9D,$BC,$13             ; 0F826E ?(??????
.byte $A9,$34,$9D,$2E,$14,$A5,$04,$9D             ; 0F8276 ?4?.????
.byte $BA,$0F,$A9,$FF,$9D,$80,$0D,$18             ; 0F827E ????????
.byte $A9,$04,$65,$06,$9D,$46,$0B,$9E             ; 0F8286 ??e??F??
.byte $B8,$0B,$18,$A9,$7E,$65,$06,$9D             ; 0F828E ????~e??
.byte $9C,$0C,$9E,$0E,$0D,$22,$BC,$AE             ; 0F8296 ?????"??
.byte $00,$98,$9D,$A0,$14,$A9,$01,$99             ; 0F829E ????????
.byte $5E,$17,$22,$F1,$AE,$00,$60                 ; 0F82A7 ^?"???`


L_F82AD:
  PHP                                             ; 0F82AD 08 
  STA TEST                                        ; 0F82AE 85 F0 
  STY $EE                                         ; 0F82B0 84 EE 
B_F82B2:
  LDA APUIO0                                      ; 0F82B2 AD 40 21 
.a8
  CMP #$AA                                        ; 0F82B5 C9 AA 
  BNE B_F82B2                                     ; 0F82B7 D0 F9 
  LDA APUIO1                                      ; 0F82B9 AD 41 21 
  CMP #$BB                                        ; 0F82BC C9 BB 
  BNE B_F82B2                                     ; 0F82BE D0 F2 
  INC APUIO1                                      ; 0F82C0 EE 41 21 
  LDA #$00                                        ; 0F82C3 A9 00 
  STA APUIO2                                      ; 0F82C5 8D 42 21 
  LDA #$02                                        ; 0F82C8 A9 02 
  STA APUIO3                                      ; 0F82CA 8D 43 21 
  LDA #$CC                                        ; 0F82CD A9 CC 
  STA APUIO0                                      ; 0F82CF 8D 40 21 
  JSR L_8309                                      ; 0F82D2 20 09 83 
  LDY #$0000                                      ; 0F82D5 A0 00 00 
B_F82D8:
  LDA [$EE],Y                                     ; 0F82D8 B7 EE 
  JSR L_8302                                      ; 0F82DA 20 02 83 
  INY                                             ; 0F82DD C8 
  DEX                                             ; 0F82DE CA 
  BNE B_F82D8                                     ; 0F82DF D0 F7 
  STZ APUIO1                                      ; 0F82E1 9C 41 21 
  LDA #$00                                        ; 0F82E4 A9 00 
  STA APUIO2                                      ; 0F82E6 8D 42 21 
  LDA #$02                                        ; 0F82E9 A9 02 
  STA APUIO3                                      ; 0F82EB 8D 43 21 
  TYA                                             ; 0F82EE 98 
  INC                                             ; 0F82EF 1A 
  STA APUIO0                                      ; 0F82F0 8D 40 21 
  LDA #$CA                                        ; 0F82F3 A9 CA 
B_F82F5:
  CMP APUIO1                                      ; 0F82F5 CD 41 21 
  BNE B_F82F5                                     ; 0F82F8 D0 FB 
  STZ APUIO0                                      ; 0F82FA 9C 40 21 
  STZ $1BFF                                       ; 0F82FD 9C FF 1B 
  PLP                                             ; 0F8300 28 
  RTL                                             ; 0F8301 6B 
  STA APUIO1                                      ; 0F8302 8D 41 21 
  TYA                                             ; 0F8305 98 
  STA APUIO0                                      ; 0F8306 8D 40 21 
B_F8309:
  CMP APUIO0                                      ; 0F8309 CD 40 21 
  BNE B_F8309                                     ; 0F830C D0 FB 
  RTS                                             ; 0F830E 60 


L_F830F:
  PHP                                             ; 0F830F 08 
  SEP #$20                                        ; 0F8310 E2 20 
  XBA                                             ; 0F8312 EB 
  LDA $1BFF                                       ; 0F8313 AD FF 1B 
B_F8316:
  CMP APUIO0                                      ; 0F8316 CD 40 21 
  BNE B_F8316                                     ; 0F8319 D0 FB 
  STX APUIO2                                      ; 0F831B 8E 42 21 
  INC                                             ; 0F831E 1A 
  XBA                                             ; 0F831F EB 
  STA APUIO1                                      ; 0F8320 8D 41 21 
  XBA                                             ; 0F8323 EB 
  STA APUIO0                                      ; 0F8324 8D 40 21 
  STA $1BFF                                       ; 0F8327 8D FF 1B 
  PLP                                             ; 0F832A 28 
  RTL                                             ; 0F832B 6B 
  XBA                                             ; 0F832C EB 
  LDA $1BFF                                       ; 0F832D AD FF 1B 
B_F8330:
  CMP APUIO0                                      ; 0F8330 CD 40 21 
  BNE B_F8330                                     ; 0F8333 D0 FB 
  INC                                             ; 0F8335 1A 
  XBA                                             ; 0F8336 EB 
  STA APUIO1                                      ; 0F8337 8D 41 21 
  XBA                                             ; 0F833A EB 
  STA APUIO0                                      ; 0F833B 8D 40 21 
  STA $1BFF                                       ; 0F833E 8D FF 1B 
  RTS                                             ; 0F8341 60 


.byte $AD,$FF,$1B,$CD,$40,$21,$D0,$FB             ; 0F8342 ????@!??
.byte $1A,$8D,$40,$21,$CD,$40,$21,$D0             ; 0F834A ??@!?@!?
.byte $FB,$8D,$FF,$1B,$AD,$41,$21,$60             ; 0F8352 ?????A!`


L_F835A:
  PHP                                             ; 0F835A 08 
  REP #$10                                        ; 0F835B C2 10 
  SEP #$20                                        ; 0F835D E2 20 
  LDY #$F563                                      ; 0F835F A0 63 F5 
  LDA #$01                                        ; 0F8362 A9 01 
  LDX #$07C6                                      ; 0F8364 A2 C6 07 
  JSL f:L_F82AD                                   ; 0F8367 22 AD 82 0F 
  PLP                                             ; 0F836B 28 
  RTL                                             ; 0F836C 6B 

L_F836D:
  PHP                                             ; 0F836D 08 
  REP #$10                                        ; 0F836E C2 10 
  TAX                                             ; 0F8370 AA 
.a16
  LDA f:D_1FFFD,X                                 ; 0F8371 BF FD FF 01 
  STA CONTROL                                     ; 0F8375 85 F1 
  LDA f:D_1FFFE,X                                 ; 0F8377 BF FE FF 01 
  STA DSPADDR                                     ; 0F837B 85 F2 
  LDY #$0000                                      ; 0F837D A0 00 00 
  LDA [CONTROL],Y                                 ; 0F8380 B7 F1 
  STA $EE                                         ; 0F8382 85 EE 
  INY                                             ; 0F8384 C8 
  LDA [CONTROL],Y                                 ; 0F8385 B7 F1 
  STA $EF                                         ; 0F8387 85 EF 
  DEY                                             ; 0F8389 88 
  LDA [$EE],Y                                     ; 0F838A B7 EE 
  DEC                                             ; 0F838C 3A 
  DEC                                             ; 0F838D 3A 
  TAX                                             ; 0F838E AA 
  STA CPUIO4                                      ; 0F838F 85 F7 
  SEP #$20                                        ; 0F8391 E2 20 
.a8
  LDA #$01                                        ; 0F8393 A9 01 
  JSL f:L_F830F                                   ; 0F8395 22 0F 83 0F 
  REP #$20                                        ; 0F8399 C2 20 
  INY                                             ; 0F839B C8 
  INY                                             ; 0F839C C8 
  LDA [$EE],Y                                     ; 0F839D B7 EE 
  JSR L_83F3                                      ; 0F839F 20 F3 83 
B_F83A2:
  INY                                             ; 0F83A2 C8 
  INY                                             ; 0F83A3 C8 
  LDA CPUIO4                                      ; 0F83A4 A5 F7 
  BEQ B_F83CF                                     ; 0F83A6 F0 27 
  LDA [$EE],Y                                     ; 0F83A8 B7 EE 
  BMI B_F83DB                                     ; 0F83AA 30 2F 
  JSR L_83D1                                      ; 0F83AC 20 D1 83 
  INY                                             ; 0F83AF C8 
  INY                                             ; 0F83B0 C8 
  LDA [$EE],Y                                     ; 0F83B1 B7 EE 
  STA CPUIO1                                      ; 0F83B3 85 F4 
  INY                                             ; 0F83B5 C8 
  LDA [$EE],Y                                     ; 0F83B6 B7 EE 
  STA CPUIO2                                      ; 0F83B8 85 F5 
  PHY                                             ; 0F83BA 5A 
  LDY #$0000                                      ; 0F83BB A0 00 00 
  SEP #$20                                        ; 0F83BE E2 20 
B_F83C0:
  LDA [CPUIO1],Y                                  ; 0F83C0 B7 F4 
  JSR L_832C                                      ; 0F83C2 20 2C 83 
  INY                                             ; 0F83C5 C8 
  CPY T0OUT                                       ; 0F83C6 C4 FD 
  BNE B_F83C0                                     ; 0F83C8 D0 F6 
  REP #$20                                        ; 0F83CA C2 20 
  PLY                                             ; 0F83CC 7A 
  BRA B_F83A2                                     ; 0F83CD 80 D3 
B_F83CF:
  PLP                                             ; 0F83CF 28 
  RTL                                             ; 0F83D0 6B 
  STA T0OUT                                       ; 0F83D1 85 FD 
  LDA CPUIO4                                      ; 0F83D3 A5 F7 
  SEC                                             ; 0F83D5 38 
  SBC T0OUT                                       ; 0F83D6 E5 FD 
  STA CPUIO4                                      ; 0F83D8 85 F7 
  RTS                                             ; 0F83DA 60 

B_F83DB:
.a16
  AND #$7FFF                                      ; 0F83DB 29 FF 7F 
  TAX                                             ; 0F83DE AA 
  ASL                                             ; 0F83DF 0A 
  JSR L_83D1                                      ; 0F83E0 20 D1 83 
  INY                                             ; 0F83E3 C8 
  INY                                             ; 0F83E4 C8 
  LDA [$EE],Y                                     ; 0F83E5 B7 EE 
  STA T0OUT                                       ; 0F83E7 85 FD 
B_F83E9:
  LDA T0OUT                                       ; 0F83E9 A5 FD 
  JSR L_83F3                                      ; 0F83EB 20 F3 83 
  DEX                                             ; 0F83EE CA 
  BNE B_F83E9                                     ; 0F83EF D0 F8 
  BRA B_F83A2                                     ; 0F83F1 80 AF 
  PHA                                             ; 0F83F3 48 
  SEP #$20                                        ; 0F83F4 E2 20 
  PLA                                             ; 0F83F6 68 
  JSR L_832C                                      ; 0F83F7 20 2C 83 
  PLA                                             ; 0F83FA 68 
  JSR L_832C                                      ; 0F83FB 20 2C 83 
  REP #$20                                        ; 0F83FE C2 20 
  RTS                                             ; 0F8400 60 


L_F8401:
  PHP                                             ; 0F8401 08 
  BIT #$8000                                      ; 0F8402 89 00 80 
  BEQ B_F847F                                     ; 0F8405 F0 78 
  REP #$10                                        ; 0F8407 C2 10 
  SEP #$20                                        ; 0F8409 E2 20 
  STA T0OUT                                       ; 0F840B 85 FD 
  LDY #$0003                                      ; 0F840D A0 03 00 
  LDA [CONTROL],Y                                 ; 0F8410 B7 F1 
.a8
  CMP #$FF                                        ; 0F8412 C9 FF 
  BEQ B_F847F                                     ; 0F8414 F0 69 
  CMP T0OUT                                       ; 0F8416 C5 FD 
  BEQ B_F8421                                     ; 0F8418 F0 07 
  INY                                             ; 0F841A C8 
  INY                                             ; 0F841B C8 
  INY                                             ; 0F841C C8 
  INY                                             ; 0F841D C8 
  JMP D_8410                                      ; 0F841E 4C 10 84 
B_F8421:
  INY                                             ; 0F8421 C8 
  REP #$20                                        ; 0F8422 C2 20 
  LDA [CONTROL],Y                                 ; 0F8424 B7 F1 
  STA $EE                                         ; 0F8426 85 EE 
  INY                                             ; 0F8428 C8 
  LDA [CONTROL],Y                                 ; 0F8429 B7 F1 
  STA $EF                                         ; 0F842B 85 EF 
  LDY #$0000                                      ; 0F842D A0 00 00 
  LDA [$EE],Y                                     ; 0F8430 B7 EE 
  DEC                                             ; 0F8432 3A 
  DEC                                             ; 0F8433 3A 
  STA CPUIO4                                      ; 0F8434 85 F7 
  INY                                             ; 0F8436 C8 
  INY                                             ; 0F8437 C8 
  LDA [$EE],Y                                     ; 0F8438 B7 EE 
  STA T1TARGET                                    ; 0F843A 85 FB 
B_F843C:
  INY                                             ; 0F843C C8 
  INY                                             ; 0F843D C8 
  LDA CPUIO4                                      ; 0F843E A5 F7 
  BEQ B_F847F                                     ; 0F8440 F0 3D 
  LDA [$EE],Y                                     ; 0F8442 B7 EE 
  BMI B_F8481                                     ; 0F8444 30 3B 
  STA RAMREG2                                     ; 0F8446 85 F9 
  JSR L_83D1                                      ; 0F8448 20 D1 83 
  INY                                             ; 0F844B C8 
  INY                                             ; 0F844C C8 
  LDA [$EE],Y                                     ; 0F844D B7 EE 
  STA CPUIO1                                      ; 0F844F 85 F4 
  INY                                             ; 0F8451 C8 
  LDA [$EE],Y                                     ; 0F8452 B7 EE 
  STA CPUIO2                                      ; 0F8454 85 F5 
  PHY                                             ; 0F8456 5A 
  LDY #$0000                                      ; 0F8457 A0 00 00 
  SEP #$20                                        ; 0F845A E2 20 
  LDA #$10                                        ; 0F845C A9 10 
  LDX T0OUT                                       ; 0F845E A6 FD 
  JSL f:L_F830F                                   ; 0F8460 22 0F 83 0F 
  LDA T1TARGET                                    ; 0F8464 A5 FB 
  JSR L_832C                                      ; 0F8466 20 2C 83 
  LDA T2TARGET                                    ; 0F8469 A5 FC 
  JSR L_832C                                      ; 0F846B 20 2C 83 
B_F846E:
  LDA [CPUIO1],Y                                  ; 0F846E B7 F4 
  JSR L_832C                                      ; 0F8470 20 2C 83 
  INC T1TARGET                                    ; 0F8473 E6 FB 
  INY                                             ; 0F8475 C8 
  CPY RAMREG2                                     ; 0F8476 C4 F9 
  BNE B_F846E                                     ; 0F8478 D0 F4 
  REP #$20                                        ; 0F847A C2 20 
  PLY                                             ; 0F847C 7A 
  BRA B_F843C                                     ; 0F847D 80 BD 
B_F847F:
  PLP                                             ; 0F847F 28 
  RTL                                             ; 0F8480 6B 

B_F8481:
.byte $29,$FF,$7F,$85,$F9,$0A,$48,$20             ; 0F8481 )?????H 
.byte $D1,$83,$FA,$E2,$20,$A9,$10,$22             ; 0F8489 ???? ??"
.byte $0F,$83,$0F,$C2,$20,$A5,$FB,$20             ; 0F8491 ???? ?? 
.byte $F3,$83,$C8,$C8,$B7,$EE,$85,$FD             ; 0F8499 ????????
.byte $A5,$FD,$20,$AC,$84,$C6,$F9,$D0             ; 0F84A1 ?? ?????
.byte $F7,$80,$90,$48,$E2,$20,$68,$20             ; 0F84A9 ???H? h 
.byte $2C,$83,$68,$20,$2C,$83,$C2,$20             ; 0F84B1 ,?h ,?? 
.byte $E6,$FB,$E6,$FB,$60                         ; 0F84BA ????`


L_F84BE:
  PHP                                             ; 0F84BE 08 
  REP #$10                                        ; 0F84BF C2 10 
  SEP #$20                                        ; 0F84C1 E2 20 
  PHA                                             ; 0F84C3 48 
  LDA #$04                                        ; 0F84C4 A9 04 
  LDX #$0000                                      ; 0F84C6 A2 00 00 
  JSL f:L_F830F                                   ; 0F84C9 22 0F 83 0F 
  PLA                                             ; 0F84CD 68 
  BEQ B_F84EA                                     ; 0F84CE F0 1A 
  REP #$20                                        ; 0F84D0 C2 20 
.a16
  AND #$00FF                                      ; 0F84D2 29 FF 00 
  PHA                                             ; 0F84D5 48 
  EOR #$FFFF                                      ; 0F84D6 49 FF FF 
  CLC                                             ; 0F84D9 18 
  ADC #$8100                                      ; 0F84DA 69 00 81 
  JSL f:L_F8401                                   ; 0F84DD 22 01 84 0F 
  PLX                                             ; 0F84E1 FA 
  SEP #$20                                        ; 0F84E2 E2 20 
.a8
  LDA #$04                                        ; 0F84E4 A9 04 
  JSL f:L_F830F                                   ; 0F84E6 22 0F 83 0F 
B_F84EA:
  PLP                                             ; 0F84EA 28 
  RTL                                             ; 0F84EB 6B 

L_F84EC:
  PHP                                             ; 0F84EC 08 
  REP #$10                                        ; 0F84ED C2 10 
  SEP #$20                                        ; 0F84EF E2 20 
  PHA                                             ; 0F84F1 48 
  LDA #$04                                        ; 0F84F2 A9 04 
  LDX #$0000                                      ; 0F84F4 A2 00 00 
  JSL f:L_F830F                                   ; 0F84F7 22 0F 83 0F 
  PLA                                             ; 0F84FB 68 
  BEQ B_F851C                                     ; 0F84FC F0 1E 
  REP #$20                                        ; 0F84FE C2 20 
.a16
  AND #$00FF                                      ; 0F8500 29 FF 00 
  PHA                                             ; 0F8503 48 
  EOR #$FFFF                                      ; 0F8504 49 FF FF 
  CLC                                             ; 0F8507 18 
  ADC #$8100                                      ; 0F8508 69 00 81 
  JSL f:L_F8401                                   ; 0F850B 22 01 84 0F 
  PLA                                             ; 0F850F 68 
  ORA #$0100                                      ; 0F8510 09 00 01 
  TAX                                             ; 0F8513 AA 
  SEP #$20                                        ; 0F8514 E2 20 
.a8
  LDA #$04                                        ; 0F8516 A9 04 
  JSL f:L_F830F                                   ; 0F8518 22 0F 83 0F 
B_F851C:
  PLP                                             ; 0F851C 28 
  RTL                                             ; 0F851D 6B 

.byte $80,$13,$9D,$09,$00,$00,$00,$0E             ; 0F851E ????????
.byte $0C,$2A,$31,$0D,$34,$34,$C8,$02             ; 0F8526 ?*1?44??
.byte $0E,$1F,$3F,$7B,$7F,$FF,$FF,$80             ; 0F852E ???{????
.byte $40,$60,$80,$80,$70,$C0,$E0,$E0             ; 0F8536 @`??p???
.byte $F0,$F0,$03,$00,$02,$01,$03,$00             ; 0F853E ????????
.byte $07,$78,$77,$E0,$1F,$47,$38,$DF             ; 0F8546 ?xw??G8?
.byte $A0,$01,$01,$03,$03,$07,$07,$0F             ; 0F854E ????????
.byte $0F,$0F,$7F,$7F,$7F,$FF,$4D,$81             ; 0F8556 ??????M?
.byte $9E,$E0,$1F,$E8,$4F,$B4,$E7,$1A             ; 0F855E ????O???
.byte $22,$CD,$9D,$6A,$CC,$35,$FE,$FF             ; 0F8566 "??j?5??
.byte $FF,$FF,$F7,$FF,$FB,$FF,$FD,$FF             ; 0F856E ????????
.byte $FE,$24,$1C,$5E,$C2,$2E,$62,$92             ; 0F8576 ?$?^?.b?
.byte $32,$CE,$1E,$64,$0C,$04,$8C,$24             ; 0F857E 2??d???$
.byte $6C,$F8,$FC,$3C,$FE,$9C,$FE,$CC             ; 0F8586 l??<????
.byte $FE,$E0,$FE,$F0,$FC,$70,$FC,$90             ; 0F858E ?????p??
.byte $FC,$3F,$00,$FF,$FF,$04,$04,$04             ; 0F8596 ????????
.byte $00,$04,$00,$04,$08,$00,$00,$08             ; 0F859E ????????
.byte $04,$0C,$05,$0D,$03,$1F,$21,$1F             ; 0F85A6 ??????!?
.byte $00,$07,$0A,$00,$18,$00,$3C,$00             ; 0F85AE ??????<?
.byte $FC,$80,$BD,$81,$9F,$87,$6F,$6F             ; 0F85B6 ??????oo
.byte $FF,$FF,$DE,$FF,$CF,$FF,$83,$7E             ; 0F85BE ???????~
.byte $7F,$78,$7F,$90,$7F,$1F,$00,$0F             ; 0F85C6 ?x??????
.byte $00,$03,$66,$1B,$F7,$CA,$7E,$62             ; 0F85CE ??f???~b
.byte $C5,$C7,$1F,$FF,$9F,$FF,$FC,$F8             ; 0F85D6 ????????
.byte $FC,$E0,$FD,$FF,$3D,$FF,$9D,$FF             ; 0F85DE ????=???
.byte $38,$FE,$03,$F8,$03,$E0,$27,$B4             ; 0F85E6 8?????'?
.byte $97,$34,$2F,$68,$AC,$E3,$F8,$77             ; 0F85EE ?4/h???w
.byte $F7,$F8,$EE,$E6,$2B,$23,$C8,$FC             ; 0F85F6 ????+#??
.byte $C8,$FC,$90,$F8,$10,$F0,$80,$B0             ; 0F85FE ????????
.byte $00,$10,$11,$00,$D4,$00,$F6,$09             ; 0F8606 ????????
.byte $EB,$15,$67,$9B,$04,$FF,$D4,$EF             ; 0F860E ??g?????
.byte $F8,$06,$F0,$0E,$30,$2E,$07,$E7             ; 0F8616 ????0.??
.byte $07,$C7,$07,$E8,$FF,$60,$FF,$40             ; 0F861E ?????`?@
.byte $C3,$1E,$80,$37,$48,$35,$80,$6A             ; 0F8626 ???7H5?j
.byte $EF,$EF,$FF,$F7,$F7,$F7,$F7,$01             ; 0F862E ????????
.byte $01,$12,$12,$28,$20,$22,$2C,$0D             ; 0F8636 ???( ",?
.byte $1F,$1F,$3F,$1F,$3F,$E0,$60,$F0             ; 0F863E ??????`?
.byte $30,$F8,$08,$AE,$9A,$E0,$C0,$F0             ; 0F8646 0???????
.byte $F0,$F8,$7C,$FE,$03,$08,$07,$1F             ; 0F864E ??|?????
.byte $0F,$37,$07,$4F,$3F,$C9,$79,$28             ; 0F8656 ?7?O??y(
.byte $B8,$28,$00,$70,$00,$F6,$00,$B7             ; 0F865E ?(?p????
.byte $40,$0F,$F0,$0C,$F3,$E8,$F7,$E7             ; 0F8666 @???????
.byte $E8,$EE,$E6,$EB,$E3,$10,$00,$11             ; 0F866E ????????
.byte $00,$14,$17,$29,$19,$48,$38,$08             ; 0F8676 ???)?H8?
.byte $36,$00,$77,$0F,$1F,$00,$3F,$03             ; 0F867E 6?w?????
.byte $2C,$43,$0C,$05,$4A,$16,$59,$34             ; 0F8686 ,C??J?Y4
.byte $7B,$2C,$73,$08,$77,$3E,$00,$2F             ; 0F868E {,s?w>?/
.byte $10,$4F,$30,$4F,$30,$5F,$20,$7F             ; 0F8696 ?O0O0_ ?
.byte $00,$7F,$00,$7F,$00,$87,$F8,$03             ; 0F869E ????????
.byte $FC,$87,$78,$EB,$14,$DF,$20,$00             ; 0F86A6 ??x??? ?
.byte $FF,$0F,$FF,$1D,$FD,$00,$C0,$00             ; 0F86AE ????????
.byte $FD,$02,$F8,$00,$F8,$00,$F4,$0C             ; 0F86B6 ????????
.byte $E2,$16,$C1,$33,$05,$F0,$04,$F0             ; 0F86BE ???3????
.byte $D6,$F0,$0B,$00,$11,$08,$F0,$0C             ; 0F86C6 ????????
.byte $F0,$0E,$F0,$0F,$F0,$0F,$02,$0A             ; 0F86CE ????????
.byte $0A,$0D,$40,$40,$81,$FE,$F5,$00             ; 0F86D6 ??@@????
.byte $F0,$FF,$00,$3F,$80,$C0,$00,$30             ; 0F86DE ???????0
.byte $2F,$A8,$5E,$CC,$0F,$CF,$0E,$CF             ; 0F86E6 /?^?????
.byte $0F,$FF,$07,$FF,$03,$FF,$03,$C7             ; 0F86EE ????????
.byte $F1,$01,$F0,$F8,$00,$FC,$00,$FC             ; 0F86F6 ????????
.byte $00,$E1,$20,$24,$00,$87,$00,$00             ; 0F86FE ?? $????
.byte $E7,$80,$7F,$F7,$08,$7F,$A8,$7F             ; 0F8706 ????????
.byte $80,$1F,$1F,$7F,$7F,$08,$01,$03             ; 0F870E ????????
.byte $03,$02,$02,$01,$03,$03,$01,$03             ; 0F8716 ????????
.byte $01,$03,$FB,$F6,$ED,$0B,$3E,$CD             ; 0F871E ??????>?
.byte $97,$66,$AB,$93,$75,$69,$DB,$14             ; 0F8726 ?f??ui??
.byte $FD,$1A,$0F,$F3,$FF,$F9,$FF,$7C             ; 0F872E ???????|
.byte $FF,$9E,$FF,$EF,$FF,$E7,$FF,$D5             ; 0F8736 ????????
.byte $CF,$E8,$67,$FF,$B0,$73,$D1,$DF             ; 0F873E ??g??s??
.byte $2F,$8D,$8F,$FD,$FF,$3C,$3F,$3E             ; 0F8746 /????<?>
.byte $CF,$FF,$EE,$FF,$F0,$FF,$70,$C0             ; 0F874E ??????p?
.byte $FF,$86,$81,$C0,$FF,$38,$3F,$FF             ; 0F8756 ?????8??
.byte $BF,$EC,$BC,$B9,$B8,$F3,$F0,$F7             ; 0F875E ????????
.byte $F0,$07,$80,$1F,$E0,$DF,$E0,$5F             ; 0F8766 ???????_
.byte $E0,$5C,$E3,$58,$E7,$10,$EF,$10             ; 0F876E ?\?X????
.byte $EF,$E0,$F0,$08,$F8,$04,$FC,$E2             ; 0F8776 ????????
.byte $FE,$31,$3F,$89,$0E,$CC,$0F,$C4             ; 0F877E ?1??????
.byte $07,$FF,$00,$F7,$00,$F3,$00,$F9             ; 0F8786 ????????
.byte $00,$3C,$C0,$07,$F8,$22,$2A,$C0             ; 0F878E ?<???"*?
.byte $01,$FE,$D5,$BF,$00,$01,$05,$03             ; 0F8796 ????????
.byte $02,$0E,$01,$18,$09,$39,$50,$33             ; 0F879E ?????9P3
.byte $28,$6F,$51,$DF,$01,$07,$39,$06             ; 0F87A6 (oQ???9?
.byte $73,$0C,$6F,$10,$F0,$88,$F8,$C4             ; 0F87AE s?o?????
.byte $FC,$82,$BE,$C1,$FF,$01,$FE,$78             ; 0F87B6 ???????x
.byte $FF,$8C,$8F,$B9,$40,$FC,$00,$FE             ; 0F87BE ????@???
.byte $8F,$02,$01,$00,$02,$02,$06,$04             ; 0F87C6 ????????
.byte $0C,$02,$1E,$01,$06,$01,$0C,$03             ; 0F87CE ????????
.byte $1E,$01,$80,$70,$9C,$02,$3E,$01             ; 0F87D6 ???p??>?
.byte $1F,$81,$1E,$00,$1F,$1C,$7F,$93             ; 0F87DE ????????
.byte $60,$39,$C0,$1C,$E0,$1E,$E0,$1F             ; 0F87E6 `9??????
.byte $E0,$7F,$80,$04,$7B,$08,$77,$44             ; 0F87EE ????{?wD
.byte $3B,$4A,$35,$2D,$12,$2A,$15,$0D             ; 0F87F6 ;J5-?*??
.byte $12,$12,$0D,$1F,$00,$39,$F9,$31             ; 0F87FE ?????9?1
.byte $F1,$32,$F3,$3E,$FF,$0C,$FF,$81             ; 0F8806 ?2?>????
.byte $7E,$02,$FD,$D8,$27,$F9,$06,$F1             ; 0F880E ~???'???
.byte $0E,$F3,$0C,$FF,$00,$86,$E0,$06             ; 0F8816 ????????
.byte $E0,$20,$E0,$11,$F1,$86,$7F,$00             ; 0F881E ? ??????
.byte $FF,$80,$7F,$2E,$D1,$1F,$E0,$1F             ; 0F8826 ???.????
.byte $F1,$0E,$80,$FF,$80,$FF,$82,$FE             ; 0F882E ????????
.byte $04,$FC,$04,$FC,$6C,$9C,$EE,$1E             ; 0F8836 ????l???
.byte $76,$8E,$01,$FC,$03,$FC,$03,$FC             ; 0F883E v???????
.byte $03,$FE,$01,$FE,$01,$7F,$81,$BF             ; 0F8846 ????????
.byte $C1,$FF,$C0,$7F,$40,$BF,$23,$7F             ; 0F884E ????@?#?
.byte $B3,$5F,$91,$2F,$CC,$7E,$00,$BE             ; 0F8856 ?_?/?~??
.byte $7F,$80,$1C,$C0,$2C,$C0,$1E,$E0             ; 0F885E ????,???
.byte $0B,$F0,$7F,$80,$7F,$80,$40,$80             ; 0F8866 ??????@?
.byte $A0,$DF,$BF,$C0,$BF,$C0,$F0,$C0             ; 0F886E ????????
.byte $FF,$C0,$3F,$3F,$3F,$1F,$1F,$1F             ; 0F8876 ????????
.byte $0F,$0F,$07,$07,$03,$7F,$0C,$BE             ; 0F887E ????????
.byte $86,$7E,$E3,$BF,$F3,$E7,$7F,$FE             ; 0F8886 ?~??????
.byte $BF,$61,$FF,$42,$3D,$F3,$FF,$79             ; 0F888E ?a?B=??y
.byte $FF,$1C,$80,$FF,$40,$7F,$00,$AA             ; 0F8896 ????@???
.byte $3F,$67,$7E,$EE,$F9,$09,$F6,$12             ; 0F889E ?g~?????
.byte $FD,$FC,$E3,$EB,$97,$F6,$0F,$C0             ; 0F88A6 ????????
.byte $FF,$80,$FE,$F0,$01,$F0,$03,$E0             ; 0F88AE ????????
.byte $07,$80,$0F,$00,$C7,$C0,$67,$C0             ; 0F88B6 ??????g?
.byte $80,$60,$10,$F0,$1F,$07,$F8,$20             ; 0F88BE ?`????? 
.byte $FF,$20,$7F,$60,$1F,$F0,$0F,$98             ; 0F88C6 ? ?`????
.byte $1F,$30,$3F,$60,$7F,$C1,$FE,$87             ; 0F88CE ?0?`????
.byte $F8,$1F,$E0,$3F,$C0,$FF,$00,$7F             ; 0F88D6 ????????
.byte $80,$02,$84,$7C,$CC,$3C,$CE,$3E             ; 0F88DE ???|?<?>
.byte $86,$7E,$04,$1F,$00,$3F,$0E,$7F             ; 0F88E6 ?~??????
.byte $17,$F7,$23,$07,$F7,$08,$E3,$1C             ; 0F88EE ??#?????
.byte $1C,$FC,$3B,$F8,$77,$F0,$67,$E0             ; 0F88F6 ??;?w?g?
.byte $33,$F0,$19,$F8,$08,$F8,$FF,$00             ; 0F88FE 3???????
.byte $FC,$03,$F8,$07,$F0,$0F,$E0,$F8             ; 0F8906 ????????
.byte $07,$F8,$E7,$07,$F3,$03,$F3,$03             ; 0F890E ????????
.byte $F2,$03,$F6,$07,$CC,$0F,$70,$7F             ; 0F8916 ??????p?
.byte $FC,$07,$F8,$0F,$80,$0C,$FC,$4E             ; 0F891E ???????N
.byte $BE,$C6,$3E,$27,$1F,$03,$3F,$41             ; 0F8926 ??>'???A
.byte $3F,$03,$7F,$82,$7E,$24,$FC,$44             ; 0F892E ????~$?D
.byte $FC,$C4,$FC,$7F,$FF,$E0,$E0,$8C             ; 0F8936 ????????
.byte $80,$3E,$00,$7E,$F9,$01,$73,$03             ; 0F893E ?>?~??s?
.byte $FF,$00,$E0,$1F,$80,$01,$FE,$03             ; 0F8946 ????????
.byte $FC,$42,$7E,$44,$7C,$44,$7C,$4C             ; 0F894E ?B~D|D|L
.byte $7C,$8E,$FE,$46,$BE,$7E,$81,$7C             ; 0F8956 |??F?~?|
.byte $83,$7C,$83,$7C,$83,$0F,$00,$0F             ; 0F895E ?|?|????
.byte $08,$07,$74,$8B,$68,$97,$30,$CF             ; 0F8966 ??t?h?0?
.byte $46,$81,$00,$C7,$14,$EB,$01,$FE             ; 0F896E F???????
.byte $02,$FC,$0C,$B6,$0E,$36,$0E,$06             ; 0F8976 ?????6??
.byte $1E,$03,$0F,$03,$0F,$01,$0F,$0C             ; 0F897E ????????
.byte $03,$0E,$01,$BE,$01,$3E,$01,$1E             ; 0F8986 ?????>??
.byte $01,$77,$E6,$5F,$E6,$0B,$F3,$C5             ; 0F898E ?w?_????
.byte $39,$E2,$1C,$71,$0E,$9F,$80,$CF             ; 0F8996 9??q????
.byte $C0,$05,$02,$FC,$01,$C0,$3F,$DF             ; 0F899E ????????
.byte $E0,$47,$7D,$83,$3D,$C3,$BD,$7F             ; 0F89A6 ?G}?=???
.byte $9E,$1F,$E8,$40,$E0,$08,$F0,$07             ; 0F89AE ???@????
.byte $20,$C0,$3F,$E0,$1F,$F8,$0F,$F0             ; 0F89B6  ???????
.byte $3F,$C0,$7C,$80,$F8,$FC,$E0,$46             ; 0F89BE ??|????F
.byte $3E,$46,$3E,$26,$1E,$03,$1F,$7E             ; 0F89C6 >F>&???~
.byte $01,$7E,$03,$0B,$07,$0B,$07,$1B             ; 0F89CE ?~??????
.byte $07,$13,$0F,$33,$0F,$72,$0E,$75             ; 0F89D6 ???3?r?u
.byte $0C,$20,$28,$18,$1C,$08,$0F,$1C             ; 0F89DE ? (?????
.byte $1F,$38,$3F,$F4,$FF,$0C,$F3,$8F             ; 0F89E6 ?8??????
.byte $70,$D0,$07,$E0,$03,$F0,$FC,$FC             ; 0F89EE p???????
.byte $FF,$00,$F2,$7D,$79,$FE,$31,$FE             ; 0F89F6 ???}y?1?
.byte $12,$FC,$84,$78,$80,$C1,$0E,$F0             ; 0F89FE ???x????
.byte $38,$C0,$F8,$E6,$1E,$26,$1E,$13             ; 0F8A06 8????&??
.byte $FE,$09,$07,$17,$0F,$0E,$1E,$3C             ; 0F8A0E ???????<
.byte $1C,$10,$30,$52,$30,$1F,$00,$1E             ; 0F8A16 ??0R0???
.byte $01,$3C,$03,$30,$0F,$70,$0F,$C4             ; 0F8A1E ?<?0?p??
.byte $FC,$C6,$FE,$47,$7F,$43,$7F,$20             ; 0F8A26 ???G?C? 
.byte $3F,$C0,$3F,$C0,$06,$07,$0C,$0F             ; 0F8A2E ????????
.byte $19,$1E,$F3,$FC,$E5,$FA,$09,$F6             ; 0F8A36 ????????
.byte $02,$FC,$04,$0F,$F0,$1F,$E0,$C6             ; 0F8A3E ????????
.byte $3E,$E6,$1E,$C6,$3E,$E3,$1F,$43             ; 0F8A46 >???>??C
.byte $3F,$21,$1F,$2C,$13,$1E,$0B,$04             ; 0F8A4E ?!?,????
.byte $0B,$04,$0D,$02,$E0,$E0,$3F,$C1             ; 0F8A56 ????????
.byte $41,$F2,$33,$BF,$41,$E0,$40,$3E             ; 0F8A5E A?3?A?@>
.byte $30,$0C,$0C,$00,$13,$1F,$E7,$FE             ; 0F8A66 0???????
.byte $2F,$FC,$DF,$F0,$BF,$C0,$DF,$C0             ; 0F8A6E /???????
.byte $EF,$8C,$DF,$90,$10,$E0,$E1,$00             ; 0F8A76 ????????
.byte $C3,$00,$CF,$70,$00,$67,$07,$79             ; 0F8A7E ???p?g?y
.byte $08,$73,$10,$77,$10,$77,$10,$37             ; 0F8A86 ?s?w?w?7
.byte $10,$37,$30,$33,$30,$3B,$38,$1F             ; 0F8A8E ?7030;8?
.byte $0F,$1F,$0F,$3F,$0F,$3F,$07,$3F             ; 0F8A96 ????????
.byte $A3,$7F,$9E,$61,$ED,$3C,$F3,$36             ; 0F8A9E ???a?<?6
.byte $FD,$17,$F5,$0B,$D9,$C6,$EC,$E3             ; 0F8AA6 ????????
.byte $F8,$FF,$FC,$FF,$3F,$FF,$1F,$FF             ; 0F8AAE ????????
.byte $F8,$00,$78,$80,$70,$80,$C0,$C0             ; 0F8AB6 ??x?p???
.byte $C0,$C0,$80,$00,$00,$27,$60,$A7             ; 0F8ABE ?????'`?
.byte $60,$22,$E0,$39,$F9,$10,$D0,$30             ; 0F8AC6 `"?9???0
.byte $F0,$70,$F0,$70,$F0,$60,$E6,$00             ; 0F8ACE ?p?p?`??
.byte $CF,$20,$8F,$27,$3F,$3A,$3B,$06             ; 0F8AD6 ? ?'?:;?
.byte $03,$C4,$C1,$60,$61,$F2,$F3,$FA             ; 0F8ADE ???`a???
.byte $FB,$C0,$3B,$C4,$03,$FC,$01,$3E             ; 0F8AE6 ??;????>
.byte $81,$1E,$03,$0C,$03,$18,$E0,$E0             ; 0F8AEE ????????
.byte $00,$60,$40,$BF,$5D,$7E,$1D,$3E             ; 0F8AF6 ?`@?]~?>
.byte $1D,$08,$08,$EF,$F0,$FF,$F0,$7F             ; 0F8AFE ????????
.byte $F0,$B8,$77,$9C,$7B,$EF,$1E,$7C             ; 0F8B06 ??w?{??|
.byte $81,$80,$40,$39,$38,$39,$38,$17             ; 0F8B0E ??@9898?
.byte $27,$1E,$13,$0D,$19,$06,$0E,$07             ; 0F8B16 '???????
.byte $18,$3F,$0C,$1F,$06,$1F,$4F,$60             ; 0F8B1E ??????O`
.byte $23,$38,$19,$2F,$DB,$C3,$34,$F1             ; 0F8B26 #8?/??4?
.byte $0C,$3C,$F0,$F8,$00,$00,$9F,$FF             ; 0F8B2E ?<??????
.byte $C7,$3C,$FF,$0E,$FF,$C0,$80,$70             ; 0F8B36 ?<?????p
.byte $F0,$79,$F9,$7F,$F0,$7E,$E1,$7C             ; 0F8B3E ?y???~?|
.byte $E3,$FC,$E3,$FC,$E3,$FE,$C1,$0F             ; 0F8B46 ????????
.byte $00,$06,$00,$0F,$1F,$1F,$7F,$1F             ; 0F8B4E ????????
.byte $1F,$FD,$FE,$F9,$FE,$FC,$0E,$7C             ; 0F8B56 ???????|
.byte $86,$1E,$E2,$1F,$E0,$79,$86,$FD             ; 0F8B5E ?????y??
.byte $02,$F0,$FD,$FF,$00,$C0,$40,$CF             ; 0F8B66 ??????@?
.byte $C0,$5F,$50,$77,$50,$5E,$4E,$72             ; 0F8B6E ?_PwP^Nr
.byte $43,$71,$50,$2A,$6E,$15,$37,$3F             ; 0F8B76 CqP*n?7?
.byte $FF,$2F,$7F,$2F,$7F,$31,$7F,$3C             ; 0F8B7E ?/?/?1?<
.byte $11,$7F,$08,$3F,$72,$91,$75,$8C             ; 0F8B86 ????r?u?
.byte $3A,$CE,$E6,$18,$71,$0E,$5C,$C3             ; 0F8B8E :???q?\?
.byte $93,$30,$52,$1B,$EF,$F1,$3F,$E4             ; 0F8B96 ?0R?????
.byte $FF,$A0,$20,$A0,$20,$00,$20,$C0             ; 0F8B9E ?? ? ? ?
.byte $E0,$C0,$E0,$0C,$1D,$07,$02,$78             ; 0F8BA6 ???????x
.byte $F8,$A0,$09,$19,$08,$16,$00,$37             ; 0F8BAE ???????7
.byte $00,$20,$70,$48,$58,$44,$DC,$02             ; 0F8BB6 ? pHXD??
.byte $9E,$21,$BF,$61,$FE,$20,$DF,$40             ; 0F8BBE ?!?a? ?@
.byte $BF,$7F,$00,$57,$20,$D3,$20,$99             ; 0F8BC6 ???W ? ?
.byte $60,$BC,$40,$01,$04,$09,$0A,$1E             ; 0F8BCE `?@?????
.byte $0E,$06,$0A,$05,$0A,$05,$1E,$01             ; 0F8BD6 ????????
.byte $1E,$FF,$BF,$FF,$C3,$43,$99,$81             ; 0F8BDE ?????C??
.byte $3D,$01,$7D,$01,$7D,$01,$F9,$FF             ; 0F8BE6 =?}?}???
.byte $00,$43,$BC,$81,$7E,$02,$FE,$84             ; 0F8BEE ?C??~???
.byte $FC,$84,$FC,$8C,$FC,$8E,$FE,$96             ; 0F8BF6 ????????
.byte $EE,$16,$1E,$00,$1E,$00,$1E,$3A             ; 0F8BFE ???????:
.byte $0E,$1A,$72,$1D,$87,$B8,$87,$78             ; 0F8C06 ??r????x
.byte $0F,$3E,$01,$72,$0D,$87,$78,$F0             ; 0F8C0E ?>?r??x?
.byte $FB,$67,$07,$0E,$0F,$3C,$3F,$F8             ; 0F8C16 ?g???<??
.byte $FF,$E1,$96,$EE,$16,$EE,$36,$CE             ; 0F8C1E ??????6?
.byte $33,$CF,$73,$8F,$D1,$2F,$8C,$63             ; 0F8C26 3?s??/?c
.byte $2E,$C1,$EF,$00,$EF,$03,$00,$03             ; 0F8C2E .???????
.byte $78,$0F,$7C,$0F,$76,$07,$72,$03             ; 0F8C36 x?|?v?r?
.byte $62,$03,$62,$03,$72,$03,$72,$03             ; 0F8C3E b?b?r?r?
.byte $02,$FD,$84,$7B,$EF,$10,$7E,$80             ; 0F8C46 ???{??~?
.byte $7C,$80,$60,$90,$50,$A0,$A0,$E0             ; 0F8C4E |?`?P???
.byte $00,$0B,$C4,$8B,$CF,$00,$06,$01             ; 0F8C56 ????????
.byte $0F,$0E,$1F,$1D,$35,$3C,$20,$3E             ; 0F8C5E ????5< >
.byte $02,$3B,$25,$02,$03,$08,$01,$18             ; 0F8C66 ?;%?????
.byte $0A,$38,$1F,$3C,$3D,$3C,$1E,$3E             ; 0F8C6E ?8?<=<?>
.byte $64,$07,$08,$0F,$10,$01,$FE,$83             ; 0F8C76 d???????
.byte $FC,$39,$3E,$10,$1F,$7F,$E0,$00             ; 0F8C7E ?9>?????
.byte $20,$32,$2D,$04,$2B,$08,$27,$11             ; 0F8C86  2-?+?'?
.byte $1E,$13,$1C,$1D,$10,$03,$0E,$03             ; 0F8C8E ????????
.byte $06,$1F,$3F,$01,$0F,$01,$07,$91             ; 0F8C96 ????????
.byte $1E,$BD,$01,$4E,$30,$87,$70,$1F             ; 0F8C9E ???N0?p?
.byte $E8,$36,$C8,$75,$99,$EA,$1B,$E0             ; 0F8CA6 ?6?u????
.byte $C0,$F7,$FF,$E6,$80,$A0,$20,$01             ; 0F8CAE ?????? ?
.byte $E4,$3E,$65,$F0,$AA,$00,$55,$00             ; 0F8CB6 ?>e???U?
.byte $2A,$FE,$A0,$03,$03,$0D,$07,$02             ; 0F8CBE *???????
.byte $A8,$57,$01,$7C,$03,$68,$57,$07             ; 0F8CC6 ?W?|?hW?
.byte $F8,$7F,$B6,$2F,$C3,$41,$00,$34             ; 0F8CCE ???/?A?4
.byte $0F,$38,$38,$73,$70,$76,$71,$F2             ; 0F8CD6 ?88spvq?
.byte $F1,$FB,$1F,$07,$3F,$0F,$7F,$0F             ; 0F8CDE ????????
.byte $7F,$10,$10,$61,$61,$F9,$F9,$08             ; 0F8CE6 ???aa???
.byte $0C,$48,$8C,$AC,$49,$68,$8D,$C4             ; 0F8CEE ?H??Ih??
.byte $01,$0F,$3F,$1E,$FF,$F1,$7E,$F1             ; 0F8CF6 ??????~?
.byte $9C,$06,$76,$1E,$37,$FF,$FF,$9C             ; 0F8CFE ??v?7???
.byte $76,$89,$37,$C8,$8A,$FF,$D5,$FF             ; 0F8D06 v?7?????
.byte $FB,$07,$02,$0B,$09,$05,$01,$16             ; 0F8D0E ????????
.byte $EA,$3A,$CD,$2F,$D0,$EF,$10,$7B             ; 0F8D16 ?:?/???{
.byte $80,$DF,$00,$DF,$80,$E1,$0E,$D5             ; 0F8D1E ????????
.byte $C0,$D0,$C0,$EF,$E0,$CF,$EF,$E0             ; 0F8D26 ????????
.byte $7F,$70,$30,$30,$07,$03,$01,$00             ; 0F8D2E ?p00????
.byte $38,$78,$F6,$7E,$F3,$FF,$B1,$DF             ; 0F8D36 8x?~????
.byte $79,$87,$D0,$AF,$99,$FE,$AB,$7C             ; 0F8D3E y??????|
.byte $47,$BF,$81,$FF,$60,$9F,$C0,$A0             ; 0F8D46 G???`???
.byte $5F,$B0,$CF,$70,$8F,$02,$04,$14             ; 0F8D4E _??p????
.byte $1A,$2E,$33,$DF,$E7,$7C,$8C,$FF             ; 0F8D56 ?.3??|??
.byte $37,$BB,$3B,$DD,$43,$FA,$FF,$E0             ; 0F8D5E 7?;?C???
.byte $37,$FF,$7F,$BB,$60,$DC,$7F,$FE             ; 0F8D66 7???`???
.byte $7F,$F4,$FF,$F8,$FA,$F4,$C3,$F1             ; 0F8D6E ????????
.byte $F8,$5C,$E0,$1E,$1E,$34,$34,$F8             ; 0F8D76 ?\???44?
.byte $78,$05,$CC,$F0,$E7,$E0,$03,$00             ; 0F8D7E x???????
.byte $1F,$0C,$3E,$19,$3C,$10,$00,$21             ; 0F8D86 ??>?<??!
.byte $01,$23,$23,$06,$06,$7F,$BF,$FF             ; 0F8D8E ?##?????
.byte $9D,$FC,$9B,$F8,$5B,$78,$03,$30             ; 0F8D96 ????[x?0
.byte $01,$10,$09,$08,$C0,$FC,$83,$F8             ; 0F8D9E ????????
.byte $C7,$78,$47,$30,$0F,$10,$10,$03             ; 0F8DA6 ?xG0????
.byte $21,$06,$23,$3F,$1C,$00,$38,$01             ; 0F8DAE !?#???8?
.byte $23,$03,$83,$80,$8B,$C0,$8F,$68             ; 0F8DB6 #??????h
.byte $1F,$F8,$5E,$F9,$4E,$39,$4F,$78             ; 0F8DBE ??^?N9Ox
.byte $2F,$68,$69,$97,$78,$87,$F8,$07             ; 0F8DC6 /hi?x???
.byte $38,$47,$78,$07,$68,$07,$FF,$7C             ; 0F8DCE 8Gx?h??|
.byte $FE,$7E,$FE,$79,$1F,$18,$9F,$0D             ; 0F8DD6 ?~?y????
.byte $EE,$97,$AF,$93,$0C,$81,$13,$90             ; 0F8DDE ????????
.byte $7D,$FC,$40,$C0,$E4,$00,$73,$81             ; 0F8DE6 }?@???s?
.byte $79,$F7,$7C,$F3,$7D,$FE,$FE,$7E             ; 0F8DEE y?|?}??~
.byte $F0,$3E,$FF,$80,$C0,$E0,$FE,$CE             ; 0F8DF6 ?>??????
.byte $70,$FC,$82,$FF,$7E,$E1,$20,$71             ; 0F8DFE p???~? q
.byte $00,$7B,$E1,$E0,$81,$00,$7D,$00             ; 0F8E06 ?{????}?
.byte $09,$08,$09,$08,$09,$08,$0C,$0C             ; 0F8E0E ????????
.byte $0C,$0C,$0E,$0E,$08,$07,$08,$07             ; 0F8E16 ????????
.byte $08,$07,$0C,$0E,$2E,$29,$0E,$09             ; 0F8E1E ????.)??
.byte $07,$06,$0F,$0E,$0F,$0F,$28,$06             ; 0F8E26 ??????(?
.byte $05,$0F,$80,$83,$60,$E3,$7E,$FF             ; 0F8E2E ????`?~?
.byte $1C,$ED,$C8,$32,$8C,$37,$E4,$1F             ; 0F8E36 ???2?7??
.byte $FF,$81,$7F,$FC,$1F,$71,$9F,$42             ; 0F8E3E ?????q?B
.byte $FD,$73,$CC,$3B,$E6,$8E,$FF,$FC             ; 0F8E46 ?s?;????
.byte $E0,$F0,$FE,$E6,$78,$FE,$04,$6F             ; 0F8E4E ????x??o
.byte $00,$C4,$C2,$FF,$FC,$7F,$03,$9F             ; 0F8E56 ????????
.byte $80,$F1,$F0,$01,$00,$85,$04,$F3             ; 0F8E5E ????????
.byte $00,$BD,$80,$FD,$FC,$FC,$00,$04             ; 0F8E66 ????????
.byte $0F,$04,$0F,$81,$00,$0C,$03,$05             ; 0F8E6E ????????
.byte $0E,$9F,$80,$F0,$F0,$FF,$FF,$E9             ; 0F8E76 ????????
.byte $9B,$C0,$81,$FF,$80,$77,$8B,$6D             ; 0F8E7E ?????w?m
.byte $D3,$81,$FF,$3F,$87,$7F,$BF,$FF             ; 0F8E86 ????????
.byte $8F,$FD,$FC,$FB,$F8,$E7,$E0,$DF             ; 0F8E8E ????????
.byte $40,$9F,$80,$64,$07,$47,$0F,$70             ; 0F8E96 @??d?G?p
.byte $00,$E3,$E0,$C7,$C0,$9F,$7F,$F7             ; 0F8E9E ????????
.byte $00,$C9,$6B,$51,$73,$1D,$7F,$0E             ; 0F8EA6 ??kQs???
.byte $1F,$08,$14,$9F,$9F,$F0,$7F,$F8             ; 0F8EAE ????????
.byte $9F,$7E,$43,$6F,$3F,$FE,$FE,$39             ; 0F8EB6 ?~Co???9
.byte $80,$C0,$4D,$0A,$40,$70,$24,$06             ; 0F8EBE ??M?@p$?
.byte $78,$09,$38,$00,$C3,$9C,$12,$73             ; 0F8EC6 x?8????s
.byte $28,$DF,$CD,$AE,$40,$E6,$64,$5E             ; 0F8ECE (???@?d^
.byte $CD,$80,$0D,$C8,$48,$CF,$C1,$C5             ; 0F8ED6 ????H???
.byte $D5,$B7,$6C,$6F,$C4,$20,$4D,$06             ; 0F8EDE ??lo? M?
.byte $C7,$31,$84,$74,$E4,$9B,$AE,$50             ; 0F8EE6 ?1?t???P
.byte $E1,$44,$88,$E7,$FD,$22,$DE,$DA             ; 0F8EEE ?D???"??
.byte $01,$E4,$11,$AC,$61,$FA,$46,$3E             ; 0F8EF6 ????a?F>
.byte $02,$03,$3A,$81,$26,$F8,$A4,$06             ; 0F8EFE ??:?&???
.byte $29,$2C,$B8,$E0,$AF,$10,$A3,$6A             ; 0F8F06 ),?????j
.byte $E4,$87,$1B,$24,$06,$BB,$92,$1C             ; 0F8F0E ???$????
.byte $68,$04,$3C,$7E,$B7,$42,$C1,$CE             ; 0F8F16 h?<~?B??
.byte $49,$73,$CC,$F3,$F8,$31,$D1,$80             ; 0F8F1E Is???1??
.byte $92,$01,$C2,$8C,$68,$48,$40,$BA             ; 0F8F26 ????hH@?
.byte $68,$40,$1D,$60,$92,$F7,$B8,$C2             ; 0F8F2E h@?`????
.byte $BB,$73,$3E,$63,$20,$6E,$D0,$4E             ; 0F8F36 ?s>c n?N
.byte $92,$6F,$20,$5F,$05,$18,$D5,$18             ; 0F8F3E ?o _????
.byte $DC,$5C,$7B,$C7,$D0,$AE,$5D,$CA             ; 0F8F46 ?\{???]?
.byte $3A,$D3,$2F,$9C,$4A,$86,$C6,$C8             ; 0F8F4E :?/?J???
.byte $36,$44,$0C,$1B,$31,$06,$D7,$AC             ; 0F8F56 6D??1???
.byte $03,$B1,$1E,$22,$CB,$AE,$89,$5E             ; 0F8F5E ???"???^
.byte $08,$04,$3C,$39,$B0,$9F,$87,$E2             ; 0F8F66 ??<9????
.byte $13,$72,$21,$86,$C8,$1E,$01,$42             ; 0F8F6E ?r!????B
.byte $F1,$C0,$94,$35,$B4,$19,$57,$32             ; 0F8F76 ???5??W2
.byte $B2,$48,$1C,$34,$48,$13,$97,$70             ; 0F8F7E ?H?4H??p
.byte $F3,$E1,$20,$0C,$BB,$B2,$A7,$4C             ; 0F8F86 ?? ????L
.byte $65,$1E,$B8,$4F,$5D,$A0,$DC,$D6             ; 0F8F8E e??O]???
.byte $E1,$79,$22,$68,$B8,$6E,$48,$BA             ; 0F8F96 ?y"h?nH?
.byte $71,$58,$47,$9C,$F0,$71,$46,$11             ; 0F8F9E qXG??qF?
.byte $DA,$CC,$09,$D1,$A6,$13,$A3,$09             ; 0F8FA6 ????????
.byte $00,$78,$28,$8E,$7B,$01,$E1,$B2             ; 0F8FAE ?x(?{???
.byte $E9,$2C,$07,$4C,$14,$D1,$8A,$1C             ; 0F8FB6 ?,?L????
.byte $86,$D1,$9A,$36,$A8,$08,$0D,$37             ; 0F8FBE ???6???7
.byte $DE,$62,$0E,$6A,$C1,$AE,$A2,$15             ; 0F8FC6 ?b?j????
.byte $EF,$AC,$E2,$56,$53,$83,$87,$8D             ; 0F8FCE ???VS???
.byte $D8,$3A,$BF,$6F,$77,$A4,$81,$27             ; 0F8FD6 ?:?ow??'
.byte $8C,$14,$80,$39,$B0,$73,$50,$F6             ; 0F8FDE ???9?sP?
.byte $A2,$40,$ED,$76,$07,$A1,$3E,$20             ; 0F8FE6 ?@?v??> 
.byte $20,$F6,$01,$21,$F1,$72,$03,$C7             ; 0F8FEE  ??!?r??
.byte $8C,$3E,$60,$F2,$A8,$FD,$07,$E9             ; 0F8FF6 ?>`?????
.byte $FD,$BD,$FA,$48,$C0,$64,$08,$58             ; 0F8FFE ???H?d?X
.byte $FA,$BA,$CB,$85,$F5,$F6,$83,$F0             ; 0F9006 ????????
.byte $9F,$C4,$24,$29,$F5,$00,$FD,$C1             ; 0F900E ??$)????
.byte $00,$FA,$72,$78,$F4,$74,$2E,$13             ; 0F9016 ??rx?t.?
.byte $E2,$B0,$75,$F7,$5E,$85,$AF,$2D             ; 0F901E ??u?^??-
.byte $B7,$4E,$2B,$21,$6B,$28,$B7,$00             ; 0F9026 ?N+!k(??
.byte $28,$C3,$A0,$7E,$3B,$E9,$B8,$A8             ; 0F902E (??~;???
.byte $F0,$4E,$B2,$E8,$7A,$6F,$16,$B6             ; 0F9036 ?N??zo??
.byte $BA,$9C,$24,$25,$91,$7A,$3C,$30             ; 0F903E ??$%?z<0
.byte $29,$01,$BD,$42,$4E,$F6,$3C,$09             ; 0F9046 )??BN?<?
.byte $1B,$A8,$0C,$AE,$CA,$02,$E3,$69             ; 0F904E ???????i
.byte $08,$F0,$DF,$C2,$C1,$39,$A6,$58             ; 0F9056 ?????9?X
.byte $E0,$C2,$70,$68,$1A,$69,$06,$E1             ; 0F905E ??ph?i??
.byte $11,$B8,$EC,$1C,$38,$26,$F2,$01             ; 0F9066 ????8&??
.byte $70,$DE,$B0,$71,$08,$5C,$44,$8D             ; 0F906E p??q?\D?
.byte $C4,$9F,$12,$87,$12,$C9,$B2,$D9             ; 0F9076 ????????
.byte $21,$91,$F0,$40,$9A,$A1,$E6,$75             ; 0F907E !??@???u
.byte $1B,$6D,$1A,$B0,$19,$9C,$30,$26             ; 0F9086 ?m????0&
.byte $FA,$30,$71,$E0,$1B,$CA,$12,$BC             ; 0F908E ?0q?????
.byte $97,$EE,$78,$71,$E8,$69,$B0,$12             ; 0F9096 ??xq?i??
.byte $62,$68,$1A,$C8,$9B,$A8,$26,$EA             ; 0F909E bh????&?
.byte $C9,$3C,$CC,$6E,$00,$4B,$AF,$40             ; 0F90A6 ?<?n?K?@
.byte $6E,$23,$28,$F3,$72,$C2,$1B,$4F             ; 0F90AE n#(?r??O
.byte $CF,$46,$44,$29,$9B,$A1,$9D,$A1             ; 0F90B6 ?FD)????
.byte $29,$C6,$B1,$06,$AC,$77,$4D,$47             ; 0F90BE )????wMG
.byte $4E,$47,$4C,$E6,$67,$B9,$10,$A2             ; 0F90C6 NGL?g???
.byte $C0,$BA,$88,$B0,$F3,$A2,$CA,$74             ; 0F90CE ???????t
.byte $B5,$21,$BA,$34,$3D,$3F,$5D,$37             ; 0F90D6 ?!?4=?]7
.byte $74,$DF,$C8,$AB,$D3,$33,$D7,$A9             ; 0F90DE t????3??
.byte $97,$9C,$98,$AE,$F5,$26,$2C,$67             ; 0F90E6 ?????&,g
.byte $1C,$F6,$35,$23,$D8,$46,$12,$DD             ; 0F90EE ??5#?F??
.byte $98,$6A,$FA,$4E,$FE,$D2,$19,$C4             ; 0F90F6 ?j?N????
.byte $17,$47,$B2,$6F,$6B,$DA,$6C,$0B             ; 0F90FE ?G?ok?l?
.byte $9E,$BC,$3C,$2A,$1D,$7E,$F5,$DB             ; 0F9106 ??<*?~??
.byte $60,$A0,$0F,$70,$67,$70,$A0,$E7             ; 0F910E `??pgp??
.byte $24,$3A,$C3,$86,$B2,$62,$F7,$3C             ; 0F9116 $:???b?<
.byte $12,$0F,$4B,$B7,$4B,$70,$07,$39             ; 0F911E ??K?Kp?9
.byte $45,$8B,$65,$9B,$90,$5D,$CA,$81             ; 0F9126 E?e??]??
.byte $DC,$84,$F7,$0A,$2F,$4E,$12,$0F             ; 0F912E ????/N??
.byte $86,$70,$8F,$4A,$77,$7F,$6D,$9E             ; 0F9136 ?p?Jw?m?
.byte $9C,$07,$5C,$BE,$08,$0C,$1C,$83             ; 0F913E ??\?????
.byte $F8,$CE,$B3,$C9,$F7,$82,$20,$5C             ; 0F9146 ?????? \
.byte $9C,$1E,$42,$83,$38,$2F,$8B,$AE             ; 0F914E ??B?8/??
.byte $A1,$83,$02,$19,$51,$01,$39,$57             ; 0F9156 ????Q?9W
.byte $8B,$2A,$6F,$AE,$F1,$74,$C6,$E8             ; 0F915E ?*o??t??
.byte $B6,$64,$13,$B2,$E0,$7A,$0F,$0A             ; 0F9166 ?d???z??
.byte $73,$6B,$27,$35,$E3,$E7,$D3,$21             ; 0F916E sk'5???!
.byte $B1,$82,$27,$75,$4F,$72,$C8,$C0             ; 0F9176 ??'uOr??
.byte $1E,$8F,$6F,$67,$27,$B1,$B1,$B5             ; 0F917E ??og'???
.byte $2C,$0F,$AB,$9B,$5B,$26,$C1,$87             ; 0F9186 ,???[&??
.byte $AA,$04,$01,$CD,$82,$7B,$78,$4E             ; 0F918E ?????{xN
.byte $70,$2E,$B0,$39,$CC,$D9,$C6,$69             ; 0F9196 p.?9???i
.byte $20,$9D,$F8,$1A,$4B,$10,$26,$63             ; 0F919E  ???K?&c
.byte $BB,$58,$AF,$C3,$04,$AE,$4B,$EF             ; 0F91A6 ?X????K?
.byte $33,$41,$9A,$B1,$0F,$38,$62,$C7             ; 0F91AE 3A???8b?
.byte $57,$47,$3A,$C0,$7B,$D9,$29,$B2             ; 0F91B6 WG:?{?)?
.byte $6C,$03,$CC,$A4,$07,$32,$00,$5E             ; 0F91BE l????2?^
.byte $3B,$4F,$81,$DE,$3B,$AF,$0D,$AF             ; 0F91C6 ;O??;???
.byte $5F,$41,$F5,$42,$40,$18,$FE,$11             ; 0F91CE _A?B@???
.byte $D1,$A0,$42,$98,$58,$18,$59,$13             ; 0F91D6 ??B?X?Y?
.byte $E2,$EE,$0A,$A3,$1D,$75,$DB,$FA             ; 0F91DE ?????u??
.byte $99,$78,$07,$72,$2B,$7C,$98,$79             ; 0F91E6 ?x?r+|?y
.byte $68,$87,$E4,$62,$C0,$F0,$32,$97             ; 0F91EE h??b??2?
.byte $96,$48,$5F,$86,$F7,$2A,$26,$01             ; 0F91F6 ?H_??*&?
.byte $88,$93,$A1,$1A,$FA,$F2,$C7,$92             ; 0F91FE ????????
.byte $60,$FD,$E6,$D8,$7F,$A1,$61,$DC             ; 0F9206 `?????a?
.byte $85,$DF,$7F,$EF,$A8,$EC,$E4,$10             ; 0F920E ????????
.byte $9F,$EA,$09,$3F,$ED,$84,$26,$B7             ; 0F9216 ??????&?
.byte $DE,$00,$32,$E3,$49,$20,$5D,$06             ; 0F921E ??2?I ]?
.byte $1A,$C8,$60,$D7,$C3,$6C,$63,$83             ; 0F9226 ??`??lc?
.byte $01,$EF,$04,$89,$DF,$77,$06,$36             ; 0F922E ?????w?6
.byte $A8,$77,$E7,$ED,$F2,$23,$18,$8B             ; 0F9236 ?w???#??
.byte $C1,$9F,$0D,$88,$F0,$74,$24,$5D             ; 0F923E ?????t$]
.byte $83,$F2,$6D,$DF,$38,$3A,$09,$99             ; 0F9246 ??m?8:??
.byte $64,$67,$83,$53,$20,$60,$EC,$90             ; 0F924E dg?S `??
.byte $74,$B4,$9C,$14,$64,$78,$7B,$48             ; 0F9256 t???dx{H
.byte $F1,$06,$85,$D7,$A3,$84,$3D,$20             ; 0F925E ??????= 
.byte $30,$8F,$6F,$B6,$09,$5C,$B6,$F0             ; 0F9266 0?o??\??
.byte $99,$D0,$E4,$E2,$6C,$04,$9C,$49             ; 0F926E ????l??I
.byte $80,$80,$33,$EE,$12,$09,$90,$F2             ; 0F9276 ??3?????
.byte $53,$1E,$E4,$09,$A2,$20,$97,$56             ; 0F927E S???? ?V
.byte $D5,$9E,$D5,$83,$8F,$9E,$D0,$59             ; 0F9286 ???????Y
.byte $78,$F8,$BB,$45,$08,$E4,$1B,$08             ; 0F928E x??E????
.byte $6D,$D4,$85,$4D,$F3,$DB,$95,$B4             ; 0F9296 m??M????
.byte $E5,$2A,$5B,$6B,$B4,$F7,$09,$A3             ; 0F929E ?*[k????
.byte $EE,$35,$97,$8E,$1B,$82,$33,$26             ; 0F92A6 ?5????3&
.byte $9C,$A8,$5B,$95,$39,$96,$24,$20             ; 0F92AE ??[?9?$ 
.byte $1E,$06,$F0,$E9,$76,$39,$4E,$C2             ; 0F92B6 ????v9N?
.byte $BC,$71,$6D,$96,$10,$BC,$9E,$06             ; 0F92BE ?qm?????
.byte $E5,$BB,$BF,$C0,$48,$C6,$E8,$C9             ; 0F92C6 ????H???
.byte $87,$FE,$E4,$E2,$F2,$14,$37,$99             ; 0F92CE ??????7?
.byte $85,$87,$FD,$70,$72,$AF,$34,$41             ; 0F92D6 ???pr?4A
.byte $63,$60,$D9,$CD,$88,$E6,$CC,$73             ; 0F92DE c`?????s
.byte $5D,$37,$8A,$2E,$F1,$96,$60,$16             ; 0F92E6 ]7?.??`?
.byte $D6,$0B,$00,$00,$00,$01,$01,$00             ; 0F92EE ????????
.byte $03,$00,$07,$02,$01,$3C,$3C,$40             ; 0F92F6 ?????<<@
.byte $7E,$F0,$FF,$08,$FF,$0C,$FF,$7E             ; 0F92FE ~??????~
.byte $40,$1B,$14,$1C,$EB,$C6,$35,$80             ; 0F9306 @?????5?
.byte $00,$C0,$02,$01,$02,$01,$04,$07             ; 0F930E ????????
.byte $00,$07,$30,$37,$03,$00,$03,$07             ; 0F9316 ??07????
.byte $07,$0A,$05,$1E,$37,$0C,$0F,$43             ; 0F931E ????7??C
.byte $3F,$81,$FF,$00,$FF,$00,$FF,$01             ; 0F9326 ????????
.byte $06,$08,$07,$76,$4A,$63,$1D,$C1             ; 0F932E ???vJc??
.byte $3E,$80,$7F,$00,$FF,$06,$F9,$C6             ; 0F9336 >???????
.byte $FF,$23,$FF,$18,$FF,$8C,$FF,$CE             ; 0F933E ?#??????
.byte $FF,$67,$FB,$33,$DD,$11,$EE,$E3             ; 0F9346 ?g?3????
.byte $DA,$31,$ED,$91,$76,$5A,$29,$AD             ; 0F934E ?1??vZ)?
.byte $9C,$D6,$4A,$63,$8D,$3B,$C4,$10             ; 0F9356 ??Jc?;??
.byte $F0,$08,$F0,$F8,$F8,$78,$B8,$78             ; 0F935E ?????x?x
.byte $C0,$30,$C0,$B0,$D0,$F7,$F9,$00             ; 0F9366 ?0??????
.byte $E0,$C8,$30,$C8,$C8,$F8,$38,$38             ; 0F936E ??0???88
.byte $80,$F0,$00,$70,$10,$F7,$F0,$07             ; 0F9376 ???p????
.byte $07,$0C,$00,$C1,$50,$04,$07,$0C             ; 0F937E ????P???
.byte $3F,$1C,$FE,$FF,$FF,$FF,$7F,$FF             ; 0F9386 ????????
.byte $0F,$0E,$09,$0F,$00,$01,$10,$17             ; 0F938E ????????
.byte $73,$27,$7B,$4F,$79,$4F,$78,$0F             ; 0F9396 s'{OyOx?
.byte $7D,$4A,$FF,$04,$FF,$84,$17,$2C             ; 0F939E }J?????,
.byte $56,$2E,$7D,$07,$7F,$07,$7F,$86             ; 0F93A6 V.}?????
.byte $3F,$C7,$FF,$03,$FF,$01,$0E,$FF             ; 0F93AE ????????
.byte $FF,$FE,$FF,$FB,$FF,$F8,$FF,$F9             ; 0F93B6 ????????
.byte $7F,$FA,$FF,$74,$EF,$1D,$BD,$4C             ; 0F93BE ???t???L
.byte $05,$04,$AE,$AA,$BF,$3A,$8F,$84             ; 0F93C6 ?????:??
.byte $FF,$ED,$09,$FF,$8F,$FE,$5F,$F0             ; 0F93CE ??????_?
.byte $FE,$01,$FE,$11,$FC,$71,$F0,$E3             ; 0F93D6 ?????q??
.byte $D4,$A1,$17,$E1,$5F,$2E,$BF,$10             ; 0F93DE ????_.??
.byte $FE,$00,$FE,$10,$FE,$70,$FC,$E0             ; 0F93E6 ?????p??
.byte $FE,$C0,$FF,$32,$DC,$F8,$BC,$F0             ; 0F93EE ???2????
.byte $F8,$E0,$3D,$05,$F3,$03,$E7,$07             ; 0F93F6 ??=?????
.byte $FF,$5E,$DF,$10,$FF,$C0,$DE,$81             ; 0F93FE ?^??????
.byte $3C,$03,$FD,$02,$FB,$04,$F7,$08             ; 0F9406 <???????
.byte $FF,$00,$4F,$31,$0B,$E3,$37,$82             ; 0F940E ??O1??7?
.byte $E7,$26,$AF,$26,$EF,$46,$EF,$87             ; 0F9416 ?&?&?F??
.byte $EF,$C5,$38,$FC,$F0,$FC,$E0,$B8             ; 0F941E ??8?????
.byte $C0,$F8,$C0,$F0,$80,$F0,$40,$F0             ; 0F9426 ??????@?
.byte $02,$F0,$FF,$80,$00,$3F,$00,$7F             ; 0F942E ????????
.byte $03,$03,$54,$77,$8C,$FF,$86,$33             ; 0F9436 ??Tw???3
.byte $10,$4E,$3D,$C7,$BE,$80,$40,$C0             ; 0F943E ?N=???@?
.byte $20,$E0,$28,$80,$80,$18,$E0,$02             ; 0F9446  ?(?????
.byte $08,$02,$08,$38,$00,$30,$00,$71             ; 0F944E ???8?0?q
.byte $00,$62,$10,$03,$03,$0F,$0E,$1B             ; 0F9456 ?b??????
.byte $1F,$39,$3F,$FD,$B7,$FD,$FF,$FC             ; 0F945E ?9??????
.byte $FF,$FC,$FF,$3F,$3D,$3C,$C4,$2C             ; 0F9466 ????=<?,
.byte $49,$18,$13,$79,$22,$F3,$24,$E4             ; 0F946E I??y"?$?
.byte $08,$B1,$01,$C2,$FF,$F8,$DF,$F1             ; 0F9476 ????????
.byte $FF,$E3,$FF,$87,$FF,$07,$FF,$0F             ; 0F947E ????????
.byte $FF,$5E,$03,$02,$18,$08,$10,$1A             ; 0F9486 ?^??????
.byte $40,$34,$48,$70,$88,$E1,$18,$62             ; 0F948E @4Hp???b
.byte $18,$03,$03,$1F,$1E,$3B,$1F,$79             ; 0F9496 ?????;?y
.byte $7F,$F9,$FF,$7F,$73,$C7,$10,$14             ; 0F949E ????s???
.byte $00,$0C,$2E,$30,$00,$38,$41,$38             ; 0F94A6 ??.0?8A8
.byte $60,$18,$01,$01,$07,$06,$1D,$0F             ; 0F94AE `???????
.byte $1D,$1F,$1D,$1B,$3F,$3F,$3E,$3F             ; 0F94B6 ??????>?
.byte $3E,$7F,$03,$02,$02,$02,$03,$02             ; 0F94BE >???????
.byte $03,$00,$03,$01,$F9,$12,$FD,$06             ; 0F94C6 ????????
.byte $F8,$03,$F0,$03,$F0,$03,$E1,$06             ; 0F94CE ????????
.byte $E0,$0F,$C0,$0F,$FD,$00,$FD,$00             ; 0F94D6 ????????
.byte $FC,$00,$FC,$F8,$01,$B0,$40,$F0             ; 0F94DE ??????@?
.byte $FE,$03,$FC,$03,$00,$FE,$F9,$00             ; 0F94E6 ????????
.byte $FF,$84,$73,$7E,$FC,$03,$00,$06             ; 0F94EE ??s~????
.byte $88,$00,$8E,$F1,$0A,$F5,$1E,$E9             ; 0F94F6 ????????
.byte $1E,$69,$3E,$C1,$7C,$81,$74,$89             ; 0F94FE ?i>?|?t?
.byte $3D,$86,$8E,$80,$0E,$04,$1E,$08             ; 0F9506 =???????
.byte $9E,$00,$3A,$04,$7E,$00,$76,$00             ; 0F950E ??:?~?v?
.byte $60,$14,$EF,$0F,$FF,$3F,$D7,$1F             ; 0F9516 `???????
.byte $EF,$0F,$F6,$16,$CB,$08,$7D,$04             ; 0F951E ??????}?
.byte $3D,$00,$10,$08,$FF,$40,$FF,$11             ; 0F9526 =????@??
.byte $EF,$08,$F7,$04,$FB,$00,$FF,$EF             ; 0F952E ????????
.byte $C5,$ED,$C0,$EC,$C0,$EE,$C2,$A6             ; 0F9536 ????????
.byte $C2,$F7,$C2,$B3,$A3,$FB,$81,$02             ; 0F953E ????????
.byte $F0,$21,$F0,$61,$F8,$21,$F8,$40             ; 0F9546 ?!?a?!?@
.byte $FC,$60,$FC,$60,$FF,$30,$7C,$1B             ; 0F954E ?`?`?0|?
.byte $DC,$13,$3C,$23,$FC,$C3,$FC,$83             ; 0F9556 ??<#????
.byte $00,$3F,$80,$0F,$C0,$00,$E3,$00             ; 0F955E ????????
.byte $E3,$00,$C3,$07,$07,$0F,$0F,$0C             ; 0F9566 ????????
.byte $0F,$0E,$03,$02,$0B,$08,$0D,$0C             ; 0F956E ????????
.byte $81,$FF,$65,$FE,$32,$FF,$58,$EF             ; 0F9576 ??e?2?X?
.byte $8E,$F7,$CE,$FB,$E1,$7F,$70,$BF             ; 0F957E ??????p?
.byte $C2,$BC,$F1,$6E,$78,$B7,$3C,$CB             ; 0F9586 ???nx?<?
.byte $1C,$65,$87,$BA,$D3,$4D,$69,$A6             ; 0F958E ?e???Mi?
.byte $1C,$FC,$C3,$FF,$E0,$7F,$7E,$BF             ; 0F9596 ??????~?
.byte $3E,$DD,$3E,$EF,$BF,$F3,$FF,$F3             ; 0F959E >?>?????
.byte $80,$78,$A0,$9C,$D7,$48,$C3,$02             ; 0F95A6 ?x???H??
.byte $3F,$DC,$3D,$EC,$7C,$30,$FE,$F2             ; 0F95AE ??=?|0??
.byte $07,$00,$3F,$41,$7F,$88,$7F,$C0             ; 0F95B6 ???A????
.byte $6F,$90,$7F,$C4,$7F,$F0,$7F,$D5             ; 0F95BE o???????
.byte $07,$00,$31,$0E,$C0,$3F,$44,$BB             ; 0F95C6 ??1???D?
.byte $30,$CF,$44,$BB,$E0,$1F,$F5,$0A             ; 0F95CE 0?D?????
.byte $B6,$00,$E6,$00,$77,$01,$B7,$01             ; 0F95D6 ????w???
.byte $BF,$01,$3D,$81,$0D,$09,$7F,$1F             ; 0F95DE ??=?????
.byte $78,$89,$FE,$C9,$7E,$C5,$FE,$41             ; 0F95E6 x???~??A
.byte $FE,$F9,$F6,$9F,$E0,$4B,$08,$BD             ; 0F95EE ?????K??
.byte $84,$BD,$80,$00,$84,$7B,$03,$02             ; 0F95F6 ?????{??
.byte $07,$02,$0B,$0A,$11,$10,$36,$32             ; 0F95FE ??????62
.byte $7E,$70,$DE,$40,$B7,$86,$7E,$1C             ; 0F9606 ~p?@??~?
.byte $06,$01,$0A,$05,$10,$0F,$32,$0D             ; 0F960E ??????2?
.byte $60,$1F,$C0,$3F,$C6,$79,$0E,$F1             ; 0F9616 `????y??
.byte $E6,$18,$C6,$38,$A6,$50,$07,$F1             ; 0F961E ???8?P??
.byte $07,$19,$07,$09,$7D,$01,$67,$A3             ; 0F9626 ????}?g?
.byte $F8,$F8,$DF,$F9,$FE,$F9,$FE,$F1             ; 0F962E ????????
.byte $FE,$81,$FE,$A3,$DC,$3D,$04,$04             ; 0F9636 ?????=??
.byte $FB,$02,$00,$02,$07,$02,$01,$01             ; 0F963E ????????
.byte $06,$03,$0C,$A2,$58,$22,$D8,$5A             ; 0F9646 ????X"?Z
.byte $A0,$8B,$71,$03,$F9,$03,$C9,$03             ; 0F964E ??q?????
.byte $89,$3B,$C1,$7C,$FB,$F7,$FD,$FE             ; 0F9656 ?;?|????
.byte $FD,$FE,$BA,$C5,$FE,$76,$91,$C0             ; 0F965E ?????v??
.byte $07,$C0,$0F,$80,$1F,$84,$1B,$C0             ; 0F9666 ????????
.byte $1E,$E0,$0D,$70,$1F,$00,$F9,$F8             ; 0F966E ???p????
.byte $08,$F0,$00,$E0,$00,$E4,$00,$61             ; 0F9676 ???????a
.byte $80,$F2,$00,$F0,$E7,$04,$C3,$0C             ; 0F967E ????????
.byte $B2,$15,$6A,$24,$DB,$00,$FF,$03             ; 0F9686 ??j$????
.byte $FC,$13,$EC,$18,$00,$38,$00,$41             ; 0F968E ?????8?A
.byte $00,$81,$10,$00,$35,$82,$1B,$C4             ; 0F9696 ????5???
.byte $0B,$E0,$03,$74,$37,$C8,$9F,$E0             ; 0F969E ???t7???
.byte $78,$1C,$00,$00,$84,$AE,$90,$9E             ; 0F96A6 x???????
.byte $80,$C0,$C1,$D0,$C2,$E0,$E4,$E0             ; 0F96AE ????????
.byte $E4,$F4,$F4,$FE,$FE,$90,$7F,$80             ; 0F96B6 ????????
.byte $7F,$C1,$3F,$C3,$3F,$E7,$1F,$E7             ; 0F96BE ????????
.byte $1E,$F7,$0B,$FF,$01,$FE,$91,$7F             ; 0F96C6 ????????
.byte $00,$E5,$04,$AC,$0C,$9E,$1C,$7E             ; 0F96CE ???????~
.byte $7C,$FE,$EC,$7E,$7C,$60,$BC,$7C             ; 0F96D6 |??~|`?|
.byte $FC,$F8,$EE,$F0,$FF,$E0,$10,$EF             ; 0F96DE ????????
.byte $80,$FF,$E7,$18,$CC,$3B,$8C,$7B             ; 0F96E6 ?????;?{
.byte $9C,$7B,$9C,$7B,$BC,$7B,$BC,$06             ; 0F96EE ?{?{?{??
.byte $07,$03,$03,$03,$01,$07,$06,$00             ; 0F96F6 ????????
.byte $38,$DF,$1F,$EF,$8F,$F7,$CF,$FD             ; 0F96FE 8???????
.byte $FF,$3C,$FF,$00,$35,$D2,$9C,$6C             ; 0F9706 ?<??5??l
.byte $4E,$36,$A7,$95,$EF,$2C,$FF,$90             ; 0F970E N6???,??
.byte $FF,$C1,$F7,$FF,$83,$FF,$C0,$F2             ; 0F9716 ????????
.byte $0D,$7E,$76,$7F,$03,$FF,$C4,$FF             ; 0F971E ?~v?????
.byte $BC,$FF,$78,$FD,$F0,$FB,$E0,$F2             ; 0F9726 ??x?????
.byte $C0,$7F,$E3,$FF,$AF,$7F,$A5,$9F             ; 0F972E ????????
.byte $60,$80,$71,$80,$7F,$08,$F7,$08             ; 0F9736 `?q?????
.byte $F7,$E3,$1C,$FF,$80,$5F,$20,$9F             ; 0F973E ?????_ ?
.byte $00,$8E,$ED,$C2,$F7,$80,$E3,$0C             ; 0F9746 ????????
.byte $CB,$10,$08,$F5,$5F,$E0,$3F,$C0             ; 0F974E ????_???
.byte $FF,$00,$D0,$00,$E8,$00,$B0,$40             ; 0F9756 ???????@
.byte $E4,$10,$40,$2E,$80,$9E,$40,$80             ; 0F975E ??@.??@?
.byte $40,$91,$41,$03,$E3,$83,$63,$83             ; 0F9766 @?A???c?
.byte $77,$81,$7F,$6F,$10,$3F,$00,$3E             ; 0F976E w??o???>
.byte $01,$3D,$02,$1B,$04,$1A,$05,$0B             ; 0F9776 ?=??????
.byte $02,$02,$06,$04,$01,$06,$01,$08             ; 0F977E ????????
.byte $07,$07,$07,$1D,$1C,$32,$32,$3D             ; 0F9786 ?????22=
.byte $3D,$5F,$4F,$22,$01,$E7,$06,$D7             ; 0F978E =_O"????
.byte $03,$0E,$01,$1C,$03,$32,$0D,$3D             ; 0F9796 ?????2?=
.byte $42,$4F,$B0,$02,$FC,$07,$F8,$03             ; 0F979E BO??????
.byte $FC,$E7,$00,$F3,$00,$F3,$02,$9E             ; 0F97A6 ????????
.byte $96,$01,$5E,$A0,$E4,$18,$03,$FC             ; 0F97AE ??^?????
.byte $87,$78,$FF,$00,$F7,$08,$5F,$00             ; 0F97B6 ?x????_?
.byte $E7,$00,$61,$16,$F1,$0E,$F8,$45             ; 0F97BE ??a????E
.byte $70,$07,$24,$C3,$01,$7E,$01,$FE             ; 0F97C6 p?$??~??
.byte $02,$FD,$68,$FA,$02,$F8,$2E,$80             ; 0F97CE ??h???.?
.byte $1E,$91,$41,$7F,$07,$07,$1F,$0E             ; 0F97D6 ??A?????
.byte $37,$04,$7F,$18,$7F,$2C,$E7,$44             ; 0F97DE 7????,?D
.byte $F3,$42,$E7,$86,$07,$08,$1F,$00             ; 0F97E6 ?B??????
.byte $3F,$08,$7F,$00,$EF,$10,$C7,$38             ; 0F97EE ???????8
.byte $C3,$3C,$87,$78,$3B,$41,$3B,$01             ; 0F97F6 ?<?x;A;?
.byte $B1,$01,$F9,$01,$79,$01,$DB,$43             ; 0F97FE ????y??C
.byte $BF,$3F,$FF,$3F,$C1,$FE,$C1,$11             ; 0F9806 ????????
.byte $43,$BC,$3F,$C0,$3F,$C0,$1F,$3E             ; 0F980E C??????>
.byte $FE,$01,$FE,$20,$FF,$FD,$FD,$FE             ; 0F9816 ??? ????
.byte $FE,$F7,$F7,$F1,$F1,$70,$70,$76             ; 0F981E ?????ppv
.byte $70,$33,$30,$FF,$00,$FD,$02,$FE             ; 0F9826 p30?????
.byte $01,$F7,$08,$F1,$0E,$70,$0F,$70             ; 0F982E ?????p?p
.byte $0F,$30,$0F,$3E,$3C,$D6,$DC,$6F             ; 0F9836 ?0?><??o
.byte $62,$2D,$28,$17,$10,$57,$54,$81             ; 0F983E b-(??WT?
.byte $00,$0B,$08,$C0,$FF,$A8,$7F,$70             ; 0F9846 ???????p
.byte $DF,$32,$FD,$18,$EF,$18,$FF,$0E             ; 0F984E ?2??????
.byte $DC,$3B,$5C,$3B,$58,$3F,$58,$3F             ; 0F9856 ?;\;X?X?
.byte $58,$3F,$28,$1F,$A8,$1F,$A8,$1F             ; 0F985E X?(?????
.byte $80,$07,$80,$07,$80,$07,$FF,$00             ; 0F9866 ????????
.byte $2C,$E0,$01,$7E,$0F,$30,$13,$0C             ; 0F986E ,??~?0??
.byte $04,$FF,$7F,$3F,$E8,$17,$0F,$70             ; 0F9876 ???????p
.byte $FE,$01,$FF,$00,$BC,$03,$C2,$3C             ; 0F987E ???????<
.byte $10,$E0,$40,$21,$80,$7F,$C0,$3D             ; 0F9886 ??@!???=
.byte $40,$BE,$00,$F7,$00,$F1,$00,$70             ; 0F988E @??????p
.byte $06,$30,$03,$30,$01,$00,$08,$00             ; 0F9896 ?0?0????
.byte $0E,$00,$0F,$00,$0F,$00,$07,$00             ; 0F989E ????????
.byte $17,$16,$1F,$07,$C0,$80,$B0,$0F             ; 0F98A6 ????????
.byte $20,$1F,$49,$3F,$04,$0F,$00,$1F             ; 0F98AE  ?I?????
.byte $06,$39,$07,$78,$BF,$40,$7F,$BF             ; 0F98B6 ?9?x?@??
.byte $FF,$38,$F4,$63,$C3,$43,$09,$08             ; 0F98BE ?8?c?C??
.byte $E3,$63,$FF,$37,$1F,$1C,$07,$E0             ; 0F98C6 ?c?7????
.byte $02,$F0,$10,$FB,$03,$FC,$08,$F7             ; 0F98CE ????????
.byte $63,$9C,$30,$2C,$C8,$90,$6E,$A1             ; 0F98D6 c?0,??n?
.byte $DF,$FE,$81,$DF,$20,$CE,$31,$AC             ; 0F98DE ???? ?1?
.byte $53,$00,$BC,$00,$FC,$91,$C0,$C0             ; 0F98E6 S???????
.byte $00,$A0,$00,$40,$0F,$F0,$3F,$80             ; 0F98EE ???@????
.byte $71,$8E,$91,$68,$80,$7F,$80,$7D             ; 0F98F6 q??h???}
.byte $C0,$3E,$C0,$37,$40,$B1,$00,$F0             ; 0F98FE ?>?7@???
.byte $06,$70,$03,$70,$02,$00,$0F,$02             ; 0F9906 ?p?p????
.byte $1E,$04,$1F,$26,$3F,$17,$3F,$1C             ; 0F990E ???&????
.byte $3E,$1D,$7F,$3E,$03,$01,$0E,$01             ; 0F9916 >??>????
.byte $1D,$03,$1E,$01,$37,$08,$3F,$00             ; 0F991E ????7???
.byte $2E,$CF,$4C,$8F,$08,$CF,$0C,$FF             ; 0F9926 .?L?????
.byte $0A,$BF,$8E,$EF,$19,$E3,$08,$70             ; 0F992E ???????p
.byte $8C,$0F,$F0,$0F,$F0,$0F,$F0,$0B             ; 0F9936 ????????
.byte $F4,$FF,$40,$E7,$08,$F7,$00,$73             ; 0F993E ??@????s
.byte $00,$C3,$3C,$01,$7E,$9F,$60,$8D             ; 0F9946 ??<?~?`?
.byte $32,$C1,$3E,$3E,$00,$5E,$C0,$F0             ; 0F994E 2?>>?^??
.byte $39,$3A,$1B,$18,$0D,$0C,$1D,$1C             ; 0F9956 9:??????
.byte $1D,$1C,$1F,$1E,$1F,$1F,$1C,$1C             ; 0F995E ????????
.byte $3A,$07,$18,$07,$0C,$03,$1C,$03             ; 0F9966 :???????
.byte $1C,$03,$1E,$03,$1F,$04,$1C,$07             ; 0F996E ????????
.byte $8B,$88,$C5,$86,$A7,$C6,$F3,$60             ; 0F9976 ???????`
.byte $FA,$21,$FB,$70,$10,$0C,$FF,$02             ; 0F997E ?!?p????
.byte $FF,$44,$41,$40,$FF,$09,$FF,$A0             ; 0F9986 ?DA@????
.byte $1F,$C0,$1F,$C0,$E0,$07,$E0,$07             ; 0F998E ????????
.byte $E0,$51,$BF,$F1,$3F,$F8,$7F,$F8             ; 0F9996 ?Q??????
.byte $7F,$F4,$7F,$D6,$FF,$D6,$FF,$D7             ; 0F999E ????????
.byte $FF,$68,$47,$C8,$C7,$C4,$C3,$C4             ; 0F99A6 ?hG?????
.byte $C3,$CB,$C0,$A9,$80,$A9,$80,$AB             ; 0F99AE ????????
.byte $83,$80,$00,$5C,$F7,$2F,$FB,$07             ; 0F99B6 ???\?/??
.byte $FD,$03,$FF,$04,$F8,$FF,$08,$E7             ; 0F99BE ????????
.byte $0B,$E0,$0C,$F8,$87,$7D,$C1,$3D             ; 0F99C6 ?????}?=
.byte $00,$F8,$E0,$00,$C0,$03,$03,$00             ; 0F99CE ????????
.byte $03,$7F,$61,$8E,$06,$F1,$41,$7B             ; 0F99D6 ??a???A{
.byte $5B,$31,$01,$73,$43,$40,$63,$1C             ; 0F99DE [1?sC@c?
.byte $97,$79,$C1,$3E,$11,$EE,$01,$FE             ; 0F99E6 ?y?>????
.byte $0B,$FC,$3F,$C0,$7F,$80,$80,$7F             ; 0F99EE ????????
.byte $E0,$9F,$F0,$6F,$F8,$F7,$F8,$F7             ; 0F99F6 ???o????
.byte $F8,$F7,$38,$07,$10,$07,$80,$70             ; 0F99FE ??8????p
.byte $80,$E8,$10,$78,$80,$F8,$F8,$00             ; 0F9A06 ???x????
.byte $00,$FC,$40,$B8,$1C,$1C,$1A,$18             ; 0F9A0E ??@?????
.byte $08,$08,$08,$08,$1C,$08,$07,$08             ; 0F9A16 ????????
.byte $7F,$00,$0B,$00,$2D,$2C,$2A,$FF             ; 0F9A1E ????-,*?
.byte $FA,$E2,$2C,$DF,$02,$FD,$12,$FD             ; 0F9A26 ??,?????
.byte $02,$FD,$82,$FF,$12,$EF,$D0,$0F             ; 0F9A2E ????????
.byte $D0,$0F,$40,$0F,$03,$87,$03,$C0             ; 0F9A36 ??@?????
.byte $D7,$FF,$D3,$FE,$C9,$77,$7C,$3D             ; 0F9A3E ?????w|=
.byte $37,$1E,$1B,$07,$04,$AF,$87,$AF             ; 0F9A46 7???????
.byte $82,$BF,$89,$A1,$90,$4B,$40,$2F             ; 0F9A4E ?????K@/
.byte $25,$1F,$1A,$07,$04,$E1,$FF,$3F             ; 0F9A56 %???????
.byte $7E,$FE,$E4,$FC,$F8,$78,$F0,$80             ; 0F9A5E ~????x??
.byte $E0,$00,$81,$9F,$FD,$E1,$F1,$31             ; 0F9A66 ???????1
.byte $3E,$BE,$8C,$94,$C8,$48,$07,$01             ; 0F9A6E >????H??
.byte $07,$02,$06,$01,$05,$02,$03,$04             ; 0F9A76 ????????
.byte $03,$04,$05,$01,$07,$03,$40,$BF             ; 0F9A7E ??????@?
.byte $00,$FF,$80,$7F,$1F,$EF,$F0,$3F             ; 0F9A86 ????????
.byte $F0,$F0,$7F,$7F,$7F,$7F,$7F,$FF             ; 0F9A8E ????????
.byte $FF,$FC,$CC,$F8,$B7,$D8,$57,$C8             ; 0F9A96 ??????W?
.byte $47,$CC,$43,$C0,$3F,$64,$9B,$30             ; 0F9A9E G?C??d?0
.byte $CF,$E0,$FE,$0C,$FA,$C0,$C0,$E4             ; 0F9AA6 ????????
.byte $E0,$F0,$F0,$30,$20,$14,$E0,$06             ; 0F9AAE ???0 ???
.byte $FA,$03,$FD,$03,$FC,$F2,$EB,$72             ; 0F9AB6 ???????r
.byte $FF,$36,$7F,$24,$3F,$0C,$0F,$0C             ; 0F9ABE ?6?$????
.byte $1E,$1C,$1C,$18,$02,$FF,$FD,$04             ; 0F9AC6 ????????
.byte $FF,$0C,$7F,$0C,$3B,$18,$16,$18             ; 0F9ACE ????;???
.byte $16,$C0,$01,$01,$E7,$FF,$ED,$FE             ; 0F9AD6 ????????
.byte $DF,$FF,$94,$93,$9A,$99,$9A,$99             ; 0F9ADE ????????
.byte $9A,$82,$93,$80,$B0,$90,$00,$3C             ; 0F9AE6 ???????<
.byte $FF,$1C,$F3,$0F,$FF,$06,$FE,$82             ; 0F9AEE ????????
.byte $FE,$F6,$7E,$71,$8E,$59,$C6,$33             ; 0F9AF6 ??~q?Y?3
.byte $F0,$2F,$C0,$1C,$EC,$CE,$36,$72             ; 0F9AFE ?/????6r
.byte $0E,$CA,$42,$40,$C0,$40,$08,$08             ; 0F9B06 ??B@?@??
.byte $0C,$6E,$5B,$3B,$2D,$1F,$16,$7D             ; 0F9B0E ?n[;-??}
.byte $48,$36,$20,$FC,$AC,$F0,$F0,$E0             ; 0F9B16 H6 ?????
.byte $7C,$2C,$30,$30,$00,$30,$04,$21             ; 0F9B1E |,00?0?!
.byte $04,$7A,$04,$D0,$08,$B0,$08,$B1             ; 0F9B26 ?z??????
.byte $08,$1F,$0D,$3F,$1C,$3F,$1C,$7F             ; 0F9B2E ????????
.byte $3E,$FF,$7E,$FF,$7E,$C7,$07,$00             ; 0F9B36 >?~?~???
.byte $06,$01,$73,$08,$7B,$00,$73,$08             ; 0F9B3E ??s?{?s?
.byte $73,$80,$23,$40,$02,$70,$06,$FC             ; 0F9B46 s?#@?p??
.byte $DB,$FC,$03,$1B,$03,$1F,$24,$3F             ; 0F9B4E ??????$?
.byte $04,$3F,$46,$5F,$26,$4F,$A3,$00             ; 0F9B56 ??F_&O??
.byte $03,$3C,$03,$3C,$03,$5E,$01,$5F             ; 0F9B5E ?<?<?^?_
.byte $00,$CE,$FE,$00,$7E,$00,$7F,$31             ; 0F9B66 ????~??1
.byte $3C,$98,$3D,$CD,$1F,$07,$34,$80             ; 0F9B6E <?=???4?
.byte $FF,$B1,$CE,$58,$E7,$0D,$F2,$E7             ; 0F9B76 ???X????
.byte $0F,$01,$1F,$03,$1F,$27,$3F,$3D             ; 0F9B7E ?????'?=
.byte $02,$8F,$61,$07,$74,$A1,$50,$B0             ; 0F9B86 ??a?t?P?
.byte $4A,$9A,$65,$D9,$26,$FC,$83,$FE             ; 0F9B8E J?e?&???
.byte $85,$9F,$00,$8F,$00,$AF,$00,$B5             ; 0F9B96 ????????
.byte $00,$98,$00,$D8,$FE,$00,$F9,$83             ; 0F9B9E ????????
.byte $D8,$A3,$F0,$CF,$F0,$07,$87,$03             ; 0F9BA6 ????????
.byte $CC,$86,$79,$FD,$00,$DC,$B8,$40             ; 0F9BAE ??y????@
.byte $FC,$08,$78,$04,$3F,$5E,$B0,$40             ; 0F9BB6 ??x??^?@
.byte $FF,$81,$DF,$81,$FF,$03,$3E,$01             ; 0F9BBE ??????>?
.byte $78,$07,$70,$0F,$E0,$81,$7E,$A1             ; 0F9BC6 x?p???~?
.byte $7E,$03,$FC,$FF,$C0,$3F,$20,$7E             ; 0F9BCE ~????? ~
.byte $60,$FE,$C0,$FE,$E2,$FC,$01,$FC             ; 0F9BD6 `???????
.byte $13,$F8,$07,$FF,$00,$FF,$00,$DF             ; 0F9BDE ????????
.byte $20,$F8,$00,$CC,$33,$78,$87,$70             ; 0F9BE6  ???3x?p
.byte $8F,$60,$9E,$E1,$1C,$C2,$3C,$85             ; 0F9BEE ?`????<?
.byte $78,$82,$78,$02,$02,$85,$05,$F8             ; 0F9BF6 x?x?????
.byte $83,$18,$41,$0C,$81,$1C,$01,$1C             ; 0F9BFE ??A?????
.byte $01,$1E,$1C,$05,$02,$87,$80,$43             ; 0F9C06 ???????C
.byte $40,$83,$80,$05,$06,$0C,$0B,$07             ; 0F9C0E @???????
.byte $06,$FF,$06,$FD,$08,$FC,$00,$03             ; 0F9C16 ????????
.byte $07,$F8,$0F,$FF,$00,$F1,$06,$E1             ; 0F9C1E ????????
.byte $06,$C1,$0E,$C6,$19,$84,$3B,$08             ; 0F9C26 ??????;?
.byte $77,$50,$2F,$42,$BC,$F8,$00,$78             ; 0F9C2E wP/B???x
.byte $E4,$C0,$05,$F0,$0A,$F0,$15,$E0             ; 0F9C36 ????????
.byte $2A,$C0,$54,$80,$A8,$00,$50,$05             ; 0F9C3E *?T???P?
.byte $05,$0A,$0A,$15,$15,$2A,$2A,$54             ; 0F9C46 ?????**T
.byte $54,$A8,$A8,$50,$50,$A0,$A0,$00             ; 0F9C4E T??PP???
.byte $1C,$02,$18,$16,$0F,$12,$1F,$01             ; 0F9C56 ????????
.byte $1F,$0F,$1E,$1F,$1B,$03,$0F,$02             ; 0F9C5E ????????
.byte $17,$09,$16,$08,$1C,$00,$11,$09             ; 0F9C66 ????????
.byte $08,$78,$87,$38,$C7,$1F,$E0,$8F             ; 0F9C6E ?x?8????
.byte $F0,$F1,$FF,$F8,$80,$F8,$C0,$BF             ; 0F9C76 ????????
.byte $3F,$1F,$1F,$0F,$0F,$01,$F8,$02             ; 0F9C7E ????????
.byte $F0,$01,$F0,$60,$F8,$F0,$F8,$F0             ; 0F9C86 ???`????
.byte $FC,$F8,$01,$01,$E0,$C0,$F0,$E0             ; 0F9C8E ????????
.byte $40,$1F,$1F,$07,$07,$10,$10,$08             ; 0F9C96 @???????
.byte $00,$CF,$FF,$8F,$1F,$FF,$3F,$FC             ; 0F9C9E ????????
.byte $FE,$F8,$FC,$78,$38,$10,$37,$07             ; 0F9CA6 ???x8?7?
.byte $57,$27,$F7,$07,$E7,$07,$CF,$0C             ; 0F9CAE W'??????
.byte $9E,$98,$FC,$F8,$FC,$38,$78,$C0             ; 0F9CB6 ?????8x?
.byte $40,$FB,$F4,$FF,$FF,$CB,$F5,$CA             ; 0F9CBE @???????
.byte $C8,$1D,$1C,$1A,$1C,$3E,$3A,$3E             ; 0F9CC6 ?????>:>
.byte $0A,$7F,$12,$7F,$38,$10,$0B,$04             ; 0F9CCE ????8???
.byte $17,$27,$14,$07,$30,$43,$FF,$FD             ; 0F9CD6 ?'??0C??
.byte $FC,$04,$6C,$09,$18,$53,$79,$62             ; 0F9CDE ??l??Syb
.byte $F3,$E4,$E4,$88,$F1,$C1,$02,$4F             ; 0F9CE6 ???????O
.byte $FF,$1E,$1E,$0F,$3B,$1B,$79,$49             ; 0F9CEE ????;?yI
.byte $59,$61,$D8,$F0,$88,$F8,$02,$FA             ; 0F9CF6 Ya??????
.byte $97,$7F,$11,$0F,$3C,$07,$3E,$07             ; 0F9CFE ????<?>?
.byte $3E,$07,$3F,$07,$77,$0F,$F5,$0F             ; 0F9D06 >???w???
.byte $E8,$07,$07,$06,$83,$80,$FF,$E0             ; 0F9D0E ????????
.byte $9F,$E9,$11,$C9,$31,$C8,$B0,$4A             ; 0F9D16 ????1??J
.byte $B2,$4E,$B2,$60,$9C,$7B,$C4,$7F             ; 0F9D1E ?N?`?{??
.byte $80,$9E,$E3,$77,$C8,$B5,$EA,$6A             ; 0F9D26 ???w???j
.byte $D5,$04,$FB,$C0,$3F,$80,$FF,$3F             ; 0F9D2E ????????
.byte $FF,$9E,$8A,$7F,$48,$B5,$A0,$6A             ; 0F9D36 ????H??j
.byte $40,$04,$00,$C0,$00,$FF,$3C,$7F             ; 0F9D3E @?????<?
.byte $1C,$71,$7E,$1B,$1C,$1B,$0C,$3E             ; 0F9D46 ?q~????>
.byte $0C,$7E,$1C,$3E,$1E,$38,$C1,$10             ; 0F9D4E ?~?>?8??
.byte $61,$08,$13,$08,$33,$1C,$61,$1C             ; 0F9D56 a???3?a?
.byte $21,$EF,$4F,$FF,$7F,$D7,$5F,$0B             ; 0F9D5E !?O???_?
.byte $0B,$BD,$85,$BD,$91,$10,$FB,$80             ; 0F9D66 ????????
.byte $FF,$0B,$02,$07,$06,$0F,$0E,$03             ; 0F9D6E ????????
.byte $06,$07,$00,$09,$0F,$03,$06,$00             ; 0F9D76 ????????
.byte $07,$FF,$86,$7F,$C4,$BF,$C8,$3F             ; 0F9D7E ????????
.byte $F8,$3F,$FB,$1F,$6F,$FB,$7C,$FA             ; 0F9D86 ????o?|?
.byte $F8,$07,$F9,$07,$7B,$87,$F7,$87             ; 0F9D8E ????{???
.byte $E7,$A7,$E4,$03,$DC,$4B,$BF,$3B             ; 0F9D96 ?????K?;
.byte $FC,$1F,$FF,$0F,$F8,$0F,$7F,$8F             ; 0F9D9E ????????
.byte $07,$FF,$9C,$9B,$54,$57,$AA,$AB             ; 0F9DA6 ????TW??
.byte $E3,$00,$F1,$01,$F7,$00,$F0,$80             ; 0F9DAE ????????
.byte $F8,$F8,$67,$F8,$AB,$FC,$55,$FE             ; 0F9DB6 ??g???U?
.byte $3F,$1F,$FF,$E1,$FF,$01,$FF,$FF             ; 0F9DBE ????????
.byte $EF,$0F,$1F,$01,$21,$20,$06,$F8             ; 0F9DC6 ????! ??
.byte $FE,$0E,$7F,$06,$3E,$0D,$1E,$07             ; 0F9DCE ????>???
.byte $0F,$0D,$0B,$05,$0E,$E1,$06,$00             ; 0F9DD6 ????????
.byte $0C,$30,$00,$AE,$9C,$DE,$C6,$C0             ; 0F9DDE ?0??????
.byte $C1,$D1,$D2,$E3,$E4,$E2,$C0,$7F             ; 0F9DE6 ????????
.byte $C1,$7F,$C3,$7F,$E7,$7F,$E7,$7E             ; 0F9DEE ???????~
.byte $F7,$3B,$FF,$1D,$3F,$6D,$7F,$6D             ; 0F9DF6 ?;???m?m
.byte $7F,$0D,$3E,$05,$1B,$06,$1F,$06             ; 0F9DFE ??>?????
.byte $1F,$03,$1E,$05,$5E,$0D,$5E,$4D             ; 0F9E06 ????^?^M
.byte $7E,$0D,$3B,$01,$1F,$02,$1B,$02             ; 0F9E0E ~?;?????
.byte $1E,$02,$1B,$01,$7A,$FA,$00,$FD             ; 0F9E16 ????z???
.byte $80,$F2,$C0,$C0,$FF,$70,$70,$C2             ; 0F9E1E ?????pp?
.byte $00,$7E,$80,$3E,$40,$3E,$BF,$01             ; 0F9E26 ?~?>@>??
.byte $C1,$C3,$3C,$C0,$FF,$FE,$FE,$71             ; 0F9E2E ??<????q
.byte $71,$70,$70,$36,$30,$0E,$FD,$0F             ; 0F9E36 qpp60???
.byte $FE,$17,$F7,$1F,$71,$1F,$70,$1F             ; 0F9E3E ????q?p?
.byte $30,$1F,$30,$0F,$04,$1F,$04,$09             ; 0F9E46 0?0?????
.byte $02,$05,$1F,$07,$1F,$05,$1F,$05             ; 0F9E4E ????????
.byte $1F,$13,$1F,$13,$0F,$03,$CE,$0F             ; 0F9E56 ????????
.byte $F0,$3F,$3F,$7F,$7F,$63,$7F,$F1             ; 0F9E5E ?????c??
.byte $2F,$3F,$9C,$FF,$1C,$FC,$1B,$F8             ; 0F9E66 /???????
.byte $C0,$FE,$06,$E6,$C7,$FF,$F9,$39             ; 0F9E6E ???????9
.byte $3B,$17,$07,$05,$04,$03,$01,$03             ; 0F9E76 ;???????
.byte $04,$02,$01,$01,$3F,$80,$3E,$F0             ; 0F9E7E ??????>?
.byte $3E,$FF,$1C,$F7,$10,$D2,$10,$D7             ; 0F9E86 >???????
.byte $10,$57,$D0,$FE,$3F,$AB,$FF,$AF             ; 0F9E8E ?W??????
.byte $FF,$EF,$FF,$EE,$FF,$83,$83,$3F             ; 0F9E96 ????????
.byte $9B,$1B,$03,$3F,$03,$3F,$E7,$3C             ; 0F9E9E ???????<
.byte $3F,$FC,$76,$F0,$F4,$F0,$F5,$E1             ; 0F9EA6 ??v?????
.byte $3D,$EF,$FE,$FF,$06,$3F,$FD,$19             ; 0F9EAE =???????
.byte $3F,$FF,$DF,$7F,$30,$3F,$0F,$3A             ; 0F9EB6 ????0??:
.byte $60,$FF,$3F,$F0,$0F,$7B,$39,$80             ; 0F9EBE `????{9?
.byte $C0,$4C,$C0,$12,$6F,$09,$1D,$E9             ; 0F9EC6 ?L??o???
.byte $09,$C0,$48,$0C,$E8,$B3,$E1,$43             ; 0F9ECE ??H????C
.byte $DC,$90,$9C,$00,$42,$65,$D0,$1D             ; 0F9ED6 ????Be??
.byte $39,$08,$0E,$72,$02,$4E,$00,$04             ; 0F9EDE 9??r?N??
.byte $9C,$40,$08,$73,$78,$99,$3C,$73             ; 0F9EE6 ?@?sx?<s
.byte $80,$91,$D0,$10,$8C,$1A,$A1,$28             ; 0F9EEE ???????(
.byte $1E,$98,$91,$03,$29,$D7,$89,$59             ; 0F9EF6 ????)??Y
.byte $CB,$BE,$29,$1B,$8C,$B5,$D8,$65             ; 0F9EFE ??)????e
.byte $D3,$B0,$64,$C7,$45,$93,$3F,$D6             ; 0F9F06 ??d?E???
.byte $31,$F0,$8C,$20,$13,$5F,$6D,$73             ; 0F9F0E 1?? ?_ms
.byte $17,$A6,$7A,$55,$94,$4D,$3B,$46             ; 0F9F16 ??zU?M;F
.byte $D6,$F4,$6E,$9E,$21,$5E,$BA,$6E             ; 0F9F1E ??n?!^?n
.byte $C0,$02,$EC,$B1,$6E,$D7,$ED,$C4             ; 0F9F26 ????n???
.byte $80,$5F,$63,$27,$DA,$BD,$AC,$3D             ; 0F9F2E ?_c'???=
.byte $BC,$F7,$56,$15,$F9,$38,$78,$EA             ; 0F9F36 ??V??8x?
.byte $4F,$97,$87,$68,$63,$A7,$67,$D0             ; 0F9F3E O??hc?g?
.byte $64,$17,$8E,$65,$1D,$C3,$10,$BA             ; 0F9F46 d??e????
.byte $20,$90,$36,$F6,$E2,$13,$6C,$CC             ; 0F9F4E  ?6???l?
.byte $B9,$5F,$E2,$21,$1C,$48,$25,$11             ; 0F9F56 ?_?!?H%?
.byte $C6,$1C,$86,$F8,$00,$93,$7E,$01             ; 0F9F5E ??????~?
.byte $6F,$DD,$8C,$5D,$60,$7C,$5B,$5D             ; 0F9F66 o??]`|[]
.byte $C2,$EE,$DA,$41,$33,$6D,$21,$BE             ; 0F9F6E ???A3m!?
.byte $01,$23,$9D,$C8,$47,$3F,$83,$5F             ; 0F9F76 ?#??G??_
.byte $E4,$EB,$FA,$C1,$F3,$D8,$4D,$7E             ; 0F9F7E ??????M~
.byte $C8,$1B,$1C,$87,$B6,$D3,$D6,$04             ; 0F9F86 ????????
.byte $B7,$D2,$F5,$B8,$0B,$AF,$23,$B7             ; 0F9F8E ??????#?
.byte $60,$3B,$22,$1D,$E0,$03,$53,$C1             ; 0F9F96 `;"???S?
.byte $28,$EE,$E4,$85,$3A,$2A,$32,$9A             ; 0F9F9E (???:*2?
.byte $39,$2F,$18,$DB,$BD,$9F,$1C,$B2             ; 0F9FA6 9/??????
.byte $83,$C2,$08,$07,$D5,$3D,$EE,$13             ; 0F9FAE ?????=??
.byte $D7,$04,$3C,$55,$B6,$D3,$A9,$C2             ; 0F9FB6 ??<U????
.byte $3D,$84,$1E,$D4,$D4,$59,$21,$DD             ; 0F9FBE =????Y!?
.byte $02,$57,$25,$50,$E8,$81,$CF,$CC             ; 0F9FC6 ?W%P????
.byte $22,$E1,$EC,$F2,$EC,$2B,$D8,$78             ; 0F9FCE "????+?x
.byte $F9,$E1,$28,$EA,$75,$3B,$D4,$C1             ; 0F9FD6 ??(?u;??
.byte $F7,$E1,$61,$47,$34,$50,$FE,$F0             ; 0F9FDE ??aG4P??
.byte $94,$71,$F3,$3E,$51,$F9,$D0,$4E             ; 0F9FE6 ?q?>Q??N
.byte $4D,$11,$BB,$56,$ED,$63,$6E,$E6             ; 0F9FEE M??V?cn?
.byte $0B,$94,$B2,$70,$40,$A4,$82,$E9             ; 0F9FF6 ???p@???
.byte $B3,$63,$8D,$26,$C6,$77,$06,$02             ; 0F9FFE ?c?&?w??
.byte $58,$B7,$29,$62,$74,$09,$89,$88             ; 0FA006 X?)bt???
.byte $91,$C1,$70,$97,$16,$2A,$4A,$86             ; 0FA00E ??p??*J?
.byte $09,$B0,$06,$D7,$92,$6C,$01,$C9             ; 0FA016 ?????l??
.byte $C1,$0B,$AF,$43,$38,$8B,$9C,$6B             ; 0FA01E ???C8??k
.byte $AC,$1B,$A6,$11,$C5,$07,$2B,$A6             ; 0FA026 ??????+?
.byte $4F,$27,$19,$E0,$C0,$F2,$E2,$F2             ; 0FA02E O'??????
.byte $F8,$6E,$B6,$F2,$EE,$0D,$83,$78             ; 0FA036 ?n?????x
.byte $BC,$58,$29,$00,$6B,$0C,$40,$F3             ; 0FA03E ?X)?k?@?
.byte $B3,$A8,$02,$1C,$17,$29,$66,$E7             ; 0FA046 ?????)f?
.byte $22,$18,$FE,$1B,$4B,$C2,$1B,$1A             ; 0FA04E "???K???
.byte $D8,$3F,$43,$CC,$94,$06,$C3,$7C             ; 0FA056 ??C????|
.byte $C5,$82,$C0,$1C,$E8,$29,$28,$F0             ; 0FA05E ?????)(?
.byte $23,$08,$9A,$52,$CF,$31,$06,$0D             ; 0FA066 #??R?1??
.byte $A5,$B2,$AF,$4B,$07,$50,$02,$DD             ; 0FA06E ???K?P??
.byte $47,$00,$42,$86,$DD,$52,$74,$71             ; 0FA076 G?B??Rtq
.byte $76,$AB,$07,$25,$84,$3D,$B2,$9D             ; 0FA07E v??%?=??
.byte $B4,$F2,$70,$33,$DB,$B1,$19,$4C             ; 0FA086 ??p3???L
.byte $87,$3D,$C8,$60,$50,$F7,$1E,$30             ; 0FA08E ?=?`P??0
.byte $03,$86,$2D,$B7,$D4,$26,$74,$D2             ; 0FA096 ??-??&t?
.byte $3D,$34,$4E,$4F,$1D,$F4,$73,$12             ; 0FA09E =4NO??s?
.byte $9D,$79,$77,$D2,$0F,$70,$65,$94             ; 0FA0A6 ?yw??pe?
.byte $77,$29,$7C,$AB,$3D,$C0,$96,$10             ; 0FA0AE w)|?=???
.byte $AC,$AE,$CA,$70,$03,$DF,$24,$BD             ; 0FA0B6 ???p??$?
.byte $F0,$49,$DF,$21,$D7,$DF,$5E,$47             ; 0FA0BE ?I?!??^G
.byte $4D,$EA,$C0,$6B,$E8,$97,$66,$33             ; 0FA0C6 M??k??f3
.byte $84,$5F,$40,$3E,$4C,$C9,$DA,$8C             ; 0FA0CE ?_@>L???
.byte $E3,$55,$64,$70,$48,$76,$D4,$12             ; 0FA0D6 ?UdpHv??
.byte $76,$E7,$76,$EC,$05,$E6,$BC,$B8             ; 0FA0DE v?v?????
.byte $63,$C8,$39,$9A,$C8,$1E,$86,$1C             ; 0FA0E6 c?9?????
.byte $C5,$26,$0E,$80,$FA,$46,$2C,$07             ; 0FA0EE ?&???F,?
.byte $93,$64,$1E,$A2,$6C,$3B,$06,$D8             ; 0FA0F6 ?d??l;??
.byte $21,$0B,$A5,$64,$A1,$C7,$9F,$96             ; 0FA0FE !??d????
.byte $30,$07,$70,$CA,$6B,$EA,$0F,$33             ; 0FA106 0?p?k??3
.byte $61,$00,$E7,$03,$23,$E3,$59,$E9             ; 0FA10E a???#?Y?
.byte $80,$17,$8C,$E9,$EF,$32,$65,$DC             ; 0FA116 ?????2e?
.byte $8F,$35,$E0,$1F,$01,$A8,$6D,$94             ; 0FA11E ?5????m?
.byte $1F,$1B,$03,$B6,$D7,$70,$A2,$6A             ; 0FA126 ?????p?j
.byte $A0,$E5,$76,$C9,$DD,$A1,$23,$A1             ; 0FA12E ??v???#?
.byte $14,$A1,$93,$41,$3D,$F3,$FC,$B0             ; 0FA136 ???A=???
.byte $9F,$51,$BC,$C4,$2C,$7C,$62,$8D             ; 0FA13E ?Q??,|b?
.byte $F6,$1A,$12,$7D,$AC,$04,$1F,$72             ; 0FA146 ???}???r
.byte $09,$0E,$4F,$E0,$C1,$F8,$20,$99             ; 0FA14E ??O??? ?
.byte $80,$C8,$E6,$A1,$21,$95,$F8,$AD             ; 0FA156 ????!???
.byte $96,$CA,$F8,$28,$1E,$D8,$E1,$14             ; 0FA15E ???(????
.byte $78,$22,$BF,$B3,$10,$0F,$AA,$71             ; 0FA166 x"?????q
.byte $98,$E1,$F3,$31,$6A,$A2,$E1,$43             ; 0FA16E ???1j??C
.byte $23,$FD,$05,$D9,$E4,$27,$7A,$52             ; 0FA176 #????'zR
.byte $39,$1B,$B0,$3E,$2F,$78,$0B,$EA             ; 0FA17E 9??>/x??
.byte $3C,$BC,$EF,$3C,$1F,$7F,$62,$71             ; 0FA186 <??<??bq
.byte $05,$28,$E3,$A8,$84,$D6,$1B,$01             ; 0FA18E ?(??????
.byte $AF,$8A,$1C,$55,$36,$AF,$F5,$35             ; 0FA196 ???U6??5
.byte $34,$EB,$12,$42,$34,$23,$5B,$A0             ; 0FA19E 4??B4#[?
.byte $65,$32,$9C,$C8,$1B,$0F,$08,$31             ; 0FA1A6 e2?????1
.byte $D3,$90,$26,$B8,$E0,$20,$CB,$15             ; 0FA1AE ??&?? ??
.byte $0B,$BF,$EE,$07,$6D,$98,$6E,$40             ; 0FA1B6 ????m?n@
.byte $0D,$EE,$89,$07,$0E,$01,$C8,$84             ; 0FA1BE ????????
.byte $E5,$20,$B0,$CE,$4E,$BC,$1B,$7C             ; 0FA1C6 ? ??N??|
.byte $DC,$19,$EE,$E7,$0E,$2E,$7D,$82             ; 0FA1CE ?????.}?
.byte $11,$CF,$E3,$6D,$F2,$6C,$F1,$32             ; 0FA1D6 ???m?l?2
.byte $3A,$BF,$61,$0E,$0A,$BB,$21,$D7             ; 0FA1DE :?a???!?
.byte $7B,$D1,$B2,$5D,$78,$BC,$C9,$BF             ; 0FA1E6 {??]x???
.byte $A4,$B5,$95,$48,$EE,$54,$84,$CE             ; 0FA1EE ???H?T??
.byte $09,$66,$FE,$87,$8D,$6D,$B4,$0E             ; 0FA1F6 ?f???m??
.byte $13,$78,$A4,$07,$0B,$82,$4E,$39             ; 0FA1FE ?x????N9
.byte $41,$71,$39,$E3,$C0,$6A,$6A,$5D             ; 0FA206 Aq9??jj]
.byte $D6,$FC,$7C,$0E,$3D,$09,$19,$16             ; 0FA20E ??|?=???
.byte $63,$60,$3E,$E5,$50,$83,$90,$20             ; 0FA216 c`>?P?? 
.byte $93,$BD,$6E,$14,$E4,$58,$49,$BC             ; 0FA21E ??n??XI?
.byte $54,$0E,$48,$0D,$BC,$54,$5C,$20             ; 0FA226 T?H??T\ 
.byte $20,$D8,$57,$D1,$B4,$6A,$8B,$07             ; 0FA22E  ?W??j??
.byte $27,$04,$23,$90,$D1,$21,$B0,$14             ; 0FA236 '?#??!??
.byte $83,$08,$D4,$29,$8B,$44,$19,$D1             ; 0FA23E ???)?D??
.byte $46,$0E,$C0,$63,$7B,$5E,$03,$11             ; 0FA246 F??c{^??
.byte $38,$B7,$C0,$0F,$2D,$9B,$12,$6D             ; 0FA24E 8???-??m
.byte $9C,$0A,$15,$37,$8A,$10,$A7,$16             ; 0FA256 ???7????
.byte $D2,$53,$2E,$31,$2F,$32,$BC,$9E             ; 0FA25E ?S.1/2??
.byte $8B,$38,$0F,$09,$35,$96,$C7,$2F             ; 0FA266 ?8??5??/
.byte $B9,$CF,$34,$47,$3A,$A8,$01,$79             ; 0FA26E ??4G:??y
.byte $45,$CE,$7C,$8C,$33,$B1,$84,$BA             ; 0FA276 E?|?3???
.byte $03,$80,$E1,$29,$CB,$E0,$97,$1A             ; 0FA27E ???)????
.byte $7F,$21,$A0,$85,$CC,$D6,$32,$9A             ; 0FA286 ?!????2?
.byte $55,$80,$C2,$28,$3D,$18,$51,$80             ; 0FA28E U??(=?Q?
.byte $1C,$72,$30,$EB,$FB,$60,$DF,$36             ; 0FA296 ?r0??`?6
.byte $6B,$A5,$B1,$1E,$9A,$54,$A0,$36             ; 0FA29E k????T?6
.byte $A4,$30,$73,$91,$B8,$D4,$4E,$1A             ; 0FA2A6 ?0s???N?
.byte $13,$47,$02,$49,$A3,$BA,$57,$A4             ; 0FA2AE ?G?I??W?
.byte $54,$EF,$FA,$36,$0D,$4A,$F2,$16             ; 0FA2B6 T??6?J??
.byte $27,$A0,$61,$BF,$4A,$5C,$25,$96             ; 0FA2BE '?a?J\%?
.byte $4D,$1B,$38,$23,$26,$A3,$A9,$DF             ; 0FA2C6 M?8#&???
.byte $34,$F2,$D5,$B8,$84,$4F,$40,$9E             ; 0FA2CE 4????O@?
.byte $64,$04,$6B,$22,$56,$D6,$68,$24             ; 0FA2D6 d?k"V?h$
.byte $1B,$56,$76,$AC,$1B,$50,$20,$E8             ; 0FA2DE ?Vv??P ?
.byte $DE,$2C,$09,$D4,$C6,$E5,$BB,$0B             ; 0FA2E6 ?,??????
.byte $88,$E1,$80,$C2,$5B,$D4,$EE,$DF             ; 0FA2EE ????[???
.byte $2E,$DD,$54,$F3,$6C,$BB,$8D,$51             ; 0FA2F6 .?T?l??Q
.byte $EB,$C8,$24,$BA,$7F,$FA,$FD,$05             ; 0FA2FE ??$?????
.byte $D6,$EE,$0D,$C0,$09,$3D,$00,$09             ; 0FA306 ?????=??
.byte $39,$37,$DD,$74,$7A,$E1,$90,$E5             ; 0FA30E 97?tz???
.byte $7F,$DB,$80,$83,$6D,$DC,$20,$00             ; 0FA316 ????m? ?
.byte $08,$C8,$01,$00,$20,$00,$20,$01             ; 0FA31E ???? ? ?
.byte $24,$02,$24,$03,$24,$04,$24,$05             ; 0FA326 $?$?$?$?
.byte $24,$06,$24,$07,$28,$08,$28,$09             ; 0FA32E $?$?(?(?
.byte $24,$0A,$24,$0B,$24,$0C,$24,$0D             ; 0FA336 $?$?$?$?
.byte $28,$0E,$0F,$24,$10,$24,$11,$24             ; 0FA33E (??$?$?$
.byte $12,$24,$13,$14,$15,$16,$24,$17             ; 0FA346 ?$????$?
.byte $24,$18,$24,$19,$24,$1A,$28,$1B             ; 0FA34E $?$?$?(?
.byte $28,$1C,$24,$1D,$24,$1E,$24,$1F             ; 0FA356 (?$?$?$?
.byte $24,$20,$24,$21,$11,$24,$22,$24             ; 0FA35E $ $!?$"$
.byte $23,$00,$20,$24,$24,$25,$26,$24             ; 0FA366 #? $$%&$
.byte $27,$24,$28,$24,$29,$24,$2A,$28             ; 0FA36E '$($)$*(
.byte $2B,$28,$2C,$24,$2D,$24,$2E,$24             ; 0FA376 +(,$-$.$
.byte $2F,$24,$30,$24,$31,$00,$20,$32             ; 0FA37E /$0$1? 2
.byte $24,$33,$24,$34,$24,$35,$24,$36             ; 0FA386 $3$4$5$6
.byte $37,$24,$38,$24,$39,$3A,$24,$3B             ; 0FA38E 7$8$9:$;
.byte $24,$3C,$24,$3D,$24,$3E,$28,$3F             ; 0FA396 $<$=$>(?
.byte $40,$24,$41,$24,$42,$24,$43,$24             ; 0FA39E @$A$B$C$
.byte $44,$45,$24,$46,$24,$47,$24,$48             ; 0FA3A6 DE$F$G$H
.byte $24,$49,$00,$20,$4A,$24,$4B,$24             ; 0FA3AE $I? J$K$
.byte $4C,$24,$4D,$4E,$24,$4F,$28,$50             ; 0FA3B6 L$MN$O(P
.byte $51,$24,$52,$24,$53,$54,$24,$55             ; 0FA3BE Q$R$ST$U
.byte $24,$56,$24,$57,$24,$54,$A8,$58             ; 0FA3C6 $V$W$T?X
.byte $28,$59,$5A,$24,$5B,$24,$5C,$5D             ; 0FA3CE (YZ$[$\]
.byte $24,$5E,$24,$5F,$24,$60,$24,$61             ; 0FA3D6 $^$_$`$a
.byte $24,$62,$24,$63,$00,$20,$64,$24             ; 0FA3DE $b$c? d$
.byte $65,$02,$64,$01,$64,$08,$68,$07             ; 0FA3E6 e?d?d?h?
.byte $68,$06,$64,$05,$64,$04,$64,$03             ; 0FA3EE h?d?d?d?
.byte $66,$0E,$68,$0D,$68,$0C,$64,$0B             ; 0FA3F6 f?h?h?d?
.byte $64,$0A,$64,$09,$13,$64,$12,$64             ; 0FA3FE d?d??d?d
.byte $11,$64,$10,$64,$0F,$14,$11,$24             ; 0FA406 ?d?d???$
.byte $67,$1B,$68,$1A,$68,$19,$64,$18             ; 0FA40E g?h?h?d?
.byte $64,$17,$64,$16,$21,$64,$20,$64             ; 0FA416 d?d?!d d
.byte $1F,$64,$1E,$64,$1D,$64,$1C,$64             ; 0FA41E ?d?d?d?d
.byte $23,$64,$22,$68,$24,$69,$24,$6A             ; 0FA426 #d"h$i$j
.byte $2B,$68,$2A,$68,$29,$64,$28,$64             ; 0FA42E +h*h)d(d
.byte $27,$64,$26,$31,$64,$30,$64,$2F             ; 0FA436 'd&1d0d/
.byte $64,$2E,$64,$2D,$64,$2C,$64,$36             ; 0FA43E d.d-d,d6
.byte $64,$35,$64,$34,$64,$33,$64,$32             ; 0FA446 d5d4d3d2
.byte $6B,$24,$6C,$24,$6D,$24,$6E,$3F             ; 0FA44E k$l$m$n?
.byte $68,$3E,$68,$3D,$64,$3C,$64,$3B             ; 0FA456 h>h=d<d;
.byte $64,$3A,$44,$64,$43,$64,$42,$64             ; 0FA45E d:DdCdBd
.byte $41,$64,$40,$49,$64,$48,$64,$47             ; 0FA466 Ad@IdHdG
.byte $64,$46,$64,$45,$6F,$24,$70,$24             ; 0FA46E dFdEo$p$
.byte $71,$24,$72,$50,$68,$4F,$68,$4E             ; 0FA476 q$rPhOhN
.byte $53,$64,$52,$64,$51,$73,$24,$74             ; 0FA47E SdRdQs$t
.byte $24,$75,$59,$68,$58,$68,$54,$E8             ; 0FA486 $uYhXhT?
.byte $5C,$64,$5B,$64,$5A,$76,$24,$77             ; 0FA48E \d[dZv$w
.byte $24,$78,$79,$24,$7A,$24,$7B,$15             ; 0FA496 $xy$z${?
.byte $66,$25,$64,$24,$67,$39,$64,$38             ; 0FA49E f%d$g9d8
.byte $64,$37,$6A,$64,$69,$64,$68,$4D             ; 0FA4A6 d7jdidhM
.byte $64,$4C,$64,$4B,$64,$4A,$6E,$64             ; 0FA4AE dLdKdJnd
.byte $6D,$64,$6C,$64,$6B,$57,$64,$56             ; 0FA4B6 mdldkWdV
.byte $64,$55,$64,$54,$72,$64,$71,$64             ; 0FA4BE dUdTrdqd
.byte $70,$64,$6F,$60,$64,$5F,$64,$5E             ; 0FA4C6 pdo`d_d^
.byte $64,$5D,$75,$64,$74,$64,$73,$63             ; 0FA4CE d]udtdsc
.byte $64,$62,$64,$61,$78,$64,$77,$64             ; 0FA4D6 dbdaxdwd
.byte $76,$65,$64,$64,$7B,$64,$7A,$64             ; 0FA4DE vedd{dzd
.byte $79,$06,$08,$30,$4D,$89,$B1,$4D             ; 0FA4E6 y??0M??M
.byte $41,$49,$0D,$C0,$9C,$C5,$39,$82             ; 0FA4EE AI????9?
.byte $90,$BB,$FC,$0F,$16,$3B,$B0,$5C             ; 0FA4F6 ?????;?\
.byte $CA,$37,$52,$0C,$2B,$E5,$BE,$01             ; 0FA4FE ?7R?+???
.byte $0F,$B2,$0C,$3F,$48,$30,$AF,$0B             ; 0FA506 ????H0??
.byte $61,$78,$D8,$EE,$22,$1E,$56,$B0             ; 0FA50E ax??"?V?
.byte $BC,$FE,$07,$A5,$8C,$0F,$5B,$18             ; 0FA516 ??????[?
.byte $1E,$D6,$BB,$C0,$21,$EF,$EA,$78             ; 0FA51E ????!??x
.byte $F8,$70,$5F,$9A,$48,$0F,$14,$A4             ; 0FA526 ?p_?H???
.byte $3E,$FD,$4F,$9F,$0F,$A7,$FB,$49             ; 0FA52E >?O????I
.byte $01,$F2,$94,$C1,$A1,$02,$1C,$0B             ; 0FA536 ????????
.byte $45,$61,$E3,$94,$58,$39,$01,$04             ; 0FA53E Ea??X9??
.byte $C7,$C2,$17,$A5,$DE,$D0,$3B,$00             ; 0FA546 ??????;?
.byte $4E,$E0,$53,$BE,$12,$CB,$91,$85             ; 0FA54E N?S?????
.byte $ED,$B7,$C4,$08,$1F,$1B,$F2,$00             ; 0FA556 ????????
.byte $BA,$5D,$19,$CF,$91,$85,$F3,$77             ; 0FA55E ?]?????w
.byte $D4,$09,$0F,$60,$09,$F2,$7F,$3C             ; 0FA566 ???`???<
.byte $02,$1D,$3B,$61,$7D,$ED,$F9,$02             ; 0FA56E ??;a}???
.byte $43,$E8,$08,$1F,$7B,$19,$75,$ED             ; 0FA576 C???{?u?
.byte $85,$FB,$D7,$F4,$08,$1F,$DB,$FE             ; 0FA57E ????????
.byte $02,$07,$EF,$46,$5C,$DD,$B0,$ED             ; 0FA586 ???F\???
.byte $EC,$1E,$08,$29,$C2,$04,$87,$84             ; 0FA58E ???)????
.byte $A3,$0E,$7E,$46,$4E,$13,$01,$C5             ; 0FA596 ??~FN???
.byte $05,$38,$C0,$90,$F0,$F4,$61,$D1             ; 0FA59E ?8????a?
.byte $CA,$83,$0F,$22,$54,$1E,$65,$28             ; 0FA5A6 ???"T?e(
.byte $1A,$DE,$10,$3A,$50,$29,$B3,$00             ; 0FA5AE ???:P)??
.byte $B8,$4A,$BD,$80,$0B,$52,$E0,$AE             ; 0FA5B6 ?J???R??
.byte $DC,$02,$7B,$2E,$3D,$C0,$0B,$6F             ; 0FA5BE ??{.=??o
.byte $22,$F6,$91,$13,$76,$04,$3D,$D7             ; 0FA5C6 "???v?=?
.byte $1F,$00,$10,$F7,$64,$11,$DF,$81             ; 0FA5CE ????d???
.byte $2E,$F6,$D6,$5F,$0C,$80,$BC,$30             ; 0FA5D6 .??_???0
.byte $09,$7C,$B7,$E8,$02,$5F,$2D,$80             ; 0FA5DE ?|???_-?
.byte $BC,$70,$09,$7D,$37,$EC,$00,$87             ; 0FA5E6 ?p?}7???
.byte $52,$E2,$0C,$3E,$DB,$06,$1D,$4B             ; 0FA5EE R??>???K
.byte $88,$B3,$F1,$B0,$61,$D4,$BA,$0B             ; 0FA5F6 ????a???
.byte $CD,$04,$54,$80,$00,$08,$B2,$00             ; 0FA5FE ??T?????
.byte $00,$20,$00,$20,$07,$28,$08,$28             ; 0FA606 ? ? ?(?(
.byte $08,$68,$07,$68,$7C,$2C,$7D,$2C             ; 0FA60E ?h?h|,},
.byte $7D,$6C,$7C,$6C,$7E,$28,$7F,$28             ; 0FA616 }l|l~(?(
.byte $0D,$28,$0E,$28,$0E,$68,$0D,$68             ; 0FA61E ?(?(?h?h
.byte $7F,$68,$7E,$80,$2C,$81,$2C,$82             ; 0FA626 ?h~?,?,?
.byte $2C,$82,$6C,$81,$6C,$80,$83,$28             ; 0FA62E ,?l?l??(
.byte $84,$28,$1A,$28,$1B,$28,$1B,$68             ; 0FA636 ?(?(?(?h
.byte $1A,$68,$84,$68,$83,$85,$2C,$86             ; 0FA63E ?h?h??,?
.byte $2C,$87,$2C,$88,$2C,$88,$6C,$87             ; 0FA646 ,?,?,?l?
.byte $6C,$86,$6C,$85,$89,$28,$8A,$28             ; 0FA64E l?l??(?(
.byte $2A,$28,$2B,$28,$2B,$68,$2A,$68             ; 0FA656 *(+(+h*h
.byte $8A,$68,$89,$8B,$2C,$8C,$2C,$8D             ; 0FA65E ?h??,?,?
.byte $2C,$8E,$2C,$8E,$6C,$8D,$6C,$8C             ; 0FA666 ,?,?l?l?
.byte $6C,$8B,$8F,$28,$3E,$28,$3F,$28             ; 0FA66E l??(>(?(
.byte $3F,$68,$3E,$68,$8F,$90,$2C,$91             ; 0FA676 ?h>h??,?
.byte $2C,$92,$2C,$92,$6C,$91,$6C,$90             ; 0FA67E ,?,?l?l?
.byte $93,$28,$94,$28,$50,$28,$50,$68             ; 0FA686 ?(?(P(Ph
.byte $94,$68,$93,$95,$2C,$96,$2C,$97             ; 0FA68E ?h??,?,?
.byte $2C,$97,$6C,$96,$6C,$95,$54,$A8             ; 0FA696 ,?l?l?T?
.byte $58,$28,$59,$28,$59,$68,$58,$68             ; 0FA69E X(Y(YhXh
.byte $54,$E8,$AC,$98,$2C,$99,$2C,$99             ; 0FA6A6 T???,?,?
.byte $6C,$98,$6C,$54,$EC,$9A,$28,$9B             ; 0FA6AE l?lT??(?
.byte $06,$0C,$13,$02,$98,$0A,$9B,$41             ; 0FA6B6 ???????A
.byte $20,$36,$82,$90,$1D,$80,$49,$5D             ; 0FA6BE  6????I]
.byte $4C,$06,$17,$73,$01,$95,$E5,$D5             ; 0FA6C6 L??s????
.byte $95,$ED,$55,$95,$DA,$EA,$CA,$EB             ; 0FA6CE ??U?????
.byte $50,$18,$5C,$A6,$0B,$0B,$9C,$C1             ; 0FA6D6 P?\?????
.byte $61,$7A,$A8,$2C,$2F,$75,$05,$90             ; 0FA6DE az?,/u??
.byte $F6,$C0,$B0,$B8,$00,$11,$37,$D8             ; 0FA6E6 ??????7?
.byte $11,$30,$41,$54,$C6,$E3,$14,$04             ; 0FA6EE ?0AT????
.byte $3B,$28,$C6,$C4,$ED,$20,$0C,$88             ; 0FA6F6 ;(??? ??
.byte $4C,$AE,$32,$40,$03,$C1,$93,$2B             ; 0FA6FE L?2@???+
.byte $13,$C4,$80,$33,$21,$33,$B8,$CD             ; 0FA706 ???3!3??
.byte $00,$0F,$46,$4C,$EC,$4F,$52,$00             ; 0FA70E ??FL?OR?
.byte $D0,$84,$D2,$E3,$44,$00,$3E,$19             ; 0FA716 ????D?>?
.byte $34,$B1,$34,$40,$13,$52,$83,$5B             ; 0FA71E 4?4@?R?[
.byte $8D,$50,$04,$FC,$80,$D6,$C4,$FD             ; 0FA726 ?P??????
.byte $20,$4C,$C5,$06,$6B,$8C,$C8,$02             ; 0FA72E  L??k???
.byte $70,$20,$33,$58,$9C,$12,$04,$CE             ; 0FA736 p 3X????
.byte $50,$67,$B8,$CE,$80,$27,$12,$03             ; 0FA73E Pg???'??
.byte $3D,$89,$9D,$04,$0D,$25,$2A,$8E             ; 0FA746 =????%*?
.byte $A4,$54,$5C,$35,$09,$AF,$44,$3A             ; 0FA74E ?T\5??D:
.byte $8C,$18,$6A,$43,$AA,$C0,$6C,$91             ; 0FA756 ??jC??l?
.byte $31,$54,$26,$CD,$00,$EC,$12,$62             ; 0FA75E 1T&????b
.byte $A1,$4E,$CB,$01,$B6,$44,$C7,$50             ; 0FA766 ?N???D?P
.byte $9B,$74,$03,$B8,$49,$8E,$85,$3B             ; 0FA76E ?t??I??;
.byte $AC,$06,$E9,$13,$25,$42,$6E,$D0             ; 0FA776 ????%Bn?
.byte $0F,$01,$26,$4A,$14,$DD,$A0,$9B             ; 0FA77E ??&J????
.byte $E6,$0C,$B5,$09,$BF,$41,$3C,$88             ; 0FA786 ?????A<?
.byte $19,$68,$53,$CA,$C2,$70,$98,$33             ; 0FA78E ?hS??p?3
.byte $54,$27,$0D,$04,$F4,$20,$66,$A1             ; 0FA796 T'??? f?
.byte $4F,$4B,$09,$C6,$60,$CF,$50,$9C             ; 0FA79E OK??`?P?
.byte $74,$13,$D8,$81,$9E,$85,$38,$E8             ; 0FA7A6 t?????8?
.byte $AA,$3F,$3F,$44,$67,$AC,$EF,$E9             ; 0FA7AE ???Dg???
.byte $80,$FB,$72,$A9,$00,$08,$55,$00             ; 0FA7B6 ??r???U?
.byte $00,$20,$00,$20,$7C,$2C,$7D,$2C             ; 0FA7BE ? ? |,},
.byte $7D,$6C,$7C,$6C,$80,$2C,$81,$2C             ; 0FA7C6 }l|l?,?,
.byte $82,$82,$6C,$81,$6C,$80,$85,$2C             ; 0FA7CE ??l?l??,
.byte $86,$2C,$87,$2C,$88,$88,$6C,$87             ; 0FA7D6 ?,?,??l?
.byte $6C,$86,$6C,$85,$8B,$2C,$8C,$2C             ; 0FA7DE l?l??,?,
.byte $8D,$2C,$8E,$8E,$6C,$8D,$6C,$8C             ; 0FA7E6 ?,??l?l?
.byte $6C,$8B,$00,$20,$90,$2C,$91,$2C             ; 0FA7EE l?? ?,?,
.byte $92,$92,$6C,$91,$6C,$90,$95,$2C             ; 0FA7F6 ??l?l??,
.byte $96,$2C,$97,$97,$6C,$96,$6C,$95             ; 0FA7FE ?,??l?l?
.byte $54,$AC,$98,$2C,$99,$99,$6C,$98             ; 0FA806 T??,??l?
.byte $6C,$54,$EC,$06,$0C,$13,$02,$98             ; 0FA80E lT??????
.byte $0A,$9B,$60,$20,$E3,$10,$6E,$10             ; 0FA816 ??` ??n?
.byte $39,$C2,$90,$ED,$6C,$3B,$BA,$3C             ; 0FA81E 9???l;?<
.byte $40,$1C,$70,$84,$BD,$5B,$2F,$72             ; 0FA826 @?p??[/r
.byte $0F,$8C,$27,$9C,$21,$2E,$EB,$65             ; 0FA82E ??'?!.?e
.byte $DF,$62,$3C,$38,$42,$5E,$56,$C3             ; 0FA836 ?b<8B^V?
.byte $A5,$D1,$E9,$00,$74,$E1,$48,$7B             ; 0FA83E ????t?H{
.byte $5B,$0F,$79,$15,$F1,$C2,$90,$FA             ; 0FA846 [?y?????
.byte $B6,$4F,$74,$29,$F3,$85,$30,$00             ; 0FA84E ?Ot)??0?
.byte $10,$37,$E8,$45,$30,$B8,$04,$C6             ; 0FA856 ?7?E0???
.byte $C1,$0E,$C6,$53,$B4,$94,$CA,$64             ; 0FA85E ???S???d
.byte $32,$C1,$4F,$04,$00,$F1,$24,$33             ; 0FA866 2?O???$3
.byte $91,$4C,$F0,$43,$D0,$81,$3D,$49             ; 0FA86E ?L?C??=I
.byte $0D,$24,$53,$4C,$10,$F8,$20,$4D             ; 0FA876 ?$SL?? M
.byte $30,$53,$59,$90,$D7,$05,$3F,$10             ; 0FA87E 0SY?????
.byte $03,$F4,$94,$CD,$32,$19,$B0,$53             ; 0FA886 ????2??S
.byte $80,$80,$1C,$12,$53,$3C,$C8,$67             ; 0FA88E ????S<?g
.byte $C1,$4E,$22,$00,$67,$C1,$54,$74             ; 0FA896 ?N"?g?Tt
.byte $8E,$AA,$3C,$F2,$55,$1E,$B8,$AA             ; 0FA89E ??<?U???
.byte $8F,$7C,$15,$47,$CD,$EA,$A3,$EE             ; 0FA8A6 ?|?G????
.byte $E5,$51,$FE,$C8,$0C,$00,$08,$26             ; 0FA8AE ?Q?????&
.byte $02,$00,$20,$00,$20,$00,$20,$01             ; 0FA8B6 ?? ? ? ?
.byte $24,$02,$24,$03,$24,$04,$24,$05             ; 0FA8BE $?$?$?$?
.byte $24,$06,$24,$07,$24,$08,$28,$09             ; 0FA8C6 $?$?$?(?
.byte $28,$0A,$28,$0B,$24,$0C,$24,$0D             ; 0FA8CE (?(?$?$?
.byte $24,$0E,$24,$0F,$24,$10,$28,$11             ; 0FA8D6 $?$?$?(?
.byte $12,$24,$13,$24,$14,$24,$15,$28             ; 0FA8DE ?$?$?$?(
.byte $16,$28,$17,$24,$18,$28,$19,$00             ; 0FA8E6 ?(?$?(??
.byte $20,$1A,$1B,$24,$1C,$24,$1D,$24             ; 0FA8EE  ??$?$?$
.byte $1E,$24,$1F,$28,$20,$28,$21,$28             ; 0FA8F6 ?$?( (!(
.byte $22,$24,$23,$24,$24,$24,$25,$24             ; 0FA8FE "$#$$$%$
.byte $26,$28,$27,$28,$24,$29,$24,$2A             ; 0FA906 &('($)$*
.byte $28,$2B,$00,$20,$2C,$24,$2D,$28             ; 0FA90E (+? ,$-(
.byte $2E,$2F,$24,$30,$24,$31,$24,$32             ; 0FA916 ./$0$1$2
.byte $24,$33,$28,$34,$28,$35,$28,$36             ; 0FA91E $3(4(5(6
.byte $24,$37,$24,$38,$24,$39,$24,$3A             ; 0FA926 $7$8$9$:
.byte $24,$3B,$24,$00,$20,$3C,$24,$3D             ; 0FA92E $;$? <$=
.byte $24,$3E,$24,$3F,$24,$40,$00,$20             ; 0FA936 $>$?$@? 
.byte $41,$24,$42,$24,$43,$28,$44,$24             ; 0FA93E A$B$C(D$
.byte $45,$24,$46,$24,$47,$28,$48,$28             ; 0FA946 E$F$G(H(
.byte $49,$4A,$24,$4B,$24,$4C,$24,$4D             ; 0FA94E IJ$K$L$M
.byte $24,$4E,$24,$4F,$24,$50,$24,$51             ; 0FA956 $N$O$P$Q
.byte $24,$52,$24,$53,$24,$54,$55,$24             ; 0FA95E $R$S$TU$
.byte $56,$24,$57,$24,$58,$59,$28,$5A             ; 0FA966 V$W$XY(Z
.byte $28,$5B,$28,$5C,$24,$5D,$24,$5E             ; 0FA96E ([(\$]$^
.byte $24,$5F,$60,$24,$61,$24,$62,$24             ; 0FA976 $_`$a$b$
.byte $63,$24,$64,$28,$65,$28,$66,$67             ; 0FA97E c$d(e(fg
.byte $24,$68,$24,$69,$6A,$24,$6B,$24             ; 0FA986 $h$ij$k$
.byte $6C,$6D,$28,$6E,$28,$6F,$70,$24             ; 0FA98E lm(n(op$
.byte $71,$72,$24,$73,$24,$74,$24,$75             ; 0FA996 qr$s$t$u
.byte $24,$00,$20,$76,$77,$24,$78,$03             ; 0FA99E $? vw$x?
.byte $64,$02,$64,$01,$64,$09,$68,$08             ; 0FA9A6 d?d?d?h?
.byte $68,$07,$64,$06,$64,$05,$64,$04             ; 0FA9AE h?d?d?d?
.byte $0A,$68,$79,$28,$7A,$11,$68,$10             ; 0FA9B6 ?hy(z?h?
.byte $68,$0F,$64,$0E,$64,$0D,$64,$0C             ; 0FA9BE h?d?d?d?
.byte $64,$0B,$16,$68,$15,$68,$14,$64             ; 0FA9C6 d??h?h?d
.byte $13,$64,$12,$19,$68,$18,$68,$17             ; 0FA9CE ?d??h?h?
.byte $7B,$24,$7C,$28,$21,$68,$20,$68             ; 0FA9D6 {$|(!h h
.byte $1F,$68,$1E,$64,$1D,$64,$1C,$64             ; 0FA9DE ?h?d?d?d
.byte $1B,$27,$68,$26,$68,$25,$64,$24             ; 0FA9E6 ?'h&h%d$
.byte $64,$23,$64,$22,$64,$2B,$68,$2A             ; 0FA9EE d#d"d+h*
.byte $68,$29,$64,$28,$7D,$24,$7E,$35             ; 0FA9F6 h)d(}$~5
.byte $68,$34,$68,$33,$68,$32,$64,$31             ; 0FA9FE h4h3h2d1
.byte $64,$30,$64,$2F,$3B,$64,$3A,$64             ; 0FAA06 d0d/;d:d
.byte $39,$64,$38,$64,$37,$64,$36,$64             ; 0FAA0E 9d8d7d6d
.byte $40,$64,$3F,$64,$3E,$64,$3D,$64             ; 0FAA16 @d?d>d=d
.byte $3C,$7F,$24,$80,$24,$81,$24,$82             ; 0FAA1E <?$?$?$?
.byte $49,$68,$48,$68,$47,$68,$46,$64             ; 0FAA26 IhHhGhFd
.byte $45,$64,$44,$4E,$64,$4D,$64,$4C             ; 0FAA2E EdDNdMdL
.byte $64,$4B,$64,$4A,$54,$64,$53,$64             ; 0FAA36 dKdJTdSd
.byte $52,$64,$51,$64,$50,$64,$4F,$69             ; 0FAA3E RdQdPdOi
.byte $E4,$83,$24,$84,$24,$85,$24,$86             ; 0FAA46 ??$?$?$?
.byte $24,$5B,$68,$5A,$68,$59,$5F,$64             ; 0FAA4E $[hZhY_d
.byte $5E,$64,$5D,$64,$5C,$87,$24,$88             ; 0FAA56 ^d]d\?$?
.byte $24,$89,$24,$8A,$24,$8B,$24,$66             ; 0FAA5E $?$?$?$f
.byte $68,$65,$68,$64,$69,$64,$68,$64             ; 0FAA66 hehdidhd
.byte $67,$8C,$24,$8D,$24,$8E,$24,$8F             ; 0FAA6E g?$?$?$?
.byte $6F,$68,$6E,$68,$6D,$71,$64,$70             ; 0FAA76 ohnhmqdp
.byte $90,$24,$91,$24,$92,$76,$1A,$7A             ; 0FAA7E ?$?$?v?z
.byte $68,$79,$2E,$68,$2D,$68,$2C,$7C             ; 0FAA86 hy.h-h,|
.byte $68,$7B,$43,$68,$42,$64,$41,$7E             ; 0FAA8E h{ChBdA~
.byte $68,$7D,$58,$64,$57,$64,$56,$64             ; 0FAA96 h}XdWdVd
.byte $55,$82,$64,$81,$64,$80,$64,$7F             ; 0FAA9E U?d?d?d?
.byte $63,$64,$62,$64,$61,$64,$60,$86             ; 0FAAA6 cdbdad`?
.byte $64,$85,$64,$84,$64,$83,$64,$69             ; 0FAAAE d?d?d?di
.byte $A4,$6C,$64,$6B,$64,$6A,$8B,$64             ; 0FAAB6 ?ldkdj?d
.byte $8A,$64,$89,$64,$88,$64,$87,$75             ; 0FAABE ?d?d?d?u
.byte $64,$74,$64,$73,$64,$72,$8F,$64             ; 0FAAC6 dtdsdr?d
.byte $8E,$64,$8D,$64,$8C,$78,$64,$77             ; 0FAACE ?d?d?xdw
.byte $92,$64,$91,$64,$90,$21,$80,$6C             ; 0FAAD6 ?d?d?!?l
.byte $0D,$82,$66,$0A,$7A,$24,$86,$E8             ; 0FAADE ??f?z$??
.byte $08,$E6,$29,$CC,$10,$91,$DF,$E1             ; 0FAAE6 ??)?????
.byte $38,$C0,$DD,$88,$79,$B0,$67,$A9             ; 0FAAEE 8???y?g?
.byte $59,$07,$CB,$7B,$42,$5F,$6D,$65             ; 0FAAF6 Y??{B_me
.byte $FA,$C6,$44,$E1,$84,$2F,$1B,$18             ; 0FAAFE ??D??/??
.byte $0E,$14,$1C,$C0,$85,$E7,$F0,$9D             ; 0FAB06 ????????
.byte $30,$85,$EB,$6F,$40,$25,$ED,$6B             ; 0FAB0E 0??o@%?k
.byte $BC,$02,$1E,$FE,$A4,$06,$0B,$F1             ; 0FAB16 ????????
.byte $49,$01,$E2,$94,$87,$DF,$A9,$F3             ; 0FAB1E I???????
.byte $E1,$F4,$FF,$69,$21,$FC,$E0,$EE             ; 0FAB26 ???i!???
.byte $92,$43,$BF,$EA,$70,$7C,$E0,$5B             ; 0FAB2E ?C??p|?[
.byte $C3,$49,$01,$C1,$4A,$4F,$1F,$8B             ; 0FAB36 ?I??JO??
.byte $C9,$4A,$72,$D0,$13,$C4,$AF,$2E             ; 0FAB3E ?Jr????.
.byte $29,$D0,$89,$26,$0A,$0A,$98,$F4             ; 0FAB46 )??&????
.byte $10,$BD,$32,$F6,$81,$1D,$80,$07             ; 0FAB4E ??2?????
.byte $70,$29,$DF,$09,$39,$76,$C8,$F6             ; 0FAB56 p)??9v??
.byte $DF,$88,$10,$3E,$3A,$30,$F4,$C8             ; 0FAB5E ???>:0??
.byte $B0,$66,$50,$48,$F9,$CF,$A8,$12             ; 0FAB66 ?fPH????
.byte $1E,$C0,$4B,$E7,$20,$CE,$9C,$8C             ; 0FAB6E ??K? ???
.byte $8F,$BD,$FC,$81,$21,$F4,$04,$0F             ; 0FAB76 ????!???
.byte $BD,$8C,$BA,$F6,$C2,$FD,$EB,$FA             ; 0FAB7E ????????
.byte $04,$0F,$ED,$FF,$01,$0B,$FD,$B0             ; 0FAB86 ????????
.byte $99,$BC,$21,$D7,$A8,$3C,$10,$53             ; 0FAB8E ??!??<?S
.byte $84,$09,$2E,$FF,$E1,$33,$F8,$43             ; 0FAB96 ??.??3?C
.byte $C2,$50,$78,$A0,$A7,$18,$12,$1D             ; 0FAB9E ?Px?????
.byte $ED,$B2,$E8,$E4,$61,$E3,$28,$3C             ; 0FABA6 ????a?(<
.byte $90,$53,$94,$00,$4F,$1F,$58,$74             ; 0FABAE ?S??O?Xt
.byte $EE,$0D,$AF,$54,$79,$A4,$A7,$38             ; 0FABB6 ???Ty??8
.byte $94,$C0,$62,$29,$AE,$A1,$0D,$78             ; 0FABBE ??b)???x
.byte $0A,$74,$A0,$53,$66,$01,$75,$55             ; 0FABC6 ?t?Sf?uU
.byte $7B,$00,$4F,$55,$41,$5D,$B8,$10             ; 0FABCE {?OUA]??
.byte $EE,$F4,$76,$A0,$13,$A9,$90,$47             ; 0FABD6 ??v????G
.byte $72,$01,$0F,$76,$5F,$00,$04,$F7             ; 0FABDE r??v_???
.byte $64,$11,$DF,$81,$2E,$F6,$D6,$5F             ; 0FABE6 d???.??_
.byte $0C,$80,$BC,$30,$09,$7C,$B7,$E8             ; 0FABEE ???0?|??
.byte $02,$13,$CB,$C0,$07,$1C,$12,$1F             ; 0FABF6 ????????
.byte $46,$FB,$00,$81,$F2,$D8,$03,$CB             ; 0FABFE F???????
.byte $00,$97,$DB,$BF,$00,$09,$7C,$B6             ; 0FAC06 ??????|?
.byte $02,$F3,$C8,$27,$E3,$A3,$F4,$20             ; 0FAC0E ???'??? 
.byte $87,$53,$22,$AF,$3D,$01,$13,$F6             ; 0FAC16 ?S"?=???
.byte $80,$84,$00,$08,$C4,$00,$00,$20             ; 0FAC1E ??????? 
.byte $00,$20,$0A,$28,$08,$28,$09,$28             ; 0FAC26 ? ?(?(?(
.byte $09,$68,$08,$68,$0A,$68,$93,$24             ; 0FAC2E ?h?h?h?$
.byte $94,$24,$94,$64,$93,$64,$95,$28             ; 0FAC36 ?$?d?d?(
.byte $96,$28,$10,$28,$11,$28,$11,$68             ; 0FAC3E ?(?(?(?h
.byte $10,$68,$96,$68,$95,$97,$24,$98             ; 0FAC46 ?h?h??$?
.byte $24,$99,$24,$9A,$24,$9A,$64,$99             ; 0FAC4E $?$?$?d?
.byte $64,$98,$64,$97,$9B,$28,$9C,$28             ; 0FAC56 d?d??(?(
.byte $20,$28,$21,$28,$21,$68,$20,$68             ; 0FAC5E  (!(!h h
.byte $9C,$68,$9B,$9D,$24,$9E,$24,$9F             ; 0FAC66 ?h??$?$?
.byte $24,$A0,$24,$A0,$64,$9F,$64,$9E             ; 0FAC6E $?$?d?d?
.byte $64,$9D,$A1,$28,$A2,$28,$34,$28             ; 0FAC76 d??(?(4(
.byte $35,$28,$35,$68,$34,$68,$A2,$68             ; 0FAC7E 5(5h4h?h
.byte $A1,$A3,$24,$A4,$24,$A5,$28,$A6             ; 0FAC86 ??$?$?(?
.byte $2C,$A6,$6C,$A5,$68,$A4,$64,$A3             ; 0FAC8E ,?l?h?d?
.byte $A7,$28,$48,$28,$49,$28,$49,$68             ; 0FAC96 ?(H(I(Ih
.byte $48,$68,$A7,$A8,$24,$A9,$20,$AA             ; 0FAC9E Hh??$? ?
.byte $20,$AA,$60,$A9,$60,$A8,$AB,$28             ; 0FACA6  ?`?`??(
.byte $5A,$28,$5B,$28,$5B,$68,$5A,$68             ; 0FACAE Z([([hZh
.byte $59,$AC,$28,$AD,$20,$AE,$20,$AE             ; 0FACB6 Y?(? ? ?
.byte $60,$AD,$60,$AC,$64,$28,$65,$28             ; 0FACBE `?`?d(e(
.byte $66,$28,$66,$68,$65,$68,$64,$AF             ; 0FACC6 f(fhehd?
.byte $28,$B0,$20,$B1,$20,$B1,$60,$B0             ; 0FACCE (? ? ?`?
.byte $60,$AF,$6D,$28,$B2,$28,$6F,$28             ; 0FACD6 `?m(?(o(
.byte $6F,$68,$B2,$68,$6D,$76,$28,$59             ; 0FACDE oh?hmv(Y
.byte $06,$0C,$13,$02,$98,$0A,$9B,$60             ; 0FACE6 ???????`
.byte $24,$36,$82,$10,$1D,$80,$49,$5D             ; 0FACEE $6????I]
.byte $55,$59,$5D,$CD,$59,$5E,$5D,$59             ; 0FACF6 UY]?Y^]Y
.byte $5E,$DD,$59,$5D,$AE,$AC,$AE,$73             ; 0FACFE ^?Y]???s
.byte $01,$85,$CA,$A0,$B0,$B9,$CC,$16             ; 0FAD06 ????????
.byte $17,$AA,$82,$C2,$F9,$50,$58,$5F             ; 0FAD0E ?????PX_
.byte $6A,$0B,$0B,$F5,$41,$61,$71,$54             ; 0FAD16 j???AaqT
.byte $47,$0A,$95,$23,$92,$1E,$15,$44             ; 0FAD1E G??#???D
.byte $70,$30,$01,$31,$B8,$C5,$00,$4E             ; 0FAD26 p0?1???N
.byte $C8,$0C,$6C,$4E,$D2,$00,$C8,$84             ; 0FAD2E ??lN????
.byte $CA,$E3,$24,$00,$3C,$19,$32,$B1             ; 0FAD36 ??$?<?2?
.byte $3C,$48,$03,$32,$13,$3B,$8C,$D0             ; 0FAD3E <H?2?;??
.byte $00,$F4,$64,$CE,$C4,$F5,$20,$0D             ; 0FAD46 ??d??? ?
.byte $08,$4D,$2E,$34,$40,$03,$E1,$93             ; 0FAD4E ?M.4@???
.byte $4B,$13,$44,$01,$35,$28,$35,$B8             ; 0FAD56 K?D?5(5?
.byte $D5,$00,$4F,$C8,$0D,$6C,$4F,$D2             ; 0FAD5E ??O??lO?
.byte $04,$B3,$16,$E6,$B8,$CC,$80,$27             ; 0FAD66 ???????'
.byte $02,$03,$35,$89,$C1,$20,$4C,$E5             ; 0FAD6E ??5?? L?
.byte $06,$7B,$8C,$E8,$02,$71,$20,$33             ; 0FAD76 ?{???q 3
.byte $D8,$9C,$52,$04,$D0,$50,$72,$10             ; 0FAD7E ??R??Pr?
.byte $D0,$80,$27,$22,$00,$E4,$70,$A6             ; 0FAD86 ??'"??p?
.byte $92,$93,$49,$C2,$9C,$CA,$03,$49             ; 0FAD8E ??I????I
.byte $C2,$01,$AE,$60,$C3,$50,$9A,$F4             ; 0FAD96 ???`?P??
.byte $13,$A8,$89,$86,$A4,$3A,$AC,$06             ; 0FAD9E ?????:??
.byte $C9,$13,$15,$42,$6C,$D0,$0E,$C1             ; 0FADA6 ???Bl???
.byte $26,$2A,$14,$EC,$B0,$1B,$64,$4C             ; 0FADAE &*????dL
.byte $75,$09,$B7,$40,$3B,$84,$98,$E8             ; 0FADB6 u??@;???
.byte $53,$BA,$C0,$6E,$91,$32,$54,$26             ; 0FADBE S??n?2T&
.byte $ED,$00,$F0,$12,$64,$A1,$4D,$DA             ; 0FADC6 ????d?M?
.byte $09,$BE,$60,$CB,$50,$9B,$F4,$13             ; 0FADCE ??`?P???
.byte $C8,$81,$96,$85,$3C,$AC,$27,$09             ; 0FADD6 ????<?'?
.byte $83,$35,$42,$70,$D0,$4F,$42,$06             ; 0FADDE ?5Bp?OB?
.byte $6A,$14,$F4,$B0,$9C,$66,$0C,$F5             ; 0FADE6 j????f??
.byte $09,$C7,$41,$3D,$88,$19,$E8,$53             ; 0FADEE ??A=???S
.byte $DA,$C2,$72,$99,$0E,$58,$29,$F0             ; 0FADF6 ??r??X)?
.byte $40,$0E,$58,$00,$73,$A1,$0E,$79             ; 0FADFE @?X?s??y
.byte $29,$F4,$60,$0D,$27,$2A,$07,$F8             ; 0FAE06 )?`?'*??
.byte $14,$80,$00,$08,$5A,$00,$00,$20             ; 0FAE0E ????Z?? 
.byte $00,$20,$93,$24,$94,$24,$94,$64             ; 0FAE16 ? ?$?$?d
.byte $93,$64,$97,$24,$98,$24,$99,$24             ; 0FAE1E ?d?$?$?$
.byte $9A,$9A,$64,$99,$64,$98,$64,$97             ; 0FAE26 ??d?d?d?
.byte $9D,$24,$9E,$24,$9F,$24,$A0,$A0             ; 0FAE2E ?$?$?$??
.byte $64,$9F,$64,$9E,$64,$9D,$A3,$24             ; 0FAE36 d?d?d??$
.byte $A4,$24,$A5,$28,$A6,$2C,$A6,$6C             ; 0FAE3E ?$?(?,?l
.byte $A5,$68,$A4,$64,$A3,$00,$20,$A8             ; 0FAE46 ?h?d?? ?
.byte $24,$A9,$20,$AA,$AA,$60,$A9,$60             ; 0FAE4E $? ??`?`
.byte $A8,$AC,$28,$AD,$20,$AE,$AE,$60             ; 0FAE56 ??(? ??`
.byte $AD,$60,$AC,$68,$AF,$28,$B0,$20             ; 0FAE5E ?`?h?(? 
.byte $B1,$B1,$60,$B0,$60,$AF,$06,$0C             ; 0FAE66 ??`?`???
.byte $13,$02,$98,$0A,$9B,$60,$20,$E3             ; 0FAE6E ?????` ?
.byte $10,$6E,$10,$39,$C2,$12,$ED,$6C             ; 0FAE76 ?n?9???l
.byte $BB,$B8,$3C,$30,$9C,$70,$84,$BD             ; 0FAE7E ??<0?p??
.byte $5B,$2F,$76,$23,$E7,$08,$40,$70             ; 0FAE86 [/v#??@p
.byte $22,$5D,$F6,$23,$C3,$84,$25,$E8             ; 0FAE8E "]?#??%?
.byte $6C,$39,$DD,$1E,$90,$07,$4E,$14             ; 0FAE96 l9????N?
.byte $87,$C1,$B2,$77,$A1,$4F,$1C,$29             ; 0FAE9E ???w?O?)
.byte $0F,$C3,$61,$F7,$22,$BF,$38,$53             ; 0FAEA6 ??a?"?8S
.byte $00,$01,$03,$7E,$84,$53,$0B,$80             ; 0FAEAE ???~?S??
.byte $4C,$6C,$10,$EC,$65,$3B,$49,$0C             ; 0FAEB6 Ll??e;I?
.byte $A4,$53,$2C,$10,$F0,$20,$4F,$12             ; 0FAEBE ?S,?? O?
.byte $43,$39,$14,$CF,$04,$3D,$08,$13             ; 0FAEC6 C9???=??
.byte $D4,$90,$D2,$45,$34,$C1,$0F,$82             ; 0FAECE ???E4???
.byte $04,$D3,$05,$35,$99,$0D,$70,$53             ; 0FAED6 ???5??pS
.byte $F1,$00,$3F,$49,$4C,$D3,$21,$9B             ; 0FAEDE ???IL?!?
.byte $05,$38,$08,$01,$C1,$25,$33,$CC             ; 0FAEE6 ?8???%3?
.byte $86,$7C,$14,$E2,$20,$06,$7C,$15             ; 0FAEEE ?|?? ?|?
.byte $47,$48,$EA,$A3,$CF,$25,$51,$EB             ; 0FAEF6 GH???%Q?
.byte $8A,$A8,$F7,$C1,$54,$7C,$DE,$AA             ; 0FAEFE ????T|??
.byte $3E,$EE,$55,$1F,$EC,$80,$C0,$00             ; 0FAF06 >?U?????
.byte $00,$C4,$6E,$A4,$55,$A2,$28,$84             ; 0FAF0E ??n?U?(?
.byte $10,$A4,$0E,$95,$0C,$FF,$03,$E7             ; 0FAF16 ????????
.byte $1C,$6B,$29,$B5,$56,$FF,$7F,$FF             ; 0FAF1E ?k)?V???
.byte $7F,$FF,$7F,$FF,$7F,$FF,$7F,$00             ; 0FAF26 ????????
.byte $00,$29,$25,$AD,$35,$10,$42,$18             ; 0FAF2E ?)%?5?B?
.byte $63,$E0,$00,$60,$01,$20,$06,$A0             ; 0FAF36 c??`? ??
.byte $06,$20,$07,$AE,$0C,$13,$15,$97             ; 0FAF3E ? ??????
.byte $25,$F8,$2D,$BE,$46,$3E,$57,$00             ; 0FAF46 %?-?F>W?
.byte $00,$4A,$29,$AD,$35,$31,$46,$D6             ; 0FAF4E ?J)?51F?
.byte $5A,$39,$67,$E0,$00,$60,$01,$20             ; 0FAF56 Z9g??`? 
.byte $06,$A0,$06,$E0,$06,$A0,$0B,$04             ; 0FAF5E ????????
.byte $00,$8B,$08,$72,$21,$F8,$2D,$00             ; 0FAF66 ???r!?-?
.byte $00,$08,$21,$4A,$29,$EF,$3D,$73             ; 0FAF6E ??!J)?=s
.byte $4E,$9C,$73,$C0,$00,$AE,$0C,$13             ; 0FAF76 N?s?????
.byte $15,$53,$1D,$97,$25,$F8,$2D,$1B             ; 0FAF7E ?S??%?-?
.byte $32,$BE,$46,$3E,$57,$04,$00,$00             ; 0FAF86 2?F>W???
.byte $00,$C5,$6E,$A4,$55,$A2,$54,$84             ; 0FAF8E ??n?U?T?
.byte $10,$A4,$0E,$99,$0C,$FF,$03,$E7             ; 0FAF96 ????????
.byte $1C,$6B,$29,$B5,$56,$D6,$5A,$31             ; 0FAF9E ?k)?V?Z1
.byte $46,$EF,$3D,$33,$00,$2E,$04,$00             ; 0FAFA6 F?=3?.??
.byte $00,$05,$00,$07,$00,$34,$19,$0B             ; 0FAFAE ?????4??
.byte $00,$2F,$00,$B7,$29,$58,$04,$7F             ; 0FAFB6 ?/??)X??
.byte $04,$3C,$25,$7D,$3E,$DC,$4E,$5C             ; 0FAFBE ?<%}>?N\
.byte $6B,$08,$21,$31,$46,$D1,$10,$00             ; 0FAFC6 k?!1F???
.byte $00,$C6,$18,$8C,$31,$31,$46,$B5             ; 0FAFCE ????11F?
.byte $56,$5C,$6B,$C7,$40,$07,$00,$0B             ; 0FAFD6 V\k?@???
.byte $00,$2F,$00,$75,$25,$33,$00,$58             ; 0FAFDE ?/?u%3?X
.byte $04,$5A,$04,$7F,$04,$09,$00,$00             ; 0FAFE6 ?Z??????
.byte $00,$07,$00,$2E,$04,$F2,$14,$13             ; 0FAFEE ???.????
.byte $19,$75,$25,$97,$25,$F8,$2D,$1B             ; 0FAFF6 ?u%?%?-?
.byte $32,$8C,$31,$EF,$3D,$31,$46,$D6             ; 0FAFFE 2?1?=1F?
.byte $5A,$5C,$6B,$33,$00,$5A,$04,$60             ; 0FB006 Z\k3?Z?`
.byte $22,$E9,$10,$00,$00,$00,$01,$01             ; 0FB00E "???????
.byte $02,$03,$08,$0F,$00,$1F,$02,$01             ; 0FB016 ????????
.byte $08,$07,$01,$01,$0C,$0B,$70,$4F             ; 0FB01E ??????pO
.byte $B0,$2F,$70,$DF,$30,$DF,$19,$E6             ; 0FB026 ?/p?0???
.byte $00,$08,$07,$20,$1F,$E0,$1F,$50             ; 0FB02E ??? ???P
.byte $8F,$10,$CF,$00,$EF,$00,$00,$81             ; 0FB036 ????????
.byte $7E,$01,$FE,$01,$FE,$09,$F6,$FF             ; 0FB03E ~???????
.byte $FE,$FE,$00,$FE,$F6,$03,$04,$03             ; 0FB046 ????????
.byte $0F,$00,$03,$1D,$04,$03,$00,$07             ; 0FB04E ????????
.byte $04,$0B,$01,$1C,$42,$7D,$80,$FF             ; 0FB056 ????B}??
.byte $01,$FE,$02,$FF,$4E,$B7,$4F,$B6             ; 0FB05E ????N?O?
.byte $1C,$FF,$F8,$1E,$00,$3D,$00,$7F             ; 0FB066 ?????=??
.byte $00,$FF,$03,$FD,$07,$B9,$06,$B8             ; 0FB06E ????????
.byte $1F,$E0,$1E,$F9,$FE,$E1,$D8,$E7             ; 0FB076 ????????
.byte $D7,$2F,$07,$FF,$07,$FF,$07,$FF             ; 0FB07E ?/??????
.byte $04,$7F,$00,$3F,$FC,$FD,$F0,$F7             ; 0FB086 ????????
.byte $C0,$EF,$80,$00,$FF,$80,$FF,$C0             ; 0FB08E ????????
.byte $FF,$08,$F7,$C6,$FF,$09,$5F,$00             ; 0FB096 ??????_?
.byte $00,$19,$19,$19,$19,$CC,$FF,$8E             ; 0FB09E ????????
.byte $FF,$0F,$F7,$7F,$BF,$FF,$A6,$FF             ; 0FB0A6 ????????
.byte $FF,$E6,$FF,$E6,$03,$FF,$02,$00             ; 0FB0AE ????????
.byte $01,$02,$01,$02,$01,$01,$3E,$40             ; 0FB0B6 ??????>@
.byte $7F,$00,$7F,$10,$6F,$29,$D7,$DE             ; 0FB0BE ????o)??
.byte $21,$FE,$07,$FE,$0E,$00,$3E,$40             ; 0FB0C6 !?????>@
.byte $3F,$00,$7F,$80,$6F,$FF,$07,$F9             ; 0FB0CE ????o???
.byte $0F,$F0,$F8,$14,$60,$BB,$60,$D6             ; 0FB0D6 ????`?`?
.byte $E1,$AF,$CF,$BF,$7F,$8F,$7F,$DF             ; 0FB0DE ????????
.byte $D8,$C8,$34,$53,$3B,$84,$56,$89             ; 0FB0E6 ??4S;?V?
.byte $CF,$10,$FF,$00,$CF,$80,$AE,$81             ; 0FB0EE ????????
.byte $A7,$0F,$01,$EF,$CF,$30,$CF,$30             ; 0FB0F6 ?????0?0
.byte $E8,$10,$47,$F8,$F1,$FE,$10,$1F             ; 0FB0FE ??G?????
.byte $FF,$DF,$DF,$DF,$DF,$DF,$D8,$00             ; 0FB106 ????????
.byte $B9,$FF,$C1,$7F,$35,$CB,$3D,$C3             ; 0FB10E ????5?=?
.byte $3D,$C3,$7F,$00,$F9,$18,$DB,$38             ; 0FB116 =??????8
.byte $07,$FF,$7F,$7F,$7F,$7F,$7F,$FF             ; 0FB11E ????????
.byte $00,$F9,$06,$F9,$06,$07,$00,$07             ; 0FB126 ????????
.byte $02,$0F,$01,$09,$06,$1E,$01,$1F             ; 0FB12E ????????
.byte $10,$04,$00,$07,$0A,$05,$0E,$10             ; 0FB136 ????????
.byte $0F,$10,$0F,$FE,$0E,$FF,$0C,$7E             ; 0FB13E ???????~
.byte $80,$EF,$FF,$1E,$3F,$FF,$FD,$59             ; 0FB146 ???????Y
.byte $0F,$F0,$0F,$70,$1F,$F8,$1A,$F8             ; 0FB14E ???p????
.byte $F2,$00,$02,$00,$20,$C1,$66,$83             ; 0FB156 ???? ?f?
.byte $B3,$47,$B7,$4F,$FB,$3C,$6B,$F4             ; 0FB15E ?G?O?<k?
.byte $57,$E8,$E7,$98,$D7,$2F,$8F,$7F             ; 0FB166 W????/??
.byte $AF,$A0,$BF,$A0,$BF,$80,$78,$00             ; 0FB16E ??????x?
.byte $70,$00,$E7,$0F,$DF,$1F,$9F,$3F             ; 0FB176 p???????
.byte $F1,$FE,$DB,$C3,$73,$F3,$5B,$BB             ; 0FB17E ????s?[?
.byte $D7,$0F,$6E,$87,$33,$C8,$99,$E4             ; 0FB186 ??n?3???
.byte $FF,$00,$C3,$3C,$F3,$0C,$7B,$04             ; 0FB18E ???<??{?
.byte $3F,$00,$1F,$80,$87,$C0,$C3,$E0             ; 0FB196 ????????
.byte $02,$26,$01,$41,$39,$47,$2F,$41             ; 0FB19E ?&?A9G/A
.byte $01,$C1,$5F,$9F,$FF,$3F,$A1,$3F             ; 0FB1A6 ??_?????
.byte $E1,$1E,$70,$8E,$7E,$80,$7E,$80             ; 0FB1AE ??p?~?~?
.byte $FE,$00,$E0,$00,$C0,$00,$C0,$1F             ; 0FB1B6 ????????
.byte $00,$3F,$00,$3F,$20,$40,$00,$1D             ; 0FB1BE ???? @??
.byte $00,$1F,$20,$1F,$20,$FC,$58,$9C             ; 0FB1C6 ?? ? ?X?
.byte $78,$9C,$78,$FC,$78,$7C,$D8,$7C             ; 0FB1CE x?x?x|?|
.byte $B8,$3F,$BB,$3D,$BD,$67,$83,$67             ; 0FB1D6 ???=?g?g
.byte $E3,$67,$E3,$83,$47,$83,$44,$83             ; 0FB1DE ?g??G?D?
.byte $43,$80,$B9,$19,$BA,$18,$BD,$4D             ; 0FB1E6 C??????M
.byte $BB,$47,$8E,$70,$B7,$78,$DB,$5C             ; 0FB1EE ?G?p?x?\
.byte $CD,$CE,$FF,$3F,$FD,$1D,$BF,$0F             ; 0FB1F6 ????????
.byte $BF,$07,$DF,$DF,$20,$CF,$30,$EC             ; 0FB1FE ???? ?0?
.byte $F2,$DF,$E0,$EA,$D4,$58,$A4,$01             ; 0FB206 ?????X??
.byte $38,$87,$10,$C5,$02,$ED,$06,$E1             ; 0FB20E 8???????
.byte $F0,$F0,$F0,$E1,$E0,$C3,$C0,$C7             ; 0FB216 ????????
.byte $C0,$FF,$1C,$FC,$01,$22,$01,$22             ; 0FB21E ?????"?"
.byte $67,$1F,$F0,$3F,$E1,$3E,$D8,$03             ; 0FB226 g????>??
.byte $00,$E0,$C0,$3F,$C0,$3F,$7F,$00             ; 0FB22E ????????
.byte $7F,$42,$7F,$4C,$7F,$70,$7B,$0C             ; 0FB236 ?B?L?p{?
.byte $0F,$32,$00,$3B,$40,$3F,$40,$3F             ; 0FB23E ?2?;@?@?
.byte $42,$3D,$4E,$30,$70,$42,$3D,$7F             ; 0FB246 B=N0pB=?
.byte $FF,$7F,$F7,$7F,$F6,$3F,$BE,$DF             ; 0FB24E ????????
.byte $78,$5B,$DA,$1B,$FA,$9F,$7C,$61             ; 0FB256 x[????|a
.byte $E0,$61,$E0,$49,$80,$41,$80,$0B             ; 0FB25E ?a?I?A??
.byte $04,$6D,$80,$6D,$3B,$FC,$B7,$78             ; 0FB266 ?m?m;??x
.byte $8E,$70,$9C,$60,$F8,$E0,$00,$E0             ; 0FB26E ?p?`????
.byte $01,$80,$FE,$80,$7B,$75,$F1,$F6             ; 0FB276 ????{u??
.byte $EF,$F2,$CA,$F8,$BF,$CF,$44,$A3             ; 0FB27E ??????D?
.byte $08,$D7,$51,$C6,$8E,$00,$0C,$00             ; 0FB286 ??Q?????
.byte $04,$00,$07,$13,$0C,$37,$08,$27             ; 0FB28E ?????7?'
.byte $18,$44,$03,$C0,$41,$9F,$5F,$AF             ; 0FB296 ?D??A?_?
.byte $CF,$93,$23,$F3,$1F,$E4,$0B,$3F             ; 0FB29E ??#?????
.byte $00,$20,$00,$10,$00,$CC,$F0,$00             ; 0FB2A6 ? ??????
.byte $F0,$00,$7F,$46,$7F,$7E,$7F,$39             ; 0FB2AE ???F?~?9
.byte $7B,$7F,$3F,$3F,$3F,$3F,$3F,$46             ; 0FB2B6 {??????F
.byte $39,$7E,$01,$79,$02,$3B,$76,$C8             ; 0FB2BE 9~?y?;v?
.byte $BF,$22,$DF,$1F,$DF,$1E,$DF,$DA             ; 0FB2C6 ?"??????
.byte $EF,$8A,$FF,$9E,$F7,$96,$41,$61             ; 0FB2CE ??????Aa
.byte $80,$61,$80,$E1,$00,$F5,$60,$F1             ; 0FB2D6 ?a????`?
.byte $60,$99,$60,$E0,$01,$E0,$03,$80             ; 0FB2DE `?`?????
.byte $02,$80,$02,$11,$84,$31,$88,$33             ; 0FB2E6 ?????1?3
.byte $80,$37,$FC,$80,$FD,$80,$FD,$80             ; 0FB2EE ?7??????
.byte $FB,$80,$F7,$F3,$CC,$A0,$9F,$F1             ; 0FB2F6 ????????
.byte $8A,$F6,$09,$E2,$1C,$CF,$33,$F7             ; 0FB2FE ??????3?
.byte $00,$CB,$08,$2F,$10,$7F,$00,$7A             ; 0FB306 ???/???z
.byte $05,$F9,$06,$FF,$00,$F4,$08,$FF             ; 0FB30E ????????
.byte $00,$F0,$07,$F3,$04,$59,$A6,$F2             ; 0FB316 ?????Y??
.byte $0F,$3D,$C1,$03,$03,$8F,$F0,$9F             ; 0FB31E ?=??????
.byte $5F,$00,$40,$F8,$00,$E4,$18,$0C             ; 0FB326 _?@?????
.byte $F0,$FE,$00,$FC,$E0,$00,$40,$BF             ; 0FB32E ??????@?
.byte $3F,$1F,$1F,$1D,$1F,$1D,$1F,$1F             ; 0FB336 ????????
.byte $1F,$0F,$0F,$0E,$0F,$05,$07,$3D             ; 0FB33E ???????=
.byte $00,$1D,$02,$1F,$00,$0E,$00,$0E             ; 0FB346 ????????
.byte $00,$F7,$F7,$FB,$B3,$FD,$C1,$F5             ; 0FB34E ????????
.byte $81,$F3,$3F,$72,$5E,$FF,$6A,$FF             ; 0FB356 ???r^?j?
.byte $C6,$F8,$00,$BC,$40,$E2,$00,$CE             ; 0FB35E ????@???
.byte $00,$BE,$0C,$FF,$FF,$00,$A4,$03             ; 0FB366 ????????
.byte $A7,$40,$40,$00,$47,$A0,$67,$80             ; 0FB36E ?@@?G?g?
.byte $67,$90,$37,$48,$9B,$64,$40,$7F             ; 0FB376 g?7H?d@?
.byte $60,$7F,$60,$7F,$70,$BF,$38,$9F             ; 0FB37E `?`?p?8?
.byte $9C,$37,$38,$69,$56,$89,$A6,$06             ; 0FB386 ?78iV???
.byte $28,$0C,$23,$01,$26,$03,$3C,$06             ; 0FB38E (?#?&?<?
.byte $38,$C8,$07,$B0,$0F,$60,$E3,$1C             ; 0FB396 8????`??
.byte $E7,$18,$00,$0F,$C1,$06,$C0,$0C             ; 0FB39E ????????
.byte $01,$C1,$4F,$8F,$DF,$1F,$3F,$3F             ; 0FB3A6 ??O?????
.byte $FB,$FB,$0F,$F0,$07,$F8,$0F,$F0             ; 0FB3AE ????????
.byte $02,$03,$01,$03,$02,$03,$02,$05             ; 0FB3B6 ????????
.byte $FF,$83,$FF,$81,$FF,$01,$FF,$40             ; 0FB3BE ???????@
.byte $16,$01,$BF,$FB,$00,$BF,$AC,$FF             ; 0FB3C6 ????????
.byte $E6,$D7,$93,$FB,$C9,$ED,$6C,$E6             ; 0FB3CE ??????l?
.byte $46,$E6,$BC,$E6,$9E,$DC,$83,$DE             ; 0FB3D6 F???????
.byte $81,$AF,$40,$E7,$00,$F3,$00,$D9             ; 0FB3DE ??@?????
.byte $00,$3F,$18,$3F,$18,$F4,$08,$7B             ; 0FB3E6 ???????{
.byte $80,$83,$40,$83,$60,$E3,$10,$F0             ; 0FB3EE ??@?`???
.byte $0F,$3F,$80,$0F,$60,$E0,$FF,$F0             ; 0FB3F6 ????`???
.byte $FF,$FF,$7F,$3F,$9F,$0F,$E7,$07             ; 0FB3FE ????????
.byte $A7,$4F,$0F,$DF,$FF,$1F,$DE,$3F             ; 0FB406 ?O??????
.byte $1C,$FF,$C0,$3F,$07,$FF,$0F,$3F             ; 0FB40E ????????
.byte $FF,$3F,$FF,$FF,$FF,$85,$05,$01             ; 0FB416 ????????
.byte $01,$2B,$2A,$3F,$1E,$1C,$1F,$0F             ; 0FB41E ?+*?????
.byte $0D,$07,$00,$03,$03,$7E,$00,$7E             ; 0FB426 ?????~?~
.byte $00,$14,$D2,$CF,$0F,$EB,$2B,$BE             ; 0FB42E ??????+?
.byte $BE,$FF,$FF,$73,$0C,$7F,$00,$57             ; 0FB436 ???s???W
.byte $00,$C1,$00,$80,$00,$80,$BF,$3F             ; 0FB43E ????????
.byte $CF,$0F,$FF,$37,$F4,$90,$F8,$B7             ; 0FB446 ???7????
.byte $F8,$F7,$FF,$F3,$FF,$F7,$C7,$08             ; 0FB44E ????????
.byte $F0,$CF,$F8,$C0,$9F,$60,$77,$07             ; 0FB456 ?????`w?
.byte $17,$07,$C0,$7F,$C1,$80,$FF,$46             ; 0FB45E ???????F
.byte $FF,$FE,$FF,$6F,$C0,$00,$FE,$00             ; 0FB466 ???o????
.byte $7E,$86,$FE,$06,$FE,$4A,$7F,$01             ; 0FB46E ~????J??
.byte $00,$07,$FF,$F7,$E7,$77,$4A,$F7             ; 0FB476 ?????wJ?
.byte $30,$C7,$3B,$CD,$78,$8D,$FA,$05             ; 0FB47E 0?;?x???
.byte $7D,$08,$00,$08,$10,$00,$FE,$87             ; 0FB486 }???????
.byte $01,$FE,$03,$FC,$B5,$48,$4B,$B4             ; 0FB48E ?????HK?
.byte $0E,$B5,$4A,$CB,$34,$03,$01,$04             ; 0FB496 ??J?4???
.byte $02,$70,$58,$EC,$3C,$7D,$CA,$BF             ; 0FB49E ?pX?<}??
.byte $D1,$D9,$26,$30,$00,$A8,$10,$48             ; 0FB4A6 ??&0???H
.byte $90,$94,$42,$80,$6F,$0A,$0F,$14             ; 0FB4AE ??B?o???
.byte $3D,$16,$FD,$22,$F9,$26,$A1,$5E             ; 0FB4B6 =??"?&?^
.byte $06,$0C,$02,$2C,$02,$F0,$06,$20             ; 0FB4BE ???,??? 
.byte $1E,$05,$02,$0F,$00,$0B,$05,$05             ; 0FB4C6 ????????
.byte $02,$19,$04,$02,$09,$00,$D6,$05             ; 0FB4CE ????????
.byte $D6,$03,$AF,$86,$7C,$9F,$06,$01             ; 0FB4D6 ????|???
.byte $4D,$83,$9B,$05,$56,$08,$61,$05             ; 0FB4DE M???V?a?
.byte $12,$00,$0B,$02,$07,$02,$0D,$06             ; 0FB4E6 ????????
.byte $0B,$0E,$16,$0C,$02,$04,$00,$01             ; 0FB4EE ????????
.byte $03,$07,$01,$0F,$1C,$07,$00,$1C             ; 0FB4F6 ????????
.byte $03,$06,$6A,$33,$84,$FE,$17,$00             ; 0FB4FE ??j3????
.byte $6B,$10,$9F,$78,$1B,$09,$17,$35             ; 0FB506 k??x???5
.byte $0E,$08,$1A,$00,$01,$02,$0F,$10             ; 0FB50E ????????
.byte $19,$00,$31,$00,$21,$01,$06,$5F             ; 0FB516 ??1?!??_
.byte $1C,$3F,$2A,$7F,$43,$0E,$01,$3C             ; 0FB51E ??*?C??<
.byte $03,$6F,$10,$4F,$30,$8B,$7B,$7D             ; 0FB526 ?o?O0?{}
.byte $6B,$26,$54,$5A,$52,$21,$41,$73             ; 0FB52E k&TZR!As
.byte $00,$71,$F6,$48,$BF,$A2,$DF,$9F             ; 0FB536 ?q?H????
.byte $DF,$1E,$5F,$DA,$EF,$0A,$FF,$1E             ; 0FB53E ??_?????
.byte $F7,$16,$41,$80,$C1,$00,$E1,$00             ; 0FB546 ??A?????
.byte $E1,$00,$61,$00,$75,$60,$71,$60             ; 0FB54E ??a?u`q`
.byte $19,$60,$10,$00,$18,$10,$1C,$0F             ; 0FB556 ?`??????
.byte $08,$0B,$00,$00,$0D,$04,$7B,$B3             ; 0FB55E ??????{?
.byte $7D,$C1,$F5,$01,$F3,$3F,$F2,$5E             ; 0FB566 }??????^
.byte $FF,$EA,$FF,$46,$78,$00,$3C,$40             ; 0FB56E ???Fx?<@
.byte $62,$01,$05,$FF,$A3,$C7,$A1,$8B             ; 0FB576 b???????
.byte $88,$91,$04,$0F,$DF,$01,$9F,$01             ; 0FB57E ????????
.byte $07,$00,$0B,$03,$03,$63,$F7,$40             ; 0FB586 ?????c?@
.byte $C1,$80,$80,$00,$73,$FF,$37,$00             ; 0FB58E ????s?7?
.byte $FF,$17,$27,$17,$0A,$17,$10,$06             ; 0FB596 ??'?????
.byte $1A,$0C,$38,$1C,$78,$04,$1C,$10             ; 0FB59E ??8?x???
.byte $05,$7A,$21,$02,$03,$03,$E2,$01             ; 0FB5A6 ?z!?????
.byte $E4,$02,$86,$05,$84,$03,$13,$80             ; 0FB5AE ????????
.byte $33,$84,$37,$81,$F8,$80,$FB,$83             ; 0FB5B6 3?7?????
.byte $FB,$83,$CB,$86,$05,$F3,$38,$FF             ; 0FB5BE ??????8?
.byte $1E,$AD,$FA,$F7,$BB,$7F,$99,$FF             ; 0FB5C6 ????????
.byte $00,$BF,$01,$01,$9B,$9B,$09,$F2             ; 0FB5CE ????????
.byte $11,$FA,$18,$E0,$C0,$C0,$B7,$FF             ; 0FB5D6 ????????
.byte $77,$FE,$33,$FC,$7F,$80,$3F,$C0             ; 0FB5DE w?3?????
.byte $FB,$FF,$BB,$BB,$90,$04,$20,$95             ; 0FB5E6 ?????? ?
.byte $43,$B9,$51,$A3,$35,$83,$FE,$1F             ; 0FB5EE C?Q?5???
.byte $3F,$28,$70,$7B,$CA,$9E,$DF,$5B             ; 0FB5F6 ?(p{???[
.byte $BE,$BF,$F5,$0F,$E3,$1F,$CF,$1F             ; 0FB5FE ????????
.byte $80,$00,$F9,$F2,$20,$1F,$3F,$F0             ; 0FB606 ???? ???
.byte $AE,$FF,$7E,$E7,$FC,$CF,$EF,$1D             ; 0FB60E ??~?????
.byte $8C,$3F,$8F,$3F,$8F,$36,$F3,$80             ; 0FB616 ?????6??
.byte $F0,$80,$F0,$CC,$AE,$97,$F9,$8F             ; 0FB61E ????????
.byte $F6,$09,$B2,$EC,$7F,$83,$07,$F0             ; 0FB626 ????????
.byte $2B,$58,$06,$7F,$0F,$E0,$F4,$C8             ; 0FB62E +X??????
.byte $FF,$F0,$F0,$77,$FF,$4F,$B8,$D8             ; 0FB636 ???w?O??
.byte $F0,$70,$F8,$FF,$E6,$05,$E4,$02             ; 0FB63E ?p??????
.byte $8E,$0D,$8C,$0F,$1F,$8C,$82,$37             ; 0FB646 ???????7
.byte $82,$FB,$F6,$F1,$F9,$81,$F9,$81             ; 0FB64E ????????
.byte $FF,$FF,$DE,$ED,$00,$33,$33,$BF             ; 0FB656 ?????33?
.byte $98,$9D,$FB,$FB,$81,$03,$92,$06             ; 0FB65E ????????
.byte $22,$97,$43,$BB,$87,$FC,$80,$F9             ; 0FB666 "?C?????
.byte $80,$F9,$80,$F4,$FB,$2A,$72,$7F             ; 0FB66E ?????*r?
.byte $CE,$9F,$DC,$5B,$BC,$BF,$C0,$F8             ; 0FB676 ???[????
.byte $00,$FD,$00,$B1,$01,$E0,$00,$CC             ; 0FB67E ????????
.byte $0C,$F6,$AF,$FF,$FE,$27,$7C,$C9             ; 0FB686 ?????'|?
.byte $C9,$FE,$FE,$2F,$2F,$37,$FC,$0F             ; 0FB68E ???//7??
.byte $FD,$F1,$F3,$F3,$F0,$8E,$31,$87             ; 0FB696 ??????1?
.byte $3B,$8E,$3F,$9A,$82,$F1,$85,$E1             ; 0FB69E ;???????
.byte $81,$CB,$87,$C0,$7F,$99,$FC,$89             ; 0FB6A6 ????????
.byte $7C,$93,$07,$22,$97,$47,$BF,$59             ; 0FB6AE |??"?G?Y
.byte $AB,$F6,$FF,$CF,$30,$00,$60,$7E             ; 0FB6B6 ????0?`~
.byte $7E,$0F,$9F,$9F,$81,$81,$B2,$8C             ; 0FB6BE ~???????
.byte $A2,$9C,$E1,$46,$E1,$42,$C0,$52             ; 0FB6C6 ???F?B?R
.byte $C1,$5E,$E0,$27,$98,$23,$9C,$33             ; 0FB6CE ?^?'?#?3
.byte $8C,$3F,$80,$F3,$CD,$EF,$D6,$1C             ; 0FB6D6 ????????
.byte $CA,$BD,$64,$C6,$A8,$C6,$29,$AE             ; 0FB6DE ??d???)?
.byte $10,$95,$29,$2F,$11,$3F,$07,$FE             ; 0FB6E6 ??)/????
.byte $CF,$DC,$CF,$FB,$E4,$FF,$63,$FF             ; 0FB6EE ??????c?
.byte $3F,$FE,$3E,$E3,$84,$E5,$9A,$8A             ; 0FB6F6 ??>?????
.byte $33,$23,$D8,$9F,$00,$FF,$FA,$C8             ; 0FB6FE 3#??????
.byte $B0,$9C,$E0,$3C,$C0,$FC,$1C,$F0             ; 0FB706 ???<????
.byte $30,$1D,$1D,$A6,$01,$A0,$45,$41             ; 0FB70E 0?????EA
.byte $03,$44,$A1,$66,$C3,$FC,$41,$7E             ; 0FB716 ?D?f??A~
.byte $D8,$7F,$B4,$FC,$80,$B1,$17,$D7             ; 0FB71E ????????
.byte $4E,$2F,$B1,$7E,$EE,$10,$F8,$6B             ; 0FB726 N/?~???k
.byte $FC,$4F,$80,$37,$08,$EF,$80,$F7             ; 0FB72E ?O?7????
.byte $00,$F7,$F8,$70,$00,$FF,$A5,$03             ; 0FB736 ???p????
.byte $A6,$49,$54,$09,$4D,$A0,$63,$80             ; 0FB73E ?IT?M?c?
.byte $61,$90,$34,$DF,$A0,$7F,$C0,$8F             ; 0FB746 a?4?????
.byte $78,$D9,$3E,$DE,$3F,$65,$1E,$C0             ; 0FB74E x?>??e??
.byte $00,$F0,$10,$FD,$1D,$FF,$CE,$80             ; 0FB756 ????????
.byte $04,$A7,$00,$A5,$45,$4F,$03,$FA             ; 0FB75E ????EO??
.byte $C0,$FC,$67,$18,$89,$E6,$09,$76             ; 0FB766 ??g????v
.byte $F8,$77,$60,$7F,$F0,$7F,$B0,$77             ; 0FB76E ?w`????w
.byte $E1,$26,$77,$F8,$27,$A6,$03,$A2             ; 0FB776 ?&w?'???
.byte $47,$41,$03,$45,$C1,$FC,$40,$B7             ; 0FB77E GA?E??@?
.byte $FF,$C0,$F1,$17,$D7,$CE,$EF,$F1             ; 0FB786 ????????
.byte $68,$68,$0F,$00,$37,$88,$FF,$3C             ; 0FB78E hh??7??<
.byte $3C,$F7,$F7,$C3,$AF,$0F,$A7,$4F             ; 0FB796 <??????O
.byte $55,$81,$61,$90,$35,$49,$9B,$64             ; 0FB79E U?a?5I?d
.byte $F0,$80,$F8,$C0,$FE,$70,$BE,$80             ; 0FB7A6 ?????p??
.byte $BF,$EF,$78,$DD,$FE,$FF,$BF,$67             ; 0FB7AE ??x????g
.byte $5E,$9D,$1D,$33,$00,$58,$00,$BD             ; 0FB7B6 ^??3?X??
.byte $DE,$F0,$F0,$C0,$EF,$EF,$0F,$A6             ; 0FB7BE ????????
.byte $03,$A7,$47,$4E,$03,$46,$A3,$91             ; 0FB7C6 ??GN?F??
.byte $FD,$FC,$40,$7C,$60,$7C,$60,$7E             ; 0FB7CE ??@|`|`~
.byte $2F,$50,$DF,$02,$9F,$22,$3C,$42             ; 0FB7D6 /P???"<B
.byte $7A,$05,$6F,$B6,$5F,$36,$38,$16             ; 0FB7DE z?o?_68?
.byte $FE,$7F,$FE,$FF,$F4,$FF,$FC,$FF             ; 0FB7E6 ????????
.byte $FD,$FF,$1E,$FF,$18,$B8,$6F,$F9             ; 0FB7EE ??????o?
.byte $06,$F8,$14,$15,$E9,$4F,$8B,$D9             ; 0FB7F6 ?????O??
.byte $1F,$3F,$3D,$FB,$FB,$7F,$F8,$7F             ; 0FB7FE ??=?????
.byte $F8,$5F,$FC,$FE,$0C,$F4,$04,$E6             ; 0FB806 ?_??????
.byte $06,$C2,$02,$04,$00,$B6,$13,$B2             ; 0FB80E ????????
.byte $57,$E9,$81,$E9,$40,$BF,$BC,$BC             ; 0FB816 W???@???
.byte $F7,$C0,$F7,$F8,$78,$C8,$88,$88             ; 0FB81E ????x???
.byte $F0,$F0,$64,$60,$F7,$F7,$43,$9F             ; 0FB826 ??d`??C?
.byte $00,$B7,$00,$77,$9F,$57,$0F,$4D             ; 0FB82E ???w?W?M
.byte $AD,$6F,$8D,$6D,$9C,$35,$4D,$F8             ; 0FB836 ?o?m?5M?
.byte $40,$72,$60,$72,$60,$73,$70,$BA             ; 0FB83E @r`r`sp?
.byte $FF,$C0,$EF,$F8,$40,$00,$30,$10             ; 0FB846 ????@?0?
.byte $1D,$B0,$0F,$B9,$46,$4F,$61,$38             ; 0FB84E ????FOa8
.byte $20,$3E,$61,$DC,$E1,$68,$03,$10             ; 0FB856  >a??h??
.byte $4D,$60,$0B,$48,$23,$45,$32,$FF             ; 0FB85E M`?H#E2?
.byte $38,$DF,$58,$FC,$F3,$47,$E3,$1C             ; 0FB866 8?X??G??
.byte $E3,$1C,$F3,$0C,$19,$88,$FF,$20             ; 0FB86E ??????? 
.byte $FD,$05,$32,$CC,$64,$CD,$D5,$3E             ; 0FB876 ??2?d??>
.byte $69,$30,$FB,$7B,$FF,$19,$3F,$F9             ; 0FB87E i0?{????
.byte $3D,$FF,$7C,$BF,$7C,$E7,$EE,$65             ; 0FB886 =?|?|??e
.byte $DF,$00,$84,$41,$67,$B2,$0C,$5F             ; 0FB88E ???Ag??_
.byte $FA,$0E,$7F,$82,$F5,$00,$FD,$77             ; 0FB896 ???????w
.byte $37,$CF,$0E,$42,$FD,$FD,$F1,$0E             ; 0FB89E 7??B????
.byte $7F,$27,$CF,$2F,$FF,$3F,$6E,$F1             ; 0FB8A6 ?'?/??n?
.byte $57,$E8,$EF,$90,$D6,$29,$97,$6D             ; 0FB8AE W????)?m
.byte $7F,$09,$98,$3D,$F3,$F3,$DB,$FB             ; 0FB8B6 ???=????
.byte $77,$8F,$EE,$07,$F3,$08,$F9,$84             ; 0FB8BE w???????
.byte $FB,$00,$43,$C0,$D8,$27,$9C,$67             ; 0FB8C6 ??C??'?g
.byte $07,$93,$37,$79,$C3,$D6,$29,$80             ; 0FB8CE ??7y??)?
.byte $C6,$0F,$8F,$B9,$44,$83,$D0,$29             ; 0FB8D6 ????D??)
.byte $99,$66,$00,$9F,$20,$40,$90,$6F             ; 0FB8DE ?f?? @?o
.byte $39,$C4,$D7,$28,$C7,$73,$88,$80             ; 0FB8E6 9??(?s??
.byte $23,$A0,$E1,$FE,$CC,$E1,$F0,$03             ; 0FB8EE #???????
.byte $E6,$60,$FE,$C1,$FB,$88,$62,$60             ; 0FB8F6 ?`????b`
.byte $23,$20,$EF,$FF,$CD,$FF,$33,$FF             ; 0FB8FE # ????3?
.byte $86,$73,$FF,$82,$FF,$D3,$EF,$F6             ; 0FB906 ?s??????
.byte $07,$72,$BC,$DE,$38,$04,$24,$1E             ; 0FB90E ?r??8?$?
.byte $80,$3F,$00,$6F,$4F,$5E,$1F,$F0             ; 0FB916 ???oO^??
.byte $FF,$CE,$20,$FF,$9E,$20,$FF,$42             ; 0FB91E ?? ?? ?B
.byte $FF,$E0,$FE,$C0,$E1,$F8,$00,$E3             ; 0FB926 ????????
.byte $60,$FC,$C2,$FE,$80,$69,$68,$23             ; 0FB92E `????ih#
.byte $20,$EE,$FF,$CD,$F3,$3F,$F8,$87             ; 0FB936  ???????
.byte $FB,$3E,$FF,$7F,$FE,$83,$FD,$D3             ; 0FB93E ?>??????
.byte $EF,$7E,$0E,$00,$3B,$04,$5E,$1F             ; 0FB946 ?~??;?^?
.byte $00,$FF,$A4,$DB,$C3,$BC,$FB,$04             ; 0FB94E ????????
.byte $F3,$0C,$EE,$1F,$3F,$88,$38,$B8             ; 0FB956 ??????8?
.byte $1F,$B8,$4F,$BE,$43,$DF,$3F,$FF             ; 0FB95E ??O?C???
.byte $1F,$3C,$C2,$DF,$E0,$0A,$F4,$98             ; 0FB966 ?<??????
.byte $64,$E0,$E0,$E0,$C1,$C0,$83,$80             ; 0FB96E d???????
.byte $80,$23,$90,$37,$BF,$0F,$B0,$47             ; 0FB976 ?#?7???G
.byte $E7,$0F,$FC,$89,$3F,$AF,$0F,$AB             ; 0FB97E ????????
.byte $57,$BC,$F3,$1F,$A5,$17,$89,$3F             ; 0FB986 W???????
.byte $4B,$BA,$45,$BC,$0F,$B9,$05,$18             ; 0FB98E K?E?????
.byte $E4,$03,$84,$3F,$BF,$1F,$B6,$4F             ; 0FB996 ???????O
.byte $B9,$46,$FE,$1F,$BD,$BC,$C2,$9F             ; 0FB99E ?F??????
.byte $A0,$8A,$74,$D8,$24,$40,$C3,$00             ; 0FB9A6 ??t?$@??
.byte $BF,$7C,$42,$FF,$80,$6A,$54,$C1             ; 0FB9AE ?|B??jT?
.byte $C0,$00,$80,$81,$88,$3F,$BE,$1C             ; 0FB9B6 ????????
.byte $02,$FF,$C0,$F5,$57,$F8,$F7,$F0             ; 0FB9BE ????W???
.byte $FF,$E0,$C8,$F9,$7B,$88,$09,$06             ; 0FB9C6 ????{???
.byte $00,$0E,$18,$3C,$64,$00,$88,$F0             ; 0FB9CE ???<d???
.byte $11,$F4,$8C,$3A,$86,$0F,$F0,$60             ; 0FB9D6 ???:???`
.byte $DF,$F8,$87,$09,$C1,$F0,$E1,$CF             ; 0FB9DE ????????
.byte $F0,$0E,$70,$8C,$38,$46,$07,$04             ; 0FB9E6 ??p?8F??
.byte $83,$02,$4E,$FE,$CC,$F3,$1B,$3F             ; 0FB9EE ??N?????
.byte $03,$0E,$01,$65,$83,$0B,$F2,$12             ; 0FB9F6 ???e????
.byte $F1,$0E,$3A,$44,$0F,$F0,$83,$7F             ; 0FB9FE ??:D????
.byte $C3,$BF,$E1,$DF,$7B,$67,$0A,$07             ; 0FBA06 ????{g??
.byte $07,$05,$83,$83,$C2,$E6,$61,$21             ; 0FBA0E ??????a!
.byte $59,$07,$EF,$09,$B9,$85,$DB,$03             ; 0FBA16 Y???????
.byte $37,$03,$99,$63,$E1,$DE,$F0,$EE             ; 0FBA1E 7??c????
.byte $BE,$B0,$9E,$98,$C6,$C4,$A4,$A4             ; 0FBA26 ????????
.byte $F8,$F8,$FC,$DC,$00,$DF,$67,$58             ; 0FBA2E ??????gX
.byte $70,$00,$39,$47,$18,$E0,$02,$4C             ; 0FBA36 p?9G???L
.byte $08,$A4,$00,$32,$E0,$E0,$A5,$3D             ; 0FBA3E ???2???=
.byte $FF,$70,$BE,$3E,$FF,$FF,$CF,$77             ; 0FBA46 ?p?>???w
.byte $8F,$F8,$03,$FC,$1D,$E3,$3F,$F0             ; 0FBA4E ????????
.byte $0B,$35,$1B,$E7,$06,$3E,$28,$38             ; 0FBA56 ?5???>(8
.byte $38,$3F,$10,$12,$C0,$C1,$C0,$C7             ; 0FBA5E 8???????
.byte $C0,$C7,$07,$EB,$04,$07,$D8,$6F             ; 0FBA66 ???????o
.byte $40,$6F,$00,$33,$44,$01,$F6,$22             ; 0FBA6E @o?3D??"
.byte $64,$18,$BC,$00,$32,$E7,$E7,$BF             ; 0FBA76 d???2???
.byte $3F,$FF,$7F,$BF,$3C,$7F,$9F,$FC             ; 0FBA7E ????<???
.byte $FF,$70,$CB,$35,$FB,$27,$02,$3E             ; 0FBA86 ?p?5?'?>
.byte $00,$3C,$20,$80,$80,$C0,$D5,$D4             ; 0FBA8E ?< ?????
.byte $EF,$EC,$DF,$1F,$EB,$04,$08,$D0             ; 0FBA96 ????????
.byte $6F,$40,$42,$03,$F4,$B0,$30,$E7             ; 0FBA9E o@B???0?
.byte $67,$B1,$31,$FC,$FC,$1E,$23,$FF             ; 0FBAA6 g?1???#?
.byte $00,$0B,$35,$3B,$47,$E2,$1E,$C1             ; 0FBAAE ??5;G???
.byte $C1,$80,$80,$15,$14,$58,$07,$F8             ; 0FBAB6 ?????X??
.byte $78,$8F,$27,$92,$C5,$8C,$C3,$9F             ; 0FBABE x?'?????
.byte $E0,$9E,$E0,$DA,$A0,$F3,$82,$9E             ; 0FBAC6 ????????
.byte $9F,$37,$FF,$DF,$3F,$EF,$FD,$19             ; 0FBACE ?7??????
.byte $E0,$00,$7B,$75,$F5,$06,$0C,$04             ; 0FBAD6 ??{u????
.byte $64,$09,$F6,$48,$8F,$40,$A7,$C0             ; 0FBADE d??H?@??
.byte $93,$21,$F1,$1C,$E5,$0A,$6F,$3F             ; 0FBAE6 ?!????o?
.byte $3E,$1F,$CE,$02,$E3,$03,$F1,$01             ; 0FBAEE >???????
.byte $F0,$0C,$00,$50,$00,$93,$0F,$20             ; 0FBAF6 ???P??? 
.byte $0F,$4D,$21,$2E,$17,$CF,$80,$40             ; 0FBAFE ?M!.???@
.byte $8F,$41,$0F,$40,$47,$74,$40,$7F             ; 0FBB06 ?A?@Gt@?
.byte $7E,$40,$06,$07,$03,$2F,$03,$03             ; 0FBB0E ~@???/??
.byte $00,$87,$FF,$FF,$07,$07,$1F,$0F             ; 0FBB16 ????????
.byte $17,$7F,$07,$7F,$07,$07,$79,$00             ; 0FBB1E ??????y?
.byte $00,$78,$79,$30,$79,$00,$7B,$01             ; 0FBB26 ?xy0y?{?
.byte $3A,$11,$3A,$01,$2A,$01,$1A,$01             ; 0FBB2E :?:?*???
.byte $1C,$07,$79,$07,$31,$03,$04,$06             ; 0FBB36 ??y?1???
.byte $00,$06,$12,$16,$02,$06,$02,$02             ; 0FBB3E ????????
.byte $00,$71,$FF,$7B,$0F,$07,$FF,$77             ; 0FBB46 ?q?{???w
.byte $0F,$D0,$29,$FB,$14,$FF,$88,$FE             ; 0FBB4E ??)?????
.byte $00,$F7,$1B,$F7,$8B,$FF,$DB,$1F             ; 0FBB56 ????????
.byte $F0,$0F,$7E,$01,$F7,$09,$F4,$2F             ; 0FBB5E ??~????/
.byte $74,$BF,$24,$F5,$0B,$CD,$3B,$FD             ; 0FBB66 t?$???;?
.byte $04,$AD,$03,$FD,$84,$F7,$8C,$FB             ; 0FBB6E ????????
.byte $F4,$FF,$FF,$79,$86,$79,$86,$66             ; 0FBB76 ???y?y?f
.byte $9B,$F5,$FA,$73,$FF,$7B,$F7,$04             ; 0FBB7E ???s?{??
.byte $17,$01,$16,$07,$31,$07,$3B,$00             ; 0FBB86 ????1?;?
.byte $0E,$13,$19,$73,$E8,$F8,$E1,$EC             ; 0FBB8E ???s????
.byte $03,$E7,$17,$0F,$0C,$03,$00,$00             ; 0FBB96 ????????
.byte $39,$DE,$0F,$17,$87,$18,$80,$1F             ; 0FBB9E 9???????
.byte $FE,$01,$07,$FE,$FD,$03,$FF,$F8             ; 0FBBA6 ????????
.byte $1F,$E0,$E7,$F8,$E0,$00,$FF,$FF             ; 0FBBAE ????????
.byte $1F,$1F,$E3,$FB,$0F,$07,$89,$73             ; 0FBBB6 ???????s
.byte $01,$7B,$81,$FB,$01,$03,$85,$E0             ; 0FBBBE ?{??????
.byte $0C,$F0,$72,$FC,$FE,$FC,$7E,$FC             ; 0FBBC6 ??r???~?
.byte $7E,$FC,$FA,$7C,$00,$1C,$0E,$00             ; 0FBBCE ~??|????
.byte $06,$02,$F3,$FF,$C3,$67,$1D,$2F             ; 0FBBD6 ?????g?/
.byte $16,$01,$1F,$09,$82,$0C,$CA,$0E             ; 0FBBDE ????????
.byte $CD,$00,$03,$30,$03,$78,$81,$B4             ; 0FBBE6 ???0?x??
.byte $48,$D2,$2C,$64,$1F,$25,$13,$32             ; 0FBBEE H?,d?%?2
.byte $01,$BF,$FF,$17,$DF,$20,$EF,$14             ; 0FBBF6 ????? ??
.byte $40,$BF,$68,$1F,$FF,$19,$6F,$90             ; 0FBBFE @?h???o?
.byte $8F,$F5,$8F,$B7,$4A,$BF,$0F,$70             ; 0FBC06 ????J??p
.byte $FF,$73,$FC,$B7,$FD,$FF,$FF,$0F             ; 0FBC0E ?s??????
.byte $2C,$0E,$29,$0F,$29,$6E,$0F,$6F             ; 0FBC16 ,?)?)n?o
.byte $0F,$67,$03,$71,$13,$17,$11,$08             ; 0FBC1E ?g?q????
.byte $04,$FF,$4F,$7F,$AF,$BF,$D7,$9F             ; 0FBC26 ??O?????
.byte $F3,$7F,$F9,$7F,$C4,$CF,$3A,$C7             ; 0FBC2E ??????:?
.byte $0F,$80,$0F,$C0,$0F,$E0,$07,$E0             ; 0FBC36 ????????
.byte $03,$F0,$01,$C8,$30,$8C,$70,$B4             ; 0FBC3E ????0?p?
.byte $78,$FF,$E7,$FF,$F9,$FE,$FF,$FD             ; 0FBC46 x???????
.byte $FF,$FB,$1F,$F8,$FC,$F8,$9F,$1F             ; 0FBC4E ????????
.byte $FC,$1B,$EB,$F3,$D5,$E7,$8F,$ED             ; 0FBC56 ????????
.byte $B7,$B3,$00,$04,$03,$17,$0F,$2C             ; 0FBC5E ???????,
.byte $1E,$5C,$3D,$7C,$7B,$03,$C1,$01             ; 0FBC66 ?\=|{???
.byte $E0,$80,$30,$10,$40,$20,$08,$10             ; 0FBC6E ??0?@ ??
.byte $0C,$08,$30,$0C,$1A,$04,$4F,$00             ; 0FBC76 ??0???O?
.byte $2F,$03,$01,$00,$E6,$50,$F0,$B9             ; 0FBC7E /????P??
.byte $F6,$4F,$FF,$10,$BF,$1F,$00,$4F             ; 0FBC86 ?O?????O
.byte $C3,$CF,$3F,$76,$0F,$3F,$40,$00             ; 0FBC8E ???v??@?
.byte $6F,$9F,$CF,$30,$33,$0C,$4F,$7F             ; 0FBC96 o??03?O?
.byte $CF,$3F,$DF,$7F,$BF,$7C,$BC,$FB             ; 0FBC9E ?????|??
.byte $38,$F3,$FF,$9F,$7F,$BF,$3F,$00             ; 0FBCA6 8???????
.byte $01,$7B,$20,$79,$00,$59,$00,$79             ; 0FBCAE ?{ y?Y?y
.byte $49,$00,$69,$08,$79,$02,$06,$01             ; 0FBCB6 I?i?y???
.byte $26,$25,$1F,$11,$2F,$18,$17,$01             ; 0FBCBE &%??/???
.byte $07,$09,$13,$C6,$3C,$81,$BE,$8C             ; 0FBCC6 ????<???
.byte $9E,$8C,$0F,$C0,$C4,$20,$DF,$B1             ; 0FBCCE ????? ??
.byte $F3,$8C,$BB,$7C,$FE,$7F,$BF,$7F             ; 0FBCD6 ???|????
.byte $9F,$7F,$71,$0E,$E7,$3F,$E0,$9A             ; 0FBCDE ??q?????
.byte $E5,$E6,$01,$05,$0B,$07,$00,$E1             ; 0FBCE6 ????????
.byte $D0,$00,$F8,$18,$00,$DF,$00,$E7             ; 0FBCEE ????????
.byte $18,$1F,$F8,$F7,$F8,$F8,$FF,$CF             ; 0FBCF6 ????????
.byte $3E,$E7,$1F,$EF,$6B,$3F,$8C,$FF             ; 0FBCFE >???k???
.byte $5C,$7F,$B8,$97,$46,$F8,$73,$C0             ; 0FBD06 \???F?s?
.byte $6C,$40,$9C,$40,$B8,$00,$B0,$C0             ; 0FBD0E l@?@????
.byte $00,$E0,$40,$38,$18,$40,$C0,$80             ; 0FBD16 ??@8?@??
.byte $F4,$40,$FE,$92,$B7,$09,$3B,$87             ; 0FBD1E ?@????;?
.byte $FF,$01,$ED,$E0,$B8,$30,$DF,$1E             ; 0FBD26 ?????0??
.byte $C4,$1A,$C4,$89,$F0,$E7,$E0,$93             ; 0FBD2E ????????
.byte $E8,$0C,$AE,$44,$DE,$BF,$9F,$01             ; 0FBD36 ???D????
.byte $03,$F1,$82,$F0,$22,$7F,$0A,$27             ; 0FBD3E ????"??'
.byte $40,$9F,$02,$FF,$7E,$50,$20,$EA             ; 0FBD46 @???~P ?
.byte $E0,$E9,$C9,$E0,$D0,$04,$30,$12             ; 0FBD4E ??????0?
.byte $E4,$14,$C2,$03,$CB,$99,$01,$F9             ; 0FBD56 ????????
.byte $01,$CE,$17,$DF,$2F,$FF,$FF,$87             ; 0FBD5E ????/???
.byte $34,$C3,$E6,$F1,$FE,$F1,$E8,$F0             ; 0FBD66 4???????
.byte $30,$C0,$40,$00,$C0,$80,$C0,$80             ; 0FBD6E 0?@?????
.byte $60,$E0,$B8,$70,$F0,$9C,$FC,$D0             ; 0FBD76 `??p????
.byte $80,$20,$80,$30,$FF,$F8,$F8,$C7             ; 0FBD7E ? ?0????
.byte $DF,$F0,$EC,$9D,$CE,$82,$DF,$81             ; 0FBD86 ????????
.byte $DF,$80,$C0,$A1,$07,$30,$0F,$42             ; 0FBD8E ?????0?B
.byte $33,$7D,$3D,$7E,$3E,$7E,$3F,$5F             ; 0FBD96 3}=~>~?_
.byte $3E,$9C,$7B,$F4,$E8,$E3,$18,$03             ; 0FBD9E >?{?????
.byte $F8,$7F,$90,$FE,$BB,$5E,$F8,$03             ; 0FBDA6 ?????^??
.byte $E3,$1B,$05,$FD,$04,$FC,$00,$F9             ; 0FBDAE ????????
.byte $21,$1A,$90,$0E,$80,$54,$40,$F9             ; 0FBDB6 !????T@?
.byte $F8,$F9,$C4,$9D,$DF,$92,$BD,$E1             ; 0FBDBE ????????
.byte $DB,$08,$3E,$00,$31,$0A,$40,$3D             ; 0FBDC6 ??>?1?@=
.byte $2C,$3E,$1E,$3D,$7E,$3B,$5F,$3E             ; 0FBDCE ,>?=~;_>
.byte $9E,$7B,$BE,$26,$FF,$7E,$9D,$FF             ; 0FBDD6 ?{?&?~??
.byte $5F,$F8,$03,$61,$17,$BF,$1F,$80             ; 0FBDDE _??a????
.byte $1D,$80,$55,$BF,$FF,$07,$FC,$30             ; 0FBDE6 ??U????0
.byte $78,$94,$FC,$94,$74,$94,$F4,$76             ; 0FBDEE x???t??v
.byte $F6,$F2,$F6,$E2,$C6,$8C,$C0,$04             ; 0FBDF6 ????????
.byte $E8,$04,$88,$04,$08,$02,$08,$02             ; 0FBDFE ????????
.byte $10,$24,$FF,$F7,$BF,$FF,$DF,$FF             ; 0FBE06 ?$??????
.byte $DF,$FF,$BB,$1F,$33,$FF,$F2,$FE             ; 0FBE0E ????3???
.byte $F5,$FD,$EB,$F9,$CF,$FE,$DF,$FE             ; 0FBE16 ????????
.byte $63,$F3,$7C,$F3,$E0,$01,$F0,$03             ; 0FBE1E c?|?????
.byte $F0,$07,$E0,$07,$C0,$0F,$C0,$13             ; 0FBE26 ????????
.byte $6C,$11,$2E,$2D,$0E,$67,$86,$DC             ; 0FBE2E l?.-?g??
.byte $06,$9A,$00,$9A,$08,$9E,$18,$9E             ; 0FBE36 ????????
.byte $16,$92,$36,$B2,$36,$BC,$40,$64             ; 0FBE3E ??6?6?@d
.byte $80,$62,$A4,$C0,$A0,$48,$E0,$98             ; 0FBE46 ?b???H??
.byte $E0,$1A,$C8,$B2,$C0,$B4,$FF,$E7             ; 0FBE4E ????????
.byte $FC,$07,$5B,$A4,$67,$80,$A8,$D0             ; 0FBE56 ??[?g???
.byte $E0,$00,$87,$0B,$00,$1F,$18,$40             ; 0FBE5E ???????@
.byte $FB,$F8,$1B,$E7,$17,$1F,$FF,$F3             ; 0FBE66 ????????
.byte $7C,$E7,$F8,$D8,$E3,$BC,$21,$7D             ; 0FBE6E |?????!}
.byte $31,$79,$29,$F8,$03,$2B,$0C,$FB             ; 0FBE76 1y)??+??
.byte $8D,$CF,$31,$0D,$EE,$4F,$6E,$EF             ; 0FBE7E ??1??On?
.byte $FE,$E7,$E6,$F5,$E6,$F1,$F6,$8E             ; 0FBE86 ????????
.byte $70,$FE,$00,$8E,$DC,$1E,$9C,$10             ; 0FBE8E p???????
.byte $90,$30,$B0,$30,$B8,$40,$6C,$80             ; 0FBE96 ?0?0?@l?
.byte $7A,$18,$C8,$B0,$C0,$B0,$06,$5F             ; 0FBE9E z??????_
.byte $AF,$75,$91,$AB,$D1,$E3,$02,$87             ; 0FBEA6 ?u??????
.byte $09,$F0,$06,$E0,$1F,$EA,$19,$E6             ; 0FBEAE ????????
.byte $15,$1D,$FE,$F8,$D3,$FC,$3D,$FD             ; 0FBEB6 ??????=?
.byte $F1,$F9,$C9,$DE,$03,$3E,$0F,$FE             ; 0FBEBE ?????>??
.byte $27,$C6,$F5,$66,$AF,$D0,$B3,$DC             ; 0FBEC6 '??f????
.byte $BF,$20,$B5,$C0,$BF,$21,$EF,$31             ; 0FBECE ? ???!?1
.byte $DF,$9E,$61,$9E,$61,$66,$D9,$AF             ; 0FBED6 ??a?af??
.byte $5F,$CE,$FF,$DE,$EF,$C0,$07,$DE             ; 0FBEDE _???????
.byte $FF,$CF,$FF,$C3,$E7,$B9,$F8,$20             ; 0FBEE6 ??????? 
.byte $C0,$0C,$C0,$1E,$80,$78,$F8,$1C             ; 0FBEEE ?????x??
.byte $88,$08,$DC,$80,$5C,$90,$54,$B0             ; 0FBEF6 ????\?T?
.byte $50,$B0,$78,$B0,$20,$80,$F8,$E0             ; 0FBEFE P?x? ???
.byte $88,$C0,$28,$60,$00,$68,$50,$48             ; 0FBF06 ??(`?hPH
.byte $50,$40,$70,$40,$20,$0B,$94,$DF             ; 0FBF0E P@p@ ???
.byte $28,$FF,$EF,$D8,$EF,$D1,$67,$7E             ; 0FBF16 (?????g~
.byte $80,$EE,$90,$2F,$F4,$2E,$FD,$8E             ; 0FBF1E ???/?.??
.byte $FF,$28,$EF,$99,$F8,$00,$40,$08             ; 0FBF26 ?(????@?
.byte $28,$14,$7F,$6F,$FF,$D9,$FF,$E3             ; 0FBF2E (??o????
.byte $7A,$80,$80,$E5,$10,$C9,$00,$E3             ; 0FBF36 z???????
.byte $07,$FF,$9C,$FF,$8A,$F0,$18,$33             ; 0FBF3E ???????3
.byte $DC,$EF,$FF,$D8,$FF,$E1,$12,$C8             ; 0FBF46 ????????
.byte $04,$E1,$EE,$D1,$E8,$08,$F4,$06             ; 0FBF4E ????????
.byte $D0,$FF,$EE,$00,$E0,$EE,$E8,$FF             ; 0FBF56 ????????
.byte $F1,$AF,$F1,$ED,$72,$6D,$7E,$02             ; 0FBF5E ????rm~?
.byte $0E,$80,$F0,$F0,$0E,$FF,$CE,$3F             ; 0FBF66 ????????
.byte $CD,$BF,$BF,$5F,$BF,$FD,$FF,$E8             ; 0FBF6E ???_????
.byte $FB,$04,$F7,$28,$14,$02,$F0,$01             ; 0FBF76 ???(????
.byte $F9,$02,$FA,$05,$02,$FD,$16,$F8             ; 0FBF7E ????????
.byte $FF,$98,$F6,$09,$F9,$EF,$FE,$F9             ; 0FBF86 ????????
.byte $FE,$F7,$69,$87,$7B,$9E,$42,$1C             ; 0FBF8E ??i?{?B?
.byte $6C,$79,$C8,$B1,$F0,$F0,$33,$E0             ; 0FBF96 ly????3?
.byte $67,$2E,$10,$CC,$30,$2C,$F1,$B1             ; 0FBF9E g.??0,??
.byte $C2,$72,$84,$C6,$08,$CC,$00,$88             ; 0FBFA6 ?r??????
.byte $10,$50,$60,$40,$C0,$20,$40,$A0             ; 0FBFAE ?P`@? @?
.byte $80,$00,$80,$40,$2A,$17,$02,$F3             ; 0FBFB6 ???@*???
.byte $00,$FB,$03,$FB,$06,$FE,$88,$F4             ; 0FBFBE ????????
.byte $0B,$F9,$EE,$FE,$FC,$FE,$FD,$C7             ; 0FBFC6 ????????
.byte $FB,$BE,$42,$5C,$2C,$13,$E0,$47             ; 0FBFCE ??B\,??G
.byte $2E,$10,$0C,$F0,$AC,$11,$D1,$82             ; 0FBFD6 .???????
.byte $42,$84,$C6,$18,$FF,$FF,$FB,$FD             ; 0FBFDE B???????
.byte $B7,$F8,$F6,$69,$46,$FC,$C3,$3B             ; 0FBFE6 ???iF??;
.byte $D6,$AF,$BF,$7F,$FF,$9B,$FF,$8C             ; 0FBFEE ????????
.byte $BF,$28,$EF,$07,$F7,$15,$7E,$80             ; 0FBFF6 ?(????~?
.byte $1B,$C0,$08,$EB,$40,$F0,$FA,$F8             ; 0FBFFE ????@???
.byte $EC,$FF,$61,$F7,$8B,$EE,$D2,$7C             ; 0FC006 ??a????|
.byte $9C,$B9,$68,$B1,$D0,$30,$D3,$E0             ; 0FC00E ??h??0??
.byte $27,$06,$20,$5C,$80,$2C,$D1,$41             ; 0FC016 '? \?,?A
.byte $82,$02,$44,$E6,$C8,$30,$E6,$B8             ; 0FC01E ??D??0??
.byte $F4,$68,$81,$F8,$91,$40,$30,$53             ; 0FC026 ?h???@0S
.byte $60,$A7,$81,$2D,$12,$4A,$34,$26             ; 0FC02E `??-?J4&
.byte $F8,$AC,$C0,$48,$FD,$FF,$E8,$FB             ; 0FC036 ???H????
.byte $06,$F7,$2A,$02,$FC,$16,$F8,$FC             ; 0FC03E ??*?????
.byte $8B,$F5,$0A,$C1,$F8,$B1,$40,$50             ; 0FC046 ??????@P
.byte $33,$60,$C7,$0A,$F4,$A6,$18,$CC             ; 0FC04E 3`??????
.byte $80,$F6,$98,$FF,$8C,$FE,$80,$7F             ; 0FC056 ????????
.byte $80,$18,$C3,$08,$D3,$FE,$60,$F4             ; 0FC05E ??????`?
.byte $88,$E9,$D0,$71,$90,$B0,$73,$A0             ; 0FC066 ???q??s?
.byte $C7,$08,$F4,$04,$D0,$06,$21,$5D             ; 0FC06E ??????!]
.byte $82,$2A,$D4,$46,$88,$0C,$40,$E8             ; 0FC076 ?*?F??@?
.byte $10,$F2,$FE,$B3,$5C,$8B,$4E,$0D             ; 0FC07E ????\?N?
.byte $DE,$05,$87,$18,$BB,$0C,$8E,$07             ; 0FC086 ????????
.byte $CF,$FD,$FD,$CC,$FF,$8C,$E6,$1E             ; 0FC08E ????????
.byte $83,$5F,$90,$ED,$A0,$17,$63,$0D             ; 0FC096 ?_????c?
.byte $0F,$9B,$6F,$F6,$FF,$08,$FC,$F9             ; 0FC09E ??o?????
.byte $01,$F3,$03,$86,$39,$7F,$F6,$F8             ; 0FC0A6 ????9???
.byte $6C,$F0,$F8,$02,$00,$F4,$F9,$98             ; 0FC0AE l???????
.byte $62,$80,$39,$C4,$8F,$8F,$1E,$1C             ; 0FC0B6 b?9?????
.byte $3E,$34,$30,$60,$10,$24,$60,$0E             ; 0FC0BE >40`?$`?
.byte $C0,$1C,$C8,$99,$F4,$77,$1C,$1F             ; 0FC0C6 ?????w??
.byte $95,$F0,$EC,$60,$EC,$CF,$67,$0A             ; 0FC0CE ???`??g?
.byte $0F,$9D,$6F,$F2,$F3,$FC,$6E,$F0             ; 0FC0D6 ??o???n?
.byte $FC,$67,$08,$0F,$9F,$F2,$FC,$6E             ; 0FC0DE ?g?????n
.byte $F1,$FC,$02,$07,$17,$10,$7F,$21             ; 0FC0E6 ???????!
.byte $FE,$20,$E8,$07,$80,$10,$10,$08             ; 0FC0EE ? ??????
.byte $00,$00,$39,$80,$C0,$4D,$0A,$40             ; 0FC0F6 ??9??M?@
.byte $6F,$01,$07,$71,$29,$C0,$85,$7C             ; 0FC0FE o??q)??|
.byte $84,$6D,$E7,$E5,$7D,$0F,$79,$A0             ; 0FC106 ?m??}?y?
.byte $1A,$8C,$BC,$03,$9C,$CA,$AF,$67             ; 0FC10E ???????g
.byte $00,$3E,$CC,$61,$E0,$74,$31,$70             ; 0FC116 ?>?a?t1p
.byte $20,$25,$4C,$D5,$02,$BB,$68,$85             ; 0FC11E  %L???h?
.byte $D9,$30,$1B,$EE,$14,$F2,$50,$1A             ; 0FC126 ?0????P?
.byte $64,$91,$D1,$30,$71,$88,$5E,$E3             ; 0FC12E d??0q?^?
.byte $28,$A6,$1F,$49,$C8,$9C,$86,$40             ; 0FC136 (??I???@
.byte $72,$13,$CB,$04,$29,$CE,$10,$01             ; 0FC13E r???)???
.byte $AF,$B2,$8E,$2F,$6B,$E1,$2B,$A2             ; 0FC146 ???/k?+?
.byte $B3,$8A,$F0,$76,$C1,$69,$91,$0A             ; 0FC14E ???v?i??
.byte $61,$DC,$AB,$E2,$30,$3C,$73,$06             ; 0FC156 a???0<s?
.byte $B1,$DE,$60,$79,$90,$48,$3D,$9F             ; 0FC15E ??`y?H=?
.byte $08,$75,$E1,$2F,$95,$CA,$FC,$44             ; 0FC166 ?u?/???D
.byte $0F,$0B,$F2,$C8,$40,$3E,$2B,$22             ; 0FC16E ????@>+"
.byte $F9,$EC,$0F,$9C,$B2,$83,$B5,$78             ; 0FC176 ???????x
.byte $17,$72,$F0,$69,$00,$80,$1D,$0A             ; 0FC17E ?r?i????
.byte $C0,$98,$DB,$60,$03,$5A,$B0,$6D             ; 0FC186 ???`?Z?m
.byte $B8,$84,$78,$2B,$68,$E5,$DA,$A4             ; 0FC18E ??x+h???
.byte $B9,$0A,$32,$2E,$59,$0B,$35,$A3             ; 0FC196 ??2.Y?5?
.byte $CC,$87,$83,$30,$1C,$9C,$2E,$5E             ; 0FC19E ???0??.^
.byte $F3,$92,$35,$76,$F3,$D8,$90,$4C             ; 0FC1A6 ??5v???L
.byte $6C,$8C,$2B,$D3,$09,$CB,$9C,$9D             ; 0FC1AE l?+?????
.byte $5A,$84,$72,$0A,$BC,$DE,$80,$D8             ; 0FC1B6 Z?r?????
.byte $07,$4E,$A4,$3A,$EA,$CA,$1B,$56             ; 0FC1BE ?N?:???V
.byte $3A,$BB,$76,$32,$07,$6E,$11,$D9             ; 0FC1C6 :?v2?n??
.byte $99,$71,$06,$60,$2D,$17,$B1,$24             ; 0FC1CE ?q?`-??$
.byte $E8,$62,$3B,$C2,$09,$2B,$90,$F9             ; 0FC1D6 ?b;??+??
.byte $F1,$8E,$0E,$36,$EB,$1D,$CE,$8C             ; 0FC1DE ???6????
.byte $35,$C0,$61,$F8,$30,$68,$3E,$59             ; 0FC1E6 5?a?0h>Y
.byte $BB,$C0,$A3,$06,$01,$01,$08,$3C             ; 0FC1EE ???????<
.byte $16,$27,$36,$13,$D7,$C4,$27,$B0             ; 0FC1F6 ?'6???'?
.byte $02,$13,$99,$D0,$B8,$6E,$60,$70             ; 0FC1FE ?????n`p
.byte $F8,$9A,$D0,$F5,$44,$9E,$B4,$48             ; 0FC206 ????D??H
.byte $C4,$D1,$1E,$BC,$85,$C5,$77,$C5             ; 0FC20E ??????w?
.byte $60,$31,$78,$D8,$C2,$50,$87,$9A             ; 0FC216 `1x??P??
.byte $04,$27,$31,$B9,$8F,$27,$C0,$83             ; 0FC21E ?'1??'??
.byte $34,$A0,$5F,$7F,$23,$36,$C9,$2F             ; 0FC226 4?_?#6?/
.byte $53,$CC,$E4,$8C,$99,$D6,$02,$03             ; 0FC22E S???????
.byte $58,$B1,$F8,$29,$72,$0A,$05,$9A             ; 0FC236 X??)r???
.byte $28,$75,$D4,$46,$25,$09,$35,$F4             ; 0FC23E (u?F%?5?
.byte $46,$60,$02,$96,$63,$23,$03,$B5             ; 0FC246 F`??c#??
.byte $D8,$CE,$FA,$A3,$B8,$80,$40,$07             ; 0FC24E ??????@?
.byte $07,$84,$9A,$6A,$46,$21,$EB,$3B             ; 0FC256 ???jF!?;
.byte $C9,$DA,$1F,$C0,$BA,$2A,$83,$8D             ; 0FC25E ?????*??
.byte $26,$98,$65,$A6,$B1,$C3,$B1,$69             ; 0FC266 &?e????i
.byte $A6,$F0,$DE,$04,$0F,$14,$FC,$54             ; 0FC26E ???????T
.byte $12,$ED,$60,$0E,$FC,$1A,$64,$BC             ; 0FC276 ??`???d?
.byte $53,$11,$B5,$82,$9A,$C0,$2C,$BA             ; 0FC27E S?????,?
.byte $C8,$22,$CE,$B6,$0A,$6B,$C2,$A3             ; 0FC286 ?"???k??
.byte $00,$EC,$60,$07,$0C,$47,$2B,$DB             ; 0FC28E ??`??G+?
.byte $20,$B0,$EE,$3F,$6B,$AF,$B2,$92             ; 0FC296  ???k???
.byte $3C,$A0,$A8,$EE,$14,$73,$48,$89             ; 0FC29E <????sH?
.byte $23,$9E,$6E,$67,$41,$9E,$94,$09             ; 0FC2A6 #?ngA???
.byte $8C,$CC,$1C,$E1,$72,$59,$6B,$81             ; 0FC2AE ????rYk?
.byte $2B,$D0,$7C,$E8,$2F,$01,$AD,$F1             ; 0FC2B6 +?|?/???
.byte $9E,$06,$78,$B0,$B9,$E9,$8E,$7B             ; 0FC2BE ??x????{
.byte $09,$0B,$89,$11,$A7,$CB,$27,$23             ; 0FC2C6 ??????'#
.byte $04,$86,$9F,$01,$75,$1B,$74,$33             ; 0FC2CE ????u?t3
.byte $60,$BF,$CE,$E1,$9E,$02,$4B,$D2             ; 0FC2D6 `?????K?
.byte $7E,$7A,$41,$0F,$56,$A4,$AE,$7E             ; 0FC2DE ~zA?V??~
.byte $13,$9F,$B4,$BA,$00,$09,$06,$82             ; 0FC2E6 ????????
.byte $02,$4A,$73,$D5,$07,$4B,$B7,$57             ; 0FC2EE ?Js??K?W
.byte $77,$3F,$30,$74,$00,$41,$D0,$40             ; 0FC2F6 w?0t?A?@
.byte $B0,$74,$31,$D0,$E2,$5D,$12,$85             ; 0FC2FE ?t1??]??
.byte $D1,$62,$E7,$3B,$1D,$1D,$01,$01             ; 0FC306 ?b?;????
.byte $D2,$65,$D2,$81,$2F,$3E,$77,$4B             ; 0FC30E ?e??/>wK
.byte $F0,$9D,$36,$10,$9A,$EA,$1D,$3F             ; 0FC316 ??6?????
.byte $0C,$3D,$45,$05,$DD,$6C,$9D,$4D             ; 0FC31E ?=E??l?M
.byte $02,$5D,$57,$A3,$75,$7E,$8C,$75             ; 0FC326 ?]W?u~?u
.byte $A0,$2C,$F5,$C0,$8B,$75,$FC,$0C             ; 0FC32E ?,???u??
.byte $BD,$88,$03,$2F,$64,$40,$C1,$D9             ; 0FC336 ???/d@??
.byte $8A,$37,$68,$28,$DD,$A8,$82,$C0             ; 0FC33E ?7h(????
.byte $76,$DC,$9D,$8D,$78,$6B,$76,$FA             ; 0FC346 v???xkv?
.byte $31,$DC,$32,$13,$DC,$BA,$8C,$F3             ; 0FC34E 1?2?????
.byte $84,$30,$0F,$31,$FE,$66,$12,$01             ; 0FC356 ?0?1?f??
.byte $E6,$C9,$29,$AA,$E1,$0B,$A3,$48             ; 0FC35E ??)????H
.byte $F3,$F9,$06,$8E,$EB,$2B,$E3,$EC             ; 0FC366 ?????+??
.byte $B8,$AB,$F9,$E8,$5A,$4F,$43,$C8             ; 0FC36E ????ZOC?
.byte $6D,$A7,$69,$69,$EC,$9E,$CA,$04             ; 0FC376 m?ii????
.byte $8E,$8D,$A0,$3A,$E8,$12,$1E,$5E             ; 0FC37E ???:???^
.byte $12,$7B,$24,$84,$68,$39,$1C,$AB             ; 0FC386 ?{$?h9??
.byte $81,$EC,$88,$C9,$A3,$30,$93,$ED             ; 0FC38E ?????0??
.byte $A8,$32,$69,$0C,$04,$9A,$4B,$01             ; 0FC396 ?2i???K?
.byte $06,$94,$82,$4E,$96,$62,$CB,$EA             ; 0FC39E ???N?b??
.byte $3A,$F6,$39,$3E,$AB,$09,$03,$EB             ; 0FC3A6 :?9>????
.byte $58,$C3,$9F,$7E,$9E,$81,$07,$B0             ; 0FC3AE X??~????
.byte $82,$4F,$BB,$62,$C3,$ED,$29,$21             ; 0FC3B6 ?O?b??)!
.byte $F0,$AF,$CE,$D1,$ED,$E9,$1E,$E1             ; 0FC3BE ????????
.byte $B0,$1E,$FA,$1E,$EA,$12,$FD,$6A             ; 0FC3C6 ???????j
.byte $04,$1E,$F6,$83,$3D,$36,$B0,$19             ; 0FC3CE ????=6??
.byte $3B,$5F,$36,$17,$DA,$32,$FC,$F6             ; 0FC3D6 ;_6??2??
.byte $C8,$38,$36,$C2,$07,$CC,$82,$4F             ; 0FC3DE ?86????O
.byte $CE,$68,$97,$D2,$08,$5F,$4F,$C0             ; 0FC3E6 ?h???_O?
.byte $3E,$3A,$C3,$E2,$8D,$F5,$FB,$09             ; 0FC3EE >:??????
.byte $F6,$70,$40,$FD,$BA,$B0,$6E,$EA             ; 0FC3F6 ?p@???n?
.byte $02,$1D,$DF,$23,$0E,$46,$5B,$23             ; 0FC3FE ???#?F[#
.byte $48,$8C,$29,$B9,$46,$05,$37,$79             ; 0FC406 H?)?F?7y
.byte $D9,$48,$D1,$6C,$A8,$2A,$33,$C2             ; 0FC40E ?H?l?*3?
.byte $0D,$16,$0E,$18,$82,$4F,$0D,$31             ; 0FC416 ?????O?1
.byte $63,$85,$12,$17,$0B,$15,$2E,$18             ; 0FC41E c?????.?
.byte $57,$0E,$60,$2E,$1A,$37,$0F,$50             ; 0FC426 W?`.?7?P
.byte $67,$29,$1A,$8C,$F0,$A5,$41,$C3             ; 0FC42E g)????A?
.byte $C0,$48,$61,$F0,$0B,$0F,$BE,$E5             ; 0FC436 ?Ha?????
.byte $A9,$C4,$00,$48,$62,$10,$0B,$3A             ; 0FC43E ???Hb??:
.byte $66,$60,$99,$E3,$00,$24,$1C,$64             ; 0FC446 f`???$?d
.byte $05,$9E,$34,$08,$5C,$6B,$D1,$B8             ; 0FC44E ??4?\k??
.byte $DF,$8B,$38,$7B,$C7,$8E,$B0,$4E             ; 0FC456 ??8{???N
.byte $1F,$F7,$8F,$20,$11,$C7,$C1,$0B             ; 0FC45E ??? ????
.byte $8F,$F8,$B0,$72,$10,$16,$79,$10             ; 0FC466 ???r??y?
.byte $28,$DC,$80,$10,$8E,$42,$08,$61             ; 0FC46E (????B?a
.byte $FE,$0E,$4C,$80,$47,$23,$04,$48             ; 0FC476 ??L?G#?H
.byte $E5,$1C,$85,$CA,$75,$18,$E3,$5C             ; 0FC47E ????u??\
.byte $8C,$89,$C5,$E2,$41,$C1,$F3,$3C             ; 0FC486 ????A??<
.byte $C5,$E0,$47,$65,$D6,$91,$A0,$81             ; 0FC48E ??Ge????
.byte $79,$9E,$C0,$62,$88,$48,$31,$4A             ; 0FC496 y??b?H1J
.byte $09,$01,$8A,$A1,$65,$C5,$70,$91             ; 0FC49E ????e?p?
.byte $CE,$09,$42,$4E,$78,$C2,$47,$3D             ; 0FC4A6 ??BNx?G=
.byte $41,$2E,$74,$2A,$32,$F3,$E7,$06             ; 0FC4AE A.t*2???
.byte $0E,$7E,$C0,$47,$3C,$29,$E7,$90             ; 0FC4B6 ?~?G<)??
.byte $24,$1C,$E6,$10,$8E,$81,$08,$5D             ; 0FC4BE $??????]
.byte $05,$D6,$03,$A2,$40,$13,$CF,$CF             ; 0FC4C6 ????@???
.byte $A2,$C2,$40,$74,$68,$03,$1D,$FC             ; 0FC4CE ??@th???
.byte $F4,$18,$02,$E7,$86,$8B,$27,$40             ; 0FC4D6 ??????'@
.byte $60,$21,$E8,$2A,$0C,$F4,$C3,$45             ; 0FC4DE `!?*???E
.byte $83,$A0,$22,$27,$2C,$01,$81,$E5             ; 0FC4E6 ??"',???
.byte $A0,$16,$CB,$5B,$7E,$DC,$98,$D4             ; 0FC4EE ???[~???
.byte $61,$7A,$9D,$90,$E1,$9F,$BA,$9F             ; 0FC4F6 az??????
.byte $8B,$07,$55,$01,$2D,$8A,$27,$56             ; 0FC4FE ??U?-?'V
.byte $10,$60,$EA,$E0,$24,$1D,$60,$23             ; 0FC506 ?`??$?`#
.byte $AA,$2A,$C7,$59,$01,$39,$B2,$84             ; 0FC50E ?*?Y?9??
.byte $8A,$9B,$BC,$4C,$47,$90,$03,$AA             ; 0FC516 ???LG???
.byte $5A,$7B,$1F,$10,$BD,$93,$59,$EC             ; 0FC51E Z{????Y?
.byte $A7,$21,$A2,$42,$7B,$35,$24,$07             ; 0FC526 ?!?B{5$?
.byte $67,$A0,$84,$ED,$14,$11,$D9,$44             ; 0FC52E g??????D
.byte $83,$B4,$D0,$46,$2C,$24,$23,$16             ; 0FC536 ???F,$#?
.byte $92,$10,$8F,$67,$3E,$2E,$84,$B8             ; 0FC53E ???g>.??
.byte $D0,$D0,$9C,$6A,$82,$4A,$75,$B3             ; 0FC546 ???j?Ju?
.byte $9C,$84,$10,$1A,$75,$80,$87,$4B             ; 0FC54E ????u??K
.byte $E1,$DD,$8C,$64,$ED,$A3,$DD,$D6             ; 0FC556 ???d????
.byte $DE,$36,$C3,$9E,$41,$B4,$00,$48             ; 0FC55E ?6??A??H
.byte $60,$FD,$B2,$78,$40,$61,$97,$84             ; 0FC566 `??x@a??
.byte $1E,$2A,$D3,$DD,$3A,$E2,$E5,$39             ; 0FC56E ?*??:??9
.byte $0E,$8D,$E1,$CD,$D6,$77,$45,$04             ; 0FC576 ?????wE?
.byte $A6,$0F,$69,$0E,$FC,$D2,$86,$36             ; 0FC57E ??i????6
.byte $D7,$45,$B0,$C0,$E0,$97,$B3,$F9             ; 0FC586 ?E??????
.byte $E9,$71,$58,$E5,$F3,$1E,$0B,$2E             ; 0FC58E ?qX????.
.byte $2F,$B0,$77,$E9,$83,$B9,$B1,$0A             ; 0FC596 /?w?????
.byte $F7,$E0,$8C,$27,$3D,$FF,$20,$1D             ; 0FC59E ???'=? ?
.byte $8E,$32,$9E,$27,$67,$C6,$16,$4C             ; 0FC5A6 ?2?'g??L
.byte $A7,$01,$D6,$8F,$91,$B4,$7D,$84             ; 0FC5AE ??????}?
.byte $AB,$C5,$E8,$3C,$81,$CB,$BC,$05             ; 0FC5B6 ???<????
.byte $20,$3C,$80,$2C,$BE,$44,$12,$53             ; 0FC5BE  <?,?D?S
.byte $CA,$14,$07,$78,$4B,$CA,$8D,$98             ; 0FC5C6 ???xK???
.byte $ED,$81,$4D,$EB,$50,$F9,$26,$B9             ; 0FC5CE ??M?P?&?
.byte $6C,$D8,$1D,$1B,$CC,$95,$E3,$7A             ; 0FC5D6 l??????z
.byte $F3,$01,$0B,$A1,$7D,$90,$33,$E5             ; 0FC5DE ????}?3?
.byte $CB,$E5,$56,$F1,$8D,$29,$DF,$EA             ; 0FC5E6 ??V??)??
.byte $4F,$3D,$90,$87,$93,$42,$0E,$CE             ; 0FC5EE O=???B??
.byte $56,$19,$8C,$B1,$84,$0E,$83,$18             ; 0FC5F6 V???????
.byte $4C,$E1,$32,$2E,$60,$02,$5E,$F0             ; 0FC5FE L?2.`?^?
.byte $F0,$2B,$B8,$CE,$C2,$FD,$21,$B5             ; 0FC606 ?+????!?
.byte $E5,$83,$01,$E7,$76,$F5,$B4,$9D             ; 0FC60E ????v???
.byte $BA,$54,$54,$E5,$AB,$B7,$C0,$0F             ; 0FC616 ?TT?????
.byte $57,$02,$CA,$6C,$7E,$91,$F5,$B2             ; 0FC61E W??l~???
.byte $30,$BA,$EF,$18,$4D,$16,$C0,$4B             ; 0FC626 0???M??K
.byte $9A,$F9,$60,$1E,$E3,$12,$3E,$CB             ; 0FC62E ??`???>?
.byte $D2,$53,$65,$DB,$3C,$B5,$EF,$2B             ; 0FC636 ?Se?<??+
.byte $24,$03,$BF,$4E,$40,$C1,$DB,$00             ; 0FC63E $??N@???
.byte $FB,$40,$15,$BC,$D8,$04,$1D,$84             ; 0FC646 ?@??????
.byte $64,$F7,$1A,$42,$3E,$95,$CF,$21             ; 0FC64E d??B>??!
.byte $12,$E5,$71,$BA,$8D,$C3,$EF,$00             ; 0FC656 ??q?????
.byte $59,$F7,$A0,$A4,$03,$8C,$AC,$91             ; 0FC65E Y???????
.byte $F3,$41,$E9,$4C,$97,$7E,$CD,$8B             ; 0FC666 ?A?L?~??
.byte $8C,$F7,$23,$90,$E0,$80,$1F,$8C             ; 0FC66E ??#?????
.byte $0A,$DF,$1C,$90,$90,$5D,$82,$30             ; 0FC676 ?????]?0
.byte $A3,$F3,$0C,$21,$7E,$6A,$0C,$3E             ; 0FC67E ???!~j?>
.byte $68,$A1,$7E,$77,$10,$9F,$3F,$08             ; 0FC686 h?~w????
.byte $0F,$A1,$0B,$03,$F4,$68,$24,$7D             ; 0FC68E ?????h$}
.byte $E5,$C8,$FA,$0D,$2F,$75,$96,$DE             ; 0FC696 ????/u??
.byte $62,$5F,$6F,$16,$EF,$00,$84,$4C             ; 0FC69E b_o????L
.byte $7E,$30,$78,$0C,$2D,$CA,$70,$1E             ; 0FC6A6 ~0x?-?p?
.byte $07,$0F,$B4,$0C,$F9,$86,$BE,$D6             ; 0FC6AE ????????
.byte $43,$ED,$DA,$DC,$AE,$7D,$BC,$3E             ; 0FC6B6 C????}?>
.byte $F0,$32,$F9,$25,$3E,$F8,$10,$1E             ; 0FC6BE ?2?%>???
.byte $83,$18,$7F,$03,$5C,$CC,$FF,$06             ; 0FC6C6 ????\???
.byte $85,$F8,$50,$4F,$B0,$00,$D9,$62             ; 0FC6CE ??PO???b
.byte $8F,$B2,$00,$46,$D8,$0B,$F1,$02             ; 0FC6D6 ???F????
.byte $CF,$E2,$C1,$20,$FC,$78,$8D,$F2             ; 0FC6DE ??? ?x??
.byte $82,$FC,$A0,$0C,$3F,$80,$10,$8F             ; 0FC6E6 ????????
.byte $C2,$08,$47,$E4,$04,$3F,$67,$3F             ; 0FC6EE ??G???g?
.byte $94,$C1,$FD,$BC,$2D,$E3,$83,$F7             ; 0FC6F6 ????-???
.byte $78,$97,$F1,$82,$5E,$D2,$52,$B9             ; 0FC6FE x???^?R?
.byte $62,$DF,$D1,$B2,$26,$F5,$58,$41             ; 0FC706 b???&?XA
.byte $FE,$4F,$A4,$64,$FF,$17,$FE,$0E             ; 0FC70E ?O?d????
.byte $DB,$D7,$3A,$46,$5F,$E8,$03,$03             ; 0FC716 ??:F_???
.byte $FD,$40,$84,$FE,$BC,$49,$FD,$A1             ; 0FC71E ?@???I??
.byte $95,$FE,$F8,$40,$FF,$87,$FE,$58             ; 0FC726 ???@???X
.byte $64,$EF,$93,$E0,$37,$F3,$C7,$7F             ; 0FC72E d???7???
.byte $F4,$85,$C7,$58,$60,$53,$7F,$6E             ; 0FC736 ???X`S?n
.byte $37,$6A,$89,$0D,$DB,$A6,$13,$64             ; 0FC73E 7j?????d
.byte $7C,$0D,$F2,$16,$D5,$B1,$78,$1C             ; 0FC746 |?????x?
.byte $0D,$F3,$00,$E0,$60,$5B,$7D,$6E             ; 0FC74E ????`[}n
.byte $1E,$07,$04,$80,$E0,$40,$48,$0E             ; 0FC756 ?????@H?
.byte $05,$04,$93,$81,$78,$0D,$FE,$20             ; 0FC75E ????x?? 
.byte $B8,$1B,$D7,$7F,$C8,$38,$1F,$81             ; 0FC766 ?????8??
.byte $E0,$03,$27,$3B,$FD,$65,$DE,$AC             ; 0FC76E ??';?e??
.byte $85,$1D,$F5,$D8,$04,$DF,$1C,$80             ; 0FC776 ????????
.byte $77,$E2,$74,$D8,$C9,$76,$71,$77             ; 0FC77E w?t??vqw
.byte $0E,$B8,$5B,$78,$50,$2E,$14,$41             ; 0FC786 ??[xP.?A
.byte $2E,$15,$14,$60,$E1,$84,$12,$0E             ; 0FC78E .??`????
.byte $15,$41,$6E,$16,$25,$09,$38,$69             ; 0FC796 ?An?%?8i
.byte $80,$87,$86,$D4,$18,$38,$79,$04             ; 0FC79E ?????8y?
.byte $93,$87,$D8,$09,$76,$CB,$D6,$0D             ; 0FC7A6 ????v???
.byte $DB,$3D,$DB,$47,$6C,$40,$2E,$22             ; 0FC7AE ?=?Gl@."
.byte $75,$E2,$48,$2E,$24,$31,$62,$00             ; 0FC7B6 u?H.$1b?
.byte $08,$CD,$00,$00,$20,$00,$20,$01             ; 0FC7BE ???? ? ?
.byte $2C,$02,$2C,$03,$2C,$03,$6C,$02             ; 0FC7C6 ,?,?,?l?
.byte $6C,$01,$6C,$04,$2C,$05,$2C,$06             ; 0FC7CE l?l?,?,?
.byte $28,$07,$28,$07,$68,$06,$68,$05             ; 0FC7D6 (?(?h?h?
.byte $6C,$04,$08,$2C,$09,$2C,$0A,$2C             ; 0FC7DE l??,?,?,
.byte $0B,$28,$0C,$28,$0C,$68,$0B,$68             ; 0FC7E6 ?(?(?h?h
.byte $0A,$6C,$09,$6C,$08,$0D,$2C,$0E             ; 0FC7EE ?l?l??,?
.byte $2C,$0F,$28,$10,$28,$11,$24,$11             ; 0FC7F6 ,?(?(?$?
.byte $64,$10,$68,$0F,$68,$0E,$6C,$0D             ; 0FC7FE d?h?h?l?
.byte $12,$2C,$13,$2C,$14,$28,$15,$28             ; 0FC806 ?,?,?(?(
.byte $16,$24,$16,$64,$15,$68,$14,$68             ; 0FC80E ?$?d?h?h
.byte $13,$6C,$12,$17,$2C,$18,$2C,$19             ; 0FC816 ?l??,?,?
.byte $28,$1A,$24,$1B,$24,$1B,$64,$1A             ; 0FC81E (?$?$?d?
.byte $64,$19,$68,$18,$6C,$17,$1C,$2C             ; 0FC826 d?h?l??,
.byte $1D,$2C,$1E,$28,$1F,$24,$20,$24             ; 0FC82E ?,?(?$ $
.byte $20,$64,$1F,$64,$1E,$68,$1D,$6C             ; 0FC836  d?d?h?l
.byte $1C,$21,$2C,$22,$2C,$23,$28,$24             ; 0FC83E ?!,",#($
.byte $24,$25,$24,$25,$64,$24,$64,$23             ; 0FC846 $%$%d$d#
.byte $68,$22,$6C,$21,$26,$2C,$27,$2C             ; 0FC84E h"l!&,',
.byte $28,$2C,$29,$28,$2A,$28,$2A,$68             ; 0FC856 (,)(*(*h
.byte $29,$68,$28,$6C,$27,$6C,$26,$2B             ; 0FC85E )h(l'l&+
.byte $2C,$2C,$2C,$2D,$2C,$2E,$2C,$2E             ; 0FC866 ,,,-,.,.
.byte $6C,$2D,$6C,$2C,$6C,$2B,$2F,$2C             ; 0FC86E l-l,l+/,
.byte $30,$2C,$31,$2C,$32,$2C,$32,$6C             ; 0FC876 0,1,2,2l
.byte $31,$6C,$30,$6C,$2F,$00,$20,$33             ; 0FC87E 1l0l/? 3
.byte $2C,$34,$2C,$34,$6C,$33,$00,$60             ; 0FC886 ,4,4l3?`
.byte $38,$1C,$13,$41,$4D,$E0,$09,$5C             ; 0FC88E 8??AM??\
.byte $78,$A3,$02,$EA,$22,$2C,$0B,$C9             ; 0FC896 x???",??
.byte $88,$B0,$2E,$D3,$11,$60,$5E,$26             ; 0FC89E ??.??`^&
.byte $22,$C0,$BD,$4C,$45,$81,$7C,$98             ; 0FC8A6 "??LE?|?
.byte $8B,$02,$E2,$88,$A3,$2B,$81,$E2             ; 0FC8AE ?????+??
.byte $AC,$AE,$07,$A0,$30,$3D,$22,$82             ; 0FC8B6 ????0="?
.byte $F6,$72,$09,$D9,$C8,$29,$E3,$CA             ; 0FC8BE ?r???)??
.byte $A3,$B9,$D5,$51,$E0,$E2,$A8,$F2             ; 0FC8C6 ???Q????
.byte $6D,$54,$7A,$34,$AA,$3D,$99,$55             ; 0FC8CE mTz4?=?U
.byte $1F,$0C,$2A,$8F,$A5,$D5,$47,$E5             ; 0FC8D6 ??*???G?
.byte $88,$81,$00,$08,$C6,$00,$00,$20             ; 0FC8DE ??????? 
.byte $00,$20,$35,$2C,$36,$2C,$37,$2C             ; 0FC8E6 ? 5,6,7,
.byte $37,$6C,$36,$6C,$35,$6C,$38,$2C             ; 0FC8EE 7l6l5l8,
.byte $39,$2C,$3A,$28,$07,$28,$07,$68             ; 0FC8F6 9,:(?(?h
.byte $3A,$68,$39,$6C,$38,$3B,$2C,$0A             ; 0FC8FE :h9l8;,?
.byte $2C,$0B,$28,$0C,$28,$0C,$68,$0B             ; 0FC906 ,?(?(?h?
.byte $68,$0A,$6C,$3B,$3C,$2C,$3D,$2C             ; 0FC90E h?l;<,=,
.byte $0F,$28,$10,$28,$11,$24,$11,$64             ; 0FC916 ?(?(?$?d
.byte $10,$68,$0F,$68,$3D,$6C,$3C,$3E             ; 0FC91E ?h?h=l<>
.byte $2C,$13,$2C,$14,$28,$15,$28,$16             ; 0FC926 ,?,?(?(?
.byte $24,$16,$64,$15,$68,$14,$68,$13             ; 0FC92E $?d?h?h?
.byte $6C,$3E,$3F,$2C,$40,$2C,$19,$28             ; 0FC936 l>?,@,?(
.byte $1A,$24,$1B,$24,$1B,$64,$1A,$64             ; 0FC93E ?$?$?d?d
.byte $19,$68,$40,$6C,$3F,$41,$2C,$42             ; 0FC946 ?h@l?A,B
.byte $2C,$1E,$28,$1F,$24,$20,$24,$20             ; 0FC94E ,?(?$ $ 
.byte $64,$1F,$64,$1E,$68,$42,$6C,$41             ; 0FC956 d?d?hBlA
.byte $43,$2C,$44,$2C,$23,$28,$24,$24             ; 0FC95E C,D,#($$
.byte $25,$24,$25,$64,$24,$64,$23,$68             ; 0FC966 %$%d$d#h
.byte $44,$6C,$43,$45,$2C,$46,$2C,$28             ; 0FC96E DlCE,F,(
.byte $2C,$29,$28,$2A,$28,$2A,$68,$29             ; 0FC976 ,)(*(*h)
.byte $68,$28,$6C,$46,$6C,$45,$47,$2C             ; 0FC97E h(lFlEG,
.byte $48,$2C,$49,$2C,$2E,$2C,$2E,$6C             ; 0FC986 H,I,.,.l
.byte $49,$6C,$48,$6C,$47,$4A,$2C,$00             ; 0FC98E IlHlGJ,?
.byte $20,$4B,$2C,$4C,$2C,$4C,$6C,$4B             ; 0FC996  K,L,LlK
.byte $4A,$00,$20,$4D,$2C,$4E,$2C,$4E             ; 0FC99E J? M,N,N
.byte $6C,$4D,$00,$60,$38,$1C,$13,$41             ; 0FC9A6 lM?`8??A
.byte $4D,$E0,$09,$5C,$78,$AB,$2B,$A8             ; 0FC9AE M??\x?+?
.byte $8A,$30,$2F,$22,$22,$C0,$BB,$4C             ; 0FC9B6 ?0/""??L
.byte $45,$81,$78,$98,$8B,$02,$F5,$31             ; 0FC9BE E?x????1
.byte $16,$05,$F2,$62,$2C,$0B,$92,$22             ; 0FC9C6 ???b,??"
.byte $8C,$AE,$28,$8A,$B0,$BC,$A3,$60             ; 0FC9CE ??(????`
.byte $7A,$03,$03,$D2,$28,$2F,$67,$20             ; 0FC9D6 z???(/g 
.byte $9D,$9C,$82,$9E,$3C,$AA,$3B,$9D             ; 0FC9DE ????<?;?
.byte $55,$1E,$0E,$2A,$8F,$26,$D5,$47             ; 0FC9E6 U??*?&?G
.byte $A3,$4A,$A3,$D9,$95,$51,$F0,$C2             ; 0FC9EE ?J???Q??
.byte $A8,$FA,$5D,$54,$7E,$58,$88,$10             ; 0FC9F6 ??]T~X??
.byte $00,$08,$42,$03,$1E,$28,$1F,$24             ; 0FC9FE ??B??(?$
.byte $20,$24,$4F,$28,$50,$28,$51,$28             ; 0FCA06  $O(P(Q(
.byte $52,$28,$53,$28,$54,$28,$55,$28             ; 0FCA0E R(S(T(U(
.byte $56,$24,$57,$24,$58,$28,$59,$28             ; 0FCA16 V$W$X(Y(
.byte $5A,$28,$5B,$28,$5C,$28,$5D,$28             ; 0FCA1E Z([(\(](
.byte $5E,$28,$5F,$24,$60,$24,$61,$28             ; 0FCA26 ^(_$`$a(
.byte $62,$28,$63,$28,$64,$28,$65,$28             ; 0FCA2E b(c(d(e(
.byte $66,$28,$67,$24,$68,$24,$69,$24             ; 0FCA36 f(g$h$i$
.byte $00,$20,$00,$20,$23,$28,$24,$24             ; 0FCA3E ? ? #($$
.byte $25,$24,$6A,$28,$6B,$28,$6C,$28             ; 0FCA46 %$j(k(l(
.byte $6D,$28,$6E,$28,$6F,$28,$70,$28             ; 0FCA4E m(n(o(p(
.byte $71,$24,$72,$24,$73,$28,$74,$28             ; 0FCA56 q$r$s(t(
.byte $75,$28,$76,$28,$77,$28,$78,$28             ; 0FCA5E u(v(w(x(
.byte $79,$28,$7A,$24,$7B,$24,$7C,$28             ; 0FCA66 y(z${$|(
.byte $7D,$28,$7E,$28,$7F,$28,$80,$81             ; 0FCA6E }(~(?(??
.byte $28,$82,$24,$83,$28,$2C,$29,$28             ; 0FCA76 (?$?(,)(
.byte $2A,$28,$28,$2C,$84,$28,$85,$86             ; 0FCA7E *((,?(??
.byte $87,$88,$89,$8A,$28,$8B,$28,$20             ; 0FCA86 ????(?( 
.byte $64,$1F,$64,$1E,$68,$51,$68,$50             ; 0FCA8E d?d?hQhP
.byte $68,$4F,$68,$54,$68,$53,$68,$52             ; 0FCA96 hOhThShR
.byte $68,$57,$64,$56,$64,$55,$68,$5A             ; 0FCA9E hWdVdUhZ
.byte $68,$59,$68,$58,$68,$5D,$68,$5C             ; 0FCAA6 hYhXh]h\
.byte $68,$5B,$68,$60,$64,$5F,$64,$5E             ; 0FCAAE h[h`d_d^
.byte $68,$63,$68,$62,$68,$61,$68,$66             ; 0FCAB6 hchbhahf
.byte $68,$65,$68,$64,$68,$69,$64,$68             ; 0FCABE hehdhidh
.byte $64,$67,$64,$25,$64,$24,$64,$23             ; 0FCAC6 dgd%d$d#
.byte $68,$6C,$68,$6B,$68,$6A,$68,$6F             ; 0FCACE hlhkhjho
.byte $68,$6E,$68,$6D,$68,$72,$64,$71             ; 0FCAD6 hnhmhrdq
.byte $64,$70,$68,$75,$68,$74,$68,$73             ; 0FCADE dphuhths
.byte $68,$78,$68,$77,$68,$76,$68,$7B             ; 0FCAE6 hxhwhvh{
.byte $64,$7A,$64,$79,$68,$7E,$68,$7D             ; 0FCAEE dzdyh~h}
.byte $68,$7C,$80,$68,$7F,$68,$83,$64             ; 0FCAF6 h|?h?h?d
.byte $82,$64,$81,$68,$2A,$68,$29,$68             ; 0FCAFE ?d?h*h)h
.byte $28,$6C,$85,$68,$84,$2A,$68,$86             ; 0FCB06 (l?h?*h?
.byte $87,$88,$89,$8B,$68,$8A,$8C,$28             ; 0FCB0E ????h??(
.byte $8D,$28,$11,$24,$8E,$28,$8F,$90             ; 0FCB16 ?(?$?(??
.byte $28,$91,$92,$28,$93,$94,$28,$95             ; 0FCB1E (??(??(?
.byte $96,$28,$97,$00,$20,$06,$28,$07             ; 0FCB26 ?(?? ?(?
.byte $28,$98,$20,$99,$20,$9A,$20,$9B             ; 0FCB2E (? ? ? ?
.byte $9C,$28,$9D,$28,$16,$24,$9E,$9F             ; 0FCB36 ?(?(?$??
.byte $28,$A0,$A1,$A2,$28,$A3,$A4,$28             ; 0FCB3E (???(??(
.byte $A5,$A6,$28,$A7,$A8,$28,$A9,$0F             ; 0FCB46 ??(??(??
.byte $28,$10,$AA,$28,$AB,$24,$11,$24             ; 0FCB4E (??(?$?$
.byte $AC,$28,$AD,$AE,$28,$AF,$24,$B0             ; 0FCB56 ?(??(?$?
.byte $07,$68,$06,$68,$99,$60,$98,$60             ; 0FCB5E ?h?h?`?`
.byte $9B,$60,$9A,$60,$00,$20,$14,$28             ; 0FCB66 ?`?`? ?(
.byte $15,$B1,$24,$B2,$24,$16,$24,$B3             ; 0FCB6E ??$?$?$?
.byte $24,$B4,$B5,$24,$B6,$24,$B7,$1A             ; 0FCB76 $??$?$??
.byte $24,$1B,$24,$1B,$64,$1A,$19,$28             ; 0FCB7E $?$?d??(
.byte $B8,$24,$11,$64,$8D,$68,$8C,$68             ; 0FCB86 ?$?d?h?h
.byte $11,$64,$97,$68,$96,$95,$68,$94             ; 0FCB8E ?d?h??h?
.byte $93,$68,$92,$91,$68,$90,$8F,$68             ; 0FCB96 ?h??h??h
.byte $8E,$19,$68,$B8,$64,$16,$64,$9D             ; 0FCB9E ??h?d?d?
.byte $68,$9C,$68,$16,$64,$A9,$68,$A8             ; 0FCBA6 h?h?d?h?
.byte $A7,$68,$A6,$A5,$68,$A4,$A3,$68             ; 0FCBAE ?h??h??h
.byte $A2,$9D,$68,$A1,$A0,$68,$9F,$9E             ; 0FCBB6 ??h??h??
.byte $B9,$24,$BA,$24,$BA,$64,$B9,$00             ; 0FCBBE ?$?$?d??
.byte $20,$11,$64,$10,$68,$0F,$AB,$64             ; 0FCBC6  ?d?h??d
.byte $AA,$AD,$64,$AC,$68,$B0,$64,$AF             ; 0FCBCE ??d?h?d?
.byte $64,$AE,$BB,$2C,$BC,$2C,$BD,$2C             ; 0FCBD6 d??,?,?,
.byte $BE,$2C,$BF,$2C,$C0,$2C,$C1,$2C             ; 0FCBDE ?,?,?,?,
.byte $BD,$6C,$BC,$6C,$BB,$C1,$6C,$C0             ; 0FCBE6 ?l?l??l?
.byte $6C,$BF,$6C,$BE,$16,$64,$15,$68             ; 0FCBEE l?l??d?h
.byte $14,$B2,$64,$B1,$B4,$64,$B3,$64             ; 0FCBF6 ??d??d?d
.byte $B7,$64,$B6,$64,$B5,$C2,$2C,$C3             ; 0FCBFE ?d?d??,?
.byte $2C,$C4,$2C,$C5,$2C,$C6,$2C,$C7             ; 0FCC06 ,?,?,?,?
.byte $2C,$C8,$2C,$C9,$2C,$C5,$6C,$C4             ; 0FCC0E ,?,?,?l?
.byte $6C,$C3,$6C,$C2,$6C,$C9,$6C,$C8             ; 0FCC16 l?l?l?l?
.byte $6C,$C7,$6C,$C6,$CA,$2C,$CB,$2C             ; 0FCC1E l?l??,?,
.byte $CC,$2C,$CD,$2C,$00,$20,$CE,$2C             ; 0FCC26 ?,?,? ?,
.byte $CF,$2C,$D0,$2C,$CD,$6C,$CC,$6C             ; 0FCC2E ?,?,?l?l
.byte $CB,$6C,$CA,$6C,$D0,$6C,$CF,$6C             ; 0FCC36 ?l?l?l?l
.byte $CE,$D1,$2C,$D2,$2C,$D3,$2C,$D4             ; 0FCC3E ??,?,?,?
.byte $00,$20,$D5,$2C,$D6,$2C,$D4,$6C             ; 0FCC46 ? ?,?,?l
.byte $D3,$6C,$D2,$6C,$D1,$6C,$D6,$6C             ; 0FCC4E ?l?l?l?l
.byte $D5,$D7,$2C,$D8,$2C,$D9,$D9,$6C             ; 0FCC56 ??,?,??l
.byte $D8,$6C,$D7,$DA,$2C,$DB,$2C,$DC             ; 0FCC5E ?l??,?,?
.byte $2C,$DD,$2C,$DE,$DF,$2C,$E0,$2C             ; 0FCC66 ,?,??,?,
.byte $E1,$00,$20,$DB,$6C,$DA,$6C,$DB             ; 0FCC6E ?? ?l?l?
.byte $6C,$DE,$6C,$DD,$6C,$DC,$6C,$DB             ; 0FCC76 l?l?l?l?
.byte $6C,$E1,$6C,$E0,$6C,$DF,$E2,$E3             ; 0FCC7E l?l?l???
.byte $2C,$E4,$2C,$E5,$00,$20,$E2,$6C             ; 0FCC86 ,?,?? ?l
.byte $E2,$6C,$E4,$6C,$E3,$6C,$E5,$E6             ; 0FCC8E ?l?l?l??
.byte $E7,$2C,$E8,$2C,$E9,$EA,$2C,$EB             ; 0FCC96 ?,?,??,?
.byte $00,$20,$E6,$6C,$E9,$6C,$E8,$6C             ; 0FCC9E ? ?l?l?l
.byte $E7,$6C,$EB,$6C,$EA,$EC,$2C,$C0             ; 0FCCA6 ?l?l??,?
.byte $6C,$ED,$2C,$EE,$2C,$EC,$2C,$EF             ; 0FCCAE l?,?,?,?
.byte $2C,$F0,$F1,$2C,$F2,$F3,$2C,$F4             ; 0FCCB6 ,??,??,?
.byte $2C,$F5,$F6,$F7,$F8,$F9,$2C,$FA             ; 0FCCBE ,?????,?
.byte $2C,$FB,$2C,$FC,$FD,$2C,$FE,$FF             ; 0FCCC6 ,?,??,??
.byte $2C,$00,$2D,$01,$2D,$FC,$2C,$02             ; 0FCCCE ,?-?-?,?
.byte $03,$2D,$04,$2D,$05,$06,$2D,$07             ; 0FCCD6 ?-?-??-?
.byte $2D,$08,$09,$2D,$0A,$2D,$0B,$2D             ; 0FCCDE -??-?-?-
.byte $00,$20,$09,$2D,$0C,$0D,$2D,$0E             ; 0FCCE6 ? ?-??-?
.byte $0F,$10,$11,$2D,$12,$00,$20,$EE             ; 0FCCEE ???-?? ?
.byte $6C,$ED,$6C,$C0,$2C,$EC,$6C,$EE             ; 0FCCF6 l?l?,?l?
.byte $6C,$F0,$6C,$EF,$6C,$F2,$6C,$F1             ; 0FCCFE l?l?l?l?
.byte $F5,$6C,$F4,$6C,$F3,$F6,$F7,$F8             ; 0FCD06 ?l?l????
.byte $FC,$6C,$FB,$6C,$FA,$6C,$F9,$FE             ; 0FCD0E ?l?l?l??
.byte $6C,$FD,$01,$6D,$00,$6D,$FF,$02             ; 0FCD16 l??m?m??
.byte $6D,$FC,$6C,$05,$6D,$04,$6D,$03             ; 0FCD1E m?l?m?m?
.byte $6D,$FC,$6C,$08,$6D,$07,$6D,$06             ; 0FCD26 m?l?m?m?
.byte $6D,$00,$20,$0B,$6D,$0A,$6D,$09             ; 0FCD2E m? ?m?m?
.byte $0C,$0E,$6D,$0D,$0F,$10,$00,$20             ; 0FCD36 ??m???? 
.byte $12,$6D,$11,$6D,$28,$2F,$86,$1D             ; 0FCD3E ?m?m(/??
.byte $DB,$0B,$C2,$DC,$1B,$C1,$00,$5C             ; 0FCD46 ???????\
.byte $A8,$DD,$4D,$D3,$B0,$6F,$84,$A8             ; 0FCD4E ??M??o??
.byte $77,$84,$2A,$F1,$D8,$4D,$F8,$40             ; 0FCD56 w?*??M?@
.byte $F4,$39,$E9,$2F,$42,$00,$BB,$0D             ; 0FCD5E ?9?/B???
.byte $D6,$46,$ED,$B3,$DC,$F9,$E1,$DF             ; 0FCD66 ?F??????
.byte $0E,$F8,$9D,$F1,$4E,$F8,$A9,$EE             ; 0FCD6E ????N???
.byte $08,$1F,$87,$3F,$26,$7E,$78,$7C             ; 0FCD76 ????&~x|
.byte $F5,$9F,$C3,$3F,$9E,$47,$DE,$CB             ; 0FCD7E ?????G??
.byte $C0,$2C,$F0,$4D,$C0,$EC,$F0,$AC             ; 0FCD86 ?,?M????
.byte $F0,$DC,$F1,$0C,$F1,$3E,$D8,$29             ; 0FCD8E ?????>?)
.byte $3B,$DB,$03,$C9,$30,$F1,$7A,$BC             ; 0FCD96 ;???0?z?
.byte $BC,$04,$03,$C5,$B0,$3D,$13,$0F             ; 0FCD9E ?????=??
.byte $2B,$A0,$EC,$02,$A9,$2E,$7D,$CA             ; 0FCDA6 +????.}?
.byte $F8,$2C,$F8,$5C,$F8,$88,$78,$8A             ; 0FCDAE ?,?\??x?
.byte $CF,$91,$CE,$9D,$BD,$D4,$92,$BE             ; 0FCDB6 ????????
.byte $8B,$3E,$97,$3E,$A3,$3E,$AF,$3E             ; 0FCDBE ?>?>?>?>
.byte $BB,$3E,$BA,$DE,$5F,$2E,$7D,$B2             ; 0FCDC6 ?>??_.}?
.byte $F9,$4C,$FC,$2C,$0F,$97,$B0,$2E             ; 0FCDCE ?L?,???.
.byte $BD,$CB,$AF,$63,$0F,$B4,$CF,$9F             ; 0FCDD6 ???c????
.byte $C0,$FB,$CC,$AB,$AF,$6A,$B2,$8E             ; 0FCDDE ?????j??
.byte $5E,$C0,$19,$78,$43,$00,$E5,$EC             ; 0FCDE6 ^??xC???
.byte $01,$79,$68,$10,$F1,$87,$98,$09             ; 0FCDEE ?yh?????
.byte $CC,$84,$E5,$E1,$0F,$1D,$79,$B8             ; 0FCDF6 ??????y?
.byte $9C,$E4,$4E,$5A,$09,$BE,$A2,$07             ; 0FCDFE ??NZ????
.byte $A0,$B0,$F4,$36,$4D,$EF,$12,$BC             ; 0FCE06 ???6M???
.byte $F1,$47,$85,$41,$70,$A6,$0E,$A3             ; 0FCE0E ?G?Ap???
.byte $17,$52,$D8,$38,$38,$12,$75,$80             ; 0FCE16 ?R?88?u?
.byte $2E,$B3,$F4,$C9,$0E,$35,$05,$C6             ; 0FCE1E .????5??
.byte $98,$7B,$0F,$3D,$8D,$83,$8B,$81             ; 0FCE26 ?{?=????
.byte $27,$68,$09,$ED,$3E,$A9,$01,$42             ; 0FCE2E 'h??>??B
.byte $47,$C0,$AC,$F8,$36,$1F,$06,$BB             ; 0FCE36 G???6???
.byte $B4,$3C,$0C,$17,$83,$46,$F0,$A8             ; 0FCE3E ?<???F??
.byte $DE,$35,$97,$C7,$F3,$E4,$54,$F2             ; 0FCE46 ?5????T?
.byte $6C,$06,$FC,$8B,$CB,$B0,$F9,$95             ; 0FCE4E l???????
.byte $3C,$DB,$0F,$9D,$61,$7D,$06,$9E             ; 0FCE56 <???a}??
.byte $8B,$19,$F4,$AB,$7A,$4C,$6F,$51             ; 0FCE5E ????zLoQ
.byte $A7,$A8,$C5,$9F,$5E,$FA,$F9,$3D             ; 0FCE66 ????^??=
.byte $7C,$A7,$AF,$95,$20,$0F,$83,$13             ; 0FCE6E |??? ???
.byte $F0,$D6,$1F,$8B,$EE,$90,$F8,$B1             ; 0FCE76 ????????
.byte $7C,$2C,$6F,$89,$8D,$F1,$B6,$5F             ; 0FCE7E |,o????_
.byte $9F,$CF,$D1,$53,$E9,$AC,$3F,$57             ; 0FCE86 ???S???W
.byte $8D,$F3,$10,$1F,$68,$49,$5F,$BF             ; 0FCE8E ????hI_?
.byte $B7,$E1,$53,$F1,$AC,$FE,$34,$6F             ; 0FCE96 ??S???4o
.byte $CE,$8D,$FA,$54,$FD,$28,$B0,$FE             ; 0FCE9E ???T?(??
.byte $FD,$3F,$7E,$A7,$EF,$D5,$28,$00             ; 0FCEA6 ??~???(?
.byte $00,$C5,$6E,$A4,$55,$A2,$28,$84             ; 0FCEAE ??n?U?(?
.byte $10,$A4,$0E,$99,$0C,$FF,$03,$E7             ; 0FCEB6 ????????
.byte $1C,$6B,$2D,$B5,$56,$8C,$28,$3B             ; 0FCEBE ?k-?V?(;
.byte $50,$33,$25,$1F,$3A,$5A,$6B,$00             ; 0FCEC6 P3%?:Zk?
.byte $00,$84,$00,$C6,$00,$29,$01,$6B             ; 0FCECE ?????)?k
.byte $01,$AD,$01,$EF,$01,$8C,$31,$31             ; 0FCED6 ??????11
.byte $02,$94,$02,$D6,$02,$FF,$03,$C9             ; 0FCEDE ????????
.byte $00,$B0,$00,$0E,$01,$71,$01,$00             ; 0FCEE6 ?????q??
.byte $00,$84,$00,$C6,$00,$B0,$00,$29             ; 0FCEEE ???????)
.byte $01,$6B,$01,$F0,$01,$52,$02,$D6             ; 0FCEF6 ?k???R??
.byte $02,$FF,$03,$8C,$28,$71,$34,$3B             ; 0FCEFE ????(q4;
.byte $50,$8C,$31,$B5,$56,$7B,$6F,$00             ; 0FCF06 P?1?V{o?
.byte $00,$84,$10,$A5,$14,$C6,$18,$08             ; 0FCF0E ????????
.byte $21,$29,$25,$8C,$28,$CE,$39,$3B             ; 0FCF16 !)%?(?9;
.byte $50,$52,$4A,$5A,$6B,$29,$01,$AD             ; 0FCF1E PRJZk)??
.byte $01,$13,$00,$79,$01,$7F,$0B,$00             ; 0FCF26 ???y????
.byte $00,$C5,$6E,$A4,$55,$A2,$28,$84             ; 0FCF2E ??n?U?(?
.byte $10,$A4,$0E,$99,$0C,$FF,$03,$E7             ; 0FCF36 ????????
.byte $1C,$6B,$2D,$B5,$56,$8C,$28,$3B             ; 0FCF3E ?k-?V?(;
.byte $50,$33,$25,$1F,$3A,$5A,$6B,$00             ; 0FCF46 P3%?:Zk?
.byte $00,$8A,$20,$8C,$28,$6E,$28,$B1             ; 0FCF4E ?? ?(n(?
.byte $34,$79,$55,$7E,$58,$BD,$73,$F7             ; 0FCF56 4yU~X?s?
.byte $5E,$34,$4A,$58,$5A,$46,$10,$AA             ; 0FCF5E ^4JXZF??
.byte $14,$33,$25,$76,$29,$1F,$3A,$00             ; 0FCF66 ?3%v)?:?
.byte $00,$84,$00,$C6,$00,$08,$01,$29             ; 0FCF6E ???????)
.byte $01,$6B,$01,$F0,$01,$52,$02,$D6             ; 0FCF76 ?k???R??
.byte $02,$FF,$03,$C9,$00,$B0,$00,$3B             ; 0FCF7E ???????;
.byte $50,$0E,$01,$B5,$56,$7B,$6F,$00             ; 0FCF86 P???V{o?
.byte $00,$C6,$08,$C6,$18,$4A,$21,$29             ; 0FCF8E ?????J!)
.byte $25,$AD,$25,$EF,$2D,$31,$32,$8C             ; 0FCF96 %?%?-12?
.byte $31,$52,$36,$94,$3E,$42,$08,$D7             ; 0FCF9E 1R6?>B??
.byte $42,$7C,$53,$52,$4A,$DF,$5B,$00             ; 0FCFA6 B|SRJ?[?
.byte $08,$89,$04,$01,$00,$02,$00,$02             ; 0FCFAE ????????
.byte $00,$03,$03,$40,$01,$40,$04,$00             ; 0FCFB6 ???@?@??
.byte $05,$00,$06,$00,$07,$00,$08,$00             ; 0FCFBE ????????
.byte $09,$00,$0A,$00,$0A,$00,$0B,$00             ; 0FCFC6 ????????
.byte $0C,$00,$0D,$00,$0E,$00,$0F,$00             ; 0FCFCE ????????
.byte $0F,$00,$0E,$40,$0D,$40,$0C,$40             ; 0FCFD6 ???@?@?@
.byte $0B,$40,$09,$40,$08,$40,$07,$40             ; 0FCFDE ?@?@?@?@
.byte $06,$40,$05,$40,$04,$10,$00,$11             ; 0FCFE6 ?@?@????
.byte $00,$12,$00,$13,$00,$14,$08,$15             ; 0FCFEE ????????
.byte $08,$16,$08,$17,$08,$18,$08,$19             ; 0FCFF6 ????????
.byte $00,$1A,$00,$1B,$00,$1C,$00,$1D             ; 0FCFFE ????????
.byte $00,$1E,$00,$1E,$40,$1D,$40,$1C             ; 0FD006 ????@?@?
.byte $40,$1B,$40,$1A,$00,$19,$40,$13             ; 0FD00E @?@???@?
.byte $40,$12,$40,$11,$40,$10,$1F,$00             ; 0FD016 @?@?@???
.byte $20,$00,$21,$00,$22,$00,$23,$00             ; 0FD01E  ?!?"?#?
.byte $24,$08,$25,$08,$26,$08,$27,$08             ; 0FD026 $?%?&?'?
.byte $28,$08,$29,$00,$2A,$04,$2B,$04             ; 0FD02E (?)?*?+?
.byte $2C,$00,$2D,$00,$2E,$00,$2E,$40             ; 0FD036 ,?-?.?.@
.byte $2D,$40,$2C,$40,$2B,$44,$2A,$44             ; 0FD03E -@,@+D*D
.byte $29,$40,$23,$40,$22,$40,$21,$40             ; 0FD046 )@#@"@!@
.byte $20,$40,$1F,$2F,$00,$30,$00,$31             ; 0FD04E  @?/?0?1
.byte $00,$32,$00,$33,$08,$34,$08,$35             ; 0FD056 ?2?3?4?5
.byte $08,$36,$08,$37,$08,$38,$00,$39             ; 0FD05E ?6?7?8?9
.byte $04,$3A,$04,$3B,$00,$3C,$00,$3D             ; 0FD066 ?:?;?<?=
.byte $00,$3D,$40,$3C,$40,$3B,$40,$3A             ; 0FD06E ?=@<@;@:
.byte $44,$39,$44,$38,$40,$32,$40,$31             ; 0FD076 D9D8@2@1
.byte $40,$30,$40,$2F,$3E,$00,$3F,$00             ; 0FD07E @0@/>???
.byte $40,$00,$41,$00,$42,$08,$43,$08             ; 0FD086 @?A?B?C?
.byte $44,$08,$45,$08,$46,$08,$47,$00             ; 0FD08E D?E?F?G?
.byte $48,$04,$49,$04,$4A,$00,$4B,$00             ; 0FD096 H?I?J?K?
.byte $4C,$00,$4C,$40,$4B,$40,$4A,$40             ; 0FD09E L?L@K@J@
.byte $49,$44,$48,$44,$47,$40,$41,$40             ; 0FD0A6 IDHDG@A@
.byte $40,$40,$3F,$40,$3E,$4D,$00,$4E             ; 0FD0AE @@?@>M?N
.byte $00,$4F,$00,$50,$00,$51,$00,$51             ; 0FD0B6 ?O?P?Q?Q
.byte $52,$00,$53,$00,$54,$00,$55,$00             ; 0FD0BE R?S?T?U?
.byte $56,$00,$56,$00,$56,$40,$56,$40             ; 0FD0C6 V?V?V@V@
.byte $55,$40,$54,$40,$53,$40,$52,$40             ; 0FD0CE U@T@S@R@
.byte $51,$40,$51,$50,$40,$4F,$40,$4E             ; 0FD0D6 Q@QP@O@N
.byte $40,$4D,$57,$00,$58,$00,$59,$00             ; 0FD0DE @MW?X?Y?
.byte $5A,$00,$5B,$00,$5C,$5D,$5B,$00             ; 0FD0E6 Z?[?\][?
.byte $5E,$00,$5F,$00,$5F,$00,$5E,$40             ; 0FD0EE ^?_?_?^@
.byte $5D,$5C,$5A,$40,$59,$40,$58,$40             ; 0FD0F6 ]\Z@Y@X@
.byte $57,$60,$00,$61,$00,$62,$00,$63             ; 0FD0FE W`?a?b?c
.byte $00,$64,$00,$65,$00,$66,$00,$67             ; 0FD106 ?d?e?f?g
.byte $00,$68,$04,$69,$00,$6A,$00,$6B             ; 0FD10E ?h?i?j?k
.byte $00,$6C,$6D,$00,$6D,$40,$6B,$40             ; 0FD116 ?lm?m@k@
.byte $40,$6A,$40,$69,$40,$68,$44,$67             ; 0FD11E @j@i@hDg
.byte $40,$66,$40,$65,$40,$64,$40,$63             ; 0FD126 @f@e@d@c
.byte $40,$62,$40,$61,$40,$60,$6E,$00             ; 0FD12E @b@a@`n?
.byte $6F,$00,$70,$00,$71,$00,$72,$00             ; 0FD136 o?p?q?r?
.byte $73,$00,$74,$00,$75,$04,$76,$04             ; 0FD13E s?t?u?v?
.byte $77,$00,$78,$00,$79,$00,$7A,$00             ; 0FD146 w?x?y?z?
.byte $7B,$00,$7C,$00,$7C,$40,$7B,$40             ; 0FD14E {?|?|@{@
.byte $7A,$40,$79,$40,$78,$40,$77,$40             ; 0FD156 z@y@x@w@
.byte $76,$44,$75,$44,$74,$40,$73,$40             ; 0FD15E vDuDt@s@
.byte $72,$40,$7D,$00,$7E,$00,$6F,$40             ; 0FD166 r@}?~?o@
.byte $6E,$7F,$00,$80,$00,$81,$04,$82             ; 0FD16E n???????
.byte $04,$83,$00,$84,$00,$85,$00,$86             ; 0FD176 ????????
.byte $00,$87,$00,$88,$04,$89,$04,$8A             ; 0FD17E ????????
.byte $8A,$40,$89,$44,$88,$44,$87,$40             ; 0FD186 ?@?D?D?@
.byte $86,$40,$85,$40,$84,$40,$83,$40             ; 0FD18E ?@?@?@?@
.byte $8B,$00,$8C,$00,$8D,$00,$7F,$8E             ; 0FD196 ????????
.byte $00,$8F,$04,$90,$04,$91,$04,$92             ; 0FD19E ????????
.byte $00,$93,$00,$94,$00,$95,$00,$96             ; 0FD1A6 ????????
.byte $00,$97,$04,$98,$04,$99,$04,$99             ; 0FD1AE ????????
.byte $44,$98,$44,$97,$44,$96,$40,$95             ; 0FD1B6 D?D?D?@?
.byte $40,$94,$40,$93,$40,$92,$40,$9A             ; 0FD1BE @?@?@?@?
.byte $00,$9B,$00,$8F,$44,$8E,$9C,$00             ; 0FD1C6 ????D???
.byte $9D,$04,$9E,$00,$9F,$00,$9E,$40             ; 0FD1CE ???????@
.byte $A0,$00,$A1,$00,$A2,$00,$A3,$00             ; 0FD1D6 ????????
.byte $A4,$00,$A5,$00,$A6,$00,$A7,$00             ; 0FD1DE ????????
.byte $A8,$00,$A9,$00,$A9,$40,$A8,$40             ; 0FD1E6 ?????@?@
.byte $A7,$40,$A6,$40,$A5,$40,$A4,$40             ; 0FD1EE ?@?@?@?@
.byte $A3,$40,$A2,$40,$A1,$40,$A0,$40             ; 0FD1F6 ?@?@?@?@
.byte $9D,$44,$9C,$AA,$00,$AB,$00,$AC             ; 0FD1FE ?D??????
.byte $00,$AD,$AE,$00,$AF,$00,$B0,$00             ; 0FD206 ????????
.byte $B1,$00,$B2,$00,$B3,$00,$B4,$00             ; 0FD20E ????????
.byte $B5,$00,$B5,$B4,$40,$B3,$40,$B2             ; 0FD216 ????@?@?
.byte $40,$B1,$40,$B0,$40,$AF,$40,$AE             ; 0FD21E @?@?@?@?
.byte $40,$AB,$40,$AD,$40,$AC,$00,$AB             ; 0FD226 @?@?@???
.byte $40,$AA,$B6,$00,$B7,$B7,$40,$B6             ; 0FD22E @?????@?
.byte $B8,$00,$B9,$00,$BA,$00,$BB,$00             ; 0FD236 ????????
.byte $BC,$00,$BD,$00,$BE,$00,$BF,$00             ; 0FD23E ????????
.byte $C0,$00,$C1,$00,$C2,$00,$C3,$00             ; 0FD246 ????????
.byte $C4,$00,$C5,$00,$C6,$00,$C6,$40             ; 0FD24E ???????@
.byte $C5,$40,$C4,$40,$C3,$40,$C2,$40             ; 0FD256 ?@?@?@?@
.byte $C1,$40,$C0,$40,$BF,$40,$BE,$40             ; 0FD25E ?@?@?@?@
.byte $BD,$40,$BC,$40,$BB,$40,$BA,$40             ; 0FD266 ?@?@?@?@
.byte $B9,$40,$B8,$C7,$00,$C8,$00,$C9             ; 0FD26E ?@??????
.byte $00,$CA,$00,$CB,$00,$CC,$00,$CD             ; 0FD276 ????????
.byte $00,$CE,$CF,$00,$D0,$D0,$40,$CF             ; 0FD27E ??????@?
.byte $40,$CC,$40,$CB,$40,$CA,$40,$CE             ; 0FD286 @?@?@?@?
.byte $40,$CD,$C9,$40,$C8,$40,$C7,$D1             ; 0FD28E @??@?@??
.byte $00,$D2,$00,$D3,$00,$D4,$00,$D5             ; 0FD296 ????????
.byte $00,$D6,$00,$D7,$00,$D8,$00,$D9             ; 0FD29E ????????
.byte $00,$DA,$00,$DB,$00,$DC,$00,$DD             ; 0FD2A6 ????????
.byte $DD,$40,$DC,$40,$DB,$40,$DA,$40             ; 0FD2AE ?@?@?@?@
.byte $D9,$40,$D8,$40,$D7,$40,$D6,$40             ; 0FD2B6 ?@?@?@?@
.byte $D5,$40,$D4,$40,$D3,$40,$D2,$40             ; 0FD2BE ?@?@?@?@
.byte $D1,$DE,$00,$DF,$00,$E0,$00,$E1             ; 0FD2C6 ????????
.byte $00,$E1,$E2,$00,$E3,$00,$E4,$00             ; 0FD2CE ????????
.byte $E5,$00,$E6,$E6,$40,$E5,$40,$E7             ; 0FD2D6 ????@?@?
.byte $E0,$40,$DF,$40,$DE,$E8,$00,$E9             ; 0FD2DE ?@?@????
.byte $00,$EA,$00,$00,$00,$EB,$04,$EC             ; 0FD2E6 ????????
.byte $04,$ED,$04,$EE,$00,$EF,$00,$F0             ; 0FD2EE ????????
.byte $00,$F1,$00,$F1,$40,$F0,$40,$F2             ; 0FD2F6 ????@?@?
.byte $00,$F3,$F4,$04,$EA,$40,$E9,$40             ; 0FD2FE ?????@?@
.byte $E8,$F5,$00,$F6,$00,$F7,$F8,$04             ; 0FD306 ????????
.byte $F9,$04,$FA,$04,$FB,$04,$FC,$04             ; 0FD30E ????????
.byte $FD,$FE,$00,$FF,$00,$00,$01,$00             ; 0FD316 ????????
.byte $41,$FF,$40,$01,$01,$EC,$44,$EB             ; 0FD31E A?@???D?
.byte $44,$02,$05,$03,$05,$00,$00,$F7             ; 0FD326 D???????
.byte $40,$F6,$40,$F5,$40,$04,$01,$05             ; 0FD32E @?@?@???
.byte $01,$06,$01,$00,$00,$07,$05,$08             ; 0FD336 ????????
.byte $00,$00,$09,$05,$0A,$05,$0B,$05             ; 0FD33E ????????
.byte $0C,$0D,$01,$0E,$01,$0E,$41,$0D             ; 0FD346 ??????A?
.byte $41,$FD,$44,$FC,$44,$FB,$44,$0F             ; 0FD34E A?D?D?D?
.byte $F9,$44,$F8,$10,$05,$11,$06,$41             ; 0FD356 ?D?????A
.byte $05,$41,$04,$41,$12,$01,$13,$01             ; 0FD35E ?A?A????
.byte $14,$15,$05,$16,$11,$45,$17,$05             ; 0FD366 ?????E??
.byte $18,$05,$19,$0C,$45,$0B,$45,$1A             ; 0FD36E ????E?E?
.byte $05,$1B,$08,$45,$07,$45,$1C,$14             ; 0FD376 ???E?E??
.byte $41,$13,$41,$1D,$1E,$0D,$1F,$0D             ; 0FD37E A?A?????
.byte $20,$0D,$21,$0D,$45,$22,$05,$23             ; 0FD386  ?!?E"?#
.byte $05,$24,$19,$45,$18,$45,$25,$05             ; 0FD38E ?$?E?E%?
.byte $26,$16,$45,$15,$45,$21,$4D,$20             ; 0FD396 &?E?E!M 
.byte $4D,$1F,$4D,$1E,$4D,$00,$00,$27             ; 0FD39E M?M?M??'
.byte $05,$28,$29,$0D,$2A,$0D,$2B,$0D             ; 0FD3A6 ?()?*?+?
.byte $2C,$0D,$2D,$0D,$2E,$0D,$2F,$00             ; 0FD3AE ,?-?.?/?
.byte $24,$45,$23,$45,$22,$45,$30,$2F             ; 0FD3B6 $E#E"E0/
.byte $4D,$2E,$4D,$2D,$4D,$2C,$4D,$2B             ; 0FD3BE M.M-M,M+
.byte $4D,$2A,$4D,$29,$31,$05,$32,$0D             ; 0FD3C6 M*M)1?2?
.byte $33,$0D,$34,$0D,$35,$0D,$36,$35             ; 0FD3CE 3?4?5?65
.byte $0D,$37,$0D,$38,$0D,$39,$0D,$3A             ; 0FD3D6 ?7?8?9?:
.byte $0D,$3B,$0D,$3C,$0D,$3D,$3D,$4D             ; 0FD3DE ?;?<?==M
.byte $3C,$4D,$3B,$4D,$3A,$4D,$39,$4D             ; 0FD3E6 <M;M:M9M
.byte $38,$4D,$37,$4D,$35,$4D,$35,$4D             ; 0FD3EE 8M7M5M5M
.byte $36,$34,$4D,$33,$4D,$32,$4D,$3E             ; 0FD3F6 64M3M2M>
.byte $0D,$3F,$40,$0D,$41,$0D,$42,$36             ; 0FD3FE ??@?A?B6
.byte $0D,$43,$0D,$44,$0D,$45,$0D,$46             ; 0FD406 ?C?D?E?F
.byte $0D,$47,$0D,$48,$0D,$49,$0D,$49             ; 0FD40E ?G?H?I?I
.byte $4D,$48,$4D,$47,$4D,$46,$4D,$45             ; 0FD416 MHMGMFME
.byte $4D,$44,$4D,$43,$36,$4D,$42,$4D             ; 0FD41E MDMC6MBM
.byte $41,$4D,$40,$3F,$4D,$3E,$4A,$0D             ; 0FD426 AM@?M>J?
.byte $4B,$0D,$4C,$4A,$4D,$40,$4C,$4D             ; 0FD42E K?LJM@LM
.byte $4B,$4D,$2E,$5E,$0D,$09,$A1,$4D             ; 0FD436 KM.^???M
.byte $85,$23,$D0,$80,$79,$64,$87,$6C             ; 0FD43E ?#??yd?l
.byte $81,$E6,$24,$2E,$FE,$11,$38,$A0             ; 0FD446 ??$.??8?
.byte $25,$DF,$61,$43,$CA,$02,$07,$7F             ; 0FD44E %?aC????
.byte $84,$4E,$14,$04,$B9,$F5,$84,$4E             ; 0FD456 ?N?????N
.byte $94,$04,$BC,$F5,$85,$F1,$27,$8D             ; 0FD45E ??????'?
.byte $91,$7D,$59,$EB,$E5,$EF,$AC,$2F             ; 0FD466 ?}Y????/
.byte $C9,$BE,$6C,$BF,$5C,$FA,$E9,$3F             ; 0FD46E ??l?\???
.byte $48,$BF,$4D,$FB,$E5,$F7,$AC,$83             ; 0FD476 H?M?????
.byte $C2,$F2,$70,$D4,$29,$BF,$AC,$A2             ; 0FD47E ??p?)???
.byte $F1,$EB,$0A,$EE,$8B,$D3,$47,$4F             ; 0FD486 ??????GO
.byte $10,$AF,$3E,$B2,$07,$4D,$09,$0A             ; 0FD48E ??>??M??
.byte $F5,$EB,$20,$9E,$0C,$13,$DF,$AC             ; 0FD496 ?? ?????
.byte $BE,$87,$00,$FA,$C9,$EB,$6C,$2B             ; 0FD49E ??????l+
.byte $E7,$AC,$F4,$C8,$BF,$0C,$27,$C3             ; 0FD4A6 ??????'?
.byte $0A,$7D,$91,$3E,$FA,$CA,$2F,$DE             ; 0FD4AE ?}?>??/?
.byte $B2,$BC,$07,$19,$CE,$FA,$C8,$F0             ; 0FD4B6 ????????
.byte $9C,$61,$DF,$EB,$20,$F0,$6D,$64             ; 0FD4BE ?a?? ?md
.byte $1E,$1E,$B0,$3C,$87,$39,$12,$C0             ; 0FD4C6 ???<?9??
.byte $F1,$7D,$87,$90,$E2,$F2,$C0,$87             ; 0FD4CE ?}??????
.byte $8F,$AC,$07,$31,$F9,$90,$C2,$3C             ; 0FD4D6 ???1???<
.byte $C7,$07,$9D,$C4,$BC,$BD,$87,$9E             ; 0FD4DE ????????
.byte $70,$73,$C8,$97,$A1,$70,$07,$3B             ; 0FD4E6 ps???p?;
.byte $00,$85,$7A,$6F,$03,$D4,$B6,$57             ; 0FD4EE ??zo???W
.byte $AA,$F3,$D2,$99,$EB,$5C,$2F,$51             ; 0FD4F6 ?????\/Q
.byte $67,$AA,$EC,$BD,$8B,$7A,$58,$92             ; 0FD4FE g????zX?
.byte $F6,$5E,$0E,$D0,$17,$6A,$E1,$EC             ; 0FD506 ?^???j??
.byte $B8,$C0,$76,$D2,$4E,$CB,$8B,$2F             ; 0FD50E ??v?N??/
.byte $75,$E0,$1E,$EB,$B2,$3D,$CD,$E7             ; 0FD516 u????=??
.byte $3A,$30,$1D,$FF,$91,$EF,$CC,$2F             ; 0FD51E :0?????/
.byte $91,$65,$7C,$22,$B0,$2F,$9C,$E0             ; 0FD526 ?e|"?/??
.byte $7C,$8F,$0F,$91,$D9,$47,$CE,$AC             ; 0FD52E |????G??
.byte $BE,$B1,$9F,$5B,$C7,$B0,$09,$F6             ; 0FD536 ???[????
.byte $1B,$3E,$CF,$3D,$9E,$FB,$31,$3D             ; 0FD53E ?>?=??1=
.byte $80,$9E,$DC,$48,$3D,$A8,$9E,$12             ; 0FD546 ???H=???
.byte $00,$F8,$00,$07,$C0,$00,$4F,$80             ; 0FD54E ??????O?
.byte $00,$A7,$C8,$11,$52,$00,$08,$84             ; 0FD556 ????R???
.byte $00,$00,$20,$00,$20,$4D,$25,$4E             ; 0FD55E ?? ? M%N
.byte $25,$4F,$25,$50,$25,$51,$25,$52             ; 0FD566 %O%P%Q%R
.byte $53,$25,$54,$25,$55,$25,$56,$25             ; 0FD56E S%T%U%V%
.byte $57,$25,$58,$25,$59,$25,$5A,$5B             ; 0FD576 W%X%Y%Z[
.byte $25,$5C,$25,$5D,$25,$5E,$25,$5F             ; 0FD57E %\%]%^%_
.byte $25,$60,$25,$61,$00,$20,$62,$25             ; 0FD586 %`%a? b%
.byte $63,$64,$25,$65,$25,$66,$25,$67             ; 0FD58E cd%e%f%g
.byte $68,$25,$69,$6A,$25,$6B,$25,$6C             ; 0FD596 h%ij%k%l
.byte $25,$6D,$6E,$25,$6F,$70,$25,$71             ; 0FD59E %mn%op%q
.byte $25,$72,$4E,$65,$4D,$65,$54,$65             ; 0FD5A6 %rNeMeTe
.byte $53,$55,$25,$5C,$65,$5B,$55,$25             ; 0FD5AE SU%\e[U%
.byte $73,$5D,$25,$63,$65,$62,$65,$74             ; 0FD5B6 s]%cebet
.byte $75,$25,$76,$69,$65,$68,$65,$6F             ; 0FD5BE u%vieheo
.byte $65,$6E,$65,$61,$65,$60,$65,$5F             ; 0FD5C6 eneae`e_
.byte $67,$65,$66,$65,$65,$65,$64,$6D             ; 0FD5CE gefeeedm
.byte $65,$6C,$65,$6B,$65,$6A,$72,$65             ; 0FD5D6 elekejre
.byte $71,$65,$70,$06,$0C,$13,$02,$98             ; 0FD5DE qep?????
.byte $0A,$98,$05,$53,$48,$45,$20,$ED             ; 0FD5E6 ???SHE ?
.byte $09,$7B,$B7,$8C,$11,$25,$76,$38             ; 0FD5EE ?{???%v8
.byte $AB,$23,$C1,$C5,$58,$7A,$2B,$2F             ; 0FD5F6 ?#??Xz+/
.byte $45,$15,$67,$C3,$B2,$F8,$71,$56             ; 0FD5FE E?g???qV
.byte $7E,$3B,$0E,$A2,$A0,$3A,$70,$63             ; 0FD606 ~;???:pc
.byte $E2,$89,$AF,$09,$C8,$08,$A6,$DC             ; 0FD60E ????????
.byte $27,$53,$00,$41,$BA,$C2,$07,$73             ; 0FD616 'S?A???s
.byte $00,$4F,$6A,$80,$3C,$70,$99,$F8             ; 0FD61E ?Oj?<p??
.byte $66,$01,$E8,$09,$0F,$8A,$AB,$97             ; 0FD626 f???????
.byte $09,$CD,$C8,$4E,$9D,$BA,$00,$7C             ; 0FD62E ???N???|
.byte $02,$4B,$ED,$28,$E7,$C1,$D5,$40             ; 0FD636 ?K?(???@
.byte $13,$F5,$2B,$A8,$00,$41,$A8,$0A             ; 0FD63E ??+??A??
.byte $71,$C0,$07,$7C,$26,$30,$93,$30             ; 0FD646 q??|&0?0
.byte $00,$41,$98,$05,$36,$F0,$1B,$42             ; 0FD64E ?A??6??B
.byte $53,$86,$86,$40,$93,$38,$00,$6D             ; 0FD656 S??@?8?m
.byte $48,$CE,$02,$9B,$B8,$37,$00,$01             ; 0FD65E H????7??
.byte $C7,$43,$8B,$C9,$A0,$00,$37,$24             ; 0FD666 ?C????7$
.byte $68,$01,$4D,$FC,$24,$3B,$15,$51             ; 0FD66E h?M?$;?Q
.byte $DE,$91,$B2,$81,$09,$79,$AA,$BB             ; 0FD676 ?????y??
.byte $66,$00,$E8,$51,$C1,$23,$4D,$02             ; 0FD67E f??Q?#M?
.byte $12,$F4,$55,$77,$4C,$01,$D4,$A3             ; 0FD686 ??UwL???
.byte $6A,$40,$9A,$B8,$48,$7A,$AA,$BC             ; 0FD68E j@??Hz??
.byte $E6,$38,$54,$01,$C9,$23,$5D,$00             ; 0FD696 ?8T??#]?
.byte $87,$49,$8E,$35,$00,$73,$49,$03             ; 0FD69E ?I?5?sI?
.byte $55,$00,$87,$44,$90,$3B,$2C,$09             ; 0FD6A6 U??D?;,?
.byte $B7,$C3,$18,$88,$75,$48,$53,$85             ; 0FD6AE ????uHS?
.byte $42,$1B,$BC,$32,$08,$87,$64,$85             ; 0FD6B6 B??2??d?
.byte $38,$D4,$A1,$CC,$80,$13,$52,$40             ; 0FD6BE 8?????R@
.byte $87,$84,$84,$0F,$7E,$08,$75,$49             ; 0FD6C6 ????~?uI
.byte $13,$07,$0A,$A3,$FD,$90,$18,$E0             ; 0FD6CE ????????
.byte $2E,$9E,$14,$00,$00,$00,$7F,$40             ; 0FD6D6 .??????@
.byte $7F,$40,$60,$5F,$40,$7F,$4F,$7F             ; 0FD6DE ?@`_@?O?
.byte $4F,$7F,$BF,$FF,$BF,$FF,$FF,$00             ; 0FD6E6 O???????
.byte $FF,$00,$FF,$FF,$FF,$3E,$4E,$7F             ; 0FD6EE ?????>N?
.byte $4E,$7F,$27,$00,$7F,$7F,$C0,$40             ; 0FD6F6 N?'????@
.byte $40,$40,$C0,$40,$C1,$40,$C3,$40             ; 0FD6FE @@?@?@?@
.byte $80,$FF,$80,$C0,$80,$CF,$80,$CF             ; 0FD706 ????????
.byte $FF,$00,$C8,$00,$FF,$FE,$02,$01             ; 0FD70E ????????
.byte $05,$03,$0B,$07,$F7,$0F,$EE,$1F             ; 0FD716 ????????
.byte $01,$FF,$03,$03,$07,$FF,$0F,$FF             ; 0FD71E ????????
.byte $1F,$FF,$3F,$FF,$BD,$7E,$BB,$7C             ; 0FD726 ?????~?|
.byte $77,$FB,$EF,$F7,$DF,$EF,$BF,$DD             ; 0FD72E w???????
.byte $65,$A3,$D9,$47,$FC,$FF,$F8,$FF             ; 0FD736 e??G????
.byte $F0,$FF,$E2,$FF,$DE,$FF,$BE,$FD             ; 0FD73E ????????
.byte $80,$80,$40,$3F,$80,$E0,$FF,$00             ; 0FD746 ??@?????
.byte $D5,$FF,$00,$03,$00,$01,$17,$07             ; 0FD74E ????????
.byte $27,$C7,$17,$07,$04,$FF,$07,$01             ; 0FD756 '???????
.byte $1F,$01,$80,$80,$21,$DE,$FF,$FF             ; 0FD75E ????!???
.byte $7F,$06,$FF,$05,$FF,$01,$01,$FE             ; 0FD766 ????????
.byte $FF,$FA,$FE,$FD,$7F,$C3,$40,$C7             ; 0FD76E ??????@?
.byte $40,$C7,$40,$C2,$41,$C5,$43,$CB             ; 0FD776 @?@?A?C?
.byte $47,$57,$4F,$6F,$5F,$81,$DF,$83             ; 0FD77E GWOo_???
.byte $DF,$87,$DF,$8F,$DF,$9F,$DD,$3E             ; 0FD786 ???????>
.byte $BD,$7F,$7A,$FC,$F7,$FA,$EC,$F5             ; 0FD78E ??z?????
.byte $DC,$EB,$B8,$D7,$71,$AE,$7F,$FF             ; 0FD796 ????q???
.byte $FD,$FF,$FB,$FF,$F7,$FF,$EF,$FF             ; 0FD79E ????????
.byte $DF,$FF,$F3,$CF,$A1,$99,$87,$70             ; 0FD7A6 ???????p
.byte $09,$E6,$11,$CE,$26,$9F,$0F,$3F             ; 0FD7AE ????&???
.byte $1F,$7F,$3C,$FF,$7E,$80,$00,$80             ; 0FD7B6 ??<?~???
.byte $80,$40,$00,$40,$00,$40,$80,$C0             ; 0FD7BE ?@?@?@??
.byte $00,$C0,$00,$E0,$00,$E0,$10,$00             ; 0FD7C6 ????????
.byte $08,$01,$01,$01,$03,$00,$00,$03             ; 0FD7CE ????????
.byte $02,$03,$4E,$49,$00,$01,$02,$01             ; 0FD7D6 ??NI????
.byte $80,$00,$83,$01,$AF,$8A,$FF,$A4             ; 0FD7DE ????????
.byte $B7,$28,$3F,$A0,$83,$00,$83,$08             ; 0FD7E6 ?(??????
.byte $07,$D8,$27,$C8,$0E,$04,$EE,$E2             ; 0FD7EE ??'?????
.byte $FE,$30,$F6,$09,$64,$88,$30,$18             ; 0FD7F6 ?0??d?0?
.byte $06,$00,$CE,$00,$EE,$00,$E6,$00             ; 0FD7FE ????????
.byte $07,$00,$17,$08,$40,$00,$F0,$E0             ; 0FD806 ????@???
.byte $E0,$10,$70,$00,$70,$00,$28,$40             ; 0FD80E ??p?p?(@
.byte $48,$20,$00,$60,$00,$60,$70,$00             ; 0FD816 H ?`?`p?
.byte $30,$00,$30,$00,$F8,$00,$07,$15             ; 0FD81E 0?0?????
.byte $07,$15,$01,$11,$01,$11,$00,$11             ; 0FD826 ????????
.byte $12,$03,$0B,$02,$03,$0A,$03,$1F             ; 0FD82E ????????
.byte $03,$1F,$03,$1F,$01,$1F,$01,$1F             ; 0FD836 ????????
.byte $01,$0F,$FB,$F9,$FD,$F9,$FD,$F9             ; 0FD83E ????????
.byte $FD,$FB,$FC,$FB,$FC,$FB,$FC,$FC             ; 0FD846 ????????
.byte $FE,$FE,$FE,$7F,$00,$A0,$C0,$9B             ; 0FD84E ????????
.byte $E6,$BD,$B3,$FE,$99,$FF,$8C,$FF             ; 0FD856 ????????
.byte $86,$FF,$83,$FF,$FF,$1F,$9F,$1D             ; 0FD85E ????????
.byte $9F,$4E,$8F,$67,$C7,$73,$E3,$79             ; 0FD866 ?N?g?s?y
.byte $F1,$7C,$F8,$80,$7F,$C0,$BF,$60             ; 0FD86E ?|?????`
.byte $DF,$30,$7F,$DF,$FF,$01,$81,$81             ; 0FD876 ?0??????
.byte $81,$01,$C1,$01,$E1,$01,$F1,$01             ; 0FD87E ????????
.byte $FF,$00,$81,$80,$FF,$C0,$FF,$E0             ; 0FD886 ????????
.byte $5E,$3F,$3C,$7E,$7B,$FD,$F7,$FA             ; 0FD88E ^?<~{???
.byte $EF,$F6,$DC,$ED,$BC,$CB,$78,$9F             ; 0FD896 ??????x?
.byte $FE,$F9,$FF,$F3,$E7,$FF,$C2,$5C             ; 0FD89E ???????\
.byte $87,$B8,$82,$F9,$06,$F1,$0C,$E3             ; 0FD8A6 ????????
.byte $19,$C7,$19,$87,$33,$0F,$BF,$BF             ; 0FD8AE ????3???
.byte $7F,$3E,$FF,$7D,$FE,$FE,$F1,$FF             ; 0FD8B6 ?>?}????
.byte $E3,$FE,$C7,$FF,$C7,$FF,$80,$E0             ; 0FD8BE ????????
.byte $80,$A0,$40,$60,$80,$20,$D0,$20             ; 0FD8C6 ??@`? ? 
.byte $80,$70,$80,$D0,$80,$D0,$F0,$00             ; 0FD8CE ?p??????
.byte $F0,$C0,$F0,$C0,$F0,$80,$B0,$08             ; 0FD8D6 ????????
.byte $0C,$0A,$04,$00,$02,$07,$05,$3B             ; 0FD8DE ???????;
.byte $3C,$7F,$6D,$FD,$C2,$FA,$05,$08             ; 0FD8E6 <?m?????
.byte $04,$07,$05,$02,$18,$00,$3D,$00             ; 0FD8EE ??????=?
.byte $7D,$43,$4E,$6F,$49,$5F,$64,$CF             ; 0FD8F6 }CNoI_d?
.byte $12,$EF,$80,$EE,$41,$FF,$20,$FE             ; 0FD8FE ????A? ?
.byte $20,$02,$2D,$09,$30,$44,$30,$06             ; 0FD906  ?-?0D0?
.byte $30,$C6,$10,$C6,$10,$C7,$00,$C7             ; 0FD90E 0???????
.byte $00,$ED,$14,$FC,$64,$7C,$98,$7C             ; 0FD916 ????d|?|
.byte $82,$7E,$81,$E1,$02,$E3,$42,$48             ; 0FD91E ?~????BH
.byte $81,$03,$80,$73,$00,$73,$00,$79             ; 0FD926 ???s?s?y
.byte $00,$7C,$00,$7C,$00,$3C,$00,$36             ; 0FD92E ?|?|?<?6
.byte $00,$E8,$14,$52,$46,$02,$0A,$07             ; 0FD936 ???RF???
.byte $05,$46,$C7,$DF,$BE,$71,$0E,$F1             ; 0FD93E ?F???q??
.byte $6E,$03,$30,$A1,$00,$F1,$38,$00             ; 0FD946 n?0???8?
.byte $E0,$20,$00,$04,$00,$40,$64,$84             ; 0FD94E ? ???@d?
.byte $84,$9E,$9C,$C2,$9C,$40,$DE,$0C             ; 0FD956 ?????@??
.byte $C0,$20,$C0,$F8,$00,$98,$00,$02             ; 0FD95E ? ??????
.byte $0B,$01,$08,$01,$08,$02,$0B,$02             ; 0FD966 ????????
.byte $0B,$07,$0A,$07,$08,$07,$08,$01             ; 0FD96E ????????
.byte $0F,$00,$0D,$00,$0D,$01,$0F,$01             ; 0FD976 ????????
.byte $0F,$0C,$00,$0C,$FF,$E0,$C0,$C0             ; 0FD97E ????????
.byte $7F,$80,$FC,$3C,$1C,$FC,$1E,$FE             ; 0FD986 ???<????
.byte $F8,$06,$F8,$1E,$F8,$06,$00,$FE             ; 0FD98E ????????
.byte $00,$FE,$FE,$3E,$FE,$02,$06,$FE             ; 0FD996 ???>????
.byte $1E,$FE,$FF,$81,$AF,$81,$D5,$80             ; 0FD99E ????????
.byte $AA,$80,$80,$80,$80,$80,$D5,$D5             ; 0FD9A6 ????????
.byte $EA,$EA,$7E,$FC,$7E,$FE,$2A,$FF             ; 0FD9AE ??~?~?*?
.byte $15,$FF,$EF,$9F,$F0,$CF,$7F,$55             ; 0FD9B6 ???????U
.byte $55,$AA,$AA,$70,$7F,$3F,$3F,$AA             ; 0FD9BE U??p????
.byte $FF,$55,$FF,$FF,$81,$7F,$C1,$BF             ; 0FD9C6 ?U??????
.byte $BF,$DF,$DF,$3B,$1B,$1B,$0B,$5D             ; 0FD9CE ???;???]
.byte $55,$AF,$AB,$7E,$40,$21,$20,$11             ; 0FD9D6 U??~@! ?
.byte $E4,$FD,$F4,$FD,$AA,$FF,$54,$FF             ; 0FD9DE ??????T?
.byte $F9,$37,$50,$4C,$E5,$5C,$6B,$58             ; 0FD9E6 ?7PL?\kX
.byte $E7,$40,$EF,$40,$FF,$50,$FF,$50             ; 0FD9EE ?@?@?P?P
.byte $CE,$BB,$FF,$B7,$AF,$FF,$AF,$FF             ; 0FD9F6 ????????
.byte $67,$1F,$E7,$1F,$E7,$1E,$C7,$3C             ; 0FD9FE g??????<
.byte $C7,$38,$CF,$31,$85,$63,$8C,$43             ; 0FDA06 ?8?1?c?C
.byte $C3,$FF,$FD,$8F,$FB,$1F,$F7,$3F             ; 0FDA0E ????????
.byte $4F,$FF,$FF,$8E,$FE,$1C,$FC,$38             ; 0FDA16 O??????8
.byte $F8,$70,$C0,$C0,$C0,$F0,$E8,$F0             ; 0FDA1E ?p??????
.byte $E0,$C8,$E0,$88,$D0,$68,$F0,$C8             ; 0FDA26 ?????h??
.byte $10,$38,$20,$38,$70,$38,$F0,$78             ; 0FDA2E ?8 8p8?x
.byte $F0,$FC,$FE,$01,$E1,$00,$E3,$02             ; 0FDA36 ????????
.byte $F9,$02,$FB,$80,$58,$40,$C0,$A0             ; 0FDA3E ????X@??
.byte $F6,$EE,$E0,$F0,$06,$7C,$00,$3F             ; 0FDA46 ?????|??
.byte $00,$1F,$00,$C1,$00,$FC,$10,$B0             ; 0FDA4E ????????
.byte $01,$81,$DB,$5B,$BF,$7F,$7D,$3E             ; 0FDA56 ???[??}>
.byte $59,$36,$E7,$7F,$00,$7E,$00,$24             ; 0FDA5E Y6???~?$
.byte $80,$00,$6D,$2D,$24,$48,$32,$12             ; 0FDA66 ??m-$H2?
.byte $DF,$EF,$DA,$ED,$CA,$F5,$1F,$E2             ; 0FDA6E ????????
.byte $E5,$1A,$9A,$00,$93,$08,$CD,$E1             ; 0FDA76 ????????
.byte $7F,$50,$AF,$C0,$BF,$E8,$D7,$A8             ; 0FDA7E ?P??????
.byte $D7,$45,$9A,$85,$1A,$09,$13,$01             ; 0FDA86 ?E??????
.byte $01,$1F,$1F,$1F,$10,$1F,$1F,$17             ; 0FDA8E ????????
.byte $1F,$17,$1F,$DF,$82,$7C,$CE,$70             ; 0FDA96 ?????|?p
.byte $04,$FA,$24,$DE,$04,$EE,$05,$EF             ; 0FDA9E ??$?????
.byte $45,$AE,$56,$ED,$CE,$FE,$0E,$FE             ; 0FDAA6 E?V?????
.byte $6E,$FE,$7E,$0F,$03,$04,$03,$07             ; 0FDAAE n?~?????
.byte $03,$07,$03,$07,$07,$07,$02,$FF             ; 0FDAB6 ????????
.byte $04,$FE,$08,$FC,$82,$7E,$C5,$3A             ; 0FDABE ?????~?:
.byte $C2,$35,$50,$23,$7A,$01,$00,$FD             ; 0FDAC6 ?5P#z???
.byte $01,$FA,$03,$F4,$F1,$FC,$F1,$F8             ; 0FDACE ????????
.byte $F8,$FE,$40,$FE,$20,$7E,$C0,$FC             ; 0FDAD6 ??@? ~??
.byte $40,$BC,$80,$5C,$00,$9C,$BC,$00             ; 0FDADE @??\????
.byte $BE,$80,$5E,$1F,$3F,$1F,$3F,$3F             ; 0FDAE6 ??^?????
.byte $7F,$CA,$C0,$B5,$A0,$FF,$40,$A0             ; 0FDAEE ??????@?
.byte $20,$AA,$00,$5F,$00,$00,$FD,$FF             ; 0FDAF6  ??_????
.byte $00,$02,$FF,$50,$F7,$58,$F6,$58             ; 0FDAFE ???P?X?X
.byte $7E,$58,$F5,$58,$F0,$58,$F9,$58             ; 0FDB06 ~X?X?X?X
.byte $F9,$58,$AE,$FF,$AE,$FF,$AC,$FF             ; 0FDB0E ?X??????
.byte $A8,$FF,$A9,$FF,$A9,$FF,$99,$06             ; 0FDB16 ????????
.byte $B3,$0D,$67,$1B,$CF,$37,$DF,$2F             ; 0FDB1E ??g??7?/
.byte $FF,$1F,$DF,$3F,$9F,$7F,$87,$FC             ; 0FDB26 ????????
.byte $FD,$FD,$FB,$F8,$F7,$F0,$FF,$E1             ; 0FDB2E ????????
.byte $FE,$C3,$FC,$83,$FC,$06,$F8,$03             ; 0FDB36 ????????
.byte $01,$07,$07,$0F,$0F,$0F,$0F,$1F             ; 0FDB3E ????????
.byte $FE,$FF,$34,$C8,$78,$84,$E0,$04             ; 0FDB46 ??4?x???
.byte $C2,$04,$82,$04,$14,$32,$20,$32             ; 0FDB4E ?????2 2
.byte $00,$0A,$F0,$FC,$F0,$FC,$E0,$FE             ; 0FDB56 ????????
.byte $C0,$FE,$80,$FE,$18,$EE,$20,$DE             ; 0FDB5E ?????? ?
.byte $0C,$F6,$07,$03,$01,$03,$03,$01             ; 0FDB66 ????????
.byte $15,$0F,$30,$0F,$18,$07,$0F,$E9             ; 0FDB6E ??0?????
.byte $D6,$AE,$D0,$A9,$D8,$3C,$CA,$55             ; 0FDB76 ?????<?U
.byte $83,$99,$0B,$31,$10,$32,$26,$01             ; 0FDB7E ???1?2&?
.byte $0E,$18,$06,$14,$02,$02,$00,$DE             ; 0FDB86 ????????
.byte $25,$60,$0C,$C4,$04,$C0,$20,$60             ; 0FDB8E %`???? `
.byte $04,$00,$00,$84,$04,$E0,$00,$00             ; 0FDB96 ????????
.byte $91,$4B,$F1,$5B,$21,$0B,$01,$0B             ; 0FDB9E ?K?[!???
.byte $05,$0F,$07,$0F,$08,$07,$00,$00             ; 0FDBA6 ????????
.byte $1F,$DF,$5F,$1F,$0B,$0F,$08,$19             ; 0FDBAE ??_?????
.byte $24,$1D,$E4,$FD,$EC,$F7,$7E,$FF             ; 0FDBB6 $?????~?
.byte $E1,$DE,$18,$E8,$FB,$FF,$3B,$FF             ; 0FDBBE ??????;?
.byte $1B,$FF,$81,$F8,$F8,$05,$01,$02             ; 0FDBC6 ????????
.byte $03,$03,$00,$03,$3D,$04,$1A,$40             ; 0FDBCE ????=??@
.byte $7F,$19,$1F,$19,$1F,$0F,$8F,$80             ; 0FDBD6 ????????
.byte $00,$FB,$FF,$7F,$80,$19,$E0,$19             ; 0FDBDE ????????
.byte $E0,$0F,$70,$00,$FF,$3C,$03,$FF             ; 0FDBE6 ??p??<??
.byte $39,$FF,$39,$F9,$00,$F9,$8B,$80             ; 0FDBEE 9?9?????
.byte $9F,$C0,$9F,$E0,$9F,$20,$DF,$FE             ; 0FDBF6 ????? ??
.byte $01,$1C,$03,$AA,$05,$55,$02,$8A             ; 0FDBFE ?????U??
.byte $2A,$95,$00,$DF,$55,$FD,$5A,$FC             ; 0FDC06 *???U?Z?
.byte $5B,$7E,$5B,$FE,$5B,$FF,$5B,$F7             ; 0FDC0E [~[?[?[?
.byte $5B,$F7,$5B,$77,$5B,$AB,$FF,$AA             ; 0FDC16 [?[w[???
.byte $FE,$AA,$FE,$0E,$04,$FB,$0C,$F3             ; 0FDC1E ????????
.byte $1E,$E1,$BF,$BF,$C0,$03,$3F,$3F             ; 0FDC26 ????????
.byte $3F,$3F,$0C,$F0,$08,$F0,$08,$F0             ; 0FDC2E ????????
.byte $13,$E3,$0E,$E6,$82,$6C,$EE,$10             ; 0FDC36 ?????l??
.byte $E6,$08,$F8,$FF,$F3,$FC,$E6,$F9             ; 0FDC3E ????????
.byte $E0,$C2,$C2,$01,$13,$10,$3A,$39             ; 0FDC46 ??????:9
.byte $F0,$F0,$80,$C4,$3F,$EF,$08,$C7             ; 0FDC4E ????????
.byte $00,$0F,$BF,$44,$44,$BB,$02,$C5             ; 0FDC56 ???DD???
.byte $39,$F8,$00,$B0,$4C,$03,$01,$FE             ; 0FDC5E 9???L???
.byte $BF,$7F,$15,$7F,$AF,$FF,$1F,$7F             ; 0FDC66 ????????
.byte $3F,$3F,$3F,$1F,$1F,$00,$FF,$56             ; 0FDC6E ???????V
.byte $45,$FF,$FA,$AA,$FE,$DF,$E0,$DF             ; 0FDC76 E???????
.byte $EF,$F0,$EB,$F0,$F1,$1E,$F7,$10             ; 0FDC7E ????????
.byte $FB,$1C,$EF,$08,$CB,$00,$ED,$03             ; 0FDC86 ????????
.byte $CF,$00,$8C,$01,$F0,$FF,$F0,$F7             ; 0FDC8E ????????
.byte $F1,$F2,$E0,$F3,$C0,$E3,$00,$00             ; 0FDC96 ????????
.byte $B0,$30,$A0,$A0,$D0,$10,$D0,$10             ; 0FDC9E ?0??????
.byte $7F,$00,$3F,$80,$3F,$80,$3F,$C0             ; 0FDCA6 ????????
.byte $0F,$C0,$9F,$40,$0F,$E0,$0F,$E7             ; 0FDCAE ???@????
.byte $1C,$FE,$07,$73,$5B,$F3,$F1,$5B             ; 0FDCB6 ???s[??[
.byte $71,$E8,$F0,$F3,$F8,$F4,$F8,$EC             ; 0FDCBE q???????
.byte $F8,$CE,$F8,$C6,$F8,$C4,$F8,$C4             ; 0FDCC6 ????????
.byte $F8,$3E,$3F,$3E,$3F,$3C,$3E,$3C             ; 0FDCCE ?>?>?<><
.byte $3E,$0E,$01,$0E,$00,$4F,$40,$3B             ; 0FDCD6 >????O@;
.byte $38,$57,$54,$FB,$FA,$C0,$E1,$80             ; 0FDCDE 8WT?????
.byte $C1,$38,$00,$54,$00,$FA,$88,$48             ; 0FDCE6 ?8?T???H
.byte $28,$C8,$6F,$8F,$FA,$0A,$05,$75             ; 0FDCEE (?o????u
.byte $B7,$C7,$5F,$A7,$0B,$B3,$07,$F0             ; 0FDCF6 ??_?????
.byte $07,$05,$F0,$32,$C8,$78,$00,$40             ; 0FDCFE ???2?x?@
.byte $40,$BB,$BB,$53,$53,$7F,$7F,$DA             ; 0FDD06 @??SS???
.byte $DA,$BF,$00,$44,$00,$AC,$25,$04             ; 0FDD0E ???D??%?
.byte $08,$0B,$04,$04,$03,$80,$83,$72             ; 0FDD16 ???????r
.byte $71,$F8,$F8,$70,$70,$FC,$F0,$E0             ; 0FDD1E q??pp???
.byte $1F,$E0,$1F,$E0,$1F,$70,$1F,$80             ; 0FDD26 ?????p??
.byte $1F,$E0,$0E,$F1,$06,$01,$F8,$07             ; 0FDD2E ????????
.byte $F8,$06,$F0,$88,$60,$10,$C0,$21             ; 0FDD36 ????`??!
.byte $86,$20,$FF,$70,$FF,$C8,$10,$10             ; 0FDD3E ? ?p????
.byte $80,$80,$70,$70,$A1,$A1,$E7,$E7             ; 0FDD46 ??pp????
.byte $D3,$D3,$EF,$8F,$00,$5E,$2C,$9F             ; 0FDD4E ?????^,?
.byte $9F,$BF,$60,$E3,$E3,$1C,$BD,$BD             ; 0FDD56 ??`?????
.byte $42,$57,$57,$A8,$00,$F1,$F0,$C5             ; 0FDD5E BWW?????
.byte $F9,$C5,$F9,$85,$15,$E9,$2D,$D1             ; 0FDD66 ??????-?
.byte $3C,$3F,$3C,$3F,$D5,$D4,$BB,$BB             ; 0FDD6E <?<?????
.byte $00,$D4,$00,$55,$39,$D9,$0C,$D3             ; 0FDD76 ???U9???
.byte $0D,$F2,$05,$EA,$27,$F8,$90,$F0             ; 0FDD7E ????'???
.byte $A4,$FB,$57,$7F,$18,$26,$1F,$8F             ; 0FDD86 ??W??&??
.byte $01,$FE,$3F,$C2,$FE,$01,$E7,$FC             ; 0FDD8E ????????
.byte $C2,$3D,$04,$FB,$F2,$F4,$70,$73             ; 0FDD96 ?=????ps
.byte $3A,$79,$91,$30,$98,$1C,$CD,$1E             ; 0FDD9E :y?0????
.byte $66,$8F,$47,$B7,$87,$00,$CF,$00             ; 0FDDA6 f?G?????
.byte $E7,$00,$E3,$00,$F1,$30,$C8,$00             ; 0FDDAE ?????0??
.byte $1F,$60,$0E,$31,$84,$19,$C4,$80             ; 0FDDB6 ?`?1????
.byte $64,$40,$31,$AA,$11,$59,$86,$43             ; 0FDDBE d@1??Y?C
.byte $4F,$87,$19,$79,$24,$E4,$48,$CC             ; 0FDDC6 O??y$?H?
.byte $90,$98,$20,$34,$4F,$B1,$9F,$63             ; 0FDDCE ?? 4O??c
.byte $3F,$C3,$7B,$87,$E7,$1B,$CF,$33             ; 0FDDD6 ??{????3
.byte $9B,$67,$33,$CF,$84,$FF,$12,$E7             ; 0FDDDE ?g3?????
.byte $29,$E7,$40,$F7,$80,$C7,$53,$7E             ; 0FDDE6 )?@???S~
.byte $3F,$3C,$1E,$19,$FC,$FF,$E7,$FE             ; 0FDDEE ?<??????
.byte $E7,$F7,$F9,$F3,$CC,$FF,$6E,$EF             ; 0FDDF6 ??????n?
.byte $CC,$B3,$80,$C0,$DC,$FC,$FA,$FA             ; 0FDDFE ????????
.byte $00,$FF,$9F,$60,$F3,$CC,$DF,$FF             ; 0FDE06 ???`????
.byte $05,$33,$00,$FF,$F9,$06,$FB,$C4             ; 0FDE0E ?3??????
.byte $FF,$0B,$F6,$FB,$F6,$FF,$02,$FD             ; 0FDE16 ????????
.byte $C4,$3B,$02,$05,$02,$05,$FD,$FD             ; 0FDE1E ?;??????
.byte $78,$78,$3F,$3F,$7D,$7D,$A0,$A0             ; 0FDE26 xx??}}??
.byte $40,$40,$02,$C0,$00,$82,$5F,$EF             ; 0FDE2E @@????_?
.byte $EF,$F7,$F7,$EF,$83,$83,$03,$03             ; 0FDE36 ????????
.byte $92,$92,$07,$07,$10,$7C,$00,$FC             ; 0FDE3E ?????|??
.byte $00,$6D,$F6,$F6,$FF,$FF,$EF,$EF             ; 0FDE46 ?m??????
.byte $67,$67,$47,$47,$47,$84,$84,$09             ; 0FDE4E ggGGG???
.byte $98,$00,$B8,$00,$B8,$7B,$00,$9C             ; 0FDE56 ?????{??
.byte $9B,$30,$CB,$B0,$4F,$A0,$57,$E4             ; 0FDE5E ?0??O?W?
.byte $1F,$09,$0F,$25,$DF,$EB,$FF,$18             ; 0FDE66 ???%????
.byte $64,$F8,$F0,$AB,$2B,$DD,$DD,$2B             ; 0FDE6E d???+??+
.byte $00,$DD,$F0,$70,$5B,$F4,$5B,$F5             ; 0FDE76 ???p[?[?
.byte $5B,$F1,$5F,$F3,$5F,$F2,$5E,$AB             ; 0FDE7E [?_?_?^?
.byte $FE,$3C,$C0,$3C,$C0,$3C,$C0,$B8             ; 0FDE86 ?<?<?<??
.byte $C0,$B8,$C0,$70,$40,$3D,$3F,$3D             ; 0FDE8E ???p@=?=
.byte $3F,$BD,$3F,$01,$09,$06,$09,$05             ; 0FDE96 ????????
.byte $13,$07,$11,$07,$FC,$F6,$FE,$EF             ; 0FDE9E ????????
.byte $FF,$40,$3F,$E0,$BF,$E0,$9F,$E3             ; 0FDEA6 ?@??????
.byte $BF,$DF,$77,$CB,$FF,$CB,$C7,$FB             ; 0FDEAE ??w?????
.byte $CF,$80,$FF,$A0,$DF,$80,$DF,$A0             ; 0FDEB6 ????????
.byte $9F,$70,$3F,$C0,$FF,$03,$FC,$03             ; 0FDEBE ?p??????
.byte $FC,$07,$F8,$2B,$D4,$02,$FF,$00             ; 0FDEC6 ???+????
.byte $02,$B3,$47,$D9,$23,$CC,$11,$EE             ; 0FDECE ??G?#???
.byte $1C,$F6,$08,$F3,$04,$F8,$07,$78             ; 0FDED6 ???????x
.byte $3E,$0C,$13,$0F,$01,$06,$00,$03             ; 0FDEDE >???????
.byte $AD,$C2,$D4,$E2,$E1,$F8,$7A,$F5             ; 0FDEE6 ??????z?
.byte $7C,$7A,$3F,$7F,$1F,$BF,$8F,$1F             ; 0FDEEE |z??????
.byte $87,$E0,$4E,$2F,$9C,$5F,$39,$BD             ; 0FDEF6 ??N/?_9?
.byte $73,$78,$F2,$F1,$E6,$E1,$C1,$EE             ; 0FDEFE sx??????
.byte $99,$C4,$01,$F3,$C3,$0F,$00,$1F             ; 0FDF06 ????????
.byte $0C,$12,$00,$3E,$08,$0B,$00,$8F             ; 0FDF0E ???>????
.byte $80,$CB,$C1,$E1,$E0,$71,$F0,$39             ; 0FDF16 ?????q?9
.byte $FA,$1F,$FB,$0B,$FB,$3F,$FF,$1F             ; 0FDF1E ????????
.byte $3F,$0D,$7E,$FF,$67,$FF,$8D,$F9             ; 0FDF26 ??~?g???
.byte $FA,$31,$F4,$23,$68,$27,$30,$3F             ; 0FDF2E ?1?#h'0?
.byte $20,$1F,$F9,$FF,$31,$FD,$23,$FB             ; 0FDF36  ???1?#?
.byte $A7,$DF,$80,$CE,$C0,$C0,$40,$C0             ; 0FDF3E ??????@?
.byte $10,$90,$38,$38,$F0,$F0,$F0,$F0             ; 0FDF46 ??88????
.byte $F8,$F8,$0B,$F4,$0B,$F4,$0B,$F4             ; 0FDF4E ????????
.byte $99,$66,$04,$FB,$04,$FB,$03,$16             ; 0FDF56 ?f??????
.byte $FE,$D5,$3D,$FE,$1E,$D8,$38,$D8             ; 0FDF5E ??=???8?
.byte $38,$F0,$30,$07,$02,$07,$01,$AB             ; 0FDF66 8?0?????
.byte $AB,$55,$55,$8A,$8A,$01,$54,$75             ; 0FDF6E ?UU???Tu
.byte $FF,$FF,$BC,$83,$BC,$83,$BC,$83             ; 0FDF76 ????????
.byte $9D,$83,$9D,$83,$0E,$02,$3C,$FC             ; 0FDF7E ??????<?
.byte $3C,$FC,$BD,$FC,$F2,$5E,$F2,$5E             ; 0FDF86 <????^?^
.byte $F2,$5E,$FA,$4E,$EE,$56,$E6,$5E             ; 0FDF8E ?^?N?V?^
.byte $E6,$5E,$E0,$5E,$AB,$FE,$BB,$FE             ; 0FDF96 ?^?^????
.byte $BB,$FE,$B3,$AB,$FE,$A9,$FE,$A9             ; 0FDF9E ????????
.byte $F8,$40,$F0,$B0,$E8,$68,$F0,$3D             ; 0FDFA6 ?@???h?=
.byte $FF,$3D,$FF,$3D,$FF,$1D,$BF,$0D             ; 0FDFAE ?=?=????
.byte $4F,$05,$87,$10,$03,$08,$04,$0C             ; 0FDFB6 O???????
.byte $08,$08,$03,$10,$00,$42,$50,$E4             ; 0FDFBE ?????BP?
.byte $EF,$EF,$FF,$FF,$C9,$4F,$51,$E7             ; 0FDFC6 ?????OQ?
.byte $81,$07,$FD,$FB,$04,$0C,$48,$18             ; 0FDFCE ??????H?
.byte $50,$30,$78,$38,$70,$FF,$A0,$AF             ; 0FDFD6 P0x8p???
.byte $78,$FE,$DB,$02,$F7,$03,$FD,$01             ; 0FDFDE x???????
.byte $FF,$01,$02,$00,$FE,$FC,$FE,$06             ; 0FDFE6 ????????
.byte $F8,$87,$F8,$87,$49,$8F,$66,$8F             ; 0FDFEE ????I?f?
.byte $B0,$77,$10,$E2,$19,$E0,$1A,$F5             ; 0FDFF6 ?w??????
.byte $7D,$00,$3F,$02,$1D,$02,$1D,$00             ; 0FDFFE }???????
.byte $0F,$35,$8A,$30,$0B,$61,$76,$C1             ; 0FE006 ?5?0?av?
.byte $2E,$80,$5F,$41,$BE,$41,$FE,$C1             ; 0FE00E .?_A?A??
.byte $FE,$60,$98,$FB,$03,$FB,$03,$FA             ; 0FE016 ?`??????
.byte $02,$FA,$02,$F8,$08,$F9,$09,$01             ; 0FE01E ????????
.byte $07,$01,$07,$01,$03,$0F,$02,$0F             ; 0FE026 ????????
.byte $20,$0F,$20,$04,$11,$61,$0C,$B1             ; 0FE02E  ? ??a??
.byte $84,$58,$84,$08,$80,$00,$D0,$40             ; 0FE036 ?X?????@
.byte $DF,$F3,$FF,$7B,$FF,$7B,$6F,$FF             ; 0FE03E ???{?{o?
.byte $73,$73,$8F,$EF,$0A,$4F,$11,$9C             ; 0FE046 ss???O??
.byte $30,$38,$69,$7A,$42,$FA,$17,$1F             ; 0FE04E 08izB???
.byte $EC,$FE,$FE,$F4,$F7,$D8,$F9,$1F             ; 0FE056 ????????
.byte $FB,$1F,$B9,$1F,$C9,$0F,$E3,$17             ; 0FE05E ????????
.byte $05,$F8,$05,$05,$78,$15,$38,$1F             ; 0FE066 ????x?8?
.byte $98,$B0,$70,$B0,$70,$A2,$60,$87             ; 0FE06E ??p?p?`?
.byte $C0,$0F,$1F,$3F,$A8,$00,$76,$60             ; 0FE076 ??????v`
.byte $5E,$E0,$5F,$E0,$5F,$E0,$5F,$E7             ; 0FE07E ^?_?_?_?
.byte $58,$E7,$59,$A9,$F8,$A8,$F8,$A8             ; 0FE086 X?Y?????
.byte $FF,$A9,$FE,$A8,$F0,$78,$E0,$28             ; 0FE08E ?????x?(
.byte $B0,$38,$E0,$10,$C0,$FF,$00,$8C             ; 0FE096 ?8??????
.byte $0D,$47,$1D,$87,$45,$C7,$05,$C7             ; 0FE09E ?G??E???
.byte $2D,$EF,$3D,$73,$FC,$63,$63,$9C             ; 0FE0A6 -?=s?cc?
.byte $FF,$18,$18,$E7,$47,$F8,$67,$F8             ; 0FE0AE ????G?g?
.byte $27,$F8,$17,$F8,$1F,$00,$FF,$CF             ; 0FE0B6 '???????
.byte $31,$80,$E0,$C0,$E0,$E0,$F0,$E0             ; 0FE0BE 1???????
.byte $F8,$00,$FF,$31,$CE,$16,$F0,$1F             ; 0FE0C6 ???1????
.byte $FF,$1F,$F8,$1F,$F8,$00,$FF,$F3             ; 0FE0CE ????????
.byte $8C,$00,$FF,$8C,$73,$C0,$FF,$C1             ; 0FE0D6 ????s???
.byte $63,$9C,$FB,$1A,$F9,$13,$FB,$2B             ; 0FE0DE c??????+
.byte $F1,$71,$E0,$64,$C0,$FF,$18,$01             ; 0FE0E6 ?q?d????
.byte $1F,$0B,$1F,$13,$3F,$09,$7F,$1D             ; 0FE0EE ????????
.byte $7F,$6D,$60,$60,$C0,$E0,$80,$90             ; 0FE0F6 ?m``????
.byte $00,$FF,$3F,$C6,$76,$FF,$E6,$FF             ; 0FE0FE ????v???
.byte $DA,$E7,$9B,$FF,$93,$00,$FF,$C6             ; 0FE106 ????????
.byte $39,$3F,$3F,$36,$3F,$50,$50,$C9             ; 0FE10E 9??6?PP?
.byte $C9,$06,$DF,$F1,$FF,$E6,$FE,$EC             ; 0FE116 ????????
.byte $E6,$E3,$F4,$43,$D4,$63,$76,$83             ; 0FE11E ???C?cv?
.byte $A6,$83,$C4,$03,$D4,$03,$FC,$F3             ; 0FE126 ????????
.byte $8C,$7A,$FD,$BA,$FD,$D8,$FF,$70             ; 0FE12E ?z?????p
.byte $7F,$00,$FF,$84,$7B,$AA,$00,$55             ; 0FE136 ????{??U
.byte $00,$AD,$00,$57,$04,$00,$48,$00             ; 0FE13E ???W??H?
.byte $95,$E7,$58,$60,$58,$E5,$5A,$E4             ; 0FE146 ??X`X?Z?
.byte $5A,$E4,$A8,$F8,$A9,$F8,$74,$4F             ; 0FE14E Z?????tO
.byte $84,$FA,$45,$4D,$DA,$35,$FD,$37             ; 0FE156 ??EM?5?7
.byte $E5,$5B,$E5,$5B,$65,$7F,$80,$80             ; 0FE15E ?[?[e???
.byte $96,$96,$B2,$B2,$B5,$B5,$AF,$AF             ; 0FE166 ????????
.byte $00,$69,$4A,$00,$50,$41,$41,$80             ; 0FE16E ?iJ?PAA?
.byte $80,$7E,$BD,$BD,$7A,$7A,$FF,$FF             ; 0FE176 ?~??zz??
.byte $BE,$81,$85,$02,$08,$08,$BA,$BA             ; 0FE17E ????????
.byte $6F,$6F,$56,$D9,$D9,$00,$F7,$90             ; 0FE186 ooV?????
.byte $00,$A9,$00,$00,$86,$86,$3E,$3E             ; 0FE18E ??????>>
.byte $F2,$F2,$CF,$CF,$3F,$3F,$FB,$C1             ; 0FE196 ????????
.byte $30,$5F,$5F,$FF,$FF,$59,$59,$E5             ; 0FE19E 0__??YY?
.byte $E5,$27,$27,$A6,$00,$1A,$00,$D8             ; 0FE1A6 ?''?????
.byte $40,$40,$ED,$ED,$2D,$2D,$B7,$B7             ; 0FE1AE @@??--??
.byte $8F,$8F,$FE,$12,$00,$D2,$70,$10             ; 0FE1B6 ??????p?
.byte $10,$2C,$2C,$AF,$AF,$7F,$7F,$BD             ; 0FE1BE ?,,?????
.byte $BD,$00,$D3,$80,$02,$02,$EF,$EF             ; 0FE1C6 ????????
.byte $FE,$FE,$EB,$EB,$D6,$D6,$37,$37             ; 0FE1CE ??????77
.byte $10,$14,$00,$29,$FD,$FD,$B6,$B6             ; 0FE1D6 ???)????
.byte $9A,$9A,$EF,$EF,$AE,$AE,$02,$00             ; 0FE1DE ????????
.byte $49,$00,$65,$51,$08,$34,$34,$9F             ; 0FE1E6 I?eQ?44?
.byte $9F,$7B,$7B,$FB,$F1,$F1,$FF,$FF             ; 0FE1EE ?{{?????
.byte $F7,$00,$CB,$04,$00,$0E,$F9,$F9             ; 0FE1F6 ????????
.byte $CF,$CF,$28,$28,$D7,$D7,$17,$17             ; 0FE1FE ??((????
.byte $7F,$30,$00,$D7,$00,$28,$00,$CB             ; 0FE206 ?0???(??
.byte $CB,$BF,$BF,$34,$0A,$0A,$FD,$00             ; 0FE20E ???4????
.byte $F5,$01,$C4,$C4,$F1,$F1,$DF,$DF             ; 0FE216 ????????
.byte $B6,$B6,$F8,$F8,$FE,$00,$3B,$20             ; 0FE21E ??????; 
.byte $07,$E5,$5B,$E4,$5B,$E4,$FC,$FD             ; 0FE226 ??[?[???
.byte $FB,$F1,$01,$EF,$10,$EF,$10,$80             ; 0FE22E ????????
.byte $FB,$84,$FB,$84,$84,$7B,$FE,$21             ; 0FE236 ?????{?!
.byte $FE,$21,$21,$DE,$21,$DE,$08,$FF             ; 0FE23E ?!!?!???
.byte $08,$08,$F7,$08,$F7,$BF,$42,$BF             ; 0FE246 ??????B?
.byte $42,$42,$BD,$42,$BD,$B7,$4A,$B6             ; 0FE24E BB?B??J?
.byte $4D,$64,$EC,$53,$DC,$63,$FC,$43             ; 0FE256 Md?S?c?C
.byte $EC,$43,$FE,$71,$DE,$71,$B8,$F8             ; 0FE25E ?C?q?q??
.byte $B0,$F0,$B0,$F0,$B0,$F0,$A0,$F0             ; 0FE266 ????????
.byte $A0,$F0,$F5,$FA,$E3,$F4,$6A,$F4             ; 0FE26E ??????j?
.byte $72,$EC,$47,$E8,$5D,$E0,$68,$D1             ; 0FE276 r?G?]?h?
.byte $5A,$99,$0C,$03,$00,$1E,$00,$1E             ; 0FE27E Z???????
.byte $00,$1E,$18,$80,$7F,$BF,$7F,$80             ; 0FE286 ????????
.byte $F7,$AF,$7B,$3D,$9A,$ED,$EE,$03             ; 0FE28E ??{=????
.byte $00,$0B,$F0,$F8,$F3,$0D,$F0,$0D             ; 0FE296 ????????
.byte $F0,$0C,$F0,$07,$03,$04,$FF,$7F             ; 0FE29E ????????
.byte $BF,$E7,$5F,$6F,$17,$80,$60,$40             ; 0FE2A6 ??_o??`@
.byte $B0,$00,$F8,$D7,$78,$F7,$78,$57             ; 0FE2AE ????x?xW
.byte $78,$D3,$78,$D3,$78,$D2,$78,$FC             ; 0FE2B6 x?x?x?x?
.byte $A8,$FC,$AA,$FF,$DB,$21,$9C,$23             ; 0FE2BE ?????!?#
.byte $D5,$23,$94,$63,$20,$4F,$68,$87             ; 0FE2C6 ?#?c Oh?
.byte $68,$97,$F8,$C7,$78,$00,$78,$60             ; 0FE2CE h???x?x`
.byte $18,$00,$E0,$C0,$20,$9F,$0F,$F0             ; 0FE2D6 ???? ???
.byte $10,$01,$FE,$07,$07,$38,$CD,$7C             ; 0FE2DE ?????8?|
.byte $86,$FE,$03,$9F,$13,$DF,$4A,$BE             ; 0FE2E6 ??????J?
.byte $74,$8C,$10,$10,$38,$38,$7C,$7C             ; 0FE2EE t???88||
.byte $FE,$FE,$9F,$FF,$7F,$7F,$23,$1F             ; 0FE2F6 ??????#?
.byte $A9,$17,$CD,$13,$D6,$09,$EF,$00             ; 0FE2FE ????????
.byte $E7,$10,$FB,$01,$F9,$04,$7C,$10             ; 0FE306 ??????|?
.byte $2E,$08,$37,$3F,$FF,$AF,$5F,$E7             ; 0FE30E .?7???_?
.byte $9F,$F0,$0D,$E0,$80,$70,$D2,$79             ; 0FE316 ?????p?y
.byte $D3,$79,$D3,$79,$D3,$79,$79,$AA             ; 0FE31E ?y?y?yy?
.byte $50,$8F,$90,$2F,$B0,$0F,$B0,$4F             ; 0FE326 P??/???O
.byte $73,$0C,$6D,$12,$E0,$20,$02,$02             ; 0FE32E s?m?? ??
.byte $05,$06,$0C,$03,$06,$06,$0F,$0F             ; 0FE336 ????????
.byte $07,$01,$03,$04,$C9,$CE,$F8,$FF             ; 0FE33E ????????
.byte $98,$FF,$C4,$7F,$7E,$32,$BC,$10             ; 0FE346 ????~2??
.byte $01,$07,$04,$07,$EE,$7F,$FF,$33             ; 0FE34E ???????3
.byte $FF,$13,$7F,$28,$F8,$F0,$F0,$E0             ; 0FE356 ???(????
.byte $60,$C0,$40,$44,$7E,$FC,$FC,$F8             ; 0FE35E `?@D~???
.byte $01,$7F,$00,$3E,$FC,$03,$93,$0C             ; 0FE366 ???>????
.byte $67,$80,$99,$60,$00,$FF,$82,$7F             ; 0FE36E g??`????
.byte $01,$FF,$83,$0C,$73,$9F,$3F,$F0             ; 0FE376 ????s???
.byte $0F,$FF,$60,$FC,$03,$FF,$FF,$60             ; 0FE37E ??`????`
.byte $9F,$03,$FC,$7F,$08,$7F,$9C,$73             ; 0FE386 ???????s
.byte $BE,$E1,$7F,$C0,$F9,$C8,$FB,$52             ; 0FE38E ???????R
.byte $7D,$2E,$31,$08,$88,$1C,$1C,$3E             ; 0FE396 }.1????>
.byte $3E,$7F,$7F,$80,$40,$C0,$20,$E0             ; 0FE39E >???@? ?
.byte $78,$8E,$3F,$0E,$BF,$4E,$BF,$4E             ; 0FE3A6 x????N?N
.byte $BF,$AE,$1F,$F2,$D2,$52,$79,$7E             ; 0FE3AE ?????Ry~
.byte $80,$7E,$A0,$7E,$A0,$7E,$A0,$7C             ; 0FE3B6 ?~?~?~?|
.byte $20,$02,$02,$06,$06,$05,$0F,$0E             ; 0FE3BE  ???????
.byte $0E,$20,$C0,$47,$A1,$E7,$07,$42             ; 0FE3C6 ? ?G???B
.byte $00,$43,$42,$72,$72,$BB,$FB,$DF             ; 0FE3CE ?CBrr???
.byte $7A,$07,$40,$00,$A5,$C2,$C3,$F1             ; 0FE3D6 z?@?????
.byte $F1,$7A,$7A,$3A,$BF,$1E,$08,$0F             ; 0FE3DE ?zz:????
.byte $20,$27,$70,$73,$38,$3B,$C4,$DC             ; 0FE3E6  'ps8;??
.byte $42,$CA,$20,$E6,$30,$70,$7F,$7F             ; 0FE3EE B? ?0p??
.byte $DF,$DF,$58,$90,$30,$F0,$10,$10             ; 0FE3F6 ??X?0???
.byte $80,$20,$18,$C0,$30,$84,$60,$97             ; 0FE3FE ? ??0?`?
.byte $EE,$FE,$EE,$FE,$EE,$FE,$DE,$FE             ; 0FE406 ????????
.byte $3C,$FC,$78,$FC,$3F,$00,$1E,$01             ; 0FE40E <?x?????
.byte $81,$7F,$03,$7F,$21,$1F,$E8,$E8             ; 0FE416 ????!???
.byte $17,$0F,$00,$14,$06,$06,$82,$02             ; 0FE41E ????????
.byte $80,$03,$80,$22,$7E,$7F,$7F,$1F             ; 0FE426 ???"~???
.byte $07,$01,$68,$38,$04,$78,$7C,$D0             ; 0FE42E ??h8?x|?
.byte $F4,$38,$1C,$70,$68,$E8,$F0,$00             ; 0FE436 ?8?ph???
.byte $18,$04,$4C,$06,$26,$7E,$7E,$BE             ; 0FE43E ??L?&~~?
.byte $BE,$1E,$3E,$6E,$7E,$B6,$BE,$FF             ; 0FE446 ??>n~???
.byte $F0,$0F,$52,$79,$F2,$F9,$D2,$F9             ; 0FE44E ??Ry????
.byte $72,$59,$E2,$E9,$F2,$09,$02,$AA             ; 0FE456 rY??????
.byte $FE,$2A,$FE,$2A,$1A,$FE,$FA,$FE             ; 0FE45E ?*?*????
.byte $FE,$7C,$A0,$58,$90,$78,$B0,$58             ; 0FE466 ?|?X?x?X
.byte $90,$48,$80,$40,$80,$40,$00,$20             ; 0FE46E ?H?@?@? 
.byte $20,$20,$30,$30,$30,$09,$09,$00             ; 0FE476   000???
.byte $0D,$06,$05,$0C,$0C,$0D,$0D,$05             ; 0FE47E ????????
.byte $05,$01,$C4,$CA,$80,$E0,$60,$60             ; 0FE486 ??????``
.byte $60,$3A,$3E,$60,$60,$16,$01,$0C             ; 0FE48E `:>``???
.byte $00,$1C,$20,$1E,$3E,$0B,$2F,$1F             ; 0FE496 ?? ?>?/?
.byte $38,$0F,$16,$17,$0F,$01,$19,$20             ; 0FE49E 8?????? 
.byte $32,$60,$64,$7E,$7E,$7D,$7D,$78             ; 0FE4A6 2`d~~}}x
.byte $7F,$76,$7F,$6D,$7D,$58,$78,$08             ; 0FE4AE ?v?m}Xx?
.byte $7C,$20,$60,$32,$30,$D2,$90,$0A             ; 0FE4B6 | `20???
.byte $08,$8C,$0C,$E0,$8C,$BF,$6F,$7F             ; 0FE4BE ??????o?
.byte $3D,$3F,$9D,$9F,$DD,$DF,$3F,$BF             ; 0FE4C6 =???????
.byte $9F,$9F,$84,$40,$04,$00,$2C,$08             ; 0FE4CE ???@??,?
.byte $5E,$1A,$6E,$1F,$97,$27,$73,$02             ; 0FE4D6 ^?n??'s?
.byte $F9,$98,$78,$FC,$F0,$F4,$DA,$FE             ; 0FE4DE ??x?????
.byte $BB,$6F,$FF,$86,$F7,$06,$E0,$E0             ; 0FE4E6 ?o??????
.byte $0B,$C0,$C0,$22,$F4,$14,$00,$18             ; 0FE4EE ???"????
.byte $10,$12,$12,$12,$1A,$08,$18,$08             ; 0FE4F6 ????????
.byte $08,$08,$08,$DC,$DE,$08,$1C,$16             ; 0FE4FE ????????
.byte $1E,$1C,$1E,$1E,$1E,$1C,$1C,$0C             ; 0FE506 ????????
.byte $0C,$0C,$0C,$E0,$BF,$C0,$60,$60             ; 0FE50E ??????``
.byte $40,$40,$80,$30,$00,$3C,$04,$3C             ; 0FE516 @@?0?<?<
.byte $05,$2C,$8F,$FF,$4F,$7F,$47,$7F             ; 0FE51E ?,??O?G?
.byte $47,$7F,$57,$7F,$77,$D9,$D8,$DB             ; 0FE526 G?W?w???
.byte $D8,$53,$51,$67,$FA,$FB,$07,$06             ; 0FE52E ?SQg????
.byte $DF,$04,$DF,$8D,$DF,$20,$80,$80             ; 0FE536 ????? ??
.byte $D0,$F0,$90,$F0,$90,$F0,$D0,$E0             ; 0FE53E ????????
.byte $E0,$1A,$1E,$10,$3E,$04,$06,$4C             ; 0FE546 ????>??L
.byte $04,$58,$0A,$49,$09,$3B,$3B,$1F             ; 0FE54E ?X?I?;;?
.byte $2B,$F6,$FE,$A4,$F4,$AA,$FA,$B3             ; 0FE556 +???????
.byte $F3,$EF,$EF,$EB,$FF,$90,$F0,$C0             ; 0FE55E ????????
.byte $50,$C8,$C8,$AC,$EC,$74,$DE,$00             ; 0FE566 P????t??
.byte $B0,$70,$DC,$DC,$8E,$AE,$08,$08             ; 0FE56E ?p??????
.byte $1C,$0C,$0C,$1C,$1A,$00,$1D,$02             ; 0FE576 ????????
.byte $3C,$3E,$C3,$FF,$C3,$CF,$00,$26             ; 0FE57E <>?????&
.byte $02,$13,$12,$0F,$4B,$3A,$3C,$FC             ; 0FE586 ????K:<?
.byte $F0,$F1,$0B,$01,$3C,$00,$70,$E0             ; 0FE58E ????<?p?
.byte $C0,$6C,$7C,$4F,$CF,$83,$43,$40             ; 0FE596 ?l|O??C@
.byte $30,$00,$8C,$80,$87,$80,$80,$00             ; 0FE59E 0???????
.byte $07,$07,$DF,$9E,$BE,$1C,$BC,$08             ; 0FE5A6 ????????
.byte $FE,$04,$0A,$0C,$00,$3C,$20,$3C             ; 0FE5AE ?????< <
.byte $A0,$34,$A0,$10,$20,$FB,$FF,$F2             ; 0FE5B6 ?4?? ???
.byte $FE,$E2,$FE,$E2,$FE,$EA,$FC,$FC             ; 0FE5BE ????????
.byte $FC,$FC,$72,$72,$20,$76,$8C,$D4             ; 0FE5C6 ??rr v??
.byte $F0,$86,$86,$D6,$D6,$F4,$F4,$D0             ; 0FE5CE ????????
.byte $D0,$D0,$D0,$E8,$FA,$1C,$0E,$38             ; 0FE5D6 ???????8
.byte $34,$F4,$F8,$11,$FA,$0A,$00,$08             ; 0FE5DE 4???????
.byte $DF,$DF,$0F,$1F,$37,$3F,$DB,$DF             ; 0FE5E6 ????7???
.byte $EE,$EF,$04,$0E,$0B,$0F,$0E,$0F             ; 0FE5EE ????????
.byte $5E,$3E,$78,$01,$38,$0F,$1F,$1E             ; 0FE5F6 ^>x?8???
.byte $7E,$7E,$FE,$E6,$E6,$86,$84,$06             ; 0FE5FE ~~??????
.byte $B9,$8E,$B1,$1C,$E4,$31,$80,$31             ; 0FE606 ?????1?1
.byte $E0,$F7,$7F,$40,$9F,$FC,$08,$C4             ; 0FE60E ???@????
.byte $40,$04,$E3,$10,$07,$3C,$07,$38             ; 0FE616 @????<?8
.byte $A7,$98,$9F,$94,$BF,$44,$F8,$02             ; 0FE61E ?????D??
.byte $3B,$F0,$1B,$F8,$13,$E4,$00,$D5             ; 0FE626 ;???????
.byte $29,$74,$33,$E6,$37,$E4,$82,$82             ; 0FE62E )t3?7???
.byte $F3,$03,$FB,$23,$BB,$77,$B9,$55             ; 0FE636 ???#?w?U
.byte $89,$7D,$13,$FF,$17,$FF,$6C,$78             ; 0FE63E ?}????lx
.byte $45,$C7,$A3,$67,$C0,$38,$F0,$8C             ; 0FE646 E??g?8??
.byte $F0,$EE,$83,$0C,$23,$9D,$60,$2B             ; 0FE64E ????#?`+
.byte $80,$0C,$E0,$0C,$70,$8C,$F7,$BE             ; 0FE656 ????p???
.byte $C0,$F0,$E0,$AC,$B8,$9B,$9E,$89             ; 0FE65E ????????
.byte $79,$C9,$39,$98,$00,$09,$30,$09             ; 0FE666 y?9???0?
.byte $C0,$D8,$D0,$50,$50,$D0,$D0,$D0             ; 0FE66E ???PP???
.byte $09,$0D,$04,$0C,$04,$04,$04,$0F             ; 0FE676 ????????
.byte $06,$06,$06,$02,$03,$0F,$09,$3A             ; 0FE67E ???????:
.byte $09,$01,$07,$17,$0F,$38,$78,$70             ; 0FE686 ?????8xp
.byte $60,$61,$63,$70,$28,$08,$43,$18             ; 0FE68E `acp(?C?
.byte $23,$40,$C1,$2A,$69,$14,$18,$07             ; 0FE696 #@?*i???
.byte $09,$F3,$40,$00,$43,$43,$E1,$E3             ; 0FE69E ??@?CC??
.byte $61,$65,$01,$07,$F9,$0B,$80,$0D             ; 0FE6A6 ae??????
.byte $22,$06,$22,$0E,$02,$0E,$20,$0E             ; 0FE6AE "?"??? ?
.byte $C0,$44,$54,$D0,$80,$05,$AB,$86             ; 0FE6B6 ?DT?????
.byte $E1,$26,$F0,$0E,$F0,$0E,$60,$2E             ; 0FE6BE ?&????`.
.byte $C8,$C7,$D4,$D7,$80,$87,$C2,$58             ; 0FE6C6 ???????X
.byte $80,$18,$82,$38,$FE,$10,$30,$70             ; 0FE6CE ???8??0p
.byte $42,$9A,$61,$98,$43,$BA,$EF,$90             ; 0FE6D6 B?a?C???
.byte $7F,$80,$CF,$30,$8F,$70,$8F,$71             ; 0FE6DE ???0?p?q
.byte $C9,$F5,$4D,$73,$3F,$18,$B7,$23             ; 0FE6E6 ??Ms???#
.byte $11,$01,$30,$21,$3C,$AB,$72,$85             ; 0FE6EE ??0!<?r?
.byte $C1,$30,$C1,$30,$F8,$20,$FF,$B4             ; 0FE6F6 ?0?0? ??
.byte $FF,$10,$FA,$31,$FF,$3E,$F3,$76             ; 0FE6FE ???1?>?v
.byte $34,$FC,$9F,$DE,$32,$FB,$29,$F8             ; 0FE706 4???2?)?
.byte $30,$EC,$1C,$E3,$0E,$F8,$03,$D0             ; 0FE70E 0???????
.byte $30,$40,$3C,$60,$12,$60,$E0,$00             ; 0FE716 0@<`?`??
.byte $E1,$38,$C0,$FD,$23,$EC,$78,$8B             ; 0FE71E ?8??#?x?
.byte $5F,$07,$53,$52,$D1,$22,$1B,$88             ; 0FE726 _?SR?"??
.byte $C0,$03,$40,$40,$81,$F0,$6F,$77             ; 0FE72E ??@@??ow
.byte $3E,$9F,$21,$E0,$80,$5F,$C1,$01             ; 0FE736 >?!??_??
.byte $E0,$DF,$FF,$82,$8C,$0C,$0C,$DB             ; 0FE73E ????????
.byte $C2,$FA,$02,$00,$30,$F1,$10,$70             ; 0FE746 ????0??p
.byte $18,$F0,$50,$B0,$C0,$38,$00,$32             ; 0FE74E ??P??8?2
.byte $30,$01,$E0,$02,$60,$0F,$E0,$4F             ; 0FE756 0???`??O
.byte $E0,$F3,$F8,$13,$32,$67,$77,$47             ; 0FE75E ????2gwG
.byte $77,$07,$F7,$62,$54,$62,$03,$00             ; 0FE766 w??bTb??
.byte $29,$08,$20,$0C,$05,$47,$10,$47             ; 0FE76E )? ??G?G
.byte $10,$07,$10,$77,$36,$E3,$03,$E8             ; 0FE776 ???w6???
.byte $29,$C8,$28,$CC,$0D,$84,$43,$00             ; 0FE77E )?(???C?
.byte $43,$60,$E3,$C0,$E3,$E0,$F7,$E0             ; 0FE786 C`??????
.byte $F7,$E0,$F7,$F0,$EF,$84,$C7,$A3             ; 0FE78E ????????
.byte $C0,$03,$E0,$07,$F4,$13,$E7,$10             ; 0FE796 ????????
.byte $FF,$18,$20,$F3,$00,$C3,$10,$C3             ; 0FE79E ?? ?????
.byte $21,$C0,$C8,$C8,$20,$08,$A0,$EC             ; 0FE7A6 !??? ???
.byte $33,$CC,$03,$DC,$13,$EF,$61,$CF             ; 0FE7AE 3?????a?
.byte $C0,$CF,$C0,$DF,$E8,$9B,$A8,$07             ; 0FE7B6 ????????
.byte $32,$05,$24,$21,$20,$21,$28,$4C             ; 0FE7BE 2?$! !(L
.byte $00,$48,$04,$48,$E7,$37,$E5,$25             ; 0FE7C6 ?H?H?7?%
.byte $E3,$21,$E9,$29,$EF,$4C,$E9,$4C             ; 0FE7CE ?!?)?L?L
.byte $F9,$48,$E1,$04,$BA,$07,$9E,$01             ; 0FE7D6 ?H??????
.byte $8E,$1D,$04,$1F,$43,$C1,$01,$C3             ; 0FE7DE ????C???
.byte $06,$C0,$02,$C1,$E0,$81,$F0,$81             ; 0FE7E6 ????????
.byte $FF,$93,$EE,$5B,$3F,$C3,$3F,$C3             ; 0FE7EE ???[????
.byte $3E,$C6,$3A,$C3,$21,$E0,$21,$DE             ; 0FE7F6 >?:?!?!?
.byte $3C,$C2,$BC,$62,$01,$13,$52,$42             ; 0FE7FE <??b??RB
.byte $00,$14,$10,$0C,$C3,$60,$E2,$B4             ; 0FE806 ?????`??
.byte $F6,$21,$1F,$52,$5F,$00,$1F,$12             ; 0FE80E ?!?R_???
.byte $1F,$8E,$82,$86,$82,$82,$7A,$F2             ; 0FE816 ??????z?
.byte $0D,$40,$3F,$40,$3F,$C0,$3E,$01             ; 0FE81E ?@?@??>?
.byte $2E,$0E,$0C,$06,$04,$04,$0C,$F3             ; 0FE826 .???????
.byte $00,$FF,$89,$F7,$05,$EB,$05,$15             ; 0FE82E ????????
.byte $0C,$1C,$0C,$3C,$0C,$FC,$C7,$38             ; 0FE836 ???<???8
.byte $83,$FC,$83,$7F,$02,$7F,$0D,$18             ; 0FE83E ????????
.byte $04,$18,$04,$38,$04,$38,$00,$38             ; 0FE846 ???8?8?8
.byte $CC,$30,$81,$FF,$DD,$2B,$13,$00             ; 0FE84E ?0???+??
.byte $18,$08,$38,$0A,$FC,$C8,$07,$FC             ; 0FE856 ??8?????
.byte $20,$33,$30,$F8,$FF,$05,$F0,$F8             ; 0FE85E  30?????
.byte $97,$9F,$07,$67,$08,$F8,$20,$DF             ; 0FE866 ???g?? ?
.byte $C7,$98,$60,$07,$08,$60,$B0,$F0             ; 0FE86E ??`??`??
.byte $C8,$F0,$F8,$FB,$F7,$8F,$07,$C3             ; 0FE876 ????????
.byte $22,$43,$22,$02,$23,$80,$E7,$E1             ; 0FE87E "C"?#???
.byte $43,$61,$02,$21,$0E,$00,$0E,$60             ; 0FE886 Ca?!???`
.byte $1F,$9F,$E0,$FF,$C0,$FC,$88,$90             ; 0FE88E ????????
.byte $71,$0E,$71,$0E,$FF,$60,$BF,$20             ; 0FE896 q?q??`? 
.byte $9F,$DF,$30,$EF,$38,$90,$21,$41             ; 0FE89E ??0?8?!A
.byte $62,$28,$22,$0C,$01,$1C,$13,$0C             ; 0FE8A6 b("?????
.byte $00,$70,$08,$88,$90,$9F,$B1,$4D             ; 0FE8AE ?p?????M
.byte $F3,$2C,$FA,$0E,$FD,$1C,$FF,$0F             ; 0FE8B6 ?,??????
.byte $FC,$FF,$78,$EF,$38,$C0,$04,$48             ; 0FE8BE ??x?8??H
.byte $0C,$42,$41,$11,$09,$C1,$C4,$48             ; 0FE8C6 ?BA????H
.byte $5D,$42,$5F,$D0,$1F,$C0,$1F,$C3             ; 0FE8CE ]B_?????
.byte $0C,$E1,$00,$F7,$E0,$B0,$B0,$90             ; 0FE8D6 ????????
.byte $90,$88,$88,$E0,$00,$B0,$08,$98             ; 0FE8DE ????????
.byte $04,$E0,$E0,$30,$30,$38,$38,$28             ; 0FE8E6 ???0088(
.byte $28,$24,$E0,$2C,$02,$20,$20,$D1             ; 0FE8EE ($?,?  ?
.byte $C1,$38,$38,$C3,$C3,$C3,$E3,$3E             ; 0FE8F6 ?88????>
.byte $80,$01,$00,$E6,$E6,$1A,$1A,$32             ; 0FE8FE ???????2
.byte $32,$E2,$E2,$FE,$FE,$22,$22,$C2             ; 0FE906 2????""?
.byte $C2,$FF,$FF,$19,$FF,$61,$7B,$81             ; 0FE90E ?????a{?
.byte $B3,$01,$E3,$01,$FF,$C1,$E3,$39             ; 0FE916 ???????9
.byte $FB,$01,$C2,$C2,$E2,$E2,$72,$72             ; 0FE91E ??????rr
.byte $FE,$FE,$1A,$1A,$1A,$1A,$01,$C3             ; 0FE926 ????????
.byte $73,$1B,$01,$80,$80,$60,$60,$30             ; 0FE92E s????``0
.byte $30,$F8,$F8,$08,$00,$08,$85,$84             ; 0FE936 0???????
.byte $82,$82,$82,$82,$82,$82,$03,$87             ; 0FE93E ????????
.byte $01,$83,$01,$83,$83,$22,$22,$E2             ; 0FE946 ?????""?
.byte $E2,$F2,$F2,$3A,$3A,$3E,$3E,$2E             ; 0FE94E ???::>>.
.byte $2E,$23,$F3,$01,$3B,$01,$3F,$01             ; 0FE956 .#??;???
.byte $2F,$18,$18,$03,$0E,$18,$00,$18             ; 0FE95E /???????
.byte $40,$00,$A3,$A3,$9C,$9C,$00,$BE             ; 0FE966 @???????
.byte $BE,$08,$08,$23,$23,$FF,$FF,$5C             ; 0FE96E ???##??\
.byte $FF,$43,$DF,$40,$47,$40,$40,$41             ; 0FE976 ?C?@G@@A
.byte $FF,$46,$4E,$58,$01,$8E,$8E,$F0             ; 0FE97E ?FNX????
.byte $F0,$1E,$1E,$02,$03,$10,$9E,$1E             ; 0FE986 ????????
.byte $CE,$CE,$8C,$8C,$98,$98,$B0,$B0             ; 0FE98E ????????
.byte $E0,$E0,$CE,$10,$9C,$20,$B8,$40             ; 0FE996 ????? ?@
.byte $FE,$FE,$19,$19,$19,$00,$FF,$08             ; 0FE99E ????????
.byte $08,$88,$88,$68,$68,$38,$38,$18             ; 0FE9A6 ???hh88?
.byte $18,$80,$88,$40,$C8,$00,$68,$18             ; 0FE9AE ???@??h?
.byte $00,$F8,$82,$82,$86,$86,$8E,$8E             ; 0FE9B6 ????????
.byte $9E,$9E,$B2,$B2,$E2,$E2,$C6,$C6             ; 0FE9BE ????????
.byte $FE,$FE,$87,$01,$8F,$01,$9F,$09             ; 0FE9C6 ????????
.byte $BB,$11,$F3,$21,$E7,$24,$24,$2C             ; 0FE9CE ???!?$$,
.byte $2C,$7A,$7A,$B2,$B2,$B2,$B2,$83             ; 0FE9D6 ,zz?????
.byte $A7,$83,$AF,$85,$FF,$45,$F7,$49             ; 0FE9DE ?????E?I
.byte $FB,$18,$19,$19,$1B,$1B,$1E,$1E             ; 0FE9E6 ????????
.byte $1F,$19,$00,$1B,$DE,$DE,$83,$83             ; 0FE9EE ????????
.byte $07,$07,$3C,$3C,$DE,$0F,$40,$7C             ; 0FE9F6 ??<<??@|
.byte $A2,$80,$C2,$C0,$42,$40,$22,$20             ; 0FE9FE ????B@" 
.byte $3A,$1A,$2E,$0E,$25,$05,$26,$06             ; 0FEA06 :?.?%?&?
.byte $40,$E2,$20,$E2,$30,$72,$18,$3A             ; 0FEA0E @? ?0r?:
.byte $04,$3E,$00,$2E,$02,$27,$01,$27             ; 0FEA16 ?>?.?'?'
.byte $81,$01,$00,$08,$04,$F4,$FC,$0C             ; 0FEA1E ????????
.byte $FC,$0C,$04,$FC,$C6,$C6,$EA,$EA             ; 0FEA26 ????????
.byte $EA,$EA,$AA,$AA,$B2,$B2,$92,$92             ; 0FEA2E ????????
.byte $92,$92,$9A,$9A,$01,$C7,$05,$EF             ; 0FEA36 ????????
.byte $01,$EB,$01,$AB,$09,$BB,$01,$93             ; 0FEA3E ????????
.byte $01,$93,$01,$9B,$52,$52,$42,$42             ; 0FEA46 ????RRBB
.byte $02,$02,$22,$22,$32,$22,$2A,$2A             ; 0FEA4E ??""2"**
.byte $52,$52,$D2,$D2,$29,$7B,$39,$7B             ; 0FEA56 RR??){9{
.byte $31,$33,$11,$33,$11,$33,$11,$3B             ; 0FEA5E 13?3?3?;
.byte $29,$7B,$29,$FB,$25,$01,$25,$01             ; 0FEA66 ){)?%?%?
.byte $24,$00,$27,$07,$1B,$0B,$1B,$03             ; 0FEA6E $?'?????
.byte $1B,$03,$19,$01,$25,$27,$04,$1F             ; 0FEA76 ????%'??
.byte $04,$1F,$04,$1F,$06,$1F,$32,$3E             ; 0FEA7E ??????2>
.byte $9F,$9F,$C8,$CB,$E4,$E4,$B0,$F1             ; 0FEA86 ????????
.byte $FA,$FA,$F1,$FD,$DF,$FF,$C1,$F3             ; 0FEA8E ????????
.byte $60,$FF,$36,$FE,$1B,$FF,$0F,$BF             ; 0FEA96 `?6?????
.byte $05,$FF,$0E,$38,$38,$1C,$9C,$90             ; 0FEA9E ???88???
.byte $90,$93,$93,$93,$DB,$3F,$BF,$C4             ; 0FEAA6 ????????
.byte $FC,$60,$7C,$60,$F0,$60,$F3,$28             ; 0FEAAE ?`|`?`?(
.byte $BB,$E0,$FF,$60,$FF,$40,$F8,$08             ; 0FEAB6 ???`?@??
.byte $F8,$08,$F8,$18,$9A,$9A,$9E,$9E             ; 0FEABE ????????
.byte $B6,$B6,$A6,$A6,$A6,$A6,$CE,$CE             ; 0FEAC6 ????????
.byte $01,$9B,$01,$9F,$01,$B7,$11,$B7             ; 0FEACE ????????
.byte $01,$A7,$01,$E3,$CF,$8A,$8A,$AA             ; 0FEAD6 ????????
.byte $AA,$2C,$2C,$64,$64,$24,$24,$A2             ; 0FEADE ?,,dd$$?
.byte $A2,$01,$00,$26,$26,$25,$AF,$45             ; 0FEAE6 ???&&%?E
.byte $EF,$43,$6F,$83,$E7,$83,$A7,$01             ; 0FEAEE ?Co?????
.byte $A3,$27,$19,$11,$0C,$00,$0A,$0C             ; 0FEAF6 ?'??????
.byte $00,$0E,$0A,$07,$06,$1F,$0E,$F1             ; 0FEAFE ????????
.byte $FD,$60,$62,$3F,$3F,$20,$20,$2B             ; 0FEB06 ?`b??  +
.byte $0B,$2B,$03,$CB,$03,$0B,$03,$02             ; 0FEB0E ?+??????
.byte $F3,$9F,$0F,$2F,$2B,$0B,$B3,$B3             ; 0FEB16 ???/+???
.byte $63,$6B,$80,$90,$C0,$C0,$F0,$F0             ; 0FEB1E ck??????
.byte $48,$FB,$98,$FB,$73,$F3,$08,$F8             ; 0FEB26 H???s???
.byte $E0,$E0,$88,$80,$10,$18,$F8,$78             ; 0FEB2E ???????x
.byte $F8,$DA,$DA,$F2,$F2,$01,$DB,$2E             ; 0FEB36 ???????.
.byte $2E,$3E,$3E,$3A,$3A,$22,$22,$22             ; 0FEB3E .>>::"""
.byte $01,$2F,$3B,$23,$23,$04,$04,$02             ; 0FEB46 ?/;##???
.byte $0B,$0B,$03,$0A,$02,$18,$08,$30             ; 0FEB4E ???????0
.byte $C0,$00,$0B,$00,$0B,$00,$30,$40             ; 0FEB56 ??????0@
.byte $00,$BF,$BF,$BF,$FF,$FF,$40,$FF             ; 0FEB5E ??????@?
.byte $FF,$F2,$72,$88,$00,$88,$80,$04             ; 0FEB66 ??r?????
.byte $00,$C4,$0C,$FE,$00,$1C,$1C,$39             ; 0FEB6E ???????9
.byte $80,$C0,$4E,$09,$0B,$CE,$43,$E0             ; 0FEB76 ??N???C?
.byte $78,$24,$1C,$19,$E3,$F1,$53,$8E             ; 0FEB7E x$????S?
.byte $3C,$91,$E1,$83,$74,$15,$83,$80             ; 0FEB86 <???t???
.byte $38,$04,$CC,$00,$25,$37,$C2,$03             ; 0FEB8E 8???%7??
.byte $B8,$20,$0E,$C0,$94,$3D,$02,$17             ; 0FEB96 ? ???=??
.byte $9F,$B3,$34,$61,$C2,$75,$7B,$99             ; 0FEB9E ??4a?u{?
.byte $0E,$28,$71,$88,$38,$1E,$19,$1C             ; 0FEBA6 ?(q?8???
.byte $C4,$71,$14,$39,$C0,$72,$55,$48             ; 0FEBAE ?q?9?rUH
.byte $5E,$A0,$13,$D8,$18,$EC,$01,$78             ; 0FEBB6 ^??????x
.byte $28,$CB,$20,$43,$99,$43,$C0,$B0             ; 0FEBBE (? C?C??
.byte $9E,$74,$3B,$7B,$E1,$6F,$3E,$3D             ; 0FEBC6 ?t;{?o>=
.byte $89,$F8,$96,$49,$07,$33,$0F,$C1             ; 0FEBCE ???I?3??
.byte $17,$24,$09,$FD,$02,$00,$CB,$C2             ; 0FEBD6 ?$??????
.byte $07,$27,$60,$4D,$AF,$25,$1C,$54             ; 0FEBDE ?'`M?%?T
.byte $42,$79,$80,$85,$E6,$F3,$9C,$C9             ; 0FEBE6 By??????
.byte $E7,$AC,$15,$06,$70,$41,$4E,$8E             ; 0FEBEE ????pAN?
.byte $BA,$82,$13,$A6,$43,$A8,$88,$35             ; 0FEBF6 ????C??5
.byte $9B,$AC,$E4,$3A,$C1,$20,$3B,$48             ; 0FEBFE ???:? ;H
.byte $90,$EE,$02,$41,$E9,$F8,$7C,$1E             ; 0FEC06 ???A??|?
.byte $50,$F3,$02,$03,$13,$C0,$3D,$11             ; 0FEC0E P?????=?
.byte $0B,$8D,$E4,$73,$CE,$E3,$1F,$74             ; 0FEC16 ???s???t
.byte $8F,$7A,$80,$0D,$45,$37,$81,$97             ; 0FEC1E ?z??E7??
.byte $D6,$12,$E1,$DB,$8E,$EE,$A4,$24             ; 0FEC26 ???????$
.byte $3D,$D5,$97,$3D,$F2,$21,$30,$A0             ; 0FEC2E =??=?!0?
.byte $52,$00,$DD,$A1,$68,$D6,$74,$73             ; 0FEC36 R???h?ts
.byte $02,$EE,$DF,$39,$C1,$BB,$20,$93             ; 0FEC3E ???9?? ?
.byte $1E,$64,$9C,$10,$0C,$7A,$1C,$4B             ; 0FEC46 ?d???z?K
.byte $81,$74,$FD,$03,$B1,$92,$04,$D7             ; 0FEC4E ?t??????
.byte $9C,$06,$C7,$61,$11,$E4,$ED,$AC             ; 0FEC56 ???a????
.byte $39,$03,$5D,$EE,$A6,$06,$44,$E9             ; 0FEC5E 9?]???D?
.byte $84,$9B,$D9,$C5,$9C,$E7,$85,$C8             ; 0FEC66 ????????
.byte $FE,$E9,$8E,$A1,$F5,$2D,$84,$3A             ; 0FEC6E ?????-?:
.byte $DB,$07,$5A,$D8,$43,$86,$47,$65             ; 0FEC76 ??Z?C?Ge
.byte $08,$0D,$DB,$5D,$1C,$20,$35,$85             ; 0FEC7E ???]? 5?
.byte $98,$B6,$11,$C7,$EC,$A3,$BF,$D9             ; 0FEC86 ????????
.byte $DF,$DB,$08,$71,$41,$08,$1D,$DD             ; 0FEC8E ???qA???
.byte $F0,$C0,$81,$D8,$14,$64,$18,$E3             ; 0FEC96 ?????d??
.byte $B1,$21,$A8,$BB,$A2,$72,$26,$9E             ; 0FEC9E ?!???r&?
.byte $19,$1E,$DA,$C2,$F5,$72,$1D,$60             ; 0FECA6 ?????r?`
.byte $B0,$AF,$46,$53,$D7,$50,$A7,$B4             ; 0FECAE ??FS?P??
.byte $A1,$5D,$BE,$CB,$D9,$50,$B5,$F7             ; 0FECB6 ?]???P??
.byte $27,$C1,$88,$E9,$E1,$CF,$FB,$E0             ; 0FECBE '???????
.byte $3F,$17,$25,$0D,$B7,$F5,$16,$57             ; 0FECC6 ??%????W
.byte $D2,$B0,$3C,$34,$13,$EC,$84,$19             ; 0FECCE ??<4????
.byte $54,$06,$0E,$A2,$7D,$88,$09,$DD             ; 0FECD6 T???}???
.byte $10,$E5,$61,$27,$37,$DF,$84,$02             ; 0FECDE ??a'7???
.byte $7F,$22,$8C,$01,$DF,$C2,$51,$F1             ; 0FECE6 ?"????Q?
.byte $7A,$32,$0E,$EB,$0C,$2A,$E0,$1A             ; 0FECEE z2???*??
.byte $03,$00,$65,$A6,$EA,$59,$00,$E6             ; 0FECF6 ??e??Y??
.byte $1C,$70,$E1,$26,$62,$7C,$45,$B0             ; 0FECFE ?p?&b|E?
.byte $A7,$02,$84,$F1,$6B,$C4,$4C,$8E             ; 0FED06 ????k?L?
.byte $29,$C4,$BB,$7E,$46,$55,$3B,$86             ; 0FED0E )??~FU;?
.byte $C6,$D7,$86,$57,$D7,$1D,$1B,$8B             ; 0FED16 ???W????
.byte $A5,$C7,$2C,$9C,$73,$42,$E3,$7A             ; 0FED1E ??,?sB?z
.byte $48,$6A,$26,$C3,$92,$E9,$82,$32             ; 0FED26 Hj&????2
.byte $CE,$2B,$8C,$0F,$27,$70,$6C,$E2             ; 0FED2E ?+??'pl?
.byte $6E,$F8,$64,$F4,$3A,$A8,$B0,$72             ; 0FED36 n?d?:??r
.byte $C9,$0F,$0A,$0A,$72,$C0,$EB,$58             ; 0FED3E ????r??X
.byte $73,$0A,$5B,$DD,$07,$2E,$82,$42             ; 0FED46 s?[??.?B
.byte $9C,$D9,$1C,$DA,$05,$8B,$AC,$BA             ; 0FED4E ????????
.byte $AC,$C6,$54,$D7,$02,$46,$DA,$E4             ; 0FED56 ??T??F??
.byte $21,$B0,$B1,$2E,$AA,$1C,$AF,$C0             ; 0FED5E !??.????
.byte $E5,$80,$CF,$31,$D0,$F3,$00,$6B             ; 0FED66 ???1???k
.byte $4E,$F2,$6B,$1C,$BA,$A1,$18,$F3             ; 0FED6E N?k?????
.byte $BC,$C7,$12,$F4,$54,$B3,$BB,$D5             ; 0FED76 ????T???
.byte $D1,$C2,$C0,$6B,$63,$06,$4C,$8E             ; 0FED7E ???kc?L?
.byte $D3,$4E,$4E,$E1,$39,$29,$A1,$CB             ; 0FED86 ?NN?9)??
.byte $82,$B3,$D4,$2A,$2E,$B7,$DD,$52             ; 0FED8E ???*.??R
.byte $A0,$F3,$54,$75,$C0,$75,$C0,$9C             ; 0FED96 ??Tu?u??
.byte $D9,$21,$1C,$E5,$6A,$85,$3C,$FE             ; 0FED9E ?!??j?<?
.byte $41,$D3,$51,$D8,$81,$D8,$82,$40             ; 0FEDA6 A?Q????@
.byte $1C,$FC,$04,$26,$4C,$F8,$53,$C8             ; 0FEDAE ???&L?S?
.byte $39,$3F,$8B,$CB,$E2,$6F,$62,$8F             ; 0FEDB6 9????ob?
.byte $6C,$68,$31,$DC,$02,$84,$6D,$AC             ; 0FEDBE lh1???m?
.byte $F7,$80,$F7,$88,$1C,$AC,$8F,$2B             ; 0FEDC6 ???????+
.byte $09,$82,$72,$BD,$68,$02,$4F,$80             ; 0FEDCE ??r?h?O?
.byte $73,$E0,$4F,$5E,$0A,$40,$1D,$8C             ; 0FEDD6 s?O^?@??
.byte $24,$A7,$1E,$A4,$27,$4F,$78,$83             ; 0FEDDE $???'Ox?
.byte $92,$06,$8E,$70,$69,$EB,$69,$B3             ; 0FEDE6 ???pi?i?
.byte $0B,$DF,$58,$43,$E2,$B5,$DF,$DB             ; 0FEDEE ??XC????
.byte $20,$EE,$01,$E5,$C7,$17,$B8,$AE             ; 0FEDF6  ???????
.byte $A6,$A9,$5D,$A8,$77,$62,$24,$06             ; 0FEDFE ??]?wb$?
.byte $AF,$90,$3D,$B7,$AB,$E7,$BA,$C3             ; 0FEE06 ??=?????
.byte $E7,$FA,$39,$CF,$92,$1E,$47,$17             ; 0FEE0E ??9???G?
.byte $99,$93,$C9,$0D,$E4,$EF,$79,$09             ; 0FEE16 ??????y?
.byte $38,$4F,$6A,$9F,$DE,$C8,$D9,$35             ; 0FEE1E 8Oj????5
.byte $74,$3E,$1D,$F2,$09,$1D,$F9,$21             ; 0FEE26 t>?????!
.byte $7A,$BE,$8C,$7A,$E0,$85,$EB,$FA             ; 0FEE2E z??z????
.byte $31,$EC,$82,$13,$E0,$6F,$81,$41             ; 0FEE36 1????o?A
.byte $7B,$8E,$78,$1E,$AC,$1E,$F0,$17             ; 0FEE3E {?x?????
.byte $BC,$B0,$1E,$F8,$1E,$F8,$24,$1B             ; 0FEE46 ??????$?
.byte $D2,$2F,$31,$13,$D1,$BF,$A2,$81             ; 0FEE4E ?/1?????
.byte $6B,$77,$02,$6C,$F2,$DE,$5F,$5D             ; 0FEE56 kw?l??_]
.byte $39,$6E,$FF,$07,$38,$3C,$38,$C1             ; 0FEE5E 9n??8<8?
.byte $EA,$E9,$07,$C2,$CE,$56,$D0,$07             ; 0FEE66 ?????V??
.byte $C7,$0C,$8B,$F2,$B0,$FA,$22,$B3             ; 0FEE6E ??????"?
.byte $92,$5C,$80,$6C,$20,$96,$3C,$83             ; 0FEE76 ?\?l ?<?
.byte $18,$52,$B3,$DD,$68,$4E,$AA,$84             ; 0FEE7E ?R??hN??
.byte $2E,$F7,$61,$3F,$78,$85,$BC,$C0             ; 0FEE86 .?a?x???
.byte $12,$F8,$8F,$07,$20,$70,$FE,$30             ; 0FEE8E ???? p?0
.byte $48,$70,$34,$43,$F3,$A4,$F8,$A8             ; 0FEE96 Hp4C????
.byte $DE,$48,$C3,$9D,$F4,$06,$51,$85             ; 0FEE9E ?H????Q?
.byte $F8,$EC,$3E,$3D,$42,$FF,$11,$39             ; 0FEEA6 ??>=B??9
.byte $44,$B0,$FF,$2F,$08,$7E,$F3,$7E             ; 0FEEAE D??/?~?~
.byte $FB,$69,$E7,$95,$EC,$1D,$F2,$0B             ; 0FEEB6 ?i??????
.byte $3F,$4A,$09,$7B,$9B,$21,$EE,$92             ; 0FEEBE ?J?{?!??
.byte $10,$BC,$01,$49,$78,$08,$1C,$04             ; 0FEEC6 ???Ix???
.byte $82,$31,$5E,$9A,$3F,$60,$77,$6D             ; 0FEECE ?1^??`wm
.byte $16,$91,$18,$C4,$74,$4A,$18,$3D             ; 0FEED6 ????tJ?=
.byte $88,$4D,$FB,$6C,$6F,$30,$CA,$2A             ; 0FEEDE ?M?lo0?*
.byte $24,$01,$B3,$8A,$C9,$B7,$3B,$9C             ; 0FEEE6 $?????;?
.byte $21,$1D,$99,$8E,$E3,$72,$C4,$CC             ; 0FEEEE !????r??
.byte $C0,$B9,$98,$6E,$17,$12,$06,$3B             ; 0FEEF6 ???n???;
.byte $31,$87,$19,$EC,$01,$88,$C8,$97             ; 0FEEFE 1???????
.byte $88,$8D,$BF,$64,$61,$38,$90,$01             ; 0FEF06 ???da8??
.byte $29,$BC,$92,$0C,$E2,$A3,$BC,$F0             ; 0FEF0E )???????
.byte $E2,$A0,$16,$8D,$59,$0E,$04,$6C             ; 0FEF16 ????Y??l
.byte $1A,$2A,$74,$EA,$9C,$3C,$89,$77             ; 0FEF1E ?*t??<?w
.byte $2E,$EE,$F0,$0B,$70,$ED,$88,$C5             ; 0FEF26 .???p???
.byte $85,$E3,$4A,$4B,$C6,$C0,$E3,$64             ; 0FEF2E ??JK???d
.byte $12,$0F,$1D,$39,$31,$38,$01,$09             ; 0FEF36 ???918??
.byte $C7,$C0,$84,$74,$6E,$D9,$06,$F2             ; 0FEF3E ???tn???
.byte $0D,$16,$23,$56,$15,$DA,$3B,$90             ; 0FEF46 ??#V??;?
.byte $FB,$04,$D8,$70,$6D,$E4,$81,$03             ; 0FEF4E ???pm???
.byte $A3,$B1,$87,$1B,$90,$70,$8C,$B8             ; 0FEF56 ?????p??
.byte $46,$1C,$99,$08,$31,$5C,$1C,$1D             ; 0FEF5E F???1\??
.byte $17,$53,$BC,$26,$E2,$42,$32,$39             ; 0FEF66 ?S?&?B29
.byte $1B,$9F,$A4,$1D,$EE,$E4,$72,$90             ; 0FEF6E ??????r?
.byte $CC,$E0,$6C,$57,$87,$96,$09,$21             ; 0FEF76 ??lW???!
.byte $C5,$77,$96,$91,$08,$E3,$BB,$61             ; 0FEF7E ?w?????a
.byte $E1,$EB,$02,$EF,$65,$C7,$A0,$10             ; 0FEF86 ????e???
.byte $F1,$13,$B1,$AF,$92,$1C,$99,$86             ; 0FEF8E ????????
.byte $53,$66,$7A,$46,$9D,$72,$DA,$96             ; 0FEF96 SfzF?r??
.byte $EB,$EC,$49,$D9,$C9,$C4,$7C,$75             ; 0FEF9E ??I???|u
.byte $F0,$A3,$27,$38,$22,$17,$9C,$89             ; 0FEFA6 ??'8"???
.byte $CE,$54,$90,$E3,$CF,$2B,$CD,$78             ; 0FEFAE ?T???+?x
.byte $B0,$A9,$A1,$18,$15,$50,$8E,$78             ; 0FEFB6 ?????P?x
.byte $08,$47,$3D,$04,$23,$93,$64,$8E             ; 0FEFBE ?G=?#?d?
.byte $E3,$C2,$10,$E8,$48,$41,$B2,$F8             ; 0FEFC6 ????HA??
.byte $D1,$E2,$92,$F2,$AD,$D6,$02,$72             ; 0FEFCE ???????r
.byte $AE,$E7,$9B,$AE,$8D,$09,$1C,$AB             ; 0FEFD6 ????????
.byte $72,$3C,$FE,$D9,$36,$AD,$04,$0E             ; 0FEFDE r<??6???
.byte $45,$D8,$13,$A1,$CF,$40,$D8,$73             ; 0FEFE6 E????@?s
.byte $0C,$D9,$13,$BA,$0E,$10,$06,$9F             ; 0FEFEE ????????
.byte $22,$43,$14,$20,$10,$6E,$91,$47             ; 0FEFF6 "C? ?n?G
.byte $5B,$E8,$B3,$BD,$77,$A7,$80,$A4             ; 0FEFFE [???w???
.byte $38,$BD,$FA,$88,$29,$03,$D5,$14             ; 0FF006 8???)???
.byte $EA,$93,$67,$D9,$27,$AA,$A1,$D5             ; 0FF00E ??g?'???
.byte $60,$EA,$3C,$5A,$E9,$11,$EA,$24             ; 0FF016 `?<Z???$
.byte $A6,$69,$83,$AB,$42,$25,$D6,$15             ; 0FF01E ?i??B%??
.byte $46,$EB,$4A,$A3,$75,$C5,$51,$BA             ; 0FF026 F?J?u?Q?
.byte $F2,$A8,$DD,$81,$54,$6E,$C4,$AA             ; 0FF02E ????Tn??
.byte $37,$64,$54,$1B,$83,$7D,$C1,$C8             ; 0FF036 7dT??}??
.byte $4C,$20,$46,$B7,$14,$1E,$D2,$8A             ; 0FF03E L F?????
.byte $41,$DB,$00,$BB,$60,$8F,$39,$20             ; 0FF046 A???`?9 
.byte $7B,$6A,$BB,$6C,$10,$CB,$6D,$DA             ; 0FF04E {j?l??m?
.byte $CC,$5B,$B5,$FB,$DB,$21,$3B,$81             ; 0FF056 ?[???!;?
.byte $1D,$B4,$14,$84,$C7,$64,$31,$D8             ; 0FF05E ?????d1?
.byte $8E,$7B,$73,$8C,$38,$94,$99,$7B             ; 0FF066 ?{s?8??{
.byte $7E,$DB,$66,$46,$ED,$1A,$40,$6A             ; 0FF06E ~?fF??@j
.byte $82,$8C,$46,$91,$D8,$0E,$7B,$AE             ; 0FF076 ??F???{?
.byte $E8,$6F,$24,$79,$0E,$19,$35,$6C             ; 0FF07E ?o$y??5l
.byte $A6,$57,$2B,$AD,$12,$1D,$DF,$58             ; 0FF086 ?W+????X
.byte $4C,$3B,$C1,$8B,$3C,$87,$BC,$FB             ; 0FF08E L;??<???
.byte $0B,$C6,$68,$EA,$1B,$3D,$4A,$6E             ; 0FF096 ??h??=Jn
.byte $4E,$4C,$06,$7A,$02,$37,$C1,$47             ; 0FF09E NL?z?7?G
.byte $73,$7B,$35,$D9,$DD,$67,$BE,$01             ; 0FF0A6 s{5??g??
.byte $21,$C8,$E3,$08,$0D,$DF,$6E,$70             ; 0FF0AE !?????np
.byte $60,$F7,$BE,$08,$4E,$F9,$C1,$0F             ; 0FF0B6 `???N???
.byte $81,$3B,$14,$E1,$2E,$8D,$08,$0D             ; 0FF0BE ?;??.???
.byte $AA,$FD,$71,$09,$ED,$D2,$30,$9E             ; 0FF0C6 ??q???0?
.byte $0B,$8B,$24,$94,$9A,$33,$7C,$2E             ; 0FF0CE ??$??3|.
.byte $B0,$77,$E6,$0E,$F5,$C1,$6D,$59             ; 0FF0D6 ?w????mY
.byte $EF,$EC,$1E,$20,$08,$DF,$04,$77             ; 0FF0DE ??? ???w
.byte $6E,$BC,$45,$31,$D3,$95,$E0,$F6             ; 0FF0E6 n?E1????
.byte $E8,$70,$21,$7B,$C6,$13,$E1,$6E             ; 0FF0EE ?p!{???n
.byte $F0,$6B,$77,$9B,$61,$F1,$C2,$78             ; 0FF0F6 ?kw?a??x
.byte $E1,$1E,$E2,$0A,$63,$56,$06,$0E             ; 0FF0FE ????cV??
.byte $BC,$82,$5A,$3E,$B0,$DB,$07,$92             ; 0FF106 ??Z>????
.byte $06,$0C,$AB,$58,$A0,$C0,$F2,$55             ; 0FF10E ???X???U
.byte $67,$5C,$06,$0E,$D4,$42,$47,$4D             ; 0FF116 g\???BGM
.byte $EE,$7E,$20,$C1,$E5,$38,$48,$39             ; 0FF11E ?~ ??8H9
.byte $B7,$8B,$3E,$5B,$84,$83,$CB,$F0             ; 0FF126 ??>[????
.byte $90,$79,$8E,$12,$0F,$33,$C2,$79             ; 0FF12E ?y???3?y
.byte $2A,$71,$40,$89,$E7,$2B,$CD,$F0             ; 0FF136 *q@??+??
.byte $90,$79,$AE,$43,$51,$B3,$CD,$CC             ; 0FF13E ?y?CQ???
.byte $5C,$B4,$C1,$DB,$8C,$4B,$C7,$6C             ; 0FF146 \????K?l
.byte $87,$8F,$C2,$50,$F1,$B3,$C2,$66             ; 0FF14E ???P???f
.byte $07,$AC,$24,$3D,$36,$F2,$DB,$F4             ; 0FF156 ??$=6???
.byte $46,$D6,$FA,$09,$73,$6A,$4D,$98             ; 0FF15E F???sjM?
.byte $21,$E9,$CD,$5B,$D4,$2A,$8D,$EA             ; 0FF166 !??[?*??
.byte $95,$46,$F5,$8A,$A3,$7A,$E5,$51             ; 0FF16E ?F???z?Q
.byte $BD,$82,$A8,$F1,$1E,$4F,$65,$82             ; 0FF176 ?????Oe?
.byte $97,$B4,$54,$19,$0E,$6D,$07,$B8             ; 0FF17E ??T??m??
.byte $D9,$E0,$42,$1D,$F6,$CF,$41,$B1             ; 0FF186 ??B???A?
.byte $E2,$1B,$3F,$54,$39,$A6,$DD,$4F             ; 0FF18E ???T9??O
.byte $4C,$87,$BC,$02,$4F,$1E,$80,$C2             ; 0FF196 L???O???
.byte $3C,$24,$A1,$E5,$20,$41,$AC,$10             ; 0FF19E <$?? A??
.byte $B9,$C4,$46,$CB,$12,$D6,$BE,$A3             ; 0FF1A6 ??F?????
.byte $A1,$38,$03,$E1,$22,$C7,$06,$2E             ; 0FF1AE ?8??"??.
.byte $87,$27,$91,$54,$D3,$A4,$46,$B2             ; 0FF1B6 ?'?T??F?
.byte $28,$57,$20,$7B,$DA,$4D,$6F,$0E             ; 0FF1BE (W {?Mo?
.byte $37,$43,$03,$E1,$8A,$30,$06,$FB             ; 0FF1C6 7C???0??
.byte $68,$78,$5A,$1C,$27,$0C,$76,$49             ; 0FF1CE hxZ?'?vI
.byte $01,$C9,$D0,$19,$CA,$FD,$F0,$84             ; 0FF1D6 ????????
.byte $5D,$41,$2F,$C9,$31,$63,$DE,$51             ; 0FF1DE ]A/?1c?Q
.byte $27,$D0,$08,$E3,$2B,$F4,$43,$7F             ; 0FF1E6 '???+?C?
.byte $AA,$C8,$60,$B3,$39,$5C,$3C,$AE             ; 0FF1EE ??`?9\<?
.byte $CF,$76,$27,$9D,$72,$32,$86,$F1             ; 0FF1F6 ?v'?r2??
.byte $E3,$0F,$A7,$23,$F0,$B4,$07,$E2             ; 0FF1FE ???#????
.byte $C1,$0F,$C8,$E1,$FA,$CC,$C8,$9C             ; 0FF206 ????????
.byte $C4,$59,$4F,$A9,$36,$F7,$13,$EC             ; 0FF20E ?YO?6???
.byte $B0,$59,$BC,$27,$ED,$0E,$8F,$7F             ; 0FF216 ?Y?'????
.byte $73,$0E,$00,$81,$4C,$AF,$BB,$92             ; 0FF21E s???L???
.byte $F5,$DD,$30,$72,$71,$13,$EF,$B3             ; 0FF226 ??0rq???
.byte $2B,$E9,$9E,$3E,$5C,$7C,$4F,$58             ; 0FF22E +??>\|OX
.byte $0C,$B1,$37,$13,$C3,$ED,$44,$3F             ; 0FF236 ??7???D?
.byte $0A,$CC,$E0,$04,$81,$CC,$80,$DA             ; 0FF23E ????????
.byte $98,$1F,$51,$86,$0C,$4F,$A0,$F4             ; 0FF246 ??Q??O??
.byte $11,$E8,$2D,$7C,$0F,$16,$D8,$B5             ; 0FF24E ??-|????
.byte $F7,$CC,$5F,$7E,$78,$F8,$82,$13             ; 0FF256 ??_~x???
.byte $91,$D0,$FA,$05,$5B,$E8,$4B,$7E             ; 0FF25E ????[?K~
.byte $C3,$3F,$63,$C6,$DD,$05,$31,$D4             ; 0FF266 ??c???1?
.byte $65,$57,$81,$C5,$9E,$3F,$BC,$EF             ; 0FF26E eW??????
.byte $1A,$BF,$BE,$71,$51,$3F,$5C,$99             ; 0FF276 ???qQ?\?
.byte $3E,$F8,$0E,$2A,$53,$E2,$DC,$09             ; 0FF27E >??*S???
.byte $FB,$F8,$90,$F6,$F0,$BA,$10,$6D             ; 0FF286 ???????m
.byte $AF,$BF,$D0,$00,$FE,$91,$8C,$EE             ; 0FF28E ????????
.byte $00,$D8,$68,$41,$FA,$E1,$21,$E7             ; 0FF296 ??hA??!?
.byte $4F,$03,$FD,$F6,$43,$44,$C1,$89             ; 0FF29E O???CD??
.byte $84,$7F,$D2,$B9,$FE,$8F,$F4,$62             ; 0FF2A6 ???????b
.byte $41,$F8,$54,$FB,$DE,$AF,$D5,$F4             ; 0FF2AE A?T?????
.byte $FC,$1B,$C9,$37,$FF,$0C,$9F,$F4             ; 0FF2B6 ???7????
.byte $14,$DE,$2C,$34,$4E,$88,$E0,$00             ; 0FF2BE ??,4N???
.byte $0D,$E3,$C3,$32,$F4,$B7,$8E,$D9             ; 0FF2C6 ???2????
.byte $C8,$B3,$80,$C2,$8B,$34,$C4,$82             ; 0FF2CE ?????4??
.byte $72,$9A,$6E,$02,$1C,$A4,$90,$38             ; 0FF2D6 r?n????8
.byte $11,$0B,$7F,$29,$77,$C0,$C6,$36             ; 0FF2DE ???)w??6
.byte $1D,$65,$4D,$7C,$C3,$35,$79,$DC             ; 0FF2E6 ?eM|?5y?
.byte $3D,$6C,$18,$57,$07,$E0,$38,$26             ; 0FF2EE =l?W??8&
.byte $09,$1D,$DE,$38,$77,$B7,$67,$15             ; 0FF2F6 ???8w?g?
.byte $CA,$57,$83,$26,$71,$1F,$60,$E0             ; 0FF2FE ?W?&q?`?
.byte $D7,$E0,$DA,$93,$77,$1B,$81,$3C             ; 0FF306 ????w??<
.byte $64,$C3,$C1,$78,$3D,$C8,$32,$21             ; 0FF30E d??x=?2!
.byte $B3,$55,$A0,$E1,$0A,$83,$79,$FB             ; 0FF316 ?U????y?
.byte $79,$F0,$E1,$09,$64,$03,$66,$A2             ; 0FF31E y???d?f?
.byte $04,$37,$1E,$61,$DD,$2E,$DF,$A4             ; 0FF326 ?7?a?.??
.byte $13,$86,$04,$5D,$E6,$99,$DD,$C0             ; 0FF32E ???]????
.byte $30,$01,$50,$78,$03,$0D,$12,$EE             ; 0FF336 0?Px????
.byte $1B,$75,$E0,$1C,$37,$85,$D7,$86             ; 0FF33E ?u??7???
.byte $D4,$1C,$7F,$CB,$35,$64,$78,$78             ; 0FF346 ????5dxx
.byte $C6,$E1,$F8,$CA,$73,$DF,$CA,$47             ; 0FF34E ????s??G
.byte $4B,$53,$88,$0C,$58,$00,$D3,$5A             ; 0FF356 KS??X??Z
.byte $4C,$14,$40,$78,$25,$C7,$89,$2C             ; 0FF35E L?@x%??,
.byte $2D,$4D,$9B,$86,$33,$2F,$B8,$0D             ; 0FF366 -M??3/??
.byte $E6,$83,$89,$58,$0E,$0C,$C2,$DF             ; 0FF36E ???X????
.byte $FD,$78,$9E,$83,$83,$68,$38,$A2             ; 0FF376 ?x???h8?
.byte $37,$3B,$93,$83,$ED,$DD,$5C,$13             ; 0FF37E 7;????\?
.byte $8A,$89,$08,$38,$47,$0E,$2B,$85             ; 0FF386 ???8G?+?
.byte $36,$74,$96,$03,$12,$3F,$80,$F0             ; 0FF38E 6t??????
.byte $85,$CA,$69,$65,$C3,$66,$9D,$91             ; 0FF396 ??ie?f??
.byte $F9,$34,$C8,$8E,$24,$00,$C3,$10             ; 0FF39E ?4??$???
.byte $0E,$32,$22,$E2,$71,$97,$8C,$C4             ; 0FF3A6 ?2"?q???
.byte $8E,$00,$58,$13,$62,$A0,$91,$DB             ; 0FF3AE ??X?b???
.byte $BB,$B8,$7B,$20,$35,$DD,$78,$9F             ; 0FF3B6 ??{ 5?x?
.byte $A7,$80,$2E,$5C,$B9,$F1,$63,$8E             ; 0FF3BE ??.\??c?
.byte $09,$0C,$1F,$B0,$B6,$24,$E4,$E2             ; 0FF3C6 ?????$??
.byte $50,$08,$0C,$5B,$23,$41,$C4,$5D             ; 0FF3CE P??[#A?]
.byte $FC,$A1,$0E,$3C,$D8,$0E,$04,$00             ; 0FF3D6 ???<????
.byte $21,$E3,$CF,$18,$4E,$2C,$85,$87             ; 0FF3DE !???N,??
.byte $0A,$39,$0E,$32,$DD,$C0,$F4,$60             ; 0FF3E6 ?9?2???`
.byte $DF,$58,$38,$80,$00,$E2,$EC,$39             ; 0FF3EE ?X8????9
.byte $10,$0D,$E1,$85,$93,$14,$51,$76             ; 0FF3F6 ??????Qv
.byte $59,$06,$E1,$A8,$14,$C6,$3A,$0E             ; 0FF3FE Y?????:?
.byte $48,$60,$24,$38,$70,$08,$1D,$F9             ; 0FF406 H`$8p???
.byte $78,$4D,$E2,$FB,$87,$E0,$24,$E2             ; 0FF40E xM????$?
.byte $87,$E3,$3B,$83,$91,$1C,$38,$68             ; 0FF416 ??;???8h
.byte $C0,$79,$39,$86,$43,$48,$12,$00             ; 0FF41E ?y9?CH??
.byte $D8,$5C,$0D,$F5,$40,$83,$5B,$7C             ; 0FF426 ?\??@?[|
.byte $1B,$63,$4E,$E2,$0F,$94,$E1,$CE             ; 0FF42E ?cN?????
.byte $2D,$2B,$0B,$61,$54,$87,$42,$CA             ; 0FF436 -+?aT?B?
.byte $4D,$E6,$59,$1C,$54,$72,$41,$36             ; 0FF43E M?Y?TrA6
.byte $36,$ED,$20,$28,$0E,$27,$C6,$17             ; 0FF446 6? (?'??
.byte $92,$28,$75,$EC,$E1,$E4,$0F,$5E             ; 0FF44E ?(u????^
.byte $41,$46,$37,$3B,$91,$DE,$64,$87             ; 0FF456 AF7;??d?
.byte $7E,$CB,$97,$DC,$6E,$60,$14,$65             ; 0FF45E ~???n`?e
.byte $E6,$24,$E5,$1E,$0B,$94,$76,$79             ; 0FF466 ?$????vy
.byte $8D,$39,$47,$81,$E5,$36,$08,$79             ; 0FF46E ?9G??6?y
.byte $3B,$50,$B9,$11,$65,$E4,$C9,$9D             ; 0FF476 ;P??e???
.byte $A0,$FD,$F3,$2C,$D3,$9B,$97,$F6             ; 0FF47E ???,????
.byte $0E,$11,$9E,$66,$B8,$4D,$E6,$02             ; 0FF486 ???f?M??
.byte $41,$31,$D4,$27,$8F,$F6,$01,$5D             ; 0FF48E A1?'???]
.byte $0D,$29,$79,$23,$02,$13,$97,$01             ; 0FF496 ?)y#????
.byte $DC,$DA,$93,$5E,$4F,$86,$E5,$24             ; 0FF49E ???^O??$
.byte $E4,$2F,$06,$1E,$73,$F5,$E7,$22             ; 0FF4A6 ?/??s??"
.byte $87,$97,$C9,$08,$E5,$F1,$42,$E4             ; 0FF4AE ??????B?
.byte $77,$46,$E4,$EA,$46,$E7,$8F,$46             ; 0FF4B6 wF??F??F
.byte $0D,$E7,$E2,$47,$83,$42,$54,$3A             ; 0FF4BE ???G?BT:
.byte $00,$A1,$0E,$77,$B8,$01,$E4,$9E             ; 0FF4C6 ???w????
.byte $80,$03,$0F,$26,$00,$75,$D8,$60             ; 0FF4CE ???&?u?`
.byte $47,$74,$B2,$47,$1C,$08,$83,$80             ; 0FF4D6 Gt?G????
.byte $B3,$83,$4E,$CF,$B2,$80,$E3,$25             ; 0FF4DE ??N????%
.byte $24,$E2,$86,$8E,$32,$46,$1D,$7B             ; 0FF4E6 $???2F?{
.byte $C9,$1C,$C7,$FE,$92,$0E,$01,$79             ; 0FF4EE ???????y
.byte $3A,$45,$A1,$DC,$03,$80,$38,$EC             ; 0FF4F6 :E????8?
.byte $A1,$07,$62,$D5,$BA,$61,$E0,$1E             ; 0FF4FE ??b??a??
.byte $39,$31,$DE,$5E,$97,$89,$29,$64             ; 0FF506 91?^??)d
.byte $E7,$6F,$18,$1D,$58,$44,$B8,$18             ; 0FF50E ?o??XD??
.byte $58,$D7,$7C,$E2,$68,$20,$31,$6D             ; 0FF516 X?|?h 1m
.byte $8E,$27,$82,$75,$25,$74,$35,$20             ; 0FF51E ?'?u%t5 
.byte $13,$15,$BA,$43,$06,$E8,$8E,$A1             ; 0FF526 ???C????
.byte $8B,$A8,$CA,$39,$CB,$D8,$0E,$22             ; 0FF52E ???9???"
.byte $C3,$89,$C0,$3A,$4F,$B0,$C7,$08             ; 0FF536 ???:O???
.byte $1C,$37,$C3,$A9,$88,$80,$DF,$E4             ; 0FF53E ?7??????
.byte $3A,$9C,$9B,$A8,$80,$90,$EA,$30             ; 0FF546 :??????0
.byte $6E,$A3,$69,$7A,$78,$0D,$F1,$A0             ; 0FF54E n?izx???
.byte $D4,$6D,$8D,$3E,$FE,$9F,$2B,$99             ; 0FF556 ?m?>??+?
.byte $CE,$EA,$B2,$81,$E8,$EB,$85,$35             ; 0FF55E ???????5
.byte $37,$FA,$A4,$25,$E3,$0C,$3A,$AC             ; 0FF566 7??%??:?
.byte $08,$3A,$4C,$ED,$4A,$A3,$AB,$80             ; 0FF56E ?:L?J???
.byte $84,$DC,$7D,$19,$34,$AD,$CD,$24             ; 0FF576 ??}?4??$
.byte $E8,$3A,$AB,$0E,$AA,$C0,$C1,$84             ; 0FF57E ?:??????
.byte $6E,$AB,$C3,$AC,$D8,$8E,$A4,$C2             ; 0FF586 n???????
.byte $13,$78,$BB,$A9,$76,$4E,$53,$D8             ; 0FF58E ?x??vNS?
.byte $17,$A9,$FA,$17,$49,$34,$EA,$82             ; 0FF596 ????I4??
.byte $21,$3A,$A4,$02,$13,$4F,$AD,$80             ; 0FF59E !:???O??
.byte $D1,$7F,$7A,$AE,$99,$EA,$FA,$D4             ; 0FF5A6 ??z?????
.byte $0B,$EB,$A0,$20,$3A,$C3,$16,$C2             ; 0FF5AE ??? :???
.byte $D9,$9E,$B1,$C2,$00,$38,$AA,$10             ; 0FF5B6 ?????8??
.byte $B5,$D5,$03,$81,$5C,$DF,$C8,$2D             ; 0FF5BE ????\??-
.byte $75,$31,$83,$93,$5D,$C8,$DC,$37             ; 0FF5C6 u1??]??7
.byte $7F,$18,$3B,$0D,$E1,$04,$CC,$99             ; 0FF5CE ??;?????
.byte $B5,$60,$E0,$53,$A5,$6A,$13,$35             ; 0FF5D6 ?`?S?j?5
.byte $18,$80,$76,$83,$C7,$80,$08,$35             ; 0FF5DE ??v????5
.byte $05,$F9,$7B,$D2,$4E,$CF,$98,$4E             ; 0FF5E6 ??{?N??N
.byte $B6,$A2,$53,$AD,$F2,$51,$EB,$90             ; 0FF5EE ??S??Q??
.byte $93,$98,$8A,$1E,$62,$78,$D1,$7A             ; 0FF5F6 ????bx?z
.byte $31,$C4,$1B,$63,$64,$81,$76,$9B             ; 0FF5FE 1??cd?v?
.byte $23,$3F,$42,$D8,$51,$81,$EC,$E6             ; 0FF606 #?B?Q???
.byte $08,$0D,$E6,$CE,$CF,$76,$5E,$41             ; 0FF60E ?????v^A
.byte $E0,$60,$EC,$2E,$4E,$DB,$82,$0E             ; 0FF616 ?`?.N???
.byte $A0,$83,$A9,$A1,$23,$AA,$63,$A8             ; 0FF61E ????#?c?
.byte $67,$A9,$E1,$24,$ED,$C2,$27,$B7             ; 0FF626 g??$??'?
.byte $AA,$3A,$A7,$2E,$DD,$26,$EA,$94             ; 0FF62E ?:?.?&??
.byte $8E,$5B,$1E,$E0,$08,$EC,$07,$76             ; 0FF636 ?[?????v
.byte $15,$DE,$E0,$00,$EE,$08,$E4,$46             ; 0FF63E ???????F
.byte $2E,$D6,$D9,$77,$50,$09,$32,$29             ; 0FF646 .??wP?2)
.byte $7A,$ED,$2D,$D3,$03,$B3,$A8,$DD             ; 0FF64E z?-?????
.byte $AD,$ED,$A5,$5E,$CF,$A3,$B6,$CF             ; 0FF656 ???^????
.byte $B6,$D5,$60,$E4,$92,$0B,$7C,$FD             ; 0FF65E ??`???|?
.byte $83,$02,$A7,$2D,$08,$B2,$D0,$83             ; 0FF666 ???-????
.byte $90,$58,$81,$E5,$E6,$19,$EE,$88             ; 0FF66E ?X??????
.byte $EE,$16,$EE,$8E,$EB,$A2,$02,$3A             ; 0FF676 ???????:
.byte $EB,$91,$CD,$7E,$EE,$A0,$39,$24             ; 0FF67E ???~??9$
.byte $00,$EE,$AE,$1C,$C5,$50,$EE,$CA             ; 0FF686 ?????P??
.byte $60,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF68E `???????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF696 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF69E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF6A6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF6AE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF6B6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF6BE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF6C6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF6CE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF6D6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF6DE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF6E6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF6EE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF6F6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF6FE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF706 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF70E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF716 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF71E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF726 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF72E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF736 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF73E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF746 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF74E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF756 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF75E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF766 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF76E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF776 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF77E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF786 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF78E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF796 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF79E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF7A6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF7AE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF7B6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF7BE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF7C6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF7CE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF7D6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF7DE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF7E6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF7EE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF7F6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF7FE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF806 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF80E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF816 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF81E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF826 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF82E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF836 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF83E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF846 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF84E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF856 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF85E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF866 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF86E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF876 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF87E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF886 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF88E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF896 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF89E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF8A6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF8AE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF8B6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF8BE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF8C6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF8CE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF8D6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF8DE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF8E6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF8EE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF8F6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF8FE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF906 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF90E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF916 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF91E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF926 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF92E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF936 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF93E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF946 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF94E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF956 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF95E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF966 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF96E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF976 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF97E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF986 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF98E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF996 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF99E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF9A6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF9AE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF9B6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF9BE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF9C6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF9CE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF9D6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF9DE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF9E6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF9EE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF9F6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FF9FE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA06 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA0E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA16 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA1E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA26 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA2E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA36 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA3E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA46 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA4E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA56 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA5E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA66 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA6E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA76 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA7E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA86 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA8E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA96 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFA9E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFAA6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFAAE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFAB6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFABE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFAC6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFACE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFAD6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFADE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFAE6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFAEE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFAF6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFAFE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB06 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB0E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB16 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB1E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB26 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB2E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB36 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB3E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB46 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB4E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB56 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB5E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB66 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB6E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB76 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB7E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB86 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB8E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB96 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFB9E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFBA6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFBAE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFBB6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFBBE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFBC6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFBCE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFBD6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFBDE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFBE6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFBEE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFBF6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFBFE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC06 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC0E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC16 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC1E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC26 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC2E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC36 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC3E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC46 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC4E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC56 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC5E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC66 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC6E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC76 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC7E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC86 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC8E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC96 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFC9E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFCA6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFCAE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFCB6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFCBE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFCC6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFCCE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFCD6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFCDE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFCE6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFCEE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFCF6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFCFE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD06 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD0E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD16 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD1E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD26 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD2E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD36 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD3E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD46 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD4E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD56 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD5E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD66 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD6E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD76 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD7E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD86 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD8E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD96 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFD9E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFDA6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFDAE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFDB6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFDBE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFDC6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFDCE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFDD6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFDDE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFDE6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFDEE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFDF6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFDFE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE06 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE0E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE16 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE1E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE26 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE2E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE36 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE3E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE46 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE4E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE56 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE5E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE66 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE6E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE76 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE7E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE86 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE8E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE96 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFE9E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFEA6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFEAE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFEB6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFEBE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFEC6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFECE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFED6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFEDE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFEE6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFEEE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFEF6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFEFE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF06 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF0E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF16 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF1E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF26 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF2E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF36 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF3E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF46 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF4E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF56 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF5E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF66 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF6E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF76 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF7E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF86 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF8E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF96 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFF9E ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFFA6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFFAE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFFB6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFFBE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFFC6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFFCE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFFD6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFFDE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFFE6 ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFFEE ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 0FFFF6 ????????
.byte $FF,$FF                                     ; 0FFFFF ??
