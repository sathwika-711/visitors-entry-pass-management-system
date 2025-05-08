package controller;

import DAO.VisitorDao;
import Model.Manager;
import Model.Visitor;
import DAO.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/FutureVisitorsServlet")
public class FutureVisitorsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Manager manager = (Manager) session.getAttribute("manager");

        if (manager == null) {
            response.sendRedirect("manager_login.jsp");
            return;
        }

        VisitorDao dao = new VisitorDao(DBConnection.getConnection());
        List<Visitor> futureVisitors = dao.getFutureVisitors(manager.getLocationId());

        request.setAttribute("futureVisitors", futureVisitors);
        request.getRequestDispatcher("future_visitors.jsp").forward(request, response);
    }
}
