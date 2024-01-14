; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn--amdhsa -mcpu=kaveri -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefixes=GCN,CI %s
; RUN: llc -mtriple=amdgcn--amdhsa -mcpu=tonga -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefixes=GCN,GFX89,VI %s
; RUN: llc -mtriple=amdgcn--amdhsa -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefixes=GCN,GFX89,GFX9 %s

; DAGCombiner will transform:
; (fabs (f16 bitcast (i16 a))) => (f16 bitcast (and (i16 a), 0x7FFFFFFF))
; unless isFabsFree returns true

define amdgpu_kernel void @s_fabs_free_f16(half addrspace(1)* %out, i16 %in) {
; CI-LABEL: s_fabs_free_f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dword s2, s[4:5], 0x2
; CI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_and_b32 s2, s2, 0x7fff
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    v_mov_b32_e32 v2, s2
; CI-NEXT:    flat_store_short v[0:1], v2
; CI-NEXT:    s_endpgm
;
; VI-LABEL: s_fabs_free_f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[4:5], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_and_b32 s2, s2, 0x7fff
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_mov_b32_e32 v2, s2
; VI-NEXT:    flat_store_short v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: s_fabs_free_f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_and_b32 s2, s2, 0x7fff
; GFX9-NEXT:    v_mov_b32_e32 v1, s2
; GFX9-NEXT:    global_store_short v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
  %bc= bitcast i16 %in to half
  %fabs = call half @llvm.fabs.f16(half %bc)
  store half %fabs, half addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @s_fabs_f16(half addrspace(1)* %out, half %in) {
; CI-LABEL: s_fabs_f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dword s2, s[4:5], 0x2
; CI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_and_b32 s2, s2, 0x7fff
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    v_mov_b32_e32 v2, s2
; CI-NEXT:    flat_store_short v[0:1], v2
; CI-NEXT:    s_endpgm
;
; VI-LABEL: s_fabs_f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[4:5], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_and_b32 s2, s2, 0x7fff
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_mov_b32_e32 v2, s2
; VI-NEXT:    flat_store_short v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: s_fabs_f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_and_b32 s2, s2, 0x7fff
; GFX9-NEXT:    v_mov_b32_e32 v1, s2
; GFX9-NEXT:    global_store_short v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
  %fabs = call half @llvm.fabs.f16(half %in)
  store half %fabs, half addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @s_fabs_v2f16(<2 x half> addrspace(1)* %out, <2 x half> %in) {
; CI-LABEL: s_fabs_v2f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dword s2, s[4:5], 0x2
; CI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_and_b32 s2, s2, 0x7fff7fff
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    v_mov_b32_e32 v2, s2
; CI-NEXT:    flat_store_dword v[0:1], v2
; CI-NEXT:    s_endpgm
;
; VI-LABEL: s_fabs_v2f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[4:5], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_and_b32 s2, s2, 0x7fff7fff
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_mov_b32_e32 v2, s2
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: s_fabs_v2f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_and_b32 s2, s2, 0x7fff7fff
; GFX9-NEXT:    v_mov_b32_e32 v1, s2
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
  %fabs = call <2 x half> @llvm.fabs.v2f16(<2 x half> %in)
  store <2 x half> %fabs, <2 x half> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @s_fabs_v4f16(<4 x half> addrspace(1)* %out, <4 x half> %in) {
; CI-LABEL: s_fabs_v4f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_and_b32 s3, s3, 0x7fff7fff
; CI-NEXT:    s_and_b32 s2, s2, 0x7fff7fff
; CI-NEXT:    v_mov_b32_e32 v3, s1
; CI-NEXT:    v_mov_b32_e32 v0, s2
; CI-NEXT:    v_mov_b32_e32 v1, s3
; CI-NEXT:    v_mov_b32_e32 v2, s0
; CI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CI-NEXT:    s_endpgm
;
; VI-LABEL: s_fabs_v4f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_and_b32 s3, s3, 0x7fff7fff
; VI-NEXT:    s_and_b32 s2, s2, 0x7fff7fff
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    v_mov_b32_e32 v0, s2
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_mov_b32_e32 v2, s0
; VI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: s_fabs_v4f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v2, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_and_b32 s3, s3, 0x7fff7fff
; GFX9-NEXT:    s_and_b32 s2, s2, 0x7fff7fff
; GFX9-NEXT:    v_mov_b32_e32 v0, s2
; GFX9-NEXT:    v_mov_b32_e32 v1, s3
; GFX9-NEXT:    global_store_dwordx2 v2, v[0:1], s[0:1]
; GFX9-NEXT:    s_endpgm
  %fabs = call <4 x half> @llvm.fabs.v4f16(<4 x half> %in)
  store <4 x half> %fabs, <4 x half> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @fabs_fold_f16(half addrspace(1)* %out, half %in0, half %in1) {
; CI-LABEL: fabs_fold_f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dword s0, s[4:5], 0x2
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    v_cvt_f32_f16_e64 v0, |s0|
; CI-NEXT:    s_lshr_b32 s0, s0, 16
; CI-NEXT:    v_cvt_f32_f16_e32 v1, s0
; CI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; CI-NEXT:    v_mul_f32_e32 v0, v0, v1
; CI-NEXT:    v_cvt_f16_f32_e32 v2, v0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    flat_store_short v[0:1], v2
; CI-NEXT:    s_endpgm
;
; VI-LABEL: fabs_fold_f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[4:5], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_lshr_b32 s3, s2, 16
; VI-NEXT:    v_mov_b32_e32 v0, s3
; VI-NEXT:    v_mul_f16_e64 v2, |s2|, v0
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    flat_store_short v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: fabs_fold_f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_lshr_b32 s3, s2, 16
; GFX9-NEXT:    v_mov_b32_e32 v1, s3
; GFX9-NEXT:    v_mul_f16_e64 v1, |s2|, v1
; GFX9-NEXT:    global_store_short v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
  %fabs = call half @llvm.fabs.f16(half %in0)
  %fmul = fmul half %fabs, %in1
  store half %fmul, half addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @v_fabs_v2f16(<2 x half> addrspace(1)* %out, <2 x half> addrspace(1)* %in) #0 {
; CI-LABEL: v_fabs_v2f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x2
; CI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    v_add_i32_e32 v0, vcc, s0, v0
; CI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; CI-NEXT:    flat_load_dword v2, v[0:1]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_and_b32_e32 v2, 0x7fff7fff, v2
; CI-NEXT:    flat_store_dword v[0:1], v2
; CI-NEXT:    s_endpgm
;
; VI-LABEL: v_fabs_v2f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x8
; VI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_add_u32_e32 v0, vcc, s0, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v2, v[0:1]
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_and_b32_e32 v2, 0x7fff7fff, v2
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_fabs_v2f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x8
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[0:1]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_and_b32_e32 v1, 0x7fff7fff, v1
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.in = getelementptr inbounds <2 x half>, <2 x half> addrspace(1)* %in, i32 %tid
  %gep.out = getelementptr inbounds <2 x half>, <2 x half> addrspace(1)* %in, i32 %tid
  %val = load <2 x half>, <2 x half> addrspace(1)* %gep.in, align 2
  %fabs = call <2 x half> @llvm.fabs.v2f16(<2 x half> %val)
  store <2 x half> %fabs, <2 x half> addrspace(1)* %gep.out
  ret void
}

define amdgpu_kernel void @fabs_free_v2f16(<2 x half> addrspace(1)* %out, i32 %in) #0 {
; CI-LABEL: fabs_free_v2f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dword s2, s[4:5], 0x2
; CI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_and_b32 s2, s2, 0x7fff7fff
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    v_mov_b32_e32 v2, s2
; CI-NEXT:    flat_store_dword v[0:1], v2
; CI-NEXT:    s_endpgm
;
; VI-LABEL: fabs_free_v2f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[4:5], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_and_b32 s2, s2, 0x7fff7fff
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_mov_b32_e32 v2, s2
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: fabs_free_v2f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_and_b32 s2, s2, 0x7fff7fff
; GFX9-NEXT:    v_mov_b32_e32 v1, s2
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
  %bc = bitcast i32 %in to <2 x half>
  %fabs = call <2 x half> @llvm.fabs.v2f16(<2 x half> %bc)
  store <2 x half> %fabs, <2 x half> addrspace(1)* %out
  ret void
}

; FIXME: Should do fabs after conversion to avoid converting multiple
; times in this particular case.
define amdgpu_kernel void @v_fabs_fold_self_v2f16(<2 x half> addrspace(1)* %out, <2 x half> addrspace(1)* %in) #0 {
; CI-LABEL: v_fabs_fold_self_v2f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    v_mov_b32_e32 v1, s3
; CI-NEXT:    v_add_i32_e32 v0, vcc, s2, v0
; CI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; CI-NEXT:    flat_load_dword v0, v[0:1]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_lshrrev_b32_e32 v1, 16, v0
; CI-NEXT:    v_cvt_f32_f16_e32 v2, v1
; CI-NEXT:    v_cvt_f32_f16_e64 v1, |v1|
; CI-NEXT:    v_cvt_f32_f16_e32 v3, v0
; CI-NEXT:    v_cvt_f32_f16_e64 v0, |v0|
; CI-NEXT:    v_mul_f32_e32 v1, v1, v2
; CI-NEXT:    v_cvt_f16_f32_e32 v2, v1
; CI-NEXT:    v_mul_f32_e32 v0, v0, v3
; CI-NEXT:    v_cvt_f16_f32_e32 v3, v0
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    v_or_b32_e32 v2, v3, v2
; CI-NEXT:    flat_store_dword v[0:1], v2
; CI-NEXT:    s_endpgm
;
; VI-LABEL: v_fabs_fold_self_v2f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; VI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v2, v[0:1]
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_mul_f16_sdwa v3, |v2|, v2 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; VI-NEXT:    v_mul_f16_e64 v2, |v2|, v2
; VI-NEXT:    v_or_b32_e32 v2, v2, v3
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_fabs_fold_self_v2f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    v_mov_b32_e32 v1, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v0, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_and_b32_e32 v2, 0x7fff7fff, v0
; GFX9-NEXT:    v_pk_mul_f16 v0, v2, v0
; GFX9-NEXT:    global_store_dword v1, v0, s[0:1]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep = getelementptr <2 x half>, <2 x half> addrspace(1)* %in, i32 %tid
  %val = load <2 x half>, <2 x half> addrspace(1)* %gep
  %fabs = call <2 x half> @llvm.fabs.v2f16(<2 x half> %val)
  %fmul = fmul <2 x half> %fabs, %val
  store <2 x half> %fmul, <2 x half> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @v_fabs_fold_v2f16(<2 x half> addrspace(1)* %out, <2 x half> addrspace(1)* %in, i32 %other.val) #0 {
; CI-LABEL: v_fabs_fold_v2f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; CI-NEXT:    s_load_dword s4, s[4:5], 0x4
; CI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    v_mov_b32_e32 v1, s3
; CI-NEXT:    v_add_i32_e32 v0, vcc, s2, v0
; CI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; CI-NEXT:    flat_load_dword v0, v[0:1]
; CI-NEXT:    s_lshr_b32 s2, s4, 16
; CI-NEXT:    v_cvt_f32_f16_e32 v1, s2
; CI-NEXT:    v_cvt_f32_f16_e32 v3, s4
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_lshrrev_b32_e32 v2, 16, v0
; CI-NEXT:    v_cvt_f32_f16_e64 v2, |v2|
; CI-NEXT:    v_cvt_f32_f16_e64 v0, |v0|
; CI-NEXT:    v_mul_f32_e32 v1, v2, v1
; CI-NEXT:    v_cvt_f16_f32_e32 v2, v1
; CI-NEXT:    v_mul_f32_e32 v0, v0, v3
; CI-NEXT:    v_cvt_f16_f32_e32 v3, v0
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    v_or_b32_e32 v2, v3, v2
; CI-NEXT:    flat_store_dword v[0:1], v2
; CI-NEXT:    s_endpgm
;
; VI-LABEL: v_fabs_fold_v2f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; VI-NEXT:    s_load_dword s4, s[4:5], 0x10
; VI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v2, v[0:1]
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    s_lshr_b32 s0, s4, 16
; VI-NEXT:    v_mov_b32_e32 v3, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_mul_f16_sdwa v3, |v2|, v3 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; VI-NEXT:    v_mul_f16_e64 v2, |v2|, s4
; VI-NEXT:    v_or_b32_e32 v2, v2, v3
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_fabs_fold_v2f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[4:5], 0x0
; GFX9-NEXT:    s_load_dword s6, s[4:5], 0x10
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    v_mov_b32_e32 v1, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v0, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_and_b32_e32 v0, 0x7fff7fff, v0
; GFX9-NEXT:    v_pk_mul_f16 v0, v0, s6
; GFX9-NEXT:    global_store_dword v1, v0, s[0:1]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep = getelementptr <2 x half>, <2 x half> addrspace(1)* %in, i32 %tid
  %val = load <2 x half>, <2 x half> addrspace(1)* %gep
  %fabs = call <2 x half> @llvm.fabs.v2f16(<2 x half> %val)
  %other.val.cvt = bitcast i32 %other.val to <2 x half>
  %fmul = fmul <2 x half> %fabs, %other.val.cvt
  store <2 x half> %fmul, <2 x half> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @v_extract_fabs_fold_v2f16(<2 x half> addrspace(1)* %in) #0 {
; CI-LABEL: v_extract_fabs_fold_v2f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    v_add_i32_e32 v0, vcc, s0, v0
; CI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; CI-NEXT:    flat_load_dword v0, v[0:1]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_lshrrev_b32_e32 v1, 16, v0
; CI-NEXT:    v_cvt_f32_f16_e64 v0, |v0|
; CI-NEXT:    v_cvt_f32_f16_e64 v1, |v1|
; CI-NEXT:    v_mul_f32_e32 v0, 4.0, v0
; CI-NEXT:    v_add_f32_e32 v1, 2.0, v1
; CI-NEXT:    v_cvt_f16_f32_e32 v0, v0
; CI-NEXT:    v_cvt_f16_f32_e32 v1, v1
; CI-NEXT:    flat_store_short v[0:1], v0
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    flat_store_short v[0:1], v1
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    s_endpgm
;
; VI-LABEL: v_extract_fabs_fold_v2f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; VI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_add_u32_e32 v0, vcc, s0, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    v_mov_b32_e32 v1, 0x4000
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_mul_f16_e64 v2, |v0|, 4.0
; VI-NEXT:    v_add_f16_sdwa v0, |v0|, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; VI-NEXT:    flat_store_short v[0:1], v2
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    flat_store_short v[0:1], v0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_extract_fabs_fold_v2f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    v_mov_b32_e32 v1, 0x4000
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v0, v0, s[0:1]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_mul_f16_e64 v2, |v0|, 4.0
; GFX9-NEXT:    v_add_f16_sdwa v0, |v0|, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; GFX9-NEXT:    global_store_short v[0:1], v2, off
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    global_store_short v[0:1], v0, off
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.in = getelementptr inbounds <2 x half>, <2 x half> addrspace(1)* %in, i32 %tid
  %val = load <2 x half>, <2 x half> addrspace(1)* %gep.in
  %fabs = call <2 x half> @llvm.fabs.v2f16(<2 x half> %val)
  %elt0 = extractelement <2 x half> %fabs, i32 0
  %elt1 = extractelement <2 x half> %fabs, i32 1

  %fmul0 = fmul half %elt0, 4.0
  %fadd1 = fadd half %elt1, 2.0
  store volatile half %fmul0, half addrspace(1)* undef
  store volatile half %fadd1, half addrspace(1)* undef
  ret void
}

define amdgpu_kernel void @v_extract_fabs_no_fold_v2f16(<2 x half> addrspace(1)* %in) #0 {
; CI-LABEL: v_extract_fabs_no_fold_v2f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; CI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    v_add_i32_e32 v0, vcc, s0, v0
; CI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; CI-NEXT:    flat_load_dword v0, v[0:1]
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    v_bfe_u32 v1, v0, 16, 15
; CI-NEXT:    v_and_b32_e32 v0, 0x7fff, v0
; CI-NEXT:    flat_store_short v[0:1], v0
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    flat_store_short v[0:1], v1
; CI-NEXT:    s_waitcnt vmcnt(0)
; CI-NEXT:    s_endpgm
;
; VI-LABEL: v_extract_fabs_no_fold_v2f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; VI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_add_u32_e32 v0, vcc, s0, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_and_b32_e32 v1, 0x7fff7fff, v0
; VI-NEXT:    v_bfe_u32 v0, v0, 16, 15
; VI-NEXT:    flat_store_short v[0:1], v1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    flat_store_short v[0:1], v0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_extract_fabs_no_fold_v2f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v0, v0, s[0:1]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_and_b32_e32 v0, 0x7fff7fff, v0
; GFX9-NEXT:    global_store_short v[0:1], v0, off
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    global_store_short_d16_hi v[0:1], v0, off
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.in = getelementptr inbounds <2 x half>, <2 x half> addrspace(1)* %in, i32 %tid
  %val = load <2 x half>, <2 x half> addrspace(1)* %gep.in
  %fabs = call <2 x half> @llvm.fabs.v2f16(<2 x half> %val)
  %elt0 = extractelement <2 x half> %fabs, i32 0
  %elt1 = extractelement <2 x half> %fabs, i32 1
  store volatile half %elt0, half addrspace(1)* undef
  store volatile half %elt1, half addrspace(1)* undef
  ret void
}

declare half @llvm.fabs.f16(half) #1
declare <2 x half> @llvm.fabs.v2f16(<2 x half>) #1
declare <4 x half> @llvm.fabs.v4f16(<4 x half>) #1
declare i32 @llvm.amdgcn.workitem.id.x() #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; GCN: {{.*}}
; GFX89: {{.*}}
