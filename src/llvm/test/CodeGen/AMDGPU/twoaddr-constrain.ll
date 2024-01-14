; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx900 -verify-machineinstrs -stop-after twoaddressinstruction < %s | FileCheck %s

; Check that %16 gets constrained to register class sgpr_96_with_sub0_sub1.
define amdgpu_ps <3 x i32> @s_load_constant_v3i32_align4(<3 x i32> addrspace(4)* inreg %ptr) {
  ; CHECK-LABEL: name: s_load_constant_v3i32_align4
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr0, $sgpr1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY killed $sgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY killed $sgpr1
  ; CHECK-NEXT:   undef %0.sub0:sreg_64 = COPY killed [[COPY]]
  ; CHECK-NEXT:   %0.sub1:sreg_64 = COPY killed [[COPY1]]
  ; CHECK-NEXT:   [[S_LOAD_DWORDX2_IMM:%[0-9]+]]:sreg_64_xexec = S_LOAD_DWORDX2_IMM %0, 0, 0 :: (invariant load (<2 x s32>) from %ir.ptr, align 4, addrspace 4)
  ; CHECK-NEXT:   [[S_LOAD_DWORD_IMM:%[0-9]+]]:sreg_32_xm0_xexec = S_LOAD_DWORD_IMM killed %0, 8, 0 :: (invariant load (s32) from %ir.ptr + 8, addrspace 4)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY [[S_LOAD_DWORDX2_IMM]].sub0
  ; CHECK-NEXT:   $sgpr0 = COPY killed [[COPY2]]
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY killed [[S_LOAD_DWORDX2_IMM]].sub1
  ; CHECK-NEXT:   $sgpr1 = COPY killed [[COPY3]]
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY killed [[S_LOAD_DWORD_IMM]]
  ; CHECK-NEXT:   $sgpr2 = COPY killed [[COPY4]]
  ; CHECK-NEXT:   SI_RETURN_TO_EPILOG implicit killed $sgpr0, implicit killed $sgpr1, implicit killed $sgpr2
  %load = load <3 x i32>, <3 x i32> addrspace(4)* %ptr, align 4
  ret <3 x i32> %load
}
