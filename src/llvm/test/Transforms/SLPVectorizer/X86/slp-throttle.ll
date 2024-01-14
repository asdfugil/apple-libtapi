; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -slp-vectorizer -S -mtriple=x86_64-unknown-linux-gnu -mcpu=bdver2 < %s | FileCheck %s

define dso_local void @rftbsub(double* %a) local_unnamed_addr #0 {
; CHECK-LABEL: @rftbsub(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds double, double* [[A:%.*]], i64 2
; CHECK-NEXT:    [[SUB22:%.*]] = fsub double undef, undef
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast double* [[ARRAYIDX6]] to <2 x double>*
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x double>, <2 x double>* [[TMP0]], align 8
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <2 x double> [[TMP1]], i32 1
; CHECK-NEXT:    [[ADD16:%.*]] = fadd double [[TMP2]], undef
; CHECK-NEXT:    [[MUL18:%.*]] = fmul double undef, [[ADD16]]
; CHECK-NEXT:    [[ADD19:%.*]] = fadd double undef, [[MUL18]]
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <2 x double> poison, double [[ADD19]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <2 x double> [[TMP3]], double [[SUB22]], i32 1
; CHECK-NEXT:    [[TMP5:%.*]] = fsub <2 x double> [[TMP1]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = bitcast double* [[ARRAYIDX6]] to <2 x double>*
; CHECK-NEXT:    store <2 x double> [[TMP5]], <2 x double>* [[TMP6]], align 8
; CHECK-NEXT:    unreachable
;
entry:
  %arrayidx6 = getelementptr inbounds double, double* %a, i64 2
  %0 = load double, double* %arrayidx6, align 8
  %1 = or i64 2, 1
  %arrayidx12 = getelementptr inbounds double, double* %a, i64 %1
  %2 = load double, double* %arrayidx12, align 8
  %add16 = fadd double %2, undef
  %mul18 = fmul double undef, %add16
  %add19 = fadd double undef, %mul18
  %sub22 = fsub double undef, undef
  %sub25 = fsub double %0, %add19
  store double %sub25, double* %arrayidx6, align 8
  %sub29 = fsub double %2, %sub22
  store double %sub29, double* %arrayidx12, align 8
  unreachable
}
