; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -loop-predication < %s 2>&1 | FileCheck %s
; RUN: opt -S -aa-pipeline=basic-aa -passes='require<aa>,require<scalar-evolution>,loop-mssa(loop-predication)' -verify-memoryssa < %s 2>&1 | FileCheck %s

declare void @llvm.experimental.guard(i1, ...)

@UNKNOWN = external global i1

define i32 @neg_length_variant(i32* %array, i32* %length, i32 %n) {
; CHECK-LABEL: @neg_length_variant(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[TMP5]], label [[EXIT:%.*]], label [[LOOP_PREHEADER:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[LOOP_ACC:%.*]] = phi i32 [ [[LOOP_ACC_NEXT:%.*]], [[LOOP]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[I:%.*]] = phi i32 [ [[I_NEXT:%.*]], [[LOOP]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[UNKNOWN:%.*]] = load volatile i1, i1* @UNKNOWN, align 1
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[UNKNOWN]]) [ "deopt"() ]
; CHECK-NEXT:    [[LEN:%.*]] = load i32, i32* [[LENGTH:%.*]], align 4
; CHECK-NEXT:    [[WITHIN_BOUNDS:%.*]] = icmp ult i32 [[I]], [[LEN]]
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[WITHIN_BOUNDS]], i32 9) [ "deopt"() ]
; CHECK-NEXT:    [[I_I64:%.*]] = zext i32 [[I]] to i64
; CHECK-NEXT:    [[ARRAY_I_PTR:%.*]] = getelementptr inbounds i32, i32* [[ARRAY:%.*]], i64 [[I_I64]]
; CHECK-NEXT:    [[ARRAY_I:%.*]] = load i32, i32* [[ARRAY_I_PTR]], align 4
; CHECK-NEXT:    [[LOOP_ACC_NEXT]] = add i32 [[LOOP_ACC]], [[ARRAY_I]]
; CHECK-NEXT:    [[I_NEXT]] = add nuw i32 [[I]], 1
; CHECK-NEXT:    [[CONTINUE:%.*]] = icmp ult i32 [[I_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[CONTINUE]], label [[LOOP]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    [[LOOP_ACC_NEXT_LCSSA:%.*]] = phi i32 [ [[LOOP_ACC_NEXT]], [[LOOP]] ]
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[RESULT:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[LOOP_ACC_NEXT_LCSSA]], [[EXIT_LOOPEXIT]] ]
; CHECK-NEXT:    ret i32 [[RESULT]]
;
entry:
  %tmp5 = icmp eq i32 %n, 0
  br i1 %tmp5, label %exit, label %loop.preheader

loop.preheader:
  br label %loop

loop:
  %loop.acc = phi i32 [ %loop.acc.next, %loop ], [ 0, %loop.preheader ]
  %i = phi i32 [ %i.next, %loop ], [ 0, %loop.preheader ]
  %unknown = load volatile i1, i1* @UNKNOWN
  call void (i1, ...) @llvm.experimental.guard(i1 %unknown) [ "deopt"() ]
  %len = load i32, i32* %length, align 4
  %within.bounds = icmp ult i32 %i, %len
  call void (i1, ...) @llvm.experimental.guard(i1 %within.bounds, i32 9) [ "deopt"() ]

  %i.i64 = zext i32 %i to i64
  %array.i.ptr = getelementptr inbounds i32, i32* %array, i64 %i.i64
  %array.i = load i32, i32* %array.i.ptr, align 4
  %loop.acc.next = add i32 %loop.acc, %array.i

  %i.next = add nuw i32 %i, 1
  %continue = icmp ult i32 %i.next, %n
  br i1 %continue, label %loop, label %exit

exit:
  %result = phi i32 [ 0, %entry ], [ %loop.acc.next, %loop ]
  ret i32 %result
}

