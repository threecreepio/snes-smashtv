
function scanRNG(seed0, seed1) {
    let RNG0 = seed0 // (Math.random() * 0x100)|100
    let RNG1 = seed1 // (Math.random() * 0x100)|100
    // 607     130     82

    const AdvanceRNG = () => {
        let carry = (RNG0 & 0x80) ? 1 : 0;
        RNG0 = ((RNG0 << 1) | carry) & 0xFF;

        RNG0 += 0x4E + carry;
        carry = (RNG0 & 0x100) ? 1 : 0
        RNG0 = (RNG0 ^ 0x3A) & 0xFF;

        RNG1 = RNG0 ^ RNG1;
        RNG1 = (RNG1 + 0xC3 + carry) & 0xFF;
    }

    const seen = new Set();
    const results = []
    for (let i=0; i<0xFFFFF; ++i) {
        let rng = (RNG0 << 8) + RNG1;
        if (seen.has(rng)) break
        results.push([RNG0, RNG1]);
        //console.log(i + '\t' + RNG0 + '\t' + RNG1); // RNG0.toString(16).padStart(2, '0') + RNG1.toString(16).padStart(2, '0'));
        seen.add(rng);
        AdvanceRNG()
    }
    return results;
}


for (let i=0; i<0x100; ++i) {
    for (let j=0; j<0x100; ++j) {
        let result = scanRNG(i, j)
        console.log(i + "\t" + j + "\t" + result.length);
    }
}

