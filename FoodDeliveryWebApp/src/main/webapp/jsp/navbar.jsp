<%@ page import="com.foodhub.model.User" %>
<%
    User sessionUser = (User) session.getAttribute("user");
%>
<header class="navbar">
    <a href="index.jsp" class="logo">FoodHub</a>
    <nav class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="restaurant?action=list">Restaurants</a>
        <% if (sessionUser != null && "ADMIN".equals(sessionUser.getRole())) { %>
            <a href="admin-dashboard.jsp">Dashboard</a>
        <% } %>
    </nav>
    <div class="nav-buttons">
        <% if (sessionUser != null) { %>
            <a href="profile.jsp" class="btn btn-secondary">Hi, <%= sessionUser.getName() %></a>
            <a href="user?action=logout" class="btn btn-primary" style="background:#ef4444;">Logout</a>
        <% } else { %>
            <a href="login.jsp" class="btn btn-secondary">Log in</a>
            <a href="register.jsp" class="btn btn-primary">Sign up</a>
        <% } %>
    </div>
</header>
