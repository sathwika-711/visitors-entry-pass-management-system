<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.LocationsModel" %>
<%@ page import="jakarta.servlet.*, jakarta.servlet.http.*, java.io.*, java.util.*" %>

<%
    LocationsModel location = (LocationsModel) request.getAttribute("location");
    if (location == null) {
        location = new LocationsModel(); 
        location.setLocationName("Unknown");
        location.setDescription("Location not found.");
    }

    int locationId = location.getLocationId();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Location Details</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/25/25694.png" type="image/png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            color: #333;
        }

        .navbar {
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 25px 40px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            min-height: 80px;
            margin-bottom: 20px;
        }

        .navbar .left {
            font-size: 26px;
            font-weight: bold;
            color: white;
        }

        .navbar .right {
            display: flex;
            gap: 18px;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 14px 20px;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
            font-weight: 500;
            font-size: 18px;
        }

        .navbar a:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .navbar .logout {
            background-color: #e74c3c;
            font-weight: bold;
        }

        .navbar .logout:hover {
            background-color: #c0392b;
        }
    </style>
    <script>
        // Set the current date as the minimum value for the Visit Date field
        window.onload = function() {
            const today = new Date();
            const formattedDate = today.toISOString().split('T')[0]; // Get current date in YYYY-MM-DD format
            document.querySelector('input[name="visit_date"]').setAttribute('min', formattedDate);
        };
    </script>

</head>
<body class="bg-light">

<!-- Custom Navbar -->
<div class="navbar">
    <div class="left">
        Visitors Entry Pass Management System
    </div>
    <div class="right">
        <a href="visitorhome.jsp">Home</a>
        <a href="locations">Book Pass</a>
        <a href="MyBookingsServlet">My Bookings</a>
        <a href="feedbackform.jsp">Give Feedback</a>
        <a href="profile">Profile</a>
        <a href="LogoutServlet" class="logout">Logout</a>
    </div>
</div>

<!-- Page Content -->
<div class="container mt-5">
    <div class="card mx-auto shadow" style="max-width: 800px;">
        <img src="<%= location.getImageUrl() %>" class="card-img-top" alt="Location Image" style="height: 300px; object-fit: cover;">
        <div class="card-body">
            <h3 class="card-title mb-3"><%= location.getLocationName() %></h3>
            <p class="card-text"><strong>Description:</strong> <%= location.getDescription() %></p>
            <ul class="list-group list-group-flush mb-3">
                <li class="list-group-item"><strong>Adult Price:</strong> ₹<%= location.getAdultPassPrice() %></li>
                <li class="list-group-item"><strong>Child Price:</strong> <%= location.getChildPassPrice() != null ? "₹" + location.getChildPassPrice() : "N/A" %></li>
                <li class="list-group-item"><strong>Timings:</strong> <%= location.getTimings() %></li>
                <li class="list-group-item"><strong>Pincode:</strong> <%= location.getPincode() %></li>
            </ul>
            <a href="locations" class="btn btn-secondary">Back to All Locations</a>
            <button class="btn btn-success ms-2" data-bs-toggle="modal" data-bs-target="#bookModal">Book Pass</button>
        </div>
    </div>
</div>

<!-- Booking Modal -->
<div class="modal fade" id="bookModal" tabindex="-1" aria-labelledby="bookModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form action="BookPassServlet" method="post" class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title">Book Pass for <%= location.getLocationName() %></h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
            <input type="hidden" name="location_id" value="<%= locationId %>">
            <div class="mb-3">
                <label>No. of Adults</label>
                <input type="number" name="adults" class="form-control" min="1" required>
            </div>
            <div class="mb-3">
                <label>No. of Children</label>
                <input type="number" name="children" class="form-control" min="0" required>
            </div>
            <div class="mb-3">
                <label>Visit Date</label>
                <input type="date" name="visit_date" class="form-control" required>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-primary" type="submit">Book Now</button>
        </div>
    </form action="BookPassServlet">
  </div>
</div>

<!-- Bootstrap Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
