require "pg"

# make connection to database
db = PG::Connection.open(:dbname => 'mks')

# output the connected database name and user
puts db.db 
puts db.user

# create new table, if it does not already exist
create_table = "create table if not exists classmates (id serial primary key, first_name varchar, last_name varchar, twitter varchar) "
db.exec(create_table)