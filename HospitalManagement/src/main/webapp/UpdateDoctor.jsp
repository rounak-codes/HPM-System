<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Doctor</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        h1 {
            color: #4CAF50;
            margin-bottom: 20px;
            text-align: center;
        }

        form {
            background: #fff;
            padding: 20px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }

        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="email"],
        input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .form-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #45a049;
        }

        .cancel-btn {
            background-color: #f44336;
        }

        .cancel-btn:hover {
            background-color: #d32f2f;
        }

        @media (max-width: 600px) {
            form {
                padding: 20px;
            }

            .form-buttons {
                flex-direction: column;
                gap: 10px;
            }

            button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <h1>Edit Doctor</h1>
    
    <%
    String doctorId = request.getParameter("doctor_id");
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    String username = "c##scott";
    String password = "tiger";
    
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, username, password);
        
        String query = "SELECT * FROM doctor WHERE doctor_id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, Integer.parseInt(doctorId));
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            String doctorName = rs.getString("doctor_name");
            String email = rs.getString("email");
            String speciality = rs.getString("speciality");
            String qualification = rs.getString("qualification");
            int experience = rs.getInt("experience");
            String passwordField = rs.getString("password");
    %>

    <form action="UpdateDoctorServlet" method="post">
        <input type="hidden" name="doctor_id" value="<%= doctorId %>">
        
        <label for="doctor_name">Doctor Name:</label>
        <input type="text" name="doctor_name" value="<%= doctorName %>" required>
        
        <label for="email">Email:</label>
        <input type="email" name="email" value="<%= email %>" required>
        
        <label for="password">Password:</label>
        <input type="text" name="password" value="<%= passwordField %>" required>
        
        <label for="speciality">Speciality:</label>
        <input type="text" name="speciality" value="<%= speciality %>" required>
        
        <label for="qualification">Qualification:</label>
        <input type="text" name="qualification" value="<%= qualification %>" required>
        
        <label for="experience">Experience:</label>
        <input type="number" name="experience" value="<%= experience %>" required>
        
        <div class="form-buttons">
            <button type="submit">Update Doctor</button>
            <button type="button" class="cancel-btn" onclick="window.location.href='ManageDoctors.jsp'">Cancel</button>
        </div>
    </form>

    <%
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
    %>
</body>
</html>
