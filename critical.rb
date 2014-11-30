require "rest-client"

url_restaurant = "http://critics.api.mks.io/restaurants"
url_movie = "http://critics.api.mks.io/movie-genres"
url_cheese = "http://critics.api.mks.io/cheeses"


def data_factory(url)
    response = RestClient.get(url)
    array = JSON.parse(response).to_a
end

data_restaurant = data_factory(url_restaurant)
data_movie = data_factory(url_movie)
data_cheese = data_factory(url_cheese)

###################################################

def best_restaurant(data)
    data.select {|restaurant| restaurant["rating"].to_i >= 8  }
end

puts best = best_restaurant(data_restaurant).sort_by {|rating| rating["rating"].to_i}.map { |restaurant| "#{restaurant["rating"]} - #{restaurant["venue"]}" }.reverse

puts "===================================================================="

def austin_restaurant(data)
    data.select {|restaurant| restaurant["venue"].downcase.include?("austin") }
end

puts austin = "Austin Restaurants:\n #{austin_restaurant(data_restaurant).map {|restaurant| "#{restaurant["venue"]}"}}"
puts "===================================================================="

def fave_most(movies)
    most_fave = Hash.new(0)
    movies.each {|movie| most_fave[movie["genre"]] += 1}
    return most_fave.sort_by {|movie| movie[1].to_i}.reverse[0..2]
end

puts "Popular Movie Geners \n #{fave_most(data_movie).each {|genre| "#{genre[0]} - #{genre[1]}"}} reviews"
puts "====================================================================="

def best_rated(movies)
    # p movies

    # counted = Hash.new(0)

    # movies.each do |movie|
    #     counted[movie["genre"]] += 1
    # end
    # p counted
    rated = Hash.new(0)
    count = 1.0
    movies.each do |movie|
      rated[movie["genre"]] += (movie["rating"].to_i / count)
      count += 1
    end
    #p rated

   return rated.sort_by {|movie| movie[1].to_i}.reverse[0..2]
end

puts " Best rated genres\n #{best_rated(data_movie)}"
puts "=========================================================================="


def get_cheeses(data)
    data.each {|cheese| puts "#{cheese["cheese"]}: #{cheese["comment"]} --#{cheese["reviewer"]}"}
end

get_cheeses(data_cheese)