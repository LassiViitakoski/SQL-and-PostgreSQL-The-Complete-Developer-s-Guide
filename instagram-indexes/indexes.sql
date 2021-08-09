CREATE INDEX ON users (username);

DROP INDEX users_username_idx;


EXPLAIN ANALYZE
SELECT *
FROM users
WHERE username = 'Emil30';

-- With index:
-- Execution Time: 0.036 ms
-- Planning Time: 0.071 ms

-- Without index:
-- Execution time: 0.53 ms

-- WITH INDEX EXECUTING QUERY ABOVE IS 15 TIMES FASTER!!!

SELECT pg_size_pretty(pg_relation_size('users_username_idx'));
-- Searches size of users_username_idx file (184kb)

SELECT
	relname,
	relkind
FROM pg_class
WHERE relkind = 'i';
-- Searches all indexes inside database