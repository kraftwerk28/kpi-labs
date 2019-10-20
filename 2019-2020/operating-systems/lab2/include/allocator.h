#ifndef __ALLOCATOR_H_
#define __ALLOCATOR_H_

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

extern int pool_size;
extern void* pool_ptr;
extern void* pool_ptr_end;

#define PTR void*
// #define HEADER_SIZE 17

// typedef struct myptr {
//   char isfree;
//   void* prev;
//   void* next;
// } myptr_t;

// myptr_t* myptr_new();

// myptr_t* search_free(PTR, size_t);

// size_t ptr_size(myptr_t* ptr);
// PTR deref(myptr_t* ptr);
// myptr_t* mymalloc(PTR start, size_t required_size);
// myptr_t* mycalloc(PTR start, unsigned count, size_t required_size);
// myptr_t* myrealloc(PTR start, myptr_t* ptr, size_t new_size);
// void myfree(PTR start, PTR);

PTR mem_alloc(size_t size);
PTR mem_realloc(PTR addr, size_t size);
PTR mem_free(PTR addr);

void print_pool(PTR);

#endif
