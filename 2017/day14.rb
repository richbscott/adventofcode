require './inputs'

input = Inputs::DAY14

#Part 1
def knot_hash(input)
    lengths = input.split("").map(&:ord) + [17, 31, 73, 47, 23]

    list = [*0..255]
    cur_pos = 0
    skip_size = 0

    64.times do
        lengths.each do |length|
            list = list.rotate(cur_pos)
            section = list[0,length].reverse
            list[0, length] = section
            list = list.rotate(-cur_pos)
            cur_pos += (length + skip_size)
            skip_size += 1
        end
    end

    sparse_hash = list
    knot_hash = []
    dense_hash = []
    16.times do |i|
      accum = 0
      section = sparse_hash[i*16..(((i+1)*16)-1)]
      section.each { |number| accum = accum ^ number }
      dense_hash << accum
      knot_hash << accum.chr.unpack('H*')
    end

    return knot_hash.join()

end

used = 0
$matrix = {}

128.times do |row|
  knot_hash = knot_hash(input + '-' + row.to_s)
  line = ''
  knot_hash.split("").each_with_index do |char, i|

    char.hex.to_s(2).rjust(4,"0").split("").each_with_index do |bit, j|
      if (bit == "1")
        used += 1
        line += '#'
      else
        line += '.'
      end
      $matrix[((i*4)+j).to_s + ',' + row.to_s] = bit
    end
  end
  puts line
end

puts used

#Part 2

$matrix_region = {}

def updateNeighbours(x, y, region)
  key = x.to_s + "," + y.to_s
  if ($matrix_region[key].nil? && $matrix[key] == "1")
    $matrix_region[key] = region

    neighbours = [ ((x.to_i+1).to_s + "," + y.to_s),
                       (x.to_i-1).to_s + "," + y.to_s,
                       x.to_s + "," + (y.to_i+1).to_s,
                       x.to_s + "," + (y.to_i-1).to_s]

    neighbours.each do |neighbour|
      if ($matrix_region[neighbour].nil? && $matrix[neighbour] == "1")
        coords = neighbour.split(',')
        updateNeighbours(coords[0], coords[1], region)
        $matrix_region[neighbour] = region
      end
    end
  end
end

region = 0

128.times do |y|
  128.times do |x|
    key = x.to_s + "," + y.to_s
    # If coordinates are not already in a region and is a used point we need to assign
    if ($matrix_region[key].nil? && $matrix[key] == "1")
      region += 1
      updateNeighbours(x,y, region)
    end
  end
end

puts region.to_s