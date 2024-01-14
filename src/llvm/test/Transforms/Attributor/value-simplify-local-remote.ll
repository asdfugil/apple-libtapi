; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=6 -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

; Most reduced from the OpenMC app running OpenMP offloading code, caused crashes before as we
; mixed local and remote (=intra and inter procedural) values.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

%S = type { ptr }
%S.2 = type { ptr, i64, i64 }
%struct1 = type { %struct2 }
%struct2 = type <{ ptr, i64, i64, i32, [4 x i8] }>

define i64 @t1(ptr %first, ptr %first.addr, ptr %0) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn writeonly
; TUNIT-LABEL: define {{[^@]+}}@t1
; TUNIT-SAME: (ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[FIRST:%.*]], ptr nocapture nofree readnone [[FIRST_ADDR:%.*]], ptr nocapture nofree readnone [[TMP0:%.*]]) #[[ATTR0:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[FIRST_ADDR1:%.*]] = alloca ptr, i32 0, align 8
; TUNIT-NEXT:    store ptr [[FIRST]], ptr [[FIRST]], align 8
; TUNIT-NEXT:    br label [[IF_END:%.*]]
; TUNIT:       if.end:
; TUNIT-NEXT:    [[CALL:%.*]] = call ptr @foo.4(ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[FIRST]]) #[[ATTR3:[0-9]+]]
; TUNIT-NEXT:    ret i64 0
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind willreturn writeonly
; CGSCC-LABEL: define {{[^@]+}}@t1
; CGSCC-SAME: (ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[FIRST:%.*]], ptr nocapture nofree readnone [[FIRST_ADDR:%.*]], ptr nocapture nofree readnone [[TMP0:%.*]]) #[[ATTR0:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[FIRST_ADDR1:%.*]] = alloca ptr, i32 0, align 8
; CGSCC-NEXT:    store ptr [[FIRST]], ptr [[FIRST]], align 8
; CGSCC-NEXT:    br label [[IF_END:%.*]]
; CGSCC:       if.end:
; CGSCC-NEXT:    [[CALL:%.*]] = call ptr @foo.4(ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[FIRST]]) #[[ATTR6:[0-9]+]]
; CGSCC-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds double, ptr [[CALL]], i64 -1
; CGSCC-NEXT:    ret i64 0
;
entry:
  %first.addr1 = alloca ptr, i32 0, align 8
  store ptr %first, ptr %first, align 8
  br label %if.end

if.end:                                           ; preds = %entry
  %1 = load ptr, ptr %first, align 8
  %call = call ptr @foo.4(ptr %first)
  %add.ptr = getelementptr inbounds double, ptr %call, i64 -1
  ret i64 0
}

define internal ptr @foo.4(ptr %__first) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn writeonly
; TUNIT-LABEL: define {{[^@]+}}@foo.4
; TUNIT-SAME: (ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[__FIRST:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[__FIRST_ADDR:%.*]] = alloca ptr, i32 0, align 8
; TUNIT-NEXT:    store ptr [[__FIRST]], ptr [[__FIRST]], align 8
; TUNIT-NEXT:    ret ptr undef
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind willreturn writeonly
; CGSCC-LABEL: define {{[^@]+}}@foo.4
; CGSCC-SAME: (ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[__FIRST:%.*]]) #[[ATTR0]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[__FIRST_ADDR:%.*]] = alloca ptr, i32 0, align 8
; CGSCC-NEXT:    store ptr [[__FIRST]], ptr [[__FIRST]], align 8
; CGSCC-NEXT:    [[CALL1:%.*]] = call noalias noundef nonnull align 8 dereferenceable(8) ptr @bar(ptr noalias nofree noundef nonnull readnone align 8 dereferenceable(8) [[__FIRST]]) #[[ATTR7:[0-9]+]]
; CGSCC-NEXT:    ret ptr [[CALL1]]
;
entry:
  %__first.addr = alloca ptr, i32 0, align 8
  store ptr %__first, ptr %__first, align 8
  %0 = load ptr, ptr %__first, align 8
  %call1 = call ptr @bar(ptr %__first)
  ret ptr %call1
}

define internal ptr @bar(ptr %QQfirst) {
; CGSCC: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@bar
; CGSCC-SAME: (ptr noalias nofree noundef nonnull readnone returned align 8 dereferenceable(8) "no-capture-maybe-returned" [[QQFIRST:%.*]]) #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[QQFIRST_ADDR:%.*]] = alloca ptr, i32 0, align 8
; CGSCC-NEXT:    store ptr [[QQFIRST]], ptr [[QQFIRST_ADDR]], align 8
; CGSCC-NEXT:    br label [[WHILE_COND:%.*]]
; CGSCC:       while.cond:
; CGSCC-NEXT:    br label [[WHILE_END:%.*]]
; CGSCC:       while.end:
; CGSCC-NEXT:    ret ptr [[QQFIRST]]
;
entry:
  %QQfirst.addr = alloca ptr, i32 0, align 8
  store ptr %QQfirst, ptr %QQfirst.addr, align 8
  br label %while.cond

while.cond:                                       ; preds = %entry
  br label %while.end

while.end:                                        ; preds = %while.cond
  %0 = load ptr, ptr %QQfirst.addr, align 8
  ret ptr %0
}

