; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+ccmp -verify-machineinstrs | FileCheck %s
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+ccmp,+ndd -verify-machineinstrs | FileCheck %s --check-prefix=NDD

define void @ctest8rr_zf(i8 noundef %a, i8 noundef %b) {
; CHECK-LABEL: ctest8rr_zf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testb %dil, %dil
; CHECK-NEXT:    ctestneb {dfv=zf} %sil, %sil
; CHECK-NEXT:    jne .LBB0_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB0_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest8rr_zf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testb %dil, %dil
; NDD-NEXT:    ctestneb {dfv=zf} %sil, %sil
; NDD-NEXT:    jne .LBB0_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB0_1: # %if.end
; NDD-NEXT:    retq
entry:
  %cmp = icmp eq i8 %a, 0
  %cmp1 = icmp eq i8 %b, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

define i8 @ctest8rr_zf_double(i8 %a, double %b, i8* nocapture %c)  {
; CHECK-LABEL: ctest8rr_zf_double:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xorpd %xmm1, %xmm1
; CHECK-NEXT:    ucomisd %xmm1, %xmm0
; CHECK-NEXT:    ctesteb {dfv=zf} %dil, %dil
; CHECK-NEXT:    je .LBB1_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    movb %dil, (%rsi)
; CHECK-NEXT:  .LBB1_2: # %if.end
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest8rr_zf_double:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    xorpd %xmm1, %xmm1
; NDD-NEXT:    ucomisd %xmm1, %xmm0
; NDD-NEXT:    ctesteb {dfv=zf} %dil, %dil
; NDD-NEXT:    je .LBB1_2
; NDD-NEXT:  # %bb.1: # %if.then
; NDD-NEXT:    movb %dil, (%rsi)
; NDD-NEXT:  .LBB1_2: # %if.end
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    retq
entry:
  %tobool = icmp ne i8 %a, 0
  %cmp = fcmp ueq double %b, 0.0
  %or.cond = select i1 %tobool, i1 %cmp, i1 false
  br i1 %or.cond, label %if.then, label %if.end

if.then:
  store i8 %a, i8* %c, align 4
  br label %if.end

if.end:
  ret i8 0
}

define i8 @ctest8rr_zf_double_p(i8 %a, double %b, i8* nocapture %c)  {
; CHECK-LABEL: ctest8rr_zf_double_p:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testb %dil, %dil
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    ucomisd %xmm0, %xmm0
; CHECK-NEXT:    setp %cl
; CHECK-NEXT:    andb %al, %cl
; CHECK-NEXT:    cmpb $1, %cl
; CHECK-NEXT:    jne .LBB2_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    movb %dil, (%rsi)
; CHECK-NEXT:  .LBB2_2: # %if.end
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest8rr_zf_double_p:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testb %dil, %dil
; NDD-NEXT:    setne %al
; NDD-NEXT:    ucomisd %xmm0, %xmm0
; NDD-NEXT:    setp %cl
; NDD-NEXT:    andb %cl, %al
; NDD-NEXT:    cmpb $1, %al
; NDD-NEXT:    jne .LBB2_2
; NDD-NEXT:  # %bb.1: # %if.then
; NDD-NEXT:    movb %dil, (%rsi)
; NDD-NEXT:  .LBB2_2: # %if.end
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    retq
entry:
  %tobool = icmp ne i8 %a, 0
  %cmp = fcmp uno double %b, 0.0
  %or.cond = select i1 %tobool, i1 %cmp, i1 false
  br i1 %or.cond, label %if.then, label %if.end

if.then:
  store i8 %a, i8* %c, align 4
  br label %if.end

if.end:
  ret i8 0
}

define i8 @ctest8rr_zf_double_np(i8 %a, double %b, i8* nocapture %c)  {
; CHECK-LABEL: ctest8rr_zf_double_np:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testb %dil, %dil
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    ucomisd %xmm0, %xmm0
; CHECK-NEXT:    setnp %cl
; CHECK-NEXT:    andb %al, %cl
; CHECK-NEXT:    cmpb $1, %cl
; CHECK-NEXT:    jne .LBB3_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    movb %dil, (%rsi)
; CHECK-NEXT:  .LBB3_2: # %if.end
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest8rr_zf_double_np:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testb %dil, %dil
; NDD-NEXT:    setne %al
; NDD-NEXT:    ucomisd %xmm0, %xmm0
; NDD-NEXT:    setnp %cl
; NDD-NEXT:    andb %cl, %al
; NDD-NEXT:    cmpb $1, %al
; NDD-NEXT:    jne .LBB3_2
; NDD-NEXT:  # %bb.1: # %if.then
; NDD-NEXT:    movb %dil, (%rsi)
; NDD-NEXT:  .LBB3_2: # %if.end
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    retq
entry:
  %tobool = icmp ne i8 %a, 0
  %cmp = fcmp ord double %b, 0.0
  %or.cond = select i1 %tobool, i1 %cmp, i1 false
  br i1 %or.cond, label %if.then, label %if.end

if.then:
  store i8 %a, i8* %c, align 4
  br label %if.end

if.end:
  ret i8 0
}

define void @ctest8rr_sf(i8 noundef %a, i8 noundef %b) {
; CHECK-LABEL: ctest8rr_sf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testb %dil, %dil
; CHECK-NEXT:    ctesteb {dfv=sf} %sil, %sil
; CHECK-NEXT:    js .LBB4_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB4_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest8rr_sf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testb %dil, %dil
; NDD-NEXT:    ctesteb {dfv=sf} %sil, %sil
; NDD-NEXT:    js .LBB4_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB4_1: # %if.end
; NDD-NEXT:    retq
entry:
  %cmp = icmp ule i8 %a, 0
  %tobool = icmp sge i8 %b, 0
  %or.cond = and i1 %cmp, %tobool
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

define i8 @ctest8rr_sf_2(i8 %a, i8 %b, i8* nocapture %c)  {
; CHECK-LABEL: ctest8rr_sf_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testb %dil, %dil
; CHECK-NEXT:    ctestleb {dfv=sf} %sil, %sil
; CHECK-NEXT:    jns .LBB5_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    movb %dil, (%rdx)
; CHECK-NEXT:  .LBB5_2: # %if.end
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest8rr_sf_2:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testb %dil, %dil
; NDD-NEXT:    ctestleb {dfv=sf} %sil, %sil
; NDD-NEXT:    jns .LBB5_2
; NDD-NEXT:  # %bb.1: # %if.then
; NDD-NEXT:    movb %dil, (%rdx)
; NDD-NEXT:  .LBB5_2: # %if.end
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    retq
entry:
  %tobool = icmp sgt i8 %a, 0
  %cmp = icmp slt i8 %b, 0
  %or.cond = select i1 %tobool, i1 true, i1 %cmp
  br i1 %or.cond, label %if.then, label %if.end

if.then:
  store i8 %a, i8* %c, align 4
  br label %if.end

if.end:
  ret i8 0
}

define i8 @ctest8rr_none(i8 %a, i8 %b, i8* nocapture %c)  {
; CHECK-LABEL: ctest8rr_none:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testb %dil, %dil
; CHECK-NEXT:    ctestneb {dfv=} %sil, %sil
; CHECK-NEXT:    jne .LBB6_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    movb %dil, (%rdx)
; CHECK-NEXT:  .LBB6_2: # %if.end
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest8rr_none:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testb %dil, %dil
; NDD-NEXT:    ctestneb {dfv=} %sil, %sil
; NDD-NEXT:    jne .LBB6_2
; NDD-NEXT:  # %bb.1: # %if.then
; NDD-NEXT:    movb %dil, (%rdx)
; NDD-NEXT:  .LBB6_2: # %if.end
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    retq
entry:
  %tobool = icmp ne i8 %a, 0
  %cmp = icmp eq i8 %b, 0
  %or.cond = select i1 %tobool, i1 %cmp, i1 false
  br i1 %or.cond, label %if.then, label %if.end

if.then:
  store i8 %a, i8* %c, align 4
  br label %if.end

if.end:
  ret i8 0
}

define void @ctest16rr_sf(i16 noundef %a, i16 noundef %b) {
; CHECK-LABEL: ctest16rr_sf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testw %di, %di
; CHECK-NEXT:    ctestlew {dfv=sf} %si, %si
; CHECK-NEXT:    jns .LBB7_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB7_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest16rr_sf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testw %di, %di
; NDD-NEXT:    ctestlew {dfv=sf} %si, %si
; NDD-NEXT:    jns .LBB7_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB7_1: # %if.end
; NDD-NEXT:    retq
entry:
  %cmp = icmp sgt i16 %a, 0
  %cmp1 = icmp slt i16 %b, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

define void @ctest32rr_zf(i32 noundef %a, i32 noundef %b) {
; CHECK-LABEL: ctest32rr_zf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    ctestsl {dfv=zf} %esi, %esi
; CHECK-NEXT:    jne .LBB8_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB8_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest32rr_zf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testl %edi, %edi
; NDD-NEXT:    ctestsl {dfv=zf} %esi, %esi
; NDD-NEXT:    jne .LBB8_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB8_1: # %if.end
; NDD-NEXT:    retq
entry:
  %cmp = icmp sge i32 %a, 0
  %cmp1 = icmp eq i32 %b, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

define void @ctest8ri_zf(i8 noundef %a, i8 noundef %b) {
; CHECK-LABEL: ctest8ri_zf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testb %dil, %dil
; CHECK-NEXT:    ctestneb {dfv=zf} $123, %sil
; CHECK-NEXT:    jne .LBB9_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB9_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest8ri_zf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testb %dil, %dil
; NDD-NEXT:    ctestneb {dfv=zf} $123, %sil
; NDD-NEXT:    jne .LBB9_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB9_1: # %if.end
; NDD-NEXT:    retq
entry:
  %cmp = icmp eq i8 %a, 0
  %and = and i8 %b, 123
  %cmp1 = icmp eq i8 %and, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

define void @ctest16ri_zf(i16 noundef %a, i16 noundef %b) {
; CHECK-LABEL: ctest16ri_zf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    andl $1234, %esi # imm = 0x4D2
; CHECK-NEXT:    testw %di, %di
; CHECK-NEXT:    ctestnew {dfv=zf} %si, %si
; CHECK-NEXT:    jne .LBB10_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB10_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest16ri_zf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testw %di, %di
; NDD-NEXT:    ctestnew {dfv=zf} $1234, %si # imm = 0x4D2
; NDD-NEXT:    jne .LBB10_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB10_1: # %if.end
; NDD-NEXT:    retq
entry:
  %cmp = icmp eq i16 %a, 0
  %and = and i16 %b, 1234
  %cmp1 = icmp eq i16 %and, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

define void @ctest32ri_zf(i32 noundef %a, i32 noundef %b) {
; CHECK-LABEL: ctest32ri_zf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    ctestnel {dfv=zf} $12345, %esi # imm = 0x3039
; CHECK-NEXT:    jne .LBB11_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB11_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest32ri_zf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testl %edi, %edi
; NDD-NEXT:    ctestnel {dfv=zf} $12345, %esi # imm = 0x3039
; NDD-NEXT:    jne .LBB11_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB11_1: # %if.end
; NDD-NEXT:    retq
entry:
  %cmp = icmp eq i32 %a, 0
  %and = and i32 %b, 12345
  %cmp1 = icmp eq i32 %and, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

define void @ctest64ri32_zf(i64 noundef %a, i64 noundef %b) {
; CHECK-LABEL: ctest64ri32_zf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testq %rdi, %rdi
; CHECK-NEXT:    ctestneq {dfv=zf} $123456, %rsi # imm = 0x1E240
; CHECK-NEXT:    jne .LBB12_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB12_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest64ri32_zf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testq %rdi, %rdi
; NDD-NEXT:    ctestneq {dfv=zf} $123456, %rsi # imm = 0x1E240
; NDD-NEXT:    jne .LBB12_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB12_1: # %if.end
; NDD-NEXT:    retq
entry:
  %cmp = icmp eq i64 %a, 0
  %and = and i64 %b, 123456
  %cmp1 = icmp eq i64 %and, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

define void @ctest8mr_zf(i8 noundef %a, ptr %ptr) {
; CHECK-LABEL: ctest8mr_zf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movzbl (%rsi), %eax
; CHECK-NEXT:    testb %dil, %dil
; CHECK-NEXT:    ctestneb {dfv=zf} %al, %al
; CHECK-NEXT:    jne .LBB13_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB13_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest8mr_zf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    movzbl (%rsi), %eax
; NDD-NEXT:    testb %dil, %dil
; NDD-NEXT:    ctestneb {dfv=zf} %al, %al
; NDD-NEXT:    jne .LBB13_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB13_1: # %if.end
; NDD-NEXT:    retq
entry:
  %b = load i8, ptr %ptr
  %cmp = icmp eq i8 %a, 0
  %cmp1 = icmp eq i8 %b, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

define void @ctest16mr_zf(i16 noundef %a, ptr %ptr) {
; CHECK-LABEL: ctest16mr_zf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movzwl (%rsi), %eax
; CHECK-NEXT:    testw %di, %di
; CHECK-NEXT:    ctestnew {dfv=zf} %ax, %ax
; CHECK-NEXT:    jne .LBB14_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB14_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest16mr_zf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    movzwl (%rsi), %eax
; NDD-NEXT:    testw %di, %di
; NDD-NEXT:    ctestnew {dfv=zf} %ax, %ax
; NDD-NEXT:    jne .LBB14_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB14_1: # %if.end
; NDD-NEXT:    retq
entry:
  %b = load i16, ptr %ptr
  %cmp = icmp eq i16 %a, 0
  %cmp1 = icmp eq i16 %b, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

define void @ctest32mr_cf(i32 noundef %a, ptr %ptr) {
; CHECK-LABEL: ctest32mr_cf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movl (%rsi), %eax
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    ctestnel {dfv=zf} %eax, %eax
; CHECK-NEXT:    jne .LBB15_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB15_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest32mr_cf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    movl (%rsi), %eax
; NDD-NEXT:    testl %edi, %edi
; NDD-NEXT:    ctestnel {dfv=zf} %eax, %eax
; NDD-NEXT:    jne .LBB15_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB15_1: # %if.end
; NDD-NEXT:    retq
entry:
  %b = load i32, ptr %ptr
  %cmp = icmp eq i32 %a, 0
  %cmp1 = icmp eq i32 %b, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

define void @ctest64mr_zf(i64 noundef %a, ptr %ptr) {
; CHECK-LABEL: ctest64mr_zf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq (%rsi), %rax
; CHECK-NEXT:    testq %rdi, %rdi
; CHECK-NEXT:    ctestneq {dfv=zf} %rax, %rax
; CHECK-NEXT:    jne .LBB16_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB16_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest64mr_zf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    movq (%rsi), %rax
; NDD-NEXT:    testq %rdi, %rdi
; NDD-NEXT:    ctestneq {dfv=zf} %rax, %rax
; NDD-NEXT:    jne .LBB16_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB16_1: # %if.end
; NDD-NEXT:    retq
entry:
  %b = load i64, ptr %ptr
  %cmp = icmp eq i64 %a, 0
  %cmp1 = icmp eq i64 %b, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

define void @ctest8mi_zf(i8 noundef %a, ptr %ptr) {
; CHECK-LABEL: ctest8mi_zf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testb %dil, %dil
; CHECK-NEXT:    ctestneb {dfv=zf} $123, (%rsi)
; CHECK-NEXT:    jne .LBB17_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB17_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest8mi_zf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testb %dil, %dil
; NDD-NEXT:    ctestneb {dfv=zf} $123, (%rsi)
; NDD-NEXT:    jne .LBB17_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB17_1: # %if.end
; NDD-NEXT:    retq
entry:
  %b = load i8, ptr %ptr
  %cmp = icmp eq i8 %a, 0
  %and = and i8 %b, 123
  %cmp1 = icmp eq i8 %and, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

define void @ctest16mi_zf(i16 noundef %a, ptr %ptr) {
; CHECK-LABEL: ctest16mi_zf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movzwl (%rsi), %eax
; CHECK-NEXT:    andl $1234, %eax # imm = 0x4D2
; CHECK-NEXT:    testw %di, %di
; CHECK-NEXT:    ctestnew {dfv=zf} %ax, %ax
; CHECK-NEXT:    jne .LBB18_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB18_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest16mi_zf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testw %di, %di
; NDD-NEXT:    ctestnew {dfv=zf} $1234, (%rsi) # imm = 0x4D2
; NDD-NEXT:    jne .LBB18_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB18_1: # %if.end
; NDD-NEXT:    retq
entry:
  %b = load i16, ptr %ptr
  %cmp = icmp eq i16 %a, 0
  %and = and i16 %b, 1234
  %cmp1 = icmp eq i16 %and, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

define void @ctest32mi_zf(i32 noundef %a, ptr %ptr) {
; CHECK-LABEL: ctest32mi_zf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movzwl (%rsi), %eax
; CHECK-NEXT:    andl $12345, %eax # imm = 0x3039
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    ctestnew {dfv=zf} %ax, %ax
; CHECK-NEXT:    jne .LBB19_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB19_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest32mi_zf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testl %edi, %edi
; NDD-NEXT:    ctestnew {dfv=zf} $12345, (%rsi) # imm = 0x3039
; NDD-NEXT:    jne .LBB19_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB19_1: # %if.end
; NDD-NEXT:    retq
entry:
  %b = load i32, ptr %ptr
  %cmp = icmp eq i32 %a, 0
  %and = and i32 %b, 12345
  %cmp1 = icmp eq i32 %and, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

define void @ctest64mi32_zf(i64 noundef %a, ptr %ptr) {
; CHECK-LABEL: ctest64mi32_zf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testq %rdi, %rdi
; CHECK-NEXT:    ctestnel {dfv=zf} $123456, (%rsi) # imm = 0x1E240
; CHECK-NEXT:    jne .LBB20_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB20_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest64mi32_zf:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testq %rdi, %rdi
; NDD-NEXT:    ctestnel {dfv=zf} $123456, (%rsi) # imm = 0x1E240
; NDD-NEXT:    jne .LBB20_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB20_1: # %if.end
; NDD-NEXT:    retq
entry:
  %b = load i64, ptr %ptr
  %cmp = icmp eq i64 %a, 0
  %and = and i64 %b, 123456
  %cmp1 = icmp eq i64 %and, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

define void @ctest_continous(i32 noundef %a, i32 noundef %b, i32 noundef %c) {
; CHECK-LABEL: ctest_continous:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpl %esi, %edi
; CHECK-NEXT:    ctestll {dfv=} %esi, %esi
; CHECK-NEXT:    ctestnsl {dfv=sf} %edx, %edx
; CHECK-NEXT:    jns .LBB21_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB21_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest_continous:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    cmpl %esi, %edi
; NDD-NEXT:    ctestll {dfv=} %esi, %esi
; NDD-NEXT:    ctestnsl {dfv=sf} %edx, %edx
; NDD-NEXT:    jns .LBB21_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB21_1: # %if.end
; NDD-NEXT:    retq
entry:
  %cmp = icmp slt i32 %a, %b
  %cmp1 = icmp slt i32 %b, 0
  %or.cond = and i1 %cmp, %cmp1
  %cmp2 = icmp slt i32 %c, 0
  %or.cond3 = or i1 %or.cond, %cmp2
  br i1 %or.cond3, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

define i32 @ctest_nobranch(i32 noundef %a, i32 noundef %b) {
; CHECK-LABEL: ctest_nobranch:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    ctestlel {dfv=} %esi, %esi
; CHECK-NEXT:    setg %al
; CHECK-NEXT:    movzbl %al, %eax
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest_nobranch:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testl %edi, %edi
; NDD-NEXT:    ctestlel {dfv=} %esi, %esi
; NDD-NEXT:    setg %al
; NDD-NEXT:    movzbl %al, %eax
; NDD-NEXT:    retq
entry:
  %cmp = icmp sgt i32 %a, 0
  %cmp1 = icmp sgt i32 %b, 0
  %or.cond.not = or i1 %cmp, %cmp1
  %. = zext i1 %or.cond.not to i32
  ret i32 %.
}

define i32 @ctest_continous_nobranch(i32 noundef %a, i32 noundef %b, i32 noundef %c) {
; CHECK-LABEL: ctest_continous_nobranch:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    ctestlel {dfv=sf} %esi, %esi
; CHECK-NEXT:    ctestsl {dfv=zf} %edx, %edx
; CHECK-NEXT:    setg %al
; CHECK-NEXT:    movzbl %al, %eax
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest_continous_nobranch:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testl %edi, %edi
; NDD-NEXT:    ctestlel {dfv=sf} %esi, %esi
; NDD-NEXT:    ctestsl {dfv=zf} %edx, %edx
; NDD-NEXT:    setg %al
; NDD-NEXT:    movzbl %al, %eax
; NDD-NEXT:    retq
entry:
  %cmp = icmp sgt i32 %a, 0
  %cmp1 = icmp slt i32 %b, 0
  %cmp2 = icmp sgt i32 %c, 0
  %or1 = or i1 %cmp, %cmp1
  %or2 =  and i1 %or1, %cmp2
  %. = zext i1 %or2 to i32
  ret i32 %.
}

define void @ctest64ri64(i64 noundef %a, i64 noundef %b) {
; CHECK-LABEL: ctest64ri64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testq %rdi, %rdi
; CHECK-NEXT:    movabsq $9992147483647, %rax # imm = 0x9167A66BBFF
; CHECK-NEXT:    ctestneq {dfv=zf} %rax, %rsi
; CHECK-NEXT:    jne .LBB24_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:  .LBB24_1: # %if.end
; CHECK-NEXT:    retq
;
; NDD-LABEL: ctest64ri64:
; NDD:       # %bb.0: # %entry
; NDD-NEXT:    testq %rdi, %rdi
; NDD-NEXT:    movabsq $9992147483647, %rax # imm = 0x9167A66BBFF
; NDD-NEXT:    ctestneq {dfv=zf} %rax, %rsi
; NDD-NEXT:    jne .LBB24_1
; NDD-NEXT:  # %bb.2: # %if.then
; NDD-NEXT:    xorl %eax, %eax
; NDD-NEXT:    jmp foo # TAILCALL
; NDD-NEXT:  .LBB24_1: # %if.end
; NDD-NEXT:    retq
entry:
  %cmp = icmp eq i64 %a, 0
  %and = and i64 %b, 9992147483647
  %cmp1 = icmp eq i64 %and, 0
  %or.cond = or i1 %cmp, %cmp1
  br i1 %or.cond, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void (...) @foo()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

declare dso_local void @foo(...)