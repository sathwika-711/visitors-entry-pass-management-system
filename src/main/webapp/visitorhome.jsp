<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Visitors Entry Pass Management System</title>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/25/25694.png" type="image/png">

    <!-- Bootstrap & Fonts -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f4f8;
            margin: 0;
            padding: 0;
            color: #333;
        }

        /* Navbar Styles (Copied from visitorhome.jsp) */
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

        .container {
            display: flex;
            max-width: 1400px;
            margin: 40px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .image-section {
            flex: 1;
            background: url('images/tourists1.png') no-repeat center center/cover;
            min-height: 500px;
        }

        .content-section {
            flex: 1;
            padding: 40px;
            background: linear-gradient(to right, #eef2f3, #ffffff);
        }

        h1 {
            color: #1e3d59;
            font-size: 28px;
            margin-bottom: 10px;
        }

        h2 {
            color: #2e5c6e;
            margin-top: 30px;
            font-size: 22px;
        }

        p {
            color: #333;
            line-height: 1.6;
        }

        ul {
            color: #444;
            padding-left: 20px;
        }

        li {
            margin-bottom: 8px;
        }

        footer {
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            color: #fff;
            padding: 40px 20px;
        }

        .footer-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            max-width: 1200px;
            margin: 0 auto;
        }

        .footer-section {
            flex: 1;
            min-width: 250px;
            margin: 10px 20px;
        }

        .footer-section h3 {
            font-size: 18px;
            margin-bottom: 15px;
            border-bottom: 2px solid #ffffff33;
            padding-bottom: 5px;
        }

        .footer-section p,
        .footer-section a {
            color: #ddd;
            font-size: 15px;
            margin: 6px 0;
            text-decoration: none;
        }

        .footer-section a:hover {
            color: #fff;
            text-decoration: underline;
        }

        .footer-copy {
            text-align: center;
            padding-top: 20px;
            font-size: 14px;
            color: #aaa;
        }
        p i {
            color: #2a5298;
            margin-right: 8px;
        }

    </style>
</head>
<body>

<!-- Custom Navbar -->
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

<!-- Main Content Container -->
<div class="container">
    <div class="image-section"></div>
    <div class="content-section">
        <h1>Welcome to the Visitors Entry Pass Management System</h1>
        <p>
            Our system is designed to simplify and streamline the process of booking passes for top destinations in Hyderabad like Charminar, Golconda Fort, Ramoji Film City, Salar Jung Museum, and many more.
        </p>

        <h2>What We Offer</h2>
        <ul>
            <li><strong>Pass Booking:</strong> Visitors can view location details, fill in their info, make secure payments, and download their passes instantly.</li>
            <li><strong>Profile Management:</strong> Users can update their profile and view or cancel their bookings anytime.</li>
            <li><strong>Location Managers:</strong> Each destination has a dedicated manager who handles visitors, feedback, booking statuses, and statistics.</li>
            <li><strong>Admin Panel:</strong> Admins can manage locations, view analytics, edit details, handle feedback, and manage managers.</li>
        </ul>

        <h2>Our Philosophy</h2>
        <ul>
            <li><strong>User First:</strong> Prioritizing convenience and clarity for all visitors.</li>
            <li><strong>Transparency:</strong> Every action is accountable – from booking to cancellation.</li>
            <li><strong>Efficiency:</strong> Quick and seamless experience for both visitors and management.</li>
            <li><strong>Insight Driven:</strong> Real-time data and statistics help improve services constantly.</li>
        </ul>
    </div>
</div>

<!-- Footer -->
<footer>
    <div class="footer-container">
        <div class="footer-section">
            <h3>Contact Us</h3>
            <p><i class="fas fa-phone-alt"></i> +91 98765 43210</p>
            <p><i class="fas fa-envelope"></i> support@visitorpasshyderabad.in</p>
        </div>

        <div class="footer-section">
            <h3>Address</h3>
            <p>Visitors Pass Office,</p>
            <p>Tourism Complex, Tank Bund Road,</p>
            <p>Hyderabad, Telangana - 500001</p>
        </div>

        <div class="footer-section">
            <h3>Follow Us</h3>
            <p><a href="#">Facebook</a> | <a href="#">Instagram</a> | <a href="#">Twitter</a></p>
        </div>
    </div>

    <div class="footer-copy">
        &copy; 2025 Visitors Entry Pass Management System. All rights reserved.
    </div>
</footer>

</body>
</html>
