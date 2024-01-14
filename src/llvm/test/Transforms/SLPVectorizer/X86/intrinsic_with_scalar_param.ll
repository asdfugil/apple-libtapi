; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-vectorizer -S -mtriple=x86_64-apple-macosx10.8.0 -slp-threshold=-8 | FileCheck %s

declare float @llvm.powi.f32.i32(float, i32)
define void @vec_powi_f32(float* %a, float* %c, i32 %P) {
; CHECK-LABEL: @vec_powi_f32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast float* [[A:%.*]] to <4 x float>*
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x float>, <4 x float>* [[TMP0]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = call <4 x float> @llvm.powi.v4f32.i32(<4 x float> [[TMP1]], i32 [[P:%.*]])
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float* [[C:%.*]] to <4 x float>*
; CHECK-NEXT:    store <4 x float> [[TMP2]], <4 x float>* [[TMP3]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %i0 = load float, float* %a, align 4
  %call1 = tail call float @llvm.powi.f32.i32(float %i0,i32 %P)

  %arrayidx2 = getelementptr inbounds float, float* %a, i32 1
  %i2 = load float, float* %arrayidx2, align 4
  %call2 = tail call float @llvm.powi.f32.i32(float %i2,i32 %P)

  %arrayidx4 = getelementptr inbounds float, float* %a, i32 2
  %i4 = load float, float* %arrayidx4, align 4
  %call3 = tail call float @llvm.powi.f32.i32(float %i4,i32 %P)

  %arrayidx6 = getelementptr inbounds float, float* %a, i32 3
  %i6 = load float, float* %arrayidx6, align 4
  %call4 = tail call float @llvm.powi.f32.i32(float %i6,i32 %P)

  store float %call1, float* %c, align 4
  %arrayidx8 = getelementptr inbounds float, float* %c, i32 1
  store float %call2, float* %arrayidx8, align 4
  %arrayidx9 = getelementptr inbounds float, float* %c, i32 2
  store float %call3, float* %arrayidx9, align 4
  %arrayidx10 = getelementptr inbounds float, float* %c, i32 3
  store float %call4, float* %arrayidx10, align 4
  ret void
}
