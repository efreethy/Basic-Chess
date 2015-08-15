require_relative 'board'

class Piece
  attr_accessor :color, :pos

  def initialize(options = {})
    defaults = { color: :white }
    options = defaults.merge(options)

    @pos = options[:pos]
    @color = options[:color]
  end

end
