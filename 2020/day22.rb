require './inputs'

input = Inputs::DAY22

player1deck = []
player2deck = []

input.split("\n\n").each_with_index do |decks, i|

  player1deck = decks.split("\n").map(&:to_i) if i == 0

  player2deck = decks.split("\n").map(&:to_i) if i == 1
end
player1deck.shift
player2deck.shift

part2_player1deck = player1deck.clone
part2_player2deck = player2deck.clone
#puts player1deck.to_s
#puts player2deck.to_s

while player1deck.size > 0 && player2deck.size > 0

  p1card = player1deck.shift
  p2card = player2deck.shift
  if  p1card > p2card
    player1deck << p1card
    player1deck << p2card
  elsif p1card < p2card
    player2deck << p2card
    player2deck << p1card
  end
end

if player1deck.size > 0
  winningdeck = player1deck
else
  winningdeck = player2deck
end

sum = 0
winningdeck.reverse.each_with_index do |card, i|
  sum += card*(i+1)
end

# part1
puts sum.to_s



# part2

def playround(player1deck, player2deck, subgame)
  i = 1


  stack = []
  while player1deck.size > 0 && player2deck.size > 0

    if stack.include?([player1deck, player2deck])
      return 1
    end

    stack << [player1deck.dup, player2deck.dup]

    p1card = player1deck.shift
    p2card = player2deck.shift

    if p1card <= player1deck.size && p2card <= player2deck.size
      p1subdeck = player1deck[0,p1card]
      p2subdeck = player2deck[0,p2card]
      winner = playround(p1subdeck, p2subdeck, true)
    else
      if  p1card > p2card
        winner = 1
      else
        winner = 2
      end
    end

    if winner == 2
      player2deck << p2card
      player2deck << p1card
    else
      player1deck << p1card
      player1deck << p2card
    end
    i += 1
  end

  if player1deck.size > 0
    return player1deck if !subgame
    return 1
  else
    return player2deck if !subgame
    return 2
  end
end

winningdeck = playround(part2_player1deck, part2_player2deck, false)

puts winningdeck.to_s

sum = 0
winningdeck.reverse.each_with_index do |card, i|
  sum += card*(i+1)
end

puts sum.to_s

# 31854

