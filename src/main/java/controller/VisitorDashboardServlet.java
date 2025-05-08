package controller;

import DAO.DBConnection;
import DAO.VisitorDao;
import Model.Manager;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;

@WebServlet("/VisitorDashboardServlet")
public class VisitorDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection con = DBConnection.getConnection();
        VisitorDao dao = new VisitorDao(con);

        LocalDate today = LocalDate.now();
        LocalDate yesterday = today.minusDays(1);
        LocalDate tomorrow = today.plusDays(1);
        LocalDate dayAfterTomorrow = today.plusDays(2);

        HttpSession session = request.getSession(false);
        Manager manager = (Manager) session.getAttribute("manager");

        if (manager != null) {
            int locationId = manager.getLocationId();
            request.setAttribute("yesterday", dao.getVisitorsByDate(yesterday, locationId));
            request.setAttribute("today", dao.getVisitorsByDate(today, locationId));
            request.setAttribute("tomorrow", dao.getVisitorsByDate(tomorrow, locationId));
            request.setAttribute("dayAfterTomorrow", dao.getVisitorsByDate(dayAfterTomorrow, locationId));

            RequestDispatcher rd = request.getRequestDispatcher("view_visitors.jsp");
            rd.forward(request, response);
        } else {
            response.sendRedirect("manager_login.jsp");
        }
    }
}
