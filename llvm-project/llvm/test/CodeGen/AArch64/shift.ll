; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=aarch64 -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD
; RUN: llc -mtriple=aarch64 -global-isel -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-GI

define i1 @shl_i1(i1 %0, i1 %1){
; CHECK-SD-LABEL: shl_i1:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    and w0, w0, #0x1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: shl_i1:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    and w8, w1, #0x1
; CHECK-GI-NEXT:    lsl w8, w0, w8
; CHECK-GI-NEXT:    and w0, w8, #0x1
; CHECK-GI-NEXT:    ret
    %3 = shl i1 %0, %1
    ret i1 %3
}

define i8 @shl_i8(i8 %0, i8 %1){
; CHECK-SD-LABEL: shl_i8:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-SD-NEXT:    lsl w0, w0, w1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: shl_i8:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    and w8, w1, #0xff
; CHECK-GI-NEXT:    lsl w0, w0, w8
; CHECK-GI-NEXT:    ret
    %3 = shl i8 %0, %1
    ret i8 %3
}

define i16 @shl_i16(i16 %0, i16 %1){
; CHECK-SD-LABEL: shl_i16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-SD-NEXT:    lsl w0, w0, w1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: shl_i16:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    and w8, w1, #0xffff
; CHECK-GI-NEXT:    lsl w0, w0, w8
; CHECK-GI-NEXT:    ret
    %3 = shl i16 %0, %1
    ret i16 %3
}

define i32 @shl_i32(i32 %0, i32 %1){
; CHECK-LABEL: shl_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsl w0, w0, w1
; CHECK-NEXT:    ret
    %3 = shl i32 %0, %1
    ret i32 %3
}

define i64 @shl_i64(i64 %0, i64 %1){
; CHECK-LABEL: shl_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsl x0, x0, x1
; CHECK-NEXT:    ret
    %3 = shl i64 %0, %1
    ret i64 %3
}

define i128 @shl_i128(i128 %0, i128 %1){
; CHECK-SD-LABEL: shl_i128:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    lsr x8, x0, #1
; CHECK-SD-NEXT:    mvn w9, w2
; CHECK-SD-NEXT:    lsl x10, x1, x2
; CHECK-SD-NEXT:    tst x2, #0x40
; CHECK-SD-NEXT:    lsr x8, x8, x9
; CHECK-SD-NEXT:    lsl x9, x0, x2
; CHECK-SD-NEXT:    orr x8, x10, x8
; CHECK-SD-NEXT:    csel x0, xzr, x9, ne
; CHECK-SD-NEXT:    csel x1, x9, x8, ne
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: shl_i128:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    mov w8, #64 // =0x40
; CHECK-GI-NEXT:    sub x9, x2, #64
; CHECK-GI-NEXT:    lsl x10, x1, x2
; CHECK-GI-NEXT:    sub x8, x8, x2
; CHECK-GI-NEXT:    lsl x11, x0, x2
; CHECK-GI-NEXT:    lsl x9, x0, x9
; CHECK-GI-NEXT:    lsr x8, x0, x8
; CHECK-GI-NEXT:    cmp x2, #64
; CHECK-GI-NEXT:    csel x0, x11, xzr, lo
; CHECK-GI-NEXT:    orr x8, x8, x10
; CHECK-GI-NEXT:    csel x8, x8, x9, lo
; CHECK-GI-NEXT:    cmp x2, #0
; CHECK-GI-NEXT:    csel x1, x1, x8, eq
; CHECK-GI-NEXT:    ret
    %3 = shl i128 %0, %1
    ret i128 %3
}

define i1 @ashr_i1(i1 %0, i1 %1){
; CHECK-SD-LABEL: ashr_i1:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    and w0, w0, #0x1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: ashr_i1:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    sbfx w8, w0, #0, #1
; CHECK-GI-NEXT:    and w9, w1, #0x1
; CHECK-GI-NEXT:    asr w8, w8, w9
; CHECK-GI-NEXT:    and w0, w8, #0x1
; CHECK-GI-NEXT:    ret
    %3 = ashr i1 %0, %1
    ret i1 %3
}

define i8 @ashr_i8(i8 %0, i8 %1){
; CHECK-SD-LABEL: ashr_i8:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    sxtb w8, w0
; CHECK-SD-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-SD-NEXT:    asr w0, w8, w1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: ashr_i8:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    sxtb w8, w0
; CHECK-GI-NEXT:    and w9, w1, #0xff
; CHECK-GI-NEXT:    asr w0, w8, w9
; CHECK-GI-NEXT:    ret
    %3 = ashr i8 %0, %1
    ret i8 %3
}

define i16 @ashr_i16(i16 %0, i16 %1){
; CHECK-SD-LABEL: ashr_i16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    sxth w8, w0
; CHECK-SD-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-SD-NEXT:    asr w0, w8, w1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: ashr_i16:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    sxth w8, w0
; CHECK-GI-NEXT:    and w9, w1, #0xffff
; CHECK-GI-NEXT:    asr w0, w8, w9
; CHECK-GI-NEXT:    ret
    %3 = ashr i16 %0, %1
    ret i16 %3
}

define i32 @ashr_i32(i32 %0, i32 %1){
; CHECK-LABEL: ashr_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    asr w0, w0, w1
; CHECK-NEXT:    ret
    %3 = ashr i32 %0, %1
    ret i32 %3
}

define i64 @ashr_i64(i64 %0, i64 %1){
; CHECK-LABEL: ashr_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    asr x0, x0, x1
; CHECK-NEXT:    ret
    %3 = ashr i64 %0, %1
    ret i64 %3
}

