; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S -passes=loop-unroll -unroll-runtime < %s | FileCheck %s

target triple = "x86_64-unknown-linux-gnu"

define void @selsort(ptr %array) #0 {
; CHECK-LABEL: define void @selsort(
; CHECK-SAME: ptr [[ARRAY:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[SIZE:%.*]] = getelementptr inbounds nuw i8, ptr [[ARRAY]], i64 8
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr [[SIZE]], align 8
; CHECK-NEXT:    [[CMP21_NOT:%.*]] = icmp eq i64 [[TMP0]], 0
; CHECK-NEXT:    br i1 [[CMP21_NOT]], label %[[FOR_END18:.*]], label %[[FOR_BODY_LR_PH:.*]]
; CHECK:       [[FOR_BODY_LR_PH]]:
; CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[ARRAY]], align 8
; CHECK-NEXT:    [[TMP7:%.*]] = add i64 [[TMP0]], -1
; CHECK-NEXT:    [[TMP8:%.*]] = add i64 [[TMP0]], -2
; CHECK-NEXT:    br label %[[FOR_BODY:.*]]
; CHECK:       [[FOR_BODY]]:
; CHECK-NEXT:    [[BASE_022:%.*]] = phi i64 [ 0, %[[FOR_BODY_LR_PH]] ], [ [[ADD:%.*]], %[[FOR_END:.*]] ]
; CHECK-NEXT:    [[TMP10:%.*]] = mul i64 [[BASE_022]], -1
; CHECK-NEXT:    [[TMP11:%.*]] = add i64 [[TMP7]], [[TMP10]]
; CHECK-NEXT:    [[TMP6:%.*]] = add i64 [[TMP8]], [[TMP10]]
; CHECK-NEXT:    [[ADD]] = add nuw i64 [[BASE_022]], 1
; CHECK-NEXT:    [[CMP318:%.*]] = icmp ult i64 [[ADD]], [[TMP0]]
; CHECK-NEXT:    br i1 [[CMP318]], label %[[FOR_BODY4_PREHEADER:.*]], label %[[FOR_END]]
; CHECK:       [[FOR_BODY4_PREHEADER]]:
; CHECK-NEXT:    [[XTRAITER:%.*]] = and i64 [[TMP11]], 3
; CHECK-NEXT:    [[LCMP_MOD:%.*]] = icmp ne i64 [[XTRAITER]], 0
; CHECK-NEXT:    br i1 [[LCMP_MOD]], label %[[FOR_BODY4_PROL_PREHEADER:.*]], label %[[FOR_BODY4_PROL_LOOPEXIT:.*]]
; CHECK:       [[FOR_BODY4_PROL_PREHEADER]]:
; CHECK-NEXT:    br label %[[FOR_BODY4_PROL:.*]]
; CHECK:       [[FOR_BODY4_PROL]]:
; CHECK-NEXT:    [[MIN_020:%.*]] = phi i64 [ [[SPEC_SELECT:%.*]], %[[FOR_BODY4_PROL]] ], [ [[BASE_022]], %[[FOR_BODY4_PROL_PREHEADER]] ]
; CHECK-NEXT:    [[C_019:%.*]] = phi i64 [ [[INC:%.*]], %[[FOR_BODY4_PROL]] ], [ [[ADD]], %[[FOR_BODY4_PROL_PREHEADER]] ]
; CHECK-NEXT:    [[PROL_ITER:%.*]] = phi i64 [ 0, %[[FOR_BODY4_PROL_PREHEADER]] ], [ [[PROL_ITER_NEXT:%.*]], %[[FOR_BODY4_PROL]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i64 [[C_019]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i64 [[MIN_020]]
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, ptr [[ARRAYIDX6]], align 4
; CHECK-NEXT:    [[CMP7:%.*]] = icmp ult i32 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    [[SPEC_SELECT]] = select i1 [[CMP7]], i64 [[C_019]], i64 [[MIN_020]]
; CHECK-NEXT:    [[INC]] = add nuw i64 [[C_019]], 1
; CHECK-NEXT:    [[CMP3:%.*]] = icmp ult i64 [[INC]], [[TMP0]]
; CHECK-NEXT:    [[PROL_ITER_NEXT]] = add i64 [[PROL_ITER]], 1
; CHECK-NEXT:    [[PROL_ITER_CMP:%.*]] = icmp ne i64 [[PROL_ITER_NEXT]], [[XTRAITER]]
; CHECK-NEXT:    br i1 [[PROL_ITER_CMP]], label %[[FOR_BODY4_PROL]], label %[[FOR_BODY4_PROL_LOOPEXIT_UNR_LCSSA:.*]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       [[FOR_BODY4_PROL_LOOPEXIT_UNR_LCSSA]]:
; CHECK-NEXT:    [[MIN_020_UNR_PH:%.*]] = phi i64 [ [[SPEC_SELECT]], %[[FOR_BODY4_PROL]] ]
; CHECK-NEXT:    [[C_019_UNR_PH:%.*]] = phi i64 [ [[INC]], %[[FOR_BODY4_PROL]] ]
; CHECK-NEXT:    [[SPEC_SELECT_LCSSA_UNR_PH:%.*]] = phi i64 [ [[SPEC_SELECT]], %[[FOR_BODY4_PROL]] ]
; CHECK-NEXT:    br label %[[FOR_BODY4_PROL_LOOPEXIT]]
; CHECK:       [[FOR_BODY4_PROL_LOOPEXIT]]:
; CHECK-NEXT:    [[MIN_020_UNR:%.*]] = phi i64 [ [[BASE_022]], %[[FOR_BODY4_PREHEADER]] ], [ [[MIN_020_UNR_PH]], %[[FOR_BODY4_PROL_LOOPEXIT_UNR_LCSSA]] ]
; CHECK-NEXT:    [[C_019_UNR:%.*]] = phi i64 [ [[ADD]], %[[FOR_BODY4_PREHEADER]] ], [ [[C_019_UNR_PH]], %[[FOR_BODY4_PROL_LOOPEXIT_UNR_LCSSA]] ]
; CHECK-NEXT:    [[SPEC_SELECT_LCSSA_UNR:%.*]] = phi i64 [ poison, %[[FOR_BODY4_PREHEADER]] ], [ [[SPEC_SELECT_LCSSA_UNR_PH]], %[[FOR_BODY4_PROL_LOOPEXIT_UNR_LCSSA]] ]
; CHECK-NEXT:    [[TMP9:%.*]] = icmp ult i64 [[TMP6]], 3
; CHECK-NEXT:    br i1 [[TMP9]], label %[[FOR_END_LOOPEXIT:.*]], label %[[FOR_BODY4_PREHEADER_NEW:.*]]
; CHECK:       [[FOR_BODY4_PREHEADER_NEW]]:
; CHECK-NEXT:    br label %[[FOR_BODY4:.*]]
; CHECK:       [[FOR_BODY4]]:
; CHECK-NEXT:    [[MIN_20:%.*]] = phi i64 [ [[MIN_020_UNR]], %[[FOR_BODY4_PREHEADER_NEW]] ], [ [[SPEC_SELECT_3:%.*]], %[[FOR_BODY4]] ]
; CHECK-NEXT:    [[MIN_0_LCSSA:%.*]] = phi i64 [ [[C_019_UNR]], %[[FOR_BODY4_PREHEADER_NEW]] ], [ [[INC_3:%.*]], %[[FOR_BODY4]] ]
; CHECK-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i64 [[MIN_0_LCSSA]]
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr [[ARRAYIDX9]], align 4
; CHECK-NEXT:    [[ARRAYIDX11:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i64 [[MIN_20]]
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr [[ARRAYIDX11]], align 4
; CHECK-NEXT:    [[CMP8:%.*]] = icmp ult i32 [[TMP4]], [[TMP5]]
; CHECK-NEXT:    [[SPEC_SELECT1:%.*]] = select i1 [[CMP8]], i64 [[MIN_0_LCSSA]], i64 [[MIN_20]]
; CHECK-NEXT:    [[INC1:%.*]] = add nuw i64 [[MIN_0_LCSSA]], 1
; CHECK-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i64 [[INC1]]
; CHECK-NEXT:    [[TMP12:%.*]] = load i32, ptr [[ARRAYIDX_1]], align 4
; CHECK-NEXT:    [[ARRAYIDX6_1:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i64 [[SPEC_SELECT1]]
; CHECK-NEXT:    [[TMP13:%.*]] = load i32, ptr [[ARRAYIDX6_1]], align 4
; CHECK-NEXT:    [[CMP7_1:%.*]] = icmp ult i32 [[TMP12]], [[TMP13]]
; CHECK-NEXT:    [[SPEC_SELECT_1:%.*]] = select i1 [[CMP7_1]], i64 [[INC1]], i64 [[SPEC_SELECT1]]
; CHECK-NEXT:    [[INC_1:%.*]] = add nuw i64 [[MIN_0_LCSSA]], 2
; CHECK-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i64 [[INC_1]]
; CHECK-NEXT:    [[TMP14:%.*]] = load i32, ptr [[ARRAYIDX_2]], align 4
; CHECK-NEXT:    [[ARRAYIDX6_2:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i64 [[SPEC_SELECT_1]]
; CHECK-NEXT:    [[TMP15:%.*]] = load i32, ptr [[ARRAYIDX6_2]], align 4
; CHECK-NEXT:    [[CMP7_2:%.*]] = icmp ult i32 [[TMP14]], [[TMP15]]
; CHECK-NEXT:    [[SPEC_SELECT_2:%.*]] = select i1 [[CMP7_2]], i64 [[INC_1]], i64 [[SPEC_SELECT_1]]
; CHECK-NEXT:    [[INC_2:%.*]] = add nuw i64 [[MIN_0_LCSSA]], 3
; CHECK-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i64 [[INC_2]]
; CHECK-NEXT:    [[TMP16:%.*]] = load i32, ptr [[ARRAYIDX_3]], align 4
; CHECK-NEXT:    [[ARRAYIDX6_3:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i64 [[SPEC_SELECT_2]]
; CHECK-NEXT:    [[TMP17:%.*]] = load i32, ptr [[ARRAYIDX6_3]], align 4
; CHECK-NEXT:    [[CMP7_3:%.*]] = icmp ult i32 [[TMP16]], [[TMP17]]
; CHECK-NEXT:    [[SPEC_SELECT_3]] = select i1 [[CMP7_3]], i64 [[INC_2]], i64 [[SPEC_SELECT_2]]
; CHECK-NEXT:    [[INC_3]] = add nuw i64 [[MIN_0_LCSSA]], 4
; CHECK-NEXT:    [[CMP3_3:%.*]] = icmp ult i64 [[INC_3]], [[TMP0]]
; CHECK-NEXT:    br i1 [[CMP3_3]], label %[[FOR_BODY4]], label %[[FOR_END_LOOPEXIT_UNR_LCSSA:.*]]
; CHECK:       [[FOR_END_LOOPEXIT_UNR_LCSSA]]:
; CHECK-NEXT:    [[SPEC_SELECT_LCSSA_PH:%.*]] = phi i64 [ [[SPEC_SELECT_3]], %[[FOR_BODY4]] ]
; CHECK-NEXT:    br label %[[FOR_END_LOOPEXIT]]
; CHECK:       [[FOR_END_LOOPEXIT]]:
; CHECK-NEXT:    [[SPEC_SELECT_LCSSA:%.*]] = phi i64 [ [[SPEC_SELECT_LCSSA_UNR]], %[[FOR_BODY4_PROL_LOOPEXIT]] ], [ [[SPEC_SELECT_LCSSA_PH]], %[[FOR_END_LOOPEXIT_UNR_LCSSA]] ]
; CHECK-NEXT:    br label %[[FOR_END]]
; CHECK:       [[FOR_END]]:
; CHECK-NEXT:    [[MIN_0_LCSSA1:%.*]] = phi i64 [ [[BASE_022]], %[[FOR_BODY]] ], [ [[SPEC_SELECT_LCSSA]], %[[FOR_END_LOOPEXIT]] ]
; CHECK-NEXT:    [[ARRAYIDX10:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i64 [[MIN_0_LCSSA1]]
; CHECK-NEXT:    [[TMP18:%.*]] = load i32, ptr [[ARRAYIDX10]], align 4
; CHECK-NEXT:    [[ARRAYIDX12:%.*]] = getelementptr inbounds i32, ptr [[TMP1]], i64 [[BASE_022]]
; CHECK-NEXT:    [[TMP19:%.*]] = load i32, ptr [[ARRAYIDX12]], align 4
; CHECK-NEXT:    store i32 [[TMP19]], ptr [[ARRAYIDX10]], align 4
; CHECK-NEXT:    store i32 [[TMP18]], ptr [[ARRAYIDX12]], align 4
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[ADD]], [[TMP0]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label %[[FOR_END18_LOOPEXIT:.*]], label %[[FOR_BODY]]
; CHECK:       [[FOR_END18_LOOPEXIT]]:
; CHECK-NEXT:    br label %[[FOR_END18]]
; CHECK:       [[FOR_END18]]:
; CHECK-NEXT:    ret void
;
entry:
  %size = getelementptr inbounds nuw i8, ptr %array, i64 8
  %0 = load i64, ptr %size, align 8
  %cmp21.not = icmp eq i64 %0, 0
  br i1 %cmp21.not, label %for.end18, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %entry
  %1 = load ptr, ptr %array, align 8
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.end
  %base.022 = phi i64 [ 0, %for.body.lr.ph ], [ %add, %for.end ]
  %add = add nuw i64 %base.022, 1
  %cmp318 = icmp ult i64 %add, %0
  br i1 %cmp318, label %for.body4, label %for.end

for.body4:                                        ; preds = %for.body, %for.body4
  %min.020 = phi i64 [ %spec.select, %for.body4 ], [ %base.022, %for.body ]
  %c.019 = phi i64 [ %inc, %for.body4 ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %1, i64 %c.019
  %2 = load i32, ptr %arrayidx, align 4
  %arrayidx6 = getelementptr inbounds i32, ptr %1, i64 %min.020
  %3 = load i32, ptr %arrayidx6, align 4
  %cmp7 = icmp ult i32 %2, %3
  %spec.select = select i1 %cmp7, i64 %c.019, i64 %min.020
  %inc = add nuw i64 %c.019, 1
  %cmp3 = icmp ult i64 %inc, %0
  br i1 %cmp3, label %for.body4, label %for.end

for.end:                                          ; preds = %for.body4, %for.body
  %min.0.lcssa = phi i64 [ %base.022, %for.body ], [ %spec.select, %for.body4 ]
  %arrayidx9 = getelementptr inbounds i32, ptr %1, i64 %min.0.lcssa
  %4 = load i32, ptr %arrayidx9, align 4
  %arrayidx11 = getelementptr inbounds i32, ptr %1, i64 %base.022
  %5 = load i32, ptr %arrayidx11, align 4
  store i32 %5, ptr %arrayidx9, align 4
  store i32 %4, ptr %arrayidx11, align 4
  %exitcond.not = icmp eq i64 %add, %0
  br i1 %exitcond.not, label %for.end18, label %for.body

for.end18:                                        ; preds = %for.end, %entry
  ret void
}

attributes #0 = { "tune-cpu"="generic" }
;.
; CHECK: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]]}
; CHECK: [[META1]] = !{!"llvm.loop.unroll.disable"}
;.