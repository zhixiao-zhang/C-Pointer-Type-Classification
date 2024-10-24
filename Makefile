ROOT_DIR := $(shell realpath ./)
BUILD_DIR := $(ROOT_DIR)/llvm-project/build
INCLUDE_DIR := $(ROOT_DIR)/llvm-project/llvm/include/llvm/Transforms/Utils
SRC_DIR := $(ROOT_DIR)/llvm-project/llvm/lib/Transforms/Utils
TEST_DIR := $(ROOT_DIR)/tests
TEST_SOURCE_DIR ?= $(ROOT_DIR)

CC := clang
OPT := $(BUILD_DIR)/bin/opt

CFLAGS := -c -emit-llvm -S -I/opt/homebrew/opt/lua/include/lua

TEST_FILES := $(wildcard $(TEST_SOURCE_DIR)/*.c)
TEST_LL_FILES := $(TEST_FILES:.c=.ll)
LL_FILES := $(patsubst $(TEST_SOURCE_DIR)/%.ll, tests/%.ll, $(TEST_LL_FILES))
LL_OPT_FILES := $(LL_FILES:.ll=.opt.ll)

all: all-tests

$(TEST_SOURCE_DIR)/%.ll: $(TEST_SOURCE_DIR)/%.c
	@echo "Compiling src to human-readable LLVM IR"
	- $(CC) $(CFLAGS) $< -o $@

all-tests: $(TEST_LL_FILES)
	mkdir -p $(TEST_DIR)
	mv $(TEST_SOURCE_DIR)/*.ll $(TEST_DIR)

cptc: $(INCLUDE_DIR)/CPTC.h $(SRC_DIR)/CPTC.cpp
	@echo "Compiling CPTC"
	cd $(BUILD_DIR) && ninja opt

opt: cptc all-opt

tests/%.opt.ll: tests/%.ll
	$(OPT) -stats -S -passes=cptc $< -o $@ &> $@.log

all-opt: $(LL_OPT_FILES)

.PHONY: all clean
clean:
	rm -f *.ll *.log
