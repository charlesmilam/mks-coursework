require "pg"

class Classmates

  # make connection to database
  def initialize
    @db = PG::Connection.open(dbname: 'mks')
  end
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
    fname = gets.chomp

    puts "Enter user last name: "
    lname = gets.chomp

    puts "Enter user twitter id: "
    twitter = gets.chomp

    insert_classmate = "insert into #{tbl} (first_name, last_name, twitter) values ('#{fname}', '#{lname}', '#{twitter}')"

    db.exec(insert_classmate)

  end

  def view_all_classmates(db, tbl)
    view_all = "select * from #{tbl}"
    result = db.exec(view_all)

    # output all classmates
    result.each {|rec| puts rec["id"], rec["first_name"], rec["last_name"]}
  end

  def remove_classmate(db, tbl)
    puts "Enter classmate id: "
    classmate_id = gets.chomp

    # delete classmate with given id
    delete_classmate = "delete from #{tbl} where id = '#{classmate_id}'"
    db.exec(delete_classmate)
  end

  def edit_classmate_twitter(db, tbl)
    puts "Enter id of classmate to edit: "
    classmate_id = gets.chomp

    puts "Enter new twitter name: "
    new_twitter = gets.chomp

    edit_twitter = "update #{tbl} set twitter = '#{new_twitter}' where id = '#{classmate_id}' "
    db.exec(edit_twitter)
  end
end

# basic query to db
select_all = "select * from #{tbl}"#
result = db.exec(select_all)

# output results of result set
result.each {|rec| puts rec}

puts "Add new classmate"
add_new_classmate(db, tbl)
view_all_classmates(db, tbl)
puts "Edit classmate"
edit_classmate_twitter(db, tbl)
view_all_classmates(db, tbl)
puts "Remove classmate"
remove_classmate(db, tbl)
view_all_classmates(db, tbl)