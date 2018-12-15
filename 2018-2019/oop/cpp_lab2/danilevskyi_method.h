//
// Created by kraftwerk28 on 14.12.18.
//

#ifndef OOP_LAB_2_DANILEVSKYI_METHOD_H
#define OOP_LAB_2_DANILEVSKYI_METHOD_H

#include "matrix.h"
#include "vector"
#include <cmath>

using std::cout;
using std::vector;

matrix frobenius(const matrix &m)
{
  auto *prev_row = new double[m.columns()];
  matrix r{m};
  const uint n = m.rows();

  for (uint k = 1; k < n; ++k)
  {
    for (uint i = 0; i < n; ++i)
    {
      prev_row[i] = r[n - k][i];
    }
    for (uint i = 0; i <= n - k; ++i)
    {
      r[i][n - k - 1] = r[i][n - k - 1] / r[n - k][n - k - 1];
    }
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
    auto frob = frobenius(m);
    double D = frob[0][0] * frob[0][0] - 4 * frob[0][1];
    if (D > 0)
    {
      res.push_back((-frob[0][0] + sqrt(D)) * 2);
      res.push_back((-frob[0][0] - sqrt(D)) * 2);
    }

  }

  res.shrink_to_fit();
  return res;
}

void print_own_vector(matrix &m, double lambda)
{
  using std::cout;
  using std::endl;

  const auto fail = []() {
    cout << "Own vectors cannot be found..." << endl;
  };

  if (m.rows() == 2)
  {
    cout << "Own vector is: ( " << (m[1][1] - lambda) - m[0][1] << " * C; "
         << (m[0][0] - lambda) * m[1][0] << " * C ), C is real number" << endl;
  } else
  {
    fail();
  }
}

#endif //OOP_LAB_2_DANILEVSKYI_METHOD_H
