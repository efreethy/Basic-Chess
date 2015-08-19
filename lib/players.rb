require_relative 'board'
require_relative 'piece'
require 'byebug'

class Player
  attr_accessor :available_pieces, :color

  def assign_pieces(board, rows)
    available_pieces = []
    rows.each do |row|
      board.grid[row].each_index do |col|
          available_pieces << board.grid[row][col]
      end
    end
    available_pieces
  end

end

class HumanPlayer < Player
  @@start_rows = [6,7]

  def initialize(board)
    @available_pieces = assign_pieces(board, @@start_rows)
    @color = :white
  end

  def get_move(board)
    print "Make your move: "
    move = gets
    start, target = [], []
    start, target = [move[0].to_i,move[2].to_i], [move[4].to_i,move[6].to_i]
    [start,target]
  end

end

class ComputerPlayer < Player
  @@start_rows = [0,1]

  def initialize(board)
    @available_pieces = assign_pieces(board, @@start_rows)
    @color = :black
  end

  def get_move(board)
  #  debugger
    best_piece = select_largest_pathspace(board)
    start = best_piece.pos
    target = find_farthest_target(best_piece, board)
    [start,target]
  end

  def select_largest_pathspace(board)
     largest_pathspace = 0
     best_piece = nil
     @available_pieces.each do |piece|
       pathspace_size = piece.pathspace(board).length
       if pathspace_size > largest_pathspace
         largest_pathspace = pathspace_size
         best_piece = piece
       end
     end
     best_piece
  end

  def find_farthest_target(piece, board)
    farthest_row = 0
    best_target = []
    piece.pathspace(board).each do |pos|
      if pos[0] > farthest_row
        farthest_row = pos[0]
        best_target = pos
      end
    end
    if farthest_row == 0
      best_target = piece.pathspace(board).sample
    end
    best_target
  end

end
