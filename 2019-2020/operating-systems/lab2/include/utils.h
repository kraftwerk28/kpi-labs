#ifndef __UTILS_H__
#define __UTILS_H__

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern const int pool_size;
extern void* pool_ptr;
extern void* pool_ptr_end;

void print_byte(char c);
char* to_array(int number);
void center_print(const char* _text);

#endif
