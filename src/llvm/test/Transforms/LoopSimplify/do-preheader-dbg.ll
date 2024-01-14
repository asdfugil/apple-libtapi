; Confirm that the line number for the do.body.preheader block
; branch is the the start of the loop.

; RUN: opt -simplifycfg -simplifycfg-require-and-preserve-domtree=1 -loop-simplify -keep-loops="false" -S <%s | FileCheck %s

; CHECK: do.body.preheader:
; CHECK-NEXT: phi
; CHECK-NEXT: phi
; CHECK-NEXT: br label %do.body, !dbg ![[DL:[0-9]+]]
; CHECK: ![[DL]] = !DILocation(line: 4,

; This IR can be generated by running:
; clang src.cpp -O2 -g -S -emit-llvm -mllvm -opt-bisect-limit=62 -o -
;
; Where  src.cpp contains:
; int foo(char *Bytes, int Count)
; {
;     int Total = 0;
;     do
;         Total += Bytes[--Count];
;     while (Count);
;     return Total;
; }

define dso_local i32 @"foo"(i8* nocapture readonly %Bytes, i32 %Count) local_unnamed_addr !dbg !8 {
entry:
  %0 = sext i32 %Count to i64, !dbg !10
  %min.iters.check = icmp ult i32 %Count, 8, !dbg !10
  br i1 %min.iters.check, label %do.body.preheader, label %vector.ph, !dbg !10

vector.ph:                                        ; preds = %entry
  %n.vec = and i64 %0, -8, !dbg !10
  %ind.end = sub nsw i64 %0, %n.vec, !dbg !10
  br label %vector.body, !dbg !10

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <4 x i32> [ zeroinitializer, %vector.ph ], [ %11, %vector.body ]
  %vec.phi5 = phi <4 x i32> [ zeroinitializer, %vector.ph ], [ %12, %vector.body ]
  %1 = xor i64 %index, -1, !dbg !11
  %2 = add i64 %1, %0, !dbg !11
  %3 = getelementptr inbounds i8, i8* %Bytes, i64 %2, !dbg !11
  %4 = getelementptr inbounds i8, i8* %3, i64 -3, !dbg !11
  %5 = bitcast i8* %4 to <4 x i8>*, !dbg !11
  %wide.load = load <4 x i8>, <4 x i8>* %5, align 1, !dbg !11, !tbaa !12
  %reverse = shufflevector <4 x i8> %wide.load, <4 x i8> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>, !dbg !11
  %6 = getelementptr inbounds i8, i8* %3, i64 -4, !dbg !11
  %7 = getelementptr inbounds i8, i8* %6, i64 -3, !dbg !11
  %8 = bitcast i8* %7 to <4 x i8>*, !dbg !11
  %wide.load6 = load <4 x i8>, <4 x i8>* %8, align 1, !dbg !11, !tbaa !12
  %reverse7 = shufflevector <4 x i8> %wide.load6, <4 x i8> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>, !dbg !11
  %9 = sext <4 x i8> %reverse to <4 x i32>, !dbg !11
  %10 = sext <4 x i8> %reverse7 to <4 x i32>, !dbg !11
  %11 = add nsw <4 x i32> %vec.phi, %9, !dbg !11
  %12 = add nsw <4 x i32> %vec.phi5, %10, !dbg !11
  %index.next = add i64 %index, 8
  %13 = icmp eq i64 %index.next, %n.vec
  br i1 %13, label %middle.block, label %vector.body, !llvm.loop !15

middle.block:                                     ; preds = %vector.body
  %.lcssa12 = phi <4 x i32> [ %11, %vector.body ], !dbg !11
  %.lcssa = phi <4 x i32> [ %12, %vector.body ], !dbg !11
  %bin.rdx = add <4 x i32> %.lcssa, %.lcssa12, !dbg !11
  %rdx.shuf = shufflevector <4 x i32> %bin.rdx, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>, !dbg !11
  %bin.rdx8 = add <4 x i32> %bin.rdx, %rdx.shuf, !dbg !11
  %rdx.shuf9 = shufflevector <4 x i32> %bin.rdx8, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>, !dbg !11
  %bin.rdx10 = add <4 x i32> %bin.rdx8, %rdx.shuf9, !dbg !11
  %14 = extractelement <4 x i32> %bin.rdx10, i32 0, !dbg !11
  %cmp.n = icmp eq i64 %n.vec, %0
  br i1 %cmp.n, label %do.end, label %do.body.preheader, !dbg !10

do.body.preheader:                                ; preds = %middle.block, %entry
  %indvars.iv.ph = phi i64 [ %0, %entry ], [ %ind.end, %middle.block ]
  %Total.0.ph = phi i32 [ 0, %entry ], [ %14, %middle.block ]
  br label %do.body, !dbg !11

do.body:                                          ; preds = %do.body.preheader, %do.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %do.body ], [ %indvars.iv.ph, %do.body.preheader ]
  %Total.0 = phi i32 [ %add, %do.body ], [ %Total.0.ph, %do.body.preheader ], !dbg !18
  %indvars.iv.next = add nsw i64 %indvars.iv, -1, !dbg !11
  %arrayidx = getelementptr inbounds i8, i8* %Bytes, i64 %indvars.iv.next, !dbg !11
  %15 = load i8, i8* %arrayidx, align 1, !dbg !11, !tbaa !12
  %conv = sext i8 %15 to i32, !dbg !11
  %add = add nsw i32 %Total.0, %conv, !dbg !11
  %16 = icmp eq i64 %indvars.iv.next, 0
  br i1 %16, label %do.end.loopexit, label %do.body, !dbg !11, !llvm.loop !19

do.end.loopexit:                                  ; preds = %do.body
  %add.lcssa11 = phi i32 [ %add, %do.body ], !dbg !11
  br label %do.end, !dbg !21

do.end:                                           ; preds = %do.end.loopexit, %middle.block
  %add.lcssa = phi i32 [ %14, %middle.block ], [ %add.lcssa11, %do.end.loopexit ], !dbg !11
  ret i32 %add.lcssa, !dbg !21
}

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !1, producer: "", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "src2.cpp", directory: "")
!2 = !{}
!3 = !{i32 2, !"CodeView", i32 1}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 2}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!""}
!8 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 1, type: !9, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !2)
!10 = !DILocation(line: 4, scope: !8)
!11 = !DILocation(line: 5, scope: !8)
!12 = !{!13, !13, i64 0}
!13 = !{!"omnipotent char", !14, i64 0}
!14 = !{!"Simple C++ TBAA"}
!15 = distinct !{!15, !10, !16, !17}
!16 = !DILocation(line: 6, scope: !8)
!17 = !{!"llvm.loop.isvectorized", i32 1}
!18 = !DILocation(line: 0, scope: !8)
!19 = distinct !{!19, !10, !16, !20, !17}
!20 = !{!"llvm.loop.unroll.runtime.disable"}
!21 = !DILocation(line: 7, scope: !8)
