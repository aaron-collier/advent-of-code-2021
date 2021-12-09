# Test Input
# 2199943210
# 3987894921
# 9856789892
# 8767896789
# 9899965678
# Real input correct answer = 575
class SmokeBasin
  def initialize
    @heat_map = []
    @basin = Hash.new(0)
  end

  def register_path(path)
    @heat_map << path.split('').map(&:to_i)
  end

  def score
    @heat_map.each_with_index do |row, x_start|
      row.each_with_index do |point, y_start|
        next if point == 9

        next_point = [x_start, y_start]
        while next_point
          x, y = next_point
          next_point = [[1, 0], [0, 1], [-1, 0], [0, -1]]
            .map{ |dx, dy| [x+dx, y+dy] }
            .filter{|nx, ny| nx.between?(0, @heat_map.size-1) && ny.between?(0, @heat_map[0].size-1)}
            .filter{|nx, ny| @heat_map[nx][ny] < @heat_map[x][y]}
            .first
        end

        @basin[[x, y]] += 1
      end
    end

    puts "Part 1: #{@basin.keys.map{|x, y| @heat_map[x][y] + 1}.sum}"
    puts "Part 2: #{@basin.values.sort[-3..].reduce(:*)}"
  end
end

smoke_basin = SmokeBasin.new
File.foreach('input.txt', chomp: true) { |path| 
  smoke_basin.register_path(path)
}
smoke_basin.score