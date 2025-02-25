//===- DWARFLinker.h --------------------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_DWARFLINKER_DWARFLINKER_H
#define LLVM_DWARFLINKER_DWARFLINKER_H

#include "llvm/ADT/AddressRanges.h"
#include "llvm/CodeGen/AccelTable.h"
#include "llvm/CodeGen/NonRelocatableStringpool.h"
#include "llvm/DWARFLinker/DWARFLinkerCompileUnit.h"
#include "llvm/DebugInfo/DWARF/DWARFContext.h"
#include "llvm/DebugInfo/DWARF/DWARFDebugLine.h"
#include "llvm/DebugInfo/DWARF/DWARFDebugRangeList.h"
#include "llvm/DebugInfo/DWARF/DWARFDie.h"
#include <map>

namespace llvm {
class DWARFExpression;
class DWARFUnit;
class DataExtractor;
class DeclContextTree;
struct MCDwarfLineTableParams;
template <typename T> class SmallVectorImpl;

enum class DwarfLinkerClient { Dsymutil, LLD, General };

/// The kind of accelerator tables we should emit.
enum class DwarfLinkerAccelTableKind : uint8_t {
  None,
  Apple,   ///< .apple_names, .apple_namespaces, .apple_types, .apple_objc.
  Dwarf,   ///< DWARF v5 .debug_names.
  Default, ///< Dwarf for DWARF5 or later, Apple otherwise.
  Pub,     ///< .debug_pubnames, .debug_pubtypes
};

/// AddressesMap represents information about valid addresses used
/// by debug information. Valid addresses are those which points to
/// live code sections. i.e. relocations for these addresses point
/// into sections which would be/are placed into resulting binary.
class AddressesMap {
public:
  virtual ~AddressesMap();

  /// Checks that there are valid relocations against a .debug_info
  /// section.
  virtual bool hasValidRelocs() = 0;

  /// Checks that the specified variable \p DIE references live code section.
  /// Allowed kind of input die: DW_TAG_variable, DW_TAG_constant.
  /// \returns true and sets Info.InDebugMap if it is the case.
  virtual bool isLiveVariable(const DWARFDie &DIE,
                              CompileUnit::DIEInfo &Info) = 0;

  /// Checks that the specified subprogram \p DIE references live code section.
  /// Allowed kind of input die: DW_TAG_subprogram, DW_TAG_label.
  /// \returns true and sets Info.InDebugMap if it is the case.
  virtual bool isLiveSubprogram(const DWARFDie &DIE,
                                CompileUnit::DIEInfo &Info) = 0;

  /// Apply the valid relocations to the buffer \p Data, taking into
  /// account that Data is at \p BaseOffset in the .debug_info section.
  ///
  /// \returns true whether any reloc has been applied.
  virtual bool applyValidRelocs(MutableArrayRef<char> Data, uint64_t BaseOffset,
                                bool IsLittleEndian) = 0;

  /// Relocate the given address offset if a valid relocation exists.
  virtual llvm::Expected<uint64_t> relocateIndexedAddr(uint64_t StartOffset,
                                                       uint64_t EndOffset) = 0;

  /// Returns all valid functions address ranges(i.e., those ranges
  /// which points to sections with code).
  virtual RangesTy &getValidAddressRanges() = 0;

  /// Erases all data.
  virtual void clear() = 0;
};

/// DwarfEmitter presents interface to generate all debug info tables.
class DwarfEmitter {
public:
  virtual ~DwarfEmitter();

  /// Emit DIE containing warnings.
  virtual void emitPaperTrailWarningsDie(DIE &Die) = 0;

  /// Emit section named SecName with data SecData.
  virtual void emitSectionContents(StringRef SecData, StringRef SecName) = 0;

  /// Emit the abbreviation table \p Abbrevs to the .debug_abbrev section.
  virtual void
  emitAbbrevs(const std::vector<std::unique_ptr<DIEAbbrev>> &Abbrevs,
              unsigned DwarfVersion) = 0;

  /// Emit the string table described by \p Pool.
  virtual void emitStrings(const NonRelocatableStringpool &Pool) = 0;

  /// Emit DWARF debug names.
  virtual void
  emitDebugNames(AccelTable<DWARF5AccelTableStaticData> &Table) = 0;

  /// Emit Apple namespaces accelerator table.
  virtual void
  emitAppleNamespaces(AccelTable<AppleAccelTableStaticOffsetData> &Table) = 0;