define ptr @t2(ptr %this, ptr %this.addr, ptr %this1) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn
; TUNIT-LABEL: define {{[^@]+}}@t2
; TUNIT-SAME: (ptr nofree noundef nonnull align 8 dereferenceable(8) [[THIS:%.*]], ptr nocapture nofree readnone [[THIS_ADDR:%.*]], ptr nocapture nofree readnone [[THIS1:%.*]]) #[[ATTR1:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    store ptr [[THIS]], ptr [[THIS]], align 8
; TUNIT-NEXT:    [[CALL:%.*]] = call [[S:%.*]] @foo.1(ptr nofree noundef nonnull align 8 dereferenceable(8) [[THIS]]) #[[ATTR4:[0-9]+]]
; TUNIT-NEXT:    [[TEST_RET:%.*]] = extractvalue [[S]] [[CALL]], 0
; TUNIT-NEXT:    ret ptr [[TEST_RET]]
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind willreturn
; CGSCC-LABEL: define {{[^@]+}}@t2
; CGSCC-SAME: (ptr nofree noundef nonnull align 8 dereferenceable(8) [[THIS:%.*]], ptr nocapture nofree readnone [[THIS_ADDR:%.*]], ptr nocapture nofree readnone [[THIS1:%.*]]) #[[ATTR2:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    store ptr [[THIS]], ptr [[THIS]], align 8
; CGSCC-NEXT:    [[CALL:%.*]] = call [[S:%.*]] @foo.1(ptr nofree noundef nonnull align 8 dereferenceable(8) [[THIS]]) #[[ATTR8:[0-9]+]]
; CGSCC-NEXT:    [[TEST_RET:%.*]] = extractvalue [[S]] [[CALL]], 0
; CGSCC-NEXT:    ret ptr [[TEST_RET]]
;
entry:
  store ptr %this, ptr %this, align 8
  %this12 = load ptr, ptr %this, align 8
  %call = call %S @foo.1(ptr %this)
  %test.ret = extractvalue %S %call, 0
  ret ptr %test.ret
}

define internal %S @foo.1(ptr %foo.this) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn
; TUNIT-LABEL: define {{[^@]+}}@foo.1
; TUNIT-SAME: (ptr nofree noundef nonnull align 8 dereferenceable(8) [[FOO_THIS:%.*]]) #[[ATTR1]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[RETVAL:%.*]] = alloca [[S:%.*]], i32 0, align 8
; TUNIT-NEXT:    store ptr [[FOO_THIS]], ptr [[FOO_THIS]], align 8
; TUNIT-NEXT:    call void @bar.2(ptr noalias nocapture nofree noundef nonnull writeonly align 8 [[RETVAL]], ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[FOO_THIS]]) #[[ATTR5:[0-9]+]]
; TUNIT-NEXT:    [[FOO_RET:%.*]] = load [[S]], ptr [[RETVAL]], align 8
; TUNIT-NEXT:    ret [[S]] [[FOO_RET]]
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind willreturn
; CGSCC-LABEL: define {{[^@]+}}@foo.1
; CGSCC-SAME: (ptr nofree noundef nonnull align 8 dereferenceable(8) [[FOO_THIS:%.*]]) #[[ATTR2]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[RETVAL:%.*]] = alloca [[S:%.*]], i32 0, align 8
; CGSCC-NEXT:    store ptr [[FOO_THIS]], ptr [[FOO_THIS]], align 8
; CGSCC-NEXT:    call void @bar.2(ptr noalias nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[RETVAL]], ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[FOO_THIS]]) #[[ATTR6]]
; CGSCC-NEXT:    [[FOO_RET:%.*]] = load [[S]], ptr [[RETVAL]], align 8
; CGSCC-NEXT:    ret [[S]] [[FOO_RET]]
;
entry:
  %retval = alloca %S, i32 0, align 8
  store ptr %foo.this, ptr %foo.this, align 8
  call void @bar.2(ptr %retval, ptr %foo.this)
  %foo.ret = load %S, ptr %retval, align 8
  ret %S %foo.ret
}

