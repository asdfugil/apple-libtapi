; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv32 -mattr=+v,+f,+zfh,+experimental-zvfh,+d -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc < %s -mtriple=riscv64 -mattr=+v,+f,+zfh,+experimental-zvfh,+d -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,RV64

define <2 x i8> @v2i8(<2 x i8> %a) {
; CHECK-LABEL: v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vslidedown.vi v9, v8, 1
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, tu, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v2i8 = shufflevector <2 x i8> %a, <2 x i8> undef, <2 x i32> <i32 1, i32 0>
  ret <2 x i8> %v2i8
}

define <4 x i8> @v2i8_2(<2 x i8> %a, <2 x i8> %b) {
; CHECK-LABEL: v2i8_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vslidedown.vi v10, v8, 1
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, tu, ma
; CHECK-NEXT:    vslideup.vi v10, v8, 1
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v9, 1
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v9, 1
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 2
; CHECK-NEXT:    ret
  %v4i8 = shufflevector <2 x i8> %a, <2 x i8> %b, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i8> %v4i8
}

define <4 x i8> @v4i8(<4 x i8> %a) {
; CHECK-LABEL: v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    vrsub.vi v10, v9, 3
; CHECK-NEXT:    vrgather.vv v9, v8, v10
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v4i8 = shufflevector <4 x i8> %a, <4 x i8> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i8> %v4i8
}

define <8 x i8> @v4i8_2(<4 x i8> %a, <4 x i8> %b) {
; CHECK-LABEL: v4i8_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vid.v v11
; CHECK-NEXT:    vrsub.vi v12, v11, 7
; CHECK-NEXT:    vrgather.vv v10, v8, v12
; CHECK-NEXT:    li a0, 15
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vrsub.vi v8, v11, 3
; CHECK-NEXT:    vrgather.vv v10, v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
  %v8i8 = shufflevector <4 x i8> %a, <4 x i8> %b, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <8 x i8> %v8i8
}

define <8 x i8> @v8i8(<8 x i8> %a) {
; CHECK-LABEL: v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    vrsub.vi v10, v9, 7
; CHECK-NEXT:    vrgather.vv v9, v8, v10
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v8i8 = shufflevector <8 x i8> %a, <8 x i8> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <8 x i8> %v8i8
}

define <16 x i8> @v8i8_2(<8 x i8> %a, <8 x i8> %b) {
; CHECK-LABEL: v8i8_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vid.v v11
; CHECK-NEXT:    vrsub.vi v12, v11, 15
; CHECK-NEXT:    vrgather.vv v10, v8, v12
; CHECK-NEXT:    li a0, 255
; CHECK-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, mu
; CHECK-NEXT:    vrsub.vi v8, v11, 7
; CHECK-NEXT:    vrgather.vv v10, v9, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v16i8 = shufflevector <8 x i8> %a, <8 x i8> %b, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <16 x i8> %v16i8
}

define <16 x i8> @v16i8(<16 x i8> %a) {
; CHECK-LABEL: v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    vrsub.vi v10, v9, 15
; CHECK-NEXT:    vrgather.vv v9, v8, v10
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v16i8 = shufflevector <16 x i8> %a, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <16 x i8> %v16i8
}

