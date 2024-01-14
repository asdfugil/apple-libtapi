; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=constraint-elimination -S %s | FileCheck %s

define void @pointer.to.array.test.ult.true.due.to.first.dimension(ptr %start, ptr %high) {
; CHECK-LABEL: @pointer.to.array.test.ult.true.due.to.first.dimension(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds [10 x i8], ptr [[START:%.*]], i64 9, i64 3
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule ptr [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[START_0:%.*]] = getelementptr inbounds [10 x i8], ptr [[START]], i64 5, i64 0
; CHECK-NEXT:    [[C_0:%.*]] = icmp ult ptr [[START_0]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_0]])
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds [10 x i8], ptr %start, i64 9, i64 3
  %c.1 = icmp ule ptr %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %start.0 = getelementptr inbounds [10 x i8], ptr %start, i64 5, i64 0
  %c.0 = icmp ult ptr %start.0, %high
  call void @use(i1 %c.0)
  ret void

if.end:                                           ; preds = %entry
  ret void
}

define void @pointer.to.array.test.ult.unknown.due.to.first.dimension(ptr %start, ptr %high) {
; CHECK-LABEL: @pointer.to.array.test.ult.unknown.due.to.first.dimension(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds [10 x i8], ptr [[START:%.*]], i64 5, i64 3
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule ptr [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[START_0:%.*]] = getelementptr inbounds [10 x i8], ptr [[START]], i64 10, i64 0
; CHECK-NEXT:    [[C_0:%.*]] = icmp ult ptr [[START_0]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_0]])
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds [10 x i8], ptr %start, i64 5, i64 3
  %c.1 = icmp ule ptr %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %start.0 = getelementptr inbounds [10 x i8], ptr %start, i64 10, i64 0
  %c.0 = icmp ult ptr %start.0, %high
  call void @use(i1 %c.0)
  ret void

if.end:                                           ; preds = %entry
  ret void
}

define void @pointer.to.array.test.ult.true.due.to.second.dimension(ptr %start, ptr %high) {
; CHECK-LABEL: @pointer.to.array.test.ult.true.due.to.second.dimension(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds [10 x i8], ptr [[START:%.*]], i64 5, i64 1
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule ptr [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[START_0:%.*]] = getelementptr inbounds [10 x i8], ptr [[START]], i64 5, i64 0
; CHECK-NEXT:    [[C_0:%.*]] = icmp ult ptr [[START_0]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_0]])
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds [10 x i8], ptr %start, i64 5, i64 1
  %c.1 = icmp ule ptr %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %start.0 = getelementptr inbounds [10 x i8], ptr %start, i64 5, i64 0
  %c.0 = icmp ult ptr %start.0, %high
  call void @use(i1 %c.0)
  ret void

if.end:                                           ; preds = %entry
  ret void
}

define void @pointer.to.array.test.ult.unknown.to.second.dimension(ptr %start, ptr %high) {
; CHECK-LABEL: @pointer.to.array.test.ult.unknown.to.second.dimension(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds [10 x i8], ptr [[START:%.*]], i64 5, i64 0
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule ptr [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[START_0:%.*]] = getelementptr inbounds [10 x i8], ptr [[START]], i64 5, i64 1
; CHECK-NEXT:    [[C_0:%.*]] = icmp ult ptr [[START_0]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_0]])
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds [10 x i8], ptr %start, i64 5, i64 0
  %c.1 = icmp ule ptr %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %start.0 = getelementptr inbounds [10 x i8], ptr %start, i64 5, i64 1
  %c.0 = icmp ult ptr %start.0, %high
  call void @use(i1 %c.0)
  ret void

if.end:                                           ; preds = %entry
  ret void
}

define void @pointer.to.array.test.not.uge.ult(ptr %start, ptr %high) {
; CHECK-LABEL: @pointer.to.array.test.not.uge.ult(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds [10 x i8], ptr [[START:%.*]], i64 1, i64 3
; CHECK-NEXT:    [[C_1:%.*]] = icmp uge ptr [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    [[START_0:%.*]] = getelementptr inbounds [10 x i8], ptr [[START]], i64 10, i64 0
; CHECK-NEXT:    [[C_0:%.*]] = icmp ult ptr [[START_0]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_0]])
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds [10 x i8], ptr %start, i64 1, i64 3
  %c.1 = icmp uge ptr %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  ret void

if.end:                                           ; preds = %entry
  %start.0 = getelementptr inbounds [10 x i8], ptr %start, i64 10, i64 0
  %c.0 = icmp ult ptr %start.0, %high
  call void @use(i1 %c.0)
  ret void
}

