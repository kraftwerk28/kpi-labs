using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace SquareCrypto
{
	public static class Alphabet
	{
		public static string alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 ?!@#$%^&*()_+=-/".ToLower();
		public static int length = alphabet.Length;
	}

	public class Program
	{

		static void Main(string[] args)
		{
			while (true)
			{
				char a = '0';
				while (a != '1' && a != '2')
				{
					Console.WriteLine("You want to encrypt(1), or decrypt(2)?");
					a = Console.ReadKey().KeyChar;
				}

				string message, key;

				switch (a)
				{
					case '1':
						Console.WriteLine("\nEnter message here:");
						message = Console.ReadLine().ToString();
						Console.WriteLine("\nEnter key:");
						key = Console.ReadLine().ToString();
						Console.WriteLine(Encryptor.Encrypt(message, key));
						break;
					case '2':
						Console.WriteLine("\nEnter encryption here:");
						message = Console.ReadLine().ToString();
						Console.WriteLine("\nEnter key:");
						key = Console.ReadLine().ToString();
						Console.WriteLine(Decryptor.Decrypt(message, key) + "\n");
						break;
				}

				Console.ReadKey();
			}
		}
	}

	public class Square
	{
		public char[,] Array;
		public Square(int dimension)
		{
			Array = new char[dimension, dimension];
			for (int y = 0; y < dimension; y++)

			{
				for (int x = 0; x < dimension; x++)
				{
					Array[x, y] = GetChar(x + y);
				}
			}
		}
		char GetChar(int value)
		{
			return Alphabet.alphabet[value < Alphabet.length ? value : value % Alphabet.length];
		}
	}

	public static class Encryptor
	{
		public static string Encrypt(string input, string key)
		{
			int size = Alphabet.length;

			Square square = new Square(size);

			string filling = "";
			do
			{
				filling = String.Concat(filling, key);
			}
			while (filling.Length < size);
			filling = filling.Substring(0, input.Length);

			string encrypted = "";

			for (int i = 0; i < input.Length; i++)
			{
				int x = Alphabet.alphabet.IndexOf(input[i].ToString(), StringComparison.CurrentCultureIgnoreCase);
				int y = Alphabet.alphabet.IndexOf(filling[i].ToString(), StringComparison.CurrentCultureIgnoreCase);
				encrypted = String.Concat(encrypted, square.Array[x, y]);
			}
			return encrypted;
		}
	}

	public static class Decryptor
	{
		public static String Decrypt(string input, string key)
		{
			int size = Alphabet.length;

			Square square = new Square(size);

			string filling = "";
			do
			{
				filling = String.Concat(filling, key);
			}
			while (filling.Length < size);
			filling = filling.Substring(0, input.Length);

			string decrypted = "";

			for (int i = 0; i < input.Length; i++)
			{
				int y = Alphabet.alphabet.IndexOf(filling[i].ToString(), StringComparison.CurrentCultureIgnoreCase);
				int x = -1;
				for (int col = 0; col < Alphabet.length; col++)
				{
					if (square.Array[col, y] == input[i])
					{
						x = col;
						break;
					}
				}
				//square.Array.
				//int x = Alphabet.alphabet.IndexOf(input[i]);
				decrypted = String.Concat(decrypted, square.Array[x, 0]);
			}
			return decrypted;
		}
	}
}
