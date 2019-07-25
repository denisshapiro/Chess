require_relative 'piece.rb'

# Class to describe a Bishop's available moves in current possiton
class Bishop < Piece
  attr_accessor :possible_moves

  def initialize(pos, color, current_board)
    @pos = pos
    @color = color
    @current_board = current_board
    @possible_moves = []
    generate_moves
    p @possible_moves
  end

  def generate_moves
    @possible_moves += up_right_diagonal_moves(@pos, @board, @color)
    @possible_moves += up_left_diagonal_moves(@pos, @board, @color)
    @possible_moves += down_left_diagonal_moves(@pos, @board, @color)
    @possible_moves += down_right_diagonal_moves(@pos, @board, @color)
    @possible_moves
  end
end
