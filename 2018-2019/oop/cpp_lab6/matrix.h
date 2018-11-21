//
// Created by kraftwerk28 on 03.10.18.
//

#ifndef OOP_LAB_6_MATRIX_H
#define OOP_LAB_6_MATRIX_H
#define log(x) #x std::cout << x << std::endl

#include <iostream>
#include <vector>
#include <typeinfo>
#include <thread>
#include <exception>

#define list std::initializer_list

typedef unsigned int uint;

class matrix_exception;

class matrix
{
public:
    matrix();

    matrix(uint _rows, uint _columns);

    matrix(list<list<double>> arg);

    matrix(const matrix &cp);

    ~matrix();


    matrix operator+(const matrix &m) const;

    matrix operator-(const matrix &m) const;

    matrix operator*(const matrix &m) const;

    matrix operator*(double num) const;

    matrix operator/(const matrix &m) const;

    double *operator[](int i) const;

    // anti-matrix
    matrix operator!() const;

    // determinant
    double operator~() const;

    friend std::ostream &operator<<(std::ostream &s, const matrix &m);

    friend std::istream &operator>>(std::istream &s, matrix &m);

    matrix transp() const;

    void print(std::ostream &s) const;

    void push(double val);

    uint size() const;

private:
    double **body;

    matrix LU() const;

    uint push_pos_r = 0, push_pos_c = 0;

    uint w = 0, h = 0;

    matrix sub_mat(uint _r, uint _c) const;

    double gaussian_det() const;
};

// -----EXCEPTION CLASSES-----
class matrix_exception : public std::exception
{
public:
    matrix_exception(const char *_message, const matrix *_source)
        : message(_message), source(_source) {}

    virtual void print() const noexcept(false);

private:
    const char *message;
    const matrix *source;
};

class non_square_matrix : public matrix_exception
{
public:
    explicit non_square_matrix(const matrix *source)
        : matrix_exception("matrix should be square", source) {}
};

class wrong_dimensions : public matrix_exception
{
public:
    explicit wrong_dimensions(const matrix *source)
        : matrix_exception(
        "matrix A width should be equal to matrix B height.",
        source
    ) {};
};

class bad_file : public matrix_exception
{
public:
    explicit bad_file(const matrix *source)
        : matrix_exception(
        "Error while opening file. Aborting.",
        source
    ) {}
};

#endif //OOP_LAB_2_MATRIX_H
