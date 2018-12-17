//
// Created by kraftwerk28 on 03.10.18.
//

#include "matrix.h"

using std::pair;

matrix::matrix()
  : w(0), h(0), body(nullptr)
{
}

matrix::matrix(std::initializer_list<std::initializer_list<double>> arg)
  : h((uint) arg.size()), w((uint) arg.begin()->size())
{
  body = new double *[arg.size()];
  for (size_t r = 0, c = 0; r < h; r++)
  {
    body[r] = new double[w];
    for (; c < w; c++)
    {
      body[r][c] = *((arg.begin() + r)->begin() + c);
    }
    c = 0;
  }
}

matrix::matrix(uint _rows, uint _columns)
  : w(_columns), h(_rows)
{
  body = new double *[h];
  for (uint r = 0; r < h; r++)
  {
    body[r] = new double[w];
    for (uint i = 0; i < w; i++)
      body[r][i] = {0};
  }
}

matrix::matrix(const matrix &cp)
  : matrix(cp.h, cp.w)
{
  for (uint r = 0; r < cp.h; r++)
    for (uint c = 0; c < cp.w; c++)
      body[r][c] = cp[r][c];
}

matrix::~matrix()
{
  for (int r = 0; r < h; ++r)
    delete[] body[r];

  delete body;
}


void matrix::print() const
{
  using std::cout;
  using std::endl;
  using std::setw;
  using std::left;
  using std::setprecision;

  cout << endl;
  for (int r = 0, c = 0; r < h; r++)
  {

    cout << left << setw(4)
         << (r == 0 ? "┌" : (r == h - 1 ? "└" : "│"));
    for (; c < w; c++)
    {
      cout << left << setw(FIELD_WIDTH) << std::setprecision(2) << body[r][c];
    }
    c = 0;
    cout << (r == 0 ? "┐" : (r == h - 1 ? "┘" : "│")) << endl;
  }
  cout << endl;
}

matrix matrix::operator+(const matrix &m) const
{
  if (w != m.w || h != m.h)
    throw "Error in sum of matrices. Matrix dimencions should be equal. Aborting...\n";
  const auto result = matrix(*this);
  for (uint r = 0; r < m.h; r++)
    for (uint c = 0; c < m.w; c++)
      result[r][c] += m[r][c];
  return result;
}

matrix matrix::operator-(const matrix &m) const
{
  if (w != m.w || h != m.h)
    throw "Error in matrix substraction. Matrix dimencions should be equal. Aborting...\n";
  auto result = matrix{*this};
  for (uint r = 0; r < m.h; r++)
    for (uint c = 0; c < m.w; c++)
      result[r][c] -= m[r][c];
  return result;
}

matrix matrix::operator*(const matrix &m) const
{
  if (w != m.h)
    throw "Error in matrix multiplication. Aborting...\n";
  const auto result = matrix{h, m.w};
  for (uint r = 0; r < h; r++)
  {
    for (uint c = 0; c < w; c++)
    {
      for (int i = 0; i < w; i++)
      {
        result[r][c] += body[r][i] * m[i][c];
      }
    }
  }
  return result;
}

matrix matrix::operator*(double num) const
{
  const auto res = matrix(*this);
  for (uint r = 0; r < h; r++)
  {
    for (uint c = 0; c < w; c++)
    {
      res[r][c] *= num;
    }
  }
  return res;
}

matrix matrix::operator/(const matrix &m) const
{
  return *this * !m;
}

double *matrix::operator[](int i) const
{
  return body[i];
}

double *matrix::operator[](int i)
{
  return body[i];
}

matrix matrix::operator!() const
{
  if (w != h)
    throw "Inverse matrix can not be calculated. Aborting...";
  matrix result{h, w};
  for (uint r = 0; r < h; r++)
  {
    for (uint c = 0; c < w; c++)
    {
      result[r][c] =
        ~sub_mat(r, c) * ((r % 2 == 0) ^ (c % 2 == 0) ? -1 : 1);
    }
  }
  return result.transp() * (double) (1 / ~*this);
}

double matrix::operator~() const
{
#if DO_GAUSSIAN
  return gaussian_det();
#else
  if (w != h)
    throw "Determinant can not be calculated. Aborting...";
  if (w <= 1)
    return body[0][0];
  else if (w == 2)
    return body[0][0] * body[1][1] - body[0][1] * body[1][0];
  else
  {
    double result = 0;
    for (uint i = 0; i < w; i++)
    {
      result += (i % 2 == 0 ? 1 : -1) * body[0][i] * ~sub_mat(0, i);
    }
    return result;
  }
#endif

}

void matrix::push(const double val)
{
  body[push_pos_r][push_pos_c] = val;
  push_pos_c++;
  if (push_pos_c >= w)
  {
    push_pos_c = 0;
    push_pos_r++;
  }
}