define <32 x i8> @v16i8_2(<16 x i8> %a, <16 x i8> %b) {
; RV32-LABEL: v16i8_2:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, %hi(.LCPI7_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI7_0)
; RV32-NEXT:    li a1, 32
; RV32-NEXT:    vsetvli zero, a1, e8, m2, ta, ma
; RV32-NEXT:    vle8.v v12, (a0)
; RV32-NEXT:    vmv1r.v v14, v9
; RV32-NEXT:    # kill: def $v8 killed $v8 def $v8m2
; RV32-NEXT:    vrgather.vv v10, v8, v12
; RV32-NEXT:    vid.v v8
; RV32-NEXT:    vrsub.vi v8, v8, 15
; RV32-NEXT:    lui a0, 16
; RV32-NEXT:    addi a0, a0, -1
; RV32-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV32-NEXT:    vmv.s.x v0, a0
; RV32-NEXT:    vsetvli zero, a1, e8, m2, ta, mu
; RV32-NEXT:    vrgather.vv v10, v14, v8, v0.t
; RV32-NEXT:    vmv.v.v v8, v10
; RV32-NEXT:    ret
;
; RV64-LABEL: v16i8_2:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a0, %hi(.LCPI7_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI7_0)
; RV64-NEXT:    li a1, 32
; RV64-NEXT:    vsetvli zero, a1, e8, m2, ta, ma
; RV64-NEXT:    vle8.v v12, (a0)
; RV64-NEXT:    vmv1r.v v14, v9
; RV64-NEXT:    # kill: def $v8 killed $v8 def $v8m2
; RV64-NEXT:    vrgather.vv v10, v8, v12
; RV64-NEXT:    vid.v v8
; RV64-NEXT:    vrsub.vi v8, v8, 15
; RV64-NEXT:    lui a0, 16
; RV64-NEXT:    addiw a0, a0, -1
; RV64-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV64-NEXT:    vmv.s.x v0, a0
; RV64-NEXT:    vsetvli zero, a1, e8, m2, ta, mu
; RV64-NEXT:    vrgather.vv v10, v14, v8, v0.t
; RV64-NEXT:    vmv.v.v v8, v10
; RV64-NEXT:    ret
  %v32i8 = shufflevector <16 x i8> %a, <16 x i8> %b,  <32 x i32> <i32 31, i32 30, i32 29, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 22, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <32 x i8> %v32i8
}

define <2 x i16> @v2i16(<2 x i16> %a) {
; CHECK-LABEL: v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v9, v8, 1
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, tu, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v2i16 = shufflevector <2 x i16> %a, <2 x i16> undef, <2 x i32> <i32 1, i32 0>
  ret <2 x i16> %v2i16
}

define <4 x i16> @v2i16_2(<2 x i16> %a, <2 x i16> %b) {
; CHECK-LABEL: v2i16_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v10, v8, 1
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, tu, ma
; CHECK-NEXT:    vslideup.vi v10, v8, 1
; CHECK-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v9, 1
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v9, 1
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 2
; CHECK-NEXT:    ret
  %v4i16 = shufflevector <2 x i16> %a, <2 x i16> %b, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i16> %v4i16
}

define <4 x i16> @v4i16(<4 x i16> %a) {
; CHECK-LABEL: v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    vrsub.vi v10, v9, 3
; CHECK-NEXT:    vrgather.vv v9, v8, v10
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v4i16 = shufflevector <4 x i16> %a, <4 x i16> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i16> %v4i16
}

define <8 x i16> @v4i16_2(<4 x i16> %a, <4 x i16> %b) {
; CHECK-LABEL: v4i16_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, mu
; CHECK-NEXT:    vid.v v11
; CHECK-NEXT:    vrsub.vi v12, v11, 7
; CHECK-NEXT:    vrgather.vv v10, v8, v12
; CHECK-NEXT:    li a0, 15
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vrsub.vi v8, v11, 3
; CHECK-NEXT:    vrgather.vv v10, v9, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v8i16 = shufflevector <4 x i16> %a, <4 x i16> %b, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <8 x i16> %v8i16
}

define <8 x i16> @v8i16(<8 x i16> %a) {
; CHECK-LABEL: v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    vrsub.vi v10, v9, 7
; CHECK-NEXT:    vrgather.vv v9, v8, v10
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v8i16 = shufflevector <8 x i16> %a, <8 x i16> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <8 x i16> %v8i16
}

