; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instsimplify -opaque-pointers < %s | FileCheck %s

define ptr @gep_zero_indices(ptr %p) {
; CHECK-LABEL: @gep_zero_indices(
; CHECK-NEXT:    ret ptr [[P:%.*]]
;
  %p2 = getelementptr { i64, i64 }, ptr %p, i64 0, i32 0
  ret ptr %p2
}

define ptr @gep_non_zero_indices1(ptr %p) {
; CHECK-LABEL: @gep_non_zero_indices1(
; CHECK-NEXT:    [[P2:%.*]] = getelementptr { i64, i64 }, ptr [[P:%.*]], i64 0, i32 1
; CHECK-NEXT:    ret ptr [[P2]]
;
  %p2 = getelementptr { i64, i64 }, ptr %p, i64 0, i32 1
  ret ptr %p2
}

define ptr @gep_non_zero_indices2(ptr %p) {
; CHECK-LABEL: @gep_non_zero_indices2(
; CHECK-NEXT:    [[P2:%.*]] = getelementptr { i64, i64 }, ptr [[P:%.*]], i64 1, i32 0
; CHECK-NEXT:    ret ptr [[P2]]
;
  %p2 = getelementptr { i64, i64 }, ptr %p, i64 1, i32 0
  ret ptr %p2
}

define <2 x ptr> @scalar_base_vector_index(ptr %p) {
; CHECK-LABEL: @scalar_base_vector_index(
; CHECK-NEXT:    [[G:%.*]] = getelementptr { i64, i64 }, ptr [[P:%.*]], <2 x i64> zeroinitializer, i32 0
; CHECK-NEXT:    ret <2 x ptr> [[G]]
;
  %g = getelementptr { i64, i64 }, ptr %p, <2 x i64> zeroinitializer, i32 0
  ret <2 x ptr> %g
}

define <2 x ptr> @vector_base_vector_index(<2 x ptr> %p) {
; CHECK-LABEL: @vector_base_vector_index(
; CHECK-NEXT:    ret <2 x ptr> [[P:%.*]]
;
  %g = getelementptr { i64, i64 }, <2 x ptr> %p, <2 x i64> zeroinitializer, i32 0
  ret <2 x ptr> %g
}

define <2 x ptr> @vector_base_scalar_index(<2 x ptr> %p) {
; CHECK-LABEL: @vector_base_scalar_index(
; CHECK-NEXT:    ret <2 x ptr> [[P:%.*]]
;
  %g = getelementptr { i64, i64 }, <2 x ptr> %p, i64 0, i32 0
  ret <2 x ptr> %g
}

@g = external global [2 x i32]

define ptr @constexpr_zero_gep_scalar_base_scalar_index() {
; CHECK-LABEL: @constexpr_zero_gep_scalar_base_scalar_index(
; CHECK-NEXT:    ret ptr @g
;
  ret ptr @g
}

define <2 x ptr> @constexpr_zero_gep_vector_base_scalar_index() {
; CHECK-LABEL: @constexpr_zero_gep_vector_base_scalar_index(
; CHECK-NEXT:    ret <2 x ptr> <ptr @g, ptr @g>
;
  ret <2 x ptr> getelementptr ([2 x i32], <2 x ptr> <ptr @g, ptr @g>, i64 0, i64 0)
}

define <2 x ptr> @constexpr_zero_gep_scalar_base_vector_index() {
; CHECK-LABEL: @constexpr_zero_gep_scalar_base_vector_index(
; CHECK-NEXT:    ret <2 x ptr> <ptr @g, ptr @g>
;
  ret <2 x ptr> getelementptr ([2 x i32], ptr @g, <2 x i64> zeroinitializer, i64 0)
}

define <2 x ptr> @constexpr_zero_gep_vector_base_vector_index() {
; CHECK-LABEL: @constexpr_zero_gep_vector_base_vector_index(
; CHECK-NEXT:    ret <2 x ptr> <ptr @g, ptr @g>
;
  ret <2 x ptr> getelementptr ([2 x i32], <2 x ptr> <ptr @g, ptr @g>, <2 x i64> zeroinitializer, i64 0)
}

define ptr @constexpr_undef_gep_scalar_base_scalar_index() {
; CHECK-LABEL: @constexpr_undef_gep_scalar_base_scalar_index(
; CHECK-NEXT:    ret ptr @g
;
  ret ptr getelementptr ([2 x i32], ptr @g, i64 0, i64 undef)
}

define <2 x ptr> @constexpr_undef_gep_vector_base_scalar_index() {
; CHECK-LABEL: @constexpr_undef_gep_vector_base_scalar_index(
; CHECK-NEXT:    ret <2 x ptr> <ptr @g, ptr @g>
;
  ret <2 x ptr> getelementptr ([2 x i32], <2 x ptr> <ptr @g, ptr @g>, i64 undef, i64 undef)
}

define <2 x ptr> @constexpr_undef_gep_scalar_base_vector_index() {
; CHECK-LABEL: @constexpr_undef_gep_scalar_base_vector_index(
; CHECK-NEXT:    ret <2 x ptr> <ptr @g, ptr @g>
;
  ret <2 x ptr> getelementptr ([2 x i32], ptr @g, <2 x i64> undef, i64 0)
}

define <2 x ptr> @constexpr_undef_gep_vector_base_vector_index() {
; CHECK-LABEL: @constexpr_undef_gep_vector_base_vector_index(
; CHECK-NEXT:    ret <2 x ptr> <ptr @g, ptr @g>
;
  ret <2 x ptr> getelementptr ([2 x i32], <2 x ptr> <ptr @g, ptr @g>, <2 x i64> undef, i64 0)
}
