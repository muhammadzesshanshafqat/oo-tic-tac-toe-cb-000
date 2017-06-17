#tic_tac_toe class
class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
  WIN_COMBINATIONS = [
    #horizontal
    [0,1,2],
    [3,4,5],
    [6,7,8],
    #vertical
    [0,3,6],
    [1,4,7],
    [2,5,8],
    #diagonal
    [0,4,8],
    [6,4,2]
  ]

  def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input = input.to_i - 1
  end

  def move(index, value = "X")
    @board[index] = value
  end

  ##position_taken? method
  def position_taken?(index)
    if @board[index] == " " || @board[index] == "" || @board[index] == nil
      return false
    elsif @board[index] != " " || @board[index] != ""
      return true
    end
  end

  def valid_move?(index)
    position_taken?(index) == false && index.between?(0,8) ? true : false
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip.to_i
    index = input_to_index(input)
    value = current_player
    if valid_move?(index)
        move(index, value)
    else
      turn
    end
    display_board
  end

  def position(location)
       @board[location.to_i]
     end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def current_player
   turn_count % 2 == 0 ? "X" : "O"
 end

 def won?
     WIN_COMBINATIONS.detect do |combo|
       position(combo[0]) == position(combo[1]) &&
       position(combo[1]) == position(combo[2]) &&
       position_taken?(combo[0])
     end
   end

 def full?
   @board.all? do |index|
     index.include?("X") || index.include?("O")
   end
 end

 def draw?
   if !won? && full?
     return true
   end
 end

 def over?
   if won? || draw? || full?
     return true
   else false
   end
 end

 def winner
      if winning_combo = won?
        @winner = position(winning_combo.first)
      end
    end

#play method. Constitutes the main game loop
def play
while !over?
  turn
end
if won?
  puts "Congratulations X!"
else
  puts "Cat's Game!"
end
end
end
