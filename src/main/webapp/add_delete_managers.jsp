<%@ page language="java" %>
<%
    int locationId = Integer.parseInt(request.getParameter("locationId"));
%>
<h2>Add Manager</h2>
<form action="manageManagers" method="post">
    <input type="hidden" name="locationId" value="<%= locationId %>" />

    Name: <input type="text" name="name" required /><br/>
    Email: <input type="email" name="email" required /><br/>
    Password: <input type="password" name="password" required /><br/>

    <input type="submit" value="Add Manager" />
</form>
