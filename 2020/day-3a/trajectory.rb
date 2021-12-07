# Test Input
#    1-3 a: abcde
#    1-3 b: cdefg
#    2-9 c: ccccccccc

class TobogganTrajectory
  def initialize()
    @rows = []
    # @trees_encountered = 0
  end

  def register_row(row)
    @rows << row.split('')
  end

  def score(right, down)
    x = 0
    row = 0
    trees_encountered = 0
    width = @rows.first.size
    height = @rows.size
    # height.times do |row| # @rows.each_with_index do |row, i|
    while row <= height
      x += right
      x = x - width if x >= width
      row += down
      break if row >= height
      # p "#{row},#{x} => #{@rows[row][x]}"
      trees_encountered += 1 if @rows[row][x] == '#'
    end      
    p "Trees encountered => #{trees_encountered}"
    trees_encountered
  end

  def aggregate_score(slopes)
    scores = []
    slopes.each do |slope|
      scores << score(slope[0], slope[1])
    end
    p "total trees encountered = #{scores.inject(:*)}"
  end
end

toboggan_trajectory = TobogganTrajectory.new

File.foreach('input.txt', chomp: true) { |row|
  toboggan_trajectory.register_row(row)
}

toboggan_trajectory.aggregate_score([[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]])