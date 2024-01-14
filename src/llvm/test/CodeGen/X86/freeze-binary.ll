; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-- -mattr=+sse2 | FileCheck %s --check-prefixes=X86
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2 | FileCheck %s --check-prefixes=X64

define i32 @freeze_and(i32 %a0) nounwind {
; X86-LABEL: freeze_and:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    andl $7, %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_and:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    andl $7, %eax
; X64-NEXT:    retq
  %x = and i32 %a0, 15
  %y = freeze i32 %x
  %z = and i32 %y, 7
  ret i32 %z
}

define <2 x i64> @freeze_and_vec(<2 x i64> %a0) nounwind {
; X86-LABEL: freeze_and_vec:
; X86:       # %bb.0:
; X86-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: freeze_and_vec:
; X64:       # %bb.0:
; X64-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-NEXT:    retq
  %x = and <2 x i64> %a0, <i64 15, i64 7>
  %y = freeze <2 x i64> %x
  %z = and <2 x i64> %y, <i64 7, i64 15>
  ret <2 x i64> %z
}

define i32 @freeze_or(i32 %a0) nounwind {
; X86-LABEL: freeze_or:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    orl $15, %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_or:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    orl $15, %eax
; X64-NEXT:    retq
  %x = or i32 %a0, 3
  %y = freeze i32 %x
  %z = or i32 %y, 12
  ret i32 %z
}

define <2 x i64> @freeze_or_vec(<2 x i64> %a0) nounwind {
; X86-LABEL: freeze_or_vec:
; X86:       # %bb.0:
; X86-NEXT:    orps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: freeze_or_vec:
; X64:       # %bb.0:
; X64-NEXT:    vorps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-NEXT:    retq
  %x = or <2 x i64> %a0, <i64 1, i64 3>
  %y = freeze <2 x i64> %x
  %z = or <2 x i64> %y, <i64 14, i64 12>
  ret <2 x i64> %z
}

define i32 @freeze_xor(i32 %a0) nounwind {
; X86-LABEL: freeze_xor:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    xorl $15, %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_xor:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    xorl $15, %eax
; X64-NEXT:    retq
  %x = xor i32 %a0, 3
  %y = freeze i32 %x
  %z = xor i32 %y, 12
  ret i32 %z
}

define <8 x i16> @freeze_xor_vec(<8 x i16> %a0) nounwind {
; X86-LABEL: freeze_xor_vec:
; X86:       # %bb.0:
; X86-NEXT:    pcmpeqd %xmm1, %xmm1
; X86-NEXT:    pxor %xmm1, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: freeze_xor_vec:
; X64:       # %bb.0:
; X64-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; X64-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; X64-NEXT:    retq
  %x = xor <8 x i16> %a0, <i16 -1, i16 0, i16 -1, i16 0, i16 -1, i16 0, i16 -1, i16 0>
  %y = freeze <8 x i16> %x
  %z = xor <8 x i16> %y, <i16 0, i16 -1, i16 0, i16 -1, i16 0, i16 -1, i16 0, i16 -1>
  ret <8 x i16> %z
}

define i32 @freeze_add(i32 %a0) nounwind {
; X86-LABEL: freeze_add:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    addl $2, %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_add:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal 2(%rdi), %eax
; X64-NEXT:    retq
  %x = add i32 %a0, 1
  %y = freeze i32 %x
  %z = add i32 %y, 1
  ret i32 %z
}

define i32 @freeze_add_nsw(i32 %a0) nounwind {
; X86-LABEL: freeze_add_nsw:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    addl $2, %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_add_nsw:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal 2(%rdi), %eax
; X64-NEXT:    retq
  %x = add nsw i32 %a0, 1
  %y = freeze i32 %x
  %z = add i32 %y, 1
  ret i32 %z
}

