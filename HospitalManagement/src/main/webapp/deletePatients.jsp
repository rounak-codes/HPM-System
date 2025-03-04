<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Patient</title>
</head>
<body>
    <h1>Delete Patient</h1>

    <%
        String patientId = request.getParameter("id");
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        String username = "c##scott";
        String password = "tiger";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, username, password);

            // Use prepared statement to prevent SQL injection
            String query = "DELETE FROM patients WHERE id = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(patientId));
            stmt.executeUpdate();

            // Redirect to the patient list page after deletion
            response.sendRedirect("ManagePatients.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
