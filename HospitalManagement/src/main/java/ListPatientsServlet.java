import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ListPatientsServlet")
public class ListPatientsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String username = "c##scott";
            String password = "tiger";

            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Establish the database connection
            Connection conn = DriverManager.getConnection(url, username, password);

            // Execute the query to retrieve patients
            Statement stmt = conn.createStatement();
            String query = "SELECT * FROM patients";
            ResultSet rs = stmt.executeQuery(query);

            // Generate the HTML table
            out.println("<table class='PatientTable' border='1'>");
            out.println("<tr><th>ID</th><th>Name</th><th>DOB</th><th>Gender</th><th>Blood Group</th><th>Email</th><th>Phone</th><th>Address</th></tr>");

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String dob = rs.getString("dob"); // dob as a string (YYYY-MM-DD)
                String gender = rs.getString("gender");
                String bloodGroup = rs.getString("blood_group");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");

                // Output the row
                out.println("<tr><td>" + id + "</td><td>" + name + "</td><td>" + dob + "</td><td>" + gender + "</td><td>" + bloodGroup + "</td><td>" + email + "</td><td>" + phone + "</td><td>" + address + "</td></tr>");
            }

            out.println("</table>");

            // Clean up resources
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
}
