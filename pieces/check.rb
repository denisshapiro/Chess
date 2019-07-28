# Detect if a King is in check
class Check
  def initialize(board, opposite_pieces, king, color)
    @board = board
    @opposite_pieces = opposite_pieces
    @king = king
    @color = color
  end

  def generate_opposite_pieces_moves
    @moves = []
    @opposite_pieces.each do |piece|
      @moves += piece.generate_moves(piece.pos)
    end
  end

  def analyze_opposite_moves
    king_pos = @king.pos

    @moves.each do |pos|
      return true if pos[1] == king_pos
    end
    false
  end
end
