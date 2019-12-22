#include "linked_list.h"

linked_list_t* ll_init(void* init_ptr) {
  linked_list_t* res = init_ptr;
  res->next = NULL;
  res->data = NULL;
  return res;
}

// linked_list_t* ll_search(uchar ord, )

void ll_add(linked_list_t* ll, void* data) {
  // if (ll->data == NULL) {
  //   ll->data = data;
  //   return;
  // }
  while (ll->data != NULL) {
    ll = ll->next;
  }
  ll->data = data;
  linked_list_t* next = (linked_list_t*)malloc(sizeof(linked_list_t));
  next->data = NULL;
  next->next = NULL;
  ll->next = next;
}

void ll_del(linked_list_t* ll, void* ptr) {
  // while 
}
