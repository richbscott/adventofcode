require './inputs'

input = Inputs::DAY18

#Part 1
variables = {}
sounds = {}
instructions = input.split("\n")
position = 0
count = 0
while position < instructions.length - 1 do


  instruction = instructions[position]
  #puts instruction
  count += 1

  var = instruction[4,1]
  variables[var] ||= 0

  case instruction[0,3]
    when "set"
      value = instruction[6..-1]
      if value.to_i.to_s == value
        variables[var] = value.to_i
      else
        variables[var] = variables[value]
      end
    when "add"
      value = instruction[6..-1]
      # if value is int or var
      if value.to_i.to_s == value
        variables[var] = variables[var] + value.to_i
      else
        variables[var] = variables[var] + variables[value]
      end
    when "mul"
      value = instruction[6..-1]
      # if value is int or var
      if value.to_i.to_s == value
        variables[var] = variables[var] * value.to_i
      else
        variables[var] = variables[var] * variables[value]
      end
    when "mod"
      value = instruction[6..-1]
      # if value is int or var
      if value.to_i.to_s == value
        variables[var] = variables[var] % value.to_i
      else
        variables[var] = variables[var] % variables[value]
      end
    when "snd"
      sound = variables[var]

    when "rcv"
      if (!variables[var].nil? && variables[var] != 0)
        puts "RECOVER SOUND " + var + " " + sound.to_s
        exit
      end

    when "jgz"
      value = instruction[6..-1]
      if (variables[var] > 0)
        if value.to_i.to_s == value
          position = position + value.to_i
        else
          position = position + variables[value]
        end
        next
      end
    end

    position += 1
end