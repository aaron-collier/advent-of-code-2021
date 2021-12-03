# frozen_string_literal: true

# Navigator class to calculate day 2b position:
# Correct: 1685186100
class Navigator
  def initialize(input_file)
    @input_file = input_file
    @aim = 0
    @depth = 0
    @position = 0
    @forward = 0
  end

  def targets
    @targets ||= File.readlines(File.expand_path('input.txt', __dir__), chomp: true)
                     .map(&:split)
                     .chunk_while { |x, y| x.first != 'forward' }
                     .to_a
  end

  def aim(commands)
    @forward = commands.last.last.to_i
    aim_down(commands) - aim_up(commands)
  end

  def aim_up(commands)
    commands.select { |dir, _v| dir == 'up' }
            .collect(&:last)
            .map(&:to_i).sum
  end

  def aim_down(commands)
    commands.select { |dir, _v| dir == 'down' }
            .collect(&:last)
            .map(&:to_i).sum
  end

  def navigate(commands)
    @aim += aim(commands)
    @depth += @forward * @aim
    @position += @forward
  end

  def position
    targets.each do |commands|
      navigate(commands)
    end

    @position * @depth
  end
end

navigator = Navigator.new('input.txt')

p(navigator.position)
