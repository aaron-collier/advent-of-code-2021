# frozen_string_literal: true

# Bingo:
# Correct: 17408
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
    if @boards.length == 1
      if @boards.first.any? { |val| val.include?(number) }
        puts "Number called: #{number}"
        print_board(@boards.first)
        # p @boards.first.map { |row| row.map(&:to_i).sum }.sum
        puts "Sum: #{(@boards.first.map { |row| row.map(&:to_i).sum }.sum - number.to_i)}"
        p((@boards.first.map { |row| row.map(&:to_i).sum }.sum - number.to_i) * number.to_i)
        return
      end
    end

    @current_boards = @boards.dup
    @boards.each_with_index do |board, board_index|
      board.each_with_index do |row, row_index|
        row.each_with_index do |column, column_index|
          next unless column == number

          @boards[board_index][row_index][column_index] = '*'
          next unless winning_board?(board)

          @current_boards.delete_at(board_index)
        end
      end
    end
    @boards = @current_boards
  end

  def winning_board?(board)
    return true if board.map(&:join).include?('*****')
    return true if board.transpose.map(&:join).include?('*****')

    false
  end

  def print_board(board)
    board.each do |row|
      puts "#{row.map { |s| s.rjust(2, ' ') }.join(' ')}"
    end
  end

  def boards
    p(@boards)
  end
end

bingo = Bingo.new('boards.txt')
bingo.load_boards

File.foreach(File.expand_path('input.txt', __dir__), chomp: true) do |line|
  line.split(',').each do |number|
    break unless bingo.mark_number(number)
  end
end
