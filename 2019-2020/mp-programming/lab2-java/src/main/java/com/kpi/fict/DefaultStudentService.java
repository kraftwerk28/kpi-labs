package com.kpi.fict;

import com.kpi.fict.entities.Exam;
import com.kpi.fict.entities.Student;
import com.kpi.fict.repositories.StudentRepository;

import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class DefaultStudentService implements StudentService {
    private StudentRepository studentRepository;

    public DefaultStudentService(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    @Override
    public Student findStudentWithMaxAvgExamRating() {
        return studentRepository
                .findAll()
                .stream()
                .max((a, b) -> {
                    double r1 = a
                            .getExams()
                            .stream()
                            .mapToDouble(Exam::getScore)
                            .average()
                            .orElse(0.);
                    double r2 = b
                            .getExams()
                            .stream()
                            .mapToDouble(Exam::getScore)
                            .average()
                            .orElse(0.);
                    return Double.compare(r1, r2);
                })
                .orElse(studentRepository.findAll().get(0));
    }

    @Override
    public List<Student> findStudentsWithMathRatingMoreThanAvgAndTakeEngExam() {
        double avg = studentRepository
                .findAll()
                .stream()
                .flatMap(s -> s.getExams().stream())
                .filter(e -> e.getType() == Exam.Type.MATH)
                .mapToDouble(Exam::getScore)
                .average()
                .orElse(0.);
        return studentRepository
                .findAll()
                .stream()
                .filter(s ->
                        s
                                .getExams()
                                .stream()
                                .filter(e -> e.getType() == Exam.Type.MATH)
                                .findFirst()
                                .orElse(new Exam(Exam.Type.MATH, 0))
                                .getScore() > avg &&
                        s
                                .getExams()
                                .stream()
                                .anyMatch(e -> e.getType() == Exam.Type.ENGLISH))
                .collect(Collectors.toList());
    }

    // c
    //Delimiter: ','
    @Override
    public List<String> getExamSumAndRatingForEachStudent() {
        return studentRepository
                .findAll()
                .stream()
                .map(s -> {
                    Optional<Double> sum = s
                            .getExams()
                            .stream()
                            .map(Exam::getScore)
                            .reduce(Double::sum);
                    double _sum = sum.isPresent() ? sum.get() : 0;
                    return _sum + "," + s.getRating() + "," + s.getName();
                })
                .collect(Collectors.toList());
    }

    @Override
    public List<Student> findStudentsWhoTakeMathEngExamWith180RatingOrMore() {
        return studentRepository
                .findAll()
                .stream()
                .filter(s ->
                        s
                                .getExams()
                                .stream()
                                .filter(e -> e.getType() == Exam.Type.MATH)
                                .findFirst()
                                .orElse(new Exam(Exam.Type.MATH, 0))
                                .getScore() > 180 &&
                        s
                                .getExams()
                                .stream()
                                .filter(e -> e.getType() == Exam.Type.ENGLISH)
                                .findFirst()
                                .orElse(new Exam(Exam.Type.ENGLISH, 0))
                                .getScore() > 180
                )
                .collect(Collectors.toList());
    }

    @Override
    public List<Student> findTwoStudentsWithMaxEngRating() {
        return studentRepository
                .findAll()
                .stream()
                .sorted((a, b) -> {
                    Optional<Exam> aa = a
                            .getExams()
                            .stream()
                            .filter(e -> e.getType() == Exam.Type.ENGLISH)
                            .findFirst();
                    Optional<Exam> bb = b
                            .getExams()
                            .stream()
                            .filter(e -> e.getType() == Exam.Type.ENGLISH)
                            .findFirst();
                    double _aa = aa.map(Exam::getScore).orElse(0.0);
                    double _bb = bb.map(Exam::getScore).orElse(0.0);
                    return Double.compare(_bb, _aa);
                })
                .limit(2)
                .sorted(Comparator.comparing(Student::getName))
                .collect(Collectors.toList());
    }

    public StudentRepository getStudentRepository() {
        return studentRepository;
    }

    public void setStudentRepository(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }
}
