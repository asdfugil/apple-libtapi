; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 < %s | FileCheck %s --check-prefix=LA32
; RUN: llc --mtriple=loongarch64 < %s | FileCheck %s --check-prefix=LA64

;; Exercise the 'ashr' LLVM IR: https://llvm.org/docs/LangRef.html#ashr-instruction

define i1 @ashr_i1(i1 %x, i1 %y) {
; LA32-LABEL: ashr_i1:
; LA32:       # %bb.0:
; LA32-NEXT:    ret
;
; LA64-LABEL: ashr_i1:
; LA64:       # %bb.0:
; LA64-NEXT:    ret
  %ashr = ashr i1 %x, %y
  ret i1 %ashr
}

define i8 @ashr_i8(i8 %x, i8 %y) {
; LA32-LABEL: ashr_i8:
; LA32:       # %bb.0:
; LA32-NEXT:    ext.w.b $a0, $a0
; LA32-NEXT:    sra.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: ashr_i8:
; LA64:       # %bb.0:
; LA64-NEXT:    ext.w.b $a0, $a0
; LA64-NEXT:    sra.d $a0, $a0, $a1
; LA64-NEXT:    ret
  %ashr = ashr i8 %x, %y
  ret i8 %ashr
}

define i16 @ashr_i16(i16 %x, i16 %y) {
; LA32-LABEL: ashr_i16:
; LA32:       # %bb.0:
; LA32-NEXT:    ext.w.h $a0, $a0
; LA32-NEXT:    sra.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: ashr_i16:
; LA64:       # %bb.0:
; LA64-NEXT:    ext.w.h $a0, $a0
; LA64-NEXT:    sra.d $a0, $a0, $a1
; LA64-NEXT:    ret
  %ashr = ashr i16 %x, %y
  ret i16 %ashr
}

define i32 @ashr_i32(i32 %x, i32 %y) {
; LA32-LABEL: ashr_i32:
; LA32:       # %bb.0:
; LA32-NEXT:    sra.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: ashr_i32:
; LA64:       # %bb.0:
; LA64-NEXT:    sra.w $a0, $a0, $a1
; LA64-NEXT:    ret
  %ashr = ashr i32 %x, %y
  ret i32 %ashr
}

define i64 @ashr_i64(i64 %x, i64 %y) {
; LA32-LABEL: ashr_i64:
; LA32:       # %bb.0:
; LA32-NEXT:    srai.w $a3, $a1, 31
; LA32-NEXT:    addi.w $a4, $a2, -32
; LA32-NEXT:    slti $a5, $a4, 0
; LA32-NEXT:    masknez $a3, $a3, $a5
; LA32-NEXT:    sra.w $a6, $a1, $a2
; LA32-NEXT:    maskeqz $a6, $a6, $a5
; LA32-NEXT:    or $a3, $a6, $a3
; LA32-NEXT:    srl.w $a0, $a0, $a2
; LA32-NEXT:    xori $a2, $a2, 31
; LA32-NEXT:    slli.w $a6, $a1, 1
; LA32-NEXT:    sll.w $a2, $a6, $a2
; LA32-NEXT:    or $a0, $a0, $a2
; LA32-NEXT:    sra.w $a1, $a1, $a4
; LA32-NEXT:    maskeqz $a0, $a0, $a5
; LA32-NEXT:    masknez $a1, $a1, $a5
; LA32-NEXT:    or $a0, $a0, $a1
; LA32-NEXT:    move $a1, $a3
; LA32-NEXT:    ret
;
; LA64-LABEL: ashr_i64:
; LA64:       # %bb.0:
; LA64-NEXT:    sra.d $a0, $a0, $a1
; LA64-NEXT:    ret
  %ashr = ashr i64 %x, %y
  ret i64 %ashr
}

define i1 @ashr_i1_3(i1 %x) {
; LA32-LABEL: ashr_i1_3:
; LA32:       # %bb.0:
; LA32-NEXT:    ret
;
; LA64-LABEL: ashr_i1_3:
; LA64:       # %bb.0:
; LA64-NEXT:    ret
  %ashr = ashr i1 %x, 3
  ret i1 %ashr
}

define i8 @ashr_i8_3(i8 %x) {
; LA32-LABEL: ashr_i8_3:
; LA32:       # %bb.0:
; LA32-NEXT:    ext.w.b $a0, $a0
; LA32-NEXT:    srai.w $a0, $a0, 3
; LA32-NEXT:    ret
;
; LA64-LABEL: ashr_i8_3:
; LA64:       # %bb.0:
; LA64-NEXT:    ext.w.b $a0, $a0
; LA64-NEXT:    srai.d $a0, $a0, 3
; LA64-NEXT:    ret
  %ashr = ashr i8 %x, 3
  ret i8 %ashr
}

define i16 @ashr_i16_3(i16 %x) {
; LA32-LABEL: ashr_i16_3:
; LA32:       # %bb.0:
; LA32-NEXT:    ext.w.h $a0, $a0
; LA32-NEXT:    srai.w $a0, $a0, 3
; LA32-NEXT:    ret
;
; LA64-LABEL: ashr_i16_3:
; LA64:       # %bb.0:
; LA64-NEXT:    ext.w.h $a0, $a0
; LA64-NEXT:    srai.d $a0, $a0, 3
; LA64-NEXT:    ret
  %ashr = ashr i16 %x, 3
  ret i16 %ashr
}

define i32 @ashr_i32_3(i32 %x) {
; LA32-LABEL: ashr_i32_3:
; LA32:       # %bb.0:
; LA32-NEXT:    srai.w $a0, $a0, 3
; LA32-NEXT:    ret
;
; LA64-LABEL: ashr_i32_3:
; LA64:       # %bb.0:
; LA64-NEXT:    addi.w $a0, $a0, 0
; LA64-NEXT:    srai.d $a0, $a0, 3
; LA64-NEXT:    ret
  %ashr = ashr i32 %x, 3
  ret i32 %ashr
}

define i64 @ashr_i64_3(i64 %x) {
; LA32-LABEL: ashr_i64_3:
; LA32:       # %bb.0:
; LA32-NEXT:    srli.w $a0, $a0, 3
; LA32-NEXT:    slli.w $a2, $a1, 29
; LA32-NEXT:    or $a0, $a0, $a2
; LA32-NEXT:    srai.w $a1, $a1, 3
; LA32-NEXT:    ret
;
; LA64-LABEL: ashr_i64_3:
; LA64:       # %bb.0:
; LA64-NEXT:    srai.d $a0, $a0, 3
; LA64-NEXT:    ret
  %ashr = ashr i64 %x, 3
  ret i64 %ashr
}
