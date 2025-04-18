# Inventory and Order Management System

## Project Description

This project involves designing and implementing a database-driven system to manage inventory and orders for an e-commerce company. The system efficiently handles product information, customer data, and order processing, ensuring proper updates to stock levels when orders are placed. It also tracks all inventory changes and streamlines stock replenishment processes. The system provides insights into customer purchase behaviors, monitors stock levels, and ensures product availability for sale.  The solution supports day-to-day operations like placing orders, updating inventory, and summarizing business metrics, such as order summaries and customer spending. 

## Phase 1: Database Design and Schema Implementation

### Tables

The database schema includes the following tables:

* **Products:**
    * Attributes: product ID, name, category, price, stock quantity, and reorder level.
* **Customers:**
    * Attributes: customer ID, name, email, and phone number. 
* **Orders:**
    * Attributes: order ID, customer ID, order date, and total amount. 
* **Order Details:**
    * Attributes: order ID, product ID, quantity, and price. 
* **Inventory Logs:**
    * Attributes: log ID, product ID, change date, change quantity, and reason. 

### Data Integrity

The design enforces data integrity by implementing relationships between tables.  For example, each order is linked to a valid customer, and order details correspond to valid products.

## Phase 2: Order Placement and Inventory Management

### Order Placement

The system processes new orders from customers, ensuring that the correct quantity is deducted from the stock and the total order amount is calculated. It handles multiple products in a single order.  Order details are updated, and stock usage is tracked.

### Inventory Tracking

Inventory changes, such as those due to orders or stock replenishment, are recorded in the `InventoryLogs` table. The log stores information about when the change occurred, which product was affected, and how much the stock changed. The system allows for retrieval of inventory change history for auditing purposes. 

## Phase 3: Monitoring and Reporting

### Business Insights and Summaries

The system displays summaries of orders, including details such as order date, total amount, and the number of items ordered for each customer. It generates reports showing products that are low on stock and need replenishment.  Products with stock levels below their reorder point are flagged for replenishment.

### Customer Insights

The system provides insights into customer spending habits, categorizing customers based on their total spending (e.g., Bronze, Silver, Gold tiers) and generating reports showing total spending.  It also supports bulk discounts, applying discounts based on the number of items purchased in large quantities. 

## Phase 4: Stock Replenishment and Automation

### Stock Replenishment

The system replenishes stock levels for products that fall below the reorder point. [cite: 61, 62] The inventory log is updated to reflect these changes. 

### Automation

The system automates tasks such as updating stock levels after an order, calculating the total amount for an order, and categorizing customers based on their spending habits.  The solution minimizes manual work while ensuring accuracy in inventory tracking and order management. 

## Phase 5: Advanced Queries and Optimizations

### Views

The system uses views to simplify data access:

* A view summarizes order information, showing details such as customer name, order date, total amount, and the number of items in each order. 
* A view displays stock information, showing which products are low on stock and need to be reordered.
### Performance Optimization

The system is optimized for performance to ensure efficiency as the number of customers, orders, and products grows.

## Deliverables

The project deliverables include:

1.  **Database Schema:** SQL scripts used to create tables, along with relationships and constraints.
2.  **SQL Queries:** SQL queries demonstrating order placement, stock updates, inventory tracking, and customer categorization based on spending. 
3.  **Views:** SQL scripts for views created to summarize order and product stock information.
4.  **Replenishment System:** Demonstration of how the system identifies low stock products and replenishes them. 
5.  **Report Summaries:** Sample queries that retrieve order summaries and stock insights. 
