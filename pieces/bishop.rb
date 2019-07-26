require_relative 'piece.rb'
require File.expand_path('./helpers.rb')

# Class to describe a Bishop's available moves in current possiton
class Bishop < Piece
  attr_accessor :possible_moves, :piece

  def initialize(pos, color, current_board)
    @pos = pos
    @color = color
    @piece = Helpers.corresponding_hash(@color)[:Bishop]
    @moves_made = 0
    @current_board = current_board
  end

  def generate_moves(pos)
    @possible_moves = []
    @possible_moves += up_right_diagonal_moves(pos)
    @possible_moves += up_left_diagonal_moves(pos)
    @possible_moves += down_left_diagonal_moves(pos)
    @possible_moves += down_right_diagonal_moves(pos)
    p @possible_moves
    @possible_moves
  end
end
