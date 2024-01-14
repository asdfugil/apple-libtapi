; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64

define <vscale x 1 x i8> @vadd_vx_nxv1i8(<vscale x 1 x i8> %va, i8 signext %b) {
; CHECK-LABEL: vadd_vx_nxv1i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i8> poison, i8 %b, i32 0
  %splat = shufflevector <vscale x 1 x i8> %head, <vscale x 1 x i8> poison, <vscale x 1 x i32> zeroinitializer
  %vc = add <vscale x 1 x i8> %va, %splat
  ret <vscale x 1 x i8> %vc
}

define <vscale x 1 x i8> @vadd_vx_nxv1i8_0(<vscale x 1 x i8> %va) {
; CHECK-LABEL: vadd_vx_nxv1i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i8> poison, i8 -1, i32 0
  %splat = shufflevector <vscale x 1 x i8> %head, <vscale x 1 x i8> poison, <vscale x 1 x i32> zeroinitializer
  %vc = add <vscale x 1 x i8> %va, %splat
  ret <vscale x 1 x i8> %vc
}

define <vscale x 1 x i8> @vadd_vx_nxv1i8_1(<vscale x 1 x i8> %va) {
; CHECK-LABEL: vadd_vx_nxv1i8_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i8> poison, i8 2, i32 0
  %splat = shufflevector <vscale x 1 x i8> %head, <vscale x 1 x i8> poison, <vscale x 1 x i32> zeroinitializer
  %vc = add <vscale x 1 x i8> %va, %splat
  ret <vscale x 1 x i8> %vc
}

; Test constant adds to see if we can optimize them away for scalable vectors.
define <vscale x 1 x i8> @vadd_ii_nxv1i8_1() {
; CHECK-LABEL: vadd_ii_nxv1i8_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 5
; CHECK-NEXT:    ret
  %heada = insertelement <vscale x 1 x i8> poison, i8 2, i32 0
  %splata = shufflevector <vscale x 1 x i8> %heada, <vscale x 1 x i8> poison, <vscale x 1 x i32> zeroinitializer
  %headb = insertelement <vscale x 1 x i8> poison, i8 3, i32 0
  %splatb = shufflevector <vscale x 1 x i8> %headb, <vscale x 1 x i8> poison, <vscale x 1 x i32> zeroinitializer
  %vc = add <vscale x 1 x i8> %splata, %splatb
  ret <vscale x 1 x i8> %vc
}

define <vscale x 2 x i8> @vadd_vx_nxv2i8(<vscale x 2 x i8> %va, i8 signext %b) {
; CHECK-LABEL: vadd_vx_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i8> poison, i8 %b, i32 0
  %splat = shufflevector <vscale x 2 x i8> %head, <vscale x 2 x i8> poison, <vscale x 2 x i32> zeroinitializer
  %vc = add <vscale x 2 x i8> %va, %splat
  ret <vscale x 2 x i8> %vc
}

define <vscale x 2 x i8> @vadd_vx_nxv2i8_0(<vscale x 2 x i8> %va) {
; CHECK-LABEL: vadd_vx_nxv2i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i8> poison, i8 -1, i32 0
  %splat = shufflevector <vscale x 2 x i8> %head, <vscale x 2 x i8> poison, <vscale x 2 x i32> zeroinitializer
  %vc = add <vscale x 2 x i8> %va, %splat
  ret <vscale x 2 x i8> %vc
}

define <vscale x 2 x i8> @vadd_vx_nxv2i8_1(<vscale x 2 x i8> %va) {
; CHECK-LABEL: vadd_vx_nxv2i8_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i8> poison, i8 2, i32 0
  %splat = shufflevector <vscale x 2 x i8> %head, <vscale x 2 x i8> poison, <vscale x 2 x i32> zeroinitializer
  %vc = add <vscale x 2 x i8> %va, %splat
  ret <vscale x 2 x i8> %vc
}

define <vscale x 4 x i8> @vadd_vx_nxv4i8(<vscale x 4 x i8> %va, i8 signext %b) {
; CHECK-LABEL: vadd_vx_nxv4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i8> poison, i8 %b, i32 0
  %splat = shufflevector <vscale x 4 x i8> %head, <vscale x 4 x i8> poison, <vscale x 4 x i32> zeroinitializer
  %vc = add <vscale x 4 x i8> %va, %splat
  ret <vscale x 4 x i8> %vc
}

