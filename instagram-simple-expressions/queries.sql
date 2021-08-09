-- Show the username of users who were tagged in
-- a caption or photo before January 7th, 2010

-- Common table expression (CTE)
WITH tags AS (
	SELECT
		user_id,
		created_at
	FROM caption_tags
	UNION ALL
	SELECT
		user_id,
		created_at
	FROM photo_tags
)
SELECT
	users.username,
	tags.created_at
FROM users
JOIN tags ON users.id = tags.user_id
WHERE tags.created_at < '2010-01-07';