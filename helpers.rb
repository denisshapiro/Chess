require_relative 'piece_hash.rb'
require_relative './pieces/piece.rb'
require_relative './pieces/bishop.rb'

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

  def self.opposite_color(color)
    color == 'WHITE' ? 'BLACK' : 'WHITE'
  end

  def self.init_turn(player_color)
    player_color == 'WHITE' ? 'player' : 'computer'
  end

  def self.valid_pos_and_dest(str)
    str.match?(/^[a-h][1-8].*[a-h][1-8]$/)
  end

  def self.convert_letter_to_number(letter)
    (letter.ord - 97) % 8
  end

  def self.convert_input_to_pos(str)
    [[convert_letter_to_number(str[0]), str[1].to_i - 1],
     [convert_letter_to_number(str[-2]), str[-1].to_i - 1]]
  end

  def self.players_piece?(pos, board, color)
    hash = corresponding_hash(color)
    if hash.has_value?(board.piece_at(pos[0], pos[1]).piece)
      true
    else
      puts "You can't move that piece!"
      false
    end
  end
end
