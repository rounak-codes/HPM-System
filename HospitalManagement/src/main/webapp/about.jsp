<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        	background-image: url("images/DoctorsTeam.jpg");
        	background-size: cover;
        	background-position: center;
        	background-repeat: no-repeat;
        }
        h1 {
            text-align: center;
            color: #2c3e50;
            margin-top: 40px;
        }
        .about-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        p {
            font-size: 16px;
            line-height: 1.6;
            color: #2c3e50;
        }
    </style>
</head>
<body>
    <%
        // Check if patient is logged in
        if (session.getAttribute("email") != null) {
    %>
        <!-- Patient is logged in, include navbar for logged-in patients -->
        <jsp:include page="navbar.jsp" />
    <% 
        } else {
    %>
        <!-- Patient is not logged in, include homeNavbar -->
        <jsp:include page="homeNavbar.jsp" />
    <% 
        }
    %>

    <h1>About Us</h1>
    <div class="about-container">
        <p>
            Welcome to our healthcare platform! We are committed to providing the best services to our patients,
            doctors, and administrators. Our goal is to make healthcare more accessible and efficient for everyone.
        </p>
        <p>
            Our platform connects patients with healthcare providers in a seamless manner. Whether you are a patient
            looking for medical assistance, a doctor seeking to manage patient records, or an administrator overseeing
            the system, we have tailored solutions to meet your needs.
        </p>
    </div>
</body>
</html>
