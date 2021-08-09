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

-- Show the name, department and price of products that are more expensive than all products in the 'Industrial' department
SELECT
	name,
  department,
  price
FROM products
WHERE price > ALL (
 	SELECT price
  FROM products
  WHERE department = 'Industrial'
);

-- Show the name of products that are more expensive than at least one product in the 'Industrial' department
SELECT name
FROM products
WHERE price > SOME (
 	SELECT price
  FROM products
  WHERE department = 'Industrial'
);

-- Show the name, department and price of the most expensive product in each department
SELECT
  name,
  department,
	price
FROM products AS p1
WHERE p1.price = (
	SELECT MAX(price)
  FROM products AS p2
  WHERE p1.department = p2.department
);

-- Without using a join or a group by, print the number of orders for each product
SELECT
	id,
	name,
	(
  	SELECT COUNT(*)
    FROM orders AS o1
    WHERE o1.product_id = p1.id
  ) AS orders_per_product
FROM products AS p1;

-- Compute the cost to ship each item
-- Shipping is the maximum of (weight * $2) or $30
SELECT
	name,
  weight,
	GREATEST(
  	weight * 2,
    30
  ) AS cost_to_ship
FROM products;

-- All products are on sale!
-- Price is the least of the product's price * 0.5 or $400
SELECT
	name,
  price,
  LEAST(
    price * 0.5,
    400
  ) AS price_on_sale
FROM products;

-- Print each product and its price. Also print a description of the price
-- If price > 600 then 'high', If price > 300 then 'medium', else print 'cheap'
SELECT
	name,
  price,
	CASE
  	WHEN price > 600 THEN 'high'
    WHEN price > 300 THEN 'medium'
    ELSE 'cheap'
  END
FROM products;