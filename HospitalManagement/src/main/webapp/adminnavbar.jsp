<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* Horizontal Navbar container */
        .navbar {
            width: 100%;
            background-color: #3498db; /* Navbar background */
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
            background-color: #2980b9; /* Slightly darker blue */
            color: #ecf0f1;
        }

        /* Active link style */
        .navbar a.active {
            background-color: #1d5d8c; /* Darker active link */
        }

    </style>
</head>
<body>
    <!-- Horizontal Navbar -->
    <div class="navbar">
        <a href="adminDashboard.jsp" class="<%= (request.getRequestURI().endsWith("adminDashboard.jsp")) ? "active" : "" %>">Home</a>
        <a href="ManagePatients.jsp" class="<%= (request.getRequestURI().endsWith("ManagePatients.jsp")) ? "active" : "" %>">Manage Patients</a>
        <a href="ManageDoctors.jsp" class="<%= (request.getRequestURI().endsWith("ManageDoctors.jsp")) ? "active" : "" %>">Manage Doctors</a>
        <a href="ManageAppointments.jsp" class="<%= (request.getRequestURI().endsWith("ManageAppointments.jsp")) ? "active" : "" %>">Manage Appointments</a>
        <a href="logout.jsp" class="<%= (request.getRequestURI().endsWith("logout.jsp")) ? "active" : "" %>">Logout</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Page content goes here -->
    </div>
</body>
</html>
