require_relative 'chess.rb'

File.open('chess.txt', 'r') { |file| puts file.read }
puts "Typing 'A2A4' will move the piece at 'A2' to 'A4'"
puts 'You can save, load, or exit your game by typing:'
puts "'save', 'load', or 'exit'"
puts "You can also propose a draw by entering 'draw'."
puts "Good luck!\n\n"

Chess.new