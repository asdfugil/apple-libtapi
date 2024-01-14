; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -simplifycfg -simplifycfg-require-and-preserve-domtree=1 -S | FileCheck %s
; PR2967

target datalayout =
"e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32"
target triple = "i386-pc-linux-gnu"

define void @test1(i32 %x) nounwind {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = icmp eq i32 [[X:%.*]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = xor i1 [[TMP0]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP1]])
; CHECK-NEXT:    ret void
;
entry:
  %0 = icmp eq i32 %x, 0          ; <i1> [#uses=1]
  br i1 %0, label %bb, label %return

bb:             ; preds = %entry
  %1 = load volatile i32, i32* null
  unreachable

  br label %return
return:         ; preds = %entry
  ret void
}

define void @test1_no_null_opt(i32 %x) nounwind #0 {
; CHECK-LABEL: @test1_no_null_opt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = icmp eq i32 [[X:%.*]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = xor i1 [[TMP0]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP1]])
; CHECK-NEXT:    ret void
;
entry:
  %0 = icmp eq i32 %x, 0          ; <i1> [#uses=1]
  br i1 %0, label %bb, label %return

bb:             ; preds = %entry
  %1 = load volatile i32, i32* null
  unreachable

  br label %return
return:         ; preds = %entry
  ret void
}

; rdar://7958343
define void @test2() nounwind {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    unreachable
;
entry:
  store i32 4,i32* null
  ret void

}

define void @test2_no_null_opt() nounwind #0 {
; CHECK-LABEL: @test2_no_null_opt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i32 4, i32* null, align 4
; CHECK-NEXT:    ret void
;
entry:
  store i32 4,i32* null
  ret void
}

; PR7369
define void @test3() nounwind {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store volatile i32 4, i32* null, align 4
; CHECK-NEXT:    ret void
;
entry:
  store volatile i32 4, i32* null
  ret void

}

define void @test3_no_null_opt() nounwind #0 {
; CHECK-LABEL: @test3_no_null_opt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store volatile i32 4, i32* null, align 4
; CHECK-NEXT:    ret void
;
entry:
  store volatile i32 4, i32* null
  ret void

}

; Check store before unreachable.
define void @test4(i1 %C, i32* %P) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[T:%.*]], label [[F:%.*]]
; CHECK:       T:
; CHECK-NEXT:    store volatile i32 0, i32* [[P:%.*]], align 4
; CHECK-NEXT:    unreachable
; CHECK:       F:
; CHECK-NEXT:    ret void
;
entry:
  br i1 %C, label %T, label %F
T:
  store volatile i32 0, i32* %P
  unreachable
F:
  ret void
}

; Check cmpxchg before unreachable.
define void @test5(i1 %C, i32* %P) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[C:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %C, label %T, label %F
T:
  cmpxchg volatile i32* %P, i32 0, i32 1 seq_cst seq_cst
  unreachable
F:
  ret void
}

; Check atomicrmw before unreachable.
define void @test6(i1 %C, i32* %P) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = xor i1 [[C:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %C, label %T, label %F
T:
  atomicrmw volatile xchg i32* %P, i32 0 seq_cst
  unreachable
F:
  ret void
}

attributes #0 = { null_pointer_is_valid }
