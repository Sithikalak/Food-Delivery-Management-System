package com.foodhub.servlet;

import com.foodhub.dao.OrderDAO;
import com.foodhub.dao.PaymentDAO;
import com.foodhub.model.Order;
import com.foodhub.model.Payment;
import com.foodhub.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("place".equals(action)) {
                User user = (User) request.getSession().getAttribute("user");
                if (user == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }
                Order order = new Order();
                order.setUserId(user.getUserId());
                order.setRestaurantId(Integer.parseInt(request.getParameter("restaurantId")));
                order.setTotalPrice(Double.parseDouble(request.getParameter("totalPrice")));
                order.setOrderType(request.getParameter("orderType"));
                
                int orderId = orderDAO.placeOrder(order);
                
                // Record Payment
                PaymentDAO paymentDAO = new PaymentDAO();
                Payment p = new Payment();
                p.setOrderId(orderId);
                p.setAmount(order.getTotalPrice());
                p.setPaymentMethod(request.getParameter("paymentMethod"));
                p.setTransactionId("TXN" + System.currentTimeMillis());
                paymentDAO.recordPayment(p);

                response.sendRedirect("order?action=status&id=" + orderId);
            } else if ("updateStatus".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");
                orderDAO.updateStatus(id, status);
                response.sendRedirect("order?action=history");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("history".equals(action)) {
                User user = (User) request.getSession().getAttribute("user");
                if ("ADMIN".equals(user.getRole())) {
                    request.setAttribute("orders", orderDAO.getAllOrders());
                } else {
                    request.setAttribute("orders", orderDAO.getHistoryByUser(user.getUserId()));
                }
                request.getRequestDispatcher("order-history.jsp").forward(request, response);
            } else if ("status".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("order", orderDAO.getOrderById(id));
                request.getRequestDispatcher("order-status.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