  /// Emit Apple names accelerator table.
  virtual void
  emitAppleNames(AccelTable<AppleAccelTableStaticOffsetData> &Table) = 0;

  /// Emit Apple Objective-C accelerator table.
  virtual void
  emitAppleObjc(AccelTable<AppleAccelTableStaticOffsetData> &Table) = 0;

  /// Emit Apple type accelerator table.
  virtual void
  emitAppleTypes(AccelTable<AppleAccelTableStaticTypeData> &Table) = 0;

  /// Emit .debug_ranges for \p FuncRange by translating the
  /// original \p Entries.
  virtual void emitRangesEntries(
      int64_t UnitPcOffset, uint64_t OrigLowPc,
      Optional<std::pair<AddressRange, int64_t>> FuncRange,
      const std::vector<DWARFDebugRangeList::RangeListEntry> &Entries,
      unsigned AddressSize) = 0;

  /// Emit .debug_aranges entries for \p Unit and if \p DoRangesSection is true,
  /// also emit the .debug_ranges entries for the DW_TAG_compile_unit's
  /// DW_AT_ranges attribute.
  virtual void emitUnitRangesEntries(CompileUnit &Unit,
                                     bool DoRangesSection) = 0;

  /// Copy the .debug_line over to the updated binary while unobfuscating the
  /// file names and directories.
  virtual void translateLineTable(DataExtractor LineData, uint64_t Offset) = 0;

  /// Emit the line table described in \p Rows into the .debug_line section.
  virtual void emitLineTableForUnit(MCDwarfLineTableParams Params,
                                    StringRef PrologueBytes,
                                    unsigned MinInstLength,
                                    std::vector<DWARFDebugLine::Row> &Rows,
                                    unsigned AdddressSize) = 0;

  /// Emit the .debug_pubnames contribution for \p Unit.
  virtual void emitPubNamesForUnit(const CompileUnit &Unit) = 0;

  /// Emit the .debug_pubtypes contribution for \p Unit.
  virtual void emitPubTypesForUnit(const CompileUnit &Unit) = 0;

  /// Emit a CIE.
  virtual void emitCIE(StringRef CIEBytes) = 0;

  /// Emit an FDE with data \p Bytes.
  virtual void emitFDE(uint32_t CIEOffset, uint32_t AddreSize, uint32_t Address,
                       StringRef Bytes) = 0;

  /// Emit the .debug_loc contribution for \p Unit by copying the entries from
  /// \p Dwarf and offsetting them. Update the location attributes to point to
  /// the new entries.
  virtual void emitLocationsForUnit(
      const CompileUnit &Unit, DWARFContext &Dwarf,
      std::function<void(StringRef, SmallVectorImpl<uint8_t> &)>
          ProcessExpr) = 0;

  /// Emit the compilation unit header for \p Unit in the
  /// .debug_info section.
  ///
  /// As a side effect, this also switches the current Dwarf version
  /// of the MC layer to the one of U.getOrigUnit().
  virtual void emitCompileUnitHeader(CompileUnit &Unit,
                                     unsigned DwarfVersion) = 0;

  /// Recursively emit the DIE tree rooted at \p Die.
  virtual void emitDIE(DIE &Die) = 0;

  /// Returns size of generated .debug_line section.
  virtual uint64_t getLineSectionSize() const = 0;

  /// Returns size of generated .debug_frame section.
  virtual uint64_t getFrameSectionSize() const = 0;

  /// Returns size of generated .debug_ranges section.
  virtual uint64_t getRangesSectionSize() const = 0;

  /// Returns size of generated .debug_info section.
  virtual uint64_t getDebugInfoSectionSize() const = 0;
};

using UnitListTy = std::vector<std::unique_ptr<CompileUnit>>;

/// this class represents DWARF information for source file
/// and it`s address map.
class DWARFFile {
public:
  DWARFFile(StringRef Name, std::unique_ptr<DWARFContext> Dwarf,
            std::unique_ptr<AddressesMap> Addresses,
            const std::vector<std::string> &Warnings)
      : FileName(Name), Dwarf(std::move(Dwarf)),
        Addresses(std::move(Addresses)), Warnings(Warnings) {}

  /// object file name.
  StringRef FileName;
  /// The source DWARF information.
  std::unique_ptr<DWARFContext> Dwarf;
  /// Helpful address information(list of valid address ranges, relocations).
  std::unique_ptr<AddressesMap> Addresses;
  /// warnings for object file.
  const std::vector<std::string> &Warnings;

