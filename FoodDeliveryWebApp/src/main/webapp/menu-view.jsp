<%@ page import="com.foodhub.model.MenuItem" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Menu - FoodHub</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="jsp/navbar.jsp" />

    <div class="container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
            <h1>Menu Items</h1>
            <a href="cart.jsp" class="btn btn-primary">🛒 View Cart (<span class="cart-count">0</span>)</a>
        </div>

        <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 25px;">
            <% 
                List<MenuItem> menu = (List<MenuItem>) request.getAttribute("menu");
                if (menu != null && !menu.isEmpty()) {
                    for (MenuItem item : menu) {
            %>
                <div class="card">
                    <div style="padding: 20px;">
                        <div style="display: flex; justify-content: space-between;">
                            <h3><%= item.getName() %></h3>
                            <span style="font-size: 12px; padding: 2px 8px; border-radius: 4px; background: #f3f4f6;">
                                <%= item.getCategory() %>
                            </span>
                        </div>
                        <p style="font-size: 20px; font-weight: 800; margin: 15px 0; color: var(--primary);">$<%= item.getPrice() %></p>
                        
                        <% if (item.isAvailability()) { %>
                            <button onclick="addToCart(<%= item.getId() %>, '<%= item.getName() %>', <%= item.getPrice() %>, <%= item.getRestaurantId() %>)" 
                                    class="btn btn-primary" style="width: 100%;">Add to Cart</button>
                        <% } else { %>
                            <button class="btn btn-secondary" style="width: 100%; cursor: not-allowed;" disabled>Out of Stock</button>
                        <% } %>
                    </div>
                </div>
            <% 
                    }
                } else {
            %>
                <p>No items available in this menu yet.</p>
            <% } %>
        </div>
    </div>

    <script src="js/cart.js"></script>
</body>
</html>
