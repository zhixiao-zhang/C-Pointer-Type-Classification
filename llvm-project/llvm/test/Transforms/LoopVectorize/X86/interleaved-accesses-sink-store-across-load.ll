; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -passes=loop-vectorize -mcpu=skx -enable-masked-interleaved-mem-accesses=1  -force-vector-width=4 -force-vector-interleave=1 -S %s | FileCheck %s
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128-ni:1-p2:32:8:8:32-ni:2"
target triple = "x86_64-apple-macos"

; %l2 load and the preceeding store has a dependency. We should not sink
; that store into the last store (by creating an interleaved store group). This
; means the loaded %l2 will have incorrect value.
define void @avoid_sinking_store_across_load(ptr %arr) {
; CHECK-LABEL: define void @avoid_sinking_store_across_load
; CHECK-SAME: (ptr [[ARR:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <4 x i64> [ <i64 1, i64 4, i64 7, i64 10>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND2:%.*]] = phi <4 x i64> [ <i64 4, i64 7, i64 10, i64 13>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT3:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = mul i64 [[INDEX]], 3
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = add i64 1, [[TMP0]]
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = add nuw nsw i64 [[TMP1]], 4
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i32, ptr [[ARR]], i64 [[TMP2]]
; CHECK-NEXT:    [[WIDE_VEC:%.*]] = load <12 x i32>, ptr [[TMP3]], align 4
; CHECK-NEXT:    [[STRIDED_VEC:%.*]] = shufflevector <12 x i32> [[WIDE_VEC]], <12 x i32> poison, <4 x i32> <i32 0, i32 3, i32 6, i32 9>
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i32, ptr [[ARR]], <4 x i64> [[VEC_IND2]]
; CHECK-NEXT:    [[TMP6:%.*]] = add nuw nsw <4 x i64> [[VEC_IND]], <i64 2, i64 2, i64 2, i64 2>
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i32, ptr [[ARR]], <4 x i64> [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = mul <4 x i32> [[STRIDED_VEC]], <i32 25, i32 25, i32 25, i32 25>
; CHECK-NEXT:    call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32> [[TMP8]], <4 x ptr> [[TMP7]], i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>)
; CHECK-NEXT:    [[TMP9:%.*]] = extractelement <4 x ptr> [[TMP7]], i32 0
; CHECK-NEXT:    [[WIDE_VEC4:%.*]] = load <12 x i32>, ptr [[TMP9]], align 4
; CHECK-NEXT:    [[STRIDED_VEC5:%.*]] = shufflevector <12 x i32> [[WIDE_VEC4]], <12 x i32> poison, <4 x i32> <i32 0, i32 3, i32 6, i32 9>
; CHECK-NEXT:    [[STRIDED_VEC6:%.*]] = shufflevector <12 x i32> [[WIDE_VEC4]], <12 x i32> poison, <4 x i32> <i32 1, i32 4, i32 7, i32 10>
; CHECK-NEXT:    [[TMP11:%.*]] = add <4 x i32> [[STRIDED_VEC6]], [[STRIDED_VEC5]]
; CHECK-NEXT:    call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32> [[TMP11]], <4 x ptr> [[TMP5]], i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>)
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <4 x i64> [[VEC_IND]], <i64 12, i64 12, i64 12, i64 12>
; CHECK-NEXT:    [[VEC_IND_NEXT3]] = add <4 x i64> [[VEC_IND2]], <i64 12, i64 12, i64 12, i64 12>
; CHECK-NEXT:    [[TMP12:%.*]] = icmp eq i64 [[INDEX_NEXT]], 16
; CHECK-NEXT:    br i1 [[TMP12]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 49, [[MIDDLE_BLOCK]] ], [ 1, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL1:%.*]] = phi i64 [ 52, [[MIDDLE_BLOCK]] ], [ 4, [[ENTRY]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV_1:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_1_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[IV_2:%.*]] = phi i64 [ [[BC_RESUME_VAL1]], [[SCALAR_PH]] ], [ [[IV_2_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[IV_1_NEXT]] = add nuw nsw i64 [[IV_1]], 3
; CHECK-NEXT:    [[IV_1_PLUS_4:%.*]] = add nuw nsw i64 [[IV_1]], 4
; CHECK-NEXT:    [[GEP_IV_1_PLUS_4:%.*]] = getelementptr inbounds i32, ptr [[ARR]], i64 [[IV_1_PLUS_4]]
; CHECK-NEXT:    [[L1:%.*]] = load i32, ptr [[GEP_IV_1_PLUS_4]], align 4
; CHECK-NEXT:    [[GEP_IV_2:%.*]] = getelementptr inbounds i32, ptr [[ARR]], i64 [[IV_2]]
; CHECK-NEXT:    [[IV_1_PLUS_2:%.*]] = add nuw nsw i64 [[IV_1]], 2
; CHECK-NEXT:    [[GEP_IV_1_PLUS_2:%.*]] = getelementptr inbounds i32, ptr [[ARR]], i64 [[IV_1_PLUS_2]]
; CHECK-NEXT:    [[MUL:%.*]] = mul i32 [[L1]], 25
; CHECK-NEXT:    store i32 [[MUL]], ptr [[GEP_IV_1_PLUS_2]], align 4
; CHECK-NEXT:    [[L2:%.*]] = load i32, ptr [[GEP_IV_1_PLUS_2]], align 4
; CHECK-NEXT:    [[L3:%.*]] = load i32, ptr [[GEP_IV_2]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[L3]], [[L2]]
; CHECK-NEXT:    store i32 [[ADD]], ptr [[GEP_IV_2]], align 4
; CHECK-NEXT:    [[IV_2_NEXT]] = add nuw nsw i64 [[IV_2]], 3
; CHECK-NEXT:    [[ICMP:%.*]] = icmp ugt i64 [[IV_2]], 50
; CHECK-NEXT:    br i1 [[ICMP]], label [[EXIT:%.*]], label [[LOOP]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %iv.1 = phi i64 [ 1, %entry ], [ %iv.1.next, %loop ]
  %iv.2 = phi i64 [ 4, %entry ], [ %iv.2.next, %loop ]
  %iv.1.next = add nuw nsw i64 %iv.1, 3
  %iv.1.plus.4 = add nuw nsw i64 %iv.1, 4
  %gep.iv.1.plus.4 = getelementptr inbounds i32, ptr %arr, i64 %iv.1.plus.4
  %l1 = load i32, ptr %gep.iv.1.plus.4
  %gep.iv.2 = getelementptr inbounds i32, ptr %arr, i64 %iv.2
  %iv.1.plus.2 = add nuw nsw i64 %iv.1, 2
  %gep.iv.1.plus.2= getelementptr inbounds i32, ptr %arr, i64 %iv.1.plus.2
  %mul = mul i32 %l1, 25
  store i32 %mul, ptr %gep.iv.1.plus.2
  %l2 = load i32, ptr %gep.iv.1.plus.2
  %l3 = load i32, ptr %gep.iv.2
  %add = add i32 %l3 , %l2
  store i32 %add, ptr %gep.iv.2
  %iv.2.next = add nuw nsw i64 %iv.2, 3
  %icmp = icmp ugt i64 %iv.2, 50
  br i1 %icmp, label %exit, label %loop

exit:
  ret void
}