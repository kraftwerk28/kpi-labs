//
// Created by kraftwerk28 on 13.12.18.
//

#ifndef OOP_LAB_2_KRYLOV_METHOD_H
#define OOP_LAB_2_KRYLOV_METHOD_H

#include <cmath>
#include <stdlib.h>
#include <stdio.h>

#include "matrix.h"
#include "danilevskyi_method.h"

//Объявим прототипы процедур и функций
void dispArr(double **Arr, int i, int j, char t[7]);

double **arrMult(double **Arr, double **ArrO, int m, int n, int q);

double **treugArr(double **Arr, int n);

double *gSolve(double **Arr, int n);

double halfDiv(double *P, double eps);

double *urDiv(double *P, double a, int n);

double urTest4(double a, double b, double *P);

//Функция перемножения матриц
double **arrMult(double **Arr, double **ArrO, int m, int n, int q)
{
  double **MultArr;
  //Динамически создаем матрицу - результат произведения
  MultArr = new double *[m];
  for (int i = 0; i < m; i++)
  {
    MultArr[i] = new double[q];
  };
  //Вычисляем произведение матриц
  for (int i = 0; i < m; i++)
    for (int j = 0; j < q; j++)
    {
      MultArr[i][j] = 0;
      for (int k = 0; k < n; k++)
        MultArr[i][j] += Arr[i][k] * ArrO[k][j];
    }
  return MultArr;
}

double **treugArr(double **Arr, int n) //Приведение матрицы к треугольному виду
{
  //Приводим матрицу A к треугольному виду
  for (int i = 0; i < n; i++)
  {
    //Обнуляем необходимые элементы
    for (int j = i + 1; j < n; j++)
    {
      double koeff =
        Arr[j][i] / Arr[i][i]; //Коэффициент, на который будем домножать строку
      for (int k = 0; k < n + 1; k++)
        Arr[j][k] = Arr[j][k] - Arr[i][k] * koeff;
    }
  }
  return Arr;
}

//Нахождение переменных в матрице, приведенной к треугольному виду
double *gSolve(double **Arr, int n)
{
  double *X;
  X = new double[n];
  //Расчет неизвестных:
  X[3] = Arr[3][4] / Arr[3][3];
  X[2] = (Arr[2][4] - Arr[2][3] * X[3]) / Arr[2][2];
  X[1] = (Arr[1][4] - Arr[1][2] * X[2] - Arr[1][3] * X[3]) / Arr[1][1];
  X[0] = (Arr[0][4] - Arr[0][1] * X[1] - Arr[0][2] * X[2] - Arr[0][3] * X[3]) /
         Arr[0][0];

  return X;
}

double halfDiv(double *P, double eps) //Метод половинного деления
{
  double a = 0, b = 0, prec;

  do
  {
    a--;
    b++;
  } while (urTest4(a, b, P) > 0);
  std::cout << "Исходный отрезок для нахождения корней: ";
  std::cout << "[" << a << "," << b << "]\n";
  do
  {
    prec = b - a;
    double cent = (a + b) / 2;
    if (urTest4(a, cent, P) < 0) b = cent;
    else a = cent;
  } while (prec > eps);

  return a;
}

double *urDiv(double *P, double a, int n) //Деление уравнения
{
  P[n] = 0;
  for (int i = n - 1; i >= 0; i--)
  {
    if (i + 1 == n)
      P[i] = -P[i] + a;
    else
      P[i] = -P[i] + P[i + 1] * a;
  }
  for (int i = 0; i < n; i++)
    if (i + 1 == n)
      P[i] = -1;
    else
      P[i] = -P[i + 1];

  return P;
}

double
urTest4(double a, double b, double *P) //Проверка знаков на концах отрезка
{
  double r1 =
    P[4] * pow(a, 4) - P[3] * pow(a, 3) - P[2] * pow(a, 2) - P[1] * a - P[0];
  double r2 =
    P[4] * pow(b, 4) - P[3] * pow(b, 3) - P[2] * pow(b, 2) - P[1] * b - P[0];

  return r1 * r2;
}

