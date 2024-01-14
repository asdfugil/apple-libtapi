; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -loop-reduce -S | FileCheck %s
target datalayout = "e-m:w-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc18.0.0"

%struct.L = type { i8, i8* }

declare i32 @__CxxFrameHandler3(...)

@GV1 = external global %struct.L*
@GV2 = external global %struct.L

define void @b_copy_ctor() personality i32 (...)* @__CxxFrameHandler3 {
; CHECK-LABEL: @b_copy_ctor(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load %struct.L*, %struct.L** @GV1, align 8
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast %struct.L* [[TMP0]] to i8*
; CHECK-NEXT:    br label [[FOR_COND:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[LSR_IV:%.*]] = phi i64 [ [[LSR_IV_NEXT:%.*]], [[CALL_I_NOEXC:%.*]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[LSR_IV2:%.*]] = inttoptr i64 [[LSR_IV]] to %struct.L*
; CHECK-NEXT:    invoke void @a_copy_ctor()
; CHECK-NEXT:    to label [[CALL_I_NOEXC]] unwind label [[CATCH_DISPATCH:%.*]]
; CHECK:       call.i.noexc:
; CHECK-NEXT:    [[LSR_IV_NEXT]] = add i64 [[LSR_IV]], -16
; CHECK-NEXT:    br label [[FOR_COND]]
; CHECK:       catch.dispatch:
; CHECK-NEXT:    [[TMP2:%.*]] = catchswitch within none [label %catch] unwind to caller
; CHECK:       catch:
; CHECK-NEXT:    [[TMP3:%.*]] = catchpad within [[TMP2]] [i8* null, i32 64, i8* null]
; CHECK-NEXT:    [[CMP16:%.*]] = icmp eq %struct.L* [[LSR_IV2]], null
; CHECK-NEXT:    [[TMP4:%.*]] = mul i64 [[LSR_IV]], -1
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, i8* [[TMP1]], i64 [[TMP4]]
; CHECK-NEXT:    [[UGLYGEP1:%.*]] = bitcast i8* [[UGLYGEP]] to %struct.L*
; CHECK-NEXT:    br i1 [[CMP16]], label [[FOR_END:%.*]], label [[FOR_BODY_PREHEADER:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq %struct.L* [[UGLYGEP1]], @GV2
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_END_LOOPEXIT:%.*]], label [[FOR_BODY]]
; CHECK:       for.end.loopexit:
; CHECK-NEXT:    br label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    catchret from [[TMP3]] to label [[TRY_CONT:%.*]]
; CHECK:       try.cont:
; CHECK-NEXT:    ret void
;
entry:
  %0 = load %struct.L*, %struct.L** @GV1, align 8
  br label %for.cond

for.cond:                                         ; preds = %call.i.noexc, %entry
  %d.0 = phi %struct.L* [ %0, %entry ], [ %incdec.ptr, %call.i.noexc ]
  invoke void @a_copy_ctor()
  to label %call.i.noexc unwind label %catch.dispatch

call.i.noexc:                                     ; preds = %for.cond
  %incdec.ptr = getelementptr inbounds %struct.L, %struct.L* %d.0, i64 1
  br label %for.cond

catch.dispatch:                                   ; preds = %for.cond
  %1 = catchswitch within none [label %catch] unwind to caller

catch:                                            ; preds = %catch.dispatch
  %2 = catchpad within %1 [i8* null, i32 64, i8* null]
  %cmp16 = icmp eq %struct.L* %0, %d.0
  br i1 %cmp16, label %for.end, label %for.body

for.body:                                         ; preds = %for.body, %catch
  %cmp = icmp eq %struct.L* @GV2, %d.0
  br i1 %cmp, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %catch
  catchret from %2 to label %try.cont

try.cont:                                         ; preds = %for.end
  ret void
}

declare void @a_copy_ctor()
