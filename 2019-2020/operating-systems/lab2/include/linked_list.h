#ifndef __LINKED_LIST_H__
#define __LINKED_LIST_H__

#include <unistd.h>
#include <stdlib.h>

typedef unsigned char uchar;

struct linked_list_
{
  struct linked_list_* next;
  void* data;
};

typedef struct linked_list_ linked_list_t;

linked_list_t* ll_init(void* init_ptr);
linked_list_t* ll_make_node(void* data);

// linked_list_t* ll_search(uchar ord, )

void ll_add(linked_list_t* ll, void* data);
void ll_del(linked_list_t* ll, void* ptr);


#endif
