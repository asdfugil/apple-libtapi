; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mcpu=generic -mtriple=i686-linux -verify-machineinstrs | FileCheck %s -check-prefix=X86
; RUN: llc < %s -mcpu=generic -mtriple=x86_64-linux -verify-machineinstrs | FileCheck %s -check-prefix=X64
; RUN: llc < %s -mcpu=generic -mtriple=x86_64-linux-gnux32 -verify-machineinstrs | FileCheck %s -check-prefix=X32ABI
; RUN: llc < %s -mcpu=generic -mtriple=i686-linux -filetype=obj
; RUN: llc < %s -mcpu=generic -mtriple=x86_64-linux -filetype=obj
; RUN: llc < %s -mcpu=generic -mtriple=x86_64-linux-gnux32 -filetype=obj

; Just to prevent the alloca from being optimized away
declare void @dummy_use(ptr, i32)

define i32 @test_basic(i32 %l) #0 {
; X86-LABEL: test_basic:
; X86:       # %bb.0:
; X86-NEXT:    cmpl %gs:48, %esp
; X86-NEXT:    jbe .LBB0_1
; X86-NEXT:  .LBB0_2:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    .cfi_offset %ebp, -8
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    .cfi_def_cfa_register %ebp
; X86-NEXT:    pushl %esi
; X86-NEXT:    pushl %eax
; X86-NEXT:    .cfi_offset %esi, -12
; X86-NEXT:    movl 8(%ebp), %esi
; X86-NEXT:    leal 15(,%esi,4), %ecx
; X86-NEXT:    andl $-16, %ecx
; X86-NEXT:    movl %esp, %eax
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    cmpl %eax, %gs:48
; X86-NEXT:    jg .LBB0_4
; X86-NEXT:  # %bb.3:
; X86-NEXT:    movl %eax, %esp
; X86-NEXT:    jmp .LBB0_5
; X86-NEXT:  .LBB0_4:
; X86-NEXT:    subl $12, %esp
; X86-NEXT:    pushl %ecx
; X86-NEXT:    calll __morestack_allocate_stack_space
; X86-NEXT:    addl $16, %esp
; X86-NEXT:  .LBB0_5:
; X86-NEXT:    subl $8, %esp
; X86-NEXT:    pushl %esi
; X86-NEXT:    pushl %eax
; X86-NEXT:    calll dummy_use@PLT
; X86-NEXT:    addl $16, %esp
; X86-NEXT:    testl %esi, %esi
; X86-NEXT:    je .LBB0_6
; X86-NEXT:  # %bb.8: # %false
; X86-NEXT:    decl %esi
; X86-NEXT:    subl $12, %esp
; X86-NEXT:    pushl %esi
; X86-NEXT:    calll test_basic@PLT
; X86-NEXT:    jmp .LBB0_7
; X86-NEXT:  .LBB0_6: # %true
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:  .LBB0_7: # %true
; X86-NEXT:    leal -4(%ebp), %esp
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %ebp
; X86-NEXT:    .cfi_def_cfa %esp, 4
; X86-NEXT:    retl
; X86-NEXT:  .LBB0_1:
; X86-NEXT:    .cfi_restore %ebp
; X86-NEXT:    .cfi_restore %esi
; X86-NEXT:    pushl $4
; X86-NEXT:    pushl $12
; X86-NEXT:    calll __morestack
; X86-NEXT:    retl
; X86-NEXT:    jmp .LBB0_2
;
; X64-LABEL: test_basic:
; X64:       # %bb.0:
; X64-NEXT:    cmpq %fs:112, %rsp
; X64-NEXT:    jbe .LBB0_1
; X64-NEXT:  .LBB0_2:
; X64-NEXT:    pushq %rbp
; X64-NEXT:    .cfi_def_cfa_offset 16
; X64-NEXT:    .cfi_offset %rbp, -16
; X64-NEXT:    movq %rsp, %rbp
; X64-NEXT:    .cfi_def_cfa_register %rbp
; X64-NEXT:    pushq %rbx
; X64-NEXT:    pushq %rax
; X64-NEXT:    .cfi_offset %rbx, -24
; X64-NEXT:    movl %edi, %ebx
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    leaq 15(,%rax,4), %rax
; X64-NEXT:    andq $-16, %rax
; X64-NEXT:    movq %rsp, %rdi
; X64-NEXT:    subq %rax, %rdi
; X64-NEXT:    cmpq %rdi, %fs:112
; X64-NEXT:    jg .LBB0_4
; X64-NEXT:  # %bb.3:
; X64-NEXT:    movq %rdi, %rsp
; X64-NEXT:    jmp .LBB0_5
; X64-NEXT:  .LBB0_4:
; X64-NEXT:    movq %rax, %rdi
; X64-NEXT:    callq __morestack_allocate_stack_space
; X64-NEXT:    movq %rax, %rdi
; X64-NEXT:  .LBB0_5:
; X64-NEXT:    movl %ebx, %esi
; X64-NEXT:    callq dummy_use@PLT
; X64-NEXT:    testl %ebx, %ebx
; X64-NEXT:    je .LBB0_6
; X64-NEXT:  # %bb.8: # %false
; X64-NEXT:    decl %ebx
; X64-NEXT:    movl %ebx, %edi
; X64-NEXT:    callq test_basic@PLT
; X64-NEXT:    jmp .LBB0_7
; X64-NEXT:  .LBB0_6: # %true
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:  .LBB0_7: # %true
; X64-NEXT:    leaq -8(%rbp), %rsp
; X64-NEXT:    popq %rbx
; X64-NEXT:    popq %rbp
; X64-NEXT:    .cfi_def_cfa %rsp, 8
; X64-NEXT:    retq
; X64-NEXT:  .LBB0_1:
; X64-NEXT:    .cfi_restore %rbx
; X64-NEXT:    .cfi_restore %rbp
; X64-NEXT:    movl $24, %r10d
; X64-NEXT:    movl $0, %r11d
; X64-NEXT:    callq __morestack
; X64-NEXT:    retq
; X64-NEXT:    jmp .LBB0_2
;
; X32ABI-LABEL: test_basic:
; X32ABI:       # %bb.0:
; X32ABI-NEXT:    cmpl %fs:64, %esp
; X32ABI-NEXT:    jbe .LBB0_1
; X32ABI-NEXT:  .LBB0_2:
; X32ABI-NEXT:    pushq %rbp
; X32ABI-NEXT:    .cfi_def_cfa_offset 16
; X32ABI-NEXT:    .cfi_offset %rbp, -16
; X32ABI-NEXT:    movl %esp, %ebp
; X32ABI-NEXT:    .cfi_def_cfa_register %rbp
; X32ABI-NEXT:    pushq %rbx
; X32ABI-NEXT:    pushq %rax
; X32ABI-NEXT:    .cfi_offset %rbx, -24
; X32ABI-NEXT:    movl %edi, %ebx
; X32ABI-NEXT:    leal 15(,%rbx,4), %eax
; X32ABI-NEXT:    andl $-16, %eax
; X32ABI-NEXT:    movl %esp, %edi
; X32ABI-NEXT:    subl %eax, %edi
; X32ABI-NEXT:    cmpl %edi, %fs:64
; X32ABI-NEXT:    jg .LBB0_4
; X32ABI-NEXT:  # %bb.3:
; X32ABI-NEXT:    movl %edi, %esp
; X32ABI-NEXT:    jmp .LBB0_5
; X32ABI-NEXT:  .LBB0_4:
; X32ABI-NEXT:    movl %eax, %edi
; X32ABI-NEXT:    callq __morestack_allocate_stack_space
; X32ABI-NEXT:    movl %eax, %edi
; X32ABI-NEXT:  .LBB0_5:
; X32ABI-NEXT:    movl %ebx, %esi
; X32ABI-NEXT:    callq dummy_use@PLT
; X32ABI-NEXT:    testl %ebx, %ebx
; X32ABI-NEXT:    je .LBB0_6
; X32ABI-NEXT:  # %bb.8: # %false
; X32ABI-NEXT:    decl %ebx
; X32ABI-NEXT:    movl %ebx, %edi
; X32ABI-NEXT:    callq test_basic@PLT
; X32ABI-NEXT:    jmp .LBB0_7
; X32ABI-NEXT:  .LBB0_6: # %true
; X32ABI-NEXT:    xorl %eax, %eax
; X32ABI-NEXT:  .LBB0_7: # %true
; X32ABI-NEXT:    leal -8(%ebp), %esp
; X32ABI-NEXT:    popq %rbx
; X32ABI-NEXT:    popq %rbp
; X32ABI-NEXT:    .cfi_def_cfa %rsp, 8
; X32ABI-NEXT:    retq
; X32ABI-NEXT:  .LBB0_1:
; X32ABI-NEXT:    .cfi_def_cfa_register 4294967294
; X32ABI-NEXT:    .cfi_restore %rbx
; X32ABI-NEXT:    .cfi_restore %rbp
; X32ABI-NEXT:    movl $24, %r10d
; X32ABI-NEXT:    movl $0, %r11d
; X32ABI-NEXT:    callq __morestack
; X32ABI-NEXT:    retq
; X32ABI-NEXT:    jmp .LBB0_2
        %mem = alloca i32, i32 %l
        call void @dummy_use (ptr %mem, i32 %l)
        %terminate = icmp eq i32 %l, 0
        br i1 %terminate, label %true, label %false

true:
        ret i32 0

false:
        %newlen = sub i32 %l, 1
        %retvalue = call i32 @test_basic(i32 %newlen)
        ret i32 %retvalue



















}

attributes #0 = { "split-stack" }
