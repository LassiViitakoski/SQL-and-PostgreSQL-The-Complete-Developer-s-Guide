CREATE TABLE accounts (
	id SERIAL PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	balance INTEGER NOT NULL,
	CHECK(balance > 0)
);

INSERT INTO accounts
	(name, balance)
VALUES
	('Gia', 100),
	('Alyson', 100);
	

BEGIN;

UPDATE accounts
SET balance = balance + 50
WHERE name = 'Alyson';

UPDATE accounts
SET balance = balance - 50
WHERE name = 'Gia';

COMMIT;