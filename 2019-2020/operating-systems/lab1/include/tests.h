#ifndef __TESTS_H__
#define __TESTS_H__

#include <stdio.h>

#include "allocator.h"

int run_tests(PTR start_ptr, size_t pool_size) {
  myptr_t* init_header = start_ptr;
  init_header->next = NULL;
  init_header->prev = NULL;
  init_header->isfree = 0x1;

  myptr_t* next = mymalloc(start_ptr, 10);
  myptr_t* next2 = mymalloc(start_ptr, 30);
  myptr_t* next3 = mymalloc(start_ptr, 60);
  myptr_t* next4 = mycalloc(start_ptr, 60, 2);
  myptr_t* next5 = mycalloc(start_ptr, 60, 2);
  myptr_t* re1 = myrealloc(start_ptr, next3, 1200);

  myfree(start_ptr, next3->prev);
  
  // printf("Diff: %ld\n", (PTR)next3 - (PTR)init_header);

  print_pool(start_ptr);
  return 1;
}

#endif
