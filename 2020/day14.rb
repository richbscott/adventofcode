require './inputs'

input = Inputs::DAY14

rows = input.split("\n")

mem = {}
mask = ''

rows.each do |row|
  line = row.split(' = ')
  if (line[0] == 'mask')
    mask = line[1]
  else
    memkey = line[0].split("[").last.split("]").first.to_i
    value = line[1].to_i.to_s(2).rjust(36, '0')
    mask.split('').each_with_index do |bit, i|
      next if bit == 'X'
      #puts mask[i]
      value[i] = mask[i]
    end
    mem[memkey] = value.to_i(2)
  end

end

sum = 0
mem.each do |k, v|
  sum += v
end

#Part 1
puts sum

def getVariations(addresses)
	pushed = false
  new_vals = []
  addresses.each do |address|
    x = address.index('X')
    if !x.nil?
      a = address.slice(0,x) + '0' + address.split(//).last(address.length-x-1).join
      b = address.slice(0,x) + '1' + address.split(//).last(address.length-x-1).join
			new_vals.push(a, b)
			pushed = true
    end
	end

	if (pushed) 
		return getVariations(new_vals);
	else 
		return addresses;
  end

end


#Part 2
mem = {}
mask = ''

rows.each do |row|
  line = row.split(' = ')
  if (line[0] == 'mask')
    mask = line[1]
  else
    memkey = line[0].split("[").last.split("]").first.to_i
    memkey = memkey.to_s(2).rjust(36, '0')
    value = line[1].to_i.to_s(2).rjust(36, '0')

    floatkeys = []
    mask.split('').each_with_index do |bit, i|
      next if bit == '0'
      memkey[i] = mask[i]
      floatkeys << i if bit == 'X'
    end
    keys = getVariations([memkey])
    keys.each do |key|
      mem[key] = value.to_i(2)
    end

  end

end

sum = 0
mem.each do |k, v|
  sum += v
end

puts sum

#3260587250457 actual
