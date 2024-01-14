; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -aggressive-instcombine -S < %s | FileCheck %s

;; C reproducers:
;; #include "stdio.h"
;; unsigned x;
;;
;; int test ()
;; {
;;  static const char table[32] =
;;    {
;;      0, 1, 28, 2, 29, 14, 24, 3, 30, 22, 20, 15, 25, 17, 4, 8,
;;      31, 27, 13, 23, 21, 19, 16, 7, 26, 12, 18, 6, 11, 5, 10, 9
;;    };
;;  return table[((unsigned)((x & -x) * 0x077CB531U)) >> 27];
;; }
;;

@x = global i32 0, align 4
@.str = private constant [3 x i8] c"%u\00", align 1
@test.table = internal constant [32 x i8] c"\00\01\1C\02\1D\0E\18\03\1E\16\14\0F\19\11\04\08\1F\1B\0D\17\15\13\10\07\1A\0C\12\06\0B\05\0A\09", align 1

define i32 @test() {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* @x, align 4
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.cttz.i32(i32 [[TMP0]], i1 true)
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[TMP0]], 0
; CHECK-NEXT:    [[TMP3:%.*]] = select i1 [[TMP2]], i32 0, i32 [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = trunc i32 [[TMP3]] to i8
; CHECK-NEXT:    [[CONV:%.*]] = zext i8 [[TMP4]] to i32
; CHECK-NEXT:    ret i32 [[CONV]]
;
entry:
  %0 = load i32, i32* @x, align 4
  %sub = sub i32 0, %0
  %and = and i32 %0, %sub
  %mul = mul i32 %and, 125613361
  %shr = lshr i32 %mul, 27
  %idxprom = zext i32 %shr to i64
  %arrayidx = getelementptr inbounds [32 x i8], [32 x i8]* @test.table, i64 0, i64 %idxprom
  %1 = load i8, i8* %arrayidx, align 1
  %conv = zext i8 %1 to i32
  ret i32 %conv
}
