#include "allocator.h"

/*

HEADER SIZE = 17 bytes

     1       8      8
-------------------------------------   ---------------------------------
| isfree | prev | next | data...        | isfree | prev | next | data...
-------------------------------------   ---------------------------------
*/

myptr_t* search_free(PTR start_ptr, size_t required_size) {
  myptr_t* cur = start_ptr;
  while (!cur->isfree) {
    cur = cur->next;
  }
  if ((char*)cur + required_size - (char*)start_ptr > 0x400) {
    cur = NULL;
  }
  return cur;
}

myptr_t* myptr_new() {
  myptr_t* res = (myptr_t*)malloc(sizeof(myptr_t));
  res->isfree = 0x01;
  res->next = NULL;
  res->prev = NULL;
  return res;
}

size_t ptr_size(myptr_t* p) {
  if (p->next == NULL) {
    return 0;
  } else {
    return (PTR)p->next - (PTR)p - HEADER_SIZE;
  }
}

//----------------------------------------------------------------------------//
extern myptr_t* mymalloc(PTR start, size_t size) {
  myptr_t* cur = search_free(start, size);
  if (cur == NULL) {
    printf("Failed to allocate memory\n");
    exit(1);
  }
  cur->isfree = 0x0;
  cur->next = (PTR)cur + size + HEADER_SIZE;

  myptr_t* next = cur->next;
  next->isfree = 0x1;
  next->prev = cur;
  next->next = NULL;

  return cur;
}

extern myptr_t* mycalloc(PTR start, unsigned count, size_t required_size) {
  return mymalloc(start, count * required_size);
}

extern myptr_t* myrealloc(PTR start, myptr_t* ptr, size_t new_size) {
  myptr_t* cur = mymalloc(start, new_size);
  ptr->isfree = 0x1;
  size_t tosz = ptr_size(ptr);
  memcpy(deref(cur), deref(ptr), tosz);
  return cur;
}

extern void myfree(PTR start, PTR ptr) {
  myptr_t* mp = ptr;
  mp->isfree = 0x1;
}

extern PTR deref(myptr_t* p) {
  return (void*)p + HEADER_SIZE + 0x1;
}

void print_pool(PTR start) {
  printf("\nMemory map:\n%-5s%-15s%-7s%s\n", "Size", "Ptr", "IsFree", "Block");
  myptr_t* cur = (myptr_t*)start;
  while (cur->next) {
    size_t len = ptr_size(cur);
    char* size_vis = malloc(sizeof(char) * (len * 0x2 + 0x1));
    size_vis[len * 0x2] = '\0';
    memset(size_vis, '|', len);
    printf("%-5ld%-15p%-7d%s\n", len, cur, cur->isfree, size_vis);
    free(size_vis);
    cur = cur->next;
  }
}
