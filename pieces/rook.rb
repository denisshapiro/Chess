require_relative 'piece.rb'
require File.expand_path('./helpers.rb')

# Class to describe a Rook's available moves in current possiton
class Rook < Piece
  attr_accessor :possible_moves, :piece, :moves_made

  def initialize(pos, color, current_board)
    @pos = pos
    @color = color
    @piece = Helpers.corresponding_hash(@color)[:Rook]
    @moves_made = 0
    @current_board = current_board
  end

  def generate_moves(pos)
    possible_moves = []
    possible_moves += forward_line_moves(pos)
    possible_moves += backward_line_moves(pos)
    possible_moves += right_line_moves(pos)
    possible_moves += left_line_moves(pos)
    p possible_moves
    possible_moves
  end
end