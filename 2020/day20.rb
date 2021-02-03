require './inputs'

input = Inputs::DAY20

tiles = {}
left = []
right = []
top = []
bottom = []
tile_id = 0
input.split("\n\n").each_with_index do |tile, i|

  tile.split("\n").each_with_index do |row, j|

    #puts j
    if j == 0
      #puts "aa"
      tile_id = row.scan(/\d/).join('')      
      #tiles[tile_id] = 
      left = []
      right = []
      #puts left.to_s
    elsif j == 1
      top = row.chars
      left << row[0]
      right << row[row.size-1]
    elsif j == row.size
      bottom = row.chars
      right << row[row.size-1]
      #puts row[row.size-1]
      #puts right.to_s
      #puts row[row.size-1]
      left << row[0]
      #puts "TILEID:" + tile_id.to_s
      tiles[tile_id] = {:top =>  top, :bottom => bottom, :left => left, :right => right}
    else
      left << row[0]
      right << row[row.size-1]
    end

  end
end


#puts tiles

sides = ['top', 'bottom', 'left', 'right']

matches = {}
tiles.each do |key, tile|
  matches[key] = {}
  tiles.each do |key2, tile2|
    next if key == key2
    tile2.each do |side, row|   
      
      if (tile[:top] == row) || tile[:top] == row.reverse
        matches[key][:top] = [] if !matches[key][:top]
        matches[key][:top] << [key2, side]
      end
      if (tile[:bottom] == row) || tile[:bottom] == row.reverse
        matches[key][:bottom] = [] if !matches[key][:bottom]
        matches[key][:bottom] << [key2, side]
      end
      if (tile[:left] == row) || tile[:left] == row.reverse
        matches[key][:left] = [] if !matches[key][:left]
        matches[key][:left] << [key2, side]
      end
      if (tile[:right] == row) || tile[:right] == row.reverse
        matches[key][:right] = [] if !matches[key][:right]
        matches[key][:right] << [key2, side]
      end
    end

  end


end


potentialcorners = []
sides = []
total = 1
matches.each do |key, match|
  if match.size == 2 
    potentialcorners << key
    total *= key.to_i
  elsif match.size == 3
    sides << key
  end
  #puts key + ' ' + match.size.to_s

end

#puts potentialcorners.to_s

#puts total.to_s

#puts sides.size.to_s


# part2

# Can we join all 4 corners with sides?
# Total sides will be sqrt of total tiles -2 based on assumption is a square

sides_to_find = Math.sqrt(tiles.size) - 2
puts "Side Length " + sides_to_find.to_s

puts matches