define i32 @invariant_load_guard_limit(i32* %array, i32* %length, i32 %n) {
; CHECK-LABEL: @invariant_load_guard_limit(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[TMP5]], label [[EXIT:%.*]], label [[LOOP_PREHEADER:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[LOOP_ACC:%.*]] = phi i32 [ [[LOOP_ACC_NEXT:%.*]], [[LOOP]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[I:%.*]] = phi i32 [ [[I_NEXT:%.*]], [[LOOP]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[UNKNOWN:%.*]] = load volatile i1, i1* @UNKNOWN, align 1
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[UNKNOWN]]) [ "deopt"() ]
; CHECK-NEXT:    [[LEN:%.*]] = load i32, i32* [[LENGTH:%.*]], align 4, !invariant.load !0
; CHECK-NEXT:    [[WITHIN_BOUNDS:%.*]] = icmp ult i32 [[I]], [[LEN]]
; CHECK-NEXT:    [[TMP0:%.*]] = icmp ule i32 [[N]], [[LEN]]
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult i32 0, [[LEN]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i1 [[TMP1]], [[TMP0]]
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[TMP2]], i32 9) [ "deopt"() ]
; CHECK-NEXT:    call void @llvm.assume(i1 [[WITHIN_BOUNDS]])
; CHECK-NEXT:    [[I_I64:%.*]] = zext i32 [[I]] to i64
; CHECK-NEXT:    [[ARRAY_I_PTR:%.*]] = getelementptr inbounds i32, i32* [[ARRAY:%.*]], i64 [[I_I64]]
; CHECK-NEXT:    [[ARRAY_I:%.*]] = load i32, i32* [[ARRAY_I_PTR]], align 4
; CHECK-NEXT:    [[LOOP_ACC_NEXT]] = add i32 [[LOOP_ACC]], [[ARRAY_I]]
; CHECK-NEXT:    [[I_NEXT]] = add nuw i32 [[I]], 1
; CHECK-NEXT:    [[CONTINUE:%.*]] = icmp ult i32 [[I_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[CONTINUE]], label [[LOOP]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    [[LOOP_ACC_NEXT_LCSSA:%.*]] = phi i32 [ [[LOOP_ACC_NEXT]], [[LOOP]] ]
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[RESULT:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[LOOP_ACC_NEXT_LCSSA]], [[EXIT_LOOPEXIT]] ]
; CHECK-NEXT:    ret i32 [[RESULT]]
;
entry:
  %tmp5 = icmp eq i32 %n, 0
  br i1 %tmp5, label %exit, label %loop.preheader

loop.preheader:
  br label %loop

loop:
  %loop.acc = phi i32 [ %loop.acc.next, %loop ], [ 0, %loop.preheader ]
  %i = phi i32 [ %i.next, %loop ], [ 0, %loop.preheader ]
  %unknown = load volatile i1, i1* @UNKNOWN
  call void (i1, ...) @llvm.experimental.guard(i1 %unknown) [ "deopt"() ]
  %len = load i32, i32* %length, align 4, !invariant.load !{}
  %within.bounds = icmp ult i32 %i, %len
  call void (i1, ...) @llvm.experimental.guard(i1 %within.bounds, i32 9) [ "deopt"() ]

  %i.i64 = zext i32 %i to i64
  %array.i.ptr = getelementptr inbounds i32, i32* %array, i64 %i.i64
  %array.i = load i32, i32* %array.i.ptr, align 4
  %loop.acc.next = add i32 %loop.acc, %array.i

  %i.next = add nuw i32 %i, 1
  %continue = icmp ult i32 %i.next, %n
  br i1 %continue, label %loop, label %exit

exit:
  %result = phi i32 [ 0, %entry ], [ %loop.acc.next, %loop ]
  ret i32 %result
}

; Case where we have an invariant load, but it's not loading from a loop
; invariant location.
define i32 @neg_varying_invariant_load_op(i32* %array, i32* %lengths, i32 %n) {
; CHECK-LABEL: @neg_varying_invariant_load_op(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[TMP5]], label [[EXIT:%.*]], label [[LOOP_PREHEADER:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[LOOP_ACC:%.*]] = phi i32 [ [[LOOP_ACC_NEXT:%.*]], [[LOOP]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[I:%.*]] = phi i32 [ [[I_NEXT:%.*]], [[LOOP]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[UNKNOWN:%.*]] = load volatile i1, i1* @UNKNOWN, align 1
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[UNKNOWN]]) [ "deopt"() ]
; CHECK-NEXT:    [[LENGTH_ADDR:%.*]] = getelementptr i32, i32* [[LENGTHS:%.*]], i32 [[I]]
; CHECK-NEXT:    [[LEN:%.*]] = load i32, i32* [[LENGTH_ADDR]], align 4, !invariant.load !0
; CHECK-NEXT:    [[WITHIN_BOUNDS:%.*]] = icmp ult i32 [[I]], [[LEN]]
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[WITHIN_BOUNDS]], i32 9) [ "deopt"() ]
; CHECK-NEXT:    [[I_I64:%.*]] = zext i32 [[I]] to i64
; CHECK-NEXT:    [[ARRAY_I_PTR:%.*]] = getelementptr inbounds i32, i32* [[ARRAY:%.*]], i64 [[I_I64]]
; CHECK-NEXT:    [[ARRAY_I:%.*]] = load i32, i32* [[ARRAY_I_PTR]], align 4
; CHECK-NEXT:    [[LOOP_ACC_NEXT]] = add i32 [[LOOP_ACC]], [[ARRAY_I]]
; CHECK-NEXT:    [[I_NEXT]] = add nuw i32 [[I]], 1
; CHECK-NEXT:    [[CONTINUE:%.*]] = icmp ult i32 [[I_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[CONTINUE]], label [[LOOP]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    [[LOOP_ACC_NEXT_LCSSA:%.*]] = phi i32 [ [[LOOP_ACC_NEXT]], [[LOOP]] ]
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[RESULT:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[LOOP_ACC_NEXT_LCSSA]], [[EXIT_LOOPEXIT]] ]
; CHECK-NEXT:    ret i32 [[RESULT]]
;
entry:
  %tmp5 = icmp eq i32 %n, 0
  br i1 %tmp5, label %exit, label %loop.preheader

loop.preheader:
  br label %loop

loop:
  %loop.acc = phi i32 [ %loop.acc.next, %loop ], [ 0, %loop.preheader ]
  %i = phi i32 [ %i.next, %loop ], [ 0, %loop.preheader ]
  %unknown = load volatile i1, i1* @UNKNOWN
  call void (i1, ...) @llvm.experimental.guard(i1 %unknown) [ "deopt"() ]

  %length.addr = getelementptr i32, i32* %lengths, i32 %i
  %len = load i32, i32* %length.addr, align 4, !invariant.load !{}
  %within.bounds = icmp ult i32 %i, %len
  call void (i1, ...) @llvm.experimental.guard(i1 %within.bounds, i32 9) [ "deopt"() ]

  %i.i64 = zext i32 %i to i64
  %array.i.ptr = getelementptr inbounds i32, i32* %array, i64 %i.i64
  %array.i = load i32, i32* %array.i.ptr, align 4
  %loop.acc.next = add i32 %loop.acc, %array.i

  %i.next = add nuw i32 %i, 1
  %continue = icmp ult i32 %i.next, %n
  br i1 %continue, label %loop, label %exit

exit:
  %result = phi i32 [ 0, %entry ], [ %loop.acc.next, %loop ]
  ret i32 %result
}

; This is a case where moving the load which provides the limit for the latch
; would be invalid, so we can't preform the tempting transform.  Loading the
; latch limit may fault since we could always fail the guard.
define i32 @neg_invariant_load_latch_limit(i32* %array, i32* %length, i32 %n) {
; CHECK-LABEL: @neg_invariant_load_latch_limit(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[TMP5]], label [[EXIT:%.*]], label [[LOOP_PREHEADER:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[LOOP_ACC:%.*]] = phi i32 [ [[LOOP_ACC_NEXT:%.*]], [[LOOP]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[I:%.*]] = phi i32 [ [[I_NEXT:%.*]], [[LOOP]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[UNKNOWN:%.*]] = load volatile i1, i1* @UNKNOWN, align 1
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[UNKNOWN]]) [ "deopt"() ]
; CHECK-NEXT:    [[WITHIN_BOUNDS:%.*]] = icmp ult i32 [[I]], [[N]]
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[WITHIN_BOUNDS]], i32 9) [ "deopt"() ]
; CHECK-NEXT:    [[I_I64:%.*]] = zext i32 [[I]] to i64
; CHECK-NEXT:    [[ARRAY_I_PTR:%.*]] = getelementptr inbounds i32, i32* [[ARRAY:%.*]], i64 [[I_I64]]
; CHECK-NEXT:    [[ARRAY_I:%.*]] = load i32, i32* [[ARRAY_I_PTR]], align 4
; CHECK-NEXT:    [[LOOP_ACC_NEXT]] = add i32 [[LOOP_ACC]], [[ARRAY_I]]
; CHECK-NEXT:    [[I_NEXT]] = add nuw i32 [[I]], 1
; CHECK-NEXT:    [[LEN:%.*]] = load i32, i32* [[LENGTH:%.*]], align 4, !invariant.load !0
; CHECK-NEXT:    [[CONTINUE:%.*]] = icmp ult i32 [[I_NEXT]], [[LEN]]
; CHECK-NEXT:    br i1 [[CONTINUE]], label [[LOOP]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    [[LOOP_ACC_NEXT_LCSSA:%.*]] = phi i32 [ [[LOOP_ACC_NEXT]], [[LOOP]] ]
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[RESULT:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[LOOP_ACC_NEXT_LCSSA]], [[EXIT_LOOPEXIT]] ]
; CHECK-NEXT:    ret i32 [[RESULT]]
;
entry:
  %tmp5 = icmp eq i32 %n, 0
  br i1 %tmp5, label %exit, label %loop.preheader

loop.preheader:
  br label %loop

loop:
  %loop.acc = phi i32 [ %loop.acc.next, %loop ], [ 0, %loop.preheader ]
  %i = phi i32 [ %i.next, %loop ], [ 0, %loop.preheader ]
  %unknown = load volatile i1, i1* @UNKNOWN
  call void (i1, ...) @llvm.experimental.guard(i1 %unknown) [ "deopt"() ]
  %within.bounds = icmp ult i32 %i, %n
  call void (i1, ...) @llvm.experimental.guard(i1 %within.bounds, i32 9) [ "deopt"() ]

  %i.i64 = zext i32 %i to i64
  %array.i.ptr = getelementptr inbounds i32, i32* %array, i64 %i.i64
  %array.i = load i32, i32* %array.i.ptr, align 4
  %loop.acc.next = add i32 %loop.acc, %array.i

  %i.next = add nuw i32 %i, 1
  %len = load i32, i32* %length, align 4, !invariant.load !{}
  %continue = icmp ult i32 %i.next, %len
  br i1 %continue, label %loop, label %exit

exit:
  %result = phi i32 [ 0, %entry ], [ %loop.acc.next, %loop ]
  ret i32 %result
}

