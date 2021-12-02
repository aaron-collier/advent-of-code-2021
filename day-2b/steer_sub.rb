# correct answer = 1685186100

data = File.readlines(File.expand_path('input.txt', __dir__), chomp: true)
           .map(&:split)
           .chunk_while { |x, y| x.first != 'forward' }
           .to_a

depth = 0
position = 0
aim = 0

data.each do |inputs|
  up = inputs.select{|dir, val| dir == 'up'}.collect(&:last).map(&:to_i).sum
  down = inputs.select{|dir, val| dir == 'down'}.collect(&:last).map(&:to_i).sum
  forward = inputs.select{|dir, val| dir == 'forward'}.collect(&:last).map(&:to_i).sum
  aim += (down - up)
  depth += forward * aim
  position += forward
end

p position * depth
