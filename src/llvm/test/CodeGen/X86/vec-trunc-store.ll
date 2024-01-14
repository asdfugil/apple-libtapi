; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux | FileCheck %s

define void @foo(ptr %p) nounwind {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movdqa (%rdi), %xmm0
; CHECK-NEXT:    movdqa 16(%rdi), %xmm1
; CHECK-NEXT:    pslld $16, %xmm1
; CHECK-NEXT:    psrad $16, %xmm1
; CHECK-NEXT:    pslld $16, %xmm0
; CHECK-NEXT:    psrad $16, %xmm0
; CHECK-NEXT:    packssdw %xmm1, %xmm0
; CHECK-NEXT:    movdqa %xmm0, (%rax)
; CHECK-NEXT:    retq
  %t = load <8 x i32>, ptr %p
  %cti69 = trunc <8 x i32> %t to <8 x i16>     ; <<8 x i16>> [#uses=1]
  store <8 x i16> %cti69, ptr undef
  ret void
}

define void @bar(ptr %p) nounwind {
; CHECK-LABEL: bar:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pshuflw {{.*#+}} xmm0 = mem[0,2,2,3,4,5,6,7]
; CHECK-NEXT:    pshufhw {{.*#+}} xmm0 = xmm0[0,1,2,3,4,6,6,7]
; CHECK-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; CHECK-NEXT:    movq %xmm0, (%rax)
; CHECK-NEXT:    retq
  %t = load <4 x i32>, ptr %p
  %cti44 = trunc <4 x i32> %t to <4 x i16>     ; <<4 x i16>> [#uses=1]
  store <4 x i16> %cti44, ptr undef
  ret void
}
