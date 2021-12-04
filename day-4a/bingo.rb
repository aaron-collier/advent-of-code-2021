# frozen_string_literal: true

# Navigator class to calculate day 2b position:
# Correct: 50008
class Bingo
  attr_reader :winning_score

  def initialize(boards_file)
    @boards_file = boards_file
    @boards = []
    @winning_score = 0
  end

  def load_boards
    File.readlines(File.expand_path(@boards_file, __dir__), chomp: true)
                       .delete_if(&:empty?)
                       .each_slice(5)
                       .map { |board| @boards << board.map(&:split) }
  end

  def mark_number(number)
    @boards.each_with_index do |board, board_index|
      board.each_with_index do |row, row_index|
        row.each_with_index do |column, column_index|
          next unless column == number

          @boards[board_index][row_index][column_index] = '*'
          next unless winning_board?(board, row_index, column_index)

          total = 0
          board.each do |data_row|
            total += data_row.map(&:to_i).sum
          end
          puts("Winning Score: #{total * number.to_i}")
          return total
        end
      end
    end
  end

  def winning_board?(board, row, column)
    return true if board[row].join == '*****'
    return true if board.transpose[column].join == '*****'

    false
  end
end

bingo = Bingo.new('boards.txt')
bingo.load_boards
i = 0
File.foreach(File.expand_path('input.txt', __dir__), chomp: true) do |line|
  line.split(',').each do |number|
    puts "Number drawn: #{number}"
    bingo.mark_number(number)
    i += 1
    continue if bingo.winning_score.positive?
  end
  puts "Score: #{bingo.winning_score}"
  next
end
p(i)

# bingo.boards.each do |board|
#   p(board)
# end
