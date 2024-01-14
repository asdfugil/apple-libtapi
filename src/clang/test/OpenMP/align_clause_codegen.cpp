// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --function-signature --include-generated-funcs
// RUN: %clang_cc1 -emit-llvm -o - -fopenmp \
// RUN: -triple i386-unknown-unknown -fopenmp-version=51 %s | \
// RUN: FileCheck %s --check-prefix=CHECK-32
// RUN: %clang_cc1 -emit-llvm -o - -fopenmp \
// RUN: -triple x86_64-unknown-linux-gnu -fopenmp-version=51 %s | FileCheck %s
// RUN: %clang_cc1 -fopenmp \
// RUN: -triple x86_64-unknown-linux-gnu -fopenmp-version=51 \
// RUN: -emit-pch %s -o %t
// RUN: %clang_cc1 -fopenmp \
// RUN: -triple x86_64-unknown-linux-gnu -fopenmp-version=51 \
// RUN: -include-pch %t -emit-llvm %s -o - | FileCheck %s
// expected-no-diagnostics
#ifndef HEADER
#define HEADER

typedef enum omp_allocator_handle_t {
  omp_null_allocator = 0,
  omp_default_mem_alloc = 1,
  omp_large_cap_mem_alloc = 2,
  omp_const_mem_alloc = 3,
  omp_high_bw_mem_alloc = 4,
  omp_low_lat_mem_alloc = 5,
  omp_cgroup_mem_alloc = 6,
  omp_pteam_mem_alloc = 7,
  omp_thread_mem_alloc = 8,
  KMP_ALLOCATOR_MAX_HANDLE = __UINTPTR_MAX__
} omp_allocator_handle_t;

int main() {
  int foo0[5];
  int foo1[10];
  int foo2[20];
  int foo3[30];
  int foo4[40];
  int foo5[50];
  int foo6[60];
  int foo7[70];
  int foo8[80];
  omp_allocator_handle_t MyAlloc = omp_large_cap_mem_alloc;

#pragma omp allocate(foo0) align(1)
#pragma omp allocate(foo1) allocator(omp_pteam_mem_alloc) align(2)
#pragma omp allocate(foo2) align(4) allocator(omp_cgroup_mem_alloc)
#pragma omp allocate(foo3) align(8) allocator(omp_low_lat_mem_alloc)
#pragma omp allocate(foo4) align(16) allocator(omp_high_bw_mem_alloc)
#pragma omp allocate(foo5) align(32) allocator(omp_const_mem_alloc)
#pragma omp allocate(foo6) align(64) allocator(omp_large_cap_mem_alloc)
#pragma omp allocate(foo7) align(32) allocator(omp_thread_mem_alloc)
#pragma omp allocate(foo8) align(16) allocator(omp_null_allocator)
  {
    double foo9[80];
    double foo10[90];
#pragma omp allocate(foo9) align(8) allocator(omp_thread_mem_alloc)
#pragma omp allocate(foo10) align(128)
  }
  {
    int bar1;
    int bar2[10];
    int bar3[20];
    int *bar4;
    float bar5;
    double bar6[30];
#pragma omp allocate(bar1, bar2, bar3) align(2) allocator(MyAlloc)
#pragma omp allocate(bar4, bar5, bar6) align(16)
  }
}

// Verify align clause in template with non-type template parameter.
template <typename T, unsigned size, unsigned align>
T run() {
  T foo[size];
#pragma omp allocate(foo) align(align) allocator(omp_cgroup_mem_alloc)
  return foo[0];
}

