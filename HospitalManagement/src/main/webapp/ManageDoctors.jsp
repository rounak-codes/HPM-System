<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="adminnavbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin-top: 20px;
            color: #2c3e50;
        }

        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        table thead tr {
            background-color: #34495e;
            color: white;
        }

        table th, table td {
            text-align: center;
            padding: 10px;
            border: 1px solid #ddd;
        }

        table tbody tr:nth-child(odd) {
            background-color: #f9f9f9;
        }

        table tbody tr:nth-child(even) {
            background-color: #ffffff;
        }

        table tbody tr:hover {
            background-color: #f1f1f1;
        }

        a {
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            color: #2980j9;
        }

        .action-buttons a {
            margin: 0 5px;
        }

        .add-new {
            display: block;
            width: 200px;
            margin: 20px auto;
            text-align: center;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
        }

        .add-new:hover {
            background-color: #2980b9;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1>Doctor List</h1>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Specialty</th>
                <th>Qualification</th>
                <th>Experience</th>
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

                    String query = "SELECT doctor_id, doctor_name, speciality, qualification, experience FROM doctor ORDER BY doctor_id ASC";
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        int id = rs.getInt("doctor_id");
                        String name = rs.getString("doctor_name");
                        String speciality = rs.getString("speciality");
                        String qualification = rs.getString("qualification");
                        int experience = rs.getInt("experience");
            %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= name %></td>
                            <td><%= speciality %></td>
                            <td><%= qualification %></td>
                            <td><%= experience %></td>
                            <td class="action-buttons">
                                <a href="UpdateDoctor.jsp?doctor_id=<%= id %>">Update</a>
                                <a href="deleteDoctor.jsp?doctor_id=<%= id %>">Delete</a>
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
                        <td colspan="6" class="error-message">Error: <%= e.getMessage() %></td>
                    </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <a href="CreateDoctor.jsp" class="add-new">Add New Doctor</a>
</body>
</html>