  /// Unloads object file and corresponding AddressesMap and Dwarf Context.
  void unload() {
    Addresses.reset();
    Dwarf.reset();
  }
};

typedef std::function<void(const Twine &Warning, StringRef Context,
                           const DWARFDie *DIE)>
    messageHandler;
typedef std::function<ErrorOr<DWARFFile &>(StringRef ContainerName,
                                           StringRef Path)>
    objFileLoader;
typedef std::map<std::string, std::string> swiftInterfacesMap;
typedef std::map<std::string, std::string> objectPrefixMap;

typedef function_ref<void(const DWARFUnit &Unit)> CompileUnitHandler;

/// The core of the Dwarf linking logic.
///
/// The generation of the dwarf information from the object files will be
/// driven by the selection of 'root DIEs', which are DIEs that
/// describe variables or functions that resolves to the corresponding
/// code section(and thus have entries in the Addresses map). All the debug
/// information that will be generated(the DIEs, but also the line
/// tables, ranges, ...) is derived from that set of root DIEs.
///
/// The root DIEs are identified because they contain relocations that
/// points to code section(the low_pc for a function, the location for
/// a variable). These relocations are called ValidRelocs in the
/// AddressesInfo and are gathered as a very first step when we start
/// processing a object file.
class DWARFLinker {
public:
  DWARFLinker(DwarfEmitter *Emitter,
              DwarfLinkerClient ClientID = DwarfLinkerClient::General)
      : TheDwarfEmitter(Emitter), DwarfLinkerClientID(ClientID) {}

  /// Add object file to be linked. Pre-load compile unit die. Call
  /// \p OnCUDieLoaded for each compile unit die. If specified \p File
  /// has reference to the Clang module then such module would be
  /// pre-loaded by \p Loader for !Update case.
  ///
  /// \pre NoODR, Update options should be set before call to addObjectFile.
  void addObjectFile(
      DWARFFile &File, objFileLoader Loader = nullptr,
      CompileUnitHandler OnCUDieLoaded = [](const DWARFUnit &) {});

  /// Link debug info for added objFiles. Object
  /// files are linked all together.
  Error link();

  /// A number of methods setting various linking options:

  /// Allows to generate log of linking process to the standard output.
  void setVerbosity(bool Verbose) { Options.Verbose = Verbose; }

  /// Print statistics to standard output.
  void setStatistics(bool Statistics) { Options.Statistics = Statistics; }

  /// Verify the input DWARF.
  void setVerifyInputDWARF(bool Verify) { Options.VerifyInputDWARF = Verify; }

  /// Do not emit linked dwarf info.
  void setNoOutput(bool NoOut) { Options.NoOutput = NoOut; }

  /// Do not unique types according to ODR.
  void setNoODR(bool NoODR) { Options.NoODR = NoODR; }

  /// update existing DWARF info(for the linked binary).
  void setUpdate(bool Update) { Options.Update = Update; }

  /// Set whether to keep the enclosing function for a static variable.
  void setKeepFunctionForStatic(bool KeepFunctionForStatic) {
    Options.KeepFunctionForStatic = KeepFunctionForStatic;
  }

  /// Use specified number of threads for parallel files linking.
  void setNumThreads(unsigned NumThreads) { Options.Threads = NumThreads; }

  /// Set kind of accelerator tables to be generated.
  void setAccelTableKind(DwarfLinkerAccelTableKind Kind) {
    Options.TheAccelTableKind = Kind;
  }

  /// Set prepend path for clang modules.
  void setPrependPath(const std::string &Ppath) { Options.PrependPath = Ppath; }

  /// Set translator which would be used for strings.
  void
  setStringsTranslator(std::function<StringRef(StringRef)> StringsTranslator) {
    this->StringsTranslator = StringsTranslator;
  }

  /// Set estimated objects files amount, for preliminary data allocation.
  void setEstimatedObjfilesAmount(unsigned ObjFilesNum) {
    ObjectContexts.reserve(ObjFilesNum);
  }

  /// Set warning handler which would be used to report warnings.
  void setWarningHandler(messageHandler Handler) {
    Options.WarningHandler = Handler;
  }

  /// Set error handler which would be used to report errors.
  void setErrorHandler(messageHandler Handler) {
    Options.ErrorHandler = Handler;
  }

  /// Set map for Swift interfaces.
  void setSwiftInterfacesMap(swiftInterfacesMap *Map) {
    Options.ParseableSwiftInterfaces = Map;
  }

