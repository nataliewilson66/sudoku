require_relative 'tile'

class Board

  def self.empty_grid
    grid = Array.new(9) { Array.new(9, Tile.new(0)) }
  end

  def self.from_file(file_name)
    rows = File.readlines(file_name).map(&:chomp)
    tiles = rows.map do |row|
      nums = row.split("").map { |char| char.to_i }
      nums.map { |val| Tile.new(val) }
    end
    self.new(tiles)
  end

  def initialize(grid = Board.empty_grid)
    @grid = grid
  end

  def update_value(position, value)
    row, col = position
    @grid[row][col].value = value
  end

  def render_tile(row, col)
    print "#{@grid[row][col].to_s} "
  end

  def render_row(row)
    (0...9).each do |col|
      print "\b|" if col == 3 || col == 6
      render_tile(row, col)
    end
    puts
  end

  def render
    (0...9).each do |row|
      if row == 3 || row == 6
        17.times { print "-" }
        puts
      end
      render_row(row)
    end
    nil
  end

  def row_solved?(row)
    value_count = Hash.new(0)
    (0...9).each do |col|
      tile_value = @grid[row][col].value
      return false if tile_value == 0
      value_count[tile_value] += 1
    end
    value_count.each_value { |count| return false if count > 1 }
    true
  end

  def col_solved?(col)
    value_count = Hash.new(0)
    (0...9).each do |row|
      tile_value = @grid[row][col].value
      return false if tile_value == 0
      value_count[tile_value] += 1
    end
    value_count.each_value { |count| return false if count > 1 }
    true
  end

  def square_solved?(square)
    value_count = Hash.new(0)
    i = 0 if square >= 0 && square < 3
    i = 3 if square >= 3 && square < 6
    i = 6 if square >= 6 && square < 9
    j = (square % 3) * 3
    (i...i + 3).each do |row|
      (j...j + 3).each do |col|
        tile_value = @grid[row][col].value
        return false if tile_value == 0
        value_count[tile_value] += 1
      end
    end
    value_count.each_value { |count| return false if count > 1 }
  end

  def solved?
    (0...9).each do |num|
      return false if !(row_solved?(num) && col_solved?(num) && square_solved?(num))
    end
    true
  end

end