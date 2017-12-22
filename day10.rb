require './inputs'

input = Inputs::DAY10

lengths = input.split(",").map(&:to_i)
list = [*0..255]
cur_pos = 0
skip_size = 0

lengths.each do |length|
    list = list.rotate(cur_pos)
    section = list[0,length].reverse
    list[0, length] = section
    list = list.rotate(-cur_pos)
    cur_pos += (length + skip_size)
    skip_size += 1
end

#Part 1
puts list[0] * list[1]

#Part 2
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

knot_hash = knot_hash.join()
puts knot_hash




