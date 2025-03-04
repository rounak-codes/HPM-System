<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page isErrorPage="true" %>
<%
    String email = (String) session.getAttribute("email");
    String oldPassword = request.getParameter("oldPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");
    String errorMessage = null;
    String successMessage = null;

    Connection con = null;
    PreparedStatement pst = null;

    try {
        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Initialize database connection
        if (con == null || con.isClosed()) {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "c##scott", "tiger");
        }

        // Check if the old password is correct
        pst = con.prepareStatement("SELECT password FROM doctor WHERE email = ?");
        pst.setString(1, email);
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            String storedPassword = rs.getString("password");

            if (storedPassword.equals(oldPassword)) {
                if (newPassword.equals(confirmPassword)) {
                    // Update password in the database
                    pst = con.prepareStatement("UPDATE doctor SET password = ? WHERE email = ?");
                    pst.setString(1, newPassword);
                    pst.setString(2, email);
                    int rowsUpdated = pst.executeUpdate();

                    if (rowsUpdated > 0) {
                        successMessage = "Password updated successfully!";
                    } else {
                        errorMessage = "Failed to update the password.";
                    }
                } else {
                    errorMessage = "New password and confirmation do not match.";
                }
            } else {
                errorMessage = "Incorrect old password.";
            }
        } else {
            errorMessage = "Doctor profile not found.";
        }
    } catch (Exception e) {
        errorMessage = "An error occurred: " + e.getMessage();
        e.printStackTrace();
    } finally {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Change Password</title>
    <meta http-equiv="refresh" content="2;URL='doctorDashboard.jsp'" />
    <style>
        .success-message {
            color: green;
            font-size: 24px;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <% if (errorMessage != null) { %>
        <div style="color: red;"> <%= errorMessage %> </div>
    <% } %>
    <% if (successMessage != null) { %>
        <div class="success-message"> <%= successMessage %> </div>
    <% } %>
</body>
</html>