matrix matrix::sub_mat(uint _r, uint _c) const
{
  const auto result = matrix(h - 1, w - 1);

  bool l_offset = false, t_offset = false;

  for (uint r = 0; r < h; r++)
  {
    for (uint c = 0; c < w; c++)
    {
      if (r == _r)
      {
        t_offset = true;
        r++;
      }
      if (c == _c)
      {
        l_offset = true;
        c++;
      }
      if (r >= h || c >= w) break;
      result[r - (t_offset ? 1 : 0)][c - (l_offset ? 1 : 0)] =
        body[r][c];
    }
    l_offset = false;
  }

  return result;
}

matrix matrix::transp() const
{
  matrix res{*this};
  for (uint r = 0; r < h; r++)
  {
    for (uint c = 0; c < w; c++)
    {
      res[c][r] = body[r][c];
    }
  }
  return res;
}

std::ostream &operator<<(std::ostream &s, const matrix &m)
{
  m.print();
  return s;
}

std::istream &operator>>(std::istream &s, matrix &m)
{
  double val;
  s >> val;
  m.push(val);
  return s;
}

matrix matrix::LU() const
{
  matrix l = matrix{h, w}, u = matrix{h, w};
  double sum = 0;

  uint d = h;

  if (body[0][0] == 0) return u;

  for (uint j = 0; j < d; ++j)
  {
    u[0][j] = body[0][j];
    l[j][0] = body[j][0] / u[0][0];
  }

  for (uint i = 1; i < d; ++i)
  {
    for (uint j = i; j < d; ++j)
    {
      sum = 0;
      for (uint k = 0; k < i; ++k)
      {
        sum += (l[i][k] * u[k][j]);
      }
      double ss = body[i][j] - sum;
      u[i][j] = body[i][j] - sum;
    }

  }
  for (uint i = 1; i < d; ++i)
  {
    for (uint j = i; j < d; ++j)
    {
      sum = 0;
      for (uint k = 0; k < i; ++k)
      {
        sum += l[j][k] * u[k][i];
      }
      l[j][i] = (body[j][i] - sum) / u[i][i];
    }
  }

  return u;
}

double matrix::gaussian_det() const
{
  const auto lu = LU();

  double res = 1;
  for (uint i = 0; i < h; i++)
  {
    res *= lu[i][i];
  }

  return res;
}

uint matrix::size() const
{
  return w * h;
}

uint matrix::columns() const
{
  return w;
}

uint matrix::rows() const
{
  return h;
}

matrix matrix::triangled() const
{
  matrix res{*this};
//  for (int i = 0; i < h; ++i)
//    for (int j = 0; j < w; ++j)
//      res[i][j] = body[i][j];
  // приводим матрицу к треугольному виду
  for (unsigned i = 1; i < h; ++i)
  {
    for (unsigned k = i; k < h; ++k)
    {
      for (int j = h - 1; j >= 0; --j)
      {
        res[k][j] -= res[k][i - 1] / res[i - 1][i - 1] * res[i - 1][j];
      }
    }
  }
  auto ptr = &res;
  return res;
}

matrix matrix::unit_matrix(uint dim)
{
  matrix res{dim, dim};
  while (dim--)
  {
    res[dim][dim] = 1;
  }
  return res;
}

matrix &matrix::operator=(const matrix &_m)
{
  new(this)matrix(_m);
  return *this;
}

matrix matrix::trian() const
{
  matrix res{*this};
  int n = rows();
  double **a = res.body;

  for (int i = 0; i < n - 1; i++)
  {
    for (int j = i + 1; j < n; j++)
    {
      double koef = a[j][i] / a[i][i];
      for (int k = i; k < n; k++)
        a[j][k] -= a[i][k] * koef;
    }
  }
  return res;
}

/*
double matrix::thread_det() const
{
    using std::thread;
    using std::vector;

    double result = 0;
    bool *thread_flags[w] = {new bool(false)};
    thread *threads[w] = {nullptr};

    for (uint i = 0; i < w; i++)
    {
        const auto l = [this, i, &thread_flags, &result]() -> void {
            result += ~sub_mat(0, i);
            *thread_flags[i] = true;
        };
        threads[i] = new thread(l);
    }

    while (true)
    {
        uint cnt = 0;
        for (uint i = 0; i < w; i++)
        {
            if (*thread_flags[i])
            {
                cnt++;
            } else
                break;
        }
        if (cnt >= w - 1)
            break;
    }

    for (uint i = 0; i < w; i++)
    {
        threads[i]->join();
        delete thread_flags[i];
        delete threads[i];
    }

    return result;
}
*/