define <vscale x 4 x i8> @vadd_vx_nxv4i8_0(<vscale x 4 x i8> %va) {
; CHECK-LABEL: vadd_vx_nxv4i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i8> poison, i8 -1, i32 0
  %splat = shufflevector <vscale x 4 x i8> %head, <vscale x 4 x i8> poison, <vscale x 4 x i32> zeroinitializer
  %vc = add <vscale x 4 x i8> %va, %splat
  ret <vscale x 4 x i8> %vc
}

define <vscale x 4 x i8> @vadd_vx_nxv4i8_1(<vscale x 4 x i8> %va) {
; CHECK-LABEL: vadd_vx_nxv4i8_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i8> poison, i8 2, i32 0
  %splat = shufflevector <vscale x 4 x i8> %head, <vscale x 4 x i8> poison, <vscale x 4 x i32> zeroinitializer
  %vc = add <vscale x 4 x i8> %va, %splat
  ret <vscale x 4 x i8> %vc
}

define <vscale x 8 x i8> @vadd_vx_nxv8i8(<vscale x 8 x i8> %va, i8 signext %b) {
; CHECK-LABEL: vadd_vx_nxv8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i8> poison, i8 %b, i32 0
  %splat = shufflevector <vscale x 8 x i8> %head, <vscale x 8 x i8> poison, <vscale x 8 x i32> zeroinitializer
  %vc = add <vscale x 8 x i8> %va, %splat
  ret <vscale x 8 x i8> %vc
}

define <vscale x 8 x i8> @vadd_vx_nxv8i8_0(<vscale x 8 x i8> %va) {
; CHECK-LABEL: vadd_vx_nxv8i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i8> poison, i8 -1, i32 0
  %splat = shufflevector <vscale x 8 x i8> %head, <vscale x 8 x i8> poison, <vscale x 8 x i32> zeroinitializer
  %vc = add <vscale x 8 x i8> %va, %splat
  ret <vscale x 8 x i8> %vc
}

define <vscale x 8 x i8> @vadd_vx_nxv8i8_1(<vscale x 8 x i8> %va) {
; CHECK-LABEL: vadd_vx_nxv8i8_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i8> poison, i8 2, i32 0
  %splat = shufflevector <vscale x 8 x i8> %head, <vscale x 8 x i8> poison, <vscale x 8 x i32> zeroinitializer
  %vc = add <vscale x 8 x i8> %va, %splat
  ret <vscale x 8 x i8> %vc
}

define <vscale x 16 x i8> @vadd_vx_nxv16i8(<vscale x 16 x i8> %va, i8 signext %b) {
; CHECK-LABEL: vadd_vx_nxv16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m2, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i8> poison, i8 %b, i32 0
  %splat = shufflevector <vscale x 16 x i8> %head, <vscale x 16 x i8> poison, <vscale x 16 x i32> zeroinitializer
  %vc = add <vscale x 16 x i8> %va, %splat
  ret <vscale x 16 x i8> %vc
}

define <vscale x 16 x i8> @vadd_vx_nxv16i8_0(<vscale x 16 x i8> %va) {
; CHECK-LABEL: vadd_vx_nxv16i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m2, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i8> poison, i8 -1, i32 0
  %splat = shufflevector <vscale x 16 x i8> %head, <vscale x 16 x i8> poison, <vscale x 16 x i32> zeroinitializer
  %vc = add <vscale x 16 x i8> %va, %splat
  ret <vscale x 16 x i8> %vc
}

define <vscale x 16 x i8> @vadd_vx_nxv16i8_1(<vscale x 16 x i8> %va) {
; CHECK-LABEL: vadd_vx_nxv16i8_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m2, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i8> poison, i8 2, i32 0
  %splat = shufflevector <vscale x 16 x i8> %head, <vscale x 16 x i8> poison, <vscale x 16 x i32> zeroinitializer
  %vc = add <vscale x 16 x i8> %va, %splat
  ret <vscale x 16 x i8> %vc
}