define <16 x i16> @v8i16_2(<8 x i16> %a, <8 x i16> %b) {
; CHECK-LABEL: v8i16_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v12, v9
; CHECK-NEXT:    # kill: def $v8 killed $v8 def $v8m2
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, mu
; CHECK-NEXT:    vid.v v14
; CHECK-NEXT:    vrsub.vi v16, v14, 15
; CHECK-NEXT:    vrgather.vv v10, v8, v16
; CHECK-NEXT:    li a0, 255
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vrsub.vi v8, v14, 7
; CHECK-NEXT:    vrgather.vv v10, v12, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v16i16 = shufflevector <8 x i16> %a, <8 x i16> %b,  <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <16 x i16> %v16i16
}

define <16 x i16> @v16i16(<16 x i16> %a) {
; CHECK-LABEL: v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vid.v v10
; CHECK-NEXT:    vrsub.vi v12, v10, 15
; CHECK-NEXT:    vrgather.vv v10, v8, v12
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v16i16 = shufflevector <16 x i16> %a, <16 x i16> undef,  <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <16 x i16> %v16i16
}

define <32 x i16> @v16i16_2(<16 x i16> %a, <16 x i16> %b) {
; RV32-LABEL: v16i16_2:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, %hi(.LCPI15_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI15_0)
; RV32-NEXT:    li a1, 32
; RV32-NEXT:    vsetvli zero, a1, e16, m4, ta, ma
; RV32-NEXT:    vle16.v v16, (a0)
; RV32-NEXT:    vmv2r.v v20, v10
; RV32-NEXT:    # kill: def $v8m2 killed $v8m2 def $v8m4
; RV32-NEXT:    vrgather.vv v12, v8, v16
; RV32-NEXT:    vid.v v8
; RV32-NEXT:    vrsub.vi v8, v8, 15
; RV32-NEXT:    lui a0, 16
; RV32-NEXT:    addi a0, a0, -1
; RV32-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV32-NEXT:    vmv.s.x v0, a0
; RV32-NEXT:    vsetvli zero, a1, e16, m4, ta, mu
; RV32-NEXT:    vrgather.vv v12, v20, v8, v0.t
; RV32-NEXT:    vmv.v.v v8, v12
; RV32-NEXT:    ret
;
; RV64-LABEL: v16i16_2:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a0, %hi(.LCPI15_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI15_0)
; RV64-NEXT:    li a1, 32
; RV64-NEXT:    vsetvli zero, a1, e16, m4, ta, ma
; RV64-NEXT:    vle16.v v16, (a0)
; RV64-NEXT:    vmv2r.v v20, v10
; RV64-NEXT:    # kill: def $v8m2 killed $v8m2 def $v8m4
; RV64-NEXT:    vrgather.vv v12, v8, v16
; RV64-NEXT:    vid.v v8
; RV64-NEXT:    vrsub.vi v8, v8, 15
; RV64-NEXT:    lui a0, 16
; RV64-NEXT:    addiw a0, a0, -1
; RV64-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV64-NEXT:    vmv.s.x v0, a0
; RV64-NEXT:    vsetvli zero, a1, e16, m4, ta, mu
; RV64-NEXT:    vrgather.vv v12, v20, v8, v0.t
; RV64-NEXT:    vmv.v.v v8, v12
; RV64-NEXT:    ret
  %v32i16 = shufflevector <16 x i16> %a, <16 x i16> %b,  <32 x i32> <i32 31, i32 30, i32 29, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 22, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <32 x i16> %v32i16
}

define <2 x i32> @v2i32(<2 x i32> %a) {
; CHECK-LABEL: v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vi v9, v8, 1
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v2i32 = shufflevector <2 x i32> %a, <2 x i32> undef, <2 x i32> <i32 1, i32 0>
  ret <2 x i32> %v2i32
}

