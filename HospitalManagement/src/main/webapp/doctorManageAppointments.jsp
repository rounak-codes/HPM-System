<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="doctornavbar.jsp" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
      body {
        font-family: Arial, sans-serif;
        height: 100%;
        margin: 0;
        padding: 0px;
      }
      
      body::before {
        content: "";
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: url('images/loginBG.jpg') no-repeat center center/cover;
        filter: blur(8px);
        z-index: -1;
      }

      h1 {
        text-align: center;
        color: #fff;
        margin-bottom: 20px;
      }

      .appointments-table {
        width: 90%;
        margin: 0 auto;
        border-collapse: collapse;
        background-color: rgba(255, 255, 255, 0.9);
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
      }

      .appointments-table th, .appointments-table td {
        padding: 12px;
        border: 1px solid #ddd;
        text-align: center;
        font-size: 14px;
      }

      .appointments-table th {
        background-color: #3498db;
        color: white;
        text-transform: uppercase;
        font-weight: bold;
      }

      .appointments-table tr:nth-child(even) {
        background-color: #f2f2f2;
      }

      .appointments-table tr:hover {
        background-color: #ddd;
      }

      .add-appointment-btn {
        display: inline-block;
        padding: 12px 20px;
        margin: 20px auto;
        background-color: #28a745;
        color: white;
        text-align: center;
        text-decoration: none;
        border-radius: 5px;
        font-size: 16px;
        transition: background-color 0.3s ease;
        display: block;
        width: fit-content;
      }

      .add-appointment-btn:hover {
        background-color: #218838;
      }

      .action-links a {
        color: #007bff;
        text-decoration: none;
        margin: 0 5px;
        font-weight: bold;
      }

      .action-links a:hover {
        color: #0056b3;
        text-decoration: underline;
      }
    </style>
    <title>Appointment List</title>
</head>
<body>
    <h1>Appointment List</h1>

    <table class="appointments-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Doctor Name</th>
                <th>Patient Name</th>
                <th>Patient Email</th>
                <th>Appointment Date</th>
                <th>Appointment Time</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Get the logged-in doctor's name from the session
                String loggedInDoctor = (String) session.getAttribute("doctor_name");

                String url = "jdbc:oracle:thin:@localhost:1521:xe";
                String username = "c##scott";
                String password = "tiger";

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection conn = DriverManager.getConnection(url, username, password);

                    // Query appointments for the logged-in doctor
                    String query = "SELECT * FROM appointments WHERE doctor_name = ?";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, loggedInDoctor);
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String doctorName = rs.getString("doctor_name");
                        String patientName = rs.getString("patient_name");
                        String patientEmail = rs.getString("patient_email");
                        String appointmentDate = rs.getString("appointment_date").split(" ")[0]; // Extract only the date part
                        String appointmentTime = rs.getString("appointment_time");
                        Timestamp createdAt = rs.getTimestamp("created_at");
            %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= doctorName %></td>
                            <td><%= patientName %></td>
                            <td><%= patientEmail %></td>
                            <td><%= appointmentDate %></td>
                            <td><%= appointmentTime %></td>
                            <td><%= createdAt %></td>
                            <td class="action-links">
                                <a href="DoctorUpdateAppointment.jsp?id=<%= id %>">Update</a>
                                <a href="docDeleteAppointmentServlet?id=<%= id %>">Delete</a>
                            </td>
                        </tr>
            <%
                    }

                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </tbody>
    </table>

    <a href="docFetchDoctorsServlet" class="add-appointment-btn">Add New Appointment</a>
</body>
</html>