define <vscale x 32 x i8> @vadd_vx_nxv32i8(<vscale x 32 x i8> %va, i8 signext %b) {
; CHECK-LABEL: vadd_vx_nxv32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m4, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 32 x i8> poison, i8 %b, i32 0
  %splat = shufflevector <vscale x 32 x i8> %head, <vscale x 32 x i8> poison, <vscale x 32 x i32> zeroinitializer
  %vc = add <vscale x 32 x i8> %va, %splat
  ret <vscale x 32 x i8> %vc
}

define <vscale x 32 x i8> @vadd_vx_nxv32i8_0(<vscale x 32 x i8> %va) {
; CHECK-LABEL: vadd_vx_nxv32i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m4, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 32 x i8> poison, i8 -1, i32 0
  %splat = shufflevector <vscale x 32 x i8> %head, <vscale x 32 x i8> poison, <vscale x 32 x i32> zeroinitializer
  %vc = add <vscale x 32 x i8> %va, %splat
  ret <vscale x 32 x i8> %vc
}

define <vscale x 32 x i8> @vadd_vx_nxv32i8_1(<vscale x 32 x i8> %va) {
; CHECK-LABEL: vadd_vx_nxv32i8_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m4, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 32 x i8> poison, i8 2, i32 0
  %splat = shufflevector <vscale x 32 x i8> %head, <vscale x 32 x i8> poison, <vscale x 32 x i32> zeroinitializer
  %vc = add <vscale x 32 x i8> %va, %splat
  ret <vscale x 32 x i8> %vc
}

define <vscale x 64 x i8> @vadd_vx_nxv64i8(<vscale x 64 x i8> %va, i8 signext %b) {
; CHECK-LABEL: vadd_vx_nxv64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m8, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 64 x i8> poison, i8 %b, i32 0
  %splat = shufflevector <vscale x 64 x i8> %head, <vscale x 64 x i8> poison, <vscale x 64 x i32> zeroinitializer
  %vc = add <vscale x 64 x i8> %va, %splat
  ret <vscale x 64 x i8> %vc
}

define <vscale x 64 x i8> @vadd_vx_nxv64i8_0(<vscale x 64 x i8> %va) {
; CHECK-LABEL: vadd_vx_nxv64i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m8, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 64 x i8> poison, i8 -1, i32 0
  %splat = shufflevector <vscale x 64 x i8> %head, <vscale x 64 x i8> poison, <vscale x 64 x i32> zeroinitializer
  %vc = add <vscale x 64 x i8> %va, %splat
  ret <vscale x 64 x i8> %vc
}

define <vscale x 64 x i8> @vadd_vx_nxv64i8_1(<vscale x 64 x i8> %va) {
; CHECK-LABEL: vadd_vx_nxv64i8_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m8, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 64 x i8> poison, i8 2, i32 0
  %splat = shufflevector <vscale x 64 x i8> %head, <vscale x 64 x i8> poison, <vscale x 64 x i32> zeroinitializer
  %vc = add <vscale x 64 x i8> %va, %splat
  ret <vscale x 64 x i8> %vc
}

define <vscale x 1 x i16> @vadd_vx_nxv1i16(<vscale x 1 x i16> %va, i16 signext %b) {
; CHECK-LABEL: vadd_vx_nxv1i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i16> poison, i16 %b, i32 0
  %splat = shufflevector <vscale x 1 x i16> %head, <vscale x 1 x i16> poison, <vscale x 1 x i32> zeroinitializer
  %vc = add <vscale x 1 x i16> %va, %splat
  ret <vscale x 1 x i16> %vc
}

define <vscale x 1 x i16> @vadd_vx_nxv1i16_0(<vscale x 1 x i16> %va) {
; CHECK-LABEL: vadd_vx_nxv1i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i16> poison, i16 -1, i32 0
  %splat = shufflevector <vscale x 1 x i16> %head, <vscale x 1 x i16> poison, <vscale x 1 x i32> zeroinitializer
  %vc = add <vscale x 1 x i16> %va, %splat
  ret <vscale x 1 x i16> %vc
}

define <vscale x 1 x i16> @vadd_vx_nxv1i16_1(<vscale x 1 x i16> %va) {
; CHECK-LABEL: vadd_vx_nxv1i16_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i16> poison, i16 2, i32 0
  %splat = shufflevector <vscale x 1 x i16> %head, <vscale x 1 x i16> poison, <vscale x 1 x i32> zeroinitializer
  %vc = add <vscale x 1 x i16> %va, %splat
  ret <vscale x 1 x i16> %vc
}

