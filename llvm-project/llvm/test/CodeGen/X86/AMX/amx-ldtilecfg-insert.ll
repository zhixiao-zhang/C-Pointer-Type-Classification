; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+amx-int8 -mattr=+avx512f -verify-machineinstrs | FileCheck %s
@buf = dso_local global [3072 x i8] zeroinitializer, align 16

define dso_local void @test1(i16 signext %0, i16 signext %1) nounwind {
; CHECK-LABEL: test1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovups %zmm0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $1, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw %si, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %dil, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw %si, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %dil, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    ldtilecfg -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movl $buf, %eax
; CHECK-NEXT:    movl $32, %ecx
; CHECK-NEXT:    movw $8, %dx
; CHECK-NEXT:    tileloadd (%rax,%rcx), %tmm0
; CHECK-NEXT:    movl $buf+1024, %eax
; CHECK-NEXT:    tileloadd (%rax,%rcx), %tmm1
; CHECK-NEXT:    movl $buf+2048, %eax
; CHECK-NEXT:    tileloadd (%rax,%rcx), %tmm2
; CHECK-NEXT:    tdpbssd %tmm1, %tmm0, %tmm2
; CHECK-NEXT:    tilestored %tmm2, (%rax,%rcx)
; CHECK-NEXT:    tilerelease
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    jmp foo # TAILCALL
  %3 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %0, i16 8, ptr @buf, i64 32)
  %4 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 %1, ptr getelementptr inbounds ([3072 x i8], ptr @buf, i64 0, i64 1024), i64 32)
  %5 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %0, i16 %1, ptr getelementptr inbounds ([3072 x i8], ptr @buf, i64 0, i64 2048), i64 32)
  %6 = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 %0, i16 %1, i16 8, x86_amx %5, x86_amx %3, x86_amx %4)
  call void @llvm.dbg.value(metadata x86_amx %6, metadata !DILocalVariable(name: "1", scope: !2), metadata !DIExpression()), !dbg !3
  tail call void @llvm.x86.tilestored64.internal(i16 %0, i16 %1, ptr getelementptr inbounds ([3072 x i8], ptr @buf, i64 0, i64 2048), i64 32, x86_amx %6)
  tail call void @foo()
  ret void
}

define dso_local void @test2(i16 signext %0, i16 signext %1) nounwind {
; CHECK-LABEL: test2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    subq $72, %rsp
; CHECK-NEXT:    movl %esi, %ebx
; CHECK-NEXT:    movl %edi, %ebp
; CHECK-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovups %zmm0, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $1, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw %bx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %bpl, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw %bx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %bpl, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw %bx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %bpl, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq foo
; CHECK-NEXT:    ldtilecfg {{[0-9]+}}(%rsp)
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB1_3
; CHECK-NEXT:  # %bb.1: # %if.true
; CHECK-NEXT:    movw $8, %ax
; CHECK-NEXT:    tilezero %tmm0
; CHECK-NEXT:    movl $32, %ecx
; CHECK-NEXT:    movl $buf+1024, %edx
; CHECK-NEXT:    tileloadd (%rdx,%rcx), %tmm1
; CHECK-NEXT:    movl $buf+2048, %edx
; CHECK-NEXT:    tileloadd (%rdx,%rcx), %tmm2
; CHECK-NEXT:    tdpbssd %tmm2, %tmm1, %tmm0
; CHECK-NEXT:    tilestored %tmm0, (%rdx,%rcx)
; CHECK-NEXT:    jmp .LBB1_2
; CHECK-NEXT:  .LBB1_3: # %if.false
; CHECK-NEXT:    movl $buf, %eax
; CHECK-NEXT:    movl $32, %ecx
; CHECK-NEXT:    movw $8, %dx
; CHECK-NEXT:    tileloadd (%rax,%rcx), %tmm3
; CHECK-NEXT:    movl $buf+1024, %eax
; CHECK-NEXT:    tileloadd (%rax,%rcx), %tmm4
; CHECK-NEXT:    movl $buf+2048, %eax
; CHECK-NEXT:    tileloadd (%rax,%rcx), %tmm2
; CHECK-NEXT:    tdpbssd %tmm2, %tmm4, %tmm3
; CHECK-NEXT:    tilestored %tmm3, (%rax,%rcx)
; CHECK-NEXT:  .LBB1_2: # %if.true
; CHECK-NEXT:    addq $72, %rsp
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    tilerelease
; CHECK-NEXT:    retq
  call void @foo()
  br i1 undef, label %if.true, label %if.false

if.true:
  %t1 = tail call x86_amx @llvm.x86.tilezero.internal(i16 %0, i16 8)
  %t2 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 %1, ptr getelementptr inbounds ([3072 x i8], ptr @buf, i64 0, i64 1024), i64 32)
  %t3 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %0, i16 %1, ptr getelementptr inbounds ([3072 x i8], ptr @buf, i64 0, i64 2048), i64 32)
  %t4 = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 %0, i16 %1, i16 8, x86_amx %t1, x86_amx %t2, x86_amx %t3)
  tail call void @llvm.x86.tilestored64.internal(i16 %0, i16 %1, ptr getelementptr inbounds ([3072 x i8], ptr @buf, i64 0, i64 2048), i64 32, x86_amx %t4)
  br label %exit

