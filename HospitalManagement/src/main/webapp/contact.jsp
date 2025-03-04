<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
         	background-image: url("images/contact.jpg");
        	background-size: cover;
        	background-position: center;
        	background-repeat: no-repeat;           
        }
        h1 {
            text-align: center;
            color: #2c3e50;
            margin-top: 40px;
        }
        .contact-container {
            max-width: 600px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        label {
            font-weight: bold;
            color: #2c3e50;
        }
        input[type="text"],
        input[type="email"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            margin-bottom: 20px;
        }
        textarea {
            resize: vertical;
        }
        button {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            width: 100%;
            text-transform: uppercase;
        }
        button:hover {
            background-color: #2980b9;
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

    <h1>Contact Us</h1>
    <div class="contact-container">
        <form action="#" method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required />
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required />
            <label for="message">Message:</label>
            <textarea id="message" name="message" rows="4" required></textarea>
            <button type="submit">Send Message</button>
        </form>
    </div>
</body>
</html>
