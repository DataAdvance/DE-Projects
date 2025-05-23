# Inventory and Order Management System (SQL Project)

## 📦 Project Overview
This project implements a relational database system for managing inventory, orders, and customer data for an e-commerce business. It includes:
- Table definitions with integrity constraints
- Stored procedures for placing orders and replenishing stock
- Triggers for inventory logging
- Views for business insights and customer analytics

---

## 🗂️ Folder Structure

| File Name                  | Purpose                                             |
|---------------------------|-----------------------------------------------------|
| `01_create_tables.sql`    | Defines all necessary tables with constraints       |
| `02_views.sql`            | Provides simplified reporting through SQL views     |
| `03_stored_procedures.sql`| Handles order placement and stock replenishment     |
| `04_triggers.sql`         | Automates stock deduction and inventory logging     |

---

## 🧱 Table Descriptions

- **products**: Product catalog with pricing and stock tracking.
- **customers**: Customer details.
- **orders**: Header record for each transaction.
- **order_details**: Line items for each order.
- **inventory_logs**: Audit table for all stock changes.

---

## ⚙️ Stored Procedures

- `place_order(p_customer_id, p_product_id, p_quantity, p_unit_price)`  
  Places a new order for a customer and deducts stock accordingly.

- `replenish_stock(p_replenish_quantity)`  
  Automatically adds stock to products below their reorder level and logs the change.

---

## 🔁 Triggers

- `after_order_detail_insert`  
  Automatically deducts stock and logs the transaction when a new order item is added.

---

## 🔍 Views

- `order_summary_view`  
  Shows total amount and item count per order, per customer.

- `low_stock_view`  
  Flags products with stock levels below their reorder threshold.

- `customer_tiers_view`  
  Categorizes customers into Bronze, Silver, or Gold based on total spending.

---

## 🚀 Getting Started

1. Run `01_create_tables.sql` to create the schema.
2. (Optional) Insert sample data.
3. Run `03_stored_procedures.sql` and `04_triggers.sql` to add logic.
4. Run `02_views.sql` to create views.
5. Use `CALL place_order(...)` and `CALL replenish_stock(...)` to test.

---

## ✅ Requirements

- MySQL 5.7+ (for JSON and view support)
- SQL client or CLI for script execution

---

## 📌 Notes

- All operations are transaction-safe.
- Inventory changes are logged for audit purposes.
- Easily extendable to support discounts, refunds, or promotions.