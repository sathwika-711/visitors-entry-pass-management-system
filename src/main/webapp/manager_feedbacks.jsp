<%@ page import="java.util.List" %>
<%@ page import="Model.Feedback" %>

<%
  List<Feedback> feedbacks = (List<Feedback>) request.getAttribute("feedbacks");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Feedbacks</title>

  <!-- Bootstrap CSS CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    .card {
      border-radius: 15px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
      background-color: #f0f8ff;
      border-left: 5px solid #007bff;
    }
    .card-body {
      color: #333;
    }
    .star-rating {
      color: #FFD700; /* Gold color for the stars */
      font-size: 1.5rem;
    }
    .card-title {
      color: #007bff;
    }
    .alert-warning {
      background-color: #cce5ff;
      border-color: #007bff;
    }
    .back-btn {
      display: inline-block;
      margin-top: 30px;
      padding: 10px 20px;
      color: white;
      background-color: #6c757d;
      text-decoration: none;
      border-radius: 5px;
    }

    .back-btn:hover {
      background-color: #5a6268;
    }
  </style>

</head>
<body class="bg-light">

<div class="container py-5">
  <h2 class="text-center mb-5 fw-bold text-primary">Location Feedback</h2>

  <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
    <%
      if (feedbacks != null && !feedbacks.isEmpty()) {
        for (Feedback fb : feedbacks) {
    %>
    <div class="col">
      <div class="card h-100 p-3">
        <div class="card-body">
          <h5 class="card-title">User ID: <%= fb.getUserId() %></h5>
          <h6 class="card-text"><strong>Email: </strong> <%= fb.getEmail() %></h6>
          <p class="card-text"><strong>Description:</strong> <%= fb.getDescription() %></p>
          <p class="star-rating mb-2">
            <strong>Rating:</strong>
            <%
              int rating = fb.getRating();
              for (int i = 0; i < 5; i++) {
                if (i < rating) {
                  out.print("&#9733;"); // Filled star
                } else {
                  out.print("&#9734;"); // Empty star
                }
              }
            %>
          </p>
          <p class="text-muted small text-end">Submitted: <%= fb.getSubmittedAt() %></p>
        </div>
      </div>
    </div>
    <%
      }
    } else {
    %>
    <div class="col">
      <div class="alert alert-warning text-center w-100">No feedbacks available.</div>
    </div>
    <%
      }
    %>
  </div>

  <!-- Back to Dashboard Button -->
  <a href="ManagerDashboardServlet" class="back-btn">Back to Dashboard</a>
</div>

</body>
</html>
