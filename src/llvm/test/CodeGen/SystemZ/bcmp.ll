; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=s390x-linux-gnu | FileCheck %s

declare signext i32 @bcmp(ptr nocapture, ptr nocapture, i64)

define zeroext i1 @test_bcmp_eq_0(ptr nocapture readonly %A, ptr nocapture readonly %B) {
; CHECK-LABEL: test_bcmp_eq_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    clc 0(2,%r3), 0(%r2)
; CHECK-NEXT:    ipm %r0
; CHECK-NEXT:    afi %r0, -268435456
; CHECK-NEXT:    risbg %r2, %r0, 63, 191, 33
; CHECK-NEXT:    br %r14
  %c = tail call signext i32 @bcmp(ptr %A, ptr %B, i64 2)
  %res  = icmp eq i32 %c, 0
  ret i1 %res
}

define signext i32 @test_bcmp(ptr nocapture readonly %A, ptr nocapture readonly %B) {
; CHECK-LABEL: test_bcmp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    clc 0(2,%r3), 0(%r2)
; CHECK-NEXT:    ipm %r0
; CHECK-NEXT:    sllg %r0, %r0, 34
; CHECK-NEXT:    srag %r2, %r0, 62
; CHECK-NEXT:    br %r14
  %res = tail call signext i32 @bcmp(ptr %A, ptr %B, i64 2)
  ret i32 %res
}
