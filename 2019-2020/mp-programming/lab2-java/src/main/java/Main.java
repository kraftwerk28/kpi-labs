import com.kpi.fict.DefaultStudentService;
import com.kpi.fict.repositories.StudentRepository;

public class Main {
    public static void main(String[] args) {
        StudentRepository r = new StudentRepository();
        DefaultStudentService ss = new DefaultStudentService(r);
        System.out.println(ss.findStudentWithMaxAvgExamRating());
        System.out.println(ss.findStudentsWithMathRatingMoreThanAvgAndTakeEngExam());
        System.out.println(ss.getExamSumAndRatingForEachStudent());
        System.out.println(ss.findStudentsWhoTakeMathEngExamWith180RatingOrMore());
        System.out.println(ss.findTwoStudentsWithMaxEngRating());
    }
}
