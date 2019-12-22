#include "allocator.h"

// size_t required_order(size_t size) {
//   return size / 
// }

void add_block(h_table_t* htable, size_t order, mem_block_t block) {
  mem_block_t* node = (mem_block_t*)malloc(sizeof(mem_block_t));
  memcpy(node, &block, sizeof(mem_block_t));
  // mem_block_t* head;
  mem_block_t* head = htable->orders[order];
  
  if (head != NULL) {
    while (head->next != NULL) {
      head = head->next;
    }
  }
  memcpy(head, node, sizeof(mem_block_t));
  
  
  // while (htable->orders[order] == NULL)
  // {
  //   order--;
  // }
  
  //  = htable->orders[]
}

void del_block(unsigned char order, void* ptr) {
  
}

void init_pool() {
  block_t* left = pool_ptr;
  block_t* right = pool_ptr + pool_size / 2;

  left->next = right;
  right->next = NULL;

  left->is_free = 1;
  right->is_free = 1;

  left->order = max_order;
  right->order = max_order;

  left->side = Left;
  right->side = Right;
}

size_t order_to_size(char ord) {
  size_t two = 1;
  for (size_t i = 0; i < ord; ++i) {
    two *= 2;
  }
  return two * min_block_size;
}

void divide(block_t* block) {
  size_t size = order_to_size(block->order);
  if (size == min_block_size) {
    return;
  }

  block_t* right_buddy = block + size / 2;
  right_buddy->next = block->next;
  block->next = right_buddy;

  block->order -= 1;
  right_buddy->order = block->order;
  right_buddy->is_free = 0;
}

void search_block(size_t size) {

}

PTR mem_alloc(size_t size);
PTR mem_realloc(PTR addr, size_t size);
PTR mem_free(PTR addr);

void print_pool() {
  block_t* cur = pool_ptr;
  while (cur) {
    const size_t block_size = order_to_size(cur->order);
    const size_t len = block_size / min_block_size * 8 + 1;
    char sign = cur->is_free ? '-' : '#';
    cur = cur->next;
    char* str = (char*)malloc(len);
    memset(str, sign, len - 1);

    // attaching label to block repr
    char* label = to_array(block_size);

    str[0] = '|';
    str[len - 2] = '|';
    str[len - 1] = '\0';
    strncpy(str + 1, label, log10(block_size) + 1);

    printf("%s", str);
    free(label);
    free(str);
  }
  printf("\n\n");
}
