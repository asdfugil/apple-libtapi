; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -slp-vectorizer -mtriple=x86_64-apple-macosx10.9.0 -mcpu=corei7-avx -S < %s | FileCheck %s
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.9.0"


; This test used to crash because we were following phi chains incorrectly.
; We used indices to get the incoming value of two phi nodes rather than
; incoming block lookup.
; This can give wrong results when the ordering of incoming
; edges in the two phi nodes don't match.

%0 = type { %1, %2 }
%1 = type { double, double }
%2 = type { double, double }


;define fastcc void @bar() {
define void @bar() {
; CHECK-LABEL: @bar(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [[TMP0:%.*]], %0* undef, i64 0, i32 1, i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [[TMP0]], %0* undef, i64 0, i32 1, i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds [[TMP0]], %0* undef, i64 0, i32 1, i32 0
; CHECK-NEXT:    br label [[TMP4:%.*]]
; CHECK:       4:
; CHECK-NEXT:    [[TMP5:%.*]] = phi <2 x double> [ <double 1.800000e+01, double 2.800000e+01>, [[TMP0]] ], [ [[TMP8:%.*]], [[TMP16:%.*]] ], [ [[TMP8]], [[TMP15:%.*]] ], [ [[TMP8]], [[TMP15]] ]
; CHECK-NEXT:    [[TMP6:%.*]] = bitcast double* [[TMP1]] to <2 x double>*
; CHECK-NEXT:    store <2 x double> [[TMP5]], <2 x double>* [[TMP6]], align 8
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast double* [[TMP2]] to <2 x double>*
; CHECK-NEXT:    [[TMP8]] = load <2 x double>, <2 x double>* [[TMP7]], align 8
; CHECK-NEXT:    br i1 undef, label [[TMP9:%.*]], label [[TMP10:%.*]]
; CHECK:       9:
; CHECK-NEXT:    ret void
; CHECK:       10:
; CHECK-NEXT:    [[TMP11:%.*]] = bitcast double* [[TMP3]] to <2 x double>*
; CHECK-NEXT:    store <2 x double> [[TMP8]], <2 x double>* [[TMP11]], align 8
; CHECK-NEXT:    br i1 undef, label [[TMP12:%.*]], label [[TMP13:%.*]]
; CHECK:       12:
; CHECK-NEXT:    br label [[TMP13]]
; CHECK:       13:
; CHECK-NEXT:    br i1 undef, label [[TMP14:%.*]], label [[TMP15]]
; CHECK:       14:
; CHECK-NEXT:    unreachable
; CHECK:       15:
; CHECK-NEXT:    switch i32 undef, label [[TMP16]] [
; CHECK-NEXT:    i32 32, label [[TMP4]]
; CHECK-NEXT:    i32 103, label [[TMP4]]
; CHECK-NEXT:    ]
; CHECK:       16:
; CHECK-NEXT:    br i1 undef, label [[TMP4]], label [[TMP17:%.*]]
; CHECK:       17:
; CHECK-NEXT:    unreachable
;
  %1 = getelementptr inbounds %0, %0* undef, i64 0, i32 1, i32 0
  %2 = getelementptr inbounds %0, %0* undef, i64 0, i32 1, i32 1
  %3 = getelementptr inbounds %0, %0* undef, i64 0, i32 1, i32 0
  %4 = getelementptr inbounds %0, %0* undef, i64 0, i32 1, i32 1
  %5 = getelementptr inbounds %0, %0* undef, i64 0, i32 1, i32 0
  %6 = getelementptr inbounds %0, %0* undef, i64 0, i32 1, i32 1
  br label %7

; <label>:7                                       ; preds = %18, %17, %17, %0
  %8 = phi double [ 2.800000e+01, %0 ], [ %11, %18 ], [ %11, %17 ], [ %11, %17 ]
  %9 = phi double [ 1.800000e+01, %0 ], [ %10, %18 ], [ %10, %17 ], [ %10, %17 ]
  store double %9, double* %1, align 8
  store double %8, double* %2, align 8
  %10 = load double, double* %3, align 8
  %11 = load double, double* %4, align 8
  br i1 undef, label %12, label %13

; <label>:12                                      ; preds = %7
  ret void

; <label>:13                                      ; preds = %7
  store double %10, double* %5, align 8
  store double %11, double* %6, align 8
  br i1 undef, label %14, label %15

; <label>:14                                      ; preds = %13
  br label %15

; <label>:15                                      ; preds = %14, %13
  br i1 undef, label %16, label %17

; <label>:16                                      ; preds = %15
  unreachable

; <label>:17                                      ; preds = %15
  switch i32 undef, label %18 [
  i32 32, label %7
  i32 103, label %7
  ]

; <label>:18                                      ; preds = %17
  br i1 undef, label %7, label %19

; <label>:19                                      ; preds = %18
  unreachable
}
