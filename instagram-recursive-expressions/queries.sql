-- WITH RECURSIVE countdown(val) AS (
-- 	SELECT 3 AS val -- Initial, Non-recursive query
-- 	UNION
-- 	SELECT val - 1 -- Recursive query
-- 	FROM countdown
-- 	WHERE val > 1
-- )
-- SELECT *
-- FROM countdown;

WITH RECURSIVE suggestions(leader_id, follower_id, depth) AS (
	SELECT
		leader_id,
		follower_id,
		1 AS depth
	FROM followers
	WHERE follower_id = 1
	UNION
	SELECT
		followers.leader_id,
		followers.follower_id,
		depth + 1
	FROM followers
	JOIN suggestions ON suggestions.leader_id = followers.follower_id
	WHERE depth < 2
)
SELECT DISTINCT
	users.id,
	users.username
FROM suggestions
JOIN users ON users.id = suggestions.leader_id
WHERE depth > 1
LIMIT 5;


