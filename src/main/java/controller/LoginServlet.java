package controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import Model.UserModel;  // Import your User model
import DAO.UserDAO;     // Import your UserDAO for database interaction

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters from the login form
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Fill the UserModel object with the form data
        UserModel user = new UserModel(null, password, null, email, null);

        // Call UserDAO to validate the login credentials
        UserDAO userDAO = new UserDAO();
        boolean isValid = userDAO.validateUserLogin(user);

        // Redirect based on validation result
        if (isValid) {
            // If valid, fetch the user details (optional: can fetch user data from the DB if necessary)
            UserModel userDetails = userDAO.getUserByEmail(email);

            // Store the user details in the session
            HttpSession session = request.getSession();
            session.setAttribute("user", userDetails);
            session.setAttribute("userID", userDetails.getUserId());
            session.setAttribute("role", userDetails.getRole());

            // Redirect to the user homepage or dashboard
            response.sendRedirect("login.jsp?status=success");
        } else {
            // If invalid, redirect back to the login page with a failure status
            response.sendRedirect("login.jsp?status=fail");
        }
    }
}
