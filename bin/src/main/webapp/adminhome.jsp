<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Home</title>
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

        .content {
            padding: 30px;
            max-width: 1200px;
            margin: auto;
        }

        h1 {
            font-size: 30px;
            margin-bottom: 25px;
            border-bottom: 2px solid #ccc;
            padding-bottom: 10px;
        }

        .overview {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 30px;
        }

        .box {
            background-color: #fff;
            padding: 22px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
            flex: 1;
        }

        .box h2 {
            font-size: 22px;
            margin-bottom: 10px;
            color: #1e3c72;
        }

        .box p {
            font-size: 18px;
        }

        h2 {
            font-size: 24px;
            margin-bottom: 15px;
        }

        ul {
            margin-top: 10px;
            padding-left: 25px;
        }

        li {
            margin-bottom: 10px;
            font-size: 16px;
        }

        @media (max-width: 768px) {
            .overview {
                flex-direction: column;
            }

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
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="left">
            Visitors Entry Pass Management System
        </div>
        <div class="right">
            <a href="adminhome.jsp">Home</a>
            <a href="manageManagers?locationId=1">Manage Managers</a>
            <a href="manageLocations">Manage Locations</a>
            <a href="generateReports">Report & Analytics</a>
            <a href="viewFeedbacks">Feedbacks</a>
            <a href="LogoutServlet?role=admin" class="logout">Logout</a>
        </div>
    </div>

    <div class="content">
        <h1>Welcome to the Admin Home Page</h1>
        <div class="overview">
            <div class="box">
                <h2>Managers Overview</h2>
                <p>Total Managers: 5</p>
            </div>
            <div class="box">
                <h2>Revenue Overview</h2>
                <p>Total Revenue: ₹1,50,000</p>
            </div>
            <div class="box">
                <h2>Visitor Overview</h2>
                <p>Total Visitors: 2000</p>
            </div>
        </div>

        <h2>Recent Activities</h2>
        <ul>
            <li>Added new manager for Charminar.</li>
            <li>Updated pass prices for Golconda Fort.</li>
            <li>Reviewed visitor feedback from last week.</li>
        </ul>
    </div>
</body>
</html>