define i128 @ashr_i128(i128 %0, i128 %1){
; CHECK-SD-LABEL: ashr_i128:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    lsl x8, x1, #1
; CHECK-SD-NEXT:    mvn w9, w2
; CHECK-SD-NEXT:    lsr x10, x0, x2
; CHECK-SD-NEXT:    asr x11, x1, #63
; CHECK-SD-NEXT:    tst x2, #0x40
; CHECK-SD-NEXT:    lsl x8, x8, x9
; CHECK-SD-NEXT:    asr x9, x1, x2
; CHECK-SD-NEXT:    orr x8, x8, x10
; CHECK-SD-NEXT:    csel x1, x11, x9, ne
; CHECK-SD-NEXT:    csel x0, x9, x8, ne
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: ashr_i128:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    mov w8, #64 // =0x40
; CHECK-GI-NEXT:    sub x9, x2, #64
; CHECK-GI-NEXT:    lsr x10, x0, x2
; CHECK-GI-NEXT:    sub x8, x8, x2
; CHECK-GI-NEXT:    asr x9, x1, x9
; CHECK-GI-NEXT:    cmp x2, #64
; CHECK-GI-NEXT:    lsl x8, x1, x8
; CHECK-GI-NEXT:    asr x11, x1, x2
; CHECK-GI-NEXT:    orr x8, x10, x8
; CHECK-GI-NEXT:    asr x10, x1, #63
; CHECK-GI-NEXT:    csel x8, x8, x9, lo
; CHECK-GI-NEXT:    cmp x2, #0
; CHECK-GI-NEXT:    csel x0, x0, x8, eq
; CHECK-GI-NEXT:    cmp x2, #64
; CHECK-GI-NEXT:    csel x1, x11, x10, lo
; CHECK-GI-NEXT:    ret
    %3 = ashr i128 %0, %1
    ret i128 %3
}

define i1 @lshr_i1(i1 %0, i1 %1){
; CHECK-SD-LABEL: lshr_i1:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    and w0, w0, #0x1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: lshr_i1:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    and w8, w1, #0x1
; CHECK-GI-NEXT:    and w9, w0, #0x1
; CHECK-GI-NEXT:    lsr w0, w9, w8
; CHECK-GI-NEXT:    ret
    %3 = lshr i1 %0, %1
    ret i1 %3
}

define i8 @lshr_i8(i8 %0, i8 %1){
; CHECK-SD-LABEL: lshr_i8:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    and w8, w0, #0xff
; CHECK-SD-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-SD-NEXT:    lsr w0, w8, w1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: lshr_i8:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    and w8, w1, #0xff
; CHECK-GI-NEXT:    and w9, w0, #0xff
; CHECK-GI-NEXT:    lsr w0, w9, w8
; CHECK-GI-NEXT:    ret
    %3 = lshr i8 %0, %1
    ret i8 %3
}

define i16 @lshr_i16(i16 %0, i16 %1){
; CHECK-SD-LABEL: lshr_i16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    and w8, w0, #0xffff
; CHECK-SD-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-SD-NEXT:    lsr w0, w8, w1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: lshr_i16:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    and w8, w1, #0xffff
; CHECK-GI-NEXT:    and w9, w0, #0xffff
; CHECK-GI-NEXT:    lsr w0, w9, w8
; CHECK-GI-NEXT:    ret
    %3 = lshr i16 %0, %1
    ret i16 %3
}

define i32 @lshr_i32(i32 %0, i32 %1){
; CHECK-LABEL: lshr_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsr w0, w0, w1
; CHECK-NEXT:    ret
    %3 = lshr i32 %0, %1
    ret i32 %3
}

define i64 @lshr_i64(i64 %0, i64 %1){
; CHECK-LABEL: lshr_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsr x0, x0, x1
; CHECK-NEXT:    ret
    %3 = lshr i64 %0, %1
    ret i64 %3
}

define i128 @lshr_i128(i128 %0, i128 %1){
; CHECK-SD-LABEL: lshr_i128:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    lsl x8, x1, #1
; CHECK-SD-NEXT:    mvn w9, w2
; CHECK-SD-NEXT:    lsr x10, x0, x2
; CHECK-SD-NEXT:    tst x2, #0x40
; CHECK-SD-NEXT:    lsl x8, x8, x9
; CHECK-SD-NEXT:    lsr x9, x1, x2
; CHECK-SD-NEXT:    orr x8, x8, x10
; CHECK-SD-NEXT:    csel x1, xzr, x9, ne
; CHECK-SD-NEXT:    csel x0, x9, x8, ne
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: lshr_i128:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    mov w8, #64 // =0x40
; CHECK-GI-NEXT:    sub x9, x2, #64
; CHECK-GI-NEXT:    lsr x10, x0, x2
; CHECK-GI-NEXT:    sub x8, x8, x2
; CHECK-GI-NEXT:    lsr x9, x1, x9
; CHECK-GI-NEXT:    cmp x2, #64
; CHECK-GI-NEXT:    lsl x8, x1, x8
; CHECK-GI-NEXT:    orr x8, x10, x8
; CHECK-GI-NEXT:    lsr x10, x1, x2
; CHECK-GI-NEXT:    csel x8, x8, x9, lo
; CHECK-GI-NEXT:    cmp x2, #0
; CHECK-GI-NEXT:    csel x0, x0, x8, eq
; CHECK-GI-NEXT:    cmp x2, #64
; CHECK-GI-NEXT:    csel x1, x10, xzr, lo
; CHECK-GI-NEXT:    ret
    %3 = lshr i128 %0, %1
    ret i128 %3
}

; ===== Legal Vector Type =====

define <8 x i8> @shl_v8i8(<8 x i8> %0, <8 x i8> %1){
; CHECK-LABEL: shl_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushl v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    ret
    %3 = shl <8 x i8> %0, %1
    ret <8 x i8> %3
}

define <16 x i8> @shl_v16i8(<16 x i8> %0, <16 x i8> %1){
; CHECK-LABEL: shl_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushl v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
    %3 = shl <16 x i8> %0, %1
    ret <16 x i8> %3
}

define <4 x i16> @shl_v4i16(<4 x i16> %0, <4 x i16> %1){
; CHECK-LABEL: shl_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushl v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
    %3 = shl <4 x i16> %0, %1
    ret <4 x i16> %3
}

define <8 x i16> @shl_v8i16(<8 x i16> %0, <8 x i16> %1){
; CHECK-LABEL: shl_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushl v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
    %3 = shl <8 x i16> %0, %1
    ret <8 x i16> %3
}

define <2 x i32> @shl_v2i32(<2 x i32> %0, <2 x i32> %1){
; CHECK-LABEL: shl_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushl v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
    %3 = shl <2 x i32> %0, %1
    ret <2 x i32> %3
}

