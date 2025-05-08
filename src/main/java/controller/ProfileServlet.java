package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import DAO.DBConnection;
import DAO.ProfileDAO;
import Model.UserModel;

import java.io.*;
import java.sql.Connection;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // GET: Show user profile
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserModel loggedUser = (UserModel) session.getAttribute("user");

        if (loggedUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Connection conn = DBConnection.getConnection();
            ProfileDAO dao = new ProfileDAO(conn);
            UserModel user = dao.getUserById(loggedUser.getUserId());

            request.setAttribute("user", user);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // PUT: Update profile (requires JS or form override)
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle form data
        int userId = Integer.parseInt(request.getParameter("userId"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");

        UserModel user = new UserModel();
        user.setUserId(userId);
        user.setName(name);
        user.setEmail(email);
        user.setMobile(mobile);
        user.setAddress(address);
        user.setGender(gender);

        try {
            Connection conn = DBConnection.getConnection();
            ProfileDAO dao = new ProfileDAO(conn);
            boolean success = dao.updateUser(user);

            if (success) {
            	HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Redirect to home.jsp
                response.sendRedirect("profile");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Update failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    // Optional: Redirect POST to PUT if form doesn't support PUT directly
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPut(request, response);
    }
}
