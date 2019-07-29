require_relative 'piece.rb'
require File.expand_path('./helpers.rb')

# Class to describe a Queen's available moves in current possiton
class Queen < Piece
  attr_accessor :possible_moves, :piece, :moves_made, :pos, :king_in_check

  def initialize(pos, color, current_board)
    @pos = pos
    @color = color
    @piece = Helpers.corresponding_hash(@color)[:Queen]
    @moves_made = 0
    @current_board = current_board
    @king_in_check = false
  end

  def generate_moves(pos)
    possible_moves = []
    possible_moves += up_right_diagonal_moves(pos)
    possible_moves += up_left_diagonal_moves(pos)
    possible_moves += down_left_diagonal_moves(pos)
    possible_moves += down_right_diagonal_moves(pos)

    possible_moves += forward_line_moves(pos)
    possible_moves += backward_line_moves(pos)
    possible_moves += right_line_moves(pos)
    possible_moves += left_line_moves(pos)
    possible_moves
  end
end
