package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

import Model.LocationsModel;
import DAO.LocationsDAO;

@WebServlet("/manageLocations")
public class ManageLocationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String action = request.getParameter("action");
        LocationsDAO dao = new LocationsDAO();

        try {
            if ("edit".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                LocationsModel location = dao.getLocationById(id);
                request.setAttribute("location", location);
                request.getRequestDispatcher("add_edit_locations.jsp").forward(request, response);

            } else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteLocation(id);
                response.sendRedirect("manageLocations?status=success");

            } else if ("add".equalsIgnoreCase(action)) {
                request.getRequestDispatcher("add_edit_locations.jsp").forward(request, response);

            } else {
                List<LocationsModel> locations = dao.getAllLocations();
                request.setAttribute("locations", locations);
                request.getRequestDispatcher("managelocations.jsp?status=success").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        LocationsDAO dao = new LocationsDAO();

        try {
            String idParam = request.getParameter("locationId");

            LocationsModel loc = new LocationsModel();
            loc.setLocationName(request.getParameter("locationName"));
            loc.setAdultPassPrice(Double.parseDouble(request.getParameter("adultPassPrice")));

            String childPrice = request.getParameter("childPassPrice");
            loc.setChildPassPrice((childPrice == null || childPrice.isEmpty()) ? null : Double.parseDouble(childPrice));

            loc.setDescription(request.getParameter("description"));
            loc.setTimings(request.getParameter("timings"));
            loc.setImageUrl(request.getParameter("imageUrl"));
            loc.setPincode(request.getParameter("pincode"));

            if (idParam == null || idParam.isEmpty()) {
                dao.insertLocation(loc);
            } else {
                loc.setLocationId(Integer.parseInt(idParam));
                dao.updateLocation(loc);
            }

            response.sendRedirect("manageLocations?status=success");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