  /// Set prefix map for objects.
  void setObjectPrefixMap(objectPrefixMap *Map) {
    Options.ObjectPrefixMap = Map;
  }

  /// Set target DWARF version.
  Error setTargetDWARFVersion(uint16_t TargetDWARFVersion) {
    if (TargetDWARFVersion < 1 || TargetDWARFVersion > 5)
      return createStringError(std::errc::invalid_argument,
                               "unsupported DWARF version: %d",
                               TargetDWARFVersion);

    Options.TargetDWARFVersion = TargetDWARFVersion;
    return Error::success();
  }

private:
  /// Flags passed to DwarfLinker::lookForDIEsToKeep
  enum TraversalFlags {
    TF_Keep = 1 << 0,            ///< Mark the traversed DIEs as kept.
    TF_InFunctionScope = 1 << 1, ///< Current scope is a function scope.
    TF_DependencyWalk = 1 << 2,  ///< Walking the dependencies of a kept DIE.
    TF_ParentWalk = 1 << 3,      ///< Walking up the parents of a kept DIE.
    TF_ODR = 1 << 4,             ///< Use the ODR while keeping dependents.
    TF_SkipPC = 1 << 5,          ///< Skip all location attributes.
  };

  /// The  distinct types of work performed by the work loop.
  enum class WorklistItemType {
    /// Given a DIE, look for DIEs to be kept.
    LookForDIEsToKeep,
    /// Given a DIE, look for children of this DIE to be kept.
    LookForChildDIEsToKeep,
    /// Given a DIE, look for DIEs referencing this DIE to be kept.
    LookForRefDIEsToKeep,
    /// Given a DIE, look for parent DIEs to be kept.
    LookForParentDIEsToKeep,
    /// Given a DIE, update its incompleteness based on whether its children are
    /// incomplete.
    UpdateChildIncompleteness,
    /// Given a DIE, update its incompleteness based on whether the DIEs it
    /// references are incomplete.
    UpdateRefIncompleteness,
    /// Given a DIE, mark it as ODR Canonical if applicable.
    MarkODRCanonicalDie,
  };

  /// This class represents an item in the work list. The type defines what kind
  /// of work needs to be performed when processing the current item. The flags
  /// and info fields are optional based on the type.
  struct WorklistItem {
    DWARFDie Die;
    WorklistItemType Type;
    CompileUnit &CU;
    unsigned Flags;
    union {
      const unsigned AncestorIdx;
      CompileUnit::DIEInfo *OtherInfo;
    };

    WorklistItem(DWARFDie Die, CompileUnit &CU, unsigned Flags,
                 WorklistItemType T = WorklistItemType::LookForDIEsToKeep)
        : Die(Die), Type(T), CU(CU), Flags(Flags), AncestorIdx(0) {}

    WorklistItem(DWARFDie Die, CompileUnit &CU, WorklistItemType T,
                 CompileUnit::DIEInfo *OtherInfo = nullptr)
        : Die(Die), Type(T), CU(CU), Flags(0), OtherInfo(OtherInfo) {}

    WorklistItem(unsigned AncestorIdx, CompileUnit &CU, unsigned Flags)
        : Type(WorklistItemType::LookForParentDIEsToKeep), CU(CU), Flags(Flags),
          AncestorIdx(AncestorIdx) {}
  };

  /// Verify the given DWARF file.
  bool verify(const DWARFFile &File);

  /// returns true if we need to translate strings.
  bool needToTranslateStrings() { return StringsTranslator != nullptr; }

  void reportWarning(const Twine &Warning, const DWARFFile &File,
                     const DWARFDie *DIE = nullptr) const {
    if (Options.WarningHandler != nullptr)
      Options.WarningHandler(Warning, File.FileName, DIE);
  }

  void reportError(const Twine &Warning, const DWARFFile &File,
                   const DWARFDie *DIE = nullptr) const {
    if (Options.ErrorHandler != nullptr)
      Options.ErrorHandler(Warning, File.FileName, DIE);
  }

  /// Remembers the kinds of accelerator tables we've seen in a unit.
  void updateAccelKind(DWARFContext &Dwarf);

  /// Emit warnings as Dwarf compile units to leave a trail after linking.
  bool emitPaperTrailWarnings(const DWARFFile &File,
                              OffsetsStringPool &StringPool);

  void copyInvariantDebugSection(DWARFContext &Dwarf);

