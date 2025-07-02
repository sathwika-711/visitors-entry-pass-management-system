<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.UserModel" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        /* Updated CSS for Edit Button Color */
        body {
            font-family: Arial, sans-serif;
            background: #f0f4f8;
            margin: 0;
            padding: 0;
        }

        /* Navbar Style */
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

        /* Profile Page Container */
        .container {
            width: 100%;
            max-width: 600px;
            padding: 40px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);

            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .info {
            margin: 15px 0;
            font-size: 16px;
            color: #555;
        }

        .info strong {
            display: inline-block;
            width: 120px;
            font-weight: 600;
            color: #333;
        }

        .info span {
            font-weight: 400;
            color: #777;
        }

        /* Edit Button Styling */
        .edit-button {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: #007bff; /* Changed to blue color */
            border: none;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 6px;
            margin-top: 25px;
            text-align: center;
            text-decoration: none;
        }

        .edit-button:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }

        p {
            font-size: 14px;
            text-align: center;
            color: red;
        }
    </style>
</head>
<body>

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

<div class="container">
    <h2>User Profile</h2>
    <%
        UserModel user = (UserModel) request.getAttribute("user");
        if (user != null) {
    %>
    <div class="info"><strong>Name:</strong> <span><%= user.getName() %></span></div>
    <div class="info"><strong>Email:</strong> <span><%= user.getEmail() %></span></div>
    <div class="info"><strong>Mobile:</strong> <span><%= user.getMobile() %></span></div>
    <div class="info"><strong>Address:</strong> <span><%= user.getAddress() %></span></div>
    <div class="info"><strong>Gender:</strong> <span><%= user.getGender() %></span></div>

    <form action="edit_profile.jsp" method="get">
        <input type="hidden" name="userId" value="<%= user.getUserId() %>">
        <button type="submit" class="edit-button">Edit Profile</button>
    </form>
    <% } else { %>
        <p>No user information available.</p>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
