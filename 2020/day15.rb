require './inputs'

input = Inputs::DAY15

numbers = input.split(",").map(&:to_i)


def getValue(numbers, position)

  seen = []
  numbers.each_with_index do |number, index|
    seen[number] ||= []
    seen[number] << index
  end
  startturn = numbers.size
  for i in startturn..position do
    occurences = seen[numbers[i-1]].size
    if occurences == 1
      number = 0
    elsif occurences > 1
      last_occurence = seen[numbers[i-1]][-1]
      prev_occurence = seen[numbers[i-1]][-2]
      number = last_occurence - prev_occurence
    end

    numbers << number
    seen[number] ||= []
    seen[number] << i

    seen[number] = seen[number].last(2)

  end
  return numbers[position-1].to_s
end


#Part 1
puts getValue(numbers,2020)

#Part 2
puts getValue(numbers, 30000000)