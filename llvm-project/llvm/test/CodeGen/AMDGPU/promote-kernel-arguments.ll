; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa < %s -amdgpu-promote-kernel-arguments -infer-address-spaces | FileCheck %s
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa < %s -passes=amdgpu-promote-kernel-arguments,infer-address-spaces | FileCheck %s
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa < %s -amdgpu-promote-kernel-arguments -infer-address-spaces | llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 | FileCheck -check-prefix=GCN %s

; GCN-LABEL: ptr_nest_3:
; GCN-COUNT-2: global_load_dwordx2
; GCN:         global_store_dword
define amdgpu_kernel void @ptr_nest_3(ptr addrspace(1) nocapture readonly %Arg) {
; CHECK-LABEL: @ptr_nest_3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[I:%.*]] = tail call i32 @llvm.amdgcn.workitem.id.x()
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds ptr, ptr addrspace(1) [[ARG:%.*]], i32 [[I]]
; CHECK-NEXT:    [[P2:%.*]] = load ptr, ptr addrspace(1) [[P1]], align 8, !amdgpu.noclobber [[META0:![0-9]+]]
; CHECK-NEXT:    [[P2_GLOBAL:%.*]] = addrspacecast ptr [[P2]] to ptr addrspace(1)
; CHECK-NEXT:    [[P3:%.*]] = load ptr, ptr addrspace(1) [[P2_GLOBAL]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[P3_GLOBAL:%.*]] = addrspacecast ptr [[P3]] to ptr addrspace(1)
; CHECK-NEXT:    store float 0.000000e+00, ptr addrspace(1) [[P3_GLOBAL]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %i = tail call i32 @llvm.amdgcn.workitem.id.x()
  %p1 = getelementptr inbounds ptr, ptr addrspace(1) %Arg, i32 %i
  %p2 = load ptr, ptr addrspace(1) %p1, align 8
  %p3 = load ptr, ptr %p2, align 8
  store float 0.000000e+00, ptr %p3, align 4
  ret void
}

; GCN-LABEL: ptr_bitcast:
; GCN: global_load_dwordx2
; GCN: global_store_dword
define amdgpu_kernel void @ptr_bitcast(ptr nocapture readonly %Arg) {
; CHECK-LABEL: @ptr_bitcast(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARG_GLOBAL:%.*]] = addrspacecast ptr [[ARG:%.*]] to ptr addrspace(1)
; CHECK-NEXT:    [[I:%.*]] = tail call i32 @llvm.amdgcn.workitem.id.x()
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds ptr, ptr addrspace(1) [[ARG_GLOBAL]], i32 [[I]]
; CHECK-NEXT:    [[P2:%.*]] = load ptr, ptr addrspace(1) [[P1]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[P2_GLOBAL:%.*]] = addrspacecast ptr [[P2]] to ptr addrspace(1)
; CHECK-NEXT:    store i32 0, ptr addrspace(1) [[P2_GLOBAL]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %i = tail call i32 @llvm.amdgcn.workitem.id.x()
  %p1 = getelementptr inbounds ptr, ptr %Arg, i32 %i
  %p2 = load ptr, ptr %p1, align 8
  store i32 0, ptr %p2, align 4
  ret void
}

%struct.S = type { ptr }

