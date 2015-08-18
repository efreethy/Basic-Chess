require_relative 'piece'
require_relative 'singlesteppiece'
require_relative 'slidingpiece'

class PieceLoader

  @@starting_pos = {"Rook"=>[[0,0],[0,7],[7,0],[7,7]] ,"Horse"=> [[0,1],[0,6],[7,1],[7,6]],
                    "Bishop"=> [[0,2],[0,5],[7,2],[7,5]],
                    "Queen" => [[0,3],[7,3]] , "King" => [[0,4],[7,4]] }

  @@factory = {"Rook"=> -> { Rook.new } ,"Horse"=> -> { Horse.new },
               "Bishop"=> -> { Bishop.new },
               "Queen" => -> { Queen.new }, "King" => -> { King.new } }


  def self.load_pawns(board)
     colors = [:white, :black]
     colors.each do |symbol|
       row = nil
       symbol == :black ? row = 1 : row = 6
       board.grid[row].each_index do |col|
        board[[row,col]] = Pawn.new(color: symbol, pos: [row,col])
       end
     end
  end

  def self.load_pieces(board)
    load_pawns(board)

    @@starting_pos.keys.each do |key|
        @@starting_pos[key].each do |pos|
            board[pos] = @@factory[key].call
            board[pos].pos = pos
            board[pos].color = :black if pos[0] < 1
        end
    end
  end

end
