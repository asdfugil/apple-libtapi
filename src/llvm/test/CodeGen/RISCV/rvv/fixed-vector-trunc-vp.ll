; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v,+m -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+v,+m -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s

declare <2 x i7> @llvm.vp.trunc.v2i7.v2i16(<2 x i16>, <2 x i1>, i32)

define <2 x i7> @vtrunc_v2i7_v2i16(<2 x i16> %a, <2 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v2i7_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x i7> @llvm.vp.trunc.v2i7.v2i16(<2 x i16> %a, <2 x i1> %m, i32 %vl)
  ret <2 x i7> %v
}

declare <2 x i8> @llvm.vp.trunc.v2i8.v2i15(<2 x i15>, <2 x i1>, i32)

define <2 x i8> @vtrunc_v2i8_v2i15(<2 x i15> %a, <2 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v2i8_v2i15:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x i8> @llvm.vp.trunc.v2i8.v2i15(<2 x i15> %a, <2 x i1> %m, i32 %vl)
  ret <2 x i8> %v
}

declare <2 x i8> @llvm.vp.trunc.v2i8.v2i16(<2 x i16>, <2 x i1>, i32)

define <2 x i8> @vtrunc_v2i8_v2i16(<2 x i16> %a, <2 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v2i8_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x i8> @llvm.vp.trunc.v2i8.v2i16(<2 x i16> %a, <2 x i1> %m, i32 %vl)
  ret <2 x i8> %v
}

define <2 x i8> @vtrunc_v2i8_v2i16_unmasked(<2 x i16> %a, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v2i8_v2i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    ret
  %v = call <2 x i8> @llvm.vp.trunc.v2i8.v2i16(<2 x i16> %a, <2 x i1> <i1 true, i1 true>, i32 %vl)
  ret <2 x i8> %v
}

declare <128 x i7> @llvm.vp.trunc.v128i7.v128i16(<128 x i16>, <128 x i1>, i32)

define <128 x i7> @vtrunc_v128i7_v128i16(<128 x i16> %a, <128 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v128i7_v128i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    vmv1r.v v24, v0
; CHECK-NEXT:    addi a1, sp, 16
; CHECK-NEXT:    vs8r.v v8, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    vsetivli zero, 8, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v0, v0, 8
; CHECK-NEXT:    addi a1, a0, -64
; CHECK-NEXT:    sltu a2, a0, a1
; CHECK-NEXT:    addi a2, a2, -1
; CHECK-NEXT:    and a1, a2, a1
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, ta, ma
; CHECK-NEXT:    li a1, 64
; CHECK-NEXT:    vnsrl.wi v8, v16, 0, v0.t
; CHECK-NEXT:    bltu a0, a1, .LBB4_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a0, 64
; CHECK-NEXT:  .LBB4_2:
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8re8.v v24, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vnsrl.wi v16, v24, 0, v0.t
; CHECK-NEXT:    li a0, 128
; CHECK-NEXT:    vsetvli zero, a0, e8, m8, tu, ma
; CHECK-NEXT:    vslideup.vx v16, v8, a1
; CHECK-NEXT:    vmv8r.v v8, v16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = call <128 x i7> @llvm.vp.trunc.v128i7.v128i16(<128 x i16> %a, <128 x i1> %m, i32 %vl)
  ret <128 x i7> %v
}

declare <2 x i8> @llvm.vp.trunc.v2i8.v2i32(<2 x i32>, <2 x i1>, i32)

define <2 x i8> @vtrunc_v2i8_v2i32(<2 x i32> %a, <2 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v2i8_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x i8> @llvm.vp.trunc.v2i8.v2i32(<2 x i32> %a, <2 x i1> %m, i32 %vl)
  ret <2 x i8> %v
}

define <2 x i8> @vtrunc_v2i8_v2i32_unmasked(<2 x i32> %a, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v2i8_v2i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    ret
  %v = call <2 x i8> @llvm.vp.trunc.v2i8.v2i32(<2 x i32> %a, <2 x i1> <i1 true, i1 true>, i32 %vl)
  ret <2 x i8> %v
}

