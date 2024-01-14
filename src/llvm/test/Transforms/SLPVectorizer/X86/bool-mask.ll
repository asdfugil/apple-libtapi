; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-vectorizer -S -mtriple=x86_64-unknown -mcpu=x86-64    -slp-vectorizer -S | FileCheck %s --check-prefixes=SSE,SSE2
; RUN: opt < %s -slp-vectorizer -S -mtriple=x86_64-unknown -mcpu=x86-64-v2 -slp-vectorizer -S | FileCheck %s --check-prefixes=SSE,SSE4
; RUN: opt < %s -slp-vectorizer -S -mtriple=x86_64-unknown -mcpu=x86-64-v3 -slp-vectorizer -S | FileCheck %s --check-prefixes=AVX
; RUN: opt < %s -slp-vectorizer -S -mtriple=x86_64-unknown -mcpu=x86-64-v4 -slp-vectorizer -S | FileCheck %s --check-prefixes=AVX512

; // PR42652
; unsigned long bitmask_16xi8(const char *src) {
;     unsigned long mask = 0;
;     for (unsigned i = 0; i != 16; ++i) {
;       if (src[i])
;         mask |= (1ull << i);
;     }
;     return mask;
; }

define i64 @bitmask_16xi8(ptr nocapture noundef readonly %src) {
; SSE-LABEL: @bitmask_16xi8(
; SSE-NEXT:  entry:
; SSE-NEXT:    [[TMP0:%.*]] = load i8, ptr [[SRC:%.*]], align 1
; SSE-NEXT:    [[TOBOOL_NOT:%.*]] = icmp ne i8 [[TMP0]], 0
; SSE-NEXT:    [[OR:%.*]] = zext i1 [[TOBOOL_NOT]] to i64
; SSE-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 1
; SSE-NEXT:    [[TMP1:%.*]] = load <8 x i8>, ptr [[ARRAYIDX_1]], align 1
; SSE-NEXT:    [[TMP2:%.*]] = icmp eq <8 x i8> [[TMP1]], zeroinitializer
; SSE-NEXT:    [[TMP3:%.*]] = select <8 x i1> [[TMP2]], <8 x i64> zeroinitializer, <8 x i64> <i64 2, i64 4, i64 8, i64 16, i64 32, i64 64, i64 128, i64 256>
; SSE-NEXT:    [[ARRAYIDX_9:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 9
; SSE-NEXT:    [[TMP4:%.*]] = load <4 x i8>, ptr [[ARRAYIDX_9]], align 1
; SSE-NEXT:    [[TMP5:%.*]] = icmp eq <4 x i8> [[TMP4]], zeroinitializer
; SSE-NEXT:    [[TMP6:%.*]] = select <4 x i1> [[TMP5]], <4 x i64> zeroinitializer, <4 x i64> <i64 512, i64 1024, i64 2048, i64 4096>
; SSE-NEXT:    [[ARRAYIDX_13:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 13
; SSE-NEXT:    [[TMP7:%.*]] = load i8, ptr [[ARRAYIDX_13]], align 1
; SSE-NEXT:    [[TOBOOL_NOT_13:%.*]] = icmp eq i8 [[TMP7]], 0
; SSE-NEXT:    [[OR_13:%.*]] = select i1 [[TOBOOL_NOT_13]], i64 0, i64 8192
; SSE-NEXT:    [[ARRAYIDX_14:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 14
; SSE-NEXT:    [[TMP8:%.*]] = load i8, ptr [[ARRAYIDX_14]], align 1
; SSE-NEXT:    [[TOBOOL_NOT_14:%.*]] = icmp eq i8 [[TMP8]], 0
; SSE-NEXT:    [[OR_14:%.*]] = select i1 [[TOBOOL_NOT_14]], i64 0, i64 16384
; SSE-NEXT:    [[ARRAYIDX_15:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 15
; SSE-NEXT:    [[TMP9:%.*]] = load i8, ptr [[ARRAYIDX_15]], align 1
; SSE-NEXT:    [[TOBOOL_NOT_15:%.*]] = icmp eq i8 [[TMP9]], 0
; SSE-NEXT:    [[OR_15:%.*]] = select i1 [[TOBOOL_NOT_15]], i64 0, i64 32768
; SSE-NEXT:    [[TMP10:%.*]] = call i64 @llvm.vector.reduce.or.v8i64(<8 x i64> [[TMP3]])
; SSE-NEXT:    [[TMP11:%.*]] = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> [[TMP6]])
; SSE-NEXT:    [[OP_RDX:%.*]] = or i64 [[TMP10]], [[TMP11]]
; SSE-NEXT:    [[OP_RDX1:%.*]] = or i64 [[OP_RDX]], [[OR_13]]
; SSE-NEXT:    [[OP_RDX2:%.*]] = or i64 [[OR_14]], [[OR_15]]
; SSE-NEXT:    [[OP_RDX3:%.*]] = or i64 [[OP_RDX1]], [[OP_RDX2]]
; SSE-NEXT:    [[OP_RDX4:%.*]] = or i64 [[OP_RDX3]], [[OR]]
; SSE-NEXT:    ret i64 [[OP_RDX4]]
;
; AVX-LABEL: @bitmask_16xi8(
; AVX-NEXT:  entry:
; AVX-NEXT:    [[TMP0:%.*]] = load i8, ptr [[SRC:%.*]], align 1
; AVX-NEXT:    [[TOBOOL_NOT:%.*]] = icmp ne i8 [[TMP0]], 0
; AVX-NEXT:    [[OR:%.*]] = zext i1 [[TOBOOL_NOT]] to i64
; AVX-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 1
; AVX-NEXT:    [[TMP1:%.*]] = load <8 x i8>, ptr [[ARRAYIDX_1]], align 1
; AVX-NEXT:    [[TMP2:%.*]] = icmp eq <8 x i8> [[TMP1]], zeroinitializer
; AVX-NEXT:    [[TMP3:%.*]] = select <8 x i1> [[TMP2]], <8 x i64> zeroinitializer, <8 x i64> <i64 2, i64 4, i64 8, i64 16, i64 32, i64 64, i64 128, i64 256>
; AVX-NEXT:    [[ARRAYIDX_9:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 9
; AVX-NEXT:    [[TMP4:%.*]] = load <4 x i8>, ptr [[ARRAYIDX_9]], align 1
; AVX-NEXT:    [[TMP5:%.*]] = icmp eq <4 x i8> [[TMP4]], zeroinitializer
; AVX-NEXT:    [[TMP6:%.*]] = select <4 x i1> [[TMP5]], <4 x i64> zeroinitializer, <4 x i64> <i64 512, i64 1024, i64 2048, i64 4096>
; AVX-NEXT:    [[ARRAYIDX_13:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 13
; AVX-NEXT:    [[TMP7:%.*]] = load i8, ptr [[ARRAYIDX_13]], align 1
; AVX-NEXT:    [[TOBOOL_NOT_13:%.*]] = icmp eq i8 [[TMP7]], 0
; AVX-NEXT:    [[OR_13:%.*]] = select i1 [[TOBOOL_NOT_13]], i64 0, i64 8192
; AVX-NEXT:    [[ARRAYIDX_14:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 14
; AVX-NEXT:    [[TMP8:%.*]] = load i8, ptr [[ARRAYIDX_14]], align 1
; AVX-NEXT:    [[TOBOOL_NOT_14:%.*]] = icmp eq i8 [[TMP8]], 0
; AVX-NEXT:    [[OR_14:%.*]] = select i1 [[TOBOOL_NOT_14]], i64 0, i64 16384
; AVX-NEXT:    [[ARRAYIDX_15:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 15
; AVX-NEXT:    [[TMP9:%.*]] = load i8, ptr [[ARRAYIDX_15]], align 1
; AVX-NEXT:    [[TOBOOL_NOT_15:%.*]] = icmp eq i8 [[TMP9]], 0
; AVX-NEXT:    [[OR_15:%.*]] = select i1 [[TOBOOL_NOT_15]], i64 0, i64 32768
; AVX-NEXT:    [[TMP10:%.*]] = call i64 @llvm.vector.reduce.or.v8i64(<8 x i64> [[TMP3]])
; AVX-NEXT:    [[TMP11:%.*]] = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> [[TMP6]])
; AVX-NEXT:    [[OP_RDX:%.*]] = or i64 [[TMP10]], [[TMP11]]
; AVX-NEXT:    [[OP_RDX1:%.*]] = or i64 [[OP_RDX]], [[OR_13]]
; AVX-NEXT:    [[OP_RDX2:%.*]] = or i64 [[OR_14]], [[OR_15]]
; AVX-NEXT:    [[OP_RDX3:%.*]] = or i64 [[OP_RDX1]], [[OP_RDX2]]
; AVX-NEXT:    [[OP_RDX4:%.*]] = or i64 [[OP_RDX3]], [[OR]]
; AVX-NEXT:    ret i64 [[OP_RDX4]]
;
; AVX512-LABEL: @bitmask_16xi8(
; AVX512-NEXT:  entry:
; AVX512-NEXT:    [[TMP0:%.*]] = load i8, ptr [[SRC:%.*]], align 1
; AVX512-NEXT:    [[TOBOOL_NOT:%.*]] = icmp ne i8 [[TMP0]], 0
; AVX512-NEXT:    [[OR:%.*]] = zext i1 [[TOBOOL_NOT]] to i64
; AVX512-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 1
; AVX512-NEXT:    [[TMP1:%.*]] = load <8 x i8>, ptr [[ARRAYIDX_1]], align 1
; AVX512-NEXT:    [[TMP2:%.*]] = icmp eq <8 x i8> [[TMP1]], zeroinitializer
; AVX512-NEXT:    [[TMP3:%.*]] = select <8 x i1> [[TMP2]], <8 x i64> zeroinitializer, <8 x i64> <i64 2, i64 4, i64 8, i64 16, i64 32, i64 64, i64 128, i64 256>
; AVX512-NEXT:    [[ARRAYIDX_9:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 9
; AVX512-NEXT:    [[TMP4:%.*]] = load <4 x i8>, ptr [[ARRAYIDX_9]], align 1
; AVX512-NEXT:    [[TMP5:%.*]] = icmp eq <4 x i8> [[TMP4]], zeroinitializer
; AVX512-NEXT:    [[TMP6:%.*]] = select <4 x i1> [[TMP5]], <4 x i64> zeroinitializer, <4 x i64> <i64 512, i64 1024, i64 2048, i64 4096>
; AVX512-NEXT:    [[ARRAYIDX_13:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 13
; AVX512-NEXT:    [[TMP7:%.*]] = load i8, ptr [[ARRAYIDX_13]], align 1
; AVX512-NEXT:    [[TOBOOL_NOT_13:%.*]] = icmp eq i8 [[TMP7]], 0
; AVX512-NEXT:    [[OR_13:%.*]] = select i1 [[TOBOOL_NOT_13]], i64 0, i64 8192
; AVX512-NEXT:    [[ARRAYIDX_14:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 14
; AVX512-NEXT:    [[TMP8:%.*]] = load <2 x i8>, ptr [[ARRAYIDX_14]], align 1
; AVX512-NEXT:    [[TMP9:%.*]] = icmp eq <2 x i8> [[TMP8]], zeroinitializer
; AVX512-NEXT:    [[TMP10:%.*]] = select <2 x i1> [[TMP9]], <2 x i64> zeroinitializer, <2 x i64> <i64 16384, i64 32768>
; AVX512-NEXT:    [[TMP11:%.*]] = call i64 @llvm.vector.reduce.or.v8i64(<8 x i64> [[TMP3]])
; AVX512-NEXT:    [[TMP12:%.*]] = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> [[TMP6]])
; AVX512-NEXT:    [[OP_RDX:%.*]] = or i64 [[TMP11]], [[TMP12]]
; AVX512-NEXT:    [[OP_RDX1:%.*]] = or i64 [[OP_RDX]], [[OR_13]]
; AVX512-NEXT:    [[TMP13:%.*]] = extractelement <2 x i64> [[TMP10]], i32 0
; AVX512-NEXT:    [[TMP14:%.*]] = extractelement <2 x i64> [[TMP10]], i32 1
; AVX512-NEXT:    [[OP_RDX2:%.*]] = or i64 [[TMP13]], [[TMP14]]
; AVX512-NEXT:    [[OP_RDX3:%.*]] = or i64 [[OP_RDX1]], [[OP_RDX2]]
; AVX512-NEXT:    [[OP_RDX4:%.*]] = or i64 [[OP_RDX3]], [[OR]]
; AVX512-NEXT:    ret i64 [[OP_RDX4]]
;
entry:
  %0 = load i8, ptr %src, align 1
  %tobool.not = icmp ne i8 %0, 0
  %or = zext i1 %tobool.not to i64
  %arrayidx.1 = getelementptr inbounds i8, ptr %src, i64 1
  %1 = load i8, ptr %arrayidx.1, align 1
  %tobool.not.1 = icmp eq i8 %1, 0
  %or.1 = select i1 %tobool.not.1, i64 0, i64 2
  %mask.1.1 = or i64 %or.1, %or
  %arrayidx.2 = getelementptr inbounds i8, ptr %src, i64 2
  %2 = load i8, ptr %arrayidx.2, align 1
  %tobool.not.2 = icmp eq i8 %2, 0
  %or.2 = select i1 %tobool.not.2, i64 0, i64 4
  %mask.1.2 = or i64 %or.2, %mask.1.1
  %arrayidx.3 = getelementptr inbounds i8, ptr %src, i64 3
  %3 = load i8, ptr %arrayidx.3, align 1
  %tobool.not.3 = icmp eq i8 %3, 0
  %or.3 = select i1 %tobool.not.3, i64 0, i64 8
  %mask.1.3 = or i64 %or.3, %mask.1.2
  %arrayidx.4 = getelementptr inbounds i8, ptr %src, i64 4
  %4 = load i8, ptr %arrayidx.4, align 1
  %tobool.not.4 = icmp eq i8 %4, 0
  %or.4 = select i1 %tobool.not.4, i64 0, i64 16
  %mask.1.4 = or i64 %or.4, %mask.1.3
  %arrayidx.5 = getelementptr inbounds i8, ptr %src, i64 5
  %5 = load i8, ptr %arrayidx.5, align 1
  %tobool.not.5 = icmp eq i8 %5, 0
  %or.5 = select i1 %tobool.not.5, i64 0, i64 32
  %mask.1.5 = or i64 %or.5, %mask.1.4
  %arrayidx.6 = getelementptr inbounds i8, ptr %src, i64 6
  %6 = load i8, ptr %arrayidx.6, align 1
  %tobool.not.6 = icmp eq i8 %6, 0
  %or.6 = select i1 %tobool.not.6, i64 0, i64 64
  %mask.1.6 = or i64 %or.6, %mask.1.5
  %arrayidx.7 = getelementptr inbounds i8, ptr %src, i64 7
  %7 = load i8, ptr %arrayidx.7, align 1
  %tobool.not.7 = icmp eq i8 %7, 0
  %or.7 = select i1 %tobool.not.7, i64 0, i64 128
  %mask.1.7 = or i64 %or.7, %mask.1.6
  %arrayidx.8 = getelementptr inbounds i8, ptr %src, i64 8
  %8 = load i8, ptr %arrayidx.8, align 1
  %tobool.not.8 = icmp eq i8 %8, 0
  %or.8 = select i1 %tobool.not.8, i64 0, i64 256
  %mask.1.8 = or i64 %or.8, %mask.1.7
  %arrayidx.9 = getelementptr inbounds i8, ptr %src, i64 9
  %9 = load i8, ptr %arrayidx.9, align 1
  %tobool.not.9 = icmp eq i8 %9, 0
  %or.9 = select i1 %tobool.not.9, i64 0, i64 512
  %mask.1.9 = or i64 %or.9, %mask.1.8
  %arrayidx.10 = getelementptr inbounds i8, ptr %src, i64 10
  %10 = load i8, ptr %arrayidx.10, align 1
  %tobool.not.10 = icmp eq i8 %10, 0
  %or.10 = select i1 %tobool.not.10, i64 0, i64 1024
  %mask.1.10 = or i64 %or.10, %mask.1.9
  %arrayidx.11 = getelementptr inbounds i8, ptr %src, i64 11
  %11 = load i8, ptr %arrayidx.11, align 1
  %tobool.not.11 = icmp eq i8 %11, 0
  %or.11 = select i1 %tobool.not.11, i64 0, i64 2048
  %mask.1.11 = or i64 %or.11, %mask.1.10
  %arrayidx.12 = getelementptr inbounds i8, ptr %src, i64 12
  %12 = load i8, ptr %arrayidx.12, align 1
  %tobool.not.12 = icmp eq i8 %12, 0
  %or.12 = select i1 %tobool.not.12, i64 0, i64 4096
  %mask.1.12 = or i64 %or.12, %mask.1.11
  %arrayidx.13 = getelementptr inbounds i8, ptr %src, i64 13
  %13 = load i8, ptr %arrayidx.13, align 1
  %tobool.not.13 = icmp eq i8 %13, 0
  %or.13 = select i1 %tobool.not.13, i64 0, i64 8192
  %mask.1.13 = or i64 %or.13, %mask.1.12
  %arrayidx.14 = getelementptr inbounds i8, ptr %src, i64 14
  %14 = load i8, ptr %arrayidx.14, align 1
  %tobool.not.14 = icmp eq i8 %14, 0
  %or.14 = select i1 %tobool.not.14, i64 0, i64 16384
  %mask.1.14 = or i64 %or.14, %mask.1.13
  %arrayidx.15 = getelementptr inbounds i8, ptr %src, i64 15
  %15 = load i8, ptr %arrayidx.15, align 1
  %tobool.not.15 = icmp eq i8 %15, 0
  %or.15 = select i1 %tobool.not.15, i64 0, i64 32768
  %mask.1.15 = or i64 %or.15, %mask.1.14
  ret i64 %mask.1.15
}

define i64 @bitmask_4xi16(ptr nocapture noundef readonly %src) {
; SSE-LABEL: @bitmask_4xi16(
; SSE-NEXT:  entry:
; SSE-NEXT:    [[TMP0:%.*]] = load i16, ptr [[SRC:%.*]], align 2
; SSE-NEXT:    [[TOBOOL_NOT:%.*]] = icmp ne i16 [[TMP0]], 0
; SSE-NEXT:    [[OR:%.*]] = zext i1 [[TOBOOL_NOT]] to i64
; SSE-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i64 1
; SSE-NEXT:    [[TMP1:%.*]] = load <4 x i16>, ptr [[ARRAYIDX_1]], align 2
; SSE-NEXT:    [[TMP2:%.*]] = icmp eq <4 x i16> [[TMP1]], zeroinitializer
; SSE-NEXT:    [[TMP3:%.*]] = select <4 x i1> [[TMP2]], <4 x i64> zeroinitializer, <4 x i64> <i64 2, i64 4, i64 8, i64 16>
; SSE-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i64 5
; SSE-NEXT:    [[TMP4:%.*]] = load i16, ptr [[ARRAYIDX_5]], align 2
; SSE-NEXT:    [[TOBOOL_NOT_5:%.*]] = icmp eq i16 [[TMP4]], 0
; SSE-NEXT:    [[OR_5:%.*]] = select i1 [[TOBOOL_NOT_5]], i64 0, i64 32
; SSE-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i64 6
; SSE-NEXT:    [[TMP5:%.*]] = load i16, ptr [[ARRAYIDX_6]], align 2
; SSE-NEXT:    [[TOBOOL_NOT_6:%.*]] = icmp eq i16 [[TMP5]], 0
; SSE-NEXT:    [[OR_6:%.*]] = select i1 [[TOBOOL_NOT_6]], i64 0, i64 64
; SSE-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i64 7
; SSE-NEXT:    [[TMP6:%.*]] = load i16, ptr [[ARRAYIDX_7]], align 2
; SSE-NEXT:    [[TOBOOL_NOT_7:%.*]] = icmp eq i16 [[TMP6]], 0
; SSE-NEXT:    [[OR_7:%.*]] = select i1 [[TOBOOL_NOT_7]], i64 0, i64 128
; SSE-NEXT:    [[TMP7:%.*]] = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> [[TMP3]])
; SSE-NEXT:    [[OP_RDX:%.*]] = or i64 [[TMP7]], [[OR_5]]
; SSE-NEXT:    [[OP_RDX1:%.*]] = or i64 [[OR_6]], [[OR_7]]
; SSE-NEXT:    [[OP_RDX2:%.*]] = or i64 [[OP_RDX]], [[OP_RDX1]]
; SSE-NEXT:    [[OP_RDX3:%.*]] = or i64 [[OP_RDX2]], [[OR]]
; SSE-NEXT:    ret i64 [[OP_RDX3]]
;
; AVX-LABEL: @bitmask_4xi16(
; AVX-NEXT:  entry:
; AVX-NEXT:    [[TMP0:%.*]] = load i16, ptr [[SRC:%.*]], align 2
; AVX-NEXT:    [[TOBOOL_NOT:%.*]] = icmp ne i16 [[TMP0]], 0
; AVX-NEXT:    [[OR:%.*]] = zext i1 [[TOBOOL_NOT]] to i64
; AVX-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i64 1
; AVX-NEXT:    [[TMP1:%.*]] = load <4 x i16>, ptr [[ARRAYIDX_1]], align 2
; AVX-NEXT:    [[TMP2:%.*]] = icmp eq <4 x i16> [[TMP1]], zeroinitializer
; AVX-NEXT:    [[TMP3:%.*]] = select <4 x i1> [[TMP2]], <4 x i64> zeroinitializer, <4 x i64> <i64 2, i64 4, i64 8, i64 16>
; AVX-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i64 5
; AVX-NEXT:    [[TMP4:%.*]] = load i16, ptr [[ARRAYIDX_5]], align 2
; AVX-NEXT:    [[TOBOOL_NOT_5:%.*]] = icmp eq i16 [[TMP4]], 0
; AVX-NEXT:    [[OR_5:%.*]] = select i1 [[TOBOOL_NOT_5]], i64 0, i64 32
; AVX-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i64 6
; AVX-NEXT:    [[TMP5:%.*]] = load i16, ptr [[ARRAYIDX_6]], align 2
; AVX-NEXT:    [[TOBOOL_NOT_6:%.*]] = icmp eq i16 [[TMP5]], 0
; AVX-NEXT:    [[OR_6:%.*]] = select i1 [[TOBOOL_NOT_6]], i64 0, i64 64
; AVX-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i64 7
; AVX-NEXT:    [[TMP6:%.*]] = load i16, ptr [[ARRAYIDX_7]], align 2
; AVX-NEXT:    [[TOBOOL_NOT_7:%.*]] = icmp eq i16 [[TMP6]], 0
; AVX-NEXT:    [[OR_7:%.*]] = select i1 [[TOBOOL_NOT_7]], i64 0, i64 128
; AVX-NEXT:    [[TMP7:%.*]] = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> [[TMP3]])
; AVX-NEXT:    [[OP_RDX:%.*]] = or i64 [[TMP7]], [[OR_5]]
; AVX-NEXT:    [[OP_RDX1:%.*]] = or i64 [[OR_6]], [[OR_7]]
; AVX-NEXT:    [[OP_RDX2:%.*]] = or i64 [[OP_RDX]], [[OP_RDX1]]
; AVX-NEXT:    [[OP_RDX3:%.*]] = or i64 [[OP_RDX2]], [[OR]]
; AVX-NEXT:    ret i64 [[OP_RDX3]]
;
; AVX512-LABEL: @bitmask_4xi16(
; AVX512-NEXT:  entry:
; AVX512-NEXT:    [[TMP0:%.*]] = load i16, ptr [[SRC:%.*]], align 2
; AVX512-NEXT:    [[TOBOOL_NOT:%.*]] = icmp ne i16 [[TMP0]], 0
; AVX512-NEXT:    [[OR:%.*]] = zext i1 [[TOBOOL_NOT]] to i64
; AVX512-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i64 1
; AVX512-NEXT:    [[TMP1:%.*]] = load <4 x i16>, ptr [[ARRAYIDX_1]], align 2
; AVX512-NEXT:    [[TMP2:%.*]] = icmp eq <4 x i16> [[TMP1]], zeroinitializer
; AVX512-NEXT:    [[TMP3:%.*]] = select <4 x i1> [[TMP2]], <4 x i64> zeroinitializer, <4 x i64> <i64 2, i64 4, i64 8, i64 16>
; AVX512-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i64 5
; AVX512-NEXT:    [[TMP4:%.*]] = load i16, ptr [[ARRAYIDX_5]], align 2
; AVX512-NEXT:    [[TOBOOL_NOT_5:%.*]] = icmp eq i16 [[TMP4]], 0
; AVX512-NEXT:    [[OR_5:%.*]] = select i1 [[TOBOOL_NOT_5]], i64 0, i64 32
; AVX512-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i64 6
; AVX512-NEXT:    [[TMP5:%.*]] = load <2 x i16>, ptr [[ARRAYIDX_6]], align 2
; AVX512-NEXT:    [[TMP6:%.*]] = icmp eq <2 x i16> [[TMP5]], zeroinitializer
; AVX512-NEXT:    [[TMP7:%.*]] = select <2 x i1> [[TMP6]], <2 x i64> zeroinitializer, <2 x i64> <i64 64, i64 128>
; AVX512-NEXT:    [[TMP8:%.*]] = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> [[TMP3]])
; AVX512-NEXT:    [[OP_RDX:%.*]] = or i64 [[TMP8]], [[OR_5]]
; AVX512-NEXT:    [[TMP9:%.*]] = extractelement <2 x i64> [[TMP7]], i32 0
; AVX512-NEXT:    [[TMP10:%.*]] = extractelement <2 x i64> [[TMP7]], i32 1
; AVX512-NEXT:    [[OP_RDX1:%.*]] = or i64 [[TMP9]], [[TMP10]]
; AVX512-NEXT:    [[OP_RDX2:%.*]] = or i64 [[OP_RDX]], [[OP_RDX1]]
; AVX512-NEXT:    [[OP_RDX3:%.*]] = or i64 [[OP_RDX2]], [[OR]]
; AVX512-NEXT:    ret i64 [[OP_RDX3]]
;
entry:
  %0 = load i16, ptr %src, align 2
  %tobool.not = icmp ne i16 %0, 0
  %or = zext i1 %tobool.not to i64
  %arrayidx.1 = getelementptr inbounds i16, ptr %src, i64 1
  %1 = load i16, ptr %arrayidx.1, align 2
  %tobool.not.1 = icmp eq i16 %1, 0
  %or.1 = select i1 %tobool.not.1, i64 0, i64 2
  %mask.1.1 = or i64 %or.1, %or
  %arrayidx.2 = getelementptr inbounds i16, ptr %src, i64 2
  %2 = load i16, ptr %arrayidx.2, align 2
  %tobool.not.2 = icmp eq i16 %2, 0
  %or.2 = select i1 %tobool.not.2, i64 0, i64 4
  %mask.1.2 = or i64 %or.2, %mask.1.1
  %arrayidx.3 = getelementptr inbounds i16, ptr %src, i64 3
  %3 = load i16, ptr %arrayidx.3, align 2
  %tobool.not.3 = icmp eq i16 %3, 0
  %or.3 = select i1 %tobool.not.3, i64 0, i64 8
  %mask.1.3 = or i64 %or.3, %mask.1.2
  %arrayidx.4 = getelementptr inbounds i16, ptr %src, i64 4
  %4 = load i16, ptr %arrayidx.4, align 2
  %tobool.not.4 = icmp eq i16 %4, 0
  %or.4 = select i1 %tobool.not.4, i64 0, i64 16
  %mask.1.4 = or i64 %or.4, %mask.1.3
  %arrayidx.5 = getelementptr inbounds i16, ptr %src, i64 5
  %5 = load i16, ptr %arrayidx.5, align 2
  %tobool.not.5 = icmp eq i16 %5, 0
  %or.5 = select i1 %tobool.not.5, i64 0, i64 32
  %mask.1.5 = or i64 %or.5, %mask.1.4
  %arrayidx.6 = getelementptr inbounds i16, ptr %src, i64 6
  %6 = load i16, ptr %arrayidx.6, align 2
  %tobool.not.6 = icmp eq i16 %6, 0
  %or.6 = select i1 %tobool.not.6, i64 0, i64 64
  %mask.1.6 = or i64 %or.6, %mask.1.5
  %arrayidx.7 = getelementptr inbounds i16, ptr %src, i64 7
  %7 = load i16, ptr %arrayidx.7, align 2
  %tobool.not.7 = icmp eq i16 %7, 0
  %or.7 = select i1 %tobool.not.7, i64 0, i64 128
  %mask.1.7 = or i64 %or.7, %mask.1.6
  ret i64 %mask.1.7
}

define i64 @bitmask_8xi32(ptr nocapture noundef readonly %src) {
; SSE-LABEL: @bitmask_8xi32(
; SSE-NEXT:  entry:
; SSE-NEXT:    [[TMP0:%.*]] = load i32, ptr [[SRC:%.*]], align 4
; SSE-NEXT:    [[TOBOOL_NOT:%.*]] = icmp ne i32 [[TMP0]], 0
; SSE-NEXT:    [[OR:%.*]] = zext i1 [[TOBOOL_NOT]] to i64
; SSE-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 1
; SSE-NEXT:    [[TMP1:%.*]] = load <4 x i32>, ptr [[ARRAYIDX_1]], align 4
; SSE-NEXT:    [[TMP2:%.*]] = icmp eq <4 x i32> [[TMP1]], zeroinitializer
; SSE-NEXT:    [[TMP3:%.*]] = select <4 x i1> [[TMP2]], <4 x i64> zeroinitializer, <4 x i64> <i64 2, i64 4, i64 8, i64 16>
; SSE-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 5
; SSE-NEXT:    [[TMP4:%.*]] = load i32, ptr [[ARRAYIDX_5]], align 4
; SSE-NEXT:    [[TOBOOL_NOT_5:%.*]] = icmp eq i32 [[TMP4]], 0
; SSE-NEXT:    [[OR_5:%.*]] = select i1 [[TOBOOL_NOT_5]], i64 0, i64 32
; SSE-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 6
; SSE-NEXT:    [[TMP5:%.*]] = load i32, ptr [[ARRAYIDX_6]], align 4
; SSE-NEXT:    [[TOBOOL_NOT_6:%.*]] = icmp eq i32 [[TMP5]], 0
; SSE-NEXT:    [[OR_6:%.*]] = select i1 [[TOBOOL_NOT_6]], i64 0, i64 64
; SSE-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 7
; SSE-NEXT:    [[TMP6:%.*]] = load i32, ptr [[ARRAYIDX_7]], align 4
; SSE-NEXT:    [[TOBOOL_NOT_7:%.*]] = icmp eq i32 [[TMP6]], 0
; SSE-NEXT:    [[OR_7:%.*]] = select i1 [[TOBOOL_NOT_7]], i64 0, i64 128
; SSE-NEXT:    [[TMP7:%.*]] = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> [[TMP3]])
; SSE-NEXT:    [[OP_RDX:%.*]] = or i64 [[TMP7]], [[OR_5]]
; SSE-NEXT:    [[OP_RDX1:%.*]] = or i64 [[OR_6]], [[OR_7]]
; SSE-NEXT:    [[OP_RDX2:%.*]] = or i64 [[OP_RDX]], [[OP_RDX1]]
; SSE-NEXT:    [[OP_RDX3:%.*]] = or i64 [[OP_RDX2]], [[OR]]
; SSE-NEXT:    ret i64 [[OP_RDX3]]
;
; AVX-LABEL: @bitmask_8xi32(
; AVX-NEXT:  entry:
; AVX-NEXT:    [[TMP0:%.*]] = load i32, ptr [[SRC:%.*]], align 4
; AVX-NEXT:    [[TOBOOL_NOT:%.*]] = icmp ne i32 [[TMP0]], 0
; AVX-NEXT:    [[OR:%.*]] = zext i1 [[TOBOOL_NOT]] to i64
; AVX-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 1
; AVX-NEXT:    [[TMP1:%.*]] = load <4 x i32>, ptr [[ARRAYIDX_1]], align 4
; AVX-NEXT:    [[TMP2:%.*]] = icmp eq <4 x i32> [[TMP1]], zeroinitializer
; AVX-NEXT:    [[TMP3:%.*]] = select <4 x i1> [[TMP2]], <4 x i64> zeroinitializer, <4 x i64> <i64 2, i64 4, i64 8, i64 16>
; AVX-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 5
; AVX-NEXT:    [[TMP4:%.*]] = load i32, ptr [[ARRAYIDX_5]], align 4
; AVX-NEXT:    [[TOBOOL_NOT_5:%.*]] = icmp eq i32 [[TMP4]], 0
; AVX-NEXT:    [[OR_5:%.*]] = select i1 [[TOBOOL_NOT_5]], i64 0, i64 32
; AVX-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 6
; AVX-NEXT:    [[TMP5:%.*]] = load i32, ptr [[ARRAYIDX_6]], align 4
; AVX-NEXT:    [[TOBOOL_NOT_6:%.*]] = icmp eq i32 [[TMP5]], 0
; AVX-NEXT:    [[OR_6:%.*]] = select i1 [[TOBOOL_NOT_6]], i64 0, i64 64
; AVX-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 7
; AVX-NEXT:    [[TMP6:%.*]] = load i32, ptr [[ARRAYIDX_7]], align 4
; AVX-NEXT:    [[TOBOOL_NOT_7:%.*]] = icmp eq i32 [[TMP6]], 0
; AVX-NEXT:    [[OR_7:%.*]] = select i1 [[TOBOOL_NOT_7]], i64 0, i64 128
; AVX-NEXT:    [[TMP7:%.*]] = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> [[TMP3]])
; AVX-NEXT:    [[OP_RDX:%.*]] = or i64 [[TMP7]], [[OR_5]]
; AVX-NEXT:    [[OP_RDX1:%.*]] = or i64 [[OR_6]], [[OR_7]]
; AVX-NEXT:    [[OP_RDX2:%.*]] = or i64 [[OP_RDX]], [[OP_RDX1]]
; AVX-NEXT:    [[OP_RDX3:%.*]] = or i64 [[OP_RDX2]], [[OR]]
; AVX-NEXT:    ret i64 [[OP_RDX3]]
;
; AVX512-LABEL: @bitmask_8xi32(
; AVX512-NEXT:  entry:
; AVX512-NEXT:    [[TMP0:%.*]] = load i32, ptr [[SRC:%.*]], align 4
; AVX512-NEXT:    [[TOBOOL_NOT:%.*]] = icmp ne i32 [[TMP0]], 0
; AVX512-NEXT:    [[OR:%.*]] = zext i1 [[TOBOOL_NOT]] to i64
; AVX512-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 1
; AVX512-NEXT:    [[TMP1:%.*]] = load <4 x i32>, ptr [[ARRAYIDX_1]], align 4
; AVX512-NEXT:    [[TMP2:%.*]] = icmp eq <4 x i32> [[TMP1]], zeroinitializer
; AVX512-NEXT:    [[TMP3:%.*]] = select <4 x i1> [[TMP2]], <4 x i64> zeroinitializer, <4 x i64> <i64 2, i64 4, i64 8, i64 16>
; AVX512-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 5
; AVX512-NEXT:    [[TMP4:%.*]] = load i32, ptr [[ARRAYIDX_5]], align 4
; AVX512-NEXT:    [[TOBOOL_NOT_5:%.*]] = icmp eq i32 [[TMP4]], 0
; AVX512-NEXT:    [[OR_5:%.*]] = select i1 [[TOBOOL_NOT_5]], i64 0, i64 32
; AVX512-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i32, ptr [[SRC]], i64 6
; AVX512-NEXT:    [[TMP5:%.*]] = load <2 x i32>, ptr [[ARRAYIDX_6]], align 4
; AVX512-NEXT:    [[TMP6:%.*]] = icmp eq <2 x i32> [[TMP5]], zeroinitializer
; AVX512-NEXT:    [[TMP7:%.*]] = select <2 x i1> [[TMP6]], <2 x i64> zeroinitializer, <2 x i64> <i64 64, i64 128>
; AVX512-NEXT:    [[TMP8:%.*]] = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> [[TMP3]])
; AVX512-NEXT:    [[OP_RDX:%.*]] = or i64 [[TMP8]], [[OR_5]]
; AVX512-NEXT:    [[TMP9:%.*]] = extractelement <2 x i64> [[TMP7]], i32 0
; AVX512-NEXT:    [[TMP10:%.*]] = extractelement <2 x i64> [[TMP7]], i32 1
; AVX512-NEXT:    [[OP_RDX1:%.*]] = or i64 [[TMP9]], [[TMP10]]
; AVX512-NEXT:    [[OP_RDX2:%.*]] = or i64 [[OP_RDX]], [[OP_RDX1]]
; AVX512-NEXT:    [[OP_RDX3:%.*]] = or i64 [[OP_RDX2]], [[OR]]
; AVX512-NEXT:    ret i64 [[OP_RDX3]]
;
entry:
  %0 = load i32, ptr %src, align 4
  %tobool.not = icmp ne i32 %0, 0
  %or = zext i1 %tobool.not to i64
  %arrayidx.1 = getelementptr inbounds i32, ptr %src, i64 1
  %1 = load i32, ptr %arrayidx.1, align 4
  %tobool.not.1 = icmp eq i32 %1, 0
  %or.1 = select i1 %tobool.not.1, i64 0, i64 2
  %mask.1.1 = or i64 %or.1, %or
  %arrayidx.2 = getelementptr inbounds i32, ptr %src, i64 2
  %2 = load i32, ptr %arrayidx.2, align 4
  %tobool.not.2 = icmp eq i32 %2, 0
  %or.2 = select i1 %tobool.not.2, i64 0, i64 4
  %mask.1.2 = or i64 %or.2, %mask.1.1
  %arrayidx.3 = getelementptr inbounds i32, ptr %src, i64 3
  %3 = load i32, ptr %arrayidx.3, align 4
  %tobool.not.3 = icmp eq i32 %3, 0
  %or.3 = select i1 %tobool.not.3, i64 0, i64 8
  %mask.1.3 = or i64 %or.3, %mask.1.2
  %arrayidx.4 = getelementptr inbounds i32, ptr %src, i64 4
  %4 = load i32, ptr %arrayidx.4, align 4
  %tobool.not.4 = icmp eq i32 %4, 0
  %or.4 = select i1 %tobool.not.4, i64 0, i64 16
  %mask.1.4 = or i64 %or.4, %mask.1.3
  %arrayidx.5 = getelementptr inbounds i32, ptr %src, i64 5
  %5 = load i32, ptr %arrayidx.5, align 4
  %tobool.not.5 = icmp eq i32 %5, 0
  %or.5 = select i1 %tobool.not.5, i64 0, i64 32
  %mask.1.5 = or i64 %or.5, %mask.1.4
  %arrayidx.6 = getelementptr inbounds i32, ptr %src, i64 6
  %6 = load i32, ptr %arrayidx.6, align 4
  %tobool.not.6 = icmp eq i32 %6, 0
  %or.6 = select i1 %tobool.not.6, i64 0, i64 64
  %mask.1.6 = or i64 %or.6, %mask.1.5
  %arrayidx.7 = getelementptr inbounds i32, ptr %src, i64 7
  %7 = load i32, ptr %arrayidx.7, align 4
  %tobool.not.7 = icmp eq i32 %7, 0
  %or.7 = select i1 %tobool.not.7, i64 0, i64 128
  %mask.1.7 = or i64 %or.7, %mask.1.6
  ret i64 %mask.1.7
}

define i64 @bitmask_8xi64(ptr nocapture noundef readonly %src) {
; SSE2-LABEL: @bitmask_8xi64(
; SSE2-NEXT:  entry:
; SSE2-NEXT:    [[TMP0:%.*]] = load i64, ptr [[SRC:%.*]], align 8
; SSE2-NEXT:    [[TOBOOL_NOT:%.*]] = icmp ne i64 [[TMP0]], 0
; SSE2-NEXT:    [[OR:%.*]] = zext i1 [[TOBOOL_NOT]] to i64
; SSE2-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 1
; SSE2-NEXT:    [[TMP1:%.*]] = load i64, ptr [[ARRAYIDX_1]], align 8
; SSE2-NEXT:    [[TOBOOL_NOT_1:%.*]] = icmp eq i64 [[TMP1]], 0
; SSE2-NEXT:    [[OR_1:%.*]] = select i1 [[TOBOOL_NOT_1]], i64 0, i64 2
; SSE2-NEXT:    [[MASK_1_1:%.*]] = or i64 [[OR_1]], [[OR]]
; SSE2-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 2
; SSE2-NEXT:    [[TMP2:%.*]] = load i64, ptr [[ARRAYIDX_2]], align 8
; SSE2-NEXT:    [[TOBOOL_NOT_2:%.*]] = icmp eq i64 [[TMP2]], 0
; SSE2-NEXT:    [[OR_2:%.*]] = select i1 [[TOBOOL_NOT_2]], i64 0, i64 4
; SSE2-NEXT:    [[MASK_1_2:%.*]] = or i64 [[OR_2]], [[MASK_1_1]]
; SSE2-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 3
; SSE2-NEXT:    [[TMP3:%.*]] = load i64, ptr [[ARRAYIDX_3]], align 8
; SSE2-NEXT:    [[TOBOOL_NOT_3:%.*]] = icmp eq i64 [[TMP3]], 0
; SSE2-NEXT:    [[OR_3:%.*]] = select i1 [[TOBOOL_NOT_3]], i64 0, i64 8
; SSE2-NEXT:    [[MASK_1_3:%.*]] = or i64 [[OR_3]], [[MASK_1_2]]
; SSE2-NEXT:    [[ARRAYIDX_4:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 4
; SSE2-NEXT:    [[TMP4:%.*]] = load i64, ptr [[ARRAYIDX_4]], align 8
; SSE2-NEXT:    [[TOBOOL_NOT_4:%.*]] = icmp eq i64 [[TMP4]], 0
; SSE2-NEXT:    [[OR_4:%.*]] = select i1 [[TOBOOL_NOT_4]], i64 0, i64 16
; SSE2-NEXT:    [[MASK_1_4:%.*]] = or i64 [[OR_4]], [[MASK_1_3]]
; SSE2-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 5
; SSE2-NEXT:    [[TMP5:%.*]] = load i64, ptr [[ARRAYIDX_5]], align 8
; SSE2-NEXT:    [[TOBOOL_NOT_5:%.*]] = icmp eq i64 [[TMP5]], 0
; SSE2-NEXT:    [[OR_5:%.*]] = select i1 [[TOBOOL_NOT_5]], i64 0, i64 32
; SSE2-NEXT:    [[MASK_1_5:%.*]] = or i64 [[OR_5]], [[MASK_1_4]]
; SSE2-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 6
; SSE2-NEXT:    [[TMP6:%.*]] = load i64, ptr [[ARRAYIDX_6]], align 8
; SSE2-NEXT:    [[TOBOOL_NOT_6:%.*]] = icmp eq i64 [[TMP6]], 0
; SSE2-NEXT:    [[OR_6:%.*]] = select i1 [[TOBOOL_NOT_6]], i64 0, i64 64
; SSE2-NEXT:    [[MASK_1_6:%.*]] = or i64 [[OR_6]], [[MASK_1_5]]
; SSE2-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 7
; SSE2-NEXT:    [[TMP7:%.*]] = load i64, ptr [[ARRAYIDX_7]], align 8
; SSE2-NEXT:    [[TOBOOL_NOT_7:%.*]] = icmp eq i64 [[TMP7]], 0
; SSE2-NEXT:    [[OR_7:%.*]] = select i1 [[TOBOOL_NOT_7]], i64 0, i64 128
; SSE2-NEXT:    [[MASK_1_7:%.*]] = or i64 [[OR_7]], [[MASK_1_6]]
; SSE2-NEXT:    ret i64 [[MASK_1_7]]
;
; SSE4-LABEL: @bitmask_8xi64(
; SSE4-NEXT:  entry:
; SSE4-NEXT:    [[TMP0:%.*]] = load i64, ptr [[SRC:%.*]], align 8
; SSE4-NEXT:    [[TOBOOL_NOT:%.*]] = icmp ne i64 [[TMP0]], 0
; SSE4-NEXT:    [[OR:%.*]] = zext i1 [[TOBOOL_NOT]] to i64
; SSE4-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 1
; SSE4-NEXT:    [[TMP1:%.*]] = load <4 x i64>, ptr [[ARRAYIDX_1]], align 8
; SSE4-NEXT:    [[TMP2:%.*]] = icmp eq <4 x i64> [[TMP1]], zeroinitializer
; SSE4-NEXT:    [[TMP3:%.*]] = select <4 x i1> [[TMP2]], <4 x i64> zeroinitializer, <4 x i64> <i64 2, i64 4, i64 8, i64 16>
; SSE4-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 5
; SSE4-NEXT:    [[TMP4:%.*]] = load i64, ptr [[ARRAYIDX_5]], align 8
; SSE4-NEXT:    [[TOBOOL_NOT_5:%.*]] = icmp eq i64 [[TMP4]], 0
; SSE4-NEXT:    [[OR_5:%.*]] = select i1 [[TOBOOL_NOT_5]], i64 0, i64 32
; SSE4-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 6
; SSE4-NEXT:    [[TMP5:%.*]] = load i64, ptr [[ARRAYIDX_6]], align 8
; SSE4-NEXT:    [[TOBOOL_NOT_6:%.*]] = icmp eq i64 [[TMP5]], 0
; SSE4-NEXT:    [[OR_6:%.*]] = select i1 [[TOBOOL_NOT_6]], i64 0, i64 64
; SSE4-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 7
; SSE4-NEXT:    [[TMP6:%.*]] = load i64, ptr [[ARRAYIDX_7]], align 8
; SSE4-NEXT:    [[TOBOOL_NOT_7:%.*]] = icmp eq i64 [[TMP6]], 0
; SSE4-NEXT:    [[OR_7:%.*]] = select i1 [[TOBOOL_NOT_7]], i64 0, i64 128
; SSE4-NEXT:    [[TMP7:%.*]] = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> [[TMP3]])
; SSE4-NEXT:    [[OP_RDX:%.*]] = or i64 [[TMP7]], [[OR_5]]
; SSE4-NEXT:    [[OP_RDX1:%.*]] = or i64 [[OR_6]], [[OR_7]]
; SSE4-NEXT:    [[OP_RDX2:%.*]] = or i64 [[OP_RDX]], [[OP_RDX1]]
; SSE4-NEXT:    [[OP_RDX3:%.*]] = or i64 [[OP_RDX2]], [[OR]]
; SSE4-NEXT:    ret i64 [[OP_RDX3]]
;
; AVX-LABEL: @bitmask_8xi64(
; AVX-NEXT:  entry:
; AVX-NEXT:    [[TMP0:%.*]] = load i64, ptr [[SRC:%.*]], align 8
; AVX-NEXT:    [[TOBOOL_NOT:%.*]] = icmp ne i64 [[TMP0]], 0
; AVX-NEXT:    [[OR:%.*]] = zext i1 [[TOBOOL_NOT]] to i64
; AVX-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 1
; AVX-NEXT:    [[TMP1:%.*]] = load <4 x i64>, ptr [[ARRAYIDX_1]], align 8
; AVX-NEXT:    [[TMP2:%.*]] = icmp eq <4 x i64> [[TMP1]], zeroinitializer
; AVX-NEXT:    [[TMP3:%.*]] = select <4 x i1> [[TMP2]], <4 x i64> zeroinitializer, <4 x i64> <i64 2, i64 4, i64 8, i64 16>
; AVX-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 5
; AVX-NEXT:    [[TMP4:%.*]] = load i64, ptr [[ARRAYIDX_5]], align 8
; AVX-NEXT:    [[TOBOOL_NOT_5:%.*]] = icmp eq i64 [[TMP4]], 0
; AVX-NEXT:    [[OR_5:%.*]] = select i1 [[TOBOOL_NOT_5]], i64 0, i64 32
; AVX-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 6
; AVX-NEXT:    [[TMP5:%.*]] = load i64, ptr [[ARRAYIDX_6]], align 8
; AVX-NEXT:    [[TOBOOL_NOT_6:%.*]] = icmp eq i64 [[TMP5]], 0
; AVX-NEXT:    [[OR_6:%.*]] = select i1 [[TOBOOL_NOT_6]], i64 0, i64 64
; AVX-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 7
; AVX-NEXT:    [[TMP6:%.*]] = load i64, ptr [[ARRAYIDX_7]], align 8
; AVX-NEXT:    [[TOBOOL_NOT_7:%.*]] = icmp eq i64 [[TMP6]], 0
; AVX-NEXT:    [[OR_7:%.*]] = select i1 [[TOBOOL_NOT_7]], i64 0, i64 128
; AVX-NEXT:    [[TMP7:%.*]] = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> [[TMP3]])
; AVX-NEXT:    [[OP_RDX:%.*]] = or i64 [[TMP7]], [[OR_5]]
; AVX-NEXT:    [[OP_RDX1:%.*]] = or i64 [[OR_6]], [[OR_7]]
; AVX-NEXT:    [[OP_RDX2:%.*]] = or i64 [[OP_RDX]], [[OP_RDX1]]
; AVX-NEXT:    [[OP_RDX3:%.*]] = or i64 [[OP_RDX2]], [[OR]]
; AVX-NEXT:    ret i64 [[OP_RDX3]]
;
; AVX512-LABEL: @bitmask_8xi64(
; AVX512-NEXT:  entry:
; AVX512-NEXT:    [[TMP0:%.*]] = load i64, ptr [[SRC:%.*]], align 8
; AVX512-NEXT:    [[TOBOOL_NOT:%.*]] = icmp ne i64 [[TMP0]], 0
; AVX512-NEXT:    [[OR:%.*]] = zext i1 [[TOBOOL_NOT]] to i64
; AVX512-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 1
; AVX512-NEXT:    [[TMP1:%.*]] = load <4 x i64>, ptr [[ARRAYIDX_1]], align 8
; AVX512-NEXT:    [[TMP2:%.*]] = icmp eq <4 x i64> [[TMP1]], zeroinitializer
; AVX512-NEXT:    [[TMP3:%.*]] = select <4 x i1> [[TMP2]], <4 x i64> zeroinitializer, <4 x i64> <i64 2, i64 4, i64 8, i64 16>
; AVX512-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 5
; AVX512-NEXT:    [[TMP4:%.*]] = load i64, ptr [[ARRAYIDX_5]], align 8
; AVX512-NEXT:    [[TOBOOL_NOT_5:%.*]] = icmp eq i64 [[TMP4]], 0
; AVX512-NEXT:    [[OR_5:%.*]] = select i1 [[TOBOOL_NOT_5]], i64 0, i64 32
; AVX512-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i64, ptr [[SRC]], i64 6
; AVX512-NEXT:    [[TMP5:%.*]] = load <2 x i64>, ptr [[ARRAYIDX_6]], align 8
; AVX512-NEXT:    [[TMP6:%.*]] = icmp eq <2 x i64> [[TMP5]], zeroinitializer
; AVX512-NEXT:    [[TMP7:%.*]] = select <2 x i1> [[TMP6]], <2 x i64> zeroinitializer, <2 x i64> <i64 64, i64 128>
; AVX512-NEXT:    [[TMP8:%.*]] = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> [[TMP3]])
; AVX512-NEXT:    [[OP_RDX:%.*]] = or i64 [[TMP8]], [[OR_5]]
; AVX512-NEXT:    [[TMP9:%.*]] = extractelement <2 x i64> [[TMP7]], i32 0
; AVX512-NEXT:    [[TMP10:%.*]] = extractelement <2 x i64> [[TMP7]], i32 1
; AVX512-NEXT:    [[OP_RDX1:%.*]] = or i64 [[TMP9]], [[TMP10]]
; AVX512-NEXT:    [[OP_RDX2:%.*]] = or i64 [[OP_RDX]], [[OP_RDX1]]
; AVX512-NEXT:    [[OP_RDX3:%.*]] = or i64 [[OP_RDX2]], [[OR]]
; AVX512-NEXT:    ret i64 [[OP_RDX3]]
;
entry:
  %0 = load i64, ptr %src, align 8
  %tobool.not = icmp ne i64 %0, 0
  %or = zext i1 %tobool.not to i64
  %arrayidx.1 = getelementptr inbounds i64, ptr %src, i64 1
  %1 = load i64, ptr %arrayidx.1, align 8
  %tobool.not.1 = icmp eq i64 %1, 0
  %or.1 = select i1 %tobool.not.1, i64 0, i64 2
  %mask.1.1 = or i64 %or.1, %or
  %arrayidx.2 = getelementptr inbounds i64, ptr %src, i64 2
  %2 = load i64, ptr %arrayidx.2, align 8
  %tobool.not.2 = icmp eq i64 %2, 0
  %or.2 = select i1 %tobool.not.2, i64 0, i64 4
  %mask.1.2 = or i64 %or.2, %mask.1.1
  %arrayidx.3 = getelementptr inbounds i64, ptr %src, i64 3
  %3 = load i64, ptr %arrayidx.3, align 8
  %tobool.not.3 = icmp eq i64 %3, 0
  %or.3 = select i1 %tobool.not.3, i64 0, i64 8
  %mask.1.3 = or i64 %or.3, %mask.1.2
  %arrayidx.4 = getelementptr inbounds i64, ptr %src, i64 4
  %4 = load i64, ptr %arrayidx.4, align 8
  %tobool.not.4 = icmp eq i64 %4, 0
  %or.4 = select i1 %tobool.not.4, i64 0, i64 16
  %mask.1.4 = or i64 %or.4, %mask.1.3
  %arrayidx.5 = getelementptr inbounds i64, ptr %src, i64 5
  %5 = load i64, ptr %arrayidx.5, align 8
  %tobool.not.5 = icmp eq i64 %5, 0
  %or.5 = select i1 %tobool.not.5, i64 0, i64 32
  %mask.1.5 = or i64 %or.5, %mask.1.4
  %arrayidx.6 = getelementptr inbounds i64, ptr %src, i64 6
  %6 = load i64, ptr %arrayidx.6, align 8
  %tobool.not.6 = icmp eq i64 %6, 0
  %or.6 = select i1 %tobool.not.6, i64 0, i64 64
  %mask.1.6 = or i64 %or.6, %mask.1.5
  %arrayidx.7 = getelementptr inbounds i64, ptr %src, i64 7
  %7 = load i64, ptr %arrayidx.7, align 8
  %tobool.not.7 = icmp eq i64 %7, 0
  %or.7 = select i1 %tobool.not.7, i64 0, i64 128
  %mask.1.7 = or i64 %or.7, %mask.1.6
  ret i64 %mask.1.7
}
