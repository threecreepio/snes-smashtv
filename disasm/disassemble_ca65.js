// this is a complete hack.. but.. yeah..

const fs = require('fs');

const romData = fs.readFileSync('./original.sfc');
const cdlData = fs.readFileSync('./original.cdl').slice(9);

const CdlNone = 0x00;
const CdlCode = 0x01;
const CdlData = 0x02;
const CdlJumpTarget = 0x04;
const CdlSubEntryPoint = 0x08;
const CdlIndexMode8 = 0x10;
const CdlMemoryMode8 = 0x20;
const CdlGsu = 0x40;
const CdlCx4 = 0x80;

const AddrMode = {
    Sig8:              0x00,
    Imm8:              0x01,
    Imm16:             0x02,
    ImmX:              0x03,
    ImmM:              0x04,
    Abs:               0x05,
    AbsIdxXInd:        0x06,
    AbsIdxX:           0x07,
    AbsIdxY:           0x08,
    AbsInd:            0x09,
    AbsIndLng:         0x0A,
    AbsLngIdxX:        0x0B,
    AbsLng:            0x0C,
    AbsJmp:            0x0D,
    AbsLngJmp:         0x0E,
    Acc:               0x0F,
    BlkMov:            0x10,
    DirIdxIndX:        0x11,
    DirIdxX:           0x12,
    DirIdxY:           0x13,
    DirIndIdxY:        0x14,
    DirIndLngIdxY:     0x15,
    DirIndLng:         0x16,
    DirInd:            0x17,
    Dir:               0x18,
    Imp:               0x19,
    RelLng:            0x1A,
    Rel:               0x1B,
    Stk:               0x1C,
    StkRel:            0x1D,
    StkRelIndIdxY:     0x1E
};

const OpSizes = [
    2, 2, 3, 0, 0, 3, 3, 3, 3, 3,
    3, 4, 4, 3, 4, 1, 3, 2, 2, 2,
    2, 2, 2, 2, 2, 1, 3, 2, 1, 2,
    2
];

const RequiredIndexMode = (addrMode, currentIndexMode) => {
    if (addrMode === AddrMode.ImmX) return currentIndexMode ? 8 : 16;
    if (addrMode === AddrMode.AbsLngIdxX) return 16;
    return null;
}

const RequiredMemoryMode = (addrMode, currentMemoryMode) => {
    if (addrMode === AddrMode.ImmM) return currentMemoryMode ? 8 : 16;
    if (addrMode === AddrMode.AbsLngIdxX) return 16;
    return null;
}

const GetOpSize = (addrMode, indexMode8, memoryMode8) => {
	if(addrMode == AddrMode.ImmX) {
		return indexMode8 ? 2 : 3;
	} else if(addrMode == AddrMode.ImmM) {
		return memoryMode8 ? 2 : 3;
	}
	return OpSizes[addrMode];
}

