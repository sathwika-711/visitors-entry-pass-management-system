package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.*;

import Model.Booking;
import Model.BookingsModel;
import java.sql.Date;
import java.sql.DriverManager;

public class BookingsDAO {

    // Add a new booking
    public boolean addBooking(BookingsModel booking) {
        boolean status = false;

        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO bookings (user_id, location_id, number_of_adults, number_of_childs, total_price, visit_date, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, booking.getUserId());
            ps.setInt(2, booking.getLocationId());
            ps.setInt(3, booking.getNumberOfAdults());
            ps.setInt(4, booking.getNumberOfChildren());
            ps.setDouble(5, booking.getTotalPrice());
            ps.setDate(6, booking.getVisitDate());
            ps.setString(7, booking.getStatus());

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                status = true;
            }

        } catch (Exception e) {
            System.out.println("Error adding booking: " + e.getMessage());
            e.printStackTrace();
        }

        return status;
    }

    // Get all bookings by user with location names, including user_id
    public List<Map<String, Object>> getBookingsByUserId(int userId) {
        List<Map<String, Object>> bookings = new ArrayList<>();

        String sql = "SELECT b.bookings_id, b.user_id, l.location_name, b.visit_date, " +
                "       (b.number_of_adults + b.number_of_childs) AS total_passes, " +
                "       b.total_price, b.status " +
                "FROM bookings b JOIN locations l ON b.location_id = l.location_id " +
                "WHERE b.user_id = ? ORDER BY b.visit_date ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("bookings_id", rs.getInt("bookings_id"));
                row.put("user_id", rs.getInt("user_id")); // Now included
                row.put("location_name", rs.getString("location_name"));
                row.put("visit_date", rs.getDate("visit_date"));
                row.put("total_passes", rs.getInt("total_passes"));
                row.put("total_price", rs.getDouble("total_price"));
                row.put("status", rs.getString("status"));
                bookings.add(row);
            }

        } catch (Exception e) {
            System.out.println("Error fetching bookings: " + e.getMessage());
            e.printStackTrace();
        }

        return bookings;
    }

    // Cancel a booking by ID (sets status to 'cancelled')
    public boolean cancelBooking(int bookingId) {
        boolean status = false;
        String sql = "UPDATE bookings SET status = 'cancelled' WHERE bookings_id = ?";

        System.out.println("cancelled bookings:");
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            int updated = ps.executeUpdate();
            status = updated > 0;
            System.out.println(status);
        } catch (Exception e) {
            System.out.println("Error cancelling booking: " + e.getMessage());
            e.printStackTrace();
        }

        return status;
    }

    public int getTodayVisitorCount(int locationId) throws SQLException {
        String sql = "SELECT SUM(number_of_adults + number_of_childs) FROM bookings WHERE visit_date = CURDATE() AND location_id = ? AND status = 'confirmed'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, locationId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // returns 0 if NULL
            }
        }
        return 0;
    }



    public int getMonthlyVisitorCount(int locationId) throws SQLException {
        String sql = "SELECT SUM(number_of_adults + number_of_childs) FROM bookings WHERE MONTH(visit_date) = MONTH(CURDATE()) AND YEAR(visit_date) = YEAR(CURDATE()) AND location_id = ? AND status = 'confirmed'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, locationId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // returns 0 if NULL
            }
        }
        return 0;
    }




    public BookingsModel getLatestBookingByUserId(int userId) {
        BookingsModel booking = null;
        String sql = "SELECT * FROM bookings WHERE user_id = ? ORDER BY bookings_id DESC LIMIT 1";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                booking = new BookingsModel();
                booking.setBookingId(rs.getInt("bookings_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setLocationId(rs.getInt("location_id"));
                booking.setNumberOfAdults(rs.getInt("number_of_adults"));
                booking.setNumberOfChildren(rs.getInt("number_of_childs"));
                booking.setTotalPrice(rs.getDouble("total_price"));
                booking.setVisitDate(rs.getDate("visit_date"));
                booking.setStatus(rs.getString("status"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return booking;
    }


    public boolean updateBookingStatus(int bookingId, String status) {
        boolean updated = false;
        String sql = "UPDATE bookings SET status = ? WHERE bookings_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, bookingId);
            updated = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return updated;
    }




    public List<Map<String, Object>> getVisitorRevenueReport(String period) throws SQLException {
        String groupByClause = "";
        String dateFormat = "";

        switch (period.toLowerCase()) {
            case "daily":
                dateFormat = "%Y-%m-%d";
                groupByClause = "DATE(visit_date)";
                break;
            case "weekly":
                dateFormat = "%x-W%v"; // ISO week format
                groupByClause = "YEARWEEK(visit_date, 1)";
                break;
            case "monthly":
                dateFormat = "%Y-%m";
                groupByClause = "YEAR(visit_date), MONTH(visit_date)";
                break;
            default:
                throw new IllegalArgumentException("Invalid period: " + period);
        }

        // WARNING: Avoiding prepared statement for DATE_FORMAT argument
        String sql = "SELECT l.location_name, DATE_FORMAT(b.visit_date, '" + dateFormat + "') AS report_period, " +
                "SUM(b.number_of_adults + b.number_of_childs) AS total_visitors, " +
                "SUM(b.total_price) AS total_revenue " +
                "FROM bookings b " +
                "JOIN locations l ON b.location_id = l.location_id " +
                "WHERE b.status = 'confirmed' " +
                "GROUP BY l.location_name, " + groupByClause + " " +
                "ORDER BY report_period DESC";

        List<Map<String, Object>> reportData = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("location_name", rs.getString("location_name"));
                row.put("report_period", rs.getString("report_period"));
                row.put("total_visitors", rs.getInt("total_visitors"));
                row.put("total_revenue", rs.getDouble("total_revenue"));
                reportData.add(row);
            }
        }

        return reportData;
    }

    public double getTodaysRevenue(int locationId) throws SQLException {
        String sql = "SELECT SUM(total_price) FROM bookings " +
                "WHERE visit_date = CURDATE() AND location_id = ? AND status = 'confirmed'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, locationId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1); // returns 0.0 if NULL
            }
        }
        return 0.0;
    }

    public double getMonthlyRevenue(int locationId) throws SQLException {
        String sql = "SELECT SUM(total_price) FROM bookings " +
                "WHERE MONTH(visit_date) = MONTH(CURDATE()) " +
                "AND YEAR(visit_date) = YEAR(CURDATE()) " +
                "AND location_id = ? AND status = 'confirmed'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, locationId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1); // returns 0.0 if NULL
            }
        }
        return 0.0;
    }

