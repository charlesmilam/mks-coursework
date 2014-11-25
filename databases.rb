require "pg"

# make connection to database
conn = PG::Connection.open(:dbname => 'mks')

# output the connected database name and user
puts conn.db 
puts conn.user