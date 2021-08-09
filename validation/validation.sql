UPDATE products
SET price = 999
WHERE price is NULL;

ALTER TABLE products
ALTER COLUMN price
SET NOT NULL;

-- In this case you can add multiple same name or department
-- but not row where name and department both are same as some other row
ALTER TABLE products
ADD UNIQUE(name, department);

ALTER TABLE products
DROP CONSTRAINT products_name_key;

ALTER TABLE products
ADD CHECK (price > 0);

CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) NOT NULL,
	created_at TIMESTAMP NOT NULL,
	est_delivery TIMESTAMP NOT NULL,
	CHECK (created_at < est_delivery)
);