//
// Created by kraftwerk28 on 03.10.18.
//

#ifndef OOP_LAB_2_MATRIX_H
#define OOP_LAB_2_MATRIX_H
#define DO_GAUSSIAN false
#define FIELD_WIDTH 7

#include <iostream>
#include <iomanip>
#include <vector>
#include <typeinfo>
#include <thread>

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


  matrix operator+(const matrix &m) const;

  matrix operator-(const matrix &m) const;

  matrix operator*(const matrix &m) const;

  matrix operator*(double num) const;

  matrix operator/(const matrix &m) const;

  double *operator[](int i) const;

  double *operator[](int i);

  matrix operator=(const matrix &m);

  // anti-matrix
  // обратная матрица
  matrix operator!() const;

  // determinant
  // определитель
  double operator~() const;

  // вывод матрицы в консоль
  friend std::ostream &operator<<(std::ostream &s, const matrix &m);

  friend std::istream &operator>>(std::istream &s, matrix &m);

  // транспонированная матрица
  matrix transp() const;

  // LU-разложение
  matrix LU() const;

  void print() const;

  // одиночное добавление числа в матрицу
  void push(double val);

  void pushall(list<double> args)
  {
    for (const auto &v : args)
    {
      push(v);
    }
  }

  uint size() const;

  uint columns() const;

  uint rows() const;

  matrix triangled() const;

  static matrix unit_matrix(uint dim);

private:
  double **body;

  uint push_pos_r = 0, push_pos_c = 0;

  uint w = 0, h = 0;

  matrix sub_mat(uint _r, uint _c) const;

  double gaussian_det() const;
};


#endif //OOP_LAB_2_MATRIX_H
