// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: powerpc-registered-target
// RUN: %clang_cc1 -flax-vector-conversions=none -target-feature +altivec -target-feature +vsx \
// RUN:   -triple powerpc64-unknown-unknown -emit-llvm %s -o - | FileCheck %s
// RUN: %clang_cc1  -flax-vector-conversions=none -target-feature +altivec -target-feature +vsx \
// RUN:   -target-feature +power8-vector -triple powerpc64le-unknown-unknown \
// RUN:   -emit-llvm %s -o - | FileCheck %s -check-prefixes=CHECK,CHECK-P8
#include <altivec.h>

// CHECK-LABEL: @test1(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[__VEC_ADDR_I:%.*]] = alloca <8 x i16>, align 16
// CHECK-NEXT:    [[__OFFSET_ADDR_I1:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I2:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I3:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__OFFSET_ADDR_I:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[C_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[ST_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[LD_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[C:%.*]], ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store ptr [[ST:%.*]], ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store ptr [[LD:%.*]], ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    store i64 3, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    store ptr [[TMP0]], ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load i64, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i64 [[TMP3]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I]], ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = load <8 x i16>, ptr [[TMP4]], align 1
// CHECK-NEXT:    [[TMP7:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store <8 x i16> [[TMP6]], ptr [[TMP7]], align 16
// CHECK-NEXT:    [[TMP8:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    [[TMP9:%.*]] = load <8 x i16>, ptr [[TMP8]], align 16
// CHECK-NEXT:    [[TMP10:%.*]] = load ptr, ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store <8 x i16> [[TMP9]], ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    store i64 7, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    store ptr [[TMP10]], ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP11:%.*]] = load ptr, ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP13:%.*]] = load i64, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    [[ADD_PTR_I4:%.*]] = getelementptr inbounds i8, ptr [[TMP11]], i64 [[TMP13]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I4]], ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    [[TMP14:%.*]] = load <8 x i16>, ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    [[TMP15:%.*]] = load ptr, ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    store <8 x i16> [[TMP14]], ptr [[TMP15]], align 1
// CHECK-NEXT:    ret void
//
void test1(vector signed short *c, signed short *st, const signed short *ld) {
    *c = vec_xl(3ll, ld);
    vec_xst(*c, 7ll, st);
}

// CHECK-LABEL: @test2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[__VEC_ADDR_I:%.*]] = alloca <8 x i16>, align 16
// CHECK-NEXT:    [[__OFFSET_ADDR_I1:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I2:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I3:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__OFFSET_ADDR_I:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[C_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[ST_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[LD_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[C:%.*]], ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store ptr [[ST:%.*]], ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store ptr [[LD:%.*]], ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    store i64 3, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    store ptr [[TMP0]], ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load i64, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i64 [[TMP3]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I]], ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = load <8 x i16>, ptr [[TMP4]], align 1
// CHECK-NEXT:    [[TMP7:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store <8 x i16> [[TMP6]], ptr [[TMP7]], align 16
// CHECK-NEXT:    [[TMP8:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    [[TMP9:%.*]] = load <8 x i16>, ptr [[TMP8]], align 16
// CHECK-NEXT:    [[TMP10:%.*]] = load ptr, ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store <8 x i16> [[TMP9]], ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    store i64 7, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    store ptr [[TMP10]], ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP11:%.*]] = load ptr, ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP13:%.*]] = load i64, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    [[ADD_PTR_I4:%.*]] = getelementptr inbounds i8, ptr [[TMP11]], i64 [[TMP13]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I4]], ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    [[TMP14:%.*]] = load <8 x i16>, ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    [[TMP15:%.*]] = load ptr, ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    store <8 x i16> [[TMP14]], ptr [[TMP15]], align 1
// CHECK-NEXT:    ret void
//
void test2(vector unsigned short *c, unsigned short *st,
           const unsigned short *ld) {
    *c = vec_xl(3ll, ld);
    vec_xst(*c, 7ll, st);
}

