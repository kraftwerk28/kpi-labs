import java.util.Arrays;

class Matrix {
    static short[][] generate(int dimension) {
        int N = dimension;
        short[][] matrix = new short[N][N];
        for (int i = 0; i < N * N; i++) {
            matrix[i / N][i % N] = (short) (Math.random() * N * N);
        }
        return matrix;
    }

    static void print(short[][] matrix) {
        for (short[] aMatrix : matrix) {
            for (int el : aMatrix) {
                System.out.printf("%d\t", el);
            }
            System.out.println();
        }
        System.out.println();
    }

    static void sortByCol(short[][] matrix, int k) {
        Arrays.sort(
            matrix,
            (short[] a, short[] b) -> Integer.signum(a[k] - b[k])
        );
    }
}
