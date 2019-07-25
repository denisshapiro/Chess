require 'piece_hash.rb'
require 'helpers.rb'

# General class for Pieces
class Piece
  def initialize(pos, destination, color, current_board)
    @pos = pos
    @color = color
    @current_board = current_board
    @destination = destination
  end

  def on_board?(pos)
    pos[0].between?(0, 7) && pos[1].between?(0, 7)
  end

  def taken_by_another_piece?(board = @current_board, pos)
    return true unless board.piece_at(pos[0], pos[1]) != ' '
  end

  def taken_by_opposite_color_piece?(board = @current_board, color = @color, pos)
    piece_at_pos = board.piece_at(pos[0], pos[1])
    opposite = Helpers.opposite_color(color)
    Helpers.corresponding_hash(opposite).has_value?(piece_at_pos)
  end

  def taken_by_same_color_piece(board = @current_board, color = @color, pos)
    piece_at_pos = board.piece_at(pos[0], pos[1])
    Helpers.corresponding_hash(color).has_value?(piece_at_pos)
  end

  def taken_by_opposite_king?(board = @current_board, color = @color, pos)
    piece_at_pos = board.piece_at(pos[0], pos[1])
    opposite = Helpers.opposite_color(color)
    piece_at_pos == Helpers.corresponding_hash(opposite)[:King]
  end

  def forward_line_moves(pos, board = @current_board, color)
    moves = [] # max of 7
    curr = [pos[0], pos[1] + 1]
    until taken_by_same_color_piece(board, color, curr) || taken_by_opposite_king?(board, color, curr) || !on_board?(curr)
      moves.push(curr)
      curr = [curr[0], curr[1] + 1] 
    end
    moves
  end

  def backward_line_moves(pos, board = @current_board, color)
    moves = [] # max of 7
    curr = [pos[0], pos[1] - 1]
    until taken_by_same_color_piece(board, color, curr) || taken_by_opposite_king?(board, color, curr) || !on_board?(curr)
      moves.push(curr)
      curr = [curr[0], curr[1] - 1] 
    end
    moves
  end

  def right_line_moves(pos, board = @current_board, color)
    moves = [] # max of 7
    curr = [pos[0] + 1, pos[1]]
    until taken_by_same_color_piece(board, color, curr) || taken_by_opposite_king?(board, color, curr) || !on_board?(curr)
      moves.push(curr)
      curr = [curr[0] + 1, curr[1]] 
    end
    moves
  end

  def left_line_moves(pos, board = @current_board, color)
    moves = [] # max of 7
    curr = [pos[0] - 1, pos[1]]
    until taken_by_same_color_piece(board, color, curr) || taken_by_opposite_king?(board, color, curr) || !on_board?(curr)
      moves.push(curr)
      curr = [curr[0] - 1, curr[1]]
    end
    moves
  end
end