// CHECK-LABEL: @test3(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[__VEC_ADDR_I:%.*]] = alloca <4 x i32>, align 16
// CHECK-NEXT:    [[__OFFSET_ADDR_I1:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I2:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I3:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__OFFSET_ADDR_I:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[C_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[ST_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[LD_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[C:%.*]], ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store ptr [[ST:%.*]], ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store ptr [[LD:%.*]], ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    store i64 3, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    store ptr [[TMP0]], ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load i64, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i64 [[TMP3]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I]], ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = load <4 x i32>, ptr [[TMP4]], align 1
// CHECK-NEXT:    [[TMP7:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store <4 x i32> [[TMP6]], ptr [[TMP7]], align 16
// CHECK-NEXT:    [[TMP8:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    [[TMP9:%.*]] = load <4 x i32>, ptr [[TMP8]], align 16
// CHECK-NEXT:    [[TMP10:%.*]] = load ptr, ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store <4 x i32> [[TMP9]], ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    store i64 7, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    store ptr [[TMP10]], ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP11:%.*]] = load ptr, ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP13:%.*]] = load i64, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    [[ADD_PTR_I4:%.*]] = getelementptr inbounds i8, ptr [[TMP11]], i64 [[TMP13]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I4]], ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    [[TMP14:%.*]] = load <4 x i32>, ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    [[TMP15:%.*]] = load ptr, ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    store <4 x i32> [[TMP14]], ptr [[TMP15]], align 1
// CHECK-NEXT:    ret void
//
void test3(vector signed int *c, signed int *st, const signed int *ld) {
    *c = vec_xl(3ll, ld);
    vec_xst(*c, 7ll, st);
}

// CHECK-LABEL: @test4(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[__VEC_ADDR_I:%.*]] = alloca <4 x i32>, align 16
// CHECK-NEXT:    [[__OFFSET_ADDR_I1:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I2:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I3:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__OFFSET_ADDR_I:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[C_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[ST_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[LD_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[C:%.*]], ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store ptr [[ST:%.*]], ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store ptr [[LD:%.*]], ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    store i64 3, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    store ptr [[TMP0]], ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load i64, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i64 [[TMP3]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I]], ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = load <4 x i32>, ptr [[TMP4]], align 1
// CHECK-NEXT:    [[TMP7:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store <4 x i32> [[TMP6]], ptr [[TMP7]], align 16
// CHECK-NEXT:    [[TMP8:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    [[TMP9:%.*]] = load <4 x i32>, ptr [[TMP8]], align 16
// CHECK-NEXT:    [[TMP10:%.*]] = load ptr, ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store <4 x i32> [[TMP9]], ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    store i64 7, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    store ptr [[TMP10]], ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP11:%.*]] = load ptr, ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP13:%.*]] = load i64, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    [[ADD_PTR_I4:%.*]] = getelementptr inbounds i8, ptr [[TMP11]], i64 [[TMP13]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I4]], ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    [[TMP14:%.*]] = load <4 x i32>, ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    [[TMP15:%.*]] = load ptr, ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    store <4 x i32> [[TMP14]], ptr [[TMP15]], align 1
// CHECK-NEXT:    ret void
//
void test4(vector unsigned int *c, unsigned int *st, const unsigned int *ld) {
    *c = vec_xl(3ll, ld);
    vec_xst(*c, 7ll, st);
}

// CHECK-LABEL: @test5(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[__VEC_ADDR_I:%.*]] = alloca <2 x i64>, align 16
// CHECK-NEXT:    [[__OFFSET_ADDR_I1:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I2:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I3:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__OFFSET_ADDR_I:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[C_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[ST_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[LD_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[C:%.*]], ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store ptr [[ST:%.*]], ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store ptr [[LD:%.*]], ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    store i64 3, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    store ptr [[TMP0]], ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load i64, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i64 [[TMP3]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I]], ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = load <2 x i64>, ptr [[TMP4]], align 1
// CHECK-NEXT:    [[TMP7:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store <2 x i64> [[TMP6]], ptr [[TMP7]], align 16
// CHECK-NEXT:    [[TMP8:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    [[TMP9:%.*]] = load <2 x i64>, ptr [[TMP8]], align 16
// CHECK-NEXT:    [[TMP10:%.*]] = load ptr, ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store <2 x i64> [[TMP9]], ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    store i64 7, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    store ptr [[TMP10]], ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP11:%.*]] = load ptr, ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP13:%.*]] = load i64, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    [[ADD_PTR_I4:%.*]] = getelementptr inbounds i8, ptr [[TMP11]], i64 [[TMP13]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I4]], ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    [[TMP14:%.*]] = load <2 x i64>, ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    [[TMP15:%.*]] = load ptr, ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    store <2 x i64> [[TMP14]], ptr [[TMP15]], align 1
// CHECK-NEXT:    ret void
//
void test5(vector signed long long *c, signed long long *st,
           const signed long long *ld) {
    *c = vec_xl(3ll, ld);
    vec_xst(*c, 7ll, st);
}

