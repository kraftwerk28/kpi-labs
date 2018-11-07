#include <iostream>
#include <string>
#include <fstream>
#include <sstream>

using namespace std;

template <typename t>
void log(t val)
{
    cout << val << endl;
}

void encrypt(string path)
{
    ifstream file(path);
    ofstream out(
            path.substr(0,
                        path.find_last_of(".") ? path.find_last_of(".") : path.length() - 1) +
            ".kip");

    // take file length
    file.seekg(0, ios::end);
    unsigned int l = file.tellg();
    file.seekg(0, ios::beg);

    // stuff vars
    char a;
    char temp;
    int caret = file.tellg();
    int cnt1 = 0;
    int cnt2 = 0;

    cout << "flength: " << l << "\n";

    file.get(temp);
    file.get(a);

    while (file.tellg() < l)
    {
        cout << file.tellg() << " -> " << a << '\n';
        if (temp != a)
        {
            while (temp != a && file.tellg() < l)
            {
                cnt2++;
                temp = a;
                file.get(a);
            }
            if (cnt2 > 0)
            {
                file.seekg(-cnt2 - 1, ios::cur);
                out << -cnt2 << '^';
                // cnt2--;
                while (cnt2 > 0)
                {
                    cnt2--;
                    file.get(a);
                    out << a;
                }
                out << '|';
                file.seekg(1, ios::cur);
            }
            cnt2 = 0;
        }
        else
        {
            while (temp == a && file.tellg() < l)
            {
                file.get(a);
                cnt1++;
            }
            out << cnt1 + 1 << ':' << temp << '|';
            cnt1 = 0;
        }
        /*
        if (temp == a)
        {
            if (cnt2 > 0)
            {
                out << -cnt2 << '^'; // may change!
                file.seekg(-cnt2, ios::cur);
                cnt2--;
                while (cnt2 > 0)
                {
                    file.get(a);
                    out << a;
                    cnt2--;
                }
                out << '|';
            }
            else
            {
                cnt1++;
            }
        }
        else
        {
            if (cnt1 > 0)
            {
                out << cnt1 + 1 << ':' << temp << '|';
                cnt1 = 0;
            }
            else
            {
                cnt2++;
                temp = a;
            }
        }
        */
    }

    // log(cnt1);
    // log(cnt2);
    // out << "Dank memes\n";
    file.close();
    out.close();
}

void decrypt(string file)
{
    ifstream input(file, ios::binary);
    string ext;
    char a;
    while (1)
    {
        input.get(a);
        if (a != '|')
        {
            ext += a;
            continue;
        }
        break;
    }
    ofstream output("[decr]" + file.substr(0, file.find_last_of('.')) + ext);

    char delim;
    int num = 0;
    int towrite = 0;
    while (input.get(a))
    {
        if (a == '|')
        {
            cout << "writing next seq...\n";
            for (; num > 0; num--)
            {
                output << (char)towrite;
            }
            num = 0;
        }
        else if (a == ':')
        {
            while (1)
            {
                input.get(a);
                if (a != '|')
                {
                    towrite = towrite * 10 + (a - '0');
                    cout << "...\n";
                }
                else
                    break;
            }
            cout << "writing next seq...: " << static_cast<char>(towrite) << "\n";
            for (; num > 0; num--)
            {
                output << static_cast<char>(towrite);
            }
            towrite = 0;
            num = 0;
        }
        else
        {
            num = num * 10 + (a - '0');
            cout << num << "\n";
        }
        // output << a;
    }
}

int main()
{
    cout << INT16_MAX;
    encrypt("t.txt");
    /*
    ifstream file("t.txt");
    ofstream out("t.kip");
    file.seekg(0, ios::end);
    unsigned int l = file.tellg();
    file.seekg(0, ios::beg);

    char a;
    char temp;
    int caret = 0;

    file.get(temp);
    unsigned int cnt1 = 1;
    unsigned int cnt2 = 0;
    size_t i = 1;
    // while (file.tellg() < l)
    for (; i < l; i++)
    {
        file.get(a);
        if (a == temp)
        {
            if (cnt2 > 1)
            {
                out << -(int)cnt2 << '^';
                file.seekg(-cnt2 - 2, ios::cur);
                // out << temp;
                while (cnt2 > 1)
                {
                    file.get(a);
                    out << a;
                    cnt2--;
                }
                cnt1 = 0;
                out << '|';
            }
            else
                cnt1++;
        }
        else
        {
            if (cnt1 < 2)
            {
                cnt2++;
                temp = a;
                // i--;
            }
            else
            {
                out << cnt1 << ':' << temp << '|';
                cnt1 = 1;
                temp = a;
            }
        }
    }
    // log(cnt1);
    log(cnt2);
    // cnt2++;
    if (cnt1 > 1)
    {
        out << cnt1 << ':' << a << '|';
    }
    if (cnt2 > 0)
    {
        out << -(int)cnt2 << '^';
        file.seekg(-cnt2, ios::cur);
        while (cnt2 > 1)
        {
            file.get(a);
            out << a;
            cnt2--;
        }
        out << '|';
    }
    */
    return 0;
}
