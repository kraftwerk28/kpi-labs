public class Main {
    public static void main(String[] args) {
        System.out.println("Виконав:\tГрупа:\nАмброс В. В.\tІП-71\n" +
                "--------------------\n");

        int N = 5;

        var matrix = Matrix.generate(N);

        Matrix.print(matrix);
        Matrix.sortByCol(matrix, 1);
        Matrix.print(matrix);

    }
}
