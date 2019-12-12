package com.kpi.fict.repositories;

import com.kpi.fict.entities.Exam;
import com.kpi.fict.entities.Student;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class StudentRepository {

    private List<Student> students = getStudents();

    private static List<Student> getStudents() {
        return Arrays.asList(
                new Student("1", 10,
                        Collections.singletonList(new Exam(Exam.Type.ENGLISH, 181))),
                new Student("2", 11,
                        Arrays.asList(new Exam(Exam.Type.ENGLISH, 182), new Exam(Exam.Type.MATH, 190))),
                new Student("3", 11,
                        Arrays.asList(new Exam(Exam.Type.ENGLISH, 183), new Exam(Exam.Type.MATH, 190))),
                new Student("4", 11,
                        Collections.emptyList())
        );
    }


    public List<Student> findAll() {
        return students;
    }

}
