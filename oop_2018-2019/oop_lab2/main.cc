#include <iostream>
#include "matrix.h"
#include <ctime>
#include <fstream>
#include <thread>

#define BIG_DIM 5000

int main()
{
    using std::cout;
    using std::cin;
    using std::endl;

    cout << "--------------------\n";

    auto
        mtrx1 = matrix(
        {
            {2, 5,  7},
            {6, 3,  4},
            {5, -2, -3}
        }),

        mtrx2 = matrix(
        {
            {2,  6,  7},
            {-4, 8,  2},
            {4,  -2, -1}
        }),

        m3 = matrix(
        {
            {2, 3},
            {1, 1}
        });

    cout << ~mtrx2 << endl;
    cout << mtrx1 * mtrx2;
    cout << mtrx1 + mtrx2;
    cout << !mtrx2;

    auto mtrxcin = matrix(2, 2);
//    uint count = mtrxcin.size();
//    while (count--)
//    {
//        cout << "> ";
//        cin >> mtrxcin;
//    }


    std::ifstream f("./file.txt");
    uint count = mtrxcin.size();
    std::string ss;
    while (count--)
    {
        f >> mtrxcin;
    }

    cout << mtrxcin;
    /*
    cout << "--------------------\n";

    auto mmm = matrix(BIG_DIM, BIG_DIM);

    auto begin = clock();
    cout << ~mmm << endl;
    auto end = clock();

    cout << "Calculating " << BIG_DIM << "x" << BIG_DIM << " determinant:\n"
         << (double) (end - begin) / CLOCKS_PER_SEC * 1000 << "ms\n"
         << "Memory allocated: " << BIG_DIM * BIG_DIM *
                                    sizeof(double) << " bytes" << endl;
    */

    return 0;
}