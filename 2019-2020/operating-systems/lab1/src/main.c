#include "allocator.h"
#include "utils.h"
#include "tests.h"

#define POOL_SIZE 1024;

int main(int argc, char const *argv[]) {
  int pool_size = POOL_SIZE;
  void* pool_ptr = malloc(pool_size);

  run_tests(pool_ptr, pool_size)
    ? printf("Testing successfull!\n")
    : printf("Testing failed!\n");

  free(pool_ptr);
  return EXIT_SUCCESS;
}
