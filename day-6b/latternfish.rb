class Latternfish
  def initialize(school)
    @school = {}
    9.times do |age|
      fish = school.split(',').map(&:to_i).tally[age]
      @school[age] = fish.nil? ? 0 : fish
    end
    p "School = #{@school}"
  end

  def count(days)
    days.times do |day|
      to_spawn = @school[0]
      (1..8).each do |age|
        @school[age-1] = @school[age]
      end

      @school[8] = to_spawn
      @school[6] += to_spawn
    end
    puts "Number of Latternfish = #{@school.to_a.transpose.last.sum}"
  end
end

File.foreach('input.txt', chomp: true) { |school| 
  latternfish = Latternfish.new(school)
  latternfish.count(ARGV[0].to_i)
}
