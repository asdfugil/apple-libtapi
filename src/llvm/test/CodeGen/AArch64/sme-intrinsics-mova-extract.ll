; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve,+sme -verify-machineinstrs < %s | FileCheck %s

define <vscale x 16 x i8> @extract_row_b(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i32 %tileslice) {
; CHECK-LABEL: extract_row_b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov z1.d, z0.d
; CHECK-NEXT:    mov z2.d, z0.d
; CHECK-NEXT:    mov z3.d, z0.d
; CHECK-NEXT:    mov z4.d, z0.d
; CHECK-NEXT:    mov z1.b, p0/m, za0h.b[w12, 0]
; CHECK-NEXT:    mov z2.b, p0/m, za0h.b[w12, 2]
; CHECK-NEXT:    mov z3.b, p0/m, za0h.b[w12, 4]
; CHECK-NEXT:    mov z2.d, z0.d
; CHECK-NEXT:    mov z4.b, p0/m, za0h.b[w12, 6]
; CHECK-NEXT:    mov z3.d, z0.d
; CHECK-NEXT:    mov z2.b, p0/m, za0h.b[w12, 8]
; CHECK-NEXT:    mov z4.d, z0.d
; CHECK-NEXT:    mov z3.b, p0/m, za0h.b[w12, 10]
; CHECK-NEXT:    mov z4.b, p0/m, za0h.b[w12, 12]
; CHECK-NEXT:    mov z0.b, p0/m, za0h.b[w12, 14]
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
  %z0 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.horiz.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice)
  %tileslice.2 = add i32 %tileslice, 2
  %z1 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.horiz.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice.2)
  %tileslice.4 = add i32 %tileslice, 4
  %z2 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.horiz.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice.4)
  %tileslice.6 = add i32 %tileslice, 6
  %z3 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.horiz.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice.6)
  %tileslice.8 = add i32 %tileslice, 8
  %z4 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.horiz.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice.8)
  %tileslice.10 = add i32 %tileslice, 10
  %z5 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.horiz.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice.10)
  %tileslice.12 = add i32 %tileslice, 12
  %z6 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.horiz.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice.12)
  %tileslice.14 = add i32 %tileslice, 14
  %z7 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.horiz.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice.14)
  ret <vscale x 16 x i8> %z0
}

define <vscale x 16 x i8> @extract_col_b(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i32 %tileslice) {
; CHECK-LABEL: extract_col_b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov z1.d, z0.d
; CHECK-NEXT:    mov z2.d, z0.d
; CHECK-NEXT:    mov z3.d, z0.d
; CHECK-NEXT:    mov z4.d, z0.d
; CHECK-NEXT:    mov z1.b, p0/m, za0v.b[w12, 1]
; CHECK-NEXT:    mov z2.b, p0/m, za0v.b[w12, 3]
; CHECK-NEXT:    mov z3.b, p0/m, za0v.b[w12, 5]
; CHECK-NEXT:    mov z2.d, z0.d
; CHECK-NEXT:    mov z4.b, p0/m, za0v.b[w12, 7]
; CHECK-NEXT:    mov z3.d, z0.d
; CHECK-NEXT:    mov z2.b, p0/m, za0v.b[w12, 9]
; CHECK-NEXT:    mov z4.d, z0.d
; CHECK-NEXT:    mov z3.b, p0/m, za0v.b[w12, 11]
; CHECK-NEXT:    mov z4.b, p0/m, za0v.b[w12, 13]
; CHECK-NEXT:    mov z0.b, p0/m, za0v.b[w12, 15]
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
  %tileslice.1 = add i32 %tileslice, 1
  %z0 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.vert.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice.1)
  %tileslice.3 = add i32 %tileslice, 3
  %z1 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.vert.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice.3)
  %tileslice.5 = add i32 %tileslice, 5
  %z2 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.vert.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice.5)
  %tileslice.7 = add i32 %tileslice, 7
  %z3 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.vert.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice.7)
  %tileslice.9 = add i32 %tileslice, 9
  %z4 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.vert.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice.9)
  %tileslice.11 = add i32 %tileslice, 11
  %z5 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.vert.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice.11)
  %tileslice.13 = add i32 %tileslice, 13
  %z6 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.vert.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice.13)
  %tileslice.15 = add i32 %tileslice, 15
  %z7 = call <vscale x 16 x i8> @llvm.aarch64.sme.read.vert.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 %tileslice.15)
  ret <vscale x 16 x i8> %z0
}

