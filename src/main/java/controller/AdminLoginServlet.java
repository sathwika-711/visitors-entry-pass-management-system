package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import Model.AdminModel;
import DAO.AdminDAO;
import DAO.BookingsDAO;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Populate model
        AdminModel admin = new AdminModel(email, password);

        // Validate using DAO
        AdminDAO dao = new AdminDAO();
        boolean isValid = dao.validateAdmin(admin);

        if (isValid) {
            // Successful login: store session and fetch report data
            HttpSession session = request.getSession();
            session.setAttribute("adminEmail", email);
            
            try {
                // Fetch report data for different periods
                BookingsDAO bookingsDAO = new BookingsDAO();
                
                // Daily report
                List<Map<String, Object>> dailyReport = bookingsDAO.getVisitorRevenueReport("daily");
                System.out.println("Daily report data fetched: " + (dailyReport != null ? dailyReport.size() : 0) + " records");
                
                // Calculate totals for daily report
                int totalVisitors = 0;
                double totalRevenue = 0.0;
                int totalLocations = 0;
                
                if (dailyReport != null && !dailyReport.isEmpty()) {
                    totalLocations = dailyReport.size();
                    for (Map<String, Object> row : dailyReport) {
                        Object visitors = row.get("total_visitors");
                        Object revenue = row.get("total_revenue");
                        
                        if (visitors != null) {
                            totalVisitors += ((Number) visitors).intValue();
                        }
                        if (revenue != null) {
                            totalRevenue += ((Number) revenue).doubleValue();
                        }
                    }
                }
                
                System.out.println("Calculated totals - Locations: " + totalLocations + 
                                 ", Visitors: " + totalVisitors + 
                                 ", Revenue: " + totalRevenue);
                
                // Store all data in session
                session.setAttribute("reportData", dailyReport);
                session.setAttribute("period", "daily");
                session.setAttribute("totalVisitors", totalVisitors);
                session.setAttribute("totalRevenue", totalRevenue);
                session.setAttribute("totalLocations", totalLocations);
                
            } catch (Exception e) {
                System.err.println("Error fetching report data: " + e.getMessage());
                e.printStackTrace();
                // Initialize default values if report data fetch fails
                session.setAttribute("reportData", null);
                session.setAttribute("period", "daily");
                session.setAttribute("totalVisitors", 0);
                session.setAttribute("totalRevenue", 0.0);
                session.setAttribute("totalLocations", 0);
            }
            
            response.sendRedirect("adminlogin.jsp?status=success");
        } else {
            // Failed login: redirect with error
            response.sendRedirect("adminlogin.jsp?status=fail");
        }
    }
}
