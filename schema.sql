CREATE DATABASE subscription_app;
USE subscription_app;

-- Users
CREATE TABLE users (
  user_id INT PRIMARY KEY,
  user_name VARCHAR(50),
  country VARCHAR(50),
  signup_date DATE
);

-- Plans
CREATE TABLE plans (
  plan_id INT PRIMARY KEY,
  plan_name VARCHAR(50),
  monthly_price DECIMAL(10,2)
);

-- Subscriptions (a user may subscribe, cancel, upgrade etc.)
CREATE TABLE subscriptions (
  subscription_id INT PRIMARY KEY,
  user_id INT,
  plan_id INT,
  start_date DATE,
  end_date DATE NULL
);

-- Payments (not every subscription has payments recorded, failures exist)
CREATE TABLE invoice (
  payment_id INT PRIMARY KEY,
  subscription_id INT,
  payment_date DATE,
  amount DECIMAL(10,2),
  status VARCHAR(20) -- 'Paid', 'Failed'
);