; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -o - -gvn %s | FileCheck %s

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

%struct.S1 = type { i32, i32 }

@a2 = common global i32* null, align 8
@a = common global i32* null, align 8
@s1 = common global %struct.S1 zeroinitializer, align 8

; Check that GVN doesn't determine %2 is partially redundant.

define i32 @volatile_load(i32 %n) {
; CHECK-LABEL: @volatile_load(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP6:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP6]], label [[FOR_BODY_LR_PH:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.lr.ph:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32*, i32** @a2, align 8, !tbaa [[TBAA5:![0-9]+]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32*, i32** @a, align 8, !tbaa [[TBAA5]]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[FOR_BODY_LR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[S_09:%.*]] = phi i32 [ 0, [[FOR_BODY_LR_PH]] ], [ [[ADD:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[P_08:%.*]] = phi i32* [ [[TMP0]], [[FOR_BODY_LR_PH]] ], [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, i32* [[P_08]], align 4, !tbaa [[TBAA9:![0-9]+]]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, i32* [[TMP1]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store i32 [[TMP2]], i32* [[ARRAYIDX]], align 4, !tbaa [[TBAA9]]
; CHECK-NEXT:    [[TMP3:%.*]] = load volatile i32, i32* [[P_08]], align 4, !tbaa [[TBAA9]]
; CHECK-NEXT:    [[ADD]] = add nsw i32 [[TMP3]], [[S_09]]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds i32, i32* [[P_08]], i64 1
; CHECK-NEXT:    [[LFTR_WIDEIV:%.*]] = trunc i64 [[INDVARS_IV_NEXT]] to i32
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i32 [[LFTR_WIDEIV]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_BODY]], label [[FOR_COND_FOR_END_CRIT_EDGE:%.*]]
; CHECK:       for.cond.for.end_crit_edge:
; CHECK-NEXT:    br label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    [[S_0_LCSSA:%.*]] = phi i32 [ [[ADD]], [[FOR_COND_FOR_END_CRIT_EDGE]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i32 [[S_0_LCSSA]]
;
entry:
  %cmp6 = icmp sgt i32 %n, 0
  br i1 %cmp6, label %for.body.lr.ph, label %for.end

for.body.lr.ph:
  %0 = load i32*, i32** @a2, align 8, !tbaa !1
  %1 = load i32*, i32** @a, align 8, !tbaa !1
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %for.body ]
  %s.09 = phi i32 [ 0, %for.body.lr.ph ], [ %add, %for.body ]
  %p.08 = phi i32* [ %0, %for.body.lr.ph ], [ %incdec.ptr, %for.body ]
  %2 = load i32, i32* %p.08, align 4, !tbaa !5
  %arrayidx = getelementptr inbounds i32, i32* %1, i64 %indvars.iv
  store i32 %2, i32* %arrayidx, align 4, !tbaa !5
  %3 = load volatile i32, i32* %p.08, align 4, !tbaa !5
  %add = add nsw i32 %3, %s.09
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %incdec.ptr = getelementptr inbounds i32, i32* %p.08, i64 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp ne i32 %lftr.wideiv, %n
  br i1 %exitcond, label %for.body, label %for.cond.for.end_crit_edge

for.cond.for.end_crit_edge:
  %add.lcssa = phi i32 [ %add, %for.body ]
  br label %for.end

for.end:
  %s.0.lcssa = phi i32 [ %add.lcssa, %for.cond.for.end_crit_edge ], [ 0, %entry ]
  ret i32 %s.0.lcssa
}

; %1 is partially redundant if %0 can be widened to a 64-bit load.
; But we should not widen %0 to 64-bit load.

define i32 @overaligned_load(i32 %a, i32* nocapture %b) !dbg !13 {
; CHECK-LABEL: @overaligned_load(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[A:%.*]], 0, !dbg [[DBG14:![0-9]+]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]], !dbg [[DBG14]]
; CHECK:       if.then:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* getelementptr inbounds ([[STRUCT_S1:%.*]], %struct.S1* @s1, i64 0, i32 0), align 8, !dbg [[DBG15:![0-9]+]], !tbaa [[TBAA9]]
; CHECK-NEXT:    br label [[IF_END:%.*]], !dbg [[DBG15]]
; CHECK:       if.else:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, i32* [[B:%.*]], i64 2, !dbg [[DBG16:![0-9]+]]
; CHECK-NEXT:    store i32 10, i32* [[ARRAYIDX]], align 4, !dbg [[DBG16]], !tbaa [[TBAA9]]
; CHECK-NEXT:    br label [[IF_END]], !dbg [[DBG16]]
; CHECK:       if.end:
; CHECK-NEXT:    [[I_0:%.*]] = phi i32 [ [[TMP0]], [[IF_THEN]] ], [ 0, [[IF_ELSE]] ]
; CHECK-NEXT:    [[P_0:%.*]] = phi i32* [ getelementptr inbounds ([[STRUCT_S1]], %struct.S1* @s1, i64 0, i32 0), [[IF_THEN]] ], [ [[B]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i32, i32* [[P_0]], i64 1, !dbg [[DBG17:![0-9]+]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* [[ADD_PTR]], align 4, !dbg [[DBG17]], !tbaa [[TBAA9]]
; CHECK-NEXT:    [[ADD1:%.*]] = add nsw i32 [[TMP1]], [[I_0]], !dbg [[DBG17]]
; CHECK-NEXT:    ret i32 [[ADD1]], !dbg [[DBG17]]
;
entry:
  %cmp = icmp sgt i32 %a, 0, !dbg !14
  br i1 %cmp, label %if.then, label %if.else, !dbg !14

if.then:
  %0 = load i32, i32* getelementptr inbounds (%struct.S1, %struct.S1* @s1, i64 0, i32 0), align 8, !tbaa !5, !dbg !15
  br label %if.end, !dbg !15

if.else:
  %arrayidx = getelementptr inbounds i32, i32* %b, i64 2, !dbg !16
  store i32 10, i32* %arrayidx, align 4, !tbaa !5, !dbg !16
  br label %if.end, !dbg !16

if.end:
  %i.0 = phi i32 [ %0, %if.then ], [ 0, %if.else ]
  %p.0 = phi i32* [ getelementptr inbounds (%struct.S1, %struct.S1* @s1, i64 0, i32 0), %if.then ], [ %b, %if.else ]
  %add.ptr = getelementptr inbounds i32, i32* %p.0, i64 1, !dbg !17
  %1 = load i32, i32* %add.ptr, align 4, !tbaa !5, !dbg !17
  %add1 = add nsw i32 %1, %i.0, !dbg !17
  ret i32 %add1, !dbg !17
}

!1 = !{!2, !2, i64 0}
!2 = !{!"any pointer", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !3, i64 0}

!llvm.module.flags = !{!7, !8, !9}
!llvm.dbg.cu = !{!18}
!7 = !{i32 2, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"PIC Level", i32 2}

!10 = !{}
!11 = !DISubroutineType(types: !10)
!12 = !DIFile(filename: "test.cpp", directory: "/tmp")
!13 = distinct !DISubprogram(name: "test", scope: !12, file: !12, line: 99, type: !11, isLocal: false, isDefinition: true, scopeLine: 100, flags: DIFlagPrototyped, isOptimized: false, unit: !18, retainedNodes: !10)
!14 = !DILocation(line: 100, column: 1, scope: !13)
!15 = !DILocation(line: 101, column: 1, scope: !13)
!16 = !DILocation(line: 102, column: 1, scope: !13)
!17 = !DILocation(line: 103, column: 1, scope: !13)
!18 = distinct !DICompileUnit(language: DW_LANG_C99, producer: "clang",
  file: !12,
  isOptimized: true, flags: "-O2",
  splitDebugFilename: "abc.debug", emissionKind: 2)
