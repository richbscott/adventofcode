require './inputs'

input = Inputs::DAY10

numbers = input.split("\n").map(&:to_i).sort

# Add socket of 0 jolts
numbers.unshift(0)
# Add device of max adapter  +3 
numbers.push(numbers.max + 3)

diff = numbers.each_cons(2).map { |a,b| b-a }
part1 = diff.count(1) * diff.count(3)

#Part 1
puts part1

#Part 2
def findCombinations(arr, start) 

    validcount = 0
    
    validcount += 1
    for i in start..arr.size-2
        if start == 1 and arr.size == 97
            puts i
        end
        if ((arr[i+1] - arr[i-1]) < 4)
            arraycheck = arr.clone
            arraycheck.delete_at(i)
            validcount += findCombinations(arraycheck, i)
        end
    end

    return validcount
end

puts findCombinations(numbers, 1)
