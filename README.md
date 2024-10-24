# C Pointer Type Classification

The path of CPTC.cpp is llvm-project/llvm/lib/Transforms/Utils/CPTC.cpp.

## Usage

There is a CI script that can be used to run the CPTC pass on test files. The variable TEST_SOURCE_DIR, defined in Makefile, should be the path to the directory containing the test files. By default, its value is set to the path of the root directory of the project. Hence, It will run the pass on test.c, which contains some basic test cases.

```shell
make
make opt
```
If you want to specify your own test files, you can pass the path to the Makefile as follows:

```shell
make TEST_SOURCE_DIR=redis/src
make opt -k # there are some files can't be compiled
```

You will find the output files and logs in the tests directory.

You may run git submodule update to get redis and parson, which are used as test files.

```shell
git submodule update --init --recursive .
```

TBD
