require 'colorize'
# Hashes to contain unicode chess symbols 
module ChessPieces
  WHITE_PIECES = {
    Rook: '♖',
    Knight: '♘',
    Bishop: '♗',
    Queen: '♕',
    King: '♔',
    Pawn: '♙'
  }.freeze

  BLACK_PIECES = {
    Rook: '♜',
    Knight: '♞',
    Bishop: '♝',
    Queen: '♛',
    King: '♚',
    Pawn: '♟'
  }.freeze
end
