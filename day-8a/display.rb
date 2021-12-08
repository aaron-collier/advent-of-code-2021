# Test Input
# be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
# edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
# fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
# fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
# aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
# fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
# dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
# bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
# egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
# gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
# ------
# Correct for test = 26
# Correct for input = 479

class Display
  UNIQUE_DIGITS = [2, 3, 4, 7].freeze

  def initialize
    @signals = []
    @digits = []
    @found_digits = 0
  end

  def register_signal(input)
    (signals, digits) = input.split(' | ').map(&:split)
    # p signals
    # p digits
    @found_digits += digits.map{ |digit| UNIQUE_DIGITS.include?(digit.length) ? 1 : 0 }.sum
  end

  def score
    p @found_digits
  end
end

display = Display.new
File.foreach('input.txt', chomp: true) { |line| 
  display.register_signal(line)
}
display.score
