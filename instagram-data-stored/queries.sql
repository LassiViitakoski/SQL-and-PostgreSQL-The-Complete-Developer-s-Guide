
SHOW data_directory;
-- Shows path where all the data is stored in machine where Postgres is running
-- C:/Program Files/PostgreSQL/13/data
-- Inside data directory all the database data is saved in base directory


SELECT oid, datname
FROM pg_database;
-- Gives directory names inside base directory that which database
-- refers to which number

SELECT * FROM pg_class;
-- Gives information of files which locate inside instagram (24610) directory