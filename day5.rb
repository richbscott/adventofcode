require './inputs'

input = Inputs::DAY5

#Part 1
numbers = input.split("\n").map(&:to_i)
pointer = 0
steps = 0
while !numbers[pointer].nil?
  jump = numbers[pointer]
  numbers[pointer] += 1
  steps += 1
  pointer = pointer + jump
end

puts steps

#Part 2
numbers = input.split("\n").map(&:to_i)
pointer = 0
steps = 0
while !numbers[pointer].nil?
  jump = numbers[pointer]
  if (jump >= 3)
    numbers[pointer] -= 1
  else
    numbers[pointer] += 1
  end
  steps += 1
  pointer = pointer + jump
end

puts steps