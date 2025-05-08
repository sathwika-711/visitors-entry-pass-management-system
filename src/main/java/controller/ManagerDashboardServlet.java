package controller;

import Model.Booking;
import Model.Manager;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

import DAO.BookingsDAO;

@WebServlet("/ManagerDashboardServlet")
public class ManagerDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Manager manager = (Manager) session.getAttribute("manager");

        if (manager == null) {
            System.out.println("No manager found in session. Redirecting to login.");
            response.sendRedirect("manager_login.jsp");
            return;
        }

        int locationId = manager.getLocationId();
        System.out.println("Manager logged in: " + manager.getName());
        System.out.println("Manager ID: " + manager.getManagerId());
        System.out.println("Manager Location ID: " + locationId);

        BookingsDAO bookingsDAO = new BookingsDAO();
        try {
            int todayCount = bookingsDAO.getTodayVisitorCount(locationId);
            int monthlyCount = bookingsDAO.getMonthlyVisitorCount(locationId);
            double todayRevenue = bookingsDAO.getTodaysRevenue(locationId);
            double monthlyRevenue = bookingsDAO.getMonthlyRevenue(locationId);

            System.out.println("Today's Visitor Count: " + todayCount);
            System.out.println("Monthly Visitor Count: " + monthlyCount);
            System.out.println("Today's Revenue: ₹" + todayRevenue);
            System.out.println("Monthly Revenue: ₹" + monthlyRevenue);

            // Set all data as request attributes
            request.setAttribute("todayVisitorCount", todayCount);
            request.setAttribute("monthlyVisitorCount", monthlyCount);
            request.setAttribute("todayRevenue", todayRevenue);
            request.setAttribute("monthlyRevenue", monthlyRevenue);

            System.out.println("Forwarding to manager_dashboard.jsp");
            RequestDispatcher dispatcher = request.getRequestDispatcher("manager_dashboard.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            System.out.println("Error occurred while fetching dashboard data.");
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
