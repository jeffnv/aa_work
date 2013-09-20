
class TreeNode
  attr_accessor :value, :parent
  attr_reader :children
  def initialize(value = nil)
    @children = []
    @parent = nil
    @value = value
  end

  def display
    "Node with value #{self.value}"
  end

  def add_node(new_node)
    @children << new_node
    new_node.parent = self
  end

  def dfs(value_to_search)
    return self if self.value == value_to_search

    @children.find do |child_node|
      child_node_search_result = child_node.dfs(value_to_search)
      if child_node_search_result
        child_node_search_result.value == value_to_search
      end
    end
  end

  def bfs(value_to_search)
    return self if self.value == value_to_search
    nodes_to_search = @children

    found_node  = nodes_to_search.find{|node|node.value == value_to_search}

    return found_node if found_node
    return nil if nodes_to_search.empty?

    nodes_to_search.each do |node|
      found_node = node.bfs(value_to_search)
      return found_node unless found_node.nil?
    end

    nil
  end
end


root = TreeNode.new("D")
level1_left = root.add_node(TreeNode.new("C"))
level1_right = root.add_node(TreeNode.new("F"))
level2_left = level1_left.add_node(TreeNode.new("B"))
level1_left.add_node(TreeNode.new("Q"))


p root.dfs("Q").display

puts "\n    Testing DFS\n"
puts "\nSearching for 'B'..."
result = root.dfs("B")
puts "Found node: #{result.display}"


puts "\nSearch 'H' value, not in tree"
puts "Found node: #{root.dfs("H").display}"

puts "\nSearch 'F'"
puts "#{root.dfs("F").display}"

puts "\n\n      BFS search tests:\n\n"
result = root.bfs("B")
puts "Found node: #{result.display}"

puts "\nSearch 'H' value, not in tree"
p root.bfs("H")

puts "\nSearch 'F' found #{root.bfs("F").display}"