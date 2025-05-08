package DAO;

import java.sql.*;
import java.time.LocalDate;
import java.util.*;

import Model.LocationReport;

public class ReportDAO {

    private Connection conn;

    public ReportDAO(Connection conn) {
        this.conn = conn;
    }

    // Get total number of managers
    public int getTotalManagers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM managers";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // Get total number of locations
    public int getTotalLocations() throws SQLException {
        String sql = "SELECT COUNT(*) FROM locations";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // Get total visitors based on period
    public int getTotalVisitors(String period) throws SQLException {
        String sql = "SELECT SUM(number_of_adults + number_of_childs) " +
                "FROM bookings WHERE status = 'confirmed' AND visit_date >= ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, getStartDate(period));
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    // Get total revenue based on period
    public double getTotalRevenue(String period) throws SQLException {
        String sql = "SELECT SUM(total_price) FROM bookings WHERE status = 'confirmed' AND visit_date >= ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, getStartDate(period));
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getDouble(1) : 0.0;
            }
        }
    }

    // Get report for each location
    public List<LocationReport> getLocationReport(String period) throws SQLException {
        List<LocationReport> list = new ArrayList<>();

        String sql = "SELECT l.location_name, " +
                "SUM(b.number_of_adults + b.number_of_childs) AS total_visitors, " +
                "SUM(b.total_price) AS total_revenue " +
                "FROM bookings b " +
                "JOIN locations l ON b.location_id = l.location_id " +
                "WHERE b.status = 'confirmed' AND b.visit_date >= ? " +
                "GROUP BY l.location_name";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, getStartDate(period));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LocationReport report = new LocationReport();
                    String locationName = rs.getString("location_name");
                    int visitors = rs.getInt("total_visitors");
                    double revenue = rs.getDouble("total_revenue");

                    report.setLocationName(locationName);
                    report.setTotalVisitors(visitors);
                    report.setTotalRevenue(revenue);
                    report.setAverageRevenue(visitors > 0 ? revenue / visitors : 0.0);

                    list.add(report);
                }
            }
        }

        return list;
    }

    // Helper method to calculate the start date based on the selected period
    private java.sql.Date getStartDate(String period) {
        LocalDate today = LocalDate.now();

        switch (period.toLowerCase()) {
            case "weekly":
                return java.sql.Date.valueOf(today.minusWeeks(1));
            case "monthly":
                return java.sql.Date.valueOf(today.minusMonths(1));
            default: // "daily"
                return java.sql.Date.valueOf(today);
        }
    }
}
