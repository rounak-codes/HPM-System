<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String email = (String) session.getAttribute("email");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Hospital Dashboard</title>
    <style>
        /* CSS for Stylish Single-Color Table Format */

        /* Table Styles */
        /* Table Styles */
		/* Table Styles */
/* Prevent overflow in the doctor's table */
		#doctorList {
		    overflow: hidden; /* Hide any overflow */
		}
		
		table {
		    width: auto; /* Tables adjust to their content's size */
		    margin: 0; /* Remove margin */
		    padding: 0; /* Remove padding */
		    border-collapse: collapse;
		    font-family: Arial, sans-serif;
		    background-color: #f3f3f3;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		    border: 1px solid #ccc;
		    table-layout: auto; /* Allow columns to resize based on content */
		}
		
		/* Table cells */
		th, td {
		    padding: 8px 10px; /* Smaller padding */
		    text-align: left;
		    border: 1px solid #ccc;
		    font-size: 14px; /* Smaller font size */
		    word-wrap: break-word; /* Break words if necessary */
		}
		
		/* Table header style */
		th {
		    background-color: #5cb85c; /* Green color */
		    color: white;
		    font-weight: bold;
		    text-transform: uppercase;
		    letter-spacing: 0.5px;
		}
		
		/* Alternate row colors for readability */
		tr:nth-child(even) {
		    background-color: #e6ffe6; /* Light green */
		}
		
		tr:hover {
		    background-color: #d4ffd4; /* Slightly darker green */
		}

        /* Optional: Add some styles for better readability */
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #f9f9f9; /* Light gray */
            color: #333; /* Dark gray text */
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
        }
        
        h1 {
            text-align: center;
            color: #5cb85c;
        }

        h2 {
            text-align: center;
            color: #5cb85c;
        }

        .button {
            display: inline-block;
            margin: 5px;
            padding: 8px 12px; /* Smaller padding for buttons */
            background-color: #5cb85c;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
        }

        .button:hover {
            background-color: #4cae4c;
        }

        .section {
            margin-bottom: 40px;
        }

        .actions {
            margin-bottom: 20px;
        }

        /* Aligning buttons to the right */
        .button-container {
            display: flex;
            justify-content: flex-end;
            gap: 10px; /* Spacing between the buttons */
        }

        /* Limit the number of rows to 10 */
        .limited-rows {
            max-height: 300px; /* Limit height for scrollable area */
            overflow-y: auto;
        }
        
        .logout-btn{position: absolute;
        align: right;
        top: 30px;
        right: 20px;
        background-color: red;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
        text-decoration: none;
      }
      
      .logout-btn:hover{
      	background-color: #8B0000;
      }
      
      .welcome-message {
        font-size: 16px;
        color: #333;
        font-weight: bold;
      }
    </style>
</head>
<body>
    <a href="logout.jsp" class="logout-btn">Logout</a>
      <div class="welcome-message"><h1><% if (email != null) { %>
          Welcome, <%= email %>!
        <% } else { %>
          Welcome, Patient!
        <% } %></h1>
        </div>
    <h2>Hospital Admin Dashboard</h2>
    
    <div class="section">
        <h2>Patients</h2>
        <div class="actions">
            <button class="button" onclick="createPatient()">Add Patient</button>
        </div>
        <div id="patientList" class="limited-rows"></div> <!-- Limit rows here -->
    </div>
    
    <div class="section">
        <h2>Doctors</h2>
        <div class="actions">
            <button class="button" onclick="createDoctor()">Add Doctor</button>
        </div>
        <div id="doctorList" class="limited-rows"></div> <!-- Limit rows here -->
    </div>
    
    <div class="section">
        <h2>Appointments</h2>
        <div class="actions">
            <button class="button" onclick="createAppointment()">Add Appointment</button>
        </div>
        <div id="appointmentList" class="limited-rows"></div> <!-- Limit rows here -->
    </div>
    
    <script>
        // Fetch patient list from the servlet
        fetch('/HospitalManagement/ListPatientsServlet')
            .then(response => response.text())
            .then(html => {
                document.getElementById('patientList').innerHTML = html;
            })
            .catch(error => console.error('Error:', error));
        
        // Fetch doctor list from the servlet
        fetch('/HospitalManagement/ListDoctorsServlet')
            .then(response => response.text())
            .then(html => {
                document.getElementById('doctorList').innerHTML = html;
            })
            .catch(error => console.error('Error:', error));
        
        // Fetch appointment list from the servlet
        fetch('/HospitalManagement/ListAppointmentsServlet')
            .then(response => response.text())
            .then(html => {
                document.getElementById('appointmentList').innerHTML = html;
            })
            .catch(error => console.error('Error:', error));

        // CRUD Operations for Patients
        function createPatient() {
            window.location.href = '/HospitalManagement/CreatePatient.jsp';
        }

        function updatePatient() {
            window.location.href = '/HospitalManagement/UpdatePatient.jsp';
        }

        function deletePatient() {
            window.location.href = '/HospitalManagement/DeletePatient.jsp';
        }

        // CRUD Operations for Doctors
        function createDoctor() {
            window.location.href = '/HospitalManagement/CreateDoctor.jsp';
        }

        function updateDoctor() {
            window.location.href = '/HospitalManagement/UpdateDoctor.jsp';
        }

        function deleteDoctor() {
            window.location.href = '/HospitalManagement/DeleteDoctor.jsp';
        }

        // CRUD Operations for Appointments
        function createAppointment() {
            window.location.href = '/HospitalManagement/CreateAppointment.jsp';
        }

        function updateAppointment() {
            window.location.href = '/HospitalManagement/UpdateAppointment.jsp';
        }

        function deleteAppointment() {
            window.location.href = '/HospitalManagement/DeleteAppointment.jsp';
        }
    </script>
    <br><br>
    <a href="homePage.jsp" class="button">Go to Homepage</a>
</body>
</html>
