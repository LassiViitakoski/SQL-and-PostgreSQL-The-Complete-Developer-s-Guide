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

-- Users can comment on photos that they posted.
-- List the url and contents for every photo/comment where this occured
SELECT
  url,
  contents
FROM
  comments
  JOIN photos ON photos.id = comments.photo_id
WHERE
  comments.user_id = photos.user_id;

-- Same thing as above but with three way join and with username printed also
SELECT
  url,
  contents,
  username,
FROM
  comments
  JOIN photos ON photos.id = comments.photo_id
  JOIN users ON users.id = comments.user_id
  AND users.id = photos.user_id;