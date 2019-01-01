using System;
using System.Text;

namespace CSLab1
{
  internal class Program
  {
    public static void Main(string[] args)
    {
      Console.OutputEncoding = Encoding.UTF8;

      var st = new Student();

      Console.WriteLine(st.ToString());

      st.Exams.Add(new Examination(2, "ТЙіМС", "Гарко І. І.", 85, true,
        "14.01.2019"));
      st.Exams.Add(new Examination(2, "ООП", "Муха І. П.", 100, true,
        "09.01.2019"));
      st.Exams.Add(new Examination(2, "Архітектура комп'ютера", "Коган А. В.",
        100, true, "17.01.2019"));
      
      st.PrintFullInfo();

      Console.ReadLine();
    }
  }
}