// CHECK-LABEL: @test6(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[__VEC_ADDR_I:%.*]] = alloca <2 x i64>, align 16
// CHECK-NEXT:    [[__OFFSET_ADDR_I1:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I2:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I3:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__OFFSET_ADDR_I:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[C_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[ST_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[LD_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[C:%.*]], ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store ptr [[ST:%.*]], ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store ptr [[LD:%.*]], ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    store i64 3, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    store ptr [[TMP0]], ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load i64, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i64 [[TMP3]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I]], ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = load <2 x i64>, ptr [[TMP4]], align 1
// CHECK-NEXT:    [[TMP7:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store <2 x i64> [[TMP6]], ptr [[TMP7]], align 16
// CHECK-NEXT:    [[TMP8:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    [[TMP9:%.*]] = load <2 x i64>, ptr [[TMP8]], align 16
// CHECK-NEXT:    [[TMP10:%.*]] = load ptr, ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store <2 x i64> [[TMP9]], ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    store i64 7, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    store ptr [[TMP10]], ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP11:%.*]] = load ptr, ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP13:%.*]] = load i64, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    [[ADD_PTR_I4:%.*]] = getelementptr inbounds i8, ptr [[TMP11]], i64 [[TMP13]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I4]], ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    [[TMP14:%.*]] = load <2 x i64>, ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    [[TMP15:%.*]] = load ptr, ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    store <2 x i64> [[TMP14]], ptr [[TMP15]], align 1
// CHECK-NEXT:    ret void
//
void test6(vector unsigned long long *c, unsigned long long *st,
           const unsigned long long *ld) {
    *c = vec_xl(3ll, ld);
    vec_xst(*c, 7ll, st);
}

// CHECK-LABEL: @test7(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[__VEC_ADDR_I:%.*]] = alloca <4 x float>, align 16
// CHECK-NEXT:    [[__OFFSET_ADDR_I1:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I2:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I3:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__OFFSET_ADDR_I:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[C_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[ST_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[LD_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[C:%.*]], ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store ptr [[ST:%.*]], ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store ptr [[LD:%.*]], ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    store i64 3, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    store ptr [[TMP0]], ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load i64, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i64 [[TMP3]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I]], ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = load <4 x float>, ptr [[TMP4]], align 1
// CHECK-NEXT:    [[TMP7:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store <4 x float> [[TMP6]], ptr [[TMP7]], align 16
// CHECK-NEXT:    [[TMP8:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    [[TMP9:%.*]] = load <4 x float>, ptr [[TMP8]], align 16
// CHECK-NEXT:    [[TMP10:%.*]] = load ptr, ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store <4 x float> [[TMP9]], ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    store i64 7, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    store ptr [[TMP10]], ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP11:%.*]] = load ptr, ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP13:%.*]] = load i64, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    [[ADD_PTR_I4:%.*]] = getelementptr inbounds i8, ptr [[TMP11]], i64 [[TMP13]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I4]], ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    [[TMP14:%.*]] = load <4 x float>, ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    [[TMP15:%.*]] = load ptr, ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    store <4 x float> [[TMP14]], ptr [[TMP15]], align 1
// CHECK-NEXT:    ret void
//
void test7(vector float *c, float *st, const float *ld) {
    *c = vec_xl(3ll, ld);
    vec_xst(*c, 7ll, st);
}

// CHECK-LABEL: @test8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[__VEC_ADDR_I:%.*]] = alloca <2 x double>, align 16
// CHECK-NEXT:    [[__OFFSET_ADDR_I1:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I2:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I3:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__OFFSET_ADDR_I:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[__PTR_ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[__ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[C_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[ST_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[LD_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[C:%.*]], ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store ptr [[ST:%.*]], ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store ptr [[LD:%.*]], ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[LD_ADDR]], align 8
// CHECK-NEXT:    store i64 3, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    store ptr [[TMP0]], ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[__PTR_ADDR_I]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load i64, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i64 [[TMP3]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I]], ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[__ADDR_I]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = load <2 x double>, ptr [[TMP4]], align 1
// CHECK-NEXT:    [[TMP7:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    store <2 x double> [[TMP6]], ptr [[TMP7]], align 16
// CHECK-NEXT:    [[TMP8:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-NEXT:    [[TMP9:%.*]] = load <2 x double>, ptr [[TMP8]], align 16
// CHECK-NEXT:    [[TMP10:%.*]] = load ptr, ptr [[ST_ADDR]], align 8
// CHECK-NEXT:    store <2 x double> [[TMP9]], ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    store i64 7, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    store ptr [[TMP10]], ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP11:%.*]] = load ptr, ptr [[__PTR_ADDR_I2]], align 8
// CHECK-NEXT:    [[TMP13:%.*]] = load i64, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-NEXT:    [[ADD_PTR_I4:%.*]] = getelementptr inbounds i8, ptr [[TMP11]], i64 [[TMP13]]
// CHECK-NEXT:    store ptr [[ADD_PTR_I4]], ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    [[TMP14:%.*]] = load <2 x double>, ptr [[__VEC_ADDR_I]], align 16
// CHECK-NEXT:    [[TMP15:%.*]] = load ptr, ptr [[__ADDR_I3]], align 8
// CHECK-NEXT:    store <2 x double> [[TMP14]], ptr [[TMP15]], align 1
// CHECK-NEXT:    ret void
//
void test8(vector double *c, double *st, const double *ld) {
    *c = vec_xl(3ll, ld);
    vec_xst(*c, 7ll, st);
}

