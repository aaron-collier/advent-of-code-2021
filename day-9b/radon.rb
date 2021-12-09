grid = ARGF.readlines.map{|x| x.strip.chars.map(&:to_i)}

basin = Hash.new(0)

grid.each_with_index do |row, x_start|
  row.each_with_index do |cell, y_start|
    next if cell == 9

    nextp = [x_start, y_start]
    while nextp
      x, y = nextp
      nextp = [[1, 0], [0, 1], [-1, 0], [0, -1]]
        .map{|dx, dy| [x+dx, y+dy]}
        .filter{|nx, ny| nx.between?(0, grid.size-1) && ny.between?(0, grid[0].size-1)}
        .filter{|nx, ny| grid[nx][ny] < grid[x][y]}
        .first
    end

    basin[[x, y]] += 1
  end
end

puts "Part 1: #{basin.keys.map{|x, y| grid[x][y] + 1}.sum}"
puts "Part 2: #{basin.values.sort[-3..].reduce(:*)}"