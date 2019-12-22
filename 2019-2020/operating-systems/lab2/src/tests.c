#include "tests.h"

int run_tests() {
  center_print("---Buddy allocator---");
  
  center_print("---------- ALLOC ----------");
  
  center_print("alloc 200 Mb");
  divide(pool_ptr);
  // divide(pool_ptr);
  print_pool();

  init_pool();
  divide(pool_ptr);
  divide(pool_ptr);
  // divide(((block_t*)((block_t*)((block_t*)pool_ptr)->next)->next)->next);
  divide(pool_ptr);

  center_print("alloc 54 and 96 Mb");
  print_pool();
  
  printf("\n\n");
  // center_print("Merging 0th order:");
  
  init_pool();
  divide(pool_ptr);
  // divide(pool_ptr);
  divide((block_t*)((block_t*)((block_t*)pool_ptr)->next)->next);
  divide(pool_ptr);
  
  center_print("---------- FREE ----------");
  center_print("Free 54 Mb and alloc 200 Mb");
  print_pool();
  
  init_pool();
  
  divide(pool_ptr);
  divide(pool_ptr);
  
  // center_print("Merging 2nd order:");
  center_print("Free 200 Mb");
  print_pool();
  // printf("%d %p %p %p\n", pool_size, pool_ptr, pool_ptr_end, sbrk(0));
  
  init_pool();
  // divide(pool_ptr);
  // divide(pool_ptr);
  
  center_print("Free 128 Mb and 256 Mb");
  print_pool();
  
  return 0;
}
