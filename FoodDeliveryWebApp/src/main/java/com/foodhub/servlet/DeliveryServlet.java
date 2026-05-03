package com.foodhub.servlet;

import com.foodhub.dao.DeliveryAgentDAO;
import com.foodhub.model.DeliveryAgent;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/delivery")
public class DeliveryServlet extends HttpServlet {
    private DeliveryAgentDAO agentDAO = new DeliveryAgentDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("register".equals(action)) {
                DeliveryAgent agent = new DeliveryAgent();
                agent.setName(request.getParameter("name"));
                agent.setPhoneNumber(request.getParameter("phone"));
                agent.setVehicleType(request.getParameter("vehicleType"));
                
                agentDAO.registerAgent(agent);
                response.sendRedirect("admin-dashboard.jsp");
            } else if ("assign".equals(action)) {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                int agentId = Integer.parseInt(request.getParameter("agentId"));
                
                com.foodhub.dao.OrderDAO orderDAO = new com.foodhub.dao.OrderDAO();
                orderDAO.assignAgent(orderId, agentId);
                response.sendRedirect("order?action=status&id=" + orderId);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("list".equals(action)) {
                request.setAttribute("agents", agentDAO.getAllAgents());
                request.getRequestDispatcher("agent-list.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
