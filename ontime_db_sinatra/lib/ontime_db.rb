require "pg"

module OntimeDB
  # connection to database
  @db = PG::Connection.open(dbname: 'mks')
  # database tables
  @movies_table = "on_time_perf"

  def self.airlines
    sql = %[
      select carrier, count(dep_delay_new) + count(arr_delay_new) as delays
      from on_time_perf
      where arr_delay_new > 0
      and dep_delay_new > 0
      group by carrier
      order by delays desc
    ]

    @db.exec sql
  end
end

# result = OntimeDB.airlines

# result.each {|airline| puts airline["carrier"]}
