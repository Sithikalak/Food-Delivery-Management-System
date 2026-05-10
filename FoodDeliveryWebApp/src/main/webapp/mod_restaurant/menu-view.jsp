<%@ page import="com.foodhub.model.MenuItem" %>
<%@ page import="com.foodhub.model.Restaurant" %>
<%@ page import="com.foodhub.model.Review" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Restaurant res = (Restaurant) request.getAttribute("restaurant");
    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Menu - FoodHub</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <jsp:include page="../jsp/navbar.jsp" />

    <div class="container">
        <% if (res != null) { %>
            <div class="card" style="padding: 30px; margin-bottom: 30px; background: linear-gradient(135deg, #06c167, #059669); color: white; border: none;">
                <h1 style="font-size: 36px; margin-bottom: 10px;"><%= res.getName() %></h1>
                <p style="font-size: 18px; opacity: 0.9;"><%= res.getCuisine() %> • <%= res.getLocation() %></p>
                <div style="margin-top: 15px; font-size: 20px;">
                    <span style="background: rgba(255,255,255,0.2); padding: 5px 12px; border-radius: 20px;">⭐ <%= res.getRating() %></span>
                </div>
            </div>
        <% } %>

        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2>Menu Items</h2>
            <a href="../mod_orders/cart.jsp" class="btn btn-primary">🛒 View Cart (<span class="cart-count">0</span>)</a>
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
            <% } %>
        </div>

        <!-- Reviews Section -->
        <div style="margin-top: 60px; border-top: 1px solid #eee; padding-top: 40px;">
            <h2 style="margin-bottom: 25px;">What Customers Say</h2>
            <div style="max-width: 800px;">
                <% if (reviews != null && !reviews.isEmpty()) { %>
                    <% for (Review rev : reviews) { %>
                        <div class="card" style="padding: 20px; margin-bottom: 20px; border-left: 5px solid #06c167;">
                            <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                                <strong style="font-size: 16px;">User #<%= rev.getUserId() %></strong>
                                <span style="color: #f59e0b; font-size: 14px;">
                                    <% for(int i=0; i<rev.getRating(); i++) { %>⭐<% } %>
                                </span>
                            </div>
                            <p style="color: #4b5563; line-height: 1.6;"><%= rev.getComment() %></p>
                            <div style="margin-top: 15px; font-size: 12px; color: #9ca3af;">
                                📅 <%= rev.getReviewDate() %>
                            </div>
                        </div>
                    <% } %>
                <% } else { %>
                    <div style="text-align: center; padding: 40px; background: #f9fafb; border-radius: 12px;">
                        <p style="color: #6b7280; font-size: 16px;">No reviews yet. Be the first to order and leave a review!</p>
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <script src="../js/cart.js"></script>
</body>
</html>
