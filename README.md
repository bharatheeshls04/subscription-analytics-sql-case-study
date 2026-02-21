# subscription-analytics-sql-case-study

## Project Overview
This project simulates a subscription app database and answers real business analytics questions using SQL.

Business questions covered:
- Who is paying vs failing?
- Which countries drive revenue?
- Who is active vs churned?
- Where are data gaps (subscriptions with no payments)?

## Tech Stack
- MySQL (tested in MySQL Workbench)
- SQL (JOINs, EXISTS/NOT EXISTS, conditional aggregation)

## Database Schema
Tables:
- `users` — user profile + country + signup date  
- `plans` — plan name + monthly price  
- `subscriptions` — subscription lifecycle (start/end dates)  
- `invoice` — payment records (Paid / Failed)

## How to Run (MySQL Workbench)
1. Open MySQL Workbench and connect to your local instance
2. Run the scripts in this order:

### Step 1 — Create schema
Run:
- `schema.sql`

### Step 2 — Insert sample data
Run:
- `data.sql`

### Step 3 — Run analysis queries
Run:
- `analysis_queries.sql`

## Tasks Completed
### Part A — Core Reporting (JOINs)
1. Subscription roster (user_name, country, plan_name, start_date, end_date)
2. Paid revenue by country (includes countries with 0 paid revenue)
3. Users with no subscription

### Part B — Data Quality + NULL traps
4. Subscriptions with no payments recorded
5. Active subscriptions as of 2025-03-15 (NULL-safe)

### Part C — Logic queries (EXISTS / NOT EXISTS)
6. Users who subscribed but never successfully paid
7. Plans ranked by paid revenue

### Part D — Analyst story output
8. Risk list: users with failed payments and no paid payment ever

## Key SQL Concepts Used
- LEFT JOIN preservation (avoiding NULL traps)
- Anti-joins using `NOT EXISTS`
- Conditional aggregation using `SUM(CASE WHEN ...)`
- Business logic filtering (active subscriptions, churn, revenue)

## Project Highlight (Analyst Insight)
Created a “high-risk” user segment:
- At least one Failed payment
- Zero Paid payments ever  
This segment is useful for churn prevention and payment recovery campaigns.