define i32 @invariant_load_latch_limit(i32* %array,
; CHECK-LABEL: @invariant_load_latch_limit(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[TMP5]], label [[EXIT:%.*]], label [[LOOP_PREHEADER:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[LOOP_ACC:%.*]] = phi i32 [ [[LOOP_ACC_NEXT:%.*]], [[LOOP]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[I:%.*]] = phi i32 [ [[I_NEXT:%.*]], [[LOOP]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[UNKNOWN:%.*]] = load volatile i1, i1* @UNKNOWN, align 1
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[UNKNOWN]]) [ "deopt"() ]
; CHECK-NEXT:    [[WITHIN_BOUNDS:%.*]] = icmp ult i32 [[I]], [[N]]
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[WITHIN_BOUNDS]], i32 9) [ "deopt"() ]
; CHECK-NEXT:    [[I_I64:%.*]] = zext i32 [[I]] to i64
; CHECK-NEXT:    [[ARRAY_I_PTR:%.*]] = getelementptr inbounds i32, i32* [[ARRAY:%.*]], i64 [[I_I64]]
; CHECK-NEXT:    [[ARRAY_I:%.*]] = load i32, i32* [[ARRAY_I_PTR]], align 4
; CHECK-NEXT:    [[LOOP_ACC_NEXT]] = add i32 [[LOOP_ACC]], [[ARRAY_I]]
; CHECK-NEXT:    [[I_NEXT]] = add nuw i32 [[I]], 1
; CHECK-NEXT:    [[LEN:%.*]] = load i32, i32* [[LENGTH:%.*]], align 4, !invariant.load !0
; CHECK-NEXT:    [[CONTINUE:%.*]] = icmp ult i32 [[I_NEXT]], [[LEN]]
; CHECK-NEXT:    br i1 [[CONTINUE]], label [[LOOP]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    [[LOOP_ACC_NEXT_LCSSA:%.*]] = phi i32 [ [[LOOP_ACC_NEXT]], [[LOOP]] ]
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[RESULT:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[LOOP_ACC_NEXT_LCSSA]], [[EXIT_LOOPEXIT]] ]
; CHECK-NEXT:    ret i32 [[RESULT]]
;
  i32* dereferenceable(4) %length,
  i32 %n) {
entry:
  %tmp5 = icmp eq i32 %n, 0
  br i1 %tmp5, label %exit, label %loop.preheader

loop.preheader:
  br label %loop

loop:
  %loop.acc = phi i32 [ %loop.acc.next, %loop ], [ 0, %loop.preheader ]
  %i = phi i32 [ %i.next, %loop ], [ 0, %loop.preheader ]
  %unknown = load volatile i1, i1* @UNKNOWN
  call void (i1, ...) @llvm.experimental.guard(i1 %unknown) [ "deopt"() ]
  %within.bounds = icmp ult i32 %i, %n
  call void (i1, ...) @llvm.experimental.guard(i1 %within.bounds, i32 9) [ "deopt"() ]

  %i.i64 = zext i32 %i to i64
  %array.i.ptr = getelementptr inbounds i32, i32* %array, i64 %i.i64
  %array.i = load i32, i32* %array.i.ptr, align 4
  %loop.acc.next = add i32 %loop.acc, %array.i

  %i.next = add nuw i32 %i, 1
  %len = load i32, i32* %length, align 4, !invariant.load !{}
  %continue = icmp ult i32 %i.next, %len
  br i1 %continue, label %loop, label %exit

exit:
  %result = phi i32 [ 0, %entry ], [ %loop.acc.next, %loop ]
  ret i32 %result
}



