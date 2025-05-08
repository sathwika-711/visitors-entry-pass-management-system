package controller;

import DAO.FeedbackDAO;
import DAO.LocationsDAO;
import Model.Feedback;
import Model.LocationsModel;
import Model.UserModel; // Assuming this is your user class

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/submitFeedback")
public class FeedbackServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LocationsDAO locDAO = new LocationsDAO();
        List<LocationsModel> locations = locDAO.getAllLocations();

        request.setAttribute("locations", locations);
        request.getRequestDispatcher("feedbackform.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?status=sessionExpired");
            return;
        }

        // Fetch user details from session
        UserModel user = (UserModel) session.getAttribute("user");
        String email = user.getEmail(); // get email from session
        int userId = user.getUserId();
        String description = request.getParameter("description");
        String ratingStr = request.getParameter("rating");
        String locationIdStr = request.getParameter("locationId");

        try {
            int rating = Integer.parseInt(ratingStr);
            int locationId = Integer.parseInt(locationIdStr);

            Feedback feedback = new Feedback();
//            feedback.setId(locationId);
            feedback.setEmail(email);
            feedback.setDescription(description);
            feedback.setRating(rating);
            feedback.setLocationId(locationId);

            FeedbackDAO feedbackDAO = new FeedbackDAO();
            boolean isSaved = feedbackDAO.saveFeedback(feedback, userId);

            if (isSaved) {
                response.sendRedirect("feedbackform.jsp?status=success");
            } else {
                response.sendRedirect("feedbackform.jsp?status=fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("submitFeedback?status=error");
        }
    }
}
