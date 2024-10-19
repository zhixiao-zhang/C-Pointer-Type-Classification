#include "llvm/Transforms/Utils/CPTC.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Module.h"

using namespace llvm;

#define DEBUG_TYPE "CPTC"

STATISTIC(NumPointerArith, "Number of pointer arithmetic operations");

PreservedAnalyses CPTCPass::run(Module &M,
                                ModuleAnalysisManager &AM) {
  // Run the transformation on the function
  for (Function &F : M) {
    for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ++I) {
      // pattern 1: load ptr, gep, store ptr
      if (LoadInst *LI = dyn_cast<LoadInst>(&*I)) {
        if (!LI->getPointerOperandType()->isPointerTy())
          continue;
        ++I;
        GetElementPtrInst *GEP = dyn_cast<GetElementPtrInst>(&*I);
        if (!GEP || !GEP->getPointerOperandType()->isPointerTy())
          continue;
        ++I;
        StoreInst *SI = dyn_cast<StoreInst>(&*I);
        if (!SI || !SI->getPointerOperandType()->isPointerTy())
          continue;
        ++NumPointerArith;
        errs() << "Found pattern 1 in Function " << F.getName() << "() (" << *LI << "; " << *GEP << "; " << *SI << ")\n";
      }
      // pattern 2: ptrtoint, arithmetic, inttoptr
      if (IntToPtrInst *ITP = dyn_cast<IntToPtrInst>(&*I)) {
        ++I;
        StoreInst *SI = dyn_cast<StoreInst>(&*I);
        if (!SI || !SI->getPointerOperandType()->isPointerTy())
          continue;
        ++NumPointerArith;
        errs() << "Found pattern 2 in Function " << F.getName() << "()\n";
      }
    }
  }

  return PreservedAnalyses::all();
}
