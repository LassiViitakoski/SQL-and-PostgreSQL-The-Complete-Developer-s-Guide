EXPLAIN
SELECT
	username,
	contents
FROM users
JOIN comments ON comments.user_id = users.id
WHERE username = 'Alyson14';

-- SELECT *
-- FROM pg_stats
-- WHERE tablename = 'users';