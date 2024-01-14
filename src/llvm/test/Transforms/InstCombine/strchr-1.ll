; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Test that the strchr library call simplifier works correctly.
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:128:128-n8:16:32"

@hello = constant [14 x i8] c"hello world\5Cn\00"
@null = constant [1 x i8] zeroinitializer
@newlines = constant [3 x i8] c"\0D\0A\00"
@chp = global ptr zeroinitializer

declare ptr @strchr(ptr, i32)

define void @test_simplify1() {
; CHECK-LABEL: @test_simplify1(
; CHECK-NEXT:    store ptr getelementptr inbounds ([14 x i8], ptr @hello, i32 0, i32 6), ptr @chp, align 4
; CHECK-NEXT:    ret void
;

  %dst = call ptr @strchr(ptr @hello, i32 119)
  store ptr %dst, ptr @chp
  ret void
}

define void @test_simplify2() {
; CHECK-LABEL: @test_simplify2(
; CHECK-NEXT:    store ptr null, ptr @chp, align 4
; CHECK-NEXT:    ret void
;

  %dst = call ptr @strchr(ptr @null, i32 119)
  store ptr %dst, ptr @chp
  ret void
}

define void @test_simplify3() {
; CHECK-LABEL: @test_simplify3(
; CHECK-NEXT:    store ptr getelementptr inbounds ([14 x i8], ptr @hello, i32 0, i32 13), ptr @chp, align 4
; CHECK-NEXT:    ret void
;

  %dst = call ptr @strchr(ptr @hello, i32 0)
  store ptr %dst, ptr @chp
  ret void
}

define void @test_simplify4(i32 %chr) {
; CHECK-LABEL: @test_simplify4(
; CHECK-NEXT:    [[MEMCHR:%.*]] = call ptr @memchr(ptr noundef nonnull dereferenceable(1) @hello, i32 [[CHR:%.*]], i32 14)
; CHECK-NEXT:    store ptr [[MEMCHR]], ptr @chp, align 4
; CHECK-NEXT:    ret void
;

  %dst = call ptr @strchr(ptr @hello, i32 %chr)
  store ptr %dst, ptr @chp
  ret void
}

define void @test_simplify5() {
; CHECK-LABEL: @test_simplify5(
; CHECK-NEXT:    store ptr getelementptr inbounds ([14 x i8], ptr @hello, i32 0, i32 13), ptr @chp, align 4
; CHECK-NEXT:    ret void
;

  %dst = call ptr @strchr(ptr @hello, i32 65280)
  store ptr %dst, ptr @chp
  ret void
}

; Check transformation strchr(p, 0) -> p + strlen(p)
define void @test_simplify6(ptr %str) {
; CHECK-LABEL: @test_simplify6(
; CHECK-NEXT:    [[STRLEN:%.*]] = call i32 @strlen(ptr noundef nonnull dereferenceable(1) [[STR:%.*]])
; CHECK-NEXT:    [[STRCHR:%.*]] = getelementptr inbounds i8, ptr [[STR]], i32 [[STRLEN]]
; CHECK-NEXT:    store ptr [[STRCHR]], ptr @chp, align 4
; CHECK-NEXT:    ret void
;

  %dst = call ptr @strchr(ptr %str, i32 0)
  store ptr %dst, ptr @chp
  ret void
}

; Check transformation strchr("\r\n", C) != nullptr -> (C & 9217) != 0
define i1 @test_simplify7(i32 %C) {
; CHECK-LABEL: @test_simplify7(
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i32 [[C:%.*]] to i16
; CHECK-NEXT:    [[TMP2:%.*]] = and i16 [[TMP1]], 255
; CHECK-NEXT:    [[MEMCHR_BOUNDS:%.*]] = icmp ult i16 [[TMP2]], 16
; CHECK-NEXT:    [[TMP3:%.*]] = shl i16 1, [[TMP2]]
; CHECK-NEXT:    [[TMP4:%.*]] = and i16 [[TMP3]], 9217
; CHECK-NEXT:    [[MEMCHR_BITS:%.*]] = icmp ne i16 [[TMP4]], 0
; CHECK-NEXT:    [[MEMCHR1:%.*]] = select i1 [[MEMCHR_BOUNDS]], i1 [[MEMCHR_BITS]], i1 false
; CHECK-NEXT:    ret i1 [[MEMCHR1]]
;

  %dst = call ptr @strchr(ptr @newlines, i32 %C)
  %cmp = icmp ne ptr %dst, null
  ret i1 %cmp
}

define ptr @test1(ptr %str, i32 %c) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    [[RET:%.*]] = call ptr @strchr(ptr noundef nonnull dereferenceable(1) [[STR:%.*]], i32 [[C:%.*]])
; CHECK-NEXT:    ret ptr [[RET]]
;

  %ret = call ptr @strchr(ptr %str, i32 %c)
  ret ptr %ret
}

define ptr @test2(ptr %str, i32 %c) null_pointer_is_valid {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    [[RET:%.*]] = call ptr @strchr(ptr noundef [[STR:%.*]], i32 [[C:%.*]])
; CHECK-NEXT:    ret ptr [[RET]]
;

  %ret = call ptr @strchr(ptr %str, i32 %c)
  ret ptr %ret
}
