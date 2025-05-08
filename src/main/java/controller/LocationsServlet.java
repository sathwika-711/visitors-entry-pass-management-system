package controller;

import DAO.LocationsDAO;
import Model.LocationsModel;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.util.List;

@WebServlet("/locations")
public class LocationsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        LocationsDAO dao = new LocationsDAO();
        List<LocationsModel> locationList = dao.getAllLocations();

        request.setAttribute("locations", locationList);
        RequestDispatcher rd = request.getRequestDispatcher("locations.jsp"); // Change to your JSP filename
        rd.forward(request, response);
    }
}