define <vscale x 8 x i16> @extract_row_h(<vscale x 8 x i16> %zd, <vscale x 8 x i1> %pg, i32 %tileslice) {
; CHECK-LABEL: extract_row_h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov z1.d, z0.d
; CHECK-NEXT:    mov z2.d, z0.d
; CHECK-NEXT:    mov z3.d, z0.d
; CHECK-NEXT:    mov z1.h, p0/m, za0h.h[w12, 0]
; CHECK-NEXT:    mov z2.h, p0/m, za0h.h[w12, 2]
; CHECK-NEXT:    mov z3.h, p0/m, za0h.h[w12, 4]
; CHECK-NEXT:    mov z0.h, p0/m, za0h.h[w12, 6]
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
  %z0 = call <vscale x 8 x i16> @llvm.aarch64.sme.read.horiz.nxv8i16(<vscale x 8 x i16> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice)
  %tileslice.2 = add i32 %tileslice, 2
  %z1 = call <vscale x 8 x i16> @llvm.aarch64.sme.read.horiz.nxv8i16(<vscale x 8 x i16> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.2)
  %tileslice.4 = add i32 %tileslice, 4
  %z2 = call <vscale x 8 x i16> @llvm.aarch64.sme.read.horiz.nxv8i16(<vscale x 8 x i16> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.4)
  %tileslice.6 = add i32 %tileslice, 6
  %z3 = call <vscale x 8 x i16> @llvm.aarch64.sme.read.horiz.nxv8i16(<vscale x 8 x i16> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.6)
  ret <vscale x 8 x i16> %z0
}

define <vscale x 8 x i16> @extract_col_h(<vscale x 8 x i16> %zd, <vscale x 8 x i1> %pg, i32 %tileslice) {
; CHECK-LABEL: extract_col_h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov z1.d, z0.d
; CHECK-NEXT:    mov z2.d, z0.d
; CHECK-NEXT:    mov z3.d, z0.d
; CHECK-NEXT:    mov z1.h, p0/m, za1v.h[w12, 1]
; CHECK-NEXT:    mov z2.h, p0/m, za1v.h[w12, 3]
; CHECK-NEXT:    mov z3.h, p0/m, za1v.h[w12, 5]
; CHECK-NEXT:    mov z0.h, p0/m, za1v.h[w12, 7]
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
  %tileslice.1 = add i32 %tileslice, 1
  %z0 = call <vscale x 8 x i16> @llvm.aarch64.sme.read.vert.nxv8i16(<vscale x 8 x i16> %zd, <vscale x 8 x i1> %pg, i64 1, i32 %tileslice.1)
  %tileslice.3 = add i32 %tileslice, 3
  %z1 = call <vscale x 8 x i16> @llvm.aarch64.sme.read.vert.nxv8i16(<vscale x 8 x i16> %zd, <vscale x 8 x i1> %pg, i64 1, i32 %tileslice.3)
  %tileslice.5 = add i32 %tileslice, 5
  %z2 = call <vscale x 8 x i16> @llvm.aarch64.sme.read.vert.nxv8i16(<vscale x 8 x i16> %zd, <vscale x 8 x i1> %pg, i64 1, i32 %tileslice.5)
  %tileslice.7 = add i32 %tileslice, 7
  %z3 = call <vscale x 8 x i16> @llvm.aarch64.sme.read.vert.nxv8i16(<vscale x 8 x i16> %zd, <vscale x 8 x i1> %pg, i64 1, i32 %tileslice.7)
  ret <vscale x 8 x i16> %z0
}

