; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -memcpyopt -S -verify-memoryssa | FileCheck %s

; Test memcpy-memcpy dependencies across invoke edges.

; Test that memcpyopt works across the non-unwind edge of an invoke.

define hidden void @test_normal(ptr noalias %dst, ptr %src) personality ptr @__gxx_personality_v0 {
; CHECK-LABEL: @test_normal(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TEMP:%.*]] = alloca i8, i32 64, align 1
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 8 [[TEMP]], ptr nonnull align 8 [[SRC:%.*]], i64 64, i1 false)
; CHECK-NEXT:    invoke void @invoke_me()
; CHECK-NEXT:    to label [[TRY_CONT:%.*]] unwind label [[LPAD:%.*]]
; CHECK:       lpad:
; CHECK-NEXT:    [[TMP0:%.*]] = landingpad { ptr, i32 }
; CHECK-NEXT:    catch ptr null
; CHECK-NEXT:    ret void
; CHECK:       try.cont:
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 8 [[DST:%.*]], ptr align 8 [[SRC]], i64 64, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  %temp = alloca i8, i32 64
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %temp, ptr nonnull align 8 %src, i64 64, i1 false)
  invoke void @invoke_me()
  to label %try.cont unwind label %lpad

lpad:
  landingpad { ptr, i32 }
  catch ptr null
  ret void

try.cont:
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %dst, ptr align 8 %temp, i64 64, i1 false)
  ret void
}

; Test that memcpyopt works across the unwind edge of an invoke.

define hidden void @test_unwind(ptr noalias %dst, ptr %src) personality ptr @__gxx_personality_v0 {
; CHECK-LABEL: @test_unwind(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TEMP:%.*]] = alloca i8, i32 64, align 1
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 8 [[TEMP]], ptr nonnull align 8 [[SRC:%.*]], i64 64, i1 false)
; CHECK-NEXT:    invoke void @invoke_me()
; CHECK-NEXT:    to label [[TRY_CONT:%.*]] unwind label [[LPAD:%.*]]
; CHECK:       lpad:
; CHECK-NEXT:    [[TMP0:%.*]] = landingpad { ptr, i32 }
; CHECK-NEXT:    catch ptr null
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 8 [[DST:%.*]], ptr align 8 [[SRC]], i64 64, i1 false)
; CHECK-NEXT:    ret void
; CHECK:       try.cont:
; CHECK-NEXT:    ret void
;
entry:
  %temp = alloca i8, i32 64
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %temp, ptr nonnull align 8 %src, i64 64, i1 false)
  invoke void @invoke_me()
  to label %try.cont unwind label %lpad

lpad:
  landingpad { ptr, i32 }
  catch ptr null
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %dst, ptr align 8 %temp, i64 64, i1 false)
  ret void

try.cont:
  ret void
}

declare void @llvm.memcpy.p0.p0.i64(ptr nocapture writeonly, ptr nocapture readonly, i64, i1)
declare i32 @__gxx_personality_v0(...)
declare void @invoke_me() readnone
