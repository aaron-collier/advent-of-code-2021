# Test Input
#    1-3 a: abcde
#    1-3 b: cdefg
#    2-9 c: ccccccccc

class PasswordAnalyzer
  def initialize()
    @valid_count = 0
  end

  def register_policy(policy)
    policy_data = policy.match(/(\d+)-(\d+)\s([a-z]): ([a-z]*)/)
    min_count = policy_data[1].to_i
    max_count = policy_data[2].to_i
    required_character = policy_data[3]
    password = policy_data[4]
    @valid_count += 1 if password.count(required_character).between?(min_count, max_count)
    # p "Password = #{password}, #{required_character} occurs #{password.count(required_character)} => #{valid}"
  end

  def score
    p @valid_count
  end
end

password_analyzer = PasswordAnalyzer.new

File.foreach('input.txt', chomp: true) { |policy|
  password_analyzer.register_policy(policy)
}

password_analyzer.score