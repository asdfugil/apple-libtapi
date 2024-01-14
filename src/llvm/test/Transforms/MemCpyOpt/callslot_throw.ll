; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -memcpyopt < %s -verify-memoryssa | FileCheck %s
declare void @may_throw(ptr nocapture %x)

define void @test1(ptr nocapture noalias dereferenceable(4) %x) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[T:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @may_throw(ptr nonnull [[T]])
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[T]], align 4
; CHECK-NEXT:    store i32 [[LOAD]], ptr [[X:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %t = alloca i32, align 4
  call void @may_throw(ptr nonnull %t)
  %load = load i32, ptr %t, align 4
  store i32 %load, ptr %x, align 4
  ret void
}

declare void @always_throws()

define void @test2(ptr nocapture noalias dereferenceable(4) %x) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[T:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @may_throw(ptr nonnull [[T]]) #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[T]], align 4
; CHECK-NEXT:    call void @always_throws()
; CHECK-NEXT:    store i32 [[LOAD]], ptr [[X:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %t = alloca i32, align 4
  call void @may_throw(ptr nonnull %t) nounwind
  %load = load i32, ptr %t, align 4
  call void @always_throws()
  store i32 %load, ptr %x, align 4
  ret void
}

; byval argument is not visible on unwind.
define void @test_byval(ptr nocapture noalias dereferenceable(4) byval(i32) %x) {
; CHECK-LABEL: @test_byval(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[T:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @may_throw(ptr nonnull [[X:%.*]])
; CHECK-NEXT:    ret void
;
entry:
  %t = alloca i32, align 4
  call void @may_throw(ptr nonnull %t)
  %load = load i32, ptr %t, align 4
  store i32 %load, ptr %x, align 4
  ret void
}

; TODO: With updated semantics, sret could also be invisible on unwind.
define void @test_sret(ptr nocapture noalias dereferenceable(4) sret(i32) %x) {
; CHECK-LABEL: @test_sret(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[T:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @may_throw(ptr nonnull [[T]])
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[T]], align 4
; CHECK-NEXT:    store i32 [[LOAD]], ptr [[X:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %t = alloca i32, align 4
  call void @may_throw(ptr nonnull %t)
  %load = load i32, ptr %t, align 4
  store i32 %load, ptr %x, align 4
  ret void
}
