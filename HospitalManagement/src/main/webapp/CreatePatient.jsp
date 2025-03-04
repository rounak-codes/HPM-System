<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Add a Patient</title>
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
      input[type="number"],
      input[type="date"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
      }

      select {
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
      .cancel-button,
      button {
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

      input[type="submit"]:hover,
      button:hover {
        background-color: #2980b9;
      }

      .cancel-button {
        background-color: #e74c3c;
      }

      .cancel-button:hover {
        background-color: #c0392b;
      }

      textarea {
        resize: vertical;
      }

      input[type="text"]:invalid,
      input[type="email"]:invalid {
        border-color: red;
      }

      /* Styling for Date of Birth (DOB) */
      input[type="date"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
        background-color: #fff;
      }

      /* Styling for Select dropdowns */
      select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
        background-color: #fff;
      }
    </style>
  </head>
  <body>
    <h1>Add a Patient</h1>

    <div class="form-container">
      <form action="AddPatientServlet" method="post">
        <table>
          <tr>
            <td><label for="name">Patient Name:</label></td>
            <td><input type="text" id="name" name="name" required /></td>
          </tr>
          <tr>
            <td><label for="dob">Date of Birth:</label></td>
            <td><input type="date" id="dob" name="dob" required /></td>
          </tr>
          <tr>
            <td><label for="gender">Gender:</label></td>
            <td>
              <select id="gender" name="gender" required>
                <option value="">Select Gender</option>
                <option value="male">Male</option>
                <option value="female">Female</option>
                <option value="other">Other</option>
              </select>
            </td>
          </tr>
          <tr>
            <td><label for="blood-group">Blood Group:</label></td>
            <td>
              <select id="blood-group" name="blood-group" required>
                <option value="">Select Blood Group</option>
                <option value="A+">A+</option>
                <option value="A-">A-</option>
                <option value="B+">B+</option>
                <option value="B-">B-</option>
                <option value="AB+">AB+</option>
                <option value="AB-">AB-</option>
                <option value="O+">O+</option>
                <option value="O-">O-</option>
              </select>
            </td>
          </tr>
          <tr>
            <td><label for="email">Email:</label></td>
            <td><input type="email" id="email" name="email" required /></td>
          </tr>
          <tr>
            <td><label for="phone">Phone Number:</label></td>
            <td>
              <input
                type="text"
                id="phone"
                name="phone"
                pattern="\d{10}"
                title="Please enter a valid 10-digit phone number"
                required
              />
            </td>
          </tr>
          <tr>
            <td><label for="address">Address:</label></td>
            <td><textarea id="address" name="address" rows="3" required></textarea></td>
          </tr>
          <tr>
            <td><label for="password">Password:</label></td>
            <td><input type="password" id="password" name="password" required /></td>
          </tr>
          <tr>
            <td><label for="confirm_password">Confirm Password:</label></td>
            <td><input type="password" id="confirm_password" name="confirm_password" required /></td>
          </tr>
        </table>

        <div class="button-group">
          <button type="submit">Register</button>
          <a href="ManagePatients.jsp" class="cancel-button">Cancel</a>
        </div>
      </form>
    </div>

     <script>
      // Set minimum date to 6 months ago for date of birth input
      window.onload = function() {
        const dobInput = document.getElementById('dob');
        const today = new Date();
        const sixMonthsAgo = new Date(today.setMonth(today.getMonth() - 6));
        
        // Format date to yyyy-mm-dd format
        const formattedDate = sixMonthsAgo.toISOString().split('T')[0];
        
        // Set the minimum date on the date input field
        dobInput.setAttribute('max', formattedDate);
      };

      document.querySelector('form').addEventListener('submit', function (event) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirm_password').value;
        if (password !== confirmPassword) {
          event.preventDefault();
          alert('Passwords do not match.');
        }
      });
    </script>
  </body>
</html>
