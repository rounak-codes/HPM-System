<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Doctor</title>
</head>
<body>
    <h1>Delete Doctor</h1>

    <%
        String doctorId = request.getParameter("doctor_id");

        if (doctorId != null) {
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String username = "c##scott";
            String password = "tiger";

            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection conn = DriverManager.getConnection(url, username, password);

                String query = "DELETE FROM doctor WHERE doctor_id = ?";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, Integer.parseInt(doctorId));

                pstmt.executeUpdate();
                pstmt.close();
                conn.close();

                // Redirect to the doctor list page after deletion
                response.sendRedirect("ManageDoctors.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
