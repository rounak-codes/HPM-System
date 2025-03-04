<%-- navbar.jsp --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* Horizontal Navbar container */
        .navbar {
            width: 100%;
            background-color: #1abc9c; /* Matching sidebar background */
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
            background-color: #16a085; /* Slightly darker green */
            color: #ecf0f1;
        }

        /* Active link style */
        .navbar a.active {
            background-color: #0e6655; /* Darker active link */
        }

        /* Menu button container (hidden in horizontal navbar) */
        .toggle-btn {
            display: none; /* Menu button hidden */
        }

        /* Main content */
        .main-content {
            padding: 20px;
        }
    </style>
</head>
<body>
    <!-- Horizontal Navbar -->
    <div class="navbar">
        <a href="patientDashboard.jsp" class="<%= (request.getRequestURI().endsWith("patientDashboard.jsp")) ? "active" : "" %>">Dashboard</a>
        <a href="editProfile.jsp" class="<%= (request.getRequestURI().endsWith("editProfile.jsp")) ? "active" : "" %>">Profile</a>
        <a href="services.jsp" class="<%= (request.getRequestURI().endsWith("services.jsp")) ? "active" : "" %>">Lab Tests</a>
        <a href="viewBookings.jsp" class="<%= (request.getRequestURI().endsWith("viewBookings.jsp")) ? "active" : "" %>">View Appointments</a>
        <a href="viewLabTests.jsp" class="<%= (request.getRequestURI().endsWith("viewLabTests.jsp")) ? "active" : "" %>">View Lab Tests</a>
        <a href="about.jsp" class="<%= (request.getRequestURI().endsWith("about.jsp")) ? "active" : "" %>">About Us</a>
        <a href="contact.jsp" class="<%= (request.getRequestURI().endsWith("contact.jsp")) ? "active" : "" %>">Contact</a>
        <a href="logout.jsp" class="<%= (request.getRequestURI().endsWith("logout.jsp")) ? "active" : "" %>">Logout</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Page content goes here -->
    </div>
</body>
</html>
