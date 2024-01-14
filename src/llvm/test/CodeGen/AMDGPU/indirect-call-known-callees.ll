; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 < %s | FileCheck %s

; We have an indirect call with a known set of callees, which are
; known to not need any special inputs. The ABI still needs to use the
; register

; FIXME: Passing real values for workitem ID, and 0s that can be undef

define amdgpu_kernel void @indirect_call_known_no_special_inputs() {
; CHECK-LABEL: indirect_call_known_no_special_inputs:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_add_u32 flat_scratch_lo, s4, s7
; CHECK-NEXT:    s_addc_u32 flat_scratch_hi, s5, 0
; CHECK-NEXT:    s_add_u32 s0, s0, s7
; CHECK-NEXT:    s_addc_u32 s1, s1, 0
; CHECK-NEXT:    s_mov_b64 s[4:5], 0
; CHECK-NEXT:    s_load_dword s7, s[4:5], 0x0
; CHECK-NEXT:    s_getpc_b64 s[4:5]
; CHECK-NEXT:    s_add_u32 s4, s4, wobble@gotpcrel32@lo+4
; CHECK-NEXT:    s_addc_u32 s5, s5, wobble@gotpcrel32@hi+12
; CHECK-NEXT:    s_getpc_b64 s[8:9]
; CHECK-NEXT:    s_add_u32 s8, s8, snork@gotpcrel32@lo+4
; CHECK-NEXT:    s_addc_u32 s9, s9, snork@gotpcrel32@hi+12
; CHECK-NEXT:    s_load_dwordx2 s[10:11], s[8:9], 0x0
; CHECK-NEXT:    s_load_dwordx2 s[12:13], s[4:5], 0x0
; CHECK-NEXT:    s_mov_b64 s[8:9], 0
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_and_b32 s4, 1, s7
; CHECK-NEXT:    s_cmp_eq_u32 s4, 1
; CHECK-NEXT:    v_mov_b32_e32 v31, v0
; CHECK-NEXT:    s_cselect_b32 s5, s13, s11
; CHECK-NEXT:    s_cselect_b32 s4, s12, s10
; CHECK-NEXT:    s_mov_b32 s12, s6
; CHECK-NEXT:    v_mov_b32_e32 v1, 0
; CHECK-NEXT:    v_mov_b32_e32 v4, 0
; CHECK-NEXT:    s_mov_b32 s32, 0
; CHECK-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; CHECK-NEXT:    s_endpgm

bb:
  %cond = load i1, i1 addrspace(4)* null
  %tmp = select i1 %cond, void (i8*, i32, i8*)* bitcast (void ()* @wobble to void (i8*, i32, i8*)*), void (i8*, i32, i8*)* bitcast (void ()* @snork to void (i8*, i32, i8*)*)
  call void %tmp(i8* undef, i32 undef, i8* undef)
  ret void
}

define void @wobble() {
; CHECK-LABEL: wobble:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
bb:
  ret void
}

define void @snork() {
; CHECK-LABEL: snork:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
bb:
  ret void
}
