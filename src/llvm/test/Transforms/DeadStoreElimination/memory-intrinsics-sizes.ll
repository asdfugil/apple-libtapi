; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -dse -S %s | FileCheck %s

define void @memset_equal_size_values(ptr %ptr, i64 %len) {
; CHECK-LABEL: @memset_equal_size_values(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[PTR:%.*]], i8 0, i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.p0.i64(ptr align 1 %ptr, i8 0, i64 %len, i1 false)
  call void @llvm.memset.p0.i64(ptr align 1 %ptr, i8 0, i64 %len, i1 false)
  ret void
}

define void @memset_different_size_values_1(ptr %ptr, i64 %len.1, i64 %len.2) {
; CHECK-LABEL: @memset_different_size_values_1(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[PTR:%.*]], i8 0, i64 [[LEN_1:%.*]], i1 false)
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[PTR]], i8 0, i64 [[LEN_2:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.p0.i64(ptr align 1 %ptr, i8 0, i64 %len.1, i1 false)
  call void @llvm.memset.p0.i64(ptr align 1 %ptr, i8 0, i64 %len.2, i1 false)
  ret void
}

define void @memset_different_size_values_2(ptr %ptr, i64 %len) {
; CHECK-LABEL: @memset_different_size_values_2(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[PTR:%.*]], i8 0, i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[PTR]], i8 0, i64 100, i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.p0.i64(ptr align 1 %ptr, i8 0, i64 %len, i1 false)
  call void @llvm.memset.p0.i64(ptr align 1 %ptr, i8 0, i64 100, i1 false)
  ret void
}

define void @memset_different_size_values_3(ptr %ptr, i64 %len) {
; CHECK-LABEL: @memset_different_size_values_3(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[PTR:%.*]], i8 0, i64 100, i1 false)
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[PTR]], i8 0, i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.p0.i64(ptr align 1 %ptr, i8 0, i64 100, i1 false)
  call void @llvm.memset.p0.i64(ptr align 1 %ptr, i8 0, i64 %len, i1 false)
  ret void
}

define void @memset_and_store_1(ptr %ptr, i64 %len) {
; CHECK-LABEL: @memset_and_store_1(
; CHECK-NEXT:    store i64 123, ptr [[PTR:%.*]], align 4
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[PTR]], i8 0, i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  store i64 123, ptr %ptr
  call void @llvm.memset.p0.i64(ptr align 1 %ptr, i8 0, i64 %len, i1 false)
  ret void
}

define void @memset_and_store_2(ptr %ptr, i64 %len) {
; CHECK-LABEL: @memset_and_store_2(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[PTR:%.*]], i8 0, i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    store i64 123, ptr [[PTR]], align 4
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.p0.i64(ptr align 1 %ptr, i8 0, i64 %len, i1 false)
  store i64 123, ptr %ptr
  ret void
}

define void @memcpy_equal_size_values(ptr noalias %src, ptr noalias %dst, i64 %len) {
; CHECK-LABEL: @memcpy_equal_size_values(
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  ret void
}

define void @memcpy_different_size_values_1(ptr noalias %src, ptr noalias %dst, i64 %len.1, i64 %len.2) {
; CHECK-LABEL: @memcpy_different_size_values_1(
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 [[LEN_1:%.*]], i1 false)
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[DST]], ptr [[SRC]], i64 [[LEN_2:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 %len.1, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 %len.2, i1 false)
  ret void
}

define void @memcpy_different_size_values_2(ptr noalias %src, ptr noalias %dst, i64 %len) {
; CHECK-LABEL: @memcpy_different_size_values_2(
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[DST]], ptr [[SRC]], i64 100, i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 100, i1 false)
  ret void
}

define void @memcpy_different_size_values_3(ptr noalias %src, ptr noalias %dst, i64 %len) {
; CHECK-LABEL: @memcpy_different_size_values_3(
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 100, i1 false)
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[DST]], ptr [[SRC]], i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 100, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  ret void
}

