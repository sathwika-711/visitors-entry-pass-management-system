<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Model.LocationsModel" %>
<html>
<head>
    <title>Submit Feedback</title>
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
            font-size: 26px; /* Larger title text */
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

        form {
            width: 500px;
            margin: 30px auto;
            padding: 30px;
            border: 1px solid #ccc;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            font-weight: normal;
            color: #2c3e50;
            margin-bottom: 15px;
            margin-top: 40px; /* Added space above the heading */
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        textarea, select, input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #aaa;
            border-radius: 4px;
            font-size: 14px;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        }

        input[type="submit"] {
            margin-top: 20px;
            background-color: #1e3c72;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #2a5298;
        }

        .msg {
            text-align: center;
            color: #2e7d32;
            font-weight: bold;
            margin-top: 20px;
        }

        .error {
            text-align: center;
            color: #c0392b;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<!-- Navbar Start -->
<div class="navbar">
    <div class="left">
        Visitors Entry Pass Management System
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

<h2>Give Your Feedback</h2>
<form action="submitFeedback" method="post">

    <label for="location">Location:</label>
    <select name="locationId" id="location" required>
        <option value="">Select Location</option>
        <%
            List<LocationsModel> locations = (List<LocationsModel>) request.getAttribute("locations");
            if (locations != null) {
                for (LocationsModel loc : locations) {
        %>
        <option value="<%= loc.getLocationId() %>"><%= loc.getLocationName() %></option>
        <%  }
            }
        %>
    </select>

    <label for="description">Description:</label>
    <textarea name="description" id="description" rows="5" required></textarea>

    <label for="rating">Rating:</label>
    <select name="rating" id="rating" required>
        <option value="" disabled selected>Select Rating</option>
        <optgroup label="Low">
            <option value="1">1 - Poor</option>
            <option value="2">2 - Fair</option>
        </optgroup>
        <optgroup label="Medium">
            <option value="3">3 - Average</option>
            <option value="4">4 - Good</option>
        </optgroup>
        <optgroup label="High">
            <option value="5">5 - Excellent</option>
        </optgroup>
    </select>

    <input type="submit" value="Submit Feedback" />
</form>

<%
    String status = request.getParameter("status");
    if ("success".equals(status)) {
%>
    <p class="msg">Thank you! Your feedback has been submitted.</p>
<% } else if ("error".equals(status) || "fail".equals(status)) { %>
    <p class="error">Something went wrong. Please try again.</p>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
