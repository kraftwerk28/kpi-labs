//
// Created by kraftwerk28 on 15.10.18.
//

#include "shape.h"

// base
shape::shape() = default;

shape::shape(list _sides) : shape((uint) _sides.size())
{
    for (sz i = 0; i < side_count; i++)
    {
        sides[i] = *(_sides.begin() + i);
    }
}

shape::~shape()
{
    delete sides;
}


// square
square::square(list _list) : square()
{
    if (_list.size() != 1 || _list.size() != 2 || _list.size() != 4)
        throw "Wrong list. Aborting...";
    sides[0] = *(_list.begin());
}

float square::area()
{
    return sides[0] * sides[0];
}

float square::perimeter()
{
    return 4 * sides[0];
}

// rectangle
rectangle::rectangle(list _list) : shape(_list)
{
    if (_list.size() != 2)
        throw std::invalid_argument("Wrong list. Aborting...");
    sides[0] = *(_list.begin());
    sides[1] = *(_list.begin() + 1);
}

float rectangle::area()
{
    return sides[0] * sides[1];
}

float rectangle::perimeter()
{
    return 2 * sides[0] + 2 * sides[1];
}


// triangle
triangle::triangle(list _list) : shape(_list)
{
    if (_list.size() != 3)
        throw "Wrong list. Aborting...";
    sides[0] = *(_list.begin());
    sides[1] = *(_list.begin() + 1);
    sides[2] = *(_list.begin() + 2);
}

float triangle::area()
{
    float p = (sides[0] + sides[1] + sides[2]) / 2;
    return sqrtf(p * (p - sides[0]) * (p - sides[1]) * (p - sides[2]));
}

float triangle::perimeter()
{
    return sides[0] + sides[1] + sides[2];
}


float ellipse::perimeter()
{
    return 4 * (M_PI * a * b + powf(a - b, 2.0)) / (a + b);
}

float ellipse::area()
{
    return M_PI * a * b;
}