const OpMode = [
	AddrMode.Sig8,  AddrMode.DirIdxIndX, AddrMode.Sig8,     AddrMode.StkRel,        AddrMode.Dir,     AddrMode.Dir,     AddrMode.Dir,     AddrMode.DirIndLng,     AddrMode.Stk, AddrMode.ImmM,    AddrMode.Acc, AddrMode.Stk, AddrMode.Abs,        AddrMode.Abs,     AddrMode.Abs,     AddrMode.AbsLng,
	AddrMode.Rel,   AddrMode.DirIndIdxY, AddrMode.DirInd,   AddrMode.StkRelIndIdxY, AddrMode.Dir,     AddrMode.DirIdxX, AddrMode.DirIdxX, AddrMode.DirIndLngIdxY, AddrMode.Imp, AddrMode.AbsIdxY, AddrMode.Acc, AddrMode.Imp, AddrMode.Abs,        AddrMode.AbsIdxX, AddrMode.AbsIdxX, AddrMode.AbsLngIdxX,
	AddrMode.Abs,   AddrMode.DirIdxIndX, AddrMode.AbsLng,   AddrMode.StkRel,        AddrMode.Dir,     AddrMode.Dir,     AddrMode.Dir,     AddrMode.DirIndLng,     AddrMode.Stk, AddrMode.ImmM,    AddrMode.Acc, AddrMode.Stk, AddrMode.Abs,        AddrMode.Abs,     AddrMode.Abs,     AddrMode.AbsLng,
	AddrMode.Rel,   AddrMode.DirIndIdxY, AddrMode.DirInd,   AddrMode.StkRelIndIdxY, AddrMode.DirIdxX, AddrMode.DirIdxX, AddrMode.DirIdxX, AddrMode.DirIndLngIdxY, AddrMode.Imp, AddrMode.AbsIdxY, AddrMode.Acc, AddrMode.Imp, AddrMode.AbsIdxX,    AddrMode.AbsIdxX, AddrMode.AbsIdxX, AddrMode.AbsLngIdxX,
	AddrMode.Stk,   AddrMode.DirIdxIndX, AddrMode.Imm8,     AddrMode.StkRel,        AddrMode.BlkMov,  AddrMode.Dir,     AddrMode.Dir,     AddrMode.DirIndLng,     AddrMode.Stk, AddrMode.ImmM,    AddrMode.Acc, AddrMode.Stk, AddrMode.Abs,        AddrMode.Abs,     AddrMode.Abs,     AddrMode.AbsLng,
	AddrMode.Rel,   AddrMode.DirIndIdxY, AddrMode.DirInd,   AddrMode.StkRelIndIdxY, AddrMode.BlkMov,  AddrMode.DirIdxX, AddrMode.DirIdxX, AddrMode.DirIndLngIdxY, AddrMode.Imp, AddrMode.AbsIdxY, AddrMode.Stk, AddrMode.Imp, AddrMode.AbsLng,     AddrMode.AbsIdxX, AddrMode.AbsIdxX, AddrMode.AbsLngIdxX,
	AddrMode.Stk,   AddrMode.DirIdxIndX, AddrMode.RelLng,   AddrMode.StkRel,        AddrMode.Dir,     AddrMode.Dir,     AddrMode.Dir,     AddrMode.DirIndLng,     AddrMode.Stk, AddrMode.ImmM,    AddrMode.Acc, AddrMode.Stk, AddrMode.AbsInd,     AddrMode.Abs,     AddrMode.Abs,     AddrMode.AbsLng,
	AddrMode.Rel,   AddrMode.DirIndIdxY, AddrMode.DirInd,   AddrMode.StkRelIndIdxY, AddrMode.DirIdxX, AddrMode.DirIdxX, AddrMode.DirIdxX, AddrMode.DirIndLngIdxY, AddrMode.Imp, AddrMode.AbsIdxY, AddrMode.Stk, AddrMode.Imp, AddrMode.AbsIdxXInd, AddrMode.AbsIdxX, AddrMode.AbsIdxX, AddrMode.AbsLngIdxX,
	AddrMode.Rel,   AddrMode.DirIdxIndX, AddrMode.RelLng,   AddrMode.StkRel,        AddrMode.Dir,     AddrMode.Dir,     AddrMode.Dir,     AddrMode.DirIndLng,     AddrMode.Imp, AddrMode.ImmM,    AddrMode.Imp, AddrMode.Stk, AddrMode.Abs,        AddrMode.Abs,     AddrMode.Abs,     AddrMode.AbsLng,
	AddrMode.Rel,   AddrMode.DirIndIdxY, AddrMode.DirInd,   AddrMode.StkRelIndIdxY, AddrMode.DirIdxX, AddrMode.DirIdxX, AddrMode.DirIdxY, AddrMode.DirIndLngIdxY, AddrMode.Imp, AddrMode.AbsIdxY, AddrMode.Imp, AddrMode.Imp, AddrMode.Abs,        AddrMode.AbsIdxX, AddrMode.AbsIdxX, AddrMode.AbsLngIdxX,
	AddrMode.ImmX,  AddrMode.DirIdxIndX, AddrMode.ImmX,     AddrMode.StkRel,        AddrMode.Dir,     AddrMode.Dir,     AddrMode.Dir,     AddrMode.DirIndLng,     AddrMode.Imp, AddrMode.ImmM,    AddrMode.Imp, AddrMode.Stk, AddrMode.Abs,        AddrMode.Abs,     AddrMode.Abs,     AddrMode.AbsLng,
	AddrMode.Rel,   AddrMode.DirIndIdxY, AddrMode.DirInd,   AddrMode.StkRelIndIdxY, AddrMode.DirIdxX, AddrMode.DirIdxX, AddrMode.DirIdxY, AddrMode.DirIndLngIdxY, AddrMode.Imp, AddrMode.AbsIdxY, AddrMode.Imp, AddrMode.Imp, AddrMode.AbsIdxX,    AddrMode.AbsIdxX, AddrMode.AbsIdxY, AddrMode.AbsLngIdxX,
	AddrMode.ImmX,  AddrMode.DirIdxIndX, AddrMode.Imm8,     AddrMode.StkRel,        AddrMode.Dir,     AddrMode.Dir,     AddrMode.Dir,     AddrMode.DirIndLng,     AddrMode.Imp, AddrMode.ImmM,    AddrMode.Imp, AddrMode.Imp, AddrMode.Abs,        AddrMode.Abs,     AddrMode.Abs,     AddrMode.AbsLng,
	AddrMode.Rel,   AddrMode.DirIndIdxY, AddrMode.DirInd,   AddrMode.StkRelIndIdxY, AddrMode.Dir,     AddrMode.DirIdxX, AddrMode.DirIdxX, AddrMode.DirIndLngIdxY, AddrMode.Imp, AddrMode.AbsIdxY, AddrMode.Stk, AddrMode.Imp, AddrMode.AbsIndLng,  AddrMode.AbsIdxX, AddrMode.AbsIdxX, AddrMode.AbsLngIdxX,
	AddrMode.ImmX,  AddrMode.DirIdxIndX, AddrMode.Imm8,     AddrMode.StkRel,        AddrMode.Dir,     AddrMode.Dir,     AddrMode.Dir,     AddrMode.DirIndLng,     AddrMode.Imp, AddrMode.ImmM,    AddrMode.Imp, AddrMode.Imp, AddrMode.Abs,        AddrMode.Abs,     AddrMode.Abs,     AddrMode.AbsLng,
	AddrMode.Rel,   AddrMode.DirIndIdxY, AddrMode.DirInd,   AddrMode.StkRelIndIdxY, AddrMode.Abs,   AddrMode.DirIdxX, AddrMode.DirIdxX, AddrMode.DirIndLngIdxY, AddrMode.Imp, AddrMode.AbsIdxY, AddrMode.Stk, AddrMode.Imp, AddrMode.AbsIdxXInd, AddrMode.AbsIdxX, AddrMode.AbsIdxX, AddrMode.AbsLngIdxX
]