define <4 x i32> @shl_v4i32(<4 x i32> %0, <4 x i32> %1){
; CHECK-LABEL: shl_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushl v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
    %3 = shl <4 x i32> %0, %1
    ret <4 x i32> %3
}

define <2 x i64> @shl_v2i64(<2 x i64> %0, <2 x i64> %1){
; CHECK-LABEL: shl_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushl v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
    %3 = shl <2 x i64> %0, %1
    ret <2 x i64> %3
}

define <8 x i8> @ashr_v8i8(<8 x i8> %0, <8 x i8> %1){
; CHECK-LABEL: ashr_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.8b, v1.8b
; CHECK-NEXT:    sshl v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    ret
    %3 = ashr <8 x i8> %0, %1
    ret <8 x i8> %3
}

define <16 x i8> @ashr_v16i8(<16 x i8> %0, <16 x i8> %1){
; CHECK-LABEL: ashr_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.16b, v1.16b
; CHECK-NEXT:    sshl v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
    %3 = ashr <16 x i8> %0, %1
    ret <16 x i8> %3
}

define <4 x i16> @ashr_v4i16(<4 x i16> %0, <4 x i16> %1){
; CHECK-LABEL: ashr_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.4h, v1.4h
; CHECK-NEXT:    sshl v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
    %3 = ashr <4 x i16> %0, %1
    ret <4 x i16> %3
}

define <8 x i16> @ashr_v8i16(<8 x i16> %0, <8 x i16> %1){
; CHECK-LABEL: ashr_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.8h, v1.8h
; CHECK-NEXT:    sshl v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
    %3 = ashr <8 x i16> %0, %1
    ret <8 x i16> %3
}

define <2 x i32> @ashr_v2i32(<2 x i32> %0, <2 x i32> %1){
; CHECK-LABEL: ashr_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.2s, v1.2s
; CHECK-NEXT:    sshl v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
    %3 = ashr <2 x i32> %0, %1
    ret <2 x i32> %3
}

define <4 x i32> @ashr_v4i32(<4 x i32> %0, <4 x i32> %1){
; CHECK-LABEL: ashr_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.4s, v1.4s
; CHECK-NEXT:    sshl v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
    %3 = ashr <4 x i32> %0, %1
    ret <4 x i32> %3
}

define <2 x i64> @ashr_v2i64(<2 x i64> %0, <2 x i64> %1){
; CHECK-LABEL: ashr_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.2d, v1.2d
; CHECK-NEXT:    sshl v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
    %3 = ashr <2 x i64> %0, %1
    ret <2 x i64> %3
}

define <8 x i8> @lshr_v8i8(<8 x i8> %0, <8 x i8> %1){
; CHECK-LABEL: lshr_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.8b, v1.8b
; CHECK-NEXT:    ushl v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    ret
    %3 = lshr <8 x i8> %0, %1
    ret <8 x i8> %3
}

define <16 x i8> @lshr_v16i8(<16 x i8> %0, <16 x i8> %1){
; CHECK-LABEL: lshr_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.16b, v1.16b
; CHECK-NEXT:    ushl v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
    %3 = lshr <16 x i8> %0, %1
    ret <16 x i8> %3
}

define <4 x i16> @lshr_v4i16(<4 x i16> %0, <4 x i16> %1){
; CHECK-LABEL: lshr_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.4h, v1.4h
; CHECK-NEXT:    ushl v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
    %3 = lshr <4 x i16> %0, %1
    ret <4 x i16> %3
}

define <8 x i16> @lshr_v8i16(<8 x i16> %0, <8 x i16> %1){
; CHECK-LABEL: lshr_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.8h, v1.8h
; CHECK-NEXT:    ushl v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
    %3 = lshr <8 x i16> %0, %1
    ret <8 x i16> %3
}

define <2 x i32> @lshr_v2i32(<2 x i32> %0, <2 x i32> %1){
; CHECK-LABEL: lshr_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.2s, v1.2s
; CHECK-NEXT:    ushl v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
    %3 = lshr <2 x i32> %0, %1
    ret <2 x i32> %3
}

define <4 x i32> @lshr_v4i32(<4 x i32> %0, <4 x i32> %1){
; CHECK-LABEL: lshr_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.4s, v1.4s
; CHECK-NEXT:    ushl v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
    %3 = lshr <4 x i32> %0, %1
    ret <4 x i32> %3
}

define <2 x i64> @lshr_v2i64(<2 x i64> %0, <2 x i64> %1){
; CHECK-LABEL: lshr_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.2d, v1.2d
; CHECK-NEXT:    ushl v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
    %3 = lshr <2 x i64> %0, %1
    ret <2 x i64> %3
}

; ===== Vector Larger/Smaller than Legal =====

define <4 x i8> @shl_v4i8(<4 x i8> %0, <4 x i8> %1){
; CHECK-SD-LABEL: shl_v4i8:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    bic v1.4h, #255, lsl #8
; CHECK-SD-NEXT:    ushl v0.4h, v0.4h, v1.4h
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: shl_v4i8:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    uzp1 v0.8b, v0.8b, v0.8b
; CHECK-GI-NEXT:    uzp1 v1.8b, v1.8b, v0.8b
; CHECK-GI-NEXT:    ushl v0.8b, v0.8b, v1.8b
; CHECK-GI-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
    %3 = shl <4 x i8> %0, %1
    ret <4 x i8> %3
}

define <32 x i8> @shl_v32i8(<32 x i8> %0, <32 x i8> %1){
; CHECK-SD-LABEL: shl_v32i8:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    ushl v1.16b, v1.16b, v3.16b
; CHECK-SD-NEXT:    ushl v0.16b, v0.16b, v2.16b
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: shl_v32i8:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    ushl v0.16b, v0.16b, v2.16b
; CHECK-GI-NEXT:    ushl v1.16b, v1.16b, v3.16b
; CHECK-GI-NEXT:    ret
    %3 = shl <32 x i8> %0, %1
    ret <32 x i8> %3
}

