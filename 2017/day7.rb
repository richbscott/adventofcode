require './inputs'

input = Inputs::DAY7

class Node
  attr_accessor :name,:weight,:child_names,:children

  def initialize(*args)
    @name,@weight,@child_names=args
    @children = []
  end

  def load_children(nodes)
    if (self.child_names)
      self.child_names.each do |child|
          child_node = nodes.index{|node|node.name==child}
          self.children << child_node
      end
    end
  end

  def total_weight(nodes)
    total = 0
    self.children.each do |child|
      total += nodes[child].total_weight(nodes)
      #total += nodes[child].weight
    end
    total += self.weight
  end

end

#Part 1
root_node = false
all_children = []
nodes = []
input.split("\n").each do |row|

  details = row.split(" -> ")

  if !details[1].nil?
    children = details[1].split(", ")
  else
    children = false
  end
  name_weight = details[0].split()

  node = Node.new(name_weight[0], name_weight[1][1..-2].to_i, children)
  nodes << node

  all_children.concat(node.child_names) if node.child_names
end

nodes.each do |node|
  # If the node name is not a child of anything else it is our root
  if !all_children.include?(node.name)
    root_node = node
  end
end
puts root_node.name

#Part 2
#Load child nodes
nodes.each do |node|
  node.load_children(nodes)
end

#loop over root node children to find which node is unbalanced
def get_unbalanced_child(node, nodes)
  child_weights = []
  weights = {}
  node.children.each do |child|
    total_weight = nodes[child].total_weight(nodes)
    child_weights << total_weight
    weights[total_weight] = child
  end

  weights_by_count = child_weights.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
  invalid_weight = false
  weights_by_count.each_with_index do |weight, index|
    if weight[1] == 1 && node.children.length > 0 # this one weight is different to all the others and therefore is not balanced
      invalid_weight = weight[0]
    end
  end

  if invalid_weight
    return nodes[weights[invalid_weight]];
  end

  return false
end

node = root_node
unbalanced = []
while (node)
  unbalanced << node
  node = get_unbalanced_child(node, nodes)
end

unbalanced_node = unbalanced.pop
parent = unbalanced.pop

weights = []
parent.children.each_with_index do |child, index|
  weights << nodes[child].total_weight(nodes)
end

weights_by_count = weights.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
correct_total_weight = weights_by_count.max_by { |v| weights_by_count[v] }

puts correct_total_weight[0] - (unbalanced_node.total_weight(nodes) - unbalanced_node.weight)