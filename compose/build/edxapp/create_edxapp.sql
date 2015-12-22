-- This creates a utf8 database, however it breaks most of the migrations
-- CREATE DATABASE edxapp CHARACTER SET utf8 COLLATE utf8_general_ci;

-- This one creates a latin1 database that works but not sure if it is good.
-- However, it looks like edX uses this
CREATE DATABASE IF NOT EXISTS edxapp;