define <2 x i16> @shl_v2i16(<2 x i16> %0, <2 x i16> %1){
; CHECK-SD-LABEL: shl_v2i16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    movi d2, #0x00ffff0000ffff
; CHECK-SD-NEXT:    and v1.8b, v1.8b, v2.8b
; CHECK-SD-NEXT:    ushl v0.2s, v0.2s, v1.2s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: shl_v2i16:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    uzp1 v0.4h, v0.4h, v0.4h
; CHECK-GI-NEXT:    uzp1 v1.4h, v1.4h, v0.4h
; CHECK-GI-NEXT:    ushl v0.4h, v0.4h, v1.4h
; CHECK-GI-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
    %3 = shl <2 x i16> %0, %1
    ret <2 x i16> %3
}

define <16 x i16> @shl_v16i16(<16 x i16> %0, <16 x i16> %1){
; CHECK-SD-LABEL: shl_v16i16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    ushl v1.8h, v1.8h, v3.8h
; CHECK-SD-NEXT:    ushl v0.8h, v0.8h, v2.8h
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: shl_v16i16:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    ushl v0.8h, v0.8h, v2.8h
; CHECK-GI-NEXT:    ushl v1.8h, v1.8h, v3.8h
; CHECK-GI-NEXT:    ret
    %3 = shl <16 x i16> %0, %1
    ret <16 x i16> %3
}

define <1 x i32> @shl_v1i32(<1 x i32> %0, <1 x i32> %1){
; CHECK-SD-LABEL: shl_v1i32:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    ushl v0.2s, v0.2s, v1.2s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: shl_v1i32:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    fmov w8, s0
; CHECK-GI-NEXT:    fmov w9, s1
; CHECK-GI-NEXT:    lsl w8, w8, w9
; CHECK-GI-NEXT:    mov v0.s[0], w8
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
    %3 = shl <1 x i32> %0, %1
    ret <1 x i32> %3
}

define <8 x i32> @shl_v8i32(<8 x i32> %0, <8 x i32> %1){
; CHECK-SD-LABEL: shl_v8i32:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    ushl v1.4s, v1.4s, v3.4s
; CHECK-SD-NEXT:    ushl v0.4s, v0.4s, v2.4s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: shl_v8i32:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    ushl v0.4s, v0.4s, v2.4s
; CHECK-GI-NEXT:    ushl v1.4s, v1.4s, v3.4s
; CHECK-GI-NEXT:    ret
    %3 = shl <8 x i32> %0, %1
    ret <8 x i32> %3
}

define <4 x i64> @shl_v4i64(<4 x i64> %0, <4 x i64> %1){
; CHECK-SD-LABEL: shl_v4i64:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    ushl v1.2d, v1.2d, v3.2d
; CHECK-SD-NEXT:    ushl v0.2d, v0.2d, v2.2d
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: shl_v4i64:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    ushl v0.2d, v0.2d, v2.2d
; CHECK-GI-NEXT:    ushl v1.2d, v1.2d, v3.2d
; CHECK-GI-NEXT:    ret
    %3 = shl <4 x i64> %0, %1
    ret <4 x i64> %3
}

define <2 x i128> @shl_v2i128(<2 x i128> %0, <2 x i128> %1){
; CHECK-SD-LABEL: shl_v2i128:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    lsr x8, x0, #1
; CHECK-SD-NEXT:    mvn w9, w4
; CHECK-SD-NEXT:    lsl x10, x1, x4
; CHECK-SD-NEXT:    mvn w12, w6
; CHECK-SD-NEXT:    lsl x11, x0, x4
; CHECK-SD-NEXT:    lsl x13, x3, x6
; CHECK-SD-NEXT:    lsr x8, x8, x9
; CHECK-SD-NEXT:    lsr x9, x2, #1
; CHECK-SD-NEXT:    tst x4, #0x40
; CHECK-SD-NEXT:    csel x0, xzr, x11, ne
; CHECK-SD-NEXT:    lsr x9, x9, x12
; CHECK-SD-NEXT:    orr x8, x10, x8
; CHECK-SD-NEXT:    lsl x10, x2, x6
; CHECK-SD-NEXT:    csel x1, x11, x8, ne
; CHECK-SD-NEXT:    tst x6, #0x40
; CHECK-SD-NEXT:    orr x8, x13, x9
; CHECK-SD-NEXT:    csel x2, xzr, x10, ne
; CHECK-SD-NEXT:    csel x3, x10, x8, ne
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: shl_v2i128:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    mov w8, #64 // =0x40
; CHECK-GI-NEXT:    sub x10, x4, #64
; CHECK-GI-NEXT:    lsl x11, x1, x4
; CHECK-GI-NEXT:    sub x9, x8, x4
; CHECK-GI-NEXT:    lsl x10, x0, x10
; CHECK-GI-NEXT:    lsl x12, x0, x4
; CHECK-GI-NEXT:    lsr x9, x0, x9
; CHECK-GI-NEXT:    cmp x4, #64
; CHECK-GI-NEXT:    sub x8, x8, x6
; CHECK-GI-NEXT:    lsr x8, x2, x8
; CHECK-GI-NEXT:    csel x0, x12, xzr, lo
; CHECK-GI-NEXT:    lsl x12, x2, x6
; CHECK-GI-NEXT:    orr x9, x9, x11
; CHECK-GI-NEXT:    lsl x11, x3, x6
; CHECK-GI-NEXT:    csel x9, x9, x10, lo
; CHECK-GI-NEXT:    sub x10, x6, #64
; CHECK-GI-NEXT:    cmp x4, #0
; CHECK-GI-NEXT:    lsl x10, x2, x10
; CHECK-GI-NEXT:    csel x1, x1, x9, eq
; CHECK-GI-NEXT:    orr x8, x8, x11
; CHECK-GI-NEXT:    cmp x6, #64
; CHECK-GI-NEXT:    csel x2, x12, xzr, lo
; CHECK-GI-NEXT:    csel x8, x8, x10, lo
; CHECK-GI-NEXT:    cmp x6, #0
; CHECK-GI-NEXT:    csel x3, x3, x8, eq
; CHECK-GI-NEXT:    ret
    %3 = shl <2 x i128> %0, %1
    ret <2 x i128> %3
}

