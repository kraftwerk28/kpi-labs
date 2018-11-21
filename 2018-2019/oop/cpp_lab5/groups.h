//
// Created by kraftwerk28 on 30.10.18.
//

#ifndef OOP_LAB4_GROUPS_H
#define OOP_LAB4_GROUPS_H

#include <type_traits>
#include <vector>
#include <typeinfo>
#include <iostream>


#define children_count 20

using std::vector;

typedef unsigned int u_int;

struct kindergarten_group
{
    int lowest_age;
    int highest_age;
    int age = 0;
    bool reserved = true;

    kindergarten_group(int _l, int _h)
        : lowest_age(_l), highest_age(_h) {};
};

// ясельная группа
struct nursery : kindergarten_group
{
    nursery() : kindergarten_group(1, 3) {}
};

struct young : kindergarten_group
{
    young() : kindergarten_group(3, 4) {}
};

struct middle : kindergarten_group
{
    middle() : kindergarten_group(5, 6) {}
};

struct old : kindergarten_group
{
    old() : kindergarten_group(6, 7) {}
};


class kindergarten
{
public:
    kindergarten();

    template<class group_type>
    void request_place(group_type *child)
    {
        using std::is_same;
        if (nursery_group.size() < children_count &&
            is_same<group_type, nursery>::value == 1)
        {
            nursery_group.push_back(child);
        } else if (nursery_group.size() < children_count &&
                   is_same<group_type, young>::value == 1)
        {
            young_group.push_back(child);
        } else if (nursery_group.size() < children_count &&
                   is_same<group_type, middle>::value == 1)
        {
            middle_group.push_back(child);
        } else if (nursery_group.size() < children_count &&
                   is_same<group_type, old>::value == 1)
        {
            old_group.push_back(child);
        }
        std::cout << "plase has been reserved\n\n";
    }

    // returns true on success
    bool unreserve(int group_type, int index);

private:
    vector<kindergarten_group *> nursery_group;
    vector<kindergarten_group *> young_group;
    vector<kindergarten_group *> middle_group;
    vector<kindergarten_group *> old_group;
};


#endif //OOP_LAB4_GROUPS_H