define <4 x i32> @v2i32_2(<2 x i32> %a, < 2 x i32> %b) {
; CHECK-LABEL: v2i32_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vi v10, v8, 1
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v10, v8, 1
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v9, 1
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v9, 1
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 2
; CHECK-NEXT:    ret
  %v4i32 = shufflevector <2 x i32> %a, <2 x i32> %b, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i32> %v4i32
}

define <4 x i32> @v4i32(<4 x i32> %a) {
; CHECK-LABEL: v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    vrsub.vi v10, v9, 3
; CHECK-NEXT:    vrgather.vv v9, v8, v10
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v4i32 = shufflevector <4 x i32> %a, <4 x i32> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i32> %v4i32
}

define <8 x i32> @v4i32_2(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: v4i32_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v12, v9
; CHECK-NEXT:    # kill: def $v8 killed $v8 def $v8m2
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, mu
; CHECK-NEXT:    vid.v v14
; CHECK-NEXT:    vrsub.vi v16, v14, 7
; CHECK-NEXT:    vrgather.vv v10, v8, v16
; CHECK-NEXT:    li a0, 15
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vrsub.vi v8, v14, 3
; CHECK-NEXT:    vrgather.vv v10, v12, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v8i32 = shufflevector <4 x i32> %a, <4 x i32> %b, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <8 x i32> %v8i32
}

define <8 x i32> @v8i32(<8 x i32> %a) {
; CHECK-LABEL: v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vid.v v10
; CHECK-NEXT:    vrsub.vi v12, v10, 7
; CHECK-NEXT:    vrgather.vv v10, v8, v12
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v8i32 = shufflevector <8 x i32> %a, <8 x i32> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <8 x i32> %v8i32
}

define <16 x i32> @v8i32_2(<8 x i32> %a, <8 x i32> %b) {
; CHECK-LABEL: v8i32_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv2r.v v16, v10
; CHECK-NEXT:    # kill: def $v8m2 killed $v8m2 def $v8m4
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, mu
; CHECK-NEXT:    vid.v v20
; CHECK-NEXT:    vrsub.vi v24, v20, 15
; CHECK-NEXT:    vrgather.vv v12, v8, v24
; CHECK-NEXT:    li a0, 255
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vrsub.vi v8, v20, 7
; CHECK-NEXT:    vrgather.vv v12, v16, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
  %v16i32 = shufflevector <8 x i32> %a, <8 x i32> %b,  <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <16 x i32> %v16i32
}

define <16 x i32> @v16i32(<16 x i32> %a) {
; CHECK-LABEL: v16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vid.v v12
; CHECK-NEXT:    vrsub.vi v16, v12, 15
; CHECK-NEXT:    vrgather.vv v12, v8, v16
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
  %v16i32 = shufflevector <16 x i32> %a, <16 x i32> undef,  <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <16 x i32> %v16i32
}

define <32 x i32> @v16i32_2(<16 x i32> %a, <16 x i32> %b) {
; RV32-LABEL: v16i32_2:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, %hi(.LCPI23_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI23_0)
; RV32-NEXT:    li a1, 32
; RV32-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; RV32-NEXT:    vle32.v v0, (a0)
; RV32-NEXT:    vmv4r.v v24, v12
; RV32-NEXT:    vmv4r.v v16, v8
; RV32-NEXT:    vrgather.vv v8, v16, v0
; RV32-NEXT:    vid.v v16
; RV32-NEXT:    vrsub.vi v16, v16, 15
; RV32-NEXT:    lui a0, 16
; RV32-NEXT:    addi a0, a0, -1
; RV32-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV32-NEXT:    vmv.s.x v0, a0
; RV32-NEXT:    vsetvli zero, a1, e32, m8, ta, mu
; RV32-NEXT:    vrgather.vv v8, v24, v16, v0.t
; RV32-NEXT:    ret
;
; RV64-LABEL: v16i32_2:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a0, %hi(.LCPI23_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI23_0)
; RV64-NEXT:    li a1, 32
; RV64-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; RV64-NEXT:    vle32.v v0, (a0)
; RV64-NEXT:    vmv4r.v v24, v12
; RV64-NEXT:    vmv4r.v v16, v8
; RV64-NEXT:    vrgather.vv v8, v16, v0
; RV64-NEXT:    vid.v v16
; RV64-NEXT:    vrsub.vi v16, v16, 15
; RV64-NEXT:    lui a0, 16
; RV64-NEXT:    addiw a0, a0, -1
; RV64-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; RV64-NEXT:    vmv.s.x v0, a0
; RV64-NEXT:    vsetvli zero, a1, e32, m8, ta, mu
; RV64-NEXT:    vrgather.vv v8, v24, v16, v0.t
; RV64-NEXT:    ret
  %v32i32 = shufflevector <16 x i32> %a, <16 x i32> %b,  <32 x i32> <i32 31, i32 30, i32 29, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 22, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <32 x i32> %v32i32
}

