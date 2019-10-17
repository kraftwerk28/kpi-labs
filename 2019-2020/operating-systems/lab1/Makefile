GCC_FLAGS := -Wno-unused-function -I include
SRCS := src/*.c
BIN := bin/allocator

all:
	@gcc -o $(BIN) $(GCC_FLAGS) $(SRCS)
	@echo -e "\e[1;32mCompiled successfully!\e[0m"

debug:
	@gcc -g -o $(BIN) $(GCC_FLAGS) $(SRCS)
	@echo -e "\e[1;32mCompiled successfully for debugging!\e[0m"
