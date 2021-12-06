class Latternfish
  def initialize(school)
    @school = school.split(',').map(&:to_i)
  end

  def count(days)
    children = 0
    days.times.each do |day|
      @school.map!{ |age| age - 1 }
      next unless @school.tally[-1]

      @school.tally[-1].times { @school << 8 }
      @school.map!{ |age| age.negative? ? 6 : age }
      puts "After #{day} days: #{@school.size}"
    end
    puts "Number of Latternfish = #{@school.size}"
  end
end


File.foreach('input.txt', chomp: true) { |school| 
  latternfish = Latternfish.new(school)
  latternfish.count(ARGV[0].to_i)
}