define <2 x i64> @v2i64(<2 x i64> %a) {
; CHECK-LABEL: v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v9, v8, 1
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, tu, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v2i64 = shufflevector <2 x i64> %a, <2 x i64> undef, <2 x i32> <i32 1, i32 0>
  ret <2 x i64> %v2i64
}

define <4 x i64> @v2i64_2(<2 x i64> %a, < 2 x i64> %b) {
; CHECK-LABEL: v2i64_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v12, v8, 1
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, tu, ma
; CHECK-NEXT:    vslideup.vi v12, v8, 1
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v10, v9, 1
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, tu, ma
; CHECK-NEXT:    vslideup.vi v10, v9, 1
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v10, v12, 2
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %v4i64 = shufflevector <2 x i64> %a, <2 x i64> %b, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i64> %v4i64
}

define <4 x i64> @v4i64(<4 x i64> %a) {
; RV32-LABEL: v4i64:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; RV32-NEXT:    vid.v v10
; RV32-NEXT:    vrsub.vi v12, v10, 3
; RV32-NEXT:    vsetvli zero, zero, e64, m2, ta, ma
; RV32-NEXT:    vrgatherei16.vv v10, v8, v12
; RV32-NEXT:    vmv.v.v v8, v10
; RV32-NEXT:    ret
;
; RV64-LABEL: v4i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV64-NEXT:    vid.v v10
; RV64-NEXT:    vrsub.vi v12, v10, 3
; RV64-NEXT:    vrgather.vv v10, v8, v12
; RV64-NEXT:    vmv.v.v v8, v10
; RV64-NEXT:    ret
  %v4i64 = shufflevector <4 x i64> %a, <4 x i64> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x i64> %v4i64
}

define <8 x i64> @v4i64_2(<4 x i64> %a, <4 x i64> %b) {
; RV32-LABEL: v4i64_2:
; RV32:       # %bb.0:
; RV32-NEXT:    vmv2r.v v16, v10
; RV32-NEXT:    # kill: def $v8m2 killed $v8m2 def $v8m4
; RV32-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; RV32-NEXT:    vid.v v20
; RV32-NEXT:    vrsub.vi v21, v20, 7
; RV32-NEXT:    vsetvli zero, zero, e64, m4, ta, ma
; RV32-NEXT:    vrgatherei16.vv v12, v8, v21
; RV32-NEXT:    li a0, 15
; RV32-NEXT:    vmv.s.x v0, a0
; RV32-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; RV32-NEXT:    vrsub.vi v8, v20, 3
; RV32-NEXT:    vsetvli zero, zero, e64, m4, ta, mu
; RV32-NEXT:    vrgatherei16.vv v12, v16, v8, v0.t
; RV32-NEXT:    vmv.v.v v8, v12
; RV32-NEXT:    ret
;
; RV64-LABEL: v4i64_2:
; RV64:       # %bb.0:
; RV64-NEXT:    vmv2r.v v16, v10
; RV64-NEXT:    # kill: def $v8m2 killed $v8m2 def $v8m4
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, mu
; RV64-NEXT:    vid.v v20
; RV64-NEXT:    vrsub.vi v24, v20, 7
; RV64-NEXT:    vrgather.vv v12, v8, v24
; RV64-NEXT:    li a0, 15
; RV64-NEXT:    vmv.s.x v0, a0
; RV64-NEXT:    vrsub.vi v8, v20, 3
; RV64-NEXT:    vrgather.vv v12, v16, v8, v0.t
; RV64-NEXT:    vmv.v.v v8, v12
; RV64-NEXT:    ret
  %v8i64 = shufflevector <4 x i64> %a, <4 x i64> %b, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <8 x i64> %v8i64
}

