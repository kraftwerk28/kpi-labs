//
// Created by kraftwerk28 on 14.12.18.
//

#ifndef OOP_LAB_2_DANILEVSKYI_METHOD_H
#define OOP_LAB_2_DANILEVSKYI_METHOD_H

#include "matrix.h"
#include "poly34.h"
#include <vector>
#include <cmath>

using std::cout;
using std::vector;

matrix frobenius(const matrix &m)
{
  auto *prev_row = new double[m.columns()];
  matrix r{m};
  const uint n = m.rows();


  // Алгоритм вычисления Фробениусовой матрицы
  for (uint k = 1; k < n; ++k)
  {
    // Копируем строчку k-1
    for (uint i = 0; i < n; ++i)
    {
      prev_row[i] = r[n - k][i];
    }
    // "Сажаем "единицу в начало ряда
    for (uint i = 0; i <= n - k; ++i)
    {
      r[i][n - k - 1] = r[i][n - k - 1] / r[n - k][n - k - 1];
    }
    // Обнуляем лишнее чтоб получилась правильная форма Фробениуса
    for (uint j = 0; j < n - 1; ++j)
    {
      for (uint i = 0; i <= n - k; ++i)
      {
        if (j != n - 1 - k)
        {
          r[i][j] = r[i][j] - r[i][n - k - 1] * r[n - k][j];
        }
      }
    }
    // Умножаем на обратную единичную матрицу с строкой которую запоминали вначале
    auto unit = matrix::unit_matrix(m.columns());
    for (int i = 0; i < m.columns(); ++i)
    {
      unit[n - k - 1][i] = r[n - k][i];
    }

    matrix inv_unit{!unit};

    r = r * (!unit);
  }

  return r;
}

vector<double> lambdas(matrix &m)
{
  vector<double> res = vector<double>();

  if (m.columns() == 2)
  {
    // Алгоритм для квадратного полинома
    auto frob = frobenius(m);
    double D = frob[0][0] * frob[0][0] - 4 * frob[0][1];
    if (D > 0)
    {
      res.push_back((-frob[0][0] + sqrt(D)) * 2);
      res.push_back((-frob[0][0] - sqrt(D)) * 2);
    }

  } else if (m.columns() == 3)
  {
    // Алгоритм для кубического полинома
    auto frob = frobenius(m);
    double b = frob[0][0];
    double c = frob[0][1];
    double d = frob[0][2];

    double x1, x2, x3;

    double is2Imag = false;
    double is3Imag = false;

    double disc, q, r, dum1, s, t, term1, r13;
    q = (3.0 * c - (b * b)) / 9.0;
    r = -(27.0 * d) + b * (9.0 * c - 2.0 * (b * b));
    r /= 54.0;
    disc = q * q * q + r * r;

    term1 = (b / 3.0);
    if (disc > 0)
    {
      s = r + sqrt(disc);
      s = ((s < 0) ? -pow(-s, (1.0 / 3.0)) : pow(s, (1.0 / 3.0)));
      t = r - sqrt(disc);
      t = ((t < 0) ? -pow(-t, (1.0 / 3.0)) : pow(t, (1.0 / 3.0)));
      x1 = -term1 + s + t;
      term1 += (s + t) / 2.0;
      x3 = x2 = -term1;
      term1 = sqrt(3.0) * (-t + s) / 2;
      is2Imag = term1;
      is3Imag = -term1;

      res.push_back(x1);
      if (is2Imag) res.push_back(x2);
      if (is3Imag) res.push_back(x3);

      return res;
    }
    // End if (disc > 0)
    // The remaining options are all real
    is2Imag = is3Imag = 0;
    if (disc == 0)
    { // All roots real, at least two are equal.
      r13 = ((r < 0) ? -pow(-r, (1.0 / 3.0)) : pow(r, (1.0 / 3.0)));
      x1 = -term1 + 2.0 * r13;
      x3 = x2 = -(r13 + term1);

      res.push_back(x1);
      if (is2Imag) res.push_back(x2);
      if (is3Imag) res.push_back(x3);
      return res;
    } // End if (disc == 0)
    // Only option left is that all roots are real and unequal (to get here, q < 0)
    q = -q;
    dum1 = q * q * q;
    dum1 = acos(r / sqrt(dum1));
    r13 = 2.0 * sqrt(q);
    x1 = -term1 + r13 * cos(dum1 / 3.0);
    x2 = -term1 + r13 * cos((dum1 + 2.0 * M_PI) / 3.0);
    x3 = -term1 + r13 * cos((dum1 + 4.0 * M_PI) / 3.0);

    res.push_back(x1);
    if (is2Imag) res.push_back(x2);
    if (is3Imag) res.push_back(x3);
    return res;
  } else if (m.columns() == 4)
  {
    auto frob = frobenius(m);
    double a = frob[0][0], b = frob[0][1], c = frob[0][2], d = frob[0][3];
    auto solves = new double[4];
    int cnt = SolveP4(solves, -a, -b, -c, -d);
    while (cnt)
    {
      cnt--;
      res.push_back(solves[cnt]);
    }
  }

  res.shrink_to_fit();
  return res;
}

void print_own_vector(matrix &m, double lambda)
{
  using std::cout;
  using std::endl;

  // Находим собственные вектора
  const auto fail = []() {
    cout << "Невозможно найти собственные вектора..." << endl;
  };

  if (m.rows() == 2)
  {
    // Это решение системы из 2х уравнений
    cout << "Собственный вектор: ( " << (m[1][1] - lambda) - m[0][1] << " * C; "
         << (m[0][0] - lambda) * m[1][0]
         << " * C ), C - любое действительное число" << endl;
  } else if (m.rows() == 3)
  {
    // Это решение системы из 3х
    matrix t = m.trian();
    for (int i = 0; i < m.rows(); ++i)
    {
      t[i][i] -= lambda;
    }
    double a = t[0][0], b = t[0][1], c = t[0][2], d = t[1][1],
      e = t[1][2];
    cout << "Собственный вектор: ( " << (b * e - c * d) << " * C; "
         << (-a * e)
         << " * C; " << (a * d) << " * C ), C - любое действительное число"
         << endl;

  } else if (m.rows() == 4)
  {
    matrix t{m.trian()};
    for (int k = 0; k < m.rows(); ++k)
    {
      t[k][k] -= lambda;
    }
    double
      a = t[0][0],
      b = t[0][1],
      c = t[0][2],
      d = t[0][3],
      e = t[1][1],
      f = t[1][2],
      g = t[1][3],
      h = t[2][2],
      i = t[2][3];

    cout << "Собственный вектор: ( "
         << (-b * f * i + b * g * h + e * i - d * e * h) << " * C; "
         << ((f * i - g * h) * a)
         << " * C; "
         << (-i * e * a)
         << " * C; " << (e * h * a)
         << " * C ), C - любое действительное число"
         << endl;


  }
}

#endif //OOP_LAB_2_DANILEVSKYI_METHOD_H
