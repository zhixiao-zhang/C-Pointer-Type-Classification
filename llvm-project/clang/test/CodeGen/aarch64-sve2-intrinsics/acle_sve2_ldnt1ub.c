// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple aarch64 -target-feature +sve -target-feature +sve2 -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple aarch64 -target-feature +sve -target-feature +sve2 -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64 -target-feature +sve -target-feature +sve2 -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64 -target-feature +sve -target-feature +sve2 -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK

// REQUIRES: aarch64-registered-target

#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1, A2_UNUSED, A3, A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1, A2, A3, A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svldnt1ub_gather_u32base_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 0)
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z33test_svldnt1ub_gather_u32base_s32u10__SVBool_tu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svint32_t test_svldnt1ub_gather_u32base_s32(svbool_t pg, svuint32_t bases) {
  return SVE_ACLE_FUNC(svldnt1ub_gather, _u32base, _s32, )(pg, bases);
}

// CHECK-LABEL: @test_svldnt1ub_gather_u64base_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 0)
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z33test_svldnt1ub_gather_u64base_s64u10__SVBool_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svint64_t test_svldnt1ub_gather_u64base_s64(svbool_t pg, svuint64_t bases) {
  return SVE_ACLE_FUNC(svldnt1ub_gather, _u64base, _s64, )(pg, bases);
}

// CHECK-LABEL: @test_svldnt1ub_gather_u32base_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 0)
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z33test_svldnt1ub_gather_u32base_u32u10__SVBool_tu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svuint32_t test_svldnt1ub_gather_u32base_u32(svbool_t pg, svuint32_t bases) {
  return SVE_ACLE_FUNC(svldnt1ub_gather, _u32base, _u32, )(pg, bases);
}

// CHECK-LABEL: @test_svldnt1ub_gather_u64base_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 0)
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z33test_svldnt1ub_gather_u64base_u64u10__SVBool_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svuint64_t test_svldnt1ub_gather_u64base_u64(svbool_t pg, svuint64_t bases) {
  return SVE_ACLE_FUNC(svldnt1ub_gather, _u64base, _u64, )(pg, bases);
}

// CHECK-LABEL: @test_svldnt1ub_gather_s64offset_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z35test_svldnt1ub_gather_s64offset_s64u10__SVBool_tPKhu11__SVInt64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svint64_t test_svldnt1ub_gather_s64offset_s64(svbool_t pg, const uint8_t *base, svint64_t offsets) {
  return SVE_ACLE_FUNC(svldnt1ub_gather_, s64, offset_s64, )(pg, base, offsets);
}

// CHECK-LABEL: @test_svldnt1ub_gather_s64offset_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z35test_svldnt1ub_gather_s64offset_u64u10__SVBool_tPKhu11__SVInt64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svuint64_t test_svldnt1ub_gather_s64offset_u64(svbool_t pg, const uint8_t *base, svint64_t offsets) {
  return SVE_ACLE_FUNC(svldnt1ub_gather_, s64, offset_u64, )(pg, base, offsets);
}

// CHECK-LABEL: @test_svldnt1ub_gather_u32offset_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnt1.gather.uxtw.nxv4i8(<vscale x 4 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 4 x i32> [[OFFSETS:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z35test_svldnt1ub_gather_u32offset_s32u10__SVBool_tPKhu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnt1.gather.uxtw.nxv4i8(<vscale x 4 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 4 x i32> [[OFFSETS:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svint32_t test_svldnt1ub_gather_u32offset_s32(svbool_t pg, const uint8_t *base, svuint32_t offsets) {
  return SVE_ACLE_FUNC(svldnt1ub_gather_, u32, offset_s32, )(pg, base, offsets);
}

// CHECK-LABEL: @test_svldnt1ub_gather_u64offset_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z35test_svldnt1ub_gather_u64offset_s64u10__SVBool_tPKhu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svint64_t test_svldnt1ub_gather_u64offset_s64(svbool_t pg, const uint8_t *base, svuint64_t offsets) {
  return SVE_ACLE_FUNC(svldnt1ub_gather_, u64, offset_s64, )(pg, base, offsets);
}

// CHECK-LABEL: @test_svldnt1ub_gather_u32offset_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnt1.gather.uxtw.nxv4i8(<vscale x 4 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 4 x i32> [[OFFSETS:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z35test_svldnt1ub_gather_u32offset_u32u10__SVBool_tPKhu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnt1.gather.uxtw.nxv4i8(<vscale x 4 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 4 x i32> [[OFFSETS:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svuint32_t test_svldnt1ub_gather_u32offset_u32(svbool_t pg, const uint8_t *base, svuint32_t offsets) {
  return SVE_ACLE_FUNC(svldnt1ub_gather_, u32, offset_u32, )(pg, base, offsets);
}

// CHECK-LABEL: @test_svldnt1ub_gather_u64offset_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z35test_svldnt1ub_gather_u64offset_u64u10__SVBool_tPKhu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], ptr [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svuint64_t test_svldnt1ub_gather_u64offset_u64(svbool_t pg, const uint8_t *base, svuint64_t offsets) {
  return SVE_ACLE_FUNC(svldnt1ub_gather_, u64, offset_u64, )(pg, base, offsets);
}

// CHECK-LABEL: @test_svldnt1ub_gather_u32base_offset_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z40test_svldnt1ub_gather_u32base_offset_s32u10__SVBool_tu12__SVUint32_tl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svint32_t test_svldnt1ub_gather_u32base_offset_s32(svbool_t pg, svuint32_t bases, int64_t offset) {
  return SVE_ACLE_FUNC(svldnt1ub_gather, _u32base, _offset_s32, )(pg, bases, offset);
}

// CHECK-LABEL: @test_svldnt1ub_gather_u64base_offset_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z40test_svldnt1ub_gather_u64base_offset_s64u10__SVBool_tu12__SVUint64_tl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svint64_t test_svldnt1ub_gather_u64base_offset_s64(svbool_t pg, svuint64_t bases, int64_t offset) {
  return SVE_ACLE_FUNC(svldnt1ub_gather, _u64base, _offset_s64, )(pg, bases, offset);
}

// CHECK-LABEL: @test_svldnt1ub_gather_u32base_offset_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z40test_svldnt1ub_gather_u32base_offset_u32u10__SVBool_tu12__SVUint32_tl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svuint32_t test_svldnt1ub_gather_u32base_offset_u32(svbool_t pg, svuint32_t bases, int64_t offset) {
  return SVE_ACLE_FUNC(svldnt1ub_gather, _u32base, _offset_u32, )(pg, bases, offset);
}

// CHECK-LABEL: @test_svldnt1ub_gather_u64base_offset_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z40test_svldnt1ub_gather_u64base_offset_u64u10__SVBool_tu12__SVUint64_tl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldnt1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svuint64_t test_svldnt1ub_gather_u64base_offset_u64(svbool_t pg, svuint64_t bases, int64_t offset) {
  return SVE_ACLE_FUNC(svldnt1ub_gather, _u64base, _offset_u64, )(pg, bases, offset);
}