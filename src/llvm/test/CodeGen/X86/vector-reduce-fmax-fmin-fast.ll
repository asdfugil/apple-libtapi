; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefixes=SSE,SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefixes=SSE,SSE41
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefix=AVX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefix=AVX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512bw | FileCheck %s --check-prefix=AVX512
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512bw,+avx512vl | FileCheck %s --check-prefix=AVX512

; These tests are identical to corresponding tests in the 'nnan' versions
; of the files except that they use 'fast' FMF. If things are working as
; expected, the 'nnan' codegen should be the same as 'fast'.

;
; vXf32
;

define float @test_v2f32(<2 x float> %a0) {
; SSE2-LABEL: test_v2f32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1],xmm0[1,1]
; SSE2-NEXT:    minss %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_v2f32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE41-NEXT:    minss %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_v2f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX-NEXT:    vminss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v2f32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX512-NEXT:    vminss %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %1 = call fast float @llvm.vector.reduce.fmin.v2f32(<2 x float> %a0)
  ret float %1
}

define float @test_v4f32(<4 x float> %a0) {
; SSE2-LABEL: test_v4f32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE2-NEXT:    maxps %xmm1, %xmm0
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1],xmm0[1,1]
; SSE2-NEXT:    maxss %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_v4f32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movaps %xmm0, %xmm1
; SSE41-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE41-NEXT:    maxps %xmm1, %xmm0
; SSE41-NEXT:    movshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE41-NEXT:    maxss %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX-NEXT:    vmaxss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v4f32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX512-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX512-NEXT:    vmaxss %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %1 = call fast float @llvm.vector.reduce.fmax.v4f32(<4 x float> %a0)
  ret float %1
}

define float @test_v8f32(<8 x float> %a0) {
; SSE2-LABEL: test_v8f32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    minps %xmm1, %xmm0
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE2-NEXT:    minps %xmm1, %xmm0
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1],xmm0[1,1]
; SSE2-NEXT:    minss %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_v8f32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    minps %xmm1, %xmm0
; SSE41-NEXT:    movaps %xmm0, %xmm1
; SSE41-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE41-NEXT:    minps %xmm1, %xmm0
; SSE41-NEXT:    movshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE41-NEXT:    minss %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_v8f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX-NEXT:    vminps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX-NEXT:    vminps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX-NEXT:    vminss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v8f32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vminps %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX512-NEXT:    vminps %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX512-NEXT:    vminss %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call fast float @llvm.vector.reduce.fmin.v8f32(<8 x float> %a0)
  ret float %1
}

define float @test_v16f32(<16 x float> %a0) {
; SSE2-LABEL: test_v16f32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    maxps %xmm3, %xmm1
; SSE2-NEXT:    maxps %xmm2, %xmm0
; SSE2-NEXT:    maxps %xmm1, %xmm0
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE2-NEXT:    maxps %xmm1, %xmm0
; SSE2-NEXT:    movaps %xmm0, %xmm1
; SSE2-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1],xmm0[1,1]
; SSE2-NEXT:    maxss %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_v16f32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    maxps %xmm3, %xmm1
; SSE41-NEXT:    maxps %xmm2, %xmm0
; SSE41-NEXT:    maxps %xmm1, %xmm0
; SSE41-NEXT:    movaps %xmm0, %xmm1
; SSE41-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE41-NEXT:    maxps %xmm1, %xmm0
; SSE41-NEXT:    movshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE41-NEXT:    maxss %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_v16f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vmaxps %ymm1, %ymm0, %ymm0
; AVX-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX-NEXT:    vmaxss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v16f32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextractf64x4 $1, %zmm0, %ymm1
; AVX512-NEXT:    vmaxps %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX512-NEXT:    vmaxps %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX512-NEXT:    vmaxss %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call fast float @llvm.vector.reduce.fmax.v16f32(<16 x float> %a0)
  ret float %1
}

;
; vXf64
;