define <vscale x 2 x i16> @vadd_vx_nxv2i16(<vscale x 2 x i16> %va, i16 signext %b) {
; CHECK-LABEL: vadd_vx_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i16> poison, i16 %b, i32 0
  %splat = shufflevector <vscale x 2 x i16> %head, <vscale x 2 x i16> poison, <vscale x 2 x i32> zeroinitializer
  %vc = add <vscale x 2 x i16> %va, %splat
  ret <vscale x 2 x i16> %vc
}

define <vscale x 2 x i16> @vadd_vx_nxv2i16_0(<vscale x 2 x i16> %va) {
; CHECK-LABEL: vadd_vx_nxv2i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i16> poison, i16 -1, i32 0
  %splat = shufflevector <vscale x 2 x i16> %head, <vscale x 2 x i16> poison, <vscale x 2 x i32> zeroinitializer
  %vc = add <vscale x 2 x i16> %va, %splat
  ret <vscale x 2 x i16> %vc
}

define <vscale x 2 x i16> @vadd_vx_nxv2i16_1(<vscale x 2 x i16> %va) {
; CHECK-LABEL: vadd_vx_nxv2i16_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i16> poison, i16 2, i32 0
  %splat = shufflevector <vscale x 2 x i16> %head, <vscale x 2 x i16> poison, <vscale x 2 x i32> zeroinitializer
  %vc = add <vscale x 2 x i16> %va, %splat
  ret <vscale x 2 x i16> %vc
}

define <vscale x 4 x i16> @vadd_vx_nxv4i16(<vscale x 4 x i16> %va, i16 signext %b) {
; CHECK-LABEL: vadd_vx_nxv4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i16> poison, i16 %b, i32 0
  %splat = shufflevector <vscale x 4 x i16> %head, <vscale x 4 x i16> poison, <vscale x 4 x i32> zeroinitializer
  %vc = add <vscale x 4 x i16> %va, %splat
  ret <vscale x 4 x i16> %vc
}

define <vscale x 4 x i16> @vadd_vx_nxv4i16_0(<vscale x 4 x i16> %va) {
; CHECK-LABEL: vadd_vx_nxv4i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i16> poison, i16 -1, i32 0
  %splat = shufflevector <vscale x 4 x i16> %head, <vscale x 4 x i16> poison, <vscale x 4 x i32> zeroinitializer
  %vc = add <vscale x 4 x i16> %va, %splat
  ret <vscale x 4 x i16> %vc
}

define <vscale x 4 x i16> @vadd_vx_nxv4i16_1(<vscale x 4 x i16> %va) {
; CHECK-LABEL: vadd_vx_nxv4i16_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i16> poison, i16 2, i32 0
  %splat = shufflevector <vscale x 4 x i16> %head, <vscale x 4 x i16> poison, <vscale x 4 x i32> zeroinitializer
  %vc = add <vscale x 4 x i16> %va, %splat
  ret <vscale x 4 x i16> %vc
}

define <vscale x 8 x i16> @vadd_vx_nxv8i16(<vscale x 8 x i16> %va, i16 signext %b) {
; CHECK-LABEL: vadd_vx_nxv8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i16> poison, i16 %b, i32 0
  %splat = shufflevector <vscale x 8 x i16> %head, <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer
  %vc = add <vscale x 8 x i16> %va, %splat
  ret <vscale x 8 x i16> %vc
}

define <vscale x 8 x i16> @vadd_vx_nxv8i16_0(<vscale x 8 x i16> %va) {
; CHECK-LABEL: vadd_vx_nxv8i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i16> poison, i16 -1, i32 0
  %splat = shufflevector <vscale x 8 x i16> %head, <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer
  %vc = add <vscale x 8 x i16> %va, %splat
  ret <vscale x 8 x i16> %vc
}

define <vscale x 8 x i16> @vadd_vx_nxv8i16_1(<vscale x 8 x i16> %va) {
; CHECK-LABEL: vadd_vx_nxv8i16_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i16> poison, i16 2, i32 0
  %splat = shufflevector <vscale x 8 x i16> %head, <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer
  %vc = add <vscale x 8 x i16> %va, %splat
  ret <vscale x 8 x i16> %vc
}