define <4 x i8> @ashr_v4i8(<4 x i8> %0, <4 x i8> %1){
; CHECK-SD-LABEL: ashr_v4i8:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    shl v0.4h, v0.4h, #8
; CHECK-SD-NEXT:    bic v1.4h, #255, lsl #8
; CHECK-SD-NEXT:    sshr v0.4h, v0.4h, #8
; CHECK-SD-NEXT:    neg v1.4h, v1.4h
; CHECK-SD-NEXT:    sshl v0.4h, v0.4h, v1.4h
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: ashr_v4i8:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    uzp1 v1.8b, v1.8b, v0.8b
; CHECK-GI-NEXT:    uzp1 v0.8b, v0.8b, v0.8b
; CHECK-GI-NEXT:    neg v1.8b, v1.8b
; CHECK-GI-NEXT:    sshl v0.8b, v0.8b, v1.8b
; CHECK-GI-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
    %3 = ashr <4 x i8> %0, %1
    ret <4 x i8> %3
}

define <32 x i8> @ashr_v32i8(<32 x i8> %0, <32 x i8> %1){
; CHECK-LABEL: ashr_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v2.16b, v2.16b
; CHECK-NEXT:    neg v3.16b, v3.16b
; CHECK-NEXT:    sshl v0.16b, v0.16b, v2.16b
; CHECK-NEXT:    sshl v1.16b, v1.16b, v3.16b
; CHECK-NEXT:    ret
    %3 = ashr <32 x i8> %0, %1
    ret <32 x i8> %3
}

define <2 x i16> @ashr_v2i16(<2 x i16> %0, <2 x i16> %1){
; CHECK-SD-LABEL: ashr_v2i16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    movi d2, #0x00ffff0000ffff
; CHECK-SD-NEXT:    shl v0.2s, v0.2s, #16
; CHECK-SD-NEXT:    sshr v0.2s, v0.2s, #16
; CHECK-SD-NEXT:    and v1.8b, v1.8b, v2.8b
; CHECK-SD-NEXT:    neg v1.2s, v1.2s
; CHECK-SD-NEXT:    sshl v0.2s, v0.2s, v1.2s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: ashr_v2i16:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    uzp1 v1.4h, v1.4h, v0.4h
; CHECK-GI-NEXT:    uzp1 v0.4h, v0.4h, v0.4h
; CHECK-GI-NEXT:    neg v1.4h, v1.4h
; CHECK-GI-NEXT:    sshl v0.4h, v0.4h, v1.4h
; CHECK-GI-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
    %3 = ashr <2 x i16> %0, %1
    ret <2 x i16> %3
}

define <16 x i16> @ashr_v16i16(<16 x i16> %0, <16 x i16> %1){
; CHECK-LABEL: ashr_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v2.8h, v2.8h
; CHECK-NEXT:    neg v3.8h, v3.8h
; CHECK-NEXT:    sshl v0.8h, v0.8h, v2.8h
; CHECK-NEXT:    sshl v1.8h, v1.8h, v3.8h
; CHECK-NEXT:    ret
    %3 = ashr <16 x i16> %0, %1
    ret <16 x i16> %3
}

define <1 x i32> @ashr_v1i32(<1 x i32> %0, <1 x i32> %1){
; CHECK-SD-LABEL: ashr_v1i32:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    neg v1.2s, v1.2s
; CHECK-SD-NEXT:    sshl v0.2s, v0.2s, v1.2s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: ashr_v1i32:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    fmov w8, s0
; CHECK-GI-NEXT:    fmov w9, s1
; CHECK-GI-NEXT:    asr w8, w8, w9
; CHECK-GI-NEXT:    mov v0.s[0], w8
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
    %3 = ashr <1 x i32> %0, %1
    ret <1 x i32> %3
}

define <8 x i32> @ashr_v8i32(<8 x i32> %0, <8 x i32> %1){
; CHECK-LABEL: ashr_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v2.4s, v2.4s
; CHECK-NEXT:    neg v3.4s, v3.4s
; CHECK-NEXT:    sshl v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    sshl v1.4s, v1.4s, v3.4s
; CHECK-NEXT:    ret
    %3 = ashr <8 x i32> %0, %1
    ret <8 x i32> %3
}

define <4 x i64> @ashr_v4i64(<4 x i64> %0, <4 x i64> %1){
; CHECK-LABEL: ashr_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v2.2d, v2.2d
; CHECK-NEXT:    neg v3.2d, v3.2d
; CHECK-NEXT:    sshl v0.2d, v0.2d, v2.2d
; CHECK-NEXT:    sshl v1.2d, v1.2d, v3.2d
; CHECK-NEXT:    ret
    %3 = ashr <4 x i64> %0, %1
    ret <4 x i64> %3
}

define <2 x i128> @ashr_v2i128(<2 x i128> %0, <2 x i128> %1){
; CHECK-SD-LABEL: ashr_v2i128:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    lsl x8, x1, #1
; CHECK-SD-NEXT:    mvn w9, w4
; CHECK-SD-NEXT:    lsl x10, x3, #1
; CHECK-SD-NEXT:    lsr x11, x0, x4
; CHECK-SD-NEXT:    lsr x12, x2, x6
; CHECK-SD-NEXT:    asr x13, x1, #63
; CHECK-SD-NEXT:    lsl x8, x8, x9
; CHECK-SD-NEXT:    mvn w9, w6
; CHECK-SD-NEXT:    tst x4, #0x40
; CHECK-SD-NEXT:    lsl x9, x10, x9
; CHECK-SD-NEXT:    asr x10, x1, x4
; CHECK-SD-NEXT:    asr x14, x3, #63
; CHECK-SD-NEXT:    orr x8, x8, x11
; CHECK-SD-NEXT:    asr x11, x3, x6
; CHECK-SD-NEXT:    csel x0, x10, x8, ne
; CHECK-SD-NEXT:    orr x8, x9, x12
; CHECK-SD-NEXT:    csel x1, x13, x10, ne
; CHECK-SD-NEXT:    tst x6, #0x40
; CHECK-SD-NEXT:    csel x2, x11, x8, ne
; CHECK-SD-NEXT:    csel x3, x14, x11, ne
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: ashr_v2i128:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    mov w8, #64 // =0x40
; CHECK-GI-NEXT:    sub x10, x4, #64
; CHECK-GI-NEXT:    lsr x11, x0, x4
; CHECK-GI-NEXT:    sub x9, x8, x4
; CHECK-GI-NEXT:    asr x10, x1, x10
; CHECK-GI-NEXT:    cmp x4, #64
; CHECK-GI-NEXT:    lsl x9, x1, x9
; CHECK-GI-NEXT:    sub x8, x8, x6
; CHECK-GI-NEXT:    asr x12, x1, x4
; CHECK-GI-NEXT:    lsl x8, x3, x8
; CHECK-GI-NEXT:    orr x9, x11, x9
; CHECK-GI-NEXT:    asr x11, x1, #63
; CHECK-GI-NEXT:    csel x9, x9, x10, lo
; CHECK-GI-NEXT:    cmp x4, #0
; CHECK-GI-NEXT:    lsr x10, x2, x6
; CHECK-GI-NEXT:    csel x0, x0, x9, eq
; CHECK-GI-NEXT:    sub x9, x6, #64
; CHECK-GI-NEXT:    cmp x4, #64
; CHECK-GI-NEXT:    asr x9, x3, x9
; CHECK-GI-NEXT:    csel x1, x12, x11, lo
; CHECK-GI-NEXT:    orr x8, x10, x8
; CHECK-GI-NEXT:    cmp x6, #64
; CHECK-GI-NEXT:    asr x11, x3, x6
; CHECK-GI-NEXT:    asr x10, x3, #63
; CHECK-GI-NEXT:    csel x8, x8, x9, lo
; CHECK-GI-NEXT:    cmp x6, #0
; CHECK-GI-NEXT:    csel x2, x2, x8, eq
; CHECK-GI-NEXT:    cmp x6, #64
; CHECK-GI-NEXT:    csel x3, x11, x10, lo
; CHECK-GI-NEXT:    ret
    %3 = ashr <2 x i128> %0, %1
    ret <2 x i128> %3
}