define double @test_v2f64(<2 x double> %a0) {
; SSE-LABEL: test_v2f64:
; SSE:       # %bb.0:
; SSE-NEXT:    movapd %xmm0, %xmm1
; SSE-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE-NEXT:    minsd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v2f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX-NEXT:    vminsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v2f64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX512-NEXT:    vminsd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %1 = call fast double @llvm.vector.reduce.fmin.v2f64(<2 x double> %a0)
  ret double %1
}

define double @test_v4f64(<4 x double> %a0) {
; SSE-LABEL: test_v4f64:
; SSE:       # %bb.0:
; SSE-NEXT:    maxpd %xmm1, %xmm0
; SSE-NEXT:    movapd %xmm0, %xmm1
; SSE-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE-NEXT:    maxsd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v4f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX-NEXT:    vmaxpd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX-NEXT:    vmaxsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v4f64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vmaxpd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX512-NEXT:    vmaxsd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call fast double @llvm.vector.reduce.fmax.v4f64(<4 x double> %a0)
  ret double %1
}

define double @test_v8f64(<8 x double> %a0) {
; SSE-LABEL: test_v8f64:
; SSE:       # %bb.0:
; SSE-NEXT:    minpd %xmm3, %xmm1
; SSE-NEXT:    minpd %xmm2, %xmm0
; SSE-NEXT:    minpd %xmm1, %xmm0
; SSE-NEXT:    movapd %xmm0, %xmm1
; SSE-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE-NEXT:    minsd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v8f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vminpd %ymm1, %ymm0, %ymm0
; AVX-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX-NEXT:    vminpd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX-NEXT:    vminsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v8f64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vextractf64x4 $1, %zmm0, %ymm1
; AVX512-NEXT:    vminpd %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vminpd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX512-NEXT:    vminsd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call fast double @llvm.vector.reduce.fmin.v8f64(<8 x double> %a0)
  ret double %1
}

define double @test_v16f64(<16 x double> %a0) {
; SSE-LABEL: test_v16f64:
; SSE:       # %bb.0:
; SSE-NEXT:    maxpd %xmm6, %xmm2
; SSE-NEXT:    maxpd %xmm4, %xmm0
; SSE-NEXT:    maxpd %xmm2, %xmm0
; SSE-NEXT:    maxpd %xmm7, %xmm3
; SSE-NEXT:    maxpd %xmm5, %xmm1
; SSE-NEXT:    maxpd %xmm3, %xmm1
; SSE-NEXT:    maxpd %xmm1, %xmm0
; SSE-NEXT:    movapd %xmm0, %xmm1
; SSE-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm0[1]
; SSE-NEXT:    maxsd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: test_v16f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vmaxpd %ymm3, %ymm1, %ymm1
; AVX-NEXT:    vmaxpd %ymm2, %ymm0, %ymm0
; AVX-NEXT:    vmaxpd %ymm1, %ymm0, %ymm0
; AVX-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX-NEXT:    vmaxpd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX-NEXT:    vmaxsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: test_v16f64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmaxpd %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextractf64x4 $1, %zmm0, %ymm1
; AVX512-NEXT:    vmaxpd %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vmaxpd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; AVX512-NEXT:    vmaxsd %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %1 = call fast double @llvm.vector.reduce.fmax.v16f64(<16 x double> %a0)
  ret double %1
}

declare float @llvm.vector.reduce.fmin.v2f32(<2 x float>)
declare float @llvm.vector.reduce.fmax.v4f32(<4 x float>)
declare float @llvm.vector.reduce.fmin.v8f32(<8 x float>)
declare float @llvm.vector.reduce.fmax.v16f32(<16 x float>)

declare double @llvm.vector.reduce.fmin.v2f64(<2 x double>)
declare double @llvm.vector.reduce.fmax.v4f64(<4 x double>)
declare double @llvm.vector.reduce.fmin.v8f64(<8 x double>)
declare double @llvm.vector.reduce.fmax.v16f64(<16 x double>)
