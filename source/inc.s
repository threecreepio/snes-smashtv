
CurrentRound = $5AB
CurrentRoom = $5AC

; entity data
MaxEntities = $72
Projectiles = $42
EntityHeader = $06D2
EntityV1     = EntityHeader + (MaxEntities *  1)
EntityV2     = EntityHeader + (MaxEntities *  2)
EntityV3     = EntityHeader + (MaxEntities *  3)
EntityV4     = EntityHeader + (MaxEntities *  4)
EntityV5     = EntityHeader + (MaxEntities *  5)
EntityV6     = EntityHeader + (MaxEntities *  6)
EntityV7     = EntityHeader + (MaxEntities *  7)
EntityV8     = EntityHeader + (MaxEntities *  8)
EntityXSubPx     = EntityHeader + (MaxEntities *  9)
EntityXPx    = EntityHeader + (MaxEntities * 10)
EntityV11    = EntityHeader + (MaxEntities * 11)
EntityYSubPx    = EntityHeader + (MaxEntities * 12)
EntityYPx    = EntityHeader + (MaxEntities * 13)
EntityV14    = EntityHeader + (MaxEntities * 14)
EntityV15    = EntityHeader + (MaxEntities * 15)
EntityV16    = EntityHeader + (MaxEntities * 16)
EntityV17    = EntityHeader + (MaxEntities * 17)
EntityV18    = EntityHeader + (MaxEntities * 18)
EntityV19    = EntityHeader + (MaxEntities * 19)
EntityV20    = EntityHeader + (MaxEntities * 20)
EntityV21    = EntityHeader + (MaxEntities * 21)
EntityV22    = EntityHeader + (MaxEntities * 22)
EntityV23    = EntityHeader + (MaxEntities * 23)
EntityV24    = EntityHeader + (MaxEntities * 24)
EntityV25    = EntityHeader + (MaxEntities * 25)
EntityV26    = EntityHeader + (MaxEntities * 26)
EntityV27    = EntityHeader + (MaxEntities * 27)
EntityV28    = EntityHeader + (MaxEntities * 28)
EntityV29    = EntityHeader + (MaxEntities * 29)
EntityV30    = EntityHeader + (MaxEntities * 30)
EntityV31    = EntityHeader + (MaxEntities * 31)
EntityV32    = EntityHeader + (MaxEntities * 32) + 4 ; 4 values squeezed in before these
EntityV33    = EntityHeader + (MaxEntities * 33) + 4
EntityV34    = EntityHeader + (MaxEntities * 34) + 4
EntityV35    = EntityHeader + (MaxEntities * 35) + 4
EntityV36    = EntityHeader + (MaxEntities * 36) + 4


JoyDirect  = $02E8
JoyDown    = $02F0
JoyHolding = $02F8
JoyPressed = $0300


IRQHandlerLo   = $00CB
IRQHandlerHi   = $00CC
IRQHandlerBank = $00CD

NMIHandlerLo   = $00C7
NMIHandlerHi   = $00C8
NMIHandlerBank = $00C9

