; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 < %s | FileCheck --check-prefixes=CHECK,NOPIC %s
; RUN: llc -mtriple=riscv64 --relocation-model=pic < %s | FileCheck --check-prefixes=CHECK,PIC %s

define i8* @f2(i8* %x0, i8* %x1) {
; CHECK-LABEL: f2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; CHECK-NEXT:    .cfi_offset ra, -8
; CHECK-NEXT:    mv t0, a1
; CHECK-NEXT:    call __hwasan_check_x10_2_short
; CHECK-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  call void @llvm.hwasan.check.memaccess.shortgranules(i8* %x1, i8* %x0, i32 2)
  ret i8* %x0
}

declare void @llvm.hwasan.check.memaccess.shortgranules(i8*, i8*, i32)

; CHECK: .section        .text.hot,"axG",@progbits,__hwasan_check_x10_2_short,comdat
; CHECK-NEXT: .type   __hwasan_check_x10_2_short,@function
; CHECK-NEXT: .weak   __hwasan_check_x10_2_short
; CHECK-NEXT: .hidden __hwasan_check_x10_2_short
; CHECK-NEXT: __hwasan_check_x10_2_short:
; CHECK-NEXT: slli    t1, a0, 8
; CHECK-NEXT: srli    t1, t1, 12
; CHECK-NEXT: add     t1, t0, t1
; CHECK-NEXT: lbu     t1, 0(t1)
; CHECK-NEXT: srli    t2, a0, 56
; CHECK-NEXT: bne     t2, t1, .Ltmp0
; CHECK-NEXT: .Ltmp1:
; CHECK-NEXT: ret
; CHECK-NEXT: .Ltmp0:
; CHECK-NEXT: li      t3, 16
; CHECK-NEXT: bgeu    t1, t3, .Ltmp2
; CHECK-NEXT: andi    t3, a0, 15
; CHECK-NEXT: addi    t3, t3, 3
; CHECK-NEXT: bge     t3, t1, .Ltmp2
; CHECK-NEXT: ori     t1, a0, 15
; CHECK-NEXT: lbu     t1, 0(t1)
; CHECK-NEXT: beq     t1, t2, .Ltmp1
; CHECK-NEXT: .Ltmp2:
; CHECK-NEXT: addi    sp, sp, -256
; CHECK-NEXT: sd      a0, 80(sp)
; CHECK-NEXT: sd      a1, 88(sp)
; CHECK-NEXT: sd      s0, 64(sp)
; CHECK-NEXT: sd      ra, 8(sp)
; CHECK-NEXT: li      a1, 2
; CHECK-NEXT: .Lpcrel_hi0:
; NOPIC-NEXT: auipc   t1, %pcrel_hi(__hwasan_tag_mismatch_v2)
; NOPIC-NEXT: addi    t1, t1, %pcrel_lo(.Lpcrel_hi0)
; PIC-NEXT: auipc   t1, %got_pcrel_hi(__hwasan_tag_mismatch_v2)
; PIC-NEXT: ld      t1, %pcrel_lo(.Lpcrel_hi0)(t1)
; CHECK-NEXT: jr      t1
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; NOPIC: {{.*}}
; PIC: {{.*}}
