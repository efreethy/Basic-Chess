require_relative 'players'
require_relative 'pieceloader'
require_relative 'piece'

class Game
  attr_accessor :board, :current_player, :human, :computer, :waiting_player

  def initialize(board)
    @board = board
  end

  def load_pieces
    PieceLoader.load_pieces(board)
  end

  def load_players
    @human = HumanPlayer.new(board)
    @computer = ComputerPlayer.new(board)
    @current_player = @human
    @waiting_player = @computer
  end

  def switch_players
    if @current_player == @human
       @current_player = @computer
       @waiting_player = @human
    else
        @current_player = @human
        @waiting_player = @computer
    end
  end

  def game_over?
    king_count = 0
    available_pieces = @human.available_pieces + @computer.available_pieces
    available_pieces.each do |piece|
      king_count += 1 if piece.is_a?(King)
    end
    king_count < 2 ? true : false
  end

end
