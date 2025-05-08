package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Invalidate the current session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Get the role parameter from the request
        String role = request.getParameter("role");

        // Determine the redirect URL based on the role
        String redirectUrl = "login.jsp?logout=success"; // default

        if (role != null) {
            switch (role.toLowerCase()) {
                case "admin":
                    redirectUrl = "adminlogin.jsp?logout=success";
                    break;
                case "manager":
                    redirectUrl = "manager_login.jsp?logout=success";
                    break;
                case "visitor":
                    redirectUrl = "login.jsp?logout=success";
                    break;
                default:
                    redirectUrl = "login.jsp?logout=success";
            }
        }

        // Redirect to appropriate login page
        response.sendRedirect(redirectUrl);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