  /// Keep information for referenced clang module: already loaded DWARF info
  /// of the clang module and a CompileUnit of the module.
  struct RefModuleUnit {
    RefModuleUnit(DWARFFile &File, std::unique_ptr<CompileUnit> Unit)
        : File(File), Unit(std::move(Unit)) {}
    RefModuleUnit(RefModuleUnit &&Other)
        : File(Other.File), Unit(std::move(Other.Unit)) {}
    RefModuleUnit(const RefModuleUnit &) = delete;

    DWARFFile &File;
    std::unique_ptr<CompileUnit> Unit;
  };
  using ModuleUnitListTy = std::vector<RefModuleUnit>;

  /// Keeps track of data associated with one object during linking.
  struct LinkContext {
    DWARFFile &File;
    UnitListTy CompileUnits;
    ModuleUnitListTy ModuleUnits;
    bool Skip = false;

    LinkContext(DWARFFile &File) : File(File) {}

    /// Clear part of the context that's no longer needed when we're done with
    /// the debug object.
    void clear() {
      CompileUnits.clear();
      ModuleUnits.clear();
      File.unload();
    }
  };

  /// Called before emitting object data
  void cleanupAuxiliarryData(LinkContext &Context);

  /// Look at the parent of the given DIE and decide whether they should be
  /// kept.
  void lookForParentDIEsToKeep(unsigned AncestorIdx, CompileUnit &CU,
                               unsigned Flags,
                               SmallVectorImpl<WorklistItem> &Worklist);

  /// Look at the children of the given DIE and decide whether they should be
  /// kept.
  void lookForChildDIEsToKeep(const DWARFDie &Die, CompileUnit &CU,
                              unsigned Flags,
                              SmallVectorImpl<WorklistItem> &Worklist);

  /// Look at DIEs referenced by the given DIE and decide whether they should be
  /// kept. All DIEs referenced though attributes should be kept.
  void lookForRefDIEsToKeep(const DWARFDie &Die, CompileUnit &CU,
                            unsigned Flags, const UnitListTy &Units,
                            const DWARFFile &File,
                            SmallVectorImpl<WorklistItem> &Worklist);

  /// Mark context corresponding to the specified \p Die as having canonical
  /// die, if applicable.
  void markODRCanonicalDie(const DWARFDie &Die, CompileUnit &CU);

  /// \defgroup FindRootDIEs Find DIEs corresponding to Address map entries.
  ///
  /// @{
  /// Recursively walk the \p DIE tree and look for DIEs to
  /// keep. Store that information in \p CU's DIEInfo.
  ///
  /// The return value indicates whether the DIE is incomplete.
  void lookForDIEsToKeep(AddressesMap &RelocMgr, RangesTy &Ranges,
                         const UnitListTy &Units, const DWARFDie &DIE,
                         const DWARFFile &File, CompileUnit &CU,
                         unsigned Flags);

  /// Check whether specified \p CUDie is a Clang module reference.
  /// if \p Quiet is false then display error messages.
  /// \return first == true if CUDie is a Clang module reference.
  ///         second == true if module is already loaded.
  std::pair<bool, bool> isClangModuleRef(const DWARFDie &CUDie,
                                         std::string &PCMFile,
                                         LinkContext &Context, unsigned Indent,
                                         bool Quiet);

  /// If this compile unit is really a skeleton CU that points to a
  /// clang module, register it in ClangModules and return true.
  ///
  /// A skeleton CU is a CU without children, a DW_AT_gnu_dwo_name
  /// pointing to the module, and a DW_AT_gnu_dwo_id with the module
  /// hash.
  bool registerModuleReference(const DWARFDie &CUDie, LinkContext &Context,
                               objFileLoader Loader,
                               CompileUnitHandler OnCUDieLoaded,
                               unsigned Indent = 0);

  /// Recursively add the debug info in this clang module .pcm
  /// file (and all the modules imported by it in a bottom-up fashion)
  /// to ModuleUnits.
  Error loadClangModule(objFileLoader Loader, const DWARFDie &CUDie,
                        const std::string &PCMFile, LinkContext &Context,
                        CompileUnitHandler OnCUDieLoaded, unsigned Indent = 0);

  /// Clone specified Clang module unit \p Unit.
  Error cloneModuleUnit(LinkContext &Context, RefModuleUnit &Unit,
                        DeclContextTree &ODRContexts,
                        OffsetsStringPool &OffsetsStringPool,
                        unsigned Indent = 0);

