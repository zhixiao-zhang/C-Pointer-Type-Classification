; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-attributes --check-globals --version 2
; RUN: opt < %s -passes=tsan-module,tsan-module -S | FileCheck %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"

declare void @can_throw()
declare void @cannot_throw() nounwind

;.
; CHECK: @llvm.used = appending global [1 x ptr] [ptr @tsan.module_ctor], section "llvm.metadata"
; CHECK: @llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 0, ptr @tsan.module_ctor, ptr null }]
;.
define i32 @func1() sanitize_thread {
; CHECK: Function Attrs: sanitize_thread
; CHECK-LABEL: define i32 @func1
; CHECK-SAME: () #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    call void @can_throw()
; CHECK-NEXT:    ret i32 0
;
  call void @can_throw()
  ret i32 0
}
;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { nounwind }
; CHECK: attributes #[[ATTR1]] = { sanitize_thread }
;.
; CHECK: [[META0:![0-9]+]] = !{i32 4, !"nosanitize_thread", i32 1}
;.