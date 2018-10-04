#include <iostream>
#include "matrix.h"

int main()
{
    using std::cout;
    using std::endl;
//    std::cout << "Hello, World!" << std::endl;
    auto
        mtrx1 = matrix(
        {
            {2, 5,  7},
            {6, 3,  4},
            {5, -2, -3}
        }),
        mtrx2 = matrix(
        {
            {-1, -2},
            {-3, -4},
            {-3, -4}
        }),
        m3 = matrix(
        {
            {2, 3},
            {1, 1}
        });

//    cout << !mtrx1 << endl;

    std::cout << (!mtrx1) << std::endl;

    matrix mmm = matrix(11, 11);
    cout << !mmm << endl;
//    (mtrx1 * mtrx2).print();

    return 0;
}