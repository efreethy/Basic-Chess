
class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def mark(pos, marker)
    row, col = pos[0], pos[1]
    @grid[row][col] = marker
  end

  def valid_move?(move,current_player)
    start, target = move[0], move[1]
    if  valid_start?(start, current_player) && valid_target?(move)
      true
    else
      false
    end
  end

  def execute_move(move, waiting_player)
    start, target = move[0], move[1]
    piece = self[start]
    self[start] = nil
    if self[target].is_a?(Piece)
      reduce_available_pieces(waiting_player, self[target])
    end
    self[target] = piece
    self[target].pos = target
  end

  def reduce_available_pieces(waiting_player, piece)
    waiting_player.available_pieces.delete(piece)
  end

  def valid_start?(start, current_player)
    row, col = start[0], start[1]
    return false if @grid[row][col].nil? || current_player.color != @grid[row][col].color
    return false if @grid[row][col].pathspace(self).length == 0
    true
  end

  def valid_target?(move)
    start, target = move[0], move[1]
    return false if @grid[start[0]][start[1]].nil?
    @grid[start[0]][start[1]].pathspace(self).include?(target) ? true : false
  end

  def print
    i = 0
    @grid.each do |row|
      line = ""
      m = 0
      row.each do |el|
        el = " " if el == nil
        line += "|" + el.to_s
      end
      puts "#{i} #{line}|"
      i += 1
    end
    puts "   0 1 2 3 4 5 6 7"
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
