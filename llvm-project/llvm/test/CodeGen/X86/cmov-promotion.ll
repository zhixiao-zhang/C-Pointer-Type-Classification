; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+cmov | FileCheck %s --check-prefix=CMOV
; RUN: llc < %s -mtriple=i686-unknown-unknown   -mattr=-cmov | FileCheck %s --check-prefix=NO_CMOV

define i16 @cmov_zpromotion_8_to_16(i1 %c) {
; CMOV-LABEL: cmov_zpromotion_8_to_16:
; CMOV:       # %bb.0:
; CMOV-NEXT:    testb $1, %dil
; CMOV-NEXT:    movl $117, %ecx
; CMOV-NEXT:    movl $237, %eax
; CMOV-NEXT:    cmovnel %ecx, %eax
; CMOV-NEXT:    # kill: def $ax killed $ax killed $eax
; CMOV-NEXT:    retq
;
; NO_CMOV-LABEL: cmov_zpromotion_8_to_16:
; NO_CMOV:       # %bb.0:
; NO_CMOV-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; NO_CMOV-NEXT:    andl $1, %eax
; NO_CMOV-NEXT:    negl %eax
; NO_CMOV-NEXT:    andl $152, %eax
; NO_CMOV-NEXT:    xorl $237, %eax
; NO_CMOV-NEXT:    # kill: def $ax killed $ax killed $eax
; NO_CMOV-NEXT:    retl
  %t0 = select i1 %c, i8 117, i8 -19
  %ret = zext i8 %t0 to i16
  ret i16 %ret
}

define i32 @cmov_zpromotion_8_to_32(i1 %c) {
; CMOV-LABEL: cmov_zpromotion_8_to_32:
; CMOV:       # %bb.0:
; CMOV-NEXT:    testb $1, %dil
; CMOV-NEXT:    movl $126, %ecx
; CMOV-NEXT:    movl $255, %eax
; CMOV-NEXT:    cmovnel %ecx, %eax
; CMOV-NEXT:    retq
;
; NO_CMOV-LABEL: cmov_zpromotion_8_to_32:
; NO_CMOV:       # %bb.0:
; NO_CMOV-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; NO_CMOV-NEXT:    andl $1, %eax
; NO_CMOV-NEXT:    negl %eax
; NO_CMOV-NEXT:    andl $129, %eax
; NO_CMOV-NEXT:    xorl $255, %eax
; NO_CMOV-NEXT:    retl
  %t0 = select i1 %c, i8 12414, i8 -1
  %ret = zext i8 %t0 to i32
  ret i32 %ret
}

define i64 @cmov_zpromotion_8_to_64(i1 %c) {
; CMOV-LABEL: cmov_zpromotion_8_to_64:
; CMOV:       # %bb.0:
; CMOV-NEXT:    testb $1, %dil
; CMOV-NEXT:    movl $126, %ecx
; CMOV-NEXT:    movl $255, %eax
; CMOV-NEXT:    cmovneq %rcx, %rax
; CMOV-NEXT:    retq
;
; NO_CMOV-LABEL: cmov_zpromotion_8_to_64:
; NO_CMOV:       # %bb.0:
; NO_CMOV-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; NO_CMOV-NEXT:    andl $1, %eax
; NO_CMOV-NEXT:    negl %eax
; NO_CMOV-NEXT:    andl $129, %eax
; NO_CMOV-NEXT:    xorl $255, %eax
; NO_CMOV-NEXT:    xorl %edx, %edx
; NO_CMOV-NEXT:    retl
  %t0 = select i1 %c, i8 12414, i8 -1
  %ret = zext i8 %t0 to i64
  ret i64 %ret
}

define i32 @cmov_zpromotion_16_to_32(i1 %c) {
; CMOV-LABEL: cmov_zpromotion_16_to_32:
; CMOV:       # %bb.0:
; CMOV-NEXT:    testb $1, %dil
; CMOV-NEXT:    movl $12414, %ecx # imm = 0x307E
; CMOV-NEXT:    movl $65535, %eax # imm = 0xFFFF
; CMOV-NEXT:    cmovnel %ecx, %eax
; CMOV-NEXT:    retq
;
; NO_CMOV-LABEL: cmov_zpromotion_16_to_32:
; NO_CMOV:       # %bb.0:
; NO_CMOV-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; NO_CMOV-NEXT:    andl $1, %eax
; NO_CMOV-NEXT:    negl %eax
; NO_CMOV-NEXT:    andl $53121, %eax # imm = 0xCF81
; NO_CMOV-NEXT:    xorl $65535, %eax # imm = 0xFFFF
; NO_CMOV-NEXT:    retl
  %t0 = select i1 %c, i16 12414, i16 -1
  %ret = zext i16 %t0 to i32
  ret i32 %ret
}

