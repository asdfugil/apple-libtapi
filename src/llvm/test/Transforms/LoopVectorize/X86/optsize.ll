; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; This test verifies that the loop vectorizer will NOT vectorize loops that
; will produce a tail loop with the optimize for size or the minimize size
; attributes. This is a target-dependent version of the test.
; RUN: opt < %s -loop-vectorize -force-vector-width=64 -S -mtriple=x86_64-unknown-linux -mcpu=skx | FileCheck %s
; RUN: opt < %s -loop-vectorize -S -mtriple=x86_64-unknown-linux -mcpu=skx | FileCheck %s --check-prefix AUTOVF

target datalayout = "E-m:e-p:32:32-i64:32-f64:32:64-a:0:32-n32-S128"

@tab = common global [32 x i8] zeroinitializer, align 1

define i32 @foo_optsize() #0 {
; CHECK-LABEL: @foo_optsize(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <64 x i32> poison, i32 [[INDEX]], i32 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <64 x i32> [[BROADCAST_SPLATINSERT]], <64 x i32> poison, <64 x i32> zeroinitializer
; CHECK-NEXT:    [[VEC_IV:%.*]] = add <64 x i32> [[BROADCAST_SPLAT]], <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ule <64 x i32> [[VEC_IV]], <i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202>
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [32 x i8], [32 x i8]* @tab, i32 0, i32 [[TMP0]]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, i8* [[TMP2]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast i8* [[TMP3]] to <64 x i8>*
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <64 x i8> @llvm.masked.load.v64i8.p0v64i8(<64 x i8>* [[TMP4]], i32 1, <64 x i1> [[TMP1]], <64 x i8> poison)
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq <64 x i8> [[WIDE_MASKED_LOAD]], zeroinitializer
; CHECK-NEXT:    [[TMP6:%.*]] = select <64 x i1> [[TMP5]], <64 x i8> <i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2>, <64 x i8> <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast i8* [[TMP3]] to <64 x i8>*
; CHECK-NEXT:    call void @llvm.masked.store.v64i8.p0v64i8(<64 x i8> [[TMP6]], <64 x i8>* [[TMP7]], i32 1, <64 x i1> [[TMP1]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 64
; CHECK-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[INDEX_NEXT]], 256
; CHECK-NEXT:    br i1 [[TMP8]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[FOR_END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 256, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_08:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [32 x i8], [32 x i8]* @tab, i32 0, i32 [[I_08]]
; CHECK-NEXT:    [[TMP9:%.*]] = load i8, i8* [[ARRAYIDX]], align 1
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i8 [[TMP9]], 0
; CHECK-NEXT:    [[DOT:%.*]] = select i1 [[CMP1]], i8 2, i8 1
; CHECK-NEXT:    store i8 [[DOT]], i8* [[ARRAYIDX]], align 1
; CHECK-NEXT:    [[INC]] = add nsw i32 [[I_08]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[I_08]], 202
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    ret i32 0
;
; AUTOVF-LABEL: @foo_optsize(
; AUTOVF-NEXT:  entry:
; AUTOVF-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; AUTOVF:       vector.ph:
; AUTOVF-NEXT:    br label [[VECTOR_BODY:%.*]]
; AUTOVF:       vector.body:
; AUTOVF-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; AUTOVF-NEXT:    [[TMP0:%.*]] = add i32 [[INDEX]], 0
; AUTOVF-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <32 x i32> poison, i32 [[INDEX]], i32 0
; AUTOVF-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <32 x i32> [[BROADCAST_SPLATINSERT]], <32 x i32> poison, <32 x i32> zeroinitializer
; AUTOVF-NEXT:    [[VEC_IV:%.*]] = add <32 x i32> [[BROADCAST_SPLAT]], <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
; AUTOVF-NEXT:    [[TMP1:%.*]] = icmp ule <32 x i32> [[VEC_IV]], <i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202>
; AUTOVF-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [32 x i8], [32 x i8]* @tab, i32 0, i32 [[TMP0]]
; AUTOVF-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, i8* [[TMP2]], i32 0
; AUTOVF-NEXT:    [[TMP4:%.*]] = bitcast i8* [[TMP3]] to <32 x i8>*
; AUTOVF-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <32 x i8> @llvm.masked.load.v32i8.p0v32i8(<32 x i8>* [[TMP4]], i32 1, <32 x i1> [[TMP1]], <32 x i8> poison)
; AUTOVF-NEXT:    [[TMP5:%.*]] = icmp eq <32 x i8> [[WIDE_MASKED_LOAD]], zeroinitializer
; AUTOVF-NEXT:    [[TMP6:%.*]] = select <32 x i1> [[TMP5]], <32 x i8> <i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2>, <32 x i8> <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
; AUTOVF-NEXT:    [[TMP7:%.*]] = bitcast i8* [[TMP3]] to <32 x i8>*
; AUTOVF-NEXT:    call void @llvm.masked.store.v32i8.p0v32i8(<32 x i8> [[TMP6]], <32 x i8>* [[TMP7]], i32 1, <32 x i1> [[TMP1]])
; AUTOVF-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 32
; AUTOVF-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[INDEX_NEXT]], 224
; AUTOVF-NEXT:    br i1 [[TMP8]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; AUTOVF:       middle.block:
; AUTOVF-NEXT:    br i1 true, label [[FOR_END:%.*]], label [[SCALAR_PH]]
; AUTOVF:       scalar.ph:
; AUTOVF-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 224, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; AUTOVF-NEXT:    br label [[FOR_BODY:%.*]]
; AUTOVF:       for.body:
; AUTOVF-NEXT:    [[I_08:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; AUTOVF-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [32 x i8], [32 x i8]* @tab, i32 0, i32 [[I_08]]
; AUTOVF-NEXT:    [[TMP9:%.*]] = load i8, i8* [[ARRAYIDX]], align 1
; AUTOVF-NEXT:    [[CMP1:%.*]] = icmp eq i8 [[TMP9]], 0
; AUTOVF-NEXT:    [[DOT:%.*]] = select i1 [[CMP1]], i8 2, i8 1
; AUTOVF-NEXT:    store i8 [[DOT]], i8* [[ARRAYIDX]], align 1
; AUTOVF-NEXT:    [[INC]] = add nsw i32 [[I_08]], 1
; AUTOVF-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[I_08]], 202
; AUTOVF-NEXT:    br i1 [[EXITCOND]], label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP2:![0-9]+]]
; AUTOVF:       for.end:
; AUTOVF-NEXT:    ret i32 0
;

entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %i.08 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds [32 x i8], [32 x i8]* @tab, i32 0, i32 %i.08
  %0 = load i8, i8* %arrayidx, align 1
  %cmp1 = icmp eq i8 %0, 0
  %. = select i1 %cmp1, i8 2, i8 1
  store i8 %., i8* %arrayidx, align 1
  %inc = add nsw i32 %i.08, 1
  %exitcond = icmp eq i32 %i.08, 202
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret i32 0
}

attributes #0 = { optsize }

define i32 @foo_minsize() #1 {
; CHECK-LABEL: @foo_minsize(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <64 x i32> poison, i32 [[INDEX]], i32 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <64 x i32> [[BROADCAST_SPLATINSERT]], <64 x i32> poison, <64 x i32> zeroinitializer
; CHECK-NEXT:    [[VEC_IV:%.*]] = add <64 x i32> [[BROADCAST_SPLAT]], <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ule <64 x i32> [[VEC_IV]], <i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202>
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [32 x i8], [32 x i8]* @tab, i32 0, i32 [[TMP0]]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, i8* [[TMP2]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast i8* [[TMP3]] to <64 x i8>*
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <64 x i8> @llvm.masked.load.v64i8.p0v64i8(<64 x i8>* [[TMP4]], i32 1, <64 x i1> [[TMP1]], <64 x i8> poison)
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq <64 x i8> [[WIDE_MASKED_LOAD]], zeroinitializer
; CHECK-NEXT:    [[TMP6:%.*]] = select <64 x i1> [[TMP5]], <64 x i8> <i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2>, <64 x i8> <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast i8* [[TMP3]] to <64 x i8>*
; CHECK-NEXT:    call void @llvm.masked.store.v64i8.p0v64i8(<64 x i8> [[TMP6]], <64 x i8>* [[TMP7]], i32 1, <64 x i1> [[TMP1]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 64
; CHECK-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[INDEX_NEXT]], 256
; CHECK-NEXT:    br i1 [[TMP8]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[FOR_END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 256, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_08:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [32 x i8], [32 x i8]* @tab, i32 0, i32 [[I_08]]
; CHECK-NEXT:    [[TMP9:%.*]] = load i8, i8* [[ARRAYIDX]], align 1
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i8 [[TMP9]], 0
; CHECK-NEXT:    [[DOT:%.*]] = select i1 [[CMP1]], i8 2, i8 1
; CHECK-NEXT:    store i8 [[DOT]], i8* [[ARRAYIDX]], align 1
; CHECK-NEXT:    [[INC]] = add nsw i32 [[I_08]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[I_08]], 202
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    ret i32 0
;
; AUTOVF-LABEL: @foo_minsize(
; AUTOVF-NEXT:  entry:
; AUTOVF-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; AUTOVF:       vector.ph:
; AUTOVF-NEXT:    br label [[VECTOR_BODY:%.*]]
; AUTOVF:       vector.body:
; AUTOVF-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; AUTOVF-NEXT:    [[TMP0:%.*]] = add i32 [[INDEX]], 0
; AUTOVF-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <32 x i32> poison, i32 [[INDEX]], i32 0
; AUTOVF-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <32 x i32> [[BROADCAST_SPLATINSERT]], <32 x i32> poison, <32 x i32> zeroinitializer
; AUTOVF-NEXT:    [[VEC_IV:%.*]] = add <32 x i32> [[BROADCAST_SPLAT]], <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
; AUTOVF-NEXT:    [[TMP1:%.*]] = icmp ule <32 x i32> [[VEC_IV]], <i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202, i32 202>
; AUTOVF-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [32 x i8], [32 x i8]* @tab, i32 0, i32 [[TMP0]]
; AUTOVF-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, i8* [[TMP2]], i32 0
; AUTOVF-NEXT:    [[TMP4:%.*]] = bitcast i8* [[TMP3]] to <32 x i8>*
; AUTOVF-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <32 x i8> @llvm.masked.load.v32i8.p0v32i8(<32 x i8>* [[TMP4]], i32 1, <32 x i1> [[TMP1]], <32 x i8> poison)
; AUTOVF-NEXT:    [[TMP5:%.*]] = icmp eq <32 x i8> [[WIDE_MASKED_LOAD]], zeroinitializer
; AUTOVF-NEXT:    [[TMP6:%.*]] = select <32 x i1> [[TMP5]], <32 x i8> <i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2>, <32 x i8> <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
; AUTOVF-NEXT:    [[TMP7:%.*]] = bitcast i8* [[TMP3]] to <32 x i8>*
; AUTOVF-NEXT:    call void @llvm.masked.store.v32i8.p0v32i8(<32 x i8> [[TMP6]], <32 x i8>* [[TMP7]], i32 1, <32 x i1> [[TMP1]])
; AUTOVF-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 32
; AUTOVF-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[INDEX_NEXT]], 224
; AUTOVF-NEXT:    br i1 [[TMP8]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; AUTOVF:       middle.block:
; AUTOVF-NEXT:    br i1 true, label [[FOR_END:%.*]], label [[SCALAR_PH]]
; AUTOVF:       scalar.ph:
; AUTOVF-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 224, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; AUTOVF-NEXT:    br label [[FOR_BODY:%.*]]
; AUTOVF:       for.body:
; AUTOVF-NEXT:    [[I_08:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; AUTOVF-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [32 x i8], [32 x i8]* @tab, i32 0, i32 [[I_08]]
; AUTOVF-NEXT:    [[TMP9:%.*]] = load i8, i8* [[ARRAYIDX]], align 1
; AUTOVF-NEXT:    [[CMP1:%.*]] = icmp eq i8 [[TMP9]], 0
; AUTOVF-NEXT:    [[DOT:%.*]] = select i1 [[CMP1]], i8 2, i8 1
; AUTOVF-NEXT:    store i8 [[DOT]], i8* [[ARRAYIDX]], align 1
; AUTOVF-NEXT:    [[INC]] = add nsw i32 [[I_08]], 1
; AUTOVF-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[I_08]], 202
; AUTOVF-NEXT:    br i1 [[EXITCOND]], label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
; AUTOVF:       for.end:
; AUTOVF-NEXT:    ret i32 0
;

entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %i.08 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds [32 x i8], [32 x i8]* @tab, i32 0, i32 %i.08
  %0 = load i8, i8* %arrayidx, align 1
  %cmp1 = icmp eq i8 %0, 0
  %. = select i1 %cmp1, i8 2, i8 1
  store i8 %., i8* %arrayidx, align 1
  %inc = add nsw i32 %i.08, 1
  %exitcond = icmp eq i32 %i.08, 202
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret i32 0
}

attributes #1 = { minsize }


; We can vectorize this one by refraining from versioning for stride==1.
define void @scev4stride1(i32* noalias nocapture %a, i32* noalias nocapture readonly %b, i32 %k) #2 {
; CHECK-LABEL: @scev4stride1(
; CHECK-NEXT:  for.body.preheader:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <64 x i32> poison, i32 [[K:%.*]], i32 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <64 x i32> [[BROADCAST_SPLATINSERT]], <64 x i32> poison, <64 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <64 x i32> [ <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = mul nsw <64 x i32> [[VEC_IND]], [[BROADCAST_SPLAT]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i32, i32* [[B:%.*]], <64 x i32> [[TMP1]]
; CHECK-NEXT:    [[WIDE_MASKED_GATHER:%.*]] = call <64 x i32> @llvm.masked.gather.v64i32.v64p0i32(<64 x i32*> [[TMP2]], i32 4, <64 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <64 x i32> poison)
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i32 [[TMP0]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i32, i32* [[TMP3]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast i32* [[TMP4]] to <64 x i32>*
; CHECK-NEXT:    store <64 x i32> [[WIDE_MASKED_GATHER]], <64 x i32>* [[TMP5]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 64
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <64 x i32> [[VEC_IND]], <i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64>
; CHECK-NEXT:    [[TMP6:%.*]] = icmp eq i32 [[INDEX_NEXT]], 256
; CHECK-NEXT:    br i1 [[TMP6]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 256, 256
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_END_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 256, [[MIDDLE_BLOCK]] ], [ 0, [[FOR_BODY_PREHEADER:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_07:%.*]] = phi i32 [ [[INC:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[MUL:%.*]] = mul nsw i32 [[I_07]], [[K]]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, i32* [[B]], i32 [[MUL]]
; CHECK-NEXT:    [[TMP7:%.*]] = load i32, i32* [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 [[I_07]]
; CHECK-NEXT:    store i32 [[TMP7]], i32* [[ARRAYIDX1]], align 4
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_07]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INC]], 256
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END_LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP7:![0-9]+]]
; CHECK:       for.end.loopexit:
; CHECK-NEXT:    ret void
;
; AUTOVF-LABEL: @scev4stride1(
; AUTOVF-NEXT:  for.body.preheader:
; AUTOVF-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; AUTOVF:       vector.ph:
; AUTOVF-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <8 x i32> poison, i32 [[K:%.*]], i32 0
; AUTOVF-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <8 x i32> [[BROADCAST_SPLATINSERT]], <8 x i32> poison, <8 x i32> zeroinitializer
; AUTOVF-NEXT:    br label [[VECTOR_BODY:%.*]]
; AUTOVF:       vector.body:
; AUTOVF-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; AUTOVF-NEXT:    [[VEC_IND:%.*]] = phi <8 x i32> [ <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; AUTOVF-NEXT:    [[TMP0:%.*]] = add i32 [[INDEX]], 0
; AUTOVF-NEXT:    [[TMP1:%.*]] = mul nsw <8 x i32> [[VEC_IND]], [[BROADCAST_SPLAT]]
; AUTOVF-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i32, i32* [[B:%.*]], <8 x i32> [[TMP1]]
; AUTOVF-NEXT:    [[WIDE_MASKED_GATHER:%.*]] = call <8 x i32> @llvm.masked.gather.v8i32.v8p0i32(<8 x i32*> [[TMP2]], i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i32> poison)
; AUTOVF-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i32 [[TMP0]]
; AUTOVF-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i32, i32* [[TMP3]], i32 0
; AUTOVF-NEXT:    [[TMP5:%.*]] = bitcast i32* [[TMP4]] to <8 x i32>*
; AUTOVF-NEXT:    store <8 x i32> [[WIDE_MASKED_GATHER]], <8 x i32>* [[TMP5]], align 4
; AUTOVF-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 8
; AUTOVF-NEXT:    [[VEC_IND_NEXT]] = add <8 x i32> [[VEC_IND]], <i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8>
; AUTOVF-NEXT:    [[TMP6:%.*]] = icmp eq i32 [[INDEX_NEXT]], 256
; AUTOVF-NEXT:    br i1 [[TMP6]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; AUTOVF:       middle.block:
; AUTOVF-NEXT:    [[CMP_N:%.*]] = icmp eq i32 256, 256
; AUTOVF-NEXT:    br i1 [[CMP_N]], label [[FOR_END_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; AUTOVF:       scalar.ph:
; AUTOVF-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 256, [[MIDDLE_BLOCK]] ], [ 0, [[FOR_BODY_PREHEADER:%.*]] ]
; AUTOVF-NEXT:    br label [[FOR_BODY:%.*]]
; AUTOVF:       for.body:
; AUTOVF-NEXT:    [[I_07:%.*]] = phi i32 [ [[INC:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; AUTOVF-NEXT:    [[MUL:%.*]] = mul nsw i32 [[I_07]], [[K]]
; AUTOVF-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, i32* [[B]], i32 [[MUL]]
; AUTOVF-NEXT:    [[TMP7:%.*]] = load i32, i32* [[ARRAYIDX]], align 4
; AUTOVF-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 [[I_07]]
; AUTOVF-NEXT:    store i32 [[TMP7]], i32* [[ARRAYIDX1]], align 4
; AUTOVF-NEXT:    [[INC]] = add nuw nsw i32 [[I_07]], 1
; AUTOVF-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INC]], 256
; AUTOVF-NEXT:    br i1 [[EXITCOND]], label [[FOR_END_LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP7:![0-9]+]]
; AUTOVF:       for.end.loopexit:
; AUTOVF-NEXT:    ret void
;
for.body.preheader:
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.07 = phi i32 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %mul = mul nsw i32 %i.07, %k
  %arrayidx = getelementptr inbounds i32, i32* %b, i32 %mul
  %0 = load i32, i32* %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds i32, i32* %a, i32 %i.07
  store i32 %0, i32* %arrayidx1, align 4
  %inc = add nuw nsw i32 %i.07, 1
  %exitcond = icmp eq i32 %inc, 256
  br i1 %exitcond, label %for.end.loopexit, label %for.body

for.end.loopexit:                                 ; preds = %for.body
  ret void
}

attributes #2 = { optsize }


; PR39497
; We can't vectorize this one because we version for overflow check and tiny
; trip count leads to opt-for-size (which otherwise could fold the tail by
; masking).
define i32 @main() local_unnamed_addr {
; CHECK-LABEL: @main(
; CHECK-NEXT:  while.cond:
; CHECK-NEXT:    br label [[FOR_COND:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[D_0:%.*]] = phi i32 [ 0, [[WHILE_COND:%.*]] ], [ [[ADD:%.*]], [[FOR_COND]] ]
; CHECK-NEXT:    [[CONV:%.*]] = and i32 [[D_0]], 65535
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[CONV]], 4
; CHECK-NEXT:    [[ADD]] = add nuw nsw i32 [[CONV]], 1
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_COND]], label [[WHILE_COND_LOOPEXIT:%.*]]
; CHECK:       while.cond.loopexit:
; CHECK-NEXT:    ret i32 0
;
; AUTOVF-LABEL: @main(
; AUTOVF-NEXT:  while.cond:
; AUTOVF-NEXT:    br label [[FOR_COND:%.*]]
; AUTOVF:       for.cond:
; AUTOVF-NEXT:    [[D_0:%.*]] = phi i32 [ 0, [[WHILE_COND:%.*]] ], [ [[ADD:%.*]], [[FOR_COND]] ]
; AUTOVF-NEXT:    [[CONV:%.*]] = and i32 [[D_0]], 65535
; AUTOVF-NEXT:    [[CMP:%.*]] = icmp ult i32 [[CONV]], 4
; AUTOVF-NEXT:    [[ADD]] = add nuw nsw i32 [[CONV]], 1
; AUTOVF-NEXT:    br i1 [[CMP]], label [[FOR_COND]], label [[WHILE_COND_LOOPEXIT:%.*]]
; AUTOVF:       while.cond.loopexit:
; AUTOVF-NEXT:    ret i32 0
;
while.cond:
  br label %for.cond

for.cond:
  %d.0 = phi i32 [ 0, %while.cond ], [ %add, %for.cond ]
  %conv = and i32 %d.0, 65535
  %cmp = icmp ult i32 %conv, 4
  %add = add nuw nsw i32 %conv, 1
  br i1 %cmp, label %for.cond, label %while.cond.loopexit

while.cond.loopexit:
  ret i32 0
}
