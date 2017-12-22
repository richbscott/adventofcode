require './inputs'

input = Inputs::DAY6
blocks = input.split().map(&:to_i)

#Part 1
iterations = 0
states = []
state = false

#Continue until a state is found which has already occurred
while !states.include?(state)
  states << state
  starting_index = blocks.index(blocks.max)
  value = blocks[starting_index]
  blocks[starting_index] = 0
  index = starting_index

  while value > 0
    if (blocks.length-1 == index)
      index = 0
    else
      index += 1
    end
    blocks[index] += 1
    value -= 1
  end
  state = blocks.join(" ")
  iterations += 1
end

puts iterations

#Part 2
puts states.length - states.index(state)