define i64 @cmov_zpromotion_16_to_64(i1 %c) {
; CMOV-LABEL: cmov_zpromotion_16_to_64:
; CMOV:       # %bb.0:
; CMOV-NEXT:    testb $1, %dil
; CMOV-NEXT:    movl $12414, %ecx # imm = 0x307E
; CMOV-NEXT:    movl $65535, %eax # imm = 0xFFFF
; CMOV-NEXT:    cmovneq %rcx, %rax
; CMOV-NEXT:    retq
;
; NO_CMOV-LABEL: cmov_zpromotion_16_to_64:
; NO_CMOV:       # %bb.0:
; NO_CMOV-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; NO_CMOV-NEXT:    andl $1, %eax
; NO_CMOV-NEXT:    negl %eax
; NO_CMOV-NEXT:    andl $53121, %eax # imm = 0xCF81
; NO_CMOV-NEXT:    xorl $65535, %eax # imm = 0xFFFF
; NO_CMOV-NEXT:    xorl %edx, %edx
; NO_CMOV-NEXT:    retl
  %t0 = select i1 %c, i16 12414, i16 -1
  %ret = zext i16 %t0 to i64
  ret i64 %ret
}

define i64 @cmov_zpromotion_32_to_64(i1 %c) {
; CMOV-LABEL: cmov_zpromotion_32_to_64:
; CMOV:       # %bb.0:
; CMOV-NEXT:    testb $1, %dil
; CMOV-NEXT:    movl $12414, %ecx # imm = 0x307E
; CMOV-NEXT:    movl $43107, %eax # imm = 0xA863
; CMOV-NEXT:    cmovnel %ecx, %eax
; CMOV-NEXT:    retq
;
; NO_CMOV-LABEL: cmov_zpromotion_32_to_64:
; NO_CMOV:       # %bb.0:
; NO_CMOV-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; NO_CMOV-NEXT:    andl $1, %eax
; NO_CMOV-NEXT:    negl %eax
; NO_CMOV-NEXT:    andl $38941, %eax # imm = 0x981D
; NO_CMOV-NEXT:    xorl $43107, %eax # imm = 0xA863
; NO_CMOV-NEXT:    xorl %edx, %edx
; NO_CMOV-NEXT:    retl
  %t0 = select i1 %c, i32 12414, i32 43107
  %ret = zext i32 %t0 to i64
  ret i64 %ret
}

define i16 @cmov_spromotion_8_to_16(i1 %c) {
; CMOV-LABEL: cmov_spromotion_8_to_16:
; CMOV:       # %bb.0:
; CMOV-NEXT:    testb $1, %dil
; CMOV-NEXT:    movl $117, %ecx
; CMOV-NEXT:    movl $65517, %eax # imm = 0xFFED
; CMOV-NEXT:    cmovnel %ecx, %eax
; CMOV-NEXT:    # kill: def $ax killed $ax killed $eax
; CMOV-NEXT:    retq
;
; NO_CMOV-LABEL: cmov_spromotion_8_to_16:
; NO_CMOV:       # %bb.0:
; NO_CMOV-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; NO_CMOV-NEXT:    andl $1, %eax
; NO_CMOV-NEXT:    negl %eax
; NO_CMOV-NEXT:    andl $-104, %eax
; NO_CMOV-NEXT:    xorl $65517, %eax # imm = 0xFFED
; NO_CMOV-NEXT:    # kill: def $ax killed $ax killed $eax
; NO_CMOV-NEXT:    retl
  %t0 = select i1 %c, i8 117, i8 -19
  %ret = sext i8 %t0 to i16
  ret i16 %ret
}

define i32 @cmov_spromotion_8_to_32(i1 %c) {
; CMOV-LABEL: cmov_spromotion_8_to_32:
; CMOV:       # %bb.0:
; CMOV-NEXT:    testb $1, %dil
; CMOV-NEXT:    movl $126, %ecx
; CMOV-NEXT:    movl $99, %eax
; CMOV-NEXT:    cmovnel %ecx, %eax
; CMOV-NEXT:    retq
;
; NO_CMOV-LABEL: cmov_spromotion_8_to_32:
; NO_CMOV:       # %bb.0:
; NO_CMOV-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; NO_CMOV-NEXT:    andl $1, %eax
; NO_CMOV-NEXT:    negl %eax
; NO_CMOV-NEXT:    andl $29, %eax
; NO_CMOV-NEXT:    xorl $99, %eax
; NO_CMOV-NEXT:    retl
  %t0 = select i1 %c, i8 12414, i8 43107
  %ret = sext i8 %t0 to i32
  ret i32 %ret
}

