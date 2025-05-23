<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Make Payment</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Same styles as you provided... */
        html, body {
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            text-align: center;
            background: linear-gradient(to bottom, #f9f9f9, #d4edda);
            margin: 0;
            padding: 0;
        }

        /* Custom Navbar */
        .navbar {
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 25px 40px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            min-height: 80px;
            margin-bottom: 20px;
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
            font-size: 18px;
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

        .payment-box {
            margin: 60px auto 20px;
            padding: 40px 30px;
            max-width: 450px;
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .payment-box h2 {
            color: #28a745;
            margin-bottom: 25px;
        }

        .payment-box p {
            font-size: 1.1em;
            margin: 8px 0;
            color: #333;
        }

        .qr-code {
            margin: 30px 0 20px;
        }

        .qr-code img {
            width: 180px;
            border: 2px solid #28a745;
            border-radius: 12px;
            padding: 8px;
        }

        button {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 14px 30px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #218838;
        }

        .back-button {
            display: inline-block;
            margin: 10px auto 40px;
            background-color: #6c757d;
            color: white;
            padding: 12px 26px;
            font-size: 16px;
            border-radius: 8px;
            text-decoration: none;
        }

        .back-button:hover {
            background-color: #5a6268;
        }

        @media screen and (max-width: 480px) {
            .payment-box {
                width: 90%;
                padding: 20px;
            }

            .qr-code img {
                width: 150px;
            }
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="left">Visitors Entry Pass Management System</div>
    <div class="right">
        <a href="visitorhome.jsp">Home</a>
        <a href="locations">Book Pass</a>
        <a href="MyBookingsServlet">My Bookings</a>
        <a href="submitFeedback">Give Feedback</a>
        <a href="profile">Profile</a>
        <a href="LogoutServlet" class="logout">Logout</a>
    </div>
</div>

<div class="payment-box">
    <h2>Complete Your Payment</h2>

    <p><strong>Email:</strong> ${email}</p>
    <p><strong>Location:</strong> ${locationName}</p>
    <p><strong>Total Passes:</strong> ${totalPasses}</p>
    <p><strong>Total Price:</strong> ₹<%= new DecimalFormat("#0.00").format((Double)request.getAttribute("totalPrice")) %></p>

    <div class="qr-code">
        <img src="https://api.qrserver.com/v1/create-qr-code/?data=upi://pay?pa=demo@upi&pn=DemoUser&am=<%= new DecimalFormat("#0.00").format((Double)request.getAttribute("totalPrice")) %>&cu=INR&size=200x200" alt="Scan to Pay">
        <p>Scan this QR code using PhonePe, Google Pay, or any UPI app to pay</p>
    </div>

    <form method="post" action="paymentServlet">
        <input type="hidden" name="bookingId" value="<%= request.getAttribute("bookingId") %>">
        <button type="submit">Pay Now</button>
    </form>
</div>

</body>
</html>

