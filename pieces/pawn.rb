require_relative 'piece.rb'

# Class to describe a Pawn's available moves in current possiton
class Pawn < Piece
  attr_accessor :possible_moves

  def initialize(pos, color, current_board, top_color, bottom_color)
    @pos = pos
    @color = color
    @top_color = top_color
    @bottom_color = bottom_color
    @current_board = current_board
    @possible_moves = []
    generate_moves
    p @possible_moves
  end

  def forward_player_piece
    moves = []
    forward = [@pos[0], @pos[1] + 1]
    moves.push(forward) unless taken_by_another_piece?(forward)
    moves
  end

  def up_right_player_piece
    moves = []
    up = [@pos[0] + 1, @pos[1] + 1]
    moves += up if taken_by_opposite_color_piece?(@current_board, @color, up) &&
                             !taken_by_opposite_king?(@color, up)
    moves
  end

  def up_left_player_piece
    moves = []
    down = [@pos[0] - 1, @pos[1] + 1]
    moves += down if taken_by_opposite_color_piece?(@current_board, @color, down) &&
                               !taken_by_opposite_king?(@color, down)
    moves
  end

  def forward_computer_piece
    moves = []
    forward = [@pos[0], @pos[1] - 1]
    moves.push(forward) unless taken_by_another_piece?(forward)
    moves
  end

  def up_right_computer_piece
    moves = []
    up = [@pos[0] - 1, @pos[1] - 1]
    moves.push(up) if taken_by_opposite_color_piece?(@current_board, @color, up) &&
                             !taken_by_opposite_king?(@color, up)
    moves
  end

  def up_left_computer_piece
    moves = []
    down = [@pos[0] + 1, @pos[1] - 1]
    moves.push(down) if taken_by_opposite_color_piece?(@current_board, @color, down) &&
                               !taken_by_opposite_king?(@color, down)
    moves
  end

  def generate_moves
    if @color == @bottom_color
      @possible_moves += forward_player_piece
      @possible_moves += up_right_player_piece
      @possible_moves += up_left_player_piece
    else
      @possible_moves += forward_computer_piece
      @possible_moves += up_right_computer_piece
      @possible_moves += up_left_computer_piece
    end
  end
end
