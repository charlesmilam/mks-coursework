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
    # prepared statement
    statement_insert_shop = %Q[ 
        insert into #{@cats_table}
        (id, name, image_url, adopted, shop_id)
        values ($1, $2, $3, $4, $5)
      ]
    @db.prepare("insert_cats", statement_insert_shop)

    # query for existing shops
    sql_shops = %Q[select * from #{@shops_table}]
    result_shops = @db.exec(sql_shops)

    # iterate through shops
    result_shops.each do |shop|
      result_cats = JSON.parse(RestClient.get @api + @shops + shop["id"] + "/" + @cats)

      # populate table using prepared statement  
      result_cats.each do |cat|
        @db.exec_prepared("insert_cats", [cat["id"].to_i, cat["name"], cat["imageUrl"], cat["adopted"], cat["shopId"].to_i])
      end
    end
  end

  # populate dogs table
  def populate_dogs
    # prepared statement
    statement_insert_shop = %Q[ 
        insert into #{@dogs_table}
        (id, name, image_url, happiness, adopted, shop_id)
        values ($1, $2, $3, $4, $5, $6)
      ]
    @db.prepare("insert_dogs", statement_insert_shop)

    # query for existing shops
    sql_shops = %Q[select * from #{@shops_table}]
    result_shops = @db.exec(sql_shops)

    # iterate through shops
    result_shops.each do |shop|
      result_cats = JSON.parse(RestClient.get @api + @shops + shop["id"] + "/" + @dogs)

      # populate table using prepared statement  
      result_cats.each do |dog|
        @db.exec_prepared("insert_dogs", [dog["id"].to_i, dog["name"], dog["imageUrl"], dog["happiness"].to_i, dog["adopted"], dog["shopId"].to_i])
      end
    end
  end

end 

petshop = PetshopSetup.new

petshop.make_tables
petshop.populate_petshops
petshop.populate_cats
petshop.populate_dogs