; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instsimplify -S | FileCheck %s

; TODO: https://alive2.llvm.org/ce/z/3ybZRl
define i32 @pr54735_slt(i32 %x, i32 %y) {
; CHECK-LABEL: @pr54735_slt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    [[SUB:%.*]] = sub nsw i32 [[X]], [[Y]]
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[SUB]], 1
; CHECK-NEXT:    [[NEG:%.*]] = xor i32 [[SUB]], -1
; CHECK-NEXT:    [[ABSCOND:%.*]] = icmp sle i32 [[SUB]], -1
; CHECK-NEXT:    [[ABS:%.*]] = select i1 [[ABSCOND]], i32 [[NEG]], i32 [[ADD]]
; CHECK-NEXT:    ret i32 [[ABS]]
; CHECK:       cond.end:
; CHECK-NEXT:    ret i32 0
;
entry:
  %cmp = icmp slt i32 %x, %y                      ; x<y ? abs (x-y+1): 0
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:                                        ; preds = %entry
  %sub = sub nsw i32 %x, %y
  %add = add nsw i32 %sub, 1
  %neg = xor i32 %sub, -1                         ; sub nsw i32 0, %add
  %abscond = icmp sle i32 %sub, -1
  %abs = select i1 %abscond, i32 %neg, i32 %add
  ret i32 %abs

cond.end:                                         ; preds = %entry, %cond.true
  ret i32 0
}

; https://alive2.llvm.org/ce/z/fTTsdT
define i32 @pr54735_sgt(i32 %x, i32 %y) {
; CHECK-LABEL: @pr54735_sgt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    [[SUB:%.*]] = sub nsw i32 [[X]], [[Y]]
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[SUB]], 1
; CHECK-NEXT:    ret i32 [[ADD]]
; CHECK:       cond.end:
; CHECK-NEXT:    ret i32 0
;
entry:
  %cmp = icmp sgt i32 %x, %y                      ; x>y ? abs (x-y+1): 0
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:                                        ; preds = %entry
  %sub = sub nsw i32 %x, %y
  %add = add nsw i32 %sub, 1
  %neg = xor i32 %sub, -1                         ; sub nsw i32 0, %add
  %abscond = icmp slt i32 %sub, -1
  %abs = select i1 %abscond, i32 %neg, i32 %add
  ret i32 %abs

cond.end:                                         ; preds = %entry, %cond.true
  ret i32 0
}

; https://alive2.llvm.org/ce/z/k9v75c
define i32 @pr54735_sge(i32 %x, i32 %y) {
; CHECK-LABEL: @pr54735_sge(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sge i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    [[SUB:%.*]] = sub nsw i32 [[X]], [[Y]]
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[SUB]], 1
; CHECK-NEXT:    ret i32 [[ADD]]
; CHECK:       cond.end:
; CHECK-NEXT:    ret i32 0
;
entry:
  %cmp = icmp sge i32 %x, %y                      ; x>y ? abs (x-y+1): 0
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:                                        ; preds = %entry
  %sub = sub nsw i32 %x, %y
  %add = add nsw i32 %sub, 1
  %neg = xor i32 %sub, -1                         ; sub nsw i32 0, %add
  %abscond = icmp slt i32 %sub, -1
  %abs = select i1 %abscond, i32 %neg, i32 %add
  ret i32 %abs

cond.end:                                         ; preds = %entry, %cond.true
  ret i32 0
}

