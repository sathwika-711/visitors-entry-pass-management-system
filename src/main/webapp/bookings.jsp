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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        /* ... your existing styles ... */
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
            align-items: flex-end;
            justify-content: center;
            gap: 10px;
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
                    double totalPrice = Double.parseDouble(booking.get("total_price").toString());
                    boolean isToday = visitLocalDate.isEqual(today);
                    boolean isFuture = visitLocalDate.isAfter(today);

                    if ((status.equals("pending") || status.equals("confirmed")) &&
                            (isToday || isFuture)) {
                %>
                <!-- Cancel Button with Confirmation -->
                <button type="button" class="btn btn-danger"
                        onclick="showCancelPopup(<%= booking.get("bookings_id") %>, <%= totalPrice %>, <%= isToday %>, '<%= booking.get("visit_date") %>')">
                    ❌ Cancel
                </button>
                <form id="cancel-form-<%= booking.get("bookings_id") %>" method="post" action="CancelBookingServlet" style="display:none;">
                    <input type="hidden" name="bookings_id" value="<%= booking.get("bookings_id") %>">
                    <input type="hidden" name="visit_date" value="<%= booking.get("visit_date") %>">
                </form>

                <!-- Download Pass Button -->
                <form method="get" action="downloadPassbyId">
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

<!-- Popup Modal without Close button -->
<div id="cancelPopup" class="modal fade" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">Cancel Booking</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                <!-- Removed the close button here -->
            </div>
            <div class="modal-body" id="cancelMessage"></div>
            <div class="modal-footer">
                <!-- Removed Close button -->
                <button type="button" class="btn btn-danger" id="confirmCancelBtn">✅ Proceed</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let cancelBookingId = null;
    let cancelModalInstance = null;

    function showCancelPopup(bookingId, totalPrice, isToday, visitDate) {
        cancelBookingId = bookingId;

        const refundAmount = isToday ? 0 : (totalPrice * 0.9).toFixed(2);
        const message = isToday
            ? `<p>Your visit is today (<strong>${visitDate}</strong>).</p><p><strong>No refund</strong> will be provided upon cancellation.</p>`
            : `<p>Your visit is on <strong>${visitDate}</strong>.</p><p><strong>90% refund</strong> will be processed: ₹<strong>${refundAmount}</strong>.</p>`;

        document.getElementById('cancelMessage').innerHTML = message;

        if (!cancelModalInstance) {
            cancelModalInstance = new bootstrap.Modal(document.getElementById('cancelPopup'));
        }
        cancelModalInstance.show();
    }

    document.getElementById('confirmCancelBtn').addEventListener('click', function () {
        if (cancelBookingId !== null) {
            document.getElementById('cancel-form-' + cancelBookingId).submit();
            cancelModalInstance.hide();
        }
    });
</script>

</body>
</html>
