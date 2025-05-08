package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import Model.LocationsModel;
import DAO.LocationsDAO;

@WebServlet("/locationDetail")
public class LocationDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int locationId = Integer.parseInt(request.getParameter("id"));

            // Get location from DAO
            LocationsDAO dao = new LocationsDAO();
            LocationsModel location = dao.getLocationById(locationId);
            System.out.println(location);
            // Set attribute and forward
            request.setAttribute("location", location);
            request.getRequestDispatcher("locationDetail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // optional error page
        }
    }
}
