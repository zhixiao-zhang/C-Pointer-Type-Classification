; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S -passes=ipsccp < %s | FileCheck %s

; Make sure that constant ranges including undef are propagated correctly.

define i8 @test_binop(i1 %cond, i8 %a) {
; CHECK-LABEL: define i8 @test_binop(
; CHECK-SAME: i1 [[COND:%.*]], i8 [[A:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br i1 [[COND]], label %[[IF:.*]], label %[[JOIN:.*]]
; CHECK:       [[IF]]:
; CHECK-NEXT:    [[A_EXT:%.*]] = zext i8 [[A]] to i16
; CHECK-NEXT:    br label %[[JOIN]]
; CHECK:       [[JOIN]]:
; CHECK-NEXT:    [[PHI:%.*]] = phi i16 [ undef, %[[ENTRY]] ], [ [[A_EXT]], %[[IF]] ]
; CHECK-NEXT:    [[AND:%.*]] = and i16 [[PHI]], -1
; CHECK-NEXT:    [[TRUNC:%.*]] = trunc i16 [[AND]] to i8
; CHECK-NEXT:    ret i8 [[TRUNC]]
;
entry:
  br i1 %cond, label %if, label %join

if:
  %a.ext = zext i8 %a to i16
  br label %join

join:
  %phi = phi i16 [ undef, %entry ], [ %a.ext, %if ]
  %and = and i16 %phi, u0x0000ffff
  %trunc = trunc i16 %and to i8
  ret i8 %trunc
}

define i8 @test_cast(i1 %cond, i8 %a) {
; CHECK-LABEL: define i8 @test_cast(
; CHECK-SAME: i1 [[COND:%.*]], i8 [[A:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br i1 [[COND]], label %[[IF:.*]], label %[[JOIN:.*]]
; CHECK:       [[IF]]:
; CHECK-NEXT:    [[A_EXT:%.*]] = zext i8 [[A]] to i16
; CHECK-NEXT:    br label %[[JOIN]]
; CHECK:       [[JOIN]]:
; CHECK-NEXT:    [[PHI:%.*]] = phi i16 [ undef, %[[ENTRY]] ], [ [[A_EXT]], %[[IF]] ]
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i16 [[PHI]] to i32
; CHECK-NEXT:    [[TRUNC:%.*]] = trunc i32 [[ZEXT]] to i8
; CHECK-NEXT:    ret i8 [[TRUNC]]
;
entry:
  br i1 %cond, label %if, label %join

if:
  %a.ext = zext i8 %a to i16
  br label %join

join:
  %phi = phi i16 [ undef, %entry ], [ %a.ext, %if ]
  %zext = zext i16 %phi to i32
  %trunc = trunc i32 %zext to i8
  ret i8 %trunc
}

define i8 @test_intrin(i1 %cond, i8 %a) {
; CHECK-LABEL: define i8 @test_intrin(
; CHECK-SAME: i1 [[COND:%.*]], i8 [[A:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br i1 [[COND]], label %[[IF:.*]], label %[[JOIN:.*]]
; CHECK:       [[IF]]:
; CHECK-NEXT:    [[A_EXT:%.*]] = zext i8 [[A]] to i16
; CHECK-NEXT:    br label %[[JOIN]]
; CHECK:       [[JOIN]]:
; CHECK-NEXT:    [[PHI:%.*]] = phi i16 [ undef, %[[ENTRY]] ], [ [[A_EXT]], %[[IF]] ]
; CHECK-NEXT:    [[UMAX:%.*]] = call i16 @llvm.umax.i16(i16 [[PHI]], i16 42)
; CHECK-NEXT:    [[TRUNC:%.*]] = trunc i16 [[UMAX]] to i8
; CHECK-NEXT:    ret i8 [[TRUNC]]
;
entry:
  br i1 %cond, label %if, label %join

if:
  %a.ext = zext i8 %a to i16
  br label %join

join:
  %phi = phi i16 [ undef, %entry ], [ %a.ext, %if ]
  %umax = call i16 @llvm.umax(i16 %phi, i16 42)
  %trunc = trunc i16 %umax to i8
  ret i8 %trunc
}

define i9 @test_with_overflow(i1 %cond, i8 %a) {
; CHECK-LABEL: define i9 @test_with_overflow(
; CHECK-SAME: i1 [[COND:%.*]], i8 [[A:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br i1 [[COND]], label %[[IF:.*]], label %[[JOIN:.*]]
; CHECK:       [[IF]]:
; CHECK-NEXT:    [[A_EXT:%.*]] = zext i8 [[A]] to i16
; CHECK-NEXT:    br label %[[JOIN]]
; CHECK:       [[JOIN]]:
; CHECK-NEXT:    [[PHI:%.*]] = phi i16 [ undef, %[[ENTRY]] ], [ [[A_EXT]], %[[IF]] ]
; CHECK-NEXT:    [[WO:%.*]] = call { i16, i1 } @llvm.uadd.with.overflow.i16(i16 [[PHI]], i16 1)
; CHECK-NEXT:    [[ADD:%.*]] = extractvalue { i16, i1 } [[WO]], 0
; CHECK-NEXT:    [[TRUNC:%.*]] = trunc i16 [[ADD]] to i9
; CHECK-NEXT:    ret i9 [[TRUNC]]
;
entry:
  br i1 %cond, label %if, label %join

if:
  %a.ext = zext i8 %a to i16
  br label %join

join:
  %phi = phi i16 [ undef, %entry ], [ %a.ext, %if ]
  %wo = call {i16, i1} @llvm.uadd.with.overflow(i16 %phi, i16 1)
  %add = extractvalue {i16, i1} %wo, 0
  %trunc = trunc i16 %add to i9
  ret i9 %trunc
}