#include <stdlib.h>
#define N 10

void foo() {
  int *p = (int *)malloc(sizeof(int) * N);

  for (int i = 0; i < N; i++) {
    p[i] = i;
  }

  p = (int *)malloc(sizeof(int) * N);

  int *p2 = p + 3;
  int *p3 = p + 5;

  p++;

  int *p4 = (int *)((long)p + 3);

  int q = 10;
  int *q2 = &q;
  (*q2)++;
  q2 = q2 + 10;
}
