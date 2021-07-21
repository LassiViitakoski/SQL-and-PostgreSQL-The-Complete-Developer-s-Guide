-- Tables structure

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR,
  last_name VARCHAR
);

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  department VARCHAR,
  price INTEGER,
  weight INTEGER
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  product_id INTEGER REFERENCES products(id),
  paid BOOLEAN
);

-- List the name and price of all products that are more
-- expensive than all products in the 'Toys' department
SELECT name, price
FROM products
WHERE price > (
	SELECT MAX(price)
  FROM products
  WHERE department = 'Toys'
);

-- Find the average number of orders for all users (There is more than one way to solve this - we are going to solve it using 'FROM' subquery)
SELECT
  AVG(p.orders_per_user)
FROM
  (
    SELECT
    	COUNT(*) AS orders_per_user
    FROM orders
    GROUP BY user_id
  ) AS p;