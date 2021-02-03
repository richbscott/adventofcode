require './inputs'

input = Inputs::DAY16

fullinput = input.split("your ticket:")
rulelines = fullinput[0].strip().split("\n")
tickets = fullinput[1].split('nearby tickets:')

myticket = tickets[0].strip().split(',').map(&:to_i)
nearbytickets = tickets[1].strip()

validtickets = []

rules = {}
# calcuate permitted numbers per rule
rulelines.each do |rule|
  rule = rule.split(': ')
  valid_numbers = []
  ranges = rule[1].split(' or ')
  ranges.each do |range|
    points = range.split('-')
    range = (points[0]..points[1]).to_a.map(&:to_i)
    valid_numbers += range
  end
  key = rule[0]
  rules[key] = valid_numbers
end

#puts rules

invalid = 0
nearbytickets.split("\n").each do |ticket|
  validticket = true 
  ticket.split(',').map(&:to_i).each do |number|
    valid = false 
    rules.keys.each_with_index do |key,i|      
      #puts i
      rule = rules[key]
      valid = true if rule.include?(number)
      #puts rule.to_s
      #puts number.to_s + valid.to_s
    end
    if !valid
      invalid += number
      validticket = false
      #puts number
    end
  end
  if validticket
    validtickets << ticket
  end
end

#Part 1
puts invalid

#Part 2
#validtickets[0].split(',').map(&:to_i).size
#identifiedcolumns = {}
potentialcolumns = []
identifiedcolumns = []

validtickets.each_with_index do |validticket, k|
  if k == 0    
    for l in 0..validticket.split(',').map(&:to_i).size-1 do
      potentialcolumns[l] = rules.keys
      identifiedcolumns[l] = []
    end
    #puts identifiedcolumns.to_s
  end
  #puts "TRACE " + identifiedcolumns.to_s
  validticket.split(',').map(&:to_i).each_with_index do |number, j|
    possiblegroups = []
    rules.keys.each_with_index do |key,i| 
      rule = rules[key]
      possiblegroups << key if rule.include?(number)
    end
    #puts j.to_s + ' ' + potentialcolumns[j].to_s + ' ' + possiblegroups.to_s + ' ' + identifiedcolumns[j].to_s
    
    #identifiedcolumns[j].intersection(possiblegroups)
    potentialcolumns[j] = (potentialcolumns[j] & possiblegroups) #- identifiedcolumns[j]

    if potentialcolumns[j].size == 1
      identifiedcolumns[j] = potentialcolumns[j]
    end
  end


end


found = identifiedcolumns.flatten.size

#puts found
while found < identifiedcolumns.size 

  potentialcolumns.each_with_index do |potentialcolumn, x|
    identifiedcolumns.each_with_index do |identifiedcolumn|
      next if potentialcolumns[x].size == 1
      potentialcolumns[x] -= identifiedcolumn

      if potentialcolumns[x].size == 1
        identifiedcolumns[x] = potentialcolumns[x]
        found += 1
      end
    end
  end
end


result = 1
identifiedcolumns.flatten.each_with_index do |identifiedcolumn, i|
  if (identifiedcolumn[0,9] == 'departure')
    result *= myticket[i]
  end
end
puts result.to_s
