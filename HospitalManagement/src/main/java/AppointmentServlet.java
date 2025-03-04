
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/book-appointment")
public class AppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String doctorName = request.getParameter("doctor-name");
            String patientName = request.getParameter("name");
            String patientEmail = request.getParameter("email");
            Date appointmentDate = Date.valueOf(request.getParameter("date"));
            String appointmentTime = request.getParameter("time");
            
            // Ensure the appointment time is not null or empty
            if (appointmentTime == null || appointmentTime.trim().isEmpty()) {
                appointmentTime = "00:00:00"; // default time if no time is provided
            } else {
                appointmentTime = appointmentTime + ":00"; // Add seconds if not provided
            }

            Class.forName("oracle.jdbc.driver.OracleDriver");

            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "c##scott", "tiger");

            String sql = "INSERT INTO appointments (doctor_name, patient_name, patient_email, appointment_date, appointment_time) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, doctorName);
            statement.setString(2, patientName);
            statement.setString(3, patientEmail);
            statement.setDate(4, appointmentDate);
            statement.setString(5, appointmentTime); // Set time as a string

            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {
                request.getRequestDispatcher("Appointment_Confirmed.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Appointment booking failed. Please try again.");
                request.getRequestDispatcher("book-appointment.jsp").forward(request, response);
            }

            statement.close();
            conn.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().write("ClassNotFoundException: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("SQLException: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Exception: " + e.getMessage());
        }
    }
}