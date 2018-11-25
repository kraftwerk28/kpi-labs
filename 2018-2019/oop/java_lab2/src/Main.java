import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        System.out.println("Виконав:\tГрупа:\nАмброс В. В.\tІП-71\n" +
            "--------------------\n");
        var scanner = new Scanner(System.in);

        System.out.println("Введіть речення:");
        Lab2.readFromConsole();
        Lab2.printInput();

        String toSearch = null, toAppend = null;

        System.out.println("Введіть строку для пошуку:");
        toSearch = scanner.nextLine();

        System.out.println("Введіть строку для додавання:");
        toAppend = scanner.nextLine();

        Lab2.addWordAfter(toSearch, toAppend);
        Lab2.printInput();
    }
}
