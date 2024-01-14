; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-vectorizer -dce -S -mtriple=xcore  | FileCheck %s

target datalayout = "e-p:32:32:32-a0:0:32-n32-i1:8:32-i8:8:32-i16:16:32-i32:32:32-i64:32:32-f16:16:32-f32:32:32-f64:32:32"
target triple = "xcore"

; Simple 3-pair chain with loads and stores
define void @test1(double* %a, double* %b, double* %c) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[I0:%.*]] = load double, double* [[A:%.*]], align 8
; CHECK-NEXT:    [[I1:%.*]] = load double, double* [[B:%.*]], align 8
; CHECK-NEXT:    [[MUL:%.*]] = fmul double [[I0]], [[I1]]
; CHECK-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds double, double* [[A]], i64 1
; CHECK-NEXT:    [[I3:%.*]] = load double, double* [[ARRAYIDX3]], align 8
; CHECK-NEXT:    [[ARRAYIDX4:%.*]] = getelementptr inbounds double, double* [[B]], i64 1
; CHECK-NEXT:    [[I4:%.*]] = load double, double* [[ARRAYIDX4]], align 8
; CHECK-NEXT:    [[MUL5:%.*]] = fmul double [[I3]], [[I4]]
; CHECK-NEXT:    store double [[MUL]], double* [[C:%.*]], align 8
; CHECK-NEXT:    [[ARRAYIDX5:%.*]] = getelementptr inbounds double, double* [[C]], i64 1
; CHECK-NEXT:    store double [[MUL5]], double* [[ARRAYIDX5]], align 8
; CHECK-NEXT:    ret void
;
entry:
  %i0 = load double, double* %a, align 8
  %i1 = load double, double* %b, align 8
  %mul = fmul double %i0, %i1
  %arrayidx3 = getelementptr inbounds double, double* %a, i64 1
  %i3 = load double, double* %arrayidx3, align 8
  %arrayidx4 = getelementptr inbounds double, double* %b, i64 1
  %i4 = load double, double* %arrayidx4, align 8
  %mul5 = fmul double %i3, %i4
  store double %mul, double* %c, align 8
  %arrayidx5 = getelementptr inbounds double, double* %c, i64 1
  store double %mul5, double* %arrayidx5, align 8
  ret void
}

