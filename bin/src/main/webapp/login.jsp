<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login | Visitors Entry Pass</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/25/25694.png" type="image/png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>

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

        /* Centering Form */
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

        .register-text {
            margin-top: 20px;
            font-size: 14px;
        }

        .register-text a {
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
        }

        .register-text a:hover {
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

<!-- Centered Login Form -->
<div class="center-wrapper">
    <div class="glass-container">
        <h2>Login</h2>
        <form action="LoginServlet" method="post">
            <div class="input-group">
                <input type="text" name="email" placeholder="Email" required>
                <i class="fa fa-user"></i>
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

        <div class="register-text">
            Don't have an account? <a href="register.jsp">Register</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
