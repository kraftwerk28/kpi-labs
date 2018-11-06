//
// Created by kraftwerk28 on 30.10.18.
//

#include "groups.h"

#define children_count 20

kindergarten::kindergarten()
{
    nursery_group = vector<nursery>(children_count);
    young_group = vector<young>(children_count);
    middle_group = vector<middle>(children_count);
    old_group = vector<old>(children_count);
}
