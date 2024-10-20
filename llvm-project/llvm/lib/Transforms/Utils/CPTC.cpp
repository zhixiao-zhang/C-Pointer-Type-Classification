#include "llvm/Transforms/Utils/CPTC.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

#define DEBUG_TYPE "CPTC"

STATISTIC(NumPointerArith, "Number of pointer arithmetic operations");

PreservedAnalyses CPTCPass::run(Module &M,
                                ModuleAnalysisManager &AM) {
  // Run the transformation on the function
  for (Function &F : M) {
    for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ) {
      // pattern 1: load ptr, gep, store ptr
      if (LoadInst *LI = dyn_cast<LoadInst>(&*I)) {
        if (!LI->getType()->isPointerTy()) {
          ++I;
          continue;
        }
        ++I;
        while (isa<CallInst>(&*I)) {
          //errs() << "Skipping call instruction: " << *I << "\n";
          ++I;
        }
        GetElementPtrInst *GEP = dyn_cast<GetElementPtrInst>(&*I);
        // Exclude GEPs for function pointers which are member of a struct
        if (!GEP)
          continue;
        if (GEP->getSourceElementType()->isStructTy()) {
          if (GEP->getNumOperands() != 2) {
            ++I;
            continue;
          }
        } else {
          if (!GEP->getSourceElementType()->isIntOrIntVectorTy()) {
            ++I;
            continue;
          }
        }
        ++I;
        StoreInst *SI = dyn_cast<StoreInst>(&*I);
        if (!SI)
          continue;
        if (!SI->getValueOperand()->getType()->isPointerTy()) {
          ++I;
          continue;
        }
        ++NumPointerArith;
        ++I;
        errs() << "Found pattern 1 in Function " << F.getName() << "() (" << *LI << "; " << *GEP << "; " << *SI << ")\n";
      } else if (IntToPtrInst *ITP = dyn_cast<IntToPtrInst>(&*I)) {
        // pattern 2: ptrtoint, arithmetic, inttoptr
        ++I;
        StoreInst *SI = dyn_cast<StoreInst>(&*I);
        if (!SI)
          continue;
        if (!SI->getValueOperand()->getType()->isPointerTy()) {
          ++I;
          continue;
        }
        ++NumPointerArith;
        ++I;
        errs() << "Found pattern 2 in Function " << F.getName() << "()\n";
      } else {
        ++I;
      }
    }
  }

  return PreservedAnalyses::all();
}