; GCN-LABEL: ptr_in_struct:
; GCN: s_load_dwordx2
; GCN: global_store_dword
define amdgpu_kernel void @ptr_in_struct(ptr addrspace(1) nocapture readonly %Arg) {
; CHECK-LABEL: @ptr_in_struct(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[P1:%.*]] = load ptr, ptr addrspace(1) [[ARG:%.*]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[P1_GLOBAL:%.*]] = addrspacecast ptr [[P1]] to ptr addrspace(1)
; CHECK-NEXT:    [[ID:%.*]] = tail call i32 @llvm.amdgcn.workitem.id.x()
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr addrspace(1) [[P1_GLOBAL]], i32 [[ID]]
; CHECK-NEXT:    store float 0.000000e+00, ptr addrspace(1) [[ARRAYIDX]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %p1 = load ptr, ptr addrspace(1) %Arg, align 8
  %id = tail call i32 @llvm.amdgcn.workitem.id.x()
  %arrayidx = getelementptr inbounds float, ptr %p1, i32 %id
  store float 0.000000e+00, ptr %arrayidx, align 4
  ret void
}

@LDS = internal unnamed_addr addrspace(3) global [4 x float] undef, align 16

; GCN-LABEL: flat_ptr_arg:
; GCN-COUNT-2: global_load_dwordx2
; GCN:         global_load_dwordx4
; GCN:         global_store_dword
define amdgpu_kernel void @flat_ptr_arg(ptr nocapture readonly noalias %Arg, ptr nocapture noalias %Out, i32 %X) {
; CHECK-LABEL: @flat_ptr_arg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OUT_GLOBAL:%.*]] = addrspacecast ptr [[OUT:%.*]] to ptr addrspace(1)
; CHECK-NEXT:    [[ARG_GLOBAL:%.*]] = addrspacecast ptr [[ARG:%.*]] to ptr addrspace(1)
; CHECK-NEXT:    [[I:%.*]] = tail call i32 @llvm.amdgcn.workitem.id.x()
; CHECK-NEXT:    [[IDXPROM:%.*]] = zext i32 [[I]] to i64
; CHECK-NEXT:    [[ARRAYIDX10:%.*]] = getelementptr inbounds ptr, ptr addrspace(1) [[ARG_GLOBAL]], i64 [[IDXPROM]]
; CHECK-NEXT:    [[I1:%.*]] = load ptr, ptr addrspace(1) [[ARRAYIDX10]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[I1_GLOBAL:%.*]] = addrspacecast ptr [[I1]] to ptr addrspace(1)
; CHECK-NEXT:    [[I2:%.*]] = load float, ptr addrspace(1) [[I1_GLOBAL]], align 4, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[ARRAYIDX512:%.*]] = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 [[X:%.*]]
; CHECK-NEXT:    store float [[I2]], ptr addrspace(3) [[ARRAYIDX512]], align 4
; CHECK-NEXT:    [[ARRAYIDX3_1:%.*]] = getelementptr inbounds float, ptr addrspace(1) [[I1_GLOBAL]], i64 1
; CHECK-NEXT:    [[I3:%.*]] = load float, ptr addrspace(1) [[ARRAYIDX3_1]], align 4
; CHECK-NEXT:    [[ADD_1:%.*]] = add nsw i32 [[X]], 1
; CHECK-NEXT:    [[ARRAYIDX512_1:%.*]] = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 [[ADD_1]]
; CHECK-NEXT:    store float [[I3]], ptr addrspace(3) [[ARRAYIDX512_1]], align 4
; CHECK-NEXT:    [[ARRAYIDX3_2:%.*]] = getelementptr inbounds float, ptr addrspace(1) [[I1_GLOBAL]], i64 2
; CHECK-NEXT:    [[I4:%.*]] = load float, ptr addrspace(1) [[ARRAYIDX3_2]], align 4
; CHECK-NEXT:    [[ADD_2:%.*]] = add nsw i32 [[X]], 2
; CHECK-NEXT:    [[ARRAYIDX512_2:%.*]] = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 [[ADD_2]]
; CHECK-NEXT:    store float [[I4]], ptr addrspace(3) [[ARRAYIDX512_2]], align 4
; CHECK-NEXT:    [[ARRAYIDX3_3:%.*]] = getelementptr inbounds float, ptr addrspace(1) [[I1_GLOBAL]], i64 3
; CHECK-NEXT:    [[I5:%.*]] = load float, ptr addrspace(1) [[ARRAYIDX3_3]], align 4
; CHECK-NEXT:    [[ADD_3:%.*]] = add nsw i32 [[X]], 3
; CHECK-NEXT:    [[ARRAYIDX512_3:%.*]] = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 [[ADD_3]]
; CHECK-NEXT:    store float [[I5]], ptr addrspace(3) [[ARRAYIDX512_3]], align 4
; CHECK-NEXT:    [[SUB:%.*]] = add nsw i32 [[X]], -1
; CHECK-NEXT:    [[ARRAYIDX711:%.*]] = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 [[SUB]]
; CHECK-NEXT:    [[I6:%.*]] = load float, ptr addrspace(3) [[ARRAYIDX711]], align 4
; CHECK-NEXT:    [[ARRAYIDX11:%.*]] = getelementptr inbounds ptr, ptr addrspace(1) [[OUT_GLOBAL]], i64 [[IDXPROM]]
; CHECK-NEXT:    [[I7:%.*]] = load ptr, ptr addrspace(1) [[ARRAYIDX11]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[I7_GLOBAL:%.*]] = addrspacecast ptr [[I7]] to ptr addrspace(1)
; CHECK-NEXT:    [[IDXPROM8:%.*]] = sext i32 [[X]] to i64
; CHECK-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds float, ptr addrspace(1) [[I7_GLOBAL]], i64 [[IDXPROM8]]
; CHECK-NEXT:    store float [[I6]], ptr addrspace(1) [[ARRAYIDX9]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %i = tail call i32 @llvm.amdgcn.workitem.id.x()
  %idxprom = zext i32 %i to i64
  %arrayidx10 = getelementptr inbounds ptr, ptr %Arg, i64 %idxprom
  %i1 = load ptr, ptr %arrayidx10, align 8
  %i2 = load float, ptr %i1, align 4
  %arrayidx512 = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 %X
  store float %i2, ptr addrspace(3) %arrayidx512, align 4
  %arrayidx3.1 = getelementptr inbounds float, ptr %i1, i64 1
  %i3 = load float, ptr %arrayidx3.1, align 4
  %add.1 = add nsw i32 %X, 1
  %arrayidx512.1 = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 %add.1
  store float %i3, ptr addrspace(3) %arrayidx512.1, align 4
  %arrayidx3.2 = getelementptr inbounds float, ptr %i1, i64 2
  %i4 = load float, ptr %arrayidx3.2, align 4
  %add.2 = add nsw i32 %X, 2
  %arrayidx512.2 = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 %add.2
  store float %i4, ptr addrspace(3) %arrayidx512.2, align 4
  %arrayidx3.3 = getelementptr inbounds float, ptr %i1, i64 3
  %i5 = load float, ptr %arrayidx3.3, align 4
  %add.3 = add nsw i32 %X, 3
  %arrayidx512.3 = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 %add.3
  store float %i5, ptr addrspace(3) %arrayidx512.3, align 4
  %sub = add nsw i32 %X, -1
  %arrayidx711 = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 %sub
  %i6 = load float, ptr addrspace(3) %arrayidx711, align 4
  %arrayidx11 = getelementptr inbounds ptr, ptr %Out, i64 %idxprom
  %i7 = load ptr, ptr %arrayidx11, align 8
  %idxprom8 = sext i32 %X to i64
  %arrayidx9 = getelementptr inbounds float, ptr %i7, i64 %idxprom8
  store float %i6, ptr %arrayidx9, align 4
  ret void
}