define internal void @bar.2(ptr %bar.this, ptr %bar.data) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn writeonly
; TUNIT-LABEL: define {{[^@]+}}@bar.2
; TUNIT-SAME: (ptr noalias nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[BAR_THIS:%.*]], ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[BAR_DATA:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    store ptr [[BAR_DATA]], ptr [[BAR_THIS]], align 8
; TUNIT-NEXT:    call void @baz(ptr nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[BAR_THIS]], ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[BAR_DATA]]) #[[ATTR5]]
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind willreturn writeonly
; CGSCC-LABEL: define {{[^@]+}}@bar.2
; CGSCC-SAME: (ptr noalias nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[BAR_THIS:%.*]], ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[BAR_DATA:%.*]]) #[[ATTR0]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    store ptr [[BAR_DATA]], ptr [[BAR_THIS]], align 8
; CGSCC-NEXT:    call void @baz(ptr nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[BAR_THIS]], ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[BAR_DATA]]) #[[ATTR6]]
; CGSCC-NEXT:    ret void
;
entry:
  store ptr %bar.data, ptr %bar.this, align 8
  call void @baz(ptr %bar.this, ptr %bar.data)
  ret void
}

define internal void @baz(ptr %baz.this, ptr %baz.data) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn writeonly
; TUNIT-LABEL: define {{[^@]+}}@baz
; TUNIT-SAME: (ptr nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[BAZ_THIS:%.*]], ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[BAZ_DATA:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    store ptr [[BAZ_DATA]], ptr [[BAZ_THIS]], align 8
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn writeonly
; CGSCC-LABEL: define {{[^@]+}}@baz
; CGSCC-SAME: (ptr nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[BAZ_THIS:%.*]], ptr nofree writeonly [[BAZ_DATA:%.*]]) #[[ATTR3:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    store ptr [[BAZ_DATA]], ptr [[BAZ_THIS]], align 8
; CGSCC-NEXT:    ret void
;
entry:
  store ptr %baz.data, ptr %baz.this, align 8
  ret void
}

define ptr @foo(ptr %this, ptr %this.addr, ptr %this1) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn
; TUNIT-LABEL: define {{[^@]+}}@foo
; TUNIT-SAME: (ptr nofree noundef nonnull align 8 dereferenceable(8) [[THIS:%.*]], ptr nocapture nofree readnone [[THIS_ADDR:%.*]], ptr nocapture nofree readnone [[THIS1:%.*]]) #[[ATTR1]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    store ptr [[THIS]], ptr [[THIS]], align 8
; TUNIT-NEXT:    [[CALL:%.*]] = call [[S:%.*]] @bar.5(ptr nofree noundef nonnull align 8 dereferenceable(8) [[THIS]]) #[[ATTR4]]
; TUNIT-NEXT:    [[FOO_RET:%.*]] = extractvalue [[S]] [[CALL]], 0
; TUNIT-NEXT:    ret ptr [[FOO_RET]]
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind willreturn
; CGSCC-LABEL: define {{[^@]+}}@foo
; CGSCC-SAME: (ptr nofree noundef nonnull align 8 dereferenceable(8) [[THIS:%.*]], ptr nocapture nofree readnone [[THIS_ADDR:%.*]], ptr nocapture nofree readnone [[THIS1:%.*]]) #[[ATTR2]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    store ptr [[THIS]], ptr [[THIS]], align 8
; CGSCC-NEXT:    [[CALL:%.*]] = call [[S:%.*]] @bar.5(ptr nofree noundef nonnull align 8 dereferenceable(8) [[THIS]]) #[[ATTR8]]
; CGSCC-NEXT:    [[FOO_RET:%.*]] = extractvalue [[S]] [[CALL]], 0
; CGSCC-NEXT:    ret ptr [[FOO_RET]]
;
entry:
  store ptr %this, ptr %this, align 8
  %this12 = load ptr, ptr %this, align 8
  %call = call %S @bar.5(ptr %this)
  %foo.ret = extractvalue %S %call, 0
  ret ptr %foo.ret
}

define internal %S @bar.5(ptr %this) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn
; TUNIT-LABEL: define {{[^@]+}}@bar.5
; TUNIT-SAME: (ptr nofree noundef nonnull align 8 dereferenceable(8) [[THIS:%.*]]) #[[ATTR1]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[RETVAL:%.*]] = alloca [[S:%.*]], i32 0, align 8
; TUNIT-NEXT:    store ptr [[THIS]], ptr [[THIS]], align 8
; TUNIT-NEXT:    call void @baz.6(ptr noalias nocapture nofree noundef nonnull writeonly align 8 [[RETVAL]], ptr nofree noundef nonnull align 8 dereferenceable(8) [[THIS]]) #[[ATTR4]]
; TUNIT-NEXT:    [[BAR_RET:%.*]] = load [[S]], ptr [[RETVAL]], align 8
; TUNIT-NEXT:    ret [[S]] [[BAR_RET]]
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind willreturn
; CGSCC-LABEL: define {{[^@]+}}@bar.5
; CGSCC-SAME: (ptr nofree noundef nonnull align 8 dereferenceable(8) [[THIS:%.*]]) #[[ATTR2]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[RETVAL:%.*]] = alloca [[S:%.*]], i32 0, align 8
; CGSCC-NEXT:    store ptr [[THIS]], ptr [[THIS]], align 8
; CGSCC-NEXT:    call void @baz.6(ptr noalias nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[RETVAL]], ptr nofree noundef nonnull align 8 dereferenceable(8) [[THIS]]) #[[ATTR8]]
; CGSCC-NEXT:    [[BAR_RET:%.*]] = load [[S]], ptr [[RETVAL]], align 8
; CGSCC-NEXT:    ret [[S]] [[BAR_RET]]
;
entry:
  %retval = alloca %S, i32 0, align 8
  store ptr %this, ptr %this, align 8
  %0 = load ptr, ptr %this, align 8
  call void @baz.6(ptr %retval, ptr %this)
  %bar.ret = load %S, ptr %retval, align 8
  ret %S %bar.ret
}

