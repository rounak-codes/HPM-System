import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;

@WebServlet("/DeleteDoctorServlet")
public class DeleteDoctorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int doctorId = Integer.parseInt(request.getParameter("doctor_id"));

        try {
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String username = "c##scott";
            String dbPassword = "tiger";

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(url, username, dbPassword);

            String query = "DELETE FROM doctor WHERE doctor_id=?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, doctorId);

            pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            response.sendRedirect("listDoctors.jsp"); // Redirect to doctor list page
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
}
