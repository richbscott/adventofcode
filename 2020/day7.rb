require './inputs'

input = Inputs::DAY7

mybag = 'shiny gold'
rules = {}
# set up rules as hash
bags = {}
input.split("\n").each do |rule|

  line = rule.split(' bags contain ')
  contents = line[1].split(',')
  bags[line[0]] = {}
  contents.each do |content|
    bag = content.gsub(/\d /, "").gsub(/bag(s?)/, "").gsub(/(\.?)/, "").strip
    bags[line[0]][bag] = content.to_i
  end
end

def getParents(bags, bag)
  parents = []
  bags.each_with_index do |(key, value), index|
    if value.keys.include?(bag)
      parents << key
      parents << getParents(bags, key)
    end
  end

  return parents
end

def countBags(bags, mybag)
  total = 0
  if (mybag != 'no other')
    bags[mybag].each_with_index do |(key, value), index|
      total += (countBags(bags, key) * value) + value
    end
  end
  return total
end

parentBags = getParents(bags, mybag)
parentBags = parentBags.flatten!

#Part 1
if !parentBags.nil?
  puts parentBags.uniq.size
end
#148

#Part 2
puts countBags(bags, mybag)
#2297 - too low