define internal void @baz.6(ptr %this, ptr %data) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn
; TUNIT-LABEL: define {{[^@]+}}@baz.6
; TUNIT-SAME: (ptr noalias nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS:%.*]], ptr nofree noundef nonnull align 8 dereferenceable(8) [[DATA:%.*]]) #[[ATTR1]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    store ptr [[DATA]], ptr [[THIS]], align 8
; TUNIT-NEXT:    call void @boom(ptr nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS]], ptr nofree noundef nonnull align 8 dereferenceable(8) [[DATA]]) #[[ATTR4]]
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind willreturn
; CGSCC-LABEL: define {{[^@]+}}@baz.6
; CGSCC-SAME: (ptr noalias nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS:%.*]], ptr nofree noundef nonnull align 8 dereferenceable(8) [[DATA:%.*]]) #[[ATTR2]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    store ptr [[DATA]], ptr [[THIS]], align 8
; CGSCC-NEXT:    call void @boom(ptr nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS]], ptr nofree noundef nonnull align 8 dereferenceable(8) [[DATA]]) #[[ATTR8]]
; CGSCC-NEXT:    ret void
;
entry:
  store ptr %data, ptr %this, align 8
  call void @boom(ptr %this, ptr %data)
  ret void
}

define internal void @boom(ptr %this, ptr %data) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn
; TUNIT-LABEL: define {{[^@]+}}@boom
; TUNIT-SAME: (ptr nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS:%.*]], ptr nofree noundef nonnull align 8 dereferenceable(8) [[DATA:%.*]]) #[[ATTR1]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[DATA_ADDR:%.*]] = alloca ptr, i32 0, align 8
; TUNIT-NEXT:    store ptr [[DATA]], ptr [[DATA_ADDR]], align 8
; TUNIT-NEXT:    [[V:%.*]] = load ptr, ptr [[DATA_ADDR]], align 8
; TUNIT-NEXT:    store ptr [[V]], ptr [[THIS]], align 8
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn
; CGSCC-LABEL: define {{[^@]+}}@boom
; CGSCC-SAME: (ptr nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS:%.*]], ptr nofree [[DATA:%.*]]) #[[ATTR4:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[DATA_ADDR:%.*]] = alloca ptr, i32 0, align 8
; CGSCC-NEXT:    store ptr [[DATA]], ptr [[DATA_ADDR]], align 8
; CGSCC-NEXT:    store ptr [[DATA]], ptr [[THIS]], align 8
; CGSCC-NEXT:    ret void
;
entry:
  %data.addr = alloca ptr, i32 0, align 8
  store ptr %data, ptr %data.addr, align 8
  %v = load ptr, ptr %data.addr, align 8
  store ptr %v, ptr %this, align 8
  ret void
}

