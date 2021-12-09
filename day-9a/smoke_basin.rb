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
    @low_points = []
  end
  
  def register_path(path)
    @heat_map << path.split('').map(&:to_i)
  end

  def score
    @heat_map.each_with_index do |path, y|
      # p path
      prev_y = y > 0 ? y - 1 : y
      next_y = y < @heat_map.size-1 ? y + 1 : y
      path.each_with_index do |point, x|
        prev_x = x > 0 ? x - 1 : x
        next_x = x < path.size-1 ? x + 1 : x
        if x == prev_x && y == prev_y # this is the lop left corner
          @low_points << point if point < @heat_map[y][next_x] && point < @heat_map[next_y][x]
        elsif x == next_x && y == next_y # this is the bottom right corner
          @low_points << point if point < @heat_map[prev_y][x] && point < @heat_map[y][prev_x]
        elsif y == prev_y # top row
          if x == next_x
            @low_points << point if point < @heat_map[y][prev_x] && point < @heat_map[next_y][x]
          else
            @low_points << point if point < @heat_map[y][prev_x] && point < @heat_map[y][next_x] && point < @heat_map[next_y][x]
          end
        elsif y == next_y # bottom row
          p "#{point} --> #{@heat_map[prev_y][x]}, #{@heat_map[y][prev_x]}, #{@heat_map[y][next_x]}"
          if x == prev_x
            @low_points << point if point < @heat_map[prev_y][x] && point < @heat_map[y][next_x]
          else
            @low_points << point if point < @heat_map[y][prev_x] && point < @heat_map[prev_y][x] && point < @heat_map[y][next_x]
          end
        else # somewhere in the middle 
          if x == prev_x
            @low_points << point if point < @heat_map[prev_y][x] && point < @heat_map[y][next_x] && point < @heat_map[next_y][x]
          elsif x == next_x
            @low_points << point if point < @heat_map[prev_y][x] && point < @heat_map[y][prev_x] && point < @heat_map[next_y][x]
          else
            @low_points << point if point < @heat_map[prev_y][x] && point < @heat_map[y][next_x] && point < @heat_map[y][prev_x] && point < @heat_map[next_y][x]
          end
        end
      end
    end

    p @low_points
    p @low_points.map{|point| point + 1}.sum
    p @low_points.size + @low_points.sum
  end
end

smoke_basin = SmokeBasin.new
File.foreach('input.txt', chomp: true) { |path| 
  smoke_basin.register_path(path)
}
smoke_basin.score