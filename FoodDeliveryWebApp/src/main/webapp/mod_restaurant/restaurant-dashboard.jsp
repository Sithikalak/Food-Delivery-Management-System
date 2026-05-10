<%@ page import="com.foodhub.model.User" %>
<%@ page import="com.foodhub.model.Restaurant" %>
<%@ page import="com.foodhub.dao.RestaurantDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"RESTAURANT".equals(user.getRole())) {
        response.sendRedirect("restaurant-login.jsp");
        return;
    }
    
    RestaurantDAO resDAO = new RestaurantDAO();
    Restaurant myRes = resDAO.getRestaurantByOwner(user.getUserId());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Restaurant Dashboard - FoodHub</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body style="background: #f8fafc;">
    <jsp:include page="../jsp/navbar.jsp" />

    <div class="container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
            <div>
                <h1 style="margin: 0;">Welcome, Partner!</h1>
                <p style="color: #64748b;">Manage your restaurant and orders from here.</p>
            </div>
            <% if (myRes != null) { %>
                <div class="card" style="padding: 10px 20px; background: #06c167; color: white;">
                    <strong><%= myRes.getName() %></strong>
                </div>
            <% } %>
        </div>

        <% if (myRes == null) { %>
            <div class="card" style="padding: 40px; text-align: center;">
                <h3>Register Your Restaurant</h3>
                <p>You haven't registered your restaurant yet. Please complete the setup to start selling.</p>
                <a href="restaurant-add.jsp" class="btn btn-primary" style="margin-top: 20px;">Complete Setup</a>
            </div>
        <% } else { %>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px;">
                <!-- Menu Management -->
                <div class="card" style="padding: 25px;">
                    <div style="font-size: 30px; margin-bottom: 15px;">🍴</div>
                    <h3>Menu Management</h3>
                    <p style="color: #64748b; margin-bottom: 20px;">Add new items, update prices, or change availability.</p>
                    <a href="../restaurant?action=menu&id=<%= myRes.getId() %>" class="btn btn-primary" style="width: 100%;">Manage Menu</a>
                </div>

                <!-- Orders -->
                <div class="card" style="padding: 25px;">
                    <div style="font-size: 30px; margin-bottom: 15px;">📦</div>
                    <h3>Active Orders</h3>
                    <p style="color: #64748b; margin-bottom: 20px;">View and update the status of incoming orders.</p>
                    <a href="../order?action=history" class="btn btn-secondary" style="width: 100%;">View Orders</a>
                </div>

                <!-- Reviews -->
                <div class="card" style="padding: 25px;">
                    <div style="font-size: 30px; margin-bottom: 15px;">⭐</div>
                    <h3>Customer Reviews</h3>
                    <p style="color: #64748b; margin-bottom: 20px;">See what your customers are saying about your food.</p>
                    <button class="btn btn-secondary" style="width: 100%;" disabled>Coming Soon</button>
                </div>
            </div>
        <% } %>
    </div>
</body>
</html>
