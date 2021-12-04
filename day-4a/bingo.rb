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
    @boards.each do |board|
      next unless board.collect.any? { |row| row.include?(number) }

      board.map! do |row|
        row.map! { |val| val == number ? '*' : val }
      end

      next unless winning_board?(board)

      puts "Winning score: #{score(board, number)}"
      return true
    end
    false
  end

  def winning_board?(board)
    return true if board.map(&:join).include?('*****')
    return true if board.transpose.map(&:join).include?('*****')

    false
  end

  def score(board, number)
    board.flatten.map(&:to_i).sum * number.to_i
  end
end

bingo = Bingo.new('boards.txt')
bingo.load_boards

File.foreach(File.expand_path('input.txt', __dir__), chomp: true) do |line|
  line.split(',').each do |number|
    break if bingo.mark_number(number)
  end
end
