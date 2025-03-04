<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="navbar.jsp" %>

<%
    String email = (String) session.getAttribute("email");
    String name = (String) session.getAttribute("name");

    // Doctor Data
    String[][] doctors = {
        {"Dr. Anjali Mehra", "Cardiology", "MBBS, MD (Cardiology)", "12 years"},
        {"Dr. Rohan Deshmukh", "Orthopedics", "MBBS, MS (Orthopedics)", "8 years"},
        {"Dr. Kavita Sharma", "Pediatrics", "MBBS, MD (Pediatrics)", "10 years"},
        {"Dr. Arjun Nair", "Neurology", "MBBS, DM (Neurology)", "15 years"},
        {"Dr. Priya Chatterjee", "Dermatology", "MBBS, MD (Dermatology)", "6 years"},
        {"Dr. Rajeev Gupta", "General", "MBBS", "20 years"},
        {"Dr. Sneha Iyer", "Gynecology", "MBBS, MS (Gynecology)", "9 years"},
        {"Dr. Vishal Patel", "Oncology", "MBBS, MD (Oncology)", "13 years"},
        {"Dr. Meenakshi Rao", "Psychiatry", "MBBS, MD (Psychiatry)", "7 years"},
        {"Dr. Sandeep Verma", "ENT", "MBBS, MS (ENT)", "11 years"}
    };
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
        }

		.header {
		    color: #fff;
		    text-align: center;
		    padding: 20px 0; /* Keep padding for header height */
		    display: flex;
		    flex-direction: column;
		    justify-content: center; /* Vertically center header content */
		    align-items: center; /* Horizontally center header content */
		    background-color: transparent; /* Remove the blue background from the header */
		}
		
		.welcome-message {
		    font-size: 22px; /* Increased font size */
		    margin-top: 10px;
		    text-align: center;
		    color: #004080;
		    background-color: transparent; /* Ensure there's no background color */
		    padding: 10px 0; /* Add some padding above */
		}


        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 10px;
        }

        h1 {
            text-align: center;
            color: #004080;
            font-size: 32px;
            margin-bottom: 20px;
        }

        .doctor-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }

        .doctor-card {
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease;
        }

        .doctor-card:hover {
            transform: translateY(-10px);
        }
        
        .doctor-image {
		    display: flex;
		    justify-content: center; /* Center horizontally */
		    align-items: center; /* Center vertically */
		    height: 200px; /* Maintain the height for the image container */
		    overflow: hidden; /* Ensure the image doesn't overflow the container */
		}

        .doctor-image img {
            width: 100%;
            height: 200px;
            object-position: center top;
            object-fit: cover;
            transform: scale(0.9);
        }

        .doctor-details {
            padding: 20px;
        }

        .doctor-details h2 {
            font-size: 20px;
            margin: 10px 0;
            color: #004080;
        }

        .doctor-details p {
            margin: 5px 0;
            color: #555;
        }

        .appointment-btn {
            display: inline-block;
            margin-top: 15px;
            background-color: #0080ff;
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
            text-align: center;
            transition: background-color 0.3s;
        }

        .appointment-btn:hover {
            background-color: #005bb5;
        }
    </style>
    <script type="text/javascript">
        var isLoggedIn = <%= (email != null) ? "true" : "false" %>;
        if (!isLoggedIn) {
            window.location.href = "homePage.jsp";
        }
    </script>
</head>
<body>
    <div class="header">
        <h1>Welcome to the Patient Dashboard</h1>
        <div class="welcome-message">
            <% if (name != null) { %>
                Hello, <%= name %>!
            <% } else { %>
                Welcome, Patient!
            <% } %>
        </div>
    </div>
    
    <div class="container">
        <h1>Our Specialist Doctors</h1>
        <div class="doctor-grid">
            <% for (int i = 0; i < doctors.length; i++) { %>
                <div class="doctor-card">
                    <div class="doctor-image">
                        <img src="images/doctor-<%= i+1 %>.jpg" alt="Doctor Image">
                    </div>
                    <div class="doctor-details">
                        <h2><%= doctors[i][0] %></h2>
                        <p><strong>Speciality:</strong> <%= doctors[i][1] %></p>
                        <p><strong>Qualification:</strong> <%= doctors[i][2] %></p>
                        <p><strong>Experience:</strong> <%= doctors[i][3] %></p>
                        <a href="booking/bookingPage_<%= i+1 %>.jsp" class="appointment-btn">Book Appointment</a>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
