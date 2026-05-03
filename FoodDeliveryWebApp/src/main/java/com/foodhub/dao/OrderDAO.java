package com.foodhub.dao;

import com.foodhub.model.Order;
import com.foodhub.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public int placeOrder(Order order) throws SQLException {
        String sql = "INSERT INTO orders (user_id, restaurant_id, total_price, order_status, order_type) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, order.getUserId());
            stmt.setInt(2, order.getRestaurantId());
            stmt.setDouble(3, order.getTotalPrice());
            stmt.setString(4, "PENDING");
            stmt.setString(5, order.getOrderType());
            
            stmt.executeUpdate();
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }

    public boolean updateStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET order_status = ? WHERE order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            return stmt.executeUpdate() > 0;
        }
    }

    public List<Order> getHistoryByUser(int userId) throws SQLException {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getInt("order_id"));
                    o.setRestaurantId(rs.getInt("restaurant_id"));
                    o.setTotalPrice(rs.getDouble("total_price"));
                    o.setOrderStatus(rs.getString("order_status"));
                    o.setOrderType(rs.getString("order_type"));
                    o.setOrderDate(rs.getTimestamp("order_date"));
                    list.add(o);
                }
            }
        }
        return list;
    }

    public List<Order> getAllOrders() throws SQLException {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("order_id"));
                o.setUserId(rs.getInt("user_id"));
                o.setRestaurantId(rs.getInt("restaurant_id"));
                o.setTotalPrice(rs.getDouble("total_price"));
                o.setOrderStatus(rs.getString("order_status"));
                o.setOrderType(rs.getString("order_type"));
                o.setOrderDate(rs.getTimestamp("order_date"));
                list.add(o);
            }
        }
        return list;
    }

    public Order getOrderById(int orderId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getInt("order_id"));
                    o.setUserId(rs.getInt("user_id"));
                    o.setRestaurantId(rs.getInt("restaurant_id"));
                    o.setTotalPrice(rs.getDouble("total_price"));
                    o.setOrderStatus(rs.getString("order_status"));
                    o.setOrderType(rs.getString("order_type"));
                    o.setOrderDate(rs.getTimestamp("order_date"));
                    return o;
                }
            }
        }
        return null;
    }

    public boolean assignAgent(int orderId, int agentId) throws SQLException {
        String updateSql = "UPDATE orders SET agent_id = ?, order_status = 'OUT_FOR_DELIVERY' WHERE order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(updateSql)) {
            stmt.setInt(1, agentId);
            stmt.setInt(2, orderId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            // If column doesn't exist, try to add it once and retry
            if (e.getMessage().contains("Unknown column 'agent_id'")) {
                try (Connection conn = DBConnection.getConnection();
                     Statement alterStmt = conn.createStatement()) {
                    alterStmt.executeUpdate("ALTER TABLE orders ADD COLUMN agent_id INT");
                    // Retry the update
                    try (PreparedStatement retryStmt = conn.prepareStatement(updateSql)) {
                        retryStmt.setInt(1, agentId);
                        retryStmt.setInt(2, orderId);
                        return retryStmt.executeUpdate() > 0;
                    }
                }
            }
            throw e;
        }
    }
}
