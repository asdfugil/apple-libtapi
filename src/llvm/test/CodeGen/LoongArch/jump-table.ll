; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 --min-jump-table-entries=5 < %s \
; RUN:   | FileCheck %s --check-prefix=LA32
; RUN: llc --mtriple=loongarch64 --min-jump-table-entries=5 < %s \
; RUN:   | FileCheck %s --check-prefix=LA64
; RUN: llc --mtriple=loongarch32 --min-jump-table-entries=4 < %s \
; RUN:   | FileCheck %s --check-prefix=LA32-JT
; RUN: llc --mtriple=loongarch64 --min-jump-table-entries=4 < %s \
; RUN:   | FileCheck %s --check-prefix=LA64-JT

;; The default mininum number of entries to use a jump table is 4.
;;
;; Note: The parameter `--min-jump-table-entries` will have no effect once we
;; have set the default value using `setMinimumJumpTableEntries`.

define void @switch_4_arms(i32 %in, ptr %out) nounwind {
; LA32-LABEL: switch_4_arms:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    ori $a2, $zero, 2
; LA32-NEXT:    blt $a2, $a0, .LBB0_4
; LA32-NEXT:  # %bb.1: # %entry
; LA32-NEXT:    ori $a3, $zero, 1
; LA32-NEXT:    beq $a0, $a3, .LBB0_8
; LA32-NEXT:  # %bb.2: # %entry
; LA32-NEXT:    bne $a0, $a2, .LBB0_10
; LA32-NEXT:  # %bb.3: # %bb2
; LA32-NEXT:    ori $a0, $zero, 3
; LA32-NEXT:    st.w $a0, $a1, 0
; LA32-NEXT:    ret
; LA32-NEXT:  .LBB0_4: # %entry
; LA32-NEXT:    ori $a3, $zero, 3
; LA32-NEXT:    beq $a0, $a3, .LBB0_9
; LA32-NEXT:  # %bb.5: # %entry
; LA32-NEXT:    ori $a2, $zero, 4
; LA32-NEXT:    bne $a0, $a2, .LBB0_10
; LA32-NEXT:  # %bb.6: # %bb4
; LA32-NEXT:    ori $a0, $zero, 1
; LA32-NEXT:    st.w $a0, $a1, 0
; LA32-NEXT:    ret
; LA32-NEXT:  .LBB0_8: # %bb1
; LA32-NEXT:    ori $a0, $zero, 4
; LA32-NEXT:    st.w $a0, $a1, 0
; LA32-NEXT:    ret
; LA32-NEXT:  .LBB0_9: # %bb3
; LA32-NEXT:    st.w $a2, $a1, 0
; LA32-NEXT:  .LBB0_10: # %exit
; LA32-NEXT:    ret
;
; LA64-LABEL: switch_4_arms:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    bstrpick.d $a0, $a0, 31, 0
; LA64-NEXT:    ori $a2, $zero, 2
; LA64-NEXT:    blt $a2, $a0, .LBB0_4
; LA64-NEXT:  # %bb.1: # %entry
; LA64-NEXT:    ori $a3, $zero, 1
; LA64-NEXT:    beq $a0, $a3, .LBB0_8
; LA64-NEXT:  # %bb.2: # %entry
; LA64-NEXT:    bne $a0, $a2, .LBB0_10
; LA64-NEXT:  # %bb.3: # %bb2
; LA64-NEXT:    ori $a0, $zero, 3
; LA64-NEXT:    st.w $a0, $a1, 0
; LA64-NEXT:    ret
; LA64-NEXT:  .LBB0_4: # %entry
; LA64-NEXT:    ori $a3, $zero, 3
; LA64-NEXT:    beq $a0, $a3, .LBB0_9
; LA64-NEXT:  # %bb.5: # %entry
; LA64-NEXT:    ori $a2, $zero, 4
; LA64-NEXT:    bne $a0, $a2, .LBB0_10
; LA64-NEXT:  # %bb.6: # %bb4
; LA64-NEXT:    ori $a0, $zero, 1
; LA64-NEXT:    st.w $a0, $a1, 0
; LA64-NEXT:    ret
; LA64-NEXT:  .LBB0_8: # %bb1
; LA64-NEXT:    ori $a0, $zero, 4
; LA64-NEXT:    st.w $a0, $a1, 0
; LA64-NEXT:    ret
; LA64-NEXT:  .LBB0_9: # %bb3
; LA64-NEXT:    st.w $a2, $a1, 0
; LA64-NEXT:  .LBB0_10: # %exit
; LA64-NEXT:    ret
;
; LA32-JT-LABEL: switch_4_arms:
; LA32-JT:       # %bb.0: # %entry
; LA32-JT-NEXT:    addi.w $a2, $a0, -1
; LA32-JT-NEXT:    ori $a0, $zero, 3
; LA32-JT-NEXT:    bltu $a0, $a2, .LBB0_6
; LA32-JT-NEXT:  # %bb.1: # %entry
; LA32-JT-NEXT:    pcalau12i $a3, %pc_hi20(.LJTI0_0)
; LA32-JT-NEXT:    addi.w $a3, $a3, %pc_lo12(.LJTI0_0)
; LA32-JT-NEXT:    alsl.w $a2, $a2, $a3, 2
; LA32-JT-NEXT:    ld.w $a2, $a2, 0
; LA32-JT-NEXT:    jr $a2
; LA32-JT-NEXT:  .LBB0_2: # %bb1
; LA32-JT-NEXT:    ori $a0, $zero, 4
; LA32-JT-NEXT:    b .LBB0_5
; LA32-JT-NEXT:  .LBB0_3: # %bb3
; LA32-JT-NEXT:    ori $a0, $zero, 2
; LA32-JT-NEXT:    b .LBB0_5
; LA32-JT-NEXT:  .LBB0_4: # %bb4
; LA32-JT-NEXT:    ori $a0, $zero, 1
; LA32-JT-NEXT:  .LBB0_5: # %exit
; LA32-JT-NEXT:    st.w $a0, $a1, 0
; LA32-JT-NEXT:  .LBB0_6: # %exit
; LA32-JT-NEXT:    ret
;
; LA64-JT-LABEL: switch_4_arms:
; LA64-JT:       # %bb.0: # %entry
; LA64-JT-NEXT:    bstrpick.d $a0, $a0, 31, 0
; LA64-JT-NEXT:    addi.d $a2, $a0, -1
; LA64-JT-NEXT:    ori $a0, $zero, 3
; LA64-JT-NEXT:    bltu $a0, $a2, .LBB0_6
; LA64-JT-NEXT:  # %bb.1: # %entry
; LA64-JT-NEXT:    slli.d $a2, $a2, 3
; LA64-JT-NEXT:    pcalau12i $a3, %pc_hi20(.LJTI0_0)
; LA64-JT-NEXT:    addi.d $a3, $a3, %pc_lo12(.LJTI0_0)
; LA64-JT-NEXT:    ldx.d $a2, $a2, $a3
; LA64-JT-NEXT:    jr $a2
; LA64-JT-NEXT:  .LBB0_2: # %bb1
; LA64-JT-NEXT:    ori $a0, $zero, 4
; LA64-JT-NEXT:    b .LBB0_5
; LA64-JT-NEXT:  .LBB0_3: # %bb3
; LA64-JT-NEXT:    ori $a0, $zero, 2
; LA64-JT-NEXT:    b .LBB0_5
; LA64-JT-NEXT:  .LBB0_4: # %bb4
; LA64-JT-NEXT:    ori $a0, $zero, 1
; LA64-JT-NEXT:  .LBB0_5: # %exit
; LA64-JT-NEXT:    st.w $a0, $a1, 0
; LA64-JT-NEXT:  .LBB0_6: # %exit
; LA64-JT-NEXT:    ret
entry:
  switch i32 %in, label %exit [
    i32 1, label %bb1
    i32 2, label %bb2
    i32 3, label %bb3
    i32 4, label %bb4
  ]
bb1:
  store i32 4, ptr %out
  br label %exit
bb2:
  store i32 3, ptr %out
  br label %exit
bb3:
  store i32 2, ptr %out
  br label %exit
bb4:
  store i32 1, ptr %out
  br label %exit
exit:
  ret void
}
