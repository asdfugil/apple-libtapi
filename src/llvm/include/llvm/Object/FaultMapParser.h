//===-- FaultMapParser.h - Parser for the  "FaultMaps" section --*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_OBJECT_FAULTMAPPARSER_H
#define LLVM_OBJECT_FAULTMAPPARSER_H

#include "llvm/Support/Endian.h"
#include <cassert>
#include <cstdint>

namespace llvm {

class raw_ostream;

/// A parser for the __llvm_faultmaps section generated by the FaultMaps class
/// declared in llvm/CodeGen/FaultMaps.h.  This parser is version locked with
/// with the __llvm_faultmaps section generated by the version of LLVM that
/// includes it.  No guarantees are made with respect to forward or backward
/// compatibility.
class FaultMapParser {
  using FaultMapVersionType = uint8_t;
  using Reserved0Type = uint8_t;
  using Reserved1Type = uint16_t;
  using NumFunctionsType = uint32_t;

  static const size_t FaultMapVersionOffset = 0;
  static const size_t Reserved0Offset =
      FaultMapVersionOffset + sizeof(FaultMapVersionType);
  static const size_t Reserved1Offset = Reserved0Offset + sizeof(Reserved0Type);
  static const size_t NumFunctionsOffset =
      Reserved1Offset + sizeof(Reserved1Type);
  static const size_t FunctionInfosOffset =
      NumFunctionsOffset + sizeof(NumFunctionsType);

  const uint8_t *P;
  const uint8_t *E;

  template <typename T> static T read(const uint8_t *P, const uint8_t *E) {
    assert(P + sizeof(T) <= E && "out of bounds read!");
    return support::endian::read<T, support::little, 1>(P);
  }

public:
  enum FaultKind {
    FaultingLoad = 1,
    FaultingLoadStore,
    FaultingStore,
    FaultKindMax
  };

  class FunctionFaultInfoAccessor {
    using FaultKindType = uint32_t;
    using FaultingPCOffsetType = uint32_t;
    using HandlerPCOffsetType = uint32_t;

    static const size_t FaultKindOffset = 0;
    static const size_t FaultingPCOffsetOffset =
        FaultKindOffset + sizeof(FaultKindType);
    static const size_t HandlerPCOffsetOffset =
        FaultingPCOffsetOffset + sizeof(FaultingPCOffsetType);

    const uint8_t *P;
    const uint8_t *E;

  public:
    static const size_t Size =
        HandlerPCOffsetOffset + sizeof(HandlerPCOffsetType);

    explicit FunctionFaultInfoAccessor(const uint8_t *P, const uint8_t *E)
        : P(P), E(E) {}

    FaultKindType getFaultKind() const {
      return read<FaultKindType>(P + FaultKindOffset, E);
    }

    FaultingPCOffsetType getFaultingPCOffset() const {
      return read<FaultingPCOffsetType>(P + FaultingPCOffsetOffset, E);
    }

    HandlerPCOffsetType getHandlerPCOffset() const {
      return read<HandlerPCOffsetType>(P + HandlerPCOffsetOffset, E);
    }
  };

  class FunctionInfoAccessor {
    using FunctionAddrType = uint64_t;
    using NumFaultingPCsType = uint32_t;
    using ReservedType = uint32_t;

    static const size_t FunctionAddrOffset = 0;
    static const size_t NumFaultingPCsOffset =
        FunctionAddrOffset + sizeof(FunctionAddrType);
    static const size_t ReservedOffset =
        NumFaultingPCsOffset + sizeof(NumFaultingPCsType);
    static const size_t FunctionFaultInfosOffset =
        ReservedOffset + sizeof(ReservedType);
    static const size_t FunctionInfoHeaderSize = FunctionFaultInfosOffset;

    const uint8_t *P = nullptr;
    const uint8_t *E = nullptr;

  public:
    FunctionInfoAccessor() = default;

    explicit FunctionInfoAccessor(const uint8_t *P, const uint8_t *E)
        : P(P), E(E) {}

    FunctionAddrType getFunctionAddr() const {
      return read<FunctionAddrType>(P + FunctionAddrOffset, E);
    }

    NumFaultingPCsType getNumFaultingPCs() const {
      return read<NumFaultingPCsType>(P + NumFaultingPCsOffset, E);
    }

    FunctionFaultInfoAccessor getFunctionFaultInfoAt(uint32_t Index) const {
      assert(Index < getNumFaultingPCs() && "index out of bounds!");
      const uint8_t *Begin = P + FunctionFaultInfosOffset +
                             FunctionFaultInfoAccessor::Size * Index;
      return FunctionFaultInfoAccessor(Begin, E);
    }

    FunctionInfoAccessor getNextFunctionInfo() const {
      size_t MySize = FunctionInfoHeaderSize +
                      getNumFaultingPCs() * FunctionFaultInfoAccessor::Size;

      const uint8_t *Begin = P + MySize;
      assert(Begin < E && "out of bounds!");
      return FunctionInfoAccessor(Begin, E);
    }
  };

  explicit FaultMapParser(const uint8_t *Begin, const uint8_t *End)
      : P(Begin), E(End) {}

  FaultMapVersionType getFaultMapVersion() const {
    auto Version = read<FaultMapVersionType>(P + FaultMapVersionOffset, E);
    assert(Version == 1 && "only version 1 supported!");
    return Version;
  }

  NumFunctionsType getNumFunctions() const {
    return read<NumFunctionsType>(P + NumFunctionsOffset, E);
  }

  FunctionInfoAccessor getFirstFunctionInfo() const {
    const uint8_t *Begin = P + FunctionInfosOffset;
    return FunctionInfoAccessor(Begin, E);
  }
};

raw_ostream &operator<<(raw_ostream &OS,
                        const FaultMapParser::FunctionFaultInfoAccessor &);

raw_ostream &operator<<(raw_ostream &OS,
                        const FaultMapParser::FunctionInfoAccessor &);

raw_ostream &operator<<(raw_ostream &OS, const FaultMapParser &);

} // namespace llvm

#endif
