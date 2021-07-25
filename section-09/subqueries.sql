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
SELECT
  name,
  price
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

-- Find users firstname, who ordered product with product_id = 3
SELECT first_name
FROM users
JOIN (
 	SELECT user_id
  FROM orders
  WHERE product_id = 3
) AS o
ON o.user_id = users.id;

-- Show the id of orders that involve a product with a price / weight ratio greater than 50
SELECT id
FROM orders
WHERE product_id
IN (
 	SELECT id
  FROM products
  WHERE price / weight > 50
);

-- Show the name of all products with a price greater than the average product price
SELECT name
FROM products
WHERE price > (
  SELECT AVG(price)
	FROM products
);

-- Show the name of all products that are not in the same department as products with a price less than 100
SELECT name
FROM products
WHERE department
NOT IN (
  SELECT department
  FROM products
  WHERE price < 100
);