<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page session="false" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String doctorName = "", patientName = "", patientEmail = "", appointmentTime = "", appointmentDate = "";

    try {
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        String username = "c##scott";
        String password = "tiger";
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection(url, username, password);
        String query = "SELECT * FROM appointments WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            doctorName = rs.getString("doctor_name");
            patientName = rs.getString("patient_name");
            patientEmail = rs.getString("patient_email");
            appointmentTime = rs.getString("appointment_time");
            appointmentDate = rs.getString("appointment_date");
        }

        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Appointment</title>
    <style>
        body {
            background-color: #f4f7f8;
            font-family: Arial, sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 20px 40px;
            width: 100%;
            max-width: 500px;
            margin: 50px auto;
        }

        h2 {
            text-align: center;
            color: #4CAF50;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin: 10px 0 5px;
            font-weight: bold;
        }

        input[type="text"], input[type="email"], input[type="time"], input[type="date"] {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
            outline: none;
        }

        input[type="text"]:focus, input[type="email"]:focus, input[type="time"]:focus, input[type="date"]:focus {
            border-color: #4CAF50;
        }

        .btn-container {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }

        input[type="submit"], .cancel-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
        }

        input[type="submit"]:hover, .cancel-btn:hover {
            background-color: #45a049;
        }

        .cancel-btn {
            background-color: #f44336;
        }

        .cancel-btn:hover {
            background-color: #e53935;
        }

        @media (max-width: 600px) {
            .container {
                padding: 10px 20px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="doctornavbar.jsp" %>
    <div class="container">
        <h2>Update Appointment</h2>
        <form action="docUpdateAppointmentsServlet" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            <label for="doctor_name">Doctor Name</label>
            <input type="text" id="doctor_name" name="doctor_name" value="<%= doctorName %>" required>
            
            <label for="patient_name">Patient Name</label>
            <input type="text" id="patient_name" name="patient_name" value="<%= patientName %>" required>
            
            <label for="patient_email">Patient Email</label>
            <input type="email" id="patient_email" name="patient_email" value="<%= patientEmail %>" required>
            
			<label for="appointment_time">Appointment Time</label>
			<input type="time" id="appointment_time" name="appointment_time" value="<%= appointmentTime %>" min="10:00" max="20:00" required>

			<%
			    java.time.LocalDate currentDate = java.time.LocalDate.now();
			%>
			<label for="appointment_date">Appointment Date</label>
			<input type="date" id="appointment_date" name="appointment_date" value="<%= appointmentDate %>" min="<%= currentDate %>" required>

            <div class="btn-container">
                <input type="submit" value="Update Appointment">
                <a href="doctorManageAppointments.jsp" class="cancel-btn">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
