// RUN: %clang_cc1 -E -dM -triple=aarch64 -xc /dev/null > %t.aarch64
// RUN: FileCheck --check-prefixes=AARCH64,AARCH64_LE,AARCH64_C %s --match-full-lines < %t.aarch64
// RUN: %clang_cc1 -E -dM -triple=arm64 -xc /dev/null > %t.arm64
// RUN: cmp %t.aarch64 %t.arm64
// RUN: %clang_cc1 -E -dM -triple=aarch64_be -xc /dev/null | FileCheck --check-prefixes=AARCH64,AARCH64_BE,AARCH64_C --match-full-lines %s
// RUN: %clang_cc1 -E -dM -triple=arm64 -xc++ /dev/null | FileCheck --check-prefixes=AARCH64,AARCH64_LE,AARCH64_CXX --match-full-lines %s

// AARCH64: #define _LP64 1
// AARCH64_BE-NEXT: #define __AARCH64EB__ 1
// AARCH64_BE-NEXT: #define __AARCH64_CMODEL_SMALL__ 1
// AARCH64_BE-NEXT: #define __AARCH_BIG_ENDIAN 1
// AARCH64_LE-NEXT: #define __AARCH64EL__ 1
// AARCH64_LE-NEXT: #define __AARCH64_CMODEL_SMALL__ 1
// AARCH64-NEXT: #define __ARM_64BIT_STATE 1
// AARCH64-NEXT: #define __ARM_ACLE 200
// AARCH64-NEXT: #define __ARM_ALIGN_MAX_STACK_PWR 4
// AARCH64-NEXT: #define __ARM_ARCH 8
// AARCH64-NEXT: #define __ARM_ARCH_ISA_A64 1
// AARCH64-NEXT: #define __ARM_ARCH_PROFILE 'A'
// AARCH64_BE-NEXT: #define __ARM_BIG_ENDIAN 1
// AARCH64-NEXT: #define __ARM_FEATURE_CLZ 1
// AARCH64-NEXT: #define __ARM_FEATURE_DIRECTED_ROUNDING 1
// AARCH64-NEXT: #define __ARM_FEATURE_DIV 1
// AARCH64-NEXT: #define __ARM_FEATURE_FMA 1
// AARCH64-NEXT: #define __ARM_FEATURE_IDIV 1
// AARCH64-NEXT: #define __ARM_FEATURE_LDREX 0xF
// AARCH64-NEXT: #define __ARM_FEATURE_NUMERIC_MAXMIN 1
// AARCH64-NEXT: #define __ARM_FEATURE_UNALIGNED 1
// AARCH64-NEXT: #define __ARM_FP 0xE
// AARCH64-NEXT: #define __ARM_FP16_ARGS 1
// AARCH64-NEXT: #define __ARM_FP16_FORMAT_IEEE 1
// AARCH64-NEXT: #define __ARM_PCS_AAPCS64 1
// AARCH64-NEXT: #define __ARM_SIZEOF_MINIMAL_ENUM 4
// AARCH64-NEXT: #define __ARM_SIZEOF_WCHAR_T 4
// AARCH64-NEXT: #define __ATOMIC_ACQUIRE 2
// AARCH64-NEXT: #define __ATOMIC_ACQ_REL 4
// AARCH64-NEXT: #define __ATOMIC_CONSUME 1
// AARCH64-NEXT: #define __ATOMIC_RELAXED 0
// AARCH64-NEXT: #define __ATOMIC_RELEASE 3
// AARCH64-NEXT: #define __ATOMIC_SEQ_CST 5
// AARCH64:      #define __BIGGEST_ALIGNMENT__ 16
// AARCH64_BE-NEXT: #define __BIG_ENDIAN__ 1
// AARCH64-NEXT: #define __BITINT_MAXWIDTH__ 128
// AARCH64-NEXT: #define __BOOL_WIDTH__ 8
// AARCH64_BE-NEXT: #define __BYTE_ORDER__ __ORDER_BIG_ENDIAN__
// AARCH64_LE-NEXT: #define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
// AARCH64-NEXT: #define __CHAR16_TYPE__ unsigned short
// AARCH64-NEXT: #define __CHAR32_TYPE__ unsigned int
// AARCH64-NEXT: #define __CHAR_BIT__ 8
// AARCH64-NEXT: #define __CLANG_ATOMIC_BOOL_LOCK_FREE 2
// AARCH64-NEXT: #define __CLANG_ATOMIC_CHAR16_T_LOCK_FREE 2
// AARCH64-NEXT: #define __CLANG_ATOMIC_CHAR32_T_LOCK_FREE 2
// AARCH64-NEXT: #define __CLANG_ATOMIC_CHAR_LOCK_FREE 2
// AARCH64-NEXT: #define __CLANG_ATOMIC_INT_LOCK_FREE 2
// AARCH64-NEXT: #define __CLANG_ATOMIC_LLONG_LOCK_FREE 2
// AARCH64-NEXT: #define __CLANG_ATOMIC_LONG_LOCK_FREE 2
// AARCH64-NEXT: #define __CLANG_ATOMIC_POINTER_LOCK_FREE 2
// AARCH64-NEXT: #define __CLANG_ATOMIC_SHORT_LOCK_FREE 2
// AARCH64-NEXT: #define __CLANG_ATOMIC_WCHAR_T_LOCK_FREE 2
// AARCH64-NEXT: #define __CONSTANT_CFSTRINGS__ 1
// AARCH64-NEXT: #define __DBL_DECIMAL_DIG__ 17
// AARCH64-NEXT: #define __DBL_DENORM_MIN__ 4.9406564584124654e-324
// AARCH64-NEXT: #define __DBL_DIG__ 15
// AARCH64-NEXT: #define __DBL_EPSILON__ 2.2204460492503131e-16
// AARCH64-NEXT: #define __DBL_HAS_DENORM__ 1
// AARCH64-NEXT: #define __DBL_HAS_INFINITY__ 1
// AARCH64-NEXT: #define __DBL_HAS_QUIET_NAN__ 1
// AARCH64-NEXT: #define __DBL_MANT_DIG__ 53
// AARCH64-NEXT: #define __DBL_MAX_10_EXP__ 308
// AARCH64-NEXT: #define __DBL_MAX_EXP__ 1024
// AARCH64-NEXT: #define __DBL_MAX__ 1.7976931348623157e+308
// AARCH64-NEXT: #define __DBL_MIN_10_EXP__ (-307)
// AARCH64-NEXT: #define __DBL_MIN_EXP__ (-1021)
// AARCH64-NEXT: #define __DBL_MIN__ 2.2250738585072014e-308
// AARCH64-NEXT: #define __DECIMAL_DIG__ __LDBL_DECIMAL_DIG__
// AARCH64-NEXT: #define __ELF__ 1
// AARCH64-NEXT: #define __FINITE_MATH_ONLY__ 0
// AARCH64-NEXT: #define __FLT16_DECIMAL_DIG__ 5
// AARCH64-NEXT: #define __FLT16_DENORM_MIN__ 5.9604644775390625e-8F16
// AARCH64-NEXT: #define __FLT16_DIG__ 3
// AARCH64-NEXT: #define __FLT16_EPSILON__ 9.765625e-4F16
// AARCH64-NEXT: #define __FLT16_HAS_DENORM__ 1
// AARCH64-NEXT: #define __FLT16_HAS_INFINITY__ 1
// AARCH64-NEXT: #define __FLT16_HAS_QUIET_NAN__ 1
// AARCH64-NEXT: #define __FLT16_MANT_DIG__ 11
// AARCH64-NEXT: #define __FLT16_MAX_10_EXP__ 4
// AARCH64-NEXT: #define __FLT16_MAX_EXP__ 16
// AARCH64-NEXT: #define __FLT16_MAX__ 6.5504e+4F16
// AARCH64-NEXT: #define __FLT16_MIN_10_EXP__ (-4)
// AARCH64-NEXT: #define __FLT16_MIN_EXP__ (-13)
// AARCH64-NEXT: #define __FLT16_MIN__ 6.103515625e-5F16
// AARCH64-NEXT: #define __FLT_DECIMAL_DIG__ 9
// AARCH64-NEXT: #define __FLT_DENORM_MIN__ 1.40129846e-45F
// AARCH64-NEXT: #define __FLT_DIG__ 6
// AARCH64-NEXT: #define __FLT_EPSILON__ 1.19209290e-7F
// AARCH64-NEXT: #define __FLT_HAS_DENORM__ 1
// AARCH64-NEXT: #define __FLT_HAS_INFINITY__ 1
// AARCH64-NEXT: #define __FLT_HAS_QUIET_NAN__ 1
// AARCH64-NEXT: #define __FLT_MANT_DIG__ 24
// AARCH64-NEXT: #define __FLT_MAX_10_EXP__ 38
// AARCH64-NEXT: #define __FLT_MAX_EXP__ 128
// AARCH64-NEXT: #define __FLT_MAX__ 3.40282347e+38F
// AARCH64-NEXT: #define __FLT_MIN_10_EXP__ (-37)
// AARCH64-NEXT: #define __FLT_MIN_EXP__ (-125)
// AARCH64-NEXT: #define __FLT_MIN__ 1.17549435e-38F
// AARCH64-NEXT: #define __FLT_RADIX__ 2
// AARCH64-NEXT: #define __FP_FAST_FMA 1
// AARCH64-NEXT: #define __FP_FAST_FMAF 1
// AARCH64-NEXT: #define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 1
// AARCH64-NEXT: #define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 1
// AARCH64-NEXT: #define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 1
// AARCH64-NEXT: #define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 1
// AARCH64_CXX-NEXT: #define __GLIBCXX_BITSIZE_INT_N_0 128
// AARCH64_CXX-NEXT: #define __GLIBCXX_TYPE_INT_N_0 __int128
// AARCH64-NEXT: #define __INT16_C_SUFFIX__
// AARCH64-NEXT: #define __INT16_FMTd__ "hd"
// AARCH64-NEXT: #define __INT16_FMTi__ "hi"
// AARCH64-NEXT: #define __INT16_MAX__ 32767
// AARCH64-NEXT: #define __INT16_TYPE__ short
// AARCH64-NEXT: #define __INT32_C_SUFFIX__
// AARCH64-NEXT: #define __INT32_FMTd__ "d"
// AARCH64-NEXT: #define __INT32_FMTi__ "i"
// AARCH64-NEXT: #define __INT32_MAX__ 2147483647
// AARCH64-NEXT: #define __INT32_TYPE__ int
// AARCH64-NEXT: #define __INT64_C_SUFFIX__ L
// AARCH64-NEXT: #define __INT64_FMTd__ "ld"
// AARCH64-NEXT: #define __INT64_FMTi__ "li"
// AARCH64-NEXT: #define __INT64_MAX__ 9223372036854775807L
// AARCH64-NEXT: #define __INT64_TYPE__ long int
// AARCH64-NEXT: #define __INT8_C_SUFFIX__
// AARCH64-NEXT: #define __INT8_FMTd__ "hhd"
// AARCH64-NEXT: #define __INT8_FMTi__ "hhi"
// AARCH64-NEXT: #define __INT8_MAX__ 127
// AARCH64-NEXT: #define __INT8_TYPE__ signed char
// AARCH64-NEXT: #define __INTMAX_C_SUFFIX__ L
// AARCH64-NEXT: #define __INTMAX_FMTd__ "ld"
// AARCH64-NEXT: #define __INTMAX_FMTi__ "li"
// AARCH64-NEXT: #define __INTMAX_MAX__ 9223372036854775807L
// AARCH64-NEXT: #define __INTMAX_TYPE__ long int
// AARCH64-NEXT: #define __INTMAX_WIDTH__ 64
// AARCH64-NEXT: #define __INTPTR_FMTd__ "ld"
// AARCH64-NEXT: #define __INTPTR_FMTi__ "li"
// AARCH64-NEXT: #define __INTPTR_MAX__ 9223372036854775807L
// AARCH64-NEXT: #define __INTPTR_TYPE__ long int
// AARCH64-NEXT: #define __INTPTR_WIDTH__ 64
// AARCH64-NEXT: #define __INT_FAST16_FMTd__ "hd"
// AARCH64-NEXT: #define __INT_FAST16_FMTi__ "hi"
// AARCH64-NEXT: #define __INT_FAST16_MAX__ 32767
// AARCH64-NEXT: #define __INT_FAST16_TYPE__ short
// AARCH64-NEXT: #define __INT_FAST16_WIDTH__ 16
// AARCH64-NEXT: #define __INT_FAST32_FMTd__ "d"
// AARCH64-NEXT: #define __INT_FAST32_FMTi__ "i"
// AARCH64-NEXT: #define __INT_FAST32_MAX__ 2147483647
// AARCH64-NEXT: #define __INT_FAST32_TYPE__ int
// AARCH64-NEXT: #define __INT_FAST32_WIDTH__ 32
// AARCH64-NEXT: #define __INT_FAST64_FMTd__ "ld"
// AARCH64-NEXT: #define __INT_FAST64_FMTi__ "li"
// AARCH64-NEXT: #define __INT_FAST64_MAX__ 9223372036854775807L
// AARCH64-NEXT: #define __INT_FAST64_TYPE__ long int
// AARCH64-NEXT: #define __INT_FAST64_WIDTH__ 64
// AARCH64-NEXT: #define __INT_FAST8_FMTd__ "hhd"
// AARCH64-NEXT: #define __INT_FAST8_FMTi__ "hhi"
// AARCH64-NEXT: #define __INT_FAST8_MAX__ 127
// AARCH64-NEXT: #define __INT_FAST8_TYPE__ signed char
// AARCH64-NEXT: #define __INT_FAST8_WIDTH__ 8
// AARCH64-NEXT: #define __INT_LEAST16_FMTd__ "hd"
// AARCH64-NEXT: #define __INT_LEAST16_FMTi__ "hi"
// AARCH64-NEXT: #define __INT_LEAST16_MAX__ 32767
// AARCH64-NEXT: #define __INT_LEAST16_TYPE__ short
// AARCH64-NEXT: #define __INT_LEAST16_WIDTH__ 16
// AARCH64-NEXT: #define __INT_LEAST32_FMTd__ "d"
// AARCH64-NEXT: #define __INT_LEAST32_FMTi__ "i"
// AARCH64-NEXT: #define __INT_LEAST32_MAX__ 2147483647
// AARCH64-NEXT: #define __INT_LEAST32_TYPE__ int
// AARCH64-NEXT: #define __INT_LEAST32_WIDTH__ 32
// AARCH64-NEXT: #define __INT_LEAST64_FMTd__ "ld"
// AARCH64-NEXT: #define __INT_LEAST64_FMTi__ "li"
// AARCH64-NEXT: #define __INT_LEAST64_MAX__ 9223372036854775807L
// AARCH64-NEXT: #define __INT_LEAST64_TYPE__ long int
// AARCH64-NEXT: #define __INT_LEAST64_WIDTH__ 64
// AARCH64-NEXT: #define __INT_LEAST8_FMTd__ "hhd"
// AARCH64-NEXT: #define __INT_LEAST8_FMTi__ "hhi"
// AARCH64-NEXT: #define __INT_LEAST8_MAX__ 127
// AARCH64-NEXT: #define __INT_LEAST8_TYPE__ signed char
// AARCH64-NEXT: #define __INT_LEAST8_WIDTH__ 8
// AARCH64-NEXT: #define __INT_MAX__ 2147483647
// AARCH64-NEXT: #define __INT_WIDTH__ 32
// AARCH64-NEXT: #define __LDBL_DECIMAL_DIG__ 36
// AARCH64-NEXT: #define __LDBL_DENORM_MIN__ 6.47517511943802511092443895822764655e-4966L
// AARCH64-NEXT: #define __LDBL_DIG__ 33
// AARCH64-NEXT: #define __LDBL_EPSILON__ 1.92592994438723585305597794258492732e-34L
// AARCH64-NEXT: #define __LDBL_HAS_DENORM__ 1
// AARCH64-NEXT: #define __LDBL_HAS_INFINITY__ 1
// AARCH64-NEXT: #define __LDBL_HAS_QUIET_NAN__ 1
// AARCH64-NEXT: #define __LDBL_MANT_DIG__ 113
// AARCH64-NEXT: #define __LDBL_MAX_10_EXP__ 4932
// AARCH64-NEXT: #define __LDBL_MAX_EXP__ 16384
// AARCH64-NEXT: #define __LDBL_MAX__ 1.18973149535723176508575932662800702e+4932L
// AARCH64-NEXT: #define __LDBL_MIN_10_EXP__ (-4931)
// AARCH64-NEXT: #define __LDBL_MIN_EXP__ (-16381)
// AARCH64-NEXT: #define __LDBL_MIN__ 3.36210314311209350626267781732175260e-4932L
// AARCH64_LE-NEXT: #define __LITTLE_ENDIAN__ 1
// AARCH64-NEXT: #define __LLONG_WIDTH__ 64
// AARCH64-NEXT: #define __LONG_LONG_MAX__ 9223372036854775807LL
// AARCH64-NEXT: #define __LONG_MAX__ 9223372036854775807L
// AARCH64-NEXT: #define __LONG_WIDTH__ 64
// AARCH64-NEXT: #define __LP64__ 1
// AARCH64-NEXT: #define __NO_INLINE__ 1
// AARCH64-NEXT: #define __NO_MATH_ERRNO__ 1
// AARCH64-NEXT: #define __OBJC_BOOL_IS_BOOL 0
// AARCH64-NEXT: #define __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES 3
// AARCH64-NEXT: #define __OPENCL_MEMORY_SCOPE_DEVICE 2
// AARCH64-NEXT: #define __OPENCL_MEMORY_SCOPE_SUB_GROUP 4
// AARCH64-NEXT: #define __OPENCL_MEMORY_SCOPE_WORK_GROUP 1
// AARCH64-NEXT: #define __OPENCL_MEMORY_SCOPE_WORK_ITEM 0
// AARCH64-NEXT: #define __ORDER_BIG_ENDIAN__ 4321
// AARCH64-NEXT: #define __ORDER_LITTLE_ENDIAN__ 1234
// AARCH64-NEXT: #define __ORDER_PDP_ENDIAN__ 3412
// AARCH64-NEXT: #define __POINTER_WIDTH__ 64
// AARCH64-NEXT: #define __PRAGMA_REDEFINE_EXTNAME 1
// AARCH64-NEXT: #define __PTRDIFF_FMTd__ "ld"
// AARCH64-NEXT: #define __PTRDIFF_FMTi__ "li"
// AARCH64-NEXT: #define __PTRDIFF_MAX__ 9223372036854775807L
// AARCH64-NEXT: #define __PTRDIFF_TYPE__ long int
// AARCH64-NEXT: #define __PTRDIFF_WIDTH__ 64
// AARCH64-NEXT: #define __SCHAR_MAX__ 127
// AARCH64-NEXT: #define __SHRT_MAX__ 32767
// AARCH64-NEXT: #define __SHRT_WIDTH__ 16
// AARCH64-NEXT: #define __SIG_ATOMIC_MAX__ 2147483647
// AARCH64-NEXT: #define __SIG_ATOMIC_WIDTH__ 32
// AARCH64-NEXT: #define __SIZEOF_DOUBLE__ 8
// AARCH64-NEXT: #define __SIZEOF_FLOAT__ 4
// AARCH64-NEXT: #define __SIZEOF_INT128__ 16
// AARCH64-NEXT: #define __SIZEOF_INT__ 4
// AARCH64-NEXT: #define __SIZEOF_LONG_DOUBLE__ 16
// AARCH64-NEXT: #define __SIZEOF_LONG_LONG__ 8
// AARCH64-NEXT: #define __SIZEOF_LONG__ 8
// AARCH64-NEXT: #define __SIZEOF_POINTER__ 8
// AARCH64-NEXT: #define __SIZEOF_PTRDIFF_T__ 8
// AARCH64-NEXT: #define __SIZEOF_SHORT__ 2
// AARCH64-NEXT: #define __SIZEOF_SIZE_T__ 8
// AARCH64-NEXT: #define __SIZEOF_WCHAR_T__ 4
// AARCH64-NEXT: #define __SIZEOF_WINT_T__ 4
// AARCH64-NEXT: #define __SIZE_FMTX__ "lX"
// AARCH64-NEXT: #define __SIZE_FMTo__ "lo"
// AARCH64-NEXT: #define __SIZE_FMTu__ "lu"
// AARCH64-NEXT: #define __SIZE_FMTx__ "lx"
// AARCH64-NEXT: #define __SIZE_MAX__ 18446744073709551615UL
// AARCH64-NEXT: #define __SIZE_TYPE__ long unsigned int
// AARCH64-NEXT: #define __SIZE_WIDTH__ 64
// AARCH64_CXX: #define __STDCPP_DEFAULT_NEW_ALIGNMENT__ 16UL
// AARCH64_CXX: #define __STDCPP_THREADS__ 1
// AARCH64-NEXT: #define __STDC_HOSTED__ 1
// AARCH64-NEXT: #define __STDC_UTF_16__ 1
// AARCH64-NEXT: #define __STDC_UTF_32__ 1
// AARCH64_C: #define __STDC_VERSION__ 201710L
// AARCH64-NEXT: #define __STDC__ 1
// AARCH64-NEXT: #define __UINT16_C_SUFFIX__
// AARCH64-NEXT: #define __UINT16_FMTX__ "hX"
// AARCH64-NEXT: #define __UINT16_FMTo__ "ho"
// AARCH64-NEXT: #define __UINT16_FMTu__ "hu"
// AARCH64-NEXT: #define __UINT16_FMTx__ "hx"
// AARCH64-NEXT: #define __UINT16_MAX__ 65535
// AARCH64-NEXT: #define __UINT16_TYPE__ unsigned short
// AARCH64-NEXT: #define __UINT32_C_SUFFIX__ U
// AARCH64-NEXT: #define __UINT32_FMTX__ "X"
// AARCH64-NEXT: #define __UINT32_FMTo__ "o"
// AARCH64-NEXT: #define __UINT32_FMTu__ "u"
// AARCH64-NEXT: #define __UINT32_FMTx__ "x"
// AARCH64-NEXT: #define __UINT32_MAX__ 4294967295U
// AARCH64-NEXT: #define __UINT32_TYPE__ unsigned int
// AARCH64-NEXT: #define __UINT64_C_SUFFIX__ UL
// AARCH64-NEXT: #define __UINT64_FMTX__ "lX"
// AARCH64-NEXT: #define __UINT64_FMTo__ "lo"
// AARCH64-NEXT: #define __UINT64_FMTu__ "lu"
// AARCH64-NEXT: #define __UINT64_FMTx__ "lx"
// AARCH64-NEXT: #define __UINT64_MAX__ 18446744073709551615UL
// AARCH64-NEXT: #define __UINT64_TYPE__ long unsigned int
// AARCH64-NEXT: #define __UINT8_C_SUFFIX__
// AARCH64-NEXT: #define __UINT8_FMTX__ "hhX"
// AARCH64-NEXT: #define __UINT8_FMTo__ "hho"
// AARCH64-NEXT: #define __UINT8_FMTu__ "hhu"
// AARCH64-NEXT: #define __UINT8_FMTx__ "hhx"
// AARCH64-NEXT: #define __UINT8_MAX__ 255
// AARCH64-NEXT: #define __UINT8_TYPE__ unsigned char
// AARCH64-NEXT: #define __UINTMAX_C_SUFFIX__ UL
// AARCH64-NEXT: #define __UINTMAX_FMTX__ "lX"
// AARCH64-NEXT: #define __UINTMAX_FMTo__ "lo"
// AARCH64-NEXT: #define __UINTMAX_FMTu__ "lu"
// AARCH64-NEXT: #define __UINTMAX_FMTx__ "lx"
// AARCH64-NEXT: #define __UINTMAX_MAX__ 18446744073709551615UL
// AARCH64-NEXT: #define __UINTMAX_TYPE__ long unsigned int
// AARCH64-NEXT: #define __UINTMAX_WIDTH__ 64
// AARCH64-NEXT: #define __UINTPTR_FMTX__ "lX"
// AARCH64-NEXT: #define __UINTPTR_FMTo__ "lo"
// AARCH64-NEXT: #define __UINTPTR_FMTu__ "lu"
// AARCH64-NEXT: #define __UINTPTR_FMTx__ "lx"
// AARCH64-NEXT: #define __UINTPTR_MAX__ 18446744073709551615UL
// AARCH64-NEXT: #define __UINTPTR_TYPE__ long unsigned int
// AARCH64-NEXT: #define __UINTPTR_WIDTH__ 64
// AARCH64-NEXT: #define __UINT_FAST16_FMTX__ "hX"
// AARCH64-NEXT: #define __UINT_FAST16_FMTo__ "ho"
// AARCH64-NEXT: #define __UINT_FAST16_FMTu__ "hu"
// AARCH64-NEXT: #define __UINT_FAST16_FMTx__ "hx"
// AARCH64-NEXT: #define __UINT_FAST16_MAX__ 65535
// AARCH64-NEXT: #define __UINT_FAST16_TYPE__ unsigned short
// AARCH64-NEXT: #define __UINT_FAST32_FMTX__ "X"
// AARCH64-NEXT: #define __UINT_FAST32_FMTo__ "o"
// AARCH64-NEXT: #define __UINT_FAST32_FMTu__ "u"
// AARCH64-NEXT: #define __UINT_FAST32_FMTx__ "x"
// AARCH64-NEXT: #define __UINT_FAST32_MAX__ 4294967295U
// AARCH64-NEXT: #define __UINT_FAST32_TYPE__ unsigned int
// AARCH64-NEXT: #define __UINT_FAST64_FMTX__ "lX"
// AARCH64-NEXT: #define __UINT_FAST64_FMTo__ "lo"
// AARCH64-NEXT: #define __UINT_FAST64_FMTu__ "lu"
// AARCH64-NEXT: #define __UINT_FAST64_FMTx__ "lx"
// AARCH64-NEXT: #define __UINT_FAST64_MAX__ 18446744073709551615UL
// AARCH64-NEXT: #define __UINT_FAST64_TYPE__ long unsigned int
// AARCH64-NEXT: #define __UINT_FAST8_FMTX__ "hhX"
// AARCH64-NEXT: #define __UINT_FAST8_FMTo__ "hho"
// AARCH64-NEXT: #define __UINT_FAST8_FMTu__ "hhu"
// AARCH64-NEXT: #define __UINT_FAST8_FMTx__ "hhx"
// AARCH64-NEXT: #define __UINT_FAST8_MAX__ 255
// AARCH64-NEXT: #define __UINT_FAST8_TYPE__ unsigned char
// AARCH64-NEXT: #define __UINT_LEAST16_FMTX__ "hX"
// AARCH64-NEXT: #define __UINT_LEAST16_FMTo__ "ho"
// AARCH64-NEXT: #define __UINT_LEAST16_FMTu__ "hu"
// AARCH64-NEXT: #define __UINT_LEAST16_FMTx__ "hx"
// AARCH64-NEXT: #define __UINT_LEAST16_MAX__ 65535
// AARCH64-NEXT: #define __UINT_LEAST16_TYPE__ unsigned short
// AARCH64-NEXT: #define __UINT_LEAST32_FMTX__ "X"
// AARCH64-NEXT: #define __UINT_LEAST32_FMTo__ "o"
// AARCH64-NEXT: #define __UINT_LEAST32_FMTu__ "u"
// AARCH64-NEXT: #define __UINT_LEAST32_FMTx__ "x"
// AARCH64-NEXT: #define __UINT_LEAST32_MAX__ 4294967295U
// AARCH64-NEXT: #define __UINT_LEAST32_TYPE__ unsigned int
// AARCH64-NEXT: #define __UINT_LEAST64_FMTX__ "lX"
// AARCH64-NEXT: #define __UINT_LEAST64_FMTo__ "lo"
// AARCH64-NEXT: #define __UINT_LEAST64_FMTu__ "lu"
// AARCH64-NEXT: #define __UINT_LEAST64_FMTx__ "lx"
// AARCH64-NEXT: #define __UINT_LEAST64_MAX__ 18446744073709551615UL
// AARCH64-NEXT: #define __UINT_LEAST64_TYPE__ long unsigned int
// AARCH64-NEXT: #define __UINT_LEAST8_FMTX__ "hhX"
// AARCH64-NEXT: #define __UINT_LEAST8_FMTo__ "hho"
// AARCH64-NEXT: #define __UINT_LEAST8_FMTu__ "hhu"
// AARCH64-NEXT: #define __UINT_LEAST8_FMTx__ "hhx"
// AARCH64-NEXT: #define __UINT_LEAST8_MAX__ 255
// AARCH64-NEXT: #define __UINT_LEAST8_TYPE__ unsigned char
// AARCH64-NEXT: #define __USER_LABEL_PREFIX__
// AARCH64-NEXT: #define __VERSION__ "{{.*}}"
// AARCH64-NEXT: #define __WCHAR_MAX__ 4294967295U
// AARCH64-NEXT: #define __WCHAR_TYPE__ unsigned int
// AARCH64-NEXT: #define __WCHAR_UNSIGNED__ 1
// AARCH64-NEXT: #define __WCHAR_WIDTH__ 32
// AARCH64-NEXT: #define __WINT_MAX__ 2147483647
// AARCH64-NEXT: #define __WINT_TYPE__ int
// AARCH64-NEXT: #define __WINT_WIDTH__ 32
// AARCH64-NEXT: #define __aarch64__ 1