define <4 x i8> @lshr_v4i8(<4 x i8> %0, <4 x i8> %1){
; CHECK-SD-LABEL: lshr_v4i8:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    bic v1.4h, #255, lsl #8
; CHECK-SD-NEXT:    bic v0.4h, #255, lsl #8
; CHECK-SD-NEXT:    neg v1.4h, v1.4h
; CHECK-SD-NEXT:    ushl v0.4h, v0.4h, v1.4h
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: lshr_v4i8:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    uzp1 v1.8b, v1.8b, v0.8b
; CHECK-GI-NEXT:    uzp1 v0.8b, v0.8b, v0.8b
; CHECK-GI-NEXT:    neg v1.8b, v1.8b
; CHECK-GI-NEXT:    ushl v0.8b, v0.8b, v1.8b
; CHECK-GI-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
    %3 = lshr <4 x i8> %0, %1
    ret <4 x i8> %3
}

define <32 x i8> @lshr_v32i8(<32 x i8> %0, <32 x i8> %1){
; CHECK-LABEL: lshr_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v2.16b, v2.16b
; CHECK-NEXT:    neg v3.16b, v3.16b
; CHECK-NEXT:    ushl v0.16b, v0.16b, v2.16b
; CHECK-NEXT:    ushl v1.16b, v1.16b, v3.16b
; CHECK-NEXT:    ret
    %3 = lshr <32 x i8> %0, %1
    ret <32 x i8> %3
}

define <2 x i16> @lshr_v2i16(<2 x i16> %0, <2 x i16> %1){
; CHECK-SD-LABEL: lshr_v2i16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    movi d2, #0x00ffff0000ffff
; CHECK-SD-NEXT:    and v1.8b, v1.8b, v2.8b
; CHECK-SD-NEXT:    and v0.8b, v0.8b, v2.8b
; CHECK-SD-NEXT:    neg v1.2s, v1.2s
; CHECK-SD-NEXT:    ushl v0.2s, v0.2s, v1.2s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: lshr_v2i16:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    uzp1 v1.4h, v1.4h, v0.4h
; CHECK-GI-NEXT:    uzp1 v0.4h, v0.4h, v0.4h
; CHECK-GI-NEXT:    neg v1.4h, v1.4h
; CHECK-GI-NEXT:    ushl v0.4h, v0.4h, v1.4h
; CHECK-GI-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
    %3 = lshr <2 x i16> %0, %1
    ret <2 x i16> %3
}

define <16 x i16> @lshr_v16i16(<16 x i16> %0, <16 x i16> %1){
; CHECK-LABEL: lshr_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v2.8h, v2.8h
; CHECK-NEXT:    neg v3.8h, v3.8h
; CHECK-NEXT:    ushl v0.8h, v0.8h, v2.8h
; CHECK-NEXT:    ushl v1.8h, v1.8h, v3.8h
; CHECK-NEXT:    ret
    %3 = lshr <16 x i16> %0, %1
    ret <16 x i16> %3
}

define <1 x i32> @lshr_v1i32(<1 x i32> %0, <1 x i32> %1){
; CHECK-SD-LABEL: lshr_v1i32:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    neg v1.2s, v1.2s
; CHECK-SD-NEXT:    ushl v0.2s, v0.2s, v1.2s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: lshr_v1i32:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    fmov w8, s0
; CHECK-GI-NEXT:    fmov w9, s1
; CHECK-GI-NEXT:    lsr w8, w8, w9
; CHECK-GI-NEXT:    mov v0.s[0], w8
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
    %3 = lshr <1 x i32> %0, %1
    ret <1 x i32> %3
}

define <8 x i32> @lshr_v8i32(<8 x i32> %0, <8 x i32> %1){
; CHECK-LABEL: lshr_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v2.4s, v2.4s
; CHECK-NEXT:    neg v3.4s, v3.4s
; CHECK-NEXT:    ushl v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    ushl v1.4s, v1.4s, v3.4s
; CHECK-NEXT:    ret
    %3 = lshr <8 x i32> %0, %1
    ret <8 x i32> %3
}

define <4 x i64> @lshr_v4i64(<4 x i64> %0, <4 x i64> %1){
; CHECK-LABEL: lshr_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v2.2d, v2.2d
; CHECK-NEXT:    neg v3.2d, v3.2d
; CHECK-NEXT:    ushl v0.2d, v0.2d, v2.2d
; CHECK-NEXT:    ushl v1.2d, v1.2d, v3.2d
; CHECK-NEXT:    ret
    %3 = lshr <4 x i64> %0, %1
    ret <4 x i64> %3
}