; GCN-LABEL: global_ptr_arg:
; GCN: global_load_dwordx2
; GCN: global_load_dwordx4
; GCN: global_store_dword
define amdgpu_kernel void @global_ptr_arg(ptr addrspace(1) nocapture readonly %Arg, i32 %X) {
; CHECK-LABEL: @global_ptr_arg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[I:%.*]] = tail call i32 @llvm.amdgcn.workitem.id.x()
; CHECK-NEXT:    [[IDXPROM:%.*]] = zext i32 [[I]] to i64
; CHECK-NEXT:    [[ARRAYIDX10:%.*]] = getelementptr inbounds ptr, ptr addrspace(1) [[ARG:%.*]], i64 [[IDXPROM]]
; CHECK-NEXT:    [[I1:%.*]] = load ptr, ptr addrspace(1) [[ARRAYIDX10]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[I1_GLOBAL:%.*]] = addrspacecast ptr [[I1]] to ptr addrspace(1)
; CHECK-NEXT:    [[I2:%.*]] = load float, ptr addrspace(1) [[I1_GLOBAL]], align 4, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[ARRAYIDX512:%.*]] = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 [[X:%.*]]
; CHECK-NEXT:    store float [[I2]], ptr addrspace(3) [[ARRAYIDX512]], align 4
; CHECK-NEXT:    [[ARRAYIDX3_1:%.*]] = getelementptr inbounds float, ptr addrspace(1) [[I1_GLOBAL]], i64 1
; CHECK-NEXT:    [[I3:%.*]] = load float, ptr addrspace(1) [[ARRAYIDX3_1]], align 4
; CHECK-NEXT:    [[ADD_1:%.*]] = add nsw i32 [[X]], 1
; CHECK-NEXT:    [[ARRAYIDX512_1:%.*]] = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 [[ADD_1]]
; CHECK-NEXT:    store float [[I3]], ptr addrspace(3) [[ARRAYIDX512_1]], align 4
; CHECK-NEXT:    [[ARRAYIDX3_2:%.*]] = getelementptr inbounds float, ptr addrspace(1) [[I1_GLOBAL]], i64 2
; CHECK-NEXT:    [[I4:%.*]] = load float, ptr addrspace(1) [[ARRAYIDX3_2]], align 4
; CHECK-NEXT:    [[ADD_2:%.*]] = add nsw i32 [[X]], 2
; CHECK-NEXT:    [[ARRAYIDX512_2:%.*]] = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 [[ADD_2]]
; CHECK-NEXT:    store float [[I4]], ptr addrspace(3) [[ARRAYIDX512_2]], align 4
; CHECK-NEXT:    [[ARRAYIDX3_3:%.*]] = getelementptr inbounds float, ptr addrspace(1) [[I1_GLOBAL]], i64 3
; CHECK-NEXT:    [[I5:%.*]] = load float, ptr addrspace(1) [[ARRAYIDX3_3]], align 4
; CHECK-NEXT:    [[ADD_3:%.*]] = add nsw i32 [[X]], 3
; CHECK-NEXT:    [[ARRAYIDX512_3:%.*]] = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 [[ADD_3]]
; CHECK-NEXT:    store float [[I5]], ptr addrspace(3) [[ARRAYIDX512_3]], align 4
; CHECK-NEXT:    [[SUB:%.*]] = add nsw i32 [[X]], -1
; CHECK-NEXT:    [[ARRAYIDX711:%.*]] = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 [[SUB]]
; CHECK-NEXT:    [[I6:%.*]] = load float, ptr addrspace(3) [[ARRAYIDX711]], align 4
; CHECK-NEXT:    [[IDXPROM8:%.*]] = sext i32 [[X]] to i64
; CHECK-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds float, ptr addrspace(1) [[I1_GLOBAL]], i64 [[IDXPROM8]]
; CHECK-NEXT:    store float [[I6]], ptr addrspace(1) [[ARRAYIDX9]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %i = tail call i32 @llvm.amdgcn.workitem.id.x()
  %idxprom = zext i32 %i to i64
  %arrayidx10 = getelementptr inbounds ptr, ptr addrspace(1) %Arg, i64 %idxprom
  %i1 = load ptr, ptr addrspace(1) %arrayidx10, align 8
  %i2 = load float, ptr %i1, align 4
  %arrayidx512 = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 %X
  store float %i2, ptr addrspace(3) %arrayidx512, align 4
  %arrayidx3.1 = getelementptr inbounds float, ptr %i1, i64 1
  %i3 = load float, ptr %arrayidx3.1, align 4
  %add.1 = add nsw i32 %X, 1
  %arrayidx512.1 = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 %add.1
  store float %i3, ptr addrspace(3) %arrayidx512.1, align 4
  %arrayidx3.2 = getelementptr inbounds float, ptr %i1, i64 2
  %i4 = load float, ptr %arrayidx3.2, align 4
  %add.2 = add nsw i32 %X, 2
  %arrayidx512.2 = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 %add.2
  store float %i4, ptr addrspace(3) %arrayidx512.2, align 4
  %arrayidx3.3 = getelementptr inbounds float, ptr %i1, i64 3
  %i5 = load float, ptr %arrayidx3.3, align 4
  %add.3 = add nsw i32 %X, 3
  %arrayidx512.3 = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 %add.3
  store float %i5, ptr addrspace(3) %arrayidx512.3, align 4
  %sub = add nsw i32 %X, -1
  %arrayidx711 = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 %sub
  %i6 = load float, ptr addrspace(3) %arrayidx711, align 4
  %idxprom8 = sext i32 %X to i64
  %arrayidx9 = getelementptr inbounds float, ptr %i1, i64 %idxprom8
  store float %i6, ptr %arrayidx9, align 4
  ret void
}

