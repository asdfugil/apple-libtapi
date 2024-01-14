// RUN: %clang_cc1 -no-opaque-pointers -no-enable-noundef-analysis -verify -triple x86_64-apple-darwin10 -fopenmp -x c++ -emit-llvm %s -o - | FileCheck %s --check-prefix=CHECK1
// RUN: %clang_cc1 -no-opaque-pointers -no-enable-noundef-analysis -fopenmp -x c++ -triple x86_64-apple-darwin10 -emit-pch -o %t %s
// RUN: %clang_cc1 -no-opaque-pointers -no-enable-noundef-analysis -fopenmp -x c++ -triple x86_64-apple-darwin10 -include-pch %t -verify %s -emit-llvm -o - | FileCheck %s --check-prefix=CHECK1
// expected-no-diagnostics
#ifndef HEADER
#define HEADER

struct S {
  int a;
  S() : a(0) {}
  S(const S &) {}
  S &operator=(const S &) { return *this; }
  ~S() {}
  friend S operator+(const S &a, const S &b) { return a; }
};

int main(int argc, char **argv) {
  int a;
  float b;
  S c[5];
  short d[argc];
#pragma omp taskgroup task_reduction(+ \
                                     : a, b, argc)
  {
#pragma omp taskgroup task_reduction(- \
                                     : c, d)
#pragma omp parallel
#pragma omp target in_reduction(+ \
                                : a)
    for (int i = 0; i < 5; i++)
      a += d[a];
  }
  return 0;
}

