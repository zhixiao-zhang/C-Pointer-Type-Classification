; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S -mtriple=riscv64-unknown-linux-gnu -mattr=+v < %s | FileCheck %s

define i32 @test() {
; CHECK-LABEL: define i32 @test(
; CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr getelementptr (i8, ptr null, i64 16), align 8
; CHECK-NEXT:    [[SHR_1_I:%.*]] = lshr i64 0, 0
; CHECK-NEXT:    [[SHR_1_I_13:%.*]] = lshr i64 0, [[TMP0]]
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 [[SHR_1_I_13]] to i8
; CHECK-NEXT:    [[STOREDV_1_I_13:%.*]] = and i8 0, [[TMP1]]
; CHECK-NEXT:    [[SHR_1_I_14:%.*]] = lshr i64 0, [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i64 [[SHR_1_I_14]] to i8
; CHECK-NEXT:    [[STOREDV_1_I_14:%.*]] = and i8 [[STOREDV_1_I_13]], [[TMP2]]
; CHECK-NEXT:    [[TMP3:%.*]] = load i64, ptr getelementptr (i8, ptr null, i64 32), align 8
; CHECK-NEXT:    [[SHR_2_I:%.*]] = lshr i64 0, [[TMP3]]
; CHECK-NEXT:    [[TMP4:%.*]] = trunc i64 [[SHR_2_I]] to i8
; CHECK-NEXT:    [[STOREDV_2_I:%.*]] = and i8 [[STOREDV_1_I_14]], [[TMP4]]
; CHECK-NEXT:    [[SHR_2_I_1:%.*]] = lshr i64 0, [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = trunc i64 [[SHR_2_I_1]] to i8
; CHECK-NEXT:    [[STOREDV_2_I_1:%.*]] = and i8 [[STOREDV_2_I]], [[TMP5]]
; CHECK-NEXT:    [[SHR_2_I_2:%.*]] = lshr i64 0, [[TMP3]]
; CHECK-NEXT:    [[TMP6:%.*]] = trunc i64 [[SHR_2_I_2]] to i8
; CHECK-NEXT:    [[STOREDV_2_I_2:%.*]] = and i8 [[STOREDV_2_I_1]], [[TMP6]]
; CHECK-NEXT:    [[SHR_2_I_3:%.*]] = lshr i64 0, [[TMP3]]
; CHECK-NEXT:    [[TMP7:%.*]] = trunc i64 [[SHR_2_I_3]] to i8
; CHECK-NEXT:    [[STOREDV_2_I_3:%.*]] = and i8 [[STOREDV_2_I_2]], [[TMP7]]
; CHECK-NEXT:    [[SHR_2_I_4:%.*]] = lshr i64 0, [[TMP3]]
; CHECK-NEXT:    [[TMP8:%.*]] = trunc i64 [[SHR_2_I_4]] to i8
; CHECK-NEXT:    [[STOREDV_2_I_4:%.*]] = and i8 [[STOREDV_2_I_3]], [[TMP8]]
; CHECK-NEXT:    [[SHR_2_I_5:%.*]] = lshr i64 0, [[TMP3]]
; CHECK-NEXT:    [[TMP9:%.*]] = trunc i64 [[SHR_2_I_5]] to i8
; CHECK-NEXT:    [[STOREDV_2_I_5:%.*]] = and i8 [[STOREDV_2_I_4]], [[TMP9]]
; CHECK-NEXT:    [[SHR_2_I_6:%.*]] = lshr i64 0, [[TMP3]]
; CHECK-NEXT:    [[TMP10:%.*]] = trunc i64 [[SHR_2_I_6]] to i8
; CHECK-NEXT:    [[STOREDV_2_I_6:%.*]] = and i8 [[STOREDV_2_I_5]], [[TMP10]]
; CHECK-NEXT:    [[SHR_2_I_7:%.*]] = lshr i64 0, [[TMP3]]
; CHECK-NEXT:    [[TMP11:%.*]] = trunc i64 [[SHR_2_I_7]] to i8
; CHECK-NEXT:    [[STOREDV_2_I_7:%.*]] = and i8 [[STOREDV_2_I_6]], [[TMP11]]
; CHECK-NEXT:    [[STOREDV_2_I_8:%.*]] = and i8 [[STOREDV_2_I_7]], 0
; CHECK-NEXT:    [[SHR_2_I_9:%.*]] = lshr i64 0, [[TMP3]]
; CHECK-NEXT:    [[TMP12:%.*]] = trunc i64 [[SHR_2_I_9]] to i8
; CHECK-NEXT:    [[STOREDV_2_I_9:%.*]] = and i8 [[STOREDV_2_I_8]], [[TMP12]]
; CHECK-NEXT:    [[SHR_2_I_10:%.*]] = lshr i64 0, [[TMP3]]
; CHECK-NEXT:    [[TMP13:%.*]] = trunc i64 [[SHR_2_I_10]] to i8
; CHECK-NEXT:    [[STOREDV_2_I_10:%.*]] = and i8 [[STOREDV_2_I_9]], [[TMP13]]
; CHECK-NEXT:    [[SHR_2_I_11:%.*]] = lshr i64 0, [[TMP3]]
; CHECK-NEXT:    [[TMP14:%.*]] = trunc i64 [[SHR_2_I_11]] to i8
; CHECK-NEXT:    [[STOREDV_2_I_11:%.*]] = and i8 [[STOREDV_2_I_10]], [[TMP14]]
; CHECK-NEXT:    [[SHR_2_I_12:%.*]] = lshr i64 0, [[TMP3]]
; CHECK-NEXT:    [[TMP15:%.*]] = trunc i64 [[SHR_2_I_12]] to i8
; CHECK-NEXT:    [[STOREDV_2_I_12:%.*]] = and i8 [[STOREDV_2_I_11]], [[TMP15]]
; CHECK-NEXT:    [[SHR_2_I_13:%.*]] = lshr i64 0, [[TMP3]]
; CHECK-NEXT:    [[TMP16:%.*]] = trunc i64 [[SHR_2_I_13]] to i8
; CHECK-NEXT:    [[STOREDV_2_I_13:%.*]] = and i8 [[STOREDV_2_I_12]], [[TMP16]]
; CHECK-NEXT:    [[STOREDV_2_I_14:%.*]] = and i8 [[STOREDV_2_I_13]], 0
; CHECK-NEXT:    [[TMP17:%.*]] = load i64, ptr getelementptr (i8, ptr null, i64 48), align 8
; CHECK-NEXT:    [[SHR_3_I:%.*]] = lshr i64 0, [[TMP17]]
; CHECK-NEXT:    [[TMP18:%.*]] = trunc i64 [[SHR_3_I]] to i8
; CHECK-NEXT:    [[STOREDV_3_I:%.*]] = and i8 [[STOREDV_2_I_14]], [[TMP18]]
; CHECK-NEXT:    [[SHR_3_I_1:%.*]] = lshr i64 0, [[TMP17]]
; CHECK-NEXT:    [[TMP19:%.*]] = trunc i64 [[SHR_3_I_1]] to i8
; CHECK-NEXT:    [[STOREDV_3_I_1:%.*]] = and i8 [[STOREDV_3_I]], [[TMP19]]
; CHECK-NEXT:    [[STOREDV_3_I_2:%.*]] = and i8 [[STOREDV_3_I_1]], 0
; CHECK-NEXT:    [[SHR_3_I_3:%.*]] = lshr i64 0, [[TMP17]]
; CHECK-NEXT:    [[TMP20:%.*]] = trunc i64 [[SHR_3_I_3]] to i8
; CHECK-NEXT:    [[STOREDV_3_I_3:%.*]] = and i8 [[STOREDV_3_I_2]], [[TMP20]]
; CHECK-NEXT:    [[SHR_3_I_4:%.*]] = lshr i64 0, [[TMP17]]
; CHECK-NEXT:    [[TMP21:%.*]] = trunc i64 [[SHR_3_I_4]] to i8
; CHECK-NEXT:    [[STOREDV_3_I_4:%.*]] = and i8 [[STOREDV_3_I_3]], [[TMP21]]
; CHECK-NEXT:    [[SHR_3_I_5:%.*]] = lshr i64 0, [[TMP17]]
; CHECK-NEXT:    [[TMP22:%.*]] = trunc i64 [[SHR_3_I_5]] to i8
; CHECK-NEXT:    [[STOREDV_3_I_5:%.*]] = and i8 [[STOREDV_3_I_4]], [[TMP22]]
; CHECK-NEXT:    [[STOREDV_3_I_6:%.*]] = and i8 [[STOREDV_3_I_5]], 0
; CHECK-NEXT:    [[SHR_3_I_7:%.*]] = lshr i64 0, [[TMP17]]
; CHECK-NEXT:    [[TMP23:%.*]] = trunc i64 [[SHR_3_I_7]] to i8
; CHECK-NEXT:    [[STOREDV_3_I_7:%.*]] = and i8 [[STOREDV_3_I_6]], [[TMP23]]
; CHECK-NEXT:    [[SHR_3_I_8:%.*]] = lshr i64 0, [[TMP17]]
; CHECK-NEXT:    [[TMP24:%.*]] = trunc i64 [[SHR_3_I_8]] to i8
; CHECK-NEXT:    [[STOREDV_3_I_8:%.*]] = and i8 [[STOREDV_3_I_7]], [[TMP24]]
; CHECK-NEXT:    [[SHR_3_I_9:%.*]] = lshr i64 0, [[TMP17]]
; CHECK-NEXT:    [[TMP25:%.*]] = trunc i64 [[SHR_3_I_9]] to i8
; CHECK-NEXT:    [[STOREDV_3_I_9:%.*]] = and i8 [[STOREDV_3_I_8]], [[TMP25]]
; CHECK-NEXT:    [[SHR_3_I_10:%.*]] = lshr i64 0, [[TMP17]]
; CHECK-NEXT:    [[TMP26:%.*]] = trunc i64 [[SHR_3_I_10]] to i8
; CHECK-NEXT:    [[STOREDV_3_I_10:%.*]] = and i8 [[STOREDV_3_I_9]], [[TMP26]]
; CHECK-NEXT:    [[SHR_3_I_11:%.*]] = lshr i64 0, [[TMP17]]
; CHECK-NEXT:    [[TMP27:%.*]] = trunc i64 [[SHR_3_I_11]] to i8
; CHECK-NEXT:    [[STOREDV_3_I_11:%.*]] = and i8 [[STOREDV_3_I_10]], [[TMP27]]
; CHECK-NEXT:    [[STOREDV_3_I_12:%.*]] = and i8 [[STOREDV_3_I_11]], 0
; CHECK-NEXT:    [[SHR_3_I_13:%.*]] = lshr i64 0, [[TMP17]]
; CHECK-NEXT:    [[TMP28:%.*]] = trunc i64 [[SHR_3_I_13]] to i8
; CHECK-NEXT:    [[STOREDV_3_I_13:%.*]] = and i8 [[STOREDV_3_I_12]], [[TMP28]]
; CHECK-NEXT:    [[SHR_3_I_14:%.*]] = lshr i64 0, [[TMP17]]
; CHECK-NEXT:    [[TMP29:%.*]] = trunc i64 [[SHR_3_I_14]] to i8
; CHECK-NEXT:    [[STOREDV_3_I_14:%.*]] = and i8 [[STOREDV_3_I_13]], [[TMP29]]
; CHECK-NEXT:    [[TMP30:%.*]] = load i64, ptr null, align 8
; CHECK-NEXT:    [[STOREDV_4_I:%.*]] = and i8 [[STOREDV_3_I_14]], 0
; CHECK-NEXT:    [[SHR_4_I_1:%.*]] = lshr i64 0, [[TMP30]]
; CHECK-NEXT:    [[TMP31:%.*]] = trunc i64 [[SHR_4_I_1]] to i8
; CHECK-NEXT:    [[STOREDV_4_I_1:%.*]] = and i8 [[STOREDV_4_I]], [[TMP31]]
; CHECK-NEXT:    [[SHR_4_I_2:%.*]] = lshr i64 0, [[TMP30]]
; CHECK-NEXT:    [[TMP32:%.*]] = trunc i64 [[SHR_4_I_2]] to i8
; CHECK-NEXT:    [[STOREDV_4_I_2:%.*]] = and i8 [[STOREDV_4_I_1]], [[TMP32]]
; CHECK-NEXT:    [[SHR_4_I_3:%.*]] = lshr i64 0, [[TMP30]]
; CHECK-NEXT:    [[TMP33:%.*]] = trunc i64 [[SHR_4_I_3]] to i8
; CHECK-NEXT:    [[STOREDV_4_I_3:%.*]] = and i8 [[STOREDV_4_I_2]], [[TMP33]]
; CHECK-NEXT:    [[SHR_4_I_4:%.*]] = lshr i64 0, [[TMP30]]
; CHECK-NEXT:    [[TMP34:%.*]] = trunc i64 [[SHR_4_I_4]] to i8
; CHECK-NEXT:    [[STOREDV_4_I_4:%.*]] = and i8 [[STOREDV_4_I_3]], [[TMP34]]
; CHECK-NEXT:    [[STOREDV_4_I_5:%.*]] = and i8 [[STOREDV_4_I_4]], 0
; CHECK-NEXT:    [[SHR_4_I_6:%.*]] = lshr i64 0, [[TMP30]]
; CHECK-NEXT:    [[TMP35:%.*]] = trunc i64 [[SHR_4_I_6]] to i8
; CHECK-NEXT:    [[STOREDV_4_I_6:%.*]] = and i8 [[STOREDV_4_I_5]], [[TMP35]]
; CHECK-NEXT:    [[SHR_4_I_7:%.*]] = lshr i64 0, [[TMP30]]
; CHECK-NEXT:    [[TMP36:%.*]] = trunc i64 [[SHR_4_I_7]] to i8
; CHECK-NEXT:    [[STOREDV_4_I_7:%.*]] = and i8 [[STOREDV_4_I_6]], [[TMP36]]
; CHECK-NEXT:    [[SHR_4_I_8:%.*]] = lshr i64 0, [[TMP30]]
; CHECK-NEXT:    [[TMP37:%.*]] = trunc i64 [[SHR_4_I_8]] to i8
; CHECK-NEXT:    [[STOREDV_4_I_8:%.*]] = and i8 [[STOREDV_4_I_7]], [[TMP37]]
; CHECK-NEXT:    [[SHR_4_I_9:%.*]] = lshr i64 0, [[TMP30]]
; CHECK-NEXT:    [[TMP38:%.*]] = trunc i64 [[SHR_4_I_9]] to i8
; CHECK-NEXT:    [[STOREDV_4_I_9:%.*]] = and i8 [[STOREDV_4_I_8]], [[TMP38]]
; CHECK-NEXT:    [[SHR_4_I_10:%.*]] = lshr i64 0, [[TMP30]]
; CHECK-NEXT:    [[TMP39:%.*]] = trunc i64 [[SHR_4_I_10]] to i8
; CHECK-NEXT:    [[STOREDV_4_I_10:%.*]] = and i8 [[STOREDV_4_I_9]], [[TMP39]]
; CHECK-NEXT:    [[STOREDV_4_I_11:%.*]] = and i8 [[STOREDV_4_I_10]], 0
; CHECK-NEXT:    [[SHR_4_I_12:%.*]] = lshr i64 0, [[TMP30]]
; CHECK-NEXT:    [[TMP40:%.*]] = trunc i64 [[SHR_4_I_12]] to i8
; CHECK-NEXT:    [[STOREDV_4_I_12:%.*]] = and i8 [[STOREDV_4_I_11]], [[TMP40]]
; CHECK-NEXT:    [[SHR_4_I_13:%.*]] = lshr i64 0, [[TMP30]]
; CHECK-NEXT:    [[TMP41:%.*]] = trunc i64 [[SHR_4_I_13]] to i8
; CHECK-NEXT:    [[STOREDV_4_I_13:%.*]] = and i8 [[STOREDV_4_I_12]], [[TMP41]]
; CHECK-NEXT:    [[SHR_4_I_14:%.*]] = lshr i64 0, [[TMP30]]
; CHECK-NEXT:    [[TMP42:%.*]] = trunc i64 [[SHR_4_I_14]] to i8
; CHECK-NEXT:    [[STOREDV_4_I_14:%.*]] = and i8 [[STOREDV_4_I_13]], [[TMP42]]
; CHECK-NEXT:    [[TMP43:%.*]] = load i64, ptr getelementptr (i8, ptr null, i64 80), align 8
; CHECK-NEXT:    [[SHR_5_I:%.*]] = lshr i64 0, [[TMP43]]
; CHECK-NEXT:    [[TMP44:%.*]] = trunc i64 [[SHR_5_I]] to i8
; CHECK-NEXT:    [[STOREDV_5_I:%.*]] = and i8 [[STOREDV_4_I_14]], [[TMP44]]
; CHECK-NEXT:    [[SHR_5_I_1:%.*]] = lshr i64 0, [[TMP43]]
; CHECK-NEXT:    [[TMP45:%.*]] = trunc i64 [[SHR_5_I_1]] to i8
; CHECK-NEXT:    [[STOREDV_5_I_1:%.*]] = and i8 [[STOREDV_5_I]], [[TMP45]]
; CHECK-NEXT:    [[SHR_5_I_2:%.*]] = lshr i64 0, [[TMP43]]
; CHECK-NEXT:    [[TMP46:%.*]] = trunc i64 [[SHR_5_I_2]] to i8
; CHECK-NEXT:    [[STOREDV_5_I_2:%.*]] = and i8 [[STOREDV_5_I_1]], [[TMP46]]
; CHECK-NEXT:    [[STOREDV_5_I_3:%.*]] = and i8 [[STOREDV_5_I_2]], 0
; CHECK-NEXT:    [[SHR_5_I_4:%.*]] = lshr i64 0, [[TMP43]]
; CHECK-NEXT:    [[TMP47:%.*]] = trunc i64 [[SHR_5_I_4]] to i8
; CHECK-NEXT:    [[STOREDV_5_I_4:%.*]] = and i8 [[STOREDV_5_I_3]], [[TMP47]]
; CHECK-NEXT:    [[SHR_5_I_5:%.*]] = lshr i64 0, [[TMP43]]
; CHECK-NEXT:    [[TMP48:%.*]] = trunc i64 [[SHR_5_I_5]] to i8
; CHECK-NEXT:    [[STOREDV_5_I_5:%.*]] = and i8 [[STOREDV_5_I_4]], [[TMP48]]
; CHECK-NEXT:    [[SHR_5_I_6:%.*]] = lshr i64 0, [[TMP43]]
; CHECK-NEXT:    [[TMP49:%.*]] = trunc i64 [[SHR_5_I_6]] to i8
; CHECK-NEXT:    [[STOREDV_5_I_6:%.*]] = and i8 [[STOREDV_5_I_5]], [[TMP49]]
; CHECK-NEXT:    [[SHR_5_I_7:%.*]] = lshr i64 0, [[TMP43]]
; CHECK-NEXT:    [[TMP50:%.*]] = trunc i64 [[SHR_5_I_7]] to i8
; CHECK-NEXT:    [[STOREDV_5_I_7:%.*]] = and i8 [[STOREDV_5_I_6]], [[TMP50]]
; CHECK-NEXT:    [[SHR_5_I_8:%.*]] = lshr i64 0, [[TMP43]]
; CHECK-NEXT:    [[TMP51:%.*]] = trunc i64 [[SHR_5_I_8]] to i8
; CHECK-NEXT:    [[STOREDV_5_I_8:%.*]] = and i8 [[STOREDV_5_I_7]], [[TMP51]]
; CHECK-NEXT:    [[STOREDV_5_I_9:%.*]] = and i8 [[STOREDV_5_I_8]], 0
; CHECK-NEXT:    [[SHR_5_I_10:%.*]] = lshr i64 0, [[TMP43]]
; CHECK-NEXT:    [[TMP52:%.*]] = trunc i64 [[SHR_5_I_10]] to i8
; CHECK-NEXT:    [[STOREDV_5_I_10:%.*]] = and i8 [[STOREDV_5_I_9]], [[TMP52]]
; CHECK-NEXT:    [[SHR_5_I_11:%.*]] = lshr i64 0, [[TMP43]]
; CHECK-NEXT:    [[TMP53:%.*]] = trunc i64 [[SHR_5_I_11]] to i8
; CHECK-NEXT:    [[STOREDV_5_I_11:%.*]] = and i8 [[STOREDV_5_I_10]], [[TMP53]]
; CHECK-NEXT:    [[SHR_5_I_12:%.*]] = lshr i64 0, [[TMP43]]
; CHECK-NEXT:    [[TMP54:%.*]] = trunc i64 [[SHR_5_I_12]] to i8
; CHECK-NEXT:    [[STOREDV_5_I_12:%.*]] = and i8 [[STOREDV_5_I_11]], [[TMP54]]
; CHECK-NEXT:    [[SHR_5_I_13:%.*]] = lshr i64 0, [[TMP43]]
; CHECK-NEXT:    [[TMP55:%.*]] = trunc i64 [[SHR_5_I_13]] to i8
; CHECK-NEXT:    [[STOREDV_5_I_13:%.*]] = and i8 [[STOREDV_5_I_12]], [[TMP55]]
; CHECK-NEXT:    [[SHR_5_I_14:%.*]] = lshr i64 0, [[TMP43]]
; CHECK-NEXT:    [[TMP56:%.*]] = trunc i64 [[SHR_5_I_14]] to i8
; CHECK-NEXT:    [[STOREDV_5_I_14:%.*]] = and i8 [[STOREDV_5_I_13]], [[TMP56]]
; CHECK-NEXT:    [[TMP57:%.*]] = load i64, ptr null, align 8
; CHECK-NEXT:    [[SHR_6_I:%.*]] = lshr i64 0, [[TMP57]]
; CHECK-NEXT:    [[TMP58:%.*]] = trunc i64 [[SHR_6_I]] to i8
; CHECK-NEXT:    [[STOREDV_6_I:%.*]] = and i8 [[STOREDV_5_I_14]], [[TMP58]]
; CHECK-NEXT:    [[SHR_6_I_1:%.*]] = lshr i64 0, [[TMP57]]
; CHECK-NEXT:    [[TMP59:%.*]] = trunc i64 [[SHR_6_I_1]] to i8
; CHECK-NEXT:    [[STOREDV_6_I_1:%.*]] = and i8 [[STOREDV_6_I]], [[TMP59]]
; CHECK-NEXT:    [[SHR_6_I_2:%.*]] = lshr i64 0, [[TMP57]]
; CHECK-NEXT:    [[TMP60:%.*]] = trunc i64 [[SHR_6_I_2]] to i8
; CHECK-NEXT:    [[STOREDV_6_I_2:%.*]] = and i8 [[STOREDV_6_I_1]], [[TMP60]]
; CHECK-NEXT:    [[STOREDV_6_I_3:%.*]] = and i8 [[STOREDV_6_I_2]], 0
; CHECK-NEXT:    [[SHR_6_I_4:%.*]] = lshr i64 0, [[TMP57]]
; CHECK-NEXT:    [[TMP61:%.*]] = trunc i64 [[SHR_6_I_4]] to i8
; CHECK-NEXT:    [[STOREDV_6_I_4:%.*]] = and i8 [[STOREDV_6_I_3]], [[TMP61]]
; CHECK-NEXT:    [[SHR_6_I_5:%.*]] = lshr i64 0, [[TMP57]]
; CHECK-NEXT:    [[TMP62:%.*]] = trunc i64 [[SHR_6_I_5]] to i8
; CHECK-NEXT:    [[STOREDV_6_I_5:%.*]] = and i8 [[STOREDV_6_I_4]], [[TMP62]]
; CHECK-NEXT:    [[SHR_6_I_6:%.*]] = lshr i64 0, [[TMP57]]
; CHECK-NEXT:    [[TMP63:%.*]] = trunc i64 [[SHR_6_I_6]] to i8
; CHECK-NEXT:    [[STOREDV_6_I_6:%.*]] = and i8 [[STOREDV_6_I_5]], [[TMP63]]
; CHECK-NEXT:    [[SHR_6_I_7:%.*]] = lshr i64 0, [[TMP57]]
; CHECK-NEXT:    [[TMP64:%.*]] = trunc i64 [[SHR_6_I_7]] to i8
; CHECK-NEXT:    [[STOREDV_6_I_7:%.*]] = and i8 [[STOREDV_6_I_6]], [[TMP64]]
; CHECK-NEXT:    [[STOREDV_6_I_8:%.*]] = and i8 [[STOREDV_6_I_7]], 0
; CHECK-NEXT:    [[SHR_6_I_9:%.*]] = lshr i64 0, [[TMP57]]
; CHECK-NEXT:    [[TMP65:%.*]] = trunc i64 [[SHR_6_I_9]] to i8
; CHECK-NEXT:    [[STOREDV_6_I_9:%.*]] = and i8 [[STOREDV_6_I_8]], [[TMP65]]
; CHECK-NEXT:    [[SHR_6_I_10:%.*]] = lshr i64 0, [[TMP57]]
; CHECK-NEXT:    [[TMP66:%.*]] = trunc i64 [[SHR_6_I_10]] to i8
; CHECK-NEXT:    [[STOREDV_6_I_10:%.*]] = and i8 [[STOREDV_6_I_9]], [[TMP66]]
; CHECK-NEXT:    [[SHR_6_I_11:%.*]] = lshr i64 0, [[TMP57]]
; CHECK-NEXT:    [[TMP67:%.*]] = trunc i64 [[SHR_6_I_11]] to i8
; CHECK-NEXT:    [[STOREDV_6_I_11:%.*]] = and i8 [[STOREDV_6_I_10]], [[TMP67]]
; CHECK-NEXT:    [[SHR_6_I_12:%.*]] = lshr i64 0, [[TMP57]]
; CHECK-NEXT:    [[TMP68:%.*]] = trunc i64 [[SHR_6_I_12]] to i8
; CHECK-NEXT:    [[STOREDV_6_I_12:%.*]] = and i8 [[STOREDV_6_I_11]], [[TMP68]]
; CHECK-NEXT:    [[STOREDV_6_I_13:%.*]] = and i8 [[STOREDV_6_I_12]], 0
; CHECK-NEXT:    [[SHR_6_I_14:%.*]] = lshr i64 0, 0
; CHECK-NEXT:    [[TMP69:%.*]] = trunc i64 [[SHR_6_I_14]] to i8
; CHECK-NEXT:    [[STOREDV_6_I_14:%.*]] = and i8 [[STOREDV_6_I_13]], [[TMP69]]
; CHECK-NEXT:    store i8 [[STOREDV_6_I_14]], ptr null, align 1
; CHECK-NEXT:    ret i32 0
;
entry:
  %0 = load i64, ptr getelementptr (i8, ptr null, i64 16), align 8
  %shr.1.i = lshr i64 0, 0
  %shr.1.i.13 = lshr i64 0, %0
  %1 = trunc i64 %shr.1.i.13 to i8
  %storedv.1.i.13 = and i8 0, %1
  %shr.1.i.14 = lshr i64 0, %0
  %2 = trunc i64 %shr.1.i.14 to i8
  %storedv.1.i.14 = and i8 %storedv.1.i.13, %2
  %3 = load i64, ptr getelementptr (i8, ptr null, i64 32), align 8
  %shr.2.i = lshr i64 0, %3
  %4 = trunc i64 %shr.2.i to i8
  %storedv.2.i = and i8 %storedv.1.i.14, %4
  %shr.2.i.1 = lshr i64 0, %3
  %5 = trunc i64 %shr.2.i.1 to i8
  %storedv.2.i.1 = and i8 %storedv.2.i, %5
  %shr.2.i.2 = lshr i64 0, %3
  %6 = trunc i64 %shr.2.i.2 to i8
  %storedv.2.i.2 = and i8 %storedv.2.i.1, %6
  %shr.2.i.3 = lshr i64 0, %3
  %7 = trunc i64 %shr.2.i.3 to i8
  %storedv.2.i.3 = and i8 %storedv.2.i.2, %7
  %shr.2.i.4 = lshr i64 0, %3
  %8 = trunc i64 %shr.2.i.4 to i8
  %storedv.2.i.4 = and i8 %storedv.2.i.3, %8
  %shr.2.i.5 = lshr i64 0, %3
  %9 = trunc i64 %shr.2.i.5 to i8
  %storedv.2.i.5 = and i8 %storedv.2.i.4, %9
  %shr.2.i.6 = lshr i64 0, %3
  %10 = trunc i64 %shr.2.i.6 to i8
  %storedv.2.i.6 = and i8 %storedv.2.i.5, %10
  %shr.2.i.7 = lshr i64 0, %3
  %11 = trunc i64 %shr.2.i.7 to i8
  %storedv.2.i.7 = and i8 %storedv.2.i.6, %11
  %storedv.2.i.8 = and i8 %storedv.2.i.7, 0
  %shr.2.i.9 = lshr i64 0, %3
  %12 = trunc i64 %shr.2.i.9 to i8
  %storedv.2.i.9 = and i8 %storedv.2.i.8, %12
  %shr.2.i.10 = lshr i64 0, %3
  %13 = trunc i64 %shr.2.i.10 to i8
  %storedv.2.i.10 = and i8 %storedv.2.i.9, %13
  %shr.2.i.11 = lshr i64 0, %3
  %14 = trunc i64 %shr.2.i.11 to i8
  %storedv.2.i.11 = and i8 %storedv.2.i.10, %14
  %shr.2.i.12 = lshr i64 0, %3
  %15 = trunc i64 %shr.2.i.12 to i8
  %storedv.2.i.12 = and i8 %storedv.2.i.11, %15
  %shr.2.i.13 = lshr i64 0, %3
  %16 = trunc i64 %shr.2.i.13 to i8
  %storedv.2.i.13 = and i8 %storedv.2.i.12, %16
  %storedv.2.i.14 = and i8 %storedv.2.i.13, 0
  %17 = load i64, ptr getelementptr (i8, ptr null, i64 48), align 8
  %shr.3.i = lshr i64 0, %17
  %18 = trunc i64 %shr.3.i to i8
  %storedv.3.i = and i8 %storedv.2.i.14, %18
  %shr.3.i.1 = lshr i64 0, %17
  %19 = trunc i64 %shr.3.i.1 to i8
  %storedv.3.i.1 = and i8 %storedv.3.i, %19
  %storedv.3.i.2 = and i8 %storedv.3.i.1, 0
  %shr.3.i.3 = lshr i64 0, %17
  %20 = trunc i64 %shr.3.i.3 to i8
  %storedv.3.i.3 = and i8 %storedv.3.i.2, %20
  %shr.3.i.4 = lshr i64 0, %17
  %21 = trunc i64 %shr.3.i.4 to i8
  %storedv.3.i.4 = and i8 %storedv.3.i.3, %21
  %shr.3.i.5 = lshr i64 0, %17
  %22 = trunc i64 %shr.3.i.5 to i8
  %storedv.3.i.5 = and i8 %storedv.3.i.4, %22
  %storedv.3.i.6 = and i8 %storedv.3.i.5, 0
  %shr.3.i.7 = lshr i64 0, %17
  %23 = trunc i64 %shr.3.i.7 to i8
  %storedv.3.i.7 = and i8 %storedv.3.i.6, %23
  %shr.3.i.8 = lshr i64 0, %17
  %24 = trunc i64 %shr.3.i.8 to i8
  %storedv.3.i.8 = and i8 %storedv.3.i.7, %24
  %shr.3.i.9 = lshr i64 0, %17
  %25 = trunc i64 %shr.3.i.9 to i8
  %storedv.3.i.9 = and i8 %storedv.3.i.8, %25
  %shr.3.i.10 = lshr i64 0, %17
  %26 = trunc i64 %shr.3.i.10 to i8
  %storedv.3.i.10 = and i8 %storedv.3.i.9, %26
  %shr.3.i.11 = lshr i64 0, %17
  %27 = trunc i64 %shr.3.i.11 to i8
  %storedv.3.i.11 = and i8 %storedv.3.i.10, %27
  %storedv.3.i.12 = and i8 %storedv.3.i.11, 0
  %shr.3.i.13 = lshr i64 0, %17
  %28 = trunc i64 %shr.3.i.13 to i8
  %storedv.3.i.13 = and i8 %storedv.3.i.12, %28
  %shr.3.i.14 = lshr i64 0, %17
  %29 = trunc i64 %shr.3.i.14 to i8
  %storedv.3.i.14 = and i8 %storedv.3.i.13, %29
  %30 = load i64, ptr null, align 8
  %storedv.4.i = and i8 %storedv.3.i.14, 0
  %shr.4.i.1 = lshr i64 0, %30
  %31 = trunc i64 %shr.4.i.1 to i8
  %storedv.4.i.1 = and i8 %storedv.4.i, %31
  %shr.4.i.2 = lshr i64 0, %30
  %32 = trunc i64 %shr.4.i.2 to i8
  %storedv.4.i.2 = and i8 %storedv.4.i.1, %32
  %shr.4.i.3 = lshr i64 0, %30
  %33 = trunc i64 %shr.4.i.3 to i8
  %storedv.4.i.3 = and i8 %storedv.4.i.2, %33
  %shr.4.i.4 = lshr i64 0, %30
  %34 = trunc i64 %shr.4.i.4 to i8
  %storedv.4.i.4 = and i8 %storedv.4.i.3, %34
  %storedv.4.i.5 = and i8 %storedv.4.i.4, 0
  %shr.4.i.6 = lshr i64 0, %30
  %35 = trunc i64 %shr.4.i.6 to i8
  %storedv.4.i.6 = and i8 %storedv.4.i.5, %35
  %shr.4.i.7 = lshr i64 0, %30
  %36 = trunc i64 %shr.4.i.7 to i8
  %storedv.4.i.7 = and i8 %storedv.4.i.6, %36
  %shr.4.i.8 = lshr i64 0, %30
  %37 = trunc i64 %shr.4.i.8 to i8
  %storedv.4.i.8 = and i8 %storedv.4.i.7, %37
  %shr.4.i.9 = lshr i64 0, %30
  %38 = trunc i64 %shr.4.i.9 to i8
  %storedv.4.i.9 = and i8 %storedv.4.i.8, %38
  %shr.4.i.10 = lshr i64 0, %30
  %39 = trunc i64 %shr.4.i.10 to i8
  %storedv.4.i.10 = and i8 %storedv.4.i.9, %39
  %storedv.4.i.11 = and i8 %storedv.4.i.10, 0
  %shr.4.i.12 = lshr i64 0, %30
  %40 = trunc i64 %shr.4.i.12 to i8
  %storedv.4.i.12 = and i8 %storedv.4.i.11, %40
  %shr.4.i.13 = lshr i64 0, %30
  %41 = trunc i64 %shr.4.i.13 to i8
  %storedv.4.i.13 = and i8 %storedv.4.i.12, %41
  %shr.4.i.14 = lshr i64 0, %30
  %42 = trunc i64 %shr.4.i.14 to i8
  %storedv.4.i.14 = and i8 %storedv.4.i.13, %42
  %43 = load i64, ptr getelementptr (i8, ptr null, i64 80), align 8
  %shr.5.i = lshr i64 0, %43
  %44 = trunc i64 %shr.5.i to i8
  %storedv.5.i = and i8 %storedv.4.i.14, %44
  %shr.5.i.1 = lshr i64 0, %43
  %45 = trunc i64 %shr.5.i.1 to i8
  %storedv.5.i.1 = and i8 %storedv.5.i, %45
  %shr.5.i.2 = lshr i64 0, %43
  %46 = trunc i64 %shr.5.i.2 to i8
  %storedv.5.i.2 = and i8 %storedv.5.i.1, %46
  %storedv.5.i.3 = and i8 %storedv.5.i.2, 0
  %shr.5.i.4 = lshr i64 0, %43
  %47 = trunc i64 %shr.5.i.4 to i8
  %storedv.5.i.4 = and i8 %storedv.5.i.3, %47
  %shr.5.i.5 = lshr i64 0, %43
  %48 = trunc i64 %shr.5.i.5 to i8
  %storedv.5.i.5 = and i8 %storedv.5.i.4, %48
  %shr.5.i.6 = lshr i64 0, %43
  %49 = trunc i64 %shr.5.i.6 to i8
  %storedv.5.i.6 = and i8 %storedv.5.i.5, %49
  %shr.5.i.7 = lshr i64 0, %43
  %50 = trunc i64 %shr.5.i.7 to i8
  %storedv.5.i.7 = and i8 %storedv.5.i.6, %50
  %shr.5.i.8 = lshr i64 0, %43
  %51 = trunc i64 %shr.5.i.8 to i8
  %storedv.5.i.8 = and i8 %storedv.5.i.7, %51
  %storedv.5.i.9 = and i8 %storedv.5.i.8, 0
  %shr.5.i.10 = lshr i64 0, %43
  %52 = trunc i64 %shr.5.i.10 to i8
  %storedv.5.i.10 = and i8 %storedv.5.i.9, %52
  %shr.5.i.11 = lshr i64 0, %43
  %53 = trunc i64 %shr.5.i.11 to i8
  %storedv.5.i.11 = and i8 %storedv.5.i.10, %53
  %shr.5.i.12 = lshr i64 0, %43
  %54 = trunc i64 %shr.5.i.12 to i8
  %storedv.5.i.12 = and i8 %storedv.5.i.11, %54
  %shr.5.i.13 = lshr i64 0, %43
  %55 = trunc i64 %shr.5.i.13 to i8
  %storedv.5.i.13 = and i8 %storedv.5.i.12, %55
  %shr.5.i.14 = lshr i64 0, %43
  %56 = trunc i64 %shr.5.i.14 to i8
  %storedv.5.i.14 = and i8 %storedv.5.i.13, %56
  %57 = load i64, ptr null, align 8
  %shr.6.i = lshr i64 0, %57
  %58 = trunc i64 %shr.6.i to i8
  %storedv.6.i = and i8 %storedv.5.i.14, %58
  %shr.6.i.1 = lshr i64 0, %57
  %59 = trunc i64 %shr.6.i.1 to i8
  %storedv.6.i.1 = and i8 %storedv.6.i, %59
  %shr.6.i.2 = lshr i64 0, %57
  %60 = trunc i64 %shr.6.i.2 to i8
  %storedv.6.i.2 = and i8 %storedv.6.i.1, %60
  %storedv.6.i.3 = and i8 %storedv.6.i.2, 0
  %shr.6.i.4 = lshr i64 0, %57
  %61 = trunc i64 %shr.6.i.4 to i8
  %storedv.6.i.4 = and i8 %storedv.6.i.3, %61
  %shr.6.i.5 = lshr i64 0, %57
  %62 = trunc i64 %shr.6.i.5 to i8
  %storedv.6.i.5 = and i8 %storedv.6.i.4, %62
  %shr.6.i.6 = lshr i64 0, %57
  %63 = trunc i64 %shr.6.i.6 to i8
  %storedv.6.i.6 = and i8 %storedv.6.i.5, %63
  %shr.6.i.7 = lshr i64 0, %57
  %64 = trunc i64 %shr.6.i.7 to i8
  %storedv.6.i.7 = and i8 %storedv.6.i.6, %64
  %storedv.6.i.8 = and i8 %storedv.6.i.7, 0
  %shr.6.i.9 = lshr i64 0, %57
  %65 = trunc i64 %shr.6.i.9 to i8
  %storedv.6.i.9 = and i8 %storedv.6.i.8, %65
  %shr.6.i.10 = lshr i64 0, %57
  %66 = trunc i64 %shr.6.i.10 to i8
  %storedv.6.i.10 = and i8 %storedv.6.i.9, %66
  %shr.6.i.11 = lshr i64 0, %57
  %67 = trunc i64 %shr.6.i.11 to i8
  %storedv.6.i.11 = and i8 %storedv.6.i.10, %67
  %shr.6.i.12 = lshr i64 0, %57
  %68 = trunc i64 %shr.6.i.12 to i8
  %storedv.6.i.12 = and i8 %storedv.6.i.11, %68
  %storedv.6.i.13 = and i8 %storedv.6.i.12, 0
  %shr.6.i.14 = lshr i64 0, 0
  %69 = trunc i64 %shr.6.i.14 to i8
  %storedv.6.i.14 = and i8 %storedv.6.i.13, %69
  store i8 %storedv.6.i.14, ptr null, align 1
  ret i32 0
}