; Negative test: https://alive2.llvm.org/ce/z/oZyu4M
define i8 @pr54735_without_nsw (i8 %x, i8 %y) {
; CHECK-LABEL: @pr54735_without_nsw(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    [[SUB:%.*]] = sub i8 [[X]], [[Y]]
; CHECK-NEXT:    [[ADD:%.*]] = add i8 [[SUB]], 1
; CHECK-NEXT:    [[NEG:%.*]] = xor i8 [[SUB]], -1
; CHECK-NEXT:    [[ABSCOND:%.*]] = icmp slt i8 [[SUB]], -1
; CHECK-NEXT:    [[ABS:%.*]] = select i1 [[ABSCOND]], i8 [[NEG]], i8 [[ADD]]
; CHECK-NEXT:    ret i8 [[ABS]]
; CHECK:       cond.end:
; CHECK-NEXT:    ret i8 0
;
entry:
  %cmp = icmp sgt i8 %x, %y
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:                                        ; preds = %entry
  %sub = sub i8 %x, %y
  %add = add i8 %sub, 1
  %neg = xor i8 %sub, -1
  %abscond = icmp slt i8 %sub, -1
  %abs = select i1 %abscond, i8 %neg, i8 %add
  ret i8 %abs

cond.end:                                         ; preds = %entry, %cond.true
  ret i8 0
}

define i32 @pr54735_sle(i32 %x, i32 %y) {
; CHECK-LABEL: @pr54735_sle(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    [[SUB:%.*]] = sub nsw i32 [[X]], [[Y]]
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[SUB]], 1
; CHECK-NEXT:    [[NEG:%.*]] = xor i32 [[SUB]], -1
; CHECK-NEXT:    [[ABSCOND:%.*]] = icmp slt i32 [[SUB]], -1
; CHECK-NEXT:    [[ABS:%.*]] = select i1 [[ABSCOND]], i32 [[NEG]], i32 [[ADD]]
; CHECK-NEXT:    ret i32 [[ABS]]
; CHECK:       cond.end:
; CHECK-NEXT:    ret i32 0
;
entry:
  %cmp = icmp sle i32 %x, %y                      ; x<=y ? abs (x-y+1): 0
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:                                        ; preds = %entry
  %sub = sub nsw i32 %x, %y
  %add = add nsw i32 %sub, 1
  %neg = xor i32 %sub, -1                         ; sub nsw i32 0, %add
  %abscond = icmp slt i32 %sub, -1
  %abs = select i1 %abscond, i32 %neg, i32 %add
  ret i32 %abs

cond.end:                                         ; preds = %entry, %cond.true
  ret i32 0
}

; https://alive2.llvm.org/ce/z/pp9zJi
define i32 @pr54735_slt_neg(i32 %x, i32 %y) {
; CHECK-LABEL: @pr54735_slt_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    [[SUB:%.*]] = sub nsw i32 [[X]], [[Y]]
; CHECK-NEXT:    [[NEG:%.*]] = xor i32 [[SUB]], 12
; CHECK-NEXT:    ret i32 [[NEG]]
; CHECK:       cond.end:
; CHECK-NEXT:    ret i32 0
;
entry:
  %cmp = icmp slt i32 %x, %y                      ; x<y ? abs (x-y-12): 0
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:                                        ; preds = %entry
  %sub = sub nsw i32 %x, %y
  %add = add nsw i32 %sub, -12                    ; %sub - 12
  %neg = xor i32 %sub, 12                         ; 12 - %sub
  %abscond = icmp sle i32 %sub, 12
  %abs = select i1 %abscond, i32 %neg, i32 %add
  ret i32 %abs

cond.end:                                         ; preds = %entry, %cond.true
  ret i32 0
}

; https://alive2.llvm.org/ce/z/9P6grR
define i32 @pr54735_sle_neg(i32 %x, i32 %y) {
; CHECK-LABEL: @pr54735_sle_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    [[SUB:%.*]] = sub nsw i32 [[X]], [[Y]]
; CHECK-NEXT:    [[NEG:%.*]] = xor i32 [[SUB]], 12
; CHECK-NEXT:    ret i32 [[NEG]]
; CHECK:       cond.end:
; CHECK-NEXT:    ret i32 0
;
entry:
  %cmp = icmp sle i32 %x, %y                      ; x<=y ? abs (x-y-12): 0
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:                                        ; preds = %entry
  %sub = sub nsw i32 %x, %y
  %add = add nsw i32 %sub, -12
  %neg = xor i32 %sub, 12                         ; %sub - 12
  %abscond = icmp sle i32 %sub, 12
  %abs = select i1 %abscond, i32 %neg, i32 %add
  ret i32 %abs

cond.end:                                         ; preds = %entry, %cond.true
  ret i32 0
}

; Negative test: https://alive2.llvm.org/ce/z/Yqv4x2
define i8 @pr54735_unexpect_const (i8 %x, i8 %y) {
; CHECK-LABEL: @pr54735_unexpect_const(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    [[SUB:%.*]] = sub i8 [[X]], [[Y]]
; CHECK-NEXT:    [[ADD:%.*]] = add i8 [[SUB]], 2
; CHECK-NEXT:    [[NEG:%.*]] = xor i8 [[SUB]], -1
; CHECK-NEXT:    [[ABSCOND:%.*]] = icmp slt i8 [[SUB]], -2
; CHECK-NEXT:    [[ABS:%.*]] = select i1 [[ABSCOND]], i8 [[NEG]], i8 [[ADD]]
; CHECK-NEXT:    ret i8 [[ABS]]
; CHECK:       cond.end:
; CHECK-NEXT:    ret i8 0
;
entry:
  %cmp = icmp sgt i8 %x, %y                       ; x>y ? abs (x-y+2): 0
  br i1 %cmp, label %cond.true, label %cond.end

cond.true:                                        ; preds = %entry
  %sub = sub i8 %x, %y
  %add = add i8 %sub, 2                           ; x-y+2
  %neg = xor i8 %sub, -1                          ; y-x-1
  %neg1 = sub i8 %neg, 1                          ; y-x-2
  %abscond = icmp slt i8 %sub, -2
  %abs = select i1 %abscond, i8 %neg, i8 %add
  ret i8 %abs

cond.end:                                         ; preds = %entry, %cond.true
  ret i8 0
}