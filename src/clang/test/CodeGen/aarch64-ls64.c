// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -no-opaque-pointers -triple aarch64-eabi -target-feature +ls64 -S -emit-llvm -x c %s -o - | FileCheck --check-prefixes=CHECK-C %s
// RUN: %clang_cc1 -no-opaque-pointers -triple aarch64-eabi -target-feature +ls64 -S -emit-llvm -x c++ %s -o - | FileCheck --check-prefixes=CHECK-CXX %s
// RUN: %clang_cc1 -no-opaque-pointers -triple aarch64_be-eabi -target-feature +ls64 -S -emit-llvm -x c %s -o - | FileCheck  --check-prefixes=CHECK-C %s
// RUN: %clang_cc1 -no-opaque-pointers -triple aarch64_be-eabi -target-feature +ls64 -S -emit-llvm -x c++ %s -o - | FileCheck  --check-prefixes=CHECK-CXX %s

#include <arm_acle.h>

#ifdef __cplusplus
#define EXTERN_C extern "C"
#else
#define EXTERN_C
#endif

data512_t val;
void *addr;
uint64_t status;

// CHECK-C-LABEL: @test_ld64b(
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    [[__ADDR_ADDR_I:%.*]] = alloca i8*, align 8
// CHECK-C-NEXT:    [[TMP:%.*]] = alloca [[STRUCT_DATA512_T:%.*]], align 8
// CHECK-C-NEXT:    [[TMP0:%.*]] = load i8*, i8** @addr, align 8
// CHECK-C-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata [[META2:![0-9]+]])
// CHECK-C-NEXT:    store i8* [[TMP0]], i8** [[__ADDR_ADDR_I]], align 8, !noalias !2
// CHECK-C-NEXT:    [[TMP1:%.*]] = load i8*, i8** [[__ADDR_ADDR_I]], align 8, !noalias !2
// CHECK-C-NEXT:    [[VAL_I:%.*]] = getelementptr inbounds [[STRUCT_DATA512_T]], %struct.data512_t* [[TMP]], i32 0, i32 0
// CHECK-C-NEXT:    [[ARRAYDECAY_I:%.*]] = getelementptr inbounds [8 x i64], [8 x i64]* [[VAL_I]], i64 0, i64 0
// CHECK-C-NEXT:    [[TMP2:%.*]] = call { i64, i64, i64, i64, i64, i64, i64, i64 } @llvm.aarch64.ld64b(i8* [[TMP1]]), !noalias !2
// CHECK-C-NEXT:    [[TMP3:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 0
// CHECK-C-NEXT:    store i64 [[TMP3]], i64* [[ARRAYDECAY_I]], align 8, !alias.scope !2
// CHECK-C-NEXT:    [[TMP4:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 1
// CHECK-C-NEXT:    [[TMP5:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 1
// CHECK-C-NEXT:    store i64 [[TMP5]], i64* [[TMP4]], align 8, !alias.scope !2
// CHECK-C-NEXT:    [[TMP6:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 2
// CHECK-C-NEXT:    [[TMP7:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 2
// CHECK-C-NEXT:    store i64 [[TMP7]], i64* [[TMP6]], align 8, !alias.scope !2
// CHECK-C-NEXT:    [[TMP8:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 3
// CHECK-C-NEXT:    [[TMP9:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 3
// CHECK-C-NEXT:    store i64 [[TMP9]], i64* [[TMP8]], align 8, !alias.scope !2
// CHECK-C-NEXT:    [[TMP10:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 4
// CHECK-C-NEXT:    [[TMP11:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 4
// CHECK-C-NEXT:    store i64 [[TMP11]], i64* [[TMP10]], align 8, !alias.scope !2
// CHECK-C-NEXT:    [[TMP12:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 5
// CHECK-C-NEXT:    [[TMP13:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 5
// CHECK-C-NEXT:    store i64 [[TMP13]], i64* [[TMP12]], align 8, !alias.scope !2
// CHECK-C-NEXT:    [[TMP14:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 6
// CHECK-C-NEXT:    [[TMP15:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 6
// CHECK-C-NEXT:    store i64 [[TMP15]], i64* [[TMP14]], align 8, !alias.scope !2
// CHECK-C-NEXT:    [[TMP16:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 7
// CHECK-C-NEXT:    [[TMP17:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 7
// CHECK-C-NEXT:    store i64 [[TMP17]], i64* [[TMP16]], align 8, !alias.scope !2
// CHECK-C-NEXT:    [[TMP18:%.*]] = bitcast %struct.data512_t* [[TMP]] to i8*
// CHECK-C-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 bitcast (%struct.data512_t* @val to i8*), i8* align 8 [[TMP18]], i64 64, i1 false)
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: @test_ld64b(
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[__ADDR_ADDR_I:%.*]] = alloca i8*, align 8
// CHECK-CXX-NEXT:    [[REF_TMP:%.*]] = alloca [[STRUCT_DATA512_T:%.*]], align 8
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = load i8*, i8** @addr, align 8
// CHECK-CXX-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata [[META2:![0-9]+]])
// CHECK-CXX-NEXT:    store i8* [[TMP0]], i8** [[__ADDR_ADDR_I]], align 8, !noalias !2
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = load i8*, i8** [[__ADDR_ADDR_I]], align 8, !noalias !2
// CHECK-CXX-NEXT:    [[VAL_I:%.*]] = getelementptr inbounds [[STRUCT_DATA512_T]], %struct.data512_t* [[REF_TMP]], i32 0, i32 0
// CHECK-CXX-NEXT:    [[ARRAYDECAY_I:%.*]] = getelementptr inbounds [8 x i64], [8 x i64]* [[VAL_I]], i64 0, i64 0
// CHECK-CXX-NEXT:    [[TMP2:%.*]] = call { i64, i64, i64, i64, i64, i64, i64, i64 } @llvm.aarch64.ld64b(i8* [[TMP1]]), !noalias !2
// CHECK-CXX-NEXT:    [[TMP3:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 0
// CHECK-CXX-NEXT:    store i64 [[TMP3]], i64* [[ARRAYDECAY_I]], align 8, !alias.scope !2
// CHECK-CXX-NEXT:    [[TMP4:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 1
// CHECK-CXX-NEXT:    [[TMP5:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 1
// CHECK-CXX-NEXT:    store i64 [[TMP5]], i64* [[TMP4]], align 8, !alias.scope !2
// CHECK-CXX-NEXT:    [[TMP6:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 2
// CHECK-CXX-NEXT:    [[TMP7:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 2
// CHECK-CXX-NEXT:    store i64 [[TMP7]], i64* [[TMP6]], align 8, !alias.scope !2
// CHECK-CXX-NEXT:    [[TMP8:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 3
// CHECK-CXX-NEXT:    [[TMP9:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 3
// CHECK-CXX-NEXT:    store i64 [[TMP9]], i64* [[TMP8]], align 8, !alias.scope !2
// CHECK-CXX-NEXT:    [[TMP10:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 4
// CHECK-CXX-NEXT:    [[TMP11:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 4
// CHECK-CXX-NEXT:    store i64 [[TMP11]], i64* [[TMP10]], align 8, !alias.scope !2
// CHECK-CXX-NEXT:    [[TMP12:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 5
// CHECK-CXX-NEXT:    [[TMP13:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 5
// CHECK-CXX-NEXT:    store i64 [[TMP13]], i64* [[TMP12]], align 8, !alias.scope !2
// CHECK-CXX-NEXT:    [[TMP14:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 6
// CHECK-CXX-NEXT:    [[TMP15:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 6
// CHECK-CXX-NEXT:    store i64 [[TMP15]], i64* [[TMP14]], align 8, !alias.scope !2
// CHECK-CXX-NEXT:    [[TMP16:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 7
// CHECK-CXX-NEXT:    [[TMP17:%.*]] = extractvalue { i64, i64, i64, i64, i64, i64, i64, i64 } [[TMP2]], 7
// CHECK-CXX-NEXT:    store i64 [[TMP17]], i64* [[TMP16]], align 8, !alias.scope !2
// CHECK-CXX-NEXT:    [[TMP18:%.*]] = bitcast %struct.data512_t* [[REF_TMP]] to i8*
// CHECK-CXX-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 bitcast (%struct.data512_t* @val to i8*), i8* align 8 [[TMP18]], i64 64, i1 false)
// CHECK-CXX-NEXT:    ret void
//
EXTERN_C void test_ld64b(void)
{
    val = __arm_ld64b(addr);
}

