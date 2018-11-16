require './inputs'

input = Inputs::DAY3

=begin
Spiral grid
36  35  34  33  32  31
17  16  15  14  13  30
18  5   4   3   12  29
19  6   1   2   11  28
20  7   8   9   10  27
21  22  23  24  25  26
Assuming 1 is coordinate 0,0
Each even square number is top left of the inner square
4(2^2) => {0,1}, 16(4^2) => {-1,2}, 36(6^2) => {-2,3}
Each odd square number is bottom right
9(3^2) => {2,-2}, 25(5^2) => {3,-3}, 49(7^2) => {4,-4}

n = input position
k = (sqrt(n) - 1) / 2
Odd square postion = {k,-k}
Even square position = {-k+1,k}

Therefore we w calculate nearest square we can find that position then
add or remove the difference from x or y as required

=end

#Part 1
def getCoordinates(input)
  square_number_before = ((Math.sqrt(input)).floor) ** 2
  square_number_after = ((Math.sqrt(input)).ceil) ** 2

  #Get closest square number
  before_diff = input - square_number_before
  after_diff = square_number_after - input
  if (before_diff < after_diff)
    diff = before_diff
    closest_square = square_number_before
  else
    diff = after_diff * -1
    closest_square = square_number_after
  end

  closest_square_coordinates = {'x' => 0, 'y' => 0}
  coordinates = {}

  k = ((Math.sqrt(closest_square) - 1) / 2).ceil
  turned_corner = -1
  direction = 1
  primary_direction = 'x'
  secondary_direction = 'y'

  if (closest_square % 2 == 0)
    direction = -1 if diff < 0
    turned_corner = 1 if diff > 1
    if diff > 1
      primary_direction = 'y'
      secondary_direction = 'x'
    end
    closest_square_coordinates['x'] = -k+1
    closest_square_coordinates['y'] = k
  else
    turned_corner = 1 if diff > 0
    if diff > 0
      direction = -1
      primary_direction = 'y'
      secondary_direction = 'x'
    end
    closest_square_coordinates['x'] = k
    closest_square_coordinates['y'] = -k
  end

  if turned_corner == 1
      diff = diff.abs - 1
      coordinates[primary_direction] = closest_square_coordinates[primary_direction] - (diff*direction)
      coordinates[secondary_direction] = closest_square_coordinates[secondary_direction] - direction
  else
      coordinates[primary_direction] = closest_square_coordinates[primary_direction] - (diff.abs*direction)
      coordinates[secondary_direction] = closest_square_coordinates[secondary_direction]
  end
  return coordinates
end

coordinates = getCoordinates(input)
#puts (coordinates['x'].abs + coordinates['y'].abs).to_i


#Part 2

def sumAllNeighbours(coordinates, values)
  x = coordinates['x']
  y = coordinates['y']
  sum = 0

  sum += values[x+1][y] if (values[x+1] && values[x+1][y])
  sum += values[x+1][y+1] if (values[x+1] && values[x+1][y+1])
  sum += values[x+1][y-1] if (values[x+1] && values[x+1][y-1])
  sum += values[x-1][y] if (values[x-1] && values[x-1][y])
  sum += values[x-1][y+1] if (values[x-1] && values[x-1][y+1])
  sum += values[x-1][y-1] if (values[x-1] && values[x-1][y-1])
  sum += values[x][y+1] if (values[x] && values[x][y+1])
  sum += values[x][y-1] if (values[x] && values[x][y-1])

  return sum
end

value = 1
values = {0 => {0 => 1}}
i = 2

while value < input
  coordinates = getCoordinates(i)
  value = sumAllNeighbours(coordinates, values)
  values[coordinates['x']] ||= {}
  values[coordinates['x']][coordinates['y']] = value
  i += 1
end

puts value