declare <2 x i8> @llvm.vp.trunc.v2i8.v2i64(<2 x i64>, <2 x i1>, i32)

define <2 x i8> @vtrunc_v2i8_v2i64(<2 x i64> %a, <2 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v2i8_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x i8> @llvm.vp.trunc.v2i8.v2i64(<2 x i64> %a, <2 x i1> %m, i32 %vl)
  ret <2 x i8> %v
}

define <2 x i8> @vtrunc_v2i8_v2i64_unmasked(<2 x i64> %a, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v2i8_v2i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    ret
  %v = call <2 x i8> @llvm.vp.trunc.v2i8.v2i64(<2 x i64> %a, <2 x i1> <i1 true, i1 true>, i32 %vl)
  ret <2 x i8> %v
}

declare <2 x i16> @llvm.vp.trunc.v2i16.v2i32(<2 x i32>, <2 x i1>, i32)

define <2 x i16> @vtrunc_v2i16_v2i32(<2 x i32> %a, <2 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v2i16_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x i16> @llvm.vp.trunc.v2i16.v2i32(<2 x i32> %a, <2 x i1> %m, i32 %vl)
  ret <2 x i16> %v
}

define <2 x i16> @vtrunc_v2i16_v2i32_unmasked(<2 x i32> %a, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v2i16_v2i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    ret
  %v = call <2 x i16> @llvm.vp.trunc.v2i16.v2i32(<2 x i32> %a, <2 x i1> <i1 true, i1 true>, i32 %vl)
  ret <2 x i16> %v
}

declare <2 x i16> @llvm.vp.trunc.v2i16.v2i64(<2 x i64>, <2 x i1>, i32)

define <2 x i16> @vtrunc_v2i16_v2i64(<2 x i64> %a, <2 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v2i16_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x i16> @llvm.vp.trunc.v2i16.v2i64(<2 x i64> %a, <2 x i1> %m, i32 %vl)
  ret <2 x i16> %v
}

define <2 x i16> @vtrunc_v2i16_v2i64_unmasked(<2 x i64> %a, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v2i16_v2i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    ret
  %v = call <2 x i16> @llvm.vp.trunc.v2i16.v2i64(<2 x i64> %a, <2 x i1> <i1 true, i1 true>, i32 %vl)
  ret <2 x i16> %v
}

declare <15 x i16> @llvm.vp.trunc.v15i16.v15i64(<15 x i64>, <15 x i1>, i32)

define <15 x i16> @vtrunc_v15i16_v15i64(<15 x i64> %a, <15 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v15i16_v15i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vnsrl.wi v16, v8, 0, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v16, 0, v0.t
; CHECK-NEXT:    ret
  %v = call <15 x i16> @llvm.vp.trunc.v15i16.v15i64(<15 x i64> %a, <15 x i1> %m, i32 %vl)
  ret <15 x i16> %v
}

declare <2 x i32> @llvm.vp.trunc.v2i32.v2i64(<2 x i64>, <2 x i1>, i32)

define <2 x i32> @vtrunc_v2i32_v2i64(<2 x i64> %a, <2 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v2i32_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0, v0.t
; CHECK-NEXT:    ret
  %v = call <2 x i32> @llvm.vp.trunc.v2i32.v2i64(<2 x i64> %a, <2 x i1> %m, i32 %vl)
  ret <2 x i32> %v
}

define <2 x i32> @vtrunc_v2i32_v2i64_unmasked(<2 x i64> %a, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v2i32_v2i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    ret
  %v = call <2 x i32> @llvm.vp.trunc.v2i32.v2i64(<2 x i64> %a, <2 x i1> <i1 true, i1 true>, i32 %vl)
  ret <2 x i32> %v
}

declare <128 x i32> @llvm.vp.trunc.v128i32.v128i64(<128 x i64>, <128 x i1>, i32)

