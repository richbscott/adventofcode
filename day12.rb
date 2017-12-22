require './inputs'

input = Inputs::DAY12

#Part1
pipes = []

input.split("\n").each do |row|
  details = row.split(' <-> ')
  pipes << details[1].split(",").map(&:to_i)
end
#puts pipes.to_s

processed_pipes = []
to_be_checked = [0]

while to_be_checked.length > 0
    check_pipe = to_be_checked.shift
    pipes[check_pipe].each do |pipe|
        if !processed_pipes.include?(pipe)
            to_be_checked << pipe
        end
    end
    processed_pipes << check_pipe
end
puts processed_pipes.uniq.length

#Part 2

groups = 0
found = []

pipes.each_with_index do |pipe_item, index|

    if (found.include?(index))
        next
    end
    to_be_checked = [index]
    processed_pipes = []
    while to_be_checked.length > 0
        check_pipe = to_be_checked.shift
        pipes[check_pipe].each do |pipe|
            if !processed_pipes.include?(pipe)
                to_be_checked << pipe
            end
        end
        processed_pipes << check_pipe
    end
    found += processed_pipes.uniq
    groups += 1
end

puts groups