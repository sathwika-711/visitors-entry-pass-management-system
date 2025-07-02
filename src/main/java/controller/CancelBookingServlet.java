package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;

import DAO.BookingsDAO;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Retrieve the booking ID from the request
            int bookingId = Integer.parseInt(request.getParameter("bookings_id"));

            // Call the DAO
            BookingsDAO dao = new BookingsDAO();

            // Cancel booking and get visit date & price
            boolean result = dao.cancelBooking(bookingId);
            double totalPrice = dao.getTotalPrice(bookingId);
            LocalDate visitDate = dao.getVisitDate(bookingId);
            LocalDate today = LocalDate.now();

            // Calculate refund
            double refundAmount = 0;
            boolean noRefund = visitDate != null && visitDate.isEqual(today);
            if (!noRefund) {
                refundAmount = totalPrice * 0.90;
            }

            // Set refund info in session
            HttpSession session = request.getSession();
            session.setAttribute("refundSuccess", result);
            session.setAttribute("totalPrice", totalPrice);
            session.setAttribute("refundAmount", refundAmount);
            session.setAttribute("noRefund", noRefund);

            // Redirect
            if (result) {
                response.sendRedirect("MyBookingsServlet?status=cancelled");
            } else {
                response.sendRedirect("bookings.jsp?status=error");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid booking ID format.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