define <128 x i32> @vtrunc_v128i32_v128i64(<128 x i64> %a, <128 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v128i32_v128i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    li a3, 56
; CHECK-NEXT:    mul a2, a2, a3
; CHECK-NEXT:    sub sp, sp, a2
; CHECK-NEXT:    vmv1r.v v1, v0
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    li a3, 24
; CHECK-NEXT:    mul a2, a2, a3
; CHECK-NEXT:    add a2, sp, a2
; CHECK-NEXT:    addi a2, a2, 16
; CHECK-NEXT:    vs8r.v v16, (a2) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    slli a2, a2, 5
; CHECK-NEXT:    add a2, sp, a2
; CHECK-NEXT:    addi a2, a2, 16
; CHECK-NEXT:    vs8r.v v8, (a2) # Unknown-size Folded Spill
; CHECK-NEXT:    vsetivli zero, 8, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v3, v0, 8
; CHECK-NEXT:    vsetivli zero, 4, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vi v2, v0, 4
; CHECK-NEXT:    vslidedown.vi v27, v3, 4
; CHECK-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v0, v27, 2
; CHECK-NEXT:    addi a2, a1, 512
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    addi a3, a1, 640
; CHECK-NEXT:    vle64.v v8, (a3)
; CHECK-NEXT:    addi a3, a7, -64
; CHECK-NEXT:    sltu a4, a7, a3
; CHECK-NEXT:    addi a4, a4, -1
; CHECK-NEXT:    and a4, a4, a3
; CHECK-NEXT:    addi a3, a4, -32
; CHECK-NEXT:    sltu a5, a4, a3
; CHECK-NEXT:    addi a5, a5, -1
; CHECK-NEXT:    and a3, a5, a3
; CHECK-NEXT:    addi a5, a3, -16
; CHECK-NEXT:    sltu a6, a3, a5
; CHECK-NEXT:    addi a6, a6, -1
; CHECK-NEXT:    and a5, a6, a5
; CHECK-NEXT:    vle64.v v16, (a2)
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    li a6, 40
; CHECK-NEXT:    mul a2, a2, a6
; CHECK-NEXT:    add a2, sp, a2
; CHECK-NEXT:    addi a2, a2, 16
; CHECK-NEXT:    vs8r.v v16, (a2) # Unknown-size Folded Spill
; CHECK-NEXT:    vsetvli zero, a5, e32, m4, ta, ma
; CHECK-NEXT:    vnsrl.wi v16, v8, 0, v0.t
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    slli a2, a2, 4
; CHECK-NEXT:    add a2, sp, a2
; CHECK-NEXT:    addi a2, a2, 16
; CHECK-NEXT:    vs8r.v v16, (a2) # Unknown-size Folded Spill
; CHECK-NEXT:    li a2, 16
; CHECK-NEXT:    addi a5, a1, 128
; CHECK-NEXT:    bltu a3, a2, .LBB16_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a3, 16
; CHECK-NEXT:  .LBB16_2:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v4, v2, 2
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vle64.v v8, (a5)
; CHECK-NEXT:    vsetvli zero, a3, e32, m4, ta, ma
; CHECK-NEXT:    li a3, 64
; CHECK-NEXT:    vmv1r.v v0, v27
; CHECK-NEXT:    csrr a5, vlenb
; CHECK-NEXT:    li a6, 40
; CHECK-NEXT:    mul a5, a5, a6
; CHECK-NEXT:    add a5, sp, a5
; CHECK-NEXT:    addi a5, a5, 16
; CHECK-NEXT:    vl8re8.v v16, (a5) # Unknown-size Folded Reload
; CHECK-NEXT:    vnsrl.wi v24, v16, 0, v0.t
; CHECK-NEXT:    csrr a5, vlenb
; CHECK-NEXT:    li a6, 48
; CHECK-NEXT:    mul a5, a5, a6
; CHECK-NEXT:    add a5, sp, a5
; CHECK-NEXT:    addi a5, a5, 16
; CHECK-NEXT:    vs8r.v v24, (a5) # Unknown-size Folded Spill
; CHECK-NEXT:    bltu a7, a3, .LBB16_4
; CHECK-NEXT:  # %bb.3:
; CHECK-NEXT:    li a7, 64
; CHECK-NEXT:  .LBB16_4:
; CHECK-NEXT:    li a3, 32
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vle64.v v16, (a1)
; CHECK-NEXT:    addi a5, a7, -32
; CHECK-NEXT:    sltu a6, a7, a5
; CHECK-NEXT:    addi a6, a6, -1
; CHECK-NEXT:    and a5, a6, a5
; CHECK-NEXT:    addi a6, a5, -16
; CHECK-NEXT:    sltu t0, a5, a6
; CHECK-NEXT:    addi t0, t0, -1
; CHECK-NEXT:    and a6, t0, a6
; CHECK-NEXT:    vsetvli zero, a6, e32, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v4
; CHECK-NEXT:    vnsrl.wi v24, v8, 0, v0.t
; CHECK-NEXT:    csrr a6, vlenb
; CHECK-NEXT:    slli a6, a6, 3
; CHECK-NEXT:    add a6, sp, a6
; CHECK-NEXT:    addi a6, a6, 16
; CHECK-NEXT:    vs8r.v v24, (a6) # Unknown-size Folded Spill
; CHECK-NEXT:    bltu a5, a2, .LBB16_6
; CHECK-NEXT:  # %bb.5:
; CHECK-NEXT:    li a5, 16
; CHECK-NEXT:  .LBB16_6:
; CHECK-NEXT:    addi a6, a1, 384
; CHECK-NEXT:    addi a1, a1, 256
; CHECK-NEXT:    vsetvli zero, a5, e32, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v2
; CHECK-NEXT:    vnsrl.wi v8, v16, 0, v0.t
; CHECK-NEXT:    csrr a5, vlenb
; CHECK-NEXT:    li t0, 40
; CHECK-NEXT:    mul a5, a5, t0
; CHECK-NEXT:    add a5, sp, a5
; CHECK-NEXT:    addi a5, a5, 16
; CHECK-NEXT:    vs8r.v v8, (a5) # Unknown-size Folded Spill
; CHECK-NEXT:    bltu a4, a3, .LBB16_8
; CHECK-NEXT:  # %bb.7:
; CHECK-NEXT:    li a4, 32
; CHECK-NEXT:  .LBB16_8:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v4, v3, 2
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vle64.v v16, (a6)
; CHECK-NEXT:    vle64.v v24, (a1)
; CHECK-NEXT:    mv a1, a4
; CHECK-NEXT:    bltu a4, a2, .LBB16_10
; CHECK-NEXT:  # %bb.9:
; CHECK-NEXT:    li a1, 16
; CHECK-NEXT:  .LBB16_10:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v2, v1, 2
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v3
; CHECK-NEXT:    vnsrl.wi v8, v24, 0, v0.t
; CHECK-NEXT:    addi a1, a4, -16
; CHECK-NEXT:    sltu a4, a4, a1
; CHECK-NEXT:    addi a4, a4, -1
; CHECK-NEXT:    and a1, a4, a1
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v4
; CHECK-NEXT:    vnsrl.wi v24, v16, 0, v0.t
; CHECK-NEXT:    addi a1, sp, 16
; CHECK-NEXT:    vs8r.v v24, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    bltu a7, a3, .LBB16_12
; CHECK-NEXT:  # %bb.11:
; CHECK-NEXT:    li a7, 32
; CHECK-NEXT:  .LBB16_12:
; CHECK-NEXT:    vsetvli zero, a3, e32, m8, tu, ma
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    li a4, 48
; CHECK-NEXT:    mul a1, a1, a4
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vl8re8.v v16, (a1) # Unknown-size Folded Reload
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 4
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vl8re8.v v24, (a1) # Unknown-size Folded Reload
; CHECK-NEXT:    vslideup.vi v16, v24, 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    li a4, 48
; CHECK-NEXT:    mul a1, a1, a4
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vs8r.v v16, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    li a4, 40
; CHECK-NEXT:    mul a1, a1, a4
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vl8re8.v v16, (a1) # Unknown-size Folded Reload
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vl8re8.v v24, (a1) # Unknown-size Folded Reload
; CHECK-NEXT:    vslideup.vi v16, v24, 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    li a4, 40
; CHECK-NEXT:    mul a1, a1, a4
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vs8r.v v16, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    addi a1, sp, 16
; CHECK-NEXT:    vl8re8.v v16, (a1) # Unknown-size Folded Reload
; CHECK-NEXT:    vslideup.vi v8, v16, 16
; CHECK-NEXT:    addi a1, a7, -16
; CHECK-NEXT:    sltu a4, a7, a1
; CHECK-NEXT:    addi a4, a4, -1
; CHECK-NEXT:    and a1, a4, a1
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v2
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    li a4, 24
; CHECK-NEXT:    mul a1, a1, a4
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vl8re8.v v16, (a1) # Unknown-size Folded Reload
; CHECK-NEXT:    vnsrl.wi v24, v16, 0, v0.t
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 4
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vs8r.v v24, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    bltu a7, a2, .LBB16_14
; CHECK-NEXT:  # %bb.13:
; CHECK-NEXT:    li a7, 16
; CHECK-NEXT:  .LBB16_14:
; CHECK-NEXT:    vsetvli zero, a7, e32, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v1
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 5
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vl8re8.v v16, (a1) # Unknown-size Folded Reload
; CHECK-NEXT:    vnsrl.wi v24, v16, 0, v0.t
; CHECK-NEXT:    vsetvli zero, a3, e32, m8, tu, ma
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 4
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vl8re8.v v16, (a1) # Unknown-size Folded Reload
; CHECK-NEXT:    vslideup.vi v24, v16, 16
; CHECK-NEXT:    vse32.v v24, (a0)
; CHECK-NEXT:    addi a1, a0, 256
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    addi a1, a0, 128
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    li a3, 40
; CHECK-NEXT:    mul a2, a2, a3
; CHECK-NEXT:    add a2, sp, a2
; CHECK-NEXT:    addi a2, a2, 16
; CHECK-NEXT:    vl8re8.v v8, (a2) # Unknown-size Folded Reload
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    addi a0, a0, 384
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    li a2, 48
; CHECK-NEXT:    mul a1, a1, a2
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vl8re8.v v8, (a1) # Unknown-size Folded Reload
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 56
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = call <128 x i32> @llvm.vp.trunc.v128i32.v128i64(<128 x i64> %a, <128 x i1> %m, i32 %vl)
  ret <128 x i32> %v
}

