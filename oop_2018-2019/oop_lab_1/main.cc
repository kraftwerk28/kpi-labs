#include "dice_game.h"

int main(int argc, char const *argv[])
{
    // init random generator
    srand((unsigned int) time(nullptr));

    char user_answer;
    while (true)
    {
        dice_game game(4);
        game.play(3, true);

        // replay if needed
        cout << "\nRerun game? (y/n): ";
        cin >> user_answer;
        if (user_answer == 'n')
            break;
        else
            continue;

    }

    return 0;
}
