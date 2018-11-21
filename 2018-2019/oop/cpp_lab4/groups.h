//
// Created by kraftwerk28 on 21.11.18.
//

#ifndef OOP_LAB4_GROUPS_H
#define OOP_LAB4_GROUPS_H

#include <type_traits>
#include <typeinfo>
#include <iostream>


#define children_count 20


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
        if (nursery_index < children_count &&
            is_same<group_type, nursery>::value == 1)
        {
            nursery_group[nursery_index++] = child;
        } else if (nursery_index < children_count &&
                   is_same<group_type, young>::value == 1)
        {
            young_group[young_index++] = child;
        } else if (nursery_index < children_count &&
                   is_same<group_type, middle>::value == 1)
        {
            middle_group[middle_index++] = child;
        } else if (nursery_index < children_count &&
                   is_same<group_type, old>::value == 1)
        {
            old_group[old_index++] = child;
        }
        std::cout << "plase has been reserved\n\n";
    }

    // returns true on success
    bool unreserve(int group_type, int index);

private:
    kindergarten_group **nursery_group;
    kindergarten_group **young_group;
    kindergarten_group **middle_group;
    kindergarten_group **old_group;

    int nursery_index = 0;
    int young_index = 0;
    int middle_index = 0;
    int old_index = 0;
};


#endif //OOP_LAB4_GROUPS_H
