require_relative 'poly_tree.rb'

class KnightPathFinder
  DELTAS = [
    [2, -1],
    [2, 1],
    [-2, -1],
    [-2, 1],
    [1, 2],
    [1,-2],
    [-1, 2],
    [-1, -2]
  ]



  def initialize(starting_pos)
    @current_position = starting_pos
    @visited_positions = [starting_pos]
  end

  def build_move_tree
    root = PolyTreeNode.new(@current_position)
    queue = [root]

    until queue.empty?
      current_node = queue.shift

      new_move_positions(current_node.value).each do |pos|
        new_node = PolyTreeNode.new(pos)
        new_node.parent = current_node
        queue << new_node
      end
    end
    root
  end

  def find_path(pos)
  end

  def self.valid_moves(pos)
    start_x, start_y = pos
    DELTAS.map do |x, y|
      new_x, new_y = x + start_x, y + start_y
      [new_x, new_y] if in_map?(new_x, new_y)
    end.compact
  end

  def self.in_map?(pos_x, pos_y)
    pos_x.between?(0,7) && pos_y.between?(0,7)
  end

  def new_move_positions(pos)
    result = []
    KnightPathFinder.valid_moves(pos).each do |pos|
      unless @visited_positions.include?(pos)
        @visited_positions << pos
        result << pos
      end
    end
    result
  end

  def find_path_bfs(pos)
    bfs_node = build_move_tree.bfs(pos)
    trace_path_back(bfs_node)
  end

  def find_path_dfs(pos)
    dfs_node = build_move_tree.dfs(pos)
    trace_path_back(dfs_node)
  end

  def trace_path_back(node)
    return [node.value] if node.parent.nil?
    trace_path_back(node.parent) + [node.value]
  end

end
