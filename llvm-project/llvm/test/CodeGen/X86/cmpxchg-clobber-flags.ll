; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=i386-linux-gnu -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=X86-ALL,X86-GOOD-RA
; RUN: llc -mtriple=i386-linux-gnu -verify-machineinstrs -pre-RA-sched=fast %s -o - | FileCheck %s --check-prefixes=X86-ALL,X86-FAST-RA

; RUN: llc -mtriple=x86_64-linux-gnu -verify-machineinstrs %s -o - | FileCheck %s --check-prefix=X64-ALL
; RUN: llc -mtriple=x86_64-linux-gnu -verify-machineinstrs -pre-RA-sched=fast %s -o - | FileCheck %s --check-prefix=X64-ALL
; RUN: llc -mtriple=x86_64-linux-gnu -verify-machineinstrs -mattr=+sahf %s -o - | FileCheck %s --check-prefix=X64-ALL
; RUN: llc -mtriple=x86_64-linux-gnu -verify-machineinstrs -mattr=+sahf -pre-RA-sched=fast %s -o - | FileCheck %s --check-prefix=X64-ALL
; RUN: llc -mtriple=x86_64-linux-gnu -verify-machineinstrs -mcpu=corei7 %s -o - | FileCheck %s --check-prefix=X64-ALL

declare i32 @foo()
declare i32 @bar(i64)

