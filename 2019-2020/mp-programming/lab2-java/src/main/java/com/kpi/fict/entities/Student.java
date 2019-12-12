package com.kpi.fict.entities;

import java.util.List;
import java.util.Objects;

public class Student {
    private String name;
    private double rating;
    private List<Exam> exams;

    public Student(String name, double rating, List<Exam> exams) {
        this.name = name;
        this.rating = rating;
        this.exams = exams;
    }

    @Override
    public String toString() {
        return "Student{" +
                "name='" + name + '\'' +
                ", rating=" + rating +
                ", exams=" + exams +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Student)) return false;
        Student student = (Student) o;
        return Double.compare(student.rating, rating) == 0 &&
                Objects.equals(name, student.name) &&
                Objects.equals(exams, student.exams);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, rating, exams);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public List<Exam> getExams() {
        return exams;
    }

    public void setExams(List<Exam> exams) {
        this.exams = exams;
    }
}
