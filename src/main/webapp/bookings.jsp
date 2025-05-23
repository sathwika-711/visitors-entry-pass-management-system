<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.sql.Date" %>

<%
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

        .ticket-card {
            border: 2px dashed #6c757d;
            border-radius: 12px;
            padding: 1.5rem;
            background-color: #f8f9fa;
            margin-bottom: 1.5rem;
        }

        .status-cancelled {
            background-color: #e74c3c !important;
            color: white !important;
        }

        .btn-action {
            padding: 6px 14px;
            font-size: 14px;
            font-weight: 500;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: all 0.3s ease;
        }

        .btn-cancel {
            background-color: #dc3545;
            color: white;
            border: none;
        }

        .btn-cancel:hover {
            background-color: #bb2d3b;
        }

        .btn-download {
            background-color: #28a745;
            color: white;
            border: none;
        }

        .btn-download:hover {
            background-color: #218838;
        }
        .col-md-4 {
            display: flex;
            flex-direction: column;
            align-items: flex-end; /* aligns items to the right */
            justify-content: center; /* vertically centers */
            gap: 10px; /* optional space between buttons */
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
                    Date visitDate = (Date) booking.get("visit_date");
                    LocalDate visitLocalDate = visitDate.toLocalDate();

                    if ((status.equals("pending") || status.equals("confirmed")) &&
                            (visitLocalDate.isEqual(today) || visitLocalDate.isAfter(today))) {
                %>
                <form method="post" action="CancelBookingServlet" class="mb-2">
                    <input type="hidden" name="booking_id" value="<%= booking.get("bookings_id") %>">
                    <button type="submit" class="btn btn-danger">❌ Cancel</button>
                </form>
                <form method="get" action="downloadPassImagebyID">
                    <input type="hidden" name="booking_id" value="<%= booking.get("bookings_id") %>">
                    <button type="submit" class="btn btn-success">⬇️ Download Pass</button>
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
