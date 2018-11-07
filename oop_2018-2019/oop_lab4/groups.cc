//
// Created by kraftwerk28 on 30.10.18.
//

#include "groups.h"


kindergarten::kindergarten()
{
    nursery_group = vector<kindergarten_group *>();
    young_group = vector<kindergarten_group *>();
    middle_group = vector<kindergarten_group *>();
    old_group = vector<kindergarten_group *>();
}

bool kindergarten::unreserve(int group_type, int index)
{
    std::cout << nursery_group.capacity() << " "
              << young_group.size() << " "
              << middle_group.size() << " "
              << old_group.size() << "\n\n";

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
