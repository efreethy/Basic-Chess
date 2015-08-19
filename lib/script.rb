require_relative 'piece'
require_relative 'board'
require_relative 'game'
require 'byebug'

board = Board.new
game = Game.new(board)
game.load_pieces
game.load_players

game.board.print
until game.game_over?
move = game.current_player.get_move(board)

  until board.valid_move?(move, game.current_player)
    # debugger
    puts "Invalid Move"
    move = game.current_player.get_move(board)
  end

board.execute_move(move, game.waiting_player)
game.board.print
game.switch_players
end

puts "#{game.waiting_player.color} wins!! thanks for playing"