#ifdef __POWER8_VECTOR__
// CHECK-P8-LABEL: @test9(
// CHECK-P8-NEXT:  entry:
// CHECK-P8-NEXT:    [[__VEC_ADDR_I:%.*]] = alloca <1 x i128>, align 16
// CHECK-P8-NEXT:    [[__OFFSET_ADDR_I1:%.*]] = alloca i64, align 8
// CHECK-P8-NEXT:    [[__PTR_ADDR_I2:%.*]] = alloca ptr, align 8
// CHECK-P8-NEXT:    [[__ADDR_I3:%.*]] = alloca ptr, align 8
// CHECK-P8-NEXT:    [[__OFFSET_ADDR_I:%.*]] = alloca i64, align 8
// CHECK-P8-NEXT:    [[__PTR_ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-P8-NEXT:    [[__ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-P8-NEXT:    [[C_ADDR:%.*]] = alloca ptr, align 8
// CHECK-P8-NEXT:    [[ST_ADDR:%.*]] = alloca ptr, align 8
// CHECK-P8-NEXT:    [[LD_ADDR:%.*]] = alloca ptr, align 8
// CHECK-P8-NEXT:    store ptr [[C:%.*]], ptr [[C_ADDR]], align 8
// CHECK-P8-NEXT:    store ptr [[ST:%.*]], ptr [[ST_ADDR]], align 8
// CHECK-P8-NEXT:    store ptr [[LD:%.*]], ptr [[LD_ADDR]], align 8
// CHECK-P8-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[LD_ADDR]], align 8
// CHECK-P8-NEXT:    store i64 3, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-P8-NEXT:    store ptr [[TMP0]], ptr [[__PTR_ADDR_I]], align 8
// CHECK-P8-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[__PTR_ADDR_I]], align 8
// CHECK-P8-NEXT:    [[TMP3:%.*]] = load i64, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-P8-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i64 [[TMP3]]
// CHECK-P8-NEXT:    store ptr [[ADD_PTR_I]], ptr [[__ADDR_I]], align 8
// CHECK-P8-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[__ADDR_I]], align 8
// CHECK-P8-NEXT:    [[TMP6:%.*]] = load <1 x i128>, ptr [[TMP4]], align 1
// CHECK-P8-NEXT:    [[TMP7:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-P8-NEXT:    store <1 x i128> [[TMP6]], ptr [[TMP7]], align 16
// CHECK-P8-NEXT:    [[TMP8:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-P8-NEXT:    [[TMP9:%.*]] = load <1 x i128>, ptr [[TMP8]], align 16
// CHECK-P8-NEXT:    [[TMP10:%.*]] = load ptr, ptr [[ST_ADDR]], align 8
// CHECK-P8-NEXT:    store <1 x i128> [[TMP9]], ptr [[__VEC_ADDR_I]], align 16
// CHECK-P8-NEXT:    store i64 7, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-P8-NEXT:    store ptr [[TMP10]], ptr [[__PTR_ADDR_I2]], align 8
// CHECK-P8-NEXT:    [[TMP11:%.*]] = load ptr, ptr [[__PTR_ADDR_I2]], align 8
// CHECK-P8-NEXT:    [[TMP13:%.*]] = load i64, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-P8-NEXT:    [[ADD_PTR_I4:%.*]] = getelementptr inbounds i8, ptr [[TMP11]], i64 [[TMP13]]
// CHECK-P8-NEXT:    store ptr [[ADD_PTR_I4]], ptr [[__ADDR_I3]], align 8
// CHECK-P8-NEXT:    [[TMP14:%.*]] = load <1 x i128>, ptr [[__VEC_ADDR_I]], align 16
// CHECK-P8-NEXT:    [[TMP15:%.*]] = load ptr, ptr [[__ADDR_I3]], align 8
// CHECK-P8-NEXT:    store <1 x i128> [[TMP14]], ptr [[TMP15]], align 1
// CHECK-P8-NEXT:    ret void
//
void test9(vector signed __int128 *c, signed __int128 *st,
           const signed __int128 *ld) {
    *c = vec_xl(3ll, ld);
    vec_xst(*c, 7ll, st);
}

