public class Logger {
    public static void Log(Object data) {
        System.out.println(data.toString());
    }

    public static void Log(String desc, Object data) {
        System.out.printf("%s: %s\n", desc, data.toString());
    }
}
