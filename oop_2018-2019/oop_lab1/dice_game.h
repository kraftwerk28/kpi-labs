#ifndef _DICE_GAME_INCLUDED_
#define _DICE_GAME_INCLUDED_

#include <iostream>
#include <fstream>
#include <sstream>

using namespace std;

class dice_game
{

private:

    class cube
    {
    public:
        int scramble();
    };

    int cubes_count;

    cube *cubes;

public:

    dice_game();

    explicit dice_game(int cubes_count);

    dice_game(const dice_game &to_copy);

    ~dice_game();

    void play(int turns_count, int make_stat);
};

#endif