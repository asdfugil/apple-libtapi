; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-vectorizer -S -mtriple=x86_64-- -mattr=+sse2 | FileCheck %s --check-prefixes=SSE
; RUN: opt < %s -slp-vectorizer -S -mtriple=x86_64-- -mattr=+avx  | FileCheck %s --check-prefixes=AVX
; RUN: opt < %s -slp-vectorizer -S -mtriple=x86_64-- -mattr=+avx2 | FileCheck %s --check-prefixes=AVX

; PR38821

define <2 x i64> @load_00123456(ptr nocapture noundef readonly %data) {
; SSE-LABEL: @load_00123456(
; SSE-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i16, ptr [[DATA:%.*]], i64 1
; SSE-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i16, ptr [[DATA]], i64 2
; SSE-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds i16, ptr [[DATA]], i64 3
; SSE-NEXT:    [[ARRAYIDX4:%.*]] = getelementptr inbounds i16, ptr [[DATA]], i64 4
; SSE-NEXT:    [[ARRAYIDX5:%.*]] = getelementptr inbounds i16, ptr [[DATA]], i64 5
; SSE-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds i16, ptr [[DATA]], i64 6
; SSE-NEXT:    [[T0:%.*]] = load i16, ptr [[DATA]], align 2
; SSE-NEXT:    [[T1:%.*]] = load i16, ptr [[ARRAYIDX1]], align 2
; SSE-NEXT:    [[T2:%.*]] = load i16, ptr [[ARRAYIDX2]], align 2
; SSE-NEXT:    [[T3:%.*]] = load i16, ptr [[ARRAYIDX3]], align 2
; SSE-NEXT:    [[T4:%.*]] = load i16, ptr [[ARRAYIDX4]], align 2
; SSE-NEXT:    [[T5:%.*]] = load i16, ptr [[ARRAYIDX5]], align 2
; SSE-NEXT:    [[T6:%.*]] = load i16, ptr [[ARRAYIDX6]], align 2
; SSE-NEXT:    [[VECINIT0_I_I:%.*]] = insertelement <8 x i16> undef, i16 [[T0]], i64 0
; SSE-NEXT:    [[VECINIT1_I_I:%.*]] = insertelement <8 x i16> [[VECINIT0_I_I]], i16 [[T0]], i64 1
; SSE-NEXT:    [[VECINIT2_I_I:%.*]] = insertelement <8 x i16> [[VECINIT1_I_I]], i16 [[T1]], i64 2
; SSE-NEXT:    [[VECINIT3_I_I:%.*]] = insertelement <8 x i16> [[VECINIT2_I_I]], i16 [[T2]], i64 3
; SSE-NEXT:    [[VECINIT4_I_I:%.*]] = insertelement <8 x i16> [[VECINIT3_I_I]], i16 [[T3]], i64 4
; SSE-NEXT:    [[VECINIT5_I_I:%.*]] = insertelement <8 x i16> [[VECINIT4_I_I]], i16 [[T4]], i64 5
; SSE-NEXT:    [[VECINIT6_I_I:%.*]] = insertelement <8 x i16> [[VECINIT5_I_I]], i16 [[T5]], i64 6
; SSE-NEXT:    [[VECINIT7_I_I:%.*]] = insertelement <8 x i16> [[VECINIT6_I_I]], i16 [[T6]], i64 7
; SSE-NEXT:    [[T7:%.*]] = bitcast <8 x i16> [[VECINIT7_I_I]] to <2 x i64>
; SSE-NEXT:    ret <2 x i64> [[T7]]
;
; AVX-LABEL: @load_00123456(
; AVX-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i16, ptr [[DATA:%.*]], i64 2
; AVX-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds i16, ptr [[DATA]], i64 3
; AVX-NEXT:    [[TMP1:%.*]] = load <2 x i16>, ptr [[DATA]], align 2
; AVX-NEXT:    [[T2:%.*]] = load i16, ptr [[ARRAYIDX2]], align 2
; AVX-NEXT:    [[TMP2:%.*]] = load <4 x i16>, ptr [[ARRAYIDX3]], align 2
; AVX-NEXT:    [[TMP3:%.*]] = shufflevector <2 x i16> [[TMP1]], <2 x i16> poison, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX-NEXT:    [[VECINIT2_I_I2:%.*]] = shufflevector <8 x i16> [[TMP3]], <8 x i16> [[TMP3]], <8 x i32> <i32 0, i32 8, i32 9, i32 3, i32 4, i32 5, i32 6, i32 7>
; AVX-NEXT:    [[VECINIT3_I_I:%.*]] = insertelement <8 x i16> [[VECINIT2_I_I2]], i16 [[T2]], i64 3
; AVX-NEXT:    [[TMP4:%.*]] = shufflevector <4 x i16> [[TMP2]], <4 x i16> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX-NEXT:    [[VECINIT7_I_I1:%.*]] = shufflevector <8 x i16> [[VECINIT3_I_I]], <8 x i16> [[TMP4]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
; AVX-NEXT:    [[T7:%.*]] = bitcast <8 x i16> [[VECINIT7_I_I1]] to <2 x i64>
; AVX-NEXT:    ret <2 x i64> [[T7]]
;
  %arrayidx1 = getelementptr inbounds i16, ptr %data, i64 1
  %arrayidx2 = getelementptr inbounds i16, ptr %data, i64 2
  %arrayidx3 = getelementptr inbounds i16, ptr %data, i64 3
  %arrayidx4 = getelementptr inbounds i16, ptr %data, i64 4
  %arrayidx5 = getelementptr inbounds i16, ptr %data, i64 5
  %arrayidx6 = getelementptr inbounds i16, ptr %data, i64 6

  %t0 = load i16, ptr %data, align 2
  %t1 = load i16, ptr %arrayidx1, align 2
  %t2 = load i16, ptr %arrayidx2, align 2
  %t3 = load i16, ptr %arrayidx3, align 2
  %t4 = load i16, ptr %arrayidx4, align 2
  %t5 = load i16, ptr %arrayidx5, align 2
  %t6 = load i16, ptr %arrayidx6, align 2

  %vecinit0.i.i = insertelement <8 x i16> undef, i16 %t0, i64 0
  %vecinit1.i.i = insertelement <8 x i16> %vecinit0.i.i, i16 %t0, i64 1
  %vecinit2.i.i = insertelement <8 x i16> %vecinit1.i.i, i16 %t1, i64 2
  %vecinit3.i.i = insertelement <8 x i16> %vecinit2.i.i, i16 %t2, i64 3
  %vecinit4.i.i = insertelement <8 x i16> %vecinit3.i.i, i16 %t3, i64 4
  %vecinit5.i.i = insertelement <8 x i16> %vecinit4.i.i, i16 %t4, i64 5
  %vecinit6.i.i = insertelement <8 x i16> %vecinit5.i.i, i16 %t5, i64 6
  %vecinit7.i.i = insertelement <8 x i16> %vecinit6.i.i, i16 %t6, i64 7
  %t7 = bitcast <8 x i16> %vecinit7.i.i to <2 x i64>
  ret <2 x i64> %t7
}
