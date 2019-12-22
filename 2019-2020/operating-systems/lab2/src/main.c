#include "allocator.h"
#include "utils.h"
#include "tests.h"

const int pool_size = 1024;
const char max_order = 3;
const int min_block_size = 64;
void* pool_ptr;
void* tree_ptr;
void* pool_ptr_end;

int main(int argc, char **argv, char **envp) {
  pool_ptr = malloc(pool_size);
  pool_ptr_end = pool_ptr + pool_size;
  init_pool();
  run_tests()
    ? printf("Testing failed!\n")
    : printf("Testing successfull!\n");

  free(tree_ptr);
  free(pool_ptr);
  return EXIT_SUCCESS;
}
