package com.foodhub.model;

public class MenuItem {
    private int id;
    private int restaurantId;
    private String name;
    private double price;
    private boolean availability;
    private String category;

    public MenuItem() {}

    public MenuItem(int id, int restaurantId, String name, double price, boolean availability, String category) {
        this.id = id;
        this.restaurantId = restaurantId;
        this.name = name;
        this.price = price;
        this.availability = availability;
        this.category = category;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public boolean isAvailability() { return availability; }
    public void setAvailability(boolean availability) { this.availability = availability; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    // Polymorphism demo
    public String getDisplayLabel() {
        return name + " (" + category + ")";
    }
}