define <4 x i32> @freeze_add_vec(<4 x i32> %a0) nounwind {
; X86-LABEL: freeze_add_vec:
; X86:       # %bb.0:
; X86-NEXT:    paddd {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: freeze_add_vec:
; X64:       # %bb.0:
; X64-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [5,5,5,5]
; X64-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; X64-NEXT:    retq
  %x = add <4 x i32> %a0, <i32 1, i32 2, i32 3, i32 4>
  %y = freeze <4 x i32> %x
  %z = add <4 x i32> %y, <i32 4, i32 3, i32 2, i32 1>
  ret <4 x i32> %z
}

define <4 x i32> @freeze_add_vec_undef(<4 x i32> %a0) nounwind {
; X86-LABEL: freeze_add_vec_undef:
; X86:       # %bb.0:
; X86-NEXT:    paddd {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    paddd {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: freeze_add_vec_undef:
; X64:       # %bb.0:
; X64-NEXT:    vpaddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-NEXT:    vpaddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-NEXT:    retq
  %x = add <4 x i32> %a0, <i32 1, i32 2, i32 3, i32 undef>
  %y = freeze <4 x i32> %x
  %z = add <4 x i32> %y, <i32 4, i32 3, i32 2, i32 undef>
  ret <4 x i32> %z
}

define i32 @freeze_sub(i32 %a0) nounwind {
; X86-LABEL: freeze_sub:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    addl $-2, %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_sub:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal -2(%rdi), %eax
; X64-NEXT:    retq
  %x = sub i32 %a0, 1
  %y = freeze i32 %x
  %z = sub i32 %y, 1
  ret i32 %z
}

define i32 @freeze_sub_nuw(i32 %a0) nounwind {
; X86-LABEL: freeze_sub_nuw:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    addl $-2, %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_sub_nuw:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal -2(%rdi), %eax
; X64-NEXT:    retq
  %x = sub nuw i32 %a0, 1
  %y = freeze i32 %x
  %z = sub i32 %y, 1
  ret i32 %z
}

define <4 x i32> @freeze_sub_vec(<4 x i32> %a0) nounwind {
; X86-LABEL: freeze_sub_vec:
; X86:       # %bb.0:
; X86-NEXT:    psubd {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: freeze_sub_vec:
; X64:       # %bb.0:
; X64-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [5,5,5,5]
; X64-NEXT:    vpsubd %xmm1, %xmm0, %xmm0
; X64-NEXT:    retq
  %x = sub <4 x i32> %a0, <i32 1, i32 2, i32 3, i32 4>
  %y = freeze <4 x i32> %x
  %z = sub <4 x i32> %y, <i32 4, i32 3, i32 2, i32 1>
  ret <4 x i32> %z
}

define <4 x i32> @freeze_sub_vec_undef(<4 x i32> %a0) nounwind {
; X86-LABEL: freeze_sub_vec_undef:
; X86:       # %bb.0:
; X86-NEXT:    psubd {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    psubd {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: freeze_sub_vec_undef:
; X64:       # %bb.0:
; X64-NEXT:    vpsubd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-NEXT:    vpsubd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-NEXT:    retq
  %x = sub <4 x i32> %a0, <i32 1, i32 2, i32 3, i32 undef>
  %y = freeze <4 x i32> %x
  %z = sub <4 x i32> %y, <i32 4, i32 3, i32 2, i32 undef>
  ret <4 x i32> %z
}

define i32 @freeze_mul(i32 %a0) nounwind {
; X86-LABEL: freeze_mul:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shll $2, %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_mul:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal (,%rdi,4), %eax
; X64-NEXT:    retq
  %x = mul i32 %a0, 2
  %y = freeze i32 %x
  %z = mul i32 %y, 2
  ret i32 %z
}

define i32 @freeze_mul_nsw(i32 %a0) nounwind {
; X86-LABEL: freeze_mul_nsw:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    leal (%eax,%eax,4), %eax
; X86-NEXT:    leal (%eax,%eax,2), %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_mul_nsw:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal (%rdi,%rdi,4), %eax
; X64-NEXT:    leal (%rax,%rax,2), %eax
; X64-NEXT:    retq
  %x = mul nsw i32 %a0, 3
  %y = freeze i32 %x
  %z = mul i32 %y, 5
  ret i32 %z
}

define <8 x i16> @freeze_mul_vec(<8 x i16> %a0) nounwind {
; X86-LABEL: freeze_mul_vec:
; X86:       # %bb.0:
; X86-NEXT:    pmullw {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: freeze_mul_vec:
; X64:       # %bb.0:
; X64-NEXT:    vpmullw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-NEXT:    retq
  %x = mul <8 x i16> %a0, <i16 1, i16 2, i16 3, i16 4, i16 4, i16 3, i16 2, i16 1>
  %y = freeze <8 x i16> %x
  %z = mul <8 x i16> %y, <i16 4, i16 3, i16 2, i16 1, i16 1, i16 2, i16 3, i16 4>
  ret <8 x i16> %z
}

define <8 x i16> @freeze_mul_vec_undef(<8 x i16> %a0) nounwind {
; X86-LABEL: freeze_mul_vec_undef:
; X86:       # %bb.0:
; X86-NEXT:    pmullw {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    pmullw {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: freeze_mul_vec_undef:
; X64:       # %bb.0:
; X64-NEXT:    vpmullw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-NEXT:    vpmullw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-NEXT:    retq
  %x = mul <8 x i16> %a0, <i16 1, i16 2, i16 3, i16 4, i16 4, i16 3, i16 undef, i16 1>
  %y = freeze <8 x i16> %x
  %z = mul <8 x i16> %y, <i16 4, i16 3, i16 2, i16 1, i16 1, i16 2, i16 undef, i16 4>
  ret <8 x i16> %z
}

define i32 @freeze_shl(i32 %a0) nounwind {
; X86-LABEL: freeze_shl:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shll $3, %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_shl:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal (,%rdi,8), %eax
; X64-NEXT:    retq
  %x = shl i32 %a0, 1
  %y = freeze i32 %x
  %z = shl i32 %y, 2
  ret i32 %z
}

define i32 @freeze_shl_nsw(i32 %a0) nounwind {
; X86-LABEL: freeze_shl_nsw:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shll $8, %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_shl_nsw:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shll $8, %eax
; X64-NEXT:    retq
  %x = shl nsw i32 %a0, 3
  %y = freeze i32 %x
  %z = shl i32 %y, 5
  ret i32 %z
}

define i32 @freeze_shl_outofrange(i32 %a0) nounwind {
; X86-LABEL: freeze_shl_outofrange:
; X86:       # %bb.0:
; X86-NEXT:    shll $2, %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_shl_outofrange:
; X64:       # %bb.0:
; X64-NEXT:    shll $2, %eax
; X64-NEXT:    retq
  %x = shl i32 %a0, 32
  %y = freeze i32 %x
  %z = shl i32 %y, 2
  ret i32 %z
}

define <2 x i64> @freeze_shl_vec(<2 x i64> %a0) nounwind {
; X86-LABEL: freeze_shl_vec:
; X86:       # %bb.0:
; X86-NEXT:    movdqa %xmm0, %xmm1
; X86-NEXT:    psllq $4, %xmm1
; X86-NEXT:    psllq $2, %xmm0
; X86-NEXT:    movsd {{.*#+}} xmm0 = xmm1[0],xmm0[1]
; X86-NEXT:    retl
;
; X64-LABEL: freeze_shl_vec:
; X64:       # %bb.0:
; X64-NEXT:    vpsllvq {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-NEXT:    retq
  %x = shl <2 x i64> %a0, <i64 2, i64 1>
  %y = freeze <2 x i64> %x
  %z = shl <2 x i64> %y, <i64 2, i64 1>
  ret <2 x i64> %z
}

define <2 x i64> @freeze_shl_vec_outofrange(<2 x i64> %a0) nounwind {
; X86-LABEL: freeze_shl_vec_outofrange:
; X86:       # %bb.0:
; X86-NEXT:    psllq $3, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: freeze_shl_vec_outofrange:
; X64:       # %bb.0:
; X64-NEXT:    vpsllvq {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-NEXT:    vpsllq $2, %xmm0, %xmm0
; X64-NEXT:    retq
  %x = shl <2 x i64> %a0, <i64 1, i64 64>
  %y = freeze <2 x i64> %x
  %z = shl <2 x i64> %y, <i64 2, i64 2>
  ret <2 x i64> %z
}

define i32 @freeze_ashr(i32 %a0) nounwind {
; X86-LABEL: freeze_ashr:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    sarl $3, %eax
; X86-NEXT:    sarl $3, %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_ashr:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    sarl $3, %eax
; X64-NEXT:    sarl $3, %eax
; X64-NEXT:    retq
  %x = ashr i32 %a0, 3
  %y = freeze i32 %x
  %z = ashr i32 %y, 3
  ret i32 %z
}

define i32 @freeze_ashr_exact(i32 %a0) nounwind {
; X86-LABEL: freeze_ashr_exact:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    sarl $3, %eax
; X86-NEXT:    sarl $6, %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_ashr_exact:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    sarl $3, %eax
; X64-NEXT:    sarl $6, %eax
; X64-NEXT:    retq
  %x = ashr exact i32 %a0, 3
  %y = freeze i32 %x
  %z = ashr i32 %y, 6
  ret i32 %z
}

define i32 @freeze_ashr_outofrange(i32 %a0) nounwind {
; X86-LABEL: freeze_ashr_outofrange:
; X86:       # %bb.0:
; X86-NEXT:    sarl $3, %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_ashr_outofrange:
; X64:       # %bb.0:
; X64-NEXT:    sarl $3, %eax
; X64-NEXT:    retq
  %x = ashr i32 %a0, 32
  %y = freeze i32 %x
  %z = ashr i32 %y, 3
  ret i32 %z
}

define <8 x i16> @freeze_ashr_vec(<8 x i16> %a0) nounwind {
; X86-LABEL: freeze_ashr_vec:
; X86:       # %bb.0:
; X86-NEXT:    movdqa %xmm0, %xmm2
; X86-NEXT:    psraw $1, %xmm2
; X86-NEXT:    movdqa {{.*#+}} xmm1 = [65535,0,65535,0,65535,0,65535,0]
; X86-NEXT:    movdqa %xmm1, %xmm3
; X86-NEXT:    pandn %xmm2, %xmm3
; X86-NEXT:    psraw $3, %xmm0
; X86-NEXT:    pand %xmm1, %xmm0
; X86-NEXT:    por %xmm3, %xmm0
; X86-NEXT:    movdqa %xmm0, %xmm2
; X86-NEXT:    psraw $3, %xmm2
; X86-NEXT:    psraw $1, %xmm0
; X86-NEXT:    pand %xmm1, %xmm0
; X86-NEXT:    pandn %xmm2, %xmm1
; X86-NEXT:    por %xmm1, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: freeze_ashr_vec:
; X64:       # %bb.0:
; X64-NEXT:    vpsraw $1, %xmm0, %xmm1
; X64-NEXT:    vpsraw $3, %xmm0, %xmm0
; X64-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0],xmm1[1],xmm0[2],xmm1[3],xmm0[4],xmm1[5],xmm0[6],xmm1[7]
; X64-NEXT:    vpsraw $3, %xmm0, %xmm1
; X64-NEXT:    vpsraw $1, %xmm0, %xmm0
; X64-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0],xmm1[1],xmm0[2],xmm1[3],xmm0[4],xmm1[5],xmm0[6],xmm1[7]
; X64-NEXT:    retq
  %x = ashr <8 x i16> %a0, <i16 3, i16 1, i16 3, i16 1, i16 3, i16 1, i16 3, i16 1>
  %y = freeze <8 x i16> %x
  %z = ashr <8 x i16> %y, <i16 1, i16 3, i16 1, i16 3, i16 1, i16 3, i16 1, i16 3>
  ret <8 x i16> %z
}

define <4 x i32> @freeze_ashr_vec_outofrange(<4 x i32> %a0) nounwind {
; X86-LABEL: freeze_ashr_vec_outofrange:
; X86:       # %bb.0:
; X86-NEXT:    psrad $1, %xmm0
; X86-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,3,2,3]
; X86-NEXT:    psrad $2, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: freeze_ashr_vec_outofrange:
; X64:       # %bb.0:
; X64-NEXT:    vpsravd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-NEXT:    vpsrad $2, %xmm0, %xmm0
; X64-NEXT:    retq
  %x = ashr <4 x i32> %a0, <i32 1, i32 33, i32 1, i32 1>
  %y = freeze <4 x i32> %x
  %z = ashr <4 x i32> %y, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %z
}

define i32 @freeze_lshr(i32 %a0) nounwind {
; X86-LABEL: freeze_lshr:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shrl $2, %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_lshr:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shrl $2, %eax
; X64-NEXT:    shrl %eax
; X64-NEXT:    retq
  %x = lshr i32 %a0, 2
  %y = freeze i32 %x
  %z = lshr i32 %y, 1
  ret i32 %z
}

define i32 @freeze_lshr_exact(i32 %a0) nounwind {
; X86-LABEL: freeze_lshr_exact:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shrl $3, %eax
; X86-NEXT:    shrl $5, %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_lshr_exact:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shrl $3, %eax
; X64-NEXT:    shrl $5, %eax
; X64-NEXT:    retq
  %x = lshr exact i32 %a0, 3
  %y = freeze i32 %x
  %z = lshr i32 %y, 5
  ret i32 %z
}

define i32 @freeze_lshr_outofrange(i32 %a0) nounwind {
; X86-LABEL: freeze_lshr_outofrange:
; X86:       # %bb.0:
; X86-NEXT:    shrl %eax
; X86-NEXT:    retl
;
; X64-LABEL: freeze_lshr_outofrange:
; X64:       # %bb.0:
; X64-NEXT:    shrl %eax
; X64-NEXT:    retq
  %x = lshr i32 %a0, 32
  %y = freeze i32 %x
  %z = lshr i32 %y, 1
  ret i32 %z
}

define <8 x i16> @freeze_lshr_vec(<8 x i16> %a0) nounwind {
; X86-LABEL: freeze_lshr_vec:
; X86:       # %bb.0:
; X86-NEXT:    movdqa %xmm0, %xmm2
; X86-NEXT:    psrlw $1, %xmm2
; X86-NEXT:    movdqa {{.*#+}} xmm1 = [65535,0,65535,0,65535,0,65535,0]
; X86-NEXT:    movdqa %xmm1, %xmm3
; X86-NEXT:    pandn %xmm2, %xmm3
; X86-NEXT:    psrlw $2, %xmm0
; X86-NEXT:    pand %xmm1, %xmm0
; X86-NEXT:    por %xmm3, %xmm0
; X86-NEXT:    movdqa %xmm0, %xmm2
; X86-NEXT:    psrlw $2, %xmm2
; X86-NEXT:    psrlw $1, %xmm0
; X86-NEXT:    pand %xmm1, %xmm0
; X86-NEXT:    pandn %xmm2, %xmm1
; X86-NEXT:    por %xmm1, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: freeze_lshr_vec:
; X64:       # %bb.0:
; X64-NEXT:    vpsrlw $1, %xmm0, %xmm1
; X64-NEXT:    vpsrlw $2, %xmm0, %xmm0
; X64-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0],xmm1[1],xmm0[2],xmm1[3],xmm0[4],xmm1[5],xmm0[6],xmm1[7]
; X64-NEXT:    vpsrlw $2, %xmm0, %xmm1
; X64-NEXT:    vpsrlw $1, %xmm0, %xmm0
; X64-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0],xmm1[1],xmm0[2],xmm1[3],xmm0[4],xmm1[5],xmm0[6],xmm1[7]
; X64-NEXT:    retq
  %x = lshr <8 x i16> %a0, <i16 2, i16 1, i16 2, i16 1, i16 2, i16 1, i16 2, i16 1>
  %y = freeze <8 x i16> %x
  %z = lshr <8 x i16> %y, <i16 1, i16 2, i16 1, i16 2, i16 1, i16 2, i16 1, i16 2>
  ret <8 x i16> %z
}

define <4 x i32> @freeze_lshr_vec_outofrange(<4 x i32> %a0) nounwind {
; X86-LABEL: freeze_lshr_vec_outofrange:
; X86:       # %bb.0:
; X86-NEXT:    psrld $1, %xmm0
; X86-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,3,2,3]
; X86-NEXT:    psrld $2, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: freeze_lshr_vec_outofrange:
; X64:       # %bb.0:
; X64-NEXT:    vpsrlvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-NEXT:    vpsrld $2, %xmm0, %xmm0
; X64-NEXT:    retq
  %x = lshr <4 x i32> %a0, <i32 1, i32 33, i32 1, i32 1>
  %y = freeze <4 x i32> %x
  %z = lshr <4 x i32> %y, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %z
}
