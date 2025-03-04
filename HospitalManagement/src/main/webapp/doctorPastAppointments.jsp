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
    <title>View Past Appointments</title>
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
        background: url('images/loginBG.jpg') no-repeat center center fixed;
        background-size: cover;
        filter: blur(8px);
        z-index: -1;
      }

      /* Main content styles */
      h1 {
        text-align: center;
        color: #fff;
        margin-top: 20px;
      }

      .appointments-table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: rgba(255, 255, 255, 0.9);
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
      }

      .appointments-table th,
      .appointments-table td {
        padding: 12px;
        border: 1px solid #ddd;
        text-align: center;
        font-size: 14px;
      }

      .appointments-table th {
        background-color: #3498db;
        color: #fff;
        text-transform: uppercase;
        letter-spacing: 1px;
      }

      .appointments-table tr:hover {
        background-color: #f1f1f1;
      }

      .no-appointments {
        text-align: center;
        color: #fff;
        margin-top: 20px;
      }
    </style>
  </head>
  <body>
    <h1>Past Appointments</h1>

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

                // Query to fetch past appointments for the doctor (appointments before today)
                String query = "SELECT patient_name, patient_email, appointment_date, appointment_time FROM appointments WHERE doctor_name = ? AND appointment_date < CURRENT_DATE";
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
              <td colspan="4">No past appointments found.</td>
            </tr>
            <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<tr><td colspan='4'>An error occurred while fetching past appointments: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            }
        } else {
            %>
            <tr>
              <td colspan="4">You are not logged in as a doctor. Please log in to view past appointments.</td>
            </tr>
            <%
        }
        %>
    </table>
  </body>
</html>
