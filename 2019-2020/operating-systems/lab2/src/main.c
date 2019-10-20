#include "allocator.h"
#include "utils.h"
#include "tests.h"

int pool_size = 1024;
void* pool_ptr;
void* pool_ptr_end;

int main(int argc, char const *argv[]) {
  pool_ptr = malloc(pool_size);
  pool_ptr_end = pool_ptr + pool_size;
  run_tests()
    ? printf("Testing failed!\n")
    : printf("Testing successfull!\n");

  free(pool_ptr);
  return EXIT_SUCCESS;
}
