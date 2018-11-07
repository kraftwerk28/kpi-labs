using System;
using System.IO;

namespace Lab2
{
	class Program
	{
		static void Main(string[] args)
		{
			int x = 0;
			string path;
			string outputPath;
			User[] users;
			User user;

			if (args.Length > -1)
			{
				path = args[0];
				outputPath = Path.GetDirectoryName(path) + "\\ip71_ambros_02_output.txt";
				x = Int32.Parse(args[1]);
				x = 6;

				string[] lines = File.ReadAllLines(path);
				users = new User[Int32.Parse(lines[0].Split(' ')[0]) - 1];

				user = new User(lines[x]);
				int offset = -1;
				Console.WriteLine("Вх1дн1 дан1:");
				for (int i = 1; i < lines.Length; i++)
				{
					if (i != x)
						users[i + offset] = new User(lines[i]);
					else offset--;

					Console.WriteLine(lines[i]);
				}

				int[] basicArray = user.Films;
				for (int i = 0; i < users.Length; i++)
				{
					users[i].Fav = InvCount(InvArray(basicArray, users[i].Films));
				}
				users = UserSort(users);

				Console.WriteLine("\nВих1дн1 дан1:");
				Console.WriteLine(x.ToString());
				File.WriteAllText(outputPath, x.ToString() + "\n");

				for (int i = 0; i < users.Length; i++)
				{
					Console.WriteLine(users[i].Index + " " + users[i].Fav);
					File.AppendAllText(outputPath, users[i].Index + " " + users[i].Fav + "\n");
				}
			}

			Console.ReadKey();

		}

		static int[] InvArray(int[] A, int[] B)
		{
			int[] res = new int[A.Length];
			for (int i = 0; i < A.Length; i++)
			{
				res[i] = Array.IndexOf(B, A[i]);
			}
			return res;
		}

		static int InvCount(int[] array)
		{
			int cnt = 0;
			for (int i = 0; i < array.Length - 1; i++)
				for (int j = i + 1; j < array.Length; j++)
					if (array[i] > array[j]) cnt++;
			return cnt;
		}

		static int[] MergeSort(int[] array)
		{
			int[] merge(int[] left, int[] right)
			{
				int[] res = new int[left.Length + right.Length];
				int resi = 0;
				int li = 0; // index for left side
				int ri = 0; // index for right side
				while (li < left.Length && ri < right.Length)
				{
					if (left[li] < right[ri])
						res[resi++] = left[li++];
					else
						res[resi++] = right[ri++];
				}
				while (li < left.Length)
					res[resi++] = left[li++];
				while (ri < right.Length)
					res[resi++] = right[ri++];
				return res;
			}

			int[] sort(int[] arr)
			{
				int mid = (int)Math.Floor((decimal)(arr.Length / 2));

				if (arr.Length < 2)
					return arr;

				int[] left = new int[mid];
				int[] right = new int[arr.Length - mid];
				Array.Copy(arr, left, mid);
				Array.Copy(arr, mid, right, 0, right.Length);

				return merge(sort(left), sort(right));
			}

			return sort(array);
		}

		static User[] UserSort(User[] array)
		{
			User[] merge(User[] left, User[] right)
			{
				User[] res = new User[left.Length + right.Length];
				int resi = 0;
				int li = 0; // index for left side
				int ri = 0; // index for right side
				while (li < left.Length && ri < right.Length)
				{
					if (left[li].Fav < right[ri].Fav)
						res[resi++] = left[li++];
					else
						res[resi++] = right[ri++];
				}
				while (li < left.Length)
					res[resi++] = left[li++];
				while (ri < right.Length)
					res[resi++] = right[ri++];
				return res;
			}

			User[] sort(User[] arr)
			{
				int mid = (int)Math.Floor((decimal)(arr.Length / 2));

				if (arr.Length < 2)
					return arr;

				User[] left = new User[mid];
				User[] right = new User[arr.Length - mid];
				Array.Copy(arr, left, mid);
				Array.Copy(arr, mid, right, 0, right.Length);

				return merge(sort(left), sort(right));
			}

			return sort(array);
		}

		static void PrintArray<T>(T[] array)
		{
			for (int i = 0; i < array.Length; i++)
			{
				Console.Write(array[i].ToString() + "\t");
			}
		}

		class User
		{
			public int Index { get; set; }
			public int[] Films { get; set; }
			public int Fav { get; set; }
			public User(string line)
			{
				string[] sa = line.Split(' ');
				Index = Int32.Parse(sa[0]);
				Films = new int[sa.Length - 1];
				for (int i = 0; i < sa.Length - 1; i++)
				{
					Films[i] = Int32.Parse(sa[i + 1]);
				}
			}
		}
	}
}
