#include <iostream>

int main() {
  int* a = new int[2];
  int res = 0;

  for (int j = 0; j < 10000000; j++) {
    a[0] += 2;
  }
  a[1] = a[0];
  std::cout << a[0] << std::endl;

  delete[] a;

  return EXIT_SUCCESS;
}