; In the following case when using fast scheduling we get a long chain of
; EFLAGS save/restore due to a sequence of:
; cmpxchg8b (implicit-def eflags)
; eax = copy eflags
; adjcallstackdown32
; ...
; use of eax
; During PEI the adjcallstackdown32 is replaced with the subl which
; clobbers eflags, effectively interfering in the liveness interval. However,
; we then promote these copies into independent conditions in GPRs that avoids
; repeated saving and restoring logic and can be trivially managed by the
; register allocator.
define i64 @test_intervening_call(ptr %foo, i64 %bar, i64 %baz) nounwind {
; X86-GOOD-RA-LABEL: test_intervening_call:
; X86-GOOD-RA:       # %bb.0: # %entry
; X86-GOOD-RA-NEXT:    pushl %ebx
; X86-GOOD-RA-NEXT:    pushl %esi
; X86-GOOD-RA-NEXT:    pushl %eax
; X86-GOOD-RA-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-GOOD-RA-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-GOOD-RA-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-GOOD-RA-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-GOOD-RA-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-GOOD-RA-NEXT:    lock cmpxchg8b (%esi)
; X86-GOOD-RA-NEXT:    setne %bl
; X86-GOOD-RA-NEXT:    subl $8, %esp
; X86-GOOD-RA-NEXT:    pushl %edx
; X86-GOOD-RA-NEXT:    pushl %eax
; X86-GOOD-RA-NEXT:    calll bar@PLT
; X86-GOOD-RA-NEXT:    addl $16, %esp
; X86-GOOD-RA-NEXT:    testb %bl, %bl
; X86-GOOD-RA-NEXT:    jne .LBB0_3
; X86-GOOD-RA-NEXT:  # %bb.1: # %t
; X86-GOOD-RA-NEXT:    movl $42, %eax
; X86-GOOD-RA-NEXT:    jmp .LBB0_2
; X86-GOOD-RA-NEXT:  .LBB0_3: # %f
; X86-GOOD-RA-NEXT:    xorl %eax, %eax
; X86-GOOD-RA-NEXT:  .LBB0_2: # %t
; X86-GOOD-RA-NEXT:    xorl %edx, %edx
; X86-GOOD-RA-NEXT:    addl $4, %esp
; X86-GOOD-RA-NEXT:    popl %esi
; X86-GOOD-RA-NEXT:    popl %ebx
; X86-GOOD-RA-NEXT:    retl
;
; X86-FAST-RA-LABEL: test_intervening_call:
; X86-FAST-RA:       # %bb.0: # %entry
; X86-FAST-RA-NEXT:    pushl %ebx
; X86-FAST-RA-NEXT:    pushl %esi
; X86-FAST-RA-NEXT:    pushl %eax
; X86-FAST-RA-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-FAST-RA-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-FAST-RA-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-FAST-RA-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-FAST-RA-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-FAST-RA-NEXT:    lock cmpxchg8b (%esi)
; X86-FAST-RA-NEXT:    setne %bl
; X86-FAST-RA-NEXT:    subl $8, %esp
; X86-FAST-RA-NEXT:    pushl %edx
; X86-FAST-RA-NEXT:    pushl %eax
; X86-FAST-RA-NEXT:    calll bar@PLT
; X86-FAST-RA-NEXT:    addl $16, %esp
; X86-FAST-RA-NEXT:    testb %bl, %bl
; X86-FAST-RA-NEXT:    jne .LBB0_3
; X86-FAST-RA-NEXT:  # %bb.1: # %t
; X86-FAST-RA-NEXT:    movl $42, %eax
; X86-FAST-RA-NEXT:    jmp .LBB0_2
; X86-FAST-RA-NEXT:  .LBB0_3: # %f
; X86-FAST-RA-NEXT:    xorl %eax, %eax
; X86-FAST-RA-NEXT:  .LBB0_2: # %t
; X86-FAST-RA-NEXT:    xorl %edx, %edx
; X86-FAST-RA-NEXT:    addl $4, %esp
; X86-FAST-RA-NEXT:    popl %esi
; X86-FAST-RA-NEXT:    popl %ebx
; X86-FAST-RA-NEXT:    retl
;
; X64-ALL-LABEL: test_intervening_call:
; X64-ALL:       # %bb.0: # %entry
; X64-ALL-NEXT:    pushq %rbx
; X64-ALL-NEXT:    movq %rsi, %rax
; X64-ALL-NEXT:    lock cmpxchgq %rdx, (%rdi)
; X64-ALL-NEXT:    setne %bl
; X64-ALL-NEXT:    movq %rax, %rdi
; X64-ALL-NEXT:    callq bar@PLT
; X64-ALL-NEXT:    testb %bl, %bl
; X64-ALL-NEXT:    jne .LBB0_2
; X64-ALL-NEXT:  # %bb.1: # %t
; X64-ALL-NEXT:    movl $42, %eax
; X64-ALL-NEXT:    popq %rbx
; X64-ALL-NEXT:    retq
; X64-ALL-NEXT:  .LBB0_2: # %f
; X64-ALL-NEXT:    xorl %eax, %eax
; X64-ALL-NEXT:    popq %rbx
; X64-ALL-NEXT:    retq
entry:
  %cx = cmpxchg ptr %foo, i64 %bar, i64 %baz seq_cst seq_cst
  %v = extractvalue { i64, i1 } %cx, 0
  %p = extractvalue { i64, i1 } %cx, 1
  call i32 @bar(i64 %v)
  br i1 %p, label %t, label %f

t:
  ret i64 42

f:
  ret i64 0
}

