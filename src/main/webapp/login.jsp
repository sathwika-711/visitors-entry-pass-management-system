<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Login</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/25/25694.png" type="image/png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

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
        .error-message {
            margin-top: 10px;
            color: red;
            font-size: 13px;
        }

        /* Styles for success/error icons in modal */
        .modal-body .icon {
            font-size: 50px;
            margin-bottom: 20px;
        }
        .modal-body .icon.success {
            color: #28a745; /* Green */
        }
        .modal-body .icon.error {
            color: #dc3545; /* Red */
        }
        .modal-body p {
            font-size: 1.1em;
            color: #333;
        }
    </style>
</head>
<body>

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


<div class="center-wrapper">
    <div class="glass-container">
        <h2>User Login</h2>
        <form action="LoginServlet" method="post">
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
        <div class="register-text">
            Don't have an account? <a href="register.jsp">Register here</a>
        </div>
    </div>
</div>


<div class="modal fade" id="statusModal" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="statusModalLabel">User Login Status</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <div id="modalIcon" class="icon"></div>
                <p id="modalMessage"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="modalOkButton">OK</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);
        const loginStatus = urlParams.get('status');
        const registrationStatus = urlParams.get('regStatus'); // Use a different parameter name for registration status

        const modal = new bootstrap.Modal(document.getElementById('statusModal'));
        const modalMessage = document.getElementById('modalMessage');
        const modalIcon = document.getElementById('modalIcon');
        const modalOkButton = document.getElementById('modalOkButton');

        // Handle login success
        if (loginStatus === 'success') {
            modalIcon.className = 'icon success fas fa-check-circle';
            modalMessage.textContent = 'User Login successful!';
            modalOkButton.onclick = function() {
                window.location.href = 'visitorhome.jsp'; // Redirect to visitor home page
            };
            modal.show();
        }

    });
</script>

</body>
</html>