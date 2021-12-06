
class HydrothermalMap
  def initialize()
    @plot_points = []
  end

  def plot_vent(vent_line)
    @plot_points << vent_line.split(' -> ').map{ |val| val.split(',').map(&:to_i) }
  end

  def max_plot_point
    @plot_points.flatten.max
  end

  def map
    grid = Array.new(max_plot_point+1){Array.new(max_plot_point+1, 0)}
    score = 0
    # puts grid.map(&:join).join("\n")
    @plot_points.each do |line|
      if horizontal_line(line)
        y = line[0][1]
        x1 = line[0][0]
        x2 = line[1][0]
        line = [x1, x2].sort
        # puts "Horizontal line on #{y} from #{line[0]} to #{line[1]}"
        (line[0]..line[1]).each do |x_point|
          grid[y][x_point] += 1
        end
      elsif vertical_line(line)
        x = line[0][0]
        y1 = line[0][1]
        y2 = line[1][1]
        line = [y1, y2].sort
        # puts "Vertical line on #{x} from #{y1} to #{y2}"
        (line[0]..line[1]).each do |y_point|
          grid[y_point][x] += 1
        end
      else
        diagonal(line).each do |x, y|
          # p "Next point = #{x},#{y}"
          grid[y][x] += 1
        end
      end
    end
    grid.map!{ |row| row.reject{ |point| point < 2 }}
    grid = grid.reject(&:empty?)
    p grid.map(&:size).sum
  end

  def diagonal(points)
    # Math.sqrt((@length.to_f ** 2) + (@width.to_f ** 2))
    sorted_points = points.sort_by(&:first)
    current_point = sorted_points[0]
    y = current_point[1]
    points = []
    (sorted_points[0][0]..sorted_points[1][0]).each do |x|
      points << [x, y]
      y = next_y(y, sorted_points[1][1])
      # p "Next point = #{x},#{y}"
    end
     points
  end

  def next_y(current_y, end_y)
    return current_y - 1 if current_y > end_y

    current_y + 1
  end

  def vertical_line(points)
    true if points[0][0] == points[1][0]
  end

  def horizontal_line(points)
    true if points[0][1] == points[1][1]
  end
end

hydrothermal_map = HydrothermalMap.new

File.foreach('input.txt', chomp: true) { |vent_line| hydrothermal_map.plot_vent(vent_line) }

hydrothermal_map.map
