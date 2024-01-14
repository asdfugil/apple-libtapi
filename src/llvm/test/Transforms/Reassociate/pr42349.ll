; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -reassociate -S | FileCheck %s

define  float @wibble(float %tmp6) #0 {
; CHECK-LABEL: @wibble(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP7:%.*]] = fmul float [[TMP6:%.*]], -1.000000e+00
; CHECK-NEXT:    [[TMP9:%.*]] = fmul fast float [[TMP6]], 0xFFF0000000000000
; CHECK-NEXT:    ret float [[TMP9]]
;
bb:
  %tmp7 = fsub float -0.000000e+00, %tmp6
  %tmp9 = fmul fast float %tmp7, 0x7FF0000000000000
  ret float %tmp9
}

attributes #0 = { "use-soft-float"="false" }
