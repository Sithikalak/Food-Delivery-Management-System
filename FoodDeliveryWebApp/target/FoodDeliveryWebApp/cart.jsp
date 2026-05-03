<%@ page import="com.foodhub.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    User u = (User) session.getAttribute("user");
    if (u == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart - FoodHub</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="jsp/navbar.jsp" />

    <div class="container">
        <h1>Your Shopping Cart</h1>
        
        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 40px; margin-top: 30px;">
            <!-- Cart Items -->
            <div class="card" style="padding: 20px;">
                <table id="cartTable">
                    <thead>
                        <tr>
                            <th>Item</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="cartItems">
                        <!-- Filled by JS -->
                    </tbody>
                </table>
            </div>

            <!-- Order Summary -->
            <div class="card" style="padding: 25px;">
                <h3>Order Summary</h3>
                <hr style="margin: 15px 0; border: 0; border-top: 1px solid #eee;">
                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <span>Subtotal</span>
                    <span id="subtotal">$0.00</span>
                </div>
                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <span>Discount (<%= u.getUserType() %>)</span>
                    <span id="discount" style="color: #06c167;">-$0.00</span>
                </div>
                <div style="display: flex; justify-content: space-between; font-weight: 800; font-size: 20px; margin-top: 20px; border-top: 1px solid #eee; padding-top: 20px;">
                    <span>Total</span>
                    <span id="finalTotal">$0.00</span>
                </div>

                <form action="order" method="POST" id="checkoutForm" style="margin-top: 30px;">
                    <input type="hidden" name="action" value="place">
                    <input type="hidden" name="restaurantId" id="resIdField">
                    <input type="hidden" name="totalPrice" id="totalField">
                    <input type="hidden" name="orderType" value="INSTANT">
                    
                    <div class="form-group" style="margin-bottom: 20px;">
                        <label>Payment Method</label>
                        <select name="paymentMethod" class="form-control" required>
                            <option value="CASH">Cash on Delivery</option>
                            <option value="CARD">Credit / Debit Card</option>
                            <option value="UPI">UPI / Wallet</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary" style="width: 100%; padding: 15px;">Place Order & Pay</button>
                </form>
            </div>
        </div>
    </div>

    <script src="js/cart.js"></script>
    <script>
        function renderCart() {
            const tbody = document.getElementById('cartItems');
            const subtotalEl = document.getElementById('subtotal');
            const discountEl = document.getElementById('discount');
            const totalEl = document.getElementById('finalTotal');
            
            if (cart.length === 0) {
                tbody.innerHTML = '<tr><td colspan="5" style="text-align:center; padding:40px;">Your cart is empty! <a href="restaurant?action=list">Go shopping</a></td></tr>';
                return;
            }

            let subtotal = 0;
            tbody.innerHTML = cart.map((item, index) => {
                const total = item.price * item.quantity;
                subtotal += total;
                return `
                    <tr>
                        <td>\${item.name}</td>
                        <td>$\${item.price}</td>
                        <td>\${item.quantity}</td>
                        <td>$\${total.toFixed(2)}</td>
                        <td><button onclick="removeFromCart(\${index})" style="color:red; border:none; background:none; cursor:pointer;">Remove</button></td>
                    </tr>
                `;
            }).join('');

            // Apply Membership Discount logic
            const userType = '<%= u.getUserType() %>';
            const discountRate = userType === 'PREMIUM' ? 0.15 : 0.05;
            const discount = subtotal * discountRate;
            const finalTotal = subtotal - discount;

            subtotalEl.textContent = `$\${subtotal.toFixed(2)}`;
            discountEl.textContent = `-$\${discount.toFixed(2)}`;
            totalEl.textContent = `$\${finalTotal.toFixed(2)}`;

            // Fill hidden fields
            document.getElementById('totalField').value = finalTotal.toFixed(2);
            if (cart.length > 0) {
                document.getElementById('resIdField').value = cart[0].restaurantId;
            }
        }

        function removeFromCart(index) {
            cart.splice(index, 1);
            saveCart();
            renderCart();
            updateCartUI();
        }

        document.addEventListener('DOMContentLoaded', renderCart);
    </script>
</body>
</html>
