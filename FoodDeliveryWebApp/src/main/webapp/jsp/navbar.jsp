<%@ page import="com.foodhub.model.User" %>
<%
    User sessionUser = (User) session.getAttribute("user");
%>
<header class="navbar">
    <a href="${pageContext.request.contextPath}/mod_delivery/index.jsp" class="logo">FoodHub</a>
    <nav class="nav-links">
        <a href="${pageContext.request.contextPath}/mod_delivery/index.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/restaurant?action=list">Restaurants</a>
        <% if (sessionUser != null && "ADMIN".equals(sessionUser.getRole())) { %>
            <a href="${pageContext.request.contextPath}/mod_delivery/admin-dashboard.jsp">Dashboard</a>
        <% } else if (sessionUser != null && "RESTAURANT".equals(sessionUser.getRole())) { %>
            <a href="${pageContext.request.contextPath}/mod_restaurant/restaurant-dashboard.jsp">Dashboard</a>
        <% } %>
    </nav>
    <div class="nav-buttons">
        <% if (sessionUser != null) { %>
            <a href="${pageContext.request.contextPath}/mod_customer/profile.jsp" class="btn btn-secondary">Hi, <%= sessionUser.getName() %></a>
            <a href="${pageContext.request.contextPath}/user?action=logout" class="btn btn-primary" style="background:#ef4444;">Logout</a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/mod_customer/login.jsp" class="btn btn-secondary">Log in</a>
            <a href="${pageContext.request.contextPath}/mod_customer/register.jsp" class="btn btn-primary">Sign up</a>
        <% } %>
    </div>
</header>
