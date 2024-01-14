// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple thumbv8.1m.main-none-none-eabi -target-feature +mve.fp -mfloat-abi hard -disable-O0-optnone -S -emit-llvm -o - %s | opt -S -mem2reg | FileCheck %s
// RUN: %clang_cc1 -triple thumbv8.1m.main-none-none-eabi -target-feature +mve.fp -mfloat-abi hard -disable-O0-optnone -DPOLYMORPHIC -S -emit-llvm -o - %s | opt -S -mem2reg | FileCheck %s

// REQUIRES: aarch64-registered-target || arm-registered-target

#include <arm_mve.h>

// CHECK-LABEL: @test_vmaxnmaq_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <8 x half> @llvm.fabs.v8f16(<8 x half> [[A:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x half> @llvm.fabs.v8f16(<8 x half> [[B:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x half> @llvm.maxnum.v8f16(<8 x half> [[TMP0]], <8 x half> [[TMP1]])
// CHECK-NEXT:    ret <8 x half> [[TMP2]]
//
float16x8_t test_vmaxnmaq_f16(float16x8_t a, float16x8_t b)
{
#ifdef POLYMORPHIC
    return vmaxnmaq(a, b);
#else /* POLYMORPHIC */
    return vmaxnmaq_f16(a, b);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmaxnmaq_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <4 x float> @llvm.fabs.v4f32(<4 x float> [[A:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x float> @llvm.fabs.v4f32(<4 x float> [[B:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x float> @llvm.maxnum.v4f32(<4 x float> [[TMP0]], <4 x float> [[TMP1]])
// CHECK-NEXT:    ret <4 x float> [[TMP2]]
//
float32x4_t test_vmaxnmaq_f32(float32x4_t a, float32x4_t b)
{
#ifdef POLYMORPHIC
    return vmaxnmaq(a, b);
#else /* POLYMORPHIC */
    return vmaxnmaq_f32(a, b);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmaxnmaq_m_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x half> @llvm.arm.mve.vmaxnma.predicated.v8f16.v8i1(<8 x half> [[A:%.*]], <8 x half> [[B:%.*]], <8 x i1> [[TMP1]])
// CHECK-NEXT:    ret <8 x half> [[TMP2]]
//
float16x8_t test_vmaxnmaq_m_f16(float16x8_t a, float16x8_t b, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vmaxnmaq_m(a, b, p);
#else /* POLYMORPHIC */
    return vmaxnmaq_m_f16(a, b, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmaxnmaq_m_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x float> @llvm.arm.mve.vmaxnma.predicated.v4f32.v4i1(<4 x float> [[A:%.*]], <4 x float> [[B:%.*]], <4 x i1> [[TMP1]])
// CHECK-NEXT:    ret <4 x float> [[TMP2]]
//
float32x4_t test_vmaxnmaq_m_f32(float32x4_t a, float32x4_t b, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vmaxnmaq_m(a, b, p);
#else /* POLYMORPHIC */
    return vmaxnmaq_m_f32(a, b, p);
#endif /* POLYMORPHIC */
}