declare <32 x i32> @llvm.vp.trunc.v32i32.v32i64(<32 x i64>, <32 x i1>, i32)

define <32 x i32> @vtrunc_v32i32_v32i64(<32 x i64> %a, <32 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vtrunc_v32i32_v32i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    vmv1r.v v24, v0
; CHECK-NEXT:    addi a1, sp, 16
; CHECK-NEXT:    vs8r.v v8, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v0, v0, 2
; CHECK-NEXT:    addi a1, a0, -16
; CHECK-NEXT:    sltu a2, a0, a1
; CHECK-NEXT:    addi a2, a2, -1
; CHECK-NEXT:    and a1, a2, a1
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, ta, ma
; CHECK-NEXT:    li a1, 16
; CHECK-NEXT:    vnsrl.wi v8, v16, 0, v0.t
; CHECK-NEXT:    bltu a0, a1, .LBB17_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a0, 16
; CHECK-NEXT:  .LBB17_2:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8re8.v v24, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vnsrl.wi v16, v24, 0, v0.t
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, tu, ma
; CHECK-NEXT:    vslideup.vi v16, v8, 16
; CHECK-NEXT:    vmv8r.v v8, v16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = call <32 x i32> @llvm.vp.trunc.v32i32.v32i64(<32 x i64> %a, <32 x i1> %m, i32 %vl)
  ret <32 x i32> %v
}
