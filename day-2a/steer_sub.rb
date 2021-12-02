# Correct Answer == 1604850
data = File.readlines(File.expand_path('input.txt', __dir__), chomp: true).map(&:split)

up = data.select{|dir, val| dir == 'up'}.collect(&:last).map(&:to_i).sum
down = data.select{|dir, val| dir == 'down'}.collect(&:last).map(&:to_i).sum
forward = data.select{|dir, val| dir == 'forward'}.collect(&:last).map(&:to_i).sum

p(
  (down - up) * forward
)
