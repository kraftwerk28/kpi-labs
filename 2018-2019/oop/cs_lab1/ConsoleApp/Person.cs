using System;

namespace CSLab1
{
  public struct BirthDate
  {
  }

  public class Person
  {
    public string Name { get; set; }
    public string Surname { get; set; }
    protected DateTime Birthday { get; set; }

    public int BirthYear
    {
      get { return Birthday.Year; }
      set { Birthday = new DateTime(value, Birthday.Month, Birthday.Day); }
    }

    public Person()
    {
      Name = "Uvuvwevwevwe Onyetenyevwe";
      Surname = "Ugwemuhwem Ossas";
      Birthday = new DateTime(2000, 05, 28);
    }

    public Person(string name, string surname, string birthdate)
    {
      Name = name;
      Surname = surname;
      Birthday = new DateTime(
        Int32.Parse(birthdate.Substring(6, 4)),
        Int32.Parse(birthdate.Substring(3, 2)),
        Int32.Parse(birthdate.Substring(0, 2))
      );
    }

    public virtual void PrintFullInfo()
    {
      Console.WriteLine("--------------------");
      Console.Write(
        "Ім'я: {0}\nПрізвище: {1}\nДата народження: {2}\n",
        Name,
        Surname,
        string.Format("{0}.{1}.{2}", Birthday.Date, Birthday.Month,
          Birthday.Year)
      );
    }
  }
}