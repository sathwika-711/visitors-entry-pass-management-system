package controller;

import DAO.DBConnection;
import DAO.VisitorDao;
import Model.BookingsModel;
import Model.UserModel;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.io.IOException;
import java.sql.Connection;
import java.util.Properties;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/updateStatus")
public class UpdateVisitorStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String newStatus = request.getParameter("newStatus");

        Connection con = DBConnection.getConnection();
        VisitorDao dao = new VisitorDao(con);

        // Get booking details to send email
        BookingsModel booking = dao.getBookingById(bookingId);
        UserModel user = dao.getUserById(booking.getUserId());

        boolean success = dao.updateVisitorStatus(bookingId, newStatus);

        HttpSession session = request.getSession();
        if (success) {
            session.setAttribute("msg", "Status updated successfully.");
            // Send email notification
            sendStatusUpdateEmail(user.getEmail(), bookingId, newStatus);
        } else {
            session.setAttribute("msg", "Status update failed.");
        }

        response.sendRedirect("view_visitors.jsp");
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
