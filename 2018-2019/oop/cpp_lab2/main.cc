#include <iostream>

#include "matrix.h"
#include "danilevskyi_method.h"
#include "krylov_method.h"

int main()
{
  // подключаем нужніе классы для ввода-вывода
  using std::cout;
  using std::cin;
  using std::endl;

  cout << "--------------------\n";

  // Тестовые матрицы
  matrix A1{
    {
      {2, 1, 4},
      {3, 2, -1},
      {5, 3, 2}
    }
  };
  matrix A2{
    {
      {1, -2},
      {-6, 3}
    }
  };
  matrix A3{
    {
      {1, 2, 3, 4},
      {2, 2, 1, 2},
      {2, 1, 3, 1},
      {3, 3, 2, 1}
    }
  };
  matrix A4{
    {
      {-3, -6},
      {2, 4}
    }
  };


  cout << "Метод Данилевского:" << endl;
  // Ищем собственные числа
  const vector<double> _lambdas11 = lambdas(A2);

  // Ищем матрицу Фробениуса
  cout << endl << "Матрица Фробениуса:" << frobenius(A2);

  // Находим собственные векторы
  for (int i = 0; i < _lambdas11.size(); ++i)
  {
    cout << "Лямбда #" << (i + 1) << " = " << _lambdas11[i] << ":" << endl;
    print_own_vector(A2, _lambdas11[i]);
  }


  // То же, только для другой матрицы (3х3)
  const vector<double> _lambdas12 = lambdas(A1);
  cout << endl << "Матрица Фробениуса:" << frobenius(A1);
  for (int i = 0; i < _lambdas12.size(); ++i)
  {
    cout << "Лямбда #" << (i + 1) << " = " << _lambdas12[i] << ":" << endl;
    print_own_vector(A1, _lambdas12[i]);
  }

  cout << endl << "Метод Крылова:" << endl;

  solve_krylov(A3);


  return 0;
}