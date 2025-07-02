<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Home</title>

    <!-- Font Awesome CDN -->
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
            background-color: #f7f9fc;
            color: #333;
        }

        .navbar {
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 25px 40px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            min-height: 80px;
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
            font-size: 32px;
            margin-bottom: 30px;
            border-bottom: 2px solid #ccc;
            padding-bottom: 10px;
        }

        .cards-section {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-top: 30px;
        }

        .card {
            background-color: #ffffff;
            border-radius: 14px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
            padding: 40px;
            flex: 0 0 calc(48%);
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            gap: 20px;
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .icon-box {
            width: 100px;
            height: 100px;
            background-color: #e8effa;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
        }

        .icon-box i {
            font-size: 48px;
            color: #2a5298;
        }

        .card-content a {
            font-size: 22px;
            font-weight: bold;
            color: #1e3c72;
            text-decoration: none;
            display: block;
            margin-bottom: 10px;
        }

        .card-content a:hover {
            text-decoration: underline;
        }

        .card-content p {
            font-size: 17px;
            color: #555;
        }

        @media (max-width: 768px) {
            .cards-section {
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

            .card {
                flex: 1 1 100%;
            }
        }
    </style>
</head>
<body>
<div class="navbar">
    <div class="left">
        <i class="fas fa-ticket-alt"></i> Visitors Entry Pass Management System
    </div>
    <div class="right">
        <a href="adminhome.jsp">Home</a>
        <a href="manageManagers?locationId=1">Manage Managers</a>
        <a href="manageLocations">Manage Locations</a>
        <a href="generateReports">Report & Analytics</a>
        <a href="viewFeedbacks">View Feedback</a>
        <a href="LogoutServlet?role=admin" class="logout">Logout</a>
    </div>
</div>

<div class="content">
    <h1>Welcome to the Admin Home Page</h1>

    <div class="cards-section">
        <div class="card">
            <div class="icon-box">
                <i class="fas fa-user-tie"></i>
            </div>
            <div class="card-content">
                <a href="manageManagers?locationId=1">Manage Managers</a>
                <p>Add or remove managers for each location.</p>
            </div>
        </div>

        <div class="card">
            <div class="icon-box">
                <i class="fas fa-map-marker-alt"></i>
            </div>
            <div class="card-content">
                <a href="manageLocations">Manage Locations</a>
                <p>Add Locations or Edit location details.</p>
            </div>
        </div>

        <div class="card">
            <div class="icon-box">
                <i class="fas fa-chart-line"></i>
            </div>
            <div class="card-content">
                <a href="generateReports">Report & Analytics</a>
                <p>View revenue and visitor trends.</p>
            </div>
        </div>

        <div class="card">
            <div class="icon-box">
                <i class="fas fa-comments"></i>
            </div>
            <div class="card-content">
                <a href="viewFeedbacks">View Feedback</a>
                <p>Check feedback submitted by visitors.</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
