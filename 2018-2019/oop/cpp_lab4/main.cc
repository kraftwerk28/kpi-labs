#include <iostream>
#include "groups.h"

int main()
{
    auto *child = new middle();

    kindergarten kg;
    kg.request_place(child);
    kg.unreserve(3, 0);

    delete child;

    return 0;
}