// RUN: %clang_cc1 -E -dM -ffreestanding -triple=aarch64-apple-ios7.0 < /dev/null | FileCheck -match-full-lines -check-prefix AARCH64-DARWIN %s

// AARCH64-DARWIN: #define _LP64 1
// AARCH64-DARWIN-NOT: #define __AARCH64EB__ 1
// AARCH64-DARWIN: #define __AARCH64EL__ 1
// AARCH64-DARWIN-NOT: #define __AARCH_BIG_ENDIAN 1
// AARCH64-DARWIN: #define __ARM_64BIT_STATE 1
// AARCH64-DARWIN: #define __ARM_ARCH 8
// AARCH64-DARWIN: #define __ARM_ARCH_ISA_A64 1
// AARCH64-DARWIN-NOT: #define __ARM_BIG_ENDIAN 1
// AARCH64-DARWIN: #define __BIGGEST_ALIGNMENT__ 8
// AARCH64-DARWIN: #define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
// AARCH64-DARWIN: #define __CHAR16_TYPE__ unsigned short
// AARCH64-DARWIN: #define __CHAR32_TYPE__ unsigned int
// AARCH64-DARWIN: #define __CHAR_BIT__ 8
// AARCH64-DARWIN: #define __DBL_DENORM_MIN__ 4.9406564584124654e-324
// AARCH64-DARWIN: #define __DBL_DIG__ 15
// AARCH64-DARWIN: #define __DBL_EPSILON__ 2.2204460492503131e-16
// AARCH64-DARWIN: #define __DBL_HAS_DENORM__ 1
// AARCH64-DARWIN: #define __DBL_HAS_INFINITY__ 1
// AARCH64-DARWIN: #define __DBL_HAS_QUIET_NAN__ 1
// AARCH64-DARWIN: #define __DBL_MANT_DIG__ 53
// AARCH64-DARWIN: #define __DBL_MAX_10_EXP__ 308
// AARCH64-DARWIN: #define __DBL_MAX_EXP__ 1024
// AARCH64-DARWIN: #define __DBL_MAX__ 1.7976931348623157e+308
// AARCH64-DARWIN: #define __DBL_MIN_10_EXP__ (-307)
// AARCH64-DARWIN: #define __DBL_MIN_EXP__ (-1021)
// AARCH64-DARWIN: #define __DBL_MIN__ 2.2250738585072014e-308
// AARCH64-DARWIN: #define __DECIMAL_DIG__ __LDBL_DECIMAL_DIG__
// AARCH64-DARWIN: #define __FLT_DENORM_MIN__ 1.40129846e-45F
// AARCH64-DARWIN: #define __FLT_DIG__ 6
// AARCH64-DARWIN: #define __FLT_EPSILON__ 1.19209290e-7F
// AARCH64-DARWIN: #define __FLT_HAS_DENORM__ 1
// AARCH64-DARWIN: #define __FLT_HAS_INFINITY__ 1
// AARCH64-DARWIN: #define __FLT_HAS_QUIET_NAN__ 1
// AARCH64-DARWIN: #define __FLT_MANT_DIG__ 24
// AARCH64-DARWIN: #define __FLT_MAX_10_EXP__ 38
// AARCH64-DARWIN: #define __FLT_MAX_EXP__ 128
// AARCH64-DARWIN: #define __FLT_MAX__ 3.40282347e+38F
// AARCH64-DARWIN: #define __FLT_MIN_10_EXP__ (-37)
// AARCH64-DARWIN: #define __FLT_MIN_EXP__ (-125)
// AARCH64-DARWIN: #define __FLT_MIN__ 1.17549435e-38F
// AARCH64-DARWIN: #define __FLT_RADIX__ 2
// AARCH64-DARWIN: #define __INT16_C_SUFFIX__
// AARCH64-DARWIN: #define __INT16_FMTd__ "hd"
// AARCH64-DARWIN: #define __INT16_FMTi__ "hi"
// AARCH64-DARWIN: #define __INT16_MAX__ 32767
// AARCH64-DARWIN: #define __INT16_TYPE__ short
// AARCH64-DARWIN: #define __INT32_C_SUFFIX__
// AARCH64-DARWIN: #define __INT32_FMTd__ "d"
// AARCH64-DARWIN: #define __INT32_FMTi__ "i"
// AARCH64-DARWIN: #define __INT32_MAX__ 2147483647
// AARCH64-DARWIN: #define __INT32_TYPE__ int
// AARCH64-DARWIN: #define __INT64_C_SUFFIX__ LL
// AARCH64-DARWIN: #define __INT64_FMTd__ "lld"
// AARCH64-DARWIN: #define __INT64_FMTi__ "lli"
// AARCH64-DARWIN: #define __INT64_MAX__ 9223372036854775807LL
// AARCH64-DARWIN: #define __INT64_TYPE__ long long int
// AARCH64-DARWIN: #define __INT8_C_SUFFIX__
// AARCH64-DARWIN: #define __INT8_FMTd__ "hhd"
// AARCH64-DARWIN: #define __INT8_FMTi__ "hhi"
// AARCH64-DARWIN: #define __INT8_MAX__ 127
// AARCH64-DARWIN: #define __INT8_TYPE__ signed char
// AARCH64-DARWIN: #define __INTMAX_C_SUFFIX__ L
// AARCH64-DARWIN: #define __INTMAX_FMTd__ "ld"
// AARCH64-DARWIN: #define __INTMAX_FMTi__ "li"
// AARCH64-DARWIN: #define __INTMAX_MAX__ 9223372036854775807L
// AARCH64-DARWIN: #define __INTMAX_TYPE__ long int
// AARCH64-DARWIN: #define __INTMAX_WIDTH__ 64
// AARCH64-DARWIN: #define __INTPTR_FMTd__ "ld"
// AARCH64-DARWIN: #define __INTPTR_FMTi__ "li"
// AARCH64-DARWIN: #define __INTPTR_MAX__ 9223372036854775807L
// AARCH64-DARWIN: #define __INTPTR_TYPE__ long int
// AARCH64-DARWIN: #define __INTPTR_WIDTH__ 64
// AARCH64-DARWIN: #define __INT_FAST16_FMTd__ "hd"
// AARCH64-DARWIN: #define __INT_FAST16_FMTi__ "hi"
// AARCH64-DARWIN: #define __INT_FAST16_MAX__ 32767
// AARCH64-DARWIN: #define __INT_FAST16_TYPE__ short
// AARCH64-DARWIN: #define __INT_FAST32_FMTd__ "d"
// AARCH64-DARWIN: #define __INT_FAST32_FMTi__ "i"
// AARCH64-DARWIN: #define __INT_FAST32_MAX__ 2147483647
// AARCH64-DARWIN: #define __INT_FAST32_TYPE__ int
// AARCH64-DARWIN: #define __INT_FAST64_FMTd__ "lld"
// AARCH64-DARWIN: #define __INT_FAST64_FMTi__ "lli"
// AARCH64-DARWIN: #define __INT_FAST64_MAX__ 9223372036854775807LL
// AARCH64-DARWIN: #define __INT_FAST64_TYPE__ long long int
// AARCH64-DARWIN: #define __INT_FAST8_FMTd__ "hhd"
// AARCH64-DARWIN: #define __INT_FAST8_FMTi__ "hhi"
// AARCH64-DARWIN: #define __INT_FAST8_MAX__ 127
// AARCH64-DARWIN: #define __INT_FAST8_TYPE__ signed char
// AARCH64-DARWIN: #define __INT_LEAST16_FMTd__ "hd"
// AARCH64-DARWIN: #define __INT_LEAST16_FMTi__ "hi"
// AARCH64-DARWIN: #define __INT_LEAST16_MAX__ 32767
// AARCH64-DARWIN: #define __INT_LEAST16_TYPE__ short
// AARCH64-DARWIN: #define __INT_LEAST32_FMTd__ "d"
// AARCH64-DARWIN: #define __INT_LEAST32_FMTi__ "i"
// AARCH64-DARWIN: #define __INT_LEAST32_MAX__ 2147483647
// AARCH64-DARWIN: #define __INT_LEAST32_TYPE__ int
// AARCH64-DARWIN: #define __INT_LEAST64_FMTd__ "lld"
// AARCH64-DARWIN: #define __INT_LEAST64_FMTi__ "lli"
// AARCH64-DARWIN: #define __INT_LEAST64_MAX__ 9223372036854775807LL
// AARCH64-DARWIN: #define __INT_LEAST64_TYPE__ long long int
// AARCH64-DARWIN: #define __INT_LEAST8_FMTd__ "hhd"
// AARCH64-DARWIN: #define __INT_LEAST8_FMTi__ "hhi"
// AARCH64-DARWIN: #define __INT_LEAST8_MAX__ 127
// AARCH64-DARWIN: #define __INT_LEAST8_TYPE__ signed char
// AARCH64-DARWIN: #define __INT_MAX__ 2147483647
// AARCH64-DARWIN: #define __LDBL_DENORM_MIN__ 4.9406564584124654e-324L
// AARCH64-DARWIN: #define __LDBL_DIG__ 15
// AARCH64-DARWIN: #define __LDBL_EPSILON__ 2.2204460492503131e-16L
// AARCH64-DARWIN: #define __LDBL_HAS_DENORM__ 1
// AARCH64-DARWIN: #define __LDBL_HAS_INFINITY__ 1
// AARCH64-DARWIN: #define __LDBL_HAS_QUIET_NAN__ 1
// AARCH64-DARWIN: #define __LDBL_MANT_DIG__ 53
// AARCH64-DARWIN: #define __LDBL_MAX_10_EXP__ 308
// AARCH64-DARWIN: #define __LDBL_MAX_EXP__ 1024
// AARCH64-DARWIN: #define __LDBL_MAX__ 1.7976931348623157e+308L
// AARCH64-DARWIN: #define __LDBL_MIN_10_EXP__ (-307)
// AARCH64-DARWIN: #define __LDBL_MIN_EXP__ (-1021)
// AARCH64-DARWIN: #define __LDBL_MIN__ 2.2250738585072014e-308L
// AARCH64-DARWIN: #define __LONG_LONG_MAX__ 9223372036854775807LL
// AARCH64-DARWIN: #define __LONG_MAX__ 9223372036854775807L
// AARCH64-DARWIN: #define __LP64__ 1
// AARCH64-DARWIN: #define __POINTER_WIDTH__ 64
// AARCH64-DARWIN: #define __PTRDIFF_TYPE__ long int
// AARCH64-DARWIN: #define __PTRDIFF_WIDTH__ 64
// AARCH64-DARWIN: #define __SCHAR_MAX__ 127
// AARCH64-DARWIN: #define __SHRT_MAX__ 32767
// AARCH64-DARWIN: #define __SIG_ATOMIC_MAX__ 2147483647
// AARCH64-DARWIN: #define __SIG_ATOMIC_WIDTH__ 32
// AARCH64-DARWIN: #define __SIZEOF_DOUBLE__ 8
// AARCH64-DARWIN: #define __SIZEOF_FLOAT__ 4
// AARCH64-DARWIN: #define __SIZEOF_INT128__ 16
// AARCH64-DARWIN: #define __SIZEOF_INT__ 4
// AARCH64-DARWIN: #define __SIZEOF_LONG_DOUBLE__ 8
// AARCH64-DARWIN: #define __SIZEOF_LONG_LONG__ 8
// AARCH64-DARWIN: #define __SIZEOF_LONG__ 8
// AARCH64-DARWIN: #define __SIZEOF_POINTER__ 8
// AARCH64-DARWIN: #define __SIZEOF_PTRDIFF_T__ 8
// AARCH64-DARWIN: #define __SIZEOF_SHORT__ 2
// AARCH64-DARWIN: #define __SIZEOF_SIZE_T__ 8
// AARCH64-DARWIN: #define __SIZEOF_WCHAR_T__ 4
// AARCH64-DARWIN: #define __SIZEOF_WINT_T__ 4
// AARCH64-DARWIN: #define __SIZE_MAX__ 18446744073709551615UL
// AARCH64-DARWIN: #define __SIZE_TYPE__ long unsigned int
// AARCH64-DARWIN: #define __SIZE_WIDTH__ 64
// AARCH64-DARWIN: #define __UINT16_C_SUFFIX__
// AARCH64-DARWIN: #define __UINT16_MAX__ 65535
// AARCH64-DARWIN: #define __UINT16_TYPE__ unsigned short
// AARCH64-DARWIN: #define __UINT32_C_SUFFIX__ U
// AARCH64-DARWIN: #define __UINT32_MAX__ 4294967295U
// AARCH64-DARWIN: #define __UINT32_TYPE__ unsigned int
// AARCH64-DARWIN: #define __UINT64_C_SUFFIX__ ULL
// AARCH64-DARWIN: #define __UINT64_MAX__ 18446744073709551615ULL
// AARCH64-DARWIN: #define __UINT64_TYPE__ long long unsigned int
// AARCH64-DARWIN: #define __UINT8_C_SUFFIX__
// AARCH64-DARWIN: #define __UINT8_MAX__ 255
// AARCH64-DARWIN: #define __UINT8_TYPE__ unsigned char
// AARCH64-DARWIN: #define __UINTMAX_C_SUFFIX__ UL
// AARCH64-DARWIN: #define __UINTMAX_MAX__ 18446744073709551615UL
// AARCH64-DARWIN: #define __UINTMAX_TYPE__ long unsigned int
// AARCH64-DARWIN: #define __UINTMAX_WIDTH__ 64
// AARCH64-DARWIN: #define __UINTPTR_MAX__ 18446744073709551615UL
// AARCH64-DARWIN: #define __UINTPTR_TYPE__ long unsigned int
// AARCH64-DARWIN: #define __UINTPTR_WIDTH__ 64
// AARCH64-DARWIN: #define __UINT_FAST16_MAX__ 65535
// AARCH64-DARWIN: #define __UINT_FAST16_TYPE__ unsigned short
// AARCH64-DARWIN: #define __UINT_FAST32_MAX__ 4294967295U
// AARCH64-DARWIN: #define __UINT_FAST32_TYPE__ unsigned int
// AARCH64-DARWIN: #define __UINT_FAST64_MAX__ 18446744073709551615ULL
// AARCH64-DARWIN: #define __UINT_FAST64_TYPE__ long long unsigned int
// AARCH64-DARWIN: #define __UINT_FAST8_MAX__ 255
// AARCH64-DARWIN: #define __UINT_FAST8_TYPE__ unsigned char
// AARCH64-DARWIN: #define __UINT_LEAST16_MAX__ 65535
// AARCH64-DARWIN: #define __UINT_LEAST16_TYPE__ unsigned short
// AARCH64-DARWIN: #define __UINT_LEAST32_MAX__ 4294967295U
// AARCH64-DARWIN: #define __UINT_LEAST32_TYPE__ unsigned int
// AARCH64-DARWIN: #define __UINT_LEAST64_MAX__ 18446744073709551615ULL
// AARCH64-DARWIN: #define __UINT_LEAST64_TYPE__ long long unsigned int
// AARCH64-DARWIN: #define __UINT_LEAST8_MAX__ 255
// AARCH64-DARWIN: #define __UINT_LEAST8_TYPE__ unsigned char
// AARCH64-DARWIN: #define __USER_LABEL_PREFIX__ _
// AARCH64-DARWIN: #define __WCHAR_MAX__ 2147483647
// AARCH64-DARWIN: #define __WCHAR_TYPE__ int
// AARCH64-DARWIN-NOT: #define __WCHAR_UNSIGNED__
// AARCH64-DARWIN: #define __WCHAR_WIDTH__ 32
// AARCH64-DARWIN: #define __WINT_TYPE__ int
// AARCH64-DARWIN: #define __WINT_WIDTH__ 32
// AARCH64-DARWIN: #define __aarch64__ 1

