package controller;

import DAO.BookingsDAO;
import DAO.LocationsDAO;
import Model.BookingsModel;
import Model.LocationsModel;
import Model.UserModel;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Properties;

@WebServlet("/paymentServlet")
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserModel user = (UserModel) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        BookingsDAO bookingsDAO = new BookingsDAO();
        BookingsModel booking = bookingsDAO.getLatestBookingByUserId(user.getUserId());

        if (booking != null) {
            LocationsDAO locDAO = new LocationsDAO();
            LocationsModel location = locDAO.getLocationById(booking.getLocationId());

            request.setAttribute("email", user.getEmail());
            request.setAttribute("locationName", location.getLocationName());
            request.setAttribute("totalPasses", booking.getNumberOfAdults() + booking.getNumberOfChildren());
            request.setAttribute("totalPrice", booking.getTotalPrice());
            request.setAttribute("bookingId", booking.getBookingId());

            request.getRequestDispatcher("payment.jsp").forward(request, response);
        } else {
            response.sendRedirect("bookings.jsp?status=notfound");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        BookingsDAO dao = new BookingsDAO();

        boolean updated = dao.updateBookingStatus(bookingId, "confirmed");

        if (updated) {
            request.setAttribute("message", "Payment Successful!");
            request.getRequestDispatcher("payment_success.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Payment Failed. Try again.");
            request.getRequestDispatcher("payment.jsp").forward(request, response);
        }
    }

    private void sendStatusUpdateEmail(String toEmail, int bookingId, String newStatus) {
        final String username = "arjunsarkarc@gmail.com"; // Replace with your Gmail
        final String password = "gbog fkim hozj zsqh"; // Your app password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Booking Status Update - Booking ID: " + bookingId);

            String emailContent = "Dear Visitor,\n\n" +
                    "Your booking status has been updated.\n\n" +
                    "Booking ID: " + bookingId + "\n" +
                    "New Status: " + newStatus + "\n\n" +
                    "Thank you for using our service.\n\n" +
                    "Best regards,\n" +
                    "Visitor Pass Management System";

            message.setText(emailContent);

            Transport.send(message);
            System.out.println("Email sent successfully to " + toEmail);

        } catch (MessagingException e) {
            System.err.println("Error sending email: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
