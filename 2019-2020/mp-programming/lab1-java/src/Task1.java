import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Random;

public class Task1 {
    private ArrayList<Integer> l;
    static final int ARR_SIZE = 10;
    Task1() {
        l = new ArrayList<>();
        var r = new Random();
        for (var i = 0; i < ARR_SIZE; ++i) {
            l.add(r.nextInt(ARR_SIZE));
        }
    }

    public double avg() {
        return l.stream().mapToInt(x -> x).summaryStatistics().getAverage();
    }

    public int[] twoMax() {
        var iter = l.stream().sorted(Collections.reverseOrder()).iterator();
        return new int[]{ iter.next(), iter.next() };
    }

    public int firstPositive() {
        return l.stream().filter(x -> x >= 0).findFirst().get();
    }

    public int countZeroes() {
        return l.stream().reduce(0, (acc, i) -> i == 0 ? acc + 1 : acc);
    }

    public int[] nonUnique() {
        return l.stream().filter(n -> l.stream().filter(x -> x == n).count() > 1).mapToInt(x -> x).toArray();
    }

    public ArrayList<Integer> getList() {
        return l;
    }
}