if.false:
  %t5 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %0, i16 8, ptr @buf, i64 32)
  %t6 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 %1, ptr getelementptr inbounds ([3072 x i8], ptr @buf, i64 0, i64 1024), i64 32)
  %t7 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %0, i16 %1, ptr getelementptr inbounds ([3072 x i8], ptr @buf, i64 0, i64 2048), i64 32)
  %t8 = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 %0, i16 %1, i16 8, x86_amx %t5, x86_amx %t6, x86_amx %t7)
  tail call void @llvm.x86.tilestored64.internal(i16 %0, i16 %1, ptr getelementptr inbounds ([3072 x i8], ptr @buf, i64 0, i64 2048), i64 32, x86_amx %t8)
  br label %exit

exit:
  ret void
}

define dso_local void @test3(i16 signext %0, i16 signext %1) nounwind {
; CHECK-LABEL: test3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovups %zmm0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $1, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw %si, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %dil, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB2_2
; CHECK-NEXT:  # %bb.1: # %if.true
; CHECK-NEXT:    incl %edi
; CHECK-NEXT:    jmp .LBB2_3
; CHECK-NEXT:  .LBB2_2: # %if.false
; CHECK-NEXT:    decl %edi
; CHECK-NEXT:  .LBB2_3: # %exit
; CHECK-NEXT:    movb %dil, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    ldtilecfg -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    tilezero %tmm0
; CHECK-NEXT:    movl $buf, %eax
; CHECK-NEXT:    movl $32, %ecx
; CHECK-NEXT:    tilestored %tmm0, (%rax,%rcx)
; CHECK-NEXT:    tilerelease
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  br i1 undef, label %if.true, label %if.false

if.true:
  %3 = add i16 %0, 1
  br label %exit

if.false:
  %4 = sub i16 %0, 1
  br label %exit

exit:
  %5 = phi i16 [ %3, %if.true ], [ %4, %if.false ]
  %6 = tail call x86_amx @llvm.x86.tilezero.internal(i16 %5, i16 %1)
  tail call void @llvm.x86.tilestored64.internal(i16 %5, i16 %1, ptr @buf, i64 32, x86_amx %6)
  ret void
}

define dso_local void @test4(i16 signext %0, i16 signext %1) nounwind {
; CHECK-LABEL: test4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovups %zmm0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $1, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw %si, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %dil, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB3_3
; CHECK-NEXT:  # %bb.1: # %if.true
; CHECK-NEXT:    incl %edi
; CHECK-NEXT:    movb %dil, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    ldtilecfg -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB3_4
; CHECK-NEXT:  .LBB3_2: # %amx2
; CHECK-NEXT:    movl $32, %eax
; CHECK-NEXT:    movl $buf+1024, %ecx
; CHECK-NEXT:    tileloadd (%rcx,%rax), %tmm0
; CHECK-NEXT:    movl $buf, %ecx
; CHECK-NEXT:    tilestored %tmm0, (%rcx,%rax)
; CHECK-NEXT:    tilerelease
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB3_3: # %if.false
; CHECK-NEXT:    decl %edi
; CHECK-NEXT:    movb %dil, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    ldtilecfg -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB3_2
; CHECK-NEXT:  .LBB3_4: # %amx1
; CHECK-NEXT:    tilezero %tmm0
; CHECK-NEXT:    movl $buf, %eax
; CHECK-NEXT:    movl $32, %ecx
; CHECK-NEXT:    tilestored %tmm0, (%rax,%rcx)
; CHECK-NEXT:    tilerelease
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  br i1 undef, label %if.true, label %if.false

if.true:
  %3 = add i16 %0, 1
  br i1 undef, label %amx1, label %amx2

if.false:
  %4 = sub i16 %0, 1
  br i1 undef, label %amx2, label %amx1

amx1:
  %5 = phi i16 [ %3, %if.true ], [ %4, %if.false ]
  %6 = tail call x86_amx @llvm.x86.tilezero.internal(i16 %5, i16 %1)
  tail call void @llvm.x86.tilestored64.internal(i16 %5, i16 %1, ptr @buf, i64 32, x86_amx %6)
  br label %exit

amx2:
  %7 = phi i16 [ %3, %if.true ], [ %4, %if.false ]
  %8 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 %7, i16 %1, ptr getelementptr inbounds ([3072 x i8], ptr @buf, i64 0, i64 1024), i64 32)
  tail call void @llvm.x86.tilestored64.internal(i16 %7, i16 %1, ptr @buf, i64 32, x86_amx %8)
  br label %exit

exit:
  ret void
}