const OpName = [
	"BRK", "ORA", "COP", "ORA", "TSB", "ORA", "ASL", "ORA", "PHP", "ORA", "ASL", "PHD", "TSB", "ORA", "ASL", "ORA",
	"BPL", "ORA", "ORA", "ORA", "TRB", "ORA", "ASL", "ORA", "CLC", "ORA", "INC", "TCS", "TRB", "ORA", "ASL", "ORA",
	"JSR", "AND", "JSL", "AND", "BIT", "AND", "ROL", "AND", "PLP", "AND", "ROL", "PLD", "BIT", "AND", "ROL", "AND",
	"BMI", "AND", "AND", "AND", "BIT", "AND", "ROL", "AND", "SEC", "AND", "DEC", "TSC", "BIT", "AND", "ROL", "AND",
	"RTI", "EOR", "WDM", "EOR", "MVP", "EOR", "LSR", "EOR", "PHA", "EOR", "LSR", "PHK", "JMP", "EOR", "LSR", "EOR",
	"BVC", "EOR", "EOR", "EOR", "MVN", "EOR", "LSR", "EOR", "CLI", "EOR", "PHY", "TCD", "JMP", "EOR", "LSR", "EOR",
	"RTS", "ADC", "PER", "ADC", "STZ", "ADC", "ROR", "ADC", "PLA", "ADC", "ROR", "RTL", "JMP", "ADC", "ROR", "ADC",
	"BVS", "ADC", "ADC", "ADC", "STZ", "ADC", "ROR", "ADC", "SEI", "ADC", "PLY", "TDC", "JMP", "ADC", "ROR", "ADC",
	"BRA", "STA", "BRL", "STA", "STY", "STA", "STX", "STA", "DEY", "BIT", "TXA", "PHB", "STY", "STA", "STX", "STA",
	"BCC", "STA", "STA", "STA", "STY", "STA", "STX", "STA", "TYA", "STA", "TXS", "TXY", "STZ", "STA", "STZ", "STA",
	"LDY", "LDA", "LDX", "LDA", "LDY", "LDA", "LDX", "LDA", "TAY", "LDA", "TAX", "PLB", "LDY", "LDA", "LDX", "LDA",
	"BCS", "LDA", "LDA", "LDA", "LDY", "LDA", "LDX", "LDA", "CLV", "LDA", "TSX", "TYX", "LDY", "LDA", "LDX", "LDA",
	"CPY", "CMP", "REP", "CMP", "CPY", "CMP", "DEC", "CMP", "INY", "CMP", "DEX", "WAI", "CPY", "CMP", "DEC", "CMP",
	"BNE", "CMP", "CMP", "CMP", "PEI", "CMP", "DEC", "CMP", "CLD", "CMP", "PHX", "STP", "JML", "CMP", "DEC", "CMP",
	"CPX", "SBC", "SEP", "SBC", "CPX", "SBC", "INC", "SBC", "INX", "SBC", "NOP", "XBA", "CPX", "SBC", "INC", "SBC",
	"BEQ", "SBC", "SBC", "SBC", "PEA", "SBC", "INC", "SBC", "SED", "SBC", "PLX", "XCE", "JSR", "SBC", "INC", "SBC" 
];



