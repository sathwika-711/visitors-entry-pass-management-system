package DAO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final Log log = LogFactory.getLog(DBConnection.class);

    private static final String DB_URL = "jdbc:mysql://localhost:3306/visitor_pass?useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root123";

    // Method to get the database connection
    public static Connection getConnection() {
        Connection con = null;
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            log.info("MySQL JDBC Driver loaded successfully");

            // Establish the connection
            log.info("Attempting to connect to database: " + DB_URL);
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            log.info("Database connection established successfully");
        } catch (ClassNotFoundException e) {
            log.error("Error: MySQL JDBC Driver not found");
            e.printStackTrace();
        } catch (Exception e) {
            log.error("Error in DBConnection: " + e.getMessage() + e.getCause());
            log.error("Please check if:");
            log.error("1. MySQL server is running");
            log.error("2. Database 'visitor_pass' exists");
            log.error("3. Username and password are correct");
            log.error("4. MySQL server is accessible on localhost:3306");
//            e.printStackTrace();
        }
        return con;
    }
}
