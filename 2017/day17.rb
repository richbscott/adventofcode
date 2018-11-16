require './inputs'

input = Inputs::DAY17

spinlock = [0]

#Part 1
2017.times do |value|
  spinlock = spinlock.rotate(input+1)
  spinlock.unshift(value+1)
end

index_2017 = spinlock.index(2017)
puts spinlock[index_2017 +1]

#Part 2
spinlock = [0]
spinlock_length = 1
value_next_to_zero = 0
current_position = 0
1.upto(50000000).each do |value|
  # We only care about the value inserted at position 1 that which is after 0 now
  # As it takes so long to insert every item just record what would be imported as this position and increase the length
  current_position = (input+current_position) % spinlock_length + 1

  if current_position == 1
    value_next_to_zero = value
  end
  spinlock_length += 1
end

puts  value_next_to_zero
