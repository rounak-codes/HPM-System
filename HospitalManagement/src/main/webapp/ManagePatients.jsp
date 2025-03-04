<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %> 
<%@ include file="adminnavbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Patients</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #f9f9f9; /* Light gray */
            color: #333; /* Dark gray text */
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #444;
            margin-bottom: 20px;
        }

        .PatientTable {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .PatientTable th, .PatientTable td {
            border: 1px solid #ddd;
            padding: 12px 15px;
            text-align: center;
        }

        .PatientTable th {
            background-color: #34495e;
            color: white;
            font-weight: bold;
        }

        .PatientTable tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .PatientTable tr:hover {
            background-color: #f1f1f1;
        }

        .actions a {
            text-decoration: none;
            padding: 6px 10px;
            border-radius: 5px;
            margin: 0 2px;
            color: #fff;
            font-size: 14px;
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
        
    </style>
</head>
<body>
    <div class="container">
        <h1>Manage Patients</h1>

        <!-- Patient List Table -->
        <table class="PatientTable">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>DOB</th>
                <th>Gender</th>
                <th>Blood Group</th>
                <th>Email</th>
                <th>Password</th>
                <th>Phone</th>
                <th>Address</th>
                <th>Actions</th>
            </tr>

            <%
                // Fetch patient data from database
                String url = "jdbc:oracle:thin:@localhost:1521:xe";
                String username = "c##scott";
                String password = "tiger";

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection conn = DriverManager.getConnection(url, username, password);
                    Statement stmt = conn.createStatement();
                    String query = "SELECT * FROM patients";
                    ResultSet rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        String dob = rs.getString("dob");
                        String gender = rs.getString("gender");
                        String bloodGroup = rs.getString("blood_group");
                        String email = rs.getString("email");
                        String pass = rs.getString("password");
                        String phone = rs.getString("phone");
                        String address = rs.getString("address");
            %>

            <tr>
                <td><%= id %></td>
                <td><%= name %></td>
                <td><%= dob %></td>
                <td><%= gender %></td>
                <td><%= bloodGroup %></td>
                <td><%= email %></td>
                <td><%= pass %></td>
                <td><%= phone %></td>
                <td><%= address %></td>
                <td class="action-buttons">
                    <a href="UpdatePatients.jsp?id=<%= id %>" class="edit">Update</a>
                    <a href="deletePatients.jsp?id=<%= id %>" class="delete">Delete</a>
                </td>
            </tr>

            <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            %>
        </table>
        <a href="CreatePatient.jsp" class="add-new">Add New Patient</a>
    </div>
</body>
</html>
