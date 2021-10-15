require_relative "board.rb"
require "pry-byebug"

class ConnectFour
  attr_reader :rows, :cols, :player_turn_index, :board, :player_strings, :column_full_msg
  E = " "
  R = "R"
  Y = "Y"


  def initialize(piece_placements = [], start_player_index = 0)
    @player_turn_index = start_player_index
    @player_strings = [R,Y]
    @player_name_strings = ["Red", "Yellow"]
    @column_full_msg = "column full"
    @rows = 6
    @cols = 7
    @board = Board.new(@rows, @cols)
    unless piece_placements.empty?
      place_pieces(piece_placements)
    end
  end

  def play
    winning_arrangement = []
    until has_winner?(winning_arrangement)
      display_turn_info
      @board.display_board
      player_turn
    end
    @board.display_board
    show_winner(winning_arrangement)
  end

  def player_turn
    input = player_input
    handle_input(input)
  end

  def player_input
    puts
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

  def has_winner?(winning_arrangement = [])
    return winner_horizontal?(winning_arrangement) || 
          winner_vertical?(winning_arrangement) || 
          winner_diagonal?(winning_arrangement) ||
          @board.board_full?
  end

  private

  def display_turn_info
    puts
    puts "#{@player_name_strings[@player_turn_index]}'s Turn"
  end

  def winner_from_string(winning_arrangement_string)
    return nil unless winning_arrangement_string

    if winning_arrangement_string.include?(R * 4)
      "Red"
    elsif winning_arrangement_string.include?(Y * 4)
      "Yellow"
    end
  end

  def show_winner(winning_arrangement_size_one_arr)
    winner = winner_from_string(winning_arrangement_size_one_arr[0])
    if winner
      puts "#{winner} Wins!"
    else
      puts "It's a Draw!"
    end
  end

  def curr_piece
    @player_strings[@player_turn_index]
  end

  def valid_input?(input)
    return valid_digit?(input) && !@board.column_full?(input.to_i - 1)
  end

  def valid_digit?(char)
    digit?(char) && char.to_i.between?(1, @cols)
  end

  def digit?(char)
    char.is_a?(String) && char.length == 1 && char >= "0" && char <= "9"
  end

  def winner_horizontal?(winning_arrangement = [])
    @board.grid.each_index do |row_index|
      row_string = @board.row_to_string(row_index)
      if string_has_four_in_a_row?(row_string)
        winning_arrangement.push(row_string)
        return true 
      end
    end
    false
  end

  def winner_vertical?(winning_arrangement = [])
    for col_index in 0...@cols do
      col_string = @board.col_to_string(col_index)
      if string_has_four_in_a_row?(col_string)
        winning_arrangement.push(col_string)
        return true 
      end
    end
    false
  end

  def winner_diagonal?(winning_arrangement = [])
    winner_diagonal_up?(winning_arrangement) || 
    winner_diagonal_down?(winning_arrangement)
  end

  def winner_diagonal_up?(winning_arrangement = [])
    #go down the left column from the first diagonal that could have a winner
    for row_index in 3...@rows do
      diag_string = @board.diagonal_up_to_string(row_index, 0)
      if string_has_four_in_a_row?(diag_string)
        winning_arrangement.push(diag_string)
        return true 
      end
    end

    #go across the bottom row to the last diagonal that could have a winner
    for col_index in 1..@cols-4 do
      diag_string = @board.diagonal_up_to_string(@rows-1, col_index)
      if string_has_four_in_a_row?(diag_string)
        winning_arrangement.push(diag_string)
        return true 
      end
    end
    false
  end

  def winner_diagonal_down?(winning_arrangement = [])
    #go up the left column from the first diagonal that could have a winner
    for row_index in (@rows-4).downto(0) do
      diag_string = @board.diagonal_down_to_string(row_index, 0)
      if string_has_four_in_a_row?(diag_string)
        winning_arrangement.push(diag_string)
        return true 
      end
    end

    #go across the top row to the last diagonal that could have a winner
    for col_index in 1..@cols-4 do
      diag_string = @board.diagonal_down_to_string(0, col_index)
      if string_has_four_in_a_row?(diag_string)
        winning_arrangement.push(diag_string)
        return true 
      end
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
      if !@board.column_full?(col_index)
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