require_relative 'piece.rb'
require File.expand_path('./helpers.rb')

# Class to describe a Queen's available moves in current possiton
class Queen < Piece
  attr_accessor :possible_moves, :piece

  def initialize(pos, color, current_board)
    @pos = pos
    @color = color
    @piece = Helpers.corresponding_hash(@color)[:Queen]
    @moves_made = 0
    @current_board = current_board
    @possible_moves = []
    #generate_moves
  end
end