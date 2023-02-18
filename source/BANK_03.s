.BANK 3
.ORG 0


ClearAllEntities:
  php                                             ; push processor state
  sep #P_Idx8Bit | P_Acc8Bit                      ; set new processor state
  ldx #MaxEntities-1                              ; load offset to final entity
-:
  stz EntityHeader,X                              ; clear a bunch of entity flags
  stz EntityTypeId,X                              ; 
  stz EntityV2,X                                  ; 
  stz EntityV3,X                                  ; 
  stz EntityXSubPxSpeed,X                                  ; 
  stz EntityXPxSpeed,X                                  ; 
  stz EntityYSubPxSpeed,X                                  ; 
  stz EntityYPxSpeed,X                                  ; 
  stz EntityXSubPx,X                              ; 
  stz EntityXPx,X                                 ; 
  stz EntityXMovement,X                                 ; 
  stz EntityYSubPx,X                              ; 
  stz EntityYPx,X                                 ; 
  stz EntityYMovement,X                                 ; 
  stz EntityV19,X                                 ; 
  dex                                             ; advance to next entity
  bpl -                                           ; and continue looping through each entity
  jsl L_3803B                                     ; clear some more state
  plp                                             ; restore processor state
  rtl                                             ; and exit

L_3803B:
  PHP                                             ; 03803B 08 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 03803C E2 30 
  LDX.B #$09                                      ; 03803E A2 09 
B_38040:
  LDA.L D_3804F,X                                 ; 038040 BF 4F 80 03 
  STA.W $1868,X                                   ; 038044 9D 68 18 
  STZ.W $185E,X                                   ; 038047 9E 5E 18 
  DEX                                             ; 03804A CA 
  BPL.B B_38040                                   ; 03804B 10 F3 
  PLP                                             ; 03804D 28 
  RTL                                             ; 03804E 6B 

D_3804F:
.byte $03,$02,$01,$01,$01,$03,$01,$01             ; 03804F DDDDDDDD ????????
.byte $02,$01                                     ; 038058 DD       ??


L_38059:
  LDY.B #$02                                      ; 038059 A0 02 
B_3805B:
  LDA.W $1AAF,Y                                   ; 03805B B9 AF 1A 
  BEQ.B B_38063                                   ; 03805E F0 03 
  DEY                                             ; 038060 88 
  BPL.B B_3805B                                   ; 038061 10 F8 
B_38063:
  RTL                                             ; 038063 6B 

L_38064:
  LDY.B #$03                                      ; 038064 A0 03 
B_38066:
  CMP.W $18C1,Y                                   ; 038066 D9 C1 18 
  BEQ.B B_3807A                                   ; 038069 F0 0F 
  DEY                                             ; 03806B 88 
  BPL.B B_38066                                   ; 03806C 10 F8 
  XBA                                             ; 03806E EB 
  LDY.B #$03                                      ; 03806F A0 03 
B_38071:
  LDA.W $18C9,Y                                   ; 038071 B9 C9 18 
  BEQ.B B_38084                                   ; 038074 F0 0E 
  DEY                                             ; 038076 88 
  BPL.B B_38071                                   ; 038077 10 F8 

.byte $6B                                         ; 03807A .        k

B_3807A:
  LDA.W $18C5,Y                                   ; 03807A B9 C5 18 
  INC A
  STA.W $18C5,Y                                   ; 03807E 99 C5 18 
  LDA.B #$00                                      ; 038081 A9 00 
  RTL                                             ; 038083 6B 
B_38084:
  XBA                                             ; 038084 EB 
  STA.W $18C1,Y                                   ; 038085 99 C1 18 
  LDA.B #$01                                      ; 038088 A9 01 
  STA.W $18C9,Y                                   ; 03808A 99 C9 18 
  STA.W $18CD,Y                                   ; 03808D 99 CD 18 
  STA.W $18C5,Y                                   ; 038090 99 C5 18 
  RTL                                             ; 038093 6B 

ClearEntitySlotData:
  php                                             ; store away processor state and switch to 8 bit mode
  sep #P_Idx8Bit | P_Acc8Bit                      ;
  stz EntityXSubPxSpeed,X                                  ; clear out a bunch of entity data
  stz EntityXPxSpeed,X                                  ; ...
  stz EntityYSubPxSpeed,X                                  ; ...
  stz EntityYPxSpeed,X                                  ; ...
  stz EntityXSubPx,X                              ; ...
  stz EntityYSubPx,X                              ; ...
  stz EntityV2,X                                  ; ...
  stz EntityV3,X                                  ; ...
  stz EntityV4,X                                  ; ...
  stz EntityV29,X                                 ; ...
  stz EntityV30,X                                 ; ...
  stz EntityV25,X                                 ; ...
  stz EntityV15,X                                 ; ...
  stz EntityV16,X                                 ; ...
  stz EntityV17,X                                 ; ...
  stz EntityV20,X                                 ; ...
  stz EntityV21,X                                 ; ...
  stz EntityV22,X                                 ; ...
  stz EntityV23,X                                 ; ...
  stz EntityV24,X                                 ; ...
  stz EntityV19,X                                 ; ...
  stz EntityV32,X                                 ; ...
  stz EntityV33,X                                 ; ...
  stz EntityV34,X                                 ; ...
  stz EntityV35,X                                 ; ...
  plp                                             ; restore initial processor state
  rtl                                             ; and exit

FindEmptyProjectileSlot:
  ldx #Projectiles                                ; get starting offset for projectiles
@Next:
  lda EntityHeader,X                              ; is this projectile slot available?
  beq @Found                                      ; yes - branch ahead
  inx                                             ; no - advance to next
  cpx #MaxEntities                                ; check if we're at the end of the entity list
  bne @Next                                       ; no - check next slot
  lda #1                                          ; yes - lda 1 to mark failure
@Found:
  rtl                                             ; and exit

FindEmptyEntitySlot:
  ldx #2                                          ; get starting offset for enemies (after 2 players)
@Next:
  lda EntityHeader,X                              ; is this entity slot available?
  beq @Found                                      ; yes - branch ahead
  inx                                             ; no - advance to next
  cpx #62                                         ; are we past the end of the list?
  bne @Next                                       ; no - continue loop
  lda #1                                          ; yes - lda 1 to mark failure
@Found:
  rtl                                             ; and exit

FindEmptyEntitySlot2:
  ldx #2                                          ; get starting offset for enemies (after 2 players)
@Next:
  lda EntityHeader,X                              ; is this entity slot available?
  beq @Found                                      ; yes - branch ahead
  inx                                             ; no - advance to next
  cpx #66                                         ; are we past the end of the list?
  bne @Next                                       ; no - continue loop
  lda #1                                          ; yes - lda 1 to mark failure
@Found:
  rtl                                             ; and exit

.byte $A2,$41,$BD,$D2,$06,$F0,$05,$CA             ; 038111 ........ ?A??????
.byte $10,$F8,$A9,$01,$6B                         ; 03811A .....    ????k


GameRunActiveEntities:
  php                                             ; set up processor state
  phb                                             ;
  sep #P_Idx8Bit | P_Acc8Bit                      ;
  lda #$03                                        ; set data bank
  pha                                             ;
  plb                                             ;
  jsr RunSharedEntityMovement                     ; run through some basic movement code for each entity
  ldx #$71                                        ; select last possible entity
ProcessNextEntity:
  @TmpIndirectJump = $04
  lda EntityHeader,X                              ; check if entity is active
  beq AdvanceToNextEntity2                        ; nope - check next entity
  ldy EntityTypeId,X                              ; check entity type
  lda EntityHandlersHi,Y                          ; and find the entity handling routine for that type
  sta @TmpIndirectJump                            ; to prepare for an indirect jump
  lda EntityHandlersLo,Y                          ;
  sta @TmpIndirectJump+1                          ;
  phx                                             ; store current entity on the stack
  jmp (@TmpIndirectJump)                          ; and process the entity (it will jump back when done)
AdvanceToNextEntity:
  plx                                             ; restore offset to our entity from the stack
AdvanceToNextEntity2:
  dex                                             ; advance to the next entity to check
  bpl ProcessNextEntity                           ; and loop until done
  plb                                             ; restore processor state
  plp                                             ;
  RTL                                             ; done!

RunSharedEntityMovement:
  php                                             ; set up processor state
  sep #P_Idx8Bit | P_Acc8Bit                      ;
  ldx #$71                                        ; select last possible entity
@HandleEntity:
  lda EntityHeader,X                              ; check if entity is active
  beq @Next                                       ; otherwise skip to next entity
  clc                                             ; 
  lda EntityXSubPxSpeed,X                         ; add subpx speed onto entity subpx
  adc EntityXSubPx,X                              ; 
  sta EntityXSubPx,X                              ; 
  ldy #0                                          ; clear movement direction
  lda EntityXPxSpeed,X                            ; check current speed direction
  bpl @AddXPx                                     ; if moving right - skip ahead
  dey                                             ; switch to $ff for leftward motion
@AddXPx:
  adc EntityXPx,X                                 ; add px speed onto entity px
  sta EntityXPx,X                                 ;
  tya                                             ;
  adc EntityXMovement,X                           ;
  sta EntityXMovement,X                           ;
  clc                                             ; 
  lda EntityYSubPxSpeed,X                         ; add subpx speed onto entity subpx
  adc EntityYSubPx,X                              ; 
  sta EntityYSubPx,X                              ; 
  ldy #0                                          ; clear movement direction
  lda EntityYPxSpeed,X                            ; check current speed direction
  bpl @AddYPx                                     ; if moving right - skip ahead
  dey                                             ; switch to $ff for leftward motion
@AddYPx:
  adc EntityYPx,X                                 ; add px speed onto entity px
  sta EntityYPx,X                                 ;
  tya                                             ; then store how many 
  adc EntityYMovement,X                           ;
  sta EntityYMovement,X                           ;
@Next:
  dex                                             ; advance to next entity
  bpl @HandleEntity                               ; and keep running until all have been processed
  plp                                             ; then restore state
  rts                                             ; and exit


L_38195:
  STA.B $04                                       ; 038195 85 04 
  LDA.W EntityXPxSpeed,X                                   ; 038197 BD 7E 09 
  BMI.B B_381C6                                   ; 03819A 30 2A 
  ORA.W EntityXSubPxSpeed,X                                   ; 03819C 1D 0C 09 
  BEQ.B B_381E9                                   ; 03819F F0 48 
  SEC                                             ; 0381A1 38 
  LDA.B #$EE                                      ; 0381A2 A9 EE 
  SBC.B $04                                       ; 0381A4 E5 04 
  CMP.W EntityXPx,X                              ; 0381A6 DD 46 0B 
  BCS.B B_381E9                                   ; 0381A9 B0 3E 

.byte $9D,$46,$0B,$BD,$7E,$09,$30,$36             ; 0381AB ........ ?F??~?06
.byte $38,$A9,$00,$FD,$0C,$09,$9D,$0C             ; 0381B3 ........ 8???????
.byte $09,$A9,$00,$FD,$7E,$09,$9D,$7E             ; 0381BB ........ ????~??~
.byte $09,$80,$23                                 ; 0381C4 ...      ??#

B_381C6:
  CLC                                             ; 0381C6 18 
  LDA.B #$12                                      ; 0381C7 A9 12 
  ADC.B $04                                       ; 0381C9 65 04 
  CMP.W EntityXPx,X                              ; 0381CB DD 46 0B 
  BCC.B B_381E9                                   ; 0381CE 90 19 

.byte $9D,$46,$0B,$BD,$7E,$09,$10,$11             ; 0381D0 ........ ?F??~???
.byte $38,$A9,$00,$FD,$0C,$09,$9D,$0C             ; 0381D8 ........ 8???????
.byte $09,$A9,$00,$FD,$7E,$09,$9D,$7E             ; 0381E0 ........ ????~??~
.byte $09                                         ; 0381E9 .        ?

B_381E9:
  LDA.W EntityYPxSpeed,X                                   ; 0381E9 BD 62 0A 
  BMI.B B_38218                                   ; 0381EC 30 2A 
  ORA.W EntityYSubPxSpeed,X                                   ; 0381EE 1D F0 09 
  BEQ.B B_3823B                                   ; 0381F1 F0 48 
  SEC                                             ; 0381F3 38 
  LDA.B #$DC                                      ; 0381F4 A9 DC 
  SBC.B $04                                       ; 0381F6 E5 04 
  CMP.W EntityYPx,X                                   ; 0381F8 DD 9C 0C 
  BCS.B B_3823B                                   ; 0381FB B0 3E 
  STA.W EntityYPx,X                                   ; 0381FD 9D 9C 0C 
  LDA.W EntityYPxSpeed,X                                   ; 038200 BD 62 0A 
  BMI.B B_3823B                                   ; 038203 30 36 
  SEC                                             ; 038205 38 
  LDA.B #$00                                      ; 038206 A9 00 
  SBC.W EntityYSubPxSpeed,X                                   ; 038208 FD F0 09 
  STA.W EntityYSubPxSpeed,X                                   ; 03820B 9D F0 09 
  LDA.B #$00                                      ; 03820E A9 00 
  SBC.W EntityYPxSpeed,X                                   ; 038210 FD 62 0A 
  STA.W EntityYPxSpeed,X                                   ; 038213 9D 62 0A 
  BRA.B B_3823B                                   ; 038216 80 23 
B_38218:
  CLC                                             ; 038218 18 
  LDA.B #$20                                      ; 038219 A9 20 
  ADC.B $04                                       ; 03821B 65 04 
  CMP.W EntityYPx,X                                   ; 03821D DD 9C 0C 
  BCC.B B_3823B                                   ; 038220 90 19 
  STA.W EntityYPx,X                                   ; 038222 9D 9C 0C 
  LDA.W EntityYPxSpeed,X                                   ; 038225 BD 62 0A 
  BPL.B B_3823B                                   ; 038228 10 11 
  SEC                                             ; 03822A 38 
  LDA.B #$00                                      ; 03822B A9 00 
  SBC.W EntityYSubPxSpeed,X                                   ; 03822D FD F0 09 
  STA.W EntityYSubPxSpeed,X                                   ; 038230 9D F0 09 
  LDA.B #$00                                      ; 038233 A9 00 
  SBC.W EntityYPxSpeed,X                                   ; 038235 FD 62 0A 
  STA.W EntityYPxSpeed,X                                   ; 038238 9D 62 0A 
B_3823B:
  RTS                                             ; 03823B 60 


L_3823C:
  STA.W EntityV26,X                                   ; 03823C 9D 66 12 
  STZ.W EntityV27,X                                   ; 03823F 9E D8 12 
  ASL                                             ; 038242 0A 
  TAY                                             ; 038243 A8 
  PHB                                             ; 038244 8B 
  LDA.B #$03                                      ; 038245 A9 03 
  PHA                                             ; 038247 48 
  PLB                                             ; 038248 AB 
  LDA.W D_382A4,Y                                 ; 038249 B9 A4 82 
  STA.B $04                                       ; 03824C 85 04 
  LDA.W D_382A5,Y                                 ; 03824E B9 A5 82 
  STA.B $05                                       ; 038251 85 05 
  LDY.B #$00                                      ; 038253 A0 00 
  LDA.B ($04),Y                                   ; 038255 B1 04 
  STA.W EntityV28,X                                   ; 038257 9D 4A 13 
  INY                                             ; 03825A C8 
  LDA.B ($04),Y                                   ; 03825B B1 04 
  STA.W EntityV25,X                                   ; 03825D 9D F4 11 
  LDA.W EntityHeader,X                                   ; 038260 BD D2 06 
  AND.B #$BF                                      ; 038263 29 BF 
  STA.W EntityHeader,X                                   ; 038265 9D D2 06 
  PLB                                             ; 038268 AB 
  RTL                                             ; 038269 6B 

L_3826A:
  LDA.W EntityHeader,X                                   ; 03826A BD D2 06 
  AND.B #$40                                      ; 03826D 29 40 
  BNE.B B_382A3                                   ; 03826F D0 32 
  DEC.W EntityV28,X                                   ; 038271 DE 4A 13 
  BNE.B B_382A3                                   ; 038274 D0 2D 
  INC.W EntityV27,X                                   ; 038276 FE D8 12 
  LDA.W EntityV26,X                                   ; 038279 BD 66 12 
  ASL                                             ; 03827C 0A 
  TAY                                             ; 03827D A8 
  LDA.W D_382A4,Y                                 ; 03827E B9 A4 82 
  STA.B $04                                       ; 038281 85 04 
  LDA.W D_382A5,Y                                 ; 038283 B9 A5 82 
  STA.B $05                                       ; 038286 85 05 
  LDA.W EntityV27,X                                   ; 038288 BD D8 12 
  ASL                                             ; 03828B 0A 
  TAY                                             ; 03828C A8 
  LDA.B ($04),Y                                   ; 03828D B1 04 
  BEQ.B B_3829B                                   ; 03828F F0 0A 
  STA.W EntityV28,X                                   ; 038291 9D 4A 13 
  INY                                             ; 038294 C8 
  LDA.B ($04),Y                                   ; 038295 B1 04 
  STA.W EntityV25,X                                   ; 038297 9D F4 11 
  RTL                                             ; 03829A 6B 
B_3829B:
  LDA.W EntityHeader,X                                   ; 03829B BD D2 06 
  ORA.B #$40                                      ; 03829E 09 40 
  STA.W EntityHeader,X                                   ; 0382A0 9D D2 06 
B_382A3:
  RTL                                             ; 0382A3 6B 

D_382A4:
.byte $F4                                         ; 0382A5 .        ?
D_382A5:
.byte $82,$FB,$82,$10,$83,$25,$83,$2E             ; 0382A5 ........ ?????%?.
.byte $83,$33,$83,$3E,$83,$49,$83,$49             ; 0382AD ........ ?3?>?I?I
.byte $83,$49,$83,$49,$83,$49,$83,$49             ; 0382B5 .......D ?I?I?I?I
.byte $83,$70,$83,$70,$83,$73,$83,$7A             ; 0382BD D..DDDDD ?p?p?s?z
.byte $83,$83,$83,$9C,$83,$AF,$83,$E2             ; 0382C5 DDDDDDDD ????????
.byte $83,$F1,$83,$FC,$83,$1F,$84,$22             ; 0382CD DDD..DD. ???????"
.byte $84,$39,$84,$5C,$84,$69,$84,$76             ; 0382D5 .DDDDDDD ?9?\?i?v
.byte $84,$8F,$84,$98,$84,$CF,$84,$D4             ; 0382DD DDDDDDDD ????????
.byte $84,$E1,$84,$EE,$84,$EE,$84,$EE             ; 0382E5 D....... ????????
.byte $84,$EE,$84,$EE,$84,$EE,$84,$08             ; 0382ED ........ ????????
.byte $01,$10,$02,$08,$00,$00,$03,$08             ; 0382F5 ........ ????????
.byte $03,$09,$03,$0A,$03,$0B,$03,$00             ; 0382FD ........ ????????
.byte $03,$08,$03,$09,$03,$0A,$03,$0B             ; 038305 ........ ????????
.byte $01,$00,$00,$03,$0C,$03,$0D,$03             ; 03830D ........ ????????
.byte $0E,$03,$0F,$03,$00,$03,$08,$03             ; 038315 ........ ????????
.byte $09,$03,$0A,$03,$0B,$01,$00,$00             ; 03831D ........ ????????
.byte $08,$03,$14,$04,$08,$03,$01,$00             ; 038325 ........ ????????
.byte $00,$1E,$05,$01,$00,$00,$0A,$05             ; 03832D ........ ????????
.byte $04,$06,$12,$07,$10,$05,$01,$00             ; 038335 ........ ????????
.byte $00,$03,$00,$03,$01,$03,$02,$03             ; 03833D ........ ????????
.byte $03,$03,$04,$00,$01,$00,$96,$03             ; 038345 ....DDDD ????????
.byte $96,$03,$08,$02,$08,$01,$8C,$00             ; 03834D DDDDDDDD ????????
.byte $03,$01,$03,$02,$03,$03,$19,$04             ; 038355 DDDDDDDD ????????
.byte $03,$03,$03,$02,$03,$01,$06,$00             ; 03835D DDDDDDDD ????????
.byte $03,$01,$03,$02,$03,$03,$19,$04             ; 038365 DDDDDDDD ????????
.byte $3C,$03,$00,$3C,$00,$00,$05,$00             ; 03836D DDDDDDDD <??<????
.byte $32,$02,$0A,$00,$00,$05,$00,$32             ; 038375 DDDDDDDD 2??????2
.byte $02,$64,$01,$0A,$00,$00,$08,$03             ; 03837D DDDDDDDD ?d??????
.byte $03,$05,$03,$08,$03,$05,$03,$08             ; 038385 DDDDDDDD ????????
.byte $03,$05,$03,$08,$03,$05,$03,$08             ; 03838D DDDDDDDD ????????
.byte $03,$05,$03,$08,$0A,$00,$00,$01             ; 038395 DDDDDDDD ????????
.byte $03,$03,$02,$03,$01,$06,$00,$03             ; 03839D DDDDDDDD ????????
.byte $01,$03,$02,$03,$03,$19,$04,$3C             ; 0383A5 DDDDDDDD ???????<
.byte $03,$00,$01,$03,$03,$02,$03,$01             ; 0383AD DDDDDDDD ????????
.byte $06,$00,$03,$01,$03,$02,$03,$03             ; 0383B5 DDDDDDDD ????????
.byte $19,$04,$03,$03,$03,$02,$03,$01             ; 0383BD DDDDDDDD ????????
.byte $06,$00,$03,$01,$03,$02,$03,$03             ; 0383C5 DDDDDDDD ????????
.byte $19,$04,$03,$03,$03,$02,$03,$01             ; 0383CD DDDDDDDD ????????
.byte $06,$00,$03,$01,$03,$02,$03,$03             ; 0383D5 DDDDDDDD ????????
.byte $19,$04,$3C,$03,$00,$01,$03,$08             ; 0383DD DDDDDDDD ??<?????
.byte $02,$08,$01,$B4,$00,$08,$01,$08             ; 0383E5 DDDDDDDD ????????
.byte $02,$3C,$03,$00,$01,$03,$08,$02             ; 0383ED DDDDDDDD ?<??????
.byte $78,$01,$08,$02,$3C,$03,$00,$01             ; 0383F5 DDDDDDD. x???<???
.byte $03,$08,$02,$08,$01,$8C,$00,$03             ; 0383FD ........ ????????
.byte $01,$03,$02,$03,$03,$19,$04,$03             ; 038405 ........ ????????
.byte $03,$03,$02,$03,$01,$06,$00,$03             ; 03840D ........ ????????
.byte $01,$03,$02,$03,$03,$19,$04,$3C             ; 038415 ........ ???????<
.byte $03,$00,$78,$03,$00,$03,$03,$06             ; 03841D ..DDD... ??x?????
.byte $04,$03,$03,$03,$02,$03,$01,$04             ; 038425 ........ ????????
.byte $00,$03,$01,$03,$02,$03,$03,$06             ; 03842D ........ ????????
.byte $04,$3C,$03,$00,$01,$03,$03,$02             ; 038435 ....DDDD ?<??????
.byte $03,$01,$04,$00,$03,$01,$03,$02             ; 03843D DDDDDDDD ????????
.byte $03,$03,$06,$04,$03,$03,$03,$02             ; 038445 DDDDDDDD ????????
.byte $03,$01,$04,$00,$03,$01,$03,$02             ; 03844D DDDDDDDD ????????
.byte $03,$03,$06,$04,$3C,$03,$00,$07             ; 038455 DDDDDDDD ????<???
.byte $04,$07,$05,$3C,$06,$07,$05,$07             ; 03845D DDDDDDDD ???<????
.byte $04,$3C,$00,$00,$07,$07,$07,$08             ; 038465 DDDDDDDD ?<??????
.byte $3C,$09,$07,$08,$07,$07,$3C,$00             ; 03846D DDDDDDDD <?????<?
.byte $00,$07,$04,$07,$05,$28,$06,$07             ; 038475 DDDDDDDD ?????(??
.byte $05,$07,$04,$07,$00,$07,$07,$07             ; 03847D DDDDDDDD ????????
.byte $08,$28,$09,$07,$08,$07,$07,$3C             ; 038485 DDDDDDDD ?(?????<
.byte $00,$00,$96,$00,$96,$00,$32,$02             ; 03848D DDDDDDDD ??????2?
.byte $0A,$00,$00,$01,$03,$03,$02,$03             ; 038495 DDDDDDDD ????????
.byte $01,$0A,$00,$03,$01,$03,$02,$03             ; 03849D DDDDDDDD ????????
.byte $03,$06,$04,$03,$03,$03,$02,$03             ; 0384A5 DDDDDDDD ????????
.byte $01,$0A,$00,$03,$01,$03,$02,$03             ; 0384AD DDDDDDDD ????????
.byte $03,$06,$04,$03,$03,$03,$02,$03             ; 0384B5 DDDDDDDD ????????
.byte $01,$0A,$00,$03,$01,$03,$02,$03             ; 0384BD DDDDDDDD ????????
.byte $03,$06,$04,$03,$03,$03,$02,$3C             ; 0384C5 DDDDDDDD ???????<
.byte $01,$00,$05,$01,$3C,$05,$00,$6E             ; 0384CD DDDDDDDD ????<??n
.byte $05,$03,$07,$03,$08,$03,$09,$03             ; 0384D5 DDDDDDDD ????????
.byte $0A,$3C,$06,$00,$6E,$06,$03,$0B             ; 0384DD DDDD.... ?<??n???
.byte $03,$0C,$03,$0D,$03,$0E,$3C,$0F             ; 0384E5 ........ ??????<?
.byte $00                                         ; 0384EE .        ?
D_384EE:
.byte $0B                                         ; 0384EF D        ?
D_384EF:
.byte $03,$03,$03,$F4,$02,$DE,$02,$C1             ; 0384EF DDDDDDDD ????????
.byte $02,$9D,$02,$72,$02,$41,$02,$0B             ; 0384F7 DDDDDDDD ???r?A??
.byte $02,$D0,$01,$91,$01,$4D,$01,$06             ; 0384FF DDDDDDDD ?????M??
.byte $01,$BD,$00,$72,$00,$26,$00,$DA             ; 038507 DDDDDDDD ???r?&??
.byte $FF,$8E,$FF,$43,$FF,$FA,$FE,$B3             ; 03850F DDDDDDDD ???C????
.byte $FE,$6F,$FE,$30,$FE,$F5,$FD,$BF             ; 038517 DDDDDDDD ?o?0????
.byte $FD,$8E,$FD,$63,$FD,$3F,$FD,$22             ; 03851F DDDDDDDD ???c???"
.byte $FD,$0C,$FD,$FD,$FC,$F5,$FC,$F5             ; 038527 DDDDDDDD ????????
.byte $FC,$FD,$FC,$0C,$FD,$22,$FD,$3F             ; 03852F DDDDDDDD ?????"??
.byte $FD,$63,$FD,$8E,$FD,$BF,$FD,$F5             ; 038537 DDDDDDDD ?c??????
.byte $FD,$30,$FE,$6F,$FE,$B3,$FE,$FA             ; 03853F DDDDDDDD ?0?o????
.byte $FE,$43,$FF,$8E,$FF,$DA,$FF,$26             ; 038547 DDDDDDDD ?C?????&
.byte $00,$72,$00,$BD,$00,$06,$01,$4D             ; 03854F DDDDDDDD ?r?????M
.byte $01,$91,$01,$D0,$01,$0B,$02,$41             ; 038557 DDDDDDDD ???????A
.byte $02,$72,$02,$9D,$02,$C1,$02,$DE             ; 03855F DDDDDDDD ?r??????
.byte $02,$F4,$02,$03,$03,$0B,$03                 ; 038568 DDDDDDD  ???????
D_3856E:
.byte $26                                         ; 03856F D        &
D_3856F:
.byte $00,$72,$00,$BD,$00,$06,$01,$4D             ; 03856F DDDDDDDD ?r?????M
.byte $01,$91,$01,$D0,$01,$0B,$02,$41             ; 038577 DDDDDDDD ???????A
.byte $02,$72,$02,$9D,$02,$C1,$02,$DE             ; 03857F DDDDDDDD ?r??????
.byte $02,$F4,$02,$03,$03,$0B,$03,$0B             ; 038587 DDDDDDDD ????????
.byte $03,$03,$03,$F4,$02,$DE,$02,$C1             ; 03858F DDDDDDDD ????????
.byte $02,$9D,$02,$72,$02,$41,$02,$0B             ; 038597 DDDDDDDD ???r?A??
.byte $02,$D0,$01,$91,$01,$4D,$01,$06             ; 03859F DDDDDDDD ?????M??
.byte $01,$BD,$00,$72,$00,$26,$00,$DA             ; 0385A7 DDDDDDDD ???r?&??
.byte $FF,$8E,$FF,$43,$FF,$FA,$FE,$B3             ; 0385AF DDDDDDDD ???C????
.byte $FE,$6F,$FE,$30,$FE,$F5,$FD,$BF             ; 0385B7 DDDDDDDD ?o?0????
.byte $FD,$8E,$FD,$63,$FD,$3F,$FD,$22             ; 0385BF DDDDDDDD ???c???"
.byte $FD,$0C,$FD,$FD,$FC,$F5,$FC,$F5             ; 0385C7 DDDDDDDD ????????
.byte $FC,$FD,$FC,$0C,$FD,$22,$FD,$3F             ; 0385CF DDDDDDDD ?????"??
.byte $FD,$63,$FD,$8E,$FD,$BF,$FD,$F5             ; 0385D7 DDDDDDDD ?c??????
.byte $FD,$30,$FE,$6F,$FE,$B3,$FE,$FA             ; 0385DF DDDDDDDD ?0?o????
.byte $FE,$43,$FF,$8E,$FF,$DA,$FF,$5F             ; 0385E7 DDDDDDD. ?C?????_
.byte $00,$5B,$00,$54,$00,$4A,$00,$3C             ; 0385EF ........ ?[?T?J?<
.byte $00,$2D,$00,$1B,$00,$09,$00,$F7             ; 0385F7 ........ ?-??????
.byte $FF,$E5,$FF,$D3,$FF,$C4,$FF,$B6             ; 0385FF ........ ????????
.byte $FF,$AC,$FF,$A5,$FF,$A1,$FF,$A1             ; 038607 ........ ????????
.byte $FF,$A5,$FF,$AC,$FF,$B6,$FF,$C4             ; 03860F ........ ????????
.byte $FF,$D3,$FF,$E5,$FF,$F7,$FF,$09             ; 038617 ........ ????????
.byte $00,$1B,$00,$2D,$00,$3C,$00,$4A             ; 03861F ........ ???-?<?J
.byte $00,$54,$00,$5B,$00,$5F,$00,$09             ; 038627 ........ ?T?[?_??
.byte $00,$1B,$00,$2D,$00,$3C,$00,$4A             ; 03862F ........ ???-?<?J
.byte $00,$54,$00,$5B,$00,$5F,$00,$5F             ; 038637 ........ ?T?[?_?_
.byte $00,$5B,$00,$54,$00,$4A,$00,$3C             ; 03863F ........ ?[?T?J?<
.byte $00,$2D,$00,$1B,$00,$09,$00,$F7             ; 038647 ........ ?-??????
.byte $FF,$E5,$FF,$D3,$FF,$C4,$FF,$B6             ; 03864F ........ ????????
.byte $FF,$AC,$FF,$A5,$FF,$A1,$FF,$A1             ; 038657 ........ ????????
.byte $FF,$A5,$FF,$AC,$FF,$B6,$FF,$C4             ; 03865F ........ ????????
.byte $FF,$D3,$FF,$E5,$FF,$F7,$FF                 ; 038668 .......  ???????
D_3866E:
.byte $7F                                         ; 03866F D        ?
D_3866F:
.byte $01,$7C,$01,$76,$01,$6E,$01,$62             ; 03866F DDDDDDDD ?|?v?n?b
.byte $01,$54,$01,$43,$01,$30,$01,$1B             ; 038677 DDDDDDDD ?T?C?0??
.byte $01,$03,$01,$E9,$00,$CE,$00,$B1             ; 03867F DDDDDDDD ????????
.byte $00,$92,$00,$73,$00,$53,$00,$32             ; 038687 DDDDDDDD ???s?S?2
.byte $00,$10,$00,$F0,$FF,$CE,$FF,$AD             ; 03868F DDDDDDDD ????????
.byte $FF,$8D,$FF,$6E,$FF,$4F,$FF,$32             ; 038697 DDDDDDDD ???n?O?2
.byte $FF,$17,$FF,$FD,$FE,$E5,$FE,$D0             ; 03869F DDDDDDDD ????????
.byte $FE,$BD,$FE,$AC,$FE,$9E,$FE,$92             ; 0386A7 DDDDDDDD ????????
.byte $FE,$8A,$FE,$84,$FE,$81,$FE,$81             ; 0386AF DDDDDDDD ????????
.byte $FE,$84,$FE,$8A,$FE,$92,$FE,$9E             ; 0386B7 DDDDDDDD ????????
.byte $FE,$AC,$FE,$BD,$FE,$D0,$FE,$E5             ; 0386BF DDDDDDDD ????????
.byte $FE,$FD,$FE,$17,$FF,$32,$FF,$4F             ; 0386C7 DDDDDDDD ?????2?O
.byte $FF,$6E,$FF,$8D,$FF,$AD,$FF,$CE             ; 0386CF DDDDDDDD ?n??????
.byte $FF,$F0,$FF,$10,$00,$32,$00,$53             ; 0386D7 DDDDDDDD ?????2?S
.byte $00,$73,$00,$92,$00,$B1,$00,$CE             ; 0386DF DDDDDDDD ?s??????
.byte $00,$E9,$00,$03,$01,$1B,$01,$30             ; 0386E7 DDDDDDDD ???????0
.byte $01,$43,$01,$54,$01,$62,$01,$6E             ; 0386EF DDDDDDDD ?C?T?b?n
.byte $01,$76,$01,$7C,$01,$7F,$01                 ; 0386F8 DDDDDDD  ?v?|???
D_386FE:
.byte $10                                         ; 0386FF D        ?
D_386FF:
.byte $00,$32,$00,$53,$00,$73,$00,$92             ; 0386FF DDDDDDDD ?2?S?s??
.byte $00,$B1,$00,$CE,$00,$E9,$00,$03             ; 038707 DDDDDDDD ????????
.byte $01,$1B,$01,$30,$01,$43,$01,$54             ; 03870F DDDDDDDD ???0?C?T
.byte $01,$62,$01,$6E,$01,$76,$01,$7C             ; 038717 DDDDDDDD ?b?n?v?|
.byte $01,$7F,$01,$7F,$01,$7C,$01,$76             ; 03871F DDDDDDDD ?????|?v
.byte $01,$6E,$01,$62,$01,$54,$01,$43             ; 038727 DDDDDDDD ?n?b?T?C
.byte $01,$30,$01,$1B,$01,$03,$01,$E9             ; 03872F DDDDDDDD ?0??????
.byte $00,$CE,$00,$B1,$00,$92,$00,$73             ; 038737 DDDDDDDD ???????s
.byte $00,$53,$00,$32,$00,$10,$00,$F0             ; 03873F DDDDDDDD ?S?2????
.byte $FF,$CE,$FF,$AD,$FF,$8D,$FF,$6E             ; 038747 DDDDDDDD ???????n
.byte $FF,$4F,$FF,$32,$FF,$17,$FF,$FD             ; 03874F DDDDDDDD ?O?2????
.byte $FE,$E5,$FE,$D0,$FE,$BD,$FE,$AC             ; 038757 DDDDDDDD ????????
.byte $FE,$9E,$FE,$92,$FE,$8A,$FE,$84             ; 03875F DDDDDDDD ????????
.byte $FE,$81,$FE,$81,$FE,$84,$FE,$8A             ; 038767 DDDDDDDD ????????
.byte $FE,$92,$FE,$9E,$FE,$AC,$FE,$BD             ; 03876F DDDDDDDD ????????
.byte $FE,$D0,$FE,$E5,$FE,$FD,$FE,$17             ; 038777 DDDDDDDD ????????
.byte $FF,$32,$FF,$4F,$FF,$6E,$FF,$8D             ; 03877F DDDDDDDD ?2?O?n??
.byte $FF,$AD,$FF,$CE,$FF,$F0,$FF                 ; 038788 DDDDDDD  ???????

EntityHandlersHi:
.byte <$88E2,<$88E5,<$89B6,<$8A0E,<$8A11,<$8B6B,<$8BC3,<$8C18
.byte <$8C42,<$8C9A,<$8CF2,<$8D08,<$8D98,<$8E5F,<$8F81,<$8FEF
.byte <$9014,<$90A0,<$90F8,<$914D,<$922D,<$9484,<$952C,<$97C2
.byte <$98DD,<$9A2E,<$9CF4,<$9E54,<$A046,<$A112,<$A1D3,<$A314
.byte <$A44E,<$A561,<$A601,<$A783,<$A8BD,<$A97F,<$AA4D,<$AAF8
.byte <$A314,<$ABB3,<$ACF4,<$91C0,<$AE09,<$AEEA,<$B01A,<$B087
.byte <$B20E,<$B2C0,<$B341,<$B341,<$B341,<$B413,<ProcessRazorShieldEntity,<$B5B0
.byte <$B66D,<$B719,<$B771,<$B846,<$B8CA,<$B8CA,<$B8CA,<$B8CA
.byte <$B8CA,<$B8CA,<$B8CA,<$B8CA,<$B8CA,<$B8CA,<$B8CA,<$B96F
.byte <$BA04,<$BACE,<$BB5D,<$BBCE,<$BC66,<$BCDF,<$BD76,<$BE60
.byte <$BF35,<$C056,<$C0CC,<$C151,<$C158,<$C233,<$C36D,<$C416
.byte <$C472,<$C4F6,<$C574,<$C7AC,<$C854,<$CA45,<$CAD3,<$CB61
.byte <$CBCE,<$CBD1,<$CBD4,<$CBD7,<$CCFB,<$CEE9,<$D053,<$D1A4
.byte <$D1A7,<$D23A,<$D299,<$D32A,<$D3FA,<$D426,<$D60B,<$D65A
.byte <$D71C,<$D75D,<$D7BA,<$D7F9,<$D835,<$D873,<$D8DA,<$D9B1
.byte <$DC29,<$DC5C,<$DCA7,<$DD53,<$DDFA,<$DE31,<$DE93,<$DEAF
.byte <$DF5E,<$DF61,<$E52C,<$E574,<$E5DB,<$E623,<$E644,<$E665
.byte <$E668,<$E66B,<$E66E,<$E671,<$E87B,<$EA7B,<$B341,<$EAF9
.byte <$EAFC,<$EB6C,<$EBF6,<$EC6E,<$ECC8,<$ED73,<$F112,<$F22D
.byte <$F25A,<$F2B8,<$F322,<$F3A0,<$F3C9,<$F450,<$F4CF,<$F534
.byte <$F5C9,<$F60F,<$F628,<$F62B,<$F62E,<$F631,<$F634,<$F6C8
.byte <$F77E,<$F856
EntityHandlersLo:
.byte >$88E2,>$88E5,>$89B6,>$8A0E,>$8A11,>$8B6B,>$8BC3,>$8C18
.byte >$8C42,>$8C9A,>$8CF2,>$8D08,>$8D98,>$8E5F,>$8F81,>$8FEF
.byte >$9014,>$90A0,>$90F8,>$914D,>$922D,>$9484,>$952C,>$97C2
.byte >$98DD,>$9A2E,>$9CF4,>$9E54,>$A046,>$A112,>$A1D3,>$A314
.byte >$A44E,>$A561,>$A601,>$A783,>$A8BD,>$A97F,>$AA4D,>$AAF8
.byte >$A314,>$ABB3,>$ACF4,>$91C0,>$AE09,>$AEEA,>$B01A,>$B087
.byte >$B20E,>$B2C0,>$B341,>$B341,>$B341,>$B413,>ProcessRazorShieldEntity,>$B5B0
.byte >$B66D,>$B719,>$B771,>$B846,>$B8CA,>$B8CA,>$B8CA,>$B8CA
.byte >$B8CA,>$B8CA,>$B8CA,>$B8CA,>$B8CA,>$B8CA,>$B8CA,>$B96F
.byte >$BA04,>$BACE,>$BB5D,>$BBCE,>$BC66,>$BCDF,>$BD76,>$BE60
.byte >$BF35,>$C056,>$C0CC,>$C151,>$C158,>$C233,>$C36D,>$C416
.byte >$C472,>$C4F6,>$C574,>$C7AC,>$C854,>$CA45,>$CAD3,>$CB61
.byte >$CBCE,>$CBD1,>$CBD4,>$CBD7,>$CCFB,>$CEE9,>$D053,>$D1A4
.byte >$D1A7,>$D23A,>$D299,>$D32A,>$D3FA,>$D426,>$D60B,>$D65A
.byte >$D71C,>$D75D,>$D7BA,>$D7F9,>$D835,>$D873,>$D8DA,>$D9B1
.byte >$DC29,>$DC5C,>$DCA7,>$DD53,>$DDFA,>$DE31,>$DE93,>$DEAF
.byte >$DF5E,>$DF61,>$E52C,>$E574,>$E5DB,>$E623,>$E644,>$E665
.byte >$E668,>$E66B,>$E66E,>$E671,>$E87B,>$EA7B,>$B341,>$EAF9
.byte >$EAFC,>$EB6C,>$EBF6,>$EC6E,>$ECC8,>$ED73,>$F112,>$F22D
.byte >$F25A,>$F2B8,>$F322,>$F3A0,>$F3C9,>$F450,>$F4CF,>$F534
.byte >$F5C9,>$F60F,>$F628,>$F62B,>$F62E,>$F631,>$F634,>$F6C8
.byte >$F77E,>$F856

  JMP.W AdvanceToNextEntity                                   ; 0388E2 4C 41 81 
  DEC.W EntityV15,X                                   ; 0388E5 DE 80 0D 
  BNE.B B_38947                                   ; 0388E8 D0 5D 
  LDA.W EntityV20,X                                   ; 0388EA BD BA 0F 
  STA.B $06                                       ; 0388ED 85 06 
  CMP.B #$04                                      ; 0388EF C9 04 
  BNE.B B_388FA                                   ; 0388F1 D0 07 
  LDA.B #$0A                                      ; 0388F3 A9 0A 
  STA.W $052C                                     ; 0388F5 8D 2C 05 
  LDA.B $06                                       ; 0388F8 A5 06 
B_388FA:
  TAY                                             ; 0388FA A8 
  LDA.W D_38986,Y                                 ; 0388FB B9 86 89 
  BEQ.B B_3894A                                   ; 0388FE F0 4A 
  STA.W EntityV15,X                                   ; 038900 9D 80 0D 
  LDA.W D_38966,Y                                 ; 038903 B9 66 89 
  STA.W $1888,X                                   ; 038906 9D 88 18 
  STA.W $188A,X                                   ; 038909 9D 8A 18 
  LDA.W D_38956,Y                                 ; 03890C B9 56 89 
  STA.W $1893,X                                   ; 03890F 9D 93 18 
  LDA.W EquippedWeaponType,X                                   ; 038912 BD 97 18 
  ASL                                             ; 038915 0A 
  ASL                                             ; 038916 0A 
  ASL                                             ; 038917 0A 
  CLC                                             ; 038918 18 
  ADC.W $1893,X                                   ; 038919 7D 93 18 
  PHX                                             ; 03891C DA 
  TAX                                             ; 03891D AA 
  LDA.L D_B457,X                                  ; 03891E BF 57 B4 00 
  PLX                                             ; 038922 FA 
  STA.W $1884,X                                   ; 038923 9D 84 18 
  LDA.B #$01                                      ; 038926 A9 01 
  STA.W $19D3,X                                   ; 038928 9D D3 19 
  LDY.B $06                                       ; 03892B A4 06 
  LDA.W D_38976,Y                                 ; 03892D B9 76 89 
  JSL L_E5C0                                      ; 038930 22 C0 E5 00 
  LDA.B $06                                       ; 038934 A5 06 
  ASL                                             ; 038936 0A 
  TAY                                             ; 038937 A8 
  LDA.W D_38996,Y                                 ; 038938 B9 96 89 
  STA.W EntityXPxSpeed,X                                   ; 03893B 9D 7E 09 
  LDA.W D_38997,Y                                 ; 03893E B9 97 89 
  STA.W EntityYPxSpeed,X                                   ; 038941 9D 62 0A 
  INC.W EntityV20,X                                   ; 038944 FE BA 0F 
B_38947:
  JMP.W AdvanceToNextEntity                                   ; 038947 4C 41 81 
B_3894A:
  STZ.W $052C                                     ; 03894A 9C 2C 05 
  STZ.W EntityXPxSpeed,X                                   ; 03894D 9E 7E 09 
  STZ.W EntityTypeId,X                                   ; 038950 9E 44 07 
  JMP.W AdvanceToNextEntity                                   ; 038953 4C 41 81 

D_38956:
.byte $04,$03,$02,$01,$00,$01,$02,$00             ; 038956 DDDDDDD. ????????
.byte $04,$05,$06,$07,$00,$01,$02,$00             ; 03895E DDDDDDD. ????????
D_38966:
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 038966 DDDDDDD. ????????
.byte $00,$40,$40,$40,$00,$00,$00,$00             ; 03896E DDDDDDD. ?@@@????
D_38976:
.byte $05,$04,$03,$02,$01,$02,$03,$00             ; 038976 DDDDDDD. ????????
.byte $05,$06,$07,$08,$01,$02,$03,$00             ; 03897E DDDDDDD. ????????
D_38986:
.byte $04,$04,$32,$04,$38,$04,$61,$00             ; 038986 DDDDDDDD ??2?8?a?
.byte $04,$04,$32,$04,$38,$04,$61,$00             ; 03898E DDDDDDDD ??2?8?a?
D_38996:
.byte $00                                         ; 038997 D        ?
D_38997:
.byte $FF,$01,$FF,$01,$00,$01,$01,$00             ; 038997 DDDDDDDD ????????
.byte $01,$01,$01,$01,$00,$00,$00,$00             ; 03899F DDDDD..D ????????
.byte $FF,$FF,$FF,$FF,$00,$FF,$01,$00             ; 0389A7 DDDDDDDD ????????
.byte $01,$01,$01,$01,$00,$00,$00                 ; 0389B0 DDDDD..  ???????

  DEC.W EntityV28,X                                   ; 0389B6 DE 4A 13 
  BNE.B B_389F7                                   ; 0389B9 D0 3C 
  LDA.B #$04                                      ; 0389BB A9 04 
  STA.W EntityV28,X                                   ; 0389BD 9D 4A 13 
  LDY.W EntityV27,X                                   ; 0389C0 BC D8 12 
  INY                                             ; 0389C3 C8 
  CPY.B #$08                                      ; 0389C4 C0 08 
  BNE.B B_389ED                                   ; 0389C6 D0 25 
  STZ.W EntityHeader,X                                   ; 0389C8 9E D2 06 
  PHX                                             ; 0389CB DA 
  LDY.W EntityV31,X                                   ; 0389CC BC A0 14 
  JSL L_AEF1                                      ; 0389CF 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 0389D3 BD A0 14 
  TAX                                             ; 0389D6 AA 
  STZ.W StateFlags,X                                   ; 0389D7 9E 5E 17 
  ASL                                             ; 0389DA 0A 
  ASL                                             ; 0389DB 0A 
  TAY                                             ; 0389DC A8 
  LDA.B #$F0                                      ; 0389DD A9 F0 
  BCC.B B_389E6                                   ; 0389DF 90 05 

.byte $99,$09,$04,$80,$03                         ; 0389E2 .....    ?????

B_389E6:
  STA.W XexzyTorsoY,Y                             ; 0389E6 99 09 03 
  PLX                                             ; 0389E9 FA 
  JMP.W AdvanceToNextEntity                                   ; 0389EA 4C 41 81 
B_389ED:
  TYA                                             ; 0389ED 98 
  STA.W EntityV27,X                                   ; 0389EE 9D D8 12 
  LDA.W D_38A06,Y                                 ; 0389F1 B9 06 8A 
  STA.W EntityV29,X                                   ; 0389F4 9D BC 13 
B_389F7:
  LDA.B #$08                                      ; 0389F7 A9 08 
  STA.B $1C                                       ; 0389F9 85 1C 
  LDA.B #$08                                      ; 0389FB A9 08 
  STA.B $1D                                       ; 0389FD 85 1D 
  JSL L_AFC2                                      ; 0389FF 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 038A03 4C 41 81 

D_38A06:
.byte $60,$62,$64,$66,$68,$6A,$6C,$6E             ; 038A06 .DDDDDDD `bdfhjln

  JMP.W AdvanceToNextEntity                                   ; 038A0E 4C 41 81 
  LDY.W EntityV20,X                                   ; 038A11 BC BA 0F 
  LDA.W $18A5,Y                                   ; 038A14 B9 A5 18 
  BNE.B B_38A2D                                   ; 038A17 D0 14 
  LDA.W EntityV15,X                                   ; 038A19 BD 80 0D 
  BNE.B B_38A88                                   ; 038A1C D0 6A 
  LDA.W EntityV16,X                                   ; 038A1E BD F2 0D 
  BEQ.B B_38A2D                                   ; 038A21 F0 0A 
  LDA.B #$A0                                      ; 038A23 A9 A0 
  STA.W EntityV15,X                                   ; 038A25 9D 80 0D 
  STZ.W EntityV16,X                                   ; 038A28 9E F2 0D 
  BRA.B B_38A88                                   ; 038A2B 80 5B 
B_38A2D:
  PHY                                             ; 038A2D 5A 
  STZ.W EntityHeader,X                                   ; 038A2E 9E D2 06 
  PHX                                             ; 038A31 DA 
  LDY.W EntityV31,X                                   ; 038A32 BC A0 14 
  JSL L_AEF1                                      ; 038A35 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 038A39 BD A0 14 
  TAX                                             ; 038A3C AA 
  STZ.W StateFlags,X                                   ; 038A3D 9E 5E 17 
  ASL                                             ; 038A40 0A 
  ASL                                             ; 038A41 0A 
  TAY                                             ; 038A42 A8 
  LDA.B #$F0                                      ; 038A43 A9 F0 
  BCC.B B_38A4C                                   ; 038A45 90 05 
  STA.W $0409,Y                                   ; 038A47 99 09 04 
  BRA.B B_38A4F                                   ; 038A4A 80 03 

B_38A4C:
.byte $99,$09,$03                                 ; 038A4D ...      ???

B_38A4F:
  PLX                                             ; 038A4F FA 
  LDA.W EntityV21,X                                   ; 038A50 BD 2C 10 
  STA.W EntityV31,X                                   ; 038A53 9D A0 14 
  PHX                                             ; 038A56 DA 
  LDY.W EntityV31,X                                   ; 038A57 BC A0 14 
  JSL L_AEF1                                      ; 038A5A 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 038A5E BD A0 14 
  TAX                                             ; 038A61 AA 
  STZ.W StateFlags,X                                   ; 038A62 9E 5E 17 
  ASL                                             ; 038A65 0A 
  ASL                                             ; 038A66 0A 
  TAY                                             ; 038A67 A8 
  LDA.B #$F0                                      ; 038A68 A9 F0 
  BCC.B B_38A71                                   ; 038A6A 90 05 
  STA.W $0409,Y                                   ; 038A6C 99 09 04 
  BRA.B B_38A74                                   ; 038A6F 80 03 

B_38A71:
.byte $99,$09,$03                                 ; 038A72 ...      ???

B_38A74:
  PLX                                             ; 038A74 FA 
  TXY                                             ; 038A75 9B 
  LDX.W EntityV20,Y                                   ; 038A76 BE BA 0F 
  STZ.W $18A9,X                                   ; 038A79 9E A9 18 
  LDA.B #$FF                                      ; 038A7C A9 FF 
  STA.W $05CC,X                                   ; 038A7E 9D CC 05 
  PLX                                             ; 038A81 FA 
  JSR.W L_38B2E                                   ; 038A82 20 2E 8B 
  JMP.W AdvanceToNextEntity                                   ; 038A85 4C 41 81 
B_38A88:
  DEC.W EntityV15,X                                   ; 038A88 DE 80 0D 
  LDY.W EntityV16,X                                   ; 038A8B BC F2 0D 
  LDA.W D_38B63,Y                                 ; 038A8E B9 63 8B 
  STA.B $04                                       ; 038A91 85 04 
  LDY.W EntityV20,X                                   ; 038A93 BC BA 0F 
  SEC                                             ; 038A96 38 
  LDA.W EntityXPx,Y                              ; 038A97 B9 46 0B 
  SBC.B #$11                                      ; 038A9A E9 11 
  STA.B $06                                       ; 038A9C 85 06 
  SEC                                             ; 038A9E 38 
  LDA.W EntityYPx,Y                                   ; 038A9F B9 9C 0C 
  SBC.B #$0E                                      ; 038AA2 E9 0E 
  STA.B $07                                       ; 038AA4 85 07 
  LDA.B FrameCounter                              ; 038AA6 A5 CF 
  AND.B #$01                                      ; 038AA8 29 01 
  TAY                                             ; 038AAA A8 
  LDA.W D_38B65,Y                                 ; 038AAB B9 65 8B 
  ORA.W $18A7                                     ; 038AAE 0D A7 18 
  STA.B $05                                       ; 038AB1 85 05 
  CLC                                             ; 038AB3 18 
  LDA.B $06                                       ; 038AB4 A5 06 
  ADC.W D_38B69,Y                                 ; 038AB6 79 69 8B 
  STA.B $06                                       ; 038AB9 85 06 
  LDA.W EntityV31,X                                   ; 038ABB BD A0 14 
  ASL                                             ; 038ABE 0A 
  ASL                                             ; 038ABF 0A 
  TAY                                             ; 038AC0 A8 
  BCC.B B_38AD9                                   ; 038AC1 90 16 
  LDA.B $06                                       ; 038AC3 A5 06 
  STA.W $0408,Y                                   ; 038AC5 99 08 04 
  LDA.B $07                                       ; 038AC8 A5 07 
  STA.W $0409,Y                                   ; 038ACA 99 09 04 
  LDA.B $04                                       ; 038ACD A5 04 
  STA.W $040A,Y                                   ; 038ACF 99 0A 04 
  LDA.B $05                                       ; 038AD2 A5 05 
  STA.W $040B,Y                                   ; 038AD4 99 0B 04 
  BRA.B B_38AED                                   ; 038AD7 80 14 

B_38AD9:
.byte $A5,$06,$99,$08,$03,$A5,$07,$99             ; 038AD9 ........ ????????
.byte $09,$03,$A5,$04,$99,$0A,$03,$A5             ; 038AE1 ........ ????????
.byte $05,$99,$0B,$03                             ; 038AEA ....     ????

B_38AED:
  LDA.W EntityV21,X                                   ; 038AED BD 2C 10 
  ASL                                             ; 038AF0 0A 
  ASL                                             ; 038AF1 0A 
  TAY                                             ; 038AF2 A8 
  BCC.B B_38B11                                   ; 038AF3 90 1C 
  LDA.B $06                                       ; 038AF5 A5 06 
  STA.W $0408,Y                                   ; 038AF7 99 08 04 
  CLC                                             ; 038AFA 18 
  LDA.B $07                                       ; 038AFB A5 07 
  ADC.B #$10                                      ; 038AFD 69 10 
  STA.W $0409,Y                                   ; 038AFF 99 09 04 
  CLC                                             ; 038B02 18 
  LDA.B $04                                       ; 038B03 A5 04 
  STA.W $040A,Y                                   ; 038B05 99 0A 04 
  LDA.B $05                                       ; 038B08 A5 05 
  ORA.B #$80                                      ; 038B0A 09 80 
  STA.W $040B,Y                                   ; 038B0C 99 0B 04 
  BRA.B B_38B2B                                   ; 038B0F 80 1A 

B_38B11:
.byte $A5,$06,$99,$08,$04,$18,$A5,$07             ; 038B11 ........ ????????
.byte $69,$10,$99,$09,$03,$18,$A5,$04             ; 038B19 ........ i???????
.byte $99,$0A,$03,$A5,$05,$09,$80,$99             ; 038B21 ........ ????????
.byte $0B,$03                                     ; 038B2A ..       ??

B_38B2B:
  JMP.W AdvanceToNextEntity                                   ; 038B2B 4C 41 81 

L_38B2E:
  SEC                                             ; 038B2E 38 
  LDA.W EntityXPx,X                              ; 038B2F BD 46 0B 
  SBC.B #$04                                      ; 038B32 E9 04 
  BCS.B B_38B38                                   ; 038B34 B0 02 

.byte $A9,$00                                     ; 038B37 ..       ??

B_38B38:
  STA.W EntityV32,X                                   ; 038B38 9D 16 15 
  CLC                                             ; 038B3B 18 
  LDA.W EntityXPx,X                              ; 038B3C BD 46 0B 
  ADC.B #$04                                      ; 038B3F 69 04 
  BCC.B B_38B45                                   ; 038B41 90 02 

.byte $A9,$FF                                     ; 038B44 ..       ??

B_38B45:
  STA.W EntityV33,X                                   ; 038B45 9D 88 15 
  SEC                                             ; 038B48 38 
  LDA.W EntityYPx,X                                   ; 038B49 BD 9C 0C 
  SBC.B #$04                                      ; 038B4C E9 04 
  BCS.B B_38B52                                   ; 038B4E B0 02 

.byte $A9,$00                                     ; 038B51 ..       ??

B_38B52:
  STA.W EntityV34,X                                   ; 038B52 9D FA 15 
  CLC                                             ; 038B55 18 
  LDA.W EntityYPx,X                                   ; 038B56 BD 9C 0C 
  ADC.B #$04                                      ; 038B59 69 04 
  BCC.B B_38B5F                                   ; 038B5B 90 02 

.byte $A9,$FF                                     ; 038B5E ..       ??

B_38B5F:
  STA.W EntityV35,X                                   ; 038B5F 9D 6C 16 
  RTS                                             ; 038B62 60 


D_38B63:
.byte $2C,$2A                                     ; 038B64 DD       ,*
D_38B65:
.byte $27,$67,$25,$65                             ; 038B66 DD..     'g%e
D_38B69:
.byte $00,$10                                     ; 038B6A DD       ??

  DEC.W EntityV28,X                                   ; 038B6B DE 4A 13 
  BNE.B B_38BAC                                   ; 038B6E D0 3C 
  LDA.B #$04                                      ; 038B70 A9 04 
  STA.W EntityV28,X                                   ; 038B72 9D 4A 13 
  LDY.W EntityV27,X                                   ; 038B75 BC D8 12 
  INY                                             ; 038B78 C8 
  CPY.B #$08                                      ; 038B79 C0 08 
  BNE.B B_38BA2                                   ; 038B7B D0 25 
  STZ.W EntityHeader,X                                   ; 038B7D 9E D2 06 
  PHX                                             ; 038B80 DA 
  LDY.W EntityV31,X                                   ; 038B81 BC A0 14 
  JSL L_AEF1                                      ; 038B84 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 038B88 BD A0 14 
  TAX                                             ; 038B8B AA 
  STZ.W StateFlags,X                                   ; 038B8C 9E 5E 17 
  ASL                                             ; 038B8F 0A 
  ASL                                             ; 038B90 0A 
  TAY                                             ; 038B91 A8 
  LDA.B #$F0                                      ; 038B92 A9 F0 
  BCC.B B_38B9B                                   ; 038B94 90 05 
  STA.W $0409,Y                                   ; 038B96 99 09 04 
  BRA.B B_38B9E                                   ; 038B99 80 03 

B_38B9B:
.byte $99,$09,$03                                 ; 038B9C ...      ???

B_38B9E:
  PLX                                             ; 038B9E FA 
  JMP.W AdvanceToNextEntity                                   ; 038B9F 4C 41 81 
B_38BA2:
  TYA                                             ; 038BA2 98 
  STA.W EntityV27,X                                   ; 038BA3 9D D8 12 
  LDA.W D_38BBB,Y                                 ; 038BA6 B9 BB 8B 
  STA.W EntityV29,X                                   ; 038BA9 9D BC 13 
B_38BAC:
  LDA.B #$08                                      ; 038BAC A9 08 
  STA.B $1C                                       ; 038BAE 85 1C 
  LDA.B #$08                                      ; 038BB0 A9 08 
  STA.B $1D                                       ; 038BB2 85 1D 
  JSL L_AFC2                                      ; 038BB4 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 038BB8 4C 41 81 

D_38BBB:
.byte $40,$42,$44,$46,$48,$4A,$4C,$4E             ; 038BBB .DDDDDDD @BDFHJLN

  DEC.W EntityV28,X                                   ; 038BC3 DE 4A 13 
  BNE.B B_38C04                                   ; 038BC6 D0 3C 
  LDA.B #$04                                      ; 038BC8 A9 04 
  STA.W EntityV28,X                                   ; 038BCA 9D 4A 13 
  LDY.W EntityV27,X                                   ; 038BCD BC D8 12 
  INY                                             ; 038BD0 C8 
  CPY.B #$05                                      ; 038BD1 C0 05 
  BNE.B B_38BFA                                   ; 038BD3 D0 25 
  STZ.W EntityHeader,X                                   ; 038BD5 9E D2 06 
  PHX                                             ; 038BD8 DA 
  LDY.W EntityV31,X                                   ; 038BD9 BC A0 14 
  JSL L_AEF1                                      ; 038BDC 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 038BE0 BD A0 14 
  TAX                                             ; 038BE3 AA 
  STZ.W StateFlags,X                                   ; 038BE4 9E 5E 17 
  ASL                                             ; 038BE7 0A 
  ASL                                             ; 038BE8 0A 
  TAY                                             ; 038BE9 A8 
  LDA.B #$F0                                      ; 038BEA A9 F0 
  BCC.B B_38BF3                                   ; 038BEC 90 05 
  STA.W $0409,Y                                   ; 038BEE 99 09 04 
  BRA.B B_38BF6                                   ; 038BF1 80 03 
B_38BF3:
  STA.W XexzyTorsoY,Y                             ; 038BF3 99 09 03 
B_38BF6:
  PLX                                             ; 038BF6 FA 
  JMP.W AdvanceToNextEntity                                   ; 038BF7 4C 41 81 
B_38BFA:
  TYA                                             ; 038BFA 98 
  STA.W EntityV27,X                                   ; 038BFB 9D D8 12 
  LDA.W D_38C13,Y                                 ; 038BFE B9 13 8C 
  STA.W EntityV29,X                                   ; 038C01 9D BC 13 
B_38C04:
  LDA.B #$08                                      ; 038C04 A9 08 
  STA.B $1C                                       ; 038C06 85 1C 
  LDA.B #$08                                      ; 038C08 A9 08 
  STA.B $1D                                       ; 038C0A 85 1D 
  JSL L_AFC2                                      ; 038C0C 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 038C10 4C 41 81 

D_38C13:
.byte $20,$22,$24,$22,$20                         ; 038C14 .DDDD     "$" 

  DEC.W EntityV15,X                                   ; 038C18 DE 80 0D 
  BNE.B B_38C3F                                   ; 038C1B D0 22 
  STZ.W EntityHeader,X                                   ; 038C1D 9E D2 06 
  PHX                                             ; 038C20 DA 
  LDY.W EntityV31,X                                   ; 038C21 BC A0 14 
  JSL L_AEF1                                      ; 038C24 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 038C28 BD A0 14 
  TAX                                             ; 038C2B AA 
  STZ.W StateFlags,X                                   ; 038C2C 9E 5E 17 
  ASL                                             ; 038C2F 0A 
  ASL                                             ; 038C30 0A 
  TAY                                             ; 038C31 A8 
  LDA.B #$F0                                      ; 038C32 A9 F0 
  BCC.B B_38C3B                                   ; 038C34 90 05 
  STA.W $0409,Y                                   ; 038C36 99 09 04 
  BRA.B B_38C3E                                   ; 038C39 80 03 
B_38C3B:
  STA.W XexzyTorsoY,Y                             ; 038C3B 99 09 03 
B_38C3E:
  PLX                                             ; 038C3E FA 
B_38C3F:
  JMP.W AdvanceToNextEntity                                   ; 038C3F 4C 41 81 
  DEC.W EntityV28,X                                   ; 038C42 DE 4A 13 
  BNE.B B_38C83                                   ; 038C45 D0 3C 
  LDA.B #$04                                      ; 038C47 A9 04 
  STA.W EntityV28,X                                   ; 038C49 9D 4A 13 
  LDY.W EntityV27,X                                   ; 038C4C BC D8 12 
  INY                                             ; 038C4F C8 
  CPY.B #$08                                      ; 038C50 C0 08 
  BNE.B B_38C79                                   ; 038C52 D0 25 
  STZ.W EntityHeader,X                                   ; 038C54 9E D2 06 
  PHX                                             ; 038C57 DA 
  LDY.W EntityV31,X                                   ; 038C58 BC A0 14 
  JSL L_AEF1                                      ; 038C5B 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 038C5F BD A0 14 
  TAX                                             ; 038C62 AA 
  STZ.W StateFlags,X                                   ; 038C63 9E 5E 17 
  ASL                                             ; 038C66 0A 
  ASL                                             ; 038C67 0A 
  TAY                                             ; 038C68 A8 
  LDA.B #$F0                                      ; 038C69 A9 F0 
  BCC.B B_38C72                                   ; 038C6B 90 05 

.byte $99,$09,$04,$80,$03                         ; 038C6E .....    ?????

B_38C72:
  STA.W XexzyTorsoY,Y                             ; 038C72 99 09 03 
  PLX                                             ; 038C75 FA 
  JMP.W AdvanceToNextEntity                                   ; 038C76 4C 41 81 
B_38C79:
  TYA                                             ; 038C79 98 
  STA.W EntityV27,X                                   ; 038C7A 9D D8 12 
  LDA.W D_38C92,Y                                 ; 038C7D B9 92 8C 
  STA.W EntityV29,X                                   ; 038C80 9D BC 13 
B_38C83:
  LDA.B #$08                                      ; 038C83 A9 08 
  STA.B $1C                                       ; 038C85 85 1C 
  LDA.B #$08                                      ; 038C87 A9 08 
  STA.B $1D                                       ; 038C89 85 1D 
  JSL L_AFC2                                      ; 038C8B 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 038C8F 4C 41 81 

D_38C92:
.byte $40,$42,$44,$46,$48,$4A,$4C,$4E             ; 038C92 .DDDDDDD @BDFHJLN

  DEC.W EntityV28,X                                   ; 038C9A DE 4A 13 
  BNE.B B_38CDB                                   ; 038C9D D0 3C 
  LDA.B #$04                                      ; 038C9F A9 04 
  STA.W EntityV28,X                                   ; 038CA1 9D 4A 13 
  LDY.W EntityV27,X                                   ; 038CA4 BC D8 12 
  INY                                             ; 038CA7 C8 
  CPY.B #$08                                      ; 038CA8 C0 08 
  BNE.B B_38CD1                                   ; 038CAA D0 25 
  STZ.W EntityHeader,X                                   ; 038CAC 9E D2 06 
  PHX                                             ; 038CAF DA 
  LDY.W EntityV31,X                                   ; 038CB0 BC A0 14 
  JSL L_AEF1                                      ; 038CB3 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 038CB7 BD A0 14 
  TAX                                             ; 038CBA AA 
  STZ.W StateFlags,X                                   ; 038CBB 9E 5E 17 
  ASL                                             ; 038CBE 0A 
  ASL                                             ; 038CBF 0A 
  TAY                                             ; 038CC0 A8 
  LDA.B #$F0                                      ; 038CC1 A9 F0 
  BCC.B B_38CCA                                   ; 038CC3 90 05 
  STA.W $0409,Y                                   ; 038CC5 99 09 04 
  BRA.B B_38CCD                                   ; 038CC8 80 03 
B_38CCA:
  STA.W XexzyTorsoY,Y                             ; 038CCA 99 09 03 
B_38CCD:
  PLX                                             ; 038CCD FA 
  JMP.W AdvanceToNextEntity                                   ; 038CCE 4C 41 81 
B_38CD1:
  TYA                                             ; 038CD1 98 
  STA.W EntityV27,X                                   ; 038CD2 9D D8 12 
  LDA.W D_38CEA,Y                                 ; 038CD5 B9 EA 8C 
  STA.W EntityV29,X                                   ; 038CD8 9D BC 13 
B_38CDB:
  LDA.B #$08                                      ; 038CDB A9 08 
  STA.B $1C                                       ; 038CDD 85 1C 
  LDA.B #$08                                      ; 038CDF A9 08 
  STA.B $1D                                       ; 038CE1 85 1D 
  JSL L_AFC2                                      ; 038CE3 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 038CE7 4C 41 81 

D_38CEA:
.byte $20,$22,$24,$26,$28,$2A,$2C,$2E             ; 038CEA .DDDDDDD  "$&(*,.
.byte $DE,$80,$0D,$A9,$FF,$9D,$7E,$09             ; 038CF2 ........ ??????~?
.byte $9E,$44,$07,$4C,$41,$81,$2D,$2C             ; 038CFA ........ ?D?LA?-,
.byte $2B,$2A,$29,$2A,$2B,$2C                     ; 038D03 ......   +*)*+,

  LDA.W EntityXPx,X                              ; 038D08 BD 46 0B 
  STA.B $04                                       ; 038D0B 85 04 
  LDA.W EntityYPx,X                                   ; 038D0D BD 9C 0C 
  STA.B $05                                       ; 038D10 85 05 
  LDA.W EntityV15,X                                   ; 038D12 BD 80 0D 
  STA.B $07                                       ; 038D15 85 07 
  LDA.W EntityV20,X                                   ; 038D17 BD BA 0F 
  STA.B $06                                       ; 038D1A 85 06 
  JSR.W L_38D74                                   ; 038D1C 20 74 8D 
  CLC                                             ; 038D1F 18 
  LDA.B $04                                       ; 038D20 A5 04 
  ADC.B $08                                       ; 038D22 65 08 
  STA.B $04                                       ; 038D24 85 04 
  JSR.W L_38D74                                   ; 038D26 20 74 8D 
  CLC                                             ; 038D29 18 
  LDA.B $05                                       ; 038D2A A5 05 
  ADC.B $08                                       ; 038D2C 65 08 
  STA.B $05                                       ; 038D2E 85 05 
  LDA.B #$1E                                      ; 038D30 A9 1E 
  CMP.B $04                                       ; 038D32 C5 04 
  BCC.B B_38D38                                   ; 038D34 90 02 
  STA.B $04                                       ; 038D36 85 04 
B_38D38:
  LDA.B #$E2                                      ; 038D38 A9 E2 
  CMP.B $04                                       ; 038D3A C5 04 
  BCS.B B_38D40                                   ; 038D3C B0 02 
  STA.B $04                                       ; 038D3E 85 04 
B_38D40:
  LDA.B #$2C                                      ; 038D40 A9 2C 
  CMP.B $05                                       ; 038D42 C5 05 
  BCC.B B_38D48                                   ; 038D44 90 02 
  STA.B $05                                       ; 038D46 85 05 
B_38D48:
  LDA.B #$D0                                      ; 038D48 A9 D0 
  CMP.B $05                                       ; 038D4A C5 05 
  BCS.B B_38D50                                   ; 038D4C B0 02 
  STA.B $05                                       ; 038D4E 85 05 
B_38D50:
  PHX                                             ; 038D50 DA 
  JSL FindEmptyEntitySlot                                     ; 038D51 22 F3 80 03 
  BNE.B B_38D68                                   ; 038D55 D0 11 
  JSL AdvanceRNG                                     ; 038D57 22 95 CA 0E 
  AND.B #$03                                      ; 038D5B 29 03 
  ORA.B $06                                       ; 038D5D 05 06 
  STA.B $06                                       ; 038D5F 85 06 
  JSL L_DAA1                                      ; 038D61 22 A1 DA 00 
  STZ.W EntityV23,X                                   ; 038D65 9E 10 11 
B_38D68:
  PLX                                             ; 038D68 FA 
  DEC.W EntityV15,X                                   ; 038D69 DE 80 0D 
  BPL.B B_38D71                                   ; 038D6C 10 03 
  STZ.W EntityHeader,X                                   ; 038D6E 9E D2 06 
B_38D71:
  JMP.W AdvanceToNextEntity                                   ; 038D71 4C 41 81 

L_38D74:
  JSL AdvanceRNG                                     ; 038D74 22 95 CA 0E 
  AND.B #$07                                      ; 038D78 29 07 
  TAY                                             ; 038D7A A8 
  LDA.W D_38D90,Y                                 ; 038D7B B9 90 8D 
  STA.B $08                                       ; 038D7E 85 08 
  JSL AdvanceRNG                                     ; 038D80 22 95 CA 0E 
  AND.B #$01                                      ; 038D84 29 01 
  BNE.B B_38D8F                                   ; 038D86 D0 07 
  SEC                                             ; 038D88 38 
  LDA.B #$00                                      ; 038D89 A9 00 
  SBC.B $08                                       ; 038D8B E5 08 
  STA.B $08                                       ; 038D8D 85 08 
B_38D8F:
  RTS                                             ; 038D8F 60 


D_38D90:
.byte $00,$04,$08,$0C,$10,$14,$18,$1C             ; 038D90 DDDDDDDD ????????

  DEC.W EntityV15,X                                   ; 038D98 DE 80 0D 
  BNE.B B_38DD3                                   ; 038D9B D0 36 
  LDA.W EntityV25,X                                   ; 038D9D BD F4 11 
  INC A
  AND.B #$03                                      ; 038DA1 29 03 
  TAY                                             ; 038DA3 A8 
  ORA.B #$04                                      ; 038DA4 09 04 
  STA.W EntityV25,X                                   ; 038DA6 9D F4 11 
  LDA.W D_38E5B,Y                                 ; 038DA9 B9 5B 8E 
  STA.W EntityV15,X                                   ; 038DAC 9D 80 0D 
  CPY.B #$02                                      ; 038DAF C0 02 
  BNE.B B_38DCF                                   ; 038DB1 D0 1C 
  LDA.W EntityV16,X                                   ; 038DB3 BD F2 0D 
  BNE.B B_38DBD                                   ; 038DB6 D0 05 
  STZ.W EntityV15,X                                   ; 038DB8 9E 80 0D 
  BRA.B B_38DCF                                   ; 038DBB 80 12 
B_38DBD:
  DEC.W EntityV16,X                                   ; 038DBD DE F2 0D 
  PHX                                             ; 038DC0 DA 
  REP.B #P_Idx8Bit                                      ; 038DC1 C2 10 
  LDA.B #$07                                      ; 038DC3 A9 07 
  LDX.W #$FF28                                    ; 038DC5 A2 28 FF 
  JSL Audio_F830F                                     ; 038DC8 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 038DCC E2 30 
  PLX                                             ; 038DCE FA 
B_38DCF:
  JSL L_38F0B                                     ; 038DCF 22 0B 8F 03 
B_38DD3:
  SEC                                             ; 038DD3 38 
  LDA.W EntityYPx,X                                   ; 038DD4 BD 9C 0C 
  SBC.B #$10                                      ; 038DD7 E9 10 
  STA.B $05                                       ; 038DD9 85 05 
  SEC                                             ; 038DDB 38 
  LDA.W EntityXPx,X                              ; 038DDC BD 46 0B 
  SBC.W $06C8                                     ; 038DDF ED C8 06 
  BCS.B B_38E19                                   ; 038DE2 B0 35 
  PHX                                             ; 038DE4 DA 
  LDX.W $18D2                                     ; 038DE5 AE D2 18 
  DEC.W $18C5,X                                   ; 038DE8 DE C5 18 
  BNE.B B_38DF3                                   ; 038DEB D0 06 

.byte $9E,$C9,$18,$9E,$C1,$18                     ; 038DEE ......   ??????

B_38DF3:
  PLX                                             ; 038DF3 FA 
  STZ.W EntityHeader,X                                   ; 038DF4 9E D2 06 
  PHX                                             ; 038DF7 DA 
  LDY.W EntityV31,X                                   ; 038DF8 BC A0 14 
  JSL L_AEF1                                      ; 038DFB 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 038DFF BD A0 14 
  TAX                                             ; 038E02 AA 
  STZ.W StateFlags,X                                   ; 038E03 9E 5E 17 
  ASL                                             ; 038E06 0A 
  ASL                                             ; 038E07 0A 
  TAY                                             ; 038E08 A8 
  LDA.B #$F0                                      ; 038E09 A9 F0 
  BCC.B B_38E12                                   ; 038E0B 90 05 

.byte $99,$09,$04,$80,$03                         ; 038E0E .....    ?????

B_38E12:
  STA.W XexzyTorsoY,Y                             ; 038E12 99 09 03 
  PLX                                             ; 038E15 FA 
  JMP.W AdvanceToNextEntity                                   ; 038E16 4C 41 81 
B_38E19:
  STA.B $04                                       ; 038E19 85 04 
  SEC                                             ; 038E1B 38 
  LDA.B $04                                       ; 038E1C A5 04 
  SBC.B #$0B                                      ; 038E1E E9 0B 
  STA.B $04                                       ; 038E20 85 04 
  LDA.W EntityV31,X                                   ; 038E22 BD A0 14 
  ASL                                             ; 038E25 0A 
  ASL                                             ; 038E26 0A 
  TAY                                             ; 038E27 A8 
  BCC.B B_38E42                                   ; 038E28 90 18 

.byte $A5,$04,$99,$08,$04,$A5,$05,$99             ; 038E2A ........ ????????
.byte $09,$04,$BD,$BC,$13,$99,$0A,$04             ; 038E32 ........ ????????
.byte $BD,$2E,$14,$99,$0B,$04,$80,$16             ; 038E3A ........ ?.??????

B_38E42:
  LDA.B $04                                       ; 038E42 A5 04 
  STA.W $0308,Y                                   ; 038E44 99 08 03 
  LDA.B $05                                       ; 038E47 A5 05 
  STA.W XexzyTorsoY,Y                             ; 038E49 99 09 03 
  LDA.W EntityV29,X                                   ; 038E4C BD BC 13 
  STA.W $030A,Y                                   ; 038E4F 99 0A 03 
  LDA.W EntityV30,X                                   ; 038E52 BD 2E 14 
  STA.W $030B,Y                                   ; 038E55 99 0B 03 
  JMP.W AdvanceToNextEntity                                   ; 038E58 4C 41 81 

D_38E5B:
.byte $0A,$05,$14,$05                             ; 038E5C DDDD     ????

  DEC.W EntityV15,X                                   ; 038E5F DE 80 0D 
  BNE.B B_38E7F                                   ; 038E62 D0 1B 
  LDA.B #$28                                      ; 038E64 A9 28 
  STA.W EntityV15,X                                   ; 038E66 9D 80 0D 
  LDA.W EntityV25,X                                   ; 038E69 BD F4 11 
  STA.B $04                                       ; 038E6C 85 04 
B_38E6E:
  JSL AdvanceRNG                                     ; 038E6E 22 95 CA 0E 
  AND.B #$03                                      ; 038E72 29 03 
  CMP.B $04                                       ; 038E74 C5 04 
  BEQ.B B_38E6E                                   ; 038E76 F0 F6 
  STA.W EntityV25,X                                   ; 038E78 9D F4 11 
  JSL L_38F0B                                     ; 038E7B 22 0B 8F 03 
B_38E7F:
  SEC                                             ; 038E7F 38 
  LDA.W EntityYPx,X                                   ; 038E80 BD 9C 0C 
  SBC.B #$10                                      ; 038E83 E9 10 
  STA.B $05                                       ; 038E85 85 05 
  SEC                                             ; 038E87 38 
  LDA.W EntityXPx,X                              ; 038E88 BD 46 0B 
  SBC.W $06C8                                     ; 038E8B ED C8 06 
  BCS.B B_38EC5                                   ; 038E8E B0 35 
  PHX                                             ; 038E90 DA 
  LDX.W $18D2                                     ; 038E91 AE D2 18 
  DEC.W $18C5,X                                   ; 038E94 DE C5 18 
  BNE.B B_38E9F                                   ; 038E97 D0 06 
  STZ.W $18C9,X                                   ; 038E99 9E C9 18 
  STZ.W $18C1,X                                   ; 038E9C 9E C1 18 
B_38E9F:
  PLX                                             ; 038E9F FA 
  STZ.W EntityHeader,X                                   ; 038EA0 9E D2 06 
  PHX                                             ; 038EA3 DA 
  LDY.W EntityV31,X                                   ; 038EA4 BC A0 14 
  JSL L_AEF1                                      ; 038EA7 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 038EAB BD A0 14 
  TAX                                             ; 038EAE AA 
  STZ.W StateFlags,X                                   ; 038EAF 9E 5E 17 
  ASL                                             ; 038EB2 0A 
  ASL                                             ; 038EB3 0A 
  TAY                                             ; 038EB4 A8 
  LDA.B #$F0                                      ; 038EB5 A9 F0 
  BCC.B B_38EBE                                   ; 038EB7 90 05 

.byte $99,$09,$04,$80,$03                         ; 038EBA .....    ?????

B_38EBE:
  STA.W XexzyTorsoY,Y                             ; 038EBE 99 09 03 
  PLX                                             ; 038EC1 FA 
  JMP.W AdvanceToNextEntity                                   ; 038EC2 4C 41 81 
B_38EC5:
  STA.B $04                                       ; 038EC5 85 04 
  SEC                                             ; 038EC7 38 
  LDA.B $04                                       ; 038EC8 A5 04 
  SBC.B #$05                                      ; 038ECA E9 05 
  STA.B $04                                       ; 038ECC 85 04 
  LDA.W EntityV31,X                                   ; 038ECE BD A0 14 
  ASL                                             ; 038ED1 0A 
  ASL                                             ; 038ED2 0A 
  TAY                                             ; 038ED3 A8 
  BCC.B B_38EEE                                   ; 038ED4 90 18 

.byte $A5,$04,$99,$08,$04,$A5,$05,$99             ; 038ED6 ........ ????????
.byte $09,$04,$BD,$BC,$13,$99,$0A,$04             ; 038EDE ........ ????????
.byte $BD,$2E,$14,$99,$0B,$04,$80,$16             ; 038EE6 ........ ?.??????

B_38EEE:
  LDA.B $04                                       ; 038EEE A5 04 
  STA.W $0308,Y                                   ; 038EF0 99 08 03 
  LDA.B $05                                       ; 038EF3 A5 05 
  STA.W XexzyTorsoY,Y                             ; 038EF5 99 09 03 
  LDA.W EntityV29,X                                   ; 038EF8 BD BC 13 
  STA.W $030A,Y                                   ; 038EFB 99 0A 03 
  LDA.W EntityV30,X                                   ; 038EFE BD 2E 14 
  STA.W $030B,Y                                   ; 038F01 99 0B 03 
  JMP.W AdvanceToNextEntity                                   ; 038F04 4C 41 81 

.byte $14,$14,$14,$14                             ; 038F08 ....     ????


L_38F0B:
  LDA.W EntityV25,X                                   ; 038F0B BD F4 11 
  ASL                                             ; 038F0E 0A 
  TAY                                             ; 038F0F A8 
  LDA.W D_38F71,Y                                 ; 038F10 B9 71 8F 
  STA.B $08                                       ; 038F13 85 08 
  LDA.W D_38F72,Y                                 ; 038F15 B9 72 8F 
  STA.B $09                                       ; 038F18 85 09 
  LDA.W EntityV23,X                                   ; 038F1A BD 10 11 
  BEQ.B B_38F57                                   ; 038F1D F0 38 
  CMP.B #$01                                      ; 038F1F C9 01 
  BEQ.B B_38F3D                                   ; 038F21 F0 1A 
  REP.B #P_Idx8Bit                                      ; 038F23 C2 10 
  LDY.B $08                                       ; 038F25 A4 08 
  STY.W $1AC5                                     ; 038F27 8C C5 1A 
  LDY.W #$1801                                    ; 038F2A A0 01 18 
  STY.W $1AC3                                     ; 038F2D 8C C3 1A 
  LDA.B #$7E                                      ; 038F30 A9 7E 
  STA.W $1AC7                                     ; 038F32 8D C7 1A 
  LDA.B #$01                                      ; 038F35 A9 01 
  STA.W $1AC2                                     ; 038F37 8D C2 1A 
  SEP.B #P_Idx8Bit                                      ; 038F3A E2 10 
  RTL                                             ; 038F3C 6B 
B_38F3D:
  REP.B #P_Idx8Bit                                      ; 038F3D C2 10 
  LDY.B $08                                       ; 038F3F A4 08 
  STY.W $1ABD                                     ; 038F41 8C BD 1A 
  LDY.W #$1801                                    ; 038F44 A0 01 18 
  STY.W $1ABB                                     ; 038F47 8C BB 1A 
  LDA.B #$7E                                      ; 038F4A A9 7E 
  STA.W $1ABF                                     ; 038F4C 8D BF 1A 
  LDA.B #$01                                      ; 038F4F A9 01 
  STA.W $1ABA                                     ; 038F51 8D BA 1A 
  SEP.B #P_Idx8Bit                                      ; 038F54 E2 10 
  RTL                                             ; 038F56 6B 
B_38F57:
  REP.B #P_Idx8Bit                                      ; 038F57 C2 10 
  LDY.B $08                                       ; 038F59 A4 08 
  STY.W $1AB5                                     ; 038F5B 8C B5 1A 
  LDY.W #$1801                                    ; 038F5E A0 01 18 
  STY.W $1AB3                                     ; 038F61 8C B3 1A 
  LDA.B #$7E                                      ; 038F64 A9 7E 
  STA.W $1AB7                                     ; 038F66 8D B7 1A 
  LDA.B #$01                                      ; 038F69 A9 01 
  STA.W $1AB2                                     ; 038F6B 8D B2 1A 
  SEP.B #P_Idx8Bit                                      ; 038F6E E2 10 
  RTL                                             ; 038F70 6B 

D_38F71:
.byte $AE                                         ; 038F72 D        ?
D_38F72:
.byte $20,$AE,$22,$AE,$24,$AE,$26,$AE             ; 038F72 DDDDDDDD  ?"?$?&?
.byte $28,$AE,$2A,$AE,$2C,$AE,$2A                 ; 038F7B DDDDDDD  (?*?,?*

  SEC                                             ; 038F81 38 
  LDA.W EntityXPx,X                              ; 038F82 BD 46 0B 
  SBC.B #$08                                      ; 038F85 E9 08 
  STA.B $04                                       ; 038F87 85 04 
  LDA.W EntityXMovement,X                                   ; 038F89 BD B8 0B 
  SBC.B #$00                                      ; 038F8C E9 00 
  STA.B $05                                       ; 038F8E 85 05 
  SEC                                             ; 038F90 38 
  LDA.W EntityYPx,X                                   ; 038F91 BD 9C 0C 
  SBC.B #$09                                      ; 038F94 E9 09 
  STA.B $06                                       ; 038F96 85 06 
  LDA.W EntityYMovement,X                                   ; 038F98 BD 0E 0D 
  SBC.B #$00                                      ; 038F9B E9 00 
  STA.B $07                                       ; 038F9D 85 07 
  SEC                                             ; 038F9F 38 
  LDA.B $04                                       ; 038FA0 A5 04 
  SBC.W $06C8                                     ; 038FA2 ED C8 06 
  LDA.B $05                                       ; 038FA5 A5 05 
  SBC.W $06C9                                     ; 038FA7 ED C9 06 
  BNE.B B_38FCA                                   ; 038FAA D0 1E 
  SEC                                             ; 038FAC 38 
  LDA.B $06                                       ; 038FAD A5 06 
  SBC.W $06CA                                     ; 038FAF ED CA 06 
  STA.B $08                                       ; 038FB2 85 08 
  LDA.B $07                                       ; 038FB4 A5 07 
  SBC.W $06CB                                     ; 038FB6 ED CB 06 
  BEQ.B B_38FC3                                   ; 038FB9 F0 08 
  BPL.B B_38FCA                                   ; 038FBB 10 0D 
  LDA.B $08                                       ; 038FBD A5 08 
  CMP.B #$F0                                      ; 038FBF C9 F0 
  BCC.B B_38FCA                                   ; 038FC1 90 07 
B_38FC3:
  JSL L_AF42                                      ; 038FC3 22 42 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 038FC7 4C 41 81 
B_38FCA:
  STZ.W EntityHeader,X                                   ; 038FCA 9E D2 06 
  PHX                                             ; 038FCD DA 
  LDY.W EntityV31,X                                   ; 038FCE BC A0 14 
  JSL L_AEF1                                      ; 038FD1 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 038FD5 BD A0 14 
  TAX                                             ; 038FD8 AA 
  STZ.W StateFlags,X                                   ; 038FD9 9E 5E 17 
  ASL                                             ; 038FDC 0A 
  ASL                                             ; 038FDD 0A 
  TAY                                             ; 038FDE A8 
  LDA.B #$F0                                      ; 038FDF A9 F0 
  BCC.B B_38FE8                                   ; 038FE1 90 05 

.byte $99,$09,$04,$80,$03                         ; 038FE4 .....    ?????

B_38FE8:
  STA.W XexzyTorsoY,Y                             ; 038FE8 99 09 03 
  PLX                                             ; 038FEB FA 
  JMP.W AdvanceToNextEntity                                   ; 038FEC 4C 41 81 
  SEC                                             ; 038FEF 38 
  LDA.W EntityXPx,X                              ; 038FF0 BD 46 0B 
  SBC.B #$08                                      ; 038FF3 E9 08 
  STA.B $04                                       ; 038FF5 85 04 
  LDA.W EntityXMovement,X                                   ; 038FF7 BD B8 0B 
  SBC.B #$00                                      ; 038FFA E9 00 
  STA.B $05                                       ; 038FFC 85 05 
  SEC                                             ; 038FFE 38 
  LDA.W EntityYPx,X                                   ; 038FFF BD 9C 0C 
  SBC.B #$09                                      ; 039002 E9 09 
  STA.B $06                                       ; 039004 85 06 
  LDA.W EntityYMovement,X                                   ; 039006 BD 0E 0D 
  SBC.B #$00                                      ; 039009 E9 00 
  STA.B $07                                       ; 03900B 85 07 
  JSL L_AF42                                      ; 03900D 22 42 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 039011 4C 41 81 
  LDA.W EntityXPxSpeed,X                                   ; 039014 BD 7E 09 
  BMI.B B_3902B                                   ; 039017 30 12 
  ORA.W EntityXSubPxSpeed,X                                   ; 039019 1D 0C 09 
  BEQ.B B_39038                                   ; 03901C F0 1A 
  LDA.B #$EE                                      ; 03901E A9 EE 
  CMP.W EntityXPx,X                              ; 039020 DD 46 0B 
  BCS.B B_39038                                   ; 039023 B0 13 
  STA.W EntityXPx,X                              ; 039025 9D 46 0B 
  JMP.W D_39079                                   ; 039028 4C 79 90 
B_3902B:
  LDA.B #$12                                      ; 03902B A9 12 
  CMP.W EntityXPx,X                              ; 03902D DD 46 0B 
  BCC.B B_39038                                   ; 039030 90 06 
  STA.W EntityXPx,X                              ; 039032 9D 46 0B 
  JMP.W D_39079                                   ; 039035 4C 79 90 
B_39038:
  LDA.W EntityYPxSpeed,X                                   ; 039038 BD 62 0A 
  BMI.B B_3904F                                   ; 03903B 30 12 
  ORA.W EntityYSubPxSpeed,X                                   ; 03903D 1D F0 09 
  BEQ.B B_3905C                                   ; 039040 F0 1A 
  LDA.B #$DC                                      ; 039042 A9 DC 
  CMP.W EntityYPx,X                                   ; 039044 DD 9C 0C 
  BCS.B B_3905C                                   ; 039047 B0 13 
  STA.W EntityYPx,X                                   ; 039049 9D 9C 0C 
  JMP.W D_39079                                   ; 03904C 4C 79 90 
B_3904F:
  LDA.B #$20                                      ; 03904F A9 20 
  CMP.W EntityYPx,X                                   ; 039051 DD 9C 0C 
  BCC.B B_3905C                                   ; 039054 90 06 
  STA.W EntityYPx,X                                   ; 039056 9D 9C 0C 
  JMP.W D_39079                                   ; 039059 4C 79 90 
B_3905C:
  LDA.B $D2                                       ; 03905C A5 D2 
  LSR                                             ; 03905E 4A 
  LSR                                             ; 03905F 4A 
  LSR                                             ; 039060 4A 
  AND.B #$01                                      ; 039061 29 01 
  TAY                                             ; 039063 A8 
  LDA.W D_3909E,Y                                 ; 039064 B9 9E 90 
  STA.W EntityV30,X                                   ; 039067 9D 2E 14 
  LDA.B #$04                                      ; 03906A A9 04 
  STA.B $1C                                       ; 03906C 85 1C 
  LDA.B #$05                                      ; 03906E A9 05 
  STA.B $1D                                       ; 039070 85 1D 
  JSL L_AFC2                                      ; 039072 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 039076 4C 41 81 
D_39079:
  STZ.W EntityHeader,X                                   ; 039079 9E D2 06 
  PHX                                             ; 03907C DA 
  LDY.W EntityV31,X                                   ; 03907D BC A0 14 
  JSL L_AEF1                                      ; 039080 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 039084 BD A0 14 
  TAX                                             ; 039087 AA 
  STZ.W StateFlags,X                                   ; 039088 9E 5E 17 
  ASL                                             ; 03908B 0A 
  ASL                                             ; 03908C 0A 
  TAY                                             ; 03908D A8 
  LDA.B #$F0                                      ; 03908E A9 F0 
  BCC.B B_39097                                   ; 039090 90 05 
  STA.W $0409,Y                                   ; 039092 99 09 04 
  BRA.B B_3909A                                   ; 039095 80 03 

B_39097:
.byte $99,$09,$03                                 ; 039098 ...      ???

B_3909A:
  PLX                                             ; 03909A FA 
  JMP.W AdvanceToNextEntity                                   ; 03909B 4C 41 81 

D_3909E:
.byte $33,$31,$A5,$D2,$29,$01,$D0,$3F             ; 03909E DD...... 31??)???
.byte $DE,$80,$0D,$D0,$12,$9E,$D2,$06             ; 0390A6 ........ ????????
.byte $9C,$C8,$06,$9C,$C9,$06,$9C,$CA             ; 0390AE ........ ????????
.byte $06,$9C,$CB,$06,$4C,$41,$81,$22             ; 0390B6 ........ ????LA?"
.byte $95,$CA,$0E,$29,$07,$0A,$A8,$B9             ; 0390BE ........ ???)????
.byte $E8,$90,$8D,$C8,$06,$B9,$E9,$90             ; 0390C6 ........ ????????
.byte $8D,$C9,$06,$22,$95,$CA,$0E,$29             ; 0390CE ........ ???"???)
.byte $07,$0A,$A8,$B9,$E8,$90,$8D,$CA             ; 0390D6 ........ ????????
.byte $06,$B9,$E9,$90,$8D,$CB,$06,$4C             ; 0390DE ........ ???????L
.byte $41,$81,$00,$00,$01,$00,$FF,$FF             ; 0390E6 ........ A???????
.byte $00,$00,$01,$00,$FF,$FF,$00,$00             ; 0390EE ........ ????????
.byte $00,$00,$DE,$4A,$13,$D0,$3C,$A9             ; 0390F6 ........ ???J??<?
.byte $04,$9D,$4A,$13,$BC,$D8,$12,$C8             ; 0390FE ........ ??J?????
.byte $C0,$05,$D0,$25,$9E,$D2,$06,$DA             ; 039106 ........ ???%????
.byte $BC,$A0,$14,$22,$F1,$AE,$00,$BD             ; 03910E ........ ???"????
.byte $A0,$14,$AA,$9E,$5E,$17,$0A,$0A             ; 039116 ........ ????^???
.byte $A8,$A9,$F0,$90,$05,$99,$09,$04             ; 03911E ........ ????????
.byte $80,$03,$99,$09,$03,$FA,$4C,$41             ; 039126 ........ ??????LA
.byte $81,$98,$9D,$D8,$12,$B9,$48,$91             ; 03912E ........ ??????H?
.byte $9D,$BC,$13,$A9,$08,$85,$1C,$A9             ; 039136 ........ ????????
.byte $09,$85,$1D,$22,$C2,$AF,$00,$4C             ; 03913E ........ ???"???L
.byte $41,$81,$A0,$A2,$A4,$A6,$A8,$DE             ; 039146 ........ A???????
.byte $4A,$13,$D0,$57,$A9,$05,$9D,$4A             ; 03914E ........ J??W???J
.byte $13,$BC,$D8,$12,$C8,$C0,$08,$D0             ; 039156 ........ ????????
.byte $40,$CE,$EF,$18,$CE,$C6,$06,$DA             ; 03915E ........ @???????
.byte $BC,$2C,$10,$30,$0E,$BE,$D6,$18             ; 039166 ........ ?,?0????
.byte $DE,$C5,$18,$D0,$06,$9E,$C9,$18             ; 03916E ........ ????????
.byte $9E,$C1,$18,$FA,$9E,$D2,$06,$DA             ; 039176 ........ ????????
.byte $BC,$A0,$14,$22,$F1,$AE,$00,$BD             ; 03917E ........ ???"????
.byte $A0,$14,$AA,$9E,$5E,$17,$0A,$0A             ; 039186 ........ ????^???
.byte $A8,$A9,$F0,$90,$05,$99,$09,$04             ; 03918E ........ ????????
.byte $80,$03,$99,$09,$03,$FA,$4C,$41             ; 039196 ........ ??????LA
.byte $81,$98,$9D,$D8,$12,$B9,$B8,$91             ; 03919E ........ ????????
.byte $9D,$BC,$13,$A9,$08,$85,$1C,$A9             ; 0391A6 ........ ????????
.byte $09,$85,$1D,$22,$C2,$AF,$00,$4C             ; 0391AE ........ ???"???L
.byte $41,$81,$80,$82,$84,$86,$88,$8A             ; 0391B6 ........ A???????
.byte $8C,$8E                                     ; 0391BF ..       ??

  SEC                                             ; 0391C0 38 
  LDA.W EntityXPx,X                              ; 0391C1 BD 46 0B 
  SBC.B #$07                                      ; 0391C4 E9 07 
  BCS.B B_391CA                                   ; 0391C6 B0 02 

.byte $A9,$00                                     ; 0391C9 ..       ??

B_391CA:
  STA.W EntityV32,X                                   ; 0391CA 9D 16 15 
  CLC                                             ; 0391CD 18 
  LDA.W EntityXPx,X                              ; 0391CE BD 46 0B 
  ADC.B #$07                                      ; 0391D1 69 07 
  BCC.B B_391D7                                   ; 0391D3 90 02 

.byte $A9,$FF                                     ; 0391D6 ..       ??

B_391D7:
  STA.W EntityV33,X                                   ; 0391D7 9D 88 15 
  SEC                                             ; 0391DA 38 
  LDA.W EntityYPx,X                                   ; 0391DB BD 9C 0C 
  SBC.B #$08                                      ; 0391DE E9 08 
  BCS.B B_391E4                                   ; 0391E0 B0 02 

.byte $A9,$00                                     ; 0391E3 ..       ??

B_391E4:
  STA.W EntityV34,X                                   ; 0391E4 9D FA 15 
  CLC                                             ; 0391E7 18 
  LDA.W EntityYPx,X                                   ; 0391E8 BD 9C 0C 
  ADC.B #$08                                      ; 0391EB 69 08 
  BCC.B B_391F1                                   ; 0391ED 90 02 

.byte $A9,$FF                                     ; 0391F0 ..       ??

B_391F1:
  STA.W EntityV35,X                                   ; 0391F1 9D 6C 16 
  DEC.W EntityV15,X                                   ; 0391F4 DE 80 0D 
  BNE.B B_39208                                   ; 0391F7 D0 0F 
  LDA.B #$16                                      ; 0391F9 A9 16 
  STA.W EntityTypeId,X                                   ; 0391FB 9D 44 07 
  LDA.B #$01                                      ; 0391FE A9 01 
  STA.W EntityV15,X                                   ; 039200 9D 80 0D 
  LDA.B #$1E                                      ; 039203 A9 1E 
  STA.W EntityV17,X                                   ; 039205 9D 64 0E 
B_39208:
  SEC                                             ; 039208 38 
  LDA.W EntityXPx,X                              ; 039209 BD 46 0B 
  SBC.B #$08                                      ; 03920C E9 08 
  STA.B $04                                       ; 03920E 85 04 
  LDA.W EntityXMovement,X                                   ; 039210 BD B8 0B 
  SBC.B #$00                                      ; 039213 E9 00 
  STA.B $05                                       ; 039215 85 05 
  SEC                                             ; 039217 38 
  LDA.W EntityYPx,X                                   ; 039218 BD 9C 0C 
  SBC.B #$0A                                      ; 03921B E9 0A 
  STA.B $06                                       ; 03921D 85 06 
  LDA.W EntityYMovement,X                                   ; 03921F BD 0E 0D 
  SBC.B #$00                                      ; 039222 E9 00 
  STA.B $07                                       ; 039224 85 07 
  JSL L_AF42                                      ; 039226 22 42 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03922A 4C 41 81 
  LDA.W EntityV15,X                                   ; 03922D BD 80 0D 
  BEQ.B B_39238                                   ; 039230 F0 06 
  DEC.W EntityV15,X                                   ; 039232 DE 80 0D 
  JMP.W AdvanceToNextEntity                                   ; 039235 4C 41 81 
B_39238:
  LDA.W EntityV22,X                                   ; 039238 BD 9E 10 
  STA.B $0C                                       ; 03923B 85 0C 
  LDA.B #$02                                      ; 03923D A9 02 
  STA.B $07                                       ; 03923F 85 07 
  LDA.B #$20                                      ; 039241 A9 20 
  STA.W EntityV15,X                                   ; 039243 9D 80 0D 
  LDA.W EntityXPx,X                              ; 039246 BD 46 0B 
  STA.B $04                                       ; 039249 85 04 
  LDA.W EntityYPx,X                                   ; 03924B BD 9C 0C 
  STA.B $05                                       ; 03924E 85 05 
  LDA.W EntityV20,X                                   ; 039250 BD BA 0F 
  STA.B $08                                       ; 039253 85 08 
  LDA.W EntityV21,X                                   ; 039255 BD 2C 10 
  STA.B $06                                       ; 039258 85 06 
  BNE.B B_3926D                                   ; 03925A D0 11 
  LDA.W $05E4                                     ; 03925C AD E4 05 
  BNE.B B_3926D                                   ; 03925F D0 0C 
  LDA.W $05E3                                     ; 039261 AD E3 05 
  CMP.B #$5A                                      ; 039264 C9 5A 
  BCS.B B_3926D                                   ; 039266 B0 05 
  LDA.B #$5A                                      ; 039268 A9 5A 
  STA.W $05E3                                     ; 03926A 8D E3 05 
B_3926D:
  STX.B $09                                       ; 03926D 86 09 
B_3926F:
  DEC.B $08                                       ; 03926F C6 08 
  BEQ.B B_392D4                                   ; 039271 F0 61 
  JSL FindEmptyEntitySlot                                     ; 039273 22 F3 80 03 
  BNE.B B_392CA                                   ; 039277 D0 51 
  LDA.B $0C                                       ; 039279 A5 0C 
  ASL                                             ; 03927B 0A 
  ASL                                             ; 03927C 0A 
  ASL                                             ; 03927D 0A 
  STA.B $12                                       ; 03927E 85 12 
  JSL AdvanceRNG                                     ; 039280 22 95 CA 0E 
  AND.B #$07                                      ; 039284 29 07 
  CLC                                             ; 039286 18 
  ADC.B $12                                       ; 039287 65 12 
  TAY                                             ; 039289 A8 
  LDA.W D_393F8,Y                                 ; 03928A B9 F8 93 
  BEQ.B B_392A6                                   ; 03928D F0 17 
  LDA.B #$06                                      ; 03928F A9 06 
  JSL L_38064                                     ; 039291 22 64 80 03 
  BMI.B B_392A6                                   ; 039295 30 0F 
  STY.W $18D4                                     ; 039297 8C D4 18 
  TYA                                             ; 03929A 98 
  ASL                                             ; 03929B 0A 
  ORA.B #$38                                      ; 03929C 09 38 
  STA.B $0A                                       ; 03929E 85 0A 
  LDA.B #$01                                      ; 0392A0 A9 01 
  STA.B $0E                                       ; 0392A2 85 0E 
  BRA.B B_392B9                                   ; 0392A4 80 13 
B_392A6:
  LDA.B #$05                                      ; 0392A6 A9 05 
  JSL L_38064                                     ; 0392A8 22 64 80 03 
  BMI.B B_392CA                                   ; 0392AC 30 1C 
  STY.W $18D3                                     ; 0392AE 8C D3 18 
  TYA                                             ; 0392B1 98 
  ASL                                             ; 0392B2 0A 
  ORA.B #$38                                      ; 0392B3 09 38 
  STA.B $0A                                       ; 0392B5 85 0A 
  STZ.B $0E                                       ; 0392B7 64 0E 
B_392B9:
  INC.W $06C6                                     ; 0392B9 EE C6 06 
  INC.W $18E4                                     ; 0392BC EE E4 18 
  JSL ClearEntitySlotData                                     ; 0392BF 22 94 80 03 
  JSR.W L_3932D                                   ; 0392C3 20 2D 93 
  DEC.B $07                                       ; 0392C6 C6 07 
  BPL.B B_3926F                                   ; 0392C8 10 A5 
B_392CA:
  LDX.B $09                                       ; 0392CA A6 09 
  LDA.B $08                                       ; 0392CC A5 08 
  STA.W EntityV20,X                                   ; 0392CE 9D BA 0F 
  JMP.W AdvanceToNextEntity                                   ; 0392D1 4C 41 81 
B_392D4:
  LDX.B $09                                       ; 0392D4 A6 09 
  LDA.B $0C                                       ; 0392D6 A5 0C 
  ASL                                             ; 0392D8 0A 
  ASL                                             ; 0392D9 0A 
  ASL                                             ; 0392DA 0A 
  STA.B $12                                       ; 0392DB 85 12 
  JSL AdvanceRNG                                     ; 0392DD 22 95 CA 0E 
  AND.B #$07                                      ; 0392E1 29 07 
  CLC                                             ; 0392E3 18 
  ADC.B $12                                       ; 0392E4 65 12 
  TAY                                             ; 0392E6 A8 
  LDA.W D_393F8,Y                                 ; 0392E7 B9 F8 93 
  BEQ.B B_39303                                   ; 0392EA F0 17 
  LDA.B #$06                                      ; 0392EC A9 06 
  JSL L_38064                                     ; 0392EE 22 64 80 03 
  BMI.B B_39303                                   ; 0392F2 30 0F 
  STY.W $18D4                                     ; 0392F4 8C D4 18 
  TYA                                             ; 0392F7 98 
  ASL                                             ; 0392F8 0A 
  ORA.B #$38                                      ; 0392F9 09 38 
  STA.B $0A                                       ; 0392FB 85 0A 
  LDA.B #$01                                      ; 0392FD A9 01 
  STA.B $0E                                       ; 0392FF 85 0E 
  BRA.B B_39316                                   ; 039301 80 13 
B_39303:
  LDA.B #$05                                      ; 039303 A9 05 
  JSL L_38064                                     ; 039305 22 64 80 03 
  BMI.B B_39325                                   ; 039309 30 1A 
  STY.W $18D3                                     ; 03930B 8C D3 18 
  TYA                                             ; 03930E 98 
  ASL                                             ; 03930F 0A 
  ORA.B #$38                                      ; 039310 09 38 
  STA.B $0A                                       ; 039312 85 0A 
  STZ.B $0E                                       ; 039314 64 0E 
B_39316:
  JSR.W L_3932D                                   ; 039316 20 2D 93 
  SEC                                             ; 039319 38 
  LDA.W $18E4                                     ; 03931A AD E4 18 
  SBC.B #$05                                      ; 03931D E9 05 
  STA.W $18E4                                     ; 03931F 8D E4 18 
  JMP.W AdvanceToNextEntity                                   ; 039322 4C 41 81 

B_39325:
.byte $A9,$01,$9D,$BA,$0F,$4C,$41,$81             ; 039325 ........ ?????LA?


L_3932D:
  LDA.B #$01                                      ; 03932D A9 01 
  STA.W EntityHeader,X                                   ; 03932F 9D D2 06 
  LDA.B #$15                                      ; 039332 A9 15 
  STA.W EntityTypeId,X                                   ; 039334 9D 44 07 
  LDA.B #$0C                                      ; 039337 A9 0C 
  STA.W EntityV3,X                                   ; 039339 9D 28 08 
  JSL AdvanceRNG                                     ; 03933C 22 95 CA 0E 
  AND.B #$01                                      ; 039340 29 01 
  STA.W EntityV20,X                                   ; 039342 9D BA 0F 
  JSL AdvanceRNG                                     ; 039345 22 95 CA 0E 
  AND.B #$3F                                      ; 039349 29 3F 
  CLC                                             ; 03934B 18 
  ADC.B #$32                                      ; 03934C 69 32 
  STA.W EntityV15,X                                   ; 03934E 9D 80 0D 
  LDA.B #$1E                                      ; 039351 A9 1E 
  STA.W EntityV17,X                                   ; 039353 9D 64 0E 
  LDA.B $06                                       ; 039356 A5 06 
  ASL                                             ; 039358 0A 
  ASL                                             ; 039359 0A 
  CLC                                             ; 03935A 18 
  ADC.B $07                                       ; 03935B 65 07 
  TAY                                             ; 03935D A8 
  CLC                                             ; 03935E 18 
  LDA.B $04                                       ; 03935F A5 04 
  ADC.W D_39444,Y                                 ; 039361 79 44 94 
  STA.W EntityXPx,X                              ; 039364 9D 46 0B 
  CLC                                             ; 039367 18 
  LDA.B $05                                       ; 039368 A5 05 
  ADC.W D_39454,Y                                 ; 03936A 79 54 94 
  STA.W EntityYPx,X                                   ; 03936D 9D 9C 0C 
  SEC                                             ; 039370 38 
  LDA.W EntityXPx,X                              ; 039371 BD 46 0B 
  SBC.B #$07                                      ; 039374 E9 07 
  BCS.B B_3937A                                   ; 039376 B0 02 
  LDA.B #$00                                      ; 039378 A9 00 
B_3937A:
  STA.W EntityV32,X                                   ; 03937A 9D 16 15 
  CLC                                             ; 03937D 18 
  LDA.W EntityXPx,X                              ; 03937E BD 46 0B 
  ADC.B #$07                                      ; 039381 69 07 
  BCC.B B_39387                                   ; 039383 90 02 
  LDA.B #$FF                                      ; 039385 A9 FF 
B_39387:
  STA.W EntityV33,X                                   ; 039387 9D 88 15 
  SEC                                             ; 03938A 38 
  LDA.W EntityYPx,X                                   ; 03938B BD 9C 0C 
  SBC.B #$08                                      ; 03938E E9 08 
  BCS.B B_39394                                   ; 039390 B0 02 
  LDA.B #$00                                      ; 039392 A9 00 
B_39394:
  STA.W EntityV34,X                                   ; 039394 9D FA 15 
  CLC                                             ; 039397 18 
  LDA.W EntityYPx,X                                   ; 039398 BD 9C 0C 
  ADC.B #$08                                      ; 03939B 69 08 
  BCC.B B_393A1                                   ; 03939D 90 02 

.byte $A9,$FF                                     ; 0393A0 ..       ??

B_393A1:
  STA.W EntityV35,X                                   ; 0393A1 9D 6C 16 
  LDA.B $0E                                       ; 0393A4 A5 0E 
  STA.W EntityV22,X                                   ; 0393A6 9D 9E 10 
  STA.W EntityV24,X                                   ; 0393A9 9D 82 11 
  ASL                                             ; 0393AC 0A 
  ASL                                             ; 0393AD 0A 
  ASL                                             ; 0393AE 0A 
  STA.B $0D                                       ; 0393AF 85 0D 
  LDA.B $06                                       ; 0393B1 A5 06 
  ASL                                             ; 0393B3 0A 
  CLC                                             ; 0393B4 18 
  ADC.B $0D                                       ; 0393B5 65 0D 
  TAY                                             ; 0393B7 A8 
  LDA.W D_39464,Y                                 ; 0393B8 B9 64 94 
  STA.W EntityXSubPxSpeed,X                                   ; 0393BB 9D 0C 09 
  LDA.W D_39465,Y                                 ; 0393BE B9 65 94 
  STA.W EntityXPxSpeed,X                                   ; 0393C1 9D 7E 09 
  LDA.W D_39474,Y                                 ; 0393C4 B9 74 94 
  STA.W EntityYSubPxSpeed,X                                   ; 0393C7 9D F0 09 
  LDA.W D_39475,Y                                 ; 0393CA B9 75 94 
  STA.W EntityYPxSpeed,X                                   ; 0393CD 9D 62 0A 
  LDY.B $06                                       ; 0393D0 A4 06 
  LDA.W D_39438,Y                                 ; 0393D2 B9 38 94 
  STA.W EntityV23,X                                   ; 0393D5 9D 10 11 
  LDA.W D_3943C,Y                                 ; 0393D8 B9 3C 94 
  STA.W EntityV29,X                                   ; 0393DB 9D BC 13 
  LDA.B $0A                                       ; 0393DE A5 0A 
  ORA.W D_39440,Y                                 ; 0393E0 19 40 94 
  STA.W EntityV30,X                                   ; 0393E3 9D 2E 14 
  JSL L_AEBC                                      ; 0393E6 22 BC AE 00 
  TYA                                             ; 0393EA 98 
  STA.W EntityV31,X                                   ; 0393EB 9D A0 14 
  LDA.B #$01                                      ; 0393EE A9 01 
  STA.W StateFlags,Y                                   ; 0393F0 99 5E 17 
  JSL L_AEF1                                      ; 0393F3 22 F1 AE 00 
  RTS                                             ; 0393F7 60 


D_393F8:
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 0393F8 DDDDDDDD ????????
.byte $00,$00,$00,$00,$01,$00,$00,$00             ; 039400 DDDDDDDD ????????
.byte $00,$00,$00,$00,$01,$01,$00,$00             ; 039408 ........ ????????
.byte $00,$00,$01,$00,$01,$01,$00,$00             ; 039410 DDDDDDDD ????????
.byte $00,$00,$00,$01,$01,$01,$01,$00             ; 039418 DDDDDDDD ????????
.byte $00,$00,$01,$00,$01,$01,$01,$00             ; 039420 ........ ????????
.byte $00,$01,$01,$01,$00,$01,$01,$00             ; 039428 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 039430 ........ ????????
D_39438:
.byte $04,$06,$00,$02                             ; 039439 DDDD     ????
D_3943C:
.byte $CC,$C8,$C4,$C8                             ; 03943D DDDD     ????
D_39440:
.byte $00,$40,$00,$00                             ; 039441 DDDD     ?@??
D_39444:
.byte $F6,$0A,$00,$00,$00,$00,$FC,$00             ; 039444 DDD.DDD. ????????
.byte $F6,$0A,$00,$00,$00,$00,$04,$00             ; 03944C DDD.DDD. ????????
D_39454:
.byte $00,$00,$04,$00,$F6,$09,$00,$00             ; 039454 DDD.DDD. ????????
.byte $00,$00,$FC,$00,$F6,$09,$00,$00             ; 03945C DDD.DDD. ????????
D_39464:
.byte $00                                         ; 039465 D        ?
D_39465:
.byte $00,$80,$FF,$00,$00,$80,$00,$00             ; 039465 DDDDDDDD ????????
.byte $00,$48,$FF,$00,$00,$B8,$00                 ; 03946E DDDDDDD  ?H?????
D_39474:
.byte $80                                         ; 039475 D        ?
D_39475:
.byte $00,$00,$00,$80,$FF,$00,$00,$B8             ; 039475 DDDDDDDD ????????
.byte $00,$00,$00,$48,$FF,$00,$00                 ; 03947E DDDDDDD  ???H???

  SEC                                             ; 039484 38 
  LDA.W EntityXPx,X                              ; 039485 BD 46 0B 
  SBC.B #$07                                      ; 039488 E9 07 
  BCS.B B_3948E                                   ; 03948A B0 02 
  LDA.B #$00                                      ; 03948C A9 00 
B_3948E:
  STA.W EntityV32,X                                   ; 03948E 9D 16 15 
  CLC                                             ; 039491 18 
  LDA.W EntityXPx,X                              ; 039492 BD 46 0B 
  ADC.B #$07                                      ; 039495 69 07 
  BCC.B B_3949B                                   ; 039497 90 02 
  LDA.B #$FF                                      ; 039499 A9 FF 
B_3949B:
  STA.W EntityV33,X                                   ; 03949B 9D 88 15 
  SEC                                             ; 03949E 38 
  LDA.W EntityYPx,X                                   ; 03949F BD 9C 0C 
  SBC.B #$08                                      ; 0394A2 E9 08 
  BCS.B B_394A8                                   ; 0394A4 B0 02 
  LDA.B #$00                                      ; 0394A6 A9 00 
B_394A8:
  STA.W EntityV34,X                                   ; 0394A8 9D FA 15 
  CLC                                             ; 0394AB 18 
  LDA.W EntityYPx,X                                   ; 0394AC BD 9C 0C 
  ADC.B #$08                                      ; 0394AF 69 08 
  BCC.B B_394B5                                   ; 0394B1 90 02 

.byte $A9,$FF                                     ; 0394B4 ..       ??

B_394B5:
  STA.W EntityV35,X                                   ; 0394B5 9D 6C 16 
  LDA.B #$08                                      ; 0394B8 A9 08 
  STA.B $1C                                       ; 0394BA 85 1C 
  LDA.B #$0A                                      ; 0394BC A9 0A 
  STA.B $1D                                       ; 0394BE 85 1D 
  JSL L_AFC2                                      ; 0394C0 22 C2 AF 00 
  DEC.W EntityV15,X                                   ; 0394C4 DE 80 0D 
  BNE.B B_39519                                   ; 0394C7 D0 50 
  JSL AdvanceRNG                                     ; 0394C9 22 95 CA 0E 
  AND.B #$3F                                      ; 0394CD 29 3F 
  CLC                                             ; 0394CF 18 
  ADC.B #$20                                      ; 0394D0 69 20 
  STA.W EntityV15,X                                   ; 0394D2 9D 80 0D 
  JSL AdvanceRNG                                     ; 0394D5 22 95 CA 0E 
  AND.B #$07                                      ; 0394D9 29 07 
  TAY                                             ; 0394DB A8 
  LDA.W D_3951C,Y                                 ; 0394DC B9 1C 95 
  STA.W EntityV29,X                                   ; 0394DF 9D BC 13 
  LDA.W EntityV30,X                                   ; 0394E2 BD 2E 14 
  AND.B #$3F                                      ; 0394E5 29 3F 
  ORA.W D_39524,Y                                 ; 0394E7 19 24 95 
  STA.W EntityV30,X                                   ; 0394EA 9D 2E 14 
  LDA.W EntityV24,X                                   ; 0394ED BD 82 11 
  ASL                                             ; 0394F0 0A 
  ASL                                             ; 0394F1 0A 
  ASL                                             ; 0394F2 0A 
  ASL                                             ; 0394F3 0A 
  STA.B $04                                       ; 0394F4 85 04 
  TYA                                             ; 0394F6 98 
  ASL                                             ; 0394F7 0A 
  CLC                                             ; 0394F8 18 
  ADC.B $04                                       ; 0394F9 65 04 
  TAY                                             ; 0394FB A8 
  LDA.W D_396E2,Y                                 ; 0394FC B9 E2 96 
  STA.W EntityXSubPxSpeed,X                                   ; 0394FF 9D 0C 09 
  LDA.W D_396E3,Y                                 ; 039502 B9 E3 96 
  STA.W EntityXPxSpeed,X                                   ; 039505 9D 7E 09 
  LDA.W D_39732,Y                                 ; 039508 B9 32 97 
  STA.W EntityYSubPxSpeed,X                                   ; 03950B 9D F0 09 
  LDA.W D_39733,Y                                 ; 03950E B9 33 97 
  STA.W EntityYPxSpeed,X                                   ; 039511 9D 62 0A 
  LDA.B #$16                                      ; 039514 A9 16 
  STA.W EntityTypeId,X                                   ; 039516 9D 44 07 
B_39519:
  JMP.W AdvanceToNextEntity                                   ; 039519 4C 41 81 

D_3951C:
.byte $C4,$C6,$C8,$CA,$CC,$CA,$C8,$C6             ; 03951C DDDDDDDD ????????
D_39524:
.byte $00,$00,$00,$00,$00,$40,$40,$40             ; 039524 DDDDDDDD ?????@@@

  DEC.W EntityV15,X                                   ; 03952C DE 80 0D 
  BEQ.B B_3956A                                   ; 03952F F0 39 
  LDA.W EntityXPxSpeed,X                                   ; 039531 BD 7E 09 
  BMI.B B_39545                                   ; 039534 30 0F 
  ORA.W EntityXSubPxSpeed,X                                   ; 039536 1D 0C 09 
  BEQ.B B_3954C                                   ; 039539 F0 11 
  LDA.W EntityXPx,X                              ; 03953B BD 46 0B 
  CMP.B #$E7                                      ; 03953E C9 E7 
  BCS.B B_3956A                                   ; 039540 B0 28 
  JMP.W B_3954C                                   ; 039542 4C 4C 95 
B_39545:
  LDA.W EntityXPx,X                              ; 039545 BD 46 0B 
  CMP.B #$19                                      ; 039548 C9 19 
  BCC.B B_3956A                                   ; 03954A 90 1E 
B_3954C:
  LDA.W EntityYPxSpeed,X                                   ; 03954C BD 62 0A 
  BMI.B B_39560                                   ; 03954F 30 0F 
  ORA.W EntityYSubPxSpeed,X                                   ; 039551 1D F0 09 
  BEQ.B B_39567                                   ; 039554 F0 11 
  LDA.W EntityYPx,X                                   ; 039556 BD 9C 0C 
  CMP.B #$D4                                      ; 039559 C9 D4 
  BCS.B B_3956A                                   ; 03955B B0 0D 
  JMP.W D_39641                                   ; 03955D 4C 41 96 
B_39560:
  LDA.W EntityYPx,X                                   ; 039560 BD 9C 0C 
  CMP.B #$28                                      ; 039563 C9 28 
  BCC.B B_3956A                                   ; 039565 90 03 
B_39567:
  JMP.W D_39641                                   ; 039567 4C 41 96 
B_3956A:
  DEC.W EntityV17,X                                   ; 03956A DE 64 0E 
  BNE.B B_3957F                                   ; 03956D D0 10 

.byte $A9,$0F,$9D,$64,$0E,$BD,$82,$11             ; 03956F ........ ???d????
.byte $C9,$04,$F0,$04,$1A,$9D,$82,$11             ; 039577 ........ ????????

B_3957F:
  STZ.B $06                                       ; 03957F 64 06 
  JSL AdvanceRNG                                     ; 039581 22 95 CA 0E 
  AND.B #$20                                      ; 039585 29 20 
  CLC                                             ; 039587 18 
  ADC.B #$10                                      ; 039588 69 10 
  STA.W EntityV15,X                                   ; 03958A 9D 80 0D 
  LDY.W EntityV20,X                                   ; 03958D BC BA 0F 
  LDA.W EntityXPx,Y                              ; 039590 B9 46 0B 
  STA.B $04                                       ; 039593 85 04 
  LDA.W EntityYPx,Y                                   ; 039595 B9 9C 0C 
  STA.B $05                                       ; 039598 85 05 
  JSL AdvanceRNG                                     ; 03959A 22 95 CA 0E 
  AND.B #$0F                                      ; 03959E 29 0F 
  ASL                                             ; 0395A0 0A 
  TAY                                             ; 0395A1 A8 
  CLC                                             ; 0395A2 18 
  LDA.B $04                                       ; 0395A3 A5 04 
  ADC.W D_39782,Y                                 ; 0395A5 79 82 97 
  STA.B $04                                       ; 0395A8 85 04 
  CLC                                             ; 0395AA 18 
  LDA.B $05                                       ; 0395AB A5 05 
  ADC.W D_39783,Y                                 ; 0395AD 79 83 97 
  STA.B $05                                       ; 0395B0 85 05 
  SEC                                             ; 0395B2 38 
  LDA.B $04                                       ; 0395B3 A5 04 
  SBC.B #$08                                      ; 0395B5 E9 08 
  CMP.W EntityXPx,X                              ; 0395B7 DD 46 0B 
  BCC.B B_395C3                                   ; 0395BA 90 07 
  LDA.B #$04                                      ; 0395BC A9 04 
  STA.B $06                                       ; 0395BE 85 06 
  JMP.W D_395D1                                   ; 0395C0 4C D1 95 
B_395C3:
  CLC                                             ; 0395C3 18 
  LDA.B $04                                       ; 0395C4 A5 04 
  ADC.B #$08                                      ; 0395C6 69 08 
  CMP.W EntityXPx,X                              ; 0395C8 DD 46 0B 
  BCS.B D_395D1                                   ; 0395CB B0 04 
  LDA.B #$08                                      ; 0395CD A9 08 
  STA.B $06                                       ; 0395CF 85 06 
D_395D1:
  SEC                                             ; 0395D1 38 
  LDA.B $05                                       ; 0395D2 A5 05 
  SBC.B #$08                                      ; 0395D4 E9 08 
  CMP.W EntityYPx,X                                   ; 0395D6 DD 9C 0C 
  BCC.B B_395E4                                   ; 0395D9 90 09 
  LDA.B $06                                       ; 0395DB A5 06 
  ORA.B #$02                                      ; 0395DD 09 02 
  STA.B $06                                       ; 0395DF 85 06 
  JMP.W D_395F4                                   ; 0395E1 4C F4 95 
B_395E4:
  CLC                                             ; 0395E4 18 
  LDA.B $05                                       ; 0395E5 A5 05 
  ADC.B #$08                                      ; 0395E7 69 08 
  CMP.W EntityYPx,X                                   ; 0395E9 DD 9C 0C 
  BCS.B D_395F4                                   ; 0395EC B0 06 
  LDA.B $06                                       ; 0395EE A5 06 
  ORA.B #$01                                      ; 0395F0 09 01 
  STA.B $06                                       ; 0395F2 85 06 
D_395F4:
  LDY.B $06                                       ; 0395F4 A4 06 
  BNE.B B_39600                                   ; 0395F6 D0 08 
  LDA.B #$01                                      ; 0395F8 A9 01 
  STA.W EntityV15,X                                   ; 0395FA 9D 80 0D 
  JMP.W D_39641                                   ; 0395FD 4C 41 96 
B_39600:
  LDA.W D_396C7,Y                                 ; 039600 B9 C7 96 
  STA.W EntityV23,X                                   ; 039603 9D 10 11 
  TAY                                             ; 039606 A8 
  LDA.W D_396D2,Y                                 ; 039607 B9 D2 96 
  STA.W EntityV29,X                                   ; 03960A 9D BC 13 
  LDA.W EntityV30,X                                   ; 03960D BD 2E 14 
  AND.B #$3F                                      ; 039610 29 3F 
  ORA.W D_396DA,Y                                 ; 039612 19 DA 96 
  STA.W EntityV30,X                                   ; 039615 9D 2E 14 
  LDA.W EntityV24,X                                   ; 039618 BD 82 11 
  ASL                                             ; 03961B 0A 
  ASL                                             ; 03961C 0A 
  ASL                                             ; 03961D 0A 
  ASL                                             ; 03961E 0A 
  STA.B $04                                       ; 03961F 85 04 
  LDA.W EntityV23,X                                   ; 039621 BD 10 11 
  ASL                                             ; 039624 0A 
  CLC                                             ; 039625 18 
  ADC.B $04                                       ; 039626 65 04 
  TAY                                             ; 039628 A8 
  LDA.W D_396E2,Y                                 ; 039629 B9 E2 96 
  STA.W EntityXSubPxSpeed,X                                   ; 03962C 9D 0C 09 
  LDA.W D_396E3,Y                                 ; 03962F B9 E3 96 
  STA.W EntityXPxSpeed,X                                   ; 039632 9D 7E 09 
  LDA.W D_39732,Y                                 ; 039635 B9 32 97 
  STA.W EntityYSubPxSpeed,X                                   ; 039638 9D F0 09 
  LDA.W D_39733,Y                                 ; 03963B B9 33 97 
  STA.W EntityYPxSpeed,X                                   ; 03963E 9D 62 0A 
D_39641:
  SEC                                             ; 039641 38 
  LDA.W EntityXPx,X                              ; 039642 BD 46 0B 
  SBC.B #$07                                      ; 039645 E9 07 
  BCS.B B_3964B                                   ; 039647 B0 02 

.byte $A9,$00                                     ; 03964A ..       ??

B_3964B:
  STA.W EntityV32,X                                   ; 03964B 9D 16 15 
  CLC                                             ; 03964E 18 
  LDA.W EntityXPx,X                              ; 03964F BD 46 0B 
  ADC.B #$07                                      ; 039652 69 07 
  BCC.B B_39658                                   ; 039654 90 02 

.byte $A9,$FF                                     ; 039657 ..       ??

B_39658:
  STA.W EntityV33,X                                   ; 039658 9D 88 15 
  SEC                                             ; 03965B 38 
  LDA.W EntityYPx,X                                   ; 03965C BD 9C 0C 
  SBC.B #$08                                      ; 03965F E9 08 
  BCS.B B_39665                                   ; 039661 B0 02 

.byte $A9,$00                                     ; 039664 ..       ??

B_39665:
  STA.W EntityV34,X                                   ; 039665 9D FA 15 
  CLC                                             ; 039668 18 
  LDA.W EntityYPx,X                                   ; 039669 BD 9C 0C 
  ADC.B #$08                                      ; 03966C 69 08 
  BCC.B B_39672                                   ; 03966E 90 02 

.byte $A9,$FF                                     ; 039671 ..       ??

B_39672:
  STA.W EntityV35,X                                   ; 039672 9D 6C 16 
  LDY.W EntityV23,X                                   ; 039675 BC 10 11 
  SEC                                             ; 039678 38 
  LDA.W EntityXPx,X                              ; 039679 BD 46 0B 
  SBC.B #$08                                      ; 03967C E9 08 
  SBC.W $1A25,Y                                   ; 03967E F9 25 1A 
  STA.B $07                                       ; 039681 85 07 
  SEC                                             ; 039683 38 
  LDA.W EntityYPx,X                                   ; 039684 BD 9C 0C 
  SBC.B #$0A                                      ; 039687 E9 0A 
  SBC.W $1A2D,Y                                   ; 039689 F9 2D 1A 
  STA.B $08                                       ; 03968C 85 08 
  LDA.W EntityV31,X                                   ; 03968E BD A0 14 
  ASL                                             ; 039691 0A 
  ASL                                             ; 039692 0A 
  TAY                                             ; 039693 A8 
  BCC.B B_396AE                                   ; 039694 90 18 

.byte $A5,$07,$99,$08,$04,$A5,$08,$99             ; 039696 ........ ????????
.byte $09,$04,$BD,$BC,$13,$99,$0A,$04             ; 03969E ........ ????????
.byte $BD,$2E,$14,$99,$0B,$04,$80,$16             ; 0396A6 ........ ?.??????

B_396AE:
  LDA.B $07                                       ; 0396AE A5 07 
  STA.W $0308,Y                                   ; 0396B0 99 08 03 
  LDA.B $08                                       ; 0396B3 A5 08 
  STA.W XexzyTorsoY,Y                             ; 0396B5 99 09 03 
  LDA.W EntityV29,X                                   ; 0396B8 BD BC 13 
  STA.W $030A,Y                                   ; 0396BB 99 0A 03 
  LDA.W EntityV30,X                                   ; 0396BE BD 2E 14 
  STA.W $030B,Y                                   ; 0396C1 99 0B 03 
  JMP.W AdvanceToNextEntity                                   ; 0396C4 4C 41 81 

D_396C7:
.byte $00,$00,$04,$00,$02,$01,$03,$00             ; 0396C7 .DD.DDD. ????????
.byte $06,$07,$05                                 ; 0396D0 DDD      ???
D_396D2:
.byte $C4,$C6,$C8,$CA,$CC,$CA,$C8,$C6             ; 0396D2 DDDDDDDD ????????
D_396DA:
.byte $00,$00,$00,$00,$00,$40,$40,$40             ; 0396DA DDDDDDDD ?????@@@
D_396E2:
.byte $00                                         ; 0396E3 D        ?
D_396E3:
.byte $00,$5B,$00,$80,$00,$5B,$00,$00             ; 0396E3 DDDDDDDD ?[???[??
.byte $00,$A5,$FF,$80,$FF,$A5,$FF,$00             ; 0396EB DDDDDDDD ????????
.byte $00,$82,$00,$B8,$00,$82,$00,$00             ; 0396F3 DDDDDDDD ????????
.byte $00,$7E,$FF,$48,$FF,$7E,$FF,$00             ; 0396FB DDDDDDD. ?~?H?~??
.byte $00,$AA,$00,$F0,$00,$AA,$00,$00             ; 039703 ........ ????????
.byte $00,$56,$FF,$10,$FF,$56,$FF,$00             ; 03970B ........ ?V???V??
.byte $00,$D1,$00,$28,$01,$D1,$00,$00             ; 039713 ........ ???(????
.byte $00,$2F,$FF,$D8,$FE,$2F,$FF,$00             ; 03971B ........ ?/???/??
.byte $00,$F9,$00,$60,$01,$F9,$00,$00             ; 039723 ........ ???`????
.byte $00,$07,$FF,$A0,$FE,$07,$FF                 ; 03972C .......  ???????
D_39732:
.byte $80                                         ; 039733 D        ?
D_39733:
.byte $FF,$A5,$FF,$00,$00,$5B,$00,$80             ; 039733 DDDDDDDD ?????[??
.byte $00,$5B,$00,$00,$00,$A5,$FF,$48             ; 03973B DDDDDDDD ?[?????H
.byte $FF,$7E,$FF,$00,$00,$82,$00,$B8             ; 039743 DDDDDDDD ?~??????
.byte $00,$82,$00,$00,$00,$7E,$FF,$10             ; 03974B DDDDDDD. ?????~??
.byte $FF,$56,$FF,$00,$00,$AA,$00,$F0             ; 039753 ........ ?V??????
.byte $00,$AA,$00,$00,$00,$56,$FF,$D8             ; 03975B ........ ?????V??
.byte $FE,$2F,$FF,$00,$00,$D1,$00,$28             ; 039763 ........ ?/?????(
.byte $01,$D1,$00,$00,$00,$2F,$FF,$A0             ; 03976B ........ ?????/??
.byte $FE,$07,$FF,$00,$00,$F9,$00,$60             ; 039773 ........ ???????`
.byte $01,$F9,$00,$00,$00,$07,$FF                 ; 03977C .......  ???????
D_39782:
.byte $E8                                         ; 039783 D        ?
D_39783:
.byte $E8,$18,$E8,$18,$18,$E8,$18,$00             ; 039783 DDDDDDDD ????????
.byte $F0,$10,$00,$00,$10,$F0,$00,$F8             ; 03978B DDDDDDDD ????????
.byte $F8,$08,$F8,$08,$08,$F8,$08,$00             ; 039793 DDDDDDDD ????????
.byte $00,$00,$00,$00,$00,$00,$00,$E0             ; 03979B DDDDDDD. ????????
.byte $E0,$20,$E0,$20,$20,$E0,$20,$00             ; 0397A3 ........ ? ?  ? ?
.byte $F0,$10,$00,$00,$10,$F0,$00,$F8             ; 0397AB ........ ????????
.byte $F8,$08,$F8,$08,$08,$F8,$08,$00             ; 0397B3 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00                 ; 0397BC .......  ???????

  SEC                                             ; 0397C2 38 
  LDA.W EntityXPx,X                              ; 0397C3 BD 46 0B 
  SBC.B #$07                                      ; 0397C6 E9 07 
  BCS.B B_397CC                                   ; 0397C8 B0 02 

.byte $A9,$00                                     ; 0397CB ..       ??

B_397CC:
  STA.W EntityV32,X                                   ; 0397CC 9D 16 15 
  CLC                                             ; 0397CF 18 
  LDA.W EntityXPx,X                              ; 0397D0 BD 46 0B 
  ADC.B #$07                                      ; 0397D3 69 07 
  BCC.B B_397D9                                   ; 0397D5 90 02 

.byte $A9,$FF                                     ; 0397D8 ..       ??

B_397D9:
  STA.W EntityV33,X                                   ; 0397D9 9D 88 15 
  SEC                                             ; 0397DC 38 
  LDA.W EntityYPx,X                                   ; 0397DD BD 9C 0C 
  SBC.B #$08                                      ; 0397E0 E9 08 
  BCS.B B_397E6                                   ; 0397E2 B0 02 

.byte $A9,$00                                     ; 0397E5 ..       ??

B_397E6:
  STA.W EntityV34,X                                   ; 0397E6 9D FA 15 
  CLC                                             ; 0397E9 18 
  LDA.W EntityYPx,X                                   ; 0397EA BD 9C 0C 
  ADC.B #$08                                      ; 0397ED 69 08 
  BCC.B B_397F3                                   ; 0397EF 90 02 

.byte $A9,$FF                                     ; 0397F2 ..       ??

B_397F3:
  STA.W EntityV35,X                                   ; 0397F3 9D 6C 16 
  DEC.W EntityV28,X                                   ; 0397F6 DE 4A 13 
  BNE.B B_39821                                   ; 0397F9 D0 26 
  INC.W EntityV27,X                                   ; 0397FB FE D8 12 
  LDA.W EntityV27,X                                   ; 0397FE BD D8 12 
  CMP.B #$21                                      ; 039801 C9 21 
  BNE.B B_39812                                   ; 039803 D0 0D 
  LDA.B #$16                                      ; 039805 A9 16 
  STA.W EntityTypeId,X                                   ; 039807 9D 44 07 
  LDA.B #$01                                      ; 03980A A9 01 
  STA.W EntityV15,X                                   ; 03980C 9D 80 0D 
  JMP.W AdvanceToNextEntity                                   ; 03980F 4C 41 81 
B_39812:
  LDY.W EntityV27,X                                   ; 039812 BC D8 12 
  LDA.W D_398B0,Y                                 ; 039815 B9 B0 98 
  STA.W EntityV28,X                                   ; 039818 9D 4A 13 
  LDA.W D_3988F,Y                                 ; 03981B B9 8F 98 
  STA.W EntityV29,X                                   ; 03981E 9D BC 13 
B_39821:
  SEC                                             ; 039821 38 
  LDA.W EntityV29,X                                   ; 039822 BD BC 13 
  SBC.B #$80                                      ; 039825 E9 80 
  LSR                                             ; 039827 4A 
  TAY                                             ; 039828 A8 
  SEC                                             ; 039829 38 
  LDA.W EntityXPx,X                              ; 03982A BD 46 0B 
  SBC.B #$08                                      ; 03982D E9 08 
  STA.B $07                                       ; 03982F 85 07 
  LDA.W EntityV30,X                                   ; 039831 BD 2E 14 
  AND.B #$40                                      ; 039834 29 40 
  BEQ.B B_39843                                   ; 039836 F0 0B 
  CLC                                             ; 039838 18 
  LDA.B $07                                       ; 039839 A5 07 
  ADC.W D_398D1,Y                                 ; 03983B 79 D1 98 
  STA.B $07                                       ; 03983E 85 07 
  JMP.W D_3984B                                   ; 039840 4C 4B 98 
B_39843:
  SEC                                             ; 039843 38 
  LDA.B $07                                       ; 039844 A5 07 
  SBC.W D_398D1,Y                                 ; 039846 F9 D1 98 
  STA.B $07                                       ; 039849 85 07 
D_3984B:
  SEC                                             ; 03984B 38 
  LDA.W EntityYPx,X                                   ; 03984C BD 9C 0C 
  SBC.B #$0A                                      ; 03984F E9 0A 
  SBC.W D_398D7,Y                                 ; 039851 F9 D7 98 
  STA.B $08                                       ; 039854 85 08 
  LDA.W EntityV31,X                                   ; 039856 BD A0 14 
  ASL                                             ; 039859 0A 
  ASL                                             ; 03985A 0A 
  TAY                                             ; 03985B A8 
  BCC.B B_39876                                   ; 03985C 90 18 

.byte $A5,$07,$99,$08,$04,$A5,$08,$99             ; 03985E ........ ????????
.byte $09,$04,$BD,$BC,$13,$99,$0A,$04             ; 039866 ........ ????????
.byte $BD,$2E,$14,$99,$0B,$04,$80,$16             ; 03986E ........ ?.??????

B_39876:
  LDA.B $07                                       ; 039876 A5 07 
  STA.W $0308,Y                                   ; 039878 99 08 03 
  LDA.B $08                                       ; 03987B A5 08 
  STA.W XexzyTorsoY,Y                             ; 03987D 99 09 03 
  LDA.W EntityV29,X                                   ; 039880 BD BC 13 
  STA.W $030A,Y                                   ; 039883 99 0A 03 
  LDA.W EntityV30,X                                   ; 039886 BD 2E 14 
  STA.W $030B,Y                                   ; 039889 99 0B 03 
  JMP.W AdvanceToNextEntity                                   ; 03988C 4C 41 81 

D_3988F:
.byte $80,$82,$84,$86,$88,$8A,$88,$86             ; 03988F DDDDDDDD ????????
.byte $84,$82,$80,$80,$82,$84,$86,$88             ; 039897 DDDDDDDD ????????
.byte $8A,$88,$86,$84,$82,$80,$80,$82             ; 03989F DDDDDDDD ????????
.byte $84,$86,$88,$8A,$88,$86,$84,$82             ; 0398A7 DDDDDDDD ????????
.byte $80                                         ; 0398B0 D        ?
D_398B0:
.byte $03,$03,$03,$03,$03,$0A,$04,$04             ; 0398B0 DDDDDDDD ????????
.byte $04,$04,$04,$03,$03,$03,$03,$03             ; 0398B8 DDDDDDDD ????????
.byte $0A,$04,$04,$04,$04,$04,$03,$03             ; 0398C0 DDDDDDDD ????????
.byte $03,$03,$03,$0A,$04,$04,$04,$04             ; 0398C8 DDDDDDDD ????????
.byte $04                                         ; 0398D1 D        ?
D_398D1:
.byte $00,$00,$FF,$FE,$FD,$FD                     ; 0398D2 DDDDDD   ??????
D_398D7:
.byte $00,$00,$FF,$00,$00,$00,$BD,$80             ; 0398D7 DDDDDD.. ????????
.byte $0D,$F0,$06,$DE,$80,$0D,$4C,$41             ; 0398DF ........ ??????LA
.byte $81,$A9,$20,$9D,$80,$0D,$A9,$02             ; 0398E7 ........ ?? ?????
.byte $85,$07,$BD,$46,$0B,$85,$04,$BD             ; 0398EF ........ ???F????
.byte $9C,$0C,$85,$05,$BD,$2C,$10,$85             ; 0398F7 ........ ?????,??
.byte $06,$D0,$11,$AD,$E4,$05,$D0,$0C             ; 0398FF ........ ????????
.byte $AD,$E3,$05,$C9,$5A,$B0,$05,$A9             ; 039907 ........ ????Z???
.byte $5A,$8D,$E3,$05,$BD,$BA,$0F,$85             ; 03990F ........ Z???????
.byte $08,$BD,$10,$11,$85,$0B,$BD,$B6             ; 039917 ........ ????????
.byte $07,$85,$0A,$86,$09,$C6,$08,$F0             ; 03991F ........ ????????
.byte $29,$22,$F3,$80,$03,$D0,$19,$8A             ; 039927 ........ )"??????
.byte $AE,$D5,$18,$FE,$C5,$18,$AA,$EE             ; 03992F ........ ????????
.byte $C6,$06,$EE,$E6,$18,$22,$94,$80             ; 039937 ........ ?????"??
.byte $03,$20,$59,$99,$C6,$07,$10,$DD             ; 03993F ........ ? Y?????
.byte $A6,$09,$A5,$08,$9D,$BA,$0F,$4C             ; 039947 ........ ???????L
.byte $41,$81,$A6,$09,$20,$59,$99,$4C             ; 03994F ........ A??? Y?L
.byte $41,$81,$A9,$01,$9D,$D2,$06,$A9             ; 039957 ........ A???????
.byte $19,$9D,$44,$07,$A9,$0C,$9D,$28             ; 03995F ........ ??D????(
.byte $08,$22,$95,$CA,$0E,$29,$01,$9D             ; 039967 ........ ?"???)??
.byte $BA,$0F,$A5,$0B,$9D,$10,$11,$22             ; 03996F ........ ???????"
.byte $95,$CA,$0E,$29,$1F,$9D,$80,$0D             ; 039977 ........ ???)????
.byte $A5,$06,$0A,$0A,$A8,$18,$65,$07             ; 03997F ........ ??????e?
.byte $A8,$18,$A5,$04,$79,$02,$9A,$9D             ; 039987 ........ ????y???
.byte $46,$0B,$18,$A5,$05,$79,$12,$9A             ; 03998F ........ F????y??
.byte $9D,$9C,$0C,$38,$BD,$46,$0B,$E9             ; 039997 ........ ???8?F??
.byte $06,$B0,$02,$A9,$00,$9D,$16,$15             ; 03999F ........ ????????
.byte $18,$BD,$46,$0B,$69,$06,$90,$02             ; 0399A7 ........ ??F?i???
.byte $A9,$FF,$9D,$88,$15,$38,$BD,$9C             ; 0399AF ........ ?????8??
.byte $0C,$E9,$06,$B0,$02,$A9,$00,$9D             ; 0399B7 ........ ????????
.byte $FA,$15,$18,$BD,$9C,$0C,$69,$06             ; 0399BF ........ ??????i?
.byte $90,$02,$A9,$FF,$9D,$6C,$16,$A4             ; 0399C7 ........ ?????l??
.byte $06,$B9,$22,$9A,$9D,$9E,$10,$B9             ; 0399CF ........ ??"?????
.byte $26,$9A,$9D,$BC,$13,$A5,$0A,$19             ; 0399D7 ........ &???????
.byte $2A,$9A,$9D,$2E,$14,$22,$95,$CA             ; 0399DF ........ *??.?"??
.byte $0E,$29,$7F,$18,$69,$28,$9D,$F2             ; 0399E7 ........ ?)??i(??
.byte $0D,$22,$BC,$AE,$00,$98,$9D,$A0             ; 0399EF ........ ?"??????
.byte $14,$A9,$01,$99,$5E,$17,$22,$F1             ; 0399F7 ........ ????^?"?
.byte $AE,$00,$60,$F8,$08,$00,$00,$00             ; 0399FF ........ ??`?????
.byte $00,$FC,$00,$F8,$08,$00,$00,$00             ; 039A07 ........ ????????
.byte $00,$04,$00,$00,$00,$04,$00,$F8             ; 039A0F ........ ????????
.byte $08,$00,$00,$00,$00,$FC,$00,$F8             ; 039A17 ........ ????????
.byte $08,$00,$00,$02,$08,$01,$04,$68             ; 039A1F ........ ???????h
.byte $64,$60,$64,$00,$40,$00,$00,$A5             ; 039A27 ........ d`d?@???
.byte $CF,$29,$01,$D0,$2A,$BD,$80,$0D             ; 039A2F ........ ?)??*???
.byte $0A,$A8,$B9,$EE,$85,$9D,$0C,$09             ; 039A37 ........ ????????
.byte $B9,$EF,$85,$9D,$7E,$09,$B9,$2E             ; 039A3F ........ ????~??.
.byte $86,$9D,$F0,$09,$B9,$2F,$86,$9D             ; 039A47 ........ ?????/??
.byte $62,$0A,$BD,$80,$0D,$1A,$C9,$20             ; 039A4F ........ b?????? 
.byte $D0,$02,$A9,$00,$9D,$80,$0D,$BD             ; 039A57 ........ ????????
.byte $F2,$0D,$F0,$06,$DE,$F2,$0D,$4C             ; 039A5F ........ ???????L
.byte $FD,$9A,$22,$95,$CA,$0E,$29,$1F             ; 039A67 ........ ??"???)?
.byte $18,$69,$10,$9D,$F2,$0D,$64,$06             ; 039A6F ........ ?i????d?
.byte $BC,$BA,$0F,$B9,$46,$0B,$85,$04             ; 039A77 ........ ????F???
.byte $B9,$9C,$0C,$85,$05,$22,$95,$CA             ; 039A7F ........ ?????"??
.byte $0E,$29,$0F,$0A,$A8,$18,$A5,$04             ; 039A87 ........ ?)??????
.byte $79,$82,$97,$85,$04,$18,$A5,$05             ; 039A8F ........ y???????
.byte $79,$83,$97,$85,$05,$38,$A5,$04             ; 039A97 ........ y????8??
.byte $E9,$08,$DD,$46,$0B,$90,$07,$A9             ; 039A9F ........ ???F????
.byte $04,$85,$06,$4C,$BB,$9A,$18,$A5             ; 039AA7 ........ ???L????
.byte $04,$69,$08,$DD,$46,$0B,$B0,$04             ; 039AAF ........ ?i??F???
.byte $A9,$08,$85,$06,$38,$A5,$05,$E9             ; 039AB7 ........ ????8???
.byte $08,$DD,$9C,$0C,$90,$09,$A5,$06             ; 039ABF ........ ????????
.byte $09,$02,$85,$06,$4C,$DE,$9A,$18             ; 039AC7 ........ ????L???
.byte $A5,$05,$69,$08,$DD,$9C,$0C,$B0             ; 039ACF ........ ??i?????
.byte $06,$A5,$06,$09,$01,$85,$06,$A5             ; 039AD7 ........ ????????
.byte $06,$9D,$9E,$10,$D0,$06,$9E,$F2             ; 039ADF ........ ????????
.byte $0D,$4C,$41,$81,$A8,$B9,$DE,$9B             ; 039AE7 ........ ?LA?????
.byte $9D,$BC,$13,$BD,$2E,$14,$29,$3F             ; 039AEF ........ ????.?)?
.byte $19,$E9,$9B,$9D,$2E,$14,$BD,$10             ; 039AF7 ........ ????.???
.byte $11,$0A,$0A,$0A,$0A,$0A,$85,$04             ; 039AFF ........ ????????
.byte $BD,$9E,$10,$0A,$18,$65,$04,$A8             ; 039B07 ........ ?????e??
.byte $18,$BD,$D4,$0A,$79,$F4,$9B,$9D             ; 039B0F ........ ????y???
.byte $D4,$0A,$BD,$46,$0B,$79,$F5,$9B             ; 039B17 ........ ???F?y??
.byte $9D,$46,$0B,$BD,$2A,$0C,$79,$74             ; 039B1F ........ ?F??*?yt
.byte $9C,$9D,$2A,$0C,$BD,$9C,$0C,$79             ; 039B27 ........ ??*????y
.byte $75,$9C,$9D,$9C,$0C,$DA,$9B,$BD             ; 039B2F ........ u???????
.byte $9E,$10,$0A,$AA,$FC,$B2,$9B,$FC             ; 039B37 ........ ????????
.byte $C8,$9B,$FA,$38,$BD,$46,$0B,$E9             ; 039B3F ........ ???8?F??
.byte $06,$B0,$02,$A9,$00,$9D,$16,$15             ; 039B47 ........ ????????
.byte $18,$BD,$46,$0B,$69,$06,$90,$02             ; 039B4F ........ ??F?i???
.byte $A9,$FF,$9D,$88,$15,$38,$BD,$9C             ; 039B57 ........ ?????8??
.byte $0C,$E9,$06,$B0,$02,$A9,$00,$9D             ; 039B5F ........ ????????
.byte $FA,$15,$18,$BD,$9C,$0C,$69,$06             ; 039B67 ........ ??????i?
.byte $90,$02,$A9,$FF,$9D,$6C,$16,$A9             ; 039B6F ........ ?????l??
.byte $08,$85,$1C,$A9,$09,$85,$1D,$22             ; 039B77 ........ ???????"
.byte $C2,$AF,$00,$4C,$41,$81,$A9,$28             ; 039B7F ........ ???LA??(
.byte $D9,$9C,$0C,$90,$03,$99,$9C,$0C             ; 039B87 ........ ????????
.byte $60,$A9,$D4,$D9,$9C,$0C,$B0,$03             ; 039B8F ........ `???????
.byte $99,$9C,$0C,$60,$A9,$1A,$D9,$46             ; 039B97 ........ ???`???F
.byte $0B,$90,$03,$99,$46,$0B,$60,$A9             ; 039B9F ........ ????F?`?
.byte $E6,$D9,$46,$0B,$B0,$03,$99,$46             ; 039BA7 ........ ??F????F
.byte $0B,$60,$60,$B1,$9B,$B1,$9B,$B1             ; 039BAF ........ ?``?????
.byte $9B,$B1,$9B,$A6,$9B,$A6,$9B,$A6             ; 039BB7 ........ ????????
.byte $9B,$B1,$9B,$9B,$9B,$9B,$9B,$9B             ; 039BBF ........ ????????
.byte $9B,$B1,$9B,$85,$9B,$90,$9B,$B1             ; 039BC7 ........ ????????
.byte $9B,$B1,$9B,$85,$9B,$90,$9B,$B1             ; 039BCF ........ ????????
.byte $9B,$B1,$9B,$85,$9B,$90,$9B,$00             ; 039BD7 ........ ????????
.byte $60,$68,$00,$64,$62,$66,$00,$64             ; 039BDF ........ `h?dbf?d
.byte $62,$66,$00,$00,$00,$00,$00,$00             ; 039BE7 ........ bf??????
.byte $00,$00,$40,$40,$40,$00,$00,$00             ; 039BEF ........ ??@@@???
.byte $00,$00,$00,$00,$00,$70,$00,$70             ; 039BF7 ........ ?????p?p
.byte $00,$70,$00,$00,$00,$90,$FF,$90             ; 039BFF ........ ?p??????
.byte $FF,$90,$FF,$00,$00,$00,$00,$00             ; 039C07 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 039C0F ........ ????????
.byte $00,$00,$00,$00,$00,$7C,$00,$7C             ; 039C17 ........ ?????|?|
.byte $00,$7C,$00,$00,$00,$84,$FF,$84             ; 039C1F ........ ?|??????
.byte $FF,$84,$FF,$00,$00,$00,$00,$00             ; 039C27 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 039C2F ........ ????????
.byte $00,$00,$00,$00,$00,$88,$00,$88             ; 039C37 ........ ????????
.byte $00,$88,$00,$00,$00,$78,$FF,$78             ; 039C3F ........ ?????x?x
.byte $FF,$78,$FF,$00,$00,$00,$00,$00             ; 039C47 ........ ?x??????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 039C4F ........ ????????
.byte $00,$00,$00,$00,$00,$A0,$00,$A0             ; 039C57 ........ ????????
.byte $00,$A0,$00,$00,$00,$60,$FF,$60             ; 039C5F ........ ?????`?`
.byte $FF,$60,$FF,$00,$00,$00,$00,$00             ; 039C67 ........ ?`??????
.byte $00,$00,$00,$00,$00,$00,$00,$90             ; 039C6F ........ ????????
.byte $FF,$70,$00,$00,$00,$00,$00,$90             ; 039C77 ........ ?p??????
.byte $FF,$70,$00,$00,$00,$00,$00,$90             ; 039C7F ........ ?p??????
.byte $FF,$70,$00,$00,$00,$00,$00,$00             ; 039C87 ........ ?p??????
.byte $00,$00,$00,$00,$00,$00,$00,$84             ; 039C8F ........ ????????
.byte $FF,$7C,$00,$00,$00,$00,$00,$84             ; 039C97 ........ ?|??????
.byte $FF,$7C,$00,$00,$00,$00,$00,$84             ; 039C9F ........ ?|??????
.byte $FF,$7C,$00,$00,$00,$00,$00,$00             ; 039CA7 ........ ?|??????
.byte $00,$00,$00,$00,$00,$00,$00,$78             ; 039CAF ........ ???????x
.byte $FF,$88,$00,$00,$00,$00,$00,$78             ; 039CB7 ........ ???????x
.byte $FF,$88,$00,$00,$00,$00,$00,$78             ; 039CBF ........ ???????x
.byte $FF,$88,$00,$00,$00,$00,$00,$00             ; 039CC7 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$60             ; 039CCF ........ ???????`
.byte $FF,$A0,$00,$00,$00,$00,$00,$60             ; 039CD7 ........ ???????`
.byte $FF,$A0,$00,$00,$00,$00,$00,$60             ; 039CDF ........ ???????`
.byte $FF,$A0,$00,$00,$00,$00,$00,$00             ; 039CE7 ........ ????????
.byte $00,$00,$00,$00,$00,$BD,$80,$0D             ; 039CEF ........ ????????
.byte $F0,$06,$DE,$80,$0D,$4C,$41,$81             ; 039CF7 ........ ?????LA?
.byte $A9,$20,$9D,$80,$0D,$A9,$02,$85             ; 039CFF ........ ? ??????
.byte $07,$BD,$46,$0B,$85,$04,$BD,$9C             ; 039D07 ........ ??F?????
.byte $0C,$85,$05,$BD,$2C,$10,$85,$06             ; 039D0F ........ ????,???
.byte $D0,$11,$AD,$E4,$05,$D0,$0C,$AD             ; 039D17 ........ ????????
.byte $E3,$05,$C9,$5A,$B0,$05,$A9,$5A             ; 039D1F ........ ???Z???Z
.byte $8D,$E3,$05,$BD,$BA,$0F,$85,$08             ; 039D27 ........ ????????
.byte $BD,$10,$11,$85,$0C,$BD,$9E,$10             ; 039D2F ........ ????????
.byte $85,$0B,$BD,$B6,$07,$85,$0A,$86             ; 039D37 ........ ????????
.byte $09,$C6,$08,$F0,$2E,$22,$F3,$80             ; 039D3F ........ ????."??
.byte $03,$D0,$1E,$DA,$A6,$0B,$30,$07             ; 039D47 ........ ??????0?
.byte $BD,$D6,$18,$AA,$FE,$C5,$18,$FA             ; 039D4F ........ ????????
.byte $EE,$C6,$06,$EE,$EF,$18,$22,$94             ; 039D57 ........ ??????"?
.byte $80,$03,$20,$7A,$9D,$C6,$07,$10             ; 039D5F ........ ?? z????
.byte $D8,$A6,$09,$A5,$08,$9D,$BA,$0F             ; 039D67 ........ ????????
.byte $4C,$41,$81,$A6,$09,$20,$7A,$9D             ; 039D6F ........ LA??? z?
.byte $4C,$41,$81,$A9,$01,$9D,$D2,$06             ; 039D77 ........ LA??????
.byte $A9,$1B,$9D,$44,$07,$A9,$0C,$9D             ; 039D7F ........ ???D????
.byte $28,$08,$22,$95,$CA,$0E,$29,$01             ; 039D87 ........ (?"???)?
.byte $9D,$BA,$0F,$A5,$0C,$9D,$10,$11             ; 039D8F ........ ????????
.byte $A5,$0B,$9D,$2C,$10,$22,$95,$CA             ; 039D97 ........ ???,?"??
.byte $0E,$29,$1F,$9D,$80,$0D,$A5,$06             ; 039D9F ........ ?)??????
.byte $0A,$0A,$A8,$18,$65,$07,$A8,$18             ; 039DA7 ........ ????e???
.byte $A5,$04,$79,$28,$9E,$9D,$46,$0B             ; 039DAF ........ ??y(??F?
.byte $18,$A5,$05,$79,$38,$9E,$9D,$9C             ; 039DB7 ........ ???y8???
.byte $0C,$38,$BD,$46,$0B,$E9,$05,$B0             ; 039DBF ........ ?8?F????
.byte $02,$A9,$00,$9D,$16,$15,$18,$BD             ; 039DC7 ........ ????????
.byte $46,$0B,$69,$05,$90,$02,$A9,$FF             ; 039DCF ........ F?i?????
.byte $9D,$88,$15,$38,$BD,$9C,$0C,$E9             ; 039DD7 ........ ???8????
.byte $05,$B0,$02,$A9,$00,$9D,$FA,$15             ; 039DDF ........ ????????
.byte $18,$BD,$9C,$0C,$69,$05,$90,$02             ; 039DE7 ........ ????i???
.byte $A9,$FF,$9D,$6C,$16,$A4,$06,$B9             ; 039DEF ........ ???l????
.byte $48,$9E,$9D,$9E,$10,$B9,$4C,$9E             ; 039DF7 ........ H?????L?
.byte $9D,$BC,$13,$A5,$0A,$19,$50,$9E             ; 039DFF ........ ??????P?
.byte $9D,$2E,$14,$22,$95,$CA,$0E,$29             ; 039E07 ........ ?.?"???)
.byte $7F,$18,$69,$28,$9D,$F2,$0D,$22             ; 039E0F ........ ??i(???"
.byte $BC,$AE,$00,$98,$9D,$A0,$14,$A9             ; 039E17 ........ ????????
.byte $01,$99,$5E,$17,$22,$F1,$AE,$00             ; 039E1F ........ ??^?"???
.byte $60,$F8,$08,$00,$00,$00,$00,$FC             ; 039E27 ........ `???????
.byte $00,$F8,$08,$00,$00,$00,$00,$04             ; 039E2F ........ ????????
.byte $00,$00,$00,$04,$00,$F8,$08,$00             ; 039E37 ........ ????????
.byte $00,$00,$00,$FC,$00,$F8,$08,$00             ; 039E3F ........ ????????
.byte $00,$02,$08,$01,$04,$68,$64,$60             ; 039E47 ........ ?????hd`
.byte $64,$00,$40,$00,$00,$A5,$CF,$29             ; 039E4F ........ d?@????)
.byte $01,$D0,$2A,$BD,$80,$0D,$0A,$A8             ; 039E57 ........ ??*?????
.byte $B9,$EE,$85,$9D,$0C,$09,$B9,$EF             ; 039E5F ........ ????????
.byte $85,$9D,$7E,$09,$B9,$2E,$86,$9D             ; 039E67 ........ ??~??.??
.byte $F0,$09,$B9,$2F,$86,$9D,$62,$0A             ; 039E6F ........ ???/??b?
.byte $BD,$80,$0D,$1A,$C9,$20,$D0,$02             ; 039E77 ........ ????? ??
.byte $A9,$00,$9D,$80,$0D,$BD,$F2,$0D             ; 039E7F ........ ????????
.byte $F0,$06,$DE,$F2,$0D,$4C,$23,$9F             ; 039E87 ........ ?????L#?
.byte $22,$95,$CA,$0E,$29,$1F,$18,$69             ; 039E8F ........ "???)??i
.byte $10,$9D,$F2,$0D,$64,$06,$BC,$BA             ; 039E97 ........ ????d???
.byte $0F,$B9,$46,$0B,$85,$04,$B9,$9C             ; 039E9F ........ ??F?????
.byte $0C,$85,$05,$22,$95,$CA,$0E,$29             ; 039EA7 ........ ???"???)
.byte $0F,$0A,$A8,$18,$A5,$04,$79,$82             ; 039EAF ........ ??????y?
.byte $97,$85,$04,$18,$A5,$05,$79,$83             ; 039EB7 ........ ??????y?
.byte $97,$85,$05,$38,$A5,$04,$E9,$08             ; 039EBF ........ ???8????
.byte $DD,$46,$0B,$90,$07,$A9,$04,$85             ; 039EC7 ........ ?F??????
.byte $06,$4C,$E1,$9E,$18,$A5,$04,$69             ; 039ECF ........ ?L?????i
.byte $08,$DD,$46,$0B,$B0,$04,$A9,$08             ; 039ED7 ........ ??F?????
.byte $85,$06,$38,$A5,$05,$E9,$08,$DD             ; 039EDF ........ ??8?????
.byte $9C,$0C,$90,$09,$A5,$06,$09,$02             ; 039EE7 ........ ????????
.byte $85,$06,$4C,$04,$9F,$18,$A5,$05             ; 039EEF ........ ??L?????
.byte $69,$08,$DD,$9C,$0C,$B0,$06,$A5             ; 039EF7 ........ i???????
.byte $06,$09,$01,$85,$06,$A5,$06,$9D             ; 039EFF ........ ????????
.byte $9E,$10,$D0,$06,$9E,$F2,$0D,$4C             ; 039F07 ........ ???????L
.byte $41,$81,$A8,$B9,$04,$A0,$9D,$BC             ; 039F0F ........ A???????
.byte $13,$BD,$2E,$14,$29,$3F,$19,$0F             ; 039F17 ........ ??.?)???
.byte $A0,$9D,$2E,$14,$BD,$10,$11,$0A             ; 039F1F ........ ??.?????
.byte $0A,$0A,$0A,$0A,$85,$04,$BD,$9E             ; 039F27 ........ ????????
.byte $10,$0A,$18,$65,$04,$A8,$18,$BD             ; 039F2F ........ ???e????
.byte $D4,$0A,$79,$F4,$9B,$9D,$D4,$0A             ; 039F37 ........ ??y?????
.byte $BD,$46,$0B,$79,$F5,$9B,$9D,$46             ; 039F3F ........ ?F?y???F
.byte $0B,$BD,$2A,$0C,$79,$74,$9C,$9D             ; 039F47 ........ ??*?yt??
.byte $2A,$0C,$BD,$9C,$0C,$79,$75,$9C             ; 039F4F ........ *????yu?
.byte $9D,$9C,$0C,$DA,$9B,$BD,$9E,$10             ; 039F57 ........ ????????
.byte $0A,$AA,$FC,$D8,$9F,$FC,$EE,$9F             ; 039F5F ........ ????????
.byte $FA,$38,$BD,$46,$0B,$E9,$05,$B0             ; 039F67 ........ ?8?F????
.byte $02,$A9,$00,$9D,$16,$15,$18,$BD             ; 039F6F ........ ????????
.byte $46,$0B,$69,$05,$90,$02,$A9,$FF             ; 039F77 ........ F?i?????
.byte $9D,$88,$15,$38,$BD,$9C,$0C,$E9             ; 039F7F ........ ???8????
.byte $05,$B0,$02,$A9,$00,$9D,$FA,$15             ; 039F87 ........ ????????
.byte $18,$BD,$9C,$0C,$69,$05,$90,$02             ; 039F8F ........ ????i???
.byte $A9,$FF,$9D,$6C,$16,$A9,$08,$85             ; 039F97 ........ ???l????
.byte $1C,$A9,$07,$85,$1D,$22,$C2,$AF             ; 039F9F ........ ?????"??
.byte $00,$4C,$41,$81,$A9,$26,$D9,$9C             ; 039FA7 ........ ?LA??&??
.byte $0C,$90,$03,$99,$9C,$0C,$60,$A9             ; 039FAF ........ ??????`?
.byte $D6,$D9,$9C,$0C,$B0,$03,$99,$9C             ; 039FB7 ........ ????????
.byte $0C,$60,$A9,$18,$D9,$46,$0B,$90             ; 039FBF ........ ?`???F??
.byte $03,$99,$46,$0B,$60,$A9,$E8,$D9             ; 039FC7 ........ ??F?`???
.byte $46,$0B,$B0,$03,$99,$46,$0B,$60             ; 039FCF ........ F????F?`
.byte $60,$D7,$9F,$D7,$9F,$D7,$9F,$D7             ; 039FD7 ........ `???????
.byte $9F,$CC,$9F,$CC,$9F,$CC,$9F,$D7             ; 039FDF ........ ????????
.byte $9F,$C1,$9F,$C1,$9F,$C1,$9F,$D7             ; 039FE7 ........ ????????
.byte $9F,$AB,$9F,$B6,$9F,$D7,$9F,$D7             ; 039FEF ........ ????????
.byte $9F,$AB,$9F,$B6,$9F,$D7,$9F,$D7             ; 039FF7 ........ ????????
.byte $9F,$AB,$9F,$B6,$9F,$00,$60,$68             ; 039FFF ........ ??????`h
.byte $00,$64,$62,$66,$00,$64,$62,$66             ; 03A007 ........ ?dbf?dbf
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03A00F ........ ????????
.byte $40,$40,$40,$00,$00,$00,$00,$00             ; 03A017 ........ @@@?????
.byte $00,$00,$00,$70,$00,$70,$00,$70             ; 03A01F ........ ???p?p?p
.byte $00,$00,$00,$90,$FF,$90,$FF,$90             ; 03A027 ........ ????????
.byte $FF,$00,$00,$90,$FF,$70,$00,$00             ; 03A02F ........ ?????p??
.byte $00,$00,$00,$90,$FF,$70,$00,$00             ; 03A037 ........ ?????p??
.byte $00,$00,$00,$90,$FF,$70,$00                 ; 03A040 .......  ?????p?

  DEC.W EntityV28,X                                   ; 03A046 DE 4A 13 
  BNE.B B_3A087                                   ; 03A049 D0 3C 
  LDA.B #$05                                      ; 03A04B A9 05 
  STA.W EntityV28,X                                   ; 03A04D 9D 4A 13 
  LDY.W EntityV27,X                                   ; 03A050 BC D8 12 
  INY                                             ; 03A053 C8 
  CPY.B #$08                                      ; 03A054 C0 08 
  BNE.B B_3A07D                                   ; 03A056 D0 25 
  STZ.W EntityHeader,X                                   ; 03A058 9E D2 06 
  PHX                                             ; 03A05B DA 
  LDY.W EntityV31,X                                   ; 03A05C BC A0 14 
  JSL L_AEF1                                      ; 03A05F 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03A063 BD A0 14 
  TAX                                             ; 03A066 AA 
  STZ.W StateFlags,X                                   ; 03A067 9E 5E 17 
  ASL                                             ; 03A06A 0A 
  ASL                                             ; 03A06B 0A 
  TAY                                             ; 03A06C A8 
  LDA.B #$F0                                      ; 03A06D A9 F0 
  BCC.B B_3A076                                   ; 03A06F 90 05 
  STA.W $0409,Y                                   ; 03A071 99 09 04 
  BRA.B B_3A079                                   ; 03A074 80 03 
B_3A076:
  STA.W XexzyTorsoY,Y                             ; 03A076 99 09 03 
B_3A079:
  PLX                                             ; 03A079 FA 
  JMP.W AdvanceToNextEntity                                   ; 03A07A 4C 41 81 
B_3A07D:
  TYA                                             ; 03A07D 98 
  STA.W EntityV27,X                                   ; 03A07E 9D D8 12 
  LDA.W D_3A10A,Y                                 ; 03A081 B9 0A A1 
  STA.W EntityV29,X                                   ; 03A084 9D BC 13 
B_3A087:
  LDA.W EntityXPxSpeed,X                                   ; 03A087 BD 7E 09 
  BMI.B B_3A0A0                                   ; 03A08A 30 14 
  ORA.W EntityXSubPxSpeed,X                                   ; 03A08C 1D 0C 09 
  BEQ.B B_3A0AF                                   ; 03A08F F0 1E 
  LDA.B #$F7                                      ; 03A091 A9 F7 
  CMP.W EntityXPx,X                              ; 03A093 DD 46 0B 
  BCS.B B_3A0AF                                   ; 03A096 B0 17 
  STA.W EntityXPx,X                              ; 03A098 9D 46 0B 
  LDY.B #$02                                      ; 03A09B A0 02 
  JMP.W D_3A0E5                                   ; 03A09D 4C E5 A0 
B_3A0A0:
  LDA.B #$08                                      ; 03A0A0 A9 08 
  CMP.W EntityXPx,X                              ; 03A0A2 DD 46 0B 
  BCC.B B_3A0AF                                   ; 03A0A5 90 08 
  STA.W EntityXPx,X                              ; 03A0A7 9D 46 0B 
  LDY.B #$03                                      ; 03A0AA A0 03 
  JMP.W D_3A0E5                                   ; 03A0AC 4C E5 A0 
B_3A0AF:
  LDA.W EntityYPxSpeed,X                                   ; 03A0AF BD 62 0A 
  BMI.B B_3A0C8                                   ; 03A0B2 30 14 
  ORA.W EntityYSubPxSpeed,X                                   ; 03A0B4 1D F0 09 
  BEQ.B B_3A0D6                                   ; 03A0B7 F0 1D 
  LDA.B #$E8                                      ; 03A0B9 A9 E8 
  CMP.W EntityYPx,X                                   ; 03A0BB DD 9C 0C 
  BCS.B B_3A0D6                                   ; 03A0BE B0 16 
  STA.W EntityYPx,X                                   ; 03A0C0 9D 9C 0C 
  LDY.B #$01                                      ; 03A0C3 A0 01 
  JMP.W D_3A0E5                                   ; 03A0C5 4C E5 A0 
B_3A0C8:
  LDA.B #$08                                      ; 03A0C8 A9 08 
  CMP.W EntityYPx,X                                   ; 03A0CA DD 9C 0C 
  BCC.B B_3A0D6                                   ; 03A0CD 90 07 
  STA.W EntityYPx,X                                   ; 03A0CF 9D 9C 0C 
  LDY.B #$00                                      ; 03A0D2 A0 00 
  BRA.B D_3A0E5                                   ; 03A0D4 80 0F 
B_3A0D6:
  LDA.B #$08                                      ; 03A0D6 A9 08 
  STA.B $1C                                       ; 03A0D8 85 1C 
  LDA.B #$08                                      ; 03A0DA A9 08 
  STA.B $1D                                       ; 03A0DC 85 1D 
  JSL L_AFC2                                      ; 03A0DE 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03A0E2 4C 41 81 
D_3A0E5:
  STZ.W EntityHeader,X                                   ; 03A0E5 9E D2 06 
  PHX                                             ; 03A0E8 DA 
  LDY.W EntityV31,X                                   ; 03A0E9 BC A0 14 
  JSL L_AEF1                                      ; 03A0EC 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03A0F0 BD A0 14 
  TAX                                             ; 03A0F3 AA 
  STZ.W StateFlags,X                                   ; 03A0F4 9E 5E 17 
  ASL                                             ; 03A0F7 0A 
  ASL                                             ; 03A0F8 0A 
  TAY                                             ; 03A0F9 A8 
  LDA.B #$F0                                      ; 03A0FA A9 F0 
  BCC.B B_3A103                                   ; 03A0FC 90 05 
  STA.W $0409,Y                                   ; 03A0FE 99 09 04 
  BRA.B B_3A106                                   ; 03A101 80 03 
B_3A103:
  STA.W XexzyTorsoY,Y                             ; 03A103 99 09 03 
B_3A106:
  PLX                                             ; 03A106 FA 
  JMP.W AdvanceToNextEntity                                   ; 03A107 4C 41 81 

D_3A10A:
.byte $20,$22,$24,$26,$28,$2A,$2C,$2E             ; 03A10A .DDDDDDD  "$&(*,.

  LDA.W EntityV15,X                                   ; 03A112 BD 80 0D 
  BEQ.B B_3A11D                                   ; 03A115 F0 06 
  DEC.W EntityV15,X                                   ; 03A117 DE 80 0D 
B_3A11A:
  JMP.W AdvanceToNextEntity                                   ; 03A11A 4C 41 81 
B_3A11D:
  STX.B $04                                       ; 03A11D 86 04 
  JSL FindEmptyProjectileSlot                                     ; 03A11F 22 E4 80 03 
  BNE.B B_3A11A                                   ; 03A123 D0 F5 
  JSL ClearEntitySlotData                                     ; 03A125 22 94 80 03 
  LDA.W $05D0                                     ; 03A129 AD D0 05 
  STA.W EntityV20,X                                   ; 03A12C 9D BA 0F 
  LDA.B #$01                                      ; 03A12F A9 01 
  STA.W EntityHeader,X                                   ; 03A131 9D D2 06 
  LDA.B #$36                                      ; 03A134 A9 36 
  STA.W EntityTypeId,X                                   ; 03A136 9D 44 07 
  LDA.B #$02                                      ; 03A139 A9 02 
  STA.W EntityV3,X                                   ; 03A13B 9D 28 08 
  LDY.W $05D0                                     ; 03A13E AC D0 05 
  LDA.W EntityXPx,Y                              ; 03A141 B9 46 0B 
  STA.W EntityXPx,X                              ; 03A144 9D 46 0B 
  SEC                                             ; 03A147 38 
  LDA.W EntityYPx,Y                                   ; 03A148 B9 9C 0C 
  SBC.B #$1F                                      ; 03A14B E9 1F 
  STA.W EntityYPx,X                                   ; 03A14D 9D 9C 0C 
  SEC                                             ; 03A150 38 
  LDA.W EntityXPx,X                              ; 03A151 BD 46 0B 
  SBC.B #$08                                      ; 03A154 E9 08 
  BCS.B B_3A15A                                   ; 03A156 B0 02 

.byte $A9,$00                                     ; 03A159 ..       ??

B_3A15A:
  STA.W EntityV32,X                                   ; 03A15A 9D 16 15 
  CLC                                             ; 03A15D 18 
  LDA.W EntityXPx,X                              ; 03A15E BD 46 0B 
  ADC.B #$08                                      ; 03A161 69 08 
  BCC.B B_3A167                                   ; 03A163 90 02 

.byte $A9,$FF                                     ; 03A166 ..       ??

B_3A167:
  STA.W EntityV33,X                                   ; 03A167 9D 88 15 
  SEC                                             ; 03A16A 38 
  LDA.W EntityYPx,X                                   ; 03A16B BD 9C 0C 
  SBC.B #$08                                      ; 03A16E E9 08 
  BCS.B B_3A174                                   ; 03A170 B0 02 

.byte $A9,$00                                     ; 03A173 ..       ??

B_3A174:
  STA.W EntityV34,X                                   ; 03A174 9D FA 15 
  CLC                                             ; 03A177 18 
  LDA.W EntityYPx,X                                   ; 03A178 BD 9C 0C 
  ADC.B #$08                                      ; 03A17B 69 08 
  BCC.B B_3A181                                   ; 03A17D 90 02 

.byte $A9,$FF                                     ; 03A180 ..       ??

B_3A181:
  STA.W EntityV35,X                                   ; 03A181 9D 6C 16 
  LDA.B #$00                                      ; 03A184 A9 00 
  STA.W EntityV15,X                                   ; 03A186 9D 80 0D 
  ASL                                             ; 03A189 0A 
  TAY                                             ; 03A18A A8 
  LDA.W D_384EE,Y                                 ; 03A18B B9 EE 84 
  STA.W EntityXSubPxSpeed,X                                   ; 03A18E 9D 0C 09 
  LDA.W D_384EF,Y                                 ; 03A191 B9 EF 84 
  STA.W EntityXPxSpeed,X                                   ; 03A194 9D 7E 09 
  LDA.W D_3856E,Y                                 ; 03A197 B9 6E 85 
  STA.W EntityYSubPxSpeed,X                                   ; 03A19A 9D F0 09 
  LDA.W D_3856F,Y                                 ; 03A19D B9 6F 85 
  STA.W EntityYPxSpeed,X                                   ; 03A1A0 9D 62 0A 
  LDA.B #$E6                                      ; 03A1A3 A9 E6 
  STA.W EntityV29,X                                   ; 03A1A5 9D BC 13 
  LDA.B #$32                                      ; 03A1A8 A9 32 
  STA.W EntityV30,X                                   ; 03A1AA 9D 2E 14 
  JSL GetEmptyStateFlag                                      ; 03A1AD 22 CB AE 00 
  TYA                                             ; 03A1B1 98 
  STA.W EntityV31,X                                   ; 03A1B2 9D A0 14 
  LDA.B #$01                                      ; 03A1B5 A9 01 
  STA.W StateFlags,Y                                   ; 03A1B7 99 5E 17 
  JSL L_AEF1                                      ; 03A1BA 22 F1 AE 00 
  INC.W PlayerRazorShieldStatus                                     ; 03A1BE EE D1 05 
  LDX.B $04                                       ; 03A1C1 A6 04 
  LDA.B #$0C                                      ; 03A1C3 A9 0C 
  STA.W EntityV15,X                                   ; 03A1C5 9D 80 0D 
  DEC.W EntityV20,X                                   ; 03A1C8 DE BA 0F 
  BNE.B B_3A1D0                                   ; 03A1CB D0 03 
  STZ.W EntityHeader,X                                   ; 03A1CD 9E D2 06 
B_3A1D0:
  JMP.W AdvanceToNextEntity                                   ; 03A1D0 4C 41 81 

.byte $DE,$80,$0D,$D0,$0E,$A9,$3C,$9D             ; 03A1D3 ........ ??????<?
.byte $80,$0D,$22,$95,$CA,$0E,$29,$07             ; 03A1DB ........ ??"???)?
.byte $9D,$9E,$10,$BC,$BA,$0F,$B9,$46             ; 03A1E3 ........ ???????F
.byte $0B,$85,$06,$B9,$9C,$0C,$85,$07             ; 03A1EB ........ ????????
.byte $BC,$9E,$10,$B9,$0C,$A3,$85,$08             ; 03A1F3 ........ ????????
.byte $38,$A5,$06,$E5,$08,$B0,$02,$A9             ; 03A1FB ........ 8???????
.byte $00,$DD,$46,$0B,$90,$10,$18,$BD             ; 03A203 ........ ??F?????
.byte $0C,$09,$69,$04,$9D,$0C,$09,$90             ; 03A20B ........ ??i?????
.byte $03,$FE,$7E,$09,$80,$1C,$18,$A5             ; 03A213 ........ ??~?????
.byte $06,$65,$08,$90,$02,$A9,$FF,$DD             ; 03A21B ........ ?e??????
.byte $46,$0B,$B0,$0E,$38,$BD,$0C,$09             ; 03A223 ........ F???8???
.byte $E9,$04,$9D,$0C,$09,$B0,$03,$DE             ; 03A22B ........ ????????
.byte $7E,$09,$38,$A5,$07,$E5,$08,$B0             ; 03A233 ........ ~?8?????
.byte $02,$A9,$00,$DD,$9C,$0C,$90,$10             ; 03A23B ........ ????????
.byte $18,$BD,$F0,$09,$69,$04,$9D,$F0             ; 03A243 ........ ????i???
.byte $09,$90,$03,$FE,$62,$0A,$80,$1C             ; 03A24B ........ ????b???
.byte $18,$A5,$07,$65,$08,$90,$02,$A9             ; 03A253 ........ ???e????
.byte $FF,$DD,$9C,$0C,$B0,$0E,$38,$BD             ; 03A25B ........ ??????8?
.byte $F0,$09,$E9,$04,$9D,$F0,$09,$B0             ; 03A263 ........ ????????
.byte $03,$DE,$62,$0A,$A9,$08,$20,$95             ; 03A26B ........ ??b??? ?
.byte $81,$BD,$7E,$09,$10,$10,$C9,$FE             ; 03A273 ........ ??~?????
.byte $F0,$02,$B0,$16,$A9,$FF,$9D,$7E             ; 03A27B ........ ???????~
.byte $09,$9E,$0C,$09,$80,$0C,$C9,$01             ; 03A283 ........ ????????
.byte $90,$08,$A9,$01,$9D,$7E,$09,$9E             ; 03A28B ........ ?????~??
.byte $0C,$09,$BD,$62,$0A,$10,$10,$C9             ; 03A293 ........ ???b????
.byte $FE,$F0,$02,$B0,$16,$A9,$FF,$9D             ; 03A29B ........ ????????
.byte $62,$0A,$9E,$F0,$09,$80,$0C,$C9             ; 03A2A3 ........ b???????
.byte $01,$90,$08,$A9,$01,$9D,$62,$0A             ; 03A2AB ........ ??????b?
.byte $9E,$F0,$09,$38,$BD,$46,$0B,$E9             ; 03A2B3 ........ ???8?F??
.byte $08,$B0,$02,$A9,$00,$9D,$16,$15             ; 03A2BB ........ ????????
.byte $18,$BD,$46,$0B,$69,$08,$90,$02             ; 03A2C3 ........ ??F?i???
.byte $A9,$FF,$9D,$88,$15,$38,$BD,$9C             ; 03A2CB ........ ?????8??
.byte $0C,$E9,$08,$B0,$02,$A9,$00,$9D             ; 03A2D3 ........ ????????
.byte $FA,$15,$18,$BD,$9C,$0C,$69,$08             ; 03A2DB ........ ??????i?
.byte $90,$02,$A9,$FF,$9D,$6C,$16,$A9             ; 03A2E3 ........ ?????l??
.byte $07,$85,$1C,$A9,$09,$85,$1D,$22             ; 03A2EB ........ ???????"
.byte $C2,$AF,$00,$A5,$D2,$29,$03,$D0             ; 03A2F3 ........ ?????)??
.byte $08,$BD,$B6,$07,$09,$38,$9D,$2E             ; 03A2FB ........ ?????8?.
.byte $14,$4C,$41,$81,$20,$22,$24,$26             ; 03A303 ........ ?LA? "$&
.byte $28,$00,$08,$10,$18,$20,$28,$30             ; 03A30B ........ (???? (0
.byte $38,$DE,$80,$0D,$D0,$0E,$A9,$3C             ; 03A313 ........ 8??????<
.byte $9D,$80,$0D,$22,$95,$CA,$0E,$29             ; 03A31B ........ ???"???)
.byte $07,$9D,$9E,$10,$BC,$BA,$0F,$B9             ; 03A323 ........ ????????
.byte $46,$0B,$85,$06,$B9,$9C,$0C,$85             ; 03A32B ........ F???????
.byte $07,$BC,$9E,$10,$B9,$46,$A4,$85             ; 03A333 ........ ?????F??
.byte $08,$38,$A5,$06,$E5,$08,$B0,$02             ; 03A33B ........ ?8??????
.byte $A9,$00,$DD,$46,$0B,$90,$10,$18             ; 03A343 ........ ???F????
.byte $BD,$0C,$09,$69,$06,$9D,$0C,$09             ; 03A34B ........ ???i????
.byte $90,$03,$FE,$7E,$09,$80,$1C,$18             ; 03A353 ........ ???~????
.byte $A5,$06,$65,$08,$90,$02,$A9,$FF             ; 03A35B ........ ??e?????
.byte $DD,$46,$0B,$B0,$0E,$38,$BD,$0C             ; 03A363 ........ ?F???8??
.byte $09,$E9,$06,$9D,$0C,$09,$B0,$03             ; 03A36B ........ ????????
.byte $DE,$7E,$09,$38,$A5,$07,$E5,$08             ; 03A373 ........ ?~?8????
.byte $B0,$02,$A9,$00,$DD,$9C,$0C,$90             ; 03A37B ........ ????????
.byte $10,$18,$BD,$F0,$09,$69,$06,$9D             ; 03A383 ........ ?????i??
.byte $F0,$09,$90,$03,$FE,$62,$0A,$80             ; 03A38B ........ ?????b??
.byte $1C,$18,$A5,$07,$65,$08,$90,$02             ; 03A393 ........ ????e???
.byte $A9,$FF,$DD,$9C,$0C,$B0,$0E,$38             ; 03A39B ........ ???????8
.byte $BD,$F0,$09,$E9,$06,$9D,$F0,$09             ; 03A3A3 ........ ????????
.byte $B0,$03,$DE,$62,$0A,$A9,$08,$20             ; 03A3AB ........ ???b??? 
.byte $95,$81,$BD,$7E,$09,$10,$10,$C9             ; 03A3B3 ........ ???~????
.byte $FE,$F0,$02,$B0,$16,$A9,$FF,$9D             ; 03A3BB ........ ????????
.byte $7E,$09,$9E,$0C,$09,$80,$0C,$C9             ; 03A3C3 ........ ~???????
.byte $01,$90,$08,$A9,$01,$9D,$7E,$09             ; 03A3CB ........ ??????~?
.byte $9E,$0C,$09,$BD,$62,$0A,$10,$10             ; 03A3D3 ........ ????b???
.byte $C9,$FE,$F0,$02,$B0,$16,$A9,$FF             ; 03A3DB ........ ????????
.byte $9D,$62,$0A,$9E,$F0,$09,$80,$0C             ; 03A3E3 ........ ?b??????
.byte $C9,$01,$90,$08,$A9,$01,$9D,$62             ; 03A3EB ........ ???????b
.byte $0A,$9E,$F0,$09,$38,$BD,$46,$0B             ; 03A3F3 ........ ????8?F?
.byte $E9,$08,$B0,$02,$A9,$00,$9D,$16             ; 03A3FB ........ ????????
.byte $15,$18,$BD,$46,$0B,$69,$08,$90             ; 03A403 ........ ???F?i??
.byte $02,$A9,$FF,$9D,$88,$15,$38,$BD             ; 03A40B ........ ??????8?
.byte $9C,$0C,$E9,$08,$B0,$02,$A9,$00             ; 03A413 ........ ????????
.byte $9D,$FA,$15,$18,$BD,$9C,$0C,$69             ; 03A41B ........ ???????i
.byte $08,$90,$02,$A9,$FF,$9D,$6C,$16             ; 03A423 ........ ??????l?
.byte $A9,$07,$85,$1C,$A9,$09,$85,$1D             ; 03A42B ........ ????????
.byte $22,$C2,$AF,$00,$A5,$D2,$29,$03             ; 03A433 ........ "?????)?
.byte $D0,$06,$BD,$B6,$07,$9D,$2E,$14             ; 03A43B ........ ??????.?
.byte $4C,$41,$81,$00,$08,$10,$18,$20             ; 03A443 ........ LA????? 
.byte $28,$30,$38,$DE,$80,$0D,$F0,$49             ; 03A44B ........ (08????I
.byte $A9,$08,$20,$95,$81,$BD,$7E,$09             ; 03A453 ........ ?? ???~?
.byte $10,$10,$C9,$FE,$F0,$02,$B0,$16             ; 03A45B ........ ????????
.byte $A9,$FF,$9D,$7E,$09,$9E,$0C,$09             ; 03A463 ........ ???~????
.byte $80,$0C,$C9,$01,$90,$08,$A9,$01             ; 03A46B ........ ????????
.byte $9D,$7E,$09,$9E,$0C,$09,$BD,$62             ; 03A473 ........ ?~?????b
.byte $0A,$10,$10,$C9,$FE,$F0,$02,$B0             ; 03A47B ........ ????????
.byte $16,$A9,$FF,$9D,$62,$0A,$9E,$F0             ; 03A483 ........ ????b???
.byte $09,$80,$0C,$C9,$01,$90,$08,$A9             ; 03A48B ........ ????????
.byte $01,$9D,$62,$0A,$9E,$F0,$09,$80             ; 03A493 ........ ??b?????
.byte $71,$A9,$0A,$9D,$80,$0D,$BD,$BA             ; 03A49B ........ q???????
.byte $0F,$85,$04,$9B,$AA,$38,$BD,$46             ; 03A4A3 ........ ?????8?F
.byte $0B,$F9,$46,$0B,$90,$11,$AA,$BF             ; 03A4AB ........ ??F?????
.byte $B0,$FA,$03,$99,$0C,$09,$BF,$B0             ; 03A4B3 ........ ????????
.byte $FB,$03,$99,$7E,$09,$80,$17,$49             ; 03A4BB ........ ???~???I
.byte $FF,$1A,$AA,$38,$A9,$00,$FF,$B0             ; 03A4C3 ........ ???8????
.byte $FA,$03,$99,$0C,$09,$A9,$00,$FF             ; 03A4CB ........ ????????
.byte $B0,$FB,$03,$99,$7E,$09,$A6,$04             ; 03A4D3 ........ ????~???
.byte $38,$BD,$9C,$0C,$F9,$9C,$0C,$90             ; 03A4DB ........ 8???????
.byte $11,$AA,$BF,$B0,$FA,$03,$99,$F0             ; 03A4E3 ........ ????????
.byte $09,$BF,$B0,$FB,$03,$99,$62,$0A             ; 03A4EB ........ ??????b?
.byte $80,$17,$49,$FF,$1A,$AA,$38,$A9             ; 03A4F3 ........ ??I???8?
.byte $00,$FF,$B0,$FA,$03,$99,$F0,$09             ; 03A4FB ........ ????????
.byte $A9,$00,$FF,$B0,$FB,$03,$99,$62             ; 03A503 ........ ???????b
.byte $0A,$BB,$38,$BD,$46,$0B,$E9,$08             ; 03A50B ........ ??8?F???
.byte $B0,$02,$A9,$00,$9D,$16,$15,$18             ; 03A513 ........ ????????
.byte $BD,$46,$0B,$69,$08,$90,$02,$A9             ; 03A51B ........ ?F?i????
.byte $FF,$9D,$88,$15,$38,$BD,$9C,$0C             ; 03A523 ........ ????8???
.byte $E9,$08,$B0,$02,$A9,$00,$9D,$FA             ; 03A52B ........ ????????
.byte $15,$18,$BD,$9C,$0C,$69,$08,$90             ; 03A533 ........ ?????i??
.byte $02,$A9,$FF,$9D,$6C,$16,$A9,$07             ; 03A53B ........ ????l???
.byte $85,$1C,$A9,$09,$85,$1D,$22,$C2             ; 03A543 ........ ??????"?
.byte $AF,$00,$A5,$D2,$29,$03,$D0,$06             ; 03A54B ........ ????)???
.byte $BD,$B6,$07,$9D,$2E,$14,$4C,$41             ; 03A553 ........ ????.?LA
.byte $81,$20,$22,$24,$26,$28,$A9,$08             ; 03A55B ........ ? "$&(??
.byte $20,$95,$81,$DE,$4A,$13,$D0,$67             ; 03A563 ........  ???J??g
.byte $DE,$2C,$10,$D0,$50,$CE,$E9,$18             ; 03A56B ........ ?,??P???
.byte $CE,$C6,$06,$DA,$AE,$DA,$18,$DE             ; 03A573 ........ ????????
.byte $C5,$18,$D0,$06,$9E,$C9,$18,$9E             ; 03A57B ........ ????????
.byte $C1,$18,$FA,$A9,$09,$9D,$44,$07             ; 03A583 ........ ??????D?
.byte $A9,$00,$9D,$28,$08,$A9,$40,$9D             ; 03A58B ........ ???(??@?
.byte $BC,$13,$A9,$32,$9D,$2E,$14,$9E             ; 03A593 ........ ???2?.??
.byte $0C,$09,$9E,$7E,$09,$9E,$F0,$09             ; 03A59B ........ ???~????
.byte $9E,$62,$0A,$A9,$04,$9D,$4A,$13             ; 03A5A3 ........ ?b????J?
.byte $9E,$D8,$12,$DA,$C2,$10,$A9,$07             ; 03A5AB ........ ????????
.byte $A2,$06,$FF,$22,$0F,$83,$0F,$E2             ; 03A5B3 ........ ???"????
.byte $30,$FA,$4C,$41,$81,$A9,$03,$9D             ; 03A5BB ........ 0?LA????
.byte $4A,$13,$BD,$10,$11,$1A,$C9,$0C             ; 03A5C3 ........ J???????
.byte $D0,$02,$A9,$00,$9D,$10,$11,$BC             ; 03A5CB ........ ????????
.byte $10,$11,$B9,$5B,$A9,$9D,$BC,$13             ; 03A5D3 ........ ???[????
.byte $BD,$2E,$14,$29,$3F,$19,$67,$A9             ; 03A5DB ........ ?.?)??g?
.byte $9D,$2E,$14,$A9,$07,$85,$1C,$A9             ; 03A5E3 ........ ?.??????
.byte $09,$85,$1D,$22,$C2,$AF,$00,$A5             ; 03A5EB ........ ???"????
.byte $D2,$29,$03,$D0,$06,$BD,$B6,$07             ; 03A5F3 ........ ?)??????
.byte $9D,$2E,$14,$4C,$41,$81,$DE,$80             ; 03A5FB ........ ?.?LA???
.byte $0D,$D0,$2F,$DE,$2C,$10,$D0,$15             ; 03A603 ........ ??/?,???
.byte $FE,$2C,$10,$AD,$D2,$05,$C9,$04             ; 03A60B ........ ?,??????
.byte $B0,$0B,$EE,$D2,$05,$A9,$23,$9D             ; 03A613 ........ ??????#?
.byte $44,$07,$4C,$D0,$A6,$22,$95,$CA             ; 03A61B ........ D?L??"??
.byte $0E,$29,$1F,$18,$69,$20,$9D,$80             ; 03A623 ........ ?)??i ??
.byte $0D,$22,$95,$CA,$0E,$29,$07,$9D             ; 03A62B ........ ?"???)??
.byte $9E,$10,$BD,$BA,$0F,$10,$0F,$29             ; 03A633 ........ ???????)
.byte $07,$A8,$B9,$6B,$A7,$85,$06,$B9             ; 03A63B ........ ???k????
.byte $73,$A7,$85,$07,$80,$0B,$A8,$B9             ; 03A643 ........ s???????
.byte $46,$0B,$85,$06,$B9,$9C,$0C,$85             ; 03A64B ........ F???????
.byte $07,$BC,$9E,$10,$B9,$7B,$A7,$85             ; 03A653 ........ ?????{??
.byte $08,$38,$A5,$06,$E5,$08,$B0,$02             ; 03A65B ........ ?8??????
.byte $A9,$00,$DD,$46,$0B,$90,$10,$18             ; 03A663 ........ ???F????
.byte $BD,$0C,$09,$69,$04,$9D,$0C,$09             ; 03A66B ........ ???i????
.byte $90,$03,$FE,$7E,$09,$80,$1C,$18             ; 03A673 ........ ???~????
.byte $A5,$06,$65,$08,$90,$02,$A9,$FF             ; 03A67B ........ ??e?????
.byte $DD,$46,$0B,$B0,$0E,$38,$BD,$0C             ; 03A683 ........ ?F???8??
.byte $09,$E9,$04,$9D,$0C,$09,$B0,$03             ; 03A68B ........ ????????
.byte $DE,$7E,$09,$38,$A5,$07,$E5,$08             ; 03A693 ........ ?~?8????
.byte $B0,$02,$A9,$00,$DD,$9C,$0C,$90             ; 03A69B ........ ????????
.byte $10,$18,$BD,$F0,$09,$69,$04,$9D             ; 03A6A3 ........ ?????i??
.byte $F0,$09,$90,$03,$FE,$62,$0A,$80             ; 03A6AB ........ ?????b??
.byte $1C,$18,$A5,$07,$65,$08,$90,$02             ; 03A6B3 ........ ????e???
.byte $A9,$FF,$DD,$9C,$0C,$B0,$0E,$38             ; 03A6BB ........ ???????8
.byte $BD,$F0,$09,$E9,$04,$9D,$F0,$09             ; 03A6C3 ........ ????????
.byte $B0,$03,$DE,$62,$0A,$A9,$08,$20             ; 03A6CB ........ ???b??? 
.byte $95,$81,$BD,$7E,$09,$10,$10,$C9             ; 03A6D3 ........ ???~????
.byte $FE,$F0,$02,$B0,$16,$A9,$FF,$9D             ; 03A6DB ........ ????????
.byte $7E,$09,$9E,$0C,$09,$80,$0C,$C9             ; 03A6E3 ........ ~???????
.byte $01,$90,$08,$A9,$01,$9D,$7E,$09             ; 03A6EB ........ ??????~?
.byte $9E,$0C,$09,$BD,$62,$0A,$10,$10             ; 03A6F3 ........ ????b???
.byte $C9,$FE,$F0,$02,$B0,$16,$A9,$FF             ; 03A6FB ........ ????????
.byte $9D,$62,$0A,$9E,$F0,$09,$80,$0C             ; 03A703 ........ ?b??????
.byte $C9,$01,$90,$08,$A9,$01,$9D,$62             ; 03A70B ........ ???????b
.byte $0A,$9E,$F0,$09,$38,$BD,$46,$0B             ; 03A713 ........ ????8?F?
.byte $E9,$06,$B0,$02,$A9,$00,$9D,$16             ; 03A71B ........ ????????
.byte $15,$18,$BD,$46,$0B,$69,$06,$90             ; 03A723 ........ ???F?i??
.byte $02,$A9,$FF,$9D,$88,$15,$38,$BD             ; 03A72B ........ ??????8?
.byte $9C,$0C,$E9,$06,$B0,$02,$A9,$00             ; 03A733 ........ ????????
.byte $9D,$FA,$15,$18,$BD,$9C,$0C,$69             ; 03A73B ........ ???????i
.byte $06,$90,$02,$A9,$FF,$9D,$6C,$16             ; 03A743 ........ ??????l?
.byte $A9,$07,$85,$1C,$A9,$09,$85,$1D             ; 03A74B ........ ????????
.byte $22,$C2,$AF,$00,$A5,$D2,$29,$03             ; 03A753 ........ "?????)?
.byte $D0,$06,$BD,$B6,$07,$9D,$2E,$14             ; 03A75B ........ ??????.?
.byte $4C,$41,$81,$60,$62,$64,$66,$60             ; 03A763 ........ LA?`bdf`
.byte $40,$60,$A0,$C0,$40,$60,$A0,$C0             ; 03A76B ........ @`??@`??
.byte $40,$60,$A0,$C0,$C0,$A0,$60,$40             ; 03A773 ........ @`????`@
.byte $00,$08,$10,$18,$20,$28,$30,$38             ; 03A77B ........ ???? (08
.byte $BD,$7E,$09,$10,$20,$1D,$0C,$09             ; 03A783 ........ ?~?? ???
.byte $F0,$34,$18,$BD,$0C,$09,$69,$04             ; 03A78B ........ ?4????i?
.byte $9D,$0C,$09,$BD,$7E,$09,$69,$00             ; 03A793 ........ ????~?i?
.byte $9D,$7E,$09,$30,$21,$9E,$0C,$09             ; 03A79B ........ ?~?0!???
.byte $9E,$7E,$09,$80,$19,$38,$BD,$0C             ; 03A7A3 ........ ?~???8??
.byte $09,$E9,$04,$9D,$0C,$09,$BD,$7E             ; 03A7AB ........ ???????~
.byte $09,$E9,$00,$9D,$7E,$09,$10,$06             ; 03A7B3 ........ ????~???
.byte $9E,$0C,$09,$9E,$7E,$09,$BD,$62             ; 03A7BB ........ ????~??b
.byte $0A,$10,$20,$1D,$F0,$09,$F0,$34             ; 03A7C3 ........ ?? ????4
.byte $18,$BD,$F0,$09,$69,$04,$9D,$F0             ; 03A7CB ........ ????i???
.byte $09,$BD,$62,$0A,$69,$00,$9D,$62             ; 03A7D3 ........ ??b?i??b
.byte $0A,$30,$21,$9E,$F0,$09,$9E,$62             ; 03A7DB ........ ?0!????b
.byte $0A,$80,$19,$38,$BD,$F0,$09,$E9             ; 03A7E3 ........ ???8????
.byte $04,$9D,$F0,$09,$BD,$62,$0A,$E9             ; 03A7EB ........ ?????b??
.byte $00,$9D,$62,$0A,$10,$06,$9E,$F0             ; 03A7F3 ........ ??b?????
.byte $09,$9E,$62,$0A,$BD,$7E,$09,$1D             ; 03A7FB ........ ??b??~??
.byte $62,$0A,$1D,$0C,$09,$1D,$F0,$09             ; 03A803 ........ b???????
.byte $D0,$4C,$A9,$24,$9D,$44,$07,$BD             ; 03A80B ........ ?L?$?D??
.byte $BA,$0F,$29,$01,$9D,$BA,$0F,$A9             ; 03A813 ........ ??)?????
.byte $01,$9D,$4A,$13,$22,$95,$CA,$0E             ; 03A81B ........ ??J?"???
.byte $29,$0F,$A8,$B9,$AD,$A8,$F0,$17             ; 03A823 ........ )???????
.byte $BC,$BA,$0F,$BD,$9C,$0C,$D9,$9C             ; 03A82B ........ ????????
.byte $0C,$B0,$07,$A9,$02,$9D,$2C,$10             ; 03A833 ........ ??????,?
.byte $80,$1C,$9E,$2C,$10,$80,$17,$BC             ; 03A83B ........ ???,????
.byte $BA,$0F,$BD,$46,$0B,$D9,$46,$0B             ; 03A843 ........ ???F??F?
.byte $B0,$07,$A9,$01,$9D,$2C,$10,$80             ; 03A84B ........ ?????,??
.byte $05,$A9,$03,$9D,$2C,$10,$A9,$08             ; 03A853 ........ ????,???
.byte $20,$95,$81,$38,$BD,$46,$0B,$E9             ; 03A85B ........  ??8?F??
.byte $06,$B0,$02,$A9,$00,$9D,$16,$15             ; 03A863 ........ ????????
.byte $18,$BD,$46,$0B,$69,$06,$90,$02             ; 03A86B ........ ??F?i???
.byte $A9,$FF,$9D,$88,$15,$38,$BD,$9C             ; 03A873 ........ ?????8??
.byte $0C,$E9,$06,$B0,$02,$A9,$00,$9D             ; 03A87B ........ ????????
.byte $FA,$15,$18,$BD,$9C,$0C,$69,$06             ; 03A883 ........ ??????i?
.byte $90,$02,$A9,$FF,$9D,$6C,$16,$A9             ; 03A88B ........ ?????l??
.byte $07,$85,$1C,$A9,$09,$85,$1D,$22             ; 03A893 ........ ???????"
.byte $C2,$AF,$00,$A5,$D2,$29,$03,$D0             ; 03A89B ........ ?????)??
.byte $06,$BD,$B6,$07,$9D,$2E,$14,$4C             ; 03A8A3 ........ ?????.?L
.byte $41,$81,$00,$01,$00,$01,$00,$00             ; 03A8AB ........ A???????
.byte $01,$00,$00,$01,$00,$01,$00,$01             ; 03A8B3 ........ ????????
.byte $00,$00,$BC,$10,$11,$BD,$2C,$10             ; 03A8BB ........ ??????,?
.byte $29,$01,$D9,$73,$A9,$D0,$17,$A9             ; 03A8C3 ........ )??s????
.byte $25,$9D,$44,$07,$A9,$04,$9D,$80             ; 03A8CB ........ %?D?????
.byte $0D,$A9,$01,$9D,$F2,$0D,$A9,$28             ; 03A8D3 ........ ???????(
.byte $9D,$9E,$10,$4C,$41,$81,$DE,$4A             ; 03A8DB ........ ???LA??J
.byte $13,$D0,$12,$A9,$06,$9D,$4A,$13             ; 03A8E3 ........ ??????J?
.byte $BD,$10,$11,$1A,$C9,$0C,$D0,$02             ; 03A8EB ........ ????????
.byte $A9,$00,$9D,$10,$11,$38,$BD,$46             ; 03A8F3 ........ ?????8?F
.byte $0B,$E9,$06,$B0,$02,$A9,$00,$9D             ; 03A8FB ........ ????????
.byte $16,$15,$18,$BD,$46,$0B,$69,$06             ; 03A903 ........ ????F?i?
.byte $90,$02,$A9,$FF,$9D,$88,$15,$38             ; 03A90B ........ ???????8
.byte $BD,$9C,$0C,$E9,$06,$B0,$02,$A9             ; 03A913 ........ ????????
.byte $00,$9D,$FA,$15,$18,$BD,$9C,$0C             ; 03A91B ........ ????????
.byte $69,$06,$90,$02,$A9,$FF,$9D,$6C             ; 03A923 ........ i??????l
.byte $16,$BC,$10,$11,$B9,$5B,$A9,$9D             ; 03A92B ........ ?????[??
.byte $BC,$13,$BD,$2E,$14,$29,$3F,$19             ; 03A933 ........ ???.?)??
.byte $67,$A9,$9D,$2E,$14,$A9,$07,$85             ; 03A93B ........ g??.????
.byte $1C,$A9,$09,$85,$1D,$22,$C2,$AF             ; 03A943 ........ ?????"??
.byte $00,$A5,$D2,$29,$03,$D0,$06,$BD             ; 03A94B ........ ???)????
.byte $B6,$07,$9D,$2E,$14,$4C,$41,$81             ; 03A953 ........ ???.?LA?
.byte $60,$62,$64,$66,$64,$62,$60,$62             ; 03A95B ........ `bdfdb`b
.byte $64,$66,$64,$62,$00,$00,$00,$00             ; 03A963 ........ dfdb????
.byte $40,$40,$00,$00,$00,$00,$40,$40             ; 03A96B ........ @@????@@
.byte $00,$FF,$FF,$01,$FF,$FF,$00,$FF             ; 03A973 ........ ????????
.byte $FF,$01,$FF,$FF,$DE,$80,$0D,$F0             ; 03A97B ........ ????????
.byte $03,$4C,$41,$81,$A9,$04,$9D,$80             ; 03A983 ........ ?LA?????
.byte $0D,$BD,$46,$0B,$85,$04,$BD,$9C             ; 03A98B ........ ??F?????
.byte $0C,$85,$05,$BD,$2C,$10,$85,$07             ; 03A993 ........ ????,???
.byte $18,$BD,$F2,$0D,$85,$06,$69,$04             ; 03A99B ........ ??????i?
.byte $C9,$2C,$B0,$03,$9D,$F2,$0D,$DE             ; 03A9A3 ........ ?,??????
.byte $9E,$10,$D0,$2A,$CE,$D2,$05,$A9             ; 03A9AB ........ ???*????
.byte $22,$9D,$44,$07,$22,$95,$CA,$0E             ; 03A9B3 ........ "?D?"???
.byte $29,$1F,$69,$20,$9D,$80,$0D,$22             ; 03A9BB ........ )?i ???"
.byte $95,$CA,$0E,$29,$07,$69,$04,$9D             ; 03A9C3 ........ ???)?i??
.byte $2C,$10,$22,$95,$CA,$0E,$29,$07             ; 03A9CB ........ ,?"???)?
.byte $9D,$9E,$10,$4C,$41,$81,$22,$F3             ; 03A9D3 ........ ???LA?"?
.byte $80,$03,$D0,$57,$EE,$C6,$06,$22             ; 03A9DB ........ ???W???"
.byte $94,$80,$03,$A9,$01,$9D,$D2,$06             ; 03A9E3 ........ ????????
.byte $A9,$27,$9D,$44,$07,$A9,$08,$9D             ; 03A9EB ........ ?'?D????
.byte $28,$08,$A4,$07,$18,$A5,$04,$79             ; 03A9F3 ........ (??????y
.byte $3D,$AA,$9D,$46,$0B,$38,$A5,$05             ; 03A9FB ........ =??F?8??
.byte $79,$41,$AA,$9D,$9C,$0C,$B9,$45             ; 03AA03 ........ yA?????E
.byte $AA,$9D,$7E,$09,$B9,$49,$AA,$9D             ; 03AA0B ........ ??~??I??
.byte $62,$0A,$B9,$39,$AA,$9D,$BC,$13             ; 03AA13 ........ b??9????
.byte $A5,$06,$9D,$80,$0D,$A9,$32,$9D             ; 03AA1B ........ ??????2?
.byte $2E,$14,$22,$BC,$AE,$00,$98,$9D             ; 03AA23 ........ .?"?????
.byte $A0,$14,$A9,$01,$99,$5E,$17,$22             ; 03AA2B ........ ?????^?"
.byte $F1,$AE,$00,$4C,$41,$81,$6A,$68             ; 03AA33 ........ ???LA?jh
.byte $6A,$68,$02,$0E,$01,$F4,$F3,$FE             ; 03AA3B ........ jh??????
.byte $0A,$FE,$00,$04,$00,$FC,$FC,$00             ; 03AA43 ........ ????????
.byte $04,$00,$A9,$08,$20,$95,$81,$38             ; 03AA4B ........ ???? ??8
.byte $BD,$46,$0B,$E9,$06,$B0,$02,$A9             ; 03AA53 ........ ?F??????
.byte $00,$9D,$16,$15,$18,$BD,$46,$0B             ; 03AA5B ........ ??????F?
.byte $69,$06,$90,$02,$A9,$FF,$9D,$88             ; 03AA63 ........ i???????
.byte $15,$38,$BD,$9C,$0C,$E9,$06,$B0             ; 03AA6B ........ ?8??????
.byte $02,$A9,$00,$9D,$FA,$15,$18,$BD             ; 03AA73 ........ ????????
.byte $9C,$0C,$69,$06,$90,$02,$A9,$FF             ; 03AA7B ........ ??i?????
.byte $9D,$6C,$16,$DE,$4A,$13,$D0,$3E             ; 03AA83 ........ ?l??J??>
.byte $DE,$2C,$10,$D0,$27,$A9,$22,$9D             ; 03AA8B ........ ?,??'?"?
.byte $44,$07,$22,$95,$CA,$0E,$29,$1F             ; 03AA93 ........ D?"???)?
.byte $69,$20,$9D,$80,$0D,$22,$95,$CA             ; 03AA9B ........ i ???"??
.byte $0E,$29,$07,$69,$04,$9D,$2C,$10             ; 03AAA3 ........ ?)?i??,?
.byte $22,$95,$CA,$0E,$29,$07,$9D,$9E             ; 03AAAB ........ "???)???
.byte $10,$4C,$41,$81,$A9,$03,$9D,$4A             ; 03AAB3 ........ ?LA????J
.byte $13,$BD,$10,$11,$1A,$C9,$0C,$D0             ; 03AABB ........ ????????
.byte $02,$A9,$00,$9D,$10,$11,$BC,$10             ; 03AAC3 ........ ????????
.byte $11,$B9,$5B,$A9,$9D,$BC,$13,$BD             ; 03AACB ........ ??[?????
.byte $2E,$14,$29,$3F,$19,$67,$A9,$9D             ; 03AAD3 ........ .?)??g??
.byte $2E,$14,$A9,$07,$85,$1C,$A9,$09             ; 03AADB ........ .???????
.byte $85,$1D,$22,$C2,$AF,$00,$A5,$D2             ; 03AAE3 ........ ??"?????
.byte $29,$03,$D0,$06,$BD,$B6,$07,$9D             ; 03AAEB ........ )???????
.byte $2E,$14,$4C,$41,$81,$38,$BD,$46             ; 03AAF3 ........ .?LA?8?F
.byte $0B,$E9,$04,$B0,$02,$A9,$00,$9D             ; 03AAFB ........ ????????
.byte $16,$15,$18,$BD,$46,$0B,$69,$04             ; 03AB03 ........ ????F?i?
.byte $90,$02,$A9,$FF,$9D,$88,$15,$38             ; 03AB0B ........ ???????8
.byte $BD,$9C,$0C,$E9,$04,$B0,$02,$A9             ; 03AB13 ........ ????????
.byte $00,$9D,$FA,$15,$18,$BD,$9C,$0C             ; 03AB1B ........ ????????
.byte $69,$04,$90,$02,$A9,$FF,$9D,$6C             ; 03AB23 ........ i??????l
.byte $16,$DE,$80,$0D,$D0,$03,$4C,$8B             ; 03AB2B ........ ??????L?
.byte $AB,$BD,$7E,$09,$30,$12,$1D,$0C             ; 03AB33 ........ ??~?0???
.byte $09,$F0,$1A,$A9,$EE,$DD,$46,$0B             ; 03AB3B ........ ??????F?
.byte $B0,$13,$9D,$46,$0B,$4C,$8B,$AB             ; 03AB43 ........ ???F?L??
.byte $A9,$12,$DD,$46,$0B,$90,$06,$9D             ; 03AB4B ........ ???F????
.byte $46,$0B,$4C,$8B,$AB,$BD,$62,$0A             ; 03AB53 ........ F?L???b?
.byte $30,$12,$1D,$F0,$09,$F0,$1A,$A9             ; 03AB5B ........ 0???????
.byte $DC,$DD,$9C,$0C,$B0,$13,$9D,$9C             ; 03AB63 ........ ????????
.byte $0C,$4C,$8B,$AB,$A9,$20,$DD,$9C             ; 03AB6B ........ ?L??? ??
.byte $0C,$90,$06,$9D,$9C,$0C,$4C,$8B             ; 03AB73 ........ ??????L?
.byte $AB,$A9,$08,$85,$1C,$A9,$08,$85             ; 03AB7B ........ ????????
.byte $1D,$22,$C2,$AF,$00,$4C,$41,$81             ; 03AB83 ........ ?"???LA?
.byte $CE,$C6,$06,$9E,$D2,$06,$DA,$BC             ; 03AB8B ........ ????????
.byte $A0,$14,$22,$F1,$AE,$00,$BD,$A0             ; 03AB93 ........ ??"?????
.byte $14,$AA,$9E,$5E,$17,$0A,$0A,$A8             ; 03AB9B ........ ???^????
.byte $A9,$F0,$90,$05,$99,$09,$04,$80             ; 03ABA3 ........ ????????
.byte $03,$99,$09,$03,$FA,$4C,$41,$81             ; 03ABAB ........ ?????LA?
.byte $DE,$80,$0D,$D0,$0E,$A9,$3C,$9D             ; 03ABB3 ........ ??????<?
.byte $80,$0D,$22,$95,$CA,$0E,$29,$07             ; 03ABBB ........ ??"???)?
.byte $9D,$9E,$10,$BC,$BA,$0F,$B9,$46             ; 03ABC3 ........ ???????F
.byte $0B,$85,$06,$B9,$9C,$0C,$85,$07             ; 03ABCB ........ ????????
.byte $BC,$9E,$10,$B9,$EC,$AC,$85,$08             ; 03ABD3 ........ ????????
.byte $38,$A5,$06,$E5,$08,$B0,$02,$A9             ; 03ABDB ........ 8???????
.byte $00,$DD,$46,$0B,$90,$10,$18,$BD             ; 03ABE3 ........ ??F?????
.byte $0C,$09,$69,$06,$9D,$0C,$09,$90             ; 03ABEB ........ ??i?????
.byte $03,$FE,$7E,$09,$80,$1C,$18,$A5             ; 03ABF3 ........ ??~?????
.byte $06,$65,$08,$90,$02,$A9,$FF,$DD             ; 03ABFB ........ ?e??????
.byte $46,$0B,$B0,$0E,$38,$BD,$0C,$09             ; 03AC03 ........ F???8???
.byte $E9,$06,$9D,$0C,$09,$B0,$03,$DE             ; 03AC0B ........ ????????
.byte $7E,$09,$38,$A5,$07,$E5,$08,$B0             ; 03AC13 ........ ~?8?????
.byte $02,$A9,$00,$DD,$9C,$0C,$90,$10             ; 03AC1B ........ ????????
.byte $18,$BD,$F0,$09,$69,$06,$9D,$F0             ; 03AC23 ........ ????i???
.byte $09,$90,$03,$FE,$62,$0A,$80,$1C             ; 03AC2B ........ ????b???
.byte $18,$A5,$07,$65,$08,$90,$02,$A9             ; 03AC33 ........ ???e????
.byte $FF,$DD,$9C,$0C,$B0,$0E,$38,$BD             ; 03AC3B ........ ??????8?
.byte $F0,$09,$E9,$06,$9D,$F0,$09,$B0             ; 03AC43 ........ ????????
.byte $03,$DE,$62,$0A,$A9,$08,$20,$95             ; 03AC4B ........ ??b??? ?
.byte $81,$BD,$7E,$09,$10,$10,$C9,$FE             ; 03AC53 ........ ??~?????
.byte $F0,$02,$B0,$16,$A9,$FF,$9D,$7E             ; 03AC5B ........ ???????~
.byte $09,$9E,$0C,$09,$80,$0C,$C9,$01             ; 03AC63 ........ ????????
.byte $90,$08,$A9,$01,$9D,$7E,$09,$9E             ; 03AC6B ........ ?????~??
.byte $0C,$09,$BD,$62,$0A,$10,$10,$C9             ; 03AC73 ........ ???b????
.byte $FE,$F0,$02,$B0,$16,$A9,$FF,$9D             ; 03AC7B ........ ????????
.byte $62,$0A,$9E,$F0,$09,$80,$0C,$C9             ; 03AC83 ........ b???????
.byte $01,$90,$08,$A9,$01,$9D,$62,$0A             ; 03AC8B ........ ??????b?
.byte $9E,$F0,$09,$38,$BD,$46,$0B,$E9             ; 03AC93 ........ ???8?F??
.byte $08,$B0,$02,$A9,$00,$9D,$16,$15             ; 03AC9B ........ ????????
.byte $18,$BD,$46,$0B,$69,$08,$90,$02             ; 03ACA3 ........ ??F?i???
.byte $A9,$FF,$9D,$88,$15,$38,$BD,$9C             ; 03ACAB ........ ?????8??
.byte $0C,$E9,$08,$B0,$02,$A9,$00,$9D             ; 03ACB3 ........ ????????
.byte $FA,$15,$18,$BD,$9C,$0C,$69,$08             ; 03ACBB ........ ??????i?
.byte $90,$02,$A9,$FF,$9D,$6C,$16,$A9             ; 03ACC3 ........ ?????l??
.byte $07,$85,$1C,$A9,$09,$85,$1D,$22             ; 03ACCB ........ ???????"
.byte $C2,$AF,$00,$A5,$D2,$29,$03,$D0             ; 03ACD3 ........ ?????)??
.byte $08,$BD,$B6,$07,$09,$38,$9D,$2E             ; 03ACDB ........ ?????8?.
.byte $14,$4C,$41,$81,$20,$22,$24,$26             ; 03ACE3 ........ ?LA? "$&
.byte $28,$00,$08,$10,$18,$20,$28,$30             ; 03ACEB ........ (???? (0
.byte $38,$DE,$80,$0D,$F0,$49,$A9,$08             ; 03ACF3 ........ 8????I??
.byte $20,$95,$81,$BD,$7E,$09,$10,$10             ; 03ACFB ........  ???~???
.byte $C9,$FE,$F0,$02,$B0,$16,$A9,$FF             ; 03AD03 ........ ????????
.byte $9D,$7E,$09,$9E,$0C,$09,$80,$0C             ; 03AD0B ........ ?~??????
.byte $C9,$01,$90,$08,$A9,$01,$9D,$7E             ; 03AD13 ........ ???????~
.byte $09,$9E,$0C,$09,$BD,$62,$0A,$10             ; 03AD1B ........ ?????b??
.byte $10,$C9,$FE,$F0,$02,$B0,$16,$A9             ; 03AD23 ........ ????????
.byte $FF,$9D,$62,$0A,$9E,$F0,$09,$80             ; 03AD2B ........ ??b?????
.byte $0C,$C9,$01,$90,$08,$A9,$01,$9D             ; 03AD33 ........ ????????
.byte $62,$0A,$9E,$F0,$09,$80,$71,$A9             ; 03AD3B ........ b?????q?
.byte $04,$9D,$80,$0D,$BD,$BA,$0F,$85             ; 03AD43 ........ ????????
.byte $04,$9B,$AA,$38,$BD,$46,$0B,$F9             ; 03AD4B ........ ???8?F??
.byte $46,$0B,$90,$11,$AA,$BF,$B0,$FA             ; 03AD53 ........ F???????
.byte $03,$99,$0C,$09,$BF,$B0,$FB,$03             ; 03AD5B ........ ????????
.byte $99,$7E,$09,$80,$17,$49,$FF,$1A             ; 03AD63 ........ ?~???I??
.byte $AA,$38,$A9,$00,$FF,$B0,$FA,$03             ; 03AD6B ........ ?8??????
.byte $99,$0C,$09,$A9,$00,$FF,$B0,$FB             ; 03AD73 ........ ????????
.byte $03,$99,$7E,$09,$A6,$04,$38,$BD             ; 03AD7B ........ ??~???8?
.byte $9C,$0C,$F9,$9C,$0C,$90,$11,$AA             ; 03AD83 ........ ????????
.byte $BF,$B0,$FA,$03,$99,$F0,$09,$BF             ; 03AD8B ........ ????????
.byte $B0,$FB,$03,$99,$62,$0A,$80,$17             ; 03AD93 ........ ????b???
.byte $49,$FF,$1A,$AA,$38,$A9,$00,$FF             ; 03AD9B ........ I???8???
.byte $B0,$FA,$03,$99,$F0,$09,$A9,$00             ; 03ADA3 ........ ????????
.byte $FF,$B0,$FB,$03,$99,$62,$0A,$BB             ; 03ADAB ........ ?????b??
.byte $38,$BD,$46,$0B,$E9,$08,$B0,$02             ; 03ADB3 ........ 8?F?????
.byte $A9,$00,$9D,$16,$15,$18,$BD,$46             ; 03ADBB ........ ???????F
.byte $0B,$69,$08,$90,$02,$A9,$FF,$9D             ; 03ADC3 ........ ?i??????
.byte $88,$15,$38,$BD,$9C,$0C,$E9,$08             ; 03ADCB ........ ??8?????
.byte $B0,$02,$A9,$00,$9D,$FA,$15,$18             ; 03ADD3 ........ ????????
.byte $BD,$9C,$0C,$69,$08,$90,$02,$A9             ; 03ADDB ........ ???i????
.byte $FF,$9D,$6C,$16,$A9,$07,$85,$1C             ; 03ADE3 ........ ??l?????
.byte $A9,$09,$85,$1D,$22,$C2,$AF,$00             ; 03ADEB ........ ????"???
.byte $A5,$D2,$29,$03,$D0,$08,$BD,$B6             ; 03ADF3 ........ ??)?????
.byte $07,$09,$38,$9D,$2E,$14,$4C,$41             ; 03ADFB ........ ??8?.?LA
.byte $81,$20,$22,$24,$26,$28                     ; 03AE04 ......   ? "$&(

  LDA.B $D2                                       ; 03AE09 A5 D2 
  AND.B #$01                                      ; 03AE0B 29 01 
  BNE.B B_3AE88                                   ; 03AE0D D0 79 
  DEC.W EntityV15,X                                   ; 03AE0F DE 80 0D 
  BNE.B B_3AE88                                   ; 03AE12 D0 74 
  LDA.W EntityV20,X                                   ; 03AE14 BD BA 0F 
  AND.B #$01                                      ; 03AE17 29 01 
  BEQ.B B_3AE40                                   ; 03AE19 F0 25 
  JSL AdvanceRNG                                     ; 03AE1B 22 95 CA 0E 
  AND.B #$01                                      ; 03AE1F 29 01 
  TAY                                             ; 03AE21 A8 
  LDA.W D_3AEDA,Y                                 ; 03AE22 B9 DA AE 
  STA.W EntityV20,X                                   ; 03AE25 9D BA 0F 
  TYA                                             ; 03AE28 98 
  ASL                                             ; 03AE29 0A 
  TAY                                             ; 03AE2A A8 
  LDA.W D_3AEE6,Y                                 ; 03AE2B B9 E6 AE 
  STA.W EntityYSubPxSpeed,X                                   ; 03AE2E 9D F0 09 
  LDA.W D_3AEE7,Y                                 ; 03AE31 B9 E7 AE 
  STA.W EntityYPxSpeed,X                                   ; 03AE34 9D 62 0A 
  STZ.W EntityXSubPxSpeed,X                                   ; 03AE37 9E 0C 09 
  STZ.W EntityXPxSpeed,X                                   ; 03AE3A 9E 7E 09 
  JMP.W D_3AE62                                   ; 03AE3D 4C 62 AE 
B_3AE40:
  JSL AdvanceRNG                                     ; 03AE40 22 95 CA 0E 
  AND.B #$01                                      ; 03AE44 29 01 
  TAY                                             ; 03AE46 A8 
  LDA.W D_3AEDC,Y                                 ; 03AE47 B9 DC AE 
  STA.W EntityV20,X                                   ; 03AE4A 9D BA 0F 
  TYA                                             ; 03AE4D 98 
  ASL                                             ; 03AE4E 0A 
  TAY                                             ; 03AE4F A8 
  LDA.W D_3AEE6,Y                                 ; 03AE50 B9 E6 AE 
  STA.W EntityXSubPxSpeed,X                                   ; 03AE53 9D 0C 09 
  LDA.W D_3AEE7,Y                                 ; 03AE56 B9 E7 AE 
  STA.W EntityXPxSpeed,X                                   ; 03AE59 9D 7E 09 
  STZ.W EntityYSubPxSpeed,X                                   ; 03AE5C 9E F0 09 
  STZ.W EntityYPxSpeed,X                                   ; 03AE5F 9E 62 0A 
D_3AE62:
  LDA.B #$2D                                      ; 03AE62 A9 2D 
  STA.W EntityTypeId,X                                   ; 03AE64 9D 44 07 
  JSL AdvanceRNG                                     ; 03AE67 22 95 CA 0E 
  AND.W EntityV22,X                                   ; 03AE6B 3D 9E 10 
  ADC.W EntityV21,X                                   ; 03AE6E 7D 2C 10 
  STA.W EntityV15,X                                   ; 03AE71 9D 80 0D 
  LDY.W EntityV20,X                                   ; 03AE74 BC BA 0F 
  LDA.W D_3AEDE,Y                                 ; 03AE77 B9 DE AE 
  STA.W EntityV29,X                                   ; 03AE7A 9D BC 13 
  LDA.B #$26                                      ; 03AE7D A9 26 
  STA.W EntityV2,X                                   ; 03AE7F 9D B6 07 
  ORA.W D_3AEE2,Y                                 ; 03AE82 19 E2 AE 
  STA.W EntityV30,X                                   ; 03AE85 9D 2E 14 
B_3AE88:
  SEC                                             ; 03AE88 38 
  LDA.W EntityXPx,X                              ; 03AE89 BD 46 0B 
  SBC.B #$08                                      ; 03AE8C E9 08 
  BCS.B B_3AE92                                   ; 03AE8E B0 02 
  LDA.B #$00                                      ; 03AE90 A9 00 
B_3AE92:
  STA.W EntityV32,X                                   ; 03AE92 9D 16 15 
  CLC                                             ; 03AE95 18 
  LDA.W EntityXPx,X                              ; 03AE96 BD 46 0B 
  ADC.B #$08                                      ; 03AE99 69 08 
  BCC.B B_3AE9F                                   ; 03AE9B 90 02 
  LDA.B #$FF                                      ; 03AE9D A9 FF 
B_3AE9F:
  STA.W EntityV33,X                                   ; 03AE9F 9D 88 15 
  SEC                                             ; 03AEA2 38 
  LDA.W EntityYPx,X                                   ; 03AEA3 BD 9C 0C 
  SBC.B #$08                                      ; 03AEA6 E9 08 
  BCS.B B_3AEAC                                   ; 03AEA8 B0 02 
  LDA.B #$00                                      ; 03AEAA A9 00 
B_3AEAC:
  STA.W EntityV34,X                                   ; 03AEAC 9D FA 15 
  CLC                                             ; 03AEAF 18 
  LDA.W EntityYPx,X                                   ; 03AEB0 BD 9C 0C 
  ADC.B #$08                                      ; 03AEB3 69 08 
  BCC.B B_3AEB9                                   ; 03AEB5 90 02 

.byte $A9,$FF                                     ; 03AEB8 ..       ??

B_3AEB9:
  STA.W EntityV35,X                                   ; 03AEB9 9D 6C 16 
  LDA.B #$08                                      ; 03AEBC A9 08 
  STA.B $1C                                       ; 03AEBE 85 1C 
  LDA.B #$09                                      ; 03AEC0 A9 09 
  STA.B $1D                                       ; 03AEC2 85 1D 
  JSL L_AFC2                                      ; 03AEC4 22 C2 AF 00 
  LDA.B $D2                                       ; 03AEC8 A5 D2 
  AND.B #$03                                      ; 03AECA 29 03 
  BNE.B B_3AED7                                   ; 03AECC D0 09 
  LDA.W EntityV30,X                                   ; 03AECE BD 2E 14 
  ORA.W EntityV2,X                                   ; 03AED1 1D B6 07 
  STA.W EntityV30,X                                   ; 03AED4 9D 2E 14 
B_3AED7:
  JMP.W AdvanceToNextEntity                                   ; 03AED7 4C 41 81 

D_3AEDA:
.byte $00,$02                                     ; 03AEDB DD       ??
D_3AEDC:
.byte $03,$01                                     ; 03AEDD DD       ??
D_3AEDE:
.byte $EC,$EA,$E8,$EA                             ; 03AEDF DDDD     ????
D_3AEE2:
.byte $00,$40,$00,$00                             ; 03AEE3 DDDD     ?@??
D_3AEE6:
.byte $40                                         ; 03AEE7 D        @
D_3AEE7:
.byte $00,$C0,$FF                                 ; 03AEE8 DDD      ???

  SEC                                             ; 03AEEA 38 
  LDA.W EntityXPx,X                              ; 03AEEB BD 46 0B 
  SBC.B #$08                                      ; 03AEEE E9 08 
  BCS.B B_3AEF4                                   ; 03AEF0 B0 02 

.byte $A9,$00                                     ; 03AEF3 ..       ??

B_3AEF4:
  STA.W EntityV32,X                                   ; 03AEF4 9D 16 15 
  CLC                                             ; 03AEF7 18 
  LDA.W EntityXPx,X                              ; 03AEF8 BD 46 0B 
  ADC.B #$08                                      ; 03AEFB 69 08 
  BCC.B B_3AF01                                   ; 03AEFD 90 02 

.byte $A9,$FF                                     ; 03AF00 ..       ??

B_3AF01:
  STA.W EntityV33,X                                   ; 03AF01 9D 88 15 
  SEC                                             ; 03AF04 38 
  LDA.W EntityYPx,X                                   ; 03AF05 BD 9C 0C 
  SBC.B #$08                                      ; 03AF08 E9 08 
  BCS.B B_3AF0E                                   ; 03AF0A B0 02 

.byte $A9,$00                                     ; 03AF0D ..       ??

B_3AF0E:
  STA.W EntityV34,X                                   ; 03AF0E 9D FA 15 
  CLC                                             ; 03AF11 18 
  LDA.W EntityYPx,X                                   ; 03AF12 BD 9C 0C 
  ADC.B #$08                                      ; 03AF15 69 08 
  BCC.B B_3AF1B                                   ; 03AF17 90 02 

.byte $A9,$FF                                     ; 03AF1A ..       ??

B_3AF1B:
  STA.W EntityV35,X                                   ; 03AF1B 9D 6C 16 
  LDY.W EntityV20,X                                   ; 03AF1E BC BA 0F 
  BEQ.B B_3AF50                                   ; 03AF21 F0 2D 
  DEY                                             ; 03AF23 88 
  BEQ.B B_3AF43                                   ; 03AF24 F0 1D 
  DEY                                             ; 03AF26 88 
  BEQ.B B_3AF36                                   ; 03AF27 F0 0D 
  LDA.W EntityXPx,X                              ; 03AF29 BD 46 0B 
  CMP.B #$E2                                      ; 03AF2C C9 E2 
  BCC.B B_3AF89                                   ; 03AF2E 90 59 
  JSR.W L_3AFFA                                   ; 03AF30 20 FA AF 
  JMP.W D_3AF5A                                   ; 03AF33 4C 5A AF 
B_3AF36:
  LDA.W EntityYPx,X                                   ; 03AF36 BD 9C 0C 
  CMP.B #$2C                                      ; 03AF39 C9 2C 
  BCS.B B_3AF89                                   ; 03AF3B B0 4C 
  JSR.W L_3B009                                   ; 03AF3D 20 09 B0 
  JMP.W D_3AF5A                                   ; 03AF40 4C 5A AF 
B_3AF43:
  LDA.W EntityXPx,X                              ; 03AF43 BD 46 0B 
  CMP.B #$1E                                      ; 03AF46 C9 1E 
  BCS.B B_3AF89                                   ; 03AF48 B0 3F 
  JSR.W L_3AFFA                                   ; 03AF4A 20 FA AF 
  JMP.W D_3AF5A                                   ; 03AF4D 4C 5A AF 
B_3AF50:
  LDA.W EntityYPx,X                                   ; 03AF50 BD 9C 0C 
  CMP.B #$D0                                      ; 03AF53 C9 D0 
  BCC.B B_3AF89                                   ; 03AF55 90 32 
  JSR.W L_3B009                                   ; 03AF57 20 09 B0 
D_3AF5A:
  LDY.W EntityV20,X                                   ; 03AF5A BC BA 0F 
  LDA.W D_3AFE2,Y                                 ; 03AF5D B9 E2 AF 
  STA.W EntityV29,X                                   ; 03AF60 9D BC 13 
  LDA.W EntityV2,X                                   ; 03AF63 BD B6 07 
  ORA.W D_3AFE6,Y                                 ; 03AF66 19 E6 AF 
  STA.W EntityV30,X                                   ; 03AF69 9D 2E 14 
  LDA.W EntityV20,X                                   ; 03AF6C BD BA 0F 
  ASL                                             ; 03AF6F 0A 
  TAY                                             ; 03AF70 A8 
  LDA.W D_3AFEA,Y                                 ; 03AF71 B9 EA AF 
  STA.W EntityXSubPxSpeed,X                                   ; 03AF74 9D 0C 09 
  LDA.W D_3AFEB,Y                                 ; 03AF77 B9 EB AF 
  STA.W EntityXPxSpeed,X                                   ; 03AF7A 9D 7E 09 
  LDA.W D_3AFF2,Y                                 ; 03AF7D B9 F2 AF 
  STA.W EntityYSubPxSpeed,X                                   ; 03AF80 9D F0 09 
  LDA.W D_3AFF3,Y                                 ; 03AF83 B9 F3 AF 
  STA.W EntityYPxSpeed,X                                   ; 03AF86 9D 62 0A 
B_3AF89:
  LDA.B $D2                                       ; 03AF89 A5 D2 
  AND.B #$07                                      ; 03AF8B 29 07 
  BNE.B B_3AFBC                                   ; 03AF8D D0 2D 
  DEC.W EntityV15,X                                   ; 03AF8F DE 80 0D 
  BNE.B B_3AFBC                                   ; 03AF92 D0 28 
  LDA.B #$2E                                      ; 03AF94 A9 2E 
  STA.W EntityTypeId,X                                   ; 03AF96 9D 44 07 
  LDA.B #$3C                                      ; 03AF99 A9 3C 
  STA.W EntityV15,X                                   ; 03AF9B 9D 80 0D 
  LDY.W EntityV20,X                                   ; 03AF9E BC BA 0F 
  LDA.W D_3AFDA,Y                                 ; 03AFA1 B9 DA AF 
  STA.W EntityV29,X                                   ; 03AFA4 9D BC 13 
  LDA.W EntityV2,X                                   ; 03AFA7 BD B6 07 
  ORA.W D_3AFDE,Y                                 ; 03AFAA 19 DE AF 
  STA.W EntityV30,X                                   ; 03AFAD 9D 2E 14 
  STZ.W EntityXSubPxSpeed,X                                   ; 03AFB0 9E 0C 09 
  STZ.W EntityXPxSpeed,X                                   ; 03AFB3 9E 7E 09 
  STZ.W EntityYSubPxSpeed,X                                   ; 03AFB6 9E F0 09 
  STZ.W EntityYPxSpeed,X                                   ; 03AFB9 9E 62 0A 
B_3AFBC:
  LDA.B #$08                                      ; 03AFBC A9 08 
  STA.B $1C                                       ; 03AFBE 85 1C 
  LDA.B #$09                                      ; 03AFC0 A9 09 
  STA.B $1D                                       ; 03AFC2 85 1D 
  JSL L_AFC2                                      ; 03AFC4 22 C2 AF 00 
  LDA.B $D2                                       ; 03AFC8 A5 D2 
  AND.B #$03                                      ; 03AFCA 29 03 
  BNE.B B_3AFD7                                   ; 03AFCC D0 09 
  LDA.W EntityV30,X                                   ; 03AFCE BD 2E 14 
  ORA.W EntityV2,X                                   ; 03AFD1 1D B6 07 
  STA.W EntityV30,X                                   ; 03AFD4 9D 2E 14 
B_3AFD7:
  JMP.W AdvanceToNextEntity                                   ; 03AFD7 4C 41 81 

D_3AFDA:
.byte $0C,$0C,$0A,$0C                             ; 03AFDB DDDD     ????
D_3AFDE:
.byte $01,$41,$01,$01                             ; 03AFDF DDDD     ?A??
D_3AFE2:
.byte $EC,$EA,$E8,$EA                             ; 03AFE3 DDDD     ????
D_3AFE6:
.byte $00,$40,$00,$00                             ; 03AFE7 DDDD     ?@??
D_3AFEA:
.byte $00                                         ; 03AFEB D        ?
D_3AFEB:
.byte $00,$C0,$FF,$00,$00,$40,$00                 ; 03AFEC DDDDDDD  ?????@?
D_3AFF2:
.byte $40                                         ; 03AFF3 D        @
D_3AFF3:
.byte $00,$00,$00,$C0,$FF,$00,$00                 ; 03AFF4 DDDDDDD  ???????


L_3AFFA:
  LDA.W EntityYPx,X                                   ; 03AFFA BD 9C 0C 
  BPL.B B_3B005                                   ; 03AFFD 10 06 
  LDA.B #$02                                      ; 03AFFF A9 02 
  STA.W EntityV20,X                                   ; 03B001 9D BA 0F 
  RTS                                             ; 03B004 60 

B_3B005:
  STZ.W EntityV20,X                                   ; 03B005 9E BA 0F 
  RTS                                             ; 03B008 60 


L_3B009:
  LDA.W EntityXPx,X                              ; 03B009 BD 46 0B 
  BPL.B B_3B014                                   ; 03B00C 10 06 
  LDA.B #$01                                      ; 03B00E A9 01 
  STA.W EntityV20,X                                   ; 03B010 9D BA 0F 
  RTS                                             ; 03B013 60 

B_3B014:
  LDA.B #$03                                      ; 03B014 A9 03 
  STA.W EntityV20,X                                   ; 03B016 9D BA 0F 
  RTS                                             ; 03B019 60 

  DEC.W EntityV15,X                                   ; 03B01A DE 80 0D 
  BNE.B B_3B035                                   ; 03B01D D0 16 
  LDA.B #$2F                                      ; 03B01F A9 2F 
  STA.W EntityTypeId,X                                   ; 03B021 9D 44 07 
  LDA.B #$3C                                      ; 03B024 A9 3C 
  STA.W EntityV15,X                                   ; 03B026 9D 80 0D 
  LDA.W EntityXPx,X                              ; 03B029 BD 46 0B 
  STA.W EntityV20,X                                   ; 03B02C 9D BA 0F 
  LDA.W EntityYPx,X                                   ; 03B02F BD 9C 0C 
  STA.W EntityV21,X                                   ; 03B032 9D 2C 10 
B_3B035:
  SEC                                             ; 03B035 38 
  LDA.W EntityXPx,X                              ; 03B036 BD 46 0B 
  SBC.B #$08                                      ; 03B039 E9 08 
  BCS.B B_3B03F                                   ; 03B03B B0 02 

.byte $A9,$00                                     ; 03B03E ..       ??

B_3B03F:
  STA.W EntityV32,X                                   ; 03B03F 9D 16 15 
  CLC                                             ; 03B042 18 
  LDA.W EntityXPx,X                              ; 03B043 BD 46 0B 
  ADC.B #$08                                      ; 03B046 69 08 
  BCC.B B_3B04C                                   ; 03B048 90 02 

.byte $A9,$FF                                     ; 03B04B ..       ??

B_3B04C:
  STA.W EntityV33,X                                   ; 03B04C 9D 88 15 
  SEC                                             ; 03B04F 38 
  LDA.W EntityYPx,X                                   ; 03B050 BD 9C 0C 
  SBC.B #$08                                      ; 03B053 E9 08 
  BCS.B B_3B059                                   ; 03B055 B0 02 

.byte $A9,$00                                     ; 03B058 ..       ??

B_3B059:
  STA.W EntityV34,X                                   ; 03B059 9D FA 15 
  CLC                                             ; 03B05C 18 
  LDA.W EntityYPx,X                                   ; 03B05D BD 9C 0C 
  ADC.B #$08                                      ; 03B060 69 08 
  BCC.B B_3B066                                   ; 03B062 90 02 

.byte $A9,$FF                                     ; 03B065 ..       ??

B_3B066:
  STA.W EntityV35,X                                   ; 03B066 9D 6C 16 
  LDA.B #$08                                      ; 03B069 A9 08 
  STA.B $1C                                       ; 03B06B 85 1C 
  LDA.B #$09                                      ; 03B06D A9 09 
  STA.B $1D                                       ; 03B06F 85 1D 
  JSL L_AFC2                                      ; 03B071 22 C2 AF 00 
  LDA.B $D2                                       ; 03B075 A5 D2 
  AND.B #$03                                      ; 03B077 29 03 
  BNE.B B_3B084                                   ; 03B079 D0 09 
  LDA.W EntityV30,X                                   ; 03B07B BD 2E 14 
  ORA.W EntityV2,X                                   ; 03B07E 1D B6 07 
  STA.W EntityV30,X                                   ; 03B081 9D 2E 14 
B_3B084:
  JMP.W AdvanceToNextEntity                                   ; 03B084 4C 41 81 
  SEC                                             ; 03B087 38 
  LDA.W EntityXPx,X                              ; 03B088 BD 46 0B 
  SBC.B #$08                                      ; 03B08B E9 08 
  BCS.B B_3B091                                   ; 03B08D B0 02 

.byte $A9,$00                                     ; 03B090 ..       ??

B_3B091:
  STA.W EntityV32,X                                   ; 03B091 9D 16 15 
  CLC                                             ; 03B094 18 
  LDA.W EntityXPx,X                              ; 03B095 BD 46 0B 
  ADC.B #$08                                      ; 03B098 69 08 
  BCC.B B_3B09E                                   ; 03B09A 90 02 

.byte $A9,$FF                                     ; 03B09D ..       ??

B_3B09E:
  STA.W EntityV33,X                                   ; 03B09E 9D 88 15 
  SEC                                             ; 03B0A1 38 
  LDA.W EntityYPx,X                                   ; 03B0A2 BD 9C 0C 
  SBC.B #$08                                      ; 03B0A5 E9 08 
  BCS.B B_3B0AB                                   ; 03B0A7 B0 02 

.byte $A9,$00                                     ; 03B0AA ..       ??

B_3B0AB:
  STA.W EntityV34,X                                   ; 03B0AB 9D FA 15 
  CLC                                             ; 03B0AE 18 
  LDA.W EntityYPx,X                                   ; 03B0AF BD 9C 0C 
  ADC.B #$08                                      ; 03B0B2 69 08 
  BCC.B B_3B0B8                                   ; 03B0B4 90 02 

.byte $A9,$FF                                     ; 03B0B7 ..       ??

B_3B0B8:
  STA.W EntityV35,X                                   ; 03B0B8 9D 6C 16 
  DEC.W EntityV15,X                                   ; 03B0BB DE 80 0D 
  BEQ.B B_3B100                                   ; 03B0BE F0 40 
  JSL AdvanceRNG                                     ; 03B0C0 22 95 CA 0E 
  AND.B #$03                                      ; 03B0C4 29 03 
  TAY                                             ; 03B0C6 A8 
  CLC                                             ; 03B0C7 18 
  LDA.W EntityV20,X                                   ; 03B0C8 BD BA 0F 
  ADC.W D_3B1EA,Y                                 ; 03B0CB 79 EA B1 
  STA.W EntityXPx,X                              ; 03B0CE 9D 46 0B 
  JSL AdvanceRNG                                     ; 03B0D1 22 95 CA 0E 
  AND.B #$03                                      ; 03B0D5 29 03 
  TAY                                             ; 03B0D7 A8 
  CLC                                             ; 03B0D8 18 
  LDA.W EntityV21,X                                   ; 03B0D9 BD 2C 10 
  ADC.W D_3B1EA,Y                                 ; 03B0DC 79 EA B1 
  STA.W EntityYPx,X                                   ; 03B0DF 9D 9C 0C 
  LDA.B #$08                                      ; 03B0E2 A9 08 
  STA.B $1C                                       ; 03B0E4 85 1C 
  LDA.B #$09                                      ; 03B0E6 A9 09 
  STA.B $1D                                       ; 03B0E8 85 1D 
  JSL L_AFC2                                      ; 03B0EA 22 C2 AF 00 
  LDA.B $D2                                       ; 03B0EE A5 D2 
  AND.B #$03                                      ; 03B0F0 29 03 
  BNE.B B_3B0FD                                   ; 03B0F2 D0 09 
  LDA.W EntityV30,X                                   ; 03B0F4 BD 2E 14 
  ORA.W EntityV2,X                                   ; 03B0F7 1D B6 07 
  STA.W EntityV30,X                                   ; 03B0FA 9D 2E 14 
B_3B0FD:
  JMP.W AdvanceToNextEntity                                   ; 03B0FD 4C 41 81 
B_3B100:
  DEC.W $18EC                                     ; 03B100 CE EC 18 
  DEC.W $06C6                                     ; 03B103 CE C6 06 
  LDA.B #$09                                      ; 03B106 A9 09 
  STA.W EntityTypeId,X                                   ; 03B108 9D 44 07 
  LDA.B #$00                                      ; 03B10B A9 00 
  STA.W EntityV3,X                                   ; 03B10D 9D 28 08 
  LDA.B #$20                                      ; 03B110 A9 20 
  STA.W EntityV29,X                                   ; 03B112 9D BC 13 
  LDA.B #$22                                      ; 03B115 A9 22 
  STA.W EntityV30,X                                   ; 03B117 9D 2E 14 
  STZ.W EntityXSubPxSpeed,X                                   ; 03B11A 9E 0C 09 
  STZ.W EntityXPxSpeed,X                                   ; 03B11D 9E 7E 09 
  STZ.W EntityYSubPxSpeed,X                                   ; 03B120 9E F0 09 
  STZ.W EntityYPxSpeed,X                                   ; 03B123 9E 62 0A 
  LDA.B #$04                                      ; 03B126 A9 04 
  STA.W EntityV28,X                                   ; 03B128 9D 4A 13 
  STZ.W EntityV27,X                                   ; 03B12B 9E D8 12 
  LDA.W EntityXPx,X                              ; 03B12E BD 46 0B 
  STA.B $04                                       ; 03B131 85 04 
  LDA.W EntityYPx,X                                   ; 03B133 BD 9C 0C 
  STA.B $05                                       ; 03B136 85 05 
  LDX.B #$07                                      ; 03B138 A2 07 
D_3B13A:
  STX.B $06                                       ; 03B13A 86 06 
  JSL FindEmptyEntitySlot                                     ; 03B13C 22 F3 80 03 
  BEQ.B B_3B145                                   ; 03B140 F0 03 

.byte $4C,$41,$81                                 ; 03B143 ...      LA?

B_3B145:
  INC.W $06C6                                     ; 03B145 EE C6 06 
  JSL ClearEntitySlotData                                     ; 03B148 22 94 80 03 
  LDA.B #$01                                      ; 03B14C A9 01 
  STA.W EntityHeader,X                                   ; 03B14E 9D D2 06 
  LDA.B #$31                                      ; 03B151 A9 31 
  STA.W EntityTypeId,X                                   ; 03B153 9D 44 07 
  LDA.B #$0C                                      ; 03B156 A9 0C 
  STA.W EntityV3,X                                   ; 03B158 9D 28 08 
  LDA.B #$48                                      ; 03B15B A9 48 
  STA.W EntityV29,X                                   ; 03B15D 9D BC 13 
  LDA.B #$37                                      ; 03B160 A9 37 
  STA.W EntityV30,X                                   ; 03B162 9D 2E 14 
  LDA.B $04                                       ; 03B165 A5 04 
  STA.W EntityXPx,X                              ; 03B167 9D 46 0B 
  LDA.B $05                                       ; 03B16A A5 05 
  STA.W EntityYPx,X                                   ; 03B16C 9D 9C 0C 
  LDA.B $06                                       ; 03B16F A5 06 
  ASL                                             ; 03B171 0A 
  TAY                                             ; 03B172 A8 
  LDA.W D_3B1EE,Y                                 ; 03B173 B9 EE B1 
  STA.W EntityXSubPxSpeed,X                                   ; 03B176 9D 0C 09 
  LDA.W D_3B1EF,Y                                 ; 03B179 B9 EF B1 
  STA.W EntityXPxSpeed,X                                   ; 03B17C 9D 7E 09 
  LDA.W D_3B1FE,Y                                 ; 03B17F B9 FE B1 
  STA.W EntityYSubPxSpeed,X                                   ; 03B182 9D F0 09 
  LDA.W D_3B1FF,Y                                 ; 03B185 B9 FF B1 
  STA.W EntityYPxSpeed,X                                   ; 03B188 9D 62 0A 
  JSL L_AEBC                                      ; 03B18B 22 BC AE 00 
  TYA                                             ; 03B18F 98 
  STA.W EntityV31,X                                   ; 03B190 9D A0 14 
  LDA.B #$01                                      ; 03B193 A9 01 
  STA.W StateFlags,Y                                   ; 03B195 99 5E 17 
  JSL L_AEF1                                      ; 03B198 22 F1 AE 00 
  SEC                                             ; 03B19C 38 
  LDA.W EntityXPx,X                              ; 03B19D BD 46 0B 
  SBC.B #$04                                      ; 03B1A0 E9 04 
  BCS.B B_3B1A6                                   ; 03B1A2 B0 02 

.byte $A9,$00                                     ; 03B1A5 ..       ??

B_3B1A6:
  STA.W EntityV32,X                                   ; 03B1A6 9D 16 15 
  CLC                                             ; 03B1A9 18 
  LDA.W EntityXPx,X                              ; 03B1AA BD 46 0B 
  ADC.B #$04                                      ; 03B1AD 69 04 
  BCC.B B_3B1B3                                   ; 03B1AF 90 02 

.byte $A9,$FF                                     ; 03B1B2 ..       ??

B_3B1B3:
  STA.W EntityV33,X                                   ; 03B1B3 9D 88 15 
  SEC                                             ; 03B1B6 38 
  LDA.W EntityYPx,X                                   ; 03B1B7 BD 9C 0C 
  SBC.B #$04                                      ; 03B1BA E9 04 
  BCS.B B_3B1C0                                   ; 03B1BC B0 02 

.byte $A9,$00                                     ; 03B1BF ..       ??

B_3B1C0:
  STA.W EntityV34,X                                   ; 03B1C0 9D FA 15 
  CLC                                             ; 03B1C3 18 
  LDA.W EntityYPx,X                                   ; 03B1C4 BD 9C 0C 
  ADC.B #$04                                      ; 03B1C7 69 04 
  BCC.B B_3B1CD                                   ; 03B1C9 90 02 

.byte $A9,$FF                                     ; 03B1CC ..       ??

B_3B1CD:
  STA.W EntityV35,X                                   ; 03B1CD 9D 6C 16 
  LDX.B $06                                       ; 03B1D0 A6 06 
  DEX                                             ; 03B1D2 CA 
  BMI.B B_3B1D8                                   ; 03B1D3 30 03 
  JMP.W D_3B13A                                   ; 03B1D5 4C 3A B1 
B_3B1D8:
  PHX                                             ; 03B1D8 DA 
  REP.B #P_Idx8Bit                                      ; 03B1D9 C2 10 
  LDA.B #$07                                      ; 03B1DB A9 07 
  LDX.W #$FF06                                    ; 03B1DD A2 06 FF 
  JSL Audio_F830F                                     ; 03B1E0 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 03B1E4 E2 30 
  PLX                                             ; 03B1E6 FA 
  JMP.W AdvanceToNextEntity                                   ; 03B1E7 4C 41 81 

D_3B1EA:
.byte $00,$01,$FF,$00                             ; 03B1EB DDDD     ????
D_3B1EE:
.byte $00                                         ; 03B1EF D        ?
D_3B1EF:
.byte $00,$10,$01,$80,$01,$10,$01,$00             ; 03B1EF DDDDDDDD ????????
.byte $00,$F0,$FE,$80,$FE,$F0,$FE                 ; 03B1F8 DDDDDDD  ???????
D_3B1FE:
.byte $80                                         ; 03B1FF D        ?
D_3B1FF:
.byte $FE,$F0,$FE,$00,$00,$10,$01,$80             ; 03B1FF DDDDDDDD ????????
.byte $01,$10,$01,$00,$00,$F0,$FE                 ; 03B208 DDDDDDD  ???????

  DEC.W EntityV15,X                                   ; 03B20E DE 80 0D 
  BNE.B B_3B246                                   ; 03B211 D0 33 
  LDA.B #$2C                                      ; 03B213 A9 2C 
  STA.W EntityTypeId,X                                   ; 03B215 9D 44 07 
  JSL AdvanceRNG                                     ; 03B218 22 95 CA 0E 
  AND.B #$1F                                      ; 03B21C 29 1F 
  CLC                                             ; 03B21E 18 
  ADC.B #$0A                                      ; 03B21F 69 0A 
  STA.W EntityV15,X                                   ; 03B221 9D 80 0D 
  LDA.B #$3F                                      ; 03B224 A9 3F 
  STA.W EntityV22,X                                   ; 03B226 9D 9E 10 
  LDA.W EntityV20,X                                   ; 03B229 BD BA 0F 
  ASL                                             ; 03B22C 0A 
  TAY                                             ; 03B22D A8 
  LDA.W D_3B2B0,Y                                 ; 03B22E B9 B0 B2 
  STA.W EntityXSubPxSpeed,X                                   ; 03B231 9D 0C 09 
  LDA.W D_3B2B1,Y                                 ; 03B234 B9 B1 B2 
  STA.W EntityXPxSpeed,X                                   ; 03B237 9D 7E 09 
  LDA.W D_3B2B8,Y                                 ; 03B23A B9 B8 B2 
  STA.W EntityYSubPxSpeed,X                                   ; 03B23D 9D F0 09 
  LDA.W D_3B2B9,Y                                 ; 03B240 B9 B9 B2 
  STA.W EntityYPxSpeed,X                                   ; 03B243 9D 62 0A 
B_3B246:
  SEC                                             ; 03B246 38 
  LDA.W EntityXPx,X                              ; 03B247 BD 46 0B 
  SBC.B #$08                                      ; 03B24A E9 08 
  BCS.B B_3B250                                   ; 03B24C B0 02 

.byte $A9,$00                                     ; 03B24F ..       ??

B_3B250:
  STA.W EntityV32,X                                   ; 03B250 9D 16 15 
  CLC                                             ; 03B253 18 
  LDA.W EntityXPx,X                              ; 03B254 BD 46 0B 
  ADC.B #$08                                      ; 03B257 69 08 
  BCC.B B_3B25D                                   ; 03B259 90 02 

.byte $A9,$FF                                     ; 03B25C ..       ??

B_3B25D:
  STA.W EntityV33,X                                   ; 03B25D 9D 88 15 
  SEC                                             ; 03B260 38 
  LDA.W EntityYPx,X                                   ; 03B261 BD 9C 0C 
  SBC.B #$08                                      ; 03B264 E9 08 
  BCS.B B_3B26A                                   ; 03B266 B0 02 

.byte $A9,$00                                     ; 03B269 ..       ??

B_3B26A:
  STA.W EntityV34,X                                   ; 03B26A 9D FA 15 
  CLC                                             ; 03B26D 18 
  LDA.W EntityYPx,X                                   ; 03B26E BD 9C 0C 
  ADC.B #$08                                      ; 03B271 69 08 
  BCC.B B_3B277                                   ; 03B273 90 02 

.byte $A9,$FF                                     ; 03B276 ..       ??

B_3B277:
  STA.W EntityV35,X                                   ; 03B277 9D 6C 16 
  SEC                                             ; 03B27A 38 
  LDA.W EntityXPx,X                              ; 03B27B BD 46 0B 
  SBC.B #$08                                      ; 03B27E E9 08 
  STA.B $04                                       ; 03B280 85 04 
  LDA.W EntityXMovement,X                                   ; 03B282 BD B8 0B 
  SBC.B #$00                                      ; 03B285 E9 00 
  STA.B $05                                       ; 03B287 85 05 
  SEC                                             ; 03B289 38 
  LDA.W EntityYPx,X                                   ; 03B28A BD 9C 0C 
  SBC.B #$09                                      ; 03B28D E9 09 
  STA.B $06                                       ; 03B28F 85 06 
  LDA.W EntityYMovement,X                                   ; 03B291 BD 0E 0D 
  SBC.B #$00                                      ; 03B294 E9 00 
  STA.B $07                                       ; 03B296 85 07 
  JSL L_AF42                                      ; 03B298 22 42 AF 00 
  LDA.B $D2                                       ; 03B29C A5 D2 
  AND.B #$03                                      ; 03B29E 29 03 
  BNE.B B_3B2AD                                   ; 03B2A0 D0 0B 
  LDA.W EntityV30,X                                   ; 03B2A2 BD 2E 14 
  AND.B #$40                                      ; 03B2A5 29 40 
  ORA.W EntityV2,X                                   ; 03B2A7 1D B6 07 
  STA.W EntityV30,X                                   ; 03B2AA 9D 2E 14 
B_3B2AD:
  JMP.W AdvanceToNextEntity                                   ; 03B2AD 4C 41 81 

D_3B2B0:
.byte $00                                         ; 03B2B1 D        ?
D_3B2B1:
.byte $00,$C0,$FF,$00,$00,$40,$00                 ; 03B2B2 D..DDDD  ?????@?
D_3B2B8:
.byte $40                                         ; 03B2B9 D        @
D_3B2B9:
.byte $00,$00,$00,$C0,$FF,$00,$00                 ; 03B2BA D..DDDD  ???????

  LDA.W EntityXPx,X                              ; 03B2C0 BD 46 0B 
  CMP.B #$1A                                      ; 03B2C3 C9 1A 
  BCC.B B_3B2D6                                   ; 03B2C5 90 0F 
  CMP.B #$E6                                      ; 03B2C7 C9 E6 
  BCS.B B_3B2D6                                   ; 03B2C9 B0 0B 
  LDA.W EntityYPx,X                                   ; 03B2CB BD 9C 0C 
  CMP.B #$28                                      ; 03B2CE C9 28 
  BCC.B B_3B2D6                                   ; 03B2D0 90 04 
  CMP.B #$D4                                      ; 03B2D2 C9 D4 
  BCC.B B_3B2FE                                   ; 03B2D4 90 28 
B_3B2D6:
  DEC.W $06C6                                     ; 03B2D6 CE C6 06 
  STZ.W EntityHeader,X                                   ; 03B2D9 9E D2 06 
  PHX                                             ; 03B2DC DA 
  LDY.W EntityV31,X                                   ; 03B2DD BC A0 14 
  JSL L_AEF1                                      ; 03B2E0 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03B2E4 BD A0 14 
  TAX                                             ; 03B2E7 AA 
  STZ.W StateFlags,X                                   ; 03B2E8 9E 5E 17 
  ASL                                             ; 03B2EB 0A 
  ASL                                             ; 03B2EC 0A 
  TAY                                             ; 03B2ED A8 
  LDA.B #$F0                                      ; 03B2EE A9 F0 
  BCC.B B_3B2F7                                   ; 03B2F0 90 05 

.byte $99,$09,$04,$80,$03                         ; 03B2F3 .....    ?????

B_3B2F7:
  STA.W XexzyTorsoY,Y                             ; 03B2F7 99 09 03 
  PLX                                             ; 03B2FA FA 
  JMP.W AdvanceToNextEntity                                   ; 03B2FB 4C 41 81 
B_3B2FE:
  SEC                                             ; 03B2FE 38 
  LDA.W EntityXPx,X                              ; 03B2FF BD 46 0B 
  SBC.B #$02                                      ; 03B302 E9 02 
  BCS.B B_3B308                                   ; 03B304 B0 02 

.byte $A9,$00                                     ; 03B307 ..       ??

B_3B308:
  STA.W EntityV32,X                                   ; 03B308 9D 16 15 
  CLC                                             ; 03B30B 18 
  LDA.W EntityXPx,X                              ; 03B30C BD 46 0B 
  ADC.B #$02                                      ; 03B30F 69 02 
  BCC.B B_3B315                                   ; 03B311 90 02 

.byte $A9,$FF                                     ; 03B314 ..       ??

B_3B315:
  STA.W EntityV33,X                                   ; 03B315 9D 88 15 
  SEC                                             ; 03B318 38 
  LDA.W EntityYPx,X                                   ; 03B319 BD 9C 0C 
  SBC.B #$02                                      ; 03B31C E9 02 
  BCS.B B_3B322                                   ; 03B31E B0 02 

.byte $A9,$00                                     ; 03B321 ..       ??

B_3B322:
  STA.W EntityV34,X                                   ; 03B322 9D FA 15 
  CLC                                             ; 03B325 18 
  LDA.W EntityYPx,X                                   ; 03B326 BD 9C 0C 
  ADC.B #$02                                      ; 03B329 69 02 
  BCC.B B_3B32F                                   ; 03B32B 90 02 

.byte $A9,$FF                                     ; 03B32E ..       ??

B_3B32F:
  STA.W EntityV35,X                                   ; 03B32F 9D 6C 16 
  LDA.B #$08                                      ; 03B332 A9 08 
  STA.B $1C                                       ; 03B334 85 1C 
  LDA.B #$09                                      ; 03B336 A9 09 
  STA.B $1D                                       ; 03B338 85 1D 
  JSL L_AFC2                                      ; 03B33A 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03B33E 4C 41 81 
  LDA.W EntityXPxSpeed,X                                   ; 03B341 BD 7E 09 
  BMI.B B_3B35A                                   ; 03B344 30 14 
  ORA.W EntityXSubPxSpeed,X                                   ; 03B346 1D 0C 09 
  BEQ.B B_3B369                                   ; 03B349 F0 1E 
  LDA.B #$EE                                      ; 03B34B A9 EE 
  CMP.W EntityXPx,X                              ; 03B34D DD 46 0B 
  BCS.B B_3B369                                   ; 03B350 B0 17 
  STA.W EntityXPx,X                              ; 03B352 9D 46 0B 
  LDY.B #$02                                      ; 03B355 A0 02 
  JMP.W D_3B3D3                                   ; 03B357 4C D3 B3 
B_3B35A:
  LDA.B #$12                                      ; 03B35A A9 12 
  CMP.W EntityXPx,X                              ; 03B35C DD 46 0B 
  BCC.B B_3B369                                   ; 03B35F 90 08 
  STA.W EntityXPx,X                              ; 03B361 9D 46 0B 
  LDY.B #$03                                      ; 03B364 A0 03 
  JMP.W D_3B3D3                                   ; 03B366 4C D3 B3 
B_3B369:
  LDA.W EntityYPxSpeed,X                                   ; 03B369 BD 62 0A 
  BMI.B B_3B382                                   ; 03B36C 30 14 
  ORA.W EntityYSubPxSpeed,X                                   ; 03B36E 1D F0 09 
  BEQ.B B_3B390                                   ; 03B371 F0 1D 
  LDA.B #$DC                                      ; 03B373 A9 DC 
  CMP.W EntityYPx,X                                   ; 03B375 DD 9C 0C 
  BCS.B B_3B390                                   ; 03B378 B0 16 
  STA.W EntityYPx,X                                   ; 03B37A 9D 9C 0C 
  LDY.B #$01                                      ; 03B37D A0 01 
  JMP.W D_3B3D3                                   ; 03B37F 4C D3 B3 
B_3B382:
  LDA.B #$14                                      ; 03B382 A9 14 
  CMP.W EntityYPx,X                                   ; 03B384 DD 9C 0C 
  BCC.B B_3B390                                   ; 03B387 90 07 
  STA.W EntityYPx,X                                   ; 03B389 9D 9C 0C 
  LDY.B #$00                                      ; 03B38C A0 00 
  BRA.B D_3B3D3                                   ; 03B38E 80 43 
B_3B390:
  SEC                                             ; 03B390 38 
  LDA.W EntityXPx,X                              ; 03B391 BD 46 0B 
  SBC.B #$01                                      ; 03B394 E9 01 
  BCS.B B_3B39A                                   ; 03B396 B0 02 

.byte $A9,$00                                     ; 03B399 ..       ??

B_3B39A:
  STA.W EntityV32,X                                   ; 03B39A 9D 16 15 
  CLC                                             ; 03B39D 18 
  LDA.W EntityXPx,X                              ; 03B39E BD 46 0B 
  ADC.B #$01                                      ; 03B3A1 69 01 
  BCC.B B_3B3A7                                   ; 03B3A3 90 02 

.byte $A9,$FF                                     ; 03B3A6 ..       ??

B_3B3A7:
  STA.W EntityV33,X                                   ; 03B3A7 9D 88 15 
  SEC                                             ; 03B3AA 38 
  LDA.W EntityYPx,X                                   ; 03B3AB BD 9C 0C 
  SBC.B #$01                                      ; 03B3AE E9 01 
  BCS.B B_3B3B4                                   ; 03B3B0 B0 02 

.byte $A9,$00                                     ; 03B3B3 ..       ??

B_3B3B4:
  STA.W EntityV34,X                                   ; 03B3B4 9D FA 15 
  CLC                                             ; 03B3B7 18 
  LDA.W EntityYPx,X                                   ; 03B3B8 BD 9C 0C 
  ADC.B #$01                                      ; 03B3BB 69 01 
  BCC.B B_3B3C1                                   ; 03B3BD 90 02 

.byte $A9,$FF                                     ; 03B3C0 ..       ??

B_3B3C1:
  STA.W EntityV35,X                                   ; 03B3C1 9D 6C 16 
  LDA.B #$08                                      ; 03B3C4 A9 08 
  STA.B $1C                                       ; 03B3C6 85 1C 
  LDA.B #$08                                      ; 03B3C8 A9 08 
  STA.B $1D                                       ; 03B3CA 85 1D 
  JSL L_AFC2                                      ; 03B3CC 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03B3D0 4C 41 81 
D_3B3D3:
  LDA.W D_3B40B,Y                                 ; 03B3D3 B9 0B B4 
  STA.W EntityV29,X                                   ; 03B3D6 9D BC 13 
  LDA.B #$32                                      ; 03B3D9 A9 32 
  ORA.W D_3B40F,Y                                 ; 03B3DB 19 0F B4 
  STA.W EntityV30,X                                   ; 03B3DE 9D 2E 14 
  STZ.W EntityXSubPxSpeed,X                                   ; 03B3E1 9E 0C 09 
  STZ.W EntityXPxSpeed,X                                   ; 03B3E4 9E 7E 09 
  STZ.W EntityYSubPxSpeed,X                                   ; 03B3E7 9E F0 09 
  STZ.W EntityYPxSpeed,X                                   ; 03B3EA 9E 62 0A 
  LDA.B #$07                                      ; 03B3ED A9 07 
  STA.W EntityTypeId,X                                   ; 03B3EF 9D 44 07 
  LDA.B #$00                                      ; 03B3F2 A9 00 
  STA.W EntityV3,X                                   ; 03B3F4 9D 28 08 
  LDA.B #$06                                      ; 03B3F7 A9 06 
  STA.W EntityV15,X                                   ; 03B3F9 9D 80 0D 
  LDA.B #$08                                      ; 03B3FC A9 08 
  STA.B $1C                                       ; 03B3FE 85 1C 
  LDA.B #$08                                      ; 03B400 A9 08 
  STA.B $1D                                       ; 03B402 85 1D 
  JSL L_AFC2                                      ; 03B404 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03B408 4C 41 81 

D_3B40B:
.byte $44,$44,$46,$46                             ; 03B40C DDDD     DDFF
D_3B40F:
.byte $01,$81,$01,$41                             ; 03B410 DDDD     ???A

  LDA.W EntityXPxSpeed,X                                   ; 03B413 BD 7E 09 
  BMI.B B_3B42A                                   ; 03B416 30 12 
  ORA.W EntityXSubPxSpeed,X                                   ; 03B418 1D 0C 09 
  BEQ.B B_3B437                                   ; 03B41B F0 1A 
  LDA.B #$EE                                      ; 03B41D A9 EE 
  CMP.W EntityXPx,X                              ; 03B41F DD 46 0B 
  BCS.B B_3B437                                   ; 03B422 B0 13 
  STA.W EntityXPx,X                              ; 03B424 9D 46 0B 
  JMP.W D_3B4A3                                   ; 03B427 4C A3 B4 
B_3B42A:
  LDA.B #$12                                      ; 03B42A A9 12 
  CMP.W EntityXPx,X                              ; 03B42C DD 46 0B 
  BCC.B B_3B437                                   ; 03B42F 90 06 
  STA.W EntityXPx,X                              ; 03B431 9D 46 0B 
  JMP.W D_3B4A3                                   ; 03B434 4C A3 B4 
B_3B437:
  LDA.W EntityYPxSpeed,X                                   ; 03B437 BD 62 0A 
  BMI.B B_3B44E                                   ; 03B43A 30 12 
  ORA.W EntityYSubPxSpeed,X                                   ; 03B43C 1D F0 09 
  BEQ.B B_3B45B                                   ; 03B43F F0 1A 
  LDA.B #$DC                                      ; 03B441 A9 DC 
  CMP.W EntityYPx,X                                   ; 03B443 DD 9C 0C 
  BCS.B B_3B45B                                   ; 03B446 B0 13 

.byte $9D,$9C,$0C,$4C,$A3,$B4                     ; 03B449 ......   ???L??

B_3B44E:
  LDA.B #$20                                      ; 03B44E A9 20 
  CMP.W EntityYPx,X                                   ; 03B450 DD 9C 0C 
  BCC.B B_3B45B                                   ; 03B453 90 06 
  STA.W EntityYPx,X                                   ; 03B455 9D 9C 0C 
  JMP.W D_3B4A3                                   ; 03B458 4C A3 B4 
B_3B45B:
  DEC.W EntityV15,X                                   ; 03B45B DE 80 0D 
  BEQ.B D_3B4A3                                   ; 03B45E F0 43 
  SEC                                             ; 03B460 38 
  LDA.W EntityXPx,X                              ; 03B461 BD 46 0B 
  SBC.B #$01                                      ; 03B464 E9 01 
  BCS.B B_3B46A                                   ; 03B466 B0 02 

.byte $A9,$00                                     ; 03B469 ..       ??

B_3B46A:
  STA.W EntityV32,X                                   ; 03B46A 9D 16 15 
  CLC                                             ; 03B46D 18 
  LDA.W EntityXPx,X                              ; 03B46E BD 46 0B 
  ADC.B #$01                                      ; 03B471 69 01 
  BCC.B B_3B477                                   ; 03B473 90 02 

.byte $A9,$FF                                     ; 03B476 ..       ??

B_3B477:
  STA.W EntityV33,X                                   ; 03B477 9D 88 15 
  SEC                                             ; 03B47A 38 
  LDA.W EntityYPx,X                                   ; 03B47B BD 9C 0C 
  SBC.B #$01                                      ; 03B47E E9 01 
  BCS.B B_3B484                                   ; 03B480 B0 02 

.byte $A9,$00                                     ; 03B483 ..       ??

B_3B484:
  STA.W EntityV34,X                                   ; 03B484 9D FA 15 
  CLC                                             ; 03B487 18 
  LDA.W EntityYPx,X                                   ; 03B488 BD 9C 0C 
  ADC.B #$01                                      ; 03B48B 69 01 
  BCC.B B_3B491                                   ; 03B48D 90 02 

.byte $A9,$FF                                     ; 03B490 ..       ??

B_3B491:
  STA.W EntityV35,X                                   ; 03B491 9D 6C 16 
  LDA.B #$08                                      ; 03B494 A9 08 
  STA.B $1C                                       ; 03B496 85 1C 
  LDA.B #$08                                      ; 03B498 A9 08 
  STA.B $1D                                       ; 03B49A 85 1D 
  JSL L_AFC2                                      ; 03B49C 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03B4A0 4C 41 81 
D_3B4A3:
  LDA.B #$06                                      ; 03B4A3 A9 06 
  STA.W EntityTypeId,X                                   ; 03B4A5 9D 44 07 
  LDA.B #$00                                      ; 03B4A8 A9 00 
  STA.W EntityV3,X                                   ; 03B4AA 9D 28 08 
  LDA.B #$20                                      ; 03B4AD A9 20 
  STA.W EntityV29,X                                   ; 03B4AF 9D BC 13 
  LDA.B #$32                                      ; 03B4B2 A9 32 
  STA.W EntityV30,X                                   ; 03B4B4 9D 2E 14 
  STZ.W EntityXSubPxSpeed,X                                   ; 03B4B7 9E 0C 09 
  STZ.W EntityXPxSpeed,X                                   ; 03B4BA 9E 7E 09 
  STZ.W EntityYSubPxSpeed,X                                   ; 03B4BD 9E F0 09 
  STZ.W EntityYPxSpeed,X                                   ; 03B4C0 9E 62 0A 
  LDA.B #$04                                      ; 03B4C3 A9 04 
  STA.W EntityV28,X                                   ; 03B4C5 9D 4A 13 
  STZ.W EntityV27,X                                   ; 03B4C8 9E D8 12 
  LDA.B #$08                                      ; 03B4CB A9 08 
  STA.B $1C                                       ; 03B4CD 85 1C 
  LDA.B #$08                                      ; 03B4CF A9 08 
  STA.B $1D                                       ; 03B4D1 85 1D 
  JSL L_AFC2                                      ; 03B4D3 22 C2 AF 00 
  JSL AdvanceRNG                                     ; 03B4D7 22 95 CA 0E 
  AND.B #$01                                      ; 03B4DB 29 01 
  BEQ.B B_3B4EE                                   ; 03B4DD F0 0F 
  PHX                                             ; 03B4DF DA 
  REP.B #P_Idx8Bit                                      ; 03B4E0 C2 10 
  LDA.B #$07                                      ; 03B4E2 A9 07 
  LDX.W #$FF06                                    ; 03B4E4 A2 06 FF 
  JSL Audio_F830F                                     ; 03B4E7 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 03B4EB E2 30 
  PLX                                             ; 03B4ED FA 
B_3B4EE:
  JMP.W AdvanceToNextEntity                                   ; 03B4EE 4C 41 81 

ProcessRazorShieldEntity:
  LDY.W $05D0                                     ; 03B4F1 AC D0 05 
  LDA.W $05D3                                     ; 03B4F4 AD D3 05 
  BNE.B B_3B4FE                                   ; 03B4F7 D0 05 
  LDA.W $18A5,Y                                   ; 03B4F9 B9 A5 18 
  BEQ.B B_3B506                                   ; 03B4FC F0 08 
B_3B4FE:
  DEC.W PlayerRazorShieldStatus                                     ; 03B4FE CE D1 05 
  LDA.B #$37                                      ; 03B501 A9 37 
  STA.W EntityTypeId,X                                   ; 03B503 9D 44 07 
B_3B506:
  CLC                                             ; 03B506 18 
  LDA.W EntityXSubPx,X                                   ; 03B507 BD D4 0A 
  ADC.W $18B4,Y                                   ; 03B50A 79 B4 18 
  STA.W EntityXSubPx,X                                   ; 03B50D 9D D4 0A 
  LDA.W EntityXPx,X                              ; 03B510 BD 46 0B 
  ADC.W $18B6,Y                                   ; 03B513 79 B6 18 
  STA.W EntityXPx,X                              ; 03B516 9D 46 0B 
  CLC                                             ; 03B519 18 
  LDA.W EntityYSubPx,X                                   ; 03B51A BD 2A 0C 
  ADC.W $18B8,Y                                   ; 03B51D 79 B8 18 
  STA.W EntityYSubPx,X                                   ; 03B520 9D 2A 0C 
  LDA.W EntityYPx,X                                   ; 03B523 BD 9C 0C 
  ADC.W $18BA,Y                                   ; 03B526 79 BA 18 
  STA.W EntityYPx,X                                   ; 03B529 9D 9C 0C 
  LDA.W EntityV15,X                                   ; 03B52C BD 80 0D 
  ASL                                             ; 03B52F 0A 
  TAY                                             ; 03B530 A8 
  LDA.W D_384EE,Y                                 ; 03B531 B9 EE 84 
  STA.W EntityXSubPxSpeed,X                                   ; 03B534 9D 0C 09 
  LDA.W D_384EF,Y                                 ; 03B537 B9 EF 84 
  STA.W EntityXPxSpeed,X                                   ; 03B53A 9D 7E 09 
  LDA.W D_3856E,Y                                 ; 03B53D B9 6E 85 
  STA.W EntityYSubPxSpeed,X                                   ; 03B540 9D F0 09 
  LDA.W D_3856F,Y                                 ; 03B543 B9 6F 85 
  STA.W EntityYPxSpeed,X                                   ; 03B546 9D 62 0A 
  LDA.W EntityV15,X                                   ; 03B549 BD 80 0D 
  TAY                                             ; 03B54C A8 
  INY                                             ; 03B54D C8 
  CPY.B #$40                                      ; 03B54E C0 40 
  BNE.B B_3B554                                   ; 03B550 D0 02 
  LDY.B #$00                                      ; 03B552 A0 00 
B_3B554:
  TYA                                             ; 03B554 98 
  STA.W EntityV15,X                                   ; 03B555 9D 80 0D 
  LDA.W EntityV15,X                                   ; 03B558 BD 80 0D 
  LSR                                             ; 03B55B 4A 
  LSR                                             ; 03B55C 4A 
  LSR                                             ; 03B55D 4A 
  TAY                                             ; 03B55E A8 
  LDA.W D_3B5A8,Y                                 ; 03B55F B9 A8 B5 
  STA.W EntityV21,X                                   ; 03B562 9D 2C 10 
  SEC                                             ; 03B565 38 
  LDA.W EntityXPx,X                              ; 03B566 BD 46 0B 
  SBC.B #$07                                      ; 03B569 E9 07 
  BCS.B B_3B56F                                   ; 03B56B B0 02 

.byte $A9,$00                                     ; 03B56E ..       ??

B_3B56F:
  STA.W EntityV32,X                                   ; 03B56F 9D 16 15 
  CLC                                             ; 03B572 18 
  LDA.W EntityXPx,X                              ; 03B573 BD 46 0B 
  ADC.B #$07                                      ; 03B576 69 07 
  BCC.B B_3B57C                                   ; 03B578 90 02 

.byte $A9,$FF                                     ; 03B57B ..       ??

B_3B57C:
  STA.W EntityV33,X                                   ; 03B57C 9D 88 15 
  SEC                                             ; 03B57F 38 
  LDA.W EntityYPx,X                                   ; 03B580 BD 9C 0C 
  SBC.B #$07                                      ; 03B583 E9 07 
  BCS.B B_3B589                                   ; 03B585 B0 02 

.byte $A9,$00                                     ; 03B588 ..       ??

B_3B589:
  STA.W EntityV34,X                                   ; 03B589 9D FA 15 
  CLC                                             ; 03B58C 18 
  LDA.W EntityYPx,X                                   ; 03B58D BD 9C 0C 
  ADC.B #$07                                      ; 03B590 69 07 
  BCC.B B_3B596                                   ; 03B592 90 02 

.byte $A9,$FF                                     ; 03B595 ..       ??

B_3B596:
  STA.W EntityV35,X                                   ; 03B596 9D 6C 16 
  LDA.B #$08                                      ; 03B599 A9 08 
  STA.B $1C                                       ; 03B59B 85 1C 
  LDA.B #$09                                      ; 03B59D A9 09 
  STA.B $1D                                       ; 03B59F 85 1D 
  JSL L_AFC2                                      ; 03B5A1 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03B5A5 4C 41 81 








D_3B5A8:
.byte $02,$01,$00,$07,$06,$05,$04,$03             ; 03B5A8 DDDDDDDD ????????

  LDA.W EntityXPxSpeed,X                                   ; 03B5B0 BD 7E 09 
  BMI.B B_3B5C7                                   ; 03B5B3 30 12 
  ORA.W EntityXSubPxSpeed,X                                   ; 03B5B5 1D 0C 09 
  BEQ.B B_3B5D4                                   ; 03B5B8 F0 1A 
  LDA.B #$EE                                      ; 03B5BA A9 EE 
  CMP.W EntityXPx,X                              ; 03B5BC DD 46 0B 
  BCS.B B_3B5D4                                   ; 03B5BF B0 13 
  STA.W EntityXPx,X                              ; 03B5C1 9D 46 0B 
  JMP.W D_3B63A                                   ; 03B5C4 4C 3A B6 
B_3B5C7:
  LDA.B #$12                                      ; 03B5C7 A9 12 
  CMP.W EntityXPx,X                              ; 03B5C9 DD 46 0B 
  BCC.B B_3B5D4                                   ; 03B5CC 90 06 
  STA.W EntityXPx,X                              ; 03B5CE 9D 46 0B 
  JMP.W D_3B63A                                   ; 03B5D1 4C 3A B6 
B_3B5D4:
  LDA.W EntityYPxSpeed,X                                   ; 03B5D4 BD 62 0A 
  BMI.B B_3B5EB                                   ; 03B5D7 30 12 
  ORA.W EntityYSubPxSpeed,X                                   ; 03B5D9 1D F0 09 
  BEQ.B B_3B5F7                                   ; 03B5DC F0 19 
  LDA.B #$DC                                      ; 03B5DE A9 DC 
  CMP.W EntityYPx,X                                   ; 03B5E0 DD 9C 0C 
  BCS.B B_3B5F7                                   ; 03B5E3 B0 12 
  STA.W EntityYPx,X                                   ; 03B5E5 9D 9C 0C 
  JMP.W D_3B63A                                   ; 03B5E8 4C 3A B6 
B_3B5EB:
  LDA.B #$20                                      ; 03B5EB A9 20 
  CMP.W EntityYPx,X                                   ; 03B5ED DD 9C 0C 
  BCC.B B_3B5F7                                   ; 03B5F0 90 05 
  STA.W EntityYPx,X                                   ; 03B5F2 9D 9C 0C 
  BRA.B D_3B63A                                   ; 03B5F5 80 43 
B_3B5F7:
  SEC                                             ; 03B5F7 38 
  LDA.W EntityXPx,X                              ; 03B5F8 BD 46 0B 
  SBC.B #$07                                      ; 03B5FB E9 07 
  BCS.B B_3B601                                   ; 03B5FD B0 02 

.byte $A9,$00                                     ; 03B600 ..       ??

B_3B601:
  STA.W EntityV32,X                                   ; 03B601 9D 16 15 
  CLC                                             ; 03B604 18 
  LDA.W EntityXPx,X                              ; 03B605 BD 46 0B 
  ADC.B #$07                                      ; 03B608 69 07 
  BCC.B B_3B60E                                   ; 03B60A 90 02 

.byte $A9,$FF                                     ; 03B60D ..       ??

B_3B60E:
  STA.W EntityV33,X                                   ; 03B60E 9D 88 15 
  SEC                                             ; 03B611 38 
  LDA.W EntityYPx,X                                   ; 03B612 BD 9C 0C 
  SBC.B #$07                                      ; 03B615 E9 07 
  BCS.B B_3B61B                                   ; 03B617 B0 02 

.byte $A9,$00                                     ; 03B61A ..       ??

B_3B61B:
  STA.W EntityV34,X                                   ; 03B61B 9D FA 15 
  CLC                                             ; 03B61E 18 
  LDA.W EntityYPx,X                                   ; 03B61F BD 9C 0C 
  ADC.B #$07                                      ; 03B622 69 07 
  BCC.B B_3B628                                   ; 03B624 90 02 

.byte $A9,$FF                                     ; 03B627 ..       ??

B_3B628:
  STA.W EntityV35,X                                   ; 03B628 9D 6C 16 
  LDA.B #$08                                      ; 03B62B A9 08 
  STA.B $1C                                       ; 03B62D 85 1C 
  LDA.B #$09                                      ; 03B62F A9 09 
  STA.B $1D                                       ; 03B631 85 1D 
  JSL L_AFC2                                      ; 03B633 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03B637 4C 41 81 










D_3B63A:
  LDA.B #$05                                      ; 03B63A A9 05 
  STA.W EntityTypeId,X                                   ; 03B63C 9D 44 07 
  LDA.B #$00                                      ; 03B63F A9 00 
  STA.W EntityV3,X                                   ; 03B641 9D 28 08 
  LDA.B #$40                                      ; 03B644 A9 40 
  STA.W EntityV29,X                                   ; 03B646 9D BC 13 
  LDA.B #$32                                      ; 03B649 A9 32 
  STA.W EntityV30,X                                   ; 03B64B 9D 2E 14 
  STZ.W EntityXSubPxSpeed,X                                   ; 03B64E 9E 0C 09 
  STZ.W EntityXPxSpeed,X                                   ; 03B651 9E 7E 09 
  STZ.W EntityYSubPxSpeed,X                                   ; 03B654 9E F0 09 
  STZ.W EntityYPxSpeed,X                                   ; 03B657 9E 62 0A 
  LDA.B #$04                                      ; 03B65A A9 04 
  STA.W EntityV28,X                                   ; 03B65C 9D 4A 13 
  STZ.W EntityV27,X                                   ; 03B65F 9E D8 12 
  JMP.W AdvanceToNextEntity                                   ; 03B662 4C 41 81 

.byte $07,$07,$08,$08,$00,$80,$00,$40             ; 03B665 ........ ???????@

  LDY.W PlayerOrbStatus                                     ; 03B66D AC CE 05 
  LDA.W $18A5,Y                                   ; 03B670 B9 A5 18 
  BEQ.B B_3B684                                   ; 03B673 F0 0F 
  LDA.B #$10                                      ; 03B675 A9 10 
  STA.W EntityTypeId,X                                   ; 03B677 9D 44 07 
  LDA.B #$FF                                      ; 03B67A A9 FF 
  STA.W PlayerOrbStatus                                     ; 03B67C 8D CE 05 
  LDA.B #$00                                      ; 03B67F A9 00 
  STA.W EntityV3,X                                   ; 03B681 9D 28 08 
B_3B684:
  CLC                                             ; 03B684 18 
  LDA.W EntityXSubPx,X                                   ; 03B685 BD D4 0A 
  ADC.W $18B4,Y                                   ; 03B688 79 B4 18 
  STA.W EntityXSubPx,X                                   ; 03B68B 9D D4 0A 
  LDA.W EntityXPx,X                              ; 03B68E BD 46 0B 
  ADC.W $18B6,Y                                   ; 03B691 79 B6 18 
  STA.W EntityXPx,X                              ; 03B694 9D 46 0B 
  CLC                                             ; 03B697 18 
  LDA.W EntityYSubPx,X                                   ; 03B698 BD 2A 0C 
  ADC.W $18B8,Y                                   ; 03B69B 79 B8 18 
  STA.W EntityYSubPx,X                                   ; 03B69E 9D 2A 0C 
  LDA.W EntityYPx,X                                   ; 03B6A1 BD 9C 0C 
  ADC.W $18BA,Y                                   ; 03B6A4 79 BA 18 
  STA.W EntityYPx,X                                   ; 03B6A7 9D 9C 0C 
  LDA.W EntityV15,X                                   ; 03B6AA BD 80 0D 
  ASL                                             ; 03B6AD 0A 
  TAY                                             ; 03B6AE A8 
  LDA.W D_3866E,Y                                 ; 03B6AF B9 6E 86 
  STA.W EntityXSubPxSpeed,X                                   ; 03B6B2 9D 0C 09 
  LDA.W D_3866F,Y                                 ; 03B6B5 B9 6F 86 
  STA.W EntityXPxSpeed,X                                   ; 03B6B8 9D 7E 09 
  LDA.W D_386FE,Y                                 ; 03B6BB B9 FE 86 
  STA.W EntityYSubPxSpeed,X                                   ; 03B6BE 9D F0 09 
  LDA.W D_386FF,Y                                 ; 03B6C1 B9 FF 86 
  STA.W EntityYPxSpeed,X                                   ; 03B6C4 9D 62 0A 
  LDA.W EntityV15,X                                   ; 03B6C7 BD 80 0D 
  TAY                                             ; 03B6CA A8 
  INY                                             ; 03B6CB C8 
  CPY.B #$48                                      ; 03B6CC C0 48 
  BNE.B B_3B6D2                                   ; 03B6CE D0 02 
  LDY.B #$00                                      ; 03B6D0 A0 00 
B_3B6D2:
  TYA                                             ; 03B6D2 98 
  STA.W EntityV15,X                                   ; 03B6D3 9D 80 0D 
  SEC                                             ; 03B6D6 38 
  LDA.W EntityXPx,X                              ; 03B6D7 BD 46 0B 
  SBC.B #$03                                      ; 03B6DA E9 03 
  BCS.B B_3B6E0                                   ; 03B6DC B0 02 

.byte $A9,$00                                     ; 03B6DF ..       ??

B_3B6E0:
  STA.W EntityV32,X                                   ; 03B6E0 9D 16 15 
  CLC                                             ; 03B6E3 18 
  LDA.W EntityXPx,X                              ; 03B6E4 BD 46 0B 
  ADC.B #$03                                      ; 03B6E7 69 03 
  BCC.B B_3B6ED                                   ; 03B6E9 90 02 

.byte $A9,$FF                                     ; 03B6EC ..       ??

B_3B6ED:
  STA.W EntityV33,X                                   ; 03B6ED 9D 88 15 
  SEC                                             ; 03B6F0 38 
  LDA.W EntityYPx,X                                   ; 03B6F1 BD 9C 0C 
  SBC.B #$03                                      ; 03B6F4 E9 03 
  BCS.B B_3B6FA                                   ; 03B6F6 B0 02 

.byte $A9,$00                                     ; 03B6F9 ..       ??

B_3B6FA:
  STA.W EntityV34,X                                   ; 03B6FA 9D FA 15 
  CLC                                             ; 03B6FD 18 
  LDA.W EntityYPx,X                                   ; 03B6FE BD 9C 0C 
  ADC.B #$03                                      ; 03B701 69 03 
  BCC.B B_3B707                                   ; 03B703 90 02 

.byte $A9,$FF                                     ; 03B706 ..       ??

B_3B707:
  STA.W EntityV35,X                                   ; 03B707 9D 6C 16 
  LDA.B #$08                                      ; 03B70A A9 08 
  STA.B $1C                                       ; 03B70C 85 1C 
  LDA.B #$09                                      ; 03B70E A9 09 
  STA.B $1D                                       ; 03B710 85 1D 
  JSL L_AFC2                                      ; 03B712 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03B716 4C 41 81 
  DEC.W EntityV28,X                                   ; 03B719 DE 4A 13 
  BNE.B B_3B75A                                   ; 03B71C D0 3C 
  LDA.B #$04                                      ; 03B71E A9 04 
  STA.W EntityV28,X                                   ; 03B720 9D 4A 13 
  LDY.W EntityV27,X                                   ; 03B723 BC D8 12 
  INY                                             ; 03B726 C8 
  CPY.B #$08                                      ; 03B727 C0 08 
  BNE.B B_3B750                                   ; 03B729 D0 25 
  STZ.W EntityHeader,X                                   ; 03B72B 9E D2 06 
  PHX                                             ; 03B72E DA 
  LDY.W EntityV31,X                                   ; 03B72F BC A0 14 
  JSL L_AEF1                                      ; 03B732 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03B736 BD A0 14 
  TAX                                             ; 03B739 AA 
  STZ.W StateFlags,X                                   ; 03B73A 9E 5E 17 
  ASL                                             ; 03B73D 0A 
  ASL                                             ; 03B73E 0A 
  TAY                                             ; 03B73F A8 
  LDA.B #$F0                                      ; 03B740 A9 F0 
  BCC.B B_3B749                                   ; 03B742 90 05 
  STA.W $0409,Y                                   ; 03B744 99 09 04 
  BRA.B B_3B74C                                   ; 03B747 80 03 

B_3B749:
.byte $99,$09,$03                                 ; 03B74A ...      ???

B_3B74C:
  PLX                                             ; 03B74C FA 
  JMP.W AdvanceToNextEntity                                   ; 03B74D 4C 41 81 
B_3B750:
  TYA                                             ; 03B750 98 
  STA.W EntityV27,X                                   ; 03B751 9D D8 12 
  LDA.W D_3B769,Y                                 ; 03B754 B9 69 B7 
  STA.W EntityV29,X                                   ; 03B757 9D BC 13 
B_3B75A:
  LDA.B #$08                                      ; 03B75A A9 08 
  STA.B $1C                                       ; 03B75C 85 1C 
  LDA.B #$08                                      ; 03B75E A9 08 
  STA.B $1D                                       ; 03B760 85 1D 
  JSL L_AFC2                                      ; 03B762 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03B766 4C 41 81 

D_3B769:
.byte $20,$22,$24,$26,$28,$2A,$2C,$2E             ; 03B769 .DDDDDDD  "$&(*,.

  CLC                                             ; 03B771 18 
  LDA.W EntityV21,X                                   ; 03B772 BD 2C 10 
  ADC.W EntityV23,X                                   ; 03B775 7D 10 11 
  STA.W EntityV21,X                                   ; 03B778 9D 2C 10 
  LDA.W EntityV22,X                                   ; 03B77B BD 9E 10 
  ADC.W EntityV24,X                                   ; 03B77E 7D 82 11 
  STA.W EntityV22,X                                   ; 03B781 9D 9E 10 
  CLC                                             ; 03B784 18 
  LDA.W EntityV23,X                                   ; 03B785 BD 10 11 
  ADC.B #$24                                      ; 03B788 69 24 
  STA.W EntityV23,X                                   ; 03B78A 9D 10 11 
  BCC.B B_3B792                                   ; 03B78D 90 03 
  INC.W EntityV24,X                                   ; 03B78F FE 82 11 
B_3B792:
  LDY.W EntityV15,X                                   ; 03B792 BC 80 0D 
  LDY.W EntityV20,X                                   ; 03B795 BC BA 0F 
  LDA.W EntityXPx,Y                              ; 03B798 B9 46 0B 
  STA.W EntityXPx,X                              ; 03B79B 9D 46 0B 
  CLC                                             ; 03B79E 18 
  LDA.W EntityYPx,Y                                   ; 03B79F B9 9C 0C 
  ADC.W EntityV22,X                                   ; 03B7A2 7D 9E 10 
  STA.W EntityYPx,X                                   ; 03B7A5 9D 9C 0C 
  DEC.W EntityV15,X                                   ; 03B7A8 DE 80 0D 
  BNE.B B_3B7D2                                   ; 03B7AB D0 25 
  STZ.W EntityHeader,X                                   ; 03B7AD 9E D2 06 
  PHX                                             ; 03B7B0 DA 
  LDY.W EntityV31,X                                   ; 03B7B1 BC A0 14 
  JSL L_AEF1                                      ; 03B7B4 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03B7B8 BD A0 14 
  TAX                                             ; 03B7BB AA 
  STZ.W StateFlags,X                                   ; 03B7BC 9E 5E 17 
  ASL                                             ; 03B7BF 0A 
  ASL                                             ; 03B7C0 0A 
  TAY                                             ; 03B7C1 A8 
  LDA.B #$F0                                      ; 03B7C2 A9 F0 
  BCC.B B_3B7CB                                   ; 03B7C4 90 05 
  STA.W $0409,Y                                   ; 03B7C6 99 09 04 
  BRA.B B_3B7CE                                   ; 03B7C9 80 03 

B_3B7CB:
.byte $99,$09,$03                                 ; 03B7CC ...      ???

B_3B7CE:
  PLX                                             ; 03B7CE FA 
  JMP.W AdvanceToNextEntity                                   ; 03B7CF 4C 41 81 
B_3B7D2:
  LDY.W EntityV15,X                                   ; 03B7D2 BC 80 0D 
  LDA.W D_3B81E,Y                                 ; 03B7D5 B9 1E B8 
  STA.W EntityV29,X                                   ; 03B7D8 9D BC 13 
  SEC                                             ; 03B7DB 38 
  LDA.W EntityXPx,X                              ; 03B7DC BD 46 0B 
  SBC.B #$01                                      ; 03B7DF E9 01 
  BCS.B B_3B7E5                                   ; 03B7E1 B0 02 

.byte $A9,$00                                     ; 03B7E4 ..       ??

B_3B7E5:
  STA.W EntityV32,X                                   ; 03B7E5 9D 16 15 
  CLC                                             ; 03B7E8 18 
  LDA.W EntityXPx,X                              ; 03B7E9 BD 46 0B 
  ADC.B #$01                                      ; 03B7EC 69 01 
  BCC.B B_3B7F2                                   ; 03B7EE 90 02 

.byte $A9,$FF                                     ; 03B7F1 ..       ??

B_3B7F2:
  STA.W EntityV33,X                                   ; 03B7F2 9D 88 15 
  SEC                                             ; 03B7F5 38 
  LDA.W EntityYPx,X                                   ; 03B7F6 BD 9C 0C 
  SBC.B #$01                                      ; 03B7F9 E9 01 
  BCS.B B_3B7FF                                   ; 03B7FB B0 02 

.byte $A9,$00                                     ; 03B7FE ..       ??

B_3B7FF:
  STA.W EntityV34,X                                   ; 03B7FF 9D FA 15 
  CLC                                             ; 03B802 18 
  LDA.W EntityYPx,X                                   ; 03B803 BD 9C 0C 
  ADC.B #$01                                      ; 03B806 69 01 
  BCC.B B_3B80C                                   ; 03B808 90 02 

.byte $A9,$FF                                     ; 03B80B ..       ??

B_3B80C:
  STA.W EntityV35,X                                   ; 03B80C 9D 6C 16 
  LDA.B #$08                                      ; 03B80F A9 08 
  STA.B $1C                                       ; 03B811 85 1C 
  LDA.B #$08                                      ; 03B813 A9 08 
  STA.B $1D                                       ; 03B815 85 1D 
  JSL L_AFC2                                      ; 03B817 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03B81B 4C 41 81 

D_3B81E:
.byte $60,$60,$60,$60,$60,$62,$62,$62             ; 03B81E .DDDDDDD `````bbb
.byte $62,$62,$64,$64,$64,$64,$64,$66             ; 03B826 DDDDDDDD bbdddddf
.byte $66,$66,$66,$66,$68,$68,$68,$68             ; 03B82E DDDDDDDD ffffhhhh
.byte $68,$66,$66,$66,$66,$66,$64,$64             ; 03B836 DDDDDDDD hfffffdd
.byte $64,$64,$64,$62,$62,$62,$62,$62             ; 03B83E DDDDDDDD dddbbbbb

  LDA.B #$01                                      ; 03B846 A9 01 
  JSR.W L_38195                                   ; 03B848 20 95 81 
  DEC.W EntityV15,X                                   ; 03B84B DE 80 0D 
  BNE.B B_3B8BB                                   ; 03B84E D0 6B 
  LDA.B #$39                                      ; 03B850 A9 39 
  STA.W EntityTypeId,X                                   ; 03B852 9D 44 07 
  LDA.B #$02                                      ; 03B855 A9 02 
  STA.W EntityV3,X                                   ; 03B857 9D 28 08 
  LDA.B #$20                                      ; 03B85A A9 20 
  STA.W EntityV29,X                                   ; 03B85C 9D BC 13 
  LDA.B #$32                                      ; 03B85F A9 32 
  STA.W EntityV30,X                                   ; 03B861 9D 2E 14 
  STZ.W EntityXSubPxSpeed,X                                   ; 03B864 9E 0C 09 
  STZ.W EntityXPxSpeed,X                                   ; 03B867 9E 7E 09 
  STZ.W EntityYSubPxSpeed,X                                   ; 03B86A 9E F0 09 
  STZ.W EntityYPxSpeed,X                                   ; 03B86D 9E 62 0A 
  LDA.B #$04                                      ; 03B870 A9 04 
  STA.W EntityV28,X                                   ; 03B872 9D 4A 13 
  STZ.W EntityV27,X                                   ; 03B875 9E D8 12 
  SEC                                             ; 03B878 38 
  LDA.W EntityXPx,X                              ; 03B879 BD 46 0B 
  SBC.B #$01                                      ; 03B87C E9 01 
  BCS.B B_3B882                                   ; 03B87E B0 02 

.byte $A9,$00                                     ; 03B881 ..       ??

B_3B882:
  STA.W EntityV32,X                                   ; 03B882 9D 16 15 
  CLC                                             ; 03B885 18 
  LDA.W EntityXPx,X                              ; 03B886 BD 46 0B 
  ADC.B #$01                                      ; 03B889 69 01 
  BCC.B B_3B88F                                   ; 03B88B 90 02 

.byte $A9,$FF                                     ; 03B88E ..       ??

B_3B88F:
  STA.W EntityV33,X                                   ; 03B88F 9D 88 15 
  SEC                                             ; 03B892 38 
  LDA.W EntityYPx,X                                   ; 03B893 BD 9C 0C 
  SBC.B #$01                                      ; 03B896 E9 01 
  BCS.B B_3B89C                                   ; 03B898 B0 02 

.byte $A9,$00                                     ; 03B89B ..       ??

B_3B89C:
  STA.W EntityV34,X                                   ; 03B89C 9D FA 15 
  CLC                                             ; 03B89F 18 
  LDA.W EntityYPx,X                                   ; 03B8A0 BD 9C 0C 
  ADC.B #$01                                      ; 03B8A3 69 01 
  BCC.B B_3B8A9                                   ; 03B8A5 90 02 

.byte $A9,$FF                                     ; 03B8A8 ..       ??

B_3B8A9:
  STA.W EntityV35,X                                   ; 03B8A9 9D 6C 16 
  PHX                                             ; 03B8AC DA 
  REP.B #P_Idx8Bit                                      ; 03B8AD C2 10 
  LDA.B #$07                                      ; 03B8AF A9 07 
  LDX.W #$FF06                                    ; 03B8B1 A2 06 FF 
  JSL Audio_F830F                                     ; 03B8B4 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 03B8B8 E2 30 
  PLX                                             ; 03B8BA FA 
B_3B8BB:
  LDA.B #$08                                      ; 03B8BB A9 08 
  STA.B $1C                                       ; 03B8BD 85 1C 
  LDA.B #$08                                      ; 03B8BF A9 08 
  STA.B $1D                                       ; 03B8C1 85 1D 
  JSL L_AFC2                                      ; 03B8C3 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03B8C7 4C 41 81 
  LDA.W $05DF                                     ; 03B8CA AD DF 05 
  BNE.B B_3B90D                                   ; 03B8CD D0 3E 
  DEC.W EntityV28,X                                   ; 03B8CF DE 4A 13 
  BNE.B B_3B8E5                                   ; 03B8D2 D0 11 
  INC.W EntityV27,X                                   ; 03B8D4 FE D8 12 
  LDA.W EntityV27,X                                   ; 03B8D7 BD D8 12 
  CMP.B #$0F                                      ; 03B8DA C9 0F 
  BEQ.B B_3B90D                                   ; 03B8DC F0 2F 
  TAY                                             ; 03B8DE A8 
  LDA.W D_3B961-1,Y                                 ; 03B8DF B9 60 B9 
  STA.W EntityV28,X                                   ; 03B8E2 9D 4A 13 
B_3B8E5:
  LDA.W EntityV27,X                                   ; 03B8E5 BD D8 12 
  AND.B #$01                                      ; 03B8E8 29 01 
  BEQ.B B_3B8F2                                   ; 03B8EA F0 06 
  LDA.B #$F0                                      ; 03B8EC A9 F0 
  STA.B $04                                       ; 03B8EE 85 04 
  BRA.B B_3B8F7                                   ; 03B8F0 80 05 
B_3B8F2:
  LDA.W EntityV20,X                                   ; 03B8F2 BD BA 0F 
  STA.B $04                                       ; 03B8F5 85 04 
B_3B8F7:
  LDA.W EntityV31,X                                   ; 03B8F7 BD A0 14 
  ASL                                             ; 03B8FA 0A 
  ASL                                             ; 03B8FB 0A 
  TAY                                             ; 03B8FC A8 
  LDA.B $04                                       ; 03B8FD A5 04 
  BCC.B B_3B907                                   ; 03B8FF 90 06 
  STA.W $0409,Y                                   ; 03B901 99 09 04 
  JMP.W AdvanceToNextEntity                                   ; 03B904 4C 41 81 

B_3B907:
.byte $99,$09,$03,$4C,$41,$81                     ; 03B908 ......   ???LA?

B_3B90D:
  LDA.W EntityTypeId,X                                   ; 03B90D BD 44 07 
  CMP.B #$3E                                      ; 03B910 C9 3E 
  BEQ.B B_3B920                                   ; 03B912 F0 0C 
  CMP.B #$41                                      ; 03B914 C9 41 
  BEQ.B B_3B920                                   ; 03B916 F0 08 
  CMP.B #$44                                      ; 03B918 C9 44 
  BEQ.B B_3B920                                   ; 03B91A F0 04 
  CMP.B #$45                                      ; 03B91C C9 45 
  BNE.B B_3B930                                   ; 03B91E D0 10 
B_3B920:
  PHX                                             ; 03B920 DA 
  LDX.W $18D1                                     ; 03B921 AE D1 18 
  DEC.W $18C5,X                                   ; 03B924 DE C5 18 
  BNE.B B_3B92F                                   ; 03B927 D0 06 
  STZ.W $18C9,X                                   ; 03B929 9E C9 18 
  STZ.W $18C1,X                                   ; 03B92C 9E C1 18 
B_3B92F:
  PLX                                             ; 03B92F FA 
B_3B930:
  STZ.W EntityHeader,X                                   ; 03B930 9E D2 06 
  PHX                                             ; 03B933 DA 
  LDY.W EntityV31,X                                   ; 03B934 BC A0 14 
  JSL L_AEF1                                      ; 03B937 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03B93B BD A0 14 
  TAX                                             ; 03B93E AA 
  STZ.W StateFlags,X                                   ; 03B93F 9E 5E 17 
  ASL                                             ; 03B942 0A 
  ASL                                             ; 03B943 0A 
  TAY                                             ; 03B944 A8 
  LDA.B #$F0                                      ; 03B945 A9 F0 
  BCC.B B_3B94E                                   ; 03B947 90 05 
  STA.W $0409,Y                                   ; 03B949 99 09 04 
  BRA.B B_3B951                                   ; 03B94C 80 03 

B_3B94E:
.byte $99,$09,$03                                 ; 03B94F ...      ???

B_3B951:
  PLX                                             ; 03B951 FA 
  JSL AdvanceRNG                                     ; 03B952 22 95 CA 0E 
  AND.B #$3F                                      ; 03B956 29 3F 
  CLC                                             ; 03B958 18 
  ADC.B #$40                                      ; 03B959 69 40 
  STA.W DropTimer                   ; 03B95B 8D AE 05 
  JMP.W AdvanceToNextEntity                                   ; 03B95E 4C 41 81 

D_3B961:
.byte $06,$06,$06,$06,$06,$06,$06,$06             ; 03B961 DDDDDDDD ????????
.byte $06,$06,$06,$06,$06,$30                     ; 03B96A DDDDDD   ?????0

  LDA.B #$FF                                      ; 03B96F A9 FF 
  STA.W PrizeTimer                                     ; 03B971 8D AF 05 
  LDA.W $05DF                                     ; 03B974 AD DF 05 
  BNE.B B_3B9B7                                   ; 03B977 D0 3E 
  DEC.W EntityV28,X                                   ; 03B979 DE 4A 13 
  BNE.B B_3B98F                                   ; 03B97C D0 11 
  INC.W EntityV27,X                                   ; 03B97E FE D8 12 
  LDA.W EntityV27,X                                   ; 03B981 BD D8 12 
  CMP.B #$0F                                      ; 03B984 C9 0F 
  BEQ.B B_3B9B7                                   ; 03B986 F0 2F 
  TAY                                             ; 03B988 A8 
  LDA.W D_3B9F6-1,Y                                 ; 03B989 B9 F5 B9 
  STA.W EntityV28,X                                   ; 03B98C 9D 4A 13 
B_3B98F:
  LDA.W EntityV27,X                                   ; 03B98F BD D8 12 
  AND.B #$01                                      ; 03B992 29 01 
  BEQ.B B_3B99C                                   ; 03B994 F0 06 
  LDA.B #$F0                                      ; 03B996 A9 F0 
  STA.B $04                                       ; 03B998 85 04 
  BRA.B B_3B9A1                                   ; 03B99A 80 05 
B_3B99C:
  LDA.W EntityV20,X                                   ; 03B99C BD BA 0F 
  STA.B $04                                       ; 03B99F 85 04 
B_3B9A1:
  LDA.W EntityV31,X                                   ; 03B9A1 BD A0 14 
  ASL                                             ; 03B9A4 0A 
  ASL                                             ; 03B9A5 0A 
  TAY                                             ; 03B9A6 A8 
  LDA.B $04                                       ; 03B9A7 A5 04 
  BCC.B B_3B9B1                                   ; 03B9A9 90 06 
  STA.W $0409,Y                                   ; 03B9AB 99 09 04 
  JMP.W AdvanceToNextEntity                                   ; 03B9AE 4C 41 81 

B_3B9B1:
.byte $99,$09,$03,$4C,$41,$81                     ; 03B9B2 ......   ???LA?

B_3B9B7:
  STZ.W EntityHeader,X                                   ; 03B9B7 9E D2 06 
  PHX                                             ; 03B9BA DA 
  LDY.W EntityV31,X                                   ; 03B9BB BC A0 14 
  JSL L_AEF1                                      ; 03B9BE 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03B9C2 BD A0 14 
  TAX                                             ; 03B9C5 AA 
  STZ.W StateFlags,X                                   ; 03B9C6 9E 5E 17 
  ASL                                             ; 03B9C9 0A 
  ASL                                             ; 03B9CA 0A 
  TAY                                             ; 03B9CB A8 
  LDA.B #$F0                                      ; 03B9CC A9 F0 
  BCC.B B_3B9D5                                   ; 03B9CE 90 05 
  STA.W $0409,Y                                   ; 03B9D0 99 09 04 
  BRA.B B_3B9D8                                   ; 03B9D3 80 03 

B_3B9D5:
.byte $99,$09,$03                                 ; 03B9D6 ...      ???

B_3B9D8:
  PLX                                             ; 03B9D8 FA 
  LDA.W CurrentRound                                     ; 03B9D9 AD AB 05 
  CMP.B #$02                                      ; 03B9DC C9 02 
  BNE.B B_3B9E7                                   ; 03B9DE D0 07 

.byte $AD,$AC,$05,$C9,$15,$F0,$0C                 ; 03B9E1 .......  ???????

B_3B9E7:
  JSL AdvanceRNG                                     ; 03B9E7 22 95 CA 0E 
  AND.B #$3F                                      ; 03B9EB 29 3F 
  CLC                                             ; 03B9ED 18 
  ADC.B #$40                                      ; 03B9EE 69 40 
  STA.W PrizeTimer                                     ; 03B9F0 8D AF 05 
  JMP.W AdvanceToNextEntity                                   ; 03B9F3 4C 41 81 

D_3B9F6:
.byte $06,$06,$06,$06,$06,$06,$06,$06             ; 03B9F6 DDDDDDDD ????????
.byte $06,$06,$06,$06,$06,$30                     ; 03B9FF DDDDDD   ?????0

  LDA.W EntityYPxSpeed,X                                   ; 03BA04 BD 62 0A 
  BMI.B B_3BA15                                   ; 03BA07 30 0C 

.byte $1D,$F0,$09,$F0,$10,$BD,$9C,$0C             ; 03BA09 ........ ????????
.byte $C9,$1B,$B0,$18                             ; 03BA12 ....     ????

B_3BA15:
  LDA.W EntityYPx,X                                   ; 03BA15 BD 9C 0C 
  CMP.B #$1B                                      ; 03BA18 C9 1B 
  BEQ.B B_3BA2D                                   ; 03BA1A F0 11 
  BCC.B B_3BA2D                                   ; 03BA1C 90 0F 
  LDA.B #$08                                      ; 03BA1E A9 08 
  STA.B $1C                                       ; 03BA20 85 1C 
  LDA.B #$08                                      ; 03BA22 A9 08 
  STA.B $1D                                       ; 03BA24 85 1D 
  JSL L_AFC2                                      ; 03BA26 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03BA2A 4C 41 81 
B_3BA2D:
  LDA.W EntityV20,X                                   ; 03BA2D BD BA 0F 
  STA.B $0E                                       ; 03BA30 85 0E 
  LDA.W EntityV21,X                                   ; 03BA32 BD 2C 10 
  BEQ.B B_3BA8C                                   ; 03BA35 F0 55 
  STZ.W EntityHeader,X                                   ; 03BA37 9E D2 06 
  PHX                                             ; 03BA3A DA 
  LDY.W EntityV31,X                                   ; 03BA3B BC A0 14 
  JSL L_AEF1                                      ; 03BA3E 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03BA42 BD A0 14 
  TAX                                             ; 03BA45 AA 
  STZ.W StateFlags,X                                   ; 03BA46 9E 5E 17 
  ASL                                             ; 03BA49 0A 
  ASL                                             ; 03BA4A 0A 
  TAY                                             ; 03BA4B A8 
  LDA.B #$F0                                      ; 03BA4C A9 F0 
  BCC.B B_3BA55                                   ; 03BA4E 90 05 
  STA.W $0409,Y                                   ; 03BA50 99 09 04 
  BRA.B B_3BA58                                   ; 03BA53 80 03 

B_3BA55:
.byte $99,$09,$03                                 ; 03BA56 ...      ???

B_3BA58:
  PLX                                             ; 03BA58 FA 
  JSL AdvanceRNG                                     ; 03BA59 22 95 CA 0E 
  AND.B #$0F                                      ; 03BA5D 29 0F 
  TAY                                             ; 03BA5F A8 
  LDA.W D_3BABE,Y                                 ; 03BA60 B9 BE BA 
  STA.B $0F                                       ; 03BA63 85 0F 
  LDA.W EntityV23,X                                   ; 03BA65 BD 10 11 
  BEQ.B B_3BA79                                   ; 03BA68 F0 0F 
  LDY.B $0E                                       ; 03BA6A A4 0E 
  LDA.B #$B4                                      ; 03BA6C A9 B4 
  STA.W $05B2,Y                                   ; 03BA6E 99 B2 05 
  LDA.B $0F                                       ; 03BA71 A5 0F 
  LDX.B $0E                                       ; 03BA73 A6 0E 
  JSL L_AB65                                      ; 03BA75 22 65 AB 00 
B_3BA79:
  LDA.B $0E                                       ; 03BA79 A5 0E 
  ASL                                             ; 03BA7B 0A 
  ASL                                             ; 03BA7C 0A 
  CLC                                             ; 03BA7D 18 
  ADC.B $0F                                       ; 03BA7E 65 0F 
  TAX                                             ; 03BA80 AA 
  INC.W $05B4,X                                   ; 03BA81 FE B4 05 
  BNE.B B_3BA89                                   ; 03BA84 D0 03 

.byte $DE,$B4,$05                                 ; 03BA87 ...      ???

B_3BA89:
  JMP.W AdvanceToNextEntity                                   ; 03BA89 4C 41 81 
B_3BA8C:
  STZ.W EntityHeader,X                                   ; 03BA8C 9E D2 06 
  PHX                                             ; 03BA8F DA 
  LDY.W EntityV31,X                                   ; 03BA90 BC A0 14 
  JSL L_AEF1                                      ; 03BA93 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03BA97 BD A0 14 
  TAX                                             ; 03BA9A AA 
  STZ.W StateFlags,X                                   ; 03BA9B 9E 5E 17 
  ASL                                             ; 03BA9E 0A 
  ASL                                             ; 03BA9F 0A 
  TAY                                             ; 03BAA0 A8 
  LDA.B #$F0                                      ; 03BAA1 A9 F0 
  BCC.B B_3BAAA                                   ; 03BAA3 90 05 
  STA.W $0409,Y                                   ; 03BAA5 99 09 04 
  BRA.B B_3BAAD                                   ; 03BAA8 80 03 

B_3BAAA:
.byte $99,$09,$03                                 ; 03BAAB ...      ???

B_3BAAD:
  PLX                                             ; 03BAAD FA 
  LDA.B $0E                                       ; 03BAAE A5 0E 
  ASL                                             ; 03BAB0 0A 
  ASL                                             ; 03BAB1 0A 
  TAX                                             ; 03BAB2 AA 
  INC.W $05B7,X                                   ; 03BAB3 FE B7 05 
  BNE.B B_3BABB                                   ; 03BAB6 D0 03 

.byte $DE,$B7,$05                                 ; 03BAB9 ...      ???

B_3BABB:
  JMP.W AdvanceToNextEntity                                   ; 03BABB 4C 41 81 

D_3BABE:
.byte $00,$01,$02,$00,$01,$02,$00,$01             ; 03BABE D..DDDDD ????????
.byte $02,$00,$01,$02,$00,$01,$02,$00             ; 03BAC6 ..D..DDD ????????

  LDA.W EntityYPxSpeed,X                                   ; 03BACE BD 62 0A 
  BMI.B B_3BADF                                   ; 03BAD1 30 0C 

.byte $1D,$F0,$09,$F0,$10,$BD,$9C,$0C             ; 03BAD3 ........ ????????
.byte $C9,$1B,$B0,$18                             ; 03BADC ....     ????

B_3BADF:
  LDA.W EntityYPx,X                                   ; 03BADF BD 9C 0C 
  CMP.B #$1B                                      ; 03BAE2 C9 1B 
  BEQ.B B_3BAF7                                   ; 03BAE4 F0 11 
  BCC.B B_3BAF7                                   ; 03BAE6 90 0F 
  LDA.B #$08                                      ; 03BAE8 A9 08 
  STA.B $1C                                       ; 03BAEA 85 1C 
  LDA.B #$08                                      ; 03BAEC A9 08 
  STA.B $1D                                       ; 03BAEE 85 1D 
  JSL L_AFC2                                      ; 03BAF0 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03BAF4 4C 41 81 
B_3BAF7:
  LDA.W EntityV20,X                                   ; 03BAF7 BD BA 0F 
  PHA                                             ; 03BAFA 48 
  STZ.W EntityHeader,X                                   ; 03BAFB 9E D2 06 
  PHX                                             ; 03BAFE DA 
  LDY.W EntityV31,X                                   ; 03BAFF BC A0 14 
  JSL L_AEF1                                      ; 03BB02 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03BB06 BD A0 14 
  TAX                                             ; 03BB09 AA 
  STZ.W StateFlags,X                                   ; 03BB0A 9E 5E 17 
  ASL                                             ; 03BB0D 0A 
  ASL                                             ; 03BB0E 0A 
  TAY                                             ; 03BB0F A8 
  LDA.B #$F0                                      ; 03BB10 A9 F0 
  BCC.B B_3BB19                                   ; 03BB12 90 05 
  STA.W $0409,Y                                   ; 03BB14 99 09 04 
  BRA.B B_3BB1C                                   ; 03BB17 80 03 

B_3BB19:
.byte $99,$09,$03                                 ; 03BB1A ...      ???

B_3BB1C:
  PLX                                             ; 03BB1C FA 
  PLX                                             ; 03BB1D FA 
  LDA.W PlayerLives,X                         ; 03BB1E BD 31 05 
  CMP.B #$09                                      ; 03BB21 C9 09 
  BCS.B B_3BB31                                   ; 03BB23 B0 0C 
  INC.W PlayerLives,X                         ; 03BB25 FE 31 05 
  LDA.W $05B2,X                                   ; 03BB28 BD B2 05 
  BNE.B B_3BB31                                   ; 03BB2B D0 04 
  JSL L_ACB0                                      ; 03BB2D 22 B0 AC 00 
B_3BB31:
  LDX.W $18D1                                     ; 03BB31 AE D1 18 
  DEC.W $18C5,X                                   ; 03BB34 DE C5 18 
  BNE.B B_3BB3F                                   ; 03BB37 D0 06 
  STZ.W $18C9,X                                   ; 03BB39 9E C9 18 
  STZ.W $18C1,X                                   ; 03BB3C 9E C1 18 
B_3BB3F:
  JSL AdvanceRNG                                     ; 03BB3F 22 95 CA 0E 
  AND.B #$3F                                      ; 03BB43 29 3F 
  CLC                                             ; 03BB45 18 
  ADC.B #$40                                      ; 03BB46 69 40 
  STA.W DropTimer                   ; 03BB48 8D AE 05 
  PHX                                             ; 03BB4B DA 
  REP.B #P_Idx8Bit                                      ; 03BB4C C2 10 
  LDA.B #$07                                      ; 03BB4E A9 07 
  LDX.W #$FF04                                    ; 03BB50 A2 04 FF 
  JSL Audio_F830F                                     ; 03BB53 22 0F 83 0F 
  SEP.B #P_Idx8Bit                                      ; 03BB57 E2 10 
  PLX                                             ; 03BB59 FA 
  JMP.W AdvanceToNextEntity                                   ; 03BB5A 4C 41 81 
  LDA.W EntityYPxSpeed,X                                   ; 03BB5D BD 62 0A 
  BMI.B B_3BB6E                                   ; 03BB60 30 0C 

.byte $1D,$F0,$09,$F0,$10,$BD,$9C,$0C             ; 03BB62 ........ ????????
.byte $C9,$1B,$B0,$18                             ; 03BB6B ....     ????

B_3BB6E:
  LDA.W EntityYPx,X                                   ; 03BB6E BD 9C 0C 
  CMP.B #$1B                                      ; 03BB71 C9 1B 
  BEQ.B B_3BB86                                   ; 03BB73 F0 11 
  BCC.B B_3BB86                                   ; 03BB75 90 0F 
  LDA.B #$08                                      ; 03BB77 A9 08 
  STA.B $1C                                       ; 03BB79 85 1C 
  LDA.B #$08                                      ; 03BB7B A9 08 
  STA.B $1D                                       ; 03BB7D 85 1D 
  JSL L_AFC2                                      ; 03BB7F 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03BB83 4C 41 81 
B_3BB86:
  LDA.W EntityV20,X                                   ; 03BB86 BD BA 0F 
  PHA                                             ; 03BB89 48 
  STZ.W EntityHeader,X                                   ; 03BB8A 9E D2 06 
  PHX                                             ; 03BB8D DA 
  LDY.W EntityV31,X                                   ; 03BB8E BC A0 14 
  JSL L_AEF1                                      ; 03BB91 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03BB95 BD A0 14 
  TAX                                             ; 03BB98 AA 
  STZ.W StateFlags,X                                   ; 03BB99 9E 5E 17 
  ASL                                             ; 03BB9C 0A 
  ASL                                             ; 03BB9D 0A 
  TAY                                             ; 03BB9E A8 
  LDA.B #$F0                                      ; 03BB9F A9 F0 
  BCC.B B_3BBA8                                   ; 03BBA1 90 05 
  STA.W $0409,Y                                   ; 03BBA3 99 09 04 
  BRA.B B_3BBAB                                   ; 03BBA6 80 03 

B_3BBA8:
.byte $99,$09,$03                                 ; 03BBA9 ...      ???

B_3BBAB:
  PLX                                             ; 03BBAB FA 
  PLX                                             ; 03BBAC FA 
  JSL AdvanceRNG                                     ; 03BBAD 22 95 CA 0E 
  AND.B #$3F                                      ; 03BBB1 29 3F 
  CLC                                             ; 03BBB3 18 
  ADC.B #$40                                      ; 03BBB4 69 40 
  STA.W DropTimer                   ; 03BBB6 8D AE 05 
  PHX                                             ; 03BBB9 DA 
  REP.B #P_Idx8Bit                                      ; 03BBBA C2 10 
  LDA.B #$07                                      ; 03BBBC A9 07 
  LDX.W #$FF04                                    ; 03BBBE A2 04 FF 
  JSL Audio_F830F                                     ; 03BBC1 22 0F 83 0F 
  SEP.B #P_Idx8Bit                                      ; 03BBC5 E2 10 
  PLX                                             ; 03BBC7 FA 
  INC.W $05B1                                     ; 03BBC8 EE B1 05 
  JMP.W AdvanceToNextEntity                                   ; 03BBCB 4C 41 81 

.byte $DE,$F2,$0D,$D0,$0A,$A9,$1B,$9D             ; 03BBCE ........ ????????
.byte $44,$07,$A9,$01,$9D,$F2,$0D,$A5             ; 03BBD6 ........ D???????
.byte $CF,$29,$01,$D0,$2A,$BD,$80,$0D             ; 03BBDE ........ ?)??*???
.byte $0A,$A8,$B9,$EE,$85,$9D,$0C,$09             ; 03BBE6 ........ ????????
.byte $B9,$EF,$85,$9D,$7E,$09,$B9,$2E             ; 03BBEE ........ ????~??.
.byte $86,$9D,$F0,$09,$B9,$2F,$86,$9D             ; 03BBF6 ........ ?????/??
.byte $62,$0A,$BD,$80,$0D,$1A,$C9,$20             ; 03BBFE ........ b?????? 
.byte $D0,$02,$A9,$00,$9D,$80,$0D,$38             ; 03BC06 ........ ???????8
.byte $BD,$46,$0B,$E9,$08,$B0,$02,$A9             ; 03BC0E ........ ?F??????
.byte $00,$9D,$16,$15,$18,$BD,$46,$0B             ; 03BC16 ........ ??????F?
.byte $69,$08,$90,$02,$A9,$FF,$9D,$88             ; 03BC1E ........ i???????
.byte $15,$38,$BD,$9C,$0C,$E9,$08,$B0             ; 03BC26 ........ ?8??????
.byte $02,$A9,$00,$9D,$FA,$15,$18,$BD             ; 03BC2E ........ ????????
.byte $9C,$0C,$69,$08,$90,$02,$A9,$FF             ; 03BC36 ........ ??i?????
.byte $9D,$6C,$16,$38,$BD,$46,$0B,$E9             ; 03BC3E ........ ?l?8?F??
.byte $08,$85,$04,$BD,$B8,$0B,$E9,$00             ; 03BC46 ........ ????????
.byte $85,$05,$38,$BD,$9C,$0C,$E9,$07             ; 03BC4E ........ ??8?????
.byte $85,$06,$BD,$0E,$0D,$E9,$00,$85             ; 03BC56 ........ ????????
.byte $07,$22,$42,$AF,$00,$4C,$41,$81             ; 03BC5E ........ ?"B??LA?

  LDA.W $05DF                                     ; 03BC66 AD DF 05 
  BNE.B B_3BCA9                                   ; 03BC69 D0 3E 
  DEC.W EntityV28,X                                   ; 03BC6B DE 4A 13 
  BNE.B B_3BC81                                   ; 03BC6E D0 11 

.byte $FE,$D8,$12,$BD,$D8,$12,$C9,$0F             ; 03BC70 ........ ????????
.byte $F0,$2F,$A8,$B9,$D0,$BC,$9D,$4A             ; 03BC78 ........ ?/?????J
.byte $13                                         ; 03BC81 .        ?

B_3BC81:
  LDA.W EntityV27,X                                   ; 03BC81 BD D8 12 
  AND.B #$01                                      ; 03BC84 29 01 
  BEQ.B B_3BC8E                                   ; 03BC86 F0 06 

.byte $A9,$F0,$85,$04,$80,$05                     ; 03BC89 ......   ??????

B_3BC8E:
  LDA.W EntityV20,X                                   ; 03BC8E BD BA 0F 
  STA.B $04                                       ; 03BC91 85 04 
  LDA.W EntityV31,X                                   ; 03BC93 BD A0 14 
  ASL                                             ; 03BC96 0A 
  ASL                                             ; 03BC97 0A 
  TAY                                             ; 03BC98 A8 
  LDA.B $04                                       ; 03BC99 A5 04 
  BCC.B B_3BCA3                                   ; 03BC9B 90 06 
  STA.W $0409,Y                                   ; 03BC9D 99 09 04 
  JMP.W AdvanceToNextEntity                                   ; 03BCA0 4C 41 81 

B_3BCA3:
.byte $99,$09,$03,$4C,$41,$81                     ; 03BCA4 ......   ???LA?
B_3BCA9:
.byte $CE,$C6,$06,$9E,$D2,$06,$DA,$BC             ; 03BCA9 ........ ????????
.byte $A0,$14,$22,$F1,$AE,$00,$BD,$A0             ; 03BCB1 ........ ??"?????
.byte $14,$AA,$9E,$5E,$17,$0A,$0A,$A8             ; 03BCB9 ........ ???^????
.byte $A9,$F0,$90,$05,$99,$09,$04,$80             ; 03BCC1 ........ ????????
.byte $03,$99,$09,$03,$FA,$4C,$41,$81             ; 03BCC9 ........ ?????LA?
.byte $06,$06,$06,$06,$06,$06,$06,$06             ; 03BCD1 ........ ????????
.byte $06,$06,$06,$06,$06,$30                     ; 03BCDA ......   ?????0

  LDA.W EntityYPxSpeed,X                                   ; 03BCDF BD 62 0A 
  BMI.B B_3BCF0                                   ; 03BCE2 30 0C 

.byte $1D,$F0,$09,$F0,$10,$BD,$9C,$0C             ; 03BCE4 ........ ????????
.byte $C9,$1B,$B0,$18                             ; 03BCED ....     ????

B_3BCF0:
  LDA.W EntityYPx,X                                   ; 03BCF0 BD 9C 0C 
  CMP.B #$1B                                      ; 03BCF3 C9 1B 
  BEQ.B B_3BD08                                   ; 03BCF5 F0 11 
  BCC.B B_3BD08                                   ; 03BCF7 90 0F 
  LDA.B #$08                                      ; 03BCF9 A9 08 
  STA.B $1C                                       ; 03BCFB 85 1C 
  LDA.B #$08                                      ; 03BCFD A9 08 
  STA.B $1D                                       ; 03BCFF 85 1D 
  JSL L_AFC2                                      ; 03BD01 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03BD05 4C 41 81 
B_3BD08:
  DEC.W $06C6                                     ; 03BD08 CE C6 06 
  LDA.W EntityV20,X                                   ; 03BD0B BD BA 0F 
  PHA                                             ; 03BD0E 48 
  STZ.W EntityHeader,X                                   ; 03BD0F 9E D2 06 
  PHX                                             ; 03BD12 DA 
  LDY.W EntityV31,X                                   ; 03BD13 BC A0 14 
  JSL L_AEF1                                      ; 03BD16 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03BD1A BD A0 14 
  TAX                                             ; 03BD1D AA 
  STZ.W StateFlags,X                                   ; 03BD1E 9E 5E 17 
  ASL                                             ; 03BD21 0A 
  ASL                                             ; 03BD22 0A 
  TAY                                             ; 03BD23 A8 
  LDA.B #$F0                                      ; 03BD24 A9 F0 
  BCC.B B_3BD2D                                   ; 03BD26 90 05 
  STA.W $0409,Y                                   ; 03BD28 99 09 04 
  BRA.B B_3BD30                                   ; 03BD2B 80 03 

B_3BD2D:
.byte $99,$09,$03                                 ; 03BD2E ...      ???

B_3BD30:
  PLX                                             ; 03BD30 FA 
  PLX                                             ; 03BD31 FA 
  PHX                                             ; 03BD32 DA 
  REP.B #P_Idx8Bit                                      ; 03BD33 C2 10 
  LDA.B #$07                                      ; 03BD35 A9 07 
  LDX.W #$FF04                                    ; 03BD37 A2 04 FF 
  JSL Audio_F830F                                     ; 03BD3A 22 0F 83 0F 
  SEP.B #P_Idx8Bit                                      ; 03BD3E E2 10 
  PLX                                             ; 03BD40 FA 
  INC.W $05B0                                     ; 03BD41 EE B0 05 
  JSL Wait1Frame                                     ; 03BD44 22 13 CA 0E 
  LDX.W $05B0                                     ; 03BD48 AE B0 05 
  LDA.W D_3BD71-1,X                                 ; 03BD4B BD 70 BD 
  LDY.B #$0F                                      ; 03BD4E A0 0F 
  JSL L_EF407                                     ; 03BD50 22 07 F4 0E 
  LDX.B #$B4                                      ; 03BD54 A2 B4 
  JSL WaitXFrames                                     ; 03BD56 22 72 C9 0E 
  LDA.B #$00                                      ; 03BD5A A9 00 
  LDY.B #$0F                                      ; 03BD5C A0 0F 
  JSL L_EF407                                     ; 03BD5E 22 07 F4 0E 
  LDA.W $05B0                                     ; 03BD62 AD B0 05 
  CMP.B #$05                                      ; 03BD65 C9 05 
  BNE.B B_3BD6E                                   ; 03BD67 D0 05 

.byte $A9,$01,$8D,$2F,$05                         ; 03BD6A .....    ???/?

B_3BD6E:
  JMP.W AdvanceToNextEntity                                   ; 03BD6E 4C 41 81 

D_3BD71:
.byte $06,$07,$08,$09,$0A,$AD,$DE,$05             ; 03BD71 D....... ????????
.byte $F0,$06,$20,$28,$BE,$4C,$41,$81             ; 03BD79 ........ ?? (?LA?
.byte $BC,$BA,$0F,$B9,$A5,$18,$F0,$10             ; 03BD81 ........ ????????
.byte $20,$28,$BE,$CE,$F1,$18,$D0,$05             ; 03BD89 ........  (??????
.byte $A9,$FF,$8D,$D4,$05,$4C,$41,$81             ; 03BD91 ........ ?????LA?
.byte $DE,$80,$0D,$F0,$EB,$BD,$46,$0B             ; 03BD99 ........ ??????F?
.byte $8D,$DF,$1A,$BD,$9C,$0C,$8D,$E1             ; 03BDA1 ........ ????????
.byte $1A,$B9,$46,$0B,$8D,$E0,$1A,$B9             ; 03BDA9 ........ ??F?????
.byte $9C,$0C,$8D,$E2,$1A,$A9,$00,$8D             ; 03BDB1 ........ ????????
.byte $E3,$1A,$A9,$01,$8D,$E4,$1A,$A5             ; 03BDB9 ........ ????????
.byte $D2,$29,$03,$D0,$03,$EE,$E4,$1A             ; 03BDC1 ........ ?)??????
.byte $22,$00,$80,$01,$AD,$E5,$1A,$9D             ; 03BDC9 ........ "???????
.byte $0C,$09,$AD,$E6,$1A,$9D,$7E,$09             ; 03BDD1 ........ ??????~?
.byte $AD,$E7,$1A,$9D,$F0,$09,$AD,$E8             ; 03BDD9 ........ ????????
.byte $1A,$9D,$62,$0A,$38,$BD,$46,$0B             ; 03BDE1 ........ ??b?8?F?
.byte $E9,$04,$B0,$02,$A9,$00,$9D,$16             ; 03BDE9 ........ ????????
.byte $15,$18,$BD,$46,$0B,$69,$04,$90             ; 03BDF1 ........ ???F?i??
.byte $02,$A9,$FF,$9D,$88,$15,$38,$BD             ; 03BDF9 ........ ??????8?
.byte $9C,$0C,$E9,$04,$B0,$02,$A9,$00             ; 03BE01 ........ ????????
.byte $9D,$FA,$15,$18,$BD,$9C,$0C,$69             ; 03BE09 ........ ???????i
.byte $04,$90,$02,$A9,$FF,$9D,$6C,$16             ; 03BE11 ........ ??????l?
.byte $A9,$08,$85,$1C,$A9,$08,$85,$1D             ; 03BE19 ........ ????????
.byte $22,$C2,$AF,$00,$4C,$41,$81,$A9             ; 03BE21 ........ "???LA??
.byte $53,$9D,$44,$07,$A9,$00,$9D,$28             ; 03BE29 ........ S?D????(
.byte $08,$A9,$20,$9D,$BC,$13,$A9,$32             ; 03BE31 ........ ?? ????2
.byte $9D,$2E,$14,$9E,$0C,$09,$9E,$7E             ; 03BE39 ........ ?.?????~
.byte $09,$9E,$F0,$09,$9E,$62,$0A,$A9             ; 03BE41 ........ ?????b??
.byte $04,$9D,$4A,$13,$9E,$D8,$12,$DA             ; 03BE49 ........ ??J?????
.byte $C2,$10,$A9,$07,$A2,$06,$FF,$22             ; 03BE51 ........ ???????"
.byte $0F,$83,$0F,$E2,$10,$FA,$60,$DE             ; 03BE59 ........ ??????`?
.byte $80,$0D,$D0,$24,$A9,$22,$9D,$44             ; 03BE61 ........ ???$?"?D
.byte $07,$22,$95,$CA,$0E,$29,$1F,$69             ; 03BE69 ........ ?"???)?i
.byte $20,$9D,$80,$0D,$22,$95,$CA,$0E             ; 03BE71 ........  ???"???
.byte $29,$03,$69,$02,$9D,$2C,$10,$22             ; 03BE79 ........ )?i??,?"
.byte $95,$CA,$0E,$29,$07,$9D,$9E,$10             ; 03BE81 ........ ???)????
.byte $A9,$08,$20,$95,$81,$BD,$7E,$09             ; 03BE89 ........ ?? ???~?
.byte $10,$10,$C9,$FE,$F0,$02,$B0,$16             ; 03BE91 ........ ????????
.byte $A9,$FF,$9D,$7E,$09,$9E,$0C,$09             ; 03BE99 ........ ???~????
.byte $80,$0C,$C9,$01,$90,$08,$A9,$01             ; 03BEA1 ........ ????????
.byte $9D,$7E,$09,$9E,$0C,$09,$BD,$62             ; 03BEA9 ........ ?~?????b
.byte $0A,$10,$10,$C9,$FE,$F0,$02,$B0             ; 03BEB1 ........ ????????
.byte $16,$A9,$FF,$9D,$62,$0A,$9E,$F0             ; 03BEB9 ........ ????b???
.byte $09,$80,$0C,$C9,$01,$90,$08,$A9             ; 03BEC1 ........ ????????
.byte $01,$9D,$62,$0A,$9E,$F0,$09,$38             ; 03BEC9 ........ ??b????8
.byte $BD,$46,$0B,$E9,$06,$B0,$02,$A9             ; 03BED1 ........ ?F??????
.byte $00,$9D,$16,$15,$18,$BD,$46,$0B             ; 03BED9 ........ ??????F?
.byte $69,$06,$90,$02,$A9,$FF,$9D,$88             ; 03BEE1 ........ i???????
.byte $15,$38,$BD,$9C,$0C,$E9,$06,$B0             ; 03BEE9 ........ ?8??????
.byte $02,$A9,$00,$9D,$FA,$15,$18,$BD             ; 03BEF1 ........ ????????
.byte $9C,$0C,$69,$06,$90,$02,$A9,$FF             ; 03BEF9 ........ ??i?????
.byte $9D,$6C,$16,$38,$BD,$46,$0B,$E9             ; 03BF01 ........ ?l?8?F??
.byte $07,$85,$04,$BD,$B8,$0B,$E9,$00             ; 03BF09 ........ ????????
.byte $85,$05,$38,$BD,$9C,$0C,$E9,$09             ; 03BF11 ........ ??8?????
.byte $85,$06,$BD,$0E,$0D,$E9,$00,$85             ; 03BF19 ........ ????????
.byte $07,$22,$42,$AF,$00,$A5,$D2,$29             ; 03BF21 ........ ?"B????)
.byte $03,$D0,$06,$BD,$B6,$07,$9D,$2E             ; 03BF29 ........ ???????.
.byte $14,$4C,$41,$81,$BD,$BA,$0F,$D0             ; 03BF31 ........ ?LA?????
.byte $11,$AD,$E4,$05,$D0,$0C,$AD,$E3             ; 03BF39 ........ ????????
.byte $05,$C9,$20,$B0,$05,$A9,$20,$8D             ; 03BF41 ........ ?? ??? ?
.byte $E3,$05,$DE,$80,$0D,$F0,$03,$4C             ; 03BF49 ........ ???????L
.byte $41,$81,$A9,$05,$9D,$80,$0D,$BD             ; 03BF51 ........ A???????
.byte $46,$0B,$85,$04,$BD,$9C,$0C,$85             ; 03BF59 ........ F???????
.byte $05,$DE,$F2,$0D,$F0,$22,$22,$F3             ; 03BF61 ........ ?????""?
.byte $80,$03,$F0,$08,$A9,$01,$9D,$80             ; 03BF69 ........ ????????
.byte $0D,$4C,$41,$81,$8A,$AE,$DE,$18             ; 03BF71 ........ ?LA?????
.byte $FE,$C5,$18,$AA,$EE,$C6,$06,$EE             ; 03BF79 ........ ????????
.byte $E7,$18,$20,$A9,$BF,$4C,$41,$81             ; 03BF81 ........ ?? ??LA?
.byte $BD,$BA,$0F,$F0,$0C,$A8,$88,$A9             ; 03BF89 ........ ????????
.byte $00,$99,$36,$06,$A9,$20,$99,$34             ; 03BF91 ........ ??6?? ?4
.byte $06,$20,$A9,$BF,$38,$AD,$E7,$18             ; 03BF99 ........ ? ??8???
.byte $E9,$09,$8D,$E7,$18,$4C,$41,$81             ; 03BFA1 ........ ?????LA?
.byte $22,$94,$80,$03,$A9,$01,$9D,$D2             ; 03BFA9 ........ "???????
.byte $06,$A9,$51,$9D,$44,$07,$A9,$0C             ; 03BFB1 ........ ??Q?D???
.byte $9D,$28,$08,$A9,$C2,$9D,$BC,$13             ; 03BFB9 ........ ?(??????
.byte $AD,$DE,$18,$0A,$09,$28,$9D,$B6             ; 03BFC1 ........ ?????(??
.byte $07,$9D,$2E,$14,$A5,$04,$9D,$46             ; 03BFC9 ........ ??.????F
.byte $0B,$A5,$05,$9D,$9C,$0C,$22,$95             ; 03BFD1 ........ ??????"?
.byte $CA,$0E,$29,$3F,$1A,$9D,$80,$0D             ; 03BFD9 ........ ??)?????
.byte $A9,$B5,$9D,$F0,$09,$A9,$00,$9D             ; 03BFE1 ........ ????????
.byte $62,$0A,$22,$95,$CA,$0E,$29,$01             ; 03BFE9 ........ b?"???)?
.byte $A8,$BD,$2E,$14,$19,$54,$C0,$9D             ; 03BFF1 ........ ??.??T??
.byte $2E,$14,$98,$0A,$A8,$B9,$50,$C0             ; 03BFF9 ........ .?????P?
.byte $9D,$0C,$09,$B9,$51,$C0,$9D,$7E             ; 03C001 ........ ????Q??~
.byte $09,$38,$BD,$46,$0B,$E9,$06,$B0             ; 03C009 ........ ?8?F????
.byte $02,$A9,$00,$9D,$16,$15,$18,$BD             ; 03C011 ........ ????????
.byte $46,$0B,$69,$06,$90,$02,$A9,$FF             ; 03C019 ........ F?i?????
.byte $9D,$88,$15,$38,$BD,$9C,$0C,$E9             ; 03C021 ........ ???8????
.byte $06,$B0,$02,$A9,$00,$9D,$FA,$15             ; 03C029 ........ ????????
.byte $18,$BD,$9C,$0C,$69,$06,$90,$02             ; 03C031 ........ ????i???
.byte $A9,$FF,$9D,$6C,$16,$22,$BC,$AE             ; 03C039 ........ ???l?"??
.byte $00,$98,$9D,$A0,$14,$A9,$01,$99             ; 03C041 ........ ????????
.byte $5E,$17,$22,$F1,$AE,$00,$60,$B5             ; 03C049 ........ ^?"???`?
.byte $00,$4B,$FF,$00,$40,$38,$BD,$46             ; 03C051 ........ ?K??@8?F
.byte $0B,$E9,$06,$B0,$02,$A9,$00,$9D             ; 03C059 ........ ????????
.byte $16,$15,$18,$BD,$46,$0B,$69,$06             ; 03C061 ........ ????F?i?
.byte $90,$02,$A9,$FF,$9D,$88,$15,$38             ; 03C069 ........ ???????8
.byte $BD,$9C,$0C,$E9,$08,$B0,$02,$A9             ; 03C071 ........ ????????
.byte $00,$9D,$FA,$15,$18,$BD,$9C,$0C             ; 03C079 ........ ????????
.byte $69,$08,$90,$02,$A9,$FF,$9D,$6C             ; 03C081 ........ i??????l
.byte $16,$DE,$80,$0D,$D0,$2C,$9E,$7E             ; 03C089 ........ ?????,?~
.byte $09,$9E,$0C,$09,$A9,$E0,$9D,$F0             ; 03C091 ........ ????????
.byte $09,$A9,$00,$9D,$62,$0A,$A9,$52             ; 03C099 ........ ????b??R
.byte $9D,$44,$07,$A9,$C0,$9D,$BC,$13             ; 03C0A1 ........ ?D??????
.byte $22,$95,$CA,$0E,$29,$01,$A8,$BD             ; 03C0A9 ........ "???)???
.byte $2E,$14,$29,$BF,$19,$CA,$C0,$9D             ; 03C0B1 ........ .?)?????
.byte $2E,$14,$A9,$08,$85,$1C,$A9,$09             ; 03C0B9 ........ .???????
.byte $85,$1D,$22,$C2,$AF,$00,$4C,$41             ; 03C0C1 ........ ??"???LA
.byte $81,$00,$40,$BD,$9C,$0C,$C9,$E4             ; 03C0C9 ........ ??@?????
.byte $90,$3B,$CE,$E7,$18,$CE,$C6,$06             ; 03C0D1 ........ ?;??????
.byte $DA,$AE,$DE,$18,$DE,$C5,$18,$D0             ; 03C0D9 ........ ????????
.byte $06,$9E,$C9,$18,$9E,$C1,$18,$FA             ; 03C0E1 ........ ????????
.byte $9E,$D2,$06,$DA,$BC,$A0,$14,$22             ; 03C0E9 ........ ???????"
.byte $F1,$AE,$00,$BD,$A0,$14,$AA,$9E             ; 03C0F1 ........ ????????
.byte $5E,$17,$0A,$0A,$A8,$A9,$F0,$90             ; 03C0F9 ........ ^???????
.byte $05,$99,$09,$04,$80,$03,$99,$09             ; 03C101 ........ ????????
.byte $03,$FA,$4C,$41,$81,$38,$BD,$46             ; 03C109 ........ ??LA?8?F
.byte $0B,$E9,$05,$B0,$02,$A9,$00,$9D             ; 03C111 ........ ????????
.byte $16,$15,$18,$BD,$46,$0B,$69,$05             ; 03C119 ........ ????F?i?
.byte $90,$02,$A9,$FF,$9D,$88,$15,$38             ; 03C121 ........ ???????8
.byte $BD,$9C,$0C,$E9,$08,$B0,$02,$A9             ; 03C129 ........ ????????
.byte $00,$9D,$FA,$15,$18,$BD,$9C,$0C             ; 03C131 ........ ????????
.byte $69,$08,$90,$02,$A9,$FF,$9D,$6C             ; 03C139 ........ i??????l
.byte $16,$A9,$08,$85,$1C,$A9,$09,$85             ; 03C141 ........ ????????
.byte $1D,$22,$C2,$AF,$00,$4C,$41,$81             ; 03C149 ........ ?"???LA?
.byte $22,$4E,$F7,$0C,$4C,$41,$81                 ; 03C152 .......  "N??LA?

  LDA.B #$08                                      ; 03C158 A9 08 
  JSR.W L_38195                                   ; 03C15A 20 95 81 
  LDY.W EntityV20,X                                   ; 03C15D BC BA 0F 
  LDA.W EntityXPx,X                              ; 03C160 BD 46 0B 
  CMP.W EntityXPx,Y                              ; 03C163 D9 46 0B 
  BCS.B B_3C179                                   ; 03C166 B0 11 
  CLC                                             ; 03C168 18 
  LDA.W EntityXSubPxSpeed,X                                   ; 03C169 BD 0C 09 
  ADC.B #$02                                      ; 03C16C 69 02 
  STA.W EntityXSubPxSpeed,X                                   ; 03C16E 9D 0C 09 
  BCC.B B_3C187                                   ; 03C171 90 14 
  INC.W EntityXPxSpeed,X                                   ; 03C173 FE 7E 09 
  JMP.W B_3C187                                   ; 03C176 4C 87 C1 
B_3C179:
  SEC                                             ; 03C179 38 
  LDA.W EntityXSubPxSpeed,X                                   ; 03C17A BD 0C 09 
  SBC.B #$02                                      ; 03C17D E9 02 
  STA.W EntityXSubPxSpeed,X                                   ; 03C17F 9D 0C 09 
  BCS.B B_3C187                                   ; 03C182 B0 03 
  DEC.W EntityXPxSpeed,X                                   ; 03C184 DE 7E 09 
B_3C187:
  LDA.W EntityYPx,X                                   ; 03C187 BD 9C 0C 
  CMP.W EntityYPx,Y                                   ; 03C18A D9 9C 0C 
  BCS.B B_3C1A0                                   ; 03C18D B0 11 
  CLC                                             ; 03C18F 18 
  LDA.W EntityYSubPxSpeed,X                                   ; 03C190 BD F0 09 
  ADC.B #$02                                      ; 03C193 69 02 
  STA.W EntityYSubPxSpeed,X                                   ; 03C195 9D F0 09 
  BCC.B B_3C1AE                                   ; 03C198 90 14 

.byte $FE,$62,$0A,$4C,$AE,$C1                     ; 03C19B ......   ?b?L??

B_3C1A0:
  SEC                                             ; 03C1A0 38 
  LDA.W EntityYSubPxSpeed,X                                   ; 03C1A1 BD F0 09 
  SBC.B #$02                                      ; 03C1A4 E9 02 
  STA.W EntityYSubPxSpeed,X                                   ; 03C1A6 9D F0 09 
  BCS.B B_3C1AE                                   ; 03C1A9 B0 03 
  DEC.W EntityYPxSpeed,X                                   ; 03C1AB DE 62 0A 
B_3C1AE:
  LDA.W EntityXPxSpeed,X                                   ; 03C1AE BD 7E 09 
  BPL.B B_3C1C3                                   ; 03C1B1 10 10 
  CMP.B #$FE                                      ; 03C1B3 C9 FE 
  BEQ.B B_3C1B9                                   ; 03C1B5 F0 02 
  BCS.B B_3C1CF                                   ; 03C1B7 B0 16 

B_3C1B9:
.byte $A9,$FF,$9D,$7E,$09,$9E,$0C,$09             ; 03C1B9 ........ ???~????
.byte $80,$0C                                     ; 03C1C2 ..       ??

B_3C1C3:
  CMP.B #$01                                      ; 03C1C3 C9 01 
  BCC.B B_3C1CF                                   ; 03C1C5 90 08 

.byte $A9,$01,$9D,$7E,$09,$9E,$0C,$09             ; 03C1C7 ........ ???~????

B_3C1CF:
  LDA.W EntityYPxSpeed,X                                   ; 03C1CF BD 62 0A 
  BPL.B B_3C1E4                                   ; 03C1D2 10 10 
  CMP.B #$FE                                      ; 03C1D4 C9 FE 
  BEQ.B B_3C1DA                                   ; 03C1D6 F0 02 

.byte $B0,$16                                     ; 03C1D9 ..       ??

B_3C1DA:
  LDA.B #$FF                                      ; 03C1DA A9 FF 
  STA.W EntityYPxSpeed,X                                   ; 03C1DC 9D 62 0A 
  STZ.W EntityYSubPxSpeed,X                                   ; 03C1DF 9E F0 09 
  BRA.B B_3C1F0                                   ; 03C1E2 80 0C 
B_3C1E4:
  CMP.B #$01                                      ; 03C1E4 C9 01 
  BCC.B B_3C1F0                                   ; 03C1E6 90 08 
  LDA.B #$01                                      ; 03C1E8 A9 01 
  STA.W EntityYPxSpeed,X                                   ; 03C1EA 9D 62 0A 
  STZ.W EntityYSubPxSpeed,X                                   ; 03C1ED 9E F0 09 
B_3C1F0:
  SEC                                             ; 03C1F0 38 
  LDA.W EntityXPx,X                              ; 03C1F1 BD 46 0B 
  SBC.B #$08                                      ; 03C1F4 E9 08 
  BCS.B B_3C1FA                                   ; 03C1F6 B0 02 

.byte $A9,$00                                     ; 03C1F9 ..       ??

B_3C1FA:
  STA.W EntityV32,X                                   ; 03C1FA 9D 16 15 
  CLC                                             ; 03C1FD 18 
  LDA.W EntityXPx,X                              ; 03C1FE BD 46 0B 
  ADC.B #$08                                      ; 03C201 69 08 
  BCC.B B_3C207                                   ; 03C203 90 02 

.byte $A9,$FF                                     ; 03C206 ..       ??

B_3C207:
  STA.W EntityV33,X                                   ; 03C207 9D 88 15 
  SEC                                             ; 03C20A 38 
  LDA.W EntityYPx,X                                   ; 03C20B BD 9C 0C 
  SBC.B #$08                                      ; 03C20E E9 08 
  BCS.B B_3C214                                   ; 03C210 B0 02 
  LDA.B #$00                                      ; 03C212 A9 00 
B_3C214:
  STA.W EntityV34,X                                   ; 03C214 9D FA 15 
  CLC                                             ; 03C217 18 
  LDA.W EntityYPx,X                                   ; 03C218 BD 9C 0C 
  ADC.B #$08                                      ; 03C21B 69 08 
  BCC.B B_3C221                                   ; 03C21D 90 02 

.byte $A9,$FF                                     ; 03C220 ..       ??

B_3C221:
  STA.W EntityV35,X                                   ; 03C221 9D 6C 16 
  LDA.B #$08                                      ; 03C224 A9 08 
  STA.B $1C                                       ; 03C226 85 1C 
  LDA.B #$09                                      ; 03C228 A9 09 
  STA.B $1D                                       ; 03C22A 85 1D 
  JSL L_AFC2                                      ; 03C22C 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03C230 4C 41 81 
  LDA.B #$04                                      ; 03C233 A9 04 
  JSR.W L_38195                                   ; 03C235 20 95 81 
  LDA.W EntityXPxSpeed,X                                   ; 03C238 BD 7E 09 
  BPL.B B_3C24D                                   ; 03C23B 10 10 
  CMP.B #$FD                                      ; 03C23D C9 FD 
  BEQ.B B_3C243                                   ; 03C23F F0 02 
  BCS.B B_3C259                                   ; 03C241 B0 16 

B_3C243:
.byte $A9,$FE,$9D,$7E,$09,$9E,$0C,$09             ; 03C243 ........ ???~????
.byte $80,$0C                                     ; 03C24C ..       ??

B_3C24D:
  CMP.B #$02                                      ; 03C24D C9 02 
  BCC.B B_3C259                                   ; 03C24F 90 08 

.byte $A9,$02,$9D,$7E,$09,$9E,$0C,$09             ; 03C251 ........ ???~????

B_3C259:
  LDA.W EntityYPxSpeed,X                                   ; 03C259 BD 62 0A 
  BPL.B B_3C26E                                   ; 03C25C 10 10 
  CMP.B #$FD                                      ; 03C25E C9 FD 
  BEQ.B B_3C264                                   ; 03C260 F0 02 
  BCS.B B_3C27A                                   ; 03C262 B0 16 

B_3C264:
.byte $A9,$FE,$9D,$62,$0A,$9E,$F0,$09             ; 03C264 ........ ???b????
.byte $80,$0C                                     ; 03C26D ..       ??

B_3C26E:
  CMP.B #$02                                      ; 03C26E C9 02 
  BCC.B B_3C27A                                   ; 03C270 90 08 
  LDA.B #$02                                      ; 03C272 A9 02 
  STA.W EntityYPxSpeed,X                                   ; 03C274 9D 62 0A 
  STZ.W EntityYSubPxSpeed,X                                   ; 03C277 9E F0 09 
B_3C27A:
  SEC                                             ; 03C27A 38 
  LDA.W EntityXPx,X                              ; 03C27B BD 46 0B 
  SBC.B #$04                                      ; 03C27E E9 04 
  BCS.B B_3C284                                   ; 03C280 B0 02 

.byte $A9,$00                                     ; 03C283 ..       ??

B_3C284:
  STA.W EntityV32,X                                   ; 03C284 9D 16 15 
  CLC                                             ; 03C287 18 
  LDA.W EntityXPx,X                              ; 03C288 BD 46 0B 
  ADC.B #$04                                      ; 03C28B 69 04 
  BCC.B B_3C291                                   ; 03C28D 90 02 

.byte $A9,$FF                                     ; 03C290 ..       ??

B_3C291:
  STA.W EntityV33,X                                   ; 03C291 9D 88 15 
  SEC                                             ; 03C294 38 
  LDA.W EntityYPx,X                                   ; 03C295 BD 9C 0C 
  SBC.B #$04                                      ; 03C298 E9 04 
  BCS.B B_3C29E                                   ; 03C29A B0 02 

.byte $A9,$00                                     ; 03C29D ..       ??

B_3C29E:
  STA.W EntityV34,X                                   ; 03C29E 9D FA 15 
  CLC                                             ; 03C2A1 18 
  LDA.W EntityYPx,X                                   ; 03C2A2 BD 9C 0C 
  ADC.B #$04                                      ; 03C2A5 69 04 
  BCC.B B_3C2AB                                   ; 03C2A7 90 02 

.byte $A9,$FF                                     ; 03C2AA ..       ??

B_3C2AB:
  STA.W EntityV35,X                                   ; 03C2AB 9D 6C 16 
  DEC.W EntityV15,X                                   ; 03C2AE DE 80 0D 
  BNE.B B_3C2D7                                   ; 03C2B1 D0 24 
  JSL AdvanceRNG                                     ; 03C2B3 22 95 CA 0E 
  AND.B #$1F                                      ; 03C2B7 29 1F 
  INC A
  STA.W EntityV15,X                                   ; 03C2BA 9D 80 0D 
  JSL AdvanceRNG                                     ; 03C2BD 22 95 CA 0E 
  AND.B #$07                                      ; 03C2C1 29 07 
  TAY                                             ; 03C2C3 A8 
  LDA.W D_3C365,Y                                 ; 03C2C4 B9 65 C3 
  STA.W EntityV21,X                                   ; 03C2C7 9D 2C 10 
  TYA                                             ; 03C2CA 98 
  CLC                                             ; 03C2CB 18 
  ADC.B #$04                                      ; 03C2CC 69 04 
  AND.B #$07                                      ; 03C2CE 29 07 
  TAY                                             ; 03C2D0 A8 
  LDA.W D_3C365,Y                                 ; 03C2D1 B9 65 C3 
  STA.W EntityV22,X                                   ; 03C2D4 9D 9E 10 
B_3C2D7:
  LDA.W EntityV21,X                                   ; 03C2D7 BD 2C 10 
  STA.B $04                                       ; 03C2DA 85 04 
  LDA.W EntityV22,X                                   ; 03C2DC BD 9E 10 
  STA.B $05                                       ; 03C2DF 85 05 
  LDY.W EntityV20,X                                   ; 03C2E1 BC BA 0F 
  LDA.W EntityXPx,Y                              ; 03C2E4 B9 46 0B 
  PHA                                             ; 03C2E7 48 
  CLC                                             ; 03C2E8 18 
  ADC.B #$0C                                      ; 03C2E9 69 0C 
  STA.B $07                                       ; 03C2EB 85 07 
  PLA                                             ; 03C2ED 68 
  SEC                                             ; 03C2EE 38 
  SBC.B #$0C                                      ; 03C2EF E9 0C 
  STA.B $06                                       ; 03C2F1 85 06 
  LDA.W EntityYPx,Y                                   ; 03C2F3 B9 9C 0C 
  PHA                                             ; 03C2F6 48 
  CLC                                             ; 03C2F7 18 
  ADC.B #$0C                                      ; 03C2F8 69 0C 
  STA.B $09                                       ; 03C2FA 85 09 
  PLA                                             ; 03C2FC 68 
  SEC                                             ; 03C2FD 38 
  SBC.B #$0C                                      ; 03C2FE E9 0C 
  STA.B $08                                       ; 03C300 85 08 
  LDA.W EntityXPx,X                              ; 03C302 BD 46 0B 
  CMP.B $07                                       ; 03C305 C5 07 
  BCS.B B_3C31E                                   ; 03C307 B0 15 
  CMP.B $06                                       ; 03C309 C5 06 
  BCS.B B_3C32C                                   ; 03C30B B0 1F 
  CLC                                             ; 03C30D 18 
  LDA.W EntityXSubPxSpeed,X                                   ; 03C30E BD 0C 09 
  ADC.B $04                                       ; 03C311 65 04 
  STA.W EntityXSubPxSpeed,X                                   ; 03C313 9D 0C 09 
  BCC.B B_3C32C                                   ; 03C316 90 14 
  INC.W EntityXPxSpeed,X                                   ; 03C318 FE 7E 09 
  JMP.W B_3C32C                                   ; 03C31B 4C 2C C3 
B_3C31E:
  SEC                                             ; 03C31E 38 
  LDA.W EntityXSubPxSpeed,X                                   ; 03C31F BD 0C 09 
  SBC.B $04                                       ; 03C322 E5 04 
  STA.W EntityXSubPxSpeed,X                                   ; 03C324 9D 0C 09 
  BCS.B B_3C32C                                   ; 03C327 B0 03 
  DEC.W EntityXPxSpeed,X                                   ; 03C329 DE 7E 09 
B_3C32C:
  LDA.W EntityYPx,X                                   ; 03C32C BD 9C 0C 
  CMP.B $09                                       ; 03C32F C5 09 
  BCS.B B_3C348                                   ; 03C331 B0 15 
  CMP.B $08                                       ; 03C333 C5 08 
  BCS.B B_3C356                                   ; 03C335 B0 1F 
  CLC                                             ; 03C337 18 
  LDA.W EntityYSubPxSpeed,X                                   ; 03C338 BD F0 09 
  ADC.B $05                                       ; 03C33B 65 05 
  STA.W EntityYSubPxSpeed,X                                   ; 03C33D 9D F0 09 
  BCC.B B_3C356                                   ; 03C340 90 14 
  INC.W EntityYPxSpeed,X                                   ; 03C342 FE 62 0A 
  JMP.W B_3C356                                   ; 03C345 4C 56 C3 
B_3C348:
  SEC                                             ; 03C348 38 
  LDA.W EntityYSubPxSpeed,X                                   ; 03C349 BD F0 09 
  SBC.B $05                                       ; 03C34C E5 05 
  STA.W EntityYSubPxSpeed,X                                   ; 03C34E 9D F0 09 
  BCS.B B_3C356                                   ; 03C351 B0 03 
  DEC.W EntityYPxSpeed,X                                   ; 03C353 DE 62 0A 
B_3C356:
  LDA.B #$08                                      ; 03C356 A9 08 
  STA.B $1C                                       ; 03C358 85 1C 
  LDA.B #$09                                      ; 03C35A A9 09 
  STA.B $1D                                       ; 03C35C 85 1D 
  JSL L_AFC2                                      ; 03C35E 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03C362 4C 41 81 

D_3C365:
.byte $0D,$0E,$0F,$10,$12,$14,$16,$18             ; 03C365 DDDDDDDD ????????

  DEC.W EntityV15,X                                   ; 03C36D DE 80 0D 
  BEQ.B B_3C375                                   ; 03C370 F0 03 
  JMP.W D_3C3CE                                   ; 03C372 4C CE C3 
B_3C375:
  DEC.W $06C6                                     ; 03C375 CE C6 06 
  PHX                                             ; 03C378 DA 
  LDX.W $18DF                                     ; 03C379 AE DF 18 
  DEC.W $18C5,X                                   ; 03C37C DE C5 18 
  BNE.B B_3C387                                   ; 03C37F D0 06 
  STZ.W $18C9,X                                   ; 03C381 9E C9 18 
  STZ.W $18C1,X                                   ; 03C384 9E C1 18 
B_3C387:
  PLX                                             ; 03C387 FA 
  LDA.B #$08                                      ; 03C388 A9 08 
  STA.W EntityTypeId,X                                   ; 03C38A 9D 44 07 
  LDA.B #$00                                      ; 03C38D A9 00 
  STA.W EntityV3,X                                   ; 03C38F 9D 28 08 
  LDA.B #$40                                      ; 03C392 A9 40 
  STA.W EntityV29,X                                   ; 03C394 9D BC 13 
  LDA.B #$32                                      ; 03C397 A9 32 
  STA.W EntityV30,X                                   ; 03C399 9D 2E 14 
  STZ.W EntityXSubPxSpeed,X                                   ; 03C39C 9E 0C 09 
  STZ.W EntityXPxSpeed,X                                   ; 03C39F 9E 7E 09 
  STZ.W EntityYSubPxSpeed,X                                   ; 03C3A2 9E F0 09 
  STZ.W EntityYPxSpeed,X                                   ; 03C3A5 9E 62 0A 
  LDA.B #$04                                      ; 03C3A8 A9 04 
  STA.W EntityV28,X                                   ; 03C3AA 9D 4A 13 
  STZ.W EntityV27,X                                   ; 03C3AD 9E D8 12 
  LDA.B #$08                                      ; 03C3B0 A9 08 
  STA.B $1C                                       ; 03C3B2 85 1C 
  LDA.B #$08                                      ; 03C3B4 A9 08 
  STA.B $1D                                       ; 03C3B6 85 1D 
  JSL L_AFC2                                      ; 03C3B8 22 C2 AF 00 
  PHX                                             ; 03C3BC DA 
  REP.B #P_Idx8Bit                                      ; 03C3BD C2 10 
  LDA.B #$07                                      ; 03C3BF A9 07 
  LDX.W #$FF06                                    ; 03C3C1 A2 06 FF 
  JSL Audio_F830F                                     ; 03C3C4 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 03C3C8 E2 30 
  PLX                                             ; 03C3CA FA 
  JMP.W AdvanceToNextEntity                                   ; 03C3CB 4C 41 81 
D_3C3CE:
  LDA.B #$04                                      ; 03C3CE A9 04 
  JSR.W L_38195                                   ; 03C3D0 20 95 81 
  SEC                                             ; 03C3D3 38 
  LDA.W EntityXPx,X                              ; 03C3D4 BD 46 0B 
  SBC.B #$04                                      ; 03C3D7 E9 04 
  BCS.B B_3C3DD                                   ; 03C3D9 B0 02 

.byte $A9,$00                                     ; 03C3DC ..       ??

B_3C3DD:
  STA.W EntityV32,X                                   ; 03C3DD 9D 16 15 
  CLC                                             ; 03C3E0 18 
  LDA.W EntityXPx,X                              ; 03C3E1 BD 46 0B 
  ADC.B #$04                                      ; 03C3E4 69 04 
  BCC.B B_3C3EA                                   ; 03C3E6 90 02 

.byte $A9,$FF                                     ; 03C3E9 ..       ??

B_3C3EA:
  STA.W EntityV33,X                                   ; 03C3EA 9D 88 15 
  SEC                                             ; 03C3ED 38 
  LDA.W EntityYPx,X                                   ; 03C3EE BD 9C 0C 
  SBC.B #$04                                      ; 03C3F1 E9 04 
  BCS.B B_3C3F7                                   ; 03C3F3 B0 02 

.byte $A9,$00                                     ; 03C3F6 ..       ??

B_3C3F7:
  STA.W EntityV34,X                                   ; 03C3F7 9D FA 15 
  CLC                                             ; 03C3FA 18 
  LDA.W EntityYPx,X                                   ; 03C3FB BD 9C 0C 
  ADC.B #$04                                      ; 03C3FE 69 04 
  BCC.B B_3C404                                   ; 03C400 90 02 

.byte $A9,$FF                                     ; 03C403 ..       ??

B_3C404:
  STA.W EntityV35,X                                   ; 03C404 9D 6C 16 
  LDA.B #$08                                      ; 03C407 A9 08 
  STA.B $1C                                       ; 03C409 85 1C 
  LDA.B #$09                                      ; 03C40B A9 09 
  STA.B $1D                                       ; 03C40D 85 1D 
  JSL L_AFC2                                      ; 03C40F 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03C413 4C 41 81 

.byte $BD,$62,$0A,$30,$0C,$1D,$F0,$09             ; 03C416 ........ ?b?0????
.byte $F0,$10,$BD,$9C,$0C,$C9,$1B,$B0             ; 03C41E ........ ????????
.byte $18,$BD,$9C,$0C,$C9,$1B,$F0,$11             ; 03C426 ........ ????????
.byte $90,$0F,$A9,$08,$85,$1C,$A9,$08             ; 03C42E ........ ????????
.byte $85,$1D,$22,$C2,$AF,$00,$4C,$41             ; 03C436 ........ ??"???LA
.byte $81,$9E,$D2,$06,$DA,$BC,$A0,$14             ; 03C43E ........ ????????
.byte $22,$F1,$AE,$00,$BD,$A0,$14,$AA             ; 03C446 ........ "???????
.byte $9E,$5E,$17,$0A,$0A,$A8,$A9,$F0             ; 03C44E ........ ?^??????
.byte $90,$05,$99,$09,$04,$80,$03,$99             ; 03C456 ........ ????????
.byte $09,$03,$FA,$AE,$D2,$18,$DE,$C5             ; 03C45E ........ ????????
.byte $18,$D0,$06,$9E,$C9,$18,$9E,$C1             ; 03C466 ........ ????????
.byte $18,$4C,$41,$81,$A9,$FF,$8D,$AF             ; 03C46E ........ ?LA?????
.byte $05,$DE,$4A,$13,$D0,$11,$FE,$D8             ; 03C476 ........ ??J?????
.byte $12,$BD,$D8,$12,$C9,$0F,$F0,$2F             ; 03C47E ........ ???????/
.byte $A8,$B9,$E7,$C4,$9D,$4A,$13,$BD             ; 03C486 ........ ?????J??
.byte $D8,$12,$29,$01,$F0,$06,$A9,$F0             ; 03C48E ........ ??)?????
.byte $85,$04,$80,$05,$BD,$BA,$0F,$85             ; 03C496 ........ ????????
.byte $04,$BD,$A0,$14,$0A,$0A,$A8,$A5             ; 03C49E ........ ????????
.byte $04,$90,$06,$99,$09,$04,$4C,$41             ; 03C4A6 ........ ??????LA
.byte $81,$99,$09,$03,$4C,$41,$81,$9E             ; 03C4AE ........ ????LA??
.byte $D2,$06,$DA,$BC,$A0,$14,$22,$F1             ; 03C4B6 ........ ??????"?
.byte $AE,$00,$BD,$A0,$14,$AA,$9E,$5E             ; 03C4BE ........ ???????^
.byte $17,$0A,$0A,$A8,$A9,$F0,$90,$05             ; 03C4C6 ........ ????????
.byte $99,$09,$04,$80,$03,$99,$09,$03             ; 03C4CE ........ ????????
.byte $FA,$AE,$D2,$18,$DE,$C5,$18,$D0             ; 03C4D6 ........ ????????
.byte $06,$9E,$C9,$18,$9E,$C1,$18,$4C             ; 03C4DE ........ ???????L
.byte $41,$81,$06,$06,$06,$06,$06,$06             ; 03C4E6 ........ A???????
.byte $06,$06,$06,$06,$06,$06,$06,$30             ; 03C4EE ........ ???????0
.byte $BD,$46,$0B,$85,$04,$BD,$9C,$0C             ; 03C4F6 ........ ?F??????
.byte $85,$05,$BD,$B6,$07,$85,$06,$20             ; 03C4FE ........ ??????? 
.byte $50,$C5,$18,$A5,$04,$65,$08,$85             ; 03C506 ........ P????e??
.byte $04,$20,$50,$C5,$18,$A5,$05,$65             ; 03C50E ........ ? P????e
.byte $08,$85,$05,$A9,$1E,$C5,$04,$90             ; 03C516 ........ ????????
.byte $02,$85,$04,$A9,$E2,$C5,$04,$B0             ; 03C51E ........ ????????
.byte $02,$85,$04,$A9,$2C,$C5,$05,$90             ; 03C526 ........ ????,???
.byte $02,$85,$05,$A9,$D0,$C5,$05,$B0             ; 03C52E ........ ????????
.byte $02,$85,$05,$DA,$22,$F3,$80,$03             ; 03C536 ........ ????"???
.byte $D0,$04,$22,$B1,$F6,$0C,$FA,$DE             ; 03C53E ........ ??"?????
.byte $80,$0D,$10,$03,$9E,$D2,$06,$4C             ; 03C546 ........ ???????L
.byte $41,$81,$22,$95,$CA,$0E,$29,$07             ; 03C54E ........ A?"???)?
.byte $A8,$B9,$6C,$C5,$85,$08,$22,$95             ; 03C556 ........ ??l???"?
.byte $CA,$0E,$29,$01,$D0,$07,$38,$A9             ; 03C55E ........ ??)???8?
.byte $00,$E5,$08,$85,$08,$60,$00,$04             ; 03C566 ........ ?????`??
.byte $08,$0C,$10,$14,$18,$1C,$BD,$80             ; 03C56E ........ ????????
.byte $0D,$F0,$06,$DE,$80,$0D,$4C,$41             ; 03C576 ........ ??????LA
.byte $81,$BD,$9E,$10,$85,$0C,$A9,$02             ; 03C57E ........ ????????
.byte $85,$07,$A9,$20,$9D,$80,$0D,$BD             ; 03C586 ........ ??? ????
.byte $46,$0B,$85,$04,$BD,$9C,$0C,$85             ; 03C58E ........ F???????
.byte $05,$BD,$BA,$0F,$85,$08,$BD,$2C             ; 03C596 ........ ???????,
.byte $10,$85,$06,$D0,$11,$AD,$E4,$05             ; 03C59E ........ ????????
.byte $D0,$0C,$AD,$E3,$05,$C9,$5A,$B0             ; 03C5A6 ........ ??????Z?
.byte $05,$A9,$5A,$8D,$E3,$05,$86,$09             ; 03C5AE ........ ??Z?????
.byte $C6,$08,$F0,$61,$22,$F3,$80,$03             ; 03C5B6 ........ ???a"???
.byte $D0,$51,$A5,$0C,$0A,$0A,$0A,$85             ; 03C5BE ........ ?Q??????
.byte $12,$22,$95,$CA,$0E,$29,$07,$18             ; 03C5C6 ........ ?"???)??
.byte $65,$12,$A8,$B9,$3F,$C7,$F0,$17             ; 03C5CE ........ e???????
.byte $A9,$0A,$22,$64,$80,$03,$30,$0F             ; 03C5D6 ........ ??"d??0?
.byte $8C,$D4,$18,$98,$0A,$09,$38,$85             ; 03C5DE ........ ??????8?
.byte $0A,$A9,$01,$85,$0E,$80,$13,$A9             ; 03C5E6 ........ ????????
.byte $09,$22,$64,$80,$03,$30,$1C,$8C             ; 03C5EE ........ ?"d??0??
.byte $D3,$18,$98,$0A,$09,$38,$85,$0A             ; 03C5F6 ........ ?????8??
.byte $64,$0E,$EE,$C6,$06,$EE,$E8,$18             ; 03C5FE ........ d???????
.byte $22,$94,$80,$03,$20,$74,$C6,$C6             ; 03C606 ........ "??? t??
.byte $07,$10,$A5,$A6,$09,$A5,$08,$9D             ; 03C60E ........ ????????
.byte $BA,$0F,$4C,$41,$81,$A6,$09,$A5             ; 03C616 ........ ??LA????
.byte $0C,$0A,$0A,$0A,$85,$12,$22,$95             ; 03C61E ........ ??????"?
.byte $CA,$0E,$29,$07,$18,$65,$12,$A8             ; 03C626 ........ ??)??e??
.byte $B9,$3F,$C7,$F0,$17,$A9,$0A,$22             ; 03C62E ........ ???????"
.byte $64,$80,$03,$30,$0F,$8C,$D4,$18             ; 03C636 ........ d??0????
.byte $98,$0A,$09,$38,$85,$0A,$A9,$01             ; 03C63E ........ ???8????
.byte $85,$0E,$80,$13,$A9,$09,$22,$64             ; 03C646 ........ ??????"d
.byte $80,$03,$30,$1A,$8C,$D3,$18,$98             ; 03C64E ........ ??0?????
.byte $0A,$09,$38,$85,$0A,$64,$0E,$20             ; 03C656 ........ ??8??d? 
.byte $74,$C6,$38,$AD,$E8,$18,$E9,$05             ; 03C65E ........ t?8?????
.byte $8D,$E8,$18,$4C,$41,$81,$A9,$01             ; 03C666 ........ ???LA???
.byte $9D,$BA,$0F,$4C,$41,$81,$A9,$01             ; 03C66E ........ ???LA???
.byte $9D,$D2,$06,$A9,$5B,$9D,$44,$07             ; 03C676 ........ ????[?D?
.byte $A9,$0C,$9D,$28,$08,$22,$95,$CA             ; 03C67E ........ ???(?"??
.byte $0E,$29,$01,$9D,$BA,$0F,$22,$95             ; 03C686 ........ ?)????"?
.byte $CA,$0E,$29,$3F,$18,$69,$32,$9D             ; 03C68E ........ ??)??i2?
.byte $80,$0D,$A9,$1E,$9D,$64,$0E,$A5             ; 03C696 ........ ?????d??
.byte $06,$0A,$0A,$18,$65,$07,$A8,$18             ; 03C69E ........ ????e???
.byte $A5,$04,$79,$8B,$C7,$9D,$46,$0B             ; 03C6A6 ........ ??y???F?
.byte $18,$A5,$05,$79,$9B,$C7,$9D,$9C             ; 03C6AE ........ ???y????
.byte $0C,$38,$BD,$46,$0B,$E9,$07,$B0             ; 03C6B6 ........ ?8?F????
.byte $02,$A9,$00,$9D,$16,$15,$18,$BD             ; 03C6BE ........ ????????
.byte $46,$0B,$69,$07,$90,$02,$A9,$FF             ; 03C6C6 ........ F?i?????
.byte $9D,$88,$15,$38,$BD,$9C,$0C,$E9             ; 03C6CE ........ ???8????
.byte $08,$B0,$02,$A9,$00,$9D,$FA,$15             ; 03C6D6 ........ ????????
.byte $18,$BD,$9C,$0C,$69,$08,$90,$02             ; 03C6DE ........ ????i???
.byte $A9,$FF,$9D,$6C,$16,$A5,$0E,$9D             ; 03C6E6 ........ ???l????
.byte $9E,$10,$9D,$82,$11,$0A,$0A,$0A             ; 03C6EE ........ ????????
.byte $85,$0D,$A5,$06,$0A,$18,$65,$0D             ; 03C6F6 ........ ??????e?
.byte $A8,$B9,$64,$94,$9D,$0C,$09,$B9             ; 03C6FE ........ ??d?????
.byte $65,$94,$9D,$7E,$09,$B9,$74,$94             ; 03C706 ........ e??~??t?
.byte $9D,$F0,$09,$B9,$75,$94,$9D,$62             ; 03C70E ........ ????u??b
.byte $0A,$A4,$06,$B9,$7F,$C7,$9D,$10             ; 03C716 ........ ????????
.byte $11,$B9,$83,$C7,$9D,$BC,$13,$A5             ; 03C71E ........ ????????
.byte $0A,$19,$87,$C7,$9D,$2E,$14,$22             ; 03C726 ........ ?????.?"
.byte $BC,$AE,$00,$98,$9D,$A0,$14,$A9             ; 03C72E ........ ????????
.byte $01,$99,$5E,$17,$22,$F1,$AE,$00             ; 03C736 ........ ??^?"???
.byte $60,$00,$00,$00,$00,$00,$00,$00             ; 03C73E ........ `???????
.byte $00,$00,$00,$00,$00,$01,$00,$00             ; 03C746 ........ ????????
.byte $00,$00,$00,$00,$00,$01,$01,$00             ; 03C74E ........ ????????
.byte $00,$00,$00,$01,$00,$01,$01,$00             ; 03C756 ........ ????????
.byte $00,$00,$00,$00,$01,$01,$01,$01             ; 03C75E ........ ????????
.byte $00,$00,$00,$01,$00,$01,$01,$01             ; 03C766 ........ ????????
.byte $00,$00,$01,$01,$01,$00,$01,$01             ; 03C76E ........ ????????
.byte $00,$01,$01,$01,$01,$01,$01,$01             ; 03C776 ........ ????????
.byte $01,$04,$06,$00,$02,$CC,$C8,$C4             ; 03C77E ........ ????????
.byte $C8,$00,$40,$00,$00,$F6,$0A,$00             ; 03C786 ........ ??@?????
.byte $00,$00,$00,$FC,$00,$F6,$0A,$00             ; 03C78E ........ ????????
.byte $00,$00,$00,$04,$00,$00,$00,$04             ; 03C796 ........ ????????
.byte $00,$F6,$09,$00,$00,$00,$00,$FC             ; 03C79E ........ ????????
.byte $00,$F6,$09,$00,$00,$60,$38,$BD             ; 03C7A6 ........ ?????`8?
.byte $46,$0B,$E9,$07,$B0,$02,$A9,$00             ; 03C7AE ........ F???????
.byte $9D,$16,$15,$18,$BD,$46,$0B,$69             ; 03C7B6 ........ ?????F?i
.byte $07,$90,$02,$A9,$FF,$9D,$88,$15             ; 03C7BE ........ ????????
.byte $38,$BD,$9C,$0C,$E9,$08,$B0,$02             ; 03C7C6 ........ 8???????
.byte $A9,$00,$9D,$FA,$15,$18,$BD,$9C             ; 03C7CE ........ ????????
.byte $0C,$69,$08,$90,$02,$A9,$FF,$9D             ; 03C7D6 ........ ?i??????
.byte $6C,$16,$A9,$08,$85,$1C,$A9,$0A             ; 03C7DE ........ l???????
.byte $85,$1D,$22,$C2,$AF,$00,$DE,$80             ; 03C7E6 ........ ??"?????
.byte $0D,$D0,$50,$22,$95,$CA,$0E,$29             ; 03C7EE ........ ??P"???)
.byte $3F,$18,$69,$20,$9D,$80,$0D,$22             ; 03C7F6 ........ ??i ???"
.byte $95,$CA,$0E,$29,$07,$A8,$B9,$44             ; 03C7FE ........ ???)???D
.byte $C8,$9D,$BC,$13,$BD,$2E,$14,$29             ; 03C806 ........ ?????.?)
.byte $3F,$19,$4C,$C8,$9D,$2E,$14,$BD             ; 03C80E ........ ??L??.??
.byte $82,$11,$0A,$0A,$0A,$0A,$85,$04             ; 03C816 ........ ????????
.byte $98,$0A,$18,$65,$04,$A8,$B9,$E2             ; 03C81E ........ ???e????
.byte $96,$9D,$0C,$09,$B9,$E3,$96,$9D             ; 03C826 ........ ????????
.byte $7E,$09,$B9,$32,$97,$9D,$F0,$09             ; 03C82E ........ ~??2????
.byte $B9,$33,$97,$9D,$62,$0A,$A9,$5C             ; 03C836 ........ ?3??b??\
.byte $9D,$44,$07,$4C,$41,$81,$C4,$C6             ; 03C83E ........ ?D?LA???
.byte $C8,$CA,$CC,$CA,$C8,$C6,$00,$00             ; 03C846 ........ ????????
.byte $00,$00,$00,$40,$40,$40,$DE,$80             ; 03C84E ........ ???@@@??
.byte $0D,$F0,$39,$BD,$7E,$09,$30,$0F             ; 03C856 ........ ??9?~?0?
.byte $1D,$0C,$09,$F0,$11,$BD,$46,$0B             ; 03C85E ........ ??????F?
.byte $C9,$E7,$B0,$28,$4C,$74,$C8,$BD             ; 03C866 ........ ???(Lt??
.byte $46,$0B,$C9,$19,$90,$1E,$BD,$62             ; 03C86E ........ F??????b
.byte $0A,$30,$0F,$1D,$F0,$09,$F0,$11             ; 03C876 ........ ?0??????
.byte $BD,$9C,$0C,$C9,$D4,$B0,$0D,$4C             ; 03C87E ........ ???????L
.byte $69,$C9,$BD,$9C,$0C,$C9,$28,$90             ; 03C886 ........ i?????(?
.byte $03,$4C,$69,$C9,$DE,$64,$0E,$D0             ; 03C88E ........ ?Li??d??
.byte $10,$A9,$0F,$9D,$64,$0E,$BD,$82             ; 03C896 ........ ????d???
.byte $11,$C9,$04,$F0,$04,$1A,$9D,$82             ; 03C89E ........ ????????
.byte $11,$64,$06,$22,$95,$CA,$0E,$29             ; 03C8A6 ........ ?d?"???)
.byte $20,$18,$69,$10,$9D,$80,$0D,$BC             ; 03C8AE ........  ?i?????
.byte $BA,$0F,$B9,$46,$0B,$85,$04,$B9             ; 03C8B6 ........ ???F????
.byte $9C,$0C,$85,$05,$22,$95,$CA,$0E             ; 03C8BE ........ ????"???
.byte $29,$0F,$0A,$A8,$18,$A5,$04,$79             ; 03C8C6 ........ )??????y
.byte $05,$CA,$85,$04,$18,$A5,$05,$79             ; 03C8CE ........ ???????y
.byte $06,$CA,$85,$05,$38,$A5,$04,$E9             ; 03C8D6 ........ ????8???
.byte $08,$DD,$46,$0B,$90,$07,$A9,$04             ; 03C8DE ........ ??F?????
.byte $85,$06,$4C,$F9,$C8,$18,$A5,$04             ; 03C8E6 ........ ??L?????
.byte $69,$08,$DD,$46,$0B,$B0,$04,$A9             ; 03C8EE ........ i??F????
.byte $08,$85,$06,$38,$A5,$05,$E9,$08             ; 03C8F6 ........ ???8????
.byte $DD,$9C,$0C,$90,$09,$A5,$06,$09             ; 03C8FE ........ ????????
.byte $02,$85,$06,$4C,$1C,$C9,$18,$A5             ; 03C906 ........ ???L????
.byte $05,$69,$08,$DD,$9C,$0C,$B0,$06             ; 03C90E ........ ?i??????
.byte $A5,$06,$09,$01,$85,$06,$A4,$06             ; 03C916 ........ ????????
.byte $D0,$08,$A9,$01,$9D,$80,$0D,$4C             ; 03C91E ........ ???????L
.byte $69,$C9,$B9,$EA,$C9,$9D,$10,$11             ; 03C926 ........ i???????
.byte $A8,$B9,$F5,$C9,$9D,$BC,$13,$BD             ; 03C92E ........ ????????
.byte $2E,$14,$29,$3F,$19,$FD,$C9,$9D             ; 03C936 ........ .?)?????
.byte $2E,$14,$BD,$82,$11,$0A,$0A,$0A             ; 03C93E ........ .???????
.byte $0A,$85,$04,$BD,$10,$11,$0A,$18             ; 03C946 ........ ????????
.byte $65,$04,$A8,$B9,$E2,$96,$9D,$0C             ; 03C94E ........ e???????
.byte $09,$B9,$E3,$96,$9D,$7E,$09,$B9             ; 03C956 ........ ?????~??
.byte $32,$97,$9D,$F0,$09,$B9,$33,$97             ; 03C95E ........ 2?????3?
.byte $9D,$62,$0A,$38,$BD,$46,$0B,$E9             ; 03C966 ........ ?b?8?F??
.byte $07,$B0,$02,$A9,$00,$9D,$16,$15             ; 03C96E ........ ????????
.byte $18,$BD,$46,$0B,$69,$07,$90,$02             ; 03C976 ........ ??F?i???
.byte $A9,$FF,$9D,$88,$15,$38,$BD,$9C             ; 03C97E ........ ?????8??
.byte $0C,$E9,$08,$B0,$02,$A9,$00,$9D             ; 03C986 ........ ????????
.byte $FA,$15,$18,$BD,$9C,$0C,$69,$08             ; 03C98E ........ ??????i?
.byte $90,$02,$A9,$FF,$9D,$6C,$16,$BC             ; 03C996 ........ ?????l??
.byte $10,$11,$38,$BD,$46,$0B,$E9,$08             ; 03C99E ........ ??8?F???
.byte $85,$07,$38,$BD,$9C,$0C,$E9,$0A             ; 03C9A6 ........ ??8?????
.byte $85,$08,$BD,$A0,$14,$0A,$0A,$A8             ; 03C9AE ........ ????????
.byte $90,$19,$A5,$07,$99,$08,$04,$A5             ; 03C9B6 ........ ????????
.byte $08,$99,$09,$04,$BD,$BC,$13,$99             ; 03C9BE ........ ????????
.byte $0A,$04,$BD,$2E,$14,$99,$0B,$04             ; 03C9C6 ........ ???.????
.byte $4C,$41,$81,$A5,$07,$99,$08,$03             ; 03C9CE ........ LA??????
.byte $A5,$08,$99,$09,$03,$BD,$BC,$13             ; 03C9D6 ........ ????????
.byte $99,$0A,$03,$BD,$2E,$14,$99,$0B             ; 03C9DE ........ ????.???
.byte $03,$4C,$41,$81,$00,$00,$04,$00             ; 03C9E6 ........ ?LA?????
.byte $02,$01,$03,$00,$06,$07,$05,$C4             ; 03C9EE ........ ????????
.byte $C6,$C8,$CA,$CC,$CA,$C8,$C6,$00             ; 03C9F6 ........ ????????
.byte $00,$00,$00,$00,$40,$40,$40,$E8             ; 03C9FE ........ ????@@@?
.byte $E8,$18,$E8,$18,$18,$E8,$18,$00             ; 03CA06 ........ ????????
.byte $F0,$10,$00,$00,$10,$F0,$00,$F8             ; 03CA0E ........ ????????
.byte $F8,$08,$F8,$08,$08,$F8,$08,$00             ; 03CA16 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$E0             ; 03CA1E ........ ????????
.byte $E0,$20,$E0,$20,$20,$E0,$20,$00             ; 03CA26 ........ ? ?  ? ?
.byte $F0,$10,$00,$00,$10,$F0,$00,$F8             ; 03CA2E ........ ????????
.byte $F8,$08,$F8,$08,$08,$F8,$08,$00             ; 03CA36 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$38             ; 03CA3E ........ ???????8
.byte $BD,$46,$0B,$E9,$07,$B0,$02,$A9             ; 03CA46 ........ ?F??????
.byte $00,$9D,$16,$15,$18,$BD,$46,$0B             ; 03CA4E ........ ??????F?
.byte $69,$07,$90,$02,$A9,$FF,$9D,$88             ; 03CA56 ........ i???????
.byte $15,$38,$BD,$9C,$0C,$E9,$08,$B0             ; 03CA5E ........ ?8??????
.byte $02,$A9,$00,$9D,$FA,$15,$18,$BD             ; 03CA66 ........ ????????
.byte $9C,$0C,$69,$08,$90,$02,$A9,$FF             ; 03CA6E ........ ??i?????
.byte $9D,$6C,$16,$DE,$4A,$13,$D0,$26             ; 03CA76 ........ ?l??J??&
.byte $FE,$D8,$12,$BD,$D8,$12,$C9,$10             ; 03CA7E ........ ????????
.byte $D0,$0D,$A9,$5C,$9D,$44,$07,$A9             ; 03CA86 ........ ???\?D??
.byte $01,$9D,$80,$0D,$4C,$41,$81,$BC             ; 03CA8E ........ ????LA??
.byte $D8,$12,$B9,$C3,$CA,$9D,$4A,$13             ; 03CA96 ........ ??????J?
.byte $B9,$B3,$CA,$9D,$BC,$13,$A9,$08             ; 03CA9E ........ ????????
.byte $85,$1C,$A9,$0A,$85,$1D,$22,$C2             ; 03CAA6 ........ ??????"?
.byte $AF,$00,$4C,$41,$81,$86,$88,$8A             ; 03CAAE ........ ??LA????
.byte $88,$86,$88,$8A,$88,$86,$88,$8A             ; 03CAB6 ........ ????????
.byte $88,$86,$88,$8A,$88,$0A,$03,$0F             ; 03CABE ........ ????????
.byte $03,$0A,$03,$0F,$03,$0A,$03,$0F             ; 03CAC6 ........ ????????
.byte $03,$0A,$03,$0F,$03,$38,$BD,$46             ; 03CACE ........ ?????8?F
.byte $0B,$E9,$07,$B0,$02,$A9,$00,$9D             ; 03CAD6 ........ ????????
.byte $16,$15,$18,$BD,$46,$0B,$69,$07             ; 03CADE ........ ????F?i?
.byte $90,$02,$A9,$FF,$9D,$88,$15,$38             ; 03CAE6 ........ ???????8
.byte $BD,$9C,$0C,$E9,$08,$B0,$02,$A9             ; 03CAEE ........ ????????
.byte $00,$9D,$FA,$15,$18,$BD,$9C,$0C             ; 03CAF6 ........ ????????
.byte $69,$08,$90,$02,$A9,$FF,$9D,$6C             ; 03CAFE ........ i??????l
.byte $16,$DE,$4A,$13,$D0,$26,$FE,$D8             ; 03CB06 ........ ??J??&??
.byte $12,$BD,$D8,$12,$C9,$10,$D0,$0D             ; 03CB0E ........ ????????
.byte $A9,$5C,$9D,$44,$07,$A9,$01,$9D             ; 03CB16 ........ ?\?D????
.byte $80,$0D,$4C,$41,$81,$BC,$D8,$12             ; 03CB1E ........ ??LA????
.byte $B9,$51,$CB,$9D,$4A,$13,$B9,$41             ; 03CB26 ........ ?Q??J??A
.byte $CB,$9D,$BC,$13,$A9,$08,$85,$1C             ; 03CB2E ........ ????????
.byte $A9,$0A,$85,$1D,$22,$C2,$AF,$00             ; 03CB36 ........ ????"???
.byte $4C,$41,$81,$80,$82,$84,$82,$80             ; 03CB3E ........ LA??????
.byte $82,$84,$82,$80,$82,$84,$82,$80             ; 03CB46 ........ ????????
.byte $82,$84,$82,$0A,$03,$0F,$03,$0A             ; 03CB4E ........ ????????
.byte $03,$0F,$03,$0A,$03,$0F,$03,$0A             ; 03CB56 ........ ????????
.byte $03,$0F,$03,$38,$BD,$46,$0B,$E9             ; 03CB5E ........ ???8?F??
.byte $07,$B0,$02,$A9,$00,$9D,$16,$15             ; 03CB66 ........ ????????
.byte $18,$BD,$46,$0B,$69,$07,$90,$02             ; 03CB6E ........ ??F?i???
.byte $A9,$FF,$9D,$88,$15,$38,$BD,$9C             ; 03CB76 ........ ?????8??
.byte $0C,$E9,$08,$B0,$02,$A9,$00,$9D             ; 03CB7E ........ ????????
.byte $FA,$15,$18,$BD,$9C,$0C,$69,$08             ; 03CB86 ........ ??????i?
.byte $90,$02,$A9,$FF,$9D,$6C,$16,$DE             ; 03CB8E ........ ?????l??
.byte $80,$0D,$D0,$0F,$A9,$5C,$9D,$44             ; 03CB96 ........ ?????\?D
.byte $07,$A9,$01,$9D,$80,$0D,$A9,$1E             ; 03CB9E ........ ????????
.byte $9D,$64,$0E,$38,$BD,$46,$0B,$E9             ; 03CBA6 ........ ?d?8?F??
.byte $08,$85,$04,$BD,$B8,$0B,$E9,$00             ; 03CBAE ........ ????????
.byte $85,$05,$38,$BD,$9C,$0C,$E9,$0A             ; 03CBB6 ........ ??8?????
.byte $85,$06,$BD,$0E,$0D,$E9,$00,$85             ; 03CBBE ........ ????????
.byte $07,$22,$42,$AF,$00,$4C,$41,$81             ; 03CBC6 ........ ?"B??LA?
.byte $4C,$41,$81,$4C,$41,$81,$4C,$41             ; 03CBCE ........ LA?LA?LA
.byte $81,$4C,$41,$81,$BD,$46,$0B,$85             ; 03CBD6 ........ ?LA??F??
.byte $04,$BD,$9C,$0C,$85,$05,$AD,$E0             ; 03CBDE ........ ????????
.byte $18,$0A,$09,$28,$85,$06,$DA,$AE             ; 03CBE6 ........ ???(????
.byte $E0,$18,$18,$BD,$C5,$18,$69,$03             ; 03CBEE ........ ??????i?
.byte $9D,$C5,$18,$FA,$9E,$D2,$06,$BC             ; 03CBF6 ........ ????????
.byte $2C,$10,$A9,$68,$99,$44,$07,$A9             ; 03CBFE ........ ,??h?D??
.byte $10,$99,$80,$0D,$20,$47,$CC,$BC             ; 03CC06 ........ ???? G??
.byte $A0,$14,$B9,$DE,$17,$9D,$A0,$14             ; 03CC0E ........ ????????
.byte $20,$47,$CC,$BC,$A0,$14,$B9,$DE             ; 03CC16 ........  G??????
.byte $17,$9D,$A0,$14,$20,$47,$CC,$BC             ; 03CC1E ........ ???? G??
.byte $A0,$14,$B9,$DE,$17,$9D,$A0,$14             ; 03CC26 ........ ????????
.byte $20,$47,$CC,$A0,$03,$5A,$20,$67             ; 03CC2E ........  G???Z g
.byte $CC,$7A,$88,$10,$F8,$A0,$07,$5A             ; 03CC36 ........ ?z?????Z
.byte $22,$BD,$F9,$0C,$7A,$88,$10,$F7             ; 03CC3E ........ "???z???
.byte $60,$DA,$BC,$A0,$14,$22,$F1,$AE             ; 03CC46 ........ `????"??
.byte $00,$BD,$A0,$14,$AA,$9E,$5E,$17             ; 03CC4E ........ ??????^?
.byte $0A,$0A,$A8,$A9,$F0,$90,$05,$99             ; 03CC56 ........ ????????
.byte $09,$04,$80,$03,$99,$09,$03,$FA             ; 03CC5E ........ ????????
.byte $60,$22,$F3,$80,$03,$D0,$6D,$22             ; 03CC66 ........ `"????m"
.byte $94,$80,$03,$A9,$01,$9D,$D2,$06             ; 03CC6E ........ ????????
.byte $A9,$6D,$9D,$44,$07,$A9,$00,$9D             ; 03CC76 ........ ?m?D????
.byte $28,$08,$B9,$DB,$CC,$9D,$BC,$13             ; 03CC7E ........ (???????
.byte $B9,$DF,$CC,$05,$06,$9D,$2E,$14             ; 03CC86 ........ ??????.?
.byte $18,$A5,$04,$79,$E3,$CC,$9D,$46             ; 03CC8E ........ ???y???F
.byte $0B,$18,$A5,$05,$79,$E7,$CC,$9D             ; 03CC96 ........ ????y???
.byte $9C,$0C,$B9,$EB,$CC,$9D,$0C,$09             ; 03CC9E ........ ????????
.byte $B9,$EF,$CC,$9D,$7E,$09,$B9,$F3             ; 03CCA6 ........ ????~???
.byte $CC,$BD,$F0,$09,$B9,$F7,$CC,$9D             ; 03CCAE ........ ????????
.byte $62,$0A,$A9,$14,$9D,$80,$0D,$22             ; 03CCB6 ........ b??????"
.byte $BC,$AE,$00,$98,$9D,$A0,$14,$A9             ; 03CCBE ........ ????????
.byte $01,$99,$5E,$17,$22,$F1,$AE,$00             ; 03CCC6 ........ ??^?"???
.byte $A9,$08,$85,$1C,$A9,$08,$85,$1D             ; 03CCCE ........ ????????
.byte $22,$C2,$AF,$00,$60,$6E,$86,$86             ; 03CCD6 ........ "???`n??
.byte $6E,$01,$01,$41,$41,$F8,$F8,$08             ; 03CCDE ........ n??AA???
.byte $08,$F8,$08,$08,$F8,$00,$00,$00             ; 03CCE6 ........ ????????
.byte $00,$FF,$FF,$01,$01,$00,$00,$00             ; 03CCEE ........ ????????
.byte $00,$FF,$01,$01,$FF,$AD,$9C,$06             ; 03CCF6 ........ ????????
.byte $F0,$30,$A9,$6B,$9D,$44,$07,$A9             ; 03CCFE ........ ?0?k?D??
.byte $50,$9D,$BA,$0F,$A9,$04,$9D,$D6             ; 03CD06 ........ P???????
.byte $0E,$A9,$01,$9D,$F2,$0D,$BD,$82             ; 03CD0E ........ ????????
.byte $11,$0A,$0A,$09,$03,$9D,$64,$0E             ; 03CD16 ........ ??????d?
.byte $DA,$C2,$10,$A9,$07,$A2,$0A,$FF             ; 03CD1E ........ ????????
.byte $22,$0F,$83,$0F,$E2,$10,$FA,$4C             ; 03CD26 ........ "??????L
.byte $57,$CE,$AD,$DE,$05,$F0,$03,$4C             ; 03CD2E ........ W??????L
.byte $57,$CE,$DE,$F2,$0D,$D0,$45,$BD             ; 03CD36 ........ W?????E?
.byte $9C,$0C,$C9,$60,$B0,$30,$9E,$0C             ; 03CD3E ........ ???`?0??
.byte $09,$9E,$7E,$09,$9E,$F0,$09,$9E             ; 03CD46 ........ ??~?????
.byte $62,$0A,$A9,$66,$9D,$44,$07,$A9             ; 03CD4E ........ b??f?D??
.byte $10,$9D,$80,$0D,$A9,$06,$9D,$F2             ; 03CD56 ........ ????????
.byte $0D,$22,$95,$CA,$0E,$29,$3F,$18             ; 03CD5E ........ ?"???)??
.byte $69,$A0,$9D,$BA,$0F,$A9,$05,$22             ; 03CD66 ........ i??????"
.byte $3C,$82,$03,$4C,$57,$CE,$22,$95             ; 03CD6E ........ <??LW?"?
.byte $CA,$0E,$18,$69,$20,$90,$02,$A9             ; 03CD76 ........ ???i ???
.byte $FF,$9D,$F2,$0D,$DE,$80,$0D,$F0             ; 03CD7E ........ ????????
.byte $03,$4C,$11,$CE,$22,$95,$CA,$0E             ; 03CD86 ........ ?L??"???
.byte $29,$01,$D0,$04,$22,$AA,$F8,$0C             ; 03CD8E ........ )???"???
.byte $BD,$D2,$06,$29,$40,$F0,$16,$22             ; 03CD96 ........ ???)@??"
.byte $95,$CA,$0E,$29,$03,$D0,$0E,$22             ; 03CD9E ........ ???)???"
.byte $95,$CA,$0E,$29,$07,$A8,$B9,$99             ; 03CDA6 ........ ???)????
.byte $CE,$22,$3C,$82,$03,$22,$95,$CA             ; 03CDAE ........ ?"<??"??
.byte $0E,$29,$03,$D0,$1E,$A9,$40,$9D             ; 03CDB6 ........ ?)????@?
.byte $BA,$0F,$BC,$82,$11,$B9,$46,$0B             ; 03CDBE ........ ??????F?
.byte $9D,$9E,$10,$22,$95,$CA,$0E,$29             ; 03CDC6 ........ ???"???)
.byte $01,$D0,$25,$B9,$9C,$0C,$9D,$10             ; 03CDCE ........ ??%?????
.byte $11,$80,$2D,$22,$95,$CA,$0E,$29             ; 03CDD6 ........ ??-"???)
.byte $07,$A8,$B9,$E1,$CE,$9D,$BA,$0F             ; 03CDDE ........ ????????
.byte $22,$95,$CA,$0E,$4D,$43,$21,$29             ; 03CDE6 ........ "???MC!)
.byte $1F,$A8,$B9,$C1,$CE,$9D,$9E,$10             ; 03CDEE ........ ????????
.byte $22,$95,$CA,$0E,$4D,$43,$21,$29             ; 03CDF6 ........ "???MC!)
.byte $1F,$A8,$B9,$A1,$CE,$9D,$10,$11             ; 03CDFE ........ ????????
.byte $22,$95,$CA,$0E,$29,$3F,$69,$20             ; 03CE06 ........ "???)?i 
.byte $9D,$80,$0D,$22,$BD,$F7,$0C,$BD             ; 03CE0E ........ ???"????
.byte $7E,$09,$10,$10,$C9,$FD,$F0,$02             ; 03CE16 ........ ~???????
.byte $B0,$16,$A9,$FE,$9D,$7E,$09,$9E             ; 03CE1E ........ ?????~??
.byte $0C,$09,$80,$0C,$C9,$02,$90,$08             ; 03CE26 ........ ????????
.byte $A9,$02,$9D,$7E,$09,$9E,$0C,$09             ; 03CE2E ........ ???~????
.byte $BD,$62,$0A,$10,$10,$C9,$FD,$F0             ; 03CE36 ........ ?b??????
.byte $02,$B0,$16,$A9,$FE,$9D,$62,$0A             ; 03CE3E ........ ??????b?
.byte $9E,$F0,$09,$80,$0C,$C9,$02,$90             ; 03CE46 ........ ????????
.byte $08,$A9,$02,$9D,$62,$0A,$9E,$F0             ; 03CE4E ........ ????b???
.byte $09,$38,$BD,$46,$0B,$E9,$0C,$B0             ; 03CE56 ........ ?8?F????
.byte $02,$A9,$00,$9D,$16,$15,$18,$BD             ; 03CE5E ........ ????????
.byte $46,$0B,$69,$0C,$90,$02,$A9,$FF             ; 03CE66 ........ F?i?????
.byte $9D,$88,$15,$38,$BD,$9C,$0C,$E9             ; 03CE6E ........ ???8????
.byte $0C,$B0,$02,$A9,$00,$9D,$FA,$15             ; 03CE76 ........ ????????
.byte $18,$BD,$9C,$0C,$69,$0C,$90,$02             ; 03CE7E ........ ????i???
.byte $A9,$FF,$9D,$6C,$16,$22,$6A,$82             ; 03CE86 ........ ???l?"j?
.byte $03,$20,$70,$D4,$22,$91,$F8,$0C             ; 03CE8E ........ ? p?"???
.byte $4C,$41,$81,$00,$03,$00,$04,$00             ; 03CE96 ........ LA??????
.byte $04,$00,$04,$C8,$30,$38,$40,$28             ; 03CE9E ........ ????08@(
.byte $30,$38,$C8,$28,$30,$38,$40,$28             ; 03CEA6 ........ 08?(08@(
.byte $30,$38,$40,$28,$30,$38,$40,$28             ; 03CEAE ........ 08@(08@(
.byte $30,$38,$40,$C8,$30,$38,$40,$28             ; 03CEB6 ........ 08@?08@(
.byte $30,$38,$C8,$80,$88,$90,$18,$20             ; 03CEBE ........ 08????? 
.byte $28,$30,$38,$40,$48,$50,$58,$60             ; 03CEC6 ........ (08@HPX`
.byte $68,$70,$78,$80,$88,$90,$98,$A0             ; 03CECE ........ hpx?????
.byte $A8,$B0,$B8,$C0,$C8,$D0,$D8,$E0             ; 03CED6 ........ ????????
.byte $90,$88,$80,$10,$0E,$0C,$0A,$0A             ; 03CEDE ........ ????????
.byte $0C,$0E,$10,$BD,$2C,$10,$10,$03             ; 03CEE6 ........ ????,???
.byte $4C,$91,$CF,$BC,$BA,$0F,$B9,$D4             ; 03CEEE ........ L???????
.byte $0A,$85,$06,$B9,$46,$0B,$85,$07             ; 03CEF6 ........ ????F???
.byte $B9,$2A,$0C,$85,$0A,$B9,$9C,$0C             ; 03CEFE ........ ?*??????
.byte $85,$0B,$BC,$2C,$10,$B9,$D4,$0A             ; 03CF06 ........ ???,????
.byte $85,$08,$B9,$46,$0B,$85,$09,$B9             ; 03CF0E ........ ???F????
.byte $2A,$0C,$85,$0C,$B9,$9C,$0C,$85             ; 03CF16 ........ *???????
.byte $0D,$C2,$20,$38,$A5,$06,$E5,$08             ; 03CF1E ........ ?? 8????
.byte $B0,$1E,$38,$A5,$08,$E5,$06,$4A             ; 03CF26 ........ ??8????J
.byte $85,$04,$38,$A5,$08,$E5,$04,$85             ; 03CF2E ........ ??8?????
.byte $04,$E2,$20,$A5,$04,$9D,$D4,$0A             ; 03CF36 ........ ?? ?????
.byte $A5,$05,$9D,$46,$0B,$4C,$58,$CF             ; 03CF3E ........ ???F?LX?
.byte $4A,$18,$65,$08,$85,$04,$E2,$20             ; 03CF46 ........ J?e???? 
.byte $A5,$04,$9D,$D4,$0A,$A5,$05,$9D             ; 03CF4E ........ ????????
.byte $46,$0B,$C2,$20,$38,$A5,$0A,$E5             ; 03CF56 ........ F?? 8???
.byte $0C,$B0,$1E,$38,$A5,$0C,$E5,$0A             ; 03CF5E ........ ???8????
.byte $4A,$85,$04,$38,$A5,$0C,$E5,$04             ; 03CF66 ........ J??8????
.byte $85,$04,$E2,$20,$A5,$04,$9D,$2A             ; 03CF6E ........ ??? ???*
.byte $0C,$A5,$05,$9D,$9C,$0C,$4C,$91             ; 03CF76 ........ ??????L?
.byte $CF,$4A,$18,$65,$0C,$85,$04,$E2             ; 03CF7E ........ ?J?e????
.byte $20,$A5,$04,$9D,$2A,$0C,$A5,$05             ; 03CF86 ........  ???*???
.byte $9D,$9C,$0C,$38,$BD,$46,$0B,$E9             ; 03CF8E ........ ???8?F??
.byte $08,$B0,$02,$A9,$00,$9D,$16,$15             ; 03CF96 ........ ????????
.byte $18,$BD,$46,$0B,$69,$08,$90,$02             ; 03CF9E ........ ??F?i???
.byte $A9,$FF,$9D,$88,$15,$38,$BD,$9C             ; 03CFA6 ........ ?????8??
.byte $0C,$E9,$08,$B0,$02,$A9,$00,$9D             ; 03CFAE ........ ????????
.byte $FA,$15,$18,$BD,$9C,$0C,$69,$08             ; 03CFB6 ........ ??????i?
.byte $90,$02,$A9,$FF,$9D,$6C,$16,$BD             ; 03CFBE ........ ?????l??
.byte $F2,$0D,$F0,$2C,$DE,$F2,$0D,$D0             ; 03CFC6 ........ ???,????
.byte $27,$BC,$BA,$0F,$B9,$44,$07,$C9             ; 03CFCE ........ '????D??
.byte $64,$F0,$17,$C9,$66,$F0,$13,$C9             ; 03CFD6 ........ d???f???
.byte $6B,$F0,$0F,$BD,$2E,$14,$99,$2E             ; 03CFDE ........ k???.??.
.byte $14,$8A,$29,$01,$18,$69,$02,$99             ; 03CFE6 ........ ??)??i??
.byte $F2,$0D,$BD,$B6,$07,$9D,$2E,$14             ; 03CFEE ........ ??????.?
.byte $38,$BD,$46,$0B,$E9,$08,$85,$0E             ; 03CFF6 ........ 8?F?????
.byte $38,$BD,$9C,$0C,$E9,$09,$85,$0F             ; 03CFFE ........ 8???????
.byte $AD,$DE,$05,$F0,$0E,$38,$A5,$0E             ; 03D006 ........ ?????8??
.byte $ED,$C8,$06,$85,$0E,$90,$04,$A9             ; 03D00E ........ ????????
.byte $F0,$85,$0F,$BD,$A0,$14,$0A,$0A             ; 03D016 ........ ????????
.byte $A8,$90,$19,$A5,$0E,$99,$08,$04             ; 03D01E ........ ????????
.byte $A5,$0F,$99,$09,$04,$BD,$BC,$13             ; 03D026 ........ ????????
.byte $99,$0A,$04,$BD,$2E,$14,$99,$0B             ; 03D02E ........ ????.???
.byte $04,$4C,$41,$81,$A5,$0E,$99,$08             ; 03D036 ........ ?LA?????
.byte $03,$A5,$0F,$99,$09,$03,$BD,$BC             ; 03D03E ........ ????????
.byte $13,$99,$0A,$03,$BD,$2E,$14,$99             ; 03D046 ........ ?????.??
.byte $0B,$03,$4C,$41,$81,$AD,$9C,$06             ; 03D04E ........ ??LA????
.byte $F0,$30,$A9,$6B,$9D,$44,$07,$A9             ; 03D056 ........ ?0?k?D??
.byte $50,$9D,$BA,$0F,$A9,$04,$9D,$D6             ; 03D05E ........ P???????
.byte $0E,$A9,$01,$9D,$F2,$0D,$BD,$82             ; 03D066 ........ ????????
.byte $11,$0A,$0A,$09,$03,$9D,$64,$0E             ; 03D06E ........ ??????d?
.byte $DA,$C2,$10,$A9,$07,$A2,$0A,$FF             ; 03D076 ........ ????????
.byte $22,$0F,$83,$0F,$E2,$10,$FA,$4C             ; 03D07E ........ "??????L
.byte $41,$81,$BD,$D2,$06,$29,$40,$F0             ; 03D086 ........ A????)@?
.byte $18,$A9,$64,$9D,$44,$07,$A9,$10             ; 03D08E ........ ??d?D???
.byte $9D,$80,$0D,$22,$95,$CA,$0E,$18             ; 03D096 ........ ???"????
.byte $69,$20,$90,$02,$A9,$FF,$9D,$F2             ; 03D09E ........ i ??????
.byte $0D,$38,$BD,$46,$0B,$E9,$0C,$B0             ; 03D0A6 ........ ?8?F????
.byte $02,$A9,$00,$9D,$16,$15,$18,$BD             ; 03D0AE ........ ????????
.byte $46,$0B,$69,$0C,$90,$02,$A9,$FF             ; 03D0B6 ........ F?i?????
.byte $9D,$88,$15,$38,$BD,$9C,$0C,$E9             ; 03D0BE ........ ???8????
.byte $0C,$B0,$02,$A9,$00,$9D,$FA,$15             ; 03D0C6 ........ ????????
.byte $18,$BD,$9C,$0C,$69,$0C,$90,$02             ; 03D0CE ........ ????i???
.byte $A9,$FF,$9D,$6C,$16,$22,$6A,$82             ; 03D0D6 ........ ???l?"j?
.byte $03,$20,$70,$D4,$BD,$F2,$0D,$D0             ; 03D0DE ........ ? p?????
.byte $03,$4C,$95,$D1,$DE,$80,$0D,$F0             ; 03D0E6 ........ ?L??????
.byte $03,$4C,$95,$D1,$A9,$02,$9D,$80             ; 03D0EE ........ ?L??????
.byte $0D,$DE,$F2,$0D,$BD,$46,$0B,$85             ; 03D0F6 ........ ?????F??
.byte $04,$18,$BD,$9C,$0C,$69,$0C,$85             ; 03D0FE ........ ?????i??
.byte $05,$BD,$BA,$0F,$85,$06,$22,$F3             ; 03D106 ........ ??????"?
.byte $80,$03,$F0,$03,$4C,$95,$D1,$22             ; 03D10E ........ ????L??"
.byte $94,$80,$03,$A9,$01,$9D,$D2,$06             ; 03D116 ........ ????????
.byte $A9,$69,$9D,$44,$07,$A9,$0C,$9D             ; 03D11E ........ ?i?D????
.byte $28,$08,$A5,$04,$9D,$46,$0B,$A5             ; 03D126 ........ (????F??
.byte $05,$9D,$9C,$0C,$A5,$06,$9D,$BA             ; 03D12E ........ ????????
.byte $0F,$A9,$06,$9D,$62,$0A,$38,$BD             ; 03D136 ........ ????b?8?
.byte $46,$0B,$E9,$04,$B0,$02,$A9,$00             ; 03D13E ........ F???????
.byte $9D,$16,$15,$18,$BD,$46,$0B,$69             ; 03D146 ........ ?????F?i
.byte $04,$90,$02,$A9,$FF,$9D,$88,$15             ; 03D14E ........ ????????
.byte $38,$BD,$9C,$0C,$E9,$08,$B0,$02             ; 03D156 ........ 8???????
.byte $A9,$00,$9D,$FA,$15,$18,$BD,$9C             ; 03D15E ........ ????????
.byte $0C,$69,$08,$90,$02,$A9,$FF,$9D             ; 03D166 ........ ?i??????
.byte $6C,$16,$22,$95,$CA,$0E,$29,$03             ; 03D16E ........ l?"???)?
.byte $0A,$A8,$B9,$9C,$D1,$9D,$BC,$13             ; 03D176 ........ ????????
.byte $B9,$9D,$D1,$9D,$2E,$14,$22,$BC             ; 03D17E ........ ????.?"?
.byte $AE,$00,$98,$9D,$A0,$14,$A9,$01             ; 03D186 ........ ????????
.byte $99,$5E,$17,$22,$F1,$AE,$00,$22             ; 03D18E ........ ?^?"???"
.byte $91,$F8,$0C,$4C,$41,$81,$A0,$33             ; 03D196 ........ ???LA??3
.byte $A0,$73,$A2,$33,$A2,$73,$4C,$41             ; 03D19E ........ ?s?3?sLA
.byte $81,$DE,$80,$0D,$D0,$7A,$BC,$2C             ; 03D1A6 ........ ?????z?,
.byte $10,$10,$2F,$DA,$BD,$46,$0B,$85             ; 03D1AE ........ ??/??F??
.byte $04,$BD,$9C,$0C,$85,$05,$22,$F3             ; 03D1B6 ........ ??????"?
.byte $80,$03,$22,$94,$80,$03,$A9,$01             ; 03D1BE ........ ??"?????
.byte $9D,$D2,$06,$A9,$6C,$9D,$44,$07             ; 03D1C6 ........ ????l?D?
.byte $A9,$78,$9D,$80,$0D,$A5,$04,$9D             ; 03D1CE ........ ?x??????
.byte $46,$0B,$A5,$05,$9D,$9C,$0C,$FA             ; 03D1D6 ........ F???????
.byte $80,$0C,$A9,$68,$99,$44,$07,$A9             ; 03D1DE ........ ???h?D??
.byte $07,$99,$80,$0D,$80,$00,$20,$29             ; 03D1E6 ........ ?????? )
.byte $D2,$A9,$09,$9D,$44,$07,$A9,$00             ; 03D1EE ........ ????D???
.byte $9D,$28,$08,$A9,$20,$9D,$BC,$13             ; 03D1F6 ........ ?(?? ???
.byte $A9,$32,$9D,$2E,$14,$9E,$0C,$09             ; 03D1FE ........ ?2?.????
.byte $9E,$7E,$09,$9E,$F0,$09,$9E,$62             ; 03D206 ........ ?~?????b
.byte $0A,$A9,$04,$9D,$4A,$13,$9E,$D8             ; 03D20E ........ ????J???
.byte $12,$DA,$C2,$10,$A9,$07,$A2,$06             ; 03D216 ........ ????????
.byte $FF,$22,$0F,$83,$0F,$E2,$30,$FA             ; 03D21E ........ ?"????0?
.byte $4C,$41,$81,$DA,$AE,$E1,$18,$DE             ; 03D226 ........ LA??????
.byte $C5,$18,$D0,$06,$9E,$C9,$18,$9E             ; 03D22E ........ ????????
.byte $C1,$18,$FA,$60,$38,$BD,$46,$0B             ; 03D236 ........ ???`8?F?
.byte $E9,$04,$B0,$02,$A9,$00,$9D,$16             ; 03D23E ........ ????????
.byte $15,$18,$BD,$46,$0B,$69,$04,$90             ; 03D246 ........ ???F?i??
.byte $02,$A9,$FF,$9D,$88,$15,$38,$BD             ; 03D24E ........ ??????8?
.byte $9C,$0C,$E9,$08,$B0,$02,$A9,$00             ; 03D256 ........ ????????
.byte $9D,$FA,$15,$18,$BD,$9C,$0C,$69             ; 03D25E ........ ???????i
.byte $08,$90,$02,$A9,$FF,$9D,$6C,$16             ; 03D266 ........ ??????l?
.byte $A9,$08,$85,$1C,$A9,$09,$85,$1D             ; 03D26E ........ ????????
.byte $22,$C2,$AF,$00,$18,$BD,$9C,$0C             ; 03D276 ........ "???????
.byte $69,$08,$DD,$BA,$0F,$90,$11,$9D             ; 03D27E ........ i???????
.byte $9C,$0C,$9E,$62,$0A,$A9,$6A,$9D             ; 03D286 ........ ???b??j?
.byte $44,$07,$A9,$06,$22,$3C,$82,$03             ; 03D28E ........ D???"<??
.byte $4C,$41,$81,$22,$6A,$82,$03,$BD             ; 03D296 ........ LA?"j???
.byte $D2,$06,$29,$40,$F0,$03,$4C,$FB             ; 03D29E ........ ??)@??L?
.byte $D2,$38,$BD,$46,$0B,$E9,$07,$B0             ; 03D2A6 ........ ?8?F????
.byte $02,$A9,$00,$9D,$16,$15,$18,$BD             ; 03D2AE ........ ????????
.byte $46,$0B,$69,$07,$90,$02,$A9,$FF             ; 03D2B6 ........ F?i?????
.byte $9D,$88,$15,$38,$BD,$9C,$0C,$E9             ; 03D2BE ........ ???8????
.byte $07,$B0,$02,$A9,$00,$9D,$FA,$15             ; 03D2C6 ........ ????????
.byte $18,$BD,$9C,$0C,$69,$07,$90,$02             ; 03D2CE ........ ????i???
.byte $A9,$FF,$9D,$6C,$16,$BD,$F4,$11             ; 03D2D6 ........ ???l????
.byte $0A,$A8,$B9,$20,$D3,$9D,$BC,$13             ; 03D2DE ........ ??? ????
.byte $B9,$21,$D3,$9D,$2E,$14,$A9,$08             ; 03D2E6 ........ ?!??.???
.byte $85,$1C,$A9,$09,$85,$1D,$22,$C2             ; 03D2EE ........ ??????"?
.byte $AF,$00,$4C,$41,$81,$9E,$D2,$06             ; 03D2F6 ........ ??LA????
.byte $DA,$BC,$A0,$14,$22,$F1,$AE,$00             ; 03D2FE ........ ????"???
.byte $BD,$A0,$14,$AA,$9E,$5E,$17,$0A             ; 03D306 ........ ?????^??
.byte $0A,$A8,$A9,$F0,$90,$05,$99,$09             ; 03D30E ........ ????????
.byte $04,$80,$03,$99,$09,$03,$FA,$4C             ; 03D316 ........ ???????L
.byte $41,$81,$A4,$33,$A6,$33,$A8,$33             ; 03D31E ........ A??3?3?3
.byte $AA,$33,$AC,$33,$BD,$D2,$06,$29             ; 03D326 ........ ?3?3???)
.byte $40,$F0,$0B,$22,$95,$CA,$0E,$29             ; 03D32E ........ @??"???)
.byte $01,$1A,$22,$3C,$82,$03,$BD,$D6             ; 03D336 ........ ??"<????
.byte $0E,$D0,$0E,$20,$DA,$CB,$A9,$80             ; 03D33E ........ ??? ????
.byte $8D,$14,$15,$8D,$15,$15,$4C,$41             ; 03D346 ........ ??????LA
.byte $81,$DE,$F2,$0D,$D0,$24,$DE,$D6             ; 03D34E ........ ?????$??
.byte $0E,$A9,$32,$9D,$F2,$0D,$BD,$64             ; 03D356 ........ ??2????d
.byte $0E,$0A,$A8,$B9,$EA,$D3,$9D,$9E             ; 03D35E ........ ????????
.byte $10,$B9,$EB,$D3,$9D,$10,$11,$DE             ; 03D366 ........ ????????
.byte $64,$0E,$BD,$64,$0E,$29,$07,$9D             ; 03D36E ........ d??d?)??
.byte $64,$0E,$DE,$80,$0D,$D0,$19,$A9             ; 03D376 ........ d???????
.byte $07,$9D,$80,$0D,$BC,$82,$11,$B9             ; 03D37E ........ ????????
.byte $BC,$06,$A8,$A9,$02,$99,$F2,$0D             ; 03D386 ........ ????????
.byte $B9,$2E,$14,$29,$F1,$99,$2E,$14             ; 03D38E ........ ?.?)??.?
.byte $22,$BD,$F7,$0C,$BD,$7E,$09,$10             ; 03D396 ........ "????~??
.byte $10,$C9,$FC,$F0,$02,$B0,$16,$A9             ; 03D39E ........ ????????
.byte $FD,$9D,$7E,$09,$9E,$0C,$09,$80             ; 03D3A6 ........ ??~?????
.byte $0C,$C9,$03,$90,$08,$A9,$03,$9D             ; 03D3AE ........ ????????
.byte $7E,$09,$9E,$0C,$09,$BD,$62,$0A             ; 03D3B6 ........ ~?????b?
.byte $10,$10,$C9,$FC,$F0,$02,$B0,$16             ; 03D3BE ........ ????????
.byte $A9,$FD,$9D,$62,$0A,$9E,$F0,$09             ; 03D3C6 ........ ???b????
.byte $80,$0C,$C9,$03,$90,$08,$A9,$03             ; 03D3CE ........ ????????
.byte $9D,$62,$0A,$9E,$F0,$09,$22,$6A             ; 03D3D6 ........ ?b????"j
.byte $82,$03,$20,$70,$D4,$22,$91,$F8             ; 03D3DE ........ ?? p?"??
.byte $0C,$4C,$41,$81,$B8,$4C,$80,$20             ; 03D3E6 ........ ?LA??L? 
.byte $48,$20,$48,$4C,$80,$20,$B8,$4C             ; 03D3EE ........ H HL? ?L
.byte $48,$4C,$B8,$20,$DE,$80,$0D,$D0             ; 03D3F6 ........ HL? ????
.byte $1A,$CE,$C6,$06,$CE,$00,$19,$9E             ; 03D3FE ........ ????????
.byte $D2,$06,$A9,$7F,$8D,$AF,$05,$AD             ; 03D406 ........ ????????
.byte $00,$19,$D0,$04,$22,$33,$FB,$0C             ; 03D40E ........ ????"3??
.byte $4C,$41,$81,$A5,$D2,$29,$03,$F0             ; 03D416 ........ LA???)??
.byte $04,$22,$3D,$FA,$0C,$4C,$41,$81             ; 03D41E ........ ?"=??LA?
.byte $DE,$80,$0D,$F0,$0F,$A9,$08,$85             ; 03D426 ........ ????????
.byte $1C,$A9,$08,$85,$1D,$22,$C2,$AF             ; 03D42E ........ ?????"??
.byte $00,$4C,$41,$81,$DA,$AE,$E0,$18             ; 03D436 ........ ?LA?????
.byte $DE,$C5,$18,$D0,$06,$9E,$C9,$18             ; 03D43E ........ ????????
.byte $9E,$C1,$18,$FA,$9E,$0C,$09,$9E             ; 03D446 ........ ????????
.byte $7E,$09,$9E,$F0,$09,$9E,$62,$0A             ; 03D44E ........ ~?????b?
.byte $A9,$09,$9D,$44,$07,$A9,$20,$9D             ; 03D456 ........ ???D?? ?
.byte $BC,$13,$A9,$32,$9D,$2E,$14,$A9             ; 03D45E ........ ???2?.??
.byte $04,$9D,$4A,$13,$9E,$D8,$12,$4C             ; 03D466 ........ ??J????L
.byte $41,$81,$BD,$F4,$11,$A8,$38,$BD             ; 03D46E ........ A?????8?
.byte $46,$0B,$E9,$10,$85,$09,$85,$0A             ; 03D476 ........ F???????
.byte $38,$BD,$9C,$0C,$E9,$11,$F9,$72             ; 03D47E ........ 8??????r
.byte $D5,$85,$0B,$BD,$B6,$07,$85,$0E             ; 03D486 ........ ????????
.byte $BD,$F4,$11,$0A,$0A,$0A,$85,$0F             ; 03D48E ........ ????????
.byte $A8,$B9,$83,$D5,$85,$0C,$B9,$84             ; 03D496 ........ ????????
.byte $D5,$05,$0E,$85,$0D,$BD,$A0,$14             ; 03D49E ........ ????????
.byte $48,$20,$05,$D5,$18,$A5,$0A,$69             ; 03D4A6 ........ H ?????i
.byte $10,$85,$0A,$A4,$0F,$B9,$85,$D5             ; 03D4AE ........ ????????
.byte $85,$0C,$B9,$86,$D5,$05,$0E,$85             ; 03D4B6 ........ ????????
.byte $0D,$7A,$B9,$DE,$17,$48,$20,$05             ; 03D4BE ........ ?z???H ?
.byte $D5,$18,$A5,$0B,$69,$10,$85,$0B             ; 03D4C6 ........ ????i???
.byte $A5,$09,$85,$0A,$A4,$0F,$B9,$87             ; 03D4CE ........ ????????
.byte $D5,$85,$0C,$B9,$88,$D5,$05,$0E             ; 03D4D6 ........ ????????
.byte $85,$0D,$7A,$B9,$DE,$17,$48,$20             ; 03D4DE ........ ??z???H 
.byte $05,$D5,$18,$A5,$0A,$69,$10,$85             ; 03D4E6 ........ ?????i??
.byte $0A,$A4,$0F,$B9,$89,$D5,$85,$0C             ; 03D4EE ........ ????????
.byte $B9,$8A,$D5,$05,$0E,$85,$0D,$7A             ; 03D4F6 ........ ???????z
.byte $B9,$DE,$17,$20,$05,$D5,$60,$0A             ; 03D4FE ........ ??? ??`?
.byte $0A,$A8,$90,$34,$A5,$0B,$48,$A5             ; 03D506 ........ ???4??H?
.byte $0A,$48,$AD,$DE,$05,$F0,$0E,$38             ; 03D50E ........ ?H?????8
.byte $A5,$0A,$ED,$C8,$06,$85,$0A,$90             ; 03D516 ........ ????????
.byte $04,$A9,$F0,$85,$0B,$A5,$0A,$99             ; 03D51E ........ ????????
.byte $08,$04,$68,$85,$0A,$A5,$0B,$99             ; 03D526 ........ ??h?????
.byte $09,$04,$68,$85,$0B,$A5,$0C,$99             ; 03D52E ........ ??h?????
.byte $0A,$04,$A5,$0D,$99,$0B,$04,$60             ; 03D536 ........ ???????`
.byte $A5,$0B,$48,$A5,$0A,$48,$AD,$DE             ; 03D53E ........ ??H??H??
.byte $05,$F0,$0E,$38,$A5,$0A,$ED,$C8             ; 03D546 ........ ???8????
.byte $06,$85,$0A,$90,$04,$A9,$F0,$85             ; 03D54E ........ ????????
.byte $0B,$A5,$0A,$99,$08,$03,$68,$85             ; 03D556 ........ ??????h?
.byte $0A,$A5,$0B,$99,$09,$03,$68,$85             ; 03D55E ........ ??????h?
.byte $0B,$A5,$0C,$99,$0A,$03,$A5,$0D             ; 03D566 ........ ????????
.byte $99,$0B,$03,$60,$00,$00,$00,$00             ; 03D56E ........ ???`????
.byte $00,$00,$00,$00,$05,$05,$05,$05             ; 03D576 ........ ????????
.byte $05,$05,$05,$05,$00,$80,$01,$80             ; 03D57E ........ ????????
.byte $41,$86,$01,$86,$41,$82,$01,$82             ; 03D586 ........ A???A???
.byte $41,$86,$01,$86,$41,$84,$01,$84             ; 03D58E ........ A???A???
.byte $41,$86,$01,$86,$41,$80,$01,$80             ; 03D596 ........ A???A???
.byte $41,$88,$01,$88,$41,$80,$01,$80             ; 03D59E ........ A???A???
.byte $41,$8A,$01,$8A,$41,$80,$01,$80             ; 03D5A6 ........ A???A???
.byte $41,$8C,$01,$8C,$41,$80,$01,$80             ; 03D5AE ........ A???A???
.byte $41,$8E,$01,$8E,$41,$80,$01,$80             ; 03D5B6 ........ A???A???
.byte $41,$AE,$01,$AE,$41,$C0,$01,$C2             ; 03D5BE ........ A???A???
.byte $01,$E0,$01,$E2,$01,$C4,$01,$C6             ; 03D5C6 ........ ????????
.byte $01,$E4,$01,$E6,$01,$C8,$01,$CA             ; 03D5CE ........ ????????
.byte $01,$E8,$01,$EA,$01,$CC,$01,$CE             ; 03D5D6 ........ ????????
.byte $01,$EC,$01,$EE,$01,$C2,$41,$C0             ; 03D5DE ........ ??????A?
.byte $41,$E2,$41,$E0,$41,$C6,$41,$C4             ; 03D5E6 ........ A?A?A?A?
.byte $41,$E6,$41,$E4,$41,$CA,$41,$C8             ; 03D5EE ........ A?A?A?A?
.byte $41,$EA,$41,$E8,$41,$CE,$41,$CC             ; 03D5F6 ........ A?A?A?A?
.byte $41,$EE,$41,$EC,$41,$6E,$01,$6E             ; 03D5FE ........ A?A?An?n
.byte $41,$86,$01,$86,$41                         ; 03D607 .....    A???A

  LDA.W EntityYPx,X                                   ; 03D60B BD 9C 0C 
  CMP.B #$08                                      ; 03D60E C9 08 
  BCC.B B_3D635                                   ; 03D610 90 23 
  LDA.W EntityXPx,X                              ; 03D612 BD 46 0B 
  CMP.B #$10                                      ; 03D615 C9 10 
  BCC.B B_3D635                                   ; 03D617 90 1C 
  CMP.B #$F0                                      ; 03D619 C9 F0 
  BCS.B B_3D635                                   ; 03D61B B0 18 
  LDY.W $068E                                     ; 03D61D AC 8E 06 
  LDA.W EntityV30,Y                                   ; 03D620 B9 2E 14 
  STA.W EntityV30,X                                   ; 03D623 9D 2E 14 
  LDA.B #$10                                      ; 03D626 A9 10 
  STA.B $1C                                       ; 03D628 85 1C 
  LDA.B #$10                                      ; 03D62A A9 10 
  STA.B $1D                                       ; 03D62C 85 1D 
  JSL L_AFC2                                      ; 03D62E 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03D632 4C 41 81 
B_3D635:
  STZ.W EntityHeader,X                                   ; 03D635 9E D2 06 
  PHX                                             ; 03D638 DA 
  LDY.W EntityV31,X                                   ; 03D639 BC A0 14 
  JSL L_AEF1                                      ; 03D63C 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03D640 BD A0 14 
  TAX                                             ; 03D643 AA 
  STZ.W StateFlags,X                                   ; 03D644 9E 5E 17 
  ASL                                             ; 03D647 0A 
  ASL                                             ; 03D648 0A 
  TAY                                             ; 03D649 A8 
  LDA.B #$F0                                      ; 03D64A A9 F0 
  BCC.B B_3D653                                   ; 03D64C 90 05 

.byte $99,$09,$04,$80,$03                         ; 03D64F .....    ?????

B_3D653:
  STA.W XexzyTorsoY,Y                             ; 03D653 99 09 03 
  PLX                                             ; 03D656 FA 
  JMP.W AdvanceToNextEntity                                   ; 03D657 4C 41 81 
  LDA.W $0694                                     ; 03D65A AD 94 06 
  STA.W EntityXPx,X                              ; 03D65D 9D 46 0B 
  LDA.W $069D                                     ; 03D660 AD 9D 06 
  BPL.B B_3D674                                   ; 03D663 10 0F 

.byte $38,$AD,$95,$06,$ED,$9D,$06,$9D             ; 03D665 ........ 8???????
.byte $9C,$0C,$9E,$0E,$0D,$80,$12                 ; 03D66E .......  ???????

B_3D674:
  SEC                                             ; 03D674 38 
  LDA.W $0695                                     ; 03D675 AD 95 06 
  SBC.W $069D                                     ; 03D678 ED 9D 06 
  STA.W EntityYPx,X                                   ; 03D67B 9D 9C 0C 
  LDA.W $0696                                     ; 03D67E AD 96 06 
  SBC.B #$00                                      ; 03D681 E9 00 
  STA.W EntityYMovement,X                                   ; 03D683 9D 0E 0D 
  JSL L_3826A                                     ; 03D686 22 6A 82 03 
  LDA.W EntityHeader,X                                   ; 03D68A BD D2 06 
  AND.B #$40                                      ; 03D68D 29 40 
  BEQ.B B_3D6FA                                   ; 03D68F F0 69 
  JSL AdvanceRNG                                     ; 03D691 22 95 CA 0E 
  LDY.W $069C                                     ; 03D695 AC 9C 06 
  CMP.W D_3D704,Y                                 ; 03D698 D9 04 D7 
  BCS.B B_3D6BE                                   ; 03D69B B0 21 
  LDA.B #$72                                      ; 03D69D A9 72 
  STA.W EntityTypeId,X                                   ; 03D69F 9D 44 07 
  JSL AdvanceRNG                                     ; 03D6A2 22 95 CA 0E 
  AND.B #$01                                      ; 03D6A6 29 01 
  STA.W EntityV20,X                                   ; 03D6A8 9D BA 0F 
  LDA.B #$01                                      ; 03D6AB A9 01 
  STA.W EntityV15,X                                   ; 03D6AD 9D 80 0D 
  JSL AdvanceRNG                                     ; 03D6B0 22 95 CA 0E 
  AND.B #$03                                      ; 03D6B4 29 03 
  CLC                                             ; 03D6B6 18 
  ADC.B #$02                                      ; 03D6B7 69 02 
  STA.W EntityV16,X                                   ; 03D6B9 9D F2 0D 
  BRA.B B_3D6FA                                   ; 03D6BC 80 3C 
B_3D6BE:
  JSL AdvanceRNG                                     ; 03D6BE 22 95 CA 0E 
  AND.B #$0F                                      ; 03D6C2 29 0F 
  TAY                                             ; 03D6C4 A8 
  LDA.W D_3D70C,Y                                 ; 03D6C5 B9 0C D7 
  PHA                                             ; 03D6C8 48 
  CMP.B #$0F                                      ; 03D6C9 C9 0F 
  BEQ.B B_3D6D1                                   ; 03D6CB F0 04 
  CMP.B #$10                                      ; 03D6CD C9 10 
  BNE.B B_3D6E2                                   ; 03D6CF D0 11 
B_3D6D1:
  PHX                                             ; 03D6D1 DA 
  REP.B #P_Idx8Bit                                      ; 03D6D2 C2 10 
  LDX.W #$FF2B                                    ; 03D6D4 A2 2B FF 
  LDA.B #$07                                      ; 03D6D7 A9 07 
  JSL Audio_F830F                                     ; 03D6D9 22 0F 83 0F 
  SEP.B #P_Idx8Bit                                      ; 03D6DD E2 10 
  PLX                                             ; 03D6DF FA 
  BRA.B B_3D6F5                                   ; 03D6E0 80 13 
B_3D6E2:
  CMP.B #$11                                      ; 03D6E2 C9 11 
  BNE.B B_3D6F5                                   ; 03D6E4 D0 0F 
  PHX                                             ; 03D6E6 DA 
  REP.B #P_Idx8Bit                                      ; 03D6E7 C2 10 
  LDX.W #$FF25                                    ; 03D6E9 A2 25 FF 
  LDA.B #$07                                      ; 03D6EC A9 07 
  JSL Audio_F830F                                     ; 03D6EE 22 0F 83 0F 
  SEP.B #P_Idx8Bit                                      ; 03D6F2 E2 10 
  PLX                                             ; 03D6F4 FA 
B_3D6F5:
  PLA                                             ; 03D6F5 68 
  JSL L_3823C                                     ; 03D6F6 22 3C 82 03 
B_3D6FA:
  JSR.W L_3DB9D                                   ; 03D6FA 20 9D DB 
  JSL L_DEDA8                                     ; 03D6FD 22 A8 ED 0D 
  JMP.W AdvanceToNextEntity                                   ; 03D701 4C 41 81 

D_3D704:
.byte $40,$60,$80,$A0,$00,$C0,$00,$00             ; 03D704 DDDD.... @`??????
D_3D70C:
.byte $0E,$0F,$10,$0E,$0F,$10,$0E,$0F             ; 03D70C DDDDDDDD ????????
.byte $1A,$1B,$1C,$10,$0E,$0F,$11,$11             ; 03D714 DDDDDDDD ????????

  LDA.W $0694                                     ; 03D71C AD 94 06 
  STA.W EntityXPx,X                              ; 03D71F 9D 46 0B 
  LDA.W $0695                                     ; 03D722 AD 95 06 
  SEC                                             ; 03D725 38 
  LDA.W $0695                                     ; 03D726 AD 95 06 
  SBC.W $069D                                     ; 03D729 ED 9D 06 
  STA.W EntityYPx,X                                   ; 03D72C 9D 9C 0C 
  STZ.W EntityYMovement,X                                   ; 03D72F 9E 0E 0D 
  DEC.W EntityV16,X                                   ; 03D732 DE F2 0D 
  BPL.B B_3D74E                                   ; 03D735 10 17 
  LDA.B #$01                                      ; 03D737 A9 01 
  STA.W EntityV16,X                                   ; 03D739 9D F2 0D 
  JSR.W L_3DAC4                                   ; 03D73C 20 C4 DA 
  DEC.W EntityV15,X                                   ; 03D73F DE 80 0D 
  BNE.B B_3D74E                                   ; 03D742 D0 0A 
  LDA.B #$1E                                      ; 03D744 A9 1E 
  STA.W EntityV15,X                                   ; 03D746 9D 80 0D 
  LDA.B #$72                                      ; 03D749 A9 72 
  STA.W EntityTypeId,X                                   ; 03D74B 9D 44 07 
B_3D74E:
  LDA.B #$10                                      ; 03D74E A9 10 
  STA.B $1C                                       ; 03D750 85 1C 
  LDA.B #$10                                      ; 03D752 A9 10 
  STA.B $1D                                       ; 03D754 85 1D 
  JSL L_AFC2                                      ; 03D756 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03D75A 4C 41 81 
  LDA.B #$20                                      ; 03D75D A9 20 
  STA.W $0699                                     ; 03D75F 8D 99 06 
  LDA.W $0694                                     ; 03D762 AD 94 06 
  STA.W EntityXPx,X                              ; 03D765 9D 46 0B 
  SEC                                             ; 03D768 38 
  LDA.W $0695                                     ; 03D769 AD 95 06 
  SBC.W $069D                                     ; 03D76C ED 9D 06 
  STA.W EntityYPx,X                                   ; 03D76F 9D 9C 0C 
  STZ.W EntityYMovement,X                                   ; 03D772 9E 0E 0D 
  DEC.W EntityV15,X                                   ; 03D775 DE 80 0D 
  BNE.B B_3D78B                                   ; 03D778 D0 11 
  LDA.B #$02                                      ; 03D77A A9 02 
  STA.W EntityV15,X                                   ; 03D77C 9D 80 0D 
  JSL L_DEE00                                     ; 03D77F 22 00 EE 0D 
  DEC.W EntityV16,X                                   ; 03D783 DE F2 0D 
  BNE.B B_3D78B                                   ; 03D786 D0 03 
  STZ.W EntityTypeId,X                                   ; 03D788 9E 44 07 
B_3D78B:
  JSL L_3826A                                     ; 03D78B 22 6A 82 03 
  LDA.W EntityHeader,X                                   ; 03D78F BD D2 06 
  AND.B #$40                                      ; 03D792 29 40 
  BEQ.B B_3D7A4                                   ; 03D794 F0 0E 
  JSL AdvanceRNG                                     ; 03D796 22 95 CA 0E 
  AND.B #$0F                                      ; 03D79A 29 0F 
  TAY                                             ; 03D79C A8 
  LDA.W D_3D7AA,Y                                 ; 03D79D B9 AA D7 
  JSL L_3823C                                     ; 03D7A0 22 3C 82 03 
B_3D7A4:
  JSR.W L_3DB9D                                   ; 03D7A4 20 9D DB 
  JMP.W AdvanceToNextEntity                                   ; 03D7A7 4C 41 81 

D_3D7AA:
.byte $0E,$0F,$10,$0E,$0F,$10,$0E,$0F             ; 03D7AA ........ ????????
.byte $1A,$1B,$1C,$10,$0E,$0F,$11,$11             ; 03D7B2 .....DD. ????????

  DEC.W EntityV15,X                                   ; 03D7BA DE 80 0D 
  BNE.B B_3D7DC                                   ; 03D7BD D0 1D 
  DEC.W EntityV16,X                                   ; 03D7BF DE F2 0D 
  BNE.B B_3D7CB                                   ; 03D7C2 D0 07 
  LDA.B #$6F                                      ; 03D7C4 A9 6F 
  STA.W EntityTypeId,X                                   ; 03D7C6 9D 44 07 
  BRA.B B_3D7DC                                   ; 03D7C9 80 11 
B_3D7CB:
  JSL L_DEFA8                                     ; 03D7CB 22 A8 EF 0D 
  LDA.B #$09                                      ; 03D7CF A9 09 
  STA.W EntityV15,X                                   ; 03D7D1 9D 80 0D 
  STZ.W EntityV16,X                                   ; 03D7D4 9E F2 0D 
  LDA.B #$70                                      ; 03D7D7 A9 70 
  STA.W EntityTypeId,X                                   ; 03D7D9 9D 44 07 
B_3D7DC:
  LDA.W $0694                                     ; 03D7DC AD 94 06 
  STA.W EntityXPx,X                              ; 03D7DF 9D 46 0B 
  SEC                                             ; 03D7E2 38 
  LDA.W $0695                                     ; 03D7E3 AD 95 06 
  SBC.W $069D                                     ; 03D7E6 ED 9D 06 
  STA.W EntityYPx,X                                   ; 03D7E9 9D 9C 0C 
  STZ.W EntityYMovement,X                                   ; 03D7EC 9E 0E 0D 
  JSR.W L_3DB9D                                   ; 03D7EF 20 9D DB 
  JSL L_DEDA8                                     ; 03D7F2 22 A8 ED 0D 
  JMP.W AdvanceToNextEntity                                   ; 03D7F6 4C 41 81 
  LDA.W $0694                                     ; 03D7F9 AD 94 06 
  STA.W EntityXPx,X                              ; 03D7FC 9D 46 0B 
  LDA.W $0695                                     ; 03D7FF AD 95 06 
  STA.W EntityYPx,X                                   ; 03D802 9D 9C 0C 
  LDA.W $069C                                     ; 03D805 AD 9C 06 
  BEQ.B B_3D814                                   ; 03D808 F0 0A 
  LDA.B #$75                                      ; 03D80A A9 75 
  STA.W EntityTypeId,X                                   ; 03D80C 9D 44 07 
  LDA.B #$01                                      ; 03D80F A9 01 
  STA.W EntityV15,X                                   ; 03D811 9D 80 0D 
B_3D814:
  LDA.W EntityV25,X                                   ; 03D814 BD F4 11 
  PHA                                             ; 03D817 48 
  JSL L_3826A                                     ; 03D818 22 6A 82 03 
  PLA                                             ; 03D81C 68 
  CMP.W EntityV25,X                                   ; 03D81D DD F4 11 
  BEQ.B B_3D832                                   ; 03D820 F0 10 
  LDA.W EntityV25,X                                   ; 03D822 BD F4 11 
  CMP.B #$04                                      ; 03D825 C9 04 
  BNE.B B_3D82E                                   ; 03D827 D0 05 
  LDA.B #$19                                      ; 03D829 A9 19 
  STA.W $05D7                                     ; 03D82B 8D D7 05 
B_3D82E:
  JSL L_DF118                                     ; 03D82E 22 18 F1 0D 
B_3D832:
  JMP.W AdvanceToNextEntity                                   ; 03D832 4C 41 81 
  LDA.W $0694                                     ; 03D835 AD 94 06 
  STA.W EntityXPx,X                              ; 03D838 9D 46 0B 
  LDA.W $0695                                     ; 03D83B AD 95 06 
  STA.W EntityYPx,X                                   ; 03D83E 9D 9C 0C 
  LDA.W $069C                                     ; 03D841 AD 9C 06 
  CMP.B #$02                                      ; 03D844 C9 02 
  BCC.B B_3D852                                   ; 03D846 90 0A 
  LDA.B #$83                                      ; 03D848 A9 83 
  STA.W EntityTypeId,X                                   ; 03D84A 9D 44 07 
  LDA.B #$01                                      ; 03D84D A9 01 
  STA.W EntityV15,X                                   ; 03D84F 9D 80 0D 
B_3D852:
  LDA.W EntityV25,X                                   ; 03D852 BD F4 11 
  PHA                                             ; 03D855 48 
  JSL L_3826A                                     ; 03D856 22 6A 82 03 
  PLA                                             ; 03D85A 68 
  CMP.W EntityV25,X                                   ; 03D85B DD F4 11 
  BEQ.B B_3D870                                   ; 03D85E F0 10 
  LDA.W EntityV25,X                                   ; 03D860 BD F4 11 
  CMP.B #$04                                      ; 03D863 C9 04 
  BNE.B B_3D86C                                   ; 03D865 D0 05 
  LDA.B #$19                                      ; 03D867 A9 19 
  STA.W $05D7                                     ; 03D869 8D D7 05 
B_3D86C:
  JSL L_DF1CA                                     ; 03D86C 22 CA F1 0D 
B_3D870:
  JMP.W AdvanceToNextEntity                                   ; 03D870 4C 41 81 
  LDA.W EntityHeader,X                                   ; 03D873 BD D2 06 
  AND.B #$40                                      ; 03D876 29 40 
  BEQ.B B_3D89E                                   ; 03D878 F0 24 
  LDA.W EntityV26,X                                   ; 03D87A BD 66 12 
  CMP.B #$1E                                      ; 03D87D C9 1E 
  BNE.B B_3D898                                   ; 03D87F D0 17 
  LDA.B #$82                                      ; 03D881 A9 82 
  STA.W EntityTypeId,X                                   ; 03D883 9D 44 07 
  LDA.B #$01                                      ; 03D886 A9 01 
  STA.W EntityV15,X                                   ; 03D888 9D 80 0D 
  LDA.B #$04                                      ; 03D88B A9 04 
  STA.W EntityV16,X                                   ; 03D88D 9D F2 0D 
  LDA.B #$1F                                      ; 03D890 A9 1F 
  JSL L_3823C                                     ; 03D892 22 3C 82 03 
  BRA.B B_3D89E                                   ; 03D896 80 06 
B_3D898:
  LDA.B #$1E                                      ; 03D898 A9 1E 
  JSL L_3823C                                     ; 03D89A 22 3C 82 03 
B_3D89E:
  DEC.W EntityV15,X                                   ; 03D89E DE 80 0D 
  BNE.B B_3D8AD                                   ; 03D8A1 D0 0A 
  LDA.B #$07                                      ; 03D8A3 A9 07 
  STA.W EntityV15,X                                   ; 03D8A5 9D 80 0D 
  LDY.B #$00                                      ; 03D8A8 A0 00 
  JSR.W L_3DA1E                                   ; 03D8AA 20 1E DA 
B_3D8AD:
  LDA.W $0694                                     ; 03D8AD AD 94 06 
  STA.W EntityXPx,X                              ; 03D8B0 9D 46 0B 
  LDA.W $0695                                     ; 03D8B3 AD 95 06 
  STA.W EntityYPx,X                                   ; 03D8B6 9D 9C 0C 
  LDA.W EntityV25,X                                   ; 03D8B9 BD F4 11 
  PHA                                             ; 03D8BC 48 
  JSL L_3826A                                     ; 03D8BD 22 6A 82 03 
  PLA                                             ; 03D8C1 68 
  CMP.W EntityV25,X                                   ; 03D8C2 DD F4 11 
  BEQ.B B_3D8D7                                   ; 03D8C5 F0 10 
  LDA.W EntityV25,X                                   ; 03D8C7 BD F4 11 
  CMP.B #$04                                      ; 03D8CA C9 04 
  BNE.B B_3D8D3                                   ; 03D8CC D0 05 
  LDA.B #$19                                      ; 03D8CE A9 19 
  STA.W $05D7                                     ; 03D8D0 8D D7 05 
B_3D8D3:
  JSL L_DF118                                     ; 03D8D3 22 18 F1 0D 
B_3D8D7:
  JMP.W AdvanceToNextEntity                                   ; 03D8D7 4C 41 81 
  LDA.W EntityYPx,X                                   ; 03D8DA BD 9C 0C 
  CMP.B #$E6                                      ; 03D8DD C9 E6 
  BCC.B B_3D8E4                                   ; 03D8DF 90 03 
  JMP.W D_3D984                                   ; 03D8E1 4C 84 D9 
B_3D8E4:
  LDA.W EntityXPx,X                              ; 03D8E4 BD 46 0B 
  CMP.B #$F4                                      ; 03D8E7 C9 F4 
  BCC.B B_3D8EE                                   ; 03D8E9 90 03 
  JMP.W D_3D984                                   ; 03D8EB 4C 84 D9 
B_3D8EE:
  CMP.B #$0D                                      ; 03D8EE C9 0D 
  BCS.B B_3D8F5                                   ; 03D8F0 B0 03 
  JMP.W D_3D984                                   ; 03D8F2 4C 84 D9 
B_3D8F5:
  DEC.W EntityV15,X                                   ; 03D8F5 DE 80 0D 
  BNE.B B_3D975                                   ; 03D8F8 D0 7B 
  LDA.B #$77                                      ; 03D8FA A9 77 
  STA.W EntityTypeId,X                                   ; 03D8FC 9D 44 07 
  LDA.B #$08                                      ; 03D8FF A9 08 
  STA.W EntityV3,X                                   ; 03D901 9D 28 08 
  SEC                                             ; 03D904 38 
  LDA.W EntityXPx,X                              ; 03D905 BD 46 0B 
  SBC.B #$02                                      ; 03D908 E9 02 
  BCS.B B_3D90E                                   ; 03D90A B0 02 

.byte $A9,$00                                     ; 03D90D ..       ??

B_3D90E:
  STA.W EntityV32,X                                   ; 03D90E 9D 16 15 
  CLC                                             ; 03D911 18 
  LDA.W EntityXPx,X                              ; 03D912 BD 46 0B 
  ADC.B #$02                                      ; 03D915 69 02 
  BCC.B B_3D91B                                   ; 03D917 90 02 

.byte $A9,$FF                                     ; 03D91A ..       ??

B_3D91B:
  STA.W EntityV33,X                                   ; 03D91B 9D 88 15 
  SEC                                             ; 03D91E 38 
  LDA.W EntityYPx,X                                   ; 03D91F BD 9C 0C 
  SBC.B #$02                                      ; 03D922 E9 02 
  BCS.B B_3D928                                   ; 03D924 B0 02 

.byte $A9,$00                                     ; 03D927 ..       ??

B_3D928:
  STA.W EntityV34,X                                   ; 03D928 9D FA 15 
  CLC                                             ; 03D92B 18 
  LDA.W EntityYPx,X                                   ; 03D92C BD 9C 0C 
  ADC.B #$02                                      ; 03D92F 69 02 
  BCC.B B_3D935                                   ; 03D931 90 02 

.byte $A9,$FF                                     ; 03D934 ..       ??

B_3D935:
  STA.W EntityV35,X                                   ; 03D935 9D 6C 16 
  LDA.B #$8E                                      ; 03D938 A9 8E 
  STA.W EntityV29,X                                   ; 03D93A 9D BC 13 
  LDA.B #$32                                      ; 03D93D A9 32 
  STA.W EntityV30,X                                   ; 03D93F 9D 2E 14 
  LDA.B #$04                                      ; 03D942 A9 04 
  STA.W EntityV15,X                                   ; 03D944 9D 80 0D 
  STZ.W EntityXSubPxSpeed,X                                   ; 03D947 9E 0C 09 
  STZ.W EntityXPxSpeed,X                                   ; 03D94A 9E 7E 09 
  STZ.W EntityYSubPxSpeed,X                                   ; 03D94D 9E F0 09 
  STZ.W EntityYPxSpeed,X                                   ; 03D950 9E 62 0A 
  JSL AdvanceRNG                                     ; 03D953 22 95 CA 0E 
  AND.B #$07                                      ; 03D957 29 07 
  TAY                                             ; 03D959 A8 
  CLC                                             ; 03D95A 18 
  LDA.W EntityXPx,X                              ; 03D95B BD 46 0B 
  ADC.W D_3D9A9,Y                                 ; 03D95E 79 A9 D9 
  STA.W EntityXPx,X                              ; 03D961 9D 46 0B 
  JSL AdvanceRNG                                     ; 03D964 22 95 CA 0E 
  AND.B #$07                                      ; 03D968 29 07 
  TAY                                             ; 03D96A A8 
  CLC                                             ; 03D96B 18 
  LDA.W EntityYPx,X                                   ; 03D96C BD 9C 0C 
  ADC.W D_3D9A9,Y                                 ; 03D96F 79 A9 D9 
  STA.W EntityYPx,X                                   ; 03D972 9D 9C 0C 
B_3D975:
  LDA.B #$08                                      ; 03D975 A9 08 
  STA.B $1C                                       ; 03D977 85 1C 
  LDA.B #$08                                      ; 03D979 A9 08 
  STA.B $1D                                       ; 03D97B 85 1D 
  JSL L_AFC2                                      ; 03D97D 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03D981 4C 41 81 
D_3D984:
  STZ.W EntityHeader,X                                   ; 03D984 9E D2 06 
  PHX                                             ; 03D987 DA 
  LDY.W EntityV31,X                                   ; 03D988 BC A0 14 
  JSL L_AEF1                                      ; 03D98B 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03D98F BD A0 14 
  TAX                                             ; 03D992 AA 
  STZ.W StateFlags,X                                   ; 03D993 9E 5E 17 
  ASL                                             ; 03D996 0A 
  ASL                                             ; 03D997 0A 
  TAY                                             ; 03D998 A8 
  LDA.B #$F0                                      ; 03D999 A9 F0 
  BCC.B B_3D9A2                                   ; 03D99B 90 05 

.byte $99,$09,$04,$80,$03                         ; 03D99E .....    ?????

B_3D9A2:
  STA.W XexzyTorsoY,Y                             ; 03D9A2 99 09 03 
  PLX                                             ; 03D9A5 FA 
  JMP.W AdvanceToNextEntity                                   ; 03D9A6 4C 41 81 

D_3D9A9:
.byte $00,$01,$02,$00,$00,$FF,$FE,$00             ; 03D9A9 DDDDDDDD ????????

  SEC                                             ; 03D9B1 38 
  LDA.W EntityXPx,X                              ; 03D9B2 BD 46 0B 
  SBC.B #$02                                      ; 03D9B5 E9 02 
  BCS.B B_3D9BB                                   ; 03D9B7 B0 02 

.byte $A9,$00                                     ; 03D9BA ..       ??

B_3D9BB:
  STA.W EntityV32,X                                   ; 03D9BB 9D 16 15 
  CLC                                             ; 03D9BE 18 
  LDA.W EntityXPx,X                              ; 03D9BF BD 46 0B 
  ADC.B #$02                                      ; 03D9C2 69 02 
  BCC.B B_3D9C8                                   ; 03D9C4 90 02 

.byte $A9,$FF                                     ; 03D9C7 ..       ??

B_3D9C8:
  STA.W EntityV33,X                                   ; 03D9C8 9D 88 15 
  SEC                                             ; 03D9CB 38 
  LDA.W EntityYPx,X                                   ; 03D9CC BD 9C 0C 
  SBC.B #$02                                      ; 03D9CF E9 02 
  BCS.B B_3D9D5                                   ; 03D9D1 B0 02 

.byte $A9,$00                                     ; 03D9D4 ..       ??

B_3D9D5:
  STA.W EntityV34,X                                   ; 03D9D5 9D FA 15 
  CLC                                             ; 03D9D8 18 
  LDA.W EntityYPx,X                                   ; 03D9D9 BD 9C 0C 
  ADC.B #$02                                      ; 03D9DC 69 02 
  BCC.B B_3D9E2                                   ; 03D9DE 90 02 

.byte $A9,$FF                                     ; 03D9E1 ..       ??

B_3D9E2:
  STA.W EntityV35,X                                   ; 03D9E2 9D 6C 16 
  DEC.W EntityV15,X                                   ; 03D9E5 DE 80 0D 
  BEQ.B B_3D9F9                                   ; 03D9E8 F0 0F 
  LDA.B #$08                                      ; 03D9EA A9 08 
  STA.B $1C                                       ; 03D9EC 85 1C 
  LDA.B #$08                                      ; 03D9EE A9 08 
  STA.B $1D                                       ; 03D9F0 85 1D 
  JSL L_AFC2                                      ; 03D9F2 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03D9F6 4C 41 81 
B_3D9F9:
  STZ.W EntityHeader,X                                   ; 03D9F9 9E D2 06 
  PHX                                             ; 03D9FC DA 
  LDY.W EntityV31,X                                   ; 03D9FD BC A0 14 
  JSL L_AEF1                                      ; 03DA00 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03DA04 BD A0 14 
  TAX                                             ; 03DA07 AA 
  STZ.W StateFlags,X                                   ; 03DA08 9E 5E 17 
  ASL                                             ; 03DA0B 0A 
  ASL                                             ; 03DA0C 0A 
  TAY                                             ; 03DA0D A8 
  LDA.B #$F0                                      ; 03DA0E A9 F0 
  BCC.B B_3DA17                                   ; 03DA10 90 05 

.byte $99,$09,$04,$80,$03                         ; 03DA13 .....    ?????

B_3DA17:
  STA.W XexzyTorsoY,Y                             ; 03DA17 99 09 03 
  PLX                                             ; 03DA1A FA 
  JMP.W AdvanceToNextEntity                                   ; 03DA1B 4C 41 81 

L_3DA1E:
  PHX                                             ; 03DA1E DA 
  CLC                                             ; 03DA1F 18 
  LDA.W EntityXPx,X                              ; 03DA20 BD 46 0B 
  ADC.W D_3DABA,Y                                 ; 03DA23 79 BA DA 
  STA.B $04                                       ; 03DA26 85 04 
  SEC                                             ; 03DA28 38 
  LDA.W EntityYPx,X                                   ; 03DA29 BD 9C 0C 
  SBC.B #$0D                                      ; 03DA2C E9 0D 
  STA.B $05                                       ; 03DA2E 85 05 
  JSL AdvanceRNG                                     ; 03DA30 22 95 CA 0E 
  AND.B #$07                                      ; 03DA34 29 07 
  TAY                                             ; 03DA36 A8 
  CLC                                             ; 03DA37 18 
  LDA.B $04                                       ; 03DA38 A5 04 
  ADC.W D_3DABC,Y                                 ; 03DA3A 79 BC DA 
  STA.B $04                                       ; 03DA3D 85 04 
  JSL AdvanceRNG                                     ; 03DA3F 22 95 CA 0E 
  AND.B #$07                                      ; 03DA43 29 07 
  TAY                                             ; 03DA45 A8 
  CLC                                             ; 03DA46 18 
  LDA.B $05                                       ; 03DA47 A5 05 
  ADC.W D_3DABC,Y                                 ; 03DA49 79 BC DA 
  STA.B $05                                       ; 03DA4C 85 05 
  JSL FindEmptyEntitySlot                                     ; 03DA4E 22 F3 80 03 
  BEQ.B B_3DA57                                   ; 03DA52 F0 03 

.byte $4C,$B8,$DA                                 ; 03DA55 ...      L??

B_3DA57:
  JSL ClearEntitySlotData                                     ; 03DA57 22 94 80 03 
  LDA.B #$01                                      ; 03DA5B A9 01 
  STA.W EntityHeader,X                                   ; 03DA5D 9D D2 06 
  LDA.B #$09                                      ; 03DA60 A9 09 
  STA.W EntityTypeId,X                                   ; 03DA62 9D 44 07 
  LDA.B #$00                                      ; 03DA65 A9 00 
  STA.W EntityV3,X                                   ; 03DA67 9D 28 08 
  LDA.B #$20                                      ; 03DA6A A9 20 
  STA.W EntityV29,X                                   ; 03DA6C 9D BC 13 
  LDA.B #$32                                      ; 03DA6F A9 32 
  STA.W EntityV30,X                                   ; 03DA71 9D 2E 14 
  LDA.B $04                                       ; 03DA74 A5 04 
  STA.W EntityXPx,X                              ; 03DA76 9D 46 0B 
  LDA.B $05                                       ; 03DA79 A5 05 
  STA.W EntityYPx,X                                   ; 03DA7B 9D 9C 0C 
  LDA.B #$04                                      ; 03DA7E A9 04 
  STA.W EntityV28,X                                   ; 03DA80 9D 4A 13 
  STZ.W EntityV27,X                                   ; 03DA83 9E D8 12 
  JSL L_AEBC                                      ; 03DA86 22 BC AE 00 
  TYA                                             ; 03DA8A 98 
  STA.W EntityV31,X                                   ; 03DA8B 9D A0 14 
  LDA.B #$01                                      ; 03DA8E A9 01 
  STA.W StateFlags,Y                                   ; 03DA90 99 5E 17 
  JSL L_AEF1                                      ; 03DA93 22 F1 AE 00 
  LDA.B #$08                                      ; 03DA97 A9 08 
  STA.B $1C                                       ; 03DA99 85 1C 
  LDA.B #$08                                      ; 03DA9B A9 08 
  STA.B $1D                                       ; 03DA9D 85 1D 
  JSL L_AFC2                                      ; 03DA9F 22 C2 AF 00 
  JSL AdvanceRNG                                     ; 03DAA3 22 95 CA 0E 
  AND.B #$01                                      ; 03DAA7 29 01 
  BNE.B B_3DAB8                                   ; 03DAA9 D0 0D 
  REP.B #P_Idx8Bit                                      ; 03DAAB C2 10 
  LDA.B #$07                                      ; 03DAAD A9 07 
  LDX.W #$FF06                                    ; 03DAAF A2 06 FF 
  JSL Audio_F830F                                     ; 03DAB2 22 0F 83 0F 
  SEP.B #P_Idx8Bit                                      ; 03DAB6 E2 10 
B_3DAB8:
  PLX                                             ; 03DAB8 FA 
  RTS                                             ; 03DAB9 60 


D_3DABA:
.byte $E7,$19                                     ; 03DABB DD       ??
D_3DABC:
.byte $00,$FE,$02,$FD,$03,$FC,$04,$00             ; 03DABC DDDDDDDD ????????


L_3DAC4:
  PHX                                             ; 03DAC4 DA 
  LDA.W $069E                                     ; 03DAC5 AD 9E 06 
  ASL                                             ; 03DAC8 0A 
  ASL                                             ; 03DAC9 0A 
  ASL                                             ; 03DACA 0A 
  CLC                                             ; 03DACB 18 
  ADC.W $068F                                     ; 03DACC 6D 8F 06 
  TAY                                             ; 03DACF A8 
  CLC                                             ; 03DAD0 18 
  LDA.W EntityXPx,X                              ; 03DAD1 BD 46 0B 
  ADC.W D_3DB6F,Y                                 ; 03DAD4 79 6F DB 
  STA.B $04                                       ; 03DAD7 85 04 
  CLC                                             ; 03DAD9 18 
  LDA.W EntityYPx,X                                   ; 03DADA BD 9C 0C 
  ADC.W D_3DB7F,Y                                 ; 03DADD 79 7F DB 
  STA.B $05                                       ; 03DAE0 85 05 
  JSL FindEmptyEntitySlot                                     ; 03DAE2 22 F3 80 03 
  BEQ.B B_3DAEB                                   ; 03DAE6 F0 03 

.byte $4C,$57,$DB                                 ; 03DAE9 ...      LW?

B_3DAEB:
  JSL ClearEntitySlotData                                     ; 03DAEB 22 94 80 03 
  LDA.W $068F                                     ; 03DAEF AD 8F 06 
  ASL                                             ; 03DAF2 0A 
  TAY                                             ; 03DAF3 A8 
  LDA.W D_3DB8F,Y                                 ; 03DAF4 B9 8F DB 
  STA.W EntityV29,X                                   ; 03DAF7 9D BC 13 
  LDA.W D_3DB90,Y                                 ; 03DAFA B9 90 DB 
  STA.W EntityV30,X                                   ; 03DAFD 9D 2E 14 
  LDA.B #$01                                      ; 03DB00 A9 01 
  STA.W EntityHeader,X                                   ; 03DB02 9D D2 06 
  LDA.B #$76                                      ; 03DB05 A9 76 
  STA.W EntityTypeId,X                                   ; 03DB07 9D 44 07 
  LDA.B #$00                                      ; 03DB0A A9 00 
  STA.W EntityV3,X                                   ; 03DB0C 9D 28 08 
  LDY.W $068F                                     ; 03DB0F AC 8F 06 
  LDA.W D_3DB68,Y                                 ; 03DB12 B9 68 DB 
  STA.W EntityV15,X                                   ; 03DB15 9D 80 0D 
  LDA.B $04                                       ; 03DB18 A5 04 
  STA.W EntityXPx,X                              ; 03DB1A 9D 46 0B 
  LDA.B $05                                       ; 03DB1D A5 05 
  STA.W EntityYPx,X                                   ; 03DB1F 9D 9C 0C 
  LDA.W $0690                                     ; 03DB22 AD 90 06 
  STA.W EntityXSubPxSpeed,X                                   ; 03DB25 9D 0C 09 
  LDA.W $0691                                     ; 03DB28 AD 91 06 
  STA.W EntityXPxSpeed,X                                   ; 03DB2B 9D 7E 09 
  LDA.W $0692                                     ; 03DB2E AD 92 06 
  STA.W EntityYSubPxSpeed,X                                   ; 03DB31 9D F0 09 
  LDA.W $0693                                     ; 03DB34 AD 93 06 
  STA.W EntityYPxSpeed,X                                   ; 03DB37 9D 62 0A 
  JSL L_AEBC                                      ; 03DB3A 22 BC AE 00 
  TYA                                             ; 03DB3E 98 
  STA.W EntityV31,X                                   ; 03DB3F 9D A0 14 
  LDA.B #$01                                      ; 03DB42 A9 01 
  STA.W StateFlags,Y                                   ; 03DB44 99 5E 17 
  JSL L_AEF1                                      ; 03DB47 22 F1 AE 00 
  LDA.B #$08                                      ; 03DB4B A9 08 
  STA.B $1C                                       ; 03DB4D 85 1C 
  LDA.B #$08                                      ; 03DB4F A9 08 
  STA.B $1D                                       ; 03DB51 85 1D 
  JSL L_AFC2                                      ; 03DB53 22 C2 AF 00 
  REP.B #P_Idx8Bit                                      ; 03DB57 C2 10 
  SEP.B #P_Acc8Bit                                      ; 03DB59 E2 20 
  LDA.B #$07                                      ; 03DB5B A9 07 
  LDX.W #$FF11                                    ; 03DB5D A2 11 FF 
  JSL Audio_F830F                                     ; 03DB60 22 0F 83 0F 
  SEP.B #P_Idx8Bit | P_Acc8Bit                                      ; 03DB64 E2 30 
  PLX                                             ; 03DB66 FA 
  RTS                                             ; 03DB67 60 


D_3DB68:
.byte $0F,$12,$14,$16,$14,$12,$0F                 ; 03DB69 DD.DDDD  ???????
D_3DB6F:
.byte $F4,$F5,$FB,$00,$05,$0B,$0C,$00             ; 03DB6F DD.DDDD. ????????
.byte $F2,$F5,$FB,$00,$05,$0B,$0E,$00             ; 03DB77 ........ ????????
D_3DB7F:
.byte $FF,$04,$05,$04,$05,$04,$FF,$00             ; 03DB7F DD.DDDD. ????????
.byte $04,$06,$08,$08,$08,$06,$04,$00             ; 03DB87 ........ ????????
D_3DB8F:
.byte $8E                                         ; 03DB90 D        ?
D_3DB90:
.byte $73,$8C,$73,$8A,$73,$88,$33,$8A             ; 03DB90 DDD..DDD s?s?s?3?
.byte $33,$8C,$33,$8E,$33                         ; 03DB99 DDDDD    3?3?3


L_3DB9D:
  LDA.W EntityV25,X                                   ; 03DB9D BD F4 11 
  TAY                                             ; 03DBA0 A8 
  LDA.W EntityV30,X                                   ; 03DBA1 BD 2E 14 
  AND.B #$BF                                      ; 03DBA4 29 BF 
  ORA.W D_3DBDF,Y                                 ; 03DBA6 19 DF DB 
  STA.W EntityV30,X                                   ; 03DBA9 9D 2E 14 
  LDA.W $069E                                     ; 03DBAC AD 9E 06 
  ASL                                             ; 03DBAF 0A 
  ASL                                             ; 03DBB0 0A 
  ASL                                             ; 03DBB1 0A 
  ASL                                             ; 03DBB2 0A 
  ASL                                             ; 03DBB3 0A 
  STA.B $04                                       ; 03DBB4 85 04 
  LDA.W EntityV25,X                                   ; 03DBB6 BD F4 11 
  ASL                                             ; 03DBB9 0A 
  CLC                                             ; 03DBBA 18 
  ADC.B $04                                       ; 03DBBB 65 04 
  TAY                                             ; 03DBBD A8 
  LDA.W D_3DBE9,Y                                 ; 03DBBE B9 E9 DB 
  STA.W $1AB5                                     ; 03DBC1 8D B5 1A 
  LDA.W D_3DBEA,Y                                 ; 03DBC4 B9 EA DB 
  STA.W $1AB6                                     ; 03DBC7 8D B6 1A 
  REP.B #P_Idx8Bit                                      ; 03DBCA C2 10 
  LDY.W #$1801                                    ; 03DBCC A0 01 18 
  STY.W $1AB3                                     ; 03DBCF 8C B3 1A 
  LDA.B #$0E                                      ; 03DBD2 A9 0E 
  STA.W $1AB7                                     ; 03DBD4 8D B7 1A 
  LDA.B #$01                                      ; 03DBD7 A9 01 
  STA.W $1AB2                                     ; 03DBD9 8D B2 1A 
  SEP.B #P_Idx8Bit                                      ; 03DBDC E2 10 
  RTS                                             ; 03DBDE 60 


D_3DBDF:
.byte $00,$00,$00,$00,$00,$00,$00,$40             ; 03DBDF DDDDDDDD ???????@
.byte $40,$40                                     ; 03DBE8 DD       @@
D_3DBE9:
.byte $00                                         ; 03DBEA D        ?
D_3DBEA:
.byte $98,$00,$9A,$00,$9C,$00,$9E,$00             ; 03DBEA DDDDDDDD ????????
.byte $A0,$00,$A2,$00,$A4,$00,$A0,$00             ; 03DBF2 DDDDDDDD ????????
.byte $A2,$00,$A4,$00,$00,$00,$00,$00             ; 03DBFA DDD..... ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03DC02 ........ ????????
.byte $A6,$00,$A8,$00,$AA,$00,$AC,$00             ; 03DC0A ........ ????????
.byte $AE,$00,$B0,$00,$B2,$00,$AE,$00             ; 03DC12 ........ ????????
.byte $B0,$00,$B2,$00,$00,$00,$00,$00             ; 03DC1A ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00                 ; 03DC23 .......  ???????

  JSL L_CFDAC                                     ; 03DC29 22 AC FD 0C 
  LDA.W $0696                                     ; 03DC2D AD 96 06 
  BNE.B B_3DC50                                   ; 03DC30 D0 1E 
  LDA.W $0695                                     ; 03DC32 AD 95 06 
  CMP.B #$10                                      ; 03DC35 C9 10 
  BNE.B B_3DC41                                   ; 03DC37 D0 08 
  LDA.B #$01                                      ; 03DC39 A9 01 
  STA.W $1873                                     ; 03DC3B 8D 73 18 
  STZ.W $05DE                                     ; 03DC3E 9C DE 05 
B_3DC41:
  LDA.W $0695                                     ; 03DC41 AD 95 06 
  CMP.B #$60                                      ; 03DC44 C9 60 
  BCC.B B_3DC50                                   ; 03DC46 90 08 
  LDA.B #$79                                      ; 03DC48 A9 79 
  STA.W EntityTypeId,X                                   ; 03DC4A 9D 44 07 
  STZ.W EntityYSubPxSpeed,X                                   ; 03DC4D 9E F0 09 
B_3DC50:
  JSR.W L_3DFBF                                   ; 03DC50 20 BF DF 
  JSR.W L_3E180                                   ; 03DC53 20 80 E1 
  JSR.W L_3E132                                   ; 03DC56 20 32 E1 
  JMP.W AdvanceToNextEntity                                   ; 03DC59 4C 41 81 

  JSL L_CFB81                                     ; 03DC5C 22 81 FB 0C 
  DEC.W EntityV15,X                                   ; 03DC60 DE 80 0D 
  BNE.B B_3DC81                                   ; 03DC63 D0 1C 
  JSL AdvanceRNG                                     ; 03DC65 22 95 CA 0E 
  AND.B #$0F                                      ; 03DC69 29 0F 
  TAY                                             ; 03DC6B A8 
  LDA.W D_3DC97,Y                                 ; 03DC6C B9 97 DC 
  BEQ.B B_3DC7A                                   ; 03DC6F F0 09 
  JSR.W L_3E21C                                   ; 03DC71 20 1C E2 
  JSL L_CFD26                                     ; 03DC74 22 26 FD 0C 
  BRA.B B_3DC81                                   ; 03DC78 80 07 
B_3DC7A:
  JSR.W L_3E282                                   ; 03DC7A 20 82 E2 
  JSL L_CFD26                                     ; 03DC7D 22 26 FD 0C 
B_3DC81:
  JSR.W L_3E1A7                                   ; 03DC81 20 A7 E1 
  JSR.W L_3DF64                                   ; 03DC84 20 64 DF 
  JSL L_CFDAC                                     ; 03DC87 22 AC FD 0C 
  JSR.W L_3DFBF                                   ; 03DC8B 20 BF DF 
  JSR.W L_3E180                                   ; 03DC8E 20 80 E1 
  JSR.W L_3E132                                   ; 03DC91 20 32 E1 
  JMP.W AdvanceToNextEntity                                   ; 03DC94 4C 41 81 

D_3DC97:
.byte $01,$00,$00,$01,$00,$01,$00,$00             ; 03DC97 DDDDDDDD ????????
.byte $00,$00,$01,$00,$01,$00,$00,$01             ; 03DC9F DDDDDDDD ????????

  JSL L_CFB81                                     ; 03DCA7 22 81 FB 0C 
  LDA.W EntityYPxSpeed,X                                   ; 03DCAB BD 62 0A 
  BPL.B B_3DCD6                                   ; 03DCAE 10 26 
  LDA.B #$2E                                      ; 03DCB0 A9 2E 
  CMP.W EntityYPx,X                                   ; 03DCB2 DD 9C 0C 
  BCC.B B_3DCD4                                   ; 03DCB5 90 1D 
  STA.W EntityYPx,X                                   ; 03DCB7 9D 9C 0C 
  JSL AdvanceRNG                                     ; 03DCBA 22 95 CA 0E 
  AND.B #$01                                      ; 03DCBE 29 01 
  BEQ.B B_3DCCE                                   ; 03DCC0 F0 0C 
  LDA.B #$40                                      ; 03DCC2 A9 40 
  STA.W EntityYSubPxSpeed,X                                   ; 03DCC4 9D F0 09 
  LDA.B #$00                                      ; 03DCC7 A9 00 
  STA.W EntityYPxSpeed,X                                   ; 03DCC9 9D 62 0A 
  BRA.B B_3DCFA                                   ; 03DCCC 80 2C 
B_3DCCE:
  STZ.W EntityYSubPxSpeed,X                                   ; 03DCCE 9E F0 09 
  STZ.W EntityYPxSpeed,X                                   ; 03DCD1 9E 62 0A 
B_3DCD4:
  BRA.B B_3DCFA                                   ; 03DCD4 80 24 
B_3DCD6:
  LDA.B #$B4                                      ; 03DCD6 A9 B4 
  CMP.W EntityYPx,X                                   ; 03DCD8 DD 9C 0C 
  BCS.B B_3DCFA                                   ; 03DCDB B0 1D 
  STA.W EntityYPx,X                                   ; 03DCDD 9D 9C 0C 
  JSL AdvanceRNG                                     ; 03DCE0 22 95 CA 0E 
  AND.B #$01                                      ; 03DCE4 29 01 
  BEQ.B B_3DCF4                                   ; 03DCE6 F0 0C 
  LDA.B #$C0                                      ; 03DCE8 A9 C0 
  STA.W EntityYSubPxSpeed,X                                   ; 03DCEA 9D F0 09 
  LDA.B #$FF                                      ; 03DCED A9 FF 
  STA.W EntityYPxSpeed,X                                   ; 03DCEF 9D 62 0A 
  BRA.B B_3DCFA                                   ; 03DCF2 80 06 
B_3DCF4:
  STZ.W EntityYSubPxSpeed,X                                   ; 03DCF4 9E F0 09 
  STZ.W EntityYPxSpeed,X                                   ; 03DCF7 9E 62 0A 
B_3DCFA:
  DEC.W EntityV15,X                                   ; 03DCFA DE 80 0D 
  BNE.B B_3DD21                                   ; 03DCFD D0 22 
  LDA.B #$79                                      ; 03DCFF A9 79 
  STA.W EntityTypeId,X                                   ; 03DD01 9D 44 07 
  STZ.W EntityYSubPxSpeed,X                                   ; 03DD04 9E F0 09 
  STZ.W EntityYPxSpeed,X                                   ; 03DD07 9E 62 0A 
  LDA.W $069C                                     ; 03DD0A AD 9C 06 
  ASL                                             ; 03DD0D 0A 
  ASL                                             ; 03DD0E 0A 
  STA.B $04                                       ; 03DD0F 85 04 
  JSL AdvanceRNG                                     ; 03DD11 22 95 CA 0E 
  AND.B #$03                                      ; 03DD15 29 03 
  CLC                                             ; 03DD17 18 
  ADC.B $04                                       ; 03DD18 65 04 
  TAY                                             ; 03DD1A A8 
  LDA.W D_3DD37,Y                                 ; 03DD1B B9 37 DD 
  STA.W EntityV15,X                                   ; 03DD1E 9D 80 0D 
B_3DD21:
  JSR.W L_3E1A7                                   ; 03DD21 20 A7 E1 
  JSR.W L_3DF64                                   ; 03DD24 20 64 DF 
  JSL L_CFDAC                                     ; 03DD27 22 AC FD 0C 
  JSR.W L_3DFBF                                   ; 03DD2B 20 BF DF 
  JSR.W L_3E180                                   ; 03DD2E 20 80 E1 
  JSR.W L_3E132                                   ; 03DD31 20 32 E1 
  JMP.W AdvanceToNextEntity                                   ; 03DD34 4C 41 81 

D_3DD37:
.byte $E8,$B0,$A8,$40,$E8,$A0,$88,$40             ; 03DD37 D...DDDD ???@???@
.byte $C8,$80,$68,$38,$B8,$60,$48,$30             ; 03DD3F DDD.DDDD ??h8?`H0
.byte $A8,$58,$48,$28,$98,$50,$40,$20             ; 03DD47 DDDD.... ?XH(?P@ 
.byte $88,$40,$30,$20                             ; 03DD50 ....     ?@0 

  JSL L_CFB81                                     ; 03DD53 22 81 FB 0C 
  LDA.W EntityXPx,X                              ; 03DD57 BD 46 0B 
  AND.B #$07                                      ; 03DD5A 29 07 
  TAY                                             ; 03DD5C A8 
  LDA.W EntityV21,X                                   ; 03DD5D BD 2C 10 
  ADC.W D_3DDF2,Y                                 ; 03DD60 79 F2 DD 
  STA.W EntityYPx,X                                   ; 03DD63 9D 9C 0C 
  LDA.W EntityXPxSpeed,X                                   ; 03DD66 BD 7E 09 
  BPL.B B_3DD91                                   ; 03DD69 10 26 
  LDA.B #$44                                      ; 03DD6B A9 44 
  CMP.W EntityXPx,X                              ; 03DD6D DD 46 0B 
  BCC.B B_3DDB5                                   ; 03DD70 90 43 
  STA.W EntityXPx,X                              ; 03DD72 9D 46 0B 
  JSL AdvanceRNG                                     ; 03DD75 22 95 CA 0E 
  AND.B #$01                                      ; 03DD79 29 01 
  BEQ.B B_3DD89                                   ; 03DD7B F0 0C 
  LDA.B #$40                                      ; 03DD7D A9 40 
  STA.W EntityXSubPxSpeed,X                                   ; 03DD7F 9D 0C 09 
  LDA.B #$00                                      ; 03DD82 A9 00 
  STA.W EntityXPxSpeed,X                                   ; 03DD84 9D 7E 09 
  BRA.B B_3DDB5                                   ; 03DD87 80 2C 
B_3DD89:
  STZ.W EntityXSubPxSpeed,X                                   ; 03DD89 9E 0C 09 
  STZ.W EntityXPxSpeed,X                                   ; 03DD8C 9E 7E 09 
  BRA.B B_3DDB5                                   ; 03DD8F 80 24 
B_3DD91:
  LDA.B #$BC                                      ; 03DD91 A9 BC 
  CMP.W EntityXPx,X                              ; 03DD93 DD 46 0B 
  BCS.B B_3DDB5                                   ; 03DD96 B0 1D 
  STA.W EntityXPx,X                              ; 03DD98 9D 46 0B 
  JSL AdvanceRNG                                     ; 03DD9B 22 95 CA 0E 
  AND.B #$01                                      ; 03DD9F 29 01 
  BEQ.B B_3DDAF                                   ; 03DDA1 F0 0C 
  LDA.B #$C0                                      ; 03DDA3 A9 C0 
  STA.W EntityXSubPxSpeed,X                                   ; 03DDA5 9D 0C 09 
  LDA.B #$FF                                      ; 03DDA8 A9 FF 
  STA.W EntityXPxSpeed,X                                   ; 03DDAA 9D 7E 09 
  BRA.B B_3DDB5                                   ; 03DDAD 80 06 
B_3DDAF:
  STZ.W EntityXSubPxSpeed,X                                   ; 03DDAF 9E 0C 09 
  STZ.W EntityXPxSpeed,X                                   ; 03DDB2 9E 7E 09 
B_3DDB5:
  DEC.W EntityV15,X                                   ; 03DDB5 DE 80 0D 
  BNE.B B_3DDDC                                   ; 03DDB8 D0 22 
  LDA.B #$79                                      ; 03DDBA A9 79 
  STA.W EntityTypeId,X                                   ; 03DDBC 9D 44 07 
  STZ.W EntityXSubPxSpeed,X                                   ; 03DDBF 9E 0C 09 
  STZ.W EntityXPxSpeed,X                                   ; 03DDC2 9E 7E 09 
  LDA.W $069C                                     ; 03DDC5 AD 9C 06 
  ASL                                             ; 03DDC8 0A 
  ASL                                             ; 03DDC9 0A 
  STA.B $04                                       ; 03DDCA 85 04 
  JSL AdvanceRNG                                     ; 03DDCC 22 95 CA 0E 
  AND.B #$03                                      ; 03DDD0 29 03 
  CLC                                             ; 03DDD2 18 
  ADC.B $04                                       ; 03DDD3 65 04 
  TAY                                             ; 03DDD5 A8 
  LDA.W D_3DD37,Y                                 ; 03DDD6 B9 37 DD 
  STA.W EntityV15,X                                   ; 03DDD9 9D 80 0D 
B_3DDDC:
  JSR.W L_3E1A7                                   ; 03DDDC 20 A7 E1 
  JSR.W L_3DF64                                   ; 03DDDF 20 64 DF 
  JSL L_CFDAC                                     ; 03DDE2 22 AC FD 0C 
  JSR.W L_3DFBF                                   ; 03DDE6 20 BF DF 
  JSR.W L_3E180                                   ; 03DDE9 20 80 E1 
  JSR.W L_3E132                                   ; 03DDEC 20 32 E1 
  JMP.W AdvanceToNextEntity                                   ; 03DDEF 4C 41 81 

D_3DDF2:
.byte $00,$FF,$01,$01,$FF,$00,$FF,$01             ; 03DDF2 DDDDDDDD ????????

  LDA.B #$20                                      ; 03DDFA A9 20 
  STA.W $0699                                     ; 03DDFC 8D 99 06 
  DEC.W EntityV15,X                                   ; 03DDFF DE 80 0D 
  BNE.B B_3DE0E                                   ; 03DE02 D0 0A 
  LDA.B #$79                                      ; 03DE04 A9 79 
  STA.W EntityTypeId,X                                   ; 03DE06 9D 44 07 
  LDA.B #$01                                      ; 03DE09 A9 01 
  STA.W EntityV15,X                                   ; 03DE0B 9D 80 0D 
B_3DE0E:
  JSR.W L_3DF64                                   ; 03DE0E 20 64 DF 
  JSL L_CFDAC                                     ; 03DE11 22 AC FD 0C 
  LDA.B $D2                                       ; 03DE15 A5 D2 
  AND.B #$01                                      ; 03DE17 29 01 
  BNE.B B_3DE25                                   ; 03DE19 D0 0A 
  LDY.B #$00                                      ; 03DE1B A0 00 
  JSR.W L_3E34A                                   ; 03DE1D 20 4A E3 
  LDY.B #$01                                      ; 03DE20 A0 01 
  JSR.W L_3E34A                                   ; 03DE22 20 4A E3 
B_3DE25:
  JSR.W L_3DFBF                                   ; 03DE25 20 BF DF 
  JSR.W L_3E180                                   ; 03DE28 20 80 E1 
  JSR.W L_3E132                                   ; 03DE2B 20 32 E1 
  JMP.W AdvanceToNextEntity                                   ; 03DE2E 4C 41 81 

.byte $A9,$20,$8D,$99,$06,$DE,$80,$0D             ; 03DE31 ........ ? ??????
.byte $D0,$19,$A9,$79,$9D,$44,$07,$A9             ; 03DE39 ........ ???y?D??
.byte $01,$9D,$80,$0D,$DA,$C2,$10,$A2             ; 03DE41 ........ ????????
.byte $18,$FF,$A9,$07,$22,$0F,$83,$0F             ; 03DE49 ........ ????"???
.byte $E2,$10,$FA,$BD,$80,$0D,$C9,$1E             ; 03DE51 ........ ????????
.byte $D0,$15,$A9,$F7,$8D,$9D,$06,$AC             ; 03DE59 ........ ????????
.byte $8E,$06,$A9,$6F,$99,$44,$07,$B9             ; 03DE61 ........ ???o?D??
.byte $A0,$14,$A8,$22,$D8,$AE,$00,$20             ; 03DE69 ........ ???"??? 
.byte $64,$DF,$22,$AC,$FD,$0C,$A5,$D2             ; 03DE71 ........ d?"?????
.byte $29,$01,$D0,$0A,$A0,$00,$20,$4A             ; 03DE79 ........ )????? J
.byte $E3,$A0,$01,$20,$4A,$E3,$20,$BF             ; 03DE81 ........ ??? J? ?
.byte $DF,$20,$80,$E1,$20,$32,$E1,$4C             ; 03DE89 ........ ? ?? 2?L
.byte $41,$81,$DE,$80,$0D,$D0,$0A,$A9             ; 03DE91 ........ A???????
.byte $7F,$9D,$44,$07,$A9,$5A,$9D,$F2             ; 03DE99 ........ ??D??Z??
.byte $0D,$22,$AC,$FD,$0C,$20,$BF,$DF             ; 03DEA1 ........ ?"??? ??
.byte $20,$32,$E1,$4C,$41,$81,$BD,$F2             ; 03DEA9 ........  2?LA???
.byte $0D,$F0,$05,$DE,$F2,$0D,$80,$4C             ; 03DEB1 ........ ???????L
.byte $A9,$10,$8D,$99,$06,$20,$64,$DF             ; 03DEB9 ........ ????? d?
.byte $20,$64,$DF,$20,$64,$DF,$20,$64             ; 03DEC1 ........  d? d? d
.byte $DF,$22,$AC,$FD,$0C,$20,$3A,$E4             ; 03DEC9 ........ ?"??? :?
.byte $A5,$D2,$29,$01,$D0,$03,$20,$3A             ; 03DED1 ........ ??)??? :
.byte $E4,$BD,$80,$0D,$C9,$10,$D0,$09             ; 03DED9 ........ ????????
.byte $22,$26,$FE,$0C,$A9,$00,$9D,$28             ; 03DEE1 ........ "&?????(
.byte $08,$DE,$80,$0D,$D0,$16,$9E,$D2             ; 03DEE9 ........ ????????
.byte $06,$CE,$C6,$06,$A9,$80,$8D,$14             ; 03DEF1 ........ ????????
.byte $15,$8D,$15,$15,$AD,$9E,$06,$F0             ; 03DEF9 ........ ????????
.byte $03,$20,$15,$DF,$BD,$80,$0D,$C9             ; 03DF01 ........ ? ??????
.byte $10,$90,$06,$20,$BF,$DF,$20,$32             ; 03DF09 ........ ??? ?? 2
.byte $E1,$4C,$41,$81,$EE,$00,$19,$EE             ; 03DF11 ........ ?LA?????
.byte $00,$19,$A9,$14,$8D,$02,$19,$A9             ; 03DF19 ........ ????????
.byte $09,$8D,$09,$19,$9C,$10,$19,$A9             ; 03DF21 ........ ????????
.byte $1D,$8D,$25,$19,$A9,$01,$8D,$2C             ; 03DF29 ........ ??%????,
.byte $19,$A9,$2C,$8D,$3A,$19,$A9,$01             ; 03DF31 ........ ??,?:???
.byte $8D,$41,$19,$A9,$15,$8D,$03,$19             ; 03DF39 ........ ?A??????
.byte $A9,$01,$8D,$0A,$19,$9C,$11,$19             ; 03DF41 ........ ????????
.byte $A9,$B4,$8D,$26,$19,$A9,$00,$8D             ; 03DF49 ........ ???&????
.byte $2D,$19,$A9,$B8,$8D,$3B,$19,$A9             ; 03DF51 ........ -????;??
.byte $0B,$8D,$42,$19,$60,$4C,$41,$81             ; 03DF59 ........ ??B?`LA?
.byte $4C,$41,$81                                 ; 03DF62 ...      LA?


L_3DF64:
  LDA.W $0699                                     ; 03DF64 AD 99 06 
  BEQ.B B_3DFB6                                   ; 03DF67 F0 4D 
  DEC.W $0699                                     ; 03DF69 CE 99 06 
  JSL AdvanceRNG                                     ; 03DF6C 22 95 CA 0E 
  AND.B #$07                                      ; 03DF70 29 07 
  TAY                                             ; 03DF72 A8 
  CLC                                             ; 03DF73 18 
  LDA.W EntityXPx,X                              ; 03DF74 BD 46 0B 
  ADC.W D_3DFB7,Y                                 ; 03DF77 79 B7 DF 
  STA.W EntityXPx,X                              ; 03DF7A 9D 46 0B 
  JSL AdvanceRNG                                     ; 03DF7D 22 95 CA 0E 
  AND.B #$07                                      ; 03DF81 29 07 
  TAY                                             ; 03DF83 A8 
  CLC                                             ; 03DF84 18 
  LDA.W EntityYPx,X                                   ; 03DF85 BD 9C 0C 
  ADC.W D_3DFB7,Y                                 ; 03DF88 79 B7 DF 
  STA.W EntityYPx,X                                   ; 03DF8B 9D 9C 0C 
  LDA.B #$2E                                      ; 03DF8E A9 2E 
  CMP.W EntityYPx,X                                   ; 03DF90 DD 9C 0C 
  BCC.B B_3DF98                                   ; 03DF93 90 03 

.byte $9D,$9C,$0C                                 ; 03DF96 ...      ???

B_3DF98:
  LDA.B #$B4                                      ; 03DF98 A9 B4 
  CMP.W EntityYPx,X                                   ; 03DF9A DD 9C 0C 
  BCS.B B_3DFA2                                   ; 03DF9D B0 03 
  STA.W EntityYPx,X                                   ; 03DF9F 9D 9C 0C 
B_3DFA2:
  LDA.B #$44                                      ; 03DFA2 A9 44 
  CMP.W EntityXPx,X                              ; 03DFA4 DD 46 0B 
  BCC.B B_3DFAC                                   ; 03DFA7 90 03 
  STA.W EntityXPx,X                              ; 03DFA9 9D 46 0B 
B_3DFAC:
  LDA.B #$BC                                      ; 03DFAC A9 BC 
  CMP.W EntityXPx,X                              ; 03DFAE DD 46 0B 
  BCS.B B_3DFB6                                   ; 03DFB1 B0 03 
  STA.W EntityXPx,X                              ; 03DFB3 9D 46 0B 
B_3DFB6:
  RTS                                             ; 03DFB6 60 


D_3DFB7:
.byte $00,$01,$02,$00,$00,$FF,$FE,$00             ; 03DFB7 DDDDDDDD ????????


L_3DFBF:
  PHX                                             ; 03DFBF DA 
  STZ.B $0D                                       ; 03DFC0 64 0D 
  SEC                                             ; 03DFC2 38 
  LDA.W EntityXPx,X                              ; 03DFC3 BD 46 0B 
  SBC.B #$20                                      ; 03DFC6 E9 20 
  STA.B $04                                       ; 03DFC8 85 04 
  SEC                                             ; 03DFCA 38 
  LDA.W EntityYPx,X                                   ; 03DFCB BD 9C 0C 
  SBC.B #$0E                                      ; 03DFCE E9 0E 
  STA.B $06                                       ; 03DFD0 85 06 
  LDA.W EntityYMovement,X                                   ; 03DFD2 BD 0E 0D 
  SBC.B #$00                                      ; 03DFD5 E9 00 
  STA.B $07                                       ; 03DFD7 85 07 
  LDY.B $0D                                       ; 03DFD9 A4 0D 
  CLC                                             ; 03DFDB 18 
  LDA.B $04                                       ; 03DFDC A5 04 
  ADC.W D_3E0E2,Y                                 ; 03DFDE 79 E2 E0 
  STA.B $05                                       ; 03DFE1 85 05 
  CLC                                             ; 03DFE3 18 
  LDA.B $06                                       ; 03DFE4 A5 06 
  ADC.W D_3E0F6,Y                                 ; 03DFE6 79 F6 E0 
  STA.B $08                                       ; 03DFE9 85 08 
  LDA.B $07                                       ; 03DFEB A5 07 
  ADC.B #$00                                      ; 03DFED 69 00 
  STA.B $09                                       ; 03DFEF 85 09 
  TYA                                             ; 03DFF1 98 
  ASL                                             ; 03DFF2 0A 
  TAY                                             ; 03DFF3 A8 
  LDA.W D_3E10A,Y                                 ; 03DFF4 B9 0A E1 
  STA.B $0A                                       ; 03DFF7 85 0A 
  LDA.W D_3E10B,Y                                 ; 03DFF9 B9 0B E1 
  ORA.W $0697                                     ; 03DFFC 0D 97 06 
  STA.B $0B                                       ; 03DFFF 85 0B 
  LDA.B $09                                       ; 03E001 A5 09 
  BPL.B B_3E00D                                   ; 03E003 10 08 
  LDA.B #$F0                                      ; 03E005 A9 F0 
  CMP.B $08                                       ; 03E007 C5 08 
  BCC.B B_3E00D                                   ; 03E009 90 02 
  STA.B $08                                       ; 03E00B 85 08 
B_3E00D:
  LDA.W EntityV31,X                                   ; 03E00D BD A0 14 
  TAX                                             ; 03E010 AA 
  ASL                                             ; 03E011 0A 
  ASL                                             ; 03E012 0A 
  TAY                                             ; 03E013 A8 
  JSR.W L_3E0B6                                   ; 03E014 20 B6 E0 
  LDY.B #$09                                      ; 03E017 A0 09 
B_3E019:
  PHY                                             ; 03E019 5A 
  INC.B $0D                                       ; 03E01A E6 0D 
  LDY.B $0D                                       ; 03E01C A4 0D 
  CLC                                             ; 03E01E 18 
  LDA.B $04                                       ; 03E01F A5 04 
  ADC.W D_3E0E2,Y                                 ; 03E021 79 E2 E0 
  STA.B $05                                       ; 03E024 85 05 
  CLC                                             ; 03E026 18 
  LDA.B $06                                       ; 03E027 A5 06 
  ADC.W D_3E0F6,Y                                 ; 03E029 79 F6 E0 
  STA.B $08                                       ; 03E02C 85 08 
  LDA.B $07                                       ; 03E02E A5 07 
  ADC.B #$00                                      ; 03E030 69 00 
  STA.B $09                                       ; 03E032 85 09 
  TYA                                             ; 03E034 98 
  ASL                                             ; 03E035 0A 
  TAY                                             ; 03E036 A8 
  LDA.W D_3E10A,Y                                 ; 03E037 B9 0A E1 
  STA.B $0A                                       ; 03E03A 85 0A 
  LDA.W D_3E10B,Y                                 ; 03E03C B9 0B E1 
  ORA.W $0697                                     ; 03E03F 0D 97 06 
  STA.B $0B                                       ; 03E042 85 0B 
  LDA.B $09                                       ; 03E044 A5 09 
  BPL.B B_3E050                                   ; 03E046 10 08 
  LDA.B #$F0                                      ; 03E048 A9 F0 
  CMP.B $08                                       ; 03E04A C5 08 
  BCC.B B_3E050                                   ; 03E04C 90 02 
  STA.B $08                                       ; 03E04E 85 08 
B_3E050:
  LDA.W $17DE,X                                   ; 03E050 BD DE 17 
  TAX                                             ; 03E053 AA 
  ASL                                             ; 03E054 0A 
  ASL                                             ; 03E055 0A 
  TAY                                             ; 03E056 A8 
  JSR.W L_3E0B6                                   ; 03E057 20 B6 E0 
  PLY                                             ; 03E05A 7A 
  DEY                                             ; 03E05B 88 
  BNE.B B_3E019                                   ; 03E05C D0 BB 
  LDY.B #$0A                                      ; 03E05E A0 0A 
B_3E060:
  PHY                                             ; 03E060 5A 
  INC.B $0D                                       ; 03E061 E6 0D 
  LDY.B $0D                                       ; 03E063 A4 0D 
  CLC                                             ; 03E065 18 
  LDA.B $04                                       ; 03E066 A5 04 
  ADC.W D_3E0E2,Y                                 ; 03E068 79 E2 E0 
  STA.B $05                                       ; 03E06B 85 05 
  CLC                                             ; 03E06D 18 
  LDA.B $06                                       ; 03E06E A5 06 
  ADC.W D_3E0F6,Y                                 ; 03E070 79 F6 E0 
  STA.B $08                                       ; 03E073 85 08 
  LDA.B $07                                       ; 03E075 A5 07 
  ADC.B #$00                                      ; 03E077 69 00 
  STA.B $09                                       ; 03E079 85 09 
  TYA                                             ; 03E07B 98 
  ASL                                             ; 03E07C 0A 
  TAY                                             ; 03E07D A8 
  LDA.W D_3E10A,Y                                 ; 03E07E B9 0A E1 
  STA.B $0A                                       ; 03E081 85 0A 
  LDA.W D_3E10B,Y                                 ; 03E083 B9 0B E1 
  ORA.W $0698                                     ; 03E086 0D 98 06 
  STA.B $0B                                       ; 03E089 85 0B 
  LDA.B $09                                       ; 03E08B A5 09 
  BPL.B B_3E097                                   ; 03E08D 10 08 
  LDA.B #$F0                                      ; 03E08F A9 F0 
  CMP.B $08                                       ; 03E091 C5 08 
  BCC.B B_3E097                                   ; 03E093 90 02 
  STA.B $08                                       ; 03E095 85 08 
B_3E097:
  LDA.W $17DE,X                                   ; 03E097 BD DE 17 
  TAX                                             ; 03E09A AA 
  ASL                                             ; 03E09B 0A 
  ASL                                             ; 03E09C 0A 
  TAY                                             ; 03E09D A8 
  JSR.W L_3E0B6                                   ; 03E09E 20 B6 E0 
  PLY                                             ; 03E0A1 7A 
  DEY                                             ; 03E0A2 88 
  BNE.B B_3E060                                   ; 03E0A3 D0 BB 
  PLX                                             ; 03E0A5 FA 
  LDA.B $D2                                       ; 03E0A6 A5 D2 
  AND.B #$01                                      ; 03E0A8 29 01 
  BNE.B B_3E0B5                                   ; 03E0AA D0 09 
  LDA.W EntityV2,X                                   ; 03E0AC BD B6 07 
  STA.W $0697                                     ; 03E0AF 8D 97 06 
  STA.W $0698                                     ; 03E0B2 8D 98 06 
B_3E0B5:
  RTS                                             ; 03E0B5 60 


L_3E0B6:
  BCC.B B_3E0CD                                   ; 03E0B6 90 15 
  LDA.B $05                                       ; 03E0B8 A5 05 
  STA.W $0408,Y                                   ; 03E0BA 99 08 04 
  LDA.B $08                                       ; 03E0BD A5 08 
  STA.W $0409,Y                                   ; 03E0BF 99 09 04 
  LDA.B $0A                                       ; 03E0C2 A5 0A 
  STA.W $040A,Y                                   ; 03E0C4 99 0A 04 
  LDA.B $0B                                       ; 03E0C7 A5 0B 
  STA.W $040B,Y                                   ; 03E0C9 99 0B 04 
  RTS                                             ; 03E0CC 60 


B_3E0CD:
.byte $A5,$05,$99,$08,$03,$A5,$08,$99             ; 03E0CD ........ ????????
.byte $09,$03,$A5,$0A,$99,$0A,$03,$A5             ; 03E0D5 ........ ????????
.byte $0B,$99,$0B,$03,$60                         ; 03E0DE .....    ????`
D_3E0E2:
.byte $00,$00,$00,$00,$00,$10,$10,$10             ; 03E0E2 DDDDDDDD ????????
.byte $10,$10,$20,$20,$20,$20,$20,$30             ; 03E0EA DDDDDDDD ??     0
.byte $30,$30,$30,$30                             ; 03E0F3 DDDD     0000
D_3E0F6:
.byte $08,$18,$28,$38,$48,$00,$10,$20             ; 03E0F6 DDDDDDDD ??(8H?? 
.byte $30,$40,$00,$10,$20,$30,$40,$08             ; 03E0FE DDDDDDDD 0@?? 0@?
.byte $18,$28,$38,$48                             ; 03E107 DDDD     ?(8H
D_3E10A:
.byte $80                                         ; 03E10B D        ?
D_3E10B:
.byte $20,$82,$20,$84,$20,$86,$20,$88             ; 03E10B DDDDDDDD  ? ? ? ?
.byte $20,$80,$21,$82,$21,$84,$21,$86             ; 03E113 DDDDDDDD  ?!?!?!?
.byte $21,$8A,$20,$80,$61,$82,$61,$84             ; 03E11B DDDDDDDD !? ?a?a?
.byte $61,$86,$61,$8A,$60,$80,$60,$82             ; 03E123 DDDDDDDD a?a?`?`?
.byte $60,$84,$60,$86,$60,$88,$60                 ; 03E12C DDDDDDD  `?`?`?`


L_3E132:
  LDA.W EntityYPx,X                                   ; 03E132 BD 9C 0C 
  PHX                                             ; 03E135 DA 
  TAX                                             ; 03E136 AA 
  LDA.L D_CFE51,X                                 ; 03E137 BF 51 FE 0C 
  PLX                                             ; 03E13B FA 
  CMP.W EntityV20,X                                   ; 03E13C DD BA 0F 
  BEQ.B B_3E175                                   ; 03E13F F0 34 
  STA.W EntityV20,X                                   ; 03E141 9D BA 0F 
  ASL                                             ; 03E144 0A 
  TAY                                             ; 03E145 A8 
  STZ.W $1A9B                                     ; 03E146 9C 9B 1A 
  LDA.W D_3E176,Y                                 ; 03E149 B9 76 E1 
  STA.W $1A9E                                     ; 03E14C 8D 9E 1A 
  LDA.W D_3E177,Y                                 ; 03E14F B9 77 E1 
  STA.W $1A9F                                     ; 03E152 8D 9F 1A 
  PHP                                             ; 03E155 08 
  REP.B #P_Idx8Bit                                      ; 03E156 C2 10 
  LDX.W #$6800                                    ; 03E158 A2 00 68 
  STX.W $1AA3                                     ; 03E15B 8E A3 1A 
  LDX.W #$1801                                    ; 03E15E A2 01 18 
  STX.W $1A9C                                     ; 03E161 8E 9C 1A 
  LDA.B #$0E                                      ; 03E164 A9 0E 
  STA.W $1AA0                                     ; 03E166 8D A0 1A 
  LDX.W #$0400                                    ; 03E169 A2 00 04 
  STX.W $1AA1                                     ; 03E16C 8E A1 1A 
  LDA.B #$01                                      ; 03E16F A9 01 
  STA.W $1A9B                                     ; 03E171 8D 9B 1A 
  PLP                                             ; 03E174 28 
B_3E175:
  RTS                                             ; 03E175 60 


D_3E176:
.byte $00                                         ; 03E177 D        ?
D_3E177:
.byte $84,$00,$88,$00,$8C,$00,$90,$00             ; 03E177 DDDDDDDD ????????
.byte $94                                         ; 03E180 D        ?


L_3E180:
  SEC                                             ; 03E180 38 
  LDA.B #$40                                      ; 03E181 A9 40 
  SBC.W EntityXPx,X                              ; 03E183 FD 46 0B 
  STA.W $06CD                                     ; 03E186 8D CD 06 
  LDA.B #$00                                      ; 03E189 A9 00 
  SBC.W EntityXMovement,X                                   ; 03E18B FD B8 0B 
  AND.B #$01                                      ; 03E18E 29 01 
  STA.W $06CE                                     ; 03E190 8D CE 06 
  SEC                                             ; 03E193 38 
  LDA.B #$28                                      ; 03E194 A9 28 
  SBC.W EntityYPx,X                                   ; 03E196 FD 9C 0C 
  STA.W $06D0                                     ; 03E199 8D D0 06 
  LDA.B #$00                                      ; 03E19C A9 00 
  SBC.W EntityYMovement,X                                   ; 03E19E FD 0E 0D 
  AND.B #$01                                      ; 03E1A1 29 01 
  STA.W $06D1                                     ; 03E1A3 8D D1 06 
  RTS                                             ; 03E1A6 60 


L_3E1A7:
  PHX                                             ; 03E1A7 DA 
  LDA.W $069C                                     ; 03E1A8 AD 9C 06 
  BEQ.B B_3E1CE                                   ; 03E1AB F0 21 
  CMP.B #$02                                      ; 03E1AD C9 02 
  BCS.B B_3E1CC                                   ; 03E1AF B0 1B 
  LDX.W $068D                                     ; 03E1B1 AE 8D 06 
  LDA.W EntityHeader,X                                   ; 03E1B4 BD D2 06 
  AND.W EntityHeader,X                                   ; 03E1B7 3D D2 06 
  AND.B #$40                                      ; 03E1BA 29 40 
  BEQ.B B_3E1FA                                   ; 03E1BC F0 3C 
  JSL AdvanceRNG                                     ; 03E1BE 22 95 CA 0E 
  AND.B #$0F                                      ; 03E1C2 29 0F 
  TAY                                             ; 03E1C4 A8 
  LDA.W D_3E20C,Y                                 ; 03E1C5 B9 0C E2 
  JSL L_3823C                                     ; 03E1C8 22 3C 82 03 
B_3E1CC:
  PLX                                             ; 03E1CC FA 
  RTS                                             ; 03E1CD 60 

B_3E1CE:
  LDX.W $068D                                     ; 03E1CE AE 8D 06 
  LDA.W EntityHeader,X                                   ; 03E1D1 BD D2 06 
  PHA                                             ; 03E1D4 48 
  LDX.W $068C                                     ; 03E1D5 AE 8C 06 
  PLA                                             ; 03E1D8 68 
  AND.W EntityHeader,X                                   ; 03E1D9 3D D2 06 
  AND.B #$40                                      ; 03E1DC 29 40 
  BEQ.B B_3E1FA                                   ; 03E1DE F0 1A 
  JSL AdvanceRNG                                     ; 03E1E0 22 95 CA 0E 
  AND.B #$0F                                      ; 03E1E4 29 0F 
  TAY                                             ; 03E1E6 A8 
  LDA.W D_3E20C,Y                                 ; 03E1E7 B9 0C E2 
  PHA                                             ; 03E1EA 48 
  LDA.W D_3E1FC,Y                                 ; 03E1EB B9 FC E1 
  JSL L_3823C                                     ; 03E1EE 22 3C 82 03 
  LDX.W $068D                                     ; 03E1F2 AE 8D 06 
  PLA                                             ; 03E1F5 68 
  JSL L_3823C                                     ; 03E1F6 22 3C 82 03 
B_3E1FA:
  PLX                                             ; 03E1FA FA 
  RTS                                             ; 03E1FB 60 


D_3E1FC:
.byte $12,$13,$14,$15,$12,$13,$12,$15             ; 03E1FC ..D..... ????????
.byte $12,$17,$14,$15,$18,$13,$14,$18             ; 03E204 ..D..... ????????
D_3E20C:
.byte $12,$13,$17,$15,$12,$13,$12,$15             ; 03E20C DDD.DDDD ????????
.byte $17,$17,$14,$15,$19,$13,$14,$19             ; 03E214 DDDDDD.D ????????


L_3E21C:
  LDA.B #$7B                                      ; 03E21C A9 7B 
  STA.W EntityTypeId,X                                   ; 03E21E 9D 44 07 
  LDA.W EntityYPx,X                                   ; 03E221 BD 9C 0C 
  STA.W EntityV21,X                                   ; 03E224 9D 2C 10 
  JSL AdvanceRNG                                     ; 03E227 22 95 CA 0E 
  AND.B #$07                                      ; 03E22B 29 07 
  TAY                                             ; 03E22D A8 
  LDA.W D_3E2E2,Y                                 ; 03E22E B9 E2 E2 
  STA.W EntityV15,X                                   ; 03E231 9D 80 0D 
  LDA.W $069C                                     ; 03E234 AD 9C 06 
  ASL                                             ; 03E237 0A 
  ASL                                             ; 03E238 0A 
  ASL                                             ; 03E239 0A 
  ASL                                             ; 03E23A 0A 
  STA.B $04                                       ; 03E23B 85 04 
  JSL AdvanceRNG                                     ; 03E23D 22 95 CA 0E 
  AND.B #$07                                      ; 03E241 29 07 
  ASL                                             ; 03E243 0A 
  ADC.B $04                                       ; 03E244 65 04 
  TAY                                             ; 03E246 A8 
  LDA.W $069E                                     ; 03E247 AD 9E 06 
  BEQ.B B_3E24E                                   ; 03E24A F0 02 

.byte $A9,$40                                     ; 03E24D ..       ?@

B_3E24E:
  CLC                                             ; 03E24E 18 
  ADC.W D_3E2EA,Y                                 ; 03E24F 79 EA E2 
  STA.W EntityXSubPxSpeed,X                                   ; 03E252 9D 0C 09 
  LDA.W D_3E2EB,Y                                 ; 03E255 B9 EB E2 
  ADC.B #$00                                      ; 03E258 69 00 
  STA.W EntityXPxSpeed,X                                   ; 03E25A 9D 7E 09 
  LDA.W EntityXPx,X                              ; 03E25D BD 46 0B 
  CMP.B #$60                                      ; 03E260 C9 60 
  BCC.B B_3E281                                   ; 03E262 90 1D 
  CMP.B #$A0                                      ; 03E264 C9 A0 
  BCS.B B_3E270                                   ; 03E266 B0 08 
  JSL AdvanceRNG                                     ; 03E268 22 95 CA 0E 
  AND.B #$01                                      ; 03E26C 29 01 
  BEQ.B B_3E281                                   ; 03E26E F0 11 
B_3E270:
  SEC                                             ; 03E270 38 
  LDA.B #$00                                      ; 03E271 A9 00 
  SBC.W EntityXSubPxSpeed,X                                   ; 03E273 FD 0C 09 
  STA.W EntityXSubPxSpeed,X                                   ; 03E276 9D 0C 09 
  LDA.B #$00                                      ; 03E279 A9 00 
  SBC.W EntityXPxSpeed,X                                   ; 03E27B FD 7E 09 
  STA.W EntityXPxSpeed,X                                   ; 03E27E 9D 7E 09 
B_3E281:
  RTS                                             ; 03E281 60 


L_3E282:
  LDA.B #$7A                                      ; 03E282 A9 7A 
  STA.W EntityTypeId,X                                   ; 03E284 9D 44 07 
  JSL AdvanceRNG                                     ; 03E287 22 95 CA 0E 
  AND.B #$07                                      ; 03E28B 29 07 
  TAY                                             ; 03E28D A8 
  LDA.W D_3E2E2,Y                                 ; 03E28E B9 E2 E2 
  STA.W EntityV15,X                                   ; 03E291 9D 80 0D 
  LDA.W $069C                                     ; 03E294 AD 9C 06 
  ASL                                             ; 03E297 0A 
  ASL                                             ; 03E298 0A 
  ASL                                             ; 03E299 0A 
  ASL                                             ; 03E29A 0A 
  STA.B $04                                       ; 03E29B 85 04 
  JSL AdvanceRNG                                     ; 03E29D 22 95 CA 0E 
  AND.B #$07                                      ; 03E2A1 29 07 
  ASL                                             ; 03E2A3 0A 
  ADC.B $04                                       ; 03E2A4 65 04 
  TAY                                             ; 03E2A6 A8 
  LDA.W $069E                                     ; 03E2A7 AD 9E 06 
  BEQ.B B_3E2AE                                   ; 03E2AA F0 02 

.byte $A9,$40                                     ; 03E2AD ..       ?@

B_3E2AE:
  CLC                                             ; 03E2AE 18 
  ADC.W D_3E2EA,Y                                 ; 03E2AF 79 EA E2 
  STA.W EntityYSubPxSpeed,X                                   ; 03E2B2 9D F0 09 
  LDA.W D_3E2EB,Y                                 ; 03E2B5 B9 EB E2 
  ADC.B #$00                                      ; 03E2B8 69 00 
  STA.W EntityYPxSpeed,X                                   ; 03E2BA 9D 62 0A 
  LDA.W EntityYPx,X                                   ; 03E2BD BD 9C 0C 
  CMP.B #$60                                      ; 03E2C0 C9 60 
  BCC.B B_3E2E1                                   ; 03E2C2 90 1D 
  CMP.B #$A0                                      ; 03E2C4 C9 A0 
  BCS.B B_3E2D0                                   ; 03E2C6 B0 08 
  JSL AdvanceRNG                                     ; 03E2C8 22 95 CA 0E 
  AND.B #$01                                      ; 03E2CC 29 01 
  BEQ.B B_3E2E1                                   ; 03E2CE F0 11 
B_3E2D0:
  SEC                                             ; 03E2D0 38 
  LDA.B #$00                                      ; 03E2D1 A9 00 
  SBC.W EntityYSubPxSpeed,X                                   ; 03E2D3 FD F0 09 
  STA.W EntityYSubPxSpeed,X                                   ; 03E2D6 9D F0 09 
  LDA.B #$00                                      ; 03E2D9 A9 00 
  SBC.W EntityYPxSpeed,X                                   ; 03E2DB FD 62 0A 
  STA.W EntityYPxSpeed,X                                   ; 03E2DE 9D 62 0A 
B_3E2E1:
  RTS                                             ; 03E2E1 60 


D_3E2E2:
.byte $B4,$A0,$8C,$78,$6E,$64,$5A,$1E             ; 03E2E2 DDDDDDDD ???xndZ?
D_3E2EA:
.byte $C0                                         ; 03E2EB .        ?
D_3E2EB:
.byte $00,$C0,$00,$A0,$00,$80,$00,$80             ; 03E2EB .......D ????????
.byte $00,$80,$00,$60,$00,$40,$00,$C8             ; 03E2F3 D..DD..D ???`?@??
.byte $00,$C8,$00,$A8,$00,$88,$00,$88             ; 03E2FB DDDDDDDD ????????
.byte $00,$88,$00,$68,$00,$48,$00,$D0             ; 03E303 DDDDDDDD ???h?H??
.byte $00,$D0,$00,$B0,$00,$90,$00,$90             ; 03E30B DDDDDDD. ????????
.byte $00,$90,$00,$70,$00,$50,$00,$D8             ; 03E313 .DD..DDD ???p?P??
.byte $00,$00,$01,$B8,$00,$98,$00,$98             ; 03E31B DDDDD..D ????????
.byte $00,$98,$00,$78,$00,$58,$00,$E0             ; 03E323 DDDDD..D ???x?X??
.byte $00,$E0,$00,$C0,$00,$A0,$00,$00             ; 03E32B DDDDDDDD ????????
.byte $01,$A0,$00,$80,$00,$60,$00,$F0             ; 03E333 DDDDDDD. ?????`??
.byte $00,$F0,$00,$E0,$00,$B0,$00,$80             ; 03E33B ........ ????????
.byte $01,$B0,$00,$90,$00,$70,$00                 ; 03E344 .......  ?????p?


L_3E34A:
  PHX                                             ; 03E34A DA 
  STY.B $06                                       ; 03E34B 84 06 
  CLC                                             ; 03E34D 18 
  LDA.W EntityXPx,X                              ; 03E34E BD 46 0B 
  ADC.W D_3E428,Y                                 ; 03E351 79 28 E4 
  STA.B $04                                       ; 03E354 85 04 
  SEC                                             ; 03E356 38 
  LDA.W EntityYPx,X                                   ; 03E357 BD 9C 0C 
  SBC.B #$09                                      ; 03E35A E9 09 
  STA.B $05                                       ; 03E35C 85 05 
  JSL AdvanceRNG                                     ; 03E35E 22 95 CA 0E 
  AND.B #$07                                      ; 03E362 29 07 
  TAY                                             ; 03E364 A8 
  CLC                                             ; 03E365 18 
  LDA.B $04                                       ; 03E366 A5 04 
  ADC.W D_3E42A,Y                                 ; 03E368 79 2A E4 
  STA.B $04                                       ; 03E36B 85 04 
  JSL AdvanceRNG                                     ; 03E36D 22 95 CA 0E 
  AND.B #$07                                      ; 03E371 29 07 
  TAY                                             ; 03E373 A8 
  CLC                                             ; 03E374 18 
  LDA.B $05                                       ; 03E375 A5 05 
  ADC.W D_3E432,Y                                 ; 03E377 79 32 E4 
  STA.B $05                                       ; 03E37A 85 05 
  JSL FindEmptyEntitySlot                                     ; 03E37C 22 F3 80 03 
  BEQ.B B_3E385                                   ; 03E380 F0 03 

.byte $4C,$04,$E4                                 ; 03E383 ...      L??

B_3E385:
  JSL ClearEntitySlotData                                     ; 03E385 22 94 80 03 
  LDA.B #$01                                      ; 03E389 A9 01 
  STA.W EntityHeader,X                                   ; 03E38B 9D D2 06 
  LDA.B #$1C                                      ; 03E38E A9 1C 
  STA.W EntityTypeId,X                                   ; 03E390 9D 44 07 
  LDA.B #$00                                      ; 03E393 A9 00 
  STA.W EntityV3,X                                   ; 03E395 9D 28 08 
  LDA.B #$24                                      ; 03E398 A9 24 
  STA.W EntityV29,X                                   ; 03E39A 9D BC 13 
  LDA.B #$32                                      ; 03E39D A9 32 
  STA.W EntityV30,X                                   ; 03E39F 9D 2E 14 
  LDA.B $04                                       ; 03E3A2 A5 04 
  STA.W EntityXPx,X                              ; 03E3A4 9D 46 0B 
  LDA.B $05                                       ; 03E3A7 A5 05 
  STA.W EntityYPx,X                                   ; 03E3A9 9D 9C 0C 
  LDA.B #$05                                      ; 03E3AC A9 05 
  STA.W EntityV28,X                                   ; 03E3AE 9D 4A 13 
  LDA.B #$02                                      ; 03E3B1 A9 02 
  STA.W EntityV27,X                                   ; 03E3B3 9D D8 12 
  LDY.B $06                                       ; 03E3B6 A4 06 
  LDA.W D_3E406,Y                                 ; 03E3B8 B9 06 E4 
  STA.W EntityXPxSpeed,X                                   ; 03E3BB 9D 7E 09 
  JSL AdvanceRNG                                     ; 03E3BE 22 95 CA 0E 
  AND.B #$0F                                      ; 03E3C2 29 0F 
  ASL                                             ; 03E3C4 0A 
  TAY                                             ; 03E3C5 A8 
  LDA.W D_3E408,Y                                 ; 03E3C6 B9 08 E4 
  STA.W EntityYSubPxSpeed,X                                   ; 03E3C9 9D F0 09 
  LDA.W D_3E409,Y                                 ; 03E3CC B9 09 E4 
  STA.W EntityYPxSpeed,X                                   ; 03E3CF 9D 62 0A 
  JSL L_AEBC                                      ; 03E3D2 22 BC AE 00 
  TYA                                             ; 03E3D6 98 
  STA.W EntityV31,X                                   ; 03E3D7 9D A0 14 
  LDA.B #$01                                      ; 03E3DA A9 01 
  STA.W StateFlags,Y                                   ; 03E3DC 99 5E 17 
  JSL L_AEF1                                      ; 03E3DF 22 F1 AE 00 
  LDA.B #$08                                      ; 03E3E3 A9 08 
  STA.B $1C                                       ; 03E3E5 85 1C 
  LDA.B #$08                                      ; 03E3E7 A9 08 
  STA.B $1D                                       ; 03E3E9 85 1D 
  JSL L_AFC2                                      ; 03E3EB 22 C2 AF 00 
  JSL AdvanceRNG                                     ; 03E3EF 22 95 CA 0E 
  AND.B #$07                                      ; 03E3F3 29 07 
  BNE.B B_3E404                                   ; 03E3F5 D0 0D 
  REP.B #P_Idx8Bit                                      ; 03E3F7 C2 10 
  LDA.B #$07                                      ; 03E3F9 A9 07 
  LDX.W #$FF06                                    ; 03E3FB A2 06 FF 
  JSL Audio_F830F                                     ; 03E3FE 22 0F 83 0F 
  SEP.B #P_Idx8Bit                                      ; 03E402 E2 10 
B_3E404:
  PLX                                             ; 03E404 FA 
  RTS                                             ; 03E405 60 


D_3E406:
.byte $FE,$02                                     ; 03E407 DD       ??
D_3E408:
.byte $00                                         ; 03E409 D        ?
D_3E409:
.byte $00,$80,$00,$C0,$00,$00,$01,$40             ; 03E409 DDDDDDDD ???????@
.byte $01,$80,$01,$C0,$01,$40,$00,$C0             ; 03E411 DDDDDDDD ?????@??
.byte $FF,$80,$FF,$40,$FF,$00,$FF,$C0             ; 03E419 DDDDDDDD ???@????
.byte $FE,$80,$FE,$40,$FE,$00,$FF                 ; 03E422 DDDDDDD  ???@???
D_3E428:
.byte $F8,$08                                     ; 03E429 DD       ??
D_3E42A:
.byte $00,$FE,$02,$FD,$03,$FC,$04,$00             ; 03E42A DDDDDDDD ????????
D_3E432:
.byte $00,$FC,$04,$F8,$08,$F4,$0C,$00             ; 03E432 DDDDDDDD ????????
.byte $DA,$BD,$46,$0B,$85,$04,$18,$BD             ; 03E43A ........ ??F?????
.byte $9C,$0C,$69,$0A,$85,$05,$22,$95             ; 03E442 ........ ??i???"?
.byte $CA,$0E,$29,$0F,$A8,$18,$A5,$04             ; 03E44A ........ ??)?????
.byte $79,$1C,$E5,$85,$04,$22,$95,$CA             ; 03E452 ........ y????"??
.byte $0E,$29,$0F,$A8,$18,$A5,$05,$79             ; 03E45A ........ ?)?????y
.byte $1C,$E5,$85,$05,$22,$F3,$80,$03             ; 03E462 ........ ????"???
.byte $F0,$03,$4C,$FA,$E4,$22,$94,$80             ; 03E46A ........ ??L??"??
.byte $03,$A9,$01,$9D,$D2,$06,$A9,$1C             ; 03E472 ........ ????????
.byte $9D,$44,$07,$A9,$00,$9D,$28,$08             ; 03E47A ........ ?D????(?
.byte $A9,$24,$9D,$BC,$13,$A9,$32,$9D             ; 03E482 ........ ?$????2?
.byte $2E,$14,$A5,$04,$9D,$46,$0B,$A5             ; 03E48A ........ .????F??
.byte $05,$9D,$9C,$0C,$A9,$05,$9D,$4A             ; 03E492 ........ ???????J
.byte $13,$A9,$02,$9D,$D8,$12,$22,$95             ; 03E49A ........ ??????"?
.byte $CA,$0E,$29,$0F,$0A,$A8,$B9,$FC             ; 03E4A2 ........ ??)?????
.byte $E4,$9D,$0C,$09,$B9,$FD,$E4,$9D             ; 03E4AA ........ ????????
.byte $7E,$09,$22,$95,$CA,$0E,$29,$0F             ; 03E4B2 ........ ~?"???)?
.byte $0A,$A8,$B9,$FC,$E4,$9D,$F0,$09             ; 03E4BA ........ ????????
.byte $B9,$FD,$E4,$9D,$62,$0A,$22,$BC             ; 03E4C2 ........ ????b?"?
.byte $AE,$00,$98,$9D,$A0,$14,$A9,$01             ; 03E4CA ........ ????????
.byte $99,$5E,$17,$22,$F1,$AE,$00,$A9             ; 03E4D2 ........ ?^?"????
.byte $08,$85,$1C,$A9,$08,$85,$1D,$22             ; 03E4DA ........ ???????"
.byte $C2,$AF,$00,$22,$95,$CA,$0E,$29             ; 03E4E2 ........ ???"???)
.byte $07,$D0,$0D,$C2,$10,$A9,$07,$A2             ; 03E4EA ........ ????????
.byte $06,$FF,$22,$0F,$83,$0F,$E2,$10             ; 03E4F2 ........ ??"?????
.byte $FA,$60,$00,$00,$00,$00,$40,$00             ; 03E4FA ........ ?`????@?
.byte $C0,$FF,$80,$00,$80,$FF,$C0,$00             ; 03E502 ........ ????????
.byte $40,$FF,$00,$01,$00,$FF,$40,$01             ; 03E50A ........ @?????@?
.byte $C0,$FE,$80,$01,$80,$FE,$C0,$01             ; 03E512 ........ ????????
.byte $40,$FE,$00,$00,$04,$FC,$08,$F8             ; 03E51A ........ @???????
.byte $0C,$F4,$10,$F0,$14,$EC,$18,$E8             ; 03E522 ........ ????????
.byte $1C,$E4                                     ; 03E52B ..       ??

  LDA.W $0694                                     ; 03E52C AD 94 06 
  STA.W EntityXPx,X                              ; 03E52F 9D 46 0B 
  LDA.W $0695                                     ; 03E532 AD 95 06 
  STA.W EntityYPx,X                                   ; 03E535 9D 9C 0C 
  LDA.B $D2                                       ; 03E538 A5 D2 
  AND.B #$01                                      ; 03E53A 29 01 
  BNE.B B_3E543                                   ; 03E53C D0 05 
  LDY.B #$00                                      ; 03E53E A0 00 
  JSR.W L_3E793                                   ; 03E540 20 93 E7 
B_3E543:
  DEC.W EntityV15,X                                   ; 03E543 DE 80 0D 
  BNE.B B_3E55F                                   ; 03E546 D0 17 
  LDA.B #$24                                      ; 03E548 A9 24 
  STA.W EntityV15,X                                   ; 03E54A 9D 80 0D 
  DEC.W EntityV16,X                                   ; 03E54D DE F2 0D 
  BNE.B B_3E55A                                   ; 03E550 D0 08 
  LDA.B #$85                                      ; 03E552 A9 85 
  STA.W EntityTypeId,X                                   ; 03E554 9D 44 07 
  JMP.W AdvanceToNextEntity                                   ; 03E557 4C 41 81 
B_3E55A:
  LDY.B #$00                                      ; 03E55A A0 00 
  JSR.W L_3E6CA                                   ; 03E55C 20 CA E6 
B_3E55F:
  LDA.W EntityV25,X                                   ; 03E55F BD F4 11 
  PHA                                             ; 03E562 48 
  JSL L_3826A                                     ; 03E563 22 6A 82 03 
  PLA                                             ; 03E567 68 
  CMP.W EntityV25,X                                   ; 03E568 DD F4 11 
  BEQ.B B_3E571                                   ; 03E56B F0 04 
  JSL L_DF118                                     ; 03E56D 22 18 F1 0D 
B_3E571:
  JMP.W AdvanceToNextEntity                                   ; 03E571 4C 41 81 
  LDA.W EntityHeader,X                                   ; 03E574 BD D2 06 
  AND.B #$40                                      ; 03E577 29 40 
  BEQ.B B_3E59F                                   ; 03E579 F0 24 
  LDA.W EntityV26,X                                   ; 03E57B BD 66 12 
  CMP.B #$1E                                      ; 03E57E C9 1E 
  BNE.B B_3E599                                   ; 03E580 D0 17 
  LDA.B #$84                                      ; 03E582 A9 84 
  STA.W EntityTypeId,X                                   ; 03E584 9D 44 07 
  LDA.B #$01                                      ; 03E587 A9 01 
  STA.W EntityV15,X                                   ; 03E589 9D 80 0D 
  LDA.B #$04                                      ; 03E58C A9 04 
  STA.W EntityV16,X                                   ; 03E58E 9D F2 0D 
  LDA.B #$1F                                      ; 03E591 A9 1F 
  JSL L_3823C                                     ; 03E593 22 3C 82 03 
  BRA.B B_3E59F                                   ; 03E597 80 06 
B_3E599:
  LDA.B #$1E                                      ; 03E599 A9 1E 
  JSL L_3823C                                     ; 03E59B 22 3C 82 03 
B_3E59F:
  DEC.W EntityV15,X                                   ; 03E59F DE 80 0D 
  BNE.B B_3E5AE                                   ; 03E5A2 D0 0A 
  LDA.B #$07                                      ; 03E5A4 A9 07 
  STA.W EntityV15,X                                   ; 03E5A6 9D 80 0D 
  LDY.B #$01                                      ; 03E5A9 A0 01 
  JSR.W L_3DA1E                                   ; 03E5AB 20 1E DA 
B_3E5AE:
  LDA.W $0694                                     ; 03E5AE AD 94 06 
  STA.W EntityXPx,X                              ; 03E5B1 9D 46 0B 
  LDA.W $0695                                     ; 03E5B4 AD 95 06 
  STA.W EntityYPx,X                                   ; 03E5B7 9D 9C 0C 
  LDA.W EntityV25,X                                   ; 03E5BA BD F4 11 
  PHA                                             ; 03E5BD 48 
  JSL L_3826A                                     ; 03E5BE 22 6A 82 03 
  PLA                                             ; 03E5C2 68 
  CMP.W EntityV25,X                                   ; 03E5C3 DD F4 11 
  BEQ.B B_3E5D8                                   ; 03E5C6 F0 10 
  LDA.W EntityV25,X                                   ; 03E5C8 BD F4 11 
  CMP.B #$04                                      ; 03E5CB C9 04 
  BNE.B B_3E5D4                                   ; 03E5CD D0 05 
  LDA.B #$19                                      ; 03E5CF A9 19 
  STA.W $05D7                                     ; 03E5D1 8D D7 05 
B_3E5D4:
  JSL L_DF1CA                                     ; 03E5D4 22 CA F1 0D 
B_3E5D8:
  JMP.W AdvanceToNextEntity                                   ; 03E5D8 4C 41 81 
  LDA.W $0694                                     ; 03E5DB AD 94 06 
  STA.W EntityXPx,X                              ; 03E5DE 9D 46 0B 
  LDA.W $0695                                     ; 03E5E1 AD 95 06 
  STA.W EntityYPx,X                                   ; 03E5E4 9D 9C 0C 
  LDA.B $D2                                       ; 03E5E7 A5 D2 
  AND.B #$01                                      ; 03E5E9 29 01 
  BNE.B B_3E5F2                                   ; 03E5EB D0 05 
  LDY.B #$01                                      ; 03E5ED A0 01 
  JSR.W L_3E793                                   ; 03E5EF 20 93 E7 
B_3E5F2:
  DEC.W EntityV15,X                                   ; 03E5F2 DE 80 0D 
  BNE.B B_3E60E                                   ; 03E5F5 D0 17 
  LDA.B #$24                                      ; 03E5F7 A9 24 
  STA.W EntityV15,X                                   ; 03E5F9 9D 80 0D 
  DEC.W EntityV16,X                                   ; 03E5FC DE F2 0D 
  BNE.B B_3E609                                   ; 03E5FF D0 08 
  LDA.B #$86                                      ; 03E601 A9 86 
  STA.W EntityTypeId,X                                   ; 03E603 9D 44 07 
  JMP.W AdvanceToNextEntity                                   ; 03E606 4C 41 81 
B_3E609:
  LDY.B #$01                                      ; 03E609 A0 01 
  JSR.W L_3E6CA                                   ; 03E60B 20 CA E6 
B_3E60E:
  LDA.W EntityV25,X                                   ; 03E60E BD F4 11 
  PHA                                             ; 03E611 48 
  JSL L_3826A                                     ; 03E612 22 6A 82 03 
  PLA                                             ; 03E616 68 
  CMP.W EntityV25,X                                   ; 03E617 DD F4 11 
  BEQ.B B_3E620                                   ; 03E61A F0 04 
  JSL L_DF1CA                                     ; 03E61C 22 CA F1 0D 
B_3E620:
  JMP.W AdvanceToNextEntity                                   ; 03E620 4C 41 81 
  LDA.W $0694                                     ; 03E623 AD 94 06 
  STA.W EntityXPx,X                              ; 03E626 9D 46 0B 
  LDA.W $0695                                     ; 03E629 AD 95 06 
  STA.W EntityYPx,X                                   ; 03E62C 9D 9C 0C 
  LDA.W EntityV25,X                                   ; 03E62F BD F4 11 
  PHA                                             ; 03E632 48 
  JSL L_3826A                                     ; 03E633 22 6A 82 03 
  PLA                                             ; 03E637 68 
  CMP.W EntityV25,X                                   ; 03E638 DD F4 11 
  BEQ.B B_3E641                                   ; 03E63B F0 04 
  JSL L_DF118                                     ; 03E63D 22 18 F1 0D 
B_3E641:
  JMP.W AdvanceToNextEntity                                   ; 03E641 4C 41 81 
  LDA.W $0694                                     ; 03E644 AD 94 06 
  STA.W EntityXPx,X                              ; 03E647 9D 46 0B 
  LDA.W $0695                                     ; 03E64A AD 95 06 
  STA.W EntityYPx,X                                   ; 03E64D 9D 9C 0C 
  LDA.W EntityV25,X                                   ; 03E650 BD F4 11 
  PHA                                             ; 03E653 48 
  JSL L_3826A                                     ; 03E654 22 6A 82 03 
  PLA                                             ; 03E658 68 
  CMP.W EntityV25,X                                   ; 03E659 DD F4 11 
  BEQ.B B_3E662                                   ; 03E65C F0 04 
  JSL L_DF1CA                                     ; 03E65E 22 CA F1 0D 
B_3E662:
  JMP.W AdvanceToNextEntity                                   ; 03E662 4C 41 81 

.byte $4C,$41,$81,$4C,$41,$81,$4C,$41             ; 03E665 ........ LA?LA?LA
.byte $81,$4C,$41,$81                             ; 03E66E ....     ?LA?

  LDA.W EntityXPxSpeed,X                                   ; 03E671 BD 7E 09 
  BPL.B B_3E67F                                   ; 03E674 10 09 
  LDA.W EntityXPx,X                              ; 03E676 BD 46 0B 
  CMP.B #$10                                      ; 03E679 C9 10 
  BCC.B B_3E695                                   ; 03E67B 90 18 
  BRA.B B_3E686                                   ; 03E67D 80 07 
B_3E67F:
  LDA.W EntityXPx,X                              ; 03E67F BD 46 0B 
  CMP.B #$F0                                      ; 03E682 C9 F0 
  BCS.B B_3E695                                   ; 03E684 B0 0F 
B_3E686:
  LDA.B #$10                                      ; 03E686 A9 10 
  STA.B $1C                                       ; 03E688 85 1C 
  LDA.B #$10                                      ; 03E68A A9 10 
  STA.B $1D                                       ; 03E68C 85 1D 
  JSL L_AFC2                                      ; 03E68E 22 C2 AF 00 
  JMP.W AdvanceToNextEntity                                   ; 03E692 4C 41 81 
B_3E695:
  STZ.W EntityHeader,X                                   ; 03E695 9E D2 06 
  PHX                                             ; 03E698 DA 
  LDX.W $06A1                                     ; 03E699 AE A1 06 
  DEC.W $18C5,X                                   ; 03E69C DE C5 18 
  BNE.B B_3E6A7                                   ; 03E69F D0 06 
  STZ.W $18C9,X                                   ; 03E6A1 9E C9 18 
  STZ.W $18C1,X                                   ; 03E6A4 9E C1 18 
B_3E6A7:
  PLX                                             ; 03E6A7 FA 
  PHX                                             ; 03E6A8 DA 
  LDY.W EntityV31,X                                   ; 03E6A9 BC A0 14 
  JSL L_AEF1                                      ; 03E6AC 22 F1 AE 00 
  LDA.W EntityV31,X                                   ; 03E6B0 BD A0 14 
  TAX                                             ; 03E6B3 AA 
  STZ.W StateFlags,X                                   ; 03E6B4 9E 5E 17 
  ASL                                             ; 03E6B7 0A 
  ASL                                             ; 03E6B8 0A 
  TAY                                             ; 03E6B9 A8 
  LDA.B #$F0                                      ; 03E6BA A9 F0 
  BCC.B B_3E6C3                                   ; 03E6BC 90 05 

.byte $99,$09,$04,$80,$03                         ; 03E6BF .....    ?????

B_3E6C3:
  STA.W XexzyTorsoY,Y                             ; 03E6C3 99 09 03 
  PLX                                             ; 03E6C6 FA 
  JMP.W AdvanceToNextEntity                                   ; 03E6C7 4C 41 81 

L_3E6CA:
  PHX                                             ; 03E6CA DA 
  STY.B $06                                       ; 03E6CB 84 06 
  CLC                                             ; 03E6CD 18 
  LDA.W EntityXPx,X                              ; 03E6CE BD 46 0B 
  ADC.W D_3E77F,Y                                 ; 03E6D1 79 7F E7 
  STA.B $04                                       ; 03E6D4 85 04 
  SEC                                             ; 03E6D6 38 
  LDA.W EntityYPx,X                                   ; 03E6D7 BD 9C 0C 
  SBC.B #$0B                                      ; 03E6DA E9 0B 
  STA.B $05                                       ; 03E6DC 85 05 
  JSL FindEmptyEntitySlot                                     ; 03E6DE 22 F3 80 03 
  BEQ.B B_3E6E7                                   ; 03E6E2 F0 03 

.byte $4C,$7B,$E7                                 ; 03E6E5 ...      L{?

B_3E6E7:
  JSL ClearEntitySlotData                                     ; 03E6E7 22 94 80 03 
  LDA.B #$13                                      ; 03E6EB A9 13 
  LDY.W $069E                                     ; 03E6ED AC 9E 06 
  BEQ.B B_3E6F4                                   ; 03E6F0 F0 02 

.byte $A9,$15                                     ; 03E6F3 ..       ??

B_3E6F4:
  JSL L_38064                                     ; 03E6F4 22 64 80 03 
  BPL.B B_3E6FD                                   ; 03E6F8 10 03 

.byte $4C,$7B,$E7                                 ; 03E6FB ...      L{?

B_3E6FD:
  STY.W $06A1                                     ; 03E6FD 8C A1 06 
  TYA                                             ; 03E700 98 
  ASL                                             ; 03E701 0A 
  ORA.B #$08                                      ; 03E702 09 08 
  STA.W EntityV2,X                                   ; 03E704 9D B6 07 
  ORA.B #$30                                      ; 03E707 09 30 
  STA.W EntityV30,X                                   ; 03E709 9D 2E 14 
  LDY.B $06                                       ; 03E70C A4 06 
  LDA.W D_3E77D,Y                                 ; 03E70E B9 7D E7 
  ORA.W EntityV30,X                                   ; 03E711 1D 2E 14 
  STA.W EntityV30,X                                   ; 03E714 9D 2E 14 
  LDA.B #$01                                      ; 03E717 A9 01 
  STA.W EntityHeader,X                                   ; 03E719 9D D2 06 
  LDA.B #$8B                                      ; 03E71C A9 8B 
  STA.W EntityTypeId,X                                   ; 03E71E 9D 44 07 
  LDA.B #$00                                      ; 03E721 A9 00 
  STA.W EntityV3,X                                   ; 03E723 9D 28 08 
  LDA.B #$C0                                      ; 03E726 A9 C0 
  STA.W EntityV29,X                                   ; 03E728 9D BC 13 
  LDA.B $04                                       ; 03E72B A5 04 
  STA.W EntityXPx,X                              ; 03E72D 9D 46 0B 
  LDA.B $05                                       ; 03E730 A5 05 
  STA.W EntityYPx,X                                   ; 03E732 9D 9C 0C 
  LDY.B $06                                       ; 03E735 A4 06 
  LDA.W D_3E781,Y                                 ; 03E737 B9 81 E7 
  STA.W EntityXPxSpeed,X                                   ; 03E73A 9D 7E 09 
  JSL AdvanceRNG                                     ; 03E73D 22 95 CA 0E 
  AND.B #$07                                      ; 03E741 29 07 
  ASL                                             ; 03E743 0A 
  TAY                                             ; 03E744 A8 
  LDA.W D_3E783,Y                                 ; 03E745 B9 83 E7 
  STA.W EntityYSubPxSpeed,X                                   ; 03E748 9D F0 09 
  LDA.W D_3E784,Y                                 ; 03E74B B9 84 E7 
  STA.W EntityYPxSpeed,X                                   ; 03E74E 9D 62 0A 
  JSL L_AEBC                                      ; 03E751 22 BC AE 00 
  TYA                                             ; 03E755 98 
  STA.W EntityV31,X                                   ; 03E756 9D A0 14 
  LDA.B #$01                                      ; 03E759 A9 01 
  STA.W StateFlags,Y                                   ; 03E75B 99 5E 17 
  JSL L_AED8                                      ; 03E75E 22 D8 AE 00 
  LDA.B #$10                                      ; 03E762 A9 10 
  STA.B $1C                                       ; 03E764 85 1C 
  LDA.B #$10                                      ; 03E766 A9 10 
  STA.B $1D                                       ; 03E768 85 1D 
  JSL L_AFC2                                      ; 03E76A 22 C2 AF 00 
  REP.B #P_Idx8Bit                                      ; 03E76E C2 10 
  LDA.B #$07                                      ; 03E770 A9 07 
  LDX.W #$FF06                                    ; 03E772 A2 06 FF 
  JSL Audio_F830F                                     ; 03E775 22 0F 83 0F 
  SEP.B #P_Idx8Bit                                      ; 03E779 E2 10 
  PLX                                             ; 03E77B FA 
  RTS                                             ; 03E77C 60 


D_3E77D:
.byte $01,$41                                     ; 03E77E DD       ?A
D_3E77F:
.byte $D6,$2A                                     ; 03E780 DD       ?*
D_3E781:
.byte $FC,$04                                     ; 03E782 DD       ??
D_3E783:
.byte $00                                         ; 03E784 .        ?
D_3E784:
.byte $00,$40,$00,$60,$00,$80,$00,$80             ; 03E784 .DDDDDDD ?@?`????
.byte $FF,$A0,$FF,$C0,$FF,$00,$00                 ; 03E78D DDDDDDD  ???????


L_3E793:
  PHX                                             ; 03E793 DA 
  STY.B $06                                       ; 03E794 84 06 
  CLC                                             ; 03E796 18 
  LDA.W EntityXPx,X                              ; 03E797 BD 46 0B 
  ADC.W D_3E871,Y                                 ; 03E79A 79 71 E8 
  STA.B $04                                       ; 03E79D 85 04 
  SEC                                             ; 03E79F 38 
  LDA.W EntityYPx,X                                   ; 03E7A0 BD 9C 0C 
  SBC.B #$0D                                      ; 03E7A3 E9 0D 
  STA.B $05                                       ; 03E7A5 85 05 
  JSL AdvanceRNG                                     ; 03E7A7 22 95 CA 0E 
  AND.B #$07                                      ; 03E7AB 29 07 
  TAY                                             ; 03E7AD A8 
  CLC                                             ; 03E7AE 18 
  LDA.B $04                                       ; 03E7AF A5 04 
  ADC.W D_3E873,Y                                 ; 03E7B1 79 73 E8 
  STA.B $04                                       ; 03E7B4 85 04 
  JSL AdvanceRNG                                     ; 03E7B6 22 95 CA 0E 
  AND.B #$07                                      ; 03E7BA 29 07 
  TAY                                             ; 03E7BC A8 
  CLC                                             ; 03E7BD 18 
  LDA.B $05                                       ; 03E7BE A5 05 
  ADC.W D_3E873,Y                                 ; 03E7C0 79 73 E8 
  STA.B $05                                       ; 03E7C3 85 05 
  JSL FindEmptyEntitySlot                                     ; 03E7C5 22 F3 80 03 
  BEQ.B B_3E7CE                                   ; 03E7C9 F0 03 

.byte $4C,$4D,$E8                                 ; 03E7CC ...      LM?

B_3E7CE:
  JSL ClearEntitySlotData                                     ; 03E7CE 22 94 80 03 
  LDA.B #$01                                      ; 03E7D2 A9 01 
  STA.W EntityHeader,X                                   ; 03E7D4 9D D2 06 
  LDA.B #$1C                                      ; 03E7D7 A9 1C 
  STA.W EntityTypeId,X                                   ; 03E7D9 9D 44 07 
  LDA.B #$00                                      ; 03E7DC A9 00 
  STA.W EntityV3,X                                   ; 03E7DE 9D 28 08 
  LDA.B #$24                                      ; 03E7E1 A9 24 
  STA.W EntityV29,X                                   ; 03E7E3 9D BC 13 
  LDA.B #$32                                      ; 03E7E6 A9 32 
  STA.W EntityV30,X                                   ; 03E7E8 9D 2E 14 
  LDA.B $04                                       ; 03E7EB A5 04 
  STA.W EntityXPx,X                              ; 03E7ED 9D 46 0B 
  LDA.B $05                                       ; 03E7F0 A5 05 
  STA.W EntityYPx,X                                   ; 03E7F2 9D 9C 0C 
  LDA.B #$05                                      ; 03E7F5 A9 05 
  STA.W EntityV28,X                                   ; 03E7F7 9D 4A 13 
  LDA.B #$02                                      ; 03E7FA A9 02 
  STA.W EntityV27,X                                   ; 03E7FC 9D D8 12 
  LDY.B $06                                       ; 03E7FF A4 06 
  LDA.W D_3E84F,Y                                 ; 03E801 B9 4F E8 
  STA.W EntityXPxSpeed,X                                   ; 03E804 9D 7E 09 
  JSL AdvanceRNG                                     ; 03E807 22 95 CA 0E 
  AND.B #$0F                                      ; 03E80B 29 0F 
  ASL                                             ; 03E80D 0A 
  TAY                                             ; 03E80E A8 
  LDA.W D_3E851,Y                                 ; 03E80F B9 51 E8 
  STA.W EntityYSubPxSpeed,X                                   ; 03E812 9D F0 09 
  LDA.W D_3E852,Y                                 ; 03E815 B9 52 E8 
  STA.W EntityYPxSpeed,X                                   ; 03E818 9D 62 0A 
  JSL L_AEBC                                      ; 03E81B 22 BC AE 00 
  TYA                                             ; 03E81F 98 
  STA.W EntityV31,X                                   ; 03E820 9D A0 14 
  LDA.B #$01                                      ; 03E823 A9 01 
  STA.W StateFlags,Y                                   ; 03E825 99 5E 17 
  JSL L_AEF1                                      ; 03E828 22 F1 AE 00 
  LDA.B #$08                                      ; 03E82C A9 08 
  STA.B $1C                                       ; 03E82E 85 1C 
  LDA.B #$08                                      ; 03E830 A9 08 
  STA.B $1D                                       ; 03E832 85 1D 
  JSL L_AFC2                                      ; 03E834 22 C2 AF 00 
  JSL AdvanceRNG                                     ; 03E838 22 95 CA 0E 
  AND.B #$03                                      ; 03E83C 29 03 
  BNE.B B_3E84D                                   ; 03E83E D0 0D 
  REP.B #P_Idx8Bit                                      ; 03E840 C2 10 
  LDA.B #$07                                      ; 03E842 A9 07 
  LDX.W #$FF06                                    ; 03E844 A2 06 FF 
  JSL Audio_F830F                                     ; 03E847 22 0F 83 0F 
  SEP.B #P_Idx8Bit                                      ; 03E84B E2 10 
B_3E84D:
  PLX                                             ; 03E84D FA 
  RTS                                             ; 03E84E 60 


D_3E84F:
.byte $FE,$02                                     ; 03E850 DD       ??
D_3E851:
.byte $00                                         ; 03E852 D        ?
D_3E852:
.byte $00,$80,$00,$C0,$00,$00,$01,$40             ; 03E852 DDDDDDDD ???????@
.byte $01,$80,$01,$C0,$01,$40,$00,$C0             ; 03E85A DDDDDDDD ?????@??
.byte $FF,$80,$FF,$40,$FF,$00,$FF,$C0             ; 03E862 DDDDDDDD ???@????
.byte $FE,$80,$FE,$40,$FE,$00,$FF                 ; 03E86B DDDDDDD  ???@???
D_3E871:
.byte $EE,$12                                     ; 03E872 DD       ??
D_3E873:
.byte $00,$FE,$02,$FD,$03,$FC,$04,$00             ; 03E873 DDDDDDDD ????????

  DEC.W EntityV15,X                                   ; 03E87B DE 80 0D 
  BNE.B B_3E8AC                                   ; 03E87E D0 2C 
  JSL AdvanceRNG                                     ; 03E880 22 95 CA 0E 
  AND.B #$03                                      ; 03E884 29 03 
  TAY                                             ; 03E886 A8 
  LDA.W D_3EA73,Y                                 ; 03E887 B9 73 EA 
  STA.W EntityV21,X                                   ; 03E88A 9D 2C 10 
  LDA.W D_3EA77,Y                                 ; 03E88D B9 77 EA 
  STA.W EntityV15,X                                   ; 03E890 9D 80 0D 
  LDA.B #$1E                                      ; 03E893 A9 1E 
  STA.W EntityV16,X                                   ; 03E895 9D F2 0D 
  LDA.B #$8D                                      ; 03E898 A9 8D 
  STA.W EntityTypeId,X                                   ; 03E89A 9D 44 07 
  STZ.W EntityXSubPxSpeed,X                                   ; 03E89D 9E 0C 09 
  STZ.W EntityXPxSpeed,X                                   ; 03E8A0 9E 7E 09 
  STZ.W EntityYSubPxSpeed,X                                   ; 03E8A3 9E F0 09 
  STZ.W EntityYPxSpeed,X                                   ; 03E8A6 9E 62 0A 
  JMP.W D_3EA39                                   ; 03E8A9 4C 39 EA 
B_3E8AC:
  LDA.W EntityV25,X                                   ; 03E8AC BD F4 11 
  LSR                                             ; 03E8AF 4A 
  TAY                                             ; 03E8B0 A8 
  BEQ.B B_3E8C9                                   ; 03E8B1 F0 16 
  DEY                                             ; 03E8B3 88 
  BEQ.B B_3E8D9                                   ; 03E8B4 F0 23 
  DEY                                             ; 03E8B6 88 
  BEQ.B B_3E8E9                                   ; 03E8B7 F0 30 
  SEC                                             ; 03E8B9 38 
  LDA.W EntityXSubPxSpeed,X                                   ; 03E8BA BD 0C 09 
  SBC.B #$06                                      ; 03E8BD E9 06 
  STA.W EntityXSubPxSpeed,X                                   ; 03E8BF 9D 0C 09 
  BCS.B B_3E8C7                                   ; 03E8C2 B0 03 
  DEC.W EntityXPxSpeed,X                                   ; 03E8C4 DE 7E 09 
B_3E8C7:
  BRA.B B_3E8F7                                   ; 03E8C7 80 2E 
B_3E8C9:
  SEC                                             ; 03E8C9 38 
  LDA.W EntityYSubPxSpeed,X                                   ; 03E8CA BD F0 09 
  SBC.B #$06                                      ; 03E8CD E9 06 
  STA.W EntityYSubPxSpeed,X                                   ; 03E8CF 9D F0 09 
  BCS.B B_3E8D7                                   ; 03E8D2 B0 03 
  DEC.W EntityYPxSpeed,X                                   ; 03E8D4 DE 62 0A 
B_3E8D7:
  BRA.B B_3E8F7                                   ; 03E8D7 80 1E 
B_3E8D9:
  CLC                                             ; 03E8D9 18 
  LDA.W EntityXSubPxSpeed,X                                   ; 03E8DA BD 0C 09 
  ADC.B #$06                                      ; 03E8DD 69 06 
  STA.W EntityXSubPxSpeed,X                                   ; 03E8DF 9D 0C 09 
  BCC.B B_3E8E7                                   ; 03E8E2 90 03 

.byte $FE,$7E,$09                                 ; 03E8E5 ...      ?~?

B_3E8E7:
  BRA.B B_3E8F7                                   ; 03E8E7 80 0E 
B_3E8E9:
  CLC                                             ; 03E8E9 18 
  LDA.W EntityYSubPxSpeed,X                                   ; 03E8EA BD F0 09 
  ADC.B #$06                                      ; 03E8ED 69 06 
  STA.W EntityYSubPxSpeed,X                                   ; 03E8EF 9D F0 09 
  BCC.B B_3E8F7                                   ; 03E8F2 90 03 

.byte $FE,$62,$0A                                 ; 03E8F5 ...      ?b?

B_3E8F7:
  LDA.W EntityXSubPxSpeed,X                                   ; 03E8F7 BD 0C 09 
  STA.B $04                                       ; 03E8FA 85 04 
  LDA.W EntityXPxSpeed,X                                   ; 03E8FC BD 7E 09 
  STA.B $05                                       ; 03E8FF 85 05 
  BPL.B B_3E929                                   ; 03E901 10 26 
  ORA.B $04                                       ; 03E903 05 04 
  BEQ.B B_3E93E                                   ; 03E905 F0 37 
  REP.B #P_Acc8Bit                                      ; 03E907 C2 20 
  SEC                                             ; 03E909 38 
  LDA.W #$0000                                    ; 03E90A A9 00 00 
  SBC.B $04                                       ; 03E90D E5 04 
  STA.B $04                                       ; 03E90F 85 04 
  CMP.W #$00C0                                    ; 03E911 C9 C0 00 
  BCC.B B_3E93E                                   ; 03E914 90 28 
  SEP.B #P_Acc8Bit                                      ; 03E916 E2 20 
  SEC                                             ; 03E918 38 
  LDA.B #$00                                      ; 03E919 A9 00 
  SBC.B #$C0                                      ; 03E91B E9 C0 
  STA.W EntityXSubPxSpeed,X                                   ; 03E91D 9D 0C 09 
  LDA.B #$00                                      ; 03E920 A9 00 
  SBC.B #$00                                      ; 03E922 E9 00 
  STA.W EntityXPxSpeed,X                                   ; 03E924 9D 7E 09 
  BRA.B B_3E940                                   ; 03E927 80 17 
B_3E929:
  REP.B #P_Acc8Bit                                      ; 03E929 C2 20 
  LDA.B $04                                       ; 03E92B A5 04 
  CMP.W #$00C0                                    ; 03E92D C9 C0 00 
  BCC.B B_3E93E                                   ; 03E930 90 0C 
  SEP.B #P_Acc8Bit                                      ; 03E932 E2 20 
  LDA.B #$C0                                      ; 03E934 A9 C0 
  STA.W EntityXSubPxSpeed,X                                   ; 03E936 9D 0C 09 
  LDA.B #$00                                      ; 03E939 A9 00 
  STA.W EntityXPxSpeed,X                                   ; 03E93B 9D 7E 09 
B_3E93E:
  SEP.B #P_Acc8Bit                                      ; 03E93E E2 20 
B_3E940:
  LDA.W EntityYSubPxSpeed,X                                   ; 03E940 BD F0 09 
  STA.B $04                                       ; 03E943 85 04 
  LDA.W EntityYPxSpeed,X                                   ; 03E945 BD 62 0A 
  STA.B $05                                       ; 03E948 85 05 
  BPL.B B_3E972                                   ; 03E94A 10 26 
  ORA.B $04                                       ; 03E94C 05 04 
  BEQ.B B_3E987                                   ; 03E94E F0 37 
  REP.B #P_Acc8Bit                                      ; 03E950 C2 20 
  SEC                                             ; 03E952 38 
  LDA.W #$0000                                    ; 03E953 A9 00 00 
  SBC.B $04                                       ; 03E956 E5 04 
  STA.B $04                                       ; 03E958 85 04 
  CMP.W #$00C0                                    ; 03E95A C9 C0 00 
  BCC.B B_3E987                                   ; 03E95D 90 28 
  SEP.B #P_Acc8Bit                                      ; 03E95F E2 20 
  SEC                                             ; 03E961 38 
  LDA.B #$00                                      ; 03E962 A9 00 
  SBC.B #$C0                                      ; 03E964 E9 C0 
  STA.W EntityYSubPxSpeed,X                                   ; 03E966 9D F0 09 
  LDA.B #$00                                      ; 03E969 A9 00 
  SBC.B #$00                                      ; 03E96B E9 00 
  STA.W EntityYPxSpeed,X                                   ; 03E96D 9D 62 0A 
  BRA.B B_3E989                                   ; 03E970 80 17 
B_3E972:
  REP.B #P_Acc8Bit                                      ; 03E972 C2 20 
  LDA.B $04                                       ; 03E974 A5 04 
  CMP.W #$00C0                                    ; 03E976 C9 C0 00 
  BCC.B B_3E987                                   ; 03E979 90 0C 
  SEP.B #P_Acc8Bit                                      ; 03E97B E2 20 
  LDA.B #$C0                                      ; 03E97D A9 C0 
  STA.W EntityYSubPxSpeed,X                                   ; 03E97F 9D F0 09 
  LDA.B #$00                                      ; 03E982 A9 00 
  STA.W EntityYPxSpeed,X                                   ; 03E984 9D 62 0A 
B_3E987:
  SEP.B #P_Acc8Bit                                      ; 03E987 E2 20 
B_3E989:
  LDA.W EntityXPxSpeed,X                                   ; 03E989 BD 7E 09 
  BMI.B B_3E9BB                                   ; 03E98C 30 2D 
  ORA.W EntityXSubPxSpeed,X                                   ; 03E98E 1D 0C 09 
  BEQ.B B_3E9E1                                   ; 03E991 F0 4E 
  LDA.B #$E4                                      ; 03E993 A9 E4 
  CMP.W EntityXPx,X                              ; 03E995 DD 46 0B 
  BCS.B B_3E9E1                                   ; 03E998 B0 47 

.byte $9D,$46,$0B,$A9,$D0,$9D,$0C,$09             ; 03E99A ........ ?F??????
.byte $A9,$FF,$9D,$7E,$09,$9E,$2C,$10             ; 03E9A2 ........ ???~??,?
.byte $A9,$04,$9D,$80,$0D,$A9,$32,$9D             ; 03E9AA ........ ??????2?
.byte $F2,$0D,$A9,$8D,$9D,$44,$07,$80             ; 03E9B2 ........ ?????D??
.byte $26                                         ; 03E9BB .        &

B_3E9BB:
  LDA.B #$1C                                      ; 03E9BB A9 1C 
  CMP.W EntityXPx,X                              ; 03E9BD DD 46 0B 
  BCC.B B_3E9E1                                   ; 03E9C0 90 1F 

.byte $9D,$46,$0B,$A9,$30,$9D,$0C,$09             ; 03E9C2 ........ ?F??0???
.byte $A9,$00,$9D,$7E,$09,$9E,$2C,$10             ; 03E9CA ........ ???~??,?
.byte $A9,$04,$9D,$80,$0D,$A9,$32,$9D             ; 03E9D2 ........ ??????2?
.byte $F2,$0D,$A9,$8D,$9D,$44,$07                 ; 03E9DB .......  ?????D?

B_3E9E1:
  LDA.W EntityYPxSpeed,X                                   ; 03E9E1 BD 62 0A 
  BMI.B B_3EA13                                   ; 03E9E4 30 2D 
  ORA.W EntityYSubPxSpeed,X                                   ; 03E9E6 1D F0 09 
  BEQ.B D_3EA39                                   ; 03E9E9 F0 4E 
  LDA.B #$D2                                      ; 03E9EB A9 D2 
  CMP.W EntityYPx,X                                   ; 03E9ED DD 9C 0C 
  BCS.B D_3EA39                                   ; 03E9F0 B0 47 

.byte $9D,$9C,$0C,$A9,$D0,$9D,$F0,$09             ; 03E9F2 ........ ????????
.byte $A9,$FF,$9D,$62,$0A,$9E,$2C,$10             ; 03E9FA ........ ???b??,?
.byte $A9,$04,$9D,$80,$0D,$A9,$32,$9D             ; 03EA02 ........ ??????2?
.byte $F2,$0D,$A9,$8D,$9D,$44,$07,$80             ; 03EA0A ........ ?????D??
.byte $26                                         ; 03EA13 .        &

B_3EA13:
  LDA.B #$2A                                      ; 03EA13 A9 2A 
  CMP.W EntityYPx,X                                   ; 03EA15 DD 9C 0C 
  BCC.B D_3EA39                                   ; 03EA18 90 1F 
  STA.W EntityYPx,X                                   ; 03EA1A 9D 9C 0C 
  LDA.B #$30                                      ; 03EA1D A9 30 
  STA.W EntityYSubPxSpeed,X                                   ; 03EA1F 9D F0 09 
  LDA.B #$00                                      ; 03EA22 A9 00 
  STA.W EntityYPxSpeed,X                                   ; 03EA24 9D 62 0A 
  STZ.W EntityV21,X                                   ; 03EA27 9E 2C 10 
  LDA.B #$04                                      ; 03EA2A A9 04 
  STA.W EntityV15,X                                   ; 03EA2C 9D 80 0D 
  LDA.B #$32                                      ; 03EA2F A9 32 
  STA.W EntityV16,X                                   ; 03EA31 9D F2 0D 
  LDA.B #$8D                                      ; 03EA34 A9 8D 
  STA.W EntityTypeId,X                                   ; 03EA36 9D 44 07 
D_3EA39:
  SEC                                             ; 03EA39 38 
  LDA.W EntityXPx,X                              ; 03EA3A BD 46 0B 
  SBC.B #$0B                                      ; 03EA3D E9 0B 
  BCS.B B_3EA43                                   ; 03EA3F B0 02 
  LDA.B #$00                                      ; 03EA41 A9 00 
B_3EA43:
  STA.W EntityV32,X                                   ; 03EA43 9D 16 15 
  CLC                                             ; 03EA46 18 
  LDA.W EntityXPx,X                              ; 03EA47 BD 46 0B 
  ADC.B #$0B                                      ; 03EA4A 69 0B 
  BCC.B B_3EA50                                   ; 03EA4C 90 02 

.byte $A9,$FF                                     ; 03EA4F ..       ??

B_3EA50:
  STA.W EntityV33,X                                   ; 03EA50 9D 88 15 
  SEC                                             ; 03EA53 38 
  LDA.W EntityYPx,X                                   ; 03EA54 BD 9C 0C 
  SBC.B #$09                                      ; 03EA57 E9 09 
  BCS.B B_3EA5D                                   ; 03EA59 B0 02 
  LDA.B #$00                                      ; 03EA5B A9 00 
B_3EA5D:
  STA.W EntityV34,X                                   ; 03EA5D 9D FA 15 
  CLC                                             ; 03EA60 18 
  LDA.W EntityYPx,X                                   ; 03EA61 BD 9C 0C 
  ADC.B #$09                                      ; 03EA64 69 09 
  BCC.B B_3EA6A                                   ; 03EA66 90 02 

.byte $A9,$FF                                     ; 03EA69 ..       ??

B_3EA6A:
  STA.W EntityV35,X                                   ; 03EA6A 9D 6C 16 
  JSR.W L_3F0E3                                   ; 03EA6D 20 E3 F0 
  JMP.W AdvanceToNextEntity                                   ; 03EA70 4C 41 81 

D_3EA73:
.byte $00,$01,$00,$01                             ; 03EA74 DD.D     ????
D_3EA77:
.byte $02,$02,$04,$04                             ; 03EA78 DD.D     ????

  DEC.W EntityV16,X                                   ; 03EA7B DE F2 0D 
  BNE.B B_3EABF                                   ; 03EA7E D0 3F 
  STZ.W EntityXSubPxSpeed,X                                   ; 03EA80 9E 0C 09 
  STZ.W EntityXPxSpeed,X                                   ; 03EA83 9E 7E 09 
  STZ.W EntityYSubPxSpeed,X                                   ; 03EA86 9E F0 09 
  STZ.W EntityYPxSpeed,X                                   ; 03EA89 9E 62 0A 
  LDA.B #$09                                      ; 03EA8C A9 09 
  STA.W EntityV16,X                                   ; 03EA8E 9D F2 0D 
  LDA.W EntityV21,X                                   ; 03EA91 BD 2C 10 
  BEQ.B B_3EAA1                                   ; 03EA94 F0 0B 
  LDA.W EntityV25,X                                   ; 03EA96 BD F4 11 
  DEC A
  AND.B #$07                                      ; 03EA9A 29 07 
  STA.W EntityV25,X                                   ; 03EA9C 9D F4 11 
  BRA.B B_3EAAA                                   ; 03EA9F 80 09 
B_3EAA1:
  LDA.W EntityV25,X                                   ; 03EAA1 BD F4 11 
  INC A
  AND.B #$07                                      ; 03EAA5 29 07 
  STA.W EntityV25,X                                   ; 03EAA7 9D F4 11 
B_3EAAA:
  DEC.W EntityV15,X                                   ; 03EAAA DE 80 0D 
  BNE.B B_3EABF                                   ; 03EAAD D0 10 
  LDA.B #$8C                                      ; 03EAAF A9 8C 
  STA.W EntityTypeId,X                                   ; 03EAB1 9D 44 07 
  JSL AdvanceRNG                                     ; 03EAB4 22 95 CA 0E 
  AND.B #$3F                                      ; 03EAB8 29 3F 
  ADC.B #$5A                                      ; 03EABA 69 5A 
  STA.W EntityV15,X                                   ; 03EABC 9D 80 0D 
B_3EABF:
  SEC                                             ; 03EABF 38 
  LDA.W EntityXPx,X                              ; 03EAC0 BD 46 0B 
  SBC.B #$0B                                      ; 03EAC3 E9 0B 
  BCS.B B_3EAC9                                   ; 03EAC5 B0 02 

.byte $A9,$00                                     ; 03EAC8 ..       ??

B_3EAC9:
  STA.W EntityV32,X                                   ; 03EAC9 9D 16 15 
  CLC                                             ; 03EACC 18 
  LDA.W EntityXPx,X                              ; 03EACD BD 46 0B 
  ADC.B #$0B                                      ; 03EAD0 69 0B 
  BCC.B B_3EAD6                                   ; 03EAD2 90 02 

.byte $A9,$FF                                     ; 03EAD5 ..       ??

B_3EAD6:
  STA.W EntityV33,X                                   ; 03EAD6 9D 88 15 
  SEC                                             ; 03EAD9 38 
  LDA.W EntityYPx,X                                   ; 03EADA BD 9C 0C 
  SBC.B #$09                                      ; 03EADD E9 09 
  BCS.B B_3EAE3                                   ; 03EADF B0 02 

.byte $A9,$00                                     ; 03EAE2 ..       ??

B_3EAE3:
  STA.W EntityV34,X                                   ; 03EAE3 9D FA 15 
  CLC                                             ; 03EAE6 18 
  LDA.W EntityYPx,X                                   ; 03EAE7 BD 9C 0C 
  ADC.B #$09                                      ; 03EAEA 69 09 
  BCC.B B_3EAF0                                   ; 03EAEC 90 02 

.byte $A9,$FF                                     ; 03EAEF ..       ??

B_3EAF0:
  STA.W EntityV35,X                                   ; 03EAF0 9D 6C 16 
  JSR.W L_3F0E3                                   ; 03EAF3 20 E3 F0 
  JMP.W AdvanceToNextEntity                                   ; 03EAF6 4C 41 81 

.byte $4C,$41,$81                                 ; 03EAFA ...      LA?

  DEC.W EntityV15,X                                   ; 03EAFC DE 80 0D 
  BNE.B B_3EB32                                   ; 03EAFF D0 31 
  JSL AdvanceRNG                                     ; 03EB01 22 95 CA 0E 
  AND.B #$01                                      ; 03EB05 29 01 
  CLC                                             ; 03EB07 18 
  ADC.B #$05                                      ; 03EB08 69 05 
  STA.W EntityV15,X                                   ; 03EB0A 9D 80 0D 
  DEC.W EntityV16,X                                   ; 03EB0D DE F2 0D 
  BNE.B B_3EB22                                   ; 03EB10 D0 10 
  LDA.B #$92                                      ; 03EB12 A9 92 
  STA.W EntityTypeId,X                                   ; 03EB14 9D 44 07 
  JSL AdvanceRNG                                     ; 03EB17 22 95 CA 0E 
  AND.B #$0F                                      ; 03EB1B 29 0F 
  ADC.B #$10                                      ; 03EB1D 69 10 
  STA.W EntityV15,X                                   ; 03EB1F 9D 80 0D 
B_3EB22:
  LDA.W EntityV25,X                                   ; 03EB22 BD F4 11 
  ORA.B #$10                                      ; 03EB25 09 10 
  STA.W EntityV25,X                                   ; 03EB27 9D F4 11 
  LDA.B #$03                                      ; 03EB2A A9 03 
  STA.W EntityV22,X                                   ; 03EB2C 9D 9E 10 
  JSR.W L_3EF0B                                   ; 03EB2F 20 0B EF 
B_3EB32:
  SEC                                             ; 03EB32 38 
  LDA.W EntityXPx,X                              ; 03EB33 BD 46 0B 
  SBC.B #$08                                      ; 03EB36 E9 08 
  BCS.B B_3EB3C                                   ; 03EB38 B0 02 

.byte $A9,$00                                     ; 03EB3B ..       ??

B_3EB3C:
  STA.W EntityV32,X                                   ; 03EB3C 9D 16 15 
  CLC                                             ; 03EB3F 18 
  LDA.W EntityXPx,X                              ; 03EB40 BD 46 0B 
  ADC.B #$08                                      ; 03EB43 69 08 
  BCC.B B_3EB49                                   ; 03EB45 90 02 

.byte $A9,$FF                                     ; 03EB48 ..       ??

B_3EB49:
  STA.W EntityV33,X                                   ; 03EB49 9D 88 15 
  SEC                                             ; 03EB4C 38 
  LDA.W EntityYPx,X                                   ; 03EB4D BD 9C 0C 
  SBC.B #$0A                                      ; 03EB50 E9 0A 
  BCS.B B_3EB56                                   ; 03EB52 B0 02 

.byte $A9,$00                                     ; 03EB55 ..       ??

B_3EB56:
  STA.W EntityV34,X                                   ; 03EB56 9D FA 15 
  CLC                                             ; 03EB59 18 
  LDA.W EntityYPx,X                                   ; 03EB5A BD 9C 0C 
  ADC.B #$0A                                      ; 03EB5D 69 0A 
  BCC.B B_3EB63                                   ; 03EB5F 90 02 

.byte $A9,$FF                                     ; 03EB62 ..       ??

B_3EB63:
  STA.W EntityV35,X                                   ; 03EB63 9D 6C 16 
  JSR.W L_3EDA3                                   ; 03EB66 20 A3 ED 
  JMP.W AdvanceToNextEntity                                   ; 03EB69 4C 41 81 
  DEC.W EntityV15,X                                   ; 03EB6C DE 80 0D 
  BNE.B B_3EBB4                                   ; 03EB6F D0 43 
  LDA.B #$08                                      ; 03EB71 A9 08 
  STA.W EntityV15,X                                   ; 03EB73 9D 80 0D 
  LDA.W EntityV25,X                                   ; 03EB76 BD F4 11 
  CMP.W EntityV22,X                                   ; 03EB79 DD 9E 10 
  BEQ.B B_3EB96                                   ; 03EB7C F0 18 
  BCC.B B_3EB8B                                   ; 03EB7E 90 0B 
  LDA.W EntityV25,X                                   ; 03EB80 BD F4 11 
  DEC A
  AND.B #$0F                                      ; 03EB84 29 0F 
  STA.W EntityV25,X                                   ; 03EB86 9D F4 11 
  BRA.B B_3EBAD                                   ; 03EB89 80 22 
B_3EB8B:
  LDA.W EntityV25,X                                   ; 03EB8B BD F4 11 
  INC A
  AND.B #$0F                                      ; 03EB8F 29 0F 
  STA.W EntityV25,X                                   ; 03EB91 9D F4 11 
  BRA.B B_3EBAD                                   ; 03EB94 80 17 
B_3EB96:
  LDA.B #$90                                      ; 03EB96 A9 90 
  STA.W EntityTypeId,X                                   ; 03EB98 9D 44 07 
  LDA.B #$01                                      ; 03EB9B A9 01 
  STA.W EntityV15,X                                   ; 03EB9D 9D 80 0D 
  JSL AdvanceRNG                                     ; 03EBA0 22 95 CA 0E 
  AND.B #$07                                      ; 03EBA4 29 07 
  TAY                                             ; 03EBA6 A8 
  LDA.W D_3EBEE,Y                                 ; 03EBA7 B9 EE EB 
  STA.W EntityV16,X                                   ; 03EBAA 9D F2 0D 
B_3EBAD:
  LDA.W EntityV23,X                                   ; 03EBAD BD 10 11 
  JSL L_3F032                                     ; 03EBB0 22 32 F0 03 
B_3EBB4:
  SEC                                             ; 03EBB4 38 
  LDA.W EntityXPx,X                              ; 03EBB5 BD 46 0B 
  SBC.B #$08                                      ; 03EBB8 E9 08 
  BCS.B B_3EBBE                                   ; 03EBBA B0 02 

.byte $A9,$00                                     ; 03EBBD ..       ??

B_3EBBE:
  STA.W EntityV32,X                                   ; 03EBBE 9D 16 15 
  CLC                                             ; 03EBC1 18 
  LDA.W EntityXPx,X                              ; 03EBC2 BD 46 0B 
  ADC.B #$08                                      ; 03EBC5 69 08 
  BCC.B B_3EBCB                                   ; 03EBC7 90 02 

.byte $A9,$FF                                     ; 03EBCA ..       ??

B_3EBCB:
  STA.W EntityV33,X                                   ; 03EBCB 9D 88 15 
  SEC                                             ; 03EBCE 38 
  LDA.W EntityYPx,X                                   ; 03EBCF BD 9C 0C 
  SBC.B #$0A                                      ; 03EBD2 E9 0A 
  BCS.B B_3EBD8                                   ; 03EBD4 B0 02 

.byte $A9,$00                                     ; 03EBD7 ..       ??

B_3EBD8:
  STA.W EntityV34,X                                   ; 03EBD8 9D FA 15 
  CLC                                             ; 03EBDB 18 
  LDA.W EntityYPx,X                                   ; 03EBDC BD 9C 0C 
  ADC.B #$0A                                      ; 03EBDF 69 0A 
  BCC.B B_3EBE5                                   ; 03EBE1 90 02 

.byte $A9,$FF                                     ; 03EBE4 ..       ??

B_3EBE5:
  STA.W EntityV35,X                                   ; 03EBE5 9D 6C 16 
  JSR.W L_3EDA3                                   ; 03EBE8 20 A3 ED 
  JMP.W AdvanceToNextEntity                                   ; 03EBEB 4C 41 81 

D_3EBEE:
.byte $01,$02,$02,$03,$03,$04,$03,$05             ; 03EBEE DDD.DDDD ????????

  LDA.B FrameCounter                              ; 03EBF6 A5 CF 
  AND.B #$03                                      ; 03EBF8 29 03 
  BNE.B B_3EC2C                                   ; 03EBFA D0 30 
  DEC.W EntityV15,X                                   ; 03EBFC DE 80 0D 
  BNE.B B_3EC2C                                   ; 03EBFF D0 2B 
  JSL AdvanceRNG                                     ; 03EC01 22 95 CA 0E 
  AND.B #$03                                      ; 03EC05 29 03 
  BNE.B B_3EC15                                   ; 03EC07 D0 0C 
  JSL AdvanceRNG                                     ; 03EC09 22 95 CA 0E 
  AND.B #$07                                      ; 03EC0D 29 07 
  TAY                                             ; 03EC0F A8 
  LDA.W D_3EC66,Y                                 ; 03EC10 B9 66 EC 
  BRA.B B_3EC1F                                   ; 03EC13 80 0A 
B_3EC15:
  JSL AdvanceRNG                                     ; 03EC15 22 95 CA 0E 
  AND.B #$01                                      ; 03EC19 29 01 
  TAY                                             ; 03EC1B A8 
  JSR.W L_3EE49                                   ; 03EC1C 20 49 EE 
B_3EC1F:
  STA.W EntityV22,X                                   ; 03EC1F 9D 9E 10 
  LDA.B #$91                                      ; 03EC22 A9 91 
  STA.W EntityTypeId,X                                   ; 03EC24 9D 44 07 
  LDA.B #$01                                      ; 03EC27 A9 01 
  STA.W EntityV15,X                                   ; 03EC29 9D 80 0D 
B_3EC2C:
  SEC                                             ; 03EC2C 38 
  LDA.W EntityXPx,X                              ; 03EC2D BD 46 0B 
  SBC.B #$08                                      ; 03EC30 E9 08 
  BCS.B B_3EC36                                   ; 03EC32 B0 02 

.byte $A9,$00                                     ; 03EC35 ..       ??

B_3EC36:
  STA.W EntityV32,X                                   ; 03EC36 9D 16 15 
  CLC                                             ; 03EC39 18 
  LDA.W EntityXPx,X                              ; 03EC3A BD 46 0B 
  ADC.B #$08                                      ; 03EC3D 69 08 
  BCC.B B_3EC43                                   ; 03EC3F 90 02 

.byte $A9,$FF                                     ; 03EC42 ..       ??

B_3EC43:
  STA.W EntityV33,X                                   ; 03EC43 9D 88 15 
  SEC                                             ; 03EC46 38 
  LDA.W EntityYPx,X                                   ; 03EC47 BD 9C 0C 
  SBC.B #$0A                                      ; 03EC4A E9 0A 
  BCS.B B_3EC50                                   ; 03EC4C B0 02 
  LDA.B #$00                                      ; 03EC4E A9 00 
B_3EC50:
  STA.W EntityV34,X                                   ; 03EC50 9D FA 15 
  CLC                                             ; 03EC53 18 
  LDA.W EntityYPx,X                                   ; 03EC54 BD 9C 0C 
  ADC.B #$0A                                      ; 03EC57 69 0A 
  BCC.B B_3EC5D                                   ; 03EC59 90 02 
  LDA.B #$FF                                      ; 03EC5B A9 FF 
B_3EC5D:
  STA.W EntityV35,X                                   ; 03EC5D 9D 6C 16 
  JSR.W L_3EDA3                                   ; 03EC60 20 A3 ED 
  JMP.W AdvanceToNextEntity                                   ; 03EC63 4C 41 81 

D_3EC66:
.byte $05,$06,$07,$08,$09,$0A,$0B,$08             ; 03EC66 .DDD..DD ????????

  DEC.W EntityV15,X                                   ; 03EC6E DE 80 0D 
  BNE.B B_3ECB3                                   ; 03EC71 D0 40 
  LDA.B #$06                                      ; 03EC73 A9 06 
  STA.W EntityV15,X                                   ; 03EC75 9D 80 0D 
  LDA.W EntityV21,X                                   ; 03EC78 BD 2C 10 
  CLC                                             ; 03EC7B 18 
  ADC.W EntityV25,X                                   ; 03EC7C 7D F4 11 
  AND.B #$0F                                      ; 03EC7F 29 0F 
  STA.W EntityV25,X                                   ; 03EC81 9D F4 11 
  LDA.W EntityV23,X                                   ; 03EC84 BD 10 11 
  JSL L_3F032                                     ; 03EC87 22 32 F0 03 
  DEC.W EntityV16,X                                   ; 03EC8B DE F2 0D 
  BEQ.B B_3ECA3                                   ; 03EC8E F0 13 
  JSL AdvanceRNG                                     ; 03EC90 22 95 CA 0E 
  AND.B #$01                                      ; 03EC94 29 01 
  TAY                                             ; 03EC96 A8 
  JSR.W L_3EE49                                   ; 03EC97 20 49 EE 
  STA.B $04                                       ; 03EC9A 85 04 
  LDA.W EntityV25,X                                   ; 03EC9C BD F4 11 
  CMP.B $04                                       ; 03EC9F C5 04 
  BNE.B B_3ECB3                                   ; 03ECA1 D0 10 
B_3ECA3:
  LDA.B #$95                                      ; 03ECA3 A9 95 
  STA.W EntityTypeId,X                                   ; 03ECA5 9D 44 07 
  JSL AdvanceRNG                                     ; 03ECA8 22 95 CA 0E 
  AND.B #$0F                                      ; 03ECAC 29 0F 
  ADC.B #$10                                      ; 03ECAE 69 10 
  STA.W EntityV15,X                                   ; 03ECB0 9D 80 0D 
B_3ECB3:
  LDY.W EntityV20,X                                   ; 03ECB3 BC BA 0F 
  LDA.W EntityXPx,Y                              ; 03ECB6 B9 46 0B 
  STA.W EntityXPx,X                              ; 03ECB9 9D 46 0B 
  LDA.W EntityYPx,Y                                   ; 03ECBC B9 9C 0C 
  STA.W EntityYPx,X                                   ; 03ECBF 9D 9C 0C 
  JSR.W L_3EDA3                                   ; 03ECC2 20 A3 ED 
  JMP.W AdvanceToNextEntity                                   ; 03ECC5 4C 41 81 
  DEC.W EntityV15,X                                   ; 03ECC8 DE 80 0D 
  BNE.B B_3ED2D                                   ; 03ECCB D0 60 
  JSL AdvanceRNG                                     ; 03ECCD 22 95 CA 0E 
  AND.B #$01                                      ; 03ECD1 29 01 
  CLC                                             ; 03ECD3 18 
  ADC.B #$06                                      ; 03ECD4 69 06 
  STA.W EntityV15,X                                   ; 03ECD6 9D 80 0D 
  LDA.W EntityV26,X                                   ; 03ECD9 BD 66 12 
  ASL                                             ; 03ECDC 0A 
  TAY                                             ; 03ECDD A8 
  LDA.W D_3ED44,Y                                 ; 03ECDE B9 44 ED 
  STA.B $04                                       ; 03ECE1 85 04 
  LDA.W D_3ED45,Y                                 ; 03ECE3 B9 45 ED 
  STA.B $05                                       ; 03ECE6 85 05 
  LDY.W EntityV27,X                                   ; 03ECE8 BC D8 12 
  INC.W EntityV27,X                                   ; 03ECEB FE D8 12 
  LDA.B ($04),Y                                   ; 03ECEE B1 04 
  BPL.B B_3ED10                                   ; 03ECF0 10 1E 
  PHA                                             ; 03ECF2 48 
  LDA.B #$93                                      ; 03ECF3 A9 93 
  STA.W EntityTypeId,X                                   ; 03ECF5 9D 44 07 
  LDA.B #$3C                                      ; 03ECF8 A9 3C 
  STA.W EntityV15,X                                   ; 03ECFA 9D 80 0D 
  LDA.B #$10                                      ; 03ECFD A9 10 
  STA.W EntityV16,X                                   ; 03ECFF 9D F2 0D 
  JSL AdvanceRNG                                     ; 03ED02 22 95 CA 0E 
  AND.B #$01                                      ; 03ED06 29 01 
  TAY                                             ; 03ED08 A8 
  LDA.W D_3ED42,Y                                 ; 03ED09 B9 42 ED 
  STA.W EntityV21,X                                   ; 03ED0C 9D 2C 10 
  PLA                                             ; 03ED0F 68 
B_3ED10:
  AND.B #$7F                                      ; 03ED10 29 7F 
  DEC A
  CLC                                             ; 03ED13 18 
  ADC.W EntityV25,X                                   ; 03ED14 7D F4 11 
  AND.B #$0F                                      ; 03ED17 29 0F 
  ORA.B #$10                                      ; 03ED19 09 10 
  STA.W EntityV25,X                                   ; 03ED1B 9D F4 11 
  LDA.B #$03                                      ; 03ED1E A9 03 
  STA.W EntityV22,X                                   ; 03ED20 9D 9E 10 
  JSR.W L_3EF0B                                   ; 03ED23 20 0B EF 
  LDA.W EntityV23,X                                   ; 03ED26 BD 10 11 
  JSL L_3F032                                     ; 03ED29 22 32 F0 03 
B_3ED2D:
  LDY.W EntityV20,X                                   ; 03ED2D BC BA 0F 
  LDA.W EntityXPx,Y                              ; 03ED30 B9 46 0B 
  STA.W EntityXPx,X                              ; 03ED33 9D 46 0B 
  LDA.W EntityYPx,Y                                   ; 03ED36 B9 9C 0C 
  STA.W EntityYPx,X                                   ; 03ED39 9D 9C 0C 
  JSR.W L_3EDA3                                   ; 03ED3C 20 A3 ED 
  JMP.W AdvanceToNextEntity                                   ; 03ED3F 4C 41 81 

D_3ED42:
.byte $01,$FF                                     ; 03ED43 DD       ??
D_3ED44:
.byte $54                                         ; 03ED45 D        T
D_3ED45:
.byte $ED,$56,$ED,$5B,$ED,$5F,$ED,$63             ; 03ED45 D..DDDDD ?V?[?_?c
.byte $ED,$66,$ED,$6A,$ED,$6E,$ED,$01             ; 03ED4D D..DDDDD ?f?j?n??
.byte $80,$02,$02,$00,$00,$80,$01,$02             ; 03ED55 D.....DD ????????
.byte $02,$82,$01,$00,$00,$80,$01,$01             ; 03ED5D DDDDD.DD ????????
.byte $81,$01,$02,$01,$80,$01,$00,$01             ; 03ED65 D....DDD ????????
.byte $82,$00,$00,$02,$02,$82                     ; 03ED6E DDDDDD   ??????

  DEC.W EntityV15,X                                   ; 03ED73 DE 80 0D 
  BNE.B B_3ED8E                                   ; 03ED76 D0 16 
  LDA.B #$94                                      ; 03ED78 A9 94 
  STA.W EntityTypeId,X                                   ; 03ED7A 9D 44 07 
  LDA.B #$01                                      ; 03ED7D A9 01 
  STA.W EntityV15,X                                   ; 03ED7F 9D 80 0D 
  JSL AdvanceRNG                                     ; 03ED82 22 95 CA 0E 
  AND.B #$07                                      ; 03ED86 29 07 
  STA.W EntityV26,X                                   ; 03ED88 9D 66 12 
  STZ.W EntityV27,X                                   ; 03ED8B 9E D8 12 
B_3ED8E:
  LDY.W EntityV20,X                                   ; 03ED8E BC BA 0F 
  LDA.W EntityXPx,Y                              ; 03ED91 B9 46 0B 
  STA.W EntityXPx,X                              ; 03ED94 9D 46 0B 
  LDA.W EntityYPx,Y                                   ; 03ED97 B9 9C 0C 
  STA.W EntityYPx,X                                   ; 03ED9A 9D 9C 0C 
  JSR.W L_3EDA3                                   ; 03ED9D 20 A3 ED 
  JMP.W AdvanceToNextEntity                                   ; 03EDA0 4C 41 81 

L_3EDA3:
  SEC                                             ; 03EDA3 38 
  LDA.W EntityXPx,X                              ; 03EDA4 BD 46 0B 
  SBC.B #$10                                      ; 03EDA7 E9 10 
  STA.B $04                                       ; 03EDA9 85 04 
  LDA.W EntityXMovement,X                                   ; 03EDAB BD B8 0B 
  SBC.B #$00                                      ; 03EDAE E9 00 
  STA.B $05                                       ; 03EDB0 85 05 
  SEC                                             ; 03EDB2 38 
  LDA.W EntityYPx,X                                   ; 03EDB3 BD 9C 0C 
  SBC.B #$11                                      ; 03EDB6 E9 11 
  STA.B $06                                       ; 03EDB8 85 06 
  LDA.W EntityYMovement,X                                   ; 03EDBA BD 0E 0D 
  SBC.B #$00                                      ; 03EDBD E9 00 
  STA.B $07                                       ; 03EDBF 85 07 
  LDA.W EntityV25,X                                   ; 03EDC1 BD F4 11 
  AND.B #$10                                      ; 03EDC4 29 10 
  BEQ.B B_3EDF5                                   ; 03EDC6 F0 2D 
  LDA.W EntityV25,X                                   ; 03EDC8 BD F4 11 
  AND.B #$0F                                      ; 03EDCB 29 0F 
  DEC.W EntityV22,X                                   ; 03EDCD DE 9E 10 
  BNE.B B_3EDD5                                   ; 03EDD0 D0 03 
  STA.W EntityV25,X                                   ; 03EDD2 9D F4 11 
B_3EDD5:
  ASL                                             ; 03EDD5 0A 
  TAY                                             ; 03EDD6 A8 
  SEC                                             ; 03EDD7 38 
  LDA.B $04                                       ; 03EDD8 A5 04 
  SBC.W D_3EE09,Y                                 ; 03EDDA F9 09 EE 
  STA.B $04                                       ; 03EDDD 85 04 
  LDA.B $05                                       ; 03EDDF A5 05 
  SBC.W D_3EE0A,Y                                 ; 03EDE1 F9 0A EE 
  STA.B $05                                       ; 03EDE4 85 05 
  SEC                                             ; 03EDE6 38 
  LDA.B $06                                       ; 03EDE7 A5 06 
  SBC.W D_3EE29,Y                                 ; 03EDE9 F9 29 EE 
  STA.B $06                                       ; 03EDEC 85 06 
  LDA.B $07                                       ; 03EDEE A5 07 
  SBC.W D_3EE2A,Y                                 ; 03EDF0 F9 2A EE 
  STA.B $07                                       ; 03EDF3 85 07 
B_3EDF5:
  JSL L_AF42                                      ; 03EDF5 22 42 AF 00 
  LDA.B $D2                                       ; 03EDF9 A5 D2 
  AND.B #$03                                      ; 03EDFB 29 03 
  BNE.B B_3EE08                                   ; 03EDFD D0 09 
  LDA.W EntityV30,X                                   ; 03EDFF BD 2E 14 
  ORA.W EntityV2,X                                   ; 03EE02 1D B6 07 
  STA.W EntityV30,X                                   ; 03EE05 9D 2E 14 
B_3EE08:
  RTS                                             ; 03EE08 60 


D_3EE09:
.byte $00                                         ; 03EE0A D        ?
D_3EE0A:
.byte $00,$01,$00,$02,$00,$03,$00,$04             ; 03EE0A DDDDDDDD ????????
.byte $00,$03,$00,$02,$00,$01,$00,$00             ; 03EE12 DDDDDDDD ????????
.byte $00,$FF,$FF,$FE,$FF,$FD,$FF,$FC             ; 03EE1A DDDDDDDD ????????
.byte $FF,$FD,$FF,$FE,$FF,$FF,$FF                 ; 03EE23 D..DDDD  ???????
D_3EE29:
.byte $FC                                         ; 03EE2A D        ?
D_3EE2A:
.byte $FF,$FD,$FF,$FE,$FF,$FF,$FF,$00             ; 03EE2A DDDDDDDD ????????
.byte $00,$01,$00,$02,$00,$03,$00,$04             ; 03EE32 DDDDDDDD ????????
.byte $00,$03,$00,$02,$00,$01,$00,$00             ; 03EE3A DDDDDDDD ????????
.byte $00,$FF,$FF,$FE,$FF,$FD,$FF                 ; 03EE43 D..DDDD  ???????


L_3EE49:
  STZ.B $0A                                       ; 03EE49 64 0A 
  LDA.W EntityXPx,X                              ; 03EE4B BD 46 0B 
  STA.B $04                                       ; 03EE4E 85 04 
  LDA.W EntityYPx,X                                   ; 03EE50 BD 9C 0C 
  STA.B $05                                       ; 03EE53 85 05 
  LDA.W EntityXPx,Y                              ; 03EE55 B9 46 0B 
  STA.B $06                                       ; 03EE58 85 06 
  LDA.W EntityYPx,Y                                   ; 03EE5A B9 9C 0C 
  STA.B $07                                       ; 03EE5D 85 07 
  SEC                                             ; 03EE5F 38 
  LDA.B $06                                       ; 03EE60 A5 06 
  SBC.B $04                                       ; 03EE62 E5 04 
  BCS.B B_3EE6F                                   ; 03EE64 B0 09 
  LDA.B #$01                                      ; 03EE66 A9 01 
  STA.B $0A                                       ; 03EE68 85 0A 
  SEC                                             ; 03EE6A 38 
  LDA.B $04                                       ; 03EE6B A5 04 
  SBC.B $06                                       ; 03EE6D E5 06 
B_3EE6F:
  STA.B $08                                       ; 03EE6F 85 08 
  SEC                                             ; 03EE71 38 
  LDA.B $07                                       ; 03EE72 A5 07 
  SBC.B $05                                       ; 03EE74 E5 05 
  BCS.B B_3EE83                                   ; 03EE76 B0 0B 
  LDA.B $0A                                       ; 03EE78 A5 0A 
  ORA.B #$02                                      ; 03EE7A 09 02 
  STA.B $0A                                       ; 03EE7C 85 0A 
  SEC                                             ; 03EE7E 38 
  LDA.B $05                                       ; 03EE7F A5 05 
  SBC.B $07                                       ; 03EE81 E5 07 
B_3EE83:
  STA.B $09                                       ; 03EE83 85 09 
B_3EE85:
  LDA.B $08                                       ; 03EE85 A5 08 
  ORA.B $09                                       ; 03EE87 05 09 
  CMP.B #$08                                      ; 03EE89 C9 08 
  BCC.B B_3EE93                                   ; 03EE8B 90 06 
  LSR.B $08                                       ; 03EE8D 46 08 
  LSR.B $09                                       ; 03EE8F 46 09 
  BRA.B B_3EE85                                   ; 03EE91 80 F2 
B_3EE93:
  LDA.B $09                                       ; 03EE93 A5 09 
  ASL                                             ; 03EE95 0A 
  ASL                                             ; 03EE96 0A 
  ASL                                             ; 03EE97 0A 
  CLC                                             ; 03EE98 18 
  ADC.B $08                                       ; 03EE99 65 08 
  TAY                                             ; 03EE9B A8 
  LDA.W D_3EECB,Y                                 ; 03EE9C B9 CB EE 
  STA.B $04                                       ; 03EE9F 85 04 
  LDY.B $0A                                       ; 03EEA1 A4 0A 
  BEQ.B B_3EEC3                                   ; 03EEA3 F0 1E 
  DEY                                             ; 03EEA5 88 
  BEQ.B B_3EEBB                                   ; 03EEA6 F0 13 
  DEY                                             ; 03EEA8 88 
  BEQ.B B_3EEB3                                   ; 03EEA9 F0 08 
  CLC                                             ; 03EEAB 18 
  LDA.B #$0C                                      ; 03EEAC A9 0C 
  ADC.B $04                                       ; 03EEAE 65 04 
  AND.B #$0F                                      ; 03EEB0 29 0F 
  RTS                                             ; 03EEB2 60 


B_3EEB3:
.byte $38,$A9,$04,$E5,$04,$29,$0F,$60             ; 03EEB3 ........ 8????)?`

B_3EEBB:
  SEC                                             ; 03EEBB 38 
  LDA.B #$0C                                      ; 03EEBC A9 0C 
  SBC.B $04                                       ; 03EEBE E5 04 
  AND.B #$0F                                      ; 03EEC0 29 0F 
  RTS                                             ; 03EEC2 60 

B_3EEC3:
  CLC                                             ; 03EEC3 18 
  LDA.B #$04                                      ; 03EEC4 A9 04 
  ADC.B $04                                       ; 03EEC6 65 04 
  AND.B #$0F                                      ; 03EEC8 29 0F 
  RTS                                             ; 03EECA 60 


D_3EECB:
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03EECB ....DD.. ????????
.byte $04,$02,$01,$01,$00,$00,$00,$00             ; 03EED3 .....D.D ????????
.byte $04,$03,$02,$01,$01,$01,$01,$01             ; 03EEDB .....D.. ????????
.byte $04,$03,$03,$02,$01,$01,$01,$01             ; 03EEE3 ....DD.. ????????
.byte $04,$04,$03,$03,$02,$02,$01,$01             ; 03EEEB DDDD.D.. ????????
.byte $04,$04,$03,$03,$02,$02,$02,$02             ; 03EEF3 D.D..... ????????
.byte $04,$04,$03,$03,$03,$02,$02,$02             ; 03EEFB DD.D..D. ????????
.byte $04,$04,$03,$03,$03,$02,$02,$02             ; 03EF03 ......D. ????????


L_3EF0B:
  LDA.W EntityV25,X                                   ; 03EF0B BD F4 11 
  AND.B #$0F                                      ; 03EF0E 29 0F 
  STA.B $06                                       ; 03EF10 85 06 
  TAY                                             ; 03EF12 A8 
  CLC                                             ; 03EF13 18 
  LDA.W EntityXPx,X                              ; 03EF14 BD 46 0B 
  ADC.W D_3EFD2,Y                                 ; 03EF17 79 D2 EF 
  STA.B $04                                       ; 03EF1A 85 04 
  CLC                                             ; 03EF1C 18 
  LDA.W EntityYPx,X                                   ; 03EF1D BD 9C 0C 
  ADC.W D_3EFE2,Y                                 ; 03EF20 79 E2 EF 
  STA.B $05                                       ; 03EF23 85 05 
  PHX                                             ; 03EF25 DA 
  JSL FindEmptyEntitySlot                                     ; 03EF26 22 F3 80 03 
  BEQ.B B_3EF2F                                   ; 03EF2A F0 03 

.byte $4C,$D0,$EF                                 ; 03EF2D ...      L??

B_3EF2F:
  JSL ClearEntitySlotData                                     ; 03EF2F 22 94 80 03 
  LDA.B #$01                                      ; 03EF33 A9 01 
  STA.W EntityHeader,X                                   ; 03EF35 9D D2 06 
  LDA.B #$8E                                      ; 03EF38 A9 8E 
  STA.W EntityTypeId,X                                   ; 03EF3A 9D 44 07 
  LDA.B #$08                                      ; 03EF3D A9 08 
  STA.W EntityV3,X                                   ; 03EF3F 9D 28 08 
  LDA.B #$4C                                      ; 03EF42 A9 4C 
  STA.W EntityV29,X                                   ; 03EF44 9D BC 13 
  LDA.B #$33                                      ; 03EF47 A9 33 
  STA.W EntityV30,X                                   ; 03EF49 9D 2E 14 
  LDA.B $04                                       ; 03EF4C A5 04 
  STA.W EntityXPx,X                              ; 03EF4E 9D 46 0B 
  LDA.B $05                                       ; 03EF51 A5 05 
  STA.W EntityYPx,X                                   ; 03EF53 9D 9C 0C 
  LDA.B $06                                       ; 03EF56 A5 06 
  ASL                                             ; 03EF58 0A 
  TAY                                             ; 03EF59 A8 
  LDA.W D_3EFF2,Y                                 ; 03EF5A B9 F2 EF 
  STA.W EntityXSubPxSpeed,X                                   ; 03EF5D 9D 0C 09 
  LDA.W D_3EFF3,Y                                 ; 03EF60 B9 F3 EF 
  STA.W EntityXPxSpeed,X                                   ; 03EF63 9D 7E 09 
  LDA.W D_3F012,Y                                 ; 03EF66 B9 12 F0 
  STA.W EntityYSubPxSpeed,X                                   ; 03EF69 9D F0 09 
  LDA.W D_3F013,Y                                 ; 03EF6C B9 13 F0 
  STA.W EntityYPxSpeed,X                                   ; 03EF6F 9D 62 0A 
  JSL L_AEBC                                      ; 03EF72 22 BC AE 00 
  TYA                                             ; 03EF76 98 
  STA.W EntityV31,X                                   ; 03EF77 9D A0 14 
  LDA.B #$01                                      ; 03EF7A A9 01 
  STA.W StateFlags,Y                                   ; 03EF7C 99 5E 17 
  JSL L_AEF1                                      ; 03EF7F 22 F1 AE 00 
  SEC                                             ; 03EF83 38 
  LDA.W EntityXPx,X                              ; 03EF84 BD 46 0B 
  SBC.B #$01                                      ; 03EF87 E9 01 
  BCS.B B_3EF8D                                   ; 03EF89 B0 02 

.byte $A9,$00                                     ; 03EF8C ..       ??

B_3EF8D:
  STA.W EntityV32,X                                   ; 03EF8D 9D 16 15 
  CLC                                             ; 03EF90 18 
  LDA.W EntityXPx,X                              ; 03EF91 BD 46 0B 
  ADC.B #$01                                      ; 03EF94 69 01 
  BCC.B B_3EF9A                                   ; 03EF96 90 02 

.byte $A9,$FF                                     ; 03EF99 ..       ??

B_3EF9A:
  STA.W EntityV33,X                                   ; 03EF9A 9D 88 15 
  SEC                                             ; 03EF9D 38 
  LDA.W EntityYPx,X                                   ; 03EF9E BD 9C 0C 
  SBC.B #$01                                      ; 03EFA1 E9 01 
  BCS.B B_3EFA7                                   ; 03EFA3 B0 02 

.byte $A9,$00                                     ; 03EFA6 ..       ??

B_3EFA7:
  STA.W EntityV34,X                                   ; 03EFA7 9D FA 15 
  CLC                                             ; 03EFAA 18 
  LDA.W EntityYPx,X                                   ; 03EFAB BD 9C 0C 
  ADC.B #$01                                      ; 03EFAE 69 01 
  BCC.B B_3EFB4                                   ; 03EFB0 90 02 

.byte $A9,$FF                                     ; 03EFB3 ..       ??

B_3EFB4:
  STA.W EntityV35,X                                   ; 03EFB4 9D 6C 16 
  LDA.B #$08                                      ; 03EFB7 A9 08 
  STA.B $1C                                       ; 03EFB9 85 1C 
  LDA.B #$08                                      ; 03EFBB A9 08 
  STA.B $1D                                       ; 03EFBD 85 1D 
  JSL L_AFC2                                      ; 03EFBF 22 C2 AF 00 
  REP.B #P_Idx8Bit                                      ; 03EFC3 C2 10 
  LDA.B #$07                                      ; 03EFC5 A9 07 
  LDX.W #$FF03                                    ; 03EFC7 A2 03 FF 
  JSL Audio_F830F                                     ; 03EFCA 22 0F 83 0F 
  SEP.B #P_Idx8Bit                                      ; 03EFCE E2 10 
  PLX                                             ; 03EFD0 FA 
  RTS                                             ; 03EFD1 60 


D_3EFD2:
.byte $02,$08,$0C,$0E,$0F,$0F,$0C,$05             ; 03EFD2 DDDDDDDD ????????
.byte $00,$FC,$F4,$F1,$F1,$F2,$F4,$F8             ; 03EFDA DDDDD.DD ????????
D_3EFE2:
.byte $F0,$F0,$F3,$F7,$FE,$06,$09,$0D             ; 03EFE2 DDDDDDDD ????????
.byte $0E,$0D,$09,$06,$FE,$F7,$F3,$F0             ; 03EFEA DDDDD.DD ????????
D_3EFF2:
.byte $00                                         ; 03EFF3 D        ?
D_3EFF3:
.byte $00,$93,$00,$10,$01,$63,$01,$80             ; 03EFF3 DDDDDDDD ?????c??
.byte $01,$63,$01,$10,$01,$93,$00,$00             ; 03EFFB DDDDDDDD ?c??????
.byte $00,$6D,$FF,$F0,$FE,$9D,$FE,$80             ; 03F003 DDDDDDDD ?m??????
.byte $FE,$9D,$FE,$F0,$FE,$6D,$FF                 ; 03F00C D..DDDD  ?????m?
D_3F012:
.byte $80                                         ; 03F013 D        ?
D_3F013:
.byte $FE,$9D,$FE,$F0,$FE,$6D,$FF,$00             ; 03F013 DDDDDDDD ?????m??
.byte $00,$93,$00,$10,$01,$63,$01,$80             ; 03F01B DDDDDDDD ?????c??
.byte $01,$63,$01,$10,$01,$93,$00,$00             ; 03F023 DDDDDDDD ?c??????
.byte $00,$6D,$FF,$F0,$FE,$9D,$FE                 ; 03F02C D..DDDD  ?m?????


L_3F032:
  PHA                                             ; 03F032 48 
  LDA.W EntityV25,X                                   ; 03F033 BD F4 11 
  AND.B #$0F                                      ; 03F036 29 0F 
  TAY                                             ; 03F038 A8 
  LDA.W EntityV2,X                                   ; 03F039 BD B6 07 
  ORA.W D_3F0D3,Y                                 ; 03F03C 19 D3 F0 
  STA.W EntityV30,X                                   ; 03F03F 9D 2E 14 
  LDA.W EntityV25,X                                   ; 03F042 BD F4 11 
  AND.B #$0F                                      ; 03F045 29 0F 
  ASL                                             ; 03F047 0A 
  TAY                                             ; 03F048 A8 
  PLA                                             ; 03F049 68 
  BEQ.B B_3F092                                   ; 03F04A F0 46 
  CMP.B #$01                                      ; 03F04C C9 01 
  BEQ.B B_3F071                                   ; 03F04E F0 21 
  LDA.W D_3F0B3,Y                                 ; 03F050 B9 B3 F0 
  STA.W $1AC5                                     ; 03F053 8D C5 1A 
  LDA.W D_3F0B4,Y                                 ; 03F056 B9 B4 F0 
  STA.W $1AC6                                     ; 03F059 8D C6 1A 
  REP.B #P_Idx8Bit                                      ; 03F05C C2 10 
  LDY.W #$1801                                    ; 03F05E A0 01 18 
  STY.W $1AC3                                     ; 03F061 8C C3 1A 
  LDA.B #$06                                      ; 03F064 A9 06 
  STA.W $1AC7                                     ; 03F066 8D C7 1A 
  LDA.B #$01                                      ; 03F069 A9 01 
  STA.W $1AC2                                     ; 03F06B 8D C2 1A 
  SEP.B #P_Idx8Bit                                      ; 03F06E E2 10 
  RTL                                             ; 03F070 6B 
B_3F071:
  LDA.W D_3F0B3,Y                                 ; 03F071 B9 B3 F0 
  STA.W $1ABD                                     ; 03F074 8D BD 1A 
  LDA.W D_3F0B4,Y                                 ; 03F077 B9 B4 F0 
  STA.W $1ABE                                     ; 03F07A 8D BE 1A 
  REP.B #P_Idx8Bit                                      ; 03F07D C2 10 
  LDY.W #$1801                                    ; 03F07F A0 01 18 
  STY.W $1ABB                                     ; 03F082 8C BB 1A 
  LDA.B #$06                                      ; 03F085 A9 06 
  STA.W $1ABF                                     ; 03F087 8D BF 1A 
  LDA.B #$01                                      ; 03F08A A9 01 
  STA.W $1ABA                                     ; 03F08C 8D BA 1A 
  SEP.B #P_Idx8Bit                                      ; 03F08F E2 10 
  RTL                                             ; 03F091 6B 

B_3F092:
.byte $B9,$B3,$F0,$8D,$B5,$1A,$B9,$B4             ; 03F092 ........ ????????
.byte $F0,$8D,$B6,$1A,$C2,$10,$A0,$01             ; 03F09A ........ ????????
.byte $18,$8C,$B3,$1A,$A9,$06,$8D,$B7             ; 03F0A2 ........ ????????
.byte $1A,$A9,$01,$8D,$B2,$1A,$E2,$10             ; 03F0AA ........ ????????
.byte $6B                                         ; 03F0B3 .        k
D_3F0B3:
.byte $00                                         ; 03F0B4 D        ?
D_3F0B4:
.byte $90,$00,$92,$00,$94,$00,$96,$00             ; 03F0B4 DDDDDDDD ????????
.byte $B8,$00,$BA,$00,$BC,$00,$BE,$00             ; 03F0BC DDDDDDDD ????????
.byte $E2,$00,$BE,$00,$BC,$00,$BA,$00             ; 03F0C4 DDDDDDDD ????????
.byte $B8,$00,$96,$00,$94,$00,$92                 ; 03F0CD DDDDDDD  ???????
D_3F0D3:
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03F0D3 DDDDDDDD ????????
.byte $00,$40,$40,$40,$40,$40,$40,$40             ; 03F0DB DDDDDDDD ?@@@@@@@


L_3F0E3:
  LDY.W EntityV25,X                                   ; 03F0E3 BC F4 11 
  LDA.W D_3F102,Y                                 ; 03F0E6 B9 02 F1 
  STA.W EntityV29,X                                   ; 03F0E9 9D BC 13 
  LDA.W EntityV2,X                                   ; 03F0EC BD B6 07 
  ORA.W D_3F10A,Y                                 ; 03F0EF 19 0A F1 
  STA.W EntityV30,X                                   ; 03F0F2 9D 2E 14 
  LDA.B #$10                                      ; 03F0F5 A9 10 
  STA.B $1C                                       ; 03F0F7 85 1C 
  LDA.B #$11                                      ; 03F0F9 A9 11 
  STA.B $1D                                       ; 03F0FB 85 1D 
  JSL L_AFC2                                      ; 03F0FD 22 C2 AF 00 
  RTS                                             ; 03F101 60 


D_3F102:
.byte $80,$84,$88,$8C,$C0,$8C,$88,$84             ; 03F102 DDDDDDDD ????????
D_3F10A:
.byte $01,$01,$01,$01,$01,$41,$41,$41             ; 03F10A DDDDDDDD ?????AAA
.byte $20,$34,$FA,$22,$8E,$F4,$0D,$20             ; 03F112 ........  4?"??? 
.byte $05,$F9,$BD,$4A,$13,$F0,$0D,$DE             ; 03F11A ........ ???J????
.byte $4A,$13,$D0,$0C,$9C,$D2,$02,$9C             ; 03F122 ........ J???????
.byte $D3,$02,$80,$04,$22,$B0,$F5,$0D             ; 03F12A ........ ????"???
.byte $DE,$80,$0D,$D0,$6D,$22,$95,$CA             ; 03F132 ........ ????m"??
.byte $0E,$29,$3F,$85,$04,$22,$95,$CA             ; 03F13A ........ ?)???"??
.byte $0E,$29,$3F,$65,$04,$69,$32,$9D             ; 03F142 ........ ?)?e?i2?
.byte $80,$0D,$22,$95,$CA,$0E,$29,$07             ; 03F14A ........ ??"???)?
.byte $85,$04,$AD,$B0,$06,$0A,$0A,$0A             ; 03F152 ........ ????????
.byte $18,$65,$04,$A8,$B9,$ED,$F1,$30             ; 03F15A ........ ?e?????0
.byte $41,$8D,$D2,$02,$8D,$D3,$02,$C9             ; 03F162 ........ A???????
.byte $02,$D0,$15,$22,$95,$CA,$0E,$29             ; 03F16A ........ ???"???)
.byte $10,$69,$10,$9D,$4A,$13,$22,$FA             ; 03F172 ........ ?i??J?"?
.byte $F9,$0D,$22,$DE,$FB,$0D,$80,$22             ; 03F17A ........ ??"????"
.byte $A9,$08,$8D,$CE,$02,$8D,$CF,$02             ; 03F182 ........ ????????
.byte $22,$95,$CA,$0E,$29,$1F,$69,$32             ; 03F18A ........ "???)?i2
.byte $9D,$4A,$13,$DA,$C2,$10,$A9,$07             ; 03F192 ........ ?J??????
.byte $A2,$2B,$FF,$22,$0F,$83,$0F,$E2             ; 03F19A ........ ?+?"????
.byte $10,$FA,$A9,$23,$20,$95,$81,$20             ; 03F1A2 ........ ???# ?? 
.byte $03,$FA,$22,$D4,$F7,$0D,$22,$6A             ; 03F1AA ........ ??"???"j
.byte $F8,$0D,$AD,$AF,$06,$C9,$02,$B0             ; 03F1B2 ........ ????????
.byte $2B,$AD,$B0,$06,$C9,$07,$D0,$24             ; 03F1BA ........ +??????$
.byte $A9,$04,$8D,$B0,$06,$9C,$B1,$06             ; 03F1C2 ........ ????????
.byte $A9,$97,$9D,$44,$07,$A9,$78,$9D             ; 03F1CA ........ ???D??x?
.byte $80,$0D,$A9,$03,$9D,$F2,$0D,$A9             ; 03F1D2 ........ ????????
.byte $FF,$8D,$BB,$06,$A9,$0B,$8D,$D2             ; 03F1DA ........ ????????
.byte $02,$8D,$D3,$02,$22,$96,$F5,$0E             ; 03F1E2 ........ ????"???
.byte $4C,$41,$81,$02,$01,$01,$FF,$01             ; 03F1EA ........ LA??????
.byte $01,$02,$FF,$02,$01,$01,$02,$01             ; 03F1F2 ........ ????????
.byte $01,$02,$FF,$02,$01,$01,$02,$01             ; 03F1FA ........ ????????
.byte $01,$02,$01,$02,$01,$02,$02,$01             ; 03F202 ........ ????????
.byte $01,$02,$01,$02,$01,$01,$02,$01             ; 03F20A ........ ????????
.byte $02,$02,$01,$02,$01,$02,$01,$02             ; 03F212 ........ ????????
.byte $02,$02,$01,$02,$02,$01,$02,$02             ; 03F21A ........ ????????
.byte $01,$02,$01,$02,$02,$02,$02,$01             ; 03F222 ........ ????????
.byte $02,$02,$01,$22,$0C,$F4,$0D,$22             ; 03F22A ........ ???"???"
.byte $DE,$F3,$0D,$DE,$80,$0D,$D0,$0A             ; 03F232 ........ ????????
.byte $A9,$98,$9D,$44,$07,$A9,$04,$9D             ; 03F23A ........ ???D????
.byte $80,$0D,$22,$8E,$F4,$0D,$20,$05             ; 03F242 ........ ??"??? ?
.byte $F9,$A9,$23,$20,$95,$81,$20,$03             ; 03F24A ........ ??# ?? ?
.byte $FA,$22,$96,$F5,$0E,$4C,$41,$81             ; 03F252 ........ ?"???LA?
.byte $22,$0C,$F4,$0D,$22,$DE,$F3,$0D             ; 03F25A ........ "???"???
.byte $DE,$80,$0D,$D0,$3B,$A9,$12,$9D             ; 03F262 ........ ????;???
.byte $80,$0D,$22,$D5,$F6,$0D,$DE,$F2             ; 03F26A ........ ??"?????
.byte $0D,$D0,$2D,$22,$C8,$FC,$0D,$A9             ; 03F272 ........ ??-"????
.byte $99,$9D,$44,$07,$A9,$20,$9D,$80             ; 03F27A ........ ??D?? ??
.byte $0D,$22,$7C,$F2,$0D,$9C,$B3,$06             ; 03F282 ........ ?"|?????
.byte $A9,$03,$8D,$D7,$02,$8D,$D8,$02             ; 03F28A ........ ????????
.byte $A9,$08,$8D,$D9,$02,$8D,$DA,$02             ; 03F292 ........ ????????
.byte $A9,$01,$8D,$BA,$06,$9C,$BB,$06             ; 03F29A ........ ????????
.byte $22,$8E,$F4,$0D,$20,$05,$F9,$A9             ; 03F2A2 ........ "??? ???
.byte $23,$20,$95,$81,$20,$03,$FA,$22             ; 03F2AA ........ # ?? ??"
.byte $96,$F5,$0E,$4C,$41,$81,$22,$0C             ; 03F2B2 ........ ???LA?"?
.byte $F4,$0D,$DE,$80,$0D,$D0,$48,$A9             ; 03F2BA ........ ??????H?
.byte $9A,$9D,$44,$07,$A9,$08,$8D,$AF             ; 03F2C2 ........ ??D?????
.byte $06,$9C,$B6,$06,$9C,$B7,$06,$9C             ; 03F2CA ........ ????????
.byte $B8,$06,$9C,$B9,$06,$DA,$C2,$10             ; 03F2D2 ........ ????????
.byte $A2,$18,$FF,$A9,$07,$22,$0F,$83             ; 03F2DA ........ ?????"??
.byte $0F,$E2,$10,$FA,$22,$B8,$F2,$0D             ; 03F2E2 ........ ????"???
.byte $A9,$0C,$22,$E5,$F2,$0D,$A9,$01             ; 03F2EA ........ ??"?????
.byte $8D,$BA,$06,$9C,$BB,$06,$9C,$D7             ; 03F2F2 ........ ????????
.byte $02,$9C,$D8,$02,$9C,$D9,$02,$9C             ; 03F2FA ........ ????????
.byte $DA,$02,$A9,$78,$9D,$4A,$13,$20             ; 03F302 ........ ???x?J? 
.byte $34,$FA,$22,$8E,$F4,$0D,$20,$05             ; 03F30A ........ 4?"??? ?
.byte $F9,$A9,$23,$20,$95,$81,$20,$03             ; 03F312 ........ ??# ?? ?
.byte $FA,$22,$96,$F5,$0E,$4C,$41,$81             ; 03F31A ........ ?"???LA?
.byte $DE,$4A,$13,$D0,$36,$AD,$D9,$02             ; 03F322 ........ ?J??6???
.byte $29,$04,$F0,$13,$9C,$D9,$02,$9C             ; 03F32A ........ )???????
.byte $DA,$02,$22,$95,$CA,$0E,$29,$1F             ; 03F332 ........ ??"???)?
.byte $69,$10,$9D,$4A,$13,$80,$1C,$A9             ; 03F33A ........ i??J????
.byte $04,$8D,$D9,$02,$8D,$DA,$02,$22             ; 03F342 ........ ???????"
.byte $95,$CA,$0E,$29,$7F,$69,$3C,$9D             ; 03F34A ........ ???)?i<?
.byte $4A,$13,$AD,$B3,$06,$30,$04,$22             ; 03F352 ........ J????0?"
.byte $4E,$FB,$0D,$20,$34,$FA,$22,$8E             ; 03F35A ........ N?? 4?"?
.byte $F4,$0D,$20,$05,$F9,$A9,$23,$20             ; 03F362 ........ ?? ???# 
.byte $95,$81,$22,$1F,$F8,$0D,$20,$03             ; 03F36A ........ ??"??? ?
.byte $FA,$22,$17,$F9,$0D,$AD,$AF,$06             ; 03F372 ........ ?"??????
.byte $C9,$01,$B0,$1B,$AD,$B0,$06,$C9             ; 03F37A ........ ????????
.byte $07,$D0,$14,$A9,$9B,$9D,$44,$07             ; 03F382 ........ ??????D?
.byte $A9,$78,$9D,$80,$0D,$A9,$05,$9D             ; 03F38A ........ ?x??????
.byte $F2,$0D,$A9,$FF,$8D,$BB,$06,$22             ; 03F392 ........ ???????"
.byte $96,$F5,$0E,$4C,$41,$81,$22,$0C             ; 03F39A ........ ???LA?"?
.byte $F4,$0D,$22,$DE,$F3,$0D,$DE,$80             ; 03F3A2 ........ ??"?????
.byte $0D,$D0,$0A,$A9,$A0,$9D,$44,$07             ; 03F3AA ........ ??????D?
.byte $A9,$04,$9D,$80,$0D,$22,$8E,$F4             ; 03F3B2 ........ ?????"??
.byte $0D,$20,$05,$F9,$A9,$23,$20,$95             ; 03F3BA ........ ? ???# ?
.byte $81,$20,$03,$FA,$4C,$41,$81,$DE             ; 03F3C2 ........ ? ??LA??
.byte $F2,$0D,$F0,$06,$20,$6D,$F9,$4C             ; 03F3CA ........ ???? m?L
.byte $41,$81,$BC,$A0,$14,$B9,$DE,$17             ; 03F3D2 ........ A???????
.byte $48,$DA,$BC,$A0,$14,$22,$F1,$AE             ; 03F3DA ........ H????"??
.byte $00,$BD,$A0,$14,$AA,$9E,$5E,$17             ; 03F3E2 ........ ??????^?
.byte $0A,$0A,$A8,$A9,$F0,$90,$05,$99             ; 03F3EA ........ ????????
.byte $09,$04,$80,$03,$99,$09,$03,$FA             ; 03F3F2 ........ ????????
.byte $68,$9D,$A0,$14,$A9,$09,$9D,$44             ; 03F3FA ........ h??????D
.byte $07,$A9,$00,$9D,$28,$08,$A9,$20             ; 03F402 ........ ????(?? 
.byte $9D,$BC,$13,$A9,$32,$9D,$2E,$14             ; 03F40A ........ ????2?.?
.byte $9E,$0C,$09,$9E,$7E,$09,$9E,$F0             ; 03F412 ........ ????~???
.byte $09,$9E,$62,$0A,$A9,$04,$9D,$4A             ; 03F41A ........ ??b????J
.byte $13,$9E,$D8,$12,$A9,$08,$85,$1C             ; 03F422 ........ ????????
.byte $A9,$08,$85,$1D,$22,$C2,$AF,$00             ; 03F42A ........ ????"???
.byte $C2,$10,$A9,$07,$A2,$06,$FF,$22             ; 03F432 ........ ???????"
.byte $0F,$83,$0F,$E2,$10,$AE,$E3,$18             ; 03F43A ........ ????????
.byte $DE,$C5,$18,$D0,$06,$9E,$C9,$18             ; 03F442 ........ ????????
.byte $9E,$C1,$18,$4C,$41,$81,$AC,$8B             ; 03F44A ........ ???LA???
.byte $06,$B9,$44,$07,$C9,$A0,$90,$1A             ; 03F452 ........ ??D?????
.byte $A9,$9C,$9D,$44,$07,$22,$95,$CA             ; 03F45A ........ ???D?"??
.byte $0E,$29,$0F,$85,$0E,$22,$95,$CA             ; 03F462 ........ ?)???"??
.byte $0E,$29,$0F,$65,$0E,$69,$01,$9D             ; 03F46A ........ ?)?e?i??
.byte $F2,$0D,$AD,$AB,$06,$85,$04,$AD             ; 03F472 ........ ????????
.byte $AC,$06,$85,$05,$BC,$2C,$10,$18             ; 03F47A ........ ?????,??
.byte $A5,$04,$79,$BF,$F4,$9D,$46,$0B             ; 03F482 ........ ??y???F?
.byte $18,$A5,$05,$79,$C7,$F4,$9D,$9C             ; 03F48A ........ ???y????
.byte $0C,$BC,$9E,$10,$BD,$BC,$13,$29             ; 03F492 ........ ???????)
.byte $8F,$19,$BC,$F4,$9D,$BC,$13,$22             ; 03F49A ........ ???????"
.byte $71,$F9,$0D,$20,$6D,$F9,$A5,$D2             ; 03F4A2 ........ q?? m???
.byte $29,$03,$D0,$0B,$BD,$2E,$14,$29             ; 03F4AA ........ )????.?)
.byte $CF,$1D,$B6,$07,$9D,$2E,$14,$4C             ; 03F4B2 ........ ?????.?L
.byte $41,$81,$00,$20,$40,$F6,$E4,$E5             ; 03F4BA ........ A?? @???
.byte $F4,$0E,$12,$13,$14,$EC,$F6,$0B             ; 03F4C2 ........ ????????
.byte $1D,$EC,$F6,$0B,$1D,$DE,$F2,$0D             ; 03F4CA ........ ????????
.byte $F0,$06,$20,$48,$F9,$4C,$41,$81             ; 03F4D2 ........ ?? H?LA?
.byte $A9,$09,$9D,$44,$07,$A9,$00,$9D             ; 03F4DA ........ ???D????
.byte $28,$08,$A9,$20,$9D,$BC,$13,$A9             ; 03F4E2 ........ (?? ????
.byte $32,$9D,$2E,$14,$9E,$0C,$09,$9E             ; 03F4EA ........ 2?.?????
.byte $7E,$09,$9E,$F0,$09,$9E,$62,$0A             ; 03F4F2 ........ ~?????b?
.byte $A9,$04,$9D,$4A,$13,$9E,$D8,$12             ; 03F4FA ........ ???J????
.byte $A9,$08,$85,$1C,$A9,$08,$85,$1D             ; 03F502 ........ ????????
.byte $22,$C2,$AF,$00,$22,$95,$CA,$0E             ; 03F50A ........ "???"???
.byte $29,$07,$D0,$0D,$C2,$10,$A9,$07             ; 03F512 ........ )???????
.byte $A2,$06,$FF,$22,$0F,$83,$0F,$E2             ; 03F51A ........ ???"????
.byte $30,$AE,$E3,$18,$DE,$C5,$18,$D0             ; 03F522 ........ 0???????
.byte $06,$9E,$C9,$18,$9E,$C1,$18,$4C             ; 03F52A ........ ???????L
.byte $41,$81,$AC,$8B,$06,$B9,$44,$07             ; 03F532 ........ A?????D?
.byte $C9,$98,$F0,$05,$BD,$10,$11,$F0             ; 03F53A ........ ????????
.byte $1A,$A9,$9E,$9D,$44,$07,$22,$95             ; 03F542 ........ ????D?"?
.byte $CA,$0E,$29,$0F,$85,$0E,$22,$95             ; 03F54A ........ ??)???"?
.byte $CA,$0E,$29,$0F,$65,$0E,$69,$01             ; 03F552 ........ ??)?e?i?
.byte $9D,$F2,$0D,$AD,$AB,$06,$85,$04             ; 03F55A ........ ????????
.byte $AD,$AC,$06,$85,$05,$BC,$2C,$10             ; 03F562 ........ ??????,?
.byte $18,$A5,$04,$79,$A9,$F5,$9D,$46             ; 03F56A ........ ???y???F
.byte $0B,$18,$A5,$05,$79,$B9,$F5,$9D             ; 03F572 ........ ????y???
.byte $9C,$0C,$BC,$9E,$10,$BD,$BC,$13             ; 03F57A ........ ????????
.byte $29,$8F,$19,$A5,$F5,$9D,$BC,$13             ; 03F582 ........ )???????
.byte $22,$2C,$F6,$0D,$20,$48,$F9,$A5             ; 03F58A ........ ",?? H??
.byte $D2,$29,$03,$D0,$0B,$BD,$2E,$14             ; 03F592 ........ ?)????.?
.byte $29,$CF,$1D,$B6,$07,$9D,$2E,$14             ; 03F59A ........ )?????.?
.byte $4C,$41,$81,$00,$20,$40,$60,$F9             ; 03F5A2 ........ LA?? @`?
.byte $EC,$E3,$DD,$DD,$E4,$EE,$FA,$07             ; 03F5AA ........ ????????
.byte $12,$1D,$21,$23,$1C,$12,$06,$DC             ; 03F5B2 ........ ??!#????
.byte $E2,$ED,$FD,$0E,$1D,$27,$2C,$DC             ; 03F5BA ........ ?????',?
.byte $E2,$ED,$FD,$0E,$1D,$27,$2C,$22             ; 03F5C2 ........ ?????',"
.byte $0C,$F4,$0D,$22,$DE,$F3,$0D,$DE             ; 03F5CA ........ ???"????
.byte $80,$0D,$D0,$23,$A9,$0F,$9D,$80             ; 03F5D2 ........ ???#????
.byte $0D,$A9,$00,$22,$E5,$F2,$0D,$DE             ; 03F5DA ........ ???"????
.byte $F2,$0D,$D0,$13,$A9,$A1,$9D,$44             ; 03F5E2 ........ ???????D
.byte $07,$A9,$19,$9D,$80,$0D,$22,$7C             ; 03F5EA ........ ??????"|
.byte $F2,$0D,$A9,$01,$8D,$88,$06,$22             ; 03F5F2 ........ ???????"
.byte $8E,$F4,$0D,$20,$05,$F9,$A9,$23             ; 03F5FA ........ ??? ???#
.byte $20,$95,$81,$20,$03,$FA,$22,$96             ; 03F602 ........  ?? ??"?
.byte $F5,$0E,$4C,$41,$81,$22,$0C,$F4             ; 03F60A ........ ??LA?"??
.byte $0D,$DE,$80,$0D,$D0,$0D,$CE,$C6             ; 03F612 ........ ????????
.byte $06,$CE,$00,$19,$9E,$D2,$06,$22             ; 03F61A ........ ???????"
.byte $C8,$FC,$0D,$4C,$41,$81,$4C,$41             ; 03F622 ........ ???LA?LA
.byte $81,$4C,$41,$81,$4C,$41,$81,$4C             ; 03F62A ........ ?LA?LA?L
.byte $41,$81,$DE,$80,$0D,$F0,$48,$A9             ; 03F632 ........ A?????H?
.byte $05,$20,$95,$81,$38,$BD,$46,$0B             ; 03F63A ........ ? ??8?F?
.byte $E9,$04,$B0,$02,$A9,$00,$9D,$16             ; 03F642 ........ ????????
.byte $15,$18,$BD,$46,$0B,$69,$04,$90             ; 03F64A ........ ???F?i??
.byte $02,$A9,$FF,$9D,$88,$15,$38,$BD             ; 03F652 ........ ??????8?
.byte $9C,$0C,$E9,$04,$B0,$02,$A9,$00             ; 03F65A ........ ????????
.byte $9D,$FA,$15,$18,$BD,$9C,$0C,$69             ; 03F662 ........ ???????i
.byte $04,$90,$02,$A9,$FF,$9D,$6C,$16             ; 03F66A ........ ??????l?
.byte $A9,$08,$85,$1C,$A9,$08,$85,$1D             ; 03F672 ........ ????????
.byte $22,$C2,$AF,$00,$4C,$41,$81,$CE             ; 03F67A ........ "???LA??
.byte $F1,$18,$A9,$06,$9D,$44,$07,$A9             ; 03F682 ........ ?????D??
.byte $00,$9D,$28,$08,$A9,$20,$9D,$BC             ; 03F68A ........ ??(?? ??
.byte $13,$A9,$32,$9D,$2E,$14,$9E,$0C             ; 03F692 ........ ??2?.???
.byte $09,$9E,$7E,$09,$9E,$F0,$09,$9E             ; 03F69A ........ ??~?????
.byte $62,$0A,$A9,$04,$9D,$4A,$13,$9E             ; 03F6A2 ........ b????J??
.byte $D8,$12,$A9,$08,$85,$1C,$A9,$08             ; 03F6AA ........ ????????
.byte $85,$1D,$22,$C2,$AF,$00,$C2,$10             ; 03F6B2 ........ ??"?????
.byte $A9,$07,$A2,$06,$FF,$22,$0F,$83             ; 03F6BA ........ ?????"??
.byte $0F,$E2,$10,$4C,$41,$81,$DE,$64             ; 03F6C2 ........ ???LA??d
.byte $0E,$F0,$68,$A9,$03,$20,$95,$81             ; 03F6CA ........ ??h?? ??
.byte $DE,$4A,$13,$D0,$1B,$A9,$02,$9D             ; 03F6D2 ........ ?J??????
.byte $4A,$13,$FE,$D8,$12,$BD,$D8,$12             ; 03F6DA ........ J???????
.byte $C9,$05,$D0,$03,$9E,$D8,$12,$BC             ; 03F6E2 ........ ????????
.byte $D8,$12,$B9,$79,$F7,$9D,$BC,$13             ; 03F6EA ........ ???y????
.byte $38,$BD,$46,$0B,$E9,$01,$B0,$02             ; 03F6F2 ........ 8?F?????
.byte $A9,$00,$9D,$16,$15,$18,$BD,$46             ; 03F6FA ........ ???????F
.byte $0B,$69,$01,$90,$02,$A9,$FF,$9D             ; 03F702 ........ ?i??????
.byte $88,$15,$38,$BD,$9C,$0C,$E9,$01             ; 03F70A ........ ??8?????
.byte $B0,$02,$A9,$00,$9D,$FA,$15,$18             ; 03F712 ........ ????????
.byte $BD,$9C,$0C,$69,$01,$90,$02,$A9             ; 03F71A ........ ???i????
.byte $FF,$9D,$6C,$16,$A9,$08,$85,$1C             ; 03F722 ........ ??l?????
.byte $A9,$08,$85,$1D,$22,$C2,$AF,$00             ; 03F72A ........ ????"???
.byte $4C,$41,$81,$A9,$06,$9D,$44,$07             ; 03F732 ........ LA????D?
.byte $A9,$00,$9D,$28,$08,$A9,$20,$9D             ; 03F73A ........ ???(?? ?
.byte $BC,$13,$A9,$32,$9D,$2E,$14,$9E             ; 03F742 ........ ???2?.??
.byte $0C,$09,$9E,$7E,$09,$9E,$F0,$09             ; 03F74A ........ ???~????
.byte $9E,$62,$0A,$A9,$04,$9D,$4A,$13             ; 03F752 ........ ?b????J?
.byte $9E,$D8,$12,$A9,$08,$85,$1C,$A9             ; 03F75A ........ ????????
.byte $08,$85,$1D,$22,$C2,$AF,$00,$C2             ; 03F762 ........ ???"????
.byte $10,$A9,$07,$A2,$06,$FF,$22,$0F             ; 03F76A ........ ??????"?
.byte $83,$0F,$E2,$10,$4C,$41,$81,$80             ; 03F772 ........ ????LA??
.byte $82,$84,$86,$88,$38,$AD,$AC,$06             ; 03F77A ........ ????8???
.byte $E9,$06,$9D,$9C,$0C,$BC,$BA,$0F             ; 03F782 ........ ????????
.byte $18,$AD,$AB,$06,$79,$54,$F8,$9D             ; 03F78A ........ ????yT??
.byte $46,$0B,$DE,$4A,$13,$D0,$1B,$A9             ; 03F792 ........ F??J????
.byte $02,$9D,$4A,$13,$FE,$D8,$12,$BD             ; 03F79A ........ ??J?????
.byte $D8,$12,$C9,$05,$D0,$03,$9E,$D8             ; 03F7A2 ........ ????????
.byte $12,$BC,$D8,$12,$B9,$4F,$F8,$9D             ; 03F7AA ........ ?????O??
.byte $BC,$13,$DE,$80,$0D,$F0,$43,$38             ; 03F7B2 ........ ??????C8
.byte $BD,$46,$0B,$E9,$01,$B0,$02,$A9             ; 03F7BA ........ ?F??????
.byte $00,$9D,$16,$15,$18,$BD,$46,$0B             ; 03F7C2 ........ ??????F?
.byte $69,$01,$90,$02,$A9,$FF,$9D,$88             ; 03F7CA ........ i???????
.byte $15,$38,$BD,$9C,$0C,$E9,$01,$B0             ; 03F7D2 ........ ?8??????
.byte $02,$A9,$00,$9D,$FA,$15,$18,$BD             ; 03F7DA ........ ????????
.byte $9C,$0C,$69,$01,$90,$02,$A9,$FF             ; 03F7E2 ........ ??i?????
.byte $9D,$6C,$16,$A9,$08,$85,$1C,$A9             ; 03F7EA ........ ?l??????
.byte $08,$85,$1D,$22,$C2,$AF,$00,$4C             ; 03F7F2 ........ ???"???L
.byte $41,$81,$9C,$B3,$06,$A9,$08,$9D             ; 03F7FA ........ A???????
.byte $28,$08,$A9,$A7,$9D,$44,$07,$BD             ; 03F802 ........ (????D??
.byte $46,$0B,$8D,$DF,$1A,$BD,$9C,$0C             ; 03F80A ........ F???????
.byte $8D,$E1,$1A,$AC,$BB,$06,$B9,$46             ; 03F812 ........ ???????F
.byte $0B,$8D,$E0,$1A,$B9,$9C,$0C,$8D             ; 03F81A ........ ????????
.byte $E2,$1A,$A9,$00,$8D,$E3,$1A,$A9             ; 03F822 ........ ????????
.byte $03,$8D,$E4,$1A,$DA,$22,$00,$80             ; 03F82A ........ ?????"??
.byte $01,$FA,$AD,$E5,$1A,$9D,$0C,$09             ; 03F832 ........ ????????
.byte $AD,$E6,$1A,$9D,$7E,$09,$AD,$E7             ; 03F83A ........ ????~???
.byte $1A,$9D,$F0,$09,$AD,$E8,$1A,$9D             ; 03F842 ........ ????????
.byte $62,$0A,$4C,$41,$81,$80,$82,$84             ; 03F84A ........ b?LA????
.byte $86,$88,$F2,$0E,$DE,$80,$0D,$F0             ; 03F852 ........ ????????
.byte $73,$BD,$7E,$09,$30,$0C,$1D,$0C             ; 03F85A ........ s?~?0???
.byte $09,$F0,$0E,$A9,$EE,$DD,$46,$0B             ; 03F862 ........ ??????F?
.byte $90,$62,$A9,$12,$DD,$46,$0B,$B0             ; 03F86A ........ ?b???F??
.byte $5B,$BD,$62,$0A,$30,$0C,$1D,$F0             ; 03F872 ........ [?b?0???
.byte $09,$F0,$0E,$A9,$DC,$DD,$9C,$0C             ; 03F87A ........ ????????
.byte $90,$4A,$A9,$14,$DD,$9C,$0C,$B0             ; 03F882 ........ ?J??????
.byte $43,$38,$BD,$46,$0B,$E9,$01,$B0             ; 03F88A ........ C8?F????
.byte $02,$A9,$00,$9D,$16,$15,$18,$BD             ; 03F892 ........ ????????
.byte $46,$0B,$69,$01,$90,$02,$A9,$FF             ; 03F89A ........ F?i?????
.byte $9D,$88,$15,$38,$BD,$9C,$0C,$E9             ; 03F8A2 ........ ???8????
.byte $01,$B0,$02,$A9,$00,$9D,$FA,$15             ; 03F8AA ........ ????????
.byte $18,$BD,$9C,$0C,$69,$01,$90,$02             ; 03F8B2 ........ ????i???
.byte $A9,$FF,$9D,$6C,$16,$A9,$08,$85             ; 03F8BA ........ ???l????
.byte $1C,$A9,$08,$85,$1D,$22,$C2,$AF             ; 03F8C2 ........ ?????"??
.byte $00,$4C,$41,$81,$A9,$06,$9D,$44             ; 03F8CA ........ ?LA????D
.byte $07,$A9,$00,$9D,$28,$08,$A9,$20             ; 03F8D2 ........ ????(?? 
.byte $9D,$BC,$13,$A9,$32,$9D,$2E,$14             ; 03F8DA ........ ????2?.?
.byte $9E,$0C,$09,$9E,$7E,$09,$9E,$F0             ; 03F8E2 ........ ????~???
.byte $09,$9E,$62,$0A,$A9,$04,$9D,$4A             ; 03F8EA ........ ??b????J
.byte $13,$9E,$D8,$12,$A9,$08,$85,$1C             ; 03F8F2 ........ ????????
.byte $A9,$08,$85,$1D,$22,$C2,$AF,$00             ; 03F8FA ........ ????"???
.byte $4C,$41,$81,$BD,$7E,$09,$10,$10             ; 03F902 ........ LA??~???
.byte $C9,$FE,$F0,$02,$B0,$16,$A9,$FF             ; 03F90A ........ ????????
.byte $9D,$7E,$09,$9E,$0C,$09,$80,$0C             ; 03F912 ........ ?~??????
.byte $C9,$01,$90,$08,$A9,$01,$9D,$7E             ; 03F91A ........ ???????~
.byte $09,$9E,$0C,$09,$BD,$62,$0A,$10             ; 03F922 ........ ?????b??
.byte $10,$C9,$FE,$F0,$02,$B0,$16,$A9             ; 03F92A ........ ????????
.byte $FF,$9D,$62,$0A,$9E,$F0,$09,$80             ; 03F932 ........ ??b?????
.byte $0C,$C9,$01,$90,$08,$A9,$01,$9D             ; 03F93A ........ ????????
.byte $62,$0A,$9E,$F0,$09,$60,$BD,$2C             ; 03F942 ........ b????`?,
.byte $10,$29,$07,$A8,$B9,$5D,$F9,$85             ; 03F94A ........ ?)???]??
.byte $1C,$B9,$65,$F9,$85,$1D,$22,$C2             ; 03F952 ........ ??e???"?
.byte $AF,$00,$60,$08,$07,$08,$07,$08             ; 03F95A ........ ??`?????
.byte $08,$08,$08,$08,$08,$08,$09,$08             ; 03F962 ........ ????????
.byte $08,$08,$09,$BD,$2C,$10,$29,$03             ; 03F96A ........ ????,?)?
.byte $A8,$B9,$F3,$F9,$85,$1C,$B9,$FB             ; 03F972 ........ ????????
.byte $F9,$85,$1D,$22,$C2,$AF,$00,$BD             ; 03F97A ........ ???"????
.byte $2C,$10,$A8,$18,$A5,$1C,$79,$E3             ; 03F982 ........ ,?????y?
.byte $F9,$85,$1C,$18,$A5,$1D,$79,$EB             ; 03F98A ........ ??????y?
.byte $F9,$85,$1D,$BD,$BC,$13,$09,$02             ; 03F992 ........ ????????
.byte $85,$1B,$BC,$A0,$14,$B9,$DE,$17             ; 03F99A ........ ????????
.byte $0A,$0A,$A8,$90,$1E,$38,$BD,$46             ; 03F9A2 ........ ?????8?F
.byte $0B,$E5,$1C,$99,$08,$04,$38,$BD             ; 03F9AA ........ ??????8?
.byte $9C,$0C,$E5,$1D,$99,$09,$04,$A5             ; 03F9B2 ........ ????????
.byte $1B,$99,$0A,$04,$BD,$2E,$14,$99             ; 03F9BA ........ ?????.??
.byte $0B,$04,$60,$38,$BD,$46,$0B,$E5             ; 03F9C2 ........ ??`8?F??
.byte $1C,$99,$08,$03,$38,$BD,$9C,$0C             ; 03F9CA ........ ????8???
.byte $E5,$1D,$99,$09,$03,$A5,$1B,$99             ; 03F9D2 ........ ????????
.byte $0A,$03,$BD,$2E,$14,$99,$0B,$03             ; 03F9DA ........ ???.????
.byte $60,$F0,$00,$00,$F0,$10,$00,$00             ; 03F9E2 ........ `???????
.byte $10,$00,$F0,$F0,$00,$00,$F0,$F0             ; 03F9EA ........ ????????
.byte $00,$0A,$03,$04,$0C,$0A,$03,$04             ; 03F9F2 ........ ????????
.byte $0C,$05,$0A,$0A,$09,$05,$0A,$0A             ; 03F9FA ........ ????????
.byte $09,$18,$BD,$46,$0B,$6D,$AD,$06             ; 03FA02 ........ ???F?m??
.byte $8D,$AB,$06,$18,$BD,$9C,$0C,$6D             ; 03FA0A ........ ???????m
.byte $AE,$06,$8D,$AC,$06,$38,$A9,$28             ; 03FA12 ........ ?????8?(
.byte $ED,$AB,$06,$8D,$CD,$06,$A9,$00             ; 03FA1A ........ ????????
.byte $8D,$CE,$06,$38,$A9,$28,$ED,$AC             ; 03FA22 ........ ???8?(??
.byte $06,$8D,$D0,$06,$A9,$00,$8D,$D1             ; 03FA2A ........ ????????
.byte $06,$60,$A5,$D2,$29,$03,$D0,$35             ; 03FA32 ........ ?`??)??5
.byte $CE,$BA,$06,$D0,$30,$22,$95,$CA             ; 03FA3A ........ ????0"??
.byte $0E,$29,$3F,$69,$28,$8D,$BA,$06             ; 03FA42 ........ ?)?i(???
.byte $A9,$01,$4D,$BB,$06,$8D,$BB,$06             ; 03FA4A ........ ??M?????
.byte $AD,$B0,$06,$0A,$0A,$85,$04,$22             ; 03FA52 ........ ???????"
.byte $95,$CA,$0E,$29,$03,$18,$65,$04             ; 03FA5A ........ ???)??e?
.byte $A8,$B9,$90,$FA,$8D,$B4,$06,$B9             ; 03FA62 ........ ????????
.byte $70,$FA,$8D,$B5,$06,$60,$40,$10             ; 03FA6A ........ p????`@?
.byte $40,$20,$40,$10,$40,$20,$40,$10             ; 03FA72 ........ @ @?@ @?
.byte $40,$20,$40,$10,$40,$20,$40,$10             ; 03FA7A ........ @ @?@ @?
.byte $40,$20,$40,$10,$40,$20,$40,$10             ; 03FA82 ........ @ @?@ @?
.byte $40,$20,$40,$10,$40,$20,$08,$08             ; 03FA8A ........ @ @?@ ??
.byte $0E,$10,$08,$0C,$0E,$10,$10,$0C             ; 03FA92 ........ ????????
.byte $0E,$12,$10,$0C,$10,$14,$08,$0E             ; 03FA9A ........ ????????
.byte $10,$16,$08,$0E,$12,$18,$0E,$0E             ; 03FAA2 ........ ????????
.byte $10,$24,$0E,$14,$18,$30,$00,$1A             ; 03FAAA ........ ?$???0??
.byte $34,$4E,$68,$82,$9C,$B6,$D0,$EA             ; 03FAB2 ........ 4Nh?????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FABA ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FAC2 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FACA ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FAD2 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FADA ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FAE2 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FAEA ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FAF2 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FAFA ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB02 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB0A ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB12 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB1A ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB22 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB2A ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB32 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB3A ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB42 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB4A ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB52 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB5A ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB62 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB6A ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB72 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB7A ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB82 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB8A ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB92 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FB9A ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FBA2 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FBAA ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FBB2 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FBBA ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FBC2 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FBCA ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FBD2 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FBDA ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FBE2 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FBEA ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FBF2 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FBFA ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC02 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC0A ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC12 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC1A ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC22 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC2A ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC32 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC3A ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC42 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC4A ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC52 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC5A ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC62 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC6A ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC72 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC7A ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC82 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC8A ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC92 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FC9A ........ ????????
.byte $01,$01,$01,$01,$01,$01,$01,$01             ; 03FCA2 ........ ????????
.byte $01,$01,$01,$01,$01,$01,$00,$00             ; 03FCAA ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FCB2 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FCBA ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FCC2 ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FCCA ........ ????????
.byte $00,$00,$00,$00,$00,$00,$00,$00             ; 03FCD2 ........ ????????
.byte $00,$08,$20,$38,$50,$68,$80,$98             ; 03FCDA ........ ?? 8Ph??
.byte $B0,$C8,$E0,$F8,$10,$28,$40,$58             ; 03FCE2 ........ ?????(@X
.byte $70,$88,$A0,$B8,$D0,$E8,$00,$18             ; 03FCEA ........ p???????
.byte $30,$48,$60,$78,$90,$A8,$C0,$D8             ; 03FCF2 ........ 0H`x????
.byte $F0,$08,$20,$38,$50,$68,$80,$98             ; 03FCFA ........ ?? 8Ph??
.byte $B0,$C8,$E0,$F8,$10,$28,$40,$58             ; 03FD02 ........ ?????(@X
.byte $70,$88,$A0,$B8,$D0,$E8,$00,$18             ; 03FD0A ........ p???????
.byte $30,$48,$60,$78,$90,$A8,$C0,$D8             ; 03FD12 ........ 0H`x????
.byte $F0,$08,$20,$38,$50,$68,$80,$98             ; 03FD1A ........ ?? 8Ph??
.byte $B0,$C8,$E0,$F8,$10,$28,$40,$58             ; 03FD22 ........ ?????(@X
.byte $70,$88,$A0,$B8,$D0,$E8,$00,$18             ; 03FD2A ........ p???????
.byte $30,$48,$60,$78,$90,$A8,$C0,$D8             ; 03FD32 ........ 0H`x????
.byte $F0,$08,$20,$38,$50,$68,$80,$98             ; 03FD3A ........ ?? 8Ph??
.byte $B0,$C8,$E0,$F8,$10,$28,$40,$58             ; 03FD42 ........ ?????(@X
.byte $70,$88,$A0,$B8,$D0,$E8,$00,$18             ; 03FD4A ........ p???????
.byte $30,$48,$60,$78,$90,$A8,$C0,$D8             ; 03FD52 ........ 0H`x????
.byte $F0,$08,$20,$38,$50,$68,$80,$98             ; 03FD5A ........ ?? 8Ph??
.byte $B0,$C8,$E0,$F8,$10,$28,$40,$58             ; 03FD62 ........ ?????(@X
.byte $70,$88,$A0,$B8,$D0,$E8,$00,$18             ; 03FD6A ........ p???????
.byte $30,$48,$60,$78,$90,$A8,$C0,$D8             ; 03FD72 ........ 0H`x????
.byte $F0,$08,$20,$38,$50,$68,$80,$98             ; 03FD7A ........ ?? 8Ph??
.byte $B0,$C8,$E0,$F8,$10,$28,$40,$58             ; 03FD82 ........ ?????(@X
.byte $70,$88,$A0,$B8,$D0,$E8,$00,$18             ; 03FD8A ........ p???????
.byte $30,$48,$60,$78,$90,$A8,$C0,$D8             ; 03FD92 ........ 0H`x????
.byte $F0,$08,$20,$38,$50,$68,$80,$98             ; 03FD9A ........ ?? 8Ph??
.byte $B0,$C8,$E0,$F8,$10,$28,$40,$58             ; 03FDA2 ........ ?????(@X
.byte $70,$88,$A0,$B8,$D0,$E8,$04,$04             ; 03FDAA ........ p???????
.byte $04,$04,$04,$04,$04,$04,$04,$04             ; 03FDB2 ........ ????????
.byte $04,$04,$04,$04,$04,$04,$04,$04             ; 03FDBA ........ ????????
.byte $04,$04,$04,$04,$04,$04,$04,$04             ; 03FDC2 ........ ????????
.byte $04,$04,$04,$04,$04,$04,$04,$04             ; 03FDCA ........ ????????
.byte $04,$04,$04,$04,$04,$04,$04,$04             ; 03FDD2 ........ ????????
.byte $04,$04,$04,$04,$04,$04,$04,$04             ; 03FDDA ........ ????????
.byte $04,$04,$04,$04,$05,$05,$05,$05             ; 03FDE2 ........ ????????
.byte $05,$05,$05,$05,$05,$05,$06,$06             ; 03FDEA ........ ????????
.byte $06,$06,$06,$06,$06,$06,$06,$06             ; 03FDF2 ........ ????????
.byte $06,$07,$07,$07,$07,$07,$07,$07             ; 03FDFA ........ ????????
.byte $07,$07,$07,$07,$08,$08,$08,$08             ; 03FE02 ........ ????????
.byte $08,$08,$08,$08,$08,$08,$09,$09             ; 03FE0A ........ ????????
.byte $09,$09,$09,$09,$09,$09,$09,$09             ; 03FE12 ........ ????????
.byte $09,$0A,$0A,$0A,$0A,$0A,$0A,$0A             ; 03FE1A ........ ????????
.byte $0A,$0A,$0A,$0A,$0B,$0B,$0B,$0B             ; 03FE22 ........ ????????
.byte $0B,$0B,$0B,$0B,$0B,$0B,$0C,$0C             ; 03FE2A ........ ????????
.byte $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C             ; 03FE32 ........ ????????
.byte $0C,$0D,$0D,$0D,$0D,$0D,$0D,$0D             ; 03FE3A ........ ????????
.byte $0D,$0D,$0D,$0D,$0E,$0E,$0E,$0E             ; 03FE42 ........ ????????
.byte $0E,$0E,$0E,$0E,$0E,$0E,$0F,$0F             ; 03FE4A ........ ????????
.byte $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F             ; 03FE52 ........ ????????
.byte $0F,$10,$10,$10,$10,$10,$10,$10             ; 03FE5A ........ ????????
.byte $10,$10,$10,$10,$11,$11,$11,$11             ; 03FE62 ........ ????????
.byte $11,$11,$11,$11,$11,$11,$12,$12             ; 03FE6A ........ ????????
.byte $12,$12,$12,$12,$12,$12,$12,$12             ; 03FE72 ........ ????????
.byte $12,$13,$13,$13,$13,$13,$13,$13             ; 03FE7A ........ ????????
.byte $13,$13,$13,$13,$14,$14,$14,$14             ; 03FE82 ........ ????????
.byte $14,$14,$14,$14,$14,$14,$15,$15             ; 03FE8A ........ ????????
.byte $15,$15,$15,$15,$15,$15,$15,$15             ; 03FE92 ........ ????????
.byte $15,$16,$16,$16,$16,$16,$16,$16             ; 03FE9A ........ ????????
.byte $16,$16,$16,$16,$17,$17,$17,$17             ; 03FEA2 ........ ????????
.byte $17,$17,$17,$17,$17,$17,$FF,$FF             ; 03FEAA ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FEB2 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FEBA ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FEC2 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FECA ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FED2 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FEDA ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FEE2 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FEEA ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FEF2 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FEFA ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF02 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF0A ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF12 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF1A ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF22 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF2A ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF32 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF3A ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF42 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF4A ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF52 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF5A ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF62 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF6A ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF72 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF7A ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF82 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF8A ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF92 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FF9A ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FFA2 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FFAA ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FFB2 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FFBA ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FFC2 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FFCA ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FFD2 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FFDA ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FFE2 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FFEA ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF             ; 03FFF2 ........ ????????
.byte $FF,$FF,$FF,$FF,$FF,$FF                     ; 03FFFB ......   ??????
