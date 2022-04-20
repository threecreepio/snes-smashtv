char RNG0 = 0
char RNG1 = 0

const AdvanceRNG = () => {
    let carry = (RNG0 & 0x80) ? 1 : 0;
    RNG0 = (RNG0 << 1) | carry;

    RNG0 += 0x4E + 1;

    RNG0 ^= 0x3A;

    RNG1 = 

  adc.b #$4E
  eor.b #$3A
  sta RNG0
  eor RNG1
  adc.b #$C3
  sta RNG1
  rtl
}