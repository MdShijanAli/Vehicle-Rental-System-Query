# Vehicle Rental System - Database Design & SQL Queries

A comprehensive database solution for managing vehicle rental operations, including user management, vehicle inventory, and booking system.

## 📋 Table of Contents

- [Overview](#overview)
- [Database Schema](#database-schema)
- [SQL Queries Documentation](#sql-queries-documentation)
- [Resources](#resources)

## 🎯 Overview

This project demonstrates a complete database design and implementation for a vehicle rental system. It includes a normalized relational database schema with multiple entities and complex SQL queries to handle various business requirements.

### Key Features

- **User Management**: Store and manage customer information
- **Vehicle Inventory**: Track different types of vehicles and their availability
- **Booking System**: Handle rental bookings with date tracking and status management
- **Advanced Queries**: Complex SQL queries for business intelligence and reporting

## 🗂️ Database Schema

The database consists of three main entities:

- **Users**: Customer information and contact details
- **Vehicles**: Vehicle inventory with type, status, and specifications
- **Bookings**: Rental transactions linking users and vehicles

### ER Diagram

View the complete Entity-Relationship diagram here:  
🔗 [Vehicle Rental System - ER Diagram](https://drawsql.app/teams/shijan/diagrams/vehicle-rental-system)

## 📊 SQL Queries Documentation

### Query 1: Retrieve Booking Information with Customer and Vehicle Details

```sql
SELECT b.booking_id, u.name AS customer_name, v.name AS vehicle_name,
       start_date, end_date, b.status
FROM users AS u
INNER JOIN bookings AS b ON b.user_id = u.user_id
INNER JOIN vehicles AS v ON v.vehicle_id = b.vehicle_id;
```

**Purpose**: This query provides a comprehensive view of all bookings in the system.

**How it works**:

- Performs an **INNER JOIN** between three tables: `users`, `bookings`, and `vehicles`
- First joins `users` with `bookings` using the `user_id` foreign key
- Then joins the result with `vehicles` using the `vehicle_id` foreign key
- Returns a consolidated view showing who booked which vehicle and when
- Displays booking status for tracking active, completed, or cancelled reservations

**Use Case**: Perfect for generating booking reports, customer service inquiries, and rental history tracking.

---

### Query 2: Find All Vehicles That Have Never Been Booked

```sql
SELECT * FROM vehicles
WHERE NOT EXISTS (
  SELECT vehicle_id FROM bookings
  WHERE vehicle_id = vehicles.vehicle_id
);
```

**Purpose**: Identify unused inventory - vehicles that have never been rented.

**How it works**:

- Uses a **correlated subquery** with the `NOT EXISTS` operator
- For each vehicle in the outer query, checks if there's any matching booking
- The subquery searches for the vehicle's ID in the bookings table
- If no matching booking exists, the vehicle is included in the results
- More efficient than `NOT IN` for large datasets as it stops searching once a match is found

**Use Case**: Helps identify underutilized vehicles, supports inventory optimization decisions, and can highlight vehicles that may need better marketing or pricing strategies.

---

### Query 3: Retrieve All Available Vehicles of a Specific Type

```sql
SELECT * FROM vehicles
WHERE status = 'available' AND type = 'car';
```

**Purpose**: Find rentable vehicles matching customer requirements.

**How it works**:

- Applies a **compound WHERE clause** with two conditions using `AND` operator
- First condition filters by `status = 'available'` to ensure the vehicle can be rented
- Second condition filters by `type = 'car'` (can be modified for other types like 'bike', 'truck', etc.)
- Both conditions must be true for a vehicle to be included
- Direct table scan with indexed columns for optimal performance

**Use Case**: Essential for customer-facing applications where users search for available vehicles. Can be easily modified to filter by different vehicle types (motorcycles, trucks, SUVs, etc.).

---

### Query 4: Find Total Bookings Per Vehicle (Vehicles with More Than 2 Bookings)

```sql
SELECT v.name AS vehicle_name, COUNT(*) AS total_bookings
FROM bookings AS b
INNER JOIN vehicles AS v ON v.vehicle_id = b.vehicle_id
GROUP BY vehicle_name
HAVING COUNT(*) > 2;
```

**Purpose**: Identify the most popular vehicles in the rental fleet.

**How it works**:

- Joins `bookings` with `vehicles` to access vehicle names
- Uses **GROUP BY** to aggregate bookings by vehicle name
- `COUNT(*)` calculates total bookings for each vehicle
- **HAVING** clause filters the grouped results to show only vehicles with more than 2 bookings
- Note: `HAVING` is used instead of `WHERE` because filtering happens after aggregation

**Use Case**: Business intelligence for identifying high-demand vehicles, informing purchasing decisions for fleet expansion, and recognizing which vehicles generate the most revenue.

---

## 📚 Resources

### Theory Questions - Viva Practice

**Video Tutorial**: Theory Questions (Viva Practice - Progress, Not Perfection)  
🎥 [Watch Video](https://drive.google.com/file/d/1FTXaYClzwhCzk54ZKrLvKx91-1rXz6_H/view?usp=sharing)

This video covers theoretical concepts and common viva questions related to:

- Database normalization
- SQL query optimization
- Indexing strategies
- Transaction management
- ER diagram interpretation

---

## 🛠️ Technologies Used

- **Database**: SQL (Compatible with MySQL, PostgreSQL, SQLite)
- **Design Tool**: DrawSQL for ER diagrams
- **Version Control**: Git & GitHub

## 📝 License

This project is created for educational purposes.

---

**Project Maintainer**: Shijan  
**Last Updated**: December 2025

---

_For any questions or contributions, feel free to reach out or submit a pull request._
