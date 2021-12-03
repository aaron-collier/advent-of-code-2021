# frozen_string_literal: true

# Diagnositcs class to calculate day 3a power consumption:
# Correct: 845186
class Diagnositcs
  def initialize(input_file)
    @input_file = input_file
    @readings = Array.new(12)
  end

  def readings
    data = File.readlines(File.expand_path(@input_file, __dir__), chomp: true)
               .map(&:chars)

    (0..11).each do |i|
      @readings[i] = data.collect { |val| val[i] }.map(&:to_i).sum
    end

    @readings
  end

  # "000011011010" => 218
  def gamma_rate
    readings.map { |val| val < 500 ? '0' : '1' }.join
  end

  # "111100100101" => 3877
  def epsilon_rate
    readings.map { |val| val < 500 ? '1' : '0' }.join
  end

  # => 845186
  def power_consumption
    p gamma_rate.to_i(2) * epsilon_rate.to_i(2)
  end
end

diagnostics = Diagnositcs.new('input.txt')

p(diagnostics.power_consumption)
