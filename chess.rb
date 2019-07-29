require 'yaml'
require_relative 'board.rb'
require_relative 'piece_hash.rb'
require_relative 'helpers.rb'
require_relative 'check.rb'
require_relative './pieces/piece.rb'
require_relative './pieces/bishop.rb'
require_relative './pieces/pawn.rb'
require_relative './pieces/rook.rb'
require_relative './pieces/queen.rb'
require_relative './pieces/king.rb'
require_relative './pieces/knight.rb'

# Class to initialize chess, to be initialized by Play class
class Chess
  attr_accessor :player_color, :computer_color, :board, :turn
  def initialize
    @board = Board.new
    @player_pieces_arr = []
    @computer_pieces_arr = []
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

  def setup(x, y, color)
    case
    when [0, 7].include?(x) then Rook.new([x, y], color, @board)
    when [1, 6].include?(x) then Knight.new([x, y], color, @board)
    when [2, 5].include?(x) then Bishop.new([x, y], color, @board)
    when x == 3 then Queen.new([x, y], color, @board)
    when x == 4 then King.new([x, y], color, @board)
    end
  end

  def arrange_board(bottom_color = @player_color, top_color = @computer_color)
    for x in 0..7
      for y in 0..1
        y == 1 ? new_piece = Pawn.new([x, y], bottom_color, @board, top_color, bottom_color) : new_piece = setup(x, y, bottom_color)
        @board.change(x, y, new_piece)
        @player_pieces_arr.push(new_piece)
      end
    end

    for x in 0..7
      for y in 6..7
        y == 6 ? new_piece = Pawn.new([x, y], top_color, @board, top_color, bottom_color) : new_piece = setup(x, y, top_color)
        @board.change(x, y, new_piece)
        @computer_pieces_arr.push(new_piece)
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
      @board.piece_at(@converted[0][0], @converted[0][1]).generate_moves(@converted[0]).include?(@converted)
  end

  def opposite_piece_arr
    @turn == 'player' ? @computer_pieces_arr : @player_pieces_arr
  end

  def same_piece_arr
    @turn == 'player' ? @player_pieces_arr : @computer_pieces_arr
  end

  def check?
    Check.new(@board, opposite_piece_arr, Helpers.find_king(same_piece_arr))
    #Check.new(@board, same_piece_arr, Helpers.find_king(opposite_piece_arr))
  end

  def play_game
    loop do
      ask_for_input
      check?
      @board.piece_at(@converted[0][0], @converted[0][1]).moves_made += 1
      @board.move(@converted[0], @converted[1])
      @board.piece_at(@converted[1][0], @converted[1][1]).pos = @converted[1]
      @board.display_board
      switch_turn
    end
  end
end