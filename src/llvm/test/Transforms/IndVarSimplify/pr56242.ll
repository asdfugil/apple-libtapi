; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -indvars < %s | FileCheck %s

declare void @use(i1)

define void @test(ptr %arr) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_INC:%.*]], [[LOOP_LATCH:%.*]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[PREV:%.*]] = phi i32 [ [[V:%.*]], [[LOOP_LATCH]] ], [ 0, [[ENTRY]] ]
; CHECK-NEXT:    [[PTR:%.*]] = getelementptr inbounds i32, ptr [[ARR:%.*]], i64 [[IV]]
; CHECK-NEXT:    [[V]] = load i32, ptr [[PTR]], align 4
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sgt i32 [[V]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[IF:%.*]], label [[LOOP_LATCH]]
; CHECK:       if:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp slt i32 [[PREV]], 0
; CHECK-NEXT:    call void @use(i1 [[CMP2]])
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[IV_INC]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[IV_INC]], 16
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i64 [ %iv.inc, %loop.latch ], [ 0, %entry ]
  %prev = phi i32 [ %v, %loop.latch ], [ 0, %entry ]
  %ptr = getelementptr inbounds i32, ptr %arr, i64 %iv
  %v = load i32, ptr %ptr
  %cmp1 = icmp sgt i32 %v, 0
  br i1 %cmp1, label %if, label %loop.latch

if:
  %cmp2 = icmp slt i32 %prev, 0
  call void @use(i1 %cmp2)
  br label %loop.latch

loop.latch:
  %iv.inc = add nuw nsw i64 %iv, 1
  %cmp = icmp ult i64 %iv.inc, 16
  br i1 %cmp, label %loop.header, label %exit

exit:
  ret void
}