  /// Mark the passed DIE as well as all the ones it depends on as kept.
  void keepDIEAndDependencies(AddressesMap &RelocMgr, RangesTy &Ranges,
                              const UnitListTy &Units, const DWARFDie &DIE,
                              CompileUnit::DIEInfo &MyInfo,
                              const DWARFFile &File, CompileUnit &CU,
                              bool UseODR);

  unsigned shouldKeepDIE(AddressesMap &RelocMgr, RangesTy &Ranges,
                         const DWARFDie &DIE, const DWARFFile &File,
                         CompileUnit &Unit, CompileUnit::DIEInfo &MyInfo,
                         unsigned Flags);

  /// Check if a variable describing DIE should be kept.
  /// \returns updated TraversalFlags.
  unsigned shouldKeepVariableDIE(AddressesMap &RelocMgr, const DWARFDie &DIE,
                                 CompileUnit::DIEInfo &MyInfo, unsigned Flags);

  unsigned shouldKeepSubprogramDIE(AddressesMap &RelocMgr, RangesTy &Ranges,
                                   const DWARFDie &DIE, const DWARFFile &File,
                                   CompileUnit &Unit,
                                   CompileUnit::DIEInfo &MyInfo,
                                   unsigned Flags);

  /// Resolve the DIE attribute reference that has been extracted in \p
  /// RefValue. The resulting DIE might be in another CompileUnit which is
  /// stored into \p ReferencedCU. \returns null if resolving fails for any
  /// reason.
  DWARFDie resolveDIEReference(const DWARFFile &File, const UnitListTy &Units,
                               const DWARFFormValue &RefValue,
                               const DWARFDie &DIE, CompileUnit *&RefCU);

  /// @}

  /// \defgroup Methods used to link the debug information
  ///
  /// @{

  struct DWARFLinkerOptions;

  class DIECloner {
    DWARFLinker &Linker;
    DwarfEmitter *Emitter;
    DWARFFile &ObjFile;

    /// Allocator used for all the DIEValue objects.
    BumpPtrAllocator &DIEAlloc;

    std::vector<std::unique_ptr<CompileUnit>> &CompileUnits;

    bool Update;

  public:
    DIECloner(DWARFLinker &Linker, DwarfEmitter *Emitter, DWARFFile &ObjFile,
              BumpPtrAllocator &DIEAlloc,
              std::vector<std::unique_ptr<CompileUnit>> &CompileUnits,
              bool Update)
        : Linker(Linker), Emitter(Emitter), ObjFile(ObjFile),
          DIEAlloc(DIEAlloc), CompileUnits(CompileUnits), Update(Update) {}

    /// Recursively clone \p InputDIE into an tree of DIE objects
    /// where useless (as decided by lookForDIEsToKeep()) bits have been
    /// stripped out and addresses have been rewritten according to the
    /// address map.
    ///
    /// \param OutOffset is the offset the cloned DIE in the output
    /// compile unit.
    /// \param PCOffset (while cloning a function scope) is the offset
    /// applied to the entry point of the function to get the linked address.
    /// \param Die the output DIE to use, pass NULL to create one.
    /// \returns the root of the cloned tree or null if nothing was selected.
    DIE *cloneDIE(const DWARFDie &InputDIE, const DWARFFile &File,
                  CompileUnit &U, OffsetsStringPool &StringPool,
                  int64_t PCOffset, uint32_t OutOffset, unsigned Flags,
                  bool IsLittleEndian, DIE *Die = nullptr);

    /// Construct the output DIE tree by cloning the DIEs we
    /// chose to keep above. If there are no valid relocs, then there's
    /// nothing to clone/emit.
    uint64_t cloneAllCompileUnits(DWARFContext &DwarfContext,
                                  const DWARFFile &File,
                                  OffsetsStringPool &StringPool,
                                  bool IsLittleEndian);

  private:
    using AttributeSpec = DWARFAbbreviationDeclaration::AttributeSpec;

    /// Information gathered and exchanged between the various
    /// clone*Attributes helpers about the attributes of a particular DIE.
    struct AttributesInfo {
      /// Names.
      DwarfStringPoolEntryRef Name, MangledName, NameWithoutTemplate;

      /// Offsets in the string pool.
      uint32_t NameOffset = 0;
      uint32_t MangledNameOffset = 0;

      /// Value of AT_low_pc in the input DIE
      uint64_t OrigLowPc = std::numeric_limits<uint64_t>::max();

      /// Value of AT_high_pc in the input DIE
      uint64_t OrigHighPc = 0;

