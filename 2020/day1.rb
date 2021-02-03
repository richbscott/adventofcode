require './inputs'

input = Inputs::DAY1


def sumfromarray(arr, sum)
  arr.each do |a|
    arr.each do |b|
      c = a + b
      return a*b if c == sum
    end
  end
  return -1
end

arr = input.split("\n").map(&:to_i)

#Part 1
puts sumfromarray(arr, 2020)

#Part 2
arr.each do |z|
  result = sumfromarray(arr, 2020 - z)
  if result > 0
    puts result * z
    break
  end
end