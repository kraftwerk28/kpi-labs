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
    for (uint i = 0; i <= n - k; ++i)
    {
      for (uint j = 0; j <= n - 1; ++j)
      {
        if (j != n - 1 - k)
        {
          r[i][j] = r[i][j] - r[i][n - k - 1] * r[n - k][j];
        }
      }
    }
    // Умножаем на обратную единичную матрицу с строкой которую запоминали вначале
    for (int j = 0; j < n; ++j)
    {
      double buf = 0;
      for (int m = 0; m < n; ++m)
      {
        buf = buf + prev_row[m] * r[m][j];
      }
      r[n - 1 - k][j] = buf;
    }
  }

  return r;
}

vector<double> lambdas(matrix &m)
{
  vector<double> res = vector<double>();
  auto frob = frobenius(m);
//  for (int i = 0; i < frob.columns(); ++i)
//  {
//    frob[i][i] -
//  }

  if (m.columns() == 2)
  {
    // Алгоритм для квадратного полинома
    double a = frob[0][0], b = frob[0][1];
    double D = a * a + 4 * b;
    if (D > 0)
    {
      res.push_back((a + sqrt(D)) / 2);
      res.push_back((a - sqrt(D)) / 2);
    } else if (D == 0)
    {
      res.push_back((a + sqrt(D)) / 2);
    }
  } else if (m.columns() == 3)
  {
    double
      a = frob[0][0],
      b = frob[0][1],
      c = frob[0][2];
    auto roots = new double[3];

    int cnt = SolveP3(roots, -a, -b, -c);

    if (cnt == 1)
    {
      res.push_back(roots[0]);
    } else if (cnt == 3)
    {
      res.push_back(roots[0]);
      res.push_back(roots[1]);
      res.push_back(roots[2]);
    }
    delete[] roots;

  } else if (m.columns() == 4)
  {
    double a = frob[0][0], b = frob[0][1], c = frob[0][2], d = frob[0][3];
    auto solves = new double[4];
    int cnt = SolveP4(solves, -a, -b, -c, -d);
    while (cnt > 0)
    {
      cnt--;
      res.push_back(solves[cnt]);
    }
    delete[] solves;
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
    cout << "Собственный вектор: ( " << (m[1][1]) << " * C; "
         << (m[0][0] - lambda)
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
    cout << "Собственный вектор: ( " << (b * e - d * c) / (a * d)
         << " * C; "
         << -(e / d)
         << " * C; " << (1) << " * C ), C - любое действительное число"
         << endl;

  } else if (m.rows() == 4)
  {
    matrix t = m.trian();
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
         << (-(b * f * i) + (b * g * h) + (e * c * i) - (d * e * h)) /
            (a * e * h) << " * C; "
         << ((f * i) - (g * h)) / (e * h)
         << " * C; "
         << -(i / h)
         << " * C; " << (1)
         << " * C ), C - любое действительное число"
         << endl;


  }
}

#endif //OOP_LAB_2_DANILEVSKYI_METHOD_H
