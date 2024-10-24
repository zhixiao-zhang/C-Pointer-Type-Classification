#include "llvm/Transforms/Utils/CPTC.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Constants.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

#define DEBUG_TYPE "CPTC"

STATISTIC(NumPointerArith, "Number of pointer arithmetic operations");

bool CPTCPass::findGEPStore(GetElementPtrInst *GEP) {
  for (auto *User : GEP->users()) {
    if (StoreInst *SI = dyn_cast<StoreInst>(User)) {
      return SI->getValueOperand()->getType()->isPointerTy();
    }
    if (CallInst *F = dyn_cast<CallInst>(User)) {
      return true;
    }
  }
  return false;
}

bool CPTCPass::findPtrSource(Value *V) {
  if (LoadInst *LI = dyn_cast<LoadInst>(V)) {
    if (LI->getType()->isPointerTy()) {
      return true;
    }
  }
  if (GetElementPtrInst *GEP = dyn_cast<GetElementPtrInst>(V)) {
    return true;
  }
  return false;
}

PreservedAnalyses CPTCPass::run(Module &M,
                                ModuleAnalysisManager &AM) {
  // Run the transformation on the function
  for (Function &F : M) {
    for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ++I) {
      // pattern 1: load ptr, gep, store ptr
      if (GetElementPtrInst *GEP = dyn_cast<GetElementPtrInst>(&*I)) {
        // Exclude GEPs for function pointers which are member of a struct
        if (GEP->getSourceElementType()->isStructTy() ||
            !GEP->getSourceElementType()->isIntOrIntVectorTy()) {
          continue;
        }
        if (findGEPStore(GEP) && findPtrSource(GEP->getPointerOperand())) {
          ++NumPointerArith;
          errs() << "Found pattern 1 in Function " << F.getName() << "(): " << *GEP << "\n";
        }
      } else if (PtrToIntInst *PTI = dyn_cast<PtrToIntInst>(&*I)) {
        // pattern 2: ptrtoint, arithmetic, inttoptr
        ++++I;
        IntToPtrInst *ITP = dyn_cast<IntToPtrInst>(&*I);
        if (!ITP) {
          continue;
        }
        ++NumPointerArith;
        errs() << "Found pattern 2 in Function " << F.getName() << "()\n";
      }
    }
  }

  return PreservedAnalyses::all();
}
