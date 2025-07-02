<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Model.Feedback" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Feedback List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
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

        /* Page Header Styling */
        h2 {
            text-align: center;
            margin: 40px 0 20px;
            font-size: 28px;
            color: #333;
        }

        /* Feedback Container Styling */
        .feedback-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto 40px;
        }

        /* Feedback Card Styling */
        .feedback-card {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            font-size: 18px;
            transition: transform 0.3s ease;
        }

        .feedback-card:hover {
            transform: translateY(-5px);
        }

        .feedback-card h3 {
            margin-bottom: 15px;
            color: #333;
            font-size: 20px;
        }

        .feedback-card p {
            color: #555;
            font-size: 16px;
            margin-bottom: 10px;
        }

        .feedback-card .rating {
            font-size: 20px;
            color: gold;
        }

        .feedback-card .submitted-at {
            font-size: 14px;
            color: #888;
            margin-top: 10px;
        }

        /* Responsive Navbar */
        @media (max-width: 600px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
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

<!-- PAGE HEADER -->
<h2>All User Feedback</h2>

<!-- FEEDBACK CONTENT -->
<div class="feedback-container">
<%
    List<Feedback> feedbacks = (List<Feedback>) request.getAttribute("feedbacks");
    if (feedbacks != null && !feedbacks.isEmpty()) {
        for (Feedback fb : feedbacks) {
%>
    <div class="feedback-card">
        <h3>User ID: <%= fb.getUserId() %></h3>
        <p><strong>Email:</strong> <%= fb.getEmail() %></p>
        <p><strong>Location:</strong> <%= fb.getLocationName() %></p>
        <p><strong>Description:</strong> <%= fb.getDescription() %></p>

        <div class="rating">
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
        </div>

        <p class="submitted-at"><strong>Submitted At:</strong> <%= fb.getSubmittedAt() %></p>
    </div>
<%
        }
    } else {
%>
    <p style="text-align:center; width:100%;">No feedbacks available.</p>
<%
    }
%>
</div>

</body>
</html>
