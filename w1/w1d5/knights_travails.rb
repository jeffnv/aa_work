load "tree_multiple_children.rb"
#TreeNode class is defined

class KnightPathFinder
  ADD_TO_KNIGHT_POS = [[2,1],[1,2],[-1,2],[-2,1],[-2,-1],[-1,-2],[1,-2],[2,-1]]
  attr_reader :move_tree, :move_list

  def initialize(start_pos)
    @start_pos = start_pos
    @move_tree = nil
    build_board
    build_move_tree
  end

  def build_board
    []
  end

  def trim_illegal_moves!(possible_moves)
    possible_moves.select! do |possible_move|
      possible_move.none?{|cooridinate| cooridinate < 0 || cooridinate > 7}
    end
  end

  def search_possible_moves(current_position)
    new_spaces = ADD_TO_KNIGHT_POS.map do |location_pair|
      [location_pair[0] + current_position[0], location_pair[1] + current_position[1]]
    end

    trim_illegal_moves!(new_spaces)

    new_spaces.each do |location_pair|
      unless @move_tree.dfs(location_pair)
        @move_tree.add_node(TreeNode.new(location_pair))
        search_possible_moves(location_pair)
      end
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