define weak_odr void @t3() {
; CHECK-LABEL: define {{[^@]+}}@t3() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_target_init(ptr noalias nocapture noundef align 4294967296 null, i8 noundef 0, i1 noundef false, i1 noundef false)
; CHECK-NEXT:    br label [[USER_CODE_ENTRY:%.*]]
; CHECK:       user_code.entry:
; CHECK-NEXT:    br label [[FOR_COND:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[CALL4:%.*]] = call [[S_2:%.*]] @t3.helper()
; CHECK-NEXT:    ret void
;
entry:
  %0 = call i32 @__kmpc_target_init(ptr null, i8 0, i1 false, i1 false)
  br label %user_code.entry

user_code.entry:                                  ; preds = %entry
  br label %for.cond

for.cond:                                         ; preds = %user_code.entry
  br label %for.body

for.body:                                         ; preds = %for.cond
  %call4 = call %S.2 @t3.helper()
  ret void
}

declare i32 @__kmpc_target_init(ptr, i8, i1, i1)

define %S.2 @t3.helper() {
; CHECK-LABEL: define {{[^@]+}}@t3.helper() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RETVAL:%.*]] = alloca [[S_2:%.*]], align 8
; CHECK-NEXT:    call void @ext1(ptr noundef nonnull align 8 dereferenceable(24) [[RETVAL]])
; CHECK-NEXT:    [[DOTFCA_0_LOAD:%.*]] = load ptr, ptr [[RETVAL]], align 8
; CHECK-NEXT:    [[DOTFCA_0_INSERT:%.*]] = insertvalue [[S_2]] poison, ptr [[DOTFCA_0_LOAD]], 0
; CHECK-NEXT:    [[DOTFCA_1_GEP:%.*]] = getelementptr inbounds [[S_2]], ptr [[RETVAL]], i32 0, i32 1
; CHECK-NEXT:    [[DOTFCA_1_LOAD:%.*]] = load i64, ptr [[DOTFCA_1_GEP]], align 8
; CHECK-NEXT:    [[DOTFCA_1_INSERT:%.*]] = insertvalue [[S_2]] [[DOTFCA_0_INSERT]], i64 [[DOTFCA_1_LOAD]], 1
; CHECK-NEXT:    [[DOTFCA_2_GEP:%.*]] = getelementptr inbounds [[S_2]], ptr [[RETVAL]], i32 0, i32 2
; CHECK-NEXT:    [[DOTFCA_2_LOAD:%.*]] = load i64, ptr [[DOTFCA_2_GEP]], align 8
; CHECK-NEXT:    [[DOTFCA_2_INSERT:%.*]] = insertvalue [[S_2]] [[DOTFCA_1_INSERT]], i64 [[DOTFCA_2_LOAD]], 2
; CHECK-NEXT:    ret [[S_2]] zeroinitializer
;
entry:
  %retval = alloca %S.2, align 8
  call void @ext1(ptr %retval)
  %.fca.0.gep = getelementptr inbounds %S.2, ptr %retval, i32 0, i32 0
  %.fca.0.load = load ptr, ptr %.fca.0.gep, align 8
  %.fca.0.insert = insertvalue %S.2 poison, ptr %.fca.0.load, 0
  %.fca.1.gep = getelementptr inbounds %S.2, ptr %retval, i32 0, i32 1
  %.fca.1.load = load i64, ptr %.fca.1.gep, align 8
  %.fca.1.insert = insertvalue %S.2 %.fca.0.insert, i64 %.fca.1.load, 1
  %.fca.2.gep = getelementptr inbounds %S.2, ptr %retval, i32 0, i32 2
  %.fca.2.load = load i64, ptr %.fca.2.gep, align 8
  %.fca.2.insert = insertvalue %S.2 %.fca.1.insert, i64 %.fca.2.load, 2
  ret %S.2 zeroinitializer
}

declare void @ext1(ptr)

