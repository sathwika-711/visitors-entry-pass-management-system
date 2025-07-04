<%@ page import="Model.LocationsModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    LocationsModel loc = (LocationsModel) request.getAttribute("location");
    boolean isEdit = loc != null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= isEdit ? "Edit" : "Add" %> Location</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

        /* Navbar Styles (copied from Admin Home) */
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

        .form-container {
            width: 500px;
            margin: 40px auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            height: 100px;
        }

        .button-group {
            margin-top: 25px;
            text-align: center;
        }

        button {
            background-color: #007bff;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            margin-right: 10px;
        }

        button:hover {
            background-color: #0056b3;
        }

        .cancel-button {
            background-color: #6c757d;
        }

        .cancel-button:hover {
            background-color: #5a6268;
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
                padding: 20px;
            }

            .navbar .right {
                flex-direction: column;
                width: 100%;
                gap: 10px;
            }

            .form-container {
                width: 90%;
            }
        }
    </style>
</head>
<body>

<!-- Admin Navbar -->
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

<!-- Add/Edit Location Form -->
<div class="form-container">
    <h2><%= isEdit ? "Edit" : "Add" %> Location</h2>
    <form action="manageLocations" method="post">
        <% if (isEdit) { %>
        <input type="hidden" name="locationId" value="<%= loc.getLocationId() %>">
        <% } %>

        <label for="locationName">Location Name:</label>
        <input type="text" name="locationName" id="locationName" required
               value="<%= isEdit ? loc.getLocationName() : "" %>">

        <label for="adultPassPrice">Adult Pass Price:</label>
        <input type="number" name="adultPassPrice" id="adultPassPrice" step="0.01" required
               value="<%= isEdit ? loc.getAdultPassPrice() : "" %>">

        <label for="childPassPrice">Child Pass Price:</label>
        <input type="number" name="childPassPrice" id="childPassPrice" step="0.01"
               value="<%= isEdit && loc.getChildPassPrice() != null ? loc.getChildPassPrice() : "" %>">

        <label for="description">Description:</label>
        <textarea name="description" id="description"><%= isEdit ? loc.getDescription() : "" %></textarea>

        <label for="timings">Timings:</label>
        <input type="text" name="timings" id="timings" required
               value="<%= isEdit ? loc.getTimings() : "" %>">

        <label for="imageUrl">Image URL:</label>
        <input type="text" name="imageUrl" id="imageUrl"
               value="<%= isEdit ? loc.getImageUrl() : "" %>">

        <label for="pincode">Pincode:</label>
        <input type="text" name="pincode" id="pincode" maxlength="10"
               value="<%= isEdit ? loc.getPincode() : "" %>">

        <div class="button-group">
            <button type="submit"><%= isEdit ? "Edit" : "Add" %> Location</button>
            <a href="manageLocations"><button type="button" class="cancel-button">Cancel</button></a>
        </div>
    </form>
</div>

</body>
</html>
