; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=mipsisa32r6-unknown-linux-gnu -verify-machineinstrs -o - %s | FileCheck %s


define i1 @isnan_float(float %x) nounwind {
; CHECK-LABEL: isnan_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.s $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 3
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f32(float %x, i32 3)  ; nan
  ret i1 %1
}

define i1 @isnan_double(double %x) nounwind {
; CHECK-LABEL: isnan_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.d $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 3
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f64(double %x, i32 3)  ; nan
  ret i1 %1
}

define i1 @isnan_float_strictfp(float %x) strictfp nounwind {
; CHECK-LABEL: isnan_float_strictfp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.s $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 3
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f32(float %x, i32 3) strictfp ; nan
  ret i1 %1
}

define i1 @isnan_double_strictfp(double %x) strictfp nounwind {
; CHECK-LABEL: isnan_double_strictfp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.d $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 3
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f64(double %x, i32 3) strictfp ; nan
  ret i1 %1
}

define i1 @isinf_float(float %x) nounwind {
; CHECK-LABEL: isinf_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.s $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 68
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f32(float %x, i32 516)  ; 0x204 = "inf"
  ret i1 %1
}

define i1 @isfinite_float(float %x) nounwind {
; CHECK-LABEL: isfinite_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.s $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 952
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f32(float %x, i32 504)  ; 0x1f8 = "finite"
  ret i1 %1
}

define i1 @isnormal_float(float %x) nounwind {
; CHECK-LABEL: isnormal_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.s $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 136
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f32(float %x, i32 264)  ; 0x108 = "normal"
  ret i1 %1
}

define i1 @issubnormal_float(float %x) nounwind {
; CHECK-LABEL: issubnormal_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.s $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 272
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f32(float %x, i32 144)  ; 0x90 = "subnormal"
  ret i1 %1
}

define i1 @iszero_float(float %x) nounwind {
; CHECK-LABEL: iszero_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.s $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 544
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f32(float %x, i32 96)  ; 0x60 = "zero"
  ret i1 %1
}

define i1 @issnan_float(float %x) nounwind {
; CHECK-LABEL: issnan_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.s $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 1
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f32(float %x, i32 1)
  ret i1 %1
}

define i1 @issnan_double(double %x) nounwind {
; CHECK-LABEL: issnan_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.d $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 1
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f64(double %x, i32 1)
  ret i1 %1
}

define i1 @isqnan_float(float %x) nounwind {
; CHECK-LABEL: isqnan_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.s $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 2
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f32(float %x, i32 2)
  ret i1 %1
}

define i1 @isqnan_double(double %x) nounwind {
; CHECK-LABEL: isqnan_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.d $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 2
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f64(double %x, i32 2)
  ret i1 %1
}

define i1 @isposzero_double(double %x) nounwind {
; CHECK-LABEL: isposzero_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.d $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 512
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f64(double %x, i32 64)
  ret i1 %1
}

define i1 @isnegzero_double(double %x) nounwind {
; CHECK-LABEL: isnegzero_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.d $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 32
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f64(double %x, i32 32)
  ret i1 %1
}

define i1 @isposnormal_double(double %x) nounwind {
; CHECK-LABEL: isposnormal_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.d $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 128
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f64(double %x, i32 256)
  ret i1 %1
}

define i1 @isnegnormal_double(double %x) nounwind {
; CHECK-LABEL: isnegnormal_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.d $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 8
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f64(double %x, i32 8)
  ret i1 %1
}

define i1 @isnormal_double(double %x) nounwind {
; CHECK-LABEL: isnormal_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.d $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 136
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f64(double %x, i32 264)
  ret i1 %1
}

define i1 @isclass_00d_double(double %x) nounwind {
; CHECK-LABEL: isclass_00d_double:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.d $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 13
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f64(double %x, i32 13)
  ret i1 %1
}

define i1 @isclass_1c0_float(float %x) nounwind {
; CHECK-LABEL: isclass_1c0_float:
; CHECK:       # %bb.0:
; CHECK-NEXT:    class.s $f0, $f12
; CHECK-NEXT:    mfc1 $1, $f0
; CHECK-NEXT:    andi $1, $1, 896
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    sltu $2, $zero, $1
  %1 = call i1 @llvm.is.fpclass.f32(float %x, i32 448)
  ret i1 %1
}

declare i1 @llvm.is.fpclass.f32(float, i32)
declare i1 @llvm.is.fpclass.f64(double, i32)