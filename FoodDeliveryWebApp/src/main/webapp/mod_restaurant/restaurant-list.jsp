<%@ page import="com.foodhub.model.Restaurant" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Restaurants - FoodHub</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <jsp:include page="../jsp/navbar.jsp" />

    <div class="container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
            <h1>Available Restaurants</h1>
            <form action="../restaurant" method="GET" style="display: flex; gap: 10px;">
                <input type="hidden" name="action" value="search">
                <input type="text" name="query" class="form-control" placeholder="Search cuisine or name..." style="width: 250px;">
                <button type="submit" class="btn btn-primary">Search</button>
            </form>
        </div>

        <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 30px;">
            <% 
                List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
                if (restaurants != null) {
                    for (Restaurant r : restaurants) {
            %>
                <div class="card">
                    <div style="padding: 20px;">
                        <h3><%= r.getName() %></h3>
                        <p style="color: #666;"><%= r.getCuisine() %></p>
                        <p>📍 <%= r.getLocation() %></p>
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 20px;">
                            <span style="font-weight: bold; color: #facc15;"><%= r.getRating() %> ★</span>
                            <a href="../restaurant?action=menu&id=<%= r.getId() %>" class="btn btn-primary">View Menu</a>
                        </div>
                    </div>
                </div>
            <% 
                    }
                } else {
            %>
                <p>Please browse all restaurants via the button above.</p>
            <% } %>
        </div>
    </div>
</body>
</html>
