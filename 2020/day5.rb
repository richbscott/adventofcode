require './inputs'

input = Inputs::DAY5

def calculateSeatId(seat)
 
  minrow = 0
  maxrow = 127
  for i in 0..6 do
    midpoint = (minrow + maxrow) / 2.0
    if seat[i] == 'F'
      row = maxrow = midpoint.floor
    elsif seat[i] == 'B'
      row = minrow = midpoint.ceil
    end
  end

  mincol = 0
  maxcol = 7
  for j in 7..9 do
    midpoint = (mincol + maxcol) / 2.0
    if seat[j] == 'L'
      col = maxcol = midpoint.floor
    elsif seat[j] == 'R'
      col = mincol = midpoint.ceil
    end
  end

  return row * 8 + col
end

highestid = 0
seatids = []
input.split("\n").each do |seat|
  seat.strip!
  seatid = calculateSeatId(seat)
  seatids << seatid
  highestid = seatid if (seatid > highestid)
end

myseat = 0
[*seatids.min..seatids.max].each do |v|
  if (!seatids.include?(v) and seatids.include?(v-1) and seatids.include?(v+1))
    myseat = v
  end

end

#Part 1
puts highestid

#Part 2 
puts myseat