let codes = [];
let placedLabels = {};
let labels = fs
    .readFileSync('./labels.txt')
    .toString('utf-8')
    .split(/\s*\r?\n\s*/)
    .filter(l => l && !/^;/.test(l))
    .map(l => {
        const [k, v] = l.split(/\s+/);
        return [parseInt(k, 16), v];
    })
    .reduce((ht, a) => { ht[a[0]] = a[1]; return ht; }, {});

let prevOrg = 0, bi = 0;
let currentData = null;
for (let i=0; i<romData.byteLength;) {
    const cdl = cdlData[i];
    const org = 0x8000 + (0x10000 * (i >> 15));
    const bank = org & 0xFFF0000;
    if (org !== prevOrg) {
        bi = 0;
        codes.push({ type: 'bank', bank: (0 + (i >> 15)) });
    }
    prevOrg = org;

    // handle data areas
    if (currentData && currentData.org !== org) {
        currentData = null;
    }
    if (!(cdl & CdlCode)) {
        if (!currentData) {
            currentData = { type: 'data', org: org, offset: bi, romOffset: i, length: 0 };
            codes.push(currentData);
        }
        currentData.length += 1;
        i += 1;
        bi += 1;
        continue;
    } else if (currentData) {
        currentData = null;
    }

    // handle code
    if (cdl & CdlCode) {
        const data = romData[i];
        const addrMode = OpMode[data];

        const indexMode8 = cdlData[i] & CdlIndexMode8;
        const memoryMode8 = cdlData[i] & CdlMemoryMode8;

        const opSize = GetOpSize(addrMode, indexMode8, memoryMode8);
        const operand = romData.slice(i + 1, i + opSize);

        if (OpName[data] === 'JSL') {
            const dest = operand.readUIntLE(0, 3);
            if (!labels[dest]) {
                labels[dest] = ('L_' + (dest).toString(16)).toUpperCase();
            }
        }

        if (OpName[data] === 'JSR') {
            const dest = operand.readUIntLE(0, 2);
            if (!labels[bank + dest]) {
                labels[bank + dest] = ('L_' + (bank + dest).toString(16)).toUpperCase();
            }
        }

        if (
            addrMode == AddrMode.AbsIdxX ||
            addrMode == AddrMode.AbsIdxY ||
            addrMode == AddrMode.AbsLng ||
            addrMode == AddrMode.AbsLngIdxX ||
            addrMode == AddrMode.Abs
        ) {
            const dest = operand.readUIntLE(0, operand.byteLength);
            if (operand.byteLength === 3) {
                if (!labels[dest] && dest >= 0x8000)
                    labels[dest] = ('D_' + (dest).toString(16)).toUpperCase();
            } else {
                if (!labels[bank + dest] && dest > 0x8000)
                    labels[bank + dest] = ('D_' + (bank + dest).toString(16)).toUpperCase();
            }
        }

        if ((addrMode == AddrMode.Rel)) {
            const dest = (2 + bi + operand.readInt8(0));
            if (!labels[org + dest])
                labels[org + dest] = ('B_' + (org + dest).toString(16)).toUpperCase();
        }

        if ((addrMode == AddrMode.RelLng)) {
            const dest = (2 + bi + operand.readInt16LE(0));
            if (!labels[org + dest])
                labels[org + dest] = ('B_' + (org + dest).toString(16)).toUpperCase();
        }

        codes.push({
            type: 'op',
            offset: bi,
            romOffset: i,
            org: org,
            id: romData[i],
            operand: romData.slice(i + 1, i + opSize),
            cdl: cdl,
            indexMode: RequiredIndexMode(addrMode, indexMode8),
            memoryMode: RequiredMemoryMode(addrMode, memoryMode8),
        });
        i += opSize;
        bi += opSize;
        continue;
    }

    throw new Error("unhandled cdl data: ", cdl.toString(16));
}

