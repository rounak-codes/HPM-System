<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String email = (String) session.getAttribute("email");
%>
<%@ include file="adminnavbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            color: #333;
            margin: 0;
            padding: 0;
            overflow: hidden; /* Prevent scrolling due to background blur */
        }

        /* Background wrapper with blur effect */
        .background {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('images/registrationBG.jpeg'); /* Add your background image */
            background-size: cover;
            background-position: center;
            filter: blur(10px); /* Apply blur effect to the background */
            z-index: -1; /* Ensure it's behind the content */
        }

        /* Content wrapper */
        .content {
            position: relative;
            z-index: 1; /* Ensure content is above the blurred background */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        h1, h2 {
            text-align: center;
            color: blue; /* White text color for headings */
        }

        h1 {
            font-size: 36px;
            font-weight: bold;
        }

        h2 {
            font-size: 28px;
            margin-top: 20px;
        }

        .button {
            display: inline-block;
            margin: 15px;
            padding: 15px 25px;
            background-color: #007bff; /* Vibrant blue background */
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 123, 255, 0.3);
            transition: background-color 0.3s, transform 0.2s;
        }

        .button:hover {
            background-color: #0056b3; /* Darker blue on hover */
            transform: scale(1.05);
        }

        .button-container {
            display: flex;
            justify-content: center;
            flex-direction: row; /* Align buttons side by side */
            align-items: center;
            flex-wrap: wrap; /* Allow wrapping on smaller screens */
        }

        .button-container .button {
            width: 250px;
            margin: 20px; /* Adjust margin for spacing between buttons */
        }

        .welcome-message {
            font-size: 18px;
            color: blue;
            font-weight: bold;
            text-align: center;
        }

        .main-content {
            margin-left: 0;
            margin-top: 0;
            transition: 0.3s;
        }

        .main-content.active {
            margin-left: 250px;
        }

        /* For responsive design */
        @media (max-width: 768px) {
            .button-container {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <!-- Background container with blur effect -->
    <div class="background"></div>

    <!-- Content container -->
    <div class="content">
        <div class="welcome-message">
            <h1><% if (email != null) { %>
                Welcome, <%= email %>!
            <% } else { %>
                Welcome, Admin!
            <% } %></h1>
        </div>

        <h2>Admin Dashboard</h2>

        <div class="button-container">
            <a href="ManagePatients.jsp" class="button">Manage Patients</a>
            <a href="ManageDoctors.jsp" class="button">Manage Doctors</a>
            <a href="ManageAppointments.jsp" class="button">Manage Appointments</a>
        </div>
    </div>
</body>
</html>
