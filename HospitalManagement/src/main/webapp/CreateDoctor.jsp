<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Doctor</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            padding: 0;
            color: #333;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-top: 20px;
        }

        .form-container {
            max-width: 600px;
            margin: 40px auto;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        table {
            width: 100%;
            border-spacing: 0;
        }

        table td {
            padding: 10px;
            vertical-align: top;
        }

        label {
            font-weight: bold;
            color: #2c3e50;
        }

        input[type="text"], 
        input[type="email"], 
        input[type="password"], 
        input[type="number"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
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
</head>
<body>
    <h1>Add New Doctor</h1>
    
    <div class="form-container">
        <form action="AddDoctorServlet" method="post">
            <table>
                <tr>
                    <td><label for="doctor_name">Doctor Name:</label></td>
                    <td><input type="text" id="doctor_name" name="doctor_name" placeholder="Enter the doctor's name" required></td>
                </tr>
                <tr>
                    <td><label for="email">Email:</label></td>
                    <td><input type="email" id="email" name="email" placeholder="Enter the doctor's email" required></td>
                </tr>
                <tr>
                    <td><label for="password">Password:</label></td>
                    <td><input type="password" id="password" name="password" placeholder="Enter a password" required></td>
                </tr>
                <tr>
                    <td><label for="speciality">Specialty:</label></td>
                    <td><input type="text" id="speciality" name="speciality" placeholder="Enter the specialty" required></td>
                </tr>
                <tr>
                    <td><label for="qualification">Qualification:</label></td>
                    <td><input type="text" id="qualification" name="qualification" placeholder="Enter the qualification" required></td>
                </tr>
                <tr>
                    <td><label for="experience">Experience (years):</label></td>
                    <td><input type="number" id="experience" name="experience" placeholder="Enter years of experience" required></td>
                </tr>
            </table>

            <div class="button-group">
                <input type="submit" value="Add Doctor">
                <a href="ManageDoctors.jsp" class="cancel-button">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
