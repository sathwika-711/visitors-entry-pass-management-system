<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/25/25694.png" type="image/png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

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

        /* Modern Navbar */
        .navbar {
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 25px 40px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .navbar .left {
            font-size: 24px;
            font-weight: bold;
            color: white;
        }

        .navbar .right {
            display: flex;
            gap: 16px;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 6px;
            transition: background-color 0.3s ease;
            font-weight: 500;
        }

        .navbar a:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .navbar .login {
            background-color: #3498db;
        }

        .navbar .login:hover {
            background-color: #2980b9;
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
                padding: 20px;
            }

            .navbar .right {
                flex-direction: column;
                gap: 10px;
                width: 100%;
                align-items: flex-start;
            }
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
            width: 360px;
            padding: 40px 30px;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.85);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            color: #333;
            text-align: center;
        }

        .glass-container h2 {
            margin-bottom: 25px;
            font-weight: 600;
            color: #2c3e50;
        }

        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .input-group input {
            width: 100%;
            padding: 12px 40px 12px 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background: #fff;
            color: #333;
            font-size: 14px;
        }

        .input-group input::placeholder {
            color: #888;
        }

        .input-group .fa {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
        }

        .btn {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 8px;
            background-color: #3498db;
            color: white;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .error-message {
            margin-top: 10px;
            color: red;
            font-size: 13px;
        }
    </style>
</head>

<body>

<!-- Navbar -->

<div class="navbar">
    <div class="left">
        <i class="fas fa-ticket-alt"></i> Visitors Entry Pass Management System
    </div>
    <div class="right">
        <a href="register.jsp"><i class="fas fa-user-plus"></i> Register/Login</a>
        <a href="manager_login.jsp"><i class="fas fa-user-tie"></i> Manager</a>
        <a href="adminlogin.jsp"><i class="fas fa-user-shield"></i> Admin</a>
    </div>
</div>

<!-- Centered Admin Login Form -->

<div class="center-wrapper">
    <div class="glass-container">
        <h2>Admin Login</h2>
        <form action="AdminLoginServlet" method="post">
            <div class="input-group">
                <input type="email" name="email" placeholder="Email" required>
                <i class="fa fa-envelope"></i>
            </div>
            <div class="input-group">
                <input type="password" name="password" placeholder="Password" required>
                <i class="fa fa-lock"></i>
            </div>
            <input type="submit" class="btn" value="Login">
        </form>

        <% if ("fail".equals(request.getParameter("status"))) { %>
        <div class="error-message">Invalid email or password!</div>
        <% } %>
    </div>
</div>

<!-- Bootstrap JS -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
