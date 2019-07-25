require 'yaml'
require_relative 'board.rb'
require_relative 'piece_hash.rb'
require_relative 'helpers.rb'
require_relative './pieces/piece.rb'
require_relative './pieces/bishop.rb'
require_relative './pieces/pawn.rb'

# Class to initialize chess, to be initialized by Play class
class Chess
  attr_accessor :player_color, :computer_color, :board, :turn
  def initialize
    @board = Board.new
    choose_color
    set_player_color
    arrange_board
    @turn = Helpers.init_turn(@player_color)
    play_game
  end

  def save_game
    game_data = {
      board: @board,
      player_color: @player_color,
      computer_color: @computer_color,
      turn: @turn
    }

    Dir.mkdir('saves') unless Dir.exist? 'saves'

    puts 'WARNING! If the filename already exist the data on that file will be overwritten!'
    print 'Enter a filename for your save: '
    filename = gets.chomp

    File.open("saves/#{filename}.yaml", 'w') do |file|
      file.puts game_data.to_yaml
    end

    puts 'Your progress has been saved!'
  end

  def load_game
    filename = nil
    loop do
      print 'Please enter an existing filename: '
      filename = gets.chomp
      break if File.exist? "saves/#{filename}.yaml"
    end

    game_data = YAML.load_file("saves/#{filename}.yaml")

    @board = game_data[:board]
    @player_color = game_data[:player_color]
    @computer_color = game_data[:computer_color]
    @turn = game_data[:turn]
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

  def switch_turn
    @turn == 'player' ? @turn = 'computer' : @turn = 'player'
  end

  def arrange_board(bottom_color = @player_color, top_color = @computer_color)
    top_hash = Helpers.corresponding_hash(top_color)
    bottom_hash = Helpers.corresponding_hash(bottom_color)
    for x in 0..7
      for y in 0..1
        y == 1 ? @board.change(x, y, bottom_hash[:Pawn]) : @board.change(x, y, Helpers.setup(bottom_hash, x))
      end
    end

    for x in 0..7
      for y in 6..7
        y == 6 ? @board.change(x, y, top_hash[:Pawn]) : @board.change(x, y, Helpers.setup(top_hash, x))
      end
    end
    @board.display_board
  end

  def return_color
    @turn == 'computer' ? @computer_color : @player_color
  end

  def ask_for_input
    loop do
      puts 'Enter piece to move and its destination (e.g. d2 to d3)'
      @input = gets.chomp.downcase
      @converted = Helpers.convert_input_to_pos(@input)
      break if valid?
    end
  end

  def valid?
    Helpers.valid_pos_and_dest(@input) &&
      Helpers.players_piece?(@converted[0], @board, return_color) &&
      find_type(@converted[0]).possible_moves.include?(@converted[1])
  end

  def find_type(pos, board = @board, color = return_color)
    hash = Helpers.corresponding_hash(color)
    piece = board.piece_at(pos[0], pos[1])
    if piece == hash[:Bishop]
      @piece = Bishop.new(pos, color, board)
    elsif piece == hash[:Pawn]
      @piece = Pawn.new(pos, color, board, @computer_color, @player_color)
    end
  end

  def play_game
    loop do
      ask_for_input
      @board.move(@converted[0], @converted[1])
      @board.display_board
      switch_turn
    end
  end
end

Chess.new
