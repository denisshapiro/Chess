require_relative 'board.rb'
require_relative 'piece_hash.rb'
require_relative 'helpers.rb'

# Class to initialize chess, to be initialized by Play class
class Chess
  attr_accessor :player_color, :computer_color, :board
  def initialize
    @board = Board.new
    choose_color
    set_player_color
    arrange_board
  end

  def choose_color
    loop do
      puts 'Do you want to play as black, white or random?'
      @player_color = gets.chomp.downcase
      break if Helpers.valid_color_input(@player_color)
    end
  end

  def set_player_color
    case @player_color[0]
    when 'b'
      @player_color = 'BLACK'
      @computer_color = 'WHITE'
    when 'w'
      @player_color = 'WHITE'
      @computer_color = 'BLACK'
    when 'r'
      @player_color = Helpers.random_color
      @player_color == 'WHITE' ? @computer_color = 'BLACK' : @computer_color = 'WHITE'
    end
  end

  def setup_main(hash, x)
    case
    when x == 0 || x == 7 then return hash[:Rook]
    when x == 1 || x == 6 then return hash[:Knight]
    when x == 2 || x == 5 then return hash[:Bishop]
    when x == 3 then return hash[:Queen]
    when x == 4 then return hash[:King]
    end
  end

  def arrange_board(bottom_color = @player_color, top_color = @computer_color)
    top_hash = Helpers.corresponding_hash(top_color)
    bottom_hash = Helpers.corresponding_hash(bottom_color)
    for x in 0..7
      for y in 0..1
         y == 1 ? @board.change(x, y, bottom_hash[:Pawn]) : @board.change(x, y, setup_main(bottom_hash, x))
      end
    end

    for x in 0..7
      for y in 6..7
        y == 6 ? @board.change(x, y, top_hash[:Pawn]) : @board.change(x, y, setup_main(top_hash, x))
      end
    end
    @board.display_board
  end
end

c = Chess.new
