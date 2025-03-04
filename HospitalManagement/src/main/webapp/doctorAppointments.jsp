<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ include file="doctornavbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>View Active Appointments</title>
    <style>
      /* Reset margin and padding */
      body, html {
        margin: 0;
        padding: 0;
        height: 100%;
        font-family: Arial, sans-serif;
      }

      /* Blurry background image */
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
        color: white;
        margin: 20px 0;
      }

      /* Table container */
      .appointments-table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: rgba(255, 255, 255, 0.95);
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        overflow: hidden;
      }

      .appointments-table th, .appointments-table td {
        padding: 12px 15px;
        border: 1px solid #ddd;
        text-align: center;
        font-size: 16px;
        color: #333;
      }

      .appointments-table th {
        background-color: #3498db;
        color: #fff;
        text-transform: uppercase;
        letter-spacing: 1px;
      }

      .appointments-table tr:nth-child(even) {
        background-color: #f2f2f2;
      }

      .appointments-table tr:hover {
        background-color: #dfe6e9;
      }

      .no-appointments {
        text-align: center;
        color: #fff;
        margin-top: 20px;
        font-size: 18px;
      }
    </style>
  </head>
  <body>
    <h1>Active Appointments</h1>

    <table class="appointments-table">
      <tr>
        <th>Patient Name</th>
        <th>Patient Email</th>
        <th>Appointment Date</th>
        <th>Appointment Time</th>
      </tr>
      <%
    // Get the doctor's name from the session
    String doctorName = (String) session.getAttribute("doctor_name");

    if (doctorName != null) {
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            // Load the Oracle JDBC Driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Establish database connection
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "c##scott", "tiger");

            // Query to fetch active appointments for the doctor
            String query = "SELECT patient_name, patient_email, appointment_date, appointment_time FROM appointments WHERE doctor_name = ? AND appointment_date >= CURRENT_DATE";
            pst = con.prepareStatement(query);
            pst.setString(1, doctorName);
            rs = pst.executeQuery();

            boolean hasRecords = false;
            while (rs.next()) {
                hasRecords = true;
                String patientName = rs.getString("patient_name");
                String patientEmail = rs.getString("patient_email");
                String appointmentDate = rs.getString("appointment_date");
                String appointmentTime = rs.getString("appointment_time");

                // Extract only the date part from appointment_date
                String appointmentDateOnly = appointmentDate.split(" ")[0];
      %>
                <tr>
                    <td><%= patientName %></td>
                    <td><%= patientEmail %></td>
                    <td><%= appointmentDateOnly %></td>
                    <td><%= appointmentTime %></td>
                </tr>
      <%
            }
            if (!hasRecords) {
      %>
                <tr>
                    <td colspan="4">No active appointments found.</td>
                </tr>
      <%
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<tr><td colspan='4'>An error occurred while fetching active appointments: " + e.getMessage() + "</td></tr>");
        } finally {
            if (rs != null) rs.close();
            if (pst != null) pst.close();
            if (con != null) con.close();
        }
    } else {
      %>
        <tr>
            <td colspan="4">You are not logged in as a doctor. Please log in to view active appointments.</td>
        </tr>
      <%
    }
      %>
    </table>
  </body>
</html>
