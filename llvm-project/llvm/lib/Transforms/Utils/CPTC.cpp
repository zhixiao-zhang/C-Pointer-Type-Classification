#include "llvm/Transforms/Utils/CPTC.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Type.h"

using namespace llvm;

#define DEBUG_TYPE "CPTC"

STATISTIC(NumPointerArith, "Number of pointer arithmetic operations");

PreservedAnalyses CPTCPass::run(Module &M,
                                ModuleAnalysisManager &AM) {
  // Run the transformation on the function
  for (Function &F : M) {
    for (BasicBlock &BB : F) {
      for (Instruction &I : BB) {
        // If this is a GEP instruction
        if (GetElementPtrInst *GEP = dyn_cast<GetElementPtrInst>(&I)) {
          // If this gep instruction if for pointer arithmetic
          // then increment the counter
          if (GEP.isInBounds())
            NumPointerArith++;
        }
      }
    }
  }

  return PreservedAnalyses::all();
}
