<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.UserModel" %>
<%
    String userId = request.getParameter("userId");
    UserModel user = (UserModel) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f4f8;
            margin: 0;
            padding: 0;
        }


        /* Navbar Styling */
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

        .container {
            width: 500px;
            margin: 60px auto;
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-top: 15px;
            font-weight: bold;
        }

        input, select {
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 25px;
            gap: 20px;
        }

        .button-link, .submit-button {
            flex: 1;
            padding: 12px;
            font-size: 16px;
            border-radius: 6px;
            text-decoration: none;
            color: white;
            border: none;
            cursor: pointer;
            text-align: center;
        }

        .button-link {
            background-color: #f44336;
        }

        .button-link:hover {
            background-color: #d32f2f;
        }

        .submit-button {
            background-color: #2196F3;
        }

        .submit-button:hover {
            background-color: #1976D2;
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
    <h2>Edit Profile</h2>
    <form action="profile" method="post">
        <input type="hidden" name="userId" value="<%= userId %>">

        <label for="name">Name:</label>
        <input type="text" name="name" id="name" value="<%= user != null ? user.getName() : "" %>" required>

        <label for="email">Email:</label>
        <input type="email" name="email" id="email" value="<%= user != null ? user.getEmail() : "" %>" required>

        <label for="mobile">Mobile:</label>
        <input type="text" name="mobile" id="mobile" value="<%= user != null ? user.getMobile() : "" %>" required>

        <label for="address">Address:</label>
        <input type="text" name="address" id="address" value="<%= user != null ? user.getAddress() : "" %>" required>

        <label for="gender">Gender:</label>
        <select name="gender" id="gender" required>
            <option value="Male" <%= user != null && "Male".equals(user.getGender()) ? "selected" : "" %>>Male</option>
            <option value="Female" <%= user != null && "Female".equals(user.getGender()) ? "selected" : "" %>>Female</option>
            <option value="Other" <%= user != null && "Other".equals(user.getGender()) ? "selected" : "" %>>Other</option>
        </select>

        <div class="button-group">
            <a href="profile" class="button-link">Cancel</a>
            <button type="submit" class="submit-button">Update</button>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
