package com.kraftwerk28.recbook;

public class RecBook {
    private String name, surname, patronymic;
    private short course;
    private Subject[] subjects;

    public RecBook() {
    }

    public RecBook(
        String _name,
        String _surname,
        String _patronymic,
        short _course,
        Subject[] _subjects
    ) {
        name = _name;
        surname = _surname;
        patronymic = _patronymic;
        course = _course;
        subjects = new Subject[_subjects.length];
        System.arraycopy(_subjects, 0,
            subjects, 0, _subjects.length);
    }

    public String toString() {
        StringBuilder subjectsStr = new StringBuilder();
        for (var subject : subjects) {
            subjectsStr.append(String.format(
                "Предмет:\t%s\nБал:\t\t%s",
                subject.name,
                subject.score
            )).append("\n---------------\n");
        }

        return String.format(
            "Прізвище:\tІм'я:\tПо-батькові:\n%s\t%s\t%s\n" +
                "Курс: %s\n" +
                "Середній бал: %s\n",
            name,
            surname,
            patronymic,
            course,
            getAvgScore()
        ) + "--------------------\n" + subjectsStr;
    }

    public float getAvgScore() {
        float res = 0;
        for (var subject : subjects) {
            res += subject.score;
        }
        return res / subjects.length;
    }
}
