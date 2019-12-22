#include <iostream>
#include <unistd.h>
#include <string>

void new_func1(void);

void DrawCircle(void) {
  for (int i = 0; i < 1000000000; i++) {
    // process of drawing
    // sleep(100);
  }

  return;
}

static void DrawSquare(void) {
  for (int i = 0; i < 1000000000; i++) {
    // process of drawing
    // sleep(100);
  }
  return;
}

int main(void) {
  printf("\n Inside main()\n");
  std::string typeOfShape;
  std::cin >> typeOfShape;

  int i = 0;
  for (; i < 0xffffff; i++) {}

  if (typeOfShape == "square") {
    DrawSquare();
  } else if (typeOfShape == "circle") {
    DrawCircle();
  }
  return 0;
}
