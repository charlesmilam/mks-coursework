counter = 0
library = []

IO.foreach("library_data_structure.txt") do |line| 
  if line[0] == "{"
    library[counter] = line.chomp
  end
  counter += 1
end

p library