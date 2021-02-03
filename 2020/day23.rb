require './inputs'

input = Inputs::DAY23


cups = input.split(//).map(&:to_i)

current_cup_index = 0
min_cup_label = cups.min
max_cup_label = cups.max

#puts "MIN Cup VALUE = " +min_cup_label.to_s
#puts "MAX Cup VALUE = " +max_cup_label.to_s
# 100 moves
100.times do |n|
  #puts "--MOVE--" + (n+1).to_s
  #puts cups.to_s
  #puts current_cup_index.to_s
  cups.rotate!(current_cup_index)
  current_cup_index = 0
  removedcups = cups.slice!(current_cup_index+1, 3)
  current_cup_value = cups[0]

  while true
    current_cup_value -= 1
    if current_cup_value < min_cup_label
      current_cup_value = max_cup_label+1
    end
    destination_cup = cups.index(current_cup_value)
    
    
    if !destination_cup.nil?
      break
    end
  end

  current_cup_index = 1
  cups.insert(destination_cup+1,*removedcups)
end

# part1
startting_cup = cups.index(1)
cups.rotate!(startting_cup).shift
puts cups.join.to_s


# part2
cups = input.split(//).map(&:to_i)

current_cup_index = 0
min_cup_label = cups.min
max_cup_label = cups.max

addvalue = max_cup_label

cups += ((max_cup_label+1)..1000000).to_a

max_cup_label = 1000000

#puts "MIN Cup VALUE = " +min_cup_label.to_s
#puts "MAX Cup VALUE = " +max_cup_label.to_s
# 100 moves
start = Time.now.to_f

10000000.times do |n|
  #puts "--MOVE--" + (n+1).to_s if n % 1000 == 0
  #puts cups.to_s
  #puts current_cup_index.to_s if n % 1000 == 0
  cups.rotate!(current_cup_index)
  current_cup_index = 0
  removedcups = cups.slice!(current_cup_index+1, 3)
  current_cup_value = cups[0]
  
  #puts "CUP VALUE " + current_cup_value.to_s if n % 1000 == 0
  while true
    current_cup_value -= 1
    if current_cup_value < min_cup_label
      current_cup_value = max_cup_label+1
    end
    destination_cup = cups.index(current_cup_value)
    #puts "DESTINATION " + destination_cup.to_s if n % 1000 == 0
    
    if !destination_cup.nil?
      break
    end
  end

  if n % 1000 == 0
    now = Time.now.to_f
    puts "TIMES" + n.to_s + '    ' + (now - start).to_s
  end

  current_cup_index = 1
  cups.insert(destination_cup+1,*removedcups)
end

# part2
startting_cup = cups.index(1)
cups.rotate!(startting_cup)
value1 = cups.shift
value2 - cups.shift
total = value1*value2
puts total.to_s

