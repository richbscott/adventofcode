require './inputs'

input = Inputs::DAY11

#'L'
#'#'
#'.'


# Loop over 
seats = {}

max_i = 0
max_j = 0

input.split("\n").each_with_index do |row, i|
  seats[i] = []
  row.split('').each_with_index do |seat, j|
    seats[i][j] = seat
    #puts j
    max_j = j
  end
  #puts i
  max_i = i

end

def renderSeats(seats)
  seats.each do |seat|
    puts seat.to_s
  end
end


def findOccupiedNeighbours(x,y, values, max_y, max_x)
  sum = 0

  if x != 0
    sum += 1 if (values.has_key?(y+1) && values[y+1][x-1] == '#')
    sum += 1 if (values.has_key?(y) && values[y][x-1] == '#')
    sum += 1 if (values.has_key?(y-1) && values[y-1][x-1] == '#')
  end
  if x != max_x
    sum += 1 if (values.has_key?(y+1) && values[y+1][x+1]  == '#')
    sum += 1 if (values.has_key?(y-1) && values[y-1][x+1] == '#')
    sum += 1 if (values.has_key?(y) && values[y][x+1] == '#')
  end

  sum += 1 if (values.has_key?(y+1) && values[y+1][x] == '#')  
  sum += 1 if (values.has_key?(y-1) && values[y-1][x] == '#')

  return sum
end

flatseats = seats.flatten(2)
prev_occupied_count = flatseats.count('#')
prev_empty_count = flatseats.count('L')
prev_floor_count = flatseats.count('.')
changes = true

part2seats = Marshal.load(Marshal.dump(seats))
#puts flatseats.to_s
#puts "Occupied:" + prev_occupied_count.to_s
#renderSeats(seats)
round = 1
while changes
  orig_seats = Marshal.load(Marshal.dump(seats))
  for y in 0..max_i
    for x in 0..max_j

      occupied_neighbours = findOccupiedNeighbours(x,y, orig_seats,max_i, max_j)

      if seats[y][x] == 'L' and occupied_neighbours == 0
        seats[y][x] = '#'
        #puts seats[y][x] + ' ' + orig_seats[y][x]
      elsif seats[y][x] == '#' and occupied_neighbours > 3
        seats[y][x] = 'L'
      end
    end
  end
  

  flatseats = seats.flatten(2)
  occupied_count = flatseats.count('#')
  empty_count = flatseats.count('L')
  floor_count = flatseats.count('.')

  #renderSeats(seats)

  #puts "Occupied:" + occupied_count.to_s
  #puts flatseats.to_s

  if floor_count == prev_floor_count and occupied_count == prev_occupied_count and empty_count == prev_empty_count
    changes = false
  end

  prev_occupied_count = occupied_count
  prev_empty_count = empty_count
  prev_floor_count = floor_count
  round += 1
end

#Part 1
#puts seats.flatten(2).count('#')


def findOccupiedDirections(y,x, values, max_y, max_x)
  sum = 0

  #puts max_x
  #puts max_y

  i = x
  j = y+1
  # Check down direction
  while j <= max_y
    break if values[j][i] == 'L'
    if values[j][i] == '#'
      #puts j.to_s + ',' + i.to_s
      sum += 1 
      break
    end
    j += 1
  end

  # Check up direction
  j = y-1
  while j >= 0
    break if values[j][i] == 'L'
    if values[j][i] == '#'
      #puts j.to_s + ',' + i.to_s
      sum += 1 
      break
    end
    j -= 1
  end

  # Check left direction
  j = y
  i = x-1
  while i >= 0
    break if values[j][i] == 'L'
    if values[j][i] == '#'
      #puts j.to_s + ',' + i.to_s
      sum += 1 
      break
    end
    i -= 1
  end

  # Check right direction
  j = y
  i = x+1
  while i <= max_x
    break if values[j][i] == 'L'
    if values[j][i] == '#'
      #puts j.to_s + ',' + i.to_s
      sum += 1 
      break
    end
    i += 1
  end

  # Check top left diagonal
  j = y-1
  i = x-1
  while i >= 0 && j >= 0
    break if values[j][i] == 'L'
    if values[j][i] == '#'
      #puts j.to_s + ',' + i.to_s
      sum += 1 
      break
    end
    i -= 1
    j -= 1
  end

  # Check top right diagonal
  j = y-1
  i = x+1
  while i <= max_x && j >= 0
    break if values[j][i] == 'L'
    if values[j][i] == '#'
      #puts j.to_s + ',' + i.to_s
      sum += 1 
      break
    end
    i += 1
    j -= 1
  end

  # Check bottom right diagonal
  j = y+1
  i = x+1
  while i <= max_x && j <= max_y
    break if values[j][i] == 'L'
    if values[j][i] == '#'
      #puts j.to_s + ',' + i.to_s
      sum += 1 
      break
    end
    i += 1
    j += 1
  end

  # Check bottom left diagonal
  j = y+1
  i = x-1
  while j <= max_y && i >= 0
    break if values[j][i] == 'L'
    if values[j][i] == '#'
      #puts j.to_s + ',' + i.to_s
      sum += 1 
      break
    end
    i -= 1
    j += 1
  end

  return sum
end



#Part 2
#puts seats.flatten(2).count('#')
flatseats = seats.flatten(2)
prev_occupied_count = flatseats.count('#')
prev_empty_count = flatseats.count('L')
prev_floor_count = flatseats.count('.')
changes = true
seats = part2seats
round = 1

#renderSeats(seats)
#puts ""
occupied_neighbours = findOccupiedDirections(0,3, orig_seats,max_i, max_j)

#puts occupied_neighbours
#exit
while changes
  orig_seats = Marshal.load(Marshal.dump(seats))
  for y in 0..max_i
    for x in 0..max_j

      occupied_neighbours = findOccupiedDirections(y, x, orig_seats,max_i, max_j)

      if seats[y][x] == 'L' and occupied_neighbours == 0
        seats[y][x] = '#'
        #puts seats[y][x] + ' ' + orig_seats[y][x]
      elsif seats[y][x] == '#' and occupied_neighbours > 4
        seats[y][x] = 'L'
      end
    end
  end
  

  flatseats = seats.flatten(2)
  occupied_count = flatseats.count('#')
  empty_count = flatseats.count('L')
  floor_count = flatseats.count('.')

  #renderSeats(seats)
  #puts ""
  #exit

  #puts "Occupied:" + occupied_count.to_s
  #puts flatseats.to_s

  if floor_count == prev_floor_count and occupied_count == prev_occupied_count and empty_count == prev_empty_count
    changes = false
  end

  prev_occupied_count = occupied_count
  prev_empty_count = empty_count
  prev_floor_count = floor_count
  round += 1
end

puts seats.flatten(2).count('#')