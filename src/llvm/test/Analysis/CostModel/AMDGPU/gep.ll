; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx1010 < %s | FileCheck -check-prefixes=ALL %s
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx90a < %s | FileCheck -check-prefixes=ALL %s
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx900 < %s | FileCheck -check-prefixes=ALL %s
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa < %s | FileCheck -check-prefixes=ALL %s

; RUN: opt -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx1010 < %s | FileCheck -check-prefixes=ALL-SIZE %s
; RUN: opt -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx90a < %s | FileCheck -check-prefixes=ALL-SIZE %s
; RUN: opt -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa -mcpu=gfx900 < %s | FileCheck -check-prefixes=ALL-SIZE %s
; RUN: opt -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=amdgcn-unknown-amdhsa < %s | FileCheck -check-prefixes=ALL-SIZE %s
; END.

define void @test_geps() {
; ALL-LABEL: 'test_geps'
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a0 = getelementptr inbounds i8, i8* undef, i32 0
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a1 = getelementptr inbounds i16, i16* undef, i32 0
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a2 = getelementptr inbounds i32, i32* undef, i32 0
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a3 = getelementptr inbounds i64, i64* undef, i32 0
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a4 = getelementptr inbounds float, float* undef, i32 0
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a5 = getelementptr inbounds double, double* undef, i32 0
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a7 = getelementptr inbounds <4 x i8>, <4 x i8>* undef, i32 0
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a8 = getelementptr inbounds <4 x i16>, <4 x i16>* undef, i32 0
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a9 = getelementptr inbounds <4 x i32>, <4 x i32>* undef, i32 0
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a10 = getelementptr inbounds <4 x i64>, <4 x i64>* undef, i32 0
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a11 = getelementptr inbounds <4 x float>, <4 x float>* undef, i32 0
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a12 = getelementptr inbounds <4 x double>, <4 x double>* undef, i32 0
; ALL-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %giant_gep0 = getelementptr inbounds i8, i8* undef, i64 9223372036854775807
; ALL-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %giant_gep1 = getelementptr inbounds i8, i8* undef, i128 295147905179352825855
; ALL-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: ret void
;
; ALL-SIZE-LABEL: 'test_geps'
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a0 = getelementptr inbounds i8, i8* undef, i32 0
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a1 = getelementptr inbounds i16, i16* undef, i32 0
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a2 = getelementptr inbounds i32, i32* undef, i32 0
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a3 = getelementptr inbounds i64, i64* undef, i32 0
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a4 = getelementptr inbounds float, float* undef, i32 0
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a5 = getelementptr inbounds double, double* undef, i32 0
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a7 = getelementptr inbounds <4 x i8>, <4 x i8>* undef, i32 0
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a8 = getelementptr inbounds <4 x i16>, <4 x i16>* undef, i32 0
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a9 = getelementptr inbounds <4 x i32>, <4 x i32>* undef, i32 0
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a10 = getelementptr inbounds <4 x i64>, <4 x i64>* undef, i32 0
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a11 = getelementptr inbounds <4 x float>, <4 x float>* undef, i32 0
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %a12 = getelementptr inbounds <4 x double>, <4 x double>* undef, i32 0
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %giant_gep0 = getelementptr inbounds i8, i8* undef, i64 9223372036854775807
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %giant_gep1 = getelementptr inbounds i8, i8* undef, i128 295147905179352825855
; ALL-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %a0 = getelementptr inbounds i8, i8* undef, i32 0
  %a1 = getelementptr inbounds i16, i16* undef, i32 0
  %a2 = getelementptr inbounds i32, i32* undef, i32 0
  %a3 = getelementptr inbounds i64, i64* undef, i32 0

  %a4 = getelementptr inbounds float, float* undef, i32 0
  %a5 = getelementptr inbounds double, double* undef, i32 0

  %a7 = getelementptr inbounds <4 x i8>, <4 x i8>* undef, i32 0
  %a8 = getelementptr inbounds <4 x i16>, <4 x i16>* undef, i32 0
  %a9 = getelementptr inbounds <4 x i32>, <4 x i32>* undef, i32 0
  %a10 = getelementptr inbounds <4 x i64>, <4 x i64>* undef, i32 0
  %a11 = getelementptr inbounds <4 x float>, <4 x float>* undef, i32 0
  %a12 = getelementptr inbounds <4 x double>, <4 x double>* undef, i32 0

  ; Check that we handle outlandishly large GEPs properly.  This is unlikely to
  ; be a valid pointer, but LLVM still generates GEPs like this sometimes in
  ; dead code.
  ; This GEP has index INT64_MAX, which is cost 1.
  %giant_gep0 = getelementptr inbounds i8, i8* undef, i64 9223372036854775807

  ; This GEP index wraps around to -1, which is cost 0.
  %giant_gep1 = getelementptr inbounds i8, i8* undef, i128 295147905179352825855

  ret void
}