const PrintOp = (opCode, operand, offset, bank) => {
	const addrMode = OpMode[opCode];
    const out = OpName[opCode];
    
    const operandHexValue = '$' + (
        (operand.toString('hex')
        .padStart(operand.byteLength * 2, '0')
        .match(/../g) || []
    ).reverse().join('').toUpperCase());
        
    let operandValue = operandHexValue;
    let value = operand.byteLength ? operand.readUIntLE(0, operand.byteLength) : 0;
    let foundLabel = null;
    if (operand.byteLength === 3) foundLabel = labels[operand.readUIntLE(0, operand.byteLength)];
    else if (operand.byteLength && value >= 0x8000) foundLabel = labels[bank + operand.readUIntLE(0, operand.byteLength)];
    else foundLabel = labels[value];
    if (foundLabel) operandValue = foundLabel;
    
    switch (addrMode) {
		case AddrMode.Abs: return `${out} ${operandValue}`;
		case AddrMode.AbsJmp: return `${out} ${operandValue}`;
		case AddrMode.AbsIdxXInd: return `${out} (${operandValue},X)`;
		case AddrMode.AbsIdxX: return `${out} ${operandValue},X`;
		case AddrMode.AbsIdxY: return `${out} ${operandValue},Y`;
		case AddrMode.AbsInd:  return `${out} (${operandValue})`;
		case AddrMode.AbsIndLng:  return `${out} [${operandValue}]`;
		case AddrMode.AbsLngIdxX: return `${out} f:${operandValue},X`;
		case AddrMode.AbsLng: return `${out} f:${operandValue}`;
		case AddrMode.AbsLngJmp: return `${out} ${operandValue}`;
		case AddrMode.Acc: return out;
		case AddrMode.BlkMov: return `${out} $${operand.slice(0,1).toString('hex')},$${operand.slice(1,2).toString('hex')}`;
		case AddrMode.DirIdxIndX: return `${out} (${operandValue},X)`;
		case AddrMode.DirIdxX: return `${out} ${operandValue},X`;
		case AddrMode.DirIdxY: return `${out} ${operandValue},Y`;
		case AddrMode.DirIndIdxY: return `${out} (${operandValue}),Y`;
		case AddrMode.DirIndLngIdxY: return `${out} [${operandValue}],Y`;
		case AddrMode.DirIndLng: return `${out} [${operandValue}]`;
		case AddrMode.DirInd: return `${out} (${operandValue})`;
		case AddrMode.Dir: return `${out} ${operandValue}`; break;

        case AddrMode.ImmM:
        case AddrMode.ImmX:
            return `${out} #${operandHexValue}`;
    
		case AddrMode.Imm8:
        case AddrMode.Imm16:
            return `${out} #${operandHexValue}`;
        
		case AddrMode.Sig8: return `${out} #${operandHexValue}`;
		case AddrMode.Imp: return out;
		case AddrMode.Stk: return out;
		case AddrMode.StkRel: return `${out} ${operandValue},X`;
		case AddrMode.StkRelIndIdxY: return `${out} (${operandValue},S),Y`;

        case AddrMode.RelLng:
		case AddrMode.Rel:
            const dest = 0x8000 + bank + operand.readIntLE(0, operand.byteLength) + offset + 2;
            return `${out} ${labels[dest] || 'FAIL'}`;
		
		default: throw new Error("invalid address mode");
    }
}