// CHECK-C-LABEL: @test_st64b(
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    [[__ADDR_ADDR_I:%.*]] = alloca i8*, align 8
// CHECK-C-NEXT:    [[VALUE_INDIRECT_ADDR:%.*]] = alloca [[INDIRECT_ADDR_TY:.*]], align 8
// CHECK-C-NEXT:    [[BYVAL_TEMP:%.*]] = alloca [[STRUCT_DATA512_T:%.*]], align 8
// CHECK-C-NEXT:    [[TMP0:%.*]] = load i8*, i8** @addr, align 8
// CHECK-C-NEXT:    [[TMP1:%.*]] = bitcast %struct.data512_t* [[BYVAL_TEMP]] to i8*
// CHECK-C-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 [[TMP1]], i8* align 8 bitcast (%struct.data512_t* @val to i8*), i64 64, i1 false)
// CHECK-C-NEXT:    store i8* [[TMP0]], i8** [[__ADDR_ADDR_I]], align 8
// CHECK-C-NEXT:    store [[INDIRECT_ADDR_TY]] [[BYVAL_TEMP]], [[INDIRECT_ADDR_TY]]* [[VALUE_INDIRECT_ADDR]], align 8
// CHECK-C-NEXT:    [[TMP2:%.*]] = load i8*, i8** [[__ADDR_ADDR_I]], align 8
// CHECK-C-NEXT:    [[VAL_I:%.*]] = getelementptr inbounds [[STRUCT_DATA512_T]], %struct.data512_t* [[BYVAL_TEMP]], i32 0, i32 0
// CHECK-C-NEXT:    [[ARRAYDECAY_I:%.*]] = getelementptr inbounds [8 x i64], [8 x i64]* [[VAL_I]], i64 0, i64 0
// CHECK-C-NEXT:    [[TMP3:%.*]] = load i64, i64* [[ARRAYDECAY_I]], align 8
// CHECK-C-NEXT:    [[TMP4:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 1
// CHECK-C-NEXT:    [[TMP5:%.*]] = load i64, i64* [[TMP4]], align 8
// CHECK-C-NEXT:    [[TMP6:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 2
// CHECK-C-NEXT:    [[TMP7:%.*]] = load i64, i64* [[TMP6]], align 8
// CHECK-C-NEXT:    [[TMP8:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 3
// CHECK-C-NEXT:    [[TMP9:%.*]] = load i64, i64* [[TMP8]], align 8
// CHECK-C-NEXT:    [[TMP10:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 4
// CHECK-C-NEXT:    [[TMP11:%.*]] = load i64, i64* [[TMP10]], align 8
// CHECK-C-NEXT:    [[TMP12:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 5
// CHECK-C-NEXT:    [[TMP13:%.*]] = load i64, i64* [[TMP12]], align 8
// CHECK-C-NEXT:    [[TMP14:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 6
// CHECK-C-NEXT:    [[TMP15:%.*]] = load i64, i64* [[TMP14]], align 8
// CHECK-C-NEXT:    [[TMP16:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 7
// CHECK-C-NEXT:    [[TMP17:%.*]] = load i64, i64* [[TMP16]], align 8
// CHECK-C-NEXT:    call void @llvm.aarch64.st64b(i8* [[TMP2]], i64 [[TMP3]], i64 [[TMP5]], i64 [[TMP7]], i64 [[TMP9]], i64 [[TMP11]], i64 [[TMP13]], i64 [[TMP15]], i64 [[TMP17]])
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: @test_st64b(
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[__ADDR_ADDR_I:%.*]] = alloca i8*, align 8
// CHECK-CXX-NEXT:    [[VALUE_INDIRECT_ADDR:%.*]] = alloca [[INDIRECT_ADDR_TY:.*]], align 8
// CHECK-CXX-NEXT:    [[AGG_TMP:%.*]] = alloca [[STRUCT_DATA512_T:%.*]], align 8
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = load i8*, i8** @addr, align 8
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = bitcast %struct.data512_t* [[AGG_TMP]] to i8*
// CHECK-CXX-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 [[TMP1]], i8* align 8 bitcast (%struct.data512_t* @val to i8*), i64 64, i1 false)
// CHECK-CXX-NEXT:    store i8* [[TMP0]], i8** [[__ADDR_ADDR_I]], align 8
// CHECK-CXX-NEXT:    store [[INDIRECT_ADDR_TY]] [[AGG_TMP]], [[INDIRECT_ADDR_TY]]* [[VALUE_INDIRECT_ADDR]], align 8
// CHECK-CXX-NEXT:    [[TMP2:%.*]] = load i8*, i8** [[__ADDR_ADDR_I]], align 8
// CHECK-CXX-NEXT:    [[VAL_I:%.*]] = getelementptr inbounds [[STRUCT_DATA512_T]], %struct.data512_t* [[AGG_TMP]], i32 0, i32 0
// CHECK-CXX-NEXT:    [[ARRAYDECAY_I:%.*]] = getelementptr inbounds [8 x i64], [8 x i64]* [[VAL_I]], i64 0, i64 0
// CHECK-CXX-NEXT:    [[TMP3:%.*]] = load i64, i64* [[ARRAYDECAY_I]], align 8
// CHECK-CXX-NEXT:    [[TMP4:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 1
// CHECK-CXX-NEXT:    [[TMP5:%.*]] = load i64, i64* [[TMP4]], align 8
// CHECK-CXX-NEXT:    [[TMP6:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 2
// CHECK-CXX-NEXT:    [[TMP7:%.*]] = load i64, i64* [[TMP6]], align 8
// CHECK-CXX-NEXT:    [[TMP8:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 3
// CHECK-CXX-NEXT:    [[TMP9:%.*]] = load i64, i64* [[TMP8]], align 8
// CHECK-CXX-NEXT:    [[TMP10:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 4
// CHECK-CXX-NEXT:    [[TMP11:%.*]] = load i64, i64* [[TMP10]], align 8
// CHECK-CXX-NEXT:    [[TMP12:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 5
// CHECK-CXX-NEXT:    [[TMP13:%.*]] = load i64, i64* [[TMP12]], align 8
// CHECK-CXX-NEXT:    [[TMP14:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 6
// CHECK-CXX-NEXT:    [[TMP15:%.*]] = load i64, i64* [[TMP14]], align 8
// CHECK-CXX-NEXT:    [[TMP16:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 7
// CHECK-CXX-NEXT:    [[TMP17:%.*]] = load i64, i64* [[TMP16]], align 8
// CHECK-CXX-NEXT:    call void @llvm.aarch64.st64b(i8* [[TMP2]], i64 [[TMP3]], i64 [[TMP5]], i64 [[TMP7]], i64 [[TMP9]], i64 [[TMP11]], i64 [[TMP13]], i64 [[TMP15]], i64 [[TMP17]])
// CHECK-CXX-NEXT:    ret void
//
EXTERN_C void test_st64b(void)
{
    __arm_st64b(addr, val);
}

