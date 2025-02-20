<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>COMP367 Welcome</title>
</head>
<body>
    <%
        Calendar cal = Calendar.getInstance();
        int hour = cal.get(Calendar.HOUR_OF_DAY);
        String timeOfDay = (hour < 12) ? "morning" : "afternoon";
        String name = "Gabriel"; 
    %>
    <h1>Good <%= timeOfDay %>, <%= name %>, Welcome to COMP367</h1>
</body>
</html>