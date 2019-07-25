# Class to create, modify, and display the chessboard
class Board
  attr_accessor :squares

  def initialize
    @squares = Array.new(8) { Array.new(8, ' ') }
    @vertical = [8, 7, 6, 5, 4, 3, 2, 1]
    @horizontal =  '    a   b   c   d   e   f   g   h'
    @row_separator = '    +---+---+---+---+---+---+---+---+'
  end

  def change(x_coord, y_coord, char)
    y_coord = 7 - ((y_coord + 8) % 8)
    @squares[y_coord][x_coord] = char
  end

  def piece_at(x_coord, y_coord)
    y_coord = 7 - ((y_coord + 8) % 8)
    @squares[y_coord][x_coord]
  end

  def move(curr_location, destination)
    piece = piece_at(curr_location[0], curr_location[1])
    change(curr_location[0], curr_location[1], ' ')
    change(destination[0], destination[1], piece)
  end

  def display_board
    @squares.each_with_index do |row, index|
      puts @row_separator
      puts " #{@vertical[index]}  #{print_row(row)}|"
    end
    puts @row_separator
    puts "  #{@horizontal}"
  end

  private

  def print_row(row_arr)
    str = ''
    row_arr.each do |square|
      str += "| #{square} "
    end
    str
  end
end