; Interesting in producing a clobber without any function calls.
define i32 @test_control_flow(ptr %p, i32 %i, i32 %j) nounwind {
; X86-ALL-LABEL: test_control_flow:
; X86-ALL:       # %bb.0: # %entry
; X86-ALL-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-ALL-NEXT:    cmpl {{[0-9]+}}(%esp), %eax
; X86-ALL-NEXT:    jle .LBB1_6
; X86-ALL-NEXT:  # %bb.1: # %loop_start
; X86-ALL-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-ALL-NEXT:    .p2align 4
; X86-ALL-NEXT:  .LBB1_2: # %while.condthread-pre-split.i
; X86-ALL-NEXT:    # =>This Loop Header: Depth=1
; X86-ALL-NEXT:    # Child Loop BB1_3 Depth 2
; X86-ALL-NEXT:    movl (%ecx), %edx
; X86-ALL-NEXT:    .p2align 4
; X86-ALL-NEXT:  .LBB1_3: # %while.cond.i
; X86-ALL-NEXT:    # Parent Loop BB1_2 Depth=1
; X86-ALL-NEXT:    # => This Inner Loop Header: Depth=2
; X86-ALL-NEXT:    movl %edx, %eax
; X86-ALL-NEXT:    xorl %edx, %edx
; X86-ALL-NEXT:    testl %eax, %eax
; X86-ALL-NEXT:    je .LBB1_3
; X86-ALL-NEXT:  # %bb.4: # %while.body.i
; X86-ALL-NEXT:    # in Loop: Header=BB1_2 Depth=1
; X86-ALL-NEXT:    lock cmpxchgl %eax, (%ecx)
; X86-ALL-NEXT:    jne .LBB1_2
; X86-ALL-NEXT:  # %bb.5:
; X86-ALL-NEXT:    xorl %eax, %eax
; X86-ALL-NEXT:  .LBB1_6: # %cond.end
; X86-ALL-NEXT:    retl
;
; X64-ALL-LABEL: test_control_flow:
; X64-ALL:       # %bb.0: # %entry
; X64-ALL-NEXT:    movl %esi, %eax
; X64-ALL-NEXT:    cmpl %edx, %esi
; X64-ALL-NEXT:    jle .LBB1_5
; X64-ALL-NEXT:    .p2align 4
; X64-ALL-NEXT:  .LBB1_1: # %while.condthread-pre-split.i
; X64-ALL-NEXT:    # =>This Loop Header: Depth=1
; X64-ALL-NEXT:    # Child Loop BB1_2 Depth 2
; X64-ALL-NEXT:    movl (%rdi), %ecx
; X64-ALL-NEXT:    .p2align 4
; X64-ALL-NEXT:  .LBB1_2: # %while.cond.i
; X64-ALL-NEXT:    # Parent Loop BB1_1 Depth=1
; X64-ALL-NEXT:    # => This Inner Loop Header: Depth=2
; X64-ALL-NEXT:    movl %ecx, %eax
; X64-ALL-NEXT:    xorl %ecx, %ecx
; X64-ALL-NEXT:    testl %eax, %eax
; X64-ALL-NEXT:    je .LBB1_2
; X64-ALL-NEXT:  # %bb.3: # %while.body.i
; X64-ALL-NEXT:    # in Loop: Header=BB1_1 Depth=1
; X64-ALL-NEXT:    lock cmpxchgl %eax, (%rdi)
; X64-ALL-NEXT:    jne .LBB1_1
; X64-ALL-NEXT:  # %bb.4:
; X64-ALL-NEXT:    xorl %eax, %eax
; X64-ALL-NEXT:  .LBB1_5: # %cond.end
; X64-ALL-NEXT:    retq
entry:
  %cmp = icmp sgt i32 %i, %j
  br i1 %cmp, label %loop_start, label %cond.end

loop_start:
  br label %while.condthread-pre-split.i

while.condthread-pre-split.i:
  %.pr.i = load i32, ptr %p, align 4
  br label %while.cond.i

while.cond.i:
  %0 = phi i32 [ %.pr.i, %while.condthread-pre-split.i ], [ 0, %while.cond.i ]
  %tobool.i = icmp eq i32 %0, 0
  br i1 %tobool.i, label %while.cond.i, label %while.body.i

while.body.i:
  %.lcssa = phi i32 [ %0, %while.cond.i ]
  %1 = cmpxchg ptr %p, i32 %.lcssa, i32 %.lcssa seq_cst seq_cst
  %2 = extractvalue { i32, i1 } %1, 1
  br i1 %2, label %cond.end.loopexit, label %while.condthread-pre-split.i

cond.end.loopexit:
  br label %cond.end

cond.end:
  %cond = phi i32 [ %i, %entry ], [ 0, %cond.end.loopexit ]
  ret i32 %cond
}

