; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=mipsel-linux-gnu < %s | FileCheck %s -check-prefix=CHECK-LIBCALL

define void @test_fadd(ptr %p, ptr %q) nounwind {
; CHECK-LIBCALL-LABEL: test_fadd:
; CHECK-LIBCALL:       # %bb.0:
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, -40
; CHECK-LIBCALL-NEXT:    sdc1 $f20, 32($sp) # 8-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $ra, 28($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $17, 24($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $16, 20($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    move $17, $4
; CHECK-LIBCALL-NEXT:    lhu $4, 0($4)
; CHECK-LIBCALL-NEXT:    jal __gnu_h2f_ieee
; CHECK-LIBCALL-NEXT:    move $16, $5
; CHECK-LIBCALL-NEXT:    lhu $4, 0($16)
; CHECK-LIBCALL-NEXT:    jal __gnu_h2f_ieee
; CHECK-LIBCALL-NEXT:    mov.s $f20, $f0
; CHECK-LIBCALL-NEXT:    jal __gnu_f2h_ieee
; CHECK-LIBCALL-NEXT:    add.s $f12, $f20, $f0
; CHECK-LIBCALL-NEXT:    sh $2, 0($17)
; CHECK-LIBCALL-NEXT:    lw $16, 20($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $17, 24($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $ra, 28($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    ldc1 $f20, 32($sp) # 8-byte Folded Reload
; CHECK-LIBCALL-NEXT:    jr $ra
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, 40
  %a = load half, ptr %p, align 2
  %b = load half, ptr %q, align 2
  %r = fadd half %a, %b
  store half %r, ptr %p
  ret void
}

define float @test_fpext_float(ptr %p) nounwind {
; CHECK-LIBCALL-LABEL: test_fpext_float:
; CHECK-LIBCALL:       # %bb.0:
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, -24
; CHECK-LIBCALL-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    lhu $4, 0($4)
; CHECK-LIBCALL-NEXT:    jal __gnu_h2f_ieee
; CHECK-LIBCALL-NEXT:    nop
; CHECK-LIBCALL-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    jr $ra
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, 24
  %a = load half, ptr %p, align 2
  %r = fpext half %a to float
  ret float %r
}

define double @test_fpext_double(ptr %p) nounwind {
; CHECK-LIBCALL-LABEL: test_fpext_double:
; CHECK-LIBCALL:       # %bb.0:
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, -24
; CHECK-LIBCALL-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    lhu $4, 0($4)
; CHECK-LIBCALL-NEXT:    jal __gnu_h2f_ieee
; CHECK-LIBCALL-NEXT:    nop
; CHECK-LIBCALL-NEXT:    cvt.d.s $f0, $f0
; CHECK-LIBCALL-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    jr $ra
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, 24
  %a = load half, ptr %p, align 2
  %r = fpext half %a to double
  ret double %r
}

define void @test_fptrunc_float(float %f, ptr %p) nounwind {
; CHECK-LIBCALL-LABEL: test_fptrunc_float:
; CHECK-LIBCALL:       # %bb.0:
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, -24
; CHECK-LIBCALL-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $16, 16($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    jal __gnu_f2h_ieee
; CHECK-LIBCALL-NEXT:    move $16, $5
; CHECK-LIBCALL-NEXT:    sh $2, 0($16)
; CHECK-LIBCALL-NEXT:    lw $16, 16($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    jr $ra
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, 24
  %a = fptrunc float %f to half
  store half %a, ptr %p
  ret void
}

define void @test_fptrunc_double(double %d, ptr %p) nounwind {
; CHECK-LIBCALL-LABEL: test_fptrunc_double:
; CHECK-LIBCALL:       # %bb.0:
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, -24
; CHECK-LIBCALL-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $16, 16($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    jal __truncdfhf2
; CHECK-LIBCALL-NEXT:    move $16, $6
; CHECK-LIBCALL-NEXT:    sh $2, 0($16)
; CHECK-LIBCALL-NEXT:    lw $16, 16($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    jr $ra
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, 24
  %a = fptrunc double %d to half
  store half %a, ptr %p
  ret void
}

define <4 x float> @test_vec_fpext_float(ptr %p) nounwind {
; CHECK-LIBCALL-LABEL: test_vec_fpext_float:
; CHECK-LIBCALL:       # %bb.0:
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, -32
; CHECK-LIBCALL-NEXT:    sw $ra, 28($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $17, 24($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $16, 20($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    move $17, $4
; CHECK-LIBCALL-NEXT:    lhu $4, 6($5)
; CHECK-LIBCALL-NEXT:    jal __gnu_h2f_ieee
; CHECK-LIBCALL-NEXT:    move $16, $5
; CHECK-LIBCALL-NEXT:    lhu $4, 4($16)
; CHECK-LIBCALL-NEXT:    jal __gnu_h2f_ieee
; CHECK-LIBCALL-NEXT:    swc1 $f0, 12($17)
; CHECK-LIBCALL-NEXT:    swc1 $f0, 8($17)
; CHECK-LIBCALL-NEXT:    lhu $4, 2($16)
; CHECK-LIBCALL-NEXT:    jal __gnu_h2f_ieee
; CHECK-LIBCALL-NEXT:    nop
; CHECK-LIBCALL-NEXT:    swc1 $f0, 4($17)
; CHECK-LIBCALL-NEXT:    lhu $4, 0($16)
; CHECK-LIBCALL-NEXT:    jal __gnu_h2f_ieee
; CHECK-LIBCALL-NEXT:    nop
; CHECK-LIBCALL-NEXT:    swc1 $f0, 0($17)
; CHECK-LIBCALL-NEXT:    lw $16, 20($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $17, 24($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $ra, 28($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    jr $ra
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, 32
  %a = load <4 x half>, ptr %p, align 8
  %b = fpext <4 x half> %a to <4 x float>
  ret <4 x float> %b
}

define <4 x double> @test_vec_fpext_double(ptr %p) nounwind {
; CHECK-LIBCALL-LABEL: test_vec_fpext_double:
; CHECK-LIBCALL:       # %bb.0:
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, -40
; CHECK-LIBCALL-NEXT:    sdc1 $f20, 32($sp) # 8-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $ra, 28($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $17, 24($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $16, 20($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    move $17, $4
; CHECK-LIBCALL-NEXT:    lhu $4, 6($5)
; CHECK-LIBCALL-NEXT:    jal __gnu_h2f_ieee
; CHECK-LIBCALL-NEXT:    move $16, $5
; CHECK-LIBCALL-NEXT:    lhu $4, 4($16)
; CHECK-LIBCALL-NEXT:    jal __gnu_h2f_ieee
; CHECK-LIBCALL-NEXT:    mov.s $f20, $f0
; CHECK-LIBCALL-NEXT:    lhu $4, 2($16)
; CHECK-LIBCALL-NEXT:    cvt.d.s $f0, $f0
; CHECK-LIBCALL-NEXT:    cvt.d.s $f2, $f20
; CHECK-LIBCALL-NEXT:    sdc1 $f2, 24($17)
; CHECK-LIBCALL-NEXT:    jal __gnu_h2f_ieee
; CHECK-LIBCALL-NEXT:    sdc1 $f0, 16($17)
; CHECK-LIBCALL-NEXT:    cvt.d.s $f0, $f0
; CHECK-LIBCALL-NEXT:    sdc1 $f0, 8($17)
; CHECK-LIBCALL-NEXT:    lhu $4, 0($16)
; CHECK-LIBCALL-NEXT:    jal __gnu_h2f_ieee
; CHECK-LIBCALL-NEXT:    nop
; CHECK-LIBCALL-NEXT:    cvt.d.s $f0, $f0
; CHECK-LIBCALL-NEXT:    sdc1 $f0, 0($17)
; CHECK-LIBCALL-NEXT:    lw $16, 20($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $17, 24($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $ra, 28($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    ldc1 $f20, 32($sp) # 8-byte Folded Reload
; CHECK-LIBCALL-NEXT:    jr $ra
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, 40
  %a = load <4 x half>, ptr %p, align 8
  %b = fpext <4 x half> %a to <4 x double>
  ret <4 x double> %b
}

define void @test_vec_fptrunc_float(<4 x float> %a, ptr %p) nounwind {
; CHECK-LIBCALL-LABEL: test_vec_fptrunc_float:
; CHECK-LIBCALL:       # %bb.0:
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, -40
; CHECK-LIBCALL-NEXT:    sw $ra, 36($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $19, 32($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $18, 28($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $17, 24($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $16, 20($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    move $16, $7
; CHECK-LIBCALL-NEXT:    move $17, $5
; CHECK-LIBCALL-NEXT:    move $18, $4
; CHECK-LIBCALL-NEXT:    jal __gnu_f2h_ieee
; CHECK-LIBCALL-NEXT:    mtc1 $6, $f12
; CHECK-LIBCALL-NEXT:    move $19, $2
; CHECK-LIBCALL-NEXT:    jal __gnu_f2h_ieee
; CHECK-LIBCALL-NEXT:    mtc1 $16, $f12
; CHECK-LIBCALL-NEXT:    mtc1 $17, $f12
; CHECK-LIBCALL-NEXT:    lw $16, 56($sp)
; CHECK-LIBCALL-NEXT:    sh $2, 6($16)
; CHECK-LIBCALL-NEXT:    jal __gnu_f2h_ieee
; CHECK-LIBCALL-NEXT:    sh $19, 4($16)
; CHECK-LIBCALL-NEXT:    sh $2, 2($16)
; CHECK-LIBCALL-NEXT:    jal __gnu_f2h_ieee
; CHECK-LIBCALL-NEXT:    mtc1 $18, $f12
; CHECK-LIBCALL-NEXT:    sh $2, 0($16)
; CHECK-LIBCALL-NEXT:    lw $16, 20($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $17, 24($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $18, 28($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $19, 32($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $ra, 36($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    jr $ra
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, 40
  %b = fptrunc <4 x float> %a to <4 x half>
  store <4 x half> %b, ptr %p, align 8
  ret void
}

define void @test_vec_fptrunc_double(<4 x double> %a, ptr %p) nounwind {
; CHECK-LIBCALL-LABEL: test_vec_fptrunc_double:
; CHECK-LIBCALL:       # %bb.0:
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, -72
; CHECK-LIBCALL-NEXT:    sw $ra, 68($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $19, 64($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $18, 60($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $17, 56($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    sw $16, 52($sp) # 4-byte Folded Spill
; CHECK-LIBCALL-NEXT:    move $16, $5
; CHECK-LIBCALL-NEXT:    move $17, $4
; CHECK-LIBCALL-NEXT:    lw $1, 92($sp)
; CHECK-LIBCALL-NEXT:    sw $1, 36($sp)
; CHECK-LIBCALL-NEXT:    lw $1, 88($sp)
; CHECK-LIBCALL-NEXT:    sw $1, 32($sp)
; CHECK-LIBCALL-NEXT:    lw $1, 96($sp)
; CHECK-LIBCALL-NEXT:    lw $2, 100($sp)
; CHECK-LIBCALL-NEXT:    sw $2, 44($sp)
; CHECK-LIBCALL-NEXT:    sw $1, 40($sp)
; CHECK-LIBCALL-NEXT:    ldc1 $f12, 32($sp)
; CHECK-LIBCALL-NEXT:    sw $7, 28($sp)
; CHECK-LIBCALL-NEXT:    jal __truncdfhf2
; CHECK-LIBCALL-NEXT:    sw $6, 24($sp)
; CHECK-LIBCALL-NEXT:    move $18, $2
; CHECK-LIBCALL-NEXT:    jal __truncdfhf2
; CHECK-LIBCALL-NEXT:    ldc1 $f12, 40($sp)
; CHECK-LIBCALL-NEXT:    ldc1 $f12, 24($sp)
; CHECK-LIBCALL-NEXT:    lw $19, 104($sp)
; CHECK-LIBCALL-NEXT:    sh $2, 6($19)
; CHECK-LIBCALL-NEXT:    jal __truncdfhf2
; CHECK-LIBCALL-NEXT:    sh $18, 4($19)
; CHECK-LIBCALL-NEXT:    sh $2, 2($19)
; CHECK-LIBCALL-NEXT:    sw $16, 20($sp)
; CHECK-LIBCALL-NEXT:    sw $17, 16($sp)
; CHECK-LIBCALL-NEXT:    jal __truncdfhf2
; CHECK-LIBCALL-NEXT:    ldc1 $f12, 16($sp)
; CHECK-LIBCALL-NEXT:    sh $2, 0($19)
; CHECK-LIBCALL-NEXT:    lw $16, 52($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $17, 56($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $18, 60($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $19, 64($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    lw $ra, 68($sp) # 4-byte Folded Reload
; CHECK-LIBCALL-NEXT:    jr $ra
; CHECK-LIBCALL-NEXT:    addiu $sp, $sp, 72
  %b = fptrunc <4 x double> %a to <4 x half>
  store <4 x half> %b, ptr %p, align 8
  ret void
}
