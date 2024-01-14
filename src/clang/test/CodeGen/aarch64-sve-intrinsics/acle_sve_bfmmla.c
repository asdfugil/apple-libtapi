// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK

// REQUIRES: aarch64-registered-target

#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1, A2_UNUSED, A3, A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1, A2, A3, A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_bfmmla_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.bfmmla(<vscale x 4 x float> [[X:%.*]], <vscale x 8 x bfloat> [[Y:%.*]], <vscale x 8 x bfloat> [[Z:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_bfmmla_f32u13__SVFloat32_tu14__SVBFloat16_tu14__SVBFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.bfmmla(<vscale x 4 x float> [[X:%.*]], <vscale x 8 x bfloat> [[Y:%.*]], <vscale x 8 x bfloat> [[Z:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
svfloat32_t test_bfmmla_f32(svfloat32_t x, svbfloat16_t y, svbfloat16_t z) {
  return SVE_ACLE_FUNC(svbfmmla, _f32, , )(x, y, z);
}
