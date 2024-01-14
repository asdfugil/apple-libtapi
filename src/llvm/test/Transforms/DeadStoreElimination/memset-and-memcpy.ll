; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -dse -S | FileCheck %s
; RUN: opt < %s -aa-pipeline=basic-aa -passes=dse -S | FileCheck %s
target datalayout = "E-p:64:64:64-a0:0:8-f32:32:32-f64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-v64:64:64-v128:128:128"

declare void @llvm.memset.p0.i64(ptr nocapture, i8, i64, i1) nounwind
declare void @llvm.memset.element.unordered.atomic.p0.i64(ptr nocapture, i8, i64, i32) nounwind
declare void @llvm.memcpy.p0.p0.i64(ptr nocapture, ptr nocapture, i64, i1) nounwind
declare void @llvm.memcpy.element.unordered.atomic.p0.p0.i64(ptr nocapture, ptr nocapture, i64, i32) nounwind
declare void @llvm.init.trampoline(ptr, ptr, ptr)


;; Overwrite of memset by memcpy.
define void @test17(ptr %P, ptr noalias %Q) nounwind ssp {
; CHECK-LABEL: @test17(
; CHECK-NEXT:    tail call void @llvm.memcpy.p0.p0.i64(ptr [[P:%.*]], ptr [[Q:%.*]], i64 12, i1 false)
; CHECK-NEXT:    ret void
;
  tail call void @llvm.memset.p0.i64(ptr %P, i8 42, i64 8, i1 false)
  tail call void @llvm.memcpy.p0.p0.i64(ptr %P, ptr %Q, i64 12, i1 false)
  ret void
}

;; Overwrite of memset by memcpy.
define void @test17_atomic(ptr %P, ptr noalias %Q) nounwind ssp {
; CHECK-LABEL: @test17_atomic(
; CHECK-NEXT:    tail call void @llvm.memcpy.element.unordered.atomic.p0.p0.i64(ptr align 1 [[P:%.*]], ptr align 1 [[Q:%.*]], i64 12, i32 1)
; CHECK-NEXT:    ret void
;
  tail call void @llvm.memset.element.unordered.atomic.p0.i64(ptr align 1 %P, i8 42, i64 8, i32 1)
  tail call void @llvm.memcpy.element.unordered.atomic.p0.p0.i64(ptr align 1 %P, ptr align 1 %Q, i64 12, i32 1)
  ret void
}

;; Overwrite of memset by memcpy. Overwrite is stronger atomicity. We can
;; remove the memset.
define void @test17_atomic_weaker(ptr %P, ptr noalias %Q) nounwind ssp {
; CHECK-LABEL: @test17_atomic_weaker(
; CHECK-NEXT:    tail call void @llvm.memcpy.element.unordered.atomic.p0.p0.i64(ptr align 1 [[P:%.*]], ptr align 1 [[Q:%.*]], i64 12, i32 1)
; CHECK-NEXT:    ret void
;
  tail call void @llvm.memset.p0.i64(ptr align 1 %P, i8 42, i64 8, i1 false)
  tail call void @llvm.memcpy.element.unordered.atomic.p0.p0.i64(ptr align 1 %P, ptr align 1 %Q, i64 12, i32 1)
  ret void
}

;; Overwrite of memset by memcpy. Overwrite is weaker atomicity. We can remove
;; the memset.
define void @test17_atomic_weaker_2(ptr %P, ptr noalias %Q) nounwind ssp {
; CHECK-LABEL: @test17_atomic_weaker_2(
; CHECK-NEXT:    tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 [[P:%.*]], ptr align 1 [[Q:%.*]], i64 12, i1 false)
; CHECK-NEXT:    ret void
;
  tail call void @llvm.memset.element.unordered.atomic.p0.i64(ptr align 1 %P, i8 42, i64 8, i32 1)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %P, ptr align 1 %Q, i64 12, i1 false)
  ret void
}

; Should not delete the volatile memset.
define void @test17v(ptr %P, ptr %Q) nounwind ssp {
; CHECK-LABEL: @test17v(
; CHECK-NEXT:    tail call void @llvm.memset.p0.i64(ptr [[P:%.*]], i8 42, i64 8, i1 true)
; CHECK-NEXT:    tail call void @llvm.memcpy.p0.p0.i64(ptr [[P]], ptr [[Q:%.*]], i64 12, i1 false)
; CHECK-NEXT:    ret void
;
  tail call void @llvm.memset.p0.i64(ptr %P, i8 42, i64 8, i1 true)
  tail call void @llvm.memcpy.p0.p0.i64(ptr %P, ptr %Q, i64 12, i1 false)
  ret void
}

; See PR11763 - LLVM allows memcpy's source and destination to be equal (but not
; inequal and overlapping).
define void @test18(ptr %P, ptr %Q, ptr %R) nounwind ssp {
; CHECK-LABEL: @test18(
; CHECK-NEXT:    tail call void @llvm.memcpy.p0.p0.i64(ptr [[P:%.*]], ptr [[Q:%.*]], i64 12, i1 false)
; CHECK-NEXT:    tail call void @llvm.memcpy.p0.p0.i64(ptr [[P]], ptr [[R:%.*]], i64 12, i1 false)
; CHECK-NEXT:    ret void
;
  tail call void @llvm.memcpy.p0.p0.i64(ptr %P, ptr %Q, i64 12, i1 false)
  tail call void @llvm.memcpy.p0.p0.i64(ptr %P, ptr %R, i64 12, i1 false)
  ret void
}

define void @test18_atomic(ptr %P, ptr %Q, ptr %R) nounwind ssp {
; CHECK-LABEL: @test18_atomic(
; CHECK-NEXT:    tail call void @llvm.memcpy.element.unordered.atomic.p0.p0.i64(ptr align 1 [[P:%.*]], ptr align 1 [[Q:%.*]], i64 12, i32 1)
; CHECK-NEXT:    tail call void @llvm.memcpy.element.unordered.atomic.p0.p0.i64(ptr align 1 [[P]], ptr align 1 [[R:%.*]], i64 12, i32 1)
; CHECK-NEXT:    ret void
;
  tail call void @llvm.memcpy.element.unordered.atomic.p0.p0.i64(ptr align 1 %P, ptr align 1 %Q, i64 12, i32 1)
  tail call void @llvm.memcpy.element.unordered.atomic.p0.p0.i64(ptr align 1 %P, ptr align 1 %R, i64 12, i32 1)
  ret void
}

define void @test_memset_memcpy_inline(ptr noalias %P, ptr noalias %Q) {
; CHECK-LABEL: @test_memset_memcpy_inline(
; CHECK-NEXT:    tail call void @llvm.memcpy.inline.p0.p0.i64(ptr align 1 [[P:%.*]], ptr align 1 [[Q:%.*]], i64 12, i1 false)
; CHECK-NEXT:    ret void
;
  tail call void @llvm.memset.p0.i64(ptr %P, i8 42, i64 8, i1 false)
  tail call void @llvm.memcpy.inline.p0.p0.i64(ptr align 1 %P, ptr align 1 %Q, i64 12, i1 false)
  ret void
}

define void @test_store_memcpy_inline(ptr noalias %P, ptr noalias %Q) {
; CHECK-LABEL: @test_store_memcpy_inline(
; CHECK-NEXT:    [[P_4:%.*]] = getelementptr i8, ptr [[P:%.*]], i64 4
; CHECK-NEXT:    store i8 4, ptr [[P_4]], align 1
; CHECK-NEXT:    tail call void @llvm.memcpy.inline.p0.p0.i64(ptr align 1 [[P]], ptr align 1 [[Q:%.*]], i64 4, i1 false)
; CHECK-NEXT:    ret void
;
  store i8 0, ptr %P
  %P.1 = getelementptr i8, ptr %P, i64 1
  store i8 1, ptr %P.1
  %P.4 = getelementptr i8, ptr %P, i64 4
  store i8 4, ptr %P.4
  tail call void @llvm.memcpy.inline.p0.p0.i64(ptr align 1 %P, ptr align 1 %Q, i64 4, i1 false)
  ret void
}

declare void @llvm.memcpy.inline.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64 immarg, i1 immarg)