; GCN-LABEL: global_ptr_arg_clobbered:
; GCN: global_store_dwordx2
; GCN: global_load_dwordx2
; GCN: flat_load_dword
; GCN: flat_store_dword
define amdgpu_kernel void @global_ptr_arg_clobbered(ptr addrspace(1) nocapture readonly %Arg, i32 %X) {
; CHECK-LABEL: @global_ptr_arg_clobbered(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[I:%.*]] = tail call i32 @llvm.amdgcn.workitem.id.x()
; CHECK-NEXT:    [[IDXPROM:%.*]] = zext i32 [[I]] to i64
; CHECK-NEXT:    [[ARRAYIDX10:%.*]] = getelementptr inbounds ptr, ptr addrspace(1) [[ARG:%.*]], i64 [[IDXPROM]]
; CHECK-NEXT:    [[ARRAYIDX11:%.*]] = getelementptr inbounds ptr, ptr addrspace(1) [[ARRAYIDX10]], i32 [[X:%.*]]
; CHECK-NEXT:    store ptr null, ptr addrspace(1) [[ARRAYIDX11]], align 4
; CHECK-NEXT:    [[I1:%.*]] = load ptr, ptr addrspace(1) [[ARRAYIDX10]], align 8
; CHECK-NEXT:    [[I2:%.*]] = load float, ptr [[I1]], align 4
; CHECK-NEXT:    [[ARRAYIDX512:%.*]] = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 [[X]]
; CHECK-NEXT:    store float [[I2]], ptr addrspace(3) [[ARRAYIDX512]], align 4
; CHECK-NEXT:    [[SUB:%.*]] = add nsw i32 [[X]], -1
; CHECK-NEXT:    [[ARRAYIDX711:%.*]] = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 [[SUB]]
; CHECK-NEXT:    [[I6:%.*]] = load float, ptr addrspace(3) [[ARRAYIDX711]], align 4
; CHECK-NEXT:    [[IDXPROM8:%.*]] = sext i32 [[X]] to i64
; CHECK-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds float, ptr [[I1]], i64 [[IDXPROM8]]
; CHECK-NEXT:    store float [[I6]], ptr [[ARRAYIDX9]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %i = tail call i32 @llvm.amdgcn.workitem.id.x()
  %idxprom = zext i32 %i to i64
  %arrayidx10 = getelementptr inbounds ptr, ptr addrspace(1) %Arg, i64 %idxprom
  %arrayidx11 = getelementptr inbounds ptr, ptr addrspace(1) %arrayidx10, i32 %X
  store ptr null, ptr addrspace(1) %arrayidx11, align 4
  %i1 = load ptr, ptr addrspace(1) %arrayidx10, align 8
  %i2 = load float, ptr %i1, align 4
  %arrayidx512 = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 %X
  store float %i2, ptr addrspace(3) %arrayidx512, align 4
  %sub = add nsw i32 %X, -1
  %arrayidx711 = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 %sub
  %i6 = load float, ptr addrspace(3) %arrayidx711, align 4
  %idxprom8 = sext i32 %X to i64
  %arrayidx9 = getelementptr inbounds float, ptr %i1, i64 %idxprom8
  store float %i6, ptr %arrayidx9, align 4
  ret void
}

; GCN-LABEL: global_ptr_arg_clobbered_after_load:
; GCN: global_load_dwordx2
; GCN: global_store_dwordx2
; GCN: global_load_dword
; GCN: global_store_dword
define amdgpu_kernel void @global_ptr_arg_clobbered_after_load(ptr addrspace(1) nocapture readonly %Arg, i32 %X) {
; CHECK-LABEL: @global_ptr_arg_clobbered_after_load(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[I:%.*]] = tail call i32 @llvm.amdgcn.workitem.id.x()
; CHECK-NEXT:    [[IDXPROM:%.*]] = zext i32 [[I]] to i64
; CHECK-NEXT:    [[ARRAYIDX10:%.*]] = getelementptr inbounds ptr, ptr addrspace(1) [[ARG:%.*]], i64 [[IDXPROM]]
; CHECK-NEXT:    [[I1:%.*]] = load ptr, ptr addrspace(1) [[ARRAYIDX10]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[I1_GLOBAL:%.*]] = addrspacecast ptr [[I1]] to ptr addrspace(1)
; CHECK-NEXT:    [[ARRAYIDX11:%.*]] = getelementptr inbounds ptr, ptr addrspace(1) [[ARRAYIDX10]], i32 [[X:%.*]]
; CHECK-NEXT:    store ptr null, ptr addrspace(1) [[ARRAYIDX11]], align 4
; CHECK-NEXT:    [[I2:%.*]] = load float, ptr addrspace(1) [[I1_GLOBAL]], align 4
; CHECK-NEXT:    [[ARRAYIDX512:%.*]] = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 [[X]]
; CHECK-NEXT:    store float [[I2]], ptr addrspace(3) [[ARRAYIDX512]], align 4
; CHECK-NEXT:    [[SUB:%.*]] = add nsw i32 [[X]], -1
; CHECK-NEXT:    [[ARRAYIDX711:%.*]] = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 [[SUB]]
; CHECK-NEXT:    [[I6:%.*]] = load float, ptr addrspace(3) [[ARRAYIDX711]], align 4
; CHECK-NEXT:    [[IDXPROM8:%.*]] = sext i32 [[X]] to i64
; CHECK-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds float, ptr addrspace(1) [[I1_GLOBAL]], i64 [[IDXPROM8]]
; CHECK-NEXT:    store float [[I6]], ptr addrspace(1) [[ARRAYIDX9]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %i = tail call i32 @llvm.amdgcn.workitem.id.x()
  %idxprom = zext i32 %i to i64
  %arrayidx10 = getelementptr inbounds ptr, ptr addrspace(1) %Arg, i64 %idxprom
  %i1 = load ptr, ptr addrspace(1) %arrayidx10, align 8
  %arrayidx11 = getelementptr inbounds ptr, ptr addrspace(1) %arrayidx10, i32 %X
  store ptr null, ptr addrspace(1) %arrayidx11, align 4
  %i2 = load float, ptr %i1, align 4
  %arrayidx512 = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 %X
  store float %i2, ptr addrspace(3) %arrayidx512, align 4
  %sub = add nsw i32 %X, -1
  %arrayidx711 = getelementptr inbounds [4 x float], ptr addrspace(3) @LDS, i32 0, i32 %sub
  %i6 = load float, ptr addrspace(3) %arrayidx711, align 4
  %idxprom8 = sext i32 %X to i64
  %arrayidx9 = getelementptr inbounds float, ptr %i1, i64 %idxprom8
  store float %i6, ptr %arrayidx9, align 4
  ret void
}

; GCN-LABEL: ptr_nest_3_barrier:
; GCN-COUNT-2: global_load_dwordx2
; GCN:         global_store_dword
define amdgpu_kernel void @ptr_nest_3_barrier(ptr addrspace(1) nocapture readonly %Arg) {
; CHECK-LABEL: @ptr_nest_3_barrier(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[I:%.*]] = tail call i32 @llvm.amdgcn.workitem.id.x()
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds ptr, ptr addrspace(1) [[ARG:%.*]], i32 [[I]]
; CHECK-NEXT:    tail call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    [[P2:%.*]] = load ptr, ptr addrspace(1) [[P1]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[P2_GLOBAL:%.*]] = addrspacecast ptr [[P2]] to ptr addrspace(1)
; CHECK-NEXT:    [[P3:%.*]] = load ptr, ptr addrspace(1) [[P2_GLOBAL]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[P3_GLOBAL:%.*]] = addrspacecast ptr [[P3]] to ptr addrspace(1)
; CHECK-NEXT:    store float 0.000000e+00, ptr addrspace(1) [[P3_GLOBAL]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %i = tail call i32 @llvm.amdgcn.workitem.id.x()
  %p1 = getelementptr inbounds ptr, ptr addrspace(1) %Arg, i32 %i
  tail call void @llvm.amdgcn.s.barrier()
  %p2 = load ptr, ptr addrspace(1) %p1, align 8
  %p3 = load ptr, ptr %p2, align 8
  store float 0.000000e+00, ptr %p3, align 4
  ret void
}

; GCN-LABEL: flat_ptr_nest_2:
; GCN: s_lshl_b64
; GCN: s_load_dwordx2
; GCN: global_store_dword
define amdgpu_kernel void @flat_ptr_nest_2(ptr nocapture readonly %Arg, i32 %i) {
; CHECK-LABEL: @flat_ptr_nest_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARG_GLOBAL:%.*]] = addrspacecast ptr [[ARG:%.*]] to ptr addrspace(1)
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds ptr, ptr addrspace(1) [[ARG_GLOBAL]], i32 [[I:%.*]]
; CHECK-NEXT:    [[P2:%.*]] = load ptr, ptr addrspace(1) [[P1]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[P2_GLOBAL:%.*]] = addrspacecast ptr [[P2]] to ptr addrspace(1)
; CHECK-NEXT:    store float 0.000000e+00, ptr addrspace(1) [[P2_GLOBAL]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %p1 = getelementptr inbounds ptr, ptr %Arg, i32 %i
  %p2 = load ptr, ptr %p1, align 8
  store float 0.000000e+00, ptr %p2, align 4
  ret void
}

; GCN-LABEL: const_ptr_nest_3:
; GCN: s_lshl_b64
; GCN: s_load_dwordx2
; GCN: s_load_dwordx2
; GCN: global_store_dword
define amdgpu_kernel void @const_ptr_nest_3(ptr addrspace(4) nocapture readonly %Arg, i32 %i) {
; CHECK-LABEL: @const_ptr_nest_3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds ptr addrspace(4), ptr addrspace(4) [[ARG:%.*]], i32 [[I:%.*]]
; CHECK-NEXT:    [[P2:%.*]] = load ptr addrspace(4), ptr addrspace(4) [[P1]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[P3:%.*]] = load ptr, ptr addrspace(4) [[P2]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[TMP0:%.*]] = addrspacecast ptr [[P3]] to ptr addrspace(1)
; CHECK-NEXT:    store float 0.000000e+00, ptr addrspace(1) [[TMP0]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %p1 = getelementptr inbounds ptr addrspace(4), ptr addrspace(4) %Arg, i32 %i
  %p2 = load ptr addrspace(4), ptr addrspace(4) %p1, align 8
  %p3 = load ptr, ptr addrspace(4) %p2, align 8
  store float 0.000000e+00, ptr %p3, align 4
  ret void
}

; GCN-LABEL: cast_from_const_const_ptr_nest_3:
; GCN: s_lshl_b64
; GCN: s_load_dwordx2
; GCN: s_load_dwordx2
; GCN: global_store_dword
define amdgpu_kernel void @cast_from_const_const_ptr_nest_3(ptr addrspace(4) nocapture readonly %Arg, i32 %i) {
; CHECK-LABEL: @cast_from_const_const_ptr_nest_3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds ptr addrspace(4), ptr addrspace(4) [[ARG:%.*]], i32 [[I:%.*]]
; CHECK-NEXT:    [[P2:%.*]] = load ptr addrspace(4), ptr addrspace(4) [[P1]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[P3:%.*]] = load ptr, ptr addrspace(4) [[P2]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[P3_GLOBAL:%.*]] = addrspacecast ptr [[P3]] to ptr addrspace(1)
; CHECK-NEXT:    store float 0.000000e+00, ptr addrspace(1) [[P3_GLOBAL]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %p1 = getelementptr inbounds ptr addrspace(4), ptr addrspace(4) %Arg, i32 %i
  %a1 = addrspacecast ptr addrspace(4) %p1 to ptr
  %p2 = load ptr addrspace(4), ptr %a1, align 8
  %a2 = addrspacecast ptr addrspace(4) %p2 to ptr
  %p3 = load ptr, ptr %a2, align 8
  store float 0.000000e+00, ptr %p3, align 4
  ret void
}

; GCN-LABEL: flat_ptr_volatile_load:
; GCN: s_lshl_b64
; GCN: flat_load_dwordx2
; GCN: global_store_dword
define amdgpu_kernel void @flat_ptr_volatile_load(ptr nocapture readonly %Arg, i32 %i) {
; CHECK-LABEL: @flat_ptr_volatile_load(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARG_GLOBAL:%.*]] = addrspacecast ptr [[ARG:%.*]] to ptr addrspace(1)
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds ptr, ptr addrspace(1) [[ARG_GLOBAL]], i32 [[I:%.*]]
; CHECK-NEXT:    [[TMP0:%.*]] = addrspacecast ptr addrspace(1) [[P1]] to ptr
; CHECK-NEXT:    [[P2:%.*]] = load volatile ptr, ptr [[TMP0]], align 8
; CHECK-NEXT:    [[P2_GLOBAL:%.*]] = addrspacecast ptr [[P2]] to ptr addrspace(1)
; CHECK-NEXT:    store float 0.000000e+00, ptr addrspace(1) [[P2_GLOBAL]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %p1 = getelementptr inbounds ptr, ptr %Arg, i32 %i
  %p2 = load volatile ptr, ptr %p1, align 8
  store float 0.000000e+00, ptr %p2, align 4
  ret void
}

; GCN-LABEL: flat_ptr_atomic_load:
; GCN: s_lshl_b64
; GCN: global_load_dwordx2
; GCN: global_store_dword
define amdgpu_kernel void @flat_ptr_atomic_load(ptr nocapture readonly %Arg, i32 %i) {
; CHECK-LABEL: @flat_ptr_atomic_load(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARG_GLOBAL:%.*]] = addrspacecast ptr [[ARG:%.*]] to ptr addrspace(1)
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds ptr, ptr addrspace(1) [[ARG_GLOBAL]], i32 [[I:%.*]]
; CHECK-NEXT:    [[P2:%.*]] = load atomic ptr, ptr addrspace(1) [[P1]] monotonic, align 8
; CHECK-NEXT:    [[P2_GLOBAL:%.*]] = addrspacecast ptr [[P2]] to ptr addrspace(1)
; CHECK-NEXT:    store float 0.000000e+00, ptr addrspace(1) [[P2_GLOBAL]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %p1 = getelementptr inbounds ptr, ptr %Arg, i32 %i
  %p2 = load atomic ptr, ptr %p1 monotonic, align 8
  store float 0.000000e+00, ptr %p2, align 4
  ret void
}

; GCN-LABEL: cast_changing_pointee_type:
; GCN: s_lshl_b64
; GCN: s_load_dwordx2
; GCN: s_load_dwordx2
; GCN: global_store_dword
define amdgpu_kernel void @cast_changing_pointee_type(ptr addrspace(1) nocapture readonly %Arg, i32 %i) {
; CHECK-LABEL: @cast_changing_pointee_type(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds ptr addrspace(1), ptr addrspace(1) [[ARG:%.*]], i32 [[I:%.*]]
; CHECK-NEXT:    [[P2:%.*]] = load ptr addrspace(1), ptr addrspace(1) [[P1]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[P3:%.*]] = load ptr, ptr addrspace(1) [[P2]], align 8, !amdgpu.noclobber [[META0]]
; CHECK-NEXT:    [[P3_GLOBAL:%.*]] = addrspacecast ptr [[P3]] to ptr addrspace(1)
; CHECK-NEXT:    store float 0.000000e+00, ptr addrspace(1) [[P3_GLOBAL]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %p1 = getelementptr inbounds ptr addrspace(1), ptr addrspace(1) %Arg, i32 %i
  %a1 = addrspacecast ptr addrspace(1) %p1 to ptr
  %p2 = load ptr addrspace(1), ptr %a1, align 8
  %a2 = addrspacecast ptr addrspace(1) %p2 to ptr
  %p3 = load ptr, ptr %a2, align 8
  store float 0.000000e+00, ptr %p3, align 4
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x()
declare void @llvm.amdgcn.s.barrier()