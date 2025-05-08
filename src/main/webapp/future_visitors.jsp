<%@ page import="Model.Visitor, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Future Visitors</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fc;
            padding: 20px;
        }

        h2 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ccc;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        a.back {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border-radius: 4px;
        }

        a.back:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h2>Future Visitors List</h2>
    <table>
        <tr>
            <th>Booking ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Visit Date</th>
            <th>Total Passes</th>
            <th>Total Price</th>
            <th>Status</th>
        </tr>
        <%
            List<Visitor> futureVisitors = (List<Visitor>) request.getAttribute("futureVisitors");
            if (futureVisitors != null && !futureVisitors.isEmpty()) {
                for (Visitor v : futureVisitors) {
        %>
        <tr>
            <td><%= v.getId() %></td>
            <td><%= v.getName() %></td>
            <td><%= v.getEmail() %></td>
            <td><%= v.getPhone() %></td>
            <td><%= v.getVisitDate() %></td>
            <td><%= v.getTotalPasses() %></td>
            <td>₹<%= String.format("%.2f", v.getTotalPrice()) %></td>
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
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="6">No future visitors found.</td>
        </tr>
        <% } %>
    </table>
    <a class="back" href="ManagerDashboardServlet">Back to Dashboard</a>
</body>
</html>
