; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -mtriple=sparcv9-unknown-linux -verify-machineinstrs -stop-after=finalize-isel < %s | FileCheck %s

; Check that the fp128 load/store is correctly split.
; The pointer metadata for the upper/lower halves of the load/store should be in
; sync with the OP address.

define fp128 @testcase(fp128 %0) {
  ; CHECK-LABEL: name: testcase
  ; CHECK: bb.0.Entry:
  ; CHECK-NEXT:   liveins: $q0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:qfpregs = COPY $q0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:dfpregs = COPY [[COPY]].sub_odd64
  ; CHECK-NEXT:   [[ADDri:%[0-9]+]]:i64regs = ADDri %stack.0, 0
  ; CHECK-NEXT:   %3:i64regs = disjoint ORri killed [[ADDri]], 8
  ; CHECK-NEXT:   STDFrr %3, $g0, killed [[COPY1]] :: (store (s64) into %stack.0 + 8)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:dfpregs = COPY [[COPY]].sub_even64
  ; CHECK-NEXT:   STDFri %stack.0, 0, killed [[COPY2]] :: (store (s64) into %stack.0, align 16)
  ; CHECK-NEXT:   [[LDXrr:%[0-9]+]]:i64regs = LDXrr %3, $g0 :: (load (s64) from %stack.0 + 8)
  ; CHECK-NEXT:   [[LDXri:%[0-9]+]]:i64regs = LDXri %stack.0, 0 :: (load (s64) from %stack.0, align 16)
  ; CHECK-NEXT:   [[ADDri1:%[0-9]+]]:i64regs = ADDri %stack.1, 0
  ; CHECK-NEXT:   %8:i64regs = disjoint ORri killed [[ADDri1]], 8
  ; CHECK-NEXT:   [[ADDri2:%[0-9]+]]:i64regs = ADDri [[LDXrr]], -1
  ; CHECK-NEXT:   STXrr %8, $g0, killed [[ADDri2]] :: (store (s64) into %stack.1 + 8, basealign 16)
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:intregs = COPY $g0
  ; CHECK-NEXT:   [[MOVRri:%[0-9]+]]:intregs = MOVRri [[LDXrr]], 1, [[COPY3]], 49
  ; CHECK-NEXT:   [[SRLri:%[0-9]+]]:i64regs = SRLri killed [[MOVRri]], 0
  ; CHECK-NEXT:   [[SUBrr:%[0-9]+]]:i64regs = SUBrr killed [[LDXri]], killed [[SRLri]]
  ; CHECK-NEXT:   STXri %stack.1, 0, killed [[SUBrr]] :: (store (s64) into %stack.1, align 16)
  ; CHECK-NEXT:   [[LDDFri:%[0-9]+]]:dfpregs = LDDFri %stack.1, 0 :: (load (s64) from %stack.1, align 16)
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:qfpregs = IMPLICIT_DEF
  ; CHECK-NEXT:   [[INSERT_SUBREG:%[0-9]+]]:qfpregs = INSERT_SUBREG [[DEF]], killed [[LDDFri]], %subreg.sub_even64
  ; CHECK-NEXT:   [[LDDFrr:%[0-9]+]]:dfpregs = LDDFrr %8, $g0 :: (load (s64) from %stack.1 + 8)
  ; CHECK-NEXT:   [[INSERT_SUBREG1:%[0-9]+]]:qfpregs = INSERT_SUBREG [[INSERT_SUBREG]], killed [[LDDFrr]], %subreg.sub_odd64
  ; CHECK-NEXT:   $q0 = COPY [[INSERT_SUBREG1]]
  ; CHECK-NEXT:   RETL 8, implicit $q0
Entry:
  %1 = bitcast fp128 %0 to i128
  %2 = add i128 %1, -1
  %3 = bitcast i128 %2 to fp128
  ret fp128 %3
}