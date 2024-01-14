; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -memcpyopt -S -verify-memoryssa | FileCheck %s

; All the stores in this example should be merged into a single memset.

target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:128:128"
target triple = "i386-apple-darwin8"

define void @test1(i8 signext  %c) nounwind  {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[X:%.*]] = alloca [19 x i8], align 1
; CHECK-NEXT:    [[TMP:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 1
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 2
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 3
; CHECK-NEXT:    [[TMP17:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 4
; CHECK-NEXT:    [[TMP21:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 5
; CHECK-NEXT:    [[TMP25:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 6
; CHECK-NEXT:    [[TMP29:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 7
; CHECK-NEXT:    [[TMP33:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 8
; CHECK-NEXT:    [[TMP37:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 9
; CHECK-NEXT:    [[TMP41:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 10
; CHECK-NEXT:    [[TMP45:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 11
; CHECK-NEXT:    [[TMP49:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 12
; CHECK-NEXT:    [[TMP53:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 13
; CHECK-NEXT:    [[TMP57:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 14
; CHECK-NEXT:    [[TMP61:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 15
; CHECK-NEXT:    [[TMP65:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 16
; CHECK-NEXT:    [[TMP69:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 17
; CHECK-NEXT:    [[TMP73:%.*]] = getelementptr [19 x i8], ptr [[X]], i32 0, i32 18
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[TMP]], i8 [[C:%.*]], i64 19, i1 false)
; CHECK-NEXT:    [[TMP76:%.*]] = call i32 (...) @bar(ptr [[X]]) #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    ret void
;
entry:
  %x = alloca [19 x i8]		; <ptr> [#uses=20]
  %tmp = getelementptr [19 x i8], ptr %x, i32 0, i32 0		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp, align 1
  %tmp5 = getelementptr [19 x i8], ptr %x, i32 0, i32 1		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp5, align 1
  %tmp9 = getelementptr [19 x i8], ptr %x, i32 0, i32 2		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp9, align 1
  %tmp13 = getelementptr [19 x i8], ptr %x, i32 0, i32 3		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp13, align 1
  %tmp17 = getelementptr [19 x i8], ptr %x, i32 0, i32 4		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp17, align 1
  %tmp21 = getelementptr [19 x i8], ptr %x, i32 0, i32 5		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp21, align 1
  %tmp25 = getelementptr [19 x i8], ptr %x, i32 0, i32 6		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp25, align 1
  %tmp29 = getelementptr [19 x i8], ptr %x, i32 0, i32 7		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp29, align 1
  %tmp33 = getelementptr [19 x i8], ptr %x, i32 0, i32 8		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp33, align 1
  %tmp37 = getelementptr [19 x i8], ptr %x, i32 0, i32 9		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp37, align 1
  %tmp41 = getelementptr [19 x i8], ptr %x, i32 0, i32 10		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp41, align 1
  %tmp45 = getelementptr [19 x i8], ptr %x, i32 0, i32 11		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp45, align 1
  %tmp49 = getelementptr [19 x i8], ptr %x, i32 0, i32 12		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp49, align 1
  %tmp53 = getelementptr [19 x i8], ptr %x, i32 0, i32 13		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp53, align 1
  %tmp57 = getelementptr [19 x i8], ptr %x, i32 0, i32 14		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp57, align 1
  %tmp61 = getelementptr [19 x i8], ptr %x, i32 0, i32 15		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp61, align 1
  %tmp65 = getelementptr [19 x i8], ptr %x, i32 0, i32 16		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp65, align 1
  %tmp69 = getelementptr [19 x i8], ptr %x, i32 0, i32 17		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp69, align 1
  %tmp73 = getelementptr [19 x i8], ptr %x, i32 0, i32 18		; <ptr> [#uses=1]
  store i8 %c, ptr %tmp73, align 1
  %tmp76 = call i32 (...) @bar( ptr %x ) nounwind
  ret void
}

declare i32 @bar(...)

%struct.MV = type { i16, i16 }


define void @test2() nounwind  {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[REF_IDX:%.*]] = alloca [8 x i8], align 1
; CHECK-NEXT:    [[LEFT_MVD:%.*]] = alloca [8 x %struct.MV], align 8
; CHECK-NEXT:    [[UP_MVD:%.*]] = alloca [8 x %struct.MV], align 8
; CHECK-NEXT:    [[TMP20:%.*]] = getelementptr [8 x i8], ptr [[REF_IDX]], i32 0, i32 7
; CHECK-NEXT:    [[TMP23:%.*]] = getelementptr [8 x i8], ptr [[REF_IDX]], i32 0, i32 6
; CHECK-NEXT:    [[TMP26:%.*]] = getelementptr [8 x i8], ptr [[REF_IDX]], i32 0, i32 5
; CHECK-NEXT:    [[TMP29:%.*]] = getelementptr [8 x i8], ptr [[REF_IDX]], i32 0, i32 4
; CHECK-NEXT:    [[TMP32:%.*]] = getelementptr [8 x i8], ptr [[REF_IDX]], i32 0, i32 3
; CHECK-NEXT:    [[TMP35:%.*]] = getelementptr [8 x i8], ptr [[REF_IDX]], i32 0, i32 2
; CHECK-NEXT:    [[TMP38:%.*]] = getelementptr [8 x i8], ptr [[REF_IDX]], i32 0, i32 1
; CHECK-NEXT:    [[TMP41:%.*]] = getelementptr [8 x i8], ptr [[REF_IDX]], i32 0, i32 0
; CHECK-NEXT:    [[TMP43:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 7, i32 0
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 1 [[TMP41]], i8 -1, i64 8, i1 false)
; CHECK-NEXT:    [[TMP46:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 7, i32 1
; CHECK-NEXT:    [[TMP57:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 6, i32 0
; CHECK-NEXT:    [[TMP60:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 6, i32 1
; CHECK-NEXT:    [[TMP71:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 5, i32 0
; CHECK-NEXT:    [[TMP74:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 5, i32 1
; CHECK-NEXT:    [[TMP85:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 4, i32 0
; CHECK-NEXT:    [[TMP88:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 4, i32 1
; CHECK-NEXT:    [[TMP99:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 3, i32 0
; CHECK-NEXT:    [[TMP102:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 3, i32 1
; CHECK-NEXT:    [[TMP113:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 2, i32 0
; CHECK-NEXT:    [[TMP116:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 2, i32 1
; CHECK-NEXT:    [[TMP127:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 1, i32 0
; CHECK-NEXT:    [[TMP130:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 1, i32 1
; CHECK-NEXT:    [[TMP141:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 0, i32 0
; CHECK-NEXT:    [[TMP144:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 0, i32 1
; CHECK-NEXT:    [[TMP148:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 7, i32 0
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 8 [[TMP141]], i8 0, i64 32, i1 false)
; CHECK-NEXT:    [[TMP151:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 7, i32 1
; CHECK-NEXT:    [[TMP162:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 6, i32 0
; CHECK-NEXT:    [[TMP165:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 6, i32 1
; CHECK-NEXT:    [[TMP176:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 5, i32 0
; CHECK-NEXT:    [[TMP179:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 5, i32 1
; CHECK-NEXT:    [[TMP190:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 4, i32 0
; CHECK-NEXT:    [[TMP193:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 4, i32 1
; CHECK-NEXT:    [[TMP204:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 3, i32 0
; CHECK-NEXT:    [[TMP207:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 3, i32 1
; CHECK-NEXT:    [[TMP218:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 2, i32 0
; CHECK-NEXT:    [[TMP221:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 2, i32 1
; CHECK-NEXT:    [[TMP232:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 1, i32 0
; CHECK-NEXT:    [[TMP235:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 1, i32 1
; CHECK-NEXT:    [[TMP246:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 0, i32 0
; CHECK-NEXT:    [[TMP249:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 0, i32 1
; CHECK-NEXT:    [[UP_MVD252:%.*]] = getelementptr [8 x %struct.MV], ptr [[UP_MVD]], i32 0, i32 0
; CHECK-NEXT:    [[LEFT_MVD253:%.*]] = getelementptr [8 x %struct.MV], ptr [[LEFT_MVD]], i32 0, i32 0
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 8 [[TMP246]], i8 0, i64 32, i1 false)
; CHECK-NEXT:    call void @foo(ptr [[UP_MVD252]], ptr [[LEFT_MVD253]], ptr [[TMP41]]) #[[ATTR0]]
; CHECK-NEXT:    ret void
;
entry:
  %ref_idx = alloca [8 x i8]		; <ptr> [#uses=8]
  %left_mvd = alloca [8 x %struct.MV]		; <ptr> [#uses=17]
  %up_mvd = alloca [8 x %struct.MV]		; <ptr> [#uses=17]
  %tmp20 = getelementptr [8 x i8], ptr %ref_idx, i32 0, i32 7		; <ptr> [#uses=1]
  store i8 -1, ptr %tmp20, align 1
  %tmp23 = getelementptr [8 x i8], ptr %ref_idx, i32 0, i32 6		; <ptr> [#uses=1]
  store i8 -1, ptr %tmp23, align 1
  %tmp26 = getelementptr [8 x i8], ptr %ref_idx, i32 0, i32 5		; <ptr> [#uses=1]
  store i8 -1, ptr %tmp26, align 1
  %tmp29 = getelementptr [8 x i8], ptr %ref_idx, i32 0, i32 4		; <ptr> [#uses=1]
  store i8 -1, ptr %tmp29, align 1
  %tmp32 = getelementptr [8 x i8], ptr %ref_idx, i32 0, i32 3		; <ptr> [#uses=1]
  store i8 -1, ptr %tmp32, align 1
  %tmp35 = getelementptr [8 x i8], ptr %ref_idx, i32 0, i32 2		; <ptr> [#uses=1]
  store i8 -1, ptr %tmp35, align 1
  %tmp38 = getelementptr [8 x i8], ptr %ref_idx, i32 0, i32 1		; <ptr> [#uses=1]
  store i8 -1, ptr %tmp38, align 1
  %tmp41 = getelementptr [8 x i8], ptr %ref_idx, i32 0, i32 0		; <ptr> [#uses=2]
  store i8 -1, ptr %tmp41, align 1
  %tmp43 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 7, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp43, align 2
  %tmp46 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 7, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp46, align 2
  %tmp57 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 6, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp57, align 2
  %tmp60 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 6, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp60, align 2
  %tmp71 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 5, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp71, align 2
  %tmp74 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 5, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp74, align 2
  %tmp85 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 4, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp85, align 2
  %tmp88 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 4, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp88, align 2
  %tmp99 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 3, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp99, align 2
  %tmp102 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 3, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp102, align 2
  %tmp113 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 2, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp113, align 2
  %tmp116 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 2, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp116, align 2
  %tmp127 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 1, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp127, align 2
  %tmp130 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 1, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp130, align 2
  %tmp141 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 0, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp141, align 8
  %tmp144 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 0, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp144, align 2
  %tmp148 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 7, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp148, align 2
  %tmp151 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 7, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp151, align 2
  %tmp162 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 6, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp162, align 2
  %tmp165 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 6, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp165, align 2
  %tmp176 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 5, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp176, align 2
  %tmp179 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 5, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp179, align 2
  %tmp190 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 4, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp190, align 2
  %tmp193 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 4, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp193, align 2
  %tmp204 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 3, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp204, align 2
  %tmp207 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 3, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp207, align 2
  %tmp218 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 2, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp218, align 2
  %tmp221 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 2, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp221, align 2
  %tmp232 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 1, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp232, align 2
  %tmp235 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 1, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp235, align 2
  %tmp246 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 0, i32 0		; <ptr> [#uses=1]
  store i16 0, ptr %tmp246, align 8
  %tmp249 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 0, i32 1		; <ptr> [#uses=1]
  store i16 0, ptr %tmp249, align 2
  %up_mvd252 = getelementptr [8 x %struct.MV], ptr %up_mvd, i32 0, i32 0		; <ptr> [#uses=1]
  %left_mvd253 = getelementptr [8 x %struct.MV], ptr %left_mvd, i32 0, i32 0		; <ptr> [#uses=1]
  call void @foo( ptr %up_mvd252, ptr %left_mvd253, ptr %tmp41 ) nounwind
  ret void

}

declare void @foo(ptr, ptr, ptr)


; Store followed by memset.
define void @test3(ptr nocapture %P) nounwind ssp {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 1
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i32, ptr [[P]], i64 2
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 4 [[ARRAYIDX]], i8 0, i64 15, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  %arrayidx = getelementptr inbounds i32, ptr %P, i64 1
  store i32 0, ptr %arrayidx, align 4
  %add.ptr = getelementptr inbounds i32, ptr %P, i64 2
  tail call void @llvm.memset.p0.i64(ptr %add.ptr, i8 0, i64 11, i1 false)
  ret void
}

; store followed by memset, different offset scenario
define void @test4(ptr nocapture %P) nounwind ssp {
; CHECK-LABEL: @test4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 1
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 4 [[P]], i8 0, i64 15, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  store i32 0, ptr %P, align 4
  %add.ptr = getelementptr inbounds i32, ptr %P, i64 1
  tail call void @llvm.memset.p0.i64(ptr %add.ptr, i8 0, i64 11, i1 false)
  ret void
}

declare void @llvm.memset.p0.i64(ptr nocapture, i8, i64, i1) nounwind

; Memset followed by store.
define void @test5(ptr nocapture %P) nounwind ssp {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 2
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[P]], i64 1
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 4 [[ARRAYIDX]], i8 0, i64 15, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr = getelementptr inbounds i32, ptr %P, i64 2
  tail call void @llvm.memset.p0.i64(ptr %add.ptr, i8 0, i64 11, i1 false)
  %arrayidx = getelementptr inbounds i32, ptr %P, i64 1
  store i32 0, ptr %arrayidx, align 4
  ret void
}

;; Memset followed by memset.
define void @test6(ptr nocapture %P) nounwind ssp {
; CHECK-LABEL: @test6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 3
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr [[P]], i8 0, i64 24, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  tail call void @llvm.memset.p0.i64(ptr %P, i8 0, i64 12, i1 false)
  %add.ptr = getelementptr inbounds i32, ptr %P, i64 3
  tail call void @llvm.memset.p0.i64(ptr %add.ptr, i8 0, i64 12, i1 false)
  ret void
}

; More aggressive heuristic
; rdar://9892684
define void @test7(ptr nocapture %c) nounwind optsize {
; CHECK-LABEL: @test7(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[C:%.*]], i32 1
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i32, ptr [[C]], i32 2
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i32, ptr [[C]], i32 3
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i32, ptr [[C]], i32 4
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 4 [[C]], i8 -1, i64 20, i1 false)
; CHECK-NEXT:    ret void
;
  store i32 -1, ptr %c, align 4
  %1 = getelementptr inbounds i32, ptr %c, i32 1
  store i32 -1, ptr %1, align 4
  %2 = getelementptr inbounds i32, ptr %c, i32 2
  store i32 -1, ptr %2, align 4
  %3 = getelementptr inbounds i32, ptr %c, i32 3
  store i32 -1, ptr %3, align 4
  %4 = getelementptr inbounds i32, ptr %c, i32 4
  store i32 -1, ptr %4, align 4
  ret void
}

%struct.test8 = type { [4 x i32] }

define void @test8() {
; CHECK-LABEL: @test8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MEMTMP:%.*]] = alloca [[STRUCT_TEST8:%.*]], align 16
; CHECK-NEXT:    store <4 x i32> <i32 -1, i32 -1, i32 -1, i32 -1>, ptr [[MEMTMP]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %memtmp = alloca %struct.test8, align 16
  store <4 x i32> <i32 -1, i32 -1, i32 -1, i32 -1>, ptr %memtmp, align 16
  ret void
}

@test9buf = internal unnamed_addr global [16 x i64] zeroinitializer, align 16

define void @test9() nounwind {
; CHECK-LABEL: @test9(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 16 @test9buf, i8 -1, i64 16, i1 false)
; CHECK-NEXT:    ret void
;
  store i8 -1, ptr @test9buf, align 16
  store i8 -1, ptr getelementptr (i8, ptr @test9buf, i64 1), align 1
  store i8 -1, ptr getelementptr (i8, ptr @test9buf, i64 2), align 2
  store i8 -1, ptr getelementptr (i8, ptr @test9buf, i64 3), align 1
  store i8 -1, ptr getelementptr (i8, ptr @test9buf, i64 4), align 4
  store i8 -1, ptr getelementptr (i8, ptr @test9buf, i64 5), align 1
  store i8 -1, ptr getelementptr (i8, ptr @test9buf, i64 6), align 2
  store i8 -1, ptr getelementptr (i8, ptr @test9buf, i64 7), align 1
  store i8 -1, ptr getelementptr inbounds ([16 x i64], ptr @test9buf, i64 0, i64 1), align 8
  store i8 -1, ptr getelementptr (i8, ptr @test9buf, i64 9), align 1
  store i8 -1, ptr getelementptr (i8, ptr @test9buf, i64 10), align 2
  store i8 -1, ptr getelementptr (i8, ptr @test9buf, i64 11), align 1
  store i8 -1, ptr getelementptr (i8, ptr @test9buf, i64 12), align 4
  store i8 -1, ptr getelementptr (i8, ptr @test9buf, i64 13), align 1
  store i8 -1, ptr getelementptr (i8, ptr @test9buf, i64 14), align 2
  store i8 -1, ptr getelementptr (i8, ptr @test9buf, i64 15), align 1
  ret void
}

; PR19092
define void @test10(ptr nocapture %P) nounwind {
; CHECK-LABEL: @test10(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr [[P:%.*]], i8 0, i64 42, i1 false)
; CHECK-NEXT:    ret void
;
  tail call void @llvm.memset.p0.i64(ptr %P, i8 0, i64 42, i1 false)
  tail call void @llvm.memset.p0.i64(ptr %P, i8 0, i64 23, i1 false)
  ret void
}

; Memset followed by odd store.
define void @test11(ptr nocapture %P) nounwind ssp {
; CHECK-LABEL: @test11(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 3
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 4 [[P]], i8 1, i64 23, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr = getelementptr inbounds i32, ptr %P, i64 3
  tail call void @llvm.memset.p0.i64(ptr %add.ptr, i8 1, i64 11, i1 false)
  store i96 310698676526526814092329217, ptr %P, align 4
  ret void
}

; Alignment should be preserved when there is a store with default align
define void @test12(ptr nocapture %P) nounwind ssp {
; CHECK-LABEL: @test12(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 1
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 4 [[P]], i8 0, i64 15, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  store i32 0, ptr %P
  %add.ptr = getelementptr inbounds i32, ptr %P, i64 1
  tail call void @llvm.memset.p0.i64(ptr %add.ptr, i8 0, i64 11, i1 false)
  ret void
}
