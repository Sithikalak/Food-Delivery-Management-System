<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Restaurant Partner Login - FoodHub</title>
    <link rel="stylesheet" href="../css/style.css">
    <style>
        .login-box { max-width: 400px; margin: 100px auto; padding: 40px; }
        .res-brand { color: #06c167; font-size: 24px; font-weight: 800; margin-bottom: 30px; text-align: center; }
    </style>
</head>
<body style="background: #f4f7f6;">
    <div class="card login-box">
        <div class="res-brand">FoodHub <span style="color: #333; font-weight: 400; font-size: 18px;">Partners</span></div>
        <h2 style="margin-bottom: 20px;">Partner Login</h2>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger" style="margin-bottom: 20px;"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="../user" method="POST">
            <input type="hidden" name="action" value="login">
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" class="form-control" placeholder="partner@restaurant.com" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" class="form-control" placeholder="••••••••" required>
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%; padding: 12px; font-size: 16px;">Login to Dashboard</button>
        </form>
        
        <p style="margin-top: 25px; text-align: center; color: #6b7280; font-size: 14px;">
            Not a partner yet? <a href="restaurant-register.jsp" style="color: #06c167; font-weight: 600;">Join Us</a>
        </p>
    </div>
</body>
</html>
