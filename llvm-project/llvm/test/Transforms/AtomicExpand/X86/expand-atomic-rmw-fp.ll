; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=i686-linux-gnu -passes=atomic-expand %s | FileCheck %s

define float @test_atomicrmw_fadd_f32(ptr %ptr, float %value) {
; CHECK-LABEL: @test_atomicrmw_fadd_f32(
; CHECK-NEXT:    [[TMP1:%.*]] = load float, ptr [[PTR:%.*]], align 4
; CHECK-NEXT:    br label [[ATOMICRMW_START:%.*]]
; CHECK:       atomicrmw.start:
; CHECK-NEXT:    [[LOADED:%.*]] = phi float [ [[TMP1]], [[TMP0:%.*]] ], [ [[TMP5:%.*]], [[ATOMICRMW_START]] ]
; CHECK-NEXT:    [[NEW:%.*]] = fadd float [[LOADED]], [[VALUE:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast float [[NEW]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float [[LOADED]] to i32
; CHECK-NEXT:    [[TMP4:%.*]] = cmpxchg ptr [[PTR]], i32 [[TMP3]], i32 [[TMP2]] seq_cst seq_cst, align 4
; CHECK-NEXT:    [[SUCCESS:%.*]] = extractvalue { i32, i1 } [[TMP4]], 1
; CHECK-NEXT:    [[NEWLOADED:%.*]] = extractvalue { i32, i1 } [[TMP4]], 0
; CHECK-NEXT:    [[TMP5]] = bitcast i32 [[NEWLOADED]] to float
; CHECK-NEXT:    br i1 [[SUCCESS]], label [[ATOMICRMW_END:%.*]], label [[ATOMICRMW_START]]
; CHECK:       atomicrmw.end:
; CHECK-NEXT:    ret float [[TMP5]]
;
  %res = atomicrmw fadd ptr %ptr, float %value seq_cst
  ret float %res
}

define double @test_atomicrmw_fadd_f64(ptr %ptr, double %value) {
; CHECK-LABEL: @test_atomicrmw_fadd_f64(
; CHECK-NEXT:    [[TMP1:%.*]] = load double, ptr [[PTR:%.*]], align 8
; CHECK-NEXT:    br label [[ATOMICRMW_START:%.*]]
; CHECK:       atomicrmw.start:
; CHECK-NEXT:    [[LOADED:%.*]] = phi double [ [[TMP1]], [[TMP0:%.*]] ], [ [[TMP5:%.*]], [[ATOMICRMW_START]] ]
; CHECK-NEXT:    [[NEW:%.*]] = fadd double [[LOADED]], [[VALUE:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast double [[NEW]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast double [[LOADED]] to i64
; CHECK-NEXT:    [[TMP4:%.*]] = cmpxchg ptr [[PTR]], i64 [[TMP3]], i64 [[TMP2]] seq_cst seq_cst, align 8
; CHECK-NEXT:    [[SUCCESS:%.*]] = extractvalue { i64, i1 } [[TMP4]], 1
; CHECK-NEXT:    [[NEWLOADED:%.*]] = extractvalue { i64, i1 } [[TMP4]], 0
; CHECK-NEXT:    [[TMP5]] = bitcast i64 [[NEWLOADED]] to double
; CHECK-NEXT:    br i1 [[SUCCESS]], label [[ATOMICRMW_END:%.*]], label [[ATOMICRMW_START]]
; CHECK:       atomicrmw.end:
; CHECK-NEXT:    ret double [[TMP5]]
;
  %res = atomicrmw fadd ptr %ptr, double %value seq_cst
  ret double %res
}

define float @test_atomicrmw_fadd_f32_as1(ptr addrspace(1) %ptr, float %value) {
; CHECK-LABEL: @test_atomicrmw_fadd_f32_as1(
; CHECK-NEXT:    [[TMP1:%.*]] = load float, ptr addrspace(1) [[PTR:%.*]], align 4
; CHECK-NEXT:    br label [[ATOMICRMW_START:%.*]]
; CHECK:       atomicrmw.start:
; CHECK-NEXT:    [[LOADED:%.*]] = phi float [ [[TMP1]], [[TMP0:%.*]] ], [ [[TMP5:%.*]], [[ATOMICRMW_START]] ]
; CHECK-NEXT:    [[NEW:%.*]] = fadd float [[LOADED]], [[VALUE:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast float [[NEW]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float [[LOADED]] to i32
; CHECK-NEXT:    [[TMP4:%.*]] = cmpxchg ptr addrspace(1) [[PTR]], i32 [[TMP3]], i32 [[TMP2]] seq_cst seq_cst, align 4
; CHECK-NEXT:    [[SUCCESS:%.*]] = extractvalue { i32, i1 } [[TMP4]], 1
; CHECK-NEXT:    [[NEWLOADED:%.*]] = extractvalue { i32, i1 } [[TMP4]], 0
; CHECK-NEXT:    [[TMP5]] = bitcast i32 [[NEWLOADED]] to float
; CHECK-NEXT:    br i1 [[SUCCESS]], label [[ATOMICRMW_END:%.*]], label [[ATOMICRMW_START]]
; CHECK:       atomicrmw.end:
; CHECK-NEXT:    ret float [[TMP5]]
;
  %res = atomicrmw fadd ptr addrspace(1) %ptr, float %value seq_cst
  ret float %res
}

define float @test_atomicrmw_fsub_f32(ptr %ptr, float %value) {
; CHECK-LABEL: @test_atomicrmw_fsub_f32(
; CHECK-NEXT:    [[TMP1:%.*]] = load float, ptr [[PTR:%.*]], align 4
; CHECK-NEXT:    br label [[ATOMICRMW_START:%.*]]
; CHECK:       atomicrmw.start:
; CHECK-NEXT:    [[LOADED:%.*]] = phi float [ [[TMP1]], [[TMP0:%.*]] ], [ [[TMP5:%.*]], [[ATOMICRMW_START]] ]
; CHECK-NEXT:    [[NEW:%.*]] = fsub float [[LOADED]], [[VALUE:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast float [[NEW]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float [[LOADED]] to i32
; CHECK-NEXT:    [[TMP4:%.*]] = cmpxchg ptr [[PTR]], i32 [[TMP3]], i32 [[TMP2]] seq_cst seq_cst, align 4
; CHECK-NEXT:    [[SUCCESS:%.*]] = extractvalue { i32, i1 } [[TMP4]], 1
; CHECK-NEXT:    [[NEWLOADED:%.*]] = extractvalue { i32, i1 } [[TMP4]], 0
; CHECK-NEXT:    [[TMP5]] = bitcast i32 [[NEWLOADED]] to float
; CHECK-NEXT:    br i1 [[SUCCESS]], label [[ATOMICRMW_END:%.*]], label [[ATOMICRMW_START]]
; CHECK:       atomicrmw.end:
; CHECK-NEXT:    ret float [[TMP5]]
;
  %res = atomicrmw fsub ptr %ptr, float %value seq_cst
  ret float %res
}

define double @test_atomicrmw_fsub_f64(ptr %ptr, double %value) {
; CHECK-LABEL: @test_atomicrmw_fsub_f64(
; CHECK-NEXT:    [[TMP1:%.*]] = load double, ptr [[PTR:%.*]], align 8
; CHECK-NEXT:    br label [[ATOMICRMW_START:%.*]]
; CHECK:       atomicrmw.start:
; CHECK-NEXT:    [[LOADED:%.*]] = phi double [ [[TMP1]], [[TMP0:%.*]] ], [ [[TMP5:%.*]], [[ATOMICRMW_START]] ]
; CHECK-NEXT:    [[NEW:%.*]] = fsub double [[LOADED]], [[VALUE:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast double [[NEW]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast double [[LOADED]] to i64
; CHECK-NEXT:    [[TMP4:%.*]] = cmpxchg ptr [[PTR]], i64 [[TMP3]], i64 [[TMP2]] seq_cst seq_cst, align 8
; CHECK-NEXT:    [[SUCCESS:%.*]] = extractvalue { i64, i1 } [[TMP4]], 1
; CHECK-NEXT:    [[NEWLOADED:%.*]] = extractvalue { i64, i1 } [[TMP4]], 0
; CHECK-NEXT:    [[TMP5]] = bitcast i64 [[NEWLOADED]] to double
; CHECK-NEXT:    br i1 [[SUCCESS]], label [[ATOMICRMW_END:%.*]], label [[ATOMICRMW_START]]
; CHECK:       atomicrmw.end:
; CHECK-NEXT:    ret double [[TMP5]]
;
  %res = atomicrmw fsub ptr %ptr, double %value seq_cst
  ret double %res
}