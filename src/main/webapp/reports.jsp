<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Model.LocationReport" %>
<!DOCTYPE html>
<html>
<head>
    <title>Visitor & Revenue Report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
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

        .report-header {
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin: 50px 0 20px 0;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 1380px;
        }

        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .stats-card h3 {
            color: #1e3c72;
            margin-bottom: 15px;
        }

        .stats-value {
            font-size: 24px;
            font-weight: bold;
            color: #28a745;
        }

        .table-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
        }

        .table th {
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            color: white;
            border: none;
        }

        .total-row {
            font-weight: bold;
            background: #f8f9fa;
        }

        canvas {
            margin-top: 30px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
        }

        @media (max-width: 768px) {
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

<!-- Navbar -->
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

<!-- Main Content -->
<div class="container">
    <div class="report-header">
        <p class="mb-0">
            <strong><%= ((String) request.getAttribute("period")).toUpperCase() %> Report</strong>
            - Generated on <%= new java.text.SimpleDateFormat("dd MMM yyyy HH:mm").format(new Date()) %>
        </p>
    </div>

    <form method="get" action="generateReports" class="mb-4">
        <div class="row">
            <div class="col-md-4">
                <label for="period" class="form-label">Select Report Period:</label>
                <select name="period" id="period" class="form-select" onchange="this.form.submit()">
                    <option value="daily" <%= "daily".equals(request.getAttribute("period")) ? "selected" : "" %>>Daily Report</option>
                    <option value="weekly" <%= "weekly".equals(request.getAttribute("period")) ? "selected" : "" %>>Weekly Report</option>
                    <option value="monthly" <%= "monthly".equals(request.getAttribute("period")) ? "selected" : "" %>>Monthly Report</option>
                </select>
            </div>
        </div>
    </form>

    <div class="row mb-4">
        <div class="col-md-4">
            <div class="stats-card">
                <h3>Total Managers</h3>
                <div class="stats-value"><%= request.getAttribute("totalManagers") != null ? request.getAttribute("totalManagers") : 0 %></div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stats-card">
                <h3>Total Locations</h3>
                <div class="stats-value"><%= request.getAttribute("totalLocations") != null ? request.getAttribute("totalLocations") : 0 %></div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stats-card">
                <h3>Total Visitors</h3>
                <div class="stats-value"><%= request.getAttribute("totalVisitors") != null ? request.getAttribute("totalVisitors") : 0 %></div>
            </div>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-12">
            <div class="stats-card">
                <h3>Total Revenue</h3>
                <div class="stats-value">
                    ₹<%= request.getAttribute("totalRevenue") != null ? String.format("%.2f", request.getAttribute("totalRevenue")) : "0.00" %>
                </div>
            </div>
        </div>
    </div>

    <div class="table-container">
        <h4>Location-wise Report</h4>
        <table class="table table-bordered table-hover mt-3">
            <thead>
            <tr>
                <th>Location</th>
                <th>Total Visitors</th>
                <th>Total Revenue</th>
                <th>Avg. Revenue per Visitor</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<LocationReport> reports = (List<LocationReport>) request.getAttribute("locationReports");
                if (reports != null && !reports.isEmpty()) {
                    for (LocationReport r : reports) {
            %>
            <tr>
                <td><%= r.getLocationName() %></td>
                <td><%= r.getTotalVisitors() %></td>
                <td>₹<%= String.format("%.2f", r.getTotalRevenue()) %></td>
                <td>₹<%= r.getTotalVisitors() != 0 ? String.format("%.2f", r.getTotalRevenue() / r.getTotalVisitors()) : "0.00" %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="4" class="text-center">No data available</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <canvas id="visitorsChart" height="100"></canvas>
    <canvas id="revenueChart" height="100"></canvas>
</div>
<%
    List<LocationReport> report = (List<LocationReport>) request.getAttribute("locationReports");
%>

<script>
    // Directly use the 'reports' variable without redeclaring it
    const labels = [
        <% for (LocationReport r : report) { %>
        "<%= r.getLocationName().replace("\"", "\\\"") %>",
        <% } %>
    ];

    const visitorData = [
        <% for (LocationReport r : report) { %>
        <%= r.getTotalVisitors() %>,
        <% } %>
    ];

    const revenueData = [
        <% for (LocationReport r : report) { %>
        <%= r.getTotalRevenue() %>,
        <% } %>
    ];

    // Visitors Chart
    new Chart(document.getElementById('visitorsChart').getContext('2d'), {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Total Visitors',
                data: visitorData,
                backgroundColor: 'rgba(54, 162, 235, 0.7)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: 'Total Visitors per Location'
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // Revenue Chart
    new Chart(document.getElementById('revenueChart').getContext('2d'), {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Total Revenue (₹)',
                data: revenueData,
                backgroundColor: 'rgba(255, 99, 132, 0.7)',
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: 'Total Revenue per Location'
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>


</body>
</html>
