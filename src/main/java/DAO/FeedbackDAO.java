package DAO;

import Model.Feedback;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {

    private static final Log log = LogFactory.getLog(FeedbackDAO.class);

    private Connection conn;

    public FeedbackDAO() {
        conn = DBConnection.getConnection();
    }

    public boolean saveFeedback(Feedback feedback, int userId) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO feedbacks (user_id, email, location_id, description, rating) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, feedback.getEmail());
            ps.setInt(3, feedback.getLocationId());
            ps.setInt(5, feedback.getRating());
            ps.setString(4, feedback.getDescription());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

            ps.close();
            con.close();

        } catch (Exception e) {
            log.info("Error in saveFeedback: " + e.getMessage());
            e.printStackTrace(); // Make sure this prints in console for debugging
        }

        return status;
    }

    public List<Feedback> getAllFeedbacks() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.*, l.location_name FROM feedbacks f " +
                "LEFT JOIN locations l ON f.location_id = l.location_id " +
                "ORDER BY f.submitted_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setId(rs.getInt("id"));
                fb.setUserId(rs.getInt("user_id"));
                fb.setEmail(rs.getString("email"));
                fb.setLocationId(rs.getInt("location_id"));
                fb.setLocationName(rs.getString("location_name"));
                fb.setDescription(rs.getString("description"));
                fb.setRating(rs.getInt("rating"));
                fb.setSubmittedAt(rs.getTimestamp("submitted_at"));
                list.add(fb);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    public List<Feedback> getFeedbacksByRating(int ratingFilter) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.*, l.location_name FROM feedbacks f " +
                "LEFT JOIN locations l ON f.location_id = l.location_id " +
                "WHERE f.rating = ? ORDER BY f.submitted_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ratingFilter);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setId(rs.getInt("id"));
                fb.setUserId(rs.getInt("user_id"));
                fb.setEmail(rs.getString("email"));
                fb.setLocationId(rs.getInt("location_id"));
                fb.setLocationName(rs.getString("location_name"));
                fb.setDescription(rs.getString("description"));
                fb.setRating(rs.getInt("rating"));
                fb.setSubmittedAt(rs.getTimestamp("submitted_at"));
                list.add(fb);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Feedback> getFeedbacksByLocationId(int locationId) {
        List<Feedback> feedbackList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM feedbacks WHERE location_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, locationId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setId(rs.getInt("id"));
                feedback.setUserId(rs.getInt("user_id"));
                feedback.setEmail(rs.getString("email"));
                feedback.setLocationId(rs.getInt("location_id"));
                feedback.setDescription(rs.getString("description"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setSubmittedAt(rs.getTimestamp("submitted_at"));

                feedbackList.add(feedback);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return feedbackList;
    }

}
