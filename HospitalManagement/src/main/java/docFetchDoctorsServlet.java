import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/docFetchDoctorsServlet")
public class docFetchDoctorsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String> doctorNames = new ArrayList<>();
        List<String> patientNames = new ArrayList<>();
        Map<String, String> patientEmails = new HashMap<>(); // Map for patient name -> email

        try {
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String username = "c##scott";
            String password = "tiger";

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(url, username, password);

            // Fetch doctor names
            String doctorQuery = "SELECT doctor_name FROM doctor";
            PreparedStatement doctorStmt = conn.prepareStatement(doctorQuery);
            ResultSet doctorRs = doctorStmt.executeQuery();
            while (doctorRs.next()) {
                doctorNames.add(doctorRs.getString("doctor_name"));
            }
            doctorRs.close();
            doctorStmt.close();

            // Fetch patient names and emails
            String patientQuery = "SELECT name, email FROM patients";
            PreparedStatement patientStmt = conn.prepareStatement(patientQuery);
            ResultSet patientRs = patientStmt.executeQuery();
            while (patientRs.next()) {
                String name = patientRs.getString("name");
                String email = patientRs.getString("email");
                patientNames.add(name);
                patientEmails.put(name, email); // Store name-email pair
            }
            patientRs.close();
            patientStmt.close();

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Set attributes for doctor names, patient names, and emails
        request.setAttribute("doctorNames", doctorNames);
        request.setAttribute("patientNames", patientNames);
        request.setAttribute("patientEmails", patientEmails);

        getServletContext().getRequestDispatcher("/docCreateAppointment.jsp").forward(request, response);
    }
}

