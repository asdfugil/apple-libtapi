// RUN: %clang --target=loongarch32-unknown-elf %s -fsyntax-only -### 2>&1 \
// RUN:   | FileCheck --check-prefix=ILP32D %s
// RUN: %clang --target=loongarch32-unknown-elf %s -fsyntax-only -### -mabi=ilp32s 2>&1 \
// RUN:   | FileCheck --check-prefix=ILP32S %s
// RUN: %clang --target=loongarch32-unknown-elf %s -fsyntax-only -### -mabi=ilp32f 2>&1 \
// RUN:   | FileCheck --check-prefix=ILP32F %s
// RUN: %clang --target=loongarch32-unknown-elf %s -fsyntax-only -### -mabi=ilp32d 2>&1 \
// RUN:   | FileCheck --check-prefix=ILP32D %s

// RUN: %clang --target=loongarch64-unknown-elf %s -fsyntax-only -### 2>&1 \
// RUN:   | FileCheck --check-prefix=LP64D %s
// RUN: %clang --target=loongarch64-unknown-elf %s -fsyntax-only -### -mabi=lp64s 2>&1 \
// RUN:   | FileCheck --check-prefix=LP64S %s
// RUN: %clang --target=loongarch64-unknown-elf %s -fsyntax-only -### -mabi=lp64f 2>&1 \
// RUN:   | FileCheck --check-prefix=LP64F %s
// RUN: %clang --target=loongarch64-unknown-elf %s -fsyntax-only -### -mabi=lp64d 2>&1 \
// RUN:   | FileCheck --check-prefix=LP64D %s

// ILP32S: "-target-abi" "ilp32s"
// ILP32F: "-target-abi" "ilp32f"
// ILP32D: "-target-abi" "ilp32d"

// LP64S: "-target-abi" "lp64s"
// LP64F: "-target-abi" "lp64f"
// LP64D: "-target-abi" "lp64d"
