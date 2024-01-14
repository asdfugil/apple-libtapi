// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -no-opaque-pointers -triple x86_64-unknown-linux-gnu -std=c++11 -emit-llvm -o - %s | FileCheck %s

struct A {
  A();
  A(const A&);
  ~A();
};

struct B {
  B();
  B(const B&);
  ~B();
};

struct C {
  C();
  C(const C&);
  ~C();
};

struct D {
  D();
  D(const D&);
  ~D();

  B *begin();
  B *end();
};

B *begin(C&);
B *end(C&);

extern B array[5];

// CHECK-LABEL: @_Z9for_arrayv(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A:%.*]] = alloca [[STRUCT_A:%.*]], align 1
// CHECK-NEXT:    [[__RANGE1:%.*]] = alloca [5 x %struct.B]*, align 8
// CHECK-NEXT:    [[__BEGIN1:%.*]] = alloca %struct.B*, align 8
// CHECK-NEXT:    [[__END1:%.*]] = alloca %struct.B*, align 8
// CHECK-NEXT:    [[B:%.*]] = alloca [[STRUCT_B:%.*]], align 1
// CHECK-NEXT:    call void @_ZN1AC1Ev(%struct.A* noundef nonnull align 1 dereferenceable(1) [[A]])
// CHECK-NEXT:    store [5 x %struct.B]* @array, [5 x %struct.B]** [[__RANGE1]], align 8
// CHECK-NEXT:    store %struct.B* getelementptr inbounds ([5 x %struct.B], [5 x %struct.B]* @array, i64 0, i64 0), %struct.B** [[__BEGIN1]], align 8
// CHECK-NEXT:    store %struct.B* getelementptr inbounds ([5 x %struct.B], [5 x %struct.B]* @array, i64 1, i64 0), %struct.B** [[__END1]], align 8
// CHECK-NEXT:    br label [[FOR_COND:%.*]]
// CHECK:       for.cond:
// CHECK-NEXT:    [[TMP0:%.*]] = load %struct.B*, %struct.B** [[__BEGIN1]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load %struct.B*, %struct.B** [[__END1]], align 8
// CHECK-NEXT:    [[CMP:%.*]] = icmp ne %struct.B* [[TMP0]], [[TMP1]]
// CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY:%.*]], label [[FOR_END:%.*]]
// CHECK:       for.body:
// CHECK-NEXT:    [[TMP2:%.*]] = load %struct.B*, %struct.B** [[__BEGIN1]], align 8
// CHECK-NEXT:    call void @_ZN1BC1ERKS_(%struct.B* noundef nonnull align 1 dereferenceable(1) [[B]], %struct.B* noundef nonnull align 1 dereferenceable(1) [[TMP2]])
// CHECK-NEXT:    call void @_ZN1BD1Ev(%struct.B* noundef nonnull align 1 dereferenceable(1) [[B]]) #[[ATTR3:[0-9]+]]
// CHECK-NEXT:    br label [[FOR_INC:%.*]]
// CHECK:       for.inc:
// CHECK-NEXT:    [[TMP3:%.*]] = load %struct.B*, %struct.B** [[__BEGIN1]], align 8
// CHECK-NEXT:    [[INCDEC_PTR:%.*]] = getelementptr inbounds [[STRUCT_B]], %struct.B* [[TMP3]], i32 1
// CHECK-NEXT:    store %struct.B* [[INCDEC_PTR]], %struct.B** [[__BEGIN1]], align 8
// CHECK-NEXT:    br label [[FOR_COND]]
// CHECK:       for.end:
// CHECK-NEXT:    call void @_ZN1AD1Ev(%struct.A* noundef nonnull align 1 dereferenceable(1) [[A]]) #[[ATTR3]]
// CHECK-NEXT:    ret void
//
void for_array() {
  A a;
  for (B b : array) {
  }
}

