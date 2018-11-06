//
// Created by kraftwerk28 on 30.10.18.
//

#ifndef OOP_LAB4_GROUPS_H
#define OOP_LAB4_GROUPS_H

#include <type_traits>
#include <vector>

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
    void request_place(group_type child)
    {
        using std::is_same;
        if (is_same<group_type, nursery>::value)
        {
            nursery_group.push_back(child);
            nursery_group.end()->reserved = true;
        } else if (is_same<group_type, young>::value)
        {
            young_group.push_back(child);
            young_group.end()->reserved = true;
        } else if (is_same<group_type, middle>::value)
        {
            middle_group.push_back(child);
            middle_group.end()->reserved = true;
        } else if (is_same<group_type, old>::value)
        {
            old_group.push_back(child);
            old_group.end()->reserved = true;
        }
    }

private:
    vector<nursery> nursery_group;
    vector<young> young_group;
    vector<middle> middle_group;
    vector<old> old_group;
};


#endif //OOP_LAB4_GROUPS_H
