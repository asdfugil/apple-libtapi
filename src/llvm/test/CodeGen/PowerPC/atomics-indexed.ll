; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=powerpc-unknown-linux-gnu -verify-machineinstrs -ppc-asm-full-reg-names | FileCheck %s --check-prefix=CHECK --check-prefix=PPC32
; FIXME: -verify-machineinstrs currently fail on ppc64 (mismatched register/instruction).
; This is already checked for in Atomics-64.ll
; RUN: llc < %s -mtriple=powerpc64-unknown-linux-gnu -ppc-asm-full-reg-names | FileCheck %s --check-prefix=CHECK --check-prefix=PPC64

; In this file, we check that atomic load/store can make use of the indexed
; versions of the instructions.

; Indexed version of loads
define i8 @load_x_i8_seq_cst(ptr %mem) {
; PPC32-LABEL: load_x_i8_seq_cst:
; PPC32:       # %bb.0:
; PPC32-NEXT:    lis r4, 1
; PPC32-NEXT:    sync
; PPC32-NEXT:    ori r4, r4, 24464
; PPC32-NEXT:    lbzx r3, r3, r4
; PPC32-NEXT:    lwsync
; PPC32-NEXT:    blr
;
; PPC64-LABEL: load_x_i8_seq_cst:
; PPC64:       # %bb.0:
; PPC64-NEXT:    lis r4, 1
; PPC64-NEXT:    sync
; PPC64-NEXT:    ori r4, r4, 24464
; PPC64-NEXT:    lbzx r3, r3, r4
; PPC64-NEXT:    cmpd cr7, r3, r3
; PPC64-NEXT:    bne- cr7, .+4
; PPC64-NEXT:    isync
; PPC64-NEXT:    blr
  %ptr = getelementptr inbounds [100000 x i8], ptr %mem, i64 0, i64 90000
  %val = load atomic i8, ptr %ptr seq_cst, align 1
  ret i8 %val
}
define i16 @load_x_i16_acquire(ptr %mem) {
; PPC32-LABEL: load_x_i16_acquire:
; PPC32:       # %bb.0:
; PPC32-NEXT:    lis r4, 2
; PPC32-NEXT:    ori r4, r4, 48928
; PPC32-NEXT:    lhzx r3, r3, r4
; PPC32-NEXT:    lwsync
; PPC32-NEXT:    blr
;
; PPC64-LABEL: load_x_i16_acquire:
; PPC64:       # %bb.0:
; PPC64-NEXT:    lis r4, 2
; PPC64-NEXT:    ori r4, r4, 48928
; PPC64-NEXT:    lhzx r3, r3, r4
; PPC64-NEXT:    cmpd cr7, r3, r3
; PPC64-NEXT:    bne- cr7, .+4
; PPC64-NEXT:    isync
; PPC64-NEXT:    blr
  %ptr = getelementptr inbounds [100000 x i16], ptr %mem, i64 0, i64 90000
  %val = load atomic i16, ptr %ptr acquire, align 2
  ret i16 %val
}
define i32 @load_x_i32_monotonic(ptr %mem) {
; CHECK-LABEL: load_x_i32_monotonic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lis r4, 5
; CHECK-NEXT:    ori r4, r4, 32320
; CHECK-NEXT:    lwzx r3, r3, r4
; CHECK-NEXT:    blr
  %ptr = getelementptr inbounds [100000 x i32], ptr %mem, i64 0, i64 90000
  %val = load atomic i32, ptr %ptr monotonic, align 4
  ret i32 %val
}
define i64 @load_x_i64_unordered(ptr %mem) {
; PPC32-LABEL: load_x_i64_unordered:
; PPC32:       # %bb.0:
; PPC32-NEXT:    mflr r0
; PPC32-NEXT:    stw r0, 4(r1)
; PPC32-NEXT:    stwu r1, -16(r1)
; PPC32-NEXT:    .cfi_def_cfa_offset 16
; PPC32-NEXT:    .cfi_offset lr, 4
; PPC32-NEXT:    addi r3, r3, -896
; PPC32-NEXT:    addis r3, r3, 11
; PPC32-NEXT:    li r4, 0
; PPC32-NEXT:    bl __atomic_load_8
; PPC32-NEXT:    lwz r0, 20(r1)
; PPC32-NEXT:    addi r1, r1, 16
; PPC32-NEXT:    mtlr r0
; PPC32-NEXT:    blr
;
; PPC64-LABEL: load_x_i64_unordered:
; PPC64:       # %bb.0:
; PPC64-NEXT:    lis r4, 10
; PPC64-NEXT:    ori r4, r4, 64640
; PPC64-NEXT:    ldx r3, r3, r4
; PPC64-NEXT:    blr
  %ptr = getelementptr inbounds [100000 x i64], ptr %mem, i64 0, i64 90000
  %val = load atomic i64, ptr %ptr unordered, align 8
  ret i64 %val
}

