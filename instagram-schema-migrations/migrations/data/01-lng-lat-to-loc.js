require('dotenv').config();

const pg = require('pg');

const pool = new pg.Pool({
  host: 'localhost',
  port: 5432,
  database: 'socialnetwork',
  user: 'postgres',
  password: process.env.DB_PASSWORD
});

pool
  .query(
    `
    UPDATE posts
    SET loc = POINT(lng, lat)
    WHERE loc IS NULL;
  `
  )
  .then(() => {
    console.log('Update completed!');
    pool.end();
  });
