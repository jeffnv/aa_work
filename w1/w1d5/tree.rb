class TreeNode
  attr_accessor :value, :parent
  def initialize(value = nil)
    @left = nil
    @right = nil
    @parent = nil
    @value = value
  end

  def display
    "Node with value #{self.value}"
  end

  def left=(new_node)
    @left = new_node
    new_node.parent = self
  end

  def left
    @left
  end

  def right=(new_node)
    @right = new_node
    new_node.parent = self
  end

  def right
    @right
  end

  def dfs(value_to_search)
    return self if self.value == value_to_search

    if self.left
      left_result = self.left.dfs(value_to_search)
    end

    if self.right
      right_result = self.right.dfs(value_to_search)
    end

    left_result || right_result
  end

  def bfs(value_to_search)
    return self if self.value == value_to_search
    nodes_to_search = []

    if self.left
      nodes_to_search << self.left
    end

    if self.right
      nodes_to_search << self.right
    end

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
level1_left = root.left = TreeNode.new("C")
level1_right = root.right = TreeNode.new("F")
level2_left = level1_left.left = TreeNode.new("B")
level1_left.right = TreeNode.new("Q")


p root.dfs("Q").display

#
#
# puts "Searching for 'B'..."
# result = root.dfs("B")
# p result.inspect
# puts "Found node: #{result.display}"
#
#
# puts "\nSearch 'H' value, not in tree"
# p root.dfs("H")
#
# puts "Search 'F'"
# puts "#{root.dfs("F")}"
#
# result = root.bfs("B")
# puts "Found node: #{result.display}"
#
# puts "\nSearch 'H' value, not in tree"
# p root.bfs("H")
#
# puts "Search 'F' found #{root.bfs("F").display}"