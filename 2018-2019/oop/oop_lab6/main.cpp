#include <iostream>

#include "matrix.h"

int main()
{
    auto matrix1 = matrix(
        {
            {1, 4, 2},
            {3, 3, 3}
        });

    try
    {
        const auto det = ~matrix1;
    } catch (matrix_exception &ex)
    {
        ex.print();
    }

    return 0;
}