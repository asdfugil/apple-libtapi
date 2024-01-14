// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -no-opaque-pointers -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -no-opaque-pointers -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -no-opaque-pointers -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -no-opaque-pointers -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -no-opaque-pointers -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -o /dev/null %s
#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1, A2_UNUSED, A3, A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1, A2, A3, A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svldff1ub_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldff1.nxv8i8(<vscale x 8 x i1> [[TMP0]], i8* [[BASE:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 8 x i8> [[TMP1]] to <vscale x 8 x i16>
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z18test_svldff1ub_s16u10__SVBool_tPKh(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldff1.nxv8i8(<vscale x 8 x i1> [[TMP0]], i8* [[BASE:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 8 x i8> [[TMP1]] to <vscale x 8 x i16>
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
svint16_t test_svldff1ub_s16(svbool_t pg, const uint8_t *base)
{
  return svldff1ub_s16(pg, base);
}

// CHECK-LABEL: @test_svldff1ub_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[BASE:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z18test_svldff1ub_s32u10__SVBool_tPKh(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[BASE:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svint32_t test_svldff1ub_s32(svbool_t pg, const uint8_t *base)
{
  return svldff1ub_s32(pg, base);
}

// CHECK-LABEL: @test_svldff1ub_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[BASE:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z18test_svldff1ub_s64u10__SVBool_tPKh(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[BASE:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svint64_t test_svldff1ub_s64(svbool_t pg, const uint8_t *base)
{
  return svldff1ub_s64(pg, base);
}

// CHECK-LABEL: @test_svldff1ub_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldff1.nxv8i8(<vscale x 8 x i1> [[TMP0]], i8* [[BASE:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 8 x i8> [[TMP1]] to <vscale x 8 x i16>
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z18test_svldff1ub_u16u10__SVBool_tPKh(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldff1.nxv8i8(<vscale x 8 x i1> [[TMP0]], i8* [[BASE:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 8 x i8> [[TMP1]] to <vscale x 8 x i16>
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
svuint16_t test_svldff1ub_u16(svbool_t pg, const uint8_t *base)
{
  return svldff1ub_u16(pg, base);
}

// CHECK-LABEL: @test_svldff1ub_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[BASE:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z18test_svldff1ub_u32u10__SVBool_tPKh(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[BASE:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svuint32_t test_svldff1ub_u32(svbool_t pg, const uint8_t *base)
{
  return svldff1ub_u32(pg, base);
}

// CHECK-LABEL: @test_svldff1ub_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[BASE:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z18test_svldff1ub_u64u10__SVBool_tPKh(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[BASE:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svuint64_t test_svldff1ub_u64(svbool_t pg, const uint8_t *base)
{
  return svldff1ub_u64(pg, base);
}

// CHECK-LABEL: @test_svldff1ub_vnum_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 8 x i8>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x i8>, <vscale x 8 x i8>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldff1.nxv8i8(<vscale x 8 x i1> [[TMP0]], i8* [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = zext <vscale x 8 x i8> [[TMP3]] to <vscale x 8 x i16>
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z23test_svldff1ub_vnum_s16u10__SVBool_tPKhl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 8 x i8>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x i8>, <vscale x 8 x i8>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldff1.nxv8i8(<vscale x 8 x i1> [[TMP0]], i8* [[TMP2]])
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = zext <vscale x 8 x i8> [[TMP3]] to <vscale x 8 x i16>
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP4]]
//
svint16_t test_svldff1ub_vnum_s16(svbool_t pg, const uint8_t *base, int64_t vnum)
{
  return svldff1ub_vnum_s16(pg, base, vnum);
}

// CHECK-LABEL: @test_svldff1ub_vnum_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 4 x i8>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 4 x i8>, <vscale x 4 x i8>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = zext <vscale x 4 x i8> [[TMP3]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z23test_svldff1ub_vnum_s32u10__SVBool_tPKhl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 4 x i8>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 4 x i8>, <vscale x 4 x i8>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[TMP2]])
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = zext <vscale x 4 x i8> [[TMP3]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP4]]
//
svint32_t test_svldff1ub_vnum_s32(svbool_t pg, const uint8_t *base, int64_t vnum)
{
  return svldff1ub_vnum_s32(pg, base, vnum);
}

// CHECK-LABEL: @test_svldff1ub_vnum_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 2 x i8>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 2 x i8>, <vscale x 2 x i8>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = zext <vscale x 2 x i8> [[TMP3]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z23test_svldff1ub_vnum_s64u10__SVBool_tPKhl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 2 x i8>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 2 x i8>, <vscale x 2 x i8>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[TMP2]])
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = zext <vscale x 2 x i8> [[TMP3]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP4]]
//
svint64_t test_svldff1ub_vnum_s64(svbool_t pg, const uint8_t *base, int64_t vnum)
{
  return svldff1ub_vnum_s64(pg, base, vnum);
}

// CHECK-LABEL: @test_svldff1ub_vnum_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 8 x i8>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x i8>, <vscale x 8 x i8>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldff1.nxv8i8(<vscale x 8 x i1> [[TMP0]], i8* [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = zext <vscale x 8 x i8> [[TMP3]] to <vscale x 8 x i16>
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z23test_svldff1ub_vnum_u16u10__SVBool_tPKhl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 8 x i8>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x i8>, <vscale x 8 x i8>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x i8> @llvm.aarch64.sve.ldff1.nxv8i8(<vscale x 8 x i1> [[TMP0]], i8* [[TMP2]])
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = zext <vscale x 8 x i8> [[TMP3]] to <vscale x 8 x i16>
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP4]]
//
svuint16_t test_svldff1ub_vnum_u16(svbool_t pg, const uint8_t *base, int64_t vnum)
{
  return svldff1ub_vnum_u16(pg, base, vnum);
}

// CHECK-LABEL: @test_svldff1ub_vnum_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 4 x i8>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 4 x i8>, <vscale x 4 x i8>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = zext <vscale x 4 x i8> [[TMP3]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z23test_svldff1ub_vnum_u32u10__SVBool_tPKhl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 4 x i8>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 4 x i8>, <vscale x 4 x i8>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[TMP2]])
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = zext <vscale x 4 x i8> [[TMP3]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP4]]
//
svuint32_t test_svldff1ub_vnum_u32(svbool_t pg, const uint8_t *base, int64_t vnum)
{
  return svldff1ub_vnum_u32(pg, base, vnum);
}

// CHECK-LABEL: @test_svldff1ub_vnum_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 2 x i8>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 2 x i8>, <vscale x 2 x i8>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = zext <vscale x 2 x i8> [[TMP3]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z23test_svldff1ub_vnum_u64u10__SVBool_tPKhl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 2 x i8>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 2 x i8>, <vscale x 2 x i8>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[TMP2]])
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = zext <vscale x 2 x i8> [[TMP3]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP4]]
//
svuint64_t test_svldff1ub_vnum_u64(svbool_t pg, const uint8_t *base, int64_t vnum)
{
  return svldff1ub_vnum_u64(pg, base, vnum);
}