// CHECK-LABEL: @_Z9for_rangev(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A:%.*]] = alloca [[STRUCT_A:%.*]], align 1
// CHECK-NEXT:    [[__RANGE1:%.*]] = alloca %struct.C*, align 8
// CHECK-NEXT:    [[REF_TMP:%.*]] = alloca [[STRUCT_C:%.*]], align 1
// CHECK-NEXT:    [[__BEGIN1:%.*]] = alloca %struct.B*, align 8
// CHECK-NEXT:    [[__END1:%.*]] = alloca %struct.B*, align 8
// CHECK-NEXT:    [[B:%.*]] = alloca [[STRUCT_B:%.*]], align 1
// CHECK-NEXT:    call void @_ZN1AC1Ev(%struct.A* noundef nonnull align 1 dereferenceable(1) [[A]])
// CHECK-NEXT:    call void @_ZN1CC1Ev(%struct.C* noundef nonnull align 1 dereferenceable(1) [[REF_TMP]])
// CHECK-NEXT:    store %struct.C* [[REF_TMP]], %struct.C** [[__RANGE1]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load %struct.C*, %struct.C** [[__RANGE1]], align 8
// CHECK-NEXT:    [[CALL:%.*]] = call noundef %struct.B* @_Z5beginR1C(%struct.C* noundef nonnull align 1 dereferenceable(1) [[TMP0]])
// CHECK-NEXT:    store %struct.B* [[CALL]], %struct.B** [[__BEGIN1]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load %struct.C*, %struct.C** [[__RANGE1]], align 8
// CHECK-NEXT:    [[CALL1:%.*]] = call noundef %struct.B* @_Z3endR1C(%struct.C* noundef nonnull align 1 dereferenceable(1) [[TMP1]])
// CHECK-NEXT:    store %struct.B* [[CALL1]], %struct.B** [[__END1]], align 8
// CHECK-NEXT:    br label [[FOR_COND:%.*]]
// CHECK:       for.cond:
// CHECK-NEXT:    [[TMP2:%.*]] = load %struct.B*, %struct.B** [[__BEGIN1]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load %struct.B*, %struct.B** [[__END1]], align 8
// CHECK-NEXT:    [[CMP:%.*]] = icmp ne %struct.B* [[TMP2]], [[TMP3]]
// CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY:%.*]], label [[FOR_COND_CLEANUP:%.*]]
// CHECK:       for.cond.cleanup:
// CHECK-NEXT:    call void @_ZN1CD1Ev(%struct.C* noundef nonnull align 1 dereferenceable(1) [[REF_TMP]]) #[[ATTR3]]
// CHECK-NEXT:    br label [[FOR_END:%.*]]
// CHECK:       for.body:
// CHECK-NEXT:    [[TMP4:%.*]] = load %struct.B*, %struct.B** [[__BEGIN1]], align 8
// CHECK-NEXT:    call void @_ZN1BC1ERKS_(%struct.B* noundef nonnull align 1 dereferenceable(1) [[B]], %struct.B* noundef nonnull align 1 dereferenceable(1) [[TMP4]])
// CHECK-NEXT:    call void @_ZN1BD1Ev(%struct.B* noundef nonnull align 1 dereferenceable(1) [[B]]) #[[ATTR3]]
// CHECK-NEXT:    br label [[FOR_INC:%.*]]
// CHECK:       for.inc:
// CHECK-NEXT:    [[TMP5:%.*]] = load %struct.B*, %struct.B** [[__BEGIN1]], align 8
// CHECK-NEXT:    [[INCDEC_PTR:%.*]] = getelementptr inbounds [[STRUCT_B]], %struct.B* [[TMP5]], i32 1
// CHECK-NEXT:    store %struct.B* [[INCDEC_PTR]], %struct.B** [[__BEGIN1]], align 8
// CHECK-NEXT:    br label [[FOR_COND]]
// CHECK:       for.end:
// CHECK-NEXT:    call void @_ZN1AD1Ev(%struct.A* noundef nonnull align 1 dereferenceable(1) [[A]]) #[[ATTR3]]
// CHECK-NEXT:    ret void
//
void for_range() {
  A a;
  for (B b : C()) {
  }
}

