#include <iostream>
#include "shape.h"

int main()
{
    using std::cout;
    using std::endl;

    shape *c = new triangle({2, 2, 3});
    shape *d = new rectangle({2, 3});
    shape *e = new ellipse(2, 3);

    cout << "triangle's area = " << c->area() << endl;
    cout << "rectangle's perimeter = " << d->perimeter() << endl;
    cout << "ellipce area = " << e->area() << endl;
    cout << "ellipce perimater = " << e->perimeter() << endl;

    delete c;
    delete d;
    delete e;

    return 0;
}
