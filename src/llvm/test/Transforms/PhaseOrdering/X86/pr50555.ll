; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -O3 -S -mtriple=x86_64-- | FileCheck %s --check-prefixes=SSE
; RUN: opt < %s -O3 -S -mtriple=x86_64-- -mattr=avx | FileCheck %s --check-prefixes=AVX

define void @trunc_through_one_add(i16* noalias %0, i8* noalias readonly %1) {
; SSE-LABEL: @trunc_through_one_add(
; SSE-NEXT:    [[TMP3:%.*]] = bitcast i8* [[TMP1:%.*]] to <8 x i8>*
; SSE-NEXT:    [[TMP4:%.*]] = load <8 x i8>, <8 x i8>* [[TMP3]], align 1
; SSE-NEXT:    [[TMP5:%.*]] = zext <8 x i8> [[TMP4]] to <8 x i16>
; SSE-NEXT:    [[TMP6:%.*]] = lshr <8 x i16> [[TMP5]], <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
; SSE-NEXT:    [[TMP7:%.*]] = add nuw nsw <8 x i16> [[TMP6]], [[TMP5]]
; SSE-NEXT:    [[TMP8:%.*]] = lshr <8 x i16> [[TMP7]], <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>
; SSE-NEXT:    [[TMP9:%.*]] = bitcast i16* [[TMP0:%.*]] to <8 x i16>*
; SSE-NEXT:    store <8 x i16> [[TMP8]], <8 x i16>* [[TMP9]], align 2
; SSE-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i8, i8* [[TMP1]], i64 8
; SSE-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i16, i16* [[TMP0]], i64 8
; SSE-NEXT:    [[TMP12:%.*]] = bitcast i8* [[TMP10]] to <8 x i8>*
; SSE-NEXT:    [[TMP13:%.*]] = load <8 x i8>, <8 x i8>* [[TMP12]], align 1
; SSE-NEXT:    [[TMP14:%.*]] = zext <8 x i8> [[TMP13]] to <8 x i16>
; SSE-NEXT:    [[TMP15:%.*]] = lshr <8 x i16> [[TMP14]], <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
; SSE-NEXT:    [[TMP16:%.*]] = add nuw nsw <8 x i16> [[TMP15]], [[TMP14]]
; SSE-NEXT:    [[TMP17:%.*]] = lshr <8 x i16> [[TMP16]], <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>
; SSE-NEXT:    [[TMP18:%.*]] = bitcast i16* [[TMP11]] to <8 x i16>*
; SSE-NEXT:    store <8 x i16> [[TMP17]], <8 x i16>* [[TMP18]], align 2
; SSE-NEXT:    ret void
;
; AVX-LABEL: @trunc_through_one_add(
; AVX-NEXT:    [[TMP3:%.*]] = bitcast i8* [[TMP1:%.*]] to <16 x i8>*
; AVX-NEXT:    [[TMP4:%.*]] = load <16 x i8>, <16 x i8>* [[TMP3]], align 1
; AVX-NEXT:    [[TMP5:%.*]] = zext <16 x i8> [[TMP4]] to <16 x i16>
; AVX-NEXT:    [[TMP6:%.*]] = lshr <16 x i16> [[TMP5]], <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
; AVX-NEXT:    [[TMP7:%.*]] = add nuw nsw <16 x i16> [[TMP6]], [[TMP5]]
; AVX-NEXT:    [[TMP8:%.*]] = lshr <16 x i16> [[TMP7]], <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>
; AVX-NEXT:    [[TMP9:%.*]] = bitcast i16* [[TMP0:%.*]] to <16 x i16>*
; AVX-NEXT:    store <16 x i16> [[TMP8]], <16 x i16>* [[TMP9]], align 2
; AVX-NEXT:    ret void
;
  %3 = load i8, i8* %1, align 1
  %4 = zext i8 %3 to i32
  %5 = lshr i32 %4, 1
  %6 = add nuw nsw i32 %5, %4
  %7 = lshr i32 %6, 2
  %8 = trunc i32 %7 to i16
  store i16 %8, i16* %0, align 2
  %9 = getelementptr inbounds i8, i8* %1, i64 1
  %10 = load i8, i8* %9, align 1
  %11 = zext i8 %10 to i32
  %12 = lshr i32 %11, 1
  %13 = add nuw nsw i32 %12, %11
  %14 = lshr i32 %13, 2
  %15 = trunc i32 %14 to i16
  %16 = getelementptr inbounds i16, i16* %0, i64 1
  store i16 %15, i16* %16, align 2
  %17 = getelementptr inbounds i8, i8* %1, i64 2
  %18 = load i8, i8* %17, align 1
  %19 = zext i8 %18 to i32
  %20 = lshr i32 %19, 1
  %21 = add nuw nsw i32 %20, %19
  %22 = lshr i32 %21, 2
  %23 = trunc i32 %22 to i16
  %24 = getelementptr inbounds i16, i16* %0, i64 2
  store i16 %23, i16* %24, align 2
  %25 = getelementptr inbounds i8, i8* %1, i64 3
  %26 = load i8, i8* %25, align 1
  %27 = zext i8 %26 to i32
  %28 = lshr i32 %27, 1
  %29 = add nuw nsw i32 %28, %27
  %30 = lshr i32 %29, 2
  %31 = trunc i32 %30 to i16
  %32 = getelementptr inbounds i16, i16* %0, i64 3
  store i16 %31, i16* %32, align 2
  %33 = getelementptr inbounds i8, i8* %1, i64 4
  %34 = load i8, i8* %33, align 1
  %35 = zext i8 %34 to i32
  %36 = lshr i32 %35, 1
  %37 = add nuw nsw i32 %36, %35
  %38 = lshr i32 %37, 2
  %39 = trunc i32 %38 to i16
  %40 = getelementptr inbounds i16, i16* %0, i64 4
  store i16 %39, i16* %40, align 2
  %41 = getelementptr inbounds i8, i8* %1, i64 5
  %42 = load i8, i8* %41, align 1
  %43 = zext i8 %42 to i32
  %44 = lshr i32 %43, 1
  %45 = add nuw nsw i32 %44, %43
  %46 = lshr i32 %45, 2
  %47 = trunc i32 %46 to i16
  %48 = getelementptr inbounds i16, i16* %0, i64 5
  store i16 %47, i16* %48, align 2
  %49 = getelementptr inbounds i8, i8* %1, i64 6
  %50 = load i8, i8* %49, align 1
  %51 = zext i8 %50 to i32
  %52 = lshr i32 %51, 1
  %53 = add nuw nsw i32 %52, %51
  %54 = lshr i32 %53, 2
  %55 = trunc i32 %54 to i16
  %56 = getelementptr inbounds i16, i16* %0, i64 6
  store i16 %55, i16* %56, align 2
  %57 = getelementptr inbounds i8, i8* %1, i64 7
  %58 = load i8, i8* %57, align 1
  %59 = zext i8 %58 to i32
  %60 = lshr i32 %59, 1
  %61 = add nuw nsw i32 %60, %59
  %62 = lshr i32 %61, 2
  %63 = trunc i32 %62 to i16
  %64 = getelementptr inbounds i16, i16* %0, i64 7
  store i16 %63, i16* %64, align 2
  %65 = getelementptr inbounds i8, i8* %1, i64 8
  %66 = load i8, i8* %65, align 1
  %67 = zext i8 %66 to i32
  %68 = lshr i32 %67, 1
  %69 = add nuw nsw i32 %68, %67
  %70 = lshr i32 %69, 2
  %71 = trunc i32 %70 to i16
  %72 = getelementptr inbounds i16, i16* %0, i64 8
  store i16 %71, i16* %72, align 2
  %73 = getelementptr inbounds i8, i8* %1, i64 9
  %74 = load i8, i8* %73, align 1
  %75 = zext i8 %74 to i32
  %76 = lshr i32 %75, 1
  %77 = add nuw nsw i32 %76, %75
  %78 = lshr i32 %77, 2
  %79 = trunc i32 %78 to i16
  %80 = getelementptr inbounds i16, i16* %0, i64 9
  store i16 %79, i16* %80, align 2
  %81 = getelementptr inbounds i8, i8* %1, i64 10
  %82 = load i8, i8* %81, align 1
  %83 = zext i8 %82 to i32
  %84 = lshr i32 %83, 1
  %85 = add nuw nsw i32 %84, %83
  %86 = lshr i32 %85, 2
  %87 = trunc i32 %86 to i16
  %88 = getelementptr inbounds i16, i16* %0, i64 10
  store i16 %87, i16* %88, align 2
  %89 = getelementptr inbounds i8, i8* %1, i64 11
  %90 = load i8, i8* %89, align 1
  %91 = zext i8 %90 to i32
  %92 = lshr i32 %91, 1
  %93 = add nuw nsw i32 %92, %91
  %94 = lshr i32 %93, 2
  %95 = trunc i32 %94 to i16
  %96 = getelementptr inbounds i16, i16* %0, i64 11
  store i16 %95, i16* %96, align 2
  %97 = getelementptr inbounds i8, i8* %1, i64 12
  %98 = load i8, i8* %97, align 1
  %99 = zext i8 %98 to i32
  %100 = lshr i32 %99, 1
  %101 = add nuw nsw i32 %100, %99
  %102 = lshr i32 %101, 2
  %103 = trunc i32 %102 to i16
  %104 = getelementptr inbounds i16, i16* %0, i64 12
  store i16 %103, i16* %104, align 2
  %105 = getelementptr inbounds i8, i8* %1, i64 13
  %106 = load i8, i8* %105, align 1
  %107 = zext i8 %106 to i32
  %108 = lshr i32 %107, 1
  %109 = add nuw nsw i32 %108, %107
  %110 = lshr i32 %109, 2
  %111 = trunc i32 %110 to i16
  %112 = getelementptr inbounds i16, i16* %0, i64 13
  store i16 %111, i16* %112, align 2
  %113 = getelementptr inbounds i8, i8* %1, i64 14
  %114 = load i8, i8* %113, align 1
  %115 = zext i8 %114 to i32
  %116 = lshr i32 %115, 1
  %117 = add nuw nsw i32 %116, %115
  %118 = lshr i32 %117, 2
  %119 = trunc i32 %118 to i16
  %120 = getelementptr inbounds i16, i16* %0, i64 14
  store i16 %119, i16* %120, align 2
  %121 = getelementptr inbounds i8, i8* %1, i64 15
  %122 = load i8, i8* %121, align 1
  %123 = zext i8 %122 to i32
  %124 = lshr i32 %123, 1
  %125 = add nuw nsw i32 %124, %123
  %126 = lshr i32 %125, 2
  %127 = trunc i32 %126 to i16
  %128 = getelementptr inbounds i16, i16* %0, i64 15
  store i16 %127, i16* %128, align 2
  ret void
}

define void @trunc_through_two_adds(i16* noalias %0, i8* noalias readonly %1, i8* noalias readonly %2) {
; SSE-LABEL: @trunc_through_two_adds(
; SSE-NEXT:    [[TMP4:%.*]] = bitcast i8* [[TMP1:%.*]] to <8 x i8>*
; SSE-NEXT:    [[TMP5:%.*]] = load <8 x i8>, <8 x i8>* [[TMP4]], align 1
; SSE-NEXT:    [[TMP6:%.*]] = zext <8 x i8> [[TMP5]] to <8 x i16>
; SSE-NEXT:    [[TMP7:%.*]] = bitcast i8* [[TMP2:%.*]] to <8 x i8>*
; SSE-NEXT:    [[TMP8:%.*]] = load <8 x i8>, <8 x i8>* [[TMP7]], align 1
; SSE-NEXT:    [[TMP9:%.*]] = zext <8 x i8> [[TMP8]] to <8 x i16>
; SSE-NEXT:    [[TMP10:%.*]] = add nuw nsw <8 x i16> [[TMP9]], [[TMP6]]
; SSE-NEXT:    [[TMP11:%.*]] = lshr <8 x i16> [[TMP10]], <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
; SSE-NEXT:    [[TMP12:%.*]] = add nuw nsw <8 x i16> [[TMP11]], [[TMP10]]
; SSE-NEXT:    [[TMP13:%.*]] = lshr <8 x i16> [[TMP12]], <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>
; SSE-NEXT:    [[TMP14:%.*]] = bitcast i16* [[TMP0:%.*]] to <8 x i16>*
; SSE-NEXT:    store <8 x i16> [[TMP13]], <8 x i16>* [[TMP14]], align 2
; SSE-NEXT:    [[TMP15:%.*]] = getelementptr inbounds i8, i8* [[TMP1]], i64 8
; SSE-NEXT:    [[TMP16:%.*]] = getelementptr inbounds i8, i8* [[TMP2]], i64 8
; SSE-NEXT:    [[TMP17:%.*]] = getelementptr inbounds i16, i16* [[TMP0]], i64 8
; SSE-NEXT:    [[TMP18:%.*]] = bitcast i8* [[TMP15]] to <8 x i8>*
; SSE-NEXT:    [[TMP19:%.*]] = load <8 x i8>, <8 x i8>* [[TMP18]], align 1
; SSE-NEXT:    [[TMP20:%.*]] = zext <8 x i8> [[TMP19]] to <8 x i16>
; SSE-NEXT:    [[TMP21:%.*]] = bitcast i8* [[TMP16]] to <8 x i8>*
; SSE-NEXT:    [[TMP22:%.*]] = load <8 x i8>, <8 x i8>* [[TMP21]], align 1
; SSE-NEXT:    [[TMP23:%.*]] = zext <8 x i8> [[TMP22]] to <8 x i16>
; SSE-NEXT:    [[TMP24:%.*]] = add nuw nsw <8 x i16> [[TMP23]], [[TMP20]]
; SSE-NEXT:    [[TMP25:%.*]] = lshr <8 x i16> [[TMP24]], <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
; SSE-NEXT:    [[TMP26:%.*]] = add nuw nsw <8 x i16> [[TMP25]], [[TMP24]]
; SSE-NEXT:    [[TMP27:%.*]] = lshr <8 x i16> [[TMP26]], <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>
; SSE-NEXT:    [[TMP28:%.*]] = bitcast i16* [[TMP17]] to <8 x i16>*
; SSE-NEXT:    store <8 x i16> [[TMP27]], <8 x i16>* [[TMP28]], align 2
; SSE-NEXT:    ret void
;
; AVX-LABEL: @trunc_through_two_adds(
; AVX-NEXT:    [[TMP4:%.*]] = bitcast i8* [[TMP1:%.*]] to <16 x i8>*
; AVX-NEXT:    [[TMP5:%.*]] = load <16 x i8>, <16 x i8>* [[TMP4]], align 1
; AVX-NEXT:    [[TMP6:%.*]] = zext <16 x i8> [[TMP5]] to <16 x i16>
; AVX-NEXT:    [[TMP7:%.*]] = bitcast i8* [[TMP2:%.*]] to <16 x i8>*
; AVX-NEXT:    [[TMP8:%.*]] = load <16 x i8>, <16 x i8>* [[TMP7]], align 1
; AVX-NEXT:    [[TMP9:%.*]] = zext <16 x i8> [[TMP8]] to <16 x i16>
; AVX-NEXT:    [[TMP10:%.*]] = add nuw nsw <16 x i16> [[TMP9]], [[TMP6]]
; AVX-NEXT:    [[TMP11:%.*]] = lshr <16 x i16> [[TMP10]], <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
; AVX-NEXT:    [[TMP12:%.*]] = add nuw nsw <16 x i16> [[TMP11]], [[TMP10]]
; AVX-NEXT:    [[TMP13:%.*]] = lshr <16 x i16> [[TMP12]], <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>
; AVX-NEXT:    [[TMP14:%.*]] = bitcast i16* [[TMP0:%.*]] to <16 x i16>*
; AVX-NEXT:    store <16 x i16> [[TMP13]], <16 x i16>* [[TMP14]], align 2
; AVX-NEXT:    ret void
;
  %4 = load i8, i8* %1, align 1
  %5 = zext i8 %4 to i32
  %6 = load i8, i8* %2, align 1
  %7 = zext i8 %6 to i32
  %8 = add nuw nsw i32 %7, %5
  %9 = lshr i32 %8, 1
  %10 = add nuw nsw i32 %9, %8
  %11 = lshr i32 %10, 2
  %12 = trunc i32 %11 to i16
  store i16 %12, i16* %0, align 2
  %13 = getelementptr inbounds i8, i8* %1, i64 1
  %14 = load i8, i8* %13, align 1
  %15 = zext i8 %14 to i32
  %16 = getelementptr inbounds i8, i8* %2, i64 1
  %17 = load i8, i8* %16, align 1
  %18 = zext i8 %17 to i32
  %19 = add nuw nsw i32 %18, %15
  %20 = lshr i32 %19, 1
  %21 = add nuw nsw i32 %20, %19
  %22 = lshr i32 %21, 2
  %23 = trunc i32 %22 to i16
  %24 = getelementptr inbounds i16, i16* %0, i64 1
  store i16 %23, i16* %24, align 2
  %25 = getelementptr inbounds i8, i8* %1, i64 2
  %26 = load i8, i8* %25, align 1
  %27 = zext i8 %26 to i32
  %28 = getelementptr inbounds i8, i8* %2, i64 2
  %29 = load i8, i8* %28, align 1
  %30 = zext i8 %29 to i32
  %31 = add nuw nsw i32 %30, %27
  %32 = lshr i32 %31, 1
  %33 = add nuw nsw i32 %32, %31
  %34 = lshr i32 %33, 2
  %35 = trunc i32 %34 to i16
  %36 = getelementptr inbounds i16, i16* %0, i64 2
  store i16 %35, i16* %36, align 2
  %37 = getelementptr inbounds i8, i8* %1, i64 3
  %38 = load i8, i8* %37, align 1
  %39 = zext i8 %38 to i32
  %40 = getelementptr inbounds i8, i8* %2, i64 3
  %41 = load i8, i8* %40, align 1
  %42 = zext i8 %41 to i32
  %43 = add nuw nsw i32 %42, %39
  %44 = lshr i32 %43, 1
  %45 = add nuw nsw i32 %44, %43
  %46 = lshr i32 %45, 2
  %47 = trunc i32 %46 to i16
  %48 = getelementptr inbounds i16, i16* %0, i64 3
  store i16 %47, i16* %48, align 2
  %49 = getelementptr inbounds i8, i8* %1, i64 4
  %50 = load i8, i8* %49, align 1
  %51 = zext i8 %50 to i32
  %52 = getelementptr inbounds i8, i8* %2, i64 4
  %53 = load i8, i8* %52, align 1
  %54 = zext i8 %53 to i32
  %55 = add nuw nsw i32 %54, %51
  %56 = lshr i32 %55, 1
  %57 = add nuw nsw i32 %56, %55
  %58 = lshr i32 %57, 2
  %59 = trunc i32 %58 to i16
  %60 = getelementptr inbounds i16, i16* %0, i64 4
  store i16 %59, i16* %60, align 2
  %61 = getelementptr inbounds i8, i8* %1, i64 5
  %62 = load i8, i8* %61, align 1
  %63 = zext i8 %62 to i32
  %64 = getelementptr inbounds i8, i8* %2, i64 5
  %65 = load i8, i8* %64, align 1
  %66 = zext i8 %65 to i32
  %67 = add nuw nsw i32 %66, %63
  %68 = lshr i32 %67, 1
  %69 = add nuw nsw i32 %68, %67
  %70 = lshr i32 %69, 2
  %71 = trunc i32 %70 to i16
  %72 = getelementptr inbounds i16, i16* %0, i64 5
  store i16 %71, i16* %72, align 2
  %73 = getelementptr inbounds i8, i8* %1, i64 6
  %74 = load i8, i8* %73, align 1
  %75 = zext i8 %74 to i32
  %76 = getelementptr inbounds i8, i8* %2, i64 6
  %77 = load i8, i8* %76, align 1
  %78 = zext i8 %77 to i32
  %79 = add nuw nsw i32 %78, %75
  %80 = lshr i32 %79, 1
  %81 = add nuw nsw i32 %80, %79
  %82 = lshr i32 %81, 2
  %83 = trunc i32 %82 to i16
  %84 = getelementptr inbounds i16, i16* %0, i64 6
  store i16 %83, i16* %84, align 2
  %85 = getelementptr inbounds i8, i8* %1, i64 7
  %86 = load i8, i8* %85, align 1
  %87 = zext i8 %86 to i32
  %88 = getelementptr inbounds i8, i8* %2, i64 7
  %89 = load i8, i8* %88, align 1
  %90 = zext i8 %89 to i32
  %91 = add nuw nsw i32 %90, %87
  %92 = lshr i32 %91, 1
  %93 = add nuw nsw i32 %92, %91
  %94 = lshr i32 %93, 2
  %95 = trunc i32 %94 to i16
  %96 = getelementptr inbounds i16, i16* %0, i64 7
  store i16 %95, i16* %96, align 2
  %97 = getelementptr inbounds i8, i8* %1, i64 8
  %98 = load i8, i8* %97, align 1
  %99 = zext i8 %98 to i32
  %100 = getelementptr inbounds i8, i8* %2, i64 8
  %101 = load i8, i8* %100, align 1
  %102 = zext i8 %101 to i32
  %103 = add nuw nsw i32 %102, %99
  %104 = lshr i32 %103, 1
  %105 = add nuw nsw i32 %104, %103
  %106 = lshr i32 %105, 2
  %107 = trunc i32 %106 to i16
  %108 = getelementptr inbounds i16, i16* %0, i64 8
  store i16 %107, i16* %108, align 2
  %109 = getelementptr inbounds i8, i8* %1, i64 9
  %110 = load i8, i8* %109, align 1
  %111 = zext i8 %110 to i32
  %112 = getelementptr inbounds i8, i8* %2, i64 9
  %113 = load i8, i8* %112, align 1
  %114 = zext i8 %113 to i32
  %115 = add nuw nsw i32 %114, %111
  %116 = lshr i32 %115, 1
  %117 = add nuw nsw i32 %116, %115
  %118 = lshr i32 %117, 2
  %119 = trunc i32 %118 to i16
  %120 = getelementptr inbounds i16, i16* %0, i64 9
  store i16 %119, i16* %120, align 2
  %121 = getelementptr inbounds i8, i8* %1, i64 10
  %122 = load i8, i8* %121, align 1
  %123 = zext i8 %122 to i32
  %124 = getelementptr inbounds i8, i8* %2, i64 10
  %125 = load i8, i8* %124, align 1
  %126 = zext i8 %125 to i32
  %127 = add nuw nsw i32 %126, %123
  %128 = lshr i32 %127, 1
  %129 = add nuw nsw i32 %128, %127
  %130 = lshr i32 %129, 2
  %131 = trunc i32 %130 to i16
  %132 = getelementptr inbounds i16, i16* %0, i64 10
  store i16 %131, i16* %132, align 2
  %133 = getelementptr inbounds i8, i8* %1, i64 11
  %134 = load i8, i8* %133, align 1
  %135 = zext i8 %134 to i32
  %136 = getelementptr inbounds i8, i8* %2, i64 11
  %137 = load i8, i8* %136, align 1
  %138 = zext i8 %137 to i32
  %139 = add nuw nsw i32 %138, %135
  %140 = lshr i32 %139, 1
  %141 = add nuw nsw i32 %140, %139
  %142 = lshr i32 %141, 2
  %143 = trunc i32 %142 to i16
  %144 = getelementptr inbounds i16, i16* %0, i64 11
  store i16 %143, i16* %144, align 2
  %145 = getelementptr inbounds i8, i8* %1, i64 12
  %146 = load i8, i8* %145, align 1
  %147 = zext i8 %146 to i32
  %148 = getelementptr inbounds i8, i8* %2, i64 12
  %149 = load i8, i8* %148, align 1
  %150 = zext i8 %149 to i32
  %151 = add nuw nsw i32 %150, %147
  %152 = lshr i32 %151, 1
  %153 = add nuw nsw i32 %152, %151
  %154 = lshr i32 %153, 2
  %155 = trunc i32 %154 to i16
  %156 = getelementptr inbounds i16, i16* %0, i64 12
  store i16 %155, i16* %156, align 2
  %157 = getelementptr inbounds i8, i8* %1, i64 13
  %158 = load i8, i8* %157, align 1
  %159 = zext i8 %158 to i32
  %160 = getelementptr inbounds i8, i8* %2, i64 13
  %161 = load i8, i8* %160, align 1
  %162 = zext i8 %161 to i32
  %163 = add nuw nsw i32 %162, %159
  %164 = lshr i32 %163, 1
  %165 = add nuw nsw i32 %164, %163
  %166 = lshr i32 %165, 2
  %167 = trunc i32 %166 to i16
  %168 = getelementptr inbounds i16, i16* %0, i64 13
  store i16 %167, i16* %168, align 2
  %169 = getelementptr inbounds i8, i8* %1, i64 14
  %170 = load i8, i8* %169, align 1
  %171 = zext i8 %170 to i32
  %172 = getelementptr inbounds i8, i8* %2, i64 14
  %173 = load i8, i8* %172, align 1
  %174 = zext i8 %173 to i32
  %175 = add nuw nsw i32 %174, %171
  %176 = lshr i32 %175, 1
  %177 = add nuw nsw i32 %176, %175
  %178 = lshr i32 %177, 2
  %179 = trunc i32 %178 to i16
  %180 = getelementptr inbounds i16, i16* %0, i64 14
  store i16 %179, i16* %180, align 2
  %181 = getelementptr inbounds i8, i8* %1, i64 15
  %182 = load i8, i8* %181, align 1
  %183 = zext i8 %182 to i32
  %184 = getelementptr inbounds i8, i8* %2, i64 15
  %185 = load i8, i8* %184, align 1
  %186 = zext i8 %185 to i32
  %187 = add nuw nsw i32 %186, %183
  %188 = lshr i32 %187, 1
  %189 = add nuw nsw i32 %188, %187
  %190 = lshr i32 %189, 2
  %191 = trunc i32 %190 to i16
  %192 = getelementptr inbounds i16, i16* %0, i64 15
  store i16 %191, i16* %192, align 2
  ret void
}
