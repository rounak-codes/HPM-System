<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="homeNavbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Login</title>
    <style>
      /* General Styles */
      body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f0f4f8;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        background-image: url("images/loginBG.jpg");
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        flex-direction: column; /* Adjust content stacking vertically */
      }

      /* Navbar adjustments */
      .navbar {
        width: 100%;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1000; /* Ensures navbar stays above other content */
      }

      .container {
        margin-top: 100px; /* Push content below the navbar */
        width: 100%;
        max-width: 400px;
        padding: 40px;
        background-color: rgba(255, 255, 255, 0.9);
        border-radius: 15px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        text-align: center;
      }

      h1 {
        color: #2c3e50;
        font-size: 28px;
        margin-bottom: 20px;
      }

      /* Form Styles */
      form {
        display: flex;
        flex-direction: column;
      }

      .form-group {
        margin-bottom: 20px;
        text-align: left;
      }

      label {
        font-weight: 600;
        color: #34495e;
        display: block;
        margin-bottom: 8px;
      }

      input {
        padding: 12px;
        width: 100%;
        font-size: 16px;
        border: 1px solid #bdc3c7;
        border-radius: 8px;
        transition: border-color 0.3s;
      }

      input:focus {
        border-color: #2980b9;
        outline: none;
        box-shadow: 0 0 5px rgba(41, 128, 185, 0.5);
      }

      .alert {
        color: #e74c3c;
        font-weight: bold;
        margin-bottom: 20px;
      }

      button {
        padding: 12px;
        background-color: #2980b9;
        color: #fff;
        border: none;
        border-radius: 8px;
        font-size: 18px;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.2s;
      }

      button:hover {
        background-color: #1f618d;
        transform: translateY(-3px);
      }

      button:active {
        background-color: #145a7a;
        transform: translateY(0);
      }
    </style>
  </head>
  <body>
    <!-- Navbar on top -->
    <div class="navbar">
      <%@ include file="homeNavbar.jsp" %>
    </div>

    <div class="container">
      <h1>Admin Login</h1>
      
      <% if (request.getAttribute("error") != null) { %>
        <div class="alert">
          <%= request.getAttribute("error") %>
        </div>
      <% } %>
      
      <form action="adminLoginServlet" method="post">
        <div class="form-group">
          <label for="email">Email:</label>
          <input type="email" id="email" name="email" required />
        </div>
        <div class="form-group">
          <label for="password">Password:</label>
          <input type="password" id="password" name="password" required />
        </div>
        <button type="submit">Login</button>
      </form>
    </div>
  </body>
</html>
