#include <iostream>
#include <fstream>

#include "matrix.h"

int main()
{
    auto
        matrix1 = matrix(
        {
            {1, 4, 2},
            {3, 3, 3}
        }),
        matrix2 = matrix(
        {
            {1, 1},
            {2, 2}
        });

    try
    {
        const auto det = ~matrix1;
    } catch (non_square_matrix &ex)
    {
        ex.print();
    }

    try
    {
        const auto multiplication = matrix1 * matrix2;
    }
    catch (wrong_dimensions &ex)
    {
        ex.print();
    }

    using std::ofstream;
    using std::exception;
    using std::cout;
    using std::endl;

    auto file = new ofstream("matrix_out.txt");
    try
    {
        *file << matrix1;
        throw bad_file(&matrix1);
    } catch (bad_file &ex)
    {
        ex.print();
        file->close();
        delete file;
    }


    return 0;
}