import com.kraftwerk28.matrix.Matrix;

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        System.out.println("Виконав:\tГрупа:\nАмброс В. В.\tІП-71\n" +
                "--------------------\n");
        Scanner scanner = new Scanner(System.in);

        int N = scanner.nextInt();
        int k = 1;


        var matrix = Matrix.generate(N);
        System.out.println("Вихідна матриця:");
        Matrix.print(matrix);

        Matrix.sortByCol(matrix, 1);
        System.out.printf("Відсорована за %d колонкою матриця:\n", k + 1);
        Matrix.print(matrix);

    }
}
