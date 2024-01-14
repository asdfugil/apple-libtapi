; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt --slp-vectorizer -mtriple=x86_64-unknown-linux-gnu -o - -S < %s | FileCheck %s

@b = common dso_local global i32* null, align 8
@e = common dso_local global float 0.000000e+00, align 4
@c = common dso_local global float 0.000000e+00, align 4
@g = common dso_local global float 0.000000e+00, align 4
@d = common dso_local global float 0.000000e+00, align 4
@f = common dso_local global float 0.000000e+00, align 4
@a = common dso_local global i32 0, align 4
@h = common dso_local global float 0.000000e+00, align 4

define dso_local void @j() local_unnamed_addr {
; CHECK-LABEL: @j(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32*, i32** @b, align 8
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, i32* [[TMP0]], i64 4
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i32, i32* [[TMP0]], i64 12
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* @a, align 4
; CHECK-NEXT:    [[CONV19:%.*]] = sitofp i32 [[TMP1]] to float
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast i32* [[ARRAYIDX]] to <2 x i32>*
; CHECK-NEXT:    [[TMP3:%.*]] = load <2 x i32>, <2 x i32>* [[TMP2]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast i32* [[ARRAYIDX1]] to <2 x i32>*
; CHECK-NEXT:    [[TMP5:%.*]] = load <2 x i32>, <2 x i32>* [[TMP4]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = add nsw <2 x i32> [[TMP5]], [[TMP3]]
; CHECK-NEXT:    [[TMP7:%.*]] = sitofp <2 x i32> [[TMP6]] to <2 x float>
; CHECK-NEXT:    [[TMP8:%.*]] = fmul <2 x float> [[TMP7]], <float 1.000000e+01, float 1.000000e+01>
; CHECK-NEXT:    [[TMP9:%.*]] = fsub <2 x float> <float 1.000000e+00, float 0.000000e+00>, [[TMP8]]
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <2 x float> [[TMP9]], <2 x float> poison, <4 x i32> <i32 1, i32 0, i32 1, i32 0>
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <4 x float> [[SHUFFLE]], i32 1
; CHECK-NEXT:    store float [[TMP10]], float* @g, align 4
; CHECK-NEXT:    [[TMP11:%.*]] = fadd <4 x float> [[SHUFFLE]], <float -1.000000e+00, float -1.000000e+00, float 1.000000e+00, float 1.000000e+00>
; CHECK-NEXT:    [[TMP12:%.*]] = extractelement <4 x float> [[TMP11]], i32 2
; CHECK-NEXT:    store float [[TMP12]], float* @c, align 4
; CHECK-NEXT:    [[TMP13:%.*]] = extractelement <4 x float> [[TMP11]], i32 0
; CHECK-NEXT:    store float [[TMP13]], float* @d, align 4
; CHECK-NEXT:    [[TMP14:%.*]] = extractelement <4 x float> [[TMP11]], i32 3
; CHECK-NEXT:    store float [[TMP14]], float* @e, align 4
; CHECK-NEXT:    [[TMP15:%.*]] = extractelement <4 x float> [[TMP11]], i32 1
; CHECK-NEXT:    store float [[TMP15]], float* @f, align 4
; CHECK-NEXT:    [[TMP16:%.*]] = insertelement <4 x float> <float poison, float -1.000000e+00, float poison, float -1.000000e+00>, float [[CONV19]], i32 0
; CHECK-NEXT:    [[TMP17:%.*]] = shufflevector <4 x float> [[TMP16]], <4 x float> [[SHUFFLE]], <4 x i32> <i32 0, i32 1, i32 4, i32 3>
; CHECK-NEXT:    [[TMP18:%.*]] = fsub <4 x float> [[TMP11]], [[TMP17]]
; CHECK-NEXT:    [[TMP19:%.*]] = fadd <4 x float> [[TMP11]], [[TMP17]]
; CHECK-NEXT:    [[TMP20:%.*]] = shufflevector <4 x float> [[TMP18]], <4 x float> [[TMP19]], <4 x i32> <i32 0, i32 5, i32 2, i32 7>
; CHECK-NEXT:    [[TMP21:%.*]] = fptosi <4 x float> [[TMP20]] to <4 x i32>
; CHECK-NEXT:    [[TMP22:%.*]] = bitcast i32* [[ARRAYIDX1]] to <4 x i32>*
; CHECK-NEXT:    store <4 x i32> [[TMP21]], <4 x i32>* [[TMP22]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %0 = load i32*, i32** @b, align 8
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 4
  %1 = load i32, i32* %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds i32, i32* %0, i64 12
  %2 = load i32, i32* %arrayidx1, align 4
  %add = add nsw i32 %2, %1
  %conv = sitofp i32 %add to float
  %mul = fmul float %conv, 1.000000e+01
  %arrayidx2 = getelementptr inbounds i32, i32* %0, i64 5
  %3 = load i32, i32* %arrayidx2, align 4
  %arrayidx3 = getelementptr inbounds i32, i32* %0, i64 13
  %4 = load i32, i32* %arrayidx3, align 4
  %add4 = add nsw i32 %4, %3
  %conv5 = sitofp i32 %add4 to float
  %mul6 = fmul float %conv5, 1.000000e+01
  %sub = fsub float 0.000000e+00, %mul6
  %sub7 = fsub float 1.000000e+00, %mul
  store float %sub7, float* @g, align 4
  %add9 = fadd float %sub, 1.000000e+00
  store float %add9, float* @c, align 4
  %sub10 = fadd float %sub, -1.000000e+00
  store float %sub10, float* @d, align 4
  %add11 = fadd float %sub7, 1.000000e+00
  store float %add11, float* @e, align 4
  %sub12 = fadd float %sub7, -1.000000e+00
  store float %sub12, float* @f, align 4
  %sub13 = fsub float %add9, %sub
  %conv14 = fptosi float %sub13 to i32
  %arrayidx15 = getelementptr inbounds i32, i32* %0, i64 14
  store i32 %conv14, i32* %arrayidx15, align 4
  %sub16 = fadd float %add11, -1.000000e+00
  %conv17 = fptosi float %sub16 to i32
  %arrayidx18 = getelementptr inbounds i32, i32* %0, i64 15
  store i32 %conv17, i32* %arrayidx18, align 4
  %5 = load i32, i32* @a, align 4
  %conv19 = sitofp i32 %5 to float
  %sub20 = fsub float %sub10, %conv19
  %conv21 = fptosi float %sub20 to i32
  store i32 %conv21, i32* %arrayidx1, align 4
  %sub23 = fadd float %sub12, -1.000000e+00
  %conv24 = fptosi float %sub23 to i32
  store i32 %conv24, i32* %arrayidx3, align 4
  ret void
}