define <vscale x 8 x half> @extract_f16(<vscale x 8 x half> %zd, <vscale x 8 x i1> %pg, i32 %tileslice) {
; CHECK-LABEL: extract_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov z1.d, z0.d
; CHECK-NEXT:    mov z2.d, z0.d
; CHECK-NEXT:    mov z3.d, z0.d
; CHECK-NEXT:    mov z4.d, z0.d
; CHECK-NEXT:    mov z1.h, p0/m, za0h.h[w12, 0]
; CHECK-NEXT:    mov z2.h, p0/m, za0h.h[w12, 1]
; CHECK-NEXT:    mov z3.h, p0/m, za0v.h[w12, 2]
; CHECK-NEXT:    mov z2.d, z0.d
; CHECK-NEXT:    mov z4.h, p0/m, za0v.h[w12, 3]
; CHECK-NEXT:    mov z3.d, z0.d
; CHECK-NEXT:    mov z2.h, p0/m, za0h.h[w12, 4]
; CHECK-NEXT:    mov z4.d, z0.d
; CHECK-NEXT:    mov z3.h, p0/m, za0h.h[w12, 5]
; CHECK-NEXT:    mov z4.h, p0/m, za0v.h[w12, 6]
; CHECK-NEXT:    mov z0.h, p0/m, za0v.h[w12, 7]
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
  %z0 = call <vscale x 8 x half> @llvm.aarch64.sme.read.horiz.nxv8f16(<vscale x 8 x half> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice)
  %tileslice.1 = add i32 %tileslice, 1
  %z1 = call <vscale x 8 x half> @llvm.aarch64.sme.read.horiz.nxv8f16(<vscale x 8 x half> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.1)
  %tileslice.2 = add i32 %tileslice, 2
  %z2 = call <vscale x 8 x half> @llvm.aarch64.sme.read.vert.nxv8f16(<vscale x 8 x half> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.2)
  %tileslice.3 = add i32 %tileslice, 3
  %z3 = call <vscale x 8 x half> @llvm.aarch64.sme.read.vert.nxv8f16(<vscale x 8 x half> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.3)
  %tileslice.4 = add i32 %tileslice, 4
  %z4 = call <vscale x 8 x half> @llvm.aarch64.sme.read.horiz.nxv8f16(<vscale x 8 x half> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.4)
  %tileslice.5 = add i32 %tileslice, 5
  %z5 = call <vscale x 8 x half> @llvm.aarch64.sme.read.horiz.nxv8f16(<vscale x 8 x half> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.5)
  %tileslice.6 = add i32 %tileslice, 6
  %z6 = call <vscale x 8 x half> @llvm.aarch64.sme.read.vert.nxv8f16(<vscale x 8 x half> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.6)
  %tileslice.7 = add i32 %tileslice, 7
  %z7 = call <vscale x 8 x half> @llvm.aarch64.sme.read.vert.nxv8f16(<vscale x 8 x half> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.7)
  ret <vscale x 8 x half> %z0
}

define <vscale x 8 x bfloat> @extract_bf16(<vscale x 8 x bfloat> %zd, <vscale x 8 x i1> %pg, i32 %tileslice, <vscale x 8 x bfloat> *%ptr) {
; CHECK-LABEL: extract_bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov z1.d, z0.d
; CHECK-NEXT:    mov z2.d, z0.d
; CHECK-NEXT:    mov z3.d, z0.d
; CHECK-NEXT:    mov z4.d, z0.d
; CHECK-NEXT:    mov z1.h, p0/m, za0h.h[w12, 0]
; CHECK-NEXT:    mov z2.h, p0/m, za0h.h[w12, 1]
; CHECK-NEXT:    mov z3.h, p0/m, za0v.h[w12, 2]
; CHECK-NEXT:    mov z2.d, z0.d
; CHECK-NEXT:    mov z4.h, p0/m, za0v.h[w12, 3]
; CHECK-NEXT:    mov z3.d, z0.d
; CHECK-NEXT:    mov z2.h, p0/m, za0h.h[w12, 4]
; CHECK-NEXT:    mov z4.d, z0.d
; CHECK-NEXT:    mov z3.h, p0/m, za0h.h[w12, 5]
; CHECK-NEXT:    mov z4.h, p0/m, za0v.h[w12, 6]
; CHECK-NEXT:    mov z0.h, p0/m, za0v.h[w12, 7]
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
  %z0 = call <vscale x 8 x bfloat> @llvm.aarch64.sme.read.horiz.nxv8bf16(<vscale x 8 x bfloat> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice)
  %tileslice.1 = add i32 %tileslice, 1
  %z1 = call <vscale x 8 x bfloat> @llvm.aarch64.sme.read.horiz.nxv8bf16(<vscale x 8 x bfloat> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.1)
  %tileslice.2 = add i32 %tileslice, 2
  %z2 = call <vscale x 8 x bfloat> @llvm.aarch64.sme.read.vert.nxv8bf16(<vscale x 8 x bfloat> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.2)
  %tileslice.3 = add i32 %tileslice, 3
  %z3 = call <vscale x 8 x bfloat> @llvm.aarch64.sme.read.vert.nxv8bf16(<vscale x 8 x bfloat> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.3)
  %tileslice.4 = add i32 %tileslice, 4
  %z4 = call <vscale x 8 x bfloat> @llvm.aarch64.sme.read.horiz.nxv8bf16(<vscale x 8 x bfloat> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.4)
  %tileslice.5 = add i32 %tileslice, 5
  %z5 = call <vscale x 8 x bfloat> @llvm.aarch64.sme.read.horiz.nxv8bf16(<vscale x 8 x bfloat> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.5)
  %tileslice.6 = add i32 %tileslice, 6
  %z6 = call <vscale x 8 x bfloat> @llvm.aarch64.sme.read.vert.nxv8bf16(<vscale x 8 x bfloat> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.6)
  %tileslice.7 = add i32 %tileslice, 7
  %z7 = call <vscale x 8 x bfloat> @llvm.aarch64.sme.read.vert.nxv8bf16(<vscale x 8 x bfloat> %zd, <vscale x 8 x i1> %pg, i64 0, i32 %tileslice.7)
  ret <vscale x 8 x bfloat> %z0
}