// CHECK-LABEL: @_Z16for_member_rangev(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A:%.*]] = alloca [[STRUCT_A:%.*]], align 1
// CHECK-NEXT:    [[__RANGE1:%.*]] = alloca %struct.D*, align 8
// CHECK-NEXT:    [[REF_TMP:%.*]] = alloca [[STRUCT_D:%.*]], align 1
// CHECK-NEXT:    [[__BEGIN1:%.*]] = alloca %struct.B*, align 8
// CHECK-NEXT:    [[__END1:%.*]] = alloca %struct.B*, align 8
// CHECK-NEXT:    [[B:%.*]] = alloca [[STRUCT_B:%.*]], align 1
// CHECK-NEXT:    call void @_ZN1AC1Ev(%struct.A* noundef nonnull align 1 dereferenceable(1) [[A]])
// CHECK-NEXT:    call void @_ZN1DC1Ev(%struct.D* noundef nonnull align 1 dereferenceable(1) [[REF_TMP]])
// CHECK-NEXT:    store %struct.D* [[REF_TMP]], %struct.D** [[__RANGE1]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load %struct.D*, %struct.D** [[__RANGE1]], align 8
// CHECK-NEXT:    [[CALL:%.*]] = call noundef %struct.B* @_ZN1D5beginEv(%struct.D* noundef nonnull align 1 dereferenceable(1) [[TMP0]])
// CHECK-NEXT:    store %struct.B* [[CALL]], %struct.B** [[__BEGIN1]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load %struct.D*, %struct.D** [[__RANGE1]], align 8
// CHECK-NEXT:    [[CALL1:%.*]] = call noundef %struct.B* @_ZN1D3endEv(%struct.D* noundef nonnull align 1 dereferenceable(1) [[TMP1]])
// CHECK-NEXT:    store %struct.B* [[CALL1]], %struct.B** [[__END1]], align 8
// CHECK-NEXT:    br label [[FOR_COND:%.*]]
// CHECK:       for.cond:
// CHECK-NEXT:    [[TMP2:%.*]] = load %struct.B*, %struct.B** [[__BEGIN1]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load %struct.B*, %struct.B** [[__END1]], align 8
// CHECK-NEXT:    [[CMP:%.*]] = icmp ne %struct.B* [[TMP2]], [[TMP3]]
// CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY:%.*]], label [[FOR_COND_CLEANUP:%.*]]
// CHECK:       for.cond.cleanup:
// CHECK-NEXT:    call void @_ZN1DD1Ev(%struct.D* noundef nonnull align 1 dereferenceable(1) [[REF_TMP]]) #[[ATTR3]]
// CHECK-NEXT:    br label [[FOR_END:%.*]]
// CHECK:       for.body:
// CHECK-NEXT:    [[TMP4:%.*]] = load %struct.B*, %struct.B** [[__BEGIN1]], align 8
// CHECK-NEXT:    call void @_ZN1BC1ERKS_(%struct.B* noundef nonnull align 1 dereferenceable(1) [[B]], %struct.B* noundef nonnull align 1 dereferenceable(1) [[TMP4]])
// CHECK-NEXT:    call void @_ZN1BD1Ev(%struct.B* noundef nonnull align 1 dereferenceable(1) [[B]]) #[[ATTR3]]
// CHECK-NEXT:    br label [[FOR_INC:%.*]]
// CHECK:       for.inc:
// CHECK-NEXT:    [[TMP5:%.*]] = load %struct.B*, %struct.B** [[__BEGIN1]], align 8
// CHECK-NEXT:    [[INCDEC_PTR:%.*]] = getelementptr inbounds [[STRUCT_B]], %struct.B* [[TMP5]], i32 1
// CHECK-NEXT:    store %struct.B* [[INCDEC_PTR]], %struct.B** [[__BEGIN1]], align 8
// CHECK-NEXT:    br label [[FOR_COND]]
// CHECK:       for.end:
// CHECK-NEXT:    call void @_ZN1AD1Ev(%struct.A* noundef nonnull align 1 dereferenceable(1) [[A]]) #[[ATTR3]]
// CHECK-NEXT:    ret void
//
void for_member_range() {
  A a;
  for (B b : D()) {
  }
}
