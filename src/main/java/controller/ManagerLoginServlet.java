package controller;

import DAO.ManagerDao;
import Model.Manager;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/ManagerLoginServlet")
public class ManagerLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Retrieving form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Print the input email and password to check values
        System.out.println("Email: " + email);
        System.out.println("Password: " + password);
        
        // Creating an instance of ManagerDao
        ManagerDao dao = new ManagerDao();
        
        // Attempting to log in with the given email and password
        Manager manager = dao.login(email, password);
        
        // Print the result of the login attempt
        if (manager != null) {
            System.out.println("Login successful. Manager found: " + manager.getName());
            // Creating session for the logged-in manager
            HttpSession session = request.getSession();
            session.setAttribute("manager", manager);
            
            // Redirecting to the dashboard page
            System.out.println("Redirecting to manager_dashboard.jsp");
            response.sendRedirect("ManagerDashboardServlet");
 // You can create this page later
        } else {
            // Print when login fails
            System.out.println("Login failed. Invalid email or password.");
            
            // Setting error message and forwarding to the login page
            request.setAttribute("error", "Invalid email or password!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("manager_login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
