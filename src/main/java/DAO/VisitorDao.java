package DAO;

import Model.Visitor;
import Model.BookingsModel;
import Model.UserModel;
import java.sql.*;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

public class VisitorDao {
    private Connection con;

    public VisitorDao(Connection con) {
        this.con = con;
    }

    // Get booking by ID
    public BookingsModel getBookingById(int bookingId) {
        BookingsModel booking = null;
        try {
            String sql = "SELECT * FROM bookings WHERE bookings_id = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, bookingId);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                booking = new BookingsModel();
                booking.setBookingId(rs.getInt("bookings_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setLocationId(rs.getInt("location_id"));
                booking.setVisitDate(rs.getDate("visit_date"));
                booking.setNumberOfAdults(rs.getInt("number_of_adults"));
                booking.setNumberOfChildren(rs.getInt("number_of_children"));
                booking.setTotalPrice(rs.getDouble("total_price"));
                booking.setStatus(rs.getString("status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return booking;
    }

    // Get user by ID
    public UserModel getUserById(int userId) {
        UserModel user = null;
        try {
            String sql = "SELECT * FROM users WHERE user_id = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                user = new UserModel();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setMobile(rs.getString("mobile"));
                user.setPassword(rs.getString("password"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Fetch visitors/bookings by a specific date
    public List<Visitor> getVisitorsByDate(LocalDate date, int locationId) {
        List<Visitor> list = new ArrayList<>();
        try {
            String sql = "SELECT b.bookings_id, u.name, u.email, u.mobile AS phone, b.visit_date, b.status, " +
                    "b.number_of_adults + b.number_of_childs AS total_passes, b.total_price " +
                    "FROM bookings b " +
                    "JOIN users u ON b.user_id = u.user_id " +
                    "WHERE b.visit_date = ? AND b.location_id = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setDate(1, Date.valueOf(date));
            pst.setInt(2, locationId);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Visitor v = new Visitor();
                v.setId(rs.getInt("bookings_id"));
                v.setName(rs.getString("name"));
                v.setEmail(rs.getString("email"));
                v.setPhone(rs.getString("phone"));
                v.setVisitDate(rs.getDate("visit_date").toLocalDate());
                v.setStatus(rs.getString("status"));
                v.setTotalPasses(rs.getInt("total_passes"));
                v.setTotalPrice(rs.getDouble("total_price"));
                list.add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    // get all upcoming visitors

    // Update booking status by bookings_id
    public boolean updateVisitorStatus(int bookingId, String newStatus) {
        try {
            String sql = "UPDATE bookings SET status = ? WHERE bookings_id = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, newStatus);
            pst.setInt(2, bookingId);
            return pst.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all future visitors from tomorrow onward
    public List<Visitor> getFutureVisitors(int locationId) {
        List<Visitor> list = new ArrayList<>();
        try {
            String sql = "SELECT b.bookings_id, u.name, u.email, u.mobile AS phone, b.visit_date, b.status, " +
                    "b.number_of_adults, b.number_of_childs, b.total_price " +
                    "FROM bookings b " +
                    "JOIN users u ON b.user_id = u.user_id " +
                    "WHERE b.visit_date > ? AND b.visit_date NOT IN (?, ?) AND b.location_id = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            LocalDate today = LocalDate.now();
            LocalDate tomorrow = today.plusDays(1);
            LocalDate dayAfterTomorrow = today.plusDays(2);
            pst.setDate(1, Date.valueOf(today));
            pst.setDate(2, Date.valueOf(tomorrow));
            pst.setDate(3, Date.valueOf(dayAfterTomorrow));
            pst.setInt(4, locationId);

            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Visitor v = new Visitor();
                v.setId(rs.getInt("bookings_id"));
                v.setName(rs.getString("name"));
                v.setEmail(rs.getString("email"));
                v.setPhone(rs.getString("phone"));
                v.setVisitDate(rs.getDate("visit_date").toLocalDate());
                v.setStatus(rs.getString("status"));
                int totalPasses = rs.getInt("number_of_adults") + rs.getInt("number_of_childs");
                v.setTotalPasses(totalPasses);
                v.setTotalPrice(rs.getDouble("total_price"));
                list.add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


}