define i64 @cmov_spromotion_8_to_64(i1 %c) {
; CMOV-LABEL: cmov_spromotion_8_to_64:
; CMOV:       # %bb.0:
; CMOV-NEXT:    testb $1, %dil
; CMOV-NEXT:    movl $126, %ecx
; CMOV-NEXT:    movl $99, %eax
; CMOV-NEXT:    cmovneq %rcx, %rax
; CMOV-NEXT:    retq
;
; NO_CMOV-LABEL: cmov_spromotion_8_to_64:
; NO_CMOV:       # %bb.0:
; NO_CMOV-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; NO_CMOV-NEXT:    andl $1, %eax
; NO_CMOV-NEXT:    negl %eax
; NO_CMOV-NEXT:    andl $29, %eax
; NO_CMOV-NEXT:    xorl $99, %eax
; NO_CMOV-NEXT:    xorl %edx, %edx
; NO_CMOV-NEXT:    retl
  %t0 = select i1 %c, i8 12414, i8 43107
  %ret = sext i8 %t0 to i64
  ret i64 %ret
}

define i32 @cmov_spromotion_16_to_32(i1 %c) {
; CMOV-LABEL: cmov_spromotion_16_to_32:
; CMOV:       # %bb.0:
; CMOV-NEXT:    testb $1, %dil
; CMOV-NEXT:    movl $12414, %ecx # imm = 0x307E
; CMOV-NEXT:    movl $-22429, %eax # imm = 0xA863
; CMOV-NEXT:    cmovnel %ecx, %eax
; CMOV-NEXT:    retq
;
; NO_CMOV-LABEL: cmov_spromotion_16_to_32:
; NO_CMOV:       # %bb.0:
; NO_CMOV-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; NO_CMOV-NEXT:    andl $1, %eax
; NO_CMOV-NEXT:    negl %eax
; NO_CMOV-NEXT:    andl $-26595, %eax # imm = 0x981D
; NO_CMOV-NEXT:    xorl $-22429, %eax # imm = 0xA863
; NO_CMOV-NEXT:    retl
  %t0 = select i1 %c, i16 12414, i16 43107
  %ret = sext i16 %t0 to i32
  ret i32 %ret
}

define i64 @cmov_spromotion_16_to_64(i1 %c) {
; CMOV-LABEL: cmov_spromotion_16_to_64:
; CMOV:       # %bb.0:
; CMOV-NEXT:    testb $1, %dil
; CMOV-NEXT:    movl $12414, %ecx # imm = 0x307E
; CMOV-NEXT:    movq $-22429, %rax # imm = 0xA863
; CMOV-NEXT:    cmovneq %rcx, %rax
; CMOV-NEXT:    retq
;
; NO_CMOV-LABEL: cmov_spromotion_16_to_64:
; NO_CMOV:       # %bb.0:
; NO_CMOV-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; NO_CMOV-NEXT:    andl $1, %eax
; NO_CMOV-NEXT:    leal -1(%eax), %edx
; NO_CMOV-NEXT:    negl %eax
; NO_CMOV-NEXT:    andl $-26595, %eax # imm = 0x981D
; NO_CMOV-NEXT:    xorl $-22429, %eax # imm = 0xA863
; NO_CMOV-NEXT:    retl
  %t0 = select i1 %c, i16 12414, i16 43107
  %ret = sext i16 %t0 to i64
  ret i64 %ret
}

define i64 @cmov_spromotion_32_to_64(i1 %c) {
; CMOV-LABEL: cmov_spromotion_32_to_64:
; CMOV:       # %bb.0:
; CMOV-NEXT:    testb $1, %dil
; CMOV-NEXT:    movl $12414, %ecx # imm = 0x307E
; CMOV-NEXT:    movl $43107, %eax # imm = 0xA863
; CMOV-NEXT:    cmovneq %rcx, %rax
; CMOV-NEXT:    retq
;
; NO_CMOV-LABEL: cmov_spromotion_32_to_64:
; NO_CMOV:       # %bb.0:
; NO_CMOV-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; NO_CMOV-NEXT:    andl $1, %eax
; NO_CMOV-NEXT:    negl %eax
; NO_CMOV-NEXT:    andl $38941, %eax # imm = 0x981D
; NO_CMOV-NEXT:    xorl $43107, %eax # imm = 0xA863
; NO_CMOV-NEXT:    xorl %edx, %edx
; NO_CMOV-NEXT:    retl
  %t0 = select i1 %c, i32 12414, i32 43107
  %ret = sext i32 %t0 to i64
  ret i64 %ret
}