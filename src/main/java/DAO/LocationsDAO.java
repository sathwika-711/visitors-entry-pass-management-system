package DAO;

import Model.LocationsModel;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class LocationsDAO {

    private static final Log log = LogFactory.getLog(LocationsDAO.class);


    // Fetch all locations
    public List<LocationsModel> getAllLocations() {
        List<LocationsModel> locations = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM locations";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                LocationsModel location = new LocationsModel();
                location.setLocationId(rs.getInt("location_id"));
                location.setLocationName(rs.getString("location_name"));
                location.setAdultPassPrice(rs.getDouble("adult_pass_price"));

                Object childPrice = rs.getObject("child_pass_price");
                location.setChildPassPrice(childPrice != null ? rs.getDouble("child_pass_price") : null);

                location.setDescription(rs.getString("description"));
                location.setTimings(rs.getString("timings"));
                location.setImageUrl(rs.getString("image_url"));
                location.setPincode(rs.getString("pincode"));

                locations.add(location);
            }
        } catch (Exception e) {
            log.info("Error fetching locations: " + e.getMessage());
        }

        return locations;
    }

    // Get a single location by ID
    public LocationsModel getLocationById(int locationId) {
        LocationsModel location = null;

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM locations WHERE location_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, locationId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                location = new LocationsModel();
                location.setLocationId(rs.getInt("location_id"));
                location.setLocationName(rs.getString("location_name"));
                location.setAdultPassPrice(rs.getDouble("adult_pass_price"));

                Object childPrice = rs.getObject("child_pass_price");
                location.setChildPassPrice(childPrice != null ? rs.getDouble("child_pass_price") : null);

                location.setDescription(rs.getString("description"));
                location.setTimings(rs.getString("timings"));
                location.setImageUrl(rs.getString("image_url"));
                location.setPincode(rs.getString("pincode"));
            }

        } catch (Exception e) {
            log.info("Error fetching location by ID: " + e.getMessage());
        }

        return location;
    }


    // Insert a new location
    public boolean insertLocation(LocationsModel location) {
        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO locations (location_name, adult_pass_price, child_pass_price, description, timings, image_url, pincode) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, location.getLocationName());
            ps.setDouble(2, location.getAdultPassPrice());
            ps.setObject(3, location.getChildPassPrice());
            ps.setString(4, location.getDescription());
            ps.setString(5, location.getTimings());
            ps.setString(6, location.getImageUrl());
            ps.setString(7, location.getPincode());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            log.info("Error inserting location: " + e.getMessage());
            return false;
        }
    }

    // Update an existing location
    public boolean updateLocation(LocationsModel location) {
        try (Connection con = DBConnection.getConnection()) {
            String sql = "UPDATE locations SET location_name=?, adult_pass_price=?, child_pass_price=?, description=?, timings=?, image_url=?, pincode=? WHERE location_id=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, location.getLocationName());
            ps.setDouble(2, location.getAdultPassPrice());
            ps.setObject(3, location.getChildPassPrice());
            ps.setString(4, location.getDescription());
            ps.setString(5, location.getTimings());
            ps.setString(6, location.getImageUrl());
            ps.setString(7, location.getPincode());
            ps.setInt(8, location.getLocationId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            log.info("Error updating location: " + e.getMessage());
            return false;
        }
    }

    // Delete a location
    public boolean deleteLocation(int locationId) {
        try (Connection con = DBConnection.getConnection()) {
            String sql = "DELETE FROM locations WHERE location_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, locationId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            log.info("Error deleting location: " + e.getMessage());
            return false;
        }
    }

    //  Get location name by location_id
    public String getLocationNameById(int locationId) {
        String locationName = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT location_name FROM locations WHERE location_id = ?")) {

            ps.setInt(1, locationId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                locationName = rs.getString("location_name");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return locationName;
    }
}
