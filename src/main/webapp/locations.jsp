<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.LocationsModel" %>

<%
    List<LocationsModel> locations = (List<LocationsModel>) request.getAttribute("locations");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Locations</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/25/25694.png" type="image/png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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

        /* Enlarged Navbar */
        .navbar {
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 25px 40px; /* Increased padding */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            min-height: 80px; /* Increased height */
            margin-bottom: 20px; /* Added space below navbar */
        }

        .navbar .left {
            font-size: 24px; /* Larger title text */
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
            padding: 14px 20px; /* Larger clickable area */
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
            font-weight: 500;
            font-size: 18px; /* Increased text size */
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
        .map-btn {
            background-color: #28a745; /* Bootstrap success green */
            color: white;
            padding: 10px 18px;
            font-size: 16px;
            font-weight: 500;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.2s ease;
            display: inline-flex;
            align-items: center;
        }

        .map-btn i {
            margin-right: 8px;
        }

        .map-btn:hover {
            background-color: #218838;
            transform: scale(1.05);
            text-decoration: none;
            color: white;
        }

    </style>
</head>
<body class="bg-light">

<!-- Navbar Start -->
<div class="navbar">
    <div class="left">
        <i class="fas fa-ticket-alt"></i> Visitors Entry Pass Management System
    </div>
    <div class="right">
        <a href="visitorhome.jsp">Home</a>
        <a href="locations">Book Pass</a>
        <a href="MyBookingsServlet">My Bookings</a>
        <a href="submitFeedback">Give Feedback</a>
        <a href="profile">Profile</a>
        <a href="LogoutServlet" class="logout">Logout</a>
    </div>
</div>
<!-- Navbar End -->

<!-- Main Content -->
<div class="container mt-5">
    <div class="position-relative mb-4" style="height: 40px;">
        <h2 class="position-absolute top-50 start-50 translate-middle m-0">All Locations</h2>
        <a href="https://www.google.com/maps/" target="_blank" class="btn btn-success position-absolute end-0 top-50 translate-middle-y" style="min-width: 150px;">
            <i class="fas fa-map-marker-alt me-2"></i> View on Map
        </a>
    </div>



    <div class="row g-4">
        <%
            if (locations != null) {
                for (LocationsModel loc : locations) {
        %>
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm">
                <img src="<%= loc.getImageUrl() %>" class="card-img-top" alt="Location Image" style="height: 200px; object-fit: cover;">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><%= loc.getLocationName() %></h5>
                    <p class="card-text"><strong>Description:</strong> <%= loc.getDescription() %></p>
                    <p class="card-text"><strong>Timings:</strong> <%= loc.getTimings() %></p>
                    <a href="locationDetail?id=<%= loc.getLocationId() %>" class="btn btn-primary mt-auto">View Details</a>
                </div>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
