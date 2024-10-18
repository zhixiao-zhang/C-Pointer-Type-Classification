ROOT_DIR := $(shell realpath ./)
BUILD_DIR := $(ROOT_DIR)/llvm-project/build
INCLUDE_DIR := $(ROOT_DIR)/llvm-project/llvm/include/llvm/Transforms/Utils
SRC_DIR := $(ROOT_DIR)/llvm-project/llvm/lib/Transforms/Utils

CC := clang
OPT := $(BUILD_DIR)/bin/opt

CFLAGS := -c -emit-llvm -S

cptc: $(INCLUDE_DIR)/CPTC.h $(SRC_DIR)/CPTC.cpp
	@echo "Compiling CPTC"
	cd $(BUILD_DIR) && ninja opt

test: test.c
	$(CC) -c -emit-llvm -S test.c -o test.ll

test_O1: test.c
	$(CC) -c -emit-llvm -S -O1 test.c -o test_O1.ll

opt: cptc test
	$(OPT) -stats -S -passes=cptc test.ll -o test.opt.ll

.PHONY: all clean
clean:
	rm -f *.ll