define <vscale x 4 x i32> @extract_row_s(<vscale x 4 x i32> %zd, <vscale x 4 x i1> %pg, i32 %tileslice) {
; CHECK-LABEL: extract_row_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov z1.d, z0.d
; CHECK-NEXT:    mov z1.s, p0/m, za0h.s[w12, 0]
; CHECK-NEXT:    mov z0.s, p0/m, za0h.s[w12, 2]
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
  %z0 = call <vscale x 4 x i32> @llvm.aarch64.sme.read.horiz.nxv4i32(<vscale x 4 x i32> %zd, <vscale x 4 x i1> %pg, i64 0, i32 %tileslice)
  %tileslice.2 = add i32 %tileslice, 2
  %z1 = call <vscale x 4 x i32> @llvm.aarch64.sme.read.horiz.nxv4i32(<vscale x 4 x i32> %zd, <vscale x 4 x i1> %pg, i64 0, i32 %tileslice.2)
  ret <vscale x 4 x i32> %z0
}

define <vscale x 4 x i32> @extract_col_s(<vscale x 4 x i32> %zd, <vscale x 4 x i1> %pg, i32 %tileslice) {
; CHECK-LABEL: extract_col_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov z1.d, z0.d
; CHECK-NEXT:    mov z1.s, p0/m, za3v.s[w12, 1]
; CHECK-NEXT:    mov z0.s, p0/m, za3v.s[w12, 3]
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
  %tileslice.1 = add i32 %tileslice, 1
  %z0 = call <vscale x 4 x i32> @llvm.aarch64.sme.read.vert.nxv4i32(<vscale x 4 x i32> %zd, <vscale x 4 x i1> %pg, i64 3, i32 %tileslice.1)
  %tileslice.3 = add i32 %tileslice, 3
  %z1 = call <vscale x 4 x i32> @llvm.aarch64.sme.read.vert.nxv4i32(<vscale x 4 x i32> %zd, <vscale x 4 x i1> %pg, i64 3, i32 %tileslice.3)
  ret <vscale x 4 x i32> %z0
}

