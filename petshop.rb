require "pg"
require "json"
require "rest-client"

class PetshopSetup
  def initialize
    # connection to database
    @db = PG::Connection.open(dbname: 'petshop')
    # database tables
    @shops_table = "petshops"
    @dogs_table = "dogs"
    @cats_table = "cats"
    # api url
    @api = "http://pet-shop.api.mks.io/"
    # api resources
    @shops = "shops/"
    @cats = "cats/"
    @dogs = "dogs/"
    
  end

  # create database tables
  def make_tables
    sql_create_petshops = %Q[
      create table if not exists #{@shops_table}
      (id integer primary key, 
      name varchar not null
      )
    ]

    sql_create_cats = %Q[
      create table if not exists #{@cats_table}
      (id integer primary key, 
      name varchar not null,
      image_url varchar null,
      adopted varchar null,
      shop_id integer references petshops
      )
    ]

    sql_create_dogs = %Q[
      create table if not exists #{@dogs_table}
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

  # populate petshops table
  def populate_petshops
    result =  JSON.parse(RestClient.get @api + @shops)
    
    # prepared statement
    statement_insert_shop = %Q[ 
        insert into #{@shops_table}
        (id, name)
        values ($1, $2)
      ]
    @db.prepare("insert_shops", statement_insert_shop)

    # populate table using prepared statement  
    result.each do |shop|
      @db.exec_prepared("insert_shops", [shop["id"], shop["name"]])
    end
  end

  # populate cats table
  def populate_cats
    result = JSON.parse(RestClient.get @api + @shops + "1/" + @cats)
    
    # prepared statement
    statement_insert_shop = %Q[ 
        insert into #{@cats_table}
        (id, name, image_url, adopted, shop_id)
        values ($1, $2, $3, $4, $5)
      ]
    @db.prepare("insert_cats", statement_insert_shop)

    # populate table using prepared statement  
    result.each do |cat|
      @db.exec_prepared("insert_cats", [cat["id"], cat["name"], cat["imageUrl"], cat["adopted"], cat["shopId"] ])
    end
  end

end 

petshop = PetshopSetup.new

petshop.make_tables
petshop.populate_petshops
petshop.populate_cats