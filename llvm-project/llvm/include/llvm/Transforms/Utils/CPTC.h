#ifndef LLVM_TRANSFORMS_UTILS_CPTC_H
#define LLVM_TRANSFORMS_UTILS_CPTC_H

#include "llvm/IR/PassManager.h"
#include "llvm/IR/Instructions.h"

namespace llvm {

class CPTCPass : public PassInfoMixin<CPTCPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
  StringRef getPassName() const { return "C Pointer Type Classification Pass"; }
private:
  static bool findGEPStore(GetElementPtrInst *GEP);
  static bool findPtrSource(Value *V);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_UTILS_CPTC_H