int template_test() {
  double result;
  result = run<double, 1000, 16>();
  return 0;
}
#endif
// CHECK-32-LABEL: define {{[^@]+}}@main
// CHECK-32-SAME: () #[[ATTR0:[0-9]+]] {
// CHECK-32-NEXT:  entry:
// CHECK-32-NEXT:    [[MYALLOC:%.*]] = alloca i32, align 4
// CHECK-32-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1:[0-9]+]])
// CHECK-32-NEXT:    [[DOTFOO0__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 4, i32 20, ptr null)
// CHECK-32-NEXT:    [[DOTFOO1__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 4, i32 40, ptr inttoptr (i32 7 to ptr))
// CHECK-32-NEXT:    [[DOTFOO2__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 4, i32 80, ptr inttoptr (i32 6 to ptr))
// CHECK-32-NEXT:    [[DOTFOO3__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 8, i32 120, ptr inttoptr (i32 5 to ptr))
// CHECK-32-NEXT:    [[DOTFOO4__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 16, i32 160, ptr inttoptr (i32 4 to ptr))
// CHECK-32-NEXT:    [[DOTFOO5__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 32, i32 200, ptr inttoptr (i32 3 to ptr))
// CHECK-32-NEXT:    [[DOTFOO6__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 64, i32 240, ptr inttoptr (i32 2 to ptr))
// CHECK-32-NEXT:    [[DOTFOO7__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 32, i32 280, ptr inttoptr (i32 8 to ptr))
// CHECK-32-NEXT:    [[DOTFOO8__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 16, i32 320, ptr null)
// CHECK-32-NEXT:    store i32 2, ptr [[MYALLOC]], align 4
// CHECK-32-NEXT:    [[DOTFOO9__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 8, i32 640, ptr inttoptr (i32 8 to ptr))
// CHECK-32-NEXT:    [[DOTFOO10__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 128, i32 720, ptr null)
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO10__VOID_ADDR]], ptr null)
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO9__VOID_ADDR]], ptr inttoptr (i32 8 to ptr))
// CHECK-32-NEXT:    [[TMP3:%.*]] = load i32, ptr [[MYALLOC]], align 4
// CHECK-32-NEXT:    [[CONV:%.*]] = inttoptr i32 [[TMP3]] to ptr
// CHECK-32-NEXT:    [[DOTBAR1__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 4, i32 4, ptr [[CONV]])
// CHECK-32-NEXT:    [[TMP4:%.*]] = load i32, ptr [[MYALLOC]], align 4
// CHECK-32-NEXT:    [[CONV1:%.*]] = inttoptr i32 [[TMP4]] to ptr
// CHECK-32-NEXT:    [[DOTBAR2__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 4, i32 40, ptr [[CONV1]])
// CHECK-32-NEXT:    [[TMP5:%.*]] = load i32, ptr [[MYALLOC]], align 4
// CHECK-32-NEXT:    [[CONV2:%.*]] = inttoptr i32 [[TMP5]] to ptr
// CHECK-32-NEXT:    [[DOTBAR3__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 4, i32 80, ptr [[CONV2]])
// CHECK-32-NEXT:    [[DOTBAR4__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 16, i32 4, ptr null)
// CHECK-32-NEXT:    [[DOTBAR5__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 16, i32 4, ptr null)
// CHECK-32-NEXT:    [[DOTBAR6__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 16, i32 240, ptr null)
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTBAR6__VOID_ADDR]], ptr null)
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTBAR5__VOID_ADDR]], ptr null)
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTBAR4__VOID_ADDR]], ptr null)
// CHECK-32-NEXT:    [[TMP10:%.*]] = load i32, ptr [[MYALLOC]], align 4
// CHECK-32-NEXT:    [[CONV3:%.*]] = inttoptr i32 [[TMP10]] to ptr
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTBAR3__VOID_ADDR]], ptr [[CONV3]])
// CHECK-32-NEXT:    [[TMP12:%.*]] = load i32, ptr [[MYALLOC]], align 4
// CHECK-32-NEXT:    [[CONV4:%.*]] = inttoptr i32 [[TMP12]] to ptr
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTBAR2__VOID_ADDR]], ptr [[CONV4]])
// CHECK-32-NEXT:    [[TMP14:%.*]] = load i32, ptr [[MYALLOC]], align 4
// CHECK-32-NEXT:    [[CONV5:%.*]] = inttoptr i32 [[TMP14]] to ptr
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTBAR1__VOID_ADDR]], ptr [[CONV5]])
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO8__VOID_ADDR]], ptr null)
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO7__VOID_ADDR]], ptr inttoptr (i32 8 to ptr))
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO6__VOID_ADDR]], ptr inttoptr (i32 2 to ptr))
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO5__VOID_ADDR]], ptr inttoptr (i32 3 to ptr))
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO4__VOID_ADDR]], ptr inttoptr (i32 4 to ptr))
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO3__VOID_ADDR]], ptr inttoptr (i32 5 to ptr))
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO2__VOID_ADDR]], ptr inttoptr (i32 6 to ptr))
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO1__VOID_ADDR]], ptr inttoptr (i32 7 to ptr))
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO0__VOID_ADDR]], ptr null)
// CHECK-32-NEXT:    ret i32 0
//
//
// CHECK-32-LABEL: define {{[^@]+}}@_Z13template_testv
// CHECK-32-SAME: () #[[ATTR2:[0-9]+]] {
// CHECK-32-NEXT:  entry:
// CHECK-32-NEXT:    [[RESULT:%.*]] = alloca double, align 8
// CHECK-32-NEXT:    [[CALL:%.*]] = call noundef double @_Z3runIdLj1000ELj16EET_v()
// CHECK-32-NEXT:    store double [[CALL]], ptr [[RESULT]], align 8
// CHECK-32-NEXT:    ret i32 0
//
//
// CHECK-32-LABEL: define {{[^@]+}}@_Z3runIdLj1000ELj16EET_v
// CHECK-32-SAME: () #[[ATTR2]] comdat {
// CHECK-32-NEXT:  entry:
// CHECK-32-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-32-NEXT:    [[DOTFOO__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i32 16, i32 8000, ptr inttoptr (i32 6 to ptr))
// CHECK-32-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [1000 x double], ptr [[DOTFOO__VOID_ADDR]], i32 0, i32 0
// CHECK-32-NEXT:    [[TMP1:%.*]] = load double, ptr [[ARRAYIDX]], align 8
// CHECK-32-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO__VOID_ADDR]], ptr inttoptr (i32 6 to ptr))
// CHECK-32-NEXT:    ret double [[TMP1]]
//
//
// CHECK-LABEL: define {{[^@]+}}@main
// CHECK-SAME: () #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[MYALLOC:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1:[0-9]+]])
// CHECK-NEXT:    [[DOTFOO0__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 4, i64 32, ptr null)
// CHECK-NEXT:    [[DOTFOO1__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 4, i64 48, ptr inttoptr (i64 7 to ptr))
// CHECK-NEXT:    [[DOTFOO2__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 4, i64 80, ptr inttoptr (i64 6 to ptr))
// CHECK-NEXT:    [[DOTFOO3__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 8, i64 128, ptr inttoptr (i64 5 to ptr))
// CHECK-NEXT:    [[DOTFOO4__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 16, i64 160, ptr inttoptr (i64 4 to ptr))
// CHECK-NEXT:    [[DOTFOO5__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 32, i64 208, ptr inttoptr (i64 3 to ptr))
// CHECK-NEXT:    [[DOTFOO6__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 64, i64 240, ptr inttoptr (i64 2 to ptr))
// CHECK-NEXT:    [[DOTFOO7__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 32, i64 288, ptr inttoptr (i64 8 to ptr))
// CHECK-NEXT:    [[DOTFOO8__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 16, i64 320, ptr null)
// CHECK-NEXT:    store i64 2, ptr [[MYALLOC]], align 8
// CHECK-NEXT:    [[DOTFOO9__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 8, i64 640, ptr inttoptr (i64 8 to ptr))
// CHECK-NEXT:    [[DOTFOO10__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 128, i64 720, ptr null)
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO10__VOID_ADDR]], ptr null)
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO9__VOID_ADDR]], ptr inttoptr (i64 8 to ptr))
// CHECK-NEXT:    [[TMP3:%.*]] = load i64, ptr [[MYALLOC]], align 8
// CHECK-NEXT:    [[CONV:%.*]] = inttoptr i64 [[TMP3]] to ptr
// CHECK-NEXT:    [[DOTBAR1__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 4, i64 4, ptr [[CONV]])
// CHECK-NEXT:    [[TMP4:%.*]] = load i64, ptr [[MYALLOC]], align 8
// CHECK-NEXT:    [[CONV1:%.*]] = inttoptr i64 [[TMP4]] to ptr
// CHECK-NEXT:    [[DOTBAR2__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 4, i64 48, ptr [[CONV1]])
// CHECK-NEXT:    [[TMP5:%.*]] = load i64, ptr [[MYALLOC]], align 8
// CHECK-NEXT:    [[CONV2:%.*]] = inttoptr i64 [[TMP5]] to ptr
// CHECK-NEXT:    [[DOTBAR3__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 4, i64 80, ptr [[CONV2]])
// CHECK-NEXT:    [[DOTBAR4__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 16, i64 8, ptr null)
// CHECK-NEXT:    [[DOTBAR5__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 16, i64 4, ptr null)
// CHECK-NEXT:    [[DOTBAR6__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 16, i64 240, ptr null)
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTBAR6__VOID_ADDR]], ptr null)
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTBAR5__VOID_ADDR]], ptr null)
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTBAR4__VOID_ADDR]], ptr null)
// CHECK-NEXT:    [[TMP10:%.*]] = load i64, ptr [[MYALLOC]], align 8
// CHECK-NEXT:    [[CONV3:%.*]] = inttoptr i64 [[TMP10]] to ptr
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTBAR3__VOID_ADDR]], ptr [[CONV3]])
// CHECK-NEXT:    [[TMP12:%.*]] = load i64, ptr [[MYALLOC]], align 8
// CHECK-NEXT:    [[CONV4:%.*]] = inttoptr i64 [[TMP12]] to ptr
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTBAR2__VOID_ADDR]], ptr [[CONV4]])
// CHECK-NEXT:    [[TMP14:%.*]] = load i64, ptr [[MYALLOC]], align 8
// CHECK-NEXT:    [[CONV5:%.*]] = inttoptr i64 [[TMP14]] to ptr
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTBAR1__VOID_ADDR]], ptr [[CONV5]])
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO8__VOID_ADDR]], ptr null)
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO7__VOID_ADDR]], ptr inttoptr (i64 8 to ptr))
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO6__VOID_ADDR]], ptr inttoptr (i64 2 to ptr))
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO5__VOID_ADDR]], ptr inttoptr (i64 3 to ptr))
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO4__VOID_ADDR]], ptr inttoptr (i64 4 to ptr))
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO3__VOID_ADDR]], ptr inttoptr (i64 5 to ptr))
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO2__VOID_ADDR]], ptr inttoptr (i64 6 to ptr))
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO1__VOID_ADDR]], ptr inttoptr (i64 7 to ptr))
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO0__VOID_ADDR]], ptr null)
// CHECK-NEXT:    ret i32 0
//
//
// CHECK-LABEL: define {{[^@]+}}@_Z13template_testv
// CHECK-SAME: () #[[ATTR2:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[RESULT:%.*]] = alloca double, align 8
// CHECK-NEXT:    [[CALL:%.*]] = call noundef double @_Z3runIdLj1000ELj16EET_v()
// CHECK-NEXT:    store double [[CALL]], ptr [[RESULT]], align 8
// CHECK-NEXT:    ret i32 0
//
//
// CHECK-LABEL: define {{[^@]+}}@_Z3runIdLj1000ELj16EET_v
// CHECK-SAME: () #[[ATTR2]] comdat {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-NEXT:    [[DOTFOO__VOID_ADDR:%.*]] = call ptr @__kmpc_aligned_alloc(i32 [[TMP0]], i64 16, i64 8000, ptr inttoptr (i64 6 to ptr))
// CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [1000 x double], ptr [[DOTFOO__VOID_ADDR]], i64 0, i64 0
// CHECK-NEXT:    [[TMP1:%.*]] = load double, ptr [[ARRAYIDX]], align 16
// CHECK-NEXT:    call void @__kmpc_free(i32 [[TMP0]], ptr [[DOTFOO__VOID_ADDR]], ptr inttoptr (i64 6 to ptr))
// CHECK-NEXT:    ret double [[TMP1]]
//
