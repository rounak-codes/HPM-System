import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;

@WebServlet("/AddAppointmentServlet")
public class AddAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String doctorName = request.getParameter("doctor_name");
        String patientName = request.getParameter("patient_name");
        String patientEmail = request.getParameter("patient_email");
        String appointmentTime = request.getParameter("appointment_time");
        String appointmentDate = request.getParameter("appointment_date");

        try {
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String username = "c##scott";
            String password = "tiger";

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(url, username, password);

            // Convert appointment date to SQL DATE
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date parsedDate = dateFormat.parse(appointmentDate);
            Date sqlAppointmentDate = new Date(parsedDate.getTime());

            // Insert query
            String query = "INSERT INTO appointments (doctor_name, patient_name, patient_email, appointment_time, appointment_date, created_at) VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, doctorName);
            pstmt.setString(2, patientName);
            pstmt.setString(3, patientEmail);
            pstmt.setString(4, appointmentTime);  // Appointment time is a VARCHAR, so just set the string
            pstmt.setDate(5, sqlAppointmentDate);  // Use Date object for appointment date

            pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            response.sendRedirect("ManageAppointments.jsp"); // Redirect to dashboard after adding
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
}