@Length = external constant i32

define i32 @constant_memory(i32* %array, i32 %n) {
; CHECK-LABEL: @constant_memory(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[TMP5]], label [[EXIT:%.*]], label [[LOOP_PREHEADER:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[LOOP_ACC:%.*]] = phi i32 [ [[LOOP_ACC_NEXT:%.*]], [[LOOP]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[I:%.*]] = phi i32 [ [[I_NEXT:%.*]], [[LOOP]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[UNKNOWN:%.*]] = load volatile i1, i1* @UNKNOWN, align 1
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[UNKNOWN]]) [ "deopt"() ]
; CHECK-NEXT:    [[LEN:%.*]] = load i32, i32* @Length, align 4
; CHECK-NEXT:    [[WITHIN_BOUNDS:%.*]] = icmp ult i32 [[I]], [[LEN]]
; CHECK-NEXT:    [[TMP0:%.*]] = icmp ule i32 [[N]], [[LEN]]
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult i32 0, [[LEN]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i1 [[TMP1]], [[TMP0]]
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[TMP2]], i32 9) [ "deopt"() ]
; CHECK-NEXT:    call void @llvm.assume(i1 [[WITHIN_BOUNDS]])
; CHECK-NEXT:    [[I_I64:%.*]] = zext i32 [[I]] to i64
; CHECK-NEXT:    [[ARRAY_I_PTR:%.*]] = getelementptr inbounds i32, i32* [[ARRAY:%.*]], i64 [[I_I64]]
; CHECK-NEXT:    [[ARRAY_I:%.*]] = load i32, i32* [[ARRAY_I_PTR]], align 4
; CHECK-NEXT:    [[LOOP_ACC_NEXT]] = add i32 [[LOOP_ACC]], [[ARRAY_I]]
; CHECK-NEXT:    [[I_NEXT]] = add nuw i32 [[I]], 1
; CHECK-NEXT:    [[CONTINUE:%.*]] = icmp ult i32 [[I_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[CONTINUE]], label [[LOOP]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    [[LOOP_ACC_NEXT_LCSSA:%.*]] = phi i32 [ [[LOOP_ACC_NEXT]], [[LOOP]] ]
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[RESULT:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[LOOP_ACC_NEXT_LCSSA]], [[EXIT_LOOPEXIT]] ]
; CHECK-NEXT:    ret i32 [[RESULT]]
;
entry:
  %tmp5 = icmp eq i32 %n, 0
  br i1 %tmp5, label %exit, label %loop.preheader

loop.preheader:
  br label %loop

loop:
  %loop.acc = phi i32 [ %loop.acc.next, %loop ], [ 0, %loop.preheader ]
  %i = phi i32 [ %i.next, %loop ], [ 0, %loop.preheader ]
  %unknown = load volatile i1, i1* @UNKNOWN
  call void (i1, ...) @llvm.experimental.guard(i1 %unknown) [ "deopt"() ]
  %len = load i32, i32* @Length, align 4
  %within.bounds = icmp ult i32 %i, %len
  call void (i1, ...) @llvm.experimental.guard(i1 %within.bounds, i32 9) [ "deopt"() ]

  %i.i64 = zext i32 %i to i64
  %array.i.ptr = getelementptr inbounds i32, i32* %array, i64 %i.i64
  %array.i = load i32, i32* %array.i.ptr, align 4
  %loop.acc.next = add i32 %loop.acc, %array.i

  %i.next = add nuw i32 %i, 1
  %continue = icmp ult i32 %i.next, %n
  br i1 %continue, label %loop, label %exit

exit:
  %result = phi i32 [ 0, %entry ], [ %loop.acc.next, %loop ]
  ret i32 %result
}

define i32 @constant_length(i32* %array, i32 %n) {
; CHECK-LABEL: @constant_length(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[TMP5]], label [[EXIT:%.*]], label [[LOOP_PREHEADER:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = icmp ule i32 [[N]], 20
; CHECK-NEXT:    [[TMP1:%.*]] = and i1 true, [[TMP0]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[LOOP_ACC:%.*]] = phi i32 [ [[LOOP_ACC_NEXT:%.*]], [[LOOP]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[I:%.*]] = phi i32 [ [[I_NEXT:%.*]], [[LOOP]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[UNKNOWN:%.*]] = load volatile i1, i1* @UNKNOWN, align 1
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[UNKNOWN]]) [ "deopt"() ]
; CHECK-NEXT:    [[WITHIN_BOUNDS:%.*]] = icmp ult i32 [[I]], 20
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 [[TMP1]], i32 9) [ "deopt"() ]
; CHECK-NEXT:    call void @llvm.assume(i1 [[WITHIN_BOUNDS]])
; CHECK-NEXT:    [[I_I64:%.*]] = zext i32 [[I]] to i64
; CHECK-NEXT:    [[ARRAY_I_PTR:%.*]] = getelementptr inbounds i32, i32* [[ARRAY:%.*]], i64 [[I_I64]]
; CHECK-NEXT:    [[ARRAY_I:%.*]] = load i32, i32* [[ARRAY_I_PTR]], align 4
; CHECK-NEXT:    [[LOOP_ACC_NEXT]] = add i32 [[LOOP_ACC]], [[ARRAY_I]]
; CHECK-NEXT:    [[I_NEXT]] = add nuw i32 [[I]], 1
; CHECK-NEXT:    [[CONTINUE:%.*]] = icmp ult i32 [[I_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[CONTINUE]], label [[LOOP]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    [[LOOP_ACC_NEXT_LCSSA:%.*]] = phi i32 [ [[LOOP_ACC_NEXT]], [[LOOP]] ]
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[RESULT:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[LOOP_ACC_NEXT_LCSSA]], [[EXIT_LOOPEXIT]] ]
; CHECK-NEXT:    ret i32 [[RESULT]]
;
entry:
  %tmp5 = icmp eq i32 %n, 0
  br i1 %tmp5, label %exit, label %loop.preheader

loop.preheader:
  br label %loop

loop:
  %loop.acc = phi i32 [ %loop.acc.next, %loop ], [ 0, %loop.preheader ]
  %i = phi i32 [ %i.next, %loop ], [ 0, %loop.preheader ]
  %unknown = load volatile i1, i1* @UNKNOWN
  call void (i1, ...) @llvm.experimental.guard(i1 %unknown) [ "deopt"() ]
  %within.bounds = icmp ult i32 %i, 20
  call void (i1, ...) @llvm.experimental.guard(i1 %within.bounds, i32 9) [ "deopt"() ]

  %i.i64 = zext i32 %i to i64
  %array.i.ptr = getelementptr inbounds i32, i32* %array, i64 %i.i64
  %array.i = load i32, i32* %array.i.ptr, align 4
  %loop.acc.next = add i32 %loop.acc, %array.i

  %i.next = add nuw i32 %i, 1
  %continue = icmp ult i32 %i.next, %n
  br i1 %continue, label %loop, label %exit

exit:
  %result = phi i32 [ 0, %entry ], [ %loop.acc.next, %loop ]
  ret i32 %result
}


