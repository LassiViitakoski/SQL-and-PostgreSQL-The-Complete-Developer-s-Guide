/* eslint-disable camelcase */

exports.shorthands = undefined;

exports.up = pgm => {
  pgm.sql(`
    CREATE TABLE posts (
      id SERIAL PRIMARY KEY,
      created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
      url VARCHAR(300),
      lat NUMERIC,
      lng NUMERIC
    );
  `);
};

exports.down = pgm => {
  pgm.sql(`
    DROP TABLE posts;
  `);
};
