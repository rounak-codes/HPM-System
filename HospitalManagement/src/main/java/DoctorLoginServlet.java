import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DoctorLoginServlet")
public class DoctorLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Load the database driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Establish the database connection
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "c##scott", "tiger");

            // Prepare the SQL statement to check the doctor credentials
            String sql = "SELECT * FROM doctor WHERE email = ? AND password = ?";
            statement = conn.prepareStatement(sql);
            statement.setString(1, email);
            statement.setString(2, password); // NOTE: For better security, hash the password

            // Execute the SQL statement
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Login successful, store doctor info in the session
                HttpSession session = request.getSession(true);
                session.setAttribute("email", email);
                session.setAttribute("doctor_name", resultSet.getString("doctor_name"));
                session.setAttribute("speciality", resultSet.getString("speciality"));
                session.setAttribute("doctor_id", resultSet.getInt("doctor_id"));
                // Redirect to doctorDashboard.jsp
                response.sendRedirect("doctorDashboard.jsp");
            } else {
                // Login failed, set error message and redirect to login.jsp
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("doctorLogin.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database driver not found.");
            request.getRequestDispatcher("doctorLogin.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database connection error.");
            request.getRequestDispatcher("doctorLogin.jsp").forward(request, response);
        } finally {
            // Ensure resources are closed
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
