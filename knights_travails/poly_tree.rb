require 'byebug'

class PolyTreeNode
  attr_reader :children, :value, :parent

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(node)
    @parent.children.delete(self) if @parent

    @parent = node
    @parent.children << self unless @parent.nil?
  end

  def add_child(node)
    node.parent = self
  end

  def has_child?(child)
    self.children.include?(child)
  end

  def remove_child(child)
    raise "node is not a child" unless self.has_child?(child)
    child.parent = nil
    @children.delete(child)
  end

  def dfs(value)
    return self if self.value == value

    self.children.each do |child|
      result = child.dfs(value)
      return result if result
    end
    nil
  end

  def bfs(value)
    queue = [self]

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == value
      queue += current_node.children
    end
    nil
  end

end
