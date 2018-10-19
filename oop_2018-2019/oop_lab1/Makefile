all: bin/dice_game.o bin/main.o
	g++ -o bin/dice bin/main.o bin/dice_game.o

bin/main.o: main.cc
	g++ -c -o bin/main.o main.cc

bin/dice_game.o: dice_game.cc
	g++ -c -o bin/dice_game.o dice_game.cc

clean:
	rm -r bin/*
	