; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple armv8.6a-arm-none-eabi -o - %s | FileCheck %s --check-prefix=BASE --check-prefix=BASE-ARM
; RUN: llc -mtriple thumbv8.6a-arm-none-eabi -o - %s | FileCheck %s --check-prefix=BASE --check-prefix=BASE-THUMB
; RUN: llc -mtriple armv8.6a-arm-none-eabi -mattr=+fullfp16 -o - %s | FileCheck %s --check-prefix=FULLFP16 --check-prefix=FULLFP16-ARM
; RUN: llc -mtriple thumbv8.6a-arm-none-eabi -mattr=+fullfp16 -o - %s | FileCheck %s --check-prefix=FULLFP16 --check-prefix=FULLFP16-THUMB

define bfloat @bf_load_soft(bfloat* %p) {
; BASE-LABEL: bf_load_soft:
; BASE:       @ %bb.0:
; BASE-NEXT:    ldrh r0, [r0]
; BASE-NEXT:    bx lr
;
; FULLFP16-LABEL: bf_load_soft:
; FULLFP16:       @ %bb.0:
; FULLFP16-NEXT:    vldr.16 s0, [r0]
; FULLFP16-NEXT:    vmov r0, s0
; FULLFP16-NEXT:    bx lr
  %f = load bfloat, bfloat* %p, align 2
  ret bfloat %f
}

define arm_aapcs_vfpcc bfloat @bf_load_hard(bfloat* %p) {
; BASE-LABEL: bf_load_hard:
; BASE:       @ %bb.0:
; BASE-NEXT:    ldrh r0, [r0]
; BASE-NEXT:    vmov s0, r0
; BASE-NEXT:    bx lr
;
; FULLFP16-LABEL: bf_load_hard:
; FULLFP16:       @ %bb.0:
; FULLFP16-NEXT:    vldr.16 s0, [r0]
; FULLFP16-NEXT:    bx lr
  %f = load bfloat, bfloat* %p, align 2
  ret bfloat %f
}

define void @bf_store_soft(bfloat* %p, bfloat %f) {
; BASE-LABEL: bf_store_soft:
; BASE:       @ %bb.0:
; BASE-NEXT:    strh r1, [r0]
; BASE-NEXT:    bx lr
;
; FULLFP16-LABEL: bf_store_soft:
; FULLFP16:       @ %bb.0:
; FULLFP16-NEXT:    vmov.f16 s0, r1
; FULLFP16-NEXT:    vstr.16 s0, [r0]
; FULLFP16-NEXT:    bx lr
  store bfloat %f, bfloat* %p, align 2
  ret void
}

define arm_aapcs_vfpcc void @bf_store_hard(bfloat* %p, bfloat %f) {
; BASE-LABEL: bf_store_hard:
; BASE:       @ %bb.0:
; BASE-NEXT:    vmov r1, s0
; BASE-NEXT:    strh r1, [r0]
; BASE-NEXT:    bx lr
;
; FULLFP16-LABEL: bf_store_hard:
; FULLFP16:       @ %bb.0:
; FULLFP16-NEXT:    vstr.16 s0, [r0]
; FULLFP16-NEXT:    bx lr
  store bfloat %f, bfloat* %p, align 2
  ret void
}

define i32 @bf_to_int_soft(bfloat %f) {
; BASE-LABEL: bf_to_int_soft:
; BASE:       @ %bb.0:
; BASE-NEXT:    uxth r0, r0
; BASE-NEXT:    bx lr
;
; FULLFP16-LABEL: bf_to_int_soft:
; FULLFP16:       @ %bb.0:
; FULLFP16-NEXT:    vmov.f16 s0, r0
; FULLFP16-NEXT:    vmov.f16 r0, s0
; FULLFP16-NEXT:    bx lr
  %h = bitcast bfloat %f to i16
  %w = zext i16 %h to i32
  ret i32 %w
}

define arm_aapcs_vfpcc i32 @bf_to_int_hard(bfloat %f) {
; BASE-LABEL: bf_to_int_hard:
; BASE:       @ %bb.0:
; BASE-NEXT:    vmov r0, s0
; BASE-NEXT:    uxth r0, r0
; BASE-NEXT:    bx lr
;
; FULLFP16-LABEL: bf_to_int_hard:
; FULLFP16:       @ %bb.0:
; FULLFP16-NEXT:    vmov.f16 r0, s0
; FULLFP16-NEXT:    bx lr
  %h = bitcast bfloat %f to i16
  %w = zext i16 %h to i32
  ret i32 %w
}

