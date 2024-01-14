; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -inline < %s | FileCheck %s

; This tests cases where instructions in the callee are simplified to
; instructions in the caller, thus making VMap contain instructions from
; the caller. We should not be assigning incorrect noalias metadata in
; that case.

declare { i64* } @opaque_callee()

define { i64* } @callee(i64* %x) {
; CHECK-LABEL: @callee(
; CHECK-NEXT:    [[RES:%.*]] = insertvalue { i64* } undef, i64* [[X:%.*]], 0
; CHECK-NEXT:    ret { i64* } [[RES]]
;
  %res = insertvalue { i64* } undef, i64* %x, 0
  ret { i64* } %res
}

; @opaque_callee() should not receive noalias metadata here.
define void @caller() {
; CHECK-LABEL: @caller(
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !0)
; CHECK-NEXT:    [[S:%.*]] = call { i64* } @opaque_callee()
; CHECK-NEXT:    [[X:%.*]] = extractvalue { i64* } [[S]], 0
; CHECK-NEXT:    ret void
;
  call void @llvm.experimental.noalias.scope.decl(metadata !0)
  %s = call { i64* } @opaque_callee()
  %x = extractvalue { i64* } %s, 0
  call { i64* } @callee(i64* %x), !noalias !0
  ret void
}

; @opaque_callee() should no the same noalias metadata as the load from the
; else branch, not as the load in the if branch.
define { i64* } @self_caller(i1 %c, i64* %a) {
; CHECK-LABEL: @self_caller(
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !0)
; CHECK-NEXT:    br i1 [[C:%.*]], label [[IF:%.*]], label [[ELSE:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[S:%.*]] = call { i64* } @opaque_callee(), !noalias !0
; CHECK-NEXT:    [[X:%.*]] = extractvalue { i64* } [[S]], 0
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata !3)
; CHECK-NEXT:    [[TMP1:%.*]] = load volatile i64, i64* [[X]], align 4, !alias.scope !3
; CHECK-NEXT:    ret { i64* } [[S]]
; CHECK:       else:
; CHECK-NEXT:    [[R2:%.*]] = insertvalue { i64* } undef, i64* [[A:%.*]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = load volatile i64, i64* [[A]], align 4, !alias.scope !0
; CHECK-NEXT:    ret { i64* } [[R2]]
;
  call void @llvm.experimental.noalias.scope.decl(metadata !0)
  br i1 %c, label %if, label %else

if:
  %s = call { i64* } @opaque_callee(), !noalias !0
  %x = extractvalue { i64* } %s, 0
  %r = call { i64* } @self_caller(i1 false, i64* %x)
  ret { i64* } %r

else:
  %r2 = insertvalue { i64* } undef, i64* %a, 0
  load volatile i64, i64* %a, !alias.scope !0
  ret { i64* } %r2
}

declare void @llvm.experimental.noalias.scope.decl(metadata)

!0 = !{!1}
!1 = !{!1, !2, !"scope"}
!2 = !{!2, !"domain"}