define <2 x half> @v2f16(<2 x half> %a) {
; CHECK-LABEL: v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v9, v8, 1
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, tu, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v2f16 = shufflevector <2 x half> %a, <2 x half> undef, <2 x i32> <i32 1, i32 0>
  ret <2 x half> %v2f16
}

define <4 x half> @v2f16_2(<2 x half> %a, <2 x half> %b) {
; CHECK-LABEL: v2f16_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v10, v8, 1
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, tu, ma
; CHECK-NEXT:    vslideup.vi v10, v8, 1
; CHECK-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v9, 1
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v9, 1
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 2
; CHECK-NEXT:    ret
  %v4f16 = shufflevector <2 x half> %a, <2 x half> %b, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x half> %v4f16
}

define <4 x half> @v4f16(<4 x half> %a) {
; CHECK-LABEL: v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    vrsub.vi v10, v9, 3
; CHECK-NEXT:    vrgather.vv v9, v8, v10
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v4f16 = shufflevector <4 x half> %a, <4 x half> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x half> %v4f16
}

define <8 x half> @v4f16_2(<4 x half> %a, <4 x half> %b) {
; CHECK-LABEL: v4f16_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, mu
; CHECK-NEXT:    vid.v v11
; CHECK-NEXT:    vrsub.vi v12, v11, 7
; CHECK-NEXT:    vrgather.vv v10, v8, v12
; CHECK-NEXT:    li a0, 15
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vrsub.vi v8, v11, 3
; CHECK-NEXT:    vrgather.vv v10, v9, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v8f16 = shufflevector <4 x half> %a, <4 x half> %b, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <8 x half> %v8f16
}

define <8 x half> @v8f16(<8 x half> %a) {
; CHECK-LABEL: v8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    vrsub.vi v10, v9, 7
; CHECK-NEXT:    vrgather.vv v9, v8, v10
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v8f16 = shufflevector <8 x half> %a, <8 x half> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <8 x half> %v8f16
}

define <16 x half> @v8f16_2(<8 x half> %a, <8 x half> %b) {
; CHECK-LABEL: v8f16_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v12, v9
; CHECK-NEXT:    # kill: def $v8 killed $v8 def $v8m2
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, mu
; CHECK-NEXT:    vid.v v14
; CHECK-NEXT:    vrsub.vi v16, v14, 15
; CHECK-NEXT:    vrgather.vv v10, v8, v16
; CHECK-NEXT:    li a0, 255
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vrsub.vi v8, v14, 7
; CHECK-NEXT:    vrgather.vv v10, v12, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v16f16 = shufflevector <8 x half> %a, <8 x half> %b,  <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <16 x half> %v16f16
}

define <16 x half> @v16f16(<16 x half> %a) {
; CHECK-LABEL: v16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vid.v v10
; CHECK-NEXT:    vrsub.vi v12, v10, 15
; CHECK-NEXT:    vrgather.vv v10, v8, v12
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v16f16 = shufflevector <16 x half> %a, <16 x half> undef,  <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <16 x half> %v16f16
}

