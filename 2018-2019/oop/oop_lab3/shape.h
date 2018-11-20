//
// Created by kraftwerk28 on 15.10.18.
//

#ifndef OOP_LAB3_SHAPE_H
#define OOP_LAB3_SHAPE_H


#include <initializer_list>
#include <cmath>
#include <stdexcept>

typedef std::initializer_list<float> list;
typedef unsigned int uint;
typedef std::size_t sz;

class shape
{
protected:
    float *sides;
    uint side_count;
public:
    shape();

    explicit shape(uint _side_count)
        : side_count(_side_count), sides(new float[_side_count]) {}

    shape(list sides);

    virtual ~shape();

    virtual float area() = 0;

    virtual float perimeter() = 0;
};


class square : public shape
{
public:
    square() : shape(1) {}

    square(list _list);

    float area() final;

    float perimeter() final;
};

class rectangle : public shape
{
public:
    rectangle() : shape(2) {}

    rectangle(list _list);

    float area() final;

    float perimeter() final;
};

class triangle : public shape
{
public:
    triangle() : shape(3) {}

    triangle(list _list);

    float area() final;

    float perimeter() final;
};

class ellipse : public shape
{
private:
    float a, b;
public:
    ellipse()
        : shape(0), a(0), b(0) {}

    ellipse(float _a, float _b)
        : a(_a), b(_b) {}

    float area() final;

    float perimeter() final;
};

#endif //OOP_LAB3_SHAPE_H
