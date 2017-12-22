require './inputs'

input = Inputs::DAY8

OPERATORS = {'inc' => '+=', 'dec' => '-='}

class Instruction
  attr_accessor :register,:operation,:adjuster,:comparison_var,:comparison_operator,:comparison_value

  def initialize(*args)
    @register,@operation,@adjuster,@comparison_var,@comparison_operator,@comparison_value,=args
  end

  def parse
    return 'registers[\'' + self.register + '\'] ' + OPERATORS[self.operation] + ' ' + self.adjuster + ' if ' + 'registers[\''+ self.comparison_var + '\'] ' + self.comparison_operator + ' ' + self.comparison_value
  end
end

registers = {}

max_during_process = 0

input.split("\n").each do |row|
  details = row.split()
  instruction = Instruction.new(details[0], details[1], details[2], details[4], details[5], details[6])
  registers[instruction.register] ||= 0
  registers[instruction.comparison_var] ||= 0
  #puts instruction.parse
  eval instruction.parse
  current_max = registers.values.max
  max_during_process = current_max if current_max > max_during_process

end

#Part 1
max = registers.values.max
puts max

#Part 2
puts max_during_process