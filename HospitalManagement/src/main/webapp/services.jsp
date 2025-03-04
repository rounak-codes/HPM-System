<%@ page import="java.sql.*" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Services</title>
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

        .welcome-message {
            position: absolute;
            top: 30px;
            font-size: 16px;
            color: #333;
            font-weight: bold;
            margin-left: 80px; /* Adds space from the toggle button */
        }

        body, html {
            margin: 0;
            padding: 0;
        }

        .container h1 {
            font-size: 2em;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Blood Bank Contact Information</h1>
        <table>
            <tr>
                <th>Id</th>
                <th>Name</th>
                <th>Contact Number</th>
                <th>Address</th>
            </tr>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "c##scott", "tiger");
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM blood_bank");

                    if (!rs.isBeforeFirst()) {
                        out.println("<tr><td colspan='4' style='text-align:center;'>No data available</td></tr>");
                    }

                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("contact_number") %></td>
                <td><%= rs.getString("address") %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
                }
            %>
        </table>

        <h1>Medical Lab Tests</h1>
        <table>
            <tr>
                <th>Test Name</th>
                <th>Price</th>
            </tr>
            <%
                Connection conn2 = null;
                Statement stmt2 = null;
                ResultSet rs2 = null;

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn2 = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "c##scott", "tiger");
                    stmt2 = conn2.createStatement();
                    rs2 = stmt2.executeQuery("SELECT * FROM lab_tests");

                    if (!rs2.isBeforeFirst()) {
                        out.println("<tr><td colspan='2' style='text-align:center;'>No data available</td></tr>");
                    }

                    while (rs2.next()) {
            %>
            <tr>
                <td><%= rs2.getString("test_name") %></td>
                <td><%= rs2.getBigDecimal("price") %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    if (rs2 != null) try { rs2.close(); } catch (Exception e) { e.printStackTrace(); }
                    if (stmt2 != null) try { stmt2.close(); } catch (Exception e) { e.printStackTrace(); }
                    if (conn2 != null) try { conn2.close(); } catch (Exception e) { e.printStackTrace(); }
                }
            %>
        </table>

        <form action="billinginfo.jsp" method="get">
            <button class="bill-button" type="submit">Proceed to Billing</button>
        </form>

        <a href="patientDashboard.jsp" class="back-btn">Back to Services</a>
    </div>
</body>
</html>
