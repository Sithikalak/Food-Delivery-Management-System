package com.foodhub.mod_restaurant;

import com.foodhub.model.Restaurant;
import com.foodhub.model.MenuItem;
import com.foodhub.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDAO {

    public boolean addRestaurant(Restaurant r) throws SQLException {
        String sql = "INSERT INTO restaurants (name, location, cuisine, owner_id) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, r.getName());
            stmt.setString(2, r.getLocation());
            stmt.setString(3, r.getCuisine());
            stmt.setInt(4, r.getOwnerId());
            return stmt.executeUpdate() > 0;
        }
    }

    public List<Restaurant> getAllRestaurants() throws SQLException {
        List<Restaurant> list = new ArrayList<>();
        String sql = "SELECT * FROM restaurants";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Restaurant(rs.getInt("id"), rs.getString("name"), rs.getString("location"), rs.getString("cuisine"), rs.getInt("owner_id"), rs.getDouble("rating")));
            }
        }
        return list;
    }

    public boolean addMenuItem(MenuItem item) throws SQLException {
        String sql = "INSERT INTO menu_items (restaurant_id, name, price, availability, category) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, item.getRestaurantId());
            stmt.setString(2, item.getName());
            stmt.setDouble(3, item.getPrice());
            stmt.setBoolean(4, item.isAvailability());
            stmt.setString(5, item.getCategory());
            return stmt.executeUpdate() > 0;
        }
    }

    public List<MenuItem> getMenuByRestaurant(int restaurantId) throws SQLException {
        List<MenuItem> list = new ArrayList<>();
        String sql = "SELECT * FROM menu_items WHERE restaurant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, restaurantId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(new MenuItem(rs.getInt("id"), rs.getInt("restaurant_id"), rs.getString("name"), rs.getDouble("price"), rs.getBoolean("availability"), rs.getString("category")));
                }
            }
        }
        return list;
    }

    public List<Restaurant> searchRestaurants(String query) throws SQLException {
        List<Restaurant> list = new ArrayList<>();
        String sql = "SELECT * FROM restaurants WHERE name LIKE ? OR cuisine LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + query + "%");
            stmt.setString(2, "%" + query + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(new Restaurant(rs.getInt("id"), rs.getString("name"), rs.getString("location"), rs.getString("cuisine"), rs.getInt("owner_id"), rs.getDouble("rating")));
                }
            }
        }
        return list;
    }

    public Restaurant getRestaurantByOwner(int ownerId) throws SQLException {
        String sql = "SELECT * FROM restaurants WHERE owner_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, ownerId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Restaurant(rs.getInt("id"), rs.getString("name"), rs.getString("location"), rs.getString("cuisine"), rs.getInt("owner_id"), rs.getDouble("rating"));
                }
            }
        }
        return null;
    }

    public Restaurant getRestaurantById(int id) throws SQLException {
        String sql = "SELECT * FROM restaurants WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Restaurant(rs.getInt("id"), rs.getString("name"), rs.getString("location"), rs.getString("cuisine"), rs.getInt("owner_id"), rs.getDouble("rating"));
                }
            }
        }
        return null;
    }

    public boolean updateMenuItemPrice(int itemId, double newPrice) throws SQLException {
        String sql = "UPDATE menu_items SET price = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDouble(1, newPrice);
            stmt.setInt(2, itemId);
            return stmt.executeUpdate() > 0;
        }
    }
}
