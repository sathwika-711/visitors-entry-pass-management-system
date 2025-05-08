<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h2>Edit Profile</h2>

    <!-- Form to Edit User Details -->
    <form action="UpdateServlet" method="POST">
        <!-- Hidden field to pass userId -->
        <input type="hidden" name="userId" value="${user.userId}" />

        <!-- Name Field -->
        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" id="name" name="name" value="${user.name}" required>
        </div>

        <!-- Mobile Field -->
        <div class="mb-3">
            <label for="mobile" class="form-label">Mobile</label>
            <input type="text" class="form-control" id="mobile" name="mobile" value="${user.mobile}" required>
        </div>

        <!-- Email Field -->
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
        </div>

        <!-- Address Field -->
        <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <textarea class="form-control" id="address" name="address" rows="3" required>${user.address}</textarea>
        </div>

        <!-- Gender Field -->
        <div class="mb-3">
            <label for="gender" class="form-label">Gender</label>
            <select class="form-control" id="gender" name="gender" required>
                <option value="Male" <c:if test="${user.gender == 'Male'}">selected</c:if>>Male</option>
                <option value="Female" <c:if test="${user.gender == 'Female'}">selected</c:if>>Female</option>
                <option value="Other" <c:if test="${user.gender == 'Other'}">selected</c:if>>Other</option>
            </select>
        </div>

        <!-- Password Field -->
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" value="${user.password}" required>
        </div>

        <!-- Role Field (hidden or editable based on your requirements) -->
        <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <input type="text" class="form-control" id="role" name="role" value="${user.role}" required readonly>
        </div>

        <!-- Buttons -->
        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-primary">Update</button>
            <a href="profile.jsp" class="btn btn-secondary">Cancel</a> <!-- Link to cancel -->
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
