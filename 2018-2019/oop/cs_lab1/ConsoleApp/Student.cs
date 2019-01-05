using System;
using System.Collections.Generic;
using System.Xml.Schema;

namespace CSLab1
{
  public class Student : Person, ICloneable
  {
    public Education EducationDegree { get; set; }
    public string GroupName { get; set; }
    public uint RecordBookId { get; set; }
    public List<Examination> Exams { get; set; }

    public Student() : base()
    {
      EducationDegree = Education.Bachelor;
      GroupName = "IP-71";
      RecordBookId = 0;
      Exams = new List<Examination>();
    }

    public Student(string name, string surname, string birthdate,
      Education degree, string groupName, uint recordBookId) :
      base(name, surname, birthdate)
    {
      EducationDegree = degree;
      GroupName = groupName;
      RecordBookId = recordBookId;
      Exams = new List<Examination>();
    }

    public float AverageScore
    {
      get
      {
        float res = 0;
        foreach (var i in Exams)
        {
          res += i.Score;
        }

        return res / Exams.Count;
      }
    }

    public void AddExams(Examination[] examList)
    {
      Exams.AddRange(examList);
    }

    public override string ToString()
    {
      return string.Format("Ім'я: {0}\nПрізвище: {1}\nГрупа: {2}\n",
        Name,
        Surname,
        GroupName
      );
      // return string.Format("{0} {1} {2}", Name, Surname, GroupName);
    }

    public override void PrintFullInfo()
    {
      Console.WriteLine("--------------------");
      Console.Write(
        "Ім'я: {0}\nПрізвище: {1}\nДата народження: {2}\nОсвіта: {3}\nГрупа: {4}\nНомер заліковки: {5}\nЕкзамени:\n{6}",
        Name,
        Surname,
        string.Format("{0}.{1}.{2}", Birthday.Date, Birthday.Month,
          Birthday.Year),
        EducationDegree,
        GroupName,
        RecordBookId,
        EnumExams()
      );
    }

    public object Clone()
    {
      var res = new Student(
        Name,
        Surname,
        string.Format("{0}.{1}.{2}", Birthday.Date, Birthday.Month,
          Birthday.Year),
        EducationDegree,
        GroupName,
        RecordBookId);
      res.Exams.AddRange(Exams);
      return res;
    }

    private string EnumExams()
    {
      string res = "";
      foreach (var exam in Exams)
      {
        res += exam.ToString();
      }

      return res;
    }

    public IEnumerable<Examination> IterateExamss()
    {
      foreach (Examination examination in Exams)
      {
        if (examination.IsDifferentiable)
        {
          yield return examination;
        }
        else
        {
          yield break;
        }
      }
    }

    public List<Examination> IterateExams()
    {
      var res = new List<Examination>();

      foreach (var i in Exams)
      {
        if (i.IsDifferentiable)
          res.Add(i);
      }

      return res;
    }


    public List<Examination> GetSortedExams()
    {
      var res = new List<Examination>(Exams);
      res.Sort((a, b) => string.Compare(a.SubjectName, b.SubjectName));
      return res;
    }
  }
}