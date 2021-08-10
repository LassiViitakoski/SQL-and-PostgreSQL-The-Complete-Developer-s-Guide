const app = require('./src/app');
const pool = require('./src/pool');
const dotenv = require('dotenv');

dotenv.config();

pool
  .connect({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: process.env.DB_DATABASE,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD
  })
  .then(() => {
    const server = app().listen(3000, () => {
      console.log(`Server running on port ${server.address().port}`);
    });
  })
  .catch(err => {
    console.error(err);
  });
