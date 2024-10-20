ROOT_DIR := $(shell realpath ./)
BUILD_DIR := $(ROOT_DIR)/llvm-project/build
INCLUDE_DIR := $(ROOT_DIR)/llvm-project/llvm/include/llvm/Transforms/Utils
SRC_DIR := $(ROOT_DIR)/llvm-project/llvm/lib/Transforms/Utils
TEST_DIR := $(ROOT_DIR)/tests

CC := clang
OPT := $(BUILD_DIR)/bin/opt

CFLAGS := -c -emit-llvm -S -I/opt/homebrew/opt/lua/include/lua

TEST_FILES := $(wildcard redis/src/*.c)
TEST_LL_FILES := $(TEST_FILES:.c=.ll)
LL_FILES := $(patsubst redis/src/%.ll, tests/%.ll, $(TEST_FILES:.c=.ll))
LL_OPT_FILES := $(LL_FILES:.ll=.opt.ll)

all: all-tests

redis/src/%.ll: redis/src/%.c
	@echo "Compiling src to human-readable LLVM IR"
	- $(CC) $(CFLAGS) $< -o $@

all-tests: $(TEST_LL_FILES)
	mv redis/src/*.ll $(TEST_DIR)

cptc: $(INCLUDE_DIR)/CPTC.h $(SRC_DIR)/CPTC.cpp
	@echo "Compiling CPTC"
	cd $(BUILD_DIR) && ninja opt

test: test.c cptc
	$(CC) -c -emit-llvm -S test.c -o test.ll
	$(OPT) -stats -S -passes=cptc test.ll -o test.opt.ll

opt: cptc all-opt

tests/%.opt.ll: tests/%.ll
	$(OPT) -stats -S -passes=cptc $< -o $@ &> $@.log

all-opt: $(LL_OPT_FILES)

.PHONY: all clean
clean:
	rm -f *.ll
