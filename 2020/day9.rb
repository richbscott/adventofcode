require './inputs'

input = Inputs::DAY9
preamble = 25
numbers = input.split("\n").map(&:to_i)
preamble_array = numbers[0,preamble]
part1 = 0

for i in preamble..numbers.size-1 do
  
  found = false
  preamble_array.each do |value|
    preamble_array.each do |value2|
      if numbers[i] == value + value2 and value != value2
        found = true
      end
    end
  end
  
  preamble_array.shift
  preamble_array << numbers[i]

  if found == false
    part1 = numbers[i]
    break
  end
end

#Part 1
puts part1

#Part 2
summation_set = []
i = 0
while i < numbers.size-1 do

  if (summation_set.sum == part1)
    break
  end
  if (summation_set.sum < part1)
    summation_set << numbers[i]
    i += 1
  elsif (summation_set.sum > part1)
    summation_set.shift
  end
end

puts summation_set.minmax.sum

