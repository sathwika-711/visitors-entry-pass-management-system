<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.sql.Date" %>

<%
    // Declare LocalDate today only once
    LocalDate today = LocalDate.now();
    List<Map<String, Object>> bookings = (List<Map<String, Object>>) request.getAttribute("bookings");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
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

        /* Custom Style for the ticket cards */
        .ticket-card {
            border: 2px dashed #6c757d;
            border-radius: 12px;
            padding: 1.5rem;
            background-color: #f8f9fa;
            margin-bottom: 1.5rem;
        }

        .status-cancelled {
            background-color: #e74c3c;
            color: white;
        }
    </style>
</head>
<body class="bg-light">

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

<!-- Main Content Start -->
<div class="container py-5">
    <h2 class="text-center mb-4">🎟️ My Bookings</h2>

    <%
        if (bookings == null || bookings.isEmpty()) {
    %>
    <div class="alert alert-info text-center">No bookings found.</div>
    <%
    } else {
        for (Map<String, Object> booking : bookings) {
    %>
    <div class="ticket-card shadow-sm">
        <div class="row">
            <div class="col-md-8">
                <h5 class="fw-bold text-primary"><%= booking.get("location_name") %></h5>
                <p><strong>Visit Date:</strong> <%= booking.get("visit_date") %></p>
                <p><strong>Total Passes:</strong> <%= booking.get("total_passes") %></p>
                <p><strong>Total Price:</strong> ₹<%= booking.get("total_price") %></p>
                <p><strong>Status:</strong>
                    <span class="badge
                            <%=
                                "pending".equals(booking.get("status")) ? "bg-warning text-dark" :
                                "confirmed".equals(booking.get("status")) ? "bg-success" :
                                "cancelled".equals(booking.get("status")) ? "status-cancelled" : "bg-secondary"
                            %>">
                            <%= booking.get("status") %>
                        </span>
                </p>
            </div>
            <div class="col-md-4 text-end d-flex flex-column justify-content-center">
                <%
                    String status = (String) booking.get("status");
                    Date visitDate = (Date) booking.get("visit_date"); // java.sql.Date
                    LocalDate visitLocalDate = visitDate.toLocalDate();

                    if ((status.equals("pending") || status.equals("confirmed")) &&
                            (visitLocalDate.isEqual(today) || visitLocalDate.isAfter(today))) {
                %>
                <form method="post" action="CancelBookingServlet">
                    <input type="hidden" name="booking_id" value="<%= booking.get("bookings_id") %>">
                    <button type="submit" class="btn btn-danger">Cancel</button>
                </form>
                <%
                } else {
                %>
                <span class="text-muted">No action available</span>
                <%
                    }
                %>
            </div>
        </div>
    </div>
    <%
            }
        }
    %>
</div>
<!-- Main Content End -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
