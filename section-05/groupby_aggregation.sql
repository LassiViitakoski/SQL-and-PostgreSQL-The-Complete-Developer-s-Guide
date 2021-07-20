-- Tables structure
CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  username VARCHAR(50)
);
 
CREATE TABLE photos (
  id SERIAL PRIMARY KEY,
  url VARCHAR(200),
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);
 
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  contents VARCHAR(240),
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  photo_id INTEGER REFERENCES photos(id) ON DELETE CASCADE
);

-- Find the number of comments for each photo
SELECT
  photo_id,
  COUNT(*)
FROM
  comments
GROUP BY
  photo_id;

-- Find the number of comments for each photo where the photo_id is
-- less than 3 and the photo has more than 2 comments
SELECT
  photo_id,
  COUNT(*) AS comments_per_photo
FROM
  comments
WHERE
  photo_id  3
GROUP BY
  photo_id
HAVING
  COUNT(*) > 2;

-- Fint the users (user_ids) where the user has commented on the first 50 photos
-- and the user added more than 20 comments on those photos

SELECT
  COUNT(*) AS comments_count,
  user_id
FROM
	comments
WHERE
	photo_id <= 50
GROUP BY
	user_id
HAVING
	COUNT(*) > 20;