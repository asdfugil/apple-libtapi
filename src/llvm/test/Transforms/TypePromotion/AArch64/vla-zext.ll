; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=aarch64 -type-promotion -verify -S %s -o - | FileCheck %s

define dso_local void @foo(ptr nocapture noundef readonly %a, ptr nocapture noundef readonly %b, ptr nocapture noundef writeonly %c, i64 noundef %n) local_unnamed_addr {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i8, ptr [[B:%.*]], i64 0
; CHECK-NEXT:    [[TMP1:%.*]] = load <vscale x 4 x i8>, ptr [[TMP0]], align 1
; CHECK-NEXT:    [[TMP2:%.*]] = tail call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP3:%.*]] = shl nuw nsw i64 [[TMP2]], 3
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[B_VECTOR:%.*]] = phi <vscale x 4 x i8> [ [[TMP1]], [[ENTRY]] ], [ [[B_VECTOR_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    [[TMP5:%.*]] = load <vscale x 4 x i32>, ptr [[TMP4]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = zext <vscale x 4 x i8> [[B_VECTOR]] to <vscale x 4 x i32>
; CHECK-NEXT:    [[TMP7:%.*]] = add <vscale x 4 x i32> [[TMP5]], [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i32, ptr [[C:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    store <vscale x 4 x i32> [[TMP7]], ptr [[TMP8]], align 4
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i8, ptr [[B]], i64 [[INDEX]]
; CHECK-NEXT:    [[B_VECTOR_NEXT]] = load <vscale x 4 x i8>, ptr [[TMP9]], align 1
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP3]]
; CHECK-NEXT:    [[TMP10:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[TMP10]], label [[END:%.*]], label [[VECTOR_BODY]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  %0 = getelementptr inbounds i8, ptr %b, i64 0
  %1 = load <vscale x 4 x i8>, ptr %0, align 1
  %2 = tail call i64 @llvm.vscale.i64()
  %3 = shl nuw nsw i64 %2, 3
  br label %vector.body

vector.body:                                              ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %b_vector = phi <vscale x 4 x i8> [ %1, %entry ], [ %b_vector.next, %vector.body ]
  %4 = getelementptr inbounds i32, ptr %a, i64 %index
  %5 = load <vscale x 4 x i32>, ptr %4, align 4
  %6 = zext <vscale x 4 x i8> %b_vector to <vscale x 4 x i32>
  %7 = add <vscale x 4 x i32> %5, %6
  %8 = getelementptr inbounds i32, ptr %c, i64 %index
  store <vscale x 4 x i32> %7, ptr %8, align 4
  %9 = getelementptr inbounds i8, ptr %b, i64 %index
  %b_vector.next = load <vscale x 4 x i8>, ptr %9, align 1
  %index.next = add nuw i64 %index, %3
  %10 = icmp eq i64 %index.next, %n
  br i1 %10, label %end, label %vector.body

end:                                                      ; preds = %vector.body
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind readnone willreturn
declare i64 @llvm.vscale.i64()
