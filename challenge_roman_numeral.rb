# I          1
# V          5
# X          10
# L          50
# C          100
# D          500
# M          1,000

roman_nums = {
  1 => "I",
  5 => "V",
  10 => "X",
  50 => "L",
  100 => "C",
  500 => "D",
  1000 => "M"
}

def to_roman_num (num)
  num_parts = num.to_s.split ""
  roman = ""
  #puts "num parts", num_parts
  # num_parts << :X
  len = num_parts.length
  num_parts.each do |part|
    case len
    when 4
      #multi = num_parts.shift.to_i
      if part.to_i < 4
        roman = roman + "M" * part.to_i
      end
    when 3
      #multi = num_parts.shift.to_i
      roman = roman + "C" * part.to_i
    when 2
      #multi = num_parts.shift.to_i
      roman = roman + "X" * part.to_i
    when 1
      #multi = num_parts.shift.to_i
      roman = roman + "I" * part.to_i
    end
    len -= 1
  end

  return roman
end

puts to_roman_num 1231