define void @memset_and_memcpy_equal_size_values(ptr noalias %src, ptr noalias %dst, i64 %len) {
; CHECK-LABEL: @memset_and_memcpy_equal_size_values(
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 %len, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  ret void
}

define void @memset_and_memcpy_different_size_values_1(ptr noalias %src, ptr noalias %dst, i64 %len.1, i64 %len.2) {
; CHECK-LABEL: @memset_and_memcpy_different_size_values_1(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[DST:%.*]], i8 0, i64 [[LEN_1:%.*]], i1 false)
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[DST]], ptr [[SRC:%.*]], i64 [[LEN_2:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 %len.1, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 %len.2, i1 false)
  ret void
}

define void @memset_and_memcpy_different_size_values_2(ptr noalias %src, ptr noalias %dst, i64 %len.1) {
; CHECK-LABEL: @memset_and_memcpy_different_size_values_2(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[DST:%.*]], i8 0, i64 [[LEN_1:%.*]], i1 false)
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[DST]], ptr [[SRC:%.*]], i64 100, i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 %len.1, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 100, i1 false)
  ret void
}

define void @memset_and_memcpy_different_size_values_3(ptr noalias %src, ptr noalias %dst, i64 %len.1) {
; CHECK-LABEL: @memset_and_memcpy_different_size_values_3(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[DST:%.*]], i8 0, i64 100, i1 false)
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[DST]], ptr [[SRC:%.*]], i64 [[LEN_1:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 100, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 %len.1, i1 false)
  ret void
}

define void @memcpy_and_memset_equal_size_values(ptr noalias %src, ptr noalias %dst, i64 %len) {
; CHECK-LABEL: @memcpy_and_memset_equal_size_values(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[DST:%.*]], i8 0, i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 %len, i1 false)
  ret void
}

define void @memcpy_and_memset_different_size_values_1(ptr noalias %src, ptr noalias %dst, i64 %len.1, i64 %len.2) {
; CHECK-LABEL: @memcpy_and_memset_different_size_values_1(
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 [[LEN_1:%.*]], i1 false)
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[DST]], i8 0, i64 [[LEN_2:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 %len.1, i1 false)
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 %len.2, i1 false)
  ret void
}

define void @memcpy_and_memset_different_size_values_2(ptr noalias %src, ptr noalias %dst, i64 %len.1) {
; CHECK-LABEL: @memcpy_and_memset_different_size_values_2(
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 [[LEN_1:%.*]], i1 false)
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[DST]], i8 0, i64 100, i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 %len.1, i1 false)
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 100, i1 false)
  ret void
}

define void @memcpy_and_memset_different_size_values_3(ptr noalias %src, ptr noalias %dst, i64 %len.1) {
; CHECK-LABEL: @memcpy_and_memset_different_size_values_3(
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 100, i1 false)
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[DST]], i8 0, i64 [[LEN_1:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 100, i1 false)
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 %len.1, i1 false)
  ret void
}

