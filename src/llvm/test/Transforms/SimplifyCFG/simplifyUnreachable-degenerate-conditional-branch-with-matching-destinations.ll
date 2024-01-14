; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -simplifycfg -simplifycfg-require-and-preserve-domtree=1 < %s | FileCheck %s

@global = external global i16, align 1
@global.1 = external global i16, align 1
@global.2 = external global i16, align 1

define void @widget() {
; CHECK-LABEL: @widget(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    unreachable
;
bb:
  %i = load i16, i16* @global, align 1
  %i13 = icmp ne i16 %i, 0
  br i1 %i13, label %bb16, label %bb14

bb14:                                             ; preds = %bb
  %i15 = load i16, i16* @global.1, align 1
  br label %bb23

bb16:                                             ; preds = %bb
  %i17 = load i16, i16* @global, align 1
  %i18 = sdiv i16 2, %i17
  %i19 = icmp ne i16 %i18, 0
  %i20 = zext i1 %i19 to i16
  %i21 = load i16, i16* @global.1, align 1
  br i1 %i19, label %bb22, label %bb23

bb22:                                             ; preds = %bb16
  br label %bb23

bb23:                                             ; preds = %bb22, %bb16, %bb14
  %i24 = phi i16 [ %i20, %bb22 ], [ %i21, %bb16 ], [ %i15, %bb14 ]
  store i16 %i24, i16* @global.2, align 1
  unreachable
}
