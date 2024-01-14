; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -slp-vectorizer -slp-vectorize-hor -S -mtriple=x86_64-unknown-linux-gnu -mcpu=bdver2 -debug < %s 2>&1 | FileCheck %s --check-prefixes=CHECK,AVX
; RUN: opt -slp-vectorizer -slp-vectorize-hor -S -mtriple=x86_64-unknown-linux-gnu -mcpu=core2 -debug < %s 2>&1 | FileCheck %s --check-prefixes=CHECK,SSE
; REQUIRES: asserts

; int test_add(unsigned int *p) {
;   int result = 0;
;   for (int i = 0; i < 8; i++)
;     result += p[i];
;   return result;
; }

; Vector cost is 5, Scalar cost is 7
; AVX: Adding cost -2 for reduction that starts with   %0 = load i32, i32* %p, align 4 (It is a splitting reduction)
; Vector cost is 6, Scalar cost is 7
; SSE: Adding cost -1 for reduction that starts with   %0 = load i32, i32* %p, align 4 (It is a splitting reduction)
define i32 @test_add(i32* nocapture readonly %p) {
; CHECK-LABEL: @test_add(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i32* [[P:%.*]] to <8 x i32>*
; CHECK-NEXT:    [[TMP1:%.*]] = load <8 x i32>, <8 x i32>* [[TMP0]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> [[TMP1]])
; CHECK-NEXT:    ret i32 [[TMP2]]
;
entry:
  %0 = load i32, i32* %p, align 4
  %arrayidx.1 = getelementptr inbounds i32, i32* %p, i64 1
  %1 = load i32, i32* %arrayidx.1, align 4
  %mul.18 = add i32 %1, %0
  %arrayidx.2 = getelementptr inbounds i32, i32* %p, i64 2
  %2 = load i32, i32* %arrayidx.2, align 4
  %mul.29 = add i32 %2, %mul.18
  %arrayidx.3 = getelementptr inbounds i32, i32* %p, i64 3
  %3 = load i32, i32* %arrayidx.3, align 4
  %mul.310 = add i32 %3, %mul.29
  %arrayidx.4 = getelementptr inbounds i32, i32* %p, i64 4
  %4 = load i32, i32* %arrayidx.4, align 4
  %mul.411 = add i32 %4, %mul.310
  %arrayidx.5 = getelementptr inbounds i32, i32* %p, i64 5
  %5 = load i32, i32* %arrayidx.5, align 4
  %mul.512 = add i32 %5, %mul.411
  %arrayidx.6 = getelementptr inbounds i32, i32* %p, i64 6
  %6 = load i32, i32* %arrayidx.6, align 4
  %mul.613 = add i32 %6, %mul.512
  %arrayidx.7 = getelementptr inbounds i32, i32* %p, i64 7
  %7 = load i32, i32* %arrayidx.7, align 4
  %mul.714 = add i32 %7, %mul.613
  ret i32 %mul.714
}

; int test_mul(unsigned int *p) {
;   int result = 0;
;   for (int i = 0; i < 8; i++)
;     result *= p[i];
;   return result;
; }

define i32 @test_mul(i32* nocapture readonly %p) {
; AVX-LABEL: @test_mul(
; AVX-NEXT:  entry:
; AVX-NEXT:    [[TMP0:%.*]] = bitcast i32* [[P:%.*]] to <8 x i32>*
; AVX-NEXT:    [[TMP1:%.*]] = load <8 x i32>, <8 x i32>* [[TMP0]], align 4
; AVX-NEXT:    [[TMP2:%.*]] = call i32 @llvm.vector.reduce.mul.v8i32(<8 x i32> [[TMP1]])
; AVX-NEXT:    ret i32 [[TMP2]]
;
; SSE-LABEL: @test_mul(
; SSE-NEXT:  entry:
; SSE-NEXT:    [[TMP0:%.*]] = load i32, i32* [[P:%.*]], align 4
; SSE-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 1
; SSE-NEXT:    [[TMP1:%.*]] = load i32, i32* [[ARRAYIDX_1]], align 4
; SSE-NEXT:    [[MUL_18:%.*]] = mul i32 [[TMP1]], [[TMP0]]
; SSE-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 2
; SSE-NEXT:    [[TMP2:%.*]] = load i32, i32* [[ARRAYIDX_2]], align 4
; SSE-NEXT:    [[MUL_29:%.*]] = mul i32 [[TMP2]], [[MUL_18]]
; SSE-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 3
; SSE-NEXT:    [[TMP3:%.*]] = load i32, i32* [[ARRAYIDX_3]], align 4
; SSE-NEXT:    [[MUL_310:%.*]] = mul i32 [[TMP3]], [[MUL_29]]
; SSE-NEXT:    [[ARRAYIDX_4:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 4
; SSE-NEXT:    [[TMP4:%.*]] = load i32, i32* [[ARRAYIDX_4]], align 4
; SSE-NEXT:    [[MUL_411:%.*]] = mul i32 [[TMP4]], [[MUL_310]]
; SSE-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 5
; SSE-NEXT:    [[TMP5:%.*]] = load i32, i32* [[ARRAYIDX_5]], align 4
; SSE-NEXT:    [[MUL_512:%.*]] = mul i32 [[TMP5]], [[MUL_411]]
; SSE-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 6
; SSE-NEXT:    [[TMP6:%.*]] = load i32, i32* [[ARRAYIDX_6]], align 4
; SSE-NEXT:    [[MUL_613:%.*]] = mul i32 [[TMP6]], [[MUL_512]]
; SSE-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 7
; SSE-NEXT:    [[TMP7:%.*]] = load i32, i32* [[ARRAYIDX_7]], align 4
; SSE-NEXT:    [[MUL_714:%.*]] = mul i32 [[TMP7]], [[MUL_613]]
; SSE-NEXT:    ret i32 [[MUL_714]]
;
entry:
  %0 = load i32, i32* %p, align 4
  %arrayidx.1 = getelementptr inbounds i32, i32* %p, i64 1
  %1 = load i32, i32* %arrayidx.1, align 4
  %mul.18 = mul i32 %1, %0
  %arrayidx.2 = getelementptr inbounds i32, i32* %p, i64 2
  %2 = load i32, i32* %arrayidx.2, align 4
  %mul.29 = mul i32 %2, %mul.18
  %arrayidx.3 = getelementptr inbounds i32, i32* %p, i64 3
  %3 = load i32, i32* %arrayidx.3, align 4
  %mul.310 = mul i32 %3, %mul.29
  %arrayidx.4 = getelementptr inbounds i32, i32* %p, i64 4
  %4 = load i32, i32* %arrayidx.4, align 4
  %mul.411 = mul i32 %4, %mul.310
  %arrayidx.5 = getelementptr inbounds i32, i32* %p, i64 5
  %5 = load i32, i32* %arrayidx.5, align 4
  %mul.512 = mul i32 %5, %mul.411
  %arrayidx.6 = getelementptr inbounds i32, i32* %p, i64 6
  %6 = load i32, i32* %arrayidx.6, align 4
  %mul.613 = mul i32 %6, %mul.512
  %arrayidx.7 = getelementptr inbounds i32, i32* %p, i64 7
  %7 = load i32, i32* %arrayidx.7, align 4
  %mul.714 = mul i32 %7, %mul.613
  ret i32 %mul.714
}

; int test_and(unsigned int *p) {
;   int result = 0;
;   for (int i = 0; i < 8; i++)
;     result &= p[i];
;   return result;
; }

define i32 @test_and(i32* nocapture readonly %p) {
; CHECK-LABEL: @test_and(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i32* [[P:%.*]] to <8 x i32>*
; CHECK-NEXT:    [[TMP1:%.*]] = load <8 x i32>, <8 x i32>* [[TMP0]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.vector.reduce.and.v8i32(<8 x i32> [[TMP1]])
; CHECK-NEXT:    ret i32 [[TMP2]]
;
entry:
  %0 = load i32, i32* %p, align 4
  %arrayidx.1 = getelementptr inbounds i32, i32* %p, i64 1
  %1 = load i32, i32* %arrayidx.1, align 4
  %mul.18 = and i32 %1, %0
  %arrayidx.2 = getelementptr inbounds i32, i32* %p, i64 2
  %2 = load i32, i32* %arrayidx.2, align 4
  %mul.29 = and i32 %2, %mul.18
  %arrayidx.3 = getelementptr inbounds i32, i32* %p, i64 3
  %3 = load i32, i32* %arrayidx.3, align 4
  %mul.310 = and i32 %3, %mul.29
  %arrayidx.4 = getelementptr inbounds i32, i32* %p, i64 4
  %4 = load i32, i32* %arrayidx.4, align 4
  %mul.411 = and i32 %4, %mul.310
  %arrayidx.5 = getelementptr inbounds i32, i32* %p, i64 5
  %5 = load i32, i32* %arrayidx.5, align 4
  %mul.512 = and i32 %5, %mul.411
  %arrayidx.6 = getelementptr inbounds i32, i32* %p, i64 6
  %6 = load i32, i32* %arrayidx.6, align 4
  %mul.613 = and i32 %6, %mul.512
  %arrayidx.7 = getelementptr inbounds i32, i32* %p, i64 7
  %7 = load i32, i32* %arrayidx.7, align 4
  %mul.714 = and i32 %7, %mul.613
  ret i32 %mul.714
}

; int test_or(unsigned int *p) {
;   int result = 0;
;   for (int i = 0; i < 8; i++)
;     result |= p[i];
;   return result;
; }

define i32 @test_or(i32* nocapture readonly %p) {
; CHECK-LABEL: @test_or(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i32* [[P:%.*]] to <8 x i32>*
; CHECK-NEXT:    [[TMP1:%.*]] = load <8 x i32>, <8 x i32>* [[TMP0]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.vector.reduce.or.v8i32(<8 x i32> [[TMP1]])
; CHECK-NEXT:    ret i32 [[TMP2]]
;
entry:
  %0 = load i32, i32* %p, align 4
  %arrayidx.1 = getelementptr inbounds i32, i32* %p, i64 1
  %1 = load i32, i32* %arrayidx.1, align 4
  %mul.18 = or i32 %1, %0
  %arrayidx.2 = getelementptr inbounds i32, i32* %p, i64 2
  %2 = load i32, i32* %arrayidx.2, align 4
  %mul.29 = or i32 %2, %mul.18
  %arrayidx.3 = getelementptr inbounds i32, i32* %p, i64 3
  %3 = load i32, i32* %arrayidx.3, align 4
  %mul.310 = or i32 %3, %mul.29
  %arrayidx.4 = getelementptr inbounds i32, i32* %p, i64 4
  %4 = load i32, i32* %arrayidx.4, align 4
  %mul.411 = or i32 %4, %mul.310
  %arrayidx.5 = getelementptr inbounds i32, i32* %p, i64 5
  %5 = load i32, i32* %arrayidx.5, align 4
  %mul.512 = or i32 %5, %mul.411
  %arrayidx.6 = getelementptr inbounds i32, i32* %p, i64 6
  %6 = load i32, i32* %arrayidx.6, align 4
  %mul.613 = or i32 %6, %mul.512
  %arrayidx.7 = getelementptr inbounds i32, i32* %p, i64 7
  %7 = load i32, i32* %arrayidx.7, align 4
  %mul.714 = or i32 %7, %mul.613
  ret i32 %mul.714
}

; int test_xor(unsigned int *p) {
;   int result = 0;
;   for (int i = 0; i < 8; i++)
;     result ^= p[i];
;   return result;
; }

define i32 @test_xor(i32* nocapture readonly %p) {
; CHECK-LABEL: @test_xor(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i32* [[P:%.*]] to <8 x i32>*
; CHECK-NEXT:    [[TMP1:%.*]] = load <8 x i32>, <8 x i32>* [[TMP0]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.vector.reduce.xor.v8i32(<8 x i32> [[TMP1]])
; CHECK-NEXT:    ret i32 [[TMP2]]
;
entry:
  %0 = load i32, i32* %p, align 4
  %arrayidx.1 = getelementptr inbounds i32, i32* %p, i64 1
  %1 = load i32, i32* %arrayidx.1, align 4
  %mul.18 = xor i32 %1, %0
  %arrayidx.2 = getelementptr inbounds i32, i32* %p, i64 2
  %2 = load i32, i32* %arrayidx.2, align 4
  %mul.29 = xor i32 %2, %mul.18
  %arrayidx.3 = getelementptr inbounds i32, i32* %p, i64 3
  %3 = load i32, i32* %arrayidx.3, align 4
  %mul.310 = xor i32 %3, %mul.29
  %arrayidx.4 = getelementptr inbounds i32, i32* %p, i64 4
  %4 = load i32, i32* %arrayidx.4, align 4
  %mul.411 = xor i32 %4, %mul.310
  %arrayidx.5 = getelementptr inbounds i32, i32* %p, i64 5
  %5 = load i32, i32* %arrayidx.5, align 4
  %mul.512 = xor i32 %5, %mul.411
  %arrayidx.6 = getelementptr inbounds i32, i32* %p, i64 6
  %6 = load i32, i32* %arrayidx.6, align 4
  %mul.613 = xor i32 %6, %mul.512
  %arrayidx.7 = getelementptr inbounds i32, i32* %p, i64 7
  %7 = load i32, i32* %arrayidx.7, align 4
  %mul.714 = xor i32 %7, %mul.613
  ret i32 %mul.714
}

define i32 @PR37731(<4 x i32>* noalias nocapture dereferenceable(16) %self) unnamed_addr #0 {
; CHECK-LABEL: @PR37731(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <4 x i32>, <4 x i32>* [[SELF:%.*]], align 16
; CHECK-NEXT:    [[TMP1:%.*]] = shl <4 x i32> [[TMP0]], <i32 6, i32 2, i32 13, i32 3>
; CHECK-NEXT:    [[TMP2:%.*]] = xor <4 x i32> [[TMP1]], [[TMP0]]
; CHECK-NEXT:    [[TMP3:%.*]] = lshr <4 x i32> [[TMP2]], <i32 13, i32 27, i32 21, i32 12>
; CHECK-NEXT:    [[TMP4:%.*]] = and <4 x i32> [[TMP0]], <i32 -2, i32 -8, i32 -16, i32 -128>
; CHECK-NEXT:    [[TMP5:%.*]] = shl <4 x i32> [[TMP4]], <i32 18, i32 2, i32 7, i32 13>
; CHECK-NEXT:    [[TMP6:%.*]] = xor <4 x i32> [[TMP3]], [[TMP5]]
; CHECK-NEXT:    store <4 x i32> [[TMP6]], <4 x i32>* [[SELF]], align 16
; CHECK-NEXT:    [[TMP7:%.*]] = call i32 @llvm.vector.reduce.xor.v4i32(<4 x i32> [[TMP6]])
; CHECK-NEXT:    ret i32 [[TMP7]]
;
entry:
  %0 = load <4 x i32>, <4 x i32>* %self, align 16
  %1 = shl <4 x i32> %0, <i32 6, i32 2, i32 13, i32 3>
  %2 = xor <4 x i32> %1, %0
  %3 = lshr <4 x i32> %2, <i32 13, i32 27, i32 21, i32 12>
  %4 = and <4 x i32> %0, <i32 -2, i32 -8, i32 -16, i32 -128>
  %5 = shl <4 x i32> %4, <i32 18, i32 2, i32 7, i32 13>
  %6 = xor <4 x i32> %3, %5
  store <4 x i32> %6, <4 x i32>* %self, align 16
  %7 = extractelement <4 x i32> %6, i32 0
  %8 = extractelement <4 x i32> %6, i32 1
  %9 = xor i32 %7, %8
  %10 = extractelement <4 x i32> %6, i32 2
  %11 = xor i32 %9, %10
  %12 = extractelement <4 x i32> %6, i32 3
  %13 = xor i32 %11, %12
  ret i32 %13
}