define <32 x half> @v16f16_2(<16 x half> %a) {
; CHECK-LABEL: v16f16_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $v8m2 killed $v8m2 def $v8m4
; CHECK-NEXT:    lui a0, %hi(.LCPI35_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI35_0)
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:    vsetvli zero, a1, e16, m4, ta, ma
; CHECK-NEXT:    vle16.v v12, (a0)
; CHECK-NEXT:    vmv.v.i v16, 0
; CHECK-NEXT:    vsetivli zero, 16, e16, m4, tu, ma
; CHECK-NEXT:    vslideup.vi v16, v8, 0
; CHECK-NEXT:    vsetvli zero, a1, e16, m4, ta, ma
; CHECK-NEXT:    vrgather.vv v8, v16, v12
; CHECK-NEXT:    ret
  %v32f16 = shufflevector <16 x half> %a, <16 x half> undef,  <32 x i32> <i32 31, i32 30, i32 29, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 22, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <32 x half> %v32f16
}

define <2 x float> @v2f32(<2 x float> %a) {
; CHECK-LABEL: v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vi v9, v8, 1
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v2f32 = shufflevector <2 x float> %a, <2 x float> undef, <2 x i32> <i32 1, i32 0>
  ret <2 x float> %v2f32
}

define <4 x float> @v2f32_2(<2 x float> %a, <2 x float> %b) {
; CHECK-LABEL: v2f32_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vi v10, v8, 1
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v10, v8, 1
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v9, 1
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v9, 1
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 2
; CHECK-NEXT:    ret
  %v4f32 = shufflevector <2 x float> %a, <2 x float> %b, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x float> %v4f32
}

define <4 x float> @v4f32(<4 x float> %a) {
; CHECK-LABEL: v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    vrsub.vi v10, v9, 3
; CHECK-NEXT:    vrgather.vv v9, v8, v10
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v4f32 = shufflevector <4 x float> %a, <4 x float> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x float> %v4f32
}

define <8 x float> @v4f32_2(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: v4f32_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v12, v9
; CHECK-NEXT:    # kill: def $v8 killed $v8 def $v8m2
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, mu
; CHECK-NEXT:    vid.v v14
; CHECK-NEXT:    vrsub.vi v16, v14, 7
; CHECK-NEXT:    vrgather.vv v10, v8, v16
; CHECK-NEXT:    li a0, 15
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vrsub.vi v8, v14, 3
; CHECK-NEXT:    vrgather.vv v10, v12, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v8f32 = shufflevector <4 x float> %a, <4 x float> %b, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <8 x float> %v8f32
}

define <8 x float> @v8f32(<8 x float> %a) {
; CHECK-LABEL: v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vid.v v10
; CHECK-NEXT:    vrsub.vi v12, v10, 7
; CHECK-NEXT:    vrgather.vv v10, v8, v12
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v8f32 = shufflevector <8 x float> %a, <8 x float> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <8 x float> %v8f32
}

define <16 x float> @v8f32_2(<8 x float> %a, <8 x float> %b) {
; CHECK-LABEL: v8f32_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv2r.v v16, v10
; CHECK-NEXT:    # kill: def $v8m2 killed $v8m2 def $v8m4
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, mu
; CHECK-NEXT:    vid.v v20
; CHECK-NEXT:    vrsub.vi v24, v20, 15
; CHECK-NEXT:    vrgather.vv v12, v8, v24
; CHECK-NEXT:    li a0, 255
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vrsub.vi v8, v20, 7
; CHECK-NEXT:    vrgather.vv v12, v16, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
  %v16f32 = shufflevector <8 x float> %a, <8 x float> %b, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <16 x float> %v16f32
}

define <2 x double> @v2f64(<2 x double> %a) {
; CHECK-LABEL: v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v9, v8, 1
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, tu, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v2f64 = shufflevector <2 x double> %a, <2 x double> undef, <2 x i32> <i32 1, i32 0>
  ret <2 x double> %v2f64
}

