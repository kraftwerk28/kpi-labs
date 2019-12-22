#include "utils.h"

void print_byte(char c) {
  char* repr = (char*)malloc(sizeof(char) * 8);
  memset(repr, '0', 8);
  repr[8] = '\0';
  size_t i = 0;
  for (; i < 8; ++i) {
    repr[i] = !!((c << i) & 0x80) + 0x30;  // tak nado
  }
  printf("%s\n", repr);
  free(repr);
}

char* to_array(int number) {
  int n = log10(number) + 1;
  int i = 0;
  char* numberArray = calloc(n, sizeof(char));
  for (i = 0; i < n; ++i, number /= 10) {
    numberArray[n - 1 - i] = (number % 10) + '0';
  }
  numberArray[i] = '\0';
  return numberArray;
}

void center_print(const char* _text) {
  const char* COLS = getenv("COLUMNS");
  int term_w = COLS ? atoi(COLS) : 143;
  const int text_w = strlen(_text);
  char* res = (char*)calloc(term_w + 1, sizeof(char));
  memset(res, ' ', term_w);
  strncpy(res + (term_w / 2) - (text_w / 2), _text, text_w);
  // res[0] = '[';
  // res[term_w - 1] = ']';
  printf("%s\n\n", res);
  free(res);
}