define <vscale x 4 x float> @extract_f32(<vscale x 4 x float> %zd, <vscale x 4 x i1> %pg, i32 %tileslice) {
; CHECK-LABEL: extract_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov z1.d, z0.d
; CHECK-NEXT:    mov z2.d, z0.d
; CHECK-NEXT:    mov z3.d, z0.d
; CHECK-NEXT:    mov z1.s, p0/m, za0h.s[w12, 0]
; CHECK-NEXT:    mov z2.s, p0/m, za0h.s[w12, 1]
; CHECK-NEXT:    mov z3.s, p0/m, za0v.s[w12, 2]
; CHECK-NEXT:    mov z0.s, p0/m, za0v.s[w12, 3]
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
  %z0 = call <vscale x 4 x float> @llvm.aarch64.sme.read.horiz.nxv4f32(<vscale x 4 x float> %zd, <vscale x 4 x i1> %pg, i64 0, i32 %tileslice)
  %tileslice.1 = add i32 %tileslice, 1
  %z1 = call <vscale x 4 x float> @llvm.aarch64.sme.read.horiz.nxv4f32(<vscale x 4 x float> %zd, <vscale x 4 x i1> %pg, i64 0, i32 %tileslice.1)
  %tileslice.2 = add i32 %tileslice, 2
  %z2 = call <vscale x 4 x float> @llvm.aarch64.sme.read.vert.nxv4f32(<vscale x 4 x float> %zd, <vscale x 4 x i1> %pg, i64 0, i32 %tileslice.2)
  %tileslice.3 = add i32 %tileslice, 3
  %z3 = call <vscale x 4 x float> @llvm.aarch64.sme.read.vert.nxv4f32(<vscale x 4 x float> %zd, <vscale x 4 x i1> %pg, i64 0, i32 %tileslice.3)
  ret <vscale x 4 x float> %z0
}

define <vscale x 2 x i64> @extract_row_d(<vscale x 2 x i64> %zd, <vscale x 2 x i1> %pg, i32 %tileslice) {
; CHECK-LABEL: extract_row_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov z0.d, p0/m, za0h.d[w12, 0]
; CHECK-NEXT:    ret
  %z0 = call <vscale x 2 x i64> @llvm.aarch64.sme.read.horiz.nxv2i64(<vscale x 2 x i64> %zd, <vscale x 2 x i1> %pg, i64 0, i32 %tileslice)
  ret <vscale x 2 x i64> %z0
}

define <vscale x 2 x i64> @extract_col_d(<vscale x 2 x i64> %zd, <vscale x 2 x i1> %pg, i32 %tileslice) {
; CHECK-LABEL: extract_col_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov z0.d, p0/m, za1v.d[w12, 1]
; CHECK-NEXT:    ret
  %tileslice.1 = add i32 %tileslice, 1
  %z0 = call <vscale x 2 x i64> @llvm.aarch64.sme.read.vert.nxv2i64(<vscale x 2 x i64> %zd, <vscale x 2 x i1> %pg, i64 1, i32 %tileslice.1)
  ret <vscale x 2 x i64> %z0
}

define <vscale x 2 x double> @extract_f64(<vscale x 2 x double> %zd, <vscale x 2 x i1> %pg, i32 %tileslice) {
; CHECK-LABEL: extract_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov z1.d, z0.d
; CHECK-NEXT:    mov z1.d, p0/m, za0h.d[w12, 0]
; CHECK-NEXT:    mov z0.d, p0/m, za0v.d[w12, 1]
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
  %z0 = call <vscale x 2 x double> @llvm.aarch64.sme.read.horiz.nxv2f64(<vscale x 2 x double> %zd, <vscale x 2 x i1> %pg, i64 0, i32 %tileslice)
  %tileslice.1 = add i32 %tileslice, 1
  %z1 = call <vscale x 2 x double> @llvm.aarch64.sme.read.vert.nxv2f64(<vscale x 2 x double> %zd, <vscale x 2 x i1> %pg, i64 0, i32 %tileslice.1)
  ret <vscale x 2 x double> %z0
}

define <vscale x 16 x i8> @extract_row_q_v16i18(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg) {
; CHECK-LABEL: extract_row_q_v16i18:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov z0.q, p0/m, za0h.q[w12, 0]
; CHECK-NEXT:    ret
  %res = call <vscale x 16 x i8> @llvm.aarch64.sme.readq.horiz.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 0, i32 0)
  ret <vscale x 16 x i8> %res
}

define <vscale x 8 x i16> @extract_row_q_v8i16(<vscale x 8 x i16> %zd, <vscale x 8 x i1> %pg) {
; CHECK-LABEL: extract_row_q_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov z0.q, p0/m, za0h.q[w12, 0]
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i16> @llvm.aarch64.sme.readq.horiz.nxv8i16(<vscale x 8 x i16> %zd, <vscale x 8 x i1> %pg, i64 0, i32 0)
  ret <vscale x 8 x i16> %res
}

