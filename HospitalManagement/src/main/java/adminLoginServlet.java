
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

@WebServlet("/login")
public class adminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Establish the database connection
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","c##scott","tiger");

            // Prepare the SQL statement to check the user credentials
            String sql = "SELECT * FROM admins WHERE email = ? AND password = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, email);
            statement.setString(2, password);

            // Execute the SQL statement
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Login successful, redirect to patientDashboard.jsp
                request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
            } else {
                // Login failed, display an error message and redirect to login.jsp
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
                
                
            }

            // Close the database resources
            resultSet.close();
            statement.close();
            conn.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}