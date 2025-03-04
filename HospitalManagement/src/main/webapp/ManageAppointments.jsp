<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="adminnavbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f9f9f9; /* Light gray */
            color: #333; /* Dark gray text */
        }

        h1 {
            text-align: center;
            margin-top: 20px;
            color: #2c3e50; /* Dark blue */
        }

        .main-content {
            margin: 0 auto;
            padding: 20px;
            max-width: 90%;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Add slight shadow */
        }

        table thead {
            background-color: #34495e; /* Blue header */
            color: #ffffff; /* White text */
        }

        table th, table td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd; /* Light gray border */
        }

        table tr:nth-child(even) {
            background-color: #f2f2f2; /* Alternate row background */
        }

        a {
            text-decoration: none;
            color: #3498db;
            font-weight: bold;
        }

        .action-link {
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
            text-transform: uppercase;
            display: inline-block;
            margin-right: 5px;
        }

        .add-appointment {
            display: block;
            width: max-content;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #3498db; /* Blue for button */
            color: white;
            text-align: center;
            text-transform: uppercase;
            font-weight: bold;
            border-radius: 4px;
        }

        .add-appointment:hover {
            background-color: #2980b9;
        }

        .error-message {
            color: red;
            text-align: center;
            font-weight: bold;
        }
    </style>
    <title>Appointment List</title>
</head>
<body>
    <h1>Appointment List</h1>

    <div class="main-content">
        <table>
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
                    String url = "jdbc:oracle:thin:@localhost:1521:xe";
                    String username = "c##scott";
                    String password = "tiger";

                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection conn = DriverManager.getConnection(url, username, password);

                        String query = "SELECT * FROM appointments";
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(query);

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
                                <td>
                                    <a href="UpdateAppointment.jsp?id=<%= id %>" class="action-link update">Update</a>
                                    <a href="DeleteAppointmentServlet?id=<%= id %>" class="action-link delete">Delete</a>
                                </td>
                            </tr>
                <%
                        }

                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                %>
                    <tr>
                        <td colspan="8" class="error-message">Error: <%= e.getMessage() %></td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <a href="FetchDoctorsServlet" class="add-appointment">Add New Appointment</a>
    </div>
</body>
</html>
