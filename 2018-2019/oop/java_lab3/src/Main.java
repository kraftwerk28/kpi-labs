import com.kraftwerk28.recbook.*;

import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        System.out.println("Виконав:\tГрупа:\nАмброс В. В.\tІП-71\n" +
            "------------------------------\n");

        RecBook[] recbooks = new RecBook[10];
        for (int i = 0; i < 10; ++i) {
            recbooks[i] = createRandomRecBook();
        }

        RecBook[] filtered = Arrays.stream(recbooks)
            .filter(recBook -> recBook.getAvgScore() > 4)
            .toArray(RecBook[]::new);

        if (filtered.length == 0) {
            System.out.println(
                "Немає студентів, середній бал яких вищий за 4.");
            return;
        }
        for (RecBook rb : filtered) {
            System.out.println(rb.toString());
        }

    }

    private static String alphabet = "abcdefghijklmnopqrstuvwxyz";

    private static RecBook createRandomRecBook() {
        Subject[] subjects = new Subject[5];
        for (int i = 0; i < 5; ++i) {
            subjects[i] = createRandomSubject();
        }

        return new RecBook(
            randString(true),
            randString(true),
            randString(true),
            (short) randRange(1, 5),
            subjects
        );
    }

    private static Subject createRandomSubject() {
        return new Subject(
            randString(false),
            randRange(2, 6)
        );
    }

    private static int randRange(int from, int to) {
        return (int) (Math.random() * (to - from)) + from;
    }

    private static boolean filterComparer(RecBook recBook) {
        return recBook.getAvgScore() > 4;
    }

    private static String randString(boolean doCapitalize) {
        int length = randRange(5, 11);
        StringBuilder res = new StringBuilder();
        for (var i = 0; i < length; ++i) {
            res.append(
                alphabet.charAt(randRange(0, alphabet.length()))
            );
        }
        if (doCapitalize)
            res.setCharAt(0, Character.toUpperCase(res.charAt(0)));

        return res.toString();
    }
}
