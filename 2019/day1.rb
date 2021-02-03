require './inputs'

input = Inputs::DAY1

total_fuelp1 = 0
total_fuelp2 = 0
input.split("\n").map(&:to_i).each do |mass|
    fuel = (mass / 3).floor - 2
    total_fuelp1 += fuel
    total_fuelp2 += fuel
    
    #Continue until we reach negative fuel required
    while fuel > 0
        fuel = (fuel / 3).floor - 2
        if fuel > 0
          total_fuelp2 += fuel
        end
    end

end

#Part 1
puts total_fuelp1

#Part 2
puts total_fuelp2