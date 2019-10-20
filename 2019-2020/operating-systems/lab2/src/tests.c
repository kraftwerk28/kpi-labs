#include "tests.h"

int run_tests() {
  printf("%d %p %p %p\n", pool_size, pool_ptr, pool_ptr_end, sbrk(0));
  return 0;
}
