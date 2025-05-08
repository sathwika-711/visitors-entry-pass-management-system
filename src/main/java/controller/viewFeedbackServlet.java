package controller;

import DAO.FeedbackDAO;
import Model.Feedback;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/viewFeedbacks")
public class viewFeedbackServlet extends HttpServlet {

    // Handles GET requests to display all feedback
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Optional: Role check for admin access
        // if (session == null || session.getAttribute("role") == null || !session.getAttribute("role").equals("admin")) {
        //     response.sendRedirect("../login.jsp?status=unauthorized");
        //     return;
        // }

        FeedbackDAO dao = new FeedbackDAO();
        List<Feedback> feedbacks = dao.getAllFeedbacks();

        request.setAttribute("feedbacks", feedbacks);
        request.getRequestDispatcher("feedbackreview.jsp").forward(request, response);
    }

    // Handles POST requests (e.g., filtering)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Example of filter by rating (extendable as needed)
        String ratingStr = request.getParameter("rating");
        FeedbackDAO dao = new FeedbackDAO();
        List<Feedback> feedbacks;

        if (ratingStr != null && !ratingStr.isEmpty()) {
            try {
                int rating = Integer.parseInt(ratingStr);
                feedbacks = dao.getFeedbacksByRating(rating); // You will need to implement this in DAO
            } catch (NumberFormatException e) {
                feedbacks = dao.getAllFeedbacks(); // fallback
            }
        } else {
            feedbacks = dao.getAllFeedbacks();
        }

        request.setAttribute("feedbacks", feedbacks);
        request.setAttribute("selectedRating", ratingStr);
        request.getRequestDispatcher("feedbackreview.jsp").forward(request, response);
    }
}
