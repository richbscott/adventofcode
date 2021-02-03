require './inputs'


def runinstructions(instructions, mustcomplete)
  accumulator = 0
  
  position = 0
  instructions_run = []
  while position < instructions.length do

    if instructions_run.include?(position)
      if mustcomplete
        return false
      else        
        break
      end
    end
    instruction = instructions[position]
    instructions_run << position

    case instruction[0,3]
      when "acc"
        accumulator += instruction[4,instruction.length-1].to_i
        position += 1
      when "jmp"
        position += instruction[4,instruction.length-1].to_i
      when "nop"
        position += 1
    end

  end

  return accumulator
end

input = Inputs::DAY8
instructions = input.split("\n")

#Part 1
puts runinstructions(instructions, false)
#1723

#Part 2
for i in 0..instructions.size-1 do 
  newinstructions = instructions.map(&:clone)
  if (instructions[i][0,3] == 'jmp')
    newinstructions[i].gsub!("jmp", "nop")
    result = runinstructions(newinstructions, true)
  elsif (instructions[i][0,3] == 'nop')
    newinstructions[i].gsub!("nop", "jmp")
    result = runinstructions(newinstructions, true)
  end
  if result
    puts result
    break
  end
 
end

