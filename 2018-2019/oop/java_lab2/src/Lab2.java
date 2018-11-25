import java.util.Scanner;

class Lab2 {
    private static String input = "";
    static Scanner scanner = new Scanner(System.in);

    static void readFromConsole() {
        input = scanner.nextLine();
    }

    static void addWordAfter(String searchWord, String appendedWord) {
        input = input
            .replaceAll(searchWord, searchWord + appendedWord);
    }

    static void printInput() {
        System.out.println(input);
    }
}
