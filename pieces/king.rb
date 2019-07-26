require_relative 'piece.rb'
require File.expand_path('./helpers.rb')

# Class to describe a King's available moves in current possiton
class King < Piece
  attr_accessor :possible_moves, :piece, :moves_made

  def initialize(pos, color, current_board)
    @pos = pos
    @color = color
    @piece = Helpers.corresponding_hash(@color)[:King]
    @moves_made = 0
    @current_board = current_board
    @x_moves = [1, 1, -1, 0, -1, 0, 1, -1]
    @y_moves = [1, 0, 0, 1, 1, -1, -1, -1]
  end

  def king_move_possible?(curr)
    on_board?(curr) && !taken_by_same_color_piece(curr) && !taken_by_opposite_king?(curr)
  end

  def generate_moves(pos)
    moves = []

    8.times do |index|
      curr = [pos[0] + @x_moves[index], pos[1] + @y_moves[index]]
      moves.push([pos, curr]) if king_move_possible?(curr)
    end
    moves
  end
end
