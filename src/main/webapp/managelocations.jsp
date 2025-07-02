<%@ page import="java.util.*, Model.LocationsModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Locations</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            padding: 0;
        }

        /* NAVBAR STYLES */
        .navbar {
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 25px 40px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            min-height: 80px;
        }

        .navbar .left {
            font-size: 24px;
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
            font-size: 16px;
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

        h1 {
            text-align: center;
            margin: 30px 0 20px;
            font-size: 26px;
            color: #333;
        }

        .header-container {
            width: 90%;
            margin: 0 auto 15px;
        }

        .header-actions {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 10px;
        }

        .add-button {
            background-color: #28a745;
            color: white;
            padding: 8px 14px;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: bold;
        }

        .add-button:hover {
            background-color: #218838;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
            font-size: 14px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
        }

        th, td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #343a40;
            color: #ffffff;
            font-weight: normal;
        }

        tr:hover {
            background-color: #f2f2f2;
        }

        .action-buttons a {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 4px;
            font-weight: bold;
            font-size: 14px;
            text-decoration: none;
            margin-right: 10px;
        }

        .edit {
            background-color: #007bff;
            color: #fff;
        }

        .edit:hover {
            background-color: #0056b3;
        }

        .delete {
            background-color: #dc3545;
            color: #fff;
        }

        .delete:hover {
            background-color: #c82333;
        }

        .center-text {
            text-align: center;
        }

        @media (max-width: 600px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }

            .navbar .right {
                flex-direction: column;
                gap: 10px;
                width: 100%;
            }

            table {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="left">
        <i class="fas fa-ticket-alt"></i> Visitors Entry Pass Management System
    </div>
    <div class="right">
        <a href="adminhome.jsp">Home</a>
        <a href="manageManagers?locationId=1">Manage Managers</a>
        <a href="manageLocations">Manage Locations</a>
        <a href="generateReports">Report & Analytics</a>
        <a href="viewFeedbacks">View Feedback</a>
        <a href="LogoutServlet?role=admin" class="logout">Logout</a>
    </div>
</div>

<!-- PAGE HEADING -->
<h1>Manage Locations</h1>

<!-- ADD BUTTON + LOCATIONS TABLE CONTAINER -->
<div class="header-container">
    <div class="header-actions">
        <a href="manageLocations?action=add" class="add-button">Add New Location</a>
    </div>

    <!-- LOCATIONS TABLE -->
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Location Name</th>
                <th>Adult Price</th>
                <th>Child Price</th>
                <th>Timings</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            List<LocationsModel> locations = (List<LocationsModel>) request.getAttribute("locations");
            if (locations != null && !locations.isEmpty()) {
                for (LocationsModel loc : locations) {
        %>
            <tr>
                <td><%= loc.getLocationId() %></td>
                <td><%= loc.getLocationName() %></td>
                <td>₹ <%= loc.getAdultPassPrice() %></td>
                <td><%= loc.getChildPassPrice() != null ? "₹ " + loc.getChildPassPrice() : "N/A" %></td>
                <td><%= loc.getTimings() %></td>
                <td class="action-buttons">
                    <a href="manageLocations?action=edit&id=<%= loc.getLocationId() %>" class="edit">Edit</a>
                    <a href="manageLocations?action=delete&id=<%= loc.getLocationId() %>"
                       class="delete"
                       onclick="return confirm('Are you sure you want to delete this location?');">Delete</a>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="6" class="center-text">No locations found.</td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>
