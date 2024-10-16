#ifndef LLVM_TRANSFORMS_UTILS_CPTC_H
#define LLVM_TRANSFORMS_UTILS_CPTC_H

#include "llvm/IR/PassManager.h"
#include "llvm/IR/Instruction.h"

namespace llvm {

  class CPointerTypeClass : public PassInfoMixin<CPointerTypeClass> {
    public:
      PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
      StringRef getPassName() const { return "C Pointer Type Classification Pass"; }
    private:
      FunctionCallee query;
  };
} // namespace llvm

#endif