// RUN: %clang_cc1 -E -dM -triple=aarch64-apple-ios7.0 -x c++ < /dev/null | FileCheck -match-full-lines -check-prefix AARCH64-DARWIN-CXX %s
// AARCH64-DARWIN-CXX: #define __STDCPP_DEFAULT_NEW_ALIGNMENT__ 16UL

// RUN: %clang_cc1 -E -dM -ffreestanding -triple=aarch64-windows-msvc < /dev/null | FileCheck -match-full-lines -check-prefix AARCH64-MSVC %s

// AARCH64-MSVC: #define _INTEGRAL_MAX_BITS 64
// AARCH64-MSVC-NOT: #define _LP64 1
// AARCH64-MSVC: #define _M_ARM64 1
// AARCH64-MSVC: #define _WIN32 1
// AARCH64-MSVC: #define _WIN64 1
// AARCH64-MSVC: #define __AARCH64EL__ 1
// AARCH64-MSVC: #define __ARM_64BIT_STATE 1
// AARCH64-MSVC: #define __ARM_ACLE 200
// AARCH64-MSVC: #define __ARM_ALIGN_MAX_STACK_PWR 4
// AARCH64-MSVC: #define __ARM_ARCH 8
// AARCH64-MSVC: #define __ARM_ARCH_ISA_A64 1
// AARCH64-MSVC: #define __ARM_ARCH_PROFILE 'A'
// AARCH64-MSVC: #define __ARM_FEATURE_CLZ 1
// AARCH64-MSVC: #define __ARM_FEATURE_DIRECTED_ROUNDING 1
// AARCH64-MSVC: #define __ARM_FEATURE_DIV 1
// AARCH64-MSVC: #define __ARM_FEATURE_FMA 1
// AARCH64-MSVC: #define __ARM_FEATURE_IDIV 1
// AARCH64-MSVC: #define __ARM_FEATURE_LDREX 0xF
// AARCH64-MSVC: #define __ARM_FEATURE_NUMERIC_MAXMIN 1
// AARCH64-MSVC: #define __ARM_FEATURE_UNALIGNED 1
// AARCH64-MSVC: #define __ARM_FP 0xE
// AARCH64-MSVC: #define __ARM_FP16_ARGS 1
// AARCH64-MSVC: #define __ARM_FP16_FORMAT_IEEE 1
// AARCH64-MSVC: #define __ARM_PCS_AAPCS64 1
// AARCH64-MSVC: #define __ARM_SIZEOF_MINIMAL_ENUM 4
// AARCH64-MSVC: #define __ARM_SIZEOF_WCHAR_T 4
// AARCH64-MSVC: #define __BIGGEST_ALIGNMENT__ 16
// AARCH64-MSVC: #define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
// AARCH64-MSVC: #define __CHAR16_TYPE__ unsigned short
// AARCH64-MSVC: #define __CHAR32_TYPE__ unsigned int
// AARCH64-MSVC: #define __CHAR_BIT__ 8
// AARCH64-MSVC: #define __CONSTANT_CFSTRINGS__ 1
// AARCH64-MSVC: #define __DBL_DECIMAL_DIG__ 17
// AARCH64-MSVC: #define __DBL_DENORM_MIN__ 4.9406564584124654e-324
// AARCH64-MSVC: #define __DBL_DIG__ 15
// AARCH64-MSVC: #define __DBL_EPSILON__ 2.2204460492503131e-16
// AARCH64-MSVC: #define __DBL_HAS_DENORM__ 1
// AARCH64-MSVC: #define __DBL_HAS_INFINITY__ 1
// AARCH64-MSVC: #define __DBL_HAS_QUIET_NAN__ 1
// AARCH64-MSVC: #define __DBL_MANT_DIG__ 53
// AARCH64-MSVC: #define __DBL_MAX_10_EXP__ 308
// AARCH64-MSVC: #define __DBL_MAX_EXP__ 1024
// AARCH64-MSVC: #define __DBL_MAX__ 1.7976931348623157e+308
// AARCH64-MSVC: #define __DBL_MIN_10_EXP__ (-307)
// AARCH64-MSVC: #define __DBL_MIN_EXP__ (-1021)
// AARCH64-MSVC: #define __DBL_MIN__ 2.2250738585072014e-308
// AARCH64-MSVC: #define __DECIMAL_DIG__ __LDBL_DECIMAL_DIG__
// AARCH64-MSVC: #define __FINITE_MATH_ONLY__ 0
// AARCH64-MSVC: #define __FLT_DECIMAL_DIG__ 9
// AARCH64-MSVC: #define __FLT_DENORM_MIN__ 1.40129846e-45F
// AARCH64-MSVC: #define __FLT_DIG__ 6
// AARCH64-MSVC: #define __FLT_EPSILON__ 1.19209290e-7F
// AARCH64-MSVC: #define __FLT_HAS_DENORM__ 1
// AARCH64-MSVC: #define __FLT_HAS_INFINITY__ 1
// AARCH64-MSVC: #define __FLT_HAS_QUIET_NAN__ 1
// AARCH64-MSVC: #define __FLT_MANT_DIG__ 24
// AARCH64-MSVC: #define __FLT_MAX_10_EXP__ 38
// AARCH64-MSVC: #define __FLT_MAX_EXP__ 128
// AARCH64-MSVC: #define __FLT_MAX__ 3.40282347e+38F
// AARCH64-MSVC: #define __FLT_MIN_10_EXP__ (-37)
// AARCH64-MSVC: #define __FLT_MIN_EXP__ (-125)
// AARCH64-MSVC: #define __FLT_MIN__ 1.17549435e-38F
// AARCH64-MSVC: #define __FLT_RADIX__ 2
// AARCH64-MSVC: #define __INT_MAX__ 2147483647
// AARCH64-MSVC: #define __LDBL_DECIMAL_DIG__ 17
// AARCH64-MSVC: #define __LDBL_DENORM_MIN__ 4.9406564584124654e-324L
// AARCH64-MSVC: #define __LDBL_DIG__ 15
// AARCH64-MSVC: #define __LDBL_EPSILON__ 2.2204460492503131e-16L
// AARCH64-MSVC: #define __LDBL_HAS_DENORM__ 1
// AARCH64-MSVC: #define __LDBL_HAS_INFINITY__ 1
// AARCH64-MSVC: #define __LDBL_HAS_QUIET_NAN__ 1
// AARCH64-MSVC: #define __LDBL_MANT_DIG__ 53
// AARCH64-MSVC: #define __LDBL_MAX_10_EXP__ 308
// AARCH64-MSVC: #define __LDBL_MAX_EXP__ 1024
// AARCH64-MSVC: #define __LDBL_MAX__ 1.7976931348623157e+308L
// AARCH64-MSVC: #define __LDBL_MIN_10_EXP__ (-307)
// AARCH64-MSVC: #define __LDBL_MIN_EXP__ (-1021)
// AARCH64-MSVC: #define __LDBL_MIN__ 2.2250738585072014e-308L
// AARCH64-MSVC: #define __LITTLE_ENDIAN__ 1
// AARCH64-MSVC: #define __LONG_LONG_MAX__ 9223372036854775807LL
// AARCH64-MSVC: #define __LONG_MAX__ 2147483647L
// AARCH64-MSVC-NOT: #define __LP64__ 1
// AARCH64-MSVC: #define __NO_INLINE__ 1
// AARCH64-MSVC: #define __OBJC_BOOL_IS_BOOL 0
// AARCH64-MSVC: #define __ORDER_BIG_ENDIAN__ 4321
// AARCH64-MSVC: #define __ORDER_LITTLE_ENDIAN__ 1234
// AARCH64-MSVC: #define __ORDER_PDP_ENDIAN__ 3412
// AARCH64-MSVC: #define __POINTER_WIDTH__ 64
// AARCH64-MSVC: #define __PRAGMA_REDEFINE_EXTNAME 1
// AARCH64-MSVC: #define __SCHAR_MAX__ 127
// AARCH64-MSVC: #define __SHRT_MAX__ 32767
// AARCH64-MSVC: #define __SIG_ATOMIC_MAX__ 2147483647
// AARCH64-MSVC: #define __SIG_ATOMIC_WIDTH__ 32
// AARCH64-MSVC: #define __SIZEOF_DOUBLE__ 8
// AARCH64-MSVC: #define __SIZEOF_FLOAT__ 4
// AARCH64-MSVC: #define __SIZEOF_INT128__ 16
// AARCH64-MSVC: #define __SIZEOF_INT__ 4
// AARCH64-MSVC: #define __SIZEOF_LONG_DOUBLE__ 8
// AARCH64-MSVC: #define __SIZEOF_LONG_LONG__ 8
// AARCH64-MSVC: #define __SIZEOF_LONG__ 4
// AARCH64-MSVC: #define __SIZEOF_POINTER__ 8
// AARCH64-MSVC: #define __SIZEOF_PTRDIFF_T__ 8
// AARCH64-MSVC: #define __SIZEOF_SHORT__ 2
// AARCH64-MSVC: #define __SIZEOF_SIZE_T__ 8
// AARCH64-MSVC: #define __SIZEOF_WCHAR_T__ 2
// AARCH64-MSVC: #define __SIZEOF_WINT_T__ 2
// AARCH64-MSVC: #define __SIZE_MAX__ 18446744073709551615ULL
// AARCH64-MSVC: #define __SIZE_TYPE__ long long unsigned int
// AARCH64-MSVC: #define __SIZE_WIDTH__ 64
// AARCH64-MSVC: #define __STDC_HOSTED__ 0
// AARCH64-MSVC: #define __STDC_UTF_16__ 1
// AARCH64-MSVC: #define __STDC_UTF_32__ 1
// AARCH64-MSVC: #define __STDC_VERSION__ 201710L
// AARCH64-MSVC: #define __STDC__ 1
// AARCH64-MSVC: #define __UINT16_C_SUFFIX__
// AARCH64-MSVC: #define __UINT16_MAX__ 65535
// AARCH64-MSVC: #define __UINT16_TYPE__ unsigned short
// AARCH64-MSVC: #define __UINT32_C_SUFFIX__ U
// AARCH64-MSVC: #define __UINT32_MAX__ 4294967295U
// AARCH64-MSVC: #define __UINT32_TYPE__ unsigned int
// AARCH64-MSVC: #define __UINT64_C_SUFFIX__ ULL
// AARCH64-MSVC: #define __UINT64_MAX__ 18446744073709551615ULL
// AARCH64-MSVC: #define __UINT64_TYPE__ long long unsigned int
// AARCH64-MSVC: #define __UINT8_C_SUFFIX__
// AARCH64-MSVC: #define __UINT8_MAX__ 255
// AARCH64-MSVC: #define __UINT8_TYPE__ unsigned char
// AARCH64-MSVC: #define __UINTMAX_C_SUFFIX__ ULL
// AARCH64-MSVC: #define __UINTMAX_MAX__ 18446744073709551615ULL
// AARCH64-MSVC: #define __UINTMAX_TYPE__ long long unsigned int
// AARCH64-MSVC: #define __UINTMAX_WIDTH__ 64
// AARCH64-MSVC: #define __UINTPTR_MAX__ 18446744073709551615ULL
// AARCH64-MSVC: #define __UINTPTR_TYPE__ long long unsigned int
// AARCH64-MSVC: #define __UINTPTR_WIDTH__ 64
// AARCH64-MSVC: #define __UINT_FAST16_MAX__ 65535
// AARCH64-MSVC: #define __UINT_FAST16_TYPE__ unsigned short
// AARCH64-MSVC: #define __UINT_FAST32_MAX__ 4294967295U
// AARCH64-MSVC: #define __UINT_FAST32_TYPE__ unsigned int
// AARCH64-MSVC: #define __UINT_FAST64_MAX__ 18446744073709551615ULL
// AARCH64-MSVC: #define __UINT_FAST64_TYPE__ long long unsigned int
// AARCH64-MSVC: #define __UINT_FAST8_MAX__ 255
// AARCH64-MSVC: #define __UINT_FAST8_TYPE__ unsigned char
// AARCH64-MSVC: #define __UINT_LEAST16_MAX__ 65535
// AARCH64-MSVC: #define __UINT_LEAST16_TYPE__ unsigned short
// AARCH64-MSVC: #define __UINT_LEAST32_MAX__ 4294967295U
// AARCH64-MSVC: #define __UINT_LEAST32_TYPE__ unsigned int
// AARCH64-MSVC: #define __UINT_LEAST64_MAX__ 18446744073709551615ULL
// AARCH64-MSVC: #define __UINT_LEAST64_TYPE__ long long unsigned int
// AARCH64-MSVC: #define __UINT_LEAST8_MAX__ 255
// AARCH64-MSVC: #define __UINT_LEAST8_TYPE__ unsigned char
// AARCH64-MSVC: #define __USER_LABEL_PREFIX__
// AARCH64-MSVC: #define __WCHAR_MAX__ 65535
// AARCH64-MSVC: #define __WCHAR_TYPE__ unsigned short
// AARCH64-MSVC: #define __WCHAR_UNSIGNED__ 1
// AARCH64-MSVC: #define __WCHAR_WIDTH__ 16
// AARCH64-MSVC: #define __WINT_TYPE__ unsigned short
// AARCH64-MSVC: #define __WINT_WIDTH__ 16
// AARCH64-MSVC: #define __aarch64__ 1

// RUN: %clang_cc1 -triple=aarch64 -E -dM -mcmodel=small -xc /dev/null | FileCheck --check-prefix=CMODEL_SMALL %s
// RUN: %clang_cc1 -triple=aarch64 -E -dM -mcmodel=tiny -xc /dev/null | FileCheck --check-prefix=CMODEL_TINY %s
// RUN: %clang_cc1 -triple=aarch64 -E -dM -mcmodel=large -xc /dev/null | FileCheck --check-prefix=CMODEL_LARGE %s

// CMODEL_TINY: #define __AARCH64_CMODEL_TINY__ 1
// CMODEL_SMALL: #define __AARCH64_CMODEL_SMALL__ 1
// CMODEL_LARGE: #define __AARCH64_CMODEL_LARGE__ 1
