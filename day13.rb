require './inputs'

input = Inputs::DAY13

input = '0: 3
1: 2
4: 4
6: 4'


layers = {}

input.split("\n").each do |row|
  details = row.split(':')
  layers[details[0].to_i] = details[1].to_i
end

puts layers.to_s

#Part 1
severity = 0
layer = 0
(layers.keys.max + 1).times do |position|

  # if layer is set
  if layers[position]
      puts position / layers[position]
      # if we are at the 0 layer
      if ((position % layers[position] == 0 && position / layers[position] == 2) || (position+1 / layers[position] == 2 && (position+1) % 2 == 0))
        puts "CAUGHT" + position.to_s
        severity += position * layers[layer]
      end
  end
end

puts severity