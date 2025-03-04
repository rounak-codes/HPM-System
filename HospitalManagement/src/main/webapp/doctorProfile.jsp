<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page isErrorPage="true" %>
<%@ page errorPage="error.jsp" %>
<%@ include file="doctornavbar.jsp" %>
<%
    // Get session email (assuming the session holds the doctor's email)
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.jsp"); // Redirect if not logged in
        return;
    }

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    String errorMessage = null;
    String successMessage = null;

    // Initialize database connection
    try {
        if (con == null || con.isClosed()) {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "c##scott", "tiger");
        }

        if (request.getParameter("submit") != null) {
        	String doctorName = request.getParameter("doctorName");
            String experience = request.getParameter("experience");
            
            pst = con.prepareStatement("UPDATE doctor SET doctor_name = ?, experience = ? WHERE email = ?");
            pst.setString(1, doctorName);
            pst.setString(2, experience);
            pst.setString(3, email);
            int updatedRows = pst.executeUpdate();
            
            if (updatedRows > 0) {
                successMessage = "Profile updated successfully.";
            }

            if (pst != null) {
                pst.close();
            }
        }
        
        // Fetch doctor profile details
        pst = con.prepareStatement("SELECT doctor_id, doctor_name, email, password, speciality, qualification, experience FROM doctor WHERE email = ?");
        pst.setString(1, email);
        rs = pst.executeQuery();
        
        if (rs.next()) {
            String doctorId = rs.getString("doctor_id");
            String doctorName = rs.getString("doctor_name");
            String emailDb = rs.getString("email");
            String password = rs.getString("password");
            String speciality = rs.getString("speciality");
            String qualification = rs.getString("qualification");
            String experience = rs.getString("experience");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <style>
        body {
            background: url(images/edit.jpg);
            background-size: cover;
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 10px;
            max-width: 500px;
            background-color: #f2f2f2;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        .navbar {
            width: 100%;
            background-color: #3498db; /* Matching sidebar background */
            overflow: hidden;
            display: flex;
            justify-content: space-around; /* Space links evenly */
            align-items: center;
            padding: 10px 0;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
        }

        .navbar a {
            text-decoration: none;
            color: white;
            font-size: 18px;
            font-weight: bold;
            padding: 8px 16px;
            transition: background-color 0.3s, color 0.3s;
            border-radius: 5px;
        }

    </style>
</head>
<body>
    <div class="container">
        <h1>Edit Profile</h1>

        <form method="POST" action="">
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="doctorId">Doctor ID</label>
                    <input type="text" class="form-control" id="doctorId" name="doctorId" value="<%= doctorId %>" readonly>
                </div>
                <div class="form-group col-md-6">
                    <label for="doctorName">Doctor Name</label>
                    <input type="text" class="form-control" id="doctorName" name="doctorName" value="<%= doctorName %>" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%= emailDb %>" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="speciality">Speciality</label>
                    <input type="text" class="form-control" id="speciality" name="speciality" value="<%= speciality %>" readonly>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="qualification">Qualification</label>
                    <input type="text" class="form-control" id="qualification" name="qualification" value="<%= qualification %>" readonly>
                </div>
                <div class="form-group col-md-6">
                    <label for="experience">Experience</label>
                    <input type="text" class="form-control" id="experience" name="experience" value="<%= experience %>" required>
                </div>
            </div>

            <button type="submit" name="submit" class="btn btn-primary">Update</button>
            <a href="doctorDashboard.jsp" class="btn btn-secondary">Cancel</a>
        </form>

        <button class="btn btn-warning mt-3" id="changePasswordBtn" onclick="togglePasswordChangeForm()">Change Password</button>

        <!-- Password Change Form (Initially Hidden) -->
        <div id="passwordChangeForm" style="display:none; margin-top: 20px;">
            <form method="POST" action="doctorchangepassword.jsp">
                <div class="form-group">
                    <label for="oldPassword">Old Password</label>
                    <input type="password" class="form-control" id="oldPassword" name="oldPassword" required>
                </div>
                <div class="form-group">
                    <label for="newPassword">New Password</label>
                    <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm New Password</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                </div>
                <button type="submit" class="btn btn-success">Submit for Password Change</button>
            </form>
        </div>
    </div>

    <script>
        function togglePasswordChangeForm() {
            var form = document.getElementById('passwordChangeForm');
            form.style.display = (form.style.display === "none" || form.style.display === "") ? "block" : "none";
        }
    </script>
<%
        } else {
            errorMessage = "Doctor profile not found.";
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<div style='color: red;'>Error: " + e.getMessage() + "</div>");
    } finally {
        try {
            // Close ResultSet, PreparedStatement, and Connection in finally block
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<div style='color: red;'>Error: " + e.getMessage() + "</div>");
        }
    }
%>
</body>
</html>