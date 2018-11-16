require './inputs'

input = Inputs::DAY16

$programs = [*('a'..'p')]

#Part 1

def dance(moves)
  moves.each do |dance|

    case dance[0,1]
    when "s"
      $programs = $programs.rotate(-1 * (dance[1..-1]).to_i)
    when "x"
      positions = dance[1..-1].split("/")
      tmp = $programs[positions[1].to_i]
      $programs[positions[1].to_i] = $programs[positions[0].to_i]
      $programs[positions[0].to_i] = tmp
    when "p"
      values = dance[1..-1].split("/")
      index_a = $programs.index(values[0])
      index_b = $programs.index(values[1])
      $programs[index_a] = values[1]
      $programs[index_b] = values[0]
    end
  end
end

dance(input.split(","))
puts $programs.join("")

#Part 2

#The same result occurs after each iteration of 60 so we only need to run the modulus number of times
(999999999 % 60).times do |count|
  dance(input.split(","))
end

puts $programs.join("")