; Taken from https://github.com/llvm/llvm-project/issues/54981
define dso_local void @spam() {
; TUNIT: Function Attrs: nofree norecurse noreturn nosync nounwind readnone
; TUNIT-LABEL: define {{[^@]+}}@spam
; TUNIT-SAME: () #[[ATTR2:[0-9]+]] {
; TUNIT-NEXT:  bb:
; TUNIT-NEXT:    [[TMP:%.*]] = alloca i32, align 4
; TUNIT-NEXT:    [[X:%.*]] = fptosi float undef to i32
; TUNIT-NEXT:    store i32 [[X]], ptr [[TMP]], align 4
; TUNIT-NEXT:    br label [[BB16:%.*]]
; TUNIT:       bb16:
; TUNIT-NEXT:    [[TMP18:%.*]] = icmp eq i32 [[X]], 0
; TUNIT-NEXT:    br i1 [[TMP18]], label [[BB35:%.*]], label [[BB19:%.*]]
; TUNIT:       bb19:
; TUNIT-NEXT:    [[TMP21:%.*]] = load float, ptr [[TMP]], align 4
; TUNIT-NEXT:    [[TMP22:%.*]] = fadd fast float [[TMP21]], 0.000000e+00
; TUNIT-NEXT:    br label [[BB23:%.*]]
; TUNIT:       bb23:
; TUNIT-NEXT:    [[TMP24:%.*]] = phi <2 x float> [ undef, [[BB19]] ], [ [[TMP26:%.*]], [[BB34:%.*]] ]
; TUNIT-NEXT:    br label [[BB25:%.*]]
; TUNIT:       bb25:
; TUNIT-NEXT:    [[TMP26]] = phi <2 x float> [ [[TMP30:%.*]], [[BB28:%.*]] ], [ [[TMP24]], [[BB23]] ]
; TUNIT-NEXT:    [[TMP27:%.*]] = icmp ult i32 undef, 8
; TUNIT-NEXT:    br i1 [[TMP27]], label [[BB28]], label [[BB34]]
; TUNIT:       bb28:
; TUNIT-NEXT:    [[TMP29:%.*]] = insertelement <2 x float> [[TMP26]], float undef, i32 0
; TUNIT-NEXT:    [[TMP30]] = insertelement <2 x float> [[TMP29]], float [[TMP22]], i32 1
; TUNIT-NEXT:    br label [[BB25]]
; TUNIT:       bb34:
; TUNIT-NEXT:    br label [[BB23]]
; TUNIT:       bb35:
; TUNIT-NEXT:    unreachable
;
; CGSCC: Function Attrs: nofree norecurse noreturn nosync nounwind readnone
; CGSCC-LABEL: define {{[^@]+}}@spam
; CGSCC-SAME: () #[[ATTR5:[0-9]+]] {
; CGSCC-NEXT:  bb:
; CGSCC-NEXT:    [[TMP:%.*]] = alloca i32, align 4
; CGSCC-NEXT:    [[X:%.*]] = fptosi float undef to i32
; CGSCC-NEXT:    store i32 [[X]], ptr [[TMP]], align 4
; CGSCC-NEXT:    br label [[BB16:%.*]]
; CGSCC:       bb16:
; CGSCC-NEXT:    [[TMP18:%.*]] = icmp eq i32 [[X]], 0
; CGSCC-NEXT:    br i1 [[TMP18]], label [[BB35:%.*]], label [[BB19:%.*]]
; CGSCC:       bb19:
; CGSCC-NEXT:    [[TMP21:%.*]] = load float, ptr [[TMP]], align 4
; CGSCC-NEXT:    [[TMP22:%.*]] = fadd fast float [[TMP21]], 0.000000e+00
; CGSCC-NEXT:    br label [[BB23:%.*]]
; CGSCC:       bb23:
; CGSCC-NEXT:    [[TMP24:%.*]] = phi <2 x float> [ undef, [[BB19]] ], [ [[TMP26:%.*]], [[BB34:%.*]] ]
; CGSCC-NEXT:    br label [[BB25:%.*]]
; CGSCC:       bb25:
; CGSCC-NEXT:    [[TMP26]] = phi <2 x float> [ [[TMP30:%.*]], [[BB28:%.*]] ], [ [[TMP24]], [[BB23]] ]
; CGSCC-NEXT:    [[TMP27:%.*]] = icmp ult i32 undef, 8
; CGSCC-NEXT:    br i1 [[TMP27]], label [[BB28]], label [[BB34]]
; CGSCC:       bb28:
; CGSCC-NEXT:    [[TMP29:%.*]] = insertelement <2 x float> [[TMP26]], float undef, i32 0
; CGSCC-NEXT:    [[TMP30]] = insertelement <2 x float> [[TMP29]], float [[TMP22]], i32 1
; CGSCC-NEXT:    br label [[BB25]]
; CGSCC:       bb34:
; CGSCC-NEXT:    br label [[BB23]]
; CGSCC:       bb35:
; CGSCC-NEXT:    unreachable
;
bb:
  %tmp = alloca i32, align 4
  %tmp12 = getelementptr inbounds i32, ptr %tmp, i64 0
  %tmp15 = getelementptr inbounds i32, ptr %tmp, i64 0
  %x = fptosi float undef to i32
  store i32 %x, ptr %tmp15, align 4
  br label %bb16

bb16:                                             ; preds = %bb
  %tmp17 = load i32, ptr %tmp12, align 4
  %tmp18 = icmp eq i32 %tmp17, 0
  br i1 %tmp18, label %bb35, label %bb19

bb19:                                             ; preds = %bb16
  %y = getelementptr inbounds i32, ptr %tmp, i64 0
  %tmp20 = bitcast ptr %y to ptr
  %tmp21 = load float, ptr %tmp20, align 4
  %tmp22 = fadd fast float %tmp21, 0.000000e+00
  br label %bb23

bb23:                                             ; preds = %bb34, %bb19
  %tmp24 = phi <2 x float> [ undef, %bb19 ], [ %tmp26, %bb34 ]
  br label %bb25

bb25:                                             ; preds = %bb28, %bb23
  %tmp26 = phi <2 x float> [ %tmp30, %bb28 ], [ %tmp24, %bb23 ]
  %tmp27 = icmp ult i32 undef, 8
  br i1 %tmp27, label %bb28, label %bb34

bb28:                                             ; preds = %bb25
  %tmp29 = insertelement <2 x float> %tmp26, float undef, i32 0
  %tmp30 = insertelement <2 x float> %tmp29, float %tmp22, i32 1
  br label %bb25

bb34:                                             ; preds = %bb25
  br label %bb23

bb35:                                             ; preds = %bb16
  unreachable
}

