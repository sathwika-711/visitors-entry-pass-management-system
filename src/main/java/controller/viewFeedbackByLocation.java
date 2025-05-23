package controller;

import DAO.FeedbackDAO;
import Model.Feedback;
import Model.Manager;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/viewFeedbackByLocation")
public class viewFeedbackByLocation extends HttpServlet {

    // Handles GET requests to display feedbacks for the manager's location
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Manager manager = (Manager) session.getAttribute("manager");

        if (manager == null) {
            response.sendRedirect("manager_login.jsp");
            return;
        }

        int locationId = manager.getLocationId();
        FeedbackDAO dao = new FeedbackDAO();
        List<Feedback> feedbacks = dao.getFeedbacksByLocationId(locationId);

        request.setAttribute("feedbacks", feedbacks);
        request.getRequestDispatcher("manager_feedbacks.jsp").forward(request, response);
    }

    // POST not needed for now, so can be omitted or kept empty
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Optional: treat POST same as GET
    }
}
