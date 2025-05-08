package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

import DAO.ManagerDao;
import Model.Manager;

@WebServlet("/manageManagers")
public class ManageManagerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ManagerDao dao = new ManagerDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equalsIgnoreCase(action)) {
                request.getRequestDispatcher("add_delete_manager.jsp").forward(request, response);

            } else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteManager(id);
                response.sendRedirect("manageManagers?status=deleted");

            } else {
                List<Manager> managers = dao.getAllManagers();
                request.setAttribute("managers", managers);
                request.getRequestDispatcher("manage_managers.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Manager manager = new Manager();
            manager.setName(request.getParameter("name"));
            manager.setEmail(request.getParameter("email"));
            manager.setPassword(request.getParameter("password"));
            manager.setLocationId(Integer.parseInt(request.getParameter("locationId")));

            dao.insertManager(manager);
            response.sendRedirect("manageManagers?status=added");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

