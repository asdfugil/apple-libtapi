# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=aarch64 -mcpu=cortex-a55 --timeline --iterations=2 < %s | FileCheck %s

add      w2, w3, #1
add      w4, w3, #2, lsl #12
add      w0, w4, #3
add      w1, w0, #4

# CHECK:      Iterations:        2
# CHECK-NEXT: Instructions:      8
# CHECK-NEXT: Total Cycles:      9
# CHECK-NEXT: Total uOps:        8

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    0.89
# CHECK-NEXT: IPC:               0.89
# CHECK-NEXT: Block RThroughput: 2.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      3     0.50                        add	w2, w3, #1
# CHECK-NEXT:  1      3     0.50                        add	w4, w3, #2, lsl #12
# CHECK-NEXT:  1      3     0.50                        add	w0, w4, #3
# CHECK-NEXT:  1      3     0.50                        add	w1, w0, #4

# CHECK:      Resources:
# CHECK-NEXT: [0.0] - CortexA55UnitALU
# CHECK-NEXT: [0.1] - CortexA55UnitALU
# CHECK-NEXT: [1]   - CortexA55UnitB
# CHECK-NEXT: [2]   - CortexA55UnitDiv
# CHECK-NEXT: [3.0] - CortexA55UnitFPALU
# CHECK-NEXT: [3.1] - CortexA55UnitFPALU
# CHECK-NEXT: [4]   - CortexA55UnitFPDIV
# CHECK-NEXT: [5.0] - CortexA55UnitFPMAC
# CHECK-NEXT: [5.1] - CortexA55UnitFPMAC
# CHECK-NEXT: [6]   - CortexA55UnitLd
# CHECK-NEXT: [7]   - CortexA55UnitMAC
# CHECK-NEXT: [8]   - CortexA55UnitSt

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0.0]  [0.1]  [1]    [2]    [3.0]  [3.1]  [4]    [5.0]  [5.1]  [6]    [7]    [8]
# CHECK-NEXT: 2.00   2.00    -      -      -      -      -      -      -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0.0]  [0.1]  [1]    [2]    [3.0]  [3.1]  [4]    [5.0]  [5.1]  [6]    [7]    [8]    Instructions:
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -      -      -      -      -     add	w2, w3, #1
# CHECK-NEXT: 1.00    -      -      -      -      -      -      -      -      -      -      -     add	w4, w3, #2, lsl #12
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -      -      -      -      -     add	w0, w4, #3
# CHECK-NEXT: 1.00    -      -      -      -      -      -      -      -      -      -      -     add	w1, w0, #4

# CHECK:      Timeline view:
# CHECK-NEXT: Index     012345678

# CHECK:      [0,0]     DeeE .  .   add	w2, w3, #1
# CHECK-NEXT: [0,1]     DeeE .  .   add	w4, w3, #2, lsl #12
# CHECK-NEXT: [0,2]     .DeeE.  .   add	w0, w4, #3
# CHECK-NEXT: [0,3]     . DeeE  .   add	w1, w0, #4
# CHECK-NEXT: [1,0]     . DeeE  .   add	w2, w3, #1
# CHECK-NEXT: [1,1]     .  DeeE .   add	w4, w3, #2, lsl #12
# CHECK-NEXT: [1,2]     .   DeeE.   add	w0, w4, #3
# CHECK-NEXT: [1,3]     .    DeeE   add	w1, w0, #4

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     2     0.0    0.0    0.0       add	w2, w3, #1
# CHECK-NEXT: 1.     2     0.0    0.0    0.0       add	w4, w3, #2, lsl #12
# CHECK-NEXT: 2.     2     0.0    0.0    0.0       add	w0, w4, #3
# CHECK-NEXT: 3.     2     0.0    0.0    0.0       add	w1, w0, #4
# CHECK-NEXT:        2     0.0    0.0    0.0       <total>
