require './inputs'

input = Inputs::DAY1

numbers = input.split('').map(&:to_i)

#Part 1
sum = 0
input.split('').map(&:to_i).each_with_index { |val, index| sum += val if (val == numbers[index-1]) }
puts sum

#Part 2
sum = 0
input.split('').map(&:to_i).each_with_index { |val, index| sum += val if (val == numbers[index - (numbers.length/2)]) }
puts sum