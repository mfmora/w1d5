class Searchable

  def dfs(root, value)
    return root if root.value == value

    root.children.each do |child|
      result = dfs(child,value)
      return result unless result
    end
    nil
  end

  def bfs
  end

end
