class ExpenseReport
  def initialize()
    @charges = []
  end

  def record_charge(charge)
    @charges << charge
  end

  def score
    score = 0
    @charges.each do |charge|
      num_to_find = 2020 - charge
      score = charge * num_to_find if @charges.include?(num_to_find)
    end
    p score
  end
end

expense_report = ExpenseReport.new

File.foreach('input.txt', chomp: true) { |charge| 
  expense_report.record_charge(charge.to_i)
}

expense_report.score