#endif
// CHECK1-LABEL: define {{[^@]+}}@main
// CHECK1-SAME: (i32 [[ARGC:%.*]], i8** [[ARGV:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[RETVAL:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[ARGC_ADDR:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[ARGV_ADDR:%.*]] = alloca i8**, align 8
// CHECK1-NEXT:    [[A:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[B:%.*]] = alloca float, align 4
// CHECK1-NEXT:    [[C:%.*]] = alloca [5 x %struct.S], align 16
// CHECK1-NEXT:    [[SAVED_STACK:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[__VLA_EXPR0:%.*]] = alloca i64, align 8
// CHECK1-NEXT:    [[DOTRD_INPUT_:%.*]] = alloca [3 x %struct.kmp_taskred_input_t], align 8
// CHECK1-NEXT:    [[DOTTASK_RED_:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[DOTRD_INPUT_3:%.*]] = alloca [2 x %struct.kmp_taskred_input_t.0], align 8
// CHECK1-NEXT:    [[DOTTASK_RED_6:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_global_thread_num(%struct.ident_t* @[[GLOB1:[0-9]+]])
// CHECK1-NEXT:    store i32 0, i32* [[RETVAL]], align 4
// CHECK1-NEXT:    store i32 [[ARGC]], i32* [[ARGC_ADDR]], align 4
// CHECK1-NEXT:    store i8** [[ARGV]], i8*** [[ARGV_ADDR]], align 8
// CHECK1-NEXT:    [[ARRAY_BEGIN:%.*]] = getelementptr inbounds [5 x %struct.S], [5 x %struct.S]* [[C]], i32 0, i32 0
// CHECK1-NEXT:    [[ARRAYCTOR_END:%.*]] = getelementptr inbounds [[STRUCT_S:%.*]], %struct.S* [[ARRAY_BEGIN]], i64 5
// CHECK1-NEXT:    br label [[ARRAYCTOR_LOOP:%.*]]
// CHECK1:       arrayctor.loop:
// CHECK1-NEXT:    [[ARRAYCTOR_CUR:%.*]] = phi %struct.S* [ [[ARRAY_BEGIN]], [[ENTRY:%.*]] ], [ [[ARRAYCTOR_NEXT:%.*]], [[ARRAYCTOR_LOOP]] ]
// CHECK1-NEXT:    call void @_ZN1SC1Ev(%struct.S* nonnull align 4 dereferenceable(4) [[ARRAYCTOR_CUR]])
// CHECK1-NEXT:    [[ARRAYCTOR_NEXT]] = getelementptr inbounds [[STRUCT_S]], %struct.S* [[ARRAYCTOR_CUR]], i64 1
// CHECK1-NEXT:    [[ARRAYCTOR_DONE:%.*]] = icmp eq %struct.S* [[ARRAYCTOR_NEXT]], [[ARRAYCTOR_END]]
// CHECK1-NEXT:    br i1 [[ARRAYCTOR_DONE]], label [[ARRAYCTOR_CONT:%.*]], label [[ARRAYCTOR_LOOP]]
// CHECK1:       arrayctor.cont:
// CHECK1-NEXT:    [[TMP1:%.*]] = load i32, i32* [[ARGC_ADDR]], align 4
// CHECK1-NEXT:    [[TMP2:%.*]] = zext i32 [[TMP1]] to i64
// CHECK1-NEXT:    [[TMP3:%.*]] = call i8* @llvm.stacksave()
// CHECK1-NEXT:    store i8* [[TMP3]], i8** [[SAVED_STACK]], align 8
// CHECK1-NEXT:    [[VLA:%.*]] = alloca i16, i64 [[TMP2]], align 16
// CHECK1-NEXT:    store i64 [[TMP2]], i64* [[__VLA_EXPR0]], align 8
// CHECK1-NEXT:    call void @__kmpc_taskgroup(%struct.ident_t* @[[GLOB1]], i32 [[TMP0]])
// CHECK1-NEXT:    [[DOTRD_INPUT_GEP_:%.*]] = getelementptr inbounds [3 x %struct.kmp_taskred_input_t], [3 x %struct.kmp_taskred_input_t]* [[DOTRD_INPUT_]], i64 0, i64 0
// CHECK1-NEXT:    [[TMP4:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T:%.*]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP5:%.*]] = bitcast i32* [[A]] to i8*
// CHECK1-NEXT:    store i8* [[TMP5]], i8** [[TMP4]], align 8
// CHECK1-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_]], i32 0, i32 1
// CHECK1-NEXT:    [[TMP7:%.*]] = bitcast i32* [[A]] to i8*
// CHECK1-NEXT:    store i8* [[TMP7]], i8** [[TMP6]], align 8
// CHECK1-NEXT:    [[TMP8:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_]], i32 0, i32 2
// CHECK1-NEXT:    store i64 4, i64* [[TMP8]], align 8
// CHECK1-NEXT:    [[TMP9:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_]], i32 0, i32 3
// CHECK1-NEXT:    store i8* bitcast (void (i8*, i8*)* @.red_init. to i8*), i8** [[TMP9]], align 8
// CHECK1-NEXT:    [[TMP10:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_]], i32 0, i32 4
// CHECK1-NEXT:    store i8* null, i8** [[TMP10]], align 8
// CHECK1-NEXT:    [[TMP11:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_]], i32 0, i32 5
// CHECK1-NEXT:    store i8* bitcast (void (i8*, i8*)* @.red_comb. to i8*), i8** [[TMP11]], align 8
// CHECK1-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_]], i32 0, i32 6
// CHECK1-NEXT:    [[TMP13:%.*]] = bitcast i32* [[TMP12]] to i8*
// CHECK1-NEXT:    call void @llvm.memset.p0i8.i64(i8* align 8 [[TMP13]], i8 0, i64 4, i1 false)
// CHECK1-NEXT:    [[DOTRD_INPUT_GEP_1:%.*]] = getelementptr inbounds [3 x %struct.kmp_taskred_input_t], [3 x %struct.kmp_taskred_input_t]* [[DOTRD_INPUT_]], i64 0, i64 1
// CHECK1-NEXT:    [[TMP14:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_1]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP15:%.*]] = bitcast float* [[B]] to i8*
// CHECK1-NEXT:    store i8* [[TMP15]], i8** [[TMP14]], align 8
// CHECK1-NEXT:    [[TMP16:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_1]], i32 0, i32 1
// CHECK1-NEXT:    [[TMP17:%.*]] = bitcast float* [[B]] to i8*
// CHECK1-NEXT:    store i8* [[TMP17]], i8** [[TMP16]], align 8
// CHECK1-NEXT:    [[TMP18:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_1]], i32 0, i32 2
// CHECK1-NEXT:    store i64 4, i64* [[TMP18]], align 8
// CHECK1-NEXT:    [[TMP19:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_1]], i32 0, i32 3
// CHECK1-NEXT:    store i8* bitcast (void (i8*, i8*)* @.red_init..1 to i8*), i8** [[TMP19]], align 8
// CHECK1-NEXT:    [[TMP20:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_1]], i32 0, i32 4
// CHECK1-NEXT:    store i8* null, i8** [[TMP20]], align 8
// CHECK1-NEXT:    [[TMP21:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_1]], i32 0, i32 5
// CHECK1-NEXT:    store i8* bitcast (void (i8*, i8*)* @.red_comb..2 to i8*), i8** [[TMP21]], align 8
// CHECK1-NEXT:    [[TMP22:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_1]], i32 0, i32 6
// CHECK1-NEXT:    [[TMP23:%.*]] = bitcast i32* [[TMP22]] to i8*
// CHECK1-NEXT:    call void @llvm.memset.p0i8.i64(i8* align 8 [[TMP23]], i8 0, i64 4, i1 false)
// CHECK1-NEXT:    [[DOTRD_INPUT_GEP_2:%.*]] = getelementptr inbounds [3 x %struct.kmp_taskred_input_t], [3 x %struct.kmp_taskred_input_t]* [[DOTRD_INPUT_]], i64 0, i64 2
// CHECK1-NEXT:    [[TMP24:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_2]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP25:%.*]] = bitcast i32* [[ARGC_ADDR]] to i8*
// CHECK1-NEXT:    store i8* [[TMP25]], i8** [[TMP24]], align 8
// CHECK1-NEXT:    [[TMP26:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_2]], i32 0, i32 1
// CHECK1-NEXT:    [[TMP27:%.*]] = bitcast i32* [[ARGC_ADDR]] to i8*
// CHECK1-NEXT:    store i8* [[TMP27]], i8** [[TMP26]], align 8
// CHECK1-NEXT:    [[TMP28:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_2]], i32 0, i32 2
// CHECK1-NEXT:    store i64 4, i64* [[TMP28]], align 8
// CHECK1-NEXT:    [[TMP29:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_2]], i32 0, i32 3
// CHECK1-NEXT:    store i8* bitcast (void (i8*, i8*)* @.red_init..3 to i8*), i8** [[TMP29]], align 8
// CHECK1-NEXT:    [[TMP30:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_2]], i32 0, i32 4
// CHECK1-NEXT:    store i8* null, i8** [[TMP30]], align 8
// CHECK1-NEXT:    [[TMP31:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_2]], i32 0, i32 5
// CHECK1-NEXT:    store i8* bitcast (void (i8*, i8*)* @.red_comb..4 to i8*), i8** [[TMP31]], align 8
// CHECK1-NEXT:    [[TMP32:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T]], %struct.kmp_taskred_input_t* [[DOTRD_INPUT_GEP_2]], i32 0, i32 6
// CHECK1-NEXT:    [[TMP33:%.*]] = bitcast i32* [[TMP32]] to i8*
// CHECK1-NEXT:    call void @llvm.memset.p0i8.i64(i8* align 8 [[TMP33]], i8 0, i64 4, i1 false)
// CHECK1-NEXT:    [[TMP34:%.*]] = bitcast [3 x %struct.kmp_taskred_input_t]* [[DOTRD_INPUT_]] to i8*
// CHECK1-NEXT:    [[TMP35:%.*]] = call i8* @__kmpc_taskred_init(i32 [[TMP0]], i32 3, i8* [[TMP34]])
// CHECK1-NEXT:    store i8* [[TMP35]], i8** [[DOTTASK_RED_]], align 8
// CHECK1-NEXT:    call void @__kmpc_taskgroup(%struct.ident_t* @[[GLOB1]], i32 [[TMP0]])
// CHECK1-NEXT:    [[DOTRD_INPUT_GEP_4:%.*]] = getelementptr inbounds [2 x %struct.kmp_taskred_input_t.0], [2 x %struct.kmp_taskred_input_t.0]* [[DOTRD_INPUT_3]], i64 0, i64 0
// CHECK1-NEXT:    [[TMP36:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T_0:%.*]], %struct.kmp_taskred_input_t.0* [[DOTRD_INPUT_GEP_4]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP37:%.*]] = bitcast [5 x %struct.S]* [[C]] to i8*
// CHECK1-NEXT:    store i8* [[TMP37]], i8** [[TMP36]], align 8
// CHECK1-NEXT:    [[TMP38:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T_0]], %struct.kmp_taskred_input_t.0* [[DOTRD_INPUT_GEP_4]], i32 0, i32 1
// CHECK1-NEXT:    [[TMP39:%.*]] = bitcast [5 x %struct.S]* [[C]] to i8*
// CHECK1-NEXT:    store i8* [[TMP39]], i8** [[TMP38]], align 8
// CHECK1-NEXT:    [[TMP40:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T_0]], %struct.kmp_taskred_input_t.0* [[DOTRD_INPUT_GEP_4]], i32 0, i32 2
// CHECK1-NEXT:    store i64 20, i64* [[TMP40]], align 8
// CHECK1-NEXT:    [[TMP41:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T_0]], %struct.kmp_taskred_input_t.0* [[DOTRD_INPUT_GEP_4]], i32 0, i32 3
// CHECK1-NEXT:    store i8* bitcast (void (i8*, i8*)* @.red_init..5 to i8*), i8** [[TMP41]], align 8
// CHECK1-NEXT:    [[TMP42:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T_0]], %struct.kmp_taskred_input_t.0* [[DOTRD_INPUT_GEP_4]], i32 0, i32 4
// CHECK1-NEXT:    store i8* bitcast (void (i8*)* @.red_fini. to i8*), i8** [[TMP42]], align 8
// CHECK1-NEXT:    [[TMP43:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T_0]], %struct.kmp_taskred_input_t.0* [[DOTRD_INPUT_GEP_4]], i32 0, i32 5
// CHECK1-NEXT:    store i8* bitcast (void (i8*, i8*)* @.red_comb..6 to i8*), i8** [[TMP43]], align 8
// CHECK1-NEXT:    [[TMP44:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T_0]], %struct.kmp_taskred_input_t.0* [[DOTRD_INPUT_GEP_4]], i32 0, i32 6
// CHECK1-NEXT:    [[TMP45:%.*]] = bitcast i32* [[TMP44]] to i8*
// CHECK1-NEXT:    call void @llvm.memset.p0i8.i64(i8* align 8 [[TMP45]], i8 0, i64 4, i1 false)
// CHECK1-NEXT:    [[DOTRD_INPUT_GEP_5:%.*]] = getelementptr inbounds [2 x %struct.kmp_taskred_input_t.0], [2 x %struct.kmp_taskred_input_t.0]* [[DOTRD_INPUT_3]], i64 0, i64 1
// CHECK1-NEXT:    [[TMP46:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T_0]], %struct.kmp_taskred_input_t.0* [[DOTRD_INPUT_GEP_5]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP47:%.*]] = bitcast i16* [[VLA]] to i8*
// CHECK1-NEXT:    store i8* [[TMP47]], i8** [[TMP46]], align 8
// CHECK1-NEXT:    [[TMP48:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T_0]], %struct.kmp_taskred_input_t.0* [[DOTRD_INPUT_GEP_5]], i32 0, i32 1
// CHECK1-NEXT:    [[TMP49:%.*]] = bitcast i16* [[VLA]] to i8*
// CHECK1-NEXT:    store i8* [[TMP49]], i8** [[TMP48]], align 8
// CHECK1-NEXT:    [[TMP50:%.*]] = mul nuw i64 [[TMP2]], 2
// CHECK1-NEXT:    [[TMP51:%.*]] = udiv exact i64 [[TMP50]], ptrtoint (i16* getelementptr (i16, i16* null, i32 1) to i64)
// CHECK1-NEXT:    [[TMP52:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T_0]], %struct.kmp_taskred_input_t.0* [[DOTRD_INPUT_GEP_5]], i32 0, i32 2
// CHECK1-NEXT:    store i64 [[TMP50]], i64* [[TMP52]], align 8
// CHECK1-NEXT:    [[TMP53:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T_0]], %struct.kmp_taskred_input_t.0* [[DOTRD_INPUT_GEP_5]], i32 0, i32 3
// CHECK1-NEXT:    store i8* bitcast (void (i8*, i8*)* @.red_init..7 to i8*), i8** [[TMP53]], align 8
// CHECK1-NEXT:    [[TMP54:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T_0]], %struct.kmp_taskred_input_t.0* [[DOTRD_INPUT_GEP_5]], i32 0, i32 4
// CHECK1-NEXT:    store i8* null, i8** [[TMP54]], align 8
// CHECK1-NEXT:    [[TMP55:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T_0]], %struct.kmp_taskred_input_t.0* [[DOTRD_INPUT_GEP_5]], i32 0, i32 5
// CHECK1-NEXT:    store i8* bitcast (void (i8*, i8*)* @.red_comb..8 to i8*), i8** [[TMP55]], align 8
// CHECK1-NEXT:    [[TMP56:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASKRED_INPUT_T_0]], %struct.kmp_taskred_input_t.0* [[DOTRD_INPUT_GEP_5]], i32 0, i32 6
// CHECK1-NEXT:    store i32 1, i32* [[TMP56]], align 8
// CHECK1-NEXT:    [[TMP57:%.*]] = bitcast [2 x %struct.kmp_taskred_input_t.0]* [[DOTRD_INPUT_3]] to i8*
// CHECK1-NEXT:    [[TMP58:%.*]] = call i8* @__kmpc_taskred_init(i32 [[TMP0]], i32 2, i8* [[TMP57]])
// CHECK1-NEXT:    store i8* [[TMP58]], i8** [[DOTTASK_RED_6]], align 8
// CHECK1-NEXT:    call void (%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%struct.ident_t* @[[GLOB1]], i32 4, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i32*, i64, i16*, i8**)* @.omp_outlined. to void (i32*, i32*, ...)*), i32* [[A]], i64 [[TMP2]], i16* [[VLA]], i8** [[DOTTASK_RED_]])
// CHECK1-NEXT:    call void @__kmpc_end_taskgroup(%struct.ident_t* @[[GLOB1]], i32 [[TMP0]])
// CHECK1-NEXT:    call void @__kmpc_end_taskgroup(%struct.ident_t* @[[GLOB1]], i32 [[TMP0]])
// CHECK1-NEXT:    store i32 0, i32* [[RETVAL]], align 4
// CHECK1-NEXT:    [[TMP59:%.*]] = load i8*, i8** [[SAVED_STACK]], align 8
// CHECK1-NEXT:    call void @llvm.stackrestore(i8* [[TMP59]])
// CHECK1-NEXT:    [[ARRAY_BEGIN7:%.*]] = getelementptr inbounds [5 x %struct.S], [5 x %struct.S]* [[C]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP60:%.*]] = getelementptr inbounds [[STRUCT_S]], %struct.S* [[ARRAY_BEGIN7]], i64 5
// CHECK1-NEXT:    br label [[ARRAYDESTROY_BODY:%.*]]
// CHECK1:       arraydestroy.body:
// CHECK1-NEXT:    [[ARRAYDESTROY_ELEMENTPAST:%.*]] = phi %struct.S* [ [[TMP60]], [[ARRAYCTOR_CONT]] ], [ [[ARRAYDESTROY_ELEMENT:%.*]], [[ARRAYDESTROY_BODY]] ]
// CHECK1-NEXT:    [[ARRAYDESTROY_ELEMENT]] = getelementptr inbounds [[STRUCT_S]], %struct.S* [[ARRAYDESTROY_ELEMENTPAST]], i64 -1
// CHECK1-NEXT:    call void @_ZN1SD1Ev(%struct.S* nonnull align 4 dereferenceable(4) [[ARRAYDESTROY_ELEMENT]]) #[[ATTR3:[0-9]+]]
// CHECK1-NEXT:    [[ARRAYDESTROY_DONE:%.*]] = icmp eq %struct.S* [[ARRAYDESTROY_ELEMENT]], [[ARRAY_BEGIN7]]
// CHECK1-NEXT:    br i1 [[ARRAYDESTROY_DONE]], label [[ARRAYDESTROY_DONE8:%.*]], label [[ARRAYDESTROY_BODY]]
// CHECK1:       arraydestroy.done8:
// CHECK1-NEXT:    [[TMP61:%.*]] = load i32, i32* [[RETVAL]], align 4
// CHECK1-NEXT:    ret i32 [[TMP61]]
//
//
// CHECK1-LABEL: define {{[^@]+}}@_ZN1SC1Ev
// CHECK1-SAME: (%struct.S* nonnull align 4 dereferenceable(4) [[THIS:%.*]]) unnamed_addr #[[ATTR1:[0-9]+]] align 2 {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[THIS_ADDR:%.*]] = alloca %struct.S*, align 8
// CHECK1-NEXT:    store %struct.S* [[THIS]], %struct.S** [[THIS_ADDR]], align 8
// CHECK1-NEXT:    [[THIS1:%.*]] = load %struct.S*, %struct.S** [[THIS_ADDR]], align 8
// CHECK1-NEXT:    call void @_ZN1SC2Ev(%struct.S* nonnull align 4 dereferenceable(4) [[THIS1]])
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@.red_init.
// CHECK1-SAME: (i8* noalias [[TMP0:%.*]], i8* noalias [[TMP1:%.*]]) #[[ATTR5:[0-9]+]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[DOTADDR1:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    store i8* [[TMP0]], i8** [[DOTADDR]], align 8
// CHECK1-NEXT:    store i8* [[TMP1]], i8** [[DOTADDR1]], align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = bitcast i8** [[DOTADDR]] to i32**
// CHECK1-NEXT:    [[TMP3:%.*]] = load i32*, i32** [[TMP2]], align 8
// CHECK1-NEXT:    store i32 0, i32* [[TMP3]], align 4
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@.red_comb.
// CHECK1-SAME: (i8* [[TMP0:%.*]], i8* [[TMP1:%.*]]) #[[ATTR5]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[DOTADDR1:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    store i8* [[TMP0]], i8** [[DOTADDR]], align 8
// CHECK1-NEXT:    store i8* [[TMP1]], i8** [[DOTADDR1]], align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = bitcast i8** [[DOTADDR]] to i32**
// CHECK1-NEXT:    [[TMP3:%.*]] = load i32*, i32** [[TMP2]], align 8
// CHECK1-NEXT:    [[TMP4:%.*]] = bitcast i8** [[DOTADDR1]] to i32**
// CHECK1-NEXT:    [[TMP5:%.*]] = load i32*, i32** [[TMP4]], align 8
// CHECK1-NEXT:    [[TMP6:%.*]] = load i32, i32* [[TMP3]], align 4
// CHECK1-NEXT:    [[TMP7:%.*]] = load i32, i32* [[TMP5]], align 4
// CHECK1-NEXT:    [[ADD:%.*]] = add nsw i32 [[TMP6]], [[TMP7]]
// CHECK1-NEXT:    store i32 [[ADD]], i32* [[TMP3]], align 4
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@.red_init..1
// CHECK1-SAME: (i8* noalias [[TMP0:%.*]], i8* noalias [[TMP1:%.*]]) #[[ATTR5]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[DOTADDR1:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    store i8* [[TMP0]], i8** [[DOTADDR]], align 8
// CHECK1-NEXT:    store i8* [[TMP1]], i8** [[DOTADDR1]], align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = bitcast i8** [[DOTADDR]] to float**
// CHECK1-NEXT:    [[TMP3:%.*]] = load float*, float** [[TMP2]], align 8
// CHECK1-NEXT:    store float 0.000000e+00, float* [[TMP3]], align 4
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@.red_comb..2
// CHECK1-SAME: (i8* [[TMP0:%.*]], i8* [[TMP1:%.*]]) #[[ATTR5]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[DOTADDR1:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    store i8* [[TMP0]], i8** [[DOTADDR]], align 8
// CHECK1-NEXT:    store i8* [[TMP1]], i8** [[DOTADDR1]], align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = bitcast i8** [[DOTADDR]] to float**
// CHECK1-NEXT:    [[TMP3:%.*]] = load float*, float** [[TMP2]], align 8
// CHECK1-NEXT:    [[TMP4:%.*]] = bitcast i8** [[DOTADDR1]] to float**
// CHECK1-NEXT:    [[TMP5:%.*]] = load float*, float** [[TMP4]], align 8
// CHECK1-NEXT:    [[TMP6:%.*]] = load float, float* [[TMP3]], align 4
// CHECK1-NEXT:    [[TMP7:%.*]] = load float, float* [[TMP5]], align 4
// CHECK1-NEXT:    [[ADD:%.*]] = fadd float [[TMP6]], [[TMP7]]
// CHECK1-NEXT:    store float [[ADD]], float* [[TMP3]], align 4
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@.red_init..3
// CHECK1-SAME: (i8* noalias [[TMP0:%.*]], i8* noalias [[TMP1:%.*]]) #[[ATTR5]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[DOTADDR1:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    store i8* [[TMP0]], i8** [[DOTADDR]], align 8
// CHECK1-NEXT:    store i8* [[TMP1]], i8** [[DOTADDR1]], align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = bitcast i8** [[DOTADDR]] to i32**
// CHECK1-NEXT:    [[TMP3:%.*]] = load i32*, i32** [[TMP2]], align 8
// CHECK1-NEXT:    store i32 0, i32* [[TMP3]], align 4
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@.red_comb..4
// CHECK1-SAME: (i8* [[TMP0:%.*]], i8* [[TMP1:%.*]]) #[[ATTR5]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[DOTADDR1:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    store i8* [[TMP0]], i8** [[DOTADDR]], align 8
// CHECK1-NEXT:    store i8* [[TMP1]], i8** [[DOTADDR1]], align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = bitcast i8** [[DOTADDR]] to i32**
// CHECK1-NEXT:    [[TMP3:%.*]] = load i32*, i32** [[TMP2]], align 8
// CHECK1-NEXT:    [[TMP4:%.*]] = bitcast i8** [[DOTADDR1]] to i32**
// CHECK1-NEXT:    [[TMP5:%.*]] = load i32*, i32** [[TMP4]], align 8
// CHECK1-NEXT:    [[TMP6:%.*]] = load i32, i32* [[TMP3]], align 4
// CHECK1-NEXT:    [[TMP7:%.*]] = load i32, i32* [[TMP5]], align 4
// CHECK1-NEXT:    [[ADD:%.*]] = add nsw i32 [[TMP6]], [[TMP7]]
// CHECK1-NEXT:    store i32 [[ADD]], i32* [[TMP3]], align 4
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@.red_init..5
// CHECK1-SAME: (i8* noalias [[TMP0:%.*]], i8* noalias [[TMP1:%.*]]) #[[ATTR5]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[DOTADDR1:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    store i8* [[TMP0]], i8** [[DOTADDR]], align 8
// CHECK1-NEXT:    store i8* [[TMP1]], i8** [[DOTADDR1]], align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = bitcast i8** [[DOTADDR]] to [5 x %struct.S]**
// CHECK1-NEXT:    [[TMP3:%.*]] = load [5 x %struct.S]*, [5 x %struct.S]** [[TMP2]], align 8
// CHECK1-NEXT:    [[ARRAY_BEGIN:%.*]] = getelementptr inbounds [5 x %struct.S], [5 x %struct.S]* [[TMP3]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP4:%.*]] = getelementptr [[STRUCT_S:%.*]], %struct.S* [[ARRAY_BEGIN]], i64 5
// CHECK1-NEXT:    [[OMP_ARRAYINIT_ISEMPTY:%.*]] = icmp eq %struct.S* [[ARRAY_BEGIN]], [[TMP4]]
// CHECK1-NEXT:    br i1 [[OMP_ARRAYINIT_ISEMPTY]], label [[OMP_ARRAYINIT_DONE:%.*]], label [[OMP_ARRAYINIT_BODY:%.*]]
// CHECK1:       omp.arrayinit.body:
// CHECK1-NEXT:    [[OMP_ARRAYCPY_DESTELEMENTPAST:%.*]] = phi %struct.S* [ [[ARRAY_BEGIN]], [[ENTRY:%.*]] ], [ [[OMP_ARRAYCPY_DEST_ELEMENT:%.*]], [[OMP_ARRAYINIT_BODY]] ]
// CHECK1-NEXT:    call void @_ZN1SC1Ev(%struct.S* nonnull align 4 dereferenceable(4) [[OMP_ARRAYCPY_DESTELEMENTPAST]])
// CHECK1-NEXT:    [[OMP_ARRAYCPY_DEST_ELEMENT]] = getelementptr [[STRUCT_S]], %struct.S* [[OMP_ARRAYCPY_DESTELEMENTPAST]], i32 1
// CHECK1-NEXT:    [[OMP_ARRAYCPY_DONE:%.*]] = icmp eq %struct.S* [[OMP_ARRAYCPY_DEST_ELEMENT]], [[TMP4]]
// CHECK1-NEXT:    br i1 [[OMP_ARRAYCPY_DONE]], label [[OMP_ARRAYINIT_DONE]], label [[OMP_ARRAYINIT_BODY]]
// CHECK1:       omp.arrayinit.done:
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@.red_fini.
// CHECK1-SAME: (i8* [[TMP0:%.*]]) #[[ATTR5]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    store i8* [[TMP0]], i8** [[DOTADDR]], align 8
// CHECK1-NEXT:    [[TMP1:%.*]] = load i8*, i8** [[DOTADDR]], align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = bitcast i8* [[TMP1]] to [5 x %struct.S]*
// CHECK1-NEXT:    [[ARRAY_BEGIN:%.*]] = getelementptr inbounds [5 x %struct.S], [5 x %struct.S]* [[TMP2]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP3:%.*]] = getelementptr inbounds [[STRUCT_S:%.*]], %struct.S* [[ARRAY_BEGIN]], i64 5
// CHECK1-NEXT:    br label [[ARRAYDESTROY_BODY:%.*]]
// CHECK1:       arraydestroy.body:
// CHECK1-NEXT:    [[ARRAYDESTROY_ELEMENTPAST:%.*]] = phi %struct.S* [ [[TMP3]], [[ENTRY:%.*]] ], [ [[ARRAYDESTROY_ELEMENT:%.*]], [[ARRAYDESTROY_BODY]] ]
// CHECK1-NEXT:    [[ARRAYDESTROY_ELEMENT]] = getelementptr inbounds [[STRUCT_S]], %struct.S* [[ARRAYDESTROY_ELEMENTPAST]], i64 -1
// CHECK1-NEXT:    call void @_ZN1SD1Ev(%struct.S* nonnull align 4 dereferenceable(4) [[ARRAYDESTROY_ELEMENT]]) #3
// CHECK1-NEXT:    [[ARRAYDESTROY_DONE:%.*]] = icmp eq %struct.S* [[ARRAYDESTROY_ELEMENT]], [[ARRAY_BEGIN]]
// CHECK1-NEXT:    br i1 [[ARRAYDESTROY_DONE]], label [[ARRAYDESTROY_DONE1:%.*]], label [[ARRAYDESTROY_BODY]]
// CHECK1:       arraydestroy.done1:
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@_ZN1SD1Ev
// CHECK1-SAME: (%struct.S* nonnull align 4 dereferenceable(4) [[THIS:%.*]]) unnamed_addr #[[ATTR1]] align 2 {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[THIS_ADDR:%.*]] = alloca %struct.S*, align 8
// CHECK1-NEXT:    store %struct.S* [[THIS]], %struct.S** [[THIS_ADDR]], align 8
// CHECK1-NEXT:    [[THIS1:%.*]] = load %struct.S*, %struct.S** [[THIS_ADDR]], align 8
// CHECK1-NEXT:    call void @_ZN1SD2Ev(%struct.S* nonnull align 4 dereferenceable(4) [[THIS1]]) #3
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@.red_comb..6
// CHECK1-SAME: (i8* [[TMP0:%.*]], i8* [[TMP1:%.*]]) #[[ATTR5]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[DOTADDR1:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[REF_TMP:%.*]] = alloca [[STRUCT_S:%.*]], align 4
// CHECK1-NEXT:    store i8* [[TMP0]], i8** [[DOTADDR]], align 8
// CHECK1-NEXT:    store i8* [[TMP1]], i8** [[DOTADDR1]], align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = bitcast i8** [[DOTADDR]] to %struct.S**
// CHECK1-NEXT:    [[TMP3:%.*]] = load %struct.S*, %struct.S** [[TMP2]], align 8
// CHECK1-NEXT:    [[TMP4:%.*]] = bitcast i8** [[DOTADDR1]] to %struct.S**
// CHECK1-NEXT:    [[TMP5:%.*]] = load %struct.S*, %struct.S** [[TMP4]], align 8
// CHECK1-NEXT:    [[TMP6:%.*]] = getelementptr [[STRUCT_S]], %struct.S* [[TMP3]], i64 5
// CHECK1-NEXT:    [[OMP_ARRAYCPY_ISEMPTY:%.*]] = icmp eq %struct.S* [[TMP3]], [[TMP6]]
// CHECK1-NEXT:    br i1 [[OMP_ARRAYCPY_ISEMPTY]], label [[OMP_ARRAYCPY_DONE2:%.*]], label [[OMP_ARRAYCPY_BODY:%.*]]
// CHECK1:       omp.arraycpy.body:
// CHECK1-NEXT:    [[OMP_ARRAYCPY_SRCELEMENTPAST:%.*]] = phi %struct.S* [ [[TMP5]], [[ENTRY:%.*]] ], [ [[OMP_ARRAYCPY_SRC_ELEMENT:%.*]], [[OMP_ARRAYCPY_BODY]] ]
// CHECK1-NEXT:    [[OMP_ARRAYCPY_DESTELEMENTPAST:%.*]] = phi %struct.S* [ [[TMP3]], [[ENTRY]] ], [ [[OMP_ARRAYCPY_DEST_ELEMENT:%.*]], [[OMP_ARRAYCPY_BODY]] ]
// CHECK1-NEXT:    call void @_ZplRK1SS1_(%struct.S* sret([[STRUCT_S]]) align 4 [[REF_TMP]], %struct.S* nonnull align 4 dereferenceable(4) [[OMP_ARRAYCPY_DESTELEMENTPAST]], %struct.S* nonnull align 4 dereferenceable(4) [[OMP_ARRAYCPY_SRCELEMENTPAST]])
// CHECK1-NEXT:    [[CALL:%.*]] = call nonnull align 4 dereferenceable(4) %struct.S* @_ZN1SaSERKS_(%struct.S* nonnull align 4 dereferenceable(4) [[OMP_ARRAYCPY_DESTELEMENTPAST]], %struct.S* nonnull align 4 dereferenceable(4) [[REF_TMP]])
// CHECK1-NEXT:    call void @_ZN1SD1Ev(%struct.S* nonnull align 4 dereferenceable(4) [[REF_TMP]]) #3
// CHECK1-NEXT:    [[OMP_ARRAYCPY_DEST_ELEMENT]] = getelementptr [[STRUCT_S]], %struct.S* [[OMP_ARRAYCPY_DESTELEMENTPAST]], i32 1
// CHECK1-NEXT:    [[OMP_ARRAYCPY_SRC_ELEMENT]] = getelementptr [[STRUCT_S]], %struct.S* [[OMP_ARRAYCPY_SRCELEMENTPAST]], i32 1
// CHECK1-NEXT:    [[OMP_ARRAYCPY_DONE:%.*]] = icmp eq %struct.S* [[OMP_ARRAYCPY_DEST_ELEMENT]], [[TMP6]]
// CHECK1-NEXT:    br i1 [[OMP_ARRAYCPY_DONE]], label [[OMP_ARRAYCPY_DONE2]], label [[OMP_ARRAYCPY_BODY]]
// CHECK1:       omp.arraycpy.done2:
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@_ZplRK1SS1_
// CHECK1-SAME: (%struct.S* noalias sret([[STRUCT_S:%.*]]) align 4 [[AGG_RESULT:%.*]], %struct.S* nonnull align 4 dereferenceable(4) [[A:%.*]], %struct.S* nonnull align 4 dereferenceable(4) [[B:%.*]]) #[[ATTR7:[0-9]+]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[RESULT_PTR:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[A_ADDR:%.*]] = alloca %struct.S*, align 8
// CHECK1-NEXT:    [[B_ADDR:%.*]] = alloca %struct.S*, align 8
// CHECK1-NEXT:    [[TMP0:%.*]] = bitcast %struct.S* [[AGG_RESULT]] to i8*
// CHECK1-NEXT:    store i8* [[TMP0]], i8** [[RESULT_PTR]], align 8
// CHECK1-NEXT:    store %struct.S* [[A]], %struct.S** [[A_ADDR]], align 8
// CHECK1-NEXT:    store %struct.S* [[B]], %struct.S** [[B_ADDR]], align 8
// CHECK1-NEXT:    [[TMP1:%.*]] = load %struct.S*, %struct.S** [[A_ADDR]], align 8
// CHECK1-NEXT:    call void @_ZN1SC1ERKS_(%struct.S* nonnull align 4 dereferenceable(4) [[AGG_RESULT]], %struct.S* nonnull align 4 dereferenceable(4) [[TMP1]])
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@_ZN1SaSERKS_
// CHECK1-SAME: (%struct.S* nonnull align 4 dereferenceable(4) [[THIS:%.*]], %struct.S* nonnull align 4 dereferenceable(4) [[TMP0:%.*]]) #[[ATTR7]] align 2 {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[THIS_ADDR:%.*]] = alloca %struct.S*, align 8
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca %struct.S*, align 8
// CHECK1-NEXT:    store %struct.S* [[THIS]], %struct.S** [[THIS_ADDR]], align 8
// CHECK1-NEXT:    store %struct.S* [[TMP0]], %struct.S** [[DOTADDR]], align 8
// CHECK1-NEXT:    [[THIS1:%.*]] = load %struct.S*, %struct.S** [[THIS_ADDR]], align 8
// CHECK1-NEXT:    ret %struct.S* [[THIS1]]
//
//
// CHECK1-LABEL: define {{[^@]+}}@.red_init..7
// CHECK1-SAME: (i8* noalias [[TMP0:%.*]], i8* noalias [[TMP1:%.*]]) #[[ATTR5]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[DOTADDR1:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = call i32 @__kmpc_global_thread_num(%struct.ident_t* @[[GLOB1]])
// CHECK1-NEXT:    store i8* [[TMP0]], i8** [[DOTADDR]], align 8
// CHECK1-NEXT:    store i8* [[TMP1]], i8** [[DOTADDR1]], align 8
// CHECK1-NEXT:    [[TMP3:%.*]] = bitcast i8** [[DOTADDR]] to i16**
// CHECK1-NEXT:    [[TMP4:%.*]] = load i16*, i16** [[TMP3]], align 8
// CHECK1-NEXT:    [[TMP5:%.*]] = call i8* @__kmpc_threadprivate_cached(%struct.ident_t* @[[GLOB1]], i32 [[TMP2]], i8* bitcast (i64* @{{reduction_size[.].+[.]}})
// CHECK1-NEXT:    [[TMP6:%.*]] = bitcast i8* [[TMP5]] to i64*
// CHECK1-NEXT:    [[TMP7:%.*]] = load i64, i64* [[TMP6]], align 8
// CHECK1-NEXT:    [[TMP8:%.*]] = getelementptr i16, i16* [[TMP4]], i64 [[TMP7]]
// CHECK1-NEXT:    [[OMP_ARRAYINIT_ISEMPTY:%.*]] = icmp eq i16* [[TMP4]], [[TMP8]]
// CHECK1-NEXT:    br i1 [[OMP_ARRAYINIT_ISEMPTY]], label [[OMP_ARRAYINIT_DONE:%.*]], label [[OMP_ARRAYINIT_BODY:%.*]]
// CHECK1:       omp.arrayinit.body:
// CHECK1-NEXT:    [[OMP_ARRAYCPY_DESTELEMENTPAST:%.*]] = phi i16* [ [[TMP4]], [[ENTRY:%.*]] ], [ [[OMP_ARRAYCPY_DEST_ELEMENT:%.*]], [[OMP_ARRAYINIT_BODY]] ]
// CHECK1-NEXT:    store i16 0, i16* [[OMP_ARRAYCPY_DESTELEMENTPAST]], align 2
// CHECK1-NEXT:    [[OMP_ARRAYCPY_DEST_ELEMENT]] = getelementptr i16, i16* [[OMP_ARRAYCPY_DESTELEMENTPAST]], i32 1
// CHECK1-NEXT:    [[OMP_ARRAYCPY_DONE:%.*]] = icmp eq i16* [[OMP_ARRAYCPY_DEST_ELEMENT]], [[TMP8]]
// CHECK1-NEXT:    br i1 [[OMP_ARRAYCPY_DONE]], label [[OMP_ARRAYINIT_DONE]], label [[OMP_ARRAYINIT_BODY]]
// CHECK1:       omp.arrayinit.done:
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@.red_comb..8
// CHECK1-SAME: (i8* [[TMP0:%.*]], i8* [[TMP1:%.*]]) #[[ATTR5]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[DOTADDR1:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = call i32 @__kmpc_global_thread_num(%struct.ident_t* @[[GLOB1]])
// CHECK1-NEXT:    store i8* [[TMP0]], i8** [[DOTADDR]], align 8
// CHECK1-NEXT:    store i8* [[TMP1]], i8** [[DOTADDR1]], align 8
// CHECK1-NEXT:    [[TMP3:%.*]] = call i8* @__kmpc_threadprivate_cached(%struct.ident_t* @[[GLOB1]], i32 [[TMP2]], i8* bitcast (i64* @{{reduction_size[.].+[.]}})
// CHECK1-NEXT:    [[TMP4:%.*]] = bitcast i8* [[TMP3]] to i64*
// CHECK1-NEXT:    [[TMP5:%.*]] = load i64, i64* [[TMP4]], align 8
// CHECK1-NEXT:    [[TMP6:%.*]] = bitcast i8** [[DOTADDR]] to i16**
// CHECK1-NEXT:    [[TMP7:%.*]] = load i16*, i16** [[TMP6]], align 8
// CHECK1-NEXT:    [[TMP8:%.*]] = bitcast i8** [[DOTADDR1]] to i16**
// CHECK1-NEXT:    [[TMP9:%.*]] = load i16*, i16** [[TMP8]], align 8
// CHECK1-NEXT:    [[TMP10:%.*]] = getelementptr i16, i16* [[TMP7]], i64 [[TMP5]]
// CHECK1-NEXT:    [[OMP_ARRAYCPY_ISEMPTY:%.*]] = icmp eq i16* [[TMP7]], [[TMP10]]
// CHECK1-NEXT:    br i1 [[OMP_ARRAYCPY_ISEMPTY]], label [[OMP_ARRAYCPY_DONE4:%.*]], label [[OMP_ARRAYCPY_BODY:%.*]]
// CHECK1:       omp.arraycpy.body:
// CHECK1-NEXT:    [[OMP_ARRAYCPY_SRCELEMENTPAST:%.*]] = phi i16* [ [[TMP9]], [[ENTRY:%.*]] ], [ [[OMP_ARRAYCPY_SRC_ELEMENT:%.*]], [[OMP_ARRAYCPY_BODY]] ]
// CHECK1-NEXT:    [[OMP_ARRAYCPY_DESTELEMENTPAST:%.*]] = phi i16* [ [[TMP7]], [[ENTRY]] ], [ [[OMP_ARRAYCPY_DEST_ELEMENT:%.*]], [[OMP_ARRAYCPY_BODY]] ]
// CHECK1-NEXT:    [[TMP11:%.*]] = load i16, i16* [[OMP_ARRAYCPY_DESTELEMENTPAST]], align 2
// CHECK1-NEXT:    [[CONV:%.*]] = sext i16 [[TMP11]] to i32
// CHECK1-NEXT:    [[TMP12:%.*]] = load i16, i16* [[OMP_ARRAYCPY_SRCELEMENTPAST]], align 2
// CHECK1-NEXT:    [[CONV2:%.*]] = sext i16 [[TMP12]] to i32
// CHECK1-NEXT:    [[ADD:%.*]] = add nsw i32 [[CONV]], [[CONV2]]
// CHECK1-NEXT:    [[CONV3:%.*]] = trunc i32 [[ADD]] to i16
// CHECK1-NEXT:    store i16 [[CONV3]], i16* [[OMP_ARRAYCPY_DESTELEMENTPAST]], align 2
// CHECK1-NEXT:    [[OMP_ARRAYCPY_DEST_ELEMENT]] = getelementptr i16, i16* [[OMP_ARRAYCPY_DESTELEMENTPAST]], i32 1
// CHECK1-NEXT:    [[OMP_ARRAYCPY_SRC_ELEMENT]] = getelementptr i16, i16* [[OMP_ARRAYCPY_SRCELEMENTPAST]], i32 1
// CHECK1-NEXT:    [[OMP_ARRAYCPY_DONE:%.*]] = icmp eq i16* [[OMP_ARRAYCPY_DEST_ELEMENT]], [[TMP10]]
// CHECK1-NEXT:    br i1 [[OMP_ARRAYCPY_DONE]], label [[OMP_ARRAYCPY_DONE4]], label [[OMP_ARRAYCPY_BODY]]
// CHECK1:       omp.arraycpy.done4:
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@.omp_outlined.
// CHECK1-SAME: (i32* noalias [[DOTGLOBAL_TID_:%.*]], i32* noalias [[DOTBOUND_TID_:%.*]], i32* nonnull align 4 dereferenceable(4) [[A:%.*]], i64 [[VLA:%.*]], i16* nonnull align 2 dereferenceable(2) [[D:%.*]], i8** nonnull align 8 dereferenceable(8) [[DOTTASK_RED_:%.*]]) #[[ATTR8:[0-9]+]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca i32*, align 8
// CHECK1-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca i32*, align 8
// CHECK1-NEXT:    [[A_ADDR:%.*]] = alloca i32*, align 8
// CHECK1-NEXT:    [[VLA_ADDR:%.*]] = alloca i64, align 8
// CHECK1-NEXT:    [[D_ADDR:%.*]] = alloca i16*, align 8
// CHECK1-NEXT:    [[DOTTASK_RED__ADDR:%.*]] = alloca i8**, align 8
// CHECK1-NEXT:    [[AGG_CAPTURED:%.*]] = alloca [[STRUCT_ANON:%.*]], align 8
// CHECK1-NEXT:    store i32* [[DOTGLOBAL_TID_]], i32** [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    store i32* [[DOTBOUND_TID_]], i32** [[DOTBOUND_TID__ADDR]], align 8
// CHECK1-NEXT:    store i32* [[A]], i32** [[A_ADDR]], align 8
// CHECK1-NEXT:    store i64 [[VLA]], i64* [[VLA_ADDR]], align 8
// CHECK1-NEXT:    store i16* [[D]], i16** [[D_ADDR]], align 8
// CHECK1-NEXT:    store i8** [[DOTTASK_RED_]], i8*** [[DOTTASK_RED__ADDR]], align 8
// CHECK1-NEXT:    [[TMP0:%.*]] = load i32*, i32** [[A_ADDR]], align 8
// CHECK1-NEXT:    [[TMP1:%.*]] = load i64, i64* [[VLA_ADDR]], align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = load i16*, i16** [[D_ADDR]], align 8
// CHECK1-NEXT:    [[TMP3:%.*]] = load i8**, i8*** [[DOTTASK_RED__ADDR]], align 8
// CHECK1-NEXT:    [[TMP4:%.*]] = load i8*, i8** [[TMP3]], align 8
// CHECK1-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT_ANON]], %struct.anon* [[AGG_CAPTURED]], i32 0, i32 0
// CHECK1-NEXT:    store i32* [[TMP0]], i32** [[TMP5]], align 8
// CHECK1-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [[STRUCT_ANON]], %struct.anon* [[AGG_CAPTURED]], i32 0, i32 1
// CHECK1-NEXT:    store i64 [[TMP1]], i64* [[TMP6]], align 8
// CHECK1-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [[STRUCT_ANON]], %struct.anon* [[AGG_CAPTURED]], i32 0, i32 2
// CHECK1-NEXT:    store i16* [[TMP2]], i16** [[TMP7]], align 8
// CHECK1-NEXT:    [[TMP8:%.*]] = getelementptr inbounds [[STRUCT_ANON]], %struct.anon* [[AGG_CAPTURED]], i32 0, i32 3
// CHECK1-NEXT:    [[TMP9:%.*]] = load i8*, i8** [[TMP3]], align 8
// CHECK1-NEXT:    store i8* [[TMP9]], i8** [[TMP8]], align 8
// CHECK1-NEXT:    [[TMP10:%.*]] = load i32*, i32** [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    [[TMP11:%.*]] = load i32, i32* [[TMP10]], align 4
// CHECK1-NEXT:    [[TMP12:%.*]] = call i8* @__kmpc_omp_task_alloc(%struct.ident_t* @[[GLOB1]], i32 [[TMP11]], i32 1, i64 48, i64 32, i32 (i32, i8*)* bitcast (i32 (i32, %struct.kmp_task_t_with_privates*)* @.omp_task_entry. to i32 (i32, i8*)*))
// CHECK1-NEXT:    [[TMP13:%.*]] = bitcast i8* [[TMP12]] to %struct.kmp_task_t_with_privates*
// CHECK1-NEXT:    [[TMP14:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASK_T_WITH_PRIVATES:%.*]], %struct.kmp_task_t_with_privates* [[TMP13]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP15:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASK_T:%.*]], %struct.kmp_task_t* [[TMP14]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP16:%.*]] = load i8*, i8** [[TMP15]], align 8
// CHECK1-NEXT:    [[TMP17:%.*]] = bitcast %struct.anon* [[AGG_CAPTURED]] to i8*
// CHECK1-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 [[TMP16]], i8* align 8 [[TMP17]], i64 32, i1 false)
// CHECK1-NEXT:    [[TMP18:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASK_T_WITH_PRIVATES]], %struct.kmp_task_t_with_privates* [[TMP13]], i32 0, i32 1
// CHECK1-NEXT:    [[TMP19:%.*]] = bitcast i8* [[TMP16]] to %struct.anon*
// CHECK1-NEXT:    [[TMP20:%.*]] = getelementptr inbounds [[STRUCT__KMP_PRIVATES_T:%.*]], %struct..kmp_privates.t* [[TMP18]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP21:%.*]] = load i8*, i8** [[TMP3]], align 8
// CHECK1-NEXT:    store i8* [[TMP21]], i8** [[TMP20]], align 8
// CHECK1-NEXT:    call void @__kmpc_omp_task_begin_if0(%struct.ident_t* @[[GLOB1]], i32 [[TMP11]], i8* [[TMP12]])
// CHECK1-NEXT:    [[TMP22:%.*]] = call i32 @.omp_task_entry.(i32 [[TMP11]], %struct.kmp_task_t_with_privates* [[TMP13]]) #[[ATTR3]]
// CHECK1-NEXT:    call void @__kmpc_omp_task_complete_if0(%struct.ident_t* @[[GLOB1]], i32 [[TMP11]], i8* [[TMP12]])
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@__omp_offloading_{{.*}}_main_l{{[0-9]+}}
// CHECK1-SAME: (i32* nonnull align 4 dereferenceable(4) [[A:%.*]], i64 [[VLA:%.*]], i16* nonnull align 2 dereferenceable(2) [[D:%.*]], i8* [[DOTTASK_RED_:%.*]]) #[[ATTR9:[0-9]+]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[A_ADDR:%.*]] = alloca i32*, align 8
// CHECK1-NEXT:    [[VLA_ADDR:%.*]] = alloca i64, align 8
// CHECK1-NEXT:    [[D_ADDR:%.*]] = alloca i16*, align 8
// CHECK1-NEXT:    [[DOTTASK_RED__ADDR:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[I:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    store i32* [[A]], i32** [[A_ADDR]], align 8
// CHECK1-NEXT:    store i64 [[VLA]], i64* [[VLA_ADDR]], align 8
// CHECK1-NEXT:    store i16* [[D]], i16** [[D_ADDR]], align 8
// CHECK1-NEXT:    store i8* [[DOTTASK_RED_]], i8** [[DOTTASK_RED__ADDR]], align 8
// CHECK1-NEXT:    [[TMP0:%.*]] = load i32*, i32** [[A_ADDR]], align 8
// CHECK1-NEXT:    [[TMP1:%.*]] = load i64, i64* [[VLA_ADDR]], align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = load i16*, i16** [[D_ADDR]], align 8
// CHECK1-NEXT:    store i32 0, i32* [[I]], align 4
// CHECK1-NEXT:    br label [[FOR_COND:%.*]]
// CHECK1:       for.cond:
// CHECK1-NEXT:    [[TMP3:%.*]] = load i32, i32* [[I]], align 4
// CHECK1-NEXT:    [[CMP:%.*]] = icmp slt i32 [[TMP3]], 5
// CHECK1-NEXT:    br i1 [[CMP]], label [[FOR_BODY:%.*]], label [[FOR_END:%.*]]
// CHECK1:       for.body:
// CHECK1-NEXT:    [[TMP4:%.*]] = load i32, i32* [[TMP0]], align 4
// CHECK1-NEXT:    [[IDXPROM_I:%.*]] = sext i32 [[TMP4]] to i64
// CHECK1-NEXT:    [[ARRAYIDX_I:%.*]] = getelementptr inbounds i16, i16* [[TMP2]], i64 [[IDXPROM_I]]
// CHECK1-NEXT:    [[TMP5:%.*]] = load i16, i16* [[ARRAYIDX_I]], align 2
// CHECK1-NEXT:    [[CONV:%.*]] = sext i16 [[TMP5]] to i32
// CHECK1-NEXT:    [[TMP6:%.*]] = load i32, i32* [[TMP0]], align 4
// CHECK1-NEXT:    [[ADD:%.*]] = add nsw i32 [[TMP6]], [[CONV]]
// CHECK1-NEXT:    store i32 [[ADD]], i32* [[TMP0]], align 4
// CHECK1-NEXT:    br label [[FOR_INC:%.*]]
// CHECK1:       for.inc:
// CHECK1-NEXT:    [[TMP7:%.*]] = load i32, i32* [[I]], align 4
// CHECK1-NEXT:    [[INC:%.*]] = add nsw i32 [[TMP7]], 1
// CHECK1-NEXT:    store i32 [[INC]], i32* [[I]], align 4
// CHECK1-NEXT:    br label [[FOR_COND]], !llvm.loop [[LOOP3:![0-9]+]]
// CHECK1:       for.end
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@.omp_task_privates_map.
// CHECK1-SAME: (%struct..kmp_privates.t* noalias [[TMP0:%.*]], i8*** noalias [[TMP1:%.*]]) #[[ATTR9:[0-9]+]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca %struct..kmp_privates.t*, align 8
// CHECK1-NEXT:    [[DOTADDR1:%.*]] = alloca i8***, align 8
// CHECK1-NEXT:    store %struct..kmp_privates.t* [[TMP0]], %struct..kmp_privates.t** [[DOTADDR]], align 8
// CHECK1-NEXT:    store i8*** [[TMP1]], i8**** [[DOTADDR1]], align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = load %struct..kmp_privates.t*, %struct..kmp_privates.t** [[DOTADDR]], align 8
// CHECK1-NEXT:    [[TMP3:%.*]] = getelementptr inbounds [[STRUCT__KMP_PRIVATES_T:%.*]], %struct..kmp_privates.t* [[TMP2]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP4:%.*]] = load i8***, i8**** [[DOTADDR1]], align 8
// CHECK1-NEXT:    store i8** [[TMP3]], i8*** [[TMP4]], align 8
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@.omp_task_entry.
// CHECK1-SAME: (i32 [[TMP0:%.*]], %struct.kmp_task_t_with_privates* noalias [[TMP1:%.*]]) #[[ATTR5]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTGLOBAL_TID__ADDR_I:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTPART_ID__ADDR_I:%.*]] = alloca i32*, align 8
// CHECK1-NEXT:    [[DOTPRIVATES__ADDR_I:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[DOTCOPY_FN__ADDR_I:%.*]] = alloca void (i8*, ...)*, align 8
// CHECK1-NEXT:    [[DOTTASK_T__ADDR_I:%.*]] = alloca i8*, align 8
// CHECK1-NEXT:    [[__CONTEXT_ADDR_I:%.*]] = alloca %struct.anon*, align 8
// CHECK1-NEXT:    [[DOTFIRSTPRIV_PTR_ADDR_I:%.*]] = alloca i8**, align 8
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTADDR1:%.*]] = alloca %struct.kmp_task_t_with_privates*, align 8
// CHECK1-NEXT:    store i32 [[TMP0]], i32* [[DOTADDR]], align 4
// CHECK1-NEXT:    store %struct.kmp_task_t_with_privates* [[TMP1]], %struct.kmp_task_t_with_privates** [[DOTADDR1]], align 8
// CHECK1-NEXT:    [[TMP2:%.*]] = load i32, i32* [[DOTADDR]], align 4
// CHECK1-NEXT:    [[TMP3:%.*]] = load %struct.kmp_task_t_with_privates*, %struct.kmp_task_t_with_privates** [[DOTADDR1]], align 8
// CHECK1-NEXT:    [[TMP4:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASK_T_WITH_PRIVATES:%.*]], %struct.kmp_task_t_with_privates* [[TMP3]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASK_T:%.*]], %struct.kmp_task_t* [[TMP4]], i32 0, i32 2
// CHECK1-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASK_T]], %struct.kmp_task_t* [[TMP4]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP7:%.*]] = load i8*, i8** [[TMP6]], align 8
// CHECK1-NEXT:    [[TMP8:%.*]] = bitcast i8* [[TMP7]] to %struct.anon*
// CHECK1-NEXT:    [[TMP9:%.*]] = getelementptr inbounds [[STRUCT_KMP_TASK_T_WITH_PRIVATES]], %struct.kmp_task_t_with_privates* [[TMP3]], i32 0, i32 1
// CHECK1-NEXT:    [[TMP10:%.*]] = bitcast %struct..kmp_privates.t* [[TMP9]] to i8*
// CHECK1-NEXT:    [[TMP11:%.*]] = bitcast %struct.kmp_task_t_with_privates* [[TMP3]] to i8*
// CHECK1-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata [[META3:![0-9]+]])
// CHECK1-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata [[META8:![0-9]+]])
// CHECK1-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata [[META10:![0-9]+]])
// CHECK1-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata [[META12:![0-9]+]])
// CHECK1-NEXT:    store i32 [[TMP2]], i32* [[DOTGLOBAL_TID__ADDR_I]], align 4, !noalias !14
// CHECK1-NEXT:    store i32* [[TMP5]], i32** [[DOTPART_ID__ADDR_I]], align 8, !noalias !14
// CHECK1-NEXT:    store i8* [[TMP10]], i8** [[DOTPRIVATES__ADDR_I]], align 8, !noalias !14
// CHECK1-NEXT:    store void (i8*, ...)* bitcast (void (%struct..kmp_privates.t*, i8***)* @.omp_task_privates_map. to void (i8*, ...)*), void (i8*, ...)** [[DOTCOPY_FN__ADDR_I]], align 8, !noalias !14
// CHECK1-NEXT:    store i8* [[TMP11]], i8** [[DOTTASK_T__ADDR_I]], align 8, !noalias !14
// CHECK1-NEXT:    store %struct.anon* [[TMP8]], %struct.anon** [[__CONTEXT_ADDR_I]], align 8, !noalias !14
// CHECK1-NEXT:    [[TMP12:%.*]] = load %struct.anon*, %struct.anon** [[__CONTEXT_ADDR_I]], align 8, !noalias !14
// CHECK1-NEXT:    [[TMP13:%.*]] = getelementptr inbounds [[STRUCT_ANON:%.*]], %struct.anon* [[TMP12]], i32 0, i32 1
// CHECK1-NEXT:    [[TMP14:%.*]] = load i64, i64* [[TMP13]], align 8
// CHECK1-NEXT:    [[TMP15:%.*]] = load void (i8*, ...)*, void (i8*, ...)** [[DOTCOPY_FN__ADDR_I]], align 8, !noalias !14
// CHECK1-NEXT:    [[TMP16:%.*]] = load i8*, i8** [[DOTPRIVATES__ADDR_I]], align 8, !noalias !14
// CHECK1-NEXT:    [[TMP17:%.*]] = bitcast void (i8*, ...)* [[TMP15]] to void (i8*, i8***)*
// CHECK1-NEXT:    call void [[TMP17]](i8* [[TMP16]], i8*** [[DOTFIRSTPRIV_PTR_ADDR_I]]) #[[ATTR3]]
// CHECK1-NEXT:    [[TMP18:%.*]] = load i8**, i8*** [[DOTFIRSTPRIV_PTR_ADDR_I]], align 8, !noalias !14
// CHECK1-NEXT:    [[TMP19:%.*]] = getelementptr inbounds [[STRUCT_ANON]], %struct.anon* [[TMP12]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP20:%.*]] = load i32*, i32** [[TMP19]], align 8
// CHECK1-NEXT:    [[TMP21:%.*]] = load i8*, i8** [[TMP18]], align 8
// CHECK1-NEXT:    [[TMP22:%.*]] = load i32, i32* [[DOTGLOBAL_TID__ADDR_I]], align 4, !noalias !14
// CHECK1-NEXT:    [[TMP23:%.*]] = bitcast i32* [[TMP20]] to i8*
// CHECK1-NEXT:    [[TMP24:%.*]] = call i8* @__kmpc_task_reduction_get_th_data(i32 [[TMP22]], i8* [[TMP21]], i8* [[TMP23]])
// CHECK1-NEXT:    [[CONV_I:%.*]] = bitcast i8* [[TMP24]] to i32*
// CHECK1-NEXT:    [[TMP25:%.*]] = getelementptr inbounds [[STRUCT_ANON]], %struct.anon* [[TMP12]], i32 0, i32 0
// CHECK1-NEXT:    [[TMP26:%.*]] = load i32*, i32** [[TMP25]], align 8
// CHECK1-NEXT:    [[TMP27:%.*]] = getelementptr inbounds [[STRUCT_ANON]], %struct.anon* [[TMP12]], i32 0, i32 2
// CHECK1-NEXT:    [[TMP28:%.*]] = load i16*, i16** [[TMP27]], align 8
// CHECK1-NEXT:    [[TMP29:%.*]] = load i8*, i8** [[TMP18]], align 8
// CHECK1-NEXT:    call void @__omp_offloading_{{.*}}_main_l{{[0-9]+}}(i32* [[TMP26]], i64 [[TMP14]], i16* [[TMP28]], i8* [[TMP29]]) #[[ATTR3]]
// CHECK1-NEXT:    ret i32 0
//
//
// CHECK1-LABEL: define {{[^@]+}}@_ZN1SC2Ev
// CHECK1-SAME: (%struct.S* nonnull align 4 dereferenceable(4) [[THIS:%.*]]) unnamed_addr #[[ATTR1]] align 2 {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[THIS_ADDR:%.*]] = alloca %struct.S*, align 8
// CHECK1-NEXT:    store %struct.S* [[THIS]], %struct.S** [[THIS_ADDR]], align 8
// CHECK1-NEXT:    [[THIS1:%.*]] = load %struct.S*, %struct.S** [[THIS_ADDR]], align 8
// CHECK1-NEXT:    [[A:%.*]] = getelementptr inbounds [[STRUCT_S:%.*]], %struct.S* [[THIS1]], i32 0, i32 0
// CHECK1-NEXT:    store i32 0, i32* [[A]], align 4
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@_ZN1SD2Ev
// CHECK1-SAME: (%struct.S* nonnull align 4 dereferenceable(4) [[THIS:%.*]]) unnamed_addr #[[ATTR1]] align 2 {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[THIS_ADDR:%.*]] = alloca %struct.S*, align 8
// CHECK1-NEXT:    store %struct.S* [[THIS]], %struct.S** [[THIS_ADDR]], align 8
// CHECK1-NEXT:    [[THIS1:%.*]] = load %struct.S*, %struct.S** [[THIS_ADDR]], align 8
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@_ZN1SC1ERKS_
// CHECK1-SAME: (%struct.S* nonnull align 4 dereferenceable(4) [[THIS:%.*]], %struct.S* nonnull align 4 dereferenceable(4) [[TMP0:%.*]]) unnamed_addr #[[ATTR1]] align 2 {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[THIS_ADDR:%.*]] = alloca %struct.S*, align 8
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca %struct.S*, align 8
// CHECK1-NEXT:    store %struct.S* [[THIS]], %struct.S** [[THIS_ADDR]], align 8
// CHECK1-NEXT:    store %struct.S* [[TMP0]], %struct.S** [[DOTADDR]], align 8
// CHECK1-NEXT:    [[THIS1:%.*]] = load %struct.S*, %struct.S** [[THIS_ADDR]], align 8
// CHECK1-NEXT:    [[TMP1:%.*]] = load %struct.S*, %struct.S** [[DOTADDR]], align 8
// CHECK1-NEXT:    call void @_ZN1SC2ERKS_(%struct.S* nonnull align 4 dereferenceable(4) [[THIS1]], %struct.S* nonnull align 4 dereferenceable(4) [[TMP1]])
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@_ZN1SC2ERKS_
// CHECK1-SAME: (%struct.S* nonnull align 4 dereferenceable(4) [[THIS:%.*]], %struct.S* nonnull align 4 dereferenceable(4) [[TMP0:%.*]]) unnamed_addr #[[ATTR1]] align 2 {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[THIS_ADDR:%.*]] = alloca %struct.S*, align 8
// CHECK1-NEXT:    [[DOTADDR:%.*]] = alloca %struct.S*, align 8
// CHECK1-NEXT:    store %struct.S* [[THIS]], %struct.S** [[THIS_ADDR]], align 8
// CHECK1-NEXT:    store %struct.S* [[TMP0]], %struct.S** [[DOTADDR]], align 8
// CHECK1-NEXT:    [[THIS1:%.*]] = load %struct.S*, %struct.S** [[THIS_ADDR]], align 8
// CHECK1-NEXT:    ret void
//
