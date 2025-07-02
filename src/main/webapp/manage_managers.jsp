<%@ page import="java.util.List" %>
<%@ page import="Model.Manager" %>
<%@ page import="DAO.ManagerDao" %>
<%@ page import="Model.LocationsModel" %>
<%@ page import="DAO.LocationsDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Managers</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f1f3f6;
            margin: 0;
        }

        /* NAVBAR STYLES */
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

        /* PAGE STYLES */
        .container {
            max-width: 1100px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .section {
            background: #ffffff;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            padding: 25px 30px;
            margin-bottom: 40px;
            border-radius: 10px;
        }

        .section h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            padding: 12px 14px;
            border: 1px solid #e0e0e0;
            text-align: center;
        }

        th {
    		background-color: #000;  /* Black header */
    		color: #fff;             /* White text */
		}


        tr:hover {
            background-color: #f4f9fc;
        }

        .btn-delete, .btn-add {
            padding: 8px 14px;
            border: none;
            border-radius: 5px;
            color: #fff;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-delete {
            background-color: #e74c3c;
        }

        .btn-add {
            background-color: #2ecc71;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        .btn-add:hover {
            background-color: #27ae60;
        }

        .popup-form, .delete-modal {
            display: none;
            position: fixed;
            top: 10%;
            left: 50%;
            transform: translateX(-50%);
            background: #ffffff;
            padding: 25px;
            width: 400px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            border-radius: 10px;
            z-index: 999;
        }

        .popup-form input[type="text"],
        .popup-form input[type="email"],
        .popup-form input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.4);
            z-index: 998;
        }

        .form-buttons {
            display: flex;
            justify-content: space-between;
        }

        .delete-modal p {
            margin-bottom: 20px;
            font-size: 16px;
            text-align: center;
        }

        .delete-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .delete-buttons button {
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            color: #fff;
            cursor: pointer;
        }

        .btn-confirm {
            background-color: #e74c3c;
        }

        .btn-cancel {
            background-color: #7f8c8d;
        }

        @media (max-width: 600px) {
            .popup-form, .delete-modal {
                width: 90%;
            }

            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }

            .navbar .right {
                flex-direction: column;
                gap: 10px;
                width: 100%;
            }
        }
    </style>

    <script>
        function showForm(locationId) {
            document.getElementById("managerForm").style.display = "block";
            document.getElementById("overlay").style.display = "block";
            document.getElementById("locationInput").value = locationId;
        }

        function closeForm() {
            document.getElementById("managerForm").style.display = "none";
            document.getElementById("overlay").style.display = "none";
        }

        function openDeleteModal(managerId) {
            document.getElementById("overlay").style.display = "block";
            document.getElementById("deleteModal").style.display = "block";
            document.getElementById("deleteManagerId").value = managerId;
        }

        function closeDeleteModal() {
            document.getElementById("overlay").style.display = "none";
            document.getElementById("deleteModal").style.display = "none";
        }

        function confirmDelete() {
            document.getElementById("deleteForm").submit();
        }
    </script>
</head>
<body>

<!-- NAVBAR -->
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

<%
    ManagerDao dao = new ManagerDao();
    List<Manager> managers = dao.getAllManagers();
    LocationsDAO locDao = new LocationsDAO();
    List<LocationsModel> locations = locDao.getAllLocations();
%>

<div class="container">

    <!-- SECTION 1: Add Manager -->
    <div class="section">
        <h2>Add Manager</h2>
        <table>
            <tr>
                <th>Location</th>
                <th>Action</th>
            </tr>
            <% for (LocationsModel l : locations) { %>
            <tr>
                <td><%= l.getLocationName() %> (ID: <%= l.getLocationId() %>)</td>
                <td><button class="btn-add" onclick="showForm(<%= l.getLocationId() %>)">Add Manager</button></td>
            </tr>
            <% } %>
        </table>
    </div>

    <!-- POPUP ADD FORM -->
    <div class="overlay" id="overlay" onclick="closeForm(); closeDeleteModal();"></div>

    <div class="popup-form" id="managerForm">
        <h3 style="text-align:center; margin-bottom: 15px;">Add New Manager</h3>
        <form action="manageManagers" method="post">
            <label>Name:</label>
            <input type="text" name="name" required>

            <label>Email:</label>
            <input type="email" name="email" required>

            <label>Password:</label>
            <input type="password" name="password" required>

            <input type="hidden" name="locationId" id="locationInput">

            <div class="form-buttons">
                <input type="submit" value="Add Manager" class="btn-add">
                <button type="button" onclick="closeForm()" class="btn-delete">Cancel</button>
            </div>
        </form>
    </div>

    <!-- DELETE CONFIRMATION MODAL -->
    <div class="delete-modal" id="deleteModal">
        <form id="deleteForm" action="manageManagers" method="get">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="id" id="deleteManagerId">
            <p>Are you sure you want to delete this manager?</p>
            <div class="delete-buttons">
                <button type="button" onclick="confirmDelete()" class="btn-confirm">OK</button>
                <button type="button" onclick="closeDeleteModal()" class="btn-cancel">Cancel</button>
            </div>
        </form>
    </div>

    <!-- SECTION 2: Managers List -->
    <div class="section">
        <h2>Managers List</h2>
        <table>
            <tr>
                <th>Manager ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Location ID</th>
                <th>Actions</th>
            </tr>
            <% for (Manager m : managers) { %>
            <tr>
                <td><%= m.getManagerId() %></td>
                <td><%= m.getName() %></td>
                <td><%= m.getEmail() %></td>
                <td><%= m.getLocationId() %></td>
                <td>
                    <button class="btn-delete" onclick="openDeleteModal(<%= m.getManagerId() %>)">Delete</button>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

</div>

</body>
</html>