define double @t4(ptr %this, ptr %this.addr, ptr %this1) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn writeonly
; TUNIT-LABEL: define {{[^@]+}}@t4
; TUNIT-SAME: (ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS:%.*]], ptr nocapture nofree readnone [[THIS_ADDR:%.*]], ptr nocapture nofree readnone [[THIS1:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[THIS_ADDR1:%.*]] = alloca ptr, i32 0, align 8
; TUNIT-NEXT:    store ptr [[THIS]], ptr [[THIS]], align 8
; TUNIT-NEXT:    [[CALL:%.*]] = call [[S:%.*]] @t4a(ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS]]) #[[ATTR5]]
; TUNIT-NEXT:    ret double 0.000000e+00
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind willreturn
; CGSCC-LABEL: define {{[^@]+}}@t4
; CGSCC-SAME: (ptr nofree noundef nonnull align 8 dereferenceable(8) [[THIS:%.*]], ptr nocapture nofree readnone [[THIS_ADDR:%.*]], ptr nocapture nofree readnone [[THIS1:%.*]]) #[[ATTR2]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[THIS_ADDR1:%.*]] = alloca ptr, i32 0, align 8
; CGSCC-NEXT:    store ptr [[THIS]], ptr [[THIS]], align 8
; CGSCC-NEXT:    [[CALL:%.*]] = call [[S:%.*]] @t4a(ptr nofree noundef nonnull align 8 dereferenceable(8) [[THIS]]) #[[ATTR8]]
; CGSCC-NEXT:    [[TMP0:%.*]] = extractvalue [[S]] [[CALL]], 0
; CGSCC-NEXT:    ret double 0.000000e+00
;
entry:
  %this.addr1 = alloca ptr, i32 0, align 8
  store ptr %this, ptr %this, align 8
  %this12 = load ptr, ptr %this, align 8
  %call = call %S @t4a(ptr %this)
  %0 = extractvalue %S %call, 0
  ret double 0.000000e+00
}

define internal %S @t4a(ptr %this) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn writeonly
; TUNIT-LABEL: define {{[^@]+}}@t4a
; TUNIT-SAME: (ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[RETVAL:%.*]] = alloca [[S:%.*]], i32 0, align 8
; TUNIT-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, i32 0, align 8
; TUNIT-NEXT:    store ptr [[THIS]], ptr [[THIS]], align 8
; TUNIT-NEXT:    call void @t4b(ptr noalias nocapture nofree noundef nonnull writeonly align 8 [[RETVAL]]) #[[ATTR5]]
; TUNIT-NEXT:    ret [[S]] undef
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind willreturn
; CGSCC-LABEL: define {{[^@]+}}@t4a
; CGSCC-SAME: (ptr nofree noundef nonnull align 8 dereferenceable(8) [[THIS:%.*]]) #[[ATTR2]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[RETVAL:%.*]] = alloca [[S:%.*]], i32 0, align 8
; CGSCC-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, i32 0, align 8
; CGSCC-NEXT:    store ptr [[THIS]], ptr [[THIS]], align 8
; CGSCC-NEXT:    call void @t4b(ptr noalias nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[RETVAL]], ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS]]) #[[ATTR6]]
; CGSCC-NEXT:    [[TMP0:%.*]] = load [[S]], ptr [[RETVAL]], align 8
; CGSCC-NEXT:    ret [[S]] [[TMP0]]
;
entry:
  %retval = alloca %S, i32 0, align 8
  %this.addr = alloca ptr, i32 0, align 8
  store ptr %this, ptr %this, align 8
  %this1 = load ptr, ptr %this, align 8
  %buffer_ = getelementptr inbounds %struct1, ptr %this1, i32 0, i32 0
  %data_ = getelementptr inbounds %struct2, ptr %buffer_, i32 0, i32 0
  %0 = load ptr, ptr %this, align 8
  call void @t4b(ptr %retval, ptr %this)
  %1 = load %S, ptr %retval, align 8
  ret %S %1
}

define internal void @t4b(ptr %this, ptr %data) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn writeonly
; TUNIT-LABEL: define {{[^@]+}}@t4b
; TUNIT-SAME: (ptr noalias nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, i32 0, align 8
; TUNIT-NEXT:    [[DATA_ADDR:%.*]] = alloca ptr, i32 0, align 8
; TUNIT-NEXT:    call void @t4c(ptr noalias nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS]]) #[[ATTR5]]
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind willreturn writeonly
; CGSCC-LABEL: define {{[^@]+}}@t4b
; CGSCC-SAME: (ptr noalias nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS:%.*]], ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[DATA:%.*]]) #[[ATTR0]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, i32 0, align 8
; CGSCC-NEXT:    [[DATA_ADDR:%.*]] = alloca ptr, i32 0, align 8
; CGSCC-NEXT:    store ptr [[DATA]], ptr [[THIS]], align 8
; CGSCC-NEXT:    call void @t4c(ptr nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS]], ptr nofree noundef nonnull writeonly align 8 dereferenceable(8) [[DATA]]) #[[ATTR6]]
; CGSCC-NEXT:    ret void
;
entry:
  %this.addr = alloca ptr, i32 0, align 8
  %data.addr = alloca ptr, i32 0, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %data, ptr %this, align 8
  %this1 = load ptr, ptr %this, align 8
  %0 = load ptr, ptr %this, align 8
  call void @t4c(ptr %this, ptr %data)
  ret void
}

