#include "dice_game.h"

dice_game::dice_game()
    : cubes_count(1),
      cubes(new cube[1]) {}

dice_game::dice_game(int cubes_count)
    : cubes_count(cubes_count),
      cubes(new cube[cubes_count]) {}

dice_game::~dice_game()
{
    delete[] cubes;
}

void dice_game::play(int turns_count, int make_stat)
{
    int score1 = 0, score2 = 0;
    stringstream ss;

    // each turn
    for (int i = 0; i < turns_count; i++)
    {
        ss << "----------------\n"
           << "turn #" << i + 1 << ":\n";
        ss << "pl #1:\tpl #2\n";

        // each cube
        for (int t = 0; t < cubes_count; t++)
        {
            int val1 = cubes[t].scramble(), val2 = cubes[t].scramble();
            score1 += val1;
            score2 += val2;
            ss << val1 << "\t" << val2 << "\n";
        }
        ss << "----------------\n";
        ss << score1 << "\t" << score2 << "\n\n";
    }


    ss << "Total:\n"
       << "pl #1:\tpl #2:\n"
       << score1 << "\t" << score2 << "\n\n";

    double percent = ((double) score1 / (score1 + score2) * 10000.0) / 100.0;
    ss << "Win percent: " << percent << "%\n";

    // console logging
    string res = ss.str();
    cout << res;

    // if need to output in file
    if (make_stat)
    {
        ofstream out_file("dice_stats.txt");
        out_file << res;
        out_file.close();
    }
}

dice_game::dice_game(const dice_game &to_copy)
    : cubes_count(to_copy.cubes_count),
      cubes(new cube[to_copy.cubes_count]) {}

int dice_game::cube::scramble()
{
    return rand() % 6 + 1;
}
