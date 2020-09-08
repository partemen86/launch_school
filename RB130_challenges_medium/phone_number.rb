class PhoneNumber
  def initialize(str)
    @num = str
  end

  def number
    return '0000000000' unless valid?(@num)
    result = @num.gsub(/\D/, '')
    result.length >= 11 ? result[1..-1] : result
  end

  def valid?(str)
    str.match?(/^[1]?\d{3}[\s.-]?\d{3}[\s.-]?\d{4}$/) ||
    str.match?(/^\(\d{3}\)\s\d{3}-\d{4}$/)
  end

  def to_s
    "(#{area_code}) #{middle_three}-#{last_four}"
  end

  def area_code
    number[0,3]
  end

  private
  
  def middle_three
    number[3,3]
  end

  def last_four
    number[6,4]
  end
end
