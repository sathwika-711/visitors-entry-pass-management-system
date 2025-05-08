package DAO;

import java.sql.*;
import Model.UserModel;

public class ProfileDAO {

    private Connection conn;

    public ProfileDAO(Connection conn) {
        this.conn = conn;
    }

    // Get user by ID
    public UserModel getUserById(int userId) {
        UserModel user = null;
        try {
            String sql = "SELECT * FROM users WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new UserModel();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setMobile(rs.getString("mobile"));
                user.setAddress(rs.getString("address"));
                user.setGender(rs.getString("gender"));
                user.setRole(rs.getString("role"));
                user.setPassword(rs.getString("password"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Update user profile
    public boolean updateUser(UserModel user) {
        boolean updated = false;
        try {
            String sql = "UPDATE users SET name = ?, email = ?, mobile = ?, address = ?, gender = ? WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getMobile());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getGender());
            ps.setInt(6, user.getUserId());

            updated = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return updated;
    }
}
