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

@WebServlet("/ListDoctorsServlet")
public class ListDoctorsServlet extends HttpServlet {
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

            // Execute the query to retrieve doctors
            Statement stmt = conn.createStatement();
            String query = "SELECT doctor_id, doctor_name, speciality, qualification, experience FROM doctor"; // Adjusted query
            ResultSet rs = stmt.executeQuery(query);

            // Generate the HTML table
            out.println("<table class='DoctorTable' border='1'>");
            out.println("<tr><th>ID</th><th>Name</th><th>Specialization</th><th>Qualification</th><th>Experience</th></tr>");

            while (rs.next()) {
                int id = rs.getInt("doctor_id");
                String name = rs.getString("doctor_name");
                String speciality = rs.getString("speciality");
                String qualification = rs.getString("qualification");
                int experience = rs.getInt("experience");

                // Output the row
                out.println("<tr><td>" + id + "</td><td>" + name + "</td><td>" + speciality + "</td><td>" + qualification + "</td><td>" + experience + "</td></tr>");
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
