require_relative 'board'

class Game

  def initialize(file_name)
    @board = Board.from_file(file_name)
  end

  def get_position
    pos = gets.chomp.split(",").map { |char| char.to_i }
    if !(pos[0] >= 0 && pos[0] < 9) || !(pos[1] >= 0 && pos[1] < 9)
      puts "Invalid position, try again: "
      self.get_position
    end
    pos
  end

  def get_value
    value = gets.chomp.to_i
    if !(value > 0 && value < 10)
      puts "Invalid value, try again: "
      self.get_value
    end
    value
  end

  def prompt
    puts "Enter a position (e.g. 2,3)"
    pos = self.get_position
    puts "Enter a value (1 thru 9) to place at the position"
    value = self.get_value
    input = [pos, value]
  end

  def play
    until @board.solved?
      @board.render
      pos, value = self.prompt
      @board.update_value(pos, value)
    end
    puts "Solved! You win!"
  end

end

puzzle_1 = "puzzles/sudoku1.txt"
puzzle_2 = "puzzles/sudoku2.txt"
puzzle_3 = "puzzles/sudoku3.txt"

my_game = Game.new(puzzle_1)
my_game.play