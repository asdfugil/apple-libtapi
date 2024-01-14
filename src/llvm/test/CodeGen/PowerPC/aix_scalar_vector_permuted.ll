; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mcpu=pwr8 -verify-machineinstrs -ppc-vsr-nums-as-vr \
; RUN:   -ppc-asm-full-reg-names -mtriple=powerpc64-ibm-aix-xcoff < %s | \
; RUN: FileCheck %s --check-prefix=AIX-P8-64
; RUN: llc -mcpu=pwr8 -verify-machineinstrs -ppc-vsr-nums-as-vr \
; RUN:   -ppc-asm-full-reg-names -mtriple=powerpc-ibm-aix-xcoff < %s | \
; RUN: FileCheck %s --check-prefix=AIX-P8-32
; RUN: llc -mcpu=pwr9 -verify-machineinstrs -ppc-vsr-nums-as-vr \
; RUN:   -ppc-asm-full-reg-names -mtriple=powerpc64-ibm-aix-xcoff < %s | \
; RUN: FileCheck %s --check-prefix=AIX-P9-64
; RUN: llc -mcpu=pwr9 -verify-machineinstrs -ppc-vsr-nums-as-vr \
; RUN:   -ppc-asm-full-reg-names -mtriple=powerpc-ibm-aix-xcoff < %s | \
; RUN: FileCheck %s --check-prefix=AIX-P9-32

%d8 = type <8 x double>
%f1 = type <1 x float>
%f2 = type <2 x float>
%f4 = type <4 x float>
%f8 = type <8 x float>
%i4 = type <4 x i32>

define void @test_f2(ptr %P, ptr %Q, ptr %S) {
; AIX-P8-64-LABEL: test_f2:
; AIX-P8-64:       # %bb.0:
; AIX-P8-64-NEXT:    lfdx f0, 0, r3
; AIX-P8-64-NEXT:    lfdx f1, 0, r4
; AIX-P8-64-NEXT:    xvaddsp vs0, vs0, vs1
; AIX-P8-64-NEXT:    stfdx f0, 0, r5
; AIX-P8-64-NEXT:    blr
;
; AIX-P8-32-LABEL: test_f2:
; AIX-P8-32:       # %bb.0:
; AIX-P8-32-NEXT:    li r6, 4
; AIX-P8-32-NEXT:    lxsiwzx v3, 0, r3
; AIX-P8-32-NEXT:    lxsiwzx v5, 0, r4
; AIX-P8-32-NEXT:    lxsiwzx v2, r3, r6
; AIX-P8-32-NEXT:    lxsiwzx v4, r4, r6
; AIX-P8-32-NEXT:    vmrgow v2, v3, v2
; AIX-P8-32-NEXT:    vmrgow v3, v5, v4
; AIX-P8-32-NEXT:    xvaddsp vs0, v2, v3
; AIX-P8-32-NEXT:    xxsldwi vs1, vs0, vs0, 1
; AIX-P8-32-NEXT:    xscvspdpn f0, vs0
; AIX-P8-32-NEXT:    xscvspdpn f1, vs1
; AIX-P8-32-NEXT:    stfs f0, 0(r5)
; AIX-P8-32-NEXT:    stfs f1, 4(r5)
; AIX-P8-32-NEXT:    blr
;
; AIX-P9-64-LABEL: test_f2:
; AIX-P9-64:       # %bb.0:
; AIX-P9-64-NEXT:    lfd f0, 0(r3)
; AIX-P9-64-NEXT:    lfd f1, 0(r4)
; AIX-P9-64-NEXT:    xvaddsp vs0, vs0, vs1
; AIX-P9-64-NEXT:    stfd f0, 0(r5)
; AIX-P9-64-NEXT:    blr
;
; AIX-P9-32-LABEL: test_f2:
; AIX-P9-32:       # %bb.0:
; AIX-P9-32-NEXT:    li r6, 4
; AIX-P9-32-NEXT:    lxsiwzx v3, 0, r3
; AIX-P9-32-NEXT:    lxsiwzx v4, 0, r4
; AIX-P9-32-NEXT:    lxsiwzx v2, r3, r6
; AIX-P9-32-NEXT:    vmrgow v2, v3, v2
; AIX-P9-32-NEXT:    lxsiwzx v3, r4, r6
; AIX-P9-32-NEXT:    vmrgow v3, v4, v3
; AIX-P9-32-NEXT:    xvaddsp vs0, v2, v3
; AIX-P9-32-NEXT:    xscvspdpn f1, vs0
; AIX-P9-32-NEXT:    xxsldwi vs0, vs0, vs0, 1
; AIX-P9-32-NEXT:    xscvspdpn f0, vs0
; AIX-P9-32-NEXT:    stfs f1, 0(r5)
; AIX-P9-32-NEXT:    stfs f0, 4(r5)
; AIX-P9-32-NEXT:    blr
  %p = load %f2, ptr %P
  %q = load %f2, ptr %Q
  %R = fadd %f2 %p, %q
  store %f2 %R, ptr %S
  ret void
}

