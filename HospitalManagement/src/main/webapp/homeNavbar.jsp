<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* Navbar container */
        .navbar {
            width: 100%;
            background-color: #3498db;
            overflow: hidden;
            display: flex;
            justify-content: space-around; /* Space links evenly */
            align-items: center;
            padding: 10px 0;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
        }

        /* Navbar links */
        .navbar a {
            text-decoration: none;
            color: white;
            font-size: 18px;
            font-weight: bold;
            padding: 8px 16px;
            transition: background-color 0.3s, color 0.3s;
            border-radius: 5px;
        }

        /* Hover effect */
        .navbar a:hover {
            background-color: #2980b9;
            color: #ecf0f1;
        }

        /* Active link style */
        .navbar a.active {
            background-color: #2c3e50;
        }
    </style>
</head>
<body>
    <!-- Horizontal Navbar -->
    <div class="navbar">
        <a href="homePage.jsp" class="<%= (request.getRequestURI().endsWith("homePage.jsp")) ? "active" : "" %>">Home</a>
        <a href="patientLogin.jsp" class="<%= (request.getRequestURI().endsWith("patientLogin.jsp")) ? "active" : "" %>">Patient Login</a>
        <a href="doctorLogin.jsp" class="<%= (request.getRequestURI().endsWith("doctorLogin.jsp")) ? "active" : "" %>">Doctor Login</a>
        <a href="adminLogin.jsp" class="<%= (request.getRequestURI().endsWith("adminLogin.jsp")) ? "active" : "" %>">Administrator Login</a>
        <a href="contact.jsp" class="<%= (request.getRequestURI().endsWith("contact.jsp")) ? "active" : "" %>">Contact</a>
        <a href="about.jsp" class="<%= (request.getRequestURI().endsWith("about.jsp")) ? "active" : "" %>">About</a>
    </div>
</body>
</html>
