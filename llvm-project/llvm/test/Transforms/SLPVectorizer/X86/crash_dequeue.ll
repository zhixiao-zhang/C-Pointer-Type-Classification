; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer,dce -S -mtriple=x86_64-apple-macosx10.8.0 -mcpu=corei7 | FileCheck %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.8.0"
%"struct.std::_Deque_iterator.4.157.174.208.259.276.344.731" = type { ptr, ptr, ptr, ptr }

; Function Attrs: nounwind ssp uwtable
define void @_ZSt6uniqueISt15_Deque_iteratorIdRdPdEET_S4_S4_(ptr %__first, ptr nocapture %__last) {
; CHECK-LABEL: @_ZSt6uniqueISt15_Deque_iteratorIdRdPdEET_S4_S4_(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[__FIRST:%.*]], align 8
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x ptr>, ptr [[__LAST:%.*]], align 8
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <2 x ptr> [[TMP1]], ptr [[TMP0]], i32 0
; CHECK-NEXT:    br i1 undef, label [[_ZST13ADJACENT_FINDIST15_DEQUE_ITERATORIDRDPDEET_S4_S4__EXIT:%.*]], label [[WHILE_COND_I_PREHEADER:%.*]]
; CHECK:       while.cond.i.preheader:
; CHECK-NEXT:    br label [[WHILE_COND_I:%.*]]
; CHECK:       while.cond.i:
; CHECK-NEXT:    br i1 undef, label [[_ZST13ADJACENT_FINDIST15_DEQUE_ITERATORIDRDPDEET_S4_S4__EXIT]], label [[WHILE_BODY_I:%.*]]
; CHECK:       while.body.i:
; CHECK-NEXT:    br i1 undef, label [[_ZST13ADJACENT_FINDIST15_DEQUE_ITERATORIDRDPDEET_S4_S4__EXIT]], label [[WHILE_COND_I]]
; CHECK:       _ZSt13adjacent_findISt15_Deque_iteratorIdRdPdEET_S4_S4_.exit:
; CHECK-NEXT:    [[TMP3:%.*]] = phi <2 x ptr> [ [[TMP2]], [[ENTRY:%.*]] ], [ [[TMP1]], [[WHILE_COND_I]] ], [ undef, [[WHILE_BODY_I]] ]
; CHECK-NEXT:    store <2 x ptr> [[TMP3]], ptr [[__FIRST]], align 8
; CHECK-NEXT:    br i1 undef, label [[IF_THEN_I55:%.*]], label [[WHILE_COND:%.*]]
; CHECK:       if.then.i55:
; CHECK-NEXT:    br label [[WHILE_COND]]
; CHECK:       while.cond:
; CHECK-NEXT:    br label [[WHILE_COND]]
;
entry:
  %0 = load ptr, ptr %__first, align 8
  %_M_first3.i.i = getelementptr inbounds %"struct.std::_Deque_iterator.4.157.174.208.259.276.344.731", ptr %__first, i64 0, i32 1
  %1 = load ptr, ptr %__last, align 8
  %_M_first3.i.i83 = getelementptr inbounds %"struct.std::_Deque_iterator.4.157.174.208.259.276.344.731", ptr %__last, i64 0, i32 1
  %2 = load ptr, ptr %_M_first3.i.i83, align 8
  br i1 undef, label %_ZSt13adjacent_findISt15_Deque_iteratorIdRdPdEET_S4_S4_.exit, label %while.cond.i.preheader

while.cond.i.preheader:                           ; preds = %entry
  br label %while.cond.i

while.cond.i:                                     ; preds = %while.body.i, %while.cond.i.preheader
  br i1 undef, label %_ZSt13adjacent_findISt15_Deque_iteratorIdRdPdEET_S4_S4_.exit, label %while.body.i

while.body.i:                                     ; preds = %while.cond.i
  br i1 undef, label %_ZSt13adjacent_findISt15_Deque_iteratorIdRdPdEET_S4_S4_.exit, label %while.cond.i

_ZSt13adjacent_findISt15_Deque_iteratorIdRdPdEET_S4_S4_.exit: ; preds = %while.body.i, %while.cond.i, %entry
  %3 = phi ptr [ %2, %entry ], [ %2, %while.cond.i ], [ undef, %while.body.i ]
  %4 = phi ptr [ %0, %entry ], [ %1, %while.cond.i ], [ undef, %while.body.i ]
  store ptr %4, ptr %__first, align 8
  store ptr %3, ptr %_M_first3.i.i, align 8
  br i1 undef, label %if.then.i55, label %while.cond

if.then.i55:                                      ; preds = %_ZSt13adjacent_findISt15_Deque_iteratorIdRdPdEET_S4_S4_.exit
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %if.then.i55, %_ZSt13adjacent_findISt15_Deque_iteratorIdRdPdEET_S4_S4_.exit
  br label %while.cond
}