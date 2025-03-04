import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateDoctorServlet
 */
@WebServlet("/UpdateDoctorServlet")
public class UpdateDoctorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int doctorId = Integer.parseInt(request.getParameter("doctor_id"));
        String doctorName = request.getParameter("doctor_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String speciality = request.getParameter("speciality");
        String qualification = request.getParameter("qualification");
        int experience = Integer.parseInt(request.getParameter("experience"));

        try {
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String username = "c##scott";
            String dbPassword = "tiger";

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(url, username, dbPassword);

            String query = "UPDATE doctor SET doctor_name = ?, email = ?, password = ?, speciality = ?, qualification = ?, experience = ? WHERE doctor_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, doctorName);
            pstmt.setString(2, email);
            pstmt.setString(3, password);
            pstmt.setString(4, speciality);
            pstmt.setString(5, qualification);
            pstmt.setInt(6, experience);
            pstmt.setInt(7, doctorId);

            pstmt.executeUpdate();

            pstmt.close();
            conn.close();

            response.sendRedirect("ManageDoctors.jsp"); // Redirect to doctor list page

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
}
