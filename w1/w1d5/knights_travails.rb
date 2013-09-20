load "tree_multiple_children.rb"
#TreeNode class is defined

class KnightPathFinder
  ADD_TO_KNIGHT_POS = [[2,1],[1,2],[-1,2],[-2,1],[-2,-1],[-1,-2],[1,-2],[2,-1]]
  attr_reader :move_tree, :move_list

  def initialize(start_pos)
    @start_pos = start_pos
    @move_tree = nil
    @move_list = []
    build_move_tree
  end

  def find_path(target_pos)
    path = [target_pos]
    target_node = @move_tree.bfs(target_pos)

    return [target_node.value] if target_node.parent.nil?

    #search @move_tree for target_pos using dfs/bfs

    find_path(target_node.parent.value) + path

  end

  def trim_illegal_moves!(possible_moves)
    possible_moves.select! do |possible_move|
      possible_move.none?{|cooridinate| cooridinate < 0 || cooridinate > 7}
    end
  end

  def search_possible_moves(current_position)
    leaf_node = @move_tree.bfs(current_position)

    new_spaces = ADD_TO_KNIGHT_POS.map do |location_pair|
      [location_pair[0] + current_position[0], location_pair[1] + current_position[1]]
    end

    trim_illegal_moves!(new_spaces)


    new_spaces.each_with_index do |location_pair, index|
      if @move_tree.bfs(location_pair)
        new_spaces[index] = nil
      else
        @move_list << location_pair
        leaf_node.add_node(TreeNode.new(location_pair))
      end
    end

    new_spaces.compact!

    new_spaces.each do |location_pair|
        search_possible_moves(location_pair)
    end

  end

  def build_move_tree
    @move_tree = TreeNode.new(@start_pos)
    search_possible_moves(@start_pos)

    #store in instance variable
    #build tree using new_move_positions
  end

  def new_move_positions(pos)
    #find positions you can move to from current position, up to 8 possible moves
  end

end

class TreeNode
  def path
    #call parents to trace back route
  end

  def display_all_nodes

  end
end

game = KnightPathFinder.new([0,0])
p game.find_path([3,3])