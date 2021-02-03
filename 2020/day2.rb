require './inputs'

input = Inputs::DAY2

p1_count = 0
p2_count = 0
input.split("\n").each do |row|
    policy, password  = row.split(":").map(&:strip)
    positions, letter = policy.split()
    min, max = positions.split("-").map(&:to_i)
    
    lettercount = password.count(letter)
    if (lettercount >= min and lettercount <= max)
      p1_count += 1
    end

    if ((password[min-1] == letter) ^ (password[max-1] == letter))
      p2_count += 1
    end
end

#Part 1
puts p1_count

#Part 2
puts p2_count