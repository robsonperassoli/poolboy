-- migrate:up
CREATE TABLE IF NOT EXISTS pools(
   id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
   volume INTEGER NOT NULL
);


-- migrate:down
drop table if exists pools;