define <vscale x 8 x half> @extract_row_q_v8f16(<vscale x 8 x half> %zd, <vscale x 8 x i1> %pg) {
; CHECK-LABEL: extract_row_q_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov z0.q, p0/m, za0h.q[w12, 0]
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x half> @llvm.aarch64.sme.readq.horiz.nxv8f16(<vscale x 8 x half> %zd, <vscale x 8 x i1> %pg, i64 0, i32 0)
  ret <vscale x 8 x half> %res
}

define <vscale x 4 x i32> @extract_row_q_v4i32(<vscale x 4 x i32> %zd, <vscale x 4 x i1> %pg) {
; CHECK-LABEL: extract_row_q_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov z0.q, p0/m, za0h.q[w12, 0]
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x i32> @llvm.aarch64.sme.readq.horiz.nxv4i32(<vscale x 4 x i32> %zd, <vscale x 4 x i1> %pg, i64 0, i32 0)
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x float> @extract_row_q_v4f32(<vscale x 4 x float> %zd, <vscale x 4 x i1> %pg) {
; CHECK-LABEL: extract_row_q_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov z0.q, p0/m, za0h.q[w12, 0]
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x float> @llvm.aarch64.sme.readq.horiz.nxv4f32(<vscale x 4 x float> %zd, <vscale x 4 x i1> %pg, i64 0, i32 0)
  ret <vscale x 4 x float> %res
}

define <vscale x 2 x i64> @extract_row_q_v2i64(<vscale x 2 x i64> %zd, <vscale x 2 x i1> %pg) {
; CHECK-LABEL: extract_row_q_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov z0.q, p0/m, za0h.q[w12, 0]
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x i64> @llvm.aarch64.sme.readq.horiz.nxv2i64(<vscale x 2 x i64> %zd, <vscale x 2 x i1> %pg, i64 0, i32 0)
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x double> @extract_row_q_v2f64(<vscale x 2 x double> %zd, <vscale x 2 x i1> %pg) {
; CHECK-LABEL: extract_row_q_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov z0.q, p0/m, za0h.q[w12, 0]
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x double> @llvm.aarch64.sme.readq.horiz.nxv2f64(<vscale x 2 x double> %zd, <vscale x 2 x i1> %pg, i64 0, i32 0)
  ret <vscale x 2 x double> %res
}

define <vscale x 16 x i8> @extract_col_q_v16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg) {
; CHECK-LABEL: extract_col_q_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov z0.q, p0/m, za15v.q[w12, 0]
; CHECK-NEXT:    ret
  %res = call <vscale x 16 x i8> @llvm.aarch64.sme.readq.vert.nxv16i8(<vscale x 16 x i8> %zd, <vscale x 16 x i1> %pg, i64 15, i32 0)
  ret <vscale x 16 x i8> %res
}

define <vscale x 8 x i16> @extract_col_q_v8i16(<vscale x 8 x i16> %zd, <vscale x 8 x i1> %pg) {
; CHECK-LABEL: extract_col_q_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov z0.q, p0/m, za15v.q[w12, 0]
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i16> @llvm.aarch64.sme.readq.vert.nxv8i16(<vscale x 8 x i16> %zd, <vscale x 8 x i1> %pg, i64 15, i32 0)
  ret <vscale x 8 x i16> %res
}

define <vscale x 8 x half> @extract_col_q_v8f16(<vscale x 8 x half> %zd, <vscale x 8 x i1> %pg) {
; CHECK-LABEL: extract_col_q_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov z0.q, p0/m, za15v.q[w12, 0]
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x half> @llvm.aarch64.sme.readq.vert.nxv8f16(<vscale x 8 x half> %zd, <vscale x 8 x i1> %pg, i64 15, i32 0)
  ret <vscale x 8 x half> %res
}

define <vscale x 4 x i32> @extract_col_q_v4i32(<vscale x 4 x i32> %zd, <vscale x 4 x i1> %pg) {
; CHECK-LABEL: extract_col_q_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov z0.q, p0/m, za15v.q[w12, 0]
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x i32> @llvm.aarch64.sme.readq.vert.nxv4i32(<vscale x 4 x i32> %zd, <vscale x 4 x i1> %pg, i64 15, i32 0)
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x float> @extract_col_q_v4f32(<vscale x 4 x float> %zd, <vscale x 4 x i1> %pg) {
; CHECK-LABEL: extract_col_q_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov z0.q, p0/m, za15v.q[w12, 0]
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x float> @llvm.aarch64.sme.readq.vert.nxv4f32(<vscale x 4 x float> %zd, <vscale x 4 x i1> %pg, i64 15, i32 0)
  ret <vscale x 4 x float> %res
}

define <vscale x 2 x i64> @extract_col_q_v2i64(<vscale x 2 x i64> %zd, <vscale x 2 x i1> %pg) {
; CHECK-LABEL: extract_col_q_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov z0.q, p0/m, za15v.q[w12, 0]
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x i64> @llvm.aarch64.sme.readq.vert.nxv2i64(<vscale x 2 x i64> %zd, <vscale x 2 x i1> %pg, i64 15, i32 0)
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x double> @extract_col_q_v2f64(<vscale x 2 x double> %zd, <vscale x 2 x i1> %pg) {
; CHECK-LABEL: extract_col_q_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w12, wzr
; CHECK-NEXT:    mov z0.q, p0/m, za15v.q[w12, 0]
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x double> @llvm.aarch64.sme.readq.vert.nxv2f64(<vscale x 2 x double> %zd, <vscale x 2 x i1> %pg, i64 15, i32 0)
  ret <vscale x 2 x double> %res
}

define <vscale x 4 x i32> @test_sink_offset_operand(<vscale x 4 x i1> %pg, i32 %base, i32 %N) {
; CHECK-LABEL: test_sink_offset_operand:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w12, w0
; CHECK-NEXT:    mov z0.s, #0 // =0x0
; CHECK-NEXT:  .LBB26_1: // %for.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    mov z1.d, z0.d
; CHECK-NEXT:    mov z2.d, z0.d
; CHECK-NEXT:    mov z1.s, p0/m, za0h.s[w12, 0]
; CHECK-NEXT:    mov z3.d, z0.d
; CHECK-NEXT:    mov z2.s, p0/m, za0h.s[w12, 1]
; CHECK-NEXT:    subs w1, w1, #3
; CHECK-NEXT:    mov z3.s, p0/m, za0h.s[w12, 2]
; CHECK-NEXT:    b.ne .LBB26_1
; CHECK-NEXT:  // %bb.2: // %exit
; CHECK-NEXT:    add z0.s, z1.s, z2.s
; CHECK-NEXT:    add z0.s, z0.s, z3.s
; CHECK-NEXT:    ret
entry:
  %add1 = add i32 %base, 1
  %add2 = add i32 %base, 2
  br label %for.body

for.body:
  %i = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %z0 = call <vscale x 4 x i32> @llvm.aarch64.sme.read.horiz.nxv4i32(<vscale x 4 x i32> zeroinitializer, <vscale x 4 x i1> %pg, i64 0, i32 %base)
  %z1 = call <vscale x 4 x i32> @llvm.aarch64.sme.read.horiz.nxv4i32(<vscale x 4 x i32> zeroinitializer, <vscale x 4 x i1> %pg, i64 0, i32 %add1)
  %z2 = call <vscale x 4 x i32> @llvm.aarch64.sme.read.horiz.nxv4i32(<vscale x 4 x i32> zeroinitializer, <vscale x 4 x i1> %pg, i64 0, i32 %add2)
  %inc = add nuw nsw i32 %i, 3
  %exitcond.not = icmp eq i32 %inc, %N
  br i1 %exitcond.not, label %exit, label %for.body

exit:
  %tmp1 = add <vscale x 4 x i32> %z0, %z1
  %res = add <vscale x 4 x i32> %tmp1, %z2
  ret <vscale x 4 x i32> %res
}

declare <vscale x 16 x i8> @llvm.aarch64.sme.read.horiz.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i1>, i64, i32)
declare <vscale x 8 x i16> @llvm.aarch64.sme.read.horiz.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i1>, i64, i32)
declare <vscale x 8 x half> @llvm.aarch64.sme.read.horiz.nxv8f16(<vscale x 8 x half>, <vscale x 8 x i1>, i64, i32)
declare <vscale x 8 x bfloat> @llvm.aarch64.sme.read.horiz.nxv8bf16(<vscale x 8 x bfloat>, <vscale x 8 x i1>, i64, i32)
declare <vscale x 4 x i32> @llvm.aarch64.sme.read.horiz.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i1>, i64, i32)
declare <vscale x 4 x float> @llvm.aarch64.sme.read.horiz.nxv4f32(<vscale x 4 x float>, <vscale x 4 x i1>, i64, i32)
declare <vscale x 2 x i64> @llvm.aarch64.sme.read.horiz.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i1>, i64, i32)
declare <vscale x 2 x double> @llvm.aarch64.sme.read.horiz.nxv2f64(<vscale x 2 x double>, <vscale x 2 x i1>, i64, i32)
declare <vscale x 16 x i8> @llvm.aarch64.sme.read.vert.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i1>, i64, i32)
declare <vscale x 8 x i16> @llvm.aarch64.sme.read.vert.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i1>, i64, i32)
declare <vscale x 8 x half> @llvm.aarch64.sme.read.vert.nxv8f16(<vscale x 8 x half>, <vscale x 8 x i1>, i64, i32)
declare <vscale x 8 x bfloat> @llvm.aarch64.sme.read.vert.nxv8bf16(<vscale x 8 x bfloat>, <vscale x 8 x i1>, i64, i32)
declare <vscale x 4 x i32> @llvm.aarch64.sme.read.vert.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i1>, i64, i32)
declare <vscale x 4 x float> @llvm.aarch64.sme.read.vert.nxv4f32(<vscale x 4 x float>, <vscale x 4 x i1>, i64, i32)
declare <vscale x 2 x i64> @llvm.aarch64.sme.read.vert.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i1>, i64, i32)
declare <vscale x 2 x double> @llvm.aarch64.sme.read.vert.nxv2f64(<vscale x 2 x double>, <vscale x 2 x i1>, i64, i32)