void
dispArr(double **Arr, int si, int sj, char t[7]) //Процедура отображения матрицы
{
  std::cout << "------------------------------ \n";
  for (int i = 0; i < si; i++)
  {
    for (int j = 0; j < sj; j++)
      printf(t, Arr[i][j]);
    std::cout << "\n";
  }
  std::cout << "------------------------------ \n";

}

void solve_krylov(matrix &m)
{
  double eps = 0.01, a;
  double **A, **mC, **c0, *P, *lambda, **tmpArr;
  int ni, nj;
  ni = m.rows();
  nj = m.columns();

  //Создаем динамические массивы
  A = new double *[ni];

  for (int i = 0; i < ni; i++)
  {
    A[i] = new double[nj];
  };
  for (uint i = 0; i < ni; ++i)
    for (uint j = 0; j < nj; ++j)
      A[i][j] = m[i][j];

  //Блок нахождения значений C(0), C(1), C(2), C(3), C(4)
  //Создадим массив который будет хранить эти значения
  mC = new double *[ni];
  for (int i = 0; i < ni; i++)
    mC[i] = new double[ni + 1];
  //В этом массиве за C(0) примем (1, 1, 1, 1)
  for (int i = 0; i < ni; i++)
    mC[i][0] = 1;
  //Создадим массив c0, который будет хранить текущее значение C(1), C(2), C(3), C(4)
  c0 = new double *[ni];
  for (int i = 0; i < ni; i++)
    c0[i] = new double[1];

  //Перейдем к нахождению C(1), C(2), C(3), C(4)
  for (int i = 0; i < ni; i++)
  {
    //Заполним массив c0 текущим значением - C(i)
    for (int j = 0; j < ni; j++)
      c0[j][0] = mC[j][i];
    //Для нахождения C(i+1) умножим массив A на с0
    tmpArr = arrMult(A, c0, ni, nj, 1);
    //Занесем полученные данные в массив mC
    for (int j = 0; j < ni; j++)
      mC[j][i + 1] = tmpArr[j][0];
  }
  std::cout << "   C(0)    C(1)    C(2)    C(3)   C(4) \n";
  dispArr(mC, 4, 5, "%7.3f ");

  //Запишем систему уравнений для нахождения P1, P2, P3, P4
  treugArr(mC, 4);
  P = new double[ni + 1];
  P = gSolve(mC, 5);
  P[4] = 1;
  //Запишем получившееся уравнение с О»

  std::cout << "Характеристическое уравнение: \n";
  std::cout << P[4] << " О»^4 - (" << P[3] << ") О»^3 - (" << P[2]
            << ") О»^2 - (" << P[1] << ") О» - (" << P[0] << ") = 0 \n";
  lambda = new double[ni];

  //Ищем значения О» методом половинного деления
  for (int k = 4; k > 0; k--)
  {
    //Будем решать полученное уравнение методом половинного деления
    a = halfDiv(P, eps);
    lambda[k - 1] = a;
    std::cout << "О»[" << ni + 1 - k << "]: ";
    printf("%7.3f \n", a);
    //Разделим уравнение на полученный корень, чтобы получить кубическое
    P = urDiv(P, a, k);
    //Запишем результат деления
    if (k - 1 > 0)
    {
      std::cout << "Уравнение " << k - 1 << " степени: \n";
      std::cout << P[4] << " О»^4 - (" << P[3] << ") О»^3 - (" << P[2]
                << ") О»^2 - (" << P[1] << ") О» - (" << P[0] << ") = 0 \n";
    }
  }
//Аккуратно выведем полученные значения О»
  std::cout << "------------------------------ \n";
  std::cout << "Полученные собственные значения: \n";
  for (int i = ni; i > 0; i--)
  {
    std::cout << "О»[" << ni - i + 1 << "]: " << lambda[i - 1] << ";\n";
  }
  std::cout << "------------------------------ \n";
  for (int i = 0; i < ni; ++i)
  {
    cout << "Лямбда: " << lambda[i] << ";\n";
    print_own_vector(m, lambda[i]);
  }

}

#endif //OOP_LAB_2_KRYLOV_METHOD_H
