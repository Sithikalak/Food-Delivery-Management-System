package com.foodhub.model;

public class RegularCustomer extends CustomerUser {
    public RegularCustomer() {
        this.setUserType("REGULAR");
    }

    @Override
    public double calculateDiscount(double amount) {
        return amount * 0.05; // 5% discount for regular
    }
}
