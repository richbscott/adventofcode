require './inputs'

input = Inputs::DAY11

directions = input.split(',')

DIRECTIONS = {"n" => 1, "s" => -1, "w" => -1, "e" => 1}

#Part 1
y_pos = 0
x_pos = 0
max_x = 0
max_y = 0

directions.each do |direction|
  direction.split("").each do |cardinal_dir|
    y_pos += DIRECTIONS[cardinal_dir] if (['n','s'].include?(cardinal_dir))
    x_pos += DIRECTIONS[cardinal_dir] if (['e','w'].include?(cardinal_dir))

    max_y = y_pos if y_pos.abs > max_y
    max_x = x_pos if x_pos.abs > max_x
  end
end

# Steps is max of x and y
steps = [x_pos.abs, y_pos.abs].max
puts steps

#Part 2
max_distance = [max_y, max_x].max
puts max_distance