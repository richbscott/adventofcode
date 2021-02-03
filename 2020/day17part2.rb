require './inputs'

input = Inputs::DAY17

input = '.#.
..#
###'
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

def getActiveNeighbours(cubes, i, j, k, l)

  active = 0
  size = cubes[0].size - 1
  #puts size.to_s + ' i:' + i.to_s + ' j:' + j.to_s + ' k:' + k.to_s
  #active += 1 if cubes[i][j][k] == '#'

  diff = [-1, 0, 1]

  diff.each do |z|
    active += 1 if k != size && cubes[i][j][k+1][z] == '#'
    active += 1 if k != 0 && cubes[i][j][k-1][z] == '#'
    active += 1 if j != size && cubes[i][j+1][k][z] == '#'
    active += 1 if j != size && k != size && cubes[i][j+1][k+1][z] == '#'
    active += 1 if j != size && k != 0 && cubes[i][j+1][k-1][z] == '#'
    active += 1 if k != size && j != 0 && cubes[i][j-1][k+1][z] == '#'
    active += 1 if k != 0 && j != 0 && cubes[i][j-1][k-1][z] == '#'  
    active += 1 if j != 0 && cubes[i][j-1][k][z] == '#'

    if i != size 
      active += 1 if k != size && cubes[i+1][j][k+1][z] == '#'
      active += 1 if k != 0 && cubes[i+1][j][k-1][z] == '#'
      active += 1 if cubes[i+1][j][k][z] == '#'
      active += 1 if j != size && cubes[i+1][j+1][k][z] == '#'
      active += 1 if j != size && k != size && cubes[i+1][j+1][k+1][z] == '#'
      active += 1 if j != size && k != 0 && cubes[i+1][j+1][k-1][z] == '#'
      active += 1 if k != size && j != 0 && cubes[i+1][j-1][k+1][z] == '#'
      active += 1 if j != 0 && k != 0 && cubes[i+1][j-1][k-1][z] == '#'  
      active += 1 if j != 0 && cubes[i+1][j-1][k][z] == '#'
    end

    if i != 0 
      active += 1 if k != size && cubes[i-1][j][k+1][z] == '#'
      active += 1 if k != 0 && cubes[i-1][j][k-1][z] == '#'
      active += 1 if cubes[i-1][j][k][z] == '#'
      active += 1 if j != size && cubes[i-1][j+1][k][z] == '#'
      active += 1 if j != size && k != size && cubes[i-1][j+1][k+1][z] == '#'
      active += 1 if j != size && k != 0 && cubes[i-1][j+1][k-1][z] == '#'
      active += 1 if j != 0 && k != size && cubes[i-1][j-1][k+1][z] == '#'
      active += 1 if j != 0 && k != 0 && cubes[i-1][j-1][k-1][z] == '#'  
      active += 1 if j != 0 && cubes[i-1][j-1][k][z] == '#'
    end
  end
  
  return active
end


def renderCubes(cubes)
  cubes.each_with_index do |cube, i|
    cube.each_with_index do |slice, j|
      puts "Slice " + i.to_s
      slice.each_with_index do |row, k|
        puts row.to_s + "\n"
      end
    end
  end

end
#renderCubes(cubes)
puts cubes.to_s
# initialise z to correct size
size = cubes[0].size
(size/2 -1).times do |x|
  if (size % 2 == 0 && x == 0)
    cubes.unshift Array.new(size) { Array.new(size) { Array.new(size, ?.) } }
  end
  cubes.unshift Array.new(size) { Array.new(size) { Array.new(size, ?.) } }
  cubes << Array.new(size) { Array.new(size) { Array.new(size, ?.) } }
end
renderCubes(cubes)
exit

def resize(cubes, size)
  cubes.unshift Array.new(size) { Array.new(size) { Array.new(size, ?.) } }
  cubes << Array.new(size) { Array.new(size) { Array.new(size, ?.) } }

  cubes.each_with_index do |cube, i|
    cubes[i].unshift Array.new(size) { Array.new(size) { Array.new(size, ?.) } }
    cubes[i] <<  Array.new(size) { Array.new(size) { Array.new(size, ?.) } }
    cube.each_with_index do |slice, j|
      cubes[i][j].unshift Array.new(size) { Array.new(size, ?.) } 
      cubes[i][j] <<  Array.new(size) { Array.new(size, ?.) } 
      slice.each_with_index do |row, k|
        puts cubes[i][j][k].to_s
        cubes[i][j][k].unshift '.'
        cubes[i][j][k] << '.'
      end
    end
  end
  return cubes
end


6.times do |i|
  size = cubes[0].size
  
  resize(cubes,size)

  newcubes = []
  maxsize = cubes[0].size - 1
  cubes.each_with_index do |cube, i|
    newcubes[i] ||= []
    cube.each_with_index do |slice, j|
      newcubes[i][j] ||= []
      slice.each_with_index do |row, k|
        newcubes[i][j][k] ||= []
        row.each_with_index do |cell, l|
          # New outer rows so ignore
          #puts '[' + i.to_s + ',' + j.to_s + ',' + k.to_s + '] ' + cell
          #if i == 0 || j == 0 || k == 0 || i == maxsize || j == maxsize || k == maxsize 
          #  newcubes[i][j][k] = cubes[i][j][k]
            #puts "NEW"
          #else
            active = getActiveNeighbours(cubes, i, j, k, l)
            #newcubes[i][j][k] = cubes[i][j][k]
            #puts "ACTIVE " + active.to_s  if i == 2 and j == 1 and k == 1
            if (cubes[i][j][k][l] == '#' and (active == 2 || active == 3))
              newcubes[i][j][k][l] = '#'
              #puts "TRACE1" if i == 2 and j == 1 and k == 1
            elsif cubes[i][j][k][l] == '#'
              newcubes[i][j][k][l] = '.'
            elsif (cubes[i][j][k][l] == '.' and active == 3)
              newcubes[i][j][k][l] = '#'
            else
              newcubes[i][j][k][l] = cubes[i][j][k][l]
              #puts "TRACE5 " if i == 2 and j == 1 and k == 1
            end
            #puts cubes.to_s
            #puts '[' + i.to_s + ',' + j.to_s + ',' + k.to_s + '] ' + newcubes[i][j][k].to_s
          #end
        end
      end
    end
  end
  cubes = newcubes
  #renderCubes(newcubes)
end

def countActive(cubes)
  active = 0
  cubes.each_with_index do |cube, i|
    cube.each_with_index do |slice, j|
      slice.each_with_index do |row, k|
        row.each_with_index do |cell, l|
          active += 1 if cell == '#'
        end
      end
    end
  end
  return active
end

#Part 1
puts countActive(cubes).to_s

#Part 2

#puts 