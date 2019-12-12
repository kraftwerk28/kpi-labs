import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        var t = new Task1();
        Logger.Log(t.getList());
        Logger.Log(Arrays.toString(t.twoMax()));
        Logger.Log(t.avg());
        Logger.Log(t.firstPositive());
        Logger.Log(t.countZeroes());
        Logger.Log(Arrays.toString(t.nonUnique()));
    }
}
