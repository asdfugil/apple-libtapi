; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -codegenprepare < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

%struct.a = type { i32, i32 }
@c = external dso_local global %struct.a, align 4
@glob_array = internal unnamed_addr constant [16 x i32] [i32 1, i32 1, i32 2, i32 3, i32 5, i32 8, i32 13, i32 21, i32 34, i32 55, i32 89, i32 144, i32 233, i32 377, i32 610, i32 987], align 16

define <vscale x 4 x i32> @splat_base(i32* %base, <vscale x 4 x i64> %index, <vscale x 4 x i1> %mask) #0 {
; CHECK-LABEL: @splat_base(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i32, i32* [[BASE:%.*]], <vscale x 4 x i64> [[INDEX:%.*]]
; CHECK-NEXT:    [[RES:%.*]] = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<vscale x 4 x i32*> [[TMP1]], i32 4, <vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> undef)
; CHECK-NEXT:    ret <vscale x 4 x i32> [[RES]]
;
  %broadcast.splatinsert = insertelement <vscale x 4 x i32*> poison, i32* %base, i32 0
  %broadcast.splat = shufflevector <vscale x 4 x i32*> %broadcast.splatinsert, <vscale x 4 x i32*> poison, <vscale x 4 x i32> zeroinitializer
  %gep = getelementptr i32, <vscale x 4 x i32*> %broadcast.splat, <vscale x 4 x i64> %index
  %res = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<vscale x 4 x i32*> %gep, i32 4, <vscale x 4 x i1> %mask, <vscale x 4 x i32> undef)
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @splat_struct(%struct.a* %base, <vscale x 4 x i1> %mask) #0 {
; CHECK-LABEL: @splat_struct(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr [[STRUCT_A:%.*]], %struct.a* [[BASE:%.*]], i64 0, i32 1
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr i32, i32* [[TMP1]], <vscale x 4 x i64> zeroinitializer
; CHECK-NEXT:    [[RES:%.*]] = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<vscale x 4 x i32*> [[TMP2]], i32 4, <vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> undef)
; CHECK-NEXT:    ret <vscale x 4 x i32> [[RES]]
;
  %gep = getelementptr %struct.a, %struct.a* %base, <vscale x 4 x i64> zeroinitializer, i32 1
  %res = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<vscale x 4 x i32*> %gep, i32 4, <vscale x 4 x i1> %mask, <vscale x 4 x i32> undef)
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @scalar_index(i32* %base, i64 %index, <vscale x 4 x i1> %mask) #0 {
; CHECK-LABEL: @scalar_index(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i32, i32* [[BASE:%.*]], i64 [[INDEX:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr i32, i32* [[TMP1]], <vscale x 4 x i64> zeroinitializer
; CHECK-NEXT:    [[RES:%.*]] = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<vscale x 4 x i32*> [[TMP2]], i32 4, <vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> undef)
; CHECK-NEXT:    ret <vscale x 4 x i32> [[RES]]
;
  %broadcast.splatinsert = insertelement <vscale x 4 x i32*> poison, i32* %base, i32 0
  %broadcast.splat = shufflevector <vscale x 4 x i32*> %broadcast.splatinsert, <vscale x 4 x i32*> poison, <vscale x 4 x i32> zeroinitializer
  %gep = getelementptr i32, <vscale x 4 x i32*> %broadcast.splat, i64 %index
  %res = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<vscale x 4 x i32*> %gep, i32 4, <vscale x 4 x i1> %mask, <vscale x 4 x i32> undef)
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @splat_index(i32* %base, i64 %index, <vscale x 4 x i1> %mask) #0 {
; CHECK-LABEL: @splat_index(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i32, i32* [[BASE:%.*]], i64 [[INDEX:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr i32, i32* [[TMP1]], <vscale x 4 x i64> zeroinitializer
; CHECK-NEXT:    [[RES:%.*]] = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<vscale x 4 x i32*> [[TMP2]], i32 4, <vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> undef)
; CHECK-NEXT:    ret <vscale x 4 x i32> [[RES]]
;
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %index, i32 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %gep = getelementptr i32, i32* %base, <vscale x 4 x i64> %broadcast.splat
  %res = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<vscale x 4 x i32*> %gep, i32 4, <vscale x 4 x i1> %mask, <vscale x 4 x i32> undef)
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @test_global_array(<vscale x 4 x i64> %indxs, <vscale x 4 x i1> %mask) #0 {
; CHECK-LABEL: @test_global_array(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i32, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @glob_array, i64 0, i64 0), <vscale x 4 x i64> [[INDXS:%.*]]
; CHECK-NEXT:    [[G:%.*]] = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<vscale x 4 x i32*> [[TMP1]], i32 4, <vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> undef)
; CHECK-NEXT:    ret <vscale x 4 x i32> [[G]]
;
  %p = getelementptr inbounds [16 x i32], [16 x i32]* @glob_array, i64 0, <vscale x 4 x i64> %indxs
  %g = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<vscale x 4 x i32*> %p, i32 4, <vscale x 4 x i1> %mask, <vscale x 4 x i32> undef)
  ret <vscale x 4 x i32> %g
}

