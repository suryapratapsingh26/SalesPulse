## SalesPulse

SalesPulse is an end-to-end **Sales & Lead Analytics** project built using **MySQL and Microsoft Power BI**.

The project demonstrates how raw sales data can be stored and analyzed in a relational database using SQL, transformed into analytics-ready views, and visualized through an interactive Power BI dashboard.

## Dashboard

### Sales Overview

<img width="1171" height="658" alt="image" src="https://github.com/user-attachments/assets/fe4358f1-5bae-4471-9276-3d695a56e8f6" />


The dashboard provides an overview of:

- Total Revenue
- Total Orders
- Units Sold
- Average Order Value
- Monthly Revenue Trend
- Revenue by Category
- Revenue by Region

## Tech Stack

- **Database:** MySQL 8
- **Data Analysis:** SQL
- **Visualization:** Microsoft Power BI
- **Version Control:** Git & GitHub

## Project Architecture

```text
Raw Sales Data
      |
      v
    MySQL
      |
      +----------------------+
      |                      |
      v                      v
 Basic & Advanced SQL     Analytics Views
      |                      |
      +----------+-----------+
                 |
                 v
           Power BI
                 |
                 v
        Interactive Dashboard
