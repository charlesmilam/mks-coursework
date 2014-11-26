require "pg"
require "json"
require "rest-client"

class Petshop
  def initialize
    # make connection to database
    @db = PG::Connection.open(dbname: 'petshop')
    @shops_table = "shops"
    @dogs_table = "dogs"
    @cats_table = "cats"
  end

  # create database tables
  def make_tables
    sql_create_petshop = %Q[
      create table if not exists petshop
      (id serial primary key, name varchar)
    ]

    sql_create_cats = %Q[
      create table if not exists cats
      (id integer, name varchar)
    ]

    sql_create_dogs = %Q[
      create table if not exists dogs
      (id integer,
      name varchar,
      image_url varchar,
      happiness integer,
      adopted_status
      )
    ]
    
    @db.exec(sql_create_table)
  end

end 

petshop = Petshop.new

petshop.make_tables