//    public Map<String, Object> getBookingDetailsForPass(int bookingId) {
//        Map<String, Object> bookingData = new HashMap<>();
//
//        String sql = "SELECT b.bookings_id, b.status, b.total_price, " +
//                "(b.number_of_adults + b.number_of_childs) AS total_passes, " +
//                "u.name AS user_name, l.location_name " +
//                "FROM bookings b " +
//                "JOIN users u ON b.user_id = u.user_id " +
//                "JOIN locations l ON b.location_id = l.location_id " +
//                "WHERE b.bookings_id = ?";
//
//        try (Connection con = DBConnection.getConnection();
//             PreparedStatement ps = con.prepareStatement(sql)) {
//
//            ps.setInt(1, bookingId);
//            ResultSet rs = ps.executeQuery();
//
//            if (rs.next()) {
//                bookingData.put("booking_id", rs.getInt("bookings_id"));
//                bookingData.put("status", rs.getString("status"));
//                bookingData.put("total_price", rs.getDouble("total_price"));
//                bookingData.put("total_passes", rs.getInt("total_passes"));
//                bookingData.put("user_name", rs.getString("user_name"));
//                bookingData.put("location_name", rs.getString("location_name"));
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return bookingData;
//    }

// In BookingsDAO.java

    public BookingsModel getLatestBookingWithUserDetails(int userId) {
        BookingsModel booking = null;

        try {
            // Get the database connection
            Connection con = DBConnection.getConnection();

            // SQL query to get the latest booking with user and location details
            String sql = "SELECT b.bookings_id, b.user_id, b.location_id, b.visit_date, " +
                    "b.number_of_adults, b.number_of_childs, b.total_price, b.status, " +
                    "u.name AS visitor_name, l.location_name " +
                    "FROM bookings b " +
                    "JOIN users u ON b.user_id = u.user_id " + // Correct user_id reference
                    "JOIN locations l ON b.location_id = l.location_id " + // Correct location_id reference
                    "WHERE b.user_id = ? " +
                    "ORDER BY b.bookings_id DESC " +
                    "LIMIT 1";  // Get only the latest booking

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId); // Set user ID in the query

            ResultSet rs = ps.executeQuery();

            // If a booking is found, populate the BookingsModel
            if (rs.next()) {
                booking = new BookingsModel();
                booking.setBookingId(rs.getInt("bookings_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setLocationId(rs.getInt("location_id"));
                booking.setVisitDate(rs.getDate("visit_date"));
                booking.setNumberOfAdults(rs.getInt("number_of_adults"));
                booking.setNumberOfChildren(rs.getInt("number_of_childs"));  // Correct field name
                booking.setTotalPrice(rs.getDouble("total_price"));
                booking.setStatus(rs.getString("status"));
                booking.setVisitorName(rs.getString("visitor_name"));
                booking.setLocationName(rs.getString("location_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();  // Handle any exceptions during the query
        }

        return booking;  // Return the booking model (can be null if no booking found)
    }

    public BookingsModel getBookingById(int bookingId) {
        BookingsModel booking = null;

        try {
            // Get the database connection
            Connection con = DBConnection.getConnection();

            // SQL query to get the booking by booking_id with user and location details
            String sql = "SELECT b.bookings_id, b.user_id, b.location_id, b.visit_date, " +
                    "b.number_of_adults, b.number_of_childs, b.total_price, b.status, " +
                    "u.name AS visitor_name, l.location_name " +
                    "FROM bookings b " +
                    "JOIN users u ON b.user_id = u.user_id " + // Correct user_id reference
                    "JOIN locations l ON b.location_id = l.location_id " + // Correct location_id reference
                    "WHERE b.bookings_id = ?";  // Fetch by specific booking_id

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, bookingId); // Set booking ID in the query

            ResultSet rs = ps.executeQuery();

            // If a booking is found, populate the BookingsModel
            if (rs.next()) {
                booking = new BookingsModel();
                booking.setBookingId(rs.getInt("bookings_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setLocationId(rs.getInt("location_id"));
                booking.setVisitDate(rs.getDate("visit_date"));
                booking.setNumberOfAdults(rs.getInt("number_of_adults"));
                booking.setNumberOfChildren(rs.getInt("number_of_childs"));
                booking.setTotalPrice(rs.getDouble("total_price"));
                booking.setStatus(rs.getString("status"));
                booking.setVisitorName(rs.getString("visitor_name"));
                booking.setLocationName(rs.getString("location_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();  // Handle any exceptions during the query
        }

        return booking;  // Return the booking model (can be null if no booking found)
    }





}
