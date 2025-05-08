package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import Model.Booking;
import Model.Manager;

public class ManagerDao {

    public Manager login(String email, String password) {
        Manager manager = null;

        String query = "SELECT m.manager_id, m.name, m.email, m.password, m.location_id, l.location_name " +
                       "FROM managers m " +
                       "JOIN locations l ON m.location_id = l.location_id " +
                       "WHERE m.email = ? AND m.password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                manager = new Manager();
                manager.setManagerId(rs.getInt("manager_id"));
                manager.setName(rs.getString("name"));
                manager.setEmail(rs.getString("email"));
                manager.setPassword(rs.getString("password"));
                manager.setLocationId(rs.getInt("location_id"));
                manager.setLocationName(rs.getString("location_name")); // Updated column
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return manager;
    }
    
    
    public boolean insertManager(Manager manager) {
        String sql = "INSERT INTO managers (name, email, password, location_id) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, manager.getName());
            stmt.setString(2, manager.getEmail());
            stmt.setString(3, manager.getPassword());
            stmt.setInt(4, manager.getLocationId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteManager(int managerId) {
        String sql = "DELETE FROM managers WHERE manager_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, managerId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Manager> getAllManagers() {
        List<Manager> list = new ArrayList<>();
        String sql = "SELECT * FROM managers";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Manager manager = new Manager();
                manager.setManagerId(rs.getInt("manager_id"));
                manager.setName(rs.getString("name"));
                manager.setEmail(rs.getString("email"));
                manager.setPassword(rs.getString("password"));
                manager.setLocationId(rs.getInt("location_id"));
                list.add(manager);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    
    
    
    public int getMonthlyVisitorCount(int managerId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM bookings WHERE MONTH(visit_date) = MONTH(CURRENT_DATE()) " +
                     "AND YEAR(visit_date) = YEAR(CURRENT_DATE()) AND manager_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, managerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    
    
 // 1. Get total number of visitors today for this manager
    public int getTodaysVisitorCount(int managerId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM bookings WHERE visit_date = CURRENT_DATE AND manager_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, managerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // 2. Get count of pending check-ins for today
    public int getPendingVisitorCount(int managerId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM bookings WHERE status = 'pending' AND visit_date = CURRENT_DATE AND manager_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, managerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
    
// // 3. Get list of today's bookings
//    public List<Booking> getTodaysBookings(int managerId) {
//        List<Booking> bookings = new ArrayList<>();
//        String sql = "SELECT * FROM bookings WHERE visit_date = CURRENT_DATE AND manager_id = ?";
//        try (Connection conn = DBConnection.getConnection();
//                PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setInt(1, managerId);
//            ResultSet rs = stmt.executeQuery();
//            while (rs.next()) {
//                Booking booking = new Booking();
//                booking.setBookingId(rs.getInt("booking_id"));
//                booking.setVisitorName(rs.getString("visitor_name"));
//                booking.setVisitDate(rs.getDate("visit_date").toLocalDate());
////                booking.setVisitTime(rs.getTime("visit_time").toLocalTime());
//                booking.setStatus(rs.getString("status"));
//                booking.setLocationId(rs.getInt("location_id"));
//                booking.setManagerId(rs.getInt("manager_id"));
//                // Add any other fields you have in Booking model
//                bookings.add(booking);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return bookings;
//    }
}