NMIPending = $052D
XexzyItemLocationMaybe = $27
XexzyItemXPickupMaybe = $28
XexzyDropIndicator = $43
XexzyScore = $97
FrameCounter = $CF
XexzyTorsoY = $309
XexzyLegY = $30D
XexzyItemY = $505
XexzyLivesCount = $531
RNG0 = $5A8
RNG1 = $5A9
XexzyDropCountDownTimer = $5AE
XexzyMutoidHealth = $69A
XexzyCharX = $B46
XexzyWalkAnimation = $1886
XexzyAmmoCounter = $189D
INIDISP = $2100
OBSEL = $2101
OAMADDL = $2102
OAMADDH = $2103
OAMDATA = $2104
BGMODE = $2105
MOSAIC = $2106
BG1SC = $2107
BG2SC = $2108
BG3SC = $2109
BG4SC = $210A
BG12NBA = $210B
BG34NBA = $210C
BG1HOFS = $210D
BG1VOFS = $210E
BG2HOFS = $210F
BG2VOFS = $2110
BG3HOFS = $2111
BG3VOFS = $2112
BG4HOFS = $2113
BG4VOFS = $2114
VMAIN = $2115
VMADDL = $2116
VMADDH = $2117
VMDATAL = $2118
VMDATAH = $2119
M7SEL = $211A
M7A = $211B
M7B = $211C
M7C = $211D
M7D = $211E
M7X = $211F
M7Y = $2120
CGADD = $2121
CGDATA = $2122
W12SEL = $2123
W34SEL = $2124
WOBJSEL = $2125
WH0 = $2126
WH1 = $2127
WH2 = $2128
WH3 = $2129
WBGLOG = $212A
WOBJLOG = $212B
TM = $212C
TS = $212D
TMW = $212E
TSW = $212F
CGWSEL = $2130
CGADSUB = $2131
COLDATA = $2132
SETINI = $2133
MPYL = $2134
MPYM = $2135
MPYH = $2136
SLHV = $2137
OAMDATAREAD = $2138
VMDATALREAD = $2139
VMDATAHREAD = $213A
CGDATAREAD = $213B
OPHCT = $213C
OPVCT = $213D
STAT77 = $213E
STAT78 = $213F
APUIO0 = $2140
APUIO1 = $2141
APUIO2 = $2142
APUIO3 = $2143
WMDATA = $2180
WMADDL = $2181
WMADDM = $2182
WMADDH = $2183
JOYSER0 = $4016
JOYSER1 = $4017
NMITIMEN = $4200
WRIO = $4201
WRMPYA = $4202
WRMPYB = $4203
WRDIVL = $4204
WRDIVH = $4205
WRDIVB = $4206
HTIMEL = $4207
HTIMEH = $4208
VTIMEL = $4209
VTIMEH = $420A
MDMAEN = $420B
HDMAEN = $420C
MEMSEL = $420D
RDNMI = $4210
TIMEUP = $4211
HVBJOY = $4212
RDIO = $4213
RDDIVL = $4214
RDDIVH = $4215
RDMPYL = $4216
RDMPYH = $4217
JOY1L = $4218
JOY1H = $4219
JOY2L = $421A
JOY2H = $421B
JOY3L = $421C
JOY3H = $421D
JOY4L = $421E
JOY4H = $421F
DMAP0 = $4300
BBAD0 = $4301
A1T0L = $4302
A1T0H = $4303
A1B0 = $4304
DAS0L = $4305
DAS0H = $4306
DAS0B = $4307
A2A0L = $4308
A2A0H = $4309
NTLR0 = $430A
DMAP1 = $4310
BBAD1 = $4311
A1T1L = $4312
A1T1H = $4313
A1B1 = $4314
DAS1L = $4315
DAS1H = $4316
DAS1B = $4317
A2A1L = $4318
A2A1H = $4319
NTLR1 = $431A
DMAP2 = $4320
BBAD2 = $4321
A1T2L = $4322
A1T2H = $4323
A1B2 = $4324
DAS2L = $4325
DAS2H = $4326
DAS2B = $4327
A2A2L = $4328
A2A2H = $4329
NTL21 = $432A
DMAP3 = $4330
BBAD3 = $4331
A1T3L = $4332
A1T3H = $4333
A1B3 = $4334
DAS3L = $4335
DAS3H = $4336
DAS3B = $4337
A2A3L = $4338
A2A3H = $4339
NTL31 = $433A
DMAP4 = $4340
BBAD4 = $4341
A1T4L = $4342
A1T4H = $4343
A1B4 = $4344
DAS4L = $4345
DAS4H = $4346
DAS4B = $4347
A2A4L = $4348
A2A4H = $4349
NTL41 = $434A
DMAP5 = $4350
BBAD5 = $4351
A1T5L = $4352
A1T5H = $4353
A1B5 = $4354
DAS5L = $4355
DAS5H = $4356
DAS5B = $4357
A2A5L = $4358
A2A5H = $4359
NTL51 = $435A
DMAP6 = $4360
BBAD6 = $4361
A1T6L = $4362
A1T6H = $4363
A1B6 = $4364
DAS6L = $4365
DAS6H = $4366
DAS6B = $4367
A2A6L = $4368
A2A6H = $4369
NTL61 = $436A
DMAP7 = $4370
BBAD7 = $4371
A1T7L = $4372
A1T7H = $4373
A1B7 = $4374
DAS7L = $4375
DAS7H = $4376
DAS7B = $4377
A2A7L = $4378
A2A7H = $4379
NTL71 = $437A
D_7E0204 = $7E0204
D_7E0206 = $7E0206
D_7E0208 = $7E0208
D_7E020A = $7E020A
D_7E020C = $7E020C
D_7E1AF1 = $7E1AF1
D_7E201E = $7E201E
D_7E2096 = $7E2096
D_7E2098 = $7E2098
D_7E209A = $7E209A
D_7E20A2 = $7E20A2
D_7E20A4 = $7E20A4
D_7E20A6 = $7E20A6
D_7E20AE = $7E20AE
D_7E28AE = $7E28AE
D_7E30AE = $7E30AE
D_7E334C = $7E334C
D_7E338C = $7E338C
D_7E3BAE = $7E3BAE
D_7E6CF6 = $7E6CF6