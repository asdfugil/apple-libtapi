// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:        | llvm-objdump -d --mattr=+sve - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:   | llvm-objdump -d --mattr=-sve - | FileCheck %s --check-prefix=CHECK-UNKNOWN

ld1w     z0.s, p0/z, [x0]
// CHECK-INST: ld1w     { z0.s }, p0/z, [x0]
// CHECK-ENCODING: [0x00,0xa0,0x40,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a540a000 <unknown>

ld1w     z0.d, p0/z, [x0]
// CHECK-INST: ld1w     { z0.d }, p0/z, [x0]
// CHECK-ENCODING: [0x00,0xa0,0x60,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a560a000 <unknown>

ld1w    { z0.s }, p0/z, [x0]
// CHECK-INST: ld1w    { z0.s }, p0/z, [x0]
// CHECK-ENCODING: [0x00,0xa0,0x40,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a540a000 <unknown>

ld1w    { z0.d }, p0/z, [x0]
// CHECK-INST: ld1w    { z0.d }, p0/z, [x0]
// CHECK-ENCODING: [0x00,0xa0,0x60,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a560a000 <unknown>

ld1w    { z31.s }, p7/z, [sp, #-1, mul vl]
// CHECK-INST: ld1w    { z31.s }, p7/z, [sp, #-1, mul vl]
// CHECK-ENCODING: [0xff,0xbf,0x4f,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a54fbfff <unknown>

ld1w    { z21.s }, p5/z, [x10, #5, mul vl]
// CHECK-INST: ld1w    { z21.s }, p5/z, [x10, #5, mul vl]
// CHECK-ENCODING: [0x55,0xb5,0x45,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a545b555 <unknown>

ld1w    { z31.d }, p7/z, [sp, #-1, mul vl]
// CHECK-INST: ld1w    { z31.d }, p7/z, [sp, #-1, mul vl]
// CHECK-ENCODING: [0xff,0xbf,0x6f,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a56fbfff <unknown>

ld1w    { z21.d }, p5/z, [x10, #5, mul vl]
// CHECK-INST: ld1w    { z21.d }, p5/z, [x10, #5, mul vl]
// CHECK-ENCODING: [0x55,0xb5,0x65,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a565b555 <unknown>

ld1w    { z21.s }, p5/z, [sp, x21, lsl #2]
// CHECK-INST: ld1w    { z21.s }, p5/z, [sp, x21, lsl #2]
// CHECK-ENCODING: [0xf5,0x57,0x55,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a55557f5 <unknown>

ld1w    { z21.s }, p5/z, [x10, x21, lsl #2]
// CHECK-INST: ld1w    { z21.s }, p5/z, [x10, x21, lsl #2]
// CHECK-ENCODING: [0x55,0x55,0x55,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a5555555 <unknown>

ld1w    { z23.d }, p3/z, [x13, x8, lsl #2]
// CHECK-INST: ld1w    { z23.d }, p3/z, [x13, x8, lsl #2]
// CHECK-ENCODING: [0xb7,0x4d,0x68,0xa5]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: a5684db7 <unknown>
