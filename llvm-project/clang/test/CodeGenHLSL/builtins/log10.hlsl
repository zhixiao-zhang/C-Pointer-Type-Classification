// RUN: %clang_cc1 -finclude-default-header -triple dxil-pc-shadermodel6.3-library %s \
// RUN:  -fnative-half-type -emit-llvm -disable-llvm-passes -o - | \
// RUN:  FileCheck %s --check-prefixes=CHECK,NATIVE_HALF
// RUN: %clang_cc1 -finclude-default-header -triple dxil-pc-shadermodel6.3-library %s \
// RUN:  -emit-llvm -disable-llvm-passes -o - | \
// RUN:  FileCheck %s --check-prefixes=CHECK,NO_HALF

// NATIVE_HALF-LABEL: define noundef half @_Z15test_log10_half
// NATIVE_HALF: call half @llvm.log10.f16(
// NO_HALF-LABEL: define noundef float @_Z15test_log10_half
// NO_HALF: call float @llvm.log10.f32(
half test_log10_half(half p0) { return log10(p0); }
// NATIVE_HALF-LABEL: define noundef <2 x half> @_Z16test_log10_half2
// NATIVE_HALF: call <2 x half> @llvm.log10.v2f16
// NO_HALF-LABEL: define noundef <2 x float> @_Z16test_log10_half2
// NO_HALF: call <2 x float> @llvm.log10.v2f32(
half2 test_log10_half2(half2 p0) { return log10(p0); }
// NATIVE_HALF-LABEL: define noundef <3 x half> @_Z16test_log10_half3
// NATIVE_HALF: call <3 x half> @llvm.log10.v3f16
// NO_HALF-LABEL: define noundef <3 x float> @_Z16test_log10_half3
// NO_HALF: call <3 x float> @llvm.log10.v3f32(
half3 test_log10_half3(half3 p0) { return log10(p0); }
// NATIVE_HALF-LABEL: define noundef <4 x half> @_Z16test_log10_half4
// NATIVE_HALF: call <4 x half> @llvm.log10.v4f16
// NO_HALF-LABEL: define noundef <4 x float> @_Z16test_log10_half4
// NO_HALF: call <4 x float> @llvm.log10.v4f32(
half4 test_log10_half4(half4 p0) { return log10(p0); }

// CHECK-LABEL: define noundef float @_Z16test_log10_float
// CHECK: call float @llvm.log10.f32(
float test_log10_float(float p0) { return log10(p0); }
// CHECK-LABEL: define noundef <2 x float> @_Z17test_log10_float2
// CHECK: call <2 x float> @llvm.log10.v2f32
float2 test_log10_float2(float2 p0) { return log10(p0); }
// CHECK-LABEL: define noundef <3 x float> @_Z17test_log10_float3
// CHECK: call <3 x float> @llvm.log10.v3f32
float3 test_log10_float3(float3 p0) { return log10(p0); }
// CHECK-LABEL: define noundef <4 x float> @_Z17test_log10_float4
// CHECK: call <4 x float> @llvm.log10.v4f32
float4 test_log10_float4(float4 p0) { return log10(p0); }