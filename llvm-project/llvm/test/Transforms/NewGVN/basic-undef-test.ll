; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -passes=newgvn -S < %s | FileCheck %s
; ModuleID = 'test3.ll'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

define i32 @main(ptr %foo)  {
; CHECK-LABEL: define i32 @main(
; CHECK-SAME: ptr [[FOO:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[FOO]], align 4
; CHECK-NEXT:    store i32 5, ptr undef, align 4
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[TMP0]], [[TMP0]]
; CHECK-NEXT:    ret i32 [[TMP1]]
;
entry:
  %0 = load i32, ptr %foo, align 4
  store i32 5, ptr undef, align 4
  %1 = load i32, ptr %foo, align 4
  %2 = add i32 %0, %1
  ret i32 %2
}