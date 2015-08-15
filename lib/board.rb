require_relative 'piece'
class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def out_of_bounds?(pos)
    !@grid[pos[0],pos[1]].respond_to?(:[])
  end

  # these bracket methods should be fed arrays ie) if pos = [2,4] -> @grid[pos]
  def [](pos)
    row, col = pos[0], pos[1]
    @grid[row][col]
  end

  def []=(pos,value)
    row, col = pos[0], pos[1]
    @grid[row][col] = value
  end

end
