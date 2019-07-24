require_relative 'piece_hash.rb'

# Some useful helper functions
module Helpers
  include ChessPieces

  def self.valid_color_input(input)
    %w[white w black b random r].include? input
  end

  def self.random_color
    %w[BLACK WHITE].sample
  end

  def self.corresponding_hash(color)
    return WHITE_PIECES if color == 'WHITE'
    return BLACK_PIECES if color == 'BLACK'
  end
end