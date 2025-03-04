<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="navbar.jsp" %> <!-- Including the navbar -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        h1 {
            text-align: left;
            color: #1E3A8A; /* Deep Blue */
            margin-bottom: 30px;
            font-size: 2.5em;
            text-transform: uppercase;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 40px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
            border-radius: 10px;
        }

        th, td {
            border: 1px solid #e0e0e0;
            padding: 16px;
            text-align: left;
            font-size: 1.1em;
        }

        th {
            background-color: #1E3A8A; /* Deep Blue */
            color: #fff;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f9fafb;
        }

        tr:hover {
            background-color: #e3e3e3;
        }

        .bill-button {
            background-color: #1E3A8A; /* Deep Blue */
            color: white;
            padding: 12px 20px;
            border: none;
            cursor: pointer;
            font-size: 18px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            margin-top: 20px;
            width: 200px;
            margin-left: auto;
            margin-right: auto;
            display: block;
        }

        .bill-button:hover {
            background-color: #2563EB; /* Lighter Blue */
        }

        .back-btn {
            background-color: #2563EB; /* Lighter Blue */
            color: white;
            padding: 12px 20px;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 20px;
            display: block;
            width: 200px;
            margin-left: auto;
            margin-right: auto;
            text-align: center;
        }

        .back-btn:hover {
            background-color: #1E3A8A; /* Deep Blue */
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Your Lab Test Bookings</h1>

    <%
        // Retrieve the email from session
        String email = (String) session.getAttribute("email");

        if (email == null) {
            out.println("<p>You are not logged in. Please log in to view your bookings.</p>");
        } else {
            // Database connection
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String username = "c##scott";
            String password = "tiger";

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection(url, username, password);

                // Query to fetch bookings based on user email
                String query = "SELECT * FROM lab_test_bookings WHERE patient_email = ?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, email);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    out.println("<table>");
                    out.println("<tr><th>Test(s)</th><th>Patient Name</th><th>Email</th><th>Phone</th></tr>");
                    do {
                        String tests = rs.getString("tests");
                        String patientName = rs.getString("patient_name");
                        String patientEmail = rs.getString("patient_email");
                        String patientPhone = rs.getString("patient_phone");

                        out.println("<tr>");
                        out.println("<td>" + tests + "</td>");
                        out.println("<td>" + patientName + "</td>");
                        out.println("<td>" + patientEmail + "</td>");
                        out.println("<td>" + patientPhone + "</td>");
                        out.println("</tr>");
                    } while (rs.next());
                    out.println("</table>");
                } else {
                    out.println("<p>No bookings found for this email.</p>");
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>

    <a href="patientDashboard" class="back-btn">Back to Dashboard</a>
</div>

</body>
</html>