define bfloat @bf_from_int_soft(i32 %w) {
; BASE-ARM-LABEL: bf_from_int_soft:
; BASE-ARM:       @ %bb.0:
; BASE-ARM-NEXT:    .pad #4
; BASE-ARM-NEXT:    sub sp, sp, #4
; BASE-ARM-NEXT:    strh r0, [sp, #2]
; BASE-ARM-NEXT:    ldrh r0, [sp, #2]
; BASE-ARM-NEXT:    add sp, sp, #4
; BASE-ARM-NEXT:    bx lr
;
; BASE-THUMB-LABEL: bf_from_int_soft:
; BASE-THUMB:       @ %bb.0:
; BASE-THUMB-NEXT:    .pad #4
; BASE-THUMB-NEXT:    sub sp, #4
; BASE-THUMB-NEXT:    strh.w r0, [sp, #2]
; BASE-THUMB-NEXT:    ldrh.w r0, [sp, #2]
; BASE-THUMB-NEXT:    add sp, #4
; BASE-THUMB-NEXT:    bx lr
;
; FULLFP16-LABEL: bf_from_int_soft:
; FULLFP16:       @ %bb.0:
; FULLFP16-NEXT:    vmov.f16 s0, r0
; FULLFP16-NEXT:    vmov r0, s0
; FULLFP16-NEXT:    bx lr
  %h = trunc i32 %w to i16
  %f = bitcast i16 %h to bfloat
  ret bfloat %f
}

define arm_aapcs_vfpcc bfloat @bf_from_int_hard(i32 %w) {
; BASE-ARM-LABEL: bf_from_int_hard:
; BASE-ARM:       @ %bb.0:
; BASE-ARM-NEXT:    .pad #4
; BASE-ARM-NEXT:    sub sp, sp, #4
; BASE-ARM-NEXT:    strh r0, [sp, #2]
; BASE-ARM-NEXT:    ldrh r0, [sp, #2]
; BASE-ARM-NEXT:    vmov s0, r0
; BASE-ARM-NEXT:    add sp, sp, #4
; BASE-ARM-NEXT:    bx lr
;
; BASE-THUMB-LABEL: bf_from_int_hard:
; BASE-THUMB:       @ %bb.0:
; BASE-THUMB-NEXT:    .pad #4
; BASE-THUMB-NEXT:    sub sp, #4
; BASE-THUMB-NEXT:    strh.w r0, [sp, #2]
; BASE-THUMB-NEXT:    ldrh.w r0, [sp, #2]
; BASE-THUMB-NEXT:    vmov s0, r0
; BASE-THUMB-NEXT:    add sp, #4
; BASE-THUMB-NEXT:    bx lr
;
; FULLFP16-LABEL: bf_from_int_hard:
; FULLFP16:       @ %bb.0:
; FULLFP16-NEXT:    vmov.f16 s0, r0
; FULLFP16-NEXT:    bx lr
  %h = trunc i32 %w to i16
  %f = bitcast i16 %h to bfloat
  ret bfloat %f
}

define bfloat @test_fncall_soft(bfloat %bf, bfloat (bfloat, bfloat)* %f) {
; BASE-ARM-LABEL: test_fncall_soft:
; BASE-ARM:       @ %bb.0:
; BASE-ARM-NEXT:    .save {r4, r5, r11, lr}
; BASE-ARM-NEXT:    push {r4, r5, r11, lr}
; BASE-ARM-NEXT:    .pad #8
; BASE-ARM-NEXT:    sub sp, sp, #8
; BASE-ARM-NEXT:    uxth r5, r0
; BASE-ARM-NEXT:    mov r4, r1
; BASE-ARM-NEXT:    mov r0, r5
; BASE-ARM-NEXT:    mov r1, r5
; BASE-ARM-NEXT:    blx r4
; BASE-ARM-NEXT:    strh r0, [sp, #6]
; BASE-ARM-NEXT:    uxth r1, r0
; BASE-ARM-NEXT:    mov r0, r5
; BASE-ARM-NEXT:    blx r4
; BASE-ARM-NEXT:    ldrh r0, [sp, #6]
; BASE-ARM-NEXT:    add sp, sp, #8
; BASE-ARM-NEXT:    pop {r4, r5, r11, pc}
;
; BASE-THUMB-LABEL: test_fncall_soft:
; BASE-THUMB:       @ %bb.0:
; BASE-THUMB-NEXT:    .save {r4, r5, r7, lr}
; BASE-THUMB-NEXT:    push {r4, r5, r7, lr}
; BASE-THUMB-NEXT:    .pad #8
; BASE-THUMB-NEXT:    sub sp, #8
; BASE-THUMB-NEXT:    uxth r5, r0
; BASE-THUMB-NEXT:    mov r4, r1
; BASE-THUMB-NEXT:    mov r0, r5
; BASE-THUMB-NEXT:    mov r1, r5
; BASE-THUMB-NEXT:    blx r4
; BASE-THUMB-NEXT:    strh.w r0, [sp, #6]
; BASE-THUMB-NEXT:    uxth r1, r0
; BASE-THUMB-NEXT:    mov r0, r5
; BASE-THUMB-NEXT:    blx r4
; BASE-THUMB-NEXT:    ldrh.w r0, [sp, #6]
; BASE-THUMB-NEXT:    add sp, #8
; BASE-THUMB-NEXT:    pop {r4, r5, r7, pc}
;
; FULLFP16-ARM-LABEL: test_fncall_soft:
; FULLFP16-ARM:       @ %bb.0:
; FULLFP16-ARM-NEXT:    .save {r4, r5, r11, lr}
; FULLFP16-ARM-NEXT:    push {r4, r5, r11, lr}
; FULLFP16-ARM-NEXT:    .vsave {d8}
; FULLFP16-ARM-NEXT:    vpush {d8}
; FULLFP16-ARM-NEXT:    vmov.f16 s0, r0
; FULLFP16-ARM-NEXT:    mov r4, r1
; FULLFP16-ARM-NEXT:    vmov.f16 r5, s0
; FULLFP16-ARM-NEXT:    mov r0, r5
; FULLFP16-ARM-NEXT:    mov r1, r5
; FULLFP16-ARM-NEXT:    blx r4
; FULLFP16-ARM-NEXT:    vmov.f16 s16, r0
; FULLFP16-ARM-NEXT:    mov r0, r5
; FULLFP16-ARM-NEXT:    vmov.f16 r1, s16
; FULLFP16-ARM-NEXT:    blx r4
; FULLFP16-ARM-NEXT:    vmov r0, s16
; FULLFP16-ARM-NEXT:    vpop {d8}
; FULLFP16-ARM-NEXT:    pop {r4, r5, r11, pc}
;
; FULLFP16-THUMB-LABEL: test_fncall_soft:
; FULLFP16-THUMB:       @ %bb.0:
; FULLFP16-THUMB-NEXT:    .save {r4, r5, r7, lr}
; FULLFP16-THUMB-NEXT:    push {r4, r5, r7, lr}
; FULLFP16-THUMB-NEXT:    .vsave {d8}
; FULLFP16-THUMB-NEXT:    vpush {d8}
; FULLFP16-THUMB-NEXT:    vmov.f16 s0, r0
; FULLFP16-THUMB-NEXT:    mov r4, r1
; FULLFP16-THUMB-NEXT:    vmov.f16 r5, s0
; FULLFP16-THUMB-NEXT:    mov r0, r5
; FULLFP16-THUMB-NEXT:    mov r1, r5
; FULLFP16-THUMB-NEXT:    blx r4
; FULLFP16-THUMB-NEXT:    vmov.f16 s16, r0
; FULLFP16-THUMB-NEXT:    mov r0, r5
; FULLFP16-THUMB-NEXT:    vmov.f16 r1, s16
; FULLFP16-THUMB-NEXT:    blx r4
; FULLFP16-THUMB-NEXT:    vmov r0, s16
; FULLFP16-THUMB-NEXT:    vpop {d8}
; FULLFP16-THUMB-NEXT:    pop {r4, r5, r7, pc}
  %call = tail call bfloat %f(bfloat %bf, bfloat %bf)
  %call1 = tail call bfloat %f(bfloat %bf, bfloat %call)
  ret bfloat %call
}

define arm_aapcs_vfpcc bfloat @test_fncall_hard(bfloat %bf, bfloat (bfloat, bfloat)* %f) {
; BASE-ARM-LABEL: test_fncall_hard:
; BASE-ARM:       @ %bb.0:
; BASE-ARM-NEXT:    .save {r4, lr}
; BASE-ARM-NEXT:    push {r4, lr}
; BASE-ARM-NEXT:    .vsave {d8}
; BASE-ARM-NEXT:    vpush {d8}
; BASE-ARM-NEXT:    .pad #8
; BASE-ARM-NEXT:    sub sp, sp, #8
; BASE-ARM-NEXT:    mov r4, r0
; BASE-ARM-NEXT:    vmov r0, s0
; BASE-ARM-NEXT:    uxth r0, r0
; BASE-ARM-NEXT:    vmov s16, r0
; BASE-ARM-NEXT:    vmov.f32 s0, s16
; BASE-ARM-NEXT:    vmov.f32 s1, s16
; BASE-ARM-NEXT:    blx r4
; BASE-ARM-NEXT:    vmov r0, s0
; BASE-ARM-NEXT:    vmov.f32 s0, s16
; BASE-ARM-NEXT:    strh r0, [sp, #6]
; BASE-ARM-NEXT:    uxth r0, r0
; BASE-ARM-NEXT:    vmov s1, r0
; BASE-ARM-NEXT:    blx r4
; BASE-ARM-NEXT:    ldrh r0, [sp, #6]
; BASE-ARM-NEXT:    vmov s0, r0
; BASE-ARM-NEXT:    add sp, sp, #8
; BASE-ARM-NEXT:    vpop {d8}
; BASE-ARM-NEXT:    pop {r4, pc}
;
; BASE-THUMB-LABEL: test_fncall_hard:
; BASE-THUMB:       @ %bb.0:
; BASE-THUMB-NEXT:    .save {r4, lr}
; BASE-THUMB-NEXT:    push {r4, lr}
; BASE-THUMB-NEXT:    .vsave {d8}
; BASE-THUMB-NEXT:    vpush {d8}
; BASE-THUMB-NEXT:    .pad #8
; BASE-THUMB-NEXT:    sub sp, #8
; BASE-THUMB-NEXT:    mov r4, r0
; BASE-THUMB-NEXT:    vmov r0, s0
; BASE-THUMB-NEXT:    uxth r0, r0
; BASE-THUMB-NEXT:    vmov s16, r0
; BASE-THUMB-NEXT:    vmov.f32 s0, s16
; BASE-THUMB-NEXT:    vmov.f32 s1, s16
; BASE-THUMB-NEXT:    blx r4
; BASE-THUMB-NEXT:    vmov r0, s0
; BASE-THUMB-NEXT:    vmov.f32 s0, s16
; BASE-THUMB-NEXT:    strh.w r0, [sp, #6]
; BASE-THUMB-NEXT:    uxth r0, r0
; BASE-THUMB-NEXT:    vmov s1, r0
; BASE-THUMB-NEXT:    blx r4
; BASE-THUMB-NEXT:    ldrh.w r0, [sp, #6]
; BASE-THUMB-NEXT:    vmov s0, r0
; BASE-THUMB-NEXT:    add sp, #8
; BASE-THUMB-NEXT:    vpop {d8}
; BASE-THUMB-NEXT:    pop {r4, pc}
;
; FULLFP16-LABEL: test_fncall_hard:
; FULLFP16:       @ %bb.0:
; FULLFP16-NEXT:    .save {r4, lr}
; FULLFP16-NEXT:    push {r4, lr}
; FULLFP16-NEXT:    .vsave {d8, d9}
; FULLFP16-NEXT:    vpush {d8, d9}
; FULLFP16-NEXT:    mov r4, r0
; FULLFP16-NEXT:    vmov.f16 r0, s0
; FULLFP16-NEXT:    vmov s16, r0
; FULLFP16-NEXT:    vmov.f32 s0, s16
; FULLFP16-NEXT:    vmov.f32 s1, s16
; FULLFP16-NEXT:    blx r4
; FULLFP16-NEXT:    vmov.f16 r0, s0
; FULLFP16-NEXT:    vmov.f32 s18, s0
; FULLFP16-NEXT:    vmov.f32 s0, s16
; FULLFP16-NEXT:    vmov s1, r0
; FULLFP16-NEXT:    blx r4
; FULLFP16-NEXT:    vmov.f32 s0, s18
; FULLFP16-NEXT:    vpop {d8, d9}
; FULLFP16-NEXT:    pop {r4, pc}
  %call = tail call arm_aapcs_vfpcc bfloat %f(bfloat %bf, bfloat %bf)
  %call1 = tail call arm_aapcs_vfpcc bfloat %f(bfloat %bf, bfloat %call)
  ret bfloat %call
}
