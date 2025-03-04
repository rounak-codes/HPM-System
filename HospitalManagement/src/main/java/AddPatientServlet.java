import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/AddPatientServlet")
public class AddPatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String bloodGroup = request.getParameter("blood-group");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        response.setContentType("text/html"); // Set response type to HTML for rendering
        PrintWriter out = response.getWriter(); // Get the PrintWriter object to print the error message

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Establish the database connection
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "c##scott", "tiger");

            // Prepare the SQL statement to insert the patient data
            String sql = "INSERT INTO patients (name, dob, gender, blood_group, email, password, phone, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, dob);
            statement.setString(3, gender);
            statement.setString(4, bloodGroup);
            statement.setString(5, email);
            statement.setString(6, password);
            statement.setString(7, phone);
            statement.setString(8, address);

            // Execute the SQL statement
            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {
                // Registration successful, redirect to welcome.jsp
                request.getRequestDispatcher("ManagePatients.jsp").forward(request, response);
            } else {
                // Registration failed, display an error message
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("patientRegistration.jsp").forward(request, response);
            }

            // Close the database resources
            statement.close();
            conn.close();
        } catch (ClassNotFoundException e) {
            // Print the error message for database driver not found
            e.printStackTrace();
            out.println("<h3>Error: Database driver not found. " + e.getMessage() + "</h3>");
        } catch (SQLException e) {
            // Print the error message for SQL exceptions
            e.printStackTrace();
            out.println("<h3>Error: A database error occurred: " + e.getMessage() + "</h3>");
        } catch (Exception e) {
            // Print any other unexpected error messages
            e.printStackTrace();
            out.println("<h3>Error: An unexpected error occurred: " + e.getMessage() + "</h3>");
        }
    }
}