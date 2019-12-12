package com.kpi.fict.entities;


import java.util.Objects;

public class Exam {
    public enum Type{
        ENGLISH, MATH
    }
    private Type type;
    private double score;

    public Exam(Type type, double score) {
        this.type = type;
        this.score = score;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Exam)) return false;
        Exam exam = (Exam) o;
        return Double.compare(exam.score, score) == 0 &&
                type == exam.type;
    }

    @Override
    public int hashCode() {
        return Objects.hash(type, score);
    }
}
