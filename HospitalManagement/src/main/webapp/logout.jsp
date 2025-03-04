<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
    // Prevent caching of this page to avoid issues with back button
    response.setHeader("Cache-Control", "no-store"); // Prevents caching
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // HTTP 1.0
    
    // Invalidate the session to log the user out
    if (session != null) {
        session.invalidate();
    }
    
    // Redirect to the home page after logging out
    response.sendRedirect("homePage.jsp");
%>
