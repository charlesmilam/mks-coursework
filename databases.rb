require "pg"

# make connection to database
db = PG::Connection.open(:dbname => 'mks')

# table being used
tbl = "classmates"

# output the connected database name and user
puts db.db 
puts db.user

# create new table, if it does not already exist
create_table = "create table if not exists #{tbl} (id serial primary key, first_name varchar, last_name varchar, twitter varchar) "
db.exec(create_table)

# query db for table makeup information
# db_col_info = "\\d+ classmates"
# db.exec(db_col_info)

def add_new_classmate(db, tbl)
  puts "Enter user first name: "
  user_fname = gets.chomp

  puts "Enter user last name: "
  user_lname = gets.chomp

  puts "Enter user twitter id: "
  user_twitter = gets.chomp

  insert_user = "insert into #{tbl} (first_name, last_name, twitter) values ('#{user_fname}', '#{user_lname}', '#{user_twitter}')"
  puts insert_user

  db.exec(insert_user)

end

def view_all_classmates(db, tbl)

end


# # basic query to db
# select_all = "select * from #{tbl}"#
# result = db.exec(select_all)

# # output results of result set
# result.each {|rec| puts rec}

add_new_classmate(db, tbl)