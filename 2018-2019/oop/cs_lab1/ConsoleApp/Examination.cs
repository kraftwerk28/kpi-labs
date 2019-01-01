using System;

namespace CSLab1
{
  public class Examination
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
  }
}