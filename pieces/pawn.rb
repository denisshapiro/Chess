require_relative 'piece.rb'

# Class to describe a Pawn's available moves in current possiton
class Pawn < Piece
  attr_accessor :possible_moves, :piece, :moves_made, :pos

  def initialize(pos, color, current_board, top_color, bottom_color)
    @pos = pos
    @color = color
    @piece = Helpers.corresponding_hash(@color)[:Pawn]
    @moves_made = 0
    @top_color = top_color
    @bottom_color = bottom_color
    @current_board = current_board
  end

  def pawn_can_eat?(pos)
    on_board?(pos) &&
      taken_by_opposite_color_piece?(pos) &&
      !taken_by_opposite_king?(pos)
  end

  def first_move_player(pos)
    moves = []
    if @moves_made.zero? && !forward_player_piece(pos).length.zero?
      double_forward = [pos[0], pos[1] + 2]
      moves.push([pos, double_forward]) unless stop_condition(double_forward)
    end
    moves
  end

  def forward_player_piece(pos)
    moves = []
    forward = [pos[0], pos[1] + 1]
    moves.push([pos, forward]) unless stop_condition(forward)
    moves
  end

  def up_right_player_piece(pos)
    moves = []
    up = [pos[0] + 1, pos[1] + 1]
    moves.push([pos, up]) if pawn_can_eat?(up)
    moves
  end

  def up_left_player_piece(pos)
    moves = []
    down = [pos[0] - 1, pos[1] + 1]
    moves.push([pos, down]) if pawn_can_eat?(down)
    moves
  end

  def first_move_computer(pos)
    moves = []
    if @moves_made.zero? && !forward_computer_piece(pos).length.zero?
      double_forward = [pos[0], pos[1] - 2]
      moves.push([pos, double_forward]) unless stop_condition(double_forward)
    end
    moves
  end

  def forward_computer_piece(pos)
    moves = []
    forward = [pos[0], pos[1] - 1]
    moves.push([pos, forward]) unless stop_condition(forward)
    moves
  end

  def up_right_computer_piece(pos)
    moves = []
    up = [pos[0] - 1, pos[1] - 1]
    moves.push([pos, up]) if pawn_can_eat?(up)
    moves
  end

  def up_left_computer_piece(pos)
    moves = []
    down = [pos[0] + 1, pos[1] - 1]
    moves.push([pos, down]) if pawn_can_eat?(down)
    moves
  end

  def generate_moves(pos)
    possible_moves = []
    if @color == @bottom_color
      possible_moves += first_move_player(pos)
      possible_moves += forward_player_piece(pos)
      possible_moves += up_right_player_piece(pos)
      possible_moves += up_left_player_piece(pos)
    else
      possible_moves += first_move_computer(pos)
      possible_moves += forward_computer_piece(pos)
      possible_moves += up_right_computer_piece(pos)
      possible_moves += up_left_computer_piece(pos)
    end
    possible_moves
  end
end
