# Online Bookstore Database & Business Analysis (PostgreSQL)

## 📌 Project Overview
This project demonstrates the creation, data ingestion, and deep analytical querying of an **Online Bookstore** database using **PostgreSQL**. The system manages operational information across books, customer profiles, and transactional orders to extract key business performance metrics.

## 🛠️ Tech Stack
* **Database Management System:** PostgreSQL 18
* **Language:** SQL (Data Definition Language & Data Manipulation Language)

## 📊 Database Schema & Architecture
The system relies on three interconnected tables structured as follows:
* **Books:** Tracks inventory profiles including `Book_id`, `Title`, `Author`, `Genre`, `Published_year`, `Price`, and current `Stock`.
* **Customers:** Manages user demographics tracking `Customer_id`, `Name`, `Email`, `Phone`, `City`, and `Country`.
* **Orders:** Bridges customers and inventory using foreign keys (`Customer_id`, `Books_id`), logging the transaction `Order_date`, `Quantity` purchased, and the `Total_amount` billed.

## 🔍 Key Business Questions Answered
The project addresses 20 critical business queries divided into core operational pillars:

### 1. Inventory & Catalog Insights
* Filtering catalog segments (e.g., extracting all **'Fiction'** genre items or identifying books published after **1950**).
* Tracking lowest inventory thresholds to prevent stockouts.
* Calculating remaining stock metrics after subtracting total sold units (`Stock - SUM(Quantity)`).

### 2. Customer Segmentation
* Locating global market distribution (e.g., retrieving lists of high-value shoppers located in specific countries like **Canada**).
* Identifying regular users who have interacted with the bookstore by placing **at least 2 distinct orders**.

### 3. Financial Performance & Sales Metrics
* Calculating total revenue metrics generated from all order transactions combined.
* Tracking targeted time-bound revenue trends (e.g., pulling exact sales data for **November 2023**).
* Isolating top-tier spending metrics to determine the single most valuable customer profile.
