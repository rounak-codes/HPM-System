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
      body {
        font-family: Arial, sans-serif;
        padding: 0px;
        margin: 0;
        height: 100%;
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
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.3);
      }

      .appointments-table th, .appointments-table td {
        padding: 12px;
        border: 1px solid #ddd;
        text-align: center;
        font-size: 14px;
      }

      .appointments-table th {
        background-color: #3498db;
        color: #fff;
        font-weight: bold;
        text-transform: uppercase;
      }

      .appointments-table tr:nth-child(even) {
        background-color: #f9f9f9;
      }

      .appointments-table tr:hover {
        background-color: #f1f1f1;
      }

      .no-appointments {
        text-align: center;
        color: #fff;
        margin-top: 20px;
        font-size: 18px;
      }

      .main-content {
        margin-left: 0;
        padding: 0px;
        transition: margin-left 0.3s ease;
      }

      .main-content.active {
        margin-left: 250px;
      }
    </style>
  </head>
  <body class="main-content">
    <h1>All Appointments</h1>

    <table class="appointments-table">
      <thead>
        <tr>
          <th>Patient Name</th>
          <th>Patient Email</th>
          <th>Appointment Date</th>
          <th>Appointment Time</th>
        </tr>
      </thead>
      <tbody>
        <%
          // Retrieve doctor's name from the session
          String doctorName = (String) session.getAttribute("doctor_name");

          if (doctorName != null) {
              Connection con = null;
              PreparedStatement pst = null;
              ResultSet rs = null;

              try {
                  // Load the JDBC Driver and Connect to Database
                  Class.forName("oracle.jdbc.driver.OracleDriver");
                  con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "c##scott", "tiger");

                  // Query to fetch past appointments
                  String query = "SELECT patient_name, patient_email, appointment_date, appointment_time FROM appointments WHERE doctor_name = ?";
                  pst = con.prepareStatement(query);
                  pst.setString(1, doctorName);
                  rs = pst.executeQuery();

                  boolean hasAppointments = false;

                  while (rs.next()) {
                      hasAppointments = true;
                      String patientName = rs.getString("patient_name");
                      String patientEmail = rs.getString("patient_email");
                      String appointmentDate = rs.getString("appointment_date").split(" ")[0];
                      String appointmentTime = rs.getString("appointment_time");
        %>
                      <tr>
                          <td><%= patientName %></td>
                          <td><%= patientEmail %></td>
                          <td><%= appointmentDate %></td>
                          <td><%= appointmentTime %></td>
                      </tr>
        <%
                  }

                  if (!hasAppointments) {
        %>
                  <tr>
                      <td colspan="4" class="no-appointments">No appointments found.</td>
                  </tr>
        <%
                  }
              } catch (Exception e) {
                  e.printStackTrace();
        %>
                  <tr>
                      <td colspan="4" class="no-appointments">Error occurred while fetching appointments: <%= e.getMessage() %></td>
                  </tr>
        <%
              } finally {
                  if (rs != null) rs.close();
                  if (pst != null) pst.close();
                  if (con != null) con.close();
              }
          } else {
        %>
              <tr>
                  <td colspan="4" class="no-appointments">Please log in as a doctor to view past appointments.</td>
              </tr>
        <%
          }
        %>
      </tbody>
    </table>
  </body>
</html>
