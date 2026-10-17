package logs;
public class Logger {
    private static Logger instance;
    private LogLevel defaultLevel;

    private Logger() {
        this.defaultLevel = LogLevel.INFO;
    }

    public static synchronized Logger getInstance() {
        if (instance == null) {
            instance = new Logger();
        }
        return instance;
    }

    public void setDefaultLevel(LogLevel level) {
        if (level != null) {
            this.defaultLevel = level;
        }
    }

    public void log(String message) {
        log(defaultLevel, message);
    }

    public void log(LogLevel level, String message) {
        if (level == null) {
            level = defaultLevel;
        }
        String output = String.format("[%s] %s", level, message);
        System.out.println(output);
    }

    public void error(String message) {
        log(LogLevel.ERROR, message);
    }

    public void warning(String message) {
        log(LogLevel.WARNING, message);
    }

    public void info(String message) {
        log(LogLevel.INFO, message);
    }
}
