package com.kraftwerk28.matrix;

import java.util.Arrays;

public class Matrix {
    private static int K, N;

    public static short[][] generate(int dimension) {
        N = dimension;
        short[][] matrix = new short[N][N];
        for (int i = 0; i < N * N; i++) {
            matrix[i / N][i % N] = (short) ((Math.random() * N * N) - N);
        }
        return matrix;
    }

    public static void print(short[][] matrix) {
        for (short[] aMatrix : matrix) {
            for (int el : aMatrix) {
                System.out.printf("%d\t", el);
            }
            System.out.println();
        }
        System.out.println();
    }

    public static void sortByCol(short[][] matrix, int _k) {
        K = _k;
        Arrays.sort(matrix, Matrix::comparer);
    }

    private static int comparer(short[] a, short[] b)
    {
        return Integer.signum(a[K] - b[K]);
    }
}
