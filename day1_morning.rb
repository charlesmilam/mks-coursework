
# -------------------- book --------------------------------
book = {
  title: "Gourd of the Flies",
  author: ["J. W. Gourding"],
  copyright: "1998",
  pages: 200
}

p book[:title]

# ----------------- library --------------------------------------

library = []

library << book

p library

library << {title: "Design Patterns", author: ["John Vlissides", "et al"]}

library << {title: "Patterns of Enterprise Application Architecture", author: ["Martin Fowler"]}

library << {title: "Domain Driven Design", author: "Eric Evans"}

p library

# -------------------------- volunteer -------------------------
volunteers = {
  name: "alice",
  info: {
    phone: "555-555-5555",
    age: 25
  },
  position: "receptionist"
}

p volunteers

# --------------------------- state ---------------------------------
state = {
  name: "Rhode Island",
  captial: "Providence",
  largest_cities: ["Providence", "Warwick", "Cranston"],
  median_hh_income: 55_619,
  governor: "Lincoln Chafee"
}

p state


# ---------------------------- laptop -----------------------------------
laptop = {
  mfg: "Apple",
  model: "MacBook Air",
  storage: {
    size: 256,
    type: "SSD"
  },
  display: {
    size: 13.3,
    type: "Retina"
  },
  processor: {
    mfg: "Intel",
    type: "i7"
  }
}

p laptop

# -------------------------------- dogs -----------------------------------
dogs = []

def dog_constructor(name, age, breed, characteristic, fave_game, likes)
  dog = {
    name: name,
    age: age,
    breed: breed,
    characteristic: characteristic,
    fave_game: fave_game,
    likes: likes
  }
end

dogs << dog_constructor("maple", 4, "pitbull", "brown", "tug-o-war", ["swimming in the lake"])

dogs << dog_constructor("atlas", 3, "boxer", "super energetic", "fetch", ["swimming in the lake"])

p dogs

# ------------------------------ fave meal ---------------------------------------------
fave_meals = []

def fave_meal(name, meal)
  fave_meal = {
    name: name,
    meal: {
      app: meal[0],
      entree: meal[1],
      dessert: meal[2]
    }
  }
end

fave_meals << fave_meal("nick", ["mozarella sticks", "chicken parmigiana", "tiramisu"])

fave_meals << fave_meal("kate", ["calzone", "slice of pizza", "cannoli"])
fave_meals << fave_meal("harsh", ["garlic knots", "spaghetti & eggplant", "cheesecake"])

p fave_meals
fave_meals.each do |meal| 
  p "#{meal[:name].capitalize}'s' appetizer: #{meal[:meal][:app]}"
end


# ------------------------------- restaurant -----------------------------------------------
class Restaurant
  attr_reader :menu

  def initialize(name)
    @name = name
    @menu = {}
  end

  def add_to_menu(item, type, price = 0)
    @menu [item.to_sym] = {type: type, price: price}
    "Menu item #{item}, with price of #{price}, created sucessfully"
  end
end

pats = Restaurant.new("Patrick's Pizzza Palace")

puts pats.add_to_menu("mozarella sticks", "appetizer")
puts pats.add_to_menu("chicken parmigiana", "entree")
puts pats.add_to_menu("tiramisu", "dessert")
puts pats.add_to_menu("calzone", "appetizer")
puts pats.add_to_menu("pizza", "entree")
puts pats.add_to_menu("cannoli", "dessert")
puts pats.add_to_menu("garlic knots", "appetizer")
puts pats.add_to_menu("spaghetti & eggplant", "entree")
puts pats.add_to_menu("cheesecake", "dessert")

puts pats.menu

