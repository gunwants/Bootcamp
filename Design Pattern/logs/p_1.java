package logs;
public class p_1 {
    public static void main(String[] args) {
        Logger logger = Logger.getInstance();

        logger.log("This is an info message using the default level.");
        logger.error("This is an error message.");
        logger.warning("This is a warning message.");
        logger.info("This is an explicit info message.");

        // Example of using logger from another part of the application.
        performTask();
    }

    private static void performTask() {
        Logger logger = Logger.getInstance();
        logger.log(LogLevel.ERROR, "Task failed due to invalid input.");
        logger.log(LogLevel.WARNING, "Task completed with warnings.");
        logger.log(LogLevel.INFO, "Task completed successfully.");
    }
}
