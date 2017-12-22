require './inputs'

input = Inputs::DAY9

state = 'group'
score = 0
depth = 1
garbage_chars = []
letters = input.split('')
prev_letter = ''
cancelled = false

letters.each_with_index do |char, index|

    if (char == '!' && cancelled == false)
      cancelled = true
      next
    elsif (cancelled == true)
      cancelled = false
      next
    elsif (state == 'garbage' && char != '>')
      garbage_chars << char
    elsif (char == '<')
      state = 'garbage'
    elsif (char == '>')
      state = 'group'
    elsif (char == '{')
      score += depth
      depth += 1
    elsif (char == '}')
      depth -= 1
    end

end

puts score

puts garbage_chars.length