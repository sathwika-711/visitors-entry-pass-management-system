package controller;

import DAO.DBConnection;
import Model.Booking;
import Model.Manager;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

import DAO.BookingsDAO;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

@WebServlet("/ManagerDashboardServlet")
public class ManagerDashboardServlet extends HttpServlet {

    private static final Log log = LogFactory.getLog(ManagerDashboardServlet.class);


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Manager manager = (Manager) session.getAttribute("manager");

        if (manager == null) {
            log.info("No manager found in session. Redirecting to login.");
            response.sendRedirect("manager_login.jsp");
            return;
        }

        int locationId = manager.getLocationId();
        log.info("Manager logged in: " + manager.getName());
        log.info("Manager ID: " + manager.getManagerId());
        log.info("Manager Location ID: " + locationId);

        BookingsDAO bookingsDAO = new BookingsDAO();
        try {
            int todayCount = bookingsDAO.getTodayVisitorCount(locationId);
            int monthlyCount = bookingsDAO.getMonthlyVisitorCount(locationId);
            double todayRevenue = bookingsDAO.getTodaysRevenue(locationId);
            double monthlyRevenue = bookingsDAO.getMonthlyRevenue(locationId);

            log.info("Today's Visitor Count: " + todayCount);
            log.info("Monthly Visitor Count: " + monthlyCount);
            log.info("Today's Revenue: ₹" + todayRevenue);
            log.info("Monthly Revenue: ₹" + monthlyRevenue);

            // Set all data as request attributes
            request.setAttribute("todayVisitorCount", todayCount);
            request.setAttribute("monthlyVisitorCount", monthlyCount);
            request.setAttribute("todayRevenue", todayRevenue);
            request.setAttribute("monthlyRevenue", monthlyRevenue);

            log.info("Forwarding to manager_dashboard.jsp");
            RequestDispatcher dispatcher = request.getRequestDispatcher("manager_dashboard.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            log.info("Error occurred while fetching dashboard data.");
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
