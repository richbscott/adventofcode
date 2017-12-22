require './inputs'

input = Inputs::DAY4

#Part1
valid_count = 0
input.split("\n").each do |passphrase|
  words = passphrase.split()
    valid_count += 1 if (words.length == words.uniq.length)
end

puts valid_count

#Part2
valid_count = 0
input.split("\n").each do |passphrase|
  words = passphrase.split()
  invalid = false
  next if (words.length != words.uniq.length)

  sorted_words = []
  words.each { |word| sorted_words << word.chars.sort.join }

  next if (words.length != sorted_words.uniq.length)
  valid_count += 1
end

puts valid_count