define <vscale x 16 x i16> @vadd_vx_nxv16i16(<vscale x 16 x i16> %va, i16 signext %b) {
; CHECK-LABEL: vadd_vx_nxv16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m4, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i16> poison, i16 %b, i32 0
  %splat = shufflevector <vscale x 16 x i16> %head, <vscale x 16 x i16> poison, <vscale x 16 x i32> zeroinitializer
  %vc = add <vscale x 16 x i16> %va, %splat
  ret <vscale x 16 x i16> %vc
}

define <vscale x 16 x i16> @vadd_vx_nxv16i16_0(<vscale x 16 x i16> %va) {
; CHECK-LABEL: vadd_vx_nxv16i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i16> poison, i16 -1, i32 0
  %splat = shufflevector <vscale x 16 x i16> %head, <vscale x 16 x i16> poison, <vscale x 16 x i32> zeroinitializer
  %vc = add <vscale x 16 x i16> %va, %splat
  ret <vscale x 16 x i16> %vc
}

define <vscale x 16 x i16> @vadd_vx_nxv16i16_1(<vscale x 16 x i16> %va) {
; CHECK-LABEL: vadd_vx_nxv16i16_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i16> poison, i16 2, i32 0
  %splat = shufflevector <vscale x 16 x i16> %head, <vscale x 16 x i16> poison, <vscale x 16 x i32> zeroinitializer
  %vc = add <vscale x 16 x i16> %va, %splat
  ret <vscale x 16 x i16> %vc
}

define <vscale x 32 x i16> @vadd_vx_nxv32i16(<vscale x 32 x i16> %va, i16 signext %b) {
; CHECK-LABEL: vadd_vx_nxv32i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m8, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 32 x i16> poison, i16 %b, i32 0
  %splat = shufflevector <vscale x 32 x i16> %head, <vscale x 32 x i16> poison, <vscale x 32 x i32> zeroinitializer
  %vc = add <vscale x 32 x i16> %va, %splat
  ret <vscale x 32 x i16> %vc
}

define <vscale x 32 x i16> @vadd_vx_nxv32i16_0(<vscale x 32 x i16> %va) {
; CHECK-LABEL: vadd_vx_nxv32i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 32 x i16> poison, i16 -1, i32 0
  %splat = shufflevector <vscale x 32 x i16> %head, <vscale x 32 x i16> poison, <vscale x 32 x i32> zeroinitializer
  %vc = add <vscale x 32 x i16> %va, %splat
  ret <vscale x 32 x i16> %vc
}

define <vscale x 32 x i16> @vadd_vx_nxv32i16_1(<vscale x 32 x i16> %va) {
; CHECK-LABEL: vadd_vx_nxv32i16_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 32 x i16> poison, i16 2, i32 0
  %splat = shufflevector <vscale x 32 x i16> %head, <vscale x 32 x i16> poison, <vscale x 32 x i32> zeroinitializer
  %vc = add <vscale x 32 x i16> %va, %splat
  ret <vscale x 32 x i16> %vc
}

define <vscale x 1 x i32> @vadd_vx_nxv1i32(<vscale x 1 x i32> %va, i32 signext %b) {
; CHECK-LABEL: vadd_vx_nxv1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i32> poison, i32 %b, i32 0
  %splat = shufflevector <vscale x 1 x i32> %head, <vscale x 1 x i32> poison, <vscale x 1 x i32> zeroinitializer
  %vc = add <vscale x 1 x i32> %va, %splat
  ret <vscale x 1 x i32> %vc
}

define <vscale x 1 x i32> @vadd_vx_nxv1i32_0(<vscale x 1 x i32> %va) {
; CHECK-LABEL: vadd_vx_nxv1i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i32> poison, i32 -1, i32 0
  %splat = shufflevector <vscale x 1 x i32> %head, <vscale x 1 x i32> poison, <vscale x 1 x i32> zeroinitializer
  %vc = add <vscale x 1 x i32> %va, %splat
  ret <vscale x 1 x i32> %vc
}

define <vscale x 1 x i32> @vadd_vx_nxv1i32_1(<vscale x 1 x i32> %va) {
; CHECK-LABEL: vadd_vx_nxv1i32_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i32> poison, i32 2, i32 0
  %splat = shufflevector <vscale x 1 x i32> %head, <vscale x 1 x i32> poison, <vscale x 1 x i32> zeroinitializer
  %vc = add <vscale x 1 x i32> %va, %splat
  ret <vscale x 1 x i32> %vc
}

