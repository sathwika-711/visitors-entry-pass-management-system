<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Model.Visitor" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Visitors</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #eef1f7;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 30px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 20px;
        }

        h2 {
            margin-top: 40px;
            font-size: 22px;
            color: #444;
            border-bottom: 2px solid #007bff;
            padding-bottom: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        table th, table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        table th {
            background-color: #007bff;
            color: white;
        }

        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        .no-data {
            color: #777;
            font-style: italic;
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            color: white;
            background-color: #6c757d;
            text-decoration: none;
            border-radius: 5px;
        }

        .back-btn:hover {
            background-color: #5a6268;
        }

        .status-form select,
        .status-form button {
            padding: 5px;
            font-size: 14px;
        }

        .message {
            margin-bottom: 20px;
            color: green;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Visitor Details</h1>

    <% String msg = (String) session.getAttribute("msg");
       if (msg != null) { %>
        <p class="message"><%= msg %></p>
    <% session.removeAttribute("msg"); } %>

    <%
        Map<String, List<Visitor>> dateMap = new LinkedHashMap<>();
        dateMap.put("Yesterday", (List<Visitor>) request.getAttribute("yesterday"));
        dateMap.put("Today", (List<Visitor>) request.getAttribute("today"));
        dateMap.put("Tomorrow", (List<Visitor>) request.getAttribute("tomorrow"));
        dateMap.put("Day After Tomorrow", (List<Visitor>) request.getAttribute("dayAfterTomorrow"));

        for (Map.Entry<String, List<Visitor>> entry : dateMap.entrySet()) {
            String label = entry.getKey();
            List<Visitor> visitors = entry.getValue();
    %>
    <h2><%= label %></h2>
    <% if (visitors != null && !visitors.isEmpty()) { %>
        <table>
            <thead>
            <tr>
                <th>Booking ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Visit Date</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
            <% for (Visitor v : visitors) { %>
                <tr class="visitor-row" data-date="<%= v.getVisitDate() %>">
                    <td><%= v.getId() %></td>
                    <td><%= v.getName() %></td>
                    <td><%= v.getEmail() %></td>
                    <td><%= v.getPhone() %></td>
                    <td><%= v.getVisitDate() %></td>
                    <td>
                        <form action="updateStatus" method="post" class="status-form">
                            <input type="hidden" name="bookingId" value="<%= v.getId() %>">
                            <select name="newStatus" <%= v.getStatus().equals("cancelled") ? "disabled" : "" %>>
                                <option value="pending" <%= v.getStatus().equals("pending") ? "selected" : "" %>>Pending</option>
                                <option value="confirmed" <%= v.getStatus().equals("confirmed") ? "selected" : "" %>>Confirmed</option>
                                <option value="cancelled" <%= v.getStatus().equals("cancelled") ? "selected" : "" %>>Cancelled</option>
                            </select>
                            <% if (!v.getStatus().equals("cancelled")) { %>
                                <button type="submit">Update</button>
                            <% } %>
                        </form>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <% } else { %>
        <p class="no-data">No visitors found for <%= label.toLowerCase() %>.</p>
    <% } } %>

    <a href="ManagerDashboardServlet" class="back-btn">Back to Dashboard</a>
</div>

<!-- JavaScript to hide update button for expired dates -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const today = new Date().setHours(0, 0, 0, 0); // midnight today

        document.querySelectorAll(".visitor-row").forEach(row => {
            const visitDateStr = row.getAttribute("data-date");
            if (!visitDateStr) return;

            // Format expected: yyyy-MM-dd or a format parseable by Date
            const visitDate = new Date(visitDateStr).setHours(0, 0, 0, 0);

            if (visitDate < today) {
                const updateBtn = row.querySelector("button[type='submit']");
                if (updateBtn) updateBtn.style.display = "none";
            }
        });
    });
</script>

</body>
</html>
