package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Model.UserModel;

public class UserDAO {

    // Register a new user
    public boolean registerUser(UserModel user) {
        boolean status = false;

        try (Connection con = DBConnection.getConnection()) {

            // SQL query to insert new user
            String sql = "INSERT INTO users (name, password, mobile, email, gender) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getPassword()); // Hashing can be added here
            ps.setString(3, user.getMobile());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getGender());

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                status = true;
            }

        } catch (Exception e) {
            System.out.println("Error inserting user: " + e.getMessage());
        }

        return status;
    }
    
    // Validate user login credentials
    public boolean validateUserLogin(UserModel user) {
        boolean status = false;

        try (Connection con = DBConnection.getConnection()) {

            // SQL query to check if the email and password match
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

            // Prepare the statement and set values
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());  // Hashing can be added here

            // Execute the query
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                status = true;
            }

        } catch (Exception e) {
            System.out.println("Error validating login: " + e.getMessage());
        }

        return status;
    }
    
    // Get user details by email
    public UserModel getUserByEmail(String email) {
        UserModel user = null;

        try (Connection con = DBConnection.getConnection()) {

            // SQL query to fetch user details by email
            String sql = "SELECT * FROM users WHERE email = ?";

            // Prepare the statement and set the email parameter
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            // Execute the query
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Map the result to the UserModel
            	int id = rs.getInt("user_id");
                String name = rs.getString("name");
                String password = rs.getString("password");
                String mobile = rs.getString("mobile");
                String gender = rs.getString("gender");
                String role = rs.getString("role");

                user = new UserModel(name, password, mobile, email, gender);
                user.setUserId(id);
            }

        } catch (Exception e) {
            System.out.println("Error fetching user by email: " + e.getMessage());
        }

        return user;
    }
    public boolean updateUserProfile(UserModel user) {
        boolean updated = false;

        try (Connection con = DBConnection.getConnection()) {
            String sql = "UPDATE users SET name = ?, mobile = ?, address = ? WHERE user_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getMobile());
            ps.setString(3, user.getAddress());
            ps.setInt(4, user.getUserId());

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                updated = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updated;
    }


    
   
}
