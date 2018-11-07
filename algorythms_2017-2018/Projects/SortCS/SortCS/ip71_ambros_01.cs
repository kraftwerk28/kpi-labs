using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Text;

namespace SortCS
{
	class ip71_ambros_01
	{
		static void Main(string[] args)
		{
			while (true)
			{
				Console.Write("Input path to file, that contains array:\n> ");
				string path = Console.ReadLine();
				string s = "";

				try
				{
					s = File.ReadAllText(path, Encoding.UTF8);
				}
				catch
				{
					Console.Clear();
					Console.WriteLine("Invalid path to file");
					continue;
				}

				Console.WriteLine("operation pending...");

				#region sorting
				string[] nums = s.Split(new string[] { "\n" }, StringSplitOptions.None);
				string[] stringArray = new string[nums.Length - 1];
				Array.Copy(nums, 1, stringArray, 0, nums.Length - 1);

				int[][] arrays = Sort.Split(Array.ConvertAll<string, int>(stringArray, st => int.Parse(st)));

				int[][] res = new int[][]
				{
					Sort.Insertion(arrays[0], Sort.SortMethod.ascending),
					Sort.Insertion(arrays[1], Sort.SortMethod.descending)
				};
				#endregion

				//Sort.PrintArray<int>(res[0]);
				//Sort.PrintArray<int>(res[1]);

				File.WriteAllText(Directory.GetParent(path).FullName + "\\ip71_Ambros_01_output" + Path.GetExtension(path),
					String.Join<int>("\n", Sort.Join(res[0], res[1])));

				Console.WriteLine("\nPress [esc] to exit, any key to continue working...");
				ConsoleKeyInfo k = Console.ReadKey();
				if (k.Key == ConsoleKey.Escape)
					break;
			}

		}

		public static class Sort
		{
			// перечисление для выбора сортировки по возрастанию, убыванию
			public enum SortMethod
			{
				ascending,
				descending
			}

			// реализация сортировки вставками
			public static int[] Insertion(int[] arr, SortMethod sortMethod)
			{
				int[] res = new int[arr.Length];
				Array.Copy(arr, res, arr.Length);
				switch (sortMethod)
				{
					case SortMethod.ascending:
						for (int k = 0; k < arr.Length - 1; k++)
						{
							int i = k + 1;
							while (i > 0)
							{
								if (res[i - 1] > res[i])
								{
									int temp = res[i - 1];
									res[i - 1] = res[i];
									res[i] = temp;
								}
								i--;
							}
						}
						break;
					case SortMethod.descending:
						for (int k = 0; k < arr.Length - 1; k++)
						{
							int i = k + 1;
							while (i > 0)
							{
								if (res[i - 1] < res[i])
								{
									int temp = res[i - 1];
									res[i - 1] = res[i];
									res[i] = temp;
								}
								i--;
							}
						}
						break;
				}
				return res;
			}

			// обобщенный метод для отображения массива в консоли
			public static string PrintArray<T>(T[] arr)
			{
				Console.WriteLine();
				string str = "";
				for (int i = 0; i < arr.Length; i++)
				{
					Console.WriteLine(arr[i].ToString());
					str = String.Concat(arr[i].ToString() + "\n");
				}
				return str;
			}

			// фунцкия, разделяющая массив на 2 массива с четными и нечетными числами
			public static int[][] Split(int[] arr)
			{
				List<int> even = new List<int>();
				List<int> odd = new List<int>();

				foreach (int n in arr)
				{
					if (n % 2 == 0)
					{
						even.Add(n);
					}
					else
					{
						odd.Add(n);
					}
				}
				return new int[][] { even.ToArray(), odd.ToArray() };
			}

			// фунцкия соединяющая два массива
			public static int[] Join(int[] arr1, int[] arr2)
			{
				int[] res = new int[arr1.Length + arr2.Length];
				Array.Copy(arr1, 0, res, 0, arr1.Length);
				Array.Copy(arr2, 0, res, arr1.Length, arr2.Length);
				return res;
			}
		}
	}
}
