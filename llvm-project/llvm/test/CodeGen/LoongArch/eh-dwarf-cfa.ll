; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 -mattr=+d < %s | FileCheck --check-prefix=LA32 %s
; RUN: llc --mtriple=loongarch64 -mattr=+d < %s | FileCheck --check-prefix=LA64 %s

define void @dwarf() {
; LA32-LABEL: dwarf:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    addi.w $sp, $sp, -16
; LA32-NEXT:    .cfi_def_cfa_offset 16
; LA32-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32-NEXT:    .cfi_offset 1, -4
; LA32-NEXT:    addi.w $a0, $sp, 16
; LA32-NEXT:    bl %plt(foo)
; LA32-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32-NEXT:    addi.w $sp, $sp, 16
; LA32-NEXT:    ret
;
; LA64-LABEL: dwarf:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    addi.d $sp, $sp, -16
; LA64-NEXT:    .cfi_def_cfa_offset 16
; LA64-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; LA64-NEXT:    .cfi_offset 1, -8
; LA64-NEXT:    addi.d $a0, $sp, 16
; LA64-NEXT:    bl %plt(foo)
; LA64-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; LA64-NEXT:    addi.d $sp, $sp, 16
; LA64-NEXT:    ret
entry:
  %0 = call ptr @llvm.eh.dwarf.cfa(i32 0)
  call void @foo(ptr %0)
  ret void
}

declare void @foo(ptr)

declare ptr @llvm.eh.dwarf.cfa(i32) nounwind