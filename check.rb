# Detect if a King is in check
class Check
  def initialize(board, opposite_pieces, king)
    @board = board
    @opposite_pieces = opposite_pieces
    @king = king
    generate_opposite_pieces_moves
    analyze_opposite_moves
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
      puts 'CHECK' if pos[1] == king_pos
      return true if pos[1] == king_pos
    end
    puts 'NOT CHECK'
    false
  end
end


