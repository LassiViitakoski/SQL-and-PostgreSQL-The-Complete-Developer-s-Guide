-- For each week, show the number of likes that posts and comments
-- received. Use the post and comment created_at, not when the like was received
CREATE MATERIALIZED VIEW weekly_likes AS (
	SELECT
		date_trunc(
			'week',
			COALESCE(posts.created_at, comments.created_at)
		) AS week,
		COUNT(posts.id) AS num_likes_for_posts,
		COUNT(comments.id) AS num_likes_for_comments
	FROM likes
	LEFT JOIN posts ON posts.id = likes.post_id
	LEFT JOIN comments ON comments.id = likes.comment_id
	GROUP BY week
	ORDER BY week
) WITH DATA;

SELECT * FROM weekly_likes;

REFRESH MATERIALIZED VIEW weekly_likes;
-- Päivittää weekly_likes taulun, esim. jos posts taulusta poistetaan rivejä, täytyy ajaa refresh komento, jotta weekly_likes taulukko päivittyy