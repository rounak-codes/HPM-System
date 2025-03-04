import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateAppointmentServlet")
public class UpdateAppointmentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String doctorName = request.getParameter("doctor_name");
        String patientName = request.getParameter("patient_name");
        String patientEmail = request.getParameter("patient_email");
        String appointmentTime = request.getParameter("appointment_time");
        String appointmentDate = request.getParameter("appointment_date"); // Expecting format: YYYY-MM-DD

        try {
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String username = "c##scott";
            String password = "tiger";

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(url, username, password);

            // Updated query to use TO_DATE for date conversion
            String query = "UPDATE appointments SET doctor_name=?, patient_name=?, patient_email=?, appointment_time=?, appointment_date=TO_DATE(?, 'YYYY-MM-DD') WHERE id=?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, doctorName);
            pstmt.setString(2, patientName);
            pstmt.setString(3, patientEmail);
            pstmt.setString(4, appointmentTime);
            pstmt.setString(5, appointmentDate); // Pass date as string in 'YYYY-MM-DD' format
            pstmt.setInt(6, id);

            pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            response.sendRedirect("ManageAppointments.jsp"); // Redirect to dashboard after updating
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
}
