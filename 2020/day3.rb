require './inputs'

input = Inputs::DAY3

rows = []
index = 1
input.split("\n").each do |row|
  rows[index] = row.strip
  index +=1 
end


def calculateTreesOnSlope(slope, right, down)
  x = 1
  trees = 0
  (1..(slope.length-1)).step(down) do |y|
    x_value = x
    if y > 1
      while x_value > slope[y].length
        x_value -= slope[y].length
      end
      if slope[y][x_value-1] == '#'
        trees += 1
      end
    end
    x += right
  end

  return trees
end


#Part 1
trees = calculateTreesOnSlope(rows, 3, 1)
puts trees


#Part 2 
trees2 = calculateTreesOnSlope(rows, 1, 1)
trees3 = calculateTreesOnSlope(rows, 5, 1)
trees4 = calculateTreesOnSlope(rows, 7, 1)
trees5 = calculateTreesOnSlope(rows, 1, 2)

totaltrees =  trees * trees2 * trees3 * trees4 * trees5
puts totaltrees