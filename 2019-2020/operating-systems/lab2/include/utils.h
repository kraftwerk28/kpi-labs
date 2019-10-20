#ifndef __UTILS_H__
#define __UTILS_H__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int pool_size;
extern void* pool_ptr;
extern void* pool_ptr_end;

void print_byte(char c) {
  char* repr = (char*)malloc(sizeof(char) * 8);
  memset(repr, '0', 8);
  repr[8] = '\0';
  size_t i = 0;
  for (; i < 8; ++i) {
    repr[i] = !!((c << i) & 0x80) + 0x30; // tak nado
  }
  printf("%s\n", repr);
  free(repr);
}

#endif
