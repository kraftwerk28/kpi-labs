// Decomposition_Inversion.cpp : Defines the entry point for the console application.
//

#include <fstream>
#include <iostream>
#include <string>

using namespace std;

int main()
{
	string path;
	cout << "Enter path to file:" << endl;
	cin >> path;
	

	ofstream sourcefile;
	sourcefile.open(path);
	string sstring;

	int A[5] = { 1, 2, 3, 4, 5 };
	int *ptr;
	ptr = A;
	cout << *(A+2);
	cin.get();
	return 0;
}
