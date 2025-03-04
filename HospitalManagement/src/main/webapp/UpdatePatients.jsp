<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Patient</title>
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
        input[type="date"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            height: 100px;
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

        .error {
            color: red;
            font-size: 14px;
            margin-top: 10px;
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
    <h1>Edit Patient</h1>
    
    <%
    String patientId = request.getParameter("id");
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    String username = "c##scott";
    String password = "tiger";
    
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, username, password);
        
        String query = "SELECT * FROM patients WHERE id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, Integer.parseInt(patientId));
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            String name = rs.getString("name");
            String dob = rs.getString("dob");
            String gender = rs.getString("gender");
            String bloodGroup = rs.getString("blood_group");
            String email = rs.getString("email");
            String passwordField = rs.getString("password");
            String phone = rs.getString("phone");
            String address = rs.getString("address");
    %>

    <form action="UpdatePatientServlet" method="post">
        <input type="hidden" name="id" value="<%= patientId %>">
        
        <label for="name">Name:</label>
        <input type="text" name="name" value="<%= name %>" required>
        
        <label for="dob">DOB:</label>
        <input type="date" name="dob" value="<%= dob %>" required>
        
        <label for="gender">Gender:</label>
        <input type="text" name="gender" value="<%= gender %>" required>
        
		<label for="blood_group">Blood Group:</label>
		<select name="blood_group" required>
		    <option value="A+" <%= bloodGroup.equals("A+") ? "selected" : "" %>>A+</option>
		    <option value="A-" <%= bloodGroup.equals("A-") ? "selected" : "" %>>A-</option>
		    <option value="B+" <%= bloodGroup.equals("B+") ? "selected" : "" %>>B+</option>
		    <option value="B-" <%= bloodGroup.equals("B-") ? "selected" : "" %>>B-</option>
		    <option value="O+" <%= bloodGroup.equals("O+") ? "selected" : "" %>>O+</option>
		    <option value="O-" <%= bloodGroup.equals("O-") ? "selected" : "" %>>O-</option>
		    <option value="AB+" <%= bloodGroup.equals("AB+") ? "selected" : "" %>>AB+</option>
		    <option value="AB-" <%= bloodGroup.equals("AB-") ? "selected" : "" %>>AB-</option>
		</select>
        
        <label for="email">Email:</label>
        <input type="email" name="email" value="<%= email %>" required>
        
        <label for="password">Password:</label>
        <input type="text" name="password" value="<%= passwordField %>" required>
        
        <label for="phone">Phone:</label>
        <input type="text" name="phone" value="<%= phone %>" required>
        
        <label for="address">Address:</label>
        <textarea name="address" required><%= address %></textarea>
        
        <div class="form-buttons">
            <button type="submit">Update Patient</button>
            <button type="button" class="cancel-btn" onclick="window.location.href='ManagePatients.jsp'">Cancel</button>
        </div>
    </form>

    <%
        }
    } catch (Exception e) {
        e.printStackTrace();
    %>
        <div class="error">Error: <%= e.getMessage() %></div>
    <%
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
