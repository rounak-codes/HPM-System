
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LabTestServlet")
public class LabTestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<Test> tests = new ArrayList<>();
        
        try {
        	Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","c##scott","tiger");
            stmt = conn.prepareStatement("SELECT * FROM lab_tests");
            rs = stmt.executeQuery();
            while (rs.next()) {
                Test test = new Test();
                test.setId(rs.getInt("id"));
                test.setTestName(rs.getString("test_name"));
                test.setPrice(rs.getBigDecimal("price"));
                tests.add(test);
            }
            request.setAttribute("tests", tests);
            request.getRequestDispatcher("billingForm.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) { }
            if (stmt != null) try { stmt.close(); } catch (Exception e) { }
            if (conn != null) try { conn.close(); } catch (Exception e) { }
        }
    }
}
    

//    public class Test {
//        private int id;
//        private String testName;
//        private BigDecimal price;
//
//        // Getters
//        public int getId() {
//            return id;
//        }
//
//        public String getTestName() {
//            return testName;
//        }
//
//        public BigDecimal getPrice() {
//            return price;
//        }
//
//        // Setters
//        public void setId(int id) {
//            this.id = id;
//        }
//
//        public void setTestName(String testName) {
//            this.testName = testName;
//        }
//
//        public void setPrice(BigDecimal price) {
//            this.price = price;
//        }


