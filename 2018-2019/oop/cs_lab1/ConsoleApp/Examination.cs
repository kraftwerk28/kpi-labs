using System;

namespace CSLab1
{
  public class Examination : IMarkName
  {
    public uint SemesterNum { get; set; }
    public string SubjectName { get; set; }
    public string PrepodName { get; set; }
    public float Score { get; set; }
    public bool IsDifferentiable { get; set; }
    public DateTime Date { get; set; }

    public Examination()
    {
      SemesterNum = 1;
      SubjectName = "Proga";
      PrepodName = "Shemsedinov T. G.";
      Score = 95;
      IsDifferentiable = true;
      Date = new DateTime(1917, 10, 25);
    }

    public Examination(uint semesterNum, string subjectName, string prepodName,
      float score, bool isDifferentiable, string date)
    {
      SemesterNum = semesterNum;
      SubjectName = subjectName;
      PrepodName = prepodName;
      Score = score;
      IsDifferentiable = isDifferentiable;
      Date = new DateTime(
        Int32.Parse(date.Substring(6, 4)),
        Int32.Parse(date.Substring(3, 2)),
        Int32.Parse(date.Substring(0, 2))
      );
    }

    public override string ToString()
    {
      return string.Format("{0}\tвикладач: {1}\t{2} балів\n", SubjectName,
        PrepodName, Score);
    }

    public string NationalScaleName()
    {
      if (Score < 60)
        return "Недопущено";
      else if (Score < 65)
        return "Незадовільно";
      else if (Score < 75)
        return "Задовільно";
      else if (Score < 85)
        return "Добре";
      else if (Score < 95)
        return "Дуже добре";
      else
        return "Відмінно";
    }

    public string EctsScaleName()
    {
      if (Score < 60)
        return "F";
      else if (Score < 65)
        return "E";
      else if (Score < 75)
        return "D";
      else if (Score < 85)
        return "C";
      else if (Score < 95)
        return "B";
      else
        return "A";
    }
  }
}