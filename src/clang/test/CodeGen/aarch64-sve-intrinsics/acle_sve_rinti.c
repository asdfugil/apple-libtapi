// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svrinti_f16_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.frinti.nxv8f16(<vscale x 8 x half> zeroinitializer, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z18test_svrinti_f16_zu10__SVBool_tu13__SVFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.frinti.nxv8f16(<vscale x 8 x half> zeroinitializer, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP1]]
//
svfloat16_t test_svrinti_f16_z(svbool_t pg, svfloat16_t op)
{
  return SVE_ACLE_FUNC(svrinti,_f16,_z,)(pg, op);
}

// CHECK-LABEL: @test_svrinti_f32_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.frinti.nxv4f32(<vscale x 4 x float> zeroinitializer, <vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z18test_svrinti_f32_zu10__SVBool_tu13__SVFloat32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.frinti.nxv4f32(<vscale x 4 x float> zeroinitializer, <vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
//
svfloat32_t test_svrinti_f32_z(svbool_t pg, svfloat32_t op)
{
  return SVE_ACLE_FUNC(svrinti,_f32,_z,)(pg, op);
}

// CHECK-LABEL: @test_svrinti_f64_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.frinti.nxv2f64(<vscale x 2 x double> zeroinitializer, <vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z18test_svrinti_f64_zu10__SVBool_tu13__SVFloat64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.frinti.nxv2f64(<vscale x 2 x double> zeroinitializer, <vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
//
svfloat64_t test_svrinti_f64_z(svbool_t pg, svfloat64_t op)
{
  return SVE_ACLE_FUNC(svrinti,_f64,_z,)(pg, op);
}

// CHECK-LABEL: @test_svrinti_f16_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.frinti.nxv8f16(<vscale x 8 x half> [[INACTIVE:%.*]], <vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z18test_svrinti_f16_mu13__SVFloat16_tu10__SVBool_tu13__SVFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.frinti.nxv8f16(<vscale x 8 x half> [[INACTIVE:%.*]], <vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP1]]
//
svfloat16_t test_svrinti_f16_m(svfloat16_t inactive, svbool_t pg, svfloat16_t op)
{
  return SVE_ACLE_FUNC(svrinti,_f16,_m,)(inactive, pg, op);
}

// CHECK-LABEL: @test_svrinti_f32_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.frinti.nxv4f32(<vscale x 4 x float> [[INACTIVE:%.*]], <vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z18test_svrinti_f32_mu13__SVFloat32_tu10__SVBool_tu13__SVFloat32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.frinti.nxv4f32(<vscale x 4 x float> [[INACTIVE:%.*]], <vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
//
svfloat32_t test_svrinti_f32_m(svfloat32_t inactive, svbool_t pg, svfloat32_t op)
{
  return SVE_ACLE_FUNC(svrinti,_f32,_m,)(inactive, pg, op);
}

// CHECK-LABEL: @test_svrinti_f64_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.frinti.nxv2f64(<vscale x 2 x double> [[INACTIVE:%.*]], <vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z18test_svrinti_f64_mu13__SVFloat64_tu10__SVBool_tu13__SVFloat64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.frinti.nxv2f64(<vscale x 2 x double> [[INACTIVE:%.*]], <vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
//
svfloat64_t test_svrinti_f64_m(svfloat64_t inactive, svbool_t pg, svfloat64_t op)
{
  return SVE_ACLE_FUNC(svrinti,_f64,_m,)(inactive, pg, op);
}

// CHECK-LABEL: @test_svrinti_f16_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.frinti.nxv8f16(<vscale x 8 x half> undef, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z18test_svrinti_f16_xu10__SVBool_tu13__SVFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.frinti.nxv8f16(<vscale x 8 x half> undef, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP1]]
//
svfloat16_t test_svrinti_f16_x(svbool_t pg, svfloat16_t op)
{
  return SVE_ACLE_FUNC(svrinti,_f16,_x,)(pg, op);
}

// CHECK-LABEL: @test_svrinti_f32_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.frinti.nxv4f32(<vscale x 4 x float> undef, <vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z18test_svrinti_f32_xu10__SVBool_tu13__SVFloat32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.frinti.nxv4f32(<vscale x 4 x float> undef, <vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
//
svfloat32_t test_svrinti_f32_x(svbool_t pg, svfloat32_t op)
{
  return SVE_ACLE_FUNC(svrinti,_f32,_x,)(pg, op);
}

// CHECK-LABEL: @test_svrinti_f64_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.frinti.nxv2f64(<vscale x 2 x double> undef, <vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z18test_svrinti_f64_xu10__SVBool_tu13__SVFloat64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.frinti.nxv2f64(<vscale x 2 x double> undef, <vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
//
svfloat64_t test_svrinti_f64_x(svbool_t pg, svfloat64_t op)
{
  return SVE_ACLE_FUNC(svrinti,_f64,_x,)(pg, op);
}
