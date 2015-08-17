class Array
  def neighbor(pos)
    [self[0] + pos[0], self[1] + pos[1]]
  end
end
