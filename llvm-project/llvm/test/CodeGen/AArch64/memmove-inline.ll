; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64 < %s | FileCheck %s --check-prefixes=CHECK,CHECK-ALIGNED
; RUN: llc -mtriple=aarch64 -mattr=+strict-align < %s | FileCheck %s --check-prefixes=CHECK,CHECK-UNALIGNED

; Small (16 bytes here) unaligned memmove() should be a function call if
; strict-alignment is turned on.
define void @t16(ptr %out, ptr %in) {
; CHECK-ALIGNED-LABEL: t16:
; CHECK-ALIGNED:       // %bb.0: // %entry
; CHECK-ALIGNED-NEXT:    ldr q0, [x1]
; CHECK-ALIGNED-NEXT:    str q0, [x0]
; CHECK-ALIGNED-NEXT:    ret
;
; CHECK-UNALIGNED-LABEL: t16:
; CHECK-UNALIGNED:       // %bb.0: // %entry
; CHECK-UNALIGNED-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-UNALIGNED-NEXT:    .cfi_def_cfa_offset 16
; CHECK-UNALIGNED-NEXT:    .cfi_offset w30, -16
; CHECK-UNALIGNED-NEXT:    mov w2, #16 // =0x10
; CHECK-UNALIGNED-NEXT:    bl memmove
; CHECK-UNALIGNED-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-UNALIGNED-NEXT:    ret
entry:
  call void @llvm.memmove.p0.p0.i64(ptr %out, ptr %in, i64 16, i1 false)
  ret void
}

; Small (16 bytes here) aligned memmove() should be inlined even if
; strict-alignment is turned on.
define void @t16_aligned(ptr align 8 %out, ptr align 8 %in) {
; CHECK-ALIGNED-LABEL: t16_aligned:
; CHECK-ALIGNED:       // %bb.0: // %entry
; CHECK-ALIGNED-NEXT:    ldr q0, [x1]
; CHECK-ALIGNED-NEXT:    str q0, [x0]
; CHECK-ALIGNED-NEXT:    ret
;
; CHECK-UNALIGNED-LABEL: t16_aligned:
; CHECK-UNALIGNED:       // %bb.0: // %entry
; CHECK-UNALIGNED-NEXT:    ldp x9, x8, [x1]
; CHECK-UNALIGNED-NEXT:    stp x9, x8, [x0]
; CHECK-UNALIGNED-NEXT:    ret
entry:
  call void @llvm.memmove.p0.p0.i64(ptr align 8 %out, ptr align 8 %in, i64 16, i1 false)
  ret void
}

; Tiny (4 bytes here) unaligned memmove() should be inlined with byte sized
; loads and stores if strict-alignment is turned on.
define void @t4(ptr %out, ptr %in) {
; CHECK-ALIGNED-LABEL: t4:
; CHECK-ALIGNED:       // %bb.0: // %entry
; CHECK-ALIGNED-NEXT:    ldr w8, [x1]
; CHECK-ALIGNED-NEXT:    str w8, [x0]
; CHECK-ALIGNED-NEXT:    ret
;
; CHECK-UNALIGNED-LABEL: t4:
; CHECK-UNALIGNED:       // %bb.0: // %entry
; CHECK-UNALIGNED-NEXT:    ldrb w8, [x1, #3]
; CHECK-UNALIGNED-NEXT:    ldrb w9, [x1, #2]
; CHECK-UNALIGNED-NEXT:    ldrb w10, [x1]
; CHECK-UNALIGNED-NEXT:    ldrb w11, [x1, #1]
; CHECK-UNALIGNED-NEXT:    strb w8, [x0, #3]
; CHECK-UNALIGNED-NEXT:    strb w9, [x0, #2]
; CHECK-UNALIGNED-NEXT:    strb w11, [x0, #1]
; CHECK-UNALIGNED-NEXT:    strb w10, [x0]
; CHECK-UNALIGNED-NEXT:    ret
entry:
  call void @llvm.memmove.p0.p0.i64(ptr %out, ptr %in, i64 4, i1 false)
  ret void
}

define void @t256(ptr %out, ptr %in) {
; CHECK-ALIGNED-LABEL: t256:
; CHECK-ALIGNED:       // %bb.0: // %entry
; CHECK-ALIGNED-NEXT:    ldp q0, q1, [x1]
; CHECK-ALIGNED-NEXT:    ldp q2, q3, [x1, #32]
; CHECK-ALIGNED-NEXT:    ldp q4, q5, [x1, #64]
; CHECK-ALIGNED-NEXT:    ldp q6, q7, [x1, #96]
; CHECK-ALIGNED-NEXT:    ldp q16, q17, [x1, #224]
; CHECK-ALIGNED-NEXT:    ldp q18, q19, [x1, #128]
; CHECK-ALIGNED-NEXT:    ldp q20, q21, [x1, #160]
; CHECK-ALIGNED-NEXT:    ldp q22, q23, [x1, #192]
; CHECK-ALIGNED-NEXT:    stp q0, q1, [x0]
; CHECK-ALIGNED-NEXT:    stp q2, q3, [x0, #32]
; CHECK-ALIGNED-NEXT:    stp q4, q5, [x0, #64]
; CHECK-ALIGNED-NEXT:    stp q6, q7, [x0, #96]
; CHECK-ALIGNED-NEXT:    stp q18, q19, [x0, #128]
; CHECK-ALIGNED-NEXT:    stp q20, q21, [x0, #160]
; CHECK-ALIGNED-NEXT:    stp q22, q23, [x0, #192]
; CHECK-ALIGNED-NEXT:    stp q16, q17, [x0, #224]
; CHECK-ALIGNED-NEXT:    ret
;
; CHECK-UNALIGNED-LABEL: t256:
; CHECK-UNALIGNED:       // %bb.0: // %entry
; CHECK-UNALIGNED-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-UNALIGNED-NEXT:    .cfi_def_cfa_offset 16
; CHECK-UNALIGNED-NEXT:    .cfi_offset w30, -16
; CHECK-UNALIGNED-NEXT:    mov w2, #256 // =0x100
; CHECK-UNALIGNED-NEXT:    bl memmove
; CHECK-UNALIGNED-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-UNALIGNED-NEXT:    ret
entry:
  call void @llvm.memmove.p0.p0.i64(ptr %out, ptr %in, i64 256, i1 false)
  ret void
}

define void @t257(ptr %out, ptr %in) {
; CHECK-LABEL: t257:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    mov w2, #257 // =0x101
; CHECK-NEXT:    bl memmove
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  call void @llvm.memmove.p0.p0.i64(ptr %out, ptr %in, i64 257, i1 false)
  ret void
}

declare void @llvm.memmove.p0.p0.i64(ptr nocapture, ptr nocapture readonly, i64, i1)