define <vscale x 2 x i32> @vadd_vx_nxv2i32(<vscale x 2 x i32> %va, i32 signext %b) {
; CHECK-LABEL: vadd_vx_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i32> poison, i32 %b, i32 0
  %splat = shufflevector <vscale x 2 x i32> %head, <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer
  %vc = add <vscale x 2 x i32> %va, %splat
  ret <vscale x 2 x i32> %vc
}

define <vscale x 2 x i32> @vadd_vx_nxv2i32_0(<vscale x 2 x i32> %va) {
; CHECK-LABEL: vadd_vx_nxv2i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i32> poison, i32 -1, i32 0
  %splat = shufflevector <vscale x 2 x i32> %head, <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer
  %vc = add <vscale x 2 x i32> %va, %splat
  ret <vscale x 2 x i32> %vc
}

define <vscale x 2 x i32> @vadd_vx_nxv2i32_1(<vscale x 2 x i32> %va) {
; CHECK-LABEL: vadd_vx_nxv2i32_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i32> poison, i32 2, i32 0
  %splat = shufflevector <vscale x 2 x i32> %head, <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer
  %vc = add <vscale x 2 x i32> %va, %splat
  ret <vscale x 2 x i32> %vc
}

define <vscale x 4 x i32> @vadd_vx_nxv4i32(<vscale x 4 x i32> %va, i32 signext %b) {
; CHECK-LABEL: vadd_vx_nxv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i32> poison, i32 %b, i32 0
  %splat = shufflevector <vscale x 4 x i32> %head, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %vc = add <vscale x 4 x i32> %va, %splat
  ret <vscale x 4 x i32> %vc
}

define <vscale x 4 x i32> @vadd_vx_nxv4i32_0(<vscale x 4 x i32> %va) {
; CHECK-LABEL: vadd_vx_nxv4i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i32> poison, i32 -1, i32 0
  %splat = shufflevector <vscale x 4 x i32> %head, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %vc = add <vscale x 4 x i32> %va, %splat
  ret <vscale x 4 x i32> %vc
}

define <vscale x 4 x i32> @vadd_vx_nxv4i32_1(<vscale x 4 x i32> %va) {
; CHECK-LABEL: vadd_vx_nxv4i32_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i32> poison, i32 2, i32 0
  %splat = shufflevector <vscale x 4 x i32> %head, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %vc = add <vscale x 4 x i32> %va, %splat
  ret <vscale x 4 x i32> %vc
}

define <vscale x 8 x i32> @vadd_vx_nxv8i32(<vscale x 8 x i32> %va, i32 signext %b) {
; CHECK-LABEL: vadd_vx_nxv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m4, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i32> poison, i32 %b, i32 0
  %splat = shufflevector <vscale x 8 x i32> %head, <vscale x 8 x i32> poison, <vscale x 8 x i32> zeroinitializer
  %vc = add <vscale x 8 x i32> %va, %splat
  ret <vscale x 8 x i32> %vc
}

define <vscale x 8 x i32> @vadd_vx_nxv8i32_0(<vscale x 8 x i32> %va) {
; CHECK-LABEL: vadd_vx_nxv8i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i32> poison, i32 -1, i32 0
  %splat = shufflevector <vscale x 8 x i32> %head, <vscale x 8 x i32> poison, <vscale x 8 x i32> zeroinitializer
  %vc = add <vscale x 8 x i32> %va, %splat
  ret <vscale x 8 x i32> %vc
}

define <vscale x 8 x i32> @vadd_vx_nxv8i32_1(<vscale x 8 x i32> %va) {
; CHECK-LABEL: vadd_vx_nxv8i32_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i32> poison, i32 2, i32 0
  %splat = shufflevector <vscale x 8 x i32> %head, <vscale x 8 x i32> poison, <vscale x 8 x i32> zeroinitializer
  %vc = add <vscale x 8 x i32> %va, %splat
  ret <vscale x 8 x i32> %vc
}

