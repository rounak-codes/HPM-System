<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page session="false" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String doctorName = "", patientName = "", patientEmail = "", appointmentTime = "", appointmentDate = "";

    try {
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        String username = "c##scott";
        String password = "tiger";
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection(url, username, password);
        String query = "SELECT * FROM appointments WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            doctorName = rs.getString("doctor_name");
            patientName = rs.getString("patient_name");
            patientEmail = rs.getString("patient_email");
            appointmentTime = rs.getString("appointment_time");
            appointmentDate = rs.getString("appointment_date");
        }

        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Appointment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #555;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 5px;
            font-weight: bold;
            color: #444;
        }

        input[type="text"], input[type="email"], input[type="time"], input[type="date"] {
            padding: 10px;
            font-size: 16px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
        }
    </style>
    <script>
        // JavaScript to enforce time input between 10:00 AM and 8:00 PM
        window.onload = function() {
            var timeInput = document.getElementById("appointment_time");

            // Set the min and max time for the time input
            timeInput.setAttribute("min", "10:00");
            timeInput.setAttribute("max", "20:00");

            // Function to validate time selection
            function validateTime() {
                var timeValue = timeInput.value;

                // If the selected time is less than 10 AM or more than 8 PM, reset it
                if (timeValue < "10:00") {
                    timeInput.setCustomValidity("Please select a time after 10:00 AM");
                    timeInput.value = "10:00"; // Set the default time to 10:00
                } else if (timeValue > "20:00") {
                    timeInput.setCustomValidity("Please select a time before 8:00 PM");
                    timeInput.value = "20:00"; // Set the default time to 8:00 PM
                } else {
                    timeInput.setCustomValidity(""); // Clear any previous error message
                }
            }

            // Attach the event to validate time when the user changes it
            timeInput.addEventListener("input", validateTime);

            // Validate time on form submission as well
            var form = document.querySelector("form");
            form.onsubmit = function(event) {
                validateTime();
                if (!timeInput.checkValidity()) {
                    event.preventDefault(); // Prevent form submission if invalid
                }
            };
        };
    </script>
</head>
<body>
    <div class="container">
        <h2>Update Appointment</h2>
        <form action="UpdateAppointmentsServlet" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            
            <label for="doctor_name">Doctor Name</label>
            <input type="text" id="doctor_name" name="doctor_name" value="<%= doctorName %>" required>
            
            <label for="patient_name">Patient Name</label>
            <input type="text" id="patient_name" name="patient_name" value="<%= patientName %>" required>
            
            <label for="patient_email">Patient Email</label>
            <input type="email" id="patient_email" name="patient_email" value="<%= patientEmail %>" required>
            
            <label for="appointment_time">Appointment Time</label>
            <input type="time" id="appointment_time" name="appointment_time" value="<%= appointmentTime %>" min="10:00" max="20:00" required>
            
            <label for="appointment_date">Appointment Date</label>
            <input type="date" id="appointment_date" name="appointment_date" value="<%= appointmentDate %>" min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>

            <input type="submit" value="Update Appointment">
        </form>
        <a href="ManageAppointments.jsp" class="back-link">Cancel</a>
    </div>
</body>
</html>