; This one is an interesting case because CMOV doesn't have a chain
; operand. Naive attempts to limit cmpxchg EFLAGS use are likely to fail here.
define i32 @test_feed_cmov(ptr %addr, i32 %desired, i32 %new) nounwind {
; X86-GOOD-RA-LABEL: test_feed_cmov:
; X86-GOOD-RA:       # %bb.0: # %entry
; X86-GOOD-RA-NEXT:    pushl %ebx
; X86-GOOD-RA-NEXT:    pushl %esi
; X86-GOOD-RA-NEXT:    pushl %eax
; X86-GOOD-RA-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-GOOD-RA-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-GOOD-RA-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-GOOD-RA-NEXT:    lock cmpxchgl %esi, (%ecx)
; X86-GOOD-RA-NEXT:    sete %bl
; X86-GOOD-RA-NEXT:    calll foo@PLT
; X86-GOOD-RA-NEXT:    testb %bl, %bl
; X86-GOOD-RA-NEXT:    jne .LBB2_2
; X86-GOOD-RA-NEXT:  # %bb.1: # %entry
; X86-GOOD-RA-NEXT:    movl %eax, %esi
; X86-GOOD-RA-NEXT:  .LBB2_2: # %entry
; X86-GOOD-RA-NEXT:    movl %esi, %eax
; X86-GOOD-RA-NEXT:    addl $4, %esp
; X86-GOOD-RA-NEXT:    popl %esi
; X86-GOOD-RA-NEXT:    popl %ebx
; X86-GOOD-RA-NEXT:    retl
;
; X86-FAST-RA-LABEL: test_feed_cmov:
; X86-FAST-RA:       # %bb.0: # %entry
; X86-FAST-RA-NEXT:    pushl %ebx
; X86-FAST-RA-NEXT:    pushl %esi
; X86-FAST-RA-NEXT:    pushl %eax
; X86-FAST-RA-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-FAST-RA-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-FAST-RA-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-FAST-RA-NEXT:    lock cmpxchgl %esi, (%ecx)
; X86-FAST-RA-NEXT:    sete %bl
; X86-FAST-RA-NEXT:    calll foo@PLT
; X86-FAST-RA-NEXT:    testb %bl, %bl
; X86-FAST-RA-NEXT:    jne .LBB2_2
; X86-FAST-RA-NEXT:  # %bb.1: # %entry
; X86-FAST-RA-NEXT:    movl %eax, %esi
; X86-FAST-RA-NEXT:  .LBB2_2: # %entry
; X86-FAST-RA-NEXT:    movl %esi, %eax
; X86-FAST-RA-NEXT:    addl $4, %esp
; X86-FAST-RA-NEXT:    popl %esi
; X86-FAST-RA-NEXT:    popl %ebx
; X86-FAST-RA-NEXT:    retl
;
; X64-ALL-LABEL: test_feed_cmov:
; X64-ALL:       # %bb.0: # %entry
; X64-ALL-NEXT:    pushq %rbp
; X64-ALL-NEXT:    pushq %rbx
; X64-ALL-NEXT:    pushq %rax
; X64-ALL-NEXT:    movl %edx, %ebx
; X64-ALL-NEXT:    movl %esi, %eax
; X64-ALL-NEXT:    lock cmpxchgl %edx, (%rdi)
; X64-ALL-NEXT:    sete %bpl
; X64-ALL-NEXT:    callq foo@PLT
; X64-ALL-NEXT:    testb %bpl, %bpl
; X64-ALL-NEXT:    cmovnel %ebx, %eax
; X64-ALL-NEXT:    addq $8, %rsp
; X64-ALL-NEXT:    popq %rbx
; X64-ALL-NEXT:    popq %rbp
; X64-ALL-NEXT:    retq
entry:
  %res = cmpxchg ptr %addr, i32 %desired, i32 %new seq_cst seq_cst
  %success = extractvalue { i32, i1 } %res, 1

  %rhs = call i32 @foo()

  %ret = select i1 %success, i32 %new, i32 %rhs
  ret i32 %ret
}