class ExpenseReport
  def initialize()
    @charges = []
  end

  def record_charge(charge)
    @charges << charge
  end

  def score
    @charges.each do |charge|
      score = three_way_score(charge)
      next unless score.positive?

      p score
      break
    end
  end

  def three_way_score(charge_1)
    score = 0
    @charges.each do |charge_2|
      num_to_find = 2020 - charge_1 - charge_2
      score = charge_1 * charge_2 * num_to_find if @charges.include?(num_to_find)
    end
    score
  end
end

expense_report = ExpenseReport.new

File.foreach('input.txt', chomp: true) { |charge| 
  expense_report.record_charge(charge.to_i)
}

expense_report.score