// CHECK-P8-LABEL: @test10(
// CHECK-P8-NEXT:  entry:
// CHECK-P8-NEXT:    [[__VEC_ADDR_I:%.*]] = alloca <1 x i128>, align 16
// CHECK-P8-NEXT:    [[__OFFSET_ADDR_I1:%.*]] = alloca i64, align 8
// CHECK-P8-NEXT:    [[__PTR_ADDR_I2:%.*]] = alloca ptr, align 8
// CHECK-P8-NEXT:    [[__ADDR_I3:%.*]] = alloca ptr, align 8
// CHECK-P8-NEXT:    [[__OFFSET_ADDR_I:%.*]] = alloca i64, align 8
// CHECK-P8-NEXT:    [[__PTR_ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-P8-NEXT:    [[__ADDR_I:%.*]] = alloca ptr, align 8
// CHECK-P8-NEXT:    [[C_ADDR:%.*]] = alloca ptr, align 8
// CHECK-P8-NEXT:    [[ST_ADDR:%.*]] = alloca ptr, align 8
// CHECK-P8-NEXT:    [[LD_ADDR:%.*]] = alloca ptr, align 8
// CHECK-P8-NEXT:    store ptr [[C:%.*]], ptr [[C_ADDR]], align 8
// CHECK-P8-NEXT:    store ptr [[ST:%.*]], ptr [[ST_ADDR]], align 8
// CHECK-P8-NEXT:    store ptr [[LD:%.*]], ptr [[LD_ADDR]], align 8
// CHECK-P8-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[LD_ADDR]], align 8
// CHECK-P8-NEXT:    store i64 3, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-P8-NEXT:    store ptr [[TMP0]], ptr [[__PTR_ADDR_I]], align 8
// CHECK-P8-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[__PTR_ADDR_I]], align 8
// CHECK-P8-NEXT:    [[TMP3:%.*]] = load i64, ptr [[__OFFSET_ADDR_I]], align 8
// CHECK-P8-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, ptr [[TMP1]], i64 [[TMP3]]
// CHECK-P8-NEXT:    store ptr [[ADD_PTR_I]], ptr [[__ADDR_I]], align 8
// CHECK-P8-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[__ADDR_I]], align 8
// CHECK-P8-NEXT:    [[TMP6:%.*]] = load <1 x i128>, ptr [[TMP4]], align 1
// CHECK-P8-NEXT:    [[TMP7:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-P8-NEXT:    store <1 x i128> [[TMP6]], ptr [[TMP7]], align 16
// CHECK-P8-NEXT:    [[TMP8:%.*]] = load ptr, ptr [[C_ADDR]], align 8
// CHECK-P8-NEXT:    [[TMP9:%.*]] = load <1 x i128>, ptr [[TMP8]], align 16
// CHECK-P8-NEXT:    [[TMP10:%.*]] = load ptr, ptr [[ST_ADDR]], align 8
// CHECK-P8-NEXT:    store <1 x i128> [[TMP9]], ptr [[__VEC_ADDR_I]], align 16
// CHECK-P8-NEXT:    store i64 7, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-P8-NEXT:    store ptr [[TMP10]], ptr [[__PTR_ADDR_I2]], align 8
// CHECK-P8-NEXT:    [[TMP11:%.*]] = load ptr, ptr [[__PTR_ADDR_I2]], align 8
// CHECK-P8-NEXT:    [[TMP13:%.*]] = load i64, ptr [[__OFFSET_ADDR_I1]], align 8
// CHECK-P8-NEXT:    [[ADD_PTR_I4:%.*]] = getelementptr inbounds i8, ptr [[TMP11]], i64 [[TMP13]]
// CHECK-P8-NEXT:    store ptr [[ADD_PTR_I4]], ptr [[__ADDR_I3]], align 8
// CHECK-P8-NEXT:    [[TMP14:%.*]] = load <1 x i128>, ptr [[__VEC_ADDR_I]], align 16
// CHECK-P8-NEXT:    [[TMP15:%.*]] = load ptr, ptr [[__ADDR_I3]], align 8
// CHECK-P8-NEXT:    store <1 x i128> [[TMP14]], ptr [[TMP15]], align 1
// CHECK-P8-NEXT:    ret void
//
void test10(vector unsigned __int128 *c, unsigned __int128 *st,
            const unsigned __int128 *ld) {
    *c = vec_xl(3ll, ld);
    vec_xst(*c, 7ll, st);
}
#endif
