-- Select the 3 users with the highest IDs from the users table
SELECT *
FROM users
ORDER BY id DESC
LIMIT 3;

-- Join the users and posts table.
-- Show the username of user ID 200 and
-- the captions of all posts they have created
SELECT
	users.username,
	posts.caption
FROM users
JOIN posts ON posts.user_id = users.id
WHERE users.id = 200;

-- Show each username and the number of
-- 'likes' they have created
SELECT
	username,
	COUNT(*)
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY username;