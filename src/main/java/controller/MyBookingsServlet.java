package controller;

import DAO.BookingsDAO;
import Model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/MyBookingsServlet")
public class MyBookingsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        BookingsDAO dao = new BookingsDAO();
        List<Map<String, Object>> bookings = dao.getBookingsByUserId(user.getUserId());

        request.setAttribute("bookings", bookings);

        // Forward to JSP
        request.getRequestDispatcher("bookings.jsp").forward(request, response);
    }
}
