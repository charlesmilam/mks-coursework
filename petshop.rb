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
    sql_create_petshops = %Q[
      create table if not exists petshops
      (id integer primary key, 
      name varchar not null
      )
    ]

    sql_create_cats = %Q[
      create table if not exists cats
      (id integer primary key, 
      name varchar not null,
      image_url varchar null,
      adopted varchar null,
      shop_id integer references petshops
      )
    ]

    sql_create_dogs = %Q[
      create table if not exists dogs
      (id integer primary key,
      name varchar not null,
      image_url varchar null,
      happiness integer constraint five_or_less check (happiness <= 5),
      adopted varchar null,
      shop_id integer references petshops
      )
    ]
    
    @db.exec(sql_create_petshops)
    @db.exec(sql_create_cats)
    @db.exec(sql_create_dogs)
  end

end 

petshop = Petshop.new

petshop.make_tables