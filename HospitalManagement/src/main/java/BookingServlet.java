
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Database connection details
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String username = "c##scott";
            String password = "tiger";

            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Establish the database connection
            Connection conn = DriverManager.getConnection(url, username, password);

            // Get form data
            String[] tests = request.getParameterValues("tests[]");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");

            // Insert data into the database
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO lab_test_bookings (tests, patient_name, patient_email, patient_phone) VALUES (?, ?, ?, ?)");
            stmt.setString(1, Arrays.toString(tests));
            stmt.setString(2, name);
            stmt.setString(3, email);
            stmt.setString(4, phone);
            stmt.executeUpdate();

            // Close the database connection
            stmt.close();
            conn.close();

            // Display thank you message
            request.getRequestDispatcher("Labtestdone.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head><title>Error</title></head>");
            out.println("<body>");
            out.println("<h1>Error: " + e.getMessage() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}