define internal void @t4c(ptr %this, ptr %data) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn writeonly
; TUNIT-LABEL: define {{[^@]+}}@t4c
; TUNIT-SAME: (ptr noalias nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, i32 0, align 8
; TUNIT-NEXT:    [[DATA_ADDR:%.*]] = alloca ptr, i32 0, align 8
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn writeonly
; CGSCC-LABEL: define {{[^@]+}}@t4c
; CGSCC-SAME: (ptr nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[THIS:%.*]], ptr nofree writeonly [[DATA:%.*]]) #[[ATTR3]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, i32 0, align 8
; CGSCC-NEXT:    [[DATA_ADDR:%.*]] = alloca ptr, i32 0, align 8
; CGSCC-NEXT:    store ptr [[DATA]], ptr [[THIS]], align 8
; CGSCC-NEXT:    store ptr [[DATA]], ptr [[THIS]], align 8
; CGSCC-NEXT:    ret void
;
entry:
  %this.addr = alloca ptr, i32 0, align 8
  %data.addr = alloca ptr, i32 0, align 8
  store ptr %this, ptr %this.addr, align 8
  store ptr %data, ptr %this, align 8
  %this1 = load ptr, ptr %this, align 8
  %data_ = getelementptr inbounds %S, ptr %this1, i32 0, i32 0
  %0 = load ptr, ptr %this, align 8
  store ptr %data, ptr %this, align 8
  ret void
}

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 11, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"openmp", i32 50}
!3 = !{i32 7, !"openmp-device", i32 50}
!4 = !{i32 8, !"PIC Level", i32 2}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = !{i32 7, !"Dwarf Version", i32 2}
!7 = !{i32 2, !"Debug Info Version", i32 3}
;.
; TUNIT: attributes #[[ATTR0]] = { argmemonly nofree norecurse nosync nounwind willreturn writeonly }
; TUNIT: attributes #[[ATTR1]] = { argmemonly nofree norecurse nosync nounwind willreturn }
; TUNIT: attributes #[[ATTR2]] = { nofree norecurse noreturn nosync nounwind readnone }
; TUNIT: attributes #[[ATTR3]] = { nofree norecurse nosync nounwind willreturn writeonly }
; TUNIT: attributes #[[ATTR4]] = { nofree nosync nounwind willreturn }
; TUNIT: attributes #[[ATTR5]] = { nofree nosync nounwind willreturn writeonly }
;.
; CGSCC: attributes #[[ATTR0]] = { argmemonly nofree nosync nounwind willreturn writeonly }
; CGSCC: attributes #[[ATTR1]] = { nofree norecurse nosync nounwind readnone willreturn }
; CGSCC: attributes #[[ATTR2]] = { argmemonly nofree nosync nounwind willreturn }
; CGSCC: attributes #[[ATTR3]] = { argmemonly nofree norecurse nosync nounwind willreturn writeonly }
; CGSCC: attributes #[[ATTR4]] = { argmemonly nofree norecurse nosync nounwind willreturn }
; CGSCC: attributes #[[ATTR5]] = { nofree norecurse noreturn nosync nounwind readnone }
; CGSCC: attributes #[[ATTR6]] = { nounwind willreturn writeonly }
; CGSCC: attributes #[[ATTR7]] = { readnone willreturn }
; CGSCC: attributes #[[ATTR8]] = { nounwind willreturn }
;.
; CHECK: [[META0:![0-9]+]] = !{i32 2, !"SDK Version", [2 x i32] [i32 11, i32 5]}
; CHECK: [[META1:![0-9]+]] = !{i32 1, !"wchar_size", i32 4}
; CHECK: [[META2:![0-9]+]] = !{i32 7, !"openmp", i32 50}
; CHECK: [[META3:![0-9]+]] = !{i32 7, !"openmp-device", i32 50}
; CHECK: [[META4:![0-9]+]] = !{i32 8, !"PIC Level", i32 2}
; CHECK: [[META5:![0-9]+]] = !{i32 7, !"frame-pointer", i32 2}
; CHECK: [[META6:![0-9]+]] = !{i32 7, !"Dwarf Version", i32 2}
; CHECK: [[META7:![0-9]+]] = !{i32 2, !"Debug Info Version", i32 3}
;.
