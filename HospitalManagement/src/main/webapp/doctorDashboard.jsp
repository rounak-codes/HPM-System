<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // Check if the session exists and contains the doctor's name
    if (session == null || session.getAttribute("doctor_name") == null) {
        // Redirect to the login page if the session or doctor_name is missing
        response.sendRedirect("doctorLogin.jsp");
        return;
    }
    // Fetch the doctor's name and ID from the session
    String doctorName = (String) session.getAttribute("doctor_name");
    String doctorId = String.valueOf(session.getAttribute("doctor_id")); // Assuming doctor_id is stored in session
%>
<%@ include file="doctornavbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Doctor Dashboard</title>
    <style>
      body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
      }

      /* Background with Blur effect */
      .background {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-image: url('images/doctorBG.jpg');
        background-size: cover;
        background-position: center;
        filter: blur(8px); /* Apply the blur effect */
        z-index: -1; /* Make sure it stays behind the content */
      }

      /* Body and content styles */
      body, html {
        margin: 0;
        padding: 0;
      }

      .header {
        margin: 0;
        padding: 20px;
        background-color: #3498db;
        color: #fff;
        text-align: center;
        font-size: 24px;
        font-weight: bold;
        position: relative;
      }

      .container {
        text-align: center;
        margin-top: 50px;
        position: relative;
        z-index: 1; /* Ensure content stays on top of background */
      }

      .doctor-image {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        object-fit: cover;
        margin-bottom: 20px;
      }

      .doctor-info {
        margin-bottom: 30px;
      }

      button {
        padding: 15px 30px;
        font-size: 18px;
        color: #fff;
        background-color: #2980b9;
        border: none;
        border-radius: 8px;
        margin: 10px;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.2s;
        width: 200px;
      }

      button:hover {
        background-color: #1f618d;
        transform: translateY(-3px);
      }

      button:active {
        background-color: #145a7a;
        transform: translateY(0);
      }

      .button-container {
        display: flex;
        justify-content: center;
        gap: 20px;
      }
    </style>
  </head>
  <body>
    <!-- Background Image with Blur -->
    <div class="background"></div>

    <!-- Header -->
    <div class="header">
      Welcome, <%= doctorName %>
    </div>

    <!-- Doctor Image and Info -->
    <div class="container">
      <img src="images/doctor-<%= doctorId %>.jpg" alt="Doctor Image" class="doctor-image" />
      <div class="doctor-info">
        <h3><%= doctorName %></h3>
      </div>
    </div>

    <!-- Buttons -->
    <div class="button-container">
      <button onclick="location.href='doctorProfile.jsp'">My Profile</button>
      <button onclick="location.href='doctorAppointments.jsp'">View Appointments</button>
      <button onclick="location.href='logout.jsp'">Logout</button>
    </div>
  </body>
</html>
