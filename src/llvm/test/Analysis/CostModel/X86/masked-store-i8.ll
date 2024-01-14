; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py UTC_ARGS: --filter "LV: Found an estimated cost of [0-9]+ for VF [0-9]+ For instruction:\s*store i8 %valB, i8\* %out, align 1"
; RUN: opt -loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+sse2 --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefixes=SSE2
; RUN: opt -loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+sse4.2 --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefixes=SSE42
; RUN: opt -loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx  --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefixes=AVX1
; RUN: opt -loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx2,-fast-gather --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefixes=AVX2
; RUN: opt -loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx2,+fast-gather --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefixes=AVX2
; RUN: opt -loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx512bw --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefixes=AVX512

; REQUIRES: asserts

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@A = global [1024 x i8] zeroinitializer, align 128
@B = global [1024 x i8] zeroinitializer, align 128

define void @test([1024 x i8]* %C) {
; SSE2-LABEL: 'test'
; SSE2:  LV: Found an estimated cost of 1 for VF 1 For instruction: store i8 %valB, i8* %out, align 1
; SSE2:  LV: Found an estimated cost of 2 for VF 2 For instruction: store i8 %valB, i8* %out, align 1
; SSE2:  LV: Found an estimated cost of 5 for VF 4 For instruction: store i8 %valB, i8* %out, align 1
; SSE2:  LV: Found an estimated cost of 11 for VF 8 For instruction: store i8 %valB, i8* %out, align 1
; SSE2:  LV: Found an estimated cost of 23 for VF 16 For instruction: store i8 %valB, i8* %out, align 1
;
; SSE42-LABEL: 'test'
; SSE42:  LV: Found an estimated cost of 1 for VF 1 For instruction: store i8 %valB, i8* %out, align 1
; SSE42:  LV: Found an estimated cost of 2 for VF 2 For instruction: store i8 %valB, i8* %out, align 1
; SSE42:  LV: Found an estimated cost of 4 for VF 4 For instruction: store i8 %valB, i8* %out, align 1
; SSE42:  LV: Found an estimated cost of 8 for VF 8 For instruction: store i8 %valB, i8* %out, align 1
; SSE42:  LV: Found an estimated cost of 16 for VF 16 For instruction: store i8 %valB, i8* %out, align 1
;
; AVX1-LABEL: 'test'
; AVX1:  LV: Found an estimated cost of 1 for VF 1 For instruction: store i8 %valB, i8* %out, align 1
; AVX1:  LV: Found an estimated cost of 2 for VF 2 For instruction: store i8 %valB, i8* %out, align 1
; AVX1:  LV: Found an estimated cost of 4 for VF 4 For instruction: store i8 %valB, i8* %out, align 1
; AVX1:  LV: Found an estimated cost of 8 for VF 8 For instruction: store i8 %valB, i8* %out, align 1
; AVX1:  LV: Found an estimated cost of 16 for VF 16 For instruction: store i8 %valB, i8* %out, align 1
; AVX1:  LV: Found an estimated cost of 32 for VF 32 For instruction: store i8 %valB, i8* %out, align 1
;
; AVX2-LABEL: 'test'
; AVX2:  LV: Found an estimated cost of 1 for VF 1 For instruction: store i8 %valB, i8* %out, align 1
; AVX2:  LV: Found an estimated cost of 2 for VF 2 For instruction: store i8 %valB, i8* %out, align 1
; AVX2:  LV: Found an estimated cost of 4 for VF 4 For instruction: store i8 %valB, i8* %out, align 1
; AVX2:  LV: Found an estimated cost of 8 for VF 8 For instruction: store i8 %valB, i8* %out, align 1
; AVX2:  LV: Found an estimated cost of 16 for VF 16 For instruction: store i8 %valB, i8* %out, align 1
; AVX2:  LV: Found an estimated cost of 32 for VF 32 For instruction: store i8 %valB, i8* %out, align 1
;
; AVX512-LABEL: 'test'
; AVX512:  LV: Found an estimated cost of 1 for VF 1 For instruction: store i8 %valB, i8* %out, align 1
; AVX512:  LV: Found an estimated cost of 2 for VF 2 For instruction: store i8 %valB, i8* %out, align 1
; AVX512:  LV: Found an estimated cost of 2 for VF 4 For instruction: store i8 %valB, i8* %out, align 1
; AVX512:  LV: Found an estimated cost of 2 for VF 8 For instruction: store i8 %valB, i8* %out, align 1
; AVX512:  LV: Found an estimated cost of 1 for VF 16 For instruction: store i8 %valB, i8* %out, align 1
; AVX512:  LV: Found an estimated cost of 1 for VF 32 For instruction: store i8 %valB, i8* %out, align 1
; AVX512:  LV: Found an estimated cost of 1 for VF 64 For instruction: store i8 %valB, i8* %out, align 1
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %end ]

  %inB = getelementptr inbounds [1024 x i8], [1024 x i8]* @B, i64 0, i64 %iv
  %valB = load i8, i8* %inB

  %inA = getelementptr inbounds [1024 x i8], [1024 x i8]* @A, i64 0, i64 %iv
  %valA = load i8, i8* %inA
  %canStore = icmp ne i8 %valA, 0
  br i1 %canStore, label %store, label %mask

store:
  %out = getelementptr inbounds [1024 x i8], [1024 x i8]* %C, i64 0, i64 %iv
  store i8 %valB, i8* %out
  br label %end

mask:
  br label %end

end:
  %iv.next = add nuw nsw i64 %iv, 1
  %cmp = icmp ult i64 %iv.next, 1024
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:
  ret void
}
