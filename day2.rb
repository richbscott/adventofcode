require './inputs'

input = Inputs::DAY2

#Part 1
sum = 0

input.split("\n").each do |row|
  sum += (row.split().map(&:to_i).max - row.split().map(&:to_i).min)
end

puts sum

#Part 2
sum = 0
input.split("\n").each do |row|
  row_numbers = row.split().map(&:to_i)
  row_numbers.each_with_index do |number, i|
    row_numbers.each_with_index do |divisor, j|
      if (i != j && number % divisor == 0)
        sum += number / divisor
        break
      end
    end
  end
end

puts sum

