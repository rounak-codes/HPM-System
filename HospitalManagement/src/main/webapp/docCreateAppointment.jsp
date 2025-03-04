<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Appointment</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            color: #333;
        }

        h2 {
            text-align: center;
            margin-top: 50px;
            color: #444;
        }

        .form-container {
            max-width: 600px;
            margin: 20px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        label {
            font-weight: bold;
            color: #555;
            margin-bottom: 5px;
            display: block;
        }

        select, input[type="text"], input[type="email"], input[type="time"], input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        input[type="email"]:read-only {
            background-color: #f1f1f1;
            cursor: not-allowed;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            font-size: 16px;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group:last-child {
            margin-bottom: 0;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }
        
        .button-group {
            text-align: center;
            margin-top: 20px;
        }
        
		input[type="submit"], 
        .cancel-button {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            text-transform: uppercase;
            margin: 5px;
            text-decoration: none;
            display: inline-block;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        .cancel-button {
            background-color: #e74c3c;
        }

        .cancel-button:hover {
            background-color: #c0392b;
        }        
    </style>
    <script>
        // Create patientEmails object from JSP attribute
        var patientEmails = {	    		
            <% @SuppressWarnings (value="unchecked") 
                Map<String, String> patientEmailsMap = (Map<String, String>) request.getAttribute("patientEmails");
                if (patientEmailsMap != null) {
                    for (Map.Entry<String, String> entry : patientEmailsMap.entrySet()) {
            %>
                "<%= entry.getKey() %>": "<%= entry.getValue() %>",
            <% 
                    }
                }
            %>
        };

        // Debugging: Log patientEmails to the console
        console.log(patientEmails);
        
        function autofillEmail() {
            var selectedPatient = document.getElementById("patient_name").value;
            var emailField = document.getElementById("patient_email");

            // If the selected patient has an email, autofill it
            if (selectedPatient && patientEmails[selectedPatient]) {
                emailField.value = patientEmails[selectedPatient];
            } else {
                emailField.value = ""; // Clear the email field if no patient is selected
            }
        }
    </script>
</head>
<body>
    <h2>Add New Appointment</h2>
    <div class="form-container">
        <form action="AddAppointmentServlet" method="post">
            <!-- Doctor Dropdown -->
            <div class="form-group">
                <label for="doctor_name">Doctor Name</label>
                <select id="doctor_name" name="doctor_name" required>
                    <%  @SuppressWarnings (value="unchecked")
                        List<String> doctorNames = (List<String>) request.getAttribute("doctorNames");
                        if (doctorNames != null) {
                            for (String doctorName : doctorNames) {
                    %>
                            <option value="<%= doctorName %>"><%= doctorName %></option>
                    <% 
                        }
                    } else { 
                    %>
                    <option value="">No doctors available</option>
                    <% } %>
                </select>
            </div>

            <!-- Patient Dropdown -->
            <div class="form-group">
                <label for="patient_name">Patient Name</label>
                <select id="patient_name" name="patient_name" onchange="autofillEmail()">
                    <option value="">Select Patient</option>
                    <%  @SuppressWarnings (value="unchecked")
                        List<String> patientNames = (List<String>) request.getAttribute("patientNames");
                        for (String name : patientNames) {
                    %>
                        <option value="<%= name %>"><%= name %></option>
                    <% 
                        }
                    %>
                </select>
            </div>

            <!-- Patient Email (readonly, auto-filled) -->
            <div class="form-group">
                <label for="patient_email">Patient Email</label>
                <input type="email" id="patient_email" name="patient_email" required readonly>
            </div>

            <!-- Appointment Time -->
            <div class="form-group">
                <label for="appointment_time">Appointment Time</label>
                <input type="time" id="appointment_time" name="appointment_time" min="10:00" max="20:00" required>
            </div>

            <%
                // Get the current date and format it as YYYY-MM-DD
                java.time.LocalDate currentDate = java.time.LocalDate.now();
                String formattedDate = currentDate.toString();
            %>

            <!-- Appointment Date -->
            <div class="form-group">
                <label for="appointment_date">Appointment Date</label>
                <input type="date" id="appointment_date" name="appointment_date" required min="<%= formattedDate %>">
            </div>

            <div class="button-group">
                <input type="submit" value="Add Doctor">
                <a href="ManageAppointments.jsp" class="cancel-button">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