define <2 x i128> @lshr_v2i128(<2 x i128> %0, <2 x i128> %1){
; CHECK-SD-LABEL: lshr_v2i128:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    lsl x8, x1, #1
; CHECK-SD-NEXT:    mvn w9, w4
; CHECK-SD-NEXT:    lsr x10, x0, x4
; CHECK-SD-NEXT:    mvn w12, w6
; CHECK-SD-NEXT:    lsr x11, x1, x4
; CHECK-SD-NEXT:    lsr x13, x2, x6
; CHECK-SD-NEXT:    lsl x8, x8, x9
; CHECK-SD-NEXT:    lsl x9, x3, #1
; CHECK-SD-NEXT:    tst x4, #0x40
; CHECK-SD-NEXT:    csel x1, xzr, x11, ne
; CHECK-SD-NEXT:    lsl x9, x9, x12
; CHECK-SD-NEXT:    orr x8, x8, x10
; CHECK-SD-NEXT:    lsr x10, x3, x6
; CHECK-SD-NEXT:    csel x0, x11, x8, ne
; CHECK-SD-NEXT:    tst x6, #0x40
; CHECK-SD-NEXT:    orr x8, x9, x13
; CHECK-SD-NEXT:    csel x3, xzr, x10, ne
; CHECK-SD-NEXT:    csel x2, x10, x8, ne
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: lshr_v2i128:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    mov w8, #64 // =0x40
; CHECK-GI-NEXT:    sub x10, x4, #64
; CHECK-GI-NEXT:    lsr x11, x0, x4
; CHECK-GI-NEXT:    sub x9, x8, x4
; CHECK-GI-NEXT:    lsr x10, x1, x10
; CHECK-GI-NEXT:    cmp x4, #64
; CHECK-GI-NEXT:    lsl x9, x1, x9
; CHECK-GI-NEXT:    sub x8, x8, x6
; CHECK-GI-NEXT:    lsr x12, x1, x4
; CHECK-GI-NEXT:    lsl x8, x3, x8
; CHECK-GI-NEXT:    orr x9, x11, x9
; CHECK-GI-NEXT:    lsr x11, x2, x6
; CHECK-GI-NEXT:    csel x9, x9, x10, lo
; CHECK-GI-NEXT:    cmp x4, #0
; CHECK-GI-NEXT:    sub x10, x6, #64
; CHECK-GI-NEXT:    csel x0, x0, x9, eq
; CHECK-GI-NEXT:    cmp x4, #64
; CHECK-GI-NEXT:    lsr x9, x3, x10
; CHECK-GI-NEXT:    csel x1, x12, xzr, lo
; CHECK-GI-NEXT:    orr x8, x11, x8
; CHECK-GI-NEXT:    cmp x6, #64
; CHECK-GI-NEXT:    lsr x10, x3, x6
; CHECK-GI-NEXT:    csel x8, x8, x9, lo
; CHECK-GI-NEXT:    cmp x6, #0
; CHECK-GI-NEXT:    csel x2, x2, x8, eq
; CHECK-GI-NEXT:    cmp x6, #64
; CHECK-GI-NEXT:    csel x3, x10, xzr, lo
; CHECK-GI-NEXT:    ret
    %3 = lshr <2 x i128> %0, %1
    ret <2 x i128> %3
}

; ===== Vector with Non-Pow 2 Width =====

define <3 x i8> @shl_v3i8(<3 x i8> %0, <3 x i8> %1){
; CHECK-SD-LABEL: shl_v3i8:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    fmov s0, w3
; CHECK-SD-NEXT:    fmov s1, w0
; CHECK-SD-NEXT:    mov v0.h[1], w4
; CHECK-SD-NEXT:    mov v1.h[1], w1
; CHECK-SD-NEXT:    mov v0.h[2], w5
; CHECK-SD-NEXT:    mov v1.h[2], w2
; CHECK-SD-NEXT:    bic v0.4h, #255, lsl #8
; CHECK-SD-NEXT:    ushl v0.4h, v1.4h, v0.4h
; CHECK-SD-NEXT:    umov w0, v0.h[0]
; CHECK-SD-NEXT:    umov w1, v0.h[1]
; CHECK-SD-NEXT:    umov w2, v0.h[2]
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: shl_v3i8:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    fmov s0, w0
; CHECK-GI-NEXT:    fmov s1, w3
; CHECK-GI-NEXT:    mov v0.b[1], w1
; CHECK-GI-NEXT:    mov v1.b[1], w4
; CHECK-GI-NEXT:    mov v0.b[2], w2
; CHECK-GI-NEXT:    mov v1.b[2], w5
; CHECK-GI-NEXT:    ushl v0.8b, v0.8b, v1.8b
; CHECK-GI-NEXT:    umov w0, v0.b[0]
; CHECK-GI-NEXT:    umov w1, v0.b[1]
; CHECK-GI-NEXT:    umov w2, v0.b[2]
; CHECK-GI-NEXT:    ret
    %3 = shl <3 x i8> %0, %1
    ret <3 x i8> %3
}

define <7 x i8> @shl_v7i8(<7 x i8> %0, <7 x i8> %1){
; CHECK-LABEL: shl_v7i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushl v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    ret
    %3 = shl <7 x i8> %0, %1
    ret <7 x i8> %3
}

define <3 x i16> @shl_v3i16(<3 x i16> %0, <3 x i16> %1){
; CHECK-LABEL: shl_v3i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushl v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
    %3 = shl <3 x i16> %0, %1
    ret <3 x i16> %3
}

define <7 x i16> @shl_v7i16(<7 x i16> %0, <7 x i16> %1){
; CHECK-LABEL: shl_v7i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushl v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
    %3 = shl <7 x i16> %0, %1
    ret <7 x i16> %3
}

define <3 x i32> @shl_v3i32(<3 x i32> %0, <3 x i32> %1){
; CHECK-LABEL: shl_v3i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushl v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
    %3 = shl <3 x i32> %0, %1
    ret <3 x i32> %3
}

