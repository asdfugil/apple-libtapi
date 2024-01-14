; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=sroa < %s | FileCheck %s

%pair = type { i32, i32 }

define i32 @test_sroa_select_gep(i1 %cond) {
; CHECK-LABEL: @test_sroa_select_gep(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[LOAD_SROA_SPECULATED:%.*]] = select i1 [[COND:%.*]], i32 1, i32 2
; CHECK-NEXT:    ret i32 [[LOAD_SROA_SPECULATED]]
;
bb:
  %a = alloca %pair, align 4
  %b = alloca %pair, align 4
  %gep_a = getelementptr inbounds %pair, ptr %a, i32 0, i32 1
  %gep_b = getelementptr inbounds %pair, ptr %b, i32 0, i32 1
  store i32 1, ptr %gep_a, align 4
  store i32 2, ptr %gep_b, align 4
  %select = select i1 %cond, ptr %a, ptr %b
  %gep = getelementptr inbounds %pair, ptr %select, i32 0, i32 1
  %load = load i32, ptr %gep, align 4
  ret i32 %load
}

define i32 @test_sroa_select_gep_non_inbound(i1 %cond) {
; CHECK-LABEL: @test_sroa_select_gep_non_inbound(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[LOAD_SROA_SPECULATED:%.*]] = select i1 [[COND:%.*]], i32 1, i32 2
; CHECK-NEXT:    ret i32 [[LOAD_SROA_SPECULATED]]
;
bb:
  %a = alloca %pair, align 4
  %b = alloca %pair, align 4
  %gep_a = getelementptr %pair, ptr %a, i32 0, i32 1
  %gep_b = getelementptr %pair, ptr %b, i32 0, i32 1
  store i32 1, ptr %gep_a, align 4
  store i32 2, ptr %gep_b, align 4
  %select = select i1 %cond, ptr %a, ptr %b
  %gep = getelementptr %pair, ptr %select, i32 0, i32 1
  %load = load i32, ptr %gep, align 4
  ret i32 %load
}

