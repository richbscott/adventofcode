require './inputs'

input = Inputs::DAY13

layers = {}

input.split("\n").each do |row|
  details = row.split(':')
  layers[details[0].to_i] = details[1].to_i
end

#Part 1
severity = 0
layer = 0
(layers.keys.max + 1).times do |position|

  # if layer is set
  if layers[position]
      # if we are at the 0 layer
      if (position % ((layers[position]-1)*2) == 0)
        severity += (position * layers[position])
      end
  end
end

puts severity


#Part 2
layer = 0
success = false
caught = false
delay = 0

while (caught == false)
    caught = false
    (layers.keys.max + 1).times do |position|

      # if layer is set
      if layers[position]
          # if we are at the 0 layer
          if ((position + delay) % ((layers[position]-1)*2) == 0)
            caught = true
          end
      end
    end

    if (!caught)
      puts "Delay:" + delay.to_s
      exit
    else
      caught = false
      delay += 1

    end
end
