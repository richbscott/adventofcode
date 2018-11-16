require './inputs'

class Generator
  attr_accessor :factor,:value

  def initialize(factor, value)
    @factor = factor
    @value = value
  end

  def generate_next_value()
    self.value  = (self.value * self.factor) % 2147483647
  end

  def lowest_16_bits
    bits = self.value.to_i.to_s(2)
    return bits[-16..-1]
  end

end

#Part 1
generatorA = Generator.new(16807, 277)
generatorB = Generator.new(48271, 349)

matches = 0
40000000.times do |count|
  generatorA.generate_next_value()
  generatorB.generate_next_value()
  if generatorA.lowest_16_bits == generatorB.lowest_16_bits
    matches += 1
  end
end

puts matches

#Part 2

generatorA = Generator.new(16807, 277)
generatorB = Generator.new(48271, 349)
matches = 0
5000000.times do |count|

  while (generatorA.value % 4 != 0)
    generatorA.generate_next_value()
  end

  while (generatorB.value % 8 != 0)
    generatorB.generate_next_value()
  end

  if generatorA.lowest_16_bits == generatorB.lowest_16_bits
    matches += 1
  end
  generatorA.generate_next_value()
  generatorB.generate_next_value()
end


puts matches