define void @memmove_equal_size_values(ptr noalias %src, ptr noalias %dst, i64 %len) {
; CHECK-LABEL: @memmove_equal_size_values(
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  ret void
}

define void @memmove_different_size_values_1(ptr noalias %src, ptr noalias %dst, i64 %len.1, i64 %len.2) {
; CHECK-LABEL: @memmove_different_size_values_1(
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 [[LEN_1:%.*]], i1 false)
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i64(ptr [[DST]], ptr [[SRC]], i64 [[LEN_2:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 %len.1, i1 false)
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 %len.2, i1 false)
  ret void
}

define void @memmove_different_size_values_2(ptr noalias %src, ptr noalias %dst, i64 %len) {
; CHECK-LABEL: @memmove_different_size_values_2(
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i64(ptr [[DST]], ptr [[SRC]], i64 100, i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 100, i1 false)
  ret void
}

define void @memmove_different_size_values_3(ptr noalias %src, ptr noalias %dst, i64 %len) {
; CHECK-LABEL: @memmove_different_size_values_3(
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 100, i1 false)
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i64(ptr [[DST]], ptr [[SRC]], i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 100, i1 false)
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  ret void
}

define void @memset_and_memmove_equal_size_values(ptr noalias %src, ptr noalias %dst, i64 %len) {
; CHECK-LABEL: @memset_and_memmove_equal_size_values(
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 %len, i1 false)
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  ret void
}

define void @memset_and_memmove_different_size_values_1(ptr noalias %src, ptr noalias %dst, i64 %len.1, i64 %len.2) {
; CHECK-LABEL: @memset_and_memmove_different_size_values_1(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[DST:%.*]], i8 0, i64 [[LEN_1:%.*]], i1 false)
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i64(ptr [[DST]], ptr [[SRC:%.*]], i64 [[LEN_2:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 %len.1, i1 false)
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 %len.2, i1 false)
  ret void
}

define void @memset_and_memmove_different_size_values_2(ptr noalias %src, ptr noalias %dst, i64 %len.1) {
; CHECK-LABEL: @memset_and_memmove_different_size_values_2(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[DST:%.*]], i8 0, i64 [[LEN_1:%.*]], i1 false)
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i64(ptr [[DST]], ptr [[SRC:%.*]], i64 100, i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 %len.1, i1 false)
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 100, i1 false)
  ret void
}

define void @memset_and_memmove_different_size_values_3(ptr noalias %src, ptr noalias %dst, i64 %len.1) {
; CHECK-LABEL: @memset_and_memmove_different_size_values_3(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[DST:%.*]], i8 0, i64 100, i1 false)
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i64(ptr [[DST]], ptr [[SRC:%.*]], i64 [[LEN_1:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 100, i1 false)
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 %len.1, i1 false)
  ret void
}

define void @memmove_and_memset_equal_size_values(ptr noalias %src, ptr noalias %dst, i64 %len) {
; CHECK-LABEL: @memmove_and_memset_equal_size_values(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[DST:%.*]], i8 0, i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 %len, i1 false)
  ret void
}

define void @memmove_and_memset_different_size_values_1(ptr noalias %src, ptr noalias %dst, i64 %len.1, i64 %len.2) {
; CHECK-LABEL: @memmove_and_memset_different_size_values_1(
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 [[LEN_1:%.*]], i1 false)
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[DST]], i8 0, i64 [[LEN_2:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 %len.1, i1 false)
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 %len.2, i1 false)
  ret void
}

define void @memmove_and_memset_different_size_values_2(ptr noalias %src, ptr noalias %dst, i64 %len.1) {
; CHECK-LABEL: @memmove_and_memset_different_size_values_2(
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 [[LEN_1:%.*]], i1 false)
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[DST]], i8 0, i64 100, i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 %len.1, i1 false)
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 100, i1 false)
  ret void
}

define void @memmove_and_memset_different_size_values_3(ptr noalias %src, ptr noalias %dst, i64 %len.1) {
; CHECK-LABEL: @memmove_and_memset_different_size_values_3(
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 100, i1 false)
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[DST]], i8 0, i64 [[LEN_1:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 100, i1 false)
  call void @llvm.memset.p0.i64(ptr align 1 %dst, i8 0, i64 %len.1, i1 false)
  ret void
}

define void @memmove_and_memcpy_equal_size_values(ptr noalias %src, ptr noalias %dst, i64 %len) {
; CHECK-LABEL: @memmove_and_memcpy_equal_size_values(
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  ret void
}

define void @memcpy_and_memmove_equal_size_values(ptr noalias %src, ptr noalias %dst, i64 %len) {
; CHECK-LABEL: @memcpy_and_memmove_equal_size_values(
; CHECK-NEXT:    call void @llvm.memmove.p0.p0.i64(ptr [[DST:%.*]], ptr [[SRC:%.*]], i64 [[LEN:%.*]], i1 false)
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  call void @llvm.memmove.p0.p0.i64(ptr %dst, ptr %src, i64 %len, i1 false)
  ret void
}

declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg)
declare void @llvm.memcpy.p0.p0.i64(ptr nocapture, ptr nocapture, i64, i1)
declare void @llvm.memmove.p0.p0.i64(ptr nocapture, ptr nocapture, i64, i1)
