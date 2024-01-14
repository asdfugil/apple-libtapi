; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -loop-idiom < %s -S | FileCheck %s

define void @copy_both_noalias(float* noalias nocapture %d, float* noalias nocapture readonly %s, i64 %sz) {
; CHECK-LABEL: @copy_both_noalias(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[D1:%.*]] = bitcast float* [[D:%.*]] to i8*
; CHECK-NEXT:    [[S2:%.*]] = bitcast float* [[S:%.*]] to i8*
; CHECK-NEXT:    [[EXITCOND_NOT1:%.*]] = icmp eq i64 [[SZ:%.*]], 0
; CHECK-NEXT:    br i1 [[EXITCOND_NOT1]], label [[FOR_END:%.*]], label [[FOR_BODY_PREHEADER:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = shl nuw i64 [[SZ]], 2
; CHECK-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 [[D1]], i8* align 4 [[S2]], i64 [[TMP0]], i1 false)
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_04:%.*]] = phi i64 [ [[INC:%.*]], [[FOR_BODY]] ], [ 0, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[D_ADDR_03:%.*]] = phi float* [ [[INCDEC_PTR1:%.*]], [[FOR_BODY]] ], [ [[D]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[S_ADDR_02:%.*]] = phi float* [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[S]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds float, float* [[S_ADDR_02]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[S_ADDR_02]], align 4
; CHECK-NEXT:    [[INCDEC_PTR1]] = getelementptr inbounds float, float* [[D_ADDR_03]], i64 1
; CHECK-NEXT:    [[INC]] = add i64 [[I_04]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INC]], [[SZ]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END_LOOPEXIT:%.*]], label [[FOR_BODY]]
; CHECK:       for.end.loopexit:
; CHECK-NEXT:    br label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %exitcond.not1 = icmp eq i64 %sz, 0
  br i1 %exitcond.not1, label %for.end, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.04 = phi i64 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %d.addr.03 = phi float* [ %incdec.ptr1, %for.body ], [ %d, %for.body.preheader ]
  %s.addr.02 = phi float* [ %incdec.ptr, %for.body ], [ %s, %for.body.preheader ]
  %incdec.ptr = getelementptr inbounds float, float* %s.addr.02, i64 1
  %0 = load float, float* %s.addr.02, align 4
  %incdec.ptr1 = getelementptr inbounds float, float* %d.addr.03, i64 1
  store float %0, float* %d.addr.03, align 4
  %inc = add i64 %i.04, 1
  %exitcond.not = icmp eq i64 %inc, %sz
  br i1 %exitcond.not, label %for.end.loopexit, label %for.body

for.end.loopexit:                                 ; preds = %for.body
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  ret void
}

define void @copy_one_noalias(float* nocapture %d, float* noalias nocapture readonly %s, i64 %sz) {
; CHECK-LABEL: @copy_one_noalias(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[D1:%.*]] = bitcast float* [[D:%.*]] to i8*
; CHECK-NEXT:    [[S2:%.*]] = bitcast float* [[S:%.*]] to i8*
; CHECK-NEXT:    [[EXITCOND_NOT1:%.*]] = icmp eq i64 [[SZ:%.*]], 0
; CHECK-NEXT:    br i1 [[EXITCOND_NOT1]], label [[FOR_END:%.*]], label [[FOR_BODY_PREHEADER:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = shl nuw i64 [[SZ]], 2
; CHECK-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 [[D1]], i8* align 4 [[S2]], i64 [[TMP0]], i1 false)
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_04:%.*]] = phi i64 [ [[INC:%.*]], [[FOR_BODY]] ], [ 0, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[D_ADDR_03:%.*]] = phi float* [ [[INCDEC_PTR1:%.*]], [[FOR_BODY]] ], [ [[D]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[S_ADDR_02:%.*]] = phi float* [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[S]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds float, float* [[S_ADDR_02]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[S_ADDR_02]], align 4
; CHECK-NEXT:    [[INCDEC_PTR1]] = getelementptr inbounds float, float* [[D_ADDR_03]], i64 1
; CHECK-NEXT:    [[INC]] = add i64 [[I_04]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INC]], [[SZ]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_END_LOOPEXIT:%.*]], label [[FOR_BODY]]
; CHECK:       for.end.loopexit:
; CHECK-NEXT:    br label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %exitcond.not1 = icmp eq i64 %sz, 0
  br i1 %exitcond.not1, label %for.end, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.04 = phi i64 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %d.addr.03 = phi float* [ %incdec.ptr1, %for.body ], [ %d, %for.body.preheader ]
  %s.addr.02 = phi float* [ %incdec.ptr, %for.body ], [ %s, %for.body.preheader ]
  %incdec.ptr = getelementptr inbounds float, float* %s.addr.02, i64 1
  %0 = load float, float* %s.addr.02, align 4
  %incdec.ptr1 = getelementptr inbounds float, float* %d.addr.03, i64 1
  store float %0, float* %d.addr.03, align 4
  %inc = add i64 %i.04, 1
  %exitcond.not = icmp eq i64 %inc, %sz
  br i1 %exitcond.not, label %for.end.loopexit, label %for.body

for.end.loopexit:                                 ; preds = %for.body
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  ret void
}

; PR44378
define dso_local void @memcpy_loop(i8* noalias nocapture %p, i8* noalias nocapture readonly %q, i32 %n) {
; CHECK-LABEL: @memcpy_loop(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP4:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP4]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 [[P:%.*]], i8* align 1 [[Q:%.*]], i64 [[TMP0]], i1 false)
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
; CHECK:       for.body:
; CHECK-NEXT:    [[I_07:%.*]] = phi i32 [ [[INC:%.*]], [[FOR_BODY]] ], [ 0, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[P_ADDR_06:%.*]] = phi i8* [ [[INCDEC_PTR1:%.*]], [[FOR_BODY]] ], [ [[P]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[Q_ADDR_05:%.*]] = phi i8* [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[Q]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds i8, i8* [[Q_ADDR_05]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = load i8, i8* [[Q_ADDR_05]], align 1
; CHECK-NEXT:    [[INCDEC_PTR1]] = getelementptr inbounds i8, i8* [[P_ADDR_06]], i64 1
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_07]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i32 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_COND_CLEANUP_LOOPEXIT:%.*]], label [[FOR_BODY]]
;
entry:
  %cmp4 = icmp sgt i32 %n, 0
  br i1 %cmp4, label %for.body, label %for.cond.cleanup

for.cond.cleanup:
  ret void

for.body:
  %i.07 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %p.addr.06 = phi i8* [ %incdec.ptr1, %for.body ], [ %p, %entry ]
  %q.addr.05 = phi i8* [ %incdec.ptr, %for.body ], [ %q, %entry ]
  %incdec.ptr = getelementptr inbounds i8, i8* %q.addr.05, i64 1
  %0 = load i8, i8* %q.addr.05, align 1
  %incdec.ptr1 = getelementptr inbounds i8, i8* %p.addr.06, i64 1
  store i8 %0, i8* %p.addr.06, align 1
  %inc = add nuw nsw i32 %i.07, 1
  %exitcond.not = icmp eq i32 %inc, %n
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}
