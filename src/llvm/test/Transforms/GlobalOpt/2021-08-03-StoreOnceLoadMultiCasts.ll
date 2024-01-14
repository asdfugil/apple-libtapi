; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=globalopt -S < %s | FileCheck %s
; RUN: opt -passes=globalopt -S < %s | FileCheck %s

@g = internal global i32* null, align 8

define signext i32 @f() local_unnamed_addr {
; CHECK-LABEL: @f(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @f1()
; CHECK-NEXT:    store i32 1, i32* bitcast ([4 x i8]* @g.body to i32*), align 4
; CHECK-NEXT:    call void @f1()
; CHECK-NEXT:    store i8 2, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @g.body, i32 0, i32 0), align 4
; CHECK-NEXT:    ret i32 1
;
entry:
  %call = call i8* @malloc(i64 4)
  %b = bitcast i8* %call to i32*
  store i32* %b, i32** @g, align 8
  call void @f1()
  %0 = load i32*, i32** @g, align 8
  store i32 1, i32* %0, align 4
  call void @f1()
  %1 = load i8*, i8** bitcast (i32** @g to i8**), align 8
  store i8 2, i8* %1, align 4
  ret i32 1
}

define signext i32 @main() {
; CHECK-LABEL: @main(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = call signext i32 @f()
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* bitcast ([4 x i8]* @g.body to i32*), align 4
; CHECK-NEXT:    ret i32 [[TMP0]]
;
entry:
  %call = call signext i32 @f()
  %0 = load i32*, i32** @g, align 8
  %1 = load i32, i32* %0, align 4
  ret i32 %1
}

declare noalias align 16 i8* @malloc(i64) allockind("alloc,uninitialized") allocsize(0)
declare void @f1()
