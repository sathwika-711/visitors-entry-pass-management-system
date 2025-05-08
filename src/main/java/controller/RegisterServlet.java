package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import Model.UserModel; // Import the UserModel class
import DAO.UserDAO;     // Import the UserDAO class

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form data
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");

        // Create UserModel object and set its values
        UserModel user = new UserModel(name, password, mobile, email, gender);

        // Call UserDAO to insert the data into the database
        UserDAO userDAO = new UserDAO();
        boolean result = userDAO.registerUser(user);

        // Redirect based on the result of registration
        if (result) {
            // If registration is successful, redirect to the login page
            response.sendRedirect("login.jsp");
        } else {
            // If registration failed, redirect back to the registration page with an error
            response.sendRedirect("register.jsp?status=fail");
        }
    }
}
