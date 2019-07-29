require File.expand_path('./piece_hash.rb')
require File.expand_path('./helpers.rb')
require File.expand_path('./board.rb')
require File.expand_path('./check.rb')

# General class for Pieces
class Piece

  def str_or_class(square)
    square.is_a?(String) ? square : square.piece
  end

  def on_board?(pos)
    pos[0].between?(0, 7) && pos[1].between?(0, 7)
  end

  def taken_by_another_piece?(pos)
    return true if @current_board.piece_at(pos[0], pos[1]) != ' '
  end

  def taken_by_opposite_color_piece?(pos)
    piece_at_pos = @current_board.piece_at(pos[0], pos[1])
    opposite = Helpers.opposite_color(@color)
    Helpers.corresponding_hash(opposite).has_value?(str_or_class(piece_at_pos))
  end

  def taken_by_same_color_piece(pos)
    piece_at_pos = @current_board.piece_at(pos[0], pos[1])
    Helpers.corresponding_hash(@color).has_value?(str_or_class(piece_at_pos))
  end

  def taken_by_opposite_king?(pos)
    piece_at_pos = @current_board.piece_at(pos[0], pos[1])
    opposite = Helpers.opposite_color(@color)
    str_or_class(piece_at_pos) == Helpers.corresponding_hash(opposite)[:King]
  end

  def forward_line_moves(pos)
    moves = [] # max of 7
    curr = [pos[0], pos[1] + 1]
    until stop_condition(curr)
      moves.push([pos, curr])
      curr = [curr[0], curr[1] + 1]
    end
    moves.push([pos, curr]) if eat_piece_possible?(curr)
    moves
  end

  def backward_line_moves(pos)
    moves = [] # max of 7
    curr = [pos[0], pos[1] - 1]
    until stop_condition(curr)
      moves.push([pos, curr])
      curr = [curr[0], curr[1] - 1] 
    end
    moves.push([pos, curr]) if eat_piece_possible?(curr)
    moves
  end

  def right_line_moves(pos)
    moves = [] # max of 7
    curr = [pos[0] + 1, pos[1]]
    until stop_condition(curr)
      moves.push([pos, curr])
      curr = [curr[0] + 1, curr[1]]
    end
    moves.push([pos, curr]) if eat_piece_possible?(curr)
    moves
  end

  def left_line_moves(pos)
    moves = [] # max of 7
    curr = [pos[0] - 1, pos[1]]
    until stop_condition(curr)
      moves.push([pos, curr])
      curr = [curr[0] - 1, curr[1]]
    end
    moves.push([pos, curr]) if eat_piece_possible?(curr)
    moves
  end

  def up_right_diagonal_moves(pos)
    moves = [] # max of 7
    curr = [pos[0] + 1, pos[1] + 1]
    until stop_condition(curr)
      moves.push([pos, curr])
      curr = [curr[0] + 1, curr[1] + 1]
    end
    moves.push([pos, curr]) if eat_piece_possible?(curr)
    moves
  end

  def up_left_diagonal_moves(pos)
    moves = [] # max of 7
    curr = [pos[0] - 1, pos[1] + 1]
    until stop_condition(curr)
      moves.push([pos, curr])
      curr = [curr[0] - 1, curr[1] + 1]
    end
    moves.push([pos, curr]) if eat_piece_possible?(curr)
    moves
  end

  def down_left_diagonal_moves(pos)
    moves = [] # max of 7
    curr = [pos[0] - 1, pos[1] - 1]
    until stop_condition(curr)
      moves.push([pos, curr])
      curr = [curr[0] - 1, curr[1] - 1]
    end
    moves.push([pos, curr]) if eat_piece_possible?(curr)
    moves
  end

  def down_right_diagonal_moves(pos)
    moves = [] # max of 7
    curr = [pos[0] + 1, pos[1] - 1]
    until stop_condition(curr)
      moves.push([pos, curr])
      curr = [curr[0] + 1, curr[1] - 1]
    end
    moves.push([pos, curr]) if eat_piece_possible?(curr)
    moves
  end

  def in_check?(opposite_pieces, king)
    Check.new(@current_board, opposite_pieces, king, @color)
  end

  def stop_condition(curr)
    !on_board?(curr) || taken_by_another_piece?(curr)
  end

  def eat_piece_possible?(curr)
    on_board?(curr) && taken_by_opposite_color_piece?(curr)
  end
end