#include <stdlib.h>

void foo1(int n) {
  int *p = (int *)malloc(sizeof(int) * n);

  for (int i = 0; i < n; i++) {
    p[i] = p[i-1];
  }
}

int foo2(int n) {
  int *p = (int *)malloc(sizeof(int) * n);

  // we need to maintain more metadata of bounds to this line
  int *q = p + 2;

  int res = *(p + 1);
  free(p);

  return res;
}

int foo3(int *p) {
  // we need to maintain more metadata of bounds to this line
  return *p++;
}

int foo4(int n) {
  int *p = (int *)malloc(sizeof(int) * n);

  // we need to maintain more metadata of bounds to this line
  int *q = (int *)((long)p + 1);

  int res = *q;
  free(p);

  return res;
}
