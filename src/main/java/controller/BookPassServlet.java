package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

import DAO.BookingsDAO;
import DAO.LocationsDAO;
import Model.BookingsModel;
import Model.LocationsModel;
import Model.UserModel;

@WebServlet("/BookPassServlet")
public class BookPassServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserModel user = (UserModel) session.getAttribute("user");

        if (user == null) {
            System.out.println("User not logged in. Redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        System.out.println("Request received in BookPassServlet");
        System.out.println("User ID: " + user);

        try {
            int locationId = Integer.parseInt(request.getParameter("location_id"));
            int adults = Integer.parseInt(request.getParameter("adults"));
            int children = Integer.parseInt(request.getParameter("children"));
            Date visitDate = Date.valueOf(request.getParameter("visit_date"));

            System.out.println("Location ID: " + locationId);
            System.out.println("No. of Adults: " + adults);
            System.out.println("No. of Children: " + children);
            System.out.println("Visit Date: " + visitDate);

            LocationsDAO locationDAO = new LocationsDAO();
            LocationsModel location = locationDAO.getLocationById(locationId);

            System.out.println("Location Name: " + location.getLocationName());
            System.out.println("Adult Pass Price: " + location.getAdultPassPrice());
            System.out.println("Child Pass Price: " + location.getChildPassPrice());

            double total = (adults * location.getAdultPassPrice()) +
                           (children * location.getChildPassPrice());

            System.out.println("Total Price: " + total);

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

            System.out.println("Booking Status: " + (success ? "Success" : "Failure"));

            if (success) {
                session.setAttribute("message", "Booking successful!");
            } else {
                session.setAttribute("message", "Booking failed. Please try again.");
            }

            response.sendRedirect("paymentServlet?status=" + (success ? "success" : "fail"));

        } catch (Exception e) {
            System.out.println("Exception occurred: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("locationDetail.jsp?status=error");
        }
    }
}
