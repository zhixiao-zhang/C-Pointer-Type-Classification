; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-attributes --check-globals --version 2
; Test basic address sanitizer instrumentation.
;
; RUN: opt < %s -passes=hwasan,hwasan -S | FileCheck %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

;.
; CHECK: @llvm.used = appending global [1 x ptr] [ptr @hwasan.module_ctor], section "llvm.metadata"
; CHECK: @llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 0, ptr @hwasan.module_ctor, ptr @hwasan.module_ctor }]
; CHECK: @__start_hwasan_globals = external hidden constant [0 x i8]
; CHECK: @__stop_hwasan_globals = external hidden constant [0 x i8]
; CHECK: @hwasan.note = private constant { i32, i32, i32, [8 x i8], i32, i32 } { i32 8, i32 8, i32 3, [8 x i8] c"LLVM\00\00\00\00", i32 trunc (i64 sub (i64 ptrtoint (ptr @__start_hwasan_globals to i64), i64 ptrtoint (ptr @hwasan.note to i64)) to i32), i32 trunc (i64 sub (i64 ptrtoint (ptr @__stop_hwasan_globals to i64), i64 ptrtoint (ptr @hwasan.note to i64)) to i32) }, section ".note.hwasan.globals", comdat($hwasan.module_ctor), align 4
; CHECK: @hwasan.dummy.global = private constant [0 x i8] zeroinitializer, section "hwasan_globals", comdat($hwasan.module_ctor), !associated [[META0:![0-9]+]]
; CHECK: @__hwasan_tls = external thread_local(initialexec) global i64
; CHECK: @llvm.compiler.used = appending global [3 x ptr] [ptr @hwasan.note, ptr @hwasan.dummy.global, ptr @__hwasan_tls], section "llvm.metadata"
; CHECK: @__hwasan_shadow = external global [0 x i8]
;.
define i8 @test_load8(ptr %a) sanitize_hwaddress {
; CHECK: Function Attrs: sanitize_hwaddress
; CHECK-LABEL: define i8 @test_load8
; CHECK-SAME: (ptr [[A:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DOTHWASAN_SHADOW:%.*]] = call ptr asm "", "=r,0"(ptr null)
; CHECK-NEXT:    [[TMP0:%.*]] = ptrtoint ptr [[A]] to i64
; CHECK-NEXT:    call void @__hwasan_load1(i64 [[TMP0]])
; CHECK-NEXT:    [[B:%.*]] = load i8, ptr [[A]], align 4
; CHECK-NEXT:    ret i8 [[B]]
;
entry:
  %b = load i8, ptr %a, align 4
  ret i8 %b
}
;.
; CHECK: attributes #[[ATTR0]] = { sanitize_hwaddress }
; CHECK: attributes #[[ATTR1:[0-9]+]] = { nounwind }
;.
; CHECK: [[META0]] = !{ptr @hwasan.note}
; CHECK: [[META1:![0-9]+]] = !{i32 4, !"nosanitize_hwaddress", i32 1}
;.