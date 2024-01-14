; Test f128 comparisons on z14.
;
; RUN: llc < %s -mtriple=s390x-linux-gnu -mcpu=z14 | FileCheck %s

; There is no memory form of 128-bit comparison.
define i64 @f1(i64 %a, i64 %b, ptr %ptr1, ptr %ptr2) {
; CHECK-LABEL: f1:
; CHECK-DAG: vl [[REG1:%v[0-9]+]], 0(%r4)
; CHECK-DAG: vl [[REG2:%v[0-9]+]], 0(%r5)
; CHECK: wfcxb [[REG1]], [[REG2]]
; CHECK-NEXT: locgrne %r2, %r3
; CHECK: br %r14
  %f1 = load fp128, ptr %ptr1
  %f2 = load fp128, ptr %ptr2
  %cond = fcmp oeq fp128 %f1, %f2
  %res = select i1 %cond, i64 %a, i64 %b
  ret i64 %res
}

; Check comparison with zero -- it is not worthwhile to copy to
; FP pairs just so we can use LTXBR, so simply load up a zero.
define i64 @f2(i64 %a, i64 %b, ptr %ptr) {
; CHECK-LABEL: f2:
; CHECK-DAG: vl [[REG1:%v[0-9]+]], 0(%r4)
; CHECK-DAG: vzero [[REG2:%v[0-9]+]]
; CHECK: wfcxb [[REG1]], [[REG2]]
; CHECK-NEXT: locgrne %r2, %r3
; CHECK: br %r14
  %f = load fp128, ptr %ptr
  %cond = fcmp oeq fp128 %f, 0xL00000000000000000000000000000000
  %res = select i1 %cond, i64 %a, i64 %b
  ret i64 %res
}
