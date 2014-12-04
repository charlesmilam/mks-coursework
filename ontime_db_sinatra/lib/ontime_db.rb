require "pg"

module OntimeDB
  # connection to database
  @db = PG::Connection.open(dbname: 'mks')
  # database tables
  @movies_table = "on_time_perf"

  def self.airlines
    sql = %Q[
      select carrier, count(dep_delay_new) + count(arr_delay_new) as delays
      from on_time_perf
      where arr_delay_new > 0
      and dep_delay_new > 0
      group by carrier
      order by delays desc
    ]

    @db.exec sql
  end

  def self.arrival_delays
    results = []
    sql_most = %Q[
      select carrier, avg(arr_delay_new) as delays
      from on_time_perf
      where arr_delay_new > 0
      group by carrier
      order by delays desc
      limit 1
    ]

    sql_least = %Q[
      select carrier, avg(arr_delay_new) as delays
      from on_time_perf
      where arr_delay_new > 0
      group by carrier
      order by delays asc
      limit 1
    ]

    most = @db.exec sql_most
    results << most.first
    least = @db.exec sql_least
    results << least.first
    return results
  end

  def self.city_depart_delays
    results = []
    sql_most = %Q[
      select origin_city_name, count(dep_delay_new) as delays
      from on_time_perf
      where dep_delay_new > 0
      group by origin_city_name
      order by delays desc
      limit 1
    ]

    sql_least = %Q[
      select origin_city_name, count(dep_delay_new) as delays
      from on_time_perf
      where dep_delay_new > 0
      group by origin_city_name
      order by delays asc
      limit 1
    ]

    data = @db.exec sql_most
    results << data.first
    data = @db.exec sql_least
    results << data.first
    results
  end

end

#result = OntimeDB.city_depart_delays

# result.each {|airline| puts airline["carrier"]}
#p result