define <vscale x 4 x i32> @global_struct_splat(<vscale x 4 x i1> %mask) #0 {
; CHECK-LABEL: @global_struct_splat(
; CHECK-NEXT:    [[TMP1:%.*]] = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<vscale x 4 x i32*> shufflevector (<vscale x 4 x i32*> insertelement (<vscale x 4 x i32*> poison, i32* getelementptr inbounds ([[STRUCT_A:%.*]], %struct.a* @c, i64 0, i32 1), i32 0), <vscale x 4 x i32*> poison, <vscale x 4 x i32> zeroinitializer), i32 4, <vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> undef)
; CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
;
  %1 = insertelement <vscale x 4 x %struct.a*> poison, %struct.a* @c, i32 0
  %2 = shufflevector <vscale x 4 x %struct.a*> %1, <vscale x 4 x %struct.a*> poison, <vscale x 4 x i32> zeroinitializer
  %3 = getelementptr %struct.a, <vscale x 4 x %struct.a*> %2, <vscale x 4 x i64> zeroinitializer, i32 1
  %4 = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<vscale x 4 x i32*> %3, i32 4, <vscale x 4 x i1> %mask, <vscale x 4 x i32> undef)
  ret <vscale x 4 x i32> %4
}

define <vscale x 4 x i32> @splat_ptr_gather(i32* %ptr, <vscale x 4 x i1> %mask, <vscale x 4 x i32> %passthru) #0 {
; CHECK-LABEL: @splat_ptr_gather(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i32, i32* [[PTR:%.*]], <vscale x 4 x i64> zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<vscale x 4 x i32*> [[TMP1]], i32 4, <vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> [[PASSTHRU:%.*]])
; CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
;
  %1 = insertelement <vscale x 4 x i32*> poison, i32* %ptr, i32 0
  %2 = shufflevector <vscale x 4 x i32*> %1, <vscale x 4 x i32*> poison, <vscale x 4 x i32> zeroinitializer
  %3 = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<vscale x 4 x i32*> %2, i32 4, <vscale x 4 x i1> %mask, <vscale x 4 x i32> %passthru)
  ret <vscale x 4 x i32> %3
}

define void @splat_ptr_scatter(i32* %ptr, <vscale x 4 x i1> %mask, <vscale x 4 x i32> %val) #0 {
; CHECK-LABEL: @splat_ptr_scatter(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i32, i32* [[PTR:%.*]], <vscale x 4 x i64> zeroinitializer
; CHECK-NEXT:    call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<vscale x 4 x i32> [[VAL:%.*]], <vscale x 4 x i32*> [[TMP1]], i32 4, <vscale x 4 x i1> [[MASK:%.*]])
; CHECK-NEXT:    ret void
;
  %1 = insertelement <vscale x 4 x i32*> poison, i32* %ptr, i32 0
  %2 = shufflevector <vscale x 4 x i32*> %1, <vscale x 4 x i32*> poison, <vscale x 4 x i32> zeroinitializer
  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<vscale x 4 x i32> %val, <vscale x 4 x i32*> %2, i32 4, <vscale x 4 x i1> %mask)
  ret void
}

declare <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<vscale x 4 x i32*>, i32, <vscale x 4 x i1>, <vscale x 4 x i32>)
declare void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<vscale x 4 x i32>, <vscale x 4 x i32*>, i32, <vscale x 4 x i1>)

attributes #0 = { "target-features"="+sve" }
