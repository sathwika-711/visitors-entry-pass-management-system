package controller;

import DAO.BookingsDAO;
import DAO.LocationsDAO;
import Model.BookingsModel;
import Model.LocationsModel;
import Model.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/BookPassServlet")
public class BookPassServlet extends HttpServlet {

    private static final Log log = LogFactory.getLog(BookPassServlet.class);

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserModel user = (UserModel) session.getAttribute("user");

        if (user == null) {
            log.info("User not logged in. Redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        log.info("Request received in BookPassServlet");
        log.info("User ID: " + user);

        try {
            int locationId = Integer.parseInt(request.getParameter("location_id"));
            int adults = Integer.parseInt(request.getParameter("adults"));
            int children = Integer.parseInt(request.getParameter("children"));
            Date visitDate = Date.valueOf(request.getParameter("visit_date"));

            log.info("Location ID: " + locationId);
            log.info("No. of Adults: " + adults);
            log.info("No. of Children: " + children);
            log.info("Visit Date: " + visitDate);

            LocationsDAO locationDAO = new LocationsDAO();
            LocationsModel location = locationDAO.getLocationById(locationId);

            log.info("Location Name: " + location.getLocationName());
            log.info("Adult Pass Price: " + location.getAdultPassPrice());
            log.info("Child Pass Price: " + location.getChildPassPrice());

            double total = (adults * location.getAdultPassPrice()) +
                    (children * location.getChildPassPrice());

            log.info("Total Price: " + total);

            BookingsModel booking = new BookingsModel();
            booking.setUserId(user.getUserId());
            booking.setLocationId(locationId);
            booking.setNumberOfAdults(adults);
            booking.setNumberOfChildren(children);
            booking.setTotalPrice(total);
            booking.setVisitDate(visitDate);
            booking.setStatus("pending");

            BookingsDAO dao = new BookingsDAO();
            boolean success = dao.addBooking(booking);

            log.info("Booking Status: " + (success ? "Success" : "Failure"));

            if (success) {
                session.setAttribute("message", "Booking successful!");
            } else {
                session.setAttribute("message", "Booking failed. Please try again.");
            }

            response.sendRedirect("paymentServlet?status=" + (success ? "success" : "fail"));

        } catch (Exception e) {
            log.info("Exception occurred: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("locationDetail.jsp?status=error");
        }
    }
}