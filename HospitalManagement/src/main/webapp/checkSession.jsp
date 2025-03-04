<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Session Doctor Name Check</title>
</head>
<body>
    <%
        if (session != null) {
            String doctorName = (String) session.getAttribute("doctor_name");
            if (doctorName != null) {
                out.println("<p>Logged-in doctor: " + doctorName + "</p>");
            } else {
                out.println("<p>No doctor name found in session.</p>");
            }
        } else {
            out.println("<p>Session does not exist.</p>");
        }
    %>
</body>
</html>
