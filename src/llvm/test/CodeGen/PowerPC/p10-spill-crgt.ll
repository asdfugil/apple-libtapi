; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:     -mcpu=pwr10 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s | \
; RUN:     FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:     -mcpu=pwr10 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s | \
; RUN:     FileCheck %s --check-prefix=CHECK-BE

; This test case tests spilling the CR GT bit on Power10. On Power10, this is
; achieved by setb %reg, %CRREG (gt bit) -> stw %reg, $FI instead of:
; mfocrf %reg, %CRREG -> rlwinm %reg1, %reg, $SH, 0, 0 -> stw %reg1, $FI.

; Without fine-grained control over clobbering individual CR bits,
; it is difficult to produce a concise test case that will ensure a specific
; bit of any CR field is spilled. We need to test the spilling of a CR bit
; other than the LT bit. Hence this test case is rather complex.

define dso_local fastcc void @P10_Spill_CR_GT() unnamed_addr {
; CHECK-LABEL: P10_Spill_CR_GT:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    mfcr r12
; CHECK-NEXT:    mflr r0
; CHECK-NEXT:    std r0, 16(r1)
; CHECK-NEXT:    stw r12, 8(r1)
; CHECK-NEXT:    stdu r1, -64(r1)
; CHECK-NEXT:    .cfi_def_cfa_offset 64
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    .cfi_offset r29, -24
; CHECK-NEXT:    .cfi_offset r30, -16
; CHECK-NEXT:    .cfi_offset cr2, 8
; CHECK-NEXT:    .cfi_offset cr3, 8
; CHECK-NEXT:    .cfi_offset cr4, 8
; CHECK-NEXT:    lwz r3, 0(r3)
; CHECK-NEXT:    std r29, 40(r1) # 8-byte Folded Spill
; CHECK-NEXT:    std r30, 48(r1) # 8-byte Folded Spill
; CHECK-NEXT:    paddi r29, 0, .LJTI0_0@PCREL, 1
; CHECK-NEXT:    srwi r4, r3, 4
; CHECK-NEXT:    srwi r3, r3, 5
; CHECK-NEXT:    andi. r4, r4, 1
; CHECK-NEXT:    li r4, 0
; CHECK-NEXT:    crmove 4*cr2+gt, gt
; CHECK-NEXT:    andi. r3, r3, 1
; CHECK-NEXT:    crmove 4*cr2+lt, gt
; CHECK-NEXT:    cmplwi cr3, r3, 336
; CHECK-NEXT:    li r3, 0
; CHECK-NEXT:    sldi r30, r3, 2
; CHECK-NEXT:    b .LBB0_2
; CHECK-NEXT:  .LBB0_1: # %bb43
; CHECK-NEXT:    #
; CHECK-NEXT:    bl call_1@notoc
; CHECK-NEXT:    setnbc r3, 4*cr4+eq
; CHECK-NEXT:    li r4, 0
; CHECK-NEXT:    stb r4, 0(r3)
; CHECK-NEXT:    li r4, 0
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_2: # %bb5
; CHECK-NEXT:    #
; CHECK-NEXT:    bc 12, 4*cr2+gt, .LBB0_31
; CHECK-NEXT:  # %bb.3: # %bb10
; CHECK-NEXT:    #
; CHECK-NEXT:    bgt cr3, .LBB0_5
; CHECK-NEXT:  # %bb.4: # %bb10
; CHECK-NEXT:    #
; CHECK-NEXT:    mr r3, r4
; CHECK-NEXT:    lwz r5, 0(r3)
; CHECK-NEXT:    rlwinm r4, r5, 0, 21, 22
; CHECK-NEXT:    cmpwi cr4, r4, 512
; CHECK-NEXT:    lwax r4, r30, r29
; CHECK-NEXT:    add r4, r4, r29
; CHECK-NEXT:    mtctr r4
; CHECK-NEXT:    li r4, 0
; CHECK-NEXT:    bctr
; CHECK-NEXT:  .LBB0_5: # %bb13
; CHECK-NEXT:    #
; CHECK-NEXT:    li r4, 16
; CHECK-NEXT:    b .LBB0_2
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_6: # %bb22
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_6
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_7: # %bb28
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_7
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_8: # %bb52
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_8
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_9: # %bb17
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_9
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_10: # %bb26
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_10
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_11: # %bb42
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_11
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_12: # %bb54
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_12
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_13: # %bb61
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_13
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_14: # %bb47
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_14
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_15: # %bb24
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_15
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_16: # %bb19
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_16
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_17: # %bb59
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_17
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_18: # %bb46
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_18
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_19: # %bb49
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_19
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_20: # %bb57
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_20
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_21: # %bb18
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_21
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_22: # %bb58
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_22
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_23: # %bb23
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_23
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_24: # %bb60
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_24
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_25: # %bb55
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_25
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_26: # %bb62
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_26
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_27: # %bb56
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_27
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_28: # %bb20
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_28
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_29: # %bb50
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_29
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_30: # %bb48
; CHECK-NEXT:    #
; CHECK-NEXT:    b .LBB0_30
; CHECK-NEXT:  .LBB0_31: # %bb9
; CHECK-NEXT:    ld r30, 48(r1) # 8-byte Folded Reload
; CHECK-NEXT:    ld r29, 40(r1) # 8-byte Folded Reload
; CHECK-NEXT:    addi r1, r1, 64
; CHECK-NEXT:    ld r0, 16(r1)
; CHECK-NEXT:    lwz r12, 8(r1)
; CHECK-NEXT:    mtlr r0
; CHECK-NEXT:    mtocrf 32, r12
; CHECK-NEXT:    mtocrf 16, r12
; CHECK-NEXT:    mtocrf 8, r12
; CHECK-NEXT:    blr
; CHECK-NEXT:  .LBB0_32: # %bb29
; CHECK-NEXT:    mcrf cr0, cr4
; CHECK-NEXT:    cmpwi cr3, r5, 366
; CHECK-NEXT:    cmpwi cr4, r3, 0
; CHECK-NEXT:    li r29, 0
; CHECK-NEXT:    setnbc r30, eq
; CHECK-NEXT:    bc 12, 4*cr2+lt, .LBB0_36
; CHECK-NEXT:    .p2align 5
; CHECK-NEXT:  .LBB0_33: # %bb36
; CHECK-NEXT:    bc 12, 4*cr4+eq, .LBB0_35
; CHECK-NEXT:  .LBB0_34: # %bb32
; CHECK-NEXT:    bc 4, 4*cr2+lt, .LBB0_33
; CHECK-NEXT:    b .LBB0_36
; CHECK-NEXT:    .p2align 5
; CHECK-NEXT:  .LBB0_35: # %bb39
; CHECK-NEXT:    bl call_2@notoc
; CHECK-NEXT:    bc 4, 4*cr2+lt, .LBB0_33
; CHECK-NEXT:  .LBB0_36: # %bb33
; CHECK-NEXT:    stb r29, 0(r30)
; CHECK-NEXT:    bc 4, 4*cr4+eq, .LBB0_34
; CHECK-NEXT:    b .LBB0_35
;
; CHECK-BE-LABEL: P10_Spill_CR_GT:
; CHECK-BE:       # %bb.0: # %bb
; CHECK-BE-NEXT:    mfcr r12
; CHECK-BE-NEXT:    mflr r0
; CHECK-BE-NEXT:    std r0, 16(r1)
; CHECK-BE-NEXT:    stw r12, 8(r1)
; CHECK-BE-NEXT:    stdu r1, -144(r1)
; CHECK-BE-NEXT:    .cfi_def_cfa_offset 144
; CHECK-BE-NEXT:    .cfi_offset lr, 16
; CHECK-BE-NEXT:    .cfi_offset r29, -24
; CHECK-BE-NEXT:    .cfi_offset r30, -16
; CHECK-BE-NEXT:    .cfi_offset cr2, 8
; CHECK-BE-NEXT:    .cfi_offset cr2, 8
; CHECK-BE-NEXT:    .cfi_offset cr2, 8
; CHECK-BE-NEXT:    lwz r3, 0(r3)
; CHECK-BE-NEXT:    std r29, 120(r1) # 8-byte Folded Spill
; CHECK-BE-NEXT:    std r30, 128(r1) # 8-byte Folded Spill
; CHECK-BE-NEXT:    srwi r4, r3, 4
; CHECK-BE-NEXT:    srwi r3, r3, 5
; CHECK-BE-NEXT:    andi. r4, r4, 1
; CHECK-BE-NEXT:    li r4, 0
; CHECK-BE-NEXT:    crmove 4*cr2+gt, gt
; CHECK-BE-NEXT:    andi. r3, r3, 1
; CHECK-BE-NEXT:    crmove 4*cr2+lt, gt
; CHECK-BE-NEXT:    cmplwi cr3, r3, 336
; CHECK-BE-NEXT:    li r3, 0
; CHECK-BE-NEXT:    sldi r30, r3, 2
; CHECK-BE-NEXT:    addis r3, r2, .LC0@toc@ha
; CHECK-BE-NEXT:    ld r29, .LC0@toc@l(r3)
; CHECK-BE-NEXT:    b .LBB0_2
; CHECK-BE-NEXT:  .LBB0_1: # %bb43
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    bl call_1
; CHECK-BE-NEXT:    nop
; CHECK-BE-NEXT:    setnbc r3, 4*cr4+eq
; CHECK-BE-NEXT:    li r4, 0
; CHECK-BE-NEXT:    stb r4, 0(r3)
; CHECK-BE-NEXT:    li r4, 0
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_2: # %bb5
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    bc 12, 4*cr2+gt, .LBB0_31
; CHECK-BE-NEXT:  # %bb.3: # %bb10
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    bgt cr3, .LBB0_5
; CHECK-BE-NEXT:  # %bb.4: # %bb10
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    mr r3, r4
; CHECK-BE-NEXT:    lwz r5, 0(r3)
; CHECK-BE-NEXT:    rlwinm r4, r5, 0, 21, 22
; CHECK-BE-NEXT:    cmpwi cr4, r4, 512
; CHECK-BE-NEXT:    lwax r4, r30, r29
; CHECK-BE-NEXT:    add r4, r4, r29
; CHECK-BE-NEXT:    mtctr r4
; CHECK-BE-NEXT:    li r4, 0
; CHECK-BE-NEXT:    bctr
; CHECK-BE-NEXT:  .LBB0_5: # %bb13
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    li r4, 16
; CHECK-BE-NEXT:    b .LBB0_2
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_6: # %bb22
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_6
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_7: # %bb28
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_7
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_8: # %bb52
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_8
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_9: # %bb17
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_9
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_10: # %bb26
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_10
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_11: # %bb42
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_11
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_12: # %bb54
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_12
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_13: # %bb61
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_13
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_14: # %bb47
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_14
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_15: # %bb24
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_15
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_16: # %bb19
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_16
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_17: # %bb59
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_17
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_18: # %bb46
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_18
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_19: # %bb49
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_19
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_20: # %bb57
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_20
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_21: # %bb18
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_21
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_22: # %bb58
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_22
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_23: # %bb23
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_23
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_24: # %bb60
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_24
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_25: # %bb55
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_25
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_26: # %bb62
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_26
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_27: # %bb56
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_27
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_28: # %bb20
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_28
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_29: # %bb50
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_29
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_30: # %bb48
; CHECK-BE-NEXT:    #
; CHECK-BE-NEXT:    b .LBB0_30
; CHECK-BE-NEXT:  .LBB0_31: # %bb9
; CHECK-BE-NEXT:    ld r30, 128(r1) # 8-byte Folded Reload
; CHECK-BE-NEXT:    ld r29, 120(r1) # 8-byte Folded Reload
; CHECK-BE-NEXT:    addi r1, r1, 144
; CHECK-BE-NEXT:    ld r0, 16(r1)
; CHECK-BE-NEXT:    lwz r12, 8(r1)
; CHECK-BE-NEXT:    mtlr r0
; CHECK-BE-NEXT:    mtocrf 32, r12
; CHECK-BE-NEXT:    mtocrf 16, r12
; CHECK-BE-NEXT:    mtocrf 8, r12
; CHECK-BE-NEXT:    blr
; CHECK-BE-NEXT:  .LBB0_32: # %bb29
; CHECK-BE-NEXT:    mcrf cr0, cr4
; CHECK-BE-NEXT:    cmpwi cr3, r5, 366
; CHECK-BE-NEXT:    cmpwi cr4, r3, 0
; CHECK-BE-NEXT:    li r29, 0
; CHECK-BE-NEXT:    setnbc r30, eq
; CHECK-BE-NEXT:    bc 12, 4*cr2+lt, .LBB0_36
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_33: # %bb36
; CHECK-BE-NEXT:    bc 12, 4*cr4+eq, .LBB0_35
; CHECK-BE-NEXT:  .LBB0_34: # %bb32
; CHECK-BE-NEXT:    bc 4, 4*cr2+lt, .LBB0_33
; CHECK-BE-NEXT:    b .LBB0_36
; CHECK-BE-NEXT:    .p2align 4
; CHECK-BE-NEXT:  .LBB0_35: # %bb39
; CHECK-BE-NEXT:    bl call_2
; CHECK-BE-NEXT:    nop
; CHECK-BE-NEXT:    bc 4, 4*cr2+lt, .LBB0_33
; CHECK-BE-NEXT:  .LBB0_36: # %bb33
; CHECK-BE-NEXT:    stb r29, 0(r30)
; CHECK-BE-NEXT:    bc 4, 4*cr4+eq, .LBB0_34
; CHECK-BE-NEXT:    b .LBB0_35
bb:
  %tmp = load i32, ptr undef, align 8
  %tmp1 = and i32 %tmp, 16
  %tmp2 = icmp ne i32 %tmp1, 0
  %tmp3 = and i32 %tmp, 32
  %tmp4 = icmp ne i32 %tmp3, 0
  br label %bb5

bb5:                                              ; preds = %bb63, %bb
  %tmp6 = phi i32 [ 0, %bb ], [ %tmp64, %bb63 ]
  %tmp7 = phi i1 [ %tmp4, %bb ], [ undef, %bb63 ]
  %tmp8 = load i32, ptr undef, align 8
  br i1 %tmp2, label %bb9, label %bb10

bb9:                                              ; preds = %bb5
  ret void

bb10:                                             ; preds = %bb5
  %tmp11 = and i32 %tmp8, 1536
  %tmp12 = icmp eq i32 %tmp11, 512
  switch i32 undef, label %bb13 [
    i32 117, label %bb62
    i32 40, label %bb63
    i32 302, label %bb63
    i32 46, label %bb63
    i32 320, label %bb16
    i32 64, label %bb16
    i32 344, label %bb18
    i32 88, label %bb19
    i32 376, label %bb63
    i32 120, label %bb20
    i32 47, label %bb21
    i32 65, label %bb21
    i32 90, label %bb21
    i32 97, label %bb21
    i32 66, label %bb63
    i32 98, label %bb63
    i32 72, label %bb63
    i32 104, label %bb63
    i32 67, label %bb63
    i32 99, label %bb23
    i32 87, label %bb24
    i32 85, label %bb63
    i32 371, label %bb25
    i32 115, label %bb25
    i32 339, label %bb27
    i32 118, label %bb27
    i32 110, label %bb27
    i32 83, label %bb27
    i32 374, label %bb29
    i32 366, label %bb29
    i32 105, label %bb41
    i32 361, label %bb41
    i32 73, label %bb43
    i32 329, label %bb43
    i32 106, label %bb46
    i32 74, label %bb47
    i32 364, label %bb48
    i32 108, label %bb49
    i32 332, label %bb50
    i32 86, label %bb51
    i32 78, label %bb51
    i32 76, label %bb51
    i32 342, label %bb53
    i32 334, label %bb53
    i32 112, label %bb55
    i32 119, label %bb56
    i32 80, label %bb63
    i32 113, label %bb57
    i32 81, label %bb58
    i32 102, label %bb59
    i32 100, label %bb60
    i32 70, label %bb61
  ]

bb13:                                             ; preds = %bb10
  %tmp14 = icmp eq i32 0, 0
  %tmp15 = select i1 %tmp14, i32 16, i32 undef
  br label %bb63

bb16:                                             ; preds = %bb10, %bb10
  br label %bb17

bb17:                                             ; preds = %bb17, %bb16
  br label %bb17

bb18:                                             ; preds = %bb18, %bb10
  br label %bb18

bb19:                                             ; preds = %bb19, %bb10
  br label %bb19

bb20:                                             ; preds = %bb20, %bb10
  br label %bb20

bb21:                                             ; preds = %bb10, %bb10, %bb10, %bb10
  br label %bb22

bb22:                                             ; preds = %bb22, %bb21
  br label %bb22

bb23:                                             ; preds = %bb23, %bb10
  br label %bb23

bb24:                                             ; preds = %bb24, %bb10
  br label %bb24

bb25:                                             ; preds = %bb10, %bb10
  br label %bb26

bb26:                                             ; preds = %bb26, %bb25
  br label %bb26

bb27:                                             ; preds = %bb10, %bb10, %bb10, %bb10
  br label %bb28

bb28:                                             ; preds = %bb28, %bb27
  br label %bb28

bb29:                                             ; preds = %bb10, %bb10
  %tmp30 = icmp eq i32 %tmp8, 366
  %tmp31 = icmp eq i32 %tmp6, 0
  br label %bb32

bb32:                                             ; preds = %bb40, %bb29
  br i1 %tmp7, label %bb33, label %bb36

bb33:                                             ; preds = %bb32
  %tmp34 = getelementptr inbounds i8, ptr null, i64 -1
  %tmp35 = select i1 %tmp12, ptr %tmp34, ptr null
  store i8 0, ptr %tmp35, align 1
  br label %bb36

bb36:                                             ; preds = %bb33, %bb32
  br i1 %tmp30, label %bb37, label %bb38

bb37:                                             ; preds = %bb36
  store i16 undef, ptr null, align 2
  br label %bb38

bb38:                                             ; preds = %bb37, %bb36
  br i1 %tmp31, label %bb39, label %bb40

bb39:                                             ; preds = %bb38
  call void @call_2()
  br label %bb40

bb40:                                             ; preds = %bb39, %bb38
  br label %bb32

bb41:                                             ; preds = %bb10, %bb10
  br label %bb42

bb42:                                             ; preds = %bb42, %bb41
  br label %bb42

bb43:                                             ; preds = %bb10, %bb10
  call void @call_1()
  %tmp44 = getelementptr inbounds i8, ptr null, i64 -1
  %tmp45 = select i1 %tmp12, ptr %tmp44, ptr null
  store i8 0, ptr %tmp45, align 1
  br label %bb63

bb46:                                             ; preds = %bb46, %bb10
  br label %bb46

bb47:                                             ; preds = %bb47, %bb10
  br label %bb47

bb48:                                             ; preds = %bb48, %bb10
  br label %bb48

bb49:                                             ; preds = %bb49, %bb10
  br label %bb49

bb50:                                             ; preds = %bb50, %bb10
  br label %bb50

bb51:                                             ; preds = %bb10, %bb10, %bb10
  br label %bb52

bb52:                                             ; preds = %bb52, %bb51
  br label %bb52

bb53:                                             ; preds = %bb10, %bb10
  br label %bb54

bb54:                                             ; preds = %bb54, %bb53
  br label %bb54

bb55:                                             ; preds = %bb55, %bb10
  br label %bb55

bb56:                                             ; preds = %bb56, %bb10
  br label %bb56

bb57:                                             ; preds = %bb57, %bb10
  br label %bb57

bb58:                                             ; preds = %bb58, %bb10
  br label %bb58

bb59:                                             ; preds = %bb59, %bb10
  br label %bb59

bb60:                                             ; preds = %bb60, %bb10
  br label %bb60

bb61:                                             ; preds = %bb61, %bb10
  br label %bb61

bb62:                                             ; preds = %bb62, %bb10
  br label %bb62

bb63:                                             ; preds = %bb43, %bb13, %bb10, %bb10, %bb10, %bb10, %bb10, %bb10, %bb10, %bb10, %bb10, %bb10, %bb10
  %tmp64 = phi i32 [ %tmp15, %bb13 ], [ 0, %bb43 ], [ 0, %bb10 ], [ 0, %bb10 ], [ 0, %bb10 ], [ 0, %bb10 ], [ 0, %bb10 ], [ 0, %bb10 ], [ 0, %bb10 ], [ 0, %bb10 ], [ 0, %bb10 ], [ 0, %bb10 ], [ 0, %bb10 ]
  br label %bb5
}

declare void @call_1() local_unnamed_addr

declare void @call_2() local_unnamed_addr
