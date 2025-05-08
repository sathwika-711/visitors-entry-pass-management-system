<%@ page import="Model.LocationsModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    LocationsModel loc = (LocationsModel) request.getAttribute("location");
    boolean isEdit = loc != null;
%>
<html>
<head>
    <title><%= isEdit ? "Edit" : "Add" %> Location</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
            padding: 40px;
        }

        .form-container {
            width: 500px;
            margin: auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            height: 100px;
        }

        .button-group {
            margin-top: 25px;
            text-align: center;
        }

        button {
            background-color: #007bff;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            margin-right: 10px;
        }

        button:hover {
            background-color: #0056b3;
        }

        .cancel-button {
            background-color: #6c757d;
        }

        .cancel-button:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2><%= isEdit ? "Edit" : "Add" %> Location</h2>
    <form action="manageLocations" method="post">
        <% if (isEdit) { %>
            <input type="hidden" name="locationId" value="<%= loc.getLocationId() %>">
        <% } %>

        <label for="locationName">Location Name:</label>
        <input type="text" name="locationName" id="locationName" required
               value="<%= isEdit ? loc.getLocationName() : "" %>">

        <label for="adultPassPrice">Adult Pass Price:</label>
        <input type="number" name="adultPassPrice" id="adultPassPrice" step="0.01" required
               value="<%= isEdit ? loc.getAdultPassPrice() : "" %>">

        <label for="childPassPrice">Child Pass Price:</label>
        <input type="number" name="childPassPrice" id="childPassPrice" step="0.01"
               value="<%= isEdit && loc.getChildPassPrice() != null ? loc.getChildPassPrice() : "" %>">

        <label for="description">Description:</label>
        <textarea name="description" id="description"><%= isEdit ? loc.getDescription() : "" %></textarea>

        <label for="timings">Timings:</label>
        <input type="text" name="timings" id="timings" required
               value="<%= isEdit ? loc.getTimings() : "" %>">

        <label for="imageUrl">Image URL:</label>
        <input type="text" name="imageUrl" id="imageUrl"
               value="<%= isEdit ? loc.getImageUrl() : "" %>">

        <label for="pincode">Pincode:</label>
        <input type="text" name="pincode" id="pincode" maxlength="10"
               value="<%= isEdit ? loc.getPincode() : "" %>">

        <div class="button-group">
            <button type="submit"><%= isEdit ? "Update" : "Add" %> Location</button>
            <a href="manageLocations"><button type="button" class="cancel-button">Cancel</button></a>
        </div>
    </form>
</div>

</body>
</html>