// CHECK-LABEL: @test_svldff1ub_gather_u32base_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 0)
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z33test_svldff1ub_gather_u32base_s32u10__SVBool_tu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svint32_t test_svldff1ub_gather_u32base_s32(svbool_t pg, svuint32_t bases) {
  return SVE_ACLE_FUNC(svldff1ub_gather, _u32base, _s32, )(pg, bases);
}

// CHECK-LABEL: @test_svldff1ub_gather_u64base_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 0)
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z33test_svldff1ub_gather_u64base_s64u10__SVBool_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svint64_t test_svldff1ub_gather_u64base_s64(svbool_t pg, svuint64_t bases) {
  return SVE_ACLE_FUNC(svldff1ub_gather, _u64base, _s64, )(pg, bases);
}

// CHECK-LABEL: @test_svldff1ub_gather_u32base_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 0)
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z33test_svldff1ub_gather_u32base_u32u10__SVBool_tu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svuint32_t test_svldff1ub_gather_u32base_u32(svbool_t pg, svuint32_t bases) {
  return SVE_ACLE_FUNC(svldff1ub_gather, _u32base, _u32, )(pg, bases);
}

// CHECK-LABEL: @test_svldff1ub_gather_u64base_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 0)
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z33test_svldff1ub_gather_u64base_u64u10__SVBool_tu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svuint64_t test_svldff1ub_gather_u64base_u64(svbool_t pg, svuint64_t bases) {
  return SVE_ACLE_FUNC(svldff1ub_gather, _u64base, _u64, )(pg, bases);
}

// CHECK-LABEL: @test_svldff1ub_gather_s32offset_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.sxtw.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 4 x i32> [[OFFSETS:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z35test_svldff1ub_gather_s32offset_s32u10__SVBool_tPKhu11__SVInt32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.sxtw.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 4 x i32> [[OFFSETS:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svint32_t test_svldff1ub_gather_s32offset_s32(svbool_t pg, const uint8_t *base, svint32_t offsets) {
  return SVE_ACLE_FUNC(svldff1ub_gather_, s32, offset_s32, )(pg, base, offsets);
}

// CHECK-LABEL: @test_svldff1ub_gather_s64offset_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z35test_svldff1ub_gather_s64offset_s64u10__SVBool_tPKhu11__SVInt64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svint64_t test_svldff1ub_gather_s64offset_s64(svbool_t pg, const uint8_t *base, svint64_t offsets) {
  return SVE_ACLE_FUNC(svldff1ub_gather_, s64, offset_s64, )(pg, base, offsets);
}

// CHECK-LABEL: @test_svldff1ub_gather_s32offset_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.sxtw.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 4 x i32> [[OFFSETS:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z35test_svldff1ub_gather_s32offset_u32u10__SVBool_tPKhu11__SVInt32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.sxtw.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 4 x i32> [[OFFSETS:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svuint32_t test_svldff1ub_gather_s32offset_u32(svbool_t pg, const uint8_t *base, svint32_t offsets) {
  return SVE_ACLE_FUNC(svldff1ub_gather_, s32, offset_u32, )(pg, base, offsets);
}

