#include <stdlib.h>
#include <string.h>

struct S {
  char a;
  int b[10];
};

static void test(int *p);

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

void foo4(int n) {
  struct S *p = (struct S *)malloc(sizeof(struct S) * n);

  for (struct S *q = p; q; q++) {
    q->a = 0;
  }
}

void foo5(int n, const char *s) {
  int *p = (int *)malloc(sizeof(int) * n);

  // we need to maintain more metadata of bounds to this line
  int *q = p + strlen(s);
}

void foo6(int n) {
  int *p = (int *)malloc(sizeof(int) * n);

  test(p+1);
}

int foo7(int n) {
  int *p = (int *)malloc(sizeof(int) * n);

  // we need to maintain more metadata of bounds to this line
  int *q = (int *)((long)p + 1);

  int res = *q;
  free(p);

  return res;
}

