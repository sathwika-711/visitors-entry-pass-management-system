package controller;

import DAO.BookingsDAO;
import Model.BookingsModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.UUID;

@WebServlet("/downloadPassImagebyID")
public class downloadPassbyId extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userID") == null) {
                response.sendRedirect("login.jsp?status=sessionExpired");
                return;
            }

            int userId = (Integer) session.getAttribute("userID");
            int bookingId = Integer.parseInt(request.getParameter("booking_id"));

            BookingsDAO dao = new BookingsDAO();
            BookingsModel booking = dao.getBookingById(bookingId);

            if (booking == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Booking not found");
                return;
            }

            if (booking.getUserId() != userId) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Unauthorized access");
                return;
            }

            // Format date
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            String formattedDate = sdf.format(booking.getVisitDate());

            // Create image canvas
            int width = 700, height = 500;
            BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            Graphics2D g = image.createGraphics();

            // Smooth rendering
            g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

            // Gradient background
            GradientPaint gradient = new GradientPaint(0, 0, new Color(200, 220, 255), width, height, Color.WHITE);
            g.setPaint(gradient);
            g.fillRect(0, 0, width, height);

            // Border
            g.setColor(Color.DARK_GRAY);
            g.setStroke(new BasicStroke(3));
            g.drawRect(10, 10, width - 20, height - 20);

            // Title
            g.setFont(new Font("SansSerif", Font.BOLD, 32));
            g.setColor(new Color(30, 60, 120));
            g.drawString("Visitor Entry Pass", 220, 60);

            // Text
            g.setFont(new Font("SansSerif", Font.PLAIN, 20));
            g.setColor(Color.BLACK);
            int x = 50, y = 120, lineSpacing = 40;

            g.drawString("Pass Number:", x, y);                g.drawString("PASS-" + booking.getBookingId() + "-" + UUID.randomUUID().toString().substring(0, 6).toUpperCase(), x + 170, y);
            g.drawString("Booking ID:", x, y += lineSpacing);  g.drawString(String.valueOf(booking.getBookingId()), x + 170, y);
            g.drawString("Visitor Name:", x, y += lineSpacing);g.drawString(booking.getVisitorName(), x + 170, y);
            g.drawString("Visit Date:", x, y += lineSpacing);  g.drawString(formattedDate, x + 170, y);
            g.drawString("Location:", x, y += lineSpacing);    g.drawString(booking.getLocationName(), x + 170, y);
            g.drawString("Total Passes:", x, y += lineSpacing);g.drawString(String.valueOf(booking.getNumberOfAdults() + booking.getNumberOfChildren()), x + 170, y);
            g.drawString("Total Price:", x, y += lineSpacing); g.drawString("₹" + booking.getTotalPrice(), x + 170, y);

            // Extra space before payment status
            y += lineSpacing;
            g.setFont(new Font("SansSerif", Font.BOLD, 20));
            g.setColor(new Color(0, 102, 51));
            g.drawString("Payment Status: " + booking.getStatus().toUpperCase(), x, y + lineSpacing);

            g.dispose();

            // Set image download headers
            response.setContentType("image/png");
            response.setHeader("Content-Disposition", "attachment; filename=VisitorPass_" + booking.getBookingId() + ".png");

            ImageIO.write(image, "png", response.getOutputStream());

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating pass");
        }
    }
}
