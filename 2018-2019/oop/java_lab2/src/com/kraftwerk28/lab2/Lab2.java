package com.kraftwerk28.lab2;

import java.util.Scanner;

public class Lab2 {
    private static String input = "";
    static Scanner scanner = new Scanner(System.in);

    public static void readFromConsole() {
        input = scanner.nextLine();
    }

    public static void addWordAfter(String searchWord, String appendedWord) {
        input = input
            .replaceAll(searchWord, searchWord + appendedWord);
    }

    public static void printInput() {
        System.out.println(input);
    }
}