; Indexed version of stores
define void @store_x_i8_seq_cst(ptr %mem) {
; CHECK-LABEL: store_x_i8_seq_cst:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lis r4, 1
; CHECK-NEXT:    ori r4, r4, 24464
; CHECK-NEXT:    li r5, 42
; CHECK-NEXT:    sync
; CHECK-NEXT:    stbx r5, r3, r4
; CHECK-NEXT:    blr
  %ptr = getelementptr inbounds [100000 x i8], ptr %mem, i64 0, i64 90000
  store atomic i8 42, ptr %ptr seq_cst, align 1
  ret void
}
define void @store_x_i16_release(ptr %mem) {
; CHECK-LABEL: store_x_i16_release:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lis r4, 2
; CHECK-NEXT:    ori r4, r4, 48928
; CHECK-NEXT:    li r5, 42
; CHECK-NEXT:    lwsync
; CHECK-NEXT:    sthx r5, r3, r4
; CHECK-NEXT:    blr
  %ptr = getelementptr inbounds [100000 x i16], ptr %mem, i64 0, i64 90000
  store atomic i16 42, ptr %ptr release, align 2
  ret void
}
define void @store_x_i32_monotonic(ptr %mem) {
; CHECK-LABEL: store_x_i32_monotonic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lis r4, 5
; CHECK-NEXT:    ori r4, r4, 32320
; CHECK-NEXT:    li r5, 42
; CHECK-NEXT:    stwx r5, r3, r4
; CHECK-NEXT:    blr
  %ptr = getelementptr inbounds [100000 x i32], ptr %mem, i64 0, i64 90000
  store atomic i32 42, ptr %ptr monotonic, align 4
  ret void
}
define void @store_x_i64_unordered(ptr %mem) {
; PPC32-LABEL: store_x_i64_unordered:
; PPC32:       # %bb.0:
; PPC32-NEXT:    mflr r0
; PPC32-NEXT:    stw r0, 4(r1)
; PPC32-NEXT:    stwu r1, -16(r1)
; PPC32-NEXT:    .cfi_def_cfa_offset 16
; PPC32-NEXT:    .cfi_offset lr, 4
; PPC32-NEXT:    addi r3, r3, -896
; PPC32-NEXT:    addis r3, r3, 11
; PPC32-NEXT:    li r5, 0
; PPC32-NEXT:    li r6, 42
; PPC32-NEXT:    li r7, 0
; PPC32-NEXT:    bl __atomic_store_8
; PPC32-NEXT:    lwz r0, 20(r1)
; PPC32-NEXT:    addi r1, r1, 16
; PPC32-NEXT:    mtlr r0
; PPC32-NEXT:    blr
;
; PPC64-LABEL: store_x_i64_unordered:
; PPC64:       # %bb.0:
; PPC64-NEXT:    lis r4, 10
; PPC64-NEXT:    ori r4, r4, 64640
; PPC64-NEXT:    li r5, 42
; PPC64-NEXT:    stdx r5, r3, r4
; PPC64-NEXT:    blr
  %ptr = getelementptr inbounds [100000 x i64], ptr %mem, i64 0, i64 90000
  store atomic i64 42, ptr %ptr unordered, align 8
  ret void
}
