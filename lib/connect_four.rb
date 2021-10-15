require_relative "board.rb"

class ConnectFour
  attr_reader :rows, :cols, :player_turn_index, :board, :player_strings, :column_full_msg
  E = " "
  R = "R"
  Y = "Y"


  def initialize(piece_placements = [], start_player_index = 0)
    @player_turn_index = start_player_index
    @player_strings = [R,Y]
    @column_full_msg = "column full"
    @rows = 6
    @cols = 7
    @board = Board.new(@rows, @cols)
    unless piece_placements.empty?
      place_pieces(piece_placements)
    end
  end

  def play
    until has_winner?
      display_turn_info
      board.display_board
      player_turn
    end
    board.display_board
  end

  def player_turn
    input = player_input
    handle_input(input)
  end

  def player_input
    print "Enter the number of the column where you want to place your piece (1-7): "
    gets.chomp.strip
  end

  def handle_input(input)
    if valid_input?(input)
      col_index = input.to_i - 1
      @board.place_piece(col_index, curr_piece)
      switch_player
    elsif !valid_digit?(input)
      puts "invalid input"
    else
      puts @column_full_msg
    end
  end

  def has_winner?
    return winner_horizontal? || winner_vertical? || winner_diagonal?
  end

  private

  def display_turn_info

  end

  def curr_piece
    @player_strings[@player_turn_index]
  end

  def valid_input?(input)
    return valid_digit?(input) && !@board.column_full(input.to_i - 1)
  end

  def valid_digit?(char)
    digit?(char) && char.to_i.between?(1, @rows)
  end

  def digit?(char)
    char.is_a?(String) && char.length == 1 && char >= "0" && char <= "9"
  end

  def winner_horizontal?
    @board.grid.each_index do |row_index|
      row_string = @board.row_to_string(row_index)
      return true if string_has_four_in_a_row?(row_string)
    end
    false
  end

  def winner_vertical?
    for col_index in 0...@cols do
      col_string = @board.col_to_string(col_index)
      return true if string_has_four_in_a_row?(col_string)
    end
    false
  end

  def winner_diagonal?
    winner_diagonal_up? || winner_diagonal_down?
  end

  def winner_diagonal_up?
    #go down the left column from the first diagonal that could have a winner
    for row_index in 3...@rows do
      diag_string = @board.diagonal_up_to_string(row_index, 0)
      return true if string_has_four_in_a_row?(diag_string)
    end

    #go across the bottom row to the last diagonal that could have a winner
    for col_index in 1..@cols-4 do
      diag_string = @board.diagonal_up_to_string(@rows-1, col_index)
      return true if string_has_four_in_a_row?(diag_string)
    end
    false
  end

  def winner_diagonal_down?
    #go up the left column from the first diagonal that could have a winner
    for row_index in (@rows-4).downto(0) do
      diag_string = @board.diagonal_down_to_string(row_index, 0)
      return true if string_has_four_in_a_row?(diag_string)
    end

    #go across the top row to the last diagonal that could have a winner
    for col_index in 1..@cols-4 do
      diag_string = @board.diagonal_down_to_string(0, col_index)
      return true if string_has_four_in_a_row?(diag_string)
    end
    false
  end

  def string_has_four_in_a_row?(str)
    str.include?(Y * 4) || str.include?(R * 4)
  end

  def place_pieces(piece_placements, start_player_index = 0) #1-based placements
    @player_turn_index = start_player_index
    piece_placements.each do |col|
      col_index = col - 1
      if !@board.column_full(col_index)
        @board.place_piece(col_index, @player_strings[@player_turn_index])
      else
        puts @column_full_msg
        return
      end
      switch_player
    end
  end

  def switch_player
    @player_turn_index  = (@player_turn_index + 1) % 2
  end
end