define dso_local void @test5(i16 signext %0, i16 signext %1) nounwind {
; CHECK-LABEL: test5:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    # kill: def $esi killed $esi def $rsi
; CHECK-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovups %zmm0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $1, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw %si, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %dil, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    movl $buf, %ecx
; CHECK-NEXT:    movl $32, %edx
; CHECK-NEXT:    leal -1(%rsi), %r8d
; CHECK-NEXT:    jmp .LBB4_1
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB4_3: # %if.false
; CHECK-NEXT:    # in Loop: Header=BB4_1 Depth=1
; CHECK-NEXT:    movl %r8d, %esi
; CHECK-NEXT:    movw %r8w, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    cmpw $7, %si
; CHECK-NEXT:    jne .LBB4_5
; CHECK-NEXT:  .LBB4_1: # %loop.bb1
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldtilecfg -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB4_3
; CHECK-NEXT:  # %bb.2: # %if.true
; CHECK-NEXT:    # in Loop: Header=BB4_1 Depth=1
; CHECK-NEXT:    tilezero %tmm0
; CHECK-NEXT:    tilestored %tmm0, (%rcx,%rdx)
; CHECK-NEXT:    cmpw $7, %si
; CHECK-NEXT:    je .LBB4_1
; CHECK-NEXT:  .LBB4_5: # %exit
; CHECK-NEXT:    tilerelease
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
entry:
  br label %loop.bb1

loop.bb1:
  %2 = phi i16 [ %1, %entry ], [ %5, %loop.bb2 ]
  br i1 undef, label %if.true, label %if.false

if.true:
  %3 = tail call x86_amx @llvm.x86.tilezero.internal(i16 %0, i16 %2)
  tail call void @llvm.x86.tilestored64.internal(i16 %0, i16 %2, ptr @buf, i64 32, x86_amx %3)
  br label %loop.bb2

if.false:
  %4 = sub i16 %1, 1
  br label %loop.bb2

loop.bb2:
  %5 = phi i16 [ %2, %if.true ], [ %4, %if.false ]
  %6 = icmp eq i16 %5, 7
  br i1 %6, label %loop.bb1, label %exit

exit:
  ret void
}

define dso_local void @test6(i16 signext %0) nounwind {
; CHECK-LABEL: test6:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovups %zmm0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $1, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %dil, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    movl $buf, %ecx
; CHECK-NEXT:    movl $32, %edx
; CHECK-NEXT:    xorl %esi, %esi
; CHECK-NEXT:    jmp .LBB5_1
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB5_3: # %if.false
; CHECK-NEXT:    # in Loop: Header=BB5_1 Depth=1
; CHECK-NEXT:    decl %esi
; CHECK-NEXT:  .LBB5_4: # %loop.bb2
; CHECK-NEXT:    # in Loop: Header=BB5_1 Depth=1
; CHECK-NEXT:    leal (%rdi,%rsi), %r8d
; CHECK-NEXT:    movw %r8w, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    cmpw $7, %si
; CHECK-NEXT:    ldtilecfg -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    tilezero %tmm0
; CHECK-NEXT:    tilestored %tmm0, (%rcx,%rdx)
; CHECK-NEXT:    jne .LBB5_5
; CHECK-NEXT:  .LBB5_1: # %loop.bb1
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB5_3
; CHECK-NEXT:  # %bb.2: # %if.true
; CHECK-NEXT:    # in Loop: Header=BB5_1 Depth=1
; CHECK-NEXT:    incl %esi
; CHECK-NEXT:    jmp .LBB5_4
; CHECK-NEXT:  .LBB5_5: # %exit
; CHECK-NEXT:    tilerelease
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
entry:
  br label %loop.bb1

loop.bb1:
  %1 = phi i16 [ 0, %entry ], [ %4, %loop.bb2 ]
  br i1 undef, label %if.true, label %if.false

if.true:
  %2 = add i16 %1, 1
  br label %loop.bb2

if.false:
  %3 = sub i16 %1, 1
  br label %loop.bb2

loop.bb2:
  %4 = phi i16 [ %2, %if.true ], [ %3, %if.false ]
  %5 = icmp eq i16 %4, 7
  %6 = add i16 %0, %4
  %7 = tail call x86_amx @llvm.x86.tilezero.internal(i16 %0, i16 %6)
  tail call void @llvm.x86.tilestored64.internal(i16 %0, i16 %6, ptr @buf, i64 32, x86_amx %7)
  br i1 %5, label %loop.bb1, label %exit

exit:
  ret void
}


declare dso_local void @foo() nounwind
declare void @llvm.dbg.value(metadata, metadata, metadata)
declare x86_amx @llvm.x86.tilezero.internal(i16, i16)
declare x86_amx @llvm.x86.tileloadd64.internal(i16, i16, ptr, i64)
declare x86_amx @llvm.x86.tdpbssd.internal(i16, i16, i16, x86_amx, x86_amx, x86_amx)
declare void @llvm.x86.tilestored64.internal(i16, i16, ptr, i64, x86_amx)

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!1}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !DIFile(filename: "1", directory: "1"))
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = distinct !DISubprogram(unit: !0)
!3 = !DILocation(line: 1, column: 1, scope: !2)