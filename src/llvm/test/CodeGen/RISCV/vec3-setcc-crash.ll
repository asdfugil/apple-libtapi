; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs \
; RUN:     -riscv-v-vector-bits-min=0 < %s | FileCheck %s --check-prefix=RV32
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs \
; RUN:     -riscv-v-vector-bits-min=0 < %s | FileCheck %s --check-prefix=RV64

; This test would lead one of the DAGCombiner's visitVSELECT optimizations to
; call getSetCCResultType, from which we'd return an invalid MVT (<3 x i1>)
; upon seeing that the V extension is enabled. The invalid MVT has a null
; Type*, which then segfaulted when accessed (as an EVT).
define void @vec3_setcc_crash(<3 x i8>* %in, <3 x i8>* %out) {
; RV32-LABEL: vec3_setcc_crash:
; RV32:       # %bb.0:
; RV32-NEXT:    lw a0, 0(a0)
; RV32-NEXT:    srli a2, a0, 16
; RV32-NEXT:    slli a3, a0, 8
; RV32-NEXT:    srai a3, a3, 24
; RV32-NEXT:    slli a4, a0, 24
; RV32-NEXT:    srai a4, a4, 24
; RV32-NEXT:    srli a5, a0, 8
; RV32-NEXT:    slli a6, a0, 16
; RV32-NEXT:    srai a6, a6, 24
; RV32-NEXT:    sgtz a6, a6
; RV32-NEXT:    neg a6, a6
; RV32-NEXT:    and a5, a6, a5
; RV32-NEXT:    slli a5, a5, 8
; RV32-NEXT:    sgtz a4, a4
; RV32-NEXT:    neg a4, a4
; RV32-NEXT:    and a0, a4, a0
; RV32-NEXT:    andi a0, a0, 255
; RV32-NEXT:    or a0, a0, a5
; RV32-NEXT:    sgtz a3, a3
; RV32-NEXT:    neg a3, a3
; RV32-NEXT:    and a2, a3, a2
; RV32-NEXT:    sb a2, 2(a1)
; RV32-NEXT:    sh a0, 0(a1)
; RV32-NEXT:    ret
;
; RV64-LABEL: vec3_setcc_crash:
; RV64:       # %bb.0:
; RV64-NEXT:    lw a0, 0(a0)
; RV64-NEXT:    srli a2, a0, 16
; RV64-NEXT:    slli a3, a0, 40
; RV64-NEXT:    srai a3, a3, 56
; RV64-NEXT:    slli a4, a0, 56
; RV64-NEXT:    srai a4, a4, 56
; RV64-NEXT:    srli a5, a0, 8
; RV64-NEXT:    slli a6, a0, 48
; RV64-NEXT:    srai a6, a6, 56
; RV64-NEXT:    sgtz a6, a6
; RV64-NEXT:    neg a6, a6
; RV64-NEXT:    and a5, a6, a5
; RV64-NEXT:    slli a5, a5, 8
; RV64-NEXT:    sgtz a4, a4
; RV64-NEXT:    neg a4, a4
; RV64-NEXT:    and a0, a4, a0
; RV64-NEXT:    andi a0, a0, 255
; RV64-NEXT:    or a0, a0, a5
; RV64-NEXT:    sgtz a3, a3
; RV64-NEXT:    neg a3, a3
; RV64-NEXT:    and a2, a3, a2
; RV64-NEXT:    sb a2, 2(a1)
; RV64-NEXT:    sh a0, 0(a1)
; RV64-NEXT:    ret
  %a = load <3 x i8>, <3 x i8>* %in
  %cmp = icmp sgt <3 x i8> %a, zeroinitializer
  %c = select <3 x i1> %cmp, <3 x i8> %a, <3 x i8> zeroinitializer
  store <3 x i8> %c, <3 x i8>* %out
  ret void
}
