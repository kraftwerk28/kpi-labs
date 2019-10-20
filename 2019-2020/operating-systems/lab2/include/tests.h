#ifndef __TESTS_H__
#define __TESTS_H__

#include <stdio.h>
#include <unistd.h>

#include "allocator.h"

extern int pool_size;
extern void* pool_ptr;
extern void* pool_ptr_end;

int run_tests();

#endif
