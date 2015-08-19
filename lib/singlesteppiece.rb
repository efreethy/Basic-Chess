require_relative 'piece'
require_relative 'array'

class SingleStepPiece < Piece

  def get_pathspace(permitted_directions, board)
    pathspace = []
    permitted_directions.each do |dir|
      neighbor = pos.neighbor(@@directions[dir])
      next if out_of_bounds?(neighbor)
      if board[neighbor].is_a?(Piece) #include an enemy block into pathspace
        pathspace << neighbor unless board[neighbor].color == self.color
        next
      end
      pathspace << neighbor
    end
    pathspace
  end

end

class King < SingleStepPiece
  @@permitted_directions = [:upleft, :upright, :downleft, :downright, :up, :down,
                           :left, :right]

  def pathspace(board)
    get_pathspace(@@permitted_directions, board)
  end

  def to_s
    color == :white ? "♔" : "♚"
  end

end

class Pawn < SingleStepPiece

   @@permitted_directions = []

   def initialize(options = {})
     defaults = { color: :white }
     options = defaults.merge(options)

     @pos = options[:pos]
     @color = options[:color]
   end

   def get_permitted_directions
        if self.color == :white
         @@permitted_directions = [:upleft, :up, :upright]
       elsif self.color == :black
          @@permitted_directions = [:downleft, :down, :downright]
        end
   end

   def permitted_directions
      @@permitted_directions
   end



  def pathspace(board)
    @@permitted_directions = get_permitted_directions
    path = []
    @@permitted_directions.each do |dir|
      neighbor = pos.neighbor(@@directions[dir])
      next if out_of_bounds?(neighbor)
      if dir == :upleft || dir == :upright || dir == :downleft || dir == :downright
        path << neighbor if board[neighbor].is_a?(Piece) && board[neighbor].color != self.color
      elsif dir == :up || dir == :down
        path << neighbor if board[neighbor] == nil
      end
    end
    path
  end

  def to_s
    color == :white ? "♙" : "♟"
  end

end

class Horse  < SingleStepPiece
  @@permitted_directions = [[-1, 2], [-1, -2], [1, 2], [1, -2], [-2, 1], [-2, -1], [2, 1], [2, -1]]

  def pathspace(board)
    pathspace = []
    @@permitted_directions.each do |dir|
      neighbor = pos.neighbor(dir)
      next if out_of_bounds?(neighbor)
      if board[neighbor].is_a?(Piece)
        pathspace << neighbor unless board[neighbor].color == self.color
        next
      end
      pathspace << neighbor
    end
    pathspace
  end

  def to_s
    color == :white ? "♘" : "♞"
  end

end