define <4 x double> @v2f64_2(<2 x double> %a, < 2 x double> %b) {
; CHECK-LABEL: v2f64_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v12, v8, 1
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, tu, ma
; CHECK-NEXT:    vslideup.vi v12, v8, 1
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v10, v9, 1
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, tu, ma
; CHECK-NEXT:    vslideup.vi v10, v9, 1
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v10, v12, 2
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %v4f64 = shufflevector <2 x double> %a, <2 x double> %b, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x double> %v4f64
}

define <4 x double> @v4f64(<4 x double> %a) {
; RV32-LABEL: v4f64:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; RV32-NEXT:    vid.v v10
; RV32-NEXT:    vrsub.vi v12, v10, 3
; RV32-NEXT:    vsetvli zero, zero, e64, m2, ta, ma
; RV32-NEXT:    vrgatherei16.vv v10, v8, v12
; RV32-NEXT:    vmv.v.v v8, v10
; RV32-NEXT:    ret
;
; RV64-LABEL: v4f64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV64-NEXT:    vid.v v10
; RV64-NEXT:    vrsub.vi v12, v10, 3
; RV64-NEXT:    vrgather.vv v10, v8, v12
; RV64-NEXT:    vmv.v.v v8, v10
; RV64-NEXT:    ret
  %v4f64 = shufflevector <4 x double> %a, <4 x double> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  ret <4 x double> %v4f64
}

define <8 x double> @v4f64_2(<4 x double> %a, <4 x double> %b) {
; RV32-LABEL: v4f64_2:
; RV32:       # %bb.0:
; RV32-NEXT:    vmv2r.v v16, v10
; RV32-NEXT:    # kill: def $v8m2 killed $v8m2 def $v8m4
; RV32-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; RV32-NEXT:    vid.v v20
; RV32-NEXT:    vrsub.vi v21, v20, 7
; RV32-NEXT:    vsetvli zero, zero, e64, m4, ta, ma
; RV32-NEXT:    vrgatherei16.vv v12, v8, v21
; RV32-NEXT:    li a0, 15
; RV32-NEXT:    vmv.s.x v0, a0
; RV32-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; RV32-NEXT:    vrsub.vi v8, v20, 3
; RV32-NEXT:    vsetvli zero, zero, e64, m4, ta, mu
; RV32-NEXT:    vrgatherei16.vv v12, v16, v8, v0.t
; RV32-NEXT:    vmv.v.v v8, v12
; RV32-NEXT:    ret
;
; RV64-LABEL: v4f64_2:
; RV64:       # %bb.0:
; RV64-NEXT:    vmv2r.v v16, v10
; RV64-NEXT:    # kill: def $v8m2 killed $v8m2 def $v8m4
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, mu
; RV64-NEXT:    vid.v v20
; RV64-NEXT:    vrsub.vi v24, v20, 7
; RV64-NEXT:    vrgather.vv v12, v8, v24
; RV64-NEXT:    li a0, 15
; RV64-NEXT:    vmv.s.x v0, a0
; RV64-NEXT:    vrsub.vi v8, v20, 3
; RV64-NEXT:    vrgather.vv v12, v16, v8, v0.t
; RV64-NEXT:    vmv.v.v v8, v12
; RV64-NEXT:    ret
  %v8f64 = shufflevector <4 x double> %a, <4 x double> %b, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <8 x double> %v8f64
}

define <32 x i8> @v32i8(<32 x i8> %a) {
; CHECK-LABEL: v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI46_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI46_0)
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:    vsetvli zero, a1, e8, m2, ta, ma
; CHECK-NEXT:    vle8.v v12, (a0)
; CHECK-NEXT:    vrgather.vv v10, v8, v12
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v32i8 = shufflevector <32 x i8> %a, <32 x i8> undef, <32 x i32> <i32 31, i32 30, i32 29, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 22, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <32 x i8> %v32i8
}