define <vscale x 16 x i32> @vadd_vx_nxv16i32(<vscale x 16 x i32> %va, i32 signext %b) {
; CHECK-LABEL: vadd_vx_nxv16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m8, ta, ma
; CHECK-NEXT:    vadd.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i32> poison, i32 %b, i32 0
  %splat = shufflevector <vscale x 16 x i32> %head, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  %vc = add <vscale x 16 x i32> %va, %splat
  ret <vscale x 16 x i32> %vc
}

define <vscale x 16 x i32> @vadd_vx_nxv16i32_0(<vscale x 16 x i32> %va) {
; CHECK-LABEL: vadd_vx_nxv16i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i32> poison, i32 -1, i32 0
  %splat = shufflevector <vscale x 16 x i32> %head, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  %vc = add <vscale x 16 x i32> %va, %splat
  ret <vscale x 16 x i32> %vc
}

define <vscale x 16 x i32> @vadd_vx_nxv16i32_1(<vscale x 16 x i32> %va) {
; CHECK-LABEL: vadd_vx_nxv16i32_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i32> poison, i32 2, i32 0
  %splat = shufflevector <vscale x 16 x i32> %head, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  %vc = add <vscale x 16 x i32> %va, %splat
  ret <vscale x 16 x i32> %vc
}

define <vscale x 1 x i64> @vadd_vx_nxv1i64(<vscale x 1 x i64> %va, i64 %b) {
; RV32-LABEL: vadd_vx_nxv1i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m1, ta, ma
; RV32-NEXT:    vlse64.v v9, (a0), zero
; RV32-NEXT:    vadd.vv v8, v8, v9
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vadd_vx_nxv1i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a1, zero, e64, m1, ta, ma
; RV64-NEXT:    vadd.vx v8, v8, a0
; RV64-NEXT:    ret
  %head = insertelement <vscale x 1 x i64> poison, i64 %b, i32 0
  %splat = shufflevector <vscale x 1 x i64> %head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %vc = add <vscale x 1 x i64> %va, %splat
  ret <vscale x 1 x i64> %vc
}

define <vscale x 1 x i64> @vadd_vx_nxv1i64_0(<vscale x 1 x i64> %va) {
; CHECK-LABEL: vadd_vx_nxv1i64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i64> poison, i64 -1, i32 0
  %splat = shufflevector <vscale x 1 x i64> %head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %vc = add <vscale x 1 x i64> %va, %splat
  ret <vscale x 1 x i64> %vc
}

define <vscale x 1 x i64> @vadd_vx_nxv1i64_1(<vscale x 1 x i64> %va) {
; CHECK-LABEL: vadd_vx_nxv1i64_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i64> poison, i64 2, i32 0
  %splat = shufflevector <vscale x 1 x i64> %head, <vscale x 1 x i64> poison, <vscale x 1 x i32> zeroinitializer
  %vc = add <vscale x 1 x i64> %va, %splat
  ret <vscale x 1 x i64> %vc
}

define <vscale x 2 x i64> @vadd_vx_nxv2i64(<vscale x 2 x i64> %va, i64 %b) {
; RV32-LABEL: vadd_vx_nxv2i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m2, ta, ma
; RV32-NEXT:    vlse64.v v10, (a0), zero
; RV32-NEXT:    vadd.vv v8, v8, v10
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vadd_vx_nxv2i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a1, zero, e64, m2, ta, ma
; RV64-NEXT:    vadd.vx v8, v8, a0
; RV64-NEXT:    ret
  %head = insertelement <vscale x 2 x i64> poison, i64 %b, i32 0
  %splat = shufflevector <vscale x 2 x i64> %head, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %vc = add <vscale x 2 x i64> %va, %splat
  ret <vscale x 2 x i64> %vc
}

define <vscale x 2 x i64> @vadd_vx_nxv2i64_0(<vscale x 2 x i64> %va) {
; CHECK-LABEL: vadd_vx_nxv2i64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i64> poison, i64 -1, i32 0
  %splat = shufflevector <vscale x 2 x i64> %head, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %vc = add <vscale x 2 x i64> %va, %splat
  ret <vscale x 2 x i64> %vc
}

define <vscale x 2 x i64> @vadd_vx_nxv2i64_1(<vscale x 2 x i64> %va) {
; CHECK-LABEL: vadd_vx_nxv2i64_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i64> poison, i64 2, i32 0
  %splat = shufflevector <vscale x 2 x i64> %head, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %vc = add <vscale x 2 x i64> %va, %splat
  ret <vscale x 2 x i64> %vc
}