declare <vscale x 16 x i8> @llvm.aarch64.sme.readq.horiz.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i1>, i64, i32)
declare <vscale x 8 x i16> @llvm.aarch64.sme.readq.horiz.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i1>, i64, i32)
declare <vscale x 8 x half> @llvm.aarch64.sme.readq.horiz.nxv8f16(<vscale x 8 x half>, <vscale x 8 x i1>, i64, i32)
declare <vscale x 8 x bfloat> @llvm.aarch64.sme.readq.horiz.nxv8bf16(<vscale x 8 x bfloat>, <vscale x 8 x i1>, i64, i32)
declare <vscale x 4 x i32> @llvm.aarch64.sme.readq.horiz.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i1>, i64, i32)
declare <vscale x 4 x float> @llvm.aarch64.sme.readq.horiz.nxv4f32(<vscale x 4 x float>, <vscale x 4 x i1>, i64, i32)
declare <vscale x 2 x i64> @llvm.aarch64.sme.readq.horiz.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i1>, i64, i32)
declare <vscale x 2 x double> @llvm.aarch64.sme.readq.horiz.nxv2f64(<vscale x 2 x double>, <vscale x 2 x i1>, i64, i32)
declare <vscale x 16 x i8> @llvm.aarch64.sme.readq.vert.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i1>, i64, i32)
declare <vscale x 8 x i16> @llvm.aarch64.sme.readq.vert.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i1>, i64, i32)
declare <vscale x 8 x half> @llvm.aarch64.sme.readq.vert.nxv8f16(<vscale x 8 x half>, <vscale x 8 x i1>, i64, i32)
declare <vscale x 8 x bfloat> @llvm.aarch64.sme.readq.vert.nxv8bf16(<vscale x 8 x bfloat>, <vscale x 8 x i1>, i64, i32)
declare <vscale x 4 x i32> @llvm.aarch64.sme.readq.vert.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i1>, i64, i32)
declare <vscale x 4 x float> @llvm.aarch64.sme.readq.vert.nxv4f32(<vscale x 4 x float>, <vscale x 4 x i1>, i64, i32)
declare <vscale x 2 x i64> @llvm.aarch64.sme.readq.vert.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i1>, i64, i32)
declare <vscale x 2 x double> @llvm.aarch64.sme.readq.vert.nxv2f64(<vscale x 2 x double>, <vscale x 2 x i1>, i64, i32)
