require './inputs'

input = Inputs::DAY17

#[z][x][y]
#     .#.
#     ..#
#     ###
cubes = []
cubes[0] = []
input.split("\n").each_with_index do |row, i|
  cubes[0][i] ||= []
  row.split("").each_with_index do |cell, j|
    cubes[0][i][j] = cell
  end
end

def getActiveNeighbours(cubes, i, j, k)

  active = 0
  size = cubes[0].size - 1
  #puts size.to_s + ' i:' + i.to_s + ' j:' + j.to_s + ' k:' + k.to_s
  #active += 1 if cubes[i][j][k] == '#'

  
  active += 1 if k != size && cubes[i][j][k+1] == '#'
  active += 1 if k != 0 && cubes[i][j][k-1] == '#'
  active += 1 if j != size && cubes[i][j+1][k] == '#'
  active += 1 if j != size && k != size && cubes[i][j+1][k+1] == '#'
  active += 1 if j != size && k != 0 && cubes[i][j+1][k-1] == '#'
  active += 1 if k != size && j != 0 && cubes[i][j-1][k+1] == '#'
  active += 1 if k != 0 && j != 0 && cubes[i][j-1][k-1] == '#'  
  active += 1 if j != 0 && cubes[i][j-1][k] == '#'

  if i != size 
    active += 1 if k != size && cubes[i+1][j][k+1] == '#'
    active += 1 if k != 0 && cubes[i+1][j][k-1] == '#'
    active += 1 if cubes[i+1][j][k] == '#'
    active += 1 if j != size && cubes[i+1][j+1][k] == '#'
    active += 1 if j != size && k != size && cubes[i+1][j+1][k+1] == '#'
    active += 1 if j != size && k != 0 && cubes[i+1][j+1][k-1] == '#'
    active += 1 if k != size && j != 0 && cubes[i+1][j-1][k+1] == '#'
    active += 1 if j != 0 && k != 0 && cubes[i+1][j-1][k-1] == '#'  
    active += 1 if j != 0 && cubes[i+1][j-1][k] == '#'
  end

  if i != 0 
    active += 1 if k != size && cubes[i-1][j][k+1] == '#'
    active += 1 if k != 0 && cubes[i-1][j][k-1] == '#'
    active += 1 if cubes[i-1][j][k] == '#'
    active += 1 if j != size && cubes[i-1][j+1][k] == '#'
    active += 1 if j != size && k != size && cubes[i-1][j+1][k+1] == '#'
    active += 1 if j != size && k != 0 && cubes[i-1][j+1][k-1] == '#'
    active += 1 if j != 0 && k != size && cubes[i-1][j-1][k+1] == '#'
    active += 1 if j != 0 && k != 0 && cubes[i-1][j-1][k-1] == '#'  
    active += 1 if j != 0 && cubes[i-1][j-1][k] == '#'
  end
  
  return active
end


def renderCubes(cubes)
  cubes.each_with_index do |slice, i|
    puts "Slice " + i.to_s
    slice.each_with_index do |row, j|
      puts row.to_s + "\n"
    end
  end

end

# initialise z to correct size
size = cubes[0].size
(size/2 -1).times do |x|
  if (size % 2 == 0 && x == 0)
    cubes.unshift Array.new(size) { Array.new(size, ?.) }
  end
  cubes.unshift Array.new(size) { Array.new(size, ?.) }
  cubes << Array.new(size) { Array.new(size, ?.) }
end
#renderCubes(cubes)
#exit

def resize(cubes, size)
  cubes.unshift Array.new(size) { Array.new(size, ?.) }
  cubes << Array.new(size) { Array.new(size, ?.) }

  cubes.each_with_index do |slice, i|
    cubes[i].unshift Array.new(size, ?.) 
    cubes[i] <<  Array.new(size, ?.)
    slice.each_with_index do |row, j|
      cubes[i][j].unshift '.'
      cubes[i][j] << '.'
    end

  end
  return cubes
end


6.times do |i|
  size = cubes[0].size
  
  resize(cubes,size)

  newcubes = []
  maxsize = cubes[0].size - 1
  cubes.each_with_index do |slice, i|
    newcubes[i] ||= []
    slice.each_with_index do |row, j|
      newcubes[i][j] ||= []
      row.each_with_index do |cell, k|
        # New outer rows so ignore
        #puts '[' + i.to_s + ',' + j.to_s + ',' + k.to_s + '] ' + cell
        #if i == 0 || j == 0 || k == 0 || i == maxsize || j == maxsize || k == maxsize 
        #  newcubes[i][j][k] = cubes[i][j][k]
          #puts "NEW"
        #else
          active = getActiveNeighbours(cubes, i, j, k)
          #newcubes[i][j][k] = cubes[i][j][k]
          #puts "ACTIVE " + active.to_s  if i == 2 and j == 1 and k == 1
          if (cubes[i][j][k] == '#' and (active == 2 || active == 3))
            newcubes[i][j][k] = '#'
            #puts "TRACE1" if i == 2 and j == 1 and k == 1
          elsif cubes[i][j][k] == '#'
            newcubes[i][j][k] = '.'
          elsif (cubes[i][j][k] == '.' and active == 3)
            newcubes[i][j][k] = '#'
          else
            newcubes[i][j][k] = cubes[i][j][k]
            #puts "TRACE5 " if i == 2 and j == 1 and k == 1
          end
          #puts cubes.to_s
          #puts '[' + i.to_s + ',' + j.to_s + ',' + k.to_s + '] ' + newcubes[i][j][k].to_s
        #end
      end
    end
  end
  cubes = newcubes
  #renderCubes(newcubes)
end

def countActive(cubes)
  active = 0
  cubes.each_with_index do |slice, i|
    slice.each_with_index do |row, j|
      row.each_with_index do |cell, j|
        active += 1 if cell == '#'
      end
    end
  end
  return active
end

#Part 1
puts countActive(cubes).to_s

#Part 2

#puts 