      /// Value of DW_AT_call_return_pc in the input DIE
      uint64_t OrigCallReturnPc = 0;

      /// Value of DW_AT_call_pc in the input DIE
      uint64_t OrigCallPc = 0;

      /// Offset to apply to PC addresses inside a function.
      int64_t PCOffset = 0;

      /// Does the DIE have a low_pc attribute?
      bool HasLowPc = false;

      /// Does the DIE have a ranges attribute?
      bool HasRanges = false;

      /// Is this DIE only a declaration?
      bool IsDeclaration = false;

      AttributesInfo() = default;
    };

    /// Helper for cloneDIE.
    unsigned cloneAttribute(DIE &Die, const DWARFDie &InputDIE,
                            const DWARFFile &File, CompileUnit &U,
                            OffsetsStringPool &StringPool,
                            const DWARFFormValue &Val,
                            const AttributeSpec AttrSpec, unsigned AttrSize,
                            AttributesInfo &AttrInfo, bool IsLittleEndian);

    /// Clone a string attribute described by \p AttrSpec and add
    /// it to \p Die.
    /// \returns the size of the new attribute.
    unsigned cloneStringAttribute(DIE &Die, AttributeSpec AttrSpec,
                                  const DWARFFormValue &Val, const DWARFUnit &U,
                                  OffsetsStringPool &StringPool,
                                  AttributesInfo &Info);

    /// Clone an attribute referencing another DIE and add
    /// it to \p Die.
    /// \returns the size of the new attribute.
    unsigned cloneDieReferenceAttribute(DIE &Die, const DWARFDie &InputDIE,
                                        AttributeSpec AttrSpec,
                                        unsigned AttrSize,
                                        const DWARFFormValue &Val,
                                        const DWARFFile &File,
                                        CompileUnit &Unit);

    /// Clone a DWARF expression that may be referencing another DIE.
    void cloneExpression(DataExtractor &Data, DWARFExpression Expression,
                         const DWARFFile &File, CompileUnit &Unit,
                         SmallVectorImpl<uint8_t> &OutputBuffer);

    /// Clone an attribute referencing another DIE and add
    /// it to \p Die.
    /// \returns the size of the new attribute.
    unsigned cloneBlockAttribute(DIE &Die, const DWARFFile &File,
                                 CompileUnit &Unit, AttributeSpec AttrSpec,
                                 const DWARFFormValue &Val, unsigned AttrSize,
                                 bool IsLittleEndian);

    /// Clone an attribute referencing another DIE and add
    /// it to \p Die.
    /// \returns the size of the new attribute.
    unsigned cloneAddressAttribute(DIE &Die, AttributeSpec AttrSpec,
                                   const DWARFFormValue &Val,
                                   const CompileUnit &Unit,
                                   AttributesInfo &Info);

    /// Clone a scalar attribute  and add it to \p Die.
    /// \returns the size of the new attribute.
    unsigned cloneScalarAttribute(DIE &Die, const DWARFDie &InputDIE,
                                  const DWARFFile &File, CompileUnit &U,
                                  AttributeSpec AttrSpec,
                                  const DWARFFormValue &Val, unsigned AttrSize,
                                  AttributesInfo &Info);

    /// Get the potential name and mangled name for the entity
    /// described by \p Die and store them in \Info if they are not
    /// already there.
    /// \returns is a name was found.
    bool getDIENames(const DWARFDie &Die, AttributesInfo &Info,
                     OffsetsStringPool &StringPool, bool StripTemplate = false);

    uint32_t hashFullyQualifiedName(DWARFDie DIE, CompileUnit &U,
                                    const DWARFFile &File,
                                    int RecurseDepth = 0);

    /// Helper for cloneDIE.
    void addObjCAccelerator(CompileUnit &Unit, const DIE *Die,
                            DwarfStringPoolEntryRef Name,
                            OffsetsStringPool &StringPool, bool SkipPubSection);
  };

  /// Assign an abbreviation number to \p Abbrev
  void assignAbbrev(DIEAbbrev &Abbrev);

  /// Compute and emit .debug_ranges section for \p Unit, and
  /// patch the attributes referencing it.
  void patchRangesForUnit(const CompileUnit &Unit, DWARFContext &Dwarf,
                          const DWARFFile &File) const;

  /// Generate and emit the DW_AT_ranges attribute for a compile_unit if it had
  /// one.
  void generateUnitRanges(CompileUnit &Unit) const;

  /// Extract the line tables from the original dwarf, extract the relevant
  /// parts according to the linked function ranges and emit the result in the
  /// .debug_line section.
  void patchLineTableForUnit(CompileUnit &Unit, DWARFContext &OrigDwarf,
                             const DWARFFile &File);

  /// Emit the accelerator entries for \p Unit.
  void emitAcceleratorEntriesForUnit(CompileUnit &Unit);
  void emitDwarfAcceleratorEntriesForUnit(CompileUnit &Unit);
  void emitAppleAcceleratorEntriesForUnit(CompileUnit &Unit);
  void emitPubAcceleratorEntriesForUnit(CompileUnit &Unit);

  /// Patch the frame info for an object file and emit it.
  void patchFrameInfoForObject(const DWARFFile &, RangesTy &Ranges,
                               DWARFContext &, unsigned AddressSize);

  /// FoldingSet that uniques the abbreviations.
  FoldingSet<DIEAbbrev> AbbreviationsSet;

  /// Storage for the unique Abbreviations.
  /// This is passed to AsmPrinter::emitDwarfAbbrevs(), thus it cannot be
  /// changed to a vector of unique_ptrs.
  std::vector<std::unique_ptr<DIEAbbrev>> Abbreviations;

  /// DIELoc objects that need to be destructed (but not freed!).
  std::vector<DIELoc *> DIELocs;

  /// DIEBlock objects that need to be destructed (but not freed!).
  std::vector<DIEBlock *> DIEBlocks;

  /// Allocator used for all the DIEValue objects.
  BumpPtrAllocator DIEAlloc;
  /// @}

  DwarfEmitter *TheDwarfEmitter;
  std::vector<LinkContext> ObjectContexts;

  bool AtLeastOneAppleAccelTable = false;
  bool AtLeastOneDwarfAccelTable = false;

  /// The CIEs that have been emitted in the output section. The actual CIE
  /// data serves a the key to this StringMap, this takes care of comparing the
  /// semantics of CIEs defined in different object files.
  StringMap<uint32_t> EmittedCIEs;

  /// Offset of the last CIE that has been emitted in the output
  /// .debug_frame section.
  uint32_t LastCIEOffset = 0;

  /// Apple accelerator tables.
  AccelTable<DWARF5AccelTableStaticData> DebugNames;
  AccelTable<AppleAccelTableStaticOffsetData> AppleNames;
  AccelTable<AppleAccelTableStaticOffsetData> AppleNamespaces;
  AccelTable<AppleAccelTableStaticOffsetData> AppleObjc;
  AccelTable<AppleAccelTableStaticTypeData> AppleTypes;

  /// Mapping the PCM filename to the DwoId.
  StringMap<uint64_t> ClangModules;

  DwarfLinkerClient DwarfLinkerClientID;

  std::function<StringRef(StringRef)> StringsTranslator = nullptr;

  /// A unique ID that identifies each compile unit.
  unsigned UniqueUnitID = 0;

  /// linking options
  struct DWARFLinkerOptions {
    /// DWARF version for the output.
    uint16_t TargetDWARFVersion = 0;

    /// Generate processing log to the standard output.
    bool Verbose = false;

    /// Print statistics.
    bool Statistics = false;

    /// Verify the input DWARF.
    bool VerifyInputDWARF = false;

    /// Skip emitting output
    bool NoOutput = false;

    /// Do not unique types according to ODR
    bool NoODR = false;

    /// Update
    bool Update = false;

    /// Whether we want a static variable to force us to keep its enclosing
    /// function.
    bool KeepFunctionForStatic = false;

    /// Number of threads.
    unsigned Threads = 1;

    /// The accelerator table kind
    DwarfLinkerAccelTableKind TheAccelTableKind =
        DwarfLinkerAccelTableKind::Default;

    /// Prepend path for the clang modules.
    std::string PrependPath;

    // warning handler
    messageHandler WarningHandler = nullptr;

    // error handler
    messageHandler ErrorHandler = nullptr;

    /// A list of all .swiftinterface files referenced by the debug
    /// info, mapping Module name to path on disk. The entries need to
    /// be uniqued and sorted and there are only few entries expected
    /// per compile unit, which is why this is a std::map.
    /// this is dsymutil specific fag.
    swiftInterfacesMap *ParseableSwiftInterfaces = nullptr;

    /// A list of remappings to apply to file paths.
    objectPrefixMap *ObjectPrefixMap = nullptr;
  } Options;
};

} // end namespace llvm

#endif // LLVM_DWARFLINKER_DWARFLINKER_H
