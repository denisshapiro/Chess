require_relative 'piece.rb'
require File.expand_path('./helpers.rb')

# Class to describe a Knight's available moves in current possiton
class Knight < Piece
  attr_accessor :possible_moves, :piece, :moves_made, :pos, :king_in_check

  def initialize(pos, color, current_board)
    @pos = pos
    @color = color
    @piece = Helpers.corresponding_hash(@color)[:Knight]
    @moves_made = 0
    @current_board = current_board
    @x_moves = [2, 1, -1, -2, -2, -1, 1, 2]
    @y_moves = [1, 2, 2, 1, -1, -2, -2, -1]
    @king_in_check = false
  end

  def knight_move_possible?(curr)
    on_board?(curr) && !taken_by_same_color_piece(curr) && !taken_by_opposite_king?(curr)
  end

  def generate_moves(pos)
    moves = []

    8.times do |index|
      curr = [pos[0] + @x_moves[index], pos[1] + @y_moves[index]]
      moves.push([pos, curr]) if knight_move_possible?(curr)
    end
    moves
  end
end
