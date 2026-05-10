<%@ page import="com.foodhub.model.MenuItem" %>
<%@ page import="com.foodhub.model.Restaurant" %>
<%@ page import="com.foodhub.model.User" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
    User currentUser = (User) session.getAttribute("user");
    
    // Security Check: Only Admin or the Restaurant Owner can manage this menu
    boolean isAuthorized = false;
    if (currentUser != null) {
        if ("ADMIN".equals(currentUser.getRole())) {
            isAuthorized = true;
        } else if ("RESTAURANT".equals(currentUser.getRole()) && restaurant != null) {
            if (restaurant.getOwnerId() == currentUser.getUserId()) {
                isAuthorized = true;
            }
        }
    }

    if (!isAuthorized) {
        response.sendRedirect("login.jsp?error=Unauthorized Access");
        return;
    }

    int resId = (restaurant != null) ? restaurant.getId() : 0;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Menu Management - FoodHub</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <jsp:include page="../jsp/navbar.jsp" />

    <div class="container">
        <h1><%= (restaurant != null) ? restaurant.getName() + " - " : "" %>Menu Management</h1>
        
        <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 40px; margin-top: 30px;">
            <!-- Add Item Form -->
            <div class="card" style="padding: 20px;">
                <h3>Add Menu Item</h3>
                <form action="../restaurant" method="POST" style="margin-top: 15px;">
                    <input type="hidden" name="action" value="addMenuItem">
                    <input type="hidden" name="restaurantId" value="<%= resId %>">
                    <div class="form-group">
                        <label>Item Name</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Price ($)</label>
                        <input type="number" step="0.01" name="price" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Category</label>
                        <select name="category" class="form-control">
                            <option value="VEG">Vegetarian</option>
                            <option value="NON_VEG">Non-Vegetarian</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%;">Add to Menu</button>
                </form>
            </div>

            <!-- Item List -->
            <div>
                <h3>Items</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<MenuItem> menu = (List<MenuItem>) request.getAttribute("menu");
                            if (menu != null) {
                                for (MenuItem item : menu) {
                        %>
                            <tr>
                                <td><%= item.getName() %></td>
                                <td><span style="padding: 3px 8px; border-radius: 4px; background: <%= "VEG".equals(item.getCategory()) ? "#dcfce7" : "#fee2e2" %>;"><%= item.getCategory() %></span></td>
                                <td>
                                    <form action="../restaurant" method="POST" style="display: flex; gap: 5px; align-items: center;">
                                        <input type="hidden" name="action" value="updatePrice">
                                        <input type="hidden" name="itemId" value="<%= item.getId() %>">
                                        <input type="hidden" name="restaurantId" value="<%= resId %>">
                                        <span style="font-weight: bold;">$</span>
                                        <input type="number" step="0.01" name="price" value="<%= item.getPrice() %>" style="width: 70px; padding: 5px; border: 1px solid #ddd; border-radius: 4px;">
                                        <button type="submit" class="btn btn-secondary" style="padding: 5px 10px; font-size: 12px; height: auto;">Update</button>
                                    </form>
                                </td>
                                <td><%= item.isAvailability() ? "✅ Available" : "❌ Out of Stock" %></td>
                            </tr>
                        <% 
                                }
                            }
                        %>
                    </tbody>
                </table>
                <% 
                    if (currentUser != null && "CUSTOMER".equals(currentUser.getRole())) { 
                %>
                    <div style="margin-top: 30px;">
                        <a href="../order?action=prepare&id=<%= resId %>" class="btn btn-primary" style="padding: 15px 30px;">Proceed to Checkout</a>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>
