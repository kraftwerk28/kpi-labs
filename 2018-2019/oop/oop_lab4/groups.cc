//
// Created by kraftwerk28 on 30.10.18.
//

#include "groups.h"


kindergarten::kindergarten()
{
    nursery_group = new kindergarten_group *[children_count];
    young_group = new kindergarten_group *[children_count];
    middle_group = new kindergarten_group *[children_count];
    old_group = new kindergarten_group *[children_count];
}

bool kindergarten::unreserve(int group_type, int index)
{
    std::cout << nursery_index << " "
              << young_index << " "
              << middle_index << " "
              << old_index << "\n\n";

    switch (group_type)
    {
        case 1:
            nursery_group[index]->reserved = false;
            break;
        case 2:
            young_group[index]->reserved = false;
            break;
        case 3:
            middle_group[index]->reserved = false;
            break;
        case 4:
            old_group[index]->reserved = false;
            break;
        default:
            break;
    }
    return false;
}
