; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -S %s | FileCheck %s
target datalayout = "p:32:32"


define i1 @alloca_argument_compare(i64* %arg) {
; CHECK-LABEL: @alloca_argument_compare(
; CHECK-NEXT:    ret i1 false
;
  %alloc = alloca i64
  %cmp = icmp eq i64* %arg, %alloc
  ret i1 %cmp
}

define i1 @alloca_argument_compare_swapped(i64* %arg) {
; CHECK-LABEL: @alloca_argument_compare_swapped(
; CHECK-NEXT:    ret i1 false
;
  %alloc = alloca i64
  %cmp = icmp eq i64* %alloc, %arg
  ret i1 %cmp
}

define i1 @alloca_argument_compare_ne(i64* %arg) {
; CHECK-LABEL: @alloca_argument_compare_ne(
; CHECK-NEXT:    ret i1 true
;
  %alloc = alloca i64
  %cmp = icmp ne i64* %arg, %alloc
  ret i1 %cmp
}

define i1 @alloca_argument_compare_derived_ptrs(i64* %arg, i64 %x) {
; CHECK-LABEL: @alloca_argument_compare_derived_ptrs(
; CHECK-NEXT:    ret i1 false
;
  %alloc = alloca i64, i64 8
  %p = getelementptr i64, i64* %arg, i64 %x
  %q = getelementptr i64, i64* %alloc, i64 3
  %cmp = icmp eq i64* %p, %q
  ret i1 %cmp
}

declare void @escape(i64*)
define i1 @alloca_argument_compare_escaped_alloca(i64* %arg) {
; CHECK-LABEL: @alloca_argument_compare_escaped_alloca(
; CHECK-NEXT:    [[ALLOC:%.*]] = alloca i64, align 8
; CHECK-NEXT:    call void @escape(i64* nonnull [[ALLOC]])
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64* [[ALLOC]], [[ARG:%.*]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %alloc = alloca i64
  call void @escape(i64* %alloc)
  %cmp = icmp eq i64* %alloc, %arg
  ret i1 %cmp
}

declare void @check_compares(i1, i1)
define void @alloca_argument_compare_two_compares(i64* %p) {
; CHECK-LABEL: @alloca_argument_compare_two_compares(
; CHECK-NEXT:    [[Q1:%.*]] = alloca [8 x i64], align 8
; CHECK-NEXT:    [[Q1_SUB:%.*]] = getelementptr inbounds [8 x i64], [8 x i64]* [[Q1]], i32 0, i32 0
; CHECK-NEXT:    [[R:%.*]] = getelementptr i64, i64* [[P:%.*]], i32 1
; CHECK-NEXT:    [[S:%.*]] = getelementptr inbounds [8 x i64], [8 x i64]* [[Q1]], i32 0, i32 2
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i64* [[Q1_SUB]], [[P]]
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i64* [[R]], [[S]]
; CHECK-NEXT:    call void @check_compares(i1 [[CMP1]], i1 [[CMP2]])
; CHECK-NEXT:    ret void
;
  %q = alloca i64, i64 8
  %r = getelementptr i64, i64* %p, i64 1
  %s = getelementptr i64, i64* %q, i64 2
  %cmp1 = icmp eq i64* %p, %q
  %cmp2 = icmp eq i64* %r, %s
  call void @check_compares(i1 %cmp1, i1 %cmp2)
  ret void
  ; We will only fold if there is a single cmp.
}

define i1 @alloca_argument_compare_escaped_through_store(i64* %arg, i64** %ptr) {
; CHECK-LABEL: @alloca_argument_compare_escaped_through_store(
; CHECK-NEXT:    [[ALLOC:%.*]] = alloca i64, align 8
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64* [[ALLOC]], [[ARG:%.*]]
; CHECK-NEXT:    [[P:%.*]] = getelementptr inbounds i64, i64* [[ALLOC]], i32 1
; CHECK-NEXT:    store i64* [[P]], i64** [[PTR:%.*]], align 4
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %alloc = alloca i64
  %cmp = icmp eq i64* %alloc, %arg
  %p = getelementptr i64, i64* %alloc, i64 1
  store i64* %p, i64** %ptr
  ret i1 %cmp
}

declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture)
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture)
define i1 @alloca_argument_compare_benign_instrs(i8* %arg) {
; CHECK-LABEL: @alloca_argument_compare_benign_instrs(
; CHECK-NEXT:    ret i1 false
;
  %alloc = alloca i8
  call void @llvm.lifetime.start.p0i8(i64 1, i8* %alloc)
  %cmp = icmp eq i8* %arg, %alloc
  %x = load i8, i8* %arg
  store i8 %x, i8* %alloc
  call void @llvm.lifetime.end.p0i8(i64 1, i8* %alloc)
  ret i1 %cmp
}

declare i64* @allocator()
define i1 @alloca_call_compare() {
; CHECK-LABEL: @alloca_call_compare(
; CHECK-NEXT:    [[Q:%.*]] = call i64* @allocator()
; CHECK-NEXT:    ret i1 false
;
  %p = alloca i64
  %q = call i64* @allocator()
  %cmp = icmp eq i64* %p, %q
  ret i1 %cmp
}


; The next block of tests demonstrate a very subtle correctness requirement.
; We can generally assume any *single* stack layout we chose for the result of
; an alloca, but we can't simultanious assume two different ones.  As a
; result, we must make sure that we only fold conditions if we can ensure that
; we fold *all* potentially address capturing compares the same.

; These two functions represents either a) forging a pointer via inttoptr or
; b) indexing off an adjacent allocation.  In either case, the operation is
; obscured by an uninlined helper and not visible to instcombine.
declare i8* @hidden_inttoptr()
declare i8* @hidden_offset(i8* %other)

define i1 @ptrtoint_single_cmp() {
; CHECK-LABEL: @ptrtoint_single_cmp(
; CHECK-NEXT:    ret i1 false
;
  %m = alloca i8, i32 4
  %rhs = inttoptr i64 2048 to i8*
  %cmp = icmp eq i8* %m, %rhs
  ret i1 %cmp
}

define i1 @offset_single_cmp() {
; CHECK-LABEL: @offset_single_cmp(
; CHECK-NEXT:    ret i1 false
;
  %m = alloca i8, i32 4
  %n = alloca i8, i32 4
  %rhs = getelementptr i8, i8* %n, i32 4
  %cmp = icmp eq i8* %m, %rhs
  ret i1 %cmp
}

declare void @witness(i1, i1)

define void @neg_consistent_fold1() {
; CHECK-LABEL: @neg_consistent_fold1(
; CHECK-NEXT:    [[M1:%.*]] = alloca [4 x i8], align 1
; CHECK-NEXT:    [[M1_SUB:%.*]] = getelementptr inbounds [4 x i8], [4 x i8]* [[M1]], i32 0, i32 0
; CHECK-NEXT:    [[RHS2:%.*]] = call i8* @hidden_inttoptr()
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i8* [[M1_SUB]], inttoptr (i64 2048 to i8*)
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i8* [[M1_SUB]], [[RHS2]]
; CHECK-NEXT:    call void @witness(i1 [[CMP1]], i1 [[CMP2]])
; CHECK-NEXT:    ret void
;
  %m = alloca i8, i32 4
  %rhs = inttoptr i64 2048 to i8*
  %rhs2 = call i8* @hidden_inttoptr()
  %cmp1 = icmp eq i8* %m, %rhs
  %cmp2 = icmp eq i8* %m, %rhs2
  call void @witness(i1 %cmp1, i1 %cmp2)
  ret void
}

define void @neg_consistent_fold2() {
; CHECK-LABEL: @neg_consistent_fold2(
; CHECK-NEXT:    [[M1:%.*]] = alloca [4 x i8], align 1
; CHECK-NEXT:    [[N2:%.*]] = alloca [4 x i8], align 1
; CHECK-NEXT:    [[N2_SUB:%.*]] = getelementptr inbounds [4 x i8], [4 x i8]* [[N2]], i32 0, i32 0
; CHECK-NEXT:    [[M1_SUB:%.*]] = getelementptr inbounds [4 x i8], [4 x i8]* [[M1]], i32 0, i32 0
; CHECK-NEXT:    [[RHS:%.*]] = getelementptr inbounds [4 x i8], [4 x i8]* [[N2]], i32 0, i32 4
; CHECK-NEXT:    [[RHS2:%.*]] = call i8* @hidden_offset(i8* nonnull [[N2_SUB]])
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i8* [[M1_SUB]], [[RHS]]
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i8* [[M1_SUB]], [[RHS2]]
; CHECK-NEXT:    call void @witness(i1 [[CMP1]], i1 [[CMP2]])
; CHECK-NEXT:    ret void
;
  %m = alloca i8, i32 4
  %n = alloca i8, i32 4
  %rhs = getelementptr i8, i8* %n, i32 4
  %rhs2 = call i8* @hidden_offset(i8* %n)
  %cmp1 = icmp eq i8* %m, %rhs
  %cmp2 = icmp eq i8* %m, %rhs2
  call void @witness(i1 %cmp1, i1 %cmp2)
  ret void
}

define void @neg_consistent_fold3() {
; CHECK-LABEL: @neg_consistent_fold3(
; CHECK-NEXT:    [[M1:%.*]] = alloca i32, align 1
; CHECK-NEXT:    [[M1_SUB:%.*]] = bitcast i32* [[M1]] to i8*
; CHECK-NEXT:    [[LGP:%.*]] = load i32*, i32** @gp, align 8
; CHECK-NEXT:    [[RHS2:%.*]] = call i8* @hidden_inttoptr()
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i32* [[M1]], [[LGP]]
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i8* [[RHS2]], [[M1_SUB]]
; CHECK-NEXT:    call void @witness(i1 [[CMP1]], i1 [[CMP2]])
; CHECK-NEXT:    ret void
;
  %m = alloca i8, i32 4
  %bc = bitcast i8* %m to i32*
  %lgp = load i32*, i32** @gp, align 8
  %rhs2 = call i8* @hidden_inttoptr()
  %cmp1 = icmp eq i32* %bc, %lgp
  %cmp2 = icmp eq i8* %m, %rhs2
  call void @witness(i1 %cmp1, i1 %cmp2)
  ret void
}

define void @neg_consistent_fold4() {
; CHECK-LABEL: @neg_consistent_fold4(
; CHECK-NEXT:    call void @witness(i1 false, i1 false)
; CHECK-NEXT:    ret void
;
  %m = alloca i8, i32 4
  %bc = bitcast i8* %m to i32*
  %lgp = load i32*, i32** @gp, align 8
  %cmp1 = icmp eq i32* %bc, %lgp
  %cmp2 = icmp eq i32* %bc, %lgp
  call void @witness(i1 %cmp1, i1 %cmp2)
  ret void
}

; A nocapture call can't cause a consistent result issue as it is (by
; assumption) not able to contain a comparison which might capture the
; address.

declare void @unknown(i8*)

; TODO: Missing optimization
define i1 @consistent_nocapture_inttoptr() {
; CHECK-LABEL: @consistent_nocapture_inttoptr(
; CHECK-NEXT:    [[M1:%.*]] = alloca [4 x i8], align 1
; CHECK-NEXT:    [[M1_SUB:%.*]] = getelementptr inbounds [4 x i8], [4 x i8]* [[M1]], i32 0, i32 0
; CHECK-NEXT:    call void @unknown(i8* nocapture nonnull [[M1_SUB]])
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8* [[M1_SUB]], inttoptr (i64 2048 to i8*)
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %m = alloca i8, i32 4
  call void @unknown(i8* nocapture %m)
  %rhs = inttoptr i64 2048 to i8*
  %cmp = icmp eq i8* %m, %rhs
  ret i1 %cmp
}

define i1 @consistent_nocapture_offset() {
; CHECK-LABEL: @consistent_nocapture_offset(
; CHECK-NEXT:    [[M1:%.*]] = alloca [4 x i8], align 1
; CHECK-NEXT:    [[M1_SUB:%.*]] = getelementptr inbounds [4 x i8], [4 x i8]* [[M1]], i32 0, i32 0
; CHECK-NEXT:    call void @unknown(i8* nocapture nonnull [[M1_SUB]])
; CHECK-NEXT:    ret i1 false
;
  %m = alloca i8, i32 4
  call void @unknown(i8* nocapture %m)
  %n = alloca i8, i32 4
  %rhs = getelementptr i8, i8* %n, i32 4
  %cmp = icmp eq i8* %m, %rhs
  ret i1 %cmp
}

@gp = global i32* null, align 8
; TODO: Missing optimization
define i1 @consistent_nocapture_through_global() {
; CHECK-LABEL: @consistent_nocapture_through_global(
; CHECK-NEXT:    [[M1:%.*]] = alloca i32, align 1
; CHECK-NEXT:    [[M1_SUB:%.*]] = bitcast i32* [[M1]] to i8*
; CHECK-NEXT:    call void @unknown(i8* nocapture nonnull [[M1_SUB]])
; CHECK-NEXT:    [[LGP:%.*]] = load i32*, i32** @gp, align 8, !nonnull !0
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32* [[M1]], [[LGP]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %m = alloca i8, i32 4
  call void @unknown(i8* nocapture %m)
  %bc = bitcast i8* %m to i32*
  %lgp = load i32*, i32** @gp, align 8, !nonnull !{}
  %cmp = icmp eq i32* %bc, %lgp
  ret i1 %cmp
}
