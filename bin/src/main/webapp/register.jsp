<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Registration</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/25/25694.png" type="image/png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS & Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            min-height: 100vh;
            background: linear-gradient(to right, #e0eafc, #cfdef3);
            display: flex;
            flex-direction: column;
        }

        /* Navbar Styling */
        .navbar {
            padding: 1.2rem 2rem;
            font-size: 1.1rem;
            font-weight: 500;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 600;
        }

        .navbar-nav .nav-link {
            margin-left: 1rem;
            color: #ffffff !important;
            transition: color 0.3s;
        }

        .navbar-nav .nav-link:hover {
            color: #f0db4f !important;
        }

        /* Center Form */
        .center-wrapper {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .glass-container {
            width: 400px;
            padding: 40px 30px;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.85);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            color: #333;
        }

        .glass-container h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 600;
            color: #2c3e50;
        }

        form label {
            display: block;
            margin-bottom: 6px;
            font-size: 14px;
            color: #333;
        }

        form input,
        form select {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #fff;
            font-size: 14px;
        }

        form input:focus,
        form select:focus {
            outline: none;
            border-color: #3498db;
        }

        form input[type="submit"] {
            background-color: #3498db;
            color: white;
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        form input[type="submit"]:hover {
            background-color: #2980b9;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }

        .login-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Visitors Entry Pass Management System</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="index.html">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register.jsp">Register/Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="manager_login.jsp">Manager</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="adminlogin.jsp">Admin</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Centered Registration Form -->
<div class="center-wrapper">
    <div class="glass-container">
        <h2>User Registration</h2>
        <form action="RegisterServlet" method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <label for="mobile">Mobile:</label>
            <input type="text" id="mobile" name="mobile" required pattern="[0-9]{10,15}">

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="gender">Gender:</label>
            <select id="gender" name="gender" required>
                <option value="">Select Gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
            </select>

            <input type="submit" value="Register">
        </form>
        <div class="login-link">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