// CHECK-C-LABEL: @test_st64bv(
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    [[__ADDR_ADDR_I:%.*]] = alloca i8*, align 8
// CHECK-C-NEXT:    [[VALUE_INDIRECT_ADDR:%.*]] = alloca [[INDIRECT_ADDR_TY]], align 8
// CHECK-C-NEXT:    [[BYVAL_TEMP:%.*]] = alloca [[STRUCT_DATA512_T:%.*]], align 8
// CHECK-C-NEXT:    [[TMP0:%.*]] = load i8*, i8** @addr, align 8
// CHECK-C-NEXT:    [[TMP1:%.*]] = bitcast %struct.data512_t* [[BYVAL_TEMP]] to i8*
// CHECK-C-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 [[TMP1]], i8* align 8 bitcast (%struct.data512_t* @val to i8*), i64 64, i1 false)
// CHECK-C-NEXT:    store i8* [[TMP0]], i8** [[__ADDR_ADDR_I]], align 8
// CHECK-C-NEXT:    store [[INDIRECT_ADDR_TY]] [[BYVAL_TEMP]], [[INDIRECT_ADDR_TY]]* [[VALUE_INDIRECT_ADDR]], align 8
// CHECK-C-NEXT:    [[TMP2:%.*]] = load i8*, i8** [[__ADDR_ADDR_I]], align 8
// CHECK-C-NEXT:    [[VAL_I:%.*]] = getelementptr inbounds [[STRUCT_DATA512_T]], %struct.data512_t* [[BYVAL_TEMP]], i32 0, i32 0
// CHECK-C-NEXT:    [[ARRAYDECAY_I:%.*]] = getelementptr inbounds [8 x i64], [8 x i64]* [[VAL_I]], i64 0, i64 0
// CHECK-C-NEXT:    [[TMP3:%.*]] = load i64, i64* [[ARRAYDECAY_I]], align 8
// CHECK-C-NEXT:    [[TMP4:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 1
// CHECK-C-NEXT:    [[TMP5:%.*]] = load i64, i64* [[TMP4]], align 8
// CHECK-C-NEXT:    [[TMP6:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 2
// CHECK-C-NEXT:    [[TMP7:%.*]] = load i64, i64* [[TMP6]], align 8
// CHECK-C-NEXT:    [[TMP8:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 3
// CHECK-C-NEXT:    [[TMP9:%.*]] = load i64, i64* [[TMP8]], align 8
// CHECK-C-NEXT:    [[TMP10:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 4
// CHECK-C-NEXT:    [[TMP11:%.*]] = load i64, i64* [[TMP10]], align 8
// CHECK-C-NEXT:    [[TMP12:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 5
// CHECK-C-NEXT:    [[TMP13:%.*]] = load i64, i64* [[TMP12]], align 8
// CHECK-C-NEXT:    [[TMP14:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 6
// CHECK-C-NEXT:    [[TMP15:%.*]] = load i64, i64* [[TMP14]], align 8
// CHECK-C-NEXT:    [[TMP16:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 7
// CHECK-C-NEXT:    [[TMP17:%.*]] = load i64, i64* [[TMP16]], align 8
// CHECK-C-NEXT:    [[TMP18:%.*]] = call i64 @llvm.aarch64.st64bv(i8* [[TMP2]], i64 [[TMP3]], i64 [[TMP5]], i64 [[TMP7]], i64 [[TMP9]], i64 [[TMP11]], i64 [[TMP13]], i64 [[TMP15]], i64 [[TMP17]])
// CHECK-C-NEXT:    store i64 [[TMP18]], i64* @status, align 8
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: @test_st64bv(
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[__ADDR_ADDR_I:%.*]] = alloca i8*, align 8
// CHECK-CXX-NEXT:    [[VALUE_INDIRECT_ADDR:%.*]] = alloca [[INDIRECT_ADDR_TY]], align 8
// CHECK-CXX-NEXT:    [[AGG_TMP:%.*]] = alloca [[STRUCT_DATA512_T:%.*]], align 8
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = load i8*, i8** @addr, align 8
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = bitcast %struct.data512_t* [[AGG_TMP]] to i8*
// CHECK-CXX-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 [[TMP1]], i8* align 8 bitcast (%struct.data512_t* @val to i8*), i64 64, i1 false)
// CHECK-CXX-NEXT:    store i8* [[TMP0]], i8** [[__ADDR_ADDR_I]], align 8
// CHECK-CXX-NEXT:    store [[INDIRECT_ADDR_TY]] [[AGG_TMP]], [[INDIRECT_ADDR_TY]]* [[VALUE_INDIRECT_ADDR]], align 8
// CHECK-CXX-NEXT:    [[TMP2:%.*]] = load i8*, i8** [[__ADDR_ADDR_I]], align 8
// CHECK-CXX-NEXT:    [[VAL_I:%.*]] = getelementptr inbounds [[STRUCT_DATA512_T]], %struct.data512_t* [[AGG_TMP]], i32 0, i32 0
// CHECK-CXX-NEXT:    [[ARRAYDECAY_I:%.*]] = getelementptr inbounds [8 x i64], [8 x i64]* [[VAL_I]], i64 0, i64 0
// CHECK-CXX-NEXT:    [[TMP3:%.*]] = load i64, i64* [[ARRAYDECAY_I]], align 8
// CHECK-CXX-NEXT:    [[TMP4:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 1
// CHECK-CXX-NEXT:    [[TMP5:%.*]] = load i64, i64* [[TMP4]], align 8
// CHECK-CXX-NEXT:    [[TMP6:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 2
// CHECK-CXX-NEXT:    [[TMP7:%.*]] = load i64, i64* [[TMP6]], align 8
// CHECK-CXX-NEXT:    [[TMP8:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 3
// CHECK-CXX-NEXT:    [[TMP9:%.*]] = load i64, i64* [[TMP8]], align 8
// CHECK-CXX-NEXT:    [[TMP10:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 4
// CHECK-CXX-NEXT:    [[TMP11:%.*]] = load i64, i64* [[TMP10]], align 8
// CHECK-CXX-NEXT:    [[TMP12:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 5
// CHECK-CXX-NEXT:    [[TMP13:%.*]] = load i64, i64* [[TMP12]], align 8
// CHECK-CXX-NEXT:    [[TMP14:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 6
// CHECK-CXX-NEXT:    [[TMP15:%.*]] = load i64, i64* [[TMP14]], align 8
// CHECK-CXX-NEXT:    [[TMP16:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 7
// CHECK-CXX-NEXT:    [[TMP17:%.*]] = load i64, i64* [[TMP16]], align 8
// CHECK-CXX-NEXT:    [[TMP18:%.*]] = call i64 @llvm.aarch64.st64bv(i8* [[TMP2]], i64 [[TMP3]], i64 [[TMP5]], i64 [[TMP7]], i64 [[TMP9]], i64 [[TMP11]], i64 [[TMP13]], i64 [[TMP15]], i64 [[TMP17]])
// CHECK-CXX-NEXT:    store i64 [[TMP18]], i64* @status, align 8
// CHECK-CXX-NEXT:    ret void
//
EXTERN_C void test_st64bv(void)
{
    status = __arm_st64bv(addr, val);
}

