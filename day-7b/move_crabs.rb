# Test Input
# 16,1,2,0,4,2,7,1,2,14
# Correct Test Answer: position 2 costs 37 fuel
# Correct Answer (real input): 102245489
class Crab
  def initialize(crabs)
    @crabs = crabs
    @fuel_costs = {}
  end

  def score
    (@crabs.min..@crabs.max).each do |pos|
      @fuel_costs[pos] = @crabs.map { |crab| (((crab - pos).abs) * (((crab - pos).abs) + 1 )) / 2}.sum
    end
    p @fuel_costs.sort_by {|k, v| v}.first[1]
  end
end

File.foreach('input.txt', chomp: true) { |line| 
  crabs = Crab.new(line.split(',').map(&:to_i).sort)
  crabs.score
}