define void @pointer.to.array.test.not.uge.ule(ptr %start, ptr %high) {
; CHECK-LABEL: @pointer.to.array.test.not.uge.ule(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds [10 x i8], ptr [[START:%.*]], i64 1, i64 3
; CHECK-NEXT:    [[C:%.*]] = icmp uge ptr [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    [[START_0:%.*]] = getelementptr inbounds [10 x i8], ptr [[START]], i64 10, i64 0
; CHECK-NEXT:    [[C_0:%.*]] = icmp ule ptr [[START_0]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_0]])
; CHECK-NEXT:    [[START_1:%.*]] = getelementptr inbounds [10 x i8], ptr [[START]], i64 2, i64 1
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule ptr [[START_1]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_1]])
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds [10 x i8], ptr %start, i64 1, i64 3
  %c = icmp uge ptr %add.ptr.i, %high
  br i1 %c, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  ret void

if.end:                                           ; preds = %entry
  %start.0 = getelementptr inbounds [10 x i8], ptr %start, i64 10, i64 0
  %c.0 = icmp ule ptr %start.0, %high
  call void @use(i1 %c.0)
  %start.1 = getelementptr inbounds [10 x i8], ptr %start, i64 2, i64 1
  %c.1 = icmp ule ptr %start.1, %high
  call void @use(i1 %c.1)
  ret void
}

define void @pointer.to.array.test.not.uge.ugt(ptr %start, ptr %high) {
; CHECK-LABEL: @pointer.to.array.test.not.uge.ugt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds [10 x i8], ptr [[START:%.*]], i64 1, i64 3
; CHECK-NEXT:    [[C:%.*]] = icmp uge ptr [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    [[START_0:%.*]] = getelementptr inbounds [10 x i8], ptr [[START]], i64 3, i64 0
; CHECK-NEXT:    [[C_0:%.*]] = icmp ugt ptr [[START_0]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_0]])
; CHECK-NEXT:    [[START_1:%.*]] = getelementptr inbounds [10 x i8], ptr [[START]], i64 3, i64 1
; CHECK-NEXT:    [[C_1:%.*]] = icmp ugt ptr [[START_1]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_1]])
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds [10 x i8], ptr %start, i64 1, i64 3
  %c = icmp uge ptr %add.ptr.i, %high
  br i1 %c, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  ret void

if.end:                                           ; preds = %entry
  %start.0 = getelementptr inbounds [10 x i8], ptr %start, i64 3, i64 0
  %c.0 = icmp ugt ptr %start.0, %high
  call void @use(i1 %c.0)
  %start.1 = getelementptr inbounds [10 x i8], ptr %start, i64 3, i64 1
  %c.1 = icmp ugt ptr %start.1, %high
  call void @use(i1 %c.1)
  ret void
}

define void @pointer.to.array.test.not.uge.uge(ptr %start, ptr %high) {
; CHECK-LABEL: @pointer.to.array.test.not.uge.uge(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds [10 x i8], ptr [[START:%.*]], i64 1, i64 3
; CHECK-NEXT:    [[C_1:%.*]] = icmp uge ptr [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    [[START_0:%.*]] = getelementptr inbounds [10 x i8], ptr [[START]], i64 3, i64 0
; CHECK-NEXT:    [[C_0:%.*]] = icmp uge ptr [[START_0]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_0]])
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds [10 x i8], ptr %start, i64 1, i64 3
  %c.1 = icmp uge ptr %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  ret void

if.end:                                           ; preds = %entry
  %start.0 = getelementptr inbounds [10 x i8], ptr %start, i64 3, i64 0
  %c.0 = icmp uge ptr %start.0, %high
  call void @use(i1 %c.0)
  ret void
}

declare void @use(i1)
