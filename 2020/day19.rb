require './inputs'

input = Inputs::DAY19

#DAY19 = '0: 4 1 5
#1: 2 3 | 3 2
#2: 4 4 | 5 5
#3: 4 5 | 5 4
#4: "a"
#5: "b"

#ababbb
#bababa
#abbbab
#aaabbb
#aaaabbb


ruleslist, messages = input.split("\n\n")


rules = {}
ruleslist.split("\n").each do |ruleline|

  key, rule = ruleline.split(': ')
  #puts rule
  rules[key] = rule.to_s

end

rule = rules['0']

while rule =~ /\d/
  items = []
  rule.split(' ').each_with_index do |item, j|
    if item =~ /\d/ 
      item = '( ' + rules[item] + ' )'
    end
    items << item
  end
  rule = items.join(' ')
end

rule = rule.gsub(/\s+/, "")
rule = rule.gsub(/\"+/, "")
#puts rule


valid = 0
messages.split("\n").each do |message|

  if message.match('^' + rule + '$')
    valid += 1
  end

end


# part1
puts valid

# part2
rules['8'] = "42 +"
rules['11'] = '(?<recursive> 42 \\g<recursive>? 31 )'

rule = rules['0']

while rule =~ /\d/
  items = []
  rule.split(' ').each_with_index do |item, j|
    
    #puts "aaa" if (j == 42)
    if item =~ /\d/ 
     # puts rules[item] if (j == 42)
      if rules[item] =~ /\d/ 
        item = '( ' + rules[item] + ' )'
      else 
        item = rules[item]
      end
    end
    items << item
  end
  rule = items.join(' ')
end

rule = rule.gsub(/\s+/, "")
rule = rule.gsub(/\"+/, "")

#puts rule


valid = 0
messages.split("\n").each do |message|

  if message.match('^' + rule + '$')
    valid += 1
  end

end

puts valid
