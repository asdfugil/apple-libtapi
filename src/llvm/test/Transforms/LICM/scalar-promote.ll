; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-attributes
; RUN: opt < %s -licm -S | FileCheck %s
; RUN: opt -aa-pipeline=tbaa,basic-aa -passes='require<aa>,require<targetir>,require<scalar-evolution>,require<opt-remark-emit>,loop-mssa(licm)' -S %s | FileCheck %s
target datalayout = "E-p:64:64:64-a0:0:8-f32:32:32-f64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-v64:64:64-v128:128:128"

@X = global i32 7   ; <ptr> [#uses=4]

define void @test1(i32 %i) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  Entry:
; CHECK-NEXT:    [[X_PROMOTED:%.*]] = load i32, ptr @X, align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       Loop:
; CHECK-NEXT:    [[X21:%.*]] = phi i32 [ [[X_PROMOTED]], [[ENTRY:%.*]] ], [ [[X2:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[J:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[X2]] = add i32 [[X21]], 1
; CHECK-NEXT:    [[NEXT]] = add i32 [[J]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[NEXT]], 0
; CHECK-NEXT:    br i1 [[COND]], label [[OUT:%.*]], label [[LOOP]]
; CHECK:       Out:
; CHECK-NEXT:    [[X2_LCSSA:%.*]] = phi i32 [ [[X2]], [[LOOP]] ]
; CHECK-NEXT:    store i32 [[X2_LCSSA]], ptr @X, align 4
; CHECK-NEXT:    ret void
;
Entry:
  br label %Loop

Loop:   ; preds = %Loop, %0
  %j = phi i32 [ 0, %Entry ], [ %Next, %Loop ]    ; <i32> [#uses=1]
  %x = load i32, ptr @X   ; <i32> [#uses=1]
  %x2 = add i32 %x, 1   ; <i32> [#uses=1]
  store i32 %x2, ptr @X
  %Next = add i32 %j, 1   ; <i32> [#uses=2]
  %cond = icmp eq i32 %Next, 0    ; <i1> [#uses=1]
  br i1 %cond, label %Out, label %Loop

Out:
  ret void
}

define void @test2(i32 %i) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  Entry:
; CHECK-NEXT:    [[DOTPROMOTED:%.*]] = load i32, ptr getelementptr inbounds (i32, ptr @X, i64 1), align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       Loop:
; CHECK-NEXT:    [[V1:%.*]] = phi i32 [ [[V:%.*]], [[LOOP]] ], [ [[DOTPROMOTED]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[V]] = add i32 [[V1]], 1
; CHECK-NEXT:    br i1 false, label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       Exit:
; CHECK-NEXT:    [[V_LCSSA:%.*]] = phi i32 [ [[V]], [[LOOP]] ]
; CHECK-NEXT:    store i32 [[V_LCSSA]], ptr getelementptr inbounds (i32, ptr @X, i64 1), align 4
; CHECK-NEXT:    ret void
;
Entry:
  br label %Loop

Loop:   ; preds = %Loop, %0
  %X1 = getelementptr i32, ptr @X, i64 1    ; <ptr> [#uses=1]
  %A = load i32, ptr %X1    ; <i32> [#uses=1]
  %V = add i32 %A, 1    ; <i32> [#uses=1]
  %X2 = getelementptr i32, ptr @X, i64 1    ; <ptr> [#uses=1]
  store i32 %V, ptr %X2
  br i1 false, label %Loop, label %Exit

Exit:   ; preds = %Loop
  ret void
}

define void @test3(i32 %i) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       Loop:
; CHECK-NEXT:    [[X:%.*]] = load volatile i32, ptr @X, align 4
; CHECK-NEXT:    [[X2:%.*]] = add i32 [[X]], 1
; CHECK-NEXT:    store i32 [[X2]], ptr @X, align 4
; CHECK-NEXT:    br i1 true, label [[OUT:%.*]], label [[LOOP]]
; CHECK:       Out:
; CHECK-NEXT:    ret void
;
  br label %Loop
Loop:
  ; Should not promote this to a register
  %x = load volatile i32, ptr @X
  %x2 = add i32 %x, 1
  store i32 %x2, ptr @X
  br i1 true, label %Out, label %Loop

Out:    ; preds = %Loop
  ret void
}

; Should not promote this to a register
define void @test3b(i32 %i) {
; CHECK-LABEL: @test3b(
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       Loop:
; CHECK-NEXT:    [[X:%.*]] = load i32, ptr @X, align 4
; CHECK-NEXT:    [[X2:%.*]] = add i32 [[X]], 1
; CHECK-NEXT:    store volatile i32 [[X2]], ptr @X, align 4
; CHECK-NEXT:    br i1 true, label [[OUT:%.*]], label [[LOOP]]
; CHECK:       Out:
; CHECK-NEXT:    ret void
;
  br label %Loop
Loop:
  %x = load i32, ptr @X
  %x2 = add i32 %x, 1
  store volatile i32 %x2, ptr @X
  br i1 true, label %Out, label %Loop

Out:    ; preds = %Loop
  ret void
}

; PR8041
; Should have promoted 'handle2' accesses.
; Should not have promoted offsetx1 loads.
define void @test4(ptr %x, i8 %n) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    [[HANDLE1:%.*]] = alloca ptr, align 8
; CHECK-NEXT:    [[HANDLE2:%.*]] = alloca ptr, align 8
; CHECK-NEXT:    store ptr [[X:%.*]], ptr [[HANDLE1]], align 8
; CHECK-NEXT:    [[TMP:%.*]] = getelementptr i8, ptr [[X]], i64 8
; CHECK-NEXT:    [[OFFSETX1:%.*]] = load ptr, ptr [[HANDLE1]], align 8
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br label [[SUBLOOP:%.*]]
; CHECK:       subloop:
; CHECK-NEXT:    [[NEWOFFSETX21:%.*]] = phi ptr [ [[TMP]], [[LOOP]] ], [ [[NEWOFFSETX2:%.*]], [[SUBLOOP]] ]
; CHECK-NEXT:    [[COUNT:%.*]] = phi i8 [ 0, [[LOOP]] ], [ [[NEXTCOUNT:%.*]], [[SUBLOOP]] ]
; CHECK-NEXT:    store i8 [[N:%.*]], ptr [[NEWOFFSETX21]], align 1
; CHECK-NEXT:    [[NEWOFFSETX2]] = getelementptr i8, ptr [[NEWOFFSETX21]], i64 -1
; CHECK-NEXT:    [[NEXTCOUNT]] = add i8 [[COUNT]], 1
; CHECK-NEXT:    [[INNEREXITCOND:%.*]] = icmp sge i8 [[NEXTCOUNT]], 8
; CHECK-NEXT:    br i1 [[INNEREXITCOND]], label [[INNEREXIT:%.*]], label [[SUBLOOP]]
; CHECK:       innerexit:
; CHECK-NEXT:    [[NEWOFFSETX2_LCSSA:%.*]] = phi ptr [ [[NEWOFFSETX2]], [[SUBLOOP]] ]
; CHECK-NEXT:    [[VAL:%.*]] = load i8, ptr [[OFFSETX1]], align 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i8 [[VAL]], [[N]]
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[NEWOFFSETX2_LCSSA_LCSSA:%.*]] = phi ptr [ [[NEWOFFSETX2_LCSSA]], [[INNEREXIT]] ]
; CHECK-NEXT:    store ptr [[NEWOFFSETX2_LCSSA_LCSSA]], ptr [[HANDLE2]], align 8
; CHECK-NEXT:    ret void
;
  %handle1 = alloca ptr
  %handle2 = alloca ptr
  store ptr %x, ptr %handle1
  br label %loop

loop:
  %tmp = getelementptr i8, ptr %x, i64 8
  store ptr %tmp, ptr %handle2
  br label %subloop

subloop:
  %count = phi i8 [ 0, %loop ], [ %nextcount, %subloop ]
  %offsetx2 = load ptr, ptr %handle2
  store i8 %n, ptr %offsetx2
  %newoffsetx2 = getelementptr i8, ptr %offsetx2, i64 -1
  store ptr %newoffsetx2, ptr %handle2
  %nextcount = add i8 %count, 1
  %innerexitcond = icmp sge i8 %nextcount, 8
  br i1 %innerexitcond, label %innerexit, label %subloop

innerexit:
  %offsetx1 = load ptr, ptr %handle1
  %val = load i8, ptr %offsetx1
  %cond = icmp eq i8 %val, %n
  br i1 %cond, label %exit, label %loop

exit:
  ret void
}

define void @test5(i32 %i, ptr noalias %P2) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  Entry:
; CHECK-NEXT:    [[X_PROMOTED:%.*]] = load i32, ptr @X, align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       Loop:
; CHECK-NEXT:    [[X21:%.*]] = phi i32 [ [[X_PROMOTED]], [[ENTRY:%.*]] ], [ [[X2:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[J:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[X2]] = add i32 [[X21]], 1
; CHECK-NEXT:    store atomic ptr @X, ptr [[P2:%.*]] monotonic, align 8
; CHECK-NEXT:    [[NEXT]] = add i32 [[J]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[NEXT]], 0
; CHECK-NEXT:    br i1 [[COND]], label [[OUT:%.*]], label [[LOOP]]
; CHECK:       Out:
; CHECK-NEXT:    [[X2_LCSSA:%.*]] = phi i32 [ [[X2]], [[LOOP]] ]
; CHECK-NEXT:    store i32 [[X2_LCSSA]], ptr @X, align 4
; CHECK-NEXT:    ret void
;
Entry:
  br label %Loop

Loop:   ; preds = %Loop, %0
  %j = phi i32 [ 0, %Entry ], [ %Next, %Loop ]    ; <i32> [#uses=1]
  %x = load i32, ptr @X   ; <i32> [#uses=1]
  %x2 = add i32 %x, 1   ; <i32> [#uses=1]
  store i32 %x2, ptr @X

  store atomic ptr @X, ptr %P2 monotonic, align 8

  %Next = add i32 %j, 1   ; <i32> [#uses=2]
  %cond = icmp eq i32 %Next, 0    ; <i1> [#uses=1]
  br i1 %cond, label %Out, label %Loop

Out:
  ret void

}


; PR14753 - Preserve TBAA tags when promoting values in a loop.
define void @test6(i32 %n, ptr nocapture %a, ptr %gi) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i32 0, ptr [[GI:%.*]], align 4, !tbaa [[TBAA0:![0-9]+]]
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 0, [[N:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_LR_PH:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.lr.ph:
; CHECK-NEXT:    [[GI_PROMOTED:%.*]] = load i32, ptr [[GI]], align 4, !tbaa [[TBAA0]]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INC1:%.*]] = phi i32 [ [[GI_PROMOTED]], [[FOR_BODY_LR_PH]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[STOREMERGE2:%.*]] = phi i32 [ 0, [[FOR_BODY_LR_PH]] ], [ [[INC]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[IDXPROM:%.*]] = sext i32 [[STOREMERGE2]] to i64
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[A:%.*]], i64 [[IDXPROM]]
; CHECK-NEXT:    store float 0.000000e+00, ptr [[ARRAYIDX]], align 4, !tbaa [[TBAA4:![0-9]+]]
; CHECK-NEXT:    [[INC]] = add nsw i32 [[INC1]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_COND_FOR_END_CRIT_EDGE:%.*]]
; CHECK:       for.cond.for.end_crit_edge:
; CHECK-NEXT:    [[INC_LCSSA:%.*]] = phi i32 [ [[INC]], [[FOR_BODY]] ]
; CHECK-NEXT:    store i32 [[INC_LCSSA]], ptr [[GI]], align 4, !tbaa [[TBAA0]]
; CHECK-NEXT:    br label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  store i32 0, ptr %gi, align 4, !tbaa !0
  %cmp1 = icmp slt i32 0, %n
  br i1 %cmp1, label %for.body.lr.ph, label %for.end

for.body.lr.ph:                                   ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.body
  %storemerge2 = phi i32 [ 0, %for.body.lr.ph ], [ %inc, %for.body ]
  %idxprom = sext i32 %storemerge2 to i64
  %arrayidx = getelementptr inbounds float, ptr %a, i64 %idxprom
  store float 0.000000e+00, ptr %arrayidx, align 4, !tbaa !3
  %0 = load i32, ptr %gi, align 4, !tbaa !0
  %inc = add nsw i32 %0, 1
  store i32 %inc, ptr %gi, align 4, !tbaa !0
  %cmp = icmp slt i32 %inc, %n
  br i1 %cmp, label %for.body, label %for.cond.for.end_crit_edge

for.cond.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end

for.end:                                          ; preds = %for.cond.for.end_crit_edge, %entry
  ret void

}

declare i32 @opaque(i32) argmemonly
declare void @capture(ptr)

; We can promote even if opaque may throw.
define i32 @test7() {
; CHECK-LABEL: @test7(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LOCAL:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @capture(ptr [[LOCAL]])
; CHECK-NEXT:    [[LOCAL_PROMOTED:%.*]] = load i32, ptr [[LOCAL]], align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[X21:%.*]] = phi i32 [ [[LOCAL_PROMOTED]], [[ENTRY:%.*]] ], [ [[X2:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[J:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[X2]] = call i32 @opaque(i32 [[X21]])
; CHECK-NEXT:    [[NEXT]] = add i32 [[J]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[NEXT]], 0
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[X2_LCSSA:%.*]] = phi i32 [ [[X2]], [[LOOP]] ]
; CHECK-NEXT:    store i32 [[X2_LCSSA]], ptr [[LOCAL]], align 4
; CHECK-NEXT:    [[RET:%.*]] = load i32, ptr [[LOCAL]], align 4
; CHECK-NEXT:    ret i32 [[RET]]
;
entry:
  %local = alloca i32
  call void @capture(ptr %local)
  br label %loop

loop:
  %j = phi i32 [ 0, %entry ], [ %next, %loop ]
  %x = load i32, ptr %local
  %x2 = call i32 @opaque(i32 %x) ; Note this does not capture %local
  store i32 %x2, ptr %local
  %next = add i32 %j, 1
  %cond = icmp eq i32 %next, 0
  br i1 %cond, label %exit, label %loop

exit:
  %ret = load i32, ptr %local
  ret i32 %ret
}

; Hoist the load even if we cannot sink the store, since the store is really
; control-flow dependent.
define i32 @test7bad() {
; CHECK-LABEL: @test7bad(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LOCAL:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @capture(ptr [[LOCAL]])
; CHECK-NEXT:    [[LOCAL_PROMOTED:%.*]] = load i32, ptr [[LOCAL]], align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[X22:%.*]] = phi i32 [ [[LOCAL_PROMOTED]], [[ENTRY:%.*]] ], [ [[X21:%.*]], [[ELSE:%.*]] ]
; CHECK-NEXT:    [[J:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[NEXT:%.*]], [[ELSE]] ]
; CHECK-NEXT:    [[X2:%.*]] = call i32 @opaque(i32 [[X22]])
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X2]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[ELSE]]
; CHECK:       if:
; CHECK-NEXT:    store i32 [[X2]], ptr [[LOCAL]], align 4
; CHECK-NEXT:    br label [[ELSE]]
; CHECK:       else:
; CHECK-NEXT:    [[X21]] = phi i32 [ [[X2]], [[IF]] ], [ [[X22]], [[LOOP]] ]
; CHECK-NEXT:    [[NEXT]] = add i32 [[J]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[NEXT]], 0
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[RET:%.*]] = load i32, ptr [[LOCAL]], align 4
; CHECK-NEXT:    ret i32 [[RET]]
;
entry:
  %local = alloca i32
  call void @capture(ptr %local)
  br label %loop
loop:
  %j = phi i32 [ 0, %entry ], [ %next, %else ]
  %x = load i32, ptr %local
  %x2 = call i32 @opaque(i32 %x) ; Note this does not capture %local
  %cmp = icmp eq i32 %x2, 0
  br i1 %cmp, label %if, label %else

if:
  store i32 %x2, ptr %local
  br label %else

else:
  %next = add i32 %j, 1
  %cond = icmp eq i32 %next, 0
  br i1 %cond, label %exit, label %loop

exit:
  %ret = load i32, ptr %local
  ret i32 %ret
}

; Even if neither the load nor the store or guaranteed to execute because
; opaque() may throw, we can still promote - the load not being guaranteed
; doesn't block us, because %local is always dereferenceable.
define i32 @test8() {
; CHECK-LABEL: @test8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LOCAL:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @capture(ptr [[LOCAL]])
; CHECK-NEXT:    [[LOCAL_PROMOTED:%.*]] = load i32, ptr [[LOCAL]], align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[X21:%.*]] = phi i32 [ [[LOCAL_PROMOTED]], [[ENTRY:%.*]] ], [ [[X2:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[J:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[THROWAWAY:%.*]] = call i32 @opaque(i32 [[J]])
; CHECK-NEXT:    [[X2]] = call i32 @opaque(i32 [[X21]])
; CHECK-NEXT:    [[NEXT]] = add i32 [[J]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[NEXT]], 0
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[X2_LCSSA:%.*]] = phi i32 [ [[X2]], [[LOOP]] ]
; CHECK-NEXT:    store i32 [[X2_LCSSA]], ptr [[LOCAL]], align 4
; CHECK-NEXT:    [[RET:%.*]] = load i32, ptr [[LOCAL]], align 4
; CHECK-NEXT:    ret i32 [[RET]]
;
entry:
  %local = alloca i32
  call void @capture(ptr %local)
  br label %loop

loop:
  %j = phi i32 [ 0, %entry ], [ %next, %loop ]
  %throwaway = call i32 @opaque(i32 %j)
  %x = load i32, ptr %local
  %x2 = call i32 @opaque(i32 %x)
  store i32 %x2, ptr %local
  %next = add i32 %j, 1
  %cond = icmp eq i32 %next, 0
  br i1 %cond, label %exit, label %loop

exit:
  %ret = load i32, ptr %local
  ret i32 %ret
}


; If the store is "guaranteed modulo exceptions", and the load depends on
; control flow, we can only promote if the pointer is otherwise known to be
; dereferenceable
define i32 @test9() {
; CHECK-LABEL: @test9(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LOCAL:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @capture(ptr [[LOCAL]])
; CHECK-NEXT:    [[LOCAL_PROMOTED:%.*]] = load i32, ptr [[LOCAL]], align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[X21:%.*]] = phi i32 [ [[LOCAL_PROMOTED]], [[ENTRY:%.*]] ], [ [[X2:%.*]], [[ELSE:%.*]] ]
; CHECK-NEXT:    [[J:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[NEXT:%.*]], [[ELSE]] ]
; CHECK-NEXT:    [[J2:%.*]] = call i32 @opaque(i32 [[J]])
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[J2]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[ELSE]]
; CHECK:       if:
; CHECK-NEXT:    br label [[ELSE]]
; CHECK:       else:
; CHECK-NEXT:    [[X2]] = phi i32 [ 0, [[LOOP]] ], [ [[X21]], [[IF]] ]
; CHECK-NEXT:    [[NEXT]] = add i32 [[J]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[NEXT]], 0
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[X2_LCSSA:%.*]] = phi i32 [ [[X2]], [[ELSE]] ]
; CHECK-NEXT:    store i32 [[X2_LCSSA]], ptr [[LOCAL]], align 4
; CHECK-NEXT:    [[RET:%.*]] = load i32, ptr [[LOCAL]], align 4
; CHECK-NEXT:    ret i32 [[RET]]
;
entry:
  %local = alloca i32
  call void @capture(ptr %local)
  br label %loop

loop:
  %j = phi i32 [ 0, %entry ], [ %next, %else ]
  %j2 = call i32 @opaque(i32 %j)
  %cmp = icmp eq i32 %j2, 0
  br i1 %cmp, label %if, label %else

if:
  %x = load i32, ptr %local
  br label %else

else:
  %x2 = phi i32 [ 0, %loop ], [ %x, %if]
  store i32 %x2, ptr %local
  %next = add i32 %j, 1
  %cond = icmp eq i32 %next, 0
  br i1 %cond, label %exit, label %loop

exit:
  %ret = load i32, ptr %local
  ret i32 %ret
}

define i32 @test9bad(i32 %i) {
; CHECK-LABEL: @test9bad(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LOCAL:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @capture(ptr [[LOCAL]])
; CHECK-NEXT:    [[NOTDEREF:%.*]] = getelementptr i32, ptr [[LOCAL]], i32 [[I:%.*]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[J:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[NEXT:%.*]], [[ELSE:%.*]] ]
; CHECK-NEXT:    [[J2:%.*]] = call i32 @opaque(i32 [[J]])
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[J2]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[IF:%.*]], label [[ELSE]]
; CHECK:       if:
; CHECK-NEXT:    [[X:%.*]] = load i32, ptr [[NOTDEREF]], align 4
; CHECK-NEXT:    br label [[ELSE]]
; CHECK:       else:
; CHECK-NEXT:    [[X2:%.*]] = phi i32 [ 0, [[LOOP]] ], [ [[X]], [[IF]] ]
; CHECK-NEXT:    store i32 [[X2]], ptr [[NOTDEREF]], align 4
; CHECK-NEXT:    [[NEXT]] = add i32 [[J]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[NEXT]], 0
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[RET:%.*]] = load i32, ptr [[NOTDEREF]], align 4
; CHECK-NEXT:    ret i32 [[RET]]
;
entry:
  %local = alloca i32
  call void @capture(ptr %local)
  %notderef = getelementptr i32, ptr %local, i32 %i
  br label %loop

loop:
  %j = phi i32 [ 0, %entry ], [ %next, %else ]
  %j2 = call i32 @opaque(i32 %j)
  %cmp = icmp eq i32 %j2, 0
  br i1 %cmp, label %if, label %else

if:
  %x = load i32, ptr %notderef
  br label %else

else:
  %x2 = phi i32 [ 0, %loop ], [ %x, %if]
  store i32 %x2, ptr %notderef
  %next = add i32 %j, 1
  %cond = icmp eq i32 %next, 0
  br i1 %cond, label %exit, label %loop

exit:
  %ret = load i32, ptr %notderef
  ret i32 %ret
}

define void @test10(i32 %i) {
; CHECK-LABEL: @test10(
; CHECK-NEXT:  Entry:
; CHECK-NEXT:    [[X_PROMOTED:%.*]] = load atomic i32, ptr @X unordered, align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       Loop:
; CHECK-NEXT:    [[X21:%.*]] = phi i32 [ [[X_PROMOTED]], [[ENTRY:%.*]] ], [ [[X2:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[J:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[X2]] = add i32 [[X21]], 1
; CHECK-NEXT:    [[NEXT]] = add i32 [[J]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[NEXT]], 0
; CHECK-NEXT:    br i1 [[COND]], label [[OUT:%.*]], label [[LOOP]]
; CHECK:       Out:
; CHECK-NEXT:    [[X2_LCSSA:%.*]] = phi i32 [ [[X2]], [[LOOP]] ]
; CHECK-NEXT:    store atomic i32 [[X2_LCSSA]], ptr @X unordered, align 4
; CHECK-NEXT:    ret void
;
Entry:
  br label %Loop


Loop:   ; preds = %Loop, %0
  %j = phi i32 [ 0, %Entry ], [ %Next, %Loop ]    ; <i32> [#uses=1]
  %x = load atomic i32, ptr @X unordered, align 4
  %x2 = add i32 %x, 1
  store atomic i32 %x2, ptr @X unordered, align 4
  %Next = add i32 %j, 1
  %cond = icmp eq i32 %Next, 0
  br i1 %cond, label %Out, label %Loop

Out:
  ret void

}

; Early exit is known not to be taken on first iteration and thus doesn't
; effect whether load is known to execute.
define void @test11(i32 %i) {
; CHECK-LABEL: @test11(
; CHECK-NEXT:  Entry:
; CHECK-NEXT:    [[X_PROMOTED:%.*]] = load i32, ptr @X, align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       Loop:
; CHECK-NEXT:    [[X21:%.*]] = phi i32 [ [[X_PROMOTED]], [[ENTRY:%.*]] ], [ [[X2:%.*]], [[BODY:%.*]] ]
; CHECK-NEXT:    [[J:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[NEXT:%.*]], [[BODY]] ]
; CHECK-NEXT:    [[EARLY_TEST:%.*]] = icmp ult i32 [[J]], 32
; CHECK-NEXT:    br i1 [[EARLY_TEST]], label [[BODY]], label [[EARLY:%.*]]
; CHECK:       body:
; CHECK-NEXT:    [[X2]] = add i32 [[X21]], 1
; CHECK-NEXT:    [[NEXT]] = add i32 [[J]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[NEXT]], 0
; CHECK-NEXT:    br i1 [[COND]], label [[OUT:%.*]], label [[LOOP]]
; CHECK:       Early:
; CHECK-NEXT:    [[X21_LCSSA:%.*]] = phi i32 [ [[X21]], [[LOOP]] ]
; CHECK-NEXT:    store i32 [[X21_LCSSA]], ptr @X, align 4
; CHECK-NEXT:    ret void
; CHECK:       Out:
; CHECK-NEXT:    [[X2_LCSSA:%.*]] = phi i32 [ [[X2]], [[BODY]] ]
; CHECK-NEXT:    store i32 [[X2_LCSSA]], ptr @X, align 4
; CHECK-NEXT:    ret void
;
Entry:
  br label %Loop


Loop:   ; preds = %Loop, %0
  %j = phi i32 [ 0, %Entry ], [ %Next, %body ]    ; <i32> [#uses=1]
  %early.test = icmp ult i32 %j, 32
  br i1 %early.test, label %body, label %Early
body:
  %x = load i32, ptr @X   ; <i32> [#uses=1]
  %x2 = add i32 %x, 1   ; <i32> [#uses=1]
  store i32 %x2, ptr @X
  %Next = add i32 %j, 1   ; <i32> [#uses=2]
  %cond = icmp eq i32 %Next, 0    ; <i1> [#uses=1]
  br i1 %cond, label %Out, label %Loop

Early:
  ret void
Out:
  ret void

}

define i8 @test_hoistable_existing_load_sinkable_store_writeonly(ptr dereferenceable(8) %ptr, i8 %start) writeonly {
; CHECK: Function Attrs: writeonly
; CHECK-LABEL: @test_hoistable_existing_load_sinkable_store_writeonly(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR_PROMOTED:%.*]] = load i8, ptr [[PTR:%.*]], align 1
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[INC1:%.*]] = phi i8 [ [[PTR_PROMOTED]], [[ENTRY:%.*]] ], [ [[INC1]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[I:%.*]] = phi i8 [ [[START:%.*]], [[ENTRY]] ], [ [[ADD:%.*]], [[LOOP_LATCH]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8 [[I]], 4
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP_LATCH]], label [[EXIT:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    store i8 [[INC1]], ptr [[PTR]], align 1
; CHECK-NEXT:    [[ADD]] = add i8 [[I]], [[INC1]]
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    [[I_LCSSA:%.*]] = phi i8 [ [[I]], [[LOOP_HEADER]] ]
; CHECK-NEXT:    ret i8 [[I_LCSSA]]
;
entry:
  br label %loop.header

loop.header:
  %i = phi i8 [ %start, %entry ], [ %add, %loop.latch ]
  %cmp = icmp ult i8 %i, 4
  br i1 %cmp, label %loop.latch, label %exit

loop.latch:
  %div = sdiv i8 %i, 3
  %inc = load i8, ptr %ptr
  store i8 %inc, ptr %ptr
  %add = add i8 %i, %inc
  br label %loop.header

exit:
  ret i8 %i
}

@glb = external global i8, align 1

; Test case for PR51248.
define void @test_sink_store_only() writeonly {
; CHECK: Function Attrs: writeonly
; CHECK-LABEL: @test_sink_store_only(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[DIV1:%.*]] = phi i8 [ poison, [[ENTRY:%.*]] ], [ [[DIV:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[I:%.*]] = phi i8 [ 0, [[ENTRY]] ], [ [[ADD:%.*]], [[LOOP_LATCH]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8 [[I]], 4
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP_LATCH]], label [[EXIT:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[DIV]] = sdiv i8 [[I]], 3
; CHECK-NEXT:    [[ADD]] = add i8 [[I]], 4
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    [[DIV1_LCSSA:%.*]] = phi i8 [ [[DIV1]], [[LOOP_HEADER]] ]
; CHECK-NEXT:    store i8 [[DIV1_LCSSA]], ptr @glb, align 1
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %i = phi i8 [ 0, %entry ], [ %add, %loop.latch ]
  %cmp = icmp ult i8 %i, 4
  br i1 %cmp, label %loop.latch, label %exit

loop.latch:
  %div = sdiv i8 %i, 3
  store i8 %div, ptr @glb, align 1
  %add = add i8 %i, 4
  br label %loop.header

exit:
  ret void
}

define void @test_sink_store_to_local_object_only_loop_must_execute() writeonly {
; CHECK: Function Attrs: writeonly
; CHECK-LABEL: @test_sink_store_to_local_object_only_loop_must_execute(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i8, align 1
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[DIV1:%.*]] = phi i8 [ poison, [[ENTRY:%.*]] ], [ [[DIV:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[I:%.*]] = phi i8 [ 0, [[ENTRY]] ], [ [[ADD:%.*]], [[LOOP_LATCH]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8 [[I]], 4
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP_LATCH]], label [[EXIT:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[DIV]] = sdiv i8 [[I]], 3
; CHECK-NEXT:    [[ADD]] = add i8 [[I]], 4
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    [[DIV1_LCSSA:%.*]] = phi i8 [ [[DIV1]], [[LOOP_HEADER]] ]
; CHECK-NEXT:    store i8 [[DIV1_LCSSA]], ptr [[A]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i8
  br label %loop.header

loop.header:
  %i = phi i8 [ 0, %entry ], [ %add, %loop.latch ]
  %cmp = icmp ult i8 %i, 4
  br i1 %cmp, label %loop.latch, label %exit

loop.latch:
  %div = sdiv i8 %i, 3
  store i8 %div, ptr %a, align 1
  %add = add i8 %i, 4
  br label %loop.header

exit:
  ret void
}

; The store in the loop may not execute, so we need to introduce a load in the
; pre-header. Make sure the writeonly attribute is dropped.
define void @test_sink_store_to_local_object_only_loop_may_not_execute(i8 %n) writeonly {
; CHECK: Function Attrs: writeonly
; CHECK-LABEL: @test_sink_store_to_local_object_only_loop_may_not_execute(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i8, align 1
; CHECK-NEXT:    [[A_PROMOTED:%.*]] = load i8, ptr [[A]], align 1
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[DIV1:%.*]] = phi i8 [ [[A_PROMOTED]], [[ENTRY:%.*]] ], [ [[DIV:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[I:%.*]] = phi i8 [ 0, [[ENTRY]] ], [ [[ADD:%.*]], [[LOOP_LATCH]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8 [[I]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP_LATCH]], label [[EXIT:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[DIV]] = sdiv i8 [[I]], 3
; CHECK-NEXT:    [[ADD]] = add i8 [[I]], 4
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    [[DIV1_LCSSA:%.*]] = phi i8 [ [[DIV1]], [[LOOP_HEADER]] ]
; CHECK-NEXT:    store i8 [[DIV1_LCSSA]], ptr [[A]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i8
  br label %loop.header

loop.header:
  %i = phi i8 [ 0, %entry ], [ %add, %loop.latch ]
  %cmp = icmp ult i8 %i, %n
  br i1 %cmp, label %loop.latch, label %exit

loop.latch:
  %div = sdiv i8 %i, 3
  store i8 %div, ptr %a, align 1
  %add = add i8 %i, 4
  br label %loop.header

exit:
  ret void
}

declare dereferenceable(8) noalias ptr @alloc_writeonly() writeonly

define void @test_sink_store_to_noalias_call_object_only_loop_may_not_execute1(i8 %n) writeonly {
; CHECK: Function Attrs: writeonly
; CHECK-LABEL: @test_sink_store_to_noalias_call_object_only_loop_may_not_execute1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = call noalias dereferenceable(8) ptr @alloc_writeonly()
; CHECK-NEXT:    [[A_PROMOTED:%.*]] = load i8, ptr [[A]], align 1
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[DIV1:%.*]] = phi i8 [ [[A_PROMOTED]], [[ENTRY:%.*]] ], [ [[DIV:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[I:%.*]] = phi i8 [ 0, [[ENTRY]] ], [ [[ADD:%.*]], [[LOOP_LATCH]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8 [[I]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP_LATCH]], label [[EXIT:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[DIV]] = sdiv i8 [[I]], 3
; CHECK-NEXT:    [[ADD]] = add i8 [[I]], 4
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    [[DIV1_LCSSA:%.*]] = phi i8 [ [[DIV1]], [[LOOP_HEADER]] ]
; CHECK-NEXT:    store i8 [[DIV1_LCSSA]], ptr [[A]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %a = call dereferenceable(8) noalias ptr @alloc_writeonly()
  br label %loop.header

loop.header:
  %i = phi i8 [ 0, %entry ], [ %add, %loop.latch ]
  %cmp = icmp ult i8 %i, %n
  br i1 %cmp, label %loop.latch, label %exit

loop.latch:
  %div = sdiv i8 %i, 3
  store i8 %div, ptr %a, align 1
  %add = add i8 %i, 4
  br label %loop.header

exit:
  ret void
}

define void @test_sink_store_only_no_phi_needed() writeonly {
; CHECK: Function Attrs: writeonly
; CHECK-LABEL: @test_sink_store_only_no_phi_needed(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[I:%.*]] = phi i8 [ 0, [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8 [[I]], 4
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i8 [[I]], 3
; CHECK-NEXT:    [[ADD]] = add i8 [[I]], 4
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[DIV_LCSSA:%.*]] = phi i8 [ [[DIV]], [[LOOP]] ]
; CHECK-NEXT:    store i8 [[DIV_LCSSA]], ptr @glb, align 1
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %i = phi i8 [ 0, %entry ], [ %add, %loop ]
  %cmp = icmp ult i8 %i, 4
  %div = sdiv i8 %i, 3
  store i8 %div, ptr @glb, align 1
  %add = add i8 %i, 4
  br i1 %cmp, label %loop, label %exit

exit:
  ret void
}

define void @sink_store_lcssa_phis(ptr %ptr, i1 %c) {
; CHECK-LABEL: @sink_store_lcssa_phis(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_1_HEADER:%.*]]
; CHECK:       loop.1.header:
; CHECK-NEXT:    br label [[LOOP_2_HEADER:%.*]]
; CHECK:       loop.2.header:
; CHECK-NEXT:    br i1 false, label [[LOOP_3_HEADER_PREHEADER:%.*]], label [[LOOP_1_LATCH:%.*]]
; CHECK:       loop.3.header.preheader:
; CHECK-NEXT:    br label [[LOOP_3_HEADER:%.*]]
; CHECK:       loop.3.header:
; CHECK-NEXT:    [[I_11:%.*]] = phi i32 [ [[I_1:%.*]], [[LOOP_3_LATCH:%.*]] ], [ poison, [[LOOP_3_HEADER_PREHEADER]] ]
; CHECK-NEXT:    [[I_1]] = phi i32 [ 1, [[LOOP_3_LATCH]] ], [ 0, [[LOOP_3_HEADER_PREHEADER]] ]
; CHECK-NEXT:    br i1 true, label [[LOOP_3_LATCH]], label [[LOOP_2_LATCH:%.*]]
; CHECK:       loop.3.latch:
; CHECK-NEXT:    br label [[LOOP_3_HEADER]]
; CHECK:       loop.2.latch:
; CHECK-NEXT:    [[I_11_LCSSA:%.*]] = phi i32 [ [[I_11]], [[LOOP_3_HEADER]] ]
; CHECK-NEXT:    store i32 [[I_11_LCSSA]], ptr [[PTR:%.*]], align 4
; CHECK-NEXT:    br label [[LOOP_2_HEADER]]
; CHECK:       loop.1.latch:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LOOP_1_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.1.header

loop.1.header:
  br label %loop.2.header

loop.2.header:
  br i1 false, label %loop.3.header, label %loop.1.latch

loop.3.header:
  %i.1 = phi i32 [ 1, %loop.3.latch ], [ 0, %loop.2.header ]
  br i1 true, label %loop.3.latch, label %loop.2.latch

loop.3.latch:
  store i32 %i.1, ptr %ptr, align 4
  br label %loop.3.header

loop.2.latch:
  br label %loop.2.header

loop.1.latch:
  br i1 %c, label %loop.1.header, label %exit

exit:
  ret void
}

; TODO: The store can be promoted, as sret memory is writable.
define void @sret_cond_store(ptr sret(i32) noalias %ptr) {
; CHECK-LABEL: @sret_cond_store(
; CHECK-NEXT:    [[PTR_PROMOTED:%.*]] = load i32, ptr [[PTR:%.*]], align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[V_INC1:%.*]] = phi i32 [ [[V_INC:%.*]], [[LOOP_LATCH:%.*]] ], [ [[PTR_PROMOTED]], [[TMP0:%.*]] ]
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[V_INC1]], 10
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_LATCH]], label [[EXIT:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[V_INC]] = add i32 [[V_INC1]], 1
; CHECK-NEXT:    store i32 [[V_INC]], ptr [[PTR]], align 4
; CHECK-NEXT:    br label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
  br label %loop

loop:
  %v = load i32, ptr %ptr
  %c = icmp ult i32 %v, 10
  br i1 %c, label %loop.latch, label %exit

loop.latch:
  %v.inc = add i32 %v, 1
  store i32 %v.inc, ptr %ptr
  br label %loop

exit:
  ret void
}

!0 = !{!4, !4, i64 0}
!1 = !{!"omnipotent char", !2}
!2 = !{!"Simple C/C++ TBAA"}
!3 = !{!5, !5, i64 0}
!4 = !{!"int", !1}
!5 = !{!"float", !1}
