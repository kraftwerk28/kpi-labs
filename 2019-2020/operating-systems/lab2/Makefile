GCC_FLAGS := -fpic -I include/ -lm
SRCS := src/*.c
BIN := bin/allocator

all:
	@gcc -O3 -o $(BIN) $(GCC_FLAGS) $(SRCS)
	@echo -e "\e[1;32mCompiled successfully!\e[0m"

debug:
	@gcc -g -o $(BIN) $(GCC_FLAGS) $(SRCS)
	@echo -e "\e[1;32mCompiled successfully for debugging!\e[0m"
