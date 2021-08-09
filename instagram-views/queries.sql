CREATE VIEW tags AS (
	SELECT
		id,
		created_at,
		user_id,
		post_id,
		'photo_tag' AS type
	FROM photo_tags
	UNION ALL
	SELECT
		id,
		created_at,
		user_id,
		post_id,
		'caption_tag' AS type
	FROM caption_tags
);

-- Show the most popular users - the users who were tagged the most
SELECT
	users.id,
	users.username,
	COUNT(*)
FROM users
JOIN tags ON users.id = tags.user_id
GROUP BY users.id
ORDER BY COUNT(*) DESC
LIMIT 10;


-- The 10 most recent posts are really important!
CREATE VIEW recent_posts AS (
	SELECT *
	FROM posts
	ORDER BY created_at DESC
	LIMIT 10
);

SELECT username
FROM recent_posts
JOIN users ON users.id = recent_posts.user_id;


-- Deleting or changing Views
CREATE OR REPLACE VIEW recent_posts AS (
	SELECT * FROM posts
	ORDER BY created_at DESC
	LIMIT 15
);

DROP VIEW recent_posts;






