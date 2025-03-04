<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>View Bookings</title>
    <style>
      body {
        background: white;
        background-size: cover;
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
      }

      h1 {
        margin-top: 20px;
        text-align: center;
        color: #1E3A8A;
        font-size: 2.5em;
        text-transform: uppercase;
      }

      .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
      }

      .bookings-table {
        width: 100%;
        margin: 20px 0;
        border-collapse: collapse;
        background-color: rgba(255, 255, 255, 0.9);
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        overflow: hidden;
      }

      .bookings-table th, .bookings-table td {
        padding: 15px;
        border: 1px solid #ddd;
        text-align: center;
      }

      .bookings-table th {
        background-color: #1E3A8A;
        color: white;
        font-size: 1.1em;
      }

      .bookings-table td {
        background-color: #f9f9f9;
        font-size: 1.1em;
        color: #333;
      }

      .bookings-table tr:nth-child(even) td {
        background-color: #f2f2f2;
      }

      .bookings-table tr:hover td {
        background-color: #e2e2e2;
        cursor: pointer;
      }

      .no-bookings, .not-logged-in {
        text-align: center;
        color: #fff;
        font-size: 1.2em;
        margin-top: 20px;
        padding: 10px;
        background-color: rgba(0, 0, 0, 0.6);
        border-radius: 5px;
      }

      .alert {
        padding: 10px;
        margin-top: 20px;
        background-color: #f44336;
        color: white;
        font-size: 1.1em;
        border-radius: 5px;
      }

      /* Add some animation to the table rows */
      .bookings-table tr {
        transition: background-color 0.3s ease;
      }

      .bookings-table tr:hover {
        background-color: #d3ffd3;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1>Your Bookings</h1>

      <table class="bookings-table">
        <tr>
          <th>Doctor Name</th>
          <th>Appointment Date</th>
          <th>Appointment Time</th>
        </tr>

        <%
          // Get the email from the session
          String email = (String) session.getAttribute("email");

          if (email != null) {
              Connection con = null;
              PreparedStatement pst = null;
              ResultSet rs = null;

              try {
                  // Load the Oracle JDBC Driver
                  Class.forName("oracle.jdbc.driver.OracleDriver");

                  // Establish database connection
                  con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "c##scott", "tiger");

                  // Query to fetch bookings using patient_email
                  String query = "SELECT doctor_name, appointment_date, appointment_time FROM appointments WHERE patient_email = ? AND appointment_date >= CURRENT_DATE";
                  pst = con.prepareStatement(query);
                  pst.setString(1, email);
                  rs = pst.executeQuery();

                  boolean hasRecords = false;
                  while (rs.next()) {
                      hasRecords = true;
                      String doctorName = rs.getString("doctor_name");
                      String appointmentDate = rs.getString("appointment_date");
                      String appointmentTime = rs.getString("appointment_time");

                      // Extract only the date part from appointment_date
                      String appointmentDateOnly = appointmentDate.split(" ")[0];
        %>
                    <tr>
                        <td><%= doctorName %></td>
                        <td><%= appointmentDateOnly %></td>
                        <td><%= appointmentTime %></td>
                    </tr>
        <%
                  }
                  if (!hasRecords) {
        %>
                    <tr>
                        <td colspan="3" class="no-bookings">No bookings found.</td>
                    </tr>
        <%
                  }
              } catch (Exception e) {
                  e.printStackTrace();
                  out.println("<tr><td colspan='3' class='alert'>An error occurred while fetching bookings: " + e.getMessage() + "</td></tr>");
              } finally {
                  if (rs != null) rs.close();
                  if (pst != null) pst.close();
                  if (con != null) con.close();
              }
          } else {
        %>
            <tr>
                <td colspan="3" class="not-logged-in">You are not logged in. Please log in to view your bookings.</td>
            </tr>
        <% } %>
      </table>
    </div>
  </body>
</html>