// CHECK-LABEL: @test_svldff1ub_gather_s64offset_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z35test_svldff1ub_gather_s64offset_u64u10__SVBool_tPKhu11__SVInt64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svuint64_t test_svldff1ub_gather_s64offset_u64(svbool_t pg, const uint8_t *base, svint64_t offsets) {
  return SVE_ACLE_FUNC(svldff1ub_gather_, s64, offset_u64, )(pg, base, offsets);
}

// CHECK-LABEL: @test_svldff1ub_gather_u32offset_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.uxtw.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 4 x i32> [[OFFSETS:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z35test_svldff1ub_gather_u32offset_s32u10__SVBool_tPKhu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.uxtw.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 4 x i32> [[OFFSETS:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svint32_t test_svldff1ub_gather_u32offset_s32(svbool_t pg, const uint8_t *base, svuint32_t offsets) {
  return SVE_ACLE_FUNC(svldff1ub_gather_, u32, offset_s32, )(pg, base, offsets);
}

// CHECK-LABEL: @test_svldff1ub_gather_u64offset_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z35test_svldff1ub_gather_u64offset_s64u10__SVBool_tPKhu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svint64_t test_svldff1ub_gather_u64offset_s64(svbool_t pg, const uint8_t *base, svuint64_t offsets) {
  return SVE_ACLE_FUNC(svldff1ub_gather_, u64, offset_s64, )(pg, base, offsets);
}

// CHECK-LABEL: @test_svldff1ub_gather_u32offset_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.uxtw.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 4 x i32> [[OFFSETS:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z35test_svldff1ub_gather_u32offset_u32u10__SVBool_tPKhu12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.uxtw.nxv4i8(<vscale x 4 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 4 x i32> [[OFFSETS:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svuint32_t test_svldff1ub_gather_u32offset_u32(svbool_t pg, const uint8_t *base, svuint32_t offsets) {
  return SVE_ACLE_FUNC(svldff1ub_gather_, u32, offset_u32, )(pg, base, offsets);
}

// CHECK-LABEL: @test_svldff1ub_gather_u64offset_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z35test_svldff1ub_gather_u64offset_u64u10__SVBool_tPKhu12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<vscale x 2 x i1> [[TMP0]], i8* [[BASE:%.*]], <vscale x 2 x i64> [[OFFSETS:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svuint64_t test_svldff1ub_gather_u64offset_u64(svbool_t pg, const uint8_t *base, svuint64_t offsets) {
  return SVE_ACLE_FUNC(svldff1ub_gather_, u64, offset_u64, )(pg, base, offsets);
}

// CHECK-LABEL: @test_svldff1ub_gather_u32base_offset_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z40test_svldff1ub_gather_u32base_offset_s32u10__SVBool_tu12__SVUint32_tl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svint32_t test_svldff1ub_gather_u32base_offset_s32(svbool_t pg, svuint32_t bases, int64_t offset) {
  return SVE_ACLE_FUNC(svldff1ub_gather, _u32base, _offset_s32, )(pg, bases, offset);
}

// CHECK-LABEL: @test_svldff1ub_gather_u64base_offset_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z40test_svldff1ub_gather_u64base_offset_s64u10__SVBool_tu12__SVUint64_tl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svint64_t test_svldff1ub_gather_u64base_offset_s64(svbool_t pg, svuint64_t bases, int64_t offset) {
  return SVE_ACLE_FUNC(svldff1ub_gather, _u64base, _offset_s64, )(pg, bases, offset);
}

// CHECK-LABEL: @test_svldff1ub_gather_u32base_offset_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z40test_svldff1ub_gather_u32base_offset_u32u10__SVBool_tu12__SVUint32_tl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv4i8.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 4 x i8> [[TMP1]] to <vscale x 4 x i32>
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svuint32_t test_svldff1ub_gather_u32base_offset_u32(svbool_t pg, svuint32_t bases, int64_t offset) {
  return SVE_ACLE_FUNC(svldff1ub_gather, _u32base, _offset_u32, )(pg, bases, offset);
}

// CHECK-LABEL: @test_svldff1ub_gather_u64base_offset_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z40test_svldff1ub_gather_u64base_offset_u64u10__SVBool_tu12__SVUint64_tl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i8> @llvm.aarch64.sve.ldff1.gather.scalar.offset.nxv2i8.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[BASES:%.*]], i64 [[OFFSET:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = zext <vscale x 2 x i8> [[TMP1]] to <vscale x 2 x i64>
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svuint64_t test_svldff1ub_gather_u64base_offset_u64(svbool_t pg, svuint64_t bases, int64_t offset) {
  return SVE_ACLE_FUNC(svldff1ub_gather, _u64base, _offset_u64, )(pg, bases, offset);
}
