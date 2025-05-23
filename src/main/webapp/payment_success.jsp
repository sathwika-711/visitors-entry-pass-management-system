<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payment Successful</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background: linear-gradient(to bottom, #f9f9f9, #d4edda);
        }

        /* Custom Navbar */
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

        /* Loading Screen */
        .loading {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: #ffffff;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .loading .spinner {
            border: 6px solid #f3f3f3;
            border-top: 6px solid #28a745;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
        }

        /* Animation for spinning */
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .loading p {
            font-size: 1.2em;
            color: #333;
            margin-top: 20px;
            text-align: center;
        }

        /* Success Box */
        .success-box {
            background-color: #ffffff;
            padding: 40px 60px;
            border-radius: 16px;
            display: inline-block;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            max-width: 600px;
            opacity: 0;
            transition: opacity 0.5s ease-in-out;
            text-align: center;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1;
        }

        .success-box h2 {
            color: #28a745;
            font-size: 2.5em;
            margin-bottom: 20px;
        }

        .success-box p {
            font-size: 1.2em;
            color: #333;
            margin-top: 10px;
        }

        .checkmark {
            font-size: 4em;
            color: #28a745;
            margin-bottom: 20px;
        }

        .btn {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 24px;
            font-size: 1em;
            color: #fff;
            background-color: #28a745;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #218838;
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

<!-- Loading Screen -->
<div class="loading" id="loading-screen">
    <div class="spinner"></div>
    <p>Wait for a while, we are confirming your payment...</p>
</div>

<!-- Success Box (Initially Hidden) -->
<div class="success-box" id="success-box">
    <div class="checkmark">✅</div>
    <h2>Payment Successful</h2>
    <p>Your payment has been processed successfully and your pass is confirmed. Enjoy your visit!</p>
    <a href="MyBookingsServlet" class="btn">View My Bookings</a>
    <form method="get" action="downloadPassImage">
        <button type="submit" class="btn">Download Visitor Pass (PNG)</button>
    </form>


</div>

<script>
    // Function to hide the loading screen and show the success box after 2 seconds
    setTimeout(function() {
        document.getElementById('loading-screen').style.display = 'none';
        document.getElementById('success-box').style.opacity = 1;
    }, 2000); // 2 seconds delay
</script>

</body>
</html>
