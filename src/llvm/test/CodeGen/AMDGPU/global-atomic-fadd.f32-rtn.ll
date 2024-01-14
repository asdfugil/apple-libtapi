; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx90a -verify-machineinstrs -stop-after=amdgpu-isel < %s | FileCheck -check-prefix=GFX90A_GFX940 %s
; RUN: llc -march=amdgcn -mcpu=gfx940 -verify-machineinstrs -stop-after=amdgpu-isel < %s | FileCheck -check-prefix=GFX90A_GFX940 %s
; RUN: llc -march=amdgcn -mcpu=gfx1100 -verify-machineinstrs -stop-after=amdgpu-isel < %s | FileCheck -check-prefix=GFX11 %s

define amdgpu_ps float @global_atomic_fadd_f32_rtn_intrinsic(float addrspace(1)* %ptr, float %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f32_rtn_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_RTN killed [[COPY3]], [[COPY]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  ; GFX11-LABEL: name: global_atomic_fadd_f32_rtn_intrinsic
  ; GFX11: bb.0 (%ir-block.0):
  ; GFX11-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX11-NEXT:   [[COPY3:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]]
  ; GFX11-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_RTN killed [[COPY3]], [[COPY]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX11-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_RTN]]
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = call float @llvm.amdgcn.global.atomic.fadd.f32.p1f32.f32(float addrspace(1)* %ptr, float %data)
  ret float %ret
}

define amdgpu_ps float @global_atomic_fadd_f32_saddr_rtn_intrinsic(float addrspace(1)* inreg %ptr, float %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f32_saddr_rtn_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_SADDR_RTN killed [[V_MOV_B32_e32_]], [[COPY]], killed [[REG_SEQUENCE]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  ; GFX11-LABEL: name: global_atomic_fadd_f32_saddr_rtn_intrinsic
  ; GFX11: bb.0 (%ir-block.0):
  ; GFX11-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX11-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX11-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_SADDR_RTN killed [[V_MOV_B32_e32_]], [[COPY]], killed [[REG_SEQUENCE]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX11-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN]]
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = call float @llvm.amdgcn.global.atomic.fadd.f32.p1f32.f32(float addrspace(1)* inreg %ptr, float %data)
  ret float %ret
}

define amdgpu_ps float @global_atomic_fadd_f32_rtn_flat_intrinsic(float addrspace(1)* %ptr, float %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f32_rtn_flat_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_RTN killed [[COPY3]], [[COPY]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  ; GFX11-LABEL: name: global_atomic_fadd_f32_rtn_flat_intrinsic
  ; GFX11: bb.0 (%ir-block.0):
  ; GFX11-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX11-NEXT:   [[COPY3:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]]
  ; GFX11-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_RTN killed [[COPY3]], [[COPY]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX11-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_RTN]]
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = call float @llvm.amdgcn.flat.atomic.fadd.f32.p1f32.f32(float addrspace(1)* %ptr, float %data)
  ret float %ret
}

define amdgpu_ps float @global_atomic_fadd_f32_saddr_rtn_flat_intrinsic(float addrspace(1)* inreg %ptr, float %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f32_saddr_rtn_flat_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_SADDR_RTN killed [[V_MOV_B32_e32_]], [[COPY]], killed [[REG_SEQUENCE]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  ; GFX11-LABEL: name: global_atomic_fadd_f32_saddr_rtn_flat_intrinsic
  ; GFX11: bb.0 (%ir-block.0):
  ; GFX11-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX11-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX11-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_SADDR_RTN killed [[V_MOV_B32_e32_]], [[COPY]], killed [[REG_SEQUENCE]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32) on %ir.ptr, addrspace 1)
  ; GFX11-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN]]
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = call float @llvm.amdgcn.flat.atomic.fadd.f32.p1f32.f32(float addrspace(1)* inreg %ptr, float %data)
  ret float %ret
}

define amdgpu_ps float @global_atomic_fadd_f32_rtn_atomicrmw(float addrspace(1)* %ptr, float %data) #0 {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f32_rtn_atomicrmw
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_RTN killed [[COPY3]], [[COPY]], 0, 1, implicit $exec :: (load store syncscope("wavefront") monotonic (s32) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  ; GFX11-LABEL: name: global_atomic_fadd_f32_rtn_atomicrmw
  ; GFX11: bb.0 (%ir-block.0):
  ; GFX11-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX11-NEXT:   [[COPY3:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]]
  ; GFX11-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_RTN killed [[COPY3]], [[COPY]], 0, 1, implicit $exec :: (load store syncscope("wavefront") monotonic (s32) on %ir.ptr, addrspace 1)
  ; GFX11-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_RTN]]
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = atomicrmw fadd float addrspace(1)* %ptr, float %data syncscope("wavefront") monotonic
  ret float %ret
}

define amdgpu_ps float @global_atomic_fadd_f32_saddr_rtn_atomicrmw(float addrspace(1)* inreg %ptr, float %data) #0 {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f32_saddr_rtn_atomicrmw
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_SADDR_RTN killed [[V_MOV_B32_e32_]], [[COPY]], killed [[REG_SEQUENCE]], 0, 1, implicit $exec :: (load store syncscope("wavefront") monotonic (s32) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  ; GFX11-LABEL: name: global_atomic_fadd_f32_saddr_rtn_atomicrmw
  ; GFX11: bb.0 (%ir-block.0):
  ; GFX11-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0
  ; GFX11-NEXT: {{  $}}
  ; GFX11-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX11-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX11-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX11-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX11-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX11-NEXT:   [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN:%[0-9]+]]:vgpr_32 = GLOBAL_ATOMIC_ADD_F32_SADDR_RTN killed [[V_MOV_B32_e32_]], [[COPY]], killed [[REG_SEQUENCE]], 0, 1, implicit $exec :: (load store syncscope("wavefront") monotonic (s32) on %ir.ptr, addrspace 1)
  ; GFX11-NEXT:   $vgpr0 = COPY [[GLOBAL_ATOMIC_ADD_F32_SADDR_RTN]]
  ; GFX11-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = atomicrmw fadd float addrspace(1)* %ptr, float %data syncscope("wavefront") monotonic
  ret float %ret
}

declare float @llvm.amdgcn.global.atomic.fadd.f32.p1f32.f32(float addrspace(1)*, float)
declare float @llvm.amdgcn.flat.atomic.fadd.f32.p1f32.f32(float addrspace(1)*, float)

attributes #0 = {"amdgpu-unsafe-fp-atomics"="true" }
