#ifndef __ALLOCATOR_H_
#define __ALLOCATOR_H_

#include "utils.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern const int pool_size;
extern const char max_order;
extern const int min_block_size;
extern void *pool_ptr;
extern void *tree_ptr;
extern void *pool_ptr_end;

#define PTR void *
#define NODE_SIZE sizeof(node_t)

typedef enum { Left = 0, Right } block_side;

// size: 16
struct block_ {
  void *next;
  char is_free;
  char order;
  block_side side;
};

struct mem_block_ {
  struct mem_block_* next;
  char is_free;
  block_side side;
};

struct h_table_ {
  struct mem_block_ **orders;
};

typedef struct _node node_t;
typedef struct _tree tree_t;
typedef struct block_ block_t;
typedef struct mem_block_ mem_block_t;
typedef struct h_table_ h_table_t;

// size_t required_order(size_t size); 
void add_block(h_table_t* htable, size_t order, mem_block_t block);
void del_block(unsigned char order, void* ptr);

void init_pool();

size_t order_to_size(char ord);
void divide(block_t *block);

void search_block(size_t size);
void *make_tree();
void *make_node(node_t *ptr);

PTR mem_alloc(size_t size);
PTR mem_realloc(PTR addr, size_t size);
PTR mem_free(PTR addr);

void print_pool();

#endif
