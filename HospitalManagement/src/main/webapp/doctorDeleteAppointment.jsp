<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Appointment</title>
</head>
<body>
    <h2>Delete Appointment</h2>
    <form action="docDeleteAppointmentServlet" method="post">
        <label>Appointment ID:</label>
        <input type="number" name="appointment_id" required><br>
        <button type="submit">Delete Appointment</button>
    </form>
    <br>
    <a href="doctorManageAppointments.jsp">Back to Dashboard</a>
</body>
</html>