define <3 x i8> @ashr_v3i8(<3 x i8> %0, <3 x i8> %1){
; CHECK-SD-LABEL: ashr_v3i8:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    fmov s0, w0
; CHECK-SD-NEXT:    fmov s1, w3
; CHECK-SD-NEXT:    mov v0.h[1], w1
; CHECK-SD-NEXT:    mov v1.h[1], w4
; CHECK-SD-NEXT:    mov v0.h[2], w2
; CHECK-SD-NEXT:    mov v1.h[2], w5
; CHECK-SD-NEXT:    shl v0.4h, v0.4h, #8
; CHECK-SD-NEXT:    bic v1.4h, #255, lsl #8
; CHECK-SD-NEXT:    sshr v0.4h, v0.4h, #8
; CHECK-SD-NEXT:    neg v1.4h, v1.4h
; CHECK-SD-NEXT:    sshl v0.4h, v0.4h, v1.4h
; CHECK-SD-NEXT:    umov w0, v0.h[0]
; CHECK-SD-NEXT:    umov w1, v0.h[1]
; CHECK-SD-NEXT:    umov w2, v0.h[2]
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: ashr_v3i8:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    fmov s0, w3
; CHECK-GI-NEXT:    fmov s1, w0
; CHECK-GI-NEXT:    mov v0.b[1], w4
; CHECK-GI-NEXT:    mov v1.b[1], w1
; CHECK-GI-NEXT:    mov v0.b[2], w5
; CHECK-GI-NEXT:    mov v1.b[2], w2
; CHECK-GI-NEXT:    neg v0.8b, v0.8b
; CHECK-GI-NEXT:    sshl v0.8b, v1.8b, v0.8b
; CHECK-GI-NEXT:    umov w0, v0.b[0]
; CHECK-GI-NEXT:    umov w1, v0.b[1]
; CHECK-GI-NEXT:    umov w2, v0.b[2]
; CHECK-GI-NEXT:    ret
    %3 = ashr <3 x i8> %0, %1
    ret <3 x i8> %3
}

define <7 x i8> @ashr_v7i8(<7 x i8> %0, <7 x i8> %1){
; CHECK-LABEL: ashr_v7i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.8b, v1.8b
; CHECK-NEXT:    sshl v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    ret
    %3 = ashr <7 x i8> %0, %1
    ret <7 x i8> %3
}

define <3 x i16> @ashr_v3i16(<3 x i16> %0, <3 x i16> %1){
; CHECK-LABEL: ashr_v3i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.4h, v1.4h
; CHECK-NEXT:    sshl v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
    %3 = ashr <3 x i16> %0, %1
    ret <3 x i16> %3
}

define <7 x i16> @ashr_v7i16(<7 x i16> %0, <7 x i16> %1){
; CHECK-LABEL: ashr_v7i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.8h, v1.8h
; CHECK-NEXT:    sshl v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
    %3 = ashr <7 x i16> %0, %1
    ret <7 x i16> %3
}

define <3 x i32> @ashr_v3i32(<3 x i32> %0, <3 x i32> %1){
; CHECK-LABEL: ashr_v3i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.4s, v1.4s
; CHECK-NEXT:    sshl v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
    %3 = ashr <3 x i32> %0, %1
    ret <3 x i32> %3
}

define <3 x i8> @lshr_v3i8(<3 x i8> %0, <3 x i8> %1){
; CHECK-SD-LABEL: lshr_v3i8:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    fmov s0, w3
; CHECK-SD-NEXT:    fmov s1, w0
; CHECK-SD-NEXT:    mov v0.h[1], w4
; CHECK-SD-NEXT:    mov v1.h[1], w1
; CHECK-SD-NEXT:    mov v0.h[2], w5
; CHECK-SD-NEXT:    mov v1.h[2], w2
; CHECK-SD-NEXT:    bic v0.4h, #255, lsl #8
; CHECK-SD-NEXT:    bic v1.4h, #255, lsl #8
; CHECK-SD-NEXT:    neg v0.4h, v0.4h
; CHECK-SD-NEXT:    ushl v0.4h, v1.4h, v0.4h
; CHECK-SD-NEXT:    umov w0, v0.h[0]
; CHECK-SD-NEXT:    umov w1, v0.h[1]
; CHECK-SD-NEXT:    umov w2, v0.h[2]
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: lshr_v3i8:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    fmov s0, w3
; CHECK-GI-NEXT:    fmov s1, w0
; CHECK-GI-NEXT:    mov v0.b[1], w4
; CHECK-GI-NEXT:    mov v1.b[1], w1
; CHECK-GI-NEXT:    mov v0.b[2], w5
; CHECK-GI-NEXT:    mov v1.b[2], w2
; CHECK-GI-NEXT:    neg v0.8b, v0.8b
; CHECK-GI-NEXT:    ushl v0.8b, v1.8b, v0.8b
; CHECK-GI-NEXT:    umov w0, v0.b[0]
; CHECK-GI-NEXT:    umov w1, v0.b[1]
; CHECK-GI-NEXT:    umov w2, v0.b[2]
; CHECK-GI-NEXT:    ret
    %3 = lshr <3 x i8> %0, %1
    ret <3 x i8> %3
}

define <7 x i8> @lshr_v7i8(<7 x i8> %0, <7 x i8> %1){
; CHECK-LABEL: lshr_v7i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.8b, v1.8b
; CHECK-NEXT:    ushl v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    ret
    %3 = lshr <7 x i8> %0, %1
    ret <7 x i8> %3
}

define <3 x i16> @lshr_v3i16(<3 x i16> %0, <3 x i16> %1){
; CHECK-LABEL: lshr_v3i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.4h, v1.4h
; CHECK-NEXT:    ushl v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
    %3 = lshr <3 x i16> %0, %1
    ret <3 x i16> %3
}

define <7 x i16> @lshr_v7i16(<7 x i16> %0, <7 x i16> %1){
; CHECK-LABEL: lshr_v7i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.8h, v1.8h
; CHECK-NEXT:    ushl v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
    %3 = lshr <7 x i16> %0, %1
    ret <7 x i16> %3
}

define <3 x i32> @lshr_v3i32(<3 x i32> %0, <3 x i32> %1){
; CHECK-LABEL: lshr_v3i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg v1.4s, v1.4s
; CHECK-NEXT:    ushl v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
    %3 = lshr <3 x i32> %0, %1
    ret <3 x i32> %3
}

; TODO:
; ===== Vector with Odd Element Sizes =====