require_relative 'piece'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  #are we asking for an index greater than length and width, or an index less than zero?
  def out_of_bounds?(pos)
    (pos[0] > 7 || pos[1] > 7) || (pos[0] < 0 || pos[1] < 0) ? true : false
  end

  def mark(pos)
    row, col = pos[0], pos[1]
    @grid[row][col] = "X"
  end

  def print
    @grid.each do |row|
      line = ""
      row.each do |el|
        el = " " if el == nil
        line += "|" + el.to_s
      end
      puts line + "|"
    end
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
