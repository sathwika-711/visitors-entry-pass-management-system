<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Visitor & Revenue Report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
            padding: 20px;
        }
        .report-header {
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
        }
        .table th {
            background: #f8f9fa;
        }
        .total-row {
            font-weight: bold;
            background: #f8f9fa;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="report-header">
            <h1>Visitor and Revenue Report</h1>
            <p class="mb-0">
                <c:choose>
                    <c:when test="${not empty sessionScope.period}">
                        ${sessionScope.period} Report
                    </c:when>
                    <c:otherwise>
                        Daily Report
                    </c:otherwise>
                </c:choose>
                - Generated on <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMM yyyy HH:mm" />
            </p>
        </div>

        <form method="get" action="generateReports" class="mb-4">
            <div class="row">
                <div class="col-md-4">
                    <label for="period" class="form-label">Select Report Period:</label>
                    <select name="period" id="period" class="form-select">
                        <option value="daily" ${sessionScope.period == "daily" ? "selected" : ""}>Daily Report</option>
                        <option value="weekly" ${sessionScope.period == "weekly" ? "selected" : ""}>Weekly Report</option>
                        <option value="monthly" ${sessionScope.period == "monthly" ? "selected" : ""}>Monthly Report</option>
                    </select>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary">Generate Report</button>
                </div>
            </div>
        </form>

        <div class="row mb-4">
            <div class="col-md-4">
                <div class="stats-card">
                    <h3>Total Locations</h3>
                    <div class="stats-value">
                        <c:choose>
                            <c:when test="${not empty sessionScope.totalLocations}">
                                ${sessionScope.totalLocations}
                            </c:when>
                            <c:otherwise>
                                0
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card">
                    <h3>Total Visitors</h3>
                    <div class="stats-value">
                        <c:choose>
                            <c:when test="${not empty sessionScope.totalVisitors}">
                                ${sessionScope.totalVisitors}
                            </c:when>
                            <c:otherwise>
                                0
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card">
                    <h3>Total Revenue</h3>
                    <div class="stats-value">
                        <c:choose>
                            <c:when test="${not empty sessionScope.totalRevenue && sessionScope.totalRevenue > 0}">
                                ₹<fmt:formatNumber value="${sessionScope.totalRevenue}" type="number" maxFractionDigits="2" />
                            </c:when>
                            <c:otherwise>
                                ₹0.00
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <div class="table-container">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>Location</th>
                        <th>Period</th>
                        <th>Total Visitors</th>
                        <th>Total Revenue</th>
                        <th>Average Revenue per Visitor</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty sessionScope.reportData}">
                        <c:forEach var="row" items="${sessionScope.reportData}">
                            <tr>
                                <td>${row.location_name}</td>
                                <td>${row.report_period}</td>
                                <td>${row.total_visitors}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${row.total_revenue > 0}">
                                            ₹<fmt:formatNumber value="${row.total_revenue}" type="number" maxFractionDigits="2" />
                                        </c:when>
                                        <c:otherwise>
                                            ₹0.00
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${row.total_visitors > 0}">
                                            ₹<fmt:formatNumber value="${row.total_revenue / row.total_visitors}" type="number" maxFractionDigits="2" />
                                        </c:when>
                                        <c:otherwise>
                                            ₹0.00
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <tr class="total-row">
                        <td colspan="2"><strong>Total</strong></td>
                        <td>
                            <strong>
                                <c:choose>
                                    <c:when test="${not empty sessionScope.totalVisitors}">
                                        ${sessionScope.totalVisitors}
                                    </c:when>
                                    <c:otherwise>
                                        0
                                    </c:otherwise>
                                </c:choose>
                            </strong>
                        </td>
                        <td>
                            <strong>
                                <c:choose>
                                    <c:when test="${not empty sessionScope.totalRevenue && sessionScope.totalRevenue > 0}">
                                        ₹<fmt:formatNumber value="${sessionScope.totalRevenue}" type="number" maxFractionDigits="2" />
                                    </c:when>
                                    <c:otherwise>
                                        ₹0.00
                                    </c:otherwise>
                                </c:choose>
                            </strong>
                        </td>
                        <td>
                            <strong>
                                <c:choose>
                                    <c:when test="${not empty sessionScope.totalVisitors && sessionScope.totalVisitors > 0}">
                                        ₹<fmt:formatNumber value="${sessionScope.totalRevenue / sessionScope.totalVisitors}" type="number" maxFractionDigits="2" />
                                    </c:when>
                                    <c:otherwise>
                                        ₹0.00
                                    </c:otherwise>
                                </c:choose>
                            </strong>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
