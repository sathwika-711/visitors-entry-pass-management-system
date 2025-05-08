package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import DAO.BookingsDAO; // Import the BookingsDAO class

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the booking ID from the request
        int bookingId = Integer.parseInt(request.getParameter("booking_id"));

        // Call the DAO method to cancel the booking
        BookingsDAO dao = new BookingsDAO();
        boolean result = dao.cancelBooking(bookingId);

        // Redirect based on the result of cancellation
        if (result) {
            // If cancellation is successful, redirect to the bookings page with success status
            response.sendRedirect("MyBookingsServlet?status=cancelled");
        } else {
            // If cancellation failed, redirect with error status
            response.sendRedirect("bookings.jsp?status=error");
        }
    }
}