const binaryData = data => `.byte ${data.map(c => '$' + c.toString(16).padStart(2, '0').toUpperCase()).join(',')}`

let output = [];
const banks = [];
let im = 16, mm = 16;
for (let code of codes) {
    const bank = code.org & 0xFFF0000;
    switch (code.type) {
        case 'bank':
            output = [];
            banks.push(output);
            im = mm = 16;
            break;

        case 'op':
            if (labels[code.org + code.offset]) {
                if (labels[code.org + code.offset][0] === 'L') {
                    output.push('');
                }
                placedLabels[code.org + code.offset] = true;
                output.push(labels[code.org + code.offset] + ':');
            }
            if (/^\?/.test(OpName[code.id])) {
                output.push('.byte $' + code.id.toString(16).padStart(2, '0').toUpperCase());
            } else {
                if (code.indexMode && code.indexMode !== im) {
                    output.push('.i' + code.indexMode);
                    im = code.indexMode;
                }
                if (code.memoryMode && code.memoryMode !== mm) {
                    output.push('.a' + code.memoryMode);
                    mm = code.memoryMode;
                }
                const op = PrintOp(code.id, code.operand, code.offset, bank);
                    output.push('  ' +
                        op.padEnd(48, ' ') + '; ' +
                        (code.org + code.offset).toString(16).padStart(6, '0').toUpperCase() + ' ' +
                        Array.from(romData.slice(code.romOffset, code.romOffset + code.operand.byteLength + 1)).map(x => x.toString(16).padStart(2, '0').toUpperCase()).join(' ') + ' '
                );
            }
            if (OpName[code.id] == 'RTS') output.push('');
            break;

        case 'data':
            output.push('');
            let bfr = [];
            let i = 0;

            const report = (bfr, loc) => {
                const str = bfr
                    .map(b => String.fromCharCode(b))
                    .join('')
                    .replace(/[^\x20-\x7E]/ig, '?');

                return (
                    binaryData(bfr).padEnd(50) + '; ' +
                    loc.toString(16).padStart(6, '0').toUpperCase() + ' ' +
                    str
                );
            }

            for (i=0; i<code.length; ++i) {
                if (labels[code.org + code.offset + i]) {
                    if (bfr.length) {
                        output.push(report(bfr, (i - bfr.length + 1) + code.org + code.offset));
                        bfr = [];
                    }
                    placedLabels[code.org + code.offset + i] = true;
                    output.push(labels[code.org + code.offset + i] + ':');
                }
                bfr.push(romData.readUInt8(code.romOffset + i));
                if (bfr.length >= 8) {
                    output.push(report(bfr, (i - bfr.length + 1) + code.org + code.offset));
                    bfr = [];
                }
            }
            if (bfr.length) {
                output.push(report(bfr, (i - bfr.length + 1) + code.org + code.offset));
            }
            output.push('');
            break;
    }
}

// print results
const entry = ['.include "../ca65.inc"'];
const extraLabels = [];
for (const label of Object.keys(labels)) {
    if (placedLabels[label]) continue;
    extraLabels.push(labels[label] + ' = $' + (Number(label).toString(16).toUpperCase()));
}
if (extraLabels.length) {
    entry.push('.include "inc.s"');
    fs.writeFileSync(__dirname + '/source/inc.s', extraLabels.join('\n'));
}
entry.push('');
for (let i=0; i<banks.length; ++i) {
    const name = `BANK_${i.toString(16).padStart(2, '0').toUpperCase()}.s`
    entry.push('.include "' + name + '"');
    entry.push('');
    banks[i].unshift(...[
        '.SETCPU "65816"',
        '.i16',
        '.a16',
        '.ORG $' + (0x8000 + (i * 0x10000)).toString(16).padStart(6, '0').toUpperCase()
    ]);
    fs.writeFileSync(__dirname + '/source/' + name, banks[i].join('\n'));
}
fs.writeFileSync(__dirname + '/source/entry.s', entry.join('\n'));

