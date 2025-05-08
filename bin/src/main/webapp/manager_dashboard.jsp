<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.Manager, Model.Booking, java.util.List" %>
<%@ page session="true" %>
<%
    Manager manager = (Manager) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect("manager_login.jsp");
        return;
    }

    List<Booking> todaysBookings = (List<Booking>) request.getAttribute("todaysBookings");
    Integer todayVisitorCount = (Integer) request.getAttribute("todayVisitorCount");
    Integer monthlyVisitorCount = (Integer) request.getAttribute("monthlyVisitorCount");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manager Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 20px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h1 {
            color: #333;
            font-size: 32px;
        }

        .welcome-msg {
            font-size: 18px;
            margin-top: 10px;
            color: #666;
        }

        .location-info {
            font-size: 16px;
            margin-top: 5px;
            color: #444;
            font-style: italic;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            margin: 20px 10px 10px 0;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            transition: 0.3s;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .visitor-summary {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            margin: 20px 0;
        }

        .card {
            flex: 1;
            min-width: 200px;
            padding: 20px;
            background-color: #e9f5ff;
            border-left: 5px solid #007bff;
            border-radius: 8px;
            font-size: 16px;
            color: #333;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        h2 {
            margin-top: 30px;
            font-size: 24px;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        table th {
            background-color: #007bff;
            color: white;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        .status-pending { color: orange; font-weight: bold; }
        .status-confirmed { color: green; font-weight: bold; }
        .status-cancelled { color: red; font-weight: bold; }

        .action-btn {
            padding: 8px 16px;
            color: white;
            background-color: #28a745;
            text-decoration: none;
            border-radius: 5px;
            margin-right: 10px;
            transition: 0.3s;
        }

        .action-btn:hover {
            background-color: #218838;
        }

        .logout {
            display: inline-block;
            padding: 12px 24px;
            margin-top: 20px;
            color: white;
            background-color: #dc3545;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            transition: 0.3s;
        }

        .logout:hover {
            background-color: #c82333;
        }

        @media screen and (max-width: 768px) {
            .dashboard-container {
                padding: 20px;
            }

            .visitor-summary {
                flex-direction: column;
            }

            .btn, .logout {
                font-size: 14px;
                padding: 10px 20px;
            }

            table th, table td {
                font-size: 14px;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <h1>Manager Dashboard</h1>
    <div class="welcome-msg">Welcome, <strong><%= manager.getName() %></strong>!</div>
    <div class="location-info">Managing Location: <strong><%= manager.getLocationName() %></strong></div>

    <!-- Action Buttons -->
    <a href="VisitorDashboardServlet" class="btn">Manage Visitors</a>
    <a href="FutureVisitorsServlet" class="btn">Future Visitors</a>

    <!-- Visitor Stats -->
    <div class="visitor-summary">
        <div class="card">Today's Visitors: <%= (todayVisitorCount != null ? todayVisitorCount : 0) %></div>
        <div class="card">Monthly Visitors: <%= (monthlyVisitorCount != null ? monthlyVisitorCount : 0) %></div>
    </div>

    <!-- Booking Table -->
    <h2>Today's Bookings</h2>
    <table>
        <thead>
        <tr>
            <th>Booking ID</th>
            <th>Visitor Name</th>
            <th>Booking Date</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% 
            if (todaysBookings != null && !todaysBookings.isEmpty()) {
                for (Booking booking : todaysBookings) {
        %>
        <tr>
            <td><%= booking.getBookingId() %></td>
            <td><%= booking.getVisitorName() %></td>
            <td><%= booking.getVisitDate() %></td>
            <td>
                <% 
                    String status = booking.getStatus();
                    if ("pending".equalsIgnoreCase(status)) { %>
                        <span class="status-pending">Pending</span>
                <% } else if ("confirmed".equalsIgnoreCase(status)) { %>
                        <span class="status-confirmed">Confirmed</span>
                <% } else if ("cancelled".equalsIgnoreCase(status)) { %>
                        <span class="status-cancelled">Cancelled</span>
                <% } %>
            </td>
            <td>
                <a href="view_booking_details.jsp?id=<%= booking.getBookingId() %>" class="action-btn">View</a>
                <a href="confirm_booking.jsp?id=<%= booking.getBookingId() %>" class="action-btn">Confirm</a>
                <a href="cancel_booking.jsp?id=<%= booking.getBookingId() %>" class="action-btn">Cancel</a>
            </td>
        </tr>
        <% 
                }
            } else {
        %>
        <tr>
            <td colspan="5">No bookings for today.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <a href="LogoutServlet?role=manager" class="logout">Logout</a>
</div>
</body>
</html>
