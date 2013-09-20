class TreeNode
  attr_accessor :value, :parent
  attr_reader :children
  def initialize(value = nil)
    @children = []
    @parent = nil
    @value = value
  end

  def display
    p self.value
  end

  def add_node(new_node)
    @children << new_node
    new_node.parent = self
  end

  def dfs(value_to_search = nil, &prc)
    prc ||= Proc.new { |value| value == value_to_search }
    return self if prc.call(self.value)

    @children.each do |child_node|
      child_node_search_result = child_node.dfs(&prc)

      if child_node_search_result
        return child_node_search_result # if prc.call(child_node_search_result.value)
      end

    end #find

  end


  def bfs(value_to_search = nil, &prc)
    prc ||= Proc.new { |value| value == value_to_search }
    # condition_satisfied = (block_given? ? prc.call(self.value) : self.value == value_to_search)

    return self if prc.call(self.value)

    nodes_to_search = @children
    found_node  = nodes_to_search.find{|node|prc.call(node.value)}

    return found_node if found_node
    return nil if nodes_to_search.empty?

    nodes_to_search.each do |node|
      found_node = node.bfs(&prc)
      return found_node unless found_node.nil?
    end

    nil
  end
end

#
# root = TreeNode.new("D")
# level1_left = root.add_node(TreeNode.new("C"))
# level1_right = root.add_node(TreeNode.new("F"))
# level2_left = level1_left.add_node(TreeNode.new("B"))
# level1_left.add_node(TreeNode.new("Q"))
#
#
# p root.dfs("Q").display
#
# puts "\n    Testing DFS\n"
# puts "\nSearching for 'B'..."
# result = root.dfs("B")
# p "Found node: #{result.display}"
#
#
# puts "\nSearch 'H' value, not in tree"
# p "Found node: #{root.dfs("H").display}"
#
# puts "\nSearch 'F'"
# p "#{root.dfs("F").display}"
#
# puts "\n\n      BFS search tests:\n\n"
# result = root.bfs("B")
# p "Found node: #{result.display}"
#
# puts "\nSearch 'H' value, not in tree"
# p "Found code: #{root.bfs("H").display}"
#
# puts "\nSearch 'F' found #{root.bfs("F").display}"
#
# puts "\nSearch 'B' with block using DFS"
# p "Found: #{(root.dfs{|val|val == 'B'}).display}"
#
# puts "\nSearch 'B' with block using BFS"
# p "Found: #{(root.bfs{|val|val == 'B'}).display}"
