# I          1
# V          5
# X          10
# L          50
# C          100
# D          500
# M          1,000



def to_roman (num)
  roman_nums = {
  "I" => 1,
  "V" => 5,
  "X" => 10,
  "L" => 5,
  "C" => 10,
  "D" => 5,
  "M" => 1000
  }

  num_parts = num.to_s.split ""
  roman = ""
 
  len = num_parts.length
  num_parts.each do |part|
    case len
    when 4
      if part.to_i < 4
        roman = roman + "M" * part.to_i
      end
    when 3
      if part.to_i < 4
        roman = roman + "C" * part.to_i
      elsif part.to_i == 4
        roman = roman + "CD"
      elsif part.to_i == 5
        roman = roman + "D"
      elsif part.to_i == 9
        roman = roman + "CM"
      else
        roman = roman + "D" + "C" * (part.to_i - roman_nums["D"])
      end
    when 2
      if part.to_i < 4
        roman = roman + "X" * part.to_i
      elsif part.to_i == 4
        roman = roman + "XL"
      elsif part.to_i == 5
        roman = roman + "L"
      elsif part.to_i == 9
        roman = roman + "XC"
      else
        roman = roman + "L" + "X" * (part.to_i - roman_nums["L"])
      end
    when 1
      if part.to_i < 4
        roman = roman + "I" * part.to_i
      elsif part.to_i == 4
        roman = roman + "IV"
      elsif part.to_i == 5
        roman = roman + "V"
      elsif part.to_i == 9
        roman = roman + "IX"
      else
        roman = roman + "V" + "I" * (part.to_i - roman_nums["V"])
      end
    end
    len -= 1
  end
  puts roman
  return roman
end

to_roman(1) #=> 'I'
to_roman(2) #=> 'II'
to_roman(3) #=> 'III'
to_roman(4) #=> 'IV'
to_roman(5) #=> 'V'
to_roman(6) #=> 'VI'
to_roman(9) #=> 'IX'
to_roman(27) #=> 'XXVII'
to_roman(48) #=> 'XLVIII'
to_roman(59) #=> 'LIX'
to_roman(93) #=> 'XCIII'
to_roman(141) #=> 'CXLI'
to_roman(163) #=> 'CLXIII'
to_roman(402) #=> 'CDII'
to_roman(575) #=> 'DLXXV'
to_roman(911) #=> 'CMXI'
to_roman(1024) #=> 'MXXIV'
to_roman(3000) #=> 'MMM'