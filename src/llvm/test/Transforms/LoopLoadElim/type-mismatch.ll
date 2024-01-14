; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -loop-load-elim -S < %s | FileCheck %s

; If the store and the load use different types, but have the same
; size then we should still be able to forward the value.
;
;   for (unsigned i = 0; i < 100; i++) {
;     A[i+1] = B[i] + 2;
;     C[i] = ((float*)A)[i] * 2;
;   }

target datalayout = "e-m:o-p64:64:64-i64:64-f80:128-n8:16:32:64-S128"

define void @f(i32* noalias %A, i32* noalias %B, i32* noalias %C, i64 %N) {
; CHECK-LABEL: @f(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A1:%.*]] = bitcast i32* [[A:%.*]] to float*
; CHECK-NEXT:    [[LOAD_INITIAL:%.*]] = load float, float* [[A1]], align 4
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[STORE_FORWARDED:%.*]] = phi float [ [[LOAD_INITIAL]], [[ENTRY:%.*]] ], [ [[STORE_FORWARD_CAST:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[ENTRY]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[AIDX_NEXT:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[INDVARS_IV_NEXT]]
; CHECK-NEXT:    [[BIDX:%.*]] = getelementptr inbounds i32, i32* [[B:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[CIDX:%.*]] = getelementptr inbounds i32, i32* [[C:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[AIDX:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[AIDX_FLOAT:%.*]] = bitcast i32* [[AIDX]] to float*
; CHECK-NEXT:    [[B:%.*]] = load i32, i32* [[BIDX]], align 4
; CHECK-NEXT:    [[A_P1:%.*]] = add i32 [[B]], 2
; CHECK-NEXT:    [[STORE_FORWARD_CAST]] = bitcast i32 [[A_P1]] to float
; CHECK-NEXT:    store i32 [[A_P1]], i32* [[AIDX_NEXT]], align 4
; CHECK-NEXT:    [[A:%.*]] = load float, float* [[AIDX_FLOAT]], align 4
; CHECK-NEXT:    [[C:%.*]] = fmul float [[STORE_FORWARDED]], 2.000000e+00
; CHECK-NEXT:    [[C_INT:%.*]] = fptosi float [[C]] to i32
; CHECK-NEXT:    store i32 [[C_INT]], i32* [[CIDX]], align 4
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1

  %Aidx_next = getelementptr inbounds i32, i32* %A, i64 %indvars.iv.next
  %Bidx = getelementptr inbounds i32, i32* %B, i64 %indvars.iv
  %Cidx = getelementptr inbounds i32, i32* %C, i64 %indvars.iv
  %Aidx = getelementptr inbounds i32, i32* %A, i64 %indvars.iv
  %Aidx.float = bitcast i32* %Aidx to float*

  %b = load i32, i32* %Bidx, align 4
  %a_p1 = add i32 %b, 2
  store i32 %a_p1, i32* %Aidx_next, align 4

  %a = load float, float* %Aidx.float, align 4
  %c = fmul float %a, 2.0
  %c.int = fptosi float %c to i32
  store i32 %c.int, i32* %Cidx, align 4

  %exitcond = icmp eq i64 %indvars.iv.next, %N
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; If the store and the load use different types, but have the same
; size then we should still be able to forward the value.
;
;   for (unsigned i = 0; i < 100; i++) {
;     A[i+1] = B[i] + 2;
;     A[i+1] = B[i] + 3;
;     C[i] = ((float*)A)[i] * 2;
;   }

define void @f2(i32* noalias %A, i32* noalias %B, i32* noalias %C, i64 %N) {
; CHECK-LABEL: @f2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A1:%.*]] = bitcast i32* [[A:%.*]] to float*
; CHECK-NEXT:    [[LOAD_INITIAL:%.*]] = load float, float* [[A1]], align 4
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[STORE_FORWARDED:%.*]] = phi float [ [[LOAD_INITIAL]], [[ENTRY:%.*]] ], [ [[STORE_FORWARD_CAST:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[ENTRY]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[AIDX_NEXT:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[INDVARS_IV_NEXT]]
; CHECK-NEXT:    [[BIDX:%.*]] = getelementptr inbounds i32, i32* [[B:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[CIDX:%.*]] = getelementptr inbounds i32, i32* [[C:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[AIDX:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[AIDX_FLOAT:%.*]] = bitcast i32* [[AIDX]] to float*
; CHECK-NEXT:    [[B:%.*]] = load i32, i32* [[BIDX]], align 4
; CHECK-NEXT:    [[A_P2:%.*]] = add i32 [[B]], 2
; CHECK-NEXT:    store i32 [[A_P2]], i32* [[AIDX_NEXT]], align 4
; CHECK-NEXT:    [[A_P3:%.*]] = add i32 [[B]], 3
; CHECK-NEXT:    [[STORE_FORWARD_CAST]] = bitcast i32 [[A_P3]] to float
; CHECK-NEXT:    store i32 [[A_P3]], i32* [[AIDX_NEXT]], align 4
; CHECK-NEXT:    [[A:%.*]] = load float, float* [[AIDX_FLOAT]], align 4
; CHECK-NEXT:    [[C:%.*]] = fmul float [[STORE_FORWARDED]], 2.000000e+00
; CHECK-NEXT:    [[C_INT:%.*]] = fptosi float [[C]] to i32
; CHECK-NEXT:    store i32 [[C_INT]], i32* [[CIDX]], align 4
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1

  %Aidx_next = getelementptr inbounds i32, i32* %A, i64 %indvars.iv.next
  %Bidx = getelementptr inbounds i32, i32* %B, i64 %indvars.iv
  %Cidx = getelementptr inbounds i32, i32* %C, i64 %indvars.iv
  %Aidx = getelementptr inbounds i32, i32* %A, i64 %indvars.iv
  %Aidx.float = bitcast i32* %Aidx to float*

  %b = load i32, i32* %Bidx, align 4
  %a_p2 = add i32 %b, 2
  store i32 %a_p2, i32* %Aidx_next, align 4

  %a_p3 = add i32 %b, 3
  store i32 %a_p3, i32* %Aidx_next, align 4

  %a = load float, float* %Aidx.float, align 4
  %c = fmul float %a, 2.0
  %c.int = fptosi float %c to i32
  store i32 %c.int, i32* %Cidx, align 4

  %exitcond = icmp eq i64 %indvars.iv.next, %N
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; Check that we can forward between pointer-sized integers and actual
; pointers.

define void @f3(i64* noalias %A, i64* noalias %B, i64* noalias %C, i64 %N) {
; CHECK-LABEL: @f3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A1:%.*]] = bitcast i64* [[A:%.*]] to i8**
; CHECK-NEXT:    [[LOAD_INITIAL:%.*]] = load i8*, i8** [[A1]], align 8
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[STORE_FORWARDED:%.*]] = phi i8* [ [[LOAD_INITIAL]], [[ENTRY:%.*]] ], [ [[STORE_FORWARD_CAST:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[ENTRY]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[AIDX_NEXT:%.*]] = getelementptr inbounds i64, i64* [[A]], i64 [[INDVARS_IV_NEXT]]
; CHECK-NEXT:    [[BIDX:%.*]] = getelementptr inbounds i64, i64* [[B:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[CIDX:%.*]] = getelementptr inbounds i64, i64* [[C:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[AIDX:%.*]] = getelementptr inbounds i64, i64* [[A]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[AIDX_I8P:%.*]] = bitcast i64* [[AIDX]] to i8**
; CHECK-NEXT:    [[B:%.*]] = load i64, i64* [[BIDX]], align 8
; CHECK-NEXT:    [[A_P1:%.*]] = add i64 [[B]], 2
; CHECK-NEXT:    [[STORE_FORWARD_CAST]] = inttoptr i64 [[A_P1]] to i8*
; CHECK-NEXT:    store i64 [[A_P1]], i64* [[AIDX_NEXT]], align 8
; CHECK-NEXT:    [[A:%.*]] = load i8*, i8** [[AIDX_I8P]], align 8
; CHECK-NEXT:    [[C:%.*]] = getelementptr i8, i8* [[STORE_FORWARDED]], i64 57
; CHECK-NEXT:    [[C_I64P:%.*]] = ptrtoint i8* [[C]] to i64
; CHECK-NEXT:    store i64 [[C_I64P]], i64* [[CIDX]], align 8
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1

  %Aidx_next = getelementptr inbounds i64, i64* %A, i64 %indvars.iv.next
  %Bidx = getelementptr inbounds i64, i64* %B, i64 %indvars.iv
  %Cidx = getelementptr inbounds i64, i64* %C, i64 %indvars.iv
  %Aidx = getelementptr inbounds i64, i64* %A, i64 %indvars.iv
  %Aidx.i8p = bitcast i64* %Aidx to i8**

  %b = load i64, i64* %Bidx, align 8
  %a_p1 = add i64 %b, 2
  store i64 %a_p1, i64* %Aidx_next, align 8

  %a = load i8*, i8** %Aidx.i8p, align 8
  %c = getelementptr i8, i8* %a, i64 57
  %c.i64p = ptrtoint i8* %c to i64
  store i64 %c.i64p, i64* %Cidx, align 8

  %exitcond = icmp eq i64 %indvars.iv.next, %N
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; If the store and the load use different types, but have the same
; size then we should still be able to forward the value--also for
; vector types.
;
;   for (unsigned i = 0; i < 100; i++) {
;     A[i+1] = B[i] + 2;
;     C[i] = ((float*)A)[i] * 2;
;   }

define void @f4(i32* noalias %A, i32* noalias %B, i32* noalias %C, i64 %N) {
; CHECK-LABEL: @f4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A1:%.*]] = bitcast i32* [[A:%.*]] to <2 x half>*
; CHECK-NEXT:    [[LOAD_INITIAL:%.*]] = load <2 x half>, <2 x half>* [[A1]], align 4
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[STORE_FORWARDED:%.*]] = phi <2 x half> [ [[LOAD_INITIAL]], [[ENTRY:%.*]] ], [ [[STORE_FORWARD_CAST:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[ENTRY]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[AIDX_NEXT:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[INDVARS_IV_NEXT]]
; CHECK-NEXT:    [[BIDX:%.*]] = getelementptr inbounds i32, i32* [[B:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[CIDX:%.*]] = getelementptr inbounds i32, i32* [[C:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[AIDX:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[AIDX_FLOAT:%.*]] = bitcast i32* [[AIDX]] to <2 x half>*
; CHECK-NEXT:    [[B:%.*]] = load i32, i32* [[BIDX]], align 4
; CHECK-NEXT:    [[A_P1:%.*]] = add i32 [[B]], 2
; CHECK-NEXT:    [[STORE_FORWARD_CAST]] = bitcast i32 [[A_P1]] to <2 x half>
; CHECK-NEXT:    store i32 [[A_P1]], i32* [[AIDX_NEXT]], align 4
; CHECK-NEXT:    [[A:%.*]] = load <2 x half>, <2 x half>* [[AIDX_FLOAT]], align 4
; CHECK-NEXT:    [[C:%.*]] = fmul <2 x half> [[STORE_FORWARDED]], <half 0xH4000, half 0xH4000>
; CHECK-NEXT:    [[C_INT:%.*]] = bitcast <2 x half> [[C]] to i32
; CHECK-NEXT:    store i32 [[C_INT]], i32* [[CIDX]], align 4
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1

  %Aidx_next = getelementptr inbounds i32, i32* %A, i64 %indvars.iv.next
  %Bidx = getelementptr inbounds i32, i32* %B, i64 %indvars.iv
  %Cidx = getelementptr inbounds i32, i32* %C, i64 %indvars.iv
  %Aidx = getelementptr inbounds i32, i32* %A, i64 %indvars.iv
  %Aidx.float = bitcast i32* %Aidx to <2 x half>*

  %b = load i32, i32* %Bidx, align 4
  %a_p1 = add i32 %b, 2
  store i32 %a_p1, i32* %Aidx_next, align 4

  %a = load <2 x half>, <2 x half>* %Aidx.float, align 4
  %c = fmul <2 x half> %a, <half 2.0, half 2.0>
  %c.int = bitcast <2 x half> %c to i32
  store i32 %c.int, i32* %Cidx, align 4

  %exitcond = icmp eq i64 %indvars.iv.next, %N
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; Check that we don't forward between integers and actual
; pointers if sizes don't match.

define void @f5(i32* noalias %A, i32* noalias %B, i32* noalias %C, i64 %N) {
; CHECK-LABEL: @f5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[AIDX_NEXT:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i64 [[INDVARS_IV_NEXT]]
; CHECK-NEXT:    [[BIDX:%.*]] = getelementptr inbounds i32, i32* [[B:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[CIDX:%.*]] = getelementptr inbounds i32, i32* [[C:%.*]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[AIDX:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[AIDX_I8P:%.*]] = bitcast i32* [[AIDX]] to i8**
; CHECK-NEXT:    [[B:%.*]] = load i32, i32* [[BIDX]], align 4
; CHECK-NEXT:    [[A_P1:%.*]] = add i32 [[B]], 2
; CHECK-NEXT:    store i32 [[A_P1]], i32* [[AIDX_NEXT]], align 4
; CHECK-NEXT:    [[A:%.*]] = load i8*, i8** [[AIDX_I8P]], align 8
; CHECK-NEXT:    [[C:%.*]] = getelementptr i8, i8* [[A]], i32 57
; CHECK-NEXT:    [[C_I64P:%.*]] = ptrtoint i8* [[C]] to i32
; CHECK-NEXT:    store i32 [[C_I64P]], i32* [[CIDX]], align 4
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1

  %Aidx_next = getelementptr inbounds i32, i32* %A, i64 %indvars.iv.next
  %Bidx = getelementptr inbounds i32, i32* %B, i64 %indvars.iv
  %Cidx = getelementptr inbounds i32, i32* %C, i64 %indvars.iv
  %Aidx = getelementptr inbounds i32, i32* %A, i64 %indvars.iv
  %Aidx.i8p = bitcast i32* %Aidx to i8**

  %b = load i32, i32* %Bidx, align 4
  %a_p1 = add i32 %b, 2
  store i32 %a_p1, i32* %Aidx_next, align 4

  %a = load i8*, i8** %Aidx.i8p, align 8
  %c = getelementptr i8, i8* %a, i32 57
  %c.i64p = ptrtoint i8* %c to i32
  store i32 %c.i64p, i32* %Cidx, align 4

  %exitcond = icmp eq i64 %indvars.iv.next, %N
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}
