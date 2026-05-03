package com.foodhub.dao;

import com.foodhub.model.Payment;
import com.foodhub.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    public boolean recordPayment(Payment p) throws SQLException {
        String sql = "INSERT INTO payments (order_id, payment_method, amount, payment_status, transaction_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, p.getOrderId());
            stmt.setString(2, p.getPaymentMethod());
            stmt.setDouble(3, p.getAmount());
            stmt.setString(4, "COMPLETED");
            stmt.setString(5, p.getTransactionId());
            return stmt.executeUpdate() > 0;
        }
    }

    public List<Payment> getAllPayments() throws SQLException {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT * FROM payments ORDER BY payment_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Payment p = new Payment();
                p.setPaymentId(rs.getInt("payment_id"));
                p.setOrderId(rs.getInt("order_id"));
                p.setPaymentMethod(rs.getString("payment_method"));
                p.setAmount(rs.getDouble("amount"));
                p.setPaymentStatus(rs.getString("payment_status"));
                p.setTransactionId(rs.getString("transaction_id"));
                p.setPaymentDate(rs.getTimestamp("payment_date"));
                list.add(p);
            }
        }
        return list;
    }
}
