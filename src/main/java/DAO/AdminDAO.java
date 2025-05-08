package DAO;

import java.sql.*;
import Model.AdminModel;


public class AdminDAO {

    public boolean validateAdmin(AdminModel admin) {
        boolean status = false;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM super_admin WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, admin.getEmail());
            ps.setString(2, admin.getPassword());

            ResultSet rs = ps.executeQuery();
            status = rs.next(); // true if admin found

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}
