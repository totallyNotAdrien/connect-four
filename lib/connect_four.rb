
class ConnectFour
  attr_reader :rows, :cols, :player_turn_index, :board, :player_strings
  E = " "
  R = "R"
  Y = "Y"


  def initialize(piece_placements = [])
    @player_turn_index = 0
    @player_strings = [R,Y]
    @rows = 6
    @cols = 7
    @board = Array.new(@rows){Array.new(@cols, E)}
    unless piece_placements.empty?
      place_pieces(piece_placements)
    end
  end

  def has_winner?
    return winner_horizontal?
  end

  private

  def winner_horizontal?
    @board.each_index do |row_index|
      row_string = row_to_string(row_index)
      return true if string_has_four_in_a_row?(row_string)
    end
    false
  end

  def string_has_four_in_a_row?(str)
    str.include?(Y * 4) || str.include?(R * 4)
  end

  def row_to_string(row_index)
    @board[row_index].join("")
  end

  def place_pieces(piece_placements, start_player_index = 0) #1-based placements
    @player_turn_index = start_player_index
    piece_placements.each do |col|
      col_index = col - 1
      row_index = bottommost_empty_row_index_in_col(col_index)
      @board[row_index][col_index] = player_strings[@player_turn_index]
      switch_player
    end
  end

  def switch_player
    @player_turn_index  = (@player_turn_index + 1) % 2
  end

  def bottommost_empty_row_index_in_col(column_index)
    row_index = @rows - 1
    until row_index < 0
      return row_index if @board[row_index][column_index] == E
      row_index -= 1
    end
    nil
  end
end