// CHECK-C-LABEL: @test_st64bv0(
// CHECK-C-NEXT:  entry:
// CHECK-C-NEXT:    [[__ADDR_ADDR_I:%.*]] = alloca i8*, align 8
// CHECK-C-NEXT:    [[VALUE_INDIRECT_ADDR:%.*]] = alloca [[INDIRECT_ADDR_TY]], align 8
// CHECK-C-NEXT:    [[BYVAL_TEMP:%.*]] = alloca [[STRUCT_DATA512_T:%.*]], align 8
// CHECK-C-NEXT:    [[TMP0:%.*]] = load i8*, i8** @addr, align 8
// CHECK-C-NEXT:    [[TMP1:%.*]] = bitcast %struct.data512_t* [[BYVAL_TEMP]] to i8*
// CHECK-C-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 [[TMP1]], i8* align 8 bitcast (%struct.data512_t* @val to i8*), i64 64, i1 false)
// CHECK-C-NEXT:    store i8* [[TMP0]], i8** [[__ADDR_ADDR_I]], align 8
// CHECK-C-NEXT:    store [[INDIRECT_ADDR_TY]] [[BYVAL_TEMP]], [[INDIRECT_ADDR_TY]]* [[VALUE_INDIRECT_ADDR]], align 8
// CHECK-C-NEXT:    [[TMP2:%.*]] = load i8*, i8** [[__ADDR_ADDR_I]], align 8
// CHECK-C-NEXT:    [[VAL_I:%.*]] = getelementptr inbounds [[STRUCT_DATA512_T]], %struct.data512_t* [[BYVAL_TEMP]], i32 0, i32 0
// CHECK-C-NEXT:    [[ARRAYDECAY_I:%.*]] = getelementptr inbounds [8 x i64], [8 x i64]* [[VAL_I]], i64 0, i64 0
// CHECK-C-NEXT:    [[TMP3:%.*]] = load i64, i64* [[ARRAYDECAY_I]], align 8
// CHECK-C-NEXT:    [[TMP4:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 1
// CHECK-C-NEXT:    [[TMP5:%.*]] = load i64, i64* [[TMP4]], align 8
// CHECK-C-NEXT:    [[TMP6:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 2
// CHECK-C-NEXT:    [[TMP7:%.*]] = load i64, i64* [[TMP6]], align 8
// CHECK-C-NEXT:    [[TMP8:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 3
// CHECK-C-NEXT:    [[TMP9:%.*]] = load i64, i64* [[TMP8]], align 8
// CHECK-C-NEXT:    [[TMP10:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 4
// CHECK-C-NEXT:    [[TMP11:%.*]] = load i64, i64* [[TMP10]], align 8
// CHECK-C-NEXT:    [[TMP12:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 5
// CHECK-C-NEXT:    [[TMP13:%.*]] = load i64, i64* [[TMP12]], align 8
// CHECK-C-NEXT:    [[TMP14:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 6
// CHECK-C-NEXT:    [[TMP15:%.*]] = load i64, i64* [[TMP14]], align 8
// CHECK-C-NEXT:    [[TMP16:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 7
// CHECK-C-NEXT:    [[TMP17:%.*]] = load i64, i64* [[TMP16]], align 8
// CHECK-C-NEXT:    [[TMP18:%.*]] = call i64 @llvm.aarch64.st64bv0(i8* [[TMP2]], i64 [[TMP3]], i64 [[TMP5]], i64 [[TMP7]], i64 [[TMP9]], i64 [[TMP11]], i64 [[TMP13]], i64 [[TMP15]], i64 [[TMP17]])
// CHECK-C-NEXT:    store i64 [[TMP18]], i64* @status, align 8
// CHECK-C-NEXT:    ret void
//
// CHECK-CXX-LABEL: @test_st64bv0(
// CHECK-CXX-NEXT:  entry:
// CHECK-CXX-NEXT:    [[__ADDR_ADDR_I:%.*]] = alloca i8*, align 8
// CHECK-CXX-NEXT:    [[VALUE_INDIRECT_ADDR:%.*]] = alloca [[INDIRECT_ADDR_TY]], align 8
// CHECK-CXX-NEXT:    [[AGG_TMP:%.*]] = alloca [[STRUCT_DATA512_T:%.*]], align 8
// CHECK-CXX-NEXT:    [[TMP0:%.*]] = load i8*, i8** @addr, align 8
// CHECK-CXX-NEXT:    [[TMP1:%.*]] = bitcast %struct.data512_t* [[AGG_TMP]] to i8*
// CHECK-CXX-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 [[TMP1]], i8* align 8 bitcast (%struct.data512_t* @val to i8*), i64 64, i1 false)
// CHECK-CXX-NEXT:    store i8* [[TMP0]], i8** [[__ADDR_ADDR_I]], align 8
// CHECK-CXX-NEXT:    store [[INDIRECT_ADDR_TY]] [[AGG_TMP]], [[INDIRECT_ADDR_TY]]* [[VALUE_INDIRECT_ADDR]], align 8
// CHECK-CXX-NEXT:    [[TMP2:%.*]] = load i8*, i8** [[__ADDR_ADDR_I]], align 8
// CHECK-CXX-NEXT:    [[VAL_I:%.*]] = getelementptr inbounds [[STRUCT_DATA512_T]], %struct.data512_t* [[AGG_TMP]], i32 0, i32 0
// CHECK-CXX-NEXT:    [[ARRAYDECAY_I:%.*]] = getelementptr inbounds [8 x i64], [8 x i64]* [[VAL_I]], i64 0, i64 0
// CHECK-CXX-NEXT:    [[TMP3:%.*]] = load i64, i64* [[ARRAYDECAY_I]], align 8
// CHECK-CXX-NEXT:    [[TMP4:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 1
// CHECK-CXX-NEXT:    [[TMP5:%.*]] = load i64, i64* [[TMP4]], align 8
// CHECK-CXX-NEXT:    [[TMP6:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 2
// CHECK-CXX-NEXT:    [[TMP7:%.*]] = load i64, i64* [[TMP6]], align 8
// CHECK-CXX-NEXT:    [[TMP8:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 3
// CHECK-CXX-NEXT:    [[TMP9:%.*]] = load i64, i64* [[TMP8]], align 8
// CHECK-CXX-NEXT:    [[TMP10:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 4
// CHECK-CXX-NEXT:    [[TMP11:%.*]] = load i64, i64* [[TMP10]], align 8
// CHECK-CXX-NEXT:    [[TMP12:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 5
// CHECK-CXX-NEXT:    [[TMP13:%.*]] = load i64, i64* [[TMP12]], align 8
// CHECK-CXX-NEXT:    [[TMP14:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 6
// CHECK-CXX-NEXT:    [[TMP15:%.*]] = load i64, i64* [[TMP14]], align 8
// CHECK-CXX-NEXT:    [[TMP16:%.*]] = getelementptr i64, i64* [[ARRAYDECAY_I]], i32 7
// CHECK-CXX-NEXT:    [[TMP17:%.*]] = load i64, i64* [[TMP16]], align 8
// CHECK-CXX-NEXT:    [[TMP18:%.*]] = call i64 @llvm.aarch64.st64bv0(i8* [[TMP2]], i64 [[TMP3]], i64 [[TMP5]], i64 [[TMP7]], i64 [[TMP9]], i64 [[TMP11]], i64 [[TMP13]], i64 [[TMP15]], i64 [[TMP17]])
// CHECK-CXX-NEXT:    store i64 [[TMP18]], i64* @status, align 8
// CHECK-CXX-NEXT:    ret void
//
EXTERN_C void test_st64bv0(void)
{
    status = __arm_st64bv0(addr, val);
}
