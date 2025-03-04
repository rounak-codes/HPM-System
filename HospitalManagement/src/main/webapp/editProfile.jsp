<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page isErrorPage="true" %>
<%@ page errorPage="error.jsp" %>
<%@ include file="navbar.jsp" %>
<%
    // Get session email
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

        // Handle profile form submission
        if (request.getParameter("submit") != null) {
            String name = request.getParameter("name");
            String dob = request.getParameter("dob");
            String bloodGroup = request.getParameter("bloodGroup");
            String phone = request.getParameter("phone");

            // Update profile details
            pst = con.prepareStatement("UPDATE patients SET name = ?, dob = ?, blood_group = ?, phone = ? WHERE email = ?");
            pst.setString(1, name);
            pst.setString(2, dob);
            pst.setString(3, bloodGroup);
            pst.setString(4, phone);
            pst.setString(5, email);
            int updatedRows = pst.executeUpdate();

            if (updatedRows > 0) {
                successMessage = "Profile updated successfully.";
            }

            if (pst != null) {
                pst.close();
            }
        }

        // Fetch current profile details to pre-fill the form
        pst = con.prepareStatement("SELECT * FROM patients WHERE email = ?");
        pst.setString(1, email);
        rs = pst.executeQuery();
        if (rs.next()) {
            String currentName = rs.getString("name");
            String currentDob = rs.getString("dob");
            String currentBloodGroup = rs.getString("blood_group");
            String currentPhoneNumber = rs.getString("phone");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <style>
        /* Matching styles from first file with modifications */
        body {
            font-family: Arial, sans-serif;
            background-color: #f1f8e9;
            margin: 0;
            padding: 0;
        }

        .container {
            margin-top: 00px;
            width: 80%; /* Increase width of the form */
            max-width: 900px; /* Set a maximum width */
            background-color: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        .form-group {
            margin-bottom: 20px;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        .alert {
            margin-bottom: 20px;
            font-size: 14px;
        }

        .navbar a {
            text-decoration: none;
        }

        .form-control {
            height: 40px; /* Adjust input height */
            font-size: 16px;
        }

        small {
            font-size: 12px;
        }

        a.btn-secondary {
            margin-top: 10px;
            text-align: center;
            display: block;
        }

        .change-password-form {
            display: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Edit Profile</h1>

        <!-- Profile Edit Form -->
        <form method="POST" action="">
            <div class="row">
                <div class="col-md-6 form-group">
                    <label for="name">Name</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%= currentName %>" required>
                </div>
                <div class="col-md-6 form-group">
                    <label for="dob">DOB</label>
                    <input type="date" class="form-control" id="dob" name="dob" value="<%= currentDob %>" required>
                </div>
            </div>
            <div class="row">
				<div class="col-md-6 form-group">
				    <label for="bloodGroup">Blood Group</label>
				    <select class="form-control" id="bloodGroup" name="bloodGroup" required>
				        <option value="A+" <%= currentBloodGroup.equals("A+") ? "selected" : "" %>>A+</option>
				        <option value="A-" <%= currentBloodGroup.equals("A-") ? "selected" : "" %>>A-</option>
				        <option value="B+" <%= currentBloodGroup.equals("B+") ? "selected" : "" %>>B+</option>
				        <option value="B-" <%= currentBloodGroup.equals("B-") ? "selected" : "" %>>B-</option>
				        <option value="O+" <%= currentBloodGroup.equals("O+") ? "selected" : "" %>>O+</option>
				        <option value="O-" <%= currentBloodGroup.equals("O-") ? "selected" : "" %>>O-</option>
				        <option value="AB+" <%= currentBloodGroup.equals("AB+") ? "selected" : "" %>>AB+</option>
				        <option value="AB-" <%= currentBloodGroup.equals("AB-") ? "selected" : "" %>>AB-</option>
				    </select>
				</div>
                <div class="col-md-6 form-group">
                    <label for="phoneNumber">Phone Number</label>
                    <input type="text" class="form-control" id="phoneNumber" name="phone" value="<%= currentPhoneNumber %>" required>
                </div>
            </div>
            <button type="submit" id="submit" name="submit" class="btn btn-primary">Update Profile</button>
            <br><br>
            <a href="patientDashboard.jsp" class="btn btn-secondary">Cancel</a>
            <br>
        </form>

        <!-- Change Password Button -->
        <button id="changePasswordBtn" class="btn btn-secondary" onclick="togglePasswordForm()">Change Password</button>

        <!-- Change Password Form -->
        <div class="change-password-form" id="changePasswordForm">
            <h2>Change Password</h2>
            <form method="POST" action="patientchangepassword.jsp">
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
                <button type="submit" class="btn btn-primary">Update Password</button>
                <a href="editProfile.jsp" class="btn btn-secondary">Cancel</a>
            </form>
        </div>

    </div>

    <script>
        function togglePasswordForm() {
            const form = document.getElementById('changePasswordForm');
            const btn = document.getElementById('changePasswordBtn');
            form.style.display = form.style.display === 'block' ? 'none' : 'block';
            btn.style.display = form.style.display === 'block' ? 'none' : 'inline-block';
        }
    </script>

<% 
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <div class="alert alert-danger">An error occurred: <%= e.getMessage() %></div>
<% } finally {
    try {
        if (con != null) {
            con.close();
        }
    } catch (SQLException se) {
        se.printStackTrace();
    }
} %>
</body>
</html>