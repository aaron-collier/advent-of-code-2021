# Test Input
#
# acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf
# So:
#   acedgfb: 8
#   cdfbe: 5
#   gcdfa: 2
#   fbcad: 3
#   dab: 7
#   cefabd: 9
#   cdfgeb: 6
#   eafb: 4
#   cagedb: 0
#   ab: 1
#
# Then, the four digits of the output value can be decoded:
#   cdfeb: 5
#   fcadb: 3
#   cdfeb: 5
#   cdbaf: 3

class Display
  UNIQUE_DIGITS = [2, 3, 4, 7].freeze

  def initialize
    @signals = []
    @digits = []
    @found_digits = 0
    @displays = []
  end

  def register_signal(input)
    (signals, digits) = input.split(' | ').map(&:split)
    signals = signals.map(&:chars).map(&:sort).map(&:join).sort_by(&:size)

    pos1 = signals[0]
    pos7 = signals[1]
    pos4 = signals[2]
    pos8 = signals.last

    two_three_five = signals[3..5]
    zero_six_nine = signals[6..8]

    pos0 = ''
    pos6 = ''
    pos9 = ''
    zero_six_nine.each do |signal|
      segment = pos8.gsub(/[#{signal}]/, '')
      if pos4.match?(/[#{segment}]/) && pos7.match?(/[#{segment}]/)
        pos6 = signal
      elsif pos4.match?(/[#{segment}]/)
        pos0 = signal
      else
        pos9 = signal
      end
    end

    pos5 = ''
    pos2 = ''
    pos3 = ''
    two_three_five.each do |signal|
      segment = pos9.gsub(/[#{signal}]/, '')
      if segment.size == 1
        if pos1.gsub(/[#{segment}]/, '') == pos1
          pos3 = signal
        else
          pos5 = signal
        end
      else
        pos2 = signal
      end
    end

    signal_wires = [pos0, pos1, pos2, pos3, pos4, pos5, pos6, pos7, pos8, pos9]
    display = digits.map(&:chars).map(&:sort).map(&:join).map { |digit| signal_wires.find_index(digit) }.join
    @displays << display
  end

  def score
    p @displays
    p @displays.map(&:to_i).sum
  end
end

display = Display.new
File.foreach('input.txt', chomp: true) { |line| 
  display.register_signal(line)
}
display.score
