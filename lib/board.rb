class Board
  attr_reader :E, :R, :Y, :grid

  def initialize(rows, cols)
    @E = " "
    @R = "R"
    @Y = "Y"
    @rows = rows
    @cols = cols
    @grid = Array.new(@rows) { Array.new(@cols, @E) }
  end

  def place_piece(col_index, piece)
    row_index = bottommost_empty_row_index_in_col(col_index)
    @grid[row_index][col_index] = piece if row_index
  end

  def row_to_string(row_index)
    @grid[row_index].join("")
  end

  def col_to_string(col_index)
    col_string = ""
    for row_index in 0...@rows
      col_string += @grid[row_index][col_index]
    end
    col_string
  end

  #returns a string representing the diagonal from BL to TR
  #that a given grid position is a part of
  def diagonal_up_to_string(row_index, col_index)
    #move to edge
    until row_index == @rows - 1 || col_index == 0
      row_index += 1
      col_index -= 1
    end

    #form diagonal string from edge
    diagonal_string = ""
    while row_index > 0 && col_index < @cols
      diagonal_string += @grid[row_index][col_index]
      row_index -= 1
      col_index += 1
    end
    diagonal_string
  end

  def diagonal_down_to_string(row_index, col_index)
    #move to edge
    until row_index == 0 || col_index == 0
      row_index -= 1
      col_index -= 1
    end

    #form diagonal string from edge
    diagonal_string = ""
    while row_index < @rows && col_index < @cols
      diagonal_string += @grid[row_index][col_index]
      row_index += 1
      col_index += 1
    end
    diagonal_string
  end

  def column_full?(col_index)
    bottommost_empty_row_index_in_col(col_index) == nil
  end

  def board_full?
    col_indices = (0...@cols).to_a
    col_indices.all? { |col_index| column_full?(col_index) }
  end

  def bottommost_empty_row_index_in_col(column_index)
    row_index = @rows - 1
    until row_index < 0
      return row_index if @grid[row_index][column_index] == @E
      row_index -= 1
    end
    nil
  end

  def display_board
    puts
    #column numbers
    col_num_output = " "
    for col_index in 0...@cols
      col_num_output += "#{col_index + 1}   "
    end
    puts col_num_output

    output = ""
    #build output row by row
    for row_index in 0...@rows
      row_out = " #{colored_piece(grid[row_index][0])} |"
      for col_index in 1...@cols
        sym = colored_piece(grid[row_index][col_index])
        last_col = col_index == @cols - 1
        row_out += " #{sym} #{last_col ? " " : "|"}"
      end
      output += "#{row_out}\n"
      output += "#{grid_row_separator}\n" unless row_index == @rows - 1
    end

    puts output
  end

  private

  def em
    "\u2014"
  end

  def grid_row_separator
    thing = "+ #{em} "
    " #{em} #{thing * (@cols - 1)}"
  end

  def piece
    "\u25c9"
  end

  def colored_piece(sym)
    if sym == @R
      piece.red
    elsif sym == @Y
      piece.yellow
    else
      sym
    end
  end
end

class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def yellow
    colorize(33)
  end
end
