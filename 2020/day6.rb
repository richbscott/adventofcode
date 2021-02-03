require './inputs'

input = Inputs::DAY6

answers = 0
p2_answers = 0
input.split(/\n{2,}/).each do |group|
  answers += group.gsub(/\s+/, "").split(//).uniq.length

  individuals = group.split(/\n/)
  answerarray = []
  individuals.each do |i|
    answerarray << i.split(//).uniq
  end
  p2_answers += answerarray.inject(:'&').length
end

#Part 1
puts answers

#Part 2 
puts p2_answers