define <vscale x 4 x i64> @vadd_vx_nxv4i64(<vscale x 4 x i64> %va, i64 %b) {
; RV32-LABEL: vadd_vx_nxv4i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m4, ta, ma
; RV32-NEXT:    vlse64.v v12, (a0), zero
; RV32-NEXT:    vadd.vv v8, v8, v12
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vadd_vx_nxv4i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a1, zero, e64, m4, ta, ma
; RV64-NEXT:    vadd.vx v8, v8, a0
; RV64-NEXT:    ret
  %head = insertelement <vscale x 4 x i64> poison, i64 %b, i32 0
  %splat = shufflevector <vscale x 4 x i64> %head, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %vc = add <vscale x 4 x i64> %va, %splat
  ret <vscale x 4 x i64> %vc
}

define <vscale x 4 x i64> @vadd_vx_nxv4i64_0(<vscale x 4 x i64> %va) {
; CHECK-LABEL: vadd_vx_nxv4i64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i64> poison, i64 -1, i32 0
  %splat = shufflevector <vscale x 4 x i64> %head, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %vc = add <vscale x 4 x i64> %va, %splat
  ret <vscale x 4 x i64> %vc
}

define <vscale x 4 x i64> @vadd_vx_nxv4i64_1(<vscale x 4 x i64> %va) {
; CHECK-LABEL: vadd_vx_nxv4i64_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i64> poison, i64 2, i32 0
  %splat = shufflevector <vscale x 4 x i64> %head, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %vc = add <vscale x 4 x i64> %va, %splat
  ret <vscale x 4 x i64> %vc
}

define <vscale x 8 x i64> @vadd_vx_nxv8i64(<vscale x 8 x i64> %va, i64 %b) {
; RV32-LABEL: vadd_vx_nxv8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; RV32-NEXT:    vlse64.v v16, (a0), zero
; RV32-NEXT:    vadd.vv v8, v8, v16
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vadd_vx_nxv8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; RV64-NEXT:    vadd.vx v8, v8, a0
; RV64-NEXT:    ret
  %head = insertelement <vscale x 8 x i64> poison, i64 %b, i32 0
  %splat = shufflevector <vscale x 8 x i64> %head, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %vc = add <vscale x 8 x i64> %va, %splat
  ret <vscale x 8 x i64> %vc
}

define <vscale x 8 x i64> @vadd_vx_nxv8i64_0(<vscale x 8 x i64> %va) {
; CHECK-LABEL: vadd_vx_nxv8i64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, -1
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i64> poison, i64 -1, i32 0
  %splat = shufflevector <vscale x 8 x i64> %head, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %vc = add <vscale x 8 x i64> %va, %splat
  ret <vscale x 8 x i64> %vc
}

define <vscale x 8 x i64> @vadd_vx_nxv8i64_1(<vscale x 8 x i64> %va) {
; CHECK-LABEL: vadd_vx_nxv8i64_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vadd.vi v8, v8, 2
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i64> poison, i64 2, i32 0
  %splat = shufflevector <vscale x 8 x i64> %head, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %vc = add <vscale x 8 x i64> %va, %splat
  ret <vscale x 8 x i64> %vc
}

define <vscale x 8 x i64> @vadd_xx_nxv8i64(i64 %a, i64 %b) nounwind {
; RV32-LABEL: vadd_xx_nxv8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; RV32-NEXT:    vlse64.v v8, (a0), zero
; RV32-NEXT:    sw a3, 12(sp)
; RV32-NEXT:    sw a2, 8(sp)
; RV32-NEXT:    vlse64.v v16, (a0), zero
; RV32-NEXT:    vadd.vv v8, v8, v16
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vadd_xx_nxv8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    add a0, a0, a1
; RV64-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; RV64-NEXT:    vmv.v.x v8, a0
; RV64-NEXT:    ret
  %head1 = insertelement <vscale x 8 x i64> poison, i64 %a, i32 0
  %splat1 = shufflevector <vscale x 8 x i64> %head1, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %head2 = insertelement <vscale x 8 x i64> poison, i64 %b, i32 0
  %splat2 = shufflevector <vscale x 8 x i64> %head2, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %v = add <vscale x 8 x i64> %splat1, %splat2
  ret <vscale x 8 x i64> %v
}
