# 🍔 Food Delivery Management System

A Java/JSP-based web application for managing food delivery operations, built with Maven and MySQL.

## 🏗️ Tech Stack

- **Backend:** Java Servlets, JSP, JSTL
- **Database:** MySQL 8.0
- **Build Tool:** Maven
- **Server:** Apache Tomcat

## 📁 Project Structure

The project is organized into **5 independent modules** for team collaboration:

| Module | Folder | Description |
|--------|--------|-------------|
| Customer | `mod_customer/` | User registration, login, profiles |
| Restaurant & Menu | `mod_restaurant/` | Restaurant & menu CRUD, owner dashboard |
| Orders | `mod_orders/` | Cart, checkout, order tracking |
| Delivery | `mod_delivery/` | Agent management, delivery tracking |
| Billing | `mod_billing/` | Payments, reviews, statistics |

## 🚀 Setup Instructions

### Prerequisites
- JDK 8+
- Apache Tomcat 9+
- MySQL 8.0+
- Maven 3.6+

### Database Setup
```sql
CREATE DATABASE foodhub;
```
Update the database connection settings in:
`src/main/java/com/foodhub/util/DBConnection.java`

### Build & Deploy
```bash
mvn clean package
# Deploy the generated .war file from target/ to Tomcat
```

## 👥 Team

See [CONTRIBUTING.md](CONTRIBUTING.md) for team roles and Git workflow.

## 📄 License

This project is for educational purposes.
