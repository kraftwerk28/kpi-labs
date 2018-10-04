//
// Created by kraftwerk28 on 03.10.18.
//

#ifndef OOP_LAB_2_MATRIX_H
#define OOP_LAB_2_MATRIX_H
#define log(x) #x std::cout << x << std::endl

#include <iostream>
#include <vector>
#include <typeinfo>

#define list std::initializer_list

typedef unsigned int uint;

class matrix
{
public:
    matrix();

    matrix(uint _rows, uint _columns);

    matrix(list<list<double>> arg);

    matrix(const matrix &cp);

    ~matrix();

    matrix operator+(const matrix &m);

    matrix operator-(const matrix &m);

    matrix operator*(const matrix &m);

    matrix operator*(double num);

    matrix operator/(const matrix &m);

    double *operator[](int i) const;

    // anti-matrix
    matrix operator!() const;

    // determinant
    double operator~() const;

    friend std::ostream &operator<<(std::ostream &s, const matrix &m);

    matrix transp() const;

    void print() const;

    void push(double val);

private:
    double **body;

    uint push_pos_r = 0, push_pos_c = 0;

    uint w = 0, h = 0;

    matrix sub_mat(uint _r, uint _c) const;
};


#endif //OOP_LAB_2_MATRIX_H
