package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import DAO.DBConnection;
import DAO.ReportDAO;
import Model.LocationReport;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/generateReports")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // GET: Display visitor and revenue report
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String period = request.getParameter("period");
        if (period == null || period.isEmpty()) {
            period = "daily";
        }

        try {
            Connection conn = DBConnection.getConnection();
            ReportDAO dao = new ReportDAO(conn);

            int totalManagers = dao.getTotalManagers();
            int totalLocations = dao.getTotalLocations();
            int totalVisitors = dao.getTotalVisitors(period);
            double totalRevenue = dao.getTotalRevenue(period);
            List<LocationReport> locationReports = dao.getLocationReport(period);

            request.setAttribute("period", period);
            request.setAttribute("totalManagers", totalManagers);
            request.setAttribute("totalLocations", totalLocations);
            request.setAttribute("totalVisitors", totalVisitors);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("locationReports", locationReports);

            request.getRequestDispatcher("reports.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // Optional: Handle POST if you want form submissions too
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
