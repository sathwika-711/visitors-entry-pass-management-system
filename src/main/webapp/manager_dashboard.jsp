<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.Manager, Model.Booking, java.util.List" %>
<%@ page session="true" %>
<%
    Manager manager = (Manager) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect("manager_login.jsp");
        return;
    }

    List<Booking> todaysBookings = (List<Booking>) request.getAttribute("todaysBookings");
    Integer todayVisitorCount = (Integer) request.getAttribute("todayVisitorCount");
    Integer monthlyVisitorCount = (Integer) request.getAttribute("monthlyVisitorCount");
    Double todayRevenue = (Double) request.getAttribute("todayRevenue");
    Double monthlyRevenue = (Double) request.getAttribute("monthlyRevenue");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manager Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 20px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h1 {
            color: #333;
            font-size: 32px;
        }

        .welcome-msg {
            font-size: 18px;
            margin-top: 10px;
            color: #666;
        }

        .location-info {
            font-size: 16px;
            margin-top: 5px;
            color: #444;
            font-style: italic;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            margin: 20px 10px 10px 0;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            transition: 0.3s;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .visitor-summary {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }

        .card {
            flex: 1;
            min-width: 200px;
            padding: 20px;
            background-color: #e9f5ff;
            border-left: 5px solid #007bff;
            border-radius: 8px;
            font-size: 16px;
            color: #333;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        h2 {
            margin-top: 30px;
            font-size: 24px;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        table th {
            background-color: #007bff;
            color: white;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        .status-pending { color: orange; font-weight: bold; }
        .status-confirmed { color: green; font-weight: bold; }
        .status-cancelled { color: red; font-weight: bold; }

        .action-btn {
            padding: 8px 16px;
            color: white;
            background-color: #28a745;
            text-decoration: none;
            border-radius: 5px;
            margin-right: 10px;
            transition: 0.3s;
        }

        .action-btn:hover {
            background-color: #218838;
        }

        .logout {
            display: inline-block;
            padding: 12px 24px;
            margin-top: 20px;
            color: white;
            background-color: #dc3545;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            transition: 0.3s;
        }

        .logout:hover {
            background-color: #c82333;
        }

        @media screen and (max-width: 768px) {
            .dashboard-container {
                padding: 20px;
            }

            .visitor-summary {
                flex-direction: column;
            }

            .btn, .logout {
                font-size: 14px;
                padding: 10px 20px;
            }

            table th, table td {
                font-size: 14px;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <h1>Manager Dashboard</h1>
    <div class="welcome-msg">Welcome, <strong><%= manager.getName() %></strong>!</div>
    <div class="location-info">Managing Location: <strong><%= manager.getLocationName() %></strong></div>

    <!-- Action Buttons -->
    <a href="VisitorDashboardServlet" class="btn">Manage Visitors</a>
    <a href="FutureVisitorsServlet" class="btn">Future Visitors</a>
    <a href="viewFeedbackByLocation" class="btn">View Feedbacks</a>

    <!-- Visitor Stats -->
    <div class="visitor-summary">
        <div class="card">Today's Visitors: <%= (todayVisitorCount != null ? todayVisitorCount : 0) %></div>
        <div class="card">Monthly Visitors: <%= (monthlyVisitorCount != null ? monthlyVisitorCount : 0) %></div>
    </div>
    <div class="visitor-summary">
        <div class="card">Today's Revenue: ₹<%= (todayRevenue != null ? String.format("%.2f", todayRevenue) : "0.00") %></div>
        <div class="card">Monthly Revenue: ₹<%= (monthlyRevenue != null ? String.format("%.2f", monthlyRevenue) : "0.00") %></div>
    </div>

    <!-- Chart Section: Visitors and Revenue -->
    <div style="margin-top: 30px; display: flex; flex-wrap: wrap; justify-content: space-around; gap: 40px;">
        <div style="flex: 1; min-width: 300px;">
            <h2 style="text-align:center;">Visitor Stats</h2>
            <canvas id="visitorChart"></canvas>
        </div>
        <div style="flex: 1; min-width: 300px;">
            <h2 style="text-align:center;">Revenue Stats</h2>
            <canvas id="revenueChart"></canvas>
        </div>
    </div>



    <a href="LogoutServlet?role=manager" class="logout">Logout</a>
</div>

<!-- Chart.js Scripts -->
<script>
    const visitorCtx = document.getElementById('visitorChart').getContext('2d');
    const revenueCtx = document.getElementById('revenueChart').getContext('2d');

    const todayVisitors = <%= (todayVisitorCount != null ? todayVisitorCount : 0) %>;
    const monthlyVisitors = <%= (monthlyVisitorCount != null ? monthlyVisitorCount : 0) %>;
    const todayRevenue = <%= (todayRevenue != null ? todayRevenue : 0.0) %>;
    const monthlyRevenue = <%= (monthlyRevenue != null ? monthlyRevenue : 0.0) %>;

    new Chart(visitorCtx, {
        type: 'bar',
        data: {
            labels: ['Today', 'This Month'],
            datasets: [{
                label: 'Visitors',
                data: [todayVisitors, monthlyVisitors],
                backgroundColor: ['#FF6384', '#36A2EB'], // Different colors
                barThickness: 30, // Thinner bars
                barPercentage: 0.5, // Reduced bar width
                categoryPercentage: 0.5 // Reduced category width
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: { beginAtZero: true }
            }
        }
    });

    new Chart(revenueCtx, {
        type: 'bar',
        data: {
            labels: ['Today', 'This Month'],
            datasets: [{
                label: 'Revenue (₹)',
                data: [todayRevenue, monthlyRevenue],
                backgroundColor: ['#FFCE56', '#4BC0C0'], // Different colors
                barThickness: 30, // Thinner bars
                barPercentage: 0.5, // Reduced bar width
                categoryPercentage: 0.5 // Reduced category width
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
</script>
</body>
</html>
