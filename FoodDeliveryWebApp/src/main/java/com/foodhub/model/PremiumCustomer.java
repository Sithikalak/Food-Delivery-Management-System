package com.foodhub.model;

public class PremiumCustomer extends CustomerUser {
    public PremiumCustomer() {
        this.setUserType("PREMIUM");
    }

    @Override
    public double calculateDiscount(double amount) {
        return amount * 0.15; // 15% discount for premium
    }
}

// Separate file logic: I'll include RegularCustomer here too if allowed, but better separate.
