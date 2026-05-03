<%@ page import="com.foodhub.model.MenuItem" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Menu Management - FoodHub</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="jsp/navbar.jsp" />

    <div class="container">
        <h1>Restaurant Menu</h1>
        
        <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 40px; margin-top: 30px;">
            <!-- Add Item Form -->
            <div class="card" style="padding: 20px;">
                <h3>Add Menu Item</h3>
                <form action="restaurant" method="POST" style="margin-top: 15px;">
                    <input type="hidden" name="action" value="addMenuItem">
                    <input type="hidden" name="restaurantId" value="<%= request.getParameter("id") %>">
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
                                <td>$<%= item.getPrice() %></td>
                                <td><%= item.isAvailability() ? "✅ Available" : "❌ Out of Stock" %></td>
                            </tr>
                        <% 
                                }
                            }
                        %>
                    </tbody>
                </table>
                <div style="margin-top: 30px;">
                    <a href="order?action=prepare&id=<%= request.getParameter("id") %>" class="btn btn-primary" style="padding: 15px 30px;">Proceed to Checkout</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