define i32 @test_sroa_select_gep_volatile_load(i1 %cond) {
; CHECK-LABEL: @test_sroa_select_gep_volatile_load(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[A_SROA_0:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[A_SROA_2:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B_SROA_0:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B_SROA_2:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 11, ptr [[A_SROA_0]], align 4
; CHECK-NEXT:    store i32 12, ptr [[B_SROA_0]], align 4
; CHECK-NEXT:    store i32 21, ptr [[A_SROA_2]], align 4
; CHECK-NEXT:    store i32 22, ptr [[B_SROA_2]], align 4
; CHECK-NEXT:    [[SELECT_SROA_SEL:%.*]] = select i1 [[COND:%.*]], ptr [[A_SROA_0]], ptr [[B_SROA_0]]
; CHECK-NEXT:    [[LOAD1:%.*]] = load volatile i32, ptr [[SELECT_SROA_SEL]], align 4
; CHECK-NEXT:    [[SELECT_SROA_SEL3:%.*]] = select i1 [[COND]], ptr [[A_SROA_2]], ptr [[B_SROA_2]]
; CHECK-NEXT:    [[LOAD2:%.*]] = load volatile i32, ptr [[SELECT_SROA_SEL3]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[LOAD1]], [[LOAD2]]
; CHECK-NEXT:    ret i32 [[ADD]]
;
bb:
  %a = alloca %pair, align 4
  %b = alloca %pair, align 4
  store i32 11, ptr %a, align 4
  store i32 12, ptr %b, align 4
  %gep_a1 = getelementptr inbounds %pair, ptr %a, i32 0, i32 1
  %gep_b1 = getelementptr inbounds %pair, ptr %b, i32 0, i32 1
  store i32 21, ptr %gep_a1, align 4
  store i32 22, ptr %gep_b1, align 4
  %select = select i1 %cond, ptr %a, ptr %b
  %load1 = load volatile i32, ptr %select, align 4
  %gep2 = getelementptr inbounds %pair, ptr %select, i32 0, i32 1
  %load2 = load volatile i32, ptr %gep2, align 4
  %add = add i32 %load1, %load2
  ret i32 %add
}

define i32 @test_sroa_select_gep_poison(i1 %cond) {
; CHECK-LABEL: @test_sroa_select_gep_poison(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[A_SROA_0:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[SELECT_SROA_SEL:%.*]] = select i1 [[COND:%.*]], ptr [[A_SROA_0]], ptr poison
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[SELECT_SROA_SEL]], align 4
; CHECK-NEXT:    ret i32 [[LOAD]]
;
bb:
  %a = alloca %pair, align 4
  %select = select i1 %cond, ptr %a, ptr poison
  %gep = getelementptr inbounds %pair, ptr %select, i32 0, i32 1
  %load = load i32, ptr %gep, align 4
  ret i32 %load
}

define i32 @test_sroa_gep_select_gep(i1 %cond) {
; CHECK-LABEL: @test_sroa_gep_select_gep(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[A_SROA_0:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B_SROA_0:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 1, ptr [[A_SROA_0]], align 4
; CHECK-NEXT:    store i32 2, ptr [[B_SROA_0]], align 4
; CHECK-NEXT:    [[SELECT_SROA_SEL:%.*]] = select i1 [[COND:%.*]], ptr [[A_SROA_0]], ptr [[B_SROA_0]]
; CHECK-NEXT:    [[SELECT2:%.*]] = select i1 [[COND]], ptr [[SELECT_SROA_SEL]], ptr [[A_SROA_0]]
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[SELECT2]], align 4
; CHECK-NEXT:    ret i32 [[LOAD]]
;
bb:
  %a = alloca %pair, align 4
  %b = alloca %pair, align 4
  %gep_a = getelementptr inbounds %pair, ptr %a, i32 0, i32 1
  %gep_b = getelementptr inbounds %pair, ptr %b, i32 0, i32 1
  store i32 1, ptr %gep_a, align 4
  store i32 2, ptr %gep_b, align 4
  %select = select i1 %cond, ptr %gep_a, ptr %gep_b
  %select2 = select i1 %cond, ptr %select, ptr %gep_a
  %load = load i32, ptr %select2, align 4
  ret i32 %load
}

define i32 @test_sroa_gep_select_gep_nonconst_idx(i1 %cond, i32 %idx) {
; CHECK-LABEL: @test_sroa_gep_select_gep_nonconst_idx(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[A:%.*]] = alloca [[PAIR:%.*]], align 4
; CHECK-NEXT:    [[B:%.*]] = alloca [[PAIR]], align 4
; CHECK-NEXT:    [[GEP_A:%.*]] = getelementptr inbounds [[PAIR]], ptr [[A]], i32 0, i32 1
; CHECK-NEXT:    [[GEP_B:%.*]] = getelementptr inbounds [[PAIR]], ptr [[B]], i32 0, i32 1
; CHECK-NEXT:    store i32 1, ptr [[GEP_A]], align 4
; CHECK-NEXT:    store i32 2, ptr [[GEP_B]], align 4
; CHECK-NEXT:    [[SELECT:%.*]] = select i1 [[COND:%.*]], ptr [[A]], ptr [[B]]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds [[PAIR]], ptr [[SELECT]], i32 [[IDX:%.*]], i32 1
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[GEP]], align 4
; CHECK-NEXT:    ret i32 [[LOAD]]
;
bb:
  %a = alloca %pair, align 4
  %b = alloca %pair, align 4
  %gep_a = getelementptr inbounds %pair, ptr %a, i32 0, i32 1
  %gep_b = getelementptr inbounds %pair, ptr %b, i32 0, i32 1
  store i32 1, ptr %gep_a, align 4
  store i32 2, ptr %gep_b, align 4
  %select = select i1 %cond, ptr %a, ptr %b
  %gep = getelementptr inbounds %pair, ptr %select, i32 %idx, i32 1
  %load = load i32, ptr %gep, align 4
  ret i32 %load
}
