; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=argpromotion < %s | FileCheck %s

; Make sure volatile and atomic loads are not promoted.

define internal i32 @callee_volatile(i32* %p) {
; CHECK-LABEL: @callee_volatile(
; CHECK-NEXT:    [[V:%.*]] = load volatile i32, i32* [[P:%.*]], align 4
; CHECK-NEXT:    ret i32 [[V]]
;
  %v = load volatile i32, i32* %p
  ret i32 %v
}

define void @caller_volatile(i32* %p) {
; CHECK-LABEL: @caller_volatile(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @callee_volatile(i32* [[P:%.*]])
; CHECK-NEXT:    ret void
;
  call i32 @callee_volatile(i32* %p)
  ret void
}

define internal i32 @callee_atomic(i32* %p) {
; CHECK-LABEL: @callee_atomic(
; CHECK-NEXT:    [[V:%.*]] = load atomic i32, i32* [[P:%.*]] seq_cst, align 4
; CHECK-NEXT:    ret i32 [[V]]
;
  %v = load atomic i32, i32* %p seq_cst, align 4
  ret i32 %v
}

define void @caller_atomic(i32* %p) {
; CHECK-LABEL: @caller_atomic(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @callee_atomic(i32* [[P:%.*]])
; CHECK-NEXT:    ret void
;
  call i32 @callee_